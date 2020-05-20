# frozen_string_literal: true

require 'matrix'

module Tanks
  class ExperienceCoefficients
    include WotMath

    attr_reader :tank, :tank_coef, :tank_coef_name, :battle_results

    SAMPLES_AMOUNT = 100
    KILLED_AMOUNT_NORMALIZATION_COEFFICIENT = 1_000
    WIN_EXPERIENCE_COEFFICIENT = 1.5
    DB_COEFFICIENT = 1_000

    def initialize(tank:)
      @tank           = tank
      @tank_coef      = tank.type == 'spg' ? 6 : 3
      @tank_coef_name = tank.type == 'spg' ? :stun : :block
      @battle_results = valid_battle_results
    end

    def call
      coefficients = calc_coefficients

      update_tank_coefficients(coefficients)
    end

    private

    def valid_battle_results
      BattleResult
        .where(tank: tank)
        .where(medal: [2, 3])
        .where.not(experience: 0)
        .sample(SAMPLES_AMOUNT)
        .pluck(:killed_amount, :damage, :assist, :block, :experience, :win, :stun)
        .map do |elem|
          elem[0] *= KILLED_AMOUNT_NORMALIZATION_COEFFICIENT
          elem[4] /= WIN_EXPERIENCE_COEFFICIENT if elem[5]
          elem
        end
    end

    def calc_coefficients
      basis_determinant = basis_matrix.determinant
      {
        bonus:     change_column_in_basis_matrix(0) / basis_determinant,
        kill:      change_column_in_basis_matrix(1) / basis_determinant,
        damage:    change_column_in_basis_matrix(2) / basis_determinant,
        assist:    change_column_in_basis_matrix(3) / basis_determinant,
        tank_coef: change_column_in_basis_matrix(4) / basis_determinant
      }
    end

    def update_tank_coefficients(coefficients)
      tank_coefficients = Tanks::ExperienceCoefficient.find_or_initialize_by(tank_id: tank.id)
      precision = r_square(coefficients)
      params = coefficients.merge(precision: precision).each_with_object({}) do |(key, value), acc|
        key = tank_coef_name if key == :tank_coef
        acc[key] = (value * DB_COEFFICIENT).round
      end

      tank_coefficients.update(params)
    end

    def r_square(coefficients)
      1 - sum_squared_errors(coefficients) / total_sum_of_squares
    end

    # rubocop: disable Metrics/AbcSize
    def basis_matrix
      @basis_matrix ||= Matrix[
        [SAMPLES_AMOUNT, sum(0), sum(1), sum(2), sum(tank_coef)],
        [sum(0), double_sum(0, 0), double_sum(0, 1), double_sum(0, 2), double_sum(0, tank_coef)],
        [sum(1), double_sum(1, 0), double_sum(1, 1), double_sum(1, 2), double_sum(1, tank_coef)],
        [sum(2), double_sum(2, 0), double_sum(2, 1), double_sum(2, 2), double_sum(2, tank_coef)],
        [
          sum(tank_coef),
          double_sum(tank_coef, 0),
          double_sum(tank_coef, 1),
          double_sum(tank_coef, 2),
          double_sum(tank_coef, tank_coef)
        ]
      ]
    end
    # rubocop: enable Metrics/AbcSize

    def result_matrix
      @result_matrix ||= [
        sum(4), double_sum(0, 4), double_sum(1, 4), double_sum(2, 4), double_sum(tank_coef, 4)
      ]
    end

    def sum(index)
      battle_results.map { |elem| elem[index] }.sum
    end

    def double_sum(index1, index2)
      battle_results.map { |elem| elem[index1] * elem[index2] }.sum
    end

    def change_column_in_basis_matrix(column_index)
      array = basis_matrix.to_a.map.with_index do |row, index|
        row[column_index] = result_matrix[index]
        row
      end
      array_to_matrix(array).determinant * 1.0
    end

    def sum_squared_errors(coefficients)
      battle_results.inject(0) do |acc, result|
        acc + (result[4] - prediction(coefficients, result))**2
      end
    end

    # rubocop: disable Metrics/AbcSize
    def prediction(coefficients, result)
      coefficients[:bonus] +
        result[0] * coefficients[:kill] +
        result[1] * coefficients[:damage] +
        result[2] * coefficients[:assist] +
        result[tank_coef] * coefficients[:tank_coef]
    end
    # rubocop: enable Metrics/AbcSize

    def total_sum_of_squares
      mean_experience = mean(battle_results.map { |result| result[4] }.sum, SAMPLES_AMOUNT)
      battle_results.inject(0) do |acc, result|
        acc + (result[4] - mean_experience)**2
      end
    end
  end
end

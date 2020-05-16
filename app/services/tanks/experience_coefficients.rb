# frozen_string_literal: true

require 'matrix'

module Tanks
  class ExperienceCoefficients
    include WotMath

    attr_reader :tank, :battle_results

    SAMPLES_AMOUNT = 100
    KILLED_AMOUNT_NORMALIZATION_COEFFICIENT = 1_000
    WIN_EXPERIENCE_COEFFICIENT = 1.5
    DB_COEFFICIENT = 1_000

    def initialize(tank:)
      @tank           = tank
      @battle_results = valid_battle_results
    end

    def call
      coefficients = calc_coefficients

      r_square(coefficients)
      update_tank_coefficients(coefficients)
    end

    private

    def valid_battle_results
      BattleResult
        .where(tank: tank)
        .where(medal: [2, 3])
        .where.not(experience: 0)
        .sample(SAMPLES_AMOUNT)
        .pluck(:killed_amount, :damage, :assist, :block, :experience, :win)
        .map do |elem|
          elem[0] *= KILLED_AMOUNT_NORMALIZATION_COEFFICIENT
          elem[4] /= WIN_EXPERIENCE_COEFFICIENT if elem[5]
          elem
        end
    end

    def calc_coefficients
      basis_determinant = basis_matrix.determinant
      {
        bonus:  change_column_in_basis_matrix(0) / basis_determinant,
        kill:   change_column_in_basis_matrix(1) / basis_determinant,
        damage: change_column_in_basis_matrix(2) / basis_determinant,
        assist: change_column_in_basis_matrix(3) / basis_determinant,
        block:  change_column_in_basis_matrix(4) / basis_determinant
      }
    end

    def r_square(coefficients)
      1 - sum_squared_errors(coefficients) / total_sum_of_squares
    end

    def update_tank_coefficients(coefficients)
      tank_coefficients = Tanks::ExperienceCoefficient.find_or_initialize_by(tank_id: tank.id)
      tank_coefficients.update(
        coefficients.each do |key, value|
          coefficients[key] = (value * DB_COEFFICIENT).round
        end
      )
    end

    # rubocop: disable Metrics/AbcSize
    def basis_matrix
      @basis_matrix ||= Matrix[
        [SAMPLES_AMOUNT, sum(0), sum(1), sum(2), sum(3)],
        [sum(0), double_sum(0, 0), double_sum(0, 1), double_sum(0, 2), double_sum(0, 3)],
        [sum(1), double_sum(1, 0), double_sum(1, 1), double_sum(1, 2), double_sum(1, 3)],
        [sum(2), double_sum(2, 0), double_sum(2, 1), double_sum(2, 2), double_sum(2, 3)],
        [sum(3), double_sum(3, 0), double_sum(3, 1), double_sum(3, 2), double_sum(3, 3)]
      ]
    end
    # rubocop: enable Metrics/AbcSize

    def result_matrix
      @result_matrix ||= [
        sum(4), double_sum(0, 4), double_sum(1, 4), double_sum(2, 4), double_sum(3, 4)
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
        result[3] * coefficients[:block]
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

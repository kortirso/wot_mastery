# frozen_string_literal: true

require 'matrix'

class Experience
  include WotMath

  attr_reader :battle_results

  SAMPLES_AMOUNT = 100
  KILLED_AMOUNT_NORMALIZATION_KOEFFICIENT = 1_000
  WIN_EXPERIENCE_KOEFFICIENT = 1.5

  def initialize
    @battle_results = valid_battle_results
  end

  def call
    koefficients = calc_koefficients

    r_square(koefficients)
  end

  private

  def valid_battle_results
    BattleResult
      .where(medal: [2, 3])
      .where.not(experience: 0)
      .sample(SAMPLES_AMOUNT)
      .pluck(:killed_amount, :damage, :assist, :block, :experience, :win)
      .map do |elem|
        elem[0] *= KILLED_AMOUNT_NORMALIZATION_KOEFFICIENT
        elem[4] /= WIN_EXPERIENCE_KOEFFICIENT if elem[5]
        elem
      end
  end

  def calc_koefficients
    basis_determinant = basis_matrix.determinant
    {
      bonus:  change_column_in_basis_matrix(0) / basis_determinant,
      kill:   change_column_in_basis_matrix(1) / basis_determinant,
      damage: change_column_in_basis_matrix(2) / basis_determinant,
      assist: change_column_in_basis_matrix(3) / basis_determinant,
      block:  change_column_in_basis_matrix(4) / basis_determinant
    }
  end

  def r_square(koefficients)
    1 - sum_squared_errors(koefficients) / total_sum_of_squares
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

  def sum_squared_errors(koefficients)
    battle_results.inject(0) do |acc, result|
      acc + (result[4] - prediction(koefficients, result))**2
    end
  end

  # rubocop: disable Metrics/AbcSize
  def prediction(koefficients, result)
    koefficients[:bonus] +
      result[0] * koefficients[:kill] +
      result[1] * koefficients[:damage] +
      result[2] * koefficients[:assist] +
      result[3] * koefficients[:block]
  end
  # rubocop: enable Metrics/AbcSize

  def total_sum_of_squares
    mean_experience = mean(battle_results.map { |result| result[4] }.sum, SAMPLES_AMOUNT)
    battle_results.inject(0) do |acc, result|
      acc + (result[4] - mean_experience)**2
    end
  end
end

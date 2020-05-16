# frozen_string_literal: true

module Tanks
  class MasteryBorder
    include WotMath

    attr_reader :tank, :step, :elements_amount, :result

    STEPS = 10.0
    CLASS_A_RESULT = -1
    CLASS_B_RESULT = 1

    def initialize(tank:)
      @tank = tank
      @step = (master_grade_factors[-1] - first_grade_factors[0]) / STEPS
      @elements_amount = master_grade_factors.size + first_grade_factors.size
    end

    def call
      calc_mastery_boundary
      update_tank
    end

    private

    def calc_mastery_boundary
      (0..STEPS).each do |index|
        threshold = first_grade_factors[0] + step * index
        errors = threshold_errors_summary(first_grade_factors, threshold, CLASS_A_RESULT)
        errors += threshold_errors_summary(master_grade_factors, threshold, CLASS_B_RESULT)

        @result = check_result(threshold, errors)
      end
    end

    def update_tank
      tank.update(master_boundary: result.fetch(:threshold).round)
    end

    def first_grade_factors
      @first_grade_factors ||=
        tank.battle_results.where(medal: 'first_grade').order(experience: :asc).pluck(:experience).uniq.last(3)
    end

    def master_grade_factors
      @master_grade_factors ||=
        tank.battle_results.where(medal: 'master').order(experience: :asc).pluck(:experience).uniq.first(3)
    end

    def threshold_errors_summary(factors, threshold, class_result)
      factors.map { |factor|
        Math.log(1 + Math.exp(-class_result * (factor - threshold)))
      }.sum
    end

    def check_result(threshold, errors)
      return { threshold: threshold, value: mean(errors, elements_amount) } unless @result

      compare_results(threshold, errors)
    end

    def compare_results(threshold, errors)
      errors_mean = mean(errors, elements_amount)
      return result if result.fetch(:value) <= errors_mean

      { threshold: threshold, value: errors_mean }
    end
  end
end

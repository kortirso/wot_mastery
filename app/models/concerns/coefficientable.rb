# frozen_string_literal: true

# Represents combinateable
module Coefficientable
  extend ActiveSupport::Concern

  included do
    has_one :experience_coefficient,
            as:         :coefficientable,
            class_name: 'Tanks::ExperienceCoefficient',
            dependent:  :destroy
  end
end

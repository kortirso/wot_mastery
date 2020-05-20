# frozen_string_literal: true

module Tanks
  class ExperienceCoefficient < ApplicationRecord
    self.table_name = 'experience_coefficients'

    belongs_to :tank

    validates :bonus, :kill, :damage, :assist, :block, presence: true
    validates :bonus, numericality: { only_integer: true }
    validates :kill, numericality: { only_integer: true }
    validates :damage, numericality: { only_integer: true }
    validates :assist, numericality: { only_integer: true }
    validates :block, numericality: { only_integer: true }
  end
end

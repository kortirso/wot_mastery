# frozen_string_literal: true

module Tanks
  class ExperienceCoefficient < ApplicationRecord
    self.table_name = 'experience_coefficients'

    belongs_to :tank

    validates :bonus, :kill, :damage, :assist, :block, presence: true
    validates :bonus, numericality: { greater_than_or_equal_to: 0 }
    validates :kill, numericality: { greater_than_or_equal_to: 0 }
    validates :damage, numericality: { greater_than_or_equal_to: 0 }
    validates :assist, numericality: { greater_than_or_equal_to: 0 }
    validates :block, numericality: { greater_than_or_equal_to: 0 }
  end
end

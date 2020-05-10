# frozen_string_literal: true

class Tank < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :country

  enum type: { light: 0, medium: 1, heavy: 2, destroyer: 3, spg: 4 }

  validates :name, :type, :tier, presence: true
  validates :tier, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
end

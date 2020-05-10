# frozen_string_literal: true

class Tank < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :country

  has_many :battle_results, dependent: :destroy

  has_many :tank_externals, class_name: 'Tanks::External', dependent: :destroy
  has_one :wot_replays_external, -> { where(source: 0) }, class_name: 'Tanks::External', inverse_of: :tank

  enum type: { light: 0, medium: 1, heavy: 2, destroyer: 3, spg: 4 }

  validates :name, :type, :tier, presence: true
  validates :tier, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
end

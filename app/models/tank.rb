# frozen_string_literal: true

class Tank < ApplicationRecord
  include Coefficientable

  belongs_to :country
  belongs_to :tanks_type, class_name: 'Tanks::Type'

  has_many :battle_results, dependent: :destroy

  has_many :tank_externals, class_name: 'Tanks::External', dependent: :destroy
  has_one :wot_replays_external, -> { where(source: 0) }, class_name: 'Tanks::External', inverse_of: :tank

  validates :name, :tier, :health, :damage_per_shot, presence: true
  validates :tier, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :health, numericality: { greater_than_or_equal_to: 1 }
  validates :damage_per_shot, numericality: { greater_than_or_equal_to: 1 }
end

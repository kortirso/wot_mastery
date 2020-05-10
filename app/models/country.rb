# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :tanks, dependent: :destroy

  validates :name, presence: true
end

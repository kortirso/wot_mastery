# frozen_string_literal: true

module Tanks
  class Type < ApplicationRecord
    include Coefficientable

    self.table_name = 'tanks_types'

    TYPE_VALUES = [
      { 'en' => 'Light tanks', 'ru' => 'Лёгкие танки' },
      { 'en' => 'Medium tanks', 'ru' => 'Средние танки' },
      { 'en' => 'Heavy tanks', 'ru' => 'Тяжёлые танки' },
      { 'en' => 'Destroyers', 'ru' => 'ПТ-САУ' },
      { 'en' => 'SPGs', 'ru' => 'САУ' }
    ].freeze

    has_many :tanks, foreign_key: :tanks_type_id, inverse_of: :tanks_type, dependent: :destroy

    enum name: { light: 0, medium: 1, heavy: 2, destroyer: 3, spg: 4 }

    validates :name, presence: true
  end
end

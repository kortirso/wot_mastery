# frozen_string_literal: true

module Tanks
  class Type < ApplicationRecord
    self.table_name = 'tanks_types'

    has_many :tanks, foreign_key: :tanks_type_id, inverse_of: :tanks_type, dependent: :destroy

    enum name: { light: 0, medium: 1, heavy: 2, destroyer: 3, spg: 4 }

    validates :name, presence: true
  end
end

# frozen_string_literal: true

module Tanks
  class Type < ApplicationRecord
    include Coefficientable

    self.table_name = 'tanks_types'

    has_many :tanks, foreign_key: :tanks_type_id, inverse_of: :tanks_type, dependent: :destroy

    validates :name, presence: true
  end
end

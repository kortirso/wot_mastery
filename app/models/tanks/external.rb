# frozen_string_literal: true

module Tanks
  class External < ApplicationRecord
    include Sourceable

    self.table_name = 'tank_externals'

    belongs_to :tank

    validates :source, :external_id, presence: true
  end
end

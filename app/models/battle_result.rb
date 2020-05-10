# frozen_string_literal: true

class BattleResult < ApplicationRecord
  include Sourceable

  belongs_to :tank

  enum medal: { third_grade: 0, second_grade: 1, first_grade: 2, master: 3 }

  validates :experience, :damage, :assist, :block, :source, :external_id, presence: true
end

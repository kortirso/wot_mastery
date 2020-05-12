# frozen_string_literal: true

class BattleResult < ApplicationRecord
  include Sourceable

  WIN_TITLE = 'Победа'
  MASTER_GRADE = 'Мастер'
  FIRST_GRADE = '1 класс'
  SECOND_GRADE = '2 класс'
  THIRD_GRADE = '3 класс'

  belongs_to :tank

  enum medal: { third_grade: 0, second_grade: 1, first_grade: 2, master: 3 }

  validates :experience, :damage, :assist, :block, :killed_amount, :source, :external_id, presence: true
  validates :experience, numericality: { greater_than_or_equal_to: 0 }
  validates :damage, numericality: { greater_than_or_equal_to: 0 }
  validates :assist, numericality: { greater_than_or_equal_to: 0 }
  validates :block, numericality: { greater_than_or_equal_to: 0 }
  validates :killed_amount, numericality: { greater_than_or_equal_to: 0 }
end

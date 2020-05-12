# frozen_string_literal: true

RSpec.describe BattleResult, type: :model do
  it { is_expected.to belong_to :tank }
  it { is_expected.to validate_presence_of :experience }
  it { is_expected.to validate_presence_of :damage }
  it { is_expected.to validate_presence_of :assist }
  it { is_expected.to validate_presence_of :block }
  it { is_expected.to validate_presence_of :killed_amount }
  it { is_expected.to validate_presence_of :source }
  it { is_expected.to validate_presence_of :external_id }
  it { is_expected.to validate_numericality_of(:experience).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:damage).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:assist).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:block).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:killed_amount).is_greater_than_or_equal_to(0) }
end

# frozen_string_literal: true

RSpec.describe BattleResult, type: :model do
  it { is_expected.to belong_to :tank }
  it { is_expected.to validate_presence_of :experience }
  it { is_expected.to validate_presence_of :damage }
  it { is_expected.to validate_presence_of :assist }
  it { is_expected.to validate_presence_of :block }
  it { is_expected.to validate_presence_of :source }
  it { is_expected.to validate_presence_of :external_id }
end

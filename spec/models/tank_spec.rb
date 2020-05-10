# frozen_string_literal: true

RSpec.describe Tank, type: :model do
  it { is_expected.to belong_to :country }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :type }
  it { is_expected.to validate_presence_of :tier }
  it { is_expected.to validate_numericality_of(:tier).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10) }
end

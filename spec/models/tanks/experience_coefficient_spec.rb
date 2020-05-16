# frozen_string_literal: true

RSpec.describe Tanks::ExperienceCoefficient, type: :model do
  it { is_expected.to belong_to :tank }
  it { is_expected.to validate_presence_of :bonus }
  it { is_expected.to validate_presence_of :kill }
  it { is_expected.to validate_presence_of :damage }
  it { is_expected.to validate_presence_of :assist }
  it { is_expected.to validate_presence_of :block }
  it { is_expected.to validate_numericality_of(:bonus).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:kill).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:damage).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:assist).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:block).is_greater_than_or_equal_to(0) }
end

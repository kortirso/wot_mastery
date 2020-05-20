# frozen_string_literal: true

RSpec.describe Tanks::ExperienceCoefficient, type: :model do
  it { is_expected.to belong_to :tank }
  it { is_expected.to validate_presence_of :bonus }
  it { is_expected.to validate_presence_of :kill }
  it { is_expected.to validate_presence_of :damage }
  it { is_expected.to validate_presence_of :assist }
  it { is_expected.to validate_presence_of :block }
  it { is_expected.to validate_numericality_of(:bonus).only_integer }
  it { is_expected.to validate_numericality_of(:kill).only_integer }
  it { is_expected.to validate_numericality_of(:damage).only_integer }
  it { is_expected.to validate_numericality_of(:assist).only_integer }
  it { is_expected.to validate_numericality_of(:block).only_integer }
end

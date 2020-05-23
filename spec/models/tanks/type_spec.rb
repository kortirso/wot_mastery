# frozen_string_literal: true

RSpec.describe Tanks::Type, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many(:tanks).dependent(:destroy) }

  it {
    is_expected.to have_one(:experience_coefficient).class_name('Tanks::ExperienceCoefficient').dependent(:destroy)
  }
end

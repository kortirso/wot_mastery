# frozen_string_literal: true

RSpec.describe Tank, type: :model do
  it { is_expected.to belong_to :country }
  it { is_expected.to belong_to(:tanks_type).class_name('Tanks::Type') }
  it { is_expected.to have_many(:battle_results).dependent(:destroy) }
  it { is_expected.to have_many(:tank_externals).class_name('Tanks::External').dependent(:destroy) }
  it { is_expected.to have_one(:wot_replays_external).class_name('Tanks::External').inverse_of(:tank) }
  it { is_expected.to have_one(:experience_coefficient).class_name('Tanks::ExperienceCoefficient') }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :tier }
  it { is_expected.to validate_presence_of :health }
  it { is_expected.to validate_presence_of :damage_per_shot }
  it { is_expected.to validate_numericality_of(:tier).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10) }
  it { is_expected.to validate_numericality_of(:health).is_greater_than_or_equal_to(1) }
  it { is_expected.to validate_numericality_of(:damage_per_shot).is_greater_than_or_equal_to(1) }
end

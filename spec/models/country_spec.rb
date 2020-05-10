# frozen_string_literal: true

RSpec.describe Country, type: :model do
  it { is_expected.to have_many(:tanks).dependent(:destroy) }
  it { is_expected.to validate_presence_of :name }
end

# frozen_string_literal: true

RSpec.describe Tanks::External, type: :model do
  it { is_expected.to belong_to :tank }
  it { is_expected.to validate_presence_of :source }
  it { is_expected.to validate_presence_of :external_id }
end

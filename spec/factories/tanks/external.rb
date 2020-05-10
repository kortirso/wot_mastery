# frozen_string_literal: true

FactoryBot.define do
  factory :tank_external, class: 'Tanks::External' do
    source { 0 }
    external_id { '7777777' }
    association :tank
  end
end

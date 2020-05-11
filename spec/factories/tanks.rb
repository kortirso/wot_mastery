# frozen_string_literal: true

FactoryBot.define do
  factory :tank do
    name { { 'en' => 'IS-7', 'ru' => 'ИС-7' } }
    type { 3 }
    tier { 10 }
    health { 2_400 }
    damage_per_shot { 490 }
    association :country
  end
end

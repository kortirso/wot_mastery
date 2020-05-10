# frozen_string_literal: true

FactoryBot.define do
  factory :tank do
    name { { 'en' => 'IS-7', 'ru' => 'ИС-7' } }
    type { 3 }
    tier { 10 }
    association :country
  end
end

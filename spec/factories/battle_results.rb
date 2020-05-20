# frozen_string_literal: true

FactoryBot.define do
  factory :battle_result do
    experience { 1_000 }
    damage { 2_000 }
    assist { 1_000 }
    block { 2_000 }
    stun { 0 }
    medal { 2 }
    source { 0 }
    external_id { '7777777' }
    association :tank
  end
end

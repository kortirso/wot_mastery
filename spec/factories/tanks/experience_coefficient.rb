# frozen_string_literal: true

FactoryBot.define do
  factory :tank_experience_coefficient, class: 'Tanks::ExperienceCoefficient' do
    bonus { 9887 }
    kill { 22 }
    damage { 94 }
    assist { 60 }
    block { 26 }
    association :tank
  end
end

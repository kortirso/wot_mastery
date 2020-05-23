# frozen_string_literal: true

FactoryBot.define do
  factory :tanks_type, class: 'Tanks::Type' do
    name { 3 }
  end
end

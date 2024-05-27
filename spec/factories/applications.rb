# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    sequence(:name) { |n| "App#{n}" }

    trait :invalid do
      name { nil }
    end
  end
end

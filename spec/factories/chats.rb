# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    application

    trait :invalid do
      application { nil }
    end
  end
end

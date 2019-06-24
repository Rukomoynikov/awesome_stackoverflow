# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    text { 'Question body' }
    question
    author { create(:user) }

    trait :invalid do
      text { nil }
    end
  end
end

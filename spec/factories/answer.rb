# frozen_string_literal: true

FactoryBot.define do
  sequence :text do |n|
    "Answer number #{ n }"
  end

  factory :answer do
    text
    question
    author { create(:user) }

    trait :invalid do
      text { nil }
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { 'Question title' }
    text  { 'Question body' }

    trait :invalid do
      title { nil }
      text  { nil }
    end
  end
end

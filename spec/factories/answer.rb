# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    text { 'Question body' }
    question
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { 'Question title' }
    text  { 'Question body' }
  end
end

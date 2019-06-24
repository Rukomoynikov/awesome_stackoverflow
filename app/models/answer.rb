# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author,
             dependent: :delete,
             class_name: 'User',
             foreign_key: :user_id

  validates :text, :question, presence: true
end

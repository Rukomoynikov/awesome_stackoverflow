# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :delete_all
  belongs_to :author,
             dependent: :delete,
             class_name: 'User',
             foreign_key: :user_id

  validates :title, :text, presence: :true
end

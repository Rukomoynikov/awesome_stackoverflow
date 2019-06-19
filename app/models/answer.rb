class Answer < ApplicationRecord
  belongs_to :question

  validates :text, :question, presence: true
end

class Question < ApplicationRecord
  has_many :answers, dependent: :delete_all

  validates :title, :text, presence: :true
end

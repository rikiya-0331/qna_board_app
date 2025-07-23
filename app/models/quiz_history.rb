class QuizHistory < ApplicationRecord
  belongs_to :category
  has_many :quiz_results, dependent: :destroy
  belongs_to :user, optional: true
end

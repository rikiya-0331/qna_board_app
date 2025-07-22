class Question < ApplicationRecord
  belongs_to :category
  has_many :answer_choices, dependent: :destroy
  has_many :quiz_results, dependent: :destroy
end
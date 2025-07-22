class QuizHistory < ApplicationRecord
  belongs_to :category
  has_many :quiz_results, dependent: :destroy
  # belongs_to :user # ユーザー認証を導入する場合にコメントを解除
end

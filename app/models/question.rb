class Question < ApplicationRecord
  belongs_to :category
  has_many :answer_choices, dependent: :destroy
  has_many :quiz_results, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favoring_users, through: :favorites, source: :user

  # 特定のユーザーがこの質問をお気に入り登録しているか確認するヘルパーメソッド
  def favorited_by?(user)
    favoring_users.include?(user)
  end
end
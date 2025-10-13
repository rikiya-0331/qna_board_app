class Question < ApplicationRecord
  belongs_to :category
  has_many :answer_choices, dependent: :destroy
  accepts_nested_attributes_for :answer_choices, allow_destroy: true
  has_many :quiz_results, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favoring_users, through: :favorites, source: :user

  # 特定のユーザーがこの質問をお気に入り登録しているか確認するヘルパーメソッド
  def favorited_by?(user)
    favoring_users.include?(user)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["answer_en", "answer_jp", "category_id", "content", "created_at", "id", "id_value", "title_en", "title_jp", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "answer_choices"]
  end
end
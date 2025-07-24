class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # 同じユーザーが同じ質問を複数回お気に入り登録できないようにする
  validates :user_id, uniqueness: { scope: :question_id }
end
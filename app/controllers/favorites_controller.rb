class FavoritesController < ApplicationController
  before_action :authenticate_user! # ログインしていないユーザーは操作できないようにする
  before_action :set_question, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.new(question_id: @question.id)
    if favorite.save
      redirect_to root_path, notice: '質問をお気に入りに追加しました。'
    else
      # バリデーションエラー（例: 既に登録済み）の場合
      redirect_to root_path, alert: '質問のお気に入り登録に失敗しました。'
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(question_id: @question.id)
    if favorite
      favorite.destroy
      redirect_to root_path, notice: '質問のお気に入りを解除しました。'
    else
      redirect_to root_path, alert: 'お気に入りの解除に失敗しました。'
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
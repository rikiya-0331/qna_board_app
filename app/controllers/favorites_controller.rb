class FavoritesController < ApplicationController
  before_action :authenticate_user! # ログインしていないユーザーは操作できないようにする
  before_action :set_question, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.new(question_id: @question.id)
    if favorite.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: '質問をお気に入りに追加しました。' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: '質問のお気に入り登録に失敗しました。' }
        format.js
      end
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(question_id: @question.id)
    if favorite
      favorite.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: '質問のお気に入りを解除しました。' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'お気に入りの解除に失敗しました。' }
        format.js
      end
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
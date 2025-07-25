class QuizHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz_history, only: [:show]

  def show
    @quiz_results = @quiz_history.quiz_results.order(:id)
  end

  private

  def set_quiz_history
    @quiz_history = QuizHistory.find(params[:id])
    unless @quiz_history.user == current_user
      redirect_to mypage_path, alert: "アクセス権限がありません。"
    end
  end
end

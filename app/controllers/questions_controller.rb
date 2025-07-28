class QuestionsController < ApplicationController
  def index
    # includes(:questions) を使うことで、カテゴリとそれに関連する質問をまとめて取得
    @categories = Category.includes(:questions)
  end

  def show
    @question = Question.find(params[:id])
    # @question に紐づく正解の answer_choice も取得しておくとビューで扱いやすい
    # (schema.rb から questions テーブルに answer_jp/en があるため、直接それらを使用することも可能)
    @correct_answer_choice = @question.answer_choices.find_by(is_correct: true)
  end
end

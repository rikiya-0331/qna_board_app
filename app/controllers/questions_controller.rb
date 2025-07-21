class QuestionsController < ApplicationController
  def index
    # includes(:questions) を使うことで、カテゴリとそれに関連する質問をまとめて取得
    @categories = Category.includes(:questions)
  end
end

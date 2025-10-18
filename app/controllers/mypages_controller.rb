# frozen_string_literal: true

class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @quiz_histories = current_user.quiz_histories.order(created_at: :desc)
    @favorite_questions = current_user.favorite_questions.order(created_at: :desc)
  end
end

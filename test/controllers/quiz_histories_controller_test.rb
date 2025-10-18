# frozen_string_literal: true

require 'test_helper'

class QuizHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @quiz_history = quiz_histories(:one)
  end

  test 'should get show' do
    get quiz_history_url(@quiz_history)
    assert_response :success
  end
end

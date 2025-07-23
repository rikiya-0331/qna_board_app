require "test_helper"

class QuizHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get quiz_histories_show_url
    assert_response :success
  end
end

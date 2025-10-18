# frozen_string_literal: true

require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user

    # 既にお気に入り済みのデータ（destroyテスト用）
    @favorited_question = questions(:one)

    # まだお気に入りにしていないデータ（createテスト用）
    @unfavorited_question = questions(:two)
  end

  test 'should create favorite' do
    assert_difference('Favorite.count') do
      post question_favorites_url(@unfavorited_question)
    end

    assert_redirected_to root_path
  end

  test 'should destroy favorite' do
    assert_difference('Favorite.count', -1) do
      delete question_favorites_url(@favorited_question)
    end

    assert_redirected_to root_path
  end
end

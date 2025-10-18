# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'POST /questions/:question_id/favorites' do
    context 'as an authenticated user' do
      before do
        sign_in user
      end

      it 'adds the question to favorites' do
        expect do
          post question_favorites_path(question)
        end.to change(user.favorites, :count).by(1)
        puts "DEBUG: Status: #{response.status}, Body: #{response.body.truncate(500)}"
        expect(response).to redirect_to(root_path)
      end
    end

    context 'as a guest' do
      it 'redirects to the login page' do
        expect do
          post question_favorites_path(question)
        end.not_to change(Favorite, :count)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /questions/:question_id/favorites' do
    before do
      user.favorites.create(question: question)
    end

    context 'as an authenticated user' do
      before do
        sign_in user
      end

      it 'removes the question from favorites' do
        expect do
          delete question_favorites_path(question)
        end.to change(user.favorites, :count).by(-1)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'as a guest' do
      it 'does not remove the question from favorites and redirects' do
        expect do
          delete question_favorites_path(question)
        end.not_to change(Favorite, :count)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

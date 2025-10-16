require 'rails_helper'

RSpec.describe "QuizHistories", type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:user1_quiz_history) { create(:quiz_history, user: user1) }
  let!(:user2_quiz_history) { create(:quiz_history, user: user2) }

  describe "GET /quiz_histories/:id" do
    context "as an authenticated user" do
      before do
        sign_in user1
      end

      context "when accessing their own quiz history" do
        it "responds successfully" do
          get quiz_history_path(user1_quiz_history)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when accessing other user's quiz history" do
        it "redirects to the mypage" do
          get quiz_history_path(user2_quiz_history)
          expect(response).to redirect_to(mypage_path)
        end
      end
    end

    context "as a guest" do
      it "redirects to the login page" do
        get quiz_history_path(user1_quiz_history)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

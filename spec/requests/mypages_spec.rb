require 'rails_helper'

RSpec.describe "Mypages", type: :request do
  let(:user) { create(:user) }

  describe "GET /mypage" do
    context "when user is logged in" do
      before do
        sign_in user
      end

      it "returns a successful response" do
        get mypage_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is not logged in" do
      it "redirects to the login page" do
        get mypage_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

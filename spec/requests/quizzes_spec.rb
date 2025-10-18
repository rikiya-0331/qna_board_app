# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  describe 'GET /quizzes' do
    it 'responds successfully' do
      get quizzes_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /quiz/start' do
    it 'responds successfully' do
      get quiz_start_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /quizzes/:id/detail' do
    let!(:quiz) { create(:quiz) }

    it 'responds successfully' do
      get detail_quiz_path(quiz)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /quiz/start' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let!(:question) { create(:question, category: category) }

    before do
      sign_in user
    end

    it 'creates a new quiz history and redirects to the first question' do
      expect do
        post quiz_start_path, params: { category_id: category.id }
      end.to change(QuizHistory, :count).by(1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(quiz_question_path(question))
    end
  end

  describe 'GET /quiz/:id' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let!(:question) { create(:question, category: category) }

    context 'when quiz has been started' do
      before do
        sign_in user
        post quiz_start_path, params: { category_id: category.id }
      end

      it 'responds successfully' do
        get quiz_question_path(question)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when quiz has not been started' do
      it 'redirects to the quiz start page' do
        get quiz_question_path(question)
        expect(response).to redirect_to(quiz_start_path)
      end
    end
  end

  describe 'POST /quiz/:id/answer' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let!(:question1) { create(:question, category: category) }
    let!(:question2) { create(:question, category: category) }
    let!(:correct_answer) { create(:answer_choice, question: question1, is_correct: true) }
    let!(:incorrect_answer) { create(:answer_choice, question: question1, is_correct: false) }

    before do
      sign_in user
      post quiz_start_path, params: { category_id: category.id }
    end

    context 'with a correct answer' do
      it 'returns a correct response and URL for the next question' do
        expect do
          post quiz_answer_path(question1), params: { selected_answer_choice_id: correct_answer.id }
        end.to change(QuizResult, :count).by(1)

        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body
        expect(json_response['correct']).to be true
        expect(json_response['next_question_url']).to eq quiz_question_path(question2)
      end
    end

    context 'with an incorrect answer' do
      it 'returns an incorrect response' do
        post quiz_answer_path(question1), params: { selected_answer_choice_id: incorrect_answer.id }
        json_response = response.parsed_body
        expect(json_response['correct']).to be false
      end
    end

    context 'with the last question' do
      let!(:question2) { nil } # このコンテキストではquestion2は存在しない

      it 'returns a response with the results URL' do
        post quiz_answer_path(question1), params: { selected_answer_choice_id: correct_answer.id }
        json_response = response.parsed_body
        expect(json_response['results_url']).to eq quiz_results_path
      end
    end
  end

  describe 'GET /quiz/results' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let!(:question) { create(:question, category: category) }
    let!(:answer_choice) { create(:answer_choice, question: question, is_correct: true) }

    context 'when quiz is finished' do
      before do
        sign_in user
        post quiz_start_path, params: { category_id: category.id }
        post quiz_answer_path(question), params: { selected_answer_choice_id: answer_choice.id }
      end

      it 'responds successfully' do
        get quiz_results_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when quiz is not started' do
      it 'redirects to the quiz start page' do
        get quiz_results_path
        expect(response).to redirect_to(quiz_start_path)
      end
    end
  end
end

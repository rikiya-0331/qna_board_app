# frozen_string_literal: true

class QuizzesController < ApplicationController
  def index; end

  def start
    # クイズ開始ページでカテゴリを選択させる
    @categories = Category.all
  end

  def show
    @quiz_history = QuizHistory.find_by(id: session[:quiz_history_id])
    if @quiz_history.nil?
      redirect_to quiz_start_path, alert: 'クイズを開始してください。'
      return
    end

    @question = Question.find(params[:id])
    @answer_choices = @question.answer_choices
  end

  def create
    # 選択されたカテゴリを取得
    category = Category.find(params[:category_id])
    questions = Question.where(category: category)

    # クイズ履歴を作成
    quiz_history = QuizHistory.create!(
      category: category,
      total_questions: questions.count, # カテゴリの総問題数を設定
      score: 0,
      correct_answers: 0,
      user: current_user
    )
    session[:quiz_history_id] = quiz_history.id

    # カテゴリに紐づく最初の問題をランダムに取得してリダイレクト
    first_question = questions.in_random_order.first
    if first_question
      redirect_to quiz_question_path(first_question)
    else
      redirect_to root_path, alert: '選択されたカテゴリの問題が見つかりませんでした。'
    end
  end

  def answer
    quiz_history = QuizHistory.find(session[:quiz_history_id])
    question = Question.find(params[:id])
    selected_answer_choice = AnswerChoice.find(params[:selected_answer_choice_id])
    is_correct = selected_answer_choice.is_correct

    # 正解ならスコアと正解数を更新
    if is_correct
      quiz_history.increment!(:correct_answers)
      quiz_history.increment!(:score, 10) # 1問あたり10点
    end

    # QuizResultを保存
    QuizResult.create!(
      quiz_history: quiz_history,
      question: question,
      selected_answer_choice: selected_answer_choice,
      is_correct: is_correct
    )

    # 次の問題を探す
    answered_question_ids = quiz_history.quiz_results.pluck(:question_id)
    next_question = Question.where(category: quiz_history.category).where.not(id: answered_question_ids).in_random_order.first

    # 正解の選択肢のIDを取得
    correct_answer_choice = question.answer_choices.find_by(is_correct: true)
    correct_answer_id = correct_answer_choice.id if correct_answer_choice

    response_data = {
      correct: is_correct,
      correct_answer_id: correct_answer_id # ここを追加
    }

    if next_question
      response_data[:next_question_url] = quiz_question_path(next_question)
    else
      # クイズ終了
      response_data[:results_url] = quiz_results_path
    end

    render json: response_data
  end

  def detail
    @quiz = Quiz.find(params[:id])
  end

  def results
    @quiz_history = QuizHistory.find_by(id: session[:quiz_history_id])
    return unless @quiz_history.nil?

    redirect_to quiz_start_path, alert: 'クイズの履歴が見つかりません。'
    nil

    # session[:quiz_history_id] = nil # 結果表示後にセッションをクリアする場合
  end
end

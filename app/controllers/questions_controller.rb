# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])

    if params[:category_id]
      @category = Category.find(params[:category_id])
      @questions = @category.questions.ransack(params[:q]).result(distinct: true).includes(:category).page(params[:page])
    else
      @questions = @q.result(distinct: true).includes(:category).page(params[:page])
    end

    @categories = Category.all
  end

  def show
    @question = Question.find(params[:id])
    # @question に紐づく正解の answer_choice も取得しておくとビューで扱いやすい
    # (schema.rb から questions テーブルに answer_jp/en があるため、直接それらを使用することも可能)
    @correct_answer_choice = @question.answer_choices.find_by(is_correct: true)
  end

  def audio
    question = Question.find(params[:id])
    text_to_synthesize = question.answer_en

    # APIクライアントを初期化
    client = Google::Cloud::TextToSpeech.text_to_speech

    # 音声合成のリクエストを設定
    synthesis_input = { text: text_to_synthesize }
    voice = { language_code: 'en-US', name: 'en-US-Wavenet-F' } # 高品質なWaveNet音声を選択
    audio_config = { audio_encoding: 'MP3' }

    # APIを呼び出して音声データを取得
    response = client.synthesize_speech(
      input: synthesis_input,
      voice: voice,
      audio_config: audio_config
    )

    # 音声データ(MP3)をブラウザに送信
    send_data response.audio_content, type: 'audio/mpeg', disposition: 'inline'
  end

  def autocomplete
    # Stimulusコントローラーからのパラメータ名 'query' を使う
    @questions = Question.search_by_keyword(params[:query]).limit(10)

    # 強力なキャッシュ無効化
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate, private, max-age=0'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Thu, 01 Jan 1970 00:00:00 GMT'
    response.headers['Last-Modified'] = Time.current.httpdate
    response.headers.delete('ETag')

    # フロントエンドで必要なデータを返す
    json_data = @questions.map do |q|
      {
        id: q.id,
        title_jp: q.title_jp,
        title_en: q.title_en,
        timestamp: Time.current.to_f # キャッシュ回避用のタイムスタンプ
      }
    end

    render json: json_data
  end

  def test_cache
    expires_now
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    response.headers.delete('Etag')
    render json: {
      message: 'Test response',
      timestamp: Time.current.to_f,
      random: rand(1000)
    }
  end
end

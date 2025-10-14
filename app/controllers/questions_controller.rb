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
    voice = { language_code: "en-US", name: "en-US-Wavenet-F" } # 高品質なWaveNet音声を選択
    audio_config = { audio_encoding: "MP3" }

    # APIを呼び出して音声データを取得
    response = client.synthesize_speech(
      input: synthesis_input,
      voice: voice,
      audio_config: audio_config
    )

    # 音声データ(MP3)をブラウザに送信
    send_data response.audio_content, type: 'audio/mpeg', disposition: 'inline'
  end
end

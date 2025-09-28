require "google/cloud/text_to_speech"

# 環境変数からJSON認証情報を読み込む
if ENV['GOOGLE_APPLICATION_CREDENTIALS_JSON']
  begin
    credentials_json = JSON.parse(ENV['GOOGLE_APPLICATION_CREDENTIALS_JSON'])

    Google::Cloud::TextToSpeech.configure do |config|
      config.credentials = credentials_json
    end
  rescue JSON::ParserError => e
    Rails.logger.error "Failed to parse GOOGLE_APPLICATION_CREDENTIALS_JSON: #{e.message}"
  end
elsif Rails.env.production?
  # 本番環境で環境変数が設定されていない場合に警告
  Rails.logger.warn("GOOGLE_APPLICATION_CREDENTIALS_JSON is not set. Text-to-Speech API will not be available.")
end

require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # 以下の既存の action_mailer 設定をコメントアウト
  # Don't care if the mailer can't send.
  #config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  #config.action_mailer.raise_delivery_errors = true
  #config.action_mailer.delivery_method = :letter_opener_web

  #config.action_mailer.perform_caching = false

# Mailgunを使うためのSMTP設定を追加します
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.mailgun.org',  # RenderのMAILGUN_SMTP_SERVERと同じ値
  port:                 587,                 # RenderのMAILGUN_SMTP_PORTと同じ値
  authentication:       :plain,
  user_name:            'postmaster@sandboxf891c5b56944b6ca8e917fed592c9f4.mailgun.org', # RenderのMAILGUN_SMTP_LOGINと同じ値
  password:             '3kh9umufjora5',      # RenderのMAILGUN_SMTP_PASSWORDと同じ値
  domain:               'sandboxf891c5b56944b6ca8e917fed592c9f4.mailgun.org', # RenderのMAILGUN_DOMAINと同じ値
  enable_starttls_auto: true
}

# 開発環境でもメール送信エラーを発生させる (これは残しておくと良い)
config.action_mailer.raise_delivery_errors = true

# メーラーのキャッシュ設定も、SMTPテスト中はfalseのままでOKです。
# config.action_mailer.perform_caching = false # 元々コメントアウトされていなければ、この行はそのまま残してもOK

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Highlight code that enqueued background job in logs.
  config.active_job.verbose_enqueue_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Raise error when a before_action's only/except options reference missing actions
  config.action_controller.raise_on_missing_callback_actions = true
end

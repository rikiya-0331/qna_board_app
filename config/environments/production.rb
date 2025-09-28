require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "active_job/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"
require "sprockets/railtie" # Sprocketsを使用している場合

Rails.application.configure do
  # ... (既存のコメントや設定はそのまま残し、以下の項目を追加・修正) ...

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, improving performance.
  # It's also important to eager load modules to avoid threading issues in production.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in ENV["RAILS_MASTER_KEY"],
  # an environment variable or in config/master.key. This key is used to decrypt
  # credentials.
  config.require_master_key = true

  # Disable serving static files from the 'public' folder by default since
  # Apache or NGINX already handles this.
  # RenderではWebサーバーがアセットを配信するため、falseにするかコメントアウト
  config.public_file_server.enabled = true

  # Compress JavaScripts and CSS.
  # config.assets.js_compressor = :uglifier # もし利用している場合
  # config.assets.css_compressor = :sass # もし利用している場合 (または別のCSSコンプレッサー)

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false # Renderではプリコンパイル済みアセットを推奨

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "[http://assets.example.com](http://assets.example.com)"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Mount Action Cable outside main process or remove if not using Action Cable.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://[example.com/cable](https://example.com/cable)"
  # config.action_cable.allowed_request_origins = [ "[http://example.com](http://example.com)", /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # RenderでHTTPSを強制する場合、またはロードバランサーがHTTPSを処理する場合
  config.force_ssl = true

  # Use the lowest log level to ensure that no sensitive information is otherwise
  # logged in production.
  config.log_level = :debug # 開発時には :debug などにするが、本番では info か warn を推奨

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store
  # Render推奨のRedis (またはMemcached) キャッシュを使う場合
  # config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'], driver: :hiredis }

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "q_a_app_production"

  config.action_mailer.perform_caching = false
# 環境変数から読み込む元の形に戻す (これを使用)
# config.action_mailer.smtp_settings = {
#   address:              ENV.fetch('MAILGUN_SMTP_SERVER'),
#   port:                 ENV.fetch('MAILGUN_SMTP_PORT').to_i, # .to_i を忘れずに
#   authentication:       :plain,
#   user_name:            ENV.fetch('MAILGUN_SMTP_LOGIN'),
#   password:             ENV.fetch('MAILGUN_SMTP_PASSWORD'),
#   domain:               ENV.fetch('MAILGUN_DOMAIN'),
#   enable_starttls_auto: true
# }


  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for corresponding requests fall back to
  # the array of locales specified in config.i18n.fallbacks instead of raising an exception).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require "syslog/logger"
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new "app-name")

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Force `routes.default_url_options` to be set. If your app is called
  # "My Application" on Render, set this to:
  # config.action_mailer.default_url_options = { host: 'my-application.onrender.com' }
  # Rails.application.routes.default_url_options = { host: 'my-application.onrender.com' }
  # Replace 'my-application.onrender.com' with your actual Render URL or custom domain.
  if ENV['RAILS_ENV'] == 'production'
    config.action_mailer.default_url_options = { host: ENV['RENDER_EXTERNAL_HOSTNAME'], protocol: 'https' }
    Rails.application.routes.default_url_options = { host: ENV['RENDER_EXTERNAL_HOSTNAME'], protocol: 'https' }
  end

  # Add Secure Headers (セキュリティ対策として推奨)
  # gem 'secure_headers' をGemfileに追加している場合
  # config.web_console.whitelisted_ips = ENV['WEB_CONSOLE_WHITELISTED_IPS'].split(',').map(&:strip) if ENV['WEB_CONSOLE_WHITELISTED_IPS'].present?

end

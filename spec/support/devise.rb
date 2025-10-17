RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Debugging Devise authentication in request specs
  config.before(:each, type: :request) do
    puts "DEBUG: RSpec request spec before hook fired."
  end
end

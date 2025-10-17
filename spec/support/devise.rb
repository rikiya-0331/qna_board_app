RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Debugging Devise authentication in request specs
  config.before(:each, type: :request) do
    if defined?(request) && request.present?
      # Check if a user is already signed in before each request spec
      if controller.present? && controller.respond_to?(:current_user) && controller.current_user.present?
        puts "DEBUG: User #{controller.current_user.id} is already signed in before example."
      else
        puts "DEBUG: No user signed in before example."
      end
    end
  end
end
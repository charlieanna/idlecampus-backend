require_relative 'boot'

require 'rails/all'
require 'omniauth'
require 'omniauth-google-oauth2'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load .env file in development and test
if Rails.env.development? || Rails.env.test?
  require 'dotenv'
  Dotenv.load
end

module SOVisits
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.enabled = true
    config.action_mailer.delivery_method = :smtp
    
    # OmniAuth Google OAuth2
    config.middleware.use OmniAuth::Builder do
      provider :google_oauth2,
               ENV['GOOGLE_CLIENT_ID'],
               ENV['GOOGLE_CLIENT_SECRET'],
               {
                 scope: 'email, profile',
                 prompt: 'select_account',
                 image_aspect_ratio: 'square',
                 image_size: 50
               }
    end
  # SMTP settings for gmail
  config.action_mailer.smtp_settings = {
    :address => "smtp.mailgun.org",
    :port => 587,
    :user_name      => "postmaster@sandbox8a3089f7bc5a4d61b075ebe2454c749c.mailgun.org",
    :password       => "YOUR_MAILGUN_API_KEY",
    :domain         => 'sandbox8a3089f7bc5a4d61b075ebe2454c749c.mailgun.org',
    :authentication => :plain,
  }
  config.autoload_paths << Rails.root.join('app', 'services')
  end
end

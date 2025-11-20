require 'omniauth-google-oauth2'

OmniAuth.config.allowed_request_methods = [:get, :post]
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
OmniAuth.config.logger = Rails.logger

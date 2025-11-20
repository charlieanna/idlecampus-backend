class ApiService
  STACKEXCHANGE_API_BASE = "https://api.stackexchange.com"
  CLIENT_DETAILS = Rails.application.credentials.stack_overflow || {
    client_id: ENV['STACKEXCHANGE_CLIENT_ID'] || '12430',
    client_secret: ENV['STACKEXCHANGE_CLIENT_SECRET'] || 'mgihU2YppZJ8XzCUwyZT6A((',
    redirect_uri: ENV['STACKEXCHANGE_CALLBACK_URL'] || 'http://localhost:3000',
    key: ENV['STACKEXCHANGE_PUBLIC_KEY'] || '6)pzbLQnfOokuC2n)6Xviw(('
  }.freeze
  
  def self.post_request(url, data)
    uri = URI.parse(url)
    Net::HTTP.post_form(uri, data)
  end

  def self.api_get_request(endpoint)
    api = "#{STACKEXCHANGE_API_BASE}#{endpoint}&key=#{CLIENT_DETAILS[:key]}"
    uri = URI.parse(api)
    Net::HTTP.get(uri)
  end
end

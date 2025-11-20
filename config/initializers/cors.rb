# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Allow requests from common React development servers
    origins 'localhost:3000',           # Rails dev server (for testing)
            'localhost:3001',           # Create React App default
            'localhost:5173',           # Vite default
            'localhost:5174',           # Vite alternate
            'localhost:4173',           # Vite preview
            'http://localhost:3000',
            'http://localhost:3001',
            'http://localhost:5173',
            'http://localhost:5174',
            'http://localhost:4173'

    # In production, replace with your actual frontend domain:
    # origins 'https://your-react-app.com'

    resource '/api/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true,
      max_age: 86400  # Cache preflight requests for 24 hours
  end
end

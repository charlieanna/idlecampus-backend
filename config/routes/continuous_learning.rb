# Continuous Learning Routes - The ONLY learning interface
Rails.application.routes.draw do
  # Single learning endpoint - NO OTHER ROUTES
  get '/learn', to: 'continuous_learning#index', as: :learn
  post '/learn/respond', to: 'continuous_learning#respond', as: :learn_respond
  post '/learn/complete', to: 'continuous_learning#complete', as: :learn_complete
  
  # Remove/redirect old learning routes
  get '/interactive_learning', to: redirect('/learn')
  get '/interactive_learning/*path', to: redirect('/learn')
  get '/courses', to: redirect('/learn')
  get '/courses/*path', to: redirect('/learn')
  get '/start_learning', to: redirect('/learn')
  get '/guided_learning/*path', to: redirect('/learn')
  
  # Redirect any chapter/unit selection attempts
  get '/chapters', to: redirect('/learn')
  get '/units', to: redirect('/learn')
  get '/modules', to: redirect('/learn')
end
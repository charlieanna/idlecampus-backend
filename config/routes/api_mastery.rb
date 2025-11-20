Rails.application.routes.draw do
  namespace :api do
    namespace :mastery do
      get 'decay_visualization', to: 'mastery#decay_visualization'
      post 'request_stealth_review', to: 'mastery#request_stealth_review'
      get 'stealth_reviews', to: 'mastery#stealth_reviews'
      get 'decay_analysis/:canonical_command', to: 'mastery#decay_analysis'
      get 'commands_at_risk', to: 'mastery#commands_at_risk'
      post 'apply_decay_batch', to: 'mastery#apply_decay_batch'
    end
  end
end
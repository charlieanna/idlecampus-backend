# Add these routes to your config/routes.rb file

# Adaptive Learning Routes
namespace :api do
  namespace :v1 do
    # Adaptive Learning System
    scope module: :adaptive_learning, path: 'adaptive_learning' do
      # Core recommendations
      get 'next_problem', to: 'adaptive_learning#next_problem'
      post 'record_attempt', to: 'adaptive_learning#record_attempt'

      # Practice sets
      get 'daily_practice', to: 'adaptive_learning#daily_practice'
      get 'improvement_plan', to: 'adaptive_learning#improvement_plan'

      # Analysis
      get 'struggle_analysis', to: 'adaptive_learning#struggle_analysis'
      get 'stats', to: 'adaptive_learning#stats'

      # Learning path management
      get 'learning_path', to: 'adaptive_learning#learning_path'
      post 'set_learning_style', to: 'adaptive_learning#set_learning_style'

      # Problem-specific helpers
      get 'prerequisites/:problem_slug', to: 'adaptive_learning#prerequisites'
      get 'similar_problems/:problem_slug', to: 'adaptive_learning#similar_problems'
    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    scope :mastery do
      get 'stats', to: 'mastery#stats'
      post 'record_attempt', to: 'mastery#record_attempt'
      get 'remedial_gate/:unit_slug', to: 'mastery#remedial_gate'
      post 'remedial_drill', to: 'mastery#create_remedial_drill'
      post 'complete_remedial', to: 'mastery#complete_remedial_drill'
      get 'review_needed', to: 'mastery#review_needed'
      get 'command/:canonical_command', to: 'mastery#command_details'
      get 'leaderboard', to: 'mastery#leaderboard'
    end
  end
end
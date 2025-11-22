# frozen_string_literal: true

# Progressive Flow API Routes
# Include this file in your main config/routes.rb with:
# Rails.application.routes.draw do
#   # ... other routes ...
#   eval(File.read(Rails.root.join('config', 'routes_progressive_flow.rb')))
# end

namespace :api do
  namespace :v1 do
    # Progressive Flow Routes
    scope :progressive do
      # Learning Tracks
      resources :progressive_tracks, only: [:index, :show], controller: 'progressive_challenges' do
        member do
          get :challenges
        end
      end

      # Challenges
      resources :progressive_challenges, only: [:index, :show], path: 'challenges' do
        member do
          get :unlock_status, action: :check_unlock
          post 'levels/:level_number/complete', action: :complete_level
          get :progress
        end
      end

      # User Progress & Stats
      scope :user, controller: 'progressive_users' do
        get :progress
        get :stats
        get :level
        get :streak
        post :award_xp
        get :rank
        
        # Achievements
        get 'achievements', action: :achievements
        get 'achievements/unlocked', action: :achievements_unlocked
        
        # Skills
        get 'skills', action: :skills
        get 'skills/tree', action: :skill_tree
        get 'skills/top', action: :top_skills
        
        # Assessment
        post 'assessment/save', action: :save_assessment
      end

      # Leaderboards
      scope :leaderboard, controller: 'progressive_leaderboards' do
        get 'global', action: :global
        get 'friends', action: :friends
        get 'challenge/:challenge_id', action: :challenge
      end

      # Achievements (separate from user achievements)
      resources :progressive_achievements, only: [:index], path: 'achievements' do
        collection do
          get :unlocked
          post :check
        end
      end

      # Daily Challenges
      resources :progressive_daily_challenges, only: [:index], path: 'daily-challenges' do
        collection do
          get :history
        end
        member do
          post :complete
        end
      end

      # Notifications
      resources :progressive_notifications, only: [:index], path: 'notifications' do
        collection do
          get :unread
          post :mark_all_read
        end
        member do
          post :mark_read
        end
      end
    end
  end
end
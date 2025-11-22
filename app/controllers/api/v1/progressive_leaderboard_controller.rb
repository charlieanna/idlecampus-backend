module Api
  module V1
    class ProgressiveLeaderboardController < ProgressiveFlowController
      skip_before_action :set_user, only: [:index, :daily_challenge]
      
      # GET /api/v1/progressive/leaderboard
      def index
        period = params[:period] || 'all'
        limit = params[:limit]&.to_i || 100
        
        service = ProgressiveLeaderboardService.new
        leaderboard = service.get_leaderboard(period, limit)
        
        render_success(leaderboard)
      rescue => e
        render_error(e.message)
      end
      
      # GET /api/v1/progressive/daily_challenge
      def daily_challenge
        service = ProgressiveDailyChallengeService.new
        challenge = service.get_todays_challenge
        
        if challenge
          render_success(challenge)
        else
          render_error('No daily challenge available', :not_found)
        end
      rescue => e
        render_error(e.message)
      end
      
      # GET /api/v1/progressive/achievements
      def achievements
        achievements = ProgressiveAchievement.active.map do |achievement|
          {
            id: achievement.id,
            slug: achievement.slug,
            name: achievement.name,
            description: achievement.description,
            iconUrl: achievement.icon_url,
            category: achievement.category,
            rarity: achievement.rarity,
            xpReward: achievement.xp_reward
          }
        end
        
        render_success(achievements)
      end
    end
  end
end
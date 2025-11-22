# frozen_string_literal: true

module Api
  module V1
    class ProgressiveLeaderboardsController < ProgressiveFlowController
      # GET /api/v1/progressive/leaderboard/global
      # Returns global leaderboard with top users by XP
      def global
        period = params[:period] || 'all_time' # all_time, monthly, weekly
        limit = (params[:limit] || 100).to_i

        stats = case period
                when 'weekly'
                  ProgressiveUserStat.where('last_activity_at >= ?', 1.week.ago)
                when 'monthly'
                  ProgressiveUserStat.where('last_activity_at >= ?', 1.month.ago)
                else
                  ProgressiveUserStat.all
                end

        leaderboard = stats
                        .includes(:user)
                        .order(total_xp: :desc, level: :desc)
                        .limit(limit)
                        .map.with_index(1) do |stat, rank|
          {
            rank: rank,
            user_id: stat.user_id,
            username: stat.user.email.split('@').first, # Or use a username field if available
            total_xp: stat.total_xp,
            level: stat.level,
            challenges_completed: stat.challenges_completed,
            current_streak: stat.current_streak,
            rank_name: stat.rank_name
          }
        end

        # Find current user's rank if authenticated
        current_user_rank = if current_user
                              stats.where('total_xp > ?', current_user.progressive_user_stat&.total_xp || 0).count + 1
                            end

        render_success({
                         leaderboard: leaderboard,
                         period: period,
                         total_users: stats.count,
                         current_user_rank: current_user_rank
                       })
      end

      # GET /api/v1/progressive/leaderboard/friends
      # Returns leaderboard of user's friends
      def friends
        # Assuming a friends association exists on User model
        friend_ids = current_user.friend_ids # Adjust based on your friendship model

        leaderboard = ProgressiveUserStat
                        .where(user_id: [current_user.id] + friend_ids)
                        .includes(:user)
                        .order(total_xp: :desc)
                        .map.with_index(1) do |stat, rank|
          {
            rank: rank,
            user_id: stat.user_id,
            username: stat.user.email.split('@').first,
            total_xp: stat.total_xp,
            level: stat.level,
            challenges_completed: stat.challenges_completed,
            is_current_user: stat.user_id == current_user.id
          }
        end

        render_success({ leaderboard: leaderboard })
      end

      # GET /api/v1/progressive/leaderboard/challenge/:challenge_id
      # Returns leaderboard for a specific challenge
      def challenge
        challenge = ProgressiveChallenge.find(params[:challenge_id])
        
        leaderboard = ProgressiveUserChallengeProgress
                        .where(challenge_id: challenge.id, status: 'completed')
                        .includes(:user)
                        .order(total_xp_earned: :desc, completed_at: :asc)
                        .limit(100)
                        .map.with_index(1) do |progress, rank|
          {
            rank: rank,
            user_id: progress.user_id,
            username: progress.user.email.split('@').first,
            total_xp_earned: progress.total_xp_earned,
            levels_completed: progress.levels_completed.length,
            completion_time: progress.completed_at,
            best_level: progress.highest_level_completed
          }
        end

        render_success({
                         challenge: {
                           id: challenge.id,
                           title: challenge.title,
                           slug: challenge.slug
                         },
                         leaderboard: leaderboard
                       })
      end
    end
  end
end
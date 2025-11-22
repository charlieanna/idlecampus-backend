# frozen_string_literal: true

# Service for managing leaderboards
class ProgressiveLeaderboardService
  class << self
    # Get global leaderboard
    def global_leaderboard(period: 'all_time', limit: 100, user: nil)
      stats = filter_by_period(ProgressiveUserStat.all, period)

      leaderboard = stats
                      .includes(:user)
                      .order(total_xp: :desc, level: :desc, challenges_completed: :desc)
                      .limit(limit)
                      .map.with_index(1) do |stat, rank|
        format_leaderboard_entry(stat, rank)
      end

      result = {
        leaderboard: leaderboard,
        period: period,
        total_users: stats.count
      }

      # Add current user's rank if provided
      if user
        user_stat = user.progressive_user_stat
        if user_stat
          user_rank = stats.where('total_xp > ? OR (total_xp = ? AND level > ?)', 
                                   user_stat.total_xp, user_stat.total_xp, user_stat.level).count + 1
          result[:current_user] = {
            rank: user_rank,
            stats: format_leaderboard_entry(user_stat, user_rank)
          }
        end
      end

      result
    end

    # Get challenge-specific leaderboard
    def challenge_leaderboard(challenge_id, limit: 100)
      progresses = ProgressiveUserChallengeProgress
                     .where(challenge_id: challenge_id, status: 'completed')
                     .includes(:user)
                     .order(total_xp_earned: :desc, completed_at: :asc)
                     .limit(limit)

      progresses.map.with_index(1) do |progress, rank|
        {
          rank: rank,
          user_id: progress.user_id,
          username: progress.user.email.split('@').first,
          total_xp_earned: progress.total_xp_earned,
          levels_completed: progress.levels_completed.length,
          highest_level: progress.highest_level_completed,
          completed_at: progress.completed_at,
          time_to_complete: calculate_completion_time(progress)
        }
      end
    end

    # Get friends leaderboard
    def friends_leaderboard(user)
      friend_ids = user.friend_ids rescue [] # Assuming friends association
      all_user_ids = [user.id] + friend_ids

      stats = ProgressiveUserStat
                .where(user_id: all_user_ids)
                .includes(:user)
                .order(total_xp: :desc, level: :desc)

      stats.map.with_index(1) do |stat, rank|
        entry = format_leaderboard_entry(stat, rank)
        entry[:is_current_user] = (stat.user_id == user.id)
        entry
      end
    end

    # Get track-specific leaderboard
    def track_leaderboard(track_id, limit: 100)
      challenge_ids = ProgressiveChallenge.where(track_id: track_id).pluck(:id)

      # Count completed challenges per user in this track
      user_counts = ProgressiveUserChallengeProgress
                      .where(challenge_id: challenge_ids, status: 'completed')
                      .group(:user_id)
                      .select('user_id, COUNT(*) as completed_count, SUM(total_xp_earned) as total_track_xp')
                      .order('completed_count DESC, total_track_xp DESC')
                      .limit(limit)

      user_counts.map.with_index(1) do |uc, rank|
        user = User.find(uc.user_id)
        {
          rank: rank,
          user_id: uc.user_id,
          username: user.email.split('@').first,
          challenges_completed: uc.completed_count,
          total_xp: uc.total_track_xp,
          completion_percentage: (uc.completed_count.to_f / challenge_ids.length * 100).round(1)
        }
      end
    end

    private

    def filter_by_period(scope, period)
      case period
      when 'weekly'
        scope.where('last_activity_at >= ?', 1.week.ago)
      when 'monthly'
        scope.where('last_activity_at >= ?', 1.month.ago)
      when 'yearly'
        scope.where('last_activity_at >= ?', 1.year.ago)
      else # 'all_time'
        scope
      end
    end

    def format_leaderboard_entry(stat, rank)
      {
        rank: rank,
        user_id: stat.user_id,
        username: stat.user.email.split('@').first,
        total_xp: stat.total_xp,
        level: stat.level,
        challenges_completed: stat.challenges_completed,
        current_streak: stat.current_streak,
        longest_streak: stat.longest_streak,
        rank_name: stat.rank_name
      }
    end

    def calculate_completion_time(progress)
      first_attempt = ProgressiveLevelAttempt
                        .where(user_id: progress.user_id, challenge_id: progress.challenge_id)
                        .order(:created_at)
                        .first

      return nil unless first_attempt && progress.completed_at

      (progress.completed_at - first_attempt.created_at).to_i # in seconds
    end
  end
end
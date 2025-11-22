# frozen_string_literal: true

# Service for checking and awarding achievements
class ProgressiveAchievementService
  class << self
    # Check all achievements for a user
    def check_all_achievements(user)
      achievements = ProgressiveAchievement.all
      newly_unlocked = []

      achievements.each do |achievement|
        next if user.progressive_user_achievements.exists?(achievement_id: achievement.id)

        if achievement_unlocked?(user, achievement)
          unlock_achievement(user, achievement)
          newly_unlocked << achievement
        end
      end

      newly_unlocked
    end

    # Check if a specific achievement is unlocked
    def achievement_unlocked?(user, achievement)
      case achievement.category
      when 'challenges'
        check_challenge_achievement(user, achievement)
      when 'streak'
        check_streak_achievement(user, achievement)
      when 'xp'
        check_xp_achievement(user, achievement)
      when 'mastery'
        check_mastery_achievement(user, achievement)
      when 'speed'
        check_speed_achievement(user, achievement)
      when 'perfect'
        check_perfect_achievement(user, achievement)
      else
        false
      end
    end

    # Unlock an achievement for a user
    def unlock_achievement(user, achievement)
      ActiveRecord::Base.transaction do
        # Create user achievement record
        user_achievement = ProgressiveUserAchievement.create!(
          user: user,
          achievement: achievement,
          unlocked_at: Time.current
        )

        # Award XP
        ProgressiveXpService.award_xp(
          user,
          achievement.xp_reward,
          'achievement',
          { achievement_id: achievement.id }
        )

        # Create notification
        ProgressiveNotification.create!(
          user: user,
          notification_type: 'achievement_unlocked',
          title: "Achievement Unlocked!",
          message: achievement.title,
          data: {
            achievement_id: achievement.id,
            xp_reward: achievement.xp_reward
          },
          read: false
        )

        user_achievement
      end
    end

    # Check achievements after completing a level
    def check_after_level_completion(user, challenge, level_number)
      check_all_achievements(user)
    end

    # Check level-based achievements
    def check_level_achievements(user, level)
      level_achievements = ProgressiveAchievement.where(category: 'xp')
      
      level_achievements.each do |achievement|
        next if user.progressive_user_achievements.exists?(achievement_id: achievement.id)
        
        required_level = achievement.criteria['level_required']
        unlock_achievement(user, achievement) if required_level && level >= required_level
      end
    end

    private

    # Check challenge-based achievements
    def check_challenge_achievement(user, achievement)
      criteria = achievement.criteria
      
      if criteria['challenges_required']
        completed = user.progressive_user_challenge_progresses.where(status: 'completed').count
        return completed >= criteria['challenges_required']
      end

      if criteria['track_id']
        track_challenges = ProgressiveChallenge.where(track_id: criteria['track_id']).pluck(:id)
        completed = user.progressive_user_challenge_progresses
                        .where(challenge_id: track_challenges, status: 'completed')
                        .count
        return completed >= (criteria['track_completion'] || track_challenges.length)
      end

      false
    end

    # Check streak-based achievements
    def check_streak_achievement(user, achievement)
      criteria = achievement.criteria
      current_streak = user.progressive_user_stat&.current_streak || 0
      
      criteria['streak_days'] && current_streak >= criteria['streak_days']
    end

    # Check XP-based achievements
    def check_xp_achievement(user, achievement)
      criteria = achievement.criteria
      total_xp = user.progressive_user_stat&.total_xp || 0
      
      criteria['xp_required'] && total_xp >= criteria['xp_required']
    end

    # Check mastery-based achievements (completing all 5 levels)
    def check_mastery_achievement(user, achievement)
      criteria = achievement.criteria
      
      mastered_count = user.progressive_user_challenge_progresses
                           .where(status: 'completed')
                           .where('array_length(levels_completed, 1) >= 5')
                           .count
      
      criteria['mastery_count'] && mastered_count >= criteria['mastery_count']
    end

    # Check speed-based achievements
    def check_speed_achievement(user, achievement)
      criteria = achievement.criteria
      
      if criteria['challenge_id'] && criteria['max_time']
        progress = user.progressive_user_challenge_progresses
                       .find_by(challenge_id: criteria['challenge_id'], status: 'completed')
        
        return false unless progress
        
        total_time = ProgressiveLevelAttempt
                       .where(user_id: user.id, challenge_id: criteria['challenge_id'], status: 'passed')
                       .sum(:time_spent)
        
        return total_time <= criteria['max_time']
      end

      false
    end

    # Check perfect score achievements
    def check_perfect_achievement(user, achievement)
      criteria = achievement.criteria
      
      if criteria['perfect_levels']
        perfect_count = ProgressiveLevelAttempt
                          .where(user_id: user.id, status: 'passed')
                          .where('test_results @> ?', { all_passed: true }.to_json)
                          .distinct
                          .count(:challenge_id)
        
        return perfect_count >= criteria['perfect_levels']
      end

      false
    end
  end
end
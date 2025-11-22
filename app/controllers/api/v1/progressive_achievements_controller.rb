# frozen_string_literal: true

module Api
  module V1
    class ProgressiveAchievementsController < ProgressiveFlowController
      # GET /api/v1/progressive/achievements
      # Returns all available achievements with user's unlock status
      def index
        achievements = ProgressiveAchievement.all.order(:category, :tier)
        user_achievement_ids = current_user.progressive_user_achievements.pluck(:achievement_id)

        achievements_data = achievements.map do |achievement|
          {
            id: achievement.id,
            title: achievement.title,
            description: achievement.description,
            category: achievement.category,
            tier: achievement.tier,
            icon: achievement.icon,
            xp_reward: achievement.xp_reward,
            criteria: achievement.criteria,
            unlocked: user_achievement_ids.include?(achievement.id),
            progress: calculate_achievement_progress(achievement)
          }
        end

        # Group by category
        grouped = achievements_data.group_by { |a| a[:category] }

        render_success({
                         achievements: achievements_data,
                         by_category: grouped,
                         total_unlocked: user_achievement_ids.length,
                         total_available: achievements.count
                       })
      end

      # GET /api/v1/progressive/achievements/unlocked
      # Returns user's unlocked achievements
      def unlocked
        user_achievements = current_user.progressive_user_achievements
                                        .includes(:achievement)
                                        .order(unlocked_at: :desc)

        achievements_data = user_achievements.map do |ua|
          {
            id: ua.achievement.id,
            title: ua.achievement.title,
            description: ua.achievement.description,
            category: ua.achievement.category,
            tier: ua.achievement.tier,
            icon: ua.achievement.icon,
            xp_reward: ua.achievement.xp_reward,
            unlocked_at: ua.unlocked_at
          }
        end

        render_success({
                         achievements: achievements_data,
                         total_xp_from_achievements: user_achievements.sum { |ua| ua.achievement.xp_reward }
                       })
      end

      # POST /api/v1/progressive/achievements/check
      # Manually trigger achievement check (usually done automatically)
      def check
        ProgressiveAchievementService.check_all_achievements(current_user)
        
        render_success({ message: 'Achievement check completed' })
      end

      private

      def calculate_achievement_progress(achievement)
        # Calculate progress based on achievement criteria
        # This is a simplified version - actual implementation depends on criteria structure
        case achievement.category
        when 'challenges'
          completed = current_user.progressive_user_challenge_progresses.where(status: 'completed').count
          required = achievement.criteria['challenges_required'] || 0
          { current: completed, required: required, percentage: (completed.to_f / required * 100).round }
        when 'streak'
          current_streak = current_user.progressive_user_stat&.current_streak || 0
          required = achievement.criteria['streak_days'] || 0
          { current: current_streak, required: required, percentage: (current_streak.to_f / required * 100).round }
        when 'xp'
          current_xp = current_user.progressive_user_stat&.total_xp || 0
          required = achievement.criteria['xp_required'] || 0
          { current: current_xp, required: required, percentage: (current_xp.to_f / required * 100).round }
        when 'mastery'
          mastered = current_user.progressive_user_challenge_progresses
                                 .where(status: 'completed')
                                 .where('array_length(levels_completed, 1) >= 5')
                                 .count
          required = achievement.criteria['mastery_count'] || 0
          { current: mastered, required: required, percentage: (mastered.to_f / required * 100).round }
        else
          { current: 0, required: 1, percentage: 0 }
        end
      end
    end
  end
end
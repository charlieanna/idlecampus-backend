module Api
  module V1
    class ProgressiveUsersController < ProgressiveFlowController
      
      # GET /api/v1/progressive/users/:user_id/progress
      def progress
        progress_data = {
          userId: @user.id,
          stats: user_stats,
          challenges: user_challenges,
          achievements: user_achievements,
          skills: user_skills,
          streak: user_streak
        }
        
        render_success(progress_data)
      end
      
      # GET /api/v1/progressive/users/:user_id/level
      def level
        stat = @user.progressive_user_stat || @user.create_progressive_user_stat
        xp_progress = stat.xp_progress
        
        level_data = {
          currentLevel: stat.current_level,
          totalXP: stat.total_xp,
          xpForCurrentLevel: ProgressiveUserStat.xp_for_level(stat.current_level - 1),
          xpForNextLevel: ProgressiveUserStat.xp_for_level(stat.current_level),
          xpProgress: xp_progress[:xp_in_level],
          rank: stat.rank_name
        }
        
        render_success(level_data)
      end
      
      # GET /api/v1/progressive/users/:user_id/streak
      def streak
        stat = @user.progressive_user_stat || @user.create_progressive_user_stat
        
        streak_data = {
          currentStreak: stat.current_streak_days,
          longestStreak: stat.longest_streak_days,
          lastActivityDate: stat.last_activity_date,
          isActiveToday: stat.active_today?
        }
        
        render_success(streak_data)
      end
      
      # GET /api/v1/progressive/users/:user_id/achievements
      def achievements
        achievements = @user.progressive_user_achievements
                           .includes(:progressive_achievement)
                           .map do |ua|
          achievement = ua.progressive_achievement
          {
            id: achievement.id,
            slug: achievement.slug,
            name: achievement.name,
            description: achievement.description,
            iconUrl: achievement.icon_url,
            category: achievement.category,
            rarity: achievement.rarity,
            xpReward: achievement.xp_reward,
            unlockedAt: ua.unlocked_at,
            progress: ua.progress
          }
        end
        
        render_success(achievements)
      end
      
      # POST /api/v1/progressive/users/:user_id/check_achievements
      def check_achievements
        service = ProgressiveAchievementService.new(@user)
        unlocked = service.check_and_unlock!
        
        render_success({
          unlockedAchievements: unlocked,
          count: unlocked.length
        })
      end
      
      # GET /api/v1/progressive/users/:user_id/skills
      def skills
        skills = @user.progressive_user_skills
                     .includes(:progressive_skill)
                     .map do |us|
          skill = us.progressive_skill
          {
            skillId: skill.id,
            skillSlug: skill.slug,
            skillName: skill.name,
            currentLevel: us.current_level,
            pointsAllocated: us.points_allocated,
            maxLevel: skill.max_level,
            unlockedAt: us.unlocked_at,
            masteredAt: us.mastered_at
          }
        end
        
        render_success(skills)
      end
      
      # POST /api/v1/progressive/users/:user_id/allocate_skill_point
      def allocate_skill_point
        skill = ProgressiveSkill.find(params[:skill_id])
        service = ProgressiveSkillService.new(@user)
        
        result = service.allocate_point!(skill.id)
        render_success(result)
      rescue => e
        render_error(e.message)
      end
      
      # GET /api/v1/progressive/users/:user_id/skill_points
      def skill_points
        service = ProgressiveSkillService.new(@user)
        available = service.available_points
        
        render_success({ availablePoints: available })
      end
      
      # POST /api/v1/progressive/users/:user_id/award_xp
      def award_xp
        service = ProgressiveXpService.new(@user)
        result = service.award_xp!(
          params[:amount].to_i,
          params[:source],
          params[:metadata] || {}
        )
        
        render_success(result)
      rescue => e
        render_error(e.message)
      end
      
      # GET /api/v1/progressive/users/:user_id/rank
      def rank
        period = params[:period] || 'all'
        service = ProgressiveLeaderboardService.new
        rank_data = service.user_rank(@user.id, period)
        
        render_success(rank_data)
      end
      
      # POST /api/v1/progressive/users/:user_id/assessment
      def save_assessment
        service = ProgressiveAssessmentService.new(@user)
        result = service.save_assessment(
          params[:answers],
          params[:score].to_f
        )
        
        render_success(result)
      rescue => e
        render_error(e.message)
      end
      
      private
      
      def user_stats
        stat = @user.progressive_user_stat || @user.create_progressive_user_stat
        {
          totalXP: stat.total_xp,
          currentLevel: stat.current_level,
          totalChallengesStarted: stat.total_challenges_started,
          totalChallengesCompleted: stat.total_challenges_completed,
          totalLevelsCompleted: stat.total_levels_completed,
          totalTimeSpentMinutes: stat.total_time_spent_minutes,
          currentStreakDays: stat.current_streak_days,
          longestStreakDays: stat.longest_streak_days,
          lastActivityDate: stat.last_activity_date,
          rankPercentile: stat.rank_percentile
        }
      end
      
      def user_challenges
        @user.progressive_user_challenge_progresses
             .includes(:progressive_challenge)
             .map do |progress|
          challenge = progress.progressive_challenge
          {
            challengeId: challenge.id,
            challengeSlug: challenge.slug,
            challengeTitle: challenge.title,
            status: progress.status,
            currentLevel: progress.current_level,
            levelsCompleted: progress.levels_completed,
            totalAttempts: progress.total_attempts,
            totalTimeSpentMinutes: progress.total_time_spent_minutes,
            bestScore: progress.best_score,
            xpEarned: progress.xp_earned,
            startDate: progress.start_date,
            completionDate: progress.completion_date
          }
        end
      end
      
      def user_achievements
        all_achievements = ProgressiveAchievement.active
        unlocked = @user.progressive_user_achievements
                       .includes(:progressive_achievement)
                       .index_by(&:progressive_achievement_id)
        
        all_achievements.map do |achievement|
          ua = unlocked[achievement.id]
          {
            id: achievement.id,
            slug: achievement.slug,
            name: achievement.name,
            description: achievement.description,
            iconUrl: achievement.icon_url,
            category: achievement.category,
            rarity: achievement.rarity,
            xpReward: achievement.xp_reward,
            unlockedAt: ua&.unlocked_at,
            progress: ua&.progress || 0
          }
        end
      end
      
      def user_skills
        @user.progressive_user_skills
             .includes(:progressive_skill)
             .map do |us|
          skill = us.progressive_skill
          {
            skillId: skill.id,
            skillSlug: skill.slug,
            skillName: skill.name,
            currentLevel: us.current_level,
            pointsAllocated: us.points_allocated,
            maxLevel: skill.max_level,
            unlockedAt: us.unlocked_at,
            masteredAt: us.mastered_at
          }
        end
      end
      
      def user_streak
        stat = @user.progressive_user_stat || @user.create_progressive_user_stat
        {
          currentStreak: stat.current_streak_days,
          longestStreak: stat.longest_streak_days,
          lastActivityDate: stat.last_activity_date,
          isActiveToday: stat.active_today?
        }
      end
    end
  end
end
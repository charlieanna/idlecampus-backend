class AchievementsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # Get all achievements
    @achievements = CourseAchievement.all.order(:points_reward)
    
    # Get user's unlocked achievements
    @user_achievements = UserCourseAchievement
                          .where(user_id: current_user.id)
                          .includes(:course_achievement)
                          .order(unlocked_at: :desc)
    
    # Calculate completion percentage
    @completion_percentage = if @achievements.count > 0
                               (@user_achievements.count.to_f / @achievements.count * 100).round
                             else
                               0
                             end
    
    # Group achievements by category
    @achievements_by_category = @achievements.group_by(&:category)
    
    # Check for unlocked achievement IDs
    @unlocked_achievement_ids = @user_achievements.pluck(:course_achievement_id)
  end
  
  def check
    # Check all achievement criteria for current user
    achievements_unlocked = []
    
    CourseAchievement.all.each do |achievement|
      if achievement.check_criteria_for(current_user)
        # Achievement unlocked!
        user_achievement = UserCourseAchievement.find_or_create_by(
          user_id: current_user.id,
          course_achievement_id: achievement.id
        )
        
        if user_achievement.previously_new_record?
          achievements_unlocked << achievement
        end
      end
    end
    
    render json: {
      success: true,
      unlocked_count: achievements_unlocked.count,
      achievements: achievements_unlocked.map { |a| {
        id: a.id,
        title: a.title,
        description: a.description,
        icon: a.icon,
        points_reward: a.points_reward
      }}
    }
  end
end
class UserStat < ApplicationRecord
  # Associations
  belongs_to :user
  
  # Validations
  validates :user_id, uniqueness: true
  
  # Callbacks
  after_update :check_achievements, if: :saved_change_to_attribute_that_matters?
  
  # Instance methods
  def update_streak!
    today = Date.current
    return unless last_activity_at
    
    last_activity_date = last_activity_at.to_date
    
    if last_activity_date == today
      # Already counted today
      return
    elsif last_activity_date == today - 1.day
      # Consecutive day
      increment!(:current_streak_days)
      update_longest_streak
    elsif last_activity_date < today - 1.day
      # Streak broken
      update(current_streak_days: 1)
    end
    
    update(last_activity_at: Time.current)
  end
  
  def record_activity!(duration_minutes = 0)
    update_streak!
    increment!(:total_study_minutes, duration_minutes) if duration_minutes > 0
    touch(:last_activity_at)
  end
  
  def add_weak_area(topic, accuracy)
    current_weak_areas = weak_areas.is_a?(Array) ? weak_areas : []
    
    # Remove existing entry for this topic
    current_weak_areas.reject! { |area| area['topic'] == topic }
    
    # Add new entry if accuracy is below threshold
    if accuracy < 0.70
      current_weak_areas << { 'topic' => topic, 'accuracy' => accuracy }
    end
    
    # Keep only top 10 weakest areas
    current_weak_areas = current_weak_areas.sort_by { |area| area['accuracy'] }.first(10)
    
    update(weak_areas: current_weak_areas)
  end
  
  def streak_display
    case current_streak_days
    when 0
      "Start your streak!"
    when 1
      "1 day streak 🔥"
    else
      "#{current_streak_days} days streak 🔥"
    end
  end
  
  def level
    # Simple level calculation based on total points
    (total_points / 1000).to_i + 1
  end
  
  def points_to_next_level
    next_level_points = level * 1000
    next_level_points - total_points
  end
  
  def progress_to_next_level
    current_level_min = (level - 1) * 1000
    next_level_min = level * 1000
    level_range = next_level_min - current_level_min
    
    points_in_level = total_points - current_level_min
    (points_in_level.to_f / level_range * 100).round
  end
  
  def rank_display
    case level
    when 1..5 then "Beginner"
    when 6..10 then "Intermediate"
    when 11..20 then "Advanced"
    when 21..50 then "Expert"
    else "Master"
    end
  end
  
  def add_xp(points)
    increment!(:total_points, points)
  end
  
  def increment_units_completed
    # Track completed interactive units
    increment!(:interactive_units_completed) if respond_to?(:interactive_units_completed)
  end
  
  private
  
  def update_longest_streak
    if current_streak_days > longest_streak_days
      update(longest_streak_days: current_streak_days)
    end
  end
  
  def saved_change_to_attribute_that_matters?
    saved_change_to_total_points? || 
      saved_change_to_current_streak_days? ||
      saved_change_to_courses_completed? ||
      saved_change_to_labs_completed? ||
      saved_change_to_quizzes_passed?
  end
  
  def check_achievements
    # Check all course achievements to see if user qualifies for any
    CourseAchievement.find_each do |achievement|
      next if achievement.earned_by?(user)
      
      if achievement.check_criteria_for(user)
        UserCourseAchievement.create(user: user, course_achievement: achievement)
      end
    end
  end
end
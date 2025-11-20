# User course achievement model (renamed to avoid conflicts)
class UserCourseAchievement < ApplicationRecord
  self.table_name = 'user_course_achievements'
  
  # Associations
  belongs_to :user
  belongs_to :course_achievement
  
  # Validations
  validates :user_id, uniqueness: { scope: :course_achievement_id }
  
  # Scopes
  scope :recent, -> { order(earned_at: :desc) }
  scope :by_badge_type, ->(type) { joins(:course_achievement).where(course_achievements: { badge_type: type }) }
  scope :by_category, ->(category) { joins(:course_achievement).where(course_achievements: { category: category }) }
  
  # Callbacks
  before_create :set_earned_at
  after_create :award_points
  
  # Instance methods
  def badge_type
    course_achievement.badge_type
  end
  
  def category
    course_achievement.category
  end
  
  def points_value
    course_achievement.points_value
  end
  
  def days_since_earned
    return 0 unless earned_at
    ((Time.current - earned_at) / 1.day).to_i
  end
  
  private
  
  def set_earned_at
    self.earned_at ||= Time.current
  end
  
  def award_points
    user_stat = user.user_stat || user.create_user_stat
    user_stat.increment!(:total_points, course_achievement.points_value)
  end
end
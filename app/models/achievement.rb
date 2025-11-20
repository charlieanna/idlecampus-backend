# Course achievement model (renamed to avoid conflicts with existing achievements table)
class CourseAchievement < ApplicationRecord
  self.table_name = 'course_achievements'
  
  # Associations
  has_many :user_course_achievements, dependent: :destroy, foreign_key: 'course_achievement_id'
  has_many :users, through: :user_course_achievements
  
  # Validations
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :badge_type, inclusion: { in: %w[bronze silver gold platinum] }
  validates :category, inclusion: { in: %w[course_completion lab_mastery quiz_perfectionist streak speed] }
  
  # Scopes
  scope :by_category, ->(category) { where(category: category) }
  scope :by_badge_type, ->(type) { where(badge_type: type) }
  scope :ordered, -> { order(badge_type: :desc, points_value: :desc) }
  
  # Callbacks
  before_validation :generate_slug, on: :create
  
  # Instance methods
  def earned_by?(user)
    user_course_achievements.exists?(user: user)
  end
  
  def earned_count
    user_course_achievements.count
  end
  
  def badge_class
    case badge_type
    when 'bronze'
      'badge-bronze'
    when 'silver'
      'badge-silver'
    when 'gold'
      'badge-gold'
    when 'platinum'
      'badge-platinum'
    else
      'badge-secondary'
    end
  end
  
  def check_criteria_for(user)
    return false unless criteria.present?
    
    case criteria['type']
    when 'complete_course'
      check_course_completion(user, criteria['course_id'])
    when 'complete_module'
      check_module_completion(user, criteria['module_id'])
    when 'quiz_perfect_score'
      check_quiz_perfect_score(user, criteria['quiz_id'])
    when 'streak_days'
      check_streak(user, criteria['days'])
    when 'total_points'
      check_total_points(user, criteria['points'])
    when 'labs_completed'
      check_labs_completed(user, criteria['count'])
    when 'speed_quiz'
      check_speed_quiz(user, criteria['quiz_id'], criteria['time_seconds'])
    else
      false
    end
  end
  
  private
  
  def generate_slug
    self.slug ||= name.parameterize if name.present?
  end
  
  def check_course_completion(user, course_id)
    CourseEnrollment.exists?(
      user: user,
      course_id: course_id,
      status: 'completed'
    )
  end
  
  def check_module_completion(user, module_id)
    ModuleProgress.exists?(
      user: user,
      course_module_id: module_id,
      status: 'completed'
    )
  end
  
  def check_quiz_perfect_score(user, quiz_id)
    QuizAttempt.exists?(
      user: user,
      quiz_id: quiz_id,
      score: 100,
      passed: true
    )
  end
  
  def check_streak(user, required_days)
    user_stat = user.user_stat
    return false unless user_stat
    
    user_stat.current_streak_days >= required_days
  end
  
  def check_total_points(user, required_points)
    user_stat = user.user_stat
    return false unless user_stat
    
    user_stat.total_points >= required_points
  end
  
  def check_labs_completed(user, required_count)
    user_stat = user.user_stat
    return false unless user_stat
    
    user_stat.labs_completed >= required_count
  end
  
  def check_speed_quiz(user, quiz_id, max_time_seconds)
    QuizAttempt.exists?(
      user: user,
      quiz_id: quiz_id,
      passed: true,
      time_taken_seconds: ..max_time_seconds
    )
  end
end
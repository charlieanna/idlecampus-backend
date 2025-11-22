# Additional Progressive Flow Models
# Note: ProgressiveLearningTrack, ProgressiveChallengeLevel, ProgressiveAchievement, and ProgressiveSkill
# are now in their own separate files following Rails naming conventions.

class ProgressiveLevelAttempt < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :progressive_challenge
  
  # Validations
  validates :level_number, inclusion: { in: 1..5 }
  validates :score, numericality: { in: 0..100 }
  validates :xp_earned, :hints_used, numericality: { greater_than_or_equal_to: 0 }
  
  # Scopes
  scope :passed, -> { where(passed: true) }
  scope :failed, -> { where(passed: false) }
  scope :recent, -> { order(created_at: :desc) }
  
  # Callbacks
  after_create :award_xp
  
  private
  
  def award_xp
    if passed && xp_earned > 0
      ProgressiveXpService.new(user).award_xp!(
        xp_earned, 
        'challenge_level',
        { challenge_id: progressive_challenge_id, level: level_number }
      )
    end
  end
end


class ProgressiveUserAchievement < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :progressive_achievement
  
  # Validations
  validates :user_id, uniqueness: { scope: :progressive_achievement_id }
  validates :progress, numericality: { in: 0..100 }
  
  # Scopes
  scope :unlocked, -> { where('progress >= ?', 100) }
  scope :in_progress, -> { where('progress < ?', 100) }
  scope :recent, -> { order(unlocked_at: :desc) }
end

class ProgressiveXpTransaction < ApplicationRecord
  # Associations
  belongs_to :user
  
  # Validations
  validates :amount, numericality: { greater_than: 0 }
  validates :source_type, presence: true
  
  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :by_source, ->(source) { where(source_type: source) }
  
  # Callbacks
  after_create :update_user_stats
  
  private
  
  def update_user_stats
    stat = user.progressive_user_stat || user.create_progressive_user_stat
    stat.increment!(:total_xp, amount)
    stat.update_level!
  end
end

class ProgressiveNotification < ApplicationRecord
  # Associations
  belongs_to :user
  
  # Validations
  validates :notification_type, :title, presence: true
  
  # Scopes
  scope :unread, -> { where(is_read: false) }
  scope :recent, -> { order(created_at: :desc) }
  
  # Instance methods
  def mark_as_read!
    update!(is_read: true, read_at: Time.current) unless is_read
  end
end


class ProgressiveUserSkill < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :progressive_skill
  
  # Validations
  validates :user_id, uniqueness: { scope: :progressive_skill_id }
  validates :current_level, :points_allocated, numericality: { greater_than_or_equal_to: 0 }
  
  # Instance methods
  def level_up!
    return false if current_level >= progressive_skill.max_level
    
    increment!(:current_level)
    increment!(:points_allocated)
    update!(mastered_at: Time.current) if current_level == progressive_skill.max_level
    true
  end
  
  def mastered?
    current_level >= progressive_skill.max_level
  end
end

# Add associations to User model
class User < ApplicationRecord
  # Progressive Flow associations
  has_one :progressive_user_stat, dependent: :destroy
  has_many :progressive_user_challenge_progresses, dependent: :destroy
  has_many :progressive_level_attempts, dependent: :destroy
  has_many :progressive_user_achievements, dependent: :destroy
  has_many :progressive_xp_transactions, dependent: :destroy
  has_many :progressive_notifications, dependent: :destroy
  has_many :progressive_user_skills, dependent: :destroy
  has_many :progressive_user_track_progresses, dependent: :destroy
  has_many :progressive_assessment_results, dependent: :destroy
  has_many :progressive_learning_sessions, dependent: :destroy
  has_many :progressive_hint_usages, dependent: :destroy
  
  # Through associations
  has_many :progressive_challenges, through: :progressive_user_challenge_progresses
  has_many :progressive_achievements, through: :progressive_user_achievements
  has_many :progressive_skills, through: :progressive_user_skills
end
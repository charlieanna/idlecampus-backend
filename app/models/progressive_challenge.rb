class ProgressiveChallenge < ApplicationRecord
  # Associations
  belongs_to :progressive_learning_track, optional: true
  has_many :progressive_challenge_levels, dependent: :destroy
  has_many :progressive_user_challenge_progresses, dependent: :destroy
  has_many :progressive_level_attempts, dependent: :destroy
  has_many :progressive_daily_challenges, dependent: :destroy
  has_many :progressive_hint_usages, dependent: :destroy
  has_many :users, through: :progressive_user_challenge_progresses
  
  # Validations
  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true
  validates :difficulty_base, inclusion: { in: %w[beginner intermediate advanced] }
  validates :xp_base, :estimated_minutes, numericality: { greater_than: 0 }
  
  # Scopes
  scope :active, -> { where(is_active: true) }
  scope :by_difficulty, ->(diff) { where(difficulty_base: diff) }
  scope :by_category, ->(cat) { where(category: cat) }
  scope :ordered, -> { order(:order_in_track, :created_at) }
  scope :with_levels, -> { includes(:progressive_challenge_levels) }
  
  # Callbacks
  after_create :create_default_levels
  
  # Instance methods
  def prerequisite_challenges
    return [] if prerequisites.blank?
    ProgressiveChallenge.where(id: prerequisites)
  end
  
  def unlocked_for?(user)
    return true if prerequisites.blank?
    
    completed_challenges = user.progressive_user_challenge_progresses
                               .where(status: 'completed')
                               .pluck(:progressive_challenge_id)
    
    (prerequisites - completed_challenges.map(&:to_s)).empty?
  end
  
  def user_progress_for(user)
    progressive_user_challenge_progresses.find_by(user: user)
  end
  
  def completion_rate
    return 0 if progressive_user_challenge_progresses.count == 0
    
    completed = progressive_user_challenge_progresses.where(status: 'completed').count
    total = progressive_user_challenge_progresses.count
    (completed.to_f / total * 100).round(2)
  end
  
  def average_completion_time
    attempts = progressive_level_attempts
                .where(passed: true)
                .where.not(time_spent_minutes: nil)
    
    return 0 if attempts.count == 0
    attempts.average(:time_spent_minutes).to_i
  end
  
  def difficulty_multiplier
    case difficulty_base
    when 'beginner' then 1.0
    when 'intermediate' then 1.5
    when 'advanced' then 2.0
    else 1.0
    end
  end
  
  def total_xp_available
    progressive_challenge_levels.sum(:xp_reward)
  end
  
  private
  
  def create_default_levels
    return if progressive_challenge_levels.exists?
    
    level_configs = [
      { level_number: 1, level_name: 'Connectivity', xp_reward: xp_base },
      { level_number: 2, level_name: 'Capacity', xp_reward: (xp_base * 1.5).to_i },
      { level_number: 3, level_name: 'Optimization', xp_reward: (xp_base * 2.0).to_i },
      { level_number: 4, level_name: 'Resilience', xp_reward: (xp_base * 2.5).to_i },
      { level_number: 5, level_name: 'Excellence', xp_reward: (xp_base * 3.0).to_i }
    ]
    
    level_configs.each do |config|
      progressive_challenge_levels.create!(
        level_number: config[:level_number],
        level_name: config[:level_name],
        xp_reward: config[:xp_reward],
        requirements: {},
        test_cases: {},
        passing_criteria: {},
        estimated_minutes: estimated_minutes / 5
      )
    end
  end
end
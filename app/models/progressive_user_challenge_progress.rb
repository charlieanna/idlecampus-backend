class ProgressiveUserChallengeProgress < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :progressive_challenge
  
  # Validations
  validates :user_id, uniqueness: { scope: :progressive_challenge_id }
  validates :status, inclusion: { in: %w[not_started in_progress completed] }
  validates :current_level, numericality: { in: 0..5 }
  validates :total_attempts, :total_time_spent_minutes, :xp_earned, 
            numericality: { greater_than_or_equal_to: 0 }
  
  # Scopes
  scope :completed, -> { where(status: 'completed') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :not_started, -> { where(status: 'not_started') }
  scope :recent, -> { order(updated_at: :desc) }
  
  # Callbacks
  before_validation :set_defaults, on: :create
  after_update :check_completion
  
  # Instance methods
  def complete_level!(level_number, performance)
    transaction do
      # Update levels completed
      self.levels_completed ||= []
      self.levels_completed << level_number unless levels_completed.include?(level_number)
      self.levels_completed.sort!
      
      # Update current level
      self.current_level = [current_level, level_number].max
      
      # Update status
      if level_number == 5
        self.status = 'completed'
        self.completion_date = Time.current
      elsif status == 'not_started'
        self.status = 'in_progress'
        self.start_date ||= Time.current
      end
      
      # Update attempts and time
      self.total_attempts += 1
      self.total_time_spent_minutes += performance[:time_spent_minutes] || 0
      
      # Update best score
      self.best_score = [best_score || 0, performance[:score] || 0].max
      
      save!
    end
  end
  
  def progress_percentage
    return 100.0 if status == 'completed'
    return 0.0 if levels_completed.empty?
    
    (levels_completed.size.to_f / 5 * 100).round(2)
  end
  
  def next_level
    return nil if status == 'completed'
    current_level + 1
  end
  
  def time_since_start
    return nil unless start_date
    Time.current - start_date
  end
  
  def average_time_per_level
    return 0 if levels_completed.empty?
    total_time_spent_minutes / levels_completed.size
  end
  
  private
  
  def set_defaults
    self.status ||= 'not_started'
    self.current_level ||= 0
    self.levels_completed ||= []
    self.total_attempts ||= 0
    self.total_time_spent_minutes ||= 0
    self.xp_earned ||= 0
  end
  
  def check_completion
    if status == 'completed' && saved_change_to_status?
      # Trigger achievement checks
      ProgressiveAchievementService.new(user).check_and_unlock!
      
      # Update user stats
      user.progressive_user_stat&.increment!(:total_challenges_completed)
      
      # Check for track completion
      track = progressive_challenge.progressive_learning_track
      if track
        track_progress = user.progressive_user_track_progresses.find_by(
          progressive_learning_track: track
        )
        track_progress&.update_progress!
      end
    end
  end
end
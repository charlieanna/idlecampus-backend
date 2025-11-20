class LearningUnitProgress < ApplicationRecord
  MASTERY_THRESHOLD = 0.7
  # Associations
  belongs_to :user
  belongs_to :interactive_learning_unit
  
  # Validations
  validates :user_id, uniqueness: { scope: :interactive_learning_unit_id }
  validates :mastery_score, numericality: { 
    greater_than_or_equal_to: 0.0, 
    less_than_or_equal_to: 1.0 
  }
  
  # Callbacks
  after_save :check_completion
  after_update :award_completion_xp, if: :saved_change_to_completed?
  
  # Scopes
  scope :completed, -> { where(completed: true) }
  scope :in_progress, -> { where(completed: false) }
  scope :needs_review, -> { where('next_review_at <= ?', Time.current) }
  scope :by_mastery, ->(min_score) { where('mastery_score >= ?', min_score) }
  
  # Instance methods
  
  # Mark explanation as read
  def mark_explanation_read!
    update(explanation_read: true)
  end
  
  # Record practice attempt
  def record_practice_attempt(user_answer, correct)
    self.practice_attempts += 1
    self.practice_user_answer = user_answer
    self.practice_correct = correct
    self.practice_completed = true if correct
    self.last_practiced_at = Time.current
    
    save
  end
  
  # Record quiz attempt
  def record_quiz_attempt(user_answer, correct)
    self.quiz_attempts += 1
    self.quiz_user_answer = user_answer
    self.quiz_correct = correct
    self.quiz_answered = true
    
    save
  end
  
  # Mark scenario as completed
  def mark_scenario_completed!
    self.scenario_attempts += 1
    self.scenario_completed = true
    save
  end
  
  # Add time spent on this unit
  def add_time_spent(seconds)
    self.time_spent_seconds += seconds
    save
  end
  
  # Check if all components are completed
  def all_components_completed?
    explanation_read && 
    practice_completed && 
    quiz_answered && 
    scenario_completed
  end
  
  # Update mastery score
  def update_mastery_score!
    new_score = interactive_learning_unit.calculate_mastery(user)
    update(mastery_score: new_score)
  end
  
  # Schedule next review using spaced repetition
  def schedule_next_review!
    return unless completed
    
    # Simple spaced repetition: increase interval based on review count
    intervals = [1.day, 3.days, 7.days, 14.days, 30.days, 60.days]
    interval_index = [review_count, intervals.length - 1].min
    
    # Adjust interval based on mastery
    # Lower mastery = shorter interval
    mastery_factor = mastery_score > 0 ? mastery_score : 0.5
    adjusted_interval = intervals[interval_index] * mastery_factor
    
    update(
      next_review_at: Time.current + adjusted_interval,
      review_count: review_count + 1
    )
  end
  
  # Reset progress for retry
  def reset_progress!
    update(
      explanation_read: false,
      practice_completed: false,
      quiz_answered: false,
      scenario_completed: false,
      practice_attempts: 0,
      quiz_attempts: 0,
      scenario_attempts: 0,
      practice_correct: false,
      quiz_correct: false,
      completed: false,
      completed_at: nil,
      mastery_score: 0.0
    )
  end
  
  # Get completion status as percentage
  def completion_percentage
    components = [
      explanation_read,
      practice_completed,
      quiz_answered,
      scenario_completed
    ]
    
    completed_count = components.count(true)
    (completed_count.to_f / components.size * 100).round
  end
  
  # Check if user needs to review this unit
  def needs_review?
    completed && next_review_at.present? && next_review_at <= Time.current
  end

  # Consider a unit passed if completed with sufficient mastery
  def passed?
    completed && mastery_score.to_f >= MASTERY_THRESHOLD
  end
  
  private
  
  # Automatically mark as completed when all components done
  def check_completion
    if all_components_completed? && !completed
      self.completed = true
      self.completed_at = Time.current
      update_mastery_score!
      schedule_next_review!
      save if changed?
    end
  end
  
  # Award XP when unit is completed
  def award_completion_xp
    return unless completed && user && interactive_learning_unit
    
    xp = interactive_learning_unit.award_xp(user)
    
    # Update user stats if they exist
    user_stat = user.user_stat
    if user_stat
      user_stat.add_xp(xp)
      user_stat.increment_units_completed
      user_stat.save
    end
  end
end


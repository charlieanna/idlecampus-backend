class SpacedRepetitionItem < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :item, polymorphic: true
  belongs_to :coding_problem, optional: true # Legacy support
  
  # Validations
  validates :user_id, presence: true
  validates :next_review_at, presence: true
  validates :state, presence: true, inclusion: { in: %w[new learning review relearning] }
  validates :difficulty, numericality: { greater_than_or_equal_to: 1.0, less_than_or_equal_to: 10.0 }
  validates :stability, numericality: { greater_than: 0 }
  
  # Scopes (progress-based)
  scope :due, -> { where('points_since_review >= review_after_points').where.not(review_after_points: nil) }
  scope :upcoming, -> { where('points_since_review < review_after_points').where.not(review_after_points: nil) }
  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :for_item_type, ->(type) { where(item_type: type) }
  scope :ordered_by_urgency, -> { order(Arel.sql('(points_since_review - review_after_points) DESC')) }
  scope :in_learning, -> { where(state: ['new', 'learning']) }
  scope :in_review, -> { where(state: 'review') }
  
  # Class methods
  def self.states
    %w[new learning review relearning]
  end
  
  def self.for_quiz_questions
    where(item_type: 'QuizQuestion')
  end
  
  def self.schedule_review_for(user, item, grade: 1)
    # Find or create spaced repetition item
    sri = find_or_initialize_by(
      user: user,
      item_type: item.class.name,
      item_id: item.id
    )
    
    # Update review schedule using FSRS
    result = FsrsService.schedule_review(
      user_id: user.id,
      item_id: item.id,
      grade: grade,
      item_state: sri.to_fsrs_state
    )
    
    # Update item with new schedule
    sri.update!(
      difficulty: result['difficulty'],
      stability: result['stability'],
      interval_days: result['interval'],
      next_review_at: result['next_review_at'],
      review_count: result['reps'],
      lapse_count: result['lapses'],
      last_review_grade: result['last_grade'],
      state: determine_state(result['reps'], result['lapses'])
    )
    
    sri
  rescue => e
    Rails.logger.error("Failed to schedule review: #{e.message}")
    # Fallback to simple scheduling
    sri.next_review_at = 1.day.from_now
    sri.interval_days = 1
    sri.review_count += 1
    sri.save
    sri
  end
  
  def self.determine_state(reps, lapses)
    return 'new' if reps == 0
    return 'relearning' if lapses > 0 && reps < 5
    return 'learning' if reps < 5
    'review'
  end
  
  # Instance methods (progress-based)
  def due?
    return false if review_after_points.nil?
    points_since_review >= review_after_points
  end
  
  def overdue?
    due? && points_overdue > 0
  end
  
  def points_overdue
    return 0 unless due?
    points_since_review - review_after_points
  end
  
  def points_until_due
    return 0 if due?
    return 0 if review_after_points.nil?
    review_after_points - points_since_review
  end
  
  def progress_percentage
    return 100 if due?
    return 0 if review_after_points.nil? || review_after_points == 0
    ((points_since_review.to_f / review_after_points) * 100).round(1)
  end
  
  def retention_probability
    # Calculate using exponential forgetting curve (progress-based)
    # R(P) = e^(-P/S) where P is points since review and S is stability
    return 1.0 if points_since_review == 0
    return 0.0 if stability == 0
    Math.exp(-points_since_review.to_f / stability)
  end
  
  def difficulty_level
    case difficulty
    when 0..3 then 'easy'
    when 3..6 then 'medium'
    when 6..10 then 'hard'
    else 'unknown'
    end
  end
  
  def to_fsrs_state
    {
      difficulty: difficulty,
      stability: stability,
      elapsed_days: (Time.current - (updated_at || created_at)) / 1.day,
      reps: review_count,
      lapses: lapse_count,
      last_review_at: updated_at&.iso8601,
      last_grade: last_review_grade
    }
  end
  
  def record_review!(grade)
    # Update using FSRS
    result = self.class.schedule_review_for(user, item, grade: grade)
    reload
  end
  
  def ease_factor_display
    (ease_factor / 100.0).round(2)
  end
end
class ProgressTrackingService
  """
  Progress-based tracking for spaced repetition
  Awards points for learning activities and triggers reviews
  """
  
  # Point values for different activities
  ACTIVITY_POINTS = {
    lesson_completed: 10,
    quiz_started: 5,
    quiz_completed: 20,
    quiz_passed: 30,
    question_answered: 1,
    question_correct: 2,
    lab_started: 10,
    lab_step_completed: 5,
    lab_completed: 30,
    lab_passed: 40,
    practice_session: 5,
    review_completed: 3,
    achievement_earned: 15,
    streak_maintained: 5
  }.freeze
  
  def initialize(user)
    @user = user
  end
  
  def record_activity(activity_type, context = {})
    """
    Record learning activity and award progress points
    
    Args:
      activity_type: Symbol from ACTIVITY_POINTS keys
      context: Additional context (quiz score, lab difficulty, etc.)
    
    Returns:
      {
        points_earned: int,
        total_points: int,
        reviews_triggered: array
      }
    """
    
    # Calculate points for this activity
    points = calculate_points(activity_type, context)
    
    return { points_earned: 0, total_points: @user.total_progress_points, reviews_triggered: [] } if points == 0
    
    # Update user's total points
    @user.increment!(:total_progress_points, points)
    
    # Update all spaced repetition items
    updated_count = SpacedRepetitionItem
      .where(user: @user)
      .update_all("points_since_review = points_since_review + #{points}")
    
    # Check for newly due reviews
    reviews_triggered = check_due_reviews
    
    # Log event
    StructuredLogger.log_event(
      category: 'progress',
      action: 'points_awarded',
      context: {
        user_id: @user.id,
        activity: activity_type,
        points: points,
        total_points: @user.total_progress_points,
        reviews_triggered: reviews_triggered.count
      }
    )
    
    {
      points_earned: points,
      total_points: @user.total_progress_points,
      reviews_triggered: reviews_triggered
    }
  end
  
  def check_due_reviews
    """Check for reviews that have crossed the point threshold"""
    
    SpacedRepetitionItem
      .where(user: @user)
      .where('points_since_review >= review_after_points')
      .where.not(review_after_points: nil)
      .to_a
  end
  
  def get_reviews_due_count
    """Get count of reviews currently due"""
    check_due_reviews.count
  end
  
  def get_progress_to_next_review(review_item)
    """Get progress percentage to next review"""
    return 100 if review_item.points_since_review >= review_item.review_after_points
    
    (review_item.points_since_review.to_f / review_item.review_after_points * 100).round(1)
  end
  
  def points_until_review(review_item)
    """Points remaining until review is due"""
    remaining = review_item.review_after_points - review_item.points_since_review
    [remaining, 0].max
  end
  
  def self.record_for_user(user, activity_type, context = {})
    """Class method for convenience"""
    new(user).record_activity(activity_type, context)
  end
  
  private
  
  def calculate_points(activity_type, context)
    """Calculate points for activity"""
    
    base_points = ACTIVITY_POINTS[activity_type] || 0
    
    # Apply multipliers based on context
    multiplier = 1.0
    
    case activity_type
    when :quiz_completed, :quiz_passed
      # Bonus for high scores
      if context[:score]
        multiplier = 1.0 + ((context[:score] - 70) / 100.0) if context[:score] > 70
      end
      
    when :lab_completed, :lab_passed
      # Bonus for difficulty
      case context[:difficulty]
      when 'hard', 'advanced'
        multiplier = 1.5
      when 'medium', 'intermediate'
        multiplier = 1.2
      end
      
    when :question_answered, :question_correct
      # Bonus for difficult questions
      if context[:difficulty] && context[:difficulty] > 0
        multiplier = 1.0 + (context[:difficulty] / 3.0).clamp(0, 0.5)
      end
    end
    
    (base_points * multiplier).round
  end
end


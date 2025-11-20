class FSRSSchedulingService
  """
  FSRS-4.5 (Free Spaced Repetition Scheduler) implementation
  Optimizes review scheduling based on memory stability and retrievability
  """
  
  # FSRS-4.5 algorithm parameters (optimized for technical content)
  # Converted to progress-based intervals (points instead of days)
  PARAMETERS = {
    initial_stability: {
      1 => 8,    # Again (complete failure) - 8 points (~0.4 days worth)
      2 => 12,   # Hard (struggled) - 12 points
      3 => 48,   # Good (correct) - 48 points (~2.4 days worth)
      4 => 116   # Easy (trivial) - 116 points (~5.8 days worth)
    },
    desired_retention: 0.9,        # Target 90% retention
    maximum_interval: 7300,        # Max interval in points (~365 days worth @ 20pts/day)
    minimum_interval: 20,          # Min interval in points (~1 day worth)
    points_per_day_avg: 20,        # Average points earned per active day
    w: [0.4, 0.6, 2.4, 5.8,        # Initial stabilities for [Again, Hard, Good, Easy]
        1.09, 0.99, 0.94, 0.00,     # Review factors
        1.49, 0.14, 0.94, 2.18,     # Difficulty adjustment
        0.05, 0.34, 1.26, 0.29,     # Stability increase
        2.61]                        # Advanced parameters
  }.freeze
  
  def schedule_review(user:, item:, performance:)
    """
    Schedule next review using FSRS algorithm
    
    Performance grades (1-4):
    - 1: Again (forgot completely)
    - 2: Hard (struggled to remember)
    - 3: Good (remembered with effort)
    - 4: Easy (remembered instantly)
    
    Returns: SpacedRepetitionItem
    """
    
    sr_item = SpacedRepetitionItem.find_or_initialize_by(
      user: user,
      reviewable: item
    )
    
    # First review?
    if sr_item.new_record?
      initialize_new_item(sr_item, performance)
    else
      update_existing_item(sr_item, performance)
    end
    
    sr_item.save!
    sr_item
  end
  
  def get_items_due_for_review(user, limit: 20)
    """Get items due for review (progress-based)"""
    SpacedRepetitionItem
      .where(user: user)
      .where('points_since_review >= review_after_points')
      .where.not(review_after_points: nil)
      .order(Arel.sql('(points_since_review - review_after_points) DESC'))
      .limit(limit)
  end
  
  def calculate_progress_load(user)
    """Calculate review load based on progress points"""
    
    progress_tracker = ProgressTrackingService.new(user)
    
    # Get items grouped by points remaining
    items = SpacedRepetitionItem.where(user: user).where.not(review_after_points: nil)
    
    load_ranges = {
      immediate: items.where('points_since_review >= review_after_points').count,
      very_soon: items.where('points_since_review >= review_after_points * 0.8 AND points_since_review < review_after_points').count,
      soon: items.where('points_since_review >= review_after_points * 0.5 AND points_since_review < review_after_points * 0.8').count,
      later: items.where('points_since_review < review_after_points * 0.5').count
    }
    
    {
      due_now: load_ranges[:immediate],
      within_20_points: load_ranges[:immediate] + load_ranges[:very_soon],
      within_50_points: load_ranges[:immediate] + load_ranges[:very_soon] + load_ranges[:soon],
      total_items: items.count,
      recommended_time_minutes: load_ranges[:immediate] * 2
    }
  end
  
  def reset_stale_items(user)
    """Reset items that have accumulated too many points without review"""
    
    # Items that have 3x the required points are considered stale
    stale = SpacedRepetitionItem
      .where(user: user)
      .where('points_since_review >= review_after_points * 3')
      .where.not(review_after_points: nil)
    
    stale.each do |item|
      # Reset to initial schedule (they need to relearn)
      item.update!(
        progress_interval: PARAMETERS[:minimum_interval],
        review_after_points: PARAMETERS[:minimum_interval],
        points_since_review: PARAMETERS[:minimum_interval], # Set to immediately due
        stability: PARAMETERS[:initial_stability][2], # Default to 'Good'
        state: 'relearning'
      )
    end
    
    stale.count
  end
  
  private
  
  def initialize_new_item(sr_item, performance)
    """Initialize a new spaced repetition item (progress-based)"""
    
    # Set initial stability based on performance
    initial_stability = PARAMETERS[:initial_stability][performance] || PARAMETERS[:initial_stability][3]
    
    # Calculate first interval in progress points
    interval_points = calculate_interval_points(initial_stability)
    
    sr_item.assign_attributes(
      stability: initial_stability,
      difficulty: calculate_initial_difficulty(performance),
      progress_interval: interval_points,
      review_after_points: interval_points,
      points_since_review: 0,
      last_review_points: sr_item.user.total_progress_points || 0,
      last_reviewed_at: Time.current,
      review_count: 1,
      state: determine_state(performance, nil)
    )
  end
  
  def update_existing_item(sr_item, performance)
    """Update existing item after review (progress-based)"""
    
    # Calculate retrievability (probability of recall based on progress)
    retrievability = calculate_retrievability_progress(sr_item)
    
    # Calculate new stability based on performance
    new_stability = calculate_stability(
      current_stability: sr_item.stability,
      performance: performance,
      retrievability: retrievability,
      difficulty: sr_item.difficulty
    )
    
    # Update difficulty
    new_difficulty = update_difficulty(sr_item.difficulty, performance)
    
    # Calculate next interval in progress points
    interval_points = calculate_interval_points(new_stability)
    
    # Update state
    new_state = determine_state(performance, sr_item.state)
    
    sr_item.assign_attributes(
      stability: new_stability.clamp(1, PARAMETERS[:maximum_interval]),
      difficulty: new_difficulty.clamp(1, 10),
      progress_interval: interval_points,
      review_after_points: interval_points,
      points_since_review: 0, # Reset counter
      last_review_points: sr_item.user.total_progress_points || 0,
      last_reviewed_at: Time.current,
      review_count: sr_item.review_count + 1,
      state: new_state
    )
  end
  
  def calculate_retrievability_progress(sr_item)
    """Calculate current retrievability based on progress points (0-1)"""
    
    return 1.0 if sr_item.points_since_review == 0
    
    points_since_review = sr_item.points_since_review || 0
    stability = sr_item.stability || PARAMETERS[:initial_stability][3]
    
    # Progress-based retrievability formula: R = e^(-P/S)
    # Where P is points since review, S is stability
    Math.exp(-points_since_review / stability)
  end
  
  def calculate_stability(current_stability:, performance:, retrievability:, difficulty:)
    """
    Calculate new memory stability using FSRS formula
    
    Stability increases when:
    - Performance is good/easy
    - Retrievability is low (item was harder to recall)
    - Current stability is higher
    """
    
    if performance >= 3 # Success (Good or Easy)
      # Stability increase on success
      # Formula: S' = S * (1 + exp(w8) * (11 - D) * S^w9 * (exp(w10 * (1 - R)) - 1))
      
      s_increment = (
        Math.exp(PARAMETERS[:w][8]) *
        (11 - difficulty) *
        current_stability ** PARAMETERS[:w][9] *
        (Math.exp(PARAMETERS[:w][10] * (1 - retrievability)) - 1)
      )
      
      new_stability = current_stability * (1 + s_increment)
      
    else # Failure (Again or Hard)
      # Stability decrease on failure
      # Formula: S' = S * exp(w11 * (G - 3) * w12)
      
      multiplier = Math.exp(PARAMETERS[:w][11] * (performance - 3) * PARAMETERS[:w][12])
      new_stability = current_stability * multiplier
      
      # Ensure minimum stability
      new_stability = [new_stability, 0.1].max
    end
    
    new_stability
  end
  
  def calculate_interval_points(stability)
    """
    Calculate optimal interval in progress points to maintain desired retention
    
    Formula: I = S * ln(D) / ln(0.9)
    where D = desired retention (0.9), S is stability in points
    """
    
    interval = stability * Math.log(PARAMETERS[:desired_retention]) / Math.log(0.9)
    interval.round.clamp(PARAMETERS[:minimum_interval], PARAMETERS[:maximum_interval])
  end
  
  def calculate_initial_difficulty(performance)
    """Calculate initial difficulty rating (1-10 scale)"""
    
    # Map performance to difficulty
    case performance
    when 1
      8.0  # Forgot = hard
    when 2
      6.0  # Hard = medium-hard
    when 3
      4.0  # Good = medium
    when 4
      2.0  # Easy = easy
    else
      5.0  # Default
    end
  end
  
  def update_difficulty(current_difficulty, performance)
    """Update difficulty based on performance"""
    
    # FSRS difficulty update formula
    # D' = D - w6 * (G - 3)
    
    delta = PARAMETERS[:w][6] * (performance - 3)
    new_difficulty = current_difficulty - delta
    
    # Difficulty should drift slowly
    new_difficulty
  end
  
  def determine_state(performance, current_state)
    """Determine item state based on performance"""
    
    case performance
    when 1
      'relearning'  # Need to relearn
    when 2
      'learning'    # Still learning
    when 3, 4
      if current_state == 'new' || current_state == 'learning'
        'learning'
      else
        'review'    # Successfully reviewed
      end
    else
      current_state || 'new'
    end
  end
  
  # ============================================
  # Public Helpers
  # ============================================
  
  def self.performance_grade_from_score(score)
    """Convert percentage score to FSRS performance grade"""
    
    case score
    when 0...40
      1  # Again
    when 40...70
      2  # Hard
    when 70...90
      3  # Good
    else
      4  # Easy
    end
  end
  
  def self.performance_grade_from_manual(grade_name)
    """Convert manual grade to number"""
    
    grades = {
      'again' => 1,
      'hard' => 2,
      'good' => 3,
      'easy' => 4
    }
    
    grades[grade_name.to_s.downcase] || 3
  end
end


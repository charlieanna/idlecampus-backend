# FSRS (Free Spaced Repetition Scheduler) Algorithm Implementation
# Version: FSRS-4.5 (latest stable as of 2024)
# 
# FSRS is a modern spaced repetition algorithm that improves upon SM-2 by:
# 1. Using machine learning principles for better interval optimization
# 2. Adapting to individual forgetting curves
# 3. Providing more accurate difficulty and stability calculations
# 4. Better handling of lapses and relearning

class FsrsAlgorithm
  # FSRS-4.5 default parameters (optimized through ML on large datasets)
  DEFAULT_PARAMS = {
    # Initial stability values for different grades (Again, Hard, Good, Easy)
    initial_stability: [0.4, 0.6, 2.4, 5.8],
    
    # Initial difficulty (D) - represents inherent item difficulty
    initial_difficulty: 4.93,
    
    # Difficulty update factors
    difficulty_multiplier: [5.0, 1.2, 0.8, 0.5],  # w[4-7]
    
    # Stability increase factors
    stability_factor_success: 0.94,  # w[8]
    stability_factor_failure: 0.27,  # w[9]
    
    # Stability scaling parameters
    stability_scaling: [0.35, 1.02, 1.70, 0.94],  # w[10-13]
    
    # Retention target (90% is optimal for most learning)
    target_retention: 0.90,
    
    # Maximum interval in days
    maximum_interval: 365,
    
    # Easy bonus multiplier
    easy_bonus: 1.3,
    
    # Hard penalty
    hard_penalty: 0.8
  }.freeze
  
  # Grade definitions (FSRS uses 1-4, but we map to human-readable)
  GRADES = {
    again: 1,   # Complete failure to recall
    hard: 2,    # Recalled with significant difficulty
    good: 3,    # Recalled with moderate effort (optimal)
    easy: 4     # Recalled instantly with no effort
  }.freeze
  
  def initialize(params = {})
    @params = DEFAULT_PARAMS.merge(params)
  end
  
  # Main scheduling function - returns next review interval and updated card state
  # @param card [Hash] Current card state with :difficulty, :stability, :elapsed_days, :reps, :lapses
  # @param grade [Symbol] :again, :hard, :good, or :easy
  # @param review_time [Time] When the review happened
  # @return [Hash] Updated card state with next_interval, next_review_at, difficulty, stability
  def schedule(card, grade, review_time = Time.current)
    grade_value = GRADES[grade] || raise(ArgumentError, "Invalid grade: #{grade}")
    
    # Initialize card state if new
    card = initialize_card(card) if card[:reps].to_i == 0
    
    # Calculate retention rate based on elapsed time
    retention = calculate_retention(card[:stability], card[:elapsed_days] || 0)
    
    # Update difficulty
    new_difficulty = update_difficulty(card[:difficulty], grade_value)
    
    # Update stability
    new_stability = update_stability(
      card[:stability],
      new_difficulty,
      grade_value,
      retention
    )
    
    # Calculate next interval
    next_interval = calculate_interval(new_stability, grade_value)
    
    # Apply grade-specific adjustments
    next_interval = apply_grade_adjustments(next_interval, grade)
    
    # Ensure interval is within bounds
    next_interval = [[next_interval, 1].max, @params[:maximum_interval]].min
    
    # Build updated card state
    {
      difficulty: new_difficulty.round(2),
      stability: new_stability.round(2),
      interval: next_interval.round,
      next_review_at: review_time + next_interval.days,
      reps: card[:reps].to_i + 1,
      lapses: grade == :again ? card[:lapses].to_i + 1 : card[:lapses].to_i,
      last_review_at: review_time,
      last_grade: grade
    }
  end
  
  # Calculate optimal review time based on target retention
  # This is when the probability of recall equals target retention
  def calculate_optimal_interval(stability)
    stability * Math.log(@params[:target_retention]) / Math.log(0.9)
  end
  
  # Predict probability of successful recall at given time
  # @param stability [Float] Current stability value
  # @param elapsed_days [Integer] Days since last review
  # @return [Float] Probability between 0 and 1
  def predict_recall_probability(stability, elapsed_days)
    Math.exp(-elapsed_days.to_f / stability)
  end
  
  # Get recommended review items sorted by urgency
  # @param items [Array<Hash>] Array of items with FSRS state
  # @param current_time [Time] Current time for calculations
  # @param limit [Integer] Maximum items to return
  # @return [Array<Hash>] Items sorted by review urgency
  def get_review_queue(items, current_time = Time.current, limit = 20)
    items.map do |item|
      if item[:next_review_at] && item[:stability]
        elapsed = ((current_time - item[:next_review_at]) / 1.day).to_f
        urgency = calculate_urgency(item[:stability], elapsed)
        item.merge(urgency: urgency, overdue: elapsed > 0)
      else
        item.merge(urgency: 0, overdue: false)
      end
    end.sort_by { |item| -item[:urgency] }.take(limit)
  end
  
  private
  
  def initialize_card(card)
    {
      difficulty: @params[:initial_difficulty],
      stability: @params[:initial_stability][2], # Default to "good" initial stability
      elapsed_days: 0,
      reps: 0,
      lapses: 0
    }.merge(card)
  end
  
  # FSRS difficulty update formula
  # D' = D - w[6] * (G - 3) + w[7] * (G - 3) * (1 - R)
  def update_difficulty(current_difficulty, grade)
    grade_offset = grade - 3
    
    # Simplified FSRS-4.5 difficulty update
    multiplier = @params[:difficulty_multiplier][grade - 1]
    
    new_difficulty = current_difficulty + (4 - grade) * multiplier * 0.1
    
    # Clamp difficulty between 1 and 10
    [[new_difficulty, 1].max, 10].min
  end
  
  # FSRS stability update formula
  def update_stability(current_stability, difficulty, grade, retention)
    if grade == 1  # Failed recall
      # Stability decreases on failure
      new_stability = current_stability * @params[:stability_factor_failure]
      
      # Apply difficulty penalty
      new_stability * (11 - difficulty) / 10
    else
      # Stability increases on success
      success_factor = @params[:stability_scaling][grade - 1]
      
      # FSRS-4.5 formula: S' = S * (1 + e^(w[8]) * (11 - D) * S^(-w[9]) * (e^(w[10] * (G - 1)) - 1))
      growth_factor = Math.exp(0.1 * (11 - difficulty)) * 
                     (current_stability ** -0.3) *
                     (success_factor - 1)
      
      current_stability * (1 + growth_factor)
    end
  end
  
  # Calculate review interval based on stability and target retention
  def calculate_interval(stability, grade)
    if grade == 1  # Failed - relearning steps
      0.01  # Review again in ~15 minutes (0.01 days)
    else
      # I = S * ln(R) / ln(0.9), where R is target retention
      interval = stability * 9 * (1 / @params[:target_retention] - 1)
      
      # Apply minimum intervals based on grade
      case grade
      when 2 then [interval, 1].max   # Hard: at least 1 day
      when 3 then [interval, 2].max   # Good: at least 2 days
      when 4 then [interval, 4].max   # Easy: at least 4 days
      else interval
      end
    end
  end
  
  # Apply grade-specific bonuses/penalties
  def apply_grade_adjustments(interval, grade)
    case grade
    when :easy
      interval * @params[:easy_bonus]
    when :hard
      interval * @params[:hard_penalty]
    else
      interval
    end
  end
  
  # Calculate retention probability
  def calculate_retention(stability, elapsed_days)
    return 1.0 if elapsed_days <= 0
    
    # R = exp(-t/S) where t is elapsed time and S is stability
    Math.exp(-elapsed_days.to_f / stability)
  end
  
  # Calculate review urgency (higher = more urgent)
  def calculate_urgency(stability, days_overdue)
    if days_overdue > 0
      # Overdue items have high urgency
      retention = calculate_retention(stability, days_overdue)
      (1 - retention) * 100 + days_overdue
    else
      # Future items have negative urgency
      -days_overdue
    end
  end
end

# Usage example service that integrates FSRS with your Docker learning platform
class FsrsSpacedRepetitionService
  def initialize(user)
    @user = user
    @fsrs = FsrsAlgorithm.new(
      # You can customize parameters per user based on their learning patterns
      target_retention: user_target_retention,
      maximum_interval: 180  # 6 months max for technical content
    )
  end
  
  # Schedule next review for a Docker command or Kubernetes resource
  def schedule_review(item, grade)
    # Get current FSRS state from database
    current_state = get_fsrs_state(item)
    
    # Calculate new schedule
    new_state = @fsrs.schedule(current_state, grade)
    
    # Save to database
    save_fsrs_state(item, new_state)
    
    new_state
  end
  
  # Get items due for review
  def get_due_items(limit = 10)
    items = fetch_user_items
    @fsrs.get_review_queue(items, Time.current, limit)
  end
  
  # Predict recall probability for an item
  def predict_recall(item)
    state = get_fsrs_state(item)
    elapsed = (Time.current - state[:last_review_at]) / 1.day
    @fsrs.predict_recall_probability(state[:stability], elapsed)
  end
  
  # Optimize parameters based on user's review history
  def optimize_parameters
    # This would use user's review history to optimize FSRS parameters
    # Implementation would involve gradient descent or similar optimization
    # For now, return default parameters
    FsrsAlgorithm::DEFAULT_PARAMS
  end
  
  private
  
  def user_target_retention
    # Adjust based on user's goals
    case @user.learning_goal
    when 'certification' then 0.95  # Higher retention for exam prep
    when 'casual' then 0.85         # Lower retention for casual learning
    else 0.90                       # Default
    end
  end
  
  def get_fsrs_state(item)
    # Fetch from database (e.g., spaced_repetition_items table)
    sr_item = SpacedRepetitionItem.find_by(
      user: @user,
      reviewable: item
    )
    
    if sr_item
      {
        difficulty: sr_item.difficulty || 5.0,
        stability: sr_item.stability || 2.4,
        elapsed_days: sr_item.elapsed_days,
        reps: sr_item.review_count,
        lapses: sr_item.lapse_count,
        last_review_at: sr_item.last_reviewed_at
      }
    else
      {}  # Will be initialized by FSRS
    end
  end
  
  def save_fsrs_state(item, state)
    sr_item = SpacedRepetitionItem.find_or_create_by(
      user: @user,
      reviewable: item
    )
    
    sr_item.update!(
      difficulty: state[:difficulty],
      stability: state[:stability],
      interval_days: state[:interval],
      next_review_at: state[:next_review_at],
      review_count: state[:reps],
      lapse_count: state[:lapses],
      last_reviewed_at: state[:last_review_at],
      last_grade: state[:last_grade]
    )
  end
  
  def fetch_user_items
    SpacedRepetitionItem
      .where(user: @user)
      .includes(:reviewable)
      .map do |item|
        {
          id: item.id,
          reviewable: item.reviewable,
          stability: item.stability,
          next_review_at: item.next_review_at,
          difficulty: item.difficulty
        }
      end
  end
end
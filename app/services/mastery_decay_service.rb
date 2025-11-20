class MasteryDecayService
  include ActiveModel::Model
  
  MUSCLE_MEMORY_FLOOR = 40
  BASE_STRENGTH_FACTOR = 7.0
  CONTEXT_BONUS_MULTIPLIER = 2.0
  SUCCESS_BONUS_MULTIPLIER = 5.0
  
  attr_accessor :user_command_mastery
  
  def initialize(user_command_mastery)
    @user_command_mastery = user_command_mastery
  end
  
  # Calculate current decayed score based on time elapsed
  def current_decayed_score
    return user_command_mastery.proficiency_score if user_command_mastery.last_practiced_at.nil?
    
    days_since_practice = days_since_last_practice
    return user_command_mastery.proficiency_score if days_since_practice <= 0
    
    calculate_decayed_score(user_command_mastery.proficiency_score, days_since_practice)
  end
  
  # Generate decay curve data for visualization
  def generate_decay_curve(days_ahead = 30)
    current_score = user_command_mastery.proficiency_score
    strength_factor = calculate_strength_factor
    
    curve_data = []
    (0..days_ahead).each do |day|
      decayed_score = calculate_decayed_score(current_score, day, strength_factor)
      
      curve_data << {
        day: day,
        score: decayed_score,
        is_projection: day > 0,
        risk_level: determine_risk_level(decayed_score)
      }
    end
    
    curve_data
  end
  
  # Predict when score will fall below threshold
  def predict_risk_threshold_breach(threshold = 80)
    return nil if user_command_mastery.proficiency_score <= threshold
    
    strength_factor = calculate_strength_factor
    current_score = user_command_mastery.proficiency_score
    
    # Solve for t in: threshold = current_score * e^(-t/S) 
    # where score above floor is reduced by muscle memory factor
    score_above_floor = current_score - MUSCLE_MEMORY_FLOOR
    threshold_above_floor = threshold - MUSCLE_MEMORY_FLOOR
    
    if threshold_above_floor <= 0 || score_above_floor <= 0
      return nil
    end
    
    # Adjusted calculation considering muscle memory floor
    retention_needed = threshold_above_floor / (score_above_floor * 0.9)
    
    if retention_needed >= 1
      return 0 # Already below threshold
    end
    
    days_to_threshold = -strength_factor * Math.log(retention_needed)
    days_to_threshold.positive? ? days_to_threshold.round : nil
  end
  
  # Calculate optimal review timing based on decay curve
  def suggest_review_timing
    current_score = current_decayed_score
    risk_level = determine_risk_level(current_score)
    
    case risk_level
    when 'critical'
      { urgency: 'immediate', days: 0, reason: 'Score below 50 - immediate review required' }
    when 'risk'
      { urgency: 'high', days: 1, reason: 'Score below 70 - review within 24 hours' }
    when 'watch'
      days_to_risk = predict_risk_threshold_breach(70)
      { urgency: 'medium', days: [days_to_risk&./(2), 3].compact.min, reason: 'Preventive review recommended' }
    else
      days_to_risk = predict_risk_threshold_breach(80)
      review_days = days_to_risk ? [days_to_risk * 0.7, 7].min.round : 7
      { urgency: 'low', days: review_days, reason: 'Maintenance review' }
    end
  end
  
  # Update proficiency score based on decay
  def apply_decay!
    new_score = current_decayed_score
    
    if new_score < user_command_mastery.proficiency_score
      user_command_mastery.update!(
        proficiency_score: new_score,
        last_decay_applied_at: Time.current
      )
      
      Rails.logger.info "Applied decay to #{user_command_mastery.canonical_command}: #{user_command_mastery.proficiency_score} -> #{new_score}"
    end
    
    new_score
  end
  
  # Check if command is protected by active shield
  def protected_by_shield?
    return false unless user_command_mastery.respond_to?(:shields)
    
    user_command_mastery.shields.any? do |shield|
      shield.active_until.nil? || shield.active_until > Time.current
    end
  end
  
  # Get decay timeline for visualization
  def self.generate_user_decay_timeline(user_id, time_range = 30)
    user_masteries = UserCommandMastery.where(user_id: user_id)
    
    timeline_data = []
    
    (-time_range..0).each do |days_offset|
      date = Date.current + days_offset.days
      daily_scores = []
      
      user_masteries.each do |mastery|
        service = new(mastery)
        # Calculate what the score would have been on that date
        days_from_last_practice = (date - mastery.last_practiced_at.to_date).to_i
        if days_from_last_practice >= 0
          score = service.calculate_decayed_score(mastery.proficiency_score, days_from_last_practice)
          daily_scores << score
        end
      end
      
      if daily_scores.any?
        timeline_data << {
          date: date.strftime('%Y-%m-%d'),
          average_score: daily_scores.sum / daily_scores.size,
          commands_tracked: daily_scores.size,
          commands_at_risk: daily_scores.count { |score| score < 80 }
        }
      end
    end
    
    timeline_data
  end
  
  private
  
  def days_since_last_practice
    return 0 unless user_command_mastery.last_practiced_at
    
    (Time.current - user_command_mastery.last_practiced_at) / 1.day
  end
  
  def calculate_strength_factor
    base_strength = BASE_STRENGTH_FACTOR
    
    # Context bonus - more contexts seen = stronger memory
    context_bonus = (user_command_mastery.contexts_seen&.size || 0) * CONTEXT_BONUS_MULTIPLIER
    
    # Success rate bonus - higher success rate = stronger memory
    success_rate = if user_command_mastery.total_attempts > 0
                    user_command_mastery.successful_attempts.to_f / user_command_mastery.total_attempts
                  else
                    0
                  end
    success_bonus = success_rate * SUCCESS_BONUS_MULTIPLIER
    
    # Shield protection bonus
    shield_bonus = protected_by_shield? ? 5.0 : 0
    
    base_strength + context_bonus + success_bonus + shield_bonus
  end
  
  def calculate_decayed_score(original_score, days_elapsed, strength_factor = nil)
    return original_score if days_elapsed <= 0
    
    strength_factor ||= calculate_strength_factor
    
    # Ebbinghaus forgetting curve: R = e^(-t/S)
    retention = Math.exp(-days_elapsed / strength_factor)
    decayed_score = original_score * retention
    
    # Apply muscle memory floor with gradual reduction
    score_above_floor = decayed_score - MUSCLE_MEMORY_FLOOR
    if score_above_floor > 0
      # Reduce the score above floor by 10% to simulate gradual decay
      decayed_score = MUSCLE_MEMORY_FLOOR + (score_above_floor * 0.9)
    end
    
    # Ensure score doesn't go below muscle memory floor
    [decayed_score, MUSCLE_MEMORY_FLOOR].max.round(2)
  end
  
  def determine_risk_level(score)
    case score
    when 90..Float::INFINITY then 'safe'
    when 70...90 then 'watch'
    when 50...70 then 'risk'
    else 'critical'
    end
  end
end
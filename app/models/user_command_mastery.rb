class UserCommandMastery < ApplicationRecord
  belongs_to :user
  
  # Validations
  validates :canonical_command, presence: true, uniqueness: { scope: :user_id }
  validates :proficiency_score, numericality: { 
    greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 100 
  }
  validates :total_attempts, :successful_attempts, 
            numericality: { greater_than_or_equal_to: 0 }
  
  # Scopes
  scope :by_category, ->(category) { where(command_category: category) }
  scope :mastered, -> { where('proficiency_score >= ?', 100) }
  scope :needs_practice, -> { where('proficiency_score < ?', 70) }
  scope :recently_used, -> { order(last_used_at: :desc) }
  scope :by_proficiency, -> { order(proficiency_score: :desc) }
  
  # Constants for mastery thresholds
  MASTERY_THRESHOLD = 100.0  # 100% required for mastery
  PRACTICE_THRESHOLD = 70.0  # Below this needs practice
  MEMORY_FLOOR = 40.0        # Muscle memory floor (Phase 3)
  
  # Context types for performance tracking
  CONTEXT_TYPES = %w[practice quiz lab real_project].freeze
  
  # Shield levels for gamification (Phase 3)
  SHIELD_LEVELS = {
    bronze: { threshold: 3, color: '#CD7F32' },
    silver: { threshold: 7, color: '#C0C0C0' },
    gold: { threshold: 14, color: '#FFD700' },
    platinum: { threshold: 30, color: '#E5E4E2' }
  }.freeze

  # Callbacks for hybrid decay tracking
  before_save :track_mastery_achievement
  
  # Calculate mastery percentage
  def mastery_percentage
    return 0.0 if total_attempts.zero?
    (successful_attempts.to_f / total_attempts * 100).round(2)
  end
  
  # Check if command is mastered
  def mastered?
    proficiency_score >= MASTERY_THRESHOLD
  end
  
  # Check if needs practice
  def needs_practice?
    proficiency_score < PRACTICE_THRESHOLD
  end
  
  # Update mastery based on new attempt
  def record_attempt(success:, context: 'practice')
    self.total_attempts += 1
    self.successful_attempts += 1 if success
    self.last_used_at = Time.current
    
    if success
      self.last_correct_at = Time.current
      self.first_mastered_at ||= Time.current if mastered?
    end
    
    # Update context-specific performance
    update_context_performance(context, success)
    
    # Recalculate proficiency score
    recalculate_proficiency_score
    
    save!
  end
  
  # Calculate decay (Phase 3)
  def calculate_decay
    return proficiency_score if last_used_at.nil?
    
    days_since_use = (Time.current - last_used_at) / 1.day
    
    # Ebbinghaus forgetting curve with muscle memory floor
    retention = if days_since_use <= 1
                  proficiency_score
                elsif days_since_use <= 7
                  proficiency_score * (0.85 ** (days_since_use / 7.0))
                else
                  [proficiency_score * (0.5 ** (days_since_use / 30.0)), MEMORY_FLOOR].max
                end
    
    retention.round(2)
  end
  
  # Apply decay if needed (Phase 3)
  def apply_decay!
    return if last_decay_calculation_at && 
              (Time.current - last_decay_calculation_at) < 1.day
    
    new_score = calculate_decay
    if new_score < proficiency_score
      self.proficiency_score = new_score
      self.last_decay_calculation_at = Time.current
      save!
    end
  end
  
  # Get current shield level (Phase 3)
  def shield_level
    return nil unless first_mastered_at
    
    days_mastered = (Time.current - first_mastered_at) / 1.day
    
    SHIELD_LEVELS.reverse_each do |level, config|
      return level if days_mastered >= config[:threshold]
    end
    
    nil
  end
  
  # Get context performance for specific context
  def performance_in_context(context)
    context_data = (context_performance || {})[context.to_s] || {}
    {
      attempts: context_data['attempts'] || 0,
      successes: context_data['successes'] || 0,
      success_rate: calculate_context_success_rate(context_data)
    }
  end

  # Hybrid Decay: Get user's current position in learning path
  def current_learning_position
    # Get user's current chapter in learning path
    session = user.learning_sessions.active.first
    return 0 unless session

    current_chapter = session.get_state('current_chapter')
    return 0 unless current_chapter

    DockerContentLibrary.learning_path_order.index(current_chapter) || 0
  end

  # Hybrid Decay: Calculate chapters completed since mastery
  def chapters_completed_since_mastery
    return 0 unless chapters_at_mastery

    current_position = current_learning_position
    [current_position - chapters_at_mastery, 0].max
  end

  private
  
  def update_context_performance(context, success)
    self.context_performance ||= {}
    self.context_performance[context.to_s] ||= { 
      'attempts' => 0, 
      'successes' => 0 
    }
    
    self.context_performance[context.to_s]['attempts'] += 1
    self.context_performance[context.to_s]['successes'] += 1 if success
  end
  
  def recalculate_proficiency_score
    # Weighted scoring based on context importance
    weights = {
      'practice' => 0.2,
      'quiz' => 0.3,
      'lab' => 0.4,
      'real_project' => 0.1
    }
    
    weighted_score = 0.0
    total_weight = 0.0
    
    (context_performance || {}).each do |context, data|
      weight = weights[context] || 0.1
      success_rate = calculate_context_success_rate(data)
      weighted_score += success_rate * weight
      total_weight += weight
    end
    
    # Fallback to overall success rate if no context data
    if total_weight.zero?
      self.proficiency_score = mastery_percentage
    else
      self.proficiency_score = (weighted_score / total_weight * 100).round(2)
    end
  end
  
  def calculate_context_success_rate(context_data)
    attempts = context_data['attempts'] || 0
    successes = context_data['successes'] || 0

    return 0.0 if attempts.zero?
    (successes.to_f / attempts)
  end

  # Hybrid Decay: Track chapter position when mastery is achieved
  def track_mastery_achievement
    if proficiency_score >= 100 && chapters_at_mastery.nil?
      self.chapters_at_mastery = current_learning_position
      self.learning_path_position = chapters_at_mastery
      Rails.logger.info "🎯 Mastery achieved for #{canonical_command} at chapter position #{chapters_at_mastery}"
    end
  end
end
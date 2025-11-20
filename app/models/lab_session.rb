class LabSession < ApplicationRecord
  belongs_to :user
  belongs_to :hands_on_lab

  # Statuses
  ACTIVE = 'active'.freeze
  COMPLETED = 'completed'.freeze
  TERMINATED = 'terminated'.freeze
  EXPIRED = 'expired'.freeze

  validates :status, inclusion: { in: [ACTIVE, COMPLETED, TERMINATED, EXPIRED] }

  scope :active, -> { where(status: ACTIVE) }
  scope :completed, -> { where(status: COMPLETED) }
  scope :recent, -> { order(created_at: :desc) }
  scope :struggling, -> { where('struggle_score >= ?', 0.6) }
  scope :flagged, -> { where(flagged_for_review: true) }
  
  serialize :metadata, JSON
  serialize :step_history, JSON
  serialize :commands_executed, JSON
  serialize :validation_results, JSON
  serialize :struggle_indicators, JSON

  after_update :record_for_adaptation!, if: :saved_change_to_struggle_score?
  after_update :update_lab_aggregate_stats!, if: :saved_change_to_passed?
  
  def active?
    status == ACTIVE
  end
  
  def completed?
    status == COMPLETED
  end
  
  def duration
    return nil unless started_at
    (ended_at || Time.current) - started_at
  end
  
  def terminate!
    update!(
      status: TERMINATED,
      ended_at: Time.current
    )
    
    # Cleanup container if exists
    cleanup_container
  end
  
  def complete!
    # Calculate struggle score before completing
    calculate_struggle_score! unless struggle_score.present?

    update!(
      status: COMPLETED,
      completed_at: Time.current
    )

    cleanup_container
  end
  
  def expired?
    return false unless active?
    created_at < 2.hours.ago
  end
  
  def increment_command_count!
    increment!(:commands_executed)
  end

  # === Struggle Detection Methods ===

  # Get the struggle analyzer for this session
  def struggle_analyzer
    @struggle_analyzer ||= LabStruggleAnalyzer.new(self)
  end

  # Calculate and update struggle score
  def calculate_struggle_score!
    score = struggle_analyzer.calculate_struggle_score
    indicators = struggle_analyzer.struggle_indicators

    update!(
      struggle_score: score,
      struggle_indicators: indicators,
      flagged_for_review: struggle_analyzer.critical_struggle?
    )

    score
  end

  # Check if user is struggling
  def struggling?
    return false unless struggle_score.present?
    struggle_score >= 0.6
  end

  # Check if struggle is critical
  def critical_struggle?
    return false unless struggle_score.present?
    struggle_score >= 0.8
  end

  # Get struggle indicators
  def get_struggle_indicators
    struggle_indicators.presence || struggle_analyzer.struggle_indicators
  end

  # Get pain points identified in this session
  def pain_points
    struggle_analyzer.identify_pain_points
  end

  # Get recommended interventions
  def recommended_interventions
    struggle_analyzer.recommended_interventions
  end

  # Record this struggle for course adaptation
  def record_for_adaptation!
    return unless struggling?

    CourseAdaptationService.record_lab_struggle(
      lab_session: self,
      struggle_score: struggle_score,
      pain_points: pain_points,
      indicators: get_struggle_indicators
    )
  end

  private

  def update_lab_aggregate_stats!
    return unless hands_on_lab.present?

    # Update aggregate struggle metrics on the lab
    hands_on_lab.update_struggle_metrics!
  end

  def cleanup_container
    return unless container_name.present?
    
    LabRunnerService.new(
      user_id: user_id, 
      lab_session_id: session_id
    ).cleanup_session
  rescue => e
    Rails.logger.error "Failed to cleanup container #{container_name}: #{e.message}"
  end
end
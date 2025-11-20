class LearningSession < ApplicationRecord
  belongs_to :user
  
  # Validations
  validates :session_id, presence: true, uniqueness: true
  validates :started_at, presence: true
  
  # Scopes
  scope :active, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :recent, -> { order(started_at: :desc) }
  scope :timed_out, -> { active.where('last_activity_at < ?', 4.hours.ago) }
  
  # Constants
  SESSION_TIMEOUT = 4.hours
  MIN_ITEMS_FOR_COMPLETION = 10
  MAX_ITEMS_PER_SESSION = 50
  
  COMPLETION_REASONS = {
    user_completed: 'user_completed',
    timeout: 'timeout',
    system_ended: 'system_ended',
    manual_exit: 'manual_exit'
  }.freeze
  
  # Callbacks
  before_validation :set_defaults, on: :create
  after_create :initialize_state_data
  
  # Class methods
  def self.create_for_user!(user)
    # End any existing active sessions
    user.learning_sessions.active.update_all(
      completed_at: Time.current,
      completion_reason: COMPLETION_REASONS[:system_ended]
    )
    
    # Create new session
    create!(
      user: user,
      session_id: generate_session_id,
      started_at: Time.current,
      last_activity_at: Time.current,
      state_data: initial_state_data,
      performance_metrics: initial_metrics
    )
  end
  
  def self.find_or_create_active(user)
    active_session = user.learning_sessions.active
                         .where('last_activity_at > ?', SESSION_TIMEOUT.ago)
                         .first
    
    active_session || create_for_user!(user)
  end
  
  # Instance methods
  def active?
    completed_at.nil? && last_activity_at > SESSION_TIMEOUT.ago
  end
  
  def expired?
    completed_at.nil? && last_activity_at <= SESSION_TIMEOUT.ago
  end
  
  def complete!(reason = COMPLETION_REASONS[:user_completed])
    update!(
      completed_at: Time.current,
      completion_reason: reason
    )
  end
  
  def touch_activity!
    update!(last_activity_at: Time.current)
  end
  
  def record_response(item_id, correct, response_time = nil)
    touch_activity!
    
    # Update counters
    increment!(:items_presented)
    if correct
      increment!(:items_correct)
    else
      increment!(:items_failed)
    end
    
    # Update state data
    responses = state_data['responses'] || []
    responses << {
      'item_id' => item_id,
      'correct' => correct,
      'response_time' => response_time,
      'timestamp' => Time.current.iso8601
    }
    
    update!(state_data: state_data.merge('responses' => responses))
    
    # Update performance metrics
    update_performance_metrics!
  end
  
  def accuracy_rate
    return 0 if items_presented.zero?
    (items_correct.to_f / items_presented * 100).round(1)
  end
  
  def current_streak
    return 0 if state_data['responses'].blank?
    
    streak = 0
    state_data['responses'].reverse_each do |response|
      break unless response['correct']
      streak += 1
    end
    streak
  end
  
  def should_complete?
    items_presented >= MAX_ITEMS_PER_SESSION ||
      (items_presented >= MIN_ITEMS_FOR_COMPLETION && accuracy_rate >= 90)
  end
  
  def session_duration
    end_time = completed_at || Time.current
    ((end_time - started_at) / 60).round # in minutes
  end
  
  def update_state(key, value)
    updated_state = state_data.merge(key => value)
    update!(state_data: updated_state)
  end
  
  def get_state(key, default = nil)
    state_data[key] || default
  end
  
  def mark_micro_complete(chapter, micro_id)
    completed = state_data['completed_micros'] || {}
    completed[chapter] ||= []
    completed[chapter] << micro_id unless completed[chapter].include?(micro_id)
    
    update_state('completed_micros', completed)
  end
  
  def is_micro_completed?(chapter, micro_id)
    completed = state_data['completed_micros'] || {}
    (completed[chapter] || []).include?(micro_id)
  end
  
  def chapter_progress(chapter)
    completed = (state_data['completed_micros'] || {})[chapter] || []
    completed.length
  end
  
  private
  
  def self.generate_session_id
    "LS-#{SecureRandom.hex(8)}-#{Time.current.to_i}"
  end
  
  def set_defaults
    self.started_at ||= Time.current
    self.last_activity_at ||= Time.current
    self.state_data ||= {}
    self.performance_metrics ||= {}
  end
  
  def initialize_state_data
    update!(state_data: initial_state_data) if state_data.blank?
  end
  
  def self.initial_state_data
    {
      'current_state' => 'START',
      'current_item_id' => nil,
      'current_item_type' => nil,
      'current_chapter' => nil,
      'current_micro' => nil,
      'completed_micros' => {},
      'responses' => [],
      'weakness_areas' => [],
      'review_items' => [],
      'completed_items' => [],
      'skipped_items' => []
    }
  end
  
  def initial_state_data
    self.class.initial_state_data
  end
  
  def self.initial_metrics
    {
      'max_streak' => 0,
      'avg_response_time' => 0,
      'difficulty_progression' => [],
      'topic_coverage' => {},
      'mastery_improvements' => []
    }
  end
  
  def initial_metrics
    self.class.initial_metrics
  end
  
  def update_performance_metrics!
    metrics = performance_metrics || {}
    
    # Update max streak
    current = current_streak
    metrics['max_streak'] = [metrics['max_streak'].to_i, current].max
    
    # Calculate average response time
    if state_data['responses'].present?
      times = state_data['responses'].map { |r| r['response_time'] }.compact
      if times.any?
        metrics['avg_response_time'] = (times.sum.to_f / times.size).round(2)
      end
    end
    
    # Track topic coverage
    if state_data['current_item_type'].present?
      topic = state_data['current_item_type']
      metrics['topic_coverage'] ||= {}
      metrics['topic_coverage'][topic] ||= 0
      metrics['topic_coverage'][topic] += 1
    end
    
    update!(performance_metrics: metrics)
  end
end
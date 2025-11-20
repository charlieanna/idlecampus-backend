class LearningEvent < ApplicationRecord
  belongs_to :user
  
  # JSON serialization for SQLite text columns
  serialize :event_data, JSON
  serialize :skill_dimensions, JSON
  
  # Validations
  validates :event_type, presence: true
  validates :event_category, presence: true
  validates :event_data, presence: true
  
  # Scopes
  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :by_type, ->(type) { where(event_type: type) }
  scope :by_category, ->(category) { where(event_category: category) }
  scope :recent, -> { order(created_at: :desc) }
  scope :today, -> { where('created_at >= ?', Time.current.beginning_of_day) }
  scope :this_week, -> { where('created_at >= ?', Time.current.beginning_of_week) }
  
  # Event types
  EVENT_TYPES = %w[
    quiz_started
    quiz_question_answered
    quiz_completed
    lesson_started
    lesson_completed
    lab_started
    lab_step_completed
    lab_hint_used
    lab_completed
    module_started
    module_completed
    course_enrolled
    review_completed
    ab_test_assigned
    ab_test_metric
  ].freeze
  
  # Event categories
  EVENT_CATEGORIES = %w[
    learning
    assessment
    practice
    review
    achievement
    experiment
  ].freeze
  
  validates :event_type, inclusion: { in: EVENT_TYPES }
  validates :event_category, inclusion: { in: EVENT_CATEGORIES }
  
  # Helper to create events
  def self.track(user:, type:, category:, data: {}, skill_dimensions: nil, performance: nil, time_spent: nil)
    create!(
      user: user,
      event_type: type,
      event_category: category,
      event_data: data,
      skill_dimensions: skill_dimensions,
      performance_score: performance,
      time_spent_seconds: time_spent
    )
  end
end


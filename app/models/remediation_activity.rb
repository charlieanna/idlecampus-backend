class RemediationActivity < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :quiz_attempt
  belongs_to :quiz_question
  belongs_to :course_lesson
  
  # Validations
  validates :user_id, presence: true
  validates :quiz_attempt_id, presence: true
  validates :quiz_question_id, presence: true
  validates :course_lesson_id, presence: true
  
  # Scopes
  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :reviewed, -> { where(lesson_reviewed: true) }
  scope :improved, -> { where(improved_on_retry: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_topic, ->(topic) { 
    joins(:quiz_question).where(quiz_questions: { topic: topic }) 
  }
  scope :since, ->(date) { where('created_at >= ?', date) }
  
  # Class methods
  def self.effectiveness_rate(user_id: nil, topic: nil)
    scope = all
    scope = scope.for_user(user_id) if user_id
    scope = scope.by_topic(topic) if topic
    
    total = scope.reviewed.count
    return 0.0 if total.zero?
    
    improved = scope.improved.count
    (improved.to_f / total * 100).round(2)
  end
  
  def self.most_reviewed_lessons(limit: 10)
    select('course_lesson_id, COUNT(*) as review_count')
      .group(:course_lesson_id)
      .order('review_count DESC')
      .limit(limit)
  end
  
  # Instance methods
  def mark_as_reviewed!
    update!(lesson_reviewed: true)
  end
  
  def mark_improvement!(improved:)
    update!(improved_on_retry: improved)
  end
  
  def time_to_review
    return nil unless lesson_reviewed
    created_at
  end
end


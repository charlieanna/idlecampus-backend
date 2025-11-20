class Quiz < ApplicationRecord
  # Quiz Type Constants
  QUIZ_TYPES = {
    standard: 'standard',
    review_session: 'review_session',
    topic_deepdive: 'topic_deepdive',
    mastery_challenge: 'mastery_challenge'
  }.freeze

  # Assessment Level Constants
  ASSESSMENT_LEVELS = %w[microlesson module multi_module course adaptive].freeze

  # Associations
  has_many :quiz_question_pools, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy
  has_many :module_items, as: :item, dependent: :destroy
  has_many :course_modules, through: :module_items
  has_many :quiz_attempts, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :passing_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :quiz_type, inclusion: { in: QUIZ_TYPES.values }, allow_nil: true
  validates :assessment_level, inclusion: { in: ASSESSMENT_LEVELS }, allow_nil: true

  # Scopes
  scope :microlesson_level, -> { where(assessment_level: 'microlesson') }
  scope :module_level, -> { where(assessment_level: 'module') }
  scope :multi_module_level, -> { where(assessment_level: 'multi_module') }
  scope :course_level, -> { where(assessment_level: 'course') }
  scope :adaptive_level, -> { where(assessment_level: 'adaptive') }
  scope :with_questions, -> { includes(:quiz_questions) }
  scope :review_sessions, -> { where(quiz_type: QUIZ_TYPES[:review_session]) }
  scope :topic_deepdives, -> { where(quiz_type: QUIZ_TYPES[:topic_deepdive]) }
  scope :mastery_challenges, -> { where(quiz_type: QUIZ_TYPES[:mastery_challenge]) }
  scope :practice_quizzes, -> { where(quiz_type: [QUIZ_TYPES[:review_session], QUIZ_TYPES[:topic_deepdive], QUIZ_TYPES[:mastery_challenge]]) }
  
  # Instance methods
  def total_questions
    quiz_questions.count
  end
  
  def total_points
    quiz_questions.sum(:points)
  end
  
  def questions_by_difficulty(difficulty)
    quiz_questions.where(difficulty_level: difficulty)
  end
  
  def best_attempt_for(user)
    quiz_attempts.where(user: user, passed: true).order(score: :desc).first
  end
  
  def attempts_for(user)
    quiz_attempts.where(user: user).order(attempt_number: :asc)
  end
  
  def attempts_count_for(user)
    quiz_attempts.where(user: user).count
  end
  
  def passed_by?(user)
    quiz_attempts.exists?(user: user, passed: true)
  end
  
  def can_attempt?(user)
    return true if max_attempts.nil?
    attempts_count_for(user) < max_attempts
  end
  
  def next_attempt_number_for(user)
    attempts_count_for(user) + 1
  end
  
  def randomized_questions
    shuffle_questions ? quiz_questions.order('RANDOM()') : quiz_questions.order(:sequence_order)
  end
  
  def calculate_score(answers)
    correct = 0
    total = quiz_questions.count
    
    quiz_questions.each do |question|
      user_answer = answers[question.id.to_s]
      correct += 1 if question.correct_answer?(user_answer)
    end
    
    total.positive? ? (correct.to_f / total * 100).round : 0
  end
  
  def time_limit_display
    return "No time limit" unless time_limit_minutes
    "#{time_limit_minutes} minutes"
  end
  
  def course
    course_modules.first&.course
  end
  
  def adaptive_retry?
    metadata.present? && metadata['adaptive_retry'] == true
  end
  
  def parent_quiz
    return nil unless metadata.present? && metadata['parent_quiz_id']
    Quiz.find_by(id: metadata['parent_quiz_id'])
  end

  # Quiz type helpers
  def review_session?
    quiz_type == QUIZ_TYPES[:review_session]
  end

  def topic_deepdive?
    quiz_type == QUIZ_TYPES[:topic_deepdive]
  end

  def mastery_challenge?
    quiz_type == QUIZ_TYPES[:mastery_challenge]
  end

  def practice_quiz?
    review_session? || topic_deepdive? || mastery_challenge?
  end

  def timed?
    time_limit_minutes.present? && time_limit_minutes > 0
  end

  def time_limit_seconds
    timed? ? time_limit_minutes * 60 : nil
  end

  # Assessment level helpers
  def microlesson_level?
    assessment_level == 'microlesson'
  end

  def module_level?
    assessment_level == 'module'
  end

  def multi_module_level?
    assessment_level == 'multi_module'
  end

  def course_level?
    assessment_level == 'course'
  end

  def adaptive_level?
    assessment_level == 'adaptive'
  end

  def source_modules
    return [] if source_module_ids.blank?
    CourseModule.where(id: source_module_ids)
  end

  def adaptive_enabled?
    adaptive_level? && adaptive_config.present?
  end
end
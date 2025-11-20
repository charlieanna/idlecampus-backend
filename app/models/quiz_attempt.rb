class QuizAttempt < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :quiz
  belongs_to :course_enrollment, optional: true
  has_many :remediation_activities, dependent: :destroy
  
  # Validations
  validates :attempt_number, presence: true, numericality: { greater_than: 0 }
  
  # Scopes
  scope :completed, -> { where.not(completed_at: nil) }
  scope :passed, -> { where(passed: true) }
  scope :failed, -> { where(passed: false) }
  scope :for_quiz, ->(quiz_id) { where(quiz_id: quiz_id) }
  scope :ordered, -> { order(attempt_number: :asc) }
  
  # Callbacks
  before_create :set_attempt_number
  after_save :schedule_spaced_repetition, if: :saved_change_to_passed?
  after_save :update_module_progress, if: :saved_change_to_passed?
  after_save :update_review_session_fsrs, if: -> { quiz.review_session? && completed_at.present? }
  
  # Instance methods
  def start!
    update(started_at: Time.current)
  end
  
  def submit!(user_answers)
    self.answers = user_answers
    self.completed_at = Time.current
    self.time_taken_seconds = (completed_at - started_at).to_i if started_at
    
    calculate_results!
    save!
    
    award_points if passed?
    self
  end
  
  def calculate_results!
    self.total_questions = quiz.quiz_questions.count
    self.correct_answers = count_correct_answers
    self.score = calculate_score
    self.passed = score >= quiz.passing_score
  end
  
  def count_correct_answers
    correct = 0
    quiz.quiz_questions.each do |question|
      user_answer = answers[question.id.to_s]
      correct += 1 if question.correct_answer?(user_answer)
    end
    correct
  end
  
  def calculate_score
    return 0 if total_questions.zero?
    (correct_answers.to_f / total_questions * 100).round
  end
  
  def incorrect_questions
    quiz.quiz_questions.select do |question|
      user_answer = answers[question.id.to_s]
      !question.correct_answer?(user_answer)
    end
  end
  
  def correct_questions
    quiz.quiz_questions.select do |question|
      user_answer = answers[question.id.to_s]
      question.correct_answer?(user_answer)
    end
  end
  
  def answer_for(question)
    answers[question.id.to_s]
  end
  
  def time_taken_display
    return "N/A" unless time_taken_seconds
    
    minutes = time_taken_seconds / 60
    seconds = time_taken_seconds % 60
    "#{minutes}m #{seconds}s"
  end
  
  def score_badge_class
    if passed?
      'badge-success'
    elsif score >= 50
      'badge-warning'
    else
      'badge-danger'
    end
  end
  
  def performance_level
    case score
    when 90..100 then 'Excellent'
    when 80...90 then 'Very Good'
    when 70...80 then 'Good'
    when 60...70 then 'Pass'
    else 'Needs Improvement'
    end
  end
  
  private
  
  def set_attempt_number
    self.attempt_number ||= quiz.next_attempt_number_for(user)
  end
  
  def award_points
    return unless course_enrollment
    
    # Base points from quiz questions
    points = quiz.quiz_questions.sum(:points)
    
    # Bonus for first attempt pass
    points = (points * 1.5).round if attempt_number == 1
    
    # Bonus for perfect score
    points = (points * 1.2).round if score == 100
    
    course_enrollment.add_points(points)
    
    # Update user stats
    user_stat = user.user_stat || user.create_user_stat
    user_stat.increment!(:quizzes_passed)
    user_stat.increment!(:total_points, points)
  end
  
  def schedule_spaced_repetition
    return unless passed? == false # Only schedule reviews for failed attempts
    
    incorrect_questions.each do |question|
      SpacedRepetitionItem.find_or_create_by(
        user: user,
        item_type: 'QuizQuestion',
        item_id: question.id
      ) do |item|
        item.next_review_at = 1.day.from_now
        item.review_count = 0
        item.ease_factor = 2.5
      end
    end
  end
  
  def update_module_progress
    return unless passed? && course_enrollment

    # Find the module that contains this quiz
    module_item = quiz.module_items.first
    return unless module_item

    course_module = module_item.course_module
    progress = ModuleProgress.find_or_create_by(
      user: user,
      course_module: course_module,
      course_enrollment: course_enrollment
    )

    progress.calculate_completion!
  end

  def update_review_session_fsrs
    # Update FSRS scheduling for review session quizzes
    return unless quiz.metadata.present? && quiz.metadata['review_item_ids'].present?

    review_item_ids = quiz.metadata['review_item_ids']

    quiz.quiz_questions.each do |question|
      # Find the corresponding spaced repetition item
      review_item = SpacedRepetitionItem.find_by(
        user: user,
        item_type: 'QuizQuestion',
        item_id: question.id,
        id: review_item_ids
      )

      next unless review_item

      # Determine performance
      user_answer = answers[question.id.to_s]
      correct = question.correct_answer?(user_answer)

      # Grade: 1=again, 2=hard, 3=good, 4=easy
      grade = if correct
                score >= 90 ? 4 : 3  # Easy if high score, good otherwise
              else
                1  # Again for incorrect
              end

      # Update FSRS scheduling
      review_item.update_fsrs_schedule!(grade)

      Rails.logger.info "✅ Updated FSRS for question #{question.id}: grade=#{grade}, next_review=#{review_item.next_review_at}"
    end

    Rails.logger.info "📅 FSRS scheduling updated for #{quiz.title} review session"
  end
end
class ProblemAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :problem

  # Validations
  validates :user_id, presence: true
  validates :problem_id, presence: true

  # Scopes
  scope :successful, -> { where(success: true) }
  scope :failed, -> { where(success: false) }
  scope :struggling, -> { where(confidence_level: ['struggling', 'gave_up']) }
  scope :recent, -> { order(created_at: :desc) }
  scope :for_topic, ->(topic) { joins(:problem).where(problems: { topic: topic }) }
  scope :for_difficulty, ->(difficulty) { joins(:problem).where(problems: { difficulty: difficulty }) }

  # Callbacks
  before_save :calculate_confidence_level, if: :will_save_change_to_success?
  after_create :update_problem_statistics
  after_create :update_learning_path

  # Instance methods

  # Determine if user is struggling based on multiple factors
  def struggling?
    struggle_score > 0.6
  end

  # Calculate struggle score (0.0 to 1.0)
  def struggle_score
    score = 0.0

    # Multiple failed attempts
    score += 0.3 if attempts_count >= 3
    score += 0.5 if attempts_count >= 5

    # Used many hints
    score += 0.2 if hints_used >= 2
    score += 0.3 if hints_used >= 4

    # Gave up or viewed solution
    score += 0.5 if gave_up
    score += 0.4 if viewed_solution

    # Many errors
    total_errors = syntax_errors + logic_errors + compilation_errors
    score += 0.2 if total_errors >= 3
    score += 0.4 if total_errors >= 6

    # Took very long time (if problem has estimated time)
    if problem.estimated_time_mins && time_spent_seconds
      time_ratio = (time_spent_seconds / 60.0) / problem.estimated_time_mins
      score += 0.3 if time_ratio > 2.0
      score += 0.5 if time_ratio > 3.0
    end

    # Failed and gave up
    score = 1.0 if !success && gave_up

    [score, 1.0].min
  end

  # Get recommended next action
  def recommended_next_action
    if struggling?
      {
        action: 'review_prerequisites',
        message: 'Let\'s build a stronger foundation first',
        problems: get_prerequisite_recommendations
      }
    elsif !success && attempts_count < 3
      {
        action: 'try_again',
        message: 'You\'re making progress! Try again with a hint',
        hint_number: hints_used + 1
      }
    elsif !success && attempts_count >= 3
      {
        action: 'try_easier',
        message: 'Let\'s try a similar but easier problem',
        problems: get_easier_alternatives
      }
    elsif success && confidence_level == 'confident'
      {
        action: 'advance',
        message: 'Great job! Ready for the next challenge?',
        problems: get_next_problems
      }
    else
      {
        action: 'practice_more',
        message: 'Good! Let\'s practice similar problems',
        problems: get_similar_problems
      }
    end
  end

  # Get prerequisite problems user should review
  def get_prerequisite_recommendations
    # Get explicitly defined prerequisites
    prereqs = problem.get_prerequisites

    # If no explicit prerequisites, get easier problems in same topic
    if prereqs.empty?
      prereqs = Problem.where(topic: problem.topic, difficulty: 'easy')
                      .where.not(id: user.completed_problem_ids)
                      .limit(3)
    end

    # Also get easier problems in same family
    family_prereqs = problem.family_problems
                           .where("difficulty_level < ?", problem.difficulty_level)
                           .where.not(id: user.completed_problem_ids)
                           .limit(2)

    (prereqs + family_prereqs).uniq.first(5)
  end

  # Get easier alternative problems
  def get_easier_alternatives
    # Get easier problems in same family
    easier_in_family = problem.family_problems
                             .where("difficulty_level < ?", problem.difficulty_level)
                             .where.not(id: user.attempted_problem_ids)
                             .limit(3)

    # Get easier problems with same tags
    similar_tags = problem.tags.first(3)
    easier_similar = Problem.where("tags && ARRAY[?]::varchar[]", similar_tags)
                           .where("difficulty_level < ?", problem.difficulty_level)
                           .where.not(id: user.attempted_problem_ids)
                           .limit(2)

    (easier_in_family + easier_similar).uniq.first(5)
  end

  # Get next problems to advance
  def get_next_problems
    # Try next in family first
    next_in_family = problem.next_in_family

    recommendations = []
    recommendations << next_in_family if next_in_family

    # Get related problems
    recommendations += problem.get_related_problems.limit(2)

    # Get similar difficulty in same topic
    recommendations += Problem.by_topic(problem.topic)
                             .by_difficulty(problem.difficulty)
                             .where.not(id: user.attempted_problem_ids)
                             .limit(2)

    recommendations.uniq.first(5)
  end

  # Get similar problems for practice
  def get_similar_problems
    problem.family_problems
          .where(difficulty: problem.difficulty)
          .where.not(id: user.attempted_problem_ids)
          .limit(5)
  end

  # Time spent in minutes
  def time_spent_mins
    return nil unless time_spent_seconds
    (time_spent_seconds / 60.0).round(2)
  end

  # Check if this was quick solve
  def quick_solve?
    return false unless success && problem.estimated_time_mins && time_spent_seconds

    time_ratio = (time_spent_seconds / 60.0) / problem.estimated_time_mins
    time_ratio < 0.5
  end

  private

  def calculate_confidence_level
    self.confidence_level = if gave_up
                             'gave_up'
                           elsif struggle_score > 0.7
                             'struggling'
                           elsif struggle_score > 0.4
                             'uncertain'
                           else
                             'confident'
                           end
  end

  def update_problem_statistics
    problem.record_attempt(
      success: success,
      time_spent_mins: time_spent_mins || 0
    )
  end

  def update_learning_path
    learning_path = user.learning_path || user.create_learning_path
    learning_path.process_attempt(self)
  end
end

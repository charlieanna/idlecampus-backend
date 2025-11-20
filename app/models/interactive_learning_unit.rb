class InteractiveLearningUnit < ApplicationRecord
  # Associations
  has_many :learning_unit_progresses, dependent: :destroy
  has_many :users, through: :learning_unit_progresses
  has_many :module_interactive_units, dependent: :destroy
  has_many :course_modules, through: :module_interactive_units
  
  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :concept_explanation, presence: true
  validates :command_to_learn, presence: true
  validates :difficulty_level, inclusion: { in: %w[easy medium hard] }
  validates :estimated_minutes, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :quiz_question_type, inclusion: { in: %w[mcq true_false fill_in_blank] }, allow_nil: true
  
  # Scopes
  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(sequence_order: :asc) }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_difficulty, ->(level) { where(difficulty_level: level) }
  
  # Callbacks
  before_validation :generate_slug, if: -> { slug.blank? && title.present? }
  
  # Instance methods
  
  # Check if user has completed this unit
  def completed_by?(user)
    return false unless user
    progress = learning_unit_progresses.find_by(user: user)
    progress&.completed?
  end
  
  # Get or create progress record for user
  def progress_for(user)
    return nil unless user
    learning_unit_progresses.find_or_create_by(user: user)
  end
  
  # Calculate completion percentage for user
  def completion_percentage(user)
    progress = progress_for(user)
    return 0 unless progress
    
    components = [
      progress.explanation_read,
      progress.practice_completed,
      progress.quiz_answered,
      progress.scenario_completed
    ]
    
    completed_count = components.count(true)
    (completed_count.to_f / components.size * 100).round
  end
  
  # Check if user can access this unit (prerequisites met)
  def accessible_by?(user)
    return true if prerequisites.blank?
    
    prerequisites.all? do |prereq_slug|
      prereq_unit = InteractiveLearningUnit.find_by(slug: prereq_slug)
      prereq_unit.nil? || prereq_unit.completed_by?(user)
    end
  end
  
  # Get next unit in sequence
  def next_unit
    InteractiveLearningUnit.published
                          .where('sequence_order > ?', sequence_order)
                          .order(sequence_order: :asc)
                          .first
  end
  
  # Get previous unit in sequence
  def previous_unit
    InteractiveLearningUnit.published
                          .where('sequence_order < ?', sequence_order)
                          .order(sequence_order: :desc)
                          .first
  end
  
  # Validate quiz answer
  def validate_quiz_answer(user_answer)
    return false if quiz_correct_answer.blank?
    
    case quiz_question_type
    when 'mcq', 'fill_in_blank'
      user_answer.to_s.strip.downcase == quiz_correct_answer.to_s.strip.downcase
    when 'true_false'
      user_answer.to_s.downcase == quiz_correct_answer.to_s.downcase
    else
      false
    end
  end
  
  # Validate practice command
  def validate_practice_command(user_command)
    return false if user_command.blank?
    
    user_cmd = user_command.strip
    main_cmd = command_to_learn.strip
    
    # Check exact match
    return true if user_cmd == main_cmd
    
    # Check variations
    return true if command_variations.any? { |var| user_cmd == var.strip }
    
    false
  end
  
  # Get progressive hint based on attempt number
  def get_hint(attempt_number)
    return nil if practice_hints.blank?
    
    index = [attempt_number - 1, practice_hints.length - 1].min
    practice_hints[index] if index >= 0
  end
  
  # Calculate mastery score for a user
  def calculate_mastery(user)
    progress = progress_for(user)
    return 0.0 unless progress
    
    score = 0.0
    
    # Explanation read: 10%
    score += 0.1 if progress.explanation_read
    
    # Practice completed correctly: 30%
    if progress.practice_completed && progress.practice_correct
      # Bonus for fewer attempts
      attempts_penalty = [progress.practice_attempts - 1, 3].min * 0.05
      score += [0.3 - attempts_penalty, 0.1].max
    end
    
    # Quiz answered correctly: 30%
    if progress.quiz_answered && progress.quiz_correct
      attempts_penalty = [progress.quiz_attempts - 1, 3].min * 0.05
      score += [0.3 - attempts_penalty, 0.1].max
    end
    
    # Scenario completed: 30%
    if progress.scenario_completed
      attempts_penalty = [progress.scenario_attempts - 1, 3].min * 0.05
      score += [0.3 - attempts_penalty, 0.1].max
    end
    
    score
  end
  
  # Award XP to user based on completion
  def award_xp(user)
    base_xp = case difficulty_level
    when 'easy' then 50
    when 'medium' then 75
    when 'hard' then 100
    else 50
    end
    
    progress = progress_for(user)
    mastery = progress&.mastery_score || 0.0
    
    # Award more XP for higher mastery
    (base_xp * (0.5 + mastery * 0.5)).to_i
  end
  
  private
  
  def generate_slug
    self.slug = title.parameterize
  end
end


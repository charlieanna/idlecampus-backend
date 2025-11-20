class QuizQuestion < ApplicationRecord
  # Serialization (for TEXT fields that store JSON)
  serialize :options, JSON
  # Note: sequence_items and concept_tags are already JSON type columns

  # Associations
  belongs_to :quiz
  has_many :quiz_question_lesson_mappings, dependent: :destroy
  has_many :course_lessons, through: :quiz_question_lesson_mappings
  has_many :remediation_activities, dependent: :destroy

  # Validations
  validates :question_text, presence: true
  validates :question_type, presence: true, inclusion: { in: %w[mcq fill_blank command true_false numerical equation_balance sequence] }
  validates :difficulty_level, inclusion: { in: %w[easy medium hard] }, allow_nil: true
  validates :points, numericality: { greater_than: 0 }

  # Chemistry-specific validations
  validates :tolerance, numericality: { greater_than_or_equal_to: 0 }, if: -> { question_type == 'numerical' }
  validates :sequence_items, presence: true, if: -> { question_type == 'sequence' }
  validate :validate_sequence_items_format, if: -> { question_type == 'sequence' }
  validate :validate_mcq_multiple_correct, if: -> { question_type == 'mcq' && multiple_correct? }
  
  # Adaptive learning metadata validations
  validates :difficulty, presence: true, numericality: { greater_than_or_equal_to: -3.0, less_than_or_equal_to: 3.0 }
  validates :discrimination, presence: true, numericality: { greater_than_or_equal_to: 0.1, less_than_or_equal_to: 3.0 }
  validates :guessing, presence: true, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 0.5 }
  
  # Scopes
  scope :by_type, ->(type) { where(question_type: type) }
  scope :by_difficulty, ->(level) { where(difficulty_level: level) }
  scope :ordered, -> { order(sequence_order: :asc, id: :asc) }
  scope :by_topic, ->(topic) { where(topic: topic) }
  scope :by_skill_dimension, ->(dimension) { where(skill_dimension: dimension) }
  scope :for_adaptive, ->(ability, exclude_ids: []) {
    # Select questions near user's ability (+/- 1.5 logits)
    where.not(id: exclude_ids)
      .where('difficulty BETWEEN ? AND ?', ability - 1.5, ability + 1.5)
  }
  
  # Instance methods
  def correct_answer?(user_answer)
    return false if user_answer.blank?

    case question_type
    when 'mcq'
      mcq_correct?(user_answer)
    when 'fill_blank'
      fill_blank_correct?(user_answer)
    when 'command'
      command_correct?(user_answer)
    when 'true_false'
      true_false_correct?(user_answer)
    when 'numerical'
      numerical_correct?(user_answer)
    when 'equation_balance'
      equation_balance_correct?(user_answer)
    when 'sequence'
      sequence_correct?(user_answer)
    else
      false
    end
  end
  
  def correct_option
    return nil unless question_type == 'mcq'
    parsed_options.find { |opt| opt['correct'] == true || opt['correct'] == 'true' }
  end

  def shuffled_options
    return parsed_options unless question_type == 'mcq'
    parsed_options.shuffle
  end

  # Helper method to parse options (handles both array and JSON string, and symbol/string keys)
  def parsed_options
    return [] unless options.present?

    opts = if options.is_a?(Array)
             options
           elsif options.is_a?(String)
             begin
               JSON.parse(options)
             rescue JSON::ParserError
               []
             end
           else
             []
           end

    # Normalize symbol keys to string keys
    opts.map do |opt|
      next opt unless opt.is_a?(Hash)

      opt.transform_keys(&:to_s)
    end.compact
  end
  
  def formatted_correct_answer
    case question_type
    when 'mcq'
      correct_option&.dig('text')
    when 'fill_blank', 'command'
      correct_answer
    when 'true_false'
      correct_answer == 'true' ? 'True' : 'False'
    end
  end
  
  def difficulty_badge_class
    case difficulty_level
    when 'easy'
      'badge-success'
    when 'medium'
      'badge-warning'
    when 'hard'
      'badge-danger'
    else
      'badge-secondary'
    end
  end
  
  private
  
  def mcq_correct?(user_answer)
    opts = parsed_options
    return false if opts.empty?

    if multiple_correct?
      # For multi-correct MCQs (IIT JEE style)
      # user_answer should be an array of indices or texts
      user_answers = user_answer.is_a?(Array) ? user_answer : user_answer.to_s.split(',').map(&:strip)
      correct_options = opts.select { |opt| opt['correct'] == true || opt['correct'] == 'true' }

      # Normalize user answers to indices
      user_indices = user_answers.map do |ans|
        if ans.to_i.to_s == ans.to_s
          ans.to_i
        else
          opts.index { |opt| opt['text'].to_s.strip.downcase == ans.to_s.strip.downcase }
        end
      end.compact.sort

      correct_indices = correct_options.map { |opt| opts.index(opt) }.sort

      user_indices == correct_indices
    else
      # Single correct answer
      correct_opt = correct_option
      return false unless correct_opt

      # User answer could be the option text or index
      user_answer.to_s.strip.downcase == correct_opt['text'].to_s.strip.downcase ||
        user_answer.to_i == opts.index(correct_opt)
    end
  end
  
  def fill_blank_correct?(user_answer)
    # Normalize both answers for comparison
    normalized_user = user_answer.to_s.strip.downcase
    normalized_correct = correct_answer.to_s.strip.downcase
    
    # Check for exact match first
    return true if normalized_user == normalized_correct
    
    # Check if correct_answer contains multiple acceptable answers (pipe-separated)
    acceptable_answers = normalized_correct.split('|').map(&:strip)
    acceptable_answers.any? { |ans| normalized_user == ans }
  end
  
  def command_correct?(user_answer)
    # For command type, we want more flexible matching
    normalized_user = normalize_command(user_answer)
    normalized_correct = normalize_command(correct_answer)
    
    # Check exact match
    return true if normalized_user == normalized_correct
    
    # Check if correct_answer contains multiple acceptable commands (pipe-separated)
    acceptable_commands = correct_answer.to_s.split('|').map { |cmd| normalize_command(cmd) }
    acceptable_commands.any? { |cmd| normalized_user == cmd }
  end
  
  def true_false_correct?(user_answer)
    normalized_user = user_answer.to_s.strip.downcase
    normalized_correct = correct_answer.to_s.strip.downcase
    
    # Handle various true/false representations
    true_values = %w[true t yes y 1]
    false_values = %w[false f no n 0]
    
    user_bool = true_values.include?(normalized_user) ? 'true' : 'false'
    correct_bool = true_values.include?(normalized_correct) ? 'true' : 'false'
    
    user_bool == correct_bool
  end
  
  def normalize_command(cmd)
    # Remove extra whitespace, normalize flags order
    cmd.to_s.strip.squeeze(' ').downcase
  end

  # Chemistry question validation methods

  def numerical_correct?(user_answer)
    # Parse user answer and correct answer as floats
    begin
      user_value = Float(user_answer)
      correct_value = Float(correct_answer)
      tol = tolerance || 0.01

      # Check if answer is within tolerance
      (user_value - correct_value).abs <= tol
    rescue ArgumentError, TypeError
      false
    end
  end

  def equation_balance_correct?(user_answer)
    # Use ChemicalEquationValidator service
    ChemicalEquationValidator.new(user_answer, correct_answer).valid?
  rescue => e
    Rails.logger.error("Error validating chemical equation: #{e.message}")
    false
  end

  def sequence_correct?(user_answer)
    # user_answer should be a comma-separated string of IDs in the correct order
    # e.g., "1,3,2,4" or an array [1, 3, 2, 4]
    user_sequence = user_answer.is_a?(Array) ? user_answer : user_answer.to_s.split(',').map(&:strip)
    correct_sequence = correct_answer.to_s.split(',').map(&:strip)

    user_sequence.map(&:to_s) == correct_sequence.map(&:to_s)
  end

  # Custom validations

  def validate_sequence_items_format
    return unless sequence_items.present?

    unless sequence_items.is_a?(Array)
      errors.add(:sequence_items, 'must be an array')
      return
    end

    sequence_items.each_with_index do |item, index|
      unless item.is_a?(Hash) && item['id'].present? && item['text'].present?
        errors.add(:sequence_items, "item #{index} must have 'id' and 'text' fields")
      end
    end
  end

  def validate_mcq_multiple_correct
    return unless options.present?

    # Handle both array and JSON string formats
    opts = if options.is_a?(Array)
             options
           elsif options.is_a?(String)
             begin
               JSON.parse(options)
             rescue JSON::ParserError
               return # Invalid JSON, will be caught by other validations
             end
           else
             return
           end

    return unless opts.is_a?(Array)

    # Count correct options (handle both string and symbol keys)
    correct_count = opts.count { |opt|
      (opt.is_a?(Hash) &&
       ((opt['correct'] == true || opt['correct'] == 'true') ||
        (opt[:correct] == true || opt[:correct] == 'true')))
    }

    if correct_count < 2
      errors.add(:multiple_correct, 'should have at least 2 correct options when multiple_correct is true')
    end
  end
end
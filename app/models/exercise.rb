# frozen_string_literal: true

class Exercise < ApplicationRecord
  # Constants
  EXERCISE_TYPES = %w[terminal mcq code short_answer sandbox].freeze

  # Associations
  belongs_to :micro_lesson

  # Validations
  validates :exercise_type, presence: true, inclusion: { in: EXERCISE_TYPES }
  validates :sequence_order, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :exercise_data, presence: true

  # Custom validations
  validate :validate_exercise_data_structure

  # Scopes
  scope :ordered, -> { order(sequence_order: :asc) }
  scope :by_type, ->(type) { where(exercise_type: type) }

  # Instance methods
  def terminal?
    exercise_type == 'terminal'
  end

  def mcq?
    exercise_type == 'mcq'
  end

  def code?
    exercise_type == 'code'
  end

  def short_answer?
    exercise_type == 'short_answer'
  end

  def sandbox?
    exercise_type == 'sandbox'
  end

  def hints
    exercise_data['hints'] || []
  end

  def difficulty
    exercise_data['difficulty'] || 'medium'
  end

  private

  def validate_exercise_data_structure
    return if exercise_data.blank?

    case exercise_type
    when 'terminal'
      validate_terminal_data
    when 'mcq'
      validate_mcq_data
    when 'code'
      validate_code_data
    when 'short_answer'
      validate_short_answer_data
    when 'sandbox'
      validate_sandbox_data
    end
  end

  def validate_terminal_data
    required_keys = %w[command description]
    missing_keys = required_keys - exercise_data.keys
    errors.add(:exercise_data, "missing required keys: #{missing_keys.join(', ')}") if missing_keys.any?
  end

  def validate_mcq_data
    required_keys = %w[question options correct_answer]
    missing_keys = required_keys - exercise_data.keys
    errors.add(:exercise_data, "missing required keys: #{missing_keys.join(', ')}") if missing_keys.any?

    if exercise_data['options'].present? && !exercise_data['options'].is_a?(Array)
      errors.add(:exercise_data, 'options must be an array')
    end
  end

  def validate_code_data
    required_keys = %w[description language]
    missing_keys = required_keys - exercise_data.keys
    errors.add(:exercise_data, "missing required keys: #{missing_keys.join(', ')}") if missing_keys.any?
  end

  def validate_short_answer_data
    required_keys = %w[question]
    missing_keys = required_keys - exercise_data.keys
    errors.add(:exercise_data, "missing required keys: #{missing_keys.join(', ')}") if missing_keys.any?
  end

  def validate_sandbox_data
    required_keys = %w[description scenario]
    missing_keys = required_keys - exercise_data.keys
    errors.add(:exercise_data, "missing required keys: #{missing_keys.join(', ')}") if missing_keys.any?
  end
end

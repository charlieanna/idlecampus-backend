# frozen_string_literal: true

class QuizQuestionPool < ApplicationRecord
  # Associations
  belongs_to :quiz
  belongs_to :exercise

  # Validations
  validates :quiz_id, uniqueness: { scope: :exercise_id }
  validates :weight, numericality: { greater_than: 0 }

  # Scopes
  scope :ordered_by_weight, -> { order(weight: :desc) }
  scope :by_difficulty, ->(difficulty) { joins(:exercise).where(exercises: { exercise_type: difficulty }) }

  # Instance methods
  def effective_difficulty
    difficulty_override || exercise.difficulty
  end

  def micro_lesson
    exercise.micro_lesson
  end
end

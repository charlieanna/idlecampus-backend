# frozen_string_literal: true

class MicroLessonProgress < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :micro_lesson

  # Validations
  validates :user_id, uniqueness: { scope: :micro_lesson_id }
  validates :exercises_completed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :total_exercises, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :time_spent_seconds, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :mastery_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  # Callbacks
  before_save :check_completion
  after_save :update_module_progress

  # Scopes
  scope :completed, -> { where(completed: true) }
  scope :in_progress, -> { where(completed: false).where('exercises_completed > 0') }
  scope :not_started, -> { where(completed: false, exercises_completed: 0) }

  # Instance methods
  def completion_percentage
    return 0 if total_exercises.zero?
    (exercises_completed.to_f / total_exercises * 100).round
  end

  def mark_exercise_completed!
    increment!(:exercises_completed)
    update_total_exercises_if_needed
    check_completion
    save if changed?
  end

  def update_mastery_score!(score)
    update!(mastery_score: score)
  end

  def add_time_spent(seconds)
    increment!(:time_spent_seconds, seconds)
  end

  private

  def check_completion
    if total_exercises.positive? && exercises_completed >= total_exercises && !completed
      self.completed = true
      self.completed_at = Time.current
    end
  end

  def update_total_exercises_if_needed
    actual_total = micro_lesson.total_exercises
    self.total_exercises = actual_total if actual_total != total_exercises
  end

  def update_module_progress
    return unless completed_previously_changed? && completed?

    # Trigger module progress update
    module_progress = user.module_progresses.find_by(course_module: micro_lesson.course_module)
    module_progress&.recalculate_completion
  end
end

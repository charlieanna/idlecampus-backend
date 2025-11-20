# frozen_string_literal: true

class MilestoneExam < ApplicationRecord
  # Associations
  belongs_to :course
  belongs_to :quiz

  # Validations
  validates :title, presence: true
  validates :module_range_start, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :module_range_end, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sequence_order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :passing_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validate :end_must_be_after_start

  # Scopes
  scope :ordered, -> { order(sequence_order: :asc) }
  scope :required, -> { where(required: true) }
  scope :by_course, ->(course_id) { where(course_id: course_id) }

  # Instance methods
  def module_range
    module_range_start..module_range_end
  end

  def covered_modules
    course.course_modules.where(sequence_order: module_range)
  end

  def covered_module_count
    module_range_end - module_range_start + 1
  end

  def passed_by?(user)
    quiz.passed_by?(user)
  end

  def unlocked_for?(user)
    # Check if all required modules in range are completed
    covered_modules.all? { |mod| mod.completed_by?(user) }
  end

  def range_label
    "Modules #{module_range_start}-#{module_range_end}"
  end

  private

  def end_must_be_after_start
    return unless module_range_start.present? && module_range_end.present?

    if module_range_end < module_range_start
      errors.add(:module_range_end, 'must be greater than or equal to module_range_start')
    end
  end
end

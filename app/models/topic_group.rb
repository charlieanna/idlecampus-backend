# frozen_string_literal: true

class TopicGroup < ApplicationRecord
  # Associations
  belongs_to :course_module
  has_many :micro_lessons, dependent: :nullify

  # Validations
  validates :title, presence: true
  validates :sequence_order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Scopes
  scope :ordered, -> { order(sequence_order: :asc) }
  scope :by_module, ->(module_id) { where(course_module_id: module_id) }

  # Instance methods
  def microlessons_count
    micro_lessons.count
  end

  def published_microlessons_count
    micro_lessons.published.count
  end

  def completion_for(user)
    total = micro_lessons.published.count
    return 0 if total.zero?

    completed = micro_lessons.published.select { |ml| ml.completed_by?(user) }.count
    (completed.to_f / total * 100).round
  end
end

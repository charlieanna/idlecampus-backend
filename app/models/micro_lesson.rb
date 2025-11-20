# frozen_string_literal: true

class MicroLesson < ApplicationRecord
  # Associations
  belongs_to :course_module
  belongs_to :topic_group, optional: true
  has_many :exercises, dependent: :destroy
  has_many :micro_lesson_progresses, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :sequence_order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :estimated_minutes, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :difficulty, inclusion: { in: %w[easy medium hard] }, allow_blank: true

  # Scopes
  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(sequence_order: :asc) }
  scope :by_module, ->(module_id) { where(course_module_id: module_id) }
  scope :by_topic_group, ->(topic_group_id) { where(topic_group_id: topic_group_id) }
  scope :without_topic_group, -> { where(topic_group_id: nil) }

  # Callbacks
  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  # Instance methods
  def prerequisites
    return [] if prerequisite_ids.blank?
    MicroLesson.where(id: prerequisite_ids)
  end

  def completed_by?(user)
    micro_lesson_progresses.find_by(user: user)&.completed? || false
  end

  def progress_for(user)
    micro_lesson_progresses.find_or_initialize_by(user: user)
  end

  def total_exercises
    exercises.count
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end

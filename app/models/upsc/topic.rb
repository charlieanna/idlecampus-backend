# frozen_string_literal: true

module Upsc
  class Topic < ApplicationRecord
    self.table_name = 'upsc_topics'

    # Associations
    belongs_to :subject, class_name: 'Upsc::Subject', foreign_key: 'upsc_subject_id'
    belongs_to :parent_topic, class_name: 'Upsc::Topic', optional: true
    belongs_to :course_lesson, class_name: 'CourseLesson', optional: true
    belongs_to :course_module, class_name: 'CourseModule', optional: true

    has_many :child_topics, class_name: 'Upsc::Topic', foreign_key: 'parent_topic_id', dependent: :destroy
    has_many :user_progress, class_name: 'Upsc::UserProgress', foreign_key: 'upsc_topic_id', dependent: :destroy
    has_many :questions, class_name: 'Upsc::Question', foreign_key: 'upsc_topic_id', dependent: :nullify
    has_many :writing_questions, class_name: 'Upsc::WritingQuestion', foreign_key: 'upsc_topic_id', dependent: :nullify
    has_many :revisions, class_name: 'Upsc::Revision', foreign_key: 'upsc_topic_id', dependent: :destroy
    has_many :daily_tasks, class_name: 'Upsc::DailyTask', foreign_key: 'upsc_topic_id', dependent: :nullify

    # Validations
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: { scope: :upsc_subject_id }
    validates :difficulty_level, inclusion: { in: %w[beginner intermediate advanced] }, allow_nil: true

    # Callbacks
    before_validation :generate_slug, on: :create

    # Scopes
    scope :root_topics, -> { where(parent_topic_id: nil) }
    scope :high_yield, -> { where(is_high_yield: true) }
    scope :ordered, -> { order(:order_index) }
    scope :by_difficulty, ->(level) { where(difficulty_level: level) }

    # Instance methods
    def full_path
      path = [name]
      current = self
      while current.parent_topic
        current = current.parent_topic
        path.unshift(current.name)
      end
      path.join(' > ')
    end

    def prerequisite_topics
      return [] unless prerequisite_topic_ids.present?
      Upsc::Topic.where(id: prerequisite_topic_ids)
    end

    def completion_rate(user)
      progress = user_progress.find_by(user: user)
      progress&.completion_percentage || 0
    end

    private

    def generate_slug
      self.slug = name.parameterize if name.present? && slug.blank?
    end
  end
end

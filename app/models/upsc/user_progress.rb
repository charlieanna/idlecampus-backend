# frozen_string_literal: true

module Upsc
  class UserProgress < ApplicationRecord
    self.table_name = 'upsc_user_progress'

    # Associations
    belongs_to :user
    belongs_to :topic, class_name: 'Upsc::Topic', foreign_key: 'upsc_topic_id'

    # Validations
    validates :user, presence: true
    validates :topic, presence: true
    validates :status, inclusion: { in: %w[not_started in_progress completed mastered] }
    validates :completion_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :confidence_level, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

    # Scopes
    scope :in_progress, -> { where(status: 'in_progress') }
    scope :completed, -> { where(status: ['completed', 'mastered']) }
    scope :recently_accessed, -> { order(last_accessed_at: :desc) }
    scope :bookmarked, -> { where(bookmarked: true) }
    scope :needs_revision, -> { where('last_revised_at IS NULL OR last_revised_at < ?', 7.days.ago) }

    # Instance methods
    def start!
      self.status = 'in_progress'
      self.first_started_at ||= Time.current
      self.last_accessed_at = Time.current
      save
    end

    def mark_complete!
      self.status = 'completed'
      self.completion_percentage = 100
      self.completed_at = Time.current
      save

      # Schedule first revision
      Upsc::Revision.schedule_next_revision(user, topic) if topic
    end

    def mark_mastered!
      self.status = 'mastered'
      self.mastered_at = Time.current
      save
    end

    def update_progress(percentage)
      self.completion_percentage = [percentage, 100].min
      self.status = 'completed' if completion_percentage >= 100
      self.last_accessed_at = Time.current
      save
    end

    def record_revision
      self.revision_count += 1
      self.last_revised_at = Time.current
      save
    end

    def time_since_last_access
      return nil unless last_accessed_at
      ((Time.current - last_accessed_at) / 1.day).round
    end

    def needs_revision?
      return true if last_revised_at.nil?
      last_revised_at < 7.days.ago
    end
  end
end

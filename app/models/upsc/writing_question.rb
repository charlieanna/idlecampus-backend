# frozen_string_literal: true

module Upsc
  class WritingQuestion < ApplicationRecord
    self.table_name = 'upsc_writing_questions'

    # Associations
    belongs_to :subject, class_name: 'Upsc::Subject', foreign_key: 'upsc_subject_id', optional: true
    belongs_to :topic, class_name: 'Upsc::Topic', foreign_key: 'upsc_topic_id', optional: true
    belongs_to :created_by, class_name: 'User', optional: true

    has_many :user_answers, class_name: 'Upsc::UserAnswer', foreign_key: 'upsc_writing_question_id', dependent: :destroy

    # Validations
    validates :question_text, presence: true
    validates :question_type, inclusion: { in: %w[essay case_study general analytical] }, allow_nil: true

    # Scopes
    scope :recent, -> { order(created_at: :desc) }
    scope :pyqs, -> { where.not(pyq_year: nil) }
    scope :by_type, ->(type) { where(question_type: type) }
    scope :for_date, ->(date) { where(current_affairs_date: date) }
    scope :high_relevance, -> { where('relevance_score >= ?', 70) }

    # Instance methods
    def is_pyq?
      pyq_year.present?
    end

    def is_current_affairs?
      current_affairs_date.present?
    end

    def daily_question?
      current_affairs_date == Date.current
    end

    def average_score
      user_answers.where.not(final_score: nil).average(:final_score) || 0
    end

    def total_submissions
      user_answers.count
    end
  end
end

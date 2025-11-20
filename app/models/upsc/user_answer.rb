# frozen_string_literal: true

module Upsc
  class UserAnswer < ApplicationRecord
    self.table_name = 'upsc_user_answers'

    # Associations
    belongs_to :user
    belongs_to :writing_question, class_name: 'Upsc::WritingQuestion', foreign_key: 'upsc_writing_question_id'
    belongs_to :evaluator, class_name: 'User', optional: true
    belongs_to :original_answer, class_name: 'Upsc::UserAnswer', optional: true

    has_many :revisions, class_name: 'Upsc::UserAnswer', foreign_key: 'original_answer_id', dependent: :nullify

    # Validations
    validates :answer_text, presence: true, unless: :file_url?
    validates :submission_type, inclusion: { in: %w[typed uploaded] }
    validates :status, inclusion: { in: %w[submitted ai_evaluated mentor_review completed] }

    # Callbacks
    before_create :calculate_word_count
    after_create :enqueue_ai_evaluation

    # Scopes
    scope :pending_evaluation, -> { where(status: ['submitted', 'ai_evaluated']) }
    scope :evaluated, -> { where(status: ['mentor_review', 'completed']) }
    scope :recent, -> { order(submitted_at: :desc) }
    scope :public_answers, -> { where(is_public: true) }

    # Instance methods
    def evaluate_with_ai
      # Will be implemented with AI service
      # AiAnswerEvaluationService.new(self).evaluate
    end

    def evaluate_by_mentor(mentor, evaluation_data)
      self.evaluator = mentor
      self.mentor_evaluation = evaluation_data
      self.mentor_score = evaluation_data['total_score']
      self.mentor_evaluated_at = Time.current
      self.final_score = mentor_score
      self.status = 'completed'
      save
    end

    def is_revision?
      original_answer_id.present?
    end

    def improvement_percentage
      return nil unless is_revision? && original_answer
      return nil unless final_score && original_answer.final_score

      ((final_score - original_answer.final_score) / original_answer.final_score * 100).round(2)
    end

    private

    def calculate_word_count
      self.word_count = answer_text.split.size if answer_text.present?
    end

    def enqueue_ai_evaluation
      # Will be implemented later
      # AiEvaluationJob.perform_later(id)
    end
  end
end

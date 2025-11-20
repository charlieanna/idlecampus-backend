# frozen_string_literal: true

module Upsc
  class StudentProfile < ApplicationRecord
    self.table_name = 'upsc_student_profiles'

    # Associations
    belongs_to :user
    belongs_to :optional_subject, class_name: 'Upsc::Subject', optional: true

    # Validations
    validates :user, presence: true, uniqueness: true
    validates :attempt_number, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
    validates :medium_of_exam, inclusion: { in: %w[english hindi] }, allow_nil: true
    validates :study_hours_per_day, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 18 }, allow_nil: true

    # Callbacks
    before_create :set_defaults

    # Instance methods
    def days_until_exam
      return nil unless target_exam_date
      (target_exam_date - Date.current).to_i
    end

    def exam_phase
      days = days_until_exam
      return 'exam_passed' if days && days < 0
      return 'exam_imminent' if days && days <= 30
      return 'final_prep' if days && days <= 90
      return 'practice_phase' if days && days <= 180
      'foundation_phase'
    end

    def is_first_attempt?
      attempt_number == 1
    end

    def weak_areas
      weaknesses || []
    end

    def strong_areas
      strengths || []
    end

    private

    def set_defaults
      self.attempt_number ||= 1
      self.medium_of_exam ||= 'english'
      self.previous_attempt_details ||= {}
      self.daf_details ||= {}
      self.strengths ||= []
      self.weaknesses ||= []
    end
  end
end

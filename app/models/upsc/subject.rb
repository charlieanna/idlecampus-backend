# frozen_string_literal: true

module Upsc
  class Subject < ApplicationRecord
    self.table_name = 'upsc_subjects'

    # Associations
    has_many :topics, class_name: 'Upsc::Topic', foreign_key: 'upsc_subject_id', dependent: :destroy
    has_many :questions, class_name: 'Upsc::Question', foreign_key: 'upsc_subject_id', dependent: :nullify
    has_many :tests, class_name: 'Upsc::Test', foreign_key: 'upsc_subject_id', dependent: :nullify
    has_many :writing_questions, class_name: 'Upsc::WritingQuestion', foreign_key: 'upsc_subject_id', dependent: :nullify
    has_many :student_profiles, class_name: 'Upsc::StudentProfile', foreign_key: 'optional_subject_id', dependent: :nullify

    # Validations
    validates :name, presence: true
    validates :code, presence: true, uniqueness: true
    validates :exam_type, presence: true, inclusion: { in: %w[prelims mains both] }

    # Scopes
    scope :prelims, -> { where(exam_type: ['prelims', 'both']) }
    scope :mains, -> { where(exam_type: ['mains', 'both']) }
    scope :optional, -> { where(is_optional: true) }
    scope :active, -> { where(is_active: true) }
    scope :ordered, -> { order(:order_index) }

    # Class methods
    def self.exam_types
      %w[prelims mains both]
    end

    # Instance methods
    def prelims_subject?
      exam_type.in?(['prelims', 'both'])
    end

    def mains_subject?
      exam_type.in?(['mains', 'both'])
    end

    def root_topics
      topics.root_topics.ordered
    end

    def total_topics_count
      topics.count
    end

    def high_yield_topics_count
      topics.high_yield.count
    end

    def as_json(options = {})
      super(options.merge(
        methods: [:total_topics_count, :high_yield_topics_count],
        except: [:created_at, :updated_at]
      ))
    end
  end
end

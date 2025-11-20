# frozen_string_literal: true

module Upsc
  class TestQuestion < ApplicationRecord
    self.table_name = 'upsc_test_questions'

    # Associations
    belongs_to :test, class_name: 'Upsc::Test', foreign_key: 'upsc_test_id'
    belongs_to :question, class_name: 'Upsc::Question', foreign_key: 'upsc_question_id'

    # Validations
    validates :marks, presence: true, numericality: { greater_than: 0 }
    validates :order_index, presence: true

    # Scopes
    scope :ordered, -> { order(:order_index) }
    scope :by_section, ->(section) { where(section: section) if section.present? }
  end
end

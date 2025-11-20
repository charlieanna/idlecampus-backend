class QuizQuestionLessonMapping < ApplicationRecord
  # Associations
  belongs_to :quiz_question
  belongs_to :course_lesson
  
  # Validations
  validates :quiz_question_id, presence: true
  validates :course_lesson_id, presence: true
  validates :relevance_weight, numericality: { 
    greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 100 
  }, allow_nil: true
  validates :quiz_question_id, uniqueness: { 
    scope: :course_lesson_id, 
    message: "already mapped to this lesson" 
  }
  
  # Scopes
  scope :ordered_by_relevance, -> { order(relevance_weight: :desc) }
  scope :for_question, ->(question_id) { where(quiz_question_id: question_id) }
  scope :for_lesson, ->(lesson_id) { where(course_lesson_id: lesson_id) }
  scope :with_section, -> { where.not(section_anchor: nil) }
  
  # Instance methods
  def primary_recommendation?
    relevance_weight >= 80
  end
  
  def section_title
    return nil unless section_anchor && course_lesson.content_sections.present?
    
    section = course_lesson.content_sections.find { |s| s['id'] == section_anchor }
    section&.dig('title')
  end
  
  def lesson_url_with_anchor
    if section_anchor.present?
      "/course_lessons/#{course_lesson.id}##{section_anchor}"
    else
      "/course_lessons/#{course_lesson.id}"
    end
  end
end


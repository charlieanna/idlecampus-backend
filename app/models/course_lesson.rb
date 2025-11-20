class CourseLesson < ApplicationRecord
  has_many :lesson_completions, dependent: :destroy
  has_many :module_items, as: :item, dependent: :destroy
  has_many :course_modules, through: :module_items
  has_many :quiz_question_lesson_mappings, dependent: :destroy
  has_many :quiz_questions, through: :quiz_question_lesson_mappings
  has_many :remediation_activities, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  # Check if user has completed this lesson
  def completed_by?(user)
    lesson_completions.exists?(user_id: user.id)
  end

  # Mark lesson as completed by user
  def mark_completed!(user)
    lesson_completions.find_or_create_by(user_id: user.id) do |completion|
      completion.completed_at = Time.current
    end
  end
end


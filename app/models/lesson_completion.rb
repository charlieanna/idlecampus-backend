class LessonCompletion < ApplicationRecord
  belongs_to :user
  belongs_to :course_lesson

  validates :user_id, uniqueness: { scope: :course_lesson_id }
  
  # Alias for backward compatibility
  alias_attribute :lesson_id, :course_lesson_id

  scope :completed, -> { where.not(completed_at: nil) }
  scope :for_user, ->(user) { where(user: user) }
end


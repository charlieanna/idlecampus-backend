class UserCourseProgress < ApplicationRecord
  belongs_to :user

  validates :tag, presence: true
  validates :question_id, presence: true
  validates :user_id, uniqueness: { scope: [:tag, :question_id] }
end
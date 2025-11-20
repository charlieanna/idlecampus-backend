class UserCourseEnrollment < ApplicationRecord
  belongs_to :user

  validates :tag, presence: true
  validates :user_id, uniqueness: { scope: :tag }
end
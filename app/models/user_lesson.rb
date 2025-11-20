# app/models/user_lesson.rb
class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  # Status can be: :not_started, :done, :review_later, :important
  enum status: [:not_started, :done, :review_later, :important]

  # Implement spaced repetition logic here for the whole lesson
  def next_review_date
    case status
    when "done"
      Date.current + 1.day
    when "review_later"
      Date.current + 3.days
    when "important"
      Date.current + 7.days
    else
      Date.current
    end
  end
end

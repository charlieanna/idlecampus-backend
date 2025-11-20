# app/models/user_question.rb
class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # Status can be: :not_started, :done, :review_later, :important
  enum status: [:not_started, :done, :review_later, :important]

  # Implement spaced repetition logic here
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
  
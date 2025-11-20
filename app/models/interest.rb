# app/models/interest.rb
class Interest < ApplicationRecord
  belongs_to :user

  validates :post_id, presence: true
  validates :user_id, uniqueness: { scope: :post_id, message: "has already marked this post as interested." }
end
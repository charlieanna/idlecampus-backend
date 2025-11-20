class Post < ApplicationRecord
  has_many :interests, dependent: :destroy
  has_many :interested_users, through: :interests, source: :user
end
class ProgressiveLearningTrack < ApplicationRecord
  # Associations
  has_many :progressive_challenges
  has_many :progressive_user_track_progresses
  
  # Validations
  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true
  validates :difficulty_level, inclusion: { in: %w[fundamentals concepts systems] }
  validates :order_index, presence: true
  
  # Scopes
  scope :active, -> { where(is_active: true) }
  scope :ordered, -> { order(:order_index) }
end


class ProgressiveChallengeLevel < ApplicationRecord
  # Associations
  belongs_to :progressive_challenge
  has_many :progressive_level_attempts
  
  # Validations
  validates :level_number, inclusion: { in: 1..5 }
  validates :level_name, presence: true
  validates :xp_reward, numericality: { greater_than: 0 }
  
  # Scopes
  scope :ordered, -> { order(:level_number) }
end


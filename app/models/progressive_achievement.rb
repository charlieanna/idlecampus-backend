class ProgressiveAchievement < ApplicationRecord
  # Associations
  has_many :progressive_user_achievements
  has_many :users, through: :progressive_user_achievements
  
  # Validations
  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true
  validates :rarity, inclusion: { in: %w[common rare epic legendary] }
  validates :xp_reward, numericality: { greater_than_or_equal_to: 0 }
  
  # Scopes
  scope :active, -> { where(is_active: true) }
  scope :by_rarity, ->(rarity) { where(rarity: rarity) }
  scope :by_category, ->(category) { where(category: category) }
end


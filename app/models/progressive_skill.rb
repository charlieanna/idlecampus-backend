class ProgressiveSkill < ApplicationRecord
  # Associations
  belongs_to :parent_skill, class_name: 'ProgressiveSkill', optional: true
  has_many :child_skills, class_name: 'ProgressiveSkill', foreign_key: 'parent_skill_id'
  has_many :progressive_user_skills
  
  # Validations
  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true
  validates :max_level, numericality: { greater_than: 0 }
  
  # Scopes
  scope :root_skills, -> { where(parent_skill_id: nil) }
  scope :by_category, ->(category) { where(category: category) }
end


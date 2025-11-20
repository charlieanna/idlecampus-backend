class ModuleInteractiveUnit < ApplicationRecord
  # Associations
  belongs_to :course_module
  belongs_to :interactive_learning_unit
  
  # Validations
  validates :sequence_order, presence: true, numericality: { only_integer: true }
  validates :interactive_learning_unit_id, uniqueness: { scope: :course_module_id }
  
  # Scopes
  scope :ordered, -> { order(sequence_order: :asc) }
  scope :required_units, -> { where(required: true) }
  
  # Delegation
  delegate :title, :slug, :difficulty_level, :estimated_minutes, 
           :completed_by?, :accessible_by?, to: :interactive_learning_unit
  
  # Instance methods
  
  # Check if this unit is completed by user
  def completed_by?(user)
    interactive_learning_unit.completed_by?(user)
  end
  
  # Get progress for user
  def progress_for(user)
    interactive_learning_unit.progress_for(user)
  end
  
  # Get completion percentage for user
  def completion_percentage(user)
    interactive_learning_unit.completion_percentage(user)
  end
  
  # Display name for UI
  def display_name
    "#{sequence_order}. #{interactive_learning_unit.title}"
  end
  
  # Icon for UI
  def icon_class
    'fa-graduation-cap'
  end
  
  # Duration estimate
  def duration_estimate
    "#{interactive_learning_unit.estimated_minutes} min"
  end
end


class ModuleProgress < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :course_module
  belongs_to :course_enrollment
  
  # Validations
  validates :user_id, uniqueness: { scope: :course_module_id }
  validates :status, inclusion: { in: %w[not_started in_progress completed] }
  
  # Scopes
  scope :completed, -> { where(status: 'completed') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :not_started, -> { where(status: 'not_started') }
  
  # Callbacks
  after_update :update_enrollment_progress
  
  # Instance methods
  def start!
    return if status == 'completed'
    
    update(
      status: 'in_progress',
      started_at: Time.current
    )
  end
  
  def complete!
    return if status == 'completed'
    
    update(
      status: 'completed',
      completed_at: Time.current,
      completion_percentage: 100
    )
  end
  
  def completed?
    status == 'completed' || completed_at.present?
  end
  
  def in_progress?
    status == 'in_progress'
  end
  
  def not_started?
    status == 'not_started'
  end
  
  def calculate_completion!
    total = course_module.total_items
    return unless total.positive?
    
    completed = course_module.items_completed_by(user)
    percentage = (completed.to_f / total * 100).round
    
    new_status = determine_status(percentage, completed)
    
    update(
      items_completed: completed,
      total_items: total,
      completion_percentage: percentage,
      status: new_status,
      started_at: started_at || (completed.positive? ? Time.current : nil),
      completed_at: percentage == 100 ? Time.current : nil
    )
  end
  
  def next_item
    course_module.next_item_for(user)
  end
  
  def progress_display
    "#{items_completed}/#{total_items} items completed"
  end
  
  def completion_badge_class
    case status
    when 'completed'
      'badge-success'
    when 'in_progress'
      'badge-info'
    else
      'badge-secondary'
    end
  end
  
  private
  
  def determine_status(percentage, completed_count)
    if percentage == 100
      'completed'
    elsif completed_count.positive?
      'in_progress'
    else
      'not_started'
    end
  end
  
  def update_enrollment_progress
    course_enrollment.update_progress! if saved_change_to_status? || saved_change_to_completion_percentage?
  end
end
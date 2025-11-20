class StudyPlan < ApplicationRecord
  belongs_to :user
  belongs_to :course
  
  # Validations
  validates :title, presence: true
  validates :daily_target, presence: true, numericality: { greater_than: 0 }
  validates :weekly_target, presence: true, numericality: { in: 1..7 }
  validates :status, inclusion: { in: %w[active paused completed cancelled] }
  
  # Scopes
  scope :active, -> { where(status: 'active') }
  scope :completed, -> { where(status: 'completed') }
  
  # Callbacks
  before_create :set_defaults
  
  def milestones_array
    return [] unless milestones.present?
    JSON.parse(milestones) rescue []
  end
  
  def milestones_array=(value)
    self.milestones = value.to_json
  end
  
  def days_remaining
    return 0 unless estimated_completion_date
    (estimated_completion_date - Date.today).to_i.clamp(0, Float::INFINITY)
  end
  
  def behind_schedule?
    return false unless estimated_completion_date && start_date
    
    expected_progress = calculate_expected_progress
    progress_percentage < expected_progress
  end
  
  def ahead_of_schedule?
    return false unless estimated_completion_date && start_date
    
    expected_progress = calculate_expected_progress
    progress_percentage > expected_progress + 10 # 10% buffer
  end
  
  def update_progress!
    # Calculate progress based on course completion
    enrollment = user.course_enrollments.find_by(course: course)
    return unless enrollment
    
    self.progress_percentage = enrollment.completion_percentage
    self.actual_days_studied = calculate_actual_days_studied
    self.total_time_spent = calculate_total_time_spent
    
    # Update status if completed
    self.status = 'completed' if progress_percentage >= 100
    
    save!
  end
  
  def generate_milestones!
    return if milestones_array.any?
    
    milestones = []
    modules = course.course_modules.published.ordered
    
    modules.each_with_index do |mod, index|
      milestone_date = calculate_milestone_date(index, modules.count)
      milestones << {
        module_id: mod.id,
        title: "Complete #{mod.title}",
        target_date: milestone_date,
        completed: false,
        completed_date: nil
      }
    end
    
    # Add final milestone
    milestones << {
      title: "Complete Final Assessment",
      target_date: estimated_completion_date,
      completed: false,
      completed_date: nil
    }
    
    self.milestones_array = milestones
    save!
  end
  
  def check_and_update_milestones!
    updated_milestones = milestones_array.map do |milestone|
      if milestone['module_id'] && !milestone['completed']
        module_progress = user.module_progresses.find_by(course_module_id: milestone['module_id'])
        if module_progress&.completed?
          milestone['completed'] = true
          milestone['completed_date'] = module_progress.completed_at&.to_date&.to_s
        end
      end
      milestone
    end
    
    self.milestones_array = updated_milestones
    save!
  end
  
  def next_milestone
    milestones_array.find { |m| !m['completed'] }
  end
  
  def daily_recommendation
    if behind_schedule?
      # Increase daily target if behind
      (daily_target * 1.2).round
    elsif ahead_of_schedule?
      # Can maintain or slightly reduce
      (daily_target * 0.9).round
    else
      daily_target
    end
  end
  
  private
  
  def set_defaults
    self.start_date ||= Date.today
    self.estimated_completion_date ||= calculate_estimated_completion_date
    self.title ||= "#{course.title} Study Plan"
    self.description ||= generate_description
  end
  
  def calculate_estimated_completion_date
    return nil unless course && daily_target && weekly_target
    
    total_hours = course.estimated_hours || 20
    total_minutes = total_hours * 60
    study_minutes_per_week = daily_target * weekly_target
    weeks_needed = (total_minutes.to_f / study_minutes_per_week).ceil
    
    start_date + weeks_needed.weeks
  end
  
  def generate_description
    "Complete #{course.title} by studying #{daily_target} minutes per day, #{weekly_target} days per week"
  end
  
  def calculate_expected_progress
    return 0 unless start_date && estimated_completion_date
    
    total_days = (estimated_completion_date - start_date).to_f
    elapsed_days = (Date.today - start_date).to_f
    
    return 100 if elapsed_days >= total_days
    
    (elapsed_days / total_days * 100).round
  end
  
  def calculate_actual_days_studied
    # Count unique days with learning events
    user.learning_events
        .where('created_at >= ?', start_date)
        .where("json_extract(event_data, '$.course_id') = ?", course.id.to_s)
        .distinct
        .count('DATE(created_at)')
  end
  
  def calculate_total_time_spent
    # Sum time from learning events
    user.learning_events
        .where('created_at >= ?', start_date)
        .where("json_extract(event_data, '$.course_id') = ?", course.id.to_s)
        .sum(:time_spent_seconds) / 60 # Convert to minutes
  end
  
  def calculate_milestone_date(index, total_modules)
    return estimated_completion_date unless total_modules > 0
    
    progress_fraction = (index + 1).to_f / total_modules
    total_days = (estimated_completion_date - start_date).to_i
    milestone_days = (total_days * progress_fraction).round
    
    start_date + milestone_days.days
  end
end
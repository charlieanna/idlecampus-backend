class ContainerLabSession < ApplicationRecord
  belongs_to :user
  
  # Statuses
  ACTIVE = 'active'.freeze
  COMPLETED = 'completed'.freeze
  TERMINATED = 'terminated'.freeze
  EXPIRED = 'expired'.freeze
  
  validates :session_id, presence: true, uniqueness: { scope: :user_id }
  validates :status, inclusion: { in: [ACTIVE, COMPLETED, TERMINATED, EXPIRED] }
  
  scope :active, -> { where(status: ACTIVE) }
  scope :completed, -> { where(status: COMPLETED) }
  scope :recent, -> { order(created_at: :desc) }
  
  serialize :metadata, JSON
  
  before_validation :generate_session_id, on: :create
  
  def active?
    status == ACTIVE
  end
  
  def completed?
    status == COMPLETED
  end
  
  def duration
    return nil unless started_at
    (ended_at || Time.current) - started_at
  end
  
  def terminate!
    update!(
      status: TERMINATED,
      ended_at: Time.current
    )
    
    # Cleanup container if exists
    cleanup_container
  end
  
  def complete!
    update!(
      status: COMPLETED,
      ended_at: Time.current
    )
    
    cleanup_container
  end
  
  def expired?
    return false unless active?
    created_at < 2.hours.ago
  end
  
  def increment_command_count!
    increment!(:commands_executed)
  end
  
  private
  
  def generate_session_id
    self.session_id ||= "#{Time.current.to_i}_#{SecureRandom.hex(4)}"
  end
  
  def cleanup_container
    return unless container_name.present?
    
    LabRunnerService.new(
      user_id: user_id, 
      lab_session_id: session_id
    ).cleanup_session
  rescue => e
    Rails.logger.error "Failed to cleanup container #{container_name}: #{e.message}"
  end
end
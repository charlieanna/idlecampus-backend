class LabAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :hands_on_lab

  # Scopes
  scope :passed, -> { where(passed: true) }
  scope :failed, -> { where(passed: false) }
  scope :recent, -> { where('created_at > ?', 7.days.ago) }
  scope :for_user, ->(user) { where(user: user) }

  # Validations
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true

  # Check if user can retry this lab
  def can_retry?
    retry_locked_until.nil? || Time.current > retry_locked_until
  end

  # Lock retry for specified hours
  def lock_retry!(hours: 24)
    update!(retry_locked_until: hours.hours.from_now)
  end

  # Get time remaining until retry is allowed
  def retry_available_in
    return nil if can_retry?

    seconds = (retry_locked_until - Time.current).to_i
    hours = seconds / 3600
    minutes = (seconds % 3600) / 60

    if hours > 0
      "#{hours}h #{minutes}m"
    else
      "#{minutes}m"
    end
  end

  # Calculate pass percentage
  def pass_percentage
    return 0 if score.nil?
    threshold = hands_on_lab.pass_threshold || 70
    (score.to_f / threshold * 100).round(1)
  end

  # Get failed command details
  def failed_command_details
    return [] if failed_commands.blank?

    failed_commands.map do |cmd|
      {
        command: cmd,
        original_chapter: ReviewGenerator.get_original_chapter_slug(cmd),
        needs_review: true
      }
    end
  end
end

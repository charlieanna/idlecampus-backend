class CourseAdaptation < ApplicationRecord
  # Associations
  belongs_to :adaptable, polymorphic: true
  belongs_to :course_module, optional: true
  belongs_to :reviewed_by, class_name: 'User', optional: true

  # Validations
  validates :adaptation_type, presence: true, inclusion: {
    in: %w[add_practice add_explanation simplify_content add_hints add_examples
           restructure_content add_prerequisites add_resources]
  }
  validates :severity, inclusion: { in: %w[low medium high critical] }
  validates :status, inclusion: {
    in: %w[pending in_review approved implemented dismissed]
  }
  validates :reason, presence: true

  # Scopes
  scope :pending, -> { where(status: 'pending') }
  scope :in_review, -> { where(status: 'in_review') }
  scope :approved, -> { where(status: 'approved') }
  scope :implemented, -> { where(status: 'implemented') }
  scope :dismissed, -> { where(status: 'dismissed') }
  scope :active, -> { where(status: %w[pending in_review approved]) }

  scope :by_severity, -> { order(Arel.sql("
    CASE severity
      WHEN 'critical' THEN 1
      WHEN 'high' THEN 2
      WHEN 'medium' THEN 3
      WHEN 'low' THEN 4
    END
  ")) }

  scope :recent, -> { order(created_at: :desc) }
  scope :for_lab, ->(lab_id) { where(adaptable_type: 'HandsOnLab', adaptable_id: lab_id) }
  scope :for_module, ->(module_id) { where(course_module_id: module_id) }
  scope :critical, -> { where(severity: 'critical') }
  scope :high_priority, -> { where(severity: %w[critical high]) }

  # Serialization
  serialize :struggle_metrics, JSON
  serialize :common_failure_points, JSON
  serialize :common_errors, JSON
  serialize :recommended_resources, JSON

  # Callbacks
  before_validation :calculate_severity, on: :create, if: -> { severity.blank? }

  # Instance methods

  # Mark for review
  def mark_for_review!
    update!(status: 'in_review')
  end

  # Approve adaptation
  def approve!(reviewer)
    update!(
      status: 'approved',
      reviewed_at: Time.current,
      reviewed_by: reviewer
    )
  end

  # Mark as implemented
  def implement!(notes = nil)
    update!(
      status: 'implemented',
      implemented_at: Time.current,
      resolution_notes: notes
    )
  end

  # Dismiss adaptation
  def dismiss!(reviewer, reason)
    update!(
      status: 'dismissed',
      reviewed_at: Time.current,
      reviewed_by: reviewer,
      resolution_notes: reason
    )
  end

  # Add affected user
  def increment_affected_users!
    increment!(:affected_users_count)
    recalculate_severity!
  end

  # Update struggle metrics
  def update_struggle_metrics!(new_metrics)
    current_metrics = struggle_metrics || {}
    merged_metrics = current_metrics.deep_merge(new_metrics)

    update!(struggle_metrics: merged_metrics)
    recalculate_severity!
  end

  # Add common failure point
  def add_failure_point(point)
    current_points = common_failure_points || []
    current_points << point unless current_points.include?(point)
    update!(common_failure_points: current_points)
  end

  # Add common error
  def add_error(error)
    current_errors = common_errors || []
    current_errors << error unless current_errors.include?(error)
    update!(common_errors: current_errors)
  end

  # Check if this is urgent
  def urgent?
    severity.in?(%w[critical high])
  end

  # Get human-readable severity
  def severity_label
    {
      'low' => '🟢 Low',
      'medium' => '🟡 Medium',
      'high' => '🟠 High',
      'critical' => '🔴 Critical'
    }[severity]
  end

  # Get human-readable status
  def status_label
    {
      'pending' => '⏳ Pending',
      'in_review' => '👀 In Review',
      'approved' => '✅ Approved',
      'implemented' => '🎉 Implemented',
      'dismissed' => '❌ Dismissed'
    }[status]
  end

  # Get adaptation type label
  def adaptation_type_label
    adaptation_type.humanize
  end

  # Summary for display
  def summary
    "#{adaptable_type} '#{adaptable&.title || adaptable_id}' needs #{adaptation_type_label}"
  end

  private

  # Calculate severity based on metrics
  def calculate_severity
    return if severity.present?

    score = 0
    metrics = struggle_metrics || {}

    # Factor 1: Number of affected users
    users = affected_users_count || 0
    score += 1 if users >= 3
    score += 2 if users >= 5
    score += 3 if users >= 10

    # Factor 2: Average struggle score
    avg_struggle = average_struggle_score || 0
    score += 1 if avg_struggle >= 0.6
    score += 2 if avg_struggle >= 0.8

    # Factor 3: Common failure points
    failures = (common_failure_points || []).count
    score += 1 if failures >= 2
    score += 2 if failures >= 4

    # Determine severity
    self.severity = case score
                    when 0..2 then 'low'
                    when 3..4 then 'medium'
                    when 5..6 then 'high'
                    else 'critical'
                    end
  end

  # Recalculate severity based on current data
  def recalculate_severity!
    self.severity = nil
    calculate_severity
    save! if severity_changed?
  end
end

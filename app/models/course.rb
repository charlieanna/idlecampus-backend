# ==================================================================================
# ⚠️  DEPRECATED MODEL - DO NOT USE FOR COURSE CONTENT!
# ==================================================================================
#
# IMPORTANT: This model should NOT be used to store or fetch course content!
#
# Course content (titles, descriptions, modules, lessons) is stored in YAML files
# and should be accessed using CourseFileReaderService.
#
# This model MAY be used for user-specific data only:
# - Tracking enrollments (via course_enrollments)
# - Tracking progress (via module_progresses)
# - Referencing courses by slug for user data
#
# However, the actual course content should ALWAYS come from YAML files.
#
# See: app/services/course_file_reader_service.rb for correct course fetching.
# ==================================================================================
class Course < ApplicationRecord
  # Associations
  has_many :course_modules, dependent: :destroy
  has_many :course_enrollments, dependent: :destroy
  has_many :enrolled_users, through: :course_enrollments, source: :user
  
  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :difficulty_level, inclusion: { in: %w[beginner intermediate advanced] }
  validates :certification_track, inclusion: { in: %w[docker dca cka ckad cks kubernetes linux foundation none] }, allow_nil: true
  
  # Scopes
  scope :published, -> { where(published: true) }
  scope :by_difficulty, ->(level) { where(difficulty_level: level) }
  scope :by_certification, ->(track) { where(certification_track: track) }
  scope :ordered, -> { order(sequence_order: :asc, created_at: :asc) }
  
  # Callbacks
  before_validation :generate_slug, on: :create
  
  # Instance methods
  def total_modules
    course_modules.count
  end
  
  def total_items
    course_modules.includes(:module_items).sum { |m| m.module_items.count }
  end
  
  def estimated_duration
    course_modules.sum(:estimated_minutes)
  end
  
  def enrollment_for(user)
    course_enrollments.find_by(user: user)
  end
  
  def enrolled?(user)
    course_enrollments.exists?(user: user)
  end
  
  def completion_rate_for(user)
    enrollment = enrollment_for(user)
    enrollment&.completion_percentage || 0
  end
  
  def next_module_for(user)
    enrollment = enrollment_for(user)
    return nil unless enrollment
    
    completed_module_ids = ModuleProgress.where(
      user: user,
      course_module_id: course_modules.pluck(:id),
      status: 'completed'
    ).pluck(:course_module_id)
    
    course_modules.ordered.where.not(id: completed_module_ids).first
  end
  
  def progress_summary_for(user)
    enrollment = enrollment_for(user)
    return nil unless enrollment
    
    {
      enrollment: enrollment,
      modules_completed: ModuleProgress.where(
        user: user,
        course_module_id: course_modules.pluck(:id),
        status: 'completed'
      ).count,
      total_modules: total_modules,
      total_points: enrollment.total_points,
      next_module: next_module_for(user)
    }
  end
  
  # Override to_param to use slug in URLs
  def to_param
    slug
  end
  
  
  private
  
  def generate_slug
    self.slug ||= title.parameterize if title.present?
  end
end
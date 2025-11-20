class HandsOnLab < ApplicationRecord
  # Associations
  has_many :lab_sessions, dependent: :destroy
  has_many :lab_attempts, dependent: :destroy
  has_many :users, through: :lab_sessions
  has_many :completed_sessions, -> { where(status: 'completed') }, class_name: 'LabSession'
  has_many :active_sessions, -> { where(status: 'active') }, class_name: 'LabSession'
  has_many :module_items, as: :item, dependent: :destroy
  has_many :course_modules, through: :module_items
  
  # Validations
  validates :title, presence: true
  validates :difficulty, presence: true, inclusion: { in: %w[easy medium hard] }
  validates :lab_type, presence: true, inclusion: { in: %w[docker kubernetes docker-compose helm python golang javascript ruby postgresql networking linux security] }
  validates :lab_format, inclusion: { in: %w[terminal code_editor hybrid] }
  validates :estimated_minutes, numericality: { greater_than: 0 }
  validates :max_attempts, numericality: { greater_than: 0 }
  validates :points_reward, numericality: { greater_than_or_equal_to: 0 }

  # Code editor specific validations
  validates :programming_language, presence: true, if: :code_editor_format?
  validates :starter_code, presence: true, if: :code_editor_format?
  validates :programming_language, inclusion: { in: %w[python golang javascript ruby java sql] }, allow_nil: true
  
  # Scopes
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
  scope :by_type, ->(type) { where(lab_type: type) }
  scope :by_difficulty, ->(level) { where(difficulty: level) }
  scope :by_category, ->(cat) { where(category: cat) }
  scope :docker_labs, -> { where(lab_type: 'docker') }
  scope :docker_related_labs, -> { where(lab_type: ['docker', 'docker-compose']) }
  scope :kubernetes_labs, -> { where(lab_type: 'kubernetes') }
  scope :for_beginners, -> { where(difficulty: 'easy') }
  scope :for_intermediate, -> { where(difficulty: 'medium') }
  scope :for_advanced, -> { where(difficulty: 'hard') }
  scope :popular, -> { order(times_completed: :desc) }
  scope :highly_successful, -> { where('average_success_rate >= ?', 0.7) }
  scope :quick_labs, -> { where('estimated_minutes <= ?', 30) }
  scope :exam_focused, ->(exam) { where(certification_exam: exam) }
  scope :terminal_labs, -> { where(lab_format: 'terminal') }
  scope :code_editor_labs, -> { where(lab_format: 'code_editor') }
  scope :by_programming_language, ->(lang) { where(programming_language: lang) }
  scope :python_labs, -> { where(programming_language: 'python') }
  scope :golang_labs, -> { where(programming_language: 'golang') }
  
  # Class methods
  def self.lab_types
    %w[docker kubernetes docker-compose helm python golang javascript ruby postgresql networking linux security]
  end

  def self.lab_formats
    %w[terminal code_editor hybrid]
  end

  def self.programming_languages
    %w[python golang javascript ruby java sql]
  end

  def self.categories
    %w[basics containers networking volumes images registry orchestration security deployment storage configuration algorithms data-structures web-development]
  end

  def self.difficulties
    %w[easy medium hard]
  end

  def self.certification_exams
    %w[DCA CKA CKAD CKS]
  end
  
  # Instance methods
  def record_completion(time_taken, success)
    increment!(:times_completed)
    update_completion_stats(time_taken, success)
  end
  
  def beginner_friendly?
    difficulty == 'easy' && estimated_minutes <= 30
  end
  
  def advanced?
    difficulty == 'hard'
  end
  
  def quick_lab?
    estimated_minutes <= 20
  end
  
  def marathon_lab?
    estimated_minutes >= 60
  end
  
  def step_count
    steps.is_a?(Array) ? steps.length : 0
  end
  
  def prerequisite_list
    prerequisites.is_a?(Array) ? prerequisites : []
  end
  
  def required_tool_list
    required_tools.is_a?(Array) ? required_tools : []
  end
  
  def has_prerequisites?
    prerequisite_list.any?
  end
  
  def average_time_minutes
    (average_completion_time / 60.0).round(1)
  end
  
  def success_percentage
    (average_success_rate * 100).round(1)
  end
  
  def difficulty_score
    case difficulty
    when 'easy' then 1
    when 'medium' then 2
    when 'hard' then 3
    else 0
    end
  end
  
  def estimated_points
    base_points = points_reward
    difficulty_multiplier = difficulty_score
    (base_points * difficulty_multiplier).to_i
  end

  # Code editor lab methods
  def code_editor_format?
    lab_format == 'code_editor' || lab_format == 'hybrid'
  end

  def terminal_format?
    lab_format == 'terminal' || lab_format == 'hybrid'
  end

  def test_case_count
    test_cases.is_a?(Array) ? test_cases.length : 0
  end

  def public_test_cases
    # Show only first 3 test cases, keep rest hidden
    return [] unless test_cases.is_a?(Array)
    test_cases.reject { |tc| tc['hidden'] }.first(3)
  end

  def hidden_test_cases
    return [] unless test_cases.is_a?(Array)
    test_cases.select { |tc| tc['hidden'] }
  end

  def all_test_cases
    test_cases.is_a?(Array) ? test_cases : []
  end

  def allowed_imports_list
    allowed_imports.is_a?(Array) ? allowed_imports : []
  end

  def has_multi_files?
    file_structure.is_a?(Hash) && file_structure.any?
  end

  # Update aggregate struggle metrics based on lab sessions
  def update_struggle_metrics!
    struggling_sessions = lab_sessions.where('struggle_score >= ?', 0.6)
    total_count = struggling_sessions.count

    if total_count > 0
      avg_struggle = struggling_sessions.average(:struggle_score) || 0.0

      update!(
        total_struggles: total_count,
        average_struggle_score: avg_struggle.round(2),
        needs_adaptation: total_count >= 3 || avg_struggle >= 0.8
      )
    else
      update!(
        total_struggles: 0,
        average_struggle_score: 0.0,
        needs_adaptation: false
      )
    end
  end

  # Check if this lab needs adaptation
  def needs_adaptation?
    needs_adaptation == true || (total_struggles.to_i >= 3 && average_struggle_score.to_f >= 0.6)
  end

  # Get struggle rate as percentage
  def struggle_rate
    total_sessions = lab_sessions.count
    return 0.0 if total_sessions.zero?

    (total_struggles.to_f / total_sessions * 100).round(1)
  end

  private
  
  def update_completion_stats(time_taken, success)
    update_average_time(time_taken)
    update_success_rate(success)
  end
  
  def update_average_time(time_taken)
    current_avg = average_completion_time || 0.0
    current_count = times_completed - 1
    new_avg = ((current_avg * current_count) + time_taken) / times_completed
    update_column(:average_completion_time, new_avg.round(2))
  end
  
  def update_success_rate(success)
    current_rate = average_success_rate || 0.0
    current_count = times_completed - 1
    new_rate = ((current_rate * current_count) + (success ? 1.0 : 0.0)) / times_completed
    update_column(:average_success_rate, new_rate.round(2))
  end
end
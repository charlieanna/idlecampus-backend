class KubernetesResource < ApplicationRecord
  # Associations
  has_many :lab_sessions, as: :practiceble, dependent: :nullify
  has_many :user_question_attempts, as: :attemptable, dependent: :destroy
  has_many :spaced_repetition_items, foreign_key: :resource_id, dependent: :destroy
  
  # Validations
  validates :resource_type, presence: true
  validates :name, presence: true
  validates :yaml_template, presence: true
  validates :difficulty, presence: true, inclusion: { in: %w[easy medium hard] }
  validates :category, presence: true
  validates :exam_frequency, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :resource_type, uniqueness: { scope: :name, message: "and name combination must be unique" }
  
  # Scopes
  scope :by_type, ->(type) { where(resource_type: type) }
  scope :by_difficulty, ->(level) { where(difficulty: level) }
  scope :by_category, ->(cat) { where(category: cat) }
  scope :high_frequency, -> { where('exam_frequency >= ?', 7) }
  scope :exam_focused, ->(exam) { where(certification_exam: exam) }
  scope :active, -> { where(is_deprecated: false) }
  scope :for_beginners, -> { where(difficulty: 'easy') }
  scope :for_intermediate, -> { where(difficulty: 'medium') }
  scope :for_advanced, -> { where(difficulty: 'hard') }
  scope :popular, -> { order(times_practiced: :desc) }
  scope :highly_successful, -> { where('average_success_rate >= ?', 0.7) }
  scope :by_api_version, ->(version) { where(api_version: version) }
  
  # Class methods
  def self.resource_types
    %w[pod deployment service configmap secret ingress statefulset daemonset job cronjob persistentvolume persistentvolumeclaim namespace serviceaccount role rolebinding clusterrole clusterrolebinding networkpolicy]
  end
  
  def self.categories
    %w[workloads networking storage configuration security rbac scheduling]
  end
  
  def self.difficulties
    %w[easy medium hard]
  end
  
  def self.certification_exams
    %w[CKA CKAD CKS]
  end
  
  def self.api_versions
    %w[v1 apps/v1 batch/v1 networking.k8s.io/v1 rbac.authorization.k8s.io/v1 storage.k8s.io/v1]
  end
  
  # Instance methods
  def record_practice(success)
    increment!(:times_practiced)
    update_success_rate(success)
  end
  
  def beginner_friendly?
    difficulty == 'easy' && exam_frequency >= 7
  end
  
  def advanced?
    difficulty == 'hard'
  end
  
  def exam_critical?
    exam_frequency >= 8
  end
  
  def workload?
    %w[pod deployment statefulset daemonset job cronjob].include?(resource_type)
  end
  
  def networking?
    %w[service ingress networkpolicy].include?(resource_type)
  end
  
  def storage?
    %w[persistentvolume persistentvolumeclaim].include?(resource_type)
  end
  
  def security_related?
    %w[secret serviceaccount role rolebinding clusterrole clusterrolebinding networkpolicy].include?(resource_type)
  end
  
  def parse_yaml
    YAML.safe_load(yaml_template) rescue {}
  end
  
  def related_resource_list
    related_resources.is_a?(Array) ? related_resources : []
  end
  
  def key_field_list
    key_fields.is_a?(Hash) ? key_fields.keys : []
  end
  
  private
  
  def update_success_rate(success)
    current_rate = average_success_rate || 0.0
    current_count = times_practiced - 1
    new_rate = ((current_rate * current_count) + (success ? 1.0 : 0.0)) / times_practiced
    update_column(:average_success_rate, new_rate.round(2))
  end
end
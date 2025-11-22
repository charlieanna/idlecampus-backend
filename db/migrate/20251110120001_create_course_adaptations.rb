class CreateCourseAdaptations < ActiveRecord::Migration[6.0]
  def change
    create_table :course_adaptations do |t|
      # Reference to what needs adaptation
      t.references :adaptable, polymorphic: true, null: false
      t.references :course_module, null: true, foreign_key: true

      # What type of adaptation is needed
      t.string :adaptation_type, null: false # 'add_practice', 'add_explanation', 'simplify_content', 'add_hints'
      t.string :severity, default: 'medium' # 'low', 'medium', 'high', 'critical'

      # Why this adaptation is needed
      t.text :reason, null: false
      t.json :struggle_metrics, default: {}

      # Struggle aggregation data
      t.integer :affected_users_count, default: 0
      t.decimal :average_struggle_score, precision: 3, scale: 2
      t.json :common_failure_points, default: []
      t.json :common_errors, default: []

      # Resolution tracking
      t.string :status, default: 'pending' # 'pending', 'in_review', 'approved', 'implemented', 'dismissed'
      t.text :resolution_notes
      t.datetime :reviewed_at
      t.references :reviewed_by, foreign_key: { to_table: :users }, null: true
      t.datetime :implemented_at

      # Suggested improvements
      t.text :suggested_changes
      t.json :recommended_resources, default: []

      t.timestamps
    end

    # Indexes for efficient querying
    add_index :course_adaptations, [:adaptable_type, :adaptable_id]
    add_index :course_adaptations, :status
    add_index :course_adaptations, :severity
    add_index :course_adaptations, :created_at
    add_index :course_adaptations, [:course_module_id, :status]

    # Add struggle tracking fields to lab_sessions
    add_column :lab_sessions, :struggle_score, :decimal, precision: 3, scale: 2
    add_column :lab_sessions, :struggle_indicators, :json, default: {}
    add_column :lab_sessions, :flagged_for_review, :boolean, default: false

    # Add aggregate struggle metrics to hands_on_labs
    add_column :hands_on_labs, :total_struggles, :integer, default: 0
    add_column :hands_on_labs, :average_struggle_score, :decimal, precision: 3, scale: 2
    add_column :hands_on_labs, :needs_adaptation, :boolean, default: false
  end
end

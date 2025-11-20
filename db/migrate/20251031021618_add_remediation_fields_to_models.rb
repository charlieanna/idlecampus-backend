class AddRemediationFieldsToModels < ActiveRecord::Migration[6.0]
  def change
    # Create remediation sessions table for tracking forced review sessions
    create_table :remediation_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :enrollment, null: false, foreign_key: { to_table: :course_enrollments }
      t.string :trigger_item_type # What failed that triggered this
      t.integer :trigger_item_id
      t.json :weak_concepts, default: [] # Concepts being remediated
      t.json :review_items, default: [] # Items to review
      t.integer :items_completed, default: 0
      t.integer :items_total, default: 0
      t.boolean :completed, default: false
      t.datetime :started_at
      t.datetime :completed_at
      t.string :status, default: 'active' # active, completed, abandoned
      
      t.timestamps
    end
    
    add_index :remediation_sessions, [:user_id, :status]
    add_index :remediation_sessions, [:enrollment_id, :status]
    add_index :remediation_sessions, [:trigger_item_type, :trigger_item_id], 
              name: 'index_remediation_sessions_on_trigger_item'
    
    # Add remediation tracking to lab_sessions
    add_column :lab_sessions, :failed_concepts, :json, default: []
    add_column :lab_sessions, :requires_remediation, :boolean, default: false
    
    # Add progressive hints tracking to learning_unit_progresses
    add_column :learning_unit_progresses, :hints_viewed, :json, default: []
    add_column :learning_unit_progresses, :refresher_accessed, :boolean, default: false
  end
end

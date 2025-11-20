class CreateLearningSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :session_id, null: false, index: { unique: true }
      t.json :state_data, default: {}
      t.integer :items_presented, default: 0
      t.integer :items_correct, default: 0
      t.integer :items_failed, default: 0
      t.datetime :started_at, null: false
      t.datetime :last_activity_at
      t.datetime :completed_at
      t.string :completion_reason # 'user_completed', 'timeout', 'system_ended'
      t.json :performance_metrics, default: {}
      
      t.timestamps
    end
    
    add_index :learning_sessions, [:user_id, :started_at]
    add_index :learning_sessions, [:user_id, :completed_at]
    add_index :learning_sessions, :last_activity_at
  end
end
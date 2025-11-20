class CreateLabSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :lab_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hands_on_lab, null: false, foreign_key: true
      t.string :container_id
      t.string :status, null: false, default: 'active'
      t.json :progress_data, default: {}
      t.integer :current_step, default: 0
      t.integer :steps_completed, default: 0
      t.json :step_history, default: []
      t.json :commands_executed, default: []
      t.json :validation_results, default: {}
      t.integer :attempts_used, default: 0
      t.integer :hints_used, default: 0
      t.text :error_logs
      t.integer :time_spent_seconds, default: 0
      t.float :completion_percentage, default: 0.0
      t.datetime :started_at
      t.datetime :completed_at
      t.datetime :expired_at
      t.datetime :last_activity_at
      t.boolean :passed, default: false
      t.integer :score, default: 0
      t.text :feedback
      t.timestamps
    end

    add_index :lab_sessions, :container_id, unique: true
    add_index :lab_sessions, :status
    add_index :lab_sessions, [:user_id, :hands_on_lab_id]
    add_index :lab_sessions, [:user_id, :status]
    add_index :lab_sessions, :started_at
    add_index :lab_sessions, :completed_at
    add_index :lab_sessions, :last_activity_at
    add_index :lab_sessions, [:hands_on_lab_id, :status]
    add_index :lab_sessions, [:user_id, :passed]
  end
end
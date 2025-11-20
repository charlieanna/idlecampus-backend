class CreateContainerLabSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :container_lab_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :session_id, null: false
      t.string :container_name
      t.string :lab_type
      t.string :status, default: 'active'
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :commands_executed, default: 0
      t.text :metadata

      t.timestamps
    end

    add_index :container_lab_sessions, [:user_id, :session_id], unique: true
    add_index :container_lab_sessions, :status
    add_index :container_lab_sessions, :container_name
  end
end
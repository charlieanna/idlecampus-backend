class CreateLearningEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :event_type, null: false
      t.string :event_category, null: false
      t.text :event_data, null: false # JSON as text (SQLite compat)
      t.text :skill_dimensions # JSON as text
      t.decimal :performance_score, precision: 5, scale: 2
      t.integer :time_spent_seconds
      
      t.timestamps
    end
    
    add_index :learning_events, [:user_id, :created_at]
    add_index :learning_events, [:event_type, :created_at]
    add_index :learning_events, :event_category
  end
end

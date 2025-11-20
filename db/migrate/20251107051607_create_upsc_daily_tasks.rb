class CreateUpscDailyTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_daily_tasks do |t|
      t.references :user, foreign_key: true, null: false
      t.references :upsc_study_plan, foreign_key: true
      t.date :task_date, null: false
      t.string :task_type
      t.string :title, null: false
      t.text :description
      t.references :upsc_topic, foreign_key: true
      t.integer :estimated_minutes
      t.integer :actual_minutes
      t.string :priority, default: 'medium'
      t.string :status, default: 'pending'
      t.datetime :completed_at
      t.text :notes

      t.timestamps
    end

    add_index :upsc_daily_tasks, [:user_id, :task_date]
    add_index :upsc_daily_tasks, :status
    add_index :upsc_daily_tasks, [:task_date, :status]
  end
end

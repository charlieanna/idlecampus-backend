class CreateStudyPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :study_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :daily_target, default: 30 # minutes per day
      t.integer :weekly_target, default: 5 # days per week
      t.date :estimated_completion_date
      t.string :status, default: 'active'
      t.integer :progress_percentage, default: 0
      t.text :milestones # JSON array of milestones
      t.date :start_date
      t.integer :actual_days_studied, default: 0
      t.integer :total_time_spent, default: 0 # minutes

      t.timestamps
    end
    
    add_index :study_plans, :status
    add_index :study_plans, [:user_id, :status]
  end
end

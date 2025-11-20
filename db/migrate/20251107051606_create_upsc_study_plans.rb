class CreateUpscStudyPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_study_plans do |t|
      t.references :user, foreign_key: true, null: false
      t.string :plan_name
      t.date :start_date, null: false
      t.date :target_exam_date, null: false
      t.integer :total_days
      t.jsonb :phase_breakdown
      t.jsonb :daily_schedule
      t.boolean :is_active, default: true
      t.integer :completion_percentage, default: 0

      t.timestamps
    end

    add_index :upsc_study_plans, [:user_id, :is_active]
    add_index :upsc_study_plans, :target_exam_date
  end
end

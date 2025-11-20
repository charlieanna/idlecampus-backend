class CreateUpscStudentProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_student_profiles do |t|
      t.references :user, foreign_key: true, null: false, index: { unique: true }
      t.date :target_exam_date
      t.integer :attempt_number, default: 1
      t.references :optional_subject, foreign_key: { to_table: :upsc_subjects }
      t.string :medium_of_exam, default: 'english'
      t.jsonb :previous_attempt_details, default: {}
      t.text :educational_background
      t.string :current_occupation
      t.text :work_experience
      t.integer :study_hours_per_day
      t.string :preferred_study_time
      t.jsonb :daf_details, default: {}
      t.text :strengths, array: true, default: []
      t.text :weaknesses, array: true, default: []
      t.text :goals

      t.timestamps
    end

    add_index :upsc_student_profiles, :target_exam_date
    add_index :upsc_student_profiles, :attempt_number
  end
end

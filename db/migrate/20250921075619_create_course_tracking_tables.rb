class CreateCourseTrackingTables < ActiveRecord::Migration[6.0]
  def change
    create_table :user_course_enrollments do |t|
      t.references :user, foreign_key: true
      t.string :tag
      t.datetime :started_at
      t.datetime :completed_at
      t.string :status
      t.timestamps
    end

    create_table :user_course_progresses do |t|
      t.references :user, foreign_key: true
      t.string :tag
      t.string :question_id
      t.string :module_id
      t.boolean :completed, default: false
      t.datetime :completed_at
      t.timestamps
    end

    create_table :user_achievements do |t|
      t.references :user, foreign_key: true
      t.string :achievement_type
      t.string :tag
      t.string :module_id
      t.datetime :achieved_at
      t.timestamps
    end

    add_index :user_course_enrollments, [:user_id, :tag], unique: true
    add_index :user_course_progresses, [:user_id, :tag, :question_id], unique: true, name: 'idx_user_course_progress'
    add_index :user_achievements, [:user_id, :achievement_type, :tag, :module_id], unique: true, name: 'idx_user_achievements'
  end
end
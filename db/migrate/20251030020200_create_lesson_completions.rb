class CreateLessonCompletions < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_completions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_lesson, null: false, foreign_key: true
      t.datetime :completed_at
      t.timestamps
    end
    
    add_index :lesson_completions, [:user_id, :course_lesson_id], unique: true
  end
end
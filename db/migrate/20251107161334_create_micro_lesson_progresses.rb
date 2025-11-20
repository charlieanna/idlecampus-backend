class CreateMicroLessonProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :micro_lesson_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :micro_lesson, null: false, foreign_key: true

      t.boolean :completed, default: false
      t.integer :exercises_completed, default: 0
      t.integer :total_exercises, default: 0
      t.integer :time_spent_seconds, default: 0
      t.float :mastery_score, default: 0.0
      t.datetime :completed_at

      t.timestamps
    end

    add_index :micro_lesson_progresses, [:user_id, :micro_lesson_id], unique: true, name: 'index_ml_progress_on_user_and_lesson'
    add_index :micro_lesson_progresses, :completed
  end
end

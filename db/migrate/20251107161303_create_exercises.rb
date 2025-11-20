class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.references :micro_lesson, null: false, foreign_key: true

      t.string :exercise_type, null: false
      t.integer :sequence_order, null: false, default: 1
      t.jsonb :exercise_data, default: {}

      t.timestamps
    end

    add_index :exercises, [:micro_lesson_id, :sequence_order]
    add_index :exercises, :exercise_type
  end
end

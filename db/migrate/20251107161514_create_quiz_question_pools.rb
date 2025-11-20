class CreateQuizQuestionPools < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_question_pools do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.float :weight, default: 1.0
      t.string :difficulty_override

      t.timestamps
    end

    add_index :quiz_question_pools, [:quiz_id, :exercise_id], unique: true
    add_index :quiz_question_pools, :weight
  end
end

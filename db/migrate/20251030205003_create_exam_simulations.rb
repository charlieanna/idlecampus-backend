class CreateExamSimulations < ActiveRecord::Migration[6.0]
  def change
    create_table :exam_simulations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :certification_type
      t.string :status
      t.float :score
      t.boolean :passed
      t.datetime :started_at
      t.datetime :submitted_at
      t.integer :time_limit
      t.integer :time_taken
      t.text :question_ids
      t.text :answers
      t.text :correct_answers
      t.integer :correct_count
      t.integer :total_questions

      t.timestamps
    end
  end
end

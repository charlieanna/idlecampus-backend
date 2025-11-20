class CreateUpscTestQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_test_questions do |t|
      t.references :upsc_test, foreign_key: true, null: false
      t.references :upsc_question, foreign_key: true, null: false
      t.decimal :marks, precision: 5, scale: 2, null: false
      t.decimal :negative_marks, precision: 5, scale: 2, default: 0
      t.integer :order_index, null: false
      t.string :section

      t.timestamps
    end

    add_index :upsc_test_questions, [:upsc_test_id, :upsc_question_id], unique: true, name: 'index_test_questions_unique'
    add_index :upsc_test_questions, :order_index
  end
end

class CreateUpscUserAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_user_answers do |t|
      t.references :user, foreign_key: true, null: false
      t.references :upsc_writing_question, foreign_key: true, null: false
      t.text :answer_text, null: false
      t.integer :word_count
      t.integer :time_taken_minutes
      t.string :submission_type, default: 'typed'
      t.string :file_url
      t.datetime :submitted_at, null: false
      t.jsonb :ai_evaluation
      t.decimal :ai_score, precision: 5, scale: 2
      t.datetime :ai_evaluated_at
      t.jsonb :mentor_evaluation
      t.decimal :mentor_score, precision: 5, scale: 2
      t.datetime :mentor_evaluated_at
      t.references :evaluator, foreign_key: { to_table: :users }
      t.decimal :final_score, precision: 5, scale: 2
      t.string :status, default: 'submitted'
      t.integer :revision_number, default: 1
      t.references :original_answer, foreign_key: { to_table: :upsc_user_answers }
      t.boolean :is_public, default: false
      t.integer :like_count, default: 0

      t.timestamps
    end

    add_index :upsc_user_answers, [:user_id, :upsc_writing_question_id], name: 'index_user_answers_on_user_and_question'
    add_index :upsc_user_answers, :status
    add_index :upsc_user_answers, :submitted_at
  end
end

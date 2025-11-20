class CreateUpscQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_questions do |t|
      t.references :upsc_subject, foreign_key: true
      t.references :upsc_topic, foreign_key: true
      t.string :question_type, null: false # mcq, msq, tf, assertion_reason
      t.string :difficulty # easy, medium, hard
      t.decimal :marks, precision: 5, scale: 2, default: 1.0
      t.decimal :negative_marks, precision: 5, scale: 2, default: 0
      t.integer :time_limit_seconds
      t.text :question_text, null: false
      t.string :question_image_url
      t.jsonb :options # [{id: 'A', text: '...', is_correct: true/false}]
      t.text :correct_answer, null: false
      t.text :explanation
      t.string :explanation_video_url
      t.text :hints, array: true, default: []
      t.integer :pyq_year
      t.string :pyq_paper
      t.integer :pyq_question_number
      t.string :source
      t.text :tags, array: true, default: []
      t.integer :relevance_score, default: 50
      t.integer :attempt_count, default: 0
      t.integer :correct_attempt_count, default: 0
      t.integer :average_time_taken_seconds
      t.string :status, default: 'active'
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :upsc_questions, :question_type
    add_index :upsc_questions, :difficulty
    add_index :upsc_questions, :pyq_year
    add_index :upsc_questions, :status
    add_index :upsc_questions, [:upsc_subject_id, :upsc_topic_id]
  end
end

class CreateUpscWritingQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_writing_questions do |t|
      t.references :upsc_subject, foreign_key: true
      t.references :upsc_topic, foreign_key: true
      t.string :question_type
      t.text :question_text, null: false
      t.text :question_context
      t.integer :word_limit
      t.decimal :marks, precision: 5, scale: 2, default: 10.0
      t.integer :time_limit_minutes
      t.string :difficulty
      t.text :directive_keywords, array: true, default: []
      t.jsonb :evaluation_criteria
      t.text :model_answer
      t.string :model_answer_url
      t.text :key_points, array: true, default: []
      t.jsonb :suggested_structure
      t.integer :pyq_year
      t.string :pyq_paper
      t.text :tags, array: true, default: []
      t.date :current_affairs_date
      t.integer :relevance_score, default: 50
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :upsc_writing_questions, :question_type
    add_index :upsc_writing_questions, :pyq_year
    add_index :upsc_writing_questions, :current_affairs_date
  end
end

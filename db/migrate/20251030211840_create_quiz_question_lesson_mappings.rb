class CreateQuizQuestionLessonMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_question_lesson_mappings do |t|
      t.references :quiz_question, null: false, foreign_key: true
      t.references :course_lesson, null: false, foreign_key: true
      t.string :section_anchor
      t.integer :relevance_weight, default: 100
      
      t.timestamps
    end
    
    add_index :quiz_question_lesson_mappings, [:quiz_question_id, :course_lesson_id], 
              name: 'index_mappings_on_question_and_lesson'
    add_index :quiz_question_lesson_mappings, :relevance_weight
  end
end

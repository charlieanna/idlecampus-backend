class AddAdaptiveMetadataToQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_questions, :difficulty, :decimal, precision: 4, scale: 2, null: false, default: 0.0
    add_column :quiz_questions, :discrimination, :decimal, precision: 4, scale: 2, null: false, default: 1.0
    add_column :quiz_questions, :guessing, :decimal, precision: 4, scale: 2, null: false, default: 0.2
    add_column :quiz_questions, :topic, :string
    add_column :quiz_questions, :skill_dimension, :string
    
    add_index :quiz_questions, :topic
    add_index :quiz_questions, :skill_dimension
    add_index :quiz_questions, [:skill_dimension, :difficulty]
  end
end

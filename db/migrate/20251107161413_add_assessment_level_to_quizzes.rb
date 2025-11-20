class AddAssessmentLevelToQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :quizzes, :assessment_level, :string, default: 'module'
    add_column :quizzes, :source_module_ids, :jsonb, default: []
    add_column :quizzes, :adaptive_config, :jsonb, default: {}

    add_index :quizzes, :assessment_level
    add_index :quizzes, :source_module_ids, using: :gin
  end
end

class AddMetadataToQuiz < ActiveRecord::Migration[6.0]
  def change
    add_column :quizzes, :metadata, :jsonb
    add_column :quizzes, :quiz_type, :string
  end
end

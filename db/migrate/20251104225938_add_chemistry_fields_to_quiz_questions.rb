class AddChemistryFieldsToQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    # For numerical questions: tolerance for answer validation (e.g., 0.01 means ±0.01)
    add_column :quiz_questions, :tolerance, :decimal, precision: 10, scale: 6, default: 0.01

    # For MCQs: whether multiple options can be correct (IIT JEE multi-correct MCQs)
    add_column :quiz_questions, :multiple_correct, :boolean, default: false

    # For sequence questions: array of items to be ordered
    # Format: [{id: 1, text: "Step 1"}, {id: 2, text: "Step 2"}]
    # correct_answer will store the correct sequence as comma-separated IDs: "1,3,2,4"
    add_column :quiz_questions, :sequence_items, :json, default: '[]'

    # Add image_url for diagrams (chemical structures, periodic table, etc.)
    add_column :quiz_questions, :image_url, :string
  end
end

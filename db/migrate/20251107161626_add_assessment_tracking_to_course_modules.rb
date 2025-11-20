class AddAssessmentTrackingToCourseModules < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_modules, :module_quiz, foreign_key: { to_table: :quizzes }, null: true
    add_column :course_modules, :requires_milestone_exam, :boolean, default: false

    add_index :course_modules, :requires_milestone_exam
  end
end

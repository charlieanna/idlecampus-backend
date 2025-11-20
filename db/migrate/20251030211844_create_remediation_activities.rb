class CreateRemediationActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :remediation_activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz_attempt, null: false, foreign_key: true
      t.references :quiz_question, null: false, foreign_key: true
      t.references :course_lesson, null: false, foreign_key: true
      t.boolean :lesson_reviewed, default: false
      t.boolean :improved_on_retry, default: false
      
      t.timestamps
    end
    
    add_index :remediation_activities, [:user_id, :quiz_question_id], 
              name: 'index_remediation_on_user_and_question'
    add_index :remediation_activities, [:user_id, :created_at]
    add_index :remediation_activities, :lesson_reviewed
  end
end

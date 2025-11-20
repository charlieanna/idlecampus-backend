class CreateMilestoneExams < ActiveRecord::Migration[6.0]
  def change
    create_table :milestone_exams do |t|
      t.references :course, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true

      t.string :title, null: false
      t.text :description
      t.integer :module_range_start, null: false
      t.integer :module_range_end, null: false
      t.integer :sequence_order, null: false, default: 0
      t.integer :passing_score, default: 75
      t.boolean :required, default: true

      t.timestamps
    end

    add_index :milestone_exams, [:course_id, :sequence_order]
    add_index :milestone_exams, [:module_range_start, :module_range_end], name: 'index_milestone_exams_on_range'
  end
end

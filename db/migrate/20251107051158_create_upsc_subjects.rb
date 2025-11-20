class CreateUpscSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_subjects do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :exam_type, null: false # prelims, mains, both
      t.integer :paper_number
      t.integer :total_marks
      t.integer :duration_minutes
      t.text :description
      t.string :syllabus_pdf_url
      t.boolean :is_optional, default: false
      t.boolean :is_active, default: true
      t.integer :order_index
      t.string :icon_url
      t.string :color_code

      t.timestamps
    end

    add_index :upsc_subjects, :code, unique: true
    add_index :upsc_subjects, :exam_type
    add_index :upsc_subjects, :is_optional
    add_index :upsc_subjects, :order_index
  end
end

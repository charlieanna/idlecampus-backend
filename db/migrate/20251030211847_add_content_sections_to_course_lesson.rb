class AddContentSectionsToCourseLesson < ActiveRecord::Migration[6.0]
  def change
    add_column :course_lessons, :content_sections, :jsonb, default: []
    add_index :course_lessons, :content_sections, using: :gin
  end
end

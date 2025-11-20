class AddKeyCommandsToCourseLesson < ActiveRecord::Migration[6.0]
  def change
    add_column :course_lessons, :key_commands, :json
  end
end

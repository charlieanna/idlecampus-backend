class AddCurrentItemToCourseEnrollments < ActiveRecord::Migration[6.0]
  def change
    change_table :course_enrollments do |t|
      t.references :current_item, polymorphic: true, index: { name: 'index_course_enrollments_on_current_item' }
    end
  end
end



class AddProgressTrackingToCourseEnrollments < ActiveRecord::Migration[6.0]
  def change
    add_column :course_enrollments, :last_accessed_at, :datetime
    add_column :course_enrollments, :needs_review, :boolean, default: false
    add_column :course_enrollments, :time_away_days, :integer, default: 0
    add_column :course_enrollments, :last_completed_item_type, :string
    add_column :course_enrollments, :last_completed_item_id, :bigint

    add_index :course_enrollments, :last_accessed_at
    add_index :course_enrollments, :needs_review
    add_index :course_enrollments, [:last_completed_item_type, :last_completed_item_id],
              name: 'index_course_enrollments_on_last_completed_item'
  end
end

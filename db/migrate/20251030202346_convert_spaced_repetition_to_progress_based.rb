class ConvertSpacedRepetitionToProgressBased < ActiveRecord::Migration[6.0]
  def up
    # Add progress-based fields
    add_column :spaced_repetition_items, :review_after_points, :integer
    add_column :spaced_repetition_items, :progress_interval, :integer
    add_column :spaced_repetition_items, :points_since_review, :integer, default: 0
    add_column :spaced_repetition_items, :last_review_points, :integer
    
    # Add user total progress points
    add_column :users, :total_progress_points, :integer, default: 0
    
    # Migrate existing data: convert time intervals to progress intervals
    # Formula: progress_interval = interval_days * 20 (assuming ~20 points per day)
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE spaced_repetition_items
          SET 
            progress_interval = COALESCE(interval_days * 20, 40),
            review_after_points = COALESCE(interval_days * 20, 40),
            points_since_review = CASE
              WHEN next_review_at IS NULL THEN 0
              WHEN next_review_at <= CURRENT_TIMESTAMP THEN COALESCE(interval_days * 20, 40)
              ELSE 0
            END,
            last_review_points = 0
        SQL
      end
    end
    
    # Add indexes for performance
    add_index :spaced_repetition_items, :review_after_points
    add_index :spaced_repetition_items, :points_since_review
    add_index :users, :total_progress_points
  end

  def down
    # Remove progress-based fields
    remove_column :spaced_repetition_items, :review_after_points
    remove_column :spaced_repetition_items, :progress_interval
    remove_column :spaced_repetition_items, :points_since_review
    remove_column :spaced_repetition_items, :last_review_points
    remove_column :users, :total_progress_points
    
    # Remove indexes
    remove_index :spaced_repetition_items, :review_after_points if index_exists?(:spaced_repetition_items, :review_after_points)
    remove_index :spaced_repetition_items, :points_since_review if index_exists?(:spaced_repetition_items, :points_since_review)
    remove_index :users, :total_progress_points if index_exists?(:users, :total_progress_points)
  end
end

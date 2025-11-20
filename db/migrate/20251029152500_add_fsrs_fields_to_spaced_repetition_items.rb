class AddFsrsFieldsToSpacedRepetitionItems < ActiveRecord::Migration[6.0]
  def change
    # Add FSRS-specific fields to existing spaced_repetition_items table
    # These fields are essential for the FSRS algorithm's state tracking
    # Note: interval_days already exists, so we skip it
    
    # Core FSRS parameters
    add_column :spaced_repetition_items, :difficulty, :decimal, precision: 4, scale: 2,
               comment: 'FSRS difficulty rating (1-10, typically 3-7)'
    add_column :spaced_repetition_items, :stability, :decimal, precision: 6, scale: 2,
               comment: 'FSRS stability in days (memory strength)'
    
    # Review tracking
    add_column :spaced_repetition_items, :elapsed_days, :integer,
               comment: 'Days elapsed since last review'
    add_column :spaced_repetition_items, :review_count, :integer, default: 0,
               comment: 'Total number of reviews'
    add_column :spaced_repetition_items, :lapse_count, :integer, default: 0,
               comment: 'Number of times recalled incorrectly'
    
    # Scheduling
    add_column :spaced_repetition_items, :last_grade, :string,
               comment: 'Last review grade (again/hard/good/easy)'
    
    # Performance metrics
    add_column :spaced_repetition_items, :average_grade, :decimal, precision: 3, scale: 2,
               comment: 'Average grade across all reviews'
    add_column :spaced_repetition_items, :retention_rate, :decimal, precision: 3, scale: 2,
               comment: 'Calculated retention probability'
    
    # User-specific parameters (for personalization)
    add_column :spaced_repetition_items, :user_params, :json,
               comment: 'User-specific FSRS parameter overrides'
    
    # Change coding_problem_id to be polymorphic for Docker/K8s content
    add_column :spaced_repetition_items, :reviewable_type, :string
    add_column :spaced_repetition_items, :reviewable_id, :integer
    
    # Add indexes for efficient querying
    add_index :spaced_repetition_items, :stability
    add_index :spaced_repetition_items, :difficulty
    add_index :spaced_repetition_items, [:reviewable_type, :reviewable_id],
              name: 'index_sri_on_reviewable'
    add_index :spaced_repetition_items, [:user_id, :lapse_count],
              name: 'index_sri_on_user_and_lapses'
  end
end
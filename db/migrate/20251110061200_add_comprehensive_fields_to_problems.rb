class AddComprehensiveFieldsToProblems < ActiveRecord::Migration[6.0]
  def change
    add_column :problems, :slug, :string
    add_column :problems, :difficulty, :string
    add_column :problems, :topic, :string
    add_column :problems, :subtopic, :string
    add_column :problems, :family_id, :string

    # JSONB columns for flexible data storage
    add_column :problems, :examples, :jsonb, default: []
    add_column :problems, :constraints, :jsonb, default: []
    add_column :problems, :test_cases, :jsonb, default: []
    add_column :problems, :hints, :jsonb, default: []
    add_column :problems, :tags, :jsonb, default: []
    add_column :problems, :related_problems, :jsonb, default: []
    add_column :problems, :prerequisites, :jsonb, default: []
    add_column :problems, :companies, :jsonb, default: []
    add_column :problems, :starter_code, :jsonb, default: {}
    add_column :problems, :follow_ups, :jsonb, default: []

    # Metadata for adaptive learning
    add_column :problems, :solution_approach, :text
    add_column :problems, :time_complexity, :string
    add_column :problems, :space_complexity, :string
    add_column :problems, :frequency, :string
    add_column :problems, :success_rate, :decimal, precision: 5, scale: 2
    add_column :problems, :estimated_time_mins, :integer
    add_column :problems, :points, :integer

    # Statistics for tracking
    add_column :problems, :total_attempts, :integer, default: 0
    add_column :problems, :successful_attempts, :integer, default: 0
    add_column :problems, :average_time_spent, :decimal, precision: 10, scale: 2

    # Indexes for common queries
    add_index :problems, :slug, unique: true
    add_index :problems, :difficulty
    add_index :problems, :topic
    add_index :problems, :family_id
    add_index :problems, :tags, using: :gin
  end
end

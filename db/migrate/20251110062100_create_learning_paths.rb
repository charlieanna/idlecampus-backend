class CreateLearningPaths < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_paths do |t|
      t.references :user, null: false, foreign_key: true

      # Current position
      t.references :current_problem, foreign_key: { to_table: :problems }
      t.string :current_topic
      t.string :current_difficulty

      # Performance tracking
      t.decimal :overall_success_rate, precision: 5, scale: 2
      t.jsonb :topic_performance, default: {} # { "Arrays & Strings": { success_rate: 0.75, problems_solved: 10 } }
      t.jsonb :difficulty_performance, default: {} # { "easy": 0.9, "medium": 0.6, "hard": 0.3 }

      # Adaptive settings
      t.string :learning_style # 'progressive', 'mixed', 'challenge_focused'
      t.integer :target_difficulty_level, default: 1 # 1=easy, 2=medium, 3=hard, 4=expert
      t.jsonb :weak_topics, default: [] # Topics where user struggles
      t.jsonb :strong_topics, default: [] # Topics where user excels

      # Recommendations
      t.jsonb :recommended_problems, default: [] # [problem_id, problem_id, ...]
      t.jsonb :prerequisite_queue, default: [] # Problems to review before advancing

      # Statistics
      t.integer :total_problems_attempted, default: 0
      t.integer :total_problems_solved, default: 0
      t.integer :current_streak, default: 0
      t.integer :longest_streak, default: 0
      t.datetime :last_activity_at

      t.timestamps
    end

    add_index :learning_paths, :user_id, unique: true unless index_exists?(:learning_paths, :user_id)
  end
end

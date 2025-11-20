class CreateCourseSystem < ActiveRecord::Migration[6.0]
  def change
    # Courses table
    create_table :courses do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description
      t.string :difficulty_level # beginner, intermediate, advanced
      t.integer :estimated_hours
      t.string :certification_track # dca, cka, ckad, etc.
      t.string :icon_url
      t.string :banner_url
      t.boolean :published, default: false
      t.integer :sequence_order, default: 0
      t.text :learning_objectives
      t.text :prerequisites
      t.timestamps
    end
    add_index :courses, :slug, unique: true
    add_index :courses, :published
    add_index :courses, :difficulty_level

    # Course modules table
    create_table :course_modules do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description
      t.integer :sequence_order, null: false
      t.integer :estimated_minutes
      t.text :learning_objectives
      t.boolean :published, default: false
      t.timestamps
    end
    add_index :course_modules, [:course_id, :slug], unique: true
    add_index :course_modules, :published

    # Course Lessons table (renamed to avoid conflict with existing lessons table)
    create_table :course_lessons do |t|
      t.string :title, null: false
      t.text :content # Markdown content
      t.string :video_url
      t.integer :reading_time_minutes
      t.text :key_concepts
      t.timestamps
    end

    # Quizzes table
    create_table :quizzes do |t|
      t.string :title, null: false
      t.text :description
      t.integer :time_limit_minutes
      t.integer :passing_score, default: 70
      t.integer :max_attempts
      t.boolean :shuffle_questions, default: true
      t.boolean :show_correct_answers, default: true
      t.timestamps
    end

    # Quiz questions table
    create_table :quiz_questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.string :question_type, null: false # mcq, fill_blank, command, true_false
      t.text :question_text, null: false
      t.text :options # For MCQ: [{text: "Option A", correct: true}, ...]
      t.text :correct_answer # For fill_blank and command types
      t.text :explanation
      t.integer :points, default: 1
      t.string :difficulty_level # easy, medium, hard
      t.text :tags
      t.integer :sequence_order
      t.timestamps
    end
    add_index :quiz_questions, :question_type
    add_index :quiz_questions, :difficulty_level

    # Module items (polymorphic join table)
    create_table :module_items do |t|
      t.references :course_module, null: false, foreign_key: true
      t.references :item, polymorphic: true, null: false # lesson, quiz, or hands_on_lab
      t.integer :sequence_order, null: false
      t.boolean :required, default: true
      t.timestamps
    end
    add_index :module_items, [:course_module_id, :sequence_order]

    # Course enrollments
    create_table :course_enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.datetime :enrolled_at
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :completion_percentage, default: 0
      t.integer :total_points, default: 0
      t.string :status, default: 'enrolled' # enrolled, in_progress, completed, dropped
      t.timestamps
    end
    add_index :course_enrollments, [:user_id, :course_id], unique: true
    add_index :course_enrollments, :status

    # Module progress tracking
    create_table :module_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_module, null: false, foreign_key: true
      t.references :course_enrollment, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :completion_percentage, default: 0
      t.integer :items_completed, default: 0
      t.integer :total_items, default: 0
      t.string :status, default: 'not_started' # not_started, in_progress, completed
      t.timestamps
    end
    add_index :module_progresses, [:user_id, :course_module_id], unique: true

    # Quiz attempts
    create_table :quiz_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true
      t.references :course_enrollment, foreign_key: true
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :score
      t.integer :total_questions
      t.integer :correct_answers, default: 0
      t.text :answers # {question_id: user_answer}
      t.integer :time_taken_seconds
      t.boolean :passed, default: false
      t.integer :attempt_number, default: 1
      t.timestamps
    end
    add_index :quiz_attempts, [:user_id, :quiz_id]
    add_index :quiz_attempts, :passed

    # Course Achievements (renamed to avoid conflict with existing achievements table)
    create_table :course_achievements do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.string :icon_url
      t.string :badge_type # bronze, silver, gold, platinum
      t.integer :points_value, default: 0
      t.string :category # course_completion, lab_mastery, quiz_perfectionist, streak, speed
      t.text :criteria # {type: "complete_course", course_id: 1}
      t.timestamps
    end
    add_index :course_achievements, :slug, unique: true
    add_index :course_achievements, :category

    # User Course Achievements (renamed to avoid conflict)
    create_table :user_course_achievements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_achievement, null: false, foreign_key: true
      t.datetime :earned_at
      t.text :metadata # Additional context about how it was earned
      t.timestamps
    end
    add_index :user_course_achievements, [:user_id, :course_achievement_id], unique: true, name: 'index_user_course_achievements_unique'

    # User stats (for gamification)
    create_table :user_stats do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.integer :total_points, default: 0, index: true
      t.integer :current_streak_days, default: 0
      t.integer :longest_streak_days, default: 0
      t.datetime :last_activity_at
      t.integer :courses_completed, default: 0
      t.integer :labs_completed, default: 0
      t.integer :quizzes_passed, default: 0
      t.integer :total_study_minutes, default: 0
      t.text :weak_areas # [{topic: "networking", accuracy: 0.45}]
      t.timestamps
    end
  end
end
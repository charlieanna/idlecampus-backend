# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2025_11_10_120001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "container_lab_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "session_id", null: false
    t.string "container_name"
    t.string "lab_type"
    t.string "status", default: "active"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer "commands_executed", default: 0
    t.text "metadata"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["container_name"], name: "index_container_lab_sessions_on_container_name"
    t.index ["status"], name: "index_container_lab_sessions_on_status"
    t.index ["user_id", "session_id"], name: "index_container_lab_sessions_on_user_id_and_session_id", unique: true
    t.index ["user_id"], name: "index_container_lab_sessions_on_user_id"
  end

  create_table "course_achievements", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.string "icon_url"
    t.string "badge_type"
    t.integer "points_value", default: 0
    t.string "category"
    t.text "criteria"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_course_achievements_on_category"
    t.index ["slug"], name: "index_course_achievements_on_slug", unique: true
  end

  create_table "course_enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "enrolled_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer "completion_percentage", default: 0
    t.integer "total_points", default: 0
    t.string "status", default: "enrolled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "current_item_type"
    t.bigint "current_item_id"
    t.datetime "last_accessed_at"
    t.boolean "needs_review", default: false
    t.integer "time_away_days", default: 0
    t.string "last_completed_item_type"
    t.bigint "last_completed_item_id"
    t.index ["course_id"], name: "index_course_enrollments_on_course_id"
    t.index ["current_item_type", "current_item_id"], name: "index_course_enrollments_on_current_item"
    t.index ["last_accessed_at"], name: "index_course_enrollments_on_last_accessed_at"
    t.index ["last_completed_item_type", "last_completed_item_id"], name: "index_course_enrollments_on_last_completed_item"
    t.index ["needs_review"], name: "index_course_enrollments_on_needs_review"
    t.index ["status"], name: "index_course_enrollments_on_status"
    t.index ["user_id", "course_id"], name: "index_course_enrollments_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_course_enrollments_on_user_id"
  end

  create_table "course_lessons", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.string "video_url"
    t.integer "reading_time_minutes"
    t.text "key_concepts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "content_sections", default: []
    t.json "key_commands"
    t.index ["content_sections"], name: "index_course_lessons_on_content_sections", using: :gin
  end

  create_table "course_modules", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "title", null: false
    t.string "slug", null: false
    t.text "description"
    t.integer "sequence_order", null: false
    t.integer "estimated_minutes"
    t.text "learning_objectives"
    t.boolean "published", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "module_quiz_id"
    t.boolean "requires_milestone_exam", default: false
    t.index ["course_id", "slug"], name: "index_course_modules_on_course_id_and_slug", unique: true
    t.index ["course_id"], name: "index_course_modules_on_course_id"
    t.index ["module_quiz_id"], name: "index_course_modules_on_module_quiz_id"
    t.index ["published"], name: "index_course_modules_on_published"
    t.index ["requires_milestone_exam"], name: "index_course_modules_on_requires_milestone_exam"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "description"
    t.string "difficulty_level"
    t.integer "estimated_hours"
    t.string "certification_track"
    t.string "icon_url"
    t.string "banner_url"
    t.boolean "published", default: false
    t.integer "sequence_order", default: 0
    t.text "learning_objectives"
    t.text "prerequisites"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["difficulty_level"], name: "index_courses_on_difficulty_level"
    t.index ["published"], name: "index_courses_on_published"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
  end

  create_table "docker_commands", force: :cascade do |t|
    t.string "command", null: false
    t.text "explanation"
    t.string "difficulty", null: false
    t.string "category", null: false
    t.integer "exam_frequency", default: 5
    t.json "variations", default: []
    t.json "flags", default: {}
    t.json "common_options", default: {}
    t.text "use_cases"
    t.text "gotchas"
    t.string "certification_exam"
    t.integer "times_practiced", default: 0
    t.float "average_success_rate", default: 0.0
    t.boolean "is_deprecated", default: false
    t.string "docker_version_min"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category", "difficulty"], name: "index_docker_commands_on_category_and_difficulty"
    t.index ["category"], name: "index_docker_commands_on_category"
    t.index ["certification_exam"], name: "index_docker_commands_on_certification_exam"
    t.index ["command"], name: "index_docker_commands_on_command", unique: true
    t.index ["difficulty", "exam_frequency"], name: "index_docker_commands_on_difficulty_and_exam_frequency"
    t.index ["difficulty"], name: "index_docker_commands_on_difficulty"
    t.index ["exam_frequency"], name: "index_docker_commands_on_exam_frequency"
    t.index ["is_deprecated"], name: "index_docker_commands_on_is_deprecated"
  end

  create_table "exam_simulations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "certification_type"
    t.string "status"
    t.float "score"
    t.boolean "passed"
    t.datetime "started_at"
    t.datetime "submitted_at"
    t.integer "time_limit"
    t.integer "time_taken"
    t.text "question_ids"
    t.text "answers"
    t.text "correct_answers"
    t.integer "correct_count"
    t.integer "total_questions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_exam_simulations_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.bigint "micro_lesson_id", null: false
    t.string "exercise_type", null: false
    t.integer "sequence_order", default: 1, null: false
    t.jsonb "exercise_data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_type"], name: "index_exercises_on_exercise_type"
    t.index ["micro_lesson_id", "sequence_order"], name: "index_exercises_on_micro_lesson_id_and_sequence_order"
    t.index ["micro_lesson_id"], name: "index_exercises_on_micro_lesson_id"
  end

  create_table "hands_on_labs", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "difficulty", null: false
    t.integer "estimated_minutes", default: 30
    t.json "steps", default: []
    t.json "validation_rules", default: {}
    t.string "lab_type", null: false
    t.string "category"
    t.text "learning_objectives"
    t.json "prerequisites", default: []
    t.text "success_criteria"
    t.string "environment_image"
    t.json "required_tools", default: []
    t.integer "max_attempts", default: 3
    t.integer "times_completed", default: 0
    t.float "average_completion_time", default: 0.0
    t.float "average_success_rate", default: 0.0
    t.string "certification_exam"
    t.boolean "is_active", default: true
    t.integer "points_reward", default: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "scenario_narrative"
    t.json "concept_tags", default: []
    t.json "required_commands", default: []
    t.json "commands_tested", default: []
    t.integer "pass_threshold", default: 70
    t.decimal "stability_multiplier", precision: 4, scale: 2, default: "1.5"
    t.string "slug"
    t.string "lab_format", default: "terminal"
    t.string "programming_language"
    t.text "starter_code"
    t.jsonb "test_cases", default: []
    t.text "validation_script"
    t.jsonb "file_structure", default: {}
    t.text "solution_code"
    t.jsonb "allowed_imports", default: []
    t.integer "time_limit_seconds", default: 5
    t.integer "memory_limit_mb", default: 128
    t.text "schema_setup"
    t.text "sample_data"
    t.json "hints"
    t.index ["category", "difficulty"], name: "index_hands_on_labs_on_category_and_difficulty"
    t.index ["category"], name: "index_hands_on_labs_on_category"
    t.index ["certification_exam"], name: "index_hands_on_labs_on_certification_exam"
    t.index ["difficulty"], name: "index_hands_on_labs_on_difficulty"
    t.index ["is_active"], name: "index_hands_on_labs_on_is_active"
    t.index ["lab_format"], name: "index_hands_on_labs_on_lab_format"
    t.index ["lab_type", "difficulty"], name: "index_hands_on_labs_on_lab_type_and_difficulty"
    t.index ["lab_type"], name: "index_hands_on_labs_on_lab_type"
    t.index ["programming_language"], name: "index_hands_on_labs_on_programming_language"
    t.index ["title"], name: "index_hands_on_labs_on_title"
  end

  create_table "interactive_learning_units", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "concept_explanation"
    t.string "command_to_learn"
    t.json "command_variations", default: []
    t.json "practice_hints", default: []
    t.text "scenario_description"
    t.json "scenario_steps", default: []
    t.string "difficulty_level"
    t.integer "estimated_minutes", default: 5
    t.integer "sequence_order", default: 0
    t.string "category"
    t.boolean "published", default: false
    t.string "quiz_question_text"
    t.string "quiz_question_type"
    t.json "quiz_options", default: []
    t.string "quiz_correct_answer"
    t.text "quiz_explanation"
    t.string "visual_aid_url"
    t.json "code_examples", default: []
    t.json "learning_objectives", default: []
    t.json "prerequisites", default: []
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "scenario_narrative"
    t.text "problem_statement"
    t.json "concept_tags", default: []
    t.json "required_commands", default: []
    t.index ["category"], name: "index_interactive_learning_units_on_category"
    t.index ["difficulty_level"], name: "index_interactive_learning_units_on_difficulty_level"
    t.index ["published"], name: "index_interactive_learning_units_on_published"
    t.index ["sequence_order"], name: "index_interactive_learning_units_on_sequence_order"
    t.index ["slug"], name: "index_interactive_learning_units_on_slug", unique: true
  end

  create_table "interests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "post_id", null: false
    t.string "database", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "post_id", "database"], name: "index_interests_on_user_id_and_post_id_and_database", unique: true
    t.index ["user_id"], name: "index_interests_on_user_id"
  end

  create_table "kubernetes_resources", force: :cascade do |t|
    t.string "resource_type", null: false
    t.string "name", null: false
    t.text "yaml_template", null: false
    t.text "explanation"
    t.string "difficulty", null: false
    t.string "category", null: false
    t.integer "exam_frequency", default: 5
    t.json "key_fields", default: {}
    t.text "common_errors"
    t.string "certification_exam"
    t.text "best_practices"
    t.json "related_resources", default: []
    t.integer "times_practiced", default: 0
    t.float "average_success_rate", default: 0.0
    t.boolean "is_deprecated", default: false
    t.string "kubernetes_version_min"
    t.string "api_version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["api_version"], name: "index_kubernetes_resources_on_api_version"
    t.index ["category", "difficulty"], name: "index_kubernetes_resources_on_category_and_difficulty"
    t.index ["category"], name: "index_kubernetes_resources_on_category"
    t.index ["certification_exam"], name: "index_kubernetes_resources_on_certification_exam"
    t.index ["difficulty", "exam_frequency"], name: "index_kubernetes_resources_on_difficulty_and_exam_frequency"
    t.index ["difficulty"], name: "index_kubernetes_resources_on_difficulty"
    t.index ["exam_frequency"], name: "index_kubernetes_resources_on_exam_frequency"
    t.index ["is_deprecated"], name: "index_kubernetes_resources_on_is_deprecated"
    t.index ["name"], name: "index_kubernetes_resources_on_name"
    t.index ["resource_type", "name"], name: "index_kubernetes_resources_on_resource_type_and_name", unique: true
    t.index ["resource_type"], name: "index_kubernetes_resources_on_resource_type"
  end

  create_table "lab_attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hands_on_lab_id", null: false
    t.integer "score"
    t.boolean "passed", default: false
    t.json "failed_commands", default: []
    t.datetime "retry_locked_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_lab_attempts_on_created_at"
    t.index ["hands_on_lab_id"], name: "index_lab_attempts_on_hands_on_lab_id"
    t.index ["user_id", "hands_on_lab_id"], name: "index_lab_attempts_on_user_id_and_hands_on_lab_id"
    t.index ["user_id"], name: "index_lab_attempts_on_user_id"
  end

  create_table "lab_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hands_on_lab_id", null: false
    t.string "container_id"
    t.string "status", default: "active", null: false
    t.json "progress_data", default: {}
    t.integer "current_step", default: 0
    t.integer "steps_completed", default: 0
    t.json "step_history", default: []
    t.json "commands_executed", default: []
    t.json "validation_results", default: {}
    t.integer "attempts_used", default: 0
    t.integer "hints_used", default: 0
    t.text "error_logs"
    t.integer "time_spent_seconds", default: 0
    t.float "completion_percentage", default: 0.0
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "expired_at"
    t.datetime "last_activity_at"
    t.boolean "passed", default: false
    t.integer "score", default: 0
    t.text "feedback"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "failed_concepts", default: []
    t.boolean "requires_remediation", default: false
    t.index ["completed_at"], name: "index_lab_sessions_on_completed_at"
    t.index ["container_id"], name: "index_lab_sessions_on_container_id", unique: true
    t.index ["hands_on_lab_id", "status"], name: "index_lab_sessions_on_hands_on_lab_id_and_status"
    t.index ["hands_on_lab_id"], name: "index_lab_sessions_on_hands_on_lab_id"
    t.index ["last_activity_at"], name: "index_lab_sessions_on_last_activity_at"
    t.index ["started_at"], name: "index_lab_sessions_on_started_at"
    t.index ["status"], name: "index_lab_sessions_on_status"
    t.index ["user_id", "hands_on_lab_id"], name: "index_lab_sessions_on_user_id_and_hands_on_lab_id"
    t.index ["user_id", "passed"], name: "index_lab_sessions_on_user_id_and_passed"
    t.index ["user_id", "status"], name: "index_lab_sessions_on_user_id_and_status"
    t.index ["user_id"], name: "index_lab_sessions_on_user_id"
  end

  create_table "learning_events", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "event_type", null: false
    t.string "event_category", null: false
    t.text "event_data", null: false
    t.text "skill_dimensions"
    t.decimal "performance_score", precision: 5, scale: 2
    t.integer "time_spent_seconds"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_category"], name: "index_learning_events_on_event_category"
    t.index ["event_type", "created_at"], name: "index_learning_events_on_event_type_and_created_at"
    t.index ["user_id", "created_at"], name: "index_learning_events_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_learning_events_on_user_id"
  end

  create_table "learning_paths", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "current_problem_id"
    t.string "current_topic"
    t.string "current_difficulty"
    t.decimal "overall_success_rate", precision: 5, scale: 2
    t.jsonb "topic_performance", default: {}
    t.jsonb "difficulty_performance", default: {}
    t.string "learning_style"
    t.integer "target_difficulty_level", default: 1
    t.jsonb "weak_topics", default: []
    t.jsonb "strong_topics", default: []
    t.jsonb "recommended_problems", default: []
    t.jsonb "prerequisite_queue", default: []
    t.integer "total_problems_attempted", default: 0
    t.integer "total_problems_solved", default: 0
    t.integer "current_streak", default: 0
    t.integer "longest_streak", default: 0
    t.datetime "last_activity_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["current_problem_id"], name: "index_learning_paths_on_current_problem_id"
    t.index ["user_id"], name: "index_learning_paths_on_user_id"
  end

  create_table "learning_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "session_id", null: false
    t.json "state_data", default: {}
    t.integer "items_presented", default: 0
    t.integer "items_correct", default: 0
    t.integer "items_failed", default: 0
    t.datetime "started_at", null: false
    t.datetime "last_activity_at"
    t.datetime "completed_at"
    t.string "completion_reason"
    t.json "performance_metrics", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["last_activity_at"], name: "index_learning_sessions_on_last_activity_at"
    t.index ["session_id"], name: "index_learning_sessions_on_session_id", unique: true
    t.index ["user_id", "completed_at"], name: "index_learning_sessions_on_user_id_and_completed_at"
    t.index ["user_id", "started_at"], name: "index_learning_sessions_on_user_id_and_started_at"
    t.index ["user_id"], name: "index_learning_sessions_on_user_id"
  end

  create_table "learning_unit_progresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "interactive_learning_unit_id", null: false
    t.boolean "explanation_read", default: false
    t.boolean "practice_completed", default: false
    t.boolean "quiz_answered", default: false
    t.boolean "scenario_completed", default: false
    t.integer "practice_attempts", default: 0
    t.integer "quiz_attempts", default: 0
    t.integer "scenario_attempts", default: 0
    t.integer "time_spent_seconds", default: 0
    t.string "practice_user_answer"
    t.boolean "practice_correct", default: false
    t.string "quiz_user_answer"
    t.boolean "quiz_correct", default: false
    t.float "mastery_score", default: 0.0
    t.datetime "last_practiced_at"
    t.datetime "next_review_at"
    t.integer "review_count", default: 0
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "hints_viewed", default: []
    t.boolean "refresher_accessed", default: false
    t.index ["completed"], name: "index_learning_unit_progresses_on_completed"
    t.index ["interactive_learning_unit_id"], name: "index_learning_unit_progresses_on_interactive_learning_unit_id"
    t.index ["mastery_score"], name: "index_learning_unit_progresses_on_mastery_score"
    t.index ["next_review_at"], name: "index_learning_unit_progresses_on_next_review_at"
    t.index ["user_id", "interactive_learning_unit_id"], name: "index_learning_progress_on_user_and_unit", unique: true
    t.index ["user_id"], name: "index_learning_unit_progresses_on_user_id"
  end

  create_table "lesson_completions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_lesson_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_lesson_id"], name: "index_lesson_completions_on_course_lesson_id"
    t.index ["user_id", "course_lesson_id"], name: "index_lesson_completions_on_user_id_and_course_lesson_id", unique: true
    t.index ["user_id"], name: "index_lesson_completions_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "micro_lesson_progresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "micro_lesson_id", null: false
    t.boolean "completed", default: false
    t.integer "exercises_completed", default: 0
    t.integer "total_exercises", default: 0
    t.integer "time_spent_seconds", default: 0
    t.float "mastery_score", default: 0.0
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["completed"], name: "index_micro_lesson_progresses_on_completed"
    t.index ["micro_lesson_id"], name: "index_micro_lesson_progresses_on_micro_lesson_id"
    t.index ["user_id", "micro_lesson_id"], name: "index_ml_progress_on_user_and_lesson", unique: true
    t.index ["user_id"], name: "index_micro_lesson_progresses_on_user_id"
  end

  create_table "micro_lessons", force: :cascade do |t|
    t.bigint "course_module_id", null: false
    t.bigint "topic_group_id"
    t.string "title", null: false
    t.string "slug", null: false
    t.text "content"
    t.integer "sequence_order", default: 0, null: false
    t.integer "estimated_minutes", default: 2
    t.string "difficulty", default: "medium"
    t.jsonb "key_concepts", default: []
    t.jsonb "prerequisite_ids", default: []
    t.boolean "published", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_module_id", "sequence_order"], name: "index_micro_lessons_on_course_module_id_and_sequence_order"
    t.index ["course_module_id"], name: "index_micro_lessons_on_course_module_id"
    t.index ["slug"], name: "index_micro_lessons_on_slug", unique: true
    t.index ["topic_group_id"], name: "index_micro_lessons_on_topic_group_id"
  end

  create_table "milestone_exams", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "quiz_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "module_range_start", null: false
    t.integer "module_range_end", null: false
    t.integer "sequence_order", default: 0, null: false
    t.integer "passing_score", default: 75
    t.boolean "required", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id", "sequence_order"], name: "index_milestone_exams_on_course_id_and_sequence_order"
    t.index ["course_id"], name: "index_milestone_exams_on_course_id"
    t.index ["module_range_start", "module_range_end"], name: "index_milestone_exams_on_range"
    t.index ["quiz_id"], name: "index_milestone_exams_on_quiz_id"
  end

  create_table "module_interactive_units", force: :cascade do |t|
    t.bigint "course_module_id", null: false
    t.bigint "interactive_learning_unit_id", null: false
    t.integer "sequence_order", null: false
    t.boolean "required", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_module_id", "interactive_learning_unit_id"], name: "index_module_units_unique", unique: true
    t.index ["course_module_id", "sequence_order"], name: "index_module_units_on_module_and_order"
    t.index ["course_module_id"], name: "index_module_interactive_units_on_course_module_id"
    t.index ["interactive_learning_unit_id"], name: "index_module_interactive_units_on_interactive_learning_unit_id"
  end

  create_table "module_items", force: :cascade do |t|
    t.bigint "course_module_id", null: false
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.integer "sequence_order", null: false
    t.boolean "required", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_module_id", "sequence_order"], name: "index_module_items_on_course_module_id_and_sequence_order"
    t.index ["course_module_id"], name: "index_module_items_on_course_module_id"
    t.index ["item_type", "item_id"], name: "index_module_items_on_item_type_and_item_id"
  end

  create_table "module_progresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_module_id", null: false
    t.bigint "course_enrollment_id", null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer "completion_percentage", default: 0
    t.integer "items_completed", default: 0
    t.integer "total_items", default: 0
    t.string "status", default: "not_started"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_enrollment_id"], name: "index_module_progresses_on_course_enrollment_id"
    t.index ["course_module_id"], name: "index_module_progresses_on_course_module_id"
    t.index ["user_id", "course_module_id"], name: "index_module_progresses_on_user_id_and_course_module_id", unique: true
    t.index ["user_id"], name: "index_module_progresses_on_user_id"
  end

  create_table "problem_attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "problem_id", null: false
    t.boolean "success", default: false
    t.integer "time_spent_seconds"
    t.text "submitted_code"
    t.jsonb "test_results", default: []
    t.integer "hints_used", default: 0
    t.jsonb "hints_viewed", default: []
    t.integer "attempts_count", default: 1
    t.boolean "gave_up", default: false
    t.boolean "viewed_solution", default: false
    t.integer "syntax_errors", default: 0
    t.integer "logic_errors", default: 0
    t.integer "compilation_errors", default: 0
    t.string "confidence_level"
    t.text "user_notes"
    t.jsonb "code_execution_history", default: []
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confidence_level"], name: "index_problem_attempts_on_confidence_level"
    t.index ["created_at"], name: "index_problem_attempts_on_created_at"
    t.index ["problem_id"], name: "index_problem_attempts_on_problem_id"
    t.index ["user_id", "problem_id"], name: "index_problem_attempts_on_user_id_and_problem_id"
    t.index ["user_id", "success"], name: "index_problem_attempts_on_user_id_and_success"
    t.index ["user_id"], name: "index_problem_attempts_on_user_id"
  end

  create_table "problems", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "sample_input"
    t.text "sample_output"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "difficulty"
    t.string "topic"
    t.string "subtopic"
    t.string "family_id"
    t.jsonb "examples", default: []
    t.jsonb "constraints", default: []
    t.jsonb "test_cases", default: []
    t.jsonb "hints", default: []
    t.jsonb "tags", default: []
    t.jsonb "related_problems", default: []
    t.jsonb "prerequisites", default: []
    t.jsonb "companies", default: []
    t.jsonb "starter_code", default: {}
    t.jsonb "follow_ups", default: []
    t.text "solution_approach"
    t.string "time_complexity"
    t.string "space_complexity"
    t.string "frequency"
    t.decimal "success_rate", precision: 5, scale: 2
    t.integer "estimated_time_mins"
    t.integer "points"
    t.integer "total_attempts", default: 0
    t.integer "successful_attempts", default: 0
    t.decimal "average_time_spent", precision: 10, scale: 2
    t.index ["difficulty"], name: "index_problems_on_difficulty"
    t.index ["family_id"], name: "index_problems_on_family_id"
    t.index ["slug"], name: "index_problems_on_slug", unique: true
    t.index ["tags"], name: "index_problems_on_tags", using: :gin
    t.index ["topic"], name: "index_problems_on_topic"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "email"
    t.string "name"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "difficulty"
    t.string "url_link"
    t.boolean "solved"
    t.date "solved_date"
    t.integer "confidence_level"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_questions_on_lesson_id"
  end

  create_table "quiz_attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quiz_id", null: false
    t.bigint "course_enrollment_id"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer "score"
    t.integer "total_questions"
    t.integer "correct_answers", default: 0
    t.text "answers"
    t.integer "time_taken_seconds"
    t.boolean "passed", default: false
    t.integer "attempt_number", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_enrollment_id"], name: "index_quiz_attempts_on_course_enrollment_id"
    t.index ["passed"], name: "index_quiz_attempts_on_passed"
    t.index ["quiz_id"], name: "index_quiz_attempts_on_quiz_id"
    t.index ["user_id", "quiz_id"], name: "index_quiz_attempts_on_user_id_and_quiz_id"
    t.index ["user_id"], name: "index_quiz_attempts_on_user_id"
  end

  create_table "quiz_question_lesson_mappings", force: :cascade do |t|
    t.bigint "quiz_question_id", null: false
    t.bigint "course_lesson_id", null: false
    t.string "section_anchor"
    t.integer "relevance_weight", default: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_lesson_id"], name: "index_quiz_question_lesson_mappings_on_course_lesson_id"
    t.index ["quiz_question_id", "course_lesson_id"], name: "index_mappings_on_question_and_lesson"
    t.index ["quiz_question_id"], name: "index_quiz_question_lesson_mappings_on_quiz_question_id"
    t.index ["relevance_weight"], name: "index_quiz_question_lesson_mappings_on_relevance_weight"
  end

  create_table "quiz_question_pools", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.bigint "exercise_id", null: false
    t.float "weight", default: 1.0
    t.string "difficulty_override"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_id"], name: "index_quiz_question_pools_on_exercise_id"
    t.index ["quiz_id", "exercise_id"], name: "index_quiz_question_pools_on_quiz_id_and_exercise_id", unique: true
    t.index ["quiz_id"], name: "index_quiz_question_pools_on_quiz_id"
    t.index ["weight"], name: "index_quiz_question_pools_on_weight"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.string "question_type", null: false
    t.text "question_text", null: false
    t.text "options"
    t.text "correct_answer"
    t.text "explanation"
    t.integer "points", default: 1
    t.string "difficulty_level"
    t.text "tags"
    t.integer "sequence_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "difficulty", precision: 4, scale: 2, default: "0.0", null: false
    t.decimal "discrimination", precision: 4, scale: 2, default: "1.0", null: false
    t.decimal "guessing", precision: 4, scale: 2, default: "0.2", null: false
    t.string "topic"
    t.string "skill_dimension"
    t.decimal "tolerance", precision: 10, scale: 6, default: "0.01"
    t.boolean "multiple_correct", default: false
    t.json "sequence_items", default: "[]"
    t.string "image_url"
    t.index ["difficulty_level"], name: "index_quiz_questions_on_difficulty_level"
    t.index ["question_type"], name: "index_quiz_questions_on_question_type"
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
    t.index ["skill_dimension", "difficulty"], name: "index_quiz_questions_on_skill_dimension_and_difficulty"
    t.index ["skill_dimension"], name: "index_quiz_questions_on_skill_dimension"
    t.index ["topic"], name: "index_quiz_questions_on_topic"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "time_limit_minutes"
    t.integer "passing_score", default: 70
    t.integer "max_attempts"
    t.boolean "shuffle_questions", default: true
    t.boolean "show_correct_answers", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "metadata"
    t.string "quiz_type"
    t.string "assessment_level", default: "module"
    t.jsonb "source_module_ids", default: []
    t.jsonb "adaptive_config", default: {}
    t.index ["assessment_level"], name: "index_quizzes_on_assessment_level"
    t.index ["source_module_ids"], name: "index_quizzes_on_source_module_ids", using: :gin
  end

  create_table "remediation_activities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quiz_attempt_id", null: false
    t.bigint "quiz_question_id", null: false
    t.bigint "course_lesson_id", null: false
    t.boolean "lesson_reviewed", default: false
    t.boolean "improved_on_retry", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_lesson_id"], name: "index_remediation_activities_on_course_lesson_id"
    t.index ["lesson_reviewed"], name: "index_remediation_activities_on_lesson_reviewed"
    t.index ["quiz_attempt_id"], name: "index_remediation_activities_on_quiz_attempt_id"
    t.index ["quiz_question_id"], name: "index_remediation_activities_on_quiz_question_id"
    t.index ["user_id", "created_at"], name: "index_remediation_activities_on_user_id_and_created_at"
    t.index ["user_id", "quiz_question_id"], name: "index_remediation_on_user_and_question"
    t.index ["user_id"], name: "index_remediation_activities_on_user_id"
  end

  create_table "remediation_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "enrollment_id", null: false
    t.string "trigger_item_type"
    t.integer "trigger_item_id"
    t.json "weak_concepts", default: []
    t.json "review_items", default: []
    t.integer "items_completed", default: 0
    t.integer "items_total", default: 0
    t.boolean "completed", default: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enrollment_id", "status"], name: "index_remediation_sessions_on_enrollment_id_and_status"
    t.index ["enrollment_id"], name: "index_remediation_sessions_on_enrollment_id"
    t.index ["trigger_item_type", "trigger_item_id"], name: "index_remediation_sessions_on_trigger_item"
    t.index ["user_id", "status"], name: "index_remediation_sessions_on_user_id_and_status"
    t.index ["user_id"], name: "index_remediation_sessions_on_user_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.date "reminder_date"
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_reminders_on_question_id"
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "review_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_enrollment_id", null: false
    t.bigint "course_id", null: false
    t.integer "days_since_last_visit", null: false
    t.string "review_type"
    t.jsonb "items_to_review", default: []
    t.jsonb "review_modules", default: []
    t.integer "items_reviewed", default: 0
    t.integer "total_items", default: 0
    t.integer "score", default: 0
    t.boolean "completed", default: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer "time_spent_seconds", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["completed"], name: "index_review_sessions_on_completed"
    t.index ["course_enrollment_id"], name: "index_review_sessions_on_course_enrollment_id"
    t.index ["course_id"], name: "index_review_sessions_on_course_id"
    t.index ["created_at"], name: "index_review_sessions_on_created_at"
    t.index ["review_type"], name: "index_review_sessions_on_review_type"
    t.index ["user_id", "course_id"], name: "index_review_sessions_on_user_id_and_course_id"
    t.index ["user_id"], name: "index_review_sessions_on_user_id"
  end

  create_table "solutions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "problem_id"
    t.string "code"
    t.string "status"
    t.string "execution_result"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "test_cases"
  end

  create_table "spaced_repetition_items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "coding_problem_id"
    t.datetime "next_review_at", null: false
    t.integer "interval_days", default: 1
    t.integer "ease_factor", default: 250
    t.string "state", default: "new"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "difficulty", precision: 4, scale: 2, comment: "FSRS difficulty rating (1-10, typically 3-7)"
    t.decimal "stability", precision: 6, scale: 2, comment: "FSRS stability in days (memory strength)"
    t.integer "elapsed_days", comment: "Days elapsed since last review"
    t.integer "review_count", default: 0, comment: "Total number of reviews"
    t.integer "lapse_count", default: 0, comment: "Number of times recalled incorrectly"
    t.string "last_grade", comment: "Last review grade (again/hard/good/easy)"
    t.decimal "average_grade", precision: 3, scale: 2, comment: "Average grade across all reviews"
    t.decimal "retention_rate", precision: 3, scale: 2, comment: "Calculated retention probability"
    t.json "user_params", comment: "User-specific FSRS parameter overrides"
    t.string "reviewable_type"
    t.integer "reviewable_id"
    t.string "item_type"
    t.integer "item_id"
    t.integer "last_review_grade"
    t.integer "review_after_points"
    t.integer "progress_interval"
    t.integer "points_since_review", default: 0
    t.integer "last_review_points"
    t.index ["coding_problem_id"], name: "index_spaced_repetition_items_on_coding_problem_id"
    t.index ["difficulty"], name: "index_spaced_repetition_items_on_difficulty"
    t.index ["item_type", "item_id"], name: "index_spaced_repetition_items_on_item_type_and_item_id"
    t.index ["next_review_at"], name: "index_spaced_repetition_items_on_next_review_at"
    t.index ["points_since_review"], name: "index_spaced_repetition_items_on_points_since_review"
    t.index ["review_after_points"], name: "index_spaced_repetition_items_on_review_after_points"
    t.index ["reviewable_type", "reviewable_id"], name: "index_sri_on_reviewable"
    t.index ["stability"], name: "index_spaced_repetition_items_on_stability"
    t.index ["user_id", "coding_problem_id"], name: "index_sri_on_user_and_problem", unique: true
    t.index ["user_id", "item_type", "item_id"], name: "index_sri_on_user_item", unique: true
    t.index ["user_id", "lapse_count"], name: "index_sri_on_user_and_lapses"
    t.index ["user_id"], name: "index_spaced_repetition_items_on_user_id"
  end

  create_table "stealth_reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "canonical_command", null: false
    t.integer "priority", default: 5
    t.string "status", default: "queued"
    t.string "strategy"
    t.datetime "requested_at"
    t.datetime "scheduled_for"
    t.datetime "completed_at"
    t.boolean "success"
    t.integer "response_time"
    t.text "context_data"
    t.integer "stealth_level", default: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["priority", "requested_at"], name: "index_stealth_reviews_on_priority_and_requested_at"
    t.index ["scheduled_for"], name: "index_stealth_reviews_on_scheduled_for"
    t.index ["user_id", "canonical_command"], name: "index_stealth_reviews_on_user_id_and_canonical_command"
    t.index ["user_id", "status"], name: "index_stealth_reviews_on_user_id_and_status"
    t.index ["user_id"], name: "index_stealth_reviews_on_user_id"
  end

  create_table "study_plans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "daily_target", default: 30
    t.integer "weekly_target", default: 5
    t.date "estimated_completion_date"
    t.string "status", default: "active"
    t.integer "progress_percentage", default: 0
    t.text "milestones"
    t.date "start_date"
    t.integer "actual_days_studied", default: 0
    t.integer "total_time_spent", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_study_plans_on_course_id"
    t.index ["status"], name: "index_study_plans_on_status"
    t.index ["user_id", "status"], name: "index_study_plans_on_user_id_and_status"
    t.index ["user_id"], name: "index_study_plans_on_user_id"
  end

  create_table "topic_groups", force: :cascade do |t|
    t.bigint "course_module_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "sequence_order", default: 0, null: false
    t.string "icon"
    t.string "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_module_id", "sequence_order"], name: "index_topic_groups_on_course_module_id_and_sequence_order"
    t.index ["course_module_id"], name: "index_topic_groups_on_course_module_id"
  end

  create_table "upsc_daily_tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "upsc_study_plan_id"
    t.date "task_date", null: false
    t.string "task_type"
    t.string "title", null: false
    t.text "description"
    t.bigint "upsc_topic_id"
    t.integer "estimated_minutes"
    t.integer "actual_minutes"
    t.string "priority", default: "medium"
    t.string "status", default: "pending"
    t.datetime "completed_at"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_upsc_daily_tasks_on_status"
    t.index ["task_date", "status"], name: "index_upsc_daily_tasks_on_task_date_and_status"
    t.index ["upsc_study_plan_id"], name: "index_upsc_daily_tasks_on_upsc_study_plan_id"
    t.index ["upsc_topic_id"], name: "index_upsc_daily_tasks_on_upsc_topic_id"
    t.index ["user_id", "task_date"], name: "index_upsc_daily_tasks_on_user_id_and_task_date"
    t.index ["user_id"], name: "index_upsc_daily_tasks_on_user_id"
  end

  create_table "upsc_news_articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "summary"
    t.text "full_content", null: false
    t.string "source"
    t.string "source_url"
    t.string "author"
    t.date "published_date", null: false
    t.text "categories", default: [], array: true
    t.text "tags", default: [], array: true
    t.integer "relevance_score", default: 50
    t.string "importance_level"
    t.boolean "is_featured", default: false
    t.string "image_url"
    t.bigint "related_topic_ids", default: [], array: true
    t.bigint "related_subject_ids", default: [], array: true
    t.text "exam_perspective"
    t.text "key_points", default: [], array: true
    t.integer "view_count", default: 0
    t.integer "like_count", default: 0
    t.string "status", default: "published"
    t.bigint "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["categories"], name: "index_upsc_news_articles_on_categories", using: :gin
    t.index ["created_by_id"], name: "index_upsc_news_articles_on_created_by_id"
    t.index ["is_featured"], name: "index_upsc_news_articles_on_is_featured"
    t.index ["published_date"], name: "index_upsc_news_articles_on_published_date"
    t.index ["slug"], name: "index_upsc_news_articles_on_slug", unique: true
    t.index ["tags"], name: "index_upsc_news_articles_on_tags", using: :gin
  end

  create_table "upsc_questions", force: :cascade do |t|
    t.bigint "upsc_subject_id"
    t.bigint "upsc_topic_id"
    t.string "question_type", null: false
    t.string "difficulty"
    t.decimal "marks", precision: 5, scale: 2, default: "1.0"
    t.decimal "negative_marks", precision: 5, scale: 2, default: "0.0"
    t.integer "time_limit_seconds"
    t.text "question_text", null: false
    t.string "question_image_url"
    t.jsonb "options"
    t.text "correct_answer", null: false
    t.text "explanation"
    t.string "explanation_video_url"
    t.text "hints", default: [], array: true
    t.integer "pyq_year"
    t.string "pyq_paper"
    t.integer "pyq_question_number"
    t.string "source"
    t.text "tags", default: [], array: true
    t.integer "relevance_score", default: 50
    t.integer "attempt_count", default: 0
    t.integer "correct_attempt_count", default: 0
    t.integer "average_time_taken_seconds"
    t.string "status", default: "active"
    t.bigint "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_upsc_questions_on_created_by_id"
    t.index ["difficulty"], name: "index_upsc_questions_on_difficulty"
    t.index ["pyq_year"], name: "index_upsc_questions_on_pyq_year"
    t.index ["question_type"], name: "index_upsc_questions_on_question_type"
    t.index ["status"], name: "index_upsc_questions_on_status"
    t.index ["upsc_subject_id", "upsc_topic_id"], name: "index_upsc_questions_on_upsc_subject_id_and_upsc_topic_id"
    t.index ["upsc_subject_id"], name: "index_upsc_questions_on_upsc_subject_id"
    t.index ["upsc_topic_id"], name: "index_upsc_questions_on_upsc_topic_id"
  end

  create_table "upsc_revisions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "upsc_topic_id"
    t.string "revision_type"
    t.date "scheduled_for", null: false
    t.datetime "completed_at"
    t.integer "interval_index", default: 0
    t.integer "performance_rating"
    t.integer "time_spent_minutes"
    t.text "notes"
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["scheduled_for", "status"], name: "index_upsc_revisions_on_scheduled_for_and_status"
    t.index ["status"], name: "index_upsc_revisions_on_status"
    t.index ["upsc_topic_id"], name: "index_upsc_revisions_on_upsc_topic_id"
    t.index ["user_id", "scheduled_for"], name: "index_upsc_revisions_on_user_id_and_scheduled_for"
    t.index ["user_id"], name: "index_upsc_revisions_on_user_id"
  end

  create_table "upsc_student_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "target_exam_date"
    t.integer "attempt_number", default: 1
    t.bigint "optional_subject_id"
    t.string "medium_of_exam", default: "english"
    t.jsonb "previous_attempt_details", default: {}
    t.text "educational_background"
    t.string "current_occupation"
    t.text "work_experience"
    t.integer "study_hours_per_day"
    t.string "preferred_study_time"
    t.jsonb "daf_details", default: {}
    t.text "strengths", default: [], array: true
    t.text "weaknesses", default: [], array: true
    t.text "goals"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attempt_number"], name: "index_upsc_student_profiles_on_attempt_number"
    t.index ["optional_subject_id"], name: "index_upsc_student_profiles_on_optional_subject_id"
    t.index ["target_exam_date"], name: "index_upsc_student_profiles_on_target_exam_date"
    t.index ["user_id"], name: "index_upsc_student_profiles_on_user_id", unique: true
  end

  create_table "upsc_study_plans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "plan_name"
    t.date "start_date", null: false
    t.date "target_exam_date", null: false
    t.integer "total_days"
    t.jsonb "phase_breakdown"
    t.jsonb "daily_schedule"
    t.boolean "is_active", default: true
    t.integer "completion_percentage", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["target_exam_date"], name: "index_upsc_study_plans_on_target_exam_date"
    t.index ["user_id", "is_active"], name: "index_upsc_study_plans_on_user_id_and_is_active"
    t.index ["user_id"], name: "index_upsc_study_plans_on_user_id"
  end

  create_table "upsc_subjects", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "exam_type", null: false
    t.integer "paper_number"
    t.integer "total_marks"
    t.integer "duration_minutes"
    t.text "description"
    t.string "syllabus_pdf_url"
    t.boolean "is_optional", default: false
    t.boolean "is_active", default: true
    t.integer "order_index"
    t.string "icon_url"
    t.string "color_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_upsc_subjects_on_code", unique: true
    t.index ["exam_type"], name: "index_upsc_subjects_on_exam_type"
    t.index ["is_optional"], name: "index_upsc_subjects_on_is_optional"
    t.index ["order_index"], name: "index_upsc_subjects_on_order_index"
  end

  create_table "upsc_test_questions", force: :cascade do |t|
    t.bigint "upsc_test_id", null: false
    t.bigint "upsc_question_id", null: false
    t.decimal "marks", precision: 5, scale: 2, null: false
    t.decimal "negative_marks", precision: 5, scale: 2, default: "0.0"
    t.integer "order_index", null: false
    t.string "section"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_index"], name: "index_upsc_test_questions_on_order_index"
    t.index ["upsc_question_id"], name: "index_upsc_test_questions_on_upsc_question_id"
    t.index ["upsc_test_id", "upsc_question_id"], name: "index_test_questions_unique", unique: true
    t.index ["upsc_test_id"], name: "index_upsc_test_questions_on_upsc_test_id"
  end

  create_table "upsc_tests", force: :cascade do |t|
    t.string "test_type", null: false
    t.string "title", null: false
    t.text "description"
    t.text "instructions"
    t.bigint "upsc_subject_id"
    t.integer "duration_minutes", null: false
    t.decimal "total_marks", precision: 7, scale: 2, null: false
    t.decimal "passing_marks", precision: 7, scale: 2
    t.boolean "negative_marking_enabled", default: true
    t.decimal "negative_marking_ratio", precision: 3, scale: 2, default: "0.33"
    t.boolean "is_live", default: false
    t.boolean "is_free", default: false
    t.datetime "scheduled_at"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "result_publish_at"
    t.integer "max_attempts", default: 1
    t.boolean "shuffle_questions", default: true
    t.boolean "shuffle_options", default: true
    t.boolean "show_answers_after_submit", default: true
    t.string "difficulty_level"
    t.text "tags", default: [], array: true
    t.bigint "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_upsc_tests_on_created_by_id"
    t.index ["is_live"], name: "index_upsc_tests_on_is_live"
    t.index ["scheduled_at"], name: "index_upsc_tests_on_scheduled_at"
    t.index ["test_type"], name: "index_upsc_tests_on_test_type"
    t.index ["upsc_subject_id"], name: "index_upsc_tests_on_upsc_subject_id"
  end

  create_table "upsc_topics", force: :cascade do |t|
    t.bigint "upsc_subject_id", null: false
    t.bigint "parent_topic_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.string "difficulty_level"
    t.decimal "estimated_hours", precision: 5, scale: 2
    t.integer "order_index"
    t.boolean "is_high_yield", default: false
    t.integer "pyq_frequency", default: 0
    t.text "tags", default: [], array: true
    t.text "learning_objectives", default: [], array: true
    t.bigint "prerequisite_topic_ids", default: [], array: true
    t.bigint "course_lesson_id"
    t.bigint "course_module_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_lesson_id"], name: "index_upsc_topics_on_course_lesson_id"
    t.index ["course_module_id"], name: "index_upsc_topics_on_course_module_id"
    t.index ["difficulty_level"], name: "index_upsc_topics_on_difficulty_level"
    t.index ["is_high_yield"], name: "index_upsc_topics_on_is_high_yield"
    t.index ["order_index"], name: "index_upsc_topics_on_order_index"
    t.index ["parent_topic_id"], name: "index_upsc_topics_on_parent_topic_id"
    t.index ["upsc_subject_id", "slug"], name: "index_upsc_topics_on_upsc_subject_id_and_slug", unique: true
    t.index ["upsc_subject_id"], name: "index_upsc_topics_on_upsc_subject_id"
  end

  create_table "upsc_user_answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "upsc_writing_question_id", null: false
    t.text "answer_text", null: false
    t.integer "word_count"
    t.integer "time_taken_minutes"
    t.string "submission_type", default: "typed"
    t.string "file_url"
    t.datetime "submitted_at", null: false
    t.jsonb "ai_evaluation"
    t.decimal "ai_score", precision: 5, scale: 2
    t.datetime "ai_evaluated_at"
    t.jsonb "mentor_evaluation"
    t.decimal "mentor_score", precision: 5, scale: 2
    t.datetime "mentor_evaluated_at"
    t.bigint "evaluator_id"
    t.decimal "final_score", precision: 5, scale: 2
    t.string "status", default: "submitted"
    t.integer "revision_number", default: 1
    t.bigint "original_answer_id"
    t.boolean "is_public", default: false
    t.integer "like_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evaluator_id"], name: "index_upsc_user_answers_on_evaluator_id"
    t.index ["original_answer_id"], name: "index_upsc_user_answers_on_original_answer_id"
    t.index ["status"], name: "index_upsc_user_answers_on_status"
    t.index ["submitted_at"], name: "index_upsc_user_answers_on_submitted_at"
    t.index ["upsc_writing_question_id"], name: "index_upsc_user_answers_on_upsc_writing_question_id"
    t.index ["user_id", "upsc_writing_question_id"], name: "index_user_answers_on_user_and_question"
    t.index ["user_id"], name: "index_upsc_user_answers_on_user_id"
  end

  create_table "upsc_user_progress", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "upsc_topic_id", null: false
    t.string "status", default: "not_started"
    t.integer "completion_percentage", default: 0
    t.integer "confidence_level"
    t.integer "time_spent_minutes", default: 0
    t.datetime "last_accessed_at"
    t.datetime "first_started_at"
    t.datetime "completed_at"
    t.datetime "mastered_at"
    t.text "notes"
    t.boolean "bookmarked", default: false
    t.integer "revision_count", default: 0
    t.datetime "last_revised_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["last_accessed_at"], name: "index_upsc_user_progress_on_last_accessed_at"
    t.index ["status"], name: "index_upsc_user_progress_on_status"
    t.index ["upsc_topic_id"], name: "index_upsc_user_progress_on_upsc_topic_id"
    t.index ["user_id", "upsc_topic_id"], name: "index_upsc_user_progress_unique", unique: true
    t.index ["user_id"], name: "index_upsc_user_progress_on_user_id"
  end

  create_table "upsc_user_test_attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "upsc_test_id", null: false
    t.integer "attempt_number", default: 1
    t.datetime "started_at", null: false
    t.datetime "submitted_at"
    t.integer "time_taken_minutes"
    t.decimal "score", precision: 7, scale: 2
    t.decimal "percentage", precision: 5, scale: 2
    t.decimal "percentile", precision: 5, scale: 2
    t.integer "rank"
    t.integer "total_questions"
    t.integer "correct_answers", default: 0
    t.integer "wrong_answers", default: 0
    t.integer "unanswered", default: 0
    t.jsonb "answers", default: {}
    t.jsonb "question_wise_time", default: {}
    t.jsonb "analysis", default: {}
    t.string "status", default: "in_progress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_upsc_user_test_attempts_on_status"
    t.index ["submitted_at"], name: "index_upsc_user_test_attempts_on_submitted_at"
    t.index ["upsc_test_id"], name: "index_upsc_user_test_attempts_on_upsc_test_id"
    t.index ["user_id", "upsc_test_id"], name: "index_upsc_user_test_attempts_on_user_id_and_upsc_test_id"
    t.index ["user_id"], name: "index_upsc_user_test_attempts_on_user_id"
  end

  create_table "upsc_writing_questions", force: :cascade do |t|
    t.bigint "upsc_subject_id"
    t.bigint "upsc_topic_id"
    t.string "question_type"
    t.text "question_text", null: false
    t.text "question_context"
    t.integer "word_limit"
    t.decimal "marks", precision: 5, scale: 2, default: "10.0"
    t.integer "time_limit_minutes"
    t.string "difficulty"
    t.text "directive_keywords", default: [], array: true
    t.jsonb "evaluation_criteria"
    t.text "model_answer"
    t.string "model_answer_url"
    t.text "key_points", default: [], array: true
    t.jsonb "suggested_structure"
    t.integer "pyq_year"
    t.string "pyq_paper"
    t.text "tags", default: [], array: true
    t.date "current_affairs_date"
    t.integer "relevance_score", default: 50
    t.bigint "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_upsc_writing_questions_on_created_by_id"
    t.index ["current_affairs_date"], name: "index_upsc_writing_questions_on_current_affairs_date"
    t.index ["pyq_year"], name: "index_upsc_writing_questions_on_pyq_year"
    t.index ["question_type"], name: "index_upsc_writing_questions_on_question_type"
    t.index ["upsc_subject_id"], name: "index_upsc_writing_questions_on_upsc_subject_id"
    t.index ["upsc_topic_id"], name: "index_upsc_writing_questions_on_upsc_topic_id"
  end

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "user_id"
    t.string "achievement_type"
    t.string "tag"
    t.string "module_id"
    t.datetime "achieved_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "achievement_type", "tag", "module_id"], name: "idx_user_achievements", unique: true
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "user_command_masteries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "canonical_command", null: false
    t.string "command_category"
    t.integer "total_attempts", default: 0
    t.integer "successful_attempts", default: 0
    t.decimal "proficiency_score", precision: 5, scale: 2, default: "0.0"
    t.json "context_performance", default: {}
    t.datetime "last_used_at"
    t.datetime "last_correct_at"
    t.datetime "first_mastered_at"
    t.decimal "decay_rate", precision: 5, scale: 2, default: "1.0"
    t.datetime "last_decay_calculation_at"
    t.json "shields", default: []
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "last_decay_applied_at"
    t.float "strength_factor"
    t.integer "shields_count", default: 0
    t.datetime "last_practiced_at"
    t.text "contexts_seen"
    t.integer "chapters_at_mastery"
    t.integer "learning_path_position"
    t.decimal "stability", precision: 6, scale: 2, default: "7.0"
    t.integer "consecutive_successes", default: 0
    t.integer "consecutive_failures", default: 0
    t.boolean "saw_answer_last", default: false
    t.integer "hints_used_last", default: 0
    t.index ["chapters_at_mastery"], name: "index_user_command_masteries_on_chapters_at_mastery"
    t.index ["command_category"], name: "index_user_command_masteries_on_command_category"
    t.index ["last_decay_applied_at"], name: "index_user_command_masteries_on_last_decay_applied_at"
    t.index ["last_used_at"], name: "index_user_command_masteries_on_last_used_at"
    t.index ["learning_path_position"], name: "index_user_command_masteries_on_learning_path_position"
    t.index ["proficiency_score"], name: "index_user_command_masteries_on_proficiency_score"
    t.index ["user_id", "canonical_command"], name: "idx_user_command_unique", unique: true
    t.index ["user_id"], name: "index_user_command_masteries_on_user_id"
  end

  create_table "user_course_achievements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_achievement_id", null: false
    t.datetime "earned_at"
    t.text "metadata"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_achievement_id"], name: "index_user_course_achievements_on_course_achievement_id"
    t.index ["user_id", "course_achievement_id"], name: "index_user_course_achievements_unique", unique: true
    t.index ["user_id"], name: "index_user_course_achievements_on_user_id"
  end

  create_table "user_course_enrollments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "tag"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "tag"], name: "index_user_course_enrollments_on_user_id_and_tag", unique: true
    t.index ["user_id"], name: "index_user_course_enrollments_on_user_id"
  end

  create_table "user_course_progresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "tag"
    t.string "question_id"
    t.string "module_id"
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "tag", "question_id"], name: "idx_user_course_progress", unique: true
    t.index ["user_id"], name: "index_user_course_progresses_on_user_id"
  end

  create_table "user_lessons", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.integer "progress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_user_lessons_on_lesson_id"
    t.index ["user_id"], name: "index_user_lessons_on_user_id"
  end

  create_table "user_skill_dimensions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "dimension", limit: 50, null: false
    t.decimal "ability_estimate", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "standard_error", precision: 5, scale: 2, default: "1.5", null: false
    t.decimal "confidence_lower", precision: 5, scale: 2
    t.decimal "confidence_upper", precision: 5, scale: 2
    t.integer "n_observations", default: 0
    t.datetime "last_updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["last_updated_at"], name: "index_user_skill_dimensions_on_last_updated_at"
    t.index ["user_id", "dimension"], name: "index_user_skill_dimensions_on_user_id_and_dimension", unique: true
    t.index ["user_id"], name: "index_user_skill_dimensions_on_user_id"
  end

  create_table "user_stats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "total_points", default: 0
    t.integer "current_streak_days", default: 0
    t.integer "longest_streak_days", default: 0
    t.datetime "last_activity_at"
    t.integer "courses_completed", default: 0
    t.integer "labs_completed", default: 0
    t.integer "quizzes_passed", default: 0
    t.integer "total_study_minutes", default: 0
    t.text "weak_areas"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["total_points"], name: "index_user_stats_on_total_points"
    t.index ["user_id"], name: "index_user_stats_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "access_token"
    t.string "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "associated_data"
    t.jsonb "user_data"
    t.jsonb "result_data"
    t.jsonb "results"
    t.integer "total_progress_points", default: 0
    t.boolean "diagnostic_completed", default: false
    t.string "diagnostic_skill_level"
    t.float "diagnostic_score"
    t.index ["diagnostic_skill_level"], name: "index_users_on_diagnostic_skill_level"
    t.index ["total_progress_points"], name: "index_users_on_total_progress_points"
  end

  add_foreign_key "container_lab_sessions", "users"
  add_foreign_key "course_enrollments", "courses"
  add_foreign_key "course_enrollments", "users"
  add_foreign_key "course_modules", "courses"
  add_foreign_key "course_modules", "quizzes", column: "module_quiz_id"
  add_foreign_key "exam_simulations", "users"
  add_foreign_key "exercises", "micro_lessons"
  add_foreign_key "interests", "users"
  add_foreign_key "lab_attempts", "hands_on_labs"
  add_foreign_key "lab_attempts", "users"
  add_foreign_key "lab_sessions", "hands_on_labs"
  add_foreign_key "lab_sessions", "users"
  add_foreign_key "learning_events", "users"
  add_foreign_key "learning_paths", "problems", column: "current_problem_id"
  add_foreign_key "learning_paths", "users"
  add_foreign_key "learning_sessions", "users"
  add_foreign_key "learning_unit_progresses", "interactive_learning_units"
  add_foreign_key "learning_unit_progresses", "users"
  add_foreign_key "lesson_completions", "course_lessons"
  add_foreign_key "lesson_completions", "users"
  add_foreign_key "micro_lesson_progresses", "micro_lessons"
  add_foreign_key "micro_lesson_progresses", "users"
  add_foreign_key "micro_lessons", "course_modules"
  add_foreign_key "micro_lessons", "topic_groups"
  add_foreign_key "milestone_exams", "courses"
  add_foreign_key "milestone_exams", "quizzes"
  add_foreign_key "module_interactive_units", "course_modules"
  add_foreign_key "module_interactive_units", "interactive_learning_units"
  add_foreign_key "module_items", "course_modules"
  add_foreign_key "module_progresses", "course_enrollments"
  add_foreign_key "module_progresses", "course_modules"
  add_foreign_key "module_progresses", "users"
  add_foreign_key "problem_attempts", "problems"
  add_foreign_key "problem_attempts", "users"
  add_foreign_key "questions", "lessons"
  add_foreign_key "quiz_attempts", "course_enrollments"
  add_foreign_key "quiz_attempts", "quizzes"
  add_foreign_key "quiz_attempts", "users"
  add_foreign_key "quiz_question_lesson_mappings", "course_lessons"
  add_foreign_key "quiz_question_lesson_mappings", "quiz_questions"
  add_foreign_key "quiz_question_pools", "exercises"
  add_foreign_key "quiz_question_pools", "quizzes"
  add_foreign_key "quiz_questions", "quizzes"
  add_foreign_key "remediation_activities", "course_lessons"
  add_foreign_key "remediation_activities", "quiz_attempts"
  add_foreign_key "remediation_activities", "quiz_questions"
  add_foreign_key "remediation_activities", "users"
  add_foreign_key "remediation_sessions", "course_enrollments", column: "enrollment_id"
  add_foreign_key "remediation_sessions", "users"
  add_foreign_key "reminders", "questions"
  add_foreign_key "reminders", "users"
  add_foreign_key "review_sessions", "course_enrollments"
  add_foreign_key "review_sessions", "courses"
  add_foreign_key "review_sessions", "users"
  add_foreign_key "stealth_reviews", "users"
  add_foreign_key "study_plans", "courses"
  add_foreign_key "study_plans", "users"
  add_foreign_key "topic_groups", "course_modules"
  add_foreign_key "upsc_daily_tasks", "upsc_study_plans"
  add_foreign_key "upsc_daily_tasks", "upsc_topics"
  add_foreign_key "upsc_daily_tasks", "users"
  add_foreign_key "upsc_news_articles", "users", column: "created_by_id"
  add_foreign_key "upsc_questions", "upsc_subjects"
  add_foreign_key "upsc_questions", "upsc_topics"
  add_foreign_key "upsc_questions", "users", column: "created_by_id"
  add_foreign_key "upsc_revisions", "upsc_topics"
  add_foreign_key "upsc_revisions", "users"
  add_foreign_key "upsc_student_profiles", "upsc_subjects", column: "optional_subject_id"
  add_foreign_key "upsc_student_profiles", "users"
  add_foreign_key "upsc_study_plans", "users"
  add_foreign_key "upsc_test_questions", "upsc_questions"
  add_foreign_key "upsc_test_questions", "upsc_tests"
  add_foreign_key "upsc_tests", "upsc_subjects"
  add_foreign_key "upsc_tests", "users", column: "created_by_id"
  add_foreign_key "upsc_topics", "course_lessons"
  add_foreign_key "upsc_topics", "course_modules"
  add_foreign_key "upsc_topics", "upsc_subjects"
  add_foreign_key "upsc_topics", "upsc_topics", column: "parent_topic_id"
  add_foreign_key "upsc_user_answers", "upsc_user_answers", column: "original_answer_id"
  add_foreign_key "upsc_user_answers", "upsc_writing_questions"
  add_foreign_key "upsc_user_answers", "users"
  add_foreign_key "upsc_user_answers", "users", column: "evaluator_id"
  add_foreign_key "upsc_user_progress", "upsc_topics"
  add_foreign_key "upsc_user_progress", "users"
  add_foreign_key "upsc_user_test_attempts", "upsc_tests"
  add_foreign_key "upsc_user_test_attempts", "users"
  add_foreign_key "upsc_writing_questions", "upsc_subjects"
  add_foreign_key "upsc_writing_questions", "upsc_topics"
  add_foreign_key "upsc_writing_questions", "users", column: "created_by_id"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "user_command_masteries", "users"
  add_foreign_key "user_course_achievements", "course_achievements"
  add_foreign_key "user_course_achievements", "users"
  add_foreign_key "user_course_enrollments", "users"
  add_foreign_key "user_course_progresses", "users"
  add_foreign_key "user_lessons", "lessons"
  add_foreign_key "user_lessons", "users"
  add_foreign_key "user_skill_dimensions", "users"
  add_foreign_key "user_stats", "users"
end

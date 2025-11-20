class CreateInteractiveLearningUnits < ActiveRecord::Migration[6.0]
  def change
    # Interactive Learning Units table
    create_table :interactive_learning_units do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :concept_explanation # Markdown, brief explanation (max 200 words)
      t.string :command_to_learn # Main command being taught
      t.json :command_variations, default: [] # Array of valid alternative commands
      t.json :practice_hints, default: [] # Progressive hints for practice
      t.text :scenario_description # Description of the hands-on scenario
      t.json :scenario_steps, default: [] # Steps for the mini-scenario
      t.string :difficulty_level # easy, medium, hard
      t.integer :estimated_minutes, default: 5 # 3-5 minutes per unit
      t.integer :sequence_order, default: 0
      t.string :category # e.g., 'containers', 'images', 'networking', 'volumes'
      t.boolean :published, default: false
      
      # Quiz question integrated into the unit
      t.string :quiz_question_text
      t.string :quiz_question_type # mcq, true_false, fill_in_blank
      t.json :quiz_options, default: [] # For MCQ questions
      t.string :quiz_correct_answer
      t.text :quiz_explanation
      
      # Visual aids and examples
      t.string :visual_aid_url # URL to diagram/image
      t.json :code_examples, default: [] # Array of code examples with syntax highlighting
      
      # Learning objectives
      t.json :learning_objectives, default: []
      t.json :prerequisites, default: [] # What should be completed first
      
      t.timestamps
    end
    
    add_index :interactive_learning_units, :slug, unique: true
    add_index :interactive_learning_units, :published
    add_index :interactive_learning_units, :difficulty_level
    add_index :interactive_learning_units, :category
    add_index :interactive_learning_units, :sequence_order
    
    # Learning Unit Progress tracking
    create_table :learning_unit_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :interactive_learning_unit, null: false, foreign_key: true
      
      # Progress flags for each component
      t.boolean :explanation_read, default: false
      t.boolean :practice_completed, default: false
      t.boolean :quiz_answered, default: false
      t.boolean :scenario_completed, default: false
      
      # Detailed tracking
      t.integer :practice_attempts, default: 0
      t.integer :quiz_attempts, default: 0
      t.integer :scenario_attempts, default: 0
      t.integer :time_spent_seconds, default: 0
      
      # Results
      t.string :practice_user_answer
      t.boolean :practice_correct, default: false
      t.string :quiz_user_answer
      t.boolean :quiz_correct, default: false
      t.float :mastery_score, default: 0.0 # 0.0 to 1.0
      
      # Timestamps for spaced repetition
      t.datetime :last_practiced_at
      t.datetime :next_review_at
      t.integer :review_count, default: 0
      
      # Completion
      t.boolean :completed, default: false
      t.datetime :completed_at
      
      t.timestamps
    end
    
    add_index :learning_unit_progresses, [:user_id, :interactive_learning_unit_id], 
              unique: true, name: 'index_learning_progress_on_user_and_unit'
    add_index :learning_unit_progresses, :completed
    add_index :learning_unit_progresses, :next_review_at
    add_index :learning_unit_progresses, :mastery_score
    
    # Junction table to connect interactive units to course modules
    create_table :module_interactive_units do |t|
      t.references :course_module, null: false, foreign_key: true
      t.references :interactive_learning_unit, null: false, foreign_key: true
      t.integer :sequence_order, null: false
      t.boolean :required, default: true
      
      t.timestamps
    end
    
    add_index :module_interactive_units, [:course_module_id, :sequence_order], 
              name: 'index_module_units_on_module_and_order'
    add_index :module_interactive_units, [:course_module_id, :interactive_learning_unit_id],
              unique: true, name: 'index_module_units_unique'
  end
end


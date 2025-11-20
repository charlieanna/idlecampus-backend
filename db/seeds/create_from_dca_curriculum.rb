# Generate DCA Curriculum from YAML
# Run with: rails runner db/seeds/create_from_dca_curriculum.rb

require 'yaml'

puts "=" * 100
puts "DOCKER CERTIFIED ASSOCIATE (DCA) CURRICULUM GENERATOR"
puts "Creating 55 Chapters + 11 Labs from YAML"
puts "=" * 100

# Load the curriculum YAML
yaml_path = Rails.root.join('dca_complete_curriculum.yml')
unless File.exist?(yaml_path)
  puts "\n❌ ERROR: #{yaml_path} not found!"
  puts "Please ensure the YAML file exists."
  exit 1
end

curriculum = YAML.load_file(yaml_path)
chapters = curriculum['chapters']
labs = curriculum['labs']

puts "\n📋 Loaded curriculum data:"
puts "   Chapters: #{chapters.count}"
puts "   Labs: #{labs.count}"
puts ""

# Track statistics
created_count = 0
updated_count = 0
skipped_count = 0
errors = []

# ==============================================================================
# HELPER: Generate concept explanation from template
# ==============================================================================

def generate_concept_explanation(chapter)
  # If chapter has minimal data, generate a basic explanation
  # Otherwise, create a comprehensive one

  command = chapter['command']
  title = chapter['title']
  key_concepts = chapter['key_concepts'] || []

  <<~MD
    **#{title}** 📚

    Learn the `#{command}` command - a critical skill for Docker #{chapter['domain']}.

    ### What You'll Learn

    #{key_concepts.map { |concept| "- **#{concept}**" }.join("\n    ")}

    ### Why This Matters for DCA

    This command is part of the **#{chapter['domain']}** domain, which makes up a significant
    portion of the Docker Certified Associate exam. Mastering this concept will help you:

    - Understand Docker's core functionality
    - Pass the DCA certification exam
    - Apply Docker skills in real-world scenarios

    ### Command Syntax

    ```bash
    #{command}
    ```

    ### Key Points

    #{key_concepts.take(3).map.with_index { |concept, i| "#{i + 1}. **#{concept}**: Essential for understanding how Docker manages #{chapter['category']}" }.join("\n    ")}

    ### Practice Task

    In this lesson, you'll practice using `#{command}` in a realistic scenario.
    Focus on understanding **when** and **why** to use this command, not just **how**.
  MD
end

# ==============================================================================
# HELPER: Generate scenario narrative from template
# ==============================================================================

def generate_scenario_narrative(chapter)
  <<~MD
    **Real-World Scenario: #{chapter['title']}**

    "You're working on a Docker project and need to #{chapter['title'].downcase}.
    This is a common task in the #{chapter['domain']} domain. Let's practice the
    `#{chapter['command']}` command to accomplish this goal."
  MD
end

# ==============================================================================
# HELPER: Generate practice hints
# ==============================================================================

def generate_practice_hints(chapter)
  command = chapter['command']
  variations = chapter['command_variations'] || []

  hints = [
    "The command you need is: #{command}",
    "This command is part of the #{chapter['domain']} domain"
  ]

  if variations.any?
    hints << "Alternative syntax: #{variations.first}"
  end

  hints << "Take your time and read the concept explanation carefully"

  hints
end

# ==============================================================================
# CREATE CHAPTERS (InteractiveLearningUnits)
# ==============================================================================

puts "\n" + "=" * 100
puts "CREATING CHAPTERS (InteractiveLearningUnits)"
puts "=" * 100

chapters.each_with_index do |chapter_data, index|
  chapter_num = chapter_data['number']
  slug = "codesprout-#{chapter_data['slug']}"

  # Skip chapters 1-9 (already exist as codesprout-hello-world, etc.)
  if chapter_num < 10
    puts "\n⏭️  Skipping Chapter #{chapter_num} (#{slug}) - already exists"
    skipped_count += 1
    next
  end

  puts "\n📝 Processing Chapter #{chapter_num}: #{chapter_data['title']}"
  puts "   Slug: #{slug}"
  puts "   Command: #{chapter_data['command']}"

  begin
    # Find or initialize the unit
    unit = InteractiveLearningUnit.find_or_initialize_by(slug: slug)

    # Set basic attributes
    unit.title = chapter_data['title']
    unit.sequence_order = chapter_num - 1  # 0-indexed
    unit.category = chapter_data['category'] || 'docker'
    unit.difficulty_level = chapter_data['difficulty'] || 'medium'
    unit.estimated_minutes = chapter_data['estimated_minutes'] || 5
    unit.published = true

    # Set command info
    unit.command_to_learn = chapter_data['command']
    unit.command_variations = chapter_data['command_variations'] || []

    # Generate or use provided content
    unit.concept_explanation = generate_concept_explanation(chapter_data)
    unit.scenario_narrative = generate_scenario_narrative(chapter_data)
    unit.practice_hints = generate_practice_hints(chapter_data)
    unit.problem_statement = "Practice using #{chapter_data['command']} for #{chapter_data['title'].downcase}"

    # Quiz data
    quiz = chapter_data['quiz']
    if quiz
      unit.quiz_question_text = quiz['question']
      unit.quiz_question_type = 'mcq'
      unit.quiz_options = quiz['options'] if quiz['options']

      # Find correct answer
      correct_option = quiz['options']&.find { |opt| opt['correct'] }
      unit.quiz_correct_answer = correct_option['text'] if correct_option
      unit.quiz_explanation = quiz['explanation']
    end

    # Concept tags
    unit.concept_tags = chapter_data['key_concepts'] || [chapter_data['category'], 'docker', 'dca']

    # Save
    if unit.new_record?
      unit.save!
      puts "   ✅ Created: #{unit.title}"
      created_count += 1
    else
      unit.save!
      puts "   ♻️  Updated: #{unit.title}"
      updated_count += 1
    end

  rescue => e
    error_msg = "Chapter #{chapter_num} (#{slug}): #{e.message}"
    errors << error_msg
    puts "   ❌ ERROR: #{e.message}"
    puts "   #{e.backtrace.first}"
  end
end

# ==============================================================================
# CREATE LABS (HandsOnLabs)
# ==============================================================================

puts "\n\n" + "=" * 100
puts "CREATING LABS (HandsOnLabs)"
puts "=" * 100

labs.each do |lab_data|
  lab_num = lab_data['number']
  slug = lab_data['slug']

  puts "\n🔬 Processing Lab #{lab_num}: #{lab_data['title']}"
  puts "   Slug: #{slug}"
  puts "   After Chapter: #{lab_data['after_chapter']}"

  begin
    # Find or initialize the lab
    lab = HandsOnLab.find_or_initialize_by(slug: slug)

    # Set basic attributes
    lab.title = lab_data['title']
    lab.lab_type = 'docker'
    lab.difficulty = lab_data['difficulty'] || 'medium'
    lab.estimated_minutes = lab_data['duration_minutes'] || 20
    lab.is_active = true

    # Description and scenario
    lab.description = lab_data['scenario']
    lab.scenario_narrative = <<~MD
      **Comprehensive Lab #{lab_num}: #{lab_data['title']}**

      #{lab_data['scenario']}

      This lab tests your mastery of:
      #{lab_data['commands_tested'].map { |cmd| "- `#{cmd}`" }.join("\n")}

      **Pass Threshold**: #{lab_data['pass_threshold']}%
      **Duration**: ~#{lab_data['duration_minutes']} minutes

      Complete all tasks to demonstrate your understanding of the concepts covered so far.
    MD

    # Store commands tested (for validation)
    lab.commands_tested = lab_data['commands_tested']
    lab.pass_threshold = lab_data['pass_threshold'] || 70
    lab.stability_multiplier = lab_data['stability_multiplier'] || 1.5

    # Success criteria (text field)
    success_data = {
      pass_threshold: lab_data['pass_threshold'],
      stability_multiplier: lab_data['stability_multiplier'] || 1.5,
      is_final_exam: lab_data['is_final_exam'] || false
    }
    lab.success_criteria = success_data.to_yaml

    # Steps (not tasks - HandsOnLab uses 'steps')
    if lab_data['tasks']
      lab.steps = lab_data['tasks'].map.with_index do |task_desc, idx|
        {
          order: idx + 1,
          description: task_desc,
          validation_type: 'command_execution',
          points: 10
        }
      end
    else
      # Generate default steps from commands
      lab.steps = lab_data['commands_tested'].map.with_index do |cmd, idx|
        {
          order: idx + 1,
          description: "Demonstrate proficiency with #{cmd}",
          validation_type: 'command_execution',
          points: 10
        }
      end
    end

    # Prerequisites: All chapters up to after_chapter must be completed
    after_chapter = lab_data['after_chapter']
    lab.prerequisites = (1..after_chapter).map { |ch| "codesprout-chapter-#{ch}" }

    # Save
    if lab.new_record?
      lab.save!
      puts "   ✅ Created: #{lab.title}"
      created_count += 1
    else
      lab.save!
      puts "   ♻️  Updated: #{lab.title}"
      updated_count += 1
    end

  rescue => e
    error_msg = "Lab #{lab_num} (#{slug}): #{e.message}"
    errors << error_msg
    puts "   ❌ ERROR: #{e.message}"
    puts "   #{e.backtrace.first}"
  end
end

# ==============================================================================
# SUMMARY
# ==============================================================================

puts "\n\n" + "=" * 100
puts "GENERATION COMPLETE!"
puts "=" * 100

puts "\n📊 Statistics:"
puts "   ✅ Created: #{created_count}"
puts "   ♻️  Updated: #{updated_count}"
puts "   ⏭️  Skipped: #{skipped_count}"
puts "   ❌ Errors: #{errors.count}"

if errors.any?
  puts "\n⚠️  Errors encountered:"
  errors.each do |error|
    puts "   - #{error}"
  end
end

puts "\n✨ Next Steps:"
puts "   1. Review created chapters: rails runner 'puts InteractiveLearningUnit.where(\"sequence_order >= ?\", 9).count'"
puts "   2. Review created labs: rails runner 'puts HandsOnLab.where(lab_type: \"docker\").count'"
puts "   3. Test the learning path: Visit http://localhost:3000/continuous_learning"
puts "   4. Verify hybrid decay is tracking all 55 chapters"

puts "\n" + "=" * 100

# Create Rich Progressive Learning Units from DockerCommand records

# Load the converter class
require_relative 'rich_docker_command_converter'

# Helper method
def difficulty_to_minutes(difficulty)
  case difficulty
  when 'easy' then 5
  when 'intermediate' then 8
  when 'advanced' then 12
  else 5
  end
end

puts "🚀 Creating rich progressive learning units from 106 Docker commands..."

course = Course.find_by(slug: 'docker-fundamentals')
unless course
  puts "❌ Docker course not found!"
  exit
end

# Category to module mapping
CATEGORY_MODULE_MAPPING = {
  'basics' => 'container-basics',
  'containers' => 'container-basics',
  'images' => 'images-dockerfiles',
  'networks' => 'networking-and-ports',
  'volumes' => 'volumes-and-storage',
  'compose' => 'docker-compose',
  'security' => 'security-best-practices',
  'registry' => 'registries-ci-cd',
  'swarm' => 'exam-readiness-dca-mock-1'
}

# Get all Docker commands
all_commands = DockerCommand.all

# Sort commands by category, then difficulty, then exam_frequency
sorted_commands = all_commands.group_by(&:category).transform_values do |commands|
  commands.sort_by do |cmd|
    difficulty_order = { 'easy' => 0, 'intermediate' => 1, 'advanced' => 2 }
    [difficulty_order[cmd.difficulty] || 1, -cmd.exam_frequency, cmd.command]
  end
end

total_created = 0
total_with_quizzes = 0

sorted_commands.each do |category, commands|
  module_slug = CATEGORY_MODULE_MAPPING[category]

  unless module_slug
    puts "⚠️  No module mapping for category: #{category}"
    next
  end

  mod = course.course_modules.find_by(slug: module_slug)
  unless mod
    puts "⚠️  Module not found: #{module_slug}"
    next
  end

  puts "\n📦 #{mod.title} (#{category} category):"
  puts "   Creating #{commands.count} rich progressive units..."

  # Get current max sequence order
  current_max_seq = mod.module_items.maximum(:sequence_order) || 0

  commands.each_with_index do |docker_cmd, index|
    # Initialize converter
    converter = RichDockerCommandConverter.new(docker_cmd)

    # Generate rich content
    concept_explanation = converter.generate_concept_explanation
    scenario_description = converter.generate_scenario_description
    practice_hints = converter.generate_practice_hints
    scenario_steps = converter.generate_scenario_steps
    learning_objectives = converter.generate_learning_objectives
    quiz_data = converter.generate_quiz_questions

    # Generate slug and title
    slug = docker_cmd.command.gsub(/[^a-z0-9\-]+/i, '-').gsub(/\-+/, '-').downcase.truncate(90, omission: '')
    slug = "#{category}-#{slug}"

    title_parts = docker_cmd.command.split
    title = docker_cmd.command.length > 50 ?
      "#{title_parts[0..2].join(' ')}..." :
      docker_cmd.command

    # Check if unit already exists
    unit = InteractiveLearningUnit.find_or_initialize_by(slug: slug)

    if unit.new_record?
      unit.assign_attributes(
        title: title,
        command_to_learn: docker_cmd.command,
        command_variations: docker_cmd.variations&.join("\n"),
        concept_explanation: concept_explanation,
        scenario_description: scenario_description,
        practice_hints: practice_hints,
        scenario_steps: scenario_steps,
        learning_objectives: learning_objectives,
        difficulty_level: docker_cmd.difficulty,
        estimated_minutes: difficulty_to_minutes(docker_cmd.difficulty),
        category: category,
        sequence_order: 0,
        quiz_question_text: quiz_data&.dig(:question_text),
        quiz_options: quiz_data&.dig(:quiz_options) || [],
        quiz_explanation: quiz_data&.dig(:quiz_explanation)
      )

      unit.save!
      total_created += 1
      total_with_quizzes += 1 if quiz_data.present?

      status = concept_explanation.length >= 200 ? "✅" : "⚠️ "
      puts "  #{status} Created: #{docker_cmd.command.truncate(60)} (#{concept_explanation.length} chars)"
    else
      puts "  ⏭️  Exists: #{docker_cmd.command.truncate(60)}"
    end

    # Link to module
    unless mod.module_items.exists?(item_type: 'InteractiveLearningUnit', item_id: unit.id)
      mod.module_items.create!(
        item: unit,
        sequence_order: current_max_seq + index + 1,
        required: true
      )
    end
  end
end

puts "\n" + "=" * 70
puts "✅ Created #{total_created} rich progressive learning units"
puts "✅ #{total_with_quizzes} units have quiz questions"

puts "\n📊 Content Quality Check:"
units = InteractiveLearningUnit.all
puts "  Total units: #{units.count}"
puts "  With long explanations (400+ chars): #{units.where('LENGTH(concept_explanation) >= 400').count}"
puts "  With medium explanations (200-399 chars): #{units.where('LENGTH(concept_explanation) BETWEEN 200 AND 399').count}"
puts "  With short explanations (<200 chars): #{units.where('LENGTH(concept_explanation) < 200').count}"
puts "  With quizzes: #{units.where.not(quiz_question_text: nil).count}"
puts "  With scenario steps: #{units.where("scenario_steps != '[]'").count}"

puts "\n📚 Final module structure:"
course.course_modules.order(:sequence_order).each do |mod|
  interactive_count = mod.module_items.where(item_type: 'InteractiveLearningUnit').count
  lab_count = mod.module_items.where(item_type: 'HandsOnLab').count

  if interactive_count > 0 || lab_count > 0
    parts = []
    parts << "#{interactive_count} commands" if interactive_count > 0
    parts << "#{lab_count} labs" if lab_count > 0
    puts "  #{mod.title}: #{parts.join(', ')}"
  end
end

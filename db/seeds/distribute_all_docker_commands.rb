# Distribute all 106 Docker commands across course modules as InteractiveLearningUnit records

# Helper method to generate hints from flags and gotchas
def generate_hints(docker_cmd)
  hints = []

  if docker_cmd.flags.present?
    hints << "Common flags:"
    docker_cmd.flags.each do |flag, description|
      hints << "  #{flag}: #{description}"
    end
  end

  if docker_cmd.gotchas.present?
    hints << "\n⚠️ Important notes:"
    hints << docker_cmd.gotchas
  end

  hints.join("\n")
end

puts "🚀 Distributing all 106 Docker commands across course modules..."

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
  'swarm' => 'exam-readiness-dca-mock-1'  # Put swarm commands in bridge module
}

# Get all Docker commands grouped by category
commands_by_category = DockerCommand.all.group_by(&:category)

puts "\n📊 Found #{DockerCommand.count} total commands across #{commands_by_category.keys.count} categories"

total_created = 0
total_linked = 0

commands_by_category.each do |category, commands|
  module_slug = CATEGORY_MODULE_MAPPING[category]

  unless module_slug
    puts "⚠️  No module mapping for category: #{category} (#{commands.count} commands)"
    next
  end

  mod = course.course_modules.find_by(slug: module_slug)
  unless mod
    puts "⚠️  Module not found: #{module_slug}"
    next
  end

  puts "\n📦 #{mod.title} (#{category} category):"
  puts "   Processing #{commands.count} commands..."

  # Sort commands: easy first, then medium, then hard
  sorted_commands = commands.sort_by do |cmd|
    difficulty_order = { 'easy' => 0, 'intermediate' => 1, 'advanced' => 2 }
    [difficulty_order[cmd.difficulty] || 1, -cmd.exam_frequency, cmd.command]
  end

  # Get current max sequence order in module
  current_max_seq = mod.module_items.maximum(:sequence_order) || 0

  sorted_commands.each_with_index do |docker_cmd, index|
    # Create or find InteractiveLearningUnit for this command
    unit = InteractiveLearningUnit.find_or_initialize_by(
      command_to_learn: docker_cmd.command
    )

    if unit.new_record?
      # Generate title from command
      title_parts = docker_cmd.command.split
      main_command = title_parts[0..1].join(' ')
      title = docker_cmd.command.length > 40 ?
        "#{main_command.capitalize}..." :
        docker_cmd.command.capitalize

      # Generate slug from command
      slug = docker_cmd.command.gsub(/[^a-z0-9\-]+/i, '-').gsub(/\-+/, '-').downcase
      slug = "#{category}-#{slug}".truncate(100, omission: '')

      unit.assign_attributes(
        title: title,
        slug: slug,
        command_to_learn: docker_cmd.command,
        command_variations: docker_cmd.variations&.join("\n"),
        concept_explanation: "#{docker_cmd.explanation}\n\n#{docker_cmd.use_cases}".strip,
        practice_hints: generate_hints(docker_cmd),
        scenario_description: docker_cmd.use_cases,
        difficulty_level: docker_cmd.difficulty,
        estimated_minutes: 5,
        category: category
      )

      unit.save!
      total_created += 1
      puts "  ✅ Created unit: #{docker_cmd.command}"
    else
      puts "  ⏭️  Unit exists: #{docker_cmd.command}"
    end

    # Link to module if not already linked
    unless mod.module_items.exists?(item_type: 'InteractiveLearningUnit', item_id: unit.id)
      mod.module_items.create!(
        item: unit,
        sequence_order: current_max_seq + index + 1,
        required: true
      )
      total_linked += 1
    end
  end
end

puts "\n" + "=" * 70
puts "✅ Created #{total_created} new InteractiveLearningUnit records"
puts "✅ Linked #{total_linked} units to modules"

puts "\n📊 Final module structure:"
course.course_modules.order(:sequence_order).each do |mod|
  interactive_count = mod.module_items.where(item_type: 'InteractiveLearningUnit').count
  lab_count = mod.module_items.where(item_type: 'HandsOnLab').count
  total = interactive_count + lab_count

  if total > 0
    parts = []
    parts << "#{interactive_count} commands" if interactive_count > 0
    parts << "#{lab_count} labs" if lab_count > 0
    puts "  #{mod.title}: #{parts.join(', ')}"
  end
end

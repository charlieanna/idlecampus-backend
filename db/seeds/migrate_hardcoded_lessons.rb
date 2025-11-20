# Migrate hardcoded DOCKER_LESSONS to InteractiveLearningUnit records
# This script converts all 22 microlessons from DockerContentLibrary::DOCKER_LESSONS
# into database records, enabling single-source-of-truth content management

puts "🚀 Starting migration of hardcoded Docker lessons to database..."
puts "=" * 80

# Starting sequence order after existing 20 units
starting_sequence = InteractiveLearningUnit.maximum(:sequence_order)&.+(1) || 21

# Track statistics
stats = {
  chapters_processed: 0,
  micros_created: 0,
  micros_skipped: 0,
  errors: []
}

# Helper to extract difficulty from content
def determine_difficulty(chapter_name, micro_id)
  # Base micros are easier, advanced features are harder
  return 'easy' if micro_id.end_with?('_base')
  return 'medium' if micro_id.include?('detached') || micro_id.include?('flag')
  return 'hard' if micro_id.include?('no_cache') || micro_id.include?('timeout')
  
  # Chapter-based difficulty
  case chapter_name
  when 'docker run', 'docker ps', 'docker images'
    'easy'
  when 'docker pull', 'docker stop', 'docker logs'
    'easy'
  when 'docker exec', 'docker build'
    'medium'
  when 'docker network', 'docker volume', 'docker-compose'
    'hard'
  else
    'medium'
  end
end

# Helper to extract category from chapter
def determine_category(chapter_name)
  case chapter_name
  when 'docker run', 'docker ps', 'docker stop', 'docker exec'
    'containers'
  when 'docker images', 'docker pull', 'docker build'
    'images'
  when 'docker logs'
    'monitoring'
  when 'docker network'
    'networking'
  when 'docker volume'
    'storage'
  when 'docker-compose'
    'orchestration'
  else
    'general'
  end
end

# Helper to estimate reading time
def estimate_minutes(explanation_length)
  # Average reading speed: 200 words per minute
  # Add time for practical execution
  words = explanation_length.split.length
  reading_time = (words / 200.0).ceil
  [reading_time + 2, 10].min # Min 2 min (reading + practice), max 10
end

# Process each chapter in DOCKER_LESSONS
DockerContentLibrary::DOCKER_LESSONS.each_with_index do |(chapter_name, chapter_data), chapter_index|
  puts "\n📚 Processing chapter: #{chapter_name}"
  puts "   Title: #{chapter_data[:title]}"
  
  stats[:chapters_processed] += 1
  
  # Process each microlesson in this chapter
  chapter_data[:micro_lessons]&.each_with_index do |micro, micro_index|
    # Calculate sequence order
    sequence_order = starting_sequence + (chapter_index * 10) + micro_index
    
    # Generate slug from chapter and micro ID
    slug = "#{chapter_name.parameterize}-#{micro[:id].to_s.parameterize}"
    
    # Check if already exists
    if InteractiveLearningUnit.exists?(slug: slug)
      puts "   ⏭️  Skipping #{slug} (already exists)"
      stats[:micros_skipped] += 1
      next
    end
    
    begin
      # Extract content
      content = micro[:content] || {}
      validation = micro[:validation] || {}
      
      # Build command variations
      command_variations = (content[:examples] || []).reject { |ex| ex == content[:expected_command] }
      
      # Extract quiz if exists
      quiz_data = micro[:quiz] || {}
      
      # Create the InteractiveLearningUnit
      unit = InteractiveLearningUnit.create!(
        # Basic info
        title: content[:title] || chapter_data[:title],
        slug: slug,
        
        # Learning content
        concept_explanation: content[:explanation] || chapter_data[:explanation] || "Learn #{chapter_name}",
        scenario_description: content[:task] || chapter_data[:practice_prompt] || "Practice #{chapter_name}",
        
        # Command details
        command_to_learn: content[:expected_command] || chapter_name,
        command_variations: command_variations,
        practice_hints: micro[:hints] || [],
        
        # Metadata
        category: determine_category(chapter_name),
        difficulty_level: determine_difficulty(chapter_name, micro[:id]),
        estimated_minutes: estimate_minutes(content[:explanation].to_s),
        sequence_order: sequence_order,
        
        # Quiz (if present)
        quiz_question_text: quiz_data[:question],
        quiz_question_type: quiz_data[:type],
        quiz_options: quiz_data[:options],
        quiz_correct_answer: quiz_data[:correct_answer],
        quiz_explanation: quiz_data[:explanation],
        
        # Publication status
        published: true,
        
        # Additional metadata for tracking
        concept_tags: [chapter_name, micro[:type].to_s, determine_category(chapter_name)].compact
      )
      
      puts "   ✅ Created: #{unit.title} (#{unit.slug})"
      puts "      - Sequence: #{sequence_order}"
      puts "      - Category: #{unit.category}"
      puts "      - Difficulty: #{unit.difficulty_level}"
      puts "      - Command: #{unit.command_to_learn}"
      
      stats[:micros_created] += 1
      
    rescue => e
      error_msg = "Failed to create #{slug}: #{e.message}"
      puts "   ❌ #{error_msg}"
      stats[:errors] << error_msg
    end
  end
end

# Print summary
puts "\n" + ("=" * 80)
puts "📊 Migration Summary"
puts ("=" * 80)
puts "Chapters processed:     #{stats[:chapters_processed]}"
puts "Microlessons created:   #{stats[:micros_created]}"
puts "Microlessons skipped:   #{stats[:micros_skipped]}"
puts "Total units in DB:      #{InteractiveLearningUnit.count}"
puts "\nPublished units:        #{InteractiveLearningUnit.published.count}"
puts "Unpublished units:      #{InteractiveLearningUnit.where(published: false).count}"

if stats[:errors].any?
  puts "\n❌ Errors encountered:"
  stats[:errors].each_with_index do |error, i|
    puts "   #{i + 1}. #{error}"
  end
else
  puts "\n✅ Migration completed successfully!"
end

puts "\n🔍 Breakdown by category:"
InteractiveLearningUnit.group(:category).count.each do |category, count|
  puts "   #{category.ljust(15)}: #{count} units"
end

puts "\n🔍 Breakdown by difficulty:"
InteractiveLearningUnit.group(:difficulty_level).count.each do |difficulty, count|
  puts "   #{difficulty.ljust(15)}: #{count} units"
end

puts "\n" + ("=" * 80)
puts "🎯 Next steps:"
puts "1. Review the created units in Rails console or admin interface"
puts "2. Update DockerContentLibrary to use database as primary source"
puts "3. Test the learning flow at /docker/learn"
puts "=" * 80
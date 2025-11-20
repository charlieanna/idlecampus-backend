namespace :docker do
  desc "Migrate hardcoded DOCKER_LESSONS to database"
  task migrate_lessons_to_db: :environment do
    puts "🚀 Migrating Docker lessons to database..."
    
    lessons = DockerContentLibrary::DOCKER_LESSONS
    sequence = 1
    
    lessons.each do |chapter_key, lesson_data|
      puts "\n📦 Processing chapter: #{chapter_key}"
      
      lesson_data[:micro_lessons].each_with_index do |micro, index|
        # Generate slug
        slug = micro[:id] || "#{chapter_key.parameterize}-#{index}"
        
        # Skip if already exists
        existing = InteractiveLearningUnit.find_by(slug: slug)
        if existing
          puts "  ⏭️  Skipping #{slug} (already exists)"
          next
        end
        
        # Extract data
        content = micro[:content] || {}
        validation = micro[:validation] || {}
        
        # Build unit attributes
        unit_attrs = {
          title: content[:title] || lesson_data[:title] || chapter_key,
          slug: slug,
          concept_explanation: content[:explanation] || '',
          command_to_learn: content[:expected_command] || chapter_key,
          scenario_description: content[:task] || content[:description],
          problem_statement: content[:task],
          practice_hints: micro[:hints] || [],
          command_variations: content[:examples] || [],
          difficulty_level: 'easy',
          estimated_minutes: 5,
          sequence_order: sequence,
          published: true,
          category: 'basics'
        }
        
        # Handle validation rules
        if validation[:required_image]
          unit_attrs[:command_variations] ||= []
          unit_attrs[:command_variations] << validation[:required_image] unless unit_attrs[:command_variations].include?(validation[:required_image])
        end
        
        # Create unit
        unit = InteractiveLearningUnit.create!(unit_attrs)
        puts "  ✅ Created: #{unit.title} (#{slug})"
        
        sequence += 1
      end
    end
    
    puts "\n✨ Migration complete! Created #{sequence - 1} units."
    puts "\n📝 Next steps:"
    puts "  1. Update DockerContentLibrary to prioritize database over hardcoded"
    puts "  2. Remove or deprecate DOCKER_LESSONS hash"
    puts "  3. Test the learning flow"
  end
end


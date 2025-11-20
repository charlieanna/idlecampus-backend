# Export Docker DCA curriculum to Adaptive Learning Service format
#
# Run with: rails runner lib/export_dca_to_adaptive.rb

require 'yaml'

puts "=" * 80
puts "EXPORTING DOCKER DCA TO ADAPTIVE LEARNING FORMAT"
puts "=" * 80

# Get all Docker DCA chapters
chapters = InteractiveLearningUnit.where("slug LIKE ?", "codesprout-%")
  .where(published: true)
  .order(:sequence_order)

puts "\nFound #{chapters.count} published chapters"

# Build course definition
course_definition = {
  'course' => {
    'id' => 'docker-dca',
    'name' => 'Docker Certified Associate',
    'version' => '1.0',

    'adaptive_config' => {
      'interference_rate' => 0.020,    # 2% base interference per skill
      'default_stability' => 7.0,      # 7 days FSRS stability
      'muscle_memory_floor' => 40.0,   # 40% minimum retention
      'protected_recent_count' => 3    # Protect last 3 skills
    },

    'domains' => [
      {
        'id' => 'container_basics',
        'name' => 'Container Basics',
        'weight' => 0.20,
        'skills' => chapters.where("sequence_order < ?", 10).pluck(:slug)
      },
      {
        'id' => 'dockerfile_mastery',
        'name' => 'Dockerfile Mastery',
        'weight' => 0.20,
        'skills' => chapters.where(sequence_order: 14..20).pluck(:slug)
      },
      {
        'id' => 'networking',
        'name' => 'Docker Networking',
        'weight' => 0.15,
        'skills' => chapters.where(sequence_order: 21..27).pluck(:slug)
      },
      {
        'id' => 'volumes',
        'name' => 'Volumes & Storage',
        'weight' => 0.10,
        'skills' => chapters.where(sequence_order: 28..34).pluck(:slug)
      },
      {
        'id' => 'compose',
        'name' => 'Docker Compose',
        'weight' => 0.15,
        'skills' => chapters.where(sequence_order: 35..41).pluck(:slug)
      },
      {
        'id' => 'swarm',
        'name' => 'Docker Swarm',
        'weight' => 0.15,
        'skills' => chapters.where(sequence_order: 42..49).pluck(:slug)
      },
      {
        'id' => 'security',
        'name' => 'Security & Best Practices',
        'weight' => 0.05,
        'skills' => chapters.where(sequence_order: 50..54).pluck(:slug)
      }
    ],

    'skills' => chapters.map { |ch|
      {
        'id' => ch.slug,
        'title' => ch.title,
        'type' => 'technique',
        'category' => ch.category || 'docker',
        'difficulty' => ch.difficulty_level || 'medium',
        'estimated_minutes' => ch.estimated_minutes || 30,
        'prerequisites' => ch.prerequisite_skill_ids || [],
        'similar_to' => generate_similarities(ch, chapters)
      }
    },

    'learning_path' => chapters.pluck(:slug)
  }
}

# Save to YAML
output_file = Rails.root.join('docker-dca-course.yml')
File.write(output_file, course_definition.to_yaml)

puts "\n✅ Course exported to: #{output_file}"
puts "\nCourse Summary:"
puts "  Skills: #{chapters.count}"
puts "  Domains: #{course_definition['course']['domains'].count}"
puts "\nDomains:"
course_definition['course']['domains'].each do |domain|
  puts "  - #{domain['name']}: #{domain['skills'].count} skills (#{(domain['weight'] * 100).to_i}% weight)"
end

puts "\nNext Steps:"
puts "1. Upload to adaptive service:"
puts "   curl -X POST $ADAPTIVE_API_URL/api/v1/courses \\"
puts "     -H \"X-API-Key: $API_KEY\" \\"
puts "     -F \"file=@#{output_file}\""
puts "\n2. Configure Rails app with adaptive-learning-sdk gem"
puts "3. Test with beta users!"

def generate_similarities(chapter, all_chapters)
  # Generate similarity scores based on command type
  similarities = {}

  all_chapters.each do |other|
    next if other.id == chapter.id

    # Base similarity on shared concepts
    similarity = calculate_similarity(chapter, other)

    if similarity > 0.15
      similarities[other.slug] = similarity.round(2)
    end
  end

  similarities
end

def calculate_similarity(ch1, ch2)
  # Simple heuristic: commands in same domain are more similar

  # Same sequence range = high similarity
  diff = (ch1.sequence_order - ch2.sequence_order).abs

  if diff == 1
    0.75  # Adjacent skills
  elsif diff == 2
    0.60  # Close skills
  elsif diff <= 5
    0.40  # Same domain
  elsif diff <= 10
    0.25  # Related domain
  else
    0.15  # Different domains
  end
end

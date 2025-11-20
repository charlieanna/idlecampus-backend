require 'json'
require 'yaml'
require 'fileutils'

puts "Converting DSA Microlessons to YAML format..."

# Load the generated microlessons JSON
json_file = File.read('db/seeds/generated_dsa_microlessons.json')
microlessons_data = JSON.parse(json_file)

# Create output directory
output_dir = 'db/seeds/dsa_microlessons'
FileUtils.mkdir_p(output_dir)

puts "Creating #{microlessons_data.length} YAML files in #{output_dir}/"

# Difficulty mapping based on problem count and content
def determine_difficulty(lesson_data)
  problem_count = lesson_data['problem_count']
  has_custom_content = lesson_data['content'].include?('## Common Patterns')

  if has_custom_content
    'medium' # Custom detailed lessons are medium difficulty
  elsif problem_count > 50
    'hard'
  elsif problem_count > 20
    'medium'
  else
    'easy'
  end
end

# Convert family_id to slug format
def to_slug(family_id)
  # Remove numbers and convert to slug
  family_id.gsub(/-\d+$/, '').gsub('_', '-')
end

microlessons_data.each_with_index do |lesson_data, index|
  slug = to_slug(lesson_data['family_id'])

  yaml_data = {
    'slug' => slug,
    'title' => lesson_data['title'],
    'sequence_order' => index + 1,
    'estimated_minutes' => lesson_data['reading_time_minutes'],
    'difficulty' => determine_difficulty(lesson_data),
    'key_concepts' => lesson_data['key_concepts'] || [],
    'content_md' => lesson_data['content']
  }

  # Write YAML file
  filename = "#{output_dir}/#{slug}.yml"
  File.write(filename, yaml_data.to_yaml)

  print "." if (index + 1) % 10 == 0
end

puts "\n"
puts "✅ Successfully converted #{microlessons_data.length} microlessons to YAML"
puts "📁 Files located in: #{output_dir}/"
puts "\nSample files:"
puts "  - #{output_dir}/array-sliding-window.yml"
puts "  - #{output_dir}/graph-union-find.yml"
puts "  - #{output_dir}/sort-search-binary-search.yml"

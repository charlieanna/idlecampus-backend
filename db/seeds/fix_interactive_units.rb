#!/usr/bin/env ruby
# Fix validation issues in Docker Interactive Learning Unit seed files

puts "🔧 Fixing Docker Interactive Learning Unit validation issues..."

seed_files = Dir.glob(Rails.root.join('db', 'seeds', 'docker_*_units.rb'))

seed_files.each do |file_path|
  content = File.read(file_path)
  original_content = content.dup
  changes = []
  
  # Fix difficulty_level: beginner -> easy, intermediate -> medium
  if content.gsub!(/u\.difficulty_level = ['"]beginner['"]/, "u.difficulty_level = 'easy'")
    changes << "beginner → easy"
  end
  
  if content.gsub!(/u\.difficulty_level = ['"]intermediate['"]/, "u.difficulty_level = 'medium'")
    changes << "intermediate → medium"
  end
  
  # Fix estimated_minutes: cap at 10 minutes
  content.gsub!(/u\.estimated_minutes = (\d+)/) do |match|
    minutes = $1.to_i
    if minutes > 10
      changes << "estimated_minutes: #{minutes} → 10"
      "u.estimated_minutes = 10"
    else
      match
    end
  end
  
  if content != original_content
    File.write(file_path, content)
    filename = File.basename(file_path)
    puts "  ✓ Fixed #{filename}"
    changes.each { |change| puts "    - #{change}" }
  end
end

puts "\n✅ All Docker Interactive Learning Unit files fixed!"
puts "Ready to run: rails db:seed"
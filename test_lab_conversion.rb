#!/usr/bin/env ruby
# Test lab-to-microlesson conversion

require_relative 'config/environment'

puts "🧪 Testing Lab-to-Microlesson Conversion"
puts "=" * 60

# Test: Load all labs
labs = HandsOnLab.where(lab_type: 'docker', is_active: true).order(:difficulty, :estimated_minutes)
puts "\n📊 Found #{labs.count} Docker labs in database"

# Test: Convert first lab
if labs.any?
  first_lab = labs.first
  puts "\n🔬 Testing conversion of: #{first_lab.title}"
  puts "   Difficulty: #{first_lab.difficulty}"
  puts "   Steps: #{first_lab.steps.length}"
  
  chapter_name = DockerContentLibrary.get_lab_chapter_name(first_lab)
  puts "   Chapter name: #{chapter_name}"
  
  # Get lab as chapter
  lab_chapter = DockerContentLibrary.get_lab_as_chapter(first_lab.id)
  
  if lab_chapter
    puts "\n✅ Chapter conversion successful!"
    puts "   Title: #{lab_chapter[:title]}"
    puts "   Microlessons: #{lab_chapter[:micro_lessons].length}"
    
    # Show first microlesson
    first_micro = lab_chapter[:micro_lessons].first
    if first_micro
      puts "\n📝 First Microlesson:"
      puts "   ID: #{first_micro[:id]}"
      puts "   Type: #{first_micro[:type]}"
      puts "   Title: #{first_micro[:content][:title]}"
      puts "   Command: #{first_micro[:content][:expected_command]}"
    end
  else
    puts "\n❌ Chapter conversion failed!"
  end
end

# Test: Get complete learning path
puts "\n\n📚 Complete Learning Path:"
complete_path = DockerContentLibrary.get_complete_learning_path
puts "   Total chapters: #{complete_path.length}"
puts "   Lab chapters: #{complete_path.select { |c| c.start_with?('lab_') }.length}"

# Show all lab chapters
lab_chapters = complete_path.select { |c| c.start_with?('lab_') }
if lab_chapters.any?
  puts "\n🔬 Lab Chapters:"
  lab_chapters.each do |chapter|
    lab_id = DockerContentLibrary.lab_id_from_chapter(chapter)
    lab = HandsOnLab.find_by(id: lab_id)
    if lab
      puts "   - #{chapter}: #{lab.title} (#{lab.difficulty}, #{lab.steps.length} steps)"
    end
  end
end

# Test: Get labs by difficulty
puts "\n\n📊 Labs by Difficulty:"
by_difficulty = DockerContentLibrary.get_labs_by_difficulty
puts "   Beginner: #{by_difficulty[:beginner].length}"
puts "   Intermediate: #{by_difficulty[:intermediate].length}"
puts "   Advanced: #{by_difficulty[:advanced].length}"

puts "\n\n✅ Test Complete!"
puts "=" * 60


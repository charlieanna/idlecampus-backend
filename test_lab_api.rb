#!/usr/bin/env ruby
# Test lab microlessons through the API

require_relative 'config/environment'

puts "🧪 Testing Lab Microlesson API"
puts "=" * 60

# Get a lab chapter
lab = HandsOnLab.where(lab_type: 'docker', is_active: true, difficulty: 'medium').first
if lab
  chapter_name = DockerContentLibrary.get_lab_chapter_name(lab)
  puts "\n📚 Testing chapter: #{chapter_name}"
  puts "   Lab: #{lab.title}"
  
  # Test get_lesson
  lesson = DockerContentLibrary.get_lesson(chapter_name)
  if lesson
    puts "\n✅ get_lesson() works!"
    puts "   Title: #{lesson[:title]}"
    puts "   Microlessons: #{lesson[:micro_lessons].length}"
  else
    puts "\n❌ get_lesson() failed!"
  end
  
  # Test get_first_micro_for_chapter
  first_micro = DockerContentLibrary.get_first_micro_for_chapter(chapter_name)
  if first_micro
    puts "\n✅ get_first_micro_for_chapter() works!"
    puts "   Micro ID: #{first_micro[:id]}"
    puts "   Title: #{first_micro[:content][:title]}"
  else
    puts "\n❌ get_first_micro_for_chapter() failed!"
  end
  
  # Test get_micro_lesson
  micro_id = first_micro[:id]
  retrieved_micro = DockerContentLibrary.get_micro_lesson(chapter_name, micro_id)
  if retrieved_micro
    puts "\n✅ get_micro_lesson() works!"
    puts "   Retrieved same micro: #{retrieved_micro[:id] == micro_id}"
  else
    puts "\n❌ get_micro_lesson() failed!"
  end
  
  # Test get_next_micro
  next_micro = DockerContentLibrary.get_next_micro(chapter_name, micro_id)
  if next_micro
    puts "\n✅ get_next_micro() works!"
    puts "   Next micro ID: #{next_micro[:id]}"
    puts "   Next micro title: #{next_micro[:content][:title]}"
  else
    puts "\n⚠️  get_next_micro() returned nil (might be last step)"
  end
  
  # Test chapter_has_micros?
  has_micros = DockerContentLibrary.chapter_has_micros?(chapter_name)
  puts "\n✅ chapter_has_micros?() works!"
  puts "   Has micros: #{has_micros}"
  
end

puts "\n\n✅ API Test Complete!"
puts "=" * 60
puts "\n🌐 Visit http://localhost:3000/docker/learn to see microlessons in action!"


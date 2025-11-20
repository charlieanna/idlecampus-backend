# Load DSA Concept Microlessons
# This script loads the generated microlessons for each DSA concept/family

require 'json'

puts "Loading DSA Concept Microlessons..."

# Find the DSA course
dsa_course = Course.find_by(slug: 'data-structures-algorithms')

unless dsa_course
  puts "❌ Data Structures & Algorithms course not found. Please ensure the course exists."
  exit
end

puts "✅ Found course: #{dsa_course.title}"

# Load microlessons from JSON
json_file = File.read('db/seeds/generated_dsa_microlessons.json')
microlessons_data = JSON.parse(json_file)

puts "\n📚 Loading #{microlessons_data.length} concept microlessons..."

# Map family_id to topic for module assignment
FAMILY_TO_MODULE = {
  # Arrays & Strings
  /^array-/ => 'arrays-lists-stacks-queues',
  /^string-/ => 'arrays-lists-stacks-queues',
  /^palindrome-/ => 'arrays-lists-stacks-queues',

  # Linked Lists
  /^linked-list-/ => 'arrays-lists-stacks-queues',

  # Stacks & Queues
  /^stack-/ => 'arrays-lists-stacks-queues',
  /^queue-/ => 'arrays-lists-stacks-queues',

  # Trees
  /^tree-/ => 'trees-graphs',

  # Graphs
  /^graph-/ => 'trees-graphs',

  # Hash Tables
  /^hash-/ => 'arrays-lists-stacks-queues',

  # Heaps
  /^heap-/ => 'arrays-lists-stacks-queues',

  # Sorting & Searching
  /^sort-search-/ => 'sorting-searching',

  # Dynamic Programming
  /^dp-/ => 'dynamic-programming',

  # Greedy
  /^greedy-/ => 'dynamic-programming',

  # Backtracking
  /^backtrack-/ => 'dynamic-programming',

  # Recursion
  /^recursion-/ => 'dynamic-programming',

  # Bit Manipulation
  /^bit-/ => 'complexity-analysis',

  # Math
  /^math-/ => 'complexity-analysis',

  # Design
  /^design-/ => 'complexity-analysis'
}

def find_module_for_family(family_id)
  FAMILY_TO_MODULE.each do |pattern, module_slug|
    return module_slug if family_id.match?(pattern)
  end
  'complexity-analysis' # Default
end

created_count = 0
updated_count = 0
skipped_count = 0

microlessons_data.each_with_index do |lesson_data, index|
  family_id = lesson_data['family_id']
  module_slug = find_module_for_family(family_id)

  course_module = CourseModule.find_by(slug: module_slug)

  unless course_module
    puts "  ⚠️  Module '#{module_slug}' not found for #{family_id}, skipping..."
    skipped_count += 1
    next
  end

  # Check if microlesson already exists
  existing = MicroLesson.find_by(
    course_module: course_module,
    title: lesson_data['title']
  )

  begin
    if existing
      existing.update!(
        content: lesson_data['content'],
        reading_time_minutes: lesson_data['reading_time_minutes'],
        key_concepts: lesson_data['key_concepts']
      )
      updated_count += 1
      print "."
    else
      MicroLesson.create!(
        course_module: course_module,
        title: lesson_data['title'],
        content: lesson_data['content'],
        reading_time_minutes: lesson_data['reading_time_minutes'],
        key_concepts: lesson_data['key_concepts']
      )
      created_count += 1
      print "+"
    end

    # Print progress every 20 items
    if (index + 1) % 20 == 0
      puts " (#{index + 1}/#{microlessons_data.length})"
    end

  rescue => e
    puts "\n  ❌ Error processing #{family_id}: #{e.message}"
    skipped_count += 1
  end
end

puts "\n"
puts "=" * 60
puts "✅ Microlesson loading complete!"
puts "=" * 60
puts "  Created: #{created_count}"
puts "  Updated: #{updated_count}"
puts "  Skipped: #{skipped_count}"
puts "  Total:   #{microlessons_data.length}"
puts "=" * 60

# Print summary by module
puts "\n📊 Distribution by module:"
CourseModule.where(course: dsa_course).each do |mod|
  count = MicroLesson.where(course_module: mod).count
  puts "  #{mod.title}: #{count} microlessons"
end

puts "\n🎓 DSA Concept Microlessons loaded successfully!"
puts "\nExample microlessons created:"
puts "  - Sliding Window"
puts "  - Union Find (Disjoint Set Union)"
puts "  - Binary Search"
puts "  - Two Pointers"
puts "  - Dynamic Programming (1D, 2D, etc.)"
puts "  - Tree Traversals"
puts "  - Graph Algorithms (DFS, BFS)"
puts "  - And 100+ more!"

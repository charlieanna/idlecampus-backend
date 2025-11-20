# Assess Content Quality of Chapters 1-14

puts "=" * 80
puts "CONTENT QUALITY ASSESSMENT - Chapters 1-14"
puts "=" * 80

chapters_to_check = [
  "codesprout-hello-world",
  "codesprout-docker-run",
  "codesprout-docker-images",
  "codesprout-docker-pull",
  "codesprout-docker-build-basics"
]

chapters_to_check.each do |slug|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  next unless unit

  puts "\n" + "=" * 80
  puts "Chapter: #{unit.title}"
  puts "Slug: #{slug}"
  puts "Command: #{unit.command_to_learn}"

  # Content quality metrics
  explanation_length = unit.concept_explanation&.length || 0
  has_quiz = unit.quiz_question_text.present?
  quiz_options_count = unit.quiz_options&.count || 0
  has_variations = unit.command_variations&.any? || false
  hints_count = unit.practice_hints&.count || 0

  puts "\nQuality Metrics:"
  puts "  Explanation length: #{explanation_length} chars"
  puts "  Status: #{explanation_length > 2000 ? 'DETAILED' : 'BRIEF'}"
  puts "  Quiz: #{has_quiz ? "Yes (#{quiz_options_count} options)" : 'No'}"
  puts "  Command variations: #{has_variations ? 'Yes' : 'No'}"
  puts "  Practice hints: #{hints_count}"

  # Show first 300 chars
  if unit.concept_explanation
    preview = unit.concept_explanation.strip.lines.first(5).join("\n")
    puts "\nContent Preview:"
    puts preview[0..300]
    puts "..."
  end
end

puts "\n" + "=" * 80
puts "ASSESSMENT COMPLETE"
puts "=" * 80

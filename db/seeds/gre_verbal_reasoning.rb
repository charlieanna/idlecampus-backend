# GRE Verbal Reasoning Course
# This seed file creates the main GRE Verbal Reasoning course with three modules:
# 1. Reading Comprehension
# 2. Text Completion
# 3. Sentence Equivalence

puts "Creating GRE Verbal Reasoning course..."

course = Course.find_or_create_by!(slug: 'gre-verbal-reasoning') do |c|
  c.title = 'GRE Verbal Reasoning'
  c.description = 'Master all aspects of GRE Verbal Reasoning including Reading Comprehension, Text Completion, and Sentence Equivalence. Build vocabulary, comprehension skills, and test-taking strategies.'
  c.difficulty_level = 'intermediate'
  c.certification_track = 'none'
  c.estimated_hours = 35
  c.published = true
  c.learning_objectives = [
    'Analyze complex passages and answer comprehension questions',
    'Master advanced vocabulary in context',
    'Identify sentence structure and meaning',
    'Apply test-taking strategies for GRE Verbal section',
    'Improve reading speed and accuracy',
    'Build vocabulary through contextual learning'
  ]
  c.prerequisites = [
    'Strong foundation in English grammar',
    'College-level reading ability',
    'Basic vocabulary (minimum 3000 words)'
  ]
  c.target_audience = [
    'Graduate school applicants',
    'Students preparing for GRE exam',
    'Anyone looking to improve verbal reasoning skills'
  ]
end

puts "✓ Created course: #{course.title}"

# Module 1: Reading Comprehension
reading_comp_module = course.course_modules.find_or_create_by!(slug: 'reading-comprehension') do |m|
  m.title = 'Reading Comprehension'
  m.sequence_order = 1
  m.estimated_minutes = 600
  m.description = 'Develop strategies for analyzing passages and answering questions about main ideas, details, inferences, and author intent.'
end

puts "✓ Created module: #{reading_comp_module.title}"

# Module 2: Text Completion
text_completion_module = course.course_modules.find_or_create_by!(slug: 'text-completion') do |m|
  m.title = 'Text Completion'
  m.sequence_order = 2
  m.estimated_minutes = 480
  m.description = 'Master single-blank, double-blank, and triple-blank text completion questions using context clues and vocabulary.'
end

puts "✓ Created module: #{text_completion_module.title}"

# Module 3: Sentence Equivalence
sentence_equiv_module = course.course_modules.find_or_create_by!(slug: 'sentence-equivalence') do |m|
  m.title = 'Sentence Equivalence'
  m.sequence_order = 3
  m.estimated_minutes = 420
  m.description = 'Identify pairs of words that complete sentences with equivalent meanings, building vocabulary and comprehension skills.'
end

puts "✓ Created module: #{sentence_equiv_module.title}"

puts "GRE Verbal Reasoning course structure created successfully!"

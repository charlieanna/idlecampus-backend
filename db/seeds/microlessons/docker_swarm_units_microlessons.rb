# AUTO-GENERATED from docker_swarm_units.rb
puts "Creating Microlessons for Docker Swarm..."

module_var = CourseModule.find_by(slug: 'docker-swarm')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 1 microlessons for Docker Swarm"

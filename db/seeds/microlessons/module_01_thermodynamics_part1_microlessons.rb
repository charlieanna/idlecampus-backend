# AUTO-GENERATED from module_01_thermodynamics_part1.rb
puts "Creating Microlessons for Module 01 Thermodynamics Part1..."

module_var = CourseModule.find_by(slug: 'module-01-thermodynamics-part1')

# === MICROLESSON 1: Lesson 1.1: System, Surroundings, and State Functions ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1.1: System, Surroundings, and State Functions',
  content: <<~MARKDOWN,
# Lesson 1.1: System, Surroundings, and State Functions 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 1.2: First Law of Thermodynamics ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1.2: First Law of Thermodynamics',
  content: <<~MARKDOWN,
# Lesson 1.2: First Law of Thermodynamics 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Lesson 1.3: Thermochemistry and Hess\ ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1.3: Thermochemistry and Hess\',
  content: <<~MARKDOWN,
# Lesson 1.3: Thermochemistry and Hess\ 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 3 microlessons for Module 01 Thermodynamics Part1"

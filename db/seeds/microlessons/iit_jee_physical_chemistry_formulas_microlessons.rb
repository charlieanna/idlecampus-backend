# AUTO-GENERATED from iit_jee_physical_chemistry_formulas.rb
puts "Creating Microlessons for Physical Formula Drills..."

module_var = CourseModule.find_by(slug: 'physical-formula-drills')

# === MICROLESSON 1: What is the #{formula_data[:name]}? ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the #{formula_data[:name]}?',
  content: <<~MARKDOWN,
# What is the #{formula_data[:name]}? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: thermodynamics — Practice ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'thermodynamics — Practice',
  content: <<~MARKDOWN,
# thermodynamics — Practice 🚀

#{formula_data[:name]} is #{formula_data[:formula]}

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['thermodynamics'],
  prerequisite_ids: []
)

# Exercise 2.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '#{formula_data[:name]} is #{formula_data[:formula]}',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 3: chemical kinetics — Practice ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical kinetics — Practice',
  content: <<~MARKDOWN,
# chemical kinetics — Practice 🚀

#{formula_data[:name]} is #{formula_data[:formula]}

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['chemical kinetics'],
  prerequisite_ids: []
)

# Exercise 3.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '#{formula_data[:name]} is #{formula_data[:formula]}',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 4: electrochemistry — Practice ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'electrochemistry — Practice',
  content: <<~MARKDOWN,
# electrochemistry — Practice 🚀

#{formula_data[:name]} is #{formula_data[:formula]}

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['electrochemistry'],
  prerequisite_ids: []
)

# Exercise 4.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '#{formula_data[:name]} is #{formula_data[:formula]}',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 5: equilibrium and solutions — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'equilibrium and solutions — Practice',
  content: <<~MARKDOWN,
# equilibrium and solutions — Practice 🚀

#{formula_data[:name]} is #{formula_data[:formula]}

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['equilibrium and solutions'],
  prerequisite_ids: []
)

# Exercise 5.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '#{formula_data[:name]} is #{formula_data[:formula]}',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 6: What is the #{formula_data[:name]}? ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the #{formula_data[:name]}?',
  content: <<~MARKDOWN,
# What is the #{formula_data[:name]}? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 6.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 7: What is the #{formula_data[:name]}? ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the #{formula_data[:name]}?',
  content: <<~MARKDOWN,
# What is the #{formula_data[:name]}? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: What is the #{formula_data[:name]}? ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the #{formula_data[:name]}?',
  content: <<~MARKDOWN,
# What is the #{formula_data[:name]}? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: What is the #{formula_data[:name]}? ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the #{formula_data[:name]}?',
  content: <<~MARKDOWN,
# What is the #{formula_data[:name]}? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: gas laws — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'gas laws — Practice',
  content: <<~MARKDOWN,
# gas laws — Practice 🚀

#{formula_data[:name]} is #{formula_data[:formula]}

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['gas laws'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the #{formula_data[:name]}?',
    answer: '',
    explanation: '#{formula_data[:name]} is #{formula_data[:formula]}',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

puts "✓ Created 10 microlessons for Iit Jee Physical Chemistry Formulas"

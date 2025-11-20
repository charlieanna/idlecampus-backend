# AUTO-GENERATED from iit_jee_mathematics_trigonometry.rb
puts "Creating Microlessons for Trig Identities..."

module_var = CourseModule.find_by(slug: 'trig-identities')

# === MICROLESSON 1: Find $$\\vec{a} \\cdot \\vec{b}$$ if $$\\vec{a} = 2\\hat{i} + 3\\hat{j}$$ and $$\\vec{b} = 4\\hat{i} + 5\\hat{j}$$ ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find $$\\vec{a} \\cdot \\vec{b}$$ if $$\\vec{a} = 2\\hat{i} + 3\\hat{j}$$ and $$\\vec{b} = 4\\hat{i} + 5\\hat{j}$$',
  content: <<~MARKDOWN,
# Find $$\\vec{a} \\cdot \\vec{b}$$ if $$\\vec{a} = 2\\hat{i} + 3\\hat{j}$$ and $$\\vec{b} = 4\\hat{i} + 5\\hat{j}$$ 🚀

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
    question: 'Find $$\\vec{a} \\cdot \\vec{b}$$ if $$\\vec{a} = 2\\hat{i} + 3\\hat{j}$$ and $$\\vec{b} = 4\\hat{i} + 5\\hat{j}$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: trig-equations-basic — Practice ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'trig-equations-basic — Practice',
  content: <<~MARKDOWN,
# trig-equations-basic — Practice 🚀

Find general solution using trig identities

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['trig-equations-basic'],
  prerequisite_ids: []
)

# === MICROLESSON 3: inverse-trig-values — Practice ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'inverse-trig-values — Practice',
  content: <<~MARKDOWN,
# inverse-trig-values — Practice 🚀

Use principal value ranges

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['inverse-trig-values'],
  prerequisite_ids: []
)

# === MICROLESSON 4: vectors-magnitude — Practice ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'vectors-magnitude — Practice',
  content: <<~MARKDOWN,
# vectors-magnitude — Practice 🚀

|a| = √(3² + 4²) = √(9 + 16) = √25 = 5

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['vectors-magnitude'],
  prerequisite_ids: []
)

# Exercise 4.2: MCQ
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find the magnitude of vector $$\\vec{a} = 3\\hat{i} + 4\\hat{j}$$',
    options: ['Coincident'],
    correct_answer: 0,
    explanation: '|a| = √(3² + 4²) = √(9 + 16) = √25 = 5',
    difficulty: 'medium'
  }
)

# === MICROLESSON 5: Which identity is correct? ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which identity is correct?',
  content: <<~MARKDOWN,
# Which identity is correct? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 5.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which identity is correct?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 6: If $$\\sin\\theta = \\frac{3}{5}$$ and $$\\theta$$ is in first quadrant, find $$\\cos\\theta$$ ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'If $$\\sin\\theta = \\frac{3}{5}$$ and $$\\theta$$ is in first quadrant, find $$\\cos\\theta$$',
  content: <<~MARKDOWN,
# If $$\\sin\\theta = \\frac{3}{5}$$ and $$\\theta$$ is in first quadrant, find $$\\cos\\theta$$ 🚀

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
    question: 'If $$\\sin\\theta = \\frac{3}{5}$$ and $$\\theta$$ is in first quadrant, find $$\\cos\\theta$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 7: Find the general solution of $$\\sin x = 0$$ ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the general solution of $$\\sin x = 0$$',
  content: <<~MARKDOWN,
# Find the general solution of $$\\sin x = 0$$ 🚀

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
    question: 'Find the general solution of $$\\sin x = 0$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: Find $$\\sin^{-1}\\left(\\frac{1}{2}\\right)$$ ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find $$\\sin^{-1}\\left(\\frac{1}{2}\\right)$$',
  content: <<~MARKDOWN,
# Find $$\\sin^{-1}\\left(\\frac{1}{2}\\right)$$ 🚀

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
    question: 'Find $$\\sin^{-1}\\left(\\frac{1}{2}\\right)$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: Find the magnitude of vector $$\\vec{a} = 3\\hat{i} + 4\\hat{j}$$ ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the magnitude of vector $$\\vec{a} = 3\\hat{i} + 4\\hat{j}$$',
  content: <<~MARKDOWN,
# Find the magnitude of vector $$\\vec{a} = 3\\hat{i} + 4\\hat{j}$$ 🚀

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
    question: 'Find the magnitude of vector $$\\vec{a} = 3\\hat{i} + 4\\hat{j}$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: trig-basic-identities — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'trig-basic-identities — Practice',
  content: <<~MARKDOWN,
# trig-basic-identities — Practice 🚀

Use compound angle formulas

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['trig-basic-identities'],
  prerequisite_ids: []
)

puts "✓ Created 10 microlessons for Trig Identities"

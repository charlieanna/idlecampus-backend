# AUTO-GENERATED from iit_jee_mathematics_algebra.rb
puts "Creating Microlessons for Quadratic Equations..."

module_var = CourseModule.find_by(slug: 'quadratic-equations')

# === MICROLESSON 1: What is the focus of the parabola $$y^2 = 4x$$? ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the focus of the parabola $$y^2 = 4x$$?',
  content: <<~MARKDOWN,
# What is the focus of the parabola $$y^2 = 4x$$? 🚀

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
    question: 'What is the focus of the parabola $$y^2 = 4x$$?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: sequences-ap — Practice ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'sequences-ap — Practice',
  content: <<~MARKDOWN,
# sequences-ap — Practice 🚀

Apply AP/GP formulas

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['sequences-ap'],
  prerequisite_ids: []
)

# Exercise 2.2: MCQ
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find the 10th term of AP: 2, 5, 8, 11, ...',
    options: ['None of these'],
    correct_answer: 0,
    explanation: 'Apply AP/GP formulas',
    difficulty: 'medium'
  }
)

# === MICROLESSON 3: coordinate-distance — Practice ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'coordinate-distance — Practice',
  content: <<~MARKDOWN,
# coordinate-distance — Practice 🚀

Distance = √[(x₂-x₁)² + (y₂-y₁)²] = √[9 + 16] = √25 = 5

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['coordinate-distance'],
  prerequisite_ids: []
)

# Exercise 3.2: MCQ
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find the distance between points $$(0, 0)$$ and $$(3, 4)$$',
    options: ['Coincident'],
    correct_answer: 0,
    explanation: 'Distance = √[(x₂-x₁)² + (y₂-y₁)²] = √[9 + 16] = √25 = 5',
    difficulty: 'medium'
  }
)

# === MICROLESSON 4: conics-parabola — Practice ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'conics-parabola — Practice',
  content: <<~MARKDOWN,
# conics-parabola — Practice 🚀

Identify conic type and apply standard form

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['conics-parabola'],
  prerequisite_ids: []
)

# === MICROLESSON 5: For the equation $$x^2 - 5x + 6 = 0$$, find the sum of the roots ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'For the equation $$x^2 - 5x + 6 = 0$$, find the sum of the roots',
  content: <<~MARKDOWN,
# For the equation $$x^2 - 5x + 6 = 0$$, find the sum of the roots 🚀

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
    question: 'For the equation $$x^2 - 5x + 6 = 0$$, find the sum of the roots',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 6: Find the discriminant of $$2x^2 + 3x - 5 = 0$$ ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the discriminant of $$2x^2 + 3x - 5 = 0$$',
  content: <<~MARKDOWN,
# Find the discriminant of $$2x^2 + 3x - 5 = 0$$ 🚀

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
    question: 'Find the discriminant of $$2x^2 + 3x - 5 = 0$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 7: If the roots of $$x^2 - 6x + k = 0$$ are equal, find k ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'If the roots of $$x^2 - 6x + k = 0$$ are equal, find k',
  content: <<~MARKDOWN,
# If the roots of $$x^2 - 6x + k = 0$$ are equal, find k 🚀

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
    question: 'If the roots of $$x^2 - 6x + k = 0$$ are equal, find k',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: Find the 10th term of AP: 2, 5, 8, 11, ... ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the 10th term of AP: 2, 5, 8, 11, ...',
  content: <<~MARKDOWN,
# Find the 10th term of AP: 2, 5, 8, 11, ... 🚀

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
    question: 'Find the 10th term of AP: 2, 5, 8, 11, ...',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: Find the sum of first 10 natural numbers ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the sum of first 10 natural numbers',
  content: <<~MARKDOWN,
# Find the sum of first 10 natural numbers 🚀

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
    question: 'Find the sum of first 10 natural numbers',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: Find the distance between points $$(0, 0)$$ and $$(3, 4)$$ ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the distance between points $$(0, 0)$$ and $$(3, 4)$$',
  content: <<~MARKDOWN,
# Find the distance between points $$(0, 0)$$ and $$(3, 4)$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find the distance between points $$(0, 0)$$ and $$(3, 4)$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: Find the slope of the line passing through $$(1, 2)$$ and $$(3, 6)$$ ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the slope of the line passing through $$(1, 2)$$ and $$(3, 6)$$',
  content: <<~MARKDOWN,
# Find the slope of the line passing through $$(1, 2)$$ and $$(3, 6)$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find the slope of the line passing through $$(1, 2)$$ and $$(3, 6)$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: quadratic-sum-product — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'quadratic-sum-product — Practice',
  content: <<~MARKDOWN,
# quadratic-sum-product — Practice 🚀

Apply quadratic formula or analyze discriminant

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['quadratic-sum-product'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For the equation $$x^2 - 5x + 6 = 0$$, find the sum of the roots',
    options: ['Cannot be determined'],
    correct_answer: 0,
    explanation: 'Apply quadratic formula or analyze discriminant',
    difficulty: 'medium'
  }
)

puts "✓ Created 12 microlessons for Quadratic Equations"

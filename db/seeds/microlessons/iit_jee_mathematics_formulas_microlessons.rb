# AUTO-GENERATED from iit_jee_mathematics_formulas.rb
puts "Creating Microlessons for Formula Drills..."

module_var = CourseModule.find_by(slug: 'formula-drills')

# === MICROLESSON 1: sin(mx)cos(nx) — Drill ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'sin(mx)cos(nx) — Drill',
  content: <<~MARKDOWN,
# sin(mx)cos(nx) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['sin(mx)cos(nx)'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'sin(mx)cos(nx): ∫sin(mx)cos(nx) dx = ? (general form)',
    answer: 'Use product-to-sum formulas',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 2: Constant Rule — Drill ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Constant Rule — Drill',
  content: <<~MARKDOWN,
# Constant Rule — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Constant Rule'],
  prerequisite_ids: []
)

# Exercise 2.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Constant Rule: d/dx[c] = ? (where c is constant)',
    answer: '0',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 3: Sum Rule — Drill ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Sum Rule — Drill',
  content: <<~MARKDOWN,
# Sum Rule — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Sum Rule'],
  prerequisite_ids: []
)

# Exercise 3.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Sum Rule: d/dx[f(x) + g(x)] = ?',
    answer: 'f\',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 4: Product Rule — Drill ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Product Rule — Drill',
  content: <<~MARKDOWN,
# Product Rule — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Product Rule'],
  prerequisite_ids: []
)

# Exercise 4.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Product Rule: d/dx[f(x)·g(x)] = ?',
    answer: 'f\',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 5: Quotient Rule — Drill ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Quotient Rule — Drill',
  content: <<~MARKDOWN,
# Quotient Rule — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Quotient Rule'],
  prerequisite_ids: []
)

# Exercise 5.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Quotient Rule: d/dx[f(x)/g(x)] = ?',
    answer: '[f\',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 6: Chain Rule — Drill ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Chain Rule — Drill',
  content: <<~MARKDOWN,
# Chain Rule — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Chain Rule'],
  prerequisite_ids: []
)

# Exercise 6.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Chain Rule: d/dx[f(g(x))] = ?',
    answer: 'f\',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 7: Sine — Drill ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Sine — Drill',
  content: <<~MARKDOWN,
# Sine — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Sine'],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Sine: d/dx[sin(x)] = ?',
    answer: 'cos(x)|cos x',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 8: Cosine — Drill ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cosine — Drill',
  content: <<~MARKDOWN,
# Cosine — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cosine'],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cosine: d/dx[cos(x)] = ?',
    answer: '-sin(x)|-sin x',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 9: Tangent — Drill ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Tangent — Drill',
  content: <<~MARKDOWN,
# Tangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Tangent'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Tangent: d/dx[tan(x)] = ?',
    answer: 'sec²(x)|sec²x|sec^2(x)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 10: Cotangent — Drill ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cotangent — Drill',
  content: <<~MARKDOWN,
# Cotangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cotangent'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cotangent: d/dx[cot(x)] = ?',
    answer: '-cosec²(x)|-csc²x|-cosec^2(x)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 11: Secant — Drill ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Secant — Drill',
  content: <<~MARKDOWN,
# Secant — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Secant'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Secant: d/dx[sec(x)] = ?',
    answer: 'sec(x)·tan(x)|sec x tan x',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 12: Cosecant — Drill ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cosecant — Drill',
  content: <<~MARKDOWN,
# Cosecant — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cosecant'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cosecant: d/dx[cosec(x)] = ?',
    answer: '-cosec(x)·cot(x)|-csc x cot x',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 13: Natural Exponential — Drill ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Natural Exponential — Drill',
  content: <<~MARKDOWN,
# Natural Exponential — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Natural Exponential'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Natural Exponential: d/dx[eˣ] = ?',
    answer: 'eˣ|e^x|exp(x)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 14: Exponential aˣ — Drill ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Exponential aˣ — Drill',
  content: <<~MARKDOWN,
# Exponential aˣ — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Exponential aˣ'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Exponential aˣ: d/dx[aˣ] = ?',
    answer: 'aˣ·ln(a)|a^x·ln(a)|a^x ln a',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 15: Natural Log — Drill ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Natural Log — Drill',
  content: <<~MARKDOWN,
# Natural Log — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Natural Log'],
  prerequisite_ids: []
)

# Exercise 15.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Natural Log: d/dx[ln(x)] = ?',
    answer: '1/x',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 16: Log base a — Drill ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Log base a — Drill',
  content: <<~MARKDOWN,
# Log base a — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Log base a'],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Log base a: d/dx[logₐ(x)] = ?',
    answer: '1/(x·ln(a))|1/(x ln a)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 17: Arcsine — Drill ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arcsine — Drill',
  content: <<~MARKDOWN,
# Arcsine — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Arcsine'],
  prerequisite_ids: []
)

# Exercise 17.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arcsine: d/dx[sin⁻¹(x)] = ?',
    answer: '1/√(1-x²)|1/sqrt(1-x^2)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 18: Arccosine — Drill ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arccosine — Drill',
  content: <<~MARKDOWN,
# Arccosine — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Arccosine'],
  prerequisite_ids: []
)

# Exercise 18.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arccosine: d/dx[cos⁻¹(x)] = ?',
    answer: '-1/√(1-x²)|-1/sqrt(1-x^2)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 19: Arctangent — Drill ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arctangent — Drill',
  content: <<~MARKDOWN,
# Arctangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Arctangent'],
  prerequisite_ids: []
)

# Exercise 19.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arctangent: d/dx[tan⁻¹(x)] = ?',
    answer: '1/(1+x²)|1/(1+x^2)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 20: Arccotangent — Drill ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arccotangent — Drill',
  content: <<~MARKDOWN,
# Arccotangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Arccotangent'],
  prerequisite_ids: []
)

# Exercise 20.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arccotangent: d/dx[cot⁻¹(x)] = ?',
    answer: '-1/(1+x²)|-1/(1+x^2)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 21: Arcsecant — Drill ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arcsecant — Drill',
  content: <<~MARKDOWN,
# Arcsecant — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Arcsecant'],
  prerequisite_ids: []
)

# Exercise 21.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_21,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arcsecant: d/dx[sec⁻¹(x)] = ?',
    answer: '1/(|x|√(x²-1))|1/(x sqrt(x^2-1))',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 22: Arccosecant — Drill ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arccosecant — Drill',
  content: <<~MARKDOWN,
# Arccosecant — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Arccosecant'],
  prerequisite_ids: []
)

# Exercise 22.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_22,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arccosecant: d/dx[cosec⁻¹(x)] = ?',
    answer: '-1/(|x|√(x²-1))|-1/(x sqrt(x^2-1))',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 23: Hyperbolic Sine — Drill ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hyperbolic Sine — Drill',
  content: <<~MARKDOWN,
# Hyperbolic Sine — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Hyperbolic Sine'],
  prerequisite_ids: []
)

# Exercise 23.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_23,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Hyperbolic Sine: d/dx[sinh(x)] = ?',
    answer: 'cosh(x)|cosh x',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 24: Hyperbolic Cosine — Drill ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hyperbolic Cosine — Drill',
  content: <<~MARKDOWN,
# Hyperbolic Cosine — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Hyperbolic Cosine'],
  prerequisite_ids: []
)

# Exercise 24.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_24,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Hyperbolic Cosine: d/dx[cosh(x)] = ?',
    answer: 'sinh(x)|sinh x',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 25: Hyperbolic Tangent — Drill ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hyperbolic Tangent — Drill',
  content: <<~MARKDOWN,
# Hyperbolic Tangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Hyperbolic Tangent'],
  prerequisite_ids: []
)

# Exercise 25.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_25,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Hyperbolic Tangent: d/dx[tanh(x)] = ?',
    answer: 'sech²(x)|sech^2(x)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 26: Absolute Value — Drill ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'Absolute Value — Drill',
  content: <<~MARKDOWN,
# Absolute Value — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Absolute Value'],
  prerequisite_ids: []
)

# Exercise 26.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_26,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Absolute Value: d/dx[|x|] = ?',
    answer: 'x/|x||sgn(x)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 27: Square Root — Drill ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'Square Root — Drill',
  content: <<~MARKDOWN,
# Square Root — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Square Root'],
  prerequisite_ids: []
)

# Exercise 27.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_27,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Square Root: d/dx[√x] = ?',
    answer: '1/(2√x)|1/(2sqrt(x))',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 28: Cube Root — Drill ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cube Root — Drill',
  content: <<~MARKDOWN,
# Cube Root — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cube Root'],
  prerequisite_ids: []
)

# Exercise 28.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_28,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cube Root: d/dx[∛x] = ?',
    answer: '1/(3∛(x²))|1/(3x^(2/3))',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 29: e^f(x) — Drill ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'e^f(x) — Drill',
  content: <<~MARKDOWN,
# e^f(x) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['e^f(x)'],
  prerequisite_ids: []
)

# Exercise 29.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_29,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'e^f(x): d/dx[e^f(x)] = ?',
    answer: 'e^f(x)·f\',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 30: ln f(x) — Drill ===
lesson_30 = MicroLesson.create!(
  course_module: module_var,
  title: 'ln f(x) — Drill',
  content: <<~MARKDOWN,
# ln f(x) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 30,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['ln f(x)'],
  prerequisite_ids: []
)

# Exercise 30.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_30,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'ln f(x): d/dx[ln f(x)] = ?',
    answer: 'f\',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 31: Power Rule — Drill ===
lesson_31 = MicroLesson.create!(
  course_module: module_var,
  title: 'Power Rule — Drill',
  content: <<~MARKDOWN,
# Power Rule — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 31,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Power Rule'],
  prerequisite_ids: []
)

# Exercise 31.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_31,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Power Rule: ∫xⁿ dx = ? (n ≠ -1)',
    answer: 'xⁿ⁺¹/(n+1) + C|x^(n+1)/(n+1) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 32: 1/x — Drill ===
lesson_32 = MicroLesson.create!(
  course_module: module_var,
  title: '1/x — Drill',
  content: <<~MARKDOWN,
# 1/x — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 32,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['1/x'],
  prerequisite_ids: []
)

# Exercise 32.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_32,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '1/x: ∫(1/x) dx = ?',
    answer: 'ln|x| + C|ln(|x|) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 33: Exponential — Drill ===
lesson_33 = MicroLesson.create!(
  course_module: module_var,
  title: 'Exponential — Drill',
  content: <<~MARKDOWN,
# Exponential — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 33,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Exponential'],
  prerequisite_ids: []
)

# Exercise 33.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_33,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Exponential: ∫eˣ dx = ?',
    answer: 'eˣ + C|e^x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 34: aˣ — Drill ===
lesson_34 = MicroLesson.create!(
  course_module: module_var,
  title: 'aˣ — Drill',
  content: <<~MARKDOWN,
# aˣ — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 34,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['aˣ'],
  prerequisite_ids: []
)

# Exercise 34.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_34,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'aˣ: ∫aˣ dx = ?',
    answer: 'aˣ/ln(a) + C|a^x/ln(a) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 35: Sine — Drill ===
lesson_35 = MicroLesson.create!(
  course_module: module_var,
  title: 'Sine — Drill',
  content: <<~MARKDOWN,
# Sine — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 35,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Sine'],
  prerequisite_ids: []
)

# Exercise 35.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_35,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Sine: ∫sin(x) dx = ?',
    answer: '-cos(x) + C|-cos x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 36: Cosine — Drill ===
lesson_36 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cosine — Drill',
  content: <<~MARKDOWN,
# Cosine — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 36,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cosine'],
  prerequisite_ids: []
)

# Exercise 36.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_36,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cosine: ∫cos(x) dx = ?',
    answer: 'sin(x) + C|sin x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 37: Secant² — Drill ===
lesson_37 = MicroLesson.create!(
  course_module: module_var,
  title: 'Secant² — Drill',
  content: <<~MARKDOWN,
# Secant² — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 37,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Secant²'],
  prerequisite_ids: []
)

# Exercise 37.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_37,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Secant²: ∫sec²(x) dx = ?',
    answer: 'tan(x) + C|tan x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 38: Cosecant² — Drill ===
lesson_38 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cosecant² — Drill',
  content: <<~MARKDOWN,
# Cosecant² — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 38,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cosecant²'],
  prerequisite_ids: []
)

# Exercise 38.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_38,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cosecant²: ∫cosec²(x) dx = ?',
    answer: '-cot(x) + C|-cot x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 39: Secant·Tangent — Drill ===
lesson_39 = MicroLesson.create!(
  course_module: module_var,
  title: 'Secant·Tangent — Drill',
  content: <<~MARKDOWN,
# Secant·Tangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 39,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Secant·Tangent'],
  prerequisite_ids: []
)

# Exercise 39.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_39,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Secant·Tangent: ∫sec(x)·tan(x) dx = ?',
    answer: 'sec(x) + C|sec x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 40: Cosecant·Cotangent — Drill ===
lesson_40 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cosecant·Cotangent — Drill',
  content: <<~MARKDOWN,
# Cosecant·Cotangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 40,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cosecant·Cotangent'],
  prerequisite_ids: []
)

# Exercise 40.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_40,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cosecant·Cotangent: ∫cosec(x)·cot(x) dx = ?',
    answer: '-cosec(x) + C|-csc x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 41: Tangent — Drill ===
lesson_41 = MicroLesson.create!(
  course_module: module_var,
  title: 'Tangent — Drill',
  content: <<~MARKDOWN,
# Tangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 41,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Tangent'],
  prerequisite_ids: []
)

# Exercise 41.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_41,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Tangent: ∫tan(x) dx = ?',
    answer: 'ln|sec(x)| + C|ln|sec x| + C|-ln|cos x| + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 42: Cotangent — Drill ===
lesson_42 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cotangent — Drill',
  content: <<~MARKDOWN,
# Cotangent — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 42,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cotangent'],
  prerequisite_ids: []
)

# Exercise 42.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_42,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cotangent: ∫cot(x) dx = ?',
    answer: 'ln|sin(x)| + C|ln|sin x| + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 43: Secant — Drill ===
lesson_43 = MicroLesson.create!(
  course_module: module_var,
  title: 'Secant — Drill',
  content: <<~MARKDOWN,
# Secant — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 43,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Secant'],
  prerequisite_ids: []
)

# Exercise 43.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_43,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Secant: ∫sec(x) dx = ?',
    answer: 'ln|sec(x)+tan(x)| + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 44: Cosecant — Drill ===
lesson_44 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cosecant — Drill',
  content: <<~MARKDOWN,
# Cosecant — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 44,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Cosecant'],
  prerequisite_ids: []
)

# Exercise 44.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_44,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cosecant: ∫cosec(x) dx = ?',
    answer: 'ln|cosec(x)-cot(x)| + C|-ln|csc x+cot x| + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 45: 1/(1+x²) — Drill ===
lesson_45 = MicroLesson.create!(
  course_module: module_var,
  title: '1/(1+x²) — Drill',
  content: <<~MARKDOWN,
# 1/(1+x²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 45,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['1/(1+x²)'],
  prerequisite_ids: []
)

# Exercise 45.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_45,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '1/(1+x²): ∫1/(1+x²) dx = ?',
    answer: 'tan⁻¹(x) + C|arctan(x) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 46: 1/√(1-x²) — Drill ===
lesson_46 = MicroLesson.create!(
  course_module: module_var,
  title: '1/√(1-x²) — Drill',
  content: <<~MARKDOWN,
# 1/√(1-x²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 46,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['1/√(1-x²)'],
  prerequisite_ids: []
)

# Exercise 46.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_46,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '1/√(1-x²): ∫1/√(1-x²) dx = ?',
    answer: 'sin⁻¹(x) + C|arcsin(x) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 47: -1/√(1-x²) — Drill ===
lesson_47 = MicroLesson.create!(
  course_module: module_var,
  title: '-1/√(1-x²) — Drill',
  content: <<~MARKDOWN,
# -1/√(1-x²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 47,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['-1/√(1-x²)'],
  prerequisite_ids: []
)

# Exercise 47.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_47,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '-1/√(1-x²): ∫-1/√(1-x²) dx = ?',
    answer: 'cos⁻¹(x) + C|arccos(x) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 48: 1/(x√(x²-1)) — Drill ===
lesson_48 = MicroLesson.create!(
  course_module: module_var,
  title: '1/(x√(x²-1)) — Drill',
  content: <<~MARKDOWN,
# 1/(x√(x²-1)) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 48,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['1/(x√(x²-1))'],
  prerequisite_ids: []
)

# Exercise 48.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_48,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '1/(x√(x²-1)): ∫1/(x√(x²-1)) dx = ?',
    answer: 'sec⁻¹(x) + C|arcsec(x) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 49: 1/(a²+x²) — Drill ===
lesson_49 = MicroLesson.create!(
  course_module: module_var,
  title: '1/(a²+x²) — Drill',
  content: <<~MARKDOWN,
# 1/(a²+x²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 49,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['1/(a²+x²)'],
  prerequisite_ids: []
)

# Exercise 49.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_49,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '1/(a²+x²): ∫1/(a²+x²) dx = ?',
    answer: '(1/a)tan⁻¹(x/a) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 50: 1/√(a²-x²) — Drill ===
lesson_50 = MicroLesson.create!(
  course_module: module_var,
  title: '1/√(a²-x²) — Drill',
  content: <<~MARKDOWN,
# 1/√(a²-x²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 50,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['1/√(a²-x²)'],
  prerequisite_ids: []
)

# Exercise 50.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_50,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '1/√(a²-x²): ∫1/√(a²-x²) dx = ?',
    answer: 'sin⁻¹(x/a) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 51: 1/√(x²-a²) — Drill ===
lesson_51 = MicroLesson.create!(
  course_module: module_var,
  title: '1/√(x²-a²) — Drill',
  content: <<~MARKDOWN,
# 1/√(x²-a²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 51,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['1/√(x²-a²)'],
  prerequisite_ids: []
)

# Exercise 51.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_51,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '1/√(x²-a²): ∫1/√(x²-a²) dx = ?',
    answer: 'ln|x+√(x²-a²)| + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 52: 1/√(x²+a²) — Drill ===
lesson_52 = MicroLesson.create!(
  course_module: module_var,
  title: '1/√(x²+a²) — Drill',
  content: <<~MARKDOWN,
# 1/√(x²+a²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 52,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['1/√(x²+a²)'],
  prerequisite_ids: []
)

# Exercise 52.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_52,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '1/√(x²+a²): ∫1/√(x²+a²) dx = ?',
    answer: 'ln|x+√(x²+a²)| + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 53: √(a²-x²) — Drill ===
lesson_53 = MicroLesson.create!(
  course_module: module_var,
  title: '√(a²-x²) — Drill',
  content: <<~MARKDOWN,
# √(a²-x²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 53,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['√(a²-x²)'],
  prerequisite_ids: []
)

# Exercise 53.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_53,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '√(a²-x²): ∫√(a²-x²) dx = ?',
    answer: '(x/2)√(a²-x²) + (a²/2)sin⁻¹(x/a) + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 54: √(x²+a²) — Drill ===
lesson_54 = MicroLesson.create!(
  course_module: module_var,
  title: '√(x²+a²) — Drill',
  content: <<~MARKDOWN,
# √(x²+a²) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 54,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['√(x²+a²)'],
  prerequisite_ids: []
)

# Exercise 54.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_54,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '√(x²+a²): ∫√(x²+a²) dx = ?',
    answer: '(x/2)√(x²+a²) + (a²/2)ln|x+√(x²+a²)| + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 55: Integration by Parts — Drill ===
lesson_55 = MicroLesson.create!(
  course_module: module_var,
  title: 'Integration by Parts — Drill',
  content: <<~MARKDOWN,
# Integration by Parts — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 55,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Integration by Parts'],
  prerequisite_ids: []
)

# Exercise 55.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_55,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Integration by Parts: ∫u dv = ?',
    answer: 'uv - ∫v du',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 56: sin²(x) — Drill ===
lesson_56 = MicroLesson.create!(
  course_module: module_var,
  title: 'sin²(x) — Drill',
  content: <<~MARKDOWN,
# sin²(x) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 56,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['sin²(x)'],
  prerequisite_ids: []
)

# Exercise 56.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_56,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'sin²(x): ∫sin²(x) dx = ?',
    answer: 'x/2 - sin(2x)/4 + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 57: cos²(x) — Drill ===
lesson_57 = MicroLesson.create!(
  course_module: module_var,
  title: 'cos²(x) — Drill',
  content: <<~MARKDOWN,
# cos²(x) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 57,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['cos²(x)'],
  prerequisite_ids: []
)

# Exercise 57.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_57,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'cos²(x): ∫cos²(x) dx = ?',
    answer: 'x/2 + sin(2x)/4 + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 58: tan²(x) — Drill ===
lesson_58 = MicroLesson.create!(
  course_module: module_var,
  title: 'tan²(x) — Drill',
  content: <<~MARKDOWN,
# tan²(x) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 58,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['tan²(x)'],
  prerequisite_ids: []
)

# Exercise 58.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_58,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'tan²(x): ∫tan²(x) dx = ?',
    answer: 'tan(x) - x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 59: cot²(x) — Drill ===
lesson_59 = MicroLesson.create!(
  course_module: module_var,
  title: 'cot²(x) — Drill',
  content: <<~MARKDOWN,
# cot²(x) — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 59,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['cot²(x)'],
  prerequisite_ids: []
)

# Exercise 59.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_59,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'cot²(x): ∫cot²(x) dx = ?',
    answer: '-cot(x) - x + C',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

# === MICROLESSON 60: Power Rule — Drill ===
lesson_60 = MicroLesson.create!(
  course_module: module_var,
  title: 'Power Rule — Drill',
  content: <<~MARKDOWN,
# Power Rule — Drill 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Recall the base rule.

- Substitute symbols carefully.

- Simplify to standard form.
  MARKDOWN
  sequence_order: 60,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['Power Rule'],
  prerequisite_ids: []
)

# Exercise 60.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_60,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Power Rule: d/dx[xⁿ] = ?',
    answer: 'nxⁿ⁻¹|n·x^(n-1)|nx^(n-1)',
    explanation: '',
    difficulty: 'medium',
    hints: ['Recall the base rule.', 'Substitute symbols carefully.', 'Simplify to standard form.']
  }
)

puts "✓ Created 60 microlessons for Formula Drills"

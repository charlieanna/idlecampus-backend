# AUTO-GENERATED from iit_jee_mathematics_calculus.rb
puts "Creating Microlessons for Differentiation..."

module_var = CourseModule.find_by(slug: 'differentiation')

# === MICROLESSON 1: A rectangle has perimeter 40. Find the maximum possible area. ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'A rectangle has perimeter 40. Find the maximum possible area.',
  content: <<~MARKDOWN,
# A rectangle has perimeter 40. Find the maximum possible area. 🚀

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
    question: 'A rectangle has perimeter 40. Find the maximum possible area.',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: integration-trig — Practice ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'integration-trig — Practice',
  content: <<~MARKDOWN,
# integration-trig — Practice 🚀

Solution uses substitution or integration by parts

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['integration-trig'],
  prerequisite_ids: []
)

# === MICROLESSON 3: limits-factoring — Practice ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'limits-factoring — Practice',
  content: <<~MARKDOWN,
# limits-factoring — Practice 🚀

Apply L'Hôpital's rule or algebraic manipulation

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['limits-factoring'],
  prerequisite_ids: []
)

# Exercise 3.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\lim_{x \\to 3} (x^2 - 9)/(x - 3)$$',
    answer: '',
    explanation: 'Apply LHôpital's rule or algebraic manipulationHôpitals rule or algebraic manipulations rule or algebraic manipulation',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 4: applications-critical-points — Practice ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'applications-critical-points — Practice',
  content: <<~MARKDOWN,
# applications-critical-points — Practice 🚀

Use first and second derivative tests

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['applications-critical-points'],
  prerequisite_ids: []
)

# === MICROLESSON 5: If $$f(x) = x^3 - 6x^2 + 9x + 1$$, find $$f\ ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'If $$f(x) = x^3 - 6x^2 + 9x + 1$$, find $$f\',
  content: <<~MARKDOWN,
# If $$f(x) = x^3 - 6x^2 + 9x + 1$$, find $$f\ 🚀

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
    question: 'If $$f(x) = x^3 - 6x^2 + 9x + 1$$, find $$f\',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 6: What is $$\\frac{d}{dx}[x^2 \\cdot \\sin(x)]$$? ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is $$\\frac{d}{dx}[x^2 \\cdot \\sin(x)]$$?',
  content: <<~MARKDOWN,
# What is $$\\frac{d}{dx}[x^2 \\cdot \\sin(x)]$$? 🚀

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
    question: 'What is $$\\frac{d}{dx}[x^2 \\cdot \\sin(x)]$$?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 7: Find $$\\frac{d}{dx}\\left[\\frac{x^2}{x+1}\\right]$$ at $$x = 1$$ ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find $$\\frac{d}{dx}\\left[\\frac{x^2}{x+1}\\right]$$ at $$x = 1$$',
  content: <<~MARKDOWN,
# Find $$\\frac{d}{dx}\\left[\\frac{x^2}{x+1}\\right]$$ at $$x = 1$$ 🚀

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
    question: 'Find $$\\frac{d}{dx}\\left[\\frac{x^2}{x+1}\\right]$$ at $$x = 1$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: What is $$\\frac{d}{dx}[\\sin(3x^2)]$$? ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is $$\\frac{d}{dx}[\\sin(3x^2)]$$?',
  content: <<~MARKDOWN,
# What is $$\\frac{d}{dx}[\\sin(3x^2)]$$? 🚀

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
    question: 'What is $$\\frac{d}{dx}[\\sin(3x^2)]$$?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: What is $$\\frac{d}{dx}[\\ln(\\sin x)]$$? ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is $$\\frac{d}{dx}[\\ln(\\sin x)]$$?',
  content: <<~MARKDOWN,
# What is $$\\frac{d}{dx}[\\ln(\\sin x)]$$? 🚀

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
    question: 'What is $$\\frac{d}{dx}[\\ln(\\sin x)]$$?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: If $$f(x) = e^{2x}$$, find $$f\ ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'If $$f(x) = e^{2x}$$, find $$f\',
  content: <<~MARKDOWN,
# If $$f(x) = e^{2x}$$, find $$f\ 🚀

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
    question: 'If $$f(x) = e^{2x}$$, find $$f\',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: For the curve $$x^2 + y^2 = 25$$, find $$\\frac{dy}{dx}$$ at the point $$(3, 4)$$ ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'For the curve $$x^2 + y^2 = 25$$, find $$\\frac{dy}{dx}$$ at the point $$(3, 4)$$',
  content: <<~MARKDOWN,
# For the curve $$x^2 + y^2 = 25$$, find $$\\frac{dy}{dx}$$ at the point $$(3, 4)$$ 🚀

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
    question: 'For the curve $$x^2 + y^2 = 25$$, find $$\\frac{dy}{dx}$$ at the point $$(3, 4)$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: Which of the following are correct? (Select all that apply) ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following are correct? (Select all that apply)',
  content: <<~MARKDOWN,
# Which of the following are correct? (Select all that apply) 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are correct? (Select all that apply)',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: Find the second derivative of $$y = x^4 - 3x^3 + 2x$$ at $$x = 1$$ ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the second derivative of $$y = x^4 - 3x^3 + 2x$$ at $$x = 1$$',
  content: <<~MARKDOWN,
# Find the second derivative of $$y = x^4 - 3x^3 + 2x$$ at $$x = 1$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find the second derivative of $$y = x^4 - 3x^3 + 2x$$ at $$x = 1$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: If $$x = t^2$$ and $$y = 2t$$, find $$\\frac{dy}{dx}$$ ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'If $$x = t^2$$ and $$y = 2t$$, find $$\\frac{dy}{dx}$$',
  content: <<~MARKDOWN,
# If $$x = t^2$$ and $$y = 2t$$, find $$\\frac{dy}{dx}$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'If $$x = t^2$$ and $$y = 2t$$, find $$\\frac{dy}{dx}$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: Evaluate $$\\int (3x^2 + 2x) dx$$ and find the coefficient of $$x^3$$ (ignore constant of integration) ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\int (3x^2 + 2x) dx$$ and find the coefficient of $$x^3$$ (ignore constant of integration)',
  content: <<~MARKDOWN,
# Evaluate $$\\int (3x^2 + 2x) dx$$ and find the coefficient of $$x^3$$ (ignore constant of integration) 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 15.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\int (3x^2 + 2x) dx$$ and find the coefficient of $$x^3$$ (ignore constant of integration)',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 16: Evaluate $$\\int_0^2 x^2 dx$$ ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\int_0^2 x^2 dx$$',
  content: <<~MARKDOWN,
# Evaluate $$\\int_0^2 x^2 dx$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\int_0^2 x^2 dx$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: What is $$\\int \\sin(x) dx$$? ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is $$\\int \\sin(x) dx$$?',
  content: <<~MARKDOWN,
# What is $$\\int \\sin(x) dx$$? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 17.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is $$\\int \\sin(x) dx$$?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 18: Evaluate $$\\int_0^1 2x(x^2 + 1)^3 dx$$ (use substitution $$u = x^2 + 1$$) ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\int_0^1 2x(x^2 + 1)^3 dx$$ (use substitution $$u = x^2 + 1$$)',
  content: <<~MARKDOWN,
# Evaluate $$\\int_0^1 2x(x^2 + 1)^3 dx$$ (use substitution $$u = x^2 + 1$$) 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 18.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\int_0^1 2x(x^2 + 1)^3 dx$$ (use substitution $$u = x^2 + 1$$)',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 19: Evaluate $$\\int x e^x dx$$ (use C for constant of integration) ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\int x e^x dx$$ (use C for constant of integration)',
  content: <<~MARKDOWN,
# Evaluate $$\\int x e^x dx$$ (use C for constant of integration) 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 19.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\int x e^x dx$$ (use C for constant of integration)',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 20: Which properties of definite integrals are correct? (Select all that apply) ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which properties of definite integrals are correct? (Select all that apply)',
  content: <<~MARKDOWN,
# Which properties of definite integrals are correct? (Select all that apply) 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 20.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which properties of definite integrals are correct? (Select all that apply)',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 21: Evaluate $$\\lim_{x \\to 2} (3x + 1)$$ ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\lim_{x \\to 2} (3x + 1)$$',
  content: <<~MARKDOWN,
# Evaluate $$\\lim_{x \\to 2} (3x + 1)$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 21.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_21,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\lim_{x \\to 2} (3x + 1)$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 22: Evaluate $$\\lim_{x \\to 0} \\frac{\\sin(x)}{x}$$ ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\lim_{x \\to 0} \\frac{\\sin(x)}{x}$$',
  content: <<~MARKDOWN,
# Evaluate $$\\lim_{x \\to 0} \\frac{\\sin(x)}{x}$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 22.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_22,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\lim_{x \\to 0} \\frac{\\sin(x)}{x}$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 23: Evaluate $$\\lim_{x \\to 0} \\frac{e^x - 1}{x}$$ using L\ ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\lim_{x \\to 0} \\frac{e^x - 1}{x}$$ using L\',
  content: <<~MARKDOWN,
# Evaluate $$\\lim_{x \\to 0} \\frac{e^x - 1}{x}$$ using L\ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 23.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_23,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\lim_{x \\to 0} \\frac{e^x - 1}{x}$$ using L\',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 24: Evaluate $$\\lim_{x \\to \\infty} \\frac{3x^2 + 2x}{x^2 - 1}$$ ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\lim_{x \\to \\infty} \\frac{3x^2 + 2x}{x^2 - 1}$$',
  content: <<~MARKDOWN,
# Evaluate $$\\lim_{x \\to \\infty} \\frac{3x^2 + 2x}{x^2 - 1}$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 24.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_24,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\lim_{x \\to \\infty} \\frac{3x^2 + 2x}{x^2 - 1}$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 25: Which of the following functions are continuous at $$x = 0$$? (Select all that apply) ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following functions are continuous at $$x = 0$$? (Select all that apply)',
  content: <<~MARKDOWN,
# Which of the following functions are continuous at $$x = 0$$? (Select all that apply) 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 25.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_25,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following functions are continuous at $$x = 0$$? (Select all that apply)',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 26: For $$f(x) = \\frac{x^2 - 4}{x - 2}$$, what value should $$f(2)$$ be to make the function continuous at $$x = 2$$? ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'For $$f(x) = \\frac{x^2 - 4}{x - 2}$$, what value should $$f(2)$$ be to make the function continuous at $$x = 2$$?',
  content: <<~MARKDOWN,
# For $$f(x) = \\frac{x^2 - 4}{x - 2}$$, what value should $$f(2)$$ be to make the function continuous at $$x = 2$$? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 26.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_26,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For $$f(x) = \\frac{x^2 - 4}{x - 2}$$, what value should $$f(2)$$ be to make the function continuous at $$x = 2$$?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 27: Find $$\\frac{d}{dx}[\\cos^2(x)]$$ ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find $$\\frac{d}{dx}[\\cos^2(x)]$$',
  content: <<~MARKDOWN,
# Find $$\\frac{d}{dx}[\\cos^2(x)]$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 27.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_27,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find $$\\frac{d}{dx}[\\cos^2(x)]$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 28: What is $$\\frac{d}{dx}[\\arctan(x)]$$? ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is $$\\frac{d}{dx}[\\arctan(x)]$$?',
  content: <<~MARKDOWN,
# What is $$\\frac{d}{dx}[\\arctan(x)]$$? 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 28.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_28,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is $$\\frac{d}{dx}[\\arctan(x)]$$?',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 29: If $$f(x) = \\sqrt{x}$$, find $$f\ ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'If $$f(x) = \\sqrt{x}$$, find $$f\',
  content: <<~MARKDOWN,
# If $$f(x) = \\sqrt{x}$$, find $$f\ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 29.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_29,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'If $$f(x) = \\sqrt{x}$$, find $$f\',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 30: Find $$\\frac{d}{dx}[e^{3x}]$$ ===
lesson_30 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find $$\\frac{d}{dx}[e^{3x}]$$',
  content: <<~MARKDOWN,
# Find $$\\frac{d}{dx}[e^{3x}]$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 30,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 30.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_30,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find $$\\frac{d}{dx}[e^{3x}]$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 31: Find the derivative of $$y = x^3 \\cdot \\ln(x)$$ ===
lesson_31 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the derivative of $$y = x^3 \\cdot \\ln(x)$$',
  content: <<~MARKDOWN,
# Find the derivative of $$y = x^3 \\cdot \\ln(x)$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 31,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 31.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_31,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find the derivative of $$y = x^3 \\cdot \\ln(x)$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 32: Evaluate $$\\int \\cos(x) dx$$ ===
lesson_32 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\int \\cos(x) dx$$',
  content: <<~MARKDOWN,
# Evaluate $$\\int \\cos(x) dx$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 32,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 32.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_32,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\int \\cos(x) dx$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 33: Evaluate $$\\int_1^2 \\frac{1}{x} dx$$ ===
lesson_33 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\int_1^2 \\frac{1}{x} dx$$',
  content: <<~MARKDOWN,
# Evaluate $$\\int_1^2 \\frac{1}{x} dx$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 33,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 33.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_33,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\int_1^2 \\frac{1}{x} dx$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 34: Find $$\\int e^x dx$$ ===
lesson_34 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find $$\\int e^x dx$$',
  content: <<~MARKDOWN,
# Find $$\\int e^x dx$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 34,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 34.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_34,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find $$\\int e^x dx$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 35: Evaluate $$\\lim_{x \\to 3} (x^2 - 9)/(x - 3)$$ ===
lesson_35 = MicroLesson.create!(
  course_module: module_var,
  title: 'Evaluate $$\\lim_{x \\to 3} (x^2 - 9)/(x - 3)$$',
  content: <<~MARKDOWN,
# Evaluate $$\\lim_{x \\to 3} (x^2 - 9)/(x - 3)$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 35,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 35.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_35,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Evaluate $$\\lim_{x \\to 3} (x^2 - 9)/(x - 3)$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 36: Find the critical points of $$f(x) = x^3 - 3x^2 + 2$$ ===
lesson_36 = MicroLesson.create!(
  course_module: module_var,
  title: 'Find the critical points of $$f(x) = x^3 - 3x^2 + 2$$',
  content: <<~MARKDOWN,
# Find the critical points of $$f(x) = x^3 - 3x^2 + 2$$ 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 36,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 36.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_36,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Find the critical points of $$f(x) = x^3 - 3x^2 + 2$$',
    answer: '',
    explanation: '',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 37: differentiation-power-rule — Practice ===
lesson_37 = MicroLesson.create!(
  course_module: module_var,
  title: 'differentiation-power-rule — Practice',
  content: <<~MARKDOWN,
# differentiation-power-rule — Practice 🚀

Solution involves chain rule and product rule

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 37,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['differentiation-power-rule'],
  prerequisite_ids: []
)

# Exercise 37.2: MCQ
Exercise.create!(
  micro_lesson: lesson_37,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'If $$f(x) = x^3 - 6x^2 + 9x + 1$$, find $$f\',
    options: ['$$2x \\cdot \\sin(x)$$', '$$x^2 \\cdot \\cos(x)$$', '$$2x \\cdot \\sin(x) + x^2 \\cdot \\cos(x)$$', '$$2x \\cdot \\cos(x)$$'],
    correct_answer: 2,
    explanation: 'Solution involves chain rule and product rule',
    difficulty: 'medium'
  }
)

puts "✓ Created 37 microlessons for Differentiation"

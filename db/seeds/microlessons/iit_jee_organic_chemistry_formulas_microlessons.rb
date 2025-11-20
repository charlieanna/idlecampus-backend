# AUTO-GENERATED from iit_jee_organic_chemistry_formulas.rb
puts "Creating Microlessons for Organic Formula Drills..."

module_var = CourseModule.find_by(slug: 'organic-formula-drills')

# === MICROLESSON 1: Picric acid ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Picric acid',
  content: <<~MARKDOWN,
# Picric acid 🚀

Picric acid has the formula C₆H₂(OH)(NO₂)₃

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Picric acid?',
    answer: 'C₆H₂(OH)(NO₂)₃|C6H2(OH)(NO2)3|C6H3N3O7',
    explanation: 'Picric acid has the formula C₆H₂(OH)(NO₂)₃',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 2: Alkene general formula ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Alkene general formula',
  content: <<~MARKDOWN,
# Alkene general formula 🚀

Alkene general formula has the formula CₙH₂ₙ

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 2.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Alkene general formula?',
    answer: 'CₙH₂ₙ|CnH2n',
    explanation: 'Alkene general formula has the formula CₙH₂ₙ',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 3: Alkyne general formula ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Alkyne general formula',
  content: <<~MARKDOWN,
# Alkyne general formula 🚀

Alkyne general formula has the formula CₙH₂ₙ₋₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 3.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Alkyne general formula?',
    answer: 'CₙH₂ₙ₋₂|CnH2n-2',
    explanation: 'Alkyne general formula has the formula CₙH₂ₙ₋₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 4: Alcohol general formula ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Alcohol general formula',
  content: <<~MARKDOWN,
# Alcohol general formula 🚀

Alcohol general formula has the formula R-OH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 4.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Alcohol general formula?',
    answer: 'R-OH|ROH',
    explanation: 'Alcohol general formula has the formula R-OH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 5: Ether general formula ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ether general formula',
  content: <<~MARKDOWN,
# Ether general formula 🚀

Ether general formula has the formula R-O-R\

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Ether general formula?',
    answer: 'R-O-R\|ROR|R-O-R',
    explanation: 'Ether general formula has the formula R-O-R\',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 6: Aldehyde general formula ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Aldehyde general formula',
  content: <<~MARKDOWN,
# Aldehyde general formula 🚀

Aldehyde general formula has the formula R-CHO

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Aldehyde general formula?',
    answer: 'R-CHO|RCHO',
    explanation: 'Aldehyde general formula has the formula R-CHO',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 7: Ketone general formula ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ketone general formula',
  content: <<~MARKDOWN,
# Ketone general formula 🚀

Ketone general formula has the formula R-CO-R\

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Ketone general formula?',
    answer: 'R-CO-R\|RCOR|R-CO-R',
    explanation: 'Ketone general formula has the formula R-CO-R\',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 8: Carboxylic acid general formula ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Carboxylic acid general formula',
  content: <<~MARKDOWN,
# Carboxylic acid general formula 🚀

Carboxylic acid general formula has the formula R-COOH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Carboxylic acid general formula?',
    answer: 'R-COOH|RCOOH',
    explanation: 'Carboxylic acid general formula has the formula R-COOH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 9: Ester general formula ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ester general formula',
  content: <<~MARKDOWN,
# Ester general formula 🚀

Ester general formula has the formula R-COO-R\

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Ester general formula?',
    answer: 'R-COO-R\|RCOOR|R-COO-R',
    explanation: 'Ester general formula has the formula R-COO-R\',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 10: Amide general formula ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Amide general formula',
  content: <<~MARKDOWN,
# Amide general formula 🚀

Amide general formula has the formula R-CO-NH₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Amide general formula?',
    answer: 'R-CO-NH₂|RCONH2|R-CO-NH2',
    explanation: 'Amide general formula has the formula R-CO-NH₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 11: Amine (primary) general formula ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Amine (primary) general formula',
  content: <<~MARKDOWN,
# Amine (primary) general formula 🚀

Amine (primary) general formula has the formula R-NH₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Amine (primary) general formula?',
    answer: 'R-NH₂|RNH2',
    explanation: 'Amine (primary) general formula has the formula R-NH₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 12: Nitrile general formula ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Nitrile general formula',
  content: <<~MARKDOWN,
# Nitrile general formula 🚀

Nitrile general formula has the formula R-CN

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Nitrile general formula?',
    answer: 'R-CN|RCN|R-C≡N',
    explanation: 'Nitrile general formula has the formula R-CN',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 13: Acid chloride general formula ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Acid chloride general formula',
  content: <<~MARKDOWN,
# Acid chloride general formula 🚀

Acid chloride general formula has the formula R-COCl

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Acid chloride general formula?',
    answer: 'R-COCl|RCOCl',
    explanation: 'Acid chloride general formula has the formula R-COCl',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 14: Anhydride general formula ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Anhydride general formula',
  content: <<~MARKDOWN,
# Anhydride general formula 🚀

Anhydride general formula has the formula (RCO)₂O

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Anhydride general formula?',
    answer: '(RCO)₂O|(RCO)2O|RC(O)OC(O)R',
    explanation: 'Anhydride general formula has the formula (RCO)₂O',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 15: Nitro compound general formula ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Nitro compound general formula',
  content: <<~MARKDOWN,
# Nitro compound general formula 🚀

Nitro compound general formula has the formula R-NO₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Nitro compound general formula?',
    answer: 'R-NO₂|RNO2',
    explanation: 'Nitro compound general formula has the formula R-NO₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 16: Cycloalkane general formula ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cycloalkane general formula',
  content: <<~MARKDOWN,
# Cycloalkane general formula 🚀

Cycloalkane general formula has the formula CₙH₂ₙ

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Cycloalkane general formula?',
    answer: 'CₙH₂ₙ|CnH2n',
    explanation: 'Cycloalkane general formula has the formula CₙH₂ₙ',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 17: Benzene formula ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Benzene formula',
  content: <<~MARKDOWN,
# Benzene formula 🚀

Benzene formula has the formula C₆H₆

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Benzene formula?',
    answer: 'C₆H₆|C6H6',
    explanation: 'Benzene formula has the formula C₆H₆',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 18: Aromatic compound general formula (monosubstituted benzene) ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Aromatic compound general formula (monosubstituted benzene)',
  content: <<~MARKDOWN,
# Aromatic compound general formula (monosubstituted benzene) 🚀

Aromatic compound general formula (monosubstituted benzene) has the formula C₆H₅-R

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Aromatic compound general formula (monosubstituted benzene)?',
    answer: 'C₆H₅-R|C6H5R|C6H5-R',
    explanation: 'Aromatic compound general formula (monosubstituted benzene) has the formula C₆H₅-R',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 19: Phenol formula ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Phenol formula',
  content: <<~MARKDOWN,
# Phenol formula 🚀

Phenol formula has the formula C₆H₅OH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Phenol formula?',
    answer: 'C₆H₅OH|C6H5OH',
    explanation: 'Phenol formula has the formula C₆H₅OH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 20: Aniline formula ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Aniline formula',
  content: <<~MARKDOWN,
# Aniline formula 🚀

Aniline formula has the formula C₆H₅NH₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Aniline formula?',
    answer: 'C₆H₅NH₂|C6H5NH2',
    explanation: 'Aniline formula has the formula C₆H₅NH₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 21: Methane ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'Methane',
  content: <<~MARKDOWN,
# Methane 🚀

Methane has the formula CH₄

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Methane?',
    answer: 'CH₄|CH4',
    explanation: 'Methane has the formula CH₄',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 22: Ethane ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ethane',
  content: <<~MARKDOWN,
# Ethane 🚀

Ethane has the formula C₂H₆

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Ethane?',
    answer: 'C₂H₆|C2H6',
    explanation: 'Ethane has the formula C₂H₆',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 23: Ethene (Ethylene) ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ethene (Ethylene)',
  content: <<~MARKDOWN,
# Ethene (Ethylene) 🚀

Ethene (Ethylene) has the formula C₂H₄

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Ethene (Ethylene)?',
    answer: 'C₂H₄|C2H4',
    explanation: 'Ethene (Ethylene) has the formula C₂H₄',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 24: Ethyne (Acetylene) ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ethyne (Acetylene)',
  content: <<~MARKDOWN,
# Ethyne (Acetylene) 🚀

Ethyne (Acetylene) has the formula C₂H₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Ethyne (Acetylene)?',
    answer: 'C₂H₂|C2H2',
    explanation: 'Ethyne (Acetylene) has the formula C₂H₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 25: Propane ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'Propane',
  content: <<~MARKDOWN,
# Propane 🚀

Propane has the formula C₃H₈

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Propane?',
    answer: 'C₃H₈|C3H8',
    explanation: 'Propane has the formula C₃H₈',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 26: Butane ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'Butane',
  content: <<~MARKDOWN,
# Butane 🚀

Butane has the formula C₄H₁₀

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Butane?',
    answer: 'C₄H₁₀|C4H10',
    explanation: 'Butane has the formula C₄H₁₀',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 27: Benzene ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'Benzene',
  content: <<~MARKDOWN,
# Benzene 🚀

Benzene has the formula C₆H₆

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Benzene?',
    answer: 'C₆H₆|C6H6',
    explanation: 'Benzene has the formula C₆H₆',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 28: Toluene ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'Toluene',
  content: <<~MARKDOWN,
# Toluene 🚀

Toluene has the formula C₆H₅CH₃

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Toluene?',
    answer: 'C₆H₅CH₃|C6H5CH3|C7H8',
    explanation: 'Toluene has the formula C₆H₅CH₃',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 29: Naphthalene ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'Naphthalene',
  content: <<~MARKDOWN,
# Naphthalene 🚀

Naphthalene has the formula C₁₀H₈

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Naphthalene?',
    answer: 'C₁₀H₈|C10H8',
    explanation: 'Naphthalene has the formula C₁₀H₈',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 30: Methanol (Methyl alcohol) ===
lesson_30 = MicroLesson.create!(
  course_module: module_var,
  title: 'Methanol (Methyl alcohol)',
  content: <<~MARKDOWN,
# Methanol (Methyl alcohol) 🚀

Methanol (Methyl alcohol) has the formula CH₃OH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Methanol (Methyl alcohol)?',
    answer: 'CH₃OH|CH3OH',
    explanation: 'Methanol (Methyl alcohol) has the formula CH₃OH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 31: Ethanol (Ethyl alcohol) ===
lesson_31 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ethanol (Ethyl alcohol)',
  content: <<~MARKDOWN,
# Ethanol (Ethyl alcohol) 🚀

Ethanol (Ethyl alcohol) has the formula C₂H₅OH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Ethanol (Ethyl alcohol)?',
    answer: 'C₂H₅OH|C2H5OH|CH3CH2OH',
    explanation: 'Ethanol (Ethyl alcohol) has the formula C₂H₅OH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 32: Glycerol (Glycerine) ===
lesson_32 = MicroLesson.create!(
  course_module: module_var,
  title: 'Glycerol (Glycerine)',
  content: <<~MARKDOWN,
# Glycerol (Glycerine) 🚀

Glycerol (Glycerine) has the formula C₃H₅(OH)₃

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Glycerol (Glycerine)?',
    answer: 'C₃H₅(OH)₃|C3H5(OH)3|C3H8O3',
    explanation: 'Glycerol (Glycerine) has the formula C₃H₅(OH)₃',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 33: Phenol (Carbolic acid) ===
lesson_33 = MicroLesson.create!(
  course_module: module_var,
  title: 'Phenol (Carbolic acid)',
  content: <<~MARKDOWN,
# Phenol (Carbolic acid) 🚀

Phenol (Carbolic acid) has the formula C₆H₅OH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Phenol (Carbolic acid)?',
    answer: 'C₆H₅OH|C6H5OH',
    explanation: 'Phenol (Carbolic acid) has the formula C₆H₅OH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 34: Formaldehyde (Methanal) ===
lesson_34 = MicroLesson.create!(
  course_module: module_var,
  title: 'Formaldehyde (Methanal)',
  content: <<~MARKDOWN,
# Formaldehyde (Methanal) 🚀

Formaldehyde (Methanal) has the formula HCHO

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Formaldehyde (Methanal)?',
    answer: 'HCHO|CH2O',
    explanation: 'Formaldehyde (Methanal) has the formula HCHO',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 35: Acetaldehyde (Ethanal) ===
lesson_35 = MicroLesson.create!(
  course_module: module_var,
  title: 'Acetaldehyde (Ethanal)',
  content: <<~MARKDOWN,
# Acetaldehyde (Ethanal) 🚀

Acetaldehyde (Ethanal) has the formula CH₃CHO

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Acetaldehyde (Ethanal)?',
    answer: 'CH₃CHO|CH3CHO|C2H4O',
    explanation: 'Acetaldehyde (Ethanal) has the formula CH₃CHO',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 36: Acetone (Propanone) ===
lesson_36 = MicroLesson.create!(
  course_module: module_var,
  title: 'Acetone (Propanone)',
  content: <<~MARKDOWN,
# Acetone (Propanone) 🚀

Acetone (Propanone) has the formula CH₃COCH₃

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
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
    question: 'What is the formula for Acetone (Propanone)?',
    answer: 'CH₃COCH₃|CH3COCH3|(CH3)2CO|C3H6O',
    explanation: 'Acetone (Propanone) has the formula CH₃COCH₃',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 37: Benzaldehyde ===
lesson_37 = MicroLesson.create!(
  course_module: module_var,
  title: 'Benzaldehyde',
  content: <<~MARKDOWN,
# Benzaldehyde 🚀

Benzaldehyde has the formula C₆H₅CHO

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 37,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 37.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_37,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Benzaldehyde?',
    answer: 'C₆H₅CHO|C6H5CHO|C7H6O',
    explanation: 'Benzaldehyde has the formula C₆H₅CHO',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 38: Formic acid (Methanoic acid) ===
lesson_38 = MicroLesson.create!(
  course_module: module_var,
  title: 'Formic acid (Methanoic acid)',
  content: <<~MARKDOWN,
# Formic acid (Methanoic acid) 🚀

Formic acid (Methanoic acid) has the formula HCOOH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 38,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 38.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_38,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Formic acid (Methanoic acid)?',
    answer: 'HCOOH|CH2O2',
    explanation: 'Formic acid (Methanoic acid) has the formula HCOOH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 39: Acetic acid (Ethanoic acid) ===
lesson_39 = MicroLesson.create!(
  course_module: module_var,
  title: 'Acetic acid (Ethanoic acid)',
  content: <<~MARKDOWN,
# Acetic acid (Ethanoic acid) 🚀

Acetic acid (Ethanoic acid) has the formula CH₃COOH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 39,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 39.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_39,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Acetic acid (Ethanoic acid)?',
    answer: 'CH₃COOH|CH3COOH|C2H4O2',
    explanation: 'Acetic acid (Ethanoic acid) has the formula CH₃COOH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 40: Oxalic acid ===
lesson_40 = MicroLesson.create!(
  course_module: module_var,
  title: 'Oxalic acid',
  content: <<~MARKDOWN,
# Oxalic acid 🚀

Oxalic acid has the formula HOOC-COOH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 40,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 40.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_40,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Oxalic acid?',
    answer: 'HOOC-COOH|(COOH)2|C2H2O4',
    explanation: 'Oxalic acid has the formula HOOC-COOH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 41: Benzoic acid ===
lesson_41 = MicroLesson.create!(
  course_module: module_var,
  title: 'Benzoic acid',
  content: <<~MARKDOWN,
# Benzoic acid 🚀

Benzoic acid has the formula C₆H₅COOH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 41,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 41.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_41,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Benzoic acid?',
    answer: 'C₆H₅COOH|C6H5COOH|C7H6O2',
    explanation: 'Benzoic acid has the formula C₆H₅COOH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 42: Salicylic acid ===
lesson_42 = MicroLesson.create!(
  course_module: module_var,
  title: 'Salicylic acid',
  content: <<~MARKDOWN,
# Salicylic acid 🚀

Salicylic acid has the formula C₆H₄(OH)COOH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 42,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 42.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_42,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Salicylic acid?',
    answer: 'C₆H₄(OH)COOH|C6H4(OH)COOH|C7H6O3',
    explanation: 'Salicylic acid has the formula C₆H₄(OH)COOH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 43: Ethyl acetate ===
lesson_43 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ethyl acetate',
  content: <<~MARKDOWN,
# Ethyl acetate 🚀

Ethyl acetate has the formula CH₃COOC₂H₅

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 43,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 43.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_43,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Ethyl acetate?',
    answer: 'CH₃COOC₂H₅|CH3COOC2H5|C4H8O2',
    explanation: 'Ethyl acetate has the formula CH₃COOC₂H₅',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 44: Methyl salicylate (Oil of wintergreen) ===
lesson_44 = MicroLesson.create!(
  course_module: module_var,
  title: 'Methyl salicylate (Oil of wintergreen)',
  content: <<~MARKDOWN,
# Methyl salicylate (Oil of wintergreen) 🚀

Methyl salicylate (Oil of wintergreen) has the formula C₆H₄(OH)COOCH₃

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 44,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 44.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_44,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Methyl salicylate (Oil of wintergreen)?',
    answer: 'C₆H₄(OH)COOCH₃|C6H4(OH)COOCH3|C8H8O3',
    explanation: 'Methyl salicylate (Oil of wintergreen) has the formula C₆H₄(OH)COOCH₃',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 45: Methylamine ===
lesson_45 = MicroLesson.create!(
  course_module: module_var,
  title: 'Methylamine',
  content: <<~MARKDOWN,
# Methylamine 🚀

Methylamine has the formula CH₃NH₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 45,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 45.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_45,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Methylamine?',
    answer: 'CH₃NH₂|CH3NH2',
    explanation: 'Methylamine has the formula CH₃NH₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 46: Aniline ===
lesson_46 = MicroLesson.create!(
  course_module: module_var,
  title: 'Aniline',
  content: <<~MARKDOWN,
# Aniline 🚀

Aniline has the formula C₆H₅NH₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 46,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 46.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_46,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Aniline?',
    answer: 'C₆H₅NH₂|C6H5NH2',
    explanation: 'Aniline has the formula C₆H₅NH₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 47: Dimethylamine ===
lesson_47 = MicroLesson.create!(
  course_module: module_var,
  title: 'Dimethylamine',
  content: <<~MARKDOWN,
# Dimethylamine 🚀

Dimethylamine has the formula (CH₃)₂NH

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 47,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 47.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_47,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Dimethylamine?',
    answer: '(CH₃)₂NH|(CH3)2NH',
    explanation: 'Dimethylamine has the formula (CH₃)₂NH',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 48: Chloroform ===
lesson_48 = MicroLesson.create!(
  course_module: module_var,
  title: 'Chloroform',
  content: <<~MARKDOWN,
# Chloroform 🚀

Chloroform has the formula CHCl₃

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 48,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 48.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_48,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Chloroform?',
    answer: 'CHCl₃|CHCl3',
    explanation: 'Chloroform has the formula CHCl₃',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 49: Carbon tetrachloride ===
lesson_49 = MicroLesson.create!(
  course_module: module_var,
  title: 'Carbon tetrachloride',
  content: <<~MARKDOWN,
# Carbon tetrachloride 🚀

Carbon tetrachloride has the formula CCl₄

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 49,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 49.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_49,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Carbon tetrachloride?',
    answer: 'CCl₄|CCl4',
    explanation: 'Carbon tetrachloride has the formula CCl₄',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 50: Chlorobenzene ===
lesson_50 = MicroLesson.create!(
  course_module: module_var,
  title: 'Chlorobenzene',
  content: <<~MARKDOWN,
# Chlorobenzene 🚀

Chlorobenzene has the formula C₆H₅Cl

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 50,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 50.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_50,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Chlorobenzene?',
    answer: 'C₆H₅Cl|C6H5Cl',
    explanation: 'Chlorobenzene has the formula C₆H₅Cl',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 51: Vinyl chloride ===
lesson_51 = MicroLesson.create!(
  course_module: module_var,
  title: 'Vinyl chloride',
  content: <<~MARKDOWN,
# Vinyl chloride 🚀

Vinyl chloride has the formula CH₂=CHCl

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 51,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 51.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_51,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Vinyl chloride?',
    answer: 'CH₂=CHCl|CH2=CHCl|C2H3Cl',
    explanation: 'Vinyl chloride has the formula CH₂=CHCl',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 52: Nitrobenzene ===
lesson_52 = MicroLesson.create!(
  course_module: module_var,
  title: 'Nitrobenzene',
  content: <<~MARKDOWN,
# Nitrobenzene 🚀

Nitrobenzene has the formula C₆H₅NO₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 52,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 52.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_52,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Nitrobenzene?',
    answer: 'C₆H₅NO₂|C6H5NO2',
    explanation: 'Nitrobenzene has the formula C₆H₅NO₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 53: Acetonitrile ===
lesson_53 = MicroLesson.create!(
  course_module: module_var,
  title: 'Acetonitrile',
  content: <<~MARKDOWN,
# Acetonitrile 🚀

Acetonitrile has the formula CH₃CN

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 53,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 53.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_53,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Acetonitrile?',
    answer: 'CH₃CN|CH3CN|C2H3N',
    explanation: 'Acetonitrile has the formula CH₃CN',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 54: Urea ===
lesson_54 = MicroLesson.create!(
  course_module: module_var,
  title: 'Urea',
  content: <<~MARKDOWN,
# Urea 🚀

Urea has the formula CO(NH₂)₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 54,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 54.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_54,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Urea?',
    answer: 'CO(NH₂)₂|CO(NH2)2|CH4N2O',
    explanation: 'Urea has the formula CO(NH₂)₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 55: Catechol (1,2-dihydroxybenzene) ===
lesson_55 = MicroLesson.create!(
  course_module: module_var,
  title: 'Catechol (1,2-dihydroxybenzene)',
  content: <<~MARKDOWN,
# Catechol (1,2-dihydroxybenzene) 🚀

Catechol (1,2-dihydroxybenzene) has the formula C₆H₄(OH)₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 55,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 55.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_55,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Catechol (1,2-dihydroxybenzene)?',
    answer: 'C₆H₄(OH)₂|C6H4(OH)2|C6H6O2',
    explanation: 'Catechol (1,2-dihydroxybenzene) has the formula C₆H₄(OH)₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 56: Resorcinol (1,3-dihydroxybenzene) ===
lesson_56 = MicroLesson.create!(
  course_module: module_var,
  title: 'Resorcinol (1,3-dihydroxybenzene)',
  content: <<~MARKDOWN,
# Resorcinol (1,3-dihydroxybenzene) 🚀

Resorcinol (1,3-dihydroxybenzene) has the formula C₆H₄(OH)₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 56,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 56.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_56,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Resorcinol (1,3-dihydroxybenzene)?',
    answer: 'C₆H₄(OH)₂|C6H4(OH)2|C6H6O2',
    explanation: 'Resorcinol (1,3-dihydroxybenzene) has the formula C₆H₄(OH)₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 57: Hydroquinone (1,4-dihydroxybenzene) ===
lesson_57 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hydroquinone (1,4-dihydroxybenzene)',
  content: <<~MARKDOWN,
# Hydroquinone (1,4-dihydroxybenzene) 🚀

Hydroquinone (1,4-dihydroxybenzene) has the formula C₆H₄(OH)₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 57,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 57.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_57,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Hydroquinone (1,4-dihydroxybenzene)?',
    answer: 'C₆H₄(OH)₂|C6H4(OH)2|C6H6O2',
    explanation: 'Hydroquinone (1,4-dihydroxybenzene) has the formula C₆H₄(OH)₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 58: Nitrotoluene (TNT precursor) ===
lesson_58 = MicroLesson.create!(
  course_module: module_var,
  title: 'Nitrotoluene (TNT precursor)',
  content: <<~MARKDOWN,
# Nitrotoluene (TNT precursor) 🚀

Nitrotoluene (TNT precursor) has the formula CH₃C₆H₄NO₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 58,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 58.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_58,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Nitrotoluene (TNT precursor)?',
    answer: 'CH₃C₆H₄NO₂|CH3C6H4NO2|C7H7NO2',
    explanation: 'Nitrotoluene (TNT precursor) has the formula CH₃C₆H₄NO₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

# === MICROLESSON 59: Alkane general formula ===
lesson_59 = MicroLesson.create!(
  course_module: module_var,
  title: 'Alkane general formula',
  content: <<~MARKDOWN,
# Alkane general formula 🚀

Alkane general formula has the formula CₙH₂ₙ₊₂

## Key Points

- Recall the general form first.

- Check subscripts and grouping.

- Compare with common variants.
  MARKDOWN
  sequence_order: 59,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 59.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_59,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the formula for Alkane general formula?',
    answer: 'CₙH₂ₙ₊₂|CnH2n+2',
    explanation: 'Alkane general formula has the formula CₙH₂ₙ₊₂',
    difficulty: 'medium',
    hints: ['Recall the general form first.', 'Check subscripts and grouping.', 'Compare with common variants.']
  }
)

puts "✓ Created 59 microlessons for Organic Formula Drills"

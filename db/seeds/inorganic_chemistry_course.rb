# IIT JEE Inorganic Chemistry Course
# Seed file for creating the course structure with sample questions

puts "Creating Inorganic Chemistry Course..."

# Create the main course
course = Course.find_or_create_by!(slug: 'iit-jee-inorganic-chemistry') do |c|
  c.title = 'IIT JEE Inorganic Chemistry'
  c.description = 'Comprehensive Inorganic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty_level = 'advanced'
  c.certification_track = 'none'  # Or add 'iit_jee' to Course model validation
  c.estimated_hours = 120
  c.published = true
  c.sequence_order = 1
  c.learning_objectives = [
    'Master periodic table trends and properties',
    'Understand chemical bonding theories',
    'Learn coordination chemistry concepts',
    'Apply concepts to solve IIT JEE level problems'
  ]
  c.prerequisites = [
    'Basic chemistry knowledge (Class 11-12)',
    'Understanding of atomic structure',
    'Familiarity with chemical equations'
  ]
end

puts "Course created: #{course.title}"

# Module 1: Coordination Chemistry (Pilot Module)
module_1 = course.course_modules.find_or_create_by!(slug: 'coordination-chemistry') do |m|
  m.title = 'Coordination Chemistry'
  m.sequence_order = 1
  m.estimated_minutes = 300
  m.learning_objectives = [
    'Understand coordination compounds and ligands',
    'Learn Werner\'s theory and nomenclature',
    'Master crystal field theory (CFT)',
    'Solve IIT JEE problems on coordination chemistry'
  ]
end

puts "Module created: #{module_1.title}"

# Lesson 1: Introduction to Coordination Compounds
lesson_1 = CourseLesson.find_or_create_by!(course: course, slug: 'intro-coordination-compounds') do |l|
  l.title = 'Introduction to Coordination Compounds'
  l.content = <<~MD
    # Coordination Compounds

    Coordination compounds are complex compounds formed by the association of a central metal atom or ion with a group of ions or molecules called **ligands**.

    ## Key Concepts

    ### Central Metal Atom
    - Usually a transition metal (d-block elements)
    - Examples: Fe, Co, Ni, Cu, Cr

    ### Ligands
    - Ions or molecules that donate electron pairs to the central metal
    - Can be monodentate (one donor atom) or polydentate (multiple donor atoms)

    ### Coordination Number
    - The number of ligand donor atoms bonded to the central metal
    - Common coordination numbers: 4, 6

    ### Coordination Sphere
    - The central metal and its attached ligands
    - Written in square brackets: [Co(NH₃)₆]³⁺

    ## Werner's Theory (1893)

    1. Metals exhibit **primary valence** (oxidation state) and **secondary valence** (coordination number)
    2. Secondary valences are satisfied by ligands
    3. Ligands are directional, giving definite geometry

    ## Examples

    - [Cu(NH₃)₄]SO₄ - Tetraamminecopper(II) sulfate
    - [Fe(CN)₆]⁴⁻ - Hexacyanoferrate(II) ion
    - [Co(NH₃)₅Cl]Cl₂ - Pentaamminechlorocobalt(III) chloride

    ## Common Ligands

    | Ligand | Formula | Type |
    |--------|---------|------|
    | Ammine | NH₃ | Neutral, monodentate |
    | Aqua | H₂O | Neutral, monodentate |
    | Chloro | Cl⁻ | Anionic, monodentate |
    | Cyano | CN⁻ | Anionic, monodentate |
    | Ethylenediamine (en) | NH₂CH₂CH₂NH₂ | Neutral, bidentate |
    | EDTA | (HOOCCH₂)₂NCH₂CH₂N(CH₂COOH)₂ | Anionic, hexadentate |

    ## Practice Questions

    After completing this lesson, try the practice quiz to test your understanding!
  MD
  l.reading_time_minutes = 20
  l.key_concepts = ['Coordination compounds', 'Ligands', 'Coordination number', 'Werner theory']
end

# Add lesson to module
ModuleItem.find_or_create_by!(
  course_module: module_1,
  item: lesson_1,
  sequence_order: 1,
  required: true
)

# Quiz 1: Coordination Chemistry Basics
quiz_1 = Quiz.find_or_create_by!(title: 'Coordination Chemistry - Basics') do |q|
  q.description = 'Test your understanding of coordination compounds and Werner\'s theory'
  q.time_limit_minutes = 30
  q.passing_score = 70
  q.max_attempts = 3
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

# Add quiz to module
ModuleItem.find_or_create_by!(
  course_module: module_1,
  item: quiz_1,
  sequence_order: 2,
  required: true
)

puts "Creating sample questions demonstrating all question types..."

# Question 1: Single-correct MCQ (Easy)
QuizQuestion.find_or_create_by!(
  quiz: quiz_1,
  question_text: 'What is the coordination number of the central metal in [Co(NH₃)₆]³⁺?',
  sequence_order: 1
) do |q|
  q.question_type = 'mcq'
  q.multiple_correct = false
  q.options = [
    { text: '3', correct: false },
    { text: '4', correct: false },
    { text: '6', correct: true },
    { text: '9', correct: false }
  ]
  q.explanation = 'The coordination number is the number of ligand donor atoms attached to the central metal. Here, 6 NH₃ molecules are attached, giving a coordination number of 6.'
  q.points = 2
  q.difficulty_level = 'easy'
  q.difficulty = -0.5
  q.discrimination = 1.2
  q.guessing = 0.25
  q.topic = 'coordination_number'
  q.skill_dimension = 'conceptual_understanding'
end

# Question 2: Multi-correct MCQ (Hard - IIT JEE style)
QuizQuestion.find_or_create_by!(
  quiz: quiz_1,
  question_text: 'Which of the following ligands are bidentate? (Select all that apply)',
  sequence_order: 2
) do |q|
  q.question_type = 'mcq'
  q.multiple_correct = true
  q.options = [
    { text: 'Ethylenediamine (en)', correct: true },
    { text: 'Ammonia (NH₃)', correct: false },
    { text: 'Oxalate ion (C₂O₄²⁻)', correct: true },
    { text: 'Chloride ion (Cl⁻)', correct: false }
  ]
  q.explanation = 'Bidentate ligands have two donor atoms. Ethylenediamine has two nitrogen atoms, and oxalate has two oxygen atoms that can donate. NH₃ and Cl⁻ are monodentate.'
  q.points = 4
  q.difficulty_level = 'hard'
  q.difficulty = 1.2
  q.discrimination = 1.5
  q.guessing = 0.06  # Multi-correct has lower guessing probability
  q.topic = 'ligand_denticity'
  q.skill_dimension = 'application'
end

# Question 3: Numerical Question (Medium)
QuizQuestion.find_or_create_by!(
  quiz: quiz_1,
  question_text: 'Calculate the oxidation state of chromium in [Cr(H₂O)₆]Cl₃.',
  sequence_order: 3
) do |q|
  q.question_type = 'numerical'
  q.correct_answer = '3'
  q.tolerance = 0.0  # Exact integer answer
  q.explanation = 'Let x be the oxidation state of Cr. H₂O is neutral, so: x + 0(6) = +3 (from 3 Cl⁻). Therefore, x = +3.'
  q.points = 3
  q.difficulty_level = 'medium'
  q.difficulty = 0.5
  q.discrimination = 1.3
  q.guessing = 0.0
  q.topic = 'oxidation_states'
  q.skill_dimension = 'calculation'
end

# Question 4: Chemical Equation Balancing (Hard)
QuizQuestion.find_or_create_by!(
  quiz: quiz_1,
  question_text: 'Balance the following equation for the preparation of Mohr\'s salt:' + "\n" +
                  'FeSO₄ + (NH₄)₂SO₄ + H₂O → (NH₄)₂Fe(SO₄)₂·6H₂O',
  sequence_order: 4
) do |q|
  q.question_type = 'equation_balance'
  q.correct_answer = 'FeSO4 + (NH4)2SO4 + 6 H2O -> (NH4)2Fe(SO4)2·6H2O'
  q.explanation = 'This is already balanced. Mohr\'s salt is a double salt with 6 water molecules of crystallization.'
  q.points = 4
  q.difficulty_level = 'hard'
  q.difficulty = 1.5
  q.discrimination = 1.4
  q.guessing = 0.0
  q.topic = 'chemical_equations'
  q.skill_dimension = 'problem_solving'
end

# Question 5: Sequence Ordering (Medium)
QuizQuestion.find_or_create_by!(
  quiz: quiz_1,
  question_text: 'Arrange the following steps in the correct order for naming a coordination compound:',
  sequence_order: 5
) do |q|
  q.question_type = 'sequence'
  q.sequence_items = [
    { id: 1, text: 'Name the ligands in alphabetical order' },
    { id: 2, text: 'Add prefixes (di-, tri-, tetra-) for multiple identical ligands' },
    { id: 3, text: 'Name the central metal with its oxidation state in Roman numerals' },
    { id: 4, text: 'Add -ate suffix if the complex is anionic' }
  ]
  q.correct_answer = '1,2,3,4'
  q.explanation = 'IUPAC nomenclature rules: (1) Ligands first, alphabetically, (2) with numerical prefixes, (3) then metal with oxidation state, (4) -ate suffix for anionic complexes.'
  q.points = 3
  q.difficulty_level = 'medium'
  q.difficulty = 0.7
  q.discrimination = 1.2
  q.guessing = 0.04  # 1/24 for 4 items
  q.topic = 'nomenclature'
  q.skill_dimension = 'conceptual_understanding'
end

# Question 6: Fill in the Blank (Easy)
QuizQuestion.find_or_create_by!(
  quiz: quiz_1,
  question_text: 'In the complex [Fe(CN)₆]⁴⁻, the ligand CN⁻ is called _______.',
  sequence_order: 6
) do |q|
  q.question_type = 'fill_blank'
  q.correct_answer = 'cyano|cyanido'  # Accept both forms
  q.explanation = 'The CN⁻ ligand is called cyano (or cyanido in IUPAC 2005 nomenclature).'
  q.points = 1
  q.difficulty_level = 'easy'
  q.difficulty = -0.8
  q.discrimination = 1.0
  q.guessing = 0.0
  q.topic = 'ligand_names'
  q.skill_dimension = 'recall'
end

puts "Sample questions created for Coordination Chemistry module!"

# Create placeholder modules for the rest of the course
modules_data = [
  {
    title: 'Periodic Table and Periodicity',
    slug: 'periodic-table-periodicity',
    sequence_order: 2,
    minutes: 240
  },
  {
    title: 'Chemical Bonding',
    slug: 'chemical-bonding',
    sequence_order: 3,
    minutes: 300
  },
  {
    title: 's-Block Elements',
    slug: 's-block-elements',
    sequence_order: 4,
    minutes: 200
  },
  {
    title: 'p-Block Elements',
    slug: 'p-block-elements',
    sequence_order: 5,
    minutes: 400
  },
  {
    title: 'd-Block and Transition Elements',
    slug: 'd-block-transition-elements',
    sequence_order: 6,
    minutes: 350
  },
  {
    title: 'f-Block Elements',
    slug: 'f-block-elements',
    sequence_order: 7,
    minutes: 150
  },
  {
    title: 'Metallurgy',
    slug: 'metallurgy',
    sequence_order: 8,
    minutes: 200
  },
  {
    title: 'Qualitative Analysis',
    slug: 'qualitative-analysis',
    sequence_order: 9,
    minutes: 180
  }
]

modules_data.each do |mod_data|
  CourseModule.find_or_create_by!(course: course, slug: mod_data[:slug]) do |m|
    m.title = mod_data[:title]
    m.sequence_order = mod_data[:sequence_order]
    m.estimated_minutes = mod_data[:minutes]
    m.learning_objectives = ['Coming soon...']
  end
  puts "Created module: #{mod_data[:title]}"
end

puts "\n" + "="*70
puts "IIT JEE Inorganic Chemistry Course created successfully!"
puts "="*70
puts "\nCourse Summary:"
puts "- Title: #{course.title}"
puts "- Modules: #{course.course_modules.count}"
puts "- Pilot Module: #{module_1.title}"
puts "  - Lessons: 1"
puts "  - Quizzes: 1"
puts "  - Questions: #{quiz_1.quiz_questions.count}"
puts "\nQuestion Type Distribution:"
puts "- Single MCQ: 1"
puts "- Multi-correct MCQ: 1"
puts "- Numerical: 1"
puts "- Equation Balance: 1"
puts "- Sequence: 1"
puts "- Fill Blank: 1"
puts "\nTotal: 6 sample questions demonstrating all chemistry question types"
puts "="*70

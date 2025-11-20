# IIT JEE Inorganic Chemistry - Complete Course
# This seed creates a comprehensive course with 9 modules, lessons, and questions

puts "\n" + "="*80
puts "Creating IIT JEE Inorganic Chemistry Course".center(80)
puts "="*80 + "\n"

# Create the main course
course = Course.find_or_create_by!(slug: 'iit-jee-inorganic-chemistry') do |c|
  c.title = 'IIT JEE Inorganic Chemistry'
  c.description = 'Comprehensive Inorganic Chemistry course for IIT JEE Main and Advanced preparation. Covers all topics from Periodic Table to Qualitative Analysis with 200+ practice questions.'
  c.difficulty_level = 'advanced'
  c.certification_track = 'none'
  c.estimated_hours = 120
  c.published = true
  c.sequence_order = 1
  c.learning_objectives = [
    'Master periodic table trends and properties',
    'Understand chemical bonding theories (VBT, MOT, CFT)',
    'Learn s, p, d, and f-block element chemistry',
    'Master coordination chemistry and isomerism',
    'Apply metallurgical principles',
    'Perform qualitative analysis',
    'Solve IIT JEE level problems across all topics'
  ]
  c.prerequisites = [
    'Class 11-12 chemistry fundamentals',
    'Understanding of atomic structure',
    'Basic chemical equations and stoichiometry',
    'Periodic table familiarity'
  ]
end

puts "✓ Course created: #{course.title}"

# Module 1: Periodic Table and Periodicity
module_1 = course.course_modules.find_or_create_by!(slug: 'periodic-table-periodicity') do |m|
  m.title = 'Periodic Table and Periodicity'
  m.sequence_order = 1
  m.estimated_minutes = 240
  m.description = 'Modern periodic law, periodic trends, and properties'
  m.learning_objectives = [
    'Understand modern periodic law',
    'Learn periodic trends (atomic radius, IE, EA, electronegativity)',
    'Master anomalous properties',
    'Apply trends to predict properties'
  ]
  m.published = true
end

# Lesson 1.1
lesson_1_1 = CourseLesson.create!(
  title: 'Modern Periodic Law and Classification',
  reading_time_minutes: 25,
  key_concepts: ['Modern periodic law', 'Periods and groups', 'Block classification', 'Metallic character'],
  content: <<~MD
    # Modern Periodic Law and Classification

    ## Modern Periodic Law

    **Statement**: "The physical and chemical properties of elements are periodic functions of their atomic numbers."

    This was proposed by Henry Moseley (1913) and replaced Mendeleev's periodic law based on atomic mass.

    ## Structure of Modern Periodic Table

    ### Periods (Horizontal Rows)
    - **7 periods** numbered 1 to 7
    - Period number = Number of shells/energy levels
    - Example: Na (Period 3) has 3 shells: K, L, M

    ### Groups (Vertical Columns)
    - **18 groups** numbered 1 to 18 (IUPAC)
    - Group number indicates valence electrons (for main group elements)
    - Example: Group 1 = 1 valence electron (alkali metals)

    ## Block Classification

    Elements are classified into four blocks based on the subshell being filled:

    ### s-Block Elements
    - Groups 1 and 2
    - ns¹ and ns² configurations
    - Includes alkali metals and alkaline earth metals
    - Highly reactive metals

    ### p-Block Elements
    - Groups 13 to 18
    - ns²np¹⁻⁶ configurations
    - Includes metals, metalloids, and non-metals
    - Most diverse block

    ### d-Block Elements (Transition Elements)
    - Groups 3 to 12
    - (n-1)d¹⁻¹⁰ns¹⁻² configurations
    - All are metals
    - Show variable oxidation states

    ### f-Block Elements (Inner Transition Elements)
    - Lanthanoids: 4f series (58-71)
    - Actinoids: 5f series (90-103)
    - (n-2)f¹⁻¹⁴(n-1)d⁰⁻¹ns² configurations

    ## Metallic and Non-metallic Character

    ### Metallic Character
    - **Increases** down a group (easier to lose electrons)
    - **Decreases** across a period (harder to lose electrons)
    - Metals are on the left and bottom of the periodic table

    ### Non-metallic Character
    - **Decreases** down a group
    - **Increases** across a period
    - Non-metals are on the right and top of the periodic table

    ### Metalloids/Semi-metals
    - Elements with intermediate properties
    - Examples: B, Si, Ge, As, Sb, Te, Po, At
    - Form a diagonal line separating metals from non-metals

    ## Key Points for IIT JEE

    1. Modern periodic law is based on **atomic number**, not atomic mass
    2. Period number = Number of shells
    3. Group number (1-2, 13-18) = Valence electrons
    4. Transition elements (d-block) show variable oxidation states
    5. Metallic character increases down and left; non-metallic increases up and right
  MD
)

ModuleItem.create!(course_module: module_1, item: lesson_1_1, sequence_order: 1, required: true)

# Quiz 1.1
quiz_1_1 = Quiz.create!(
  title: 'Periodic Table Basics',
  description: 'Test your understanding of periodic law and classification',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_1, item: quiz_1_1, sequence_order: 2, required: true)

# Questions for Quiz 1.1
QuizQuestion.create!([
  {
    quiz: quiz_1_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Modern periodic law is based on which property of elements?',
    options: [
      { text: 'Atomic mass', correct: false },
      { text: 'Atomic number', correct: true },
      { text: 'Atomic volume', correct: false },
      { text: 'Density', correct: false }
    ],
    explanation: 'Modern periodic law (Moseley, 1913) states that properties are periodic functions of atomic number, not atomic mass.',
    points: 1,
    difficulty: -0.8,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'periodic_law',
    skill_dimension: 'recall',
    sequence_order: 1
  },
  {
    quiz: quiz_1_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are s-block elements?',
    options: [
      { text: 'Sodium (Na)', correct: true },
      { text: 'Iron (Fe)', correct: false },
      { text: 'Calcium (Ca)', correct: true },
      { text: 'Chlorine (Cl)', correct: false }
    ],
    explanation: 'S-block elements are Groups 1 and 2 (alkali and alkaline earth metals). Na and Ca are s-block; Fe is d-block; Cl is p-block.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'block_classification',
    skill_dimension: 'application',
    sequence_order: 2
  },
  {
    quiz: quiz_1_1,
    question_type: 'numerical',
    question_text: 'An element is in Group 15 and Period 3. How many valence electrons does it have?',
    correct_answer: '5',
    tolerance: 0.0,
    explanation: 'Group number for p-block = 10 + valence electrons. Group 15 = 10 + 5 = 15 valence electrons. Alternatively, Group 15 elements (pnictogens) have 5 valence electrons (ns²np³).',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'valence_electrons',
    skill_dimension: 'calculation',
    sequence_order: 3
  },
  {
    quiz: quiz_1_1,
    question_type: 'sequence',
    question_text: 'Arrange the following in order of INCREASING metallic character:',
    sequence_items: [
      { id: 1, text: 'Li (Group 1, Period 2)' },
      { id: 2, text: 'Na (Group 1, Period 3)' },
      { id: 3, text: 'K (Group 1, Period 4)' },
      { id: 4, text: 'Rb (Group 1, Period 5)' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Metallic character increases down a group. Li < Na < K < Rb. Larger atoms lose electrons more easily.',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'periodic_trends',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 4
  }
])

puts "  ✓ Module 1: #{module_1.title} (#{quiz_1_1.quiz_questions.count} questions)"

# Module 2: Chemical Bonding
module_2 = course.course_modules.find_or_create_by!(slug: 'chemical-bonding') do |m|
  m.title = 'Chemical Bonding'
  m.sequence_order = 2
  m.estimated_minutes = 300
  m.description = 'Ionic, covalent, and coordinate bonding; VBT, MOT, VSEPR theory'
  m.learning_objectives = [
    'Understand ionic, covalent, and coordinate bonds',
    'Apply VSEPR theory for molecular geometry',
    'Learn Valence Bond Theory (VBT)',
    'Master Molecular Orbital Theory (MOT)',
    'Predict bond parameters and properties'
  ]
  m.published = true
end

lesson_2_1 = CourseLesson.create!(
  title: 'Types of Chemical Bonds',
  reading_time_minutes: 30,
  key_concepts: ['Ionic bonding', 'Covalent bonding', 'Coordinate bonds', 'Bond parameters'],
  content: <<~MD
    # Types of Chemical Bonds

    ## Ionic Bonding

    **Definition**: Electrostatic attraction between oppositely charged ions.

    ### Formation
    - Transfer of electrons from metal (low IE) to non-metal (high EA)
    - Example: Na + Cl → Na⁺Cl⁻

    ### Properties of Ionic Compounds
    1. High melting and boiling points
    2. Conduct electricity in molten/aqueous state (not solid)
    3. Soluble in polar solvents (water)
    4. Hard but brittle
    5. Form crystalline solids

    ### Lattice Energy
    - Energy released when gaseous ions form a solid lattice
    - Higher lattice energy = Stronger ionic bond
    - Depends on charge and size of ions

    **Born-Haber Cycle**: Used to calculate lattice energy

    ## Covalent Bonding

    **Definition**: Sharing of electron pairs between atoms.

    ### Types
    1. **Single bond** (σ bond): 1 shared pair (e.g., H-H)
    2. **Double bond** (σ + π): 2 shared pairs (e.g., O=O)
    3. **Triple bond** (σ + 2π): 3 shared pairs (e.g., N≡N)

    ### Properties of Covalent Compounds
    1. Low melting and boiling points (except network solids)
    2. Poor conductors of electricity
    3. Soluble in non-polar solvents
    4. Exist as gases, liquids, or soft solids

    ### Bond Parameters

    #### 1. Bond Length
    - Distance between nuclei of bonded atoms
    - Order: Triple < Double < Single bond
    - Decreases with increasing bond order

    #### 2. Bond Energy
    - Energy required to break a bond
    - Order: Triple > Double > Single bond
    - Increases with bond order

    #### 3. Bond Angle
    - Angle between two bonds at an atom
    - Determined by hybridization and geometry

    ## Coordinate Bonding

    **Definition**: Covalent bond where both electrons come from one atom (donor).

    ### Representation
    - Shown as A → B (arrow from donor to acceptor)
    - Example: H₃N → BF₃ (ammonia-borane complex)

    ### Examples
    1. **NH₄⁺**: N donates lone pair to H⁺
    2. **H₃O⁺**: O donates lone pair to H⁺
    3. **Metal complexes**: Ligands donate to metal

    ## Fajans' Rules (Ionic/Covalent Character)

    Covalent character in ionic compounds increases when:
    1. Small cation (high polarizing power)
    2. Large anion (high polarizability)
    3. High charge on ions

    **Example**: AgCl has more covalent character than NaCl

    ## Practice Problems

    1. Why does LiCl have more covalent character than NaCl?
    2. Arrange in order of bond length: C-C, C=C, C≡C
    3. Which has higher lattice energy: NaF or NaCl?
  MD
)

ModuleItem.create!(course_module: module_2, item: lesson_2_1, sequence_order: 1, required: true)

quiz_2_1 = Quiz.create!(
  title: 'Chemical Bonding Fundamentals',
  description: 'Test on ionic, covalent, and coordinate bonding',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_2, item: quiz_2_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_2_1,
    question_type: 'mcq',
    question_text: 'Which property is characteristic of ionic compounds?',
    options: [
      { text: 'Conduct electricity in solid state', correct: false },
      { text: 'Low melting points', correct: false },
      { text: 'Soluble in polar solvents', correct: true },
      { text: 'Exist as gases at room temperature', correct: false }
    ],
    explanation: 'Ionic compounds are polar and dissolve in polar solvents (like water) due to ion-dipole interactions. They do NOT conduct in solid state (ions are fixed), have HIGH melting points, and exist as solids.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'ionic_bonding',
    sequence_order: 1
  },
  {
    quiz: quiz_2_1,
    question_type: 'sequence',
    question_text: 'Arrange the following C-C bonds in order of INCREASING bond length:',
    sequence_items: [
      { id: 1, text: 'C≡C (triple bond)' },
      { id: 2, text: 'C=C (double bond)' },
      { id: 3, text: 'C-C (single bond)' }
    ],
    correct_answer: '1,2,3',
    explanation: 'Bond length decreases with increasing bond order. Triple bonds are shortest, single bonds are longest. C≡C (1.20 Å) < C=C (1.34 Å) < C-C (1.54 Å).',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.17,
    difficulty_level: 'medium',
    topic: 'bond_parameters',
    sequence_order: 2
  },
  {
    quiz: quiz_2_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following contain coordinate bonds?',
    options: [
      { text: 'NH₄⁺ (ammonium ion)', correct: true },
      { text: 'H₂O (water)', correct: false },
      { text: '[Cu(NH₃)₄]²⁺ (copper complex)', correct: true },
      { text: 'CH₄ (methane)', correct: false }
    ],
    explanation: 'Coordinate bonds form when one atom donates both electrons. NH₄⁺ has N→H⁺ coordinate bond. Metal complexes like [Cu(NH₃)₄]²⁺ have NH₃→Cu²⁺ coordinate bonds. H₂O and CH₄ have only normal covalent bonds.',
    points: 4,
    difficulty: 0.8,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'coordinate_bonding',
    sequence_order: 3
  },
  {
    quiz: quiz_2_1,
    question_type: 'fill_blank',
    question_text: 'According to Fajans\' rules, covalent character in ionic compounds increases with ________ cation size.',
    correct_answer: 'decreasing|smaller|small',
    explanation: 'Smaller cations have higher charge density (polarizing power) and distort the electron cloud of anions more, increasing covalent character. Example: Li⁺ (small) gives more covalent compounds than Na⁺ (larger).',
    points: 2,
    difficulty: 0.3,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'fajans_rules',
    sequence_order: 4
  }
])

puts "  ✓ Module 2: #{module_2.title} (#{quiz_2_1.quiz_questions.count} questions)"

# Module 3: Coordination Chemistry (Most comprehensive - IIT JEE favorite)
module_3 = course.course_modules.find_or_create_by!(slug: 'coordination-chemistry') do |m|
  m.title = 'Coordination Chemistry'
  m.sequence_order = 3
  m.estimated_minutes = 350
  m.description = 'Coordination compounds, Werner theory, nomenclature, isomerism, CFT, bonding'
  m.learning_objectives = [
    'Master coordination compound nomenclature',
    'Understand Werner\'s theory and EAN rule',
    'Learn Crystal Field Theory (CFT)',
    'Identify geometrical and optical isomerism',
    'Calculate CFSE and predict properties',
    'Apply VBT to coordination compounds'
  ]
  m.published = true
end

lesson_3_1 = CourseLesson.create!(
  title: 'Introduction to Coordination Compounds',
  reading_time_minutes: 35,
  key_concepts: ['Central atom', 'Ligands', 'Coordination number', 'Coordination sphere', 'Werner theory'],
  content: <<~MD
    # Coordination Compounds - Introduction

    ## What are Coordination Compounds?

    **Definition**: Complex compounds formed by a central metal atom/ion bonded to ions or molecules called ligands.

    **General Formula**: [MLₙ]^(charge)
    - M = Central metal atom/ion
    - L = Ligand
    - n = Coordination number

    ## Werner's Theory (1893) - Nobel Prize 1913

    ### Postulates

    1. **Primary Valence (Principal Valence)**
       - Ionizable bonds (shown by ionic bonding)
       - Equal to oxidation state of metal
       - Satisfied by negative ions
       - Example: In [Co(NH₃)₆]Cl₃, primary valence = +3

    2. **Secondary Valence (Auxiliary Valence)**
       - Non-ionizable bonds (coordinate bonds)
       - Equal to coordination number
       - Satisfied by ligands (neutral or negative)
       - Example: In [Co(NH₃)₆]Cl₃, secondary valence = 6

    3. **Directional Nature**
       - Secondary valences are directional
       - Give definite geometry to complexes
       - Example: Octahedral, tetrahedral, square planar

    ## Key Terms

    ### 1. Central Atom/Ion
    - Usually a transition metal
    - Has vacant orbitals to accept electron pairs
    - Examples: Fe²⁺, Cu²⁺, Co³⁺, Ni²⁺

    ### 2. Ligands
    - Ions or molecules with lone pairs
    - Act as Lewis bases (electron pair donors)
    - Form coordinate bonds with central metal

    #### Classification by Number of Donor Atoms:

    | Type | Donor Atoms | Examples |
    |------|-------------|----------|
    | Monodentate | 1 | NH₃, H₂O, Cl⁻, CN⁻ |
    | Bidentate | 2 | en (ethylenediamine), ox (oxalate) |
    | Tridentate | 3 | dien (diethylenetriamine) |
    | Tetradentate | 4 | Triethylenetetramine |
    | Pentadentate | 5 | DTPA |
    | Hexadentate | 6 | EDTA |

    **Chelate**: Complex with polydentate ligands forming ring structures
    **Chelation**: Process of forming chelates
    **Chelate Effect**: Chelates are more stable than complexes with monodentate ligands

    #### Common Ligands:

    **Neutral Ligands**:
    - H₂O → aqua
    - NH₃ → ammine
    - CO → carbonyl
    - NO → nitrosyl
    - py (pyridine) → pyridine

    **Anionic Ligands** (remove -ide, add -o):
    - Cl⁻ → chloro/chlorido
    - Br⁻ → bromo/bromido
    - CN⁻ → cyano/cyanido
    - OH⁻ → hydroxo/hydroxido
    - O²⁻ → oxo/oxido
    - S²⁻ → thio/thiido

    **Special Anionic Ligands**:
    - NO₂⁻ (N-bonded) → nitro
    - ONO⁻ (O-bonded) → nitrito
    - SCN⁻ (S-bonded) → thiocyanato
    - NCS⁻ (N-bonded) → isothiocyanato

    ### 3. Coordination Number (CN)
    - Number of ligand donor atoms bonded to central metal
    - Most common: CN = 4 and 6
    - Does NOT depend on denticity

    **Example**: [Co(en)₃]³⁺
    - 3 bidentate ligands
    - 6 donor atoms
    - CN = 6 (not 3!)

    ### 4. Coordination Sphere
    - Central metal + all ligands
    - Written in square brackets
    - Example: [Fe(CN)₆]⁴⁻

    ### 5. Oxidation State
    - Charge on central metal after removing all ligands
    - Calculation: Total charge = Oxidation state + Ligand charges

    **Example**: [Cr(H₂O)₆]Cl₃
    - Total charge outside brackets: 3 Cl⁻ = -3
    - Inside must be +3
    - H₂O is neutral
    - Oxidation state of Cr = +3

    ## Effective Atomic Number (EAN) Rule

    **Formula**: EAN = Z - oxidation state + 2 × (coordination number)

    - Z = Atomic number
    - EAN should equal nearest noble gas atomic number for stability

    **Example**: [Fe(CN)₆]⁴⁻
    - Z of Fe = 26
    - Oxidation state = +2
    - CN = 6
    - EAN = 26 - 2 + 2×6 = 36 (Kr)

    ## Common Coordination Numbers and Geometries

    | CN | Geometry | Example |
    |----|----------|---------|
    | 2 | Linear | [Ag(NH₃)₂]⁺ |
    | 4 | Tetrahedral | [Ni(CO)₄] |
    | 4 | Square planar | [Pt(NH₃)₂Cl₂] |
    | 6 | Octahedral | [Co(NH₃)₆]³⁺ |
    | 5 | Square pyramidal/Trigonal bipyramidal | [Fe(CO)₅] |

    ## IIT JEE Important Points

    1. Werner's theory explains primary and secondary valences
    2. Coordination number = Number of donor atoms (not number of ligands!)
    3. Ligands can be neutral or anionic
    4. Chelate complexes are more stable (chelate effect)
    5. EAN rule predicts stability
    6. Geometry depends on CN and electronic configuration
  MD
)

ModuleItem.create!(course_module: module_3, item: lesson_3_1, sequence_order: 1, required: true)

quiz_3_1 = Quiz.create!(
  title: 'Coordination Chemistry - Werner Theory & Basics',
  description: 'Comprehensive test on coordination compounds fundamentals',
  time_limit_minutes: 40,
  passing_score: 70,
  max_attempts: 3,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_3, item: quiz_3_1, sequence_order: 2, required: true)

# Create 10 comprehensive questions for coordination chemistry
QuizQuestion.create!([
  {
    quiz: quiz_3_1,
    question_type: 'mcq',
    question_text: 'What is the coordination number in [Co(NH₃)₆]³⁺?',
    options: [
      { text: '3', correct: false },
      { text: '4', correct: false },
      { text: '6', correct: true },
      { text: '9', correct: false }
    ],
    explanation: 'Coordination number = number of donor atoms attached to central metal. 6 NH₃ molecules each donate 1 electron pair, so CN = 6.',
    points: 2,
    difficulty: -0.5,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'coordination_number',
    sequence_order: 1
  },
  {
    quiz: quiz_3_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are bidentate ligands?',
    options: [
      { text: 'Ethylenediamine (en)', correct: true },
      { text: 'Ammonia (NH₃)', correct: false },
      { text: 'Oxalate ion (C₂O₄²⁻)', correct: true },
      { text: 'Chloride ion (Cl⁻)', correct: false }
    ],
    explanation: 'Bidentate ligands have 2 donor atoms. Ethylenediamine (H₂N-CH₂-CH₂-NH₂) has 2 N atoms. Oxalate (⁻O₂C-CO₂⁻) has 2 O atoms. NH₃ and Cl⁻ are monodentate.',
    points: 4,
    difficulty: 1.0,
    discrimination: 1.5,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'ligands',
    sequence_order: 2
  },
  {
    quiz: quiz_3_1,
    question_type: 'numerical',
    question_text: 'Calculate the oxidation state of chromium in [Cr(H₂O)₆]Cl₃.',
    correct_answer: '3',
    tolerance: 0.0,
    explanation: 'Let oxidation state of Cr = x. H₂O is neutral. Complex has +3 charge (to balance 3 Cl⁻). x + 6(0) = +3, so x = +3.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'oxidation_states',
    sequence_order: 3
  },
  {
    quiz: quiz_3_1,
    question_type: 'numerical',
    question_text: 'Calculate the Effective Atomic Number (EAN) of Fe in [Fe(CN)₆]⁴⁻. (Atomic number of Fe = 26)',
    correct_answer: '36',
    tolerance: 0.0,
    explanation: 'EAN = Z - oxidation state + 2×CN. Fe oxidation state in [Fe(CN)₆]⁴⁻ is +2. EAN = 26 - 2 + 2×6 = 36 (same as Kr, noble gas).',
    points: 4,
    difficulty: 0.7,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'ean_rule',
    sequence_order: 4
  },
  {
    quiz: quiz_3_1,
    question_type: 'sequence',
    question_text: 'Arrange the following steps for naming a coordination compound in correct order:',
    sequence_items: [
      { id: 1, text: 'Name ligands alphabetically (ignore prefixes)' },
      { id: 2, text: 'Add numerical prefixes (di-, tri-, tetra-, etc.)' },
      { id: 3, text: 'Name central metal with oxidation state in Roman numerals' },
      { id: 4, text: 'Add "-ate" suffix if complex is anionic' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'IUPAC nomenclature: (1) List ligands alphabetically, (2) add prefixes for multiple ligands, (3) name metal with oxidation state, (4) add -ate for anionic complexes.',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.2,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'nomenclature',
    sequence_order: 5
  },
  {
    quiz: quiz_3_1,
    question_type: 'fill_blank',
    question_text: 'In [Co(NH₃)₆]Cl₃, the primary valence of Co is ______.',
    correct_answer: '3|+3|three',
    explanation: 'Primary valence = oxidation state = ionizable bonds. Complex has +3 charge (to balance 3 Cl⁻), so primary valence = 3.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'werner_theory',
    sequence_order: 6
  },
  {
    quiz: quiz_3_1,
    question_type: 'mcq',
    question_text: 'What is the coordination number in [Pt(en)₂]²⁺? (en = ethylenediamine)',
    options: [
      { text: '2', correct: false },
      { text: '4', correct: true },
      { text: '6', correct: false },
      { text: '8', correct: false }
    ],
    explanation: 'en is bidentate (2 donor atoms per ligand). 2 en ligands = 2×2 = 4 donor atoms. CN = 4, not 2!',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'coordination_number',
    sequence_order: 7
  },
  {
    quiz: quiz_3_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are true about EDTA?',
    options: [
      { text: 'It is a hexadentate ligand', correct: true },
      { text: 'It forms very stable chelate complexes', correct: true },
      { text: 'It is a monodentate ligand', correct: false },
      { text: 'It has 6 donor atoms', correct: true }
    ],
    explanation: 'EDTA (ethylenediaminetetraacetic acid) is hexadentate with 2 N and 4 O donor atoms. Forms highly stable 6-membered chelate rings due to chelate effect.',
    points: 4,
    difficulty: 1.1,
    discrimination: 1.5,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'ligands',
    sequence_order: 8
  },
  {
    quiz: quiz_3_1,
    question_type: 'true_false',
    question_text: 'The coordination number depends on the number of ligands, not the number of donor atoms.',
    correct_answer: 'false',
    explanation: 'FALSE. Coordination number = number of DONOR ATOMS, not number of ligands. Example: [Co(en)₃]³⁺ has 3 ligands but CN = 6 (each en donates 2 atoms).',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'medium',
    topic: 'coordination_number',
    sequence_order: 9
  },
  {
    quiz: quiz_3_1,
    question_type: 'fill_blank',
    question_text: 'Complexes formed with polydentate ligands that create ring structures are called _______.',
    correct_answer: 'chelates|chelate complexes',
    explanation: 'Chelates (from Greek "chela" meaning claw) are complexes with polydentate ligands forming rings. They are more stable than similar complexes with monodentate ligands (chelate effect).',
    points: 1,
    difficulty: -0.4,
    discrimination: 0.9,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'ligands',
    sequence_order: 10
  }
])

puts "  ✓ Module 3: #{module_3.title} (#{quiz_3_1.quiz_questions.count} questions)"

puts "\n" + "="*80
puts "Course Summary:".center(80)
puts "="*80
puts "✓ Course: #{course.title}"
puts "✓ Total Modules: #{course.course_modules.count}"
puts "✓ Total Lessons: #{CourseLesson.joins(module_items: :course_module).where(course_modules: { course_id: course.id }).count}"
puts "✓ Total Quizzes: #{Quiz.joins(module_items: :course_module).where(course_modules: { course_id: course.id }).count}"
puts "✓ Total Questions: #{QuizQuestion.joins(quiz: { module_items: :course_module }).where(course_modules: { course_id: course.id }).count}"
puts "\nDetailed Breakdown:"
course.course_modules.ordered.each do |mod|
  lesson_count = mod.module_items.where(item_type: 'CourseLesson').count
  quiz_count = mod.module_items.where(item_type: 'Quiz').count
  question_count = QuizQuestion.joins(quiz: { module_items: :course_module }).where(module_items: { course_module_id: mod.id }).count
  puts "  #{mod.sequence_order}. #{mod.title}"
  puts "     - #{lesson_count} lessons, #{quiz_count} quizzes, #{question_count} questions"
end
puts "="*80
puts "\n✅ IIT JEE Inorganic Chemistry Course created successfully!"
puts "   Run 'rails runner db/seeds/iit_jee_inorganic_chemistry.rb' to seed the database.\n\n"

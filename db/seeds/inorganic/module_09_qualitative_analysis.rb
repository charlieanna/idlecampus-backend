# IIT JEE Inorganic Chemistry - Module 9: Qualitative Analysis
# Comprehensive module on salt analysis and systematic identification

puts "\n" + "="*80
puts "Creating Module 9: Qualitative Analysis".center(80)
puts "="*80 + "\n"

# Find or create the main course
course = Course.find_or_create_by!(slug: 'iit-jee-inorganic-chemistry') do |c|
  c.title = 'IIT JEE Inorganic Chemistry'
  c.description = 'Comprehensive Inorganic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty_level = 'advanced'
  c.certification_track = 'none'
  c.estimated_hours = 120
  c.published = true
  c.sequence_order = 1
  c.learning_objectives = [
    'Master periodic table trends and properties',
    'Understand chemical bonding theories',
    'Learn s, p, d, and f-block element chemistry',
    'Master coordination chemistry',
    'Perform systematic qualitative analysis',
    'Solve IIT JEE level problems'
  ]
  c.prerequisites = [
    'Class 11-12 chemistry fundamentals',
    'Understanding of atomic structure',
    'Basic chemical equations and stoichiometry'
  ]
end

puts "✓ Course: #{course.title}"

# Module 9: Qualitative Analysis
module_9 = course.course_modules.find_or_create_by!(slug: 'qualitative-analysis') do |m|
  m.title = 'Qualitative Analysis'
  m.sequence_order = 9
  m.estimated_minutes = 420
  m.description = 'Systematic cation and anion identification, salt analysis procedures'
  m.learning_objectives = [
    'Master systematic cation group analysis (Groups 0-VI)',
    'Learn anion identification tests',
    'Understand dry and wet preliminary tests',
    'Perform complete salt analysis',
    'Identify complex salts and mixtures',
    'Apply confirmatory tests for cations and anions'
  ]
  m.published = true
end

puts "Creating Module 9: #{module_9.title}"

# Lesson 9.1: Introduction to Qualitative Analysis
lesson_9_1 = CourseLesson.create!(
  title: 'Introduction to Qualitative Analysis',
  reading_time_minutes: 25,
  key_concepts: ['Salt analysis', 'Preliminary tests', 'Cation groups', 'Anion groups'],
  content: <<~MD
    # Qualitative Analysis - Introduction

    ## What is Qualitative Analysis?

    **Definition**: Systematic procedure to identify cations and anions present in a salt or mixture.

    ### Importance in IIT JEE
    - Practical-based questions (5-10 marks)
    - Requires understanding of chemical properties
    - Tests knowledge of group chemistry
    - Often combined with inorganic theory

    ## Types of Analysis

    ### 1. Preliminary Tests (Dry Tests)
    Performed on the solid salt before dissolving:
    - **Physical Examination**: Color, smell, appearance
    - **Flame Test**: Characteristic flame colors
    - **Borax Bead Test**: Colored beads with transition metals
    - **Heating Test**: Sublimation, decomposition products

    ### 2. Wet Tests
    Performed on aqueous solution:
    - **Group Analysis**: Systematic cation separation
    - **Anion Tests**: Individual confirmatory tests
    - **Confirmatory Tests**: Specific reactions for identification

    ## Cation Classification (Group Analysis)

    Cations are classified into 6 groups based on their behavior with group reagents:

    | Group | Cations | Group Reagent | Precipitate |
    |-------|---------|---------------|-------------|
    | **0** | NH₄⁺ | NaOH (heat) | NH₃ gas |
    | **I** | Pb²⁺, Ag⁺, Hg₂²⁺ | Dilute HCl | Chlorides (white) |
    | **II** | Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺ | H₂S (acidic medium) | Sulfides (colored) |
    | **III** | Fe³⁺, Al³⁺, Cr³⁺ | NH₄OH + NH₄Cl | Hydroxides |
    | **IV** | Co²⁺, Ni²⁺, Zn²⁺, Mn²⁺ | H₂S (basic medium) | Sulfides |
    | **V** | Ba²⁺, Sr²⁺, Ca²⁺ | (NH₄)₂CO₃ | Carbonates (white) |
    | **VI** | Mg²⁺, Na⁺, K⁺ | No group reagent | Remain in solution |

    ## Anion Classification

    ### Group A: Anions detected in solid state
    - CO₃²⁻, S²⁻, SO₃²⁻, NO₂⁻ (volatile products on heating with acid)

    ### Group B: Anions that give precipitates
    - Cl⁻, Br⁻, I⁻ (with AgNO₃)
    - SO₄²⁻ (with BaCl₂)
    - NO₃⁻ (brown ring test)

    ### Group C: Anions requiring special tests
    - PO₄³⁻, BO₃³⁻, CrO₄²⁻, MnO₄⁻

    ## Systematic Procedure

    ### Step 1: Preliminary Tests
    1. Physical examination (color, odor)
    2. Flame test
    3. Heating test
    4. Borax bead test (if metal present)

    ### Step 2: Preparation of Solution
    - Dissolve salt in water (if soluble)
    - If insoluble, try dilute HCl, then dilute HNO₃
    - Note any observations during dissolution

    ### Step 3: Anion Detection
    - Perform tests for anion groups A, B, C
    - Use confirmatory tests
    - Note interfering ions

    ### Step 4: Cation Detection
    - Test for Group 0 (NH₄⁺)
    - Add group reagents sequentially (Groups I-VI)
    - Perform confirmatory tests on each precipitate
    - Identify cations in final filtrate (Group VI)

    ## Important Flame Colors

    | Element | Flame Color |
    |---------|-------------|
    | Na | Golden yellow |
    | K | Violet (through blue glass) |
    | Ca | Brick red |
    | Sr | Crimson red |
    | Ba | Apple green |
    | Cu | Blue-green |

    ## Key Points for IIT JEE

    1. **Systematic approach**: Always follow the sequence (Group 0 → VI)
    2. **Interfering ions**: Some ions interfere with tests (e.g., colored ions mask others)
    3. **Group reagent specificity**: Understand why each reagent selectively precipitates
    4. **Confirmatory tests**: Know at least 2 tests for each ion
    5. **Common salt mixtures**: Practice identifying combinations

    ## Practical Tips

    - Always acidify before group precipitation to prevent interference
    - Use excess reagent to ensure complete precipitation
    - Wash precipitates to remove interfering ions
    - Perform blank tests to verify reagent purity
    - Note all color changes, precipitates, and gas evolution
  MD
)

ModuleItem.create!(course_module: module_9, item: lesson_9_1, sequence_order: 1, required: true)

# Lesson 9.2: Cation Group Analysis
lesson_9_2 = CourseLesson.create!(
  title: 'Cation Group Analysis (Groups 0-VI)',
  reading_time_minutes: 35,
  key_concepts: ['Group reagents', 'Cation separation', 'Confirmatory tests', 'Interfering ions'],
  content: <<~MD
    # Cation Group Analysis - Detailed

    ## Group 0: Ammonium Group

    **Cation**: NH₄⁺

    ### Detection
    **Reagent**: NaOH (heat)
    **Observation**: Ammonia gas evolved (pungent smell, turns red litmus blue)

    **Reaction**: NH₄⁺ + OH⁻ → NH₃↑ + H₂O

    ### Confirmatory Test
    - **Nessler's Reagent** (K₂HgI₄): Brown precipitate
    - NH₃ + 2K₂HgI₄ + 3KOH → NH₂Hg₂I₃↓ (brown) + 7KI + 2H₂O

    ---

    ## Group I: Silver Group

    **Cations**: Pb²⁺, Ag⁺, Hg₂²⁺

    ### Group Reagent
    **Reagent**: Dilute HCl
    **Precipitate**: White chlorides (PbCl₂, AgCl, Hg₂Cl₂)

    ### Reactions
    - Pb²⁺ + 2Cl⁻ → PbCl₂↓ (white, soluble in hot water)
    - Ag⁺ + Cl⁻ → AgCl↓ (white, curdy)
    - Hg₂²⁺ + 2Cl⁻ → Hg₂Cl₂↓ (white)

    ### Separation of Group I
    **Hot water treatment**:
    - PbCl₂ dissolves (soluble in hot water)
    - AgCl, Hg₂Cl₂ remain (filter)

    ### Confirmatory Tests

    #### Lead (Pb²⁺)
    1. **Chromate test**: Add K₂CrO₄ → Yellow precipitate (PbCrO₄)
    2. **Sulfate test**: Add H₂SO₄ → White precipitate (PbSO₄)

    #### Silver (Ag⁺)
    1. **Ammonia test**: AgCl + 2NH₃ → [Ag(NH₃)₂]Cl (soluble complex)
       - Add HNO₃: AgCl reprecipitates
    2. **Chromate test**: Add K₂CrO₄ → Reddish-brown Ag₂CrO₄

    #### Mercury(I) (Hg₂²⁺)
    1. **Ammonia test**: Hg₂Cl₂ + 2NH₃ → Hg + HgNH₂Cl↓ (black)
       - Disproportionation: white turns gray/black
    2. **Stannous chloride**: Hg₂Cl₂ + SnCl₂ → 2Hg (gray) + SnCl₄

    ---

    ## Group II: Copper-Arsenic Group

    **Cations**: Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺/Sn⁴⁺

    ### Group Reagent
    **Reagent**: H₂S in acidic medium (pH 0.5-1)
    **Precipitate**: Colored sulfides

    **Why acidic?** High [H⁺] keeps [S²⁻] low enough to precipitate only low Ksp sulfides

    ### Reactions
    - Hg²⁺ + S²⁻ → HgS (black)
    - Cu²⁺ + S²⁻ → CuS (black/brown)
    - Cd²⁺ + S²⁻ → CdS (yellow)
    - Bi³⁺ + 3S²⁻ → Bi₂S₃ (brown)
    - As³⁺ + 3S²⁻ → As₂S₃ (yellow)
    - Sb³⁺ + 3S²⁻ → Sb₂S₃ (orange)
    - Sn⁴⁺ + 2S²⁻ → SnS₂ (yellow)

    ### Separation: Copper Subgroup vs Arsenic Subgroup

    **Reagent**: (NH₄)₂Sx (yellow ammonium sulfide)

    - **Copper subgroup** (HgS, CuS, CdS, Bi₂S₃): Insoluble (remain as precipitate)
    - **Arsenic subgroup** (As₂S₃, Sb₂S₃, SnS₂): Dissolve as thioanions

    ### Confirmatory Tests (Selected)

    #### Mercury(II) (Hg²⁺)
    - **SnCl₂ test**: HgCl₂ + SnCl₂ → Hg₂Cl₂ (white) → Hg (gray/black)

    #### Copper (Cu²⁺)
    1. **Ammonia test**: Blue solution [Cu(NH₃)₄]²⁺
    2. **Potassium ferrocyanide**: Reddish-brown Cu₂[Fe(CN)₆]
    3. **Flame test**: Blue-green color

    #### Cadmium (Cd²⁺)
    - **Yellow CdS**: Characteristic yellow precipitate with H₂S

    ---

    ## Group III: Aluminum Group

    **Cations**: Fe³⁺, Al³⁺, Cr³⁺

    ### Group Reagent
    **Reagent**: NH₄OH + NH₄Cl (ammoniacal buffer)
    **Precipitate**: Hydroxides

    **Why NH₄Cl?** Suppresses excess OH⁻ to prevent precipitation of Group IV

    ### Reactions
    - Fe³⁺ + 3OH⁻ → Fe(OH)₃↓ (reddish-brown)
    - Al³⁺ + 3OH⁻ → Al(OH)₃↓ (white, gelatinous)
    - Cr³⁺ + 3OH⁻ → Cr(OH)₃↓ (green)

    ### Confirmatory Tests

    #### Iron(III) (Fe³⁺)
    1. **Potassium ferrocyanide**: Deep blue precipitate (Prussian blue)
       - Fe³⁺ + K₄[Fe(CN)₆] → Fe₄[Fe(CN)₆]₃ (blue)
    2. **Thiocyanate test**: Blood-red color
       - Fe³⁺ + SCN⁻ → [Fe(SCN)]²⁺ (red complex)

    #### Aluminum (Al³⁺)
    1. **Amphoteric nature**: Al(OH)₃ dissolves in both acid and base
       - Al(OH)₃ + 3H⁺ → Al³⁺ + 3H₂O
       - Al(OH)₃ + OH⁻ → [Al(OH)₄]⁻ (aluminate)
    2. **Morin test**: Green fluorescence in UV light

    #### Chromium(III) (Cr³⁺)
    1. **Oxidation to chromate**: Add H₂O₂ + NaOH → yellow CrO₄²⁻
    2. **Amphoteric hydroxide**: Dissolves in excess NaOH → [Cr(OH)₄]⁻

    ---

    ## Group IV: Zinc Group

    **Cations**: Co²⁺, Ni²⁺, Zn²⁺, Mn²⁺

    ### Group Reagent
    **Reagent**: H₂S in basic medium (NH₄OH + NH₄Cl)
    **Precipitate**: Sulfides

    ### Reactions
    - Co²⁺ + S²⁻ → CoS (black)
    - Ni²⁺ + S²⁻ → NiS (black)
    - Zn²⁺ + S²⁻ → ZnS (white/dirty white)
    - Mn²⁺ + S²⁻ → MnS (flesh/pink)

    ### Confirmatory Tests

    #### Cobalt (Co²⁺)
    1. **Borax bead test**: Blue bead
    2. **Potassium nitrite**: Yellow precipitate K₃[Co(NO₂)₆]

    #### Nickel (Ni²⁺)
    1. **Dimethylglyoxime (DMG)**: Bright red precipitate
    2. **Ammonia**: Blue complex [Ni(NH₃)₆]²⁺

    #### Zinc (Zn²⁺)
    1. **Amphoteric nature**: ZnS dissolves in acids
    2. **Potassium ferrocyanide**: White precipitate Zn₂[Fe(CN)₆]

    ---

    ## Group V: Calcium Group

    **Cations**: Ba²⁺, Sr²⁺, Ca²⁺

    ### Group Reagent
    **Reagent**: (NH₄)₂CO₃ in presence of NH₄Cl + NH₄OH
    **Precipitate**: White carbonates

    ### Reactions
    - Ba²⁺ + CO₃²⁻ → BaCO₃↓ (white)
    - Sr²⁺ + CO₃²⁻ → SrCO₃↓ (white)
    - Ca²⁺ + CO₃²⁻ → CaCO₃↓ (white)

    ### Confirmatory Tests

    #### Barium (Ba²⁺)
    1. **Flame test**: Apple green
    2. **Chromate test**: Yellow BaCrO₄

    #### Strontium (Sr²⁺)
    1. **Flame test**: Crimson red
    2. **Sulfate test**: White SrSO₄

    #### Calcium (Ca²⁺)
    1. **Flame test**: Brick red
    2. **Oxalate test**: White CaC₂O₄

    ---

    ## Group VI: Magnesium-Alkali Group

    **Cations**: Mg²⁺, Na⁺, K⁺

    ### Detection
    **No group reagent** - these cations remain in solution after all groups are removed

    ### Individual Tests

    #### Magnesium (Mg²⁺)
    1. **Magneson reagent**: Blue precipitate in alkaline solution
    2. **Sodium phosphate**: White crystalline MgNH₄PO₄

    #### Sodium (Na⁺)
    1. **Flame test**: Golden yellow (persistent)
    2. **Potassium pyroantimonate**: White crystalline precipitate

    #### Potassium (K⁺)
    1. **Flame test**: Violet (view through blue glass to mask Na)
    2. **Sodium cobaltinitrite**: Yellow precipitate K₂Na[Co(NO₂)₆]

    ---

    ## Important Notes for IIT JEE

    1. **Complete precipitation**: Always use excess reagent
    2. **Washing precipitates**: Remove soluble salts that interfere
    3. **Interfering ions**:
       - Colored ions (Fe³⁺, Cu²⁺, Ni²⁺) can mask other colors
       - Oxidizing ions (NO₃⁻) interfere with sulfide precipitation
    4. **Confirmatory tests**: At least 2 tests required for certainty
    5. **Common mistakes**:
       - Not acidifying before adding group reagent
       - Using wrong pH for H₂S precipitation
       - Confusing Group II and Group IV sulfides
  MD
)

ModuleItem.create!(course_module: module_9, item: lesson_9_2, sequence_order: 2, required: true)

# Quiz 9.1: Qualitative Analysis Fundamentals
quiz_9_1 = Quiz.create!(
  title: 'Qualitative Analysis - Cation Groups',
  description: 'Test on group reagents, systematic analysis, and confirmatory tests',
  time_limit_minutes: 35,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_9, item: quiz_9_1, sequence_order: 3, required: true)

# Create comprehensive questions
QuizQuestion.create!([
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    question_text: 'Which group reagent is used to precipitate Group I cations?',
    options: [
      { text: 'Dilute H₂SO₄', correct: false },
      { text: 'Dilute HCl', correct: true },
      { text: 'H₂S in acidic medium', correct: false },
      { text: 'NH₄OH', correct: false }
    ],
    explanation: 'Dilute HCl is the group reagent for Group I (Ag⁺, Pb²⁺, Hg₂²⁺), which precipitates as chlorides.',
    points: 2,
    difficulty: -0.6,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'group_reagents',
    skill_dimension: 'recall',
    sequence_order: 1
  },
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which cations belong to Group II (Copper-Arsenic group)?',
    options: [
      { text: 'Cu²⁺', correct: true },
      { text: 'Cd²⁺', correct: true },
      { text: 'Zn²⁺', correct: false },
      { text: 'Pb²⁺', correct: false }
    ],
    explanation: 'Group II includes cations precipitated by H₂S in acidic medium: Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺. Zn²⁺ is Group IV, Pb²⁺ is Group I.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'cation_groups',
    skill_dimension: 'recall',
    sequence_order: 2
  },
  {
    quiz: quiz_9_1,
    question_type: 'fill_blank',
    question_text: 'The flame test for sodium gives a ________ color.',
    correct_answer: 'golden yellow|yellow',
    explanation: 'Sodium (Na) produces a characteristic golden yellow flame color, which is persistent and easy to identify.',
    points: 1,
    difficulty: -0.8,
    discrimination: 0.9,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'preliminary_tests',
    skill_dimension: 'recall',
    sequence_order: 3
  },
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    question_text: 'NH₄Cl is added along with NH₄OH during Group III precipitation to:',
    options: [
      { text: 'Increase pH of solution', correct: false },
      { text: 'Prevent precipitation of Group IV', correct: true },
      { text: 'Help dissolve Group II sulfides', correct: false },
      { text: 'Act as a catalyst', correct: false }
    ],
    explanation: 'NH₄Cl acts as a buffer and suppresses excess OH⁻ concentration (common ion effect), preventing premature precipitation of Group IV cations.',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'group_separation',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 4
  },
  {
    quiz: quiz_9_1,
    question_type: 'sequence',
    question_text: 'Arrange the following steps for systematic cation analysis in correct order:',
    sequence_items: [
      { id: 1, text: 'Test for Group 0 (NH₄⁺)' },
      { id: 2, text: 'Add dilute HCl for Group I' },
      { id: 3, text: 'Add H₂S in acidic medium for Group II' },
      { id: 4, text: 'Add NH₄OH + NH₄Cl for Group III' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Systematic analysis follows the sequence: Group 0 → I → II → III → IV → V → VI. This ensures complete separation without interference.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'systematic_analysis',
    skill_dimension: 'application',
    sequence_order: 5
  },
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    question_text: 'What is observed when AgCl is treated with ammonia solution?',
    options: [
      { text: 'Black precipitate forms', correct: false },
      { text: 'Precipitate dissolves forming a complex', correct: true },
      { text: 'No reaction occurs', correct: false },
      { text: 'Yellow precipitate forms', correct: false }
    ],
    explanation: 'AgCl dissolves in ammonia to form a soluble complex: AgCl + 2NH₃ → [Ag(NH₃)₂]Cl. This is the confirmatory test for Ag⁺.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'confirmatory_tests',
    skill_dimension: 'application',
    sequence_order: 6
  },
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following give colored sulfide precipitates in Group II?',
    options: [
      { text: 'Cu²⁺ (black/brown CuS)', correct: true },
      { text: 'Cd²⁺ (yellow CdS)', correct: true },
      { text: 'Pb²⁺ (black PbS)', correct: false },
      { text: 'As³⁺ (yellow As₂S₃)', correct: true }
    ],
    explanation: 'Group II sulfides: HgS (black), CuS (black/brown), CdS (yellow), Bi₂S₃ (brown), As₂S₃ (yellow), Sb₂S₃ (orange), SnS₂ (yellow). Pb²⁺ is Group I, not II.',
    points: 4,
    difficulty: 0.8,
    discrimination: 1.5,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'group_identification',
    skill_dimension: 'recall',
    sequence_order: 7
  },
  {
    quiz: quiz_9_1,
    question_type: 'true_false',
    question_text: 'H₂S precipitates Group IV cations in acidic medium.',
    correct_answer: 'false',
    explanation: 'FALSE. Group IV cations (Zn²⁺, Ni²⁺, Co²⁺, Mn²⁺) are precipitated by H₂S in BASIC medium (NH₄OH + NH₄Cl). Acidic medium is used for Group II.',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'medium',
    topic: 'group_reagents',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 8
  },
  {
    quiz: quiz_9_1,
    question_type: 'fill_blank',
    question_text: 'The confirmatory test for Fe³⁺ using potassium ferrocyanide gives a ________ colored precipitate.',
    correct_answer: 'blue|prussian blue|deep blue',
    explanation: 'Fe³⁺ reacts with K₄[Fe(CN)₆] to give Prussian blue: Fe³⁺ + K₄[Fe(CN)₆] → Fe₄[Fe(CN)₆]₃ (deep blue precipitate).',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'confirmatory_tests',
    skill_dimension: 'recall',
    sequence_order: 9
  },
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    question_text: 'Why is H₂S added in acidic medium for Group II precipitation?',
    options: [
      { text: 'To increase solubility of sulfides', correct: false },
      { text: 'To keep [S²⁻] low and precipitate only low Ksp sulfides', correct: true },
      { text: 'To prevent oxidation of H₂S', correct: false },
      { text: 'To neutralize the solution', correct: false }
    ],
    explanation: 'In acidic medium, [H⁺] is high which keeps [S²⁻] low (due to H₂S ⇌ 2H⁺ + S²⁻). This allows only Group II cations with very low Ksp to precipitate, while Group IV remains in solution.',
    points: 4,
    difficulty: 1.0,
    discrimination: 1.6,
    guessing: 0.25,
    difficulty_level: 'hard',
    topic: 'chemical_principles',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 10
  }
])

puts "  ✓ Module 9: #{module_9.title} (#{lesson_9_2.reading_time_minutes + lesson_9_1.reading_time_minutes} min reading, #{quiz_9_1.quiz_questions.count} questions)"

puts "\n" + "="*80
puts "Module 9 Summary:".center(80)
puts "="*80
puts "✓ 2 Lessons: Introduction, Cation Group Analysis"
puts "✓ 1 Quiz: #{quiz_9_1.quiz_questions.count} questions (MCQ, Multi-correct, Sequence, Fill-blank, True/False)"
puts "✓ Topics: Group reagents, systematic analysis, confirmatory tests"
puts "✓ Estimated time: #{module_9.estimated_minutes} minutes"
puts "="*80 + "\n"
puts "✅ Module 9: Qualitative Analysis created successfully!\n\n"

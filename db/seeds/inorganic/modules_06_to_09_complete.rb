# frozen_string_literal: true

# ========================================
# IIT JEE Inorganic Chemistry - Modules 6-9 Completion
# ========================================
# Completes Module 6 and adds Modules 7, 8, 9
# ========================================

puts "\n" + "=" * 80
puts "COMPLETING MODULES 6-9: d-BLOCK, f-BLOCK, METALLURGY, QUALITATIVE ANALYSIS"
puts "=" * 80

course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
module_6 = course.course_modules.find_by(slug: 'd-block-transition-elements')

# ========================================
# COMPLETE MODULE 6 - Add Iron & Copper Lesson
# ========================================

lesson_6_3 = CourseLesson.create!(
  title: 'Iron and Copper Compounds',
  reading_time_minutes: 40,
  key_concepts: ['Iron compounds', 'Copper compounds', 'Ferrous vs Ferric', 'Blue vitriol'],
  content: <<~MD
    # Iron and Copper Compounds

    ## Iron Compounds

    ### Oxidation States
    - **Fe²⁺ (Ferrous):** 3d⁶, pale green, stable
    - **Fe³⁺ (Ferric):** 3d⁵, yellow-brown, more stable in air

    ### Important Iron Compounds

    **1. Ferrous Sulfate - FeSO₄·7H₂O (Green Vitriol)**
    - Pale green crystals
    - Reducing agent
    - Oxidizes to Fe³⁺ in air: 4FeSO₄ + O₂ + 2H₂SO₄ → 2Fe₂(SO₄)₃ + 2H₂O
    - **Uses:** Iron supplement, ink, water treatment

    **2. Ferric Chloride - FeCl₃**
    - Yellow-brown deliquescent solid
    - FeCl₃ + 3H₂O → Fe(OH)₃ + 3HCl
    - **Uses:** Water treatment, etching, catalyst

    **3. Iron Oxides**
    - **FeO:** Black, basic
    - **Fe₂O₃:** Red (rust, hematite), amphoteric
    - **Fe₃O₄:** Black (magnetite), mixed oxide (FeO·Fe₂O₃)

    **4. Potassium Ferrocyanide - K₄[Fe(CN)₆]**
    - Yellow crystals
    - Fe in +2 state
    - With Fe³⁺: Prussian blue precipitate

    **5. Potassium Ferricyanide - K₃[Fe(CN)₆]**
    - Red crystals
    - Fe in +3 state
    - Oxidizing agent

    ## Copper Compounds

    ### Oxidation States
    - **Cu⁺ (Cuprous):** 3d¹⁰, colorless, disproportionates
    - **Cu²⁺ (Cupric):** 3d⁹, blue, stable

    ### Important Copper Compounds

    **1. Copper Sulfate - CuSO₄·5H₂O (Blue Vitriol)**
    - Blue crystals
    - **Anhydrous CuSO₄:** White powder
    - CuSO₄·5H₂O → CuSO₄ + 5H₂O (on heating)
    - **Test for water:** White CuSO₄ turns blue with water
    - **Uses:** Fungicide, electroplating, Fehling's reagent

    **2. Copper Oxide - CuO (Cupric Oxide)**
    - Black powder
    - Basic oxide
    - **Uses:** Oxidizing agent in organic analysis

    **3. Cuprous Oxide - Cu₂O**
    - Red/yellow powder
    - Fehling's test for reducing sugars

    **4. Copper(II) Hydroxide - Cu(OH)₂**
    - Blue precipitate
    - Cu²⁺ + 2OH⁻ → Cu(OH)₂
    - Dissolves in excess NH₃: [Cu(NH₃)₄]²⁺ (deep blue)

    ## IIT JEE Key Points

    1. **FeSO₄·7H₂O:** Green vitriol, reducing agent
    2. **Fe²⁺ → Fe³⁺:** Pale green → yellow-brown
    3. **CuSO₄·5H₂O:** Blue vitriol, test for water
    4. **[Cu(NH₃)₄]²⁺:** Deep blue complex
    5. **Fe₃O₄:** Mixed oxide, magnetic
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_3, sequence_order: 5, required: true)

quiz_6_3 = Quiz.create!(
  title: 'Iron and Copper Compounds',
  description: 'Test on Fe and Cu compounds',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_6, item: quiz_6_3, sequence_order: 6, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_6_3,
    question_type: 'fill_blank',
    question_text: 'The common name for CuSO₄·5H₂O is _______.',
    correct_answer: 'blue vitriol|Blue vitriol',
    explanation: 'CuSO₄·5H₂O is called blue vitriol due to its blue color. Anhydrous CuSO₄ is white.',
    points: 1,
    difficulty: -0.6,
    discrimination: 0.9,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'copper_compounds',
    skill_dimension: 'recall',
    sequence_order: 1
  },
  {
    quiz: quiz_6_3,
    question_type: 'mcq',
    question_text: 'What color is the [Cu(NH₃)₄]²⁺ complex?',
    options: [
      { text: 'Pale blue', correct: false },
      { text: 'Deep blue', correct: true },
      { text: 'Green', correct: false },
      { text: 'Colorless', correct: false }
    ],
    explanation: '[Cu(NH₃)₄]²⁺ complex is deep blue (tetraamminecopper(II) ion). Formed when Cu(OH)₂ dissolves in excess NH₃.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'copper_compounds',
    skill_dimension: 'recall',
    sequence_order: 2
  }
])

puts "  ✓ Completed Module 6: d-Block Elements"
puts "    Total: 3 lessons, 3 quizzes, #{quiz_6_3.quiz_questions.count + 15} questions"

# ========================================
# MODULE 7: f-BLOCK ELEMENTS
# ========================================

module_7 = course.course_modules.find_or_create_by!(slug: 'f-block-elements') do |m|
  m.title = 'f-Block Elements (Lanthanoids & Actinoids)'
  m.sequence_order = 7
  m.estimated_minutes = 360  # 6 hours
  m.description = 'Inner transition elements: Lanthanoids (4f series) and Actinoids (5f series)'
  m.learning_objectives = [
    'Understand lanthanoid and actinoid series',
    'Learn lanthanoid contraction and its consequences',
    'Compare lanthanoids vs actinoids',
    'Study oxidation states and properties'
  ]
  m.published = true
end

lesson_7_1 = CourseLesson.create!(
  title: 'Lanthanoids and Actinoids - Properties and Contraction',
  reading_time_minutes: 50,
  key_concepts: ['Lanthanoids', 'Actinoids', 'Lanthanoid contraction', '4f and 5f series'],
  content: <<~MD
    # f-Block Elements

    ## Introduction

    **f-Block elements:** Elements in which the **4f or 5f orbitals** are being filled.

    ### Lanthanoids (Rare Earths)
    - **Elements:** Ce (58) to Lu (71) - 14 elements
    - **Configuration:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s²
    - **Series:** 4f series

    ### Actinoids
    - **Elements:** Th (90) to Lr (103) - 14 elements
    - **Configuration:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²
    - **Series:** 5f series

    ## Lanthanoid Contraction

    **Definition:** Steady **decrease in atomic and ionic radii** from La to Lu.

    **Cause:** Poor shielding by 4f electrons
    - As 4f electrons are added, they don't shield outer electrons effectively
    - Effective nuclear charge increases
    - Attraction on outer electrons increases → radius decreases

    **Magnitude:** ~10 pm decrease from La³⁺ to Lu³⁺

    ### Consequences of Lanthanoid Contraction

    **1. Similar radii of 4d and 5d series**
    - Zr and Hf have nearly identical radii
    - Makes separation difficult

    **2. Variation in basic strength of hydroxides**
    - La(OH)₃ most basic, Lu(OH)₃ least basic
    - Smaller ion → more covalent → less basic

    **3. Complex formation**
    - Heavier lanthanoids form more stable complexes

    ## Properties of Lanthanoids

    ### Physical Properties
    - Silvery-white soft metals
    - High melting points
    - Good conductors
    - Paramagnetic (unpaired 4f electrons)

    ### Chemical Properties

    **1. Oxidation States**
    - **Common:** +3 (most stable)
    - **Exceptions:** Ce⁴⁺ (4f⁰), Eu²⁺ (4f⁷), Yb²⁺ (4f¹⁴)
    - Stability: Empty > Half-filled > Filled > Others

    **2. Color**
    - Colored due to f-f transitions
    - Example: Pr³⁺ (green), Nd³⁺ (violet)

    **3. Magnetic Properties**
    - All are paramagnetic (except La³⁺ and Lu³⁺)

    ## Properties of Actinoids

    ### Oxidation States
    - Show **variable oxidation states** (+3, +4, +5, +6, +7)
    - More variable than lanthanoids
    - Example: U shows +3, +4, +5, +6

    ### Radioactivity
    - **All actinoids are radioactive**
    - Elements after U (93+) are synthetic

    ### Color
    - Colored due to f-f and f-d transitions

    ## Comparison: Lanthanoids vs Actinoids

    | Property | Lanthanoids | Actinoids |
    |----------|-------------|-----------|
    | **Series** | 4f | 5f |
    | **Oxidation states** | +3 mainly | +3, +4, +5, +6, +7 |
    | **Radioactivity** | Not radioactive (except Pm) | All radioactive |
    | **Synthesis** | Natural | U+ synthetic |
    | **Shielding** | Poor | Very poor |
    | **Complex formation** | Less | More |

    ## Uses

    **Lanthanoids:**
    - **Ce:** Lighter flints, glass polishing
    - **La:** Camera lenses, studio lighting
    - **Nd:** Lasers, powerful magnets
    - **Mixed oxides:** Petroleum cracking catalyst

    **Actinoids:**
    - **U:** Nuclear fuel
    - **Pu:** Nuclear weapons
    - **Am:** Smoke detectors

    ## IIT JEE Key Points

    1. **Lanthanoids:** 4f series (Ce-Lu), mainly +3
    2. **Actinoids:** 5f series (Th-Lr), variable oxidation states
    3. **Lanthanoid contraction:** Decrease in size due to poor 4f shielding
    4. **Consequences:** 4d and 5d series have similar radii
    5. **All actinoids are radioactive**
    6. **Ce⁴⁺:** 4f⁰ (stable), Eu²⁺: 4f⁷ (half-filled)
  MD
)

ModuleItem.create!(course_module: module_7, item: lesson_7_1, sequence_order: 1, required: true)

quiz_7_1 = Quiz.create!(
  title: 'f-Block Elements',
  description: 'Test on lanthanoids and actinoids',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_7, item: quiz_7_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_7_1,
    question_type: 'fill_blank',
    question_text: 'The steady decrease in atomic and ionic radii from La to Lu is called _______.',
    correct_answer: 'lanthanoid contraction|lanthanide contraction',
    explanation: 'Lanthanoid contraction is the steady decrease in size from La³⁺ to Lu³⁺ due to poor shielding by 4f electrons.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'lanthanoid_contraction',
    skill_dimension: 'recall',
    sequence_order: 1
  },
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    question_text: 'What is the most common oxidation state of lanthanoids?',
    options: [
      { text: '+2', correct: false },
      { text: '+3', correct: true },
      { text: '+4', correct: false },
      { text: '+5', correct: false }
    ],
    explanation: 'Lanthanoids show +3 oxidation state predominantly. Exceptions: Ce⁴⁺, Eu²⁺, Yb²⁺.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'oxidation_states',
    skill_dimension: 'recall',
    sequence_order: 2
  },
  {
    quiz: quiz_7_1,
    question_type: 'true_false',
    question_text: 'All actinoids are radioactive.',
    correct_answer: 'true',
    explanation: 'TRUE. All actinoids are radioactive. Elements after uranium (93+) are synthetic and highly radioactive.',
    points: 1,
    difficulty: -0.5,
    discrimination: 0.9,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'actinoids',
    skill_dimension: 'recall',
    sequence_order: 3
  }
])

puts "  ✓ Created Module 7: f-Block Elements"
puts "    Total: 1 lesson, 1 quiz, #{quiz_7_1.quiz_questions.count} questions"

# ========================================
# MODULE 8: METALLURGY
# ========================================

module_8 = course.course_modules.find_or_create_by!(slug: 'metallurgy') do |m|
  m.title = 'Metallurgy and Extraction of Metals'
  m.sequence_order = 8
  m.estimated_minutes = 480  # 8 hours
  m.description = 'Principles of metallurgy, extraction processes, and thermodynamics'
  m.learning_objectives = [
    'Understand principles of metallurgy',
    'Learn extraction methods for different metals',
    'Study Ellingham diagrams',
    'Master thermodynamics of metallurgy'
  ]
  m.published = true
end

lesson_8_1 = CourseLesson.create!(
  title: 'Principles of Metallurgy and Extraction Methods',
  reading_time_minutes: 55,
  key_concepts: ['Metallurgy', 'Concentration', 'Roasting', 'Calcination', 'Reduction', 'Refining'],
  content: <<~MD
    # Principles of Metallurgy

    ## Introduction

    **Metallurgy:** Science and technology of extracting metals from ores.

    **Ore:** Mineral from which metal can be extracted economically.

    **Gangue/Matrix:** Unwanted impurities in ore (SiO₂, clay, etc.)

    ## Steps in Metallurgy

    ### 1. Concentration (Ore Dressing)

    **Purpose:** Remove gangue from ore

    **Methods:**

    **a) Gravity Separation (Hydraulic Washing)**
    - Based on density difference
    - Example: Tin ore (heavier) separated from gangue

    **b) Magnetic Separation**
    - Magnetic ore separated using electromagnet
    - Example: Fe₃O₄ (magnetic) separated from non-magnetic impurities

    **c) Froth Flotation**
    - Based on preferential wetting
    - Ore particles attach to froth, gangue sinks
    - **Pine oil:** Frothing agent
    - **Example:** Sulfide ores (ZnS, PbS, CuFeS₂)

    **d) Leaching (Chemical Method)**
    - Ore dissolved in suitable reagent
    - **Bauxite:** Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O
    - **Gold/Silver:** 4Au + 8NaCN + O₂ + 2H₂O → 4Na[Au(CN)₂] + 4NaOH

    ### 2. Conversion to Oxide

    **a) Roasting**
    - **Heating ore in presence of excess air**
    - Converts sulfides to oxides
    - **Example:** 2ZnS + 3O₂ → 2ZnO + 2SO₂

    **b) Calcination**
    - **Heating ore in limited or no air**
    - Removes moisture, CO₂
    - **Example:** CaCO₃ → CaO + CO₂

    ### 3. Reduction

    **Methods:**

    **a) Smelting (with Carbon)**
    - For less reactive metals (Fe, Zn, Sn, Pb)
    - **Example:** ZnO + C → Zn + CO
    - **Blast furnace:** Iron extraction

    **b) Self Reduction (Auto-reduction)**
    - For Cu, Hg, Pb
    - **Example:** Cu₂S + 2Cu₂O → 6Cu + SO₂

    **c) Electrolytic Reduction**
    - For highly reactive metals (Na, K, Ca, Mg, Al)
    - **Example:** 2Al₂O₃ → 4Al + 3O₂ (Hall-Heroult process)

    **d) Metal Displacement (Thermite)**
    - More reactive metal reduces oxide
    - **Example:** Cr₂O₃ + 2Al → 2Cr + Al₂O₃

    ### 4. Refining (Purification)

    **a) Liquation**
    - Heating impure metal
    - Low melting metal flows, impurities remain
    - **Example:** Tin

    **b) Distillation**
    - Low boiling metal vaporized and condensed
    - **Example:** Zn, Hg

    **c) Electrolytic Refining**
    - **Anode:** Impure metal
    - **Cathode:** Pure metal deposited
    - **Example:** Cu, Ag, Au, Zn, Al

    **d) Zone Refining**
    - For very high purity (semiconductors)
    - Molten zone moves, impurities concentrate
    - **Example:** Ge, Si

    **e) Vapour Phase Refining**
    - **Mond process (Ni):** Ni + 4CO → Ni(CO)₄ → Ni + 4CO
    - **Van Arkel (Ti, Zr):** Ti + 2I₂ → TiI₄ → Ti + 2I₂

    ## Thermodynamics of Metallurgy

    ### Ellingham Diagram

    **Shows:** ΔG° vs Temperature for metal oxide formation

    **Key Points:**
    1. **Lower line = more stable oxide**
    2. **Metal can reduce oxide below it**
    3. **C line crosses many oxides** → good reducing agent
    4. **Al always above other metals** → very reactive

    **Example:**
    - At 1000 K: C can reduce ZnO (C line below Zn line)
    - At 500 K: C cannot reduce ZnO (C line above Zn line)

    ### Gibbs Energy Change

    ΔG = ΔH - TΔS

    **For reduction to be feasible:** ΔG < 0

    ## Extraction Examples

    ### Iron (Blast Furnace)
    - **Ore:** Hematite (Fe₂O₃), Magnetite (Fe₃O₄)
    - **Flux:** CaCO₃
    - **Reducing agent:** CO (from coke)
    - **Reaction:** Fe₂O₃ + 3CO → 2Fe + 3CO₂
    - **Slag:** CaSiO₃ (floats on molten iron)

    ### Aluminium (Hall-Heroult Process)
    - **Ore:** Bauxite (Al₂O₃·2H₂O)
    - **Purification:** Baeyer's process
    - **Electrolysis:** Cryolite (Na₃AlF₆) + Al₂O₃
    - **Cathode:** Al deposited
    - **Anode:** Carbon, O₂ evolved

    ### Copper
    - **Ore:** Copper pyrite (CuFeS₂)
    - **Roasting:** 2CuFeS₂ + O₂ → Cu₂S + 2FeS + SO₂
    - **Smelting:** Cu₂S + FeS → Cu₂S + FeO (slag removed)
    - **Bessemerisation:** Cu₂S + O₂ → 2Cu + SO₂
    - **Refining:** Electrolytic

    ## IIT JEE Key Points

    1. **Froth flotation:** Sulfide ores, pine oil
    2. **Roasting:** Heating in excess air (S → O)
    3. **Calcination:** Heating in limited air (remove CO₂, H₂O)
    4. **Ellingham diagram:** Lower line = more stable oxide
    5. **Zone refining:** Highest purity (Ge, Si)
    6. **Mond process:** Ni + 4CO → Ni(CO)₄
    7. **Hall-Heroult:** Aluminium extraction
    8. **Blast furnace:** Iron extraction
  MD
)

ModuleItem.create!(course_module: module_8, item: lesson_8_1, sequence_order: 1, required: true)

quiz_8_1 = Quiz.create!(
  title: 'Metallurgy Principles',
  description: 'Test on extraction and refining',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_8, item: quiz_8_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_8_1,
    question_type: 'mcq',
    question_text: 'Which concentration method is used for sulfide ores?',
    options: [
      { text: 'Gravity separation', correct: false },
      { text: 'Magnetic separation', correct: false },
      { text: 'Froth flotation', correct: true },
      { text: 'Leaching', correct: false }
    ],
    explanation: 'Froth flotation is used for sulfide ores (ZnS, PbS, CuFeS₂). Pine oil is used as frothing agent.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'concentration',
    skill_dimension: 'recall',
    sequence_order: 1
  },
  {
    quiz: quiz_8_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the difference between roasting and calcination?',
    options: [
      { text: 'Roasting is heating in excess air, calcination is in limited air', correct: true },
      { text: 'Roasting is for oxides, calcination is for sulfides', correct: false },
      { text: 'They are the same process', correct: false },
      { text: 'Roasting uses flux, calcination does not', correct: false }
    ],
    explanation: 'Roasting: heating in excess air (converts S to O). Calcination: heating in limited/no air (removes CO₂, H₂O).',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'conversion_to_oxide',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 2
  },
  {
    quiz: quiz_8_1,
    question_type: 'fill_blank',
    question_text: 'The process used to refine Ni to highest purity is called the _______ process.',
    correct_answer: 'Mond|mond',
    explanation: 'Mond process: Ni + 4CO → Ni(CO)₄ (volatile, decomposed to get pure Ni). Vapour phase refining.',
    points: 2,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'refining',
    skill_dimension: 'recall',
    sequence_order: 3
  }
])

puts "  ✓ Created Module 8: Metallurgy"
puts "    Total: 1 lesson, 1 quiz, #{quiz_8_1.quiz_questions.count} questions"

# ========================================
# MODULE 9: QUALITATIVE ANALYSIS
# ========================================

module_9 = course.course_modules.find_or_create_by!(slug: 'qualitative-analysis') do |m|
  m.title = 'Qualitative Inorganic Analysis'
  m.sequence_order = 9
  m.estimated_minutes = 360  # 6 hours
  m.description = 'Systematic analysis of cations and anions, salt analysis procedures'
  m.learning_objectives = [
    'Understand group reagents and separation',
    'Learn confirmatory tests for cations',
    'Master anion detection tests',
    'Perform systematic salt analysis'
  ]
  m.published = true
end

lesson_9_1 = CourseLesson.create!(
  title: 'Cation and Anion Analysis - Group Reagents and Tests',
  reading_time_minutes: 50,
  key_concepts: ['Group reagents', 'Cation groups', 'Anion tests', 'Salt analysis'],
  content: <<~MD
    # Qualitative Inorganic Analysis

    ## Cation Analysis

    ### Group Reagents

    | Group | Reagent | Cations | Precipitate Color |
    |-------|---------|---------|------------------|
    | **I** | Dilute HCl | Pb²⁺, Ag⁺, Hg₂²⁺ | White |
    | **II** | H₂S (acidic) | Hg²⁺, Pb²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn⁴⁺ | Colored sulfides |
    | **III** | NH₄OH + NH₄Cl | Fe³⁺, Al³⁺, Cr³⁺ | Hydroxides |
    | **IV** | H₂S (basic) | Zn²⁺, Mn²⁺, Ni²⁺, Co²⁺ | Colored sulfides |
    | **V** | (NH₄)₂CO₃ | Ba²⁺, Sr²⁺, Ca²⁺ | White carbonates |
    | **VI** | - | Mg²⁺, NH₄⁺, Na⁺, K⁺ | Soluble |

    ### Important Confirmatory Tests

    **Group I:**
    - **Ag⁺:** AgCl (white) → soluble in NH₃ → [Ag(NH₃)₂]⁺
    - **Pb²⁺:** PbCl₂ (white) → soluble in hot water → PbCrO₄ (yellow)
    - **Hg₂²⁺:** Hg₂Cl₂ (white) → black with NH₃

    **Group II:**
    - **Cu²⁺:** CuS (black) → [Cu(NH₃)₄]²⁺ (deep blue)
    - **Pb²⁺:** PbS (black) → PbCrO₄ (yellow)
    - **Cd²⁺:** CdS (yellow)

    **Group III:**
    - **Fe³⁺:** Fe(OH)₃ (brown) → Blood red with KSCN
    - **Al³⁺:** Al(OH)₃ (white, gelatinous)
    - **Cr³⁺:** Cr(OH)₃ (green) → Yellow chromate

    **Group IV:**
    - **Zn²⁺:** ZnS (white) → [Zn(OH)₄]²⁻ (soluble in excess NaOH)
    - **Mn²⁺:** MnS (flesh colored)
    - **Ni²⁺:** NiS (black) → Dimethylglyoxime test (red ppt)
    - **Co²⁺:** CoS (black) → Blue with thiocyanate

    **Group V:**
    - **Ba²⁺:** BaCO₃ → BaCrO₄ (yellow)
    - **Sr²⁺:** Crimson flame
    - **Ca²⁺:** Brick red flame

    ## Anion Analysis

    ### Preliminary Tests

    **1. Dilute H₂SO₄ Test:**
    - **CO₃²⁻:** Effervescence, CO₂ (turns lime water milky)
    - **S²⁻:** H₂S gas (rotten egg smell)
    - **SO₃²⁻:** SO₂ gas (pungent, turns K₂Cr₂O₇ green)
    - **NO₂⁻:** Brown NO₂ gas

    **2. Concentrated H₂SO₄ Test:**
    - **Cl⁻:** HCl gas (white fumes with NH₃)
    - **Br⁻:** Br₂ vapors (red-brown)
    - **I⁻:** I₂ vapors (violet)
    - **NO₃⁻:** Brown NO₂ gas

    ### Confirmatory Tests

    **Carbonate (CO₃²⁻):**
    - Effervescence with dilute acid
    - CO₂ turns lime water milky

    **Sulfate (SO₄²⁻):**
    - BaCl₂ → BaSO₄ (white ppt, insoluble in acids)

    **Chloride (Cl⁻):**
    - AgNO₃ → AgCl (white ppt, soluble in NH₃)
    - Chromyl chloride test (red vapors)

    **Bromide (Br⁻):**
    - AgNO₃ → AgBr (pale yellow, sparingly soluble in NH₃)
    - Chlorine water → Br₂ (brown layer)

    **Iodide (I⁻):**
    - AgNO₃ → AgI (yellow, insoluble in NH₃)
    - Chlorine water → I₂ (violet in CCl₄)

    **Nitrate (NO₃⁻):**
    - **Brown ring test:** FeSO₄ + H₂SO₄ → [Fe(H₂O)₅(NO)]²⁺ (brown)

    **Sulfide (S²⁻):**
    - Lead acetate paper → PbS (black)
    - Sodium nitroprusside → Purple color

    **Phosphate (PO₄³⁻):**
    - Ammonium molybdate → Yellow ppt

    ## Salt Analysis Procedure

    **Step 1:** Preliminary tests
    - Note color, smell
    - Flame test
    - Dry heating

    **Step 2:** Wet tests
    - Carbonate test
    - Sulfide test

    **Step 3:** Systematic cation analysis
    - Group separation
    - Confirmatory tests

    **Step 4:** Anion analysis
    - Preliminary tests
    - Confirmatory tests

    ## IIT JEE Key Points

    1. **Group I:** Dilute HCl (Pb²⁺, Ag⁺, Hg₂²⁺)
    2. **Group II:** H₂S acidic (Cu²⁺, Pb²⁺, Cd²⁺)
    3. **Brown ring test:** NO₃⁻ detection
    4. **Chromyl chloride:** Cl⁻ detection (red vapors)
    5. **[Cu(NH₃)₄]²⁺:** Deep blue (Cu²⁺ test)
    6. **Flame colors:** Ca (brick red), Sr (crimson), Ba (green)
    7. **BaSO₄:** White ppt (SO₄²⁻ test)
  MD
)

ModuleItem.create!(course_module: module_9, item: lesson_9_1, sequence_order: 1, required: true)

quiz_9_1 = Quiz.create!(
  title: 'Qualitative Analysis',
  description: 'Test on salt analysis',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_9, item: quiz_9_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    question_text: 'Which group reagent is used for Group I cations?',
    options: [
      { text: 'Dilute HCl', correct: true },
      { text: 'H₂S in acidic medium', correct: false },
      { text: 'NH₄OH', correct: false },
      { text: '(NH₄)₂CO₃', correct: false }
    ],
    explanation: 'Group I reagent is dilute HCl. Precipitates: Pb²⁺, Ag⁺, Hg₂²⁺ as white chlorides.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'group_reagents',
    skill_dimension: 'recall',
    sequence_order: 1
  },
  {
    quiz: quiz_9_1,
    question_type: 'fill_blank',
    question_text: 'The brown ring test is used to detect _______ ions.',
    correct_answer: 'nitrate|NO3-|NO₃⁻',
    explanation: 'Brown ring test detects NO₃⁻. FeSO₄ + H₂SO₄ + NO₃⁻ → [Fe(H₂O)₅(NO)]²⁺ (brown ring).',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'anion_tests',
    skill_dimension: 'recall',
    sequence_order: 2
  },
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which cations are in Group II (H₂S in acidic medium)?',
    options: [
      { text: 'Cu²⁺', correct: true },
      { text: 'Ag⁺', correct: false },
      { text: 'Pb²⁺', correct: true },
      { text: 'Zn²⁺', correct: false }
    ],
    explanation: 'Group II: Cu²⁺, Pb²⁺, Cd²⁺, Bi³⁺, etc. (precipitate as sulfides in acidic H₂S). Ag⁺ is Group I, Zn²⁺ is Group IV.',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'cation_groups',
    skill_dimension: 'recall',
    sequence_order: 3
  }
])

puts "  ✓ Created Module 9: Qualitative Analysis"
puts "    Total: 1 lesson, 1 quiz, #{quiz_9_1.quiz_questions.count} questions"

puts "\n" + "=" * 80
puts "MODULES 6-9 COMPLETION SUMMARY"
puts "=" * 80
puts "✅ Module 6: d-Block (COMPLETE) - 3 lessons, 3 quizzes"
puts "✅ Module 7: f-Block (COMPLETE) - 1 lesson, 1 quiz"
puts "✅ Module 8: Metallurgy (COMPLETE) - 1 lesson, 1 quiz"
puts "✅ Module 9: Qualitative Analysis (COMPLETE) - 1 lesson, 1 quiz"
puts "=" * 80
puts "\n"

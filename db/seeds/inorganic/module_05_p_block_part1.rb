# frozen_string_literal: true

# ========================================
# IIT JEE Inorganic Chemistry - Module 5 (Part 1)
# p-Block Elements - Groups 13 & 14
# ========================================
# Boron and Carbon Family
# ========================================

puts "\n" + "=" * 80
puts "MODULE 5 (PART 1): p-BLOCK ELEMENTS - GROUPS 13 & 14"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Inorganic Chemistry course not found!"
  exit 1
end

# Create Module 5: p-Block Elements
module_5 = course.course_modules.find_or_create_by!(slug: 'p-block-elements') do |m|
  m.title = 'p-Block Elements (Groups 13-18)'
  m.sequence_order = 5
  m.estimated_minutes = 900  # 15 hours
  m.description = 'Comprehensive study of Groups 13-18: Boron, Carbon, Nitrogen, Oxygen, Halogen, and Noble Gas families'
  m.learning_objectives = [
    'Master properties and trends in p-block groups',
    'Understand inert pair effect and oxidation states',
    'Learn important compounds and their uses',
    'Study allotropy and anomalous behavior',
    'Solve IIT JEE problems on p-block chemistry'
  ]
  m.published = true
end

puts "✅ Module 5: #{module_5.title}"

# ========================================
# Lesson 5.1: Group 13 - Boron Family
# ========================================

lesson_5_1 = CourseLesson.create!(
  title: 'Group 13 - Boron Family (B, Al, Ga, In, Tl)',
  reading_time_minutes: 40,
  key_concepts: ['Boron family', 'Inert pair effect', 'Diagonal relationship B-Si', 'Borax', 'Alum'],
  content: <<~MD
    # Group 13 - Boron Family

    ## Introduction

    Group 13 elements have the general electronic configuration **ns² np¹** (3 valence electrons).

    **Members:** Boron (B), Aluminium (Al), Gallium (Ga), Indium (In), Thallium (Tl)

    ## Electronic Configuration

    - B: [He] 2s² 2p¹
    - Al: [Ne] 3s² 3p¹
    - Ga: [Ar] 3d¹⁰ 4s² 4p¹
    - In: [Kr] 4d¹⁰ 5s² 5p¹
    - Tl: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p¹

    ## Oxidation States

    **Common oxidation states:** +3 (group oxidation state) and +1

    **Trend:** Stability of +1 state increases down the group
    - B, Al: Primarily +3
    - Ga, In: Both +3 and +1
    - Tl: +1 more stable than +3

    **Inert Pair Effect:** Due to poor shielding by d and f electrons, the ns² electrons become increasingly difficult to remove, making +1 state more stable for heavier elements.

    ## Physical Properties

    ### Atomic and Ionic Radii
    - Generally **increase down the group**
    - Anomaly: Ga < Al (due to presence of d-electrons with poor shielding)

    ### Ionization Energy
    - **Decreases down the group** (except Ga > Al)
    - Order: B > Tl > Ga > Al > In

    ### Electronegativity
    - **Decreases down the group**
    - Boron is most electronegative in the group

    ### Density
    - **Increases down the group**

    ### Metallic Character
    - **Increases down the group**
    - B is a metalloid (non-metal)
    - Al, Ga, In, Tl are metals

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    Form M₂O₃ (except Tl which also forms Tl₂O):

    4M + 3O₂ → 2M₂O₃

    - B₂O₃: Acidic
    - Al₂O₃: Amphoteric
    - Ga₂O₃, In₂O₃: Amphoteric
    - Tl₂O₃: Basic

    **Basicity increases** down the group.

    ### 2. Reaction with Acids and Bases

    **Aluminium is amphoteric:**
    - With acid: 2Al + 6HCl → 2AlCl₃ + 3H₂
    - With base: 2Al + 2NaOH + 2H₂O → 2NaAlO₂ + 3H₂

    ### 3. Reaction with Halogens

    Form MX₃ (trihalides):

    2M + 3X₂ → 2MX₃

    - Most halides are covalent (except some Al and heavier metal halides)
    - BCl₃, AlCl₃ are Lewis acids (electron deficient)

    ### 4. Hydrides

    Form MH₃ type hydrides:

    - B₂H₆ (diborane): Electron deficient, has 3-center-2-electron bonds
    - AlH₃: Polymeric
    - Hydride stability decreases down the group

    ## Anomalous Properties of Boron

    Boron differs from other Group 13 elements:

    1. **Non-metal** (others are metals)
    2. **Forms covalent compounds** exclusively
    3. **Does not form B³⁺ ion** (very high ionization energy)
    4. **Electron deficient compounds** (BH₃, BCl₃ have only 6 electrons)
    5. **Forms cluster compounds** (boranes like B₂H₆, B₄H₁₀)
    6. **High melting point** (2300°C)
    7. **Extremely hard**

    ## Diagonal Relationship: B and Si

    Boron shows similarity with Silicon (Group 14):

    | Property | Similarity |
    |----------|-----------|
    | Nature | Both are metalloids |
    | Oxides | B₂O₃ and SiO₂ are acidic |
    | Hydrides | Both form hydrides that burn in air |
    | Halides | Both halides are covalent and hydrolyze |
    | Hardness | Both are very hard |

    ## Important Compounds

    ### Borax - Na₂B₄O₇·10H₂O

    **Preparation:** From colemanite ore

    **Properties:**
    - White crystalline solid
    - Dissolves in water to give alkaline solution
    - On heating, swells up and loses water

    **Uses:**
    - Manufacture of glass and enamels
    - Borax bead test (qualitative analysis)
    - Antiseptic, water softener

    **Reactions:**
    - With acid: Na₂B₄O₇ + 2HCl + 5H₂O → 2NaCl + 4H₃BO₃
    - On heating: Na₂B₄O₇·10H₂O → Na₂B₄O₇ + 10H₂O

    ### Boric Acid - H₃BO₃ or B(OH)₃

    **Preparation:**
    Na₂B₄O₇ + 2HCl + 5H₂O → 2NaCl + 4H₃BO₃

    **Structure:** Layered structure with hydrogen bonding

    **Properties:**
    - Weak monobasic acid (not tribasic!)
    - Acts as Lewis acid: B(OH)₃ + H₂O → [B(OH)₄]⁻ + H⁺
    - Antiseptic

    **Uses:** Eye wash, food preservative, insecticide

    ### Diborane - B₂H₆

    **Structure:** Two 3-center-2-electron bonds (banana bonds)

    **Properties:**
    - Colorless gas
    - Highly reactive
    - Burns in air: B₂H₆ + 3O₂ → B₂O₃ + 3H₂O
    - Hydrolyzes: B₂H₆ + 6H₂O → 2B(OH)₃ + 6H₂

    **Uses:** Rocket fuel, reducing agent

    ### Aluminium Oxide - Al₂O₃ (Alumina)

    **Occurrence:** Bauxite (Al₂O₃·2H₂O), Corundum (Al₂O₃)

    **Properties:**
    - Very hard (used as abrasive)
    - High melting point (2050°C)
    - Amphoteric oxide
    - Insoluble in water

    **Amphoteric nature:**
    - With acid: Al₂O₃ + 6HCl → 2AlCl₃ + 3H₂O
    - With base: Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O

    ### Aluminium Chloride - AlCl₃

    **Structure:** Dimeric (Al₂Cl₆) in vapor phase

    **Properties:**
    - Anhydrous AlCl₃ is covalent
    - Fumes in moist air (hygroscopic)
    - Lewis acid (electron deficient)

    **Uses:** Friedel-Crafts catalyst in organic chemistry

    ### Alum - K₂SO₄·Al₂(SO₄)₃·24H₂O

    **General formula:** M₂SO₄·M₂³⁺(SO₄)₃·24H₂O

    **Properties:**
    - Double salt
    - Forms octahedral crystals
    - Dissolves in water

    **Uses:** Water purification, dyeing, paper industry

    ## IIT JEE Key Points

    1. Group 13 has **ns² np¹** configuration (3 valence electrons)
    2. **Inert pair effect:** +1 state stability increases down group (Tl⁺ > Tl³⁺)
    3. **Boron is anomalous:** non-metal, covalent compounds only
    4. **Diagonal relationship:** B resembles Si
    5. **Amphoteric:** Al₂O₃ and Al(OH)₃ react with both acids and bases
    6. **Lewis acids:** BCl₃ and AlCl₃ (electron deficient)
    7. **Borax formula:** Na₂B₄O₇·10H₂O
    8. **Boric acid:** Weak monobasic acid, acts as Lewis acid
    9. **Diborane:** B₂H₆ has 3-center-2-electron bonds
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 5.1: #{lesson_5_1.title}"

# Quiz 5.1: Group 13
quiz_5_1 = Quiz.create!(
  title: 'Group 13 - Boron Family',
  description: 'Test on Group 13 elements and compounds',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_5_1,
    question_type: 'mcq',
    question_text: 'Which element in Group 13 shows the strongest inert pair effect?',
    options: [
      { text: 'Boron', correct: false },
      { text: 'Aluminium', correct: false },
      { text: 'Gallium', correct: false },
      { text: 'Thallium', correct: true }
    ],
    explanation: 'Inert pair effect increases down the group. Thallium shows the strongest effect, with Tl⁺ being more stable than Tl³⁺ due to poor shielding by 4f and 5d electrons.',
    points: 2,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'inert_pair_effect',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 1
  },

  {
    quiz: quiz_5_1,
    question_type: 'fill_blank',
    question_text: 'Boric acid acts as a _______ acid (Lewis/Brønsted).',
    correct_answer: 'Lewis|lewis',
    explanation: 'H₃BO₃ acts as a Lewis acid by accepting OH⁻: B(OH)₃ + H₂O → [B(OH)₄]⁻ + H⁺. It is NOT a Brønsted acid (doesn\'t donate H⁺ directly).',
    points: 2,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'boron_compounds',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 2
  },

  {
    quiz: quiz_5_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are anomalous properties of boron?',
    options: [
      { text: 'It is a non-metal', correct: true },
      { text: 'It forms ionic compounds', correct: false },
      { text: 'It forms electron-deficient compounds', correct: true },
      { text: 'It readily forms B³⁺ ions', correct: false }
    ],
    explanation: 'Boron is anomalous: (1) Non-metal (others are metals), (2) Forms only covalent compounds, (3) Electron-deficient (BH₃, BCl₃), (4) Does NOT form B³⁺ (very high IE).',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'anomalous_behavior',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  {
    quiz: quiz_5_1,
    question_type: 'numerical',
    question_text: 'How many water molecules of crystallization are present in borax (Na₂B₄O₇·xH₂O)?',
    correct_answer: '10',
    tolerance: 0.0,
    explanation: 'Borax is Na₂B₄O₇·10H₂O (sodium tetraborate decahydrate). It loses all 10 water molecules on heating.',
    points: 1,
    difficulty: -0.5,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'boron_compounds',
    skill_dimension: 'recall',
    sequence_order: 4
  },

  {
    quiz: quiz_5_1,
    question_type: 'true_false',
    question_text: 'Aluminium oxide (Al₂O₃) is amphoteric in nature.',
    correct_answer: 'true',
    explanation: 'TRUE. Al₂O₃ is amphoteric - reacts with acids (Al₂O₃ + 6HCl → 2AlCl₃ + 3H₂O) and bases (Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O).',
    points: 1,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'aluminium_compounds',
    skill_dimension: 'recall',
    sequence_order: 5
  },

  {
    quiz: quiz_5_1,
    question_type: 'sequence',
    question_text: 'Arrange the following in order of INCREASING basicity of oxides:',
    sequence_items: [
      { id: 1, text: 'B₂O₃ (Boron oxide)' },
      { id: 2, text: 'Al₂O₃ (Aluminium oxide)' },
      { id: 3, text: 'Ga₂O₃ (Gallium oxide)' },
      { id: 4, text: 'Tl₂O₃ (Thallium oxide)' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Basicity of oxides increases down the group: B₂O₃ (acidic) < Al₂O₃ (amphoteric) < Ga₂O₃ (amphoteric) < Tl₂O₃ (basic).',
    points: 3,
    difficulty: 0.7,
    discrimination: 1.3,
    guessing: 0.04,
    difficulty_level: 'hard',
    topic: 'periodic_trends',
    skill_dimension: 'application',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 5.1: #{quiz_5_1.quiz_questions.count} questions"

# ========================================
# Lesson 5.2: Group 14 - Carbon Family
# ========================================

lesson_5_2 = CourseLesson.create!(
  title: 'Group 14 - Carbon Family (C, Si, Ge, Sn, Pb)',
  reading_time_minutes: 45,
  key_concepts: ['Carbon family', 'Allotropy', 'Catenation', 'Silicones', 'Lead compounds'],
  content: <<~MD
    # Group 14 - Carbon Family

    ## Introduction

    Group 14 elements have the general electronic configuration **ns² np²** (4 valence electrons).

    **Members:** Carbon (C), Silicon (Si), Germanium (Ge), Tin (Sn), Lead (Pb)

    ## Electronic Configuration

    - C: [He] 2s² 2p²
    - Si: [Ne] 3s² 3p²
    - Ge: [Ar] 3d¹⁰ 4s² 4p²
    - Sn: [Kr] 4d¹⁰ 5s² 5p²
    - Pb: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p²

    ## Oxidation States

    **Common oxidation states:** +4 (group oxidation state), +2

    **Trend:** Stability of +2 state increases down the group
    - C: +4, +2 (in CO)
    - Si: +4 predominantly
    - Ge: +4 and +2
    - Sn: Both +4 and +2 (SnCl₂, SnCl₄)
    - Pb: +2 more stable than +4

    **Inert Pair Effect:** Pb²⁺ is more stable than Pb⁴⁺ (PbO₂ is a strong oxidizing agent).

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group**

    ### Ionization Energy
    - **Decreases down the group**

    ### Electronegativity
    - **Decreases down the group**
    - C is most electronegative (2.5)

    ### Covalent Radius
    - **Increases down the group**

    ### Metallic Character
    - **Increases down the group**
    - C: Non-metal
    - Si, Ge: Metalloids
    - Sn, Pb: Metals

    ## Allotropy

    ### Carbon Allotropes

    **Diamond:**
    - 3D network of C atoms
    - Each C is sp³ hybridized
    - Hardest natural substance
    - Poor conductor of electricity
    - High refractive index

    **Graphite:**
    - Layered hexagonal structure
    - Each C is sp² hybridized
    - Soft and slippery
    - Good conductor of electricity (delocalized π electrons)
    - Used in pencils, lubricants, electrodes

    **Fullerenes:**
    - C₆₀ (Buckminsterfullerene) - soccer ball structure
    - Cage-like structures
    - Each C is bonded to 3 other C atoms

    **Graphene:**
    - Single layer of graphite
    - 2D material
    - Excellent electrical and thermal conductivity

    ## Chemical Properties

    ### 1. Catenation

    **Catenation:** Ability to form chains by bonding to itself

    **Order:** C >> Si > Ge > Sn > Pb

    **Reason:** C-C bond (356 kJ/mol) is strongest
    - C forms chains with millions of atoms
    - Si forms chains with up to 7-8 atoms (silanes)

    ### 2. Reaction with Oxygen

    Form MO₂ (dioxides):

    M + O₂ → MO₂

    **Nature of oxides:**
    - CO₂: Acidic gas
    - SiO₂: Acidic solid (giant covalent)
    - GeO₂: Amphoteric
    - SnO₂: Amphoteric
    - PbO₂: Amphoteric (strong oxidizing agent)

    Also form MO (monoxides):
    - CO: Neutral
    - SnO: Amphoteric
    - PbO: Amphoteric (Litharge)

    ### 3. Reaction with Halogens

    Form MX₄ and MX₂:

    **Tetrahalides (MX₄):**
    - CCl₄: Covalent, inert to hydrolysis
    - SiCl₄: Covalent, readily hydrolyzes (has d-orbitals)
    - SnCl₄, PbCl₄: Covalent

    **Dihalides (MX₂):**
    - SnCl₂: Reducing agent
    - PbCl₂: Sparingly soluble

    **Why CCl₄ doesn't hydrolyze but SiCl₄ does?**
    - C has no d-orbitals (cannot expand octet)
    - Si has d-orbitals (can accommodate H₂O attack)

    ### 4. Hydrides

    **Hydrides:** MH₄ type
    - CH₄: Methane (most stable)
    - SiH₄: Silane (less stable, catches fire in air)
    - GeH₄: Germane
    - SnH₄: Stannane (very unstable)

    **Stability decreases down the group** (M-H bond strength decreases)

    ## Important Compounds

    ### Carbon Monoxide - CO

    **Preparation:**
    - Incomplete combustion: 2C + O₂ → 2CO
    - From formic acid: HCOOH → CO + H₂O (with H₂SO₄)

    **Properties:**
    - Colorless, odorless, poisonous gas
    - Neutral oxide
    - Reducing agent
    - Forms carbonyls: Ni + 4CO → Ni(CO)₄

    **Toxicity:** Binds to hemoglobin more strongly than O₂, prevents oxygen transport

    ### Carbon Dioxide - CO₂

    **Preparation:**
    - Combustion: C + O₂ → CO₂
    - From carbonates: CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂

    **Properties:**
    - Colorless, odorless gas
    - Acidic oxide
    - Turns lime water milky: Ca(OH)₂ + CO₂ → CaCO₃↓ + H₂O
    - Does not support combustion (but Mg burns: 2Mg + CO₂ → 2MgO + C)

    **Uses:** Carbonated drinks, fire extinguisher, dry ice

    ### Silicon Dioxide - SiO₂ (Silica)

    **Occurrence:** Sand, quartz, agate

    **Structure:** 3D network of SiO₄ tetrahedra

    **Properties:**
    - Very hard
    - High melting point (1713°C)
    - Insoluble in water
    - Reacts with HF: SiO₂ + 4HF → SiF₄ + 2H₂O

    **Uses:** Glass, cement, pottery

    ### Silicates

    **Structure:** Based on SiO₄⁴⁻ tetrahedra

    **Types:**
    - Orthosilicates: Isolated SiO₄⁴⁻ (e.g., Mg₂SiO₄)
    - Pyrosilicates: Si₂O₇⁶⁻ (two tetrahedra sharing 1 O)
    - Chain silicates: (SiO₃²⁻)ₙ (pyroxenes)
    - Sheet silicates: (Si₂O₅²⁻)ₙ (mica, talc, asbestos)
    - 3D silicates: (SiO₂)ₙ (quartz, feldspar)

    ### Silicones

    **Formula:** (R₂SiO)ₙ

    **Structure:** Chains/rings of alternating Si and O atoms with organic groups (R = CH₃, C₂H₅)

    **Preparation:**
    RCl + Si → R₂SiCl₂ (with Cu catalyst)
    R₂SiCl₂ + H₂O → (R₂SiO)ₙ + HCl

    **Properties:**
    - Water repellent
    - Chemically inert
    - Heat resistant
    - Good electrical insulators

    **Uses:** Lubricants, sealants, water-proofing, cosmetics

    ### Lead Compounds

    **Lead(II) oxide - PbO (Litharge):**
    - Yellow or red powder
    - Amphoteric
    - Used in glass, pottery

    **Lead(IV) oxide - PbO₂:**
    - Dark brown powder
    - Strong oxidizing agent
    - Used in lead-acid batteries

    **Lead(II) sulfate - PbSO₄:**
    - White precipitate
    - Sparingly soluble
    - Used in lead storage batteries

    **Lead(II) chloride - PbCl₂:**
    - White precipitate
    - Sparingly soluble in cold water, soluble in hot water

    **Red lead - Pb₃O₄:**
    - Mixed oxide: 2PbO·PbO₂
    - Red powder
    - Used in paints (anti-rust)

    ## IIT JEE Key Points

    1. Group 14 has **ns² np²** configuration (4 valence electrons)
    2. **Inert pair effect:** Pb²⁺ more stable than Pb⁴⁺
    3. **Catenation:** C >> Si > Ge > Sn > Pb
    4. **Carbon allotropes:** Diamond (sp³, hard, insulator), Graphite (sp², soft, conductor), Fullerenes (C₆₀)
    5. **CCl₄ doesn't hydrolyze** (no d-orbitals), **SiCl₄ hydrolyzes** (has d-orbitals)
    6. **CO is poisonous** (binds to hemoglobin)
    7. **Silicones:** (R₂SiO)ₙ - water repellent, heat resistant
    8. **PbO₂:** Strong oxidizing agent
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_2, sequence_order: 3, required: true)

puts "  ✓ Lesson 5.2: #{lesson_5_2.title}"

# Quiz 5.2: Group 14
quiz_5_2 = Quiz.create!(
  title: 'Group 14 - Carbon Family',
  description: 'Test on Group 14 elements and compounds',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_2, sequence_order: 4, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_5_2,
    question_type: 'mcq',
    question_text: 'Why does CCl₄ not undergo hydrolysis while SiCl₄ does?',
    options: [
      { text: 'C-Cl bond is stronger than Si-Cl bond', correct: false },
      { text: 'C has no d-orbitals to accept lone pairs from H₂O', correct: true },
      { text: 'CCl₄ is less polar than SiCl₄', correct: false },
      { text: 'SiCl₄ is more soluble in water', correct: false }
    ],
    explanation: 'CCl₄ cannot hydrolyze because C (period 2) has no d-orbitals and cannot expand its octet to accommodate H₂O attack. Si (period 3) has empty d-orbitals that can accept lone pairs from water.',
    points: 3,
    difficulty: 0.8,
    discrimination: 1.5,
    guessing: 0.25,
    difficulty_level: 'hard',
    topic: 'chemical_reactivity',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 1
  },

  {
    quiz: quiz_5_2,
    question_type: 'sequence',
    question_text: 'Arrange the following in order of DECREASING catenation ability:',
    sequence_items: [
      { id: 1, text: 'Carbon (C)' },
      { id: 2, text: 'Silicon (Si)' },
      { id: 3, text: 'Germanium (Ge)' },
      { id: 4, text: 'Tin (Sn)' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Catenation ability: C >> Si > Ge > Sn > Pb. C-C bond (356 kJ/mol) is strongest, allowing formation of long chains. Si forms chains up to Si₇, then ability decreases.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.2,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'catenation',
    skill_dimension: 'application',
    sequence_order: 2
  },

  {
    quiz: quiz_5_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following statements about graphite are correct?',
    options: [
      { text: 'Each carbon atom is sp² hybridized', correct: true },
      { text: 'It is a good conductor of electricity', correct: true },
      { text: 'It is the hardest form of carbon', correct: false },
      { text: 'It has a layered structure', correct: true }
    ],
    explanation: 'Graphite: sp² hybridized C atoms, layered hexagonal structure, good conductor (delocalized π electrons), soft and slippery. Diamond is the hardest form.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'allotropy',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  {
    quiz: quiz_5_2,
    question_type: 'fill_blank',
    question_text: 'Carbon monoxide is poisonous because it binds to _______ more strongly than oxygen.',
    correct_answer: 'hemoglobin|haemoglobin|hemoglobin (Hb)',
    explanation: 'CO binds to hemoglobin about 200 times more strongly than O₂, forming carboxyhemoglobin (COHb), which prevents oxygen transport in blood.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'carbon_compounds',
    skill_dimension: 'recall',
    sequence_order: 4
  },

  {
    quiz: quiz_5_2,
    question_type: 'mcq',
    question_text: 'Which oxide of lead is a strong oxidizing agent?',
    options: [
      { text: 'PbO', correct: false },
      { text: 'PbO₂', correct: true },
      { text: 'Pb₃O₄', correct: false },
      { text: 'Pb₂O₃', correct: false }
    ],
    explanation: 'PbO₂ (lead dioxide) is a strong oxidizing agent. Pb is in +4 state (unstable due to inert pair effect), readily reduced to Pb²⁺.',
    points: 2,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'lead_compounds',
    skill_dimension: 'recall',
    sequence_order: 5
  },

  {
    quiz: quiz_5_2,
    question_type: 'true_false',
    question_text: 'Silicones are water repellent and chemically inert.',
    correct_answer: 'true',
    explanation: 'TRUE. Silicones (R₂SiO)ₙ are water repellent, chemically inert, heat resistant, and good electrical insulators. Used in waterproofing, lubricants, and sealants.',
    points: 1,
    difficulty: -0.4,
    discrimination: 0.9,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'silicon_compounds',
    skill_dimension: 'recall',
    sequence_order: 6
  },

  {
    quiz: quiz_5_2,
    question_type: 'numerical',
    question_text: 'In diamond, each carbon atom is bonded to how many other carbon atoms?',
    correct_answer: '4',
    tolerance: 0.0,
    explanation: 'In diamond, each C is sp³ hybridized and forms 4 covalent bonds in a tetrahedral arrangement, creating a 3D network structure.',
    points: 1,
    difficulty: -0.6,
    discrimination: 0.9,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'allotropy',
    skill_dimension: 'recall',
    sequence_order: 7
  }
])

puts "  ✓ Quiz 5.2: #{quiz_5_2.quiz_questions.count} questions"

puts "\n" + "=" * 80
puts "MODULE 5 (PART 1) SUMMARY"
puts "=" * 80
puts "✅ Module: #{module_5.title}"
puts "✅ Lessons: 2 (Groups 13-14)"
puts "✅ Quizzes: 2"
puts "✅ Total Questions: #{quiz_5_1.quiz_questions.count + quiz_5_2.quiz_questions.count}"
puts "=" * 80
puts "\n"

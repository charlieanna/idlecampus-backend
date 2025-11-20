# frozen_string_literal: true

# ========================================
# IIT JEE Inorganic Chemistry - Module 6
# d-Block Elements (Transition Metals)
# ========================================
# Groups 3-12, covering 3d, 4d, 5d series
# Most important module for IIT JEE Advanced
# ========================================

puts "\n" + "=" * 80
puts "MODULE 6: d-BLOCK ELEMENTS (TRANSITION METALS)"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Inorganic Chemistry course not found!"
  exit 1
end

# Create Module 6: d-Block Elements
module_6 = course.course_modules.find_or_create_by!(slug: 'd-block-transition-elements') do |m|
  m.title = 'd-Block and Transition Elements'
  m.sequence_order = 6
  m.estimated_minutes = 700  # ~12 hours
  m.description = 'Comprehensive study of transition metals: properties, oxidation states, color, magnetism, and important compounds'
  m.learning_objectives = [
    'Understand electronic configuration of d-block elements',
    'Master variable oxidation states and catalytic properties',
    'Learn magnetic properties and color in complexes',
    'Study important compounds: K₂Cr₂O₇, KMnO₄, FeSO₄',
    'Apply knowledge to solve IIT JEE Advanced problems'
  ]
  m.published = true
end

puts "✅ Module 6: #{module_6.title}"

# ========================================
# Lesson 6.1: General Properties of Transition Metals
# ========================================

lesson_6_1 = CourseLesson.create!(
  title: 'General Properties of Transition Metals',
  reading_time_minutes: 45,
  key_concepts: ['Transition metals', 'd-orbitals', 'Metallic character', 'Density', 'Melting points'],
  content: <<~MD
    # General Properties of Transition Metals

    ## Definition

    **Transition elements:** Elements with **incompletely filled d-orbitals** in the ground state or in any stable oxidation state.

    **d-Block elements:** Elements in Groups 3-12 where d-orbitals are being filled.

    **Note:** Zn, Cd, Hg are NOT transition elements (d¹⁰s² - completely filled d-orbitals).

    ## Electronic Configuration

    ### General Configuration
    **(n-1)d¹⁻¹⁰ ns¹⁻²**

    ### 3d Series (First Transition Series)
    Sc to Zn (Atomic numbers 21-30)

    | Element | Configuration | Exceptions |
    |---------|---------------|------------|
    | Sc | [Ar] 3d¹ 4s² | - |
    | Ti | [Ar] 3d² 4s² | - |
    | V | [Ar] 3d³ 4s² | - |
    | Cr | [Ar] 3d⁵ 4s¹ | Exception! (half-filled stability) |
    | Mn | [Ar] 3d⁵ 4s² | - |
    | Fe | [Ar] 3d⁶ 4s² | - |
    | Co | [Ar] 3d⁷ 4s² | - |
    | Ni | [Ar] 3d⁸ 4s² | - |
    | Cu | [Ar] 3d¹⁰ 4s¹ | Exception! (fully-filled stability) |
    | Zn | [Ar] 3d¹⁰ 4s² | Not a transition metal |

    **Exceptions:**
    - **Cr:** 3d⁵ 4s¹ (instead of 3d⁴ 4s²) - half-filled d-orbital stability
    - **Cu:** 3d¹⁰ 4s¹ (instead of 3d⁹ 4s²) - fully-filled d-orbital stability

    ## Physical Properties

    ### 1. Metallic Character
    - All are **metals**
    - Good conductors of heat and electricity
    - Lustrous appearance
    - High tensile strength

    ### 2. Atomic and Ionic Radii

    **Trend across period:**
    - Generally **decrease** from Sc to Zn (but small variation)
    - Effective nuclear charge increases, pulls electrons closer

    **d-electrons provide poor shielding** → small decrease in size

    ### 3. Ionization Energy

    **Trend:**
    - Generally **increases** across the series
    - Irregular trend due to electronic configuration changes
    - Higher than s-block, lower than p-block metals

    **Why irregular?**
    - Cr and Cu have extra stability (half-filled and fully-filled)
    - Higher IE than expected

    ### 4. Density

    - **Very high densities** (heavy metals)
    - **Increases** across the period (up to middle, then decreases)
    - Maximum around Fe, Co, Ni

    **Reason:** Atomic mass increases more than atomic volume increases

    ### 5. Melting and Boiling Points

    - **Very high** melting and boiling points
    - Due to strong metallic bonding (involving both d and s electrons)
    - Maximum at Group 6 (Cr, Mo, W)

    **Exception:** Zn, Cd, Hg have low melting points (d¹⁰ - no d-electrons available for bonding)

    ### 6. Enthalpy of Atomization

    - **High** values
    - Reflects strong metallic bonding
    - Maximum around the middle of series (V, Cr, Mn)

    ## Chemical Properties

    ### 1. Variable Oxidation States

    **Most characteristic property** of transition metals

    **Reason:**
    - Both (n-1)d and ns electrons participate in bonding
    - Small energy difference between (n-1)d and ns orbitals

    **Examples:**
    - Sc: +3 only
    - Ti: +2, +3, +4
    - V: +2, +3, +4, +5
    - Cr: +2, +3, +4, +5, +6
    - Mn: +2, +3, +4, +5, +6, +7 (maximum oxidation states!)
    - Fe: +2, +3
    - Cu: +1, +2

    **Common oxidation states:**
    - +2 (most common - loss of 2 ns electrons)
    - +3 (loss of 1 ns + 1 d electron)
    - Higher states in compounds with F and O

    **Stability of +2 state:**
    - **Increases** from Sc to Zn
    - Mn²⁺ and Fe²⁺ are very stable

    ### 2. Formation of Colored Ions

    **Reason:** Partially filled d-orbitals → d-d transitions

    When white light falls on transition metal compounds:
    - d-electrons absorb specific wavelengths
    - Get excited to higher d-orbitals
    - Complementary color is observed

    **Examples:**
    - Cu²⁺: Blue (absorbs red-orange)
    - Fe³⁺: Yellow-brown
    - Cr³⁺: Green
    - Co²⁺: Pink
    - Ni²⁺: Green

    **Colorless ions:**
    - Sc³⁺ (d⁰) - no d-electrons
    - Zn²⁺ (d¹⁰) - completely filled
    - Ti⁴⁺ (d⁰)

    ### 3. Paramagnetism

    **Definition:** Attraction to magnetic field due to unpaired electrons

    **Magnetic moment (μ):** μ = √(n(n+2)) BM (Bohr Magneton)
    where n = number of unpaired electrons

    **Examples:**
    - Sc³⁺ (d⁰): 0 unpaired → diamagnetic
    - Ti³⁺ (d¹): 1 unpaired → μ = √3 = 1.73 BM
    - V³⁺ (d²): 2 unpaired → μ = √8 = 2.83 BM
    - Cr³⁺ (d³): 3 unpaired → μ = √15 = 3.87 BM
    - Mn²⁺ (d⁵): 5 unpaired → μ = √35 = 5.92 BM (maximum!)
    - Fe²⁺ (d⁶): 4 unpaired → μ = √24 = 4.90 BM
    - Cu²⁺ (d⁹): 1 unpaired → μ = 1.73 BM
    - Zn²⁺ (d¹⁰): 0 unpaired → diamagnetic

    ### 4. Formation of Complex Compounds

    **Reason:**
    - Small size, high charge
    - Availability of vacant d-orbitals
    - Can accept electron pairs from ligands

    **Examples:**
    - [Fe(CN)₆]⁴⁻, [Fe(CN)₆]³⁻
    - [Cu(NH₃)₄]²⁺
    - [Ni(CO)₄]
    - [Co(NH₃)₆]³⁺

    ### 5. Catalytic Properties

    **Transition metals and their compounds act as catalysts**

    **Reason:**
    - Variable oxidation states (can change easily)
    - Ability to adsorb reactants on surface
    - Form intermediate compounds

    **Examples:**
    - Fe in Haber process: N₂ + 3H₂ ⇌ 2NH₃
    - V₂O₅ in Contact process: 2SO₂ + O₂ → 2SO₃
    - Ni in hydrogenation: C₂H₄ + H₂ → C₂H₆
    - Pt in Ostwald process: 4NH₃ + 5O₂ → 4NO + 6H₂O
    - TiCl₄/Al(C₂H₅)₃ in Ziegler-Natta polymerization

    ### 6. Formation of Alloys

    - Transition metals readily form alloys
    - Similar atomic sizes → easy substitution

    **Examples:**
    - Steel: Fe + C
    - Brass: Cu + Zn
    - Bronze: Cu + Sn
    - Stainless steel: Fe + Cr + Ni

    ### 7. Interstitial Compounds

    - Small atoms (H, C, N) occupy **interstitial sites** in metal lattice
    - Example: Steel (C in Fe lattice)
    - Properties: Very hard, high melting points

    ## Comparison: 3d, 4d, 5d Series

    | Property | 3d Series | 4d Series | 5d Series |
    |----------|-----------|-----------|-----------|
    | Atomic radius | Smallest | Medium | Largest (but ~4d) |
    | Density | Lower | Medium | Highest |
    | Melting point | Lower | Higher | Highest |
    | Oxidation states | Lower max | Higher | Highest |
    | Stability of higher states | Least | Medium | Most |

    **Lanthanoid Contraction Effect:**
    - 4d and 5d series have nearly same size
    - Due to poor shielding by 4f electrons

    ## IIT JEE Key Points

    1. **Definition:** Incomplete d-orbitals in ground state or stable oxidation state
    2. **Electronic configuration:** (n-1)d¹⁻¹⁰ ns¹⁻²
    3. **Exceptions:** Cr (3d⁵ 4s¹), Cu (3d¹⁰ 4s¹)
    4. **Zn, Cd, Hg NOT transition metals** (d¹⁰ - completely filled)
    5. **Variable oxidation states** (most characteristic property)
    6. **Colored ions** due to d-d transitions
    7. **Paramagnetic** due to unpaired electrons: μ = √(n(n+2)) BM
    8. **Catalysts** due to variable oxidation states
    9. **Mn²⁺ has maximum unpaired electrons** (5) → highest magnetic moment
    10. **High density, high melting points** (strong metallic bonding)
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 6.1: #{lesson_6_1.title}"

# Quiz 6.1
quiz_6_1 = Quiz.create!(
  title: 'General Properties of Transition Metals',
  description: 'Test on d-block element properties',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_6, item: quiz_6_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are NOT transition elements?',
    options: [
      { text: 'Scandium (Sc)', correct: false },
      { text: 'Zinc (Zn)', correct: true },
      { text: 'Copper (Cu)', correct: false },
      { text: 'Cadmium (Cd)', correct: true }
    ],
    explanation: 'Zn (3d¹⁰ 4s²) and Cd (4d¹⁰ 5s²) have completely filled d-orbitals in ground state and common oxidation states. They are NOT transition elements. Cu is a transition element (forms Cu²⁺ with d⁹).',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'definition',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 1
  },

  {
    quiz: quiz_6_1,
    question_type: 'fill_blank',
    question_text: 'The electronic configuration of chromium (Cr, Z=24) is [Ar] 3d____ 4s____.',
    correct_answer: '3d5 4s1|3d⁵ 4s¹|5,1',
    explanation: 'Cr has exceptional configuration [Ar] 3d⁵ 4s¹ (not 3d⁴ 4s²) due to extra stability of half-filled d-orbital.',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'electronic_configuration',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    question_text: 'Which transition metal ion has the maximum number of unpaired electrons?',
    options: [
      { text: 'Fe²⁺ (d⁶)', correct: false },
      { text: 'Mn²⁺ (d⁵)', correct: true },
      { text: 'Cr³⁺ (d³)', correct: false },
      { text: 'Cu²⁺ (d⁹)', correct: false }
    ],
    explanation: 'Mn²⁺ has d⁵ configuration with 5 unpaired electrons (one in each d-orbital), giving maximum unpaired electrons and highest magnetic moment μ = √35 = 5.92 BM.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'magnetism',
    skill_dimension: 'application',
    sequence_order: 3
  },

  {
    quiz: quiz_6_1,
    question_type: 'numerical',
    question_text: 'Calculate the magnetic moment (in BM) of Ti³⁺ ion (d¹ configuration). Use formula: μ = √(n(n+2)) where n = unpaired electrons.',
    correct_answer: '1.73',
    tolerance: 0.1,
    explanation: 'Ti³⁺ has d¹ configuration (1 unpaired electron). μ = √(1(1+2)) = √3 = 1.73 BM.',
    points: 3,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'magnetism',
    skill_dimension: 'calculation',
    sequence_order: 4
  },

  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Why do transition metals show catalytic properties?',
    options: [
      { text: 'Variable oxidation states', correct: true },
      { text: 'Ability to adsorb reactants', correct: true },
      { text: 'Complete d-orbitals', correct: false },
      { text: 'Large atomic size', correct: false }
    ],
    explanation: 'Transition metals act as catalysts due to: (1) Variable oxidation states (can change during reaction), (2) Ability to adsorb reactants on surface, (3) Formation of unstable intermediates.',
    points: 4,
    difficulty: 0.7,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'catalysis',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 5
  },

  {
    quiz: quiz_6_1,
    question_type: 'true_false',
    question_text: 'Sc³⁺ and Zn²⁺ ions are diamagnetic.',
    correct_answer: 'true',
    explanation: 'TRUE. Sc³⁺ has d⁰ configuration (no d-electrons) and Zn²⁺ has d¹⁰ (completely filled). Both have zero unpaired electrons, hence diamagnetic.',
    points: 2,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.5,
    difficulty_level: 'medium',
    topic: 'magnetism',
    skill_dimension: 'application',
    sequence_order: 6
  },

  {
    quiz: quiz_6_1,
    question_type: 'sequence',
    question_text: 'Arrange the following in order of INCREASING number of oxidation states:',
    sequence_items: [
      { id: 1, text: 'Scandium (Sc)' },
      { id: 2, text: 'Titanium (Ti)' },
      { id: 3, text: 'Chromium (Cr)' },
      { id: 4, text: 'Manganese (Mn)' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Number of oxidation states increases across 3d series initially. Sc (only +3) < Ti (+2,+3,+4) < Cr (+2,+3,+4,+5,+6) < Mn (+2,+3,+4,+5,+6,+7 - maximum!).',
    points: 4,
    difficulty: 0.8,
    discrimination: 1.5,
    guessing: 0.04,
    difficulty_level: 'hard',
    topic: 'oxidation_states',
    skill_dimension: 'application',
    sequence_order: 7
  },

  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    question_text: 'Which of the following ions is colorless in aqueous solution?',
    options: [
      { text: 'Cu²⁺', correct: false },
      { text: 'Fe³⁺', correct: false },
      { text: 'Zn²⁺', correct: true },
      { text: 'Cr³⁺', correct: false }
    ],
    explanation: 'Zn²⁺ (d¹⁰) is colorless because d-orbitals are completely filled - no d-d transitions possible. Cu²⁺ (blue), Fe³⁺ (yellow-brown), Cr³⁺ (green) are colored.',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'color',
    skill_dimension: 'application',
    sequence_order: 8
  }
])

puts "  ✓ Quiz 6.1: #{quiz_6_1.quiz_questions.count} questions"

# ========================================
# Lesson 6.2: Important Compounds - Dichromates and Permanganates
# ========================================

lesson_6_2 = CourseLesson.create!(
  title: 'Important Compounds: Dichromates and Permanganates',
  reading_time_minutes: 50,
  key_concepts: ['Potassium dichromate', 'Potassium permanganate', 'Oxidizing agents', 'Chromyl chloride test'],
  content: <<~MD
    # Important Transition Metal Compounds

    ## Potassium Dichromate - K₂Cr₂O₇

    ### Preparation

    **From chromite ore (FeCr₂O₄):**

    1. **Roasting with Na₂CO₃ in presence of air:**
       4FeCr₂O₄ + 8Na₂CO₃ + 7O₂ → 8Na₂CrO₄ + 2Fe₂O₃ + 8CO₂
       (Sodium chromate - yellow, soluble)

    2. **Acidification:**
       2Na₂CrO₄ + H₂SO₄ → Na₂Cr₂O₇ + Na₂SO₄ + H₂O
       (Sodium dichromate - orange)

    3. **Conversion to K₂Cr₂O₇:**
       Na₂Cr₂O₇ + 2KCl → K₂Cr₂O₇ + 2NaCl
       (K₂Cr₂O₇ is less soluble, precipitates)

    ### Structure

    - **Cr₂O₇²⁻ ion:** Two CrO₄ tetrahedra sharing one oxygen
    - **Oxidation state of Cr:** +6
    - **Chromate-Dichromate equilibrium:**
      2CrO₄²⁻ + 2H⁺ ⇌ Cr₂O₇²⁻ + H₂O
      (Yellow)    (Orange)

    **In acidic medium:** Orange (Cr₂O₇²⁻)
    **In basic medium:** Yellow (CrO₄²⁻)

    ### Properties

    **Physical:**
    - Orange-red crystalline solid
    - Soluble in water

    **Chemical:**
    - **Strong oxidizing agent** (especially in acidic medium)
    - **Cr₂O₇²⁻ → Cr³⁺** (green in acidic medium)

    ### Oxidizing Reactions

    **1. With FeSO₄:**
    K₂Cr₂O₇ + 7H₂SO₄ + 6FeSO₄ → K₂SO₄ + Cr₂(SO₄)₃ + 3Fe₂(SO₄)₃ + 7H₂O
    (Orange → Green)
    Fe²⁺ → Fe³⁺ (oxidized)

    **2. With KI in acidic medium:**
    K₂Cr₂O₇ + 7H₂SO₄ + 6KI → K₂SO₄ + Cr₂(SO₄)₃ + 3I₂ + 7H₂O + 3K₂SO₄
    Iodine liberated (violet color)

    **3. With SO₂:**
    K₂Cr₂O₇ + H₂SO₄ + 3SO₂ → K₂SO₄ + Cr₂(SO₄)₃ + H₂O
    (Orange → Green)

    **4. With H₂S:**
    K₂Cr₂O₇ + 4H₂SO₄ + 3H₂S → K₂SO₄ + Cr₂(SO₄)₃ + 3S + 7H₂O
    (Orange → Green, sulfur precipitates)

    **5. Oxidation of alcohols:**
    - **Primary alcohol → Aldehyde → Carboxylic acid**
    - **Secondary alcohol → Ketone**
    - **Tertiary alcohol → No reaction**

    ### Chromyl Chloride Test (for Cl⁻)

    **Test for chloride ions:**

    K₂Cr₂O₇ + 4NaCl + 6H₂SO₄ → 2KHSO₄ + 4NaHSO₄ + 2CrO₂Cl₂ + 3H₂O
    (Chromyl chloride - red vapors)

    CrO₂Cl₂ + 4NaOH → Na₂CrO₄ + 2NaCl + 2H₂O
    (Yellow solution)

    Add acetic acid + lead acetate:
    Na₂CrO₄ + Pb(CH₃COO)₂ → PbCrO₄ + 2CH₃COONa
    (Yellow precipitate of PbCrO₄)

    **Confirmatory test for Cl⁻ ions**

    ### Uses

    1. **Oxidizing agent** in organic chemistry
    2. **Leather tanning**
    3. **Chrome plating**
    4. **Pigments** (chrome yellow - PbCrO₄)
    5. **Analytical reagent**

    ---

    ## Potassium Permanganate - KMnO₄

    ### Preparation

    **From pyrolusite (MnO₂):**

    1. **Fusion with KOH in presence of air:**
       2MnO₂ + 4KOH + O₂ → 2K₂MnO₄ + 2H₂O
       (Potassium manganate - green)

    2. **Electrolytic oxidation or acidification:**
       3MnO₄²⁻ + 4H⁺ → 2MnO₄⁻ + MnO₂ + 2H₂O
       (Green)    (Purple)

       Or: 2K₂MnO₄ + Cl₂ → 2KMnO₄ + 2KCl

    ### Structure

    - **MnO₄⁻ ion:** Tetrahedral
    - **Oxidation state of Mn:** +7
    - **Bond order:** 1.5 (partial double bond character)

    ### Properties

    **Physical:**
    - Dark purple crystalline solid
    - Moderately soluble in water (purple solution)
    - Intense color (even dilute solutions are colored)

    **Chemical:**
    - **Strong oxidizing agent** (one of the strongest!)
    - Oxidizing power depends on pH:
      - **Acidic medium:** MnO₄⁻ → Mn²⁺ (colorless)
      - **Neutral/Faintly alkaline:** MnO₄⁻ → MnO₂ (brown ppt)
      - **Strongly alkaline:** MnO₄⁻ → MnO₄²⁻ (green)

    ### Oxidizing Reactions

    **In Acidic Medium (H₂SO₄):**

    **1. With FeSO₄:**
    2KMnO₄ + 10FeSO₄ + 8H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5Fe₂(SO₄)₃ + 8H₂O
    (Purple → Colorless)
    Mn⁺⁷ → Mn²⁺

    **2. With Oxalic acid:**
    2KMnO₄ + 5H₂C₂O₄ + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 10CO₂ + 8H₂O
    (Self-indicating - purple → colorless)

    **3. With SO₂:**
    2KMnO₄ + 5SO₂ + 2H₂O → K₂SO₄ + 2MnSO₄ + 2H₂SO₄
    (Purple → Colorless)

    **4. With H₂S:**
    2KMnO₄ + 5H₂S + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5S + 8H₂O
    (Purple → Colorless, sulfur precipitates)

    **5. With H₂O₂:**
    2KMnO₄ + 5H₂O₂ + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5O₂ + 8H₂O
    Oxygen gas evolved

    **In Neutral/Alkaline Medium:**

    **With KI:**
    2KMnO₄ + H₂O + KI → 2MnO₂ + 2KOH + KIO₃
    (Purple → Brown precipitate)

    ### Self-Indication

    KMnO₄ acts as **self-indicator** in volumetric analysis:
    - During titration: Purple color disappears
    - At endpoint: First permanent pink color appears
    - No need for external indicator!

    ### Tests for Unsaturation

    **Baeyer's Test:**
    - **Alkenes** decolorize KMnO₄ solution
    - C=C + KMnO₄ (cold, dilute) → diol (glycol)
    - Purple → Colorless (or brown MnO₂ ppt)

    ### Uses

    1. **Oxidizing agent** in organic chemistry
    2. **Volumetric analysis** (titrations)
    3. **Disinfectant and germicide** (dilute solution)
    4. **Water purification**
    5. **Antidote for certain poisons**
    6. **Baeyer's test** for unsaturation

    ---

    ## Comparison: K₂Cr₂O₇ vs KMnO₄

    | Property | K₂Cr₂O₇ | KMnO₄ |
    |----------|---------|-------|
    | **Color** | Orange-red | Dark purple |
    | **Oxidation state** | Cr⁺⁶ | Mn⁺⁷ |
    | **Reduced to (acid)** | Cr³⁺ (green) | Mn²⁺ (colorless) |
    | **Stability** | Very stable | Decomposes on heating |
    | **Oxidizing power** | Strong | Stronger |
    | **Primary standard** | Yes | No (not pure, decomposes) |
    | **Use in titrations** | Yes | Yes (self-indicator) |
    | **Reaction with HCl** | Liberates Cl₂ | Liberates Cl₂ |

    ## IIT JEE Key Points

    1. **K₂Cr₂O₇:** Orange, Cr⁺⁶, reduced to green Cr³⁺
    2. **Chromate-dichromate equilibrium:** Yellow (CrO₄²⁻) ⇌ Orange (Cr₂O₇²⁻)
    3. **Chromyl chloride test:** Red vapors of CrO₂Cl₂ (for Cl⁻)
    4. **KMnO₄:** Purple, Mn⁺⁷, strong oxidizing agent
    5. **In acidic medium:** MnO₄⁻ → Mn²⁺ (colorless)
    6. **In neutral:** MnO₄⁻ → MnO₂ (brown ppt)
    7. **Self-indicator:** KMnO₄ in titrations
    8. **Baeyer's test:** KMnO₄ decolorization by alkenes
    9. **K₂Cr₂O₇ is primary standard**, KMnO₄ is not
    10. Both oxidize Fe²⁺ → Fe³⁺ in acidic medium
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_2, sequence_order: 3, required: true)

puts "  ✓ Lesson 6.2: #{lesson_6_2.title}"

# Quiz 6.2
quiz_6_2 = Quiz.create!(
  title: 'Dichromates and Permanganates',
  description: 'Test on K₂Cr₂O₇ and KMnO₄ compounds',
  time_limit_minutes: 35,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_6, item: quiz_6_2, sequence_order: 4, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_6_2,
    question_type: 'mcq',
    question_text: 'What is the color of dichromate ion (Cr₂O₇²⁻) in solution?',
    options: [
      { text: 'Yellow', correct: false },
      { text: 'Orange', correct: true },
      { text: 'Green', correct: false },
      { text: 'Purple', correct: false }
    ],
    explanation: 'Dichromate ion (Cr₂O₇²⁻) is orange in solution. Chromate (CrO₄²⁻) is yellow. When K₂Cr₂O₇ is reduced in acidic medium, it forms green Cr³⁺.',
    points: 1,
    difficulty: -0.5,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'dichromate',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  {
    quiz: quiz_6_2,
    question_type: 'fill_blank',
    question_text: 'In acidic medium, permanganate ion (MnO₄⁻) is reduced to _______ ion.',
    correct_answer: 'Mn2+|Mn²⁺|manganous|manganese(II)',
    explanation: 'In acidic medium (H₂SO₄), MnO₄⁻ (Mn⁺⁷, purple) is reduced to Mn²⁺ (colorless). In neutral medium, it forms MnO₂ (brown ppt).',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'permanganate',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  {
    quiz: quiz_6_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which statements about KMnO₄ are correct?',
    options: [
      { text: 'It is a strong oxidizing agent', correct: true },
      { text: 'It acts as self-indicator in titrations', correct: true },
      { text: 'It is a primary standard', correct: false },
      { text: 'Mn is in +7 oxidation state', correct: true }
    ],
    explanation: 'KMnO₄: (1) Strong oxidizing agent, (2) Self-indicator (purple color), (3) NOT primary standard (decomposes, not 100% pure), (4) Mn in +7 state.',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'permanganate',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  {
    quiz: quiz_6_2,
    question_type: 'true_false',
    question_text: 'The chromyl chloride test is used to detect chloride ions.',
    correct_answer: 'true',
    explanation: 'TRUE. Chromyl chloride test: K₂Cr₂O₇ + NaCl + H₂SO₄ → CrO₂Cl₂ (red vapors). This confirms presence of Cl⁻ ions.',
    points: 1,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'chromyl_chloride',
    skill_dimension: 'recall',
    sequence_order: 4
  },

  {
    quiz: quiz_6_2,
    question_type: 'equation_balance',
    question_text: 'Balance the reaction of KMnO₄ with FeSO₄ in acidic medium:' + "\n" +
                    'KMnO₄ + FeSO₄ + H₂SO₄ → K₂SO₄ + MnSO₄ + Fe₂(SO₄)₃ + H₂O',
    correct_answer: '2 KMnO4 + 10 FeSO4 + 8 H2SO4 -> K2SO4 + 2 MnSO4 + 5 Fe2(SO4)3 + 8 H2O',
    explanation: '2KMnO₄ + 10FeSO₄ + 8H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5Fe₂(SO₄)₃ + 8H₂O. Fe²⁺ oxidized to Fe³⁺, Mn⁺⁷ reduced to Mn²⁺.',
    points: 4,
    difficulty: 1.0,
    discrimination: 1.5,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'redox_reactions',
    skill_dimension: 'problem_solving',
    sequence_order: 5
  },

  {
    quiz: quiz_6_2,
    question_type: 'numerical',
    question_text: 'What is the oxidation state of chromium in K₂Cr₂O₇?',
    correct_answer: '6',
    tolerance: 0.0,
    explanation: 'Let oxidation state of Cr = x. 2(+1) + 2x + 7(-2) = 0, so 2 + 2x - 14 = 0, x = +6.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'oxidation_states',
    skill_dimension: 'calculation',
    sequence_order: 6
  },

  {
    quiz: quiz_6_2,
    question_type: 'mcq',
    question_text: 'Which compound is used as a primary standard in volumetric analysis?',
    options: [
      { text: 'KMnO₄', correct: false },
      { text: 'K₂Cr₂O₇', correct: true },
      { text: 'FeSO₄', correct: false },
      { text: 'Na₂S₂O₃', correct: false }
    ],
    explanation: 'K₂Cr₂O₇ is a primary standard (pure, stable, doesn\'t decompose). KMnO₄ is NOT primary standard (decomposes, contains impurities).',
    points: 2,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'volumetric_analysis',
    skill_dimension: 'recall',
    sequence_order: 7
  }
])

puts "  ✓ Quiz 6.2: #{quiz_6_2.quiz_questions.count} questions"

puts "\n" + "=" * 80
puts "MODULE 6 (PARTIAL) SUMMARY"
puts "=" * 80
puts "✅ Module: #{module_6.title}"
puts "✅ Lessons: 2"
puts "✅ Quizzes: 2"
puts "✅ Total Questions: #{quiz_6_1.quiz_questions.count + quiz_6_2.quiz_questions.count}"
puts "=" * 80
puts "\n"

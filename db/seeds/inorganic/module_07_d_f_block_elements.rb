# frozen_string_literal: true

# ========================================
# IIT JEE Inorganic Chemistry - Module 7
# d-Block and f-Block Elements
# ========================================
# Complete module with lessons and questions
# Covers: Transition elements, electronic configuration, properties, trends, lanthanoids, actinoids
# ========================================

puts "\n" + "=" * 80
puts "MODULE 7: d-BLOCK AND f-BLOCK ELEMENTS"
puts "=" * 80

# Find or create the Inorganic Chemistry course
course = Course.find_or_create_by!(slug: 'iit-jee-inorganic-chemistry') do |c|
  c.title = 'IIT JEE Inorganic Chemistry'
  c.description = 'Comprehensive Inorganic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty = 'advanced'
  c.estimated_hours = 120
  c.published = true
end

# Create Module 7: d-Block and f-Block Elements
module_7 = course.course_modules.find_or_create_by!(slug: 'd-f-block-elements') do |m|
  m.title = 'd-Block and f-Block Elements'
  m.sequence_order = 7
  m.estimated_minutes = 1080  # 18 hours
  m.description = 'Transition elements, inner transition elements, electronic configuration, properties, and trends'
  m.learning_objectives = [
    'Understand electronic configuration of d-block and f-block elements',
    'Master characteristic properties of transition elements',
    'Learn trends in oxidation states, magnetic properties, and colored compounds',
    'Understand lanthanoid and actinoid contraction',
    'Solve IIT JEE problems on d-block and f-block elements',
    'Apply concepts to catalytic properties and complex formation'
  ]
  m.published = true
end

puts "✅ Module 7: #{module_7.title}"

# ========================================
# Lesson 7.1: d-Block Elements - Introduction and Electronic Configuration
# ========================================

lesson_7_1 = CourseLesson.create!(
  title: 'd-Block Elements - Electronic Configuration and General Properties',
  reading_time_minutes: 55,
  key_concepts: ['d-block elements', 'Electronic configuration', 'Transition elements', 'General characteristics', 'Oxidation states'],
  content: <<~MD
    # d-Block Elements: Transition Elements

    ## Introduction

    **d-block elements** are elements in which the last electron enters the d-orbital of the penultimate (second last) shell.

    **Position in Periodic Table:**
    - Groups 3 to 12
    - Four series: 3d, 4d, 5d, and 6d
    - Located between s-block and p-block elements

    ---

    ## Electronic Configuration

    ### General Electronic Configuration
    ```
    (n-1)d¹⁻¹⁰ ns¹⁻²
    ```

    Where:
    - n = outermost shell
    - (n-1) = penultimate shell

    ### 3d Series (Sc to Zn)

    | Element | Atomic No. | Electronic Configuration | Exceptional? |
    |---------|------------|-------------------------|--------------|
    | Sc | 21 | [Ar] 3d¹ 4s² | No |
    | Ti | 22 | [Ar] 3d² 4s² | No |
    | V | 23 | [Ar] 3d³ 4s² | No |
    | Cr | 24 | [Ar] 3d⁵ 4s¹ | ✓ Exception |
    | Mn | 25 | [Ar] 3d⁵ 4s² | No |
    | Fe | 26 | [Ar] 3d⁶ 4s² | No |
    | Co | 27 | [Ar] 3d⁷ 4s² | No |
    | Ni | 28 | [Ar] 3d⁸ 4s² | No |
    | Cu | 29 | [Ar] 3d¹⁰ 4s¹ | ✓ Exception |
    | Zn | 30 | [Ar] 3d¹⁰ 4s² | No |

    **Exceptions:**
    - **Chromium (Cr):** 3d⁵ 4s¹ (not 3d⁴ 4s²)
    - **Copper (Cu):** 3d¹⁰ 4s¹ (not 3d⁹ 4s²)

    **Reason:** Extra stability of half-filled (d⁵) and fully-filled (d¹⁰) orbitals

    ---

    ## Transition Elements vs d-Block Elements

    ### Transition Elements
    **Definition:** Elements with **partially filled d-orbitals** in their ground state or common oxidation states

    **Includes:**
    - Sc to Mn (3d¹ to 3d⁵)
    - Fe to Cu (3d⁶ to 3d¹⁰)

    **Excludes:**
    - **Zinc (Zn):** 3d¹⁰ 4s² → Zn²⁺: 3d¹⁰ (fully filled d-orbitals)
    - **Cd, Hg:** Similar reasons

    **Note:** All transition elements are d-block elements, but not all d-block elements are transition elements

    ---

    ## General Characteristics of Transition Elements

    ### 1. Metallic Character
    - **All are metals**
    - High melting and boiling points (except Zn, Cd, Hg)
    - Good conductors of heat and electricity
    - Hard and strong (due to metallic bonding involving d-electrons)

    ### 2. Atomic and Ionic Radii
    - **Decrease across period** (increasing nuclear charge)
    - Decrease is small compared to s and p block elements
    - **Lanthanoid contraction** affects 5d series

    ### 3. Ionization Enthalpy
    - **Increases gradually** across the period
    - Higher than s-block, lower than p-block elements
    - **Reason:** Effective nuclear charge increases, shielding by d-electrons is less effective

    ### 4. Metallic Character and Density
    - High density (d-electrons contribute to metallic bonding)
    - **Order:** Osmium (Os) > Iridium (Ir) > Platinum (Pt)
    - **Osmium** is the densest element (22.6 g/cm³)

    ---

    ## Variable Oxidation States

    **Key Feature:** Transition elements show **multiple oxidation states**

    ### Reasons:
    1. **Small energy difference** between (n-1)d and ns orbitals
    2. Both d and s electrons can participate in bonding
    3. Different numbers of electrons can be lost

    ### Common Oxidation States (3d Series)

    | Element | Common Oxidation States | Most Stable |
    |---------|------------------------|-------------|
    | Sc | +3 | +3 |
    | Ti | +2, +3, +4 | +4 |
    | V | +2, +3, +4, +5 | +5 |
    | Cr | +2, +3, +6 | +3, +6 |
    | Mn | +2, +3, +4, +6, +7 | +2, +7 |
    | Fe | +2, +3 | +3 |
    | Co | +2, +3 | +2 |
    | Ni | +2, +3, +4 | +2 |
    | Cu | +1, +2 | +2 |
    | Zn | +2 | +2 |

    ### Trends:
    - **Maximum oxidation state** = Group number (up to Mn)
    - **Higher oxidation states** are more common in early transition metals
    - **+2 oxidation state** is most common (loss of 4s² electrons)
    - **Stability of higher oxidation states** decreases across period

    ---

    ## Magnetic Properties

    ### Paramagnetic vs Diamagnetic

    **Paramagnetic:**
    - **Unpaired electrons** present
    - Attracted by magnetic field
    - **Most transition metal compounds** are paramagnetic

    **Diamagnetic:**
    - **No unpaired electrons**
    - Repelled by magnetic field
    - Examples: Zn²⁺ (3d¹⁰), Cu⁺ (3d¹⁰), Sc³⁺ (3d⁰)

    ### Magnetic Moment (μ)

    **Formula:**
    ```
    μ = √[n(n+2)] BM (Bohr Magneton)
    ```

    Where n = number of unpaired electrons

    **Examples:**
    - Fe²⁺ (3d⁶): 4 unpaired electrons → μ = √[4(4+2)] = √24 = 4.9 BM
    - Cu²⁺ (3d⁹): 1 unpaired electron → μ = √[1(1+2)] = √3 = 1.73 BM
    - Zn²⁺ (3d¹⁰): 0 unpaired electrons → μ = 0 BM (diamagnetic)

    ---

    ## Formation of Colored Compounds

    **Most transition metal compounds are colored**

    ### Reason: d-d Transitions
    1. **d-orbitals split** in the presence of ligands (crystal field splitting)
    2. **Electrons absorb visible light** and jump from lower to higher d-orbitals
    3. **Complementary color** is observed

    ### Examples:

    | Compound | Color | Ion | d-electrons |
    |----------|-------|-----|-------------|
    | CuSO₄·5H₂O | Blue | Cu²⁺ | d⁹ |
    | FeSO₄·7H₂O | Green | Fe²⁺ | d⁶ |
    | KMnO₄ | Purple | MnO₄⁻ | d⁰* |
    | K₂Cr₂O₇ | Orange | Cr₂O₇²⁻ | d⁰* |

    *MnO₄⁻ and Cr₂O₇²⁻ are colored due to charge transfer, not d-d transitions

    ### Colorless Compounds:
    - **d⁰ configuration:** Sc³⁺, Ti⁴⁺ (no d-electrons)
    - **d¹⁰ configuration:** Zn²⁺, Cu⁺ (no d-d transitions possible)

    ---

    ## Catalytic Properties

    **Transition metals and their compounds act as excellent catalysts**

    ### Reasons:
    1. **Variable oxidation states** - can accept/donate electrons
    2. **Large surface area** - provide surface for adsorption
    3. **Formation of intermediate compounds** with reactants

    ### Examples:

    | Catalyst | Reaction | Process |
    |----------|----------|---------|
    | Fe | N₂ + 3H₂ → 2NH₃ | Haber process |
    | Ni | Vegetable oil + H₂ → Vanaspati | Hydrogenation |
    | V₂O₅ | 2SO₂ + O₂ → 2SO₃ | Contact process |
    | Pt | 4NH₃ + 5O₂ → 4NO + 6H₂O | Ostwald process |
    | MnO₂ | 2KClO₃ → 2KCl + 3O₂ | Decomposition |

    ---

    ## Complex Formation (Coordination Compounds)

    **Transition metals readily form complexes**

    ### Reasons:
    1. **Small size and high charge** - high charge density
    2. **Availability of vacant d-orbitals** for accepting electron pairs
    3. **Variable oxidation states**

    ### Examples:
    - [Fe(CN)₆]⁴⁻ - Hexacyanoferrate(II)
    - [Cu(NH₃)₄]²⁺ - Tetraamminecopper(II)
    - [Ni(CO)₄] - Nickel tetracarbonyl

    ---

    ## Interstitial Compounds

    **Compounds formed when small atoms (H, B, C, N) occupy interstitial sites in metal lattice**

    ### Properties:
    - **Non-stoichiometric** (variable composition)
    - **Harder than parent metal**
    - **Higher melting point**
    - **Chemically inert**

    ### Examples:
    - TiH₁.₇, VH₀.₅₆
    - TiC, Fe₃C (steel)
    - TiN, Mn₄N

    ---

    ## Alloy Formation

    **Transition metals form alloys with each other and with other metals**

    ### Reason:
    - Similar atomic sizes
    - Similar crystal structures

    ### Important Alloys:
    - **Steel:** Fe + C (+ Cr, Ni, etc.)
    - **Brass:** Cu + Zn
    - **Bronze:** Cu + Sn
    - **Stainless steel:** Fe + Cr + Ni

    ---

    ## IIT JEE Key Points

    1. **Electronic configuration:** (n-1)d¹⁻¹⁰ ns¹⁻²
    2. **Exceptions:** Cr (3d⁵ 4s¹), Cu (3d¹⁰ 4s¹) - half-filled and fully-filled stability
    3. **Zn, Cd, Hg are NOT transition elements** (d¹⁰ configuration)
    4. **Variable oxidation states** due to close energy of ns and (n-1)d orbitals
    5. **Magnetic moment:** μ = √[n(n+2)] BM, where n = unpaired electrons
    6. **Colored compounds:** d-d transitions (except d⁰ and d¹⁰)
    7. **Paramagnetic** if unpaired electrons present
    8. **Good catalysts** due to variable oxidation states
    9. **Maximum oxidation state** = Group number (up to Mn, group 7)
    10. **+2 is most common oxidation state** (loss of ns² electrons)
  MD
)

ModuleItem.create!(course_module: module_7, item: lesson_7_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 7.1: #{lesson_7_1.title}"

# ========================================
# Quiz 7.1: d-Block Elements Basics
# ========================================

quiz_7_1 = Quiz.create!(
  title: 'd-Block Elements - Properties and Configuration',
  description: 'Test your understanding of transition elements, electronic configuration, and general properties',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_7, item: quiz_7_1, sequence_order: 2, required: true)

# Questions for Quiz 7.1
QuizQuestion.create!([
  # Question 1: Electronic configuration
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following electronic configurations is correct for chromium (Cr, Z=24)?',
    options: [
      { text: '[Ar] 3d⁴ 4s²', correct: false },
      { text: '[Ar] 3d⁵ 4s¹', correct: true },
      { text: '[Ar] 3d⁶ 4s⁰', correct: false },
      { text: '[Ar] 3d³ 4s³', correct: false }
    ],
    explanation: 'Chromium has exceptional configuration [Ar] 3d⁵ 4s¹ instead of expected 3d⁴ 4s² due to extra stability of half-filled d-orbital (d⁵).',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'electronic_configuration',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: Transition elements definition
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are NOT considered transition elements?',
    options: [
      { text: 'Zinc (Zn)', correct: true },
      { text: 'Scandium (Sc)', correct: false },
      { text: 'Cadmium (Cd)', correct: true },
      { text: 'Iron (Fe)', correct: false }
    ],
    explanation: 'Zn (3d¹⁰ 4s²) and Cd (4d¹⁰ 5s²) are not transition elements because they have fully filled d-orbitals in both ground state and common oxidation states (+2). Sc and Fe have partially filled d-orbitals.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'transition_elements',
    skill_dimension: 'comprehension',
    sequence_order: 2
  },

  # Question 3: Magnetic moment calculation
  {
    quiz: quiz_7_1,
    question_type: 'numerical',
    question_text: 'Calculate the magnetic moment (in BM) of Fe²⁺ ion (3d⁶ configuration). Use the formula μ = √[n(n+2)] where n = number of unpaired electrons. Round to 1 decimal place.',
    correct_answer: 4.9,
    tolerance: 0.1,
    explanation: 'Fe²⁺ has configuration 3d⁶ with 4 unpaired electrons (↑ ↑ ↑ ↑ ↑↓). Using μ = √[n(n+2)] = √[4(4+2)] = √24 = 4.9 BM.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'magnetic_properties',
    skill_dimension: 'application',
    sequence_order: 3
  },

  # Question 4: Variable oxidation states
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which element shows the maximum number of oxidation states in the 3d series?',
    options: [
      { text: 'Scandium (Sc)', correct: false },
      { text: 'Manganese (Mn)', correct: true },
      { text: 'Iron (Fe)', correct: false },
      { text: 'Zinc (Zn)', correct: false }
    ],
    explanation: 'Manganese shows maximum oxidation states: +2, +3, +4, +6, +7. It can use all seven electrons (3d⁵ 4s²) for bonding. Common examples: Mn²⁺, MnO₂ (+4), MnO₄⁻ (+7).',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'oxidation_states',
    skill_dimension: 'recall',
    sequence_order: 4
  },

  # Question 5: Colored compounds
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following ions is colorless in aqueous solution?',
    options: [
      { text: 'Cu²⁺ (3d⁹)', correct: false },
      { text: 'Fe²⁺ (3d⁶)', correct: false },
      { text: 'Zn²⁺ (3d¹⁰)', correct: true },
      { text: 'Ni²⁺ (3d⁸)', correct: false }
    ],
    explanation: 'Zn²⁺ is colorless because it has d¹⁰ configuration (fully filled d-orbitals). No d-d transitions are possible. Cu²⁺ (blue), Fe²⁺ (green), and Ni²⁺ (green) are colored due to d-d transitions.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'colored_compounds',
    skill_dimension: 'application',
    sequence_order: 5
  },

  # Question 6: Catalytic properties
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which properties make transition metals good catalysts?',
    options: [
      { text: 'Variable oxidation states', correct: true },
      { text: 'Ability to provide large surface area for adsorption', correct: true },
      { text: 'Formation of intermediate compounds', correct: true },
      { text: 'Complete inertness to reactants', correct: false }
    ],
    explanation: 'Transition metals are good catalysts due to: (1) Variable oxidation states - can accept/donate electrons, (2) Large surface area for adsorption, (3) Ability to form intermediates. They are NOT inert - they participate in reaction.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'catalytic_properties',
    skill_dimension: 'comprehension',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 7.1: #{quiz_7_1.title} (#{quiz_7_1.quiz_questions.count} questions)"

# ========================================
# Lesson 7.2: f-Block Elements - Lanthanoids and Actinoids
# ========================================

lesson_7_2 = CourseLesson.create!(
  title: 'f-Block Elements - Lanthanoids and Actinoids',
  reading_time_minutes: 50,
  key_concepts: ['f-block elements', 'Lanthanoids', 'Actinoids', 'Lanthanoid contraction', 'Radioactivity', 'Comparison'],
  content: <<~MD
    # f-Block Elements: Inner Transition Elements

    ## Introduction

    **f-block elements** are elements in which the last electron enters the f-orbital of the ante-penultimate (third last) shell.

    **General Electronic Configuration:**
    ```
    (n-2)f¹⁻¹⁴ (n-1)d⁰⁻¹ ns²
    ```

    **Two Series:**
    1. **Lanthanoids (4f series):** Ce (58) to Lu (71)
    2. **Actinoids (5f series):** Th (90) to Lr (103)

    **Position in Periodic Table:**
    - Placed separately below main periodic table
    - Also called **inner transition elements**

    ---

    ## Lanthanoids (Rare Earth Elements)

    ### Electronic Configuration

    **General configuration:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s²

    | Element | Symbol | Atomic No. | 4f electrons |
    |---------|--------|------------|--------------|
    | Lanthanum | La | 57 | 4f⁰ 5d¹ 6s² |
    | Cerium | Ce | 58 | 4f² 6s² |
    | Praseodymium | Pr | 59 | 4f³ 6s² |
    | Neodymium | Nd | 60 | 4f⁴ 6s² |
    | Promethium | Pm | 61 | 4f⁵ 6s² |
    | Samarium | Sm | 62 | 4f⁶ 6s² |
    | Europium | Eu | 63 | 4f⁷ 6s² |
    | Gadolinium | Gd | 64 | 4f⁷ 5d¹ 6s² |
    | Terbium | Tb | 65 | 4f⁹ 6s² |
    | Dysprosium | Dy | 66 | 4f¹⁰ 6s² |
    | Holmium | Ho | 67 | 4f¹¹ 6s² |
    | Erbium | Er | 68 | 4f¹² 6s² |
    | Thulium | Tm | 69 | 4f¹³ 6s² |
    | Ytterbium | Yb | 70 | 4f¹⁴ 6s² |
    | Lutetium | Lu | 71 | 4f¹⁴ 5d¹ 6s² |

    **Note:** La and Gd have exceptional configurations with one electron in 5d orbital

    ---

    ## Lanthanoid Contraction

    ### Definition
    **Lanthanoid contraction** is the gradual decrease in atomic and ionic radii of lanthanoids with increasing atomic number.

    ### Cause
    1. **Imperfect shielding** by 4f electrons
    2. Nuclear charge increases by +1 at each step
    3. Effective nuclear charge increases
    4. Electrons are pulled closer to nucleus

    **Magnitude:** Total decrease from La³⁺ to Lu³⁺ ≈ 11 pm (0.11 Å)

    ### Consequences of Lanthanoid Contraction

    #### 1. Similarity in Properties
    - Lanthanoids have very similar chemical properties
    - Difficult to separate (ion exchange method used)

    #### 2. Effect on 5d Series
    - Atomic radii of 4d and 5d elements are nearly same
    - Example: Zr (160 pm) ≈ Hf (159 pm)
    - Chemical properties of 4d and 5d elements are similar

    #### 3. Basicity Decrease
    - Basicity of hydroxides decreases from La(OH)₃ to Lu(OH)₃
    - Reason: Ionic radius decreases, covalent character increases

    #### 4. Complex Formation
    - Tendency to form complexes increases
    - Smaller size → Higher charge density → Stronger complexation

    ---

    ## Properties of Lanthanoids

    ### 1. Physical Properties

    **Metallic Character:**
    - All are silvery-white metals
    - Soft, malleable, and ductile
    - Tarnish rapidly in air

    **Melting and Boiling Points:**
    - High melting points (800-1600°C)
    - Lower than d-block transition metals

    ### 2. Oxidation States

    **Most common oxidation state:** +3

    **Reason:**
    - Loss of two 6s electrons and one 4f or 5d electron
    - Ln³⁺ configuration is very stable

    **Some show +2 and +4:**
    - **Eu²⁺ and Yb²⁺:** Extra stability of half-filled (f⁷) and fully-filled (f¹⁴)
    - **Ce⁴⁺ and Tb⁴⁺:** Extra stability of empty (f⁰) and half-filled (f⁷)

    ### 3. Magnetic Properties

    - **All lanthanoid ions are paramagnetic** (except La³⁺ and Lu³⁺)
    - Reason: Unpaired f-electrons
    - **Magnetic moment depends on number of unpaired electrons**

    ### 4. Colored Ions

    - Most Ln³⁺ ions are **colored**
    - Reason: f-f transitions (similar to d-d transitions)
    - **Exceptions:** La³⁺ (f⁰) and Lu³⁺ (f¹⁴) are colorless

    ### 5. Chemical Reactivity

    - **Highly electropositive** (like alkaline earth metals)
    - React with water: 2Ln + 6H₂O → 2Ln(OH)₃ + 3H₂
    - Combine with halogens: 2Ln + 3X₂ → 2LnX₃
    - React with acids: 2Ln + 6H⁺ → 2Ln³⁺ + 3H₂

    ---

    ## Actinoids

    ### Electronic Configuration

    **General configuration:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²

    | Element | Symbol | Atomic No. | Notable |
    |---------|--------|------------|---------|
    | Actinium | Ac | 89 | 5f⁰ 6d¹ 7s² |
    | Thorium | Th | 90 | Natural |
    | Protactinium | Pa | 91 | Natural |
    | Uranium | U | 92 | Natural, fissile |
    | Neptunium | Np | 93 | First transuranium |
    | Plutonium | Pu | 94 | Fissile |
    | Americium | Am | 95 | Transuranic |
    | ... | ... | ... | ... |
    | Lawrencium | Lr | 103 | Last actinoid |

    **Note:**
    - Elements beyond U (92) are **transuranium elements** (all radioactive)
    - Only Th, Pa, and U occur naturally
    - All actinoids are **radioactive**

    ---

    ## Properties of Actinoids

    ### 1. Radioactivity
    - **All actinoids are radioactive**
    - Heavy nuclei undergo radioactive decay
    - Emit α, β, and γ radiations

    ### 2. Oxidation States
    - Show **variable oxidation states**
    - Range: +3 to +7
    - Common: +3, +4, +5, +6

    **Examples:**
    - U: +3, +4, +5, +6
    - Pu: +3, +4, +5, +6
    - Np: +3, +4, +5, +6, +7

    **Greater variability than lanthanoids** (5f orbitals have higher energy)

    ### 3. Actinoid Contraction
    - Similar to lanthanoid contraction
    - Ionic radii decrease across series
    - Due to poor shielding by 5f electrons

    ### 4. Magnetic Properties
    - **Highly paramagnetic**
    - Due to large number of unpaired 5f electrons

    ### 5. Complex Formation
    - **Greater tendency to form complexes** than lanthanoids
    - Due to higher charge and smaller size

    ---

    ## Comparison: Lanthanoids vs Actinoids

    | Property | Lanthanoids | Actinoids |
    |----------|-------------|-----------|
    | **Orbitals filled** | 4f | 5f |
    | **Radioactivity** | Non-radioactive (except Pm) | All radioactive |
    | **Oxidation states** | Mainly +3 | +3, +4, +5, +6, +7 (variable) |
    | **Binding energy** | Higher | Lower |
    | **Magnetic moment** | Lower | Higher |
    | **Complex formation** | Less tendency | Greater tendency |
    | **Occurrence** | Natural (except Pm) | Only Th, Pa, U natural |
    | **Chemical reactivity** | Less reactive | More reactive |
    | **Color intensity** | Less intense | More intense |

    ### Why More Oxidation States in Actinoids?
    - **5f, 6d, and 7s orbitals** have comparable energies
    - All three can participate in bonding
    - **4f orbitals** in lanthanoids are deeply buried (less available)

    ---

    ## Uses of Lanthanoids and Actinoids

    ### Lanthanoids:
    1. **Mixed oxide catalysts:** Petroleum cracking
    2. **Glass industry:** Coloring and polishing
    3. **Phosphors:** Television screens, LEDs
    4. **Magnets:** NdFeB (neodymium) magnets - strongest permanent magnets
    5. **Nuclear reactors:** Control rods (Gd, Sm absorb neutrons)
    6. **Steel making:** Improve properties

    ### Actinoids:
    1. **Nuclear fuel:** U-235, Pu-239 (fission reactions)
    2. **Nuclear weapons:** Pu-239
    3. **Radiotherapy:** Cancer treatment
    4. **Smoke detectors:** Am-241
    5. **Research:** Radioisotopes for dating, tracing

    ---

    ## IIT JEE Key Points

    1. **Lanthanoids:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s², **Actinoids:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²
    2. **Lanthanoid contraction:** Gradual decrease in size due to poor shielding by 4f
    3. **Consequence:** 4d and 5d elements have similar sizes and properties
    4. **Lanthanoids:** Mainly +3 oxidation state
    5. **Actinoids:** Variable oxidation states (+3 to +7), all radioactive
    6. **Actinoids show more oxidation states** because 5f, 6d, 7s have comparable energies
    7. **Complex formation:** Actinoids > Lanthanoids
    8. **La³⁺ and Lu³⁺ are colorless** (f⁰ and f¹⁴ respectively)
    9. **Only Th, Pa, U occur naturally** among actinoids
    10. **Transuranium elements** (Z > 92) are all synthetic and radioactive
  MD
)

ModuleItem.create!(course_module: module_7, item: lesson_7_2, sequence_order: 3, required: true)

puts "  ✓ Lesson 7.2: #{lesson_7_2.title}"

# ========================================
# Quiz 7.2: f-Block Elements
# ========================================

quiz_7_2 = Quiz.create!(
  title: 'f-Block Elements - Lanthanoids and Actinoids',
  description: 'Test your knowledge of inner transition elements, lanthanoid contraction, and actinoid properties',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_7, item: quiz_7_2, sequence_order: 4, required: true)

# Questions for Quiz 7.2
QuizQuestion.create!([
  # Question 1: Lanthanoid contraction
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Lanthanoid contraction is caused by:',
    options: [
      { text: 'Perfect shielding by 4f electrons', correct: false },
      { text: 'Imperfect shielding by 4f electrons', correct: true },
      { text: 'Complete absence of 4f electrons', correct: false },
      { text: 'Large size of lanthanoid atoms', correct: false }
    ],
    explanation: 'Lanthanoid contraction occurs due to imperfect/poor shielding by 4f electrons. As nuclear charge increases, effective nuclear charge increases, pulling electrons closer.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'lanthanoid_contraction',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: Consequences of lanthanoid contraction
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which are consequences of lanthanoid contraction?',
    options: [
      { text: 'Similarity in properties of lanthanoids', correct: true },
      { text: 'Similar atomic radii of 4d and 5d elements', correct: true },
      { text: 'Increase in basicity from La(OH)₃ to Lu(OH)₃', correct: false },
      { text: 'Increased tendency to form complexes', correct: true }
    ],
    explanation: 'Lanthanoid contraction causes: (1) Similar properties of lanthanoids, (2) Similar sizes of 4d and 5d elements (Zr≈Hf), (3) Decreased basicity (not increase), (4) Increased complex formation.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'lanthanoid_contraction',
    skill_dimension: 'comprehension',
    sequence_order: 2
  },

  # Question 3: Oxidation states
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'The most common oxidation state of lanthanoids is:',
    options: [
      { text: '+2', correct: false },
      { text: '+3', correct: true },
      { text: '+4', correct: false },
      { text: '+5', correct: false }
    ],
    explanation: 'Most common oxidation state of lanthanoids is +3 (Ln³⁺). This results from loss of two 6s electrons and one 4f/5d electron. Some show +2 (Eu, Yb) or +4 (Ce, Tb) due to stability of specific f-configurations.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'oxidation_states',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  # Question 4: Actinoids vs Lanthanoids
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why do actinoids show greater range of oxidation states compared to lanthanoids?',
    options: [
      { text: 'Actinoids have smaller atomic size', correct: false },
      { text: '5f, 6d, and 7s orbitals have comparable energies', correct: true },
      { text: 'Actinoids have no radioactivity', correct: false },
      { text: '4f orbitals are more available for bonding', correct: false }
    ],
    explanation: 'Actinoids show oxidation states from +3 to +7 because 5f, 6d, and 7s orbitals have comparable energies and can all participate in bonding. In lanthanoids, 4f orbitals are deeply buried and less available.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'hard',
    topic: 'actinoids_vs_lanthanoids',
    skill_dimension: 'comprehension',
    sequence_order: 4
  },

  # Question 5: Colorless ions
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which lanthanoid ions are colorless?',
    options: [
      { text: 'La³⁺ (f⁰)', correct: true },
      { text: 'Ce³⁺ (f¹)', correct: false },
      { text: 'Eu³⁺ (f⁶)', correct: false },
      { text: 'Lu³⁺ (f¹⁴)', correct: true }
    ],
    explanation: 'La³⁺ (f⁰) and Lu³⁺ (f¹⁴) are colorless because they have no f-electrons or fully-filled f-orbitals. No f-f transitions are possible. Other Ln³⁺ ions are colored due to f-f transitions.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'colored_ions',
    skill_dimension: 'application',
    sequence_order: 5
  },

  # Question 6: Natural occurrence
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'How many actinoids occur naturally in significant amounts?',
    options: [
      { text: 'None', correct: false },
      { text: 'Three (Th, Pa, U)', correct: true },
      { text: 'All 15 actinoids', correct: false },
      { text: 'Only Uranium', correct: false }
    ],
    explanation: 'Only three actinoids occur naturally: Thorium (Th), Protactinium (Pa), and Uranium (U). All other actinoids are synthetic. Elements beyond U (Z>92) are transuranium elements.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'actinoid_occurrence',
    skill_dimension: 'recall',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 7.2: #{quiz_7_2.title} (#{quiz_7_2.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 7 COMPLETE: d-Block and f-Block Elements"
puts "Total Lessons: 2"
puts "Total Quizzes: 2"
puts "Total Questions: #{QuizQuestion.where(quiz_id: [quiz_7_1.id, quiz_7_2.id]).count}"
puts "=" * 80

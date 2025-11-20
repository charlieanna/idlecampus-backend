# frozen_string_literal: true

# ========================================
# IIT JEE Organic Chemistry - Module 9
# Haloalkanes and Haloarenes
# ========================================
# Complete module with lessons and questions
# Covers: Nomenclature, preparation, properties, reactions, SN1, SN2, elimination
# ========================================

puts "\n" + "=" * 80
puts "MODULE 9: HALOALKANES AND HALOARENES"
puts "=" * 80

# Find or create the Organic Chemistry course
course = Course.find_or_create_by!(slug: 'iit-jee-organic-chemistry') do |c|
  c.title = 'IIT JEE Organic Chemistry'
  c.description = 'Comprehensive Organic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty = 'advanced'
  c.estimated_hours = 150
  c.published = true
end

# Create Module 9: Haloalkanes and Haloarenes
module_9 = course.course_modules.find_or_create_by!(slug: 'haloalkanes-haloarenes') do |m|
  m.title = 'Haloalkanes and Haloarenes'
  m.sequence_order = 9
  m.estimated_minutes = 960  # 16 hours
  m.description = 'Halogen-containing organic compounds: nomenclature, preparation, properties, and reaction mechanisms'
  m.learning_objectives = [
    'Master nomenclature of haloalkanes and haloarenes',
    'Understand preparation methods from alcohols and alkenes',
    'Learn nucleophilic substitution mechanisms (SN1 and SN2)',
    'Understand elimination reactions (E1 and E2)',
    'Compare reactivity of different halogen compounds',
    'Solve IIT JEE problems on reaction mechanisms and products'
  ]
  m.published = true
end

puts "✅ Module 9: #{module_9.title}"

# ========================================
# Lesson 9.1: Haloalkanes - Nomenclature, Classification, and Preparation
# ========================================

lesson_9_1 = CourseLesson.create!(
  title: 'Haloalkanes - Classification, Nomenclature, and Preparation',
  reading_time_minutes: 60,
  key_concepts: ['Haloalkanes', 'Classification', 'IUPAC nomenclature', 'Preparation methods', 'From alcohols', 'Halogenation'],
  content: <<~MD
    # Haloalkanes (Alkyl Halides)

    ## Introduction

    **Haloalkanes** are organic compounds in which one or more hydrogen atoms of an alkane are replaced by halogen atoms (F, Cl, Br, I).

    **General formula:** R-X (where X = F, Cl, Br, I)

    **Examples:**
    - CH₃Cl (Methyl chloride)
    - CH₃CH₂Br (Ethyl bromide)
    - CH₃CHBrCH₃ (Isopropyl bromide)

    ---

    ## Classification of Haloalkanes

    ### 1. Based on Number of Halogen Atoms

    #### Mono-haloalkanes (1 halogen)
    - CH₃Cl (Chloromethane)
    - CH₃CH₂Br (Bromoethane)

    #### Di-haloalkanes (2 halogens)
    - CH₂Cl₂ (Dichloromethane)
    - CH₂Br-CH₂Br (1,2-Dibromoethane)

    **Geminal dihalides:** Two halogens on same carbon (CH₃CHCl₂)
    **Vicinal dihalides:** Two halogens on adjacent carbons (CH₂Cl-CH₂Cl)

    #### Tri-haloalkanes (3 halogens)
    - CHCl₃ (Chloroform)
    - CH₃CCl₃ (1,1,1-Trichloroethane)

    #### Tetra-haloalkanes (4 halogens)
    - CCl₄ (Carbon tetrachloride)

    ### 2. Based on Carbon Bearing Halogen

    #### Primary (1°) Haloalkanes
    - Halogen attached to **primary carbon** (carbon bonded to one other carbon)
    - **Example:** CH₃CH₂-Cl (Ethyl chloride)

    ```
    CH₃-CH₂-X
         ↑
      Primary carbon
    ```

    #### Secondary (2°) Haloalkanes
    - Halogen attached to **secondary carbon** (carbon bonded to two other carbons)
    - **Example:** CH₃-CHCl-CH₃ (Isopropyl chloride)

    ```
         CH₃
         |
    CH₃-CH-X
         ↑
      Secondary carbon
    ```

    #### Tertiary (3°) Haloalkanes
    - Halogen attached to **tertiary carbon** (carbon bonded to three other carbons)
    - **Example:** (CH₃)₃C-Cl (tert-Butyl chloride)

    ```
         CH₃
         |
    CH₃-C-X
         |
         CH₃
         ↑
      Tertiary carbon
    ```

    **Reactivity order (SN1):** 3° > 2° > 1°
    **Reactivity order (SN2):** 1° > 2° > 3°

    ---

    ## IUPAC Nomenclature

    ### Rules:
    1. **Select longest carbon chain** containing halogen
    2. **Number the chain** to give halogen lowest number
    3. **Name halogens** as prefixes: fluoro-, chloro-, bromo-, iodo-
    4. **Alphabetical order** if multiple halogens
    5. **Use di-, tri-, tetra-** for multiple identical halogens

    ### Examples:

    | Structure | IUPAC Name | Common Name |
    |-----------|------------|-------------|
    | CH₃Cl | Chloromethane | Methyl chloride |
    | CH₃CH₂Br | Bromoethane | Ethyl bromide |
    | CH₃CHClCH₃ | 2-Chloropropane | Isopropyl chloride |
    | (CH₃)₃CBr | 2-Bromo-2-methylpropane | tert-Butyl bromide |
    | CH₂Cl₂ | Dichloromethane | Methylene chloride |
    | CHCl₃ | Trichloromethane | Chloroform |
    | CCl₄ | Tetrachloromethane | Carbon tetrachloride |
    | CH₂=CHCl | Chloroethene | Vinyl chloride |

    **Practice:**
    - CH₃CH₂CH₂Cl → 1-Chloropropane (n-Propyl chloride)
    - CH₃CHBrCH₂CH₃ → 2-Bromobutane (sec-Butyl bromide)
    - CH₂Br-CH₂Br → 1,2-Dibromoethane (Ethylene dibromide)

    ---

    ## Physical Properties

    ### 1. State and Odor
    - **C1-C5:** Gases or volatile liquids
    - **C6-C18:** Liquids
    - **>C18:** Solids
    - Sweet-smelling (but toxic!)

    ### 2. Boiling Point

    **Factors affecting boiling point:**

    #### Effect of Halogen
    ```
    R-I > R-Br > R-Cl > R-F
    (Increasing molecular weight and van der Waals forces)
    ```

    #### Effect of Chain Length
    - **Longer chain → Higher boiling point**
    - More surface area → stronger van der Waals forces

    #### Effect of Branching
    - **More branching → Lower boiling point**
    - Less surface contact

    **Example:**
    - n-Butyl chloride (78°C) > Isobutyl chloride (69°C) > tert-Butyl chloride (51°C)

    ### 3. Solubility
    - **Insoluble in water** (non-polar, cannot form H-bonds)
    - **Soluble in organic solvents** (like dissolves like)
    - Heavier than water (except some fluoroalkanes)

    ### 4. Density
    - **Increases with:** Molecular weight, number of halogens
    - **Order:** R-I > R-Br > R-Cl > R-F

    ---

    ## Preparation of Haloalkanes

    ### Method 1: From Alcohols (Most Important)

    #### (a) With Halogen Acids (HX)
    ```
    R-OH + HX → R-X + H₂O
    ```

    **Reactivity order:**
    ```
    HI > HBr > HCl >> HF
    (Increasing acid strength and nucleophilicity)
    ```

    **With alcohols:**
    ```
    3° > 2° > 1° (ease of reaction)
    ```

    **Examples:**
    - CH₃CH₂OH + HBr → CH₃CH₂Br + H₂O
    - (CH₃)₃COH + HCl → (CH₃)₃CCl + H₂O (fast)

    **Mechanism:** 1° alcohols - SN2, 3° alcohols - SN1

    #### (b) With Phosphorus Halides
    **With PCl₅:**
    ```
    R-OH + PCl₅ → R-Cl + POCl₃ + HCl
    ```

    **With PCl₃:**
    ```
    3 R-OH + PCl₃ → 3 R-Cl + H₃PO₃
    ```

    **With PBr₃:**
    ```
    3 R-OH + PBr₃ → 3 R-Br + H₃PO₃
    ```

    **Advantage:** Works well with all types of alcohols

    #### (c) With Thionyl Chloride (SOCl₂) - Best Method
    ```
    R-OH + SOCl₂ → R-Cl + SO₂↑ + HCl↑
    ```

    **Advantages:**
    - Byproducts are gases (SO₂, HCl) - easy to remove
    - **Purest product obtained**
    - Works for all alcohols

    ### Method 2: Halogenation of Alkanes
    ```
    R-H + X₂ --[UV light or heat]--> R-X + HX
    ```

    **Free radical mechanism:**
    ```
    Initiation: X₂ --[UV]--> 2X·
    Propagation: R-H + X· → R· + HX
                 R· + X₂ → R-X + X·
    Termination: R· + R· → R-R
                 X· + X· → X₂
                 R· + X· → R-X
    ```

    **Reactivity order:**
    ```
    F₂ > Cl₂ > Br₂ > I₂
    ```

    **Limitation:** Mixture of products (all possible isomers)

    ### Method 3: Addition to Alkenes

    #### (a) Addition of HX (Markovnikov)
    ```
    R-CH=CH₂ + HX → R-CHX-CH₃
    ```

    **Markovnikov's rule:** H goes to carbon with more H atoms

    **Example:**
    ```
    CH₃-CH=CH₂ + HBr → CH₃-CHBr-CH₃ (major)
    ```

    #### (b) Addition of X₂
    ```
    R-CH=CH₂ + X₂ → R-CHX-CH₂X (vicinal dihalide)
    ```

    **Example:**
    ```
    CH₂=CH₂ + Br₂ → CH₂Br-CH₂Br (1,2-dibromoethane)
    ```

    ### Method 4: Hunsdiecker Reaction
    ```
    R-COOAg + Br₂ → R-Br + CO₂ + AgBr
    ```

    **Used to:** Reduce carbon chain by one carbon

    ### Method 5: Swarts Reaction (Fluorination)
    ```
    R-Cl + AgF → R-F + AgCl
    or
    R-Cl + SbF₃ → R-F + SbCl₃
    ```

    **Used specifically for:** Preparing fluoroalkanes

    ---

    ## IIT JEE Key Points

    1. **Classification:** 1°, 2°, 3° based on carbon bearing halogen
    2. **Nomenclature:** Halogens as prefixes (chloro-, bromo-, iodo-)
    3. **Boiling point order:** R-I > R-Br > R-Cl > R-F
    4. **Reactivity with HX:** 3° > 2° > 1° (carbocation stability)
    5. **Best method from alcohols:** SOCl₂ (gaseous byproducts)
    6. **Halogenation:** Free radical mechanism, mixture of products
    7. **Addition to alkenes:** Markovnikov's rule for HX
    8. **Geminal:** Same carbon, **Vicinal:** Adjacent carbons
    9. **Swarts reaction:** For fluoroalkanes (R-Cl + AgF)
    10. **Insoluble in water** but soluble in organic solvents
  MD
)

ModuleItem.create!(course_module: module_9, item: lesson_9_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 9.1: #{lesson_9_1.title}"

# ========================================
# Quiz 9.1: Haloalkanes Basics
# ========================================

quiz_9_1 = Quiz.create!(
  title: 'Haloalkanes - Classification and Preparation',
  description: 'Test your understanding of haloalkane nomenclature, classification, and preparation methods',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_9, item: quiz_9_1, sequence_order: 2, required: true)

# Questions for Quiz 9.1
QuizQuestion.create!([
  # Question 1: Classification
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following is a secondary (2°) haloalkane?',
    options: [
      { text: 'CH₃CH₂CH₂Cl', correct: false },
      { text: 'CH₃CHClCH₃', correct: true },
      { text: '(CH₃)₃CCl', correct: false },
      { text: 'CH₃Cl', correct: false }
    ],
    explanation: 'CH₃CHClCH₃ is 2-chloropropane, a secondary haloalkane (Cl on carbon bonded to 2 other carbons). Option A is 1°, option C is 3°, option D is methyl halide.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'classification',
    skill_dimension: 'application',
    sequence_order: 1
  },

  # Question 2: Boiling point
  {
    quiz: quiz_9_2,
    question_type: 'sequence',
    question_text: 'Arrange the following in order of INCREASING boiling point: (1) CH₃F (2) CH₃Cl (3) CH₃Br (4) CH₃I',
    sequence_items: [
      { id: 1, text: 'CH₃F (Fluoromethane)' },
      { id: 2, text: 'CH₃Cl (Chloromethane)' },
      { id: 3, text: 'CH₃Br (Bromomethane)' },
      { id: 4, text: 'CH₃I (Iodomethane)' }
    ],
    explanation: 'Boiling point increases with molecular weight and van der Waals forces: CH₃F < CH₃Cl < CH₃Br < CH₃I. Iodine is largest, so CH₃I has highest boiling point.',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.2,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'physical_properties',
    skill_dimension: 'application',
    sequence_order: 2
  },

  # Question 3: Preparation from alcohols
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which reagent gives the PUREST alkyl chloride from an alcohol?',
    options: [
      { text: 'HCl + ZnCl₂', correct: false },
      { text: 'PCl₅', correct: false },
      { text: 'SOCl₂ (Thionyl chloride)', correct: true },
      { text: 'PCl₃', correct: false }
    ],
    explanation: 'SOCl₂ gives purest product because byproducts (SO₂, HCl) are gases and escape, leaving pure alkyl chloride. Reaction: R-OH + SOCl₂ → R-Cl + SO₂↑ + HCl↑',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'preparation_methods',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  # Question 4: Geminal vs Vicinal
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which compound is a vicinal dihalide?',
    options: [
      { text: 'CH₂Cl₂ (Dichloromethane)', correct: false },
      { text: 'CH₃CHCl₂ (1,1-Dichloroethane)', correct: false },
      { text: 'CH₂Cl-CH₂Cl (1,2-Dichloroethane)', correct: true },
      { text: 'CCl₄ (Carbon tetrachloride)', correct: false }
    ],
    explanation: 'Vicinal dihalides have two halogens on adjacent carbons. CH₂Cl-CH₂Cl is 1,2-dichloroethane (vicinal). CH₃CHCl₂ is geminal (same carbon). CH₂Cl₂ has only one carbon.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'classification',
    skill_dimension: 'comprehension',
    sequence_order: 4
  },

  # Question 5: Halogenation mechanism
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which statements about free radical halogenation of alkanes are correct?',
    options: [
      { text: 'Requires UV light or heat for initiation', correct: true },
      { text: 'Proceeds through carbocation intermediate', correct: false },
      { text: 'Gives mixture of products', correct: true },
      { text: 'Reactivity: F₂ > Cl₂ > Br₂ > I₂', correct: true }
    ],
    explanation: 'Free radical halogenation: (1) Needs UV/heat ✓, (2) Free radical mechanism (not carbocation) ✓, (3) Gives product mixture ✓, (4) Reactivity F₂ > Cl₂ > Br₂ > I₂ ✓.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'halogenation',
    skill_dimension: 'comprehension',
    sequence_order: 5
  },

  # Question 6: Swarts reaction
  {
    quiz: quiz_9_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Swarts reaction is used for the preparation of:',
    options: [
      { text: 'Chloroalkanes', correct: false },
      { text: 'Bromoalkanes', correct: false },
      { text: 'Fluoroalkanes', correct: true },
      { text: 'Iodoalkanes', correct: false }
    ],
    explanation: 'Swarts reaction specifically prepares fluoroalkanes: R-Cl + AgF → R-F + AgCl or R-Cl + SbF₃ → R-F + SbCl₃. Named after Belgian chemist Frédéric Swarts.',
    points: 2,
    difficulty: -0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'preparation_methods',
    skill_dimension: 'recall',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 9.1: #{quiz_9_1.title} (#{quiz_9_1.quiz_questions.count} questions)"

# ========================================
# Lesson 9.2: Nucleophilic Substitution Reactions (SN1 and SN2)
# ========================================

lesson_9_2 = CourseLesson.create!(
  title: 'Nucleophilic Substitution - SN1 and SN2 Mechanisms',
  reading_time_minutes: 70,
  key_concepts: ['Nucleophilic substitution', 'SN1 mechanism', 'SN2 mechanism', 'Stereochemistry', 'Factors affecting reactivity'],
  content: <<~MD
    # Nucleophilic Substitution Reactions

    ## Introduction

    **Nucleophilic substitution** is a reaction where a nucleophile (Nu⁻) replaces a leaving group (X⁻) in a molecule.

    **General reaction:**
    ```
    R-X + Nu⁻ → R-Nu + X⁻
    ```

    **Two major mechanisms:**
    1. **SN1:** Substitution, Nucleophilic, Unimolecular
    2. **SN2:** Substitution, Nucleophilic, Bimolecular

    ---

    ## SN2 Mechanism (Bimolecular)

    ### Characteristics

    **S** = Substitution
    **N** = Nucleophilic
    **2** = Second order kinetics (depends on both [R-X] and [Nu⁻])

    ### Mechanism (One-Step)

    ```
    Nu⁻ + R-X → [Nu---R---X]‡ → Nu-R + X⁻
              Transition state
    ```

    **Key features:**
    - **Single step** (no intermediate)
    - **Transition state** with partial bonds
    - **Concerted mechanism** (bond making and breaking simultaneous)

    ### Rate Equation
    ```
    Rate = k[R-X][Nu⁻]
    ```

    **Second order:** Depends on concentration of both reactants

    ### Stereochemistry: Inversion of Configuration

    **Walden Inversion:** Complete inversion of stereochemistry

    ```
         Nu⁻
          ↓
    a     |     c           c     |     a
     \    |    /             \    |    /
      \   |   /     SN2       \   |   /
       C--X        →           C--Nu
      /         /             /         \
     b         b

    (R) configuration  →  (S) configuration
    ```

    **Example:**
    ```
    (R)-2-bromobutane + OH⁻ → (S)-2-butanol
    ```

    **100% inversion of configuration**

    ### Factors Affecting SN2 Rate

    #### 1. Structure of Alkyl Halide

    **Steric hindrance is crucial:**

    ```
    Methyl > 1° > 2° >> 3° (cannot occur)

    CH₃-X > R-CH₂-X > R₂CH-X >> R₃C-X
    (fastest)                    (no reaction)
    ```

    **Reason:** Backside attack is hindered by bulky groups

    **Examples:**
    - CH₃Br: Very fast (no steric hindrance)
    - CH₃CH₂Br: Fast (1°, little hindrance)
    - (CH₃)₂CHBr: Slow (2°, moderate hindrance)
    - (CH₃)₃CBr: No SN2 (3°, too hindered)

    #### 2. Nature of Nucleophile

    **Stronger nucleophile → Faster reaction**

    **Nucleophilicity order (in protic solvents):**
    ```
    I⁻ > Br⁻ > Cl⁻ > F⁻ (opposite of basicity)
    RS⁻ > RO⁻
    CN⁻ > I⁻ > OH⁻ > N₃⁻ > Br⁻ > Cl⁻ > F⁻ > H₂O
    ```

    **In protic solvents:** Larger nucleophile = less solvated = more nucleophilic

    #### 3. Nature of Leaving Group

    **Better leaving group → Faster reaction**

    **Leaving group ability:**
    ```
    I⁻ > Br⁻ > Cl⁻ >> F⁻
    (weak base = good leaving group)
    ```

    #### 4. Solvent

    **Polar aprotic solvents favor SN2**
    - Examples: DMSO, DMF, acetone, acetonitrile
    - Do not solvate nucleophile strongly
    - Nucleophile remains "naked" and reactive

    **Polar protic solvents slow SN2**
    - Examples: H₂O, ROH
    - Solvate and stabilize nucleophile
    - Reduces nucleophilicity

    ---

    ## SN1 Mechanism (Unimolecular)

    ### Characteristics

    **S** = Substitution
    **N** = Nucleophilic
    **1** = First order kinetics (depends only on [R-X])

    ### Mechanism (Two-Step)

    **Step 1: Ionization (slow, rate-determining)**
    ```
    R-X → R⁺ + X⁻  (slow)
    ```

    **Step 2: Nucleophilic attack (fast)**
    ```
    R⁺ + Nu⁻ → R-Nu  (fast)
    ```

    **Key features:**
    - **Two steps**
    - **Carbocation intermediate** formed
    - **Rate-determining step:** Formation of carbocation

    ### Rate Equation
    ```
    Rate = k[R-X]
    ```

    **First order:** Depends only on [R-X], NOT on [Nu⁻]

    ### Stereochemistry: Racemization

    **Carbocation is sp² hybridized (planar)**

    ```
         R₁
          |
    R₂---C⁺   (planar, sp²)
          |
         R₃
    ```

    **Nucleophile can attack from either side:**
    - 50% from top → Retention of configuration
    - 50% from bottom → Inversion of configuration

    **Result: Racemic mixture (50:50 mixture of enantiomers)**

    **Example:**
    ```
    (R)-2-bromobutane + H₂O → (R)-2-butanol (50%) + (S)-2-butanol (50%)
    ```

    ### Factors Affecting SN1 Rate

    #### 1. Structure of Alkyl Halide

    **Carbocation stability is crucial:**

    ```
    3° > 2° > 1° > Methyl

    R₃C-X > R₂CH-X > R-CH₂-X >> CH₃-X
    (fastest)                    (no reaction)
    ```

    **Carbocation stability order:**
    ```
    3° > 2° > 1° > CH₃⁺

    Resonance-stabilized > 3° > 2° > 1°
    ```

    **Examples of resonance-stabilized:**
    - Allyl: CH₂=CH-CH₂⁺ (resonance)
    - Benzyl: C₆H₅-CH₂⁺ (resonance with ring)

    #### 2. Nature of Leaving Group

    **Same as SN2:** I⁻ > Br⁻ > Cl⁻ >> F⁻

    #### 3. Solvent

    **Polar protic solvents favor SN1**
    - Examples: H₂O, ROH
    - Stabilize carbocation and leaving group by solvation
    - SN1 rate increases in polar protic solvents

    #### 4. Nature of Nucleophile

    **Does NOT affect rate** (not involved in rate-determining step)
    - But affects product distribution

    ---

    ## Comparison: SN1 vs SN2

    | Property | SN1 | SN2 |
    |----------|-----|-----|
    | **Mechanism** | Two-step (carbocation) | One-step (concerted) |
    | **Rate equation** | Rate = k[R-X] | Rate = k[R-X][Nu⁻] |
    | **Order** | First order | Second order |
    | **Intermediate** | Carbocation (sp²) | Transition state |
    | **Stereochemistry** | Racemization (±) | Inversion (Walden) |
    | **Alkyl halide** | 3° > 2° >> 1° | 1° > 2° >> 3° |
    | **Nucleophile** | Weak OK | Strong required |
    | **Solvent** | Polar protic | Polar aprotic |
    | **Rearrangement** | Possible (via carbocation) | Not possible |

    ---

    ## Important Reactions of Haloalkanes

    ### 1. Hydrolysis (with OH⁻ or H₂O)
    ```
    R-X + OH⁻ → R-OH + X⁻  (SN2 for 1°)
    R-X + H₂O → R-OH + HX  (SN1 for 3°)
    ```

    ### 2. Reaction with Alkoxide (Williamson Ether Synthesis)
    ```
    R-X + R'O⁻ → R-O-R' + X⁻  (SN2)
    ```

    **Best with 1° alkyl halides and alkoxide**

    ### 3. Reaction with Cyanide (CN⁻)
    ```
    R-X + CN⁻ → R-CN + X⁻  (SN2)
    ```

    **Chain extension by one carbon**

    ### 4. Reaction with Ammonia
    ```
    R-X + NH₃ → R-NH₂ + HX
    ```

    **Excess NH₃ used to prevent multiple substitutions**

    ### 5. Reaction with AgCN
    ```
    R-X + AgCN → R-NC + AgX  (isocyanide)
    ```

    **KCN gives nitrile, AgCN gives isonitrile**

    ### 6. Reduction
    ```
    R-X + Zn + H⁺ → R-H + ZnX₂
    or
    R-X + LiAlH₄ → R-H + LiX + AlH₃
    ```

    ---

    ## Carbocation Rearrangements in SN1

    **Carbocations can rearrange to more stable forms via:**

    ### 1. Hydride Shift (H⁻ migration)
    ```
    CH₃-CH-CH₂⁺-CH₃  →  CH₃-C⁺-CH₂-CH₃
        |                     |
        CH₃                   CH₃

    (2° carbocation)      (3° carbocation - more stable)
    ```

    ### 2. Methyl Shift (CH₃⁻ migration)
    ```
    (CH₃)₂CH-CH₂⁺  →  (CH₃)₂C⁺-CH₃

    (1° carbocation)   (3° carbocation)
    ```

    **Driving force:** Formation of more stable carbocation

    ---

    ## IIT JEE Key Points

    1. **SN2:** One-step, inversion, 1° > 2° >> 3°, polar aprotic solvent
    2. **SN1:** Two-step, racemization, 3° > 2° >> 1°, polar protic solvent
    3. **Carbocation stability:** 3° > 2° > 1° > CH₃⁺, resonance > 3°
    4. **Walden inversion:** Complete stereochemical inversion in SN2
    5. **Leaving group ability:** I⁻ > Br⁻ > Cl⁻ >> F⁻
    6. **Nucleophilicity (protic):** I⁻ > Br⁻ > Cl⁻ > F⁻
    7. **Rearrangements** possible in SN1 (not in SN2)
    8. **Williamson ether synthesis:** R-X + R'O⁻ (SN2, use 1° halide)
    9. **KCN gives nitrile** (R-CN), **AgCN gives isonitrile** (R-NC)
    10. **Rate (SN2) = k[R-X][Nu⁻]**, **Rate (SN1) = k[R-X]**
  MD
)

ModuleItem.create!(course_module: module_9, item: lesson_9_2, sequence_order: 3, required: true)

puts "  ✓ Lesson 9.2: #{lesson_9_2.title}"

# ========================================
# Quiz 9.2: SN1 and SN2 Mechanisms
# ========================================

quiz_9_2 = Quiz.create!(
  title: 'Nucleophilic Substitution - SN1 and SN2',
  description: 'Test your understanding of substitution mechanisms, stereochemistry, and reactivity',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_9, item: quiz_9_2, sequence_order: 4, required: true)

# Questions for Quiz 9.2
QuizQuestion.create!([
  # Question 1: SN2 reactivity order
  {
    quiz: quiz_9_2,
    question_type: 'sequence',
    question_text: 'Arrange the following alkyl bromides in order of INCREASING SN2 reactivity: (1) CH₃Br (2) (CH₃)₂CHBr (3) CH₃CH₂Br (4) (CH₃)₃CBr',
    sequence_items: [
      { id: 4, text: '(CH₃)₃CBr (tert-Butyl bromide)' },
      { id: 2, text: '(CH₃)₂CHBr (Isopropyl bromide)' },
      { id: 3, text: 'CH₃CH₂Br (Ethyl bromide)' },
      { id: 1, text: 'CH₃Br (Methyl bromide)' }
    ],
    explanation: 'SN2 reactivity: Methyl > 1° > 2° >> 3°. Steric hindrance decreases rate. Order: (CH₃)₃CBr < (CH₃)₂CHBr < CH₃CH₂Br < CH₃Br. Tertiary halides cannot undergo SN2.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.4,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'sn2_reactivity',
    skill_dimension: 'application',
    sequence_order: 1
  },

  # Question 2: SN1 vs SN2
  {
    quiz: quiz_9_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which statements correctly describe SN1 mechanism?',
    options: [
      { text: 'Proceeds through carbocation intermediate', correct: true },
      { text: 'Shows complete inversion of configuration', correct: false },
      { text: 'Rate = k[R-X] (first order)', correct: true },
      { text: 'Favored by polar aprotic solvents', correct: false }
    ],
    explanation: 'SN1: (1) Carbocation intermediate ✓, (2) Racemization (not inversion) ✓, (3) First order ✓, (4) Favored by polar PROTIC solvents (not aprotic) ✓.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'sn1_mechanism',
    skill_dimension: 'comprehension',
    sequence_order: 2
  },

  # Question 3: Stereochemistry
  {
    quiz: quiz_9_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the stereochemical outcome of SN2 reaction on an optically active alkyl halide?',
    options: [
      { text: 'Retention of configuration', correct: false },
      { text: 'Racemization', correct: false },
      { text: 'Inversion of configuration', correct: true },
      { text: 'No change in stereochemistry', correct: false }
    ],
    explanation: 'SN2 shows Walden inversion - complete inversion of configuration. (R) → (S) or (S) → (R). This is due to backside attack by nucleophile.',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'stereochemistry',
    skill_dimension: 'comprehension',
    sequence_order: 3
  },

  # Question 4: Carbocation stability
  {
    quiz: quiz_9_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which carbocation is the MOST stable?',
    options: [
      { text: 'CH₃-CH₂⁺ (Primary)', correct: false },
      { text: '(CH₃)₂CH⁺ (Secondary)', correct: false },
      { text: 'C₆H₅-CH₂⁺ (Benzyl)', correct: true },
      { text: 'CH₃⁺ (Methyl)', correct: false }
    ],
    explanation: 'Benzyl carbocation is most stable due to resonance with benzene ring. Stability order: Resonance-stabilized (allyl, benzyl) > 3° > 2° > 1° > CH₃⁺.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'carbocation_stability',
    skill_dimension: 'application',
    sequence_order: 4
  },

  # Question 5: Nucleophilicity
  {
    quiz: quiz_9_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In protic solvents, which is the best nucleophile?',
    options: [
      { text: 'F⁻', correct: false },
      { text: 'Cl⁻', correct: false },
      { text: 'Br⁻', correct: false },
      { text: 'I⁻', correct: true }
    ],
    explanation: 'In protic solvents, nucleophilicity order: I⁻ > Br⁻ > Cl⁻ > F⁻ (opposite of basicity). Larger ions are less solvated and more nucleophilic.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'nucleophilicity',
    skill_dimension: 'recall',
    sequence_order: 5
  },

  # Question 6: Williamson ether synthesis
  {
    quiz: quiz_9_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Williamson ether synthesis works best with which combination?',
    options: [
      { text: 'Primary alkyl halide + alkoxide ion', correct: true },
      { text: 'Tertiary alkyl halide + alkoxide ion', correct: false },
      { text: 'Aryl halide + alkoxide ion', correct: false },
      { text: 'Vinyl halide + alkoxide ion', correct: false }
    ],
    explanation: 'Williamson ether synthesis (R-X + R\'O⁻ → R-O-R\') is SN2 reaction, works best with primary alkyl halides. Tertiary gives elimination, aryl/vinyl are unreactive.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'williamson_synthesis',
    skill_dimension: 'application',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 9.2: #{quiz_9_2.title} (#{quiz_9_2.quiz_questions.count} questions)"

# ========================================
# Lesson 9.3: Elimination Reactions and Haloarenes
# ========================================

lesson_9_3 = CourseLesson.create!(
  title: 'Elimination Reactions (E1, E2) and Haloarenes',
  reading_time_minutes: 55,
  key_concepts: ['Elimination reactions', 'E1 mechanism', 'E2 mechanism', 'Saytzeff rule', 'Haloarenes', 'Low reactivity'],
  content: <<~MD
    # Elimination Reactions and Haloarenes

    ## Elimination Reactions

    **Elimination** is the removal of two atoms or groups from adjacent carbons to form a double bond.

    **General reaction:**
    ```
    H-C-C-X + Base → C=C + HX
    | |
    ```

    **Product:** Alkene (C=C double bond)

    **Two major mechanisms:**
    1. **E1:** Elimination, Unimolecular
    2. **E2:** Elimination, Bimolecular

    ---

    ## E2 Mechanism (Bimolecular Elimination)

    ### Characteristics

    **E** = Elimination
    **2** = Second order (depends on [R-X] and [Base])

    ### Mechanism (One-Step, Concerted)

    ```
         H     X
         |     |
    Base-C-----C   →   C=C + Base-H + X⁻
         |     |
    ```

    **Features:**
    - **Single step** (concerted)
    - **Simultaneous:** H removal + C-X breaking + C=C formation
    - **Anti-periplanar geometry** required (H and X on opposite sides, 180°)

    ### Rate Equation
    ```
    Rate = k[R-X][Base]
    ```

    **Second order**

    ### Stereochemistry: Anti-Elimination

    **Requires anti-periplanar geometry:**

    ```
         H
         |
    -----C-----
         |     \
         |      X  (H and X must be anti, 180°)
         |     /
    -----C-----
    ```

    **Example:**
    - For elimination from CH₃CHBrCH₃, H and Br must be anti-periplanar

    ### Factors Affecting E2 Rate

    #### 1. Structure of Alkyl Halide
    ```
    3° > 2° > 1° (ease of H removal, stability of alkene formed)
    ```

    #### 2. Strength of Base
    **Strong base required**
    - Examples: OH⁻, RO⁻ (especially bulky bases like (CH₃)₃CO⁻)

    #### 3. Leaving Group
    **Better leaving group → Faster elimination**
    - I⁻ > Br⁻ > Cl⁻ > F⁻

    ---

    ## E1 Mechanism (Unimolecular Elimination)

    ### Characteristics

    **E** = Elimination
    **1** = First order (depends only on [R-X])

    ### Mechanism (Two-Step)

    **Step 1: Ionization (slow)**
    ```
    R-X → R⁺ + X⁻  (slow, forms carbocation)
    ```

    **Step 2: Deprotonation (fast)**
    ```
    R⁺ → C=C + H⁺  (fast)
    ```

    ### Rate Equation
    ```
    Rate = k[R-X]
    ```

    **First order** (same as SN1)

    ### Factors Affecting E1 Rate

    #### 1. Structure of Alkyl Halide
    ```
    3° > 2° >> 1° (carbocation stability)
    ```

    #### 2. Solvent
    **Polar protic solvents favor E1** (stabilize carbocation)

    ---

    ## Comparison: E1 vs E2

    | Property | E1 | E2 |
    |----------|----|----|
    | **Mechanism** | Two-step (carbocation) | One-step (concerted) |
    | **Rate** | k[R-X] | k[R-X][Base] |
    | **Order** | First | Second |
    | **Base** | Weak base OK | Strong base required |
    | **Alkyl halide** | 3° > 2° >> 1° | 3° > 2° > 1° |
    | **Stereochemistry** | No specific requirement | Anti-periplanar |
    | **Carbocation** | Yes (can rearrange) | No |
    | **Solvent** | Polar protic | Any |

    ---

    ## Competition: Substitution vs Elimination

    ### Factors Favoring Elimination Over Substitution

    #### 1. Structure of Alkyl Halide
    - **3° halides:** Favor elimination (especially E2 with strong base)
    - **1° halides:** Favor substitution (SN2)
    - **2° halides:** Depends on conditions

    #### 2. Base/Nucleophile
    - **Strong, bulky base:** Favors elimination (E2)
    - **Example:** (CH₃)₃CO⁻ (tert-butoxide) - strong base, poor nucleophile
    - **Small nucleophile:** Favors substitution

    #### 3. Temperature
    - **High temperature:** Favors elimination (higher activation energy)
    - **Low temperature:** Favors substitution

    ### Summary Table

    | Alkyl Halide | Conditions | Major Product |
    |--------------|-----------|---------------|
    | 1° | Strong nucleophile, low temp | SN2 |
    | 1° | Strong base, high temp | E2 |
    | 2° | Strong nucleophile | SN2 |
    | 2° | Strong base | E2 |
    | 3° | Weak nucleophile, polar protic | SN1 + E1 |
    | 3° | Strong base | E2 (major) |

    ---

    ## Saytzeff's Rule (Zaitsev's Rule)

    **Statement:** In elimination reactions, the **more substituted alkene** (more stable) is the major product.

    **Reason:** More substituted alkenes are more stable (hyperconjugation)

    ### Stability of Alkenes
    ```
    Tetra > Tri > Di > Mono > Unsubstituted
    ```

    ### Example 1
    ```
    CH₃-CHBr-CH₂-CH₃ + Base

    Products:
    CH₃-CH=CH-CH₃ (2-butene, trisubstituted) - MAJOR (Saytzeff)
    CH₂=CH-CH₂-CH₃ (1-butene, disubstituted) - MINOR (Hofmann)
    ```

    ### Example 2
    ```
    (CH₃)₂CH-CH₂Br + Base

    Products:
    (CH₃)₂C=CH₂ (2-methylpropene) - MAJOR (Saytzeff)
    ```

    **Hofmann product:** Less substituted alkene (minor, with bulky bases)

    ---

    ## Haloarenes (Aryl Halides)

    ### Introduction

    **Haloarenes:** Halogen directly attached to benzene ring

    **Examples:**
    - C₆H₅Cl (Chlorobenzene)
    - C₆H₅Br (Bromobenzene)
    - o-C₆H₄Cl₂ (o-Dichlorobenzene)

    ### Nomenclature

    | Structure | IUPAC Name | Common Name |
    |-----------|------------|-------------|
    | C₆H₅Cl | Chlorobenzene | Phenyl chloride |
    | C₆H₅Br | Bromobenzene | Phenyl bromide |
    | C₆H₅I | Iodobenzene | Phenyl iodide |
    | C₆H₅CH₂Cl | (Chloromethyl)benzene | Benzyl chloride* |

    *Note: Benzyl chloride is NOT a haloarene (Cl not on ring)

    ---

    ## Preparation of Haloarenes

    ### Method 1: Direct Halogenation
    ```
    C₆H₆ + X₂ --[FeBr₃ or AlCl₃]--> C₆H₅X + HX
    ```

    **Mechanism:** Electrophilic aromatic substitution

    **Lewis acid catalyst required:** FeBr₃, AlCl₃, Fe

    ### Method 2: Sandmeyer Reaction
    ```
    C₆H₅NH₂ --[NaNO₂/HCl, 0-5°C]--> C₆H₅N₂⁺Cl⁻ --[CuX]--> C₆H₅X + N₂

    X = Cl, Br, CN
    ```

    **Best method for:** Chlorobenzene, bromobenzene

    ### Method 3: Gattermann Reaction
    ```
    C₆H₅N₂⁺Cl⁻ + Cu/HX → C₆H₅X + N₂
    ```

    **Similar to Sandmeyer, uses Cu metal instead of CuX**

    ### Method 4: Balz-Schiemann Reaction
    ```
    C₆H₅N₂⁺BF₄⁻ --[heat]--> C₆H₅F + N₂ + BF₃
    ```

    **Best method for:** Fluorobenzene

    ---

    ## Properties of Haloarenes

    ### Physical Properties
    - Colorless liquids or solids
    - Pleasant smell (but toxic)
    - Insoluble in water, soluble in organic solvents
    - Higher boiling point than benzene

    ### Chemical Properties: Low Reactivity

    **Haloarenes are MUCH LESS reactive than haloalkanes**

    #### Reasons for Low Reactivity:

    **1. Resonance Stabilization**
    ```
    Lone pair on halogen delocalizes into benzene ring
    C-X bond acquires partial double bond character
    Stronger bond → Harder to break
    ```

    **2. sp² Carbon**
    - C-X bond is shorter and stronger (sp² > sp³)
    - Halogen attached to sp² carbon (benzene)

    **3. Steric Hindrance**
    - Benzene ring provides steric protection

    ### Reactions of Haloarenes

    #### 1. Nucleophilic Substitution (Very Difficult)
    **Does NOT undergo SN1 or SN2 under normal conditions**

    **Requires:** Very harsh conditions
    - High temperature (300-400°C)
    - High pressure
    - Strong nucleophile

    **Example:**
    ```
    C₆H₅Cl + NaOH --[623 K, 300 atm]--> C₆H₅OH + NaCl
    ```

    #### 2. Electrophilic Substitution (Easy)
    **Halogen is ortho-para directing, deactivating**

    **Example:** Further halogenation
    ```
    C₆H₅Cl + Br₂ --[FeBr₃]--> o-ClC₆H₄Br + p-ClC₆H₄Br
    ```

    #### 3. Reduction
    ```
    C₆H₅Cl + H₂ --[Ni]--> C₆H₆ + HCl
    ```

    #### 4. Wurtz-Fittig Reaction
    ```
    C₆H₅Br + 2Na + BrCH₃ → C₆H₅-CH₃ + 2NaBr
    ```

    **Coupling of aryl and alkyl halides**

    ---

    ## Comparison: Haloalkanes vs Haloarenes

    | Property | Haloalkanes (R-X) | Haloarenes (Ar-X) |
    |----------|-------------------|-------------------|
    | **C-X bond** | sp³, longer, weaker | sp², shorter, stronger |
    | **Resonance** | No resonance | Resonance with ring |
    | **SN reactions** | Easy (SN1, SN2) | Very difficult |
    | **Reactivity** | High | Low |
    | **Conditions for Nu-Sub** | Mild | Very harsh (623 K, 300 atm) |
    | **Directing effect** | — | ortho-para directing |

    ---

    ## IIT JEE Key Points

    1. **E2:** One-step, anti-periplanar, strong base, Rate = k[R-X][Base]
    2. **E1:** Two-step, carbocation, weak base, Rate = k[R-X]
    3. **Saytzeff rule:** More substituted alkene is major product
    4. **Elimination vs Substitution:** 3° → E2, 1° → SN2
    5. **Bulky base** favors elimination over substitution
    6. **Haloarenes:** C-X on benzene ring, very low reactivity
    7. **Resonance** makes C-X bond stronger in haloarenes
    8. **Sandmeyer reaction:** Best for Cl, Br (via diazonium salt)
    9. **Balz-Schiemann:** For fluorobenzene (via diazonium fluoroborate)
    10. **Haloarenes:** ortho-para directing, deactivating in EAS
  MD
)

ModuleItem.create!(course_module: module_9, item: lesson_9_3, sequence_order: 5, required: true)

puts "  ✓ Lesson 9.3: #{lesson_9_3.title}"

# ========================================
# Quiz 9.3: Elimination and Haloarenes
# ========================================

quiz_9_3 = Quiz.create!(
  title: 'Elimination Reactions and Haloarenes',
  description: 'Test your knowledge of E1, E2 mechanisms, Saytzeff rule, and haloarene reactivity',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_9, item: quiz_9_3, sequence_order: 6, required: true)

# Questions for Quiz 9.3
QuizQuestion.create!([
  # Question 1: E2 mechanism
  {
    quiz: quiz_9_3,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which statements about E2 mechanism are correct?',
    options: [
      { text: 'Requires strong base', correct: true },
      { text: 'Anti-periplanar geometry required', correct: true },
      { text: 'Proceeds through carbocation intermediate', correct: false },
      { text: 'Rate = k[R-X][Base]', correct: true }
    ],
    explanation: 'E2: (1) Strong base needed ✓, (2) Anti-periplanar (H and X at 180°) ✓, (3) One-step, no carbocation ✓, (4) Second order rate ✓.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'e2_mechanism',
    skill_dimension: 'comprehension',
    sequence_order: 1
  },

  # Question 2: Saytzeff rule
  {
    quiz: quiz_9_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'According to Saytzeff\'s rule, which alkene is the major product from 2-bromobutane + strong base?',
    options: [
      { text: '1-Butene (CH₂=CHCH₂CH₃)', correct: false },
      { text: '2-Butene (CH₃CH=CHCH₃)', correct: true },
      { text: 'Cyclobutane', correct: false },
      { text: 'No alkene formed', correct: false }
    ],
    explanation: 'Saytzeff: More substituted alkene is major. 2-Butene (trisubstituted) is more stable than 1-butene (disubstituted). CH₃CH=CHCH₃ is major product.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'saytzeff_rule',
    skill_dimension: 'application',
    sequence_order: 2
  },

  # Question 3: Substitution vs Elimination
  {
    quiz: quiz_9_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which alkyl halide will predominantly undergo E2 elimination (rather than SN2) with strong base?',
    options: [
      { text: 'CH₃CH₂Br (Primary)', correct: false },
      { text: 'CH₃CHBrCH₃ (Secondary)', correct: false },
      { text: '(CH₃)₃CBr (Tertiary)', correct: true },
      { text: 'CH₃Br (Methyl)', correct: false }
    ],
    explanation: 'Tertiary halides favor elimination over substitution due to steric hindrance. With strong base, (CH₃)₃CBr gives E2 as major pathway. Primary favors SN2.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'substitution_vs_elimination',
    skill_dimension: 'application',
    sequence_order: 3
  },

  # Question 4: Haloarene reactivity
  {
    quiz: quiz_9_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why are haloarenes less reactive than haloalkanes in nucleophilic substitution?',
    options: [
      { text: 'C-X bond is longer in haloarenes', correct: false },
      { text: 'Resonance stabilization of C-X bond', correct: true },
      { text: 'Haloarenes have lower molecular weight', correct: false },
      { text: 'Benzene ring is too electron-rich', correct: false }
    ],
    explanation: 'Haloarenes have low reactivity due to: (1) Resonance - lone pair on X delocalizes into ring, (2) C-X has partial double bond character (sp²), (3) Stronger, shorter bond.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'haloarene_reactivity',
    skill_dimension: 'comprehension',
    sequence_order: 4
  },

  # Question 5: Sandmeyer reaction
  {
    quiz: quiz_9_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Sandmeyer reaction is used to prepare:',
    options: [
      { text: 'Haloalkanes from alcohols', correct: false },
      { text: 'Haloarenes from aniline (via diazonium salt)', correct: true },
      { text: 'Alkyl halides from alkenes', correct: false },
      { text: 'Fluorobenzene from benzene', correct: false }
    ],
    explanation: 'Sandmeyer: C₆H₅NH₂ → C₆H₅N₂⁺Cl⁻ → C₆H₅X (X=Cl, Br, CN) using CuX. Best method for chlorobenzene and bromobenzene from aniline.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'sandmeyer_reaction',
    skill_dimension: 'recall',
    sequence_order: 5
  },

  # Question 6: E1 vs E2
  {
    quiz: quiz_9_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which condition favors E1 over E2?',
    options: [
      { text: 'Strong base, polar aprotic solvent', correct: false },
      { text: 'Weak base, polar protic solvent', correct: true },
      { text: 'Primary alkyl halide', correct: false },
      { text: 'High concentration of base', correct: false }
    ],
    explanation: 'E1 favored by: (1) Weak base, (2) Polar protic solvent (stabilizes carbocation), (3) Tertiary halide. E2 needs strong base. E1 rate independent of base concentration.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'hard',
    topic: 'e1_vs_e2',
    skill_dimension: 'comprehension',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 9.3: #{quiz_9_3.title} (#{quiz_9_3.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 9 COMPLETE: Haloalkanes and Haloarenes"
puts "Total Lessons: 3"
puts "Total Quizzes: 3"
puts "Total Questions: #{QuizQuestion.where(quiz_id: [quiz_9_1.id, quiz_9_2.id, quiz_9_3.id]).count}"
puts "=" * 80

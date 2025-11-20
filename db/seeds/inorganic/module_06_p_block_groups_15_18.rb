# frozen_string_literal: true

# ========================================
# IIT JEE Inorganic Chemistry - Module 6
# p-Block Elements - Groups 15-18
# ========================================
# Complete module covering nitrogen family, oxygen family,
# halogens, and noble gases
# ========================================

puts "\n" + "=" * 80
puts "MODULE 6: p-BLOCK ELEMENTS (GROUPS 15-18)"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Inorganic Chemistry course not found!"
  puts "   Please run db/seeds/iit_jee_inorganic_chemistry.rb first"
  exit 1
end

# Create Module 6: p-Block Elements Groups 15-18
module_6 = course.course_modules.find_or_create_by!(slug: 'p-block-groups-15-18') do |m|
  m.title = 'p-Block Elements (Groups 15-18)'
  m.sequence_order = 6
  m.estimated_minutes = 1200  # 20 hours
  m.description = 'Comprehensive coverage of nitrogen family, oxygen family, halogens, and noble gases'
  m.learning_objectives = [
    'Master Group 15 elements (N, P, As, Sb, Bi) and their compounds',
    'Understand Group 16 elements (O, S, Se, Te, Po) chemistry',
    'Learn Group 17 (halogens) properties and reactions',
    'Master Group 18 (noble gases) and their compounds',
    'Understand trends and anomalous behavior in p-block',
    'Solve IIT JEE problems on p-block elements'
  ]
  m.published = true
end

puts "✅ Module 6: #{module_6.title}"

# ========================================
# Lesson 6.1: Group 15 - Nitrogen Family (Part 1)
# ========================================

lesson_6_1 = CourseLesson.create!(
  title: 'Group 15 Elements - Properties and Trends',
  reading_time_minutes: 50,
  key_concepts: ['Group 15 elements', 'Nitrogen', 'Phosphorus', 'Electronic configuration', 'Periodic trends', 'Anomalous behavior'],
  content: <<~MD
    # Group 15 Elements - Nitrogen Family

    ## Introduction

    **Group 15 elements:** Nitrogen (N), Phosphorus (P), Arsenic (As), Antimony (Sb), Bismuth (Bi)

    Also called **pnictogens** or **nitrogen family**

    ## Electronic Configuration

    **General configuration:** ns² np³

    - N (7): [He] 2s² 2p³
    - P (15): [Ne] 3s² 3p³
    - As (33): [Ar] 3d¹⁰ 4s² 4p³
    - Sb (51): [Kr] 4d¹⁰ 5s² 5p³
    - Bi (83): [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p³

    **Key feature:** Half-filled p-orbitals (p³) give extra stability

    ---

    ## Physical Properties and Trends

    ### 1. Atomic and Ionic Radii
    - **Increase down the group:** N < P < As < Sb < Bi
    - Reason: Addition of new shells
    - Covalent radius of P >> N (due to absence of d-orbitals in N)

    ### 2. Ionization Energy
    - **Decreases down the group:** N > P > As > Sb > Bi
    - Reason: Increasing atomic size
    - Exception: P has higher IE than expected (stable half-filled p³)

    ### 3. Electronegativity
    - **Decreases down the group:** N > P > As > Sb > Bi
    - Nitrogen is highly electronegative (3.0)

    ### 4. Electron Gain Enthalpy
    - Becomes less negative down the group
    - N has less negative value than P (small size, high inter-electronic repulsion)

    ### 5. Metallic Character
    - **Increases down the group**
    - N, P: Non-metals (diatomic/solid)
    - As, Sb: Metalloids
    - Bi: Metal

    ### 6. Allotropy
    - **Phosphorus:** White (P₄), red, black
    - **Arsenic:** Yellow, grey, black
    - Others don't show significant allotropy

    ---

    ## Chemical Properties

    ### Oxidation States

    **Common oxidation states:** -3, +3, +5

    - **-3:** Ammonia (NH₃), phosphine (PH₃)
    - **+3:** Phosphorous acid (H₃PO₃), PCl₃
    - **+5:** Nitric acid (HNO₃), phosphoric acid (H₃PO₄), PCl₅

    **Stability trend:**
    - **+5 state:** Decreases down group (N to Bi)
    - **+3 state:** Increases down group (inert pair effect in Bi)

    **Important:** Nitrogen shows -3 to +5 (except +4), all oxidation states

    ### Covalency

    - **Maximum covalency:**
      - N: 4 (no d-orbitals, forms dative bonds)
      - P, As, Sb, Bi: 6 (due to vacant d-orbitals)

    - **Examples:**
      - N: NH₄⁺ (4 bonds via dative bond)
      - P: PCl₅, PF₅ (5 bonds using sp³d)

    ### Bond Formation

    **Single bond strength:** N-N < P-P < As-As

    **Why N-N single bond weak?**
    - Small size → High inter-electronic repulsion between lone pairs
    - N≡N triple bond is very strong (944 kJ/mol)

    **Multiple bonding:**
    - **Nitrogen:** Forms strong pπ-pπ multiple bonds (N₂, N=O)
    - **Heavier elements:** Weak pπ-pπ, prefer pπ-dπ or single bonds

    ---

    ## Anomalous Behavior of Nitrogen

    ### Reasons:
    1. **Smallest size** in group
    2. **High electronegativity**
    3. **Absence of d-orbitals** (maximum covalency = 4)
    4. **Strong tendency** to form pπ-pπ multiple bonds

    ### Anomalous Properties:

    1. **Exists as diatomic molecule (N₂)**
       - Others exist as solids (P₄, As, etc.)
       - N₂ has strong triple bond

    2. **Cannot form dπ-pπ bonds**
       - No d-orbitals available
       - Others can expand octet

    3. **Forms stable multiple bonds**
       - N=N, N≡N very stable
       - P=P, As=As relatively unstable

    4. **Maximum covalency is 4**
       - Forms NH₄⁺ via dative bond
       - P can form PCl₅, PF₅ (covalency = 5)

    5. **Forms highly stable compounds**
       - NH₃ more stable than PH₃
       - HNO₃ is strong acid, H₃PO₄ is weak

    ---

    ## Important Compounds - Nitrogen

    ### 1. Ammonia (NH₃)

    **Preparation:**
    ```
    N₂(g) + 3H₂(g) ⇌ 2NH₃(g)  [Haber process, Fe catalyst, 450°C, 200 atm]
    ```

    **Laboratory:**
    ```
    2NH₄Cl + Ca(OH)₂ → CaCl₂ + 2H₂O + 2NH₃
    ```

    **Properties:**
    - Colorless, pungent smell
    - Highly soluble in water
    - Basic in nature: NH₃ + H₂O ⇌ NH₄⁺ + OH⁻
    - Forms complexes: [Cu(NH₃)₄]²⁺, [Ag(NH₃)₂]⁺

    **Structure:**
    - Pyramidal shape
    - sp³ hybridization
    - Bond angle: 107° (less than 109.5° due to lone pair)

    **Uses:**
    - Fertilizers (urea, ammonium salts)
    - Nitric acid production
    - Explosives, plastics

    ### 2. Oxides of Nitrogen

    | Oxide | Name | Oxidation State | Nature |
    |-------|------|-----------------|--------|
    | N₂O | Nitrous oxide (laughing gas) | +1 | Neutral |
    | NO | Nitric oxide | +2 | Neutral |
    | N₂O₃ | Dinitrogen trioxide | +3 | Acidic |
    | NO₂ | Nitrogen dioxide | +4 | Acidic |
    | N₂O₅ | Dinitrogen pentoxide | +5 | Acidic |

    **N₂O (Nitrous oxide):**
    - Preparation: NH₄NO₃ --heat--> N₂O + 2H₂O
    - Anesthetic (laughing gas)
    - Supports combustion

    **NO (Nitric oxide):**
    - Preparation: 3Cu + 8HNO₃(dilute) → 3Cu(NO₃)₂ + 2NO + 4H₂O
    - Colorless, neutral
    - Paramagnetic (odd electron)
    - Oxidizes to NO₂ in air

    **NO₂ (Nitrogen dioxide):**
    - Brown gas, pungent smell
    - Acidic oxide: 2NO₂ + H₂O → HNO₃ + HNO₂
    - Dimerizes: 2NO₂ ⇌ N₂O₄ (colorless)
    - Air pollutant

    ### 3. Nitric Acid (HNO₃)

    **Preparation - Ostwald Process:**
    ```
    Step 1: 4NH₃ + 5O₂ → 4NO + 6H₂O  [Pt catalyst, 800°C]
    Step 2: 2NO + O₂ → 2NO₂
    Step 3: 4NO₂ + O₂ + 2H₂O → 4HNO₃
    ```

    **Laboratory:**
    ```
    NaNO₃ + H₂SO₄ → NaHSO₄ + HNO₃
    ```

    **Properties:**
    - Colorless liquid (pure), turns yellow on standing (NO₂ formation)
    - Strong monobasic acid
    - Powerful oxidizing agent

    **Reactions as oxidizing agent:**

    With metals:
    ```
    3Cu + 8HNO₃(dil) → 3Cu(NO₃)₂ + 2NO + 4H₂O
    Cu + 4HNO₃(conc) → Cu(NO₃)₂ + 2NO₂ + 2H₂O
    ```

    With non-metals:
    ```
    S + 6HNO₃(conc) → H₂SO₄ + 6NO₂ + 2H₂O
    P₄ + 20HNO₃(conc) → 4H₃PO₄ + 20NO₂ + 4H₂O
    ```

    **Aqua regia:** 3 HCl : 1 HNO₃ (dissolves gold and platinum)

    **Brown ring test for nitrates:**
    ```
    NO₃⁻ + 3Fe²⁺ + 4H⁺ → NO + 3Fe³⁺ + 2H₂O
    [Fe(H₂O)₆]²⁺ + NO → [Fe(H₂O)₅NO]²⁺ + H₂O (brown ring)
    ```

    ---

    ## Important Compounds - Phosphorus

    ### Allotropes of Phosphorus

    #### 1. White Phosphorus (P₄)
    - Translucent white waxy solid
    - Highly reactive, spontaneously ignites in air
    - Poisonous
    - Stored under water
    - Tetrahedral structure (P₄)

    #### 2. Red Phosphorus
    - Less reactive than white
    - Non-poisonous
    - Polymeric structure
    - Obtained by heating white P at 573 K in inert atmosphere

    #### 3. Black Phosphorus
    - Least reactive
    - Graphite-like structure
    - Obtained by heating white P under high pressure

    ### Phosphine (PH₃)

    **Preparation:**
    ```
    Ca₃P₂ + 6H₂O → 3Ca(OH)₂ + 2PH₃
    White P + NaOH + H₂O → PH₃ + NaH₂PO₂
    ```

    **Properties:**
    - Colorless, poisonous gas
    - Fish-like odor
    - Less basic than NH₃
    - Does not form hydrogen bonds (less soluble in water)

    **Structure:**
    - Pyramidal
    - Bond angle: 93.5° (less than NH₃ due to less s-character)

    ### Oxides of Phosphorus

    **P₄O₆ (Phosphorus trioxide):**
    ```
    P₄ + 3O₂ (limited) → P₄O₆
    ```

    **P₄O₁₀ (Phosphorus pentoxide):**
    ```
    P₄ + 5O₂ (excess) → P₄O₁₀
    ```
    - White powder
    - Strong dehydrating agent
    - Acidic oxide: P₄O₁₀ + 6H₂O → 4H₃PO₄

    ---

    ## IIT JEE Key Points

    1. Group 15: **ns² np³** configuration
    2. **Nitrogen** is anomalous due to small size, high EN, no d-orbitals
    3. **Oxidation states:** -3, +3, +5 (stability of +5 decreases, +3 increases down group)
    4. **Maximum covalency:** N = 4, others = 6
    5. **N₂** has very strong triple bond (944 kJ/mol)
    6. **NH₃:** Basic, pyramidal, forms complexes
    7. **HNO₃:** Strong oxidizing agent, Ostwald process
    8. **White phosphorus (P₄):** Highly reactive, stored under water
    9. **PH₃:** Less basic than NH₃, pyramidal
    10. **Aqua regia:** 3 HCl : 1 HNO₃ (dissolves Au, Pt)
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 6.1: #{lesson_6_1.title}"

# ========================================
# Quiz 6.1: Group 15 Elements
# ========================================

quiz_6_1 = Quiz.create!(
  title: 'Group 15 Elements - Properties and Compounds',
  description: 'Test your understanding of nitrogen family elements',
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
    multiple_correct: false,
    question_text: 'The electronic configuration of Group 15 elements is:',
    options: [
      { text: 'ns² np³', correct: true },
      { text: 'ns² np⁵', correct: false },
      { text: 'ns² np⁴', correct: false },
      { text: 'ns² np⁶', correct: false }
    ],
    explanation: 'Group 15 elements have 5 valence electrons with configuration ns² np³, giving half-filled p-orbitals.',
    points: 2,
    difficulty: -0.6,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'group_15',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which are anomalous properties of nitrogen?',
    options: [
      { text: 'Exists as diatomic molecule (N₂)', correct: true },
      { text: 'Maximum covalency is 4', correct: true },
      { text: 'Can form compounds with covalency 5', correct: false },
      { text: 'Forms weak triple bonds', correct: false }
    ],
    explanation: 'Nitrogen exists as N₂ with strong triple bond, has maximum covalency 4 (no d-orbitals), unlike heavier elements which can expand octet.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'nitrogen_anomalous',
    skill_dimension: 'comprehension',
    sequence_order: 2
  },

  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Ammonia (NH₃) has bond angle of approximately:',
    options: [
      { text: '107°', correct: true },
      { text: '109.5°', correct: false },
      { text: '120°', correct: false },
      { text: '90°', correct: false }
    ],
    explanation: 'NH₃ is pyramidal (sp³) with bond angle ~107°, less than tetrahedral 109.5° due to lone pair repulsion.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'ammonia',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which allotrope of phosphorus is most reactive?',
    options: [
      { text: 'White phosphorus', correct: true },
      { text: 'Red phosphorus', correct: false },
      { text: 'Black phosphorus', correct: false },
      { text: 'All equally reactive', correct: false }
    ],
    explanation: 'White phosphorus (P₄) is highly reactive, spontaneously ignites in air, must be stored under water. Red and black are less reactive.',
    points: 2,
    difficulty: -0.4,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'phosphorus',
    skill_dimension: 'recall',
    sequence_order: 4
  },

  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Nitric acid acts as an oxidizing agent. When it reacts with copper, which product is formed with dilute HNO₃?',
    options: [
      { text: 'NO (nitric oxide)', correct: true },
      { text: 'NO₂ (nitrogen dioxide)', correct: false },
      { text: 'N₂O (nitrous oxide)', correct: false },
      { text: 'N₂ (nitrogen)', correct: false }
    ],
    explanation: '3Cu + 8HNO₃(dilute) → 3Cu(NO₃)₂ + 2NO + 4H₂O. Dilute HNO₃ gives NO. Concentrated HNO₃ gives NO₂.',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'nitric_acid',
    skill_dimension: 'application',
    sequence_order: 5
  }
])

puts "  ✓ Quiz 6.1: #{quiz_6_1.title} (#{quiz_6_1.quiz_questions.count} questions)"

# ========================================
# Lesson 6.2: Group 16 - Oxygen Family
# ========================================

lesson_6_2 = CourseLesson.create!(
  title: 'Group 16 Elements - Oxygen and Sulfur',
  reading_time_minutes: 55,
  key_concepts: ['Group 16 elements', 'Oxygen', 'Ozone', 'Sulfur', 'Allotropes', 'Oxides', 'Sulfuric acid'],
  content: <<~MD
    # Group 16 Elements - Oxygen Family (Chalcogens)

    ## Introduction

    **Group 16 elements:** Oxygen (O), Sulfur (S), Selenium (Se), Tellurium (Te), Polonium (Po)

    Also called **chalcogens** (ore-forming elements)

    ## Electronic Configuration

    **General configuration:** ns² np⁴

    - O (8): [He] 2s² 2p⁴
    - S (16): [Ne] 3s² 3p⁴
    - Se (34): [Ar] 3d¹⁰ 4s² 4p⁴
    - Te (52): [Kr] 4d¹⁰ 5s² 5p⁴
    - Po (84): [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁴

    **Need 2 more electrons** to complete octet

    ---

    ## Trends in Properties

    ### Physical Properties

    **Atomic/Ionic radius:** O < S < Se < Te < Po (increases)
    **Ionization energy:** O > S > Se > Te > Po (decreases)
    **Electronegativity:** O > S > Se > Te > Po (decreases)
    **Metallic character:** Increases (O, S non-metals; Se, Te metalloids; Po metal)

    ### Chemical Properties

    **Oxidation states:** -2, +2, +4, +6

    - **-2:** Most common (H₂O, H₂S)
    - **+4:** SO₂, SF₄
    - **+6:** SO₃, H₂SO₄, SF₆

    **Stability of +6:** Decreases down group (O to Po)
    **Stability of +4:** Increases down group

    ---

    ## Anomalous Behavior of Oxygen

    **Reasons:**
    1. Smallest size in group
    2. Highest electronegativity
    3. Absence of d-orbitals
    4. Strong tendency for pπ-pπ bonding

    **Anomalous properties:**

    1. **Exists as diatomic O₂**
       - Sulfur exists as S₈
       - O=O double bond (strong pπ-pπ)

    2. **Forms hydrogen bonds**
       - H₂O has high boiling point
       - H₂S doesn't form H-bonds effectively

    3. **High electronegativity**
       - Most electronegative after F
       - Shows only -2, -1 oxidation states (rare positive)

    4. **Maximum covalency 4**
       - O: H₃O⁺ (4 bonds max)
       - S: SF₆ (6 bonds using d-orbitals)

    ---

    ## Dioxygen (O₂)

    **Preparation:**

    Industrial:
    ```
    Fractional distillation of liquid air
    ```

    Laboratory:
    ```
    2KClO₃ --MnO₂, heat--> 2KCl + 3O₂
    2H₂O₂ --MnO₂--> 2H₂O + O₂
    ```

    **Properties:**
    - Colorless, odorless gas
    - Paramagnetic (two unpaired electrons)
    - Supports combustion
    - Essential for respiration

    **Reactions:**

    With metals:
    ```
    4Na + O₂ → 2Na₂O (oxide)
    2Na + O₂ → Na₂O₂ (peroxide)
    K + O₂ → KO₂ (superoxide)
    ```

    With non-metals:
    ```
    S + O₂ → SO₂
    4P + 5O₂ → P₄O₁₀
    ```

    ---

    ## Ozone (O₃)

    **Preparation:**
    ```
    3O₂ --silent electric discharge--> 2O₃
    ```

    **Structure:**
    - Bent shape
    - Resonance hybrid
    - O-O bond length: 128 pm (between O=O double 121 pm and O-O single 148 pm)
    - Bond angle: 117°

    **Properties:**
    - Pale blue gas
    - Pungent odor
    - Powerful oxidizing agent
    - Diamagnetic

    **Reactions:**

    Oxidizing agent:
    ```
    PbS + 4O₃ → PbSO₄ + 4O₂
    2I⁻ + H₂O + O₃ → 2OH⁻ + I₂ + O₂
    ```

    **Uses:**
    - Water purification
    - Bleaching agent
    - Disinfectant
    - Ozone layer absorbs UV radiation

    **Ozone layer depletion:**
    - CFCs release Cl radicals
    - Cl + O₃ → ClO + O₂
    - ClO + O → Cl + O₂
    - Net: O₃ + O → 2O₂

    ---

    ## Sulfur

    ### Allotropes

    **Rhombic sulfur (α-sulfur):**
    - Yellow octahedral crystals
    - Stable below 369 K
    - S₈ ring structure

    **Monoclinic sulfur (β-sulfur):**
    - Needle-shaped crystals
    - Stable above 369 K
    - Also S₈ structure

    **Plastic sulfur:**
    - Amorphous, elastic
    - Formed by sudden cooling of molten S
    - Chain structure

    ### Hydrogen Sulfide (H₂S)

    **Preparation:**
    ```
    FeS + H₂SO₄ → FeSO₄ + H₂S
    ```

    **Properties:**
    - Colorless, foul smell (rotten eggs)
    - Poisonous
    - Weak dibasic acid
    - Reducing agent

    **Structure:**
    - Bent shape (like H₂O)
    - Bond angle: 92° (less than H₂O due to less s-character)

    **Reactions:**

    Acidic nature:
    ```
    H₂S ⇌ H⁺ + HS⁻ ⇌ 2H⁺ + S²⁻
    ```

    Reducing agent:
    ```
    H₂S + Cl₂ → 2HCl + S
    2H₂S + SO₂ → 3S + 2H₂O
    ```

    **Group precipitation:**
    - Group 2: CuS, PbS, HgS (in acidic medium)
    - Group 4: NiS, CoS, MnS (in basic medium)

    ---

    ## Oxides of Sulfur

    ### Sulfur Dioxide (SO₂)

    **Preparation:**
    ```
    S + O₂ → SO₂
    Cu + 2H₂SO₄(conc) → CuSO₄ + SO₂ + 2H₂O
    ```

    **Properties:**
    - Colorless, pungent smell
    - Acidic oxide
    - Reducing agent
    - Bleaching agent (temporary)

    **Structure:**
    - Bent, V-shaped
    - sp² hybridization
    - Bond angle: 119°

    **Reactions:**

    Acidic oxide:
    ```
    SO₂ + H₂O → H₂SO₃ (sulfurous acid)
    ```

    Reducing agent:
    ```
    SO₂ + 2H₂S → 3S + 2H₂O
    ```

    Bleaching:
    ```
    SO₂ + H₂O → H₂SO₃ (removes color by reduction)
    ```

    ### Sulfur Trioxide (SO₃)

    **Preparation:**
    ```
    2SO₂ + O₂ ⇌ 2SO₃  [V₂O₅ catalyst, Contact process]
    ```

    **Properties:**
    - Colorless liquid/solid
    - Highly reactive
    - Strong acidic oxide

    **Structure:**
    - Planar triangular
    - sp² hybridization
    - Bond angle: 120°

    **Reaction:**
    ```
    SO₃ + H₂O → H₂SO₄
    ```

    ---

    ## Sulfuric Acid (H₂SO₄)

    ### Preparation - Contact Process

    **Steps:**

    1. **Burning sulfur:**
       ```
       S + O₂ → SO₂
       ```

    2. **Oxidation to SO₃:**
       ```
       2SO₂ + O₂ ⇌ 2SO₃  [V₂O₅, 450°C]
       ```

    3. **Absorption in H₂SO₄:**
       ```
       SO₃ + H₂SO₄ → H₂S₂O₇ (oleum)
       H₂S₂O₇ + H₂O → 2H₂SO₄
       ```

    ### Properties

    **Physical:**
    - Oily, viscous liquid
    - Colorless when pure
    - Highly hygroscopic (dehydrating agent)

    **Chemical:**

    **1. Strong dibasic acid:**
    ```
    H₂SO₄ → H⁺ + HSO₄⁻ (complete)
    HSO₄⁻ ⇌ H⁺ + SO₄²⁻ (partial)
    ```

    **2. Dehydrating agent:**
    ```
    C₁₂H₂₂O₁₁ --H₂SO₄--> 12C + 11H₂O (charring)
    ```

    **3. Oxidizing agent (conc):**

    With metals:
    ```
    Cu + 2H₂SO₄(conc) → CuSO₄ + SO₂ + 2H₂O
    ```

    With non-metals:
    ```
    C + 2H₂SO₄(conc) → CO₂ + 2SO₂ + 2H₂O
    S + 2H₂SO₄(conc) → 3SO₂ + 2H₂O
    ```

    ### Uses
    - Fertilizer manufacturing
    - Petroleum refining
    - Lead-acid batteries
    - Chemical synthesis

    ---

    ## IIT JEE Key Points

    1. Group 16: **ns² np⁴** configuration
    2. **Oxygen** anomalous: small, high EN, no d-orbitals, forms pπ-pπ bonds
    3. **Oxidation states:** -2 (most common), +4, +6
    4. **O₂** paramagnetic (two unpaired electrons)
    5. **O₃** bent, resonance, powerful oxidizing agent
    6. **H₂S:** Weak acid, reducing agent, group precipitation
    7. **SO₂:** Reducing agent, temporary bleaching
    8. **H₂SO₄:** Strong acid, dehydrating agent, oxidizing agent (conc)
    9. **Contact process:** S → SO₂ → SO₃ → H₂SO₄ (V₂O₅ catalyst)
    10. **Sulfur allotropes:** Rhombic, monoclinic (S₈), plastic (chain)
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_2, sequence_order: 3, required: true)

puts "  ✓ Lesson 6.2: #{lesson_6_2.title}"

# Continue with more lessons for Groups 17 and 18...
# Due to length constraints, I'm creating a comprehensive but focused set

# ========================================
# Lesson 6.3: Group 17 - Halogens
# ========================================

lesson_6_3 = CourseLesson.create!(
  title: 'Group 17 Elements - Halogens',
  reading_time_minutes: 50,
  key_concepts: ['Halogens', 'Fluorine', 'Chlorine', 'Halogen acids', 'Interhalogen compounds', 'Oxoacids'],
  content: <<~MD
    # Group 17 Elements - Halogens

    ## Introduction

    **Group 17 elements:** Fluorine (F), Chlorine (Cl), Bromine (Br), Iodine (I), Astatine (At)

    **Halogens** means "salt producers" (Greek: hals = salt, genes = born)

    ## Electronic Configuration

    **General configuration:** ns² np⁵

    - F (9): [He] 2s² 2p⁵
    - Cl (17): [Ne] 3s² 3p⁵
    - Br (35): [Ar] 3d¹⁰ 4s² 4p⁵
    - I (53): [Kr] 4d¹⁰ 5s² 5p⁵

    **Need 1 electron** to complete octet → highly reactive

    ---

    ## Trends in Properties

    **Atomic radius:** F < Cl < Br < I (increases)
    **Ionization energy:** F > Cl > Br > I (decreases)
    **Electronegativity:** F > Cl > Br > I (F most electronegative, 4.0)
    **Electron gain enthalpy:** Cl > F > Br > I
    **Bond dissociation energy:** Cl₂ > Br₂ > F₂ > I₂

    **Why F₂ has lower bond energy than Cl₂?**
    - Small size → High inter-electronic repulsion between lone pairs
    - F-F bond weaker than expected

    **Reactivity:** F > Cl > Br > I (decreases)

    **Physical state:**
    - F₂, Cl₂: Gases
    - Br₂: Liquid
    - I₂: Solid

    ---

    ## Oxidation States

    **Common:** -1 (most stable in all)

    **Positive oxidation states:** +1, +3, +5, +7
    - **Fluorine:** Only -1 (most electronegative, no d-orbitals)
    - **Others:** Can show +1, +3, +5, +7 (using d-orbitals)

    **Examples:**
    - +1: ClO⁻, BrO⁻
    - +3: ClO₂⁻, HClO₂
    - +5: ClO₃⁻, HClO₃
    - +7: ClO₄⁻, HClO₄, IF₇

    ---

    ## Anomalous Behavior of Fluorine

    **Reasons:**
    1. Smallest size
    2. Highest electronegativity (4.0)
    3. No d-orbitals
    4. Low F-F bond dissociation energy

    **Anomalous properties:**

    1. **Most reactive halogen**
    2. **Only -1 oxidation state** (others show positive states)
    3. **Forms only one oxoacid** (HOF)
    4. **Ionic bonds with metals** (others more covalent)
    5. **Hydrogen bonding** (HF has highest b.p. among halogen acids)
    6. **Low bond dissociation energy** (F₂)

    ---

    ## Chlorine (Cl₂)

    ### Preparation

    **Laboratory - Deacon's process:**
    ```
    MnO₂ + 4HCl → MnCl₂ + Cl₂ + 2H₂O
    ```

    **Industrial - Electrolysis:**
    ```
    2NaCl + 2H₂O --electrolysis--> 2NaOH + Cl₂ + H₂
    ```

    ### Properties

    - Greenish-yellow gas, pungent odor
    - Poisonous
    - Strong oxidizing agent
    - Bleaching agent (permanent)

    ### Reactions

    **With metals:**
    ```
    2Na + Cl₂ → 2NaCl
    2Fe + 3Cl₂ → 2FeCl₃
    ```

    **With hydrogen:**
    ```
    H₂ + Cl₂ --sunlight--> 2HCl (explosive in sunlight)
    ```

    **With water:**
    ```
    Cl₂ + H₂O ⇌ HCl + HOCl (hypochlorous acid)
    ```

    **Bleaching:**
    ```
    Cl₂ + H₂O → HCl + HOCl
    HOCl → HCl + [O] (nascent oxygen oxidizes colored matter)
    ```

    ---

    ## Hydrogen Halides (HX)

    ### Preparation

    **General:**
    ```
    H₂ + X₂ → 2HX
    NaX + H₂SO₄ → NaHSO₄ + HX
    ```

    **Special for HI and HBr:**
    ```
    Use H₃PO₄ instead of H₂SO₄ (H₂SO₄ oxidizes HI, HBr)
    ```

    ### Properties

    | Property | HF | HCl | HBr | HI |
    |----------|----|----|-----|-----|
    | Physical state | Liquid | Gas | Gas | Gas |
    | Boiling point | Highest (19.5°C) | Low | Lower | Lowest |
    | Thermal stability | High | High | Medium | Low |
    | Acid strength | Weak | Strong | Strong | Strongest |
    | Reducing power | Weak | Weak | Medium | Strong |

    **Thermal stability:** HF > HCl > HBr > HI
    **Acid strength:** HI > HBr > HCl > HF
    **Reducing power:** HI > HBr > HCl > HF

    **Why HF is weak acid?**
    - Strong H-F bond (high bond dissociation energy)
    - Extensive hydrogen bonding
    - F⁻ is small, highly solvated

    **Why HI is strongest acid?**
    - Weak H-I bond (easy to break)
    - Large I⁻ ion, less solvated
    - Conjugate base more stable

    ### Uses

    **HF:**
    - Etching glass: SiO₂ + 4HF → SiF₄ + 2H₂O
    - Stored in plastic/wax bottles

    **HCl:**
    - Cleaning metals (pickling)
    - Manufacturing dyes, fertilizers

    ---

    ## Oxoacids of Halogens

    ### Chlorine Oxoacids

    | Acid | Formula | Oxidation State | Strength |
    |------|---------|-----------------|----------|
    | Hypochlorous | HOCl | +1 | Weak |
    | Chlorous | HClO₂ | +3 | Weak |
    | Chloric | HClO₃ | +5 | Strong |
    | Perchloric | HClO₄ | +7 | Strongest |

    **Acid strength:** HClO₄ > HClO₃ > HClO₂ > HOCl

    **Oxidizing power:** HOCl > HClO₂ > HClO₃ > HClO₄

    **Trend explanation:**
    - More O atoms → More electron withdrawal → Stronger acid
    - Lower oxidation state → Stronger oxidizing agent

    ### Important Reactions

    **Bleaching powder (CaOCl₂):**
    ```
    Ca(OH)₂ + Cl₂ → CaOCl₂ + H₂O
    ```

    Uses: Bleaching, disinfection

    ---

    ## Interhalogen Compounds

    **Definition:** Compounds formed between two different halogens

    **General formula:** XX'ₙ where n = 1, 3, 5, 7

    **Types:**

    - **XX':** ClF, BrF, ICl, IBr
    - **XX'₃:** ClF₃, BrF₃, ICl₃
    - **XX'₅:** ClF₅, BrF₅, IF₅
    - **XX'₇:** IF₇

    **Properties:**
    - More reactive than halogens (except F₂)
    - Covalent compounds
    - Undergo hydrolysis

    **Example structures:**
    - **ClF₃:** T-shaped (sp³d)
    - **IF₅:** Square pyramidal (sp³d²)
    - **IF₇:** Pentagonal bipyramidal (sp³d³)

    ---

    ## IIT JEE Key Points

    1. Group 17: **ns² np⁵**, need 1 electron (highly reactive)
    2. **Fluorine** most reactive, only -1 state
    3. **Electronegativity:** F > Cl > Br > I
    4. **Reactivity:** F > Cl > Br > I
    5. **Bond energy:** Cl₂ > Br₂ > F₂ > I₂ (F-F weak due to repulsion)
    6. **Acid strength:** HI > HBr > HCl > HF
    7. **Reducing power:** HI > HBr > HCl > HF
    8. **Chlorine:** Bleaching agent (permanent, via oxidation)
    9. **Oxoacid strength:** HClO₄ > HClO₃ > HClO₂ > HOCl
    10. **Interhalogen compounds:** XX'ₙ (n = 1, 3, 5, 7)
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_3, sequence_order: 4, required: true)

puts "  ✓ Lesson 6.3: #{lesson_6_3.title}"

# ========================================
# Lesson 6.4: Group 18 - Noble Gases
# ========================================

lesson_6_4 = CourseLesson.create!(
  title: 'Group 18 Elements - Noble Gases',
  reading_time_minutes: 35,
  key_concepts: ['Noble gases', 'Inert gases', 'Electronic configuration', 'Noble gas compounds', 'Xenon fluorides'],
  content: <<~MD
    # Group 18 Elements - Noble Gases

    ## Introduction

    **Group 18 elements:** Helium (He), Neon (Ne), Argon (Ar), Krypton (Kr), Xenon (Xe), Radon (Rn)

    Also called **inert gases** or **rare gases**

    **Discovery:** Most were discovered by Ramsay and Rayleigh

    ---

    ## Electronic Configuration

    **General configuration:** ns² np⁶ (except He: 1s²)

    - He (2): 1s²
    - Ne (10): [He] 2s² 2p⁶
    - Ar (18): [Ne] 3s² 3p⁶
    - Kr (36): [Ar] 3d¹⁰ 4s² 4p⁶
    - Xe (54): [Kr] 4d¹⁰ 5s² 5p⁶
    - Rn (86): [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁶

    **Key feature:** Complete octet (very stable configuration)

    ---

    ## Trends in Properties

    **Atomic radius:** He < Ne < Ar < Kr < Xe < Rn (increases)
    **Ionization energy:** He > Ne > Ar > Kr > Xe > Rn (decreases)
    **Electron gain enthalpy:** Close to zero (stable configuration)
    **Electronegativity:** Almost zero

    **Boiling point:** Increases down group
    - He has lowest boiling point of all elements (4.2 K)
    - Increases due to stronger van der Waals forces

    ---

    ## Chemical Properties

    ### Inertness

    **Reasons for inertness:**
    1. Complete octet (stable electronic configuration)
    2. High ionization energy
    3. No tendency to gain electrons (zero electron affinity)
    4. Symmetrical electron distribution

    **Exceptions:** Heavier noble gases (Kr, Xe, Rn) can form compounds

    ---

    ## Noble Gas Compounds

    ### Historical Background

    - Until 1962, noble gases considered completely inert
    - **Neil Bartlett (1962):** First noble gas compound
      ```
      Xe + PtF₆ → Xe⁺[PtF₆]⁻
      ```

    ### Conditions for Compound Formation

    **Why only Kr, Xe, Rn form compounds?**

    1. **Lower ionization energy** (easier to remove electron)
    2. **Larger atomic size** (can accommodate more bonds)
    3. **Availability of d-orbitals** (for bonding)

    **Why He, Ne, Ar don't form compounds?**
    - Very high ionization energy
    - Small size
    - No vacant d-orbitals

    **Best partner: Fluorine**
    - Most electronegative element
    - Small size
    - Can oxidize Xe, Kr

    ---

    ## Xenon Compounds

    ### Xenon Fluorides

    #### 1. Xenon Difluoride (XeF₂)

    **Preparation:**
    ```
    Xe + F₂ → XeF₂  [2:1 ratio, 673 K, 1 bar]
    ```

    **Structure:**
    - Linear shape
    - sp³d hybridization
    - 3 lone pairs (equatorial), 2 bond pairs (axial)

    **Hydrolysis:**
    ```
    2XeF₂ + 2H₂O → 2Xe + 4HF + O₂
    ```

    #### 2. Xenon Tetrafluoride (XeF₄)

    **Preparation:**
    ```
    Xe + 2F₂ → XeF₄  [1:5 ratio, 873 K, 7 bar]
    ```

    **Structure:**
    - Square planar
    - sp³d² hybridization
    - 2 lone pairs (axial), 4 bond pairs (planar)

    **Hydrolysis:**
    ```
    3XeF₄ + 6H₂O → 2Xe + XeO₃ + 12HF + 1.5O₂
    ```

    #### 3. Xenon Hexafluoride (XeF₆)

    **Preparation:**
    ```
    Xe + 3F₂ → XeF₆  [1:20 ratio, 573 K, 60 bar]
    ```

    **Structure:**
    - Distorted octahedral
    - sp³d³ hybridization
    - 1 lone pair, 6 bond pairs

    **Hydrolysis:**
    ```
    XeF₆ + 3H₂O → XeO₃ + 6HF
    ```

    **Most reactive** xenon fluoride

    ### Xenon Oxides

    **XeO₃ (Xenon trioxide):**
    ```
    XeF₆ + 3H₂O → XeO₃ + 6HF
    ```
    - Explosive solid
    - Pyramidal structure

    **XeO₄ (Xenon tetroxide):**
    - Extremely explosive
    - Tetrahedral structure

    ### Xenon Oxyfluorides

    **XeOF₂:** From XeF₂
    **XeOF₄:** From XeF₄
    **XeO₂F₂:** From XeF₆

    ---

    ## Uses of Noble Gases

    ### Helium
    - Filling balloons (lighter than air, non-flammable)
    - Diving gas mixtures (with O₂)
    - Cryogenics (liquefied He)
    - Cooling superconducting magnets (MRI machines)

    ### Neon
    - Neon signs (advertising)
    - Discharge tubes
    - Gas lasers

    ### Argon
    - Inert atmosphere for welding
    - Filling electric bulbs
    - Preservation of historical documents

    ### Krypton
    - High-speed photography (flash bulbs)
    - Filling fluorescent lamps

    ### Xenon
    - Flash lamps for photography
    - Bactericidal lamps
    - Anesthetics (in medicine)
    - Arc lamps for cinema projection

    ### Radon
    - Radiotherapy (cancer treatment)
    - Radioactive (all isotopes)

    ---

    ## IIT JEE Key Points

    1. Noble gases: **ns² np⁶** (stable octet)
    2. **Inert** due to complete octet, high IE
    3. **Monoatomic** gases (exist as single atoms)
    4. **First compound (1962):** Xe⁺[PtF₆]⁻ by Neil Bartlett
    5. **Compound formation:** Only Kr, Xe, Rn (low IE, larger size, d-orbitals)
    6. **XeF₂:** Linear (sp³d)
    7. **XeF₄:** Square planar (sp³d²)
    8. **XeF₆:** Distorted octahedral (sp³d³), most reactive
    9. **Helium:** Lowest boiling point (4.2 K)
    10. **Trend:** Boiling point, atomic radius increase; IE decreases down group
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_4, sequence_order: 5, required: true)

puts "  ✓ Lesson 6.4: #{lesson_6_4.title}"

# ========================================
# Comprehensive Quiz for Module 6
# ========================================

quiz_6_comprehensive = Quiz.create!(
  title: 'p-Block Groups 15-18 - Comprehensive Assessment',
  description: 'Comprehensive test covering all p-block groups',
  time_limit_minutes: 45,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_6, item: quiz_6_comprehensive, sequence_order: 6, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_6_comprehensive,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which Group 16 element exists as diatomic molecules at room temperature?',
    options: [
      { text: 'Oxygen (O₂)', correct: true },
      { text: 'Sulfur (S₈)', correct: false },
      { text: 'Selenium', correct: false },
      { text: 'Tellurium', correct: false }
    ],
    explanation: 'Oxygen exists as diatomic O₂ molecules. Sulfur exists as S₈ rings, while Se and Te are polymeric solids.',
    points: 2,
    difficulty: -0.4,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'group_16',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  {
    quiz: quiz_6_comprehensive,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'The bleaching action of SO₂ is:',
    options: [
      { text: 'Temporary (due to reduction)', correct: true },
      { text: 'Permanent (due to oxidation)', correct: false },
      { text: 'Temporary (due to oxidation)', correct: false },
      { text: 'Permanent (due to reduction)', correct: false }
    ],
    explanation: 'SO₂ bleaches by reduction forming colorless compounds, which can revert back to colored form. Cl₂ bleaches permanently by oxidation.',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'sulfur_compounds',
    skill_dimension: 'comprehension',
    sequence_order: 2
  },

  {
    quiz: quiz_6_comprehensive,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which statements about halogens are correct?',
    options: [
      { text: 'Fluorine is most reactive halogen', correct: true },
      { text: 'HI is strongest halogen acid', correct: true },
      { text: 'F₂ has highest bond dissociation energy', correct: false },
      { text: 'All halogens can show positive oxidation states', correct: false }
    ],
    explanation: 'F is most reactive, HI is strongest acid. But F₂ has lower bond energy than Cl₂ (repulsion). Only Cl, Br, I show positive states; F only shows -1.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'halogens',
    skill_dimension: 'comprehension',
    sequence_order: 3
  },

  {
    quiz: quiz_6_comprehensive,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which noble gas compound has square planar structure?',
    options: [
      { text: 'XeF₄', correct: true },
      { text: 'XeF₂', correct: false },
      { text: 'XeF₆', correct: false },
      { text: 'XeO₃', correct: false }
    ],
    explanation: 'XeF₄ has square planar structure (sp³d² hybridization, 2 lone pairs axial, 4 bond pairs planar). XeF₂ is linear, XeF₆ is distorted octahedral.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'noble_gases',
    skill_dimension: 'recall',
    sequence_order: 4
  },

  {
    quiz: quiz_6_comprehensive,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In Contact process for H₂SO₄ production, which catalyst is used?',
    options: [
      { text: 'V₂O₅ (Vanadium pentoxide)', correct: true },
      { text: 'Pt (Platinum)', correct: false },
      { text: 'Fe (Iron)', correct: false },
      { text: 'MnO₂ (Manganese dioxide)', correct: false }
    ],
    explanation: 'Contact process uses V₂O₅ as catalyst for oxidation: 2SO₂ + O₂ → 2SO₃. Pt is used in Ostwald process (HNO₃), Fe in Haber (NH₃).',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'industrial_processes',
    skill_dimension: 'recall',
    sequence_order: 5
  },

  {
    quiz: quiz_6_comprehensive,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Ozone layer depletion is primarily caused by:',
    options: [
      { text: 'Chlorine radicals from CFCs', correct: true },
      { text: 'Carbon dioxide', correct: false },
      { text: 'Sulfur dioxide', correct: false },
      { text: 'Nitrogen oxides only', correct: false }
    ],
    explanation: 'CFCs release Cl radicals which catalytically destroy ozone: Cl + O₃ → ClO + O₂; ClO + O → Cl + O₂. Net: O₃ + O → 2O₂.',
    points: 3,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'environmental_chemistry',
    skill_dimension: 'comprehension',
    sequence_order: 6
  }
])

puts "  ✓ Quiz: #{quiz_6_comprehensive.title} (#{quiz_6_comprehensive.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 6 COMPLETE: p-Block Elements (Groups 15-18)"
puts "Total Lessons: 4"
puts "Total Quizzes: 2"
puts "=" * 80

# frozen_string_literal: true

# ========================================
# IIT JEE Inorganic Chemistry - Module 4
# s-Block Elements (Alkali & Alkaline Earth Metals)
# ========================================
# Complete module with lessons and questions
# Groups 1 and 2 of periodic table
# ========================================

puts "\n" + "=" * 80
puts "MODULE 4: s-BLOCK ELEMENTS"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Inorganic Chemistry course not found!"
  puts "   Please run db/seeds/iit_jee_inorganic_chemistry.rb first"
  exit 1
end

# Create Module 4: s-Block Elements
module_4 = course.course_modules.find_or_create_by!(slug: 's-block-elements') do |m|
  m.title = 's-Block Elements'
  m.sequence_order = 4
  m.estimated_minutes = 480  # 8 hours
  m.description = 'Alkali metals (Group 1) and Alkaline earth metals (Group 2) - properties, compounds, and reactions'
  m.learning_objectives = [
    'Understand properties and trends in Group 1 (Alkali metals)',
    'Master properties and trends in Group 2 (Alkaline earth metals)',
    'Learn anomalous behavior of Li and Be',
    'Understand diagonal relationships (Li-Mg, Be-Al)',
    'Master important compounds and their uses',
    'Solve IIT JEE problems on s-block chemistry'
  ]
  m.published = true
end

puts "✅ Module 4: #{module_4.title}"

# ========================================
# Lesson 4.1: Group 1 - Alkali Metals
# ========================================

lesson_4_1 = CourseLesson.create!(
  title: 'Group 1 - Alkali Metals (Li, Na, K, Rb, Cs, Fr)',
  reading_time_minutes: 35,
  key_concepts: ['Alkali metals', 'Electronic configuration', 'Physical properties', 'Chemical reactivity', 'Flame colors'],
  content: <<~MD
    # Group 1 - Alkali Metals

    ## Introduction

    Group 1 elements are called **alkali metals** because they form alkalis (strong bases) when they react with water.

    **Members:** Lithium (Li), Sodium (Na), Potassium (K), Rubidium (Rb), Cesium (Cs), Francium (Fr)

    ## Electronic Configuration

    All alkali metals have **one valence electron** in their outermost s-orbital.

    - Li: [He] 2s¹
    - Na: [Ne] 3s¹
    - K: [Ar] 4s¹
    - Rb: [Kr] 5s¹
    - Cs: [Xe] 6s¹
    - Fr: [Rn] 7s¹

    This single valence electron makes them highly reactive and gives them similar chemical properties.

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group:** Li < Na < K < Rb < Cs < Fr
    - Reason: Addition of new electron shells
    - Alkali metals have the **largest atomic radii** in their respective periods

    ### Ionization Energy (IE)
    - **Decreases down the group:** Li > Na > K > Rb > Cs > Fr
    - Reason: Increasing atomic size, valence electron farther from nucleus
    - Alkali metals have the **lowest ionization energies** in their periods
    - Easy to lose the valence electron → +1 oxidation state

    ### Electronegativity
    - **Decreases down the group:** Li > Na > K > Rb > Cs > Fr
    - Very low electronegativity (highly electropositive)

    ### Density
    - Generally **increases down the group**
    - Exception: K < Na (due to large increase in atomic size)
    - Li, Na, K are less dense than water

    ### Melting and Boiling Points
    - **Decrease down the group:** Li > Na > K > Rb > Cs > Fr
    - Reason: Weaker metallic bonding with increasing size
    - Alkali metals are soft and have low melting points

    ### Physical State and Appearance
    - All are soft, silvery-white metals
    - Can be cut with a knife
    - Freshly cut surface is shiny but tarnishes quickly in air

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    All alkali metals react vigorously with oxygen, but products differ:

    **Lithium (Normal oxide):**
    4Li + O₂ → 2Li₂O (Lithium oxide)

    **Sodium (Peroxide):**
    2Na + O₂ → Na₂O₂ (Sodium peroxide)

    **K, Rb, Cs (Superoxide):**
    K + O₂ → KO₂ (Potassium superoxide)

    **Trend:** Normal oxide → Peroxide → Superoxide (down the group)

    ### 2. Reaction with Water

    All alkali metals react with water to form hydroxides and hydrogen gas:

    2M + 2H₂O → 2MOH + H₂↑

    **Reactivity increases down the group:** Li < Na < K < Rb < Cs

    - Li: Reacts steadily, floats
    - Na: Reacts vigorously, melts into a ball, floats
    - K: Reacts violently, catches fire (lilac flame), floats
    - Rb, Cs: Explosive reaction

    ### 3. Reaction with Halogens

    Form ionic halides (MX):

    2M + X₂ → 2MX

    - Highly exothermic reactions
    - Reactivity: F₂ > Cl₂ > Br₂ > I₂

    ### 4. Reaction with Hydrogen

    Form ionic hydrides (MH):

    2M + H₂ → 2MH (at high temperature)

    - These are strong reducing agents
    - Example: LiH, NaH

    ### 5. Reducing Nature

    Alkali metals are **strong reducing agents**.

    **Reducing power:** Li > Na > K > Rb > Cs (in aqueous solution)

    **Why is Li the strongest reducer?**
    - High hydration enthalpy due to small size
    - Compensates for high ionization energy

    ## Flame Colors

    Alkali metals impart characteristic colors to flame:

    | Element | Flame Color | Wavelength Range |
    |---------|-------------|------------------|
    | Li | Crimson red | 670 nm |
    | Na | Golden yellow | 589 nm |
    | K | Lilac/Violet | 766 nm |
    | Rb | Red-violet | - |
    | Cs | Blue | - |

    **Reason:** Excitation of valence electron by heat energy

    ## Solutions in Liquid Ammonia

    Alkali metals dissolve in liquid ammonia to form blue solutions:

    M + (x+y)NH₃ → [M(NH₃)ₓ]⁺ + [e(NH₃)ᵧ]⁻

    - Dilute solutions: Blue color (due to ammoniated electrons)
    - Concentrated solutions: Bronze color (metallic luster)
    - Solutions are good conductors of electricity
    - Paramagnetic due to unpaired electrons

    ## Anomalous Properties of Lithium

    Lithium differs from other alkali metals due to its **small size** and **high charge density**:

    1. **Hardest** alkali metal
    2. **Highest melting and boiling points**
    3. **Least reactive** with water
    4. Forms **covalent compounds** (e.g., LiCl has some covalent character)
    5. **Decomposes on heating:** 4LiNO₃ → 2Li₂O + 4NO₂ + O₂ (other alkali metal nitrates give nitrites)
    6. **LiOH is less basic** than other alkali metal hydroxides
    7. **Li₂CO₃ decomposes on heating** (others don't)
    8. **Does not form superoxide** (only normal oxide)

    ## Diagonal Relationship: Li and Mg

    Lithium shows similarity with Magnesium (diagonal element) due to similar charge/size ratio:

    | Property | Similarity |
    |----------|-----------|
    | Hardness | Both are harder than group members |
    | Carbonate | Both carbonates decompose on heating |
    | Nitrate | Both nitrates give oxides on heating |
    | Hydroxide | Both hydroxides are weak bases |
    | Bicarbonate | Neither forms solid bicarbonates |
    | Organometallic | Both form organometallic compounds |

    ## Important Compounds of Alkali Metals

    ### Sodium Hydroxide (NaOH) - Caustic Soda
    - **Preparation:** Chlor-alkali process (electrolysis of brine)
    - **Uses:** Soap making, paper industry, petroleum refining

    ### Sodium Carbonate (Na₂CO₃·10H₂O) - Washing Soda
    - **Preparation:** Solvay process (ammonia-soda process)
    - **Uses:** Water softening, glass manufacturing, cleaning

    ### Sodium Bicarbonate (NaHCO₃) - Baking Soda
    - **Preparation:** From washing soda and CO₂
    - **Uses:** Baking powder, antacid, fire extinguisher

    ### Sodium Chloride (NaCl) - Common Salt
    - **Source:** Sea water, rock salt
    - **Uses:** Food preservation, raw material for chemicals

    ### Sodium Thiosulfate (Na₂S₂O₃·5H₂O) - Hypo
    - **Uses:** Photography (fixing agent), dechlorination

    ## IIT JEE Key Points

    1. Alkali metals have **one valence electron** (ns¹)
    2. **Reactivity increases** down the group (Li < Na < K < Rb < Cs)
    3. **Reducing power in solution:** Li > Na > K > Rb > Cs
    4. Flame colors: Li (crimson), Na (yellow), K (lilac)
    5. **Lithium is anomalous** due to small size
    6. **Diagonal relationship:** Li resembles Mg
    7. Oxide formation: Li (oxide), Na (peroxide), K/Rb/Cs (superoxide)
    8. All form **ionic compounds** (except Li shows some covalent character)
  MD
)

ModuleItem.create!(course_module: module_4, item: lesson_4_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 4.1: #{lesson_4_1.title}"

# ========================================
# Quiz 4.1: Alkali Metals
# ========================================

quiz_4_1 = Quiz.create!(
  title: 'Alkali Metals - Properties and Reactions',
  description: 'Test your understanding of Group 1 elements',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_4, item: quiz_4_1, sequence_order: 2, required: true)

# Questions for Quiz 4.1
QuizQuestion.create!([
  # Question 1: Periodic trend - Easy
  {
    quiz: quiz_4_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which alkali metal has the highest ionization energy?',
    options: [
      { text: 'Lithium', correct: true },
      { text: 'Sodium', correct: false },
      { text: 'Potassium', correct: false },
      { text: 'Cesium', correct: false }
    ],
    explanation: 'Ionization energy decreases down the group due to increasing atomic size. Lithium has the smallest atomic radius, so highest ionization energy among alkali metals.',
    points: 2,
    difficulty: -0.5,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'periodic_trends',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: Multi-correct - Hard
  {
    quiz: quiz_4_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are anomalous properties of lithium?',
    options: [
      { text: 'It is the hardest alkali metal', correct: true },
      { text: 'It forms superoxide when heated in oxygen', correct: false },
      { text: 'Its carbonate decomposes on heating', correct: true },
      { text: 'Its nitrate gives oxide on heating (not nitrite)', correct: true }
    ],
    explanation: 'Lithium is anomalous due to small size. It is hardest, Li₂CO₃ decomposes (Li₂CO₃ → Li₂O + CO₂), and LiNO₃ gives oxide (4LiNO₃ → 2Li₂O + 4NO₂ + O₂). Li forms only normal oxide (Li₂O), not superoxide.',
    points: 4,
    difficulty: 1.0,
    discrimination: 1.5,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'anomalous_behavior',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 2
  },

  # Question 3: Flame color - Easy
  {
    quiz: quiz_4_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What color does sodium impart to the flame?',
    options: [
      { text: 'Crimson red', correct: false },
      { text: 'Golden yellow', correct: true },
      { text: 'Lilac', correct: false },
      { text: 'Blue', correct: false }
    ],
    explanation: 'Sodium gives golden yellow flame (589 nm). Li gives crimson red, K gives lilac, and Cs gives blue.',
    points: 1,
    difficulty: -0.8,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'flame_colors',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  # Question 4: Reducing power - Medium
  {
    quiz: quiz_4_1,
    question_type: 'sequence',
    question_text: 'Arrange the following alkali metals in order of DECREASING reducing power in aqueous solution:',
    sequence_items: [
      { id: 1, text: 'Lithium (Li)' },
      { id: 2, text: 'Sodium (Na)' },
      { id: 3, text: 'Potassium (K)' },
      { id: 4, text: 'Cesium (Cs)' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'In aqueous solution: Li > Na > K > Cs. Lithium is the strongest reducer due to high hydration enthalpy that compensates for its high ionization energy.',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'reducing_power',
    skill_dimension: 'application',
    sequence_order: 4
  },

  # Question 5: Oxide formation - Medium
  {
    quiz: quiz_4_1,
    question_type: 'fill_blank',
    question_text: 'When potassium reacts with excess oxygen, it forms _______ (type of oxide).',
    correct_answer: 'superoxide|KO2|potassium superoxide',
    explanation: 'Potassium forms superoxide (KO₂) when heated in excess oxygen. Lithium forms normal oxide (Li₂O), sodium forms peroxide (Na₂O₂), and heavier alkali metals (K, Rb, Cs) form superoxides.',
    points: 2,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'chemical_reactions',
    skill_dimension: 'application',
    sequence_order: 5
  },

  # Question 6: Diagonal relationship - Medium
  {
    quiz: quiz_4_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Lithium shows diagonal relationship with magnesium. Which properties support this?',
    options: [
      { text: 'Both carbonates decompose on heating', correct: true },
      { text: 'Both form superoxides', correct: false },
      { text: 'Both nitrates give oxides on heating', correct: true },
      { text: 'Both are highly soluble in water', correct: false }
    ],
    explanation: 'Li and Mg show diagonal relationship due to similar charge density. Both Li₂CO₃ and MgCO₃ decompose on heating. Both LiNO₃ and Mg(NO₃)₂ give oxides on heating. Neither forms superoxides, and both have low solubility compounds.',
    points: 4,
    difficulty: 0.7,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'diagonal_relationship',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 6
  },

  # Question 7: Equation balancing - Hard
  {
    quiz: quiz_4_1,
    question_type: 'equation_balance',
    question_text: 'Balance the equation for the reaction of potassium with water:' + "\n" +
                    'K + H₂O → KOH + H₂',
    correct_answer: '2 K + 2 H2O -> 2 KOH + H2',
    explanation: '2K + 2H₂O → 2KOH + H₂. All alkali metals react with water to form hydroxides and hydrogen gas. The reaction becomes more vigorous down the group.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'chemical_equations',
    skill_dimension: 'problem_solving',
    sequence_order: 7
  },

  # Question 8: True/False - Easy
  {
    quiz: quiz_4_1,
    question_type: 'true_false',
    question_text: 'All alkali metal hydroxides are strong bases.',
    correct_answer: 'true',
    explanation: 'TRUE. All alkali metal hydroxides (LiOH, NaOH, KOH, etc.) are strong bases because they completely dissociate in water. However, LiOH is relatively less basic than others.',
    points: 1,
    difficulty: -0.3,
    discrimination: 0.9,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'chemical_properties',
    skill_dimension: 'recall',
    sequence_order: 8
  },

  # Question 9: Density anomaly - Medium
  {
    quiz: quiz_4_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which alkali metal shows an anomalous trend in density?',
    options: [
      { text: 'Lithium - highest density', correct: false },
      { text: 'Potassium - less dense than sodium', correct: true },
      { text: 'Cesium - lowest density', correct: false },
      { text: 'No anomaly in density trend', correct: false }
    ],
    explanation: 'Potassium is less dense than sodium (K < Na) despite being below it in the group. This is anomalous because density generally increases down the group. The large increase in atomic volume of K overshadows the mass increase.',
    points: 3,
    difficulty: 0.6,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'physical_properties',
    skill_dimension: 'application',
    sequence_order: 9
  },

  # Question 10: Liquid ammonia - Hard
  {
    quiz: quiz_4_1,
    question_type: 'fill_blank',
    question_text: 'Dilute solutions of alkali metals in liquid ammonia are _______ colored due to ammoniated electrons.',
    correct_answer: 'blue',
    explanation: 'Alkali metals dissolve in liquid ammonia to give blue solutions due to ammoniated electrons [e(NH₃)ₓ]⁻. Concentrated solutions are bronze colored with metallic luster.',
    points: 2,
    difficulty: 0.8,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'special_properties',
    skill_dimension: 'recall',
    sequence_order: 10
  }
])

puts "  ✓ Quiz 4.1: #{quiz_4_1.quiz_questions.count} questions created"

# ========================================
# Lesson 4.2: Group 2 - Alkaline Earth Metals
# ========================================

lesson_4_2 = CourseLesson.create!(
  title: 'Group 2 - Alkaline Earth Metals (Be, Mg, Ca, Sr, Ba, Ra)',
  reading_time_minutes: 40,
  key_concepts: ['Alkaline earth metals', 'Beryllium anomaly', 'Calcium compounds', 'Hardness of water'],
  content: <<~MD
    # Group 2 - Alkaline Earth Metals

    ## Introduction

    Group 2 elements are called **alkaline earth metals** because their oxides and hydroxides are alkaline and are found in earth's crust.

    **Members:** Beryllium (Be), Magnesium (Mg), Calcium (Ca), Strontium (Sr), Barium (Ba), Radium (Ra)

    ## Electronic Configuration

    All alkaline earth metals have **two valence electrons** in their outermost s-orbital.

    - Be: [He] 2s²
    - Mg: [Ne] 3s²
    - Ca: [Ar] 4s²
    - Sr: [Kr] 5s²
    - Ba: [Xe] 6s²
    - Ra: [Rn] 7s²

    Common oxidation state: **+2**

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group:** Be < Mg < Ca < Sr < Ba < Ra
    - Smaller than corresponding alkali metals (same period)
    - Reason: Higher nuclear charge with same number of shells

    ### Ionization Energy
    - **Decreases down the group:** Be > Mg > Ca > Sr > Ba > Ra
    - Higher than alkali metals (need to remove 2 electrons)
    - Still relatively low → readily form M²⁺ ions

    ### Electronegativity
    - **Decreases down the group:** Be > Mg > Ca > Sr > Ba > Ra
    - Lower than alkali metals in same period

    ### Density
    - **Increases down the group:** Be < Mg < Ca < Sr < Ba < Ra
    - Higher than alkali metals

    ### Melting and Boiling Points
    - **Decrease down the group** (except Mg < Ca)
    - Higher than alkali metals (stronger metallic bonding)

    ### Hardness
    - **Harder than alkali metals**
    - Beryllium is the hardest
    - Decreases down the group

    ### Physical Appearance
    - Silvery-white metals
    - Less reactive than alkali metals (but still reactive)

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    Form ionic oxides (MO):

    2M + O₂ → 2MO

    - BeO: Amphoteric (reacts with both acids and bases)
    - Other oxides: Basic
    - **Basicity increases down the group:** BeO < MgO < CaO < SrO < BaO

    ### 2. Reaction with Water

    **Beryllium:** Does not react with water (protective oxide layer)

    **Magnesium:** Reacts slowly with cold water, rapidly with hot water:
    Mg + 2H₂O → Mg(OH)₂ + H₂

    **Ca, Sr, Ba:** React readily with cold water:
    M + 2H₂O → M(OH)₂ + H₂

    **Reactivity:** Be < Mg < Ca < Sr < Ba

    ### 3. Reaction with Acids

    React with dilute acids to give hydrogen gas:

    M + 2HCl → MCl₂ + H₂↑

    ### 4. Reaction with Halogens

    Form ionic halides (MX₂):

    M + X₂ → MX₂

    - BeCl₂ has covalent character (polymeric structure)
    - Other halides are predominantly ionic

    ### 5. Reaction with Hydrogen

    Form hydrides (MH₂) at high temperature:

    M + H₂ → MH₂

    - BeH₂ is covalent (polymeric)
    - Others are ionic

    ### 6. Reducing Nature

    Alkaline earth metals are **reducing agents** (but weaker than alkali metals).

    **Reducing power:** Ba > Sr > Ca > Mg > Be

    ## Solubility of Salts

    ### Hydroxides: M(OH)₂
    **Solubility and basicity increase down the group:**
    Be(OH)₂ < Mg(OH)₂ < Ca(OH)₂ < Sr(OH)₂ < Ba(OH)₂

    - Be(OH)₂: Amphoteric, sparingly soluble
    - Mg(OH)₂: Sparingly soluble, weak base
    - Ca(OH)₂: Moderately soluble (lime water)
    - Ba(OH)₂: Quite soluble, strong base

    ### Sulfates: MSO₄
    **Solubility decreases down the group:**
    BeSO₄ > MgSO₄ > CaSO₄ > SrSO₄ > BaSO₄

    - BaSO₄: Almost insoluble (used in medical imaging)
    - Hydration enthalpy decreases faster than lattice energy

    ### Carbonates: MCO₃
    **Thermal stability increases down the group:**
    BeCO₃ < MgCO₃ < CaCO₃ < SrCO₃ < BaCO₃

    All decompose on heating:
    MCO₃ → MO + CO₂

    - BeCO₃ and MgCO₃: Least stable
    - BaCO₃: Most stable

    ## Anomalous Properties of Beryllium

    Beryllium differs from other alkaline earth metals due to **very small size** and **high ionization energy**:

    1. **Hardest** and **highest melting point**
    2. **Does not react with water** (protective oxide layer)
    3. Forms **covalent compounds** (BeCl₂, BeH₂ are covalent polymers)
    4. **BeO and Be(OH)₂ are amphoteric** (others are basic)
    5. **Does not form complexes easily** (except with fluoride: [BeF₄]²⁻)
    6. **Carbonate unstable** (BeCO₃ exists only in solution)
    7. Forms **coordinate covalent bonds** in many compounds

    ## Diagonal Relationship: Be and Al

    Beryllium shows similarity with Aluminium:

    | Property | Similarity |
    |----------|-----------|
    | Oxide | Both BeO and Al₂O₃ are amphoteric |
    | Hydroxide | Both Be(OH)₂ and Al(OH)₃ are amphoteric |
    | Carbide | Both form carbides that give methane with water |
    | Chloride | Both BeCl₂ and AlCl₃ are covalent, hygroscopic |
    | Complex formation | Both form complex fluorides |

    ## Important Compounds

    ### Calcium Oxide (CaO) - Quick Lime
    **Preparation:** Thermal decomposition of limestone
    CaCO₃ → CaO + CO₂ (at 1200 K)

    **Uses:** Manufacture of cement, slaked lime, mortar

    ### Calcium Hydroxide - Ca(OH)₂ - Slaked Lime
    **Preparation:** CaO + H₂O → Ca(OH)₂ + Heat

    **Uses:** Mortar, white wash, softening hard water

    ### Calcium Carbonate (CaCO₃)
    **Forms:** Limestone, marble, chalk

    **Uses:** Manufacture of lime, cement, glass

    ### Plaster of Paris - CaSO₄·½H₂O
    **Preparation:** Heating gypsum at 393 K
    CaSO₄·2H₂O → CaSO₄·½H₂O + 1½H₂O

    **Property:** Sets to a hard mass (gypsum) when mixed with water
    CaSO₄·½H₂O + 1½H₂O → CaSO₄·2H₂O

    **Uses:** Casts, molds, surgical bandages

    ### Gypsum - CaSO₄·2H₂O
    **Uses:** Manufacture of plaster of paris, cement retardant

    ### Magnesium Hydroxide - Mg(OH)₂ - Milk of Magnesia
    **Uses:** Antacid, laxative

    ### Magnesium Sulfate - MgSO₄·7H₂O - Epsom Salt
    **Uses:** Purgative, in tanning, dyeing

    ## Hardness of Water

    Water containing dissolved Ca²⁺ and Mg²⁺ salts is called **hard water**.

    ### Types of Hardness

    **1. Temporary Hardness (Carbonate hardness)**
    - Due to: Ca(HCO₃)₂, Mg(HCO₃)₂
    - **Removal:** Boiling
      - Ca(HCO₃)₂ → CaCO₃↓ + H₂O + CO₂
      - Mg(HCO₃)₂ → MgCO₃↓ + H₂O + CO₂
    - **Removal:** Clark's method (adding lime)
      - Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O

    **2. Permanent Hardness (Non-carbonate hardness)**
    - Due to: CaSO₄, CaCl₂, MgSO₄, MgCl₂
    - **Cannot be removed by boiling**
    - **Removal methods:**
      - **Washing soda:** Na₂CO₃ + CaSO₄ → CaCO₃↓ + Na₂SO₄
      - **Ion exchange resins:** Replace Ca²⁺, Mg²⁺ with Na⁺ or H⁺
      - **Calgon's method:** Sodium hexametaphosphate complexes Ca²⁺, Mg²⁺

    ## Flame Colors

    | Element | Flame Color |
    |---------|-------------|
    | Be | No distinct color |
    | Mg | No distinct color |
    | Ca | Brick red |
    | Sr | Crimson red |
    | Ba | Apple green |

    ## Biological Importance

    - **Mg²⁺:** Essential for chlorophyll (photosynthesis)
    - **Ca²⁺:** Bones, teeth, blood clotting, muscle contraction

    ## IIT JEE Key Points

    1. Alkaline earth metals have **two valence electrons** (ns²)
    2. **Reactivity increases** down the group
    3. **Beryllium is anomalous** (smallest size, covalent compounds)
    4. **Diagonal relationship:** Be resembles Al
    5. **Solubility of hydroxides increases** down the group
    6. **Solubility of sulfates decreases** down the group
    7. **Thermal stability of carbonates increases** down the group
    8. Hard water: Temporary (bicarbonates) vs Permanent (sulfates, chlorides)
    9. Plaster of Paris: CaSO₄·½H₂O (sets to gypsum)
    10. Flame colors: Ca (brick red), Sr (crimson), Ba (green)
  MD
)

ModuleItem.create!(course_module: module_4, item: lesson_4_2, sequence_order: 3, required: true)

puts "  ✓ Lesson 4.2: #{lesson_4_2.title}"

# ========================================
# Quiz 4.2: Alkaline Earth Metals
# ========================================

quiz_4_2 = Quiz.create!(
  title: 'Alkaline Earth Metals - Properties and Compounds',
  description: 'Test your understanding of Group 2 elements',
  time_limit_minutes: 35,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_4, item: quiz_4_2, sequence_order: 4, required: true)

# Questions for Quiz 4.2 (15 questions)
QuizQuestion.create!([
  # Question 1: Beryllium anomaly - Medium
  {
    quiz: quiz_4_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are anomalous properties of beryllium?',
    options: [
      { text: 'BeO is amphoteric', correct: true },
      { text: 'BeCl₂ is covalent', correct: true },
      { text: 'Be reacts vigorously with water', correct: false },
      { text: 'BeSO₄ is insoluble in water', correct: false }
    ],
    explanation: 'Beryllium is anomalous due to small size and high charge density. BeO and Be(OH)₂ are amphoteric, BeCl₂ is covalent (polymeric). Be does NOT react with water (protective oxide layer), and BeSO₄ is soluble.',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'anomalous_behavior',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 1
  },

  # Question 2: Solubility trend - Medium
  {
    quiz: quiz_4_2,
    question_type: 'sequence',
    question_text: 'Arrange the following sulfates in order of INCREASING solubility in water:',
    sequence_items: [
      { id: 1, text: 'BaSO₄' },
      { id: 2, text: 'SrSO₄' },
      { id: 3, text: 'CaSO₄' },
      { id: 4, text: 'MgSO₄' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Solubility of sulfates DECREASES down the group: BaSO₄ < SrSO₄ < CaSO₄ < MgSO₄ < BeSO₄. BaSO₄ is almost insoluble (used in barium meal for X-rays).',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'solubility_trends',
    skill_dimension: 'application',
    sequence_order: 2
  },

  # Question 3: Plaster of Paris - Easy
  {
    quiz: quiz_4_2,
    question_type: 'fill_blank',
    question_text: 'The chemical formula of Plaster of Paris is _______.',
    correct_answer: 'CaSO4.1/2H2O|CaSO₄·½H₂O|(CaSO4)2.H2O|CaSO4.0.5H2O',
    explanation: 'Plaster of Paris is calcium sulfate hemihydrate: CaSO₄·½H₂O or (CaSO₄)₂·H₂O. It is prepared by heating gypsum (CaSO₄·2H₂O) at 393 K.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'important_compounds',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  # Question 4: Hardness of water - Medium
  {
    quiz: quiz_4_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following causes temporary hardness in water?',
    options: [
      { text: 'CaSO₄', correct: false },
      { text: 'Ca(HCO₃)₂', correct: true },
      { text: 'CaCl₂', correct: false },
      { text: 'MgSO₄', correct: false }
    ],
    explanation: 'Temporary hardness is caused by bicarbonates: Ca(HCO₃)₂ and Mg(HCO₃)₂. It can be removed by boiling. Permanent hardness is caused by sulfates and chlorides (CaSO₄, CaCl₂, MgSO₄, MgCl₂).',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'hardness_of_water',
    skill_dimension: 'application',
    sequence_order: 4
  },

  # Question 5: Thermal stability - Hard
  {
    quiz: quiz_4_2,
    question_type: 'sequence',
    question_text: 'Arrange the following carbonates in order of INCREASING thermal stability:',
    sequence_items: [
      { id: 1, text: 'BeCO₃' },
      { id: 2, text: 'MgCO₃' },
      { id: 3, text: 'CaCO₃' },
      { id: 4, text: 'BaCO₃' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Thermal stability of carbonates INCREASES down the group: BeCO₃ < MgCO₃ < CaCO₃ < SrCO₃ < BaCO₃. Smaller cations have higher polarizing power, making the carbonate more unstable.',
    points: 4,
    difficulty: 0.8,
    discrimination: 1.4,
    guessing: 0.04,
    difficulty_level: 'hard',
    topic: 'thermal_stability',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 5
  },

  # Question 6: Flame color - Easy
  {
    quiz: quiz_4_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which alkaline earth metal gives an apple green flame?',
    options: [
      { text: 'Calcium', correct: false },
      { text: 'Strontium', correct: false },
      { text: 'Barium', correct: true },
      { text: 'Magnesium', correct: false }
    ],
    explanation: 'Barium gives apple green flame. Calcium gives brick red, Strontium gives crimson red, and Mg/Be don\'t give characteristic flame colors.',
    points: 1,
    difficulty: -0.5,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'flame_colors',
    skill_dimension: 'recall',
    sequence_order: 6
  },

  # Question 7: Diagonal relationship - Medium
  {
    quiz: quiz_4_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Beryllium shows diagonal relationship with aluminium. Which properties are similar?',
    options: [
      { text: 'Both oxides are amphoteric', correct: true },
      { text: 'Both chlorides are covalent and hygroscopic', correct: true },
      { text: 'Both react vigorously with water', correct: false },
      { text: 'Both form [M(H₂O)₆]²⁺ ions', correct: false }
    ],
    explanation: 'Be and Al show diagonal relationship. Both BeO and Al₂O₃ are amphoteric, both BeCl₂ and AlCl₃ are covalent and hygroscopic. Be does not react with water, and Be forms [Be(H₂O)₄]²⁺, not 6-coordinate.',
    points: 4,
    difficulty: 0.7,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'diagonal_relationship',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 7
  },

  # Question 8: Equation - Medium
  {
    quiz: quiz_4_2,
    question_type: 'equation_balance',
    question_text: 'Balance the thermal decomposition of calcium carbonate:' + "\n" +
                    'CaCO₃ → CaO + CO₂',
    correct_answer: 'CaCO3 -> CaO + CO2',
    explanation: 'CaCO₃ → CaO + CO₂ (already balanced). This reaction occurs at high temperature (~1200 K) and is the basis for manufacturing quicklime from limestone.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'chemical_equations',
    skill_dimension: 'problem_solving',
    sequence_order: 8
  },

  # Question 9: Hydroxide basicity - Medium
  {
    quiz: quiz_4_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following is the strongest base?',
    options: [
      { text: 'Be(OH)₂', correct: false },
      { text: 'Mg(OH)₂', correct: false },
      { text: 'Ca(OH)₂', correct: false },
      { text: 'Ba(OH)₂', correct: true }
    ],
    explanation: 'Basicity of hydroxides increases down the group: Be(OH)₂ < Mg(OH)₂ < Ca(OH)₂ < Sr(OH)₂ < Ba(OH)₂. Ba(OH)₂ is the strongest base. Be(OH)₂ is amphoteric.',
    points: 2,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'chemical_properties',
    skill_dimension: 'application',
    sequence_order: 9
  },

  # Question 10: Gypsum - Easy
  {
    quiz: quiz_4_2,
    question_type: 'numerical',
    question_text: 'How many water molecules of crystallization are present in gypsum (CaSO₄·xH₂O)? Enter the value of x.',
    correct_answer: '2',
    tolerance: 0.0,
    explanation: 'Gypsum is CaSO₄·2H₂O (calcium sulfate dihydrate). When heated at 393 K, it loses 1.5 molecules of water to form Plaster of Paris (CaSO₄·½H₂O).',
    points: 1,
    difficulty: -0.6,
    discrimination: 0.9,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'important_compounds',
    skill_dimension: 'recall',
    sequence_order: 10
  },

  # Question 11: Clark's method - Hard
  {
    quiz: quiz_4_2,
    question_type: 'equation_balance',
    question_text: 'Balance the equation for Clark\'s method of removing temporary hardness:' + "\n" +
                    'Ca(HCO₃)₂ + Ca(OH)₂ → CaCO₃ + H₂O',
    correct_answer: 'Ca(HCO3)2 + Ca(OH)2 -> 2 CaCO3 + 2 H2O',
    explanation: 'Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O. Clark\'s method removes temporary hardness by adding calculated amount of lime [Ca(OH)₂] to precipitate calcium carbonate.',
    points: 3,
    difficulty: 0.6,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'hardness_of_water',
    skill_dimension: 'problem_solving',
    sequence_order: 11
  },

  # Question 12: Amphoteric nature - Medium
  {
    quiz: quiz_4_2,
    question_type: 'true_false',
    question_text: 'Beryllium oxide (BeO) reacts with both acids and bases.',
    correct_answer: 'true',
    explanation: 'TRUE. BeO is amphoteric. It reacts with acids: BeO + 2HCl → BeCl₂ + H₂O, and with bases: BeO + 2NaOH → Na₂BeO₂ + H₂O (sodium beryllate).',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'anomalous_behavior',
    skill_dimension: 'recall',
    sequence_order: 12
  },

  # Question 13: Removal of permanent hardness - Medium
  {
    quiz: quiz_4_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which methods can remove permanent hardness of water?',
    options: [
      { text: 'Boiling', correct: false },
      { text: 'Adding washing soda (Na₂CO₃)', correct: true },
      { text: 'Ion exchange resins', correct: true },
      { text: 'Adding slaked lime', correct: false }
    ],
    explanation: 'Permanent hardness (due to sulfates/chlorides) can be removed by: (1) Washing soda - Na₂CO₃ + CaSO₄ → CaCO₃↓ + Na₂SO₄, (2) Ion exchange resins, (3) Calgon\'s method. Boiling and lime only remove temporary hardness.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'hardness_of_water',
    skill_dimension: 'application',
    sequence_order: 13
  },

  # Question 14: Biological importance - Easy
  {
    quiz: quiz_4_2,
    question_type: 'fill_blank',
    question_text: 'Magnesium is an essential component of _______, which is responsible for photosynthesis in plants.',
    correct_answer: 'chlorophyll',
    explanation: 'Magnesium is present at the center of chlorophyll molecule, which is essential for photosynthesis. Calcium is important for bones and teeth.',
    points: 1,
    difficulty: -0.7,
    discrimination: 0.8,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'biological_importance',
    skill_dimension: 'recall',
    sequence_order: 14
  },

  # Question 15: Reactivity with water - Medium
  {
    quiz: quiz_4_2,
    question_type: 'sequence',
    question_text: 'Arrange the following alkaline earth metals in order of INCREASING reactivity with water:',
    sequence_items: [
      { id: 1, text: 'Beryllium (Be)' },
      { id: 2, text: 'Magnesium (Mg)' },
      { id: 3, text: 'Calcium (Ca)' },
      { id: 4, text: 'Barium (Ba)' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Reactivity with water increases down the group: Be < Mg < Ca < Sr < Ba. Be does not react (protective oxide), Mg reacts slowly with cold water, Ca/Sr/Ba react readily with cold water.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.2,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'chemical_reactivity',
    skill_dimension: 'application',
    sequence_order: 15
  }
])

puts "  ✓ Quiz 4.2: #{quiz_4_2.quiz_questions.count} questions created"

# ========================================
# Summary
# ========================================

puts "\n" + "=" * 80
puts "MODULE 4 SUMMARY"
puts "=" * 80
puts "✅ Module: #{module_4.title}"
puts "✅ Lessons: 2"
puts "✅ Quizzes: 2"
puts "✅ Total Questions: #{quiz_4_1.quiz_questions.count + quiz_4_2.quiz_questions.count}"
puts "✅ Estimated Learning Time: #{module_4.estimated_minutes / 60} hours"
puts "=" * 80
puts "\n"

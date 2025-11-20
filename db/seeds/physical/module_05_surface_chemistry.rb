# frozen_string_literal: true

# ========================================
# IIT JEE Physical Chemistry - Module 5
# Surface Chemistry
# ========================================
# Complete module with lessons and questions
# Covers: Adsorption, Catalysis, Colloids, Emulsions
# ========================================

puts "\n" + "=" * 80
puts "MODULE 5: SURFACE CHEMISTRY"
puts "=" * 80

# Find or create the Physical Chemistry course
course = Course.find_or_create_by!(slug: 'iit-jee-physical-chemistry') do |c|
  c.title = 'IIT JEE Physical Chemistry'
  c.description = 'Complete Physical Chemistry course for IIT JEE preparation'
  c.difficulty = 'advanced'
  c.estimated_hours = 150
  c.published = true
end

# Create Module 5: Surface Chemistry
module_5 = course.course_modules.find_or_create_by!(slug: 'surface-chemistry') do |m|
  m.title = 'Surface Chemistry'
  m.sequence_order = 5
  m.estimated_minutes = 720  # 12 hours
  m.description = 'Adsorption, catalysis, colloids, and emulsions - surface phenomena in chemistry'
  m.learning_objectives = [
    'Understand adsorption and its types (physisorption and chemisorption)',
    'Master adsorption isotherms (Freundlich and Langmuir)',
    'Learn about catalysis and its types',
    'Understand colloidal systems and their properties',
    'Master emulsions and their applications',
    'Solve IIT JEE problems on surface chemistry'
  ]
  m.published = true
end

puts "✅ Module 5: #{module_5.title}"

# ========================================
# Lesson 5.1: Adsorption
# ========================================

lesson_5_1 = CourseLesson.create!(
  title: 'Adsorption - Types and Mechanisms',
  reading_time_minutes: 45,
  key_concepts: ['Adsorption', 'Physisorption', 'Chemisorption', 'Adsorption isotherms', 'Factors affecting adsorption'],
  content: <<~MD
    # Adsorption

    ## Introduction

    **Adsorption** is the phenomenon of accumulation of molecules of a substance on the surface of a solid or liquid, forming a molecular or atomic film.

    - **Adsorbate:** The substance that gets adsorbed
    - **Adsorbent:** The surface on which adsorption occurs

    **Examples:**
    - Activated charcoal adsorbs gases
    - Silica gel adsorbs moisture
    - Animal charcoal decolorizes sugar solutions

    ## Adsorption vs Absorption

    | Adsorption | Absorption |
    |------------|------------|
    | Surface phenomenon | Bulk phenomenon |
    | Concentration on surface | Uniform distribution throughout |
    | Example: Gas on charcoal | Example: Water in sponge |

    **Sorption:** When both adsorption and absorption occur simultaneously

    ---

    ## Types of Adsorption

    ### 1. Physical Adsorption (Physisorption)

    **Characteristics:**
    - **Forces:** Weak van der Waals forces
    - **Heat of adsorption:** Low (20-40 kJ/mol)
    - **Temperature:** Occurs at low temperatures
    - **Reversibility:** Easily reversible
    - **Specificity:** Non-specific (any gas can be adsorbed)
    - **Layer formation:** Can form multi-molecular layers
    - **Activation energy:** Not required

    **Example:** Adsorption of N₂ on iron at low temperature

    ### 2. Chemical Adsorption (Chemisorption)

    **Characteristics:**
    - **Forces:** Strong chemical bonds (covalent/ionic)
    - **Heat of adsorption:** High (80-400 kJ/mol)
    - **Temperature:** Occurs at high temperatures
    - **Reversibility:** Irreversible
    - **Specificity:** Highly specific
    - **Layer formation:** Forms unimolecular layer only
    - **Activation energy:** Required

    **Example:** Adsorption of H₂ on nickel

    | Property | Physisorption | Chemisorption |
    |----------|---------------|---------------|
    | Nature of forces | Van der Waals | Chemical bonds |
    | Heat of adsorption | 20-40 kJ/mol | 80-400 kJ/mol |
    | Temperature | Low temperature favored | High temperature favored |
    | Reversibility | Reversible | Irreversible |
    | Specificity | Non-specific | Highly specific |
    | Layers | Multi-layer | Mono-layer |
    | Activation energy | Not required | Required |

    ---

    ## Factors Affecting Adsorption

    ### 1. Nature of Adsorbent
    - **Surface area:** Greater surface area → More adsorption
    - **Porosity:** Porous materials have higher adsorption capacity
    - **Activation:** Activated charcoal has very high surface area

    ### 2. Nature of Adsorbate
    - **Easily liquefiable gases** (high critical temperature) are easily adsorbed
    - Order: NH₃ > SO₂ > HCl > CO₂ > CH₄ > H₂ > N₂
    - Polar molecules are preferentially adsorbed over non-polar

    ### 3. Temperature
    - **Physisorption:** Decreases with increasing temperature (exothermic)
    - **Chemisorption:** Initially increases, then decreases

    ### 4. Pressure
    - **Increases with pressure** at constant temperature
    - At high pressure, adsorption becomes independent of pressure (saturation)

    ---

    ## Adsorption Isotherms

    Adsorption isotherms are graphs showing the variation of adsorption with pressure at constant temperature.

    ### 1. Freundlich Adsorption Isotherm

    **Equation:**
    ```
    x/m = k·P^(1/n)
    ```

    Where:
    - x = mass of gas adsorbed
    - m = mass of adsorbent
    - P = pressure
    - k, n = constants (depend on nature of adsorbate and adsorbent)
    - n > 1

    **Logarithmic form:**
    ```
    log(x/m) = log k + (1/n)log P
    ```

    This is a straight line with:
    - Slope = 1/n
    - Intercept = log k

    **Validity:**
    - Valid for moderate pressure range
    - Fails at very low and very high pressures

    ### 2. Langmuir Adsorption Isotherm

    **Assumptions:**
    - Adsorption occurs on specific sites on the adsorbent surface
    - Each site can hold only one molecule (monolayer)
    - All sites are equivalent
    - No interaction between adsorbed molecules

    **Equation:**
    ```
    x/m = (a·b·P)/(1 + b·P)
    ```

    Where:
    - a = maximum adsorption capacity
    - b = constant related to enthalpy of adsorption

    **At low pressure:** x/m = a·b·P (linear)
    **At high pressure:** x/m = a (constant, saturation)

    ---

    ## Applications of Adsorption

    1. **Gas masks:** Activated charcoal adsorbs poisonous gases
    2. **Decolorization:** Animal charcoal removes colored impurities from sugar
    3. **Water purification:** Removal of odor and taste
    4. **Humidity control:** Silica gel and alumina gel
    5. **Chromatography:** Separation of mixtures
    6. **Heterogeneous catalysis:** Catalyst provides surface for reaction
    7. **Froth flotation:** Separation of ores

    ---

    ## IIT JEE Key Points

    1. Adsorption is **exothermic** (ΔH < 0)
    2. **Entropy decreases** during adsorption (ΔS < 0)
    3. For spontaneity: ΔG = ΔH - TΔS < 0
    4. Physisorption occurs at **low temperature**
    5. Chemisorption requires **activation energy**
    6. **Freundlich isotherm:** x/m = k·P^(1/n), valid at moderate pressure
    7. **Langmuir isotherm:** Based on monolayer adsorption
    8. Easily liquefiable gases are **readily adsorbed**
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 5.1: #{lesson_5_1.title}"

# ========================================
# Quiz 5.1: Adsorption
# ========================================

quiz_5_1 = Quiz.create!(
  title: 'Adsorption - Concepts and Applications',
  description: 'Test your understanding of adsorption phenomena',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_1, sequence_order: 2, required: true)

# Questions for Quiz 5.1
QuizQuestion.create!([
  # Question 1: Physisorption vs Chemisorption
  {
    quiz: quiz_5_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following is characteristic of physisorption?',
    options: [
      { text: 'Low heat of adsorption (20-40 kJ/mol)', correct: true },
      { text: 'Forms chemical bonds', correct: false },
      { text: 'Irreversible process', correct: false },
      { text: 'Forms only monolayer', correct: false }
    ],
    explanation: 'Physisorption involves weak van der Waals forces, resulting in low heat of adsorption (20-40 kJ/mol). It is reversible and can form multilayers.',
    points: 2,
    difficulty: -0.5,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'adsorption',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: Adsorption order
  {
    quiz: quiz_5_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which gas will be adsorbed to the maximum extent on activated charcoal?',
    options: [
      { text: 'Ammonia (NH₃)', correct: true },
      { text: 'Nitrogen (N₂)', correct: false },
      { text: 'Hydrogen (H₂)', correct: false },
      { text: 'Methane (CH₄)', correct: false }
    ],
    explanation: 'Easily liquefiable gases (high critical temperature) are readily adsorbed. NH₃ has the highest critical temperature among these gases, so it is adsorbed most.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'adsorption',
    skill_dimension: 'application',
    sequence_order: 2
  },

  # Question 3: Freundlich isotherm
  {
    quiz: quiz_5_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'According to Freundlich adsorption isotherm, which statements are correct?',
    options: [
      { text: 'x/m = k·P^(1/n) where n > 1', correct: true },
      { text: 'Valid for all pressure ranges', correct: false },
      { text: 'log(x/m) vs log P gives a straight line', correct: true },
      { text: 'Based on monolayer adsorption', correct: false }
    ],
    explanation: 'Freundlich isotherm: x/m = k·P^(1/n) with n > 1. The logarithmic form gives a straight line. It is valid only at moderate pressures, not all ranges. Langmuir (not Freundlich) assumes monolayer.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'adsorption_isotherms',
    skill_dimension: 'comprehension',
    sequence_order: 3
  },

  # Question 4: Thermodynamics of adsorption
  {
    quiz: quiz_5_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Adsorption is accompanied by:',
    options: [
      { text: 'Decrease in enthalpy and decrease in entropy', correct: true },
      { text: 'Increase in enthalpy and increase in entropy', correct: false },
      { text: 'Decrease in enthalpy and increase in entropy', correct: false },
      { text: 'Increase in enthalpy and decrease in entropy', correct: false }
    ],
    explanation: 'Adsorption is exothermic (ΔH < 0, enthalpy decreases). It also decreases entropy (ΔS < 0) as molecules become more ordered on the surface.',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'adsorption_thermodynamics',
    skill_dimension: 'comprehension',
    sequence_order: 4
  },

  # Question 5: Numerical on Freundlich
  {
    quiz: quiz_5_1,
    question_type: 'numerical',
    question_text: 'For Freundlich adsorption isotherm, a plot of log(x/m) vs log P has a slope of 0.5 and intercept of 0.301. What is the value of x/m at pressure 4 atm? (x/m in g/g)',
    correct_answer: 4.0,
    tolerance: 0.1,
    explanation: 'log(x/m) = log k + (1/n)log P. Slope = 1/n = 0.5, Intercept = log k = 0.301, so k = 2. At P = 4: log(x/m) = 0.301 + 0.5×log(4) = 0.301 + 0.5×0.602 = 0.602. Therefore x/m = 10^0.602 = 4.0 g/g.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'adsorption_isotherms',
    skill_dimension: 'application',
    sequence_order: 5
  }
])

puts "  ✓ Quiz 5.1: #{quiz_5_1.title} (#{quiz_5_1.quiz_questions.count} questions)"

# ========================================
# Lesson 5.2: Catalysis
# ========================================

lesson_5_2 = CourseLesson.create!(
  title: 'Catalysis - Types and Mechanisms',
  reading_time_minutes: 50,
  key_concepts: ['Catalysis', 'Homogeneous catalysis', 'Heterogeneous catalysis', 'Enzyme catalysis', 'Catalyst poisoning'],
  content: <<~MD
    # Catalysis

    ## Introduction

    **Catalyst:** A substance that alters the rate of a chemical reaction without being consumed in the process.

    **Catalysis:** The phenomenon of altering the rate of reaction using a catalyst.

    ---

    ## Types of Catalysis

    ### 1. Positive Catalysis
    - Catalyst **increases** the rate of reaction
    - Most common type
    - **Example:** MnO₂ in decomposition of KClO₃

    ### 2. Negative Catalysis (Inhibition)
    - Catalyst **decreases** the rate of reaction
    - **Example:** Phosphoric acid retards decomposition of H₂O₂

    ### 3. Auto-catalysis
    - Product of reaction acts as catalyst
    - **Example:** CH₃COOC₂H₅ + H₂O → CH₃COOH + C₂H₅OH (CH₃COOH catalyzes the reaction)

    ---

    ## Classification Based on Phase

    ### Homogeneous Catalysis

    **Definition:** Catalyst and reactants are in the same phase.

    **Characteristics:**
    - Usually in liquid or gas phase
    - Catalyst uniformly distributed
    - High selectivity

    **Examples:**

    1. **Lead chamber process (SO₂ oxidation):**
       ```
       2SO₂(g) + O₂(g) --[NO(g)]--> 2SO₃(g)
       ```

    2. **Esterification:**
       ```
       CH₃COOH(l) + C₂H₅OH(l) --[H₂SO₄(l)]--> CH₃COOC₂H₅(l) + H₂O(l)
       ```

    3. **Hydrolysis of esters:**
       ```
       CH₃COOC₂H₅ + H₂O --[H⁺ or OH⁻]--> CH₃COOH + C₂H₅OH
       ```

    4. **Inversion of cane sugar:**
       ```
       C₁₂H₂₂O₁₁ + H₂O --[H⁺]--> C₆H₁₂O₆ + C₆H₁₂O₆
       ```

    ### Heterogeneous Catalysis

    **Definition:** Catalyst and reactants are in different phases.

    **Characteristics:**
    - Catalyst is usually solid, reactants are gas or liquid
    - Reaction occurs on catalyst surface
    - Surface area is important

    **Examples:**

    1. **Haber process (Ammonia synthesis):**
       ```
       N₂(g) + 3H₂(g) --[Fe(s)]--> 2NH₃(g)
       ```

    2. **Ostwald process (Oxidation of ammonia):**
       ```
       4NH₃(g) + 5O₂(g) --[Pt(s)]--> 4NO(g) + 6H₂O(g)
       ```

    3. **Contact process (SO₃ production):**
       ```
       2SO₂(g) + O₂(g) --[V₂O₅(s)]--> 2SO₃(g)
       ```

    4. **Hydrogenation of vegetable oils:**
       ```
       Vegetable oil + H₂ --[Ni(s)]--> Vanaspati ghee
       ```

    5. **Deacon's process (Chlorine production):**
       ```
       4HCl(g) + O₂(g) --[CuCl₂(s)]--> 2Cl₂(g) + 2H₂O(g)
       ```

    | Homogeneous | Heterogeneous |
    |-------------|---------------|
    | Same phase | Different phases |
    | Uniformly distributed | Localized at interface |
    | Example: NO in SO₂ oxidation | Example: Fe in Haber process |

    ---

    ## Mechanism of Heterogeneous Catalysis

    **Steps:**

    1. **Diffusion:** Reactant molecules diffuse to catalyst surface
    2. **Adsorption:** Reactants are adsorbed on catalyst surface (chemisorption)
    3. **Reaction:** Adsorbed molecules react on surface (activation energy lowered)
    4. **Desorption:** Products desorb from surface
    5. **Diffusion:** Products diffuse away from surface

    **Active sites:** Specific locations on catalyst surface where reaction occurs

    ---

    ## Important Features of Catalysis

    ### 1. Catalyst Remains Unchanged
    - Mass and chemical composition remain same
    - May undergo temporary physical/chemical change

    ### 2. Small Amount Required
    - Catalyst works in very small quantities
    - Effect depends on surface area, not mass

    ### 3. Catalyst Cannot Initiate Reaction
    - Can only alter rate of thermodynamically feasible reactions
    - Cannot make impossible reactions possible

    ### 4. Catalyst is Specific
    - A given catalyst works for specific reactions only
    - Example: MnO₂ catalyzes KClO₃ decomposition but not others

    ### 5. Catalyst Does Not Alter Equilibrium
    - Increases both forward and backward reaction rates equally
    - Position of equilibrium remains same
    - Equilibrium is attained faster

    ### 6. Catalyst Lowers Activation Energy
    - Provides alternate pathway with lower Ea
    - More molecules have energy ≥ Ea
    - Rate increases

    ---

    ## Promoters and Catalytic Poisons

    ### Promoters (Co-catalysts)
    - Substances that enhance catalyst activity
    - **Example:** In Haber process, Fe is catalyst, Mo acts as promoter

    ### Catalytic Poisons
    - Substances that reduce or destroy catalyst activity
    - **Example:**
      - Arsenic poisoning of Pt catalyst in Contact process
      - CO poisoning of Fe catalyst in Haber process
      - Lead poisoning of catalytic converters

    ---

    ## Enzyme Catalysis

    **Enzymes:** Biological catalysts (proteins) in living organisms

    **Characteristics:**
    - Highly specific (lock and key mechanism)
    - Work under mild conditions (body temperature, neutral pH)
    - Very efficient (increase rate by 10⁶ to 10²⁰ times)
    - Sensitive to temperature and pH

    **Examples:**
    - **Invertase:** Converts cane sugar to glucose and fructose
    - **Maltase:** Converts maltose to glucose
    - **Urease:** Converts urea to ammonia and CO₂
    - **Pepsin:** Digests proteins in stomach
    - **Amylase:** Converts starch to maltose

    **Mechanism:**
    ```
    Enzyme (E) + Substrate (S) ⇌ E-S complex → E + Product (P)
    ```

    ---

    ## Zeolites as Catalysts

    **Zeolites:** Microporous aluminosilicate minerals with shape-selective catalysis

    **Structure:**
    - 3D network of SiO₄ and AlO₄ tetrahedra
    - Contains cavities and channels of molecular dimensions

    **Applications:**
    - Petroleum refining (catalytic cracking)
    - Petrochemical industry
    - Conversion of alcohols to gasoline
    - **ZSM-5:** Used to convert methanol to gasoline

    **Shape Selectivity:** Only molecules of certain size and shape can enter pores and react

    ---

    ## IIT JEE Key Points

    1. Catalyst **does not alter ΔG** or equilibrium position
    2. Catalyst **lowers activation energy** (Ea)
    3. **Heterogeneous catalysis:** Adsorption → Reaction → Desorption
    4. **Homogeneous:** Same phase; **Heterogeneous:** Different phases
    5. **Promoters** enhance catalyst activity
    6. **Poisons** reduce catalyst activity
    7. **Enzymes** are highly specific biological catalysts
    8. **Zeolites** show shape-selective catalysis
    9. Catalyst increases rate of **both forward and backward** reactions equally
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_2, sequence_order: 3, required: true)

puts "  ✓ Lesson 5.2: #{lesson_5_2.title}"

# ========================================
# Quiz 5.2: Catalysis
# ========================================

quiz_5_2 = Quiz.create!(
  title: 'Catalysis - Mechanisms and Applications',
  description: 'Test your knowledge of catalytic processes',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_2, sequence_order: 4, required: true)

# Questions for Quiz 5.2
QuizQuestion.create!([
  # Question 1: Homogeneous vs Heterogeneous
  {
    quiz: quiz_5_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following is an example of heterogeneous catalysis?',
    options: [
      { text: 'Haber process: N₂ + 3H₂ → 2NH₃ (Fe catalyst)', correct: true },
      { text: 'Esterification with H₂SO₄', correct: false },
      { text: 'Oxidation of SO₂ with NO catalyst', correct: false },
      { text: 'Hydrolysis of ester with H⁺', correct: false }
    ],
    explanation: 'In Haber process, Fe (solid) catalyzes reaction of N₂ and H₂ (gases), making it heterogeneous. Others involve same-phase catalysis.',
    points: 2,
    difficulty: -0.4,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'catalysis',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: Catalyst properties
  {
    quiz: quiz_5_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which statements are true about catalysts?',
    options: [
      { text: 'Catalyst lowers activation energy', correct: true },
      { text: 'Catalyst does not alter equilibrium position', correct: true },
      { text: 'Catalyst changes Gibbs free energy of reaction', correct: false },
      { text: 'Catalyst can make thermodynamically unfavorable reactions occur', correct: false }
    ],
    explanation: 'Catalysts lower activation energy and speed up both forward/backward reactions equally, so equilibrium position is unchanged. They do not alter ΔG or make impossible reactions possible.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'catalysis_properties',
    skill_dimension: 'comprehension',
    sequence_order: 2
  },

  # Question 3: Promoters and poisons
  {
    quiz: quiz_5_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In the Haber process for ammonia synthesis with Fe catalyst, molybdenum (Mo) acts as:',
    options: [
      { text: 'Promoter', correct: true },
      { text: 'Catalytic poison', correct: false },
      { text: 'Auto-catalyst', correct: false },
      { text: 'Negative catalyst', correct: false }
    ],
    explanation: 'Molybdenum enhances the activity of Fe catalyst in Haber process, making it a promoter or co-catalyst.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'catalysis',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  # Question 4: Enzyme catalysis
  {
    quiz: quiz_5_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which are characteristics of enzyme catalysis?',
    options: [
      { text: 'Highly specific for particular substrate', correct: true },
      { text: 'Work efficiently at body temperature', correct: true },
      { text: 'Activity independent of pH', correct: false },
      { text: 'Can catalyze any chemical reaction', correct: false }
    ],
    explanation: 'Enzymes are highly specific (lock and key), work at mild conditions (37°C), but are sensitive to pH changes. They only catalyze specific reactions.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'enzyme_catalysis',
    skill_dimension: 'comprehension',
    sequence_order: 4
  },

  # Question 5: Zeolites
  {
    quiz: quiz_5_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Zeolites are used as catalysts due to their property of:',
    options: [
      { text: 'Shape-selective catalysis', correct: true },
      { text: 'Enzyme-like activity', correct: false },
      { text: 'Homogeneous catalysis', correct: false },
      { text: 'Auto-catalysis', correct: false }
    ],
    explanation: 'Zeolites have microporous structure with cavities of molecular dimensions, allowing only specific molecules to enter and react - this is called shape-selective catalysis.',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'zeolites',
    skill_dimension: 'comprehension',
    sequence_order: 5
  }
])

puts "  ✓ Quiz 5.2: #{quiz_5_2.title} (#{quiz_5_2.quiz_questions.count} questions)"

# ========================================
# Lesson 5.3: Colloids
# ========================================

lesson_5_3 = CourseLesson.create!(
  title: 'Colloidal Systems - Properties and Classification',
  reading_time_minutes: 55,
  key_concepts: ['Colloids', 'Classification', 'Preparation', 'Properties', 'Tyndall effect', 'Brownian motion'],
  content: <<~MD
    # Colloidal Systems

    ## Introduction

    **Colloidal solution (or sol):** A heterogeneous mixture where particle size is intermediate between true solution and suspension.

    **Particle size:**
    - True solution: < 1 nm
    - Colloidal solution: 1-1000 nm (1-100 nm typically)
    - Suspension: > 1000 nm

    **Components:**
    - **Dispersed phase:** Substance distributed as particles (like solute)
    - **Dispersion medium:** Medium in which particles are dispersed (like solvent)

    ---

    ## Classification of Colloids

    ### Based on Physical State

    | Dispersed Phase | Dispersion Medium | Name | Example |
    |-----------------|-------------------|------|---------|
    | Solid | Solid | Solid sol | Colored glasses, gemstones |
    | Solid | Liquid | Sol | Paint, ink, gold sol |
    | Solid | Gas | Aerosol | Smoke, dust in air |
    | Liquid | Solid | Gel | Jellies, cheese, butter |
    | Liquid | Liquid | Emulsion | Milk, mayonnaise |
    | Liquid | Gas | Aerosol | Fog, mist, cloud |
    | Gas | Solid | Solid foam | Pumice stone, foam rubber |
    | Gas | Liquid | Foam | Soap foam, whipped cream |

    **Note:** Gas-gas mixtures are always homogeneous (true solutions), never colloidal.

    ### Based on Nature of Interaction

    #### 1. Lyophilic Colloids (Solvent-loving)
    - Strong interaction between dispersed phase and medium
    - Directly formed by mixing with solvent
    - **Reversible:** Can be reconstituted after evaporation
    - **Stable:** Not easily coagulated
    - **Examples:** Starch, gelatin, rubber, proteins in water

    #### 2. Lyophobic Colloids (Solvent-hating)
    - Weak or no interaction between dispersed phase and medium
    - Not directly formed, need special methods
    - **Irreversible:** Cannot be reconstituted
    - **Unstable:** Easily coagulated
    - **Examples:** Metal sols (gold, silver), sulfur sol, As₂S₃ sol

    **If water is the medium:**
    - Lyophilic → Hydrophilic
    - Lyophobic → Hydrophobic

    ### Based on Type of Particles

    #### 1. Multimolecular Colloids
    - Large number of atoms/molecules aggregate together
    - Size in colloidal range
    - **Example:** Gold sol, sulfur sol

    #### 2. Macromolecular Colloids
    - Individual large molecules (macromolecules)
    - Size naturally in colloidal range
    - **Example:** Proteins, starch, cellulose, polymers

    #### 3. Associated Colloids (Micelles)
    - Formed by aggregation of small molecules above a certain concentration
    - **CMC (Critical Micelle Concentration):** Minimum concentration for micelle formation
    - **Kraft Temperature:** Minimum temperature for micelle formation
    - **Example:** Soaps, detergents

    ---

    ## Preparation of Colloids

    ### Dispersion Methods (Breaking down larger particles)

    #### 1. Mechanical Dispersion
    - Grinding substance with dispersion medium in colloid mill
    - **Example:** Preparation of colloidal solutions of dyes

    #### 2. Electrical Dispersion (Bredig's Arc Method)
    - Electric arc struck between metal electrodes under water
    - Metal vaporizes and condenses to colloidal particles
    - **Example:** Preparation of gold, silver, platinum sols

    #### 3. Peptization
    - Process of converting precipitate into colloid by adding electrolyte (peptizing agent)
    - Electrolyte gets preferentially adsorbed
    - **Example:** Fresh Fe(OH)₃ precipitate + FeCl₃ → Fe(OH)₃ sol

    ### Condensation Methods (Building up from smaller particles)

    #### 1. Chemical Methods

    **Oxidation:**
    ```
    2H₂S + SO₂ → 3S (sol) + 2H₂O
    ```

    **Reduction:**
    ```
    2AuCl₃ + 3HCHO + 3H₂O → 2Au (sol) + 3HCOOH + 6HCl
    ```

    **Hydrolysis:**
    ```
    FeCl₃ + 3H₂O → Fe(OH)₃ (sol) + 3HCl
    ```

    **Double decomposition:**
    ```
    As₂O₃ + 3H₂S → As₂S₃ (sol) + 3H₂O
    ```

    #### 2. Change of Solvent
    - Dissolve substance in one solvent
    - Pour into another solvent where it's less soluble
    - **Example:** Sulfur sol by pouring alcoholic sulfur solution into water

    ---

    ## Properties of Colloids

    ### 1. Heterogeneous Nature
    - Colloids are heterogeneous (two phases)
    - But appear homogeneous to naked eye

    ### 2. Filterability
    - Pass through ordinary filter paper
    - Do not pass through parchment or cellophane (semi-permeable membrane)
    - **Dialysis:** Purification of colloids by removing dissolved substances

    ### 3. Colligative Properties
    - Exhibit colligative properties
    - But much smaller than true solutions (fewer particles per unit mass)

    ### 4. Tyndall Effect
    - Scattering of light by colloidal particles
    - Path of light becomes visible
    - **Not shown by true solutions** (particles too small)
    - **Example:** Beam of light in a dusty room, car headlights in fog

    ### 5. Brownian Motion
    - Random, zig-zag motion of colloidal particles
    - Due to unequal bombardment by molecules of dispersion medium
    - Prevents settling of particles under gravity
    - Observed under ultramicroscope

    ### 6. Charge on Colloidal Particles
    - All particles in a given colloid have same charge
    - Prevents aggregation (repulsion)
    - **Positive sols:** Fe(OH)₃, Al(OH)₃, metal sols
    - **Negative sols:** As₂S₃, sulfur sol, gold sol, starch, gums

    ### 7. Electrophoresis
    - Movement of colloidal particles under electric field
    - Positive particles move to cathode (negative electrode)
    - Negative particles move to anode (positive electrode)
    - **Applications:** Determination of charge, purification

    ### 8. Coagulation or Flocculation
    - Settling down of colloidal particles
    - Achieved by:
      - **Adding electrolytes** (most effective)
      - Heating
      - Mixing oppositely charged sols
    - **Hardy-Schulze Rule:** Greater the valence of coagulating ion, greater its coagulating power
    - For negative sols: Al³⁺ > Ba²⁺ > Na⁺
    - For positive sols: [Fe(CN)₆]⁴⁻ > PO₄³⁻ > SO₄²⁻ > Cl⁻

    ---

    ## Protection of Colloids

    **Protective Colloids:** Lyophilic colloids added to lyophobic sols to prevent coagulation

    **Example:** Gelatin added to gold sol

    **Gold Number:** Minimum mass (in mg) of protective colloid required to prevent coagulation of 10 mL of gold sol by 1 mL of 10% NaCl solution

    - **Lower gold number = Better protective action**

    ---

    ## Applications of Colloids

    1. **Purification of water:** Alum coagulates suspended impurities
    2. **Medicines:** Colloidal silver (Argyrol) as antiseptic
    3. **Smoke precipitation:** Cottrell precipitator
    4. **Artificial rain:** Cloud seeding with AgI
    5. **Photography:** Silver bromide in gelatin
    6. **Food industry:** Ice cream, whipped cream
    7. **Rubber industry:** Latex is colloidal
    8. **Cleansing action of soaps**

    ---

    ## IIT JEE Key Points

    1. Colloidal particle size: **1-1000 nm** (typically 1-100 nm)
    2. **Tyndall effect:** Scattering of light by colloidal particles
    3. **Brownian motion:** Random motion preventing settling
    4. **Electrophoresis:** Movement under electric field
    5. **Hardy-Schulze rule:** Higher charge → Greater coagulating power
    6. **Lyophilic:** Reversible, stable; **Lyophobic:** Irreversible, unstable
    7. **Peptization:** Precipitate → Colloid (with electrolyte)
    8. **Gold number:** Lower value = Better protection
    9. Gas-gas mixtures are **never colloidal**
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_3, sequence_order: 5, required: true)

puts "  ✓ Lesson 5.3: #{lesson_5_3.title}"

# ========================================
# Quiz 5.3: Colloids
# ========================================

quiz_5_3 = Quiz.create!(
  title: 'Colloidal Systems - Properties and Applications',
  description: 'Test your understanding of colloidal chemistry',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_3, sequence_order: 6, required: true)

# Questions for Quiz 5.3
QuizQuestion.create!([
  # Question 1: Particle size
  {
    quiz: quiz_5_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'The particle size range of colloidal solutions is:',
    options: [
      { text: '1-1000 nm', correct: true },
      { text: '0.1-1 nm', correct: false },
      { text: '1000-10000 nm', correct: false },
      { text: '10-100 μm', correct: false }
    ],
    explanation: 'Colloidal particles have size in the range of 1-1000 nm (typically 1-100 nm), which is intermediate between true solutions (<1 nm) and suspensions (>1000 nm).',
    points: 2,
    difficulty: -0.6,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'colloids',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: Tyndall effect
  {
    quiz: quiz_5_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Tyndall effect is observed in:',
    options: [
      { text: 'Colloidal solutions only', correct: true },
      { text: 'True solutions only', correct: false },
      { text: 'Both colloidal and true solutions', correct: false },
      { text: 'Neither colloidal nor true solutions', correct: false }
    ],
    explanation: 'Tyndall effect (scattering of light) is observed only in colloidal solutions. True solutions have particles too small to scatter light.',
    points: 2,
    difficulty: -0.4,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'colloid_properties',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  # Question 3: Lyophilic vs Lyophobic
  {
    quiz: quiz_5_3,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which are characteristics of lyophilic colloids?',
    options: [
      { text: 'Strong interaction with dispersion medium', correct: true },
      { text: 'Reversible nature', correct: true },
      { text: 'Easily coagulated by electrolytes', correct: false },
      { text: 'Require special methods for preparation', correct: false }
    ],
    explanation: 'Lyophilic colloids have strong interaction with medium, are reversible (can be reconstituted), stable (not easily coagulated), and can be prepared directly.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'colloid_types',
    skill_dimension: 'comprehension',
    sequence_order: 3
  },

  # Question 4: Hardy-Schulze rule
  {
    quiz: quiz_5_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'For coagulation of a negative sol (like As₂S₃), the correct order of coagulating power is:',
    options: [
      { text: 'Al³⁺ > Ba²⁺ > Na⁺', correct: true },
      { text: 'Na⁺ > Ba²⁺ > Al³⁺', correct: false },
      { text: 'Ba²⁺ > Al³⁺ > Na⁺', correct: false },
      { text: 'All have equal coagulating power', correct: false }
    ],
    explanation: 'According to Hardy-Schulze rule, higher the valence of coagulating ion, greater its coagulating power. For negative sol: Al³⁺ (3+) > Ba²⁺ (2+) > Na⁺ (1+).',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'coagulation',
    skill_dimension: 'application',
    sequence_order: 4
  },

  # Question 5: Classification
  {
    quiz: quiz_5_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Milk is an example of:',
    options: [
      { text: 'Emulsion (liquid in liquid)', correct: true },
      { text: 'Sol (solid in liquid)', correct: false },
      { text: 'Foam (gas in liquid)', correct: false },
      { text: 'Aerosol (liquid in gas)', correct: false }
    ],
    explanation: 'Milk is an emulsion where fat droplets (liquid) are dispersed in water (liquid). It is a liquid-in-liquid colloidal system.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'colloid_classification',
    skill_dimension: 'application',
    sequence_order: 5
  },

  # Question 6: Gold number
  {
    quiz: quiz_5_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'If protective colloid A has gold number 0.01 and B has gold number 0.1, which statement is correct?',
    options: [
      { text: 'A is better protective colloid than B', correct: true },
      { text: 'B is better protective colloid than A', correct: false },
      { text: 'Both have equal protective action', correct: false },
      { text: 'Cannot determine from given information', correct: false }
    ],
    explanation: 'Gold number is the minimum mass (in mg) of protective colloid needed to prevent coagulation. Lower gold number means better protection. A (0.01) < B (0.1), so A is better.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'protective_colloids',
    skill_dimension: 'application',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 5.3: #{quiz_5_3.title} (#{quiz_5_3.quiz_questions.count} questions)"

# ========================================
# Lesson 5.4: Emulsions
# ========================================

lesson_5_4 = CourseLesson.create!(
  title: 'Emulsions and Micelles',
  reading_time_minutes: 35,
  key_concepts: ['Emulsions', 'Emulsifying agents', 'Types of emulsions', 'Micelles', 'Soaps and detergents'],
  content: <<~MD
    # Emulsions and Micelles

    ## Emulsions

    **Emulsion:** Colloidal system where both dispersed phase and dispersion medium are liquids.

    - Both liquids must be immiscible
    - One liquid is dispersed in another as droplets

    ---

    ## Types of Emulsions

    ### 1. Oil-in-Water (O/W) Emulsion
    - **Dispersed phase:** Oil
    - **Dispersion medium:** Water
    - **Examples:**
      - Milk (fat in water)
      - Vanishing cream
      - Cod liver oil

    ### 2. Water-in-Oil (W/O) Emulsion
    - **Dispersed phase:** Water
    - **Dispersion medium:** Oil
    - **Examples:**
      - Butter
      - Cold cream
      - Cod liver oil

    | Property | O/W Emulsion | W/O Emulsion |
    |----------|--------------|--------------|
    | Dispersed phase | Oil | Water |
    | Dispersion medium | Water | Oil |
    | Dilution | With water | With oil |
    | Conductivity | Conducts electricity | Does not conduct |
    | Example | Milk | Butter |

    ---

    ## Tests to Identify Emulsion Type

    ### 1. Dilution Test
    - **O/W:** Can be diluted with water
    - **W/O:** Can be diluted with oil

    ### 2. Conductivity Test
    - **O/W:** Conducts electricity (water conducts)
    - **W/O:** Does not conduct (oil doesn't conduct)

    ### 3. Dye Test
    - **O/W:** Water-soluble dye colors the emulsion
    - **W/O:** Oil-soluble dye colors the emulsion

    ---

    ## Emulsifying Agents (Emulsifiers)

    **Function:** Stabilize emulsions by forming interfacial film between two liquids

    **Types:**

    1. **Lyophilic colloids:** Gelatin, albumin, casein
    2. **Surface active agents:** Soaps, detergents
    3. **Finely divided solids:** Lampblack, clay

    **Mechanism:**
    - Molecules have hydrophilic (water-loving) and hydrophobic (water-hating) parts
    - Form protective layer around droplets
    - Prevent coalescence

    ---

    ## Applications of Emulsions

    1. **Medicines:** Cod liver oil, liquid paraffin
    2. **Cosmetics:** Cold cream, vanishing cream
    3. **Food:** Milk, butter, ice cream
    4. **Paints:** Oil-based paints
    5. **Disinfectants:** Phenol emulsions
    6. **Asphalt emulsions:** Road surfacing

    ---

    ## Demulsification

    **Process of breaking emulsion into constituent liquids**

    **Methods:**
    1. **Heating:** Destroys emulsifying agent
    2. **Freezing:** Ice crystals break emulsion
    3. **Centrifugation:** Separates by density
    4. **Chemical methods:** Adding electrolytes, changing pH
    5. **Addition of opposite type emulsifier**

    **Example:** Cream separation from milk by centrifugation

    ---

    ## Micelles

    **Micelle:** Aggregate of surfactant molecules in colloidal dimensions

    ### Surfactants (Surface Active Agents)

    **Structure:**
    - **Hydrophilic head:** Polar, water-loving (COO⁻, SO₃⁻, SO₄⁻)
    - **Hydrophobic tail:** Non-polar, water-hating (long hydrocarbon chain)

    **Example - Soap (RCOO⁻Na⁺):**
    - Hydrophilic: COO⁻ group
    - Hydrophobic: Long alkyl chain (R)

    ### Micelle Formation

    **In water:**
    - Hydrophobic tails point inward
    - Hydrophilic heads point outward toward water
    - Forms spherical aggregate

    **Critical Micelle Concentration (CMC):**
    - Minimum concentration at which micelles form
    - Below CMC: Individual molecules
    - Above CMC: Micelles form

    **Kraft Temperature:**
    - Minimum temperature for micelle formation
    - Below this, surfactant precipitates

    ---

    ## Cleansing Action of Soaps

    **Mechanism:**

    1. **Soap dissolves in water** and forms micelles (above CMC)

    2. **Hydrophobic tails** dissolve in grease/oil on fabric
       **Hydrophilic heads** remain in water

    3. **Mechanical action** (rubbing) breaks up oil into droplets

    4. **Micelles surround oil droplets** with tails inside oil and heads outside in water

    5. **Repulsion between negatively charged heads** keeps droplets dispersed (emulsion)

    6. **Rinsing with water** removes emulsified oil droplets

    **Why soap doesn't work in hard water:**
    - Hard water contains Ca²⁺, Mg²⁺ ions
    - Forms insoluble salts: 2RCOO⁻Na⁺ + Ca²⁺ → (RCOO)₂Ca + 2Na⁺
    - These precipitate as scum, reducing cleansing action

    ---

    ## Detergents

    **Synthetic detergents:** Sodium salts of long-chain sulfonic acids or alkyl hydrogen sulfates

    **Structure:**
    - Example: Sodium lauryl sulfate (CH₃(CH₂)₁₁OSO₃⁻Na⁺)
    - Long hydrocarbon chain + sulfate group

    **Advantages over soaps:**

    1. **Work in hard water:** Don't form insoluble salts with Ca²⁺, Mg²⁺
    2. **Work in acidic solutions:** Don't precipitate
    3. **Stronger cleansing action**
    4. **Better solubility in water**

    **Types:**

    1. **Anionic detergents:**
       - Negatively charged (SO₃⁻, SO₄⁻)
       - Example: Sodium dodecyl benzene sulfonate
       - Best for removing oily dirt

    2. **Cationic detergents:**
       - Positively charged (NH₄⁺)
       - Example: Cetyltrimethylammonium bromide
       - Used as germicides, antiseptics

    3. **Non-ionic detergents:**
       - No charge
       - Example: Polyethylene glycol stearate
       - Used in dishwashing liquids

    **Disadvantage:** Some detergents are not biodegradable, causing water pollution

    ---

    ## IIT JEE Key Points

    1. **Emulsion:** Liquid in liquid colloidal system
    2. **O/W emulsion:** Can be diluted with water, conducts electricity
    3. **W/O emulsion:** Can be diluted with oil, doesn't conduct
    4. **Emulsifier:** Stabilizes emulsion (gelatin, soap)
    5. **Micelles:** Form above CMC and Kraft temperature
    6. **Soap structure:** Hydrophilic head (COO⁻) + Hydrophobic tail (alkyl chain)
    7. **Cleansing:** Micelles surround oil, emulsification occurs
    8. **Hard water:** Forms scum with soap (Ca²⁺/Mg²⁺ salts)
    9. **Detergents:** Work in hard water, more versatile than soaps
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_4, sequence_order: 7, required: true)

puts "  ✓ Lesson 5.4: #{lesson_5_4.title}"

# ========================================
# Quiz 5.4: Emulsions and Micelles
# ========================================

quiz_5_4 = Quiz.create!(
  title: 'Emulsions and Micelles - Applications',
  description: 'Test your knowledge of emulsions, micelles, and cleansing action',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_4, sequence_order: 8, required: true)

# Questions for Quiz 5.4
QuizQuestion.create!([
  # Question 1: Emulsion type
  {
    quiz: quiz_5_4,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Milk is an example of which type of emulsion?',
    options: [
      { text: 'Oil-in-water (O/W)', correct: true },
      { text: 'Water-in-oil (W/O)', correct: false },
      { text: 'Water-in-water', correct: false },
      { text: 'Oil-in-oil', correct: false }
    ],
    explanation: 'Milk is an oil-in-water (O/W) emulsion where fat droplets (oil) are dispersed in water. It can be diluted with water and conducts electricity.',
    points: 2,
    difficulty: -0.5,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'emulsions',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: Identifying emulsion type
  {
    quiz: quiz_5_4,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which test can distinguish between O/W and W/O emulsions?',
    options: [
      { text: 'Conductivity test (O/W conducts, W/O does not)', correct: true },
      { text: 'pH test', correct: false },
      { text: 'Density test', correct: false },
      { text: 'Temperature test', correct: false }
    ],
    explanation: 'Conductivity test: O/W emulsions conduct electricity because water (dispersion medium) conducts. W/O emulsions do not conduct because oil (dispersion medium) is non-conducting.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'emulsions',
    skill_dimension: 'application',
    sequence_order: 2
  },

  # Question 3: CMC
  {
    quiz: quiz_5_4,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Critical Micelle Concentration (CMC) is:',
    options: [
      { text: 'Minimum concentration at which micelles form', correct: true },
      { text: 'Maximum concentration of surfactant', correct: false },
      { text: 'Concentration at which emulsion breaks', correct: false },
      { text: 'Temperature for micelle formation', correct: false }
    ],
    explanation: 'CMC is the minimum concentration of surfactant at which micelles start forming. Below CMC, molecules exist individually. Above CMC, micelles form.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'micelles',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  # Question 4: Soap structure
  {
    quiz: quiz_5_4,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which statements are correct about soap molecule (RCOO⁻Na⁺)?',
    options: [
      { text: 'Has hydrophilic head (COO⁻ group)', correct: true },
      { text: 'Has hydrophobic tail (alkyl chain)', correct: true },
      { text: 'Forms micelles above CMC', correct: true },
      { text: 'Works efficiently in hard water', correct: false }
    ],
    explanation: 'Soap has hydrophilic COO⁻ head and hydrophobic alkyl tail, forms micelles above CMC. But soap does NOT work in hard water (forms scum with Ca²⁺/Mg²⁺).',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'soaps',
    skill_dimension: 'comprehension',
    sequence_order: 4
  },

  # Question 5: Detergents vs soaps
  {
    quiz: quiz_5_4,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why do detergents work better than soaps in hard water?',
    options: [
      { text: 'They do not form insoluble salts with Ca²⁺ and Mg²⁺', correct: true },
      { text: 'They have stronger cleansing action in soft water only', correct: false },
      { text: 'They do not form micelles', correct: false },
      { text: 'They have shorter hydrocarbon chains', correct: false }
    ],
    explanation: 'Detergents (sulfonic acid salts) do not form insoluble precipitates with Ca²⁺ and Mg²⁺ ions in hard water, unlike soaps which form scum.',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'detergents',
    skill_dimension: 'comprehension',
    sequence_order: 5
  }
])

puts "  ✓ Quiz 5.4: #{quiz_5_4.title} (#{quiz_5_4.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 5 COMPLETE: Surface Chemistry"
puts "Total Lessons: 4"
puts "Total Quizzes: 4"
puts "Total Questions: #{QuizQuestion.where(quiz_id: [quiz_5_1.id, quiz_5_2.id, quiz_5_3.id, quiz_5_4.id]).count}"
puts "=" * 80

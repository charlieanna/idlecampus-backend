# frozen_string_literal: true

# ========================================
# IIT JEE Inorganic Chemistry - Module 5 (Part 2)
# p-Block Elements - Groups 15, 16, 17, 18
# ========================================
# Nitrogen, Oxygen, Halogen, and Noble Gas Families
# ========================================

puts "\n" + "=" * 80
puts "MODULE 5 (PART 2): p-BLOCK ELEMENTS - GROUPS 15-18"
puts "=" * 80

# Find the course and module
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
module_5 = course.course_modules.find_by(slug: 'p-block-elements')

unless module_5
  puts "❌ ERROR: Module 5 not found! Run part 1 first."
  exit 1
end

# ========================================
# Lesson 5.3: Group 15 - Nitrogen Family
# ========================================

lesson_5_3 = CourseLesson.create!(
  title: 'Group 15 - Nitrogen Family (N, P, As, Sb, Bi)',
  reading_time_minutes: 50,
  key_concepts: ['Nitrogen family', 'Allotropes of phosphorus', 'Ammonia', 'Nitric acid', 'Phosphoric acid'],
  content: <<~MD
    # Group 15 - Nitrogen Family (Pnictogens)

    ## Introduction

    Group 15 elements have the general electronic configuration **ns² np³** (5 valence electrons).

    **Members:** Nitrogen (N), Phosphorus (P), Arsenic (As), Antimony (Sb), Bismuth (Bi)

    ## Electronic Configuration

    - N: [He] 2s² 2p³
    - P: [Ne] 3s² 3p³
    - As: [Ar] 3d¹⁰ 4s² 4p³
    - Sb: [Kr] 4d¹⁰ 5s² 5p³
    - Bi: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p³

    ## Oxidation States

    Common oxidation states: **+5**, **+3**, **-3**

    **Trend:** Stability of +3 increases down group, +5 decreases
    - N: -3, +3, +5 (NO₂, HNO₃)
    - P: -3, +3, +5 (most stable: +5)
    - Bi: +3 most stable (inert pair effect)

    **Why nitrogen doesn't form pentahalides (NX₅)?**
    - No d-orbitals (cannot expand octet)
    - Maximum covalency = 4

    ## Allotropy of Phosphorus

    ### White Phosphorus (P₄)
    - Tetrahedral P₄ molecules
    - Waxy, white solid
    - Highly reactive, poisonous
    - Stored under water
    - Glows in dark (chemiluminescence)
    - Catches fire at 35°C

    ### Red Phosphorus
    - Polymeric structure
    - Less reactive
    - Non-poisonous
    - Does not glow in dark
    - Ignites at 260°C

    ### Black Phosphorus
    - Least reactive
    - Graphite-like structure
    - Electrical conductor

    **White → Red conversion:** Heat white P at 573 K (absence of air)

    ## Chemical Properties

    ### 1. Dinitrogen (N₂)

    **Properties:**
    - Triple bond (N≡N) - very strong (946 kJ/mol)
    - Unreactive at room temperature
    - Inert gas behavior

    **Reactions:**
    - With H₂: N₂ + 3H₂ ⇌ 2NH₃ (Haber process, 200 atm, 700 K, Fe catalyst)
    - With O₂: N₂ + O₂ → 2NO (at high temperature)
    - With Mg: N₂ + 3Mg → Mg₃N₂ (magnesium nitride)

    ### 2. Ammonia (NH₃)

    **Preparation:**
    - Lab: NH₄Cl + Ca(OH)₂ → CaCl₂ + 2H₂O + 2NH₃
    - Industrial: Haber process

    **Properties:**
    - Colorless, pungent gas
    - Highly soluble in water (fountain experiment)
    - Weak base: NH₃ + H₂O ⇌ NH₄⁺ + OH⁻
    - Reducing agent

    **Reactions:**
    - With HCl: NH₃ + HCl → NH₄Cl (white fumes)
    - With O₂: 4NH₃ + 5O₂ → 4NO + 6H₂O (Ostwald process)
    - With CuSO₄: Forms complex [Cu(NH₃)₄]²⁺ (deep blue)

    **Uses:** Fertilizers, refrigerant, manufacturing HNO₃

    ### 3. Oxides of Nitrogen

    | Formula | Name | Oxidation State | Nature |
    |---------|------|----------------|--------|
    | N₂O | Nitrous oxide | +1 | Neutral, laughing gas |
    | NO | Nitric oxide | +2 | Neutral, paramagnetic |
    | N₂O₃ | Dinitrogen trioxide | +3 | Acidic |
    | NO₂ | Nitrogen dioxide | +4 | Acidic, brown gas |
    | N₂O₅ | Dinitrogen pentoxide | +5 | Acidic |

    **NO₂ ⇌ N₂O₄ (brown) (colorless) equilibrium**

    ### 4. Nitric Acid (HNO₃)

    **Preparation (Ostwald process):**
    1. 4NH₃ + 5O₂ → 4NO + 6H₂O
    2. 2NO + O₂ → 2NO₂
    3. 4NO₂ + 2H₂O + O₂ → 4HNO₃

    **Properties:**
    - Strong acid
    - Strong oxidizing agent
    - Aqua regia: 3HCl + HNO₃ (dissolves gold and platinum)

    **Reactions:**
    - With Cu: 3Cu + 8HNO₃ (dilute) → 3Cu(NO₃)₂ + 2NO + 4H₂O
    - With Cu: Cu + 4HNO₃ (conc.) → Cu(NO₃)₂ + 2NO₂ + 2H₂O

    **Brown ring test (for NO₃⁻):**
    Add FeSO₄ + conc. H₂SO₄ → brown ring of [Fe(H₂O)₅(NO)]²⁺

    ### 5. Phosphorus Oxides

    **P₄O₁₀ (Phosphorus pentoxide):**
    - White powder
    - Extremely hygroscopic (dehydrating agent)
    - P₄ + 5O₂ → P₄O₁₀
    - P₄O₁₀ + 6H₂O → 4H₃PO₄

    ### 6. Phosphoric Acid (H₃PO₄)

    **Preparation:**
    - P₄O₁₀ + 6H₂O → 4H₃PO₄
    - Ca₃(PO₄)₂ + 3H₂SO₄ → 2H₃PO₄ + 3CaSO₄

    **Properties:**
    - Tribasic acid (3 ionizable H)
    - Oxidizing agent (when concentrated)

    **Salts:**
    - NaH₂PO₄ (monobasic)
    - Na₂HPO₄ (dibasic)
    - Na₃PO₄ (tribasic)

    ## IIT JEE Key Points

    1. Group 15: **ns² np³** (5 valence electrons)
    2. **N doesn't form NF₅** (no d-orbitals)
    3. **Phosphorus allotropes:** White (P₄, reactive), Red (polymeric, less reactive), Black (least reactive)
    4. **Ammonia:** Weak base, fountain experiment, [Cu(NH₃)₄]²⁺ complex
    5. **HNO₃:** Strong oxidizing agent, aqua regia dissolves Au/Pt
    6. **Brown ring test:** For NO₃⁻ using FeSO₄
    7. **H₃PO₄:** Tribasic acid
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_3, sequence_order: 5, required: true)

puts "  ✓ Lesson 5.3: #{lesson_5_3.title}"

# Quiz 5.3
quiz_5_3 = Quiz.create!(
  title: 'Group 15 - Nitrogen Family',
  description: 'Test on nitrogen family elements',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_3, sequence_order: 6, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_5_3,
    question_type: 'mcq',
    question_text: 'Which allotrope of phosphorus is the most reactive?',
    options: [
      { text: 'White phosphorus', correct: true },
      { text: 'Red phosphorus', correct: false },
      { text: 'Black phosphorus', correct: false },
      { text: 'All equally reactive', correct: false }
    ],
    explanation: 'White phosphorus (P₄) is most reactive, poisonous, glows in dark, and catches fire at 35°C. Must be stored under water.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'allotropy',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  {
    quiz: quiz_5_3,
    question_type: 'fill_blank',
    question_text: 'The brown ring test is used to detect the presence of _______ ions.',
    correct_answer: 'nitrate|NO3-|NO₃⁻',
    explanation: 'Brown ring test detects NO₃⁻ ions. Add FeSO₄ and conc. H₂SO₄ to form brown ring of [Fe(H₂O)₅(NO)]²⁺ complex.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'chemical_tests',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  {
    quiz: quiz_5_3,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which statements about ammonia (NH₃) are correct?',
    options: [
      { text: 'It is a weak base', correct: true },
      { text: 'It forms deep blue complex with Cu²⁺', correct: true },
      { text: 'It is a strong oxidizing agent', correct: false },
      { text: 'It is highly soluble in water', correct: true }
    ],
    explanation: 'NH₃ is a weak base, highly soluble (fountain experiment), forms [Cu(NH₃)₄]²⁺ (deep blue). It is a reducing agent, not oxidizing agent.',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'ammonia',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  {
    quiz: quiz_5_3,
    question_type: 'equation_balance',
    question_text: 'Balance the first step of Ostwald process for HNO₃ production:' + "\n" + 'NH₃ + O₂ → NO + H₂O',
    correct_answer: '4 NH3 + 5 O2 -> 4 NO + 6 H2O',
    explanation: '4NH₃ + 5O₂ → 4NO + 6H₂O. This is the first step of Ostwald process, using Pt catalyst at 500°C.',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'chemical_equations',
    skill_dimension: 'problem_solving',
    sequence_order: 4
  }
])

puts "  ✓ Quiz 5.3: #{quiz_5_3.quiz_questions.count} questions"

# ========================================
# Lesson 5.4: Group 17 - Halogens
# ========================================

lesson_5_4 = CourseLesson.create!(
  title: 'Group 17 - Halogens (F, Cl, Br, I, At)',
  reading_time_minutes: 45,
  key_concepts: ['Halogens', 'Interhalogen compounds', 'Hydrogen halides', 'Bleaching powder', 'Aqua regia'],
  content: <<~MD
    # Group 17 - Halogens

    ## Introduction

    Group 17 elements have the general electronic configuration **ns² np⁵** (7 valence electrons).

    **Members:** Fluorine (F), Chlorine (Cl), Bromine (Br), Iodine (I), Astatine (At)

    **Name:** Halogens = Salt formers

    ## Electronic Configuration

    - F: [He] 2s² 2p⁵
    - Cl: [Ne] 3s² 3p⁵
    - Br: [Ar] 3d¹⁰ 4s² 4p⁵
    - I: [Kr] 4d¹⁰ 5s² 5p⁵
    - At: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁵

    ## Oxidation States

    Common oxidation state: **-1** (gain 1 electron)

    Higher oxidation states: +1, +3, +5, +7 (except F)

    **Fluorine:** Only -1 (most electronegative, no d-orbitals)
    **Chlorine:** -1, +1, +3, +5, +7 (ClO₄⁻ has Cl in +7)
    **Iodine:** -1, +1, +3, +5, +7 (I₂O₅, HIO₃)

    ## Physical Properties

    ### Physical State
    - F₂: Pale yellow gas
    - Cl₂: Greenish-yellow gas
    - Br₂: Red-brown liquid
    - I₂: Violet solid (sublimes)

    ### Color
    Halogens are colored due to absorption of visible light (electronic excitation)

    ### Atomic and Ionic Radii
    **Increase down the group:** F < Cl < Br < I

    ### Electronegativity
    **Decreases down the group:** F > Cl > Br > I > At
    - Fluorine is the **most electronegative** element (4.0)

    ### Electron Affinity
    **Order:** Cl > F > Br > I
    - Anomaly: Cl > F (due to small size of F, electron-electron repulsion)

    ### Bond Dissociation Energy
    **Order:** Cl₂ > Br₂ > F₂ > I₂
    - Anomaly: F₂ < Cl₂ (weak F-F bond due to lone pair repulsion in small F atom)

    ### Reactivity
    **Decreases down the group:** F₂ > Cl₂ > Br₂ > I₂
    - Fluorine is the **most reactive** non-metal

    ## Chemical Properties

    ### 1. Oxidizing Power

    **Decreases down the group:** F₂ > Cl₂ > Br₂ > I₂

    **Displacement reactions:**
    - Cl₂ + 2Br⁻ → 2Cl⁻ + Br₂ (Cl displaces Br)
    - Br₂ + 2I⁻ → 2Br⁻ + I₂ (Br displaces I)

    ### 2. Reaction with Hydrogen

    Form hydrogen halides (HX):

    H₂ + X₂ → 2HX

    **Reactivity:** H₂ + F₂ → 2HF (explosive even in dark)
    - H₂ + Cl₂ → 2HCl (explosive in sunlight)
    - Decreases down group

    **Thermal stability of HX:** HF > HCl > HBr > HI
    - H-F bond is strongest, H-I bond is weakest

    **Acid strength:** HF < HCl < HBr < HI
    - HF is weak acid (H-F bond very strong, doesn't ionize easily)
    - HI is strongest acid (H-I bond weak, ionizes easily)

    ### 3. Hydrogen Fluoride (HF)

    **Properties:**
    - Weak acid (Ka ~ 10⁻⁴)
    - Forms hydrogen bonds
    - Attacks glass: SiO₂ + 4HF → SiF₄ + 2H₂O
    - Stored in wax/plastic bottles

    ### 4. Hydrogen Chloride (HCl)

    **Preparation:**
    - Lab: NaCl + H₂SO₄ → NaHSO₄ + HCl
    - Industrial: H₂ + Cl₂ → 2HCl

    **Properties:**
    - Colorless, pungent gas
    - Highly soluble in water
    - Strong acid (HCl → H⁺ + Cl⁻)
    - Fumes in moist air

    **Aqua regia (Royal water):**
    3HCl + HNO₃ → 2H₂O + NOCl + Cl₂
    - Dissolves gold and platinum
    - Au + 3Cl₂ → AuCl₃ (oxidation by nascent chlorine)

    ### 5. Interhalogen Compounds

    Compounds between different halogens: XX', XX'₃, XX'₅, XX'₇

    **Examples:**
    - ClF, BrF, ICl (XX')
    - ClF₃, BrF₃, IF₃ (XX'₃)
    - ClF₅, BrF₅, IF₅ (XX'₅)
    - IF₇ (XX'₇)

    **Properties:**
    - More reactive than parent halogens
    - X is less electronegative, X' is more electronegative
    - Formed in decreasing electronegativity order

    ### 6. Chlorine Compounds

    **Bleaching Powder - CaOCl₂ or Ca(OCl)₂**

    **Preparation:**
    Ca(OH)₂ + Cl₂ → CaOCl₂ + H₂O

    **Properties:**
    - White powder, smell of chlorine
    - Oxidizing and bleaching agent
    - With dilute acid: Ca(OCl)₂ + H₂SO₄ → CaSO₄ + Cl₂ + H₂O

    **Uses:** Bleaching, disinfectant, oxidizing agent

    ## Anomalous Properties of Fluorine

    1. **Most electronegative** element (4.0)
    2. **Most reactive** non-metal
    3. **No positive oxidation states** (only -1)
    4. **HF is weak acid** (others are strong)
    5. **F₂ has low bond energy** (lone pair repulsion)
    6. Forms only **one oxoacid** (HOF)
    7. **Smallest halogen**, most reactive

    ## IIT JEE Key Points

    1. Halogens: **ns² np⁵** (7 valence electrons)
    2. **Reactivity:** F₂ > Cl₂ > Br₂ > I₂
    3. **Electronegativity:** F (4.0) is most electronegative
    4. **Acid strength:** HF < HCl < HBr < HI
    5. **Thermal stability:** HF > HCl > HBr > HI
    6. **Aqua regia:** 3HCl + HNO₃ (dissolves Au, Pt)
    7. **Bleaching powder:** CaOCl₂
    8. **Interhalogens:** XX', XX'₃, XX'₅, XX'₇
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_4, sequence_order: 7, required: true)

puts "  ✓ Lesson 5.4: #{lesson_5_4.title}"

# Quiz 5.4
quiz_5_4 = Quiz.create!(
  title: 'Group 17 - Halogens',
  description: 'Test on halogen elements',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_4, sequence_order: 8, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_5_4,
    question_type: 'sequence',
    question_text: 'Arrange the following hydrogen halides in order of INCREASING acid strength:',
    sequence_items: [
      { id: 1, text: 'HF' },
      { id: 2, text: 'HCl' },
      { id: 3, text: 'HBr' },
      { id: 4, text: 'HI' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'Acid strength increases down group: HF < HCl < HBr < HI. HF is weak (strong H-F bond), HI is strongest (weak H-I bond, easy ionization).',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.2,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'hydrogen_halides',
    skill_dimension: 'application',
    sequence_order: 1
  },

  {
    quiz: quiz_5_4,
    question_type: 'fill_blank',
    question_text: 'The mixture of 3HCl and HNO₃ is called _______ and dissolves gold and platinum.',
    correct_answer: 'aqua regia|aqua-regia|royal water',
    explanation: 'Aqua regia (royal water) is 3HCl:1HNO₃ mixture. Produces nascent chlorine which oxidizes noble metals like Au and Pt.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'chlorine_compounds',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  {
    quiz: quiz_5_4,
    question_type: 'mcq',
    question_text: 'Which element is the most electronegative in the periodic table?',
    options: [
      { text: 'Oxygen', correct: false },
      { text: 'Fluorine', correct: true },
      { text: 'Chlorine', correct: false },
      { text: 'Nitrogen', correct: false }
    ],
    explanation: 'Fluorine is the most electronegative element (electronegativity = 4.0 on Pauling scale). It has the highest tendency to attract electrons.',
    points: 1,
    difficulty: -0.7,
    discrimination: 0.9,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'periodic_trends',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  {
    quiz: quiz_5_4,
    question_type: 'true_false',
    question_text: 'Chlorine can displace bromine from bromide solutions.',
    correct_answer: 'true',
    explanation: 'TRUE. Cl₂ + 2Br⁻ → 2Cl⁻ + Br₂. More reactive halogen displaces less reactive. Reactivity: F₂ > Cl₂ > Br₂ > I₂.',
    points: 1,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'displacement_reactions',
    skill_dimension: 'application',
    sequence_order: 4
  }
])

puts "  ✓ Quiz 5.4: #{quiz_5_4.quiz_questions.count} questions"

# ========================================
# Lesson 5.5: Group 18 - Noble Gases
# ========================================

lesson_5_5 = CourseLesson.create!(
  title: 'Group 18 - Noble Gases (He, Ne, Ar, Kr, Xe, Rn)',
  reading_time_minutes: 25,
  key_concepts: ['Noble gases', 'Inert gas configuration', 'Xenon compounds', 'Low reactivity'],
  content: <<~MD
    # Group 18 - Noble Gases

    ## Introduction

    Group 18 elements have the general electronic configuration **ns² np⁶** (complete octet).

    **Members:** Helium (He), Neon (Ne), Argon (Ar), Krypton (Kr), Xenon (Xe), Radon (Rn)

    **Name:** Noble gases (inert gases, rare gases)

    ## Electronic Configuration

    - He: 1s² (only 2 electrons - stable)
    - Ne: [He] 2s² 2p⁶
    - Ar: [Ne] 3s² 3p⁶
    - Kr: [Ar] 3d¹⁰ 4s² 4p⁶
    - Xe: [Kr] 4d¹⁰ 5s² 5p⁶
    - Rn: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁶

    ## Physical Properties

    ### Physical State
    - All are **monoatomic gases**
    - Colorless, odorless, tasteless

    ### Atomic Radii
    **Increase down the group:** He < Ne < Ar < Kr < Xe < Rn

    ### Ionization Energy
    **Decreases down the group:** He > Ne > Ar > Kr > Xe > Rn
    - He has **highest ionization energy** of all elements

    ### Electron Affinity
    - Nearly **zero** (stable octet, no tendency to gain electrons)

    ### Boiling Point
    **Increases down the group:** He < Ne < Ar < Kr < Xe < Rn
    - Due to increasing van der Waals forces

    ## Chemical Properties

    ### Inertness

    **Why are noble gases unreactive?**
    1. Complete octet (ns² np⁶) - stable electronic configuration
    2. Very high ionization energy
    3. Nearly zero electron affinity
    4. No tendency to gain, lose, or share electrons

    ### Compounds of Noble Gases

    **Historically:** Considered completely inert

    **1962:** Neil Bartlett prepared first noble gas compound
    - XePtF₆ (xenon hexafluoroplatinate)

    **Why only Xe and Kr form compounds?**
    - Lower ionization energy
    - Larger size (can accommodate F or O)
    - Empty d-orbitals available

    ### Xenon Compounds

    **Xenon fluorides:**
    - XeF₂ (linear)
    - XeF₄ (square planar)
    - XeF₆ (distorted octahedral)

    **Preparation:**
    Xe + F₂ → XeF₂, XeF₄, XeF₆ (conditions vary)

    **Xenon oxides:**
    - XeO₃ (explosive)
    - XeO₄ (explosive)

    **Xenon oxyfluorides:**
    - XeOF₄
    - XeO₂F₂

    **Hydrolysis of XeF₄:**
    XeF₄ + 2H₂O → XeO₂ + 4HF

    **Complete hydrolysis of XeF₆:**
    XeF₆ + 3H₂O → XeO₃ + 6HF

    ## Uses of Noble Gases

    ### Helium (He)
    - Filling balloons, airships (lighter than air, non-flammable)
    - Diving apparatus (mixed with O₂)
    - Cryogenics (liquid He, -269°C)

    ### Neon (Ne)
    - Neon signs, discharge tubes (red glow)
    - Advertising lights

    ### Argon (Ar)
    - Inert atmosphere for welding
    - Filling electric bulbs (prevents oxidation of filament)

    ### Krypton (Kr)
    - High-intensity lamps
    - Flash lamps for photography

    ### Xenon (Xe)
    - Flash lamps
    - Lasers
    - Anesthesia

    ### Radon (Rn)
    - Radiotherapy (radioactive)

    ## IIT JEE Key Points

    1. Noble gases: **ns² np⁶** (complete octet, except He: 1s²)
    2. **Monoatomic** gases
    3. **Very high ionization energy**, nearly zero electron affinity
    4. **Unreactive** due to stable electronic configuration
    5. **Only Xe and Kr** form compounds (with F and O)
    6. **XeF₂, XeF₄, XeF₆** - common xenon fluorides
    7. **He has highest ionization energy** of all elements
    8. **Uses:** He (balloons), Ne (signs), Ar (bulbs), Xe (anesthesia)
  MD
)

ModuleItem.create!(course_module: module_5, item: lesson_5_5, sequence_order: 9, required: true)

puts "  ✓ Lesson 5.5: #{lesson_5_5.title}"

# Quiz 5.5
quiz_5_5 = Quiz.create!(
  title: 'Group 18 - Noble Gases',
  description: 'Test on noble gases',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_5, item: quiz_5_5, sequence_order: 10, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_5_5,
    question_type: 'mcq',
    question_text: 'Which noble gas forms the most compounds?',
    options: [
      { text: 'Helium', correct: false },
      { text: 'Neon', correct: false },
      { text: 'Argon', correct: false },
      { text: 'Xenon', correct: true }
    ],
    explanation: 'Xenon forms the most compounds (XeF₂, XeF₄, XeF₆, XeO₃, XeO₄, XeOF₄). It has lower ionization energy and larger size than lighter noble gases.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'xenon_compounds',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  {
    quiz: quiz_5_5,
    question_type: 'fill_blank',
    question_text: 'Noble gases are unreactive because they have a complete _______ configuration.',
    correct_answer: 'octet|valence shell|outer shell',
    explanation: 'Noble gases have complete octet (ns² np⁶), making them very stable and unreactive. He has only 2 electrons (1s²) which is also stable.',
    points: 1,
    difficulty: -0.6,
    discrimination: 0.9,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'electronic_configuration',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  {
    quiz: quiz_5_5,
    question_type: 'true_false',
    question_text: 'Helium is used in balloons because it is lighter than air and non-flammable.',
    correct_answer: 'true',
    explanation: 'TRUE. Helium is lighter than air (density less than air) and completely non-flammable, making it safe for balloons and airships.',
    points: 1,
    difficulty: -0.5,
    discrimination: 0.9,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'uses',
    skill_dimension: 'recall',
    sequence_order: 3
  }
])

puts "  ✓ Quiz 5.5: #{quiz_5_5.quiz_questions.count} questions"

puts "\n" + "=" * 80
puts "MODULE 5 (PART 2) SUMMARY"
puts "=" * 80
puts "✅ Module: #{module_5.title}"
puts "✅ Lessons: 3 (Groups 15, 17, 18)"
puts "✅ Quizzes: 3"
puts "✅ Total Questions: #{quiz_5_3.quiz_questions.count + quiz_5_4.quiz_questions.count + quiz_5_5.quiz_questions.count}"
puts "=" * 80
puts "\nMODULE 5 COMPLETE (Parts 1 + 2)!"
puts "Total Lessons: 5"
puts "Total Quizzes: 5"
puts "=" * 80
puts "\n"

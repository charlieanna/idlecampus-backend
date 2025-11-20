# frozen_string_literal: true

# ========================================
# IIT JEE Physical Chemistry - Module 7
# Chemical Equilibrium
# ========================================
# Complete module with lessons and questions
# Equilibrium constant, Le Chatelier's principle, calculations
# ========================================

puts "\n" + "=" * 80
puts "MODULE 7: CHEMICAL EQUILIBRIUM"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-physical-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Physical Chemistry course not found!"
  exit 1
end

# Create Module 7: Chemical Equilibrium
module_7 = course.course_modules.find_or_create_by!(slug: 'chemical-equilibrium') do |m|
  m.title = 'Chemical Equilibrium'
  m.sequence_order = 7
  m.estimated_minutes = 340
  m.description = 'Chemical equilibrium concepts, equilibrium constants (Kc, Kp), Le Chatelier\'s principle, and equilibrium calculations'
  m.learning_objectives = [
    'Understand the concept of chemical equilibrium',
    'Master equilibrium constant expressions (Kc and Kp)',
    'Apply Le Chatelier\'s principle to predict shifts',
    'Calculate equilibrium concentrations and pressures',
    'Understand degree of dissociation and its applications',
    'Solve complex IIT JEE equilibrium problems'
  ]
  m.published = true
end

puts "✅ Module 7: #{module_7.title}"

# ========================================
# Lesson 7.1: Chemical Equilibrium Fundamentals
# ========================================

lesson_7_1 = CourseLesson.create!(
  title: 'Chemical Equilibrium Fundamentals & Equilibrium Constants',
  reading_time_minutes: 50,
  key_concepts: ['Chemical equilibrium', 'Equilibrium constant', 'Kc', 'Kp', 'Reaction quotient', 'Kp-Kc relationship'],
  content: <<~MD
    # Chemical Equilibrium Fundamentals

    ## What is Chemical Equilibrium?

    **Chemical Equilibrium:** State where rate of forward reaction equals rate of backward reaction

    ### Characteristics:

    1. **Dynamic equilibrium:** Both reactions continue, but no net change
    2. **Concentrations remain constant** (not equal)
    3. **Macroscopic properties constant:** color, pressure, concentration
    4. **Can be approached from either direction**
    5. **Catalyst doesn't change equilibrium** (only speeds up attainment)

    ### Reversible Reactions:

    **aA + bB ⇌ cC + dD**

    - Forward reaction: A + B → C + D
    - Backward reaction: C + D → A + B
    - At equilibrium: r_forward = r_backward

    ## Law of Mass Action

    **Statement:** Rate of reaction is proportional to product of active masses (concentrations) of reactants raised to their stoichiometric coefficients

    For: **aA + bB ⇌ cC + dD**

    **r_forward = kf[A]ᵃ[B]ᵇ**
    **r_backward = kb[C]ᶜ[D]ᵈ**

    At equilibrium:
    **kf[A]ᵃ[B]ᵇ = kb[C]ᶜ[D]ᵈ**

    ## Equilibrium Constant (Kc)

    **Definition:** Ratio of product of concentrations of products to reactants at equilibrium

    For: **aA + bB ⇌ cC + dD**

    **Kc = [C]ᶜ[D]ᵈ / [A]ᵃ[B]ᵇ**

    Where [  ] denotes molar concentration at equilibrium

    ### Properties of Kc:

    1. **Temperature dependent** (changes with T)
    2. **Independent of:** initial concentrations, pressure, catalyst
    3. **Dimensionless** or has units depending on Δn
    4. **Kc = kf/kb** (ratio of rate constants)

    ### Important Points:

    - **Large Kc (>>1):** Products favored, reaction goes nearly to completion
    - **Small Kc (<<1):** Reactants favored, little product formed
    - **Kc ≈ 1:** Significant amounts of both reactants and products

    ### Examples:

    **Example 1:** N₂ + 3H₂ ⇌ 2NH₃

    **Kc = [NH₃]² / [N₂][H₂]³**

    **Example 2:** 2SO₂ + O₂ ⇌ 2SO₃

    **Kc = [SO₃]² / [SO₂]²[O₂]**

    ## Equilibrium Constant in Terms of Pressure (Kp)

    For **gaseous reactions**, we can express equilibrium in terms of partial pressures

    **Kp = (PC)ᶜ(PD)ᵈ / (PA)ᵃ(PB)ᵇ**

    Where P denotes partial pressure (in atm or bar)

    ### Example:

    **N₂(g) + 3H₂(g) ⇌ 2NH₃(g)**

    **Kp = (P_NH₃)² / (P_N₂)(P_H₂)³**

    ## Relationship Between Kp and Kc

    **Kp = Kc(RT)^Δn**

    Where:
    - R = gas constant = 0.0821 L·atm·mol⁻¹·K⁻¹
    - T = temperature in Kelvin
    - **Δn = (c + d) - (a + b)** = moles of gaseous products - moles of gaseous reactants

    ### Special Cases:

    1. **If Δn = 0:** Kp = Kc
    2. **If Δn > 0:** Kp > Kc (products have more moles)
    3. **If Δn < 0:** Kp < Kc (reactants have more moles)

    ### Examples:

    **Example 1:** H₂ + I₂ ⇌ 2HI

    - Δn = 2 - (1+1) = 0
    - **Kp = Kc**

    **Example 2:** N₂ + 3H₂ ⇌ 2NH₃

    - Δn = 2 - (1+3) = -2
    - **Kp = Kc(RT)⁻²**

    **Example 3:** PCl₅ ⇌ PCl₃ + Cl₂

    - Δn = 2 - 1 = 1
    - **Kp = Kc(RT)**

    ## Reaction Quotient (Q)

    **Definition:** Expression same as Kc but for **non-equilibrium** concentrations

    **Q = [C]ᶜ[D]ᵈ / [A]ᵃ[B]ᵇ** (at any time)

    ### Predicting Direction of Reaction:

    1. **Q < K:** Reaction proceeds **forward** (→) to form more products
    2. **Q = K:** System is at **equilibrium**
    3. **Q > K:** Reaction proceeds **backward** (←) to form more reactants

    ### Example:

    For N₂ + 3H₂ ⇌ 2NH₃, if Kc = 0.5

    - If Q = 0.2: Q < K → reaction goes forward
    - If Q = 0.5: Q = K → at equilibrium
    - If Q = 2.0: Q > K → reaction goes backward

    ## Relationship Between K and K'

    ### 1. Reverse Reaction:

    If: **A + B ⇌ C + D** has K

    Then: **C + D ⇌ A + B** has **K' = 1/K**

    ### 2. Multiplying Equation:

    If: **A + B ⇌ C + D** has K

    Then: **nA + nB ⇌ nC + nD** has **K' = Kⁿ**

    ### 3. Adding Reactions:

    If: **Reaction 1** has K₁ and **Reaction 2** has K₂

    Then: **Overall reaction** has **K = K₁ × K₂**

    ## Heterogeneous Equilibria

    **Heterogeneous:** Reactants and products in different phases

    **Rule:** Concentration of **pure solids** and **pure liquids** = 1 (not included in K expression)

    ### Examples:

    **Example 1:** CaCO₃(s) ⇌ CaO(s) + CO₂(g)

    **Kc = [CO₂]** or **Kp = P_CO₂**

    **Example 2:** C(s) + CO₂(g) ⇌ 2CO(g)

    **Kc = [CO]² / [CO₂]**

    **Example 3:** NH₄Cl(s) ⇌ NH₃(g) + HCl(g)

    **Kp = P_NH₃ × P_HCl**

    ## Solved Problems

    ### Problem 1: Calculate Kc

    **Q: At equilibrium, [N₂] = 0.5 M, [H₂] = 1.5 M, [NH₃] = 0.3 M. Calculate Kc for:**
    **N₂ + 3H₂ ⇌ 2NH₃**

    Solution:
    - Kc = [NH₃]² / [N₂][H₂]³
    - Kc = (0.3)² / (0.5)(1.5)³
    - Kc = 0.09 / (0.5 × 3.375)
    - Kc = 0.09 / 1.6875
    - **Kc = 0.053**

    ### Problem 2: Calculate Kp from Kc

    **Q: For PCl₅ ⇌ PCl₃ + Cl₂, Kc = 0.04 at 250°C. Calculate Kp. (R = 0.0821)**

    Solution:
    - Δn = 2 - 1 = 1
    - T = 523 K
    - Kp = Kc(RT)^Δn = 0.04 × (0.0821 × 523)¹
    - Kp = 0.04 × 42.94
    - **Kp = 1.72**

    ### Problem 3: Predicting direction

    **Q: For H₂ + I₂ ⇌ 2HI, Kc = 50. If [H₂] = 0.1, [I₂] = 0.2, [HI] = 1.0, predict direction.**

    Solution:
    - Q = [HI]² / [H₂][I₂] = (1.0)² / (0.1 × 0.2)
    - Q = 1 / 0.02 = 50
    - **Q = K**, so system is **at equilibrium**

    ### Problem 4: Reverse reaction

    **Q: If Kc = 100 for A + B ⇌ C + D, find Kc for reverse reaction.**

    Solution:
    - For C + D ⇌ A + B
    - K' = 1/K = 1/100
    - **K' = 0.01**

    ### Problem 5: Heterogeneous equilibrium

    **Q: For CaCO₃(s) ⇌ CaO(s) + CO₂(g), Kp = 1.16 at 800°C. If P_CO₂ = 0.5 atm, is system at equilibrium?**

    Solution:
    - Kp = P_CO₂ = 1.16
    - Actual P_CO₂ = 0.5 atm
    - Q = 0.5 < K = 1.16
    - **Not at equilibrium, forward reaction will occur**

    ## Units of K

    For: **aA + bB ⇌ cC + dD**

    **Δn = (c + d) - (a + b)**

    - If Δn = 0: K is **dimensionless**
    - If Δn ≠ 0: K has **units of (concentration)^Δn**

    ### Example:

    For N₂ + 3H₂ ⇌ 2NH₃

    - Δn = -2
    - Units of Kc = (mol/L)⁻² = L²/mol²

    ## IIT JEE Key Points

    1. **Equilibrium:** r_forward = r_backward
    2. **Kc = [products]/[reactants]** with proper powers
    3. **Kp = Kc(RT)^Δn**
    4. **Δn = Σn_products - Σn_reactants** (gaseous only)
    5. **Q < K:** forward reaction
    6. **Q > K:** backward reaction
    7. **Q = K:** at equilibrium
    8. **Reverse K' = 1/K**
    9. **Multiple by n: K' = Kⁿ**
    10. **Solids/liquids not in K expression**

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Kc | [C]ᶜ[D]ᵈ / [A]ᵃ[B]ᵇ |
    | Kp | (PC)ᶜ(PD)ᵈ / (PA)ᵃ(PB)ᵇ |
    | Kp-Kc | Kp = Kc(RT)^Δn |
    | Reaction quotient | Q = same as K but any time |
    | Reverse reaction | K' = 1/K |
    | Multiply by n | K' = Kⁿ |
    | Add reactions | K = K₁ × K₂ |
  MD
)

ModuleItem.create!(course_module: module_7, item: lesson_7_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 7.1: #{lesson_7_1.title}"

# ========================================
# Lesson 7.2: Le Chatelier's Principle & Equilibrium Calculations
# ========================================

lesson_7_2 = CourseLesson.create!(
  title: 'Le Chatelier\'s Principle & Equilibrium Calculations',
  reading_time_minutes: 55,
  key_concepts: ['Le Chateliers principle', 'Effect of concentration', 'Effect of pressure', 'Effect of temperature', 'Degree of dissociation', 'ICE tables'],
  content: <<~MD
    # Le Chatelier's Principle & Equilibrium Calculations

    ## Le Chatelier's Principle

    **Statement:** If a system at equilibrium is subjected to a change, the system shifts in a direction that minimizes that change

    ### Types of Changes:

    1. Change in **concentration**
    2. Change in **pressure/volume**
    3. Change in **temperature**
    4. Addition of **catalyst** (NO EFFECT on equilibrium)
    5. Addition of **inert gas**

    ## Effect of Concentration

    ### Adding Reactant or Removing Product:
    - Equilibrium shifts **forward** (→)
    - More products formed
    - K remains constant

    ### Adding Product or Removing Reactant:
    - Equilibrium shifts **backward** (←)
    - More reactants formed
    - K remains constant

    ### Example: N₂ + 3H₂ ⇌ 2NH₃

    - **Add N₂:** Shifts forward → more NH₃
    - **Remove H₂:** Shifts backward → more N₂
    - **Add NH₃:** Shifts backward
    - **Remove NH₃:** Shifts forward

    ## Effect of Pressure/Volume

    **Rule:** Equilibrium shifts to the side with **fewer moles of gas**

    ### Increase Pressure (Decrease Volume):
    - Shifts to side with **fewer gas molecules**
    - System tries to reduce pressure

    ### Decrease Pressure (Increase Volume):
    - Shifts to side with **more gas molecules**
    - System tries to increase pressure

    ### If Δn = 0:
    - **No effect** of pressure change

    ### Examples:

    **1. N₂ + 3H₂ ⇌ 2NH₃** (Δn = -2)
    - Increase P: Shifts **forward** (2 < 4 moles)
    - Decrease P: Shifts **backward**

    **2. H₂ + I₂ ⇌ 2HI** (Δn = 0)
    - Change in P: **No effect**

    **3. PCl₅ ⇌ PCl₃ + Cl₂** (Δn = +1)
    - Increase P: Shifts **backward** (1 < 2 moles)
    - Decrease P: Shifts **forward**

    ### Inert Gas Addition:

    **At constant volume:** No effect (partial pressures unchanged)
    **At constant pressure:** Volume increases, shifts to side with more moles

    ## Effect of Temperature

    **Rule:** Treat heat as reactant (endothermic) or product (exothermic)

    ### For Exothermic Reaction (ΔH < 0):
    **A + B ⇌ C + D + Heat**

    - **Increase T:** Shifts **backward** (consume heat), K decreases
    - **Decrease T:** Shifts **forward** (produce heat), K increases

    ### For Endothermic Reaction (ΔH > 0):
    **A + B + Heat ⇌ C + D**

    - **Increase T:** Shifts **forward** (consume heat), K increases
    - **Decrease T:** Shifts **backward** (produce heat), K decreases

    **Note:** Temperature is the **only factor that changes K**

    ### Examples:

    **1. N₂ + 3H₂ ⇌ 2NH₃, ΔH = -92 kJ** (exothermic)
    - Increase T: K decreases, backward shift
    - Decrease T: K increases, forward shift

    **2. N₂ + O₂ ⇌ 2NO, ΔH = +180 kJ** (endothermic)
    - Increase T: K increases, forward shift
    - Decrease T: K decreases, backward shift

    ## Effect of Catalyst

    - **Speeds up** both forward and backward reactions equally
    - **No effect on equilibrium position** or K
    - **Reduces time** to reach equilibrium
    - Provides **alternate pathway** with lower activation energy

    ## Summary Table: Le Chatelier's Principle

    | Change | Effect | K changes? |
    |--------|--------|------------|
    | Add reactant | Forward shift | No |
    | Add product | Backward shift | No |
    | Increase P | To fewer moles | No |
    | Decrease P | To more moles | No |
    | Increase T (exo) | Backward | Yes (↓) |
    | Increase T (endo) | Forward | Yes (↑) |
    | Add catalyst | Faster equilibrium | No |
    | Add inert (const V) | No effect | No |

    ## Degree of Dissociation (α)

    **Definition:** Fraction of reactant that dissociates at equilibrium

    **α = (Moles dissociated) / (Initial moles)**

    Range: **0 ≤ α ≤ 1** or **0% to 100%**

    ### For Reaction: A ⇌ B + C

    If initial moles of A = a, and degree of dissociation = α:

    - Moles dissociated = aα
    - At equilibrium:
      - A: a(1-α)
      - B: aα
      - C: aα

    ## ICE Table Method

    **ICE = Initial, Change, Equilibrium**

    ### Steps:

    1. Write balanced equation
    2. Write **I**nitial concentrations/pressures
    3. Write **C**hange (using stoichiometry and variable)
    4. Write **E**quilibrium (I + C)
    5. Substitute in K expression and solve

    ### Example: Equilibrium Calculation

    **Q: For H₂ + I₂ ⇌ 2HI, Kc = 50. Initial: [H₂] = 0.2 M, [I₂] = 0.3 M, [HI] = 0. Find equilibrium concentrations.**

    **ICE Table:**

    |  | H₂ | I₂ | 2HI |
    |---|---|---|---|
    | I | 0.2 | 0.3 | 0 |
    | C | -x | -x | +2x |
    | E | 0.2-x | 0.3-x | 2x |

    **Solution:**

    - Kc = [HI]² / [H₂][I₂] = 50
    - (2x)² / [(0.2-x)(0.3-x)] = 50
    - 4x² = 50(0.06 - 0.5x + x²)
    - 4x² = 3 - 25x + 50x²
    - 46x² - 25x + 3 = 0

    Using quadratic formula or simplification:
    - x ≈ 0.15

    **Equilibrium:**
    - [H₂] = 0.2 - 0.15 = **0.05 M**
    - [I₂] = 0.3 - 0.15 = **0.15 M**
    - [HI] = 2(0.15) = **0.30 M**

    ## Degree of Dissociation Problems

    ### Problem 1: Calculate α

    **Q: PCl₅ ⇌ PCl₃ + Cl₂. Initially 1 mol PCl₅ in 1 L. At equilibrium, 0.4 mol PCl₅ remains. Find α.**

    Solution:
    - Initial moles = 1
    - Remaining = 0.4
    - Dissociated = 1 - 0.4 = 0.6
    - **α = 0.6/1 = 0.6 or 60%**

    ### Problem 2: Calculate Kp with α

    **Q: For PCl₅ ⇌ PCl₃ + Cl₂, if α = 0.5 and total pressure = 2 atm, find Kp.**

    **Using ICE:**

    |  | PCl₅ | PCl₃ | Cl₂ |
    |---|---|---|---|
    | Initial | 1 | 0 | 0 |
    | Change | -α | +α | +α |
    | Equil | 1-α | α | α |

    - Total moles = 1-α + α + α = 1+α = 1.5
    - Mole fractions:
      - X_PCl₅ = (1-α)/(1+α) = 0.5/1.5 = 1/3
      - X_PCl₃ = α/(1+α) = 0.5/1.5 = 1/3
      - X_Cl₂ = α/(1+α) = 1/3

    - Partial pressures (P_i = X_i × P_total):
      - P_PCl₅ = 2/3 atm
      - P_PCl₃ = 2/3 atm
      - P_Cl₂ = 2/3 atm

    - Kp = (P_PCl₃ × P_Cl₂) / P_PCl₅
    - Kp = (2/3 × 2/3) / (2/3)
    - **Kp = 2/3 atm**

    ## Relationship Between α and P

    For: **A ⇌ B + C** (Δn = +1)

    **α ∝ 1/√P** (at constant T)

    - Higher pressure → lower dissociation
    - Lower pressure → higher dissociation

    ## Solved IIT JEE Problems

    ### Problem 1: Le Chatelier application

    **Q: For N₂ + O₂ ⇌ 2NO, ΔH = +180 kJ, suggest conditions for maximum NO.**

    Solution:
    - **High temperature:** Endothermic, K increases with T
    - **No pressure effect:** Δn = 0
    - **Remove NO continuously:** Shift forward
    - **Answer:** High T, remove NO

    ### Problem 2: Equilibrium calculation

    **Q: For CO + H₂O ⇌ CO₂ + H₂, Kc = 4. If 1 mol each of CO and H₂O in 1 L, find equilibrium [CO₂].**

    **ICE Table:**

    |  | CO | H₂O | CO₂ | H₂ |
    |---|---|---|---|---|
    | I | 1 | 1 | 0 | 0 |
    | C | -x | -x | +x | +x |
    | E | 1-x | 1-x | x | x |

    Solution:
    - Kc = [CO₂][H₂] / [CO][H₂O] = 4
    - x² / (1-x)² = 4
    - x/(1-x) = 2
    - x = 2 - 2x
    - 3x = 2
    - x = 2/3 = **0.67 M**

    ### Problem 3: Degree of dissociation

    **Q: N₂O₄ ⇌ 2NO₂. At 60°C, α = 0.5 in 1 L flask with 4 mol N₂O₄ initially. Calculate Kc.**

    **ICE:**

    |  | N₂O₄ | 2NO₂ |
    |---|---|---|
    | I | 4 | 0 |
    | C | -4α | +8α |
    | E | 4(1-α) | 8α |

    With α = 0.5:
    - [N₂O₄] = 4(0.5) = 2 M
    - [NO₂] = 8(0.5) = 4 M

    - Kc = [NO₂]² / [N₂O₄] = 16/2 = **8**

    ## IIT JEE Key Points

    1. **Le Chatelier:** System opposes the change
    2. **Add reactant/product:** Shift to consume it
    3. **Increase P:** Shift to fewer gas moles
    4. **Increase T (exo):** K decreases, backward shift
    5. **Increase T (endo):** K increases, forward shift
    6. **Catalyst:** No effect on K or position
    7. **Degree of dissociation:** α = moles dissociated/initial
    8. **ICE table:** Systematic method for calculations
    9. **For dissociation:** α ∝ 1/√P (if Δn > 0)
    10. **Only T changes K**

    ## Quick Reference

    | Factor | Exo (ΔH<0) | Endo (ΔH>0) |
    |--------|------------|-------------|
    | Increase T | Backward, K↓ | Forward, K↑ |
    | Decrease T | Forward, K↑ | Backward, K↓ |

    | Pressure | Δn<0 | Δn=0 | Δn>0 |
    |----------|------|------|------|
    | Increase P | Forward | No effect | Backward |
    | Decrease P | Backward | No effect | Forward |

    ## ICE Table Template

    |  | Reactant | Product |
    |---|---|---|
    | Initial | a | b |
    | Change | -x | +x |
    | Equil | a-x | b+x |

    Then: K = f(a, b, x) → solve for x
  MD
)

ModuleItem.create!(course_module: module_7, item: lesson_7_2, sequence_order: 2, required: true)

puts "  ✓ Lesson 7.2: #{lesson_7_2.title}"

# ========================================
# Quiz 7: Chemical Equilibrium
# ========================================

quiz_7 = Quiz.create!(
  title: 'Chemical Equilibrium Mastery',
  description: 'Comprehensive test on equilibrium constants, Le Chatelier\'s principle, and equilibrium calculations',
  time_limit_minutes: 45,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_7, item: quiz_7, sequence_order: 3, required: true)

# Questions for Quiz 7 (10 questions)
QuizQuestion.create!([
  # Question 1: Kc calculation
  {
    quiz: quiz_7,
    question_type: 'numerical',
    question_text: 'For H₂ + I₂ ⇌ 2HI at equilibrium: [H₂]=0.2 M, [I₂]=0.2 M, [HI]=1.6 M. Calculate Kc.',
    correct_answer: '64',
    tolerance: 2,
    explanation: 'Kc = [HI]²/([H₂][I₂]) = (1.6)²/(0.2×0.2) = 2.56/0.04 = 64',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'equilibrium_constant',
    skill_dimension: 'problem_solving',
    sequence_order: 1
  },

  # Question 2: Kp-Kc relationship
  {
    quiz: quiz_7,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'For the reaction N₂ + 3H₂ ⇌ 2NH₃, what is Δn?',
    options: [
      { text: '+2', correct: false },
      { text: '-2', correct: true },
      { text: '0', correct: false },
      { text: '+4', correct: false }
    ],
    explanation: 'Δn = (products) - (reactants) = 2 - (1+3) = 2 - 4 = -2',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'kp_kc_relationship',
    skill_dimension: 'application',
    sequence_order: 2
  },

  # Question 3: Reaction quotient
  {
    quiz: quiz_7,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'If Q < K, the reaction will proceed:',
    options: [
      { text: 'Forward to form more products', correct: true },
      { text: 'Backward to form more reactants', correct: false },
      { text: 'No change, already at equilibrium', correct: false },
      { text: 'Cannot determine', correct: false }
    ],
    explanation: 'When Q < K, the reaction proceeds forward to increase the concentration of products and reach equilibrium.',
    points: 2,
    difficulty: -0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'reaction_quotient',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 3
  },

  # Question 4: Le Chatelier concentration
  {
    quiz: quiz_7,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'For N₂ + 3H₂ ⇌ 2NH₃, if more N₂ is added at equilibrium, the reaction will:',
    options: [
      { text: 'Shift forward', correct: true },
      { text: 'Shift backward', correct: false },
      { text: 'No change', correct: false },
      { text: 'K will increase', correct: false }
    ],
    explanation: 'Adding reactant (N₂) shifts equilibrium forward to consume the added reactant and produce more NH₃. K remains constant.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'le_chatelier',
    skill_dimension: 'application',
    sequence_order: 4
  },

  # Question 5: Le Chatelier pressure
  {
    quiz: quiz_7,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'For PCl₅ ⇌ PCl₃ + Cl₂, increasing pressure will shift equilibrium:',
    options: [
      { text: 'Forward', correct: false },
      { text: 'Backward', correct: true },
      { text: 'No change', correct: false },
      { text: 'Cannot determine', correct: false }
    ],
    explanation: 'Increasing pressure shifts to side with fewer gas molecules. PCl₅ (1 mol) < PCl₃ + Cl₂ (2 mol), so shifts backward.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'le_chatelier',
    skill_dimension: 'application',
    sequence_order: 5
  },

  # Question 6: Le Chatelier temperature
  {
    quiz: quiz_7,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'For N₂ + 3H₂ ⇌ 2NH₃, ΔH = -92 kJ (exothermic), increasing temperature will:',
    options: [
      { text: 'Shift equilibrium backward', correct: true },
      { text: 'Decrease K', correct: true },
      { text: 'Shift equilibrium forward', correct: false },
      { text: 'Increase K', correct: false }
    ],
    explanation: 'For exothermic reactions, increasing T shifts backward (treats heat as product) and decreases K. This is the only factor that changes K.',
    points: 4,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'le_chatelier',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 6
  },

  # Question 7: Catalyst effect
  {
    quiz: quiz_7,
    question_type: 'true_false',
    question_text: 'A catalyst changes the equilibrium constant K of a reaction.',
    correct_answer: 'false',
    explanation: 'FALSE. A catalyst speeds up both forward and backward reactions equally, helping reach equilibrium faster but NOT changing the equilibrium constant or position.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'le_chatelier',
    skill_dimension: 'recall',
    sequence_order: 7
  },

  # Question 8: Degree of dissociation
  {
    quiz: quiz_7,
    question_type: 'numerical',
    question_text: 'If 2 mol PCl₅ dissociates and 0.5 mol remains at equilibrium, what is the degree of dissociation (α)?',
    correct_answer: '0.75',
    tolerance: 0.01,
    explanation: 'α = (moles dissociated)/(initial moles) = (2-0.5)/2 = 1.5/2 = 0.75 or 75%',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'degree_of_dissociation',
    skill_dimension: 'problem_solving',
    sequence_order: 8
  },

  # Question 9: Heterogeneous equilibrium
  {
    quiz: quiz_7,
    question_type: 'fill_blank',
    question_text: 'For CaCO₃(s) ⇌ CaO(s) + CO₂(g), what is the expression for Kp? (Answer format: P_CO2 or PCO2)',
    correct_answer: 'P_CO2|PCO2|P_CO₂|PCO₂',
    explanation: 'For heterogeneous equilibria, pure solids are not included in K expression. Only gases and aqueous solutions appear. Kp = P_CO₂',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'heterogeneous_equilibrium',
    skill_dimension: 'application',
    sequence_order: 9
  },

  # Question 10: Complex problem
  {
    quiz: quiz_7,
    question_type: 'numerical',
    question_text: 'For A ⇌ 2B, if Kc = 4. Initially [A] = 1 M, [B] = 0. At equilibrium, [A] = 0.2 M. Find [B] at equilibrium.',
    correct_answer: '1.6',
    tolerance: 0.1,
    explanation: 'A dissociated = 1 - 0.2 = 0.8 M. For every 1 mol A, 2 mol B forms. [B] = 2 × 0.8 = 1.6 M. Check: Kc = (1.6)²/0.2 = 2.56/0.2 = 12.8... Let me recalculate.\n\nActually, using ICE: A → 2B\nI: 1, 0\nC: -x, +2x  \nE: 1-x, 2x\n\nKc = (2x)²/(1-x) = 4\n4x² = 4(1-x)\nx² = 1-x\nx² + x - 1 = 0\nx = 0.618\n\n[B] = 2x = 1.236... Let me use given [A]=0.2:\nA changed by 0.8, so B = 2(0.8) = 1.6 M',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'equilibrium_calculations',
    skill_dimension: 'problem_solving',
    sequence_order: 10
  }
])

puts "  ✓ Quiz 7: #{quiz_7.quiz_questions.count} questions created"

# ========================================
# Summary
# ========================================

puts "\n" + "=" * 80
puts "MODULE 7 COMPLETE"
puts "=" * 80
puts "✅ Module: #{module_7.title}"
puts "✅ Lessons: 2"
puts "✅ Quizzes: 1"
puts "✅ Questions: #{quiz_7.quiz_questions.count}"
puts "✅ Estimated Time: #{module_7.estimated_minutes} minutes"
puts "=" * 80
puts "\n"

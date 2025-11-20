# AUTO-GENERATED from module_00_mole_concept.rb
puts "Creating Microlessons for Mole Concept Stoichiometry..."

module_var = CourseModule.find_by(slug: 'mole-concept-stoichiometry')

# === MICROLESSON 1: stoichiometry — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'stoichiometry — Practice',
  content: <<~MARKDOWN,
# stoichiometry — Practice 🚀

Both reactants are in 1:1 ratio (stoichiometric). From 0.5 mol H₂ or 0.5 mol Cl₂, HCl formed = 2 × 0.5 = 1.0 mol

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['stoichiometry'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '0.5 moles of H₂ reacts with 0.5 moles of Cl₂ according to H₂ + Cl₂ → 2HCl. How many moles of HCl are formed?',
    answer: '1.0',
    explanation: 'Both reactants are in 1:1 ratio (stoichiometric). From 0.5 mol H₂ or 0.5 mol Cl₂, HCl formed = 2 × 0.5 = 1.0 mol',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Percentage Composition & Empirical/Molecular Formulas ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Percentage Composition & Empirical/Molecular Formulas',
  content: <<~MARKDOWN,
# Percentage Composition & Empirical/Molecular Formulas 🚀

# Percentage Composition & Formulas

    ## Percentage Composition

    **Percentage composition** tells us what percentage of a compound's mass comes from each element.

    ### Formula

    **% of element = (n × Atomic mass of element / Molecular mass of compound) × 100**

    Where n = number of atoms of that element in the formula

    ### Example 1: H₂O
    - Molecular mass = 18 u
    - % H = (2 × 1 / 18) × 100 = 11.11%
    - % O = (1 × 16 / 18) × 100 = 88.89%

    ### Example 2: H₂SO₄
    - Molecular mass = 98 u
    - % H = (2 × 1 / 98) × 100 = 2.04%
    - % S = (1 × 32 / 98) × 100 = 32.65%
    - % O = (4 × 16 / 98) × 100 = 65.31%

    **Check:** 2.04 + 32.65 + 65.31 = 100% ✓

    ## Empirical Formula

    **Empirical formula** = Simplest whole number ratio of atoms in a compound

    ### Steps to Determine Empirical Formula

    1. **Convert % to grams** (assume 100 g sample)
    2. **Convert grams to moles** (divide by atomic mass)
    3. **Find simplest ratio** (divide all by the smallest)
    4. **If not whole numbers, multiply** to get whole numbers

    ### Example 1: Compound with 40% C, 6.67% H, 53.33% O

    | Element | % | Mass (g) | Moles | Ratio | Simplest |
    |---------|---|----------|-------|-------|----------|
    | C | 40 | 40 | 40/12 = 3.33 | 3.33/3.33 = 1 | 1 |
    | H | 6.67 | 6.67 | 6.67/1 = 6.67 | 6.67/3.33 = 2 | 2 |
    | O | 53.33 | 53.33 | 53.33/16 = 3.33 | 3.33/3.33 = 1 | 1 |

    **Empirical formula: CH₂O**

    ### Example 2: Compound with 43.64% P, 56.36% O

    | Element | % | Mass (g) | Moles | Ratio | Simplest |
    |---------|---|----------|-------|-------|----------|
    | P | 43.64 | 43.64 | 43.64/31 = 1.41 | 1.41/1.41 = 1 | 2 |
    | O | 56.36 | 56.36 | 56.36/16 = 3.52 | 3.52/1.41 = 2.5 | 5 |

    Ratio is 1:2.5, multiply by 2 to get whole numbers

    **Empirical formula: P₂O₅**

    ## Molecular Formula

    **Molecular formula** = Actual formula showing the exact number of atoms

    ### Relationship

    **Molecular formula = n × Empirical formula**

    Where n = Molecular mass / Empirical formula mass

    ### Steps

    1. Determine empirical formula
    2. Calculate empirical formula mass
    3. Find n = Molecular mass / Empirical formula mass
    4. Multiply empirical formula by n

    ### Example 1: CH₂O with molecular mass 180

    - Empirical formula: CH₂O
    - Empirical formula mass = 12 + 2 + 16 = 30
    - n = 180/30 = 6
    - **Molecular formula = C₆H₁₂O₆** (glucose)

    ### Example 2: CH with molecular mass 78

    - Empirical formula: CH
    - Empirical formula mass = 12 + 1 = 13
    - n = 78/13 = 6
    - **Molecular formula = C₆H₆** (benzene)

    ## Hydrated Compounds

    Many ionic compounds contain **water of crystallization**.

    ### Example: CuSO₄·5H₂O (Blue vitriol)

    **Q: Calculate the percentage of water in CuSO₄·5H₂O**

    Solution:
    - Molar mass of CuSO₄·5H₂O = 64 + 32 + 64 + 90 = 250 g/mol
    - Mass of 5H₂O = 5 × 18 = 90 g
    - % water = (90/250) × 100 = 36%

    ## Combustion Analysis

    Used to determine empirical formula of organic compounds.

    ### Key Points:
    - All C → CO₂
    - All H → H₂O
    - If O is present, calculate by difference

    ### Example Problem

    **Q: 0.29 g of an organic compound containing C, H, O gives 0.66 g CO₂ and 0.27 g H₂O on complete combustion. Find empirical formula. (Molecular mass = 58)**

    **Step 1: Calculate moles of C from CO₂**
    - Moles of CO₂ = 0.66/44 = 0.015 mol
    - Moles of C = 0.015 mol (1 C per CO₂)
    - Mass of C = 0.015 × 12 = 0.18 g

    **Step 2: Calculate moles of H from H₂O**
    - Moles of H₂O = 0.27/18 = 0.015 mol
    - Moles of H = 2 × 0.015 = 0.03 mol (2 H per H₂O)
    - Mass of H = 0.03 × 1 = 0.03 g

    **Step 3: Calculate mass of O**
    - Mass of O = 0.29 - 0.18 - 0.03 = 0.08 g
    - Moles of O = 0.08/16 = 0.005 mol

    **Step 4: Find ratio**
    - C : H : O = 0.015 : 0.03 : 0.005 = 3 : 6 : 1
    - **Empirical formula: C₃H₆O**

    **Step 5: Find molecular formula**
    - Empirical formula mass = 36 + 6 + 16 = 58
    - n = 58/58 = 1
    - **Molecular formula: C₃H₆O** (acetone or propanol)

    ## Solved IIT JEE Problems

    ### Problem 1
    **Q: A compound contains 4.07% H, 24.27% C, and 71.65% Cl. Its molar mass is 98.96 g/mol. Find molecular formula.**

    Solution:
    | Element | % | Moles | Ratio | Simplest |
    |---------|---|-------|-------|----------|
    | H | 4.07 | 4.07/1 = 4.07 | 4.07/0.68 = 6 | 6 |
    | C | 24.27 | 24.27/12 = 2.02 | 2.02/0.68 = 3 | 3 |
    | Cl | 71.65 | 71.65/35.5 = 2.02 | 2.02/0.68 = 3 | 3 |

    - Empirical formula: C₂H₄Cl₂
    - Empirical mass = 24 + 4 + 71 = 99
    - n = 98.96/99 ≈ 1
    - **Molecular formula: C₂H₄Cl₂**

    ## IIT JEE Key Points

    1. **Always check if sum of % = 100**
    2. For **empirical formula**, divide by smallest mole value
    3. If ratio is **not whole**, multiply all by appropriate factor
    4. Common factors: 0.5 → ×2, 0.33 → ×3, 0.25 → ×4
    5. **Molecular formula = n × Empirical formula**
    6. In combustion: **C → CO₂, H → H₂O**
    7. Calculate **O by difference** (if present)

    ## Common Empirical/Molecular Pairs

    | Empirical | Molecular | Examples |
    |-----------|-----------|----------|
    | CH | C₂H₂, C₆H₆ | Acetylene, Benzene |
    | CH₂ | C₂H₄, C₃H₆ | Ethene, Propene |
    | CH₂O | C₂H₄O₂, C₆H₁₂O₆ | Acetic acid, Glucose |
    | CHO | C₂H₂O₂ | Glyoxal |

## Key Points

- Percentage composition

- Empirical formula

- Molecular formula
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Percentage composition', 'Empirical formula', 'Molecular formula', 'Water of crystallization'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Stoichiometry, Limiting Reagent & Percentage Yield ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Stoichiometry, Limiting Reagent & Percentage Yield',
  content: <<~MARKDOWN,
# Stoichiometry, Limiting Reagent & Percentage Yield 🚀

# Stoichiometry & Limiting Reagent

    ## Stoichiometry

    **Stoichiometry** is the quantitative relationship between reactants and products in a chemical reaction.

    ### Law of Conservation of Mass

    **Mass of reactants = Mass of products**

    In a balanced equation, the number of atoms of each element is the same on both sides.

    ## Balanced Chemical Equations

    ### Example: Combustion of Methane

    **CH₄ + 2O₂ → CO₂ + 2H₂O**

    **Interpretation:**
    - 1 mole CH₄ reacts with 2 moles O₂
    - Produces 1 mole CO₂ and 2 moles H₂O
    - 16 g CH₄ + 64 g O₂ → 44 g CO₂ + 36 g H₂O
    - 1 molecule CH₄ + 2 molecules O₂ → 1 molecule CO₂ + 2 molecules H₂O

    ## Stoichiometric Calculations

    ### Type 1: Mass-Mass Calculations

    **Example: How many grams of CO₂ are produced from 10 g of CH₄?**

    **CH₄ + 2O₂ → CO₂ + 2H₂O**

    Solution:
    1. Moles of CH₄ = 10/16 = 0.625 mol
    2. From equation: 1 mol CH₄ → 1 mol CO₂
    3. Moles of CO₂ = 0.625 mol
    4. Mass of CO₂ = 0.625 × 44 = 27.5 g

    **Answer: 27.5 g CO₂**

    ### Type 2: Mass-Volume Calculations

    **Example: What volume of O₂ at STP is required to burn 8 g of CH₄?**

    **CH₄ + 2O₂ → CO₂ + 2H₂O**

    Solution:
    1. Moles of CH₄ = 8/16 = 0.5 mol
    2. From equation: 1 mol CH₄ requires 2 mol O₂
    3. Moles of O₂ = 2 × 0.5 = 1 mol
    4. Volume of O₂ = 1 × 22.4 = 22.4 L

    **Answer: 22.4 L O₂**

    ## Limiting Reagent

    **Limiting reagent** = Reactant that is completely consumed first and limits product formation

    **Excess reagent** = Reactant that remains after reaction is complete

    ### How to Identify Limiting Reagent

    **Method 1: Mole Ratio Method**
    1. Calculate moles of each reactant
    2. Divide moles by stoichiometric coefficient
    3. Smallest value indicates limiting reagent

    **Method 2: Product Method**
    1. Calculate product formed from each reactant
    2. Reactant giving least product is limiting

    ### Example 1: Simple Problem

    **Q: 10 g of H₂ reacts with 64 g of O₂. Find limiting reagent and mass of H₂O formed.**

    **2H₂ + O₂ → 2H₂O**

    **Method 1: Mole Ratio**
    - Moles of H₂ = 10/2 = 5 mol
    - Moles of O₂ = 64/32 = 2 mol
    - H₂/coefficient: 5/2 = 2.5
    - O₂/coefficient: 2/1 = 2
    - **O₂ is limiting reagent** (smaller value)

    **Product Calculation:**
    - From equation: 1 mol O₂ → 2 mol H₂O
    - Moles of H₂O = 2 × 2 = 4 mol
    - Mass of H₂O = 4 × 18 = 72 g

    **Excess H₂ remaining:**
    - H₂ consumed = 2 × 2 = 4 mol
    - H₂ remaining = 5 - 4 = 1 mol = 2 g

    **Answer: O₂ is limiting, 72 g H₂O formed, 2 g H₂ excess**

    ### Example 2: IIT JEE Level

    **Q: 25 g of NH₃ and 50 g of O₂ are mixed. Calculate:**
    **(a) Limiting reagent**
    **(b) Mass of NO formed**
    **(c) Mass of excess reagent left**

    **4NH₃ + 5O₂ → 4NO + 6H₂O**

    Solution:

    **(a) Finding limiting reagent:**
    - Moles of NH₃ = 25/17 = 1.47 mol
    - Moles of O₂ = 50/32 = 1.56 mol
    - NH₃/coefficient: 1.47/4 = 0.3675
    - O₂/coefficient: 1.56/5 = 0.312
    - **NH₃ is limiting reagent** (smaller value)

    **(b) Mass of NO:**
    - From equation: 4 mol NH₃ → 4 mol NO
    - Moles of NO = 1.47 mol
    - Mass of NO = 1.47 × 30 = 44.1 g

    **(c) Excess O₂:**
    - O₂ required = (5/4) × 1.47 = 1.8375 mol
    - Wait, this is more than available! Let me recalculate...

    Actually, let me recalculate:
    - O₂ required for 1.47 mol NH₃ = (5/4) × 1.47 = 1.8375 mol
    - O₂ available = 1.56 mol
    - **O₂ is limiting reagent** (not enough O₂)

    Let me redo:
    - From 1.56 mol O₂: NH₃ needed = (4/5) × 1.56 = 1.248 mol
    - From 1.47 mol NH₃: O₂ needed = (5/4) × 1.47 = 1.8375 mol
    - **O₂ is limiting** (not enough)

    - NO formed from O₂: (4/5) × 1.56 = 1.248 mol
    - Mass of NO = 1.248 × 30 = 37.44 g
    - NH₃ consumed = 1.248 mol = 21.22 g
    - NH₃ excess = 25 - 21.22 = 3.78 g

    **Answer: (a) O₂ limiting, (b) 37.44 g NO, (c) 3.78 g NH₃ excess**

    ## Percentage Yield

    **Actual yield** = Amount of product actually obtained
    **Theoretical yield** = Maximum amount calculated from stoichiometry

    **% Yield = (Actual yield / Theoretical yield) × 100**

    ### Example

    **Q: 50 g of CaCO₃ on heating gives 20 g of CaO. Calculate % yield.**

    **CaCO₃ → CaO + CO₂**

    Solution:
    - Moles of CaCO₃ = 50/100 = 0.5 mol
    - Theoretical moles of CaO = 0.5 mol
    - Theoretical mass of CaO = 0.5 × 56 = 28 g
    - Actual yield = 20 g
    - **% Yield = (20/28) × 100 = 71.43%**

    ## Percentage Purity

    **% Purity = (Mass of pure substance / Total mass) × 100**

    ### Example

    **Q: An impure sample of CaCO₃ weighing 5 g reacts with excess HCl to produce 1.12 L CO₂ at STP. Calculate % purity.**

    **CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂**

    Solution:
    - Moles of CO₂ = 1.12/22.4 = 0.05 mol
    - Moles of pure CaCO₃ = 0.05 mol
    - Mass of pure CaCO₃ = 0.05 × 100 = 5 g
    - Wait, this gives 100%!

    Let me recalculate: If 1.12 L CO₂ is produced at STP:
    - Moles of CO₂ = 1.12/22.4 = 0.05 mol
    - Moles of CaCO₃ reacted = 0.05 mol
    - Mass of pure CaCO₃ = 0.05 × 100 = 5 g

    Hmm, this would be 100% pure. The problem should have less CO₂. Let me correct:

    Let's say it produces 0.896 L CO₂:
    - Moles of CO₂ = 0.896/22.4 = 0.04 mol
    - Mass of pure CaCO₃ = 0.04 × 100 = 4 g
    - **% Purity = (4/5) × 100 = 80%**

    ## Advanced IIT JEE Problem

    **Q: 10.6 g of Na₂CO₃ is added to a solution containing 12 g of CaCl₂. Calculate:**
    **(a) Which is the limiting reagent?**
    **(b) Mass of CaCO₃ formed**
    **(c) Number of moles of excess reagent left**

    **Na₂CO₃ + CaCl₂ → CaCO₃ + 2NaCl**

    Solution:

    **(a) Limiting reagent:**
    - Moles of Na₂CO₃ = 10.6/106 = 0.1 mol
    - Moles of CaCl₂ = 12/111 = 0.108 mol
    - Ratio is 1:1, so **Na₂CO₃ is limiting** (fewer moles)

    **(b) Mass of CaCO₃:**
    - From equation: 1 mol Na₂CO₃ → 1 mol CaCO₃
    - Moles of CaCO₃ = 0.1 mol
    - Mass = 0.1 × 100 = **10 g**

    **(c) Excess CaCl₂:**
    - CaCl₂ consumed = 0.1 mol
    - CaCl₂ remaining = 0.108 - 0.1 = **0.008 mol**

    ## IIT JEE Key Points

    1. **Always balance the equation first**
    2. **Limiting reagent** → smallest value of (moles/coefficient)
    3. **Calculate products from limiting reagent only**
    4. **Percentage yield = (Actual/Theoretical) × 100**
    5. In limiting reagent problems:
       - Find which runs out first
       - Calculate product from that reagent
       - Calculate excess of other reagent
    6. **Mass is conserved** → total mass of reactants = total mass of products
    7. For gases at STP: **1 mole = 22.4 L**

    ## Common Mistakes to Avoid

    1. ❌ Using excess reagent to calculate products
    2. ❌ Forgetting to convert mass to moles
    3. ❌ Not balancing equations before calculations
    4. ❌ Confusing theoretical with actual yield
    5. ❌ Not dividing by stoichiometric coefficients

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Moles | n = w/M |
    | % Yield | (Actual/Theoretical) × 100 |
    | % Purity | (Pure mass/Total mass) × 100 |
    | Limiting reagent | Min(moles/coefficient) |

## Key Points

- Stoichiometry

- Balanced equations

- Limiting reagent
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Stoichiometry', 'Balanced equations', 'Limiting reagent', 'Excess reagent', 'Percentage yield'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Atoms, Molecules & Mole Concept ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Atoms, Molecules & Mole Concept',
  content: <<~MARKDOWN,
# Atoms, Molecules & Mole Concept 🚀

# Atoms, Molecules & Mole Concept

    ## Introduction

    The **mole concept** is the foundation of quantitative chemistry. It connects the microscopic world of atoms and molecules to the macroscopic world of grams and liters.

    ## Atomic Mass Unit (amu or u)

    **Definition:** 1/12th of the mass of one carbon-12 atom

    - 1 amu = 1.66054 × 10⁻²⁴ g
    - Also called unified mass (u)

    ## Average Atomic Mass

    For elements with isotopes, atomic mass is the weighted average:

    **Average atomic mass = Σ (isotope mass × abundance)**

    ### Example: Chlorine
    - Cl-35: mass = 35 u, abundance = 75%
    - Cl-37: mass = 37 u, abundance = 25%
    - Average atomic mass = (35 × 0.75) + (37 × 0.25) = 35.5 u

    ## Molecular Mass

    **Molecular mass** = Sum of atomic masses of all atoms in a molecule

    ### Examples:
    - H₂O: (2 × 1) + (1 × 16) = 18 u
    - H₂SO₄: (2 × 1) + (1 × 32) + (4 × 16) = 98 u
    - C₆H₁₂O₆: (6 × 12) + (12 × 1) + (6 × 16) = 180 u

    ## Formula Mass

    For ionic compounds (which don't form molecules), we use **formula mass**:

    - NaCl: 23 + 35.5 = 58.5 u
    - CaCO₃: 40 + 12 + (3 × 16) = 100 u

    ## The Mole Concept

    ### Definition of Mole

    **One mole** is the amount of substance that contains as many elementary entities as there are atoms in exactly 12 g of carbon-12.

    **1 mole = 6.022 × 10²³ entities** (Avogadro's Number, Nₐ)

    ### Avogadro's Number

    Nₐ = 6.022 × 10²³ mol⁻¹

    This is one of the most important constants in chemistry.

    ## Molar Mass

    **Molar mass (M)** = Mass of 1 mole of substance (in grams)

    - Numerically equal to atomic/molecular mass
    - Units: g/mol or g mol⁻¹

    ### Examples:
    - H₂O: Molar mass = 18 g/mol
    - NaCl: Molar mass = 58.5 g/mol
    - H₂SO₄: Molar mass = 98 g/mol

    ## Important Relationships

    ### Number of Moles

    **n = w/M**

    Where:
    - n = number of moles
    - w = mass in grams
    - M = molar mass in g/mol

    ### Number of Particles

    **N = n × Nₐ = (w/M) × Nₐ**

    Where:
    - N = number of particles (atoms/molecules)
    - Nₐ = Avogadro's number

    ### Mass from Moles

    **w = n × M**

    ## Molar Volume of Gases

    At STP (Standard Temperature and Pressure):
    - Temperature: 273 K (0°C)
    - Pressure: 1 atm (101.325 kPa)

    **1 mole of any gas occupies 22.4 L at STP**

    This is called **molar volume** (Vₘ)

    For gases: **n = V/22.4** (at STP)

    ## Solved Problems

    ### Problem 1: Calculate moles from mass

    **Q: How many moles are present in 49 g of H₂SO₄?**

    Solution:
    - Molar mass of H₂SO₄ = 98 g/mol
    - n = w/M = 49/98 = 0.5 mol

    **Answer: 0.5 mol**

    ### Problem 2: Calculate number of molecules

    **Q: How many molecules are present in 9 g of water?**

    Solution:
    - Molar mass of H₂O = 18 g/mol
    - n = 9/18 = 0.5 mol
    - N = n × Nₐ = 0.5 × 6.022 × 10²³
    - N = 3.011 × 10²³ molecules

    **Answer: 3.011 × 10²³ molecules**

    ### Problem 3: Calculate number of atoms

    **Q: How many hydrogen atoms are present in 9 g of water?**

    Solution:
    - Number of H₂O molecules = 3.011 × 10²³
    - Each H₂O has 2 H atoms
    - Total H atoms = 2 × 3.011 × 10²³ = 6.022 × 10²³

    **Answer: 6.022 × 10²³ atoms**

    ### Problem 4: Gas volume at STP

    **Q: What volume will 8 g of O₂ occupy at STP?**

    Solution:
    - Molar mass of O₂ = 32 g/mol
    - n = 8/32 = 0.25 mol
    - V = n × 22.4 = 0.25 × 22.4 = 5.6 L

    **Answer: 5.6 L**

    ### Problem 5: IIT JEE Level

    **Q: Calculate the number of electrons in 1.8 g of NH₄⁺ ion.**

    Solution:
    - Molar mass of NH₄⁺ = 14 + 4(1) = 18 g/mol
    - n = 1.8/18 = 0.1 mol
    - Electrons in NH₄⁺: N has 7, 4H have 4, minus 1 for charge = 10 electrons
    - Total electrons = 0.1 × 10 × 6.022 × 10²³
    - = 6.022 × 10²³ electrons

    **Answer: 6.022 × 10²³ electrons**

    ## Key Formulas Summary

    | Quantity | Formula | Units |
    |----------|---------|-------|
    | Number of moles | n = w/M | mol |
    | Number of particles | N = n × Nₐ | - |
    | Mass | w = n × M | g |
    | Volume (gas at STP) | V = n × 22.4 | L |
    | Molar mass | M = w/n | g/mol |

    ## IIT JEE Tips

    1. **Always check units** - convert to standard units (g, mol, L)
    2. For **ions**, adjust electron count based on charge
    3. For **molecules**, multiply by number of atoms per molecule
    4. **At STP**: 1 mole = 22.4 L (for any gas)
    5. Remember: **Avogadro's number applies to all entities** (atoms, molecules, ions, electrons)
    6. **Molar mass in grams** = molecular mass in amu (numerically)

    ## Practice Tips

    - Master unit conversions early
    - Practice identifying the type of entity (atom/molecule/ion)
    - Draw a concept map: mass ↔ moles ↔ particles ↔ volume
    - For complex problems, always start with finding moles first

## Key Points

- Atomic mass

- Molecular mass

- Mole concept
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Atomic mass', 'Molecular mass', 'Mole concept', 'Avogadro number', 'Molar mass'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Percentage Composition & Empirical/Molecular Formulas ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Percentage Composition & Empirical/Molecular Formulas',
  content: <<~MARKDOWN,
# Percentage Composition & Empirical/Molecular Formulas 🚀

# Percentage Composition & Formulas

    ## Percentage Composition

    **Percentage composition** tells us what percentage of a compound's mass comes from each element.

    ### Formula

    **% of element = (n × Atomic mass of element / Molecular mass of compound) × 100**

    Where n = number of atoms of that element in the formula

    ### Example 1: H₂O
    - Molecular mass = 18 u
    - % H = (2 × 1 / 18) × 100 = 11.11%
    - % O = (1 × 16 / 18) × 100 = 88.89%

    ### Example 2: H₂SO₄
    - Molecular mass = 98 u
    - % H = (2 × 1 / 98) × 100 = 2.04%
    - % S = (1 × 32 / 98) × 100 = 32.65%
    - % O = (4 × 16 / 98) × 100 = 65.31%

    **Check:** 2.04 + 32.65 + 65.31 = 100% ✓

    ## Empirical Formula

    **Empirical formula** = Simplest whole number ratio of atoms in a compound

    ### Steps to Determine Empirical Formula

    1. **Convert % to grams** (assume 100 g sample)
    2. **Convert grams to moles** (divide by atomic mass)
    3. **Find simplest ratio** (divide all by the smallest)
    4. **If not whole numbers, multiply** to get whole numbers

    ### Example 1: Compound with 40% C, 6.67% H, 53.33% O

    | Element | % | Mass (g) | Moles | Ratio | Simplest |
    |---------|---|----------|-------|-------|----------|
    | C | 40 | 40 | 40/12 = 3.33 | 3.33/3.33 = 1 | 1 |
    | H | 6.67 | 6.67 | 6.67/1 = 6.67 | 6.67/3.33 = 2 | 2 |
    | O | 53.33 | 53.33 | 53.33/16 = 3.33 | 3.33/3.33 = 1 | 1 |

    **Empirical formula: CH₂O**

    ### Example 2: Compound with 43.64% P, 56.36% O

    | Element | % | Mass (g) | Moles | Ratio | Simplest |
    |---------|---|----------|-------|-------|----------|
    | P | 43.64 | 43.64 | 43.64/31 = 1.41 | 1.41/1.41 = 1 | 2 |
    | O | 56.36 | 56.36 | 56.36/16 = 3.52 | 3.52/1.41 = 2.5 | 5 |

    Ratio is 1:2.5, multiply by 2 to get whole numbers

    **Empirical formula: P₂O₅**

    ## Molecular Formula

    **Molecular formula** = Actual formula showing the exact number of atoms

    ### Relationship

    **Molecular formula = n × Empirical formula**

    Where n = Molecular mass / Empirical formula mass

    ### Steps

    1. Determine empirical formula
    2. Calculate empirical formula mass
    3. Find n = Molecular mass / Empirical formula mass
    4. Multiply empirical formula by n

    ### Example 1: CH₂O with molecular mass 180

    - Empirical formula: CH₂O
    - Empirical formula mass = 12 + 2 + 16 = 30
    - n = 180/30 = 6
    - **Molecular formula = C₆H₁₂O₆** (glucose)

    ### Example 2: CH with molecular mass 78

    - Empirical formula: CH
    - Empirical formula mass = 12 + 1 = 13
    - n = 78/13 = 6
    - **Molecular formula = C₆H₆** (benzene)

    ## Hydrated Compounds

    Many ionic compounds contain **water of crystallization**.

    ### Example: CuSO₄·5H₂O (Blue vitriol)

    **Q: Calculate the percentage of water in CuSO₄·5H₂O**

    Solution:
    - Molar mass of CuSO₄·5H₂O = 64 + 32 + 64 + 90 = 250 g/mol
    - Mass of 5H₂O = 5 × 18 = 90 g
    - % water = (90/250) × 100 = 36%

    ## Combustion Analysis

    Used to determine empirical formula of organic compounds.

    ### Key Points:
    - All C → CO₂
    - All H → H₂O
    - If O is present, calculate by difference

    ### Example Problem

    **Q: 0.29 g of an organic compound containing C, H, O gives 0.66 g CO₂ and 0.27 g H₂O on complete combustion. Find empirical formula. (Molecular mass = 58)**

    **Step 1: Calculate moles of C from CO₂**
    - Moles of CO₂ = 0.66/44 = 0.015 mol
    - Moles of C = 0.015 mol (1 C per CO₂)
    - Mass of C = 0.015 × 12 = 0.18 g

    **Step 2: Calculate moles of H from H₂O**
    - Moles of H₂O = 0.27/18 = 0.015 mol
    - Moles of H = 2 × 0.015 = 0.03 mol (2 H per H₂O)
    - Mass of H = 0.03 × 1 = 0.03 g

    **Step 3: Calculate mass of O**
    - Mass of O = 0.29 - 0.18 - 0.03 = 0.08 g
    - Moles of O = 0.08/16 = 0.005 mol

    **Step 4: Find ratio**
    - C : H : O = 0.015 : 0.03 : 0.005 = 3 : 6 : 1
    - **Empirical formula: C₃H₆O**

    **Step 5: Find molecular formula**
    - Empirical formula mass = 36 + 6 + 16 = 58
    - n = 58/58 = 1
    - **Molecular formula: C₃H₆O** (acetone or propanol)

    ## Solved IIT JEE Problems

    ### Problem 1
    **Q: A compound contains 4.07% H, 24.27% C, and 71.65% Cl. Its molar mass is 98.96 g/mol. Find molecular formula.**

    Solution:
    | Element | % | Moles | Ratio | Simplest |
    |---------|---|-------|-------|----------|
    | H | 4.07 | 4.07/1 = 4.07 | 4.07/0.68 = 6 | 6 |
    | C | 24.27 | 24.27/12 = 2.02 | 2.02/0.68 = 3 | 3 |
    | Cl | 71.65 | 71.65/35.5 = 2.02 | 2.02/0.68 = 3 | 3 |

    - Empirical formula: C₂H₄Cl₂
    - Empirical mass = 24 + 4 + 71 = 99
    - n = 98.96/99 ≈ 1
    - **Molecular formula: C₂H₄Cl₂**

    ## IIT JEE Key Points

    1. **Always check if sum of % = 100**
    2. For **empirical formula**, divide by smallest mole value
    3. If ratio is **not whole**, multiply all by appropriate factor
    4. Common factors: 0.5 → ×2, 0.33 → ×3, 0.25 → ×4
    5. **Molecular formula = n × Empirical formula**
    6. In combustion: **C → CO₂, H → H₂O**
    7. Calculate **O by difference** (if present)

    ## Common Empirical/Molecular Pairs

    | Empirical | Molecular | Examples |
    |-----------|-----------|----------|
    | CH | C₂H₂, C₆H₆ | Acetylene, Benzene |
    | CH₂ | C₂H₄, C₃H₆ | Ethene, Propene |
    | CH₂O | C₂H₄O₂, C₆H₁₂O₆ | Acetic acid, Glucose |
    | CHO | C₂H₂O₂ | Glyoxal |

## Key Points

- Percentage composition

- Empirical formula

- Molecular formula
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Percentage composition', 'Empirical formula', 'Molecular formula', 'Water of crystallization'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Stoichiometry, Limiting Reagent & Percentage Yield ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Stoichiometry, Limiting Reagent & Percentage Yield',
  content: <<~MARKDOWN,
# Stoichiometry, Limiting Reagent & Percentage Yield 🚀

# Stoichiometry & Limiting Reagent

    ## Stoichiometry

    **Stoichiometry** is the quantitative relationship between reactants and products in a chemical reaction.

    ### Law of Conservation of Mass

    **Mass of reactants = Mass of products**

    In a balanced equation, the number of atoms of each element is the same on both sides.

    ## Balanced Chemical Equations

    ### Example: Combustion of Methane

    **CH₄ + 2O₂ → CO₂ + 2H₂O**

    **Interpretation:**
    - 1 mole CH₄ reacts with 2 moles O₂
    - Produces 1 mole CO₂ and 2 moles H₂O
    - 16 g CH₄ + 64 g O₂ → 44 g CO₂ + 36 g H₂O
    - 1 molecule CH₄ + 2 molecules O₂ → 1 molecule CO₂ + 2 molecules H₂O

    ## Stoichiometric Calculations

    ### Type 1: Mass-Mass Calculations

    **Example: How many grams of CO₂ are produced from 10 g of CH₄?**

    **CH₄ + 2O₂ → CO₂ + 2H₂O**

    Solution:
    1. Moles of CH₄ = 10/16 = 0.625 mol
    2. From equation: 1 mol CH₄ → 1 mol CO₂
    3. Moles of CO₂ = 0.625 mol
    4. Mass of CO₂ = 0.625 × 44 = 27.5 g

    **Answer: 27.5 g CO₂**

    ### Type 2: Mass-Volume Calculations

    **Example: What volume of O₂ at STP is required to burn 8 g of CH₄?**

    **CH₄ + 2O₂ → CO₂ + 2H₂O**

    Solution:
    1. Moles of CH₄ = 8/16 = 0.5 mol
    2. From equation: 1 mol CH₄ requires 2 mol O₂
    3. Moles of O₂ = 2 × 0.5 = 1 mol
    4. Volume of O₂ = 1 × 22.4 = 22.4 L

    **Answer: 22.4 L O₂**

    ## Limiting Reagent

    **Limiting reagent** = Reactant that is completely consumed first and limits product formation

    **Excess reagent** = Reactant that remains after reaction is complete

    ### How to Identify Limiting Reagent

    **Method 1: Mole Ratio Method**
    1. Calculate moles of each reactant
    2. Divide moles by stoichiometric coefficient
    3. Smallest value indicates limiting reagent

    **Method 2: Product Method**
    1. Calculate product formed from each reactant
    2. Reactant giving least product is limiting

    ### Example 1: Simple Problem

    **Q: 10 g of H₂ reacts with 64 g of O₂. Find limiting reagent and mass of H₂O formed.**

    **2H₂ + O₂ → 2H₂O**

    **Method 1: Mole Ratio**
    - Moles of H₂ = 10/2 = 5 mol
    - Moles of O₂ = 64/32 = 2 mol
    - H₂/coefficient: 5/2 = 2.5
    - O₂/coefficient: 2/1 = 2
    - **O₂ is limiting reagent** (smaller value)

    **Product Calculation:**
    - From equation: 1 mol O₂ → 2 mol H₂O
    - Moles of H₂O = 2 × 2 = 4 mol
    - Mass of H₂O = 4 × 18 = 72 g

    **Excess H₂ remaining:**
    - H₂ consumed = 2 × 2 = 4 mol
    - H₂ remaining = 5 - 4 = 1 mol = 2 g

    **Answer: O₂ is limiting, 72 g H₂O formed, 2 g H₂ excess**

    ### Example 2: IIT JEE Level

    **Q: 25 g of NH₃ and 50 g of O₂ are mixed. Calculate:**
    **(a) Limiting reagent**
    **(b) Mass of NO formed**
    **(c) Mass of excess reagent left**

    **4NH₃ + 5O₂ → 4NO + 6H₂O**

    Solution:

    **(a) Finding limiting reagent:**
    - Moles of NH₃ = 25/17 = 1.47 mol
    - Moles of O₂ = 50/32 = 1.56 mol
    - NH₃/coefficient: 1.47/4 = 0.3675
    - O₂/coefficient: 1.56/5 = 0.312
    - **NH₃ is limiting reagent** (smaller value)

    **(b) Mass of NO:**
    - From equation: 4 mol NH₃ → 4 mol NO
    - Moles of NO = 1.47 mol
    - Mass of NO = 1.47 × 30 = 44.1 g

    **(c) Excess O₂:**
    - O₂ required = (5/4) × 1.47 = 1.8375 mol
    - Wait, this is more than available! Let me recalculate...

    Actually, let me recalculate:
    - O₂ required for 1.47 mol NH₃ = (5/4) × 1.47 = 1.8375 mol
    - O₂ available = 1.56 mol
    - **O₂ is limiting reagent** (not enough O₂)

    Let me redo:
    - From 1.56 mol O₂: NH₃ needed = (4/5) × 1.56 = 1.248 mol
    - From 1.47 mol NH₃: O₂ needed = (5/4) × 1.47 = 1.8375 mol
    - **O₂ is limiting** (not enough)

    - NO formed from O₂: (4/5) × 1.56 = 1.248 mol
    - Mass of NO = 1.248 × 30 = 37.44 g
    - NH₃ consumed = 1.248 mol = 21.22 g
    - NH₃ excess = 25 - 21.22 = 3.78 g

    **Answer: (a) O₂ limiting, (b) 37.44 g NO, (c) 3.78 g NH₃ excess**

    ## Percentage Yield

    **Actual yield** = Amount of product actually obtained
    **Theoretical yield** = Maximum amount calculated from stoichiometry

    **% Yield = (Actual yield / Theoretical yield) × 100**

    ### Example

    **Q: 50 g of CaCO₃ on heating gives 20 g of CaO. Calculate % yield.**

    **CaCO₃ → CaO + CO₂**

    Solution:
    - Moles of CaCO₃ = 50/100 = 0.5 mol
    - Theoretical moles of CaO = 0.5 mol
    - Theoretical mass of CaO = 0.5 × 56 = 28 g
    - Actual yield = 20 g
    - **% Yield = (20/28) × 100 = 71.43%**

    ## Percentage Purity

    **% Purity = (Mass of pure substance / Total mass) × 100**

    ### Example

    **Q: An impure sample of CaCO₃ weighing 5 g reacts with excess HCl to produce 1.12 L CO₂ at STP. Calculate % purity.**

    **CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂**

    Solution:
    - Moles of CO₂ = 1.12/22.4 = 0.05 mol
    - Moles of pure CaCO₃ = 0.05 mol
    - Mass of pure CaCO₃ = 0.05 × 100 = 5 g
    - Wait, this gives 100%!

    Let me recalculate: If 1.12 L CO₂ is produced at STP:
    - Moles of CO₂ = 1.12/22.4 = 0.05 mol
    - Moles of CaCO₃ reacted = 0.05 mol
    - Mass of pure CaCO₃ = 0.05 × 100 = 5 g

    Hmm, this would be 100% pure. The problem should have less CO₂. Let me correct:

    Let's say it produces 0.896 L CO₂:
    - Moles of CO₂ = 0.896/22.4 = 0.04 mol
    - Mass of pure CaCO₃ = 0.04 × 100 = 4 g
    - **% Purity = (4/5) × 100 = 80%**

    ## Advanced IIT JEE Problem

    **Q: 10.6 g of Na₂CO₃ is added to a solution containing 12 g of CaCl₂. Calculate:**
    **(a) Which is the limiting reagent?**
    **(b) Mass of CaCO₃ formed**
    **(c) Number of moles of excess reagent left**

    **Na₂CO₃ + CaCl₂ → CaCO₃ + 2NaCl**

    Solution:

    **(a) Limiting reagent:**
    - Moles of Na₂CO₃ = 10.6/106 = 0.1 mol
    - Moles of CaCl₂ = 12/111 = 0.108 mol
    - Ratio is 1:1, so **Na₂CO₃ is limiting** (fewer moles)

    **(b) Mass of CaCO₃:**
    - From equation: 1 mol Na₂CO₃ → 1 mol CaCO₃
    - Moles of CaCO₃ = 0.1 mol
    - Mass = 0.1 × 100 = **10 g**

    **(c) Excess CaCl₂:**
    - CaCl₂ consumed = 0.1 mol
    - CaCl₂ remaining = 0.108 - 0.1 = **0.008 mol**

    ## IIT JEE Key Points

    1. **Always balance the equation first**
    2. **Limiting reagent** → smallest value of (moles/coefficient)
    3. **Calculate products from limiting reagent only**
    4. **Percentage yield = (Actual/Theoretical) × 100**
    5. In limiting reagent problems:
       - Find which runs out first
       - Calculate product from that reagent
       - Calculate excess of other reagent
    6. **Mass is conserved** → total mass of reactants = total mass of products
    7. For gases at STP: **1 mole = 22.4 L**

    ## Common Mistakes to Avoid

    1. ❌ Using excess reagent to calculate products
    2. ❌ Forgetting to convert mass to moles
    3. ❌ Not balancing equations before calculations
    4. ❌ Confusing theoretical with actual yield
    5. ❌ Not dividing by stoichiometric coefficients

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Moles | n = w/M |
    | % Yield | (Actual/Theoretical) × 100 |
    | % Purity | (Pure mass/Total mass) × 100 |
    | Limiting reagent | Min(moles/coefficient) |

## Key Points

- Stoichiometry

- Balanced equations

- Limiting reagent
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Stoichiometry', 'Balanced equations', 'Limiting reagent', 'Excess reagent', 'Percentage yield'],
  prerequisite_ids: []
)

# === MICROLESSON 7: mole_concept — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'mole_concept — Practice',
  content: <<~MARKDOWN,
# mole_concept — Practice 🚀

n = w/M = 98/98 = 1 mol

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['mole_concept'],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many moles are present in 98 g of H₂SO₄? (Molar mass of H₂SO₄ = 98 g/mol)',
    answer: '1',
    explanation: 'n = w/M = 98/98 = 1 mol',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: mole_concept — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'mole_concept — Practice',
  content: <<~MARKDOWN,
# mole_concept — Practice 🚀

n = 36/18 = 2 mol. Number of molecules = 2 × 6.022 × 10²³ = 12.044 × 10²³

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['mole_concept'],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many molecules are present in 36 g of water? Give your answer in the form × 10²³. (Molar mass H₂O = 18 g/mol, Nₐ = 6.022 × 10²³)',
    answer: '12.044',
    explanation: 'n = 36/18 = 2 mol. Number of molecules = 2 × 6.022 × 10²³ = 12.044 × 10²³',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: mole_concept — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'mole_concept — Practice',
  content: <<~MARKDOWN,
# mole_concept — Practice 🚀

n = 11/44 = 0.25 mol. At STP, V = n × 22.4 = 0.25 × 22.4 = 5.6 L

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['mole_concept'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What volume in liters will 11 g of CO₂ occupy at STP? (Molar mass CO₂ = 44 g/mol)',
    answer: '5.6',
    explanation: 'n = 11/44 = 0.25 mol. At STP, V = n × 22.4 = 0.25 × 22.4 = 5.6 L',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: percentage_composition — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'percentage_composition — Practice',
  content: <<~MARKDOWN,
# percentage_composition — Practice 🚀

Molar mass of CaCO₃ = 40 + 12 + 48 = 100 g/mol. % O = (48/100) × 100 = 48.0%

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['percentage_composition'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the percentage of oxygen in CaCO₃. Give answer rounded to 1 decimal place. (Atomic masses: Ca=40, C=12, O=16)',
    answer: '48.0',
    explanation: 'Molar mass of CaCO₃ = 40 + 12 + 48 = 100 g/mol. % O = (48/100) × 100 = 48.0%',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: empirical_formula — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'empirical_formula — Practice',
  content: <<~MARKDOWN,
# empirical_formula — Practice 🚀

C: 40/12 = 3.33, H: 6.67/1 = 6.67, O: 53.33/16 = 3.33. Ratio = 3.33:6.67:3.33 = 1:2:1. Empirical formula = CH₂O

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['empirical_formula'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'A compound contains 40% carbon, 6.67% hydrogen, and 53.33% oxygen by mass. What is its empirical formula?',
    answer: 'CH2O|CH₂O',
    explanation: 'C: 40/12 = 3.33, H: 6.67/1 = 6.67, O: 53.33/16 = 3.33. Ratio = 3.33:6.67:3.33 = 1:2:1. Empirical formula = CH₂O',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: molecular_formula — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'molecular_formula — Practice',
  content: <<~MARKDOWN,
# molecular_formula — Practice 🚀

Empirical mass = 12 + 2 + 16 = 30. n = 180/30 = 6. Molecular formula = 6 × CH₂O = C₆H₁₂O₆ (glucose)

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['molecular_formula'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The empirical formula of a compound is CH₂O and its molar mass is 180 g/mol. What is its molecular formula?',
    answer: 'C6H12O6|C₆H₁₂O₆',
    explanation: 'Empirical mass = 12 + 2 + 16 = 30. n = 180/30 = 6. Molecular formula = 6 × CH₂O = C₆H₁₂O₆ (glucose)',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: stoichiometry — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'stoichiometry — Practice',
  content: <<~MARKDOWN,
# stoichiometry — Practice 🚀

Moles of H₂ = 4/2 = 2 mol. From equation: 2 mol H₂ → 2 mol H₂O. Mass of H₂O = 2 × 18 = 36 g

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['stoichiometry'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In the reaction 2H₂ + O₂ → 2H₂O, how many grams of water are formed from 4 g of hydrogen? (H=1, O=16)',
    answer: '36',
    explanation: 'Moles of H₂ = 4/2 = 2 mol. From equation: 2 mol H₂ → 2 mol H₂O. Mass of H₂O = 2 × 18 = 36 g',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: limiting_reagent — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'limiting_reagent — Practice',
  content: <<~MARKDOWN,
# limiting_reagent — Practice 🚀

N₂/coefficient = 2/1 = 2. H₂/coefficient = 4/3 = 1.33. H₂ has smaller value, so it is the limiting reagent.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['limiting_reagent'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In the reaction N₂ + 3H₂ → 2NH₃, if 2 moles of N₂ react with 4 moles of H₂, which is the limiting reagent?',
    options: ['N₂', 'H₂', 'NH₃', 'Both are in stoichiometric ratio'],
    correct_answer: 1,
    explanation: 'N₂/coefficient = 2/1 = 2. H₂/coefficient = 4/3 = 1.33. H₂ has smaller value, so it is the limiting reagent.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 15: percentage_yield — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'percentage_yield — Practice',
  content: <<~MARKDOWN,
# percentage_yield — Practice 🚀

CaCO₃ → CaO + CO₂. Moles CaCO₃ = 100/100 = 1 mol. Theoretical CaO = 1 × 56 = 56 g. % Yield = (50/56) × 100 = 89.3%

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['percentage_yield'],
  prerequisite_ids: []
)

# Exercise 15.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'From 100 g of CaCO₃, 50 g of CaO is obtained. Calculate the percentage yield. (Ca=40, C=12, O=16)',
    answer: '89.3',
    explanation: 'CaCO₃ → CaO + CO₂. Moles CaCO₃ = 100/100 = 1 mol. Theoretical CaO = 1 × 56 = 56 g. % Yield = (50/56) × 100 = 89.3%',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 16: Atoms, Molecules & Mole Concept ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Atoms, Molecules & Mole Concept',
  content: <<~MARKDOWN,
# Atoms, Molecules & Mole Concept 🚀

# Atoms, Molecules & Mole Concept

    ## Introduction

    The **mole concept** is the foundation of quantitative chemistry. It connects the microscopic world of atoms and molecules to the macroscopic world of grams and liters.

    ## Atomic Mass Unit (amu or u)

    **Definition:** 1/12th of the mass of one carbon-12 atom

    - 1 amu = 1.66054 × 10⁻²⁴ g
    - Also called unified mass (u)

    ## Average Atomic Mass

    For elements with isotopes, atomic mass is the weighted average:

    **Average atomic mass = Σ (isotope mass × abundance)**

    ### Example: Chlorine
    - Cl-35: mass = 35 u, abundance = 75%
    - Cl-37: mass = 37 u, abundance = 25%
    - Average atomic mass = (35 × 0.75) + (37 × 0.25) = 35.5 u

    ## Molecular Mass

    **Molecular mass** = Sum of atomic masses of all atoms in a molecule

    ### Examples:
    - H₂O: (2 × 1) + (1 × 16) = 18 u
    - H₂SO₄: (2 × 1) + (1 × 32) + (4 × 16) = 98 u
    - C₆H₁₂O₆: (6 × 12) + (12 × 1) + (6 × 16) = 180 u

    ## Formula Mass

    For ionic compounds (which don't form molecules), we use **formula mass**:

    - NaCl: 23 + 35.5 = 58.5 u
    - CaCO₃: 40 + 12 + (3 × 16) = 100 u

    ## The Mole Concept

    ### Definition of Mole

    **One mole** is the amount of substance that contains as many elementary entities as there are atoms in exactly 12 g of carbon-12.

    **1 mole = 6.022 × 10²³ entities** (Avogadro's Number, Nₐ)

    ### Avogadro's Number

    Nₐ = 6.022 × 10²³ mol⁻¹

    This is one of the most important constants in chemistry.

    ## Molar Mass

    **Molar mass (M)** = Mass of 1 mole of substance (in grams)

    - Numerically equal to atomic/molecular mass
    - Units: g/mol or g mol⁻¹

    ### Examples:
    - H₂O: Molar mass = 18 g/mol
    - NaCl: Molar mass = 58.5 g/mol
    - H₂SO₄: Molar mass = 98 g/mol

    ## Important Relationships

    ### Number of Moles

    **n = w/M**

    Where:
    - n = number of moles
    - w = mass in grams
    - M = molar mass in g/mol

    ### Number of Particles

    **N = n × Nₐ = (w/M) × Nₐ**

    Where:
    - N = number of particles (atoms/molecules)
    - Nₐ = Avogadro's number

    ### Mass from Moles

    **w = n × M**

    ## Molar Volume of Gases

    At STP (Standard Temperature and Pressure):
    - Temperature: 273 K (0°C)
    - Pressure: 1 atm (101.325 kPa)

    **1 mole of any gas occupies 22.4 L at STP**

    This is called **molar volume** (Vₘ)

    For gases: **n = V/22.4** (at STP)

    ## Solved Problems

    ### Problem 1: Calculate moles from mass

    **Q: How many moles are present in 49 g of H₂SO₄?**

    Solution:
    - Molar mass of H₂SO₄ = 98 g/mol
    - n = w/M = 49/98 = 0.5 mol

    **Answer: 0.5 mol**

    ### Problem 2: Calculate number of molecules

    **Q: How many molecules are present in 9 g of water?**

    Solution:
    - Molar mass of H₂O = 18 g/mol
    - n = 9/18 = 0.5 mol
    - N = n × Nₐ = 0.5 × 6.022 × 10²³
    - N = 3.011 × 10²³ molecules

    **Answer: 3.011 × 10²³ molecules**

    ### Problem 3: Calculate number of atoms

    **Q: How many hydrogen atoms are present in 9 g of water?**

    Solution:
    - Number of H₂O molecules = 3.011 × 10²³
    - Each H₂O has 2 H atoms
    - Total H atoms = 2 × 3.011 × 10²³ = 6.022 × 10²³

    **Answer: 6.022 × 10²³ atoms**

    ### Problem 4: Gas volume at STP

    **Q: What volume will 8 g of O₂ occupy at STP?**

    Solution:
    - Molar mass of O₂ = 32 g/mol
    - n = 8/32 = 0.25 mol
    - V = n × 22.4 = 0.25 × 22.4 = 5.6 L

    **Answer: 5.6 L**

    ### Problem 5: IIT JEE Level

    **Q: Calculate the number of electrons in 1.8 g of NH₄⁺ ion.**

    Solution:
    - Molar mass of NH₄⁺ = 14 + 4(1) = 18 g/mol
    - n = 1.8/18 = 0.1 mol
    - Electrons in NH₄⁺: N has 7, 4H have 4, minus 1 for charge = 10 electrons
    - Total electrons = 0.1 × 10 × 6.022 × 10²³
    - = 6.022 × 10²³ electrons

    **Answer: 6.022 × 10²³ electrons**

    ## Key Formulas Summary

    | Quantity | Formula | Units |
    |----------|---------|-------|
    | Number of moles | n = w/M | mol |
    | Number of particles | N = n × Nₐ | - |
    | Mass | w = n × M | g |
    | Volume (gas at STP) | V = n × 22.4 | L |
    | Molar mass | M = w/n | g/mol |

    ## IIT JEE Tips

    1. **Always check units** - convert to standard units (g, mol, L)
    2. For **ions**, adjust electron count based on charge
    3. For **molecules**, multiply by number of atoms per molecule
    4. **At STP**: 1 mole = 22.4 L (for any gas)
    5. Remember: **Avogadro's number applies to all entities** (atoms, molecules, ions, electrons)
    6. **Molar mass in grams** = molecular mass in amu (numerically)

    ## Practice Tips

    - Master unit conversions early
    - Practice identifying the type of entity (atom/molecule/ion)
    - Draw a concept map: mass ↔ moles ↔ particles ↔ volume
    - For complex problems, always start with finding moles first

## Key Points

- Atomic mass

- Molecular mass

- Mole concept
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Atomic mass', 'Molecular mass', 'Mole concept', 'Avogadro number', 'Molar mass'],
  prerequisite_ids: []
)

puts "✓ Created 16 microlessons for Mole Concept Stoichiometry"

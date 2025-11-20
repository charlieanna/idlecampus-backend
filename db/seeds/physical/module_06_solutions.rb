# frozen_string_literal: true

# ========================================
# IIT JEE Physical Chemistry - Module 6
# Solutions and Colligative Properties
# ========================================
# Complete module with lessons and questions
# Solution concentration, Raoult's law, colligative properties
# ========================================

puts "\n" + "=" * 80
puts "MODULE 6: SOLUTIONS AND COLLIGATIVE PROPERTIES"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-physical-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Physical Chemistry course not found!"
  exit 1
end

# Create Module 6: Solutions
module_6 = course.course_modules.find_or_create_by!(slug: 'solutions-colligative-properties') do |m|
  m.title = 'Solutions and Colligative Properties'
  m.sequence_order = 6
  m.estimated_minutes = 400
  m.description = 'Solution concentration, Raoult\'s law, ideal/non-ideal solutions, colligative properties, and abnormal molar mass'
  m.learning_objectives = [
    'Master different ways of expressing concentration',
    'Understand Raoult\'s law and vapor pressure',
    'Differentiate ideal and non-ideal solutions',
    'Master colligative properties (osmotic pressure, BP elevation, FP depression)',
    'Calculate van\'t Hoff factor and abnormal molar mass',
    'Solve IIT JEE numerical problems on solutions'
  ]
  m.published = true
end

puts "✅ Module 6: #{module_6.title}"

# ========================================
# Lesson 6.1: Solutions & Concentration Terms
# ========================================

lesson_6_1 = CourseLesson.create!(
  title: 'Solutions & Concentration Terms',
  reading_time_minutes: 40,
  key_concepts: ['Solution types', 'Molarity', 'Molality', 'Mole fraction', 'Concentration conversions'],
  content: <<~MD
    # Solutions & Concentration Terms

    ## Solutions

    **Solution** = Homogeneous mixture of two or more substances

    ### Components:
    - **Solute:** Substance present in smaller amount (gets dissolved)
    - **Solvent:** Substance present in larger amount (does the dissolving)

    ### Types Based on Physical State:

    | Solute | Solvent | Example |
    |--------|---------|---------|
    | Gas | Gas | Air (O₂ in N₂) |
    | Gas | Liquid | Soda (CO₂ in H₂O) |
    | Liquid | Liquid | Alcohol in water |
    | Solid | Liquid | Salt in water |
    | Solid | Solid | Alloys (brass) |

    ### Types Based on Solute Amount:

    1. **Dilute solution:** Small amount of solute
    2. **Concentrated solution:** Large amount of solute
    3. **Saturated solution:** Maximum solute dissolved at given T
    4. **Unsaturated solution:** Can dissolve more solute
    5. **Supersaturated solution:** Contains more solute than saturation (unstable)

    ## Concentration Terms

    ### 1. Molarity (M)

    **Definition:** Number of moles of solute per liter of solution

    **M = n/V = w/(M × V)**

    Where:
    - n = moles of solute
    - w = mass of solute (g)
    - M = molar mass (g/mol)
    - V = volume of solution (L)

    **Units:** mol/L or M

    **Temperature dependent** (volume changes with temperature)

    ### Example:
    49 g H₂SO₄ dissolved in water to make 500 mL solution. Find molarity.

    - Molar mass H₂SO₄ = 98 g/mol
    - n = 49/98 = 0.5 mol
    - V = 0.5 L
    - M = 0.5/0.5 = **1 M**

    ### 2. Molality (m)

    **Definition:** Number of moles of solute per kilogram of solvent

    **m = n/W = w/(M × W)**

    Where:
    - n = moles of solute
    - w = mass of solute (g)
    - M = molar mass (g/mol)
    - W = mass of solvent (kg)

    **Units:** mol/kg or m

    **Temperature independent** (mass doesn't change)

    ### Example:
    5.85 g NaCl dissolved in 100 g water. Find molality.

    - Molar mass NaCl = 58.5 g/mol
    - n = 5.85/58.5 = 0.1 mol
    - W = 0.1 kg
    - m = 0.1/0.1 = **1 m**

    ### 3. Mole Fraction (X or χ)

    **Definition:** Ratio of moles of one component to total moles

    **Xₐ = nₐ/(nₐ + nᵦ)**

    Where:
    - nₐ = moles of component A
    - nᵦ = moles of component B

    **Properties:**
    - Xₐ + Xᵦ = 1 (for binary solution)
    - Dimensionless (no units)
    - Temperature independent

    ### Example:
    Solution contains 1 mol ethanol and 4 mol water. Find mole fractions.

    - Total moles = 1 + 4 = 5
    - X_ethanol = 1/5 = **0.2**
    - X_water = 4/5 = **0.8**

    ### 4. Mass Percentage (% w/w)

    **% w/w = (Mass of solute / Mass of solution) × 100**

    ### Example:
    10 g sugar dissolved in 90 g water.

    - Total mass = 100 g
    - % w/w = (10/100) × 100 = **10%**

    ### 5. Volume Percentage (% v/v)

    **% v/v = (Volume of solute / Volume of solution) × 100**

    Used for liquid-liquid solutions

    ### 6. Mass by Volume (% w/v)

    **% w/v = (Mass of solute in g / Volume of solution in mL) × 100**

    ### 7. Parts Per Million (ppm)

    **ppm = (Mass of solute / Mass of solution) × 10⁶**

    Used for very dilute solutions

    ### 8. Normality (N)

    **N = Number of gram equivalents / Volume (L)**

    **Gram equivalent = Mass / Equivalent weight**

    **For acids:** Eq. wt. = Molar mass / Basicity
    **For bases:** Eq. wt. = Molar mass / Acidity

    ## Relationships Between Concentration Terms

    ### Molarity to Molality:

    **m = (1000 × M) / (1000d - M × M₂)**

    Where:
    - d = density of solution (g/mL)
    - M = molarity
    - M₂ = molar mass of solute

    ### Molality to Mole Fraction:

    **Xsolute = (m × Msolvent) / (1000 + m × Msolvent)**

    **Xsolvent = 1000 / (1000 + m × Msolute)**

    ### Mole Fraction to Molality:

    **m = (1000 × X₂) / (M₁ × X₁)**

    Where:
    - X₂ = mole fraction of solute
    - X₁ = mole fraction of solvent
    - M₁ = molar mass of solvent

    ## Solubility

    **Solubility:** Maximum amount of solute that dissolves in given amount of solvent at specific temperature

    ### Factors Affecting Solubility:

    **1. Nature of solute and solvent:**
    - "Like dissolves like"
    - Polar solutes dissolve in polar solvents
    - Non-polar solutes dissolve in non-polar solvents

    **2. Temperature:**
    - For most solids: Solubility ↑ with temperature ↑
    - For gases: Solubility ↓ with temperature ↑

    **3. Pressure (for gases):**
    - Henry's Law: **P = KH × X**
    - Higher pressure → higher solubility

    ## Henry's Law

    **Statement:** At constant temperature, solubility of gas is directly proportional to partial pressure

    **P = KH × X**

    Or: **X = P/KH**

    Where:
    - P = partial pressure of gas
    - KH = Henry's law constant
    - X = mole fraction of gas in solution

    **Higher KH** → Lower solubility (less favorable dissolution)

    ### Applications:
    1. Carbonated beverages (CO₂ under pressure)
    2. Scuba diving (N₂ dissolution in blood)
    3. Oxygen cylinders for mountaineers

    ## Solved Problems

    ### Problem 1: Molarity calculation

    **Q: Calculate molarity of solution containing 20 g NaOH in 250 mL solution.**

    Solution:
    - Molar mass NaOH = 40 g/mol
    - n = 20/40 = 0.5 mol
    - V = 0.25 L
    - M = 0.5/0.25 = **2 M**

    ### Problem 2: Molality calculation

    **Q: 18 g glucose (C₆H₁₂O₆) dissolved in 100 g water. Find molality.**

    Solution:
    - Molar mass glucose = 180 g/mol
    - n = 18/180 = 0.1 mol
    - W = 0.1 kg
    - m = 0.1/0.1 = **1 m**

    ### Problem 3: Mole fraction

    **Q: Calculate mole fraction of ethanol in solution with 2 mol ethanol and 3 mol water.**

    Solution:
    - Total moles = 5
    - X_ethanol = 2/5 = **0.4**
    - X_water = 3/5 = **0.6**

    ### Problem 4: Conversion

    **Q: A 2 M NaCl solution has density 1.08 g/mL. Find molality.**

    Solution:
    - Consider 1 L solution (1000 mL)
    - Mass of solution = 1000 × 1.08 = 1080 g
    - Moles NaCl = 2 mol
    - Mass of NaCl = 2 × 58.5 = 117 g
    - Mass of water = 1080 - 117 = 963 g = 0.963 kg
    - m = 2/0.963 = **2.08 m**

    ### Problem 5: Henry's Law

    **Q: KH for O₂ is 34.86 kbar. Calculate solubility of O₂ at 1 atm.**

    Solution:
    - P = 1 atm = 0.00101 kbar
    - X = P/KH = 0.00101/34.86
    - X = **2.9 × 10⁻⁵**

    ## IIT JEE Key Points

    1. **Molarity (M):** mol/L, temperature dependent
    2. **Molality (m):** mol/kg, temperature independent
    3. **Mole fraction (X):** dimensionless, 0 to 1
    4. **Colligative properties** depend on molality or mole fraction
    5. **Henry's Law:** P = KH × X (gas solubility)
    6. For dilute solutions: **Molarity ≈ Molality**
    7. Xₐ + Xᵦ = 1 (binary solution)
    8. Temperature ↑ → gas solubility ↓
    9. Pressure ↑ → gas solubility ↑
    10. Use **molality** for colligative properties

    ## Quick Formulas

    | Term | Formula | Units |
    |------|---------|-------|
    | Molarity | n/V | mol/L |
    | Molality | n/W | mol/kg |
    | Mole fraction | nᵢ/ntotal | - |
    | % w/w | (wsolute/wsolution)×100 | % |
    | ppm | (wsolute/wsolution)×10⁶ | ppm |
    | Henry's Law | P = KH × X | varies |
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 6.1: #{lesson_6_1.title}"

# ========================================
# Lesson 6.2: Raoult's Law & Vapor Pressure
# ========================================

lesson_6_2 = CourseLesson.create!(
  title: 'Raoult\'s Law & Ideal/Non-Ideal Solutions',
  reading_time_minutes: 45,
  key_concepts: ['Raoults law', 'Vapor pressure', 'Ideal solutions', 'Non-ideal solutions', 'Azeotropes'],
  content: <<~MD
    # Raoult's Law & Ideal/Non-Ideal Solutions

    ## Vapor Pressure of Solutions

    **Vapor pressure** = Pressure exerted by vapor in equilibrium with liquid

    When non-volatile solute is added:
    - Vapor pressure **decreases**
    - Fewer solvent molecules can escape to vapor phase

    ## Raoult's Law

    **For solution containing non-volatile solute:**

    **P = P° × X_solvent**

    Where:
    - P = vapor pressure of solution
    - P° = vapor pressure of pure solvent
    - X_solvent = mole fraction of solvent

    ### Alternate Form:

    **P° - P = P° × X_solute**

    **ΔP = P° × X_solute** (lowering of vapor pressure)

    ### Relative Lowering:

    **(P° - P)/P° = X_solute**

    This is **independent of temperature**

    ### For Binary Solution of Volatile Components:

    **P_total = P°ₐ × Xₐ + P°ᵦ × Xᵦ**

    Where both components contribute to vapor pressure

    ## Ideal Solutions

    **Definition:** Solutions that obey Raoult's law at all concentrations and temperatures

    ### Characteristics:

    1. **ΔH_mixing = 0** (no heat change on mixing)
    2. **ΔV_mixing = 0** (no volume change on mixing)
    3. **A-A, B-B, and A-B interactions are similar**
    4. **Obey Raoult's law:** P = P° × X

    ### Examples:
    - Benzene + Toluene
    - n-Hexane + n-Heptane
    - Chlorobenzene + Bromobenzene
    - Ethyl bromide + Ethyl iodide

    **Condition:** Components must be chemically similar

    ## Non-Ideal Solutions

    **Definition:** Solutions that deviate from Raoult's law

    ### Types:

    ### 1. Positive Deviation (P > P_ideal)

    **Characteristics:**
    - A-B interactions **weaker** than A-A and B-B
    - Molecules escape **more easily**
    - **P_observed > P_Raoult**
    - **ΔH_mixing > 0** (endothermic)
    - **ΔV_mixing > 0** (volume increases)

    **Examples:**
    - Ethanol + Water
    - Ethanol + Cyclohexane
    - Acetone + CS₂
    - CHCl₃ + CCl₄

    ### 2. Negative Deviation (P < P_ideal)

    **Characteristics:**
    - A-B interactions **stronger** than A-A and B-B
    - Molecules escape **less easily**
    - **P_observed < P_Raoult**
    - **ΔH_mixing < 0** (exothermic)
    - **ΔV_mixing < 0** (volume decreases)

    **Examples:**
    - CHCl₃ + Acetone (H-bonding)
    - HCl + Water
    - HNO₃ + Water
    - Acetic acid + Pyridine

    ## Azeotropes

    **Definition:** Constant boiling mixtures that cannot be separated by simple distillation

    ### Types:

    ### 1. Minimum Boiling Azeotrope

    - Shows **positive deviation**
    - Boils at **lower temperature** than components
    - Examples:
      - Ethanol (95.5%) + Water (4.5%), BP = 78.2°C
      - HCl (20.2%) + Water (79.8%), BP = 108.6°C

    ### 2. Maximum Boiling Azeotrope

    - Shows **negative deviation**
    - Boils at **higher temperature** than components
    - Examples:
      - HNO₃ (68%) + Water (32%), BP = 121.9°C
      - HCl (20.2%) + Water (79.8%)

    ## Solved Problems

    ### Problem 1: Raoult's Law

    **Q: Calculate vapor pressure of solution containing 2 mol glucose in 18 mol water at 25°C. (P°_water = 24 mm Hg)**

    Solution:
    - Total moles = 2 + 18 = 20
    - X_water = 18/20 = 0.9
    - P = P° × X_water
    - P = 24 × 0.9 = **21.6 mm Hg**

    ### Problem 2: Relative Lowering

    **Q: Relative lowering of vapor pressure for solution is 0.1. If solution contains 18 g water, find mass of solute (M = 60 g/mol).**

    Solution:
    - (P° - P)/P° = X_solute = 0.1
    - X_solute = n_solute/(n_solute + n_solvent)
    - n_water = 18/18 = 1 mol
    - 0.1 = n_s/(n_s + 1)
    - 0.1(n_s + 1) = n_s
    - 0.1 + 0.1n_s = n_s
    - 0.9n_s = 0.1
    - n_s = 0.111 mol
    - Mass = 0.111 × 60 = **6.67 g**

    ### Problem 3: Binary Volatile Solution

    **Q: P°_A = 100 mm Hg, P°_B = 200 mm Hg. In solution, Xₐ = 0.4, Xᵦ = 0.6. Find total vapor pressure.**

    Solution:
    - P_total = P°ₐ × Xₐ + P°ᵦ × Xᵦ
    - P_total = 100(0.4) + 200(0.6)
    - P_total = 40 + 120 = **160 mm Hg**

    ### Problem 4: IIT JEE Level

    **Q: At 300 K, vapor pressure of pure A is 400 mm and pure B is 200 mm. If mixture has mole fraction of A = 0.5, find:**
    **(a) Total vapor pressure**
    **(b) Mole fraction of A in vapor phase**

    Solution:

    **(a) Total pressure:**
    - P_total = 400(0.5) + 200(0.5) = 200 + 100 = **300 mm Hg**

    **(b) Partial pressure of A in vapor:**
    - Pₐ = 400 × 0.5 = 200 mm Hg
    - Mole fraction in vapor: Yₐ = Pₐ/P_total
    - Yₐ = 200/300 = **0.667 or 2/3**

    ## Composition of Vapor vs Liquid

    For volatile binary solution:

    **Yₐ/Yᵦ = (P°ₐ/P°ᵦ) × (Xₐ/Xᵦ)**

    Where:
    - Y = mole fraction in vapor
    - X = mole fraction in liquid

    **More volatile component is enriched in vapor phase**

    ## Vapor Pressure Diagrams

    ### For Ideal Solutions:
    - Linear relationship between P and X
    - P_total varies linearly with composition

    ### For Non-Ideal Solutions:
    - **Positive deviation:** Curve above ideal line
    - **Negative deviation:** Curve below ideal line
    - **Azeotrope:** Maximum or minimum in curve

    ## Colligative Properties Introduction

    **Colligative properties** depend only on **number of solute particles**, not their nature

    Four main colligative properties:
    1. Relative lowering of vapor pressure
    2. Elevation of boiling point
    3. Depression of freezing point
    4. Osmotic pressure

    ### Why Called Colligative?

    From Latin "colligatus" meaning "bound together"
    - Properties depend on **collective effect** of particles
    - Don't depend on **identity** of solute

    ### Requirements:
    - Solute must be **non-volatile**
    - Solution should be **dilute**
    - Solute should **not dissociate** (for non-electrolytes)

    ## IIT JEE Key Points

    1. **Raoult's Law:** P = P° × X_solvent
    2. **Relative lowering:** (P° - P)/P° = X_solute
    3. **Ideal solution:** ΔH = 0, ΔV = 0, obeys Raoult's law
    4. **Positive deviation:** A-B weaker, P ↑, ΔH > 0
    5. **Negative deviation:** A-B stronger, P ↓, ΔH < 0
    6. **Azeotropes:** Constant boiling mixtures
    7. **Min. boiling:** Positive deviation (ethanol + water)
    8. **Max. boiling:** Negative deviation (HNO₃ + water)
    9. Vapor is **enriched** in more volatile component
    10. **Colligative properties** depend on particle count

    ## Quick Reference

    | Solution Type | Deviation | ΔH | ΔV | P |
    |---------------|-----------|----|----|---|
    | Ideal | None | 0 | 0 | P=P°X |
    | Positive | +ve | >0 | >0 | P>P_ideal |
    | Negative | -ve | <0 | <0 | P<P_ideal |

    ## Important Examples

    | Type | Examples |
    |------|----------|
    | Ideal | Benzene+Toluene, n-Hexane+n-Heptane |
    | Positive | Ethanol+Water, Acetone+CS₂ |
    | Negative | CHCl₃+Acetone, HNO₃+Water |
    | Min. boiling azeotrope | Ethanol+Water (95.5:4.5) |
    | Max. boiling azeotrope | HNO₃+Water (68:32) |
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_2, sequence_order: 2, required: true)

puts "  ✓ Lesson 6.2: #{lesson_6_2.title}"

# ========================================
# Lesson 6.3: Colligative Properties
# ========================================

lesson_6_3 = CourseLesson.create!(
  title: 'Colligative Properties & Abnormal Molar Mass',
  reading_time_minutes: 50,
  key_concepts: ['Osmotic pressure', 'BP elevation', 'FP depression', 'van\'t Hoff factor', 'Abnormal molar mass'],
  content: <<~MD
    # Colligative Properties & Abnormal Molar Mass

    ## 1. Osmotic Pressure (π)

    **Osmosis:** Flow of solvent from lower concentration to higher concentration through semipermeable membrane

    **Osmotic Pressure:** Pressure required to stop osmosis

    ### van't Hoff Equation:

    **π = CRT = (n/V)RT**

    Where:
    - π = osmotic pressure
    - C = molar concentration (mol/L)
    - R = gas constant = 0.0821 L·atm·mol⁻¹·K⁻¹
    - T = absolute temperature (K)

    ### Alternate Forms:

    **π = (w/M)(RT/V)** (using mass)

    **M = (wRT)/(πV)** (to calculate molar mass)

    ### Types:

    1. **Isotonic solutions:** Same osmotic pressure
    2. **Hypertonic:** Higher osmotic pressure
    3. **Hypotonic:** Lower osmotic pressure

    ### Applications:
    - Desalination (reverse osmosis)
    - Preservation of food (salt/sugar)
    - IV fluids (isotonic with blood)
    - Determination of molar mass

    ### Example:

    **Q: Calculate osmotic pressure of 0.1 M glucose solution at 27°C.**

    Solution:
    - C = 0.1 M
    - T = 300 K
    - π = CRT = 0.1 × 0.0821 × 300
    - π = **2.463 atm**

    ## 2. Elevation of Boiling Point (ΔTᵦ)

    When non-volatile solute is added, boiling point **increases**

    **ΔTᵦ = Tᵦ - T°ᵦ = Kᵦ × m**

    Where:
    - ΔTᵦ = elevation in boiling point
    - Kᵦ = ebullioscopic constant (molal boiling point elevation constant)
    - m = molality of solution

    ### Ebullioscopic Constants (Kᵦ):

    | Solvent | Kᵦ (K·kg·mol⁻¹) | BP (°C) |
    |---------|-----------------|---------|
    | Water | 0.52 | 100 |
    | Benzene | 2.53 | 80.1 |
    | CCl₄ | 5.03 | 76.8 |
    | CHCl₃ | 3.63 | 61.2 |
    | Ethanol | 1.22 | 78.4 |

    ### To Calculate Molar Mass:

    **M = (Kᵦ × w × 1000)/(ΔTᵦ × W)**

    Where:
    - w = mass of solute (g)
    - W = mass of solvent (g)

    ### Example:

    **Q: 1.8 g glucose dissolved in 100 g water. Calculate elevation in BP. (Kᵦ = 0.52)**

    Solution:
    - Molar mass glucose = 180 g/mol
    - m = (1.8/180)/0.1 = 0.1 mol/kg
    - ΔTᵦ = 0.52 × 0.1 = **0.052 K or °C**
    - New BP = 100 + 0.052 = 100.052°C

    ## 3. Depression of Freezing Point (ΔTf)

    When non-volatile solute is added, freezing point **decreases**

    **ΔTf = T°f - Tf = Kf × m**

    Where:
    - ΔTf = depression in freezing point
    - Kf = cryoscopic constant (molal freezing point depression constant)
    - m = molality

    ### Cryoscopic Constants (Kf):

    | Solvent | Kf (K·kg·mol⁻¹) | FP (°C) |
    |---------|-----------------|---------|
    | Water | 1.86 | 0 |
    | Benzene | 5.12 | 5.5 |
    | CCl₄ | 30 | -23 |
    | CHCl₃ | 4.68 | -63.5 |
    | Acetic acid | 3.90 | 16.6 |

    ### To Calculate Molar Mass:

    **M = (Kf × w × 1000)/(ΔTf × W)**

    ### Example:

    **Q: 0.5 molal aqueous solution. Calculate freezing point. (Kf = 1.86)**

    Solution:
    - ΔTf = Kf × m = 1.86 × 0.5 = 0.93 K
    - Tf = 0 - 0.93 = **-0.93°C**

    ### Applications:
    - Antifreeze in car radiators (ethylene glycol)
    - De-icing of roads (salt)
    - Making ice cream (salt + ice lowers temperature)

    ## Comparison of Colligative Properties

    | Property | Formula | Constant |
    |----------|---------|----------|
    | Vapor pressure lowering | ΔP/P° = X₂ | - |
    | Osmotic pressure | π = CRT | R |
    | BP elevation | ΔTᵦ = Kᵦm | Kᵦ |
    | FP depression | ΔTf = Kfm | Kf |

    **Most accurate for molar mass:** Osmotic pressure (large effect, measured precisely)

    ## van't Hoff Factor (i)

    **Definition:** Ratio of actual number of particles to formula units dissolved

    **i = (Observed colligative property) / (Calculated colligative property)**

    Or:

    **i = (Total particles after dissociation/association) / (Particles before)**

    ### Modified Equations:

    - **π = iCRT**
    - **ΔTᵦ = iKᵦm**
    - **ΔTf = iKfm**
    - **(P° - P)/P° = iX₂**

    ### Values of i:

    **1. For non-electrolytes (no dissociation):**
    - Glucose, urea, sucrose: **i = 1**

    **2. For electrolytes (dissociation):**
    - NaCl → Na⁺ + Cl⁻: **i ≈ 2**
    - CaCl₂ → Ca²⁺ + 2Cl⁻: **i ≈ 3**
    - K₂SO₄ → 2K⁺ + SO₄²⁻: **i ≈ 3**
    - Al₂(SO₄)₃ → 2Al³⁺ + 3SO₄²⁻: **i ≈ 5**

    **3. For association:**
    - Acetic acid in benzene (dimerization): **i < 1**
    - 2CH₃COOH ⇌ (CH₃COOH)₂: **i = 0.5** (complete association)

    ### Relationship with Degree of Dissociation (α):

    **i = 1 + (n - 1)α**

    Where:
    - n = number of particles after complete dissociation
    - α = degree of dissociation (0 to 1)

    **For association:**

    **i = 1 + (1/n - 1)α**

    Where n = number of particles associating

    ## Abnormal Molar Mass

    When solute dissociates or associates:
    - **Dissociation:** Observed M < Normal M, i > 1
    - **Association:** Observed M > Normal M, i < 1

    **M_normal = i × M_observed**

    ### Example: Dissociation

    **Q: NaCl gives ΔTf = 3.72 K when 0.1 mol dissolved in 1 kg water. Calculate i. (Kf = 1.86)**

    Solution:
    - For non-electrolyte: ΔTf = 1.86 × 0.1 = 0.186 K
    - Observed: ΔTf = 3.72 K
    - i = 3.72/0.186 = **2.0** (complete dissociation)
    - NaCl → Na⁺ + Cl⁻ (2 particles)

    ### Example: Association

    **Q: Benzoic acid in benzene shows i = 0.52. Calculate % association if dimerization occurs.**

    Solution:
    - 2C₆H₅COOH ⇌ (C₆H₅COOH)₂
    - n = 2 (2 molecules associate)
    - i = 1 + (1/n - 1)α
    - 0.52 = 1 + (0.5 - 1)α
    - 0.52 = 1 - 0.5α
    - 0.5α = 0.48
    - α = **0.96 or 96%**

    ## Isotonic Solutions

    **Definition:** Solutions having same osmotic pressure

    **π₁ = π₂**

    **C₁RT = C₂RT**

    **C₁ = C₂** (at same temperature)

    ### Example:

    **Q: 0.1 M NaCl solution (i=2) is isotonic with which glucose solution?**

    Solution:
    - For NaCl: C_effective = i × C = 2 × 0.1 = 0.2 M
    - For glucose: i = 1
    - Glucose concentration = **0.2 M**

    ## IIT JEE Key Points

    1. **Osmotic pressure:** π = CRT (most sensitive)
    2. **BP elevation:** ΔTᵦ = Kᵦm
    3. **FP depression:** ΔTf = Kfm
    4. **van't Hoff factor:** i = observed/calculated
    5. **Non-electrolyte:** i = 1
    6. **Dissociation:** i > 1
    7. **Association:** i < 1
    8. **i = 1 + (n-1)α** for dissociation
    9. **Isotonic:** π₁ = π₂
    10. **For molar mass:** Use ΔTf or π

    ## Solved IIT JEE Problem

    **Q: A solution of 0.5 g KCl in 100 g water freezes at -0.24°C. Calculate van't Hoff factor. (Kf = 1.86, M_KCl = 74.5)**

    Solution:
    1. Calculate theoretical ΔTf (if i = 1):
       - m = (0.5/74.5)/0.1 = 0.0671 mol/kg
       - ΔTf(theoretical) = 1.86 × 0.0671 = 0.125 K

    2. Observed ΔTf = 0.24 K

    3. i = observed/theoretical = 0.24/0.125 = **1.92**

    This shows KCl dissociates almost completely (expected i = 2)

    ## Quick Formulas

    | Property | Formula | Molar Mass |
    |----------|---------|------------|
    | Osmotic pressure | π = CRT | M = wRT/(πV) |
    | BP elevation | ΔTᵦ = Kᵦm | M = Kᵦw1000/(ΔTᵦW) |
    | FP depression | ΔTf = Kfm | M = Kfw1000/(ΔTfW) |
    | van't Hoff | i = obs/calc | i = 1+(n-1)α |
  MD
)

ModuleItem.create!(course_module: module_6, item: lesson_6_3, sequence_order: 3, required: true)

puts "  ✓ Lesson 6.3: #{lesson_6_3.title}"

# ========================================
# Quiz 6: Solutions and Colligative Properties
# ========================================

quiz_6 = Quiz.create!(
  title: 'Solutions and Colligative Properties Mastery',
  description: 'Comprehensive test on solution concentration, Raoult\'s law, and colligative properties',
  time_limit_minutes: 50,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_6, item: quiz_6, sequence_order: 4, required: true)

# Questions for Quiz 6 (12 questions)
QuizQuestion.create!([
  # Question 1: Molarity
  {
    quiz: quiz_6,
    question_type: 'numerical',
    question_text: 'Calculate the molarity of a solution containing 10 g NaOH (M=40 g/mol) in 500 mL solution.',
    correct_answer: '0.5',
    tolerance: 0.01,
    explanation: 'n = 10/40 = 0.25 mol. V = 0.5 L. M = n/V = 0.25/0.5 = 0.5 M',
    points: 2,
    difficulty: -0.1,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'concentration',
    skill_dimension: 'application',
    sequence_order: 1
  },

  # Question 2: Molality
  {
    quiz: quiz_6,
    question_type: 'numerical',
    question_text: 'Calculate molality of solution with 5.85 g NaCl (M=58.5 g/mol) in 200 g water.',
    correct_answer: '0.5',
    tolerance: 0.01,
    explanation: 'n = 5.85/58.5 = 0.1 mol. W = 0.2 kg. m = n/W = 0.1/0.2 = 0.5 m',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'concentration',
    skill_dimension: 'application',
    sequence_order: 2
  },

  # Question 3: Mole fraction
  {
    quiz: quiz_6,
    question_type: 'numerical',
    question_text: 'A solution contains 1 mol ethanol and 4 mol water. What is the mole fraction of ethanol?',
    correct_answer: '0.2',
    tolerance: 0.01,
    explanation: 'Total moles = 5. X_ethanol = 1/5 = 0.2',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'mole_fraction',
    skill_dimension: 'application',
    sequence_order: 3
  },

  # Question 4: Raoult's law
  {
    quiz: quiz_6,
    question_type: 'numerical',
    question_text: 'Calculate vapor pressure of solution with 1 mol glucose in 9 mol water. (P°_water = 30 mm Hg)',
    correct_answer: '27',
    tolerance: 0.5,
    explanation: 'Total moles = 10. X_water = 9/10 = 0.9. P = P° × X = 30 × 0.9 = 27 mm Hg',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'raoults_law',
    skill_dimension: 'problem_solving',
    sequence_order: 4
  },

  # Question 5: Ideal solutions
  {
    quiz: quiz_6,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which are characteristics of ideal solutions?',
    options: [
      { text: 'ΔH_mixing = 0', correct: true },
      { text: 'ΔV_mixing = 0', correct: true },
      { text: 'Obey Raoult\'s law', correct: true },
      { text: 'Show positive deviation', correct: false }
    ],
    explanation: 'Ideal solutions have ΔH = 0, ΔV = 0, and obey Raoult\'s law perfectly. They show no deviation.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'ideal_solutions',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 5
  },

  # Question 6: Deviation type
  {
    quiz: quiz_6,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Ethanol + Water solution shows:',
    options: [
      { text: 'Ideal behavior', correct: false },
      { text: 'Positive deviation', correct: true },
      { text: 'Negative deviation', correct: false },
      { text: 'No deviation', correct: false }
    ],
    explanation: 'Ethanol + Water shows positive deviation (A-B interactions weaker than A-A and B-B) forming minimum boiling azeotrope.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'non_ideal_solutions',
    skill_dimension: 'recall',
    sequence_order: 6
  },

  # Question 7: Osmotic pressure
  {
    quiz: quiz_6,
    question_type: 'numerical',
    question_text: 'Calculate osmotic pressure of 0.2 M glucose solution at 27°C. (R = 0.0821 L·atm·mol⁻¹·K⁻¹)',
    correct_answer: '4.926',
    tolerance: 0.1,
    explanation: 'π = CRT = 0.2 × 0.0821 × 300 = 4.926 atm',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'osmotic_pressure',
    skill_dimension: 'problem_solving',
    sequence_order: 7
  },

  # Question 8: BP elevation
  {
    quiz: quiz_6,
    question_type: 'numerical',
    question_text: 'Calculate elevation in BP when 18 g glucose (M=180) dissolved in 100 g water. (Kb = 0.52)',
    correct_answer: '0.052',
    tolerance: 0.005,
    explanation: 'm = (18/180)/0.1 = 0.1 mol/kg. ΔTb = Kb × m = 0.52 × 0.1 = 0.052 K',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'bp_elevation',
    skill_dimension: 'problem_solving',
    sequence_order: 8
  },

  # Question 9: FP depression
  {
    quiz: quiz_6,
    question_type: 'numerical',
    question_text: 'Calculate freezing point of 0.5 molal aqueous solution. (Kf = 1.86 for water)',
    correct_answer: '-0.93',
    tolerance: 0.05,
    explanation: 'ΔTf = Kf × m = 1.86 × 0.5 = 0.93 K. Tf = 0 - 0.93 = -0.93°C',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'fp_depression',
    skill_dimension: 'problem_solving',
    sequence_order: 9
  },

  # Question 10: van't Hoff factor
  {
    quiz: quiz_6,
    question_type: 'numerical',
    question_text: 'What is the theoretical van\'t Hoff factor (i) for complete dissociation of CaCl₂?',
    correct_answer: '3',
    tolerance: 0,
    explanation: 'CaCl₂ → Ca²⁺ + 2Cl⁻. Total particles = 3. So i = 3',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'vant_hoff_factor',
    skill_dimension: 'application',
    sequence_order: 10
  },

  # Question 11: Association
  {
    quiz: quiz_6,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Acetic acid in benzene shows i < 1 due to:',
    options: [
      { text: 'Dissociation', correct: false },
      { text: 'Association (dimerization)', correct: true },
      { text: 'Ionization', correct: false },
      { text: 'Hydrolysis', correct: false }
    ],
    explanation: 'i < 1 indicates association. Acetic acid forms dimers through hydrogen bonding: 2CH₃COOH ⇌ (CH₃COOH)₂',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'vant_hoff_factor',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 11
  },

  # Question 12: Isotonic solutions
  {
    quiz: quiz_6,
    question_type: 'true_false',
    question_text: 'Isotonic solutions have the same osmotic pressure.',
    correct_answer: 'true',
    explanation: 'TRUE. Isotonic solutions have equal osmotic pressure. This is important in medical applications (IV fluids must be isotonic with blood).',
    points: 2,
    difficulty: -0.3,
    discrimination: 0.9,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'osmotic_pressure',
    skill_dimension: 'recall',
    sequence_order: 12
  }
])

puts "  ✓ Quiz 6: #{quiz_6.quiz_questions.count} questions created"

# ========================================
# Summary
# ========================================

puts "\n" + "=" * 80
puts "MODULE 6 COMPLETE"
puts "=" * 80
puts "✅ Module: #{module_6.title}"
puts "✅ Lessons: 3"
puts "✅ Quizzes: 1"
puts "✅ Questions: #{quiz_6.quiz_questions.count}"
puts "✅ Estimated Time: #{module_6.estimated_minutes} minutes"
puts "=" * 80
puts "\n"

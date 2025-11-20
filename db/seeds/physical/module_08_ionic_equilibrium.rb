# frozen_string_literal: true

# ========================================
# IIT JEE Physical Chemistry - Module 8
# Ionic Equilibrium
# ========================================
# Complete module with lessons and questions
# Acids, bases, pH, ionization constants, buffers, salt hydrolysis, solubility
# ========================================

puts "\n" + "=" * 80
puts "MODULE 8: IONIC EQUILIBRIUM"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-physical-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Physical Chemistry course not found!"
  exit 1
end

# Create Module 8: Ionic Equilibrium
module_8 = course.course_modules.find_or_create_by!(slug: 'ionic-equilibrium') do |m|
  m.title = 'Ionic Equilibrium'
  m.sequence_order = 8
  m.estimated_minutes = 400
  m.description = 'Acids and bases, pH and pOH, ionization constants, buffer solutions, salt hydrolysis, and solubility equilibrium'
  m.learning_objectives = [
    'Master different acid-base theories (Arrhenius, Bronsted-Lowry, Lewis)',
    'Calculate pH and pOH for various solutions',
    'Understand ionization constants Ka and Kb',
    'Apply Henderson-Hasselbalch equation to buffer problems',
    'Analyze salt hydrolysis and predict solution nature',
    'Solve solubility equilibrium and Ksp problems'
  ]
  m.published = true
end

puts "✅ Module 8: #{module_8.title}"

# ========================================
# Lesson 8.1: Acids, Bases, pH and Ionization
# ========================================

lesson_8_1 = CourseLesson.create!(
  title: 'Acids and Bases: Theories, pH and Ionization Constants',
  reading_time_minutes: 55,
  key_concepts: ['Arrhenius theory', 'Bronsted-Lowry theory', 'Lewis theory', 'pH and pOH', 'Ionization constant Ka Kb', 'Conjugate acid-base pairs'],
  content: <<~MD
    # Acids and Bases: Theories, pH and Ionization Constants

    ## Acid-Base Theories

    ### 1. Arrhenius Theory (1884)

    **Acid:** Substance that releases H⁺ ions in water
    **Base:** Substance that releases OH⁻ ions in water

    **Examples:**
    - HCl → H⁺ + Cl⁻ (acid)
    - NaOH → Na⁺ + OH⁻ (base)

    **Limitations:**
    - Only for aqueous solutions
    - Cannot explain NH₃ as base (no OH⁻)
    - Limited scope

    ### 2. Bronsted-Lowry Theory (1923)

    **Acid:** Proton (H⁺) donor
    **Base:** Proton (H⁺) acceptor

    **General reaction:**
    **HA + B ⇌ A⁻ + BH⁺**

    HA = acid (donates H⁺)
    B = base (accepts H⁺)

    **Examples:**

    **1. HCl + H₂O → Cl⁻ + H₃O⁺**
    - HCl = acid (donates H⁺)
    - H₂O = base (accepts H⁺)

    **2. NH₃ + H₂O ⇌ NH₄⁺ + OH⁻**
    - H₂O = acid (donates H⁺)
    - NH₃ = base (accepts H⁺)

    ### Conjugate Acid-Base Pairs

    **Definition:** Pairs that differ by one H⁺

    **Acid ⇌ Conjugate base + H⁺**
    **Base + H⁺ ⇌ Conjugate acid**

    **Examples:**

    | Acid | Conjugate Base |
    |------|----------------|
    | HCl | Cl⁻ |
    | H₂SO₄ | HSO₄⁻ |
    | HSO₄⁻ | SO₄²⁻ |
    | H₃O⁺ | H₂O |
    | H₂O | OH⁻ |

    | Base | Conjugate Acid |
    |------|----------------|
    | NH₃ | NH₄⁺ |
    | OH⁻ | H₂O |
    | H₂O | H₃O⁺ |
    | CO₃²⁻ | HCO₃⁻ |

    **Amphoteric species:** Can act as both acid and base
    - H₂O, HSO₄⁻, HCO₃⁻, H₂PO₄⁻

    ### 3. Lewis Theory (1923)

    **Acid:** Electron pair acceptor (electrophile)
    **Base:** Electron pair donor (nucleophile)

    **Examples:**

    **1. BF₃ + NH₃ → F₃B←NH₃**
    - BF₃ = Lewis acid (accepts electron pair)
    - NH₃ = Lewis base (donates electron pair)

    **2. H⁺ + :OH⁻ → H₂O**
    - H⁺ = Lewis acid
    - OH⁻ = Lewis base

    **Common Lewis acids:** BF₃, AlCl₃, FeCl₃, H⁺, CO₂
    **Common Lewis bases:** NH₃, H₂O, ROH, :NH₂⁻

    ## Ionic Product of Water (Kw)

    **Auto-ionization of water:**
    **H₂O ⇌ H⁺ + OH⁻** or **2H₂O ⇌ H₃O⁺ + OH⁻**

    **Kw = [H⁺][OH⁻] = 1.0 × 10⁻¹⁴ at 25°C**

    ### Important Points:

    1. **In pure water:** [H⁺] = [OH⁻] = 10⁻⁷ M
    2. **In acidic solution:** [H⁺] > 10⁻⁷, [OH⁻] < 10⁻⁷
    3. **In basic solution:** [H⁺] < 10⁻⁷, [OH⁻] > 10⁻⁷
    4. **Kw increases with temperature** (endothermic process)
    5. **[H⁺][OH⁻] = 10⁻¹⁴** always at 25°C

    ## pH and pOH

    **pH = -log₁₀[H⁺]**
    **pOH = -log₁₀[OH⁻]**

    **Relationship:**
    **pH + pOH = 14** (at 25°C)

    Also: **pKw = pH + pOH = 14**

    ### pH Scale:

    - **pH < 7:** Acidic
    - **pH = 7:** Neutral
    - **pH > 7:** Basic

    ### Calculations:

    **From pH to [H⁺]:**
    **[H⁺] = 10⁻ᵖᴴ**

    **From pOH to [OH⁻]:**
    **[OH⁻] = 10⁻ᵖᴼᴴ**

    ### Examples:

    **1. [H⁺] = 10⁻³ M**
    - pH = -log(10⁻³) = 3
    - pOH = 14 - 3 = 11
    - [OH⁻] = 10⁻¹¹ M

    **2. pH = 11**
    - [H⁺] = 10⁻¹¹ M
    - pOH = 14 - 11 = 3
    - [OH⁻] = 10⁻³ M

    ## Strength of Acids and Bases

    ### Strong Acids (α ≈ 1, complete ionization):
    - HCl, HBr, HI
    - HNO₃, H₂SO₄ (first proton)
    - HClO₄, HClO₃

    ### Weak Acids (α << 1, partial ionization):
    - CH₃COOH, HCOOH
    - HF, HCN
    - H₂S, H₃PO₄

    ### Strong Bases (α ≈ 1):
    - NaOH, KOH
    - Ca(OH)₂, Ba(OH)₂

    ### Weak Bases (α << 1):
    - NH₃, methylamine
    - Pyridine, aniline

    ## Ionization Constants

    ### For Weak Acid (HA):

    **HA ⇌ H⁺ + A⁻**

    **Ka = [H⁺][A⁻] / [HA]**

    **pKa = -log Ka**

    **Larger Ka → Stronger acid**
    **Smaller pKa → Stronger acid**

    ### For Weak Base (B):

    **B + H₂O ⇌ BH⁺ + OH⁻**

    **Kb = [BH⁺][OH⁻] / [B]**

    **pKb = -log Kb**

    **Larger Kb → Stronger base**
    **Smaller pKb → Stronger base**

    ### Relationship Between Ka and Kb:

    For conjugate acid-base pair:
    **Ka × Kb = Kw = 10⁻¹⁴**

    **pKa + pKb = pKw = 14**

    ### Examples:

    **1. CH₃COOH:** Ka = 1.8 × 10⁻⁵, pKa = 4.74
    **CH₃COO⁻:** Kb = Kw/Ka = 5.6 × 10⁻¹⁰, pKb = 9.26

    **2. NH₄⁺:** Ka = 5.6 × 10⁻¹⁰, pKa = 9.26
    **NH₃:** Kb = 1.8 × 10⁻⁵, pKb = 4.74

    ## pH Calculations

    ### 1. Strong Acid:

    For HCl of concentration C:
    **pH = -log C**

    **Example:** 0.01 M HCl
    - [H⁺] = 0.01 = 10⁻² M
    - pH = 2

    ### 2. Strong Base:

    For NaOH of concentration C:
    **pOH = -log C**
    **pH = 14 - pOH**

    **Example:** 0.001 M NaOH
    - [OH⁻] = 10⁻³ M
    - pOH = 3
    - pH = 11

    ### 3. Weak Acid:

    For weak acid HA with concentration C and Ka:

    **HA ⇌ H⁺ + A⁻**

    Using ICE table:
    - [H⁺] = √(Ka × C)
    - pH = -log[H⁺]

    **Approximate formula (if α < 5%):**
    **[H⁺] = √(Ka × C)**

    **Example:** 0.1 M CH₃COOH (Ka = 1.8 × 10⁻⁵)
    - [H⁺] = √(1.8 × 10⁻⁵ × 0.1) = √(1.8 × 10⁻⁶)
    - [H⁺] = 1.34 × 10⁻³ M
    - pH = 2.87

    ### 4. Weak Base:

    For weak base B with concentration C and Kb:

    **[OH⁻] = √(Kb × C)**
    **pOH = -log[OH⁻]**
    **pH = 14 - pOH**

    **Example:** 0.1 M NH₃ (Kb = 1.8 × 10⁻⁵)
    - [OH⁻] = √(1.8 × 10⁻⁵ × 0.1) = 1.34 × 10⁻³ M
    - pOH = 2.87
    - pH = 11.13

    ## Polyprotic Acids

    **Polyprotic acids:** Can donate more than one H⁺

    ### Example: H₂SO₄

    **First ionization (complete):** H₂SO₄ → H⁺ + HSO₄⁻ (Ka₁ ≈ ∞)
    **Second ionization (weak):** HSO₄⁻ ⇌ H⁺ + SO₄²⁻ (Ka₂ = 1.2 × 10⁻²)

    ### Example: H₃PO₄

    **H₃PO₄ ⇌ H⁺ + H₂PO₄⁻** (Ka₁ = 7.5 × 10⁻³)
    **H₂PO₄⁻ ⇌ H⁺ + HPO₄²⁻** (Ka₂ = 6.2 × 10⁻⁸)
    **HPO₄²⁻ ⇌ H⁺ + PO₄³⁻** (Ka₃ = 4.8 × 10⁻¹³)

    **Note:** Ka₁ > Ka₂ > Ka₃ (successive ionization becomes harder)

    ## Degree of Ionization (α)

    **α = (Moles ionized) / (Initial moles)**

    For weak acid HA with concentration C:

    **α = √(Ka/C)**

    For weak base:

    **α = √(Kb/C)**

    **Ostwald's Dilution Law:**
    **Ka = Cα² / (1-α) ≈ Cα²** (if α << 1)

    ## Solved Problems

    ### Problem 1: pH of strong acid

    **Q: Calculate pH of 0.005 M HCl.**

    Solution:
    - HCl is strong acid, complete ionization
    - [H⁺] = 0.005 = 5 × 10⁻³ M
    - pH = -log(5 × 10⁻³) = 3 - log 5 = 3 - 0.7 = **2.3**

    ### Problem 2: pH of weak acid

    **Q: Calculate pH of 0.1 M CH₃COOH (Ka = 1.8 × 10⁻⁵).**

    Solution:
    - [H⁺] = √(Ka × C) = √(1.8 × 10⁻⁵ × 0.1)
    - [H⁺] = √(1.8 × 10⁻⁶) = 1.34 × 10⁻³ M
    - pH = -log(1.34 × 10⁻³) = **2.87**

    ### Problem 3: Ka from pH

    **Q: pH of 0.01 M weak acid is 4. Calculate Ka.**

    Solution:
    - pH = 4, so [H⁺] = 10⁻⁴ M
    - C = 0.01 M
    - Ka = [H⁺]² / C = (10⁻⁴)² / 0.01
    - Ka = 10⁻⁸ / 10⁻² = **10⁻⁶**

    ### Problem 4: Conjugate pairs

    **Q: If Ka for NH₄⁺ = 5.6 × 10⁻¹⁰, find Kb for NH₃.**

    Solution:
    - NH₄⁺ and NH₃ are conjugate pair
    - Ka × Kb = Kw
    - Kb = 10⁻¹⁴ / (5.6 × 10⁻¹⁰)
    - Kb = **1.8 × 10⁻⁵**

    ### Problem 5: pH of strong base

    **Q: Calculate pH of 0.02 M Ba(OH)₂.**

    Solution:
    - Ba(OH)₂ → Ba²⁺ + 2OH⁻
    - [OH⁻] = 2 × 0.02 = 0.04 M
    - pOH = -log(0.04) = 1.4
    - pH = 14 - 1.4 = **12.6**

    ## IIT JEE Key Points

    1. **Arrhenius:** H⁺/OH⁻ in water
    2. **Bronsted-Lowry:** H⁺ donor/acceptor
    3. **Lewis:** e⁻ pair acceptor/donor
    4. **Kw = [H⁺][OH⁻] = 10⁻¹⁴** at 25°C
    5. **pH + pOH = 14**
    6. **Ka × Kb = Kw** (conjugate pair)
    7. **Strong acid:** pH = -log C
    8. **Weak acid:** [H⁺] = √(Ka·C)
    9. **pKa + pKb = 14**
    10. **α = √(Ka/C)** for weak acids

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | pH | -log[H⁺] |
    | pOH | -log[OH⁻] |
    | Kw | [H⁺][OH⁻] = 10⁻¹⁴ |
    | pH + pOH | 14 |
    | Ka (weak acid) | [H⁺][A⁻]/[HA] |
    | Kb (weak base) | [BH⁺][OH⁻]/[B] |
    | Ka × Kb | Kw = 10⁻¹⁴ |
    | [H⁺] weak acid | √(Ka·C) |
    | [OH⁻] weak base | √(Kb·C) |
    | α (degree) | √(Ka/C) |
  MD
)

ModuleItem.create!(course_module: module_8, item: lesson_8_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 8.1: #{lesson_8_1.title}"

# ========================================
# Lesson 8.2: Buffer Solutions and Common Ion Effect
# ========================================

lesson_8_2 = CourseLesson.create!(
  title: 'Buffer Solutions, Common Ion Effect and Salt Hydrolysis',
  reading_time_minutes: 60,
  key_concepts: ['Buffer solutions', 'Henderson-Hasselbalch equation', 'Common ion effect', 'Salt hydrolysis', 'Acidic basic neutral salts'],
  content: <<~MD
    # Buffer Solutions, Common Ion Effect and Salt Hydrolysis

    ## Common Ion Effect

    **Definition:** Suppression of ionization of weak electrolyte by adding a strong electrolyte having a common ion

    ### Example 1: CH₃COOH + CH₃COONa

    **CH₃COOH ⇌ H⁺ + CH₃COO⁻** (weak acid)
    **CH₃COONa → Na⁺ + CH₃COO⁻** (strong salt)

    - Adding CH₃COONa increases [CH₃COO⁻]
    - Equilibrium shifts backward (Le Chatelier)
    - **Ionization of CH₃COOH decreases**
    - pH increases (less acidic)

    ### Example 2: NH₃ + NH₄Cl

    **NH₃ + H₂O ⇌ NH₄⁺ + OH⁻** (weak base)
    **NH₄Cl → NH₄⁺ + Cl⁻** (strong salt)

    - Adding NH₄Cl increases [NH₄⁺]
    - Equilibrium shifts backward
    - **Ionization of NH₃ decreases**
    - pH decreases (less basic)

    ### Effect on pH:

    **For weak acid + salt:** pH increases
    **For weak base + salt:** pH decreases

    ## Buffer Solutions

    **Definition:** Solutions that resist change in pH upon addition of small amounts of acid or base

    ### Types of Buffers:

    **1. Acidic Buffer (pH < 7):**
    - Weak acid + its salt with strong base
    - Examples: CH₃COOH + CH₃COONa, H₂CO₃ + NaHCO₃

    **2. Basic Buffer (pH > 7):**
    - Weak base + its salt with strong acid
    - Examples: NH₃ + NH₄Cl, NH₄OH + NH₄Cl

    ### Buffer Action:

    **Example: CH₃COOH + CH₃COONa**

    **On adding acid (H⁺):**
    - CH₃COO⁻ + H⁺ → CH₃COOH
    - Neutralizes H⁺, pH remains nearly constant

    **On adding base (OH⁻):**
    - CH₃COOH + OH⁻ → CH₃COO⁻ + H₂O
    - Neutralizes OH⁻, pH remains nearly constant

    ## Henderson-Hasselbalch Equation

    ### For Acidic Buffer:

    **pH = pKa + log([Salt]/[Acid])**

    Or: **pH = pKa + log([A⁻]/[HA])**

    Where:
    - pKa = -log Ka
    - [Salt] = concentration of conjugate base
    - [Acid] = concentration of weak acid

    ### For Basic Buffer:

    **pOH = pKb + log([Salt]/[Base])**

    Or: **pOH = pKb + log([BH⁺]/[B])**

    Then: **pH = 14 - pOH**

    ### Special Cases:

    **1. When [Salt] = [Acid]:**
    - pH = pKa (maximum buffer capacity)

    **2. Buffer Range:**
    - pH = pKa ± 1 (effective range)

    **3. Buffer Capacity:**
    - Higher concentration → Higher capacity
    - Maximum when ratio = 1:1

    ## Buffer pH Calculations

    ### Problem 1: Acidic buffer

    **Q: Calculate pH of buffer containing 0.1 M CH₃COOH and 0.1 M CH₃COONa. (Ka = 1.8 × 10⁻⁵)**

    Solution:
    - pKa = -log(1.8 × 10⁻⁵) = 4.74
    - pH = pKa + log([Salt]/[Acid])
    - pH = 4.74 + log(0.1/0.1)
    - pH = 4.74 + 0 = **4.74**

    ### Problem 2: Different concentrations

    **Q: Buffer has 0.2 M CH₃COOH and 0.4 M CH₃COONa. Calculate pH. (pKa = 4.74)**

    Solution:
    - pH = pKa + log([Salt]/[Acid])
    - pH = 4.74 + log(0.4/0.2)
    - pH = 4.74 + log 2
    - pH = 4.74 + 0.3 = **5.04**

    ### Problem 3: Basic buffer

    **Q: Calculate pH of 0.1 M NH₃ and 0.1 M NH₄Cl. (Kb = 1.8 × 10⁻⁵)**

    Solution:
    - pKb = -log(1.8 × 10⁻⁵) = 4.74
    - pOH = pKb + log([Salt]/[Base])
    - pOH = 4.74 + log(0.1/0.1) = 4.74
    - pH = 14 - 4.74 = **9.26**

    ## Salt Hydrolysis

    **Hydrolysis:** Reaction of salt with water to produce acidic or basic solution

    ### Types of Salts:

    **1. Salt of Strong Acid + Strong Base:**
    - Example: NaCl, KNO₃
    - **No hydrolysis**
    - pH = 7 (neutral)

    **2. Salt of Weak Acid + Strong Base:**
    - Example: CH₃COONa, Na₂CO₃
    - **Anion hydrolysis**
    - CH₃COO⁻ + H₂O ⇌ CH₃COOH + OH⁻
    - pH > 7 (basic)

    **3. Salt of Strong Acid + Weak Base:**
    - Example: NH₄Cl, NH₄NO₃
    - **Cation hydrolysis**
    - NH₄⁺ + H₂O ⇌ NH₃ + H₃O⁺
    - pH < 7 (acidic)

    **4. Salt of Weak Acid + Weak Base:**
    - Example: CH₃COONH₄, NH₄CN
    - **Both ions hydrolyze**
    - pH depends on relative Ka and Kb

    ### pH Formulas for Salt Solutions:

    **1. Salt of weak acid + strong base:**
    **pH = 7 + ½pKa + ½log C**

    **2. Salt of strong acid + weak base:**
    **pH = 7 - ½pKb - ½log C**

    **3. Salt of weak acid + weak base:**
    **pH = 7 + ½pKa - ½pKb**

    (Independent of concentration!)

    ## Hydrolysis Constant

    ### For Cation (from weak base):

    **Kh = Kw/Kb**

    **Example:** NH₄⁺
    - Kh = 10⁻¹⁴/(1.8 × 10⁻⁵) = 5.6 × 10⁻¹⁰

    ### For Anion (from weak acid):

    **Kh = Kw/Ka**

    **Example:** CH₃COO⁻
    - Kh = 10⁻¹⁴/(1.8 × 10⁻⁵) = 5.6 × 10⁻¹⁰

    ### For Salt of weak acid + weak base:

    **Kh = Kw/(Ka × Kb)**

    ## Solved Salt Hydrolysis Problems

    ### Problem 1: Basic salt

    **Q: Calculate pH of 0.1 M CH₃COONa. (Ka of CH₃COOH = 1.8 × 10⁻⁵)**

    Solution:
    - pKa = 4.74
    - pH = 7 + ½pKa + ½log C
    - pH = 7 + ½(4.74) + ½log(0.1)
    - pH = 7 + 2.37 + ½(-1)
    - pH = 7 + 2.37 - 0.5 = **8.87**

    ### Problem 2: Acidic salt

    **Q: Calculate pH of 0.1 M NH₄Cl. (Kb of NH₃ = 1.8 × 10⁻⁵)**

    Solution:
    - pKb = 4.74
    - pH = 7 - ½pKb - ½log C
    - pH = 7 - ½(4.74) - ½log(0.1)
    - pH = 7 - 2.37 - ½(-1)
    - pH = 7 - 2.37 + 0.5 = **5.13**

    ### Problem 3: Both weak

    **Q: Calculate pH of CH₃COONH₄. (Ka = 1.8 × 10⁻⁵, Kb = 1.8 × 10⁻⁵)**

    Solution:
    - pKa = pKb = 4.74
    - pH = 7 + ½pKa - ½pKb
    - pH = 7 + ½(4.74) - ½(4.74)
    - pH = 7 + 0 = **7.0** (neutral)

    ### Problem 4: Compare strengths

    **Q: NH₄CN solution: Ka(HCN) = 6.2 × 10⁻¹⁰, Kb(NH₃) = 1.8 × 10⁻⁵. Find pH.**

    Solution:
    - pKa = -log(6.2 × 10⁻¹⁰) = 9.21
    - pKb = 4.74
    - pH = 7 + ½(9.21) - ½(4.74)
    - pH = 7 + 4.61 - 2.37 = **9.24** (basic)
    - CN⁻ is stronger base than NH₄⁺ is acid

    ## Summary Table: Salt Nature

    | Salt Type | Example | Hydrolysis | pH | Nature |
    |-----------|---------|------------|-----|--------|
    | SA + SB | NaCl | None | 7 | Neutral |
    | WA + SB | CH₃COONa | Anion | >7 | Basic |
    | SA + WB | NH₄Cl | Cation | <7 | Acidic |
    | WA + WB | CH₃COONH₄ | Both | Depends | Varies |

    SA = Strong Acid, SB = Strong Base, WA = Weak Acid, WB = Weak Base

    ## IIT JEE Key Points

    1. **Common ion effect:** Suppresses ionization
    2. **Buffer = weak acid/base + its salt**
    3. **Henderson-Hasselbalch:** pH = pKa + log([Salt]/[Acid])
    4. **Maximum buffer capacity:** [Salt] = [Acid]
    5. **Buffer range:** pKa ± 1
    6. **SA+SB salt:** pH = 7
    7. **WA+SB salt:** pH > 7 (basic)
    8. **SA+WB salt:** pH < 7 (acidic)
    9. **WA+WB salt:** pH = 7 + ½pKa - ½pKb
    10. **Kh = Kw/Ka** or **Kw/Kb**

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Acidic buffer pH | pKa + log([Salt]/[Acid]) |
    | Basic buffer pOH | pKb + log([Salt]/[Base]) |
    | WA+SB salt pH | 7 + ½pKa + ½log C |
    | SA+WB salt pH | 7 - ½pKb - ½log C |
    | WA+WB salt pH | 7 + ½pKa - ½pKb |
    | Hydrolysis constant | Kw/Ka or Kw/Kb |
  MD
)

ModuleItem.create!(course_module: module_8, item: lesson_8_2, sequence_order: 2, required: true)

puts "  ✓ Lesson 8.2: #{lesson_8_2.title}"

# ========================================
# Lesson 8.3: Solubility Equilibrium
# ========================================

lesson_8_3 = CourseLesson.create!(
  title: 'Solubility Equilibrium and Solubility Product',
  reading_time_minutes: 50,
  key_concepts: ['Solubility equilibrium', 'Solubility product Ksp', 'Common ion effect on solubility', 'Precipitation', 'Selective precipitation'],
  content: <<~MD
    # Solubility Equilibrium and Solubility Product

    ## Solubility

    **Solubility (S):** Maximum amount of solute that dissolves in given solvent at specific temperature

    **Units:** mol/L or g/L

    ### Saturated Solution:

    - Maximum solute dissolved
    - Dynamic equilibrium between dissolved and undissolved
    - **Solid ⇌ Dissolved ions**

    ## Solubility Product (Ksp)

    **For sparingly soluble salt:** AxBy(s) ⇌ xAʸ⁺(aq) + yBˣ⁻(aq)

    **Ksp = [Aʸ⁺]ˣ[Bˣ⁻]ʸ**

    **Note:** Concentration of solid is constant (not in expression)

    ### Examples:

    **1. AgCl(s) ⇌ Ag⁺(aq) + Cl⁻(aq)**
    **Ksp = [Ag⁺][Cl⁻]**

    **2. BaSO₄(s) ⇌ Ba²⁺(aq) + SO₄²⁻(aq)**
    **Ksp = [Ba²⁺][SO₄²⁻]**

    **3. Ag₂CrO₄(s) ⇌ 2Ag⁺(aq) + CrO₄²⁻(aq)**
    **Ksp = [Ag⁺]²[CrO₄²⁻]**

    **4. Ca₃(PO₄)₂(s) ⇌ 3Ca²⁺(aq) + 2PO₄³⁻(aq)**
    **Ksp = [Ca²⁺]³[PO₄³⁻]²**

    ## Relationship Between S and Ksp

    ### Type 1: AB Type (AgCl, BaSO₄)

    **AgCl ⇌ Ag⁺ + Cl⁻**

    If solubility = S
    - [Ag⁺] = S
    - [Cl⁻] = S

    **Ksp = S × S = S²**
    **S = √Ksp**

    ### Type 2: AB₂ Type (CaF₂, PbCl₂)

    **CaF₂ ⇌ Ca²⁺ + 2F⁻**

    If solubility = S
    - [Ca²⁺] = S
    - [F⁻] = 2S

    **Ksp = S × (2S)² = 4S³**
    **S = ∛(Ksp/4)**

    ### Type 3: A₂B Type (Ag₂CrO₄, Ag₂S)

    **Ag₂CrO₄ ⇌ 2Ag⁺ + CrO₄²⁻**

    If solubility = S
    - [Ag⁺] = 2S
    - [CrO₄²⁻] = S

    **Ksp = (2S)² × S = 4S³**
    **S = ∛(Ksp/4)**

    ### Type 4: A₃B Type (Ca₃(PO₄)₂)

    **Ca₃(PO₄)₂ ⇌ 3Ca²⁺ + 2PO₄³⁻**

    If solubility = S
    - [Ca²⁺] = 3S
    - [PO₄³⁻] = 2S

    **Ksp = (3S)³ × (2S)² = 27S³ × 4S² = 108S⁵**
    **S = ⁵√(Ksp/108)**

    ## Common Ion Effect on Solubility

    **Rule:** Addition of common ion decreases solubility

    ### Example: AgCl in NaCl solution

    **AgCl ⇌ Ag⁺ + Cl⁻** (Ksp = 1.8 × 10⁻¹⁰)

    **In pure water:**
    - S = √Ksp = √(1.8 × 10⁻¹⁰) = 1.34 × 10⁻⁵ M

    **In 0.1 M NaCl:**
    - [Cl⁻] from NaCl = 0.1 M (large)
    - Let solubility = S' (very small)
    - [Ag⁺] = S'
    - [Cl⁻] ≈ 0.1 M

    - Ksp = [Ag⁺][Cl⁻]
    - 1.8 × 10⁻¹⁰ = S' × 0.1
    - S' = 1.8 × 10⁻⁹ M

    **Solubility decreased from 1.34 × 10⁻⁵ to 1.8 × 10⁻⁹**

    ## Ionic Product (Q)

    **Q = [Aʸ⁺]ˣ[Bˣ⁻]ʸ** (at any time)

    ### Precipitation Conditions:

    **1. Q < Ksp:** Unsaturated, no precipitate, more can dissolve
    **2. Q = Ksp:** Saturated, equilibrium, no change
    **3. Q > Ksp:** Supersaturated, **precipitation occurs**

    ## Selective Precipitation

    **Application:** Separate ions using precipitation

    ### Example: Ag⁺ and Pb²⁺ separation using Cl⁻

    **Data:**
    - Ksp(AgCl) = 1.8 × 10⁻¹⁰
    - Ksp(PbCl₂) = 1.7 × 10⁻⁵

    **Lower Ksp precipitates first** → AgCl precipitates before PbCl₂

    ### Calculation:

    If [Ag⁺] = [Pb²⁺] = 0.1 M

    **For AgCl to precipitate:**
    - [Cl⁻] = Ksp/[Ag⁺] = (1.8 × 10⁻¹⁰)/0.1 = 1.8 × 10⁻⁹ M

    **For PbCl₂ to precipitate:**
    - [Cl⁻]² = Ksp/[Pb²⁺] = (1.7 × 10⁻⁵)/0.1
    - [Cl⁻] = √(1.7 × 10⁻⁴) = 1.3 × 10⁻² M

    **AgCl precipitates first at much lower [Cl⁻]**

    ## Solved Ksp Problems

    ### Problem 1: Calculate Ksp

    **Q: Solubility of BaSO₄ = 1.0 × 10⁻⁵ mol/L. Calculate Ksp.**

    Solution:
    - BaSO₄ ⇌ Ba²⁺ + SO₄²⁻
    - [Ba²⁺] = [SO₄²⁻] = S = 1.0 × 10⁻⁵ M
    - Ksp = [Ba²⁺][SO₄²⁻] = (1.0 × 10⁻⁵)²
    - **Ksp = 1.0 × 10⁻¹⁰**

    ### Problem 2: Calculate solubility

    **Q: Ksp of PbCl₂ = 1.7 × 10⁻⁵. Calculate solubility.**

    Solution:
    - PbCl₂ ⇌ Pb²⁺ + 2Cl⁻
    - Ksp = [Pb²⁺][Cl⁻]² = S(2S)² = 4S³
    - 1.7 × 10⁻⁵ = 4S³
    - S³ = 4.25 × 10⁻⁶
    - **S = 1.62 × 10⁻² mol/L**

    ### Problem 3: Common ion effect

    **Q: Calculate solubility of AgCl in 0.01 M AgNO₃. (Ksp = 1.8 × 10⁻¹⁰)**

    Solution:
    - [Ag⁺] from AgNO₃ = 0.01 M
    - Let solubility of AgCl = S
    - [Ag⁺]total ≈ 0.01 M (S is negligible)
    - [Cl⁻] = S

    - Ksp = [Ag⁺][Cl⁻]
    - 1.8 × 10⁻¹⁰ = 0.01 × S
    - **S = 1.8 × 10⁻⁸ mol/L**

    ### Problem 4: Precipitation prediction

    **Q: Will AgCl precipitate if 100 mL 10⁻⁴ M AgNO₃ is mixed with 100 mL 10⁻⁴ M NaCl? (Ksp = 1.8 × 10⁻¹⁰)**

    Solution:
    - After mixing, volume = 200 mL
    - [Ag⁺] = (10⁻⁴ × 100)/200 = 5 × 10⁻⁵ M
    - [Cl⁻] = (10⁻⁴ × 100)/200 = 5 × 10⁻⁵ M

    - Q = [Ag⁺][Cl⁻] = (5 × 10⁻⁵)² = 2.5 × 10⁻⁹
    - Ksp = 1.8 × 10⁻¹⁰

    - **Q > Ksp**, so **YES, precipitation occurs**

    ### Problem 5: AB₂ type

    **Q: Ksp of Mg(OH)₂ = 1.8 × 10⁻¹¹. Calculate solubility.**

    Solution:
    - Mg(OH)₂ ⇌ Mg²⁺ + 2OH⁻
    - Ksp = [Mg²⁺][OH⁻]² = S(2S)² = 4S³
    - 1.8 × 10⁻¹¹ = 4S³
    - S³ = 4.5 × 10⁻¹²
    - **S = 1.65 × 10⁻⁴ mol/L**

    ### Problem 6: Complex problem

    **Q: In a solution containing 0.1 M Mg²⁺, what [OH⁻] will precipitate Mg(OH)₂? (Ksp = 1.8 × 10⁻¹¹)**

    Solution:
    - Ksp = [Mg²⁺][OH⁻]²
    - 1.8 × 10⁻¹¹ = 0.1 × [OH⁻]²
    - [OH⁻]² = 1.8 × 10⁻¹⁰
    - [OH⁻] = 1.34 × 10⁻⁵ M
    - pOH = 4.87
    - **pH = 9.13**

    When pH > 9.13, Mg(OH)₂ will precipitate

    ## Applications of Ksp

    1. **Qualitative analysis:** Separation of cations/anions
    2. **Water softening:** Remove Ca²⁺, Mg²⁺
    3. **Tooth decay:** Ca₅(PO₄)₃OH ⇌ 5Ca²⁺ + 3PO₄³⁻ + OH⁻
    4. **Kidney stones:** CaC₂O₄ precipitation
    5. **Photography:** AgBr in films

    ## IIT JEE Key Points

    1. **Ksp = ionic product at saturation**
    2. **AB type:** Ksp = S²
    3. **AB₂ type:** Ksp = 4S³
    4. **A₂B type:** Ksp = 4S³
    5. **Common ion decreases solubility**
    6. **Q < Ksp:** unsaturated
    7. **Q = Ksp:** saturated
    8. **Q > Ksp:** precipitation
    9. **Lower Ksp precipitates first**
    10. **Solid not in Ksp expression**

    ## Quick Reference

    | Salt Type | Example | Ksp Expression | S from Ksp |
    |-----------|---------|----------------|------------|
    | AB | AgCl | [A⁺][B⁻] | √Ksp |
    | AB₂ | CaF₂ | [A²⁺][B⁻]² | ∛(Ksp/4) |
    | A₂B | Ag₂CrO₄ | [A⁺]²[B²⁻] | ∛(Ksp/4) |
    | A₂B₃ | Al₂S₃ | [A³⁺]²[B²⁻]³ | ⁵√(Ksp/108) |

    ## Summary

    | Concept | Key Point |
    |---------|-----------|
    | Ksp | Product of ion concentrations at saturation |
    | Common ion | Decreases solubility |
    | Q vs Ksp | Predicts precipitation |
    | Selective precipitation | Lower Ksp first |
  MD
)

ModuleItem.create!(course_module: module_8, item: lesson_8_3, sequence_order: 3, required: true)

puts "  ✓ Lesson 8.3: #{lesson_8_3.title}"

# ========================================
# Quiz 8: Ionic Equilibrium
# ========================================

quiz_8 = Quiz.create!(
  title: 'Ionic Equilibrium Mastery',
  description: 'Comprehensive test on acids, bases, pH, buffers, salt hydrolysis, and solubility equilibrium',
  time_limit_minutes: 50,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_8, item: quiz_8, sequence_order: 4, required: true)

# Questions for Quiz 8 (12 questions)
QuizQuestion.create!([
  # Question 1: pH calculation
  {
    quiz: quiz_8,
    question_type: 'numerical',
    question_text: 'Calculate pH of 0.001 M HCl solution.',
    correct_answer: '3',
    tolerance: 0.1,
    explanation: 'HCl is strong acid. [H⁺] = 0.001 = 10⁻³ M. pH = -log(10⁻³) = 3',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'ph_calculations',
    skill_dimension: 'problem_solving',
    sequence_order: 1
  },

  # Question 2: Weak acid pH
  {
    quiz: quiz_8,
    question_type: 'numerical',
    question_text: 'Calculate pH of 0.1 M CH₃COOH (Ka = 1.8 × 10⁻⁵). Use formula [H⁺] = √(Ka×C).',
    correct_answer: '2.87',
    tolerance: 0.05,
    explanation: '[H⁺] = √(1.8×10⁻⁵ × 0.1) = √(1.8×10⁻⁶) = 1.34×10⁻³ M. pH = -log(1.34×10⁻³) = 2.87',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'weak_acid_equilibrium',
    skill_dimension: 'problem_solving',
    sequence_order: 2
  },

  # Question 3: Conjugate pairs
  {
    quiz: quiz_8,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the conjugate base of H₂PO₄⁻?',
    options: [
      { text: 'H₃PO₄', correct: false },
      { text: 'HPO₄²⁻', correct: true },
      { text: 'PO₄³⁻', correct: false },
      { text: 'H₂PO₄⁺', correct: false }
    ],
    explanation: 'Conjugate base is formed by removing one H⁺. H₂PO₄⁻ → HPO₄²⁻ + H⁺',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'acid_base_theories',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  # Question 4: Ka and Kb relationship
  {
    quiz: quiz_8,
    question_type: 'numerical',
    question_text: 'If Ka for NH₄⁺ is 5.6 × 10⁻¹⁰, calculate Kb for NH₃. (Answer in scientific notation as coefficient, e.g., 1.8 for 1.8×10⁻⁵)',
    correct_answer: '1.8',
    tolerance: 0.2,
    explanation: 'Ka × Kb = Kw = 10⁻¹⁴. Kb = 10⁻¹⁴/(5.6×10⁻¹⁰) = 1.8×10⁻⁵',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'ionization_constants',
    skill_dimension: 'problem_solving',
    sequence_order: 4
  },

  # Question 5: Buffer pH
  {
    quiz: quiz_8,
    question_type: 'numerical',
    question_text: 'Calculate pH of buffer with 0.1 M CH₃COOH and 0.2 M CH₃COONa. (pKa = 4.74)',
    correct_answer: '5.04',
    tolerance: 0.05,
    explanation: 'pH = pKa + log([Salt]/[Acid]) = 4.74 + log(0.2/0.1) = 4.74 + 0.30 = 5.04',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'buffer_solutions',
    skill_dimension: 'problem_solving',
    sequence_order: 5
  },

  # Question 6: Lewis acid
  {
    quiz: quiz_8,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following is a Lewis acid?',
    options: [
      { text: 'NH₃', correct: false },
      { text: 'OH⁻', correct: false },
      { text: 'BF₃', correct: true },
      { text: 'H₂O', correct: false }
    ],
    explanation: 'Lewis acid is electron pair acceptor. BF₃ has incomplete octet and accepts electron pairs.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'lewis_theory',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 6
  },

  # Question 7: Salt hydrolysis
  {
    quiz: quiz_8,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Aqueous solution of NH₄Cl is:',
    options: [
      { text: 'Acidic', correct: true },
      { text: 'Basic', correct: false },
      { text: 'Neutral', correct: false },
      { text: 'Amphoteric', correct: false }
    ],
    explanation: 'NH₄Cl is salt of strong acid (HCl) and weak base (NH₃). Cation hydrolysis occurs: NH₄⁺ + H₂O → NH₃ + H₃O⁺, giving acidic solution.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'salt_hydrolysis',
    skill_dimension: 'application',
    sequence_order: 7
  },

  # Question 8: Salt pH calculation
  {
    quiz: quiz_8,
    question_type: 'numerical',
    question_text: 'Calculate pH of 0.1 M CH₃COONa. Use: pH = 7 + ½pKa + ½logC, pKa = 4.74',
    correct_answer: '8.87',
    tolerance: 0.1,
    explanation: 'pH = 7 + ½(4.74) + ½log(0.1) = 7 + 2.37 + ½(-1) = 7 + 2.37 - 0.5 = 8.87',
    points: 4,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'salt_hydrolysis',
    skill_dimension: 'problem_solving',
    sequence_order: 8
  },

  # Question 9: Ksp calculation
  {
    quiz: quiz_8,
    question_type: 'numerical',
    question_text: 'Solubility of AgCl is 1.34 × 10⁻⁵ mol/L. Calculate Ksp. (Answer in scientific notation: coefficient × 10⁻¹⁰)',
    correct_answer: '1.8',
    tolerance: 0.2,
    explanation: 'AgCl → Ag⁺ + Cl⁻. Ksp = [Ag⁺][Cl⁻] = S × S = (1.34×10⁻⁵)² = 1.8×10⁻¹⁰',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'solubility_equilibrium',
    skill_dimension: 'problem_solving',
    sequence_order: 9
  },

  # Question 10: Common ion effect
  {
    quiz: quiz_8,
    question_type: 'true_false',
    question_text: 'Addition of common ion increases the solubility of a sparingly soluble salt.',
    correct_answer: 'false',
    explanation: 'FALSE. Common ion effect DECREASES solubility by shifting equilibrium backward (Le Chatelier\'s principle).',
    points: 2,
    difficulty: -0.1,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'common_ion_effect',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 10
  },

  # Question 11: Precipitation
  {
    quiz: quiz_8,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Precipitation occurs when:',
    options: [
      { text: 'Q < Ksp', correct: false },
      { text: 'Q = Ksp', correct: false },
      { text: 'Q > Ksp', correct: true },
      { text: 'Cannot determine', correct: false }
    ],
    explanation: 'When ionic product Q exceeds Ksp, the solution is supersaturated and precipitation occurs to reach equilibrium.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'precipitation',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 11
  },

  # Question 12: Complex buffer problem
  {
    quiz: quiz_8,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'A good buffer solution should have:',
    options: [
      { text: 'Equal concentrations of weak acid and its salt', correct: true },
      { text: 'High total concentration', correct: true },
      { text: 'pH in range pKa ± 1', correct: true },
      { text: 'Strong acid and strong base', correct: false }
    ],
    explanation: 'Good buffer has: (1) equal [acid]:[salt] ratio for max capacity, (2) high concentrations for capacity, (3) operates in pH = pKa ± 1 range. Strong acid/base cannot form buffers.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'hard',
    topic: 'buffer_capacity',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 12
  }
])

puts "  ✓ Quiz 8: #{quiz_8.quiz_questions.count} questions created"

# ========================================
# Summary
# ========================================

puts "\n" + "=" * 80
puts "MODULE 8 COMPLETE"
puts "=" * 80
puts "✅ Module: #{module_8.title}"
puts "✅ Lessons: 3"
puts "✅ Quizzes: 1"
puts "✅ Questions: #{quiz_8.quiz_questions.count}"
puts "✅ Estimated Time: #{module_8.estimated_minutes} minutes"
puts "=" * 80
puts "\n"

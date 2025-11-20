# Physical Chemistry - Module 1: Chemical Thermodynamics - Part 1
# Covers: System, State Functions, First Law, Thermochemistry, Hess's Law

puts "Creating Physical Chemistry Module 1: Chemical Thermodynamics - Part 1..."

# Find or create the Physical Chemistry course
course_physical = Course.find_or_create_by!(title: 'Physical Chemistry for IIT JEE Main & Advanced') do |course|
  course.description = 'Complete Physical Chemistry course for IIT JEE preparation with focus on numerical problem solving'
  course.difficulty = 'advanced'
  course.estimated_hours = 50
end

# Create Module 1
module_01 = CourseModule.create!(
  course: course_physical,
  title: 'Module 1: Chemical Thermodynamics - Part 1 (Basics)',
  description: 'Master thermodynamic fundamentals: systems, state functions, first law, and thermochemistry',
  order_index: 1,
  estimated_minutes: 155
)

# ============================================================================
# LESSON 1.1: System, Surroundings, and State Functions
# ============================================================================

lesson_1_1 = Lesson.create!(
  course_module: module_01,
  title: 'Lesson 1.1: System, Surroundings, and State Functions',
  content: %{
# System, Surroundings, and State Functions

## Introduction to Thermodynamics

Thermodynamics is the branch of physical chemistry that deals with energy changes in chemical reactions and physical transformations. It helps us predict whether a reaction will occur spontaneously and how much energy will be involved.

---

## System and Surroundings

### System
**System** is the part of the universe under study. It can be:
- A beaker with reacting chemicals
- A gas in a cylinder
- A solution in a container

### Surroundings
**Surroundings** are everything else in the universe that can interact with the system.

### Universe
**Universe = System + Surroundings**

---

## Types of Systems

### 1. Open System
- **Mass exchange:** Yes (can exchange matter)
- **Energy exchange:** Yes (can exchange energy)
- **Example:** Open beaker, water in an open container

### 2. Closed System
- **Mass exchange:** No (cannot exchange matter)
- **Energy exchange:** Yes (can exchange energy)
- **Example:** Sealed flask, gas in a closed cylinder with movable piston

### 3. Isolated System
- **Mass exchange:** No
- **Energy exchange:** No
- **Example:** Thermos flask (ideal), insulated sealed container

---

## Thermodynamic Properties

### Intensive Properties
Properties that **do NOT depend on the amount of substance:**
- Temperature (T)
- Pressure (P)
- Density (ρ)
- Molar volume
- Refractive index
- Viscosity

**Example:** 10 mL of water at 25°C has the same temperature as 100 mL of water at 25°C.

### Extensive Properties
Properties that **DEPEND on the amount of substance:**
- Mass (m)
- Volume (V)
- Enthalpy (H)
- Internal energy (U)
- Entropy (S)
- Gibbs free energy (G)
- Heat capacity (C)

**Example:** 100 g of water has twice the mass of 50 g of water.

**Note:** Extensive properties become intensive when expressed per mole or per unit mass (e.g., molar enthalpy, specific heat capacity).

---

## State Functions vs Path Functions

### State Functions
**State functions** depend ONLY on the initial and final states, NOT on the path taken.

**Characteristics:**
- Change (Δ) depends only on initial and final states
- Independent of the process
- Have exact differentials

**Examples:**
- Internal energy (U): ΔU = U₂ - U₁
- Enthalpy (H): ΔH = H₂ - H₁
- Entropy (S): ΔS = S₂ - S₁
- Gibbs free energy (G): ΔG = G₂ - G₁
- Pressure (P), Volume (V), Temperature (T)

**Analogy:** Like altitude in mountain climbing - doesn't matter which path you take to reach the summit, the altitude change is the same.

### Path Functions
**Path functions** depend on the PATH taken between initial and final states.

**Characteristics:**
- Value depends on the process
- Different paths give different values
- Do NOT have exact differentials

**Examples:**
- Heat (q)
- Work (w)

**Analogy:** Like distance traveled in mountain climbing - different paths cover different distances, even though starting and ending points are the same.

---

## Internal Energy (U)

**Internal energy** is the total energy contained within a system.

**Components:**
1. **Kinetic energy** of molecules (translational, rotational, vibrational)
2. **Potential energy** due to intermolecular forces
3. **Intramolecular energy** (chemical bonds, electronic energy)

**Key Points:**
- U is a **state function**
- Absolute value of U cannot be measured
- Only ΔU (change in internal energy) can be measured
- ΔU = U_final - U_initial
- For an isolated system: ΔU = 0

---

## Enthalpy (H)

**Enthalpy** is a thermodynamic property defined as:

### H = U + PV

Where:
- H = Enthalpy
- U = Internal energy
- P = Pressure
- V = Volume

**Key Points:**
- H is a **state function**
- H is an extensive property
- At constant pressure: ΔH = q_p (heat absorbed/released)
- Most reactions occur at constant pressure (atmospheric), so ΔH is very useful

**Physical Meaning:**
Enthalpy represents the total heat content of the system at constant pressure.

---

## Work and Heat

### Heat (q)
- Energy transfer due to temperature difference
- Path function
- Flows from hot to cold
- **Sign convention:**
  - q > 0: Heat absorbed by system (endothermic)
  - q < 0: Heat released by system (exothermic)

### Work (w)
- Energy transfer due to force acting through distance
- Path function
- **Sign convention (IUPAC):**
  - w > 0: Work done ON the system (compression)
  - w < 0: Work done BY the system (expansion)

**Types of Work:**
1. **Mechanical work** (expansion/compression)
2. **Electrical work**
3. **Gravitational work**

---

## Summary

| Property | Type | Depends on Path? | Example |
|----------|------|------------------|---------|
| U, H, S, G | State functions | No | ΔU = U₂ - U₁ |
| q, w | Path functions | Yes | Different for different paths |
| T, P | Intensive | No | Same regardless of amount |
| V, m, n | Extensive | No | Depend on amount |

**Key Takeaway:** Understanding the difference between state functions and path functions is crucial for solving thermodynamics problems. State functions simplify calculations because we only need to know initial and final states!

---

**Practice Tip:** When solving problems, first identify whether you're dealing with state functions or path functions. For state functions, any convenient path can be chosen for calculations.
},
  order_index: 1,
  estimated_minutes: 50
)

# Quiz 1.1
quiz_1_1 = Quiz.create!(
  lesson: lesson_1_1,
  title: 'Quiz 1.1: System, Surroundings, and State Functions'
)

quiz_1_1_questions = [
  {
    question_text: 'A gas in a sealed cylinder with a movable piston is an example of which type of system?',
    question_type: 'multiple_choice',
    options: ['Open system', 'Closed system', 'Isolated system', 'Adiabatic system'],
    correct_answer: 'Closed system',
    explanation: 'A gas in a sealed cylinder with movable piston is a CLOSED system. It can exchange energy (heat and work through piston movement) but NOT matter (sealed).',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'Which of the following is an intensive property?',
    question_type: 'multiple_choice',
    options: ['Volume', 'Mass', 'Density', 'Enthalpy'],
    correct_answer: 'Density',
    explanation: 'Density is intensive - does NOT depend on amount. Volume, mass, and enthalpy are extensive (depend on amount).',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'Which of the following is a STATE function?',
    question_type: 'multiple_choice',
    options: ['Heat (q)', 'Work (w)', 'Internal energy (U)', 'All of these'],
    correct_answer: 'Internal energy (U)',
    explanation: 'Internal energy (U) is a state function - depends only on initial and final states. Heat (q) and work (w) are path functions - depend on the process.',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'For a process where system goes from state A to state B, ΔU depends on:',
    question_type: 'multiple_choice',
    options: ['The path taken', 'Only states A and B', 'The temperature', 'The pressure'],
    correct_answer: 'Only states A and B',
    explanation: 'ΔU depends ONLY on initial (A) and final (B) states because U is a state function. Path taken does not matter.',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'Heat absorbed by a system at constant pressure is equal to:',
    question_type: 'multiple_choice',
    options: ['ΔU', 'ΔH', 'ΔG', 'ΔS'],
    correct_answer: 'ΔH',
    explanation: 'At constant pressure, heat absorbed q_p = ΔH (enthalpy change). This is why enthalpy is so useful - most reactions occur at constant atmospheric pressure.',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'If a system absorbs 50 J of heat, the sign of q is:',
    question_type: 'multiple_choice',
    options: ['Positive (+)', 'Negative (-)', 'Zero', 'Cannot determine'],
    correct_answer: 'Positive (+)',
    explanation: 'q > 0 (positive) when system ABSORBS heat (endothermic). q < 0 (negative) when system RELEASES heat (exothermic).',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'The enthalpy H is defined as:',
    question_type: 'multiple_choice',
    options: ['H = U - PV', 'H = U + PV', 'H = U/PV', 'H = UPV'],
    correct_answer: 'H = U + PV',
    explanation: 'Enthalpy is defined as H = U + PV. This makes ΔH = q at constant pressure, which is very convenient for most chemical reactions.',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'An isolated system can exchange:',
    question_type: 'multiple_choice',
    options: ['Both matter and energy', 'Only matter', 'Only energy', 'Neither matter nor energy'],
    correct_answer: 'Neither matter nor energy',
    explanation: 'Isolated system: NO exchange of matter or energy. Example: perfect thermos flask. For isolated system, ΔU = 0 (energy is conserved).',
    difficulty: 'easy',
    points: 10
  }
]

quiz_1_1_questions.each_with_index do |q_data, index|
  Question.create!(
    quiz: quiz_1_1,
    question_text: q_data[:question_text],
    question_type: q_data[:question_type],
    options: q_data[:options],
    correct_answer: q_data[:correct_answer],
    explanation: q_data[:explanation],
    difficulty: q_data[:difficulty],
    points: q_data[:points],
    order_index: index + 1
  )
end

puts "  ✓ Lesson 1.1 created with #{quiz_1_1_questions.length} quiz questions"

# ============================================================================
# LESSON 1.2: First Law of Thermodynamics
# ============================================================================

lesson_1_2 = Lesson.create!(
  course_module: module_01,
  title: 'Lesson 1.2: First Law of Thermodynamics',
  content: %{
# First Law of Thermodynamics

## Statement of First Law

**"Energy can neither be created nor destroyed, only converted from one form to another."**

Mathematically:

### ΔU = q + w

Where:
- **ΔU** = Change in internal energy (state function)
- **q** = Heat absorbed/released (path function)
- **w** = Work done on/by system (path function)

**Alternative forms:**
- ΔU = q - w (old convention, rarely used)
- dU = δq + δw (infinitesimal form)

---

## Sign Conventions (IUPAC)

### For Heat (q):
- **q > 0 (positive):** Heat absorbed BY system (endothermic)
- **q < 0 (negative):** Heat released BY system (exothermic)

### For Work (w):
- **w > 0 (positive):** Work done ON system (compression)
- **w < 0 (negative):** Work done BY system (expansion)

**Memory Tip:** Think from the system's perspective:
- Positive = system GAINS energy (heat in or work on)
- Negative = system LOSES energy (heat out or work by)

---

## Work Done in Different Processes

### 1. Expansion/Compression Work

**General formula:**
### w = -∫P_ext dV

For constant external pressure:
### w = -P_ext ΔV = -P_ext(V₂ - V₁)

**Key Points:**
- Expansion (ΔV > 0): w < 0 (work done BY system)
- Compression (ΔV < 0): w > 0 (work done ON system)
- No volume change (ΔV = 0): w = 0

---

## Thermodynamic Processes

### 1. Isothermal Process (Constant Temperature)
- **Condition:** T = constant, ΔT = 0
- **For ideal gas:** ΔU = 0 (internal energy depends only on T)
- **First law:** q = -w
- **Work:** w = -nRT ln(V₂/V₁) = -nRT ln(P₁/P₂)
- **Heat:** q = nRT ln(V₂/V₁)

**Example:** Slow expansion/compression with heat exchange to maintain constant T.

### 2. Adiabatic Process (No Heat Exchange)
- **Condition:** q = 0 (no heat transfer)
- **First law:** ΔU = w
- **For ideal gas:** PVᵞ = constant
- **Work:** w = (P₂V₂ - P₁V₁)/(γ - 1) = nCᵥ(T₂ - T₁)

Where γ (gamma) = Cp/Cv

**Example:** Rapid expansion/compression in insulated container.

### 3. Isobaric Process (Constant Pressure)
- **Condition:** P = constant, ΔP = 0
- **Work:** w = -P ΔV
- **Heat:** q_p = ΔH
- **ΔU:** ΔU = q + w = ΔH - P ΔV

**Example:** Heating water in an open container at atmospheric pressure.

### 4. Isochoric Process (Constant Volume)
- **Condition:** V = constant, ΔV = 0
- **Work:** w = 0 (no volume change)
- **First law:** ΔU = q_v
- **Heat:** q_v = nCᵥΔT

**Example:** Heating gas in a rigid sealed container.

---

## Relationship Between ΔU and ΔH

### ΔH = ΔU + Δ(PV)

For processes at constant pressure:
### ΔH = ΔU + P ΔV

For ideal gases:
### ΔH = ΔU + Δ(nRT) = ΔU + nRΔT

For reactions (constant T and P):
### ΔH = ΔU + ΔnRT

Where Δn = (moles of gaseous products) - (moles of gaseous reactants)

**Important Cases:**
- **Δn = 0:** ΔH = ΔU
- **Δn > 0:** ΔH > ΔU (expansion)
- **Δn < 0:** ΔH < ΔU (contraction)

**Note:** This relationship is crucial for converting between ΔH and ΔU in chemical reactions!

---

## Heat Capacity

### Heat Capacity (C)
Amount of heat required to raise temperature by 1 K (or 1°C).

**Units:** J/K or J/°C

### Molar Heat Capacity (C_m)
Heat capacity per mole.

**Units:** J/(mol·K)

### Specific Heat Capacity (c or s)
Heat capacity per gram.

**Units:** J/(g·K)

---

## Two Types of Heat Capacities

### 1. Heat Capacity at Constant Volume (Cᵥ)
- Heat required at constant volume
- **For ideal gas:** q_v = nCᵥΔT
- **Relation to ΔU:** ΔU = nCᵥΔT (always, not just at constant V)

### 2. Heat Capacity at Constant Pressure (Cₚ)
- Heat required at constant pressure
- **For ideal gas:** q_p = nCₚΔT
- **Relation to ΔH:** ΔH = nCₚΔT (always, not just at constant P)

---

## Relationship Between Cₚ and Cᵥ

### For Ideal Gases:

### Cₚ - Cᵥ = R

Or in molar form:
### Cₚ,m - Cᵥ,m = R = 8.314 J/(mol·K)

**Ratio:**
### γ (gamma) = Cₚ/Cᵥ

**Values of γ:**
- Monoatomic gases (He, Ne, Ar): γ = 5/3 = 1.67
- Diatomic gases (H₂, N₂, O₂): γ = 7/5 = 1.40
- Polyatomic gases (CO₂, CH₄): γ ≈ 1.33

**Key Insight:** Cₚ > Cᵥ always, because heating at constant P requires extra energy to do expansion work.

---

## Important Formulas Summary

| Process | Condition | ΔU | ΔH | q | w |
|---------|-----------|----|----|---|---|
| **Isothermal** | ΔT = 0 | 0 | 0 | -w | -nRT ln(V₂/V₁) |
| **Adiabatic** | q = 0 | w | w + PΔV | 0 | nCᵥΔT |
| **Isobaric** | ΔP = 0 | q - PΔV | q | nCₚΔT | -PΔV |
| **Isochoric** | ΔV = 0 | q | q + VΔP | nCᵥΔT | 0 |

---

## Solved Example

**Problem:** 2 moles of an ideal gas expand isothermally at 300 K from 10 L to 20 L. Calculate q, w, and ΔU.

**Solution:**
- Isothermal process: ΔU = 0 (for ideal gas)
- Work: w = -nRT ln(V₂/V₁)
  - w = -2 × 8.314 × 300 × ln(20/10)
  - w = -2 × 8.314 × 300 × 0.693
  - w = -3456 J = -3.456 kJ
- First law: ΔU = q + w
  - 0 = q + (-3456)
  - q = +3456 J = +3.456 kJ

**Answer:** q = +3.456 kJ (absorbed), w = -3.456 kJ (expansion work), ΔU = 0

---

## Key Takeaways

1. **First law:** Energy is conserved (ΔU = q + w)
2. **Sign conventions matter:** Be consistent with IUPAC signs
3. **Process type determines formulas:** Identify the process first
4. **ΔU vs ΔH:** Use ΔH = ΔU + ΔnRT for reactions
5. **Heat capacities:** Cₚ > Cᵥ and Cₚ - Cᵥ = R for ideal gases

**Practice Strategy:** Master the formulas for each type of process, and always start by identifying which process you're dealing with!
},
  order_index: 2,
  estimated_minutes: 55
)

# Quiz 1.2
quiz_1_2 = Quiz.create!(
  lesson: lesson_1_2,
  title: 'Quiz 1.2: First Law of Thermodynamics'
)

quiz_1_2_questions = [
  {
    question_text: 'According to first law of thermodynamics, ΔU is equal to:',
    question_type: 'multiple_choice',
    options: ['q - w', 'q + w', 'q × w', 'q/w'],
    correct_answer: 'q + w',
    explanation: 'First law (IUPAC): ΔU = q + w. Energy change = heat + work (with proper signs).',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'When a gas expands, the work done BY the system is:',
    question_type: 'multiple_choice',
    options: ['Positive', 'Negative', 'Zero', 'Infinite'],
    correct_answer: 'Negative',
    explanation: 'Work done BY system (expansion) is NEGATIVE (w < 0). System loses energy doing work on surroundings.',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'For an isothermal process of an ideal gas, ΔU is:',
    question_type: 'multiple_choice',
    options: ['Zero', 'Positive', 'Negative', 'Equal to q'],
    correct_answer: 'Zero',
    explanation: 'Isothermal (constant T): ΔU = 0 for ideal gas (U depends only on T). Therefore q = -w.',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'For an adiabatic process:',
    question_type: 'multiple_choice',
    options: ['q = 0', 'w = 0', 'ΔU = 0', 'ΔH = 0'],
    correct_answer: 'q = 0',
    explanation: 'Adiabatic: NO heat exchange, so q = 0. From first law: ΔU = w (all energy change is work).',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'At constant pressure, heat absorbed equals:',
    question_type: 'multiple_choice',
    options: ['ΔU', 'ΔH', 'ΔG', 'ΔS'],
    correct_answer: 'ΔH',
    explanation: 'At constant P: q_p = ΔH. This is the definition and usefulness of enthalpy.',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'The relationship between Cp and Cv for an ideal gas is:',
    question_type: 'multiple_choice',
    options: ['Cp = Cv', 'Cp < Cv', 'Cp - Cv = R', 'Cp + Cv = R'],
    correct_answer: 'Cp - Cv = R',
    explanation: 'For ideal gas: Cp - Cv = R = 8.314 J/(mol·K). Cp is always greater than Cv.',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'For an isochoric (constant volume) process, work done is:',
    question_type: 'multiple_choice',
    options: ['Maximum', 'Minimum', 'Zero', 'Equal to ΔU'],
    correct_answer: 'Zero',
    explanation: 'Constant volume: ΔV = 0, so w = -PΔV = 0. From first law: ΔU = q_v (all heat goes to internal energy).',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'For the reaction: N₂(g) + 3H₂(g) → 2NH₃(g), the relationship between ΔH and ΔU is:',
    question_type: 'multiple_choice',
    options: ['ΔH = ΔU', 'ΔH > ΔU', 'ΔH < ΔU', 'Cannot determine'],
    correct_answer: 'ΔH < ΔU',
    explanation: 'Δn = 2 - 4 = -2 (negative). ΔH = ΔU + ΔnRT. Since Δn < 0, ΔH < ΔU. Moles of gas decrease.',
    difficulty: 'hard',
    points: 20
  },
  {
    question_text: 'The value of γ (gamma = Cp/Cv) for a monoatomic gas is:',
    question_type: 'multiple_choice',
    options: ['1.33', '1.40', '1.67', '2.00'],
    correct_answer: '1.67',
    explanation: 'Monoatomic gases (He, Ar): γ = 5/3 = 1.67. Diatomic: γ = 7/5 = 1.40. Polyatomic: γ ≈ 1.33.',
    difficulty: 'medium',
    points: 15
  }
]

quiz_1_2_questions.each_with_index do |q_data, index|
  Question.create!(
    quiz: quiz_1_2,
    question_text: q_data[:question_text],
    question_type: q_data[:question_type],
    options: q_data[:options],
    correct_answer: q_data[:correct_answer],
    explanation: q_data[:explanation],
    difficulty: q_data[:difficulty],
    points: q_data[:points],
    order_index: index + 1
  )
end

puts "  ✓ Lesson 1.2 created with #{quiz_1_2_questions.length} quiz questions"

# ============================================================================
# LESSON 1.3: Thermochemistry and Hess's Law
# ============================================================================

lesson_1_3 = Lesson.create!(
  course_module: module_01,
  title: 'Lesson 1.3: Thermochemistry and Hess\'s Law',
  content: %{
# Thermochemistry and Hess's Law

## Introduction to Thermochemistry

**Thermochemistry** is the study of heat changes (enthalpy changes) in chemical reactions and physical transformations.

Most reactions occur at constant atmospheric pressure, so we use **ΔH** (enthalpy change) to describe heat changes.

---

## Standard Conditions

### Standard State
- **Pressure:** P° = 1 bar (≈ 1 atm)
- **Temperature:** Usually 298 K (25°C), unless specified otherwise
- **Concentration:** 1 M for solutions
- **Pure substances** in their most stable form

**Notation:** The superscript "°" (degree) indicates standard conditions.
- Example: ΔH°, ΔH°f, ΔH°r

---

## Types of Enthalpy Changes

### 1. Standard Enthalpy of Formation (ΔH°f)

**Definition:** Enthalpy change when **1 mole** of a compound is formed from its **elements** in their **standard states**.

**Example:**
- C(graphite) + O₂(g) → CO₂(g), ΔH°f = -393.5 kJ/mol
- H₂(g) + ½O₂(g) → H₂O(l), ΔH°f = -285.8 kJ/mol

**Key Points:**
- ΔH°f of elements in standard state = 0 (by definition)
  - ΔH°f(H₂) = 0, ΔH°f(O₂) = 0, ΔH°f(C, graphite) = 0
- Most stable form: O₂ (not O₃), C(graphite) (not diamond)

---

### 2. Standard Enthalpy of Combustion (ΔH°c)

**Definition:** Enthalpy change when **1 mole** of a substance is **completely burned** in excess oxygen.

**Example:**
- CH₄(g) + 2O₂(g) → CO₂(g) + 2H₂O(l), ΔH°c = -890 kJ/mol
- C₂H₅OH(l) + 3O₂(g) → 2CO₂(g) + 3H₂O(l), ΔH°c = -1367 kJ/mol

**Key Points:**
- Always exothermic (ΔH°c < 0)
- Products: CO₂(g) and H₂O(l) for complete combustion
- Used to determine calorific values of fuels

---

### 3. Standard Enthalpy of Reaction (ΔH°r)

**Definition:** Enthalpy change for a reaction as written.

**General formula:**
### ΔH°r = Σ(ΔH°f of products) - Σ(ΔH°f of reactants)

With stoichiometric coefficients:
### ΔH°r = Σnₚ·ΔH°f(products) - Σnᵣ·ΔH°f(reactants)

**Example:** For aA + bB → cC + dD
ΔH°r = [c·ΔH°f(C) + d·ΔH°f(D)] - [a·ΔH°f(A) + b·ΔH°f(B)]

---

### 4. Other Important Enthalpy Changes

**Enthalpy of Atomization (ΔH°atom):**
- Heat required to break 1 mole of bonds to give gaseous atoms
- Example: H₂(g) → 2H(g), ΔH°atom = 436 kJ/mol

**Enthalpy of Sublimation (ΔH°sub):**
- Solid → Gas (direct)
- Example: I₂(s) → I₂(g)

**Enthalpy of Fusion (ΔH°fus):**
- Solid → Liquid (melting)
- Example: H₂O(s) → H₂O(l), ΔH°fus = 6.01 kJ/mol

**Enthalpy of Vaporization (ΔH°vap):**
- Liquid → Gas (boiling)
- Example: H₂O(l) → H₂O(g), ΔH°vap = 40.7 kJ/mol

**Relationship:**
### ΔH°sub = ΔH°fus + ΔH°vap

---

## Hess's Law

**Statement:** "The total enthalpy change for a reaction is independent of the route by which the reaction occurs."

**Consequence:** If a reaction can be expressed as a sum of two or more reactions, then ΔH for the overall reaction is the sum of ΔH values for the individual reactions.

### ΔH°overall = ΔH°₁ + ΔH°₂ + ΔH°₃ + ...

**Why it works:** Enthalpy (H) is a **state function** - path independent!

---

## Applying Hess's Law

### Method: Manipulate given equations to get target equation

**Rules:**
1. **Reverse equation:** Change sign of ΔH
   - If A → B has ΔH₁, then B → A has ΔH = -ΔH₁

2. **Multiply equation by n:** Multiply ΔH by n
   - If A → B has ΔH₁, then nA → nB has ΔH = n·ΔH₁

3. **Add equations:** Add ΔH values
   - If A → B (ΔH₁) and B → C (ΔH₂), then A → C has ΔH = ΔH₁ + ΔH₂

**Strategy:**
- Write target equation
- Manipulate given equations (reverse, multiply) to match
- Add equations (cancel species on both sides)
- Add ΔH values

---

## Hess's Law Example

**Problem:** Calculate ΔH° for: C(s) + ½O₂(g) → CO(g)

**Given:**
1. C(s) + O₂(g) → CO₂(g), ΔH°₁ = -393.5 kJ
2. CO(g) + ½O₂(g) → CO₂(g), ΔH°₂ = -283.0 kJ

**Solution:**
- Target: C + ½O₂ → CO
- Keep equation 1 as is: C + O₂ → CO₂ (ΔH°₁ = -393.5 kJ)
- Reverse equation 2: CO₂ → CO + ½O₂ (ΔH° = +283.0 kJ)
- Add equations:
  - C + O₂ + CO₂ → CO₂ + CO + ½O₂
  - Cancel CO₂: C + ½O₂ → CO
- ΔH° = -393.5 + 283.0 = -110.5 kJ

**Answer:** ΔH° = -110.5 kJ/mol

---

## Bond Enthalpy (Bond Energy)

**Definition:** Energy required to break **1 mole** of bonds in gaseous molecules.

**Example:**
- H₂(g) → 2H(g), Bond enthalpy of H-H = 436 kJ/mol
- Cl₂(g) → 2Cl(g), Bond enthalpy of Cl-Cl = 242 kJ/mol

### Calculating ΔH° from Bond Enthalpies:

### ΔH°r = Σ(Bonds broken) - Σ(Bonds formed)

Or:
### ΔH°r = Σ(B.E. of reactants) - Σ(B.E. of products)

**Key Point:** Bond breaking requires energy (endothermic, +), bond formation releases energy (exothermic, -)

---

## Bond Enthalpy Example

**Problem:** Calculate ΔH° for: CH₄(g) + Cl₂(g) → CH₃Cl(g) + HCl(g)

**Bond enthalpies:**
- C-H: 413 kJ/mol
- Cl-Cl: 242 kJ/mol
- C-Cl: 328 kJ/mol
- H-Cl: 431 kJ/mol

**Solution:**
Bonds broken (reactants):
- 4 × C-H = 4 × 413 = 1652 kJ
- 1 × Cl-Cl = 242 kJ
- Total = 1894 kJ

Bonds formed (products):
- 3 × C-H = 3 × 413 = 1239 kJ
- 1 × C-Cl = 328 kJ
- 1 × H-Cl = 431 kJ
- Total = 1998 kJ

ΔH° = 1894 - 1998 = -104 kJ

**Answer:** ΔH° = -104 kJ (exothermic)

---

## Important Points

1. **Exothermic reactions:** ΔH < 0 (heat released)
   - More stable products, stronger bonds formed

2. **Endothermic reactions:** ΔH > 0 (heat absorbed)
   - Less stable products, weaker bonds formed

3. **Hess's Law applications:**
   - Calculate ΔH° for reactions difficult to measure directly
   - Use known ΔH°f values
   - Manipulate equations algebraically

4. **Bond enthalpies:**
   - Average values (not exact for specific molecules)
   - All species must be gaseous
   - Approximate method for estimating ΔH°

---

## Summary Table

| Type | Symbol | Definition |
|------|--------|------------|
| Formation | ΔH°f | 1 mol compound from elements |
| Combustion | ΔH°c | 1 mol substance + O₂ → CO₂ + H₂O |
| Reaction | ΔH°r | For reaction as written |
| Atomization | ΔH°atom | Break bonds to give atoms |
| Fusion | ΔH°fus | Solid → Liquid |
| Vaporization | ΔH°vap | Liquid → Gas |
| Sublimation | ΔH°sub | Solid → Gas |

**Key Formula:**
### ΔH°r = Σnₚ·ΔH°f(products) - Σnᵣ·ΔH°f(reactants)

---

## Practice Strategy

1. **Identify type of ΔH:** Formation, combustion, reaction?
2. **Use standard formulas:** ΔH°r from ΔH°f values
3. **Apply Hess's Law:** For multi-step calculations
4. **Check signs:** Exothermic (-) or endothermic (+)
5. **Include units:** Always kJ or kJ/mol

**Master these:** Hess's Law manipulations and ΔH° calculations from ΔH°f values are essential for IIT JEE!
},
  order_index: 3,
  estimated_minutes: 50
)

# Quiz 1.3
quiz_1_3 = Quiz.create!(
  lesson: lesson_1_3,
  title: 'Quiz 1.3: Thermochemistry and Hess\'s Law'
)

quiz_1_3_questions = [
  {
    question_text: 'The standard enthalpy of formation (ΔH°f) of O₂(g) is:',
    question_type: 'multiple_choice',
    options: ['Zero', 'Positive', 'Negative', 'Cannot be determined'],
    correct_answer: 'Zero',
    explanation: 'ΔH°f of elements in their standard state is ZERO by definition. O₂(g) is the standard state of oxygen.',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'Hess\'s law is based on the fact that enthalpy is a:',
    question_type: 'multiple_choice',
    options: ['Path function', 'State function', 'Intensive property', 'Extensive property'],
    correct_answer: 'State function',
    explanation: 'Hess\'s law works because enthalpy (H) is a STATE FUNCTION - independent of path. Total ΔH depends only on initial and final states.',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'For an exothermic reaction, ΔH is:',
    question_type: 'multiple_choice',
    options: ['Positive', 'Negative', 'Zero', 'Infinite'],
    correct_answer: 'Negative',
    explanation: 'Exothermic: heat RELEASED, so ΔH < 0 (negative). Endothermic: heat ABSORBED, so ΔH > 0 (positive).',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'The enthalpy of combustion (ΔH°c) is always:',
    question_type: 'multiple_choice',
    options: ['Positive', 'Negative', 'Zero', 'Can be any value'],
    correct_answer: 'Negative',
    explanation: 'Combustion reactions are ALWAYS exothermic (release heat), so ΔH°c < 0 (negative) always.',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'To calculate ΔH°r from bond enthalpies, the formula is:',
    question_type: 'multiple_choice',
    options: ['ΔH° = Bonds formed - Bonds broken', 'ΔH° = Bonds broken - Bonds formed', 'ΔH° = Bonds broken + Bonds formed', 'ΔH° = Bonds broken × Bonds formed'],
    correct_answer: 'ΔH° = Bonds broken - Bonds formed',
    explanation: 'ΔH° = Σ(Bonds broken) - Σ(Bonds formed). Breaking bonds requires energy (+), forming bonds releases energy (-).',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'ΔH°sub (sublimation) is related to ΔH°fus and ΔH°vap as:',
    question_type: 'multiple_choice',
    options: ['ΔH°sub = ΔH°fus - ΔH°vap', 'ΔH°sub = ΔH°fus + ΔH°vap', 'ΔH°sub = ΔH°vap - ΔH°fus', 'ΔH°sub = ΔH°fus × ΔH°vap'],
    correct_answer: 'ΔH°sub = ΔH°fus + ΔH°vap',
    explanation: 'Sublimation = Fusion + Vaporization (Solid → Liquid → Gas). So ΔH°sub = ΔH°fus + ΔH°vap.',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'If an equation is reversed, the sign of ΔH:',
    question_type: 'multiple_choice',
    options: ['Remains same', 'Changes', 'Becomes zero', 'Doubles'],
    correct_answer: 'Changes',
    explanation: 'Reversing equation CHANGES sign of ΔH. If A → B has ΔH, then B → A has -ΔH. This is key for Hess\'s Law.',
    difficulty: 'easy',
    points: 10
  },
  {
    question_text: 'Standard enthalpy of formation is defined for:',
    question_type: 'multiple_choice',
    options: ['Any reaction', 'Only combustion', 'Formation of 1 mole compound from elements', 'Breaking of bonds'],
    correct_answer: 'Formation of 1 mole compound from elements',
    explanation: 'ΔH°f: Enthalpy change when 1 MOLE of compound is formed from ELEMENTS in standard states.',
    difficulty: 'medium',
    points: 15
  },
  {
    question_text: 'Bond enthalpy calculations require all species to be in which state?',
    question_type: 'multiple_choice',
    options: ['Solid', 'Liquid', 'Gaseous', 'Aqueous'],
    correct_answer: 'Gaseous',
    explanation: 'Bond enthalpies are defined for GASEOUS molecules only. All species must be in gas phase for bond energy calculations.',
    difficulty: 'medium',
    points: 15
  }
]

quiz_1_3_questions.each_with_index do |q_data, index|
  Question.create!(
    quiz: quiz_1_3,
    question_text: q_data[:question_text],
    question_type: q_data[:question_type],
    options: q_data[:options],
    correct_answer: q_data[:correct_answer],
    explanation: q_data[:explanation],
    difficulty: q_data[:difficulty],
    points: q_data[:points],
    order_index: index + 1
  )
end

puts "  ✓ Lesson 1.3 created with #{quiz_1_3_questions.length} quiz questions"

# Summary
puts "\n" + "="*80
puts "Module 1: Chemical Thermodynamics - Part 1 Summary"
puts "="*80
puts "Module: #{module_01.title}"
puts "Lessons: 3"
puts "  • Lesson 1.1: System, Surroundings, and State Functions (50 min, 8 quiz questions)"
puts "  • Lesson 1.2: First Law of Thermodynamics (55 min, 9 quiz questions)"
puts "  • Lesson 1.3: Thermochemistry and Hess's Law (50 min, 9 quiz questions)"
puts "Total quiz questions: 26"
puts "Total estimated time: ~155 minutes (~2.6 hours)"
puts "="*80
puts "Physical Chemistry Module 1 created successfully!"
puts "="*80

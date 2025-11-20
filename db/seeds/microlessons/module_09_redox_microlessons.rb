# AUTO-GENERATED from module_09_redox.rb
puts "Creating Microlessons for Redox Reactions..."

module_var = CourseModule.find_by(slug: 'redox-reactions')

# === MICROLESSON 1: oxidation_numbers — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_numbers — Practice',
  content: <<~MARKDOWN,
# oxidation_numbers — Practice 🚀

Mn in MnO₄⁻: +7 (calculated: x + 4(-2) = -1 → x = +7). Mn²⁺: +2. Change = 7 - 2 = 5. Mn gains 5 electrons (reduced by 5).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['oxidation_numbers'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In the reaction: MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O, what is the change in oxidation number of Mn?',
    answer: '5',
    explanation: 'Mn in MnO₄⁻: +7 (calculated: x + 4(-2) = -1 → x = +7). Mn²⁺: +2. Change = 7 - 2 = 5. Mn gains 5 electrons (reduced by 5).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Balancing Redox Equations and Electrochemical Series ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Balancing Redox Equations and Electrochemical Series',
  content: <<~MARKDOWN,
# Balancing Redox Equations and Electrochemical Series 🚀

# Balancing Redox Equations and Electrochemical Series

    ## Methods for Balancing Redox Equations

    ### 1. Oxidation Number Method
    ### 2. Half-Reaction (Ion-Electron) Method ⭐

    We'll focus on the **Half-Reaction Method** (preferred for IIT JEE)

    ## Half-Reaction Method (Ion-Electron Method)

    ### Steps for Acidic Medium:

    **Step 1:** Write separate oxidation and reduction half-reactions
    **Step 2:** Balance atoms other than O and H
    **Step 3:** Balance O by adding H₂O
    **Step 4:** Balance H by adding H⁺
    **Step 5:** Balance charge by adding electrons
    **Step 6:** Multiply to equalize electrons
    **Step 7:** Add half-reactions and cancel common terms

    ### Example 1: MnO₄⁻ + Fe²⁺ → Mn²⁺ + Fe³⁺ (acidic)

    **Step 1: Separate half-reactions**

    Oxidation: Fe²⁺ → Fe³⁺
    Reduction: MnO₄⁻ → Mn²⁺

    **Step 2: Balance atoms (except O, H)**

    Already balanced

    **Step 3: Balance O with H₂O**

    Fe²⁺ → Fe³⁺
    MnO₄⁻ → Mn²⁺ + 4H₂O

    **Step 4: Balance H with H⁺**

    Fe²⁺ → Fe³⁺
    MnO₄⁻ + 8H⁺ → Mn²⁺ + 4H₂O

    **Step 5: Balance charge with electrons**

    Fe²⁺ → Fe³⁺ + e⁻ ... (1)
    MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O ... (2)

    **Step 6: Multiply to equalize electrons**

    (1) × 5: 5Fe²⁺ → 5Fe³⁺ + 5e⁻
    (2) × 1: MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O

    **Step 7: Add and simplify**

    **MnO₄⁻ + 5Fe²⁺ + 8H⁺ → Mn²⁺ + 5Fe³⁺ + 4H₂O**

    ### Example 2: Cr₂O₇²⁻ + SO₃²⁻ → Cr³⁺ + SO₄²⁻ (acidic)

    **Oxidation:** SO₃²⁻ → SO₄²⁻
    **Reduction:** Cr₂O₇²⁻ → Cr³⁺

    **Balance atoms:**
    SO₃²⁻ → SO₄²⁻
    Cr₂O₇²⁻ → 2Cr³⁺

    **Balance O with H₂O:**
    SO₃²⁻ + H₂O → SO₄²⁻
    Cr₂O₇²⁻ → 2Cr³⁺ + 7H₂O

    **Balance H with H⁺:**
    SO₃²⁻ + H₂O → SO₄²⁻ + 2H⁺
    Cr₂O₇²⁻ + 14H⁺ → 2Cr³⁺ + 7H₂O

    **Balance charge:**
    SO₃²⁻ + H₂O → SO₄²⁻ + 2H⁺ + 2e⁻ ... (1)
    Cr₂O₇²⁻ + 14H⁺ + 6e⁻ → 2Cr³⁺ + 7H₂O ... (2)

    **Multiply (1)×3:**
    3SO₃²⁻ + 3H₂O → 3SO₄²⁻ + 6H⁺ + 6e⁻

    **Add:**
    **Cr₂O₇²⁻ + 3SO₃²⁻ + 8H⁺ → 2Cr³⁺ + 3SO₄²⁻ + 4H₂O**

    ## Balancing in Basic Medium

    ### Method 1: Balance in acidic, then convert to basic

    **Steps:**
    1. Balance as if in acidic medium
    2. Add OH⁻ to both sides equal to H⁺
    3. Combine H⁺ + OH⁻ → H₂O
    4. Cancel excess H₂O

    ### Example: MnO₄⁻ + I⁻ → MnO₂ + IO₃⁻ (basic)

    **Step 1: Balance in acidic medium**

    Oxidation: I⁻ + 3H₂O → IO₃⁻ + 6H⁺ + 6e⁻
    Reduction: MnO₄⁻ + 4H⁺ + 3e⁻ → MnO₂ + 2H₂O

    Multiply reduction ×2:
    2MnO₄⁻ + 8H⁺ + 6e⁻ → 2MnO₂ + 4H₂O

    Add:
    2MnO₄⁻ + I⁻ + 8H⁺ + 3H₂O → 2MnO₂ + IO₃⁻ + 6H⁺ + 4H₂O

    Simplify:
    2MnO₄⁻ + I⁻ + 2H⁺ → 2MnO₂ + IO₃⁻ + H₂O ... (acidic)

    **Step 2: Convert to basic (add 2OH⁻ to both sides)**

    2MnO₄⁻ + I⁻ + 2H⁺ + 2OH⁻ → 2MnO₂ + IO₃⁻ + H₂O + 2OH⁻

    **Step 3: H⁺ + OH⁻ → H₂O**

    2MnO₄⁻ + I⁻ + 2H₂O → 2MnO₂ + IO₃⁻ + H₂O + 2OH⁻

    **Step 4: Simplify**

    **2MnO₄⁻ + I⁻ + H₂O → 2MnO₂ + IO₃⁻ + 2OH⁻**

    ## Method 2: Direct Balancing in Basic Medium

    **Steps:**
    1. Write half-reactions
    2. Balance atoms except O, H
    3. Balance O with H₂O
    4. Balance H with H₂O and OH⁻ (add H₂O to H-deficient side, equal OH⁻ to other)
    5. Balance charge with electrons
    6. Equalize electrons and add

    ## Complex Examples

    ### Example 3: H₂O₂ + KMnO₄ → O₂ + MnO₂ (basic)

    **Oxidation:** H₂O₂ → O₂
    **Reduction:** MnO₄⁻ → MnO₂

    **In basic:**
    H₂O₂ → O₂ + 2H⁺ + 2e⁻
    Add 2OH⁻: H₂O₂ + 2OH⁻ → O₂ + 2H₂O + 2e⁻

    MnO₄⁻ + 4H⁺ + 3e⁻ → MnO₂ + 2H₂O
    Add 4OH⁻: MnO₄⁻ + 4H₂O + 3e⁻ → MnO₂ + 2H₂O + 4OH⁻
    Simplify: MnO₄⁻ + 2H₂O + 3e⁻ → MnO₂ + 4OH⁻

    Multiply: (ox)×3, (red)×2

    3H₂O₂ + 6OH⁻ → 3O₂ + 6H₂O + 6e⁻
    2MnO₄⁻ + 4H₂O + 6e⁻ → 2MnO₂ + 8OH⁻

    Add:
    **3H₂O₂ + 2MnO₄⁻ → 3O₂ + 2MnO₂ + 2OH⁻ + 2H₂O**

    ## Electrochemical Series

    **Definition:** Arrangement of metals/electrodes in order of their standard reduction potentials

    ### Standard Hydrogen Electrode (SHE):

    **2H⁺ + 2e⁻ → H₂**
    **E° = 0.00 V** (reference)

    ### Standard Electrode Potential (E°):

    Potential of half-cell measured against SHE under standard conditions:
    - Concentration: 1 M
    - Pressure: 1 atm
    - Temperature: 25°C (298 K)

    ## Electrochemical Series (Partial)

    | Half-Reaction | E° (V) | Strength |
    |---------------|--------|----------|
    | F₂ + 2e⁻ → 2F⁻ | +2.87 | Strongest oxidizer |
    | MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O | +1.51 | |
    | Cl₂ + 2e⁻ → 2Cl⁻ | +1.36 | |
    | Cr₂O₇²⁻ + 14H⁺ + 6e⁻ → 2Cr³⁺ + 7H₂O | +1.33 | |
    | Br₂ + 2e⁻ → 2Br⁻ | +1.09 | |
    | Ag⁺ + e⁻ → Ag | +0.80 | |
    | Fe³⁺ + e⁻ → Fe²⁺ | +0.77 | |
    | I₂ + 2e⁻ → 2I⁻ | +0.54 | |
    | Cu²⁺ + 2e⁻ → Cu | +0.34 | |
    | **2H⁺ + 2e⁻ → H₂** | **0.00** | **Reference** |
    | Pb²⁺ + 2e⁻ → Pb | -0.13 | |
    | Sn²⁺ + 2e⁻ → Sn | -0.14 | |
    | Ni²⁺ + 2e⁻ → Ni | -0.25 | |
    | Fe²⁺ + 2e⁻ → Fe | -0.44 | |
    | Zn²⁺ + 2e⁻ → Zn | -0.76 | |
    | Al³⁺ + 3e⁻ → Al | -1.66 | |
    | Mg²⁺ + 2e⁻ → Mg | -2.37 | |
    | Na⁺ + e⁻ → Na | -2.71 | |
    | K⁺ + e⁻ → K | -2.93 | |
    | Li⁺ + e⁻ → Li | -3.05 | Strongest reducer |

    ## Applications of Electrochemical Series

    ### 1. Predicting Oxidizing/Reducing Strength:

    **Higher E°** → Better oxidizing agent (easily reduced)
    **Lower E°** → Better reducing agent (easily oxidized)

    **Example:**
    - F₂ (E° = +2.87) is strongest oxidizer
    - Li (E° = -3.05) is strongest reducer

    ### 2. Predicting Spontaneity:

    **For reaction:** A + B⁺ → A⁺ + B

    If E°(B⁺/B) > E°(A⁺/A), reaction is **spontaneous**

    **Example:** Can Cu reduce Ag⁺?

    Cu → Cu²⁺ + 2e⁻ (E° = -0.34 V for reverse)
    Ag⁺ + e⁻ → Ag (E° = +0.80 V)

    Since E°(Ag⁺/Ag) > E°(Cu²⁺/Cu), **YES, spontaneous**

    ### 3. Displacement Reactions:

    **Metal with lower E° can displace metal with higher E° from solution**

    **Example:** Zn + CuSO₄ → ZnSO₄ + Cu ✓
    - E°(Zn²⁺/Zn) = -0.76 < E°(Cu²⁺/Cu) = +0.34

    But: Cu + ZnSO₄ → ? ✗ (Not spontaneous)

    ### 4. Reactivity with Acids:

    **Metals with E° < 0** (below H₂) can liberate H₂ from acids

    **Example:**
    - Zn + HCl → ZnCl₂ + H₂ ✓ (E° = -0.76 V)
    - Cu + HCl → ? ✗ (E° = +0.34 V)

    ## Solved Problems

    ### Problem 1: Balance equation (acidic)

    **Q: Balance: MnO₄⁻ + H₂O₂ → Mn²⁺ + O₂ (acidic)**

    Solution:
    Oxidation: H₂O₂ → O₂ + 2H⁺ + 2e⁻
    Reduction: MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O

    Multiply: (ox)×5, (red)×2

    5H₂O₂ → 5O₂ + 10H⁺ + 10e⁻
    2MnO₄⁻ + 16H⁺ + 10e⁻ → 2Mn²⁺ + 8H₂O

    **2MnO₄⁻ + 5H₂O₂ + 6H⁺ → 2Mn²⁺ + 5O₂ + 8H₂O**

    ### Problem 2: Predict spontaneity

    **Q: Will Fe reduce Cu²⁺? E°(Cu²⁺/Cu) = +0.34 V, E°(Fe²⁺/Fe) = -0.44 V**

    Solution:
    - E°(Cu²⁺/Cu) > E°(Fe²⁺/Fe)
    - Fe has lower E°, stronger reducer
    - **YES, Fe + Cu²⁺ → Fe²⁺ + Cu is spontaneous**

    ### Problem 3: Displacement

    **Q: Which metal can displace Ag from AgNO₃: Cu or Au?**

    E°: Ag⁺/Ag = +0.80, Cu²⁺/Cu = +0.34, Au³⁺/Au = +1.50

    Solution:
    - Cu has lower E° than Ag → **Cu can displace Ag** ✓
    - Au has higher E° than Ag → Au cannot displace Ag ✗

    ## IIT JEE Key Points

    1. **Half-reaction method:** Balance O with H₂O, H with H⁺, charge with e⁻
    2. **Basic medium:** Add OH⁻ equal to H⁺, combine to H₂O
    3. **E° scale:** SHE = 0.00 V reference
    4. **Higher E°:** Better oxidizing agent
    5. **Lower E°:** Better reducing agent
    6. **Spontaneous:** Higher E° oxidizer + lower E° reducer
    7. **Displacement:** Lower E° displaces higher E°
    8. **Metals below H₂:** React with acids
    9. **F₂:** Strongest oxidizer
    10. **Li/K:** Strongest reducers

    ## Quick Formulas

    | Concept | Method |
    |---------|--------|
    | Balance redox | Half-reaction method |
    | Acidic medium | Add H⁺ and H₂O |
    | Basic medium | Convert H⁺ to H₂O using OH⁻ |
    | Spontaneity | E°(oxidizer) > E°(reducer) |
    | Displacement | Lower E° displaces higher E° |

## Key Points

- Half-reaction method

- Ion-electron method

- Balancing in acidic medium
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Half-reaction method', 'Ion-electron method', 'Balancing in acidic medium', 'Balancing in basic medium', 'Electrochemical series', 'Standard electrode potential'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Oxidation Numbers and Redox Reaction Fundamentals ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Oxidation Numbers and Redox Reaction Fundamentals',
  content: <<~MARKDOWN,
# Oxidation Numbers and Redox Reaction Fundamentals 🚀

# Oxidation Numbers and Redox Reaction Fundamentals

    ## Classical Definitions

    ### Oxidation:
    - Addition of oxygen
    - Removal of hydrogen
    - Loss of electrons

    ### Reduction:
    - Removal of oxygen
    - Addition of hydrogen
    - Gain of electrons

    **Example:**
    **2Mg + O₂ → 2MgO**
    - Mg oxidized (adds O)
    - O₂ reduced

    ## Modern Definition (Electronic)

    **Oxidation:** Loss of electrons (increase in oxidation number)
    **Reduction:** Gain of electrons (decrease in oxidation number)

    **Mnemonic: OIL RIG**
    - **O**xidation **I**s **L**oss (of electrons)
    - **R**eduction **I**s **G**ain (of electrons)

    ### Example:
    **Zn + Cu²⁺ → Zn²⁺ + Cu**

    - **Oxidation:** Zn → Zn²⁺ + 2e⁻ (loss of electrons)
    - **Reduction:** Cu²⁺ + 2e⁻ → Cu (gain of electrons)

    ## Oxidation Number (Oxidation State)

    **Definition:** Charge an atom would have if all bonds were ionic

    ### Rules for Assigning Oxidation Numbers:

    **1. Free element:** Oxidation number = 0
    - Na, O₂, P₄, S₈ all have ON = 0

    **2. Monatomic ion:** ON = charge on ion
    - Na⁺: +1, Cl⁻: -1, Fe³⁺: +3, O²⁻: -2

    **3. Hydrogen:** Usually +1
    - Exception: In metal hydrides (NaH, CaH₂), H = -1

    **4. Oxygen:** Usually -2
    - Exceptions:
      - Peroxides (H₂O₂, Na₂O₂): O = -1
      - Superoxides (KO₂): O = -½
      - OF₂: O = +2 (F more electronegative)

    **5. Fluorine:** Always -1

    **6. Group 1 metals (Li, Na, K):** Always +1

    **7. Group 2 metals (Mg, Ca, Ba):** Always +2

    **8. Chlorine, Bromine, Iodine:** Usually -1
    - Exception: When bonded to O or F (e.g., ClO⁻, BrO₃⁻)

    **9. Sum of oxidation numbers:**
    - **Neutral molecule:** Sum = 0
    - **Ion:** Sum = charge on ion

    ## Examples of Oxidation Number Calculation

    ### Example 1: H₂SO₄

    Let ON of S = x
    - 2(+1) + x + 4(-2) = 0
    - 2 + x - 8 = 0
    - x = +6

    **S in H₂SO₄ has ON = +6**

    ### Example 2: Cr₂O₇²⁻

    Let ON of Cr = x
    - 2x + 7(-2) = -2
    - 2x - 14 = -2
    - 2x = 12
    - x = +6

    **Cr in Cr₂O₇²⁻ has ON = +6**

    ### Example 3: NH₃

    Let ON of N = x
    - x + 3(+1) = 0
    - x = -3

    **N in NH₃ has ON = -3**

    ### Example 4: H₂O₂

    - Each H = +1
    - Each O = -1 (peroxide)
    - Check: 2(+1) + 2(-1) = 0 ✓

    ### Example 5: Fe₃O₄

    Let ON of Fe = x
    - 3x + 4(-2) = 0
    - 3x = 8
    - x = 8/3

    **Fe in Fe₃O₄ has average ON = +8/3**

    (Actually Fe₃O₄ = FeO·Fe₂O₃, contains Fe²⁺ and Fe³⁺)

    ## Variable Oxidation States

    Many elements show multiple oxidation states:

    | Element | Common ON | Examples |
    |---------|-----------|----------|
    | **C** | -4 to +4 | CH₄(-4), CO(+2), CO₂(+4) |
    | **N** | -3 to +5 | NH₃(-3), N₂O(+1), NO₂(+4), HNO₃(+5) |
    | **S** | -2 to +6 | H₂S(-2), SO₂(+4), H₂SO₄(+6) |
    | **P** | -3 to +5 | PH₃(-3), H₃PO₃(+3), H₃PO₄(+5) |
    | **Cl** | -1 to +7 | HCl(-1), HClO(+1), HClO₄(+7) |
    | **Mn** | +2 to +7 | MnO(+2), MnO₂(+4), KMnO₄(+7) |
    | **Cr** | +2 to +6 | CrO(+2), Cr₂O₃(+3), K₂Cr₂O₇(+6) |

    ## Redox Reactions

    **Definition:** Reactions involving change in oxidation numbers

    **Redox = Reduction + Oxidation** (occur simultaneously)

    ### Components:

    **Oxidizing agent (Oxidant):**
    - Gets reduced
    - Accepts electrons
    - Oxidation number decreases

    **Reducing agent (Reductant):**
    - Gets oxidized
    - Donates electrons
    - Oxidation number increases

    ### Example:
    **Zn + Cu²⁺ → Zn²⁺ + Cu**

    - **Zn:** 0 → +2 (oxidized, reducing agent)
    - **Cu²⁺:** +2 → 0 (reduced, oxidizing agent)

    ### Example 2:
    **2Fe²⁺ + Cl₂ → 2Fe³⁺ + 2Cl⁻**

    - **Fe²⁺:** +2 → +3 (oxidized, reducing agent)
    - **Cl₂:** 0 → -1 (reduced, oxidizing agent)

    ## Types of Redox Reactions

    ### 1. Combination:
    **C + O₂ → CO₂**
    - C: 0 → +4 (oxidized)
    - O: 0 → -2 (reduced)

    ### 2. Decomposition:
    **2KClO₃ → 2KCl + 3O₂**
    - Cl: +5 → -1 (reduced)
    - O: -2 → 0 (oxidized)

    ### 3. Displacement:
    **Zn + CuSO₄ → ZnSO₄ + Cu**
    - Zn: 0 → +2 (oxidized)
    - Cu: +2 → 0 (reduced)

    ### 4. Disproportionation:

    **Definition:** Same element simultaneously oxidized and reduced

    **Example 1:** Cl₂ + 2NaOH → NaCl + NaClO + H₂O
    - Cl in Cl₂: 0
    - Cl in NaCl: -1 (reduced)
    - Cl in NaClO: +1 (oxidized)

    **Example 2:** 3Cl₂ + 6OH⁻ → 5Cl⁻ + ClO₃⁻ + 3H₂O
    - Cl: 0 → -1 (reduced)
    - Cl: 0 → +5 (oxidized)

    **Example 3:** 2H₂O₂ → 2H₂O + O₂
    - O in H₂O₂: -1
    - O in H₂O: -2 (reduced)
    - O in O₂: 0 (oxidized)

    ### 5. Comproportionation (Reverse of Disproportionation):

    **Example:** 2Fe³⁺ + Fe → 3Fe²⁺
    - Fe³⁺: +3 → +2 (reduced)
    - Fe: 0 → +2 (oxidized)
    - Product has intermediate ON

    ## Common Oxidizing Agents

    | Agent | Half-Reaction | Use |
    |-------|---------------|-----|
    | **KMnO₄** (acidic) | MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O | Strong oxidizer |
    | **K₂Cr₂O₇** (acidic) | Cr₂O₇²⁻ + 14H⁺ + 6e⁻ → 2Cr³⁺ + 7H₂O | Titrations |
    | **Cl₂** | Cl₂ + 2e⁻ → 2Cl⁻ | Bleaching |
    | **H₂O₂** | H₂O₂ + 2H⁺ + 2e⁻ → 2H₂O | Mild oxidizer |
    | **O₃** | O₃ + 2H⁺ + 2e⁻ → O₂ + H₂O | Powerful oxidizer |

    ## Common Reducing Agents

    | Agent | Half-Reaction | Use |
    |-------|---------------|-----|
    | **Na** | Na → Na⁺ + e⁻ | Strong reducer |
    | **Zn** | Zn → Zn²⁺ + 2e⁻ | Metallurgy |
    | **H₂** | H₂ → 2H⁺ + 2e⁻ | Hydrogenation |
    | **SO₂** | SO₂ + 2H₂O → SO₄²⁻ + 4H⁺ + 2e⁻ | Bleaching |
    | **H₂S** | H₂S → S + 2H⁺ + 2e⁻ | Analysis |

    ## Solved Problems

    ### Problem 1: Oxidation number

    **Q: Find ON of Mn in KMnO₄.**

    Solution:
    - K: +1, O: -2
    - Let Mn = x
    - +1 + x + 4(-2) = 0
    - 1 + x - 8 = 0
    - **x = +7**

    ### Problem 2: Oxidation number in ion

    **Q: Find ON of S in S₂O₃²⁻.**

    Solution:
    - Let S = x
    - 2x + 3(-2) = -2
    - 2x - 6 = -2
    - 2x = 4
    - **x = +2**

    ### Problem 3: Identify oxidation/reduction

    **Q: In 2Na + Cl₂ → 2NaCl, identify oxidized and reduced species.**

    Solution:
    - Na: 0 → +1 (oxidized, reducing agent)
    - Cl₂: 0 → -1 (reduced, oxidizing agent)

    ### Problem 4: Disproportionation

    **Q: Is P₄ + 3NaOH + 3H₂O → 3NaH₂PO₂ + PH₃ a disproportionation?**

    Solution:
    - P in P₄: 0
    - P in NaH₂PO₂: +1 (oxidized)
    - P in PH₃: -3 (reduced)
    - **Yes, disproportionation** (P goes to both +1 and -3)

    ### Problem 5: Average ON

    **Q: Find average ON of C in C₃O₂.**

    Solution:
    - Let C = x
    - 3x + 2(-2) = 0
    - 3x = 4
    - **x = +4/3**

    ## IIT JEE Key Points

    1. **Free element:** ON = 0
    2. **H:** Usually +1 (except hydrides: -1)
    3. **O:** Usually -2 (peroxide: -1, superoxide: -½)
    4. **F:** Always -1
    5. **Oxidation:** Loss of e⁻, ON increases
    6. **Reduction:** Gain of e⁻, ON decreases
    7. **Oxidizing agent:** Gets reduced
    8. **Reducing agent:** Gets oxidized
    9. **Disproportionation:** Same element both oxidized and reduced
    10. **In molecules:** ΣON = 0; **In ions:** ΣON = charge

    ## Quick Reference

    | Concept | Key Point |
    |---------|-----------|
    | Oxidation | Loss of e⁻, ON ↑ |
    | Reduction | Gain of e⁻, ON ↓ |
    | Oxidizing agent | Species reduced |
    | Reducing agent | Species oxidized |
    | Disproportionation | One element → two ON |

    ## Common ON Rules

    | Element | ON | Exception |
    |---------|-----|-----------|
    | H | +1 | NaH: -1 |
    | O | -2 | H₂O₂: -1, KO₂: -½, OF₂: +2 |
    | F | -1 | None |
    | Alkali (Li, Na, K) | +1 | None |
    | Alkaline earth (Mg, Ca) | +2 | None |
    | Halogen (Cl, Br, I) | -1 | With O/F: positive |

## Key Points

- Oxidation number

- Oxidation and reduction

- Oxidizing and reducing agents
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Oxidation number', 'Oxidation and reduction', 'Oxidizing and reducing agents', 'Redox reactions', 'Disproportionation'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Balancing Redox Equations and Electrochemical Series ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Balancing Redox Equations and Electrochemical Series',
  content: <<~MARKDOWN,
# Balancing Redox Equations and Electrochemical Series 🚀

# Balancing Redox Equations and Electrochemical Series

    ## Methods for Balancing Redox Equations

    ### 1. Oxidation Number Method
    ### 2. Half-Reaction (Ion-Electron) Method ⭐

    We'll focus on the **Half-Reaction Method** (preferred for IIT JEE)

    ## Half-Reaction Method (Ion-Electron Method)

    ### Steps for Acidic Medium:

    **Step 1:** Write separate oxidation and reduction half-reactions
    **Step 2:** Balance atoms other than O and H
    **Step 3:** Balance O by adding H₂O
    **Step 4:** Balance H by adding H⁺
    **Step 5:** Balance charge by adding electrons
    **Step 6:** Multiply to equalize electrons
    **Step 7:** Add half-reactions and cancel common terms

    ### Example 1: MnO₄⁻ + Fe²⁺ → Mn²⁺ + Fe³⁺ (acidic)

    **Step 1: Separate half-reactions**

    Oxidation: Fe²⁺ → Fe³⁺
    Reduction: MnO₄⁻ → Mn²⁺

    **Step 2: Balance atoms (except O, H)**

    Already balanced

    **Step 3: Balance O with H₂O**

    Fe²⁺ → Fe³⁺
    MnO₄⁻ → Mn²⁺ + 4H₂O

    **Step 4: Balance H with H⁺**

    Fe²⁺ → Fe³⁺
    MnO₄⁻ + 8H⁺ → Mn²⁺ + 4H₂O

    **Step 5: Balance charge with electrons**

    Fe²⁺ → Fe³⁺ + e⁻ ... (1)
    MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O ... (2)

    **Step 6: Multiply to equalize electrons**

    (1) × 5: 5Fe²⁺ → 5Fe³⁺ + 5e⁻
    (2) × 1: MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O

    **Step 7: Add and simplify**

    **MnO₄⁻ + 5Fe²⁺ + 8H⁺ → Mn²⁺ + 5Fe³⁺ + 4H₂O**

    ### Example 2: Cr₂O₇²⁻ + SO₃²⁻ → Cr³⁺ + SO₄²⁻ (acidic)

    **Oxidation:** SO₃²⁻ → SO₄²⁻
    **Reduction:** Cr₂O₇²⁻ → Cr³⁺

    **Balance atoms:**
    SO₃²⁻ → SO₄²⁻
    Cr₂O₇²⁻ → 2Cr³⁺

    **Balance O with H₂O:**
    SO₃²⁻ + H₂O → SO₄²⁻
    Cr₂O₇²⁻ → 2Cr³⁺ + 7H₂O

    **Balance H with H⁺:**
    SO₃²⁻ + H₂O → SO₄²⁻ + 2H⁺
    Cr₂O₇²⁻ + 14H⁺ → 2Cr³⁺ + 7H₂O

    **Balance charge:**
    SO₃²⁻ + H₂O → SO₄²⁻ + 2H⁺ + 2e⁻ ... (1)
    Cr₂O₇²⁻ + 14H⁺ + 6e⁻ → 2Cr³⁺ + 7H₂O ... (2)

    **Multiply (1)×3:**
    3SO₃²⁻ + 3H₂O → 3SO₄²⁻ + 6H⁺ + 6e⁻

    **Add:**
    **Cr₂O₇²⁻ + 3SO₃²⁻ + 8H⁺ → 2Cr³⁺ + 3SO₄²⁻ + 4H₂O**

    ## Balancing in Basic Medium

    ### Method 1: Balance in acidic, then convert to basic

    **Steps:**
    1. Balance as if in acidic medium
    2. Add OH⁻ to both sides equal to H⁺
    3. Combine H⁺ + OH⁻ → H₂O
    4. Cancel excess H₂O

    ### Example: MnO₄⁻ + I⁻ → MnO₂ + IO₃⁻ (basic)

    **Step 1: Balance in acidic medium**

    Oxidation: I⁻ + 3H₂O → IO₃⁻ + 6H⁺ + 6e⁻
    Reduction: MnO₄⁻ + 4H⁺ + 3e⁻ → MnO₂ + 2H₂O

    Multiply reduction ×2:
    2MnO₄⁻ + 8H⁺ + 6e⁻ → 2MnO₂ + 4H₂O

    Add:
    2MnO₄⁻ + I⁻ + 8H⁺ + 3H₂O → 2MnO₂ + IO₃⁻ + 6H⁺ + 4H₂O

    Simplify:
    2MnO₄⁻ + I⁻ + 2H⁺ → 2MnO₂ + IO₃⁻ + H₂O ... (acidic)

    **Step 2: Convert to basic (add 2OH⁻ to both sides)**

    2MnO₄⁻ + I⁻ + 2H⁺ + 2OH⁻ → 2MnO₂ + IO₃⁻ + H₂O + 2OH⁻

    **Step 3: H⁺ + OH⁻ → H₂O**

    2MnO₄⁻ + I⁻ + 2H₂O → 2MnO₂ + IO₃⁻ + H₂O + 2OH⁻

    **Step 4: Simplify**

    **2MnO₄⁻ + I⁻ + H₂O → 2MnO₂ + IO₃⁻ + 2OH⁻**

    ## Method 2: Direct Balancing in Basic Medium

    **Steps:**
    1. Write half-reactions
    2. Balance atoms except O, H
    3. Balance O with H₂O
    4. Balance H with H₂O and OH⁻ (add H₂O to H-deficient side, equal OH⁻ to other)
    5. Balance charge with electrons
    6. Equalize electrons and add

    ## Complex Examples

    ### Example 3: H₂O₂ + KMnO₄ → O₂ + MnO₂ (basic)

    **Oxidation:** H₂O₂ → O₂
    **Reduction:** MnO₄⁻ → MnO₂

    **In basic:**
    H₂O₂ → O₂ + 2H⁺ + 2e⁻
    Add 2OH⁻: H₂O₂ + 2OH⁻ → O₂ + 2H₂O + 2e⁻

    MnO₄⁻ + 4H⁺ + 3e⁻ → MnO₂ + 2H₂O
    Add 4OH⁻: MnO₄⁻ + 4H₂O + 3e⁻ → MnO₂ + 2H₂O + 4OH⁻
    Simplify: MnO₄⁻ + 2H₂O + 3e⁻ → MnO₂ + 4OH⁻

    Multiply: (ox)×3, (red)×2

    3H₂O₂ + 6OH⁻ → 3O₂ + 6H₂O + 6e⁻
    2MnO₄⁻ + 4H₂O + 6e⁻ → 2MnO₂ + 8OH⁻

    Add:
    **3H₂O₂ + 2MnO₄⁻ → 3O₂ + 2MnO₂ + 2OH⁻ + 2H₂O**

    ## Electrochemical Series

    **Definition:** Arrangement of metals/electrodes in order of their standard reduction potentials

    ### Standard Hydrogen Electrode (SHE):

    **2H⁺ + 2e⁻ → H₂**
    **E° = 0.00 V** (reference)

    ### Standard Electrode Potential (E°):

    Potential of half-cell measured against SHE under standard conditions:
    - Concentration: 1 M
    - Pressure: 1 atm
    - Temperature: 25°C (298 K)

    ## Electrochemical Series (Partial)

    | Half-Reaction | E° (V) | Strength |
    |---------------|--------|----------|
    | F₂ + 2e⁻ → 2F⁻ | +2.87 | Strongest oxidizer |
    | MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O | +1.51 | |
    | Cl₂ + 2e⁻ → 2Cl⁻ | +1.36 | |
    | Cr₂O₇²⁻ + 14H⁺ + 6e⁻ → 2Cr³⁺ + 7H₂O | +1.33 | |
    | Br₂ + 2e⁻ → 2Br⁻ | +1.09 | |
    | Ag⁺ + e⁻ → Ag | +0.80 | |
    | Fe³⁺ + e⁻ → Fe²⁺ | +0.77 | |
    | I₂ + 2e⁻ → 2I⁻ | +0.54 | |
    | Cu²⁺ + 2e⁻ → Cu | +0.34 | |
    | **2H⁺ + 2e⁻ → H₂** | **0.00** | **Reference** |
    | Pb²⁺ + 2e⁻ → Pb | -0.13 | |
    | Sn²⁺ + 2e⁻ → Sn | -0.14 | |
    | Ni²⁺ + 2e⁻ → Ni | -0.25 | |
    | Fe²⁺ + 2e⁻ → Fe | -0.44 | |
    | Zn²⁺ + 2e⁻ → Zn | -0.76 | |
    | Al³⁺ + 3e⁻ → Al | -1.66 | |
    | Mg²⁺ + 2e⁻ → Mg | -2.37 | |
    | Na⁺ + e⁻ → Na | -2.71 | |
    | K⁺ + e⁻ → K | -2.93 | |
    | Li⁺ + e⁻ → Li | -3.05 | Strongest reducer |

    ## Applications of Electrochemical Series

    ### 1. Predicting Oxidizing/Reducing Strength:

    **Higher E°** → Better oxidizing agent (easily reduced)
    **Lower E°** → Better reducing agent (easily oxidized)

    **Example:**
    - F₂ (E° = +2.87) is strongest oxidizer
    - Li (E° = -3.05) is strongest reducer

    ### 2. Predicting Spontaneity:

    **For reaction:** A + B⁺ → A⁺ + B

    If E°(B⁺/B) > E°(A⁺/A), reaction is **spontaneous**

    **Example:** Can Cu reduce Ag⁺?

    Cu → Cu²⁺ + 2e⁻ (E° = -0.34 V for reverse)
    Ag⁺ + e⁻ → Ag (E° = +0.80 V)

    Since E°(Ag⁺/Ag) > E°(Cu²⁺/Cu), **YES, spontaneous**

    ### 3. Displacement Reactions:

    **Metal with lower E° can displace metal with higher E° from solution**

    **Example:** Zn + CuSO₄ → ZnSO₄ + Cu ✓
    - E°(Zn²⁺/Zn) = -0.76 < E°(Cu²⁺/Cu) = +0.34

    But: Cu + ZnSO₄ → ? ✗ (Not spontaneous)

    ### 4. Reactivity with Acids:

    **Metals with E° < 0** (below H₂) can liberate H₂ from acids

    **Example:**
    - Zn + HCl → ZnCl₂ + H₂ ✓ (E° = -0.76 V)
    - Cu + HCl → ? ✗ (E° = +0.34 V)

    ## Solved Problems

    ### Problem 1: Balance equation (acidic)

    **Q: Balance: MnO₄⁻ + H₂O₂ → Mn²⁺ + O₂ (acidic)**

    Solution:
    Oxidation: H₂O₂ → O₂ + 2H⁺ + 2e⁻
    Reduction: MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O

    Multiply: (ox)×5, (red)×2

    5H₂O₂ → 5O₂ + 10H⁺ + 10e⁻
    2MnO₄⁻ + 16H⁺ + 10e⁻ → 2Mn²⁺ + 8H₂O

    **2MnO₄⁻ + 5H₂O₂ + 6H⁺ → 2Mn²⁺ + 5O₂ + 8H₂O**

    ### Problem 2: Predict spontaneity

    **Q: Will Fe reduce Cu²⁺? E°(Cu²⁺/Cu) = +0.34 V, E°(Fe²⁺/Fe) = -0.44 V**

    Solution:
    - E°(Cu²⁺/Cu) > E°(Fe²⁺/Fe)
    - Fe has lower E°, stronger reducer
    - **YES, Fe + Cu²⁺ → Fe²⁺ + Cu is spontaneous**

    ### Problem 3: Displacement

    **Q: Which metal can displace Ag from AgNO₃: Cu or Au?**

    E°: Ag⁺/Ag = +0.80, Cu²⁺/Cu = +0.34, Au³⁺/Au = +1.50

    Solution:
    - Cu has lower E° than Ag → **Cu can displace Ag** ✓
    - Au has higher E° than Ag → Au cannot displace Ag ✗

    ## IIT JEE Key Points

    1. **Half-reaction method:** Balance O with H₂O, H with H⁺, charge with e⁻
    2. **Basic medium:** Add OH⁻ equal to H⁺, combine to H₂O
    3. **E° scale:** SHE = 0.00 V reference
    4. **Higher E°:** Better oxidizing agent
    5. **Lower E°:** Better reducing agent
    6. **Spontaneous:** Higher E° oxidizer + lower E° reducer
    7. **Displacement:** Lower E° displaces higher E°
    8. **Metals below H₂:** React with acids
    9. **F₂:** Strongest oxidizer
    10. **Li/K:** Strongest reducers

    ## Quick Formulas

    | Concept | Method |
    |---------|--------|
    | Balance redox | Half-reaction method |
    | Acidic medium | Add H⁺ and H₂O |
    | Basic medium | Convert H⁺ to H₂O using OH⁻ |
    | Spontaneity | E°(oxidizer) > E°(reducer) |
    | Displacement | Lower E° displaces higher E° |

## Key Points

- Half-reaction method

- Ion-electron method

- Balancing in acidic medium
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Half-reaction method', 'Ion-electron method', 'Balancing in acidic medium', 'Balancing in basic medium', 'Electrochemical series', 'Standard electrode potential'],
  prerequisite_ids: []
)

# === MICROLESSON 5: oxidation_numbers — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_numbers — Practice',
  content: <<~MARKDOWN,
# oxidation_numbers — Practice 🚀

2(+1) + 2x + 7(-2) = 0 → 2 + 2x - 14 = 0 → 2x = 12 → x = +6

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['oxidation_numbers'],
  prerequisite_ids: []
)

# Exercise 5.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the oxidation number of Cr in K₂Cr₂O₇?',
    answer: '6',
    explanation: '2(+1) + 2x + 7(-2) = 0 → 2 + 2x - 14 = 0 → 2x = 12 → x = +6',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 6: oxidation_numbers — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_numbers — Practice',
  content: <<~MARKDOWN,
# oxidation_numbers — Practice 🚀

In peroxides, oxygen has oxidation number -1. Each H is +1, each O is -1. Check: 2(+1) + 2(-1) = 0 ✓

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['oxidation_numbers'],
  prerequisite_ids: []
)

# Exercise 6.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the oxidation number of O in H₂O₂?',
    answer: '-1',
    explanation: 'In peroxides, oxygen has oxidation number -1. Each H is +1, each O is -1. Check: 2(+1) + 2(-1) = 0 ✓',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 7: redox_concepts — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'redox_concepts — Practice',
  content: <<~MARKDOWN,
# redox_concepts — Practice 🚀

Oxidizing agent gets reduced. Cu²⁺ gains electrons (reduced from +2 to 0), so Cu²⁺ is the oxidizing agent.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['redox_concepts'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In the reaction Zn + Cu²⁺ → Zn²⁺ + Cu, the oxidizing agent is:',
    options: ['Zn', 'Cu²⁺', 'Zn²⁺', 'Cu'],
    correct_answer: 1,
    explanation: 'Oxidizing agent gets reduced. Cu²⁺ gains electrons (reduced from +2 to 0), so Cu²⁺ is the oxidizing agent.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: disproportionation — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'disproportionation — Practice',
  content: <<~MARKDOWN,
# disproportionation — Practice 🚀

TRUE. Cl in Cl₂ (ON = 0) goes to both Cl⁻ (ON = -1, reduced) and ClO₃⁻ (ON = +5, oxidized). Same element simultaneously oxidized and reduced.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['disproportionation'],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The reaction 3Cl₂ + 6OH⁻ → 5Cl⁻ + ClO₃⁻ + 3H₂O is a disproportionation reaction.',
    answer: 'true',
    explanation: 'TRUE. Cl in Cl₂ (ON = 0) goes to both Cl⁻ (ON = -1, reduced) and ClO₃⁻ (ON = +5, oxidized). Same element simultaneously oxidized and reduced.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: oxidation_numbers — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_numbers — Practice',
  content: <<~MARKDOWN,
# oxidation_numbers — Practice 🚀

Let ON of S = x. 2x + 3(-2) = -2 → 2x - 6 = -2 → 2x = 4 → x = +2

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['oxidation_numbers'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the oxidation number of S in S₂O₃²⁻ (thiosulfate ion).',
    answer: '2',
    explanation: 'Let ON of S = x. 2x + 3(-2) = -2 → 2x - 6 = -2 → 2x = 4 → x = +2',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: electrochemical_series — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'electrochemical_series — Practice',
  content: <<~MARKDOWN,
# electrochemical_series — Practice 🚀

Higher standard electrode potential means better oxidizing agent (easily reduced). F₂ has highest E° = +2.87 V.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['electrochemical_series'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which is the strongest oxidizing agent among the following?',
    options: ['F₂ (E° = +2.87 V)', 'Cl₂ (E° = +1.36 V)', 'Br₂ (E° = +1.09 V)', 'I₂ (E° = +0.54 V)'],
    correct_answer: 0,
    explanation: 'Higher standard electrode potential means better oxidizing agent (easily reduced). F₂ has highest E° = +2.87 V.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: electrochemical_series — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'electrochemical_series — Practice',
  content: <<~MARKDOWN,
# electrochemical_series — Practice 🚀

Metal with lower E° (Zn, -0.76 V) can reduce metal ion with higher E° (Cu²⁺, +0.34 V). Zn + Cu²⁺ → Zn²⁺ + Cu is spontaneous.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['electrochemical_series'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Given: E°(Zn²⁺/Zn) = -0.76 V, E°(Cu²⁺/Cu) = +0.34 V. Which reaction is spontaneous?',
    options: ['Zn²⁺ + Cu → Zn + Cu²⁺', 'Zn + Cu²⁺ → Zn²⁺ + Cu', 'Both', 'Neither'],
    correct_answer: 1,
    explanation: 'Metal with lower E° (Zn, -0.76 V) can reduce metal ion with higher E° (Cu²⁺, +0.34 V). Zn + Cu²⁺ → Zn²⁺ + Cu is spontaneous.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 12: balancing_redox — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'balancing_redox — Practice',
  content: <<~MARKDOWN,
# balancing_redox — Practice 🚀

In half-reaction method for acidic medium, oxygen is balanced by adding H₂O molecules, and hydrogen is then balanced by adding H⁺ ions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['balancing_redox'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In acidic medium, oxygen atoms are balanced by adding _____ molecules. (Answer: H2O or water)',
    answer: 'H2O|water|H₂O',
    explanation: 'In half-reaction method for acidic medium, oxygen is balanced by adding H₂O molecules, and hydrogen is then balanced by adding H⁺ ions.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: electrochemical_series — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'electrochemical_series — Practice',
  content: <<~MARKDOWN,
# electrochemical_series — Practice 🚀

Lower (more negative) E° means better reducing agent (easily oxidized). Li has lowest E° = -3.05 V, strongest reducer.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['electrochemical_series'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following is the strongest reducing agent?',
    options: ['Li (E° = -3.05 V)', 'Na (E° = -2.71 V)', 'Zn (E° = -0.76 V)', 'Cu (E° = +0.34 V)'],
    correct_answer: 0,
    explanation: 'Lower (more negative) E° means better reducing agent (easily oxidized). Li has lowest E° = -3.05 V, strongest reducer.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 14: Oxidation Numbers and Redox Reaction Fundamentals ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Oxidation Numbers and Redox Reaction Fundamentals',
  content: <<~MARKDOWN,
# Oxidation Numbers and Redox Reaction Fundamentals 🚀

# Oxidation Numbers and Redox Reaction Fundamentals

    ## Classical Definitions

    ### Oxidation:
    - Addition of oxygen
    - Removal of hydrogen
    - Loss of electrons

    ### Reduction:
    - Removal of oxygen
    - Addition of hydrogen
    - Gain of electrons

    **Example:**
    **2Mg + O₂ → 2MgO**
    - Mg oxidized (adds O)
    - O₂ reduced

    ## Modern Definition (Electronic)

    **Oxidation:** Loss of electrons (increase in oxidation number)
    **Reduction:** Gain of electrons (decrease in oxidation number)

    **Mnemonic: OIL RIG**
    - **O**xidation **I**s **L**oss (of electrons)
    - **R**eduction **I**s **G**ain (of electrons)

    ### Example:
    **Zn + Cu²⁺ → Zn²⁺ + Cu**

    - **Oxidation:** Zn → Zn²⁺ + 2e⁻ (loss of electrons)
    - **Reduction:** Cu²⁺ + 2e⁻ → Cu (gain of electrons)

    ## Oxidation Number (Oxidation State)

    **Definition:** Charge an atom would have if all bonds were ionic

    ### Rules for Assigning Oxidation Numbers:

    **1. Free element:** Oxidation number = 0
    - Na, O₂, P₄, S₈ all have ON = 0

    **2. Monatomic ion:** ON = charge on ion
    - Na⁺: +1, Cl⁻: -1, Fe³⁺: +3, O²⁻: -2

    **3. Hydrogen:** Usually +1
    - Exception: In metal hydrides (NaH, CaH₂), H = -1

    **4. Oxygen:** Usually -2
    - Exceptions:
      - Peroxides (H₂O₂, Na₂O₂): O = -1
      - Superoxides (KO₂): O = -½
      - OF₂: O = +2 (F more electronegative)

    **5. Fluorine:** Always -1

    **6. Group 1 metals (Li, Na, K):** Always +1

    **7. Group 2 metals (Mg, Ca, Ba):** Always +2

    **8. Chlorine, Bromine, Iodine:** Usually -1
    - Exception: When bonded to O or F (e.g., ClO⁻, BrO₃⁻)

    **9. Sum of oxidation numbers:**
    - **Neutral molecule:** Sum = 0
    - **Ion:** Sum = charge on ion

    ## Examples of Oxidation Number Calculation

    ### Example 1: H₂SO₄

    Let ON of S = x
    - 2(+1) + x + 4(-2) = 0
    - 2 + x - 8 = 0
    - x = +6

    **S in H₂SO₄ has ON = +6**

    ### Example 2: Cr₂O₇²⁻

    Let ON of Cr = x
    - 2x + 7(-2) = -2
    - 2x - 14 = -2
    - 2x = 12
    - x = +6

    **Cr in Cr₂O₇²⁻ has ON = +6**

    ### Example 3: NH₃

    Let ON of N = x
    - x + 3(+1) = 0
    - x = -3

    **N in NH₃ has ON = -3**

    ### Example 4: H₂O₂

    - Each H = +1
    - Each O = -1 (peroxide)
    - Check: 2(+1) + 2(-1) = 0 ✓

    ### Example 5: Fe₃O₄

    Let ON of Fe = x
    - 3x + 4(-2) = 0
    - 3x = 8
    - x = 8/3

    **Fe in Fe₃O₄ has average ON = +8/3**

    (Actually Fe₃O₄ = FeO·Fe₂O₃, contains Fe²⁺ and Fe³⁺)

    ## Variable Oxidation States

    Many elements show multiple oxidation states:

    | Element | Common ON | Examples |
    |---------|-----------|----------|
    | **C** | -4 to +4 | CH₄(-4), CO(+2), CO₂(+4) |
    | **N** | -3 to +5 | NH₃(-3), N₂O(+1), NO₂(+4), HNO₃(+5) |
    | **S** | -2 to +6 | H₂S(-2), SO₂(+4), H₂SO₄(+6) |
    | **P** | -3 to +5 | PH₃(-3), H₃PO₃(+3), H₃PO₄(+5) |
    | **Cl** | -1 to +7 | HCl(-1), HClO(+1), HClO₄(+7) |
    | **Mn** | +2 to +7 | MnO(+2), MnO₂(+4), KMnO₄(+7) |
    | **Cr** | +2 to +6 | CrO(+2), Cr₂O₃(+3), K₂Cr₂O₇(+6) |

    ## Redox Reactions

    **Definition:** Reactions involving change in oxidation numbers

    **Redox = Reduction + Oxidation** (occur simultaneously)

    ### Components:

    **Oxidizing agent (Oxidant):**
    - Gets reduced
    - Accepts electrons
    - Oxidation number decreases

    **Reducing agent (Reductant):**
    - Gets oxidized
    - Donates electrons
    - Oxidation number increases

    ### Example:
    **Zn + Cu²⁺ → Zn²⁺ + Cu**

    - **Zn:** 0 → +2 (oxidized, reducing agent)
    - **Cu²⁺:** +2 → 0 (reduced, oxidizing agent)

    ### Example 2:
    **2Fe²⁺ + Cl₂ → 2Fe³⁺ + 2Cl⁻**

    - **Fe²⁺:** +2 → +3 (oxidized, reducing agent)
    - **Cl₂:** 0 → -1 (reduced, oxidizing agent)

    ## Types of Redox Reactions

    ### 1. Combination:
    **C + O₂ → CO₂**
    - C: 0 → +4 (oxidized)
    - O: 0 → -2 (reduced)

    ### 2. Decomposition:
    **2KClO₃ → 2KCl + 3O₂**
    - Cl: +5 → -1 (reduced)
    - O: -2 → 0 (oxidized)

    ### 3. Displacement:
    **Zn + CuSO₄ → ZnSO₄ + Cu**
    - Zn: 0 → +2 (oxidized)
    - Cu: +2 → 0 (reduced)

    ### 4. Disproportionation:

    **Definition:** Same element simultaneously oxidized and reduced

    **Example 1:** Cl₂ + 2NaOH → NaCl + NaClO + H₂O
    - Cl in Cl₂: 0
    - Cl in NaCl: -1 (reduced)
    - Cl in NaClO: +1 (oxidized)

    **Example 2:** 3Cl₂ + 6OH⁻ → 5Cl⁻ + ClO₃⁻ + 3H₂O
    - Cl: 0 → -1 (reduced)
    - Cl: 0 → +5 (oxidized)

    **Example 3:** 2H₂O₂ → 2H₂O + O₂
    - O in H₂O₂: -1
    - O in H₂O: -2 (reduced)
    - O in O₂: 0 (oxidized)

    ### 5. Comproportionation (Reverse of Disproportionation):

    **Example:** 2Fe³⁺ + Fe → 3Fe²⁺
    - Fe³⁺: +3 → +2 (reduced)
    - Fe: 0 → +2 (oxidized)
    - Product has intermediate ON

    ## Common Oxidizing Agents

    | Agent | Half-Reaction | Use |
    |-------|---------------|-----|
    | **KMnO₄** (acidic) | MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O | Strong oxidizer |
    | **K₂Cr₂O₇** (acidic) | Cr₂O₇²⁻ + 14H⁺ + 6e⁻ → 2Cr³⁺ + 7H₂O | Titrations |
    | **Cl₂** | Cl₂ + 2e⁻ → 2Cl⁻ | Bleaching |
    | **H₂O₂** | H₂O₂ + 2H⁺ + 2e⁻ → 2H₂O | Mild oxidizer |
    | **O₃** | O₃ + 2H⁺ + 2e⁻ → O₂ + H₂O | Powerful oxidizer |

    ## Common Reducing Agents

    | Agent | Half-Reaction | Use |
    |-------|---------------|-----|
    | **Na** | Na → Na⁺ + e⁻ | Strong reducer |
    | **Zn** | Zn → Zn²⁺ + 2e⁻ | Metallurgy |
    | **H₂** | H₂ → 2H⁺ + 2e⁻ | Hydrogenation |
    | **SO₂** | SO₂ + 2H₂O → SO₄²⁻ + 4H⁺ + 2e⁻ | Bleaching |
    | **H₂S** | H₂S → S + 2H⁺ + 2e⁻ | Analysis |

    ## Solved Problems

    ### Problem 1: Oxidation number

    **Q: Find ON of Mn in KMnO₄.**

    Solution:
    - K: +1, O: -2
    - Let Mn = x
    - +1 + x + 4(-2) = 0
    - 1 + x - 8 = 0
    - **x = +7**

    ### Problem 2: Oxidation number in ion

    **Q: Find ON of S in S₂O₃²⁻.**

    Solution:
    - Let S = x
    - 2x + 3(-2) = -2
    - 2x - 6 = -2
    - 2x = 4
    - **x = +2**

    ### Problem 3: Identify oxidation/reduction

    **Q: In 2Na + Cl₂ → 2NaCl, identify oxidized and reduced species.**

    Solution:
    - Na: 0 → +1 (oxidized, reducing agent)
    - Cl₂: 0 → -1 (reduced, oxidizing agent)

    ### Problem 4: Disproportionation

    **Q: Is P₄ + 3NaOH + 3H₂O → 3NaH₂PO₂ + PH₃ a disproportionation?**

    Solution:
    - P in P₄: 0
    - P in NaH₂PO₂: +1 (oxidized)
    - P in PH₃: -3 (reduced)
    - **Yes, disproportionation** (P goes to both +1 and -3)

    ### Problem 5: Average ON

    **Q: Find average ON of C in C₃O₂.**

    Solution:
    - Let C = x
    - 3x + 2(-2) = 0
    - 3x = 4
    - **x = +4/3**

    ## IIT JEE Key Points

    1. **Free element:** ON = 0
    2. **H:** Usually +1 (except hydrides: -1)
    3. **O:** Usually -2 (peroxide: -1, superoxide: -½)
    4. **F:** Always -1
    5. **Oxidation:** Loss of e⁻, ON increases
    6. **Reduction:** Gain of e⁻, ON decreases
    7. **Oxidizing agent:** Gets reduced
    8. **Reducing agent:** Gets oxidized
    9. **Disproportionation:** Same element both oxidized and reduced
    10. **In molecules:** ΣON = 0; **In ions:** ΣON = charge

    ## Quick Reference

    | Concept | Key Point |
    |---------|-----------|
    | Oxidation | Loss of e⁻, ON ↑ |
    | Reduction | Gain of e⁻, ON ↓ |
    | Oxidizing agent | Species reduced |
    | Reducing agent | Species oxidized |
    | Disproportionation | One element → two ON |

    ## Common ON Rules

    | Element | ON | Exception |
    |---------|-----|-----------|
    | H | +1 | NaH: -1 |
    | O | -2 | H₂O₂: -1, KO₂: -½, OF₂: +2 |
    | F | -1 | None |
    | Alkali (Li, Na, K) | +1 | None |
    | Alkaline earth (Mg, Ca) | +2 | None |
    | Halogen (Cl, Br, I) | -1 | With O/F: positive |

## Key Points

- Oxidation number

- Oxidation and reduction

- Oxidizing and reducing agents
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Oxidation number', 'Oxidation and reduction', 'Oxidizing and reducing agents', 'Redox reactions', 'Disproportionation'],
  prerequisite_ids: []
)

puts "✓ Created 14 microlessons for Redox Reactions"

# AUTO-GENERATED from module_10_electrochemistry.rb
puts "Creating Microlessons for Electrochemistry..."

module_var = CourseModule.find_by(slug: 'electrochemistry')

# === MICROLESSON 1: cell_potential — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'cell_potential — Practice',
  content: <<~MARKDOWN,
# cell_potential — Practice 🚀

EMF depends on: (1) nature of electrodes (E° value), (2) concentration (Nernst equation), (3) temperature (RT in Nernst). Size of electrodes does NOT affect EMF, only current capacity.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['cell_potential'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which factors affect the EMF of a galvanic cell?',
    options: ['Temperature', 'Concentration of electrolytes', 'Nature of electrodes', 'Size of electrodes'],
    correct_answer: 2,
    explanation: 'EMF depends on: (1) nature of electrodes (E° value), (2) concentration (Nernst equation), (3) temperature (RT in Nernst). Size of electrodes does NOT affect EMF, only current capacity.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: Electrolysis, Faraday\ ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Electrolysis, Faraday\',
  content: <<~MARKDOWN,
# Electrolysis, Faraday\ 🚀

# Electrolysis, Faraday's Laws and Electrolytic Cells

    ## Electrolysis

    **Definition:** Chemical decomposition using electrical energy (non-spontaneous reaction)

    **Electrolytic Cell:** Electrical → Chemical energy

    ### Differences: Galvanic vs Electrolytic

    | Property | Galvanic | Electrolytic |
    |----------|----------|--------------|
    | Energy | Chemical → Electrical | Electrical → Chemical |
    | Reaction | Spontaneous | Non-spontaneous |
    | E°cell | Positive | Negative (needs external V) |
    | Anode | Negative | Positive (connected to +ve) |
    | Cathode | Positive | Negative (connected to -ve) |
    | Example | Battery | Electrolysis of water |

    **Note:** In BOTH cells:
    - Oxidation at anode
    - Reduction at cathode

    ## Electrolysis Examples

    ### 1. Electrolysis of Molten NaCl:

    **Cathode (reduction):** Na⁺ + e⁻ → Na(l)
    **Anode (oxidation):** 2Cl⁻ → Cl₂(g) + 2e⁻

    **Overall:** 2NaCl(l) → 2Na(l) + Cl₂(g)

    Uses: **Downs process** for Na production

    ### 2. Electrolysis of Water (acidified):

    **Cathode:** 2H⁺ + 2e⁻ → H₂(g) (or 2H₂O + 2e⁻ → H₂ + 2OH⁻)
    **Anode:** 2H₂O → O₂(g) + 4H⁺ + 4e⁻ (or 4OH⁻ → O₂ + 2H₂O + 4e⁻)

    **Overall:** 2H₂O → 2H₂(g) + O₂(g)

    **Ratio:** 2 volumes H₂ : 1 volume O₂

    ### 3. Electrolysis of Aqueous NaCl (Brine):

    **Cathode:** 2H₂O + 2e⁻ → H₂(g) + 2OH⁻
    **Anode:** 2Cl⁻ → Cl₂(g) + 2e⁻

    **Overall:** 2NaCl(aq) + 2H₂O → 2NaOH(aq) + H₂(g) + Cl₂(g)

    **Chlor-alkali process:** Produces NaOH, H₂, Cl₂

    ### 4. Electrolysis of CuSO₄ with Cu electrodes:

    **Cathode (Cu):** Cu²⁺ + 2e⁻ → Cu (deposition)
    **Anode (Cu):** Cu → Cu²⁺ + 2e⁻ (dissolution)

    Net: **Cu transfers from anode to cathode**

    Uses: **Electrorefining of copper**

    ## Preferential Discharge

    When multiple ions present, which one is discharged?

    ### At Cathode (reduction):

    **Order of preference:** (easier to reduce first)

    **Au³⁺ > Ag⁺ > Cu²⁺ > H⁺ > Pb²⁺ > Fe²⁺ > Zn²⁺ > Na⁺ > K⁺**

    (Higher E° reduces first)

    ### At Anode (oxidation):

    **Order of preference:** (easier to oxidize first)

    **S²⁻ > I⁻ > Br⁻ > Cl⁻ > OH⁻ > NO₃⁻ > SO₄²⁻**

    (Lower E° oxidizes first)

    ### Examples:

    **1. Electrolysis of AgNO₃(aq):**
    - Cathode: Ag⁺ + e⁻ → Ag (Ag⁺ preferred over H⁺)
    - Anode: 2H₂O → O₂ + 4H⁺ + 4e⁻ (NO₃⁻ not oxidized)

    **2. Electrolysis of CuSO₄(aq) with Pt electrodes:**
    - Cathode: Cu²⁺ + 2e⁻ → Cu (Cu²⁺ preferred over H⁺)
    - Anode: 2H₂O → O₂ + 4H⁺ + 4e⁻ (SO₄²⁻ not oxidized)

    ## Faraday's Laws of Electrolysis

    ### First Law:

    **Statement:** Mass deposited/liberated is directly proportional to quantity of electricity passed

    **m ∝ Q**
    **m = ZQ** or **m = Zit**

    Where:
    - m = mass deposited (g)
    - Q = charge (coulombs, C)
    - i = current (amperes, A)
    - t = time (seconds, s)
    - Z = electrochemical equivalent (g/C)

    ### Second Law:

    **Statement:** When same quantity of electricity passes through different electrolytes, masses deposited are proportional to their equivalent weights

    **m₁/m₂ = E₁/E₂**

    Where E = equivalent weight

    ### Combined Form:

    **m = (E × i × t) / (96,500)**

    Or: **m = (E × Q) / F**

    Or: **m = (M × i × t) / (n × F)**

    Where:
    - M = molar mass (g/mol)
    - n = number of electrons
    - F = 96,500 C/mol (Faraday constant)
    - E = M/n = equivalent weight

    ## Electrochemical Equivalent (Z)

    **Definition:** Mass deposited by 1 coulomb of charge

    **Z = E/F = M/(nF)**

    Where:
    - E = equivalent weight
    - M = molar mass
    - n = charge on ion
    - F = 96,500 C/mol

    ### Example: For Cu²⁺

    M = 63.5 g/mol, n = 2

    Z = 63.5/(2 × 96,500) = 3.29 × 10⁻⁴ g/C

    ## Moles of Electrons

    **Number of moles of electrons = Q/F = it/F**

    **Number of electrons = Q/e** (where e = 1.6 × 10⁻¹⁹ C)

    ## Quantitative Calculations

    ### Problem 1: Mass deposited

    **Q: A current of 5 A is passed through CuSO₄ for 30 minutes. Calculate mass of Cu deposited. (Cu = 63.5, n = 2)**

    Solution:
    - i = 5 A
    - t = 30 × 60 = 1800 s
    - Q = it = 5 × 1800 = 9000 C

    m = MQ/(nF) = (63.5 × 9000)/(2 × 96,500)
    m = 571,500/193,000 = **2.96 g**

    ### Problem 2: Time required

    **Q: How long should 2 A current be passed to deposit 1.08 g Ag? (Ag = 108)**

    Solution:
    - m = 1.08 g
    - M = 108, n = 1
    - i = 2 A

    m = Mit/(nF)
    1.08 = (108 × 2 × t)/(1 × 96,500)
    t = (1.08 × 96,500)/216 = **482.5 s ≈ 8 min**

    ### Problem 3: Current

    **Q: What current is needed to deposit 3.17 g Cu in 1 hour? (Cu = 63.5, n = 2)**

    Solution:
    - m = 3.17 g
    - t = 3600 s

    m = Mit/(nF)
    3.17 = (63.5 × i × 3600)/(2 × 96,500)
    i = (3.17 × 2 × 96,500)/(63.5 × 3600)
    i = **2.67 A**

    ### Problem 4: Second law

    **Q: Same charge deposits 0.54 g Ag and x g Cu. Find x. (Ag = 108, Cu = 63.5)**

    Solution:
    - For Ag: E₁ = 108/1 = 108
    - For Cu: E₂ = 63.5/2 = 31.75

    m₁/m₂ = E₁/E₂
    0.54/x = 108/31.75
    x = (0.54 × 31.75)/108 = **0.159 g**

    ## Applications of Electrolysis

    ### 1. Electroplating:

    **Process:** Coating one metal with another using electrolysis

    **Example:** Silver plating on spoon
    - Electrolyte: AgNO₃ solution
    - Anode: Pure Ag
    - Cathode: Spoon (to be plated)
    - Reaction: Ag from anode deposits on cathode

    **Uses:** Protection, decoration, electrical contacts

    ### 2. Electrorefining:

    **Process:** Purification of metals

    **Example:** Refining copper
    - Electrolyte: CuSO₄ + H₂SO₄
    - Anode: Impure Cu
    - Cathode: Pure Cu strip
    - Impurities fall as **anode mud** (contains Ag, Au, Pt)

    ### 3. Extraction of Metals:

    **Electrolytic reduction:** Na, K, Ca, Mg, Al from molten salts

    **Example:** **Hall-Heroult process** for Al
    - Al₂O₃ dissolved in molten cryolite (Na₃AlF₆)
    - Cathode: 2Al₂O₃ + 3C → 4Al + 3CO₂
    - Anode: Carbon, gets oxidized

    ### 4. Anodizing:

    **Process:** Forming protective oxide layer on Al

    **5. Manufacturing:**
    - Chlorine, NaOH (chlor-alkali)
    - H₂ and O₂ (water electrolysis)

    ## Solved Electrolysis Problems

    ### Problem 5: Volume of gas

    **Q: Calculate volume of H₂ at STP liberated when 0.1 A current is passed through water for 30 min.**

    Solution:
    - Q = it = 0.1 × 30 × 60 = 180 C
    - 2H⁺ + 2e⁻ → H₂
    - 2 mol e⁻ → 1 mol H₂
    - 2F → 22.4 L at STP

    Volume = (Q/F) × (22.4/2)
    V = (180/96,500) × 11.2
    V = **0.0209 L = 20.9 mL**

    ### Problem 6: Multiple electrolytes

    **Q: Same current passes through AgNO₃ and CuSO₄. If 1.08 g Ag deposits, find Cu deposited.**

    Solution:
    - Ag: M = 108, n = 1, E = 108
    - Cu: M = 63.5, n = 2, E = 31.75

    m(Cu)/m(Ag) = E(Cu)/E(Ag)
    m(Cu)/1.08 = 31.75/108
    m(Cu) = **0.317 g**

    ## IIT JEE Key Points

    1. **Electrolysis:** Electrical → Chemical (non-spontaneous)
    2. **Both cells:** Oxidation at anode, reduction at cathode
    3. **Faraday I:** m = Zit = ZQ
    4. **Faraday II:** m₁/m₂ = E₁/E₂
    5. **m = Mit/(nF)** or **m = MQ/(nF)**
    6. **F = 96,500 C/mol**
    7. **Z = M/(nF)** = electrochemical equivalent
    8. **Preferential discharge:** Higher E° reduces first
    9. **Electrorefining:** Purifies metals
    10. **Electroplating:** Coating metals

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Mass deposited | m = Mit/(nF) |
    | Charge | Q = it |
    | ECE (Z) | M/(nF) |
    | Second law | m₁/m₂ = E₁/E₂ |
    | Moles of e⁻ | Q/F or it/F |

    ## Important Values

    - **F** = 96,500 C/mol
    - **1 mole e⁻** = 96,500 C
    - **STP:** 22.4 L/mol

## Key Points

- Electrolysis

- Faradays laws

- Electrochemical equivalent
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Electrolysis', 'Faradays laws', 'Electrochemical equivalent', 'Preferential discharge', 'Electrolytic refining', 'Electroplating'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Conductance, Kohlrausch\ ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Conductance, Kohlrausch\',
  content: <<~MARKDOWN,
# Conductance, Kohlrausch\ 🚀

# Conductance, Kohlrausch's Law and Electrochemical Devices

    ## Electrical Conductance

    **Conductance (G):** Ability to conduct electricity

    **G = 1/R** (reciprocal of resistance)

    **Units:** Siemens (S) or mho (℧) or Ω⁻¹

    ### Ohm's Law:

    **V = IR** or **R = V/I**

    **Conductance: G = I/V = 1/R**

    ## Specific Conductance (κ - kappa)

    **Definition:** Conductance of 1 cm³ solution between electrodes 1 cm apart

    **κ = (1/R) × (l/A) = G × (l/A)**

    Where:
    - l = distance between electrodes (cm)
    - A = area of electrodes (cm²)
    - l/A = cell constant (G*)

    **κ = G × G***

    **Units:** S cm⁻¹ or Ω⁻¹ cm⁻¹

    ### Cell Constant (G*):

    **G* = l/A** (depends on geometry of cell)

    **Units:** cm⁻¹

    Determined using solution of known κ (KCl solution)

    ## Molar Conductivity (Λm)

    **Definition:** Conductance of solution containing 1 mole of electrolyte placed between electrodes 1 cm apart

    **Λm = κ × 1000 / M**

    Where:
    - κ = specific conductance (S cm⁻¹)
    - M = molarity (mol/L)
    - 1000 = conversion factor (1 L = 1000 cm³)

    **Units:** S cm² mol⁻¹

    ### Equivalent Conductivity (Λeq):

    **Λeq = κ × 1000 / N**

    Where N = normality

    **Relationship:** Λm = n × Λeq (n = number of charges)

    ## Variation of Conductivity with Dilution

    ### Specific Conductance (κ):

    **Decreases with dilution** (fewer ions per unit volume)

    ### Molar Conductivity (Λm):

    **Increases with dilution** (less inter-ionic interactions)

    **Strong electrolytes:** Λm increases slightly with dilution
    **Weak electrolytes:** Λm increases sharply with dilution

    At **infinite dilution:** Λm = Λm° (maximum value)

    ## Kohlrausch's Law of Independent Migration

    **Statement:** At infinite dilution, molar conductivity is sum of contributions from individual ions

    **Λm° = λ₊° + λ₋°**

    Where:
    - λ₊° = limiting molar conductivity of cation
    - λ₋° = limiting molar conductivity of anion

    ### For Salt:

    **Λm°(NaCl) = λ°(Na⁺) + λ°(Cl⁻)**

    ### For Acid/Base:

    **Λm°(HCl) = λ°(H⁺) + λ°(Cl⁻)**
    **Λm°(NaOH) = λ°(Na⁺) + λ°(OH⁻)**

    ## Applications of Kohlrausch's Law

    ### 1. Calculate Λm° of weak electrolyte:

    **Example:** Find Λm°(CH₃COOH)

    **Method:**
    Λm°(CH₃COOH) = λ°(CH₃COO⁻) + λ°(H⁺)

    Cannot measure directly, so use:

    **Λm°(CH₃COOH) = Λm°(CH₃COONa) + Λm°(HCl) - Λm°(NaCl)**

    Proof:
    - Λm°(CH₃COONa) = λ°(CH₃COO⁻) + λ°(Na⁺)
    - Λm°(HCl) = λ°(H⁺) + λ°(Cl⁻)
    - Λm°(NaCl) = λ°(Na⁺) + λ°(Cl⁻)

    Adding first two and subtracting third:
    = λ°(CH₃COO⁻) + λ°(H⁺) ✓

    ### 2. Degree of Dissociation (α):

    For weak electrolyte:

    **α = Λm / Λm°**

    Where:
    - Λm = molar conductivity at given concentration
    - Λm° = limiting molar conductivity

    ### 3. Dissociation Constant (Ka):

    For weak acid HA:

    **Ka = (Cα²)/(1-α) ≈ Cα²** (if α << 1)

    Since α = Λm/Λm°:

    **Ka = C(Λm/Λm°)² / (1 - Λm/Λm°)**

    ## Numerical Examples

    ### Problem 1: Calculate κ

    **Q: R = 100 Ω, G* = 0.5 cm⁻¹. Calculate κ.**

    Solution:
    - G = 1/R = 1/100 = 0.01 S
    - κ = G × G* = 0.01 × 0.5
    - **κ = 0.005 S cm⁻¹**

    ### Problem 2: Calculate Λm

    **Q: κ = 0.0025 S cm⁻¹, M = 0.1 M. Calculate Λm.**

    Solution:
    Λm = (κ × 1000)/M = (0.0025 × 1000)/0.1
    **Λm = 25 S cm² mol⁻¹**

    ### Problem 3: Kohlrausch's law

    **Q: Calculate Λm°(NH₄OH) given:**
    - Λm°(NH₄Cl) = 150 S cm² mol⁻¹
    - Λm°(NaOH) = 248 S cm² mol⁻¹
    - Λm°(NaCl) = 126 S cm² mol⁻¹

    Solution:
    Λm°(NH₄OH) = Λm°(NH₄Cl) + Λm°(NaOH) - Λm°(NaCl)
    = 150 + 248 - 126
    **= 272 S cm² mol⁻¹**

    ### Problem 4: Degree of dissociation

    **Q: For CH₃COOH, Λm = 18 S cm² mol⁻¹, Λm° = 390 S cm² mol⁻¹. Find α.**

    Solution:
    α = Λm/Λm° = 18/390
    **α = 0.046 or 4.6%**

    ### Problem 5: Calculate Ka

    **Q: For 0.01 M CH₃COOH, α = 0.04, find Ka.**

    Solution:
    Ka = Cα²/(1-α) = (0.01 × 0.04²)/(1-0.04)
    Ka = (0.01 × 0.0016)/0.96
    **Ka = 1.67 × 10⁻⁵**

    ## Batteries (Electrochemical Cells)

    ### Primary Batteries (Non-rechargeable):

    **1. Dry Cell (Leclanche Cell):**

    - **Anode:** Zn container
    - **Cathode:** Carbon rod
    - **Electrolyte:** NH₄Cl + ZnCl₂ paste + MnO₂

    Reactions:
    - Anode: Zn → Zn²⁺ + 2e⁻
    - Cathode: MnO₂ + NH₄⁺ + e⁻ → MnO(OH) + NH₃

    **Voltage:** ~1.5 V
    **Uses:** Flashlights, remote controls

    **2. Mercury Cell:**

    - **Anode:** Zn-Hg amalgam
    - **Cathode:** HgO + carbon
    - **Electrolyte:** KOH paste

    Reactions:
    - Anode: Zn + 2OH⁻ → ZnO + H₂O + 2e⁻
    - Cathode: HgO + H₂O + 2e⁻ → Hg + 2OH⁻

    **Voltage:** 1.35 V (constant)
    **Uses:** Hearing aids, watches

    ### Secondary Batteries (Rechargeable):

    **1. Lead-Acid Battery:**

    - **Anode:** Pb
    - **Cathode:** PbO₂
    - **Electrolyte:** 38% H₂SO₄

    **Discharge:**
    - Anode: Pb + SO₄²⁻ → PbSO₄ + 2e⁻
    - Cathode: PbO₂ + 4H⁺ + SO₄²⁻ + 2e⁻ → PbSO₄ + 2H₂O
    - Overall: Pb + PbO₂ + 2H₂SO₄ → 2PbSO₄ + 2H₂O

    **Charge:** Reverse reaction

    **Voltage:** 2 V per cell (6 cells = 12 V battery)
    **Uses:** Automobiles

    **2. Nickel-Cadmium (NiCd) Battery:**

    - **Anode:** Cd
    - **Cathode:** NiO(OH)
    - **Electrolyte:** KOH

    **Voltage:** 1.4 V
    **Uses:** Electronic devices

    **3. Lithium-ion Battery:**

    - **Anode:** Graphite (Li intercalated)
    - **Cathode:** LiCoO₂
    - **Electrolyte:** Lithium salt in organic solvent

    **Voltage:** 3.7 V
    **Uses:** Mobile phones, laptops, EVs
    **Advantages:** High energy density, lightweight

    ## Fuel Cells

    **Definition:** Continuously converts chemical energy to electrical energy as long as fuel is supplied

    ### Hydrogen-Oxygen Fuel Cell:

    - **Anode:** H₂ → 2H⁺ + 2e⁻
    - **Cathode:** O₂ + 4H⁺ + 4e⁻ → 2H₂O
    - **Overall:** 2H₂ + O₂ → 2H₂O

    **Electrolyte:** KOH (aqueous) or polymer membrane
    **Efficiency:** 60-70% (higher than combustion)
    **Byproduct:** Water only (clean)

    **Uses:** Space programs, vehicles, stationary power

    **Advantages:**
    - High efficiency
    - Low pollution
    - Continuous operation

    ## Corrosion

    **Definition:** Electrochemical degradation of metals

    ### Rusting of Iron:

    **Anodic area:** Fe → Fe²⁺ + 2e⁻
    **Cathodic area:** O₂ + 4H⁺ + 4e⁻ → 2H₂O (acidic)
    or O₂ + 2H₂O + 4e⁻ → 4OH⁻ (neutral/basic)

    **Overall:** 2Fe + O₂ + 4H⁺ → 2Fe²⁺ + 2H₂O
    Then: 4Fe²⁺ + O₂ + 4H₂O → 2Fe₂O₃·xH₂O (rust)

    **Factors enhancing corrosion:**
    - Moisture, oxygen
    - Acidic environment
    - Salts (electrolytes)
    - Impurities in metal

    ### Prevention of Corrosion:

    1. **Painting/coating:** Barrier against O₂, H₂O
    2. **Galvanization:** Coating with Zn (sacrificial protection)
    3. **Electroplating:** Ni, Cr plating
    4. **Alloying:** Stainless steel (Cr, Ni added)
    5. **Cathodic protection:** Connect to more active metal
    6. **Passivation:** Formation of oxide layer (Al₂O₃ on Al)

    ## IIT JEE Key Points

    1. **Conductance G = 1/R**
    2. **κ = G × (l/A) = G × G***
    3. **Λm = κ × 1000/M**
    4. **Λm increases with dilution**
    5. **Kohlrausch:** Λm° = λ₊° + λ₋°
    6. **α = Λm/Λm°** (weak electrolyte)
    7. **Primary battery:** Non-rechargeable
    8. **Secondary battery:** Rechargeable
    9. **Fuel cell:** Continuous operation
    10. **Corrosion:** Electrochemical oxidation

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Conductance | G = 1/R |
    | Specific conductance | κ = G × G* |
    | Molar conductivity | Λm = κ × 1000/M |
    | Kohlrausch's law | Λm° = λ₊° + λ₋° |
    | Degree of dissociation | α = Λm/Λm° |

    ## Important Facts

    - **H⁺** and **OH⁻** have highest conductivities
    - **Strong electrolytes:** Complete dissociation
    - **Weak electrolytes:** Partial dissociation
    - **Λm° (weak):** Use Kohlrausch's law

## Key Points

- Conductance

- Molar conductivity

- Kohlrauschs law
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Conductance', 'Molar conductivity', 'Kohlrauschs law', 'Batteries', 'Fuel cells', 'Corrosion'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Galvanic Cells, EMF and Nernst Equation ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Galvanic Cells, EMF and Nernst Equation',
  content: <<~MARKDOWN,
# Galvanic Cells, EMF and Nernst Equation 🚀

# Galvanic Cells, EMF and Nernst Equation

    ## Electrochemical Cells

    **Electrochemical cell:** Device that converts chemical energy to electrical energy (or vice versa)

    ### Types:

    **1. Galvanic (Voltaic) Cell:** Chemical → Electrical energy
    - Spontaneous redox reaction
    - Generates electricity
    - Example: Daniell cell

    **2. Electrolytic Cell:** Electrical → Chemical energy
    - Non-spontaneous reaction
    - Requires external voltage
    - Example: Electrolysis of water

    ## Galvanic Cell (Daniell Cell)

    ### Construction:

    **Anode (oxidation):** Zn rod in ZnSO₄ solution
    **Cathode (reduction):** Cu rod in CuSO₄ solution
    **Salt bridge:** KCl or KNO₃ solution in agar gel

    ### Reactions:

    **Anode (oxidation):** Zn(s) → Zn²⁺(aq) + 2e⁻
    **Cathode (reduction):** Cu²⁺(aq) + 2e⁻ → Cu(s)

    **Overall:** Zn(s) + Cu²⁺(aq) → Zn²⁺(aq) + Cu(s)

    ### Important Points:

    - **Anode:** Negative terminal, oxidation occurs
    - **Cathode:** Positive terminal, reduction occurs
    - **Electrons flow:** Anode → Cathode (external circuit)
    - **Anions move:** Toward anode (in solution)
    - **Cations move:** Toward cathode (in solution)

    **Mnemonic: AN OX and RED CAT**
    - **AN**ode **OX**idation
    - **RED**uction **CAT**hode

    ### Salt Bridge Function:

    1. **Completes circuit** (allows ion flow)
    2. **Maintains electrical neutrality**
    3. **Prevents mixing** of solutions
    4. Uses **inert electrolyte** (KCl, KNO₃, NH₄NO₃)

    ## Cell Notation (IUPAC Convention)

    **Anode | Anode solution || Cathode solution | Cathode**

    **Example:** Daniell cell
    **Zn(s) | Zn²⁺(aq) || Cu²⁺(aq) | Cu(s)**

    **Notes:**
    - Single line (|): Phase boundary
    - Double line (||): Salt bridge
    - Anode (oxidation) on left
    - Cathode (reduction) on right

    ### More Examples:

    **1. Pt | H₂(g) | H⁺(aq) || Ag⁺(aq) | Ag(s)**

    Anode: H₂ → 2H⁺ + 2e⁻
    Cathode: Ag⁺ + e⁻ → Ag

    **2. Zn(s) | Zn²⁺(aq) || Ag⁺(aq) | Ag(s)**

    Anode: Zn → Zn²⁺ + 2e⁻
    Cathode: Ag⁺ + e⁻ → Ag

    ## Standard Electrode Potential (E°)

    **Definition:** Potential of half-cell measured against Standard Hydrogen Electrode (SHE) under standard conditions

    **Standard conditions:**
    - Temperature: 25°C (298 K)
    - Concentration: 1 M
    - Pressure: 1 atm (for gases)

    ### Standard Hydrogen Electrode (SHE):

    **2H⁺(aq, 1M) + 2e⁻ → H₂(g, 1 atm)**
    **E° = 0.00 V** (reference)

    Construction: Pt electrode in 1M HCl, H₂ gas at 1 atm

    ## Standard Cell Potential (E°cell)

    **E°cell = E°cathode - E°anode**

    Or: **E°cell = E°reduction - E°oxidation**

    ### Important:
    - Use **reduction potentials** from tables
    - For oxidation half-cell, use **same E°** (don't reverse sign for calculation)
    - **Positive E°cell:** Spontaneous reaction

    ### Example: Daniell Cell

    **Cathode:** Cu²⁺ + 2e⁻ → Cu, E° = +0.34 V
    **Anode:** Zn → Zn²⁺ + 2e⁻, E°(Zn²⁺/Zn) = -0.76 V

    **E°cell = E°cathode - E°anode**
    **E°cell = 0.34 - (-0.76) = 1.10 V**

    ## Relationship Between ΔG° and E°cell

    **ΔG° = -nFE°cell**

    Where:
    - n = number of electrons transferred
    - F = Faraday constant = 96,500 C/mol
    - E°cell = standard cell potential (V)
    - ΔG° = standard Gibbs free energy (J)

    **Spontaneity:**
    - **E°cell > 0:** ΔG° < 0, spontaneous
    - **E°cell < 0:** ΔG° > 0, non-spontaneous
    - **E°cell = 0:** ΔG° = 0, equilibrium

    ### Example:

    For Daniell cell: E°cell = 1.10 V, n = 2

    ΔG° = -2 × 96,500 × 1.10
    ΔG° = -212,300 J = **-212.3 kJ** (spontaneous)

    ## Relationship Between E°cell and K

    **E°cell = (RT/nF) ln K** or **E°cell = (0.0591/n) log K** at 25°C

    Or: **E°cell = (2.303RT/nF) log K**

    At 25°C: **E°cell = (0.0591/n) log K**

    **K = equilibrium constant**

    ### Example:

    For Daniell cell: E°cell = 1.10 V, n = 2

    1.10 = (0.0591/2) log K
    log K = (1.10 × 2)/0.0591 = 37.23
    **K = 10³⁷·²³** (very large, nearly complete reaction)

    ## Nernst Equation

    **For non-standard conditions**, cell potential depends on concentration:

    **General form:**
    **E = E° - (RT/nF) ln Q**

    **At 25°C:**
    **E = E° - (0.0591/n) log Q**

    Where Q = reaction quotient

    ### For Half-Cell:

    For: **Mⁿ⁺ + ne⁻ → M**

    **E = E° - (0.0591/n) log(1/[Mⁿ⁺])**

    **E = E° + (0.0591/n) log[Mⁿ⁺]**

    ### For Complete Cell:

    For: **aA + bB → cC + dD**

    **E = E° - (0.0591/n) log([C]ᶜ[D]ᵈ/[A]ᵃ[B]ᵇ)**

    ### Example 1: Daniell Cell

    **Zn + Cu²⁺ → Zn²⁺ + Cu**
    **E° = 1.10 V, n = 2**

    If [Zn²⁺] = 0.1 M, [Cu²⁺] = 1.0 M:

    E = 1.10 - (0.0591/2) log([Zn²⁺]/[Cu²⁺])
    E = 1.10 - 0.02955 log(0.1/1.0)
    E = 1.10 - 0.02955 × (-1)
    E = 1.10 + 0.03 = **1.13 V**

    ### Example 2: Hydrogen Electrode

    **2H⁺ + 2e⁻ → H₂**, E° = 0.00 V

    If [H⁺] = 0.01 M, P(H₂) = 1 atm:

    E = 0 + (0.0591/2) log([H⁺]²/P(H₂))
    E = 0.02955 log(0.01)²
    E = 0.02955 × (-4)
    E = **-0.118 V**

    ## Concentration Cell

    **Definition:** Cell with same electrodes but different concentrations

    **Example:** Zn | Zn²⁺(C₁) || Zn²⁺(C₂) | Zn

    **E°cell = 0** (same electrodes)

    **E = 0 - (0.0591/n) log(C₁/C₂)**
    **E = (0.0591/n) log(C₂/C₁)**

    **Note:** Higher concentration is cathode (reduction), lower is anode (oxidation)

    ### Example:

    Zn | Zn²⁺(0.01 M) || Zn²⁺(1.0 M) | Zn

    E = (0.0591/2) log(1.0/0.01)
    E = 0.02955 × 2
    E = **0.059 V**

    ## Applications of Nernst Equation

    1. **Calculate EMF** at non-standard conditions
    2. **Determine pH** using pH electrode
    3. **Find equilibrium constant** from E°
    4. **Concentration cells** calculations
    5. **Predict spontaneity** under various conditions

    ### pH Calculation:

    For hydrogen electrode:
    **E = 0 - 0.0591 pH**

    If E = -0.295 V:
    -0.295 = -0.0591 pH
    pH = 0.295/0.0591 = **5.0**

    ## Solved Problems

    ### Problem 1: Calculate E°cell

    **Q: Calculate E°cell for Zn | Zn²⁺ || Ag⁺ | Ag**
    **E°(Zn²⁺/Zn) = -0.76 V, E°(Ag⁺/Ag) = +0.80 V**

    Solution:
    - Cathode (reduction): Ag⁺ + e⁻ → Ag, E° = +0.80 V
    - Anode (oxidation): Zn → Zn²⁺ + 2e⁻, E° = -0.76 V

    E°cell = E°cathode - E°anode
    E°cell = 0.80 - (-0.76) = **1.56 V**

    ### Problem 2: Nernst equation

    **Q: For Daniell cell, E° = 1.10 V. Calculate E when [Zn²⁺] = 0.01 M, [Cu²⁺] = 0.1 M.**

    Solution:
    E = E° - (0.0591/n) log([Zn²⁺]/[Cu²⁺])
    E = 1.10 - (0.0591/2) log(0.01/0.1)
    E = 1.10 - 0.02955 log(0.1)
    E = 1.10 - 0.02955 × (-1)
    E = 1.10 + 0.03 = **1.13 V**

    ### Problem 3: Calculate K

    **Q: E°cell = 0.46 V for a 2-electron transfer. Calculate K at 25°C.**

    Solution:
    E° = (0.0591/n) log K
    0.46 = (0.0591/2) log K
    log K = (0.46 × 2)/0.0591 = 15.57
    **K = 10¹⁵·⁵⁷ ≈ 3.7 × 10¹⁵**

    ### Problem 4: Concentration cell

    **Q: Calculate EMF of Ag | Ag⁺(0.001 M) || Ag⁺(0.1 M) | Ag**

    Solution:
    E = (0.0591/n) log(C₂/C₁)
    E = (0.0591/1) log(0.1/0.001)
    E = 0.0591 log(100)
    E = 0.0591 × 2 = **0.118 V**

    ### Problem 5: Calculate ΔG°

    **Q: E°cell = 1.10 V for 2-electron transfer. Calculate ΔG°.**

    Solution:
    ΔG° = -nFE°
    ΔG° = -2 × 96,500 × 1.10
    ΔG° = -212,300 J = **-212.3 kJ**

    ## IIT JEE Key Points

    1. **Galvanic cell:** Chemical → Electrical (spontaneous)
    2. **Anode:** Oxidation, negative, electron source
    3. **Cathode:** Reduction, positive, electron sink
    4. **E°cell = E°cathode - E°anode**
    5. **ΔG° = -nFE°cell**
    6. **E°cell = (0.0591/n) log K** at 25°C
    7. **Nernst:** E = E° - (0.0591/n) log Q
    8. **Concentration cell:** E°cell = 0
    9. **F = 96,500 C/mol**
    10. **Positive E°cell:** Spontaneous

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | E°cell | E°cathode - E°anode |
    | ΔG° | -nFE°cell |
    | E° and K | E° = (0.0591/n) log K |
    | Nernst equation | E = E° - (0.0591/n) log Q |
    | Concentration cell | E = (0.0591/n) log(C₂/C₁) |

    ## Important Constants

    - **F (Faraday)** = 96,500 C/mol ≈ 96,487 C/mol
    - **R** = 8.314 J/(mol·K)
    - **T** = 298 K (25°C)
    - **2.303RT/F** = 0.0591 V at 25°C

## Key Points

- Galvanic cells

- Standard electrode potential

- Cell EMF
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Galvanic cells', 'Standard electrode potential', 'Cell EMF', 'Nernst equation', 'Concentration cells', 'Cell notation'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Electrolysis, Faraday\ ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Electrolysis, Faraday\',
  content: <<~MARKDOWN,
# Electrolysis, Faraday\ 🚀

# Electrolysis, Faraday's Laws and Electrolytic Cells

    ## Electrolysis

    **Definition:** Chemical decomposition using electrical energy (non-spontaneous reaction)

    **Electrolytic Cell:** Electrical → Chemical energy

    ### Differences: Galvanic vs Electrolytic

    | Property | Galvanic | Electrolytic |
    |----------|----------|--------------|
    | Energy | Chemical → Electrical | Electrical → Chemical |
    | Reaction | Spontaneous | Non-spontaneous |
    | E°cell | Positive | Negative (needs external V) |
    | Anode | Negative | Positive (connected to +ve) |
    | Cathode | Positive | Negative (connected to -ve) |
    | Example | Battery | Electrolysis of water |

    **Note:** In BOTH cells:
    - Oxidation at anode
    - Reduction at cathode

    ## Electrolysis Examples

    ### 1. Electrolysis of Molten NaCl:

    **Cathode (reduction):** Na⁺ + e⁻ → Na(l)
    **Anode (oxidation):** 2Cl⁻ → Cl₂(g) + 2e⁻

    **Overall:** 2NaCl(l) → 2Na(l) + Cl₂(g)

    Uses: **Downs process** for Na production

    ### 2. Electrolysis of Water (acidified):

    **Cathode:** 2H⁺ + 2e⁻ → H₂(g) (or 2H₂O + 2e⁻ → H₂ + 2OH⁻)
    **Anode:** 2H₂O → O₂(g) + 4H⁺ + 4e⁻ (or 4OH⁻ → O₂ + 2H₂O + 4e⁻)

    **Overall:** 2H₂O → 2H₂(g) + O₂(g)

    **Ratio:** 2 volumes H₂ : 1 volume O₂

    ### 3. Electrolysis of Aqueous NaCl (Brine):

    **Cathode:** 2H₂O + 2e⁻ → H₂(g) + 2OH⁻
    **Anode:** 2Cl⁻ → Cl₂(g) + 2e⁻

    **Overall:** 2NaCl(aq) + 2H₂O → 2NaOH(aq) + H₂(g) + Cl₂(g)

    **Chlor-alkali process:** Produces NaOH, H₂, Cl₂

    ### 4. Electrolysis of CuSO₄ with Cu electrodes:

    **Cathode (Cu):** Cu²⁺ + 2e⁻ → Cu (deposition)
    **Anode (Cu):** Cu → Cu²⁺ + 2e⁻ (dissolution)

    Net: **Cu transfers from anode to cathode**

    Uses: **Electrorefining of copper**

    ## Preferential Discharge

    When multiple ions present, which one is discharged?

    ### At Cathode (reduction):

    **Order of preference:** (easier to reduce first)

    **Au³⁺ > Ag⁺ > Cu²⁺ > H⁺ > Pb²⁺ > Fe²⁺ > Zn²⁺ > Na⁺ > K⁺**

    (Higher E° reduces first)

    ### At Anode (oxidation):

    **Order of preference:** (easier to oxidize first)

    **S²⁻ > I⁻ > Br⁻ > Cl⁻ > OH⁻ > NO₃⁻ > SO₄²⁻**

    (Lower E° oxidizes first)

    ### Examples:

    **1. Electrolysis of AgNO₃(aq):**
    - Cathode: Ag⁺ + e⁻ → Ag (Ag⁺ preferred over H⁺)
    - Anode: 2H₂O → O₂ + 4H⁺ + 4e⁻ (NO₃⁻ not oxidized)

    **2. Electrolysis of CuSO₄(aq) with Pt electrodes:**
    - Cathode: Cu²⁺ + 2e⁻ → Cu (Cu²⁺ preferred over H⁺)
    - Anode: 2H₂O → O₂ + 4H⁺ + 4e⁻ (SO₄²⁻ not oxidized)

    ## Faraday's Laws of Electrolysis

    ### First Law:

    **Statement:** Mass deposited/liberated is directly proportional to quantity of electricity passed

    **m ∝ Q**
    **m = ZQ** or **m = Zit**

    Where:
    - m = mass deposited (g)
    - Q = charge (coulombs, C)
    - i = current (amperes, A)
    - t = time (seconds, s)
    - Z = electrochemical equivalent (g/C)

    ### Second Law:

    **Statement:** When same quantity of electricity passes through different electrolytes, masses deposited are proportional to their equivalent weights

    **m₁/m₂ = E₁/E₂**

    Where E = equivalent weight

    ### Combined Form:

    **m = (E × i × t) / (96,500)**

    Or: **m = (E × Q) / F**

    Or: **m = (M × i × t) / (n × F)**

    Where:
    - M = molar mass (g/mol)
    - n = number of electrons
    - F = 96,500 C/mol (Faraday constant)
    - E = M/n = equivalent weight

    ## Electrochemical Equivalent (Z)

    **Definition:** Mass deposited by 1 coulomb of charge

    **Z = E/F = M/(nF)**

    Where:
    - E = equivalent weight
    - M = molar mass
    - n = charge on ion
    - F = 96,500 C/mol

    ### Example: For Cu²⁺

    M = 63.5 g/mol, n = 2

    Z = 63.5/(2 × 96,500) = 3.29 × 10⁻⁴ g/C

    ## Moles of Electrons

    **Number of moles of electrons = Q/F = it/F**

    **Number of electrons = Q/e** (where e = 1.6 × 10⁻¹⁹ C)

    ## Quantitative Calculations

    ### Problem 1: Mass deposited

    **Q: A current of 5 A is passed through CuSO₄ for 30 minutes. Calculate mass of Cu deposited. (Cu = 63.5, n = 2)**

    Solution:
    - i = 5 A
    - t = 30 × 60 = 1800 s
    - Q = it = 5 × 1800 = 9000 C

    m = MQ/(nF) = (63.5 × 9000)/(2 × 96,500)
    m = 571,500/193,000 = **2.96 g**

    ### Problem 2: Time required

    **Q: How long should 2 A current be passed to deposit 1.08 g Ag? (Ag = 108)**

    Solution:
    - m = 1.08 g
    - M = 108, n = 1
    - i = 2 A

    m = Mit/(nF)
    1.08 = (108 × 2 × t)/(1 × 96,500)
    t = (1.08 × 96,500)/216 = **482.5 s ≈ 8 min**

    ### Problem 3: Current

    **Q: What current is needed to deposit 3.17 g Cu in 1 hour? (Cu = 63.5, n = 2)**

    Solution:
    - m = 3.17 g
    - t = 3600 s

    m = Mit/(nF)
    3.17 = (63.5 × i × 3600)/(2 × 96,500)
    i = (3.17 × 2 × 96,500)/(63.5 × 3600)
    i = **2.67 A**

    ### Problem 4: Second law

    **Q: Same charge deposits 0.54 g Ag and x g Cu. Find x. (Ag = 108, Cu = 63.5)**

    Solution:
    - For Ag: E₁ = 108/1 = 108
    - For Cu: E₂ = 63.5/2 = 31.75

    m₁/m₂ = E₁/E₂
    0.54/x = 108/31.75
    x = (0.54 × 31.75)/108 = **0.159 g**

    ## Applications of Electrolysis

    ### 1. Electroplating:

    **Process:** Coating one metal with another using electrolysis

    **Example:** Silver plating on spoon
    - Electrolyte: AgNO₃ solution
    - Anode: Pure Ag
    - Cathode: Spoon (to be plated)
    - Reaction: Ag from anode deposits on cathode

    **Uses:** Protection, decoration, electrical contacts

    ### 2. Electrorefining:

    **Process:** Purification of metals

    **Example:** Refining copper
    - Electrolyte: CuSO₄ + H₂SO₄
    - Anode: Impure Cu
    - Cathode: Pure Cu strip
    - Impurities fall as **anode mud** (contains Ag, Au, Pt)

    ### 3. Extraction of Metals:

    **Electrolytic reduction:** Na, K, Ca, Mg, Al from molten salts

    **Example:** **Hall-Heroult process** for Al
    - Al₂O₃ dissolved in molten cryolite (Na₃AlF₆)
    - Cathode: 2Al₂O₃ + 3C → 4Al + 3CO₂
    - Anode: Carbon, gets oxidized

    ### 4. Anodizing:

    **Process:** Forming protective oxide layer on Al

    **5. Manufacturing:**
    - Chlorine, NaOH (chlor-alkali)
    - H₂ and O₂ (water electrolysis)

    ## Solved Electrolysis Problems

    ### Problem 5: Volume of gas

    **Q: Calculate volume of H₂ at STP liberated when 0.1 A current is passed through water for 30 min.**

    Solution:
    - Q = it = 0.1 × 30 × 60 = 180 C
    - 2H⁺ + 2e⁻ → H₂
    - 2 mol e⁻ → 1 mol H₂
    - 2F → 22.4 L at STP

    Volume = (Q/F) × (22.4/2)
    V = (180/96,500) × 11.2
    V = **0.0209 L = 20.9 mL**

    ### Problem 6: Multiple electrolytes

    **Q: Same current passes through AgNO₃ and CuSO₄. If 1.08 g Ag deposits, find Cu deposited.**

    Solution:
    - Ag: M = 108, n = 1, E = 108
    - Cu: M = 63.5, n = 2, E = 31.75

    m(Cu)/m(Ag) = E(Cu)/E(Ag)
    m(Cu)/1.08 = 31.75/108
    m(Cu) = **0.317 g**

    ## IIT JEE Key Points

    1. **Electrolysis:** Electrical → Chemical (non-spontaneous)
    2. **Both cells:** Oxidation at anode, reduction at cathode
    3. **Faraday I:** m = Zit = ZQ
    4. **Faraday II:** m₁/m₂ = E₁/E₂
    5. **m = Mit/(nF)** or **m = MQ/(nF)**
    6. **F = 96,500 C/mol**
    7. **Z = M/(nF)** = electrochemical equivalent
    8. **Preferential discharge:** Higher E° reduces first
    9. **Electrorefining:** Purifies metals
    10. **Electroplating:** Coating metals

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Mass deposited | m = Mit/(nF) |
    | Charge | Q = it |
    | ECE (Z) | M/(nF) |
    | Second law | m₁/m₂ = E₁/E₂ |
    | Moles of e⁻ | Q/F or it/F |

    ## Important Values

    - **F** = 96,500 C/mol
    - **1 mole e⁻** = 96,500 C
    - **STP:** 22.4 L/mol

## Key Points

- Electrolysis

- Faradays laws

- Electrochemical equivalent
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Electrolysis', 'Faradays laws', 'Electrochemical equivalent', 'Preferential discharge', 'Electrolytic refining', 'Electroplating'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Conductance, Kohlrausch\ ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Conductance, Kohlrausch\',
  content: <<~MARKDOWN,
# Conductance, Kohlrausch\ 🚀

# Conductance, Kohlrausch's Law and Electrochemical Devices

    ## Electrical Conductance

    **Conductance (G):** Ability to conduct electricity

    **G = 1/R** (reciprocal of resistance)

    **Units:** Siemens (S) or mho (℧) or Ω⁻¹

    ### Ohm's Law:

    **V = IR** or **R = V/I**

    **Conductance: G = I/V = 1/R**

    ## Specific Conductance (κ - kappa)

    **Definition:** Conductance of 1 cm³ solution between electrodes 1 cm apart

    **κ = (1/R) × (l/A) = G × (l/A)**

    Where:
    - l = distance between electrodes (cm)
    - A = area of electrodes (cm²)
    - l/A = cell constant (G*)

    **κ = G × G***

    **Units:** S cm⁻¹ or Ω⁻¹ cm⁻¹

    ### Cell Constant (G*):

    **G* = l/A** (depends on geometry of cell)

    **Units:** cm⁻¹

    Determined using solution of known κ (KCl solution)

    ## Molar Conductivity (Λm)

    **Definition:** Conductance of solution containing 1 mole of electrolyte placed between electrodes 1 cm apart

    **Λm = κ × 1000 / M**

    Where:
    - κ = specific conductance (S cm⁻¹)
    - M = molarity (mol/L)
    - 1000 = conversion factor (1 L = 1000 cm³)

    **Units:** S cm² mol⁻¹

    ### Equivalent Conductivity (Λeq):

    **Λeq = κ × 1000 / N**

    Where N = normality

    **Relationship:** Λm = n × Λeq (n = number of charges)

    ## Variation of Conductivity with Dilution

    ### Specific Conductance (κ):

    **Decreases with dilution** (fewer ions per unit volume)

    ### Molar Conductivity (Λm):

    **Increases with dilution** (less inter-ionic interactions)

    **Strong electrolytes:** Λm increases slightly with dilution
    **Weak electrolytes:** Λm increases sharply with dilution

    At **infinite dilution:** Λm = Λm° (maximum value)

    ## Kohlrausch's Law of Independent Migration

    **Statement:** At infinite dilution, molar conductivity is sum of contributions from individual ions

    **Λm° = λ₊° + λ₋°**

    Where:
    - λ₊° = limiting molar conductivity of cation
    - λ₋° = limiting molar conductivity of anion

    ### For Salt:

    **Λm°(NaCl) = λ°(Na⁺) + λ°(Cl⁻)**

    ### For Acid/Base:

    **Λm°(HCl) = λ°(H⁺) + λ°(Cl⁻)**
    **Λm°(NaOH) = λ°(Na⁺) + λ°(OH⁻)**

    ## Applications of Kohlrausch's Law

    ### 1. Calculate Λm° of weak electrolyte:

    **Example:** Find Λm°(CH₃COOH)

    **Method:**
    Λm°(CH₃COOH) = λ°(CH₃COO⁻) + λ°(H⁺)

    Cannot measure directly, so use:

    **Λm°(CH₃COOH) = Λm°(CH₃COONa) + Λm°(HCl) - Λm°(NaCl)**

    Proof:
    - Λm°(CH₃COONa) = λ°(CH₃COO⁻) + λ°(Na⁺)
    - Λm°(HCl) = λ°(H⁺) + λ°(Cl⁻)
    - Λm°(NaCl) = λ°(Na⁺) + λ°(Cl⁻)

    Adding first two and subtracting third:
    = λ°(CH₃COO⁻) + λ°(H⁺) ✓

    ### 2. Degree of Dissociation (α):

    For weak electrolyte:

    **α = Λm / Λm°**

    Where:
    - Λm = molar conductivity at given concentration
    - Λm° = limiting molar conductivity

    ### 3. Dissociation Constant (Ka):

    For weak acid HA:

    **Ka = (Cα²)/(1-α) ≈ Cα²** (if α << 1)

    Since α = Λm/Λm°:

    **Ka = C(Λm/Λm°)² / (1 - Λm/Λm°)**

    ## Numerical Examples

    ### Problem 1: Calculate κ

    **Q: R = 100 Ω, G* = 0.5 cm⁻¹. Calculate κ.**

    Solution:
    - G = 1/R = 1/100 = 0.01 S
    - κ = G × G* = 0.01 × 0.5
    - **κ = 0.005 S cm⁻¹**

    ### Problem 2: Calculate Λm

    **Q: κ = 0.0025 S cm⁻¹, M = 0.1 M. Calculate Λm.**

    Solution:
    Λm = (κ × 1000)/M = (0.0025 × 1000)/0.1
    **Λm = 25 S cm² mol⁻¹**

    ### Problem 3: Kohlrausch's law

    **Q: Calculate Λm°(NH₄OH) given:**
    - Λm°(NH₄Cl) = 150 S cm² mol⁻¹
    - Λm°(NaOH) = 248 S cm² mol⁻¹
    - Λm°(NaCl) = 126 S cm² mol⁻¹

    Solution:
    Λm°(NH₄OH) = Λm°(NH₄Cl) + Λm°(NaOH) - Λm°(NaCl)
    = 150 + 248 - 126
    **= 272 S cm² mol⁻¹**

    ### Problem 4: Degree of dissociation

    **Q: For CH₃COOH, Λm = 18 S cm² mol⁻¹, Λm° = 390 S cm² mol⁻¹. Find α.**

    Solution:
    α = Λm/Λm° = 18/390
    **α = 0.046 or 4.6%**

    ### Problem 5: Calculate Ka

    **Q: For 0.01 M CH₃COOH, α = 0.04, find Ka.**

    Solution:
    Ka = Cα²/(1-α) = (0.01 × 0.04²)/(1-0.04)
    Ka = (0.01 × 0.0016)/0.96
    **Ka = 1.67 × 10⁻⁵**

    ## Batteries (Electrochemical Cells)

    ### Primary Batteries (Non-rechargeable):

    **1. Dry Cell (Leclanche Cell):**

    - **Anode:** Zn container
    - **Cathode:** Carbon rod
    - **Electrolyte:** NH₄Cl + ZnCl₂ paste + MnO₂

    Reactions:
    - Anode: Zn → Zn²⁺ + 2e⁻
    - Cathode: MnO₂ + NH₄⁺ + e⁻ → MnO(OH) + NH₃

    **Voltage:** ~1.5 V
    **Uses:** Flashlights, remote controls

    **2. Mercury Cell:**

    - **Anode:** Zn-Hg amalgam
    - **Cathode:** HgO + carbon
    - **Electrolyte:** KOH paste

    Reactions:
    - Anode: Zn + 2OH⁻ → ZnO + H₂O + 2e⁻
    - Cathode: HgO + H₂O + 2e⁻ → Hg + 2OH⁻

    **Voltage:** 1.35 V (constant)
    **Uses:** Hearing aids, watches

    ### Secondary Batteries (Rechargeable):

    **1. Lead-Acid Battery:**

    - **Anode:** Pb
    - **Cathode:** PbO₂
    - **Electrolyte:** 38% H₂SO₄

    **Discharge:**
    - Anode: Pb + SO₄²⁻ → PbSO₄ + 2e⁻
    - Cathode: PbO₂ + 4H⁺ + SO₄²⁻ + 2e⁻ → PbSO₄ + 2H₂O
    - Overall: Pb + PbO₂ + 2H₂SO₄ → 2PbSO₄ + 2H₂O

    **Charge:** Reverse reaction

    **Voltage:** 2 V per cell (6 cells = 12 V battery)
    **Uses:** Automobiles

    **2. Nickel-Cadmium (NiCd) Battery:**

    - **Anode:** Cd
    - **Cathode:** NiO(OH)
    - **Electrolyte:** KOH

    **Voltage:** 1.4 V
    **Uses:** Electronic devices

    **3. Lithium-ion Battery:**

    - **Anode:** Graphite (Li intercalated)
    - **Cathode:** LiCoO₂
    - **Electrolyte:** Lithium salt in organic solvent

    **Voltage:** 3.7 V
    **Uses:** Mobile phones, laptops, EVs
    **Advantages:** High energy density, lightweight

    ## Fuel Cells

    **Definition:** Continuously converts chemical energy to electrical energy as long as fuel is supplied

    ### Hydrogen-Oxygen Fuel Cell:

    - **Anode:** H₂ → 2H⁺ + 2e⁻
    - **Cathode:** O₂ + 4H⁺ + 4e⁻ → 2H₂O
    - **Overall:** 2H₂ + O₂ → 2H₂O

    **Electrolyte:** KOH (aqueous) or polymer membrane
    **Efficiency:** 60-70% (higher than combustion)
    **Byproduct:** Water only (clean)

    **Uses:** Space programs, vehicles, stationary power

    **Advantages:**
    - High efficiency
    - Low pollution
    - Continuous operation

    ## Corrosion

    **Definition:** Electrochemical degradation of metals

    ### Rusting of Iron:

    **Anodic area:** Fe → Fe²⁺ + 2e⁻
    **Cathodic area:** O₂ + 4H⁺ + 4e⁻ → 2H₂O (acidic)
    or O₂ + 2H₂O + 4e⁻ → 4OH⁻ (neutral/basic)

    **Overall:** 2Fe + O₂ + 4H⁺ → 2Fe²⁺ + 2H₂O
    Then: 4Fe²⁺ + O₂ + 4H₂O → 2Fe₂O₃·xH₂O (rust)

    **Factors enhancing corrosion:**
    - Moisture, oxygen
    - Acidic environment
    - Salts (electrolytes)
    - Impurities in metal

    ### Prevention of Corrosion:

    1. **Painting/coating:** Barrier against O₂, H₂O
    2. **Galvanization:** Coating with Zn (sacrificial protection)
    3. **Electroplating:** Ni, Cr plating
    4. **Alloying:** Stainless steel (Cr, Ni added)
    5. **Cathodic protection:** Connect to more active metal
    6. **Passivation:** Formation of oxide layer (Al₂O₃ on Al)

    ## IIT JEE Key Points

    1. **Conductance G = 1/R**
    2. **κ = G × (l/A) = G × G***
    3. **Λm = κ × 1000/M**
    4. **Λm increases with dilution**
    5. **Kohlrausch:** Λm° = λ₊° + λ₋°
    6. **α = Λm/Λm°** (weak electrolyte)
    7. **Primary battery:** Non-rechargeable
    8. **Secondary battery:** Rechargeable
    9. **Fuel cell:** Continuous operation
    10. **Corrosion:** Electrochemical oxidation

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Conductance | G = 1/R |
    | Specific conductance | κ = G × G* |
    | Molar conductivity | Λm = κ × 1000/M |
    | Kohlrausch's law | Λm° = λ₊° + λ₋° |
    | Degree of dissociation | α = Λm/Λm° |

    ## Important Facts

    - **H⁺** and **OH⁻** have highest conductivities
    - **Strong electrolytes:** Complete dissociation
    - **Weak electrolytes:** Partial dissociation
    - **Λm° (weak):** Use Kohlrausch's law

## Key Points

- Conductance

- Molar conductivity

- Kohlrauschs law
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Conductance', 'Molar conductivity', 'Kohlrauschs law', 'Batteries', 'Fuel cells', 'Corrosion'],
  prerequisite_ids: []
)

# === MICROLESSON 7: cell_potential — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'cell_potential — Practice',
  content: <<~MARKDOWN,
# cell_potential — Practice 🚀

E°cell = E°cathode - E°anode = 0.34 - (-0.76) = 1.10 V

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['cell_potential'],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate E°cell for the cell: Zn|Zn²⁺||Cu²⁺|Cu. E°(Zn²⁺/Zn) = -0.76 V, E°(Cu²⁺/Cu) = +0.34 V',
    answer: '1.10',
    explanation: 'E°cell = E°cathode - E°anode = 0.34 - (-0.76) = 1.10 V',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: galvanic_cells — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'galvanic_cells — Practice',
  content: <<~MARKDOWN,
# galvanic_cells — Practice 🚀

In IUPAC cell notation, anode (oxidation) is on left, cathode (reduction) on right. Oxidation occurs at anode (A).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['galvanic_cells'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In cell notation A|B||C|D, oxidation occurs at:',
    options: ['A (anode)', 'D (cathode)', 'Both A and D', 'Salt bridge'],
    correct_answer: 0,
    explanation: 'In IUPAC cell notation, anode (oxidation) is on left, cathode (reduction) on right. Oxidation occurs at anode (A).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: thermodynamics_cells — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'thermodynamics_cells — Practice',
  content: <<~MARKDOWN,
# thermodynamics_cells — Practice 🚀

ΔG° = -nFE° = -2 × 96,500 × 1.10 = -212,300 J = -212.3 kJ

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['thermodynamics_cells'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For a cell with E° = 1.10 V and n = 2, calculate ΔG° in kJ. Use F = 96,500 C/mol.',
    answer: '-212.3',
    explanation: 'ΔG° = -nFE° = -2 × 96,500 × 1.10 = -212,300 J = -212.3 kJ',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: nernst_equation — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'nernst_equation — Practice',
  content: <<~MARKDOWN,
# nernst_equation — Practice 🚀

Concentration cells have same electrodes at both ends, so E°cell = E°cathode - E°anode = 0. EMF comes only from concentration difference via Nernst equation.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['nernst_equation'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For concentration cell with same electrodes but different concentrations, E°cell is:',
    options: ['0 V', 'Positive', 'Negative', 'Depends on concentration'],
    correct_answer: 0,
    explanation: 'Concentration cells have same electrodes at both ends, so E°cell = E°cathode - E°anode = 0. EMF comes only from concentration difference via Nernst equation.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: faradays_laws — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'faradays_laws — Practice',
  content: <<~MARKDOWN,
# faradays_laws — Practice 🚀

Q = it = 2 × 3600 = 7200 C. m = MQ/(nF) = (63.5 × 7200)/(2 × 96,500) = 2.37 g

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['faradays_laws'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many grams of Cu are deposited when 2 A current passes through CuSO₄ for 1 hour? (Cu = 63.5, n = 2, F = 96,500)',
    answer: '2.37',
    explanation: 'Q = it = 2 × 3600 = 7200 C. m = MQ/(nF) = (63.5 × 7200)/(2 × 96,500) = 2.37 g',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: electrolysis — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'electrolysis — Practice',
  content: <<~MARKDOWN,
# electrolysis — Practice 🚀

TRUE. In BOTH types of cells, oxidation always occurs at anode and reduction at cathode. The difference is in polarity and spontaneity.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['electrolysis'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In both galvanic and electrolytic cells, oxidation occurs at the anode.',
    answer: 'true',
    explanation: 'TRUE. In BOTH types of cells, oxidation always occurs at anode and reduction at cathode. The difference is in polarity and spontaneity.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: faradays_laws — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'faradays_laws — Practice',
  content: <<~MARKDOWN,
# faradays_laws — Practice 🚀

E(Ag) = 108/1 = 108, E(Cu) = 63.5/2 = 31.75. m(Cu)/m(Ag) = E(Cu)/E(Ag) → m(Cu) = 1.08 × 31.75/108 = 0.317 g

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['faradays_laws'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Same charge deposits 1.08 g Ag. How much Cu is deposited? (Ag = 108, n=1; Cu = 63.5, n=2)',
    answer: '0.317',
    explanation: 'E(Ag) = 108/1 = 108, E(Cu) = 63.5/2 = 31.75. m(Cu)/m(Ag) = E(Cu)/E(Ag) → m(Cu) = 1.08 × 31.75/108 = 0.317 g',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: conductance — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'conductance — Practice',
  content: <<~MARKDOWN,
# conductance — Practice 🚀

Λm = (κ × 1000)/M = (0.004 × 1000)/0.1 = 40 S cm² mol⁻¹

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['conductance'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'If κ = 0.004 S/cm and M = 0.1 M, calculate Λm in S cm² mol⁻¹.',
    answer: '40',
    explanation: 'Λm = (κ × 1000)/M = (0.004 × 1000)/0.1 = 40 S cm² mol⁻¹',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: kohlrauschs_law — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'kohlrauschs_law — Practice',
  content: <<~MARKDOWN,
# kohlrauschs_law — Practice 🚀

Kohlrausch\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['kohlrauschs_law'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Kohlrausch\',
    options: ['Weak electrolytes', 'Strong electrolytes', 'Non-electrolytes', 'Inert gases'],
    correct_answer: 0,
    explanation: 'Kohlrausch\',
    difficulty: 'easy'
  }
)

# === MICROLESSON 16: batteries — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'batteries — Practice',
  content: <<~MARKDOWN,
# batteries — Practice 🚀

Lead-acid battery is secondary (rechargeable). Dry cell and mercury cell are primary (non-rechargeable).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['batteries'],
  prerequisite_ids: []
)

# Exercise 16.2: MCQ
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which is a secondary (rechargeable) battery?',
    options: ['Dry cell', 'Lead-acid battery', 'Mercury cell', 'Alkaline battery'],
    correct_answer: 1,
    explanation: 'Lead-acid battery is secondary (rechargeable). Dry cell and mercury cell are primary (non-rechargeable).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 17: conductance — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'conductance — Practice',
  content: <<~MARKDOWN,
# conductance — Practice 🚀

α = Λm/Λm° = 20/400 = 0.05 or 5%

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['conductance'],
  prerequisite_ids: []
)

# Exercise 17.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For weak acid, Λm = 20 S cm² mol⁻¹ and Λm° = 400 S cm² mol⁻¹. Calculate α (degree of dissociation).',
    answer: '0.05',
    explanation: 'α = Λm/Λm° = 20/400 = 0.05 or 5%',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 18: Galvanic Cells, EMF and Nernst Equation ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Galvanic Cells, EMF and Nernst Equation',
  content: <<~MARKDOWN,
# Galvanic Cells, EMF and Nernst Equation 🚀

# Galvanic Cells, EMF and Nernst Equation

    ## Electrochemical Cells

    **Electrochemical cell:** Device that converts chemical energy to electrical energy (or vice versa)

    ### Types:

    **1. Galvanic (Voltaic) Cell:** Chemical → Electrical energy
    - Spontaneous redox reaction
    - Generates electricity
    - Example: Daniell cell

    **2. Electrolytic Cell:** Electrical → Chemical energy
    - Non-spontaneous reaction
    - Requires external voltage
    - Example: Electrolysis of water

    ## Galvanic Cell (Daniell Cell)

    ### Construction:

    **Anode (oxidation):** Zn rod in ZnSO₄ solution
    **Cathode (reduction):** Cu rod in CuSO₄ solution
    **Salt bridge:** KCl or KNO₃ solution in agar gel

    ### Reactions:

    **Anode (oxidation):** Zn(s) → Zn²⁺(aq) + 2e⁻
    **Cathode (reduction):** Cu²⁺(aq) + 2e⁻ → Cu(s)

    **Overall:** Zn(s) + Cu²⁺(aq) → Zn²⁺(aq) + Cu(s)

    ### Important Points:

    - **Anode:** Negative terminal, oxidation occurs
    - **Cathode:** Positive terminal, reduction occurs
    - **Electrons flow:** Anode → Cathode (external circuit)
    - **Anions move:** Toward anode (in solution)
    - **Cations move:** Toward cathode (in solution)

    **Mnemonic: AN OX and RED CAT**
    - **AN**ode **OX**idation
    - **RED**uction **CAT**hode

    ### Salt Bridge Function:

    1. **Completes circuit** (allows ion flow)
    2. **Maintains electrical neutrality**
    3. **Prevents mixing** of solutions
    4. Uses **inert electrolyte** (KCl, KNO₃, NH₄NO₃)

    ## Cell Notation (IUPAC Convention)

    **Anode | Anode solution || Cathode solution | Cathode**

    **Example:** Daniell cell
    **Zn(s) | Zn²⁺(aq) || Cu²⁺(aq) | Cu(s)**

    **Notes:**
    - Single line (|): Phase boundary
    - Double line (||): Salt bridge
    - Anode (oxidation) on left
    - Cathode (reduction) on right

    ### More Examples:

    **1. Pt | H₂(g) | H⁺(aq) || Ag⁺(aq) | Ag(s)**

    Anode: H₂ → 2H⁺ + 2e⁻
    Cathode: Ag⁺ + e⁻ → Ag

    **2. Zn(s) | Zn²⁺(aq) || Ag⁺(aq) | Ag(s)**

    Anode: Zn → Zn²⁺ + 2e⁻
    Cathode: Ag⁺ + e⁻ → Ag

    ## Standard Electrode Potential (E°)

    **Definition:** Potential of half-cell measured against Standard Hydrogen Electrode (SHE) under standard conditions

    **Standard conditions:**
    - Temperature: 25°C (298 K)
    - Concentration: 1 M
    - Pressure: 1 atm (for gases)

    ### Standard Hydrogen Electrode (SHE):

    **2H⁺(aq, 1M) + 2e⁻ → H₂(g, 1 atm)**
    **E° = 0.00 V** (reference)

    Construction: Pt electrode in 1M HCl, H₂ gas at 1 atm

    ## Standard Cell Potential (E°cell)

    **E°cell = E°cathode - E°anode**

    Or: **E°cell = E°reduction - E°oxidation**

    ### Important:
    - Use **reduction potentials** from tables
    - For oxidation half-cell, use **same E°** (don't reverse sign for calculation)
    - **Positive E°cell:** Spontaneous reaction

    ### Example: Daniell Cell

    **Cathode:** Cu²⁺ + 2e⁻ → Cu, E° = +0.34 V
    **Anode:** Zn → Zn²⁺ + 2e⁻, E°(Zn²⁺/Zn) = -0.76 V

    **E°cell = E°cathode - E°anode**
    **E°cell = 0.34 - (-0.76) = 1.10 V**

    ## Relationship Between ΔG° and E°cell

    **ΔG° = -nFE°cell**

    Where:
    - n = number of electrons transferred
    - F = Faraday constant = 96,500 C/mol
    - E°cell = standard cell potential (V)
    - ΔG° = standard Gibbs free energy (J)

    **Spontaneity:**
    - **E°cell > 0:** ΔG° < 0, spontaneous
    - **E°cell < 0:** ΔG° > 0, non-spontaneous
    - **E°cell = 0:** ΔG° = 0, equilibrium

    ### Example:

    For Daniell cell: E°cell = 1.10 V, n = 2

    ΔG° = -2 × 96,500 × 1.10
    ΔG° = -212,300 J = **-212.3 kJ** (spontaneous)

    ## Relationship Between E°cell and K

    **E°cell = (RT/nF) ln K** or **E°cell = (0.0591/n) log K** at 25°C

    Or: **E°cell = (2.303RT/nF) log K**

    At 25°C: **E°cell = (0.0591/n) log K**

    **K = equilibrium constant**

    ### Example:

    For Daniell cell: E°cell = 1.10 V, n = 2

    1.10 = (0.0591/2) log K
    log K = (1.10 × 2)/0.0591 = 37.23
    **K = 10³⁷·²³** (very large, nearly complete reaction)

    ## Nernst Equation

    **For non-standard conditions**, cell potential depends on concentration:

    **General form:**
    **E = E° - (RT/nF) ln Q**

    **At 25°C:**
    **E = E° - (0.0591/n) log Q**

    Where Q = reaction quotient

    ### For Half-Cell:

    For: **Mⁿ⁺ + ne⁻ → M**

    **E = E° - (0.0591/n) log(1/[Mⁿ⁺])**

    **E = E° + (0.0591/n) log[Mⁿ⁺]**

    ### For Complete Cell:

    For: **aA + bB → cC + dD**

    **E = E° - (0.0591/n) log([C]ᶜ[D]ᵈ/[A]ᵃ[B]ᵇ)**

    ### Example 1: Daniell Cell

    **Zn + Cu²⁺ → Zn²⁺ + Cu**
    **E° = 1.10 V, n = 2**

    If [Zn²⁺] = 0.1 M, [Cu²⁺] = 1.0 M:

    E = 1.10 - (0.0591/2) log([Zn²⁺]/[Cu²⁺])
    E = 1.10 - 0.02955 log(0.1/1.0)
    E = 1.10 - 0.02955 × (-1)
    E = 1.10 + 0.03 = **1.13 V**

    ### Example 2: Hydrogen Electrode

    **2H⁺ + 2e⁻ → H₂**, E° = 0.00 V

    If [H⁺] = 0.01 M, P(H₂) = 1 atm:

    E = 0 + (0.0591/2) log([H⁺]²/P(H₂))
    E = 0.02955 log(0.01)²
    E = 0.02955 × (-4)
    E = **-0.118 V**

    ## Concentration Cell

    **Definition:** Cell with same electrodes but different concentrations

    **Example:** Zn | Zn²⁺(C₁) || Zn²⁺(C₂) | Zn

    **E°cell = 0** (same electrodes)

    **E = 0 - (0.0591/n) log(C₁/C₂)**
    **E = (0.0591/n) log(C₂/C₁)**

    **Note:** Higher concentration is cathode (reduction), lower is anode (oxidation)

    ### Example:

    Zn | Zn²⁺(0.01 M) || Zn²⁺(1.0 M) | Zn

    E = (0.0591/2) log(1.0/0.01)
    E = 0.02955 × 2
    E = **0.059 V**

    ## Applications of Nernst Equation

    1. **Calculate EMF** at non-standard conditions
    2. **Determine pH** using pH electrode
    3. **Find equilibrium constant** from E°
    4. **Concentration cells** calculations
    5. **Predict spontaneity** under various conditions

    ### pH Calculation:

    For hydrogen electrode:
    **E = 0 - 0.0591 pH**

    If E = -0.295 V:
    -0.295 = -0.0591 pH
    pH = 0.295/0.0591 = **5.0**

    ## Solved Problems

    ### Problem 1: Calculate E°cell

    **Q: Calculate E°cell for Zn | Zn²⁺ || Ag⁺ | Ag**
    **E°(Zn²⁺/Zn) = -0.76 V, E°(Ag⁺/Ag) = +0.80 V**

    Solution:
    - Cathode (reduction): Ag⁺ + e⁻ → Ag, E° = +0.80 V
    - Anode (oxidation): Zn → Zn²⁺ + 2e⁻, E° = -0.76 V

    E°cell = E°cathode - E°anode
    E°cell = 0.80 - (-0.76) = **1.56 V**

    ### Problem 2: Nernst equation

    **Q: For Daniell cell, E° = 1.10 V. Calculate E when [Zn²⁺] = 0.01 M, [Cu²⁺] = 0.1 M.**

    Solution:
    E = E° - (0.0591/n) log([Zn²⁺]/[Cu²⁺])
    E = 1.10 - (0.0591/2) log(0.01/0.1)
    E = 1.10 - 0.02955 log(0.1)
    E = 1.10 - 0.02955 × (-1)
    E = 1.10 + 0.03 = **1.13 V**

    ### Problem 3: Calculate K

    **Q: E°cell = 0.46 V for a 2-electron transfer. Calculate K at 25°C.**

    Solution:
    E° = (0.0591/n) log K
    0.46 = (0.0591/2) log K
    log K = (0.46 × 2)/0.0591 = 15.57
    **K = 10¹⁵·⁵⁷ ≈ 3.7 × 10¹⁵**

    ### Problem 4: Concentration cell

    **Q: Calculate EMF of Ag | Ag⁺(0.001 M) || Ag⁺(0.1 M) | Ag**

    Solution:
    E = (0.0591/n) log(C₂/C₁)
    E = (0.0591/1) log(0.1/0.001)
    E = 0.0591 log(100)
    E = 0.0591 × 2 = **0.118 V**

    ### Problem 5: Calculate ΔG°

    **Q: E°cell = 1.10 V for 2-electron transfer. Calculate ΔG°.**

    Solution:
    ΔG° = -nFE°
    ΔG° = -2 × 96,500 × 1.10
    ΔG° = -212,300 J = **-212.3 kJ**

    ## IIT JEE Key Points

    1. **Galvanic cell:** Chemical → Electrical (spontaneous)
    2. **Anode:** Oxidation, negative, electron source
    3. **Cathode:** Reduction, positive, electron sink
    4. **E°cell = E°cathode - E°anode**
    5. **ΔG° = -nFE°cell**
    6. **E°cell = (0.0591/n) log K** at 25°C
    7. **Nernst:** E = E° - (0.0591/n) log Q
    8. **Concentration cell:** E°cell = 0
    9. **F = 96,500 C/mol**
    10. **Positive E°cell:** Spontaneous

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | E°cell | E°cathode - E°anode |
    | ΔG° | -nFE°cell |
    | E° and K | E° = (0.0591/n) log K |
    | Nernst equation | E = E° - (0.0591/n) log Q |
    | Concentration cell | E = (0.0591/n) log(C₂/C₁) |

    ## Important Constants

    - **F (Faraday)** = 96,500 C/mol ≈ 96,487 C/mol
    - **R** = 8.314 J/(mol·K)
    - **T** = 298 K (25°C)
    - **2.303RT/F** = 0.0591 V at 25°C

## Key Points

- Galvanic cells

- Standard electrode potential

- Cell EMF
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Galvanic cells', 'Standard electrode potential', 'Cell EMF', 'Nernst equation', 'Concentration cells', 'Cell notation'],
  prerequisite_ids: []
)

puts "✓ Created 18 microlessons for Electrochemistry"

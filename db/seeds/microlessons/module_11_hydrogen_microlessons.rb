# AUTO-GENERATED from module_11_hydrogen.rb
puts "Creating Microlessons for Hydrogen Chemistry..."

module_var = CourseModule.find_by(slug: 'hydrogen-chemistry')

# === MICROLESSON 1: hydrogen_fuel — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'hydrogen_fuel — Practice',
  content: <<~MARKDOWN,
# hydrogen_fuel — Practice 🚀

Hydrogen fuel cells convert chemical energy directly to electrical energy through electrochemical reactions. At the anode: H₂ → 2H⁺ + 2e⁻, and at the cathode: O₂ + 4H⁺ + 4e⁻ → 2H₂O. The overall process produces water and electrical energy with high efficiency (60-80%).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['hydrogen_fuel'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In a hydrogen fuel cell, the overall reaction is 2H₂ + O₂ → 2H₂O + ________ energy.',
    answer: 'electrical|electric',
    explanation: 'Hydrogen fuel cells convert chemical energy directly to electrical energy through electrochemical reactions. At the anode: H₂ → 2H⁺ + 2e⁻, and at the cathode: O₂ + 4H⁺ + 4e⁻ → 2H₂O. The overall process produces water and electrical energy with high efficiency (60-80%).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Hydrides, Water Chemistry, and Heavy Water ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hydrides, Water Chemistry, and Heavy Water',
  content: <<~MARKDOWN,
# Hydrides, Water Chemistry, and Heavy Water 🚀

# Hydrides Classification

    ## What are Hydrides?

    **Definition**: Binary compounds of hydrogen with other elements.

    **General formula**: XHₙ or HₙX (X = any element)

    Hydrides are classified into three main types based on bonding:

    ---

    ## 1. Ionic (Saline) Hydrides

    ### Formation
    - Formed by **highly electropositive s-block metals** (Group 1, Group 2 heavier elements)
    - Elements: Na, K, Ca, Ba (not Be, Mg)

    **Examples**: NaH, KH, CaH₂, BaH₂

    ### Characteristics
    - **Stoichiometric compounds** (definite formula)
    - **Crystalline solids** (ionic lattice)
    - **High melting points** (strong ionic bonds)
    - Contain **H⁻ ion** (hydride ion)
    - Conduct electricity in molten state

    ### Chemical Properties
    #### Reaction with Water (Vigorous)
    - NaH + H₂O → NaOH + H₂↑
    - CaH₂ + 2H₂O → Ca(OH)₂ + 2H₂↑

    #### Strong Reducing Agents
    - 4NaH + TiCl₄ → Ti + 4NaCl + 2H₂

    ### Uses
    - **Portable source of hydrogen**
    - **Drying agents** (remove water)
    - **Reducing agents** in organic synthesis

    ---

    ## 2. Covalent (Molecular) Hydrides

    ### Formation
    - Formed by **non-metals and some metalloids**
    - Elements: Groups 13-17 (B, C, N, O, F, Si, P, S, Cl, etc.)

    **Examples**: CH₄, NH₃, H₂O, HF, SiH₄, PH₃, H₂S, HCl

    ### Characteristics
    - **Molecular compounds** (discrete molecules)
    - **Covalent bonds** (electron sharing)
    - **Gases or volatile liquids** at room temperature
    - **Low melting and boiling points** (weak intermolecular forces)
    - **Do not conduct electricity** (no ions)

    ### Classification by Electron Deficiency

    #### A. Electron-Deficient Hydrides
    - **Central atom has incomplete octet**
    - Examples: B₂H₆ (diborane), BH₃

    **Diborane Structure**:
    - B₂H₆ has 3-center-2-electron bonds (banana bonds)
    - Bridge hydrogen atoms

    #### B. Electron-Precise Hydrides
    - **Central atom has complete octet**
    - Examples: CH₄, SiH₄, GeH₄

    **Characteristics**:
    - No lone pairs on central atom
    - Tetrahedral geometry

    #### C. Electron-Rich Hydrides
    - **Central atom has lone pairs** (excess electrons)
    - Examples: NH₃ (1 lone pair), H₂O (2 lone pairs), HF (3 lone pairs)

    **Characteristics**:
    - Can act as Lewis bases (electron donors)
    - Form hydrogen bonds
    - Higher boiling points due to H-bonding

    ### Hydrogen Bonding

    **Occurs in**: H₂O, HF, NH₃ (H bonded to N, O, F)

    **Effects**:
    - Abnormally high boiling points
    - Water: H-bonding makes ice less dense than water
    - HF: Associates as (HF)ₙ polymer

    **Boiling point order**:
    - Group 15: NH₃ > PH₃ < AsH₃ < SbH₃ (H-bonding in NH₃)
    - Group 16: H₂O > H₂S < H₂Se < H₂Te (H-bonding in H₂O)
    - Group 17: HF > HCl < HBr < HI (H-bonding in HF)

    ---

    ## 3. Metallic (Interstitial) Hydrides

    ### Formation
    - Formed by **d-block and f-block metals**
    - Examples: TiH₁.₇, ZrH₂, VH₀.₅₆, PdH₀.₆

    ### Characteristics
    - **Non-stoichiometric** (variable composition)
    - H atoms occupy **interstitial spaces** in metal lattice
    - Retain metallic properties
    - Conduct electricity
    - Lower density than parent metal
    - Hard and brittle

    ### Uses
    - **Hydrogen storage materials**
    - **Catalysts** (Pd absorbs H₂)
    - **Reducing agents** in metallurgy

    ---

    ## Water (H₂O)

    ### Occurrence
    - Covers 71% of Earth's surface
    - Essential for life
    - Exists in three states (ice, water, vapor)

    ### Physical Properties
    - Colorless, odorless, tasteless liquid
    - Maximum density at 4°C (anomalous)
    - High boiling point (100°C) due to H-bonding
    - Excellent solvent (universal solvent)

    ### Amphoteric Nature
    - Acts as both acid and base:
      - **As acid**: H₂O + NH₃ → NH₄⁺ + OH⁻
      - **As base**: H₂O + HCl → H₃O⁺ + Cl⁻

    ### Chemical Reactions

    #### 1. Hydrolysis Reactions
    - P₄O₁₀ + 6H₂O → 4H₃PO₄
    - CaO + H₂O → Ca(OH)₂
    - NH₃ + H₂O → NH₄OH

    #### 2. Hydration
    - CuSO₄ (anhydrous, white) + 5H₂O → CuSO₄·5H₂O (blue)

    ---

    ## Hard Water vs Soft Water

    ### Hard Water
    **Definition**: Water that does not form lather easily with soap (contains Ca²⁺, Mg²⁺ salts)

    ### Types of Hardness

    #### 1. Temporary Hardness (Carbonate Hardness)
    **Cause**: Presence of bicarbonates of Ca²⁺ and Mg²⁺
    - Ca(HCO₃)₂, Mg(HCO₃)₂

    **Removal**: By boiling
    - Ca(HCO₃)₂ → CaCO₃↓ + H₂O + CO₂↑
    - Mg(HCO₃)₂ → MgCO₃↓ + H₂O + CO₂↑

    **Removal**: By Clark's method (adding lime)
    - Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O

    #### 2. Permanent Hardness (Non-carbonate Hardness)
    **Cause**: Presence of sulfates and chlorides of Ca²⁺ and Mg²⁺
    - CaSO₄, MgSO₄, CaCl₂, MgCl₂

    **Cannot be removed by boiling**

    **Removal methods**:

    **A. Washing Soda Method**
    - CaSO₄ + Na₂CO₃ → CaCO₃↓ + Na₂SO₄
    - MgCl₂ + Na₂CO₃ → MgCO₃↓ + 2NaCl

    **B. Ion Exchange (Permutit/Zeolite) Method**
    - Na₂Z (zeolite) + Ca²⁺ → CaZ + 2Na⁺
    - Zeolite can be regenerated: CaZ + 2NaCl → Na₂Z + CaCl₂

    **C. Calgon Method**
    - Sodium hexametaphosphate: Na₂[Na₄(PO₃)₆]
    - 2Ca²⁺ + Na₂[Na₄(PO₃)₆] → Na₂[Ca₂(PO₃)₆] + 4Na⁺
    - Forms soluble complex

    ### Soft Water
    - Water that readily forms lather with soap
    - Free from Ca²⁺ and Mg²⁺ salts
    - Examples: Rainwater, distilled water

    ---

    ## Heavy Water (D₂O)

    ### Preparation

    #### 1. Electrolysis of Water
    - Ordinary water (H₂O) preferentially electrolyzed
    - D₂O concentration increases in residue
    - Very inefficient (30 L water → 1 mL D₂O)

    #### 2. Fractional Distillation
    - D₂O has higher bp (101.4°C) than H₂O (100°C)
    - D₂O concentrates in residue

    #### 3. Exchange Reaction (Best Method)
    - H₂S + D₂O ⇌ HDO + HDS (at different temperatures)
    - By shifting equilibrium, D₂O separated

    ### Physical Properties Comparison

    | Property | H₂O | D₂O |
    |----------|-----|-----|
    | Molecular mass | 18 | 20 |
    | Melting point | 0°C | 3.82°C |
    | Boiling point | 100°C | 101.4°C |
    | Density (at 25°C) | 1.0 g/mL | 1.11 g/mL |
    | Viscosity | Lower | Higher |

    ### Chemical Properties
    - **Slower reactions** than H₂O (kinetic isotope effect)
    - Does not support life (toxic to living organisms)
    - Exchange with H in compounds:
      - NaH + D₂O → NaOD + HD↑
      - Al₄C₃ + 12D₂O → 4Al(OD)₃ + 3CD₄↑

    ### Uses of D₂O
    1. **Moderator in nuclear reactors**: Slows down neutrons without absorbing them
    2. **Tracer in reaction mechanisms**: Study reaction pathways
    3. **NMR spectroscopy**: Solvent (no H signal interference)
    4. **Preparation of deuterated compounds**: D₂SO₄, CD₄, etc.

    ---

    ## Key Points for IIT JEE

    1. **Ionic hydrides**: Formed by Group 1, 2 metals; contain H⁻; react vigorously with water
    2. **Covalent hydrides**: Electron-deficient (B₂H₆), electron-precise (CH₄), electron-rich (NH₃, H₂O)
    3. **Interstitial hydrides**: Non-stoichiometric; d-block metals; hydrogen storage
    4. **H-bonding**: NH₃, H₂O, HF have abnormally high bp
    5. **Hard water**: Temporary (bicarbonates, removed by boiling) vs Permanent (sulfates/chlorides)
    6. **Removal of hardness**: Clark's method (lime), washing soda, zeolite, Calgon
    7. **D₂O**: Higher bp (101.4°C), used as moderator in nuclear reactors
    8. **Diborane**: B₂H₆ has 3-center-2-electron bonds

## Key Points

- Ionic hydrides

- Covalent hydrides

- Interstitial hydrides
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ionic hydrides', 'Covalent hydrides', 'Interstitial hydrides', 'Hard water', 'Soft water', 'Heavy water D₂O'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Hydrogen Peroxide (H₂O₂) and Hydrogen as Fuel ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hydrogen Peroxide (H₂O₂) and Hydrogen as Fuel',
  content: <<~MARKDOWN,
# Hydrogen Peroxide (H₂O₂) and Hydrogen as Fuel 🚀

# Hydrogen Peroxide (H₂O₂)

    ## Structure

    ### Molecular Structure
    - **Non-planar** structure (open book structure)
    - **O-O bond**: Single bond (covalent)
    - **Bond angle** (H-O-O): 97°
    - **Dihedral angle**: 111.5° (in gas phase)

    ### Bonding
    - Each oxygen has sp³ hybridization
    - Two O-H bonds, one O-O bond
    - Two lone pairs on each oxygen

    ---

    ## Preparation

    ### Laboratory Preparation

    #### Method 1: From Barium Peroxide
    **Reaction**: Acid treatment of BaO₂
    - BaO₂ + H₂SO₄ (cold, dilute) → BaSO₄↓ + H₂O₂

    **Advantage**: Simple, gives dilute H₂O₂
    **Disadvantage**: BaSO₄ precipitate must be filtered

    #### Method 2: From Sodium Peroxide
    - Na₂O₂ + H₂SO₄ (cold) → Na₂SO₄ + H₂O₂
    - 2Na₂O₂ + 2H₂O (ice cold) → 4NaOH + O₂↑ (side reaction, avoided)

    ### Industrial Preparation

    #### 1. Electrolytic Method (Older)
    **Process**: Electrolysis of 50% H₂SO₄
    - 2H₂SO₄ → H₂S₂O₈ (peroxodisulfuric acid) + 2H⁺ + 2e⁻
    - H₂S₂O₈ + 2H₂O → 2H₂SO₄ + H₂O₂ (hydrolysis)

    #### 2. Auto-oxidation Method (Modern)
    **Process**: 2-ethylanthraquinol cycle

    **Step 1**: Hydrogenation
    - 2-ethylanthraquinone + H₂ → 2-ethylanthraquinol (catalyst: Pd)

    **Step 2**: Oxidation
    - 2-ethylanthraquinol + O₂ → 2-ethylanthraquinone + H₂O₂

    **Advantage**:
    - 2-ethylanthraquinone regenerated (cyclic process)
    - No side products
    - Most economical

    ---

    ## Concentration of H₂O₂

    ### Concentration by Distillation
    - **Cannot use direct distillation** (H₂O₂ decomposes on heating)
    - **Distill under reduced pressure** (40-50°C)
    - Water evaporates, H₂O₂ concentrates in residue

    ### Storage
    - Stored in **plastic or wax-lined glass bottles**
    - **Stabilizers added**: Urea, phosphoric acid (prevent decomposition)
    - Kept in **dark** (light catalyzes decomposition)
    - Kept **cool**

    ---

    ## Physical Properties

    - Colorless, syrupy liquid (pure)
    - Highly associated due to H-bonding
    - Miscible with water in all proportions
    - More dense than water (1.44 g/mL)
    - Boiling point: 150°C (decomposes before boiling)

    ---

    ## Chemical Properties

    ### 1. Decomposition
    **Reaction**: 2H₂O₂ → 2H₂O + O₂↑

    **Catalysts**: MnO₂, Pt, enzymes (catalase)
    - Exothermic reaction
    - Reason for instability

    ### 2. Oxidizing Agent

    H₂O₂ acts as an **oxidizing agent** in both acidic and basic media:

    #### In Acidic Medium
    **Half-reaction**: H₂O₂ + 2H⁺ + 2e⁻ → 2H₂O

    **Examples**:
    1. **Oxidizes Fe²⁺ to Fe³⁺**:
       - 2Fe²⁺ + H₂O₂ + 2H⁺ → 2Fe³⁺ + 2H₂O

    2. **Oxidizes I⁻ to I₂**:
       - 2I⁻ + H₂O₂ + 2H⁺ → I₂ + 2H₂O

    3. **Oxidizes PbS to PbSO₄** (blackened lead sulfide):
       - PbS + 4H₂O₂ → PbSO₄ + 4H₂O (restoration of old paintings)

    #### In Basic Medium
    **Half-reaction**: H₂O₂ + 2e⁻ → 2OH⁻

    **Example**:
    - Cr³⁺ + 3H₂O₂ + 4OH⁻ → 2CrO₄²⁻ (yellow chromate) + 5H₂O

    ### 3. Reducing Agent

    H₂O₂ acts as a **reducing agent** with strong oxidizing agents:

    **Half-reaction**: H₂O₂ → O₂ + 2H⁺ + 2e⁻

    **Examples**:
    1. **Reduces KMnO₄**:
       - 2KMnO₄ + 3H₂SO₄ + 5H₂O₂ → K₂SO₄ + 2MnSO₄ + 8H₂O + 5O₂↑
       - Purple color disappears

    2. **Reduces K₂Cr₂O₇**:
       - K₂Cr₂O₇ + 4H₂SO₄ + 3H₂O₂ → K₂SO₄ + Cr₂(SO₄)₃ + 7H₂O + 3O₂↑
       - Orange color → green color

    3. **Reduces AgNO₃**:
       - 2AgNO₃ + H₂O₂ → 2Ag↓ (black) + 2HNO₃ + O₂↑

    4. **Reduces ozone**:
       - O₃ + H₂O₂ → H₂O + 2O₂

    ### 4. Acidic Nature
    - Very weak acid (pKₐ = 11.6)
    - H₂O₂ ⇌ H⁺ + HO₂⁻

    ---

    ## Strength of H₂O₂ Solutions

    ### Volume Strength
    **Definition**: Volume of O₂ (at STP) liberated by 1 volume of H₂O₂ solution

    **Example**: 10 volume H₂O₂ means:
    - 1 L of this solution liberates 10 L of O₂ at STP
    - 2H₂O₂ → 2H₂O + O₂

    ### Relationship: Volume Strength and Molarity

    **Formula**: Volume strength = Molarity × 11.2

    **Derivation**:
    - 2 mol H₂O₂ → 1 mol O₂ (22.4 L at STP)
    - 1 mol H₂O₂ → 11.2 L O₂
    - 1 M H₂O₂ → 11.2 volume

    **Example**:
    - 20 volume H₂O₂ = 20/11.2 = 1.786 M
    - 3% H₂O₂ ≈ 10 volume (approx.)

    ---

    ## Uses of H₂O₂

    1. **Bleaching agent**:
       - Textiles, paper, hair, wool, silk
       - Environmentally friendly (produces only H₂O + O₂)

    2. **Disinfectant and antiseptic**:
       - 3% solution for wounds (releases O₂, kills anaerobic bacteria)

    3. **Oxidizing agent**:
       - Chemical synthesis
       - Pollution control (oxidizes pollutants)

    4. **Rocket propellant**:
       - Concentrated H₂O₂ (90%) used in torpedoes, rockets

    5. **Restoration of art**:
       - Restores blackened lead paintings: PbS → PbSO₄ (white)

    ---

    ## Hydrogen as Fuel

    ### Why Hydrogen?

    **Advantages**:
    1. **Clean fuel**: Only product is water (2H₂ + O₂ → 2H₂O)
    2. **High energy content**: 142 kJ/g (vs 50 kJ/g for gasoline)
    3. **Abundant**: Can be produced from water
    4. **No greenhouse gases**: Zero CO₂ emissions
    5. **Renewable**: From electrolysis using renewable energy

    **Disadvantages**:
    1. **Storage challenges**: Low density, requires compression or liquefaction
    2. **Production cost**: Electrolysis expensive
    3. **Safety concerns**: Highly flammable, explosive mixtures with air
    4. **Infrastructure**: Requires new distribution systems

    ---

    ## Hydrogen Fuel Cells

    ### What is a Fuel Cell?
    - **Electrochemical device** that converts chemical energy directly to electrical energy
    - Continuous supply of fuel (H₂) and oxidant (O₂)
    - No combustion (no Carnot cycle limitations)

    ### Working Principle

    **Anode (oxidation)**: H₂ → 2H⁺ + 2e⁻

    **Cathode (reduction)**: O₂ + 4H⁺ + 4e⁻ → 2H₂O

    **Overall**: 2H₂ + O₂ → 2H₂O + Electrical energy + Heat

    ### Types of Fuel Cells

    1. **Proton Exchange Membrane (PEM)**: Low temperature (60-80°C), vehicles
    2. **Alkaline Fuel Cell (AFC)**: Used in space shuttles
    3. **Solid Oxide Fuel Cell (SOFC)**: High temperature (800-1000°C), stationary power

    ### Advantages of Fuel Cells
    - **High efficiency**: 60-80% (vs 25-30% for internal combustion)
    - **No pollution**: Only water as byproduct
    - **Silent operation**: No moving parts
    - **Modular**: Can be scaled up or down

    ### Applications
    1. **Space missions**: Apollo, Space Shuttle (drinking water + electricity)
    2. **Vehicles**: Hydrogen cars (Toyota Mirai, Hyundai Nexo)
    3. **Portable power**: Laptops, mobile phones
    4. **Stationary power**: Backup power, grid support

    ---

    ## Future of Hydrogen Economy

    ### Hydrogen Production
    - **Green hydrogen**: From renewable energy + electrolysis
    - **Blue hydrogen**: From natural gas + carbon capture
    - **Biological**: From algae, bacteria

    ### Challenges
    1. Cost reduction
    2. Storage technology
    3. Distribution infrastructure
    4. Safety protocols

    ---

    ## Key Points for IIT JEE

    1. **H₂O₂ structure**: Non-planar, open book, dihedral angle 111.5°
    2. **Preparation**: BaO₂ + H₂SO₄ (lab), auto-oxidation of 2-ethylanthraquinol (industrial)
    3. **Dual nature**: Both oxidizing and reducing agent
    4. **Oxidizing**: Fe²⁺ → Fe³⁺, I⁻ → I₂, PbS → PbSO₄
    5. **Reducing**: KMnO₄ (purple → colorless), K₂Cr₂O₇ (orange → green)
    6. **Volume strength**: Molarity × 11.2 = Volume strength
    7. **Storage**: Dark bottles, stabilizers (urea, H₃PO₄), cool place
    8. **Fuel cells**: 2H₂ + O₂ → 2H₂O + electricity (clean, efficient)
    9. **Decomposition**: 2H₂O₂ → 2H₂O + O₂ (catalyzed by MnO₂)

## Key Points

- Hydrogen peroxide structure

- Preparation

- Properties
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Hydrogen peroxide structure', 'Preparation', 'Properties', 'Redox reactions', 'Hydrogen fuel cells'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Hydrogen: Position, Isotopes, and Preparation ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hydrogen: Position, Isotopes, and Preparation',
  content: <<~MARKDOWN,
# Hydrogen: Position, Isotopes, and Preparation 🚀

# Hydrogen - Introduction

    ## Position in Periodic Table

    ### Unique Position
    Hydrogen has a **unique and controversial position** in the periodic table:

    #### Resemblance to Alkali Metals (Group 1)
    **Similarities**:
    - Electronic configuration: 1s¹ (one electron in outermost shell)
    - Forms H⁺ ion (like Na⁺, K⁺)
    - Forms hydrides (like NaH, KH)
    - Electropositive character

    #### Resemblance to Halogens (Group 17)
    **Similarities**:
    - Needs one electron to complete shell (like F, Cl)
    - Forms H⁻ ion (like Cl⁻, Br⁻)
    - Diatomic molecule H₂ (like F₂, Cl₂)
    - Forms covalent compounds

    #### Differences from Both
    - Much smaller size than alkali metals
    - Higher ionization energy than alkali metals
    - Lower electron affinity than halogens
    - Non-metallic character (unlike alkali metals)

    **Conclusion**: Hydrogen is placed in Group 1 but has unique properties distinct from both groups.

    ---

    ## Isotopes of Hydrogen

    Hydrogen has **three naturally occurring isotopes**:

    | Isotope | Symbol | Atomic Mass | Abundance | Name |
    |---------|--------|-------------|-----------|------|
    | ¹H | H or ¹₁H | 1 amu | 99.985% | **Protium** (Ordinary hydrogen) |
    | ²H | D or ²₁H | 2 amu | 0.015% | **Deuterium** (Heavy hydrogen) |
    | ³H | T or ³₁H | 3 amu | Trace (radioactive) | **Tritium** |

    ### 1. Protium (¹H)
    - Most abundant isotope
    - Nucleus: 1 proton, 0 neutrons
    - Symbol: H
    - Forms H₂ molecules

    ### 2. Deuterium (²H or D)
    - **Heavy hydrogen**
    - Nucleus: 1 proton, 1 neutron
    - Symbol: D or ²H
    - Forms D₂ molecules
    - Found in heavy water (D₂O)

    **Key properties**:
    - Twice as heavy as protium
    - D₂O has higher boiling point (101.4°C) than H₂O (100°C)
    - Slower reaction rates (kinetic isotope effect)
    - Used as moderator in nuclear reactors

    ### 3. Tritium (³H or T)
    - Radioactive isotope
    - Nucleus: 1 proton, 2 neutrons
    - Symbol: T or ³H
    - Half-life: 12.3 years
    - Beta emitter: ³H → ³He + β⁻

    **Uses**:
    - Radioactive tracer
    - Self-luminous paints
    - Thermonuclear fusion reactions

    ---

    ## Occurrence of Hydrogen

    ### Free State
    - Very rare in Earth's atmosphere (0.00005%)
    - Abundant in Sun and stars (75% by mass)
    - Interstellar space contains H₂

    ### Combined State
    - **Water** (H₂O): Most abundant compound
    - **Hydrocarbons**: Petroleum, natural gas (CH₄)
    - **Carbohydrates**: Glucose (C₆H₁₂O₆)
    - **Proteins and fats**: Essential component
    - **Minerals**: Clay, feldspar

    ---

    ## Preparation of Hydrogen

    ### Laboratory Preparation

    #### Method 1: Reaction with Dilute Acids
    **Reagents**: Zinc (or other active metals) + dilute HCl or H₂SO₄

    **Reaction**:
    - Zn + 2HCl → ZnCl₂ + H₂↑
    - Zn + H₂SO₄ → ZnSO₄ + H₂↑

    **Why not concentrated acids?**
    - Concentrated H₂SO₄ is oxidizing: Zn + 2H₂SO₄(conc.) → ZnSO₄ + SO₂ + 2H₂O (no H₂)
    - Concentrated HNO₃ is oxidizing: produces NOx gases

    #### Method 2: Reaction of Metals with Alkalis
    **Reagents**: Aluminum or zinc + NaOH or KOH

    **Reactions**:
    - 2Al + 2NaOH + 2H₂O → 2NaAlO₂ + 3H₂↑
    - Zn + 2NaOH → Na₂ZnO₂ + H₂↑

    **Advantage**: Can use less reactive metals

    #### Method 3: Hydrolysis of Hydrides
    **Example**: Metal hydrides react with water

    - NaH + H₂O → NaOH + H₂↑
    - CaH₂ + 2H₂O → Ca(OH)₂ + 2H₂↑

    ---

    ### Industrial Preparation

    #### 1. Electrolysis of Water
    **Process**: Passing electricity through acidified water

    **Reactions**:
    - **At cathode** (reduction): 2H⁺ + 2e⁻ → H₂↑
    - **At anode** (oxidation): 2OH⁻ → H₂O + ½O₂↑ + 2e⁻

    **Overall**: 2H₂O → 2H₂ + O₂

    **Advantages**:
    - Very pure hydrogen (99.9%)
    - Produces oxygen as byproduct

    **Disadvantages**:
    - Expensive (high electricity cost)

    #### 2. Bosch Process (Coal Gasification)
    **Step 1**: Water gas production
    - C + H₂O → CO + H₂ (water gas, at 1000°C)

    **Step 2**: Water gas shift reaction
    - CO + H₂O → CO₂ + H₂ (at 400°C, Fe₂O₃/Cr₂O₃ catalyst)

    **Step 3**: Remove CO₂
    - CO₂ absorbed in K₂CO₃ solution

    **Net**: C + 2H₂O → CO₂ + 2H₂

    #### 3. Lane's Process
    **Reaction**: Alternate steam and hot iron
    - **Step 1**: 3Fe + 4H₂O → Fe₃O₄ + 4H₂ (steam passed over hot iron at 700°C)
    - **Step 2**: Fe₃O₄ + 4CO → 3Fe + 4CO₂ (regenerate iron using water gas)

    #### 4. Steam Reforming of Hydrocarbons
    **Most common industrial method**

    **Reaction**: Methane + steam
    - CH₄ + H₂O → CO + 3H₂ (at 850°C, Ni catalyst)
    - CO + H₂O → CO₂ + H₂ (shift reaction)

    **Net**: CH₄ + 2H₂O → CO₂ + 4H₂

    **Advantage**: Cheapest large-scale method

    ---

    ## Properties of Hydrogen

    ### Physical Properties
    - Colorless, odorless, tasteless gas
    - Lightest element (density = 0.089 g/L at STP)
    - Diatomic molecule (H₂)
    - Very low boiling point (-253°C)
    - Sparingly soluble in water
    - Highly flammable

    ### Chemical Properties

    #### 1. Combustion
    - 2H₂ + O₂ → 2H₂O (highly exothermic)
    - Burns with pale blue flame
    - Explosive mixture with air (4-74% H₂)

    #### 2. Reducing Agent
    - Reduces metal oxides to metals:
      - CuO + H₂ → Cu + H₂O
      - Fe₃O₄ + 4H₂ → 3Fe + 4H₂O

    #### 3. Reaction with Non-metals
    - With nitrogen: N₂ + 3H₂ → 2NH₃ (Haber process, high P, T, catalyst)
    - With sulfur: S + H₂ → H₂S
    - With halogens: H₂ + Cl₂ → 2HCl (explosive in sunlight)

    #### 4. Reaction with Metals
    - Forms hydrides:
      - 2Na + H₂ → 2NaH (sodium hydride)
      - Ca + H₂ → CaH₂ (calcium hydride)

    ---

    ## Atomic vs Nascent Hydrogen

    ### Nascent Hydrogen [H]
    - **Definition**: Hydrogen at the moment of generation (atomic form)
    - **Symbol**: [H] or H
    - More reactive than H₂ molecular hydrogen
    - Produced during chemical reactions:
      - Zn + H₂SO₄ → ZnSO₄ + 2[H] → ZnSO₄ + H₂

    **Why more reactive?**
    - No need to break H-H bond (bond dissociation energy = 436 kJ/mol)
    - Higher energy state

    **Applications**:
    - Reduction of unsaturated compounds
    - More effective reducing agent

    ---

    ## Uses of Hydrogen

    1. **Haber process**: Ammonia synthesis (NH₃)
    2. **Hydrogenation**: Vegetable oils → solid fats (margarine)
    3. **Rocket fuel**: Liquid H₂ in space rockets
    4. **Fuel cells**: Clean energy source (H₂ + O₂ → H₂O + energy)
    5. **Synthesis**: HCl, methanol production
    6. **Metallurgy**: Reducing agent for metal extraction
    7. **Weather balloons**: Low density (replaced by He for safety)

    ---

    ## Key Points for IIT JEE

    1. **Unique position**: Hydrogen resembles both Group 1 and Group 17
    2. **Three isotopes**: Protium (99.985%), Deuterium (0.015%), Tritium (radioactive)
    3. **Lab preparation**: Zn + dil. H₂SO₄ (not conc. H₂SO₄ or HNO₃)
    4. **Industrial methods**: Electrolysis (purest), Bosch process, steam reforming (cheapest)
    5. **Nascent hydrogen**: Atomic form [H], more reactive than H₂
    6. **D₂O properties**: Higher bp (101.4°C), used as moderator
    7. **Water gas**: CO + H₂ (produced from C + H₂O)

## Key Points

- Periodic table position

- Isotopes

- Protium
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Periodic table position', 'Isotopes', 'Protium', 'Deuterium', 'Tritium', 'Preparation methods'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Hydrides, Water Chemistry, and Heavy Water ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hydrides, Water Chemistry, and Heavy Water',
  content: <<~MARKDOWN,
# Hydrides, Water Chemistry, and Heavy Water 🚀

# Hydrides Classification

    ## What are Hydrides?

    **Definition**: Binary compounds of hydrogen with other elements.

    **General formula**: XHₙ or HₙX (X = any element)

    Hydrides are classified into three main types based on bonding:

    ---

    ## 1. Ionic (Saline) Hydrides

    ### Formation
    - Formed by **highly electropositive s-block metals** (Group 1, Group 2 heavier elements)
    - Elements: Na, K, Ca, Ba (not Be, Mg)

    **Examples**: NaH, KH, CaH₂, BaH₂

    ### Characteristics
    - **Stoichiometric compounds** (definite formula)
    - **Crystalline solids** (ionic lattice)
    - **High melting points** (strong ionic bonds)
    - Contain **H⁻ ion** (hydride ion)
    - Conduct electricity in molten state

    ### Chemical Properties
    #### Reaction with Water (Vigorous)
    - NaH + H₂O → NaOH + H₂↑
    - CaH₂ + 2H₂O → Ca(OH)₂ + 2H₂↑

    #### Strong Reducing Agents
    - 4NaH + TiCl₄ → Ti + 4NaCl + 2H₂

    ### Uses
    - **Portable source of hydrogen**
    - **Drying agents** (remove water)
    - **Reducing agents** in organic synthesis

    ---

    ## 2. Covalent (Molecular) Hydrides

    ### Formation
    - Formed by **non-metals and some metalloids**
    - Elements: Groups 13-17 (B, C, N, O, F, Si, P, S, Cl, etc.)

    **Examples**: CH₄, NH₃, H₂O, HF, SiH₄, PH₃, H₂S, HCl

    ### Characteristics
    - **Molecular compounds** (discrete molecules)
    - **Covalent bonds** (electron sharing)
    - **Gases or volatile liquids** at room temperature
    - **Low melting and boiling points** (weak intermolecular forces)
    - **Do not conduct electricity** (no ions)

    ### Classification by Electron Deficiency

    #### A. Electron-Deficient Hydrides
    - **Central atom has incomplete octet**
    - Examples: B₂H₆ (diborane), BH₃

    **Diborane Structure**:
    - B₂H₆ has 3-center-2-electron bonds (banana bonds)
    - Bridge hydrogen atoms

    #### B. Electron-Precise Hydrides
    - **Central atom has complete octet**
    - Examples: CH₄, SiH₄, GeH₄

    **Characteristics**:
    - No lone pairs on central atom
    - Tetrahedral geometry

    #### C. Electron-Rich Hydrides
    - **Central atom has lone pairs** (excess electrons)
    - Examples: NH₃ (1 lone pair), H₂O (2 lone pairs), HF (3 lone pairs)

    **Characteristics**:
    - Can act as Lewis bases (electron donors)
    - Form hydrogen bonds
    - Higher boiling points due to H-bonding

    ### Hydrogen Bonding

    **Occurs in**: H₂O, HF, NH₃ (H bonded to N, O, F)

    **Effects**:
    - Abnormally high boiling points
    - Water: H-bonding makes ice less dense than water
    - HF: Associates as (HF)ₙ polymer

    **Boiling point order**:
    - Group 15: NH₃ > PH₃ < AsH₃ < SbH₃ (H-bonding in NH₃)
    - Group 16: H₂O > H₂S < H₂Se < H₂Te (H-bonding in H₂O)
    - Group 17: HF > HCl < HBr < HI (H-bonding in HF)

    ---

    ## 3. Metallic (Interstitial) Hydrides

    ### Formation
    - Formed by **d-block and f-block metals**
    - Examples: TiH₁.₇, ZrH₂, VH₀.₅₆, PdH₀.₆

    ### Characteristics
    - **Non-stoichiometric** (variable composition)
    - H atoms occupy **interstitial spaces** in metal lattice
    - Retain metallic properties
    - Conduct electricity
    - Lower density than parent metal
    - Hard and brittle

    ### Uses
    - **Hydrogen storage materials**
    - **Catalysts** (Pd absorbs H₂)
    - **Reducing agents** in metallurgy

    ---

    ## Water (H₂O)

    ### Occurrence
    - Covers 71% of Earth's surface
    - Essential for life
    - Exists in three states (ice, water, vapor)

    ### Physical Properties
    - Colorless, odorless, tasteless liquid
    - Maximum density at 4°C (anomalous)
    - High boiling point (100°C) due to H-bonding
    - Excellent solvent (universal solvent)

    ### Amphoteric Nature
    - Acts as both acid and base:
      - **As acid**: H₂O + NH₃ → NH₄⁺ + OH⁻
      - **As base**: H₂O + HCl → H₃O⁺ + Cl⁻

    ### Chemical Reactions

    #### 1. Hydrolysis Reactions
    - P₄O₁₀ + 6H₂O → 4H₃PO₄
    - CaO + H₂O → Ca(OH)₂
    - NH₃ + H₂O → NH₄OH

    #### 2. Hydration
    - CuSO₄ (anhydrous, white) + 5H₂O → CuSO₄·5H₂O (blue)

    ---

    ## Hard Water vs Soft Water

    ### Hard Water
    **Definition**: Water that does not form lather easily with soap (contains Ca²⁺, Mg²⁺ salts)

    ### Types of Hardness

    #### 1. Temporary Hardness (Carbonate Hardness)
    **Cause**: Presence of bicarbonates of Ca²⁺ and Mg²⁺
    - Ca(HCO₃)₂, Mg(HCO₃)₂

    **Removal**: By boiling
    - Ca(HCO₃)₂ → CaCO₃↓ + H₂O + CO₂↑
    - Mg(HCO₃)₂ → MgCO₃↓ + H₂O + CO₂↑

    **Removal**: By Clark's method (adding lime)
    - Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O

    #### 2. Permanent Hardness (Non-carbonate Hardness)
    **Cause**: Presence of sulfates and chlorides of Ca²⁺ and Mg²⁺
    - CaSO₄, MgSO₄, CaCl₂, MgCl₂

    **Cannot be removed by boiling**

    **Removal methods**:

    **A. Washing Soda Method**
    - CaSO₄ + Na₂CO₃ → CaCO₃↓ + Na₂SO₄
    - MgCl₂ + Na₂CO₃ → MgCO₃↓ + 2NaCl

    **B. Ion Exchange (Permutit/Zeolite) Method**
    - Na₂Z (zeolite) + Ca²⁺ → CaZ + 2Na⁺
    - Zeolite can be regenerated: CaZ + 2NaCl → Na₂Z + CaCl₂

    **C. Calgon Method**
    - Sodium hexametaphosphate: Na₂[Na₄(PO₃)₆]
    - 2Ca²⁺ + Na₂[Na₄(PO₃)₆] → Na₂[Ca₂(PO₃)₆] + 4Na⁺
    - Forms soluble complex

    ### Soft Water
    - Water that readily forms lather with soap
    - Free from Ca²⁺ and Mg²⁺ salts
    - Examples: Rainwater, distilled water

    ---

    ## Heavy Water (D₂O)

    ### Preparation

    #### 1. Electrolysis of Water
    - Ordinary water (H₂O) preferentially electrolyzed
    - D₂O concentration increases in residue
    - Very inefficient (30 L water → 1 mL D₂O)

    #### 2. Fractional Distillation
    - D₂O has higher bp (101.4°C) than H₂O (100°C)
    - D₂O concentrates in residue

    #### 3. Exchange Reaction (Best Method)
    - H₂S + D₂O ⇌ HDO + HDS (at different temperatures)
    - By shifting equilibrium, D₂O separated

    ### Physical Properties Comparison

    | Property | H₂O | D₂O |
    |----------|-----|-----|
    | Molecular mass | 18 | 20 |
    | Melting point | 0°C | 3.82°C |
    | Boiling point | 100°C | 101.4°C |
    | Density (at 25°C) | 1.0 g/mL | 1.11 g/mL |
    | Viscosity | Lower | Higher |

    ### Chemical Properties
    - **Slower reactions** than H₂O (kinetic isotope effect)
    - Does not support life (toxic to living organisms)
    - Exchange with H in compounds:
      - NaH + D₂O → NaOD + HD↑
      - Al₄C₃ + 12D₂O → 4Al(OD)₃ + 3CD₄↑

    ### Uses of D₂O
    1. **Moderator in nuclear reactors**: Slows down neutrons without absorbing them
    2. **Tracer in reaction mechanisms**: Study reaction pathways
    3. **NMR spectroscopy**: Solvent (no H signal interference)
    4. **Preparation of deuterated compounds**: D₂SO₄, CD₄, etc.

    ---

    ## Key Points for IIT JEE

    1. **Ionic hydrides**: Formed by Group 1, 2 metals; contain H⁻; react vigorously with water
    2. **Covalent hydrides**: Electron-deficient (B₂H₆), electron-precise (CH₄), electron-rich (NH₃, H₂O)
    3. **Interstitial hydrides**: Non-stoichiometric; d-block metals; hydrogen storage
    4. **H-bonding**: NH₃, H₂O, HF have abnormally high bp
    5. **Hard water**: Temporary (bicarbonates, removed by boiling) vs Permanent (sulfates/chlorides)
    6. **Removal of hardness**: Clark's method (lime), washing soda, zeolite, Calgon
    7. **D₂O**: Higher bp (101.4°C), used as moderator in nuclear reactors
    8. **Diborane**: B₂H₆ has 3-center-2-electron bonds

## Key Points

- Ionic hydrides

- Covalent hydrides

- Interstitial hydrides
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ionic hydrides', 'Covalent hydrides', 'Interstitial hydrides', 'Hard water', 'Soft water', 'Heavy water D₂O'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Hydrogen Peroxide (H₂O₂) and Hydrogen as Fuel ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hydrogen Peroxide (H₂O₂) and Hydrogen as Fuel',
  content: <<~MARKDOWN,
# Hydrogen Peroxide (H₂O₂) and Hydrogen as Fuel 🚀

# Hydrogen Peroxide (H₂O₂)

    ## Structure

    ### Molecular Structure
    - **Non-planar** structure (open book structure)
    - **O-O bond**: Single bond (covalent)
    - **Bond angle** (H-O-O): 97°
    - **Dihedral angle**: 111.5° (in gas phase)

    ### Bonding
    - Each oxygen has sp³ hybridization
    - Two O-H bonds, one O-O bond
    - Two lone pairs on each oxygen

    ---

    ## Preparation

    ### Laboratory Preparation

    #### Method 1: From Barium Peroxide
    **Reaction**: Acid treatment of BaO₂
    - BaO₂ + H₂SO₄ (cold, dilute) → BaSO₄↓ + H₂O₂

    **Advantage**: Simple, gives dilute H₂O₂
    **Disadvantage**: BaSO₄ precipitate must be filtered

    #### Method 2: From Sodium Peroxide
    - Na₂O₂ + H₂SO₄ (cold) → Na₂SO₄ + H₂O₂
    - 2Na₂O₂ + 2H₂O (ice cold) → 4NaOH + O₂↑ (side reaction, avoided)

    ### Industrial Preparation

    #### 1. Electrolytic Method (Older)
    **Process**: Electrolysis of 50% H₂SO₄
    - 2H₂SO₄ → H₂S₂O₈ (peroxodisulfuric acid) + 2H⁺ + 2e⁻
    - H₂S₂O₈ + 2H₂O → 2H₂SO₄ + H₂O₂ (hydrolysis)

    #### 2. Auto-oxidation Method (Modern)
    **Process**: 2-ethylanthraquinol cycle

    **Step 1**: Hydrogenation
    - 2-ethylanthraquinone + H₂ → 2-ethylanthraquinol (catalyst: Pd)

    **Step 2**: Oxidation
    - 2-ethylanthraquinol + O₂ → 2-ethylanthraquinone + H₂O₂

    **Advantage**:
    - 2-ethylanthraquinone regenerated (cyclic process)
    - No side products
    - Most economical

    ---

    ## Concentration of H₂O₂

    ### Concentration by Distillation
    - **Cannot use direct distillation** (H₂O₂ decomposes on heating)
    - **Distill under reduced pressure** (40-50°C)
    - Water evaporates, H₂O₂ concentrates in residue

    ### Storage
    - Stored in **plastic or wax-lined glass bottles**
    - **Stabilizers added**: Urea, phosphoric acid (prevent decomposition)
    - Kept in **dark** (light catalyzes decomposition)
    - Kept **cool**

    ---

    ## Physical Properties

    - Colorless, syrupy liquid (pure)
    - Highly associated due to H-bonding
    - Miscible with water in all proportions
    - More dense than water (1.44 g/mL)
    - Boiling point: 150°C (decomposes before boiling)

    ---

    ## Chemical Properties

    ### 1. Decomposition
    **Reaction**: 2H₂O₂ → 2H₂O + O₂↑

    **Catalysts**: MnO₂, Pt, enzymes (catalase)
    - Exothermic reaction
    - Reason for instability

    ### 2. Oxidizing Agent

    H₂O₂ acts as an **oxidizing agent** in both acidic and basic media:

    #### In Acidic Medium
    **Half-reaction**: H₂O₂ + 2H⁺ + 2e⁻ → 2H₂O

    **Examples**:
    1. **Oxidizes Fe²⁺ to Fe³⁺**:
       - 2Fe²⁺ + H₂O₂ + 2H⁺ → 2Fe³⁺ + 2H₂O

    2. **Oxidizes I⁻ to I₂**:
       - 2I⁻ + H₂O₂ + 2H⁺ → I₂ + 2H₂O

    3. **Oxidizes PbS to PbSO₄** (blackened lead sulfide):
       - PbS + 4H₂O₂ → PbSO₄ + 4H₂O (restoration of old paintings)

    #### In Basic Medium
    **Half-reaction**: H₂O₂ + 2e⁻ → 2OH⁻

    **Example**:
    - Cr³⁺ + 3H₂O₂ + 4OH⁻ → 2CrO₄²⁻ (yellow chromate) + 5H₂O

    ### 3. Reducing Agent

    H₂O₂ acts as a **reducing agent** with strong oxidizing agents:

    **Half-reaction**: H₂O₂ → O₂ + 2H⁺ + 2e⁻

    **Examples**:
    1. **Reduces KMnO₄**:
       - 2KMnO₄ + 3H₂SO₄ + 5H₂O₂ → K₂SO₄ + 2MnSO₄ + 8H₂O + 5O₂↑
       - Purple color disappears

    2. **Reduces K₂Cr₂O₇**:
       - K₂Cr₂O₇ + 4H₂SO₄ + 3H₂O₂ → K₂SO₄ + Cr₂(SO₄)₃ + 7H₂O + 3O₂↑
       - Orange color → green color

    3. **Reduces AgNO₃**:
       - 2AgNO₃ + H₂O₂ → 2Ag↓ (black) + 2HNO₃ + O₂↑

    4. **Reduces ozone**:
       - O₃ + H₂O₂ → H₂O + 2O₂

    ### 4. Acidic Nature
    - Very weak acid (pKₐ = 11.6)
    - H₂O₂ ⇌ H⁺ + HO₂⁻

    ---

    ## Strength of H₂O₂ Solutions

    ### Volume Strength
    **Definition**: Volume of O₂ (at STP) liberated by 1 volume of H₂O₂ solution

    **Example**: 10 volume H₂O₂ means:
    - 1 L of this solution liberates 10 L of O₂ at STP
    - 2H₂O₂ → 2H₂O + O₂

    ### Relationship: Volume Strength and Molarity

    **Formula**: Volume strength = Molarity × 11.2

    **Derivation**:
    - 2 mol H₂O₂ → 1 mol O₂ (22.4 L at STP)
    - 1 mol H₂O₂ → 11.2 L O₂
    - 1 M H₂O₂ → 11.2 volume

    **Example**:
    - 20 volume H₂O₂ = 20/11.2 = 1.786 M
    - 3% H₂O₂ ≈ 10 volume (approx.)

    ---

    ## Uses of H₂O₂

    1. **Bleaching agent**:
       - Textiles, paper, hair, wool, silk
       - Environmentally friendly (produces only H₂O + O₂)

    2. **Disinfectant and antiseptic**:
       - 3% solution for wounds (releases O₂, kills anaerobic bacteria)

    3. **Oxidizing agent**:
       - Chemical synthesis
       - Pollution control (oxidizes pollutants)

    4. **Rocket propellant**:
       - Concentrated H₂O₂ (90%) used in torpedoes, rockets

    5. **Restoration of art**:
       - Restores blackened lead paintings: PbS → PbSO₄ (white)

    ---

    ## Hydrogen as Fuel

    ### Why Hydrogen?

    **Advantages**:
    1. **Clean fuel**: Only product is water (2H₂ + O₂ → 2H₂O)
    2. **High energy content**: 142 kJ/g (vs 50 kJ/g for gasoline)
    3. **Abundant**: Can be produced from water
    4. **No greenhouse gases**: Zero CO₂ emissions
    5. **Renewable**: From electrolysis using renewable energy

    **Disadvantages**:
    1. **Storage challenges**: Low density, requires compression or liquefaction
    2. **Production cost**: Electrolysis expensive
    3. **Safety concerns**: Highly flammable, explosive mixtures with air
    4. **Infrastructure**: Requires new distribution systems

    ---

    ## Hydrogen Fuel Cells

    ### What is a Fuel Cell?
    - **Electrochemical device** that converts chemical energy directly to electrical energy
    - Continuous supply of fuel (H₂) and oxidant (O₂)
    - No combustion (no Carnot cycle limitations)

    ### Working Principle

    **Anode (oxidation)**: H₂ → 2H⁺ + 2e⁻

    **Cathode (reduction)**: O₂ + 4H⁺ + 4e⁻ → 2H₂O

    **Overall**: 2H₂ + O₂ → 2H₂O + Electrical energy + Heat

    ### Types of Fuel Cells

    1. **Proton Exchange Membrane (PEM)**: Low temperature (60-80°C), vehicles
    2. **Alkaline Fuel Cell (AFC)**: Used in space shuttles
    3. **Solid Oxide Fuel Cell (SOFC)**: High temperature (800-1000°C), stationary power

    ### Advantages of Fuel Cells
    - **High efficiency**: 60-80% (vs 25-30% for internal combustion)
    - **No pollution**: Only water as byproduct
    - **Silent operation**: No moving parts
    - **Modular**: Can be scaled up or down

    ### Applications
    1. **Space missions**: Apollo, Space Shuttle (drinking water + electricity)
    2. **Vehicles**: Hydrogen cars (Toyota Mirai, Hyundai Nexo)
    3. **Portable power**: Laptops, mobile phones
    4. **Stationary power**: Backup power, grid support

    ---

    ## Future of Hydrogen Economy

    ### Hydrogen Production
    - **Green hydrogen**: From renewable energy + electrolysis
    - **Blue hydrogen**: From natural gas + carbon capture
    - **Biological**: From algae, bacteria

    ### Challenges
    1. Cost reduction
    2. Storage technology
    3. Distribution infrastructure
    4. Safety protocols

    ---

    ## Key Points for IIT JEE

    1. **H₂O₂ structure**: Non-planar, open book, dihedral angle 111.5°
    2. **Preparation**: BaO₂ + H₂SO₄ (lab), auto-oxidation of 2-ethylanthraquinol (industrial)
    3. **Dual nature**: Both oxidizing and reducing agent
    4. **Oxidizing**: Fe²⁺ → Fe³⁺, I⁻ → I₂, PbS → PbSO₄
    5. **Reducing**: KMnO₄ (purple → colorless), K₂Cr₂O₇ (orange → green)
    6. **Volume strength**: Molarity × 11.2 = Volume strength
    7. **Storage**: Dark bottles, stabilizers (urea, H₃PO₄), cool place
    8. **Fuel cells**: 2H₂ + O₂ → 2H₂O + electricity (clean, efficient)
    9. **Decomposition**: 2H₂O₂ → 2H₂O + O₂ (catalyzed by MnO₂)

## Key Points

- Hydrogen peroxide structure

- Preparation

- Properties
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Hydrogen peroxide structure', 'Preparation', 'Properties', 'Redox reactions', 'Hydrogen fuel cells'],
  prerequisite_ids: []
)

# === MICROLESSON 7: hydrogen_isotopes — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'hydrogen_isotopes — Practice',
  content: <<~MARKDOWN,
# hydrogen_isotopes — Practice 🚀

Tritium (³H or T) is the radioactive isotope of hydrogen with a half-life of 12.3 years. It is a beta emitter: ³H → ³He + β⁻. Protium and deuterium are stable.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['hydrogen_isotopes'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which isotope of hydrogen is radioactive?',
    options: ['Protium', 'Deuterium', 'Tritium', 'All isotopes are radioactive'],
    correct_answer: 2,
    explanation: 'Tritium (³H or T) is the radioactive isotope of hydrogen with a half-life of 12.3 years. It is a beta emitter: ³H → ³He + β⁻. Protium and deuterium are stable.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: hydrides_classification — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'hydrides_classification — Practice',
  content: <<~MARKDOWN,
# hydrides_classification — Practice 🚀

Ionic hydrides are formed by highly electropositive s-block metals (Group 1 and heavier Group 2 elements). NaH and CaH₂ are ionic hydrides containing H⁻ ion. NH₃ and SiH₄ are covalent hydrides.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['hydrides_classification'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are ionic (saline) hydrides?',
    options: ['NaH', 'CaH₂', 'NH₃', 'SiH₄'],
    correct_answer: 1,
    explanation: 'Ionic hydrides are formed by highly electropositive s-block metals (Group 1 and heavier Group 2 elements). NaH and CaH₂ are ionic hydrides containing H⁻ ion. NH₃ and SiH₄ are covalent hydrides.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: heavy_water — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'heavy_water — Practice',
  content: <<~MARKDOWN,
# heavy_water — Practice 🚀

Heavy water (D₂O) has a boiling point of 101.4°C, which is higher than normal water (100°C) due to stronger hydrogen bonding caused by the heavier deuterium atoms.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['heavy_water'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Heavy water (D₂O) has a boiling point of ________ °C.',
    answer: '101.4',
    explanation: 'Heavy water (D₂O) has a boiling point of 101.4°C, which is higher than normal water (100°C) due to stronger hydrogen bonding caused by the heavier deuterium atoms.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: water_chemistry — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'water_chemistry — Practice',
  content: <<~MARKDOWN,
# water_chemistry — Practice 🚀

Temporary hardness is caused by bicarbonates Ca(HCO₃)₂ and Mg(HCO₃)₂, which decompose on boiling: Ca(HCO₃)₂ → CaCO₃↓ + H₂O + CO₂↑. Washing soda and ion exchange remove permanent hardness.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['water_chemistry'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Temporary hardness of water can be removed by:',
    options: ['Boiling', 'Adding washing soda', 'Ion exchange method', 'Distillation'],
    correct_answer: 0,
    explanation: 'Temporary hardness is caused by bicarbonates Ca(HCO₃)₂ and Mg(HCO₃)₂, which decompose on boiling: Ca(HCO₃)₂ → CaCO₃↓ + H₂O + CO₂↑. Washing soda and ion exchange remove permanent hardness.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: hydrogen_peroxide — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'hydrogen_peroxide — Practice',
  content: <<~MARKDOWN,
# hydrogen_peroxide — Practice 🚀

Volume strength = Molarity × 11.2. Therefore, Molarity = Volume strength / 11.2 = 22.4 / 11.2 = 2.0 M. This relationship comes from the fact that 1 mole of H₂O₂ produces 11.2 L of O₂ at STP.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['hydrogen_peroxide'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the molarity of H₂O₂ solution that has a volume strength of 22.4. (Answer in mol/L)',
    answer: '2.0',
    explanation: 'Volume strength = Molarity × 11.2. Therefore, Molarity = Volume strength / 11.2 = 22.4 / 11.2 = 2.0 M. This relationship comes from the fact that 1 mole of H₂O₂ produces 11.2 L of O₂ at STP.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: hydrogen_peroxide_reactions — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'hydrogen_peroxide_reactions — Practice',
  content: <<~MARKDOWN,
# hydrogen_peroxide_reactions — Practice 🚀

H₂O₂ acts as a reducing agent when it reduces strong oxidizing agents like KMnO₄, producing O₂: H₂O₂ → O₂ + 2H⁺ + 2e⁻. In the other reactions, H₂O₂ acts as an oxidizing agent.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['hydrogen_peroxide_reactions'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In which of the following reactions does H₂O₂ act as a reducing agent?',
    options: ['H₂O₂ + 2Fe²⁺ + 2H⁺ → 2Fe³⁺ + 2H₂O', 'H₂O₂ + 2I⁻ + 2H⁺ → I₂ + 2H₂O', '2KMnO₄ + 3H₂SO₄ + 5H₂O₂ → K₂SO₄ + 2MnSO₄ + 8H₂O + 5O₂', 'PbS + 4H₂O₂ → PbSO₄ + 4H₂O'],
    correct_answer: 2,
    explanation: 'H₂O₂ acts as a reducing agent when it reduces strong oxidizing agents like KMnO₄, producing O₂: H₂O₂ → O₂ + 2H⁺ + 2e⁻. In the other reactions, H₂O₂ acts as an oxidizing agent.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 13: covalent_hydrides — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'covalent_hydrides — Practice',
  content: <<~MARKDOWN,
# covalent_hydrides — Practice 🚀

TRUE. Diborane (B₂H₆) is an electron-deficient hydride because boron has only 6 electrons (incomplete octet). It contains unique 3-center-2-electron bonds (banana bonds) involving bridge hydrogen atoms.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['covalent_hydrides'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Diborane (B₂H₆) is an electron-deficient hydride with 3-center-2-electron bonds.',
    answer: 'true',
    explanation: 'TRUE. Diborane (B₂H₆) is an electron-deficient hydride because boron has only 6 electrons (incomplete octet). It contains unique 3-center-2-electron bonds (banana bonds) involving bridge hydrogen atoms.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: hydrogen_preparation — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'hydrogen_preparation — Practice',
  content: <<~MARKDOWN,
# hydrogen_preparation — Practice 🚀

Steam reforming of methane (CH₄ + H₂O → CO + 3H₂, followed by CO + H₂O → CO₂ + H₂) is the most economical large-scale method. Electrolysis produces very pure H₂ but is expensive.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['hydrogen_preparation'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The most economical industrial method for large-scale hydrogen production is:',
    options: ['Electrolysis of water', 'Steam reforming of methane', 'Bosch process'],
    correct_answer: 1,
    explanation: 'Steam reforming of methane (CH₄ + H₂O → CO + 3H₂, followed by CO + H₂O → CO₂ + H₂) is the most economical large-scale method. Electrolysis produces very pure H₂ but is expensive.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 15: heavy_water_properties — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'heavy_water_properties — Practice',
  content: <<~MARKDOWN,
# heavy_water_properties — Practice 🚀

D₂O is used as a moderator in nuclear reactors (slows neutrons), has higher density (1.11 g/mL) than H₂O (1.0 g/mL), is toxic to living organisms, and reacts slower than H₂O due to kinetic isotope effect.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['heavy_water_properties'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are correct about D₂O (heavy water)?',
    options: ['Used as moderator in nuclear reactors', 'Has lower density than H₂O', 'Toxic to living organisms', 'Reacts faster than H₂O'],
    correct_answer: 2,
    explanation: 'D₂O is used as a moderator in nuclear reactors (slows neutrons), has higher density (1.11 g/mL) than H₂O (1.0 g/mL), is toxic to living organisms, and reacts slower than H₂O due to kinetic isotope effect.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 16: Hydrogen: Position, Isotopes, and Preparation ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hydrogen: Position, Isotopes, and Preparation',
  content: <<~MARKDOWN,
# Hydrogen: Position, Isotopes, and Preparation 🚀

# Hydrogen - Introduction

    ## Position in Periodic Table

    ### Unique Position
    Hydrogen has a **unique and controversial position** in the periodic table:

    #### Resemblance to Alkali Metals (Group 1)
    **Similarities**:
    - Electronic configuration: 1s¹ (one electron in outermost shell)
    - Forms H⁺ ion (like Na⁺, K⁺)
    - Forms hydrides (like NaH, KH)
    - Electropositive character

    #### Resemblance to Halogens (Group 17)
    **Similarities**:
    - Needs one electron to complete shell (like F, Cl)
    - Forms H⁻ ion (like Cl⁻, Br⁻)
    - Diatomic molecule H₂ (like F₂, Cl₂)
    - Forms covalent compounds

    #### Differences from Both
    - Much smaller size than alkali metals
    - Higher ionization energy than alkali metals
    - Lower electron affinity than halogens
    - Non-metallic character (unlike alkali metals)

    **Conclusion**: Hydrogen is placed in Group 1 but has unique properties distinct from both groups.

    ---

    ## Isotopes of Hydrogen

    Hydrogen has **three naturally occurring isotopes**:

    | Isotope | Symbol | Atomic Mass | Abundance | Name |
    |---------|--------|-------------|-----------|------|
    | ¹H | H or ¹₁H | 1 amu | 99.985% | **Protium** (Ordinary hydrogen) |
    | ²H | D or ²₁H | 2 amu | 0.015% | **Deuterium** (Heavy hydrogen) |
    | ³H | T or ³₁H | 3 amu | Trace (radioactive) | **Tritium** |

    ### 1. Protium (¹H)
    - Most abundant isotope
    - Nucleus: 1 proton, 0 neutrons
    - Symbol: H
    - Forms H₂ molecules

    ### 2. Deuterium (²H or D)
    - **Heavy hydrogen**
    - Nucleus: 1 proton, 1 neutron
    - Symbol: D or ²H
    - Forms D₂ molecules
    - Found in heavy water (D₂O)

    **Key properties**:
    - Twice as heavy as protium
    - D₂O has higher boiling point (101.4°C) than H₂O (100°C)
    - Slower reaction rates (kinetic isotope effect)
    - Used as moderator in nuclear reactors

    ### 3. Tritium (³H or T)
    - Radioactive isotope
    - Nucleus: 1 proton, 2 neutrons
    - Symbol: T or ³H
    - Half-life: 12.3 years
    - Beta emitter: ³H → ³He + β⁻

    **Uses**:
    - Radioactive tracer
    - Self-luminous paints
    - Thermonuclear fusion reactions

    ---

    ## Occurrence of Hydrogen

    ### Free State
    - Very rare in Earth's atmosphere (0.00005%)
    - Abundant in Sun and stars (75% by mass)
    - Interstellar space contains H₂

    ### Combined State
    - **Water** (H₂O): Most abundant compound
    - **Hydrocarbons**: Petroleum, natural gas (CH₄)
    - **Carbohydrates**: Glucose (C₆H₁₂O₆)
    - **Proteins and fats**: Essential component
    - **Minerals**: Clay, feldspar

    ---

    ## Preparation of Hydrogen

    ### Laboratory Preparation

    #### Method 1: Reaction with Dilute Acids
    **Reagents**: Zinc (or other active metals) + dilute HCl or H₂SO₄

    **Reaction**:
    - Zn + 2HCl → ZnCl₂ + H₂↑
    - Zn + H₂SO₄ → ZnSO₄ + H₂↑

    **Why not concentrated acids?**
    - Concentrated H₂SO₄ is oxidizing: Zn + 2H₂SO₄(conc.) → ZnSO₄ + SO₂ + 2H₂O (no H₂)
    - Concentrated HNO₃ is oxidizing: produces NOx gases

    #### Method 2: Reaction of Metals with Alkalis
    **Reagents**: Aluminum or zinc + NaOH or KOH

    **Reactions**:
    - 2Al + 2NaOH + 2H₂O → 2NaAlO₂ + 3H₂↑
    - Zn + 2NaOH → Na₂ZnO₂ + H₂↑

    **Advantage**: Can use less reactive metals

    #### Method 3: Hydrolysis of Hydrides
    **Example**: Metal hydrides react with water

    - NaH + H₂O → NaOH + H₂↑
    - CaH₂ + 2H₂O → Ca(OH)₂ + 2H₂↑

    ---

    ### Industrial Preparation

    #### 1. Electrolysis of Water
    **Process**: Passing electricity through acidified water

    **Reactions**:
    - **At cathode** (reduction): 2H⁺ + 2e⁻ → H₂↑
    - **At anode** (oxidation): 2OH⁻ → H₂O + ½O₂↑ + 2e⁻

    **Overall**: 2H₂O → 2H₂ + O₂

    **Advantages**:
    - Very pure hydrogen (99.9%)
    - Produces oxygen as byproduct

    **Disadvantages**:
    - Expensive (high electricity cost)

    #### 2. Bosch Process (Coal Gasification)
    **Step 1**: Water gas production
    - C + H₂O → CO + H₂ (water gas, at 1000°C)

    **Step 2**: Water gas shift reaction
    - CO + H₂O → CO₂ + H₂ (at 400°C, Fe₂O₃/Cr₂O₃ catalyst)

    **Step 3**: Remove CO₂
    - CO₂ absorbed in K₂CO₃ solution

    **Net**: C + 2H₂O → CO₂ + 2H₂

    #### 3. Lane's Process
    **Reaction**: Alternate steam and hot iron
    - **Step 1**: 3Fe + 4H₂O → Fe₃O₄ + 4H₂ (steam passed over hot iron at 700°C)
    - **Step 2**: Fe₃O₄ + 4CO → 3Fe + 4CO₂ (regenerate iron using water gas)

    #### 4. Steam Reforming of Hydrocarbons
    **Most common industrial method**

    **Reaction**: Methane + steam
    - CH₄ + H₂O → CO + 3H₂ (at 850°C, Ni catalyst)
    - CO + H₂O → CO₂ + H₂ (shift reaction)

    **Net**: CH₄ + 2H₂O → CO₂ + 4H₂

    **Advantage**: Cheapest large-scale method

    ---

    ## Properties of Hydrogen

    ### Physical Properties
    - Colorless, odorless, tasteless gas
    - Lightest element (density = 0.089 g/L at STP)
    - Diatomic molecule (H₂)
    - Very low boiling point (-253°C)
    - Sparingly soluble in water
    - Highly flammable

    ### Chemical Properties

    #### 1. Combustion
    - 2H₂ + O₂ → 2H₂O (highly exothermic)
    - Burns with pale blue flame
    - Explosive mixture with air (4-74% H₂)

    #### 2. Reducing Agent
    - Reduces metal oxides to metals:
      - CuO + H₂ → Cu + H₂O
      - Fe₃O₄ + 4H₂ → 3Fe + 4H₂O

    #### 3. Reaction with Non-metals
    - With nitrogen: N₂ + 3H₂ → 2NH₃ (Haber process, high P, T, catalyst)
    - With sulfur: S + H₂ → H₂S
    - With halogens: H₂ + Cl₂ → 2HCl (explosive in sunlight)

    #### 4. Reaction with Metals
    - Forms hydrides:
      - 2Na + H₂ → 2NaH (sodium hydride)
      - Ca + H₂ → CaH₂ (calcium hydride)

    ---

    ## Atomic vs Nascent Hydrogen

    ### Nascent Hydrogen [H]
    - **Definition**: Hydrogen at the moment of generation (atomic form)
    - **Symbol**: [H] or H
    - More reactive than H₂ molecular hydrogen
    - Produced during chemical reactions:
      - Zn + H₂SO₄ → ZnSO₄ + 2[H] → ZnSO₄ + H₂

    **Why more reactive?**
    - No need to break H-H bond (bond dissociation energy = 436 kJ/mol)
    - Higher energy state

    **Applications**:
    - Reduction of unsaturated compounds
    - More effective reducing agent

    ---

    ## Uses of Hydrogen

    1. **Haber process**: Ammonia synthesis (NH₃)
    2. **Hydrogenation**: Vegetable oils → solid fats (margarine)
    3. **Rocket fuel**: Liquid H₂ in space rockets
    4. **Fuel cells**: Clean energy source (H₂ + O₂ → H₂O + energy)
    5. **Synthesis**: HCl, methanol production
    6. **Metallurgy**: Reducing agent for metal extraction
    7. **Weather balloons**: Low density (replaced by He for safety)

    ---

    ## Key Points for IIT JEE

    1. **Unique position**: Hydrogen resembles both Group 1 and Group 17
    2. **Three isotopes**: Protium (99.985%), Deuterium (0.015%), Tritium (radioactive)
    3. **Lab preparation**: Zn + dil. H₂SO₄ (not conc. H₂SO₄ or HNO₃)
    4. **Industrial methods**: Electrolysis (purest), Bosch process, steam reforming (cheapest)
    5. **Nascent hydrogen**: Atomic form [H], more reactive than H₂
    6. **D₂O properties**: Higher bp (101.4°C), used as moderator
    7. **Water gas**: CO + H₂ (produced from C + H₂O)

## Key Points

- Periodic table position

- Isotopes

- Protium
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Periodic table position', 'Isotopes', 'Protium', 'Deuterium', 'Tritium', 'Preparation methods'],
  prerequisite_ids: []
)

puts "✓ Created 16 microlessons for Hydrogen Chemistry"

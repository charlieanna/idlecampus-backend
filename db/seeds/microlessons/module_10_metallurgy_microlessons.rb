# AUTO-GENERATED from module_10_metallurgy.rb
puts "Creating Microlessons for Metallurgy Extraction..."

module_var = CourseModule.find_by(slug: 'metallurgy-extraction')

# === MICROLESSON 1: electrolytic_refining — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'electrolytic_refining — Practice',
  content: <<~MARKDOWN,
# electrolytic_refining — Practice 🚀

Noble metals (Au, Ag, Pt) are less reactive and don\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['electrolytic_refining'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In electrolytic refining of copper, the impurities like gold and silver settle at the bottom as ________.',
    answer: 'anode mud|anode slime',
    explanation: 'Noble metals (Au, Ag, Pt) are less reactive and don\',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Ellingham Diagrams and Thermodynamics of Reduction ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ellingham Diagrams and Thermodynamics of Reduction',
  content: <<~MARKDOWN,
# Ellingham Diagrams and Thermodynamics of Reduction 🚀

# Ellingham Diagrams

    ## What is an Ellingham Diagram?

    **Definition**: Graph showing variation of ΔG° (standard Gibbs free energy) with temperature for oxidation reactions.

    ### General Reaction
    2M(s) + O₂(g) → 2MO(s)

    **Y-axis**: ΔG° (kJ/mol of O₂)
    **X-axis**: Temperature (K or °C)

    ## Key Features

    ### 1. Slope
    - Most lines have **positive slope** (ΔG° becomes less negative with temperature)
    - Reason: Negative ΔS° (gas O₂ consumed, solid MO formed)
    - ΔG° = ΔH° - TΔS°

    ### 2. Position of Line
    - **Lower line** = More stable oxide (larger negative ΔG°)
    - **Higher line** = Less stable oxide (less negative ΔG°)

    ### 3. Metal can reduce oxide if its line is below
    - Metal M can reduce oxide N-O if M-O line is below N-O line at that temperature
    - Example: At high temperature, C-CO line is below Fe-FeO line → C can reduce FeO

    ### 4. Breaks in Lines
    - **Abrupt changes** at:
      - Melting point (s → l)
      - Boiling point (l → g)
      - Phase transition
    - Reason: Change in ΔS°

    ## Thermodynamic Principles

    ### Feasibility of Reduction
    For reduction to be feasible: **ΔG° < 0**

    **Coupled reaction principle**:
    - Reaction 1: M-O formation (more negative ΔG°)
    - Reaction 2: N-O decomposition (positive ΔG°)
    - Net: ΔG°_net = ΔG°₁ + ΔG°₂ < 0

    **Example**: Reduction of ZnO by carbon
    - ZnO(s) → Zn(s) + ½O₂(g)        ΔG°₁ = +480 kJ (at 1000K)
    - C(s) + ½O₂(g) → CO(g)          ΔG°₂ = -380 kJ (at 1000K)
    - **Net**: ZnO(s) + C(s) → Zn(s) + CO(g)   ΔG° = +100 kJ (not feasible at 1000K)

    At higher temperature (~1200K):
    - ΔG°_net becomes negative → reaction feasible

    ## Carbon as Reducing Agent

    ### Two oxidation products:
    1. **C → CO**: Ellingham line slopes downward (negative slope)
       - Reason: 2C(s) + O₂(g) → 2CO(g) has ΔS° > 0 (solid → gas)
    2. **C → CO₂**: Similar behavior but less negative slope

    ### Why carbon is effective at high temperatures:
    - At high T, C-CO line crosses below many metal oxide lines
    - Example: Fe₃O₄, ZnO, CuO can be reduced by C/CO at high temperatures

    ## Special Cases

    ### 1. Aluminum (Al)
    - Al-Al₂O₃ line is very low (highly stable oxide)
    - Cannot be reduced by carbon
    - Requires **electrolytic reduction** (Hall-Héroult process)

    ### 2. Reactive Metals (Na, K, Ca, Mg)
    - Very low Ellingham lines (very stable oxides)
    - Must use electrolysis of molten salts
    - Down's process (Na), Electrolysis of MgCl₂

    ### 3. Less Reactive Metals (Hg, Ag)
    - High Ellingham lines (unstable oxides)
    - Can decompose on heating alone
    - HgO → Hg + ½O₂ (simple heating)

    ## Reduction Methods Based on Thermodynamics

    ### 1. Self-Reduction (Autoreduction)
    - No external reducing agent needed
    - Ore reduces itself
    - **Example**: Copper extraction
      - 2Cu₂S + 3O₂ → 2Cu₂O + 2SO₂ (partial roasting)
      - 2Cu₂O + Cu₂S → 6Cu + SO₂ (self-reduction)

    ### 2. Carbon Reduction
    - Used for moderately reactive metals
    - Feasible at high temperatures
    - **Examples**: Fe, Zn, Sn, Pb

    ### 3. Displacement (More reactive metal)
    - **Thermite reaction**:
      - Fe₂O₃ + 2Al → 2Fe + Al₂O₃ (highly exothermic)
      - Used for welding railway tracks
    - **Goldschmidt process**: Cr₂O₃ + 2Al → 2Cr + Al₂O₃

    ### 4. Electrolytic Reduction
    - For highly reactive metals
    - **Examples**:
      - Al: Hall-Héroult process (electrolysis of Al₂O₃ in molten cryolite)
      - Na: Down's process (electrolysis of molten NaCl)

    ## Interpreting Ellingham Diagrams

    ### Problem Type 1: Can metal A reduce oxide B-O?
    **Solution**: Check if A-O line is below B-O line at the given temperature

    ### Problem Type 2: At what temperature does reduction become feasible?
    **Solution**: Find intersection point of two lines (ΔG°_net = 0)

    ### Problem Type 3: Compare oxidation stability
    **Solution**: Lower line = more stable oxide

    ## Key Points for IIT JEE

    1. **Lower line** in Ellingham diagram = more stable oxide
    2. Carbon's effectiveness increases with temperature (negative slope for C-CO)
    3. Al, Mg, Na, K require electrolysis (very stable oxides)
    4. ΔG° < 0 for feasible reduction
    5. Thermite reaction: Al reduces Fe₂O₃ (highly exothermic)
    6. Self-reduction used for Cu (Cu₂S + Cu₂O → Cu)
    7. Line breaks indicate phase transitions

## Key Points

- Ellingham diagram

- Gibbs free energy

- Reduction principles
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ellingham diagram', 'Gibbs free energy', 'Reduction principles', 'Coupling reactions'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Extraction of Specific Metals (Fe, Cu, Al, Zn) ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Extraction of Specific Metals (Fe, Cu, Al, Zn)',
  content: <<~MARKDOWN,
# Extraction of Specific Metals (Fe, Cu, Al, Zn) 🚀

# Extraction of Specific Metals

    ## 1. Extraction of Iron (Fe)

    **Ore**: Hematite (Fe₂O₃), Magnetite (Fe₃O₄)
    **Process**: Blast furnace

    ### Blast Furnace
    - **Structure**: Tall steel tower lined with refractory bricks
    - **Charge**: Ore (Fe₂O₃) + Coke (C) + Limestone (CaCO₃)
    - **Temperature zones**: 500-900°C (top) to 2200°C (bottom)

    ### Reactions:
    **Zone 1 (Lower zone, hottest ~2200°C)**:
    - C + O₂ → CO₂ (combustion of coke)
    - CO₂ + C → 2CO (at high temperature)

    **Zone 2 (Middle zone, ~1000°C)**:
    - Fe₂O₃ + 3CO → 2Fe + 3CO₂ (reduction)
    - Fe₂O₃ + 3C → 2Fe + 3CO

    **Flux reaction** (removal of gangue):
    - CaCO₃ → CaO + CO₂ (calcination)
    - CaO + SiO₂ → CaSiO₃ (slag, molten)

    ### Products:
    - **Pig iron** (impure): 4% C, traces of Si, S, P, Mn
    - **Slag** (CaSiO₃): Floats on molten iron, removed

    ### Refining of Iron:
    - **Cast iron**: 2-4% C (brittle, used for casting)
    - **Wrought iron**: <0.2% C (tough, malleable)
    - **Steel**: 0.2-2% C (strong, elastic)

    ---

    ## 2. Extraction of Copper (Cu)

    **Ore**: Copper pyrites (CuFeS₂), Chalcocite (Cu₂S)

    ### Process: Self-reduction
    **Step 1: Concentration** - Froth flotation

    **Step 2: Roasting** (partial, controlled O₂):
    - 2CuFeS₂ + O₂ → Cu₂S + 2FeS + SO₂

    **Step 3: Smelting** (in reverberatory furnace):
    - FeS + SiO₂ → FeSiO₃ (slag, removed)
    - Cu₂S + FeS mixture = **matte**

    **Step 4: Bessemerization** (convert matte to copper):
    - 2FeS + 3O₂ → 2FeO + 2SO₂
    - FeO + SiO₂ → FeSiO₃ (slag)
    - **Self-reduction**:
      - 2Cu₂S + 3O₂ → 2Cu₂O + 2SO₂
      - 2Cu₂O + Cu₂S → 6Cu + SO₂ (**blister copper**, 98% pure)

    **Step 5: Refining** - Electrolytic refining
    - Anode: Impure copper
    - Cathode: Pure copper strip
    - Electrolyte: CuSO₄ + H₂SO₄
    - **At anode**: Cu → Cu²⁺ + 2e⁻
    - **At cathode**: Cu²⁺ + 2e⁻ → Cu (pure, 99.95%)
    - Impurities (Ag, Au, Pt) settle as **anode mud** (valuable!)

    ---

    ## 3. Extraction of Aluminum (Al)

    **Ore**: Bauxite (Al₂O₃·2H₂O)
    **Problem**: Cannot use carbon reduction (Al₂O₃ very stable)
    **Solution**: Electrolytic reduction

    ### Hall-Héroult Process
    **Step 1: Purification** - Bayer's process
    - Bauxite + NaOH (conc.) → NaAlO₂ + impurities
    - Al₂O₃·2H₂O + 2NaOH → 2NaAlO₂ + 3H₂O
    - Gangue (Fe₂O₃, SiO₂) filtered out
    - NaAlO₂ + 2H₂O → Al(OH)₃ + NaOH (precipitate by dilution)
    - 2Al(OH)₃ → Al₂O₃ + 3H₂O (calcination at 1200°C)

    **Step 2: Electrolytic reduction**
    - **Electrolyte**: Al₂O₃ dissolved in molten cryolite (Na₃AlF₆) at 900-950°C
    - **Cathode**: Carbon-lined steel vessel
    - **Anode**: Graphite rods (consumable)

    **Reactions**:
    - **At cathode**: Al³⁺ + 3e⁻ → Al (molten, collected at bottom)
    - **At anode**: 2O²⁻ → O₂ + 4e⁻
      - O₂ + C → CO₂ (anode burns away)

    **Overall**: 2Al₂O₃ + 3C → 4Al + 3CO₂

    **Why cryolite?**
    1. Lowers melting point of Al₂O₃ (from 2050°C to 950°C)
    2. Increases conductivity
    3. Reduces energy consumption

    ---

    ## 4. Extraction of Zinc (Zn)

    **Ore**: Zinc blende (ZnS), Calamine (ZnCO₃)

    ### Process:
    **Step 1: Concentration** - Froth flotation (for ZnS)

    **Step 2: Roasting** (for ZnS):
    - 2ZnS + 3O₂ → 2ZnO + 2SO₂

    **Step 2 (alternate)**: Calcination (for ZnCO₃):
    - ZnCO₃ → ZnO + CO₂

    **Step 3: Reduction** (using coke):
    - ZnO + C → Zn + CO (at ~1100°C)
    - Zinc vaporizes (bp 907°C), collected by condensation

    **Step 4: Refining**:
    - **Fractional distillation** (Zn bp 907°C, impurities higher bp)
    - **Electrolytic refining** (for very pure Zn)

    ---

    ## Comparison Table

    | Metal | Ore | Main Process | Reducing Agent | Refining |
    |-------|-----|--------------|----------------|----------|
    | Fe | Hematite (Fe₂O₃) | Blast furnace | C/CO | - |
    | Cu | Copper pyrites | Self-reduction | Cu₂S (self) | Electrolytic |
    | Al | Bauxite | Hall-Héroult | Electrolysis | - |
    | Zn | Zinc blende | Carbon reduction | C/CO | Distillation |

    ## Refining Methods

    ### 1. Electrolytic Refining
    - Impure metal anode, pure metal cathode
    - Metal ions migrate to cathode, deposit as pure metal
    - Used for: Cu, Zn, Ag, Au, Al

    ### 2. Distillation
    - Based on difference in boiling points
    - Volatile metal vaporizes, condenses, collected
    - Used for: Zn, Hg, Cd

    ### 3. Zone Refining
    - Used for semiconductors (very high purity needed)
    - Molten zone moves along rod, impurities concentrate at one end
    - Used for: Ge, Si, Ga

    ### 4. Van Arkel Method (Vapor phase refining)
    - Metal heated with I₂ → volatile iodide
    - Iodide decomposed on hot tungsten filament → pure metal
    - Used for: Ti, Zr, Hf

    ### 5. Mond Process
    - Ni + 4CO → Ni(CO)₄ (volatile, at 50-60°C)
    - Ni(CO)₄ → Ni + 4CO (decompose at 180°C)
    - Used exclusively for: Nickel

    ## Key Points for IIT JEE

    1. **Blast furnace**: Fe extracted using C/CO reduction, CaCO₃ flux removes SiO₂
    2. **Hall-Héroult**: Al extracted by electrolysis in molten cryolite
    3. **Self-reduction**: Cu₂S + Cu₂O → Cu (no external reducing agent)
    4. **Cryolite role**: Lowers melting point, increases conductivity
    5. **Electrolytic refining**: Pure metal at cathode, anode mud contains noble metals
    6. **Zinc extraction**: Reduction by carbon, zinc vapor collected
    7. **Mond process**: Ni purified using Ni(CO)₄ volatile compound

## Key Points

- Blast furnace

- Hall-Heroult process

- Copper extraction
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Blast furnace', 'Hall-Heroult process', 'Copper extraction', 'Zinc extraction'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Introduction to Metallurgy ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Metallurgy',
  content: <<~MARKDOWN,
# Introduction to Metallurgy 🚀

# Metallurgy - Introduction

    ## What is Metallurgy?

    **Definition**: Science and technology of extracting metals from their ores and preparing them for use.

    ### Key Terms

    #### 1. Mineral
    - Naturally occurring chemical substance containing metals
    - Example: Bauxite (Al₂O₃·2H₂O), Hematite (Fe₂O₃)

    #### 2. Ore
    - Mineral from which metal can be extracted **profitably**
    - Not all minerals are ores (economic viability matters)
    - Example: Bauxite is the chief ore of aluminum

    #### 3. Gangue (Matrix)
    - Unwanted impurities (sand, rocks, clay) associated with ore
    - Must be removed during concentration
    - Example: SiO₂, Al₂O₃ in iron ores

    ## Steps in Metallurgy

    ### 1. Crushing and Grinding
    - Reduces ore to fine powder
    - Increases surface area for chemical reactions
    - Done in jaw crushers and ball mills

    ### 2. Concentration (Ore Dressing)
    **Purpose**: Remove gangue and enrich the ore

    #### Methods:

    **A. Hydraulic Washing (Gravity Separation)**
    - Based on density difference between ore and gangue
    - Lighter gangue washed away by water stream
    - Used for: Oxide ores (hematite, tinstone)

    **B. Froth Flotation Process**
    - Based on preferential wetting
    - Ore particles wetted by oil (hydrophobic)
    - Gangue wetted by water (hydrophilic)
    - **Process**:
      1. Crushed ore + water + pine oil + collectors (xanthates)
      2. Air blown through → froth forms
      3. Ore particles attach to froth bubbles → float
      4. Gangue sinks to bottom
    - Used for: Sulfide ores (ZnS, PbS, Cu₂S)

    **C. Magnetic Separation**
    - Based on magnetic properties
    - Ore is magnetic, gangue is non-magnetic (or vice versa)
    - Used for: Chromite (FeCr₂O₄), pyrolusite (MnO₂)

    **D. Leaching (Chemical Separation)**
    - Ore dissolved in suitable reagent
    - Gangue remains undissolved (filtered out)
    - **Examples**:
      - **Bauxite leaching** (Bayer's process):
        - Al₂O₃·2H₂O + 2NaOH → 2NaAlO₂ + 3H₂O
        - Gangue (Fe₂O₃, SiO₂) doesn't dissolve
      - **Gold/Silver leaching**:
        - 4Au + 8NaCN + O₂ + 2H₂O → 4Na[Au(CN)₂] + 4NaOH

    ### 3. Calcination vs Roasting

    #### Calcination
    - **Definition**: Heating ore in **limited or no air**
    - **Purpose**: Remove volatile impurities (H₂O, CO₂)
    - **Examples**:
      - ZnCO₃ → ZnO + CO₂↑
      - Al₂O₃·2H₂O → Al₂O₃ + 2H₂O↑
      - CaCO₃ → CaO + CO₂↑

    #### Roasting
    - **Definition**: Heating ore in **excess air**
    - **Purpose**: Convert sulfides to oxides
    - **Examples**:
      - 2ZnS + 3O₂ → 2ZnO + 2SO₂↑
      - 2Cu₂S + 3O₂ → 2Cu₂O + 2SO₂↑
      - 2PbS + 3O₂ → 2PbO + 2SO₂↑

    ### 4. Reduction (Extraction)
    - Convert metal oxide/compound to free metal
    - Methods: Carbon reduction, self-reduction, electrolysis, thermite

    ### 5. Refining
    - Purify crude metal
    - Methods: Electrolytic, distillation, zone refining, van Arkel

    ## Occurrence of Metals

    ### Native State (Free)
    - Noble metals (low reactivity)
    - Examples: Au, Pt, Ag (small amounts)

    ### Combined State (Compounds)
    - Most metals occur as compounds

    **Common ore types:**
    - **Oxides**: Fe₂O₃ (hematite), Al₂O₃ (bauxite)
    - **Sulfides**: ZnS (zinc blende), PbS (galena), Cu₂S (chalcocite)
    - **Carbonates**: CaCO₃ (limestone), MgCO₃·CaCO₃ (dolomite)
    - **Halides**: NaCl (rock salt), KCl (sylvite)

    ## Activity Series and Extraction

    Metals are extracted using methods based on their reactivity:

    | Reactivity | Metals | Extraction Method |
    |------------|--------|-------------------|
    | **High** | K, Na, Ca, Mg, Al | Electrolytic reduction |
    | **Medium** | Zn, Fe, Pb, Cu | Carbon/Carbon monoxide reduction |
    | **Low** | Hg, Ag | Roasting alone or self-reduction |
    | **Very Low** | Au, Pt | No extraction needed (native) |

    ## IIT JEE Important Points

    1. **Froth flotation** is used for sulfide ores (not oxide ores)
    2. **Calcination** = limited air; **Roasting** = excess air
    3. **Ellingham diagrams** predict feasibility of reduction
    4. **Self-reduction**: No external reducing agent needed
    5. **Leaching**: Chemical method to concentrate ore
    6. Activity series determines extraction method

## Key Points

- Minerals

- Ores

- Gangue
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Minerals', 'Ores', 'Gangue', 'Concentration methods', 'Metallurgical processes'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Ellingham Diagrams and Thermodynamics of Reduction ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ellingham Diagrams and Thermodynamics of Reduction',
  content: <<~MARKDOWN,
# Ellingham Diagrams and Thermodynamics of Reduction 🚀

# Ellingham Diagrams

    ## What is an Ellingham Diagram?

    **Definition**: Graph showing variation of ΔG° (standard Gibbs free energy) with temperature for oxidation reactions.

    ### General Reaction
    2M(s) + O₂(g) → 2MO(s)

    **Y-axis**: ΔG° (kJ/mol of O₂)
    **X-axis**: Temperature (K or °C)

    ## Key Features

    ### 1. Slope
    - Most lines have **positive slope** (ΔG° becomes less negative with temperature)
    - Reason: Negative ΔS° (gas O₂ consumed, solid MO formed)
    - ΔG° = ΔH° - TΔS°

    ### 2. Position of Line
    - **Lower line** = More stable oxide (larger negative ΔG°)
    - **Higher line** = Less stable oxide (less negative ΔG°)

    ### 3. Metal can reduce oxide if its line is below
    - Metal M can reduce oxide N-O if M-O line is below N-O line at that temperature
    - Example: At high temperature, C-CO line is below Fe-FeO line → C can reduce FeO

    ### 4. Breaks in Lines
    - **Abrupt changes** at:
      - Melting point (s → l)
      - Boiling point (l → g)
      - Phase transition
    - Reason: Change in ΔS°

    ## Thermodynamic Principles

    ### Feasibility of Reduction
    For reduction to be feasible: **ΔG° < 0**

    **Coupled reaction principle**:
    - Reaction 1: M-O formation (more negative ΔG°)
    - Reaction 2: N-O decomposition (positive ΔG°)
    - Net: ΔG°_net = ΔG°₁ + ΔG°₂ < 0

    **Example**: Reduction of ZnO by carbon
    - ZnO(s) → Zn(s) + ½O₂(g)        ΔG°₁ = +480 kJ (at 1000K)
    - C(s) + ½O₂(g) → CO(g)          ΔG°₂ = -380 kJ (at 1000K)
    - **Net**: ZnO(s) + C(s) → Zn(s) + CO(g)   ΔG° = +100 kJ (not feasible at 1000K)

    At higher temperature (~1200K):
    - ΔG°_net becomes negative → reaction feasible

    ## Carbon as Reducing Agent

    ### Two oxidation products:
    1. **C → CO**: Ellingham line slopes downward (negative slope)
       - Reason: 2C(s) + O₂(g) → 2CO(g) has ΔS° > 0 (solid → gas)
    2. **C → CO₂**: Similar behavior but less negative slope

    ### Why carbon is effective at high temperatures:
    - At high T, C-CO line crosses below many metal oxide lines
    - Example: Fe₃O₄, ZnO, CuO can be reduced by C/CO at high temperatures

    ## Special Cases

    ### 1. Aluminum (Al)
    - Al-Al₂O₃ line is very low (highly stable oxide)
    - Cannot be reduced by carbon
    - Requires **electrolytic reduction** (Hall-Héroult process)

    ### 2. Reactive Metals (Na, K, Ca, Mg)
    - Very low Ellingham lines (very stable oxides)
    - Must use electrolysis of molten salts
    - Down's process (Na), Electrolysis of MgCl₂

    ### 3. Less Reactive Metals (Hg, Ag)
    - High Ellingham lines (unstable oxides)
    - Can decompose on heating alone
    - HgO → Hg + ½O₂ (simple heating)

    ## Reduction Methods Based on Thermodynamics

    ### 1. Self-Reduction (Autoreduction)
    - No external reducing agent needed
    - Ore reduces itself
    - **Example**: Copper extraction
      - 2Cu₂S + 3O₂ → 2Cu₂O + 2SO₂ (partial roasting)
      - 2Cu₂O + Cu₂S → 6Cu + SO₂ (self-reduction)

    ### 2. Carbon Reduction
    - Used for moderately reactive metals
    - Feasible at high temperatures
    - **Examples**: Fe, Zn, Sn, Pb

    ### 3. Displacement (More reactive metal)
    - **Thermite reaction**:
      - Fe₂O₃ + 2Al → 2Fe + Al₂O₃ (highly exothermic)
      - Used for welding railway tracks
    - **Goldschmidt process**: Cr₂O₃ + 2Al → 2Cr + Al₂O₃

    ### 4. Electrolytic Reduction
    - For highly reactive metals
    - **Examples**:
      - Al: Hall-Héroult process (electrolysis of Al₂O₃ in molten cryolite)
      - Na: Down's process (electrolysis of molten NaCl)

    ## Interpreting Ellingham Diagrams

    ### Problem Type 1: Can metal A reduce oxide B-O?
    **Solution**: Check if A-O line is below B-O line at the given temperature

    ### Problem Type 2: At what temperature does reduction become feasible?
    **Solution**: Find intersection point of two lines (ΔG°_net = 0)

    ### Problem Type 3: Compare oxidation stability
    **Solution**: Lower line = more stable oxide

    ## Key Points for IIT JEE

    1. **Lower line** in Ellingham diagram = more stable oxide
    2. Carbon's effectiveness increases with temperature (negative slope for C-CO)
    3. Al, Mg, Na, K require electrolysis (very stable oxides)
    4. ΔG° < 0 for feasible reduction
    5. Thermite reaction: Al reduces Fe₂O₃ (highly exothermic)
    6. Self-reduction used for Cu (Cu₂S + Cu₂O → Cu)
    7. Line breaks indicate phase transitions

## Key Points

- Ellingham diagram

- Gibbs free energy

- Reduction principles
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ellingham diagram', 'Gibbs free energy', 'Reduction principles', 'Coupling reactions'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Extraction of Specific Metals (Fe, Cu, Al, Zn) ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Extraction of Specific Metals (Fe, Cu, Al, Zn)',
  content: <<~MARKDOWN,
# Extraction of Specific Metals (Fe, Cu, Al, Zn) 🚀

# Extraction of Specific Metals

    ## 1. Extraction of Iron (Fe)

    **Ore**: Hematite (Fe₂O₃), Magnetite (Fe₃O₄)
    **Process**: Blast furnace

    ### Blast Furnace
    - **Structure**: Tall steel tower lined with refractory bricks
    - **Charge**: Ore (Fe₂O₃) + Coke (C) + Limestone (CaCO₃)
    - **Temperature zones**: 500-900°C (top) to 2200°C (bottom)

    ### Reactions:
    **Zone 1 (Lower zone, hottest ~2200°C)**:
    - C + O₂ → CO₂ (combustion of coke)
    - CO₂ + C → 2CO (at high temperature)

    **Zone 2 (Middle zone, ~1000°C)**:
    - Fe₂O₃ + 3CO → 2Fe + 3CO₂ (reduction)
    - Fe₂O₃ + 3C → 2Fe + 3CO

    **Flux reaction** (removal of gangue):
    - CaCO₃ → CaO + CO₂ (calcination)
    - CaO + SiO₂ → CaSiO₃ (slag, molten)

    ### Products:
    - **Pig iron** (impure): 4% C, traces of Si, S, P, Mn
    - **Slag** (CaSiO₃): Floats on molten iron, removed

    ### Refining of Iron:
    - **Cast iron**: 2-4% C (brittle, used for casting)
    - **Wrought iron**: <0.2% C (tough, malleable)
    - **Steel**: 0.2-2% C (strong, elastic)

    ---

    ## 2. Extraction of Copper (Cu)

    **Ore**: Copper pyrites (CuFeS₂), Chalcocite (Cu₂S)

    ### Process: Self-reduction
    **Step 1: Concentration** - Froth flotation

    **Step 2: Roasting** (partial, controlled O₂):
    - 2CuFeS₂ + O₂ → Cu₂S + 2FeS + SO₂

    **Step 3: Smelting** (in reverberatory furnace):
    - FeS + SiO₂ → FeSiO₃ (slag, removed)
    - Cu₂S + FeS mixture = **matte**

    **Step 4: Bessemerization** (convert matte to copper):
    - 2FeS + 3O₂ → 2FeO + 2SO₂
    - FeO + SiO₂ → FeSiO₃ (slag)
    - **Self-reduction**:
      - 2Cu₂S + 3O₂ → 2Cu₂O + 2SO₂
      - 2Cu₂O + Cu₂S → 6Cu + SO₂ (**blister copper**, 98% pure)

    **Step 5: Refining** - Electrolytic refining
    - Anode: Impure copper
    - Cathode: Pure copper strip
    - Electrolyte: CuSO₄ + H₂SO₄
    - **At anode**: Cu → Cu²⁺ + 2e⁻
    - **At cathode**: Cu²⁺ + 2e⁻ → Cu (pure, 99.95%)
    - Impurities (Ag, Au, Pt) settle as **anode mud** (valuable!)

    ---

    ## 3. Extraction of Aluminum (Al)

    **Ore**: Bauxite (Al₂O₃·2H₂O)
    **Problem**: Cannot use carbon reduction (Al₂O₃ very stable)
    **Solution**: Electrolytic reduction

    ### Hall-Héroult Process
    **Step 1: Purification** - Bayer's process
    - Bauxite + NaOH (conc.) → NaAlO₂ + impurities
    - Al₂O₃·2H₂O + 2NaOH → 2NaAlO₂ + 3H₂O
    - Gangue (Fe₂O₃, SiO₂) filtered out
    - NaAlO₂ + 2H₂O → Al(OH)₃ + NaOH (precipitate by dilution)
    - 2Al(OH)₃ → Al₂O₃ + 3H₂O (calcination at 1200°C)

    **Step 2: Electrolytic reduction**
    - **Electrolyte**: Al₂O₃ dissolved in molten cryolite (Na₃AlF₆) at 900-950°C
    - **Cathode**: Carbon-lined steel vessel
    - **Anode**: Graphite rods (consumable)

    **Reactions**:
    - **At cathode**: Al³⁺ + 3e⁻ → Al (molten, collected at bottom)
    - **At anode**: 2O²⁻ → O₂ + 4e⁻
      - O₂ + C → CO₂ (anode burns away)

    **Overall**: 2Al₂O₃ + 3C → 4Al + 3CO₂

    **Why cryolite?**
    1. Lowers melting point of Al₂O₃ (from 2050°C to 950°C)
    2. Increases conductivity
    3. Reduces energy consumption

    ---

    ## 4. Extraction of Zinc (Zn)

    **Ore**: Zinc blende (ZnS), Calamine (ZnCO₃)

    ### Process:
    **Step 1: Concentration** - Froth flotation (for ZnS)

    **Step 2: Roasting** (for ZnS):
    - 2ZnS + 3O₂ → 2ZnO + 2SO₂

    **Step 2 (alternate)**: Calcination (for ZnCO₃):
    - ZnCO₃ → ZnO + CO₂

    **Step 3: Reduction** (using coke):
    - ZnO + C → Zn + CO (at ~1100°C)
    - Zinc vaporizes (bp 907°C), collected by condensation

    **Step 4: Refining**:
    - **Fractional distillation** (Zn bp 907°C, impurities higher bp)
    - **Electrolytic refining** (for very pure Zn)

    ---

    ## Comparison Table

    | Metal | Ore | Main Process | Reducing Agent | Refining |
    |-------|-----|--------------|----------------|----------|
    | Fe | Hematite (Fe₂O₃) | Blast furnace | C/CO | - |
    | Cu | Copper pyrites | Self-reduction | Cu₂S (self) | Electrolytic |
    | Al | Bauxite | Hall-Héroult | Electrolysis | - |
    | Zn | Zinc blende | Carbon reduction | C/CO | Distillation |

    ## Refining Methods

    ### 1. Electrolytic Refining
    - Impure metal anode, pure metal cathode
    - Metal ions migrate to cathode, deposit as pure metal
    - Used for: Cu, Zn, Ag, Au, Al

    ### 2. Distillation
    - Based on difference in boiling points
    - Volatile metal vaporizes, condenses, collected
    - Used for: Zn, Hg, Cd

    ### 3. Zone Refining
    - Used for semiconductors (very high purity needed)
    - Molten zone moves along rod, impurities concentrate at one end
    - Used for: Ge, Si, Ga

    ### 4. Van Arkel Method (Vapor phase refining)
    - Metal heated with I₂ → volatile iodide
    - Iodide decomposed on hot tungsten filament → pure metal
    - Used for: Ti, Zr, Hf

    ### 5. Mond Process
    - Ni + 4CO → Ni(CO)₄ (volatile, at 50-60°C)
    - Ni(CO)₄ → Ni + 4CO (decompose at 180°C)
    - Used exclusively for: Nickel

    ## Key Points for IIT JEE

    1. **Blast furnace**: Fe extracted using C/CO reduction, CaCO₃ flux removes SiO₂
    2. **Hall-Héroult**: Al extracted by electrolysis in molten cryolite
    3. **Self-reduction**: Cu₂S + Cu₂O → Cu (no external reducing agent)
    4. **Cryolite role**: Lowers melting point, increases conductivity
    5. **Electrolytic refining**: Pure metal at cathode, anode mud contains noble metals
    6. **Zinc extraction**: Reduction by carbon, zinc vapor collected
    7. **Mond process**: Ni purified using Ni(CO)₄ volatile compound

## Key Points

- Blast furnace

- Hall-Heroult process

- Copper extraction
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Blast furnace', 'Hall-Heroult process', 'Copper extraction', 'Zinc extraction'],
  prerequisite_ids: []
)

# === MICROLESSON 7: concentration_methods — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'concentration_methods — Practice',
  content: <<~MARKDOWN,
# concentration_methods — Practice 🚀

Froth flotation is used for sulfide ores (ZnS, PbS, Cu₂S). Sulfide ore particles are preferentially wetted by oil and float with froth, while gangue sinks.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['concentration_methods'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which concentration method is used for sulfide ores?',
    options: ['Hydraulic washing', 'Froth flotation', 'Magnetic separation', 'Calcination'],
    correct_answer: 1,
    explanation: 'Froth flotation is used for sulfide ores (ZnS, PbS, Cu₂S). Sulfide ore particles are preferentially wetted by oil and float with froth, while gangue sinks.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: extraction_processes — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'extraction_processes — Practice',
  content: <<~MARKDOWN,
# extraction_processes — Practice 🚀

Calcination is heating in limited or no air (removes H₂O, CO₂). Roasting is heating in excess air (converts sulfides to oxides). Example: ZnCO₃ → ZnO (calcination), 2ZnS + 3O₂ → 2ZnO (roasting).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['extraction_processes'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the main difference between calcination and roasting?',
    options: ['Calcination uses excess air, roasting uses limited air', 'Calcination uses limited/no air, roasting uses excess air', 'Both are the same process', 'Calcination is for sulfides, roasting is for carbonates'],
    correct_answer: 1,
    explanation: 'Calcination is heating in limited or no air (removes H₂O, CO₂). Roasting is heating in excess air (converts sulfides to oxides). Example: ZnCO₃ → ZnO (calcination), 2ZnS + 3O₂ → 2ZnO (roasting).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: extraction_methods — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'extraction_methods — Practice',
  content: <<~MARKDOWN,
# extraction_methods — Practice 🚀

Highly reactive metals (Al, Na, K, Ca, Mg) have very stable oxides and require electrolytic reduction. Fe is extracted by carbon reduction, Cu by self-reduction.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['extraction_methods'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which metals are extracted by electrolytic reduction?',
    options: ['Aluminum (Al)', 'Sodium (Na)', 'Iron (Fe)', 'Copper (Cu)'],
    correct_answer: 1,
    explanation: 'Highly reactive metals (Al, Na, K, Ca, Mg) have very stable oxides and require electrolytic reduction. Fe is extracted by carbon reduction, Cu by self-reduction.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 10: ellingham_diagrams — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'ellingham_diagrams — Practice',
  content: <<~MARKDOWN,
# ellingham_diagrams — Practice 🚀

Lower line means more negative ΔG°, which indicates greater thermodynamic stability. The metal oxide is more stable and harder to reduce.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['ellingham_diagrams'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In the Ellingham diagram, a lower line indicates a ________ stable oxide.',
    answer: 'more',
    explanation: 'Lower line means more negative ΔG°, which indicates greater thermodynamic stability. The metal oxide is more stable and harder to reduce.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: aluminum_extraction — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'aluminum_extraction — Practice',
  content: <<~MARKDOWN,
# aluminum_extraction — Practice 🚀

Cryolite lowers the melting point of Al₂O₃ from 2050°C to ~950°C and increases electrical conductivity of the electrolyte, making the electrolytic process more economical.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['aluminum_extraction'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the role of cryolite (Na₃AlF₆) in the Hall-Héroult process?',
    options: ['Acts as a reducing agent', 'Lowers melting point and increases conductivity', 'Oxidizes aluminum', 'Removes impurities'],
    correct_answer: 1,
    explanation: 'Cryolite lowers the melting point of Al₂O₃ from 2050°C to ~950°C and increases electrical conductivity of the electrolyte, making the electrolytic process more economical.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 12: iron_extraction — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'iron_extraction — Practice',
  content: <<~MARKDOWN,
# iron_extraction — Practice 🚀

TRUE. CaCO₃ → CaO + CO₂, then CaO + SiO₂ → CaSiO₃ (slag). The slag is molten and less dense than iron, so it floats and can be removed.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['iron_extraction'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In the blast furnace, limestone (CaCO₃) acts as a flux to remove silica (SiO₂) impurities.',
    answer: 'true',
    explanation: 'TRUE. CaCO₃ → CaO + CO₂, then CaO + SiO₂ → CaSiO₃ (slag). The slag is molten and less dense than iron, so it floats and can be removed.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: copper_extraction — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'copper_extraction — Practice',
  content: <<~MARKDOWN,
# copper_extraction — Practice 🚀

Copper extraction uses self-reduction: 2Cu₂O + Cu₂S → 6Cu + SO₂. Cu₂S acts as reducing agent for Cu₂O, no external reducing agent needed.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['copper_extraction'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which process involves self-reduction?',
    options: ['Extraction of iron from Fe₂O₃', 'Extraction of copper from Cu₂S', 'Extraction of aluminum from Al₂O₃', 'Extraction of zinc from ZnO'],
    correct_answer: 1,
    explanation: 'Copper extraction uses self-reduction: 2Cu₂O + Cu₂S → 6Cu + SO₂. Cu₂S acts as reducing agent for Cu₂O, no external reducing agent needed.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: chemical_equations — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_equations — Practice',
  content: <<~MARKDOWN,
# chemical_equations — Practice 🚀

Balanced equation: 2ZnS + 3O₂ → 2ZnO + 2SO₂. This is the roasting of zinc sulfide to convert it to zinc oxide before reduction.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['chemical_equations'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Balance the roasting reaction: ZnS + O₂ → ZnO + SO₂',
    answer: '2ZnS + 3O₂ → 2ZnO + 2SO₂',
    explanation: 'Balanced equation: 2ZnS + 3O₂ → 2ZnO + 2SO₂. This is the roasting of zinc sulfide to convert it to zinc oxide before reduction.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: refining_methods — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'refining_methods — Practice',
  content: <<~MARKDOWN,
# refining_methods — Practice 🚀

Mond process: Ni + 4CO → Ni(CO)₄ (50-60°C, volatile) → Ni + 4CO (180°C, decomposition). This gives very pure nickel.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['refining_methods'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which statements about the Mond process are correct?',
    options: ['Used for purification of nickel', 'Forms volatile Ni(CO)₄ at 50-60°C', 'Used for purification of iron', 'Decomposes Ni(CO)₄ at 180°C to get pure Ni'],
    correct_answer: 3,
    explanation: 'Mond process: Ni + 4CO → Ni(CO)₄ (50-60°C, volatile) → Ni + 4CO (180°C, decomposition). This gives very pure nickel.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 16: extraction_sequence — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'extraction_sequence — Practice',
  content: <<~MARKDOWN,
# extraction_sequence — Practice 🚀

Correct sequence: (1) Concentration → (3) Roasting/Calcination → (2) Reduction in blast furnace → (4) Collection of molten iron. This is the systematic metallurgical process.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['extraction_sequence'],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following steps in iron extraction in correct order:',
    answer: '1,3,2,4',
    explanation: 'Correct sequence: (1) Concentration → (3) Roasting/Calcination → (2) Reduction in blast furnace → (4) Collection of molten iron. This is the systematic metallurgical process.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: Introduction to Metallurgy ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Metallurgy',
  content: <<~MARKDOWN,
# Introduction to Metallurgy 🚀

# Metallurgy - Introduction

    ## What is Metallurgy?

    **Definition**: Science and technology of extracting metals from their ores and preparing them for use.

    ### Key Terms

    #### 1. Mineral
    - Naturally occurring chemical substance containing metals
    - Example: Bauxite (Al₂O₃·2H₂O), Hematite (Fe₂O₃)

    #### 2. Ore
    - Mineral from which metal can be extracted **profitably**
    - Not all minerals are ores (economic viability matters)
    - Example: Bauxite is the chief ore of aluminum

    #### 3. Gangue (Matrix)
    - Unwanted impurities (sand, rocks, clay) associated with ore
    - Must be removed during concentration
    - Example: SiO₂, Al₂O₃ in iron ores

    ## Steps in Metallurgy

    ### 1. Crushing and Grinding
    - Reduces ore to fine powder
    - Increases surface area for chemical reactions
    - Done in jaw crushers and ball mills

    ### 2. Concentration (Ore Dressing)
    **Purpose**: Remove gangue and enrich the ore

    #### Methods:

    **A. Hydraulic Washing (Gravity Separation)**
    - Based on density difference between ore and gangue
    - Lighter gangue washed away by water stream
    - Used for: Oxide ores (hematite, tinstone)

    **B. Froth Flotation Process**
    - Based on preferential wetting
    - Ore particles wetted by oil (hydrophobic)
    - Gangue wetted by water (hydrophilic)
    - **Process**:
      1. Crushed ore + water + pine oil + collectors (xanthates)
      2. Air blown through → froth forms
      3. Ore particles attach to froth bubbles → float
      4. Gangue sinks to bottom
    - Used for: Sulfide ores (ZnS, PbS, Cu₂S)

    **C. Magnetic Separation**
    - Based on magnetic properties
    - Ore is magnetic, gangue is non-magnetic (or vice versa)
    - Used for: Chromite (FeCr₂O₄), pyrolusite (MnO₂)

    **D. Leaching (Chemical Separation)**
    - Ore dissolved in suitable reagent
    - Gangue remains undissolved (filtered out)
    - **Examples**:
      - **Bauxite leaching** (Bayer's process):
        - Al₂O₃·2H₂O + 2NaOH → 2NaAlO₂ + 3H₂O
        - Gangue (Fe₂O₃, SiO₂) doesn't dissolve
      - **Gold/Silver leaching**:
        - 4Au + 8NaCN + O₂ + 2H₂O → 4Na[Au(CN)₂] + 4NaOH

    ### 3. Calcination vs Roasting

    #### Calcination
    - **Definition**: Heating ore in **limited or no air**
    - **Purpose**: Remove volatile impurities (H₂O, CO₂)
    - **Examples**:
      - ZnCO₃ → ZnO + CO₂↑
      - Al₂O₃·2H₂O → Al₂O₃ + 2H₂O↑
      - CaCO₃ → CaO + CO₂↑

    #### Roasting
    - **Definition**: Heating ore in **excess air**
    - **Purpose**: Convert sulfides to oxides
    - **Examples**:
      - 2ZnS + 3O₂ → 2ZnO + 2SO₂↑
      - 2Cu₂S + 3O₂ → 2Cu₂O + 2SO₂↑
      - 2PbS + 3O₂ → 2PbO + 2SO₂↑

    ### 4. Reduction (Extraction)
    - Convert metal oxide/compound to free metal
    - Methods: Carbon reduction, self-reduction, electrolysis, thermite

    ### 5. Refining
    - Purify crude metal
    - Methods: Electrolytic, distillation, zone refining, van Arkel

    ## Occurrence of Metals

    ### Native State (Free)
    - Noble metals (low reactivity)
    - Examples: Au, Pt, Ag (small amounts)

    ### Combined State (Compounds)
    - Most metals occur as compounds

    **Common ore types:**
    - **Oxides**: Fe₂O₃ (hematite), Al₂O₃ (bauxite)
    - **Sulfides**: ZnS (zinc blende), PbS (galena), Cu₂S (chalcocite)
    - **Carbonates**: CaCO₃ (limestone), MgCO₃·CaCO₃ (dolomite)
    - **Halides**: NaCl (rock salt), KCl (sylvite)

    ## Activity Series and Extraction

    Metals are extracted using methods based on their reactivity:

    | Reactivity | Metals | Extraction Method |
    |------------|--------|-------------------|
    | **High** | K, Na, Ca, Mg, Al | Electrolytic reduction |
    | **Medium** | Zn, Fe, Pb, Cu | Carbon/Carbon monoxide reduction |
    | **Low** | Hg, Ag | Roasting alone or self-reduction |
    | **Very Low** | Au, Pt | No extraction needed (native) |

    ## IIT JEE Important Points

    1. **Froth flotation** is used for sulfide ores (not oxide ores)
    2. **Calcination** = limited air; **Roasting** = excess air
    3. **Ellingham diagrams** predict feasibility of reduction
    4. **Self-reduction**: No external reducing agent needed
    5. **Leaching**: Chemical method to concentrate ore
    6. Activity series determines extraction method

## Key Points

- Minerals

- Ores

- Gangue
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Minerals', 'Ores', 'Gangue', 'Concentration methods', 'Metallurgical processes'],
  prerequisite_ids: []
)

puts "✓ Created 17 microlessons for Metallurgy Extraction"

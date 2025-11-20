# AUTO-GENERATED from modules_06_to_09_complete.rb
puts "Creating Microlessons for F Block Elements..."

module_var = CourseModule.find_by(slug: 'f-block-elements')

# === MICROLESSON 1: cation_groups — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'cation_groups — Practice',
  content: <<~MARKDOWN,
# cation_groups — Practice 🚀

Group II: Cu²⁺, Pb²⁺, Cd²⁺, Bi³⁺, etc. (precipitate as sulfides in acidic H₂S). Ag⁺ is Group I, Zn²⁺ is Group IV.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['cation_groups'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which cations are in Group II (H₂S in acidic medium)?',
    options: ['Cu²⁺', 'Ag⁺', 'Pb²⁺', 'Zn²⁺'],
    correct_answer: 2,
    explanation: 'Group II: Cu²⁺, Pb²⁺, Cd²⁺, Bi³⁺, etc. (precipitate as sulfides in acidic H₂S). Ag⁺ is Group I, Zn²⁺ is Group IV.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: Lanthanoids and Actinoids - Properties and Contraction ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lanthanoids and Actinoids - Properties and Contraction',
  content: <<~MARKDOWN,
# Lanthanoids and Actinoids - Properties and Contraction 🚀

# f-Block Elements

    ## Introduction

    **f-Block elements:** Elements in which the **4f or 5f orbitals** are being filled.

    ### Lanthanoids (Rare Earths)
    - **Elements:** Ce (58) to Lu (71) - 14 elements
    - **Configuration:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s²
    - **Series:** 4f series

    ### Actinoids
    - **Elements:** Th (90) to Lr (103) - 14 elements
    - **Configuration:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²
    - **Series:** 5f series

    ## Lanthanoid Contraction

    **Definition:** Steady **decrease in atomic and ionic radii** from La to Lu.

    **Cause:** Poor shielding by 4f electrons
    - As 4f electrons are added, they don't shield outer electrons effectively
    - Effective nuclear charge increases
    - Attraction on outer electrons increases → radius decreases

    **Magnitude:** ~10 pm decrease from La³⁺ to Lu³⁺

    ### Consequences of Lanthanoid Contraction

    **1. Similar radii of 4d and 5d series**
    - Zr and Hf have nearly identical radii
    - Makes separation difficult

    **2. Variation in basic strength of hydroxides**
    - La(OH)₃ most basic, Lu(OH)₃ least basic
    - Smaller ion → more covalent → less basic

    **3. Complex formation**
    - Heavier lanthanoids form more stable complexes

    ## Properties of Lanthanoids

    ### Physical Properties
    - Silvery-white soft metals
    - High melting points
    - Good conductors
    - Paramagnetic (unpaired 4f electrons)

    ### Chemical Properties

    **1. Oxidation States**
    - **Common:** +3 (most stable)
    - **Exceptions:** Ce⁴⁺ (4f⁰), Eu²⁺ (4f⁷), Yb²⁺ (4f¹⁴)
    - Stability: Empty > Half-filled > Filled > Others

    **2. Color**
    - Colored due to f-f transitions
    - Example: Pr³⁺ (green), Nd³⁺ (violet)

    **3. Magnetic Properties**
    - All are paramagnetic (except La³⁺ and Lu³⁺)

    ## Properties of Actinoids

    ### Oxidation States
    - Show **variable oxidation states** (+3, +4, +5, +6, +7)
    - More variable than lanthanoids
    - Example: U shows +3, +4, +5, +6

    ### Radioactivity
    - **All actinoids are radioactive**
    - Elements after U (93+) are synthetic

    ### Color
    - Colored due to f-f and f-d transitions

    ## Comparison: Lanthanoids vs Actinoids

    | Property | Lanthanoids | Actinoids |
    |----------|-------------|-----------|
    | **Series** | 4f | 5f |
    | **Oxidation states** | +3 mainly | +3, +4, +5, +6, +7 |
    | **Radioactivity** | Not radioactive (except Pm) | All radioactive |
    | **Synthesis** | Natural | U+ synthetic |
    | **Shielding** | Poor | Very poor |
    | **Complex formation** | Less | More |

    ## Uses

    **Lanthanoids:**
    - **Ce:** Lighter flints, glass polishing
    - **La:** Camera lenses, studio lighting
    - **Nd:** Lasers, powerful magnets
    - **Mixed oxides:** Petroleum cracking catalyst

    **Actinoids:**
    - **U:** Nuclear fuel
    - **Pu:** Nuclear weapons
    - **Am:** Smoke detectors

    ## IIT JEE Key Points

    1. **Lanthanoids:** 4f series (Ce-Lu), mainly +3
    2. **Actinoids:** 5f series (Th-Lr), variable oxidation states
    3. **Lanthanoid contraction:** Decrease in size due to poor 4f shielding
    4. **Consequences:** 4d and 5d series have similar radii
    5. **All actinoids are radioactive**
    6. **Ce⁴⁺:** 4f⁰ (stable), Eu²⁺: 4f⁷ (half-filled)

## Key Points

- Lanthanoids

- Actinoids

- Lanthanoid contraction
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Lanthanoids', 'Actinoids', 'Lanthanoid contraction', '4f and 5f series'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Principles of Metallurgy and Extraction Methods ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Principles of Metallurgy and Extraction Methods',
  content: <<~MARKDOWN,
# Principles of Metallurgy and Extraction Methods 🚀

# Principles of Metallurgy

    ## Introduction

    **Metallurgy:** Science and technology of extracting metals from ores.

    **Ore:** Mineral from which metal can be extracted economically.

    **Gangue/Matrix:** Unwanted impurities in ore (SiO₂, clay, etc.)

    ## Steps in Metallurgy

    ### 1. Concentration (Ore Dressing)

    **Purpose:** Remove gangue from ore

    **Methods:**

    **a) Gravity Separation (Hydraulic Washing)**
    - Based on density difference
    - Example: Tin ore (heavier) separated from gangue

    **b) Magnetic Separation**
    - Magnetic ore separated using electromagnet
    - Example: Fe₃O₄ (magnetic) separated from non-magnetic impurities

    **c) Froth Flotation**
    - Based on preferential wetting
    - Ore particles attach to froth, gangue sinks
    - **Pine oil:** Frothing agent
    - **Example:** Sulfide ores (ZnS, PbS, CuFeS₂)

    **d) Leaching (Chemical Method)**
    - Ore dissolved in suitable reagent
    - **Bauxite:** Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O
    - **Gold/Silver:** 4Au + 8NaCN + O₂ + 2H₂O → 4Na[Au(CN)₂] + 4NaOH

    ### 2. Conversion to Oxide

    **a) Roasting**
    - **Heating ore in presence of excess air**
    - Converts sulfides to oxides
    - **Example:** 2ZnS + 3O₂ → 2ZnO + 2SO₂

    **b) Calcination**
    - **Heating ore in limited or no air**
    - Removes moisture, CO₂
    - **Example:** CaCO₃ → CaO + CO₂

    ### 3. Reduction

    **Methods:**

    **a) Smelting (with Carbon)**
    - For less reactive metals (Fe, Zn, Sn, Pb)
    - **Example:** ZnO + C → Zn + CO
    - **Blast furnace:** Iron extraction

    **b) Self Reduction (Auto-reduction)**
    - For Cu, Hg, Pb
    - **Example:** Cu₂S + 2Cu₂O → 6Cu + SO₂

    **c) Electrolytic Reduction**
    - For highly reactive metals (Na, K, Ca, Mg, Al)
    - **Example:** 2Al₂O₃ → 4Al + 3O₂ (Hall-Heroult process)

    **d) Metal Displacement (Thermite)**
    - More reactive metal reduces oxide
    - **Example:** Cr₂O₃ + 2Al → 2Cr + Al₂O₃

    ### 4. Refining (Purification)

    **a) Liquation**
    - Heating impure metal
    - Low melting metal flows, impurities remain
    - **Example:** Tin

    **b) Distillation**
    - Low boiling metal vaporized and condensed
    - **Example:** Zn, Hg

    **c) Electrolytic Refining**
    - **Anode:** Impure metal
    - **Cathode:** Pure metal deposited
    - **Example:** Cu, Ag, Au, Zn, Al

    **d) Zone Refining**
    - For very high purity (semiconductors)
    - Molten zone moves, impurities concentrate
    - **Example:** Ge, Si

    **e) Vapour Phase Refining**
    - **Mond process (Ni):** Ni + 4CO → Ni(CO)₄ → Ni + 4CO
    - **Van Arkel (Ti, Zr):** Ti + 2I₂ → TiI₄ → Ti + 2I₂

    ## Thermodynamics of Metallurgy

    ### Ellingham Diagram

    **Shows:** ΔG° vs Temperature for metal oxide formation

    **Key Points:**
    1. **Lower line = more stable oxide**
    2. **Metal can reduce oxide below it**
    3. **C line crosses many oxides** → good reducing agent
    4. **Al always above other metals** → very reactive

    **Example:**
    - At 1000 K: C can reduce ZnO (C line below Zn line)
    - At 500 K: C cannot reduce ZnO (C line above Zn line)

    ### Gibbs Energy Change

    ΔG = ΔH - TΔS

    **For reduction to be feasible:** ΔG < 0

    ## Extraction Examples

    ### Iron (Blast Furnace)
    - **Ore:** Hematite (Fe₂O₃), Magnetite (Fe₃O₄)
    - **Flux:** CaCO₃
    - **Reducing agent:** CO (from coke)
    - **Reaction:** Fe₂O₃ + 3CO → 2Fe + 3CO₂
    - **Slag:** CaSiO₃ (floats on molten iron)

    ### Aluminium (Hall-Heroult Process)
    - **Ore:** Bauxite (Al₂O₃·2H₂O)
    - **Purification:** Baeyer's process
    - **Electrolysis:** Cryolite (Na₃AlF₆) + Al₂O₃
    - **Cathode:** Al deposited
    - **Anode:** Carbon, O₂ evolved

    ### Copper
    - **Ore:** Copper pyrite (CuFeS₂)
    - **Roasting:** 2CuFeS₂ + O₂ → Cu₂S + 2FeS + SO₂
    - **Smelting:** Cu₂S + FeS → Cu₂S + FeO (slag removed)
    - **Bessemerisation:** Cu₂S + O₂ → 2Cu + SO₂
    - **Refining:** Electrolytic

    ## IIT JEE Key Points

    1. **Froth flotation:** Sulfide ores, pine oil
    2. **Roasting:** Heating in excess air (S → O)
    3. **Calcination:** Heating in limited air (remove CO₂, H₂O)
    4. **Ellingham diagram:** Lower line = more stable oxide
    5. **Zone refining:** Highest purity (Ge, Si)
    6. **Mond process:** Ni + 4CO → Ni(CO)₄
    7. **Hall-Heroult:** Aluminium extraction
    8. **Blast furnace:** Iron extraction

## Key Points

- Metallurgy

- Concentration

- Roasting
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Metallurgy', 'Concentration', 'Roasting', 'Calcination', 'Reduction', 'Refining'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Cation and Anion Analysis - Group Reagents and Tests ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cation and Anion Analysis - Group Reagents and Tests',
  content: <<~MARKDOWN,
# Cation and Anion Analysis - Group Reagents and Tests 🚀

# Qualitative Inorganic Analysis

    ## Cation Analysis

    ### Group Reagents

    | Group | Reagent | Cations | Precipitate Color |
    |-------|---------|---------|------------------|
    | **I** | Dilute HCl | Pb²⁺, Ag⁺, Hg₂²⁺ | White |
    | **II** | H₂S (acidic) | Hg²⁺, Pb²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn⁴⁺ | Colored sulfides |
    | **III** | NH₄OH + NH₄Cl | Fe³⁺, Al³⁺, Cr³⁺ | Hydroxides |
    | **IV** | H₂S (basic) | Zn²⁺, Mn²⁺, Ni²⁺, Co²⁺ | Colored sulfides |
    | **V** | (NH₄)₂CO₃ | Ba²⁺, Sr²⁺, Ca²⁺ | White carbonates |
    | **VI** | - | Mg²⁺, NH₄⁺, Na⁺, K⁺ | Soluble |

    ### Important Confirmatory Tests

    **Group I:**
    - **Ag⁺:** AgCl (white) → soluble in NH₃ → [Ag(NH₃)₂]⁺
    - **Pb²⁺:** PbCl₂ (white) → soluble in hot water → PbCrO₄ (yellow)
    - **Hg₂²⁺:** Hg₂Cl₂ (white) → black with NH₃

    **Group II:**
    - **Cu²⁺:** CuS (black) → [Cu(NH₃)₄]²⁺ (deep blue)
    - **Pb²⁺:** PbS (black) → PbCrO₄ (yellow)
    - **Cd²⁺:** CdS (yellow)

    **Group III:**
    - **Fe³⁺:** Fe(OH)₃ (brown) → Blood red with KSCN
    - **Al³⁺:** Al(OH)₃ (white, gelatinous)
    - **Cr³⁺:** Cr(OH)₃ (green) → Yellow chromate

    **Group IV:**
    - **Zn²⁺:** ZnS (white) → [Zn(OH)₄]²⁻ (soluble in excess NaOH)
    - **Mn²⁺:** MnS (flesh colored)
    - **Ni²⁺:** NiS (black) → Dimethylglyoxime test (red ppt)
    - **Co²⁺:** CoS (black) → Blue with thiocyanate

    **Group V:**
    - **Ba²⁺:** BaCO₃ → BaCrO₄ (yellow)
    - **Sr²⁺:** Crimson flame
    - **Ca²⁺:** Brick red flame

    ## Anion Analysis

    ### Preliminary Tests

    **1. Dilute H₂SO₄ Test:**
    - **CO₃²⁻:** Effervescence, CO₂ (turns lime water milky)
    - **S²⁻:** H₂S gas (rotten egg smell)
    - **SO₃²⁻:** SO₂ gas (pungent, turns K₂Cr₂O₇ green)
    - **NO₂⁻:** Brown NO₂ gas

    **2. Concentrated H₂SO₄ Test:**
    - **Cl⁻:** HCl gas (white fumes with NH₃)
    - **Br⁻:** Br₂ vapors (red-brown)
    - **I⁻:** I₂ vapors (violet)
    - **NO₃⁻:** Brown NO₂ gas

    ### Confirmatory Tests

    **Carbonate (CO₃²⁻):**
    - Effervescence with dilute acid
    - CO₂ turns lime water milky

    **Sulfate (SO₄²⁻):**
    - BaCl₂ → BaSO₄ (white ppt, insoluble in acids)

    **Chloride (Cl⁻):**
    - AgNO₃ → AgCl (white ppt, soluble in NH₃)
    - Chromyl chloride test (red vapors)

    **Bromide (Br⁻):**
    - AgNO₃ → AgBr (pale yellow, sparingly soluble in NH₃)
    - Chlorine water → Br₂ (brown layer)

    **Iodide (I⁻):**
    - AgNO₃ → AgI (yellow, insoluble in NH₃)
    - Chlorine water → I₂ (violet in CCl₄)

    **Nitrate (NO₃⁻):**
    - **Brown ring test:** FeSO₄ + H₂SO₄ → [Fe(H₂O)₅(NO)]²⁺ (brown)

    **Sulfide (S²⁻):**
    - Lead acetate paper → PbS (black)
    - Sodium nitroprusside → Purple color

    **Phosphate (PO₄³⁻):**
    - Ammonium molybdate → Yellow ppt

    ## Salt Analysis Procedure

    **Step 1:** Preliminary tests
    - Note color, smell
    - Flame test
    - Dry heating

    **Step 2:** Wet tests
    - Carbonate test
    - Sulfide test

    **Step 3:** Systematic cation analysis
    - Group separation
    - Confirmatory tests

    **Step 4:** Anion analysis
    - Preliminary tests
    - Confirmatory tests

    ## IIT JEE Key Points

    1. **Group I:** Dilute HCl (Pb²⁺, Ag⁺, Hg₂²⁺)
    2. **Group II:** H₂S acidic (Cu²⁺, Pb²⁺, Cd²⁺)
    3. **Brown ring test:** NO₃⁻ detection
    4. **Chromyl chloride:** Cl⁻ detection (red vapors)
    5. **[Cu(NH₃)₄]²⁺:** Deep blue (Cu²⁺ test)
    6. **Flame colors:** Ca (brick red), Sr (crimson), Ba (green)
    7. **BaSO₄:** White ppt (SO₄²⁻ test)

## Key Points

- Group reagents

- Cation groups

- Anion tests
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Group reagents', 'Cation groups', 'Anion tests', 'Salt analysis'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Iron and Copper Compounds ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Iron and Copper Compounds',
  content: <<~MARKDOWN,
# Iron and Copper Compounds 🚀

# Iron and Copper Compounds

    ## Iron Compounds

    ### Oxidation States
    - **Fe²⁺ (Ferrous):** 3d⁶, pale green, stable
    - **Fe³⁺ (Ferric):** 3d⁵, yellow-brown, more stable in air

    ### Important Iron Compounds

    **1. Ferrous Sulfate - FeSO₄·7H₂O (Green Vitriol)**
    - Pale green crystals
    - Reducing agent
    - Oxidizes to Fe³⁺ in air: 4FeSO₄ + O₂ + 2H₂SO₄ → 2Fe₂(SO₄)₃ + 2H₂O
    - **Uses:** Iron supplement, ink, water treatment

    **2. Ferric Chloride - FeCl₃**
    - Yellow-brown deliquescent solid
    - FeCl₃ + 3H₂O → Fe(OH)₃ + 3HCl
    - **Uses:** Water treatment, etching, catalyst

    **3. Iron Oxides**
    - **FeO:** Black, basic
    - **Fe₂O₃:** Red (rust, hematite), amphoteric
    - **Fe₃O₄:** Black (magnetite), mixed oxide (FeO·Fe₂O₃)

    **4. Potassium Ferrocyanide - K₄[Fe(CN)₆]**
    - Yellow crystals
    - Fe in +2 state
    - With Fe³⁺: Prussian blue precipitate

    **5. Potassium Ferricyanide - K₃[Fe(CN)₆]**
    - Red crystals
    - Fe in +3 state
    - Oxidizing agent

    ## Copper Compounds

    ### Oxidation States
    - **Cu⁺ (Cuprous):** 3d¹⁰, colorless, disproportionates
    - **Cu²⁺ (Cupric):** 3d⁹, blue, stable

    ### Important Copper Compounds

    **1. Copper Sulfate - CuSO₄·5H₂O (Blue Vitriol)**
    - Blue crystals
    - **Anhydrous CuSO₄:** White powder
    - CuSO₄·5H₂O → CuSO₄ + 5H₂O (on heating)
    - **Test for water:** White CuSO₄ turns blue with water
    - **Uses:** Fungicide, electroplating, Fehling's reagent

    **2. Copper Oxide - CuO (Cupric Oxide)**
    - Black powder
    - Basic oxide
    - **Uses:** Oxidizing agent in organic analysis

    **3. Cuprous Oxide - Cu₂O**
    - Red/yellow powder
    - Fehling's test for reducing sugars

    **4. Copper(II) Hydroxide - Cu(OH)₂**
    - Blue precipitate
    - Cu²⁺ + 2OH⁻ → Cu(OH)₂
    - Dissolves in excess NH₃: [Cu(NH₃)₄]²⁺ (deep blue)

    ## IIT JEE Key Points

    1. **FeSO₄·7H₂O:** Green vitriol, reducing agent
    2. **Fe²⁺ → Fe³⁺:** Pale green → yellow-brown
    3. **CuSO₄·5H₂O:** Blue vitriol, test for water
    4. **[Cu(NH₃)₄]²⁺:** Deep blue complex
    5. **Fe₃O₄:** Mixed oxide, magnetic

## Key Points

- Iron compounds

- Copper compounds

- Ferrous vs Ferric
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Iron compounds', 'Copper compounds', 'Ferrous vs Ferric', 'Blue vitriol'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Lanthanoids and Actinoids - Properties and Contraction ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lanthanoids and Actinoids - Properties and Contraction',
  content: <<~MARKDOWN,
# Lanthanoids and Actinoids - Properties and Contraction 🚀

# f-Block Elements

    ## Introduction

    **f-Block elements:** Elements in which the **4f or 5f orbitals** are being filled.

    ### Lanthanoids (Rare Earths)
    - **Elements:** Ce (58) to Lu (71) - 14 elements
    - **Configuration:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s²
    - **Series:** 4f series

    ### Actinoids
    - **Elements:** Th (90) to Lr (103) - 14 elements
    - **Configuration:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²
    - **Series:** 5f series

    ## Lanthanoid Contraction

    **Definition:** Steady **decrease in atomic and ionic radii** from La to Lu.

    **Cause:** Poor shielding by 4f electrons
    - As 4f electrons are added, they don't shield outer electrons effectively
    - Effective nuclear charge increases
    - Attraction on outer electrons increases → radius decreases

    **Magnitude:** ~10 pm decrease from La³⁺ to Lu³⁺

    ### Consequences of Lanthanoid Contraction

    **1. Similar radii of 4d and 5d series**
    - Zr and Hf have nearly identical radii
    - Makes separation difficult

    **2. Variation in basic strength of hydroxides**
    - La(OH)₃ most basic, Lu(OH)₃ least basic
    - Smaller ion → more covalent → less basic

    **3. Complex formation**
    - Heavier lanthanoids form more stable complexes

    ## Properties of Lanthanoids

    ### Physical Properties
    - Silvery-white soft metals
    - High melting points
    - Good conductors
    - Paramagnetic (unpaired 4f electrons)

    ### Chemical Properties

    **1. Oxidation States**
    - **Common:** +3 (most stable)
    - **Exceptions:** Ce⁴⁺ (4f⁰), Eu²⁺ (4f⁷), Yb²⁺ (4f¹⁴)
    - Stability: Empty > Half-filled > Filled > Others

    **2. Color**
    - Colored due to f-f transitions
    - Example: Pr³⁺ (green), Nd³⁺ (violet)

    **3. Magnetic Properties**
    - All are paramagnetic (except La³⁺ and Lu³⁺)

    ## Properties of Actinoids

    ### Oxidation States
    - Show **variable oxidation states** (+3, +4, +5, +6, +7)
    - More variable than lanthanoids
    - Example: U shows +3, +4, +5, +6

    ### Radioactivity
    - **All actinoids are radioactive**
    - Elements after U (93+) are synthetic

    ### Color
    - Colored due to f-f and f-d transitions

    ## Comparison: Lanthanoids vs Actinoids

    | Property | Lanthanoids | Actinoids |
    |----------|-------------|-----------|
    | **Series** | 4f | 5f |
    | **Oxidation states** | +3 mainly | +3, +4, +5, +6, +7 |
    | **Radioactivity** | Not radioactive (except Pm) | All radioactive |
    | **Synthesis** | Natural | U+ synthetic |
    | **Shielding** | Poor | Very poor |
    | **Complex formation** | Less | More |

    ## Uses

    **Lanthanoids:**
    - **Ce:** Lighter flints, glass polishing
    - **La:** Camera lenses, studio lighting
    - **Nd:** Lasers, powerful magnets
    - **Mixed oxides:** Petroleum cracking catalyst

    **Actinoids:**
    - **U:** Nuclear fuel
    - **Pu:** Nuclear weapons
    - **Am:** Smoke detectors

    ## IIT JEE Key Points

    1. **Lanthanoids:** 4f series (Ce-Lu), mainly +3
    2. **Actinoids:** 5f series (Th-Lr), variable oxidation states
    3. **Lanthanoid contraction:** Decrease in size due to poor 4f shielding
    4. **Consequences:** 4d and 5d series have similar radii
    5. **All actinoids are radioactive**
    6. **Ce⁴⁺:** 4f⁰ (stable), Eu²⁺: 4f⁷ (half-filled)

## Key Points

- Lanthanoids

- Actinoids

- Lanthanoid contraction
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Lanthanoids', 'Actinoids', 'Lanthanoid contraction', '4f and 5f series'],
  prerequisite_ids: []
)

# === MICROLESSON 7: Principles of Metallurgy and Extraction Methods ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Principles of Metallurgy and Extraction Methods',
  content: <<~MARKDOWN,
# Principles of Metallurgy and Extraction Methods 🚀

# Principles of Metallurgy

    ## Introduction

    **Metallurgy:** Science and technology of extracting metals from ores.

    **Ore:** Mineral from which metal can be extracted economically.

    **Gangue/Matrix:** Unwanted impurities in ore (SiO₂, clay, etc.)

    ## Steps in Metallurgy

    ### 1. Concentration (Ore Dressing)

    **Purpose:** Remove gangue from ore

    **Methods:**

    **a) Gravity Separation (Hydraulic Washing)**
    - Based on density difference
    - Example: Tin ore (heavier) separated from gangue

    **b) Magnetic Separation**
    - Magnetic ore separated using electromagnet
    - Example: Fe₃O₄ (magnetic) separated from non-magnetic impurities

    **c) Froth Flotation**
    - Based on preferential wetting
    - Ore particles attach to froth, gangue sinks
    - **Pine oil:** Frothing agent
    - **Example:** Sulfide ores (ZnS, PbS, CuFeS₂)

    **d) Leaching (Chemical Method)**
    - Ore dissolved in suitable reagent
    - **Bauxite:** Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O
    - **Gold/Silver:** 4Au + 8NaCN + O₂ + 2H₂O → 4Na[Au(CN)₂] + 4NaOH

    ### 2. Conversion to Oxide

    **a) Roasting**
    - **Heating ore in presence of excess air**
    - Converts sulfides to oxides
    - **Example:** 2ZnS + 3O₂ → 2ZnO + 2SO₂

    **b) Calcination**
    - **Heating ore in limited or no air**
    - Removes moisture, CO₂
    - **Example:** CaCO₃ → CaO + CO₂

    ### 3. Reduction

    **Methods:**

    **a) Smelting (with Carbon)**
    - For less reactive metals (Fe, Zn, Sn, Pb)
    - **Example:** ZnO + C → Zn + CO
    - **Blast furnace:** Iron extraction

    **b) Self Reduction (Auto-reduction)**
    - For Cu, Hg, Pb
    - **Example:** Cu₂S + 2Cu₂O → 6Cu + SO₂

    **c) Electrolytic Reduction**
    - For highly reactive metals (Na, K, Ca, Mg, Al)
    - **Example:** 2Al₂O₃ → 4Al + 3O₂ (Hall-Heroult process)

    **d) Metal Displacement (Thermite)**
    - More reactive metal reduces oxide
    - **Example:** Cr₂O₃ + 2Al → 2Cr + Al₂O₃

    ### 4. Refining (Purification)

    **a) Liquation**
    - Heating impure metal
    - Low melting metal flows, impurities remain
    - **Example:** Tin

    **b) Distillation**
    - Low boiling metal vaporized and condensed
    - **Example:** Zn, Hg

    **c) Electrolytic Refining**
    - **Anode:** Impure metal
    - **Cathode:** Pure metal deposited
    - **Example:** Cu, Ag, Au, Zn, Al

    **d) Zone Refining**
    - For very high purity (semiconductors)
    - Molten zone moves, impurities concentrate
    - **Example:** Ge, Si

    **e) Vapour Phase Refining**
    - **Mond process (Ni):** Ni + 4CO → Ni(CO)₄ → Ni + 4CO
    - **Van Arkel (Ti, Zr):** Ti + 2I₂ → TiI₄ → Ti + 2I₂

    ## Thermodynamics of Metallurgy

    ### Ellingham Diagram

    **Shows:** ΔG° vs Temperature for metal oxide formation

    **Key Points:**
    1. **Lower line = more stable oxide**
    2. **Metal can reduce oxide below it**
    3. **C line crosses many oxides** → good reducing agent
    4. **Al always above other metals** → very reactive

    **Example:**
    - At 1000 K: C can reduce ZnO (C line below Zn line)
    - At 500 K: C cannot reduce ZnO (C line above Zn line)

    ### Gibbs Energy Change

    ΔG = ΔH - TΔS

    **For reduction to be feasible:** ΔG < 0

    ## Extraction Examples

    ### Iron (Blast Furnace)
    - **Ore:** Hematite (Fe₂O₃), Magnetite (Fe₃O₄)
    - **Flux:** CaCO₃
    - **Reducing agent:** CO (from coke)
    - **Reaction:** Fe₂O₃ + 3CO → 2Fe + 3CO₂
    - **Slag:** CaSiO₃ (floats on molten iron)

    ### Aluminium (Hall-Heroult Process)
    - **Ore:** Bauxite (Al₂O₃·2H₂O)
    - **Purification:** Baeyer's process
    - **Electrolysis:** Cryolite (Na₃AlF₆) + Al₂O₃
    - **Cathode:** Al deposited
    - **Anode:** Carbon, O₂ evolved

    ### Copper
    - **Ore:** Copper pyrite (CuFeS₂)
    - **Roasting:** 2CuFeS₂ + O₂ → Cu₂S + 2FeS + SO₂
    - **Smelting:** Cu₂S + FeS → Cu₂S + FeO (slag removed)
    - **Bessemerisation:** Cu₂S + O₂ → 2Cu + SO₂
    - **Refining:** Electrolytic

    ## IIT JEE Key Points

    1. **Froth flotation:** Sulfide ores, pine oil
    2. **Roasting:** Heating in excess air (S → O)
    3. **Calcination:** Heating in limited air (remove CO₂, H₂O)
    4. **Ellingham diagram:** Lower line = more stable oxide
    5. **Zone refining:** Highest purity (Ge, Si)
    6. **Mond process:** Ni + 4CO → Ni(CO)₄
    7. **Hall-Heroult:** Aluminium extraction
    8. **Blast furnace:** Iron extraction

## Key Points

- Metallurgy

- Concentration

- Roasting
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Metallurgy', 'Concentration', 'Roasting', 'Calcination', 'Reduction', 'Refining'],
  prerequisite_ids: []
)

# === MICROLESSON 8: Cation and Anion Analysis - Group Reagents and Tests ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cation and Anion Analysis - Group Reagents and Tests',
  content: <<~MARKDOWN,
# Cation and Anion Analysis - Group Reagents and Tests 🚀

# Qualitative Inorganic Analysis

    ## Cation Analysis

    ### Group Reagents

    | Group | Reagent | Cations | Precipitate Color |
    |-------|---------|---------|------------------|
    | **I** | Dilute HCl | Pb²⁺, Ag⁺, Hg₂²⁺ | White |
    | **II** | H₂S (acidic) | Hg²⁺, Pb²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn⁴⁺ | Colored sulfides |
    | **III** | NH₄OH + NH₄Cl | Fe³⁺, Al³⁺, Cr³⁺ | Hydroxides |
    | **IV** | H₂S (basic) | Zn²⁺, Mn²⁺, Ni²⁺, Co²⁺ | Colored sulfides |
    | **V** | (NH₄)₂CO₃ | Ba²⁺, Sr²⁺, Ca²⁺ | White carbonates |
    | **VI** | - | Mg²⁺, NH₄⁺, Na⁺, K⁺ | Soluble |

    ### Important Confirmatory Tests

    **Group I:**
    - **Ag⁺:** AgCl (white) → soluble in NH₃ → [Ag(NH₃)₂]⁺
    - **Pb²⁺:** PbCl₂ (white) → soluble in hot water → PbCrO₄ (yellow)
    - **Hg₂²⁺:** Hg₂Cl₂ (white) → black with NH₃

    **Group II:**
    - **Cu²⁺:** CuS (black) → [Cu(NH₃)₄]²⁺ (deep blue)
    - **Pb²⁺:** PbS (black) → PbCrO₄ (yellow)
    - **Cd²⁺:** CdS (yellow)

    **Group III:**
    - **Fe³⁺:** Fe(OH)₃ (brown) → Blood red with KSCN
    - **Al³⁺:** Al(OH)₃ (white, gelatinous)
    - **Cr³⁺:** Cr(OH)₃ (green) → Yellow chromate

    **Group IV:**
    - **Zn²⁺:** ZnS (white) → [Zn(OH)₄]²⁻ (soluble in excess NaOH)
    - **Mn²⁺:** MnS (flesh colored)
    - **Ni²⁺:** NiS (black) → Dimethylglyoxime test (red ppt)
    - **Co²⁺:** CoS (black) → Blue with thiocyanate

    **Group V:**
    - **Ba²⁺:** BaCO₃ → BaCrO₄ (yellow)
    - **Sr²⁺:** Crimson flame
    - **Ca²⁺:** Brick red flame

    ## Anion Analysis

    ### Preliminary Tests

    **1. Dilute H₂SO₄ Test:**
    - **CO₃²⁻:** Effervescence, CO₂ (turns lime water milky)
    - **S²⁻:** H₂S gas (rotten egg smell)
    - **SO₃²⁻:** SO₂ gas (pungent, turns K₂Cr₂O₇ green)
    - **NO₂⁻:** Brown NO₂ gas

    **2. Concentrated H₂SO₄ Test:**
    - **Cl⁻:** HCl gas (white fumes with NH₃)
    - **Br⁻:** Br₂ vapors (red-brown)
    - **I⁻:** I₂ vapors (violet)
    - **NO₃⁻:** Brown NO₂ gas

    ### Confirmatory Tests

    **Carbonate (CO₃²⁻):**
    - Effervescence with dilute acid
    - CO₂ turns lime water milky

    **Sulfate (SO₄²⁻):**
    - BaCl₂ → BaSO₄ (white ppt, insoluble in acids)

    **Chloride (Cl⁻):**
    - AgNO₃ → AgCl (white ppt, soluble in NH₃)
    - Chromyl chloride test (red vapors)

    **Bromide (Br⁻):**
    - AgNO₃ → AgBr (pale yellow, sparingly soluble in NH₃)
    - Chlorine water → Br₂ (brown layer)

    **Iodide (I⁻):**
    - AgNO₃ → AgI (yellow, insoluble in NH₃)
    - Chlorine water → I₂ (violet in CCl₄)

    **Nitrate (NO₃⁻):**
    - **Brown ring test:** FeSO₄ + H₂SO₄ → [Fe(H₂O)₅(NO)]²⁺ (brown)

    **Sulfide (S²⁻):**
    - Lead acetate paper → PbS (black)
    - Sodium nitroprusside → Purple color

    **Phosphate (PO₄³⁻):**
    - Ammonium molybdate → Yellow ppt

    ## Salt Analysis Procedure

    **Step 1:** Preliminary tests
    - Note color, smell
    - Flame test
    - Dry heating

    **Step 2:** Wet tests
    - Carbonate test
    - Sulfide test

    **Step 3:** Systematic cation analysis
    - Group separation
    - Confirmatory tests

    **Step 4:** Anion analysis
    - Preliminary tests
    - Confirmatory tests

    ## IIT JEE Key Points

    1. **Group I:** Dilute HCl (Pb²⁺, Ag⁺, Hg₂²⁺)
    2. **Group II:** H₂S acidic (Cu²⁺, Pb²⁺, Cd²⁺)
    3. **Brown ring test:** NO₃⁻ detection
    4. **Chromyl chloride:** Cl⁻ detection (red vapors)
    5. **[Cu(NH₃)₄]²⁺:** Deep blue (Cu²⁺ test)
    6. **Flame colors:** Ca (brick red), Sr (crimson), Ba (green)
    7. **BaSO₄:** White ppt (SO₄²⁻ test)

## Key Points

- Group reagents

- Cation groups

- Anion tests
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Group reagents', 'Cation groups', 'Anion tests', 'Salt analysis'],
  prerequisite_ids: []
)

# === MICROLESSON 9: copper_compounds — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'copper_compounds — Practice',
  content: <<~MARKDOWN,
# copper_compounds — Practice 🚀

CuSO₄·5H₂O is called blue vitriol due to its blue color. Anhydrous CuSO₄ is white.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['copper_compounds'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The common name for CuSO₄·5H₂O is _______.',
    answer: 'blue vitriol|Blue vitriol',
    explanation: 'CuSO₄·5H₂O is called blue vitriol due to its blue color. Anhydrous CuSO₄ is white.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: copper_compounds — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'copper_compounds — Practice',
  content: <<~MARKDOWN,
# copper_compounds — Practice 🚀

[Cu(NH₃)₄]²⁺ complex is deep blue (tetraamminecopper(II) ion). Formed when Cu(OH)₂ dissolves in excess NH₃.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['copper_compounds'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What color is the [Cu(NH₃)₄]²⁺ complex?',
    options: ['Pale blue', 'Deep blue', 'Green', 'Colorless'],
    correct_answer: 1,
    explanation: '[Cu(NH₃)₄]²⁺ complex is deep blue (tetraamminecopper(II) ion). Formed when Cu(OH)₂ dissolves in excess NH₃.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: lanthanoid_contraction — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'lanthanoid_contraction — Practice',
  content: <<~MARKDOWN,
# lanthanoid_contraction — Practice 🚀

Lanthanoid contraction is the steady decrease in size from La³⁺ to Lu³⁺ due to poor shielding by 4f electrons.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['lanthanoid_contraction'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The steady decrease in atomic and ionic radii from La to Lu is called _______.',
    answer: 'lanthanoid contraction|lanthanide contraction',
    explanation: 'Lanthanoid contraction is the steady decrease in size from La³⁺ to Lu³⁺ due to poor shielding by 4f electrons.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: oxidation_states — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_states — Practice',
  content: <<~MARKDOWN,
# oxidation_states — Practice 🚀

Lanthanoids show +3 oxidation state predominantly. Exceptions: Ce⁴⁺, Eu²⁺, Yb²⁺.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['oxidation_states'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the most common oxidation state of lanthanoids?',
    options: ['+2', '+3', '+4', '+5'],
    correct_answer: 1,
    explanation: 'Lanthanoids show +3 oxidation state predominantly. Exceptions: Ce⁴⁺, Eu²⁺, Yb²⁺.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: actinoids — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'actinoids — Practice',
  content: <<~MARKDOWN,
# actinoids — Practice 🚀

TRUE. All actinoids are radioactive. Elements after uranium (93+) are synthetic and highly radioactive.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['actinoids'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'All actinoids are radioactive.',
    answer: 'true',
    explanation: 'TRUE. All actinoids are radioactive. Elements after uranium (93+) are synthetic and highly radioactive.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: concentration — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'concentration — Practice',
  content: <<~MARKDOWN,
# concentration — Practice 🚀

Froth flotation is used for sulfide ores (ZnS, PbS, CuFeS₂). Pine oil is used as frothing agent.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['concentration'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which concentration method is used for sulfide ores?',
    options: ['Gravity separation', 'Magnetic separation', 'Froth flotation', 'Leaching'],
    correct_answer: 2,
    explanation: 'Froth flotation is used for sulfide ores (ZnS, PbS, CuFeS₂). Pine oil is used as frothing agent.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 15: conversion_to_oxide — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'conversion_to_oxide — Practice',
  content: <<~MARKDOWN,
# conversion_to_oxide — Practice 🚀

Roasting: heating in excess air (converts S to O). Calcination: heating in limited/no air (removes CO₂, H₂O).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['conversion_to_oxide'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the difference between roasting and calcination?',
    options: ['Roasting is heating in excess air, calcination is in limited air', 'Roasting is for oxides, calcination is for sulfides', 'They are the same process', 'Roasting uses flux, calcination does not'],
    correct_answer: 0,
    explanation: 'Roasting: heating in excess air (converts S to O). Calcination: heating in limited/no air (removes CO₂, H₂O).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: refining — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'refining — Practice',
  content: <<~MARKDOWN,
# refining — Practice 🚀

Mond process: Ni + 4CO → Ni(CO)₄ (volatile, decomposed to get pure Ni). Vapour phase refining.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['refining'],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The process used to refine Ni to highest purity is called the _______ process.',
    answer: 'Mond|mond',
    explanation: 'Mond process: Ni + 4CO → Ni(CO)₄ (volatile, decomposed to get pure Ni). Vapour phase refining.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: group_reagents — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'group_reagents — Practice',
  content: <<~MARKDOWN,
# group_reagents — Practice 🚀

Group I reagent is dilute HCl. Precipitates: Pb²⁺, Ag⁺, Hg₂²⁺ as white chlorides.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['group_reagents'],
  prerequisite_ids: []
)

# Exercise 17.2: MCQ
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which group reagent is used for Group I cations?',
    options: ['Dilute HCl', 'H₂S in acidic medium', 'NH₄OH', '(NH₄)₂CO₃'],
    correct_answer: 0,
    explanation: 'Group I reagent is dilute HCl. Precipitates: Pb²⁺, Ag⁺, Hg₂²⁺ as white chlorides.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 18: anion_tests — Practice ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'anion_tests — Practice',
  content: <<~MARKDOWN,
# anion_tests — Practice 🚀

Brown ring test detects NO₃⁻. FeSO₄ + H₂SO₄ + NO₃⁻ → [Fe(H₂O)₅(NO)]²⁺ (brown ring).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['anion_tests'],
  prerequisite_ids: []
)

# Exercise 18.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The brown ring test is used to detect _______ ions.',
    answer: 'nitrate|NO3-|NO₃⁻',
    explanation: 'Brown ring test detects NO₃⁻. FeSO₄ + H₂SO₄ + NO₃⁻ → [Fe(H₂O)₅(NO)]²⁺ (brown ring).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 19: Iron and Copper Compounds ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Iron and Copper Compounds',
  content: <<~MARKDOWN,
# Iron and Copper Compounds 🚀

# Iron and Copper Compounds

    ## Iron Compounds

    ### Oxidation States
    - **Fe²⁺ (Ferrous):** 3d⁶, pale green, stable
    - **Fe³⁺ (Ferric):** 3d⁵, yellow-brown, more stable in air

    ### Important Iron Compounds

    **1. Ferrous Sulfate - FeSO₄·7H₂O (Green Vitriol)**
    - Pale green crystals
    - Reducing agent
    - Oxidizes to Fe³⁺ in air: 4FeSO₄ + O₂ + 2H₂SO₄ → 2Fe₂(SO₄)₃ + 2H₂O
    - **Uses:** Iron supplement, ink, water treatment

    **2. Ferric Chloride - FeCl₃**
    - Yellow-brown deliquescent solid
    - FeCl₃ + 3H₂O → Fe(OH)₃ + 3HCl
    - **Uses:** Water treatment, etching, catalyst

    **3. Iron Oxides**
    - **FeO:** Black, basic
    - **Fe₂O₃:** Red (rust, hematite), amphoteric
    - **Fe₃O₄:** Black (magnetite), mixed oxide (FeO·Fe₂O₃)

    **4. Potassium Ferrocyanide - K₄[Fe(CN)₆]**
    - Yellow crystals
    - Fe in +2 state
    - With Fe³⁺: Prussian blue precipitate

    **5. Potassium Ferricyanide - K₃[Fe(CN)₆]**
    - Red crystals
    - Fe in +3 state
    - Oxidizing agent

    ## Copper Compounds

    ### Oxidation States
    - **Cu⁺ (Cuprous):** 3d¹⁰, colorless, disproportionates
    - **Cu²⁺ (Cupric):** 3d⁹, blue, stable

    ### Important Copper Compounds

    **1. Copper Sulfate - CuSO₄·5H₂O (Blue Vitriol)**
    - Blue crystals
    - **Anhydrous CuSO₄:** White powder
    - CuSO₄·5H₂O → CuSO₄ + 5H₂O (on heating)
    - **Test for water:** White CuSO₄ turns blue with water
    - **Uses:** Fungicide, electroplating, Fehling's reagent

    **2. Copper Oxide - CuO (Cupric Oxide)**
    - Black powder
    - Basic oxide
    - **Uses:** Oxidizing agent in organic analysis

    **3. Cuprous Oxide - Cu₂O**
    - Red/yellow powder
    - Fehling's test for reducing sugars

    **4. Copper(II) Hydroxide - Cu(OH)₂**
    - Blue precipitate
    - Cu²⁺ + 2OH⁻ → Cu(OH)₂
    - Dissolves in excess NH₃: [Cu(NH₃)₄]²⁺ (deep blue)

    ## IIT JEE Key Points

    1. **FeSO₄·7H₂O:** Green vitriol, reducing agent
    2. **Fe²⁺ → Fe³⁺:** Pale green → yellow-brown
    3. **CuSO₄·5H₂O:** Blue vitriol, test for water
    4. **[Cu(NH₃)₄]²⁺:** Deep blue complex
    5. **Fe₃O₄:** Mixed oxide, magnetic

## Key Points

- Iron compounds

- Copper compounds

- Ferrous vs Ferric
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Iron compounds', 'Copper compounds', 'Ferrous vs Ferric', 'Blue vitriol'],
  prerequisite_ids: []
)

puts "✓ Created 19 microlessons for F Block Elements"

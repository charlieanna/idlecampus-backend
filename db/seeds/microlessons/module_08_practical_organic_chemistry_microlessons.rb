# AUTO-GENERATED from module_08_practical_organic_chemistry.rb
puts "Creating Microlessons for Module 08 Practical Organic Chemistry..."

module_var = CourseModule.find_by(slug: 'module-08-practical-organic-chemistry')

# === MICROLESSON 1: Both aldehydes and ketones give a positive 2,4-DNP test. ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Both aldehydes and ketones give a positive 2,4-DNP test.',
  content: <<~MARKDOWN,
# Both aldehydes and ketones give a positive 2,4-DNP test. 🚀

TRUE. The 2,4-DNP (2,4-dinitrophenylhydrazine) test is positive for all compounds containing a carbonyl group (C=O), including both aldehydes and ketones. Yellow/orange precipitate forms.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Both aldehydes and ketones give a positive 2,4-DNP test.',
    answer: '',
    explanation: 'TRUE. The 2,4-DNP (2,4-dinitrophenylhydrazine) test is positive for all compounds containing a carbonyl group (C=O), including both aldehydes and ketones. Yellow/orange precipitate forms.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Qualitative Analysis - Detection Tests for Elements and Functional Groups ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Qualitative Analysis - Detection Tests for Elements and Functional Groups',
  content: <<~MARKDOWN,
# Qualitative Analysis - Detection Tests for Elements and Functional Groups 🚀

# Qualitative Analysis of Organic Compounds

    ## 1. Introduction

    ### Purpose of Qualitative Analysis
    1. **Element detection:** C, H, O, N, S, halogens
    2. **Functional group identification:** -OH, -CHO, -COOH, -NH₂, etc.
    3. **Structure determination:** Combining with other data

    ### Systematic Approach
    1. Physical examination (color, odor, state)
    2. Detection of elements
    3. Functional group tests
    4. Confirmatory tests

    ---

    ## 2. Detection of Carbon and Hydrogen

    ### Test: Combustion Test

    **Procedure:**
    - Heat organic compound with copper(II) oxide (CuO)
    - Organic compound oxidized to CO₂ and H₂O

    **Reactions:**
    ```
    C (in compound) + 2CuO → CO₂ + 2Cu
    2H (in compound) + CuO → H₂O + Cu
    ```

    **Observations:**
    - **Carbon:** CO₂ turns lime water milky
      ```
      Ca(OH)₂ + CO₂ → CaCO₃ (white ppt) + H₂O
      ```

    - **Hydrogen:** H₂O condenses on cool surface or turns anhydrous CuSO₄ blue
      ```
      CuSO₄ (white) + 5H₂O → CuSO₄·5H₂O (blue)
      ```

    ---

    ## 3. Detection of Nitrogen, Sulfur, and Halogens

    ### Lassaigne's Test (Sodium Fusion Test)

    **Principle:** Convert covalent organic compounds to ionic forms (water-soluble)

    **Procedure:**
    1. Fuse organic compound with metallic sodium
    2. Extract with water (sodium fusion extract - SFE)
    3. Perform specific tests on SFE

    **Key reactions during fusion:**
    ```
    Nitrogen: C, H, N + Na → NaCN (sodium cyanide)
    Sulfur: S + 2Na → Na₂S (sodium sulfide)
    Halogens: C, H, X + Na → NaX (sodium halide)
    ```

    ### A. Test for Nitrogen (Prussian Blue Test)

    **Procedure:**
    1. Boil SFE with FeSO₄ (iron(II) sulfate)
    2. Add few drops H₂SO₄
    3. Heat and cool

    **Reactions:**
    ```
    6NaCN + FeSO₄ → Na₄[Fe(CN)₆] (sodium ferrocyanide) + Na₂SO₄

    3Na₄[Fe(CN)₆] + 4FeSO₄ → Fe₄[Fe(CN)₆]₃ (Prussian blue) + 6Na₂SO₄
    ```

    **Observation:**
    - **Prussian blue/green precipitate** → Nitrogen present

    ### B. Test for Sulfur

    **Procedure:**
    1. Acidify SFE with acetic acid
    2. Add lead acetate solution

    **Reaction:**
    ```
    Na₂S + (CH₃COO)₂Pb → PbS (black ppt) + 2CH₃COONa
    ```

    **Observation:**
    - **Black precipitate** → Sulfur present

    **Alternative Test (Sodium Nitroprusside Test):**
    ```
    Na₂S + Na₂[Fe(CN)₅NO] → Purple/violet color
    ```

    ### C. Test for Halogens

    **Procedure:**
    1. Acidify SFE with HNO₃
    2. Add AgNO₃ solution

    **Reactions:**
    ```
    NaCl + AgNO₃ → AgCl (white ppt) + NaNO₃
    NaBr + AgNO₃ → AgBr (pale yellow ppt) + NaNO₃
    NaI + AgNO₃ → AgI (yellow ppt) + NaNO₃
    ```

    **Observations:**
    - **White ppt:** Chlorine
    - **Pale yellow ppt:** Bromine
    - **Yellow ppt:** Iodine

    **Note:** If N and S are present with halogens, they must be removed first (interfere with test):
    ```
    NaCN + AgNO₃ → AgCN (white) - interferes
    Na₂S + AgNO₃ → Ag₂S (black) - interferes
    ```

    ---

    ## 4. Detection of Oxygen

    ### No Direct Test
    - Oxygen is detected by **difference**
    - If elements add up to <100% → Oxygen likely present
    - Oxygen presence inferred from functional group tests

    ---

    ## 5. Functional Group Tests - Alcohols and Phenols

    ### A. Test for Alcohols

    #### 1. Ester Test (Acetylation)
    **Reagent:** Acetic anhydride or acetyl chloride

    **Reaction:**
    ```
    R-OH + (CH₃CO)₂O → R-O-CO-CH₃ (ester) + CH₃COOH
    ```

    **Observation:**
    - **Fruity smell** of ester

    #### 2. Lucas Test (Distinguish 1°, 2°, 3° alcohols)
    **Reagent:** Lucas reagent (ZnCl₂ in conc. HCl)

    **Principle:** 3° > 2° > 1° reactivity toward SN1

    **Observations:**
    - **Tertiary (3°):** Turbidity appears **immediately**
    - **Secondary (2°):** Turbidity after **5-10 minutes**
    - **Primary (1°):** **No turbidity** at room temperature

    **Reaction:**
    ```
    R-OH + HCl → R-Cl (insoluble, turbid) + H₂O
    ```

    #### 3. Oxidation Test (Victor Meyer Test)
    **Reagent:** K₂Cr₂O₇ + H₂SO₄ (or KMnO₄)

    **Observations:**
    - **Primary alcohol:** Oxidized to aldehyde, then carboxylic acid (orange to green)
    - **Secondary alcohol:** Oxidized to ketone (orange to green)
    - **Tertiary alcohol:** **No oxidation** (orange color persists)

    ### B. Test for Phenols

    #### 1. Ferric Chloride Test
    **Reagent:** Neutral FeCl₃ solution

    **Reaction:**
    ```
    3ArOH + FeCl₃ → [Fe(OAr)₃] (colored complex) + 3HCl
    ```

    **Observation:**
    - **Violet, blue, green, or red color** → Phenol present
    - Most common: Violet color for simple phenols

    #### 2. Bromine Water Test
    **Reagent:** Bromine water (Br₂/H₂O)

    **Reaction:**
    ```
    C₆H₅OH + 3Br₂ → 2,4,6-Tribromophenol (white ppt) + 3HBr
    ```

    **Observation:**
    - **White precipitate** → Phenol present
    - Decolorization of bromine water

    #### 3. Libermann's Nitroso Test
    **Reagent:** NaNO₂ + conc. H₂SO₄

    **Observation:**
    - **Deep blue/green color** → Phenol present

    ---

    ## 6. Functional Group Tests - Aldehydes and Ketones

    ### Tests for Carbonyl Group (C=O)

    #### 1. 2,4-DNP Test (2,4-Dinitrophenylhydrazine)
    **Reagent:** 2,4-dinitrophenylhydrazine in acidic solution

    **Reaction:**
    ```
    R-CHO + H₂N-NH-C₆H₃(NO₂)₂ → R-CH=N-NH-C₆H₃(NO₂)₂ (yellow/orange ppt)
    ```

    **Observation:**
    - **Yellow/orange precipitate** → Aldehyde or ketone present

    **Note:** Both aldehydes and ketones give this test (not specific)

    ### Tests Specific for Aldehydes

    #### 2. Tollens' Test (Silver Mirror Test)
    **Reagent:** Tollens' reagent [Ag(NH₃)₂]⁺ (ammoniacal AgNO₃)

    **Reaction:**
    ```
    R-CHO + 2[Ag(NH₃)₂]⁺ + 3OH⁻ → R-COO⁻ + 2Ag (silver mirror) + 4NH₃ + 2H₂O
    ```

    **Observation:**
    - **Silver mirror** on inner surface of test tube → Aldehyde present

    **Note:**
    - **Aldehydes:** Positive (reducing agents)
    - **Ketones:** Negative (not reducing)
    - Aromatic aldehydes (benzaldehyde) may give positive test but slowly

    #### 3. Fehling's Test
    **Reagent:** Fehling's solution (Cu²⁺ in alkaline tartrate)

    **Reaction:**
    ```
    R-CHO + 2Cu²⁺ + 5OH⁻ → R-COO⁻ + Cu₂O (red ppt) + 3H₂O
    ```

    **Observation:**
    - **Red precipitate (Cu₂O)** → Aliphatic aldehyde present

    **Note:**
    - **Aliphatic aldehydes:** Positive
    - **Aromatic aldehydes:** Negative
    - **Ketones:** Negative

    #### 4. Schiff's Test
    **Reagent:** Schiff's reagent (decolorized fuchsin)

    **Observation:**
    - **Pink/magenta color** → Aldehyde present
    - **Ketones:** No color change

    ### Test for Methyl Ketones

    #### Iodoform Test
    **Reagent:** I₂ + NaOH (or KI/I₂ + NaOH)

    **Reaction:**
    ```
    CH₃-CO-R + 3I₂ + 4NaOH → CHI₃ (iodoform, yellow ppt) + R-COONa + 3NaI + 3H₂O
    ```

    **Observation:**
    - **Yellow precipitate of iodoform** (characteristic smell)

    **Positive test:**
    - Methyl ketones: CH₃-CO-R
    - Ethanol: CH₃-CH₂-OH (oxidized to CH₃-CHO, then gives test)
    - Secondary alcohols with CH₃-CHOH-R structure

    ---

    ## 7. Functional Group Tests - Carboxylic Acids

    ### 1. Litmus Test
    **Observation:**
    - **Turns blue litmus red** → Acidic compound (carboxylic acid)

    ### 2. Sodium Bicarbonate Test
    **Reagent:** NaHCO₃ solution

    **Reaction:**
    ```
    R-COOH + NaHCO₃ → R-COONa + H₂O + CO₂ (effervescence)
    ```

    **Observation:**
    - **Brisk effervescence** → Carboxylic acid present
    - CO₂ turns lime water milky

    **Note:** This test distinguishes RCOOH from phenols (phenols don't react with NaHCO₃)

    ### 3. Ester Test
    **Reagent:** Ethanol + conc. H₂SO₄ (heat)

    **Reaction:**
    ```
    R-COOH + C₂H₅OH → R-COO-C₂H₅ (ester, fruity smell) + H₂O
    ```

    **Observation:**
    - **Fruity smell** → Carboxylic acid present

    ---

    ## 8. Functional Group Tests - Amines

    ### 1. Carbylamine Test (Isocyanide Test)
    **Reagent:** CHCl₃ + alcoholic KOH (heat)

    **Reaction:**
    ```
    R-NH₂ + CHCl₃ + 3KOH → R-N≡C (isocyanide, foul smell) + 3KCl + 3H₂O
    ```

    **Observation:**
    - **Offensive/foul smell** → Primary amine present

    **Note:** Only **primary amines** give this test (2° and 3° amines do NOT)

    ### 2. Hinsberg's Test (Distinguish 1°, 2°, 3° amines)
    **Reagent:** Benzenesulfonyl chloride (C₆H₅SO₂Cl) + KOH

    **Reactions:**

    **Primary amine:**
    ```
    R-NH₂ + C₆H₅SO₂Cl + KOH → C₆H₅SO₂-NH-R (soluble in KOH) + KCl + H₂O
    ```
    **Observation:** Soluble in base (clear solution)

    **Secondary amine:**
    ```
    R₂NH + C₆H₅SO₂Cl → C₆H₅SO₂-NR₂ (insoluble in KOH) + HCl
    ```
    **Observation:** Insoluble in base (oily layer or precipitate)

    **Tertiary amine:**
    ```
    R₃N + C₆H₅SO₂Cl → No reaction
    ```
    **Observation:** Remains as separate layer (unreacted)

    **Summary:**
    - **1° amine:** Soluble in KOH (can donate H⁺)
    - **2° amine:** Insoluble in KOH (no H to donate)
    - **3° amine:** No reaction (no H on N)

    ### 3. Azo Dye Test (for Aromatic Amines)
    **Reagent:** NaNO₂ + HCl (0-5°C), then β-naphthol

    **Reactions:**
    ```
    Step 1: Ar-NH₂ + NaNO₂ + 2HCl → Ar-N₂⁺Cl⁻ (diazonium salt) + NaCl + 2H₂O
    Step 2: Ar-N₂⁺Cl⁻ + β-naphthol → Ar-N=N-naphthol (orange-red dye)
    ```

    **Observation:**
    - **Orange-red dye** → Aromatic primary amine present

    ---

    ## 9. Summary Table - Functional Group Tests

    | Functional Group | Test | Reagent | Positive Result |
    |------------------|------|---------|-----------------|
    | **Alcohol** | Lucas test | ZnCl₂/HCl | Turbidity (3°>2°>1°) |
    | **Phenol** | FeCl₃ test | FeCl₃ | Violet/blue/green color |
    | **Phenol** | Bromine water | Br₂/H₂O | White ppt |
    | **Aldehyde** | Tollens' test | [Ag(NH₃)₂]⁺ | Silver mirror |
    | **Aldehyde** | Fehling's test | Cu²⁺/alkaline | Red ppt (Cu₂O) |
    | **Aldehyde/Ketone** | 2,4-DNP | 2,4-DNP | Yellow/orange ppt |
    | **Methyl ketone** | Iodoform | I₂/NaOH | Yellow ppt (CHI₃) |
    | **Carboxylic acid** | NaHCO₃ | NaHCO₃ | Effervescence (CO₂) |
    | **Primary amine** | Carbylamine | CHCl₃/KOH | Foul smell |
    | **Amines (1°/2°/3°)** | Hinsberg | C₆H₅SO₂Cl/KOH | Soluble/insoluble/no rxn |

    ---

    ## Important Points for IIT JEE

    1. **Lassaigne's test:**
       - Converts covalent to ionic (water-soluble)
       - N → NaCN (Prussian blue with Fe²⁺)
       - S → Na₂S (black PbS with lead acetate)
       - X → NaX (ppt with AgNO₃)

    2. **Distinction tests:**
       - Aldehyde vs ketone: Tollens' or Fehling's
       - 1°, 2°, 3° alcohols: Lucas test
       - 1°, 2°, 3° amines: Hinsberg test
       - RCOOH vs ArOH: NaHCO₃ test

    3. **Color tests:**
       - Phenol + FeCl₃ → Violet
       - Aldehyde + Tollens' → Silver mirror
       - Aldehyde + Fehling's → Red ppt
       - Methyl ketone + I₂/NaOH → Yellow ppt

    4. **Specific tests:**
       - Only primary amines: Carbylamine test
       - Only aldehydes: Tollens' and Fehling's
       - Only carboxylic acids: NaHCO₃ (effervescence)

    ---

    ## Practice Questions

    1. How would you distinguish between ethanal and propanone using a chemical test?
    2. An organic compound gives a silver mirror with Tollens' reagent. What functional group is present?
    3. Explain how Hinsberg's test distinguishes between 1°, 2°, and 3° amines.
    4. A compound gives a violet color with FeCl₃. Which functional group is present?
    5. How would you test for the presence of nitrogen in an organic compound?

## Key Points

- Detection of C, H, O, N, S, halogens

- Lassaigne\

- ,
    
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Detection of C, H, O, N, S, halogens', 'Lassaigne\', ',
    ', ',
    ', ',
    ', ',
    '],
  prerequisite_ids: []
)

# === MICROLESSON 3: Basic Laboratory Techniques - Purification and Separation Methods ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Basic Laboratory Techniques - Purification and Separation Methods',
  content: <<~MARKDOWN,
# Basic Laboratory Techniques - Purification and Separation Methods 🚀

# Basic Laboratory Techniques in Organic Chemistry

    ## 1. Introduction to Practical Organic Chemistry

    ### Importance
    - **Synthesis:** Preparing organic compounds
    - **Purification:** Obtaining pure products
    - **Analysis:** Identifying unknown compounds
    - **Characterization:** Determining structure and properties

    ### Safety Principles
    1. Always wear **safety goggles** and **lab coat**
    2. Work in a **fume hood** with volatile/toxic compounds
    3. Know the location of **fire extinguisher** and **safety shower**
    4. Never taste or directly smell chemicals
    5. Dispose of chemical waste properly

    ---

    ## 2. Crystallization and Recrystallization

    ### Principle
    - **Solubility difference:** Most substances are more soluble in hot solvent than cold
    - **Impurities:** Either remain dissolved or don't dissolve at all

    ### Procedure
    1. **Dissolve:** Impure solid in minimum hot solvent
    2. **Filter hot:** Remove insoluble impurities
    3. **Cool slowly:** Pure crystals form
    4. **Filter cold:** Collect crystals (impurities stay in solution)
    5. **Wash:** With cold solvent
    6. **Dry:** Remove residual solvent

    ### Choice of Solvent
    **Ideal solvent should:**
    - Dissolve large amount of substance when hot
    - Dissolve very little when cold
    - Not react with the substance
    - Have low boiling point (easy to remove)
    - Be non-toxic and non-flammable (preferred)

    **Common solvents:**
    - Water, ethanol, methanol
    - Acetone, diethyl ether
    - Petroleum ether, benzene, toluene

    ### Example
    **Purification of benzoic acid:**
    - Soluble in hot water, insoluble in cold water
    - Dissolve in hot water → Cool → Crystals form
    - Filter, wash with cold water, dry

    ---

    ## 3. Distillation

    ### A. Simple Distillation

    **Principle:** Separation based on **boiling point difference** (>25°C)

    **Setup:**
    ```
    Thermometer
        |
    [Round-bottom flask with liquid]
        ↓ heat
    [Condenser with cold water]
        ↓
    [Receiving flask]
    ```

    **Applications:**
    - Purifying liquids
    - Separating liquid from non-volatile impurities
    - Example: Purifying ethanol from water-ethanol mixture (not efficient for close bp)

    ### B. Fractional Distillation

    **Principle:** Separation of liquids with **close boiling points** (<25°C)

    **Setup:** Same as simple distillation but with **fractionating column** (packed with glass beads or steel wool)

    **How it works:**
    - Multiple vaporization-condensation cycles
    - Lower bp component concentrates at top
    - Higher bp component returns to flask

    **Applications:**
    - Petroleum refining
    - Separating ethanol (78°C) from water (100°C)
    - Separating benzene (80°C) from toluene (111°C)

    ### C. Steam Distillation

    **Principle:** Used for **heat-sensitive, water-immiscible** organic compounds

    **Key point:**
    - Mixture boils when sum of vapor pressures = atmospheric pressure
    - Boiling point < 100°C (both components' bp)

    **Setup:**
    ```
    [Steam generator] → [Flask with organic compound + water] → [Condenser] → [Receiver]
    ```

    **Applications:**
    - Extracting essential oils (aniline, nitrobenzene)
    - Purifying natural products
    - Example: Isolating aniline (bp 184°C) at ~98°C

    **Advantages:**
    - Compounds distill below their boiling points
    - Prevents decomposition of heat-sensitive compounds

    ---

    ## 4. Sublimation

    ### Principle
    **Sublimation:** Direct conversion from solid → gas without passing through liquid phase.

    ### Procedure
    1. Place crude solid in sublimation apparatus
    2. Heat gently
    3. Pure substance sublimes and condenses on cold surface
    4. Impurities remain behind (if non-volatile)

    ### Compounds that Sublime
    - **Organic:** Benzoic acid, camphor, naphthalene, anthracene
    - **Inorganic:** Iodine, ammonium chloride, dry ice (CO₂)

    ### Applications
    - Purifying solids that sublime readily
    - Separating from non-volatile impurities

    ---

    ## 5. Chromatography

    ### Principle
    **Separation** based on differential migration of components between:
    - **Stationary phase:** Fixed (solid or liquid)
    - **Mobile phase:** Moving (liquid or gas)

    ### A. Thin Layer Chromatography (TLC)

    **Stationary phase:** Thin layer of silica gel or alumina on glass/plastic plate

    **Mobile phase:** Liquid solvent

    **Procedure:**
    1. Spot sample near bottom of TLC plate
    2. Place plate in chamber with solvent (below spot level)
    3. Solvent rises by capillary action
    4. Components separate based on polarity
    5. Visualize spots (UV light or iodine vapor)

    **Rf value (Retention factor):**
    ```
    Rf = Distance traveled by compound / Distance traveled by solvent

    0 < Rf < 1
    ```

    **Applications:**
    - Checking purity
    - Monitoring reactions
    - Identifying compounds

    **Interpretation:**
    - More polar compound → Lower Rf (sticks to polar silica)
    - Less polar compound → Higher Rf (moves with solvent)

    ### B. Column Chromatography

    **Stationary phase:** Silica gel or alumina packed in column

    **Mobile phase:** Liquid solvent (eluting solvent)

    **Procedure:**
    1. Pack column with adsorbent (silica gel)
    2. Load sample mixture at top
    3. Elute with solvent
    4. Less polar compounds elute first
    5. Collect fractions, analyze

    **Applications:**
    - Separating mixtures
    - Purifying compounds
    - Large-scale separations

    ---

    ## 6. Extraction and Washing

    ### Liquid-Liquid Extraction

    **Principle:** Transfer of solute from one solvent to another (immiscible solvents)

    **Based on:** **Distribution law** (partition coefficient)
    ```
    K = Concentration in solvent A / Concentration in solvent B
    ```

    **Setup:**
    - **Separatory funnel**
    - Two immiscible solvents (e.g., water and ether)

    **Procedure:**
    1. Add mixture to separatory funnel with two solvents
    2. Shake vigorously (vent periodically)
    3. Let layers separate
    4. Drain lower layer
    5. Collect upper layer

    **Applications:**
    - Isolating organic products from aqueous solutions
    - Removing impurities

    ### Acid-Base Extraction

    **Principle:** Use acid/base to convert organic compound to ionic form (water-soluble)

    **Example: Separating carboxylic acid, phenol, and neutral compound**

    ```
    Mixture in ether
        ↓ Extract with NaOH (base)
    [Aqueous layer: RCOO⁻ + phenolate]  [Ether layer: neutral compound]
        ↓ Acidify
    RCOOH + Phenol (precipitate)

    Further separate phenol using NaHCO₃ (weaker base)
    - RCOOH reacts with NaHCO₃ → RCOONa (water-soluble)
    - Phenol does NOT react (too weak acid)
    ```

    **Key reactions:**
    - RCOOH + NaOH → RCOONa (soluble)
    - ArOH + NaOH → ArONa (soluble)
    - RCOOH + NaHCO₃ → RCOONa + H₂O + CO₂

    ---

    ## 7. Drying Agents

    ### Purpose
    Remove traces of water from organic solvents or solutions

    ### Common Drying Agents

    | Drying Agent | Use | Advantages | Disadvantages |
    |--------------|-----|------------|---------------|
    | **Anhydrous Na₂SO₄** | General purpose | Neutral, mild | Slow, low capacity |
    | **Anhydrous MgSO₄** | General purpose | Fast, high capacity | Slightly acidic |
    | **Anhydrous CaCl₂** | Hydrocarbons, ethers | Fast, cheap | Reacts with alcohols, amines |
    | **Anhydrous K₂CO₃** | Esters, ketones | Basic (removes acids) | Cannot use with acidic compounds |
    | **Molecular sieves** | All solvents | Very efficient | Expensive |

    ### Procedure
    1. Add drying agent to wet organic solution
    2. Swirl/stir for 5-10 minutes
    3. Filter off drying agent
    4. Solvent is now anhydrous

    ---

    ## 8. Determination of Melting Point

    ### Importance
    - **Identification:** Pure compounds have sharp melting points
    - **Purity:** Impurities lower and broaden melting point

    ### Procedure
    1. Pack powdered sample in capillary tube
    2. Heat slowly in melting point apparatus
    3. Note temperature when melting starts and when complete

    ### Interpretation
    - **Sharp mp (1-2°C range):** Pure compound
    - **Broad mp (>5°C range):** Impure
    - **Lower than expected:** Impurities present

    ### Mixed Melting Point
    - Mix unknown with known compound
    - If mp doesn't change → Same compound
    - If mp decreases/broadens → Different compounds

    ---

    ## 9. Determination of Boiling Point

    ### Importance
    - Identification of liquid compounds
    - Purity check

    ### Simple Method
    1. Heat liquid in small flask with thermometer
    2. Note temperature when boiling (constant temperature)

    ### Micro Method (Siwoloboff Method)
    - Use capillary tube inverted in liquid
    - When bubbles stream rapidly → boiling point

    ### Interpretation
    - **Constant bp:** Pure liquid
    - **Range of bp:** Mixture

    ---

    ## Important Points for IIT JEE

    1. **Crystallization:**
       - Compound should be soluble in hot solvent, insoluble in cold
       - Impurities remain in solution (mother liquor)

    2. **Distillation types:**
       - Simple: bp difference >25°C
       - Fractional: bp difference <25°C
       - Steam: Heat-sensitive, water-immiscible compounds

    3. **Sublimation examples:**
       - Benzoic acid, naphthalene, camphor, iodine

    4. **TLC Rf values:**
       - Polar compounds: Low Rf (stick to silica)
       - Non-polar compounds: High Rf (move with solvent)

    5. **Acid-base extraction:**
       - Strong acid (RCOOH): Reacts with NaHCO₃ and NaOH
       - Weak acid (ArOH): Reacts only with NaOH
       - Use to separate mixtures

    ---

    ## Practice Questions

    1. What solvent would you choose to recrystallize benzoic acid? Why?
    2. Explain why steam distillation is used for isolating aniline.
    3. Calculate Rf if a compound travels 4.5 cm and solvent travels 6.0 cm.
    4. How would you separate a mixture of benzoic acid, phenol, and toluene using extraction?
    5. What drying agent would you use for drying ethanol? Why not CaCl₂?

## Key Points

- Crystallization and recrystallization

- Distillation (simple, fractional, steam)

- Sublimation
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Crystallization and recrystallization', 'Distillation (simple, fractional, steam)', 'Sublimation', 'Chromatography (TLC, column)', 'Extraction and washing', 'Drying agents'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Qualitative Analysis - Detection Tests for Elements and Functional Groups ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Qualitative Analysis - Detection Tests for Elements and Functional Groups',
  content: <<~MARKDOWN,
# Qualitative Analysis - Detection Tests for Elements and Functional Groups 🚀

# Qualitative Analysis of Organic Compounds

    ## 1. Introduction

    ### Purpose of Qualitative Analysis
    1. **Element detection:** C, H, O, N, S, halogens
    2. **Functional group identification:** -OH, -CHO, -COOH, -NH₂, etc.
    3. **Structure determination:** Combining with other data

    ### Systematic Approach
    1. Physical examination (color, odor, state)
    2. Detection of elements
    3. Functional group tests
    4. Confirmatory tests

    ---

    ## 2. Detection of Carbon and Hydrogen

    ### Test: Combustion Test

    **Procedure:**
    - Heat organic compound with copper(II) oxide (CuO)
    - Organic compound oxidized to CO₂ and H₂O

    **Reactions:**
    ```
    C (in compound) + 2CuO → CO₂ + 2Cu
    2H (in compound) + CuO → H₂O + Cu
    ```

    **Observations:**
    - **Carbon:** CO₂ turns lime water milky
      ```
      Ca(OH)₂ + CO₂ → CaCO₃ (white ppt) + H₂O
      ```

    - **Hydrogen:** H₂O condenses on cool surface or turns anhydrous CuSO₄ blue
      ```
      CuSO₄ (white) + 5H₂O → CuSO₄·5H₂O (blue)
      ```

    ---

    ## 3. Detection of Nitrogen, Sulfur, and Halogens

    ### Lassaigne's Test (Sodium Fusion Test)

    **Principle:** Convert covalent organic compounds to ionic forms (water-soluble)

    **Procedure:**
    1. Fuse organic compound with metallic sodium
    2. Extract with water (sodium fusion extract - SFE)
    3. Perform specific tests on SFE

    **Key reactions during fusion:**
    ```
    Nitrogen: C, H, N + Na → NaCN (sodium cyanide)
    Sulfur: S + 2Na → Na₂S (sodium sulfide)
    Halogens: C, H, X + Na → NaX (sodium halide)
    ```

    ### A. Test for Nitrogen (Prussian Blue Test)

    **Procedure:**
    1. Boil SFE with FeSO₄ (iron(II) sulfate)
    2. Add few drops H₂SO₄
    3. Heat and cool

    **Reactions:**
    ```
    6NaCN + FeSO₄ → Na₄[Fe(CN)₆] (sodium ferrocyanide) + Na₂SO₄

    3Na₄[Fe(CN)₆] + 4FeSO₄ → Fe₄[Fe(CN)₆]₃ (Prussian blue) + 6Na₂SO₄
    ```

    **Observation:**
    - **Prussian blue/green precipitate** → Nitrogen present

    ### B. Test for Sulfur

    **Procedure:**
    1. Acidify SFE with acetic acid
    2. Add lead acetate solution

    **Reaction:**
    ```
    Na₂S + (CH₃COO)₂Pb → PbS (black ppt) + 2CH₃COONa
    ```

    **Observation:**
    - **Black precipitate** → Sulfur present

    **Alternative Test (Sodium Nitroprusside Test):**
    ```
    Na₂S + Na₂[Fe(CN)₅NO] → Purple/violet color
    ```

    ### C. Test for Halogens

    **Procedure:**
    1. Acidify SFE with HNO₃
    2. Add AgNO₃ solution

    **Reactions:**
    ```
    NaCl + AgNO₃ → AgCl (white ppt) + NaNO₃
    NaBr + AgNO₃ → AgBr (pale yellow ppt) + NaNO₃
    NaI + AgNO₃ → AgI (yellow ppt) + NaNO₃
    ```

    **Observations:**
    - **White ppt:** Chlorine
    - **Pale yellow ppt:** Bromine
    - **Yellow ppt:** Iodine

    **Note:** If N and S are present with halogens, they must be removed first (interfere with test):
    ```
    NaCN + AgNO₃ → AgCN (white) - interferes
    Na₂S + AgNO₃ → Ag₂S (black) - interferes
    ```

    ---

    ## 4. Detection of Oxygen

    ### No Direct Test
    - Oxygen is detected by **difference**
    - If elements add up to <100% → Oxygen likely present
    - Oxygen presence inferred from functional group tests

    ---

    ## 5. Functional Group Tests - Alcohols and Phenols

    ### A. Test for Alcohols

    #### 1. Ester Test (Acetylation)
    **Reagent:** Acetic anhydride or acetyl chloride

    **Reaction:**
    ```
    R-OH + (CH₃CO)₂O → R-O-CO-CH₃ (ester) + CH₃COOH
    ```

    **Observation:**
    - **Fruity smell** of ester

    #### 2. Lucas Test (Distinguish 1°, 2°, 3° alcohols)
    **Reagent:** Lucas reagent (ZnCl₂ in conc. HCl)

    **Principle:** 3° > 2° > 1° reactivity toward SN1

    **Observations:**
    - **Tertiary (3°):** Turbidity appears **immediately**
    - **Secondary (2°):** Turbidity after **5-10 minutes**
    - **Primary (1°):** **No turbidity** at room temperature

    **Reaction:**
    ```
    R-OH + HCl → R-Cl (insoluble, turbid) + H₂O
    ```

    #### 3. Oxidation Test (Victor Meyer Test)
    **Reagent:** K₂Cr₂O₇ + H₂SO₄ (or KMnO₄)

    **Observations:**
    - **Primary alcohol:** Oxidized to aldehyde, then carboxylic acid (orange to green)
    - **Secondary alcohol:** Oxidized to ketone (orange to green)
    - **Tertiary alcohol:** **No oxidation** (orange color persists)

    ### B. Test for Phenols

    #### 1. Ferric Chloride Test
    **Reagent:** Neutral FeCl₃ solution

    **Reaction:**
    ```
    3ArOH + FeCl₃ → [Fe(OAr)₃] (colored complex) + 3HCl
    ```

    **Observation:**
    - **Violet, blue, green, or red color** → Phenol present
    - Most common: Violet color for simple phenols

    #### 2. Bromine Water Test
    **Reagent:** Bromine water (Br₂/H₂O)

    **Reaction:**
    ```
    C₆H₅OH + 3Br₂ → 2,4,6-Tribromophenol (white ppt) + 3HBr
    ```

    **Observation:**
    - **White precipitate** → Phenol present
    - Decolorization of bromine water

    #### 3. Libermann's Nitroso Test
    **Reagent:** NaNO₂ + conc. H₂SO₄

    **Observation:**
    - **Deep blue/green color** → Phenol present

    ---

    ## 6. Functional Group Tests - Aldehydes and Ketones

    ### Tests for Carbonyl Group (C=O)

    #### 1. 2,4-DNP Test (2,4-Dinitrophenylhydrazine)
    **Reagent:** 2,4-dinitrophenylhydrazine in acidic solution

    **Reaction:**
    ```
    R-CHO + H₂N-NH-C₆H₃(NO₂)₂ → R-CH=N-NH-C₆H₃(NO₂)₂ (yellow/orange ppt)
    ```

    **Observation:**
    - **Yellow/orange precipitate** → Aldehyde or ketone present

    **Note:** Both aldehydes and ketones give this test (not specific)

    ### Tests Specific for Aldehydes

    #### 2. Tollens' Test (Silver Mirror Test)
    **Reagent:** Tollens' reagent [Ag(NH₃)₂]⁺ (ammoniacal AgNO₃)

    **Reaction:**
    ```
    R-CHO + 2[Ag(NH₃)₂]⁺ + 3OH⁻ → R-COO⁻ + 2Ag (silver mirror) + 4NH₃ + 2H₂O
    ```

    **Observation:**
    - **Silver mirror** on inner surface of test tube → Aldehyde present

    **Note:**
    - **Aldehydes:** Positive (reducing agents)
    - **Ketones:** Negative (not reducing)
    - Aromatic aldehydes (benzaldehyde) may give positive test but slowly

    #### 3. Fehling's Test
    **Reagent:** Fehling's solution (Cu²⁺ in alkaline tartrate)

    **Reaction:**
    ```
    R-CHO + 2Cu²⁺ + 5OH⁻ → R-COO⁻ + Cu₂O (red ppt) + 3H₂O
    ```

    **Observation:**
    - **Red precipitate (Cu₂O)** → Aliphatic aldehyde present

    **Note:**
    - **Aliphatic aldehydes:** Positive
    - **Aromatic aldehydes:** Negative
    - **Ketones:** Negative

    #### 4. Schiff's Test
    **Reagent:** Schiff's reagent (decolorized fuchsin)

    **Observation:**
    - **Pink/magenta color** → Aldehyde present
    - **Ketones:** No color change

    ### Test for Methyl Ketones

    #### Iodoform Test
    **Reagent:** I₂ + NaOH (or KI/I₂ + NaOH)

    **Reaction:**
    ```
    CH₃-CO-R + 3I₂ + 4NaOH → CHI₃ (iodoform, yellow ppt) + R-COONa + 3NaI + 3H₂O
    ```

    **Observation:**
    - **Yellow precipitate of iodoform** (characteristic smell)

    **Positive test:**
    - Methyl ketones: CH₃-CO-R
    - Ethanol: CH₃-CH₂-OH (oxidized to CH₃-CHO, then gives test)
    - Secondary alcohols with CH₃-CHOH-R structure

    ---

    ## 7. Functional Group Tests - Carboxylic Acids

    ### 1. Litmus Test
    **Observation:**
    - **Turns blue litmus red** → Acidic compound (carboxylic acid)

    ### 2. Sodium Bicarbonate Test
    **Reagent:** NaHCO₃ solution

    **Reaction:**
    ```
    R-COOH + NaHCO₃ → R-COONa + H₂O + CO₂ (effervescence)
    ```

    **Observation:**
    - **Brisk effervescence** → Carboxylic acid present
    - CO₂ turns lime water milky

    **Note:** This test distinguishes RCOOH from phenols (phenols don't react with NaHCO₃)

    ### 3. Ester Test
    **Reagent:** Ethanol + conc. H₂SO₄ (heat)

    **Reaction:**
    ```
    R-COOH + C₂H₅OH → R-COO-C₂H₅ (ester, fruity smell) + H₂O
    ```

    **Observation:**
    - **Fruity smell** → Carboxylic acid present

    ---

    ## 8. Functional Group Tests - Amines

    ### 1. Carbylamine Test (Isocyanide Test)
    **Reagent:** CHCl₃ + alcoholic KOH (heat)

    **Reaction:**
    ```
    R-NH₂ + CHCl₃ + 3KOH → R-N≡C (isocyanide, foul smell) + 3KCl + 3H₂O
    ```

    **Observation:**
    - **Offensive/foul smell** → Primary amine present

    **Note:** Only **primary amines** give this test (2° and 3° amines do NOT)

    ### 2. Hinsberg's Test (Distinguish 1°, 2°, 3° amines)
    **Reagent:** Benzenesulfonyl chloride (C₆H₅SO₂Cl) + KOH

    **Reactions:**

    **Primary amine:**
    ```
    R-NH₂ + C₆H₅SO₂Cl + KOH → C₆H₅SO₂-NH-R (soluble in KOH) + KCl + H₂O
    ```
    **Observation:** Soluble in base (clear solution)

    **Secondary amine:**
    ```
    R₂NH + C₆H₅SO₂Cl → C₆H₅SO₂-NR₂ (insoluble in KOH) + HCl
    ```
    **Observation:** Insoluble in base (oily layer or precipitate)

    **Tertiary amine:**
    ```
    R₃N + C₆H₅SO₂Cl → No reaction
    ```
    **Observation:** Remains as separate layer (unreacted)

    **Summary:**
    - **1° amine:** Soluble in KOH (can donate H⁺)
    - **2° amine:** Insoluble in KOH (no H to donate)
    - **3° amine:** No reaction (no H on N)

    ### 3. Azo Dye Test (for Aromatic Amines)
    **Reagent:** NaNO₂ + HCl (0-5°C), then β-naphthol

    **Reactions:**
    ```
    Step 1: Ar-NH₂ + NaNO₂ + 2HCl → Ar-N₂⁺Cl⁻ (diazonium salt) + NaCl + 2H₂O
    Step 2: Ar-N₂⁺Cl⁻ + β-naphthol → Ar-N=N-naphthol (orange-red dye)
    ```

    **Observation:**
    - **Orange-red dye** → Aromatic primary amine present

    ---

    ## 9. Summary Table - Functional Group Tests

    | Functional Group | Test | Reagent | Positive Result |
    |------------------|------|---------|-----------------|
    | **Alcohol** | Lucas test | ZnCl₂/HCl | Turbidity (3°>2°>1°) |
    | **Phenol** | FeCl₃ test | FeCl₃ | Violet/blue/green color |
    | **Phenol** | Bromine water | Br₂/H₂O | White ppt |
    | **Aldehyde** | Tollens' test | [Ag(NH₃)₂]⁺ | Silver mirror |
    | **Aldehyde** | Fehling's test | Cu²⁺/alkaline | Red ppt (Cu₂O) |
    | **Aldehyde/Ketone** | 2,4-DNP | 2,4-DNP | Yellow/orange ppt |
    | **Methyl ketone** | Iodoform | I₂/NaOH | Yellow ppt (CHI₃) |
    | **Carboxylic acid** | NaHCO₃ | NaHCO₃ | Effervescence (CO₂) |
    | **Primary amine** | Carbylamine | CHCl₃/KOH | Foul smell |
    | **Amines (1°/2°/3°)** | Hinsberg | C₆H₅SO₂Cl/KOH | Soluble/insoluble/no rxn |

    ---

    ## Important Points for IIT JEE

    1. **Lassaigne's test:**
       - Converts covalent to ionic (water-soluble)
       - N → NaCN (Prussian blue with Fe²⁺)
       - S → Na₂S (black PbS with lead acetate)
       - X → NaX (ppt with AgNO₃)

    2. **Distinction tests:**
       - Aldehyde vs ketone: Tollens' or Fehling's
       - 1°, 2°, 3° alcohols: Lucas test
       - 1°, 2°, 3° amines: Hinsberg test
       - RCOOH vs ArOH: NaHCO₃ test

    3. **Color tests:**
       - Phenol + FeCl₃ → Violet
       - Aldehyde + Tollens' → Silver mirror
       - Aldehyde + Fehling's → Red ppt
       - Methyl ketone + I₂/NaOH → Yellow ppt

    4. **Specific tests:**
       - Only primary amines: Carbylamine test
       - Only aldehydes: Tollens' and Fehling's
       - Only carboxylic acids: NaHCO₃ (effervescence)

    ---

    ## Practice Questions

    1. How would you distinguish between ethanal and propanone using a chemical test?
    2. An organic compound gives a silver mirror with Tollens' reagent. What functional group is present?
    3. Explain how Hinsberg's test distinguishes between 1°, 2°, and 3° amines.
    4. A compound gives a violet color with FeCl₃. Which functional group is present?
    5. How would you test for the presence of nitrogen in an organic compound?

## Key Points

- Detection of C, H, O, N, S, halogens

- Lassaigne\

- ,
    
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Detection of C, H, O, N, S, halogens', 'Lassaigne\', ',
    ', ',
    ', ',
    ', ',
    '],
  prerequisite_ids: []
)

# === MICROLESSON 5: Which purification technique is based on differences in boiling points of liquids? ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which purification technique is based on differences in boiling points of liquids?',
  content: <<~MARKDOWN,
# Which purification technique is based on differences in boiling points of liquids? 🚀

Distillation separates liquids based on differences in their boiling points. Simple distillation is used when bp difference >25°C, fractional distillation when <25°C.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which purification technique is based on differences in boiling points of liquids?',
    options: ['Crystallization', 'Distillation', 'Sublimation', 'Chromatography'],
    correct_answer: 1,
    explanation: 'Distillation separates liquids based on differences in their boiling points. Simple distillation is used when bp difference >25°C, fractional distillation when <25°C.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: Steam distillation is particularly useful for: ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Steam distillation is particularly useful for:',
  content: <<~MARKDOWN,
# Steam distillation is particularly useful for: 🚀

Steam distillation is used for heat-sensitive, water-immiscible organic compounds. It allows distillation below the normal boiling point of the compound, preventing decomposition. Example: aniline.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Steam distillation is particularly useful for:',
    options: ['Separating miscible liquids', 'Purifying heat-sensitive, water-immiscible compounds', 'Separating solids from liquids', 'Removing dissolved gases'],
    correct_answer: 1,
    explanation: 'Steam distillation is used for heat-sensitive, water-immiscible organic compounds. It allows distillation below the normal boiling point of the compound, preventing decomposition. Example: aniline.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 7: Which of the following compounds can be purified by sublimation? ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following compounds can be purified by sublimation?',
  content: <<~MARKDOWN,
# Which of the following compounds can be purified by sublimation? 🚀

Compounds that sublime (solid→gas directly) include: benzoic acid, naphthalene, camphor, anthracene, and iodine. NaCl has very high melting point and does not sublime readily.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following compounds can be purified by sublimation?',
    options: ['Benzoic acid', 'Naphthalene', 'Sodium chloride', 'Camphor'],
    correct_answer: 3,
    explanation: 'Compounds that sublime (solid→gas directly) include: benzoic acid, naphthalene, camphor, anthracene, and iodine. NaCl has very high melting point and does not sublime readily.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 8: In a TLC experiment, a compound travels 3.6 cm and the solvent front travels 9.0 cm. Calculate the Rf value. ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'In a TLC experiment, a compound travels 3.6 cm and the solvent front travels 9.0 cm. Calculate the Rf value.',
  content: <<~MARKDOWN,
# In a TLC experiment, a compound travels 3.6 cm and the solvent front travels 9.0 cm. Calculate the Rf value. 🚀

Rf = Distance traveled by compound / Distance traveled by solvent = 3.6 / 9.0 = 0.4. Rf values always range from 0 to 1.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In a TLC experiment, a compound travels 3.6 cm and the solvent front travels 9.0 cm. Calculate the Rf value.',
    answer: '0.4',
    explanation: 'Rf = Distance traveled by compound / Distance traveled by solvent = 3.6 / 9.0 = 0.4. Rf values always range from 0 to 1.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: In TLC, a compound with high Rf value indicates that it is: ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'In TLC, a compound with high Rf value indicates that it is:',
  content: <<~MARKDOWN,
# In TLC, a compound with high Rf value indicates that it is: 🚀

High Rf means the compound moves far with the solvent, indicating it is less polar (weak interaction with polar silica gel). Polar compounds have low Rf as they stick to the stationary phase.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In TLC, a compound with high Rf value indicates that it is:',
    options: ['Very polar', 'Less polar', 'Ionic', 'Insoluble'],
    correct_answer: 1,
    explanation: 'High Rf means the compound moves far with the solvent, indicating it is less polar (weak interaction with polar silica gel). Polar compounds have low Rf as they stick to the stationary phase.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 10: Which reagent can be used to distinguish between benzoic acid and phenol using extraction? ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which reagent can be used to distinguish between benzoic acid and phenol using extraction?',
  content: <<~MARKDOWN,
# Which reagent can be used to distinguish between benzoic acid and phenol using extraction? 🚀

NaHCO₃ (weak base) reacts with stronger acids like benzoic acid (RCOOH) but NOT with weaker acids like phenol (ArOH). Benzoic acid dissolves in aqueous NaHCO₃ layer, phenol stays in organic layer.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which reagent can be used to distinguish between benzoic acid and phenol using extraction?',
    options: ['H₂O', 'NaHCO₃', 'HCl', 'Ether'],
    correct_answer: 1,
    explanation: 'NaHCO₃ (weak base) reacts with stronger acids like benzoic acid (RCOOH) but NOT with weaker acids like phenol (ArOH). Benzoic acid dissolves in aqueous NaHCO₃ layer, phenol stays in organic layer.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 11: Which drying agent should NOT be used for drying alcohols? ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which drying agent should NOT be used for drying alcohols?',
  content: <<~MARKDOWN,
# Which drying agent should NOT be used for drying alcohols? 🚀

CaCl₂ reacts with alcohols and amines forming complexes, so it should not be used. Na₂SO₄ or MgSO₄ are suitable for drying alcohols as they are neutral and unreactive.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which drying agent should NOT be used for drying alcohols?',
    options: ['Na₂SO₄', 'MgSO₄', 'CaCl₂', 'K₂CO₃'],
    correct_answer: 2,
    explanation: 'CaCl₂ reacts with alcohols and amines forming complexes, so it should not be used. Na₂SO₄ or MgSO₄ are suitable for drying alcohols as they are neutral and unreactive.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 12: A pure organic compound typically shows: ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'A pure organic compound typically shows:',
  content: <<~MARKDOWN,
# A pure organic compound typically shows: 🚀

A pure organic compound has a sharp melting point (1-2°C range). Impurities cause the melting point to be lower and broader (depression and broadening of mp).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'A pure organic compound typically shows:',
    options: ['A broad melting point range (>10°C)', 'A sharp melting point (1-2°C range)', 'No definite melting point', 'Multiple melting points'],
    correct_answer: 1,
    explanation: 'A pure organic compound has a sharp melting point (1-2°C range). Impurities cause the melting point to be lower and broader (depression and broadening of mp).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: Fractional distillation is more efficient than simple distillation for separating liquids with close boiling points. ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Fractional distillation is more efficient than simple distillation for separating liquids with close boiling points.',
  content: <<~MARKDOWN,
# Fractional distillation is more efficient than simple distillation for separating liquids with close boiling points. 🚀

TRUE. Fractional distillation uses a fractionating column that provides multiple vaporization-condensation cycles, making it much more efficient for separating liquids with boiling points differing by <25°C.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Fractional distillation is more efficient than simple distillation for separating liquids with close boiling points.',
    answer: '',
    explanation: 'TRUE. Fractional distillation uses a fractionating column that provides multiple vaporization-condensation cycles, making it much more efficient for separating liquids with boiling points differing by <25°C.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: In Lassaigne\ ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'In Lassaigne\',
  content: <<~MARKDOWN,
# In Lassaigne\ 🚀

Nitrogen is detected by forming Prussian blue (Fe₄[Fe(CN)₆]₃) when sodium fusion extract is treated with FeSO₄ and H₂SO₄. The nitrogen converts to NaCN during fusion.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In Lassaigne\',
    options: ['Formation of white precipitate with AgNO₃', 'Formation of Prussian blue precipitate with FeSO₄', 'Formation of black precipitate with lead acetate', 'Effervescence with NaHCO₃'],
    correct_answer: 1,
    explanation: 'Nitrogen is detected by forming Prussian blue (Fe₄[Fe(CN)₆]₃) when sodium fusion extract is treated with FeSO₄ and H₂SO₄. The nitrogen converts to NaCN during fusion.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 15: Which test gives a silver mirror with aldehydes? ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which test gives a silver mirror with aldehydes?',
  content: <<~MARKDOWN,
# Which test gives a silver mirror with aldehydes? 🚀

Tollens\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which test gives a silver mirror with aldehydes?',
    options: ['Iodoform test', '2,4-DNP test'],
    correct_answer: 0,
    explanation: 'Tollens\',
    difficulty: 'easy'
  }
)

# === MICROLESSON 16: The Lucas test is used to distinguish between: ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'The Lucas test is used to distinguish between:',
  content: <<~MARKDOWN,
# The Lucas test is used to distinguish between: 🚀

Lucas test (ZnCl₂ in HCl) distinguishes alcohols based on reactivity: Tertiary (immediate turbidity) > Secondary (5-10 min) > Primary (no reaction). Based on SN1 mechanism.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 16.2: MCQ
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The Lucas test is used to distinguish between:',
    options: ['Aldehydes and ketones', 'Primary, secondary, and tertiary alcohols', 'Phenols and alcohols', 'Carboxylic acids and esters'],
    correct_answer: 1,
    explanation: 'Lucas test (ZnCl₂ in HCl) distinguishes alcohols based on reactivity: Tertiary (immediate turbidity) > Secondary (5-10 min) > Primary (no reaction). Based on SN1 mechanism.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 17: Which of the following compounds will give a positive iodoform test? ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following compounds will give a positive iodoform test?',
  content: <<~MARKDOWN,
# Which of the following compounds will give a positive iodoform test? 🚀

Iodoform test is positive for: (1) Methyl ketones (CH₃-CO-R), (2) Ethanol (oxidizes to acetaldehyde), (3) Acetaldehyde. Propanone is a methyl ketone so it gives positive test.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 17.2: MCQ
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following compounds will give a positive iodoform test?',
    options: ['Acetone (CH₃-CO-CH₃)', 'Ethanol (CH₃-CH₂-OH)', 'Propanone (CH₃-CO-CH₂-CH₃)', 'Acetaldehyde (CH₃-CHO)'],
    correct_answer: 3,
    explanation: 'Iodoform test is positive for: (1) Methyl ketones (CH₃-CO-R), (2) Ethanol (oxidizes to acetaldehyde), (3) Acetaldehyde. Propanone is a methyl ketone so it gives positive test.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 18: Phenol reacts with neutral FeCl₃ to give: ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Phenol reacts with neutral FeCl₃ to give:',
  content: <<~MARKDOWN,
# Phenol reacts with neutral FeCl₃ to give: 🚀

Phenol forms a colored complex [Fe(OAr)₃] with FeCl₃, giving violet, blue, or green color depending on the phenol. This is a characteristic test for phenolic compounds.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 18.2: MCQ
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Phenol reacts with neutral FeCl₃ to give:',
    options: ['Red precipitate', 'Violet/blue/green color', 'Silver mirror', 'Yellow precipitate'],
    correct_answer: 1,
    explanation: 'Phenol forms a colored complex [Fe(OAr)₃] with FeCl₃, giving violet, blue, or green color depending on the phenol. This is a characteristic test for phenolic compounds.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 19: Which test can distinguish between a carboxylic acid and a phenol? ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which test can distinguish between a carboxylic acid and a phenol?',
  content: <<~MARKDOWN,
# Which test can distinguish between a carboxylic acid and a phenol? 🚀

NaHCO₃ reacts only with carboxylic acids (stronger acids) producing CO₂ effervescence. Phenols (weaker acids) do NOT react with NaHCO₃ but react with NaOH.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 19.2: MCQ
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which test can distinguish between a carboxylic acid and a phenol?',
    options: ['FeCl₃ test', 'NaOH test', 'NaHCO₃ test', 'Bromine water test'],
    correct_answer: 2,
    explanation: 'NaHCO₃ reacts only with carboxylic acids (stronger acids) producing CO₂ effervescence. Phenols (weaker acids) do NOT react with NaHCO₃ but react with NaOH.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 20: In Hinsberg\ ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'In Hinsberg\',
  content: <<~MARKDOWN,
# In Hinsberg\ 🚀

Primary amine reacts with benzenesulfonyl chloride to form C₆H₅SO₂-NH-R, which has an acidic H and is soluble in KOH. Secondary amines give insoluble products. Tertiary amines don\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 20.2: MCQ
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In Hinsberg\',
    options: ['Insoluble in KOH', 'Soluble in KOH', 'Does not react', 'Forms a colored complex'],
    correct_answer: 1,
    explanation: 'Primary amine reacts with benzenesulfonyl chloride to form C₆H₅SO₂-NH-R, which has an acidic H and is soluble in KOH. Secondary amines give insoluble products. Tertiary amines don\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 21: The carbylamine test is specific for: ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'The carbylamine test is specific for:',
  content: <<~MARKDOWN,
# The carbylamine test is specific for: 🚀

Carbylamine test (CHCl₃ + KOH) produces isocyanide with a foul smell ONLY with primary amines. Secondary and tertiary amines do not give this test.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 21.2: MCQ
Exercise.create!(
  micro_lesson: lesson_21,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The carbylamine test is specific for:',
    options: ['All amines', 'Primary amines only', 'Secondary amines only', 'Tertiary amines only'],
    correct_answer: 1,
    explanation: 'Carbylamine test (CHCl₃ + KOH) produces isocyanide with a foul smell ONLY with primary amines. Secondary and tertiary amines do not give this test.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 22: Fehling\ ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'Fehling\',
  content: <<~MARKDOWN,
# Fehling\ 🚀

Fehling\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 22.2: MCQ
Exercise.create!(
  micro_lesson: lesson_22,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Fehling\',
    options: ['All aldehydes and ketones', 'Aliphatic aldehydes only', 'Aromatic aldehydes only', 'All ketones'],
    correct_answer: 1,
    explanation: 'Fehling\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 23: Basic Laboratory Techniques - Purification and Separation Methods ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'Basic Laboratory Techniques - Purification and Separation Methods',
  content: <<~MARKDOWN,
# Basic Laboratory Techniques - Purification and Separation Methods 🚀

# Basic Laboratory Techniques in Organic Chemistry

    ## 1. Introduction to Practical Organic Chemistry

    ### Importance
    - **Synthesis:** Preparing organic compounds
    - **Purification:** Obtaining pure products
    - **Analysis:** Identifying unknown compounds
    - **Characterization:** Determining structure and properties

    ### Safety Principles
    1. Always wear **safety goggles** and **lab coat**
    2. Work in a **fume hood** with volatile/toxic compounds
    3. Know the location of **fire extinguisher** and **safety shower**
    4. Never taste or directly smell chemicals
    5. Dispose of chemical waste properly

    ---

    ## 2. Crystallization and Recrystallization

    ### Principle
    - **Solubility difference:** Most substances are more soluble in hot solvent than cold
    - **Impurities:** Either remain dissolved or don't dissolve at all

    ### Procedure
    1. **Dissolve:** Impure solid in minimum hot solvent
    2. **Filter hot:** Remove insoluble impurities
    3. **Cool slowly:** Pure crystals form
    4. **Filter cold:** Collect crystals (impurities stay in solution)
    5. **Wash:** With cold solvent
    6. **Dry:** Remove residual solvent

    ### Choice of Solvent
    **Ideal solvent should:**
    - Dissolve large amount of substance when hot
    - Dissolve very little when cold
    - Not react with the substance
    - Have low boiling point (easy to remove)
    - Be non-toxic and non-flammable (preferred)

    **Common solvents:**
    - Water, ethanol, methanol
    - Acetone, diethyl ether
    - Petroleum ether, benzene, toluene

    ### Example
    **Purification of benzoic acid:**
    - Soluble in hot water, insoluble in cold water
    - Dissolve in hot water → Cool → Crystals form
    - Filter, wash with cold water, dry

    ---

    ## 3. Distillation

    ### A. Simple Distillation

    **Principle:** Separation based on **boiling point difference** (>25°C)

    **Setup:**
    ```
    Thermometer
        |
    [Round-bottom flask with liquid]
        ↓ heat
    [Condenser with cold water]
        ↓
    [Receiving flask]
    ```

    **Applications:**
    - Purifying liquids
    - Separating liquid from non-volatile impurities
    - Example: Purifying ethanol from water-ethanol mixture (not efficient for close bp)

    ### B. Fractional Distillation

    **Principle:** Separation of liquids with **close boiling points** (<25°C)

    **Setup:** Same as simple distillation but with **fractionating column** (packed with glass beads or steel wool)

    **How it works:**
    - Multiple vaporization-condensation cycles
    - Lower bp component concentrates at top
    - Higher bp component returns to flask

    **Applications:**
    - Petroleum refining
    - Separating ethanol (78°C) from water (100°C)
    - Separating benzene (80°C) from toluene (111°C)

    ### C. Steam Distillation

    **Principle:** Used for **heat-sensitive, water-immiscible** organic compounds

    **Key point:**
    - Mixture boils when sum of vapor pressures = atmospheric pressure
    - Boiling point < 100°C (both components' bp)

    **Setup:**
    ```
    [Steam generator] → [Flask with organic compound + water] → [Condenser] → [Receiver]
    ```

    **Applications:**
    - Extracting essential oils (aniline, nitrobenzene)
    - Purifying natural products
    - Example: Isolating aniline (bp 184°C) at ~98°C

    **Advantages:**
    - Compounds distill below their boiling points
    - Prevents decomposition of heat-sensitive compounds

    ---

    ## 4. Sublimation

    ### Principle
    **Sublimation:** Direct conversion from solid → gas without passing through liquid phase.

    ### Procedure
    1. Place crude solid in sublimation apparatus
    2. Heat gently
    3. Pure substance sublimes and condenses on cold surface
    4. Impurities remain behind (if non-volatile)

    ### Compounds that Sublime
    - **Organic:** Benzoic acid, camphor, naphthalene, anthracene
    - **Inorganic:** Iodine, ammonium chloride, dry ice (CO₂)

    ### Applications
    - Purifying solids that sublime readily
    - Separating from non-volatile impurities

    ---

    ## 5. Chromatography

    ### Principle
    **Separation** based on differential migration of components between:
    - **Stationary phase:** Fixed (solid or liquid)
    - **Mobile phase:** Moving (liquid or gas)

    ### A. Thin Layer Chromatography (TLC)

    **Stationary phase:** Thin layer of silica gel or alumina on glass/plastic plate

    **Mobile phase:** Liquid solvent

    **Procedure:**
    1. Spot sample near bottom of TLC plate
    2. Place plate in chamber with solvent (below spot level)
    3. Solvent rises by capillary action
    4. Components separate based on polarity
    5. Visualize spots (UV light or iodine vapor)

    **Rf value (Retention factor):**
    ```
    Rf = Distance traveled by compound / Distance traveled by solvent

    0 < Rf < 1
    ```

    **Applications:**
    - Checking purity
    - Monitoring reactions
    - Identifying compounds

    **Interpretation:**
    - More polar compound → Lower Rf (sticks to polar silica)
    - Less polar compound → Higher Rf (moves with solvent)

    ### B. Column Chromatography

    **Stationary phase:** Silica gel or alumina packed in column

    **Mobile phase:** Liquid solvent (eluting solvent)

    **Procedure:**
    1. Pack column with adsorbent (silica gel)
    2. Load sample mixture at top
    3. Elute with solvent
    4. Less polar compounds elute first
    5. Collect fractions, analyze

    **Applications:**
    - Separating mixtures
    - Purifying compounds
    - Large-scale separations

    ---

    ## 6. Extraction and Washing

    ### Liquid-Liquid Extraction

    **Principle:** Transfer of solute from one solvent to another (immiscible solvents)

    **Based on:** **Distribution law** (partition coefficient)
    ```
    K = Concentration in solvent A / Concentration in solvent B
    ```

    **Setup:**
    - **Separatory funnel**
    - Two immiscible solvents (e.g., water and ether)

    **Procedure:**
    1. Add mixture to separatory funnel with two solvents
    2. Shake vigorously (vent periodically)
    3. Let layers separate
    4. Drain lower layer
    5. Collect upper layer

    **Applications:**
    - Isolating organic products from aqueous solutions
    - Removing impurities

    ### Acid-Base Extraction

    **Principle:** Use acid/base to convert organic compound to ionic form (water-soluble)

    **Example: Separating carboxylic acid, phenol, and neutral compound**

    ```
    Mixture in ether
        ↓ Extract with NaOH (base)
    [Aqueous layer: RCOO⁻ + phenolate]  [Ether layer: neutral compound]
        ↓ Acidify
    RCOOH + Phenol (precipitate)

    Further separate phenol using NaHCO₃ (weaker base)
    - RCOOH reacts with NaHCO₃ → RCOONa (water-soluble)
    - Phenol does NOT react (too weak acid)
    ```

    **Key reactions:**
    - RCOOH + NaOH → RCOONa (soluble)
    - ArOH + NaOH → ArONa (soluble)
    - RCOOH + NaHCO₃ → RCOONa + H₂O + CO₂

    ---

    ## 7. Drying Agents

    ### Purpose
    Remove traces of water from organic solvents or solutions

    ### Common Drying Agents

    | Drying Agent | Use | Advantages | Disadvantages |
    |--------------|-----|------------|---------------|
    | **Anhydrous Na₂SO₄** | General purpose | Neutral, mild | Slow, low capacity |
    | **Anhydrous MgSO₄** | General purpose | Fast, high capacity | Slightly acidic |
    | **Anhydrous CaCl₂** | Hydrocarbons, ethers | Fast, cheap | Reacts with alcohols, amines |
    | **Anhydrous K₂CO₃** | Esters, ketones | Basic (removes acids) | Cannot use with acidic compounds |
    | **Molecular sieves** | All solvents | Very efficient | Expensive |

    ### Procedure
    1. Add drying agent to wet organic solution
    2. Swirl/stir for 5-10 minutes
    3. Filter off drying agent
    4. Solvent is now anhydrous

    ---

    ## 8. Determination of Melting Point

    ### Importance
    - **Identification:** Pure compounds have sharp melting points
    - **Purity:** Impurities lower and broaden melting point

    ### Procedure
    1. Pack powdered sample in capillary tube
    2. Heat slowly in melting point apparatus
    3. Note temperature when melting starts and when complete

    ### Interpretation
    - **Sharp mp (1-2°C range):** Pure compound
    - **Broad mp (>5°C range):** Impure
    - **Lower than expected:** Impurities present

    ### Mixed Melting Point
    - Mix unknown with known compound
    - If mp doesn't change → Same compound
    - If mp decreases/broadens → Different compounds

    ---

    ## 9. Determination of Boiling Point

    ### Importance
    - Identification of liquid compounds
    - Purity check

    ### Simple Method
    1. Heat liquid in small flask with thermometer
    2. Note temperature when boiling (constant temperature)

    ### Micro Method (Siwoloboff Method)
    - Use capillary tube inverted in liquid
    - When bubbles stream rapidly → boiling point

    ### Interpretation
    - **Constant bp:** Pure liquid
    - **Range of bp:** Mixture

    ---

    ## Important Points for IIT JEE

    1. **Crystallization:**
       - Compound should be soluble in hot solvent, insoluble in cold
       - Impurities remain in solution (mother liquor)

    2. **Distillation types:**
       - Simple: bp difference >25°C
       - Fractional: bp difference <25°C
       - Steam: Heat-sensitive, water-immiscible compounds

    3. **Sublimation examples:**
       - Benzoic acid, naphthalene, camphor, iodine

    4. **TLC Rf values:**
       - Polar compounds: Low Rf (stick to silica)
       - Non-polar compounds: High Rf (move with solvent)

    5. **Acid-base extraction:**
       - Strong acid (RCOOH): Reacts with NaHCO₃ and NaOH
       - Weak acid (ArOH): Reacts only with NaOH
       - Use to separate mixtures

    ---

    ## Practice Questions

    1. What solvent would you choose to recrystallize benzoic acid? Why?
    2. Explain why steam distillation is used for isolating aniline.
    3. Calculate Rf if a compound travels 4.5 cm and solvent travels 6.0 cm.
    4. How would you separate a mixture of benzoic acid, phenol, and toluene using extraction?
    5. What drying agent would you use for drying ethanol? Why not CaCl₂?

## Key Points

- Crystallization and recrystallization

- Distillation (simple, fractional, steam)

- Sublimation
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Crystallization and recrystallization', 'Distillation (simple, fractional, steam)', 'Sublimation', 'Chromatography (TLC, column)', 'Extraction and washing', 'Drying agents'],
  prerequisite_ids: []
)

puts "✓ Created 23 microlessons for Module 08 Practical Organic Chemistry"

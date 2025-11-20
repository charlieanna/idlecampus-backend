# AUTO-GENERATED from module_06_d_block.rb
puts "Creating Microlessons for D Block Transition Elements..."

module_var = CourseModule.find_by(slug: 'd-block-transition-elements')

# === MICROLESSON 1: volumetric_analysis — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'volumetric_analysis — Practice',
  content: <<~MARKDOWN,
# volumetric_analysis — Practice 🚀

K₂Cr₂O₇ is a primary standard (pure, stable, doesn\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['volumetric_analysis'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which compound is used as a primary standard in volumetric analysis?',
    options: ['KMnO₄', 'K₂Cr₂O₇', 'FeSO₄', 'Na₂S₂O₃'],
    correct_answer: 1,
    explanation: 'K₂Cr₂O₇ is a primary standard (pure, stable, doesn\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: Important Compounds: Dichromates and Permanganates ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Important Compounds: Dichromates and Permanganates',
  content: <<~MARKDOWN,
# Important Compounds: Dichromates and Permanganates 🚀

# Important Transition Metal Compounds

    ## Potassium Dichromate - K₂Cr₂O₇

    ### Preparation

    **From chromite ore (FeCr₂O₄):**

    1. **Roasting with Na₂CO₃ in presence of air:**
       4FeCr₂O₄ + 8Na₂CO₃ + 7O₂ → 8Na₂CrO₄ + 2Fe₂O₃ + 8CO₂
       (Sodium chromate - yellow, soluble)

    2. **Acidification:**
       2Na₂CrO₄ + H₂SO₄ → Na₂Cr₂O₇ + Na₂SO₄ + H₂O
       (Sodium dichromate - orange)

    3. **Conversion to K₂Cr₂O₇:**
       Na₂Cr₂O₇ + 2KCl → K₂Cr₂O₇ + 2NaCl
       (K₂Cr₂O₇ is less soluble, precipitates)

    ### Structure

    - **Cr₂O₇²⁻ ion:** Two CrO₄ tetrahedra sharing one oxygen
    - **Oxidation state of Cr:** +6
    - **Chromate-Dichromate equilibrium:**
      2CrO₄²⁻ + 2H⁺ ⇌ Cr₂O₇²⁻ + H₂O
      (Yellow)    (Orange)

    **In acidic medium:** Orange (Cr₂O₇²⁻)
    **In basic medium:** Yellow (CrO₄²⁻)

    ### Properties

    **Physical:**
    - Orange-red crystalline solid
    - Soluble in water

    **Chemical:**
    - **Strong oxidizing agent** (especially in acidic medium)
    - **Cr₂O₇²⁻ → Cr³⁺** (green in acidic medium)

    ### Oxidizing Reactions

    **1. With FeSO₄:**
    K₂Cr₂O₇ + 7H₂SO₄ + 6FeSO₄ → K₂SO₄ + Cr₂(SO₄)₃ + 3Fe₂(SO₄)₃ + 7H₂O
    (Orange → Green)
    Fe²⁺ → Fe³⁺ (oxidized)

    **2. With KI in acidic medium:**
    K₂Cr₂O₇ + 7H₂SO₄ + 6KI → K₂SO₄ + Cr₂(SO₄)₃ + 3I₂ + 7H₂O + 3K₂SO₄
    Iodine liberated (violet color)

    **3. With SO₂:**
    K₂Cr₂O₇ + H₂SO₄ + 3SO₂ → K₂SO₄ + Cr₂(SO₄)₃ + H₂O
    (Orange → Green)

    **4. With H₂S:**
    K₂Cr₂O₇ + 4H₂SO₄ + 3H₂S → K₂SO₄ + Cr₂(SO₄)₃ + 3S + 7H₂O
    (Orange → Green, sulfur precipitates)

    **5. Oxidation of alcohols:**
    - **Primary alcohol → Aldehyde → Carboxylic acid**
    - **Secondary alcohol → Ketone**
    - **Tertiary alcohol → No reaction**

    ### Chromyl Chloride Test (for Cl⁻)

    **Test for chloride ions:**

    K₂Cr₂O₇ + 4NaCl + 6H₂SO₄ → 2KHSO₄ + 4NaHSO₄ + 2CrO₂Cl₂ + 3H₂O
    (Chromyl chloride - red vapors)

    CrO₂Cl₂ + 4NaOH → Na₂CrO₄ + 2NaCl + 2H₂O
    (Yellow solution)

    Add acetic acid + lead acetate:
    Na₂CrO₄ + Pb(CH₃COO)₂ → PbCrO₄ + 2CH₃COONa
    (Yellow precipitate of PbCrO₄)

    **Confirmatory test for Cl⁻ ions**

    ### Uses

    1. **Oxidizing agent** in organic chemistry
    2. **Leather tanning**
    3. **Chrome plating**
    4. **Pigments** (chrome yellow - PbCrO₄)
    5. **Analytical reagent**

    ---

    ## Potassium Permanganate - KMnO₄

    ### Preparation

    **From pyrolusite (MnO₂):**

    1. **Fusion with KOH in presence of air:**
       2MnO₂ + 4KOH + O₂ → 2K₂MnO₄ + 2H₂O
       (Potassium manganate - green)

    2. **Electrolytic oxidation or acidification:**
       3MnO₄²⁻ + 4H⁺ → 2MnO₄⁻ + MnO₂ + 2H₂O
       (Green)    (Purple)

       Or: 2K₂MnO₄ + Cl₂ → 2KMnO₄ + 2KCl

    ### Structure

    - **MnO₄⁻ ion:** Tetrahedral
    - **Oxidation state of Mn:** +7
    - **Bond order:** 1.5 (partial double bond character)

    ### Properties

    **Physical:**
    - Dark purple crystalline solid
    - Moderately soluble in water (purple solution)
    - Intense color (even dilute solutions are colored)

    **Chemical:**
    - **Strong oxidizing agent** (one of the strongest!)
    - Oxidizing power depends on pH:
      - **Acidic medium:** MnO₄⁻ → Mn²⁺ (colorless)
      - **Neutral/Faintly alkaline:** MnO₄⁻ → MnO₂ (brown ppt)
      - **Strongly alkaline:** MnO₄⁻ → MnO₄²⁻ (green)

    ### Oxidizing Reactions

    **In Acidic Medium (H₂SO₄):**

    **1. With FeSO₄:**
    2KMnO₄ + 10FeSO₄ + 8H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5Fe₂(SO₄)₃ + 8H₂O
    (Purple → Colorless)
    Mn⁺⁷ → Mn²⁺

    **2. With Oxalic acid:**
    2KMnO₄ + 5H₂C₂O₄ + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 10CO₂ + 8H₂O
    (Self-indicating - purple → colorless)

    **3. With SO₂:**
    2KMnO₄ + 5SO₂ + 2H₂O → K₂SO₄ + 2MnSO₄ + 2H₂SO₄
    (Purple → Colorless)

    **4. With H₂S:**
    2KMnO₄ + 5H₂S + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5S + 8H₂O
    (Purple → Colorless, sulfur precipitates)

    **5. With H₂O₂:**
    2KMnO₄ + 5H₂O₂ + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5O₂ + 8H₂O
    Oxygen gas evolved

    **In Neutral/Alkaline Medium:**

    **With KI:**
    2KMnO₄ + H₂O + KI → 2MnO₂ + 2KOH + KIO₃
    (Purple → Brown precipitate)

    ### Self-Indication

    KMnO₄ acts as **self-indicator** in volumetric analysis:
    - During titration: Purple color disappears
    - At endpoint: First permanent pink color appears
    - No need for external indicator!

    ### Tests for Unsaturation

    **Baeyer's Test:**
    - **Alkenes** decolorize KMnO₄ solution
    - C=C + KMnO₄ (cold, dilute) → diol (glycol)
    - Purple → Colorless (or brown MnO₂ ppt)

    ### Uses

    1. **Oxidizing agent** in organic chemistry
    2. **Volumetric analysis** (titrations)
    3. **Disinfectant and germicide** (dilute solution)
    4. **Water purification**
    5. **Antidote for certain poisons**
    6. **Baeyer's test** for unsaturation

    ---

    ## Comparison: K₂Cr₂O₇ vs KMnO₄

    | Property | K₂Cr₂O₇ | KMnO₄ |
    |----------|---------|-------|
    | **Color** | Orange-red | Dark purple |
    | **Oxidation state** | Cr⁺⁶ | Mn⁺⁷ |
    | **Reduced to (acid)** | Cr³⁺ (green) | Mn²⁺ (colorless) |
    | **Stability** | Very stable | Decomposes on heating |
    | **Oxidizing power** | Strong | Stronger |
    | **Primary standard** | Yes | No (not pure, decomposes) |
    | **Use in titrations** | Yes | Yes (self-indicator) |
    | **Reaction with HCl** | Liberates Cl₂ | Liberates Cl₂ |

    ## IIT JEE Key Points

    1. **K₂Cr₂O₇:** Orange, Cr⁺⁶, reduced to green Cr³⁺
    2. **Chromate-dichromate equilibrium:** Yellow (CrO₄²⁻) ⇌ Orange (Cr₂O₇²⁻)
    3. **Chromyl chloride test:** Red vapors of CrO₂Cl₂ (for Cl⁻)
    4. **KMnO₄:** Purple, Mn⁺⁷, strong oxidizing agent
    5. **In acidic medium:** MnO₄⁻ → Mn²⁺ (colorless)
    6. **In neutral:** MnO₄⁻ → MnO₂ (brown ppt)
    7. **Self-indicator:** KMnO₄ in titrations
    8. **Baeyer's test:** KMnO₄ decolorization by alkenes
    9. **K₂Cr₂O₇ is primary standard**, KMnO₄ is not
    10. Both oxidize Fe²⁺ → Fe³⁺ in acidic medium

## Key Points

- Potassium dichromate

- Potassium permanganate

- Oxidizing agents
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Potassium dichromate', 'Potassium permanganate', 'Oxidizing agents', 'Chromyl chloride test'],
  prerequisite_ids: []
)

# === MICROLESSON 3: General Properties of Transition Metals ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'General Properties of Transition Metals',
  content: <<~MARKDOWN,
# General Properties of Transition Metals 🚀

# General Properties of Transition Metals

    ## Definition

    **Transition elements:** Elements with **incompletely filled d-orbitals** in the ground state or in any stable oxidation state.

    **d-Block elements:** Elements in Groups 3-12 where d-orbitals are being filled.

    **Note:** Zn, Cd, Hg are NOT transition elements (d¹⁰s² - completely filled d-orbitals).

    ## Electronic Configuration

    ### General Configuration
    **(n-1)d¹⁻¹⁰ ns¹⁻²**

    ### 3d Series (First Transition Series)
    Sc to Zn (Atomic numbers 21-30)

    | Element | Configuration | Exceptions |
    |---------|---------------|------------|
    | Sc | [Ar] 3d¹ 4s² | - |
    | Ti | [Ar] 3d² 4s² | - |
    | V | [Ar] 3d³ 4s² | - |
    | Cr | [Ar] 3d⁵ 4s¹ | Exception! (half-filled stability) |
    | Mn | [Ar] 3d⁵ 4s² | - |
    | Fe | [Ar] 3d⁶ 4s² | - |
    | Co | [Ar] 3d⁷ 4s² | - |
    | Ni | [Ar] 3d⁸ 4s² | - |
    | Cu | [Ar] 3d¹⁰ 4s¹ | Exception! (fully-filled stability) |
    | Zn | [Ar] 3d¹⁰ 4s² | Not a transition metal |

    **Exceptions:**
    - **Cr:** 3d⁵ 4s¹ (instead of 3d⁴ 4s²) - half-filled d-orbital stability
    - **Cu:** 3d¹⁰ 4s¹ (instead of 3d⁹ 4s²) - fully-filled d-orbital stability

    ## Physical Properties

    ### 1. Metallic Character
    - All are **metals**
    - Good conductors of heat and electricity
    - Lustrous appearance
    - High tensile strength

    ### 2. Atomic and Ionic Radii

    **Trend across period:**
    - Generally **decrease** from Sc to Zn (but small variation)
    - Effective nuclear charge increases, pulls electrons closer

    **d-electrons provide poor shielding** → small decrease in size

    ### 3. Ionization Energy

    **Trend:**
    - Generally **increases** across the series
    - Irregular trend due to electronic configuration changes
    - Higher than s-block, lower than p-block metals

    **Why irregular?**
    - Cr and Cu have extra stability (half-filled and fully-filled)
    - Higher IE than expected

    ### 4. Density

    - **Very high densities** (heavy metals)
    - **Increases** across the period (up to middle, then decreases)
    - Maximum around Fe, Co, Ni

    **Reason:** Atomic mass increases more than atomic volume increases

    ### 5. Melting and Boiling Points

    - **Very high** melting and boiling points
    - Due to strong metallic bonding (involving both d and s electrons)
    - Maximum at Group 6 (Cr, Mo, W)

    **Exception:** Zn, Cd, Hg have low melting points (d¹⁰ - no d-electrons available for bonding)

    ### 6. Enthalpy of Atomization

    - **High** values
    - Reflects strong metallic bonding
    - Maximum around the middle of series (V, Cr, Mn)

    ## Chemical Properties

    ### 1. Variable Oxidation States

    **Most characteristic property** of transition metals

    **Reason:**
    - Both (n-1)d and ns electrons participate in bonding
    - Small energy difference between (n-1)d and ns orbitals

    **Examples:**
    - Sc: +3 only
    - Ti: +2, +3, +4
    - V: +2, +3, +4, +5
    - Cr: +2, +3, +4, +5, +6
    - Mn: +2, +3, +4, +5, +6, +7 (maximum oxidation states!)
    - Fe: +2, +3
    - Cu: +1, +2

    **Common oxidation states:**
    - +2 (most common - loss of 2 ns electrons)
    - +3 (loss of 1 ns + 1 d electron)
    - Higher states in compounds with F and O

    **Stability of +2 state:**
    - **Increases** from Sc to Zn
    - Mn²⁺ and Fe²⁺ are very stable

    ### 2. Formation of Colored Ions

    **Reason:** Partially filled d-orbitals → d-d transitions

    When white light falls on transition metal compounds:
    - d-electrons absorb specific wavelengths
    - Get excited to higher d-orbitals
    - Complementary color is observed

    **Examples:**
    - Cu²⁺: Blue (absorbs red-orange)
    - Fe³⁺: Yellow-brown
    - Cr³⁺: Green
    - Co²⁺: Pink
    - Ni²⁺: Green

    **Colorless ions:**
    - Sc³⁺ (d⁰) - no d-electrons
    - Zn²⁺ (d¹⁰) - completely filled
    - Ti⁴⁺ (d⁰)

    ### 3. Paramagnetism

    **Definition:** Attraction to magnetic field due to unpaired electrons

    **Magnetic moment (μ):** μ = √(n(n+2)) BM (Bohr Magneton)
    where n = number of unpaired electrons

    **Examples:**
    - Sc³⁺ (d⁰): 0 unpaired → diamagnetic
    - Ti³⁺ (d¹): 1 unpaired → μ = √3 = 1.73 BM
    - V³⁺ (d²): 2 unpaired → μ = √8 = 2.83 BM
    - Cr³⁺ (d³): 3 unpaired → μ = √15 = 3.87 BM
    - Mn²⁺ (d⁵): 5 unpaired → μ = √35 = 5.92 BM (maximum!)
    - Fe²⁺ (d⁶): 4 unpaired → μ = √24 = 4.90 BM
    - Cu²⁺ (d⁹): 1 unpaired → μ = 1.73 BM
    - Zn²⁺ (d¹⁰): 0 unpaired → diamagnetic

    ### 4. Formation of Complex Compounds

    **Reason:**
    - Small size, high charge
    - Availability of vacant d-orbitals
    - Can accept electron pairs from ligands

    **Examples:**
    - [Fe(CN)₆]⁴⁻, [Fe(CN)₆]³⁻
    - [Cu(NH₃)₄]²⁺
    - [Ni(CO)₄]
    - [Co(NH₃)₆]³⁺

    ### 5. Catalytic Properties

    **Transition metals and their compounds act as catalysts**

    **Reason:**
    - Variable oxidation states (can change easily)
    - Ability to adsorb reactants on surface
    - Form intermediate compounds

    **Examples:**
    - Fe in Haber process: N₂ + 3H₂ ⇌ 2NH₃
    - V₂O₅ in Contact process: 2SO₂ + O₂ → 2SO₃
    - Ni in hydrogenation: C₂H₄ + H₂ → C₂H₆
    - Pt in Ostwald process: 4NH₃ + 5O₂ → 4NO + 6H₂O
    - TiCl₄/Al(C₂H₅)₃ in Ziegler-Natta polymerization

    ### 6. Formation of Alloys

    - Transition metals readily form alloys
    - Similar atomic sizes → easy substitution

    **Examples:**
    - Steel: Fe + C
    - Brass: Cu + Zn
    - Bronze: Cu + Sn
    - Stainless steel: Fe + Cr + Ni

    ### 7. Interstitial Compounds

    - Small atoms (H, C, N) occupy **interstitial sites** in metal lattice
    - Example: Steel (C in Fe lattice)
    - Properties: Very hard, high melting points

    ## Comparison: 3d, 4d, 5d Series

    | Property | 3d Series | 4d Series | 5d Series |
    |----------|-----------|-----------|-----------|
    | Atomic radius | Smallest | Medium | Largest (but ~4d) |
    | Density | Lower | Medium | Highest |
    | Melting point | Lower | Higher | Highest |
    | Oxidation states | Lower max | Higher | Highest |
    | Stability of higher states | Least | Medium | Most |

    **Lanthanoid Contraction Effect:**
    - 4d and 5d series have nearly same size
    - Due to poor shielding by 4f electrons

    ## IIT JEE Key Points

    1. **Definition:** Incomplete d-orbitals in ground state or stable oxidation state
    2. **Electronic configuration:** (n-1)d¹⁻¹⁰ ns¹⁻²
    3. **Exceptions:** Cr (3d⁵ 4s¹), Cu (3d¹⁰ 4s¹)
    4. **Zn, Cd, Hg NOT transition metals** (d¹⁰ - completely filled)
    5. **Variable oxidation states** (most characteristic property)
    6. **Colored ions** due to d-d transitions
    7. **Paramagnetic** due to unpaired electrons: μ = √(n(n+2)) BM
    8. **Catalysts** due to variable oxidation states
    9. **Mn²⁺ has maximum unpaired electrons** (5) → highest magnetic moment
    10. **High density, high melting points** (strong metallic bonding)

## Key Points

- Transition metals

- d-orbitals

- Metallic character
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Transition metals', 'd-orbitals', 'Metallic character', 'Density', 'Melting points'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Important Compounds: Dichromates and Permanganates ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Important Compounds: Dichromates and Permanganates',
  content: <<~MARKDOWN,
# Important Compounds: Dichromates and Permanganates 🚀

# Important Transition Metal Compounds

    ## Potassium Dichromate - K₂Cr₂O₇

    ### Preparation

    **From chromite ore (FeCr₂O₄):**

    1. **Roasting with Na₂CO₃ in presence of air:**
       4FeCr₂O₄ + 8Na₂CO₃ + 7O₂ → 8Na₂CrO₄ + 2Fe₂O₃ + 8CO₂
       (Sodium chromate - yellow, soluble)

    2. **Acidification:**
       2Na₂CrO₄ + H₂SO₄ → Na₂Cr₂O₇ + Na₂SO₄ + H₂O
       (Sodium dichromate - orange)

    3. **Conversion to K₂Cr₂O₇:**
       Na₂Cr₂O₇ + 2KCl → K₂Cr₂O₇ + 2NaCl
       (K₂Cr₂O₇ is less soluble, precipitates)

    ### Structure

    - **Cr₂O₇²⁻ ion:** Two CrO₄ tetrahedra sharing one oxygen
    - **Oxidation state of Cr:** +6
    - **Chromate-Dichromate equilibrium:**
      2CrO₄²⁻ + 2H⁺ ⇌ Cr₂O₇²⁻ + H₂O
      (Yellow)    (Orange)

    **In acidic medium:** Orange (Cr₂O₇²⁻)
    **In basic medium:** Yellow (CrO₄²⁻)

    ### Properties

    **Physical:**
    - Orange-red crystalline solid
    - Soluble in water

    **Chemical:**
    - **Strong oxidizing agent** (especially in acidic medium)
    - **Cr₂O₇²⁻ → Cr³⁺** (green in acidic medium)

    ### Oxidizing Reactions

    **1. With FeSO₄:**
    K₂Cr₂O₇ + 7H₂SO₄ + 6FeSO₄ → K₂SO₄ + Cr₂(SO₄)₃ + 3Fe₂(SO₄)₃ + 7H₂O
    (Orange → Green)
    Fe²⁺ → Fe³⁺ (oxidized)

    **2. With KI in acidic medium:**
    K₂Cr₂O₇ + 7H₂SO₄ + 6KI → K₂SO₄ + Cr₂(SO₄)₃ + 3I₂ + 7H₂O + 3K₂SO₄
    Iodine liberated (violet color)

    **3. With SO₂:**
    K₂Cr₂O₇ + H₂SO₄ + 3SO₂ → K₂SO₄ + Cr₂(SO₄)₃ + H₂O
    (Orange → Green)

    **4. With H₂S:**
    K₂Cr₂O₇ + 4H₂SO₄ + 3H₂S → K₂SO₄ + Cr₂(SO₄)₃ + 3S + 7H₂O
    (Orange → Green, sulfur precipitates)

    **5. Oxidation of alcohols:**
    - **Primary alcohol → Aldehyde → Carboxylic acid**
    - **Secondary alcohol → Ketone**
    - **Tertiary alcohol → No reaction**

    ### Chromyl Chloride Test (for Cl⁻)

    **Test for chloride ions:**

    K₂Cr₂O₇ + 4NaCl + 6H₂SO₄ → 2KHSO₄ + 4NaHSO₄ + 2CrO₂Cl₂ + 3H₂O
    (Chromyl chloride - red vapors)

    CrO₂Cl₂ + 4NaOH → Na₂CrO₄ + 2NaCl + 2H₂O
    (Yellow solution)

    Add acetic acid + lead acetate:
    Na₂CrO₄ + Pb(CH₃COO)₂ → PbCrO₄ + 2CH₃COONa
    (Yellow precipitate of PbCrO₄)

    **Confirmatory test for Cl⁻ ions**

    ### Uses

    1. **Oxidizing agent** in organic chemistry
    2. **Leather tanning**
    3. **Chrome plating**
    4. **Pigments** (chrome yellow - PbCrO₄)
    5. **Analytical reagent**

    ---

    ## Potassium Permanganate - KMnO₄

    ### Preparation

    **From pyrolusite (MnO₂):**

    1. **Fusion with KOH in presence of air:**
       2MnO₂ + 4KOH + O₂ → 2K₂MnO₄ + 2H₂O
       (Potassium manganate - green)

    2. **Electrolytic oxidation or acidification:**
       3MnO₄²⁻ + 4H⁺ → 2MnO₄⁻ + MnO₂ + 2H₂O
       (Green)    (Purple)

       Or: 2K₂MnO₄ + Cl₂ → 2KMnO₄ + 2KCl

    ### Structure

    - **MnO₄⁻ ion:** Tetrahedral
    - **Oxidation state of Mn:** +7
    - **Bond order:** 1.5 (partial double bond character)

    ### Properties

    **Physical:**
    - Dark purple crystalline solid
    - Moderately soluble in water (purple solution)
    - Intense color (even dilute solutions are colored)

    **Chemical:**
    - **Strong oxidizing agent** (one of the strongest!)
    - Oxidizing power depends on pH:
      - **Acidic medium:** MnO₄⁻ → Mn²⁺ (colorless)
      - **Neutral/Faintly alkaline:** MnO₄⁻ → MnO₂ (brown ppt)
      - **Strongly alkaline:** MnO₄⁻ → MnO₄²⁻ (green)

    ### Oxidizing Reactions

    **In Acidic Medium (H₂SO₄):**

    **1. With FeSO₄:**
    2KMnO₄ + 10FeSO₄ + 8H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5Fe₂(SO₄)₃ + 8H₂O
    (Purple → Colorless)
    Mn⁺⁷ → Mn²⁺

    **2. With Oxalic acid:**
    2KMnO₄ + 5H₂C₂O₄ + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 10CO₂ + 8H₂O
    (Self-indicating - purple → colorless)

    **3. With SO₂:**
    2KMnO₄ + 5SO₂ + 2H₂O → K₂SO₄ + 2MnSO₄ + 2H₂SO₄
    (Purple → Colorless)

    **4. With H₂S:**
    2KMnO₄ + 5H₂S + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5S + 8H₂O
    (Purple → Colorless, sulfur precipitates)

    **5. With H₂O₂:**
    2KMnO₄ + 5H₂O₂ + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5O₂ + 8H₂O
    Oxygen gas evolved

    **In Neutral/Alkaline Medium:**

    **With KI:**
    2KMnO₄ + H₂O + KI → 2MnO₂ + 2KOH + KIO₃
    (Purple → Brown precipitate)

    ### Self-Indication

    KMnO₄ acts as **self-indicator** in volumetric analysis:
    - During titration: Purple color disappears
    - At endpoint: First permanent pink color appears
    - No need for external indicator!

    ### Tests for Unsaturation

    **Baeyer's Test:**
    - **Alkenes** decolorize KMnO₄ solution
    - C=C + KMnO₄ (cold, dilute) → diol (glycol)
    - Purple → Colorless (or brown MnO₂ ppt)

    ### Uses

    1. **Oxidizing agent** in organic chemistry
    2. **Volumetric analysis** (titrations)
    3. **Disinfectant and germicide** (dilute solution)
    4. **Water purification**
    5. **Antidote for certain poisons**
    6. **Baeyer's test** for unsaturation

    ---

    ## Comparison: K₂Cr₂O₇ vs KMnO₄

    | Property | K₂Cr₂O₇ | KMnO₄ |
    |----------|---------|-------|
    | **Color** | Orange-red | Dark purple |
    | **Oxidation state** | Cr⁺⁶ | Mn⁺⁷ |
    | **Reduced to (acid)** | Cr³⁺ (green) | Mn²⁺ (colorless) |
    | **Stability** | Very stable | Decomposes on heating |
    | **Oxidizing power** | Strong | Stronger |
    | **Primary standard** | Yes | No (not pure, decomposes) |
    | **Use in titrations** | Yes | Yes (self-indicator) |
    | **Reaction with HCl** | Liberates Cl₂ | Liberates Cl₂ |

    ## IIT JEE Key Points

    1. **K₂Cr₂O₇:** Orange, Cr⁺⁶, reduced to green Cr³⁺
    2. **Chromate-dichromate equilibrium:** Yellow (CrO₄²⁻) ⇌ Orange (Cr₂O₇²⁻)
    3. **Chromyl chloride test:** Red vapors of CrO₂Cl₂ (for Cl⁻)
    4. **KMnO₄:** Purple, Mn⁺⁷, strong oxidizing agent
    5. **In acidic medium:** MnO₄⁻ → Mn²⁺ (colorless)
    6. **In neutral:** MnO₄⁻ → MnO₂ (brown ppt)
    7. **Self-indicator:** KMnO₄ in titrations
    8. **Baeyer's test:** KMnO₄ decolorization by alkenes
    9. **K₂Cr₂O₇ is primary standard**, KMnO₄ is not
    10. Both oxidize Fe²⁺ → Fe³⁺ in acidic medium

## Key Points

- Potassium dichromate

- Potassium permanganate

- Oxidizing agents
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Potassium dichromate', 'Potassium permanganate', 'Oxidizing agents', 'Chromyl chloride test'],
  prerequisite_ids: []
)

# === MICROLESSON 5: definition — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'definition — Practice',
  content: <<~MARKDOWN,
# definition — Practice 🚀

Zn (3d¹⁰ 4s²) and Cd (4d¹⁰ 5s²) have completely filled d-orbitals in ground state and common oxidation states. They are NOT transition elements. Cu is a transition element (forms Cu²⁺ with d⁹).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['definition'],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are NOT transition elements?',
    options: ['Scandium (Sc)', 'Zinc (Zn)', 'Copper (Cu)', 'Cadmium (Cd)'],
    correct_answer: 3,
    explanation: 'Zn (3d¹⁰ 4s²) and Cd (4d¹⁰ 5s²) have completely filled d-orbitals in ground state and common oxidation states. They are NOT transition elements. Cu is a transition element (forms Cu²⁺ with d⁹).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 6: electronic_configuration — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'electronic_configuration — Practice',
  content: <<~MARKDOWN,
# electronic_configuration — Practice 🚀

Cr has exceptional configuration [Ar] 3d⁵ 4s¹ (not 3d⁴ 4s²) due to extra stability of half-filled d-orbital.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['electronic_configuration'],
  prerequisite_ids: []
)

# Exercise 6.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The electronic configuration of chromium (Cr, Z=24) is [Ar] 3d____ 4s____.',
    answer: '3d5 4s1|3d⁵ 4s¹|5,1',
    explanation: 'Cr has exceptional configuration [Ar] 3d⁵ 4s¹ (not 3d⁴ 4s²) due to extra stability of half-filled d-orbital.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 7: magnetism — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'magnetism — Practice',
  content: <<~MARKDOWN,
# magnetism — Practice 🚀

Mn²⁺ has d⁵ configuration with 5 unpaired electrons (one in each d-orbital), giving maximum unpaired electrons and highest magnetic moment μ = √35 = 5.92 BM.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['magnetism'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which transition metal ion has the maximum number of unpaired electrons?',
    options: ['Fe²⁺ (d⁶)', 'Mn²⁺ (d⁵)', 'Cr³⁺ (d³)', 'Cu²⁺ (d⁹)'],
    correct_answer: 1,
    explanation: 'Mn²⁺ has d⁵ configuration with 5 unpaired electrons (one in each d-orbital), giving maximum unpaired electrons and highest magnetic moment μ = √35 = 5.92 BM.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 8: magnetism — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'magnetism — Practice',
  content: <<~MARKDOWN,
# magnetism — Practice 🚀

Ti³⁺ has d¹ configuration (1 unpaired electron). μ = √(1(1+2)) = √3 = 1.73 BM.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['magnetism'],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the magnetic moment (in BM) of Ti³⁺ ion (d¹ configuration). Use formula: μ = √(n(n+2)) where n = unpaired electrons.',
    answer: '1.73',
    explanation: 'Ti³⁺ has d¹ configuration (1 unpaired electron). μ = √(1(1+2)) = √3 = 1.73 BM.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: catalysis — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'catalysis — Practice',
  content: <<~MARKDOWN,
# catalysis — Practice 🚀

Transition metals act as catalysts due to: (1) Variable oxidation states (can change during reaction), (2) Ability to adsorb reactants on surface, (3) Formation of unstable intermediates.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['catalysis'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why do transition metals show catalytic properties?',
    options: ['Variable oxidation states', 'Ability to adsorb reactants', 'Complete d-orbitals', 'Large atomic size'],
    correct_answer: 1,
    explanation: 'Transition metals act as catalysts due to: (1) Variable oxidation states (can change during reaction), (2) Ability to adsorb reactants on surface, (3) Formation of unstable intermediates.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 10: magnetism — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'magnetism — Practice',
  content: <<~MARKDOWN,
# magnetism — Practice 🚀

TRUE. Sc³⁺ has d⁰ configuration (no d-electrons) and Zn²⁺ has d¹⁰ (completely filled). Both have zero unpaired electrons, hence diamagnetic.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['magnetism'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Sc³⁺ and Zn²⁺ ions are diamagnetic.',
    answer: 'true',
    explanation: 'TRUE. Sc³⁺ has d⁰ configuration (no d-electrons) and Zn²⁺ has d¹⁰ (completely filled). Both have zero unpaired electrons, hence diamagnetic.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: oxidation_states — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_states — Practice',
  content: <<~MARKDOWN,
# oxidation_states — Practice 🚀

Number of oxidation states increases across 3d series initially. Sc (only +3) < Ti (+2,+3,+4) < Cr (+2,+3,+4,+5,+6) < Mn (+2,+3,+4,+5,+6,+7 - maximum!).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['oxidation_states'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following in order of INCREASING number of oxidation states:',
    answer: '1,2,3,4',
    explanation: 'Number of oxidation states increases across 3d series initially. Sc (only +3) < Ti (+2,+3,+4) < Cr (+2,+3,+4,+5,+6) < Mn (+2,+3,+4,+5,+6,+7 - maximum!).',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: color — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'color — Practice',
  content: <<~MARKDOWN,
# color — Practice 🚀

Zn²⁺ (d¹⁰) is colorless because d-orbitals are completely filled - no d-d transitions possible. Cu²⁺ (blue), Fe³⁺ (yellow-brown), Cr³⁺ (green) are colored.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['color'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following ions is colorless in aqueous solution?',
    options: ['Cu²⁺', 'Fe³⁺', 'Zn²⁺', 'Cr³⁺'],
    correct_answer: 2,
    explanation: 'Zn²⁺ (d¹⁰) is colorless because d-orbitals are completely filled - no d-d transitions possible. Cu²⁺ (blue), Fe³⁺ (yellow-brown), Cr³⁺ (green) are colored.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: dichromate — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'dichromate — Practice',
  content: <<~MARKDOWN,
# dichromate — Practice 🚀

Dichromate ion (Cr₂O₇²⁻) is orange in solution. Chromate (CrO₄²⁻) is yellow. When K₂Cr₂O₇ is reduced in acidic medium, it forms green Cr³⁺.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['dichromate'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the color of dichromate ion (Cr₂O₇²⁻) in solution?',
    options: ['Yellow', 'Orange', 'Green', 'Purple'],
    correct_answer: 1,
    explanation: 'Dichromate ion (Cr₂O₇²⁻) is orange in solution. Chromate (CrO₄²⁻) is yellow. When K₂Cr₂O₇ is reduced in acidic medium, it forms green Cr³⁺.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 14: permanganate — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'permanganate — Practice',
  content: <<~MARKDOWN,
# permanganate — Practice 🚀

In acidic medium (H₂SO₄), MnO₄⁻ (Mn⁺⁷, purple) is reduced to Mn²⁺ (colorless). In neutral medium, it forms MnO₂ (brown ppt).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['permanganate'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In acidic medium, permanganate ion (MnO₄⁻) is reduced to _______ ion.',
    answer: 'Mn2+|Mn²⁺|manganous|manganese(II)',
    explanation: 'In acidic medium (H₂SO₄), MnO₄⁻ (Mn⁺⁷, purple) is reduced to Mn²⁺ (colorless). In neutral medium, it forms MnO₂ (brown ppt).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: permanganate — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'permanganate — Practice',
  content: <<~MARKDOWN,
# permanganate — Practice 🚀

KMnO₄: (1) Strong oxidizing agent, (2) Self-indicator (purple color), (3) NOT primary standard (decomposes, not 100% pure), (4) Mn in +7 state.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['permanganate'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which statements about KMnO₄ are correct?',
    options: ['It is a strong oxidizing agent', 'It acts as self-indicator in titrations', 'It is a primary standard', 'Mn is in +7 oxidation state'],
    correct_answer: 3,
    explanation: 'KMnO₄: (1) Strong oxidizing agent, (2) Self-indicator (purple color), (3) NOT primary standard (decomposes, not 100% pure), (4) Mn in +7 state.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: chromyl_chloride — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'chromyl_chloride — Practice',
  content: <<~MARKDOWN,
# chromyl_chloride — Practice 🚀

TRUE. Chromyl chloride test: K₂Cr₂O₇ + NaCl + H₂SO₄ → CrO₂Cl₂ (red vapors). This confirms presence of Cl⁻ ions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['chromyl_chloride'],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The chromyl chloride test is used to detect chloride ions.',
    answer: 'true',
    explanation: 'TRUE. Chromyl chloride test: K₂Cr₂O₇ + NaCl + H₂SO₄ → CrO₂Cl₂ (red vapors). This confirms presence of Cl⁻ ions.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: redox_reactions — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'redox_reactions — Practice',
  content: <<~MARKDOWN,
# redox_reactions — Practice 🚀

2KMnO₄ + 10FeSO₄ + 8H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5Fe₂(SO₄)₃ + 8H₂O. Fe²⁺ oxidized to Fe³⁺, Mn⁺⁷ reduced to Mn²⁺.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['redox_reactions'],
  prerequisite_ids: []
)

# Exercise 17.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Balance the reaction of KMnO₄ with FeSO₄ in acidic medium:',
    answer: '2 KMnO4 + 10 FeSO4 + 8 H2SO4 -> K2SO4 + 2 MnSO4 + 5 Fe2(SO4)3 + 8 H2O',
    explanation: '2KMnO₄ + 10FeSO₄ + 8H₂SO₄ → K₂SO₄ + 2MnSO₄ + 5Fe₂(SO₄)₃ + 8H₂O. Fe²⁺ oxidized to Fe³⁺, Mn⁺⁷ reduced to Mn²⁺.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 18: oxidation_states — Practice ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_states — Practice',
  content: <<~MARKDOWN,
# oxidation_states — Practice 🚀

Let oxidation state of Cr = x. 2(+1) + 2x + 7(-2) = 0, so 2 + 2x - 14 = 0, x = +6.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['oxidation_states'],
  prerequisite_ids: []
)

# Exercise 18.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the oxidation state of chromium in K₂Cr₂O₇?',
    answer: '6',
    explanation: 'Let oxidation state of Cr = x. 2(+1) + 2x + 7(-2) = 0, so 2 + 2x - 14 = 0, x = +6.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 19: General Properties of Transition Metals ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'General Properties of Transition Metals',
  content: <<~MARKDOWN,
# General Properties of Transition Metals 🚀

# General Properties of Transition Metals

    ## Definition

    **Transition elements:** Elements with **incompletely filled d-orbitals** in the ground state or in any stable oxidation state.

    **d-Block elements:** Elements in Groups 3-12 where d-orbitals are being filled.

    **Note:** Zn, Cd, Hg are NOT transition elements (d¹⁰s² - completely filled d-orbitals).

    ## Electronic Configuration

    ### General Configuration
    **(n-1)d¹⁻¹⁰ ns¹⁻²**

    ### 3d Series (First Transition Series)
    Sc to Zn (Atomic numbers 21-30)

    | Element | Configuration | Exceptions |
    |---------|---------------|------------|
    | Sc | [Ar] 3d¹ 4s² | - |
    | Ti | [Ar] 3d² 4s² | - |
    | V | [Ar] 3d³ 4s² | - |
    | Cr | [Ar] 3d⁵ 4s¹ | Exception! (half-filled stability) |
    | Mn | [Ar] 3d⁵ 4s² | - |
    | Fe | [Ar] 3d⁶ 4s² | - |
    | Co | [Ar] 3d⁷ 4s² | - |
    | Ni | [Ar] 3d⁸ 4s² | - |
    | Cu | [Ar] 3d¹⁰ 4s¹ | Exception! (fully-filled stability) |
    | Zn | [Ar] 3d¹⁰ 4s² | Not a transition metal |

    **Exceptions:**
    - **Cr:** 3d⁵ 4s¹ (instead of 3d⁴ 4s²) - half-filled d-orbital stability
    - **Cu:** 3d¹⁰ 4s¹ (instead of 3d⁹ 4s²) - fully-filled d-orbital stability

    ## Physical Properties

    ### 1. Metallic Character
    - All are **metals**
    - Good conductors of heat and electricity
    - Lustrous appearance
    - High tensile strength

    ### 2. Atomic and Ionic Radii

    **Trend across period:**
    - Generally **decrease** from Sc to Zn (but small variation)
    - Effective nuclear charge increases, pulls electrons closer

    **d-electrons provide poor shielding** → small decrease in size

    ### 3. Ionization Energy

    **Trend:**
    - Generally **increases** across the series
    - Irregular trend due to electronic configuration changes
    - Higher than s-block, lower than p-block metals

    **Why irregular?**
    - Cr and Cu have extra stability (half-filled and fully-filled)
    - Higher IE than expected

    ### 4. Density

    - **Very high densities** (heavy metals)
    - **Increases** across the period (up to middle, then decreases)
    - Maximum around Fe, Co, Ni

    **Reason:** Atomic mass increases more than atomic volume increases

    ### 5. Melting and Boiling Points

    - **Very high** melting and boiling points
    - Due to strong metallic bonding (involving both d and s electrons)
    - Maximum at Group 6 (Cr, Mo, W)

    **Exception:** Zn, Cd, Hg have low melting points (d¹⁰ - no d-electrons available for bonding)

    ### 6. Enthalpy of Atomization

    - **High** values
    - Reflects strong metallic bonding
    - Maximum around the middle of series (V, Cr, Mn)

    ## Chemical Properties

    ### 1. Variable Oxidation States

    **Most characteristic property** of transition metals

    **Reason:**
    - Both (n-1)d and ns electrons participate in bonding
    - Small energy difference between (n-1)d and ns orbitals

    **Examples:**
    - Sc: +3 only
    - Ti: +2, +3, +4
    - V: +2, +3, +4, +5
    - Cr: +2, +3, +4, +5, +6
    - Mn: +2, +3, +4, +5, +6, +7 (maximum oxidation states!)
    - Fe: +2, +3
    - Cu: +1, +2

    **Common oxidation states:**
    - +2 (most common - loss of 2 ns electrons)
    - +3 (loss of 1 ns + 1 d electron)
    - Higher states in compounds with F and O

    **Stability of +2 state:**
    - **Increases** from Sc to Zn
    - Mn²⁺ and Fe²⁺ are very stable

    ### 2. Formation of Colored Ions

    **Reason:** Partially filled d-orbitals → d-d transitions

    When white light falls on transition metal compounds:
    - d-electrons absorb specific wavelengths
    - Get excited to higher d-orbitals
    - Complementary color is observed

    **Examples:**
    - Cu²⁺: Blue (absorbs red-orange)
    - Fe³⁺: Yellow-brown
    - Cr³⁺: Green
    - Co²⁺: Pink
    - Ni²⁺: Green

    **Colorless ions:**
    - Sc³⁺ (d⁰) - no d-electrons
    - Zn²⁺ (d¹⁰) - completely filled
    - Ti⁴⁺ (d⁰)

    ### 3. Paramagnetism

    **Definition:** Attraction to magnetic field due to unpaired electrons

    **Magnetic moment (μ):** μ = √(n(n+2)) BM (Bohr Magneton)
    where n = number of unpaired electrons

    **Examples:**
    - Sc³⁺ (d⁰): 0 unpaired → diamagnetic
    - Ti³⁺ (d¹): 1 unpaired → μ = √3 = 1.73 BM
    - V³⁺ (d²): 2 unpaired → μ = √8 = 2.83 BM
    - Cr³⁺ (d³): 3 unpaired → μ = √15 = 3.87 BM
    - Mn²⁺ (d⁵): 5 unpaired → μ = √35 = 5.92 BM (maximum!)
    - Fe²⁺ (d⁶): 4 unpaired → μ = √24 = 4.90 BM
    - Cu²⁺ (d⁹): 1 unpaired → μ = 1.73 BM
    - Zn²⁺ (d¹⁰): 0 unpaired → diamagnetic

    ### 4. Formation of Complex Compounds

    **Reason:**
    - Small size, high charge
    - Availability of vacant d-orbitals
    - Can accept electron pairs from ligands

    **Examples:**
    - [Fe(CN)₆]⁴⁻, [Fe(CN)₆]³⁻
    - [Cu(NH₃)₄]²⁺
    - [Ni(CO)₄]
    - [Co(NH₃)₆]³⁺

    ### 5. Catalytic Properties

    **Transition metals and their compounds act as catalysts**

    **Reason:**
    - Variable oxidation states (can change easily)
    - Ability to adsorb reactants on surface
    - Form intermediate compounds

    **Examples:**
    - Fe in Haber process: N₂ + 3H₂ ⇌ 2NH₃
    - V₂O₅ in Contact process: 2SO₂ + O₂ → 2SO₃
    - Ni in hydrogenation: C₂H₄ + H₂ → C₂H₆
    - Pt in Ostwald process: 4NH₃ + 5O₂ → 4NO + 6H₂O
    - TiCl₄/Al(C₂H₅)₃ in Ziegler-Natta polymerization

    ### 6. Formation of Alloys

    - Transition metals readily form alloys
    - Similar atomic sizes → easy substitution

    **Examples:**
    - Steel: Fe + C
    - Brass: Cu + Zn
    - Bronze: Cu + Sn
    - Stainless steel: Fe + Cr + Ni

    ### 7. Interstitial Compounds

    - Small atoms (H, C, N) occupy **interstitial sites** in metal lattice
    - Example: Steel (C in Fe lattice)
    - Properties: Very hard, high melting points

    ## Comparison: 3d, 4d, 5d Series

    | Property | 3d Series | 4d Series | 5d Series |
    |----------|-----------|-----------|-----------|
    | Atomic radius | Smallest | Medium | Largest (but ~4d) |
    | Density | Lower | Medium | Highest |
    | Melting point | Lower | Higher | Highest |
    | Oxidation states | Lower max | Higher | Highest |
    | Stability of higher states | Least | Medium | Most |

    **Lanthanoid Contraction Effect:**
    - 4d and 5d series have nearly same size
    - Due to poor shielding by 4f electrons

    ## IIT JEE Key Points

    1. **Definition:** Incomplete d-orbitals in ground state or stable oxidation state
    2. **Electronic configuration:** (n-1)d¹⁻¹⁰ ns¹⁻²
    3. **Exceptions:** Cr (3d⁵ 4s¹), Cu (3d¹⁰ 4s¹)
    4. **Zn, Cd, Hg NOT transition metals** (d¹⁰ - completely filled)
    5. **Variable oxidation states** (most characteristic property)
    6. **Colored ions** due to d-d transitions
    7. **Paramagnetic** due to unpaired electrons: μ = √(n(n+2)) BM
    8. **Catalysts** due to variable oxidation states
    9. **Mn²⁺ has maximum unpaired electrons** (5) → highest magnetic moment
    10. **High density, high melting points** (strong metallic bonding)

## Key Points

- Transition metals

- d-orbitals

- Metallic character
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Transition metals', 'd-orbitals', 'Metallic character', 'Density', 'Melting points'],
  prerequisite_ids: []
)

puts "✓ Created 19 microlessons for D Block Transition Elements"

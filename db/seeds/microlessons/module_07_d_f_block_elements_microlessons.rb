# AUTO-GENERATED from module_07_d_f_block_elements.rb
puts "Creating Microlessons for D F Block Elements..."

module_var = CourseModule.find_by(slug: 'd-f-block-elements')

# === MICROLESSON 1: actinoid_occurrence — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'actinoid_occurrence — Practice',
  content: <<~MARKDOWN,
# actinoid_occurrence — Practice 🚀

Only three actinoids occur naturally: Thorium (Th), Protactinium (Pa), and Uranium (U). All other actinoids are synthetic. Elements beyond U (Z>92) are transuranium elements.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['actinoid_occurrence'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many actinoids occur naturally in significant amounts?',
    options: ['None', 'Three (Th, Pa, U)', 'All 15 actinoids', 'Only Uranium'],
    correct_answer: 1,
    explanation: 'Only three actinoids occur naturally: Thorium (Th), Protactinium (Pa), and Uranium (U). All other actinoids are synthetic. Elements beyond U (Z>92) are transuranium elements.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: f-Block Elements - Lanthanoids and Actinoids ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'f-Block Elements - Lanthanoids and Actinoids',
  content: <<~MARKDOWN,
# f-Block Elements - Lanthanoids and Actinoids 🚀

# f-Block Elements: Inner Transition Elements

    ## Introduction

    **f-block elements** are elements in which the last electron enters the f-orbital of the ante-penultimate (third last) shell.

    **General Electronic Configuration:**
    ```
    (n-2)f¹⁻¹⁴ (n-1)d⁰⁻¹ ns²
    ```

    **Two Series:**
    1. **Lanthanoids (4f series):** Ce (58) to Lu (71)
    2. **Actinoids (5f series):** Th (90) to Lr (103)

    **Position in Periodic Table:**
    - Placed separately below main periodic table
    - Also called **inner transition elements**

    ---

    ## Lanthanoids (Rare Earth Elements)

    ### Electronic Configuration

    **General configuration:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s²

    | Element | Symbol | Atomic No. | 4f electrons |
    |---------|--------|------------|--------------|
    | Lanthanum | La | 57 | 4f⁰ 5d¹ 6s² |
    | Cerium | Ce | 58 | 4f² 6s² |
    | Praseodymium | Pr | 59 | 4f³ 6s² |
    | Neodymium | Nd | 60 | 4f⁴ 6s² |
    | Promethium | Pm | 61 | 4f⁵ 6s² |
    | Samarium | Sm | 62 | 4f⁶ 6s² |
    | Europium | Eu | 63 | 4f⁷ 6s² |
    | Gadolinium | Gd | 64 | 4f⁷ 5d¹ 6s² |
    | Terbium | Tb | 65 | 4f⁹ 6s² |
    | Dysprosium | Dy | 66 | 4f¹⁰ 6s² |
    | Holmium | Ho | 67 | 4f¹¹ 6s² |
    | Erbium | Er | 68 | 4f¹² 6s² |
    | Thulium | Tm | 69 | 4f¹³ 6s² |
    | Ytterbium | Yb | 70 | 4f¹⁴ 6s² |
    | Lutetium | Lu | 71 | 4f¹⁴ 5d¹ 6s² |

    **Note:** La and Gd have exceptional configurations with one electron in 5d orbital

    ---

    ## Lanthanoid Contraction

    ### Definition
    **Lanthanoid contraction** is the gradual decrease in atomic and ionic radii of lanthanoids with increasing atomic number.

    ### Cause
    1. **Imperfect shielding** by 4f electrons
    2. Nuclear charge increases by +1 at each step
    3. Effective nuclear charge increases
    4. Electrons are pulled closer to nucleus

    **Magnitude:** Total decrease from La³⁺ to Lu³⁺ ≈ 11 pm (0.11 Å)

    ### Consequences of Lanthanoid Contraction

    #### 1. Similarity in Properties
    - Lanthanoids have very similar chemical properties
    - Difficult to separate (ion exchange method used)

    #### 2. Effect on 5d Series
    - Atomic radii of 4d and 5d elements are nearly same
    - Example: Zr (160 pm) ≈ Hf (159 pm)
    - Chemical properties of 4d and 5d elements are similar

    #### 3. Basicity Decrease
    - Basicity of hydroxides decreases from La(OH)₃ to Lu(OH)₃
    - Reason: Ionic radius decreases, covalent character increases

    #### 4. Complex Formation
    - Tendency to form complexes increases
    - Smaller size → Higher charge density → Stronger complexation

    ---

    ## Properties of Lanthanoids

    ### 1. Physical Properties

    **Metallic Character:**
    - All are silvery-white metals
    - Soft, malleable, and ductile
    - Tarnish rapidly in air

    **Melting and Boiling Points:**
    - High melting points (800-1600°C)
    - Lower than d-block transition metals

    ### 2. Oxidation States

    **Most common oxidation state:** +3

    **Reason:**
    - Loss of two 6s electrons and one 4f or 5d electron
    - Ln³⁺ configuration is very stable

    **Some show +2 and +4:**
    - **Eu²⁺ and Yb²⁺:** Extra stability of half-filled (f⁷) and fully-filled (f¹⁴)
    - **Ce⁴⁺ and Tb⁴⁺:** Extra stability of empty (f⁰) and half-filled (f⁷)

    ### 3. Magnetic Properties

    - **All lanthanoid ions are paramagnetic** (except La³⁺ and Lu³⁺)
    - Reason: Unpaired f-electrons
    - **Magnetic moment depends on number of unpaired electrons**

    ### 4. Colored Ions

    - Most Ln³⁺ ions are **colored**
    - Reason: f-f transitions (similar to d-d transitions)
    - **Exceptions:** La³⁺ (f⁰) and Lu³⁺ (f¹⁴) are colorless

    ### 5. Chemical Reactivity

    - **Highly electropositive** (like alkaline earth metals)
    - React with water: 2Ln + 6H₂O → 2Ln(OH)₃ + 3H₂
    - Combine with halogens: 2Ln + 3X₂ → 2LnX₃
    - React with acids: 2Ln + 6H⁺ → 2Ln³⁺ + 3H₂

    ---

    ## Actinoids

    ### Electronic Configuration

    **General configuration:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²

    | Element | Symbol | Atomic No. | Notable |
    |---------|--------|------------|---------|
    | Actinium | Ac | 89 | 5f⁰ 6d¹ 7s² |
    | Thorium | Th | 90 | Natural |
    | Protactinium | Pa | 91 | Natural |
    | Uranium | U | 92 | Natural, fissile |
    | Neptunium | Np | 93 | First transuranium |
    | Plutonium | Pu | 94 | Fissile |
    | Americium | Am | 95 | Transuranic |
    | ... | ... | ... | ... |
    | Lawrencium | Lr | 103 | Last actinoid |

    **Note:**
    - Elements beyond U (92) are **transuranium elements** (all radioactive)
    - Only Th, Pa, and U occur naturally
    - All actinoids are **radioactive**

    ---

    ## Properties of Actinoids

    ### 1. Radioactivity
    - **All actinoids are radioactive**
    - Heavy nuclei undergo radioactive decay
    - Emit α, β, and γ radiations

    ### 2. Oxidation States
    - Show **variable oxidation states**
    - Range: +3 to +7
    - Common: +3, +4, +5, +6

    **Examples:**
    - U: +3, +4, +5, +6
    - Pu: +3, +4, +5, +6
    - Np: +3, +4, +5, +6, +7

    **Greater variability than lanthanoids** (5f orbitals have higher energy)

    ### 3. Actinoid Contraction
    - Similar to lanthanoid contraction
    - Ionic radii decrease across series
    - Due to poor shielding by 5f electrons

    ### 4. Magnetic Properties
    - **Highly paramagnetic**
    - Due to large number of unpaired 5f electrons

    ### 5. Complex Formation
    - **Greater tendency to form complexes** than lanthanoids
    - Due to higher charge and smaller size

    ---

    ## Comparison: Lanthanoids vs Actinoids

    | Property | Lanthanoids | Actinoids |
    |----------|-------------|-----------|
    | **Orbitals filled** | 4f | 5f |
    | **Radioactivity** | Non-radioactive (except Pm) | All radioactive |
    | **Oxidation states** | Mainly +3 | +3, +4, +5, +6, +7 (variable) |
    | **Binding energy** | Higher | Lower |
    | **Magnetic moment** | Lower | Higher |
    | **Complex formation** | Less tendency | Greater tendency |
    | **Occurrence** | Natural (except Pm) | Only Th, Pa, U natural |
    | **Chemical reactivity** | Less reactive | More reactive |
    | **Color intensity** | Less intense | More intense |

    ### Why More Oxidation States in Actinoids?
    - **5f, 6d, and 7s orbitals** have comparable energies
    - All three can participate in bonding
    - **4f orbitals** in lanthanoids are deeply buried (less available)

    ---

    ## Uses of Lanthanoids and Actinoids

    ### Lanthanoids:
    1. **Mixed oxide catalysts:** Petroleum cracking
    2. **Glass industry:** Coloring and polishing
    3. **Phosphors:** Television screens, LEDs
    4. **Magnets:** NdFeB (neodymium) magnets - strongest permanent magnets
    5. **Nuclear reactors:** Control rods (Gd, Sm absorb neutrons)
    6. **Steel making:** Improve properties

    ### Actinoids:
    1. **Nuclear fuel:** U-235, Pu-239 (fission reactions)
    2. **Nuclear weapons:** Pu-239
    3. **Radiotherapy:** Cancer treatment
    4. **Smoke detectors:** Am-241
    5. **Research:** Radioisotopes for dating, tracing

    ---

    ## IIT JEE Key Points

    1. **Lanthanoids:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s², **Actinoids:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²
    2. **Lanthanoid contraction:** Gradual decrease in size due to poor shielding by 4f
    3. **Consequence:** 4d and 5d elements have similar sizes and properties
    4. **Lanthanoids:** Mainly +3 oxidation state
    5. **Actinoids:** Variable oxidation states (+3 to +7), all radioactive
    6. **Actinoids show more oxidation states** because 5f, 6d, 7s have comparable energies
    7. **Complex formation:** Actinoids > Lanthanoids
    8. **La³⁺ and Lu³⁺ are colorless** (f⁰ and f¹⁴ respectively)
    9. **Only Th, Pa, U occur naturally** among actinoids
    10. **Transuranium elements** (Z > 92) are all synthetic and radioactive

## Key Points

- f-block elements

- Lanthanoids

- Actinoids
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['f-block elements', 'Lanthanoids', 'Actinoids', 'Lanthanoid contraction', 'Radioactivity', 'Comparison'],
  prerequisite_ids: []
)

# === MICROLESSON 3: d-Block Elements - Electronic Configuration and General Properties ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'd-Block Elements - Electronic Configuration and General Properties',
  content: <<~MARKDOWN,
# d-Block Elements - Electronic Configuration and General Properties 🚀

# d-Block Elements: Transition Elements

    ## Introduction

    **d-block elements** are elements in which the last electron enters the d-orbital of the penultimate (second last) shell.

    **Position in Periodic Table:**
    - Groups 3 to 12
    - Four series: 3d, 4d, 5d, and 6d
    - Located between s-block and p-block elements

    ---

    ## Electronic Configuration

    ### General Electronic Configuration
    ```
    (n-1)d¹⁻¹⁰ ns¹⁻²
    ```

    Where:
    - n = outermost shell
    - (n-1) = penultimate shell

    ### 3d Series (Sc to Zn)

    | Element | Atomic No. | Electronic Configuration | Exceptional? |
    |---------|------------|-------------------------|--------------|
    | Sc | 21 | [Ar] 3d¹ 4s² | No |
    | Ti | 22 | [Ar] 3d² 4s² | No |
    | V | 23 | [Ar] 3d³ 4s² | No |
    | Cr | 24 | [Ar] 3d⁵ 4s¹ | ✓ Exception |
    | Mn | 25 | [Ar] 3d⁵ 4s² | No |
    | Fe | 26 | [Ar] 3d⁶ 4s² | No |
    | Co | 27 | [Ar] 3d⁷ 4s² | No |
    | Ni | 28 | [Ar] 3d⁸ 4s² | No |
    | Cu | 29 | [Ar] 3d¹⁰ 4s¹ | ✓ Exception |
    | Zn | 30 | [Ar] 3d¹⁰ 4s² | No |

    **Exceptions:**
    - **Chromium (Cr):** 3d⁵ 4s¹ (not 3d⁴ 4s²)
    - **Copper (Cu):** 3d¹⁰ 4s¹ (not 3d⁹ 4s²)

    **Reason:** Extra stability of half-filled (d⁵) and fully-filled (d¹⁰) orbitals

    ---

    ## Transition Elements vs d-Block Elements

    ### Transition Elements
    **Definition:** Elements with **partially filled d-orbitals** in their ground state or common oxidation states

    **Includes:**
    - Sc to Mn (3d¹ to 3d⁵)
    - Fe to Cu (3d⁶ to 3d¹⁰)

    **Excludes:**
    - **Zinc (Zn):** 3d¹⁰ 4s² → Zn²⁺: 3d¹⁰ (fully filled d-orbitals)
    - **Cd, Hg:** Similar reasons

    **Note:** All transition elements are d-block elements, but not all d-block elements are transition elements

    ---

    ## General Characteristics of Transition Elements

    ### 1. Metallic Character
    - **All are metals**
    - High melting and boiling points (except Zn, Cd, Hg)
    - Good conductors of heat and electricity
    - Hard and strong (due to metallic bonding involving d-electrons)

    ### 2. Atomic and Ionic Radii
    - **Decrease across period** (increasing nuclear charge)
    - Decrease is small compared to s and p block elements
    - **Lanthanoid contraction** affects 5d series

    ### 3. Ionization Enthalpy
    - **Increases gradually** across the period
    - Higher than s-block, lower than p-block elements
    - **Reason:** Effective nuclear charge increases, shielding by d-electrons is less effective

    ### 4. Metallic Character and Density
    - High density (d-electrons contribute to metallic bonding)
    - **Order:** Osmium (Os) > Iridium (Ir) > Platinum (Pt)
    - **Osmium** is the densest element (22.6 g/cm³)

    ---

    ## Variable Oxidation States

    **Key Feature:** Transition elements show **multiple oxidation states**

    ### Reasons:
    1. **Small energy difference** between (n-1)d and ns orbitals
    2. Both d and s electrons can participate in bonding
    3. Different numbers of electrons can be lost

    ### Common Oxidation States (3d Series)

    | Element | Common Oxidation States | Most Stable |
    |---------|------------------------|-------------|
    | Sc | +3 | +3 |
    | Ti | +2, +3, +4 | +4 |
    | V | +2, +3, +4, +5 | +5 |
    | Cr | +2, +3, +6 | +3, +6 |
    | Mn | +2, +3, +4, +6, +7 | +2, +7 |
    | Fe | +2, +3 | +3 |
    | Co | +2, +3 | +2 |
    | Ni | +2, +3, +4 | +2 |
    | Cu | +1, +2 | +2 |
    | Zn | +2 | +2 |

    ### Trends:
    - **Maximum oxidation state** = Group number (up to Mn)
    - **Higher oxidation states** are more common in early transition metals
    - **+2 oxidation state** is most common (loss of 4s² electrons)
    - **Stability of higher oxidation states** decreases across period

    ---

    ## Magnetic Properties

    ### Paramagnetic vs Diamagnetic

    **Paramagnetic:**
    - **Unpaired electrons** present
    - Attracted by magnetic field
    - **Most transition metal compounds** are paramagnetic

    **Diamagnetic:**
    - **No unpaired electrons**
    - Repelled by magnetic field
    - Examples: Zn²⁺ (3d¹⁰), Cu⁺ (3d¹⁰), Sc³⁺ (3d⁰)

    ### Magnetic Moment (μ)

    **Formula:**
    ```
    μ = √[n(n+2)] BM (Bohr Magneton)
    ```

    Where n = number of unpaired electrons

    **Examples:**
    - Fe²⁺ (3d⁶): 4 unpaired electrons → μ = √[4(4+2)] = √24 = 4.9 BM
    - Cu²⁺ (3d⁹): 1 unpaired electron → μ = √[1(1+2)] = √3 = 1.73 BM
    - Zn²⁺ (3d¹⁰): 0 unpaired electrons → μ = 0 BM (diamagnetic)

    ---

    ## Formation of Colored Compounds

    **Most transition metal compounds are colored**

    ### Reason: d-d Transitions
    1. **d-orbitals split** in the presence of ligands (crystal field splitting)
    2. **Electrons absorb visible light** and jump from lower to higher d-orbitals
    3. **Complementary color** is observed

    ### Examples:

    | Compound | Color | Ion | d-electrons |
    |----------|-------|-----|-------------|
    | CuSO₄·5H₂O | Blue | Cu²⁺ | d⁹ |
    | FeSO₄·7H₂O | Green | Fe²⁺ | d⁶ |
    | KMnO₄ | Purple | MnO₄⁻ | d⁰* |
    | K₂Cr₂O₇ | Orange | Cr₂O₇²⁻ | d⁰* |

    *MnO₄⁻ and Cr₂O₇²⁻ are colored due to charge transfer, not d-d transitions

    ### Colorless Compounds:
    - **d⁰ configuration:** Sc³⁺, Ti⁴⁺ (no d-electrons)
    - **d¹⁰ configuration:** Zn²⁺, Cu⁺ (no d-d transitions possible)

    ---

    ## Catalytic Properties

    **Transition metals and their compounds act as excellent catalysts**

    ### Reasons:
    1. **Variable oxidation states** - can accept/donate electrons
    2. **Large surface area** - provide surface for adsorption
    3. **Formation of intermediate compounds** with reactants

    ### Examples:

    | Catalyst | Reaction | Process |
    |----------|----------|---------|
    | Fe | N₂ + 3H₂ → 2NH₃ | Haber process |
    | Ni | Vegetable oil + H₂ → Vanaspati | Hydrogenation |
    | V₂O₅ | 2SO₂ + O₂ → 2SO₃ | Contact process |
    | Pt | 4NH₃ + 5O₂ → 4NO + 6H₂O | Ostwald process |
    | MnO₂ | 2KClO₃ → 2KCl + 3O₂ | Decomposition |

    ---

    ## Complex Formation (Coordination Compounds)

    **Transition metals readily form complexes**

    ### Reasons:
    1. **Small size and high charge** - high charge density
    2. **Availability of vacant d-orbitals** for accepting electron pairs
    3. **Variable oxidation states**

    ### Examples:
    - [Fe(CN)₆]⁴⁻ - Hexacyanoferrate(II)
    - [Cu(NH₃)₄]²⁺ - Tetraamminecopper(II)
    - [Ni(CO)₄] - Nickel tetracarbonyl

    ---

    ## Interstitial Compounds

    **Compounds formed when small atoms (H, B, C, N) occupy interstitial sites in metal lattice**

    ### Properties:
    - **Non-stoichiometric** (variable composition)
    - **Harder than parent metal**
    - **Higher melting point**
    - **Chemically inert**

    ### Examples:
    - TiH₁.₇, VH₀.₅₆
    - TiC, Fe₃C (steel)
    - TiN, Mn₄N

    ---

    ## Alloy Formation

    **Transition metals form alloys with each other and with other metals**

    ### Reason:
    - Similar atomic sizes
    - Similar crystal structures

    ### Important Alloys:
    - **Steel:** Fe + C (+ Cr, Ni, etc.)
    - **Brass:** Cu + Zn
    - **Bronze:** Cu + Sn
    - **Stainless steel:** Fe + Cr + Ni

    ---

    ## IIT JEE Key Points

    1. **Electronic configuration:** (n-1)d¹⁻¹⁰ ns¹⁻²
    2. **Exceptions:** Cr (3d⁵ 4s¹), Cu (3d¹⁰ 4s¹) - half-filled and fully-filled stability
    3. **Zn, Cd, Hg are NOT transition elements** (d¹⁰ configuration)
    4. **Variable oxidation states** due to close energy of ns and (n-1)d orbitals
    5. **Magnetic moment:** μ = √[n(n+2)] BM, where n = unpaired electrons
    6. **Colored compounds:** d-d transitions (except d⁰ and d¹⁰)
    7. **Paramagnetic** if unpaired electrons present
    8. **Good catalysts** due to variable oxidation states
    9. **Maximum oxidation state** = Group number (up to Mn, group 7)
    10. **+2 is most common oxidation state** (loss of ns² electrons)

## Key Points

- d-block elements

- Electronic configuration

- Transition elements
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['d-block elements', 'Electronic configuration', 'Transition elements', 'General characteristics', 'Oxidation states'],
  prerequisite_ids: []
)

# === MICROLESSON 4: f-Block Elements - Lanthanoids and Actinoids ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'f-Block Elements - Lanthanoids and Actinoids',
  content: <<~MARKDOWN,
# f-Block Elements - Lanthanoids and Actinoids 🚀

# f-Block Elements: Inner Transition Elements

    ## Introduction

    **f-block elements** are elements in which the last electron enters the f-orbital of the ante-penultimate (third last) shell.

    **General Electronic Configuration:**
    ```
    (n-2)f¹⁻¹⁴ (n-1)d⁰⁻¹ ns²
    ```

    **Two Series:**
    1. **Lanthanoids (4f series):** Ce (58) to Lu (71)
    2. **Actinoids (5f series):** Th (90) to Lr (103)

    **Position in Periodic Table:**
    - Placed separately below main periodic table
    - Also called **inner transition elements**

    ---

    ## Lanthanoids (Rare Earth Elements)

    ### Electronic Configuration

    **General configuration:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s²

    | Element | Symbol | Atomic No. | 4f electrons |
    |---------|--------|------------|--------------|
    | Lanthanum | La | 57 | 4f⁰ 5d¹ 6s² |
    | Cerium | Ce | 58 | 4f² 6s² |
    | Praseodymium | Pr | 59 | 4f³ 6s² |
    | Neodymium | Nd | 60 | 4f⁴ 6s² |
    | Promethium | Pm | 61 | 4f⁵ 6s² |
    | Samarium | Sm | 62 | 4f⁶ 6s² |
    | Europium | Eu | 63 | 4f⁷ 6s² |
    | Gadolinium | Gd | 64 | 4f⁷ 5d¹ 6s² |
    | Terbium | Tb | 65 | 4f⁹ 6s² |
    | Dysprosium | Dy | 66 | 4f¹⁰ 6s² |
    | Holmium | Ho | 67 | 4f¹¹ 6s² |
    | Erbium | Er | 68 | 4f¹² 6s² |
    | Thulium | Tm | 69 | 4f¹³ 6s² |
    | Ytterbium | Yb | 70 | 4f¹⁴ 6s² |
    | Lutetium | Lu | 71 | 4f¹⁴ 5d¹ 6s² |

    **Note:** La and Gd have exceptional configurations with one electron in 5d orbital

    ---

    ## Lanthanoid Contraction

    ### Definition
    **Lanthanoid contraction** is the gradual decrease in atomic and ionic radii of lanthanoids with increasing atomic number.

    ### Cause
    1. **Imperfect shielding** by 4f electrons
    2. Nuclear charge increases by +1 at each step
    3. Effective nuclear charge increases
    4. Electrons are pulled closer to nucleus

    **Magnitude:** Total decrease from La³⁺ to Lu³⁺ ≈ 11 pm (0.11 Å)

    ### Consequences of Lanthanoid Contraction

    #### 1. Similarity in Properties
    - Lanthanoids have very similar chemical properties
    - Difficult to separate (ion exchange method used)

    #### 2. Effect on 5d Series
    - Atomic radii of 4d and 5d elements are nearly same
    - Example: Zr (160 pm) ≈ Hf (159 pm)
    - Chemical properties of 4d and 5d elements are similar

    #### 3. Basicity Decrease
    - Basicity of hydroxides decreases from La(OH)₃ to Lu(OH)₃
    - Reason: Ionic radius decreases, covalent character increases

    #### 4. Complex Formation
    - Tendency to form complexes increases
    - Smaller size → Higher charge density → Stronger complexation

    ---

    ## Properties of Lanthanoids

    ### 1. Physical Properties

    **Metallic Character:**
    - All are silvery-white metals
    - Soft, malleable, and ductile
    - Tarnish rapidly in air

    **Melting and Boiling Points:**
    - High melting points (800-1600°C)
    - Lower than d-block transition metals

    ### 2. Oxidation States

    **Most common oxidation state:** +3

    **Reason:**
    - Loss of two 6s electrons and one 4f or 5d electron
    - Ln³⁺ configuration is very stable

    **Some show +2 and +4:**
    - **Eu²⁺ and Yb²⁺:** Extra stability of half-filled (f⁷) and fully-filled (f¹⁴)
    - **Ce⁴⁺ and Tb⁴⁺:** Extra stability of empty (f⁰) and half-filled (f⁷)

    ### 3. Magnetic Properties

    - **All lanthanoid ions are paramagnetic** (except La³⁺ and Lu³⁺)
    - Reason: Unpaired f-electrons
    - **Magnetic moment depends on number of unpaired electrons**

    ### 4. Colored Ions

    - Most Ln³⁺ ions are **colored**
    - Reason: f-f transitions (similar to d-d transitions)
    - **Exceptions:** La³⁺ (f⁰) and Lu³⁺ (f¹⁴) are colorless

    ### 5. Chemical Reactivity

    - **Highly electropositive** (like alkaline earth metals)
    - React with water: 2Ln + 6H₂O → 2Ln(OH)₃ + 3H₂
    - Combine with halogens: 2Ln + 3X₂ → 2LnX₃
    - React with acids: 2Ln + 6H⁺ → 2Ln³⁺ + 3H₂

    ---

    ## Actinoids

    ### Electronic Configuration

    **General configuration:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²

    | Element | Symbol | Atomic No. | Notable |
    |---------|--------|------------|---------|
    | Actinium | Ac | 89 | 5f⁰ 6d¹ 7s² |
    | Thorium | Th | 90 | Natural |
    | Protactinium | Pa | 91 | Natural |
    | Uranium | U | 92 | Natural, fissile |
    | Neptunium | Np | 93 | First transuranium |
    | Plutonium | Pu | 94 | Fissile |
    | Americium | Am | 95 | Transuranic |
    | ... | ... | ... | ... |
    | Lawrencium | Lr | 103 | Last actinoid |

    **Note:**
    - Elements beyond U (92) are **transuranium elements** (all radioactive)
    - Only Th, Pa, and U occur naturally
    - All actinoids are **radioactive**

    ---

    ## Properties of Actinoids

    ### 1. Radioactivity
    - **All actinoids are radioactive**
    - Heavy nuclei undergo radioactive decay
    - Emit α, β, and γ radiations

    ### 2. Oxidation States
    - Show **variable oxidation states**
    - Range: +3 to +7
    - Common: +3, +4, +5, +6

    **Examples:**
    - U: +3, +4, +5, +6
    - Pu: +3, +4, +5, +6
    - Np: +3, +4, +5, +6, +7

    **Greater variability than lanthanoids** (5f orbitals have higher energy)

    ### 3. Actinoid Contraction
    - Similar to lanthanoid contraction
    - Ionic radii decrease across series
    - Due to poor shielding by 5f electrons

    ### 4. Magnetic Properties
    - **Highly paramagnetic**
    - Due to large number of unpaired 5f electrons

    ### 5. Complex Formation
    - **Greater tendency to form complexes** than lanthanoids
    - Due to higher charge and smaller size

    ---

    ## Comparison: Lanthanoids vs Actinoids

    | Property | Lanthanoids | Actinoids |
    |----------|-------------|-----------|
    | **Orbitals filled** | 4f | 5f |
    | **Radioactivity** | Non-radioactive (except Pm) | All radioactive |
    | **Oxidation states** | Mainly +3 | +3, +4, +5, +6, +7 (variable) |
    | **Binding energy** | Higher | Lower |
    | **Magnetic moment** | Lower | Higher |
    | **Complex formation** | Less tendency | Greater tendency |
    | **Occurrence** | Natural (except Pm) | Only Th, Pa, U natural |
    | **Chemical reactivity** | Less reactive | More reactive |
    | **Color intensity** | Less intense | More intense |

    ### Why More Oxidation States in Actinoids?
    - **5f, 6d, and 7s orbitals** have comparable energies
    - All three can participate in bonding
    - **4f orbitals** in lanthanoids are deeply buried (less available)

    ---

    ## Uses of Lanthanoids and Actinoids

    ### Lanthanoids:
    1. **Mixed oxide catalysts:** Petroleum cracking
    2. **Glass industry:** Coloring and polishing
    3. **Phosphors:** Television screens, LEDs
    4. **Magnets:** NdFeB (neodymium) magnets - strongest permanent magnets
    5. **Nuclear reactors:** Control rods (Gd, Sm absorb neutrons)
    6. **Steel making:** Improve properties

    ### Actinoids:
    1. **Nuclear fuel:** U-235, Pu-239 (fission reactions)
    2. **Nuclear weapons:** Pu-239
    3. **Radiotherapy:** Cancer treatment
    4. **Smoke detectors:** Am-241
    5. **Research:** Radioisotopes for dating, tracing

    ---

    ## IIT JEE Key Points

    1. **Lanthanoids:** [Xe] 4f¹⁻¹⁴ 5d⁰⁻¹ 6s², **Actinoids:** [Rn] 5f¹⁻¹⁴ 6d⁰⁻¹ 7s²
    2. **Lanthanoid contraction:** Gradual decrease in size due to poor shielding by 4f
    3. **Consequence:** 4d and 5d elements have similar sizes and properties
    4. **Lanthanoids:** Mainly +3 oxidation state
    5. **Actinoids:** Variable oxidation states (+3 to +7), all radioactive
    6. **Actinoids show more oxidation states** because 5f, 6d, 7s have comparable energies
    7. **Complex formation:** Actinoids > Lanthanoids
    8. **La³⁺ and Lu³⁺ are colorless** (f⁰ and f¹⁴ respectively)
    9. **Only Th, Pa, U occur naturally** among actinoids
    10. **Transuranium elements** (Z > 92) are all synthetic and radioactive

## Key Points

- f-block elements

- Lanthanoids

- Actinoids
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['f-block elements', 'Lanthanoids', 'Actinoids', 'Lanthanoid contraction', 'Radioactivity', 'Comparison'],
  prerequisite_ids: []
)

# === MICROLESSON 5: electronic_configuration — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'electronic_configuration — Practice',
  content: <<~MARKDOWN,
# electronic_configuration — Practice 🚀

Chromium has exceptional configuration [Ar] 3d⁵ 4s¹ instead of expected 3d⁴ 4s² due to extra stability of half-filled d-orbital (d⁵).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['electronic_configuration'],
  prerequisite_ids: []
)

# === MICROLESSON 6: transition_elements — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'transition_elements — Practice',
  content: <<~MARKDOWN,
# transition_elements — Practice 🚀

Zn (3d¹⁰ 4s²) and Cd (4d¹⁰ 5s²) are not transition elements because they have fully filled d-orbitals in both ground state and common oxidation states (+2). Sc and Fe have partially filled d-orbitals.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['transition_elements'],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are NOT considered transition elements?',
    options: ['Zinc (Zn)', 'Scandium (Sc)', 'Cadmium (Cd)', 'Iron (Fe)'],
    correct_answer: 2,
    explanation: 'Zn (3d¹⁰ 4s²) and Cd (4d¹⁰ 5s²) are not transition elements because they have fully filled d-orbitals in both ground state and common oxidation states (+2). Sc and Fe have partially filled d-orbitals.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 7: magnetic_properties — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'magnetic_properties — Practice',
  content: <<~MARKDOWN,
# magnetic_properties — Practice 🚀

Fe²⁺ has configuration 3d⁶ with 4 unpaired electrons (↑ ↑ ↑ ↑ ↑↓). Using μ = √[n(n+2)] = √[4(4+2)] = √24 = 4.9 BM.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['magnetic_properties'],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the magnetic moment (in BM) of Fe²⁺ ion (3d⁶ configuration). Use the formula μ = √[n(n+2)] where n = number of unpaired electrons. Round to 1 decimal place.',
    answer: '',
    explanation: 'Fe²⁺ has configuration 3d⁶ with 4 unpaired electrons (↑ ↑ ↑ ↑ ↑↓). Using μ = √[n(n+2)] = √[4(4+2)] = √24 = 4.9 BM.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: oxidation_states — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_states — Practice',
  content: <<~MARKDOWN,
# oxidation_states — Practice 🚀

Manganese shows maximum oxidation states: +2, +3, +4, +6, +7. It can use all seven electrons (3d⁵ 4s²) for bonding. Common examples: Mn²⁺, MnO₂ (+4), MnO₄⁻ (+7).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['oxidation_states'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which element shows the maximum number of oxidation states in the 3d series?',
    options: ['Scandium (Sc)', 'Manganese (Mn)', 'Iron (Fe)', 'Zinc (Zn)'],
    correct_answer: 1,
    explanation: 'Manganese shows maximum oxidation states: +2, +3, +4, +6, +7. It can use all seven electrons (3d⁵ 4s²) for bonding. Common examples: Mn²⁺, MnO₂ (+4), MnO₄⁻ (+7).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: colored_compounds — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'colored_compounds — Practice',
  content: <<~MARKDOWN,
# colored_compounds — Practice 🚀

Zn²⁺ is colorless because it has d¹⁰ configuration (fully filled d-orbitals). No d-d transitions are possible. Cu²⁺ (blue), Fe²⁺ (green), and Ni²⁺ (green) are colored due to d-d transitions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['colored_compounds'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following ions is colorless in aqueous solution?',
    options: ['Cu²⁺ (3d⁹)', 'Fe²⁺ (3d⁶)', 'Zn²⁺ (3d¹⁰)', 'Ni²⁺ (3d⁸)'],
    correct_answer: 2,
    explanation: 'Zn²⁺ is colorless because it has d¹⁰ configuration (fully filled d-orbitals). No d-d transitions are possible. Cu²⁺ (blue), Fe²⁺ (green), and Ni²⁺ (green) are colored due to d-d transitions.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: catalytic_properties — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'catalytic_properties — Practice',
  content: <<~MARKDOWN,
# catalytic_properties — Practice 🚀

Transition metals are good catalysts due to: (1) Variable oxidation states - can accept/donate electrons, (2) Large surface area for adsorption, (3) Ability to form intermediates. They are NOT inert - they participate in reaction.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['catalytic_properties'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which properties make transition metals good catalysts?',
    options: ['Variable oxidation states', 'Ability to provide large surface area for adsorption', 'Formation of intermediate compounds', 'Complete inertness to reactants'],
    correct_answer: 2,
    explanation: 'Transition metals are good catalysts due to: (1) Variable oxidation states - can accept/donate electrons, (2) Large surface area for adsorption, (3) Ability to form intermediates. They are NOT inert - they participate in reaction.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 11: lanthanoid_contraction — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'lanthanoid_contraction — Practice',
  content: <<~MARKDOWN,
# lanthanoid_contraction — Practice 🚀

Lanthanoid contraction occurs due to imperfect/poor shielding by 4f electrons. As nuclear charge increases, effective nuclear charge increases, pulling electrons closer.

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

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Lanthanoid contraction is caused by:',
    options: ['Perfect shielding by 4f electrons', 'Imperfect shielding by 4f electrons', 'Complete absence of 4f electrons', 'Large size of lanthanoid atoms'],
    correct_answer: 1,
    explanation: 'Lanthanoid contraction occurs due to imperfect/poor shielding by 4f electrons. As nuclear charge increases, effective nuclear charge increases, pulling electrons closer.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: lanthanoid_contraction — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'lanthanoid_contraction — Practice',
  content: <<~MARKDOWN,
# lanthanoid_contraction — Practice 🚀

Lanthanoid contraction causes: (1) Similar properties of lanthanoids, (2) Similar sizes of 4d and 5d elements (Zr≈Hf), (3) Decreased basicity (not increase), (4) Increased complex formation.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['lanthanoid_contraction'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which are consequences of lanthanoid contraction?',
    options: ['Similarity in properties of lanthanoids', 'Similar atomic radii of 4d and 5d elements', 'Increase in basicity from La(OH)₃ to Lu(OH)₃', 'Increased tendency to form complexes'],
    correct_answer: 3,
    explanation: 'Lanthanoid contraction causes: (1) Similar properties of lanthanoids, (2) Similar sizes of 4d and 5d elements (Zr≈Hf), (3) Decreased basicity (not increase), (4) Increased complex formation.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 13: oxidation_states — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_states — Practice',
  content: <<~MARKDOWN,
# oxidation_states — Practice 🚀

Most common oxidation state of lanthanoids is +3 (Ln³⁺). This results from loss of two 6s electrons and one 4f/5d electron. Some show +2 (Eu, Yb) or +4 (Ce, Tb) due to stability of specific f-configurations.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['oxidation_states'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The most common oxidation state of lanthanoids is:',
    options: ['+2', '+3', '+4', '+5'],
    correct_answer: 1,
    explanation: 'Most common oxidation state of lanthanoids is +3 (Ln³⁺). This results from loss of two 6s electrons and one 4f/5d electron. Some show +2 (Eu, Yb) or +4 (Ce, Tb) due to stability of specific f-configurations.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 14: actinoids_vs_lanthanoids — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'actinoids_vs_lanthanoids — Practice',
  content: <<~MARKDOWN,
# actinoids_vs_lanthanoids — Practice 🚀

Actinoids show oxidation states from +3 to +7 because 5f, 6d, and 7s orbitals have comparable energies and can all participate in bonding. In lanthanoids, 4f orbitals are deeply buried and less available.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['actinoids_vs_lanthanoids'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why do actinoids show greater range of oxidation states compared to lanthanoids?',
    options: ['Actinoids have smaller atomic size', '5f, 6d, and 7s orbitals have comparable energies', 'Actinoids have no radioactivity', '4f orbitals are more available for bonding'],
    correct_answer: 1,
    explanation: 'Actinoids show oxidation states from +3 to +7 because 5f, 6d, and 7s orbitals have comparable energies and can all participate in bonding. In lanthanoids, 4f orbitals are deeply buried and less available.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 15: colored_ions — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'colored_ions — Practice',
  content: <<~MARKDOWN,
# colored_ions — Practice 🚀

La³⁺ (f⁰) and Lu³⁺ (f¹⁴) are colorless because they have no f-electrons or fully-filled f-orbitals. No f-f transitions are possible. Other Ln³⁺ ions are colored due to f-f transitions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['colored_ions'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which lanthanoid ions are colorless?',
    options: ['La³⁺ (f⁰)', 'Ce³⁺ (f¹)', 'Eu³⁺ (f⁶)', 'Lu³⁺ (f¹⁴)'],
    correct_answer: 3,
    explanation: 'La³⁺ (f⁰) and Lu³⁺ (f¹⁴) are colorless because they have no f-electrons or fully-filled f-orbitals. No f-f transitions are possible. Other Ln³⁺ ions are colored due to f-f transitions.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 16: d-Block Elements - Electronic Configuration and General Properties ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'd-Block Elements - Electronic Configuration and General Properties',
  content: <<~MARKDOWN,
# d-Block Elements - Electronic Configuration and General Properties 🚀

# d-Block Elements: Transition Elements

    ## Introduction

    **d-block elements** are elements in which the last electron enters the d-orbital of the penultimate (second last) shell.

    **Position in Periodic Table:**
    - Groups 3 to 12
    - Four series: 3d, 4d, 5d, and 6d
    - Located between s-block and p-block elements

    ---

    ## Electronic Configuration

    ### General Electronic Configuration
    ```
    (n-1)d¹⁻¹⁰ ns¹⁻²
    ```

    Where:
    - n = outermost shell
    - (n-1) = penultimate shell

    ### 3d Series (Sc to Zn)

    | Element | Atomic No. | Electronic Configuration | Exceptional? |
    |---------|------------|-------------------------|--------------|
    | Sc | 21 | [Ar] 3d¹ 4s² | No |
    | Ti | 22 | [Ar] 3d² 4s² | No |
    | V | 23 | [Ar] 3d³ 4s² | No |
    | Cr | 24 | [Ar] 3d⁵ 4s¹ | ✓ Exception |
    | Mn | 25 | [Ar] 3d⁵ 4s² | No |
    | Fe | 26 | [Ar] 3d⁶ 4s² | No |
    | Co | 27 | [Ar] 3d⁷ 4s² | No |
    | Ni | 28 | [Ar] 3d⁸ 4s² | No |
    | Cu | 29 | [Ar] 3d¹⁰ 4s¹ | ✓ Exception |
    | Zn | 30 | [Ar] 3d¹⁰ 4s² | No |

    **Exceptions:**
    - **Chromium (Cr):** 3d⁵ 4s¹ (not 3d⁴ 4s²)
    - **Copper (Cu):** 3d¹⁰ 4s¹ (not 3d⁹ 4s²)

    **Reason:** Extra stability of half-filled (d⁵) and fully-filled (d¹⁰) orbitals

    ---

    ## Transition Elements vs d-Block Elements

    ### Transition Elements
    **Definition:** Elements with **partially filled d-orbitals** in their ground state or common oxidation states

    **Includes:**
    - Sc to Mn (3d¹ to 3d⁵)
    - Fe to Cu (3d⁶ to 3d¹⁰)

    **Excludes:**
    - **Zinc (Zn):** 3d¹⁰ 4s² → Zn²⁺: 3d¹⁰ (fully filled d-orbitals)
    - **Cd, Hg:** Similar reasons

    **Note:** All transition elements are d-block elements, but not all d-block elements are transition elements

    ---

    ## General Characteristics of Transition Elements

    ### 1. Metallic Character
    - **All are metals**
    - High melting and boiling points (except Zn, Cd, Hg)
    - Good conductors of heat and electricity
    - Hard and strong (due to metallic bonding involving d-electrons)

    ### 2. Atomic and Ionic Radii
    - **Decrease across period** (increasing nuclear charge)
    - Decrease is small compared to s and p block elements
    - **Lanthanoid contraction** affects 5d series

    ### 3. Ionization Enthalpy
    - **Increases gradually** across the period
    - Higher than s-block, lower than p-block elements
    - **Reason:** Effective nuclear charge increases, shielding by d-electrons is less effective

    ### 4. Metallic Character and Density
    - High density (d-electrons contribute to metallic bonding)
    - **Order:** Osmium (Os) > Iridium (Ir) > Platinum (Pt)
    - **Osmium** is the densest element (22.6 g/cm³)

    ---

    ## Variable Oxidation States

    **Key Feature:** Transition elements show **multiple oxidation states**

    ### Reasons:
    1. **Small energy difference** between (n-1)d and ns orbitals
    2. Both d and s electrons can participate in bonding
    3. Different numbers of electrons can be lost

    ### Common Oxidation States (3d Series)

    | Element | Common Oxidation States | Most Stable |
    |---------|------------------------|-------------|
    | Sc | +3 | +3 |
    | Ti | +2, +3, +4 | +4 |
    | V | +2, +3, +4, +5 | +5 |
    | Cr | +2, +3, +6 | +3, +6 |
    | Mn | +2, +3, +4, +6, +7 | +2, +7 |
    | Fe | +2, +3 | +3 |
    | Co | +2, +3 | +2 |
    | Ni | +2, +3, +4 | +2 |
    | Cu | +1, +2 | +2 |
    | Zn | +2 | +2 |

    ### Trends:
    - **Maximum oxidation state** = Group number (up to Mn)
    - **Higher oxidation states** are more common in early transition metals
    - **+2 oxidation state** is most common (loss of 4s² electrons)
    - **Stability of higher oxidation states** decreases across period

    ---

    ## Magnetic Properties

    ### Paramagnetic vs Diamagnetic

    **Paramagnetic:**
    - **Unpaired electrons** present
    - Attracted by magnetic field
    - **Most transition metal compounds** are paramagnetic

    **Diamagnetic:**
    - **No unpaired electrons**
    - Repelled by magnetic field
    - Examples: Zn²⁺ (3d¹⁰), Cu⁺ (3d¹⁰), Sc³⁺ (3d⁰)

    ### Magnetic Moment (μ)

    **Formula:**
    ```
    μ = √[n(n+2)] BM (Bohr Magneton)
    ```

    Where n = number of unpaired electrons

    **Examples:**
    - Fe²⁺ (3d⁶): 4 unpaired electrons → μ = √[4(4+2)] = √24 = 4.9 BM
    - Cu²⁺ (3d⁹): 1 unpaired electron → μ = √[1(1+2)] = √3 = 1.73 BM
    - Zn²⁺ (3d¹⁰): 0 unpaired electrons → μ = 0 BM (diamagnetic)

    ---

    ## Formation of Colored Compounds

    **Most transition metal compounds are colored**

    ### Reason: d-d Transitions
    1. **d-orbitals split** in the presence of ligands (crystal field splitting)
    2. **Electrons absorb visible light** and jump from lower to higher d-orbitals
    3. **Complementary color** is observed

    ### Examples:

    | Compound | Color | Ion | d-electrons |
    |----------|-------|-----|-------------|
    | CuSO₄·5H₂O | Blue | Cu²⁺ | d⁹ |
    | FeSO₄·7H₂O | Green | Fe²⁺ | d⁶ |
    | KMnO₄ | Purple | MnO₄⁻ | d⁰* |
    | K₂Cr₂O₇ | Orange | Cr₂O₇²⁻ | d⁰* |

    *MnO₄⁻ and Cr₂O₇²⁻ are colored due to charge transfer, not d-d transitions

    ### Colorless Compounds:
    - **d⁰ configuration:** Sc³⁺, Ti⁴⁺ (no d-electrons)
    - **d¹⁰ configuration:** Zn²⁺, Cu⁺ (no d-d transitions possible)

    ---

    ## Catalytic Properties

    **Transition metals and their compounds act as excellent catalysts**

    ### Reasons:
    1. **Variable oxidation states** - can accept/donate electrons
    2. **Large surface area** - provide surface for adsorption
    3. **Formation of intermediate compounds** with reactants

    ### Examples:

    | Catalyst | Reaction | Process |
    |----------|----------|---------|
    | Fe | N₂ + 3H₂ → 2NH₃ | Haber process |
    | Ni | Vegetable oil + H₂ → Vanaspati | Hydrogenation |
    | V₂O₅ | 2SO₂ + O₂ → 2SO₃ | Contact process |
    | Pt | 4NH₃ + 5O₂ → 4NO + 6H₂O | Ostwald process |
    | MnO₂ | 2KClO₃ → 2KCl + 3O₂ | Decomposition |

    ---

    ## Complex Formation (Coordination Compounds)

    **Transition metals readily form complexes**

    ### Reasons:
    1. **Small size and high charge** - high charge density
    2. **Availability of vacant d-orbitals** for accepting electron pairs
    3. **Variable oxidation states**

    ### Examples:
    - [Fe(CN)₆]⁴⁻ - Hexacyanoferrate(II)
    - [Cu(NH₃)₄]²⁺ - Tetraamminecopper(II)
    - [Ni(CO)₄] - Nickel tetracarbonyl

    ---

    ## Interstitial Compounds

    **Compounds formed when small atoms (H, B, C, N) occupy interstitial sites in metal lattice**

    ### Properties:
    - **Non-stoichiometric** (variable composition)
    - **Harder than parent metal**
    - **Higher melting point**
    - **Chemically inert**

    ### Examples:
    - TiH₁.₇, VH₀.₅₆
    - TiC, Fe₃C (steel)
    - TiN, Mn₄N

    ---

    ## Alloy Formation

    **Transition metals form alloys with each other and with other metals**

    ### Reason:
    - Similar atomic sizes
    - Similar crystal structures

    ### Important Alloys:
    - **Steel:** Fe + C (+ Cr, Ni, etc.)
    - **Brass:** Cu + Zn
    - **Bronze:** Cu + Sn
    - **Stainless steel:** Fe + Cr + Ni

    ---

    ## IIT JEE Key Points

    1. **Electronic configuration:** (n-1)d¹⁻¹⁰ ns¹⁻²
    2. **Exceptions:** Cr (3d⁵ 4s¹), Cu (3d¹⁰ 4s¹) - half-filled and fully-filled stability
    3. **Zn, Cd, Hg are NOT transition elements** (d¹⁰ configuration)
    4. **Variable oxidation states** due to close energy of ns and (n-1)d orbitals
    5. **Magnetic moment:** μ = √[n(n+2)] BM, where n = unpaired electrons
    6. **Colored compounds:** d-d transitions (except d⁰ and d¹⁰)
    7. **Paramagnetic** if unpaired electrons present
    8. **Good catalysts** due to variable oxidation states
    9. **Maximum oxidation state** = Group number (up to Mn, group 7)
    10. **+2 is most common oxidation state** (loss of ns² electrons)

## Key Points

- d-block elements

- Electronic configuration

- Transition elements
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['d-block elements', 'Electronic configuration', 'Transition elements', 'General characteristics', 'Oxidation states'],
  prerequisite_ids: []
)

puts "✓ Created 16 microlessons for D F Block Elements"

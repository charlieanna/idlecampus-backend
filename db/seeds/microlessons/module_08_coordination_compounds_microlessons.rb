# AUTO-GENERATED from module_08_coordination_compounds.rb
puts "Creating Microlessons for Coordination Compounds..."

module_var = CourseModule.find_by(slug: 'coordination-compounds')

# === MICROLESSON 1: magnetic_properties — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'magnetic_properties — Practice',
  content: <<~MARKDOWN,
# magnetic_properties — Practice 🚀

CN⁻ is strong field ligand causing electron pairing in Fe²⁺ (d⁶). Configuration becomes t2g⁶ eg⁰ with all electrons paired, hence diamagnetic (0 unpaired electrons).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['magnetic_properties'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: '[Fe(CN)₆]⁴⁻ is diamagnetic. How many unpaired electrons does it have?',
    answer: '',
    explanation: 'CN⁻ is strong field ligand causing electron pairing in Fe²⁺ (d⁶). Configuration becomes t2g⁶ eg⁰ with all electrons paired, hence diamagnetic (0 unpaired electrons).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Nomenclature and Isomerism in Coordination Compounds ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Nomenclature and Isomerism in Coordination Compounds',
  content: <<~MARKDOWN,
# Nomenclature and Isomerism in Coordination Compounds 🚀

# Nomenclature and Isomerism

    ## IUPAC Nomenclature Rules

    ### Basic Rules

    1. **Cation named first, then anion**
       - K₄[Fe(CN)₆]: Potassium hexacyanoferrate(II)

    2. **Ligands named before metal**
       - Alphabetically (ignore numerical prefixes)

    3. **Anionic ligands end in '-o'**
       - Cl⁻ → chlorido
       - CN⁻ → cyanido
       - NO₂⁻ → nitrito-N (nitro)
       - ONO⁻ → nitrito-O (nitrito)

    4. **Neutral ligands keep name**
       - Exception: H₂O → aqua, NH₃ → ammine, CO → carbonyl

    5. **Number of ligands indicated by prefix**
       - 2 → di, 3 → tri, 4 → tetra, 5 → penta, 6 → hexa
       - For complex ligands: bis, tris, tetrakis

    6. **Oxidation state in Roman numerals**
       - In parentheses after metal name

    7. **Anionic complex ends in '-ate'**
       - Cationic/neutral: just metal name

    ### Common Ligand Names

    | Ligand | Name | Ligand | Name |
    |--------|------|--------|------|
    | H₂O | aqua | NH₃ | ammine |
    | CO | carbonyl | NO | nitrosyl |
    | Cl⁻ | chlorido | Br⁻ | bromido |
    | CN⁻ | cyanido | OH⁻ | hydroxido |
    | O²⁻ | oxido | NO₂⁻ | nitrito-N |
    | C₂O₄²⁻ | oxalato | en | ethylenediamine |
    | EDTA⁴⁻ | ethylenediaminetetraacetato | acac⁻ | acetylacetonato |

    ### Metal Names in Anionic Complexes

    | Metal | Anionic name | Metal | Anionic name |
    |-------|--------------|-------|--------------|
    | Fe | ferrate | Cu | cuprate |
    | Co | cobaltate | Zn | zincate |
    | Ni | nickelate | Au | aurate |
    | Ag | argentate | Pb | plumbate |

    ### Examples

    **[Co(NH₃)₆]Cl₃**
    - Hexaamminecobalt(III) chloride

    **K₄[Fe(CN)₆]**
    - Potassium hexacyanoferrate(II)

    **[Co(NH₃)₅Cl]SO₄**
    - Pentaamminechloridocobalt(III) sulfate

    **[Pt(NH₃)₂Cl₂]**
    - Diamminedichloridoplatinum(II)

    **[Ni(CO)₄]**
    - Tetracarbonylnickel(0)

    **[Co(en)₃]Cl₃**
    - Tris(ethylenediamine)cobalt(III) chloride

    ---

    ## Isomerism in Coordination Compounds

    **Isomers:** Compounds with same molecular formula but different arrangements

    ---

    ## I. Structural Isomerism

    ### 1. Ionization Isomerism

    **Definition:** Different ions produced in solution due to exchange between ligand and counter ion

    **Examples:**

    - [Co(NH₃)₅Br]SO₄ (gives SO₄²⁻ in solution)
    - [Co(NH₃)₅SO₄]Br (gives Br⁻ in solution)

    ---

    - [Pt(NH₃)₄Cl₂]Br₂ (gives Br⁻)
    - [Pt(NH₃)₄Br₂]Cl₂ (gives Cl⁻)

    ### 2. Linkage Isomerism

    **Definition:** Different donor atoms of ambidentate ligand coordinate to metal

    **Examples:**

    **Nitro-nitrito isomerism:**
    - [Co(NH₃)₅(NO₂)]²⁺ (nitrito-N, N-bonded, yellow)
    - [Co(NH₃)₅(ONO)]²⁺ (nitrito-O, O-bonded, red)

    **Thiocyanato isomerism:**
    - [Co(NH₃)₅(SCN)]²⁺ (S-bonded)
    - [Co(NH₃)₅(NCS)]²⁺ (N-bonded)

    ### 3. Coordination Isomerism

    **Definition:** Interchange of ligands between cationic and anionic complexes

    **Examples:**

    - [Co(NH₃)₆][Cr(CN)₆]
    - [Cr(NH₃)₆][Co(CN)₆]

    ---

    - [Cu(NH₃)₄][PtCl₄]
    - [Pt(NH₃)₄][CuCl₄]

    ### 4. Solvate Isomerism (Hydrate Isomerism)

    **Definition:** Differs in number of solvent molecules as ligands vs outside

    **Examples:**

    - [Cr(H₂O)₆]Cl₃ (violet)
    - [Cr(H₂O)₅Cl]Cl₂·H₂O (blue-green)
    - [Cr(H₂O)₄Cl₂]Cl·2H₂O (dark green)

    ---

    ## II. Stereoisomerism

    ### 1. Geometrical Isomerism

    **Definition:** Different spatial arrangements of ligands

    #### A. Square Planar Complexes (MA₂B₂)

    **Cis-trans isomerism:**

    **Example: [Pt(NH₃)₂Cl₂]**

    **Cis isomer:**
    - Similar ligands adjacent (90°)
    - More polar
    - Used in cancer treatment (cisplatin)

    **Trans isomer:**
    - Similar ligands opposite (180°)
    - Less polar
    - No medicinal use

    #### B. Octahedral Complexes

    **Type 1: MA₄B₂**

    **Example: [Co(NH₃)₄Cl₂]⁺**

    - **Cis:** Cl atoms adjacent
    - **Trans:** Cl atoms opposite

    **Type 2: MA₃B₃**

    **Example: [Co(NH₃)₃Cl₃]**

    - **Fac (facial):** Three similar ligands on same face
    - **Mer (meridional):** Three similar ligands in meridian

    **Type 3: [M(AA)₂B₂]** (AA = bidentate)

    - Cis and trans possible

    **Type 4: [M(AA)₃]**

    - No geometrical isomerism
    - But shows optical isomerism

    ### 2. Optical Isomerism

    **Definition:** Isomers that are non-superimposable mirror images (enantiomers)

    **Chiral complexes:**
    - No plane of symmetry
    - Rotate plane-polarized light

    **d-isomer:** Rotates light clockwise (dextrorotatory, +)
    **l-isomer:** Rotates light anticlockwise (levorotatory, -)

    **Examples:**

    **[Co(en)₃]³⁺:**
    - Two optical isomers (d and l)
    - Octahedral, three bidentate ligands
    - No plane of symmetry

    **[Cis-Co(en)₂Cl₂]⁺:**
    - Two optical isomers
    - Cis form is chiral

    **[Trans-Co(en)₂Cl₂]⁺:**
    - No optical isomerism
    - Has plane of symmetry (achiral)

    **[Pt(NH₃)₂Cl₂]:**
    - Square planar
    - No optical isomerism (planar, has symmetry)

    ---

    ## Summary of Isomerism

    ```
    Isomerism
    ├── Structural Isomerism
    │   ├── Ionization
    │   ├── Linkage
    │   ├── Coordination
    │   └── Solvate (Hydrate)
    └── Stereoisomerism
        ├── Geometrical (cis-trans, fac-mer)
        └── Optical (d, l enantiomers)
    ```

    ---

    ## IIT JEE Key Points

    1. **Nomenclature:** Ligands alphabetically, metal with oxidation state
    2. **Anionic ligands:** End in '-o' (chlorido, cyanido)
    3. **Anionic complex:** Metal name ends in '-ate' (ferrate, cuprate)
    4. **Ionization isomerism:** Exchange ligand ↔ counter ion
    5. **Linkage isomerism:** Different donor atom (NO₂⁻/ONO⁻)
    6. **Geometrical:** Cis-trans (square planar, octahedral)
    7. **Optical:** Chiral complexes, non-superimposable mirror images
    8. **[Co(en)₃]³⁺:** Shows optical isomerism (d, l)
    9. **Cisplatin [Pt(NH₃)₂Cl₂]:** Cis isomer for cancer treatment
    10. **Trans isomers:** Usually achiral (have plane of symmetry)

## Key Points

- IUPAC nomenclature

- Geometrical isomerism

- Optical isomerism
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['IUPAC nomenclature', 'Geometrical isomerism', 'Optical isomerism', 'Linkage isomerism', 'Ionization isomerism'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Bonding in Coordination Compounds - VBT and CFT ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Bonding in Coordination Compounds - VBT and CFT',
  content: <<~MARKDOWN,
# Bonding in Coordination Compounds - VBT and CFT 🚀

# Bonding Theories in Coordination Compounds

    ## I. Valence Bond Theory (VBT)

    **Developed by:** Linus Pauling

    ### Basic Postulates

    1. **Metal uses vacant orbitals** for bonding
    2. **Ligands donate electron pairs** (coordinate covalent bonds)
    3. **Hybridization** determines geometry
    4. **Magnetic properties** explained by unpaired electrons

    ### Hybridization and Geometry

    | Coordination Number | Hybridization | Geometry | Example |
    |---------------------|---------------|----------|---------|
    | 4 | sp³ | Tetrahedral | [NiCl₄]²⁻ |
    | 4 | dsp² | Square planar | [Ni(CN)₄]²⁻ |
    | 5 | sp³d | Trigonal bipyramidal | [Fe(CO)₅] |
    | 6 | sp³d² | Octahedral | [CoF₆]³⁻ |
    | 6 | d²sp³ | Octahedral | [Co(NH₃)₆]³⁺ |

    ### Inner Orbital vs Outer Orbital Complexes

    **Inner orbital (low spin):**
    - Uses (n-1)d orbitals
    - d²sp³ hybridization
    - Strong field ligands
    - Paired electrons → diamagnetic or less paramagnetic

    **Outer orbital (high spin):**
    - Uses nd orbitals
    - sp³d² hybridization
    - Weak field ligands
    - Maximum unpaired electrons → paramagnetic

    ### Examples

    #### [Fe(CN)₆]⁴⁻ (Low spin, d²sp³)

    **Fe²⁺:** 3d⁶ → [Ar] 3d⁶

    Before bonding: ↑↓ ↑↓ ↑ ↑ (4 unpaired)

    CN⁻ is **strong field ligand** → pairing occurs

    After pairing: ↑↓ ↑↓ ↑↓ (0 unpaired)

    ```
    3d:      ↑↓ ↑↓ ↑↓
    4s: (empty) 4p: (empty)(empty)(empty)

    d²sp³ hybridization → 6 hybrid orbitals
    ```

    **Result:** Diamagnetic, inner orbital complex

    #### [FeF₆]⁴⁻ (High spin, sp³d²)

    **Fe²⁺:** 3d⁶

    F⁻ is **weak field ligand** → no pairing

    ```
    3d: ↑↓ ↑ ↑ ↑ ↑ (4 unpaired)
    4s: (empty) 4p: (empty)(empty)(empty) 4d: (empty)(empty)

    sp³d² hybridization → 6 hybrid orbitals
    ```

    **Result:** Paramagnetic (4 unpaired), outer orbital complex

    ### Limitations of VBT

    1. No quantitative explanation of magnetic properties
    2. Cannot explain color of complexes
    3. No explanation of thermodynamic/kinetic stability
    4. Doesn't explain spectrochemical series

    ---

    ## II. Crystal Field Theory (CFT)

    **Developed by:** Hans Bethe and John van Vleck

    ### Basic Assumptions

    1. **Ionic interaction** between metal and ligands
    2. **Ligands are point charges** (anions) or dipoles (neutral)
    3. **d-orbital degeneracy removed** by electrostatic field
    4. **Energy changes** explain color, magnetism, stability

    ### d-Orbital Splitting

    #### Octahedral Complexes

    **Free metal ion:** 5 d-orbitals degenerate (same energy)

    **In octahedral field:**
    - Ligands approach along axes
    - Orbitals along axes (dz², dx²-y²) → higher energy → **eg**
    - Orbitals between axes (dxy, dyz, dxz) → lower energy → **t2g**

    **Energy gap:** Δₒ (crystal field splitting energy)

    ```
              eg  ↑  ↑   (+0.6Δₒ each)

    Average ----------------

              t2g ↑  ↑  ↑  (-0.4Δₒ each)
    ```

    **Splitting:**
    - eg orbitals: +0.6Δₒ above average
    - t2g orbitals: -0.4Δₒ below average
    - Total: 3(-0.4Δₒ) + 2(+0.6Δₒ) = 0

    #### Strong Field vs Weak Field

    **Weak field ligands (Δₒ < Pairing Energy):**
    - High spin configuration
    - Maximum unpaired electrons
    - Example: F⁻, Cl⁻, Br⁻, I⁻

    **Strong field ligands (Δₒ > Pairing Energy):**
    - Low spin configuration
    - Electron pairing occurs
    - Example: CN⁻, CO, NH₃, en

    ### Spectrochemical Series

    **Increasing Δₒ (field strength):**

    I⁻ < Br⁻ < SCN⁻ < Cl⁻ < F⁻ < OH⁻ < H₂O < NCS⁻ < NH₃ < en < CN⁻ < CO

    **Weak field ← → Strong field**

    ### Electronic Configuration in Octahedral Field

    **d⁴ to d⁷:** Can be high spin or low spin depending on ligand

    **Examples:**

    **Fe²⁺ (d⁶) with CN⁻ (strong field):**
    ```
    eg:  ↑↓  —
    t2g: ↑↓ ↑↓ ↑↓
    Low spin, 0 unpaired electrons
    ```

    **Fe²⁺ (d⁶) with F⁻ (weak field):**
    ```
    eg:  ↑  ↑
    t2g: ↑↓ ↑  ↑
    High spin, 4 unpaired electrons
    ```

    ### Crystal Field Stabilization Energy (CFSE)

    **CFSE** = (-0.4 × nₜ₂g + 0.6 × nₑg) Δₒ + Pairing energy

    **Examples:**

    **[Fe(CN)₆]⁴⁻ (d⁶, low spin):**
    ```
    CFSE = (-0.4 × 6 + 0.6 × 0)Δₒ + 2P
         = -2.4Δₒ + 2P
    ```

    **[FeF₆]⁴⁻ (d⁶, high spin):**
    ```
    CFSE = (-0.4 × 4 + 0.6 × 2)Δₒ + 0
         = -0.4Δₒ
    ```

    ### Tetrahedral Complexes

    **d-orbital splitting:**
    - Smaller splitting: Δₜ ≈ (4/9)Δₒ
    - Reverse order: t₂ higher, e lower
    - Always high spin (small Δₜ)

    ```
    t₂  ↑  ↑  ↑   (+0.4Δₜ each)

    Average --------

    e   ↑  ↑       (-0.6Δₜ each)
    ```

    ### Square Planar Complexes

    - Derived from octahedral by removing two trans ligands
    - d⁸ configuration common (Ni²⁺, Pd²⁺, Pt²⁺)
    - Strong field ligands required
    - Usually low spin

    **Example: [Ni(CN)₄]²⁻**
    - Ni²⁺: d⁸
    - dsp² hybridization
    - Diamagnetic (all paired)

    ---

    ## Color in Coordination Compounds

    ### Origin of Color

    **d-d transitions:**
    - Electron excited from t2g to eg
    - Energy absorbed = Δₒ
    - Complementary color observed

    **Example:**
    - [Ti(H₂O)₆]³⁺ (d¹): Purple (absorbs yellow-green)
    - [Cu(H₂O)₆]²⁺ (d⁹): Blue
    - [Fe(H₂O)₆]²⁺ (d⁶): Pale green

    **Colorless complexes:**
    - d⁰ (no electrons): Sc³⁺, Ti⁴⁺
    - d¹⁰ (full d): Cu⁺, Zn²⁺
    - No d-d transition possible

    ---

    ## Magnetic Properties

    **Magnetic moment (μ):**
    ```
    μ = √[n(n+2)] B.M.
    ```
    where n = number of unpaired electrons

    **Examples:**

    | Complex | Unpaired e⁻ | μ (calculated) | Magnetic nature |
    |---------|-------------|----------------|-----------------|
    | [Fe(CN)₆]⁴⁻ | 0 | 0 | Diamagnetic |
    | [FeF₆]⁴⁻ | 4 | 4.9 | Paramagnetic |
    | [Co(NH₃)₆]³⁺ | 0 | 0 | Diamagnetic |
    | [CoF₆]³⁻ | 4 | 4.9 | Paramagnetic |

    ---

    ## IIT JEE Key Points

    1. **VBT:** Hybridization determines geometry
    2. **d²sp³:** Inner orbital (low spin), strong field
    3. **sp³d²:** Outer orbital (high spin), weak field
    4. **CFT:** d-orbital splitting by ligand field
    5. **Octahedral:** eg (higher) and t2g (lower), Δₒ gap
    6. **Spectrochemical series:** I⁻ < Br⁻ < Cl⁻ < F⁻ < H₂O < NH₃ < en < CN⁻ < CO
    7. **Strong field (CN⁻):** Low spin, diamagnetic (pairing)
    8. **Weak field (F⁻):** High spin, paramagnetic (no pairing)
    9. **Color:** d-d transitions, Δₒ energy absorbed
    10. **μ = √[n(n+2)] B.M.** where n = unpaired electrons
    11. **Tetrahedral:** Δₜ ≈ (4/9)Δₒ, always high spin
    12. **d⁰ and d¹⁰:** Colorless (no d-d transition)

## Key Points

- Valence Bond Theory

- Crystal Field Theory

- Hybridization
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Valence Bond Theory', 'Crystal Field Theory', 'Hybridization', 'd-orbital splitting', 'CFSE', 'Magnetic properties'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Introduction to Coordination Compounds ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Coordination Compounds',
  content: <<~MARKDOWN,
# Introduction to Coordination Compounds 🚀

# Introduction to Coordination Compounds

    ## Definition

    **Coordination compound:** A compound containing a central metal atom/ion bonded to a fixed number of molecules or ions (ligands).

    **Examples:**
    - [Fe(CN)₆]⁴⁻
    - [Cu(NH₃)₄]²⁺
    - [Co(NH₃)₆]³⁺
    - K₄[Fe(CN)₆]

    ---

    ## Werner's Coordination Theory (1893)

    **Alfred Werner** proposed the first successful theory explaining structure and bonding in coordination compounds. He won Nobel Prize (1913).

    ### Postulates

    1. **Primary valence (Ionizable):**
       - Oxidation state of central metal
       - Satisfied by negative ions
       - Non-directional, ionic

    2. **Secondary valence (Non-ionizable):**
       - Coordination number
       - Satisfied by ligands (can be neutral or ionic)
       - Directional, covalent

    3. **Specific geometry:**
       - Secondary valences are directed in space
       - Determine geometry of complex

    ### Example: CoCl₃·6NH₃

    Different compounds formed:

    | Formula | Ionizable Cl⁻ | Color | Modern Formula |
    |---------|---------------|-------|----------------|
    | CoCl₃·6NH₃ | 3 | Yellow | [Co(NH₃)₆]Cl₃ |
    | CoCl₃·5NH₃ | 2 | Purple | [Co(NH₃)₅Cl]Cl₂ |
    | CoCl₃·4NH₃ | 1 | Green | [Co(NH₃)₄Cl₂]Cl |
    | CoCl₃·4NH₃ | 1 | Violet | [Co(NH₃)₄Cl₂]Cl |

    **Explanation:**
    - Primary valence of Co = +3 (satisfied by 3 Cl⁻)
    - Secondary valence (coordination number) = 6
    - Geometry: Octahedral

    ---

    ## Important Terms

    ### 1. Central Metal Atom/Ion
    - Atom/ion to which ligands are attached
    - Usually transition metal
    - **Examples:** Co³⁺, Fe²⁺, Cu²⁺, Ni²⁺

    ### 2. Ligands
    - Molecules or ions bonded to central metal
    - Must have at least one lone pair to donate
    - Act as **Lewis bases**

    **Classification by number of donor atoms:**

    #### Monodentate (1 donor atom)
    - Cl⁻, Br⁻, I⁻, CN⁻, SCN⁻
    - H₂O, NH₃, CO, NO
    - Examples: [Co(NH₃)₆]³⁺

    #### Bidentate (2 donor atoms)
    - **Ethylenediamine (en):** H₂N-CH₂-CH₂-NH₂
    - **Oxalate:** C₂O₄²⁻
    - **Acetylacetonate (acac):** CH₃COCH=COCH₃⁻
    - Examples: [Co(en)₃]³⁺

    #### Polydentate (>2 donor atoms)
    - **EDTA⁴⁻ (hexadentate):** 6 donor atoms (2N, 4O)
    - **DMG (dimethylglyoxime):** Bidentate/tetradentate

    ### 3. Coordination Number
    - Number of ligand donor atoms bonded to central metal
    - Most common: 4 and 6

    **Examples:**
    - [Co(NH₃)₆]³⁺ → CN = 6
    - [Ni(CO)₄] → CN = 4
    - [Ni(en)₃]²⁺ → CN = 6 (3 bidentate ligands)

    ### 4. Coordination Sphere
    - Central metal + ligands (written in square brackets)
    - [Co(NH₃)₆]³⁺

    ### 5. Counter Ions
    - Ions outside coordination sphere
    - Balance charge
    - K₄[Fe(CN)₆] → K⁺ are counter ions

    ### 6. Oxidation State
    - Charge on central metal after removing all ligands
    - Calculate: Charge on complex = OS + Σ(ligand charges)

    **Examples:**

    [Fe(CN)₆]⁴⁻:
    ```
    -4 = OS + 6(-1)
    OS = +2
    ```

    [Co(NH₃)₅Cl]²⁺:
    ```
    +2 = OS + 5(0) + 1(-1)
    OS = +3
    ```

    ---

    ## Types of Complexes

    ### Based on Charge

    **1. Cationic complexes:**
    - [Co(NH₃)₆]³⁺, [Cu(NH₃)₄]²⁺

    **2. Anionic complexes:**
    - [Fe(CN)₆]⁴⁻, [CoCl₄]²⁻

    **3. Neutral complexes:**
    - [Ni(CO)₄], [Co(NH₃)₃Cl₃]

    ### Based on Ligands

    **1. Homoleptic:**
    - Only one type of ligand
    - [Co(NH₃)₆]³⁺, [Fe(CN)₆]⁴⁻

    **2. Heteroleptic:**
    - More than one type of ligand
    - [Co(NH₃)₅Cl]²⁺, [Co(en)₂Cl₂]⁺

    ---

    ## Chelate Effect

    **Chelate:** Complex with polydentate ligands forming ring structures

    **Examples:**
    - [Co(en)₃]³⁺ (3 five-membered rings)
    - [Ni(DMG)₂] (2 six-membered rings)

    **Chelate Effect:** Complexes with chelating ligands are more stable than those with monodentate ligands

    **Reason:**
    - **Entropy increase:** One polydentate replaces multiple monodentate ligands
    - Thermodynamically favorable (ΔG = ΔH - TΔS)

    **Example:**
    ```
    [Ni(H₂O)₆]²⁺ + 3en ⇌ [Ni(en)₃]²⁺ + 6H₂O

    4 particles → 7 particles (entropy increases)
    [Ni(en)₃]²⁺ is more stable
    ```

    ---

    ## Ambidentate Ligands

    **Definition:** Ligands with two different donor atoms, but can donate through only one at a time

    **Examples:**

    1. **Thiocyanate:**
       - SCN⁻ → S-bonded (thiocyanato-S)
       - NCS⁻ → N-bonded (thiocyanato-N)

    2. **Nitrite:**
       - NO₂⁻ → N-bonded (nitrito-N or nitro)
       - ONO⁻ → O-bonded (nitrito-O or nitrito)

    ---

    ## IIT JEE Key Points

    1. **Werner's theory:** Primary valence (ionic) + Secondary valence (covalent)
    2. **Coordination number:** Number of donor atoms bonded to metal
    3. **Ligands:** Lewis bases with lone pairs
    4. **Monodentate:** 1 donor; **Bidentate:** 2 donors; **Polydentate:** >2 donors
    5. **EDTA⁴⁻:** Hexadentate ligand (6 donor atoms)
    6. **Chelate effect:** Polydentate ligands form more stable complexes
    7. **Ambidentate:** Can coordinate through different atoms (SCN⁻/NCS⁻, NO₂⁻/ONO⁻)
    8. **Oxidation state calculation:** Charge = OS + Σ(ligand charges)

## Key Points

- Coordination compounds

- Werner\

- , 
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Coordination compounds', 'Werner\', ', ', ', ', ', '],
  prerequisite_ids: []
)

# === MICROLESSON 5: Nomenclature and Isomerism in Coordination Compounds ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Nomenclature and Isomerism in Coordination Compounds',
  content: <<~MARKDOWN,
# Nomenclature and Isomerism in Coordination Compounds 🚀

# Nomenclature and Isomerism

    ## IUPAC Nomenclature Rules

    ### Basic Rules

    1. **Cation named first, then anion**
       - K₄[Fe(CN)₆]: Potassium hexacyanoferrate(II)

    2. **Ligands named before metal**
       - Alphabetically (ignore numerical prefixes)

    3. **Anionic ligands end in '-o'**
       - Cl⁻ → chlorido
       - CN⁻ → cyanido
       - NO₂⁻ → nitrito-N (nitro)
       - ONO⁻ → nitrito-O (nitrito)

    4. **Neutral ligands keep name**
       - Exception: H₂O → aqua, NH₃ → ammine, CO → carbonyl

    5. **Number of ligands indicated by prefix**
       - 2 → di, 3 → tri, 4 → tetra, 5 → penta, 6 → hexa
       - For complex ligands: bis, tris, tetrakis

    6. **Oxidation state in Roman numerals**
       - In parentheses after metal name

    7. **Anionic complex ends in '-ate'**
       - Cationic/neutral: just metal name

    ### Common Ligand Names

    | Ligand | Name | Ligand | Name |
    |--------|------|--------|------|
    | H₂O | aqua | NH₃ | ammine |
    | CO | carbonyl | NO | nitrosyl |
    | Cl⁻ | chlorido | Br⁻ | bromido |
    | CN⁻ | cyanido | OH⁻ | hydroxido |
    | O²⁻ | oxido | NO₂⁻ | nitrito-N |
    | C₂O₄²⁻ | oxalato | en | ethylenediamine |
    | EDTA⁴⁻ | ethylenediaminetetraacetato | acac⁻ | acetylacetonato |

    ### Metal Names in Anionic Complexes

    | Metal | Anionic name | Metal | Anionic name |
    |-------|--------------|-------|--------------|
    | Fe | ferrate | Cu | cuprate |
    | Co | cobaltate | Zn | zincate |
    | Ni | nickelate | Au | aurate |
    | Ag | argentate | Pb | plumbate |

    ### Examples

    **[Co(NH₃)₆]Cl₃**
    - Hexaamminecobalt(III) chloride

    **K₄[Fe(CN)₆]**
    - Potassium hexacyanoferrate(II)

    **[Co(NH₃)₅Cl]SO₄**
    - Pentaamminechloridocobalt(III) sulfate

    **[Pt(NH₃)₂Cl₂]**
    - Diamminedichloridoplatinum(II)

    **[Ni(CO)₄]**
    - Tetracarbonylnickel(0)

    **[Co(en)₃]Cl₃**
    - Tris(ethylenediamine)cobalt(III) chloride

    ---

    ## Isomerism in Coordination Compounds

    **Isomers:** Compounds with same molecular formula but different arrangements

    ---

    ## I. Structural Isomerism

    ### 1. Ionization Isomerism

    **Definition:** Different ions produced in solution due to exchange between ligand and counter ion

    **Examples:**

    - [Co(NH₃)₅Br]SO₄ (gives SO₄²⁻ in solution)
    - [Co(NH₃)₅SO₄]Br (gives Br⁻ in solution)

    ---

    - [Pt(NH₃)₄Cl₂]Br₂ (gives Br⁻)
    - [Pt(NH₃)₄Br₂]Cl₂ (gives Cl⁻)

    ### 2. Linkage Isomerism

    **Definition:** Different donor atoms of ambidentate ligand coordinate to metal

    **Examples:**

    **Nitro-nitrito isomerism:**
    - [Co(NH₃)₅(NO₂)]²⁺ (nitrito-N, N-bonded, yellow)
    - [Co(NH₃)₅(ONO)]²⁺ (nitrito-O, O-bonded, red)

    **Thiocyanato isomerism:**
    - [Co(NH₃)₅(SCN)]²⁺ (S-bonded)
    - [Co(NH₃)₅(NCS)]²⁺ (N-bonded)

    ### 3. Coordination Isomerism

    **Definition:** Interchange of ligands between cationic and anionic complexes

    **Examples:**

    - [Co(NH₃)₆][Cr(CN)₆]
    - [Cr(NH₃)₆][Co(CN)₆]

    ---

    - [Cu(NH₃)₄][PtCl₄]
    - [Pt(NH₃)₄][CuCl₄]

    ### 4. Solvate Isomerism (Hydrate Isomerism)

    **Definition:** Differs in number of solvent molecules as ligands vs outside

    **Examples:**

    - [Cr(H₂O)₆]Cl₃ (violet)
    - [Cr(H₂O)₅Cl]Cl₂·H₂O (blue-green)
    - [Cr(H₂O)₄Cl₂]Cl·2H₂O (dark green)

    ---

    ## II. Stereoisomerism

    ### 1. Geometrical Isomerism

    **Definition:** Different spatial arrangements of ligands

    #### A. Square Planar Complexes (MA₂B₂)

    **Cis-trans isomerism:**

    **Example: [Pt(NH₃)₂Cl₂]**

    **Cis isomer:**
    - Similar ligands adjacent (90°)
    - More polar
    - Used in cancer treatment (cisplatin)

    **Trans isomer:**
    - Similar ligands opposite (180°)
    - Less polar
    - No medicinal use

    #### B. Octahedral Complexes

    **Type 1: MA₄B₂**

    **Example: [Co(NH₃)₄Cl₂]⁺**

    - **Cis:** Cl atoms adjacent
    - **Trans:** Cl atoms opposite

    **Type 2: MA₃B₃**

    **Example: [Co(NH₃)₃Cl₃]**

    - **Fac (facial):** Three similar ligands on same face
    - **Mer (meridional):** Three similar ligands in meridian

    **Type 3: [M(AA)₂B₂]** (AA = bidentate)

    - Cis and trans possible

    **Type 4: [M(AA)₃]**

    - No geometrical isomerism
    - But shows optical isomerism

    ### 2. Optical Isomerism

    **Definition:** Isomers that are non-superimposable mirror images (enantiomers)

    **Chiral complexes:**
    - No plane of symmetry
    - Rotate plane-polarized light

    **d-isomer:** Rotates light clockwise (dextrorotatory, +)
    **l-isomer:** Rotates light anticlockwise (levorotatory, -)

    **Examples:**

    **[Co(en)₃]³⁺:**
    - Two optical isomers (d and l)
    - Octahedral, three bidentate ligands
    - No plane of symmetry

    **[Cis-Co(en)₂Cl₂]⁺:**
    - Two optical isomers
    - Cis form is chiral

    **[Trans-Co(en)₂Cl₂]⁺:**
    - No optical isomerism
    - Has plane of symmetry (achiral)

    **[Pt(NH₃)₂Cl₂]:**
    - Square planar
    - No optical isomerism (planar, has symmetry)

    ---

    ## Summary of Isomerism

    ```
    Isomerism
    ├── Structural Isomerism
    │   ├── Ionization
    │   ├── Linkage
    │   ├── Coordination
    │   └── Solvate (Hydrate)
    └── Stereoisomerism
        ├── Geometrical (cis-trans, fac-mer)
        └── Optical (d, l enantiomers)
    ```

    ---

    ## IIT JEE Key Points

    1. **Nomenclature:** Ligands alphabetically, metal with oxidation state
    2. **Anionic ligands:** End in '-o' (chlorido, cyanido)
    3. **Anionic complex:** Metal name ends in '-ate' (ferrate, cuprate)
    4. **Ionization isomerism:** Exchange ligand ↔ counter ion
    5. **Linkage isomerism:** Different donor atom (NO₂⁻/ONO⁻)
    6. **Geometrical:** Cis-trans (square planar, octahedral)
    7. **Optical:** Chiral complexes, non-superimposable mirror images
    8. **[Co(en)₃]³⁺:** Shows optical isomerism (d, l)
    9. **Cisplatin [Pt(NH₃)₂Cl₂]:** Cis isomer for cancer treatment
    10. **Trans isomers:** Usually achiral (have plane of symmetry)

## Key Points

- IUPAC nomenclature

- Geometrical isomerism

- Optical isomerism
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['IUPAC nomenclature', 'Geometrical isomerism', 'Optical isomerism', 'Linkage isomerism', 'Ionization isomerism'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Bonding in Coordination Compounds - VBT and CFT ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Bonding in Coordination Compounds - VBT and CFT',
  content: <<~MARKDOWN,
# Bonding in Coordination Compounds - VBT and CFT 🚀

# Bonding Theories in Coordination Compounds

    ## I. Valence Bond Theory (VBT)

    **Developed by:** Linus Pauling

    ### Basic Postulates

    1. **Metal uses vacant orbitals** for bonding
    2. **Ligands donate electron pairs** (coordinate covalent bonds)
    3. **Hybridization** determines geometry
    4. **Magnetic properties** explained by unpaired electrons

    ### Hybridization and Geometry

    | Coordination Number | Hybridization | Geometry | Example |
    |---------------------|---------------|----------|---------|
    | 4 | sp³ | Tetrahedral | [NiCl₄]²⁻ |
    | 4 | dsp² | Square planar | [Ni(CN)₄]²⁻ |
    | 5 | sp³d | Trigonal bipyramidal | [Fe(CO)₅] |
    | 6 | sp³d² | Octahedral | [CoF₆]³⁻ |
    | 6 | d²sp³ | Octahedral | [Co(NH₃)₆]³⁺ |

    ### Inner Orbital vs Outer Orbital Complexes

    **Inner orbital (low spin):**
    - Uses (n-1)d orbitals
    - d²sp³ hybridization
    - Strong field ligands
    - Paired electrons → diamagnetic or less paramagnetic

    **Outer orbital (high spin):**
    - Uses nd orbitals
    - sp³d² hybridization
    - Weak field ligands
    - Maximum unpaired electrons → paramagnetic

    ### Examples

    #### [Fe(CN)₆]⁴⁻ (Low spin, d²sp³)

    **Fe²⁺:** 3d⁶ → [Ar] 3d⁶

    Before bonding: ↑↓ ↑↓ ↑ ↑ (4 unpaired)

    CN⁻ is **strong field ligand** → pairing occurs

    After pairing: ↑↓ ↑↓ ↑↓ (0 unpaired)

    ```
    3d:      ↑↓ ↑↓ ↑↓
    4s: (empty) 4p: (empty)(empty)(empty)

    d²sp³ hybridization → 6 hybrid orbitals
    ```

    **Result:** Diamagnetic, inner orbital complex

    #### [FeF₆]⁴⁻ (High spin, sp³d²)

    **Fe²⁺:** 3d⁶

    F⁻ is **weak field ligand** → no pairing

    ```
    3d: ↑↓ ↑ ↑ ↑ ↑ (4 unpaired)
    4s: (empty) 4p: (empty)(empty)(empty) 4d: (empty)(empty)

    sp³d² hybridization → 6 hybrid orbitals
    ```

    **Result:** Paramagnetic (4 unpaired), outer orbital complex

    ### Limitations of VBT

    1. No quantitative explanation of magnetic properties
    2. Cannot explain color of complexes
    3. No explanation of thermodynamic/kinetic stability
    4. Doesn't explain spectrochemical series

    ---

    ## II. Crystal Field Theory (CFT)

    **Developed by:** Hans Bethe and John van Vleck

    ### Basic Assumptions

    1. **Ionic interaction** between metal and ligands
    2. **Ligands are point charges** (anions) or dipoles (neutral)
    3. **d-orbital degeneracy removed** by electrostatic field
    4. **Energy changes** explain color, magnetism, stability

    ### d-Orbital Splitting

    #### Octahedral Complexes

    **Free metal ion:** 5 d-orbitals degenerate (same energy)

    **In octahedral field:**
    - Ligands approach along axes
    - Orbitals along axes (dz², dx²-y²) → higher energy → **eg**
    - Orbitals between axes (dxy, dyz, dxz) → lower energy → **t2g**

    **Energy gap:** Δₒ (crystal field splitting energy)

    ```
              eg  ↑  ↑   (+0.6Δₒ each)

    Average ----------------

              t2g ↑  ↑  ↑  (-0.4Δₒ each)
    ```

    **Splitting:**
    - eg orbitals: +0.6Δₒ above average
    - t2g orbitals: -0.4Δₒ below average
    - Total: 3(-0.4Δₒ) + 2(+0.6Δₒ) = 0

    #### Strong Field vs Weak Field

    **Weak field ligands (Δₒ < Pairing Energy):**
    - High spin configuration
    - Maximum unpaired electrons
    - Example: F⁻, Cl⁻, Br⁻, I⁻

    **Strong field ligands (Δₒ > Pairing Energy):**
    - Low spin configuration
    - Electron pairing occurs
    - Example: CN⁻, CO, NH₃, en

    ### Spectrochemical Series

    **Increasing Δₒ (field strength):**

    I⁻ < Br⁻ < SCN⁻ < Cl⁻ < F⁻ < OH⁻ < H₂O < NCS⁻ < NH₃ < en < CN⁻ < CO

    **Weak field ← → Strong field**

    ### Electronic Configuration in Octahedral Field

    **d⁴ to d⁷:** Can be high spin or low spin depending on ligand

    **Examples:**

    **Fe²⁺ (d⁶) with CN⁻ (strong field):**
    ```
    eg:  ↑↓  —
    t2g: ↑↓ ↑↓ ↑↓
    Low spin, 0 unpaired electrons
    ```

    **Fe²⁺ (d⁶) with F⁻ (weak field):**
    ```
    eg:  ↑  ↑
    t2g: ↑↓ ↑  ↑
    High spin, 4 unpaired electrons
    ```

    ### Crystal Field Stabilization Energy (CFSE)

    **CFSE** = (-0.4 × nₜ₂g + 0.6 × nₑg) Δₒ + Pairing energy

    **Examples:**

    **[Fe(CN)₆]⁴⁻ (d⁶, low spin):**
    ```
    CFSE = (-0.4 × 6 + 0.6 × 0)Δₒ + 2P
         = -2.4Δₒ + 2P
    ```

    **[FeF₆]⁴⁻ (d⁶, high spin):**
    ```
    CFSE = (-0.4 × 4 + 0.6 × 2)Δₒ + 0
         = -0.4Δₒ
    ```

    ### Tetrahedral Complexes

    **d-orbital splitting:**
    - Smaller splitting: Δₜ ≈ (4/9)Δₒ
    - Reverse order: t₂ higher, e lower
    - Always high spin (small Δₜ)

    ```
    t₂  ↑  ↑  ↑   (+0.4Δₜ each)

    Average --------

    e   ↑  ↑       (-0.6Δₜ each)
    ```

    ### Square Planar Complexes

    - Derived from octahedral by removing two trans ligands
    - d⁸ configuration common (Ni²⁺, Pd²⁺, Pt²⁺)
    - Strong field ligands required
    - Usually low spin

    **Example: [Ni(CN)₄]²⁻**
    - Ni²⁺: d⁸
    - dsp² hybridization
    - Diamagnetic (all paired)

    ---

    ## Color in Coordination Compounds

    ### Origin of Color

    **d-d transitions:**
    - Electron excited from t2g to eg
    - Energy absorbed = Δₒ
    - Complementary color observed

    **Example:**
    - [Ti(H₂O)₆]³⁺ (d¹): Purple (absorbs yellow-green)
    - [Cu(H₂O)₆]²⁺ (d⁹): Blue
    - [Fe(H₂O)₆]²⁺ (d⁶): Pale green

    **Colorless complexes:**
    - d⁰ (no electrons): Sc³⁺, Ti⁴⁺
    - d¹⁰ (full d): Cu⁺, Zn²⁺
    - No d-d transition possible

    ---

    ## Magnetic Properties

    **Magnetic moment (μ):**
    ```
    μ = √[n(n+2)] B.M.
    ```
    where n = number of unpaired electrons

    **Examples:**

    | Complex | Unpaired e⁻ | μ (calculated) | Magnetic nature |
    |---------|-------------|----------------|-----------------|
    | [Fe(CN)₆]⁴⁻ | 0 | 0 | Diamagnetic |
    | [FeF₆]⁴⁻ | 4 | 4.9 | Paramagnetic |
    | [Co(NH₃)₆]³⁺ | 0 | 0 | Diamagnetic |
    | [CoF₆]³⁻ | 4 | 4.9 | Paramagnetic |

    ---

    ## IIT JEE Key Points

    1. **VBT:** Hybridization determines geometry
    2. **d²sp³:** Inner orbital (low spin), strong field
    3. **sp³d²:** Outer orbital (high spin), weak field
    4. **CFT:** d-orbital splitting by ligand field
    5. **Octahedral:** eg (higher) and t2g (lower), Δₒ gap
    6. **Spectrochemical series:** I⁻ < Br⁻ < Cl⁻ < F⁻ < H₂O < NH₃ < en < CN⁻ < CO
    7. **Strong field (CN⁻):** Low spin, diamagnetic (pairing)
    8. **Weak field (F⁻):** High spin, paramagnetic (no pairing)
    9. **Color:** d-d transitions, Δₒ energy absorbed
    10. **μ = √[n(n+2)] B.M.** where n = unpaired electrons
    11. **Tetrahedral:** Δₜ ≈ (4/9)Δₒ, always high spin
    12. **d⁰ and d¹⁰:** Colorless (no d-d transition)

## Key Points

- Valence Bond Theory

- Crystal Field Theory

- Hybridization
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Valence Bond Theory', 'Crystal Field Theory', 'Hybridization', 'd-orbital splitting', 'CFSE', 'Magnetic properties'],
  prerequisite_ids: []
)

# === MICROLESSON 7: ligands — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'ligands — Practice',
  content: <<~MARKDOWN,
# ligands — Practice 🚀

EDTA⁴⁻ (ethylenediaminetetraacetate) has 6 donor atoms (2 nitrogen and 4 oxygen), making it a hexadentate ligand.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['ligands'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'EDTA⁴⁻ is an example of which type of ligand?',
    options: ['Hexadentate', 'Bidentate', 'Tridentate', 'Tetradentate'],
    correct_answer: 0,
    explanation: 'EDTA⁴⁻ (ethylenediaminetetraacetate) has 6 donor atoms (2 nitrogen and 4 oxygen), making it a hexadentate ligand.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: oxidation_state — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_state — Practice',
  content: <<~MARKDOWN,
# oxidation_state — Practice 🚀

Charge on complex = OS + Σ(ligand charges). -4 = OS + 6(-1), therefore OS = +2.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['oxidation_state'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the oxidation state of Fe in [Fe(CN)₆]⁴⁻?',
    options: ['+2', '+3', '+4', '+1'],
    correct_answer: 0,
    explanation: 'Charge on complex = OS + Σ(ligand charges). -4 = OS + 6(-1), therefore OS = +2.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: isomerism — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'isomerism — Practice',
  content: <<~MARKDOWN,
# isomerism — Practice 🚀

[Co(en)₃]³⁺ and cis-[Co(en)₂Cl₂]⁺ are chiral (no plane of symmetry). Trans isomer and square planar complex have symmetry, hence achiral.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['isomerism'],
  prerequisite_ids: []
)

# === MICROLESSON 10: crystal_field_theory — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'crystal_field_theory — Practice',
  content: <<~MARKDOWN,
# crystal_field_theory — Practice 🚀

In octahedral field, ligands approach along axes. Orbitals along axes (dz², dx²-y²) experience more repulsion, hence higher energy (eg set).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['crystal_field_theory'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'According to Crystal Field Theory, in an octahedral complex, which d-orbitals have higher energy?',
    options: ['dz² and dx²-y² (eg orbitals)', 'dxy, dyz, and dxz (t2g orbitals)', 'All d-orbitals have equal energy', 'Only dz² orbital'],
    correct_answer: 0,
    explanation: 'In octahedral field, ligands approach along axes. Orbitals along axes (dz², dx²-y²) experience more repulsion, hence higher energy (eg set).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 11: crystal_field_theory — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'crystal_field_theory — Practice',
  content: <<~MARKDOWN,
# crystal_field_theory — Practice 🚀

According to spectrochemical series: CN⁻ is strongest field ligand (largest Δₒ), followed by NH₃, H₂O, F⁻, Cl⁻, Br⁻, I⁻.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['crystal_field_theory'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which ligand produces the largest crystal field splitting (Δₒ)?',
    options: ['CN⁻', 'H₂O', 'Cl⁻', 'F⁻'],
    correct_answer: 0,
    explanation: 'According to spectrochemical series: CN⁻ is strongest field ligand (largest Δₒ), followed by NH₃, H₂O, F⁻, Cl⁻, Br⁻, I⁻.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: Introduction to Coordination Compounds ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Coordination Compounds',
  content: <<~MARKDOWN,
# Introduction to Coordination Compounds 🚀

# Introduction to Coordination Compounds

    ## Definition

    **Coordination compound:** A compound containing a central metal atom/ion bonded to a fixed number of molecules or ions (ligands).

    **Examples:**
    - [Fe(CN)₆]⁴⁻
    - [Cu(NH₃)₄]²⁺
    - [Co(NH₃)₆]³⁺
    - K₄[Fe(CN)₆]

    ---

    ## Werner's Coordination Theory (1893)

    **Alfred Werner** proposed the first successful theory explaining structure and bonding in coordination compounds. He won Nobel Prize (1913).

    ### Postulates

    1. **Primary valence (Ionizable):**
       - Oxidation state of central metal
       - Satisfied by negative ions
       - Non-directional, ionic

    2. **Secondary valence (Non-ionizable):**
       - Coordination number
       - Satisfied by ligands (can be neutral or ionic)
       - Directional, covalent

    3. **Specific geometry:**
       - Secondary valences are directed in space
       - Determine geometry of complex

    ### Example: CoCl₃·6NH₃

    Different compounds formed:

    | Formula | Ionizable Cl⁻ | Color | Modern Formula |
    |---------|---------------|-------|----------------|
    | CoCl₃·6NH₃ | 3 | Yellow | [Co(NH₃)₆]Cl₃ |
    | CoCl₃·5NH₃ | 2 | Purple | [Co(NH₃)₅Cl]Cl₂ |
    | CoCl₃·4NH₃ | 1 | Green | [Co(NH₃)₄Cl₂]Cl |
    | CoCl₃·4NH₃ | 1 | Violet | [Co(NH₃)₄Cl₂]Cl |

    **Explanation:**
    - Primary valence of Co = +3 (satisfied by 3 Cl⁻)
    - Secondary valence (coordination number) = 6
    - Geometry: Octahedral

    ---

    ## Important Terms

    ### 1. Central Metal Atom/Ion
    - Atom/ion to which ligands are attached
    - Usually transition metal
    - **Examples:** Co³⁺, Fe²⁺, Cu²⁺, Ni²⁺

    ### 2. Ligands
    - Molecules or ions bonded to central metal
    - Must have at least one lone pair to donate
    - Act as **Lewis bases**

    **Classification by number of donor atoms:**

    #### Monodentate (1 donor atom)
    - Cl⁻, Br⁻, I⁻, CN⁻, SCN⁻
    - H₂O, NH₃, CO, NO
    - Examples: [Co(NH₃)₆]³⁺

    #### Bidentate (2 donor atoms)
    - **Ethylenediamine (en):** H₂N-CH₂-CH₂-NH₂
    - **Oxalate:** C₂O₄²⁻
    - **Acetylacetonate (acac):** CH₃COCH=COCH₃⁻
    - Examples: [Co(en)₃]³⁺

    #### Polydentate (>2 donor atoms)
    - **EDTA⁴⁻ (hexadentate):** 6 donor atoms (2N, 4O)
    - **DMG (dimethylglyoxime):** Bidentate/tetradentate

    ### 3. Coordination Number
    - Number of ligand donor atoms bonded to central metal
    - Most common: 4 and 6

    **Examples:**
    - [Co(NH₃)₆]³⁺ → CN = 6
    - [Ni(CO)₄] → CN = 4
    - [Ni(en)₃]²⁺ → CN = 6 (3 bidentate ligands)

    ### 4. Coordination Sphere
    - Central metal + ligands (written in square brackets)
    - [Co(NH₃)₆]³⁺

    ### 5. Counter Ions
    - Ions outside coordination sphere
    - Balance charge
    - K₄[Fe(CN)₆] → K⁺ are counter ions

    ### 6. Oxidation State
    - Charge on central metal after removing all ligands
    - Calculate: Charge on complex = OS + Σ(ligand charges)

    **Examples:**

    [Fe(CN)₆]⁴⁻:
    ```
    -4 = OS + 6(-1)
    OS = +2
    ```

    [Co(NH₃)₅Cl]²⁺:
    ```
    +2 = OS + 5(0) + 1(-1)
    OS = +3
    ```

    ---

    ## Types of Complexes

    ### Based on Charge

    **1. Cationic complexes:**
    - [Co(NH₃)₆]³⁺, [Cu(NH₃)₄]²⁺

    **2. Anionic complexes:**
    - [Fe(CN)₆]⁴⁻, [CoCl₄]²⁻

    **3. Neutral complexes:**
    - [Ni(CO)₄], [Co(NH₃)₃Cl₃]

    ### Based on Ligands

    **1. Homoleptic:**
    - Only one type of ligand
    - [Co(NH₃)₆]³⁺, [Fe(CN)₆]⁴⁻

    **2. Heteroleptic:**
    - More than one type of ligand
    - [Co(NH₃)₅Cl]²⁺, [Co(en)₂Cl₂]⁺

    ---

    ## Chelate Effect

    **Chelate:** Complex with polydentate ligands forming ring structures

    **Examples:**
    - [Co(en)₃]³⁺ (3 five-membered rings)
    - [Ni(DMG)₂] (2 six-membered rings)

    **Chelate Effect:** Complexes with chelating ligands are more stable than those with monodentate ligands

    **Reason:**
    - **Entropy increase:** One polydentate replaces multiple monodentate ligands
    - Thermodynamically favorable (ΔG = ΔH - TΔS)

    **Example:**
    ```
    [Ni(H₂O)₆]²⁺ + 3en ⇌ [Ni(en)₃]²⁺ + 6H₂O

    4 particles → 7 particles (entropy increases)
    [Ni(en)₃]²⁺ is more stable
    ```

    ---

    ## Ambidentate Ligands

    **Definition:** Ligands with two different donor atoms, but can donate through only one at a time

    **Examples:**

    1. **Thiocyanate:**
       - SCN⁻ → S-bonded (thiocyanato-S)
       - NCS⁻ → N-bonded (thiocyanato-N)

    2. **Nitrite:**
       - NO₂⁻ → N-bonded (nitrito-N or nitro)
       - ONO⁻ → O-bonded (nitrito-O or nitrito)

    ---

    ## IIT JEE Key Points

    1. **Werner's theory:** Primary valence (ionic) + Secondary valence (covalent)
    2. **Coordination number:** Number of donor atoms bonded to metal
    3. **Ligands:** Lewis bases with lone pairs
    4. **Monodentate:** 1 donor; **Bidentate:** 2 donors; **Polydentate:** >2 donors
    5. **EDTA⁴⁻:** Hexadentate ligand (6 donor atoms)
    6. **Chelate effect:** Polydentate ligands form more stable complexes
    7. **Ambidentate:** Can coordinate through different atoms (SCN⁻/NCS⁻, NO₂⁻/ONO⁻)
    8. **Oxidation state calculation:** Charge = OS + Σ(ligand charges)

## Key Points

- Coordination compounds

- Werner\

- , 
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Coordination compounds', 'Werner\', ', ', ', ', ', '],
  prerequisite_ids: []
)

puts "✓ Created 12 microlessons for Coordination Compounds"

# frozen_string_literal: true

# ========================================
# IIT JEE Physical Chemistry - Module 12
# Solid State Chemistry
# ========================================
# Complete module with lessons and questions
# Crystal lattices, unit cells, packing, defects, properties
# ========================================

puts "\n" + "=" * 80
puts "MODULE 12: SOLID STATE CHEMISTRY"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-physical-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Physical Chemistry course not found!"
  exit 1
end

# Create Module 12: Solid State Chemistry
module_12 = course.course_modules.find_or_create_by!(slug: 'solid-state-chemistry') do |m|
  m.title = 'Solid State Chemistry'
  m.sequence_order = 12
  m.estimated_minutes = 380
  m.description = 'Crystal lattices, unit cells, packing efficiency, crystal defects, and electrical and magnetic properties of solids'
  m.learning_objectives = [
    'Understand crystal lattice structures and unit cells',
    'Calculate packing efficiency for different structures',
    'Master coordination number concepts',
    'Identify and classify crystal defects',
    'Understand electrical properties: conductors, semiconductors, insulators',
    'Learn magnetic properties and band theory'
  ]
  m.published = true
end

puts "✅ Module 12: #{module_12.title}"

# ========================================
# Lesson 12.1: Crystal Lattices and Unit Cells
# ========================================

lesson_12_1 = CourseLesson.create!(
  title: 'Crystal Lattices, Unit Cells and Coordination Number',
  reading_time_minutes: 60,
  key_concepts: ['Crystal lattice', 'Unit cell', 'Primitive cells', 'Simple cubic', 'BCC', 'FCC', 'Coordination number', 'Crystal systems'],
  content: <<~MD
    # Crystal Lattices, Unit Cells and Coordination Number

    ## Solid State Classification

    ### Crystalline Solids:
    - Long-range order
    - Definite geometric shape
    - Sharp melting point
    - Anisotropic properties
    - Examples: NaCl, diamond, quartz

    ### Amorphous Solids:
    - Short-range order only
    - No definite shape
    - Gradual softening
    - Isotropic properties
    - Examples: Glass, rubber, plastics

    ## Crystal Lattice

    **Definition:** 3D arrangement of constituent particles (atoms, ions, molecules) in a regular pattern

    **Space Lattice:** Array of points showing positions of particles

    **Lattice Points:** Positions occupied by constituent particles

    ## Unit Cell

    **Definition:** Smallest repeating unit of crystal lattice that generates entire crystal when repeated in 3D

    **Parameters:**
    - **Edge lengths:** a, b, c
    - **Angles:** α (between b and c), β (between a and c), γ (between a and b)

    ### Types of Unit Cells:

    **1. Primitive (Simple):** Atoms only at corners
    **2. Body-centered:** Atoms at corners + body center
    **3. Face-centered:** Atoms at corners + face centers
    **4. End-centered:** Atoms at corners + two opposite face centers

    ## Seven Crystal Systems

    | System | Axial Lengths | Axial Angles | Example |
    |--------|---------------|--------------|---------|
    | **Cubic** | a = b = c | α = β = γ = 90° | NaCl, Diamond |
    | **Tetragonal** | a = b ≠ c | α = β = γ = 90° | SnO₂, TiO₂ |
    | **Orthorhombic** | a ≠ b ≠ c | α = β = γ = 90° | BaSO₄, KNO₃ |
    | **Monoclinic** | a ≠ b ≠ c | α = γ = 90° ≠ β | Na₂SO₄·10H₂O |
    | **Triclinic** | a ≠ b ≠ c | α ≠ β ≠ γ | K₂Cr₂O₇, CuSO₄·5H₂O |
    | **Hexagonal** | a = b ≠ c | α = β = 90°, γ = 120° | Graphite, ZnO |
    | **Rhombohedral** | a = b = c | α = β = γ ≠ 90° | Calcite |

    ## Cubic Unit Cells

    ### 1. Simple Cubic (SC) / Primitive Cubic (PC)

    **Structure:**
    - Atoms at 8 corners only
    - Each corner atom shared by 8 unit cells

    **Atoms per unit cell:**
    - Corner atoms: 8 × 1/8 = **1 atom**

    **Coordination number:** 6

    **Examples:** Po (only example!)

    **Volume of unit cell:** a³
    **Relation:** If r = atomic radius, **a = 2r**

    ### 2. Body-Centered Cubic (BCC)

    **Structure:**
    - Atoms at 8 corners + 1 at body center
    - Corner atoms shared by 8 cells
    - Body center atom belongs to 1 cell

    **Atoms per unit cell:**
    - Corners: 8 × 1/8 = 1
    - Body center: 1 × 1 = 1
    - **Total: 2 atoms**

    **Coordination number:** 8

    **Examples:** Fe, Cr, Na, K, W

    **Relation:** Body diagonal = 4r
    - **√3 a = 4r**
    - **a = 4r/√3**

    ### 3. Face-Centered Cubic (FCC)

    **Structure:**
    - Atoms at 8 corners + 6 face centers
    - Corner atoms shared by 8 cells
    - Face atoms shared by 2 cells

    **Atoms per unit cell:**
    - Corners: 8 × 1/8 = 1
    - Faces: 6 × 1/2 = 3
    - **Total: 4 atoms**

    **Coordination number:** 12

    **Examples:** Cu, Ag, Au, Al, Ni, Pt

    **Relation:** Face diagonal = 4r
    - **√2 a = 4r**
    - **a = 4r/√2 = 2√2 r**

    ## Comparison: Cubic Unit Cells

    | Property | Simple Cubic | BCC | FCC |
    |----------|--------------|-----|-----|
    | Atoms/cell | 1 | 2 | 4 |
    | Coordination number | 6 | 8 | 12 |
    | a-r relation | 2r | 4r/√3 | 2√2 r |
    | Packing efficiency | 52.4% | 68% | 74% |
    | Example | Po | Fe, Na | Cu, Ag |

    ## Coordination Number

    **Definition:** Number of nearest neighbors surrounding a particle

    ### For Cubic Structures:

    - **Simple Cubic:** 6
    - **BCC:** 8
    - **FCC:** 12
    - **HCP:** 12 (hexagonal close packing)

    ### For Ionic Compounds:

    Depends on radius ratio (r⁺/r⁻):

    | r⁺/r⁻ | Coordination Number | Structure | Example |
    |-------|---------------------|-----------|---------|
    | 0.155-0.225 | 3 | Planar triangle | - |
    | 0.225-0.414 | 4 | Tetrahedral | ZnS |
    | 0.414-0.732 | 6 | Octahedral | NaCl |
    | 0.732-1.0 | 8 | Cubic | CsCl |

    ## Density Calculations

    **Formula:**

    **ρ = (Z × M) / (a³ × Nₐ)**

    Where:
    - ρ = density (g/cm³)
    - Z = atoms per unit cell
    - M = molar mass (g/mol)
    - a = edge length (cm)
    - Nₐ = Avogadro's number = 6.022 × 10²³

    **Or:** **M = (ρ × a³ × Nₐ) / Z**

    ## Solved Problems

    ### Problem 1: Calculate a from r (BCC)

    **Q: Fe crystallizes in BCC with atomic radius 1.24 Å. Calculate edge length.**

    Solution:
    - For BCC: a = 4r/√3
    - a = (4 × 1.24)/√3 = 4.96/1.732
    - **a = 2.86 Å**

    ### Problem 2: Calculate density

    **Q: Cu (FCC) has a = 3.6 Å, M = 63.5 g/mol. Calculate density.**

    Solution:
    - Z = 4 (FCC)
    - a = 3.6 Å = 3.6 × 10⁻⁸ cm
    - a³ = (3.6 × 10⁻⁸)³ = 4.67 × 10⁻²³ cm³

    ρ = (Z × M)/(a³ × Nₐ)
    = (4 × 63.5)/(4.67 × 10⁻²³ × 6.022 × 10²³)
    = 254/(4.67 × 6.022)
    = 254/28.12
    **ρ = 9.03 g/cm³**

    ### Problem 3: Atoms per unit cell

    **Q: A metal crystallizes with atoms at corners and face centers. How many atoms per unit cell?**

    Solution:
    - This is FCC
    - Corners: 8 × 1/8 = 1
    - Faces: 6 × 1/2 = 3
    - **Total: 4 atoms**

    ### Problem 4: Coordination number

    **Q: In CsCl structure, what is coordination number of Cs⁺?**

    Solution:
    - CsCl has cubic structure (not FCC NaCl type!)
    - Each Cs⁺ surrounded by 8 Cl⁻
    - **Coordination number = 8**

    ### Problem 5: Calculate M from density

    **Q: Metal (BCC) has ρ = 7.2 g/cm³, a = 2.88 × 10⁻⁸ cm. Calculate molar mass.**

    Solution:
    - Z = 2 (BCC)
    - a³ = (2.88 × 10⁻⁸)³ = 2.39 × 10⁻²³ cm³

    M = (ρ × a³ × Nₐ)/Z
    = (7.2 × 2.39 × 10⁻²³ × 6.022 × 10²³)/2
    = (7.2 × 2.39 × 6.022)/2
    = 103.4/2
    **M = 51.7 g/mol** (Close to Cr = 52)

    ## Ionic Structures

    ### 1. Rock Salt (NaCl) Structure:

    - **FCC lattice** of Cl⁻
    - Na⁺ in **octahedral voids**
    - Coordination: 6:6
    - Examples: NaCl, KCl, MgO

    ### 2. Zinc Blende (ZnS) Structure:

    - **FCC lattice** of S²⁻
    - Zn²⁺ in **alternate tetrahedral voids**
    - Coordination: 4:4
    - Examples: ZnS, CuCl

    ### 3. Fluorite (CaF₂) Structure:

    - **FCC lattice** of Ca²⁺
    - F⁻ in **all tetrahedral voids**
    - Coordination: 8:4
    - Examples: CaF₂, BaCl₂

    ### 4. Antifluorite (Na₂O) Structure:

    - **FCC lattice** of O²⁻
    - Na⁺ in **all tetrahedral voids**
    - Coordination: 4:8 (reverse of fluorite)
    - Examples: Na₂O, K₂O

    ### 5. Cesium Chloride (CsCl) Structure:

    - **Simple cubic** of Cl⁻
    - Cs⁺ at **body center**
    - Coordination: 8:8
    - Examples: CsCl, CsBr

    ## Voids in Close Packing

    ### Tetrahedral Void:

    - Formed by 4 spheres
    - **Number:** 2n (if n atoms)
    - Coordination: 4
    - Size: Can accommodate sphere with r = 0.225R

    ### Octahedral Void:

    - Formed by 6 spheres
    - **Number:** n (if n atoms)
    - Coordination: 6
    - Size: Can accommodate sphere with r = 0.414R

    ## IIT JEE Key Points

    1. **Unit cell:** Smallest repeating unit
    2. **SC:** Z = 1, CN = 6
    3. **BCC:** Z = 2, CN = 8, a = 4r/√3
    4. **FCC:** Z = 4, CN = 12, a = 2√2r
    5. **Density:** ρ = ZM/(a³Nₐ)
    6. **NaCl:** FCC of Cl⁻, 6:6 coordination
    7. **ZnS:** FCC of S²⁻, 4:4 coordination
    8. **CaF₂:** FCC of Ca²⁺, 8:4 coordination
    9. **CsCl:** Simple cubic, 8:8 coordination
    10. **Voids:** 2n tetrahedral, n octahedral

    ## Quick Reference

    | Structure | Z | CN | a-r relation |
    |-----------|---|----|--------------|
    | SC | 1 | 6 | 2r |
    | BCC | 2 | 8 | 4r/√3 |
    | FCC | 4 | 12 | 2√2r |

    | Ionic Structure | Lattice | Voids Occupied | CN |
    |-----------------|---------|----------------|-----|
    | NaCl | FCC Cl⁻ | All octahedral | 6:6 |
    | ZnS | FCC S²⁻ | Alternate tetrahedral | 4:4 |
    | CaF₂ | FCC Ca²⁺ | All tetrahedral | 8:4 |
    | CsCl | SC Cl⁻ | Body center | 8:8 |

    ## Important Formulas

    | Concept | Formula |
    |---------|---------|
    | Density | ρ = ZM/(a³Nₐ) |
    | BCC edge | a = 4r/√3 |
    | FCC edge | a = 2√2r |
    | SC edge | a = 2r |
  MD
)

ModuleItem.create!(course_module: module_12, item: lesson_12_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 12.1: #{lesson_12_1.title}"

# ========================================
# Lesson 12.2: Close Packing and Crystal Defects
# ========================================

lesson_12_2 = CourseLesson.create!(
  title: 'Close Packing, Packing Efficiency and Crystal Defects',
  reading_time_minutes: 60,
  key_concepts: ['Close packing', 'HCP', 'CCP', 'Packing efficiency', 'Schottky defect', 'Frenkel defect', 'Non-stoichiometric defects'],
  content: <<~MD
    # Close Packing, Packing Efficiency and Crystal Defects

    ## Close Packing of Spheres

    **Goal:** Arrange spheres to occupy maximum space (minimum void)

    ### Close Packing in 2D:

    **Square packing:** Efficiency = 52.4%
    **Hexagonal packing:** Efficiency = 60.4% (better)

    ### Close Packing in 3D:

    Two types: **HCP** and **CCP (FCC)**

    ## Hexagonal Close Packing (HCP)

    **Structure:**
    - Layer A: Hexagonal arrangement
    - Layer B: Spheres in depressions of A
    - Layer C: Same as A (directly above A)
    - **Stacking: ABABAB...**

    **Coordination number:** 12
    **Packing efficiency:** 74%
    **Examples:** Mg, Zn, Cd, Be

    ## Cubic Close Packing (CCP) = FCC

    **Structure:**
    - Layer A: Hexagonal arrangement
    - Layer B: Spheres in depressions of A
    - Layer C: Different positions (not above A or B)
    - **Stacking: ABCABCABC...**

    **Coordination number:** 12
    **Packing efficiency:** 74%
    **Examples:** Cu, Ag, Au, Al

    **Note:** CCP is same as FCC!

    ## Packing Efficiency

    **Definition:** Percentage of space occupied by constituent particles

    **Packing Efficiency = (Volume occupied by atoms / Total volume of unit cell) × 100**

    ### 1. Simple Cubic (SC):

    - Atoms per cell: Z = 1
    - Edge: a = 2r
    - Volume of atoms: Z × (4/3)πr³ = (4/3)πr³
    - Volume of cell: a³ = (2r)³ = 8r³

    **PE = [(4/3)πr³ / 8r³] × 100 = (π/6) × 100 = 52.4%**

    ### 2. Body-Centered Cubic (BCC):

    - Z = 2
    - a = 4r/√3
    - Volume of atoms: 2 × (4/3)πr³ = (8/3)πr³
    - Volume of cell: a³ = (4r/√3)³ = 64r³/(3√3)

    **PE = [(8πr³/3) / (64r³/3√3)] × 100 = (√3π/8) × 100 = 68%**

    ### 3. Face-Centered Cubic (FCC) / CCP:

    - Z = 4
    - a = 2√2 r
    - Volume of atoms: 4 × (4/3)πr³ = (16/3)πr³
    - Volume of cell: a³ = (2√2 r)³ = 16√2 r³

    **PE = [(16πr³/3) / (16√2 r³)] × 100 = (π/3√2) × 100 = 74%**

    ### 4. HCP:

    - Coordination: 12
    - **PE = 74%** (same as CCP/FCC)

    ## Summary: Packing Efficiency

    | Structure | Packing Efficiency |
    |-----------|--------------------|
    | Simple Cubic | 52.4% |
    | BCC | 68% |
    | FCC / CCP | 74% |
    | HCP | 74% |

    **Note:** FCC and HCP have **maximum packing efficiency** (74%)

    ## Voids in Close Packing

    ### In Close-Packed Structures (FCC/HCP):

    **Number of voids per n atoms:**
    - **Octahedral voids:** n
    - **Tetrahedral voids:** 2n

    ### Example:

    If FCC has 4 atoms per unit cell:
    - Octahedral voids: 4
    - Tetrahedral voids: 8

    ## Crystal Defects (Imperfections)

    **Definition:** Irregularities in arrangement of particles

    ### Types:

    **1. Point Defects:** Irregular arrangement at a point
    **2. Line Defects:** Irregularities along a line (dislocations)
    **3. Plane Defects:** Grain boundaries

    ## Point Defects

    ### A. Stoichiometric Defects:

    **Do not change stoichiometry**

    #### 1. Schottky Defect:

    **Definition:** Equal number of cations and anions missing from lattice

    **Characteristics:**
    - Maintains electrical neutrality
    - **Decreases density** (missing ions)
    - Found in ionic crystals with **high coordination number**
    - r⁺/r⁻ ≈ 1 (similar sized ions)

    **Examples:** NaCl, KCl, CsCl, AgBr

    **Result:** Creates vacancies, lowers density

    #### 2. Frenkel Defect:

    **Definition:** Smaller ion (usually cation) displaced to interstitial site

    **Characteristics:**
    - **No change in density** (ion just displaced)
    - Found when **large difference in ion size**
    - r⁺/r⁻ << 1 (small cation)
    - Creates vacancy + interstitial

    **Examples:** ZnS, AgCl, AgBr, AgI

    **AgBr:** Shows **both** Schottky and Frenkel defects!

    ### Comparison: Schottky vs Frenkel

    | Property | Schottky | Frenkel |
    |----------|----------|---------|
    | Missing ions | Equal cations and anions | None (displaced) |
    | Density | Decreases | No change |
    | Ion size | Similar | Different (small cation) |
    | Coordination | High (6:6, 8:8) | Low (4:4) |
    | Example | NaCl | ZnS |

    ### B. Non-Stoichiometric Defects:

    **Change in stoichiometry**

    #### 1. Metal Excess Defect:

    **Type (a): Due to anion vacancy**

    **Example:** NaCl heated in Na vapor
    - Cl⁻ leaves lattice
    - Na atoms deposit, release e⁻
    - Electron trapped in vacancy (F-center)
    - Formula: Na₁₊ₓCl

    **Result:** Yellow color (F-centers absorb light)

    **Type (b): Due to extra cation in interstitial**

    **Example:** Zn₁₊ₓO
    - Extra Zn²⁺ in interstitial
    - Extra electrons

    **Result:** Electrical conductivity increases

    #### 2. Metal Deficiency Defect:

    **Example:** FeO, FeS
    - Fe²⁺ missing from lattice
    - Some Fe²⁺ oxidized to Fe³⁺ (to maintain charge)
    - Formula: Fe₀.₉₅O or Fe₀.₉₈S

    **Found in:** Transition metal compounds

    ## F-Centers (Color Centers)

    **Definition:** Anionic sites occupied by unpaired electrons

    **Cause:** Metal excess defect (anion vacancies)

    **Effect:** Impart color to crystals
    - NaCl + Na vapor → Yellow
    - KCl + K vapor → Violet

    **Application:** Photographic process

    ## Solved Problems

    ### Problem 1: Packing efficiency of BCC

    **Q: Calculate packing efficiency of BCC.**

    Solution:
    - Z = 2, a = 4r/√3
    - Volume of atoms = 2 × (4/3)πr³
    - Volume of cell = (4r/√3)³ = 64r³/(3√3)

    PE = [2 × (4/3)πr³] / [64r³/(3√3)] × 100
    = [(8πr³/3) × (3√3)/(64r³)] × 100
    = (√3π/8) × 100
    **= 68%**

    ### Problem 2: Number of voids

    **Q: FCC unit cell has 4 atoms. How many octahedral and tetrahedral voids?**

    Solution:
    - Octahedral voids = n = **4**
    - Tetrahedral voids = 2n = **8**

    ### Problem 3: Density change

    **Q: Which defect decreases density of crystal?**

    Solution:
    **Schottky defect** (ions missing from lattice, reduces mass while volume same)

    Frenkel defect does NOT change density (ion just displaced)

    ### Problem 4: Identify defect

    **Q: AgBr shows both types of point defects. Name them.**

    Solution:
    - **Schottky defect** (both Ag⁺ and Br⁻ missing)
    - **Frenkel defect** (Ag⁺ displaced to interstitial)

    AgBr is unique in showing both!

    ### Problem 5: F-centers

    **Q: NaCl heated in Na vapor turns yellow. Explain.**

    Solution:
    - Na atoms deposit on surface
    - Cl⁻ diffuses out, creating vacancies
    - Na atoms release electrons
    - Electrons trapped in Cl⁻ vacancies (F-centers)
    - F-centers absorb light, impart yellow color

    ### Problem 6: Packing efficiency calculation

    **Q: Copper (FCC) has atomic radius 128 pm. Calculate percentage of unoccupied space.**

    Solution:
    - FCC packing efficiency = 74%
    - Unoccupied space = 100 - 74
    **= 26%**

    ## Applications of Defects

    1. **Electrical conductivity:** Metal excess defects (Zn₁₊ₓO)
    2. **Photography:** AgBr with Frenkel defect
    3. **Color:** F-centers in alkali halides
    4. **Diffusion:** Vacancy defects allow diffusion
    5. **Mechanical properties:** Dislocations affect strength

    ## IIT JEE Key Points

    1. **HCP:** ABAB stacking, PE = 74%
    2. **CCP (FCC):** ABCABC stacking, PE = 74%
    3. **PE (SC):** 52.4%
    4. **PE (BCC):** 68%
    5. **PE (FCC/HCP):** 74% (maximum)
    6. **Voids:** n octahedral, 2n tetrahedral
    7. **Schottky:** Missing ions, density ↓, NaCl
    8. **Frenkel:** Displaced ion, density same, ZnS
    9. **F-centers:** Electrons in anion vacancies, color
    10. **Metal deficiency:** Transition metal oxides (FeO)

    ## Quick Reference

    | Defect | Type | Density | Example |
    |--------|------|---------|---------|
    | Schottky | Missing ions | Decreases | NaCl |
    | Frenkel | Displaced ion | No change | ZnS |
    | Metal excess (a) | Anion vacancy | Increases | NaCl+Na |
    | Metal excess (b) | Cation interstitial | Increases | Zn₁₊ₓO |
    | Metal deficiency | Cation missing | Decreases | FeO |

    ## Important Formulas

    | Concept | Formula |
    |---------|---------|
    | PE (SC) | 52.4% |
    | PE (BCC) | 68% |
    | PE (FCC/HCP) | 74% |
    | Octahedral voids | n |
    | Tetrahedral voids | 2n |
  MD
)

ModuleItem.create!(course_module: module_12, item: lesson_12_2, sequence_order: 2, required: true)

puts "  ✓ Lesson 12.2: #{lesson_12_2.title}"

# ========================================
# Lesson 12.3: Electrical and Magnetic Properties
# ========================================

lesson_12_3 = CourseLesson.create!(
  title: 'Electrical and Magnetic Properties of Solids',
  reading_time_minutes: 50,
  key_concepts: ['Electrical conductivity', 'Conductors', 'Semiconductors', 'Insulators', 'Band theory', 'Magnetic properties', 'Ferromagnetism', 'Paramagnetism', 'Diamagnetism'],
  content: <<~MD
    # Electrical and Magnetic Properties of Solids

    ## Electrical Properties

    ### Classification Based on Conductivity:

    **1. Conductors:** High conductivity (10⁶-10⁸ S/m)
    **2. Semiconductors:** Moderate (10⁻⁴-10² S/m)
    **3. Insulators:** Very low (<10⁻¹⁰ S/m)

    ## Band Theory

    **Explains electrical properties based on energy levels**

    ### Energy Bands:

    **Valence Band (VB):**
    - Filled with electrons at 0 K
    - Electrons involved in bonding
    - Highest occupied band

    **Conduction Band (CB):**
    - Empty at 0 K
    - Electrons can move freely
    - Lowest unoccupied band

    **Band Gap (Eg):**
    - Energy difference between VB and CB
    - Determines electrical properties

    ## Types of Solids (Band Theory)

    ### 1. Conductors (Metals):

    **Characteristics:**
    - Valence band and conduction band **overlap**
    - **No band gap** (Eg = 0)
    - Electrons easily move to CB
    - Conductivity **decreases** with temperature

    **Examples:** Cu, Ag, Au, Al, Fe

    **Reason for conductivity:** Free electrons in partially filled bands

    ### 2. Insulators:

    **Characteristics:**
    - **Large band gap** (Eg > 3 eV)
    - VB completely filled
    - CB completely empty
    - Electrons cannot jump to CB easily
    - Very low conductivity

    **Examples:** Diamond (Eg = 6 eV), quartz, glass, rubber

    **Temperature effect:** Slight increase in conductivity (negligible)

    ### 3. Semiconductors:

    **Characteristics:**
    - **Small band gap** (Eg ≈ 0.1-3 eV)
    - At 0 K: Behaves like insulator
    - At room T: Some electrons jump to CB
    - Conductivity **increases** with temperature

    **Examples:**
    - Si (Eg = 1.1 eV)
    - Ge (Eg = 0.7 eV)
    - GaAs (Eg = 1.4 eV)

    ## Types of Semiconductors

    ### A. Intrinsic Semiconductors:

    **Definition:** Pure semiconductors (no impurities)

    **Examples:** Pure Si, Ge

    **Conduction:**
    - Thermal energy creates electron-hole pairs
    - Equal number of electrons and holes
    - **n = p** (n = electron concentration, p = hole concentration)

    **Conductivity:** Low (increases with temperature)

    ### B. Extrinsic Semiconductors:

    **Definition:** Doped with impurities (controlled addition)

    **Purpose:** Increase conductivity

    #### 1. n-type Semiconductor:

    **Doping:** Group 15 element (P, As, Sb) added to Si/Ge (Group 14)

    **Mechanism:**
    - Dopant has 5 valence electrons
    - 4 form bonds, 1 extra electron
    - Extra electrons in CB
    - **n >> p** (electrons are majority carriers)

    **Charge:** Negatively charged carriers (hence n-type)

    **Example:** Si doped with P

    #### 2. p-type Semiconductor:

    **Doping:** Group 13 element (B, Al, Ga, In) added to Si/Ge

    **Mechanism:**
    - Dopant has 3 valence electrons
    - Creates electron deficiency (hole)
    - Holes in VB
    - **p >> n** (holes are majority carriers)

    **Charge:** Positively charged carriers (hence p-type)

    **Example:** Si doped with B

    ## Applications of Semiconductors

    ### 1. p-n Junction Diode:

    - Allows current in one direction (rectification)
    - Used in: Power supplies, detectors

    ### 2. Transistors:

    - Amplification and switching
    - Used in: Computers, mobile phones

    ### 3. Solar Cells:

    - Photovoltaic effect
    - Converts light to electricity

    ### 4. LEDs:

    - Electroluminescence
    - Energy-efficient lighting

    ### 5. Integrated Circuits:

    - Basis of modern electronics

    ## Magnetic Properties

    **Magnetism arises from:** Motion of electrons and unpaired electron spins

    ### Types of Magnetic Materials:

    ## 1. Diamagnetic Materials

    **Characteristics:**
    - **Weakly repelled** by magnetic field
    - **No unpaired electrons**
    - Magnetic moment = 0
    - Induced magnetism opposite to applied field
    - **χ (susceptibility) is negative** and small

    **Examples:**
    - Inert gases: He, Ne, Ar
    - H₂O, NaCl
    - Organic compounds (most)
    - TiO₂, V₂O₅

    **Ions:** Zn²⁺, Cu⁺, Ga³⁺ (all paired electrons)

    ## 2. Paramagnetic Materials

    **Characteristics:**
    - **Weakly attracted** to magnetic field
    - **Have unpaired electrons**
    - Random orientation of magnetic moments
    - Become magnetic in external field
    - **χ is positive** and small

    **Examples:**
    - O₂, Cu²⁺, Fe³⁺, Cr³⁺
    - Al, Na, Mn

    **Curie Law:** χ ∝ 1/T (susceptibility decreases with temperature)

    **Magnetic moment (μ):**

    **μ = √[n(n+2)] B.M.**

    where n = number of unpaired electrons, B.M. = Bohr magneton

    ## 3. Ferromagnetic Materials

    **Characteristics:**
    - **Strongly attracted** to magnetic field
    - Can be **permanently magnetized**
    - Unpaired electrons align **parallel** (same direction)
    - Large magnetic domains
    - **χ is very large** and positive

    **Examples:** Fe, Co, Ni, CrO₂

    **Curie Temperature (Tc):**
    - Above Tc: Becomes paramagnetic
    - Below Tc: Ferromagnetic

    **Uses:** Permanent magnets, magnetic recording, transformers

    ## 4. Antiferromagnetic Materials

    **Characteristics:**
    - Unpaired electrons align **antiparallel** (opposite)
    - Net magnetic moment = 0 or small
    - Domains cancel each other

    **Examples:** MnO, MnO₂, FeO, Fe₂O₃, NiO

    **Neel Temperature (TN):**
    - Above TN: Becomes paramagnetic

    ## 5. Ferrimagnetic Materials

    **Characteristics:**
    - Antiparallel alignment but **unequal magnitudes**
    - **Net magnetic moment exists**
    - Weaker than ferromagnetic

    **Examples:** Fe₃O₄ (magnetite), ferrites (MFe₂O₄)

    **Uses:** Transformer cores, computer memory

    ## Comparison of Magnetic Properties

    | Type | Unpaired e⁻ | Alignment | Attraction | χ | Example |
    |------|-------------|-----------|------------|---|---------|
    | **Diamagnetic** | No | - | Weak repulsion | Negative | H₂O |
    | **Paramagnetic** | Yes | Random | Weak | Positive, small | O₂, Cu²⁺ |
    | **Ferromagnetic** | Yes | Parallel | Strong | Very large | Fe, Ni, Co |
    | **Antiferromagnetic** | Yes | Antiparallel equal | Very weak | Small positive | MnO |
    | **Ferrimagnetic** | Yes | Antiparallel unequal | Moderate | Large | Fe₃O₄ |

    ## Magnetic Moment Calculation

    **μ = √[n(n+2)] B.M.**

    where n = number of unpaired electrons

    ### Examples:

    **1. Fe³⁺ (3d⁵):**
    - Electronic configuration: [Ar] 3d⁵
    - All 5 electrons unpaired (Hund's rule)
    - μ = √[5(5+2)] = √35 = **5.92 B.M.**

    **2. Cu²⁺ (3d⁹):**
    - Configuration: [Ar] 3d⁹
    - 1 unpaired electron
    - μ = √[1(1+2)] = √3 = **1.73 B.M.**

    **3. Zn²⁺ (3d¹⁰):**
    - Configuration: [Ar] 3d¹⁰
    - All paired
    - **μ = 0** (diamagnetic)

    ## Solved Problems

    ### Problem 1: Conductivity vs temperature

    **Q: What happens to conductivity of metals with increase in temperature?**

    Solution:
    - In metals, increased T causes more lattice vibrations
    - Electrons collide more with vibrating atoms
    - **Conductivity decreases**

    (Opposite for semiconductors!)

    ### Problem 2: Semiconductor type

    **Q: Si is doped with B. Identify type of semiconductor.**

    Solution:
    - Si: Group 14 (4 valence e⁻)
    - B: Group 13 (3 valence e⁻)
    - Creates holes (electron deficiency)
    - **p-type semiconductor**

    ### Problem 3: Magnetic moment

    **Q: Calculate magnetic moment of Fe²⁺ (Z = 26).**

    Solution:
    - Fe²⁺: 3d⁶ configuration
    - 4 unpaired electrons (↑↑↑↑↓↓)
    - μ = √[4(4+2)] = √24
    - **μ = 4.90 B.M.**

    ### Problem 4: Identify magnetic type

    **Q: Cu²⁺ has 1 unpaired electron. What type of magnetism?**

    Solution:
    - Has unpaired electron
    - Weakly attracted to field
    - **Paramagnetic**

    ### Problem 5: Band gap

    **Q: Material has band gap 5 eV. Classify it.**

    Solution:
    - Large band gap (> 3 eV)
    - **Insulator**

    Si (1.1 eV) = semiconductor, Diamond (6 eV) = insulator

    ## IIT JEE Key Points

    1. **Conductors:** Overlapping bands, Eg = 0
    2. **Semiconductors:** Small band gap (0.1-3 eV)
    3. **Insulators:** Large band gap (> 3 eV)
    4. **n-type:** Doped with Group 15, excess electrons
    5. **p-type:** Doped with Group 13, excess holes
    6. **Diamagnetic:** No unpaired e⁻, χ negative
    7. **Paramagnetic:** Unpaired e⁻, χ positive small
    8. **Ferromagnetic:** Strong attraction, Fe, Co, Ni
    9. **μ = √[n(n+2)] B.M.**
    10. **Metal conductivity ↓ with T, semiconductor ↑**

    ## Quick Reference

    | Property | Conductor | Semiconductor | Insulator |
    |----------|-----------|---------------|-----------|
    | Band gap | 0 | 0.1-3 eV | > 3 eV |
    | Conductivity | High | Moderate | Very low |
    | T effect | Decreases | Increases | Negligible |
    | Example | Cu | Si, Ge | Diamond |

    | Magnetic Type | Unpaired e⁻ | χ | Example |
    |---------------|-------------|---|---------|
    | Diamagnetic | No | Negative | H₂O, Zn²⁺ |
    | Paramagnetic | Yes | Positive, small | O₂, Cu²⁺ |
    | Ferromagnetic | Yes | Very large | Fe, Ni, Co |

    ## Summary

    **Electrical properties** depend on band structure
    **Magnetic properties** depend on unpaired electrons

    Understanding these properties is crucial for:
    - Electronic devices (semiconductors)
    - Magnetic storage (ferromagnets)
    - Material selection in engineering
  MD
)

ModuleItem.create!(course_module: module_12, item: lesson_12_3, sequence_order: 3, required: true)

puts "  ✓ Lesson 12.3: #{lesson_12_3.title}"

# ========================================
# Quiz 12: Solid State Chemistry
# ========================================

quiz_12 = Quiz.create!(
  title: 'Solid State Chemistry Mastery',
  description: 'Comprehensive test on crystal structures, packing efficiency, defects, and electrical/magnetic properties',
  time_limit_minutes: 45,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_12, item: quiz_12, sequence_order: 4, required: true)

# Questions for Quiz 12 (10 questions)
QuizQuestion.create!([
  # Question 1: Atoms per unit cell
  {
    quiz: quiz_12,
    question_type: 'numerical',
    question_text: 'How many atoms are present in one FCC unit cell?',
    correct_answer: '4',
    tolerance: 0,
    explanation: 'FCC has atoms at 8 corners (8×1/8 = 1) and 6 face centers (6×1/2 = 3). Total = 4 atoms.',
    points: 2,
    difficulty: -0.1,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'unit_cells',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: Coordination number
  {
    quiz: quiz_12,
    question_type: 'numerical',
    question_text: 'What is the coordination number in BCC structure?',
    correct_answer: '8',
    tolerance: 0,
    explanation: 'In BCC, each atom at corner is surrounded by 8 nearest neighbors (one at center + 7 at other corners diagonally). CN = 8.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'coordination_number',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  # Question 3: Packing efficiency
  {
    quiz: quiz_12,
    question_type: 'numerical',
    question_text: 'What is the packing efficiency (in %) of FCC structure?',
    correct_answer: '74',
    tolerance: 1,
    explanation: 'FCC (also called CCP) has the maximum packing efficiency of 74%.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'packing_efficiency',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  # Question 4: Schottky vs Frenkel
  {
    quiz: quiz_12,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which defect decreases the density of a crystal?',
    options: [
      { text: 'Schottky defect', correct: true },
      { text: 'Frenkel defect', correct: false },
      { text: 'Interstitial defect', correct: false },
      { text: 'F-center', correct: false }
    ],
    explanation: 'Schottky defect involves missing ions from lattice, which decreases mass while volume remains same, hence density decreases. Frenkel involves displacement, not removal.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'crystal_defects',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 4
  },

  # Question 5: NaCl structure
  {
    quiz: quiz_12,
    question_type: 'fill_blank',
    question_text: 'In NaCl structure, the coordination number is _____:_____. (Answer format: 6:6)',
    correct_answer: '6:6',
    explanation: 'NaCl has rock salt structure where each Na⁺ is surrounded by 6 Cl⁻ and vice versa. Coordination is 6:6.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'ionic_structures',
    skill_dimension: 'recall',
    sequence_order: 5
  },

  # Question 6: Voids
  {
    quiz: quiz_12,
    question_type: 'numerical',
    question_text: 'If a close-packed structure has 4 atoms, how many tetrahedral voids are present?',
    correct_answer: '8',
    tolerance: 0,
    explanation: 'Number of tetrahedral voids = 2n, where n = number of atoms. Here n = 4, so tetrahedral voids = 2×4 = 8.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'voids',
    skill_dimension: 'problem_solving',
    sequence_order: 6
  },

  # Question 7: Semiconductor doping
  {
    quiz: quiz_12,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Silicon doped with phosphorus gives:',
    options: [
      { text: 'n-type semiconductor', correct: true },
      { text: 'p-type semiconductor', correct: false },
      { text: 'Insulator', correct: false },
      { text: 'Conductor', correct: false }
    ],
    explanation: 'P (Group 15) has 5 valence electrons. When doped in Si (Group 14), it provides extra electron, creating n-type semiconductor.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'semiconductors',
    skill_dimension: 'application',
    sequence_order: 7
  },

  # Question 8: Band theory
  {
    quiz: quiz_12,
    question_type: 'true_false',
    question_text: 'In conductors, the valence band and conduction band overlap.',
    correct_answer: 'true',
    explanation: 'TRUE. In conductors (metals), valence and conduction bands overlap, so electrons can move freely. Band gap = 0.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'band_theory',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 8
  },

  # Question 9: Magnetic property
  {
    quiz: quiz_12,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which ion is diamagnetic?',
    options: [
      { text: 'Cu²⁺', correct: false },
      { text: 'Fe³⁺', correct: false },
      { text: 'Zn²⁺', correct: true },
      { text: 'Ni²⁺', correct: false }
    ],
    explanation: 'Zn²⁺ has 3d¹⁰ configuration (all paired electrons), hence diamagnetic. Others have unpaired electrons (paramagnetic).',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'magnetic_properties',
    skill_dimension: 'application',
    sequence_order: 9
  },

  # Question 10: Ferromagnetic
  {
    quiz: quiz_12,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which are ferromagnetic substances?',
    options: [
      { text: 'Fe', correct: true },
      { text: 'Co', correct: true },
      { text: 'Ni', correct: true },
      { text: 'Al', correct: false }
    ],
    explanation: 'Fe, Co, and Ni are ferromagnetic (strongly attracted to magnetic field, can be permanently magnetized). Al is paramagnetic.',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'ferromagnetism',
    skill_dimension: 'recall',
    sequence_order: 10
  }
])

puts "  ✓ Quiz 12: #{quiz_12.quiz_questions.count} questions created"

# ========================================
# Summary
# ========================================

puts "\n" + "=" * 80
puts "MODULE 12 COMPLETE"
puts "=" * 80
puts "✅ Module: #{module_12.title}"
puts "✅ Lessons: 3"
puts "✅ Quizzes: 1"
puts "✅ Questions: #{quiz_12.quiz_questions.count}"
puts "✅ Estimated Time: #{module_12.estimated_minutes} minutes"
puts "=" * 80
puts "\n"

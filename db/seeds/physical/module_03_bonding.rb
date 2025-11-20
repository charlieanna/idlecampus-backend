# frozen_string_literal: true

# ========================================
# IIT JEE Physical Chemistry - Module 3
# Chemical Bonding & Molecular Structure
# ========================================
# Complete module with lessons and questions
# Ionic, covalent, VBT, MOT, VSEPR, hybridization
# ========================================

puts "\n" + "=" * 80
puts "MODULE 3: CHEMICAL BONDING & MOLECULAR STRUCTURE"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-physical-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Physical Chemistry course not found!"
  exit 1
end

# Create Module 3: Chemical Bonding
module_3 = course.course_modules.find_or_create_by!(slug: 'chemical-bonding-molecular-structure') do |m|
  m.title = 'Chemical Bonding & Molecular Structure'
  m.sequence_order = 3
  m.estimated_minutes = 420
  m.description = 'Ionic and covalent bonding, Lewis structures, VSEPR theory, VBT, hybridization, MOT, and molecular properties'
  m.learning_objectives = [
    'Understand ionic and covalent bonding',
    'Master Lewis structures and formal charge',
    'Apply VSEPR theory to predict molecular geometry',
    'Understand hybridization and molecular orbitals',
    'Learn bond parameters and intermolecular forces',
    'Solve IIT JEE problems on bonding and structure'
  ]
  m.published = true
end

puts "✅ Module 3: #{module_3.title}"

# ========================================
# Lesson 3.1: Ionic & Covalent Bonding
# ========================================

lesson_3_1 = CourseLesson.create!(
  title: 'Ionic & Covalent Bonding Fundamentals',
  reading_time_minutes: 45,
  key_concepts: ['Ionic bonding', 'Lattice energy', 'Covalent bonding', 'Lewis structures', 'Formal charge'],
  content: <<~MD
    # Ionic & Covalent Bonding

    ## Chemical Bonding

    **Chemical bond** = Force that holds atoms together in molecules or compounds

    **Why atoms bond:**
    - To achieve **stable electronic configuration** (usually noble gas configuration)
    - To **lower their energy** (bonded state has lower energy than isolated atoms)

    ## Kossel-Lewis Theory

    **Key Points:**
    - Atoms combine to achieve **octet** (8 electrons in valence shell)
    - Noble gases are stable (complete octet)
    - Elements gain, lose, or share electrons to achieve octet

    ## Ionic Bonding

    **Definition:** Electrostatic attraction between oppositely charged ions

    **Formation:**
    - Metal **loses electrons** → cation (+)
    - Non-metal **gains electrons** → anion (-)

    ### Example: NaCl Formation

    Na (2,8,1) → Na⁺ (2,8) + e⁻
    Cl (2,8,7) + e⁻ → Cl⁻ (2,8,8)

    Na⁺ + Cl⁻ → NaCl (ionic bond)

    ### Conditions for Ionic Bond Formation:

    1. **Low ionization energy** of metal (easy to lose electrons)
    2. **High electron affinity** of non-metal (easy to gain electrons)
    3. **High lattice energy** (energy released when ions combine)

    ### Lattice Energy

    **Definition:** Energy required to separate 1 mole of ionic solid into gaseous ions

    **NaCl(s) → Na⁺(g) + Cl⁻(g)** ΔH = +788 kJ/mol

    **Factors affecting lattice energy:**
    - **Charge of ions:** Higher charge → higher lattice energy
    - **Size of ions:** Smaller ions → higher lattice energy

    **Born-Landé equation:**
    U ∝ (Z⁺ × Z⁻)/r

    Where Z = charge, r = interionic distance

    ### Properties of Ionic Compounds:

    1. **High melting and boiling points** (strong electrostatic forces)
    2. **Hard but brittle** (ions arranged in rigid lattice)
    3. **Conduct electricity** when molten or in solution (ions are mobile)
    4. **Soluble in polar solvents** (like water)
    5. **Form crystalline solids**

    ## Covalent Bonding

    **Definition:** Sharing of electrons between atoms

    ### Formation:
    - Atoms **share electrons** to achieve octet
    - Both nuclei attracted to shared electrons

    ### Example: H₂ Formation

    H· + ·H → H:H or H-H

    Each H now has 2 electrons (like He)

    ### Example: Cl₂ Formation

    :Cl· + ·Cl: → :Cl:Cl: or Cl-Cl

    Each Cl has 8 electrons (octet)

    ## Lewis Structures (Electron Dot Structures)

    **Rules for Drawing Lewis Structures:**

    1. Count **total valence electrons**
    2. Connect atoms with **single bonds** (central atom in middle)
    3. Complete **octets** of outer atoms
    4. Place remaining electrons on **central atom**
    5. If central atom lacks octet, form **multiple bonds**

    ### Example 1: Water (H₂O)

    - Total electrons: 1+1+6 = 8
    - O is central atom
    - Two O-H bonds use 4 electrons
    - Remaining 4 on O as 2 lone pairs

    ```
        H-O-H  or  H:O:H
                      ··
    ```

    ### Example 2: Carbon Dioxide (CO₂)

    - Total electrons: 4+6+6 = 16
    - C is central atom
    - Need double bonds for C to have octet

    ```
    O=C=O  or  :O::C::O:
    ```

    ### Example 3: Nitrogen (N₂)

    - Total electrons: 5+5 = 10
    - Triple bond needed

    ```
    N≡N  or  :N:::N:
    ```

    ## Formal Charge

    **Definition:** Hypothetical charge on an atom if all bonds were purely covalent

    **Formula:**
    **Formal Charge = V - N - B/2**

    Where:
    - V = valence electrons in free atom
    - N = non-bonding electrons (lone pairs)
    - B = bonding electrons (shared electrons)

    **Simplified:**
    **FC = V - (L + B)**

    Where L = lone pair electrons, B = bonds (single=1, double=2)

    ### Example: CO₂

    ```
    O=C=O
    ```

    **For C:**
    - V = 4, L = 0, B = 4 (two double bonds)
    - FC = 4 - (0 + 4) = 0

    **For each O:**
    - V = 6, L = 4, B = 2 (one double bond)
    - FC = 6 - (4 + 2) = 0

    ### Rules for Stable Structures:

    1. **Minimize formal charges** (ideally all zero)
    2. Negative formal charge on **most electronegative** atom
    3. Adjacent atoms should not have **same sign** charges
    4. Structures with **smaller formal charges** are more stable

    ## Resonance

    **Definition:** When a molecule cannot be represented by a single Lewis structure

    ### Example: Ozone (O₃)

    Two equivalent structures:

    ```
    O-O=O  ←→  O=O-O
    ```

    **Reality:** Bonds are **identical** and **intermediate** in character
    - Bond order = 1.5 (average of single and double)
    - **Resonance hybrid** is actual structure

    ### Example: Carbonate Ion (CO₃²⁻)

    Three resonance structures (each C-O bond has order 1.33)

    ## Exceptions to Octet Rule

    ### 1. Incomplete Octet

    **BF₃:** Boron has only 6 electrons (stable)
    **BeH₂:** Beryllium has only 4 electrons

    ### 2. Expanded Octet (Hypervalency)

    Elements in **period 3 and beyond** can have > 8 electrons

    **PCl₅:** Phosphorus has 10 electrons
    **SF₆:** Sulfur has 12 electrons
    **IF₇:** Iodine has 14 electrons

    **Reason:** Availability of d-orbitals for bonding

    ### 3. Odd Electron Molecules

    **NO:** Total electrons = 11 (cannot pair all)
    **NO₂:** Total electrons = 17
    **ClO₂:** Total electrons = 19

    ## Types of Covalent Bonds

    ### By Number of Shared Electrons:

    1. **Single bond:** 1 pair shared (e.g., H-H, C-C)
    2. **Double bond:** 2 pairs shared (e.g., O=O, C=O)
    3. **Triple bond:** 3 pairs shared (e.g., N≡N, C≡C)

    ### By Electron Contribution:

    1. **Normal covalent:** Each atom contributes 1 electron
    2. **Coordinate covalent (dative):** One atom provides both electrons

    ### Coordinate Covalent Bond

    **Example: NH₃ + BF₃ → H₃N→BF₃**
    - NH₃ donates lone pair to BF₃
    - Represented by arrow (→)

    **Example: Formation of H₃O⁺**
    - H₂O + H⁺ → H₃O⁺
    - O donates lone pair to H⁺

    ## Bond Parameters

    ### 1. Bond Length
    - Distance between nuclei of bonded atoms
    - Triple < Double < Single
    - C≡C (120 pm) < C=C (134 pm) < C-C (154 pm)

    ### 2. Bond Energy
    - Energy required to break 1 mole of bonds
    - Triple > Double > Single
    - Higher bond energy → stronger bond

    ### 3. Bond Order
    - Number of electron pairs shared
    - **Bond order = (Bonding electrons - Antibonding electrons)/2**

    For Lewis structures:
    - Single bond = 1
    - Double bond = 2
    - Triple bond = 3

    Higher bond order → shorter bond length, higher bond energy

    ## IIT JEE Key Points

    1. **Ionic:** Transfer of electrons, forms ions
    2. **Covalent:** Sharing of electrons
    3. **Lattice energy ∝ (charge)²/radius**
    4. **Lewis structures:** Follow octet rule (with exceptions)
    5. **Formal charge = V - L - B**
    6. **Resonance:** Multiple valid structures
    7. **Expanded octet:** Period 3+ elements (use d-orbitals)
    8. **Bond order:** Triple > Double > Single
    9. **Bond length:** Triple < Double < Single
    10. **Coordinate bond:** One atom donates both electrons

    ## Practice Problems

    **Q1: Draw Lewis structure of HCN**

    Solution:
    - Total electrons: 1+4+5 = 10
    - H-C≡N: (H has 2, C has 8, N has 8)

    **Q2: Calculate formal charges in HCN**

    - H: 1 - (0 + 1) = 0
    - C: 4 - (0 + 4) = 0
    - N: 5 - (2 + 3) = 0

    All formal charges are zero → stable structure
  MD
)

ModuleItem.create!(course_module: module_3, item: lesson_3_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 3.1: #{lesson_3_1.title}"

# ========================================
# Lesson 3.2: VSEPR Theory & Hybridization
# ========================================

lesson_3_2 = CourseLesson.create!(
  title: 'VSEPR Theory & Hybridization',
  reading_time_minutes: 50,
  key_concepts: ['VSEPR theory', 'Molecular geometry', 'Hybridization', 'sp sp2 sp3', 'Bond angles'],
  content: <<~MD
    # VSEPR Theory & Hybridization

    ## VSEPR Theory

    **Valence Shell Electron Pair Repulsion Theory**

    **Main Principle:** Electron pairs around central atom repel each other and arrange themselves to minimize repulsion

    ### Key Concepts:

    1. Count **total electron pairs** (bonding + lone pairs) around central atom
    2. Electron pairs arrange in **3D space** to maximize distance
    3. **Lone pairs** repel more than bonding pairs
    4. Repulsion order: **LP-LP > LP-BP > BP-BP**

    ### Notation: AXₙEₘ

    - **A** = Central atom
    - **X** = Bonded atoms (bonding pairs)
    - **E** = Lone pairs
    - **n** = number of bonded atoms
    - **m** = number of lone pairs

    ## VSEPR Geometries

    ### AX₂ (2 bonding pairs, 0 lone pairs)

    **Example:** BeH₂, CO₂, BeCl₂
    - **Electron geometry:** Linear
    - **Molecular geometry:** Linear
    - **Bond angle:** 180°

    ### AX₃ (3 bonding pairs, 0 lone pairs)

    **Example:** BF₃, BCl₃
    - **Electron geometry:** Trigonal planar
    - **Molecular geometry:** Trigonal planar
    - **Bond angle:** 120°

    ### AX₂E (2 bonding, 1 lone pair)

    **Example:** SnCl₂, SO₂
    - **Electron geometry:** Trigonal planar
    - **Molecular geometry:** Bent
    - **Bond angle:** <120° (~119° for SO₂)

    ### AX₄ (4 bonding pairs, 0 lone pairs)

    **Example:** CH₄, CCl₄, SiH₄
    - **Electron geometry:** Tetrahedral
    - **Molecular geometry:** Tetrahedral
    - **Bond angle:** 109.5°

    ### AX₃E (3 bonding, 1 lone pair)

    **Example:** NH₃, PH₃
    - **Electron geometry:** Tetrahedral
    - **Molecular geometry:** Trigonal pyramidal
    - **Bond angle:** <109.5° (107° for NH₃)

    ### AX₂E₂ (2 bonding, 2 lone pairs)

    **Example:** H₂O, H₂S
    - **Electron geometry:** Tetrahedral
    - **Molecular geometry:** Bent
    - **Bond angle:** <109.5° (104.5° for H₂O)

    ### AX₅ (5 bonding pairs, 0 lone pairs)

    **Example:** PCl₅, PF₅
    - **Electron geometry:** Trigonal bipyramidal
    - **Molecular geometry:** Trigonal bipyramidal
    - **Bond angles:** 90° (axial-equatorial), 120° (equatorial-equatorial)

    ### AX₄E (4 bonding, 1 lone pair)

    **Example:** SF₄
    - **Electron geometry:** Trigonal bipyramidal
    - **Molecular geometry:** See-saw
    - Lone pair occupies equatorial position (less repulsion)

    ### AX₃E₂ (3 bonding, 2 lone pairs)

    **Example:** ClF₃, BrF₃
    - **Electron geometry:** Trigonal bipyramidal
    - **Molecular geometry:** T-shaped

    ### AX₂E₃ (2 bonding, 3 lone pairs)

    **Example:** XeF₂, I₃⁻
    - **Electron geometry:** Trigonal bipyramidal
    - **Molecular geometry:** Linear

    ### AX₆ (6 bonding pairs, 0 lone pairs)

    **Example:** SF₆
    - **Electron geometry:** Octahedral
    - **Molecular geometry:** Octahedral
    - **Bond angle:** 90°

    ### AX₅E (5 bonding, 1 lone pair)

    **Example:** BrF₅, IF₅
    - **Electron geometry:** Octahedral
    - **Molecular geometry:** Square pyramidal

    ### AX₄E₂ (4 bonding, 2 lone pairs)

    **Example:** XeF₄
    - **Electron geometry:** Octahedral
    - **Molecular geometry:** Square planar

    ## Factors Affecting Bond Angles

    1. **Lone pairs:** Compress bond angles (LP repels more)
       - CH₄ (109.5°) > NH₃ (107°) > H₂O (104.5°)

    2. **Electronegativity:** More electronegative atoms → smaller bond angle
       - NH₃ (107°) > PH₃ (93°) > AsH₃ (92°)

    3. **Multiple bonds:** Count as single electron domain

    ## Hybridization

    **Definition:** Mixing of atomic orbitals to form new hybrid orbitals suitable for bonding

    ### Why Hybridization?

    - Explains **molecular geometry**
    - Explains **equivalent bonds** in molecules
    - Example: CH₄ has 4 identical C-H bonds (not 3 p + 1 s)

    ## Types of Hybridization

    ### sp Hybridization

    **Mixing:** 1s + 1p → 2 sp orbitals

    **Geometry:** Linear
    **Bond angle:** 180°
    **Example:** BeH₂, BeCl₂, C₂H₂ (HC≡CH)

    **Carbon in acetylene (C₂H₂):**
    - sp hybrid orbitals form σ bonds
    - Two unhybridized p orbitals form two π bonds
    - C≡C: 1σ + 2π

    ### sp² Hybridization

    **Mixing:** 1s + 2p → 3 sp² orbitals

    **Geometry:** Trigonal planar
    **Bond angle:** 120°
    **Example:** BF₃, BCl₃, C₂H₄ (H₂C=CH₂)

    **Carbon in ethene (C₂H₄):**
    - sp² hybrid orbitals form σ bonds
    - One unhybridized p orbital forms π bond
    - C=C: 1σ + 1π

    ### sp³ Hybridization

    **Mixing:** 1s + 3p → 4 sp³ orbitals

    **Geometry:** Tetrahedral
    **Bond angle:** 109.5°
    **Example:** CH₄, NH₃, H₂O

    **CH₄:** All sp³ orbitals form σ bonds
    **NH₃:** 3 sp³ for bonding, 1 for lone pair
    **H₂O:** 2 sp³ for bonding, 2 for lone pairs

    ### sp³d Hybridization

    **Mixing:** 1s + 3p + 1d → 5 sp³d orbitals

    **Geometry:** Trigonal bipyramidal
    **Bond angles:** 90°, 120°
    **Example:** PCl₅, PF₅

    ### sp³d² Hybridization

    **Mixing:** 1s + 3p + 2d → 6 sp³d² orbitals

    **Geometry:** Octahedral
    **Bond angle:** 90°
    **Example:** SF₆

    ## Determining Hybridization

    **Formula:** Hybridization index = (Bonding pairs + Lone pairs)

    | Index | Hybridization | Geometry |
    |-------|---------------|----------|
    | 2 | sp | Linear |
    | 3 | sp² | Trigonal planar |
    | 4 | sp³ | Tetrahedral |
    | 5 | sp³d | Trigonal bipyramidal |
    | 6 | sp³d² | Octahedral |

    ## Solved Problems

    ### Problem 1: H₂O

    - O has 2 bonds + 2 lone pairs = 4
    - **Hybridization:** sp³
    - **Geometry:** Bent
    - **Bond angle:** 104.5°

    ### Problem 2: NH₃

    - N has 3 bonds + 1 lone pair = 4
    - **Hybridization:** sp³
    - **Geometry:** Trigonal pyramidal
    - **Bond angle:** 107°

    ### Problem 3: BF₃

    - B has 3 bonds + 0 lone pairs = 3
    - **Hybridization:** sp²
    - **Geometry:** Trigonal planar
    - **Bond angle:** 120°

    ### Problem 4: C₂H₂ (acetylene)

    - Each C has 2 σ bonds (1 to H, 1 to C)
    - **Hybridization:** sp
    - **Geometry:** Linear
    - **Bond angle:** 180°
    - Triple bond: 1σ + 2π

    ### Problem 5: PCl₅

    - P has 5 bonds + 0 lone pairs = 5
    - **Hybridization:** sp³d
    - **Geometry:** Trigonal bipyramidal
    - **Bond angles:** 90°, 120°

    ## σ and π Bonds

    ### σ (Sigma) Bond:
    - Formed by **head-on overlap**
    - Can be: s-s, s-p, p-p (along axis)
    - **Stronger** than π bond
    - **Free rotation** possible
    - Present in all bonds (single, double, triple)

    ### π (Pi) Bond:
    - Formed by **lateral overlap** of p orbitals
    - **Weaker** than σ bond
    - **No rotation** (restricted)
    - Present in double and triple bonds only

    ### Bond Composition:

    - **Single bond:** 1σ
    - **Double bond:** 1σ + 1π
    - **Triple bond:** 1σ + 2π

    ## IIT JEE Key Points

    1. **VSEPR:** Minimize electron pair repulsion
    2. **LP-LP > LP-BP > BP-BP** repulsion
    3. Lone pairs **decrease bond angles**
    4. **Hybridization** = Bonding pairs + Lone pairs
    5. **sp:** 2 (linear, 180°)
    6. **sp²:** 3 (trigonal planar, 120°)
    7. **sp³:** 4 (tetrahedral, 109.5°)
    8. **sp³d:** 5 (trigonal bipyramidal)
    9. **sp³d²:** 6 (octahedral, 90°)
    10. **Multiple bonds:** 1σ always, rest are π

    ## Quick Reference

    | Molecule | Hybridization | Shape | Angle |
    |----------|---------------|-------|-------|
    | BeCl₂ | sp | Linear | 180° |
    | BF₃ | sp² | Trigonal planar | 120° |
    | CH₄ | sp³ | Tetrahedral | 109.5° |
    | NH₃ | sp³ | Pyramidal | 107° |
    | H₂O | sp³ | Bent | 104.5° |
    | PCl₅ | sp³d | Trig. bipyramidal | 90°,120° |
    | SF₆ | sp³d² | Octahedral | 90° |
  MD
)

ModuleItem.create!(course_module: module_3, item: lesson_3_2, sequence_order: 2, required: true)

puts "  ✓ Lesson 3.2: #{lesson_3_2.title}"

# ========================================
# Lesson 3.3: Molecular Orbital Theory & Bonding Properties
# ========================================

lesson_3_3 = CourseLesson.create!(
  title: 'Molecular Orbital Theory & Bonding Properties',
  reading_time_minutes: 45,
  key_concepts: ['MOT', 'Bond order', 'Magnetic properties', 'Dipole moment', 'Hydrogen bonding'],
  content: <<~MD
    # Molecular Orbital Theory & Bonding Properties

    ## Molecular Orbital Theory (MOT)

    **Concept:** Atomic orbitals combine to form molecular orbitals that belong to the entire molecule

    ### Key Principles:

    1. **Number of MOs = Number of AOs** combined
    2. Two types: **Bonding** (lower energy) and **Antibonding** (higher energy)
    3. Electrons fill MOs according to aufbau principle
    4. **Bonding MO:** Electron density between nuclei (stabilizes)
    5. **Antibonding MO:** Electron density away from internuclear region (destabilizes)

    ## Formation of Molecular Orbitals

    ### Bonding MO (σ):
    - Formed by **constructive interference** of atomic orbitals
    - **Lower energy** than atomic orbitals
    - Electron density **concentrated between nuclei**
    - Denoted: σ, π

    ### Antibonding MO (σ*):
    - Formed by **destructive interference**
    - **Higher energy** than atomic orbitals
    - Electron density **away from nuclei**
    - Denoted: σ*, π*

    ## Energy Order of Molecular Orbitals

    ### For O₂, F₂, Ne₂:
    σ1s < σ*1s < σ2s < σ*2s < σ2pz < π2px = π2py < π*2px = π*2py < σ*2pz

    ### For B₂, C₂, N₂:
    σ1s < σ*1s < σ2s < σ*2s < π2px = π2py < σ2pz < π*2px = π*2py < σ*2pz

    **Note:** For B₂ to N₂, π2p orbitals are lower in energy than σ2pz

    ## Bond Order

    **Formula:**
    **Bond Order = (Nb - Na)/2**

    Where:
    - Nb = number of electrons in bonding MOs
    - Na = number of electrons in antibonding MOs

    **Interpretation:**
    - Bond order = 0 → molecule doesn't exist
    - Bond order = 1 → single bond
    - Bond order = 2 → double bond
    - Bond order = 3 → triple bond
    - Higher bond order → stronger bond, shorter length

    ## Molecular Orbital Diagrams

    ### H₂ (2 electrons):
    - σ1s²
    - Bond order = (2-0)/2 = **1**
    - **Diamagnetic** (all paired)
    - Stable molecule

    ### He₂ (4 electrons):
    - σ1s² σ*1s²
    - Bond order = (2-2)/2 = **0**
    - Does **not exist**

    ### O₂ (16 electrons):
    - Configuration: σ1s² σ*1s² σ2s² σ*2s² σ2pz² π2px² π2py² π*2px¹ π*2py¹
    - Bond order = (10-6)/2 = **2**
    - **Paramagnetic** (2 unpaired electrons)
    - O=O double bond

    ### N₂ (14 electrons):
    - Configuration: σ1s² σ*1s² σ2s² σ*2s² π2px² π2py² σ2pz²
    - Bond order = (10-4)/2 = **3**
    - **Diamagnetic** (all paired)
    - N≡N triple bond
    - Very strong, stable

    ### C₂ (12 electrons):
    - Bond order = (8-4)/2 = **2**
    - **Diamagnetic**

    ### B₂ (10 electrons):
    - Bond order = (6-4)/2 = **1**
    - **Paramagnetic** (2 unpaired in π orbitals)

    ## Magnetic Properties

    ### Diamagnetic:
    - All electrons **paired**
    - **Weakly repelled** by magnetic field
    - Examples: N₂, H₂, CO

    ### Paramagnetic:
    - Contains **unpaired electrons**
    - **Attracted** by magnetic field
    - Examples: O₂, B₂, NO

    ## Comparison of VBT and MOT

    | Aspect | VBT | MOT |
    |--------|-----|-----|
    | Orbitals | Atomic orbitals overlap | Form molecular orbitals |
    | Electrons | Localized between atoms | Delocalized over molecule |
    | O₂ magnetism | Cannot explain | Correctly predicts paramagnetic |
    | Bond order | Difficult to calculate | Easily calculated |
    | Resonance | Needs multiple structures | Single MO diagram |

    ## Dipole Moment

    **Definition:** Measure of polarity in a molecule

    **Formula:**
    **μ = q × d**

    Where:
    - μ = dipole moment (in Debye, D)
    - q = magnitude of charge
    - d = distance between charges

    **Unit:** Debye (D) or Coulomb·meter (C·m)
    - 1 D = 3.336 × 10⁻³⁰ C·m

    ### Polarity:

    **Polar molecules (μ ≠ 0):**
    - Asymmetric distribution of charge
    - Examples: H₂O, NH₃, HCl, CO

    **Non-polar molecules (μ = 0):**
    - Symmetric distribution of charge
    - Examples: CO₂, CH₄, BF₃, CCl₄

    ### Factors Affecting Dipole Moment:

    1. **Electronegativity difference:** Greater difference → higher dipole moment
    2. **Molecular geometry:** Symmetry can cancel dipole moments

    ### Examples:

    **H₂O (bent):**
    - Two O-H bonds are polar
    - Bent shape → dipoles don't cancel
    - **μ = 1.85 D** (polar)

    **CO₂ (linear):**
    - Two C=O bonds are polar
    - Linear shape → dipoles cancel
    - **μ = 0 D** (non-polar)

    **NH₃ (pyramidal):**
    - Three N-H bonds polar
    - Pyramidal → dipoles don't cancel
    - **μ = 1.47 D** (polar)

    **CH₄ (tetrahedral):**
    - Four C-H bonds slightly polar
    - Tetrahedral symmetry → cancel
    - **μ ≈ 0 D** (non-polar)

    ## Hydrogen Bonding

    **Definition:** Attractive interaction between H atom bonded to highly electronegative atom (F, O, N) and another electronegative atom

    **Notation:** X-H···Y

    Where X, Y = F, O, N

    ### Types:

    **1. Intermolecular H-bonding:**
    - Between different molecules
    - Examples: H₂O, HF, alcohols, carboxylic acids

    **2. Intramolecular H-bonding:**
    - Within same molecule
    - Example: o-nitrophenol

    ### Effects of H-bonding:

    1. **Increases boiling point**
       - H₂O (100°C) >> H₂S (-60°C)
       - HF (20°C) >> HCl (-85°C)

    2. **Increases solubility** in water
       - Alcohols, sugars are soluble

    3. **Decreases vapor pressure**

    4. **Increases viscosity**

    5. **Abnormal density** of ice (less dense than water)

    ### Example: Water

    - Each H₂O can form **4 H-bonds**
    - 2 through H atoms (donors)
    - 2 through lone pairs on O (acceptors)
    - Creates extensive H-bonding network
    - Explains high boiling point of water

    ## Resonance

    **Definition:** Molecule represented by two or more Lewis structures

    ### Conditions:
    1. Same arrangement of atoms
    2. Different arrangement of electrons
    3. All structures follow octet rule

    ### Example: Benzene (C₆H₆)

    - Two Kekulé structures with alternating single and double bonds
    - Reality: All C-C bonds are **equal** (intermediate between single and double)
    - Bond order = 1.5

    ### Example: Carbonate Ion (CO₃²⁻)

    - Three resonance structures
    - Each C-O bond has order = 4/3 ≈ 1.33
    - All three C-O bonds are identical

    ### Resonance Energy:
    - **Extra stability** due to resonance
    - Benzene is more stable than predicted by any single structure

    ## IIT JEE Key Points

    1. **MOT:** Explains paramagnetism of O₂
    2. **Bond order = (Nb - Na)/2**
    3. **Higher bond order** → stronger, shorter bond
    4. **Paramagnetic:** Unpaired electrons (O₂, B₂)
    5. **Diamagnetic:** All paired (N₂, H₂)
    6. **Dipole moment:** Depends on geometry
    7. **Symmetric molecules:** μ = 0 (CO₂, CH₄, BF₃)
    8. **H-bonding:** F-H···F, O-H···O, N-H···N
    9. **H-bonding increases:** BP, solubility, viscosity
    10. **Resonance:** Multiple structures, delocalized electrons

    ## Solved Problems

    ### Problem 1: Bond order of O₂⁺

    - O₂: 16 electrons, BO = 2
    - O₂⁺: 15 electrons (remove from π* orbital)
    - Configuration: ...π*2px¹ π*2py⁰
    - BO = (10-5)/2 = **2.5**
    - **Paramagnetic** (1 unpaired)

    ### Problem 2: Which is more polar: HCl or HBr?

    - Electronegativity: Cl > Br
    - HCl has greater ΔEN
    - **HCl is more polar**

    ### Problem 3: Why is H₂O liquid but H₂S gas at room temperature?

    - H₂O has strong **H-bonding** (O is highly electronegative)
    - H₂S cannot form H-bonding (S less electronegative)
    - H₂O has much higher BP
    - **H₂O is liquid, H₂S is gas**

    ## Quick Reference

    | Molecule | Bond Order | Magnetic | Bond |
    |----------|------------|----------|------|
    | H₂ | 1 | Diamagnetic | Single |
    | He₂ | 0 | - | No bond |
    | N₂ | 3 | Diamagnetic | Triple |
    | O₂ | 2 | Paramagnetic | Double |
    | F₂ | 1 | Diamagnetic | Single |
    | B₂ | 1 | Paramagnetic | Single |
    | C₂ | 2 | Diamagnetic | Double |
  MD
)

ModuleItem.create!(course_module: module_3, item: lesson_3_3, sequence_order: 3, required: true)

puts "  ✓ Lesson 3.3: #{lesson_3_3.title}"

# ========================================
# Quiz 3: Chemical Bonding & Molecular Structure
# ========================================

quiz_3 = Quiz.create!(
  title: 'Chemical Bonding & Molecular Structure Mastery',
  description: 'Comprehensive test on bonding theories, VSEPR, hybridization, and MOT',
  time_limit_minutes: 50,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_3, item: quiz_3, sequence_order: 4, required: true)

# Questions for Quiz 3 (12 questions)
QuizQuestion.create!([
  # Question 1: Formal charge
  {
    quiz: quiz_3,
    question_type: 'numerical',
    question_text: 'Calculate the formal charge on the central carbon atom in CO₂. (C has 4 valence electrons, 0 lone pairs, and 4 bonds in O=C=O)',
    correct_answer: '0',
    tolerance: 0,
    explanation: 'Formal charge = V - L - B = 4 - 0 - 4 = 0. The central carbon has zero formal charge.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'formal_charge',
    skill_dimension: 'application',
    sequence_order: 1
  },

  # Question 2: VSEPR geometry
  {
    quiz: quiz_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the molecular geometry of NH₃?',
    options: [
      { text: 'Tetrahedral', correct: false },
      { text: 'Trigonal pyramidal', correct: true },
      { text: 'Trigonal planar', correct: false },
      { text: 'Bent', correct: false }
    ],
    explanation: 'NH₃ has 3 bonding pairs and 1 lone pair (sp³ hybridized). The molecular geometry is trigonal pyramidal with bond angle ~107°.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'vsepr_theory',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  # Question 3: Hybridization
  {
    quiz: quiz_3,
    question_type: 'fill_blank',
    question_text: 'What is the hybridization of carbon in ethene (C₂H₄)?',
    correct_answer: 'sp2|sp²',
    explanation: 'In ethene, each carbon forms 3 σ bonds (2 with H, 1 with C) and 1 π bond. This requires sp² hybridization.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'hybridization',
    skill_dimension: 'application',
    sequence_order: 3
  },

  # Question 4: Bond angles
  {
    quiz: quiz_3,
    question_type: 'sequence',
    question_text: 'Arrange the following molecules in order of INCREASING bond angle:',
    sequence_items: [
      { id: 1, text: 'H₂O (104.5°)' },
      { id: 2, text: 'NH₃ (107°)' },
      { id: 3, text: 'CH₄ (109.5°)' },
      { id: 4, text: 'BF₃ (120°)' }
    ],
    correct_answer: '1,2,3,4',
    explanation: 'H₂O (104.5°) < NH₃ (107°) < CH₄ (109.5°) < BF₃ (120°). Lone pairs decrease bond angles: 2 LP < 1 LP < 0 LP.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.04,
    difficulty_level: 'medium',
    topic: 'bond_angles',
    skill_dimension: 'application',
    sequence_order: 4
  },

  # Question 5: MOT bond order
  {
    quiz: quiz_3,
    question_type: 'numerical',
    question_text: 'Calculate the bond order of O₂ molecule. (O₂ has 10 bonding and 6 antibonding electrons)',
    correct_answer: '2',
    tolerance: 0,
    explanation: 'Bond order = (Nb - Na)/2 = (10 - 6)/2 = 2. O₂ has a double bond.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'mot_bond_order',
    skill_dimension: 'problem_solving',
    sequence_order: 5
  },

  # Question 6: Paramagnetism
  {
    quiz: quiz_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following molecules is paramagnetic?',
    options: [
      { text: 'N₂', correct: false },
      { text: 'O₂', correct: true },
      { text: 'F₂', correct: false },
      { text: 'H₂', correct: false }
    ],
    explanation: 'O₂ has 2 unpaired electrons in π* orbitals, making it paramagnetic. N₂, F₂, and H₂ have all electrons paired (diamagnetic).',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'magnetic_properties',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 6
  },

  # Question 7: Sigma and pi bonds
  {
    quiz: quiz_3,
    question_type: 'numerical',
    question_text: 'How many sigma (σ) and pi (π) bonds are present in C₂H₂ (acetylene)? Give the total number of bonds (σ + π).',
    correct_answer: '5',
    tolerance: 0,
    explanation: 'C₂H₂ has: 2 C-H bonds (2σ) + C≡C (1σ + 2π) = 3σ + 2π = 5 total bonds',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'sigma_pi_bonds',
    skill_dimension: 'problem_solving',
    sequence_order: 7
  },

  # Question 8: Dipole moment
  {
    quiz: quiz_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which molecule has zero dipole moment due to symmetry?',
    options: [
      { text: 'H₂O', correct: false },
      { text: 'NH₃', correct: false },
      { text: 'CO₂', correct: true },
      { text: 'HCl', correct: false }
    ],
    explanation: 'CO₂ is linear (O=C=O). The two C=O dipoles are equal and opposite, canceling each other. Net dipole moment = 0.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'dipole_moment',
    skill_dimension: 'application',
    sequence_order: 8
  },

  # Question 9: Hydrogen bonding
  {
    quiz: quiz_3,
    question_type: 'true_false',
    question_text: 'Hydrogen bonding can only occur when hydrogen is bonded to F, O, or N.',
    correct_answer: 'true',
    explanation: 'TRUE. Hydrogen bonding requires H bonded to highly electronegative atoms (F, O, N) which create significant partial positive charge on H.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'hydrogen_bonding',
    skill_dimension: 'recall',
    sequence_order: 9
  },

  # Question 10: Exceptions to octet
  {
    quiz: quiz_3,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following molecules have expanded octets?',
    options: [
      { text: 'PCl₅', correct: true },
      { text: 'SF₆', correct: true },
      { text: 'BF₃', correct: false },
      { text: 'CH₄', correct: false }
    ],
    explanation: 'PCl₅ (10 electrons on P) and SF₆ (12 electrons on S) have expanded octets using d-orbitals. BF₃ has incomplete octet (6 on B), CH₄ follows octet.',
    points: 4,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'octet_exceptions',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 10
  },

  # Question 11: Resonance
  {
    quiz: quiz_3,
    question_type: 'numerical',
    question_text: 'In benzene (C₆H₆), what is the C-C bond order? (Benzene has 3 double and 3 single bonds in resonance)',
    correct_answer: '1.5',
    tolerance: 0.1,
    explanation: 'Benzene has two resonance structures with alternating single and double bonds. The actual C-C bond order = (1+2)/2 = 1.5',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'resonance',
    skill_dimension: 'application',
    sequence_order: 11
  },

  # Question 12: Complex geometry
  {
    quiz: quiz_3,
    question_type: 'fill_blank',
    question_text: 'What is the molecular geometry of XeF₄ which has 4 bonding pairs and 2 lone pairs?',
    correct_answer: 'square planar',
    explanation: 'XeF₄ is AX₄E₂ (sp³d² hybridization). With 4 bonds and 2 lone pairs in octahedral arrangement, molecular geometry is square planar.',
    points: 4,
    difficulty: 0.7,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'vsepr_theory',
    skill_dimension: 'problem_solving',
    sequence_order: 12
  }
])

puts "  ✓ Quiz 3: #{quiz_3.quiz_questions.count} questions created"

# ========================================
# Summary
# ========================================

puts "\n" + "=" * 80
puts "MODULE 3 COMPLETE"
puts "=" * 80
puts "✅ Module: #{module_3.title}"
puts "✅ Lessons: 3"
puts "✅ Quizzes: 1"
puts "✅ Questions: #{quiz_3.quiz_questions.count}"
puts "✅ Estimated Time: #{module_3.estimated_minutes} minutes"
puts "=" * 80
puts "\n"

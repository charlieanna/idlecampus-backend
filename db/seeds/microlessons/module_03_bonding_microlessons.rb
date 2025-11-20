# AUTO-GENERATED from module_03_bonding.rb
puts "Creating Microlessons for Chemical Bonding Molecular Structure..."

module_var = CourseModule.find_by(slug: 'chemical-bonding-molecular-structure')

# === MICROLESSON 1: vsepr_theory — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'vsepr_theory — Practice',
  content: <<~MARKDOWN,
# vsepr_theory — Practice 🚀

XeF₄ is AX₄E₂ (sp³d² hybridization). With 4 bonds and 2 lone pairs in octahedral arrangement, molecular geometry is square planar.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['vsepr_theory'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the molecular geometry of XeF₄ which has 4 bonding pairs and 2 lone pairs?',
    answer: 'square planar',
    explanation: 'XeF₄ is AX₄E₂ (sp³d² hybridization). With 4 bonds and 2 lone pairs in octahedral arrangement, molecular geometry is square planar.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: VSEPR Theory & Hybridization ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'VSEPR Theory & Hybridization',
  content: <<~MARKDOWN,
# VSEPR Theory & Hybridization 🚀

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

## Key Points

- VSEPR theory

- Molecular geometry

- Hybridization
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['VSEPR theory', 'Molecular geometry', 'Hybridization', 'sp sp2 sp3', 'Bond angles'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Molecular Orbital Theory & Bonding Properties ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Molecular Orbital Theory & Bonding Properties',
  content: <<~MARKDOWN,
# Molecular Orbital Theory & Bonding Properties 🚀

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

## Key Points

- MOT

- Bond order

- Magnetic properties
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['MOT', 'Bond order', 'Magnetic properties', 'Dipole moment', 'Hydrogen bonding'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Ionic & Covalent Bonding Fundamentals ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ionic & Covalent Bonding Fundamentals',
  content: <<~MARKDOWN,
# Ionic & Covalent Bonding Fundamentals 🚀

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

## Key Points

- Ionic bonding

- Lattice energy

- Covalent bonding
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ionic bonding', 'Lattice energy', 'Covalent bonding', 'Lewis structures', 'Formal charge'],
  prerequisite_ids: []
)

# === MICROLESSON 5: VSEPR Theory & Hybridization ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'VSEPR Theory & Hybridization',
  content: <<~MARKDOWN,
# VSEPR Theory & Hybridization 🚀

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

## Key Points

- VSEPR theory

- Molecular geometry

- Hybridization
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['VSEPR theory', 'Molecular geometry', 'Hybridization', 'sp sp2 sp3', 'Bond angles'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Molecular Orbital Theory & Bonding Properties ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Molecular Orbital Theory & Bonding Properties',
  content: <<~MARKDOWN,
# Molecular Orbital Theory & Bonding Properties 🚀

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

## Key Points

- MOT

- Bond order

- Magnetic properties
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['MOT', 'Bond order', 'Magnetic properties', 'Dipole moment', 'Hydrogen bonding'],
  prerequisite_ids: []
)

# === MICROLESSON 7: formal_charge — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'formal_charge — Practice',
  content: <<~MARKDOWN,
# formal_charge — Practice 🚀

Formal charge = V - L - B = 4 - 0 - 4 = 0. The central carbon has zero formal charge.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['formal_charge'],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the formal charge on the central carbon atom in CO₂. (C has 4 valence electrons, 0 lone pairs, and 4 bonds in O=C=O)',
    answer: '0',
    explanation: 'Formal charge = V - L - B = 4 - 0 - 4 = 0. The central carbon has zero formal charge.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: vsepr_theory — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'vsepr_theory — Practice',
  content: <<~MARKDOWN,
# vsepr_theory — Practice 🚀

NH₃ has 3 bonding pairs and 1 lone pair (sp³ hybridized). The molecular geometry is trigonal pyramidal with bond angle ~107°.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['vsepr_theory'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the molecular geometry of NH₃?',
    options: ['Tetrahedral', 'Trigonal pyramidal', 'Trigonal planar', 'Bent'],
    correct_answer: 1,
    explanation: 'NH₃ has 3 bonding pairs and 1 lone pair (sp³ hybridized). The molecular geometry is trigonal pyramidal with bond angle ~107°.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: hybridization — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'hybridization — Practice',
  content: <<~MARKDOWN,
# hybridization — Practice 🚀

In ethene, each carbon forms 3 σ bonds (2 with H, 1 with C) and 1 π bond. This requires sp² hybridization.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['hybridization'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the hybridization of carbon in ethene (C₂H₄)?',
    answer: 'sp2|sp²',
    explanation: 'In ethene, each carbon forms 3 σ bonds (2 with H, 1 with C) and 1 π bond. This requires sp² hybridization.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: bond_angles — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'bond_angles — Practice',
  content: <<~MARKDOWN,
# bond_angles — Practice 🚀

H₂O (104.5°) < NH₃ (107°) < CH₄ (109.5°) < BF₃ (120°). Lone pairs decrease bond angles: 2 LP < 1 LP < 0 LP.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['bond_angles'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following molecules in order of INCREASING bond angle:',
    answer: '1,2,3,4',
    explanation: 'H₂O (104.5°) < NH₃ (107°) < CH₄ (109.5°) < BF₃ (120°). Lone pairs decrease bond angles: 2 LP < 1 LP < 0 LP.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: mot_bond_order — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'mot_bond_order — Practice',
  content: <<~MARKDOWN,
# mot_bond_order — Practice 🚀

Bond order = (Nb - Na)/2 = (10 - 6)/2 = 2. O₂ has a double bond.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['mot_bond_order'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the bond order of O₂ molecule. (O₂ has 10 bonding and 6 antibonding electrons)',
    answer: '2',
    explanation: 'Bond order = (Nb - Na)/2 = (10 - 6)/2 = 2. O₂ has a double bond.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: magnetic_properties — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'magnetic_properties — Practice',
  content: <<~MARKDOWN,
# magnetic_properties — Practice 🚀

O₂ has 2 unpaired electrons in π* orbitals, making it paramagnetic. N₂, F₂, and H₂ have all electrons paired (diamagnetic).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['magnetic_properties'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following molecules is paramagnetic?',
    options: ['N₂', 'O₂', 'F₂', 'H₂'],
    correct_answer: 1,
    explanation: 'O₂ has 2 unpaired electrons in π* orbitals, making it paramagnetic. N₂, F₂, and H₂ have all electrons paired (diamagnetic).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 13: sigma_pi_bonds — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'sigma_pi_bonds — Practice',
  content: <<~MARKDOWN,
# sigma_pi_bonds — Practice 🚀

C₂H₂ has: 2 C-H bonds (2σ) + C≡C (1σ + 2π) = 3σ + 2π = 5 total bonds

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['sigma_pi_bonds'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many sigma (σ) and pi (π) bonds are present in C₂H₂ (acetylene)? Give the total number of bonds (σ + π).',
    answer: '5',
    explanation: 'C₂H₂ has: 2 C-H bonds (2σ) + C≡C (1σ + 2π) = 3σ + 2π = 5 total bonds',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: dipole_moment — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'dipole_moment — Practice',
  content: <<~MARKDOWN,
# dipole_moment — Practice 🚀

CO₂ is linear (O=C=O). The two C=O dipoles are equal and opposite, canceling each other. Net dipole moment = 0.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['dipole_moment'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which molecule has zero dipole moment due to symmetry?',
    options: ['H₂O', 'NH₃', 'CO₂', 'HCl'],
    correct_answer: 2,
    explanation: 'CO₂ is linear (O=C=O). The two C=O dipoles are equal and opposite, canceling each other. Net dipole moment = 0.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 15: hydrogen_bonding — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'hydrogen_bonding — Practice',
  content: <<~MARKDOWN,
# hydrogen_bonding — Practice 🚀

TRUE. Hydrogen bonding requires H bonded to highly electronegative atoms (F, O, N) which create significant partial positive charge on H.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['hydrogen_bonding'],
  prerequisite_ids: []
)

# Exercise 15.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Hydrogen bonding can only occur when hydrogen is bonded to F, O, or N.',
    answer: 'true',
    explanation: 'TRUE. Hydrogen bonding requires H bonded to highly electronegative atoms (F, O, N) which create significant partial positive charge on H.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 16: octet_exceptions — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'octet_exceptions — Practice',
  content: <<~MARKDOWN,
# octet_exceptions — Practice 🚀

PCl₅ (10 electrons on P) and SF₆ (12 electrons on S) have expanded octets using d-orbitals. BF₃ has incomplete octet (6 on B), CH₄ follows octet.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['octet_exceptions'],
  prerequisite_ids: []
)

# Exercise 16.2: MCQ
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following molecules have expanded octets?',
    options: ['PCl₅', 'SF₆', 'BF₃', 'CH₄'],
    correct_answer: 1,
    explanation: 'PCl₅ (10 electrons on P) and SF₆ (12 electrons on S) have expanded octets using d-orbitals. BF₃ has incomplete octet (6 on B), CH₄ follows octet.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 17: resonance — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'resonance — Practice',
  content: <<~MARKDOWN,
# resonance — Practice 🚀

Benzene has two resonance structures with alternating single and double bonds. The actual C-C bond order = (1+2)/2 = 1.5

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['resonance'],
  prerequisite_ids: []
)

# Exercise 17.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In benzene (C₆H₆), what is the C-C bond order? (Benzene has 3 double and 3 single bonds in resonance)',
    answer: '1.5',
    explanation: 'Benzene has two resonance structures with alternating single and double bonds. The actual C-C bond order = (1+2)/2 = 1.5',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 18: Ionic & Covalent Bonding Fundamentals ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ionic & Covalent Bonding Fundamentals',
  content: <<~MARKDOWN,
# Ionic & Covalent Bonding Fundamentals 🚀

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

## Key Points

- Ionic bonding

- Lattice energy

- Covalent bonding
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ionic bonding', 'Lattice energy', 'Covalent bonding', 'Lewis structures', 'Formal charge'],
  prerequisite_ids: []
)

puts "✓ Created 18 microlessons for Chemical Bonding Molecular Structure"

# AUTO-GENERATED from module_06_stereochemistry.rb
puts "Creating Microlessons for Module 06 Stereochemistry..."

module_var = CourseModule.find_by(slug: 'module-06-stereochemistry')

# === MICROLESSON 1: What is the approximate energy (in kJ/mol) of the gauche conformation of butane relative to the anti conformation? ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the approximate energy (in kJ/mol) of the gauche conformation of butane relative to the anti conformation?',
  content: <<~MARKDOWN,
# What is the approximate energy (in kJ/mol) of the gauche conformation of butane relative to the anti conformation? 🚀

The gauche conformation of butane is approximately 3.8 kJ/mol higher in energy than the anti conformation due to steric repulsion between the two CH₃ groups that are 60° apart.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
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
    question: 'What is the approximate energy (in kJ/mol) of the gauche conformation of butane relative to the anti conformation?',
    answer: '3.8',
    explanation: 'The gauche conformation of butane is approximately 3.8 kJ/mol higher in energy than the anti conformation due to steric repulsion between the two CH₃ groups that are 60° apart.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Optical Isomerism - Chirality, Enantiomers, and Optical Activity ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Optical Isomerism - Chirality, Enantiomers, and Optical Activity',
  content: <<~MARKDOWN,
# Optical Isomerism - Chirality, Enantiomers, and Optical Activity 🚀

# Optical Isomerism and Chirality

    ## 1. What is Chirality?

    ### Definition
    **Chirality** (from Greek "cheir" = hand) means "handedness". A molecule is **chiral** if it is **non-superimposable on its mirror image**.

    **Analogy:** Your left and right hands are mirror images but cannot be superimposed perfectly.

    ### Achiral vs Chiral
    - **Achiral:** Superimposable on mirror image (has symmetry)
    - **Chiral:** Non-superimposable on mirror image (no symmetry)

    **Example:**
    ```
    Achiral: CH₃Cl (has plane of symmetry)
    Chiral:  CHBrClF (no plane of symmetry)
    ```

    ---

    ## 2. Chiral Center (Stereogenic Center)

    ### Definition
    A **chiral center** is a carbon atom bonded to **four different groups**.

    **Notation:** Often marked with an asterisk (*)

    ### Identifying Chiral Centers

    **Example 1: 2-Butanol**
    ```
           OH
           |
    CH₃ — C* — H
           |
           CH₂CH₃

    Four different groups: -CH₃, -OH, -H, -CH₂CH₃
    ✓ Chiral center
    ```

    **Example 2: 2-Propanol**
    ```
           OH
           |
    CH₃ — C — H
           |
           CH₃

    Two identical CH₃ groups
    ✗ NOT a chiral center
    ```

    ### Conditions for Chirality
    1. **sp³ hybridized carbon** (tetrahedral)
    2. **Four different substituents**
    3. **No plane of symmetry** in the molecule

    ---

    ## 3. Enantiomers

    ### Definition
    **Enantiomers** are **non-superimposable mirror images** of each other.

    ### Properties of Enantiomers

    | Property | Enantiomer 1 | Enantiomer 2 |
    |----------|--------------|--------------|
    | **Physical properties** | Identical | Identical |
    | **Melting point** | Same | Same |
    | **Boiling point** | Same | Same |
    | **Solubility** | Same | Same |
    | **Refractive index** | Same | Same |
    | **Optical rotation** | +θ (dextrorotatory, d or +) | -θ (levorotatory, l or -) |
    | **Magnitude of rotation** | Same | Same (opposite sign) |
    | **Chemical reactions** | Same (with achiral reagents) | Different (with chiral reagents) |

    **Key point:** Enantiomers differ ONLY in:
    1. Direction of plane-polarized light rotation
    2. Reactions with chiral molecules
    3. Biological activity

    ---

    ## 4. Optical Activity

    ### Definition
    **Optical activity** is the ability to rotate the plane of **plane-polarized light**.

    ### Polarimeter
    - **Instrument** used to measure optical rotation
    - **Components:** Light source → Polarizer → Sample tube → Analyzer → Observer

    ### Terminology
    - **Dextrorotatory (d or +):** Rotates light clockwise (to the right)
    - **Levorotatory (l or -):** Rotates light counterclockwise (to the left)
    - **Optically active:** Rotates plane-polarized light
    - **Optically inactive:** Does not rotate light

    ### Specific Rotation [α]

    **Formula:**
    ```
    [α]ᴰᵗ = α / (l × c)

    Where:
    [α]ᴰᵗ = Specific rotation at temperature t using D-line of sodium (589 nm)
    α = Observed rotation (in degrees)
    l = Path length (in decimeters, dm)
    c = Concentration (g/mL for solutions, or density for pure liquids)
    ```

    **Units:** degrees·mL/(g·dm) or deg·mL·g⁻¹·dm⁻¹

    **Example Problem:**
    A solution of 2.0 g of compound in 50 mL solvent, placed in a 2 dm tube, shows +15° rotation. Calculate [α].

    **Solution:**
    ```
    c = 2.0 g / 50 mL = 0.04 g/mL
    l = 2 dm
    α = +15°

    [α] = 15° / (2 × 0.04) = +187.5°
    ```

    ---

    ## 5. R/S Nomenclature (Cahn-Ingold-Prelog Rules)

    ### Why R/S System?
    - d/l (or +/-) tells direction of rotation but NOT configuration
    - R/S system describes **absolute configuration** of chiral center

    ### Steps to Assign R or S

    **Step 1: Assign priorities (1-4) to four groups**
    - **Rule 1:** Higher atomic number = Higher priority
    - **Rule 2:** If tied, look at next atoms
    - **Rule 3:** Double/triple bonds count as duplicate/triplicate atoms

    **Priority order (common groups):**
    ```
    I > Br > Cl > S > F > O > N > C > ³H > ²H > ¹H

    For carbon groups:
    -COOH > -CHO > -CH₂OH > -CH₃ > -H
    ```

    **Step 2: Orient molecule**
    - Place **lowest priority (4) away from you** (going into the page)

    **Step 3: Trace path 1 → 2 → 3**
    - **Clockwise → R (Rectus = right)**
    - **Counterclockwise → S (Sinister = left)**

    ### Example: 2-Butanol

    ```
           OH (2)
           |
    CH₃ —  C* — H (4)
    (3)    |
           CH₂CH₃ (1)

    Priorities:
    1. -CH₂CH₃ (starts with C, then C,H,H)
    2. -OH (O has higher atomic number than C)
    3. -CH₃ (starts with C, then H,H,H)
    4. -H (lowest)

    Put H away from you, trace 1→2→3:
    Clockwise → R configuration → (R)-2-butanol
    ```

    ---

    ## 6. Racemic Mixture

    ### Definition
    A **racemic mixture** (or racemate) is a **1:1 mixture** of two enantiomers.

    **Notation:** (±) or (d,l) or rac-

    ### Properties
    - **Optically inactive** (equal and opposite rotations cancel out)
    - **Melting point** may differ from pure enantiomers
    - **Cannot be separated** by normal methods (achiral techniques)

    ### Racemization
    Conversion of one enantiomer to a racemic mixture.

    **Example:** SN1 reactions at chiral centers often give racemic products (carbocation intermediate is planar, achiral).

    ---

    ## 7. Meso Compounds

    ### Definition
    **Meso compounds** have chiral centers but are **optically inactive** due to an **internal plane of symmetry**.

    ### Characteristics
    - Contains chiral centers (2 or more)
    - Has plane of symmetry (achiral overall)
    - Optically inactive
    - Superimposable on mirror image

    ### Example: meso-Tartaric Acid

    ```
         COOH              COOH
         |                 |
    H — C* — OH      HO — C* — H
         |                 |
    H — C* — OH      HO — C* — H
         |                 |
         COOH              COOH

    (2R,3S)                (same as above due to symmetry)

    Has plane of symmetry between C-2 and C-3
    → Optically INACTIVE (meso compound)
    ```

    **Comparison with other tartaric acid isomers:**
    - **(2R,3R)-Tartaric acid:** Optically active, (+) enantiomer
    - **(2S,3S)-Tartaric acid:** Optically active, (-) enantiomer
    - **(2R,3S)-Tartaric acid:** meso form, optically inactive

    ---

    ## 8. Number of Stereoisomers

    ### Formula for Compounds with n Chiral Centers

    **General rule:**
    ```
    Maximum stereoisomers = 2ⁿ (where n = number of chiral centers)
    ```

    **But:** If there is symmetry (meso forms), actual number < 2ⁿ

    ### Examples

    **Example 1: 2-Butanol (n = 1)**
    ```
    2¹ = 2 stereoisomers (R and S enantiomers)
    ```

    **Example 2: Tartaric acid (n = 2)**
    ```
    2² = 4 possible stereoisomers
    Actual = 3 [(2R,3R), (2S,3S), meso (2R,3S)]
    (2R,3S) is identical to (2S,3R) due to symmetry
    ```

    **Example 3: 2,3-Dibromopentane (n = 2, no symmetry)**
    ```
    2² = 4 stereoisomers (all distinct)
    - (2R,3R) and (2S,3S) - pair of enantiomers
    - (2R,3S) and (2S,3R) - another pair of enantiomers
    ```

    ---

    ## 9. Diastereomers (Preview)

    ### Definition
    **Diastereomers** are stereoisomers that are **NOT mirror images** of each other.

    ### Characteristics
    - Different physical properties (mp, bp, solubility)
    - Different optical rotations
    - Can be separated by normal methods

    **Example:** (2R,3R) and (2R,3S) are diastereomers (not mirror images)

    ---

    ## Important Points for IIT JEE

    1. **Chiral center identification:**
       - Look for sp³ carbon with 4 different groups
       - Watch out for pseudo-chiral centers

    2. **Optical activity requires:**
       - No plane of symmetry
       - Pure enantiomer (not racemic mixture)
       - Not a meso compound

    3. **R/S assignment:**
       - Practice priority rules
       - Remember to put group 4 away from you
       - Common mistake: forgetting to account for perspective

    4. **Meso compounds:**
       - Must have internal plane of symmetry
       - Always optically inactive despite having chiral centers

    5. **Specific rotation calculations:**
       - Units matter (dm, g/mL)
       - Sign indicates direction of rotation
       - Magnitude does NOT correlate with R/S

    ---

    ## Practice Questions

    1. Identify all chiral centers in: CH₃-CHBr-CHCl-COOH
    2. Calculate specific rotation if 0.5 g in 25 mL shows +10° in a 1 dm tube
    3. Assign R or S to: CHBrClF (with given 3D structure)
    4. How many stereoisomers does 2,3,4-trihydroxybutanal have?
    5. Why is meso-tartaric acid optically inactive?

## Key Points

- Chirality and chiral centers

- Enantiomers and mirror images

- Optical activity and specific rotation
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Chirality and chiral centers', 'Enantiomers and mirror images', 'Optical activity and specific rotation', 'R/S nomenclature (Cahn-Ingold-Prelog rules)', 'Racemic mixtures and meso compounds'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Geometrical Isomerism and Conformational Analysis ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Geometrical Isomerism and Conformational Analysis',
  content: <<~MARKDOWN,
# Geometrical Isomerism and Conformational Analysis 🚀

# Geometrical Isomerism and Conformational Analysis

    ## 1. Geometrical Isomerism (cis-trans Isomerism)

    ### Definition
    **Geometrical isomerism** arises due to **restricted rotation** around a bond, leading to different spatial arrangements of groups.

    ### Requirements for Geometrical Isomerism
    1. **Restricted rotation:**
       - C=C double bond (π bond prevents rotation)
       - Cyclic structures (ring restricts rotation)
    2. **Different groups** on each carbon of the double bond

    ### Example: 2-Butene

    **Does NOT show geometrical isomerism:**
    ```
    CH₃-CH=CH₂  (Propene)

    One carbon has two H atoms → No geometrical isomerism
    ```

    **Shows geometrical isomerism:**
    ```
    Cis-2-butene:            Trans-2-butene:
         CH₃    CH₃               CH₃    H
          \    /                   \    /
           C=C                      C=C
          /    \                   /    \
         H      H                 H      CH₃

    (Z)-2-butene              (E)-2-butene
    Same side                 Opposite sides
    ```

    ---

    ## 2. cis-trans Nomenclature

    ### Rules
    - **cis:** Similar/higher priority groups on the **same side** of the double bond
    - **trans:** Similar/higher priority groups on **opposite sides**

    ### Limitations
    - Works well when each C has one H and one substituent
    - Ambiguous for more complex cases

    **Example: 1,2-Dichloroethene**
    ```
    cis-1,2-dichloroethene:     trans-1,2-dichloroethene:
         Cl     Cl                  Cl     H
          \    /                     \    /
           C=C                        C=C
          /    \                     /    \
         H      H                   H      Cl
    ```

    ---

    ## 3. E-Z Nomenclature (IUPAC System)

    ### Why E-Z System?
    - **More systematic** than cis-trans
    - Works for all cases, including complex substituents
    - Based on **Cahn-Ingold-Prelog priority rules**

    ### Rules
    1. **Assign priorities** to groups on each carbon (same as R/S)
    2. Compare highest priority groups on each C:
       - **Z (Zusammen = together):** Higher priority groups on **same side**
       - **E (Entgegen = opposite):** Higher priority groups on **opposite sides**

    ### Example 1: 2-Butene

    ```
    C-1: -CH₃ (higher) vs -H (lower)
    C-2: -CH₃ (higher) vs -H (lower)

    (Z)-2-butene:              (E)-2-butene:
         CH₃(high) CH₃(high)       CH₃(high)  H(low)
          \        /                \        /
           C  =  C                   C  =  C
          /        \                /        \
         H(low)  H(low)            H(low)  CH₃(high)

    High groups same side → Z    High groups opposite → E
    ```

    ### Example 2: 1-Bromo-1-chloropropene

    ```
         Br     CH₂CH₃              Br     H
          \    /                     \    /
           C=C                        C=C
          /    \                     /    \
         Cl     H                   Cl     CH₂CH₃

    (Z)-1-Bromo-1-chloro-      (E)-1-Bromo-1-chloro-
    propene                     propene

    C-1: Br > Cl               C-1: Br > Cl
    C-2: -CH₂CH₃ > -H          C-2: -CH₂CH₃ > -H
    ```

    ---

    ## 4. Properties of Geometrical Isomers

    ### Physical Properties

    | Property | cis-Isomer | trans-Isomer |
    |----------|-----------|--------------|
    | **Polarity** | More polar (dipoles don't cancel) | Less polar or nonpolar (dipoles may cancel) |
    | **Boiling point** | Higher (more polar) | Lower |
    | **Melting point** | Lower (less symmetric) | Higher (more symmetric, better packing) |
    | **Solubility** | More soluble in polar solvents | More soluble in nonpolar solvents |
    | **Stability** | Less stable (steric repulsion) | More stable (less steric repulsion) |

    ### Example: 2-Butene

    | Property | cis-2-butene | trans-2-butene |
    |----------|--------------|----------------|
    | Boiling point | 3.7°C | 0.9°C |
    | Melting point | -139°C | -106°C |
    | Dipole moment | 0.33 D | 0 D |
    | Stability | Less stable | More stable |

    **trans is more stable:** Less steric repulsion between bulky groups

    ---

    ## 5. Geometrical Isomerism in Cyclic Compounds

    ### Cycloalkanes
    Ring restricts rotation, allowing cis-trans isomerism.

    **Example: 1,2-Dimethylcyclopropane**
    ```
    cis-1,2-Dimethylcyclopropane:  trans-1,2-Dimethylcyclopropane:

         CH₃                            CH₃
          |                              |
       /——⌴——\                         /——⌴——\
      |       |                        |       |
      \———————/                        \———————/
          |                                  |
         CH₃                                CH₃

    (both CH₃ on same side)           (CH₃ on opposite sides)
    ```

    ---

    ## 6. Conformational Isomerism

    ### Definition
    **Conformational isomers (conformers)** arise from **rotation around single bonds** (σ bonds).

    ### Key Points
    - **Interconvert rapidly** at room temperature
    - **Energy barrier** is low (typically 10-20 kJ/mol)
    - Cannot be isolated separately at room temperature
    - **Different energies** (some conformers more stable than others)

    ---

    ## 7. Newman Projections

    ### What are Newman Projections?
    - **2D representation** of 3D molecular conformation
    - View along a C-C bond axis
    - **Front carbon:** Dot at center
    - **Back carbon:** Circle

    **Example: Ethane (CH₃-CH₃)**
    ```
    View along C-C bond:

           H                    H
           |                    |
       H — C — C — H   →    H-⊙-H  (Newman projection)
           |   |               |
           H   H               H

    Front C (dot) has 3 H
    Back C (circle) has 3 H
    ```

    ---

    ## 8. Conformations of Ethane

    ### Staggered Conformation
    - **Definition:** Bonds on adjacent carbons are **60° apart**
    - **Energy:** Lowest energy (most stable)
    - **Reason:** Maximum separation of electron clouds (minimum repulsion)

    **Newman projection:**
    ```
           H
           |
       H-⊙-H
          |
          H

    Dihedral angle = 60°
    Minimum torsional strain
    ```

    ### Eclipsed Conformation
    - **Definition:** Bonds on adjacent carbons **overlap** (0° dihedral angle)
    - **Energy:** Highest energy (least stable)
    - **Reason:** Maximum electron repulsion (torsional strain)

    **Newman projection:**
    ```
          H
          |
       H-⊙-H
          |
          H

    Dihedral angle = 0°
    Maximum torsional strain
    ```

    ### Energy Diagram

    ```
    Energy
      ↑
      |     Eclipsed         Eclipsed         Eclipsed
      |        /\              /\               /\
    12|       /  \            /  \             /  \
    kJ|      /    \          /    \           /    \
    /mol   /      \        /      \         /      \
      |   /________\______/________\______/_________\____
      |   Staggered       Staggered        Staggered
      |
      └────────────────────────────────────────────────→
          0°    60°   120°  180°  240°  300°  360°
                         Dihedral angle
    ```

    **Energy difference:** ~12 kJ/mol (rotation barrier)

    ---

    ## 9. Conformations of Butane

    ### Four Key Conformations

    Looking down C2-C3 bond of CH₃-CH₂-CH₂-CH₃:

    #### 1. Anti (Most Stable)
    - **Dihedral angle:** 180°
    - **Energy:** 0 kJ/mol (reference)
    - **Groups:** Two CH₃ groups as far apart as possible

    ```
           CH₃
            |
        H-⊙-H
           |
           H

    Anti conformation
    CH₃ groups 180° apart
    ```

    #### 2. Gauche (Stable)
    - **Dihedral angle:** 60° (or 300°)
    - **Energy:** +3.8 kJ/mol
    - **Reason:** Steric repulsion between two CH₃ groups

    ```
          CH₃
           |
       H-⊙-H
          |
          H

    Gauche conformation
    CH₃ groups 60° apart
    ```

    #### 3. Eclipsed (H-H)
    - **Dihedral angle:** 0° (or 120° or 240°)
    - **Energy:** +14 kJ/mol
    - **Reason:** Torsional strain (H-H eclipsing) + some CH₃-H repulsion

    #### 4. Eclipsed (CH₃-CH₃) - Least Stable
    - **Dihedral angle:** 0°
    - **Energy:** +19 kJ/mol
    - **Reason:** Maximum steric strain (CH₃-CH₃ eclipsing)

    ### Energy Diagram for Butane

    ```
    Energy
      ↑
      |        Eclipsed                    Eclipsed
      |        CH₃-CH₃                     CH₃-CH₃
    19|           /\                          /\
    kJ|          /  \                        /  \
    /mol       /    \                      /    \
    14|       /      \    Eclipsed        /      \
      |      /        \   H-H            /        \
     4|     /  Gauche  \    /\          /  Gauche  \
      |    /            \  /  \        /            \
      |___/______________\/_____\_____/_____________\___
      |  Anti                           Anti
      |
      └────────────────────────────────────────────────→
         0°    60°   120°  180°  240°  300°  360°
                        Dihedral angle
    ```

    ---

    ## 10. Types of Strain

    ### 1. Torsional Strain
    - **Cause:** Repulsion between **electrons in eclipsed bonds**
    - **Example:** Eclipsed ethane
    - **Energy:** ~4 kJ/mol per eclipsed H-H interaction

    ### 2. Steric Strain (Van der Waals Strain)
    - **Cause:** Repulsion between **atoms or groups** that are too close
    - **Example:** Gauche butane (CH₃ groups close)
    - **Energy:** Depends on size of groups

    ### 3. Angle Strain
    - **Cause:** Deviation from ideal bond angles (109.5° for sp³)
    - **Example:** Cyclopropane (60° vs 109.5°)
    - Not covered in conformational analysis

    ---

    ## 11. Comparison: Geometrical vs Conformational Isomerism

    | Property | Geometrical | Conformational |
    |----------|------------|----------------|
    | **Cause** | Restricted rotation (C=C or ring) | Rotation around single bond |
    | **Interconversion** | Requires bond breaking | Free rotation (low barrier) |
    | **Isolation** | Can be isolated | Cannot be isolated (rapid equilibrium) |
    | **Energy difference** | Large (~250 kJ/mol to rotate C=C) | Small (10-20 kJ/mol) |
    | **Examples** | cis/trans-2-butene | Staggered/eclipsed ethane |

    ---

    ## Important Points for IIT JEE

    1. **Geometrical isomerism requires:**
       - Restricted rotation (C=C or ring)
       - Different groups on each C of the double bond
       - Does NOT occur if any C has two identical groups

    2. **E-Z vs cis-trans:**
       - Use E-Z for complex molecules
       - Remember: Z = Zusammen (same side), E = Entgegen (opposite)

    3. **Stability:**
       - trans-alkenes more stable than cis (less steric strain)
       - Anti conformation most stable (groups 180° apart)
       - Eclipsed conformations least stable

    4. **Newman projections:**
       - Practice drawing and identifying conformations
       - Staggered: 60° dihedral angles
       - Eclipsed: 0° dihedral angles

    5. **Energy barriers:**
       - Ethane rotation barrier: ~12 kJ/mol
       - Butane rotation barrier: ~19 kJ/mol (CH₃-CH₃ eclipsed)
       - C=C rotation: ~250 kJ/mol (requires bond breaking)

    ---

    ## Practice Questions

    1. Draw cis and trans isomers of 2-pentene
    2. Assign E or Z to: CHCl=CHBr (with priorities)
    3. Draw Newman projections for all staggered and eclipsed conformations of propane
    4. Why is trans-2-butene more stable than cis-2-butene?
    5. What is the energy difference between anti and gauche conformations of butane?

## Key Points

- Geometrical isomerism (cis-trans)

- E-Z nomenclature

- Conformational isomerism
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Geometrical isomerism (cis-trans)', 'E-Z nomenclature', 'Conformational isomerism', 'Newman projections', 'Eclipsed and staggered conformations', 'Torsional and steric strain'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Introduction to Isomerism - Structural vs Stereoisomerism ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Isomerism - Structural vs Stereoisomerism',
  content: <<~MARKDOWN,
# Introduction to Isomerism - Structural vs Stereoisomerism 🚀

# Introduction to Isomerism

    ## 1. What is Isomerism?

    ### Definition
    **Isomers** are compounds with the **same molecular formula** but **different structures** or **spatial arrangements**.

    **Example:**
    ```
    C₄H₁₀ has two isomers:

    1. n-Butane:     CH₃-CH₂-CH₂-CH₃
    2. Isobutane:    CH₃-CH(CH₃)-CH₃
    ```

    Both have the same molecular formula (C₄H₁₀) but different structures.

    ---

    ## 2. Types of Isomerism

    ```
    ISOMERISM
    │
    ├── STRUCTURAL ISOMERISM (Constitutional Isomerism)
    │   ├── Chain/Skeletal Isomerism
    │   ├── Position Isomerism
    │   ├── Functional Group Isomerism
    │   ├── Metamerism
    │   └── Tautomerism
    │
    └── STEREOISOMERISM (Spatial Isomerism)
        ├── CONFIGURATIONAL ISOMERISM
        │   ├── Optical Isomerism (Enantiomers, Diastereomers)
        │   └── Geometrical Isomerism (cis-trans, E-Z)
        │
        └── CONFORMATIONAL ISOMERISM
            └── Conformers (Rotational isomers)
    ```

    ---

    ## 3. Structural Isomerism

    ### A. Chain Isomerism (Skeletal Isomerism)
    Isomers differ in the **carbon skeleton** (branching pattern).

    **Example: C₅H₁₂ (Pentane)**
    ```
    1. n-Pentane:        CH₃-CH₂-CH₂-CH₂-CH₃

    2. Isopentane:       CH₃-CH(CH₃)-CH₂-CH₃

    3. Neopentane:       C(CH₃)₄
    ```

    ### B. Position Isomerism
    Isomers differ in the **position of functional group** or substituent on the same carbon chain.

    **Example: C₃H₇Cl (Chloropropane)**
    ```
    1. 1-Chloropropane:  CH₃-CH₂-CH₂-Cl

    2. 2-Chloropropane:  CH₃-CHCl-CH₃
    ```

    **Example: C₃H₈O (Propanol)**
    ```
    1. 1-Propanol:       CH₃-CH₂-CH₂-OH

    2. 2-Propanol:       CH₃-CH(OH)-CH₃
    ```

    ### C. Functional Group Isomerism
    Isomers have **different functional groups**.

    **Example: C₃H₆O**
    ```
    1. Propanal (aldehyde):     CH₃-CH₂-CHO

    2. Propanone (ketone):      CH₃-CO-CH₃

    3. Allyl alcohol:           CH₂=CH-CH₂-OH

    4. Propylene oxide:         CH₃-CH-CH₂
                                    \__O__/
    ```

    **Common functional group isomer pairs:**
    - **Alcohols** and **Ethers**: CₙH₂ₙ₊₂O
    - **Aldehydes** and **Ketones**: CₙH₂ₙO
    - **Carboxylic acids** and **Esters**: CₙH₂ₙO₂
    - **Alkynes** and **Dienes**: CₙH₂ₙ₋₂

    ### D. Metamerism
    Isomers differ in the **distribution of carbon atoms around a functional group** (special case of position isomerism for ethers, ketones, etc.).

    **Example: C₄H₁₀O (Ethers)**
    ```
    1. Diethyl ether:            CH₃-CH₂-O-CH₂-CH₃

    2. Methyl propyl ether:      CH₃-O-CH₂-CH₂-CH₃
    ```

    ### E. Tautomerism (Dynamic Isomerism)
    Isomers exist in **equilibrium** by migration of a proton and shift of a double bond.

    **Example: Keto-Enol Tautomerism**
    ```
    Keto form              ⇌              Enol form
    CH₃-CO-CH₃                            CH₂=C(OH)-CH₃
    (Acetone, 99.99%)                     (<0.01%)
    ```

    **Example: Phenol (no tautomerism):**
    - Phenol does NOT show keto-enol tautomerism because it would lose aromatic stability

    ---

    ## 4. Stereoisomerism - Introduction

    ### Definition
    **Stereoisomers** have the same structural formula but differ in **spatial arrangement** of atoms.

    ### Key Difference from Structural Isomers
    - **Structural isomers:** Different connectivity of atoms
    - **Stereoisomers:** Same connectivity, different 3D arrangement

    ### Types of Stereoisomerism

    #### A. Configurational Isomerism
    - **Configuration** is **fixed** and cannot be interconverted without breaking bonds
    - Two types:
      1. **Optical isomerism** (chirality-based)
      2. **Geometrical isomerism** (restricted rotation)

    #### B. Conformational Isomerism
    - **Conformers** can be interconverted by **rotation** around single bonds
    - No bond breaking required
    - Rapidly interconverting at room temperature

    ---

    ## 5. Configurational vs Conformational Isomers

    | Property | Configurational | Conformational |
    |----------|-----------------|----------------|
    | **Bond breaking** | Required | Not required |
    | **Interconversion** | Not possible at room temp | Rapid at room temp |
    | **Energy barrier** | High | Low |
    | **Stability** | Fixed | Different conformers have different energies |
    | **Isolation** | Can be isolated | Usually cannot be isolated |
    | **Examples** | Enantiomers, cis-trans | Eclipsed, staggered |

    ---

    ## 6. Importance of Stereochemistry

    ### In Biological Systems
    - **Drug activity:** Only one stereoisomer may be active
    - **Example:** L-DOPA (Parkinson's treatment) vs D-DOPA (inactive)
    - **Example:** Thalidomide - one enantiomer caused birth defects

    ### In Chemical Reactions
    - **Selectivity:** Reactions may produce specific stereoisomers
    - **Mechanism understanding:** Stereochemistry reveals reaction pathways

    ### In IIT JEE
    - **High weightage topic** (5-8% of organic chemistry)
    - **Conceptual questions** on chirality, optical activity, R/S nomenclature
    - **Numerical problems** on specific rotation
    - **Mechanism questions** involving stereochemistry

    ---

    ## 7. Key Terms to Remember

    | Term | Definition |
    |------|------------|
    | **Isomers** | Same molecular formula, different structure/arrangement |
    | **Constitutional isomers** | Different connectivity (structural isomers) |
    | **Stereoisomers** | Same connectivity, different spatial arrangement |
    | **Configuration** | Fixed 3D arrangement (requires bond breaking to change) |
    | **Conformation** | Spatial arrangement from rotation (no bond breaking) |
    | **Chirality** | Non-superimposable on mirror image |
    | **Enantiomers** | Non-superimposable mirror images |
    | **Diastereomers** | Non-mirror image stereoisomers |

    ---

    ## Important Points for IIT JEE

    1. **Count all possible isomers systematically:**
       - Start with straight chain, then branched
       - Consider all positions for functional groups
       - Don't forget stereoisomers

    2. **Identify isomer type:**
       - Check molecular formula first
       - Determine connectivity (structural vs stereoisomerism)
       - Check for chirality or restricted rotation

    3. **Tautomerism requires:**
       - α-hydrogen (H on carbon adjacent to C=O)
       - Enolizable hydrogen
       - Usually keto form is more stable

    4. **Functional group isomerism:**
       - Memorize common pairs (alcohol-ether, aldehyde-ketone, etc.)
       - Useful for identifying unknown compounds

    ---

    ## Practice Questions

    1. How many structural isomers does C₅H₁₂ have?
    2. Draw all position isomers of C₄H₉Cl
    3. Give functional group isomers of C₃H₆O
    4. What is the difference between configurational and conformational isomers?
    5. Which compounds show tautomerism: (a) Acetone (b) Phenol (c) Acetaldehyde?

## Key Points

- Types of isomerism

- Structural isomerism (chain, position, functional)

- Stereoisomerism overview
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Types of isomerism', 'Structural isomerism (chain, position, functional)', 'Stereoisomerism overview', 'Configurational vs conformational isomers', 'Molecular formulas and isomer counting'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Optical Isomerism - Chirality, Enantiomers, and Optical Activity ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Optical Isomerism - Chirality, Enantiomers, and Optical Activity',
  content: <<~MARKDOWN,
# Optical Isomerism - Chirality, Enantiomers, and Optical Activity 🚀

# Optical Isomerism and Chirality

    ## 1. What is Chirality?

    ### Definition
    **Chirality** (from Greek "cheir" = hand) means "handedness". A molecule is **chiral** if it is **non-superimposable on its mirror image**.

    **Analogy:** Your left and right hands are mirror images but cannot be superimposed perfectly.

    ### Achiral vs Chiral
    - **Achiral:** Superimposable on mirror image (has symmetry)
    - **Chiral:** Non-superimposable on mirror image (no symmetry)

    **Example:**
    ```
    Achiral: CH₃Cl (has plane of symmetry)
    Chiral:  CHBrClF (no plane of symmetry)
    ```

    ---

    ## 2. Chiral Center (Stereogenic Center)

    ### Definition
    A **chiral center** is a carbon atom bonded to **four different groups**.

    **Notation:** Often marked with an asterisk (*)

    ### Identifying Chiral Centers

    **Example 1: 2-Butanol**
    ```
           OH
           |
    CH₃ — C* — H
           |
           CH₂CH₃

    Four different groups: -CH₃, -OH, -H, -CH₂CH₃
    ✓ Chiral center
    ```

    **Example 2: 2-Propanol**
    ```
           OH
           |
    CH₃ — C — H
           |
           CH₃

    Two identical CH₃ groups
    ✗ NOT a chiral center
    ```

    ### Conditions for Chirality
    1. **sp³ hybridized carbon** (tetrahedral)
    2. **Four different substituents**
    3. **No plane of symmetry** in the molecule

    ---

    ## 3. Enantiomers

    ### Definition
    **Enantiomers** are **non-superimposable mirror images** of each other.

    ### Properties of Enantiomers

    | Property | Enantiomer 1 | Enantiomer 2 |
    |----------|--------------|--------------|
    | **Physical properties** | Identical | Identical |
    | **Melting point** | Same | Same |
    | **Boiling point** | Same | Same |
    | **Solubility** | Same | Same |
    | **Refractive index** | Same | Same |
    | **Optical rotation** | +θ (dextrorotatory, d or +) | -θ (levorotatory, l or -) |
    | **Magnitude of rotation** | Same | Same (opposite sign) |
    | **Chemical reactions** | Same (with achiral reagents) | Different (with chiral reagents) |

    **Key point:** Enantiomers differ ONLY in:
    1. Direction of plane-polarized light rotation
    2. Reactions with chiral molecules
    3. Biological activity

    ---

    ## 4. Optical Activity

    ### Definition
    **Optical activity** is the ability to rotate the plane of **plane-polarized light**.

    ### Polarimeter
    - **Instrument** used to measure optical rotation
    - **Components:** Light source → Polarizer → Sample tube → Analyzer → Observer

    ### Terminology
    - **Dextrorotatory (d or +):** Rotates light clockwise (to the right)
    - **Levorotatory (l or -):** Rotates light counterclockwise (to the left)
    - **Optically active:** Rotates plane-polarized light
    - **Optically inactive:** Does not rotate light

    ### Specific Rotation [α]

    **Formula:**
    ```
    [α]ᴰᵗ = α / (l × c)

    Where:
    [α]ᴰᵗ = Specific rotation at temperature t using D-line of sodium (589 nm)
    α = Observed rotation (in degrees)
    l = Path length (in decimeters, dm)
    c = Concentration (g/mL for solutions, or density for pure liquids)
    ```

    **Units:** degrees·mL/(g·dm) or deg·mL·g⁻¹·dm⁻¹

    **Example Problem:**
    A solution of 2.0 g of compound in 50 mL solvent, placed in a 2 dm tube, shows +15° rotation. Calculate [α].

    **Solution:**
    ```
    c = 2.0 g / 50 mL = 0.04 g/mL
    l = 2 dm
    α = +15°

    [α] = 15° / (2 × 0.04) = +187.5°
    ```

    ---

    ## 5. R/S Nomenclature (Cahn-Ingold-Prelog Rules)

    ### Why R/S System?
    - d/l (or +/-) tells direction of rotation but NOT configuration
    - R/S system describes **absolute configuration** of chiral center

    ### Steps to Assign R or S

    **Step 1: Assign priorities (1-4) to four groups**
    - **Rule 1:** Higher atomic number = Higher priority
    - **Rule 2:** If tied, look at next atoms
    - **Rule 3:** Double/triple bonds count as duplicate/triplicate atoms

    **Priority order (common groups):**
    ```
    I > Br > Cl > S > F > O > N > C > ³H > ²H > ¹H

    For carbon groups:
    -COOH > -CHO > -CH₂OH > -CH₃ > -H
    ```

    **Step 2: Orient molecule**
    - Place **lowest priority (4) away from you** (going into the page)

    **Step 3: Trace path 1 → 2 → 3**
    - **Clockwise → R (Rectus = right)**
    - **Counterclockwise → S (Sinister = left)**

    ### Example: 2-Butanol

    ```
           OH (2)
           |
    CH₃ —  C* — H (4)
    (3)    |
           CH₂CH₃ (1)

    Priorities:
    1. -CH₂CH₃ (starts with C, then C,H,H)
    2. -OH (O has higher atomic number than C)
    3. -CH₃ (starts with C, then H,H,H)
    4. -H (lowest)

    Put H away from you, trace 1→2→3:
    Clockwise → R configuration → (R)-2-butanol
    ```

    ---

    ## 6. Racemic Mixture

    ### Definition
    A **racemic mixture** (or racemate) is a **1:1 mixture** of two enantiomers.

    **Notation:** (±) or (d,l) or rac-

    ### Properties
    - **Optically inactive** (equal and opposite rotations cancel out)
    - **Melting point** may differ from pure enantiomers
    - **Cannot be separated** by normal methods (achiral techniques)

    ### Racemization
    Conversion of one enantiomer to a racemic mixture.

    **Example:** SN1 reactions at chiral centers often give racemic products (carbocation intermediate is planar, achiral).

    ---

    ## 7. Meso Compounds

    ### Definition
    **Meso compounds** have chiral centers but are **optically inactive** due to an **internal plane of symmetry**.

    ### Characteristics
    - Contains chiral centers (2 or more)
    - Has plane of symmetry (achiral overall)
    - Optically inactive
    - Superimposable on mirror image

    ### Example: meso-Tartaric Acid

    ```
         COOH              COOH
         |                 |
    H — C* — OH      HO — C* — H
         |                 |
    H — C* — OH      HO — C* — H
         |                 |
         COOH              COOH

    (2R,3S)                (same as above due to symmetry)

    Has plane of symmetry between C-2 and C-3
    → Optically INACTIVE (meso compound)
    ```

    **Comparison with other tartaric acid isomers:**
    - **(2R,3R)-Tartaric acid:** Optically active, (+) enantiomer
    - **(2S,3S)-Tartaric acid:** Optically active, (-) enantiomer
    - **(2R,3S)-Tartaric acid:** meso form, optically inactive

    ---

    ## 8. Number of Stereoisomers

    ### Formula for Compounds with n Chiral Centers

    **General rule:**
    ```
    Maximum stereoisomers = 2ⁿ (where n = number of chiral centers)
    ```

    **But:** If there is symmetry (meso forms), actual number < 2ⁿ

    ### Examples

    **Example 1: 2-Butanol (n = 1)**
    ```
    2¹ = 2 stereoisomers (R and S enantiomers)
    ```

    **Example 2: Tartaric acid (n = 2)**
    ```
    2² = 4 possible stereoisomers
    Actual = 3 [(2R,3R), (2S,3S), meso (2R,3S)]
    (2R,3S) is identical to (2S,3R) due to symmetry
    ```

    **Example 3: 2,3-Dibromopentane (n = 2, no symmetry)**
    ```
    2² = 4 stereoisomers (all distinct)
    - (2R,3R) and (2S,3S) - pair of enantiomers
    - (2R,3S) and (2S,3R) - another pair of enantiomers
    ```

    ---

    ## 9. Diastereomers (Preview)

    ### Definition
    **Diastereomers** are stereoisomers that are **NOT mirror images** of each other.

    ### Characteristics
    - Different physical properties (mp, bp, solubility)
    - Different optical rotations
    - Can be separated by normal methods

    **Example:** (2R,3R) and (2R,3S) are diastereomers (not mirror images)

    ---

    ## Important Points for IIT JEE

    1. **Chiral center identification:**
       - Look for sp³ carbon with 4 different groups
       - Watch out for pseudo-chiral centers

    2. **Optical activity requires:**
       - No plane of symmetry
       - Pure enantiomer (not racemic mixture)
       - Not a meso compound

    3. **R/S assignment:**
       - Practice priority rules
       - Remember to put group 4 away from you
       - Common mistake: forgetting to account for perspective

    4. **Meso compounds:**
       - Must have internal plane of symmetry
       - Always optically inactive despite having chiral centers

    5. **Specific rotation calculations:**
       - Units matter (dm, g/mL)
       - Sign indicates direction of rotation
       - Magnitude does NOT correlate with R/S

    ---

    ## Practice Questions

    1. Identify all chiral centers in: CH₃-CHBr-CHCl-COOH
    2. Calculate specific rotation if 0.5 g in 25 mL shows +10° in a 1 dm tube
    3. Assign R or S to: CHBrClF (with given 3D structure)
    4. How many stereoisomers does 2,3,4-trihydroxybutanal have?
    5. Why is meso-tartaric acid optically inactive?

## Key Points

- Chirality and chiral centers

- Enantiomers and mirror images

- Optical activity and specific rotation
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Chirality and chiral centers', 'Enantiomers and mirror images', 'Optical activity and specific rotation', 'R/S nomenclature (Cahn-Ingold-Prelog rules)', 'Racemic mixtures and meso compounds'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Geometrical Isomerism and Conformational Analysis ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Geometrical Isomerism and Conformational Analysis',
  content: <<~MARKDOWN,
# Geometrical Isomerism and Conformational Analysis 🚀

# Geometrical Isomerism and Conformational Analysis

    ## 1. Geometrical Isomerism (cis-trans Isomerism)

    ### Definition
    **Geometrical isomerism** arises due to **restricted rotation** around a bond, leading to different spatial arrangements of groups.

    ### Requirements for Geometrical Isomerism
    1. **Restricted rotation:**
       - C=C double bond (π bond prevents rotation)
       - Cyclic structures (ring restricts rotation)
    2. **Different groups** on each carbon of the double bond

    ### Example: 2-Butene

    **Does NOT show geometrical isomerism:**
    ```
    CH₃-CH=CH₂  (Propene)

    One carbon has two H atoms → No geometrical isomerism
    ```

    **Shows geometrical isomerism:**
    ```
    Cis-2-butene:            Trans-2-butene:
         CH₃    CH₃               CH₃    H
          \    /                   \    /
           C=C                      C=C
          /    \                   /    \
         H      H                 H      CH₃

    (Z)-2-butene              (E)-2-butene
    Same side                 Opposite sides
    ```

    ---

    ## 2. cis-trans Nomenclature

    ### Rules
    - **cis:** Similar/higher priority groups on the **same side** of the double bond
    - **trans:** Similar/higher priority groups on **opposite sides**

    ### Limitations
    - Works well when each C has one H and one substituent
    - Ambiguous for more complex cases

    **Example: 1,2-Dichloroethene**
    ```
    cis-1,2-dichloroethene:     trans-1,2-dichloroethene:
         Cl     Cl                  Cl     H
          \    /                     \    /
           C=C                        C=C
          /    \                     /    \
         H      H                   H      Cl
    ```

    ---

    ## 3. E-Z Nomenclature (IUPAC System)

    ### Why E-Z System?
    - **More systematic** than cis-trans
    - Works for all cases, including complex substituents
    - Based on **Cahn-Ingold-Prelog priority rules**

    ### Rules
    1. **Assign priorities** to groups on each carbon (same as R/S)
    2. Compare highest priority groups on each C:
       - **Z (Zusammen = together):** Higher priority groups on **same side**
       - **E (Entgegen = opposite):** Higher priority groups on **opposite sides**

    ### Example 1: 2-Butene

    ```
    C-1: -CH₃ (higher) vs -H (lower)
    C-2: -CH₃ (higher) vs -H (lower)

    (Z)-2-butene:              (E)-2-butene:
         CH₃(high) CH₃(high)       CH₃(high)  H(low)
          \        /                \        /
           C  =  C                   C  =  C
          /        \                /        \
         H(low)  H(low)            H(low)  CH₃(high)

    High groups same side → Z    High groups opposite → E
    ```

    ### Example 2: 1-Bromo-1-chloropropene

    ```
         Br     CH₂CH₃              Br     H
          \    /                     \    /
           C=C                        C=C
          /    \                     /    \
         Cl     H                   Cl     CH₂CH₃

    (Z)-1-Bromo-1-chloro-      (E)-1-Bromo-1-chloro-
    propene                     propene

    C-1: Br > Cl               C-1: Br > Cl
    C-2: -CH₂CH₃ > -H          C-2: -CH₂CH₃ > -H
    ```

    ---

    ## 4. Properties of Geometrical Isomers

    ### Physical Properties

    | Property | cis-Isomer | trans-Isomer |
    |----------|-----------|--------------|
    | **Polarity** | More polar (dipoles don't cancel) | Less polar or nonpolar (dipoles may cancel) |
    | **Boiling point** | Higher (more polar) | Lower |
    | **Melting point** | Lower (less symmetric) | Higher (more symmetric, better packing) |
    | **Solubility** | More soluble in polar solvents | More soluble in nonpolar solvents |
    | **Stability** | Less stable (steric repulsion) | More stable (less steric repulsion) |

    ### Example: 2-Butene

    | Property | cis-2-butene | trans-2-butene |
    |----------|--------------|----------------|
    | Boiling point | 3.7°C | 0.9°C |
    | Melting point | -139°C | -106°C |
    | Dipole moment | 0.33 D | 0 D |
    | Stability | Less stable | More stable |

    **trans is more stable:** Less steric repulsion between bulky groups

    ---

    ## 5. Geometrical Isomerism in Cyclic Compounds

    ### Cycloalkanes
    Ring restricts rotation, allowing cis-trans isomerism.

    **Example: 1,2-Dimethylcyclopropane**
    ```
    cis-1,2-Dimethylcyclopropane:  trans-1,2-Dimethylcyclopropane:

         CH₃                            CH₃
          |                              |
       /——⌴——\                         /——⌴——\
      |       |                        |       |
      \———————/                        \———————/
          |                                  |
         CH₃                                CH₃

    (both CH₃ on same side)           (CH₃ on opposite sides)
    ```

    ---

    ## 6. Conformational Isomerism

    ### Definition
    **Conformational isomers (conformers)** arise from **rotation around single bonds** (σ bonds).

    ### Key Points
    - **Interconvert rapidly** at room temperature
    - **Energy barrier** is low (typically 10-20 kJ/mol)
    - Cannot be isolated separately at room temperature
    - **Different energies** (some conformers more stable than others)

    ---

    ## 7. Newman Projections

    ### What are Newman Projections?
    - **2D representation** of 3D molecular conformation
    - View along a C-C bond axis
    - **Front carbon:** Dot at center
    - **Back carbon:** Circle

    **Example: Ethane (CH₃-CH₃)**
    ```
    View along C-C bond:

           H                    H
           |                    |
       H — C — C — H   →    H-⊙-H  (Newman projection)
           |   |               |
           H   H               H

    Front C (dot) has 3 H
    Back C (circle) has 3 H
    ```

    ---

    ## 8. Conformations of Ethane

    ### Staggered Conformation
    - **Definition:** Bonds on adjacent carbons are **60° apart**
    - **Energy:** Lowest energy (most stable)
    - **Reason:** Maximum separation of electron clouds (minimum repulsion)

    **Newman projection:**
    ```
           H
           |
       H-⊙-H
          |
          H

    Dihedral angle = 60°
    Minimum torsional strain
    ```

    ### Eclipsed Conformation
    - **Definition:** Bonds on adjacent carbons **overlap** (0° dihedral angle)
    - **Energy:** Highest energy (least stable)
    - **Reason:** Maximum electron repulsion (torsional strain)

    **Newman projection:**
    ```
          H
          |
       H-⊙-H
          |
          H

    Dihedral angle = 0°
    Maximum torsional strain
    ```

    ### Energy Diagram

    ```
    Energy
      ↑
      |     Eclipsed         Eclipsed         Eclipsed
      |        /\              /\               /\
    12|       /  \            /  \             /  \
    kJ|      /    \          /    \           /    \
    /mol   /      \        /      \         /      \
      |   /________\______/________\______/_________\____
      |   Staggered       Staggered        Staggered
      |
      └────────────────────────────────────────────────→
          0°    60°   120°  180°  240°  300°  360°
                         Dihedral angle
    ```

    **Energy difference:** ~12 kJ/mol (rotation barrier)

    ---

    ## 9. Conformations of Butane

    ### Four Key Conformations

    Looking down C2-C3 bond of CH₃-CH₂-CH₂-CH₃:

    #### 1. Anti (Most Stable)
    - **Dihedral angle:** 180°
    - **Energy:** 0 kJ/mol (reference)
    - **Groups:** Two CH₃ groups as far apart as possible

    ```
           CH₃
            |
        H-⊙-H
           |
           H

    Anti conformation
    CH₃ groups 180° apart
    ```

    #### 2. Gauche (Stable)
    - **Dihedral angle:** 60° (or 300°)
    - **Energy:** +3.8 kJ/mol
    - **Reason:** Steric repulsion between two CH₃ groups

    ```
          CH₃
           |
       H-⊙-H
          |
          H

    Gauche conformation
    CH₃ groups 60° apart
    ```

    #### 3. Eclipsed (H-H)
    - **Dihedral angle:** 0° (or 120° or 240°)
    - **Energy:** +14 kJ/mol
    - **Reason:** Torsional strain (H-H eclipsing) + some CH₃-H repulsion

    #### 4. Eclipsed (CH₃-CH₃) - Least Stable
    - **Dihedral angle:** 0°
    - **Energy:** +19 kJ/mol
    - **Reason:** Maximum steric strain (CH₃-CH₃ eclipsing)

    ### Energy Diagram for Butane

    ```
    Energy
      ↑
      |        Eclipsed                    Eclipsed
      |        CH₃-CH₃                     CH₃-CH₃
    19|           /\                          /\
    kJ|          /  \                        /  \
    /mol       /    \                      /    \
    14|       /      \    Eclipsed        /      \
      |      /        \   H-H            /        \
     4|     /  Gauche  \    /\          /  Gauche  \
      |    /            \  /  \        /            \
      |___/______________\/_____\_____/_____________\___
      |  Anti                           Anti
      |
      └────────────────────────────────────────────────→
         0°    60°   120°  180°  240°  300°  360°
                        Dihedral angle
    ```

    ---

    ## 10. Types of Strain

    ### 1. Torsional Strain
    - **Cause:** Repulsion between **electrons in eclipsed bonds**
    - **Example:** Eclipsed ethane
    - **Energy:** ~4 kJ/mol per eclipsed H-H interaction

    ### 2. Steric Strain (Van der Waals Strain)
    - **Cause:** Repulsion between **atoms or groups** that are too close
    - **Example:** Gauche butane (CH₃ groups close)
    - **Energy:** Depends on size of groups

    ### 3. Angle Strain
    - **Cause:** Deviation from ideal bond angles (109.5° for sp³)
    - **Example:** Cyclopropane (60° vs 109.5°)
    - Not covered in conformational analysis

    ---

    ## 11. Comparison: Geometrical vs Conformational Isomerism

    | Property | Geometrical | Conformational |
    |----------|------------|----------------|
    | **Cause** | Restricted rotation (C=C or ring) | Rotation around single bond |
    | **Interconversion** | Requires bond breaking | Free rotation (low barrier) |
    | **Isolation** | Can be isolated | Cannot be isolated (rapid equilibrium) |
    | **Energy difference** | Large (~250 kJ/mol to rotate C=C) | Small (10-20 kJ/mol) |
    | **Examples** | cis/trans-2-butene | Staggered/eclipsed ethane |

    ---

    ## Important Points for IIT JEE

    1. **Geometrical isomerism requires:**
       - Restricted rotation (C=C or ring)
       - Different groups on each C of the double bond
       - Does NOT occur if any C has two identical groups

    2. **E-Z vs cis-trans:**
       - Use E-Z for complex molecules
       - Remember: Z = Zusammen (same side), E = Entgegen (opposite)

    3. **Stability:**
       - trans-alkenes more stable than cis (less steric strain)
       - Anti conformation most stable (groups 180° apart)
       - Eclipsed conformations least stable

    4. **Newman projections:**
       - Practice drawing and identifying conformations
       - Staggered: 60° dihedral angles
       - Eclipsed: 0° dihedral angles

    5. **Energy barriers:**
       - Ethane rotation barrier: ~12 kJ/mol
       - Butane rotation barrier: ~19 kJ/mol (CH₃-CH₃ eclipsed)
       - C=C rotation: ~250 kJ/mol (requires bond breaking)

    ---

    ## Practice Questions

    1. Draw cis and trans isomers of 2-pentene
    2. Assign E or Z to: CHCl=CHBr (with priorities)
    3. Draw Newman projections for all staggered and eclipsed conformations of propane
    4. Why is trans-2-butene more stable than cis-2-butene?
    5. What is the energy difference between anti and gauche conformations of butane?

## Key Points

- Geometrical isomerism (cis-trans)

- E-Z nomenclature

- Conformational isomerism
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Geometrical isomerism (cis-trans)', 'E-Z nomenclature', 'Conformational isomerism', 'Newman projections', 'Eclipsed and staggered conformations', 'Torsional and steric strain'],
  prerequisite_ids: []
)

# === MICROLESSON 7: How many chain isomers (structural isomers) does pentane (C₅H₁₂) have? ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'How many chain isomers (structural isomers) does pentane (C₅H₁₂) have?',
  content: <<~MARKDOWN,
# How many chain isomers (structural isomers) does pentane (C₅H₁₂) have? 🚀

Pentane has 3 chain isomers: n-pentane, isopentane (2-methylbutane), and neopentane (2,2-dimethylpropane).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
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
    question: 'How many chain isomers (structural isomers) does pentane (C₅H₁₂) have?',
    options: ['2', '3', '4', '5'],
    correct_answer: 1,
    explanation: 'Pentane has 3 chain isomers: n-pentane, isopentane (2-methylbutane), and neopentane (2,2-dimethylpropane).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: Which of the following pairs are functional group isomers? ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following pairs are functional group isomers?',
  content: <<~MARKDOWN,
# Which of the following pairs are functional group isomers? 🚀

Functional group isomers have different functional groups: Ethanol (alcohol) and dimethyl ether (ether) are C₂H₆O; Propanal (aldehyde) and propanone (ketone) are C₃H₆O. 1-Propanol and 2-propanol are position isomers.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following pairs are functional group isomers?',
    options: ['Ethanol and dimethyl ether', 'Propanal and propanone', '1-Propanol and 2-propanol', 'Propyne and allene'],
    correct_answer: 1,
    explanation: 'Functional group isomers have different functional groups: Ethanol (alcohol) and dimethyl ether (ether) are C₂H₆O; Propanal (aldehyde) and propanone (ketone) are C₃H₆O. 1-Propanol and 2-propanol are position isomers.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: What is the key difference between configurational and conformational isomers? ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the key difference between configurational and conformational isomers?',
  content: <<~MARKDOWN,
# What is the key difference between configurational and conformational isomers? 🚀

Conformational isomers (conformers) can interconvert by rotation around single bonds without breaking any bonds. Configurational isomers require bond breaking to interconvert.

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
    question: 'What is the key difference between configurational and conformational isomers?',
    options: ['Configurational isomers have different molecular formulas', 'Conformational isomers can interconvert without breaking bonds', 'Configurational isomers can be easily separated', 'Conformational isomers have different functional groups'],
    correct_answer: 1,
    explanation: 'Conformational isomers (conformers) can interconvert by rotation around single bonds without breaking any bonds. Configurational isomers require bond breaking to interconvert.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 10: Which type of isomerism is exhibited by 1-chloropropane and 2-chloropropane? ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which type of isomerism is exhibited by 1-chloropropane and 2-chloropropane?',
  content: <<~MARKDOWN,
# Which type of isomerism is exhibited by 1-chloropropane and 2-chloropropane? 🚀

These compounds have the same carbon chain but differ in the position of the chlorine atom. This is position isomerism.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
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
    question: 'Which type of isomerism is exhibited by 1-chloropropane and 2-chloropropane?',
    options: ['Chain isomerism', 'Position isomerism', 'Functional group isomerism', 'Metamerism'],
    correct_answer: 1,
    explanation: 'These compounds have the same carbon chain but differ in the position of the chlorine atom. This is position isomerism.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: Which of the following compounds can show keto-enol tautomerism? ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following compounds can show keto-enol tautomerism?',
  content: <<~MARKDOWN,
# Which of the following compounds can show keto-enol tautomerism? 🚀

Acetone can show keto-enol tautomerism because it has α-hydrogens (on CH₃ groups adjacent to C=O). Phenol does not because it would lose aromatic stability. Formaldehyde has no α-hydrogens.

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
    question: 'Which of the following compounds can show keto-enol tautomerism?',
    options: ['Acetone (CH₃COCH₃)', 'Phenol (C₆H₅OH)', 'Acetic acid (CH₃COOH)', 'Formaldehyde (HCHO)'],
    correct_answer: 0,
    explanation: 'Acetone can show keto-enol tautomerism because it has α-hydrogens (on CH₃ groups adjacent to C=O). Phenol does not because it would lose aromatic stability. Formaldehyde has no α-hydrogens.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 12: Stereoisomers have the same connectivity of atoms but differ in their spatial arrangement. ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Stereoisomers have the same connectivity of atoms but differ in their spatial arrangement.',
  content: <<~MARKDOWN,
# Stereoisomers have the same connectivity of atoms but differ in their spatial arrangement. 🚀

TRUE. Stereoisomers have identical structural formulas (same connectivity) but differ in the three-dimensional arrangement of atoms in space.

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

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Stereoisomers have the same connectivity of atoms but differ in their spatial arrangement.',
    answer: '',
    explanation: 'TRUE. Stereoisomers have identical structural formulas (same connectivity) but differ in the three-dimensional arrangement of atoms in space.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: Which of the following is the correct definition of chirality? ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following is the correct definition of chirality?',
  content: <<~MARKDOWN,
# Which of the following is the correct definition of chirality? 🚀

Chirality means non-superimposability on mirror image. While chiral molecules usually have chiral centers and are optically active, the fundamental definition is about mirror image non-superimposability.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following is the correct definition of chirality?',
    options: ['A molecule that rotates plane-polarized light', 'A molecule with a chiral center', 'A molecule that is non-superimposable on its mirror image', 'A molecule with an asymmetric carbon atom'],
    correct_answer: 2,
    explanation: 'Chirality means non-superimposability on mirror image. While chiral molecules usually have chiral centers and are optically active, the fundamental definition is about mirror image non-superimposability.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: How many chiral centers are present in the molecule: CH₃-CHBr-CHCl-COOH? ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'How many chiral centers are present in the molecule: CH₃-CHBr-CHCl-COOH?',
  content: <<~MARKDOWN,
# How many chiral centers are present in the molecule: CH₃-CHBr-CHCl-COOH? 🚀

Two chiral centers: C-2 (with -CH₃, -Br, -H, -CHClCOOH) and C-3 (with -CHBrCH₃, -Cl, -H, -COOH). Each carbon has 4 different groups.

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

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many chiral centers are present in the molecule: CH₃-CHBr-CHCl-COOH?',
    answer: '2',
    explanation: 'Two chiral centers: C-2 (with -CH₃, -Br, -H, -CHClCOOH) and C-3 (with -CHBrCH₃, -Cl, -H, -COOH). Each carbon has 4 different groups.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: Which properties are IDENTICAL for a pair of enantiomers? ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which properties are IDENTICAL for a pair of enantiomers?',
  content: <<~MARKDOWN,
# Which properties are IDENTICAL for a pair of enantiomers? 🚀

Enantiomers have identical physical properties (mp, bp, solubility, density) and same magnitude of optical rotation, but OPPOSITE direction of rotation.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
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
    question: 'Which properties are IDENTICAL for a pair of enantiomers?',
    options: ['Melting point', 'Direction of optical rotation', 'Boiling point', 'Magnitude of optical rotation'],
    correct_answer: 3,
    explanation: 'Enantiomers have identical physical properties (mp, bp, solubility, density) and same magnitude of optical rotation, but OPPOSITE direction of rotation.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: A solution containing 2.0 g of a compound dissolved in 50 mL of solvent shows a rotation of +30° in a polarimeter tube of length 2 dm. Calculate the specific rotation [α] in degrees·mL/(g·dm). ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'A solution containing 2.0 g of a compound dissolved in 50 mL of solvent shows a rotation of +30° in a polarimeter tube of length 2 dm. Calculate the specific rotation [α] in degrees·mL/(g·dm).',
  content: <<~MARKDOWN,
# A solution containing 2.0 g of a compound dissolved in 50 mL of solvent shows a rotation of +30° in a polarimeter tube of length 2 dm. Calculate the specific rotation [α] in degrees·mL/(g·dm). 🚀

c = 2.0 g / 50 mL = 0.04 g/mL; l = 2 dm; α = +30°. [α] = α/(l×c) = 30/(2×0.04) = 375 degrees·mL/(g·dm).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'A solution containing 2.0 g of a compound dissolved in 50 mL of solvent shows a rotation of +30° in a polarimeter tube of length 2 dm. Calculate the specific rotation [α] in degrees·mL/(g·dm).',
    answer: '375',
    explanation: 'c = 2.0 g / 50 mL = 0.04 g/mL; l = 2 dm; α = +30°. [α] = α/(l×c) = 30/(2×0.04) = 375 degrees·mL/(g·dm).',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: What is a racemic mixture? ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is a racemic mixture?',
  content: <<~MARKDOWN,
# What is a racemic mixture? 🚀

A racemic mixture (racemate) is a 1:1 mixture of both enantiomers. The equal and opposite rotations cancel out, making it optically inactive. Notation: (±) or rac-.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
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
    question: 'What is a racemic mixture?',
    options: ['A pure enantiomer that is optically active', 'A 1:1 mixture of two enantiomers that is optically inactive', 'A meso compound with internal symmetry', 'A mixture of diastereomers'],
    correct_answer: 1,
    explanation: 'A racemic mixture (racemate) is a 1:1 mixture of both enantiomers. The equal and opposite rotations cancel out, making it optically inactive. Notation: (±) or rac-.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 18: Which statement about meso compounds is CORRECT? ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which statement about meso compounds is CORRECT?',
  content: <<~MARKDOWN,
# Which statement about meso compounds is CORRECT? 🚀

Meso compounds have chiral centers but possess an internal plane of symmetry, making them optically INACTIVE. They are superimposable on their mirror images.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'medium',
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
    question: 'Which statement about meso compounds is CORRECT?',
    options: ['They have no chiral centers', 'They are optically active', 'They have an internal plane of symmetry', 'They are mirror images of each other'],
    correct_answer: 2,
    explanation: 'Meso compounds have chiral centers but possess an internal plane of symmetry, making them optically INACTIVE. They are superimposable on their mirror images.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 19: How many stereoisomers are possible for a compound with 3 different chiral centers (assuming no meso forms)? ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'How many stereoisomers are possible for a compound with 3 different chiral centers (assuming no meso forms)?',
  content: <<~MARKDOWN,
# How many stereoisomers are possible for a compound with 3 different chiral centers (assuming no meso forms)? 🚀

Number of stereoisomers = 2ⁿ where n = number of chiral centers. 2³ = 8 stereoisomers (4 pairs of enantiomers).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 19.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many stereoisomers are possible for a compound with 3 different chiral centers (assuming no meso forms)?',
    answer: '8',
    explanation: 'Number of stereoisomers = 2ⁿ where n = number of chiral centers. 2³ = 8 stereoisomers (4 pairs of enantiomers).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 20: In the Cahn-Ingold-Prelog (R/S) system, which of the following groups has the HIGHEST priority? ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'In the Cahn-Ingold-Prelog (R/S) system, which of the following groups has the HIGHEST priority?',
  content: <<~MARKDOWN,
# In the Cahn-Ingold-Prelog (R/S) system, which of the following groups has the HIGHEST priority? 🚀

Priority order for common groups: -COOH > -CHO > -CH₂OH > -CH₃ > -H. COOH has the highest priority because the C is bonded to two O atoms (counted twice).

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
    question: 'In the Cahn-Ingold-Prelog (R/S) system, which of the following groups has the HIGHEST priority?',
    options: ['-CH₂OH', '-CHO', '-COOH', '-CH₃'],
    correct_answer: 2,
    explanation: 'Priority order for common groups: -COOH > -CHO > -CH₂OH > -CH₃ > -H. COOH has the highest priority because the C is bonded to two O atoms (counted twice).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 21: The sign of optical rotation (+/- or d/l) directly indicates whether a molecule has R or S configuration. ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'The sign of optical rotation (+/- or d/l) directly indicates whether a molecule has R or S configuration.',
  content: <<~MARKDOWN,
# The sign of optical rotation (+/- or d/l) directly indicates whether a molecule has R or S configuration. 🚀

FALSE. The sign of rotation (+/-) indicates the DIRECTION of light rotation but does NOT correlate with R/S configuration. A compound can be (R)-(+), (R)-(-), (S)-(+), or (S)-(-).

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

# Exercise 21.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_21,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The sign of optical rotation (+/- or d/l) directly indicates whether a molecule has R or S configuration.',
    answer: '',
    explanation: 'FALSE. The sign of rotation (+/-) indicates the DIRECTION of light rotation but does NOT correlate with R/S configuration. A compound can be (R)-(+), (R)-(-), (S)-(+), or (S)-(-).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 22: Which of the following conditions are REQUIRED for geometrical isomerism in alkenes? ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following conditions are REQUIRED for geometrical isomerism in alkenes?',
  content: <<~MARKDOWN,
# Which of the following conditions are REQUIRED for geometrical isomerism in alkenes? 🚀

Geometrical isomerism requires: (1) Restricted rotation (C=C or ring) and (2) Different groups on each carbon. It does NOT require chirality or specific H atoms.

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
    question: 'Which of the following conditions are REQUIRED for geometrical isomerism in alkenes?',
    options: ['Restricted rotation around C=C double bond', 'Different groups on each carbon of the double bond', 'Presence of a chiral center', 'At least one hydrogen on each carbon'],
    correct_answer: 1,
    explanation: 'Geometrical isomerism requires: (1) Restricted rotation (C=C or ring) and (2) Different groups on each carbon. It does NOT require chirality or specific H atoms.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 23: Which of the following compounds can show geometrical isomerism? ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following compounds can show geometrical isomerism?',
  content: <<~MARKDOWN,
# Which of the following compounds can show geometrical isomerism? 🚀

2-Butene shows geometrical isomerism (cis/trans) because each C of the double bond has different groups. Propene has two H on one C. Ethene has two H on each C. 2-Methylpropene has two CH₃ on one C.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 23.2: MCQ
Exercise.create!(
  micro_lesson: lesson_23,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following compounds can show geometrical isomerism?',
    options: ['CH₃-CH=CH₂ (Propene)', 'CH₃-CH=CH-CH₃ (2-Butene)', 'CH₂=CH₂ (Ethene)', 'CH₂=C(CH₃)₂ (2-Methylpropene)'],
    correct_answer: 1,
    explanation: '2-Butene shows geometrical isomerism (cis/trans) because each C of the double bond has different groups. Propene has two H on one C. Ethene has two H on each C. 2-Methylpropene has two CH₃ on one C.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 24: In the E-Z nomenclature system, what does \"Z\" stand for? ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'In the E-Z nomenclature system, what does \"Z\" stand for?',
  content: <<~MARKDOWN,
# In the E-Z nomenclature system, what does "Z" stand for? 🚀

Z = Zusammen (German for "together"). Higher priority groups on the same side → Z. E = Entgegen (opposite) → higher priority groups on opposite sides.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 24.2: MCQ
Exercise.create!(
  micro_lesson: lesson_24,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In the E-Z nomenclature system, what does "Z" stand for?',
    options: ['Zero - groups are at 0° angle', 'Zusammen - higher priority groups on same side', 'Zipper - groups are close together', 'Z-axis - groups are aligned vertically'],
    correct_answer: 1,
    explanation: 'Z = Zusammen (German for "together"). Higher priority groups on the same side → Z. E = Entgegen (opposite) → higher priority groups on opposite sides.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 25: Why is trans-2-butene MORE STABLE than cis-2-butene? ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'Why is trans-2-butene MORE STABLE than cis-2-butene?',
  content: <<~MARKDOWN,
# Why is trans-2-butene MORE STABLE than cis-2-butene? 🚀

trans-2-butene is more stable because the two CH₃ groups are on opposite sides of the double bond (180° apart), minimizing steric repulsion. In cis, they are on the same side causing repulsion.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 25.2: MCQ
Exercise.create!(
  micro_lesson: lesson_25,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why is trans-2-butene MORE STABLE than cis-2-butene?',
    options: ['trans has stronger C=C bond', 'trans has less steric repulsion between CH₃ groups', 'trans has more hydrogen bonding', 'trans has higher dipole moment'],
    correct_answer: 1,
    explanation: 'trans-2-butene is more stable because the two CH₃ groups are on opposite sides of the double bond (180° apart), minimizing steric repulsion. In cis, they are on the same side causing repulsion.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 26: In a Newman projection of ethane, which conformation has the LOWEST energy? ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'In a Newman projection of ethane, which conformation has the LOWEST energy?',
  content: <<~MARKDOWN,
# In a Newman projection of ethane, which conformation has the LOWEST energy? 🚀

Staggered conformation has the lowest energy (most stable) because bonds are 60° apart, minimizing electron repulsion. Eclipsed has maximum repulsion (0° dihedral angle). Gauche and anti are specific to molecules like butane.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 26.2: MCQ
Exercise.create!(
  micro_lesson: lesson_26,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In a Newman projection of ethane, which conformation has the LOWEST energy?',
    options: ['Eclipsed', 'Staggered', 'Gauche', 'Anti'],
    correct_answer: 1,
    explanation: 'Staggered conformation has the lowest energy (most stable) because bonds are 60° apart, minimizing electron repulsion. Eclipsed has maximum repulsion (0° dihedral angle). Gauche and anti are specific to molecules like butane.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 27: What is the approximate energy difference (in kJ/mol) between the staggered and eclipsed conformations of ethane? ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the approximate energy difference (in kJ/mol) between the staggered and eclipsed conformations of ethane?',
  content: <<~MARKDOWN,
# What is the approximate energy difference (in kJ/mol) between the staggered and eclipsed conformations of ethane? 🚀

The rotation barrier in ethane is approximately 12 kJ/mol. This is the energy difference between the lowest energy conformation (staggered) and highest energy conformation (eclipsed).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 27.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_27,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the approximate energy difference (in kJ/mol) between the staggered and eclipsed conformations of ethane?',
    answer: '12',
    explanation: 'The rotation barrier in ethane is approximately 12 kJ/mol. This is the energy difference between the lowest energy conformation (staggered) and highest energy conformation (eclipsed).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 28: For butane (CH₃-CH₂-CH₂-CH₃), looking down the C2-C3 bond, which conformation is the MOST STABLE? ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'For butane (CH₃-CH₂-CH₂-CH₃), looking down the C2-C3 bond, which conformation is the MOST STABLE?',
  content: <<~MARKDOWN,
# For butane (CH₃-CH₂-CH₂-CH₃), looking down the C2-C3 bond, which conformation is the MOST STABLE? 🚀

Anti conformation (CH₃ groups 180° apart) is the most stable. Energy order: Anti (0 kJ/mol) < Gauche (+3.8) < Eclipsed H-H (+14) < Eclipsed CH₃-CH₃ (+19).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 28.2: MCQ
Exercise.create!(
  micro_lesson: lesson_28,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For butane (CH₃-CH₂-CH₂-CH₃), looking down the C2-C3 bond, which conformation is the MOST STABLE?',
    options: ['Eclipsed (CH₃-CH₃)', 'Eclipsed (CH₃-H)', 'Gauche', 'Anti'],
    correct_answer: 3,
    explanation: 'Anti conformation (CH₃ groups 180° apart) is the most stable. Energy order: Anti (0 kJ/mol) < Gauche (+3.8) < Eclipsed H-H (+14) < Eclipsed CH₃-CH₃ (+19).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 29: What is the primary cause of torsional strain? ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the primary cause of torsional strain?',
  content: <<~MARKDOWN,
# What is the primary cause of torsional strain? 🚀

Torsional strain arises from repulsion between electrons in eclipsed bonds (0° dihedral angle). Steric strain is from atoms being too close. Angle strain is from deviation from ideal angles.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 29.2: MCQ
Exercise.create!(
  micro_lesson: lesson_29,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the primary cause of torsional strain?',
    options: ['Repulsion between atoms that are too close in space', 'Deviation from ideal bond angles', 'Repulsion between electrons in eclipsed bonds', 'Attraction between opposite charges'],
    correct_answer: 2,
    explanation: 'Torsional strain arises from repulsion between electrons in eclipsed bonds (0° dihedral angle). Steric strain is from atoms being too close. Angle strain is from deviation from ideal angles.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 30: Conformational isomers can be easily isolated and stored separately at room temperature. ===
lesson_30 = MicroLesson.create!(
  course_module: module_var,
  title: 'Conformational isomers can be easily isolated and stored separately at room temperature.',
  content: <<~MARKDOWN,
# Conformational isomers can be easily isolated and stored separately at room temperature. 🚀

FALSE. Conformational isomers (conformers) rapidly interconvert at room temperature due to low rotation barrier (~10-20 kJ/mol). They cannot be isolated separately under normal conditions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 30,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 30.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_30,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Conformational isomers can be easily isolated and stored separately at room temperature.',
    answer: '',
    explanation: 'FALSE. Conformational isomers (conformers) rapidly interconvert at room temperature due to low rotation barrier (~10-20 kJ/mol). They cannot be isolated separately under normal conditions.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 31: Introduction to Isomerism - Structural vs Stereoisomerism ===
lesson_31 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Isomerism - Structural vs Stereoisomerism',
  content: <<~MARKDOWN,
# Introduction to Isomerism - Structural vs Stereoisomerism 🚀

# Introduction to Isomerism

    ## 1. What is Isomerism?

    ### Definition
    **Isomers** are compounds with the **same molecular formula** but **different structures** or **spatial arrangements**.

    **Example:**
    ```
    C₄H₁₀ has two isomers:

    1. n-Butane:     CH₃-CH₂-CH₂-CH₃
    2. Isobutane:    CH₃-CH(CH₃)-CH₃
    ```

    Both have the same molecular formula (C₄H₁₀) but different structures.

    ---

    ## 2. Types of Isomerism

    ```
    ISOMERISM
    │
    ├── STRUCTURAL ISOMERISM (Constitutional Isomerism)
    │   ├── Chain/Skeletal Isomerism
    │   ├── Position Isomerism
    │   ├── Functional Group Isomerism
    │   ├── Metamerism
    │   └── Tautomerism
    │
    └── STEREOISOMERISM (Spatial Isomerism)
        ├── CONFIGURATIONAL ISOMERISM
        │   ├── Optical Isomerism (Enantiomers, Diastereomers)
        │   └── Geometrical Isomerism (cis-trans, E-Z)
        │
        └── CONFORMATIONAL ISOMERISM
            └── Conformers (Rotational isomers)
    ```

    ---

    ## 3. Structural Isomerism

    ### A. Chain Isomerism (Skeletal Isomerism)
    Isomers differ in the **carbon skeleton** (branching pattern).

    **Example: C₅H₁₂ (Pentane)**
    ```
    1. n-Pentane:        CH₃-CH₂-CH₂-CH₂-CH₃

    2. Isopentane:       CH₃-CH(CH₃)-CH₂-CH₃

    3. Neopentane:       C(CH₃)₄
    ```

    ### B. Position Isomerism
    Isomers differ in the **position of functional group** or substituent on the same carbon chain.

    **Example: C₃H₇Cl (Chloropropane)**
    ```
    1. 1-Chloropropane:  CH₃-CH₂-CH₂-Cl

    2. 2-Chloropropane:  CH₃-CHCl-CH₃
    ```

    **Example: C₃H₈O (Propanol)**
    ```
    1. 1-Propanol:       CH₃-CH₂-CH₂-OH

    2. 2-Propanol:       CH₃-CH(OH)-CH₃
    ```

    ### C. Functional Group Isomerism
    Isomers have **different functional groups**.

    **Example: C₃H₆O**
    ```
    1. Propanal (aldehyde):     CH₃-CH₂-CHO

    2. Propanone (ketone):      CH₃-CO-CH₃

    3. Allyl alcohol:           CH₂=CH-CH₂-OH

    4. Propylene oxide:         CH₃-CH-CH₂
                                    \__O__/
    ```

    **Common functional group isomer pairs:**
    - **Alcohols** and **Ethers**: CₙH₂ₙ₊₂O
    - **Aldehydes** and **Ketones**: CₙH₂ₙO
    - **Carboxylic acids** and **Esters**: CₙH₂ₙO₂
    - **Alkynes** and **Dienes**: CₙH₂ₙ₋₂

    ### D. Metamerism
    Isomers differ in the **distribution of carbon atoms around a functional group** (special case of position isomerism for ethers, ketones, etc.).

    **Example: C₄H₁₀O (Ethers)**
    ```
    1. Diethyl ether:            CH₃-CH₂-O-CH₂-CH₃

    2. Methyl propyl ether:      CH₃-O-CH₂-CH₂-CH₃
    ```

    ### E. Tautomerism (Dynamic Isomerism)
    Isomers exist in **equilibrium** by migration of a proton and shift of a double bond.

    **Example: Keto-Enol Tautomerism**
    ```
    Keto form              ⇌              Enol form
    CH₃-CO-CH₃                            CH₂=C(OH)-CH₃
    (Acetone, 99.99%)                     (<0.01%)
    ```

    **Example: Phenol (no tautomerism):**
    - Phenol does NOT show keto-enol tautomerism because it would lose aromatic stability

    ---

    ## 4. Stereoisomerism - Introduction

    ### Definition
    **Stereoisomers** have the same structural formula but differ in **spatial arrangement** of atoms.

    ### Key Difference from Structural Isomers
    - **Structural isomers:** Different connectivity of atoms
    - **Stereoisomers:** Same connectivity, different 3D arrangement

    ### Types of Stereoisomerism

    #### A. Configurational Isomerism
    - **Configuration** is **fixed** and cannot be interconverted without breaking bonds
    - Two types:
      1. **Optical isomerism** (chirality-based)
      2. **Geometrical isomerism** (restricted rotation)

    #### B. Conformational Isomerism
    - **Conformers** can be interconverted by **rotation** around single bonds
    - No bond breaking required
    - Rapidly interconverting at room temperature

    ---

    ## 5. Configurational vs Conformational Isomers

    | Property | Configurational | Conformational |
    |----------|-----------------|----------------|
    | **Bond breaking** | Required | Not required |
    | **Interconversion** | Not possible at room temp | Rapid at room temp |
    | **Energy barrier** | High | Low |
    | **Stability** | Fixed | Different conformers have different energies |
    | **Isolation** | Can be isolated | Usually cannot be isolated |
    | **Examples** | Enantiomers, cis-trans | Eclipsed, staggered |

    ---

    ## 6. Importance of Stereochemistry

    ### In Biological Systems
    - **Drug activity:** Only one stereoisomer may be active
    - **Example:** L-DOPA (Parkinson's treatment) vs D-DOPA (inactive)
    - **Example:** Thalidomide - one enantiomer caused birth defects

    ### In Chemical Reactions
    - **Selectivity:** Reactions may produce specific stereoisomers
    - **Mechanism understanding:** Stereochemistry reveals reaction pathways

    ### In IIT JEE
    - **High weightage topic** (5-8% of organic chemistry)
    - **Conceptual questions** on chirality, optical activity, R/S nomenclature
    - **Numerical problems** on specific rotation
    - **Mechanism questions** involving stereochemistry

    ---

    ## 7. Key Terms to Remember

    | Term | Definition |
    |------|------------|
    | **Isomers** | Same molecular formula, different structure/arrangement |
    | **Constitutional isomers** | Different connectivity (structural isomers) |
    | **Stereoisomers** | Same connectivity, different spatial arrangement |
    | **Configuration** | Fixed 3D arrangement (requires bond breaking to change) |
    | **Conformation** | Spatial arrangement from rotation (no bond breaking) |
    | **Chirality** | Non-superimposable on mirror image |
    | **Enantiomers** | Non-superimposable mirror images |
    | **Diastereomers** | Non-mirror image stereoisomers |

    ---

    ## Important Points for IIT JEE

    1. **Count all possible isomers systematically:**
       - Start with straight chain, then branched
       - Consider all positions for functional groups
       - Don't forget stereoisomers

    2. **Identify isomer type:**
       - Check molecular formula first
       - Determine connectivity (structural vs stereoisomerism)
       - Check for chirality or restricted rotation

    3. **Tautomerism requires:**
       - α-hydrogen (H on carbon adjacent to C=O)
       - Enolizable hydrogen
       - Usually keto form is more stable

    4. **Functional group isomerism:**
       - Memorize common pairs (alcohol-ether, aldehyde-ketone, etc.)
       - Useful for identifying unknown compounds

    ---

    ## Practice Questions

    1. How many structural isomers does C₅H₁₂ have?
    2. Draw all position isomers of C₄H₉Cl
    3. Give functional group isomers of C₃H₆O
    4. What is the difference between configurational and conformational isomers?
    5. Which compounds show tautomerism: (a) Acetone (b) Phenol (c) Acetaldehyde?

## Key Points

- Types of isomerism

- Structural isomerism (chain, position, functional)

- Stereoisomerism overview
  MARKDOWN
  sequence_order: 31,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Types of isomerism', 'Structural isomerism (chain, position, functional)', 'Stereoisomerism overview', 'Configurational vs conformational isomers', 'Molecular formulas and isomer counting'],
  prerequisite_ids: []
)

puts "✓ Created 31 microlessons for Module 06 Stereochemistry"

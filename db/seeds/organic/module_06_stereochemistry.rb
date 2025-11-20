# Module 6: Stereochemistry
# Advanced concepts in 3D structure and spatial arrangement
# Covers optical isomerism, geometrical isomerism, chirality, and conformational analysis

puts "Creating Module 6: Stereochemistry..."

# Get Organic Chemistry course
course_organic = Course.find_by(title: 'Organic Chemistry for IIT JEE Main & Advanced')

unless course_organic
  puts "❌ Error: Organic Chemistry course not found. Please run module_01_goc.rb first."
  exit
end

# Create Module 6
module_06 = CourseModule.create!(
  course: course_organic,
  title: 'Module 6: Stereochemistry',
  description: 'Three-dimensional aspects of molecules: chirality, optical activity, enantiomers, diastereomers, and conformational analysis',
  sequence_order: 6,
  estimated_minutes: 240,
  published: true
)

puts "✅ Module 6 created"

# ============================================================================
# LESSON 6.1: Introduction to Isomerism and Stereoisomerism
# ============================================================================

lesson_6_1 = CourseLesson.create!(
  title: 'Introduction to Isomerism - Structural vs Stereoisomerism',
  reading_time_minutes: 45,
  key_concepts: [
    'Types of isomerism',
    'Structural isomerism (chain, position, functional)',
    'Stereoisomerism overview',
    'Configurational vs conformational isomers',
    'Molecular formulas and isomer counting'
  ],
  content: <<~MD
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
  MD
)

ModuleItem.create!(
  course_module: module_06,
  item: lesson_6_1,
  sequence_order: 1,
  required: true
)

puts "✅ Lesson 6.1 created"

# Create Quiz 6.1
quiz_6_1 = Quiz.create!(
  title: 'Quiz 6.1: Introduction to Isomerism',
  description: 'Test your understanding of structural and stereoisomerism basics',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_06,
  item: quiz_6_1,
  sequence_order: 2,
  required: true
)

# Quiz 6.1 Questions
QuizQuestion.create!([
  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'How many chain isomers (structural isomers) does pentane (C₅H₁₂) have?',
    options: [
      { text: '2', correct: false },
      { text: '3', correct: true },
      { text: '4', correct: false },
      { text: '5', correct: false }
    ],
    explanation: 'Pentane has 3 chain isomers: n-pentane, isopentane (2-methylbutane), and neopentane (2,2-dimethylpropane).',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following pairs are functional group isomers?',
    options: [
      { text: 'Ethanol and dimethyl ether', correct: true },
      { text: 'Propanal and propanone', correct: true },
      { text: '1-Propanol and 2-propanol', correct: false },
      { text: 'Propyne and allene', correct: false }
    ],
    explanation: 'Functional group isomers have different functional groups: Ethanol (alcohol) and dimethyl ether (ether) are C₂H₆O; Propanal (aldehyde) and propanone (ketone) are C₃H₆O. 1-Propanol and 2-propanol are position isomers.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the key difference between configurational and conformational isomers?',
    options: [
      { text: 'Configurational isomers have different molecular formulas', correct: false },
      { text: 'Conformational isomers can interconvert without breaking bonds', correct: true },
      { text: 'Configurational isomers can be easily separated', correct: false },
      { text: 'Conformational isomers have different functional groups', correct: false }
    ],
    explanation: 'Conformational isomers (conformers) can interconvert by rotation around single bonds without breaking any bonds. Configurational isomers require bond breaking to interconvert.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which type of isomerism is exhibited by 1-chloropropane and 2-chloropropane?',
    options: [
      { text: 'Chain isomerism', correct: false },
      { text: 'Position isomerism', correct: true },
      { text: 'Functional group isomerism', correct: false },
      { text: 'Metamerism', correct: false }
    ],
    explanation: 'These compounds have the same carbon chain but differ in the position of the chlorine atom. This is position isomerism.',
    points: 2,
    difficulty: -0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_6_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following compounds can show keto-enol tautomerism?',
    options: [
      { text: 'Acetone (CH₃COCH₃)', correct: true },
      { text: 'Phenol (C₆H₅OH)', correct: false },
      { text: 'Acetic acid (CH₃COOH)', correct: false },
      { text: 'Formaldehyde (HCHO)', correct: false }
    ],
    explanation: 'Acetone can show keto-enol tautomerism because it has α-hydrogens (on CH₃ groups adjacent to C=O). Phenol does not because it would lose aromatic stability. Formaldehyde has no α-hydrogens.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_1,
    question_type: 'true_false',
    question_text: 'Stereoisomers have the same connectivity of atoms but differ in their spatial arrangement.',
    correct_answer: true,
    explanation: 'TRUE. Stereoisomers have identical structural formulas (same connectivity) but differ in the three-dimensional arrangement of atoms in space.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy'
  }
])

puts "✅ Quiz 6.1 created with 6 questions"

# ============================================================================
# LESSON 6.2: Optical Isomerism and Chirality
# ============================================================================

lesson_6_2 = CourseLesson.create!(
  title: 'Optical Isomerism - Chirality, Enantiomers, and Optical Activity',
  reading_time_minutes: 60,
  key_concepts: [
    'Chirality and chiral centers',
    'Enantiomers and mirror images',
    'Optical activity and specific rotation',
    'R/S nomenclature (Cahn-Ingold-Prelog rules)',
    'Racemic mixtures and meso compounds'
  ],
  content: <<~MD
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
  MD
)

ModuleItem.create!(
  course_module: module_06,
  item: lesson_6_2,
  sequence_order: 3,
  required: true
)

puts "✅ Lesson 6.2 created"

# Create Quiz 6.2
quiz_6_2 = Quiz.create!(
  title: 'Quiz 6.2: Optical Isomerism and Chirality',
  description: 'Test your understanding of chirality, enantiomers, and optical activity',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_06,
  item: quiz_6_2,
  sequence_order: 4,
  required: true
)

# Quiz 6.2 Questions
QuizQuestion.create!([
  {
    quiz: quiz_6_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following is the correct definition of chirality?',
    options: [
      { text: 'A molecule that rotates plane-polarized light', correct: false },
      { text: 'A molecule with a chiral center', correct: false },
      { text: 'A molecule that is non-superimposable on its mirror image', correct: true },
      { text: 'A molecule with an asymmetric carbon atom', correct: false }
    ],
    explanation: 'Chirality means non-superimposability on mirror image. While chiral molecules usually have chiral centers and are optically active, the fundamental definition is about mirror image non-superimposability.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_2,
    question_type: 'numerical',
    question_text: 'How many chiral centers are present in the molecule: CH₃-CHBr-CHCl-COOH?',
    correct_answer: '2',
    tolerance: 0,
    explanation: 'Two chiral centers: C-2 (with -CH₃, -Br, -H, -CHClCOOH) and C-3 (with -CHBrCH₃, -Cl, -H, -COOH). Each carbon has 4 different groups.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which properties are IDENTICAL for a pair of enantiomers?',
    options: [
      { text: 'Melting point', correct: true },
      { text: 'Direction of optical rotation', correct: false },
      { text: 'Boiling point', correct: true },
      { text: 'Magnitude of optical rotation', correct: true }
    ],
    explanation: 'Enantiomers have identical physical properties (mp, bp, solubility, density) and same magnitude of optical rotation, but OPPOSITE direction of rotation.',
    points: 4,
    difficulty: 0.1,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_2,
    question_type: 'numerical',
    question_text: 'A solution containing 2.0 g of a compound dissolved in 50 mL of solvent shows a rotation of +30° in a polarimeter tube of length 2 dm. Calculate the specific rotation [α] in degrees·mL/(g·dm).',
    correct_answer: '375',
    tolerance: 5,
    explanation: 'c = 2.0 g / 50 mL = 0.04 g/mL; l = 2 dm; α = +30°. [α] = α/(l×c) = 30/(2×0.04) = 375 degrees·mL/(g·dm).',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.5,
    guessing: 0.0,
    difficulty_level: 'hard'
  },
  {
    quiz: quiz_6_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is a racemic mixture?',
    options: [
      { text: 'A pure enantiomer that is optically active', correct: false },
      { text: 'A 1:1 mixture of two enantiomers that is optically inactive', correct: true },
      { text: 'A meso compound with internal symmetry', correct: false },
      { text: 'A mixture of diastereomers', correct: false }
    ],
    explanation: 'A racemic mixture (racemate) is a 1:1 mixture of both enantiomers. The equal and opposite rotations cancel out, making it optically inactive. Notation: (±) or rac-.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_6_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which statement about meso compounds is CORRECT?',
    options: [
      { text: 'They have no chiral centers', correct: false },
      { text: 'They are optically active', correct: false },
      { text: 'They have an internal plane of symmetry', correct: true },
      { text: 'They are mirror images of each other', correct: false }
    ],
    explanation: 'Meso compounds have chiral centers but possess an internal plane of symmetry, making them optically INACTIVE. They are superimposable on their mirror images.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_2,
    question_type: 'numerical',
    question_text: 'How many stereoisomers are possible for a compound with 3 different chiral centers (assuming no meso forms)?',
    correct_answer: '8',
    tolerance: 0,
    explanation: 'Number of stereoisomers = 2ⁿ where n = number of chiral centers. 2³ = 8 stereoisomers (4 pairs of enantiomers).',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.0,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_6_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In the Cahn-Ingold-Prelog (R/S) system, which of the following groups has the HIGHEST priority?',
    options: [
      { text: '-CH₂OH', correct: false },
      { text: '-CHO', correct: false },
      { text: '-COOH', correct: true },
      { text: '-CH₃', correct: false }
    ],
    explanation: 'Priority order for common groups: -COOH > -CHO > -CH₂OH > -CH₃ > -H. COOH has the highest priority because the C is bonded to two O atoms (counted twice).',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_2,
    question_type: 'true_false',
    question_text: 'The sign of optical rotation (+/- or d/l) directly indicates whether a molecule has R or S configuration.',
    correct_answer: false,
    explanation: 'FALSE. The sign of rotation (+/-) indicates the DIRECTION of light rotation but does NOT correlate with R/S configuration. A compound can be (R)-(+), (R)-(-), (S)-(+), or (S)-(-).',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.5,
    difficulty_level: 'medium'
  }
])

puts "✅ Quiz 6.2 created with 9 questions"

# ============================================================================
# LESSON 6.3: Geometrical Isomerism and Conformational Analysis
# ============================================================================

lesson_6_3 = CourseLesson.create!(
  title: 'Geometrical Isomerism and Conformational Analysis',
  reading_time_minutes: 55,
  key_concepts: [
    'Geometrical isomerism (cis-trans)',
    'E-Z nomenclature',
    'Conformational isomerism',
    'Newman projections',
    'Eclipsed and staggered conformations',
    'Torsional and steric strain'
  ],
  content: <<~MD
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
  MD
)

ModuleItem.create!(
  course_module: module_06,
  item: lesson_6_3,
  sequence_order: 5,
  required: true
)

puts "✅ Lesson 6.3 created"

# Create Quiz 6.3
quiz_6_3 = Quiz.create!(
  title: 'Quiz 6.3: Geometrical and Conformational Isomerism',
  description: 'Test your understanding of cis-trans isomerism, E-Z nomenclature, and conformational analysis',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_06,
  item: quiz_6_3,
  sequence_order: 6,
  required: true
)

# Quiz 6.3 Questions
QuizQuestion.create!([
  {
    quiz: quiz_6_3,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following conditions are REQUIRED for geometrical isomerism in alkenes?',
    options: [
      { text: 'Restricted rotation around C=C double bond', correct: true },
      { text: 'Different groups on each carbon of the double bond', correct: true },
      { text: 'Presence of a chiral center', correct: false },
      { text: 'At least one hydrogen on each carbon', correct: false }
    ],
    explanation: 'Geometrical isomerism requires: (1) Restricted rotation (C=C or ring) and (2) Different groups on each carbon. It does NOT require chirality or specific H atoms.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following compounds can show geometrical isomerism?',
    options: [
      { text: 'CH₃-CH=CH₂ (Propene)', correct: false },
      { text: 'CH₃-CH=CH-CH₃ (2-Butene)', correct: true },
      { text: 'CH₂=CH₂ (Ethene)', correct: false },
      { text: 'CH₂=C(CH₃)₂ (2-Methylpropene)', correct: false }
    ],
    explanation: '2-Butene shows geometrical isomerism (cis/trans) because each C of the double bond has different groups. Propene has two H on one C. Ethene has two H on each C. 2-Methylpropene has two CH₃ on one C.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In the E-Z nomenclature system, what does "Z" stand for?',
    options: [
      { text: 'Zero - groups are at 0° angle', correct: false },
      { text: 'Zusammen - higher priority groups on same side', correct: true },
      { text: 'Zipper - groups are close together', correct: false },
      { text: 'Z-axis - groups are aligned vertically', correct: false }
    ],
    explanation: 'Z = Zusammen (German for "together"). Higher priority groups on the same side → Z. E = Entgegen (opposite) → higher priority groups on opposite sides.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_6_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why is trans-2-butene MORE STABLE than cis-2-butene?',
    options: [
      { text: 'trans has stronger C=C bond', correct: false },
      { text: 'trans has less steric repulsion between CH₃ groups', correct: true },
      { text: 'trans has more hydrogen bonding', correct: false },
      { text: 'trans has higher dipole moment', correct: false }
    ],
    explanation: 'trans-2-butene is more stable because the two CH₃ groups are on opposite sides of the double bond (180° apart), minimizing steric repulsion. In cis, they are on the same side causing repulsion.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In a Newman projection of ethane, which conformation has the LOWEST energy?',
    options: [
      { text: 'Eclipsed', correct: false },
      { text: 'Staggered', correct: true },
      { text: 'Gauche', correct: false },
      { text: 'Anti', correct: false }
    ],
    explanation: 'Staggered conformation has the lowest energy (most stable) because bonds are 60° apart, minimizing electron repulsion. Eclipsed has maximum repulsion (0° dihedral angle). Gauche and anti are specific to molecules like butane.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_6_3,
    question_type: 'numerical',
    question_text: 'What is the approximate energy difference (in kJ/mol) between the staggered and eclipsed conformations of ethane?',
    correct_answer: '12',
    tolerance: 2,
    explanation: 'The rotation barrier in ethane is approximately 12 kJ/mol. This is the energy difference between the lowest energy conformation (staggered) and highest energy conformation (eclipsed).',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'For butane (CH₃-CH₂-CH₂-CH₃), looking down the C2-C3 bond, which conformation is the MOST STABLE?',
    options: [
      { text: 'Eclipsed (CH₃-CH₃)', correct: false },
      { text: 'Eclipsed (CH₃-H)', correct: false },
      { text: 'Gauche', correct: false },
      { text: 'Anti', correct: true }
    ],
    explanation: 'Anti conformation (CH₃ groups 180° apart) is the most stable. Energy order: Anti (0 kJ/mol) < Gauche (+3.8) < Eclipsed H-H (+14) < Eclipsed CH₃-CH₃ (+19).',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the primary cause of torsional strain?',
    options: [
      { text: 'Repulsion between atoms that are too close in space', correct: false },
      { text: 'Deviation from ideal bond angles', correct: false },
      { text: 'Repulsion between electrons in eclipsed bonds', correct: true },
      { text: 'Attraction between opposite charges', correct: false }
    ],
    explanation: 'Torsional strain arises from repulsion between electrons in eclipsed bonds (0° dihedral angle). Steric strain is from atoms being too close. Angle strain is from deviation from ideal angles.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_6_3,
    question_type: 'true_false',
    question_text: 'Conformational isomers can be easily isolated and stored separately at room temperature.',
    correct_answer: false,
    explanation: 'FALSE. Conformational isomers (conformers) rapidly interconvert at room temperature due to low rotation barrier (~10-20 kJ/mol). They cannot be isolated separately under normal conditions.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.5,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_6_3,
    question_type: 'numerical',
    question_text: 'What is the approximate energy (in kJ/mol) of the gauche conformation of butane relative to the anti conformation?',
    correct_answer: '3.8',
    tolerance: 0.5,
    explanation: 'The gauche conformation of butane is approximately 3.8 kJ/mol higher in energy than the anti conformation due to steric repulsion between the two CH₃ groups that are 60° apart.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'medium'
  }
])

puts "✅ Quiz 6.3 created with 10 questions"

puts "\n" + "="*80
puts "Module 6: Stereochemistry Complete!"
puts "="*80
puts "✅ 3 comprehensive lessons covering:"
puts "   - Isomerism fundamentals"
puts "   - Optical isomerism and chirality"
puts "   - Geometrical and conformational isomerism"
puts "✅ 3 quizzes with 25 questions total"
puts "="*80

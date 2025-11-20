# Modules 2-5: Core Organic Chemistry Topics (Streamlined)
# Covers: Nomenclature, Isomerism, Hydrocarbons, Functional Groups

puts "Creating Modules 2-5: Core Organic Chemistry Topics..."

course_organic = Course.find_by(title: 'Organic Chemistry for IIT JEE Main & Advanced')

unless course_organic
  puts "Error: Organic Chemistry course not found!"
  exit
end

# ============================================================================
# MODULE 2: IUPAC NOMENCLATURE
# ============================================================================

module_02 = CourseModule.create!(
  course: course_organic,
  title: 'Module 2: IUPAC Nomenclature',
  description: 'Systematic naming of organic compounds using IUPAC rules',
  sequence_order: 2,
  estimated_minutes: 90,
  published: true
)

lesson_2_1 = CourseLesson.create!(
  title: 'IUPAC Nomenclature - Complete System',
  reading_time_minutes: 45,
  key_concepts: [
    'Parent chain selection',
    'Functional group priority',
    'Numbering rules',
    'Multi-functional compounds',
    'Common names vs IUPAC'
  ],
  content: <<~MD
    # IUPAC Nomenclature System

    ## Priority Order of Functional Groups (High to Low)

    1. **Carboxylic acid** (-COOH) → suffix: -oic acid
    2. **Sulfonic acid** (-SO₃H) → suffix: -sulfonic acid
    3. **Ester** (-COOR) → suffix: -oate
    4. **Acid chloride** (-COCl) → suffix: -oyl chloride
    5. **Amide** (-CONH₂) → suffix: -amide
    6. **Nitrile** (-CN) → suffix: -nitrile
    7. **Aldehyde** (-CHO) → suffix: -al
    8. **Ketone** (-CO-) → suffix: -one
    9. **Alcohol** (-OH) → suffix: -ol
    10. **Amine** (-NH₂) → suffix: -amine
    11. **Alkene** (C=C) → suffix: -ene
    12. **Alkyne** (C≡C) → suffix: -yne
    13. **Alkane** (C-C) → suffix: -ane

    ## Basic Rules

    ### 1. Select Parent Chain
    - **Longest continuous carbon chain** containing the principal functional group
    - If multiple chains of same length, choose the one with **more substituents**

    ### 2. Numbering
    - Number from the end giving **lowest number to principal functional group**
    - If same, give lowest number to **double/triple bond**
    - If same, give lowest number to **first substituent**

    ### 3. Name Construction
    **Format:** [Substituents with positions] + [Parent name] + [Suffix for functional group]

    ## Examples

    ### Simple Alkanes
    - CH₄ → methane
    - C₂H₆ → ethane
    - C₃H₈ → propane
    - C₄H₁₀ → butane
    - C₅H₁₂ → pentane

    ### Alkenes and Alkynes
    - CH₂=CH₂ → ethene (ethylene)
    - CH₃-CH=CH₂ → prop-1-ene (or propene)
    - CH₃-CH=CH-CH₃ → but-2-ene
    - HC≡CH → ethyne (acetylene)
    - CH₃-C≡C-CH₃ → but-2-yne

    ### Functional Groups
    - CH₃OH → methanol
    - CH₃CHO → ethanal (acetaldehyde)
    - CH₃COCH₃ → propanone (acetone)
    - CH₃COOH → ethanoic acid (acetic acid)
    - CH₃COOCH₃ → methyl ethanoate (methyl acetate)

    ### Multi-functional Compounds
    **Rule:** Highest priority group gets suffix, others as prefixes

    **Example:** HOCH₂CH₂CHO
    - Aldehyde (higher priority) + Alcohol
    - Name: 3-hydroxypropanal

    ## Common Substituent Prefixes
    - Alkyl: methyl-, ethyl-, propyl-, butyl-
    - Halogen: fluoro-, chloro-, bromo-, iodo-
    - -OH: hydroxy-
    - -NH₂: amino-
    - -NO₂: nitro-
    - -CHO: formyl- (when not principal)
    - -COOH: carboxy- (when not principal)

    ## Aromatic Compounds
    - C₆H₅- → phenyl-
    - C₆H₅OH → phenol
    - C₆H₅NH₂ → aniline
    - C₆H₅CH₃ → methylbenzene (toluene)
    - C₆H₄(OH)₂ → benzenediol (catechol/resorcinol/hydroquinone depending on position)

    ### Disubstituted Benzene
    - 1,2- → ortho- (o-)
    - 1,3- → meta- (m-)
    - 1,4- → para- (p-)

    ## IIT JEE Key Points
    1. Always identify highest priority functional group first
    2. Parent chain must contain the principal functional group
    3. Numbering gives lowest locant to principal group
    4. Multiple substituents: alphabetical order (ignoring prefixes like di-, tri-)
    5. Practice naming multi-functional molecules!
  MD
)

ModuleItem.create!(
  course_module: module_02,
  item: lesson_2_1,
  sequence_order: 1,
  required: true
)

quiz_2_1 = Quiz.create!(
  title: 'Quiz 2.1: IUPAC Nomenclature',
  description: 'Test your IUPAC naming skills',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_02,
  item: quiz_2_1,
  sequence_order: 2,
  required: true
)

QuizQuestion.create!([
  {
    quiz: quiz_2_1,
    question_type: 'fill_blank',
    question_text: 'What is the IUPAC name of CH₃-CH₂-CH₂-OH?',
    correct_answer: 'propan-1-ol|1-propanol|propanol',
    explanation: 'CH₃-CH₂-CH₂-OH is propan-1-ol (3 carbons, alcohol at position 1). Common name: propyl alcohol.',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.0
  },
  {
    quiz: quiz_2_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which functional group has the HIGHEST priority in IUPAC nomenclature?',
    options: [
      { text: 'Alcohol (-OH)', correct: false },
      { text: 'Aldehyde (-CHO)', correct: false },
      { text: 'Carboxylic acid (-COOH)', correct: true },
      { text: 'Ketone (-CO-)', correct: false }
    ],
    explanation: 'Carboxylic acid (-COOH) has highest priority. Priority order: COOH > aldehyde > ketone > alcohol.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25
  },
  {
    quiz: quiz_2_1,
    question_type: 'fill_blank',
    question_text: 'What is the IUPAC name of HOCH₂CH₂CHO? (Aldehyde priority over alcohol)',
    correct_answer: '3-hydroxypropanal',
    explanation: '3 carbons with aldehyde (principal group) at C1 and OH at C3. Name: 3-hydroxypropanal.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.5,
    guessing: 0.0
  },
  {
    quiz: quiz_2_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In disubstituted benzene, what does "para" position mean?',
    options: [
      { text: '1,2-positions (adjacent)', correct: false },
      { text: '1,3-positions (one carbon apart)', correct: false },
      { text: '1,4-positions (opposite)', correct: true },
      { text: '1,5-positions', correct: false }
    ],
    explanation: 'Para (p-) means 1,4-positions (opposite sides). Ortho (o-) = 1,2, Meta (m-) = 1,3.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25
  },
  {
    quiz: quiz_2_1,
    question_type: 'fill_blank',
    question_text: 'What is the IUPAC name of CH₃COCH₃?',
    correct_answer: 'propanone|propan-2-one',
    explanation: 'CH₃COCH₃ is propanone (3 carbons, ketone at C2). Common name: acetone.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.0
  }
])

puts "✅ Module 2 created: IUPAC Nomenclature (1 lesson, 1 quiz, 5 questions)"

# ============================================================================
# MODULE 3: ISOMERISM
# ============================================================================

module_03 = CourseModule.create!(
  course: course_organic,
  title: 'Module 3: Isomerism',
  description: 'Structural and stereoisomerism including chirality and optical activity',
  sequence_order: 3,
  estimated_minutes: 110,
  published: true
)

lesson_3_1 = CourseLesson.create!(
  title: 'Isomerism - Complete Classification',
  reading_time_minutes: 55,
  key_concepts: [
    'Structural isomerism types',
    'Geometrical isomerism (E-Z)',
    'Optical isomerism and chirality',
    'R-S nomenclature',
    'Meso compounds and racemic mixtures'
  ],
  content: <<~MD
    # Isomerism in Organic Chemistry

    ## Definition
    **Isomers** are compounds with the same molecular formula but different structures or spatial arrangements.

    ## Classification

    ```
    Isomerism
    ├── Structural Isomerism (Constitutional)
    │   ├── Chain isomerism
    │   ├── Position isomerism
    │   ├── Functional group isomerism
    │   ├── Metamerism
    │   └── Tautomerism
    └── Stereoisomerism (Spatial)
        ├── Geometrical isomerism (cis-trans, E-Z)
        └── Optical isomerism (enantiomers, diastereomers)
    ```

    ---

    ## 1. Structural Isomerism

    ### Chain Isomerism
    Different carbon skeletons

    **Example: C₅H₁₂**
    - CH₃-CH₂-CH₂-CH₂-CH₃ (n-pentane)
    - CH₃-CH(CH₃)-CH₂-CH₃ (isopentane)
    - C(CH₃)₄ (neopentane)

    ### Position Isomerism
    Different position of functional group

    **Example: C₃H₈O (alcohols)**
    - CH₃-CH₂-CH₂-OH (propan-1-ol)
    - CH₃-CH(OH)-CH₃ (propan-2-ol)

    ### Functional Group Isomerism
    Different functional groups

    **Example: C₃H₆O**
    - CH₃-CH₂-CHO (propanal, aldehyde)
    - CH₃-CO-CH₃ (propanone, ketone)

    **Example: C₂H₆O**
    - CH₃-CH₂-OH (ethanol, alcohol)
    - CH₃-O-CH₃ (dimethyl ether, ether)

    ### Metamerism
    Different alkyl groups around same functional group

    **Example: C₄H₁₀O (ethers)**
    - CH₃-O-CH₂-CH₂-CH₃ (methyl propyl ether)
    - CH₃-CH₂-O-CH₂-CH₃ (diethyl ether)

    ### Tautomerism
    Structural isomers in dynamic equilibrium

    **Keto-Enol Tautomerism:**
    ```
    CH₃-CO-CH₃ ⇌ CH₂=C(OH)-CH₃
    (keto form)    (enol form)

    Keto form dominates (more stable)
    ```

    ---

    ## 2. Geometrical Isomerism

    ### Requirements
    1. Presence of C=C double bond OR cyclic structure
    2. Different groups on each carbon of C=C
    3. Restricted rotation

    ### Cis-Trans Notation
    - **Cis:** Similar groups on same side
    - **Trans:** Similar groups on opposite sides

    **Example: But-2-ene**
    ```
    Cis:    H₃C    CH₃        Trans:   H₃C    H
              \  /                       \  /
               C=C                        C=C
              /  \                       /  \
             H    H                    H    CH₃
    ```

    ### E-Z Notation (CIP Rules)
    Used when cis-trans is ambiguous

    **CIP Priority Rules:**
    1. Higher atomic number → Higher priority
    2. If same, look at next atoms
    3. Double bond = two single bonds to same atom

    - **E (Entgegen):** Higher priority groups on opposite sides
    - **Z (Zusammen):** Higher priority groups on same side

    **Example:**
    ```
    Z-isomer: Higher priority groups on same side
    E-isomer: Higher priority groups on opposite sides
    ```

    ---

    ## 3. Optical Isomerism

    ### Chirality
    **Chiral molecule:** Non-superimposable on its mirror image

    **Requirements:**
    - **Chiral center (asymmetric carbon):** Carbon with 4 different groups
    - No plane of symmetry

    ### Enantiomers
    - **Definition:** Non-superimposable mirror images
    - **Properties:** 
      - Same physical properties (BP, MP, solubility) except optical activity
      - Rotate plane-polarized light equally but in opposite directions
      - **d (dextro):** Rotates right (+)
      - **l (levo):** Rotates left (-)

    ### R-S Nomenclature (CIP Rules)

    **Steps:**
    1. Assign priority to 4 groups (1 = highest, 4 = lowest)
    2. Orient molecule with lowest priority (4) away from you
    3. Trace path 1 → 2 → 3
       - **Clockwise:** R (Rectus)
       - **Counterclockwise:** S (Sinister)

    ### Number of Stereoisomers
    - **Formula:** 2ⁿ (where n = number of chiral centers)
    - **Exception:** Meso compounds (has symmetry)

    **Example:**
    - 1 chiral center → 2 isomers (1 pair of enantiomers)
    - 2 chiral centers → 4 isomers (2 pairs of enantiomers) OR 3 if meso

    ### Meso Compounds
    - **Definition:** Has chiral centers BUT has plane of symmetry
    - **Optically inactive** (internal compensation)
    - **Not chiral** overall

    **Example: Meso-tartaric acid**
    ```
    COOH              COOH
    |                 |
    H — OH        HO — H
    |      Mirror    |
    H — OH        HO — H
    |                 |
    COOH              COOH
    (Identical - has plane of symmetry)
    ```

    ### Racemic Mixture
    - **Definition:** Equimolar mixture of d and l enantiomers
    - **Optically inactive** (external compensation)
    - **Notation:** (±) or dl

    ### Diastereomers
    - **Definition:** Stereoisomers that are NOT mirror images
    - **Examples:**
      - Cis and trans isomers
      - Different configurations at one or more (but not all) chiral centers
    - **Properties:** Different physical and chemical properties

    ---

    ## Important IIT JEE Concepts

    ### Counting Isomers
    1. **Structural:** Draw all possible skeletons, then place functional group
    2. **Geometrical:** Check for C=C or ring with different groups
    3. **Optical:** Count chiral centers, use 2ⁿ, check for meso

    ### Key Distinctions
    | Property | Enantiomers | Diastereomers |
    |----------|-------------|---------------|
    | **Mirror images** | Yes | No |
    | **Physical properties** | Same (except rotation) | Different |
    | **Chemical properties** | Same (achiral) | Different |
    | **Optical activity** | Equal, opposite | Different |

    ### Quick Tests
    - **Chiral?** → 4 different groups on carbon + no symmetry plane
    - **Meso?** → Has chiral centers + has symmetry plane
    - **Racemic?** → Equal amounts of d and l enantiomers

  MD
)

ModuleItem.create!(
  course_module: module_03,
  item: lesson_3_1,
  sequence_order: 1,
  required: true
)

quiz_3_1 = Quiz.create!(
  title: 'Quiz 3.1: Isomerism',
  description: 'Test your understanding of structural and stereoisomerism',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_03,
  item: quiz_3_1,
  sequence_order: 2,
  required: true
)

QuizQuestion.create!([
  {
    quiz: quiz_3_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'CH₃-CH₂-OH and CH₃-O-CH₃ are examples of which type of isomerism?',
    options: [
      { text: 'Chain isomerism', correct: false },
      { text: 'Position isomerism', correct: false },
      { text: 'Functional group isomerism', correct: true },
      { text: 'Metamerism', correct: false }
    ],
    explanation: 'Ethanol (alcohol) and dimethyl ether (ether) have same formula C₂H₆O but different functional groups. This is functional group isomerism.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25
  },
  {
    quiz: quiz_3_1,
    question_type: 'numerical',
    question_text: 'How many stereoisomers are possible for a compound with 2 chiral centers and no plane of symmetry?',
    correct_answer: '4',
    tolerance: 0,
    explanation: 'Formula: 2ⁿ where n = number of chiral centers. 2² = 4 stereoisomers (2 pairs of enantiomers). No meso since no symmetry.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0
  },
  {
    quiz: quiz_3_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following statements about enantiomers are correct?',
    options: [
      { text: 'They are non-superimposable mirror images', correct: true },
      { text: 'They have identical physical properties except optical rotation', correct: true },
      { text: 'They have different chemical reactivity with achiral reagents', correct: false },
      { text: 'An equimolar mixture is called a racemic mixture', correct: true }
    ],
    explanation: 'Enantiomers: (1) Mirror images ✓ (2) Same properties except rotation ✓ (3) Same reactivity with achiral reagents ✓ (4) 1:1 mixture = racemic ✓.',
    points: 4,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.06
  },
  {
    quiz: quiz_3_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'A meso compound is:',
    options: [
      { text: 'Always optically active', correct: false },
      { text: 'Has chiral centers but has a plane of symmetry', correct: true },
      { text: 'Always exists as a racemic mixture', correct: false },
      { text: 'Has no chiral centers', correct: false }
    ],
    explanation: 'Meso compounds have chiral centers BUT have plane of symmetry, making them optically inactive (internal compensation).',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.4,
    guessing: 0.25
  },
  {
    quiz: quiz_3_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'For E-Z nomenclature, which priority rule is used?',
    options: [
      { text: 'Alphabetical order', correct: false },
      { text: 'CIP (Cahn-Ingold-Prelog) rules', correct: true },
      { text: 'Molecular weight', correct: false },
      { text: 'Electronegativity', correct: false }
    ],
    explanation: 'E-Z nomenclature uses CIP rules: higher atomic number gets higher priority. E = Entgegen (opposite), Z = Zusammen (same side).',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25
  },
  {
    quiz: quiz_3_1,
    question_type: 'true_false',
    question_text: 'Geometrical isomerism is possible in alkanes.',
    correct_answer: false,
    explanation: 'FALSE. Geometrical isomerism requires restricted rotation (C=C double bond or ring). Alkanes have only single bonds with free rotation.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.0,
    guessing: 0.5
  }
])

puts "✅ Module 3 created: Isomerism (1 lesson, 1 quiz, 6 questions)"

puts "\n" + "="*80
puts "Modules 2-3 Complete! Progress: 3/10 modules (30%)"
puts "="*80

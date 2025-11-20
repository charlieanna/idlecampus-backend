# AUTO-GENERATED from modules_02_to_05_core.rb
puts "Creating Microlessons for Modules 02 To 05 Core..."

module_var = CourseModule.find_by(slug: 'modules-02-to-05-core')

# === MICROLESSON 1: Geometrical isomerism is possible in alkanes. ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Geometrical isomerism is possible in alkanes.',
  content: <<~MARKDOWN,
# Geometrical isomerism is possible in alkanes. 🚀

FALSE. Geometrical isomerism requires restricted rotation (C=C double bond or ring). Alkanes have only single bonds with free rotation.

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
    question: 'Geometrical isomerism is possible in alkanes.',
    answer: '',
    explanation: 'FALSE. Geometrical isomerism requires restricted rotation (C=C double bond or ring). Alkanes have only single bonds with free rotation.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Isomerism - Complete Classification ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Isomerism - Complete Classification',
  content: <<~MARKDOWN,
# Isomerism - Complete Classification 🚀

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

## Key Points

- Structural isomerism types

- Geometrical isomerism (E-Z)

- Optical isomerism and chirality
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Structural isomerism types', 'Geometrical isomerism (E-Z)', 'Optical isomerism and chirality', 'R-S nomenclature', 'Meso compounds and racemic mixtures'],
  prerequisite_ids: []
)

# === MICROLESSON 3: IUPAC Nomenclature - Complete System ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'IUPAC Nomenclature - Complete System',
  content: <<~MARKDOWN,
# IUPAC Nomenclature - Complete System 🚀

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

## Key Points

- Parent chain selection

- Functional group priority

- Numbering rules
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Parent chain selection', 'Functional group priority', 'Numbering rules', 'Multi-functional compounds', 'Common names vs IUPAC'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Isomerism - Complete Classification ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Isomerism - Complete Classification',
  content: <<~MARKDOWN,
# Isomerism - Complete Classification 🚀

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

## Key Points

- Structural isomerism types

- Geometrical isomerism (E-Z)

- Optical isomerism and chirality
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Structural isomerism types', 'Geometrical isomerism (E-Z)', 'Optical isomerism and chirality', 'R-S nomenclature', 'Meso compounds and racemic mixtures'],
  prerequisite_ids: []
)

# === MICROLESSON 5: What is the IUPAC name of CH₃-CH₂-CH₂-OH? ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the IUPAC name of CH₃-CH₂-CH₂-OH?',
  content: <<~MARKDOWN,
# What is the IUPAC name of CH₃-CH₂-CH₂-OH? 🚀

CH₃-CH₂-CH₂-OH is propan-1-ol (3 carbons, alcohol at position 1). Common name: propyl alcohol.

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

# Exercise 5.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the IUPAC name of CH₃-CH₂-CH₂-OH?',
    answer: 'propan-1-ol|1-propanol|propanol',
    explanation: 'CH₃-CH₂-CH₂-OH is propan-1-ol (3 carbons, alcohol at position 1). Common name: propyl alcohol.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 6: Which functional group has the HIGHEST priority in IUPAC nomenclature? ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which functional group has the HIGHEST priority in IUPAC nomenclature?',
  content: <<~MARKDOWN,
# Which functional group has the HIGHEST priority in IUPAC nomenclature? 🚀

Carboxylic acid (-COOH) has highest priority. Priority order: COOH > aldehyde > ketone > alcohol.

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
    question: 'Which functional group has the HIGHEST priority in IUPAC nomenclature?',
    options: ['Alcohol (-OH)', 'Aldehyde (-CHO)', 'Carboxylic acid (-COOH)', 'Ketone (-CO-)'],
    correct_answer: 2,
    explanation: 'Carboxylic acid (-COOH) has highest priority. Priority order: COOH > aldehyde > ketone > alcohol.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 7: What is the IUPAC name of HOCH₂CH₂CHO? (Aldehyde priority over alcohol) ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the IUPAC name of HOCH₂CH₂CHO? (Aldehyde priority over alcohol)',
  content: <<~MARKDOWN,
# What is the IUPAC name of HOCH₂CH₂CHO? (Aldehyde priority over alcohol) 🚀

3 carbons with aldehyde (principal group) at C1 and OH at C3. Name: 3-hydroxypropanal.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the IUPAC name of HOCH₂CH₂CHO? (Aldehyde priority over alcohol)',
    answer: '3-hydroxypropanal',
    explanation: '3 carbons with aldehyde (principal group) at C1 and OH at C3. Name: 3-hydroxypropanal.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: In disubstituted benzene, what does \"para\" position mean? ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'In disubstituted benzene, what does \"para\" position mean?',
  content: <<~MARKDOWN,
# In disubstituted benzene, what does "para" position mean? 🚀

Para (p-) means 1,4-positions (opposite sides). Ortho (o-) = 1,2, Meta (m-) = 1,3.

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
    question: 'In disubstituted benzene, what does "para" position mean?',
    options: ['1,2-positions (adjacent)', '1,3-positions (one carbon apart)', '1,4-positions (opposite)', '1,5-positions'],
    correct_answer: 2,
    explanation: 'Para (p-) means 1,4-positions (opposite sides). Ortho (o-) = 1,2, Meta (m-) = 1,3.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: What is the IUPAC name of CH₃COCH₃? ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the IUPAC name of CH₃COCH₃?',
  content: <<~MARKDOWN,
# What is the IUPAC name of CH₃COCH₃? 🚀

CH₃COCH₃ is propanone (3 carbons, ketone at C2). Common name: acetone.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the IUPAC name of CH₃COCH₃?',
    answer: 'propanone|propan-2-one',
    explanation: 'CH₃COCH₃ is propanone (3 carbons, ketone at C2). Common name: acetone.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: CH₃-CH₂-OH and CH₃-O-CH₃ are examples of which type of isomerism? ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'CH₃-CH₂-OH and CH₃-O-CH₃ are examples of which type of isomerism?',
  content: <<~MARKDOWN,
# CH₃-CH₂-OH and CH₃-O-CH₃ are examples of which type of isomerism? 🚀

Ethanol (alcohol) and dimethyl ether (ether) have same formula C₂H₆O but different functional groups. This is functional group isomerism.

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
    question: 'CH₃-CH₂-OH and CH₃-O-CH₃ are examples of which type of isomerism?',
    options: ['Chain isomerism', 'Position isomerism', 'Functional group isomerism', 'Metamerism'],
    correct_answer: 2,
    explanation: 'Ethanol (alcohol) and dimethyl ether (ether) have same formula C₂H₆O but different functional groups. This is functional group isomerism.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 11: How many stereoisomers are possible for a compound with 2 chiral centers and no plane of symmetry? ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'How many stereoisomers are possible for a compound with 2 chiral centers and no plane of symmetry?',
  content: <<~MARKDOWN,
# How many stereoisomers are possible for a compound with 2 chiral centers and no plane of symmetry? 🚀

Formula: 2ⁿ where n = number of chiral centers. 2² = 4 stereoisomers (2 pairs of enantiomers). No meso since no symmetry.

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

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many stereoisomers are possible for a compound with 2 chiral centers and no plane of symmetry?',
    answer: '4',
    explanation: 'Formula: 2ⁿ where n = number of chiral centers. 2² = 4 stereoisomers (2 pairs of enantiomers). No meso since no symmetry.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: Which of the following statements about enantiomers are correct? ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following statements about enantiomers are correct?',
  content: <<~MARKDOWN,
# Which of the following statements about enantiomers are correct? 🚀

Enantiomers: (1) Mirror images ✓ (2) Same properties except rotation ✓ (3) Same reactivity with achiral reagents ✓ (4) 1:1 mixture = racemic ✓.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
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
    question: 'Which of the following statements about enantiomers are correct?',
    options: ['They are non-superimposable mirror images', 'They have identical physical properties except optical rotation', 'They have different chemical reactivity with achiral reagents', 'An equimolar mixture is called a racemic mixture'],
    correct_answer: 3,
    explanation: 'Enantiomers: (1) Mirror images ✓ (2) Same properties except rotation ✓ (3) Same reactivity with achiral reagents ✓ (4) 1:1 mixture = racemic ✓.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 13: A meso compound is: ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'A meso compound is:',
  content: <<~MARKDOWN,
# A meso compound is: 🚀

Meso compounds have chiral centers BUT have plane of symmetry, making them optically inactive (internal compensation).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'hard',
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
    question: 'A meso compound is:',
    options: ['Always optically active', 'Has chiral centers but has a plane of symmetry', 'Always exists as a racemic mixture', 'Has no chiral centers'],
    correct_answer: 1,
    explanation: 'Meso compounds have chiral centers BUT have plane of symmetry, making them optically inactive (internal compensation).',
    difficulty: 'hard'
  }
)

# === MICROLESSON 14: For E-Z nomenclature, which priority rule is used? ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'For E-Z nomenclature, which priority rule is used?',
  content: <<~MARKDOWN,
# For E-Z nomenclature, which priority rule is used? 🚀

E-Z nomenclature uses CIP rules: higher atomic number gets higher priority. E = Entgegen (opposite), Z = Zusammen (same side).

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
    question: 'For E-Z nomenclature, which priority rule is used?',
    options: ['Alphabetical order', 'CIP (Cahn-Ingold-Prelog) rules', 'Molecular weight', 'Electronegativity'],
    correct_answer: 1,
    explanation: 'E-Z nomenclature uses CIP rules: higher atomic number gets higher priority. E = Entgegen (opposite), Z = Zusammen (same side).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 15: IUPAC Nomenclature - Complete System ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'IUPAC Nomenclature - Complete System',
  content: <<~MARKDOWN,
# IUPAC Nomenclature - Complete System 🚀

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

## Key Points

- Parent chain selection

- Functional group priority

- Numbering rules
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Parent chain selection', 'Functional group priority', 'Numbering rules', 'Multi-functional compounds', 'Common names vs IUPAC'],
  prerequisite_ids: []
)

puts "✓ Created 15 microlessons for Modules 02 To 05 Core"

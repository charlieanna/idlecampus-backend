# AUTO-GENERATED from iit_jee_inorganic_chemistry.rb
puts "Creating Microlessons for Periodic Table Periodicity..."

module_var = CourseModule.find_by(slug: 'periodic-table-periodicity')

# === MICROLESSON 1: ligands — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'ligands — Practice',
  content: <<~MARKDOWN,
# ligands — Practice 🚀

Chelates (from Greek "chela" meaning claw) are complexes with polydentate ligands forming rings. They are more stable than similar complexes with monodentate ligands (chelate effect).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['ligands'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Complexes formed with polydentate ligands that create ring structures are called _______.',
    answer: 'chelates|chelate complexes',
    explanation: 'Chelates (from Greek "chela" meaning claw) are complexes with polydentate ligands forming rings. They are more stable than similar complexes with monodentate ligands (chelate effect).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Types of Chemical Bonds ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Types of Chemical Bonds',
  content: <<~MARKDOWN,
# Types of Chemical Bonds 🚀

# Types of Chemical Bonds

    ## Ionic Bonding

    **Definition**: Electrostatic attraction between oppositely charged ions.

    ### Formation
    - Transfer of electrons from metal (low IE) to non-metal (high EA)
    - Example: Na + Cl → Na⁺Cl⁻

    ### Properties of Ionic Compounds
    1. High melting and boiling points
    2. Conduct electricity in molten/aqueous state (not solid)
    3. Soluble in polar solvents (water)
    4. Hard but brittle
    5. Form crystalline solids

    ### Lattice Energy
    - Energy released when gaseous ions form a solid lattice
    - Higher lattice energy = Stronger ionic bond
    - Depends on charge and size of ions

    **Born-Haber Cycle**: Used to calculate lattice energy

    ## Covalent Bonding

    **Definition**: Sharing of electron pairs between atoms.

    ### Types
    1. **Single bond** (σ bond): 1 shared pair (e.g., H-H)
    2. **Double bond** (σ + π): 2 shared pairs (e.g., O=O)
    3. **Triple bond** (σ + 2π): 3 shared pairs (e.g., N≡N)

    ### Properties of Covalent Compounds
    1. Low melting and boiling points (except network solids)
    2. Poor conductors of electricity
    3. Soluble in non-polar solvents
    4. Exist as gases, liquids, or soft solids

    ### Bond Parameters

    #### 1. Bond Length
    - Distance between nuclei of bonded atoms
    - Order: Triple < Double < Single bond
    - Decreases with increasing bond order

    #### 2. Bond Energy
    - Energy required to break a bond
    - Order: Triple > Double > Single bond
    - Increases with bond order

    #### 3. Bond Angle
    - Angle between two bonds at an atom
    - Determined by hybridization and geometry

    ## Coordinate Bonding

    **Definition**: Covalent bond where both electrons come from one atom (donor).

    ### Representation
    - Shown as A → B (arrow from donor to acceptor)
    - Example: H₃N → BF₃ (ammonia-borane complex)

    ### Examples
    1. **NH₄⁺**: N donates lone pair to H⁺
    2. **H₃O⁺**: O donates lone pair to H⁺
    3. **Metal complexes**: Ligands donate to metal

    ## Fajans' Rules (Ionic/Covalent Character)

    Covalent character in ionic compounds increases when:
    1. Small cation (high polarizing power)
    2. Large anion (high polarizability)
    3. High charge on ions

    **Example**: AgCl has more covalent character than NaCl

    ## Practice Problems

    1. Why does LiCl have more covalent character than NaCl?
    2. Arrange in order of bond length: C-C, C=C, C≡C
    3. Which has higher lattice energy: NaF or NaCl?

## Key Points

- Ionic bonding

- Covalent bonding

- Coordinate bonds
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ionic bonding', 'Covalent bonding', 'Coordinate bonds', 'Bond parameters'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Introduction to Coordination Compounds ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Coordination Compounds',
  content: <<~MARKDOWN,
# Introduction to Coordination Compounds 🚀

# Coordination Compounds - Introduction

    ## What are Coordination Compounds?

    **Definition**: Complex compounds formed by a central metal atom/ion bonded to ions or molecules called ligands.

    **General Formula**: [MLₙ]^(charge)
    - M = Central metal atom/ion
    - L = Ligand
    - n = Coordination number

    ## Werner's Theory (1893) - Nobel Prize 1913

    ### Postulates

    1. **Primary Valence (Principal Valence)**
       - Ionizable bonds (shown by ionic bonding)
       - Equal to oxidation state of metal
       - Satisfied by negative ions
       - Example: In [Co(NH₃)₆]Cl₃, primary valence = +3

    2. **Secondary Valence (Auxiliary Valence)**
       - Non-ionizable bonds (coordinate bonds)
       - Equal to coordination number
       - Satisfied by ligands (neutral or negative)
       - Example: In [Co(NH₃)₆]Cl₃, secondary valence = 6

    3. **Directional Nature**
       - Secondary valences are directional
       - Give definite geometry to complexes
       - Example: Octahedral, tetrahedral, square planar

    ## Key Terms

    ### 1. Central Atom/Ion
    - Usually a transition metal
    - Has vacant orbitals to accept electron pairs
    - Examples: Fe²⁺, Cu²⁺, Co³⁺, Ni²⁺

    ### 2. Ligands
    - Ions or molecules with lone pairs
    - Act as Lewis bases (electron pair donors)
    - Form coordinate bonds with central metal

    #### Classification by Number of Donor Atoms:

    | Type | Donor Atoms | Examples |
    |------|-------------|----------|
    | Monodentate | 1 | NH₃, H₂O, Cl⁻, CN⁻ |
    | Bidentate | 2 | en (ethylenediamine), ox (oxalate) |
    | Tridentate | 3 | dien (diethylenetriamine) |
    | Tetradentate | 4 | Triethylenetetramine |
    | Pentadentate | 5 | DTPA |
    | Hexadentate | 6 | EDTA |

    **Chelate**: Complex with polydentate ligands forming ring structures
    **Chelation**: Process of forming chelates
    **Chelate Effect**: Chelates are more stable than complexes with monodentate ligands

    #### Common Ligands:

    **Neutral Ligands**:
    - H₂O → aqua
    - NH₃ → ammine
    - CO → carbonyl
    - NO → nitrosyl
    - py (pyridine) → pyridine

    **Anionic Ligands** (remove -ide, add -o):
    - Cl⁻ → chloro/chlorido
    - Br⁻ → bromo/bromido
    - CN⁻ → cyano/cyanido
    - OH⁻ → hydroxo/hydroxido
    - O²⁻ → oxo/oxido
    - S²⁻ → thio/thiido

    **Special Anionic Ligands**:
    - NO₂⁻ (N-bonded) → nitro
    - ONO⁻ (O-bonded) → nitrito
    - SCN⁻ (S-bonded) → thiocyanato
    - NCS⁻ (N-bonded) → isothiocyanato

    ### 3. Coordination Number (CN)
    - Number of ligand donor atoms bonded to central metal
    - Most common: CN = 4 and 6
    - Does NOT depend on denticity

    **Example**: [Co(en)₃]³⁺
    - 3 bidentate ligands
    - 6 donor atoms
    - CN = 6 (not 3!)

    ### 4. Coordination Sphere
    - Central metal + all ligands
    - Written in square brackets
    - Example: [Fe(CN)₆]⁴⁻

    ### 5. Oxidation State
    - Charge on central metal after removing all ligands
    - Calculation: Total charge = Oxidation state + Ligand charges

    **Example**: [Cr(H₂O)₆]Cl₃
    - Total charge outside brackets: 3 Cl⁻ = -3
    - Inside must be +3
    - H₂O is neutral
    - Oxidation state of Cr = +3

    ## Effective Atomic Number (EAN) Rule

    **Formula**: EAN = Z - oxidation state + 2 × (coordination number)

    - Z = Atomic number
    - EAN should equal nearest noble gas atomic number for stability

    **Example**: [Fe(CN)₆]⁴⁻
    - Z of Fe = 26
    - Oxidation state = +2
    - CN = 6
    - EAN = 26 - 2 + 2×6 = 36 (Kr)

    ## Common Coordination Numbers and Geometries

    | CN | Geometry | Example |
    |----|----------|---------|
    | 2 | Linear | [Ag(NH₃)₂]⁺ |
    | 4 | Tetrahedral | [Ni(CO)₄] |
    | 4 | Square planar | [Pt(NH₃)₂Cl₂] |
    | 6 | Octahedral | [Co(NH₃)₆]³⁺ |
    | 5 | Square pyramidal/Trigonal bipyramidal | [Fe(CO)₅] |

    ## IIT JEE Important Points

    1. Werner's theory explains primary and secondary valences
    2. Coordination number = Number of donor atoms (not number of ligands!)
    3. Ligands can be neutral or anionic
    4. Chelate complexes are more stable (chelate effect)
    5. EAN rule predicts stability
    6. Geometry depends on CN and electronic configuration

## Key Points

- Central atom

- Ligands

- Coordination number
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Central atom', 'Ligands', 'Coordination number', 'Coordination sphere', 'Werner theory'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Modern Periodic Law and Classification ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Modern Periodic Law and Classification',
  content: <<~MARKDOWN,
# Modern Periodic Law and Classification 🚀

# Modern Periodic Law and Classification

    ## Modern Periodic Law

    **Statement**: "The physical and chemical properties of elements are periodic functions of their atomic numbers."

    This was proposed by Henry Moseley (1913) and replaced Mendeleev's periodic law based on atomic mass.

    ## Structure of Modern Periodic Table

    ### Periods (Horizontal Rows)
    - **7 periods** numbered 1 to 7
    - Period number = Number of shells/energy levels
    - Example: Na (Period 3) has 3 shells: K, L, M

    ### Groups (Vertical Columns)
    - **18 groups** numbered 1 to 18 (IUPAC)
    - Group number indicates valence electrons (for main group elements)
    - Example: Group 1 = 1 valence electron (alkali metals)

    ## Block Classification

    Elements are classified into four blocks based on the subshell being filled:

    ### s-Block Elements
    - Groups 1 and 2
    - ns¹ and ns² configurations
    - Includes alkali metals and alkaline earth metals
    - Highly reactive metals

    ### p-Block Elements
    - Groups 13 to 18
    - ns²np¹⁻⁶ configurations
    - Includes metals, metalloids, and non-metals
    - Most diverse block

    ### d-Block Elements (Transition Elements)
    - Groups 3 to 12
    - (n-1)d¹⁻¹⁰ns¹⁻² configurations
    - All are metals
    - Show variable oxidation states

    ### f-Block Elements (Inner Transition Elements)
    - Lanthanoids: 4f series (58-71)
    - Actinoids: 5f series (90-103)
    - (n-2)f¹⁻¹⁴(n-1)d⁰⁻¹ns² configurations

    ## Metallic and Non-metallic Character

    ### Metallic Character
    - **Increases** down a group (easier to lose electrons)
    - **Decreases** across a period (harder to lose electrons)
    - Metals are on the left and bottom of the periodic table

    ### Non-metallic Character
    - **Decreases** down a group
    - **Increases** across a period
    - Non-metals are on the right and top of the periodic table

    ### Metalloids/Semi-metals
    - Elements with intermediate properties
    - Examples: B, Si, Ge, As, Sb, Te, Po, At
    - Form a diagonal line separating metals from non-metals

    ## Key Points for IIT JEE

    1. Modern periodic law is based on **atomic number**, not atomic mass
    2. Period number = Number of shells
    3. Group number (1-2, 13-18) = Valence electrons
    4. Transition elements (d-block) show variable oxidation states
    5. Metallic character increases down and left; non-metallic increases up and right

## Key Points

- Modern periodic law

- Periods and groups

- Block classification
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Modern periodic law', 'Periods and groups', 'Block classification', 'Metallic character'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Types of Chemical Bonds ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Types of Chemical Bonds',
  content: <<~MARKDOWN,
# Types of Chemical Bonds 🚀

# Types of Chemical Bonds

    ## Ionic Bonding

    **Definition**: Electrostatic attraction between oppositely charged ions.

    ### Formation
    - Transfer of electrons from metal (low IE) to non-metal (high EA)
    - Example: Na + Cl → Na⁺Cl⁻

    ### Properties of Ionic Compounds
    1. High melting and boiling points
    2. Conduct electricity in molten/aqueous state (not solid)
    3. Soluble in polar solvents (water)
    4. Hard but brittle
    5. Form crystalline solids

    ### Lattice Energy
    - Energy released when gaseous ions form a solid lattice
    - Higher lattice energy = Stronger ionic bond
    - Depends on charge and size of ions

    **Born-Haber Cycle**: Used to calculate lattice energy

    ## Covalent Bonding

    **Definition**: Sharing of electron pairs between atoms.

    ### Types
    1. **Single bond** (σ bond): 1 shared pair (e.g., H-H)
    2. **Double bond** (σ + π): 2 shared pairs (e.g., O=O)
    3. **Triple bond** (σ + 2π): 3 shared pairs (e.g., N≡N)

    ### Properties of Covalent Compounds
    1. Low melting and boiling points (except network solids)
    2. Poor conductors of electricity
    3. Soluble in non-polar solvents
    4. Exist as gases, liquids, or soft solids

    ### Bond Parameters

    #### 1. Bond Length
    - Distance between nuclei of bonded atoms
    - Order: Triple < Double < Single bond
    - Decreases with increasing bond order

    #### 2. Bond Energy
    - Energy required to break a bond
    - Order: Triple > Double > Single bond
    - Increases with bond order

    #### 3. Bond Angle
    - Angle between two bonds at an atom
    - Determined by hybridization and geometry

    ## Coordinate Bonding

    **Definition**: Covalent bond where both electrons come from one atom (donor).

    ### Representation
    - Shown as A → B (arrow from donor to acceptor)
    - Example: H₃N → BF₃ (ammonia-borane complex)

    ### Examples
    1. **NH₄⁺**: N donates lone pair to H⁺
    2. **H₃O⁺**: O donates lone pair to H⁺
    3. **Metal complexes**: Ligands donate to metal

    ## Fajans' Rules (Ionic/Covalent Character)

    Covalent character in ionic compounds increases when:
    1. Small cation (high polarizing power)
    2. Large anion (high polarizability)
    3. High charge on ions

    **Example**: AgCl has more covalent character than NaCl

    ## Practice Problems

    1. Why does LiCl have more covalent character than NaCl?
    2. Arrange in order of bond length: C-C, C=C, C≡C
    3. Which has higher lattice energy: NaF or NaCl?

## Key Points

- Ionic bonding

- Covalent bonding

- Coordinate bonds
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ionic bonding', 'Covalent bonding', 'Coordinate bonds', 'Bond parameters'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Introduction to Coordination Compounds ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Coordination Compounds',
  content: <<~MARKDOWN,
# Introduction to Coordination Compounds 🚀

# Coordination Compounds - Introduction

    ## What are Coordination Compounds?

    **Definition**: Complex compounds formed by a central metal atom/ion bonded to ions or molecules called ligands.

    **General Formula**: [MLₙ]^(charge)
    - M = Central metal atom/ion
    - L = Ligand
    - n = Coordination number

    ## Werner's Theory (1893) - Nobel Prize 1913

    ### Postulates

    1. **Primary Valence (Principal Valence)**
       - Ionizable bonds (shown by ionic bonding)
       - Equal to oxidation state of metal
       - Satisfied by negative ions
       - Example: In [Co(NH₃)₆]Cl₃, primary valence = +3

    2. **Secondary Valence (Auxiliary Valence)**
       - Non-ionizable bonds (coordinate bonds)
       - Equal to coordination number
       - Satisfied by ligands (neutral or negative)
       - Example: In [Co(NH₃)₆]Cl₃, secondary valence = 6

    3. **Directional Nature**
       - Secondary valences are directional
       - Give definite geometry to complexes
       - Example: Octahedral, tetrahedral, square planar

    ## Key Terms

    ### 1. Central Atom/Ion
    - Usually a transition metal
    - Has vacant orbitals to accept electron pairs
    - Examples: Fe²⁺, Cu²⁺, Co³⁺, Ni²⁺

    ### 2. Ligands
    - Ions or molecules with lone pairs
    - Act as Lewis bases (electron pair donors)
    - Form coordinate bonds with central metal

    #### Classification by Number of Donor Atoms:

    | Type | Donor Atoms | Examples |
    |------|-------------|----------|
    | Monodentate | 1 | NH₃, H₂O, Cl⁻, CN⁻ |
    | Bidentate | 2 | en (ethylenediamine), ox (oxalate) |
    | Tridentate | 3 | dien (diethylenetriamine) |
    | Tetradentate | 4 | Triethylenetetramine |
    | Pentadentate | 5 | DTPA |
    | Hexadentate | 6 | EDTA |

    **Chelate**: Complex with polydentate ligands forming ring structures
    **Chelation**: Process of forming chelates
    **Chelate Effect**: Chelates are more stable than complexes with monodentate ligands

    #### Common Ligands:

    **Neutral Ligands**:
    - H₂O → aqua
    - NH₃ → ammine
    - CO → carbonyl
    - NO → nitrosyl
    - py (pyridine) → pyridine

    **Anionic Ligands** (remove -ide, add -o):
    - Cl⁻ → chloro/chlorido
    - Br⁻ → bromo/bromido
    - CN⁻ → cyano/cyanido
    - OH⁻ → hydroxo/hydroxido
    - O²⁻ → oxo/oxido
    - S²⁻ → thio/thiido

    **Special Anionic Ligands**:
    - NO₂⁻ (N-bonded) → nitro
    - ONO⁻ (O-bonded) → nitrito
    - SCN⁻ (S-bonded) → thiocyanato
    - NCS⁻ (N-bonded) → isothiocyanato

    ### 3. Coordination Number (CN)
    - Number of ligand donor atoms bonded to central metal
    - Most common: CN = 4 and 6
    - Does NOT depend on denticity

    **Example**: [Co(en)₃]³⁺
    - 3 bidentate ligands
    - 6 donor atoms
    - CN = 6 (not 3!)

    ### 4. Coordination Sphere
    - Central metal + all ligands
    - Written in square brackets
    - Example: [Fe(CN)₆]⁴⁻

    ### 5. Oxidation State
    - Charge on central metal after removing all ligands
    - Calculation: Total charge = Oxidation state + Ligand charges

    **Example**: [Cr(H₂O)₆]Cl₃
    - Total charge outside brackets: 3 Cl⁻ = -3
    - Inside must be +3
    - H₂O is neutral
    - Oxidation state of Cr = +3

    ## Effective Atomic Number (EAN) Rule

    **Formula**: EAN = Z - oxidation state + 2 × (coordination number)

    - Z = Atomic number
    - EAN should equal nearest noble gas atomic number for stability

    **Example**: [Fe(CN)₆]⁴⁻
    - Z of Fe = 26
    - Oxidation state = +2
    - CN = 6
    - EAN = 26 - 2 + 2×6 = 36 (Kr)

    ## Common Coordination Numbers and Geometries

    | CN | Geometry | Example |
    |----|----------|---------|
    | 2 | Linear | [Ag(NH₃)₂]⁺ |
    | 4 | Tetrahedral | [Ni(CO)₄] |
    | 4 | Square planar | [Pt(NH₃)₂Cl₂] |
    | 6 | Octahedral | [Co(NH₃)₆]³⁺ |
    | 5 | Square pyramidal/Trigonal bipyramidal | [Fe(CO)₅] |

    ## IIT JEE Important Points

    1. Werner's theory explains primary and secondary valences
    2. Coordination number = Number of donor atoms (not number of ligands!)
    3. Ligands can be neutral or anionic
    4. Chelate complexes are more stable (chelate effect)
    5. EAN rule predicts stability
    6. Geometry depends on CN and electronic configuration

## Key Points

- Central atom

- Ligands

- Coordination number
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Central atom', 'Ligands', 'Coordination number', 'Coordination sphere', 'Werner theory'],
  prerequisite_ids: []
)

# === MICROLESSON 7: periodic_law — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'periodic_law — Practice',
  content: <<~MARKDOWN,
# periodic_law — Practice 🚀

Modern periodic law (Moseley, 1913) states that properties are periodic functions of atomic number, not atomic mass.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['periodic_law'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Modern periodic law is based on which property of elements?',
    options: ['Atomic mass', 'Atomic number', 'Atomic volume', 'Density'],
    correct_answer: 1,
    explanation: 'Modern periodic law (Moseley, 1913) states that properties are periodic functions of atomic number, not atomic mass.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: block_classification — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'block_classification — Practice',
  content: <<~MARKDOWN,
# block_classification — Practice 🚀

S-block elements are Groups 1 and 2 (alkali and alkaline earth metals). Na and Ca are s-block; Fe is d-block; Cl is p-block.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['block_classification'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are s-block elements?',
    options: ['Sodium (Na)', 'Iron (Fe)', 'Calcium (Ca)', 'Chlorine (Cl)'],
    correct_answer: 2,
    explanation: 'S-block elements are Groups 1 and 2 (alkali and alkaline earth metals). Na and Ca are s-block; Fe is d-block; Cl is p-block.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: valence_electrons — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'valence_electrons — Practice',
  content: <<~MARKDOWN,
# valence_electrons — Practice 🚀

Group number for p-block = 10 + valence electrons. Group 15 = 10 + 5 = 15 valence electrons. Alternatively, Group 15 elements (pnictogens) have 5 valence electrons (ns²np³).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['valence_electrons'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'An element is in Group 15 and Period 3. How many valence electrons does it have?',
    answer: '5',
    explanation: 'Group number for p-block = 10 + valence electrons. Group 15 = 10 + 5 = 15 valence electrons. Alternatively, Group 15 elements (pnictogens) have 5 valence electrons (ns²np³).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: periodic_trends — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'periodic_trends — Practice',
  content: <<~MARKDOWN,
# periodic_trends — Practice 🚀

Metallic character increases down a group. Li < Na < K < Rb. Larger atoms lose electrons more easily.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['periodic_trends'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following in order of INCREASING metallic character:',
    answer: '1,2,3,4',
    explanation: 'Metallic character increases down a group. Li < Na < K < Rb. Larger atoms lose electrons more easily.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: ionic_bonding — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'ionic_bonding — Practice',
  content: <<~MARKDOWN,
# ionic_bonding — Practice 🚀

Ionic compounds are polar and dissolve in polar solvents (like water) due to ion-dipole interactions. They do NOT conduct in solid state (ions are fixed), have HIGH melting points, and exist as solids.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['ionic_bonding'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which property is characteristic of ionic compounds?',
    options: ['Conduct electricity in solid state', 'Low melting points', 'Soluble in polar solvents', 'Exist as gases at room temperature'],
    correct_answer: 2,
    explanation: 'Ionic compounds are polar and dissolve in polar solvents (like water) due to ion-dipole interactions. They do NOT conduct in solid state (ions are fixed), have HIGH melting points, and exist as solids.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: bond_parameters — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'bond_parameters — Practice',
  content: <<~MARKDOWN,
# bond_parameters — Practice 🚀

Bond length decreases with increasing bond order. Triple bonds are shortest, single bonds are longest. C≡C (1.20 Å) < C=C (1.34 Å) < C-C (1.54 Å).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['bond_parameters'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following C-C bonds in order of INCREASING bond length:',
    answer: '1,2,3',
    explanation: 'Bond length decreases with increasing bond order. Triple bonds are shortest, single bonds are longest. C≡C (1.20 Å) < C=C (1.34 Å) < C-C (1.54 Å).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: coordinate_bonding — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'coordinate_bonding — Practice',
  content: <<~MARKDOWN,
# coordinate_bonding — Practice 🚀

Coordinate bonds form when one atom donates both electrons. NH₄⁺ has N→H⁺ coordinate bond. Metal complexes like [Cu(NH₃)₄]²⁺ have NH₃→Cu²⁺ coordinate bonds. H₂O and CH₄ have only normal covalent bonds.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['coordinate_bonding'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following contain coordinate bonds?',
    options: ['NH₄⁺ (ammonium ion)', 'H₂O (water)'],
    correct_answer: 0,
    explanation: 'Coordinate bonds form when one atom donates both electrons. NH₄⁺ has N→H⁺ coordinate bond. Metal complexes like [Cu(NH₃)₄]²⁺ have NH₃→Cu²⁺ coordinate bonds. H₂O and CH₄ have only normal covalent bonds.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 14: fajans_rules — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'fajans_rules — Practice',
  content: <<~MARKDOWN,
# fajans_rules — Practice 🚀

Smaller cations have higher charge density (polarizing power) and distort the electron cloud of anions more, increasing covalent character. Example: Li⁺ (small) gives more covalent compounds than Na⁺ (larger).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['fajans_rules'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'According to Fajans\',
    answer: 'decreasing|smaller|small',
    explanation: 'Smaller cations have higher charge density (polarizing power) and distort the electron cloud of anions more, increasing covalent character. Example: Li⁺ (small) gives more covalent compounds than Na⁺ (larger).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: coordination_number — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'coordination_number — Practice',
  content: <<~MARKDOWN,
# coordination_number — Practice 🚀

Coordination number = number of donor atoms attached to central metal. 6 NH₃ molecules each donate 1 electron pair, so CN = 6.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['coordination_number'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the coordination number in [Co(NH₃)₆]³⁺?',
    options: ['3', '4', '6', '9'],
    correct_answer: 2,
    explanation: 'Coordination number = number of donor atoms attached to central metal. 6 NH₃ molecules each donate 1 electron pair, so CN = 6.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 16: ligands — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'ligands — Practice',
  content: <<~MARKDOWN,
# ligands — Practice 🚀

Bidentate ligands have 2 donor atoms. Ethylenediamine (H₂N-CH₂-CH₂-NH₂) has 2 N atoms. Oxalate (⁻O₂C-CO₂⁻) has 2 O atoms. NH₃ and Cl⁻ are monodentate.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['ligands'],
  prerequisite_ids: []
)

# Exercise 16.2: MCQ
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are bidentate ligands?',
    options: ['Ethylenediamine (en)', 'Ammonia (NH₃)', 'Oxalate ion (C₂O₄²⁻)', 'Chloride ion (Cl⁻)'],
    correct_answer: 2,
    explanation: 'Bidentate ligands have 2 donor atoms. Ethylenediamine (H₂N-CH₂-CH₂-NH₂) has 2 N atoms. Oxalate (⁻O₂C-CO₂⁻) has 2 O atoms. NH₃ and Cl⁻ are monodentate.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 17: oxidation_states — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation_states — Practice',
  content: <<~MARKDOWN,
# oxidation_states — Practice 🚀

Let oxidation state of Cr = x. H₂O is neutral. Complex has +3 charge (to balance 3 Cl⁻). x + 6(0) = +3, so x = +3.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['oxidation_states'],
  prerequisite_ids: []
)

# Exercise 17.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the oxidation state of chromium in [Cr(H₂O)₆]Cl₃.',
    answer: '3',
    explanation: 'Let oxidation state of Cr = x. H₂O is neutral. Complex has +3 charge (to balance 3 Cl⁻). x + 6(0) = +3, so x = +3.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 18: ean_rule — Practice ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'ean_rule — Practice',
  content: <<~MARKDOWN,
# ean_rule — Practice 🚀

EAN = Z - oxidation state + 2×CN. Fe oxidation state in [Fe(CN)₆]⁴⁻ is +2. EAN = 26 - 2 + 2×6 = 36 (same as Kr, noble gas).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['ean_rule'],
  prerequisite_ids: []
)

# Exercise 18.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the Effective Atomic Number (EAN) of Fe in [Fe(CN)₆]⁴⁻. (Atomic number of Fe = 26)',
    answer: '36',
    explanation: 'EAN = Z - oxidation state + 2×CN. Fe oxidation state in [Fe(CN)₆]⁴⁻ is +2. EAN = 26 - 2 + 2×6 = 36 (same as Kr, noble gas).',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 19: nomenclature — Practice ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'nomenclature — Practice',
  content: <<~MARKDOWN,
# nomenclature — Practice 🚀

IUPAC nomenclature: (1) List ligands alphabetically, (2) add prefixes for multiple ligands, (3) name metal with oxidation state, (4) add -ate for anionic complexes.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['nomenclature'],
  prerequisite_ids: []
)

# Exercise 19.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following steps for naming a coordination compound in correct order:',
    answer: '1,2,3,4',
    explanation: 'IUPAC nomenclature: (1) List ligands alphabetically, (2) add prefixes for multiple ligands, (3) name metal with oxidation state, (4) add -ate for anionic complexes.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 20: werner_theory — Practice ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'werner_theory — Practice',
  content: <<~MARKDOWN,
# werner_theory — Practice 🚀

Primary valence = oxidation state = ionizable bonds. Complex has +3 charge (to balance 3 Cl⁻), so primary valence = 3.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['werner_theory'],
  prerequisite_ids: []
)

# Exercise 20.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In [Co(NH₃)₆]Cl₃, the primary valence of Co is ______.',
    answer: '3|+3|three',
    explanation: 'Primary valence = oxidation state = ionizable bonds. Complex has +3 charge (to balance 3 Cl⁻), so primary valence = 3.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 21: coordination_number — Practice ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'coordination_number — Practice',
  content: <<~MARKDOWN,
# coordination_number — Practice 🚀

en is bidentate (2 donor atoms per ligand). 2 en ligands = 2×2 = 4 donor atoms. CN = 4, not 2!

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['coordination_number'],
  prerequisite_ids: []
)

# Exercise 21.2: MCQ
Exercise.create!(
  micro_lesson: lesson_21,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the coordination number in [Pt(en)₂]²⁺? (en = ethylenediamine)',
    options: ['2', '4', '6', '8'],
    correct_answer: 1,
    explanation: 'en is bidentate (2 donor atoms per ligand). 2 en ligands = 2×2 = 4 donor atoms. CN = 4, not 2!',
    difficulty: 'medium'
  }
)

# === MICROLESSON 22: ligands — Practice ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'ligands — Practice',
  content: <<~MARKDOWN,
# ligands — Practice 🚀

EDTA (ethylenediaminetetraacetic acid) is hexadentate with 2 N and 4 O donor atoms. Forms highly stable 6-membered chelate rings due to chelate effect.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['ligands'],
  prerequisite_ids: []
)

# Exercise 22.2: MCQ
Exercise.create!(
  micro_lesson: lesson_22,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are true about EDTA?',
    options: ['It is a hexadentate ligand', 'It forms very stable chelate complexes', 'It is a monodentate ligand', 'It has 6 donor atoms'],
    correct_answer: 3,
    explanation: 'EDTA (ethylenediaminetetraacetic acid) is hexadentate with 2 N and 4 O donor atoms. Forms highly stable 6-membered chelate rings due to chelate effect.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 23: coordination_number — Practice ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'coordination_number — Practice',
  content: <<~MARKDOWN,
# coordination_number — Practice 🚀

FALSE. Coordination number = number of DONOR ATOMS, not number of ligands. Example: [Co(en)₃]³⁺ has 3 ligands but CN = 6 (each en donates 2 atoms).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['coordination_number'],
  prerequisite_ids: []
)

# Exercise 23.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_23,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The coordination number depends on the number of ligands, not the number of donor atoms.',
    answer: 'false',
    explanation: 'FALSE. Coordination number = number of DONOR ATOMS, not number of ligands. Example: [Co(en)₃]³⁺ has 3 ligands but CN = 6 (each en donates 2 atoms).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 24: Modern Periodic Law and Classification ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'Modern Periodic Law and Classification',
  content: <<~MARKDOWN,
# Modern Periodic Law and Classification 🚀

# Modern Periodic Law and Classification

    ## Modern Periodic Law

    **Statement**: "The physical and chemical properties of elements are periodic functions of their atomic numbers."

    This was proposed by Henry Moseley (1913) and replaced Mendeleev's periodic law based on atomic mass.

    ## Structure of Modern Periodic Table

    ### Periods (Horizontal Rows)
    - **7 periods** numbered 1 to 7
    - Period number = Number of shells/energy levels
    - Example: Na (Period 3) has 3 shells: K, L, M

    ### Groups (Vertical Columns)
    - **18 groups** numbered 1 to 18 (IUPAC)
    - Group number indicates valence electrons (for main group elements)
    - Example: Group 1 = 1 valence electron (alkali metals)

    ## Block Classification

    Elements are classified into four blocks based on the subshell being filled:

    ### s-Block Elements
    - Groups 1 and 2
    - ns¹ and ns² configurations
    - Includes alkali metals and alkaline earth metals
    - Highly reactive metals

    ### p-Block Elements
    - Groups 13 to 18
    - ns²np¹⁻⁶ configurations
    - Includes metals, metalloids, and non-metals
    - Most diverse block

    ### d-Block Elements (Transition Elements)
    - Groups 3 to 12
    - (n-1)d¹⁻¹⁰ns¹⁻² configurations
    - All are metals
    - Show variable oxidation states

    ### f-Block Elements (Inner Transition Elements)
    - Lanthanoids: 4f series (58-71)
    - Actinoids: 5f series (90-103)
    - (n-2)f¹⁻¹⁴(n-1)d⁰⁻¹ns² configurations

    ## Metallic and Non-metallic Character

    ### Metallic Character
    - **Increases** down a group (easier to lose electrons)
    - **Decreases** across a period (harder to lose electrons)
    - Metals are on the left and bottom of the periodic table

    ### Non-metallic Character
    - **Decreases** down a group
    - **Increases** across a period
    - Non-metals are on the right and top of the periodic table

    ### Metalloids/Semi-metals
    - Elements with intermediate properties
    - Examples: B, Si, Ge, As, Sb, Te, Po, At
    - Form a diagonal line separating metals from non-metals

    ## Key Points for IIT JEE

    1. Modern periodic law is based on **atomic number**, not atomic mass
    2. Period number = Number of shells
    3. Group number (1-2, 13-18) = Valence electrons
    4. Transition elements (d-block) show variable oxidation states
    5. Metallic character increases down and left; non-metallic increases up and right

## Key Points

- Modern periodic law

- Periods and groups

- Block classification
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Modern periodic law', 'Periods and groups', 'Block classification', 'Metallic character'],
  prerequisite_ids: []
)

puts "✓ Created 24 microlessons for Periodic Table Periodicity"

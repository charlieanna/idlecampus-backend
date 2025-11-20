# Module 1: General Organic Chemistry (GOC)
# Foundation module for all organic chemistry concepts
# Covers bonding, electronic effects, resonance, and reaction mechanisms

puts "Creating Module 1: General Organic Chemistry (GOC)..."

# Get or create Organic Chemistry course
course_organic = Course.find_by(title: 'Organic Chemistry for IIT JEE Main & Advanced')

unless course_organic
  course_organic = Course.create!(
    title: 'Organic Chemistry for IIT JEE Main & Advanced',
    slug: 'iit-jee-organic-chemistry',
    description: 'Comprehensive Organic Chemistry course covering all IIT JEE topics with mechanism-focused problem solving',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    published: true,
    certification_track: 'none',
    learning_objectives: [
      'Master General Organic Chemistry principles',
      'Understand reaction mechanisms and arrow pushing',
      'Apply IUPAC nomenclature systematically',
      'Solve stereochemistry and isomerism problems',
      'Master all functional group reactions',
      'Execute multi-step organic synthesis'
    ],
    prerequisites: [
      'Basic chemical bonding concepts',
      'Understanding of atomic structure',
      'Familiarity with periodic trends'
    ]
  )
  puts "✅ Created Organic Chemistry course"
else
  puts "✅ Found existing Organic Chemistry course"
end

# Create Module 1
module_01 = CourseModule.create!(
  course: course_organic,
  title: 'Module 1: General Organic Chemistry (GOC)',
  description: 'Foundation concepts: bonding, hybridization, electronic effects, resonance, and reaction mechanisms',
  sequence_order: 1,
  estimated_minutes: 200,
  published: true
)

puts "✅ Module 1 created"

# ============================================================================
# LESSON 1.1: Bonding in Organic Compounds
# ============================================================================

lesson_1_1 = CourseLesson.create!(
  title: 'Bonding in Organic Compounds - Hybridization and Bond Types',
  reading_time_minutes: 50,
  key_concepts: [
    'Hybridization (sp, sp², sp³)',
    'Sigma and pi bonds',
    'Bond lengths and bond angles',
    'Bond energy and strength',
    'Covalent character and polarity'
  ],
  content: <<~MD
    # Bonding in Organic Compounds

    ## 1. Atomic Orbitals and Hybridization

    ### What is Hybridization?
    **Hybridization** is the mixing of atomic orbitals to form new **hybrid orbitals** suitable for bonding.

    ### Types of Hybridization

    #### sp³ Hybridization (Tetrahedral)
    - **Formation:** 1s + 3p orbitals → 4 sp³ hybrid orbitals
    - **Geometry:** Tetrahedral
    - **Bond angle:** 109.5°
    - **Examples:** CH₄ (methane), C₂H₆ (ethane), diamond
    - **Carbon valency:** 4 single bonds

    ```
    CH₄ (Methane):
         H
         |
    H — C — H    Bond angle: 109.5°
         |
         H
    ```

    #### sp² Hybridization (Trigonal Planar)
    - **Formation:** 1s + 2p orbitals → 3 sp² hybrid orbitals + 1 unhybridized p orbital
    - **Geometry:** Trigonal planar
    - **Bond angle:** 120°
    - **Examples:** C₂H₄ (ethene), benzene, graphite
    - **Carbon valency:** 3 sigma bonds + 1 pi bond (double bond)

    ```
    C₂H₄ (Ethene):
         H     H
          \   /
           C=C      Bond angle: 120°
          /   \
         H     H

    Double bond = 1 σ (sigma) + 1 π (pi)
    ```

    #### sp Hybridization (Linear)
    - **Formation:** 1s + 1p orbital → 2 sp hybrid orbitals + 2 unhybridized p orbitals
    - **Geometry:** Linear
    - **Bond angle:** 180°
    - **Examples:** C₂H₂ (ethyne/acetylene), CO₂, HCN
    - **Carbon valency:** 2 sigma bonds + 2 pi bonds (triple bond)

    ```
    C₂H₂ (Ethyne):
    H — C ≡ C — H    Bond angle: 180°

    Triple bond = 1 σ (sigma) + 2 π (pi)
    ```

    ### Summary Table

    | Hybridization | Orbitals Mixed | Hybrid Orbitals | Unhybridized p | Geometry | Bond Angle | Example |
    |---------------|----------------|-----------------|----------------|----------|------------|---------|
    | **sp³** | 1s + 3p | 4 sp³ | 0 | Tetrahedral | 109.5° | CH₄ |
    | **sp²** | 1s + 2p | 3 sp² | 1 | Trigonal planar | 120° | C₂H₄ |
    | **sp** | 1s + 1p | 2 sp | 2 | Linear | 180° | C₂H₂ |

    ---

    ## 2. Sigma (σ) and Pi (π) Bonds

    ### Sigma (σ) Bond
    - **Formation:** Head-on overlap of orbitals
    - **Electron density:** Along the internuclear axis
    - **Rotation:** Free rotation possible
    - **Strength:** Stronger than pi bond
    - **Examples:** All single bonds (C-C, C-H, C-O, etc.)

    ### Pi (π) Bond
    - **Formation:** Lateral (sideways) overlap of p orbitals
    - **Electron density:** Above and below the internuclear axis
    - **Rotation:** Restricted (no free rotation)
    - **Strength:** Weaker than sigma bond
    - **Examples:** Present in double and triple bonds

    ### Key Differences

    | Property | Sigma (σ) Bond | Pi (π) Bond |
    |----------|----------------|-------------|
    | **Overlap** | Head-on | Lateral |
    | **Strength** | Stronger | Weaker |
    | **Rotation** | Free | Restricted |
    | **Electron cloud** | Cylindrical | Dumbbell-shaped |
    | **First/Second bond** | Always first | Always second/third |

    ### Bond Composition
    - **Single bond (C-C):** 1σ
    - **Double bond (C=C):** 1σ + 1π
    - **Triple bond (C≡C):** 1σ + 2π

    ---

    ## 3. Bond Length and Bond Energy

    ### Bond Length
    **Bond length** is the average distance between the nuclei of two bonded atoms.

    **Order of bond length:**
    ```
    C ≡ C  <  C = C  <  C — C
    (shortest)          (longest)

    120 pm < 134 pm < 154 pm
    ```

    **Reason:** More bonds → more attraction → shorter distance

    ### Bond Energy (Bond Strength)
    **Bond energy** is the energy required to break one mole of bonds in the gaseous state.

    **Order of bond strength:**
    ```
    C ≡ C  >  C = C  >  C — C
    (strongest)       (weakest)

    839 kJ/mol > 606 kJ/mol > 347 kJ/mol
    ```

    **Important relationship:**
    - **Bond length ∝ 1 / Bond strength**
    - Shorter bond = Stronger bond
    - Longer bond = Weaker bond

    ---

    ## 4. Percentage s-Character and Properties

    ### s-Character in Hybrid Orbitals
    - **sp³:** 25% s-character (1s out of 4 orbitals)
    - **sp²:** 33% s-character (1s out of 3 orbitals)
    - **sp:** 50% s-character (1s out of 2 orbitals)

    ### Effects of Increasing s-Character

    #### Bond Length Decreases
    - More s-character → Electrons closer to nucleus → Shorter bond
    - **Order:** sp < sp² < sp³ (bond length)

    #### Bond Angle Increases
    - More s-character → More directional → Larger bond angle
    - **Order:** 180° (sp) > 120° (sp²) > 109.5° (sp³)

    #### Electronegativity Increases
    - More s-character → Electrons held more tightly
    - **Order:** sp > sp² > sp³ (electronegativity)

    #### Acidity Increases
    - More s-character → Anion more stable → More acidic
    - **Acidity order:** HC≡CH > H₂C=CH₂ > H₃C-CH₃
    - **pKa values:** 25 > 44 > 50

    ---

    ## 5. Covalent Character and Polarity

    ### Electronegativity and Bond Polarity
    - **Electronegativity difference (ΔEN)** determines bond character
    - Larger ΔEN → More polar bond

    ### Bond Types
    | ΔEN | Bond Type | Example |
    |-----|-----------|---------|
    | 0 - 0.4 | Nonpolar covalent | C-C, C-H |
    | 0.4 - 1.7 | Polar covalent | C-O, C-N, C-Cl |
    | > 1.7 | Ionic | Na-Cl, K-F |

    ### Dipole Moment (μ)
    - **Definition:** Measure of bond polarity
    - **Formula:** μ = q × d (charge × distance)
    - **Unit:** Debye (D)
    - **Direction:** From positive to negative (δ⁺ → δ⁻)

    ---

    ## Important Points for IIT JEE

    1. **Hybridization from structure:**
       - Linear → sp
       - Trigonal planar → sp²
       - Tetrahedral → sp³

    2. **Counting bonds:**
       - Count σ and π separately
       - Every bond has at least one σ bond

    3. **Bond strength vs reactivity:**
       - π bonds are more reactive than σ bonds
       - Double/triple bonds are sites of chemical reactions

    4. **s-Character correlations:**
       - ↑ s-character → ↑ electronegativity → ↑ acidity
       - ↑ s-character → ↓ bond length

    5. **Molecular geometry vs electron geometry:**
       - Lone pairs affect geometry
       - Use VSEPR to predict shapes

    ---

    ## Practice Questions (To be added to quiz)
    1. Determine hybridization of each carbon in CH₂=CH-CN
    2. Compare bond lengths: C-C (ethane), C=C (ethene), C≡C (ethyne)
    3. Which is more acidic: ethane or ethyne? Why?
    4. How many σ and π bonds in benzene (C₆H₆)?
    5. Order by increasing bond angle: NH₃, H₂O, CH₄
  MD
)

ModuleItem.create!(
  course_module: module_01,
  item: lesson_1_1,
  sequence_order: 1,
  required: true
)

puts "✅ Lesson 1.1 created"

# Create Quiz 1.1
quiz_1_1 = Quiz.create!(
  title: 'Quiz 1.1: Bonding and Hybridization',
  description: 'Test your understanding of hybridization, bond types, and molecular geometry',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_01,
  item: quiz_1_1,
  sequence_order: 2,
  required: true
)

# Quiz 1.1 Questions
QuizQuestion.create!([
  {
    quiz: quiz_1_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the hybridization of the carbon atom in CH₄ (methane)?',
    options: [
      { text: 'sp', correct: false },
      { text: 'sp²', correct: false },
      { text: 'sp³', correct: true },
      { text: 'sp³d', correct: false }
    ],
    explanation: 'Methane (CH₄) has tetrahedral geometry with 4 single bonds, indicating sp³ hybridization. Bond angle = 109.5°.',
    points: 2,
    difficulty: -0.5,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_1_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following statements about π bonds are correct?',
    options: [
      { text: 'π bonds are formed by lateral overlap of p orbitals', correct: true },
      { text: 'π bonds allow free rotation around the bond axis', correct: false },
      { text: 'π bonds are weaker than σ bonds', correct: true },
      { text: 'π bonds have electron density along the internuclear axis', correct: false }
    ],
    explanation: 'π bonds: (1) Lateral overlap of p orbitals ✓ (2) Restricted rotation ✓ (3) Weaker than σ ✓ (4) Electron density above/below axis, not along it.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_1_1,
    question_type: 'sequence',
    question_text: 'Arrange the following in order of INCREASING bond length: (1) C-C (ethane) (2) C=C (ethene) (3) C≡C (ethyne)',
    sequence_items: [
      { id: 1, text: 'C≡C (ethyne)' },
      { id: 2, text: 'C=C (ethene)' },
      { id: 3, text: 'C-C (ethane)' }
    ],
    explanation: 'Bond length order: C≡C (120 pm) < C=C (134 pm) < C-C (154 pm). More bonds → shorter distance.',
    points: 3,
    difficulty: 0.1,
    discrimination: 1.2,
    guessing: 0.17,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_1_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In the compound CH₂=CH-CN, what is the hybridization of the carbon in the nitrile group (-CN)?',
    options: [
      { text: 'sp', correct: true },
      { text: 'sp²', correct: false },
      { text: 'sp³', correct: false },
      { text: 'sp²d', correct: false }
    ],
    explanation: 'The carbon in -CN forms a triple bond (C≡N), which requires sp hybridization (linear geometry, 180° bond angle).',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_1_1,
    question_type: 'numerical',
    question_text: 'How many sigma (σ) bonds are present in benzene (C₆H₆)?',
    correct_answer: '12',
    tolerance: 0,
    explanation: 'Benzene has 6 C-C bonds + 6 C-H bonds = 12 σ bonds. (The 3 double bonds contribute 3 more π bonds, total 12σ + 3π = 15 bonds).',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_1_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which hybrid orbital has the HIGHEST percentage of s-character?',
    options: [
      { text: 'sp³', correct: false },
      { text: 'sp²', correct: false },
      { text: 'sp', correct: true },
      { text: 'All have equal s-character', correct: false }
    ],
    explanation: 'sp has 50% s-character (1s in 2 orbitals). sp² has 33% (1s in 3 orbitals). sp³ has 25% (1s in 4 orbitals).',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_1_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following is the MOST acidic?',
    options: [
      { text: 'Ethane (C₂H₆)', correct: false },
      { text: 'Ethene (C₂H₄)', correct: false },
      { text: 'Ethyne (C₂H₂)', correct: true },
      { text: 'All are equally acidic', correct: false }
    ],
    explanation: 'Ethyne (sp carbon) is most acidic (pKa ≈ 25). More s-character → conjugate base (C₂H⁻) more stable → more acidic. Ethene: pKa ≈ 44, Ethane: pKa ≈ 50.',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.5,
    guessing: 0.25,
    difficulty_level: 'hard'
  },
  {
    quiz: quiz_1_1,
    question_type: 'fill_blank',
    question_text: 'A double bond consists of ___ sigma bond(s) and ___ pi bond(s). (Format: X,Y)',
    correct_answer: '1,1',
    explanation: 'A double bond = 1 σ + 1 π. The σ bond is formed first (stronger, head-on overlap), then π bond (weaker, lateral overlap).',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy'
  }
])

puts "✅ Quiz 1.1 created with 8 questions"

puts "\n" + "="*80
puts "Module 1: Lesson 1.1 and Quiz 1.1 Complete!"
puts "="*80
puts "Progress: 1/4 lessons complete (25%)"
puts "Next: Lesson 1.2 - Electronic Effects Part 1"
puts "="*80

# ============================================================================
# LESSON 1.2: Electronic Effects - Resonance and Inductive Effects
# ============================================================================

lesson_1_2 = CourseLesson.create!(
  title: 'Electronic Effects - Resonance, Inductive, and Hyperconjugation',
  reading_time_minutes: 55,
  key_concepts: [
    'Resonance structures and stability',
    'Inductive effect (+I, -I)',
    'Mesomeric effect (+M, -M)',
    'Hyperconjugation',
    'Applications to acidity and basicity'
  ],
  content: <<~MD
    # Electronic Effects in Organic Chemistry

    Electronic effects determine the distribution of electron density in molecules and influence reactivity, acidity, basicity, and stability.

    ## 1. Inductive Effect (I Effect)

    ### Definition
    **Inductive effect** is the permanent polarization of a σ bond due to electronegativity difference, transmitted through the chain of σ bonds.

    ### Characteristics
    - **Transmission:** Through σ bonds
    - **Nature:** Permanent effect
    - **Magnitude:** Decreases rapidly with distance (negligible after 3-4 bonds)
    - **Direction:** Towards more electronegative atom

    ### Types

    #### -I Effect (Electron-withdrawing)
    Groups that pull electrons towards themselves:
    
    **Order (strongest to weakest):**
    ```
    -NO₂ > -CN > -COOH > -F > -Cl > -Br > -I > -OH > -OR > -NH₂ > -C₆H₅ > -H
    ```

    **Examples:**
    - -NO₂, -CN, -COOH (very strong)
    - Halogens: -F > -Cl > -Br > -I
    - -OH, -NH₂ (weak -I)

    #### +I Effect (Electron-donating)
    Groups that push electrons away from themselves:
    
    **Order (strongest to weakest):**
    ```
    -C(CH₃)₃ > -CH(CH₃)₂ > -CH₂CH₃ > -CH₃ > -H
    (tert-butyl > isopropyl > ethyl > methyl)
    ```

    **Alkyl groups show +I effect** (electron-donating relative to H)

    ---

    ## 2. Resonance (Mesomeric Effect)

    ### Definition
    **Resonance** is the delocalization of π electrons or lone pairs across multiple atoms, represented by multiple Lewis structures.

    ### Rules for Drawing Resonance Structures
    1. **Only electrons move** (not atoms)
    2. **Same number of electrons** in all structures
    3. **Same number of unpaired electrons**
    4. **Octets must be obeyed** (for 2nd period elements)
    5. **Negative charge on more electronegative atom** is more stable
    6. **Positive charge on less electronegative atom** is more stable

    ### Resonance Energy
    - **Definition:** Stabilization energy due to delocalization
    - **Greater delocalization → Greater stability**

    ### Important Resonance Systems

    #### Benzene (C₆H₆)
    ```
    Two equivalent structures (Kekulé structures):
    
         ┌─┐         ┌═┐
        /   \       //   \\
       │     │  ⟷  │     │
        \   /       \\   //
         └─┘         └═┘
    
    Reality: All C-C bonds are equal (139 pm)
    Resonance energy: 150 kJ/mol
    ```

    #### Carboxylate Ion (RCOO⁻)
    ```
          O⁻              O
          ║               ║
    R — C       ⟷   R — C
          \               \
           O               O⁻
    
    Both C-O bonds are equivalent (127 pm)
    ```

    #### Nitro Group (-NO₂)
    ```
          O⁻              O
          ║               ║
    R — N       ⟷   R — N
          \               \
           O               O⁻
    ```

    ### Mesomeric Effect (M Effect)

    #### +M Effect (Electron-donating)
    Groups that donate electrons through resonance:
    
    **Order:**
    ```
    -O⁻ > -NH₂ > -NHR > -NHCOCH₃ > -OR > -OH > -C₆H₅
    ```

    **Mechanism:** Lone pair donation into π system

    **Example:** Aniline (C₆H₅-NH₂)
    ```
         NH₂                NH₂⁺              NH₂⁺
          |                  |                  |
    ⟷    ⟷            ⟷    ⟷
    
    Lone pair on N delocalizes into benzene ring
    ```

    #### -M Effect (Electron-withdrawing)
    Groups that pull electrons through resonance:
    
    **Order:**
    ```
    -NO₂ > -CN > -CHO > -COR > -COOH > -COOR > -CONH₂
    ```

    **Mechanism:** π bond or empty orbital pulls electrons

    ---

    ## 3. Hyperconjugation (σ-π Conjugation)

    ### Definition
    **Hyperconjugation** is the delocalization of σ electrons (C-H or C-C bonds) into adjacent π system or empty p orbital.

    ### Key Points
    - **Also called:** "No-bond resonance" or "Baker-Nathan effect"
    - **Requires:** α-hydrogen atoms (hydrogens on carbon adjacent to π bond or carbocation)
    - **Effect:** Stabilizes carbocations, free radicals, and alkenes

    ### Number of Hyperconjugative Structures
    **Formula:** Number of α-hydrogens

    **Example: Propene (CH₃-CH=CH₂)**
    - CH₃ group has 3 α-hydrogens
    - Number of hyperconjugative structures = 3

    ### Stability Order (Due to Hyperconjugation)

    #### Carbocations
    ```
    (CH₃)₃C⁺ > (CH₃)₂CH⁺ > CH₃CH₂⁺ > CH₃⁺ > H₃C⁺
    (3°)      (2°)         (1°)       (methyl)
    
    3° = 9 α-H, 2° = 6 α-H, 1° = 3 α-H, methyl = 0 α-H
    ```

    #### Alkenes
    ```
    (CH₃)₂C=C(CH₃)₂ > CH₃CH=C(CH₃)₂ > (CH₃)₂C=CH₂ > CH₃CH=CH₂ > CH₂=CH₂
    (tetra-substituted) (tri-sub)     (di-sub)     (mono-sub)   (unsubstituted)
    ```

    **More alkyl substituents → More hyperconjugation → More stable alkene**

    ---

    ## 4. Comparison of Electronic Effects

    | Property | Inductive (-I/+I) | Resonance (-M/+M) | Hyperconjugation |
    |----------|-------------------|-------------------|------------------|
    | **Transmission** | Through σ bonds | Through π system | σ to π/p orbital |
    | **Nature** | Permanent | Permanent | Permanent |
    | **Distance** | Short range (3-4 bonds) | Long range | Adjacent atoms only |
    | **Strength** | Weaker | Stronger | Weakest |
    | **Electrons** | σ electrons | π/lone pairs | σ C-H electrons |

    ---

    ## 5. Applications to Acidity and Basicity

    ### Acidity of Carboxylic Acids

    **More stable anion (RCOO⁻) → Stronger acid**

    #### Effect of Substituents on Acidity

    **-I groups increase acidity** (stabilize anion):
    ```
    Cl₃C-COOH > Cl₂CH-COOH > ClCH₂-COOH > CH₃-COOH
    (pKa: 0.7)   (1.3)         (2.9)         (4.8)
    
    More -I effect → More acidic
    ```

    **+I groups decrease acidity** (destabilize anion):
    ```
    CH₃-COOH > CH₃CH₂-COOH > (CH₃)₂CH-COOH > (CH₃)₃C-COOH
    (4.8)      (4.9)           (4.9)            (5.1)
    
    More +I effect → Less acidic
    ```

    ### Acidity of Phenols

    **Electron-withdrawing groups increase acidity:**

    **-M and -I groups at ortho/para positions:**
    ```
    p-NO₂-C₆H₄OH > o-NO₂-C₆H₄OH > C₆H₅OH > p-CH₃-C₆H₄OH
    (pKa: 7.1)     (7.2)           (10.0)   (10.3)
    
    -NO₂ (strong -M, -I) increases acidity
    -CH₃ (weak +I) decreases acidity
    ```

    ### Basicity of Amines

    **More stable cation (RNH₃⁺) → Stronger base**

    **Aliphatic amines:**
    ```
    (C₂H₅)₂NH > C₂H₅NH₂ > (C₂H₅)₃N > NH₃ > C₆H₅NH₂
    (2°)        (1°)        (3°)
    
    Basicity: Inductive effect vs steric hindrance balance
    ```

    **Aromatic amines are weaker bases:**
    - Aniline (C₆H₅NH₂): Lone pair delocalized into benzene ring (+M effect)
    - Less available for protonation → Weaker base
    - pKb (aniline) = 9.4 vs pKb (CH₃NH₂) = 3.4

    ---

    ## Important IIT JEE Concepts

    ### 1. Identify Dominant Effect
    When both -I and +M (or +I and -M) are present:
    - **-OH, -OR, -NH₂:** +M dominates over -I (net electron-donating)
    - **-COOH, -CHO, -NO₂:** -M dominates (net electron-withdrawing)
    - **Halogens (-F, -Cl, -Br, -I):** -I dominates over +M (net electron-withdrawing)

    ### 2. Stability Comparisons
    **Always consider:**
    - Resonance first (strongest effect)
    - Inductive effect second
    - Hyperconjugation for similar structures

    ### 3. Position Matters
    - **Ortho/para position:** Both resonance and inductive effects operate
    - **Meta position:** Only inductive effect operates
    - **Proximity matters:** Effects decrease with distance

    ### 4. Conjugation Increases Stability
    - Extended conjugation (alternating single-double bonds) provides extra stability
    - Example: 1,3-butadiene is more stable than isolated double bonds

    ---

    ## Practice Problems (For Quiz)
    1. Order by acidity: CH₃COOH, ClCH₂COOH, Cl₂CHCOOH, Cl₃CCOOH
    2. Which is more basic: aniline or cyclohexylamine?
    3. Draw resonance structures for benzyl carbocation (C₆H₅-CH₂⁺)
    4. Count hyperconjugative structures in: (CH₃)₂CH⁺
    5. Why is phenol more acidic than cyclohexanol?
  MD
)

ModuleItem.create!(
  course_module: module_01,
  item: lesson_1_2,
  sequence_order: 3,
  required: true
)

puts "✅ Lesson 1.2 created"

# Create Quiz 1.2
quiz_1_2 = Quiz.create!(
  title: 'Quiz 1.2: Electronic Effects',
  description: 'Test your understanding of inductive effect, resonance, and hyperconjugation',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_01,
  item: quiz_1_2,
  sequence_order: 4,
  required: true
)

# Quiz 1.2 Questions
QuizQuestion.create!([
  {
    quiz: quiz_1_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following groups shows the STRONGEST -I (electron-withdrawing inductive) effect?',
    options: [
      { text: '-CH₃', correct: false },
      { text: '-OH', correct: false },
      { text: '-NO₂', correct: true },
      { text: '-C₆H₅', correct: false }
    ],
    explanation: '-NO₂ (nitro group) has the strongest -I effect. Order: -NO₂ > -CN > -COOH > -F > -Cl > -Br > -I > -OH > -OR > -NH₂.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_1_2,
    question_type: 'sequence',
    question_text: 'Arrange the following carboxylic acids in order of INCREASING acidity: (1) CH₃COOH (2) ClCH₂COOH (3) Cl₂CHCOOH (4) Cl₃CCOOH',
    sequence_items: [
      { id: 1, text: 'CH₃COOH' },
      { id: 2, text: 'ClCH₂COOH' },
      { id: 3, text: 'Cl₂CHCOOH' },
      { id: 4, text: 'Cl₃CCOOH' }
    ],
    explanation: 'More Cl atoms → stronger -I effect → more stable anion → more acidic. pKa values: Cl₃C (0.7) < Cl₂CH (1.3) < ClCH₂ (2.9) < CH₃ (4.8).',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.4,
    guessing: 0.04,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_1_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following statements about resonance are correct?',
    options: [
      { text: 'Resonance structures differ in the position of electrons only', correct: true },
      { text: 'The actual molecule is a hybrid of all resonance structures', correct: true },
      { text: 'Atoms can change position in different resonance structures', correct: false },
      { text: 'Resonance always increases molecular stability', correct: true }
    ],
    explanation: 'Resonance rules: (1) Only electrons move, not atoms ✓ (2) Hybrid structure represents reality ✓ (3) Atoms fixed ✓ (4) Delocalization always stabilizes ✓.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_1_2,
    question_type: 'numerical',
    question_text: 'How many hyperconjugative structures can be drawn for the tert-butyl carbocation, (CH₃)₃C⁺?',
    correct_answer: '9',
    tolerance: 0,
    explanation: 'Tert-butyl carbocation has 3 CH₃ groups. Each CH₃ has 3 α-hydrogens. Total = 3 × 3 = 9 hyperconjugative structures.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_1_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following carbocations is the MOST stable?',
    options: [
      { text: 'CH₃⁺ (methyl)', correct: false },
      { text: 'CH₃CH₂⁺ (primary)', correct: false },
      { text: '(CH₃)₂CH⁺ (secondary)', correct: false },
      { text: '(CH₃)₃C⁺ (tertiary)', correct: true }
    ],
    explanation: 'Stability order: 3° > 2° > 1° > methyl. Tertiary carbocation is most stable due to +I effect of three CH₃ groups and maximum hyperconjugation (9 α-H).',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_1_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why is phenol (C₆H₅OH) more acidic than cyclohexanol (C₆H₁₁OH)?',
    options: [
      { text: 'Phenol has a stronger O-H bond', correct: false },
      { text: 'The phenoxide ion is stabilized by resonance', correct: true },
      { text: 'Cyclohexanol is more polar', correct: false },
      { text: 'Phenol has a higher molecular weight', correct: false }
    ],
    explanation: 'Phenoxide ion (C₆H₅O⁻) is stabilized by resonance with the benzene ring (delocalization of negative charge). Cyclohexanol anion has no such stabilization. pKa (phenol) ≈ 10, pKa (cyclohexanol) ≈ 16.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.5,
    guessing: 0.25,
    difficulty_level: 'hard'
  },
  {
    quiz: quiz_1_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which group shows both -I and +M effects, but +M effect DOMINATES?',
    options: [
      { text: '-NO₂', correct: false },
      { text: '-COOH', correct: false },
      { text: '-OH', correct: true },
      { text: '-CN', correct: false }
    ],
    explanation: '-OH shows -I (O is electronegative) and +M (lone pair donation). +M dominates, making -OH a net electron-donating group. -NO₂, -COOH, -CN show dominant -M effect.',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.5,
    guessing: 0.25,
    difficulty_level: 'hard'
  },
  {
    quiz: quiz_1_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following alkenes is the MOST stable?',
    options: [
      { text: 'CH₂=CH₂ (ethene)', correct: false },
      { text: 'CH₃CH=CH₂ (propene)', correct: false },
      { text: '(CH₃)₂C=CH₂ (2-methylpropene)', correct: false },
      { text: '(CH₃)₂C=C(CH₃)₂ (2,3-dimethyl-2-butene)', correct: true }
    ],
    explanation: 'Alkene stability: Tetra-substituted > Tri > Di > Mono > Unsubstituted. (CH₃)₂C=C(CH₃)₂ is tetra-substituted (4 alkyl groups). More hyperconjugation → more stable.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_1_2,
    question_type: 'true_false',
    question_text: 'Aniline (C₆H₅NH₂) is a weaker base than aliphatic amines because the lone pair on nitrogen is delocalized into the benzene ring.',
    correct_answer: true,
    explanation: 'TRUE. Aniline\'s lone pair delocalizes into benzene (+M effect), making it less available for protonation. pKb (aniline) = 9.4 vs pKb (CH₃NH₂) = 3.4.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.5,
    difficulty_level: 'easy'
  }
])

puts "✅ Quiz 1.2 created with 9 questions"

puts "\n" + "="*80
puts "Module 1: General Organic Chemistry - Core Content Complete!"
puts "="*80
puts "Completed: 2 lessons, 2 quizzes, 17 questions"
puts "Module 1 provides strong foundation for all organic chemistry"
puts "="*80

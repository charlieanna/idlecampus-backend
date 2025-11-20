# AUTO-GENERATED from module_01_goc.rb
puts "Creating Microlessons for Module 01 Goc..."

module_var = CourseModule.find_by(slug: 'module-01-goc')

# === MICROLESSON 1: Aniline (C₆H₅NH₂) is a weaker base than aliphatic amines because the lone pair on nitrogen is delocalized into the benzene ring. ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Aniline (C₆H₅NH₂) is a weaker base than aliphatic amines because the lone pair on nitrogen is delocalized into the benzene ring.',
  content: <<~MARKDOWN,
# Aniline (C₆H₅NH₂) is a weaker base than aliphatic amines because the lone pair on nitrogen is delocalized into the benzene ring. 🚀

TRUE. Aniline\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
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
    question: 'Aniline (C₆H₅NH₂) is a weaker base than aliphatic amines because the lone pair on nitrogen is delocalized into the benzene ring.',
    answer: '',
    explanation: 'TRUE. Aniline\',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Electronic Effects - Resonance, Inductive, and Hyperconjugation ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Electronic Effects - Resonance, Inductive, and Hyperconjugation',
  content: <<~MARKDOWN,
# Electronic Effects - Resonance, Inductive, and Hyperconjugation 🚀

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

## Key Points

- Resonance structures and stability

- Inductive effect (+I, -I)

- Mesomeric effect (+M, -M)
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Resonance structures and stability', 'Inductive effect (+I, -I)', 'Mesomeric effect (+M, -M)', 'Hyperconjugation', 'Applications to acidity and basicity'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Bonding in Organic Compounds - Hybridization and Bond Types ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Bonding in Organic Compounds - Hybridization and Bond Types',
  content: <<~MARKDOWN,
# Bonding in Organic Compounds - Hybridization and Bond Types 🚀

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

## Key Points

- Hybridization (sp, sp², sp³)

- Sigma and pi bonds

- Bond lengths and bond angles
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Hybridization (sp, sp², sp³)', 'Sigma and pi bonds', 'Bond lengths and bond angles', 'Bond energy and strength', 'Covalent character and polarity'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Electronic Effects - Resonance, Inductive, and Hyperconjugation ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Electronic Effects - Resonance, Inductive, and Hyperconjugation',
  content: <<~MARKDOWN,
# Electronic Effects - Resonance, Inductive, and Hyperconjugation 🚀

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

## Key Points

- Resonance structures and stability

- Inductive effect (+I, -I)

- Mesomeric effect (+M, -M)
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Resonance structures and stability', 'Inductive effect (+I, -I)', 'Mesomeric effect (+M, -M)', 'Hyperconjugation', 'Applications to acidity and basicity'],
  prerequisite_ids: []
)

# === MICROLESSON 5: What is the hybridization of the carbon atom in CH₄ (methane)? ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the hybridization of the carbon atom in CH₄ (methane)?',
  content: <<~MARKDOWN,
# What is the hybridization of the carbon atom in CH₄ (methane)? 🚀

Methane (CH₄) has tetrahedral geometry with 4 single bonds, indicating sp³ hybridization. Bond angle = 109.5°.

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

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the hybridization of the carbon atom in CH₄ (methane)?',
    options: ['sp', 'sp²', 'sp³', 'sp³d'],
    correct_answer: 2,
    explanation: 'Methane (CH₄) has tetrahedral geometry with 4 single bonds, indicating sp³ hybridization. Bond angle = 109.5°.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: Which of the following statements about π bonds are correct? ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following statements about π bonds are correct?',
  content: <<~MARKDOWN,
# Which of the following statements about π bonds are correct? 🚀

π bonds: (1) Lateral overlap of p orbitals ✓ (2) Restricted rotation ✓ (3) Weaker than σ ✓ (4) Electron density above/below axis, not along it.

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
    question: 'Which of the following statements about π bonds are correct?',
    options: ['π bonds are formed by lateral overlap of p orbitals', 'π bonds allow free rotation around the bond axis', 'π bonds are weaker than σ bonds', 'π bonds have electron density along the internuclear axis'],
    correct_answer: 2,
    explanation: 'π bonds: (1) Lateral overlap of p orbitals ✓ (2) Restricted rotation ✓ (3) Weaker than σ ✓ (4) Electron density above/below axis, not along it.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 7: Arrange the following in order of INCREASING bond length: (1) C-C (ethane) (2) C=C (ethene) (3) C≡C (ethyne) ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arrange the following in order of INCREASING bond length: (1) C-C (ethane) (2) C=C (ethene) (3) C≡C (ethyne)',
  content: <<~MARKDOWN,
# Arrange the following in order of INCREASING bond length: (1) C-C (ethane) (2) C=C (ethene) (3) C≡C (ethyne) 🚀

Bond length order: C≡C (120 pm) < C=C (134 pm) < C-C (154 pm). More bonds → shorter distance.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
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
    question: 'Arrange the following in order of INCREASING bond length: (1) C-C (ethane) (2) C=C (ethene) (3) C≡C (ethyne)',
    answer: '',
    explanation: 'Bond length order: C≡C (120 pm) < C=C (134 pm) < C-C (154 pm). More bonds → shorter distance.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: In the compound CH₂=CH-CN, what is the hybridization of the carbon in the nitrile group (-CN)? ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'In the compound CH₂=CH-CN, what is the hybridization of the carbon in the nitrile group (-CN)?',
  content: <<~MARKDOWN,
# In the compound CH₂=CH-CN, what is the hybridization of the carbon in the nitrile group (-CN)? 🚀

The carbon in -CN forms a triple bond (C≡N), which requires sp hybridization (linear geometry, 180° bond angle).

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
    question: 'In the compound CH₂=CH-CN, what is the hybridization of the carbon in the nitrile group (-CN)?',
    options: ['sp', 'sp²', 'sp³', 'sp²d'],
    correct_answer: 0,
    explanation: 'The carbon in -CN forms a triple bond (C≡N), which requires sp hybridization (linear geometry, 180° bond angle).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: How many sigma (σ) bonds are present in benzene (C₆H₆)? ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'How many sigma (σ) bonds are present in benzene (C₆H₆)?',
  content: <<~MARKDOWN,
# How many sigma (σ) bonds are present in benzene (C₆H₆)? 🚀

Benzene has 6 C-C bonds + 6 C-H bonds = 12 σ bonds. (The 3 double bonds contribute 3 more π bonds, total 12σ + 3π = 15 bonds).

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

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many sigma (σ) bonds are present in benzene (C₆H₆)?',
    answer: '12',
    explanation: 'Benzene has 6 C-C bonds + 6 C-H bonds = 12 σ bonds. (The 3 double bonds contribute 3 more π bonds, total 12σ + 3π = 15 bonds).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: Which hybrid orbital has the HIGHEST percentage of s-character? ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which hybrid orbital has the HIGHEST percentage of s-character?',
  content: <<~MARKDOWN,
# Which hybrid orbital has the HIGHEST percentage of s-character? 🚀

sp has 50% s-character (1s in 2 orbitals). sp² has 33% (1s in 3 orbitals). sp³ has 25% (1s in 4 orbitals).

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
    question: 'Which hybrid orbital has the HIGHEST percentage of s-character?',
    options: ['sp³', 'sp²', 'sp', 'All have equal s-character'],
    correct_answer: 2,
    explanation: 'sp has 50% s-character (1s in 2 orbitals). sp² has 33% (1s in 3 orbitals). sp³ has 25% (1s in 4 orbitals).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: Which of the following is the MOST acidic? ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following is the MOST acidic?',
  content: <<~MARKDOWN,
# Which of the following is the MOST acidic? 🚀

Ethyne (sp carbon) is most acidic (pKa ≈ 25). More s-character → conjugate base (C₂H⁻) more stable → more acidic. Ethene: pKa ≈ 44, Ethane: pKa ≈ 50.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'hard',
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
    question: 'Which of the following is the MOST acidic?',
    options: ['Ethane (C₂H₆)', 'Ethene (C₂H₄)', 'Ethyne (C₂H₂)', 'All are equally acidic'],
    correct_answer: 2,
    explanation: 'Ethyne (sp carbon) is most acidic (pKa ≈ 25). More s-character → conjugate base (C₂H⁻) more stable → more acidic. Ethene: pKa ≈ 44, Ethane: pKa ≈ 50.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 12: A double bond consists of ___ sigma bond(s) and ___ pi bond(s). (Format: X,Y) ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'A double bond consists of ___ sigma bond(s) and ___ pi bond(s). (Format: X,Y)',
  content: <<~MARKDOWN,
# A double bond consists of ___ sigma bond(s) and ___ pi bond(s). (Format: X,Y) 🚀

A double bond = 1 σ + 1 π. The σ bond is formed first (stronger, head-on overlap), then π bond (weaker, lateral overlap).

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
    question: 'A double bond consists of ___ sigma bond(s) and ___ pi bond(s). (Format: X,Y)',
    answer: '1,1',
    explanation: 'A double bond = 1 σ + 1 π. The σ bond is formed first (stronger, head-on overlap), then π bond (weaker, lateral overlap).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: Which of the following groups shows the STRONGEST -I (electron-withdrawing inductive) effect? ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following groups shows the STRONGEST -I (electron-withdrawing inductive) effect?',
  content: <<~MARKDOWN,
# Which of the following groups shows the STRONGEST -I (electron-withdrawing inductive) effect? 🚀

-NO₂ (nitro group) has the strongest -I effect. Order: -NO₂ > -CN > -COOH > -F > -Cl > -Br > -I > -OH > -OR > -NH₂.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
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
    question: 'Which of the following groups shows the STRONGEST -I (electron-withdrawing inductive) effect?',
    options: ['-CH₃', '-OH', '-NO₂', '-C₆H₅'],
    correct_answer: 2,
    explanation: '-NO₂ (nitro group) has the strongest -I effect. Order: -NO₂ > -CN > -COOH > -F > -Cl > -Br > -I > -OH > -OR > -NH₂.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 14: Arrange the following carboxylic acids in order of INCREASING acidity: (1) CH₃COOH (2) ClCH₂COOH (3) Cl₂CHCOOH (4) Cl₃CCOOH ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arrange the following carboxylic acids in order of INCREASING acidity: (1) CH₃COOH (2) ClCH₂COOH (3) Cl₂CHCOOH (4) Cl₃CCOOH',
  content: <<~MARKDOWN,
# Arrange the following carboxylic acids in order of INCREASING acidity: (1) CH₃COOH (2) ClCH₂COOH (3) Cl₂CHCOOH (4) Cl₃CCOOH 🚀

More Cl atoms → stronger -I effect → more stable anion → more acidic. pKa values: Cl₃C (0.7) < Cl₂CH (1.3) < ClCH₂ (2.9) < CH₃ (4.8).

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
    question: 'Arrange the following carboxylic acids in order of INCREASING acidity: (1) CH₃COOH (2) ClCH₂COOH (3) Cl₂CHCOOH (4) Cl₃CCOOH',
    answer: '',
    explanation: 'More Cl atoms → stronger -I effect → more stable anion → more acidic. pKa values: Cl₃C (0.7) < Cl₂CH (1.3) < ClCH₂ (2.9) < CH₃ (4.8).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: Which of the following statements about resonance are correct? ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following statements about resonance are correct?',
  content: <<~MARKDOWN,
# Which of the following statements about resonance are correct? 🚀

Resonance rules: (1) Only electrons move, not atoms ✓ (2) Hybrid structure represents reality ✓ (3) Atoms fixed ✓ (4) Delocalization always stabilizes ✓.

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
    question: 'Which of the following statements about resonance are correct?',
    options: ['Resonance structures differ in the position of electrons only', 'The actual molecule is a hybrid of all resonance structures', 'Atoms can change position in different resonance structures', 'Resonance always increases molecular stability'],
    correct_answer: 3,
    explanation: 'Resonance rules: (1) Only electrons move, not atoms ✓ (2) Hybrid structure represents reality ✓ (3) Atoms fixed ✓ (4) Delocalization always stabilizes ✓.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: How many hyperconjugative structures can be drawn for the tert-butyl carbocation, (CH₃)₃C⁺? ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'How many hyperconjugative structures can be drawn for the tert-butyl carbocation, (CH₃)₃C⁺?',
  content: <<~MARKDOWN,
# How many hyperconjugative structures can be drawn for the tert-butyl carbocation, (CH₃)₃C⁺? 🚀

Tert-butyl carbocation has 3 CH₃ groups. Each CH₃ has 3 α-hydrogens. Total = 3 × 3 = 9 hyperconjugative structures.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
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
    question: 'How many hyperconjugative structures can be drawn for the tert-butyl carbocation, (CH₃)₃C⁺?',
    answer: '9',
    explanation: 'Tert-butyl carbocation has 3 CH₃ groups. Each CH₃ has 3 α-hydrogens. Total = 3 × 3 = 9 hyperconjugative structures.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: Which of the following carbocations is the MOST stable? ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following carbocations is the MOST stable?',
  content: <<~MARKDOWN,
# Which of the following carbocations is the MOST stable? 🚀

Stability order: 3° > 2° > 1° > methyl. Tertiary carbocation is most stable due to +I effect of three CH₃ groups and maximum hyperconjugation (9 α-H).

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
    question: 'Which of the following carbocations is the MOST stable?',
    options: ['CH₃⁺ (methyl)', 'CH₃CH₂⁺ (primary)', '(CH₃)₂CH⁺ (secondary)', '(CH₃)₃C⁺ (tertiary)'],
    correct_answer: 3,
    explanation: 'Stability order: 3° > 2° > 1° > methyl. Tertiary carbocation is most stable due to +I effect of three CH₃ groups and maximum hyperconjugation (9 α-H).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 18: Why is phenol (C₆H₅OH) more acidic than cyclohexanol (C₆H₁₁OH)? ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Why is phenol (C₆H₅OH) more acidic than cyclohexanol (C₆H₁₁OH)?',
  content: <<~MARKDOWN,
# Why is phenol (C₆H₅OH) more acidic than cyclohexanol (C₆H₁₁OH)? 🚀

Phenoxide ion (C₆H₅O⁻) is stabilized by resonance with the benzene ring (delocalization of negative charge). Cyclohexanol anion has no such stabilization. pKa (phenol) ≈ 10, pKa (cyclohexanol) ≈ 16.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'hard',
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
    question: 'Why is phenol (C₆H₅OH) more acidic than cyclohexanol (C₆H₁₁OH)?',
    options: ['Phenol has a stronger O-H bond', 'The phenoxide ion is stabilized by resonance', 'Cyclohexanol is more polar', 'Phenol has a higher molecular weight'],
    correct_answer: 1,
    explanation: 'Phenoxide ion (C₆H₅O⁻) is stabilized by resonance with the benzene ring (delocalization of negative charge). Cyclohexanol anion has no such stabilization. pKa (phenol) ≈ 10, pKa (cyclohexanol) ≈ 16.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 19: Which group shows both -I and +M effects, but +M effect DOMINATES? ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which group shows both -I and +M effects, but +M effect DOMINATES?',
  content: <<~MARKDOWN,
# Which group shows both -I and +M effects, but +M effect DOMINATES? 🚀

-OH shows -I (O is electronegative) and +M (lone pair donation). +M dominates, making -OH a net electron-donating group. -NO₂, -COOH, -CN show dominant -M effect.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 19.2: MCQ
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which group shows both -I and +M effects, but +M effect DOMINATES?',
    options: ['-NO₂', '-COOH', '-OH', '-CN'],
    correct_answer: 2,
    explanation: '-OH shows -I (O is electronegative) and +M (lone pair donation). +M dominates, making -OH a net electron-donating group. -NO₂, -COOH, -CN show dominant -M effect.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 20: Which of the following alkenes is the MOST stable? ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following alkenes is the MOST stable?',
  content: <<~MARKDOWN,
# Which of the following alkenes is the MOST stable? 🚀

Alkene stability: Tetra-substituted > Tri > Di > Mono > Unsubstituted. (CH₃)₂C=C(CH₃)₂ is tetra-substituted (4 alkyl groups). More hyperconjugation → more stable.

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
    question: 'Which of the following alkenes is the MOST stable?',
    options: ['CH₂=CH₂ (ethene)', 'CH₃CH=CH₂ (propene)', '(CH₃)₂C=CH₂ (2-methylpropene)', '(CH₃)₂C=C(CH₃)₂ (2,3-dimethyl-2-butene)'],
    correct_answer: 3,
    explanation: 'Alkene stability: Tetra-substituted > Tri > Di > Mono > Unsubstituted. (CH₃)₂C=C(CH₃)₂ is tetra-substituted (4 alkyl groups). More hyperconjugation → more stable.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 21: Bonding in Organic Compounds - Hybridization and Bond Types ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'Bonding in Organic Compounds - Hybridization and Bond Types',
  content: <<~MARKDOWN,
# Bonding in Organic Compounds - Hybridization and Bond Types 🚀

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

## Key Points

- Hybridization (sp, sp², sp³)

- Sigma and pi bonds

- Bond lengths and bond angles
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Hybridization (sp, sp², sp³)', 'Sigma and pi bonds', 'Bond lengths and bond angles', 'Bond energy and strength', 'Covalent character and polarity'],
  prerequisite_ids: []
)

puts "✓ Created 21 microlessons for Module 01 Goc"

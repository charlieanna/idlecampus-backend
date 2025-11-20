# Module 7: Aromatic Compounds
# Comprehensive coverage of aromaticity, benzene chemistry, and electrophilic aromatic substitution
# Covers Huckel's rule, EAS mechanisms, and directing effects

puts "Creating Module 7: Aromatic Compounds..."

# Get Organic Chemistry course
course_organic = Course.find_by(title: 'Organic Chemistry for IIT JEE Main & Advanced')

unless course_organic
  puts "❌ Error: Organic Chemistry course not found. Please run module_01_goc.rb first."
  exit
end

# Create Module 7
module_07 = CourseModule.create!(
  course: course_organic,
  title: 'Module 7: Aromatic Compounds',
  description: 'Aromaticity, benzene chemistry, Huckel\'s rule, electrophilic aromatic substitution, and directing effects of substituents',
  sequence_order: 7,
  estimated_minutes: 280,
  published: true
)

puts "✅ Module 7 created"

# ============================================================================
# LESSON 7.1: Introduction to Aromaticity and Huckel's Rule
# ============================================================================

lesson_7_1 = CourseLesson.create!(
  title: 'Introduction to Aromaticity - Benzene Structure and Huckel\'s Rule',
  reading_time_minutes: 50,
  key_concepts: [
    'Structure of benzene',
    'Aromaticity and resonance energy',
    'Huckel\'s rule (4n+2)',
    'Aromatic, antiaromatic, and nonaromatic compounds',
    'Aromatic heterocycles'
  ],
  content: <<~MD
    # Introduction to Aromaticity

    ## 1. Discovery and Structure of Benzene

    ### Historical Context
    - **Molecular formula:** C₆H₆
    - **Discovered by:** Michael Faraday (1825)
    - **Structure proposed by:** Friedrich August Kekulé (1865)

    ### Kekulé Structure
    ```
    Two possible structures (resonance):

         ⬡                ⬡
        / \\              /  \\
       /   \\            //   \\
      |     |     ⟷    |     |
       \   /             \\   /
        \\_//              \\ //
         ⬡                ⬡

    Alternating single and double bonds
    ```

    ### Problems with Kekulé Structure
    1. **Should show reactivity of alkenes** → But benzene is very stable
    2. **Should have two different C-C bond lengths** → But all are equal (139 pm)
    3. **Heat of hydrogenation** should be 3× cyclohexene → But it's much less

    ---

    ## 2. Modern Structure of Benzene

    ### Resonance Model
    - **All C-C bonds are equivalent** (139 pm)
    - **Bond order:** 1.5 (between single and double)
    - **Hybrid structure:** Resonance between two Kekulé structures
    - **π electrons delocalized** over all six carbons

    ### Orbital Picture
    - **All carbons:** sp² hybridized
    - **Bond angles:** 120° (hexagonal, planar)
    - **π system:** 6 p orbitals overlap to form continuous π cloud above and below the ring

    ```
    Side view of benzene:

         π electron cloud (above)
         ___________________
        |                   |
    C — C — C — C — C — C (σ framework)
        |___________________|
         π electron cloud (below)

    6 π electrons delocalized
    ```

    ### Resonance Energy
    - **Definition:** Extra stability due to delocalization
    - **Benzene resonance energy:** 150 kJ/mol (36 kcal/mol)
    - **Meaning:** Benzene is 150 kJ/mol more stable than predicted for localized structure

    **Evidence from hydrogenation:**
    ```
    Cyclohexene + H₂ → Cyclohexane         ΔH = -120 kJ/mol

    Predicted for benzene (3 double bonds):
    3 × (-120) = -360 kJ/mol

    Actual for benzene:
    Benzene + 3H₂ → Cyclohexane            ΔH = -210 kJ/mol

    Difference = 360 - 210 = 150 kJ/mol
    (This is the resonance energy/stabilization)
    ```

    ---

    ## 3. Aromaticity - Definition and Criteria

    ### What is Aromaticity?
    **Aromaticity** is the special stability exhibited by cyclic, planar compounds with delocalized π electrons following Huckel's rule.

    ### Criteria for Aromaticity (Must satisfy ALL)

    #### 1. Cyclic Structure
    - Molecule must form a ring
    - Acyclic systems cannot be aromatic

    #### 2. Planar Geometry
    - All atoms in the ring must be in the same plane
    - Allows p orbital overlap for π delocalization
    - Non-planar rings cannot have effective π overlap

    #### 3. Complete Conjugation
    - Every atom in the ring has a p orbital
    - Continuous overlap of p orbitals around the ring
    - Typically sp² or sp hybridized atoms

    #### 4. Huckel's Rule: (4n + 2) π electrons
    - **n** is a non-negative integer (0, 1, 2, 3, ...)
    - **Aromatic:** 2, 6, 10, 14, 18, ... π electrons
    - **Antiaromatic:** 4n π electrons (4, 8, 12, ...)

    ---

    ## 4. Huckel's Rule Explained

    ### The (4n + 2) Rule

    **Aromatic compounds have (4n + 2) π electrons where n = 0, 1, 2, 3, ...**

    | n | 4n + 2 | π electrons | Example |
    |---|--------|-------------|---------|
    | 0 | 2 | 2 | Cyclopropenyl cation |
    | 1 | 6 | 6 | Benzene, pyridine |
    | 2 | 10 | 10 | Naphthalene, azulene |
    | 3 | 14 | 14 | Anthracene |
    | 4 | 18 | 18 | [18]Annulene |

    ### Quantum Mechanical Origin
    - Based on **molecular orbital theory**
    - (4n + 2) π electrons fill all bonding and non-bonding MOs
    - Results in **closed-shell configuration** (extra stable)

    ---

    ## 5. Types of Compounds

    ### A. Aromatic Compounds
    - **Satisfy all criteria** including (4n+2) π electrons
    - **Exceptionally stable** (low reactivity)
    - **Undergo substitution** rather than addition reactions
    - **Examples:** Benzene, naphthalene, pyridine, furan

    ### B. Antiaromatic Compounds
    - Cyclic, planar, conjugated
    - Have **4n π electrons** (n = 1, 2, 3, ...)
    - **Highly unstable** (more reactive than expected)
    - **Avoid planarity** if possible (to reduce instability)
    - **Examples:** Cyclobutadiene, cyclooctatetraene (if planar)

    ### C. Nonaromatic Compounds
    - Do NOT meet one or more criteria
    - **Not cyclic**, OR
    - **Not planar**, OR
    - **Not conjugated**
    - **Normal stability** (neither extra stable nor unstable)
    - **Examples:** Cyclohexene, cyclohexane, cyclooctatetraene (tub-shaped)

    ---

    ## 6. Examples and Analysis

    ### Aromatic Examples

    #### Benzene (C₆H₆)
    ```
    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated (6 p orbitals)
    ✓ 6 π electrons (4n+2, n=1)
    → AROMATIC
    ```

    #### Naphthalene (C₁₀H₈)
    ```
    ⬡⬡  (Two fused benzene rings)

    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated
    ✓ 10 π electrons (4n+2, n=2)
    → AROMATIC
    ```

    #### Cyclopropenyl Cation (C₃H₃⁺)
    ```
         +
        /⌃\\
       /    \\

    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated (3 p orbitals)
    ✓ 2 π electrons (4n+2, n=0)
    → AROMATIC
    ```

    ### Antiaromatic Example

    #### Cyclobutadiene (C₄H₄)
    ```
      ⬡
     /  \\
    |    |
     \\  /
      ⬡

    ✓ Cyclic
    ✓ Planar (if forced)
    ✓ Conjugated
    ✗ 4 π electrons (4n, n=1)
    → ANTIAROMATIC (highly unstable)
    ```

    ### Nonaromatic Examples

    #### Cyclohexene
    ```
       ⬡
      /  \\
     /    \\
    |      | (one double bond)
     \\    /
      \\  /

    ✓ Cyclic
    ✓ Planar (roughly)
    ✗ NOT fully conjugated (one sp³ carbon)
    → NONAROMATIC
    ```

    #### Cyclooctatetraene (C₈H₈) - Actual Structure
    ```
    ✓ Cyclic
    ✗ NOT planar (adopts tub shape to avoid antiaromaticity)
    ✓ Would be conjugated if planar
    ✗ 8 π electrons (4n, n=2) → would be antiaromatic if planar

    → NONAROMATIC (avoids antiaromaticity by being non-planar)
    ```

    ---

    ## 7. Aromatic Ions

    ### Cyclopropenyl Cation (C₃H₃⁺)
    - **2 π electrons** (4n+2, n=0)
    - **Aromatic** and very stable for a cation
    - pKa of precursor ~1 (very acidic)

    ### Cyclopropenyl Anion (C₃H₃⁻)
    - **4 π electrons** (4n, n=1)
    - **Antiaromatic** and very unstable

    ### Cyclopentadienyl Anion (C₅H₅⁻)
    ```
        ⊖
       /⌂\\
      /    \\
     |      |
      \\    /
       \\__/

    6 π electrons (4n+2, n=1)
    → AROMATIC (very stable anion)
    pKa of cyclopentadiene ≈ 16 (very acidic for hydrocarbon)
    ```

    ### Cyclopentadienyl Cation (C₅H₅⁺)
    - **4 π electrons** (4n, n=1)
    - **Antiaromatic** and very unstable

    ### Cycloheptatrienyl Cation (Tropylium, C₇H₇⁺)
    ```
         ⊕
        /⌃\\
       /    \\
      |      |
       \\    /
        \\__/

    6 π electrons (4n+2, n=1)
    → AROMATIC (stable cation)
    ```

    **Summary:**
    - **Cyclopentadienyl anion:** Aromatic (6 π e⁻)
    - **Tropylium cation:** Aromatic (6 π e⁻)
    - Both are exceptionally stable for ions

    ---

    ## 8. Aromatic Heterocycles

    ### Pyridine (C₅H₅N)
    ```
         N
        /⌂\\
       /    \\
      |      |
       \\    /
        \\__/

    - Nitrogen has one lone pair in sp² orbital (NOT in π system)
    - 6 π electrons from 5 carbons + 1 from N
    - Aromatic
    ```

    ### Pyrrole (C₄H₅N)
    ```
         N-H
        /⌂\\
       /    \\
      |      |
       \\____/

    - Nitrogen lone pair IN π system
    - 6 π electrons (4 from C=C + 2 from N)
    - Aromatic
    - Less basic than pyridine (lone pair delocalized)
    ```

    ### Furan (C₄H₄O)
    ```
         O
        /⌂\\
       /    \\
      |      |
       \\____/

    - Oxygen has one lone pair in π system
    - 6 π electrons (4 from C=C + 2 from O)
    - Aromatic
    ```

    ### Comparison

    | Compound | Heteroatom | Lone pair position | π electrons | Aromatic? |
    |----------|------------|-------------------|-------------|-----------|
    | Benzene | None | — | 6 | Yes |
    | Pyridine | N | sp² (not in π) | 6 | Yes |
    | Pyrrole | N | p (in π) | 6 | Yes |
    | Furan | O | p (in π) | 6 | Yes |

    ---

    ## 9. Stability Order

    ### Aromatic > Nonaromatic > Antiaromatic

    **Energy comparison:**
    ```
    Antiaromatic (least stable)
          ↑
          | (highly unstable)
          |
    Nonaromatic (normal stability)
          ↑
          | (resonance stabilization)
          |
    Aromatic (most stable)
    ```

    **Example: C₅H₅ species**
    ```
    C₅H₅⁺ (4π, antiaromatic) < C₅H₅• (5π, nonaromatic) < C₅H₅⁻ (6π, aromatic)
    (least stable)                                         (most stable)
    ```

    ---

    ## Important Points for IIT JEE

    1. **Huckel's rule memorization:**
       - Aromatic: 2, 6, 10, 14, 18 π electrons
       - Antiaromatic: 4, 8, 12, 16 π electrons
       - Must be cyclic, planar, and conjugated

    2. **Counting π electrons:**
       - Double bond = 2 π electrons
       - Lone pair (if in p orbital) = 2 π electrons
       - Empty p orbital = 0 π electrons
       - Check ONLY the cyclic system

    3. **Aromaticity in ions:**
       - C₃H₃⁺, C₅H₅⁻, C₇H₇⁺ are aromatic (6 π e⁻)
       - These ions are surprisingly stable

    4. **Heterocycles:**
       - Pyridine: N lone pair NOT in π system (basic)
       - Pyrrole: N lone pair IN π system (weakly basic)
       - Both are aromatic (6 π electrons)

    5. **Resonance energy:**
       - Measure of extra stability
       - Benzene: 150 kJ/mol
       - Explains why benzene undergoes substitution, not addition

    ---

    ## Practice Questions

    1. Is cyclooctatetraene aromatic, antiaromatic, or nonaromatic? Explain.
    2. Calculate the number of π electrons in furan and determine if it's aromatic.
    3. Why is cyclopentadienyl anion much more stable than typical carbanions?
    4. Draw the structure of naphthalene and verify it follows Huckel's rule.
    5. Compare the basicity of pyridine and pyrrole. Explain the difference.
  MD
)

ModuleItem.create!(
  course_module: module_07,
  item: lesson_7_1,
  sequence_order: 1,
  required: true
)

puts "✅ Lesson 7.1 created"

# Create Quiz 7.1
quiz_7_1 = Quiz.create!(
  title: 'Quiz 7.1: Aromaticity and Huckel\'s Rule',
  description: 'Test your understanding of aromaticity, Huckel\'s rule, and aromatic/antiaromatic compounds',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_07,
  item: quiz_7_1,
  sequence_order: 2,
  required: true
)

# Quiz 7.1 Questions
QuizQuestion.create!([
  {
    quiz: quiz_7_1,
    question_type: 'numerical',
    question_text: 'What is the resonance energy of benzene in kJ/mol?',
    correct_answer: '150',
    tolerance: 10,
    explanation: 'Benzene has a resonance energy of approximately 150 kJ/mol (or 36 kcal/mol). This represents the extra stability gained from π electron delocalization.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following criteria must be satisfied for a compound to be aromatic?',
    options: [
      { text: 'Cyclic structure', correct: true },
      { text: 'Planar geometry', correct: true },
      { text: 'Complete conjugation', correct: true },
      { text: '4n π electrons where n is an integer', correct: false }
    ],
    explanation: 'For aromaticity: (1) Cyclic ✓ (2) Planar ✓ (3) Conjugated ✓ (4) (4n+2) π electrons, not 4n. The 4n rule gives antiaromatic compounds.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'According to Huckel\'s rule, which of the following numbers of π electrons indicates an AROMATIC compound?',
    options: [
      { text: '4', correct: false },
      { text: '6', correct: true },
      { text: '8', correct: false },
      { text: '12', correct: false }
    ],
    explanation: 'Aromatic compounds have (4n+2) π electrons where n=0,1,2,3... → 2,6,10,14,18... For n=1: 4(1)+2=6. The values 4, 8, 12 are 4n (antiaromatic).',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_7_1,
    question_type: 'numerical',
    question_text: 'How many π electrons does naphthalene (two fused benzene rings) have?',
    correct_answer: '10',
    tolerance: 0,
    explanation: 'Naphthalene (C₁₀H₈) has 10 π electrons (5 double bonds). This satisfies Huckel\'s rule: 4n+2=10, where n=2. Therefore, naphthalene is aromatic.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Cyclobutadiene (C₄H₄) is classified as:',
    options: [
      { text: 'Aromatic', correct: false },
      { text: 'Antiaromatic', correct: true },
      { text: 'Nonaromatic', correct: false },
      { text: 'None of the above', correct: false }
    ],
    explanation: 'Cyclobutadiene has 4 π electrons (4n where n=1), making it ANTIAROMATIC. It is cyclic, planar, and conjugated, but has 4n electrons instead of 4n+2, making it highly unstable.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why is cyclopentadienyl anion (C₅H₅⁻) exceptionally stable?',
    options: [
      { text: 'It has 4 π electrons making it antiaromatic', correct: false },
      { text: 'It has 6 π electrons making it aromatic', correct: true },
      { text: 'It has resonance with oxygen', correct: false },
      { text: 'It is a primary carbanion', correct: false }
    ],
    explanation: 'C₅H₅⁻ has 6 π electrons (4n+2, n=1), making it AROMATIC and exceptionally stable for a carbanion. The cyclopentadienyl anion is one of the most stable organic anions due to aromaticity.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Cyclooctatetraene (C₈H₈) is nonaromatic rather than antiaromatic because:',
    options: [
      { text: 'It has 6 π electrons', correct: false },
      { text: 'It adopts a non-planar tub shape', correct: true },
      { text: 'It lacks conjugation', correct: false },
      { text: 'It is not cyclic', correct: false }
    ],
    explanation: 'Cyclooctatetraene has 8 π electrons (4n, n=2) which would make it antiaromatic if planar. To avoid this instability, it adopts a non-planar tub conformation, making it nonaromatic instead.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.5,
    guessing: 0.25,
    difficulty_level: 'hard'
  },
  {
    quiz: quiz_7_1,
    question_type: 'numerical',
    question_text: 'How many π electrons does pyrrole (C₄H₅N) contain in its aromatic system?',
    correct_answer: '6',
    tolerance: 0,
    explanation: 'Pyrrole has 6 π electrons: 4 from the two C=C double bonds + 2 from the nitrogen lone pair (which is in a p orbital and part of the π system). This makes pyrrole aromatic.',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In pyridine (C₅H₅N), the nitrogen lone pair is:',
    options: [
      { text: 'Part of the aromatic π system', correct: false },
      { text: 'In an sp² orbital perpendicular to the ring', correct: true },
      { text: 'Delocalized over all six atoms', correct: false },
      { text: 'Not present', correct: false }
    ],
    explanation: 'In pyridine, the N lone pair is in an sp² orbital in the plane of the ring (NOT part of the π system). The π system has 6 electrons from the ring. This makes pyridine basic (lone pair available).',
    points: 4,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_1,
    question_type: 'true_false',
    question_text: 'Antiaromatic compounds are less stable than their corresponding nonaromatic compounds.',
    correct_answer: true,
    explanation: 'TRUE. Stability order: Aromatic > Nonaromatic > Antiaromatic. Antiaromatic compounds (4n π electrons in cyclic, planar, conjugated systems) are destabilized and less stable than nonaromatic compounds.',
    points: 2,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.5,
    difficulty_level: 'medium'
  }
])

puts "✅ Quiz 7.1 created with 10 questions"

# ============================================================================
# LESSON 7.2: Electrophilic Aromatic Substitution (EAS) Reactions
# ============================================================================

lesson_7_2 = CourseLesson.create!(
  title: 'Electrophilic Aromatic Substitution - Mechanisms and Reactions',
  reading_time_minutes: 65,
  key_concepts: [
    'General mechanism of EAS',
    'Halogenation',
    'Nitration',
    'Sulfonation',
    'Friedel-Crafts alkylation and acylation',
    'Energy profile and intermediate stability'
  ],
  content: <<~MD
    # Electrophilic Aromatic Substitution (EAS)

    ## 1. Why Substitution Instead of Addition?

    ### Benzene vs Alkenes

    **Alkenes:** Undergo addition reactions
    ```
    CH₂=CH₂ + Br₂ → CH₂Br-CH₂Br
    (Addition product - no loss of unsaturation)
    ```

    **Benzene:** Undergoes substitution reactions
    ```
    C₆H₆ + Br₂ → C₆H₅Br + HBr
    (Substitution product - maintains aromaticity)
    ```

    ### Reason
    - **Addition** would destroy aromaticity (loss of 150 kJ/mol stabilization)
    - **Substitution** maintains aromaticity (energetically favorable)
    - Benzene sacrifices one H to keep aromatic system intact

    ---

    ## 2. General Mechanism of EAS

    ### Two-Step Process

    **Step 1: Formation of σ-complex (Slow, Rate-determining)**
    ```
    Electrophile (E⁺) attacks π cloud
    → Arenium ion (σ-complex, Wheland intermediate)
    → Loss of aromaticity (carbocation intermediate)
    ```

    **Step 2: Deprotonation (Fast)**
    ```
    Loss of H⁺ from carbocation
    → Restoration of aromaticity
    → Substituted benzene
    ```

    ### Detailed Mechanism

    ```
    Step 1: Electrophilic Attack (SLOW)

          H   E                    H   E⁺
          |   |                    |   |
      ⬡       →               ⬡
     /  \\                    /  \\
    |    |                  |    |  (σ-complex)
     \\  /                    \\  /
      ⬡                      ⬡

    (Aromatic)           (Non-aromatic, less stable)


    Step 2: Deprotonation (FAST)

         H   E⁺                    E
         |   |                     |
     ⬡           + Base→       ⬡
    /  \\                      /  \\
   |    |                    |    |
    \\  /                      \\  /
     ⬡                        ⬡

    (σ-complex)              (Aromatic, restored)
    ```

    ### Energy Diagram

    ```
    Energy
      ↑
      |           σ-complex (arenium ion)
      |              /\\
      |             /  \\
      |            /    \\
      |  E⁺       /      \\        Product
      |  +    Ea₁/        \\Ea₂    (aromatic)
      | Benzene  /          \\___________
      |    ___/
      |   /
      |__________________________________→
                Reaction coordinate

    Step 1 (slow): Formation of carbocation (rate-determining)
    Step 2 (fast): Loss of H⁺
    ```

    ---

    ## 3. Halogenation

    ### Reaction
    ```
    Benzene + X₂ → Chlorobenzene/Bromobenzene + HX
    (X = Cl or Br)
    ```

    ### Mechanism

    **Step 1: Generation of electrophile**
    ```
    Br₂ + FeBr₃ → Br⁺ (bromonium ion) + FeBr₄⁻

    FeBr₃ acts as Lewis acid catalyst
    ```

    **Step 2: Electrophilic attack**
    ```
        H  Br⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Bromobenzene + HBr + FeBr₃
    ```

    ### Key Points
    - **Requires Lewis acid catalyst:** FeBr₃, FeCl₃, AlCl₃, AlBr₃
    - **Iodination:** Difficult (reversible), needs oxidizing agent
    - **Fluorination:** Too violent, not used
    - **Only Cl₂ and Br₂** are practical

    ---

    ## 4. Nitration

    ### Reaction
    ```
    Benzene + HNO₃ → Nitrobenzene + H₂O
    (Requires H₂SO₄ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of nitronium ion (NO₂⁺)**
    ```
    HNO₃ + 2H₂SO₄ → NO₂⁺ + H₃O⁺ + 2HSO₄⁻

    Nitronium ion (NO₂⁺) is the electrophile
    ```

    **Step 2: Electrophilic attack**
    ```
        H  NO₂⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Nitrobenzene + H₂SO₄
    ```

    ### Key Points
    - **Electrophile:** NO₂⁺ (nitronium ion)
    - **Reagents:** Conc. HNO₃ + Conc. H₂SO₄ (nitrating mixture)
    - **Product:** Nitrobenzene (yellow liquid)
    - **Application:** Starting material for aniline synthesis

    ---

    ## 5. Sulfonation

    ### Reaction
    ```
    Benzene + H₂SO₄ (fuming) → Benzenesulfonic acid + H₂O
    ```

    ### Mechanism

    **Step 1: Generation of electrophile**
    ```
    H₂SO₄ → SO₃ (sulfur trioxide) + H₂O
    OR
    2H₂SO₄ → SO₃H⁺ (protonated sulfur trioxide)

    Electrophile: SO₃ or SO₃H⁺
    ```

    **Step 2: Electrophilic attack**
    ```
        H  SO₃H⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Benzenesulfonic acid
    ```

    ### Key Points
    - **Electrophile:** SO₃ or SO₃H⁺
    - **Reagent:** Fuming H₂SO₄ (oleum, contains SO₃)
    - **Reversible reaction:** Can be reversed by heating with dilute H₂SO₄
    - **Application:** Detergent synthesis, dye intermediates

    ---

    ## 6. Friedel-Crafts Alkylation

    ### Reaction
    ```
    Benzene + R-X → Alkylbenzene + HX
    (Requires AlCl₃ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of carbocation**
    ```
    R-Cl + AlCl₃ → R⁺ (carbocation) + AlCl₄⁻

    Carbocation is the electrophile
    ```

    **Step 2: Electrophilic attack**
    ```
        H  R⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Alkylbenzene + HCl + AlCl₃
    ```

    ### Limitations

    #### 1. Polyalkylation
    - Product is more reactive than starting benzene
    - Leads to multiple substitutions
    ```
    Benzene → Toluene → Xylene → Trimethylbenzene
    (Difficult to stop at one substitution)
    ```

    #### 2. Carbocation Rearrangement
    - Primary and secondary carbocations rearrange to more stable forms
    ```
    CH₃-CH₂-CH₂-Cl + AlCl₃ → CH₃-CH₂-CH₂⁺
    → CH₃-CH⁺-CH₃ (more stable 2° carbocation)

    Expected: n-propylbenzene
    Actual: Isopropylbenzene (major product)
    ```

    #### 3. Cannot Use with Deactivated Rings
    - NO₂, COOH, SO₃H, etc. deactivate benzene
    - Friedel-Crafts reactions do NOT work on deactivated rings

    ---

    ## 7. Friedel-Crafts Acylation

    ### Reaction
    ```
    Benzene + RCOCl → Acylbenzene (ketone) + HCl
    (Requires AlCl₃ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of acylium ion**
    ```
    R-CO-Cl + AlCl₃ → R-CO⁺ (acylium ion) + AlCl₄⁻

    Acylium ion: R-C≡O⁺ (resonance stabilized)
    ```

    **Step 2: Electrophilic attack**
    ```
        H  R-CO⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Acylbenzene (ketone) + HCl + AlCl₃
    ```

    ### Advantages over Alkylation

    #### 1. No Polyacylation
    - Ketone product is LESS reactive (C=O is electron-withdrawing)
    - Stops after one substitution

    #### 2. No Rearrangement
    - Acylium ion (R-C≡O⁺) is resonance stabilized
    - Does not rearrange

    #### 3. Can be Reduced to Alkylbenzene
    ```
    Acylbenzene → Alkylbenzene (via Clemmensen or Wolff-Kishner reduction)

    Better route to alkylbenzenes than direct alkylation!
    ```

    ---

    ## 8. Comparison of EAS Reactions

    | Reaction | Electrophile | Reagents | Catalyst | Product |
    |----------|--------------|----------|----------|---------|
    | **Halogenation** | X⁺ (Cl⁺, Br⁺) | Cl₂, Br₂ | FeCl₃, FeBr₃ | Halobenzene |
    | **Nitration** | NO₂⁺ | HNO₃ | H₂SO₄ | Nitrobenzene |
    | **Sulfonation** | SO₃, SO₃H⁺ | H₂SO₄ (fuming) | None | Benzenesulfonic acid |
    | **F-C Alkylation** | R⁺ | R-X | AlCl₃ | Alkylbenzene |
    | **F-C Acylation** | RCO⁺ | RCOCl | AlCl₃ | Acylbenzene (ketone) |

    ---

    ## 9. Stability of σ-Complex (Arenium Ion)

    ### Resonance Structures
    The carbocation intermediate (σ-complex) is stabilized by resonance:

    ```
         H   E⁺           H   E⁺           H   E⁺
         |   |            |   |            |   |
     ⬡             ⟷  ⬡             ⟷  ⬡
    /  \\              /  \\              /  \\
   |    |            |    |            |    |
    \\  /              \\  /              \\  /

    Positive charge delocalized over 3 carbons
    (ortho, meta positions relative to attack site)
    ```

    ### Factors Affecting Stability
    1. **Electron-donating groups (+I, +M)** stabilize σ-complex → Faster reaction
    2. **Electron-withdrawing groups (-I, -M)** destabilize σ-complex → Slower reaction
    3. **Position of substituent** affects which positions are stabilized

    ---

    ## Important Points for IIT JEE

    1. **Benzene prefers substitution:**
       - Maintains aromaticity (150 kJ/mol stabilization)
       - Addition would destroy aromatic system

    2. **Rate-determining step:**
       - Formation of σ-complex (Step 1)
       - Electrophile attacks benzene ring
       - Loss of aromaticity is costly energetically

    3. **Friedel-Crafts limitations:**
       - Alkylation: polyalkylation, rearrangement issues
       - Acylation: better alternative, no rearrangement
       - Neither works on deactivated rings (NO₂, COOH, etc.)

    4. **Electrophile generation:**
       - Always requires catalyst or strong acid
       - Memorize electrophiles: X⁺, NO₂⁺, SO₃/SO₃H⁺, R⁺, RCO⁺

    5. **Sulfonation is reversible:**
       - Can remove -SO₃H by heating with dilute H₂SO₄
       - Useful for temporary blocking positions

    ---

    ## Practice Questions

    1. Why does benzene undergo substitution rather than addition with Br₂?
    2. Draw the mechanism for nitration of benzene.
    3. What is the major product when n-propyl chloride reacts with benzene in presence of AlCl₃?
    4. Why is Friedel-Crafts acylation preferred over alkylation?
    5. Why don't Friedel-Crafts reactions work on nitrobenzene?
  MD
)

ModuleItem.create!(
  course_module: module_07,
  item: lesson_7_2,
  sequence_order: 3,
  required: true
)

puts "✅ Lesson 7.2 created"

# Create Quiz 7.2
quiz_7_2 = Quiz.create!(
  title: 'Quiz 7.2: Electrophilic Aromatic Substitution',
  description: 'Test your understanding of EAS mechanisms and reactions',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_07,
  item: quiz_7_2,
  sequence_order: 4,
  required: true
)

# Quiz 7.2 Questions
QuizQuestion.create!([
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why does benzene undergo substitution reactions rather than addition reactions?',
    options: [
      { text: 'Benzene has no double bonds', correct: false },
      { text: 'Addition reactions would destroy the aromatic stability', correct: true },
      { text: 'Benzene is too unreactive for addition', correct: false },
      { text: 'Substitution is faster than addition', correct: false }
    ],
    explanation: 'Benzene undergoes substitution to maintain its aromatic stability (150 kJ/mol resonance energy). Addition would destroy aromaticity, which is energetically unfavorable.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the electrophile in the nitration of benzene?',
    options: [
      { text: 'HNO₃', correct: false },
      { text: 'NO₂⁺ (nitronium ion)', correct: true },
      { text: 'H₂SO₄', correct: false },
      { text: 'NO₃⁻', correct: false }
    ],
    explanation: 'The electrophile in nitration is NO₂⁺ (nitronium ion), generated from HNO₃ and H₂SO₄. The reaction is: HNO₃ + 2H₂SO₄ → NO₂⁺ + H₃O⁺ + 2HSO₄⁻.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which step is the rate-determining step in electrophilic aromatic substitution?',
    options: [
      { text: 'Formation of the electrophile', correct: false },
      { text: 'Formation of the σ-complex (arenium ion)', correct: true },
      { text: 'Deprotonation of the σ-complex', correct: false },
      { text: 'Regeneration of the catalyst', correct: false }
    ],
    explanation: 'The rate-determining step is the formation of the σ-complex (arenium ion) where the electrophile attacks benzene. This step is slow because it temporarily destroys aromaticity.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following are limitations of Friedel-Crafts alkylation?',
    options: [
      { text: 'Polyalkylation occurs', correct: true },
      { text: 'Carbocation rearrangement can occur', correct: true },
      { text: 'Does not work on deactivated rings', correct: true },
      { text: 'Requires high temperatures', correct: false }
    ],
    explanation: 'Friedel-Crafts alkylation has three major limitations: (1) Polyalkylation - product is more reactive (2) Carbocation rearrangement (3) Does not work on deactivated rings (NO₂, COOH, etc.).',
    points: 4,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.06,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'When n-propyl chloride reacts with benzene in the presence of AlCl₃, what is the major product?',
    options: [
      { text: 'n-Propylbenzene', correct: false },
      { text: 'Isopropylbenzene', correct: true },
      { text: 'Benzyl chloride', correct: false },
      { text: 'Cyclopropylbenzene', correct: false }
    ],
    explanation: 'The n-propyl carbocation (1°) rearranges to the more stable isopropyl carbocation (2°) via hydride shift. Therefore, isopropylbenzene is the major product, not n-propylbenzene.',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.5,
    guessing: 0.25,
    difficulty_level: 'hard'
  },
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why is Friedel-Crafts acylation preferred over alkylation for introducing alkyl groups?',
    options: [
      { text: 'Acylation is faster', correct: false },
      { text: 'Acylation has no polysubstitution or rearrangement problems', correct: true },
      { text: 'Acylation requires milder conditions', correct: false },
      { text: 'Acylation gives higher yields', correct: false }
    ],
    explanation: 'Friedel-Crafts acylation is preferred because: (1) Acylium ion is resonance stabilized (no rearrangement) (2) Ketone product is deactivated (no polyacylation). The ketone can then be reduced to give the alkyl group.',
    points: 4,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which catalyst is commonly used for halogenation of benzene?',
    options: [
      { text: 'H₂SO₄', correct: false },
      { text: 'FeBr₃ or AlCl₃', correct: true },
      { text: 'NaOH', correct: false },
      { text: 'Pt/C', correct: false }
    ],
    explanation: 'Halogenation of benzene requires a Lewis acid catalyst like FeBr₃, FeCl₃, AlBr₃, or AlCl₃. These generate the electrophilic X⁺ from X₂.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_7_2,
    question_type: 'true_false',
    question_text: 'Friedel-Crafts reactions work efficiently on nitrobenzene.',
    correct_answer: false,
    explanation: 'FALSE. Friedel-Crafts reactions (both alkylation and acylation) do NOT work on deactivated rings. Nitrobenzene is strongly deactivated by the -NO₂ group, which is a strong electron-withdrawing group.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.5,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Sulfonation of benzene is unique among EAS reactions because it is:',
    options: [
      { text: 'Irreversible', correct: false },
      { text: 'Reversible', correct: true },
      { text: 'Does not require a catalyst', correct: false },
      { text: 'Forms two products', correct: false }
    ],
    explanation: 'Sulfonation is the only EAS reaction that is REVERSIBLE. The -SO₃H group can be removed by heating with dilute H₂SO₄, making it useful for temporary blocking of positions.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  }
])

puts "✅ Quiz 7.2 created with 9 questions"

# ============================================================================
# LESSON 7.3: Directing Effects and Reactivity in Substituted Benzenes
# ============================================================================

lesson_7_3 = CourseLesson.create!(
  title: 'Directing Effects - Ortho/Para and Meta Directors, Reactivity Patterns',
  reading_time_minutes: 60,
  key_concepts: [
    'Ortho/Para directing groups',
    'Meta directing groups',
    'Activating vs deactivating groups',
    'Explanation using resonance and inductive effects',
    'Orientation in disubstituted benzenes'
  ],
  content: <<~MD
    # Directing Effects in Aromatic Substitution

    ## 1. Introduction to Directing Effects

    ### Substituents Influence EAS
    When benzene already has one substituent, it affects:
    1. **Reactivity:** How fast EAS occurs (activating/deactivating)
    2. **Orientation:** Where the next substituent goes (ortho/para or meta)

    ### Three Possible Positions
    ```
          Y (existing substituent)
          |
      ⬡
     /  \\
    |    |  (where does new substituent go?)
     \\  /
      ⬡

    Ortho: Positions 2 and 6 (adjacent to Y)
    Meta: Positions 3 and 5 (one carbon away)
    Para: Position 4 (opposite to Y)
    ```

    ---

    ## 2. Types of Directors

    ### A. Ortho/Para Directors
    Direct incoming electrophile to **ortho and para positions**.

    **Examples:**
    - **Activating (increase reactivity):**
      - -OH, -OR (alkoxy)
      - -NH₂, -NHR, -NR₂ (amino)
      - -NHCOCH₃ (acetamido)
      - Alkyl groups: -CH₃, -C₂H₅, etc.

    - **Deactivating (decrease reactivity):**
      - Halogens: -F, -Cl, -Br, -I

    ### B. Meta Directors
    Direct incoming electrophile to **meta position**.

    **All are deactivating (decrease reactivity):**
    - -NO₂ (nitro)
    - -CN (cyano)
    - -CHO (aldehyde)
    - -COR (ketone)
    - -COOH (carboxylic acid)
    - -COOR (ester)
    - -SO₃H (sulfonic acid)
    - -CF₃ (trifluoromethyl)
    - -NR₃⁺ (quaternary ammonium)

    ---

    ## 3. Summary Table

    | Group | Type | Orientation | Reactivity | Effect |
    |-------|------|-------------|------------|--------|
    | **-NH₂, -OH, -OR** | Strong activating | o/p | Very fast | +M >> -I |
    | **-NHCOCH₃** | Moderate activating | o/p | Moderate | +M > -I |
    | **-CH₃, alkyl** | Weak activating | o/p | Slightly fast | +I |
    | **-F, -Cl, -Br, -I** | Weak deactivating | o/p | Slow | -I > +M |
    | **-NO₂, -CN, -CHO, -COOH, -SO₃H** | Strong deactivating | m | Very slow | -M, -I |

    ---

    ## 4. Why Ortho/Para Direction?

    ### Electron-Donating Groups (+M, +I)
    Stabilize σ-complex at **ortho and para** positions through resonance.

    #### Example: Aniline (-NH₂)

    **Ortho attack:**
    ```
         NH₂           NH₂⁺          NH₂⁺          NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
        \\               \\               \\              \\
         E⁺              E              E              E

    Resonance structure with + charge on N
    → Extra stability (N can donate lone pair)
    ```

    **Para attack:**
    ```
         NH₂           NH₂⁺          NH₂⁺          NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
     |                |                |               |
     E⁺               E                E               E

    Resonance structure with + charge on N
    → Extra stability
    ```

    **Meta attack:**
    ```
         NH₂           NH₂           NH₂           NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
       \\              \\              \\             \\
        E⁺             E              E              E

    No resonance structure with + charge on N
    → Less stability
    ```

    **Conclusion:** o/p attack is favored because lone pair on N stabilizes σ-complex.

    ### Alkyl Groups (+I Effect)
    - **+I effect:** Donates electron density
    - Stabilizes positive charge at **o/p positions** more than meta
    - Example: Toluene (-CH₃ group)

    ---

    ## 5. Why Meta Direction?

    ### Electron-Withdrawing Groups (-M, -I)
    Destabilize σ-complex at **ortho and para** positions but meta is least destabilized.

    #### Example: Nitrobenzene (-NO₂)

    **Ortho attack:**
    ```
         NO₂           NO₂           NO₂⁺          NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
        \\               \\               \\              \\
         E⁺              E              E              E

    Resonance structure with + charge adjacent to NO₂
    → Highly unstable (two + charges close)
    ```

    **Para attack:**
    ```
         NO₂           NO₂           NO₂⁺          NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
     |                |                |               |
     E⁺               E                E               E

    Resonance structure with + charge on carbon bearing NO₂
    → Highly unstable
    ```

    **Meta attack:**
    ```
         NO₂           NO₂           NO₂           NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
       \\              \\              \\             \\
        E⁺             E              E              E

    No resonance structure with + charge adjacent to NO₂
    → Least destabilized (relatively)
    ```

    **Conclusion:** Meta attack is favored because it avoids placing + charge adjacent to electron-withdrawing group.

    ---

    ## 6. Special Case: Halogens

    ### Ortho/Para Directors but Deactivating

    **Why o/p directing?**
    - **+M effect (lone pair donation)** stabilizes o/p positions
    - Resonance effect dominates for **orientation**

    **Why deactivating?**
    - **-I effect (electronegativity)** withdraws electrons through σ bonds
    - Inductive effect dominates for **reactivity**

    **Net result:**
    - -I > +M → **Deactivating** (slower than benzene)
    - +M effect still operates → **o/p directing**

    **Order of reactivity:**
    ```
    -F is most deactivating (strongest -I, weakest +M)
    -I is least deactivating (weakest -I, strongest +M)

    Order: -F > -Cl > -Br > -I (deactivation)
    ```

    ---

    ## 7. Activating vs Deactivating Groups

    ### Activating Groups
    - **Make benzene MORE reactive** than unsubstituted benzene
    - **Stabilize σ-complex** (lower activation energy)
    - All are **ortho/para directors** (except none)

    **Order of activation:**
    ```
    -O⁻ > -NH₂ > -OH > -OR > -NHCOCH₃ > -CH₃ > -H (benzene)
    (strongest)                                    (reference)
    ```

    ### Deactivating Groups
    - **Make benzene LESS reactive** than unsubstituted benzene
    - **Destabilize σ-complex** (higher activation energy)
    - Most are **meta directors**
    - Exception: **Halogens are o/p directors** but deactivating

    **Order of deactivation:**
    ```
    -H (benzene) > -F > -Cl > -Br > -I > -COOH > -CHO > -NO₂ > -NR₃⁺
    (reference)                                              (strongest)
    ```

    ---

    ## 8. Orientation in Disubstituted Benzenes

    ### Rule 1: Activating Group Wins
    When two groups compete, the **more activating group** controls orientation.

    **Example:** p-Nitrotoluene
    ```
         CH₃ (o/p, activating)
          |
      ⬡
          |
         NO₂ (m, deactivating)

    -CH₃ is more activating → controls orientation
    → Electrophile goes ortho to -CH₃ (meta to -NO₂)
    ```

    ### Rule 2: When Both Are Activating
    If both are activating, **both direct** (may give mixture).

    **Example:** p-Cresol (p-methylphenol)
    ```
         OH (o/p, strong activating)
         |
     ⬡
         |
         CH₃ (o/p, weak activating)

    Both are activating, -OH is stronger
    → Major product: ortho and meta to -OH (ortho to -CH₃)
    ```

    ### Rule 3: Steric Effects
    - **Ortho position** to bulky groups is disfavored (steric hindrance)
    - **Para product** is often major when ortho is hindered

    ### Rule 4: When Both Are Deactivating
    - **Less deactivating group** controls
    - Reaction is very slow

    ---

    ## 9. Predicting Products

    ### Strategy
    1. **Identify existing substituent(s)**
    2. **Classify:** Activating/deactivating, o/p or meta directing
    3. **Apply rules:**
       - Activating group wins
       - o/p directors → ortho and para products
       - meta directors → meta products
    4. **Consider steric effects** (para favored if ortho is crowded)

    ### Example 1: Bromination of Toluene
    ```
    Toluene (-CH₃, o/p directing, activating)
    + Br₂/FeBr₃
    →
    Major products: o-Bromotoluene + p-Bromotoluene
    (ortho and para to -CH₃)
    ```

    ### Example 2: Nitration of Benzoic Acid
    ```
    Benzoic acid (-COOH, m directing, deactivating)
    + HNO₃/H₂SO₄
    →
    Major product: m-Nitrobenzoic acid
    (meta to -COOH)
    ```

    ### Example 3: Nitration of Chlorobenzene
    ```
    Chlorobenzene (-Cl, o/p directing, deactivating)
    + HNO₃/H₂SO₄
    →
    Major products: o-Nitrochlorobenzene + p-Nitrochlorobenzene
    (ortho and para to -Cl, but reaction is slower than benzene)
    ```

    ---

    ## 10. Blocking Positions

    ### Strategy for Selective Substitution
    Sometimes we need to "block" certain positions to control orientation.

    **Example: Synthesis of m-Bromonitrobenzene**

    **Wrong approach:**
    ```
    Benzene → Nitration → Nitrobenzene → Bromination → m-Bromonitrobenzene (✓)
    (NO₂ directs meta)
    ```

    **Right approach:**
    ```
    Benzene → Bromination → Bromobenzene → Nitration → o/p-Bromonitrobenzene (✗)
    (Br directs ortho/para, not meta!)
    ```

    **To get meta product:** Introduce meta-director FIRST.

    ---

    ## Important Points for IIT JEE

    1. **Memorize directors:**
       - o/p activating: -OH, -OR, -NH₂, -NHR, -CH₃
       - o/p deactivating: -F, -Cl, -Br, -I
       - m deactivating: -NO₂, -CHO, -COOH, -CN, -SO₃H

    2. **Orientation explanation:**
       - o/p directors stabilize σ-complex at o/p via +M or +I
       - m directors destabilize o/p more than meta via -M or -I

    3. **Halogens are special:**
       - o/p directing (due to +M)
       - But deactivating (due to -I > +M)

    4. **Reactivity order:**
       - Activated benzene > Benzene > Deactivated benzene
       - More activating = faster reaction

    5. **Disubstituted benzenes:**
       - More activating group controls orientation
       - Steric effects favor para over ortho

    ---

    ## Practice Questions

    1. Predict the major product of nitration of anisole (methoxybenzene).
    2. Why is chlorobenzene less reactive than benzene in EAS?
    3. Arrange in order of reactivity toward EAS: benzene, toluene, nitrobenzene.
    4. Explain why halogens are o/p directors but deactivating.
    5. How would you synthesize m-nitrochlorobenzene from benzene?
  MD
)

ModuleItem.create!(
  course_module: module_07,
  item: lesson_7_3,
  sequence_order: 5,
  required: true
)

puts "✅ Lesson 7.3 created"

# Create Quiz 7.3
quiz_7_3 = Quiz.create!(
  title: 'Quiz 7.3: Directing Effects and Reactivity',
  description: 'Test your understanding of ortho/para and meta directors, and reactivity patterns',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(
  course_module: module_07,
  item: quiz_7_3,
  sequence_order: 6,
  required: true
)

# Quiz 7.3 Questions
QuizQuestion.create!([
  {
    quiz: quiz_7_3,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following substituents are ortho/para directors?',
    options: [
      { text: '-OH (hydroxyl)', correct: true },
      { text: '-NO₂ (nitro)', correct: false },
      { text: '-CH₃ (methyl)', correct: true },
      { text: '-Cl (chloro)', correct: true }
    ],
    explanation: 'Ortho/para directors include: -OH, -OR, -NH₂, -NHR, -CH₃ (activating) and halogens -F, -Cl, -Br, -I (deactivating). -NO₂ is a meta director.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which group is a meta director and strongly deactivating?',
    options: [
      { text: '-CH₃', correct: false },
      { text: '-OH', correct: false },
      { text: '-NO₂', correct: true },
      { text: '-Cl', correct: false }
    ],
    explanation: '-NO₂ (nitro) is a strong meta director and strongly deactivating group due to its strong -M and -I effects. It makes the benzene ring much less reactive than benzene.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_7_3,
    question_type: 'sequence',
    question_text: 'Arrange the following compounds in order of INCREASING reactivity toward electrophilic aromatic substitution: (1) Benzene (2) Toluene (3) Nitrobenzene',
    sequence_items: [
      { id: 3, text: 'Nitrobenzene' },
      { id: 1, text: 'Benzene' },
      { id: 2, text: 'Toluene' }
    ],
    explanation: 'Nitrobenzene (least reactive, deactivated by -NO₂) < Benzene (reference) < Toluene (most reactive, activated by -CH₃). -CH₃ is activating, -NO₂ is strongly deactivating.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.17,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why are halogens (F, Cl, Br, I) ortho/para directors but deactivating?',
    options: [
      { text: 'They have only +M effect', correct: false },
      { text: '+M effect controls orientation, but -I effect dominates reactivity', correct: true },
      { text: 'They have only -I effect', correct: false },
      { text: 'They are actually meta directors', correct: false }
    ],
    explanation: 'Halogens show both -I effect (electron-withdrawing through σ bonds) and +M effect (lone pair donation). +M effect stabilizes o/p positions (orientation), but -I > +M overall, making them deactivating (reactivity).',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.5,
    guessing: 0.25,
    difficulty_level: 'hard'
  },
  {
    quiz: quiz_7_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'What is the major product when toluene undergoes nitration?',
    options: [
      { text: 'Only m-Nitrotoluene', correct: false },
      { text: 'Only o-Nitrotoluene', correct: false },
      { text: 'Mixture of o-Nitrotoluene and p-Nitrotoluene', correct: true },
      { text: 'Only p-Nitrotoluene', correct: false }
    ],
    explanation: 'Toluene has -CH₃ group which is an ortho/para director and activating. Nitration gives a mixture of o-nitrotoluene and p-nitrotoluene (with para usually predominating due to less steric hindrance).',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why does the -NH₂ group direct electrophiles to ortho and para positions?',
    options: [
      { text: 'It withdraws electrons from these positions', correct: false },
      { text: 'It stabilizes the σ-complex at o/p positions through resonance', correct: true },
      { text: 'It is sterically hindered at meta position', correct: false },
      { text: 'It has strong -I effect', correct: false }
    ],
    explanation: '-NH₂ has a lone pair that can donate into the ring (+M effect). At o/p positions, resonance structures place positive charge on N, which stabilizes the σ-complex. This is not possible for meta attack.',
    points: 4,
    difficulty: 0.4,
    discrimination: 1.4,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'When nitrobenzene undergoes bromination, what is the major product?',
    options: [
      { text: 'o-Bromonitrobenzene', correct: false },
      { text: 'm-Bromonitrobenzene', correct: true },
      { text: 'p-Bromonitrobenzene', correct: false },
      { text: 'Mixture of o- and p-bromonitrobenzene', correct: false }
    ],
    explanation: 'Nitrobenzene has -NO₂ group which is a strong meta director. Bromination gives m-bromonitrobenzene as the major product. The reaction is also very slow because -NO₂ is strongly deactivating.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'In a disubstituted benzene with one activating and one deactivating group, which group controls the orientation?',
    options: [
      { text: 'The deactivating group', correct: false },
      { text: 'The activating group', correct: true },
      { text: 'Both equally', correct: false },
      { text: 'The larger group', correct: false }
    ],
    explanation: 'When an activating and deactivating group compete, the MORE ACTIVATING group controls the orientation. The more activated positions react faster and determine where the new substituent goes.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium'
  },
  {
    quiz: quiz_7_3,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following is the MOST activating group?',
    options: [
      { text: '-CH₃', correct: false },
      { text: '-OH', correct: true },
      { text: '-Cl', correct: false },
      { text: '-COOH', correct: false }
    ],
    explanation: 'Order of activation: -O⁻ > -NH₂ > -OH > -OR > -NHCOCH₃ > -CH₃ > -H (benzene) > halogens > deactivating groups. Among the options, -OH is the most activating due to strong +M effect.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy'
  },
  {
    quiz: quiz_7_3,
    question_type: 'true_false',
    question_text: 'All meta directing groups are deactivating.',
    correct_answer: true,
    explanation: 'TRUE. All meta directors are deactivating groups. They include -NO₂, -CN, -CHO, -COR, -COOH, -COOR, -SO₃H, -CF₃, -NR₃⁺. These groups have strong -M and/or -I effects that deactivate the ring.',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.5,
    difficulty_level: 'easy'
  }
])

puts "✅ Quiz 7.3 created with 10 questions"

puts "\n" + "="*80
puts "Module 7: Aromatic Compounds Complete!"
puts "="*80
puts "✅ 3 comprehensive lessons covering:"
puts "   - Aromaticity and Huckel's rule"
puts "   - Electrophilic aromatic substitution mechanisms"
puts "   - Directing effects and reactivity patterns"
puts "✅ 3 quizzes with 29 questions total"
puts "="*80

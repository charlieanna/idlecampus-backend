# AUTO-GENERATED from module_13_amines.rb
puts "Creating Microlessons for Amines..."

module_var = CourseModule.find_by(slug: 'amines')

# === MICROLESSON 1: coupling — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'coupling — Practice',
  content: <<~MARKDOWN,
# coupling — Practice 🚀

C₆H₅N₂⁺Cl⁻ + C₆H₅OH → [NaOH] → p-HO-C₆H₄-N=N-C₆H₅ (p-Hydroxyazobenzene, orange colored azo dye). Coupling reaction.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['coupling'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Coupling of benzenediazonium chloride with phenol gives:',
    options: ['p-Hydroxyazobenzene (orange azo dye)', 'Benzene', 'Aniline', 'Benzoic acid'],
    correct_answer: 0,
    explanation: 'C₆H₅N₂⁺Cl⁻ + C₆H₅OH → [NaOH] → p-HO-C₆H₄-N=N-C₆H₅ (p-Hydroxyazobenzene, orange colored azo dye). Coupling reaction.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 2: Diazonium Salts - Preparation and Reactions ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Diazonium Salts - Preparation and Reactions',
  content: <<~MARKDOWN,
# Diazonium Salts - Preparation and Reactions 🚀

# Diazonium Salts

    ## Structure
    **General formula:** Ar-N₂⁺X⁻ (Arenediazonium salt)

    **Example:** C₆H₅-N₂⁺Cl⁻ (Benzenediazonium chloride)

    **Important:** Aliphatic diazonium salts are unstable. Only aromatic ones are stable.

    ## Preparation (Diazotization)
    ```
    C₆H₅-NH₂ + NaNO₂ + 2HCl → [0-5°C] → C₆H₅-N₂⁺Cl⁻ + NaCl + 2H₂O
    (Aniline)                           (Benzenediazonium chloride)
    ```

    **Conditions:** 0-5°C (ice-cold), otherwise decomposes

    ## Reactions

    ### Replacement of Diazo Group

    #### 1. Sandmeyer Reaction (CuX catalyst)
    ```
    C₆H₅-N₂⁺Cl⁻ + CuCl → C₆H₅-Cl + N₂ (Chlorobenzene)
    C₆H₅-N₂⁺Cl⁻ + CuBr → C₆H₅-Br + N₂ (Bromobenzene)
    C₆H₅-N₂⁺Cl⁻ + CuCN → C₆H₅-CN + N₂ (Benzonitrile)
    ```

    #### 2. Gattermann Reaction (Cu + HX)
    ```
    C₆H₅-N₂⁺Cl⁻ + Cu + HCl → C₆H₅-Cl + N₂
    ```

    #### 3. Replacement by -OH
    ```
    C₆H₅-N₂⁺Cl⁻ + H₂O → [warm] → C₆H₅-OH + N₂ + HCl (Phenol)
    ```

    #### 4. Replacement by -I
    ```
    C₆H₅-N₂⁺Cl⁻ + KI → C₆H₅-I + N₂ + KCl (Iodobenzene)
    ```

    #### 5. Replacement by -F (Balz-Schiemann)
    ```
    C₆H₅-N₂⁺BF₄⁻ → [heat] → C₆H₅-F + N₂ + BF₃ (Fluorobenzene)
    ```

    #### 6. Replacement by -H (Reduction)
    ```
    C₆H₅-N₂⁺Cl⁻ + H₃PO₂ + H₂O → C₆H₆ + N₂ + H₃PO₃ + HCl
    ```

    ### Coupling Reactions (Azo Dyes)

    **With Phenol:**
    ```
    C₆H₅-N₂⁺Cl⁻ + C₆H₅-OH → [NaOH, 273-278 K] → p-HO-C₆H₄-N=N-C₆H₅
                                                  (p-Hydroxyazobenzene - orange)
    ```

    **With Aniline:**
    ```
    C₆H₅-N₂⁺Cl⁻ + C₆H₅-NH₂ → [pH 4-5] → p-H₂N-C₆H₄-N=N-C₆H₅
                                         (p-Aminoazobenzene - yellow)
    ```

    **Products:** Azo compounds (colored dyes)

    ## Importance of Diazonium Salts
    1. **Convert aniline to other compounds:** Phenol, halobenzenes, benzonitrile
    2. **Introduce groups that cannot be introduced directly:** -F, -I, -CN, -OH
    3. **Synthesis of azo dyes:** Textile industry
    4. **Versatile intermediate:** Many transformations possible

    ## Summary of Key Reactions

    | Reagent | Product | Reaction Name |
    |---------|---------|---------------|
    | CuCl/CuBr | C₆H₅-Cl/Br | Sandmeyer |
    | CuCN | C₆H₅-CN | Sandmeyer |
    | Cu/HCl | C₆H₅-Cl | Gattermann |
    | H₂O (warm) | C₆H₅-OH | Hydrolysis |
    | KI | C₆H₅-I | Direct |
    | BF₄⁻ (heat) | C₆H₅-F | Balz-Schiemann |
    | H₃PO₂ | C₆H₆ | Reduction |
    | Phenol/Aniline | Azo dye | Coupling |

## Key Points

- Diazonium salts

- Diazotization

- Sandmeyer reaction
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Diazonium salts', 'Diazotization', 'Sandmeyer reaction', 'Gattermann reaction', 'Coupling reactions', 'Azo dyes'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Amines - Classification, Basicity, and Preparation ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Amines - Classification, Basicity, and Preparation',
  content: <<~MARKDOWN,
# Amines - Classification, Basicity, and Preparation 🚀

# Amines

    ## Classification
    **Amines:** Derivatives of ammonia (NH₃) where H atoms replaced by alkyl/aryl groups

    **Types:**
    1. **Primary (1°):** R-NH₂ (one H replaced)
    2. **Secondary (2°):** R₂NH (two H replaced)
    3. **Tertiary (3°):** R₃N (three H replaced)

    **Examples:**
    - CH₃NH₂ (Methylamine, 1°)
    - (CH₃)₂NH (Dimethylamine, 2°)
    - (CH₃)₃N (Trimethylamine, 3°)
    - C₆H₅NH₂ (Aniline, aromatic 1°)

    ## Basicity
    **Amines are basic** (lone pair on N accepts H⁺)
    ```
    R-NH₂ + H₂O ⇌ R-NH₃⁺ + OH⁻
    ```

    **Basicity order (Aliphatic):**
    ```
    (C₂H₅)₂NH > C₂H₅NH₂ > (C₂H₅)₃N > NH₃
    (2°)         (1°)         (3°)
    ```

    **Factors:**
    1. **+I effect:** Increases electron density on N
    2. **Steric hindrance:** Decreases stability of R-NH₃⁺ (3° most hindered)
    3. **Balance:** 2° amines are most basic

    **Aromatic Amines:**
    ```
    Aliphatic amines >> Aniline
    (pKb ≈ 3-4)         (pKb ≈ 9.4)
    ```

    **Why is aniline weakly basic?**
    - Lone pair on N delocalizes into benzene ring (+M effect)
    - Less available for protonation

    **Substituent effects on aniline:**
    - **EWG (-NO₂, -CN):** Decrease basicity (withdraw electrons)
    - **EDG (-CH₃, -OCH₃):** Increase basicity (donate electrons)

    **Order:** p-CH₃-C₆H₄-NH₂ > C₆H₅-NH₂ > p-NO₂-C₆H₄-NH₂

    ## Preparation
    ### 1. Reduction of Nitro Compounds
    ```
    R-NO₂ → [Sn/HCl or Fe/HCl] → R-NH₂ (1° amine)
    C₆H₅-NO₂ → [Sn/HCl] → C₆H₅-NH₂ (Aniline)
    ```

    ### 2. Reduction of Nitriles
    ```
    R-CN → [LiAlH₄ or H₂/Ni] → R-CH₂-NH₂ (1° amine)
    ```

    ### 3. Reduction of Amides
    ```
    R-CONH₂ → [LiAlH₄] → R-CH₂-NH₂
    ```

    ### 4. Gabriel Phthalimide Synthesis (1° amines only)
    ```
    Phthalimide + KOH → Phthalimide-K
    Phthalimide-K + R-X → N-alkylphthalimide
    N-alkylphthalimide + KOH → R-NH₂ + Phthalic acid
    ```

    **Advantage:** Pure 1° amines (no 2°/3° contamination)

    ### 5. Hoffmann Bromamide Degradation
    ```
    R-CONH₂ + Br₂/NaOH → R-NH₂ + CO₂
    ```

    **Note:** One carbon lost

    ### 6. Alkylation of Ammonia
    ```
    NH₃ + R-X → R-NH₂ + R₂NH + R₃N (mixture)
    ```

    **Limitation:** Gives mixture of 1°, 2°, 3° amines and quaternary salt

    ## Distinction Tests
    ### Hinsberg Test (with C₆H₅SO₂Cl)

    **1° Amine:**
    ```
    R-NH₂ + C₆H₅SO₂Cl → R-NH-SO₂-C₆H₅ (soluble in NaOH)
    ```

    **2° Amine:**
    ```
    R₂NH + C₆H₅SO₂Cl → R₂N-SO₂-C₆H₅ (insoluble in NaOH)
    ```

    **3° Amine:** No reaction

    ### Carbylamine Test (1° only)
    ```
    R-NH₂ + CHCl₃ + KOH → R-NC (isocyanide, foul smell)
    ```

    **Only 1° amines give positive test** (offensive smell)

## Key Points

- Amines

- Classification

- Basicity
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Amines', 'Classification', 'Basicity', 'Preparation', 'Gabriel phthalimide synthesis', 'Hoffmann bromamide'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Diazonium Salts - Preparation and Reactions ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Diazonium Salts - Preparation and Reactions',
  content: <<~MARKDOWN,
# Diazonium Salts - Preparation and Reactions 🚀

# Diazonium Salts

    ## Structure
    **General formula:** Ar-N₂⁺X⁻ (Arenediazonium salt)

    **Example:** C₆H₅-N₂⁺Cl⁻ (Benzenediazonium chloride)

    **Important:** Aliphatic diazonium salts are unstable. Only aromatic ones are stable.

    ## Preparation (Diazotization)
    ```
    C₆H₅-NH₂ + NaNO₂ + 2HCl → [0-5°C] → C₆H₅-N₂⁺Cl⁻ + NaCl + 2H₂O
    (Aniline)                           (Benzenediazonium chloride)
    ```

    **Conditions:** 0-5°C (ice-cold), otherwise decomposes

    ## Reactions

    ### Replacement of Diazo Group

    #### 1. Sandmeyer Reaction (CuX catalyst)
    ```
    C₆H₅-N₂⁺Cl⁻ + CuCl → C₆H₅-Cl + N₂ (Chlorobenzene)
    C₆H₅-N₂⁺Cl⁻ + CuBr → C₆H₅-Br + N₂ (Bromobenzene)
    C₆H₅-N₂⁺Cl⁻ + CuCN → C₆H₅-CN + N₂ (Benzonitrile)
    ```

    #### 2. Gattermann Reaction (Cu + HX)
    ```
    C₆H₅-N₂⁺Cl⁻ + Cu + HCl → C₆H₅-Cl + N₂
    ```

    #### 3. Replacement by -OH
    ```
    C₆H₅-N₂⁺Cl⁻ + H₂O → [warm] → C₆H₅-OH + N₂ + HCl (Phenol)
    ```

    #### 4. Replacement by -I
    ```
    C₆H₅-N₂⁺Cl⁻ + KI → C₆H₅-I + N₂ + KCl (Iodobenzene)
    ```

    #### 5. Replacement by -F (Balz-Schiemann)
    ```
    C₆H₅-N₂⁺BF₄⁻ → [heat] → C₆H₅-F + N₂ + BF₃ (Fluorobenzene)
    ```

    #### 6. Replacement by -H (Reduction)
    ```
    C₆H₅-N₂⁺Cl⁻ + H₃PO₂ + H₂O → C₆H₆ + N₂ + H₃PO₃ + HCl
    ```

    ### Coupling Reactions (Azo Dyes)

    **With Phenol:**
    ```
    C₆H₅-N₂⁺Cl⁻ + C₆H₅-OH → [NaOH, 273-278 K] → p-HO-C₆H₄-N=N-C₆H₅
                                                  (p-Hydroxyazobenzene - orange)
    ```

    **With Aniline:**
    ```
    C₆H₅-N₂⁺Cl⁻ + C₆H₅-NH₂ → [pH 4-5] → p-H₂N-C₆H₄-N=N-C₆H₅
                                         (p-Aminoazobenzene - yellow)
    ```

    **Products:** Azo compounds (colored dyes)

    ## Importance of Diazonium Salts
    1. **Convert aniline to other compounds:** Phenol, halobenzenes, benzonitrile
    2. **Introduce groups that cannot be introduced directly:** -F, -I, -CN, -OH
    3. **Synthesis of azo dyes:** Textile industry
    4. **Versatile intermediate:** Many transformations possible

    ## Summary of Key Reactions

    | Reagent | Product | Reaction Name |
    |---------|---------|---------------|
    | CuCl/CuBr | C₆H₅-Cl/Br | Sandmeyer |
    | CuCN | C₆H₅-CN | Sandmeyer |
    | Cu/HCl | C₆H₅-Cl | Gattermann |
    | H₂O (warm) | C₆H₅-OH | Hydrolysis |
    | KI | C₆H₅-I | Direct |
    | BF₄⁻ (heat) | C₆H₅-F | Balz-Schiemann |
    | H₃PO₂ | C₆H₆ | Reduction |
    | Phenol/Aniline | Azo dye | Coupling |

## Key Points

- Diazonium salts

- Diazotization

- Sandmeyer reaction
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Diazonium salts', 'Diazotization', 'Sandmeyer reaction', 'Gattermann reaction', 'Coupling reactions', 'Azo dyes'],
  prerequisite_ids: []
)

# === MICROLESSON 5: basicity — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'basicity — Practice',
  content: <<~MARKDOWN,
# basicity — Practice 🚀

Aliphatic amine basicity: (C₂H₅)₂NH > C₂H₅NH₂ > (C₂H₅)₃N > NH₃. 2° amine is most basic due to +I effect and less steric hindrance. Aniline is weakly basic.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['basicity'],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which is the most basic amine?',
    options: ['(C₂H₅)₂NH (2° aliphatic)', 'C₆H₅NH₂ (Aniline)', '(C₂H₅)₃N (3° aliphatic)', 'NH₃'],
    correct_answer: 0,
    explanation: 'Aliphatic amine basicity: (C₂H₅)₂NH > C₂H₅NH₂ > (C₂H₅)₃N > NH₃. 2° amine is most basic due to +I effect and less steric hindrance. Aniline is weakly basic.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: basicity — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'basicity — Practice',
  content: <<~MARKDOWN,
# basicity — Practice 🚀

Aniline\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['basicity'],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why is aniline less basic than aliphatic amines?',
    options: ['Lone pair delocalizes into benzene ring', 'Aniline is aromatic', 'Aniline has higher molecular weight', 'Nitrogen is sp³ in aniline'],
    correct_answer: 0,
    explanation: 'Aniline\',
    difficulty: 'easy'
  }
)

# === MICROLESSON 7: preparation — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'preparation — Practice',
  content: <<~MARKDOWN,
# preparation — Practice 🚀

Gabriel synthesis gives ONLY 1° amines (no 2°/3° contamination). Uses phthalimide + alkyl halide. Best method for pure 1° amines.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['preparation'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Gabriel phthalimide synthesis is used to prepare:',
    options: ['Pure 1° amines only', '2° amines only', '3° amines only', 'Mixture of all amines'],
    correct_answer: 0,
    explanation: 'Gabriel synthesis gives ONLY 1° amines (no 2°/3° contamination). Uses phthalimide + alkyl halide. Best method for pure 1° amines.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: tests — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'tests — Practice',
  content: <<~MARKDOWN,
# tests — Practice 🚀

Amine tests: (1) Hinsberg - all react differently ✓, (2) Carbylamine - only 1° positive ✓. Tollen\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['tests'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which tests distinguish 1°, 2°, 3° amines?',
    options: ['Hinsberg test (C₆H₅SO₂Cl)', 'Carbylamine test (CHCl₃/KOH)'],
    correct_answer: 1,
    explanation: 'Amine tests: (1) Hinsberg - all react differently ✓, (2) Carbylamine - only 1° positive ✓. Tollen\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: tests — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'tests — Practice',
  content: <<~MARKDOWN,
# tests — Practice 🚀

Carbylamine: R-NH₂ + CHCl₃ + KOH → R-NC (foul smell). ONLY 1° amines give offensive smell of isocyanide. 2° and 3° do not react.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['tests'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Carbylamine test is positive for:',
    options: ['1° amines only', '2° amines only', 'All amines', '3° amines only'],
    correct_answer: 0,
    explanation: 'Carbylamine: R-NH₂ + CHCl₃ + KOH → R-NC (foul smell). ONLY 1° amines give offensive smell of isocyanide. 2° and 3° do not react.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: preparation — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'preparation — Practice',
  content: <<~MARKDOWN,
# preparation — Practice 🚀

Diazotization: C₆H₅NH₂ + NaNO₂/HCl → [0-5°C] → C₆H₅N₂⁺Cl⁻. Must be kept ice-cold (0-5°C), otherwise decomposes.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['preparation'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Benzenediazonium chloride is prepared from aniline at:',
    options: ['0-5°C (ice-cold)', 'Room temperature', '100°C', '-20°C'],
    correct_answer: 0,
    explanation: 'Diazotization: C₆H₅NH₂ + NaNO₂/HCl → [0-5°C] → C₆H₅N₂⁺Cl⁻. Must be kept ice-cold (0-5°C), otherwise decomposes.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: sandmeyer — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'sandmeyer — Practice',
  content: <<~MARKDOWN,
# sandmeyer — Practice 🚀

Sandmeyer: C₆H₅N₂⁺Cl⁻ + CuX → C₆H₅X + N₂ (X = Cl, Br, CN). Uses copper(I) salts as catalyst. Best method for Cl, Br, CN.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['sandmeyer'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Sandmeyer reaction uses which catalyst?',
    options: ['CuCl/CuBr/CuCN', 'AlCl₃', 'FeBr₃', 'Ni'],
    correct_answer: 0,
    explanation: 'Sandmeyer: C₆H₅N₂⁺Cl⁻ + CuX → C₆H₅X + N₂ (X = Cl, Br, CN). Uses copper(I) salts as catalyst. Best method for Cl, Br, CN.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: balz_schiemann — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'balz_schiemann — Practice',
  content: <<~MARKDOWN,
# balz_schiemann — Practice 🚀

Balz-Schiemann: C₆H₅N₂⁺BF₄⁻ → [heat] → C₆H₅F + N₂ + BF₃. Best method for fluorobenzene. Sandmeyer does not work for F.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['balz_schiemann'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which reaction converts benzenediazonium salt to fluorobenzene?',
    options: ['Balz-Schiemann (diazonium fluoroborate, heat)', 'Sandmeyer (CuF)', 'Direct reaction with HF', 'Gattermann reaction'],
    correct_answer: 0,
    explanation: 'Balz-Schiemann: C₆H₅N₂⁺BF₄⁻ → [heat] → C₆H₅F + N₂ + BF₃. Best method for fluorobenzene. Sandmeyer does not work for F.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: importance — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'importance — Practice',
  content: <<~MARKDOWN,
# importance — Practice 🚀

Diazonium salts: (1) Convert to phenol, Cl, Br, I, CN, F ✓, (2) Form azo dyes ✓, (3) Versatile intermediate ✓. They are UNSTABLE at room temperature.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['importance'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Diazonium salts are important because they:',
    options: ['Convert aniline to phenol/halobenzenes', 'Form azo dyes by coupling', 'Introduce groups like -F, -CN, -I', 'Are very stable at room temperature'],
    correct_answer: 2,
    explanation: 'Diazonium salts: (1) Convert to phenol, Cl, Br, I, CN, F ✓, (2) Form azo dyes ✓, (3) Versatile intermediate ✓. They are UNSTABLE at room temperature.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: Amines - Classification, Basicity, and Preparation ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Amines - Classification, Basicity, and Preparation',
  content: <<~MARKDOWN,
# Amines - Classification, Basicity, and Preparation 🚀

# Amines

    ## Classification
    **Amines:** Derivatives of ammonia (NH₃) where H atoms replaced by alkyl/aryl groups

    **Types:**
    1. **Primary (1°):** R-NH₂ (one H replaced)
    2. **Secondary (2°):** R₂NH (two H replaced)
    3. **Tertiary (3°):** R₃N (three H replaced)

    **Examples:**
    - CH₃NH₂ (Methylamine, 1°)
    - (CH₃)₂NH (Dimethylamine, 2°)
    - (CH₃)₃N (Trimethylamine, 3°)
    - C₆H₅NH₂ (Aniline, aromatic 1°)

    ## Basicity
    **Amines are basic** (lone pair on N accepts H⁺)
    ```
    R-NH₂ + H₂O ⇌ R-NH₃⁺ + OH⁻
    ```

    **Basicity order (Aliphatic):**
    ```
    (C₂H₅)₂NH > C₂H₅NH₂ > (C₂H₅)₃N > NH₃
    (2°)         (1°)         (3°)
    ```

    **Factors:**
    1. **+I effect:** Increases electron density on N
    2. **Steric hindrance:** Decreases stability of R-NH₃⁺ (3° most hindered)
    3. **Balance:** 2° amines are most basic

    **Aromatic Amines:**
    ```
    Aliphatic amines >> Aniline
    (pKb ≈ 3-4)         (pKb ≈ 9.4)
    ```

    **Why is aniline weakly basic?**
    - Lone pair on N delocalizes into benzene ring (+M effect)
    - Less available for protonation

    **Substituent effects on aniline:**
    - **EWG (-NO₂, -CN):** Decrease basicity (withdraw electrons)
    - **EDG (-CH₃, -OCH₃):** Increase basicity (donate electrons)

    **Order:** p-CH₃-C₆H₄-NH₂ > C₆H₅-NH₂ > p-NO₂-C₆H₄-NH₂

    ## Preparation
    ### 1. Reduction of Nitro Compounds
    ```
    R-NO₂ → [Sn/HCl or Fe/HCl] → R-NH₂ (1° amine)
    C₆H₅-NO₂ → [Sn/HCl] → C₆H₅-NH₂ (Aniline)
    ```

    ### 2. Reduction of Nitriles
    ```
    R-CN → [LiAlH₄ or H₂/Ni] → R-CH₂-NH₂ (1° amine)
    ```

    ### 3. Reduction of Amides
    ```
    R-CONH₂ → [LiAlH₄] → R-CH₂-NH₂
    ```

    ### 4. Gabriel Phthalimide Synthesis (1° amines only)
    ```
    Phthalimide + KOH → Phthalimide-K
    Phthalimide-K + R-X → N-alkylphthalimide
    N-alkylphthalimide + KOH → R-NH₂ + Phthalic acid
    ```

    **Advantage:** Pure 1° amines (no 2°/3° contamination)

    ### 5. Hoffmann Bromamide Degradation
    ```
    R-CONH₂ + Br₂/NaOH → R-NH₂ + CO₂
    ```

    **Note:** One carbon lost

    ### 6. Alkylation of Ammonia
    ```
    NH₃ + R-X → R-NH₂ + R₂NH + R₃N (mixture)
    ```

    **Limitation:** Gives mixture of 1°, 2°, 3° amines and quaternary salt

    ## Distinction Tests
    ### Hinsberg Test (with C₆H₅SO₂Cl)

    **1° Amine:**
    ```
    R-NH₂ + C₆H₅SO₂Cl → R-NH-SO₂-C₆H₅ (soluble in NaOH)
    ```

    **2° Amine:**
    ```
    R₂NH + C₆H₅SO₂Cl → R₂N-SO₂-C₆H₅ (insoluble in NaOH)
    ```

    **3° Amine:** No reaction

    ### Carbylamine Test (1° only)
    ```
    R-NH₂ + CHCl₃ + KOH → R-NC (isocyanide, foul smell)
    ```

    **Only 1° amines give positive test** (offensive smell)

## Key Points

- Amines

- Classification

- Basicity
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Amines', 'Classification', 'Basicity', 'Preparation', 'Gabriel phthalimide synthesis', 'Hoffmann bromamide'],
  prerequisite_ids: []
)

puts "✓ Created 14 microlessons for Amines"

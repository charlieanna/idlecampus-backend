# AUTO-GENERATED from module_12_carboxylic_acids_derivatives.rb
puts "Creating Microlessons for Carboxylic Acids Derivatives..."

module_var = CourseModule.find_by(slug: 'carboxylic-acids-derivatives')

# === MICROLESSON 1: ester_reactions — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'ester_reactions — Practice',
  content: <<~MARKDOWN,
# ester_reactions — Practice 🚀

R-COOR\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['ester_reactions'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Reaction of 2 moles of Grignard reagent with ester gives:',
    options: ['Tertiary alcohol', 'Secondary alcohol', 'Primary alcohol', 'Ketone'],
    correct_answer: 0,
    explanation: 'R-COOR\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: Acid Derivatives - Comparative Reactivity ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Acid Derivatives - Comparative Reactivity',
  content: <<~MARKDOWN,
# Acid Derivatives - Comparative Reactivity 🚀

# Acid Derivatives

    ## Types of Acid Derivatives
    1. **Acid Chlorides:** R-COCl
    2. **Acid Anhydrides:** (R-CO)₂O
    3. **Esters:** R-COOR'
    4. **Amides:** R-CONH₂

    ## Reactivity Order (Nucleophilic Acyl Substitution)
    ```
    Acid Chloride > Acid Anhydride > Ester > Amide > Carboxylate ion
    (Most reactive)                              (Least reactive)
    ```

    **Reason:** Leaving group ability and resonance stabilization

    ## Acid Chlorides (R-COCl)
    **Most reactive** acid derivative

    **Reactions:**
    1. **Hydrolysis:** R-COCl + H₂O → R-COOH + HCl
    2. **Alcoholysis:** R-COCl + R'-OH → R-COOR' + HCl (ester)
    3. **Ammonolysis:** R-COCl + 2NH₃ → R-CONH₂ + NH₄Cl (amide)
    4. **Reduction (Rosenmund):** R-COCl + H₂ → [Pd-BaSO₄] → R-CHO

    ## Acid Anhydrides ((R-CO)₂O)
    **Less reactive than acid chlorides**

    **Reactions:** Similar to acid chlorides but slower
    - (CH₃CO)₂O + H₂O → 2CH₃COOH
    - (CH₃CO)₂O + ROH → CH₃COOR + CH₃COOH

    ## Esters (R-COOR')
    **Pleasant fruity smell**

    **Preparation:**
    1. **Fischer esterification:** R-COOH + R'-OH → [H⁺] → R-COOR' + H₂O
    2. **From acid chlorides:** R-COCl + R'-OH → R-COOR' + HCl

    **Reactions:**
    1. **Hydrolysis (acidic):** R-COOR' + H₂O → [H⁺] → R-COOH + R'-OH
    2. **Saponification (basic):** R-COOR' + NaOH → R-COONa + R'-OH
    3. **Reduction:** R-COOR' → [LiAlH₄] → R-CH₂OH + R'-OH
    4. **Grignard (2 moles):** R-COOR' + 2R"-MgX → R-C(OH)(R")₂ (3° alcohol)

    **Claisen Condensation:**
    ```
    2CH₃COOR → [Base] → CH₃COCH₂COOR + ROH (β-ketoester)
    ```

    ## Amides (R-CONH₂)
    **Least reactive** derivative

    **Preparation:**
    - R-COCl + 2NH₃ → R-CONH₂ + NH₄Cl
    - R-COOH + NH₃ → [heat] → R-CONH₂ + H₂O

    **Reactions:**
    1. **Hydrolysis:** R-CONH₂ + H₂O → [H⁺/OH⁻] → R-COOH + NH₃
    2. **Dehydration:** R-CONH₂ → [P₂O₅] → R-CN (nitrile)
    3. **Hoffmann bromamide:** R-CONH₂ + Br₂/NaOH → R-NH₂ + CO₂ (amine, -1 carbon)
    4. **Reduction:** R-CONH₂ → [LiAlH₄] → R-CH₂-NH₂

    ## Key Differences

    | Property | Acid Chloride | Anhydride | Ester | Amide |
    |----------|---------------|-----------|-------|-------|
    | Reactivity | Highest | High | Moderate | Lowest |
    | Smell | Pungent | Pungent | Pleasant | Odorless |
    | Hydrolysis | Very fast | Fast | Slow | Very slow |
    | Leaving group | Cl⁻ (good) | RCOO⁻ | RO⁻ | NH₂⁻ (poor) |

## Key Points

- Acid chlorides

- Acid anhydrides

- Esters
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Acid chlorides', 'Acid anhydrides', 'Esters', 'Amides', 'Reactivity order', 'Nucleophilic acyl substitution'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Carboxylic Acids - Structure, Acidity, and Reactions ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Carboxylic Acids - Structure, Acidity, and Reactions',
  content: <<~MARKDOWN,
# Carboxylic Acids - Structure, Acidity, and Reactions 🚀

# Carboxylic Acids

    ## Structure and Nomenclature
    **General formula:** R-COOH
    **Functional group:** -COOH (carboxyl group = carbonyl + hydroxyl)

    **IUPAC:** Replace -e with -oic acid
    - CH₃COOH: Ethanoic acid (Acetic acid)
    - CH₃CH₂COOH: Propanoic acid (Propionic acid)
    - C₆H₅COOH: Benzoic acid

    ## Acidity
    **Most acidic organic compounds (pKa ≈ 4-5)**

    **Reason:** Resonance stabilization of carboxylate anion (RCOO⁻)
    ```
    R-C(=O)-O⁻ ⟷ R-C(-O)=O
    (Two equivalent resonance structures)
    ```

    **Factors Affecting Acidity:**
    1. **-I groups increase acidity:** Cl₃CCOOH > Cl₂CHCOOH > ClCH₂COOH > CH₃COOH
    2. **+I groups decrease acidity:** CH₃COOH > CH₃CH₂COOH > (CH₃)₂CHCOOH
    3. **Aromatic acids:** C₆H₅COOH (pKa 4.2) > CH₃COOH (pKa 4.8)

    **Acidity order:** HCOOH > C₆H₅COOH > CH₃COOH > H₂O > ROH

    ## Preparation
    1. **Oxidation of 1° alcohols/aldehydes:**
       ```
       R-CH₂OH → [K₂Cr₂O₇/H⁺] → R-COOH
       R-CHO → [KMnO₄/H⁺] → R-COOH
       ```

    2. **Hydrolysis of nitriles:**
       ```
       R-CN + H₂O → [H⁺ or OH⁻] → R-COOH
       ```

    3. **Grignard + CO₂:**
       ```
       R-MgX + CO₂ → R-COO⁻MgX → [H₃O⁺] → R-COOH
       ```

    4. **From alkylbenzenes:**
       ```
       C₆H₅-CH₃ → [KMnO₄/H⁺] → C₆H₅-COOH
       ```

    ## Important Reactions
    1. **Formation of salts:** R-COOH + NaOH → R-COONa + H₂O
    2. **Acid chloride:** R-COOH + SOCl₂ → R-COCl + SO₂ + HCl
    3. **Esterification:** R-COOH + R'-OH → [H₂SO₄] → R-COOR' + H₂O
    4. **Reduction:** R-COOH → [LiAlH₄] → R-CH₂OH
    5. **Hell-Volhard-Zelinsky:** R-CH₂-COOH + Br₂/P → R-CHBr-COOH (α-halogenation)
    6. **Decarboxylation:** R-COONa + NaOH → [CaO, heat] → R-H + Na₂CO₃

## Key Points

- Carboxylic acids

- IUPAC nomenclature

- Acidity
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Carboxylic acids', 'IUPAC nomenclature', 'Acidity', 'Hydrogen bonding', 'Preparation', 'Hell-Volhard-Zelinsky reaction'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Acid Derivatives - Comparative Reactivity ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Acid Derivatives - Comparative Reactivity',
  content: <<~MARKDOWN,
# Acid Derivatives - Comparative Reactivity 🚀

# Acid Derivatives

    ## Types of Acid Derivatives
    1. **Acid Chlorides:** R-COCl
    2. **Acid Anhydrides:** (R-CO)₂O
    3. **Esters:** R-COOR'
    4. **Amides:** R-CONH₂

    ## Reactivity Order (Nucleophilic Acyl Substitution)
    ```
    Acid Chloride > Acid Anhydride > Ester > Amide > Carboxylate ion
    (Most reactive)                              (Least reactive)
    ```

    **Reason:** Leaving group ability and resonance stabilization

    ## Acid Chlorides (R-COCl)
    **Most reactive** acid derivative

    **Reactions:**
    1. **Hydrolysis:** R-COCl + H₂O → R-COOH + HCl
    2. **Alcoholysis:** R-COCl + R'-OH → R-COOR' + HCl (ester)
    3. **Ammonolysis:** R-COCl + 2NH₃ → R-CONH₂ + NH₄Cl (amide)
    4. **Reduction (Rosenmund):** R-COCl + H₂ → [Pd-BaSO₄] → R-CHO

    ## Acid Anhydrides ((R-CO)₂O)
    **Less reactive than acid chlorides**

    **Reactions:** Similar to acid chlorides but slower
    - (CH₃CO)₂O + H₂O → 2CH₃COOH
    - (CH₃CO)₂O + ROH → CH₃COOR + CH₃COOH

    ## Esters (R-COOR')
    **Pleasant fruity smell**

    **Preparation:**
    1. **Fischer esterification:** R-COOH + R'-OH → [H⁺] → R-COOR' + H₂O
    2. **From acid chlorides:** R-COCl + R'-OH → R-COOR' + HCl

    **Reactions:**
    1. **Hydrolysis (acidic):** R-COOR' + H₂O → [H⁺] → R-COOH + R'-OH
    2. **Saponification (basic):** R-COOR' + NaOH → R-COONa + R'-OH
    3. **Reduction:** R-COOR' → [LiAlH₄] → R-CH₂OH + R'-OH
    4. **Grignard (2 moles):** R-COOR' + 2R"-MgX → R-C(OH)(R")₂ (3° alcohol)

    **Claisen Condensation:**
    ```
    2CH₃COOR → [Base] → CH₃COCH₂COOR + ROH (β-ketoester)
    ```

    ## Amides (R-CONH₂)
    **Least reactive** derivative

    **Preparation:**
    - R-COCl + 2NH₃ → R-CONH₂ + NH₄Cl
    - R-COOH + NH₃ → [heat] → R-CONH₂ + H₂O

    **Reactions:**
    1. **Hydrolysis:** R-CONH₂ + H₂O → [H⁺/OH⁻] → R-COOH + NH₃
    2. **Dehydration:** R-CONH₂ → [P₂O₅] → R-CN (nitrile)
    3. **Hoffmann bromamide:** R-CONH₂ + Br₂/NaOH → R-NH₂ + CO₂ (amine, -1 carbon)
    4. **Reduction:** R-CONH₂ → [LiAlH₄] → R-CH₂-NH₂

    ## Key Differences

    | Property | Acid Chloride | Anhydride | Ester | Amide |
    |----------|---------------|-----------|-------|-------|
    | Reactivity | Highest | High | Moderate | Lowest |
    | Smell | Pungent | Pungent | Pleasant | Odorless |
    | Hydrolysis | Very fast | Fast | Slow | Very slow |
    | Leaving group | Cl⁻ (good) | RCOO⁻ | RO⁻ | NH₂⁻ (poor) |

## Key Points

- Acid chlorides

- Acid anhydrides

- Esters
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Acid chlorides', 'Acid anhydrides', 'Esters', 'Amides', 'Reactivity order', 'Nucleophilic acyl substitution'],
  prerequisite_ids: []
)

# === MICROLESSON 5: acidity — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'acidity — Practice',
  content: <<~MARKDOWN,
# acidity — Practice 🚀

More Cl (EWG) → stronger acid. Order: CH₃ < ClCH₂ < Cl₂CH < Cl₃C.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['acidity'],
  prerequisite_ids: []
)

# Exercise 5.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange in order of INCREASING acidity: (1) CH₃COOH (2) ClCH₂COOH (3) Cl₂CHCOOH (4) Cl₃CCOOH',
    answer: '',
    explanation: 'More Cl (EWG) → stronger acid. Order: CH₃ < ClCH₂ < Cl₂CH < Cl₃C.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 6: acidity — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'acidity — Practice',
  content: <<~MARKDOWN,
# acidity — Practice 🚀

CH₃COO⁻ is resonance-stabilized (2 equivalent structures). C₂H₅O⁻ has no resonance. pKa: CH₃COOH (4.8) < C₂H₅OH (16).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['acidity'],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why is acetic acid more acidic than ethanol?',
    options: ['Resonance stabilization of acetate ion', 'Ethanol forms H-bonds', 'Acetic acid has higher MW', 'Ethanol is basic'],
    correct_answer: 0,
    explanation: 'CH₃COO⁻ is resonance-stabilized (2 equivalent structures). C₂H₅O⁻ has no resonance. pKa: CH₃COOH (4.8) < C₂H₅OH (16).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 7: reactions — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'reactions — Practice',
  content: <<~MARKDOWN,
# reactions — Practice 🚀

HVZ: R-CH₂-COOH + Br₂/P → R-CHBr-COOH (α-halogenation). Halogen goes to carbon adjacent to -COOH.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['reactions'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Hell-Volhard-Zelinsky reaction introduces halogen at:',
    options: ['α-position', 'β-position', 'Carboxyl group', 'Any position'],
    correct_answer: 0,
    explanation: 'HVZ: R-CH₂-COOH + Br₂/P → R-CHBr-COOH (α-halogenation). Halogen goes to carbon adjacent to -COOH.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: reactions — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'reactions — Practice',
  content: <<~MARKDOWN,
# reactions — Practice 🚀

R-COOH → R-COCl using: SOCl₂ (best), PCl₅, or PCl₃. NaCl does not work.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['reactions'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which reagents convert carboxylic acids to acid chlorides?',
    options: ['SOCl₂ (Thionyl chloride)', 'PCl₅', 'PCl₃', 'NaCl'],
    correct_answer: 2,
    explanation: 'R-COOH → R-COCl using: SOCl₂ (best), PCl₅, or PCl₃. NaCl does not work.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: reactions — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'reactions — Practice',
  content: <<~MARKDOWN,
# reactions — Practice 🚀

R-COOH → [LiAlH₄] → R-CH₂-OH (1° alcohol). LiAlH₄ is strong reducing agent.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['reactions'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Reduction of carboxylic acid with LiAlH₄ gives:',
    options: ['Primary alcohol', 'Secondary alcohol', 'Aldehyde', 'Ketone'],
    correct_answer: 0,
    explanation: 'R-COOH → [LiAlH₄] → R-CH₂-OH (1° alcohol). LiAlH₄ is strong reducing agent.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: reactivity — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'reactivity — Practice',
  content: <<~MARKDOWN,
# reactivity — Practice 🚀

Reactivity: Amide < Ester < Anhydride < Acid chloride. Based on leaving group ability.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['reactivity'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange in order of INCREASING reactivity in nucleophilic acyl substitution: (1) Amide (2) Ester (3) Acid chloride (4) Anhydride',
    answer: '',
    explanation: 'Reactivity: Amide < Ester < Anhydride < Acid chloride. Based on leaving group ability.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: amides — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'amides — Practice',
  content: <<~MARKDOWN,
# amides — Practice 🚀

Hoffmann: R-CONH₂ + Br₂/NaOH → R-NH₂ + CO₂. Amide loses -CO₂, giving amine with one less carbon.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['amides'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Hoffmann bromamide degradation converts:',
    options: ['Amide to amine (with loss of one carbon)', 'Amine to amide', 'Acid to amine', 'Ester to amide'],
    correct_answer: 0,
    explanation: 'Hoffmann: R-CONH₂ + Br₂/NaOH → R-NH₂ + CO₂. Amide loses -CO₂, giving amine with one less carbon.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 12: esters — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'esters — Practice',
  content: <<~MARKDOWN,
# esters — Practice 🚀

Saponification: R-COOR\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['esters'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Saponification is:',
    options: ['Alkaline hydrolysis of esters', 'Acidic hydrolysis of esters', 'Reduction of esters', 'Oxidation of alcohols'],
    correct_answer: 0,
    explanation: 'Saponification: R-COOR\',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: ester_synthesis — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'ester_synthesis — Practice',
  content: <<~MARKDOWN,
# ester_synthesis — Practice 🚀

Ester formation: (1) Acid + alcohol (Fischer) ✓, (2) Acid chloride + alcohol ✓, (3) Anhydride + alcohol ✓. Amide + alcohol does not give ester.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['ester_synthesis'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which can be converted to esters?',
    options: ['Carboxylic acid + alcohol', 'Acid chloride + alcohol', 'Anhydride + alcohol', 'Amide + alcohol'],
    correct_answer: 2,
    explanation: 'Ester formation: (1) Acid + alcohol (Fischer) ✓, (2) Acid chloride + alcohol ✓, (3) Anhydride + alcohol ✓. Amide + alcohol does not give ester.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: Carboxylic Acids - Structure, Acidity, and Reactions ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Carboxylic Acids - Structure, Acidity, and Reactions',
  content: <<~MARKDOWN,
# Carboxylic Acids - Structure, Acidity, and Reactions 🚀

# Carboxylic Acids

    ## Structure and Nomenclature
    **General formula:** R-COOH
    **Functional group:** -COOH (carboxyl group = carbonyl + hydroxyl)

    **IUPAC:** Replace -e with -oic acid
    - CH₃COOH: Ethanoic acid (Acetic acid)
    - CH₃CH₂COOH: Propanoic acid (Propionic acid)
    - C₆H₅COOH: Benzoic acid

    ## Acidity
    **Most acidic organic compounds (pKa ≈ 4-5)**

    **Reason:** Resonance stabilization of carboxylate anion (RCOO⁻)
    ```
    R-C(=O)-O⁻ ⟷ R-C(-O)=O
    (Two equivalent resonance structures)
    ```

    **Factors Affecting Acidity:**
    1. **-I groups increase acidity:** Cl₃CCOOH > Cl₂CHCOOH > ClCH₂COOH > CH₃COOH
    2. **+I groups decrease acidity:** CH₃COOH > CH₃CH₂COOH > (CH₃)₂CHCOOH
    3. **Aromatic acids:** C₆H₅COOH (pKa 4.2) > CH₃COOH (pKa 4.8)

    **Acidity order:** HCOOH > C₆H₅COOH > CH₃COOH > H₂O > ROH

    ## Preparation
    1. **Oxidation of 1° alcohols/aldehydes:**
       ```
       R-CH₂OH → [K₂Cr₂O₇/H⁺] → R-COOH
       R-CHO → [KMnO₄/H⁺] → R-COOH
       ```

    2. **Hydrolysis of nitriles:**
       ```
       R-CN + H₂O → [H⁺ or OH⁻] → R-COOH
       ```

    3. **Grignard + CO₂:**
       ```
       R-MgX + CO₂ → R-COO⁻MgX → [H₃O⁺] → R-COOH
       ```

    4. **From alkylbenzenes:**
       ```
       C₆H₅-CH₃ → [KMnO₄/H⁺] → C₆H₅-COOH
       ```

    ## Important Reactions
    1. **Formation of salts:** R-COOH + NaOH → R-COONa + H₂O
    2. **Acid chloride:** R-COOH + SOCl₂ → R-COCl + SO₂ + HCl
    3. **Esterification:** R-COOH + R'-OH → [H₂SO₄] → R-COOR' + H₂O
    4. **Reduction:** R-COOH → [LiAlH₄] → R-CH₂OH
    5. **Hell-Volhard-Zelinsky:** R-CH₂-COOH + Br₂/P → R-CHBr-COOH (α-halogenation)
    6. **Decarboxylation:** R-COONa + NaOH → [CaO, heat] → R-H + Na₂CO₃

## Key Points

- Carboxylic acids

- IUPAC nomenclature

- Acidity
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Carboxylic acids', 'IUPAC nomenclature', 'Acidity', 'Hydrogen bonding', 'Preparation', 'Hell-Volhard-Zelinsky reaction'],
  prerequisite_ids: []
)

puts "✓ Created 14 microlessons for Carboxylic Acids Derivatives"

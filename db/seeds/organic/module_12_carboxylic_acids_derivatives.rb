# frozen_string_literal: true

puts "\n" + "=" * 80
puts "MODULE 12: CARBOXYLIC ACIDS AND DERIVATIVES"
puts "=" * 80

course = Course.find_or_create_by!(slug: 'iit-jee-organic-chemistry') do |c|
  c.title = 'IIT JEE Organic Chemistry'
  c.description = 'Comprehensive Organic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty = 'advanced'
  c.estimated_hours = 150
  c.published = true
end

module_12 = course.course_modules.find_or_create_by!(slug: 'carboxylic-acids-derivatives') do |m|
  m.title = 'Carboxylic Acids and Derivatives'
  m.sequence_order = 12
  m.estimated_minutes = 960  # 16 hours
  m.description = 'Carboxylic acids and their derivatives: nomenclature, preparation, acidity, and reactions'
  m.learning_objectives = [
    'Master nomenclature and structure of carboxylic acids',
    'Understand acidity and factors affecting it',
    'Learn preparation methods and important reactions',
    'Master chemistry of acid derivatives (chlorides, anhydrides, esters, amides)',
    'Understand relative reactivity of acid derivatives',
    'Solve IIT JEE problems on mechanisms and conversions'
  ]
  m.published = true
end

puts "✅ Module 12: #{module_12.title}"

lesson_12_1 = CourseLesson.create!(
  title: 'Carboxylic Acids - Structure, Acidity, and Reactions',
  reading_time_minutes: 60,
  key_concepts: ['Carboxylic acids', 'IUPAC nomenclature', 'Acidity', 'Hydrogen bonding', 'Preparation', 'Hell-Volhard-Zelinsky reaction'],
  content: <<~MD
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
  MD
)

ModuleItem.create!(course_module: module_12, item: lesson_12_1, sequence_order: 1, required: true)
puts "  ✓ Lesson 12.1: #{lesson_12_1.title}"

quiz_12_1 = Quiz.create!(
  title: 'Carboxylic Acids - Acidity and Reactions',
  description: 'Test your understanding of carboxylic acids',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_12, item: quiz_12_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {quiz: quiz_12_1, question_type: 'sequence', question_text: 'Arrange in order of INCREASING acidity: (1) CH₃COOH (2) ClCH₂COOH (3) Cl₂CHCOOH (4) Cl₃CCOOH',
   sequence_items: [{id: 1, text: 'CH₃COOH'}, {id: 2, text: 'ClCH₂COOH'}, {id: 3, text: 'Cl₂CHCOOH'}, {id: 4, text: 'Cl₃CCOOH'}],
   explanation: 'More Cl (EWG) → stronger acid. Order: CH₃ < ClCH₂ < Cl₂CH < Cl₃C.', points: 4, difficulty: 0.2, discrimination: 1.3, guessing: 0.04, difficulty_level: 'medium', topic: 'acidity', skill_dimension: 'application', sequence_order: 1},
  
  {quiz: quiz_12_1, question_type: 'mcq', multiple_correct: false, question_text: 'Why is acetic acid more acidic than ethanol?',
   options: [{text: 'Resonance stabilization of acetate ion', correct: true}, {text: 'Ethanol forms H-bonds', correct: false}, {text: 'Acetic acid has higher MW', correct: false}, {text: 'Ethanol is basic', correct: false}],
   explanation: 'CH₃COO⁻ is resonance-stabilized (2 equivalent structures). C₂H₅O⁻ has no resonance. pKa: CH₃COOH (4.8) < C₂H₅OH (16).', points: 2, difficulty: 0.0, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'acidity', skill_dimension: 'comprehension', sequence_order: 2},
  
  {quiz: quiz_12_1, question_type: 'mcq', multiple_correct: false, question_text: 'Hell-Volhard-Zelinsky reaction introduces halogen at:',
   options: [{text: 'α-position', correct: true}, {text: 'β-position', correct: false}, {text: 'Carboxyl group', correct: false}, {text: 'Any position', correct: false}],
   explanation: 'HVZ: R-CH₂-COOH + Br₂/P → R-CHBr-COOH (α-halogenation). Halogen goes to carbon adjacent to -COOH.', points: 2, difficulty: 0.0, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'reactions', skill_dimension: 'recall', sequence_order: 3},
  
  {quiz: quiz_12_1, question_type: 'mcq', multiple_correct: true, question_text: 'Which reagents convert carboxylic acids to acid chlorides?',
   options: [{text: 'SOCl₂ (Thionyl chloride)', correct: true}, {text: 'PCl₅', correct: true}, {text: 'PCl₃', correct: true}, {text: 'NaCl', correct: false}],
   explanation: 'R-COOH → R-COCl using: SOCl₂ (best), PCl₅, or PCl₃. NaCl does not work.', points: 4, difficulty: 0.2, discrimination: 1.2, guessing: 0.0, difficulty_level: 'medium', topic: 'reactions', skill_dimension: 'recall', sequence_order: 4},
  
  {quiz: quiz_12_1, question_type: 'mcq', multiple_correct: false, question_text: 'Reduction of carboxylic acid with LiAlH₄ gives:',
   options: [{text: 'Primary alcohol', correct: true}, {text: 'Secondary alcohol', correct: false}, {text: 'Aldehyde', correct: false}, {text: 'Ketone', correct: false}],
   explanation: 'R-COOH → [LiAlH₄] → R-CH₂-OH (1° alcohol). LiAlH₄ is strong reducing agent.', points: 2, difficulty: -0.1, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'reactions', skill_dimension: 'recall', sequence_order: 5}
])

puts "  ✓ Quiz 12.1: #{quiz_12_1.title} (#{quiz_12_1.quiz_questions.count} questions)"

lesson_12_2 = CourseLesson.create!(
  title: 'Acid Derivatives - Comparative Reactivity',
  reading_time_minutes: 55,
  key_concepts: ['Acid chlorides', 'Acid anhydrides', 'Esters', 'Amides', 'Reactivity order', 'Nucleophilic acyl substitution'],
  content: <<~MD
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
  MD
)

ModuleItem.create!(course_module: module_12, item: lesson_12_2, sequence_order: 3, required: true)
puts "  ✓ Lesson 12.2: #{lesson_12_2.title}"

quiz_12_2 = Quiz.create!(
  title: 'Acid Derivatives - Reactivity and Reactions',
  description: 'Test your knowledge of acid derivatives',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_12, item: quiz_12_2, sequence_order: 4, required: true)

QuizQuestion.create!([
  {quiz: quiz_12_2, question_type: 'sequence', question_text: 'Arrange in order of INCREASING reactivity in nucleophilic acyl substitution: (1) Amide (2) Ester (3) Acid chloride (4) Anhydride',
   sequence_items: [{id: 1, text: 'Amide'}, {id: 2, text: 'Ester'}, {id: 4, text: 'Anhydride'}, {id: 3, text: 'Acid chloride'}],
   explanation: 'Reactivity: Amide < Ester < Anhydride < Acid chloride. Based on leaving group ability.', points: 4, difficulty: 0.3, discrimination: 1.3, guessing: 0.04, difficulty_level: 'medium', topic: 'reactivity', skill_dimension: 'comprehension', sequence_order: 1},
  
  {quiz: quiz_12_2, question_type: 'mcq', multiple_correct: false, question_text: 'Hoffmann bromamide degradation converts:',
   options: [{text: 'Amide to amine (with loss of one carbon)', correct: true}, {text: 'Amine to amide', correct: false}, {text: 'Acid to amine', correct: false}, {text: 'Ester to amide', correct: false}],
   explanation: 'Hoffmann: R-CONH₂ + Br₂/NaOH → R-NH₂ + CO₂. Amide loses -CO₂, giving amine with one less carbon.', points: 3, difficulty: 0.1, discrimination: 1.2, guessing: 0.25, difficulty_level: 'medium', topic: 'amides', skill_dimension: 'recall', sequence_order: 2},
  
  {quiz: quiz_12_2, question_type: 'mcq', multiple_correct: false, question_text: 'Saponification is:',
   options: [{text: 'Alkaline hydrolysis of esters', correct: true}, {text: 'Acidic hydrolysis of esters', correct: false}, {text: 'Reduction of esters', correct: false}, {text: 'Oxidation of alcohols', correct: false}],
   explanation: 'Saponification: R-COOR\' + NaOH → R-COONa + R\'-OH. Alkaline (base) hydrolysis of esters. Used in soap making.', points: 2, difficulty: -0.2, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'esters', skill_dimension: 'recall', sequence_order: 3},
  
  {quiz: quiz_12_2, question_type: 'mcq', multiple_correct: true, question_text: 'Which can be converted to esters?',
   options: [{text: 'Carboxylic acid + alcohol', correct: true}, {text: 'Acid chloride + alcohol', correct: true}, {text: 'Anhydride + alcohol', correct: true}, {text: 'Amide + alcohol', correct: false}],
   explanation: 'Ester formation: (1) Acid + alcohol (Fischer) ✓, (2) Acid chloride + alcohol ✓, (3) Anhydride + alcohol ✓. Amide + alcohol does not give ester.', points: 4, difficulty: 0.2, discrimination: 1.2, guessing: 0.0, difficulty_level: 'medium', topic: 'ester_synthesis', skill_dimension: 'comprehension', sequence_order: 4},
  
  {quiz: quiz_12_2, question_type: 'mcq', multiple_correct: false, question_text: 'Reaction of 2 moles of Grignard reagent with ester gives:',
   options: [{text: 'Tertiary alcohol', correct: true}, {text: 'Secondary alcohol', correct: false}, {text: 'Primary alcohol', correct: false}, {text: 'Ketone', correct: false}],
   explanation: 'R-COOR\' + 2R"-MgX → R-C(OH)(R")₂ (3° alcohol). First mole gives ketone, second mole reacts with ketone to form 3° alcohol.', points: 3, difficulty: 0.3, discrimination: 1.3, guessing: 0.25, difficulty_level: 'medium', topic: 'ester_reactions', skill_dimension: 'application', sequence_order: 5}
])

puts "  ✓ Quiz 12.2: #{quiz_12_2.title} (#{quiz_12_2.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 12 COMPLETE: Carboxylic Acids and Derivatives"
puts "=" * 80

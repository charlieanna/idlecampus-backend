# frozen_string_literal: true

puts "\n" + "=" * 80
puts "MODULE 13: AMINES"
puts "=" * 80

course = Course.find_or_create_by!(slug: 'iit-jee-organic-chemistry') do |c|
  c.title = 'IIT JEE Organic Chemistry'
  c.description = 'Comprehensive Organic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty = 'advanced'
  c.estimated_hours = 150
  c.published = true
end

module_13 = course.course_modules.find_or_create_by!(slug: 'amines') do |m|
  m.title = 'Amines'
  m.sequence_order = 13
  m.estimated_minutes = 840  # 14 hours
  m.description = 'Nitrogen-containing organic compounds: classification, basicity, preparation, reactions, and diazonium salts'
  m.learning_objectives = [
    'Master classification and nomenclature of amines',
    'Understand basicity trends and factors',
    'Learn preparation methods and important reactions',
    'Master chemistry of diazonium salts',
    'Understand distinction tests for 1°, 2°, 3° amines',
    'Solve IIT JEE problems on mechanisms'
  ]
  m.published = true
end

puts "✅ Module 13: #{module_13.title}"

lesson_13_1 = CourseLesson.create!(
  title: 'Amines - Classification, Basicity, and Preparation',
  reading_time_minutes: 55,
  key_concepts: ['Amines', 'Classification', 'Basicity', 'Preparation', 'Gabriel phthalimide synthesis', 'Hoffmann bromamide'],
  content: <<~MD
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
  MD
)

ModuleItem.create!(course_module: module_13, item: lesson_13_1, sequence_order: 1, required: true)
puts "  ✓ Lesson 13.1: #{lesson_13_1.title}"

quiz_13_1 = Quiz.create!(
  title: 'Amines - Basicity and Preparation',
  description: 'Test your understanding of amine basicity and preparation',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_13, item: quiz_13_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {quiz: quiz_13_1, question_type: 'mcq', multiple_correct: false, question_text: 'Which is the most basic amine?',
   options: [{text: '(C₂H₅)₂NH (2° aliphatic)', correct: true}, {text: 'C₆H₅NH₂ (Aniline)', correct: false}, {text: '(C₂H₅)₃N (3° aliphatic)', correct: false}, {text: 'NH₃', correct: false}],
   explanation: 'Aliphatic amine basicity: (C₂H₅)₂NH > C₂H₅NH₂ > (C₂H₅)₃N > NH₃. 2° amine is most basic due to +I effect and less steric hindrance. Aniline is weakly basic.', points: 2, difficulty: 0.0, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'basicity', skill_dimension: 'recall', sequence_order: 1},
  
  {quiz: quiz_13_1, question_type: 'mcq', multiple_correct: false, question_text: 'Why is aniline less basic than aliphatic amines?',
   options: [{text: 'Lone pair delocalizes into benzene ring', correct: true}, {text: 'Aniline is aromatic', correct: false}, {text: 'Aniline has higher molecular weight', correct: false}, {text: 'Nitrogen is sp³ in aniline', correct: false}],
   explanation: 'Aniline\'s lone pair on N delocalizes into benzene ring (+M effect), making it less available for protonation. pKb (aniline) ≈ 9.4 vs pKb (CH₃NH₂) ≈ 3.4.', points: 2, difficulty: 0.1, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'basicity', skill_dimension: 'comprehension', sequence_order: 2},
  
  {quiz: quiz_13_1, question_type: 'mcq', multiple_correct: false, question_text: 'Gabriel phthalimide synthesis is used to prepare:',
   options: [{text: 'Pure 1° amines only', correct: true}, {text: '2° amines only', correct: false}, {text: '3° amines only', correct: false}, {text: 'Mixture of all amines', correct: false}],
   explanation: 'Gabriel synthesis gives ONLY 1° amines (no 2°/3° contamination). Uses phthalimide + alkyl halide. Best method for pure 1° amines.', points: 2, difficulty: -0.1, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'preparation', skill_dimension: 'recall', sequence_order: 3},
  
  {quiz: quiz_13_1, question_type: 'mcq', multiple_correct: true, question_text: 'Which tests distinguish 1°, 2°, 3° amines?',
   options: [{text: 'Hinsberg test (C₆H₅SO₂Cl)', correct: true}, {text: 'Carbylamine test (CHCl₃/KOH)', correct: true}, {text: 'Tollen\'s test', correct: false}, {text: 'Fehling\'s test', correct: false}],
   explanation: 'Amine tests: (1) Hinsberg - all react differently ✓, (2) Carbylamine - only 1° positive ✓. Tollen\'s/Fehling\'s are for aldehydes.', points: 4, difficulty: 0.2, discrimination: 1.2, guessing: 0.0, difficulty_level: 'medium', topic: 'tests', skill_dimension: 'recall', sequence_order: 4},
  
  {quiz: quiz_13_1, question_type: 'mcq', multiple_correct: false, question_text: 'Carbylamine test is positive for:',
   options: [{text: '1° amines only', correct: true}, {text: '2° amines only', correct: false}, {text: 'All amines', correct: false}, {text: '3° amines only', correct: false}],
   explanation: 'Carbylamine: R-NH₂ + CHCl₃ + KOH → R-NC (foul smell). ONLY 1° amines give offensive smell of isocyanide. 2° and 3° do not react.', points: 2, difficulty: 0.0, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'tests', skill_dimension: 'recall', sequence_order: 5}
])

puts "  ✓ Quiz 13.1: #{quiz_13_1.title} (#{quiz_13_1.quiz_questions.count} questions)"

lesson_13_2 = CourseLesson.create!(
  title: 'Diazonium Salts - Preparation and Reactions',
  reading_time_minutes: 50,
  key_concepts: ['Diazonium salts', 'Diazotization', 'Sandmeyer reaction', 'Gattermann reaction', 'Coupling reactions', 'Azo dyes'],
  content: <<~MD
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
  MD
)

ModuleItem.create!(course_module: module_13, item: lesson_13_2, sequence_order: 3, required: true)
puts "  ✓ Lesson 13.2: #{lesson_13_2.title}"

quiz_13_2 = Quiz.create!(
  title: 'Diazonium Salts - Reactions',
  description: 'Test your knowledge of diazonium salt chemistry',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_13, item: quiz_13_2, sequence_order: 4, required: true)

QuizQuestion.create!([
  {quiz: quiz_13_2, question_type: 'mcq', multiple_correct: false, question_text: 'Benzenediazonium chloride is prepared from aniline at:',
   options: [{text: '0-5°C (ice-cold)', correct: true}, {text: 'Room temperature', correct: false}, {text: '100°C', correct: false}, {text: '-20°C', correct: false}],
   explanation: 'Diazotization: C₆H₅NH₂ + NaNO₂/HCl → [0-5°C] → C₆H₅N₂⁺Cl⁻. Must be kept ice-cold (0-5°C), otherwise decomposes.', points: 2, difficulty: -0.2, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'preparation', skill_dimension: 'recall', sequence_order: 1},
  
  {quiz: quiz_13_2, question_type: 'mcq', multiple_correct: false, question_text: 'Sandmeyer reaction uses which catalyst?',
   options: [{text: 'CuCl/CuBr/CuCN', correct: true}, {text: 'AlCl₃', correct: false}, {text: 'FeBr₃', correct: false}, {text: 'Ni', correct: false}],
   explanation: 'Sandmeyer: C₆H₅N₂⁺Cl⁻ + CuX → C₆H₅X + N₂ (X = Cl, Br, CN). Uses copper(I) salts as catalyst. Best method for Cl, Br, CN.', points: 2, difficulty: 0.0, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'sandmeyer', skill_dimension: 'recall', sequence_order: 2},
  
  {quiz: quiz_13_2, question_type: 'mcq', multiple_correct: false, question_text: 'Which reaction converts benzenediazonium salt to fluorobenzene?',
   options: [{text: 'Balz-Schiemann (diazonium fluoroborate, heat)', correct: true}, {text: 'Sandmeyer (CuF)', correct: false}, {text: 'Direct reaction with HF', correct: false}, {text: 'Gattermann reaction', correct: false}],
   explanation: 'Balz-Schiemann: C₆H₅N₂⁺BF₄⁻ → [heat] → C₆H₅F + N₂ + BF₃. Best method for fluorobenzene. Sandmeyer does not work for F.', points: 2, difficulty: 0.1, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'balz_schiemann', skill_dimension: 'recall', sequence_order: 3},
  
  {quiz: quiz_13_2, question_type: 'mcq', multiple_correct: true, question_text: 'Diazonium salts are important because they:',
   options: [{text: 'Convert aniline to phenol/halobenzenes', correct: true}, {text: 'Form azo dyes by coupling', correct: true}, {text: 'Introduce groups like -F, -CN, -I', correct: true}, {text: 'Are very stable at room temperature', correct: false}],
   explanation: 'Diazonium salts: (1) Convert to phenol, Cl, Br, I, CN, F ✓, (2) Form azo dyes ✓, (3) Versatile intermediate ✓. They are UNSTABLE at room temperature.', points: 4, difficulty: 0.2, discrimination: 1.2, guessing: 0.0, difficulty_level: 'medium', topic: 'importance', skill_dimension: 'comprehension', sequence_order: 4},
  
  {quiz: quiz_13_2, question_type: 'mcq', multiple_correct: false, question_text: 'Coupling of benzenediazonium chloride with phenol gives:',
   options: [{text: 'p-Hydroxyazobenzene (orange azo dye)', correct: true}, {text: 'Benzene', correct: false}, {text: 'Aniline', correct: false}, {text: 'Benzoic acid', correct: false}],
   explanation: 'C₆H₅N₂⁺Cl⁻ + C₆H₅OH → [NaOH] → p-HO-C₆H₄-N=N-C₆H₅ (p-Hydroxyazobenzene, orange colored azo dye). Coupling reaction.', points: 2, difficulty: 0.0, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'coupling', skill_dimension: 'recall', sequence_order: 5}
])

puts "  ✓ Quiz 13.2: #{quiz_13_2.title} (#{quiz_13_2.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 13 COMPLETE: Amines"
puts "=" * 80

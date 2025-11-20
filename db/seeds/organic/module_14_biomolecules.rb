# frozen_string_literal: true

puts "\n" + "=" * 80
puts "MODULE 14: BIOMOLECULES"
puts "=" * 80

course = Course.find_or_create_by!(slug: 'iit-jee-organic-chemistry') do |c|
  c.title = 'IIT JEE Organic Chemistry'
  c.description = 'Comprehensive Organic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty = 'advanced'
  c.estimated_hours = 150
  c.published = true
end

module_14 = course.course_modules.find_or_create_by!(slug: 'biomolecules') do |m|
  m.title = 'Biomolecules'
  m.sequence_order = 14
  m.estimated_minutes = 840  # 14 hours
  m.description = 'Biological molecules: carbohydrates, proteins, amino acids, enzymes, vitamins, and nucleic acids'
  m.learning_objectives = [
    'Understand structure and classification of carbohydrates',
    'Learn about monosaccharides, disaccharides, and polysaccharides',
    'Master structure and properties of amino acids and proteins',
    'Understand enzyme catalysis and vitamin functions',
    'Learn basics of nucleic acids (DNA and RNA)',
    'Solve IIT JEE problems on biomolecule chemistry'
  ]
  m.published = true
end

puts "✅ Module 14: #{module_14.title}"

lesson_14_1 = CourseLesson.create!(
  title: 'Carbohydrates - Structure and Classification',
  reading_time_minutes: 60,
  key_concepts: ['Carbohydrates', 'Monosaccharides', 'Glucose', 'Fructose', 'Disaccharides', 'Polysaccharides', 'Starch', 'Cellulose'],
  content: <<~MD
    # Carbohydrates

    ## Introduction
    **Carbohydrates:** Polyhydroxy aldehydes or ketones, or compounds that yield them on hydrolysis
    **General formula:** Cₙ(H₂O)ₙ (not always exact)

    ## Classification

    ### 1. Monosaccharides (Simple sugars)
    **Cannot be hydrolyzed further**
    - **Aldoses:** Contain aldehyde group (glucose, ribose)
    - **Ketoses:** Contain ketone group (fructose, ribulose)

    **By number of carbons:**
    - Triose (C₃): Glyceraldehyde
    - Tetrose (C₄): Erythrose
    - Pentose (C₅): Ribose, Xylose
    - Hexose (C₆): Glucose, Fructose, Galactose

    ### 2. Disaccharides
    **Hydrolysis → 2 monosaccharides**
    - **Sucrose** (Cane sugar): Glucose + Fructose
    - **Lactose** (Milk sugar): Glucose + Galactose
    - **Maltose** (Malt sugar): Glucose + Glucose

    ### 3. Polysaccharides
    **Hydrolysis → Many monosaccharides**
    - **Starch:** (C₆H₁₀O₅)ₙ, storage in plants
    - **Cellulose:** (C₆H₁₀O₅)ₙ, structural in plants
    - **Glycogen:** Animal starch

    ## Glucose (D-Glucose)
    **Molecular formula:** C₆H₁₂O₆
    **Structure:** Aldohexose (6 carbons, aldehyde group)

    **Open chain (Fischer projection):**
    ```
    CHO
    |
    H-C-OH
    |
    HO-C-H
    |
    H-C-OH
    |
    H-C-OH
    |
    CH₂OH
    ```

    **Cyclic forms (Haworth projection):**
    - **α-D-Glucose:** -OH on C-1 is down
    - **β-D-Glucose:** -OH on C-1 is up

    **In solution:** Equilibrium between α, β, and open chain (mutarotation)

    ## Fructose (D-Fructose)
    **Molecular formula:** C₆H₁₂O₆
    **Structure:** Ketohexose (6 carbons, ketone group at C-2)
    - Sweetest natural sugar
    - Found in honey, fruits

    ## Reactions of Monosaccharides

    ### 1. Reduction
    ```
    Glucose + H₂ → [Ni] → Sorbitol (Hexahydric alcohol)
    ```

    ### 2. Oxidation
    **Mild (Bromine water):**
    ```
    Glucose → Gluconic acid (COOH at C-1)
    ```

    **Strong (HNO₃):**
    ```
    Glucose → Glucaric acid (COOH at both ends)
    ```

    ### 3. Glycoside Formation
    ```
    Glucose + CH₃OH → [HCl] → Methyl glucoside + H₂O
    ```

    ### 4. Osazone Formation
    ```
    Glucose + Phenylhydrazine → Glucosazone (yellow crystals)
    ```

    **Test:** Glucose and fructose give same osazone

    ## Disaccharides

    ### Sucrose (C₁₂H₂₂O₁₁)
    - **Composition:** α-D-Glucose + β-D-Fructose
    - **Linkage:** α(1→2) glycosidic linkage
    - **Non-reducing sugar** (no free -CHO or >C=O)
    - **Inversion:** Sucrose + H₂O → Glucose + Fructose (optical rotation changes)

    ### Maltose (C₁₂H₂₂O₁₁)
    - **Composition:** α-D-Glucose + α-D-Glucose
    - **Linkage:** α(1→4)
    - **Reducing sugar** (has free -OH at C-1)

    ### Lactose (C₁₂H₂₂O₁₁)
    - **Composition:** β-D-Galactose + β-D-Glucose
    - **Linkage:** β(1→4)
    - **Reducing sugar**

    ## Polysaccharides

    ### Starch
    - **Amylose:** Linear polymer of glucose, α(1→4) linkages
    - **Amylopectin:** Branched polymer, α(1→4) and α(1→6) linkages
    - **Test:** Blue color with iodine
    - **Hydrolysis:** Starch → Maltose → Glucose

    ### Cellulose
    - **Linear polymer** of β-D-glucose
    - **β(1→4) linkages**
    - Most abundant organic compound on Earth
    - Structural component of plant cell walls
    - Humans cannot digest (lack enzyme cellulase)

    ### Glycogen
    - **Animal starch**
    - Highly branched
    - Stored in liver and muscles

    ## Key Differences

    | Property | Starch | Cellulose |
    |----------|--------|-----------|
    | Linkage | α(1→4) | β(1→4) |
    | Structure | Branched | Linear |
    | Solubility | Soluble | Insoluble |
    | Digestible | Yes (humans) | No (humans) |
    | Function | Energy storage | Structural support |
    | Iodine test | Blue color | No color |
  MD
)

ModuleItem.create!(course_module: module_14, item: lesson_14_1, sequence_order: 1, required: true)
puts "  ✓ Lesson 14.1: #{lesson_14_1.title}"

quiz_14_1 = Quiz.create!(
  title: 'Carbohydrates - Structure and Properties',
  description: 'Test your understanding of carbohydrates',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_14, item: quiz_14_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {quiz: quiz_14_1, question_type: 'mcq', multiple_correct: false, question_text: 'Which is a non-reducing sugar?',
   options: [{text: 'Sucrose', correct: true}, {text: 'Maltose', correct: false}, {text: 'Lactose', correct: false}, {text: 'Glucose', correct: false}],
   explanation: 'Sucrose is non-reducing (no free aldehyde/ketone). Maltose, lactose, and glucose are reducing sugars (free -CHO or >C=O group).', points: 2, difficulty: 0.0, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'disaccharides', skill_dimension: 'recall', sequence_order: 1},
  
  {quiz: quiz_14_1, question_type: 'mcq', multiple_correct: false, question_text: 'Glucose is an example of:',
   options: [{text: 'Aldohexose', correct: true}, {text: 'Ketohexose', correct: false}, {text: 'Aldopentose', correct: false}, {text: 'Ketopentose', correct: false}],
   explanation: 'Glucose: 6 carbons (hexose) + aldehyde group (aldo) = Aldohexose. Fructose is ketohexose. Ribose is aldopentose.', points: 2, difficulty: -0.2, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'monosaccharides', skill_dimension: 'recall', sequence_order: 2},
  
  {quiz: quiz_14_1, question_type: 'mcq', multiple_correct: true, question_text: 'Which are reducing sugars?',
   options: [{text: 'Glucose', correct: true}, {text: 'Maltose', correct: true}, {text: 'Sucrose', correct: false}, {text: 'Lactose', correct: true}],
   explanation: 'Reducing sugars (free -CHO): Glucose ✓, Maltose ✓, Lactose ✓. Sucrose is non-reducing (no free carbonyl).', points: 4, difficulty: 0.2, discrimination: 1.2, guessing: 0.0, difficulty_level: 'medium', topic: 'reducing_sugars', skill_dimension: 'comprehension', sequence_order: 3},
  
  {quiz: quiz_14_1, question_type: 'mcq', multiple_correct: false, question_text: 'Starch and cellulose differ in:',
   options: [{text: 'Type of glycosidic linkage (α vs β)', correct: true}, {text: 'Molecular formula', correct: false}, {text: 'Monomer unit', correct: false}, {text: 'Element composition', correct: false}],
   explanation: 'Starch: α(1→4) linkages (digestible). Cellulose: β(1→4) linkages (indigestible). Both are (C₆H₁₀O₅)ₙ made of glucose.', points: 3, difficulty: 0.3, discrimination: 1.3, guessing: 0.25, difficulty_level: 'medium', topic: 'polysaccharides', skill_dimension: 'comprehension', sequence_order: 4},
  
  {quiz: quiz_14_1, question_type: 'mcq', multiple_correct: false, question_text: 'Blue color with iodine is given by:',
   options: [{text: 'Starch', correct: true}, {text: 'Cellulose', correct: false}, {text: 'Glucose', correct: false}, {text: 'Fructose', correct: false}],
   explanation: 'Starch gives blue color with iodine (diagnostic test). Cellulose gives no color. Glucose/fructose are monosaccharides (no iodine test).', points: 2, difficulty: -0.1, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'polysaccharides', skill_dimension: 'recall', sequence_order: 5}
])

puts "  ✓ Quiz 14.1: #{quiz_14_1.title} (#{quiz_14_1.quiz_questions.count} questions)"

lesson_14_2 = CourseLesson.create!(
  title: 'Proteins, Amino Acids, Enzymes, Vitamins, and Nucleic Acids',
  reading_time_minutes: 55,
  key_concepts: ['Amino acids', 'Proteins', 'Peptide bond', 'Enzymes', 'Vitamins', 'Nucleic acids', 'DNA', 'RNA'],
  content: <<~MD
    # Proteins and Amino Acids

    ## Amino Acids
    **General structure:** H₂N-CHR-COOH (α-amino acid)
    - **Amino group:** -NH₂
    - **Carboxyl group:** -COOH
    - **R group:** Side chain (varies)

    **Classification:**
    - **Essential:** Must be obtained from diet (9 amino acids)
    - **Non-essential:** Synthesized by body

    **Zwitterion:** H₃N⁺-CHR-COO⁻ (dipolar form, isoelectric point)

    ## Peptide Bond
    **Formation:** Condensation of -COOH of one amino acid with -NH₂ of another
    ```
    H₂N-CHR₁-COOH + H₂N-CHR₂-COOH → H₂N-CHR₁-CO-NH-CHR₂-COOH + H₂O
                                      (Dipeptide)
    ```

    **Peptide bond:** -CO-NH- (amide linkage)

    ## Proteins
    **Polymers of amino acids** joined by peptide bonds

    **Classification:**
    1. **Fibrous:** Keratin (hair), collagen (connective tissue)
    2. **Globular:** Enzymes, antibodies, hemoglobin

    **Structure levels:**
    1. **Primary:** Sequence of amino acids
    2. **Secondary:** α-helix or β-pleated sheet (H-bonding)
    3. **Tertiary:** 3D folding
    4. **Quaternary:** Multiple polypeptide chains

    **Denaturation:** Loss of structure and function (heat, pH, chemicals)

    ## Enzymes
    **Biological catalysts** (proteins)

    **Properties:**
    - Highly specific (lock and key model)
    - Work at body temperature (37°C)
    - Work at specific pH
    - Increase reaction rate by 10⁶ to 10²⁰ times

    **Mechanism:** E + S ⇌ ES → E + P (Enzyme + Substrate → Product)

    **Examples:**
    - Amylase: Starch → Maltose
    - Invertase: Sucrose → Glucose + Fructose
    - Urease: Urea → NH₃ + CO₂

    ## Vitamins
    **Organic compounds required in small amounts**

    **Classification:**
    1. **Fat-soluble:** A, D, E, K
    2. **Water-soluble:** B-complex, C

    **Important vitamins:**
    - **Vitamin A (Retinol):** Vision, growth
    - **Vitamin B₁ (Thiamine):** Beriberi
    - **Vitamin C (Ascorbic acid):** Scurvy
    - **Vitamin D (Calciferol):** Rickets
    - **Vitamin K:** Blood clotting

    **Deficiency diseases:** Scurvy (C), Beriberi (B₁), Night blindness (A), Rickets (D)

    ## Nucleic Acids
    **Polymers of nucleotides**

    **Nucleotide = Sugar + Nitrogenous base + Phosphate**

    ### DNA (Deoxyribonucleic Acid)
    - **Sugar:** Deoxyribose (C₅H₁₀O₄)
    - **Bases:** Adenine (A), Guanine (G), Cytosine (C), Thymine (T)
    - **Structure:** Double helix (Watson-Crick model)
    - **Base pairing:** A-T (2 H-bonds), G-C (3 H-bonds)
    - **Function:** Genetic information storage

    ### RNA (Ribonucleic Acid)
    - **Sugar:** Ribose (C₅H₁₀O₅)
    - **Bases:** A, G, C, Uracil (U) [instead of T]
    - **Structure:** Single strand
    - **Types:** mRNA, tRNA, rRNA
    - **Function:** Protein synthesis

    | Property | DNA | RNA |
    |----------|-----|-----|
    | Sugar | Deoxyribose | Ribose |
    | Bases | A, G, C, T | A, G, C, U |
    | Structure | Double helix | Single strand |
    | Location | Nucleus | Cytoplasm + nucleus |
    | Function | Genetic info | Protein synthesis |
  MD
)

ModuleItem.create!(course_module: module_14, item: lesson_14_2, sequence_order: 3, required: true)
puts "  ✓ Lesson 14.2: #{lesson_14_2.title}"

quiz_14_2 = Quiz.create!(
  title: 'Proteins, Vitamins, and Nucleic Acids',
  description: 'Test your understanding of biomolecules',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_14, item: quiz_14_2, sequence_order: 4, required: true)

QuizQuestion.create!([
  {quiz: quiz_14_2, question_type: 'mcq', multiple_correct: false, question_text: 'Peptide bond is formed between:',
   options: [{text: '-COOH of one amino acid and -NH₂ of another', correct: true}, {text: 'Two -COOH groups', correct: false}, {text: 'Two -NH₂ groups', correct: false}, {text: '-OH groups', correct: false}],
   explanation: 'Peptide bond (-CO-NH-) forms by condensation: -COOH + H₂N- → -CO-NH- + H₂O. This is an amide linkage.', points: 2, difficulty: -0.1, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'proteins', skill_dimension: 'recall', sequence_order: 1},
  
  {quiz: quiz_14_2, question_type: 'mcq', multiple_correct: false, question_text: 'Enzymes are:',
   options: [{text: 'Biological catalysts (proteins)', correct: true}, {text: 'Carbohydrates', correct: false}, {text: 'Lipids', correct: false}, {text: 'Nucleic acids', correct: false}],
   explanation: 'Enzymes are proteins that act as biological catalysts. They are highly specific and work at body temperature/pH.', points: 2, difficulty: -0.3, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'enzymes', skill_dimension: 'recall', sequence_order: 2},
  
  {quiz: quiz_14_2, question_type: 'mcq', multiple_correct: true, question_text: 'Which vitamins are water-soluble?',
   options: [{text: 'Vitamin B-complex', correct: true}, {text: 'Vitamin C (Ascorbic acid)', correct: true}, {text: 'Vitamin A', correct: false}, {text: 'Vitamin D', correct: false}],
   explanation: 'Water-soluble: B-complex ✓, C ✓. Fat-soluble: A, D, E, K. Water-soluble vitamins are not stored in body.', points: 4, difficulty: 0.2, discrimination: 1.2, guessing: 0.0, difficulty_level: 'medium', topic: 'vitamins', skill_dimension: 'recall', sequence_order: 3},
  
  {quiz: quiz_14_2, question_type: 'mcq', multiple_correct: false, question_text: 'In DNA, adenine pairs with:',
   options: [{text: 'Thymine (2 H-bonds)', correct: true}, {text: 'Cytosine', correct: false}, {text: 'Guanine', correct: false}, {text: 'Uracil', correct: false}],
   explanation: 'DNA base pairing: A-T (2 H-bonds), G-C (3 H-bonds). RNA has uracil (U) instead of thymine (T).', points: 2, difficulty: 0.0, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'nucleic_acids', skill_dimension: 'recall', sequence_order: 4},
  
  {quiz: quiz_14_2, question_type: 'mcq', multiple_correct: false, question_text: 'Which disease is caused by Vitamin C deficiency?',
   options: [{text: 'Scurvy', correct: true}, {text: 'Beriberi', correct: false}, {text: 'Rickets', correct: false}, {text: 'Night blindness', correct: false}],
   explanation: 'Vitamin C (Ascorbic acid) deficiency → Scurvy. Beriberi (B₁), Rickets (D), Night blindness (A).', points: 2, difficulty: -0.1, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'vitamins', skill_dimension: 'recall', sequence_order: 5}
])

puts "  ✓ Quiz 14.2: #{quiz_14_2.title} (#{quiz_14_2.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 14 COMPLETE: Biomolecules"
puts "=" * 80

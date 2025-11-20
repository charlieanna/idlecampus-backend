# frozen_string_literal: true

puts "\n" + "=" * 80
puts "MODULE 15: POLYMERS"
puts "=" * 80

course = Course.find_or_create_by!(slug: 'iit-jee-organic-chemistry') do |c|
  c.title = 'IIT JEE Organic Chemistry'
  c.description = 'Comprehensive Organic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty = 'advanced'
  c.estimated_hours = 150
  c.published = true
end

module_15 = course.course_modules.find_or_create_by!(slug: 'polymers') do |m|
  m.title = 'Polymers'
  m.sequence_order = 15
  m.estimated_minutes = 600  # 10 hours
  m.description = 'Macromolecules: classification, polymerization mechanisms, important polymers, and biodegradable polymers'
  m.learning_objectives = [
    'Understand classification of polymers',
    'Master addition and condensation polymerization',
    'Learn structure and properties of important polymers',
    'Understand biodegradable polymers',
    'Distinguish between natural and synthetic polymers',
    'Solve IIT JEE problems on polymer chemistry'
  ]
  m.published = true
end

puts "✅ Module 15: #{module_15.title}"

lesson_15_1 = CourseLesson.create!(
  title: 'Polymers - Classification and Polymerization',
  reading_time_minutes: 55,
  key_concepts: ['Polymers', 'Monomers', 'Addition polymerization', 'Condensation polymerization', 'Classification', 'Copolymers'],
  content: <<~MD
    # Polymers

    ## Introduction
    **Polymer:** Large molecule (macromolecule) formed by joining many small molecules (monomers)

    **Monomer:** Small repeating unit
    **Polymer:** (Greek) Poly = many, meros = parts

    **Example:**
    ```
    nCH₂=CH₂ → -(CH₂-CH₂)ₙ-
    (Ethylene)    (Polyethylene)
     Monomer       Polymer
    ```

    ## Classification of Polymers

    ### 1. Based on Source

    #### Natural Polymers
    - Occur in nature
    - **Examples:** Starch, cellulose, proteins, natural rubber, DNA

    #### Semi-synthetic Polymers
    - Chemically modified natural polymers
    - **Examples:** Cellulose acetate, cellulose nitrate, vulcanized rubber

    #### Synthetic Polymers
    - Man-made in laboratory/industry
    - **Examples:** Polyethylene, PVC, nylon, bakelite, teflon

    ### 2. Based on Structure

    #### Linear Polymers
    - Monomers joined in a line
    - **Examples:** PVC, polyethylene, nylon
    - Properties: Flexible, can be melted

    #### Branched Polymers
    - Linear chains with branches
    - **Examples:** Low-density polyethylene (LDPE)
    - Properties: Less dense, lower strength

    #### Cross-linked Polymers
    - Chains connected by cross-links
    - **Examples:** Bakelite, vulcanized rubber
    - Properties: Hard, rigid, cannot be melted

    ### 3. Based on Mode of Polymerization

    #### Addition Polymers
    - Monomers add without loss of any molecule
    - **Requires:** C=C or C≡C (unsaturated monomers)
    - **Examples:** Polyethylene, polypropylene, PVC, teflon

    #### Condensation Polymers
    - Monomers join with loss of small molecules (H₂O, HCl, etc.)
    - **Requires:** Bifunctional monomers
    - **Examples:** Nylon, terylene, bakelite

    ### 4. Based on Molecular Forces

    #### Elastomers
    - Elastic, can be stretched
    - **Examples:** Natural rubber, neoprene, buna-S
    - Weak intermolecular forces

    #### Fibers
    - Strong, thread-like
    - **Examples:** Nylon, terylene, polyester
    - Strong H-bonding or dipole-dipole forces

    #### Thermoplastics
    - Can be melted and remolded
    - **Examples:** Polythene, PVC, polystyrene
    - Weak intermolecular forces

    #### Thermosetting
    - Cannot be melted once set
    - **Examples:** Bakelite, melamine, urea-formaldehyde
    - Cross-linked structure

    ## Types of Polymerization

    ### Addition Polymerization (Chain Growth)

    **Mechanism:** Free radical, ionic, or coordination

    **Characteristics:**
    - Monomers with C=C bond
    - No loss of small molecules
    - Same empirical formula as monomer

    **Examples:**

    1. **Polyethylene:**
       ```
       nCH₂=CH₂ → -(CH₂-CH₂)ₙ-
       ```

    2. **Polypropylene:**
       ```
       nCH₂=CH-CH₃ → -(CH₂-CH(CH₃))ₙ-
       ```

    3. **PVC (Polyvinyl chloride):**
       ```
       nCH₂=CHCl → -(CH₂-CHCl)ₙ-
       ```

    4. **Teflon:**
       ```
       nCF₂=CF₂ → -(CF₂-CF₂)ₙ-
       ```

    5. **Polystyrene:**
       ```
       nCH₂=CH-C₆H₅ → -(CH₂-CH(C₆H₅))ₙ-
       ```

    ### Condensation Polymerization (Step Growth)

    **Mechanism:** Functional groups react

    **Characteristics:**
    - Bifunctional monomers
    - Loss of small molecules (H₂O, HCl, NH₃)
    - Different empirical formula than monomer

    **Examples:**

    1. **Nylon-6,6:**
       ```
       nHOOC-(CH₂)₄-COOH + nH₂N-(CH₂)₆-NH₂ →
       Adipic acid         Hexamethylenediamine
       
       -[CO-(CH₂)₄-CO-NH-(CH₂)₆-NH]ₙ- + 2nH₂O
       ```

    2. **Nylon-6:**
       ```
       nH₂N-(CH₂)₅-COOH → -[NH-(CH₂)₅-CO]ₙ- + nH₂O
       (Caprolactam)
       ```

    3. **Terylene (Dacron):**
       ```
       nHOOC-C₆H₄-COOH + nHOCH₂CH₂OH →
       Terephthalic acid   Ethylene glycol
       
       -[OC-C₆H₄-CO-OCH₂CH₂O]ₙ- + 2nH₂O
       ```

    4. **Bakelite:**
       ```
       Phenol + Formaldehyde → [Phenol-CH₂]ₙ (cross-linked) + nH₂O
       ```

    ### Copolymers

    **Two or more different monomers** polymerize together

    **Examples:**

    1. **Buna-S (SBR):**
       ```
       Butadiene + Styrene → Synthetic rubber
       ```

    2. **Buna-N:**
       ```
       Butadiene + Acrylonitrile → Oil-resistant rubber
       ```

    ## Important Polymers and Uses

    | Polymer | Monomer | Use |
    |---------|---------|-----|
    | **Polyethylene (LDPE/HDPE)** | Ethylene | Plastic bags, bottles |
    | **PVC** | Vinyl chloride | Pipes, flooring |
    | **Teflon** | Tetrafluoroethylene | Non-stick cookware |
    | **Polystyrene** | Styrene | Packaging, insulation |
    | **Nylon-6,6** | Adipic acid + Hexamethylenediamine | Fibers, ropes |
    | **Terylene** | Terephthalic acid + Ethylene glycol | Fibers, films |
    | **Bakelite** | Phenol + Formaldehyde | Electrical switches |
    | **PET** | Ethylene glycol + Terephthalic acid | Bottles, fibers |

    ## Biodegradable Polymers

    **Polymers that can be decomposed by microorganisms**

    **Examples:**

    1. **PHBV (Poly-β-hydroxybutyrate-co-β-hydroxyvalerate):**
       - Natural biodegradable polymer
       - Used in packaging

    2. **Nylon-2-nylon-6:**
       - Biodegradable polyamide
       - Medical applications

    **Importance:** Reduce environmental pollution

    ## Non-biodegradable vs Biodegradable

    | Type | Examples | Environmental Impact |
    |------|----------|---------------------|
    | **Non-biodegradable** | Polythene, PVC, polystyrene | Persist for years, pollution |
    | **Biodegradable** | PHBV, Nylon-2-nylon-6, starch | Decompose naturally, eco-friendly |
  MD
)

ModuleItem.create!(course_module: module_15, item: lesson_15_1, sequence_order: 1, required: true)
puts "  ✓ Lesson 15.1: #{lesson_15_1.title}"

quiz_15_1 = Quiz.create!(
  title: 'Polymers - Classification and Types',
  description: 'Test your understanding of polymer chemistry',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_15, item: quiz_15_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {quiz: quiz_15_1, question_type: 'mcq', multiple_correct: false, question_text: 'Which is an addition polymer?',
   options: [{text: 'Polyethylene', correct: true}, {text: 'Nylon-6,6', correct: false}, {text: 'Terylene', correct: false}, {text: 'Bakelite', correct: false}],
   explanation: 'Polyethylene: nCH₂=CH₂ → -(CH₂-CH₂)ₙ- (addition, no loss of molecules). Nylon, terylene, bakelite are condensation polymers (lose H₂O).', points: 2, difficulty: -0.2, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'classification', skill_dimension: 'recall', sequence_order: 1},
  
  {quiz: quiz_15_1, question_type: 'mcq', multiple_correct: true, question_text: 'Which are thermoplastic polymers?',
   options: [{text: 'Polythene', correct: true}, {text: 'PVC', correct: true}, {text: 'Bakelite', correct: false}, {text: 'Polystyrene', correct: true}],
   explanation: 'Thermoplastics (can be melted): Polythene ✓, PVC ✓, Polystyrene ✓. Thermosetting (cannot be melted): Bakelite (cross-linked).', points: 4, difficulty: 0.2, discrimination: 1.2, guessing: 0.0, difficulty_level: 'medium', topic: 'classification', skill_dimension: 'recall', sequence_order: 2},
  
  {quiz: quiz_15_1, question_type: 'mcq', multiple_correct: false, question_text: 'Nylon-6,6 is formed by condensation of:',
   options: [{text: 'Adipic acid + Hexamethylenediamine', correct: true}, {text: 'Ethylene glycol + Terephthalic acid', correct: false}, {text: 'Phenol + Formaldehyde', correct: false}, {text: 'Butadiene + Styrene', correct: false}],
   explanation: 'Nylon-6,6: Adipic acid (6C) + Hexamethylenediamine (6C) → polyamide + H₂O. Terylene uses ethylene glycol + terephthalic acid. Bakelite uses phenol + formaldehyde.', points: 2, difficulty: 0.0, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'condensation_polymers', skill_dimension: 'recall', sequence_order: 3},
  
  {quiz: quiz_15_1, question_type: 'mcq', multiple_correct: false, question_text: 'Which polymer is used in non-stick cookware?',
   options: [{text: 'Teflon (PTFE)', correct: true}, {text: 'PVC', correct: false}, {text: 'Bakelite', correct: false}, {text: 'Nylon', correct: false}],
   explanation: 'Teflon (Polytetrafluoroethylene, -(CF₂-CF₂)ₙ-) is used in non-stick cookware. Very chemically inert, high heat resistance.', points: 2, difficulty: -0.1, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'polymer_uses', skill_dimension: 'recall', sequence_order: 4},
  
  {quiz: quiz_15_1, question_type: 'mcq', multiple_correct: false, question_text: 'Biodegradable polymers are important because they:',
   options: [{text: 'Decompose naturally, reducing pollution', correct: true}, {text: 'Are cheaper to produce', correct: false}, {text: 'Have higher strength', correct: false}, {text: 'Last longer', correct: false}],
   explanation: 'Biodegradable polymers (PHBV, Nylon-2-nylon-6) decompose by microorganisms, reducing environmental pollution. Non-biodegradable polymers persist for years.', points: 2, difficulty: 0.0, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'biodegradable', skill_dimension: 'comprehension', sequence_order: 5},
  
  {quiz: quiz_15_1, question_type: 'mcq', multiple_correct: true, question_text: 'Which are natural polymers?',
   options: [{text: 'Starch', correct: true}, {text: 'Cellulose', correct: true}, {text: 'Proteins', correct: true}, {text: 'PVC', correct: false}],
   explanation: 'Natural polymers (occur in nature): Starch ✓, Cellulose ✓, Proteins ✓, Natural rubber ✓. PVC is synthetic (man-made).', points: 4, difficulty: 0.1, discrimination: 1.1, guessing: 0.0, difficulty_level: 'easy', topic: 'classification', skill_dimension: 'recall', sequence_order: 6}
])

puts "  ✓ Quiz 15.1: #{quiz_15_1.title} (#{quiz_15_1.quiz_questions.count} questions)"

lesson_15_2 = CourseLesson.create!(
  title: 'Important Synthetic Polymers and Applications',
  reading_time_minutes: 40,
  key_concepts: ['Synthetic rubber', 'Buna-S', 'Buna-N', 'Plastic types', 'Polymer applications', 'Environmental concerns'],
  content: <<~MD
    # Important Synthetic Polymers

    ## Synthetic Rubbers (Elastomers)

    ### Natural Rubber
    - **Monomer:** Isoprene (2-Methylbuta-1,3-diene)
    - **Structure:** cis-1,4-Polyisoprene
    - **Problems:** Sticky in summer, brittle in winter

    ### Vulcanization
    - **Process:** Heating natural rubber with sulfur (1-5%)
    - **Effect:** Cross-linking of polymer chains
    - **Result:** Improved strength, elasticity, temperature resistance

    ### Buna-S (SBR - Styrene-Butadiene Rubber)
    - **Monomers:** Butadiene (75%) + Styrene (25%)
    - **Use:** Automobile tires, shoe soles
    - **Property:** Superior to natural rubber

    ### Buna-N (Nitrile Rubber)
    - **Monomers:** Butadiene + Acrylonitrile
    - **Use:** Oil-resistant applications (hoses, gaskets)
    - **Property:** Resistant to oils and solvents

    ### Neoprene
    - **Monomer:** Chloroprene (2-Chlorobuta-1,3-diene)
    - **Use:** Gaskets, conveyor belts
    - **Property:** Oil and heat resistant

    ## Important Plastics

    ### Thermoplastics

    #### 1. Polyethylene (PE)
    **LDPE (Low Density):**
    - Branched structure
    - Use: Plastic bags, films

    **HDPE (High Density):**
    - Linear structure
    - Use: Bottles, containers, pipes

    #### 2. PVC (Polyvinyl Chloride)
    - Monomer: Vinyl chloride (CH₂=CHCl)
    - Use: Pipes, flooring, electrical insulation
    - Can be rigid or flexible (with plasticizers)

    #### 3. Polystyrene
    - Monomer: Styrene (C₆H₅-CH=CH₂)
    - Use: Packaging, disposable cups, insulation

    #### 4. PET (Polyethylene Terephthalate)
    - Condensation polymer
    - Use: Plastic bottles, fibers (terylene/dacron)
    - Can be recycled

    ### Thermosetting Plastics

    #### 1. Bakelite
    - Monomers: Phenol + Formaldehyde
    - Structure: Cross-linked
    - Use: Electrical switches, handles, laboratory equipment
    - First fully synthetic plastic

    #### 2. Melamine-Formaldehyde
    - Monomers: Melamine + Formaldehyde
    - Use: Dinnerware, laminates
    - Heat resistant

    #### 3. Urea-Formaldehyde
    - Monomers: Urea + Formaldehyde
    - Use: Adhesives, particle board

    ## Synthetic Fibers

    ### 1. Nylon-6,6
    - **Monomers:** Adipic acid + Hexamethylenediamine
    - **Use:** Ropes, fabrics, tire cords, parachutes
    - **Property:** Strong, elastic, lustrous

    ### 2. Nylon-6
    - **Monomer:** Caprolactam
    - **Use:** Similar to Nylon-6,6
    - **Advantage:** Single monomer

    ### 3. Terylene (Dacron, Polyester)
    - **Monomers:** Terephthalic acid + Ethylene glycol
    - **Use:** Fabrics, bottles (PET)
    - **Property:** Wrinkle-resistant, strong

    ## Environmental Concerns

    ### Problems with Non-biodegradable Polymers
    1. **Persistence:** Remain in environment for hundreds of years
    2. **Pollution:** Plastic waste in oceans, landfills
    3. **Harmful to wildlife:** Ingestion, entanglement
    4. **Burning releases toxins:** Dioxins from PVC

    ### Solutions
    1. **Reduce, Reuse, Recycle (3R)**
    2. **Biodegradable polymers:** PHBV, PLA
    3. **Proper waste management**
    4. **Regulations on single-use plastics**

    ## Comparison Table

    | Polymer | Type | Monomer(s) | Main Use |
    |---------|------|-----------|----------|
    | Polyethylene | Addition | Ethylene | Bags, bottles |
    | PVC | Addition | Vinyl chloride | Pipes |
    | Teflon | Addition | Tetrafluoroethylene | Non-stick coating |
    | Polystyrene | Addition | Styrene | Packaging |
    | Nylon-6,6 | Condensation | Adipic acid + Hexamethylenediamine | Fibers |
    | Terylene | Condensation | Terephthalic acid + Ethylene glycol | Fibers, bottles |
    | Bakelite | Condensation | Phenol + Formaldehyde | Electrical |
    | Buna-S | Addition (Copolymer) | Butadiene + Styrene | Tires |

    ## Key Takeaways
    1. **Addition polymers:** From alkenes, no loss of molecules
    2. **Condensation polymers:** From bifunctional monomers, lose H₂O/HCl
    3. **Thermoplastics:** Can be melted and remolded
    4. **Thermosetting:** Cannot be melted once set (cross-linked)
    5. **Biodegradable polymers:** Important for environment
    6. **Vulcanization:** Improves rubber properties
  MD
)

ModuleItem.create!(course_module: module_15, item: lesson_15_2, sequence_order: 3, required: true)
puts "  ✓ Lesson 15.2: #{lesson_15_2.title}"

quiz_15_2 = Quiz.create!(
  title: 'Synthetic Polymers and Applications',
  description: 'Test your knowledge of polymer applications',
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_15, item: quiz_15_2, sequence_order: 4, required: true)

QuizQuestion.create!([
  {quiz: quiz_15_2, question_type: 'mcq', multiple_correct: false, question_text: 'Vulcanization of rubber involves heating with:',
   options: [{text: 'Sulfur', correct: true}, {text: 'Oxygen', correct: false}, {text: 'Nitrogen', correct: false}, {text: 'Chlorine', correct: false}],
   explanation: 'Vulcanization: Natural rubber + Sulfur (1-5%) → [heat] → Cross-linked rubber. Improves strength, elasticity, and temperature resistance.', points: 2, difficulty: -0.1, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'rubber', skill_dimension: 'recall', sequence_order: 1},
  
  {quiz: quiz_15_2, question_type: 'mcq', multiple_correct: false, question_text: 'Buna-S is a copolymer of:',
   options: [{text: 'Butadiene + Styrene', correct: true}, {text: 'Butadiene + Acrylonitrile', correct: false}, {text: 'Isoprene + Styrene', correct: false}, {text: 'Ethylene + Propylene', correct: false}],
   explanation: 'Buna-S (SBR): Butadiene (75%) + Styrene (25%) → Synthetic rubber. Used in automobile tires. Buna-N uses butadiene + acrylonitrile.', points: 2, difficulty: 0.0, discrimination: 1.1, guessing: 0.25, difficulty_level: 'easy', topic: 'synthetic_rubber', skill_dimension: 'recall', sequence_order: 2},
  
  {quiz: quiz_15_2, question_type: 'mcq', multiple_correct: false, question_text: 'Bakelite is an example of:',
   options: [{text: 'Thermosetting plastic', correct: true}, {text: 'Thermoplastic', correct: false}, {text: 'Addition polymer', correct: false}, {text: 'Elastomer', correct: false}],
   explanation: 'Bakelite (phenol + formaldehyde) is thermosetting - cross-linked structure, cannot be melted once set. Used in electrical switches.', points: 2, difficulty: -0.1, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'thermosetting', skill_dimension: 'recall', sequence_order: 3},
  
  {quiz: quiz_15_2, question_type: 'mcq', multiple_correct: true, question_text: 'Which polymers are biodegradable?',
   options: [{text: 'PHBV', correct: true}, {text: 'Nylon-2-nylon-6', correct: true}, {text: 'Polythene', correct: false}, {text: 'PVC', correct: false}],
   explanation: 'Biodegradable: PHBV ✓, Nylon-2-nylon-6 ✓. Non-biodegradable: Polythene, PVC (persist for years, environmental pollution).', points: 4, difficulty: 0.2, discrimination: 1.2, guessing: 0.0, difficulty_level: 'medium', topic: 'biodegradable', skill_dimension: 'recall', sequence_order: 4},
  
  {quiz: quiz_15_2, question_type: 'mcq', multiple_correct: false, question_text: 'PET (Polyethylene Terephthalate) is used for:',
   options: [{text: 'Plastic bottles and fibers', correct: true}, {text: 'Electrical switches', correct: false}, {text: 'Automobile tires', correct: false}, {text: 'Non-stick cookware', correct: false}],
   explanation: 'PET (terylene/dacron): Plastic bottles, fibers, fabrics. Bakelite for electrical switches. Buna-S for tires. Teflon for non-stick cookware.', points: 2, difficulty: 0.0, discrimination: 1.0, guessing: 0.25, difficulty_level: 'easy', topic: 'polymer_uses', skill_dimension: 'recall', sequence_order: 5}
])

puts "  ✓ Quiz 15.2: #{quiz_15_2.title} (#{quiz_15_2.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 15 COMPLETE: Polymers"
puts "=" * 80
puts "\n" + "=" * 80
puts "ALL 8 CHEMISTRY MODULES CREATED SUCCESSFULLY!"
puts "=" * 80

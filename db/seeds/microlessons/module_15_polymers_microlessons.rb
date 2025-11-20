# AUTO-GENERATED from module_15_polymers.rb
puts "Creating Microlessons for Polymers..."

module_var = CourseModule.find_by(slug: 'polymers')

# === MICROLESSON 1: polymer_uses — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'polymer_uses — Practice',
  content: <<~MARKDOWN,
# polymer_uses — Practice 🚀

PET (terylene/dacron): Plastic bottles, fibers, fabrics. Bakelite for electrical switches. Buna-S for tires. Teflon for non-stick cookware.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['polymer_uses'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'PET (Polyethylene Terephthalate) is used for:',
    options: ['Plastic bottles and fibers', 'Electrical switches', 'Automobile tires', 'Non-stick cookware'],
    correct_answer: 0,
    explanation: 'PET (terylene/dacron): Plastic bottles, fibers, fabrics. Bakelite for electrical switches. Buna-S for tires. Teflon for non-stick cookware.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 2: Important Synthetic Polymers and Applications ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Important Synthetic Polymers and Applications',
  content: <<~MARKDOWN,
# Important Synthetic Polymers and Applications 🚀

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

## Key Points

- Synthetic rubber

- Buna-S

- Buna-N
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Synthetic rubber', 'Buna-S', 'Buna-N', 'Plastic types', 'Polymer applications', 'Environmental concerns'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Polymers - Classification and Polymerization ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Polymers - Classification and Polymerization',
  content: <<~MARKDOWN,
# Polymers - Classification and Polymerization 🚀

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

## Key Points

- Polymers

- Monomers

- Addition polymerization
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Polymers', 'Monomers', 'Addition polymerization', 'Condensation polymerization', 'Classification', 'Copolymers'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Important Synthetic Polymers and Applications ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Important Synthetic Polymers and Applications',
  content: <<~MARKDOWN,
# Important Synthetic Polymers and Applications 🚀

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

## Key Points

- Synthetic rubber

- Buna-S

- Buna-N
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Synthetic rubber', 'Buna-S', 'Buna-N', 'Plastic types', 'Polymer applications', 'Environmental concerns'],
  prerequisite_ids: []
)

# === MICROLESSON 5: classification — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'classification — Practice',
  content: <<~MARKDOWN,
# classification — Practice 🚀

Polyethylene: nCH₂=CH₂ → -(CH₂-CH₂)ₙ- (addition, no loss of molecules). Nylon, terylene, bakelite are condensation polymers (lose H₂O).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['classification'],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which is an addition polymer?',
    options: ['Polyethylene', 'Nylon-6,6', 'Terylene', 'Bakelite'],
    correct_answer: 0,
    explanation: 'Polyethylene: nCH₂=CH₂ → -(CH₂-CH₂)ₙ- (addition, no loss of molecules). Nylon, terylene, bakelite are condensation polymers (lose H₂O).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: classification — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'classification — Practice',
  content: <<~MARKDOWN,
# classification — Practice 🚀

Thermoplastics (can be melted): Polythene ✓, PVC ✓, Polystyrene ✓. Thermosetting (cannot be melted): Bakelite (cross-linked).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['classification'],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which are thermoplastic polymers?',
    options: ['Polythene', 'PVC', 'Bakelite', 'Polystyrene'],
    correct_answer: 3,
    explanation: 'Thermoplastics (can be melted): Polythene ✓, PVC ✓, Polystyrene ✓. Thermosetting (cannot be melted): Bakelite (cross-linked).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 7: condensation_polymers — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'condensation_polymers — Practice',
  content: <<~MARKDOWN,
# condensation_polymers — Practice 🚀

Nylon-6,6: Adipic acid (6C) + Hexamethylenediamine (6C) → polyamide + H₂O. Terylene uses ethylene glycol + terephthalic acid. Bakelite uses phenol + formaldehyde.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['condensation_polymers'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Nylon-6,6 is formed by condensation of:',
    options: ['Adipic acid + Hexamethylenediamine', 'Ethylene glycol + Terephthalic acid', 'Phenol + Formaldehyde', 'Butadiene + Styrene'],
    correct_answer: 0,
    explanation: 'Nylon-6,6: Adipic acid (6C) + Hexamethylenediamine (6C) → polyamide + H₂O. Terylene uses ethylene glycol + terephthalic acid. Bakelite uses phenol + formaldehyde.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: polymer_uses — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'polymer_uses — Practice',
  content: <<~MARKDOWN,
# polymer_uses — Practice 🚀

Teflon (Polytetrafluoroethylene, -(CF₂-CF₂)ₙ-) is used in non-stick cookware. Very chemically inert, high heat resistance.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['polymer_uses'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which polymer is used in non-stick cookware?',
    options: ['Teflon (PTFE)', 'PVC', 'Bakelite', 'Nylon'],
    correct_answer: 0,
    explanation: 'Teflon (Polytetrafluoroethylene, -(CF₂-CF₂)ₙ-) is used in non-stick cookware. Very chemically inert, high heat resistance.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: biodegradable — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'biodegradable — Practice',
  content: <<~MARKDOWN,
# biodegradable — Practice 🚀

Biodegradable polymers (PHBV, Nylon-2-nylon-6) decompose by microorganisms, reducing environmental pollution. Non-biodegradable polymers persist for years.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['biodegradable'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Biodegradable polymers are important because they:',
    options: ['Decompose naturally, reducing pollution', 'Are cheaper to produce', 'Have higher strength', 'Last longer'],
    correct_answer: 0,
    explanation: 'Biodegradable polymers (PHBV, Nylon-2-nylon-6) decompose by microorganisms, reducing environmental pollution. Non-biodegradable polymers persist for years.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: classification — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'classification — Practice',
  content: <<~MARKDOWN,
# classification — Practice 🚀

Natural polymers (occur in nature): Starch ✓, Cellulose ✓, Proteins ✓, Natural rubber ✓. PVC is synthetic (man-made).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['classification'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which are natural polymers?',
    options: ['Starch', 'Cellulose', 'Proteins', 'PVC'],
    correct_answer: 2,
    explanation: 'Natural polymers (occur in nature): Starch ✓, Cellulose ✓, Proteins ✓, Natural rubber ✓. PVC is synthetic (man-made).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: rubber — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'rubber — Practice',
  content: <<~MARKDOWN,
# rubber — Practice 🚀

Vulcanization: Natural rubber + Sulfur (1-5%) → [heat] → Cross-linked rubber. Improves strength, elasticity, and temperature resistance.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['rubber'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Vulcanization of rubber involves heating with:',
    options: ['Sulfur', 'Oxygen', 'Nitrogen', 'Chlorine'],
    correct_answer: 0,
    explanation: 'Vulcanization: Natural rubber + Sulfur (1-5%) → [heat] → Cross-linked rubber. Improves strength, elasticity, and temperature resistance.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: synthetic_rubber — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'synthetic_rubber — Practice',
  content: <<~MARKDOWN,
# synthetic_rubber — Practice 🚀

Buna-S (SBR): Butadiene (75%) + Styrene (25%) → Synthetic rubber. Used in automobile tires. Buna-N uses butadiene + acrylonitrile.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['synthetic_rubber'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Buna-S is a copolymer of:',
    options: ['Butadiene + Styrene', 'Butadiene + Acrylonitrile', 'Isoprene + Styrene', 'Ethylene + Propylene'],
    correct_answer: 0,
    explanation: 'Buna-S (SBR): Butadiene (75%) + Styrene (25%) → Synthetic rubber. Used in automobile tires. Buna-N uses butadiene + acrylonitrile.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: thermosetting — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'thermosetting — Practice',
  content: <<~MARKDOWN,
# thermosetting — Practice 🚀

Bakelite (phenol + formaldehyde) is thermosetting - cross-linked structure, cannot be melted once set. Used in electrical switches.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['thermosetting'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Bakelite is an example of:',
    options: ['Thermosetting plastic', 'Thermoplastic', 'Addition polymer', 'Elastomer'],
    correct_answer: 0,
    explanation: 'Bakelite (phenol + formaldehyde) is thermosetting - cross-linked structure, cannot be melted once set. Used in electrical switches.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 14: biodegradable — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'biodegradable — Practice',
  content: <<~MARKDOWN,
# biodegradable — Practice 🚀

Biodegradable: PHBV ✓, Nylon-2-nylon-6 ✓. Non-biodegradable: Polythene, PVC (persist for years, environmental pollution).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['biodegradable'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which polymers are biodegradable?',
    options: ['PHBV', 'Nylon-2-nylon-6', 'Polythene', 'PVC'],
    correct_answer: 1,
    explanation: 'Biodegradable: PHBV ✓, Nylon-2-nylon-6 ✓. Non-biodegradable: Polythene, PVC (persist for years, environmental pollution).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 15: Polymers - Classification and Polymerization ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Polymers - Classification and Polymerization',
  content: <<~MARKDOWN,
# Polymers - Classification and Polymerization 🚀

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

## Key Points

- Polymers

- Monomers

- Addition polymerization
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Polymers', 'Monomers', 'Addition polymerization', 'Condensation polymerization', 'Classification', 'Copolymers'],
  prerequisite_ids: []
)

puts "✓ Created 15 microlessons for Polymers"

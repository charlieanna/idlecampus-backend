# AUTO-GENERATED from module_14_biomolecules.rb
puts "Creating Microlessons for Biomolecules..."

module_var = CourseModule.find_by(slug: 'biomolecules')

# === MICROLESSON 1: vitamins — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'vitamins — Practice',
  content: <<~MARKDOWN,
# vitamins — Practice 🚀

Vitamin C (Ascorbic acid) deficiency → Scurvy. Beriberi (B₁), Rickets (D), Night blindness (A).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['vitamins'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which disease is caused by Vitamin C deficiency?',
    options: ['Scurvy', 'Beriberi', 'Rickets', 'Night blindness'],
    correct_answer: 0,
    explanation: 'Vitamin C (Ascorbic acid) deficiency → Scurvy. Beriberi (B₁), Rickets (D), Night blindness (A).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 2: Proteins, Amino Acids, Enzymes, Vitamins, and Nucleic Acids ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Proteins, Amino Acids, Enzymes, Vitamins, and Nucleic Acids',
  content: <<~MARKDOWN,
# Proteins, Amino Acids, Enzymes, Vitamins, and Nucleic Acids 🚀

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

## Key Points

- Amino acids

- Proteins

- Peptide bond
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Amino acids', 'Proteins', 'Peptide bond', 'Enzymes', 'Vitamins', 'Nucleic acids', 'DNA', 'RNA'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Carbohydrates - Structure and Classification ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Carbohydrates - Structure and Classification',
  content: <<~MARKDOWN,
# Carbohydrates - Structure and Classification 🚀

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

## Key Points

- Carbohydrates

- Monosaccharides

- Glucose
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Carbohydrates', 'Monosaccharides', 'Glucose', 'Fructose', 'Disaccharides', 'Polysaccharides', 'Starch', 'Cellulose'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Proteins, Amino Acids, Enzymes, Vitamins, and Nucleic Acids ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Proteins, Amino Acids, Enzymes, Vitamins, and Nucleic Acids',
  content: <<~MARKDOWN,
# Proteins, Amino Acids, Enzymes, Vitamins, and Nucleic Acids 🚀

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

## Key Points

- Amino acids

- Proteins

- Peptide bond
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Amino acids', 'Proteins', 'Peptide bond', 'Enzymes', 'Vitamins', 'Nucleic acids', 'DNA', 'RNA'],
  prerequisite_ids: []
)

# === MICROLESSON 5: disaccharides — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'disaccharides — Practice',
  content: <<~MARKDOWN,
# disaccharides — Practice 🚀

Sucrose is non-reducing (no free aldehyde/ketone). Maltose, lactose, and glucose are reducing sugars (free -CHO or >C=O group).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['disaccharides'],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which is a non-reducing sugar?',
    options: ['Sucrose', 'Maltose', 'Lactose', 'Glucose'],
    correct_answer: 0,
    explanation: 'Sucrose is non-reducing (no free aldehyde/ketone). Maltose, lactose, and glucose are reducing sugars (free -CHO or >C=O group).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: monosaccharides — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'monosaccharides — Practice',
  content: <<~MARKDOWN,
# monosaccharides — Practice 🚀

Glucose: 6 carbons (hexose) + aldehyde group (aldo) = Aldohexose. Fructose is ketohexose. Ribose is aldopentose.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['monosaccharides'],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Glucose is an example of:',
    options: ['Aldohexose', 'Ketohexose', 'Aldopentose', 'Ketopentose'],
    correct_answer: 0,
    explanation: 'Glucose: 6 carbons (hexose) + aldehyde group (aldo) = Aldohexose. Fructose is ketohexose. Ribose is aldopentose.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 7: reducing_sugars — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'reducing_sugars — Practice',
  content: <<~MARKDOWN,
# reducing_sugars — Practice 🚀

Reducing sugars (free -CHO): Glucose ✓, Maltose ✓, Lactose ✓. Sucrose is non-reducing (no free carbonyl).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['reducing_sugars'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which are reducing sugars?',
    options: ['Glucose', 'Maltose', 'Sucrose', 'Lactose'],
    correct_answer: 3,
    explanation: 'Reducing sugars (free -CHO): Glucose ✓, Maltose ✓, Lactose ✓. Sucrose is non-reducing (no free carbonyl).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 8: polysaccharides — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'polysaccharides — Practice',
  content: <<~MARKDOWN,
# polysaccharides — Practice 🚀

Starch: α(1→4) linkages (digestible). Cellulose: β(1→4) linkages (indigestible). Both are (C₆H₁₀O₅)ₙ made of glucose.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['polysaccharides'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Starch and cellulose differ in:',
    options: ['Type of glycosidic linkage (α vs β)', 'Molecular formula', 'Monomer unit', 'Element composition'],
    correct_answer: 0,
    explanation: 'Starch: α(1→4) linkages (digestible). Cellulose: β(1→4) linkages (indigestible). Both are (C₆H₁₀O₅)ₙ made of glucose.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: polysaccharides — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'polysaccharides — Practice',
  content: <<~MARKDOWN,
# polysaccharides — Practice 🚀

Starch gives blue color with iodine (diagnostic test). Cellulose gives no color. Glucose/fructose are monosaccharides (no iodine test).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['polysaccharides'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Blue color with iodine is given by:',
    options: ['Starch', 'Cellulose', 'Glucose', 'Fructose'],
    correct_answer: 0,
    explanation: 'Starch gives blue color with iodine (diagnostic test). Cellulose gives no color. Glucose/fructose are monosaccharides (no iodine test).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: proteins — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'proteins — Practice',
  content: <<~MARKDOWN,
# proteins — Practice 🚀

Peptide bond (-CO-NH-) forms by condensation: -COOH + H₂N- → -CO-NH- + H₂O. This is an amide linkage.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['proteins'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Peptide bond is formed between:',
    options: ['-COOH of one amino acid and -NH₂ of another', 'Two -COOH groups', 'Two -NH₂ groups', '-OH groups'],
    correct_answer: 0,
    explanation: 'Peptide bond (-CO-NH-) forms by condensation: -COOH + H₂N- → -CO-NH- + H₂O. This is an amide linkage.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: enzymes — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'enzymes — Practice',
  content: <<~MARKDOWN,
# enzymes — Practice 🚀

Enzymes are proteins that act as biological catalysts. They are highly specific and work at body temperature/pH.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['enzymes'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Enzymes are:',
    options: ['Biological catalysts (proteins)', 'Carbohydrates', 'Lipids', 'Nucleic acids'],
    correct_answer: 0,
    explanation: 'Enzymes are proteins that act as biological catalysts. They are highly specific and work at body temperature/pH.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: vitamins — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'vitamins — Practice',
  content: <<~MARKDOWN,
# vitamins — Practice 🚀

Water-soluble: B-complex ✓, C ✓. Fat-soluble: A, D, E, K. Water-soluble vitamins are not stored in body.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['vitamins'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which vitamins are water-soluble?',
    options: ['Vitamin B-complex', 'Vitamin C (Ascorbic acid)', 'Vitamin A', 'Vitamin D'],
    correct_answer: 1,
    explanation: 'Water-soluble: B-complex ✓, C ✓. Fat-soluble: A, D, E, K. Water-soluble vitamins are not stored in body.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 13: nucleic_acids — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'nucleic_acids — Practice',
  content: <<~MARKDOWN,
# nucleic_acids — Practice 🚀

DNA base pairing: A-T (2 H-bonds), G-C (3 H-bonds). RNA has uracil (U) instead of thymine (T).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['nucleic_acids'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In DNA, adenine pairs with:',
    options: ['Thymine (2 H-bonds)', 'Cytosine', 'Guanine', 'Uracil'],
    correct_answer: 0,
    explanation: 'DNA base pairing: A-T (2 H-bonds), G-C (3 H-bonds). RNA has uracil (U) instead of thymine (T).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 14: Carbohydrates - Structure and Classification ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Carbohydrates - Structure and Classification',
  content: <<~MARKDOWN,
# Carbohydrates - Structure and Classification 🚀

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

## Key Points

- Carbohydrates

- Monosaccharides

- Glucose
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Carbohydrates', 'Monosaccharides', 'Glucose', 'Fructose', 'Disaccharides', 'Polysaccharides', 'Starch', 'Cellulose'],
  prerequisite_ids: []
)

puts "✓ Created 14 microlessons for Biomolecules"

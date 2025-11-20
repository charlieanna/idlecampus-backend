# frozen_string_literal: true

# ========================================
# IIT JEE Organic Chemistry - Module 11
# Aldehydes and Ketones
# ========================================
# Complete module with lessons and questions
# Covers: Nomenclature, preparation, nucleophilic addition, aldol, Cannizzaro, oxidation/reduction
# ========================================

puts "\n" + "=" * 80
puts "MODULE 11: ALDEHYDES AND KETONES"
puts "=" * 80

# Find or create the Organic Chemistry course
course = Course.find_or_create_by!(slug: 'iit-jee-organic-chemistry') do |c|
  c.title = 'IIT JEE Organic Chemistry'
  c.description = 'Comprehensive Organic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty = 'advanced'
  c.estimated_hours = 150
  c.published = true
end

# Create Module 11: Aldehydes and Ketones
module_11 = course.course_modules.find_or_create_by!(slug: 'aldehydes-ketones') do |m|
  m.title = 'Aldehydes and Ketones'
  m.sequence_order = 11
  m.estimated_minutes = 1080  # 18 hours
  m.description = 'Carbonyl compounds: nomenclature, preparation, nucleophilic addition reactions, and important named reactions'
  m.learning_objectives = [
    'Master nomenclature and structure of carbonyl compounds',
    'Understand preparation methods from alcohols and alkynes',
    'Learn nucleophilic addition mechanism and reactions',
    'Master aldol condensation and Cannizzaro reaction',
    'Understand oxidation and reduction of carbonyl compounds',
    'Solve IIT JEE problems on mechanisms and product prediction'
  ]
  m.published = true
end

puts "✅ Module 11: #{module_11.title}"

# ========================================
# Lesson 11.1: Aldehydes and Ketones - Structure, Nomenclature, and Preparation
# ========================================

lesson_11_1 = CourseLesson.create!(
  title: 'Aldehydes and Ketones - Structure, Nomenclature, and Preparation',
  reading_time_minutes: 65,
  key_concepts: ['Carbonyl group', 'Aldehydes', 'Ketones', 'Nomenclature', 'Preparation methods', 'Oxidation of alcohols'],
  content: <<~MD
    # Aldehydes and Ketones

    ## Introduction

    **Carbonyl compounds** contain the carbonyl group: C=O

    **Two main classes:**
    1. **Aldehydes:** Carbonyl carbon bonded to at least one H atom
    2. **Ketones:** Carbonyl carbon bonded to two carbon atoms

    ---

    ## Structure of Carbonyl Group

    ```
         O          (Oxygen: sp² hybridized)
         ║
    R -- C -- H     (Carbon: sp² hybridized, trigonal planar)

    Bond angle: ~120° (sp²)
    ```

    **Key features:**
    - **C=O double bond:** 1 σ bond + 1 π bond
    - **sp² hybridized carbon:** Trigonal planar geometry
    - **Polar bond:** δ⁺C=Oδ⁻ (O more electronegative)
    - **Electrophilic carbon:** Susceptible to nucleophilic attack

    ---

    ## Aldehydes

    **General formula:** R-CHO

    **Functional group:** -CHO (formyl group)

    **Structure:**
    ```
         O
         ║
    R -- C -- H
    ```

    **Examples:**
    - HCHO (Formaldehyde/Methanal)
    - CH₃CHO (Acetaldehyde/Ethanal)
    - C₆H₅CHO (Benzaldehyde)

    ---

    ## Ketones

    **General formula:** R-CO-R' (R and R' = alkyl/aryl)

    **Functional group:** >C=O (carbonyl group)

    **Structure:**
    ```
         O
         ║
    R -- C -- R'
    ```

    **Examples:**
    - CH₃COCH₃ (Acetone/Propanone)
    - CH₃COC₂H₅ (Methyl ethyl ketone/Butanone)
    - C₆H₅COC₆H₅ (Benzophenone)

    ---

    ## IUPAC Nomenclature

    ### Aldehydes: -al suffix

    **Rules:**
    1. Select longest chain containing -CHO
    2. -CHO carbon is always position 1
    3. Replace -e with -al

    **Examples:**

    | Structure | IUPAC Name | Common Name |
    |-----------|------------|-------------|
    | HCHO | Methanal | Formaldehyde |
    | CH₃CHO | Ethanal | Acetaldehyde |
    | CH₃CH₂CHO | Propanal | Propionaldehyde |
    | CH₃CH₂CH₂CHO | Butanal | Butyraldehyde |
    | C₆H₅CHO | Benzenecarbaldehyde | Benzaldehyde |

    ### Ketones: -one suffix

    **Rules:**
    1. Select longest chain containing >C=O
    2. Number to give C=O lowest number
    3. Replace -e with -one

    **Examples:**

    | Structure | IUPAC Name | Common Name |
    |-----------|------------|-------------|
    | CH₃COCH₃ | Propanone | Acetone |
    | CH₃COC₂H₅ | Butanone | Methyl ethyl ketone (MEK) |
    | CH₃COCH₂CH₃ | Butanone | — |
    | CH₃CH₂COCH₂CH₃ | Pentan-3-one | Diethyl ketone |
    | C₆H₅COCH₃ | Phenylethanone | Acetophenone |

    ---

    ## Physical Properties

    ### 1. State and Odor
    - **Lower members:** Pleasant smell
    - **Formaldehyde:** Pungent gas
    - **Acetone:** Sweet smell, volatile liquid

    ### 2. Boiling Point

    **Comparison:**
    - **Aldehydes/Ketones < Alcohols** (no H-bonding between carbonyl molecules)
    - **Aldehydes/Ketones > Alkanes** (polar C=O, dipole-dipole)

    **Example:**
    - CH₃CHO (21°C) < CH₃CH₂OH (78°C)
    - CH₃COCH₃ (56°C) < CH₃CH₂CH₂OH (97°C)

    ### 3. Solubility
    - **Lower members (C1-C4):** Soluble in water (H-bonding with water)
    - **Higher members:** Decrease in solubility
    - **All:** Soluble in organic solvents

    ---

    ## Preparation of Aldehydes

    ### Method 1: Oxidation of Primary Alcohols

    **With PCC (mild):**
    ```
    R-CH₂-OH --[PCC]--> R-CHO (stops at aldehyde)
    ```

    **With K₂Cr₂O₇/H⁺ (strong):**
    ```
    R-CH₂-OH --[K₂Cr₂O₇/H⁺]--> R-CHO --[further]--> R-COOH
    ```

    **Best for aldehydes:** PCC (Pyridinium chlorochromate)

    ### Method 2: Ozonolysis of Alkenes
    ```
    R-CH=CH-R' --[1. O₃, 2. Zn/H₂O]--> R-CHO + R'-CHO
    ```

    **Breaks C=C bond**

    ### Method 3: Rosenmund Reduction
    ```
    R-COCl --[H₂, Pd-BaSO₄, S]--> R-CHO + HCl
    ```

    **Acid chloride → Aldehyde**

    **Poison (S):** Prevents over-reduction to alcohol

    ### Method 4: Stephen Reaction
    ```
    R-C≡N --[SnCl₂/HCl, H₂O]--> R-CHO
    ```

    **Nitrile → Aldehyde**

    ### Method 5: From Alkynes (Hydration)
    ```
    R-C≡C-H + H₂O --[H₂SO₄, HgSO₄]--> R-CO-CH₃ (ketone, Markovnikov)
    ```

    **Terminal alkyne → Methyl ketone**

    **For aldehyde (Anti-Markovnikov):**
    ```
    R-C≡C-H --[1. Hydroboration, 2. Oxidation]--> R-CH₂-CHO
    ```

    ---

    ## Preparation of Ketones

    ### Method 1: Oxidation of Secondary Alcohols
    ```
    R₂CH-OH --[K₂Cr₂O₇/H⁺]--> R₂C=O
    ```

    **Does NOT oxidize further** (no H on carbonyl carbon)

    ### Method 2: From Alkynes (Hydration)
    ```
    R-C≡C-R' + H₂O --[H₂SO₄, HgSO₄]--> R-CO-CH₂-R'
    ```

    ### Method 3: From Nitriles (Grignard)
    ```
    R-C≡N + R'-MgX → R-CO-R' (after hydrolysis)
    ```

    ### Method 4: Friedel-Crafts Acylation
    ```
    C₆H₆ + R-COCl --[AlCl₃]--> C₆H₅-CO-R + HCl
    ```

    **Best for aromatic ketones**

    **Example:**
    ```
    C₆H₆ + CH₃COCl → C₆H₅COCH₃ (Acetophenone)
    ```

    ### Method 5: Decarboxylation of Carboxylic Acids
    ```
    R-COOH + Ca(OH)₂ --[heat]--> (R-COO)₂Ca --[heat]--> R-CO-R + CaCO₃
    ```

    **Two acid molecules → One ketone**

    ---

    ## Reactivity of Carbonyl Group

    **Why is C=O reactive?**

    1. **Polarization:** δ⁺C=Oδ⁻
    2. **Electrophilic carbon:** Attracts nucleophiles
    3. **π bond is weaker:** Easier to break than σ bond

    **Reactivity order:**
    ```
    Aldehydes > Ketones
    ```

    **Reasons:**
    1. **Electronic:** Aldehyde has only 1 R group (+I effect), ketone has 2
    2. **Steric:** Aldehyde less hindered

    ---

    ## Tests to Distinguish Aldehydes and Ketones

    ### 1. Tollen's Test (Silver Mirror Test)

    **Reagent:** Tollen's reagent [Ag(NH₃)₂]⁺

    **Aldehydes:**
    ```
    R-CHO + 2[Ag(NH₃)₂]⁺ + 3OH⁻ → R-COO⁻ + 2Ag↓ + 4NH₃ + 2H₂O
                                        (Silver mirror)
    ```

    **Ketones:** No reaction

    ### 2. Fehling's Test

    **Reagent:** Fehling's A (CuSO₄) + Fehling's B (Rochelle salt in NaOH)

    **Aldehydes:**
    ```
    R-CHO + 2Cu²⁺ + 5OH⁻ → R-COO⁻ + Cu₂O↓ + 3H₂O
                              (Red precipitate)
    ```

    **Ketones:** No reaction

    **Note:** Aromatic aldehydes (C₆H₅CHO) do NOT give Fehling's test

    ### 3. Benedict's Test

    Similar to Fehling's test
    - **Aldehydes:** Red precipitate (Cu₂O)
    - **Ketones:** No reaction

    ### 4. Schiff's Test

    **Reagent:** Schiff's reagent (decolorized fuchsin)

    **Aldehydes:** Pink/magenta color
    **Ketones:** No color

    ### 5. Sodium Bisulfite Test

    **Both aldehydes and ketones** (not a distinction test)
    ```
    R₂C=O + NaHSO₃ → R₂C(OH)(SO₃Na) (white crystalline addition product)
    ```

    **Use:** Separation and purification

    ---

    ## IIT JEE Key Points

    1. **Carbonyl group:** C=O (sp², trigonal planar, 120°)
    2. **Aldehydes:** R-CHO (-al), **Ketones:** R-CO-R' (-one)
    3. **Reactivity:** Aldehydes > Ketones (electronic + steric)
    4. **1° alcohol → Aldehyde** (PCC stops at aldehyde)
    5. **2° alcohol → Ketone** (cannot oxidize further)
    6. **Rosenmund:** R-COCl → R-CHO (Pd-BaSO₄, poison)
    7. **Friedel-Crafts acylation:** Best for aromatic ketones
    8. **Tollen's/Fehling's:** Aldehydes positive, ketones negative
    9. **Aromatic aldehydes:** No Fehling's test
    10. **Boiling point:** Aldehydes/Ketones < Alcohols (no H-bonding)
  MD
)

ModuleItem.create!(course_module: module_11, item: lesson_11_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 11.1: #{lesson_11_1.title}"

# ========================================
# Quiz 11.1: Aldehydes and Ketones Basics
# ========================================

quiz_11_1 = Quiz.create!(
  title: 'Aldehydes and Ketones - Structure and Preparation',
  description: 'Test your understanding of carbonyl compounds, nomenclature, and preparation methods',
  time_limit_minutes: 25,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_11, item: quiz_11_1, sequence_order: 2, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_11_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which reagent is used to oxidize primary alcohols to aldehydes WITHOUT further oxidation to carboxylic acid?',
    options: [
      { text: 'K₂Cr₂O₇/H⁺', correct: false },
      { text: 'KMnO₄', correct: false },
      { text: 'PCC (Pyridinium chlorochromate)', correct: true },
      { text: 'Conc. HNO₃', correct: false }
    ],
    explanation: 'PCC is a mild oxidizing agent that stops at aldehyde. K₂Cr₂O₇/H⁺ and KMnO₄ are strong oxidizers that continue to carboxylic acid. R-CH₂-OH → [PCC] → R-CHO.',
    points: 3,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'preparation',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  {
    quiz: quiz_11_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Why are aldehydes MORE reactive than ketones in nucleophilic addition?',
    options: [
      { text: 'Aldehydes have higher boiling point', correct: false },
      { text: 'Aldehydes have less steric hindrance and less +I effect', correct: true },
      { text: 'Ketones cannot form carbonyl compounds', correct: false },
      { text: 'Aldehydes are more polar', correct: false }
    ],
    explanation: 'Aldehydes are more reactive due to: (1) Less steric hindrance (only 1 R group vs 2 in ketone), (2) Less +I effect (1 R group vs 2), making carbonyl carbon more electrophilic.',
    points: 3,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'reactivity',
    skill_dimension: 'comprehension',
    sequence_order: 2
  },

  {
    quiz: quiz_11_1,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which tests are positive for aldehydes but negative for ketones?',
    options: [
      { text: 'Tollen\'s test (Silver mirror)', correct: true },
      { text: 'Fehling\'s test (Red ppt)', correct: true },
      { text: 'Sodium bisulfite test', correct: false },
      { text: 'Iodoform test', correct: false }
    ],
    explanation: 'Aldehyde-specific tests: (1) Tollen\'s - silver mirror ✓, (2) Fehling\'s/Benedict\'s - red ppt ✓. NaHSO₃ reacts with both. Iodoform test is for methyl ketones (CH₃CO-R).',
    points: 4,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'tests',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  {
    quiz: quiz_11_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Rosenmund reduction converts:',
    options: [
      { text: 'Aldehyde to alcohol', correct: false },
      { text: 'Acid chloride to aldehyde', correct: true },
      { text: 'Ketone to alcohol', correct: false },
      { text: 'Nitrile to amine', correct: false }
    ],
    explanation: 'Rosenmund reduction: R-COCl + H₂ → [Pd-BaSO₄, poison S] → R-CHO + HCl. Acid chloride reduces to aldehyde. Poison prevents over-reduction to alcohol.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'preparation',
    skill_dimension: 'recall',
    sequence_order: 4
  },

  {
    quiz: quiz_11_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Friedel-Crafts acylation of benzene with CH₃COCl gives:',
    options: [
      { text: 'Benzaldehyde', correct: false },
      { text: 'Acetophenone', correct: true },
      { text: 'Benzophenone', correct: false },
      { text: 'Benzoic acid', correct: false }
    ],
    explanation: 'Friedel-Crafts acylation: C₆H₆ + CH₃COCl → [AlCl₃] → C₆H₅COCH₃ (Acetophenone/Phenylethanone) + HCl. Best method for aromatic ketones.',
    points: 2,
    difficulty: -0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'preparation',
    skill_dimension: 'application',
    sequence_order: 5
  },

  {
    quiz: quiz_11_1,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'The bond angle around carbonyl carbon in aldehydes and ketones is approximately:',
    options: [
      { text: '109.5° (tetrahedral)', correct: false },
      { text: '120° (trigonal planar)', correct: true },
      { text: '180° (linear)', correct: false },
      { text: '90° (square planar)', correct: false }
    ],
    explanation: 'Carbonyl carbon is sp² hybridized with trigonal planar geometry, bond angle ≈ 120°. Similar to alkenes (C=C). sp³ = 109.5°, sp = 180°.',
    points: 2,
    difficulty: -0.2,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'structure',
    skill_dimension: 'recall',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 11.1: #{quiz_11_1.title} (#{quiz_11_1.quiz_questions.count} questions)"

# ========================================
# Lesson 11.2: Nucleophilic Addition Reactions
# ========================================

lesson_11_2 = CourseLesson.create!(
  title: 'Nucleophilic Addition Reactions and Important Reactions',
  reading_time_minutes: 70,
  key_concepts: ['Nucleophilic addition', 'Aldol condensation', 'Cannizzaro reaction', 'Reduction', 'Oxidation', 'Grignard reagents'],
  content: <<~MD
    # Nucleophilic Addition Reactions

    ## Mechanism of Nucleophilic Addition

    **General mechanism:**

    ```
    Step 1: Nucleophilic attack
         δ⁺  δ⁻
         C = O  + Nu⁻ → C-O⁻
         |               |
         R               Nu

    Step 2: Protonation
         C-O⁻ + H⁺ → C-OH
         |            |
         Nu           Nu
    ```

    **Key feature:** Addition across C=O bond

    ---

    ## Important Nucleophilic Addition Reactions

    ### 1. Addition of HCN (Cyanohydrin Formation)

    **Reaction:**
    ```
    R₂C=O + HCN → R₂C(OH)(CN)  (Cyanohydrin)
    ```

    **Mechanism:**
    ```
    CN⁻ attacks C=O → R₂C(O⁻)(CN) → R₂C(OH)(CN)
    ```

    **Use:** Chain extension (CN can be converted to -COOH, -CH₂NH₂)

    **Example:**
    ```
    CH₃CHO + HCN → CH₃CH(OH)(CN) (Acetaldehyde cyanohydrin)
    ```

    ### 2. Addition of Grignard Reagent

    **Grignard reagent:** R-MgX (acts as R⁻ nucleophile)

    **With Formaldehyde → 1° Alcohol:**
    ```
    R-MgX + H₂C=O → R-CH₂-OH (after H₃O⁺)
    ```

    **With Other Aldehydes → 2° Alcohol:**
    ```
    R-MgX + R'-CHO → R-CH(OH)-R' (after H₃O⁺)
    ```

    **With Ketones → 3° Alcohol:**
    ```
    R-MgX + R'-CO-R" → R-C(OH)(R')(R") (after H₃O⁺)
    ```

    ### 3. Addition of Alcohols

    #### (a) Formation of Hemiacetal (1 alcohol)
    ```
    R-CHO + R'-OH ⇌ R-CH(OH)(OR')  (Hemiacetal)
    ```

    #### (b) Formation of Acetal (2 alcohols)
    ```
    R-CHO + 2R'-OH --[H⁺]--> R-CH(OR')₂ + H₂O  (Acetal)
    ```

    **For ketones:** Hemiketal and Ketal

    **Use:** Protecting group for aldehydes/ketones

    ### 4. Addition of Ammonia Derivatives

    **General reaction:**
    ```
    R₂C=O + H₂N-Z → R₂C=N-Z + H₂O
    ```

    **Important derivatives:**

    | Reagent | Product | Name |
    |---------|---------|------|
    | NH₃ | R₂C=NH | Imine |
    | NH₂OH | R₂C=NOH | Oxime |
    | NH₂-NH₂ | R₂C=NNH₂ | Hydrazone |
    | NH₂-NH-C₆H₅ | R₂C=NNH-C₆H₅ | Phenylhydrazone |
    | NH₂-NH-CO-NH₂ | R₂C=NNHCONH₂ | Semicarbazone |

    **Use:** Identification and purification (crystalline derivatives)

    ---

    ## Reduction Reactions

    ### 1. Reduction to Alcohols

    **With LiAlH₄ or NaBH₄:**
    ```
    R-CHO → R-CH₂-OH (1° alcohol)
    R₂C=O → R₂CH-OH (2° alcohol)
    ```

    **Catalytic hydrogenation:**
    ```
    R₂C=O + H₂ --[Ni/Pt/Pd]--> R₂CH-OH
    ```

    ### 2. Clemmensen Reduction (to Alkane)

    **Reagent:** Zn-Hg / HCl

    ```
    R-CHO → R-CH₃
    R₂C=O → R₂CH₂
    ```

    **Conditions:** Acidic (Zn-Hg amalgam)

    ### 3. Wolff-Kishner Reduction (to Alkane)

    **Reagent:** NH₂-NH₂, KOH, heat

    ```
    R-CHO → R-CH₃
    R₂C=O → R₂CH₂
    ```

    **Conditions:** Basic

    **Mechanism:**
    ```
    R₂C=O → R₂C=NNH₂ → R₂CH₂ + N₂
    ```

    ---

    ## Oxidation Reactions

    ### 1. Aldehydes

    **Easily oxidized to carboxylic acids:**
    ```
    R-CHO --[K₂Cr₂O₇/H⁺ or KMnO₄]--> R-COOH
    ```

    **Even mild oxidizing agents work:**
    ```
    R-CHO --[Tollen's or Fehling's]--> R-COOH
    ```

    ### 2. Ketones

    **Generally NOT oxidized** (no H on carbonyl carbon)

    **Exceptional case:** Baeyer-Villiger oxidation
    ```
    R-CO-R' --[Peracid (R-CO-OOH)]--> R-COO-R' (Ester)
    ```

    **Oxygen insertion between C=O and R**

    ---

    ## Aldol Condensation

    **Reaction:** Self-condensation of aldehydes/ketones with α-hydrogen

    **Requirement:** Must have α-hydrogen (hydrogen on carbon adjacent to C=O)

    ### Mechanism (Base-catalyzed)

    **Step 1: Enolate formation**
    ```
    CH₃-CHO + OH⁻ → CH₂⁻-CHO (Enolate anion)
                      ↓ ←→ ↓
                    CH₂=CH-O⁻ (resonance)
    ```

    **Step 2: Nucleophilic attack**
    ```
    CH₂⁻-CHO + CH₃-CHO → CH₃-CH(O⁻)-CH₂-CHO
    ```

    **Step 3: Protonation**
    ```
    CH₃-CH(O⁻)-CH₂-CHO + H⁺ → CH₃-CH(OH)-CH₂-CHO (Aldol)
                                  (β-hydroxy aldehyde)
    ```

    **Step 4: Dehydration (on heating)**
    ```
    CH₃-CH(OH)-CH₂-CHO --[heat, -H₂O]--> CH₃-CH=CH-CHO (α,β-unsaturated aldehyde)
    ```

    **Overall:**
    ```
    2CH₃CHO --[Base, heat]--> CH₃CH=CH-CHO + H₂O
    (Acetaldehyde)            (Crotonaldehyde/But-2-enal)
    ```

    **Products:**
    - **Without heat:** β-hydroxy aldehyde/ketone (Aldol)
    - **With heat:** α,β-unsaturated aldehyde/ketone (Aldol condensation product)

    **Cross-aldol:** Between two different aldehydes (gives mixture)

    ---

    ## Cannizzaro Reaction

    **Reaction:** Disproportionation of aldehydes **WITHOUT α-hydrogen**

    **Requirement:** No α-hydrogen

    **Examples of aldehydes without α-H:**
    - HCHO (Formaldehyde)
    - C₆H₅CHO (Benzaldehyde)
    - (CH₃)₃C-CHO (Trimethylacetaldehyde)

    ### Mechanism

    ```
    Step 1: Hydride transfer
    2C₆H₅CHO + OH⁻ → C₆H₅CH(OH)-O⁻ → C₆H₅CH₂OH + C₆H₅COO⁻
                                      (Benzyl alcohol) (Benzoate)
    ```

    **Overall:**
    ```
    2C₆H₅CHO + NaOH → C₆H₅CH₂OH + C₆H₅COONa
                      (Alcohol)    (Salt of acid)
    ```

    **One molecule is reduced (→ alcohol), one is oxidized (→ acid)**

    **Crossed Cannizzaro:**
    - HCHO + R-CHO → CH₃OH + R-COO⁻
    - HCHO preferentially oxidizes (gives CH₃OH)

    ---

    ## Iodoform Test

    **For:** Methyl ketones (CH₃CO-R) or compounds giving CH₃CO- on oxidation

    **Reagent:** I₂ + NaOH

    **Reaction:**
    ```
    CH₃-CO-R + 3I₂ + 4NaOH → CHI₃↓ + R-COONa + 3NaI + 3H₂O
                              (Yellow ppt)
    ```

    **Positive test:**
    - Methyl ketones: CH₃COCH₃, CH₃COC₂H₅
    - Acetaldehyde: CH₃CHO
    - Ethanol: CH₃CH₂OH (oxidizes to CH₃CHO)
    - 2° alcohols with CH₃CH(OH)- structure

    **Yellow precipitate of CHI₃ (Iodoform)** is diagnostic

    ---

    ## IIT JEE Key Points

    1. **Nucleophilic addition:** Nu⁻ attacks electrophilic C of C=O
    2. **Aldehydes > Ketones** in reactivity (less steric, less +I)
    3. **Grignard:** HCHO → 1°, R-CHO → 2°, R₂CO → 3° alcohol
    4. **Clemmensen:** Zn-Hg/HCl (acidic), **Wolff-Kishner:** NH₂NH₂/KOH (basic)
    5. **Both reduce C=O to CH₂**
    6. **Aldol:** Needs α-H, gives β-hydroxy carbonyl → α,β-unsaturated (on heating)
    7. **Cannizzaro:** No α-H, disproportionation (one → alcohol, one → acid)
    8. **Iodoform:** CH₃CO-R or CH₃CH(OH)-R → yellow ppt (CHI₃)
    9. **Oxidation:** Aldehydes easily oxidized, ketones generally not
    10. **Baeyer-Villiger:** Ketone + peracid → Ester (O insertion)
  MD
)

ModuleItem.create!(course_module: module_11, item: lesson_11_2, sequence_order: 3, required: true)

puts "  ✓ Lesson 11.2: #{lesson_11_2.title}"

# ========================================
# Quiz 11.2: Reactions of Aldehydes and Ketones
# ========================================

quiz_11_2 = Quiz.create!(
  title: 'Aldehydes and Ketones - Reactions and Mechanisms',
  description: 'Test your understanding of nucleophilic addition, aldol condensation, and Cannizzaro reaction',
  time_limit_minutes: 30,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_11, item: quiz_11_2, sequence_order: 4, required: true)

QuizQuestion.create!([
  {
    quiz: quiz_11_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Aldol condensation requires the carbonyl compound to have:',
    options: [
      { text: 'No α-hydrogen', correct: false },
      { text: 'At least one α-hydrogen', correct: true },
      { text: 'Aromatic ring', correct: false },
      { text: 'Two carbonyl groups', correct: false }
    ],
    explanation: 'Aldol condensation needs α-hydrogen (H on carbon adjacent to C=O) to form enolate anion. Example: CH₃CHO (has α-H) undergoes aldol, but C₆H₅CHO (no α-H) undergoes Cannizzaro.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'aldol_condensation',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  {
    quiz: quiz_11_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Cannizzaro reaction is given by:',
    options: [
      { text: 'Aldehydes with α-hydrogen', correct: false },
      { text: 'Aldehydes without α-hydrogen', correct: true },
      { text: 'All ketones', correct: false },
      { text: 'Carboxylic acids', correct: false }
    ],
    explanation: 'Cannizzaro: Aldehydes WITHOUT α-H undergo disproportionation. HCHO, C₆H₅CHO, (CH₃)₃C-CHO give Cannizzaro. One molecule → alcohol, one → acid.',
    points: 2,
    difficulty: -0.1,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'cannizzaro_reaction',
    skill_dimension: 'recall',
    sequence_order: 2
  },

  {
    quiz: quiz_11_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which reagents reduce carbonyl compounds to alkanes (C=O → CH₂)?',
    options: [
      { text: 'Clemmensen reduction (Zn-Hg/HCl)', correct: true },
      { text: 'Wolff-Kishner reduction (NH₂NH₂/KOH)', correct: true },
      { text: 'LiAlH₄', correct: false },
      { text: 'NaBH₄', correct: false }
    ],
    explanation: 'To alkane: (1) Clemmensen (Zn-Hg/HCl, acidic) ✓, (2) Wolff-Kishner (NH₂NH₂/KOH, basic) ✓. LiAlH₄ and NaBH₄ reduce to alcohols (R-CH₂OH or R₂CHOH), not alkanes.',
    points: 4,
    difficulty: 0.2,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'reduction',
    skill_dimension: 'recall',
    sequence_order: 3
  },

  {
    quiz: quiz_11_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Iodoform test is positive for:',
    options: [
      { text: 'All aldehydes', correct: false },
      { text: 'Methyl ketones (CH₃CO-R)', correct: true },
      { text: 'Carboxylic acids', correct: false },
      { text: 'Ethers', correct: false }
    ],
    explanation: 'Iodoform test (I₂/NaOH) is positive for methyl ketones (CH₃CO-R) and compounds giving CH₃CO- on oxidation (CH₃CHO, CH₃CH₂OH). Yellow ppt of CHI₃ forms.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'iodoform_test',
    skill_dimension: 'recall',
    sequence_order: 4
  },

  {
    quiz: quiz_11_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Product of aldol condensation of acetaldehyde (with heating) is:',
    options: [
      { text: 'CH₃CH(OH)CH₂CHO', correct: false },
      { text: 'CH₃CH=CHCHO', correct: true },
      { text: 'CH₃COOH', correct: false },
      { text: 'CH₃CH₂OH', correct: false }
    ],
    explanation: '2CH₃CHO → [Base] → CH₃CH(OH)CH₂CHO (aldol) → [heat, -H₂O] → CH₃CH=CHCHO (crotonaldehyde, α,β-unsaturated aldehyde). Without heat, product is β-hydroxy aldehyde.',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'aldol_condensation',
    skill_dimension: 'application',
    sequence_order: 5
  },

  {
    quiz: quiz_11_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Grignard reagent (R-MgX) reacts with formaldehyde to give (after hydrolysis):',
    options: [
      { text: 'Primary alcohol', correct: true },
      { text: 'Secondary alcohol', correct: false },
      { text: 'Tertiary alcohol', correct: false },
      { text: 'Ketone', correct: false }
    ],
    explanation: 'R-MgX + H₂C=O → R-CH₂-OH (1° alcohol). With other aldehydes → 2° alcohol. With ketones → 3° alcohol. Grignard acts as R⁻ nucleophile.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'grignard_reactions',
    skill_dimension: 'recall',
    sequence_order: 6
  }
])

puts "  ✓ Quiz 11.2: #{quiz_11_2.title} (#{quiz_11_2.quiz_questions.count} questions)"

puts "\n" + "=" * 80
puts "MODULE 11 COMPLETE: Aldehydes and Ketones"
puts "Total Lessons: 2"
puts "Total Quizzes: 2"
puts "Total Questions: #{QuizQuestion.where(quiz_id: [quiz_11_1.id, quiz_11_2.id]).count}"
puts "=" * 80

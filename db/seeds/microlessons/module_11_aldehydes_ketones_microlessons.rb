# AUTO-GENERATED from module_11_aldehydes_ketones.rb
puts "Creating Microlessons for Aldehydes Ketones..."

module_var = CourseModule.find_by(slug: 'aldehydes-ketones')

# === MICROLESSON 1: grignard_reactions — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'grignard_reactions — Practice',
  content: <<~MARKDOWN,
# grignard_reactions — Practice 🚀

R-MgX + H₂C=O → R-CH₂-OH (1° alcohol). With other aldehydes → 2° alcohol. With ketones → 3° alcohol. Grignard acts as R⁻ nucleophile.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['grignard_reactions'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Grignard reagent (R-MgX) reacts with formaldehyde to give (after hydrolysis):',
    options: ['Primary alcohol', 'Secondary alcohol', 'Tertiary alcohol', 'Ketone'],
    correct_answer: 0,
    explanation: 'R-MgX + H₂C=O → R-CH₂-OH (1° alcohol). With other aldehydes → 2° alcohol. With ketones → 3° alcohol. Grignard acts as R⁻ nucleophile.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 2: Nucleophilic Addition Reactions and Important Reactions ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Nucleophilic Addition Reactions and Important Reactions',
  content: <<~MARKDOWN,
# Nucleophilic Addition Reactions and Important Reactions 🚀

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

## Key Points

- Nucleophilic addition

- Aldol condensation

- Cannizzaro reaction
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Nucleophilic addition', 'Aldol condensation', 'Cannizzaro reaction', 'Reduction', 'Oxidation', 'Grignard reagents'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Aldehydes and Ketones - Structure, Nomenclature, and Preparation ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Aldehydes and Ketones - Structure, Nomenclature, and Preparation',
  content: <<~MARKDOWN,
# Aldehydes and Ketones - Structure, Nomenclature, and Preparation 🚀

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

## Key Points

- Carbonyl group

- Aldehydes

- Ketones
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Carbonyl group', 'Aldehydes', 'Ketones', 'Nomenclature', 'Preparation methods', 'Oxidation of alcohols'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Nucleophilic Addition Reactions and Important Reactions ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Nucleophilic Addition Reactions and Important Reactions',
  content: <<~MARKDOWN,
# Nucleophilic Addition Reactions and Important Reactions 🚀

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

## Key Points

- Nucleophilic addition

- Aldol condensation

- Cannizzaro reaction
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Nucleophilic addition', 'Aldol condensation', 'Cannizzaro reaction', 'Reduction', 'Oxidation', 'Grignard reagents'],
  prerequisite_ids: []
)

# === MICROLESSON 5: preparation — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'preparation — Practice',
  content: <<~MARKDOWN,
# preparation — Practice 🚀

PCC is a mild oxidizing agent that stops at aldehyde. K₂Cr₂O₇/H⁺ and KMnO₄ are strong oxidizers that continue to carboxylic acid. R-CH₂-OH → [PCC] → R-CHO.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['preparation'],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which reagent is used to oxidize primary alcohols to aldehydes WITHOUT further oxidation to carboxylic acid?',
    options: ['K₂Cr₂O₇/H⁺', 'KMnO₄', 'PCC (Pyridinium chlorochromate)', 'Conc. HNO₃'],
    correct_answer: 2,
    explanation: 'PCC is a mild oxidizing agent that stops at aldehyde. K₂Cr₂O₇/H⁺ and KMnO₄ are strong oxidizers that continue to carboxylic acid. R-CH₂-OH → [PCC] → R-CHO.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: reactivity — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'reactivity — Practice',
  content: <<~MARKDOWN,
# reactivity — Practice 🚀

Aldehydes are more reactive due to: (1) Less steric hindrance (only 1 R group vs 2 in ketone), (2) Less +I effect (1 R group vs 2), making carbonyl carbon more electrophilic.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['reactivity'],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why are aldehydes MORE reactive than ketones in nucleophilic addition?',
    options: ['Aldehydes have higher boiling point', 'Aldehydes have less steric hindrance and less +I effect', 'Ketones cannot form carbonyl compounds', 'Aldehydes are more polar'],
    correct_answer: 1,
    explanation: 'Aldehydes are more reactive due to: (1) Less steric hindrance (only 1 R group vs 2 in ketone), (2) Less +I effect (1 R group vs 2), making carbonyl carbon more electrophilic.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 7: tests — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'tests — Practice',
  content: <<~MARKDOWN,
# tests — Practice 🚀

Aldehyde-specific tests: (1) Tollen\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['tests'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which tests are positive for aldehydes but negative for ketones?',
    options: ['Sodium bisulfite test', 'Iodoform test'],
    correct_answer: 0,
    explanation: 'Aldehyde-specific tests: (1) Tollen\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 8: preparation — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'preparation — Practice',
  content: <<~MARKDOWN,
# preparation — Practice 🚀

Rosenmund reduction: R-COCl + H₂ → [Pd-BaSO₄, poison S] → R-CHO + HCl. Acid chloride reduces to aldehyde. Poison prevents over-reduction to alcohol.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['preparation'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Rosenmund reduction converts:',
    options: ['Aldehyde to alcohol', 'Acid chloride to aldehyde', 'Ketone to alcohol', 'Nitrile to amine'],
    correct_answer: 1,
    explanation: 'Rosenmund reduction: R-COCl + H₂ → [Pd-BaSO₄, poison S] → R-CHO + HCl. Acid chloride reduces to aldehyde. Poison prevents over-reduction to alcohol.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: preparation — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'preparation — Practice',
  content: <<~MARKDOWN,
# preparation — Practice 🚀

Friedel-Crafts acylation: C₆H₆ + CH₃COCl → [AlCl₃] → C₆H₅COCH₃ (Acetophenone/Phenylethanone) + HCl. Best method for aromatic ketones.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['preparation'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Friedel-Crafts acylation of benzene with CH₃COCl gives:',
    options: ['Benzaldehyde', 'Acetophenone', 'Benzophenone', 'Benzoic acid'],
    correct_answer: 1,
    explanation: 'Friedel-Crafts acylation: C₆H₆ + CH₃COCl → [AlCl₃] → C₆H₅COCH₃ (Acetophenone/Phenylethanone) + HCl. Best method for aromatic ketones.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: structure — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'structure — Practice',
  content: <<~MARKDOWN,
# structure — Practice 🚀

Carbonyl carbon is sp² hybridized with trigonal planar geometry, bond angle ≈ 120°. Similar to alkenes (C=C). sp³ = 109.5°, sp = 180°.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['structure'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The bond angle around carbonyl carbon in aldehydes and ketones is approximately:',
    options: ['109.5° (tetrahedral)', '120° (trigonal planar)', '180° (linear)', '90° (square planar)'],
    correct_answer: 1,
    explanation: 'Carbonyl carbon is sp² hybridized with trigonal planar geometry, bond angle ≈ 120°. Similar to alkenes (C=C). sp³ = 109.5°, sp = 180°.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: aldol_condensation — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'aldol_condensation — Practice',
  content: <<~MARKDOWN,
# aldol_condensation — Practice 🚀

Aldol condensation needs α-hydrogen (H on carbon adjacent to C=O) to form enolate anion. Example: CH₃CHO (has α-H) undergoes aldol, but C₆H₅CHO (no α-H) undergoes Cannizzaro.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['aldol_condensation'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Aldol condensation requires the carbonyl compound to have:',
    options: ['No α-hydrogen', 'At least one α-hydrogen', 'Aromatic ring', 'Two carbonyl groups'],
    correct_answer: 1,
    explanation: 'Aldol condensation needs α-hydrogen (H on carbon adjacent to C=O) to form enolate anion. Example: CH₃CHO (has α-H) undergoes aldol, but C₆H₅CHO (no α-H) undergoes Cannizzaro.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: cannizzaro_reaction — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'cannizzaro_reaction — Practice',
  content: <<~MARKDOWN,
# cannizzaro_reaction — Practice 🚀

Cannizzaro: Aldehydes WITHOUT α-H undergo disproportionation. HCHO, C₆H₅CHO, (CH₃)₃C-CHO give Cannizzaro. One molecule → alcohol, one → acid.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['cannizzaro_reaction'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cannizzaro reaction is given by:',
    options: ['Aldehydes with α-hydrogen', 'Aldehydes without α-hydrogen', 'All ketones', 'Carboxylic acids'],
    correct_answer: 1,
    explanation: 'Cannizzaro: Aldehydes WITHOUT α-H undergo disproportionation. HCHO, C₆H₅CHO, (CH₃)₃C-CHO give Cannizzaro. One molecule → alcohol, one → acid.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: reduction — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'reduction — Practice',
  content: <<~MARKDOWN,
# reduction — Practice 🚀

To alkane: (1) Clemmensen (Zn-Hg/HCl, acidic) ✓, (2) Wolff-Kishner (NH₂NH₂/KOH, basic) ✓. LiAlH₄ and NaBH₄ reduce to alcohols (R-CH₂OH or R₂CHOH), not alkanes.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['reduction'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which reagents reduce carbonyl compounds to alkanes (C=O → CH₂)?',
    options: ['Clemmensen reduction (Zn-Hg/HCl)', 'Wolff-Kishner reduction (NH₂NH₂/KOH)', 'LiAlH₄', 'NaBH₄'],
    correct_answer: 1,
    explanation: 'To alkane: (1) Clemmensen (Zn-Hg/HCl, acidic) ✓, (2) Wolff-Kishner (NH₂NH₂/KOH, basic) ✓. LiAlH₄ and NaBH₄ reduce to alcohols (R-CH₂OH or R₂CHOH), not alkanes.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: iodoform_test — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'iodoform_test — Practice',
  content: <<~MARKDOWN,
# iodoform_test — Practice 🚀

Iodoform test (I₂/NaOH) is positive for methyl ketones (CH₃CO-R) and compounds giving CH₃CO- on oxidation (CH₃CHO, CH₃CH₂OH). Yellow ppt of CHI₃ forms.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['iodoform_test'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Iodoform test is positive for:',
    options: ['All aldehydes', 'Methyl ketones (CH₃CO-R)', 'Carboxylic acids', 'Ethers'],
    correct_answer: 1,
    explanation: 'Iodoform test (I₂/NaOH) is positive for methyl ketones (CH₃CO-R) and compounds giving CH₃CO- on oxidation (CH₃CHO, CH₃CH₂OH). Yellow ppt of CHI₃ forms.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 15: aldol_condensation — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'aldol_condensation — Practice',
  content: <<~MARKDOWN,
# aldol_condensation — Practice 🚀

2CH₃CHO → [Base] → CH₃CH(OH)CH₂CHO (aldol) → [heat, -H₂O] → CH₃CH=CHCHO (crotonaldehyde, α,β-unsaturated aldehyde). Without heat, product is β-hydroxy aldehyde.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['aldol_condensation'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Product of aldol condensation of acetaldehyde (with heating) is:',
    options: ['CH₃CH(OH)CH₂CHO', 'CH₃CH=CHCHO', 'CH₃COOH', 'CH₃CH₂OH'],
    correct_answer: 1,
    explanation: '2CH₃CHO → [Base] → CH₃CH(OH)CH₂CHO (aldol) → [heat, -H₂O] → CH₃CH=CHCHO (crotonaldehyde, α,β-unsaturated aldehyde). Without heat, product is β-hydroxy aldehyde.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: Aldehydes and Ketones - Structure, Nomenclature, and Preparation ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Aldehydes and Ketones - Structure, Nomenclature, and Preparation',
  content: <<~MARKDOWN,
# Aldehydes and Ketones - Structure, Nomenclature, and Preparation 🚀

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

## Key Points

- Carbonyl group

- Aldehydes

- Ketones
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Carbonyl group', 'Aldehydes', 'Ketones', 'Nomenclature', 'Preparation methods', 'Oxidation of alcohols'],
  prerequisite_ids: []
)

puts "✓ Created 16 microlessons for Aldehydes Ketones"

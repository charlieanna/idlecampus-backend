# AUTO-GENERATED from module_10_alcohols_phenols_ethers.rb
puts "Creating Microlessons for Alcohols Phenols Ethers..."

module_var = CourseModule.find_by(slug: 'alcohols-phenols-ethers')

# === MICROLESSON 1: phenol_tests — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'phenol_tests — Practice',
  content: <<~MARKDOWN,
# phenol_tests — Practice 🚀

Tests for phenol: (1) Br₂ water → white ppt (2,4,6-tribromophenol) ✓, (2) FeCl₃ → violet color ✓. Neither phenol nor alcohol reacts with NaHCO₃. Lucas test for alcohols only.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['phenol_tests'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which tests distinguish phenol from alcohol?',
    options: ['Br₂ water gives white precipitate with phenol', 'FeCl₃ gives violet color with phenol', 'Both react with NaHCO₃', 'Both give positive Lucas test'],
    correct_answer: 1,
    explanation: 'Tests for phenol: (1) Br₂ water → white ppt (2,4,6-tribromophenol) ✓, (2) FeCl₃ → violet color ✓. Neither phenol nor alcohol reacts with NaHCO₃. Lucas test for alcohols only.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: Phenols - Acidity, Preparation, and Reactions ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Phenols - Acidity, Preparation, and Reactions',
  content: <<~MARKDOWN,
# Phenols - Acidity, Preparation, and Reactions 🚀

# Phenols

    ## Introduction

    **Phenols** are organic compounds in which -OH group is directly attached to benzene ring.

    **General formula:** Ar-OH (Ar = aromatic ring)

    **Example:** C₆H₅OH (Phenol, carbolic acid)

    **NOT phenols:** C₆H₅CH₂OH (Benzyl alcohol - aromatic alcohol, not phenol)

    ---

    ## Nomenclature

    | Structure | IUPAC Name | Common Name |
    |-----------|------------|-------------|
    | C₆H₅OH | Benzenol | Phenol |
    | o-CH₃-C₆H₄-OH | 2-Methylphenol | o-Cresol |
    | m-CH₃-C₆H₄-OH | 3-Methylphenol | m-Cresol |
    | p-CH₃-C₆H₄-OH | 4-Methylphenol | p-Cresol |
    | C₆H₄(OH)₂ | Benzenediol | Catechol (o-), Resorcinol (m-), Hydroquinone (p-) |

    ---

    ## Acidity of Phenols

    **Phenols are MORE acidic than alcohols**

    ```
    C₆H₅-OH ⇌ C₆H₅-O⁻ + H⁺

    pKa (Phenol) ≈ 10
    pKa (Alcohols) ≈ 15-16
    pKa (Water) = 15.7
    ```

    **Acidity order:**
    ```
    Phenol > H₂O > Alcohols
    ```

    ### Why is Phenol More Acidic?

    **Reason: Resonance stabilization of phenoxide ion**

    **Phenoxide ion (C₆H₅O⁻):**
    ```
         O⁻              O⁻              O⁻
         ║               |               |
    ⟷          ⟷          ⟷

    Negative charge delocalizes into benzene ring
    (4 resonance structures)
    ```

    **Alkoxide ion (R-O⁻):**
    ```
    R-O⁻  (No resonance, charge localized on O)
    ```

    **More stable anion → More acidic**

    ### Effect of Substituents on Acidity

    #### Electron-Withdrawing Groups (EWG) Increase Acidity
    - **-NO₂, -CN, -COOH:** Stabilize phenoxide ion further

    **Examples:**
    ```
    p-NO₂-C₆H₄-OH (pKa 7.1) > m-NO₂-C₆H₄-OH (8.4) > C₆H₅-OH (10.0)
    ```

    **ortho and para effects are stronger** (resonance + inductive)

    #### Electron-Donating Groups (EDG) Decrease Acidity
    - **-CH₃, -OCH₃, -NH₂:** Destabilize phenoxide ion

    **Examples:**
    ```
    C₆H₅-OH (pKa 10.0) > p-CH₃-C₆H₄-OH (10.3) > p-OCH₃-C₆H₄-OH (10.2)
    ```

    **Acidity trend:**
    ```
    p-NO₂-phenol > m-NO₂-phenol > phenol > p-CH₃-phenol
    ```

    ---

    ## Preparation of Phenols

    ### Method 1: From Chlorobenzene (Dow Process)
    ```
    C₆H₅Cl + 2NaOH --[623 K, 300 atm]--> C₆H₅ONa + NaCl + H₂O
    C₆H₅ONa + HCl → C₆H₅OH + NaCl
    ```

    **Requires:** High temperature and pressure

    ### Method 2: From Diazonium Salts
    ```
    C₆H₅NH₂ --[NaNO₂/HCl, 0-5°C]--> C₆H₅N₂⁺Cl⁻ --[H₂O, warm]--> C₆H₅OH + N₂ + HCl
    ```

    **Best laboratory method**

    ### Method 3: From Cumene (Industrial)
    ```
    C₆H₅-CH(CH₃)₂ --[O₂]--> C₆H₅-C(OOH)(CH₃)₂ --[H⁺]--> C₆H₅OH + (CH₃)₂CO

    (Cumene)         (Cumene hydroperoxide)         (Phenol)  (Acetone)
    ```

    **Cumene process:** Industrial method, also produces acetone

    ### Method 4: From Benzene Sulfonic Acid
    ```
    C₆H₅-SO₃H --[NaOH, 623 K]--> C₆H₅-OH
    ```

    ---

    ## Chemical Reactions of Phenols

    ### 1. Acidity - Reaction with Bases

    **With NaOH:**
    ```
    C₆H₅-OH + NaOH → C₆H₅-O⁻Na⁺ + H₂O (Sodium phenoxide)
    ```

    **With Na:**
    ```
    2C₆H₅-OH + 2Na → 2C₆H₅-O⁻Na⁺ + H₂↑
    ```

    **Does NOT react with NaHCO₃** (weaker base than carbonic acid)

    ### 2. Electrophilic Substitution (Very Easy)

    **-OH is strongly activating, ortho-para directing**

    #### (a) Halogenation
    ```
    C₆H₅-OH + 3Br₂ (aq) → 2,4,6-Tribromophenol (white ppt) + 3HBr
    ```

    **No catalyst needed!** (Very reactive)

    **Test for phenol:** White precipitate with Br₂ water

    #### (b) Nitration
    ```
    C₆H₅-OH + HNO₃ (dilute) → o-Nitrophenol + p-Nitrophenol
    ```

    **Dilute acid:** ortho + para mixture
    **Conc. acid:** 2,4,6-Trinitrophenol (Picric acid) - explosive

    #### (c) Sulfonation
    ```
    C₆H₅-OH + H₂SO₄ → o-Phenolsulfonic acid + p-Phenolsulfonic acid
    ```

    ### 3. Kolbe's Reaction (Kolbe-Schmitt)
    ```
    C₆H₅-ONa + CO₂ --[400 K, 4-7 atm]--> o-HO-C₆H₄-COONa --[H⁺]--> o-HO-C₆H₄-COOH

    (Sodium phenoxide)                    (Sodium salicylate)      (Salicylic acid)
    ```

    **Product:** Salicylic acid (used to make aspirin)

    ### 4. Reimer-Tiemann Reaction
    ```
    C₆H₅-OH + CHCl₃ --[NaOH, heat]--> o-HO-C₆H₄-CHO + p-HO-C₆H₄-CHO

    (Phenol)                          (Salicylaldehyde, major)
    ```

    **Introduces -CHO group at ortho position (major)**

    ### 5. Coupling with Diazonium Salts
    ```
    C₆H₅-OH + C₆H₅N₂⁺Cl⁻ --[NaOH, 273-278 K]--> p-HO-C₆H₄-N=N-C₆H₅

    (Phenol)  (Benzenediazonium)               (p-Hydroxyazobenzene - orange dye)
    ```

    **Azo coupling:** Forms colored azo compounds (dyes)

    ### 6. Oxidation

    **Mild oxidation:**
    ```
    C₆H₅-OH --[Na₂Cr₂O₇/H⁺]--> Benzoquinone (p-quinone)
    ```

    **Strong oxidation:** Ring breaks

    ### 7. Esterification
    ```
    C₆H₅-OH + CH₃COCl → C₆H₅-O-CO-CH₃ + HCl (Phenyl acetate)
    ```

    **Note:** Phenols do NOT react with carboxylic acids directly (need acid chloride or anhydride)

    ---

    ## Distinction: Alcohols vs Phenols

    | Test | Alcohols | Phenols |
    |------|----------|---------|
    | **NaOH** | No reaction | Reacts (salt) |
    | **NaHCO₃** | No reaction | No reaction |
    | **Br₂ water** | No reaction | White ppt (tribromophenol) |
    | **FeCl₃** | No color | Violet color |
    | **Oxidation** | R-CHO/R-COOH/R₂CO | Quinone |
    | **Lucas test** | Positive | Negative |

    ---

    ## IIT JEE Key Points

    1. **Phenol acidity:** pKa ≈ 10, more acidic than H₂O and alcohols
    2. **Reason:** Resonance stabilization of phenoxide ion
    3. **EWG increase acidity:** -NO₂ > -CN > -COOH
    4. **EDG decrease acidity:** -CH₃, -OCH₃, -NH₂
    5. **Cumene process:** Industrial method (gives phenol + acetone)
    6. **Kolbe reaction:** CO₂ + phenoxide → salicylic acid
    7. **Reimer-Tiemann:** CHCl₃ + phenol → salicylaldehyde (o-CHO)
    8. **Br₂ water test:** White ppt of 2,4,6-tribromophenol
    9. **FeCl₃ test:** Violet color with phenol
    10. **Very reactive in EAS:** -OH is strongly activating, o-p directing

## Key Points

- Phenols

- Acidity of phenols

- Resonance stabilization
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Phenols', 'Acidity of phenols', 'Resonance stabilization', 'Electrophilic substitution', 'Kolbe reaction', 'Reimer-Tiemann reaction'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Ethers - Nomenclature, Williamson Synthesis, and Reactions ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ethers - Nomenclature, Williamson Synthesis, and Reactions',
  content: <<~MARKDOWN,
# Ethers - Nomenclature, Williamson Synthesis, and Reactions 🚀

# Ethers

    ## Introduction

    **Ethers** are organic compounds containing two alkyl or aryl groups bonded to oxygen atom.

    **General formula:** R-O-R' (R and R' can be same or different)

    **Functional group:** -O- (ether linkage)

    ---

    ## Classification

    ### Symmetrical (Simple) Ethers
    - Both alkyl groups are **identical**
    - **Examples:**
      - CH₃-O-CH₃ (Dimethyl ether)
      - C₂H₅-O-C₂H₅ (Diethyl ether)

    ### Unsymmetrical (Mixed) Ethers
    - Alkyl/aryl groups are **different**
    - **Examples:**
      - CH₃-O-C₂H₅ (Methyl ethyl ether)
      - C₆H₅-O-CH₃ (Anisole/Methyl phenyl ether)

    ---

    ## Nomenclature

    ### Common Names
    - Name both groups + "ether"
    - Alphabetical order

    ### IUPAC Names
    - Larger group = parent alkane
    - Smaller group-O- = alkoxy substituent

    **Examples:**

    | Structure | IUPAC | Common |
    |-----------|-------|--------|
    | CH₃-O-CH₃ | Methoxymethane | Dimethyl ether |
    | C₂H₅-O-C₂H₅ | Ethoxyethane | Diethyl ether |
    | CH₃-O-C₂H₅ | Methoxyethane | Methyl ethyl ether |
    | C₆H₅-O-CH₃ | Methoxybenzene | Anisole |
    | C₆H₅-O-C₆H₅ | Diphenyl ether | Phenyl ether |

    ---

    ## Physical Properties

    ### 1. Boiling Point
    - **Lower than alcohols** (no H-bonding between ether molecules)
    - **Similar to alkanes** of comparable molecular weight
    - Can act as H-bond acceptors (but not donors)

    **Example:**
    - CH₃-O-CH₃: -24°C
    - CH₃CH₂OH: 78°C (much higher!)
    - C₃H₈: -42°C (similar to ether)

    ### 2. Solubility
    - **Slightly soluble in water** (can accept H-bonds from water)
    - **Soluble in organic solvents**

    ### 3. Chemical Nature
    - Relatively **unreactive** (stable)
    - Good **solvents** for organic reactions

    ---

    ## Preparation of Ethers

    ### Method 1: Williamson Ether Synthesis (Most Important)

    **Reaction:**
    ```
    R-O⁻ + R'-X → R-O-R' + X⁻  (SN2)
    ```

    **Mechanism:** SN2 nucleophilic substitution

    **Best conditions:**
    - **Primary alkyl halide** (R'-X)
    - **Alkoxide ion** (R-O⁻ from R-OH + Na)

    **Example 1 (Symmetrical):**
    ```
    2C₂H₅OH + 2Na → 2C₂H₅O⁻Na⁺ + H₂

    C₂H₅O⁻Na⁺ + C₂H₅Br → C₂H₅-O-C₂H₅ + NaBr
    ```

    **Example 2 (Unsymmetrical):**
    ```
    CH₃O⁻Na⁺ + C₂H₅Br → CH₃-O-C₂H₅ + NaBr
    ```

    **Important:**
    - Use **1° alkyl halide** for best results (SN2)
    - **Avoid 3° halides** (gives elimination E2)

    **For aryl ethers:**
    ```
    C₆H₅O⁻Na⁺ + CH₃I → C₆H₅-O-CH₃ (Anisole) + NaI
    ```

    ### Method 2: Dehydration of Alcohols

    **Reaction:**
    ```
    2R-OH --[H₂SO₄, 413 K]--> R-O-R + H₂O
    ```

    **Conditions:**
    - **Lower temperature (413 K):** Ether formation
    - **Higher temperature (443 K):** Alkene formation (dehydration)

    **Example:**
    ```
    2C₂H₅OH --[H₂SO₄, 140°C]--> C₂H₅-O-C₂H₅ + H₂O
    ```

    **Limitation:** Only for **symmetrical ethers**, **1° alcohols**

    ---

    ## Reactions of Ethers

    ### 1. Cleavage by HI or HBr (Most Important)

    **Reaction:**
    ```
    R-O-R' + HX → R-X + R'-OH  (excess HX → R'-X)
    ```

    **Mechanism:** SN2 (for small alkyl groups)

    **Example:**
    ```
    CH₃-O-C₂H₅ + HI → CH₃-I + C₂H₅-OH
                      (Methyl iodide) (Ethanol)

    C₂H₅-OH + HI → C₂H₅-I + H₂O  (with excess HI)
    ```

    **Reactivity:** HI > HBr >> HCl

    **For unsymmetrical ethers:**
    - **Smaller alkyl group** forms halide (SN2 easier)
    - **Larger alkyl group** forms alcohol

    **With aromatic ethers:**
    ```
    C₆H₅-O-CH₃ + HI → C₆H₅-OH + CH₃-I
                      (Phenol)    (Methyl iodide)

    (NOT C₆H₅-I because Ar-O is very strong)
    ```

    ### 2. With PCl₅ or PCl₃
    ```
    R-O-R + PCl₅ → R-Cl + R-Cl + POCl₃
    ```

    ### 3. Halogenation
    ```
    R-O-R + Cl₂ --[UV]--> R-O-CHCl-R + HCl  (α-substitution)
    ```

    **Halogenation at α-carbon** (carbon next to oxygen)

    ### 4. Formation of Oxonium Salts
    ```
    R-O-R + H⁺ → [R-O⁺H-R]  (Oxonium ion)
    ```

    **Protonation of ether in acidic medium**

    ---

    ## Important Ethers

    ### 1. Diethyl Ether (Ethoxyethane)
    - **Common name:** Ether
    - **Uses:**
      - Anesthetic (early surgery)
      - Solvent for Grignard reagents
      - Highly volatile, flammable

    ### 2. Anisole (Methoxybenzene)
    - C₆H₅-O-CH₃
    - Pleasant smell
    - Used in perfumes

    ### 3. Crown Ethers
    - **Cyclic polyethers** with multiple -O- groups
    - **Example:** 18-Crown-6 (6 oxygen atoms, 18-membered ring)
    - **Use:** Chelate metal ions (K⁺, Na⁺)
    - **Function:** Phase transfer catalysts

    ```
         O          O
        / \        / \
    O-CH₂ CH₂-O-CH₂ CH₂-O
        \           /
         O-CH₂-CH₂-O

    (18-Crown-6 - simplified)
    ```

    ---

    ## Comparison: Alcohols vs Ethers

    | Property | Alcohols (R-OH) | Ethers (R-O-R') |
    |----------|-----------------|-----------------|
    | **H-bonding** | Strong (donor + acceptor) | Weak (acceptor only) |
    | **Boiling point** | High | Low |
    | **Acidity** | Weakly acidic | Neutral |
    | **Reactivity** | High (many reactions) | Low (stable) |
    | **Use as solvent** | Less common | Very common |
    | **Reaction with Na** | Liberates H₂ | No reaction |

    ---

    ## IIT JEE Key Points

    1. **Williamson synthesis:** R-O⁻ + R'-X → R-O-R' (SN2, use 1° halide)
    2. **Best method:** For both symmetrical and unsymmetrical ethers
    3. **Dehydration:** 2R-OH → R-O-R at 140°C (only symmetrical)
    4. **Cleavage with HI:** R-O-R' → R-X + R'-OH
    5. **Smaller alkyl** forms halide (SN2 easier)
    6. **Aryl ethers:** Ar-O-R + HI → Ar-OH + R-I (NOT Ar-I)
    7. **Boiling point:** Ethers < Alcohols (no H-bonding)
    8. **Reactivity order:** HI > HBr >> HCl
    9. **Crown ethers:** Chelate metal ions, phase transfer catalysts
    10. **Ethers are stable:** Good solvents for organic reactions

## Key Points

- Ethers

- Williamson synthesis

- Preparation
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ethers', 'Williamson synthesis', 'Preparation', 'Reactions with HI', 'Crown ethers', 'Cleavage reactions'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Alcohols - Classification, Nomenclature, and Preparation ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Alcohols - Classification, Nomenclature, and Preparation',
  content: <<~MARKDOWN,
# Alcohols - Classification, Nomenclature, and Preparation 🚀

# Alcohols

    ## Introduction

    **Alcohols** are organic compounds containing hydroxyl group (-OH) bonded to saturated carbon atom.

    **General formula:** R-OH

    **Functional group:** -OH (hydroxyl group)

    ---

    ## Classification of Alcohols

    ### Based on Number of -OH Groups

    #### Monohydric (1 -OH)
    - CH₃OH (Methanol)
    - C₂H₅OH (Ethanol)
    - C₃H₇OH (Propanol)

    #### Dihydric (2 -OH)
    - HOCH₂-CH₂OH (Ethylene glycol)
    - CH₃CH(OH)CH₂OH (Propylene glycol)

    #### Trihydric (3 -OH)
    - CH₂OH-CHOH-CH₂OH (Glycerol/Glycerin)

    #### Polyhydric (>3 -OH)
    - Sorbitol, Mannitol (6 -OH groups)

    ### Based on Carbon Bearing -OH

    #### Primary (1°) Alcohols
    - -OH on primary carbon (bonded to 1 other carbon or none)
    - **Example:** CH₃CH₂OH (Ethanol), CH₃CH₂CH₂OH (1-Propanol)

    ```
    R-CH₂-OH  (Primary)
    ```

    #### Secondary (2°) Alcohols
    - -OH on secondary carbon (bonded to 2 other carbons)
    - **Example:** CH₃CH(OH)CH₃ (2-Propanol/Isopropanol)

    ```
         R
         |
    R-CH-OH  (Secondary)
    ```

    #### Tertiary (3°) Alcohols
    - -OH on tertiary carbon (bonded to 3 other carbons)
    - **Example:** (CH₃)₃COH (tert-Butanol/2-Methyl-2-propanol)

    ```
         R
         |
    R-C-OH  (Tertiary)
         |
         R
    ```

    ### Based on Nature of Hydrocarbon

    #### Aliphatic Alcohols
    - Open-chain structure
    - Examples: Methanol, Ethanol, Propanol

    #### Alicyclic Alcohols
    - Cyclic structure
    - Example: Cyclohexanol

    #### Aromatic Alcohols
    - -OH attached to alkyl side chain of benzene (NOT directly to ring)
    - Example: C₆H₅CH₂OH (Benzyl alcohol)

    **Note:** C₆H₅OH is **phenol**, not aromatic alcohol!

    ---

    ## IUPAC Nomenclature

    ### Rules:
    1. **Select longest carbon chain** containing -OH
    2. **Number from end** giving -OH lowest number
    3. **Replace -e with -ol** in parent alkane name
    4. **Position number** before -ol

    ### Examples:

    | Structure | IUPAC Name | Common Name |
    |-----------|------------|-------------|
    | CH₃OH | Methanol | Methyl alcohol |
    | CH₃CH₂OH | Ethanol | Ethyl alcohol |
    | CH₃CH₂CH₂OH | Propan-1-ol | n-Propyl alcohol |
    | CH₃CH(OH)CH₃ | Propan-2-ol | Isopropyl alcohol |
    | (CH₃)₃COH | 2-Methylpropan-2-ol | tert-Butyl alcohol |
    | HOCH₂CH₂OH | Ethane-1,2-diol | Ethylene glycol |
    | CH₂(OH)CH(OH)CH₂(OH) | Propane-1,2,3-triol | Glycerol |

    ---

    ## Physical Properties

    ### 1. State and Appearance
    - C1-C12: Liquids
    - >C12: Solids
    - Colorless (pure)
    - Sweet smell (lower alcohols)

    ### 2. Boiling Point

    **Alcohols have HIGHER boiling points than:**
    - Alkanes of similar molecular weight
    - Ethers of similar molecular weight

    **Reason: Hydrogen Bonding**

    ```
    R-O-H···O-H···O-H-R
         |     |
         H     H

    Strong intermolecular H-bonding
    ```

    **Trends:**
    - **Increases with molecular weight** (more van der Waals forces)
    - **Decreases with branching** (less surface area)

    **Example:**
    - n-Butanol (117°C) > Isobutanol (108°C) > tert-Butanol (83°C)

    **Comparison:**
    - CH₃CH₂OH (78°C) vs CH₃OCH₃ (-24°C) - alcohol much higher!

    ### 3. Solubility

    **In Water:**
    - **Lower alcohols (C1-C3):** Completely miscible
    - **C4-C5:** Soluble but decreases
    - **Higher alcohols (>C5):** Insoluble

    **Reason:**
    - -OH group forms H-bonds with water (hydrophilic)
    - Alkyl group is hydrophobic
    - As chain length increases, hydrophobic part dominates

    **In Organic Solvents:**
    - All alcohols are soluble

    ### 4. Acidity

    Alcohols are **weakly acidic** (pKa ≈ 15-16)

    ```
    R-OH ⇌ R-O⁻ + H⁺
    ```

    **Acidity order:**
    ```
    CH₃OH > 1° > 2° > 3° (due to +I effect of alkyl groups)
    ```

    **Water (pKa = 15.7) ≈ Alcohols**

    ---

    ## Preparation of Alcohols

    ### Method 1: From Alkenes (Hydration)

    #### (a) Acid-catalyzed Hydration
    ```
    R-CH=CH₂ + H₂O --[H₂SO₄]--> R-CH(OH)-CH₃
    ```

    **Markovnikov's rule applies**

    **Example:**
    ```
    CH₃CH=CH₂ + H₂O → CH₃CH(OH)CH₃ (2-propanol)
    ```

    #### (b) Hydroboration-Oxidation (Anti-Markovnikov)
    ```
    R-CH=CH₂ --[1. B₂H₆, 2. H₂O₂/OH⁻]--> R-CH₂-CH₂OH
    ```

    **Anti-Markovnikov product (1° alcohol)**

    **Example:**
    ```
    CH₃CH=CH₂ → CH₃CH₂CH₂OH (1-propanol)
    ```

    ### Method 2: From Haloalkanes

    #### (a) With Aqueous KOH/NaOH
    ```
    R-X + OH⁻ → R-OH + X⁻  (SN2 for 1°)
    ```

    #### (b) With Moist Ag₂O
    ```
    2R-X + Ag₂O + H₂O → 2R-OH + 2AgX
    ```

    ### Method 3: From Carbonyl Compounds (Reduction)

    #### (a) From Aldehydes → 1° Alcohols
    ```
    R-CHO --[LiAlH₄ or NaBH₄]--> R-CH₂OH
    ```

    **Example:**
    ```
    CH₃CHO → CH₃CH₂OH (Ethanol)
    ```

    #### (b) From Ketones → 2° Alcohols
    ```
    R-CO-R' --[LiAlH₄ or NaBH₄]--> R-CH(OH)-R'
    ```

    **Example:**
    ```
    CH₃COCH₃ → CH₃CH(OH)CH₃ (Isopropanol)
    ```

    **Reducing agents:**
    - **LiAlH₄** (Lithium aluminum hydride) - Strong, reduces everything
    - **NaBH₄** (Sodium borohydride) - Mild, selective

    ### Method 4: Grignard Reagent Reactions

    **Grignard reagent:** R-MgX (in dry ether)

    #### (a) With Formaldehyde → 1° Alcohol
    ```
    R-MgX + H₂C=O → R-CH₂-O-MgX --[H₃O⁺]--> R-CH₂-OH
    ```

    #### (b) With Other Aldehydes → 2° Alcohol
    ```
    R-MgX + R'-CHO → R-CH(OH)-R'
    ```

    #### (c) With Ketones → 3° Alcohol
    ```
    R-MgX + R'-CO-R" → R-C(OH)(R')(R")
    ```

    **Example:**
    ```
    CH₃MgBr + CH₃COCH₃ → (CH₃)₃COH (tert-butanol)
    ```

    ### Method 5: Fermentation (Biological)
    ```
    C₆H₁₂O₆ --[Zymase]--> 2C₂H₅OH + 2CO₂
    ```

    **Used for:** Ethanol production from sugars

    ---

    ## Reactions of Alcohols

    ### 1. Reaction with Metals (Na, K)
    ```
    2R-OH + 2Na → 2R-O⁻Na⁺ + H₂↑
    ```

    **Forms:** Sodium alkoxide + Hydrogen gas

    **Test for -OH group**

    ### 2. Reaction with Hydrogen Halides (HX)
    ```
    R-OH + HX → R-X + H₂O
    ```

    **Reactivity:**
    - **Alcohols:** 3° > 2° > 1° (via carbocation)
    - **HX:** HI > HBr > HCl

    **Lucas Test:** Distinguishes 1°, 2°, 3° alcohols
    - ZnCl₂ + HCl
    - 3°: Immediate turbidity
    - 2°: Turbidity in 5 min
    - 1°: No turbidity at room temp

    ### 3. Dehydration (Formation of Alkenes)
    ```
    R-CH₂-CH₂-OH --[H₂SO₄, 443 K]--> R-CH=CH₂ + H₂O
    ```

    **Ease:** 3° > 2° > 1°

    **Saytzeff product** (more substituted alkene) is major

    ### 4. Oxidation

    #### Primary Alcohols
    ```
    1° R-CH₂-OH --[K₂Cr₂O₇/H⁺]--> R-CHO (Aldehyde) --[oxidation]--> R-COOH (Acid)
    ```

    **Mild oxidation:** PCC (Pyridinium chlorochromate) → Stops at aldehyde

    #### Secondary Alcohols
    ```
    2° R₂CH-OH --[K₂Cr₂O₇/H⁺]--> R₂C=O (Ketone)
    ```

    **Ketones cannot be oxidized further** (no H on carbonyl carbon)

    #### Tertiary Alcohols
    ```
    3° R₃C-OH --[No oxidation under normal conditions]-->
    ```

    **No oxidation** (no H on carbon bearing -OH)

    ### 5. Esterification
    ```
    R-OH + R'-COOH --[H₂SO₄]--> R'-COO-R + H₂O
    ```

    **Forms:** Ester

    ---

    ## IIT JEE Key Points

    1. **Classification:** 1°, 2°, 3° based on carbon bearing -OH
    2. **Boiling point:** High due to H-bonding
    3. **Solubility:** Decreases with increasing chain length
    4. **Acidity:** CH₃OH > 1° > 2° > 3° (weaker than water)
    5. **Hydroboration-oxidation:** Anti-Markovnikov, gives 1° alcohol
    6. **Reduction:** Aldehyde → 1° alcohol, Ketone → 2° alcohol
    7. **Grignard:** Formaldehyde → 1°, Aldehyde → 2°, Ketone → 3°
    8. **Oxidation:** 1° → Aldehyde → Acid, 2° → Ketone, 3° → No oxidation
    9. **Lucas test:** 3° immediate, 2° in 5 min, 1° no reaction
    10. **Dehydration:** 3° > 2° > 1° (ease)

## Key Points

- Alcohols

- Classification

- Nomenclature
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Alcohols', 'Classification', 'Nomenclature', 'Preparation methods', 'Physical properties', 'Hydrogen bonding'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Phenols - Acidity, Preparation, and Reactions ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Phenols - Acidity, Preparation, and Reactions',
  content: <<~MARKDOWN,
# Phenols - Acidity, Preparation, and Reactions 🚀

# Phenols

    ## Introduction

    **Phenols** are organic compounds in which -OH group is directly attached to benzene ring.

    **General formula:** Ar-OH (Ar = aromatic ring)

    **Example:** C₆H₅OH (Phenol, carbolic acid)

    **NOT phenols:** C₆H₅CH₂OH (Benzyl alcohol - aromatic alcohol, not phenol)

    ---

    ## Nomenclature

    | Structure | IUPAC Name | Common Name |
    |-----------|------------|-------------|
    | C₆H₅OH | Benzenol | Phenol |
    | o-CH₃-C₆H₄-OH | 2-Methylphenol | o-Cresol |
    | m-CH₃-C₆H₄-OH | 3-Methylphenol | m-Cresol |
    | p-CH₃-C₆H₄-OH | 4-Methylphenol | p-Cresol |
    | C₆H₄(OH)₂ | Benzenediol | Catechol (o-), Resorcinol (m-), Hydroquinone (p-) |

    ---

    ## Acidity of Phenols

    **Phenols are MORE acidic than alcohols**

    ```
    C₆H₅-OH ⇌ C₆H₅-O⁻ + H⁺

    pKa (Phenol) ≈ 10
    pKa (Alcohols) ≈ 15-16
    pKa (Water) = 15.7
    ```

    **Acidity order:**
    ```
    Phenol > H₂O > Alcohols
    ```

    ### Why is Phenol More Acidic?

    **Reason: Resonance stabilization of phenoxide ion**

    **Phenoxide ion (C₆H₅O⁻):**
    ```
         O⁻              O⁻              O⁻
         ║               |               |
    ⟷          ⟷          ⟷

    Negative charge delocalizes into benzene ring
    (4 resonance structures)
    ```

    **Alkoxide ion (R-O⁻):**
    ```
    R-O⁻  (No resonance, charge localized on O)
    ```

    **More stable anion → More acidic**

    ### Effect of Substituents on Acidity

    #### Electron-Withdrawing Groups (EWG) Increase Acidity
    - **-NO₂, -CN, -COOH:** Stabilize phenoxide ion further

    **Examples:**
    ```
    p-NO₂-C₆H₄-OH (pKa 7.1) > m-NO₂-C₆H₄-OH (8.4) > C₆H₅-OH (10.0)
    ```

    **ortho and para effects are stronger** (resonance + inductive)

    #### Electron-Donating Groups (EDG) Decrease Acidity
    - **-CH₃, -OCH₃, -NH₂:** Destabilize phenoxide ion

    **Examples:**
    ```
    C₆H₅-OH (pKa 10.0) > p-CH₃-C₆H₄-OH (10.3) > p-OCH₃-C₆H₄-OH (10.2)
    ```

    **Acidity trend:**
    ```
    p-NO₂-phenol > m-NO₂-phenol > phenol > p-CH₃-phenol
    ```

    ---

    ## Preparation of Phenols

    ### Method 1: From Chlorobenzene (Dow Process)
    ```
    C₆H₅Cl + 2NaOH --[623 K, 300 atm]--> C₆H₅ONa + NaCl + H₂O
    C₆H₅ONa + HCl → C₆H₅OH + NaCl
    ```

    **Requires:** High temperature and pressure

    ### Method 2: From Diazonium Salts
    ```
    C₆H₅NH₂ --[NaNO₂/HCl, 0-5°C]--> C₆H₅N₂⁺Cl⁻ --[H₂O, warm]--> C₆H₅OH + N₂ + HCl
    ```

    **Best laboratory method**

    ### Method 3: From Cumene (Industrial)
    ```
    C₆H₅-CH(CH₃)₂ --[O₂]--> C₆H₅-C(OOH)(CH₃)₂ --[H⁺]--> C₆H₅OH + (CH₃)₂CO

    (Cumene)         (Cumene hydroperoxide)         (Phenol)  (Acetone)
    ```

    **Cumene process:** Industrial method, also produces acetone

    ### Method 4: From Benzene Sulfonic Acid
    ```
    C₆H₅-SO₃H --[NaOH, 623 K]--> C₆H₅-OH
    ```

    ---

    ## Chemical Reactions of Phenols

    ### 1. Acidity - Reaction with Bases

    **With NaOH:**
    ```
    C₆H₅-OH + NaOH → C₆H₅-O⁻Na⁺ + H₂O (Sodium phenoxide)
    ```

    **With Na:**
    ```
    2C₆H₅-OH + 2Na → 2C₆H₅-O⁻Na⁺ + H₂↑
    ```

    **Does NOT react with NaHCO₃** (weaker base than carbonic acid)

    ### 2. Electrophilic Substitution (Very Easy)

    **-OH is strongly activating, ortho-para directing**

    #### (a) Halogenation
    ```
    C₆H₅-OH + 3Br₂ (aq) → 2,4,6-Tribromophenol (white ppt) + 3HBr
    ```

    **No catalyst needed!** (Very reactive)

    **Test for phenol:** White precipitate with Br₂ water

    #### (b) Nitration
    ```
    C₆H₅-OH + HNO₃ (dilute) → o-Nitrophenol + p-Nitrophenol
    ```

    **Dilute acid:** ortho + para mixture
    **Conc. acid:** 2,4,6-Trinitrophenol (Picric acid) - explosive

    #### (c) Sulfonation
    ```
    C₆H₅-OH + H₂SO₄ → o-Phenolsulfonic acid + p-Phenolsulfonic acid
    ```

    ### 3. Kolbe's Reaction (Kolbe-Schmitt)
    ```
    C₆H₅-ONa + CO₂ --[400 K, 4-7 atm]--> o-HO-C₆H₄-COONa --[H⁺]--> o-HO-C₆H₄-COOH

    (Sodium phenoxide)                    (Sodium salicylate)      (Salicylic acid)
    ```

    **Product:** Salicylic acid (used to make aspirin)

    ### 4. Reimer-Tiemann Reaction
    ```
    C₆H₅-OH + CHCl₃ --[NaOH, heat]--> o-HO-C₆H₄-CHO + p-HO-C₆H₄-CHO

    (Phenol)                          (Salicylaldehyde, major)
    ```

    **Introduces -CHO group at ortho position (major)**

    ### 5. Coupling with Diazonium Salts
    ```
    C₆H₅-OH + C₆H₅N₂⁺Cl⁻ --[NaOH, 273-278 K]--> p-HO-C₆H₄-N=N-C₆H₅

    (Phenol)  (Benzenediazonium)               (p-Hydroxyazobenzene - orange dye)
    ```

    **Azo coupling:** Forms colored azo compounds (dyes)

    ### 6. Oxidation

    **Mild oxidation:**
    ```
    C₆H₅-OH --[Na₂Cr₂O₇/H⁺]--> Benzoquinone (p-quinone)
    ```

    **Strong oxidation:** Ring breaks

    ### 7. Esterification
    ```
    C₆H₅-OH + CH₃COCl → C₆H₅-O-CO-CH₃ + HCl (Phenyl acetate)
    ```

    **Note:** Phenols do NOT react with carboxylic acids directly (need acid chloride or anhydride)

    ---

    ## Distinction: Alcohols vs Phenols

    | Test | Alcohols | Phenols |
    |------|----------|---------|
    | **NaOH** | No reaction | Reacts (salt) |
    | **NaHCO₃** | No reaction | No reaction |
    | **Br₂ water** | No reaction | White ppt (tribromophenol) |
    | **FeCl₃** | No color | Violet color |
    | **Oxidation** | R-CHO/R-COOH/R₂CO | Quinone |
    | **Lucas test** | Positive | Negative |

    ---

    ## IIT JEE Key Points

    1. **Phenol acidity:** pKa ≈ 10, more acidic than H₂O and alcohols
    2. **Reason:** Resonance stabilization of phenoxide ion
    3. **EWG increase acidity:** -NO₂ > -CN > -COOH
    4. **EDG decrease acidity:** -CH₃, -OCH₃, -NH₂
    5. **Cumene process:** Industrial method (gives phenol + acetone)
    6. **Kolbe reaction:** CO₂ + phenoxide → salicylic acid
    7. **Reimer-Tiemann:** CHCl₃ + phenol → salicylaldehyde (o-CHO)
    8. **Br₂ water test:** White ppt of 2,4,6-tribromophenol
    9. **FeCl₃ test:** Violet color with phenol
    10. **Very reactive in EAS:** -OH is strongly activating, o-p directing

## Key Points

- Phenols

- Acidity of phenols

- Resonance stabilization
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Phenols', 'Acidity of phenols', 'Resonance stabilization', 'Electrophilic substitution', 'Kolbe reaction', 'Reimer-Tiemann reaction'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Ethers - Nomenclature, Williamson Synthesis, and Reactions ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Ethers - Nomenclature, Williamson Synthesis, and Reactions',
  content: <<~MARKDOWN,
# Ethers - Nomenclature, Williamson Synthesis, and Reactions 🚀

# Ethers

    ## Introduction

    **Ethers** are organic compounds containing two alkyl or aryl groups bonded to oxygen atom.

    **General formula:** R-O-R' (R and R' can be same or different)

    **Functional group:** -O- (ether linkage)

    ---

    ## Classification

    ### Symmetrical (Simple) Ethers
    - Both alkyl groups are **identical**
    - **Examples:**
      - CH₃-O-CH₃ (Dimethyl ether)
      - C₂H₅-O-C₂H₅ (Diethyl ether)

    ### Unsymmetrical (Mixed) Ethers
    - Alkyl/aryl groups are **different**
    - **Examples:**
      - CH₃-O-C₂H₅ (Methyl ethyl ether)
      - C₆H₅-O-CH₃ (Anisole/Methyl phenyl ether)

    ---

    ## Nomenclature

    ### Common Names
    - Name both groups + "ether"
    - Alphabetical order

    ### IUPAC Names
    - Larger group = parent alkane
    - Smaller group-O- = alkoxy substituent

    **Examples:**

    | Structure | IUPAC | Common |
    |-----------|-------|--------|
    | CH₃-O-CH₃ | Methoxymethane | Dimethyl ether |
    | C₂H₅-O-C₂H₅ | Ethoxyethane | Diethyl ether |
    | CH₃-O-C₂H₅ | Methoxyethane | Methyl ethyl ether |
    | C₆H₅-O-CH₃ | Methoxybenzene | Anisole |
    | C₆H₅-O-C₆H₅ | Diphenyl ether | Phenyl ether |

    ---

    ## Physical Properties

    ### 1. Boiling Point
    - **Lower than alcohols** (no H-bonding between ether molecules)
    - **Similar to alkanes** of comparable molecular weight
    - Can act as H-bond acceptors (but not donors)

    **Example:**
    - CH₃-O-CH₃: -24°C
    - CH₃CH₂OH: 78°C (much higher!)
    - C₃H₈: -42°C (similar to ether)

    ### 2. Solubility
    - **Slightly soluble in water** (can accept H-bonds from water)
    - **Soluble in organic solvents**

    ### 3. Chemical Nature
    - Relatively **unreactive** (stable)
    - Good **solvents** for organic reactions

    ---

    ## Preparation of Ethers

    ### Method 1: Williamson Ether Synthesis (Most Important)

    **Reaction:**
    ```
    R-O⁻ + R'-X → R-O-R' + X⁻  (SN2)
    ```

    **Mechanism:** SN2 nucleophilic substitution

    **Best conditions:**
    - **Primary alkyl halide** (R'-X)
    - **Alkoxide ion** (R-O⁻ from R-OH + Na)

    **Example 1 (Symmetrical):**
    ```
    2C₂H₅OH + 2Na → 2C₂H₅O⁻Na⁺ + H₂

    C₂H₅O⁻Na⁺ + C₂H₅Br → C₂H₅-O-C₂H₅ + NaBr
    ```

    **Example 2 (Unsymmetrical):**
    ```
    CH₃O⁻Na⁺ + C₂H₅Br → CH₃-O-C₂H₅ + NaBr
    ```

    **Important:**
    - Use **1° alkyl halide** for best results (SN2)
    - **Avoid 3° halides** (gives elimination E2)

    **For aryl ethers:**
    ```
    C₆H₅O⁻Na⁺ + CH₃I → C₆H₅-O-CH₃ (Anisole) + NaI
    ```

    ### Method 2: Dehydration of Alcohols

    **Reaction:**
    ```
    2R-OH --[H₂SO₄, 413 K]--> R-O-R + H₂O
    ```

    **Conditions:**
    - **Lower temperature (413 K):** Ether formation
    - **Higher temperature (443 K):** Alkene formation (dehydration)

    **Example:**
    ```
    2C₂H₅OH --[H₂SO₄, 140°C]--> C₂H₅-O-C₂H₅ + H₂O
    ```

    **Limitation:** Only for **symmetrical ethers**, **1° alcohols**

    ---

    ## Reactions of Ethers

    ### 1. Cleavage by HI or HBr (Most Important)

    **Reaction:**
    ```
    R-O-R' + HX → R-X + R'-OH  (excess HX → R'-X)
    ```

    **Mechanism:** SN2 (for small alkyl groups)

    **Example:**
    ```
    CH₃-O-C₂H₅ + HI → CH₃-I + C₂H₅-OH
                      (Methyl iodide) (Ethanol)

    C₂H₅-OH + HI → C₂H₅-I + H₂O  (with excess HI)
    ```

    **Reactivity:** HI > HBr >> HCl

    **For unsymmetrical ethers:**
    - **Smaller alkyl group** forms halide (SN2 easier)
    - **Larger alkyl group** forms alcohol

    **With aromatic ethers:**
    ```
    C₆H₅-O-CH₃ + HI → C₆H₅-OH + CH₃-I
                      (Phenol)    (Methyl iodide)

    (NOT C₆H₅-I because Ar-O is very strong)
    ```

    ### 2. With PCl₅ or PCl₃
    ```
    R-O-R + PCl₅ → R-Cl + R-Cl + POCl₃
    ```

    ### 3. Halogenation
    ```
    R-O-R + Cl₂ --[UV]--> R-O-CHCl-R + HCl  (α-substitution)
    ```

    **Halogenation at α-carbon** (carbon next to oxygen)

    ### 4. Formation of Oxonium Salts
    ```
    R-O-R + H⁺ → [R-O⁺H-R]  (Oxonium ion)
    ```

    **Protonation of ether in acidic medium**

    ---

    ## Important Ethers

    ### 1. Diethyl Ether (Ethoxyethane)
    - **Common name:** Ether
    - **Uses:**
      - Anesthetic (early surgery)
      - Solvent for Grignard reagents
      - Highly volatile, flammable

    ### 2. Anisole (Methoxybenzene)
    - C₆H₅-O-CH₃
    - Pleasant smell
    - Used in perfumes

    ### 3. Crown Ethers
    - **Cyclic polyethers** with multiple -O- groups
    - **Example:** 18-Crown-6 (6 oxygen atoms, 18-membered ring)
    - **Use:** Chelate metal ions (K⁺, Na⁺)
    - **Function:** Phase transfer catalysts

    ```
         O          O
        / \        / \
    O-CH₂ CH₂-O-CH₂ CH₂-O
        \           /
         O-CH₂-CH₂-O

    (18-Crown-6 - simplified)
    ```

    ---

    ## Comparison: Alcohols vs Ethers

    | Property | Alcohols (R-OH) | Ethers (R-O-R') |
    |----------|-----------------|-----------------|
    | **H-bonding** | Strong (donor + acceptor) | Weak (acceptor only) |
    | **Boiling point** | High | Low |
    | **Acidity** | Weakly acidic | Neutral |
    | **Reactivity** | High (many reactions) | Low (stable) |
    | **Use as solvent** | Less common | Very common |
    | **Reaction with Na** | Liberates H₂ | No reaction |

    ---

    ## IIT JEE Key Points

    1. **Williamson synthesis:** R-O⁻ + R'-X → R-O-R' (SN2, use 1° halide)
    2. **Best method:** For both symmetrical and unsymmetrical ethers
    3. **Dehydration:** 2R-OH → R-O-R at 140°C (only symmetrical)
    4. **Cleavage with HI:** R-O-R' → R-X + R'-OH
    5. **Smaller alkyl** forms halide (SN2 easier)
    6. **Aryl ethers:** Ar-O-R + HI → Ar-OH + R-I (NOT Ar-I)
    7. **Boiling point:** Ethers < Alcohols (no H-bonding)
    8. **Reactivity order:** HI > HBr >> HCl
    9. **Crown ethers:** Chelate metal ions, phase transfer catalysts
    10. **Ethers are stable:** Good solvents for organic reactions

## Key Points

- Ethers

- Williamson synthesis

- Preparation
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ethers', 'Williamson synthesis', 'Preparation', 'Reactions with HI', 'Crown ethers', 'Cleavage reactions'],
  prerequisite_ids: []
)

# === MICROLESSON 7: classification — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'classification — Practice',
  content: <<~MARKDOWN,
# classification — Practice 🚀

CH₃CH(OH)CH₃ (2-propanol/isopropanol) is 2° alcohol - OH on carbon bonded to 2 other carbons. Option A is 1°, C is 3°, D is methanol.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['classification'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following is a secondary (2°) alcohol?',
    options: ['CH₃CH₂CH₂OH', 'CH₃CH(OH)CH₃', '(CH₃)₃COH', 'CH₃OH'],
    correct_answer: 1,
    explanation: 'CH₃CH(OH)CH₃ (2-propanol/isopropanol) is 2° alcohol - OH on carbon bonded to 2 other carbons. Option A is 1°, C is 3°, D is methanol.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: physical_properties — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'physical_properties — Practice',
  content: <<~MARKDOWN,
# physical_properties — Practice 🚀

Alcohols form strong intermolecular H-bonds (R-O-H···O-H-R), requiring more energy to break. Ethers cannot H-bond with each other (no H on O). BP: Ethanol 78°C vs Dimethyl ether -24°C.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['physical_properties'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why do alcohols have higher boiling points than ethers of similar molecular weight?',
    options: ['Alcohols are more polar', 'Alcohols can form intermolecular hydrogen bonds', 'Alcohols have higher molecular weight', 'Ethers decompose at low temperature'],
    correct_answer: 1,
    explanation: 'Alcohols form strong intermolecular H-bonds (R-O-H···O-H-R), requiring more energy to break. Ethers cannot H-bond with each other (no H on O). BP: Ethanol 78°C vs Dimethyl ether -24°C.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: acidity — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'acidity — Practice',
  content: <<~MARKDOWN,
# acidity — Practice 🚀

Acidity: CH₃OH > 1° > 2° > 3°. More +I effect destabilizes RO⁻ anion. Order: (CH₃)₃COH < (CH₃)₂CHOH < CH₃CH₂OH < CH₃OH.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['acidity'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange in order of INCREASING acidity: (1) CH₃OH (2) CH₃CH₂OH (3) (CH₃)₂CHOH (4) (CH₃)₃COH',
    answer: '',
    explanation: 'Acidity: CH₃OH > 1° > 2° > 3°. More +I effect destabilizes RO⁻ anion. Order: (CH₃)₃COH < (CH₃)₂CHOH < CH₃CH₂OH < CH₃OH.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: preparation — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'preparation — Practice',
  content: <<~MARKDOWN,
# preparation — Practice 🚀

Hydroboration-oxidation (B₂H₆, then H₂O₂/OH⁻) gives anti-Markovnikov product. CH₃CH=CH₂ → CH₃CH₂CH₂OH (1° alcohol), not CH₃CH(OH)CH₃.

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
    question: 'Hydroboration-oxidation of alkenes gives:',
    options: ['Markovnikov alcohol', 'Anti-Markovnikov alcohol', 'Ketone', 'Aldehyde'],
    correct_answer: 1,
    explanation: 'Hydroboration-oxidation (B₂H₆, then H₂O₂/OH⁻) gives anti-Markovnikov product. CH₃CH=CH₂ → CH₃CH₂CH₂OH (1° alcohol), not CH₃CH(OH)CH₃.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: preparation — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'preparation — Practice',
  content: <<~MARKDOWN,
# preparation — Practice 🚀

Reducing agents for ketones: (1) LiAlH₄ - strong ✓, (2) NaBH₄ - mild ✓. K₂Cr₂O₇ and PCC are oxidizing agents, not reducing agents.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['preparation'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which reagents can reduce ketones to secondary alcohols?',
    options: ['LiAlH₄ (Lithium aluminum hydride)', 'NaBH₄ (Sodium borohydride)', 'K₂Cr₂O₇/H⁺ (Oxidizing agent)', 'PCC (Pyridinium chlorochromate)'],
    correct_answer: 1,
    explanation: 'Reducing agents for ketones: (1) LiAlH₄ - strong ✓, (2) NaBH₄ - mild ✓. K₂Cr₂O₇ and PCC are oxidizing agents, not reducing agents.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 12: oxidation — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'oxidation — Practice',
  content: <<~MARKDOWN,
# oxidation — Practice 🚀

1° alcohols oxidize: R-CH₂-OH → R-CHO (aldehyde) → R-COOH (carboxylic acid). To stop at aldehyde, use mild oxidizing agent like PCC. 2° → ketone, 3° → no oxidation.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['oxidation'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Oxidation of primary alcohols with K₂Cr₂O₇/H⁺ gives:',
    options: ['Ketone', 'Aldehyde, then carboxylic acid', 'Ether', 'No reaction'],
    correct_answer: 1,
    explanation: '1° alcohols oxidize: R-CH₂-OH → R-CHO (aldehyde) → R-COOH (carboxylic acid). To stop at aldehyde, use mild oxidizing agent like PCC. 2° → ketone, 3° → no oxidation.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 13: phenol_acidity — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'phenol_acidity — Practice',
  content: <<~MARKDOWN,
# phenol_acidity — Practice 🚀

Phenoxide ion (C₆H₅O⁻) is resonance-stabilized (charge delocalizes into ring). Ethoxide (C₂H₅O⁻) has no resonance. More stable anion → more acidic. pKa: Phenol (10) < Ethanol (16).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['phenol_acidity'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why is phenol more acidic than ethanol?',
    options: ['Phenol has higher molecular weight', 'Phenoxide ion is stabilized by resonance', 'Phenol forms stronger H-bonds', 'Ethanol is more polar'],
    correct_answer: 1,
    explanation: 'Phenoxide ion (C₆H₅O⁻) is resonance-stabilized (charge delocalizes into ring). Ethoxide (C₂H₅O⁻) has no resonance. More stable anion → more acidic. pKa: Phenol (10) < Ethanol (16).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: phenol_acidity — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'phenol_acidity — Practice',
  content: <<~MARKDOWN,
# phenol_acidity — Practice 🚀

EWG increases acidity (stabilize anion), EDG decreases. -NO₂ (strong EWG) > H > -CH₃ (EDG) > -OCH₃ (strong EDG). Order: p-OCH₃ < p-CH₃ < phenol < p-NO₂.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['phenol_acidity'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange in order of INCREASING acidity: (1) Phenol (2) p-Nitrophenol (3) p-Methylphenol (4) p-Methoxyphenol',
    answer: '',
    explanation: 'EWG increases acidity (stabilize anion), EDG decreases. -NO₂ (strong EWG) > H > -CH₃ (EDG) > -OCH₃ (strong EDG). Order: p-OCH₃ < p-CH₃ < phenol < p-NO₂.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: phenol_reactions — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'phenol_reactions — Practice',
  content: <<~MARKDOWN,
# phenol_reactions — Practice 🚀

Kolbe reaction: C₆H₅ONa + CO₂ → o-HO-C₆H₄-COONa → Salicylic acid (used to make aspirin). Introduces -COOH at ortho position.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['phenol_reactions'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Kolbe\',
    options: ['Benzoic acid', 'Salicylic acid (o-hydroxybenzoic acid)', 'Picric acid', 'Phthalic acid'],
    correct_answer: 1,
    explanation: 'Kolbe reaction: C₆H₅ONa + CO₂ → o-HO-C₆H₄-COONa → Salicylic acid (used to make aspirin). Introduces -COOH at ortho position.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 16: ether_synthesis — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'ether_synthesis — Practice',
  content: <<~MARKDOWN,
# ether_synthesis — Practice 🚀

Williamson synthesis (R-O⁻ + R\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['ether_synthesis'],
  prerequisite_ids: []
)

# Exercise 16.2: MCQ
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Williamson ether synthesis works best with which combination?',
    options: ['Alkoxide + tertiary alkyl halide', 'Alkoxide + primary alkyl halide', 'Alcohol + alkyl halide', 'Phenoxide + aryl halide'],
    correct_answer: 1,
    explanation: 'Williamson synthesis (R-O⁻ + R\',
    difficulty: 'easy'
  }
)

# === MICROLESSON 17: ether_reactions — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'ether_reactions — Practice',
  content: <<~MARKDOWN,
# ether_reactions — Practice 🚀

Ether cleavage: CH₃-O-C₂H₅ + HI → CH₃I + C₂H₅OH (smaller alkyl forms halide). Excess HI: C₂H₅OH + HI → C₂H₅I. Final: CH₃I + C₂H₅I.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['ether_reactions'],
  prerequisite_ids: []
)

# Exercise 17.2: MCQ
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cleavage of CH₃-O-C₂H₅ with excess HI gives:',
    options: ['CH₃OH + C₂H₅I', 'CH₃I + C₂H₅OH', 'CH₃I + C₂H₅I', 'No reaction'],
    correct_answer: 2,
    explanation: 'Ether cleavage: CH₃-O-C₂H₅ + HI → CH₃I + C₂H₅OH (smaller alkyl forms halide). Excess HI: C₂H₅OH + HI → C₂H₅I. Final: CH₃I + C₂H₅I.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 18: Alcohols - Classification, Nomenclature, and Preparation ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Alcohols - Classification, Nomenclature, and Preparation',
  content: <<~MARKDOWN,
# Alcohols - Classification, Nomenclature, and Preparation 🚀

# Alcohols

    ## Introduction

    **Alcohols** are organic compounds containing hydroxyl group (-OH) bonded to saturated carbon atom.

    **General formula:** R-OH

    **Functional group:** -OH (hydroxyl group)

    ---

    ## Classification of Alcohols

    ### Based on Number of -OH Groups

    #### Monohydric (1 -OH)
    - CH₃OH (Methanol)
    - C₂H₅OH (Ethanol)
    - C₃H₇OH (Propanol)

    #### Dihydric (2 -OH)
    - HOCH₂-CH₂OH (Ethylene glycol)
    - CH₃CH(OH)CH₂OH (Propylene glycol)

    #### Trihydric (3 -OH)
    - CH₂OH-CHOH-CH₂OH (Glycerol/Glycerin)

    #### Polyhydric (>3 -OH)
    - Sorbitol, Mannitol (6 -OH groups)

    ### Based on Carbon Bearing -OH

    #### Primary (1°) Alcohols
    - -OH on primary carbon (bonded to 1 other carbon or none)
    - **Example:** CH₃CH₂OH (Ethanol), CH₃CH₂CH₂OH (1-Propanol)

    ```
    R-CH₂-OH  (Primary)
    ```

    #### Secondary (2°) Alcohols
    - -OH on secondary carbon (bonded to 2 other carbons)
    - **Example:** CH₃CH(OH)CH₃ (2-Propanol/Isopropanol)

    ```
         R
         |
    R-CH-OH  (Secondary)
    ```

    #### Tertiary (3°) Alcohols
    - -OH on tertiary carbon (bonded to 3 other carbons)
    - **Example:** (CH₃)₃COH (tert-Butanol/2-Methyl-2-propanol)

    ```
         R
         |
    R-C-OH  (Tertiary)
         |
         R
    ```

    ### Based on Nature of Hydrocarbon

    #### Aliphatic Alcohols
    - Open-chain structure
    - Examples: Methanol, Ethanol, Propanol

    #### Alicyclic Alcohols
    - Cyclic structure
    - Example: Cyclohexanol

    #### Aromatic Alcohols
    - -OH attached to alkyl side chain of benzene (NOT directly to ring)
    - Example: C₆H₅CH₂OH (Benzyl alcohol)

    **Note:** C₆H₅OH is **phenol**, not aromatic alcohol!

    ---

    ## IUPAC Nomenclature

    ### Rules:
    1. **Select longest carbon chain** containing -OH
    2. **Number from end** giving -OH lowest number
    3. **Replace -e with -ol** in parent alkane name
    4. **Position number** before -ol

    ### Examples:

    | Structure | IUPAC Name | Common Name |
    |-----------|------------|-------------|
    | CH₃OH | Methanol | Methyl alcohol |
    | CH₃CH₂OH | Ethanol | Ethyl alcohol |
    | CH₃CH₂CH₂OH | Propan-1-ol | n-Propyl alcohol |
    | CH₃CH(OH)CH₃ | Propan-2-ol | Isopropyl alcohol |
    | (CH₃)₃COH | 2-Methylpropan-2-ol | tert-Butyl alcohol |
    | HOCH₂CH₂OH | Ethane-1,2-diol | Ethylene glycol |
    | CH₂(OH)CH(OH)CH₂(OH) | Propane-1,2,3-triol | Glycerol |

    ---

    ## Physical Properties

    ### 1. State and Appearance
    - C1-C12: Liquids
    - >C12: Solids
    - Colorless (pure)
    - Sweet smell (lower alcohols)

    ### 2. Boiling Point

    **Alcohols have HIGHER boiling points than:**
    - Alkanes of similar molecular weight
    - Ethers of similar molecular weight

    **Reason: Hydrogen Bonding**

    ```
    R-O-H···O-H···O-H-R
         |     |
         H     H

    Strong intermolecular H-bonding
    ```

    **Trends:**
    - **Increases with molecular weight** (more van der Waals forces)
    - **Decreases with branching** (less surface area)

    **Example:**
    - n-Butanol (117°C) > Isobutanol (108°C) > tert-Butanol (83°C)

    **Comparison:**
    - CH₃CH₂OH (78°C) vs CH₃OCH₃ (-24°C) - alcohol much higher!

    ### 3. Solubility

    **In Water:**
    - **Lower alcohols (C1-C3):** Completely miscible
    - **C4-C5:** Soluble but decreases
    - **Higher alcohols (>C5):** Insoluble

    **Reason:**
    - -OH group forms H-bonds with water (hydrophilic)
    - Alkyl group is hydrophobic
    - As chain length increases, hydrophobic part dominates

    **In Organic Solvents:**
    - All alcohols are soluble

    ### 4. Acidity

    Alcohols are **weakly acidic** (pKa ≈ 15-16)

    ```
    R-OH ⇌ R-O⁻ + H⁺
    ```

    **Acidity order:**
    ```
    CH₃OH > 1° > 2° > 3° (due to +I effect of alkyl groups)
    ```

    **Water (pKa = 15.7) ≈ Alcohols**

    ---

    ## Preparation of Alcohols

    ### Method 1: From Alkenes (Hydration)

    #### (a) Acid-catalyzed Hydration
    ```
    R-CH=CH₂ + H₂O --[H₂SO₄]--> R-CH(OH)-CH₃
    ```

    **Markovnikov's rule applies**

    **Example:**
    ```
    CH₃CH=CH₂ + H₂O → CH₃CH(OH)CH₃ (2-propanol)
    ```

    #### (b) Hydroboration-Oxidation (Anti-Markovnikov)
    ```
    R-CH=CH₂ --[1. B₂H₆, 2. H₂O₂/OH⁻]--> R-CH₂-CH₂OH
    ```

    **Anti-Markovnikov product (1° alcohol)**

    **Example:**
    ```
    CH₃CH=CH₂ → CH₃CH₂CH₂OH (1-propanol)
    ```

    ### Method 2: From Haloalkanes

    #### (a) With Aqueous KOH/NaOH
    ```
    R-X + OH⁻ → R-OH + X⁻  (SN2 for 1°)
    ```

    #### (b) With Moist Ag₂O
    ```
    2R-X + Ag₂O + H₂O → 2R-OH + 2AgX
    ```

    ### Method 3: From Carbonyl Compounds (Reduction)

    #### (a) From Aldehydes → 1° Alcohols
    ```
    R-CHO --[LiAlH₄ or NaBH₄]--> R-CH₂OH
    ```

    **Example:**
    ```
    CH₃CHO → CH₃CH₂OH (Ethanol)
    ```

    #### (b) From Ketones → 2° Alcohols
    ```
    R-CO-R' --[LiAlH₄ or NaBH₄]--> R-CH(OH)-R'
    ```

    **Example:**
    ```
    CH₃COCH₃ → CH₃CH(OH)CH₃ (Isopropanol)
    ```

    **Reducing agents:**
    - **LiAlH₄** (Lithium aluminum hydride) - Strong, reduces everything
    - **NaBH₄** (Sodium borohydride) - Mild, selective

    ### Method 4: Grignard Reagent Reactions

    **Grignard reagent:** R-MgX (in dry ether)

    #### (a) With Formaldehyde → 1° Alcohol
    ```
    R-MgX + H₂C=O → R-CH₂-O-MgX --[H₃O⁺]--> R-CH₂-OH
    ```

    #### (b) With Other Aldehydes → 2° Alcohol
    ```
    R-MgX + R'-CHO → R-CH(OH)-R'
    ```

    #### (c) With Ketones → 3° Alcohol
    ```
    R-MgX + R'-CO-R" → R-C(OH)(R')(R")
    ```

    **Example:**
    ```
    CH₃MgBr + CH₃COCH₃ → (CH₃)₃COH (tert-butanol)
    ```

    ### Method 5: Fermentation (Biological)
    ```
    C₆H₁₂O₆ --[Zymase]--> 2C₂H₅OH + 2CO₂
    ```

    **Used for:** Ethanol production from sugars

    ---

    ## Reactions of Alcohols

    ### 1. Reaction with Metals (Na, K)
    ```
    2R-OH + 2Na → 2R-O⁻Na⁺ + H₂↑
    ```

    **Forms:** Sodium alkoxide + Hydrogen gas

    **Test for -OH group**

    ### 2. Reaction with Hydrogen Halides (HX)
    ```
    R-OH + HX → R-X + H₂O
    ```

    **Reactivity:**
    - **Alcohols:** 3° > 2° > 1° (via carbocation)
    - **HX:** HI > HBr > HCl

    **Lucas Test:** Distinguishes 1°, 2°, 3° alcohols
    - ZnCl₂ + HCl
    - 3°: Immediate turbidity
    - 2°: Turbidity in 5 min
    - 1°: No turbidity at room temp

    ### 3. Dehydration (Formation of Alkenes)
    ```
    R-CH₂-CH₂-OH --[H₂SO₄, 443 K]--> R-CH=CH₂ + H₂O
    ```

    **Ease:** 3° > 2° > 1°

    **Saytzeff product** (more substituted alkene) is major

    ### 4. Oxidation

    #### Primary Alcohols
    ```
    1° R-CH₂-OH --[K₂Cr₂O₇/H⁺]--> R-CHO (Aldehyde) --[oxidation]--> R-COOH (Acid)
    ```

    **Mild oxidation:** PCC (Pyridinium chlorochromate) → Stops at aldehyde

    #### Secondary Alcohols
    ```
    2° R₂CH-OH --[K₂Cr₂O₇/H⁺]--> R₂C=O (Ketone)
    ```

    **Ketones cannot be oxidized further** (no H on carbonyl carbon)

    #### Tertiary Alcohols
    ```
    3° R₃C-OH --[No oxidation under normal conditions]-->
    ```

    **No oxidation** (no H on carbon bearing -OH)

    ### 5. Esterification
    ```
    R-OH + R'-COOH --[H₂SO₄]--> R'-COO-R + H₂O
    ```

    **Forms:** Ester

    ---

    ## IIT JEE Key Points

    1. **Classification:** 1°, 2°, 3° based on carbon bearing -OH
    2. **Boiling point:** High due to H-bonding
    3. **Solubility:** Decreases with increasing chain length
    4. **Acidity:** CH₃OH > 1° > 2° > 3° (weaker than water)
    5. **Hydroboration-oxidation:** Anti-Markovnikov, gives 1° alcohol
    6. **Reduction:** Aldehyde → 1° alcohol, Ketone → 2° alcohol
    7. **Grignard:** Formaldehyde → 1°, Aldehyde → 2°, Ketone → 3°
    8. **Oxidation:** 1° → Aldehyde → Acid, 2° → Ketone, 3° → No oxidation
    9. **Lucas test:** 3° immediate, 2° in 5 min, 1° no reaction
    10. **Dehydration:** 3° > 2° > 1° (ease)

## Key Points

- Alcohols

- Classification

- Nomenclature
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Alcohols', 'Classification', 'Nomenclature', 'Preparation methods', 'Physical properties', 'Hydrogen bonding'],
  prerequisite_ids: []
)

puts "✓ Created 18 microlessons for Alcohols Phenols Ethers"

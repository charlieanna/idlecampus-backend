# AUTO-GENERATED from module_07_aromatic_compounds.rb
puts "Creating Microlessons for Module 07 Aromatic Compounds..."

module_var = CourseModule.find_by(slug: 'module-07-aromatic-compounds')

# === MICROLESSON 1: All meta directing groups are deactivating. ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'All meta directing groups are deactivating.',
  content: <<~MARKDOWN,
# All meta directing groups are deactivating. 🚀

TRUE. All meta directors are deactivating groups. They include -NO₂, -CN, -CHO, -COR, -COOH, -COOR, -SO₃H, -CF₃, -NR₃⁺. These groups have strong -M and/or -I effects that deactivate the ring.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'All meta directing groups are deactivating.',
    answer: '',
    explanation: 'TRUE. All meta directors are deactivating groups. They include -NO₂, -CN, -CHO, -COR, -COOH, -COOR, -SO₃H, -CF₃, -NR₃⁺. These groups have strong -M and/or -I effects that deactivate the ring.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Electrophilic Aromatic Substitution - Mechanisms and Reactions ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Electrophilic Aromatic Substitution - Mechanisms and Reactions',
  content: <<~MARKDOWN,
# Electrophilic Aromatic Substitution - Mechanisms and Reactions 🚀

# Electrophilic Aromatic Substitution (EAS)

    ## 1. Why Substitution Instead of Addition?

    ### Benzene vs Alkenes

    **Alkenes:** Undergo addition reactions
    ```
    CH₂=CH₂ + Br₂ → CH₂Br-CH₂Br
    (Addition product - no loss of unsaturation)
    ```

    **Benzene:** Undergoes substitution reactions
    ```
    C₆H₆ + Br₂ → C₆H₅Br + HBr
    (Substitution product - maintains aromaticity)
    ```

    ### Reason
    - **Addition** would destroy aromaticity (loss of 150 kJ/mol stabilization)
    - **Substitution** maintains aromaticity (energetically favorable)
    - Benzene sacrifices one H to keep aromatic system intact

    ---

    ## 2. General Mechanism of EAS

    ### Two-Step Process

    **Step 1: Formation of σ-complex (Slow, Rate-determining)**
    ```
    Electrophile (E⁺) attacks π cloud
    → Arenium ion (σ-complex, Wheland intermediate)
    → Loss of aromaticity (carbocation intermediate)
    ```

    **Step 2: Deprotonation (Fast)**
    ```
    Loss of H⁺ from carbocation
    → Restoration of aromaticity
    → Substituted benzene
    ```

    ### Detailed Mechanism

    ```
    Step 1: Electrophilic Attack (SLOW)

          H   E                    H   E⁺
          |   |                    |   |
      ⬡       →               ⬡
     /  \\                    /  \\
    |    |                  |    |  (σ-complex)
     \\  /                    \\  /
      ⬡                      ⬡

    (Aromatic)           (Non-aromatic, less stable)


    Step 2: Deprotonation (FAST)

         H   E⁺                    E
         |   |                     |
     ⬡           + Base→       ⬡
    /  \\                      /  \\
   |    |                    |    |
    \\  /                      \\  /
     ⬡                        ⬡

    (σ-complex)              (Aromatic, restored)
    ```

    ### Energy Diagram

    ```
    Energy
      ↑
      |           σ-complex (arenium ion)
      |              /\\
      |             /  \\
      |            /    \\
      |  E⁺       /      \\        Product
      |  +    Ea₁/        \\Ea₂    (aromatic)
      | Benzene  /          \\___________
      |    ___/
      |   /
      |__________________________________→
                Reaction coordinate

    Step 1 (slow): Formation of carbocation (rate-determining)
    Step 2 (fast): Loss of H⁺
    ```

    ---

    ## 3. Halogenation

    ### Reaction
    ```
    Benzene + X₂ → Chlorobenzene/Bromobenzene + HX
    (X = Cl or Br)
    ```

    ### Mechanism

    **Step 1: Generation of electrophile**
    ```
    Br₂ + FeBr₃ → Br⁺ (bromonium ion) + FeBr₄⁻

    FeBr₃ acts as Lewis acid catalyst
    ```

    **Step 2: Electrophilic attack**
    ```
        H  Br⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Bromobenzene + HBr + FeBr₃
    ```

    ### Key Points
    - **Requires Lewis acid catalyst:** FeBr₃, FeCl₃, AlCl₃, AlBr₃
    - **Iodination:** Difficult (reversible), needs oxidizing agent
    - **Fluorination:** Too violent, not used
    - **Only Cl₂ and Br₂** are practical

    ---

    ## 4. Nitration

    ### Reaction
    ```
    Benzene + HNO₃ → Nitrobenzene + H₂O
    (Requires H₂SO₄ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of nitronium ion (NO₂⁺)**
    ```
    HNO₃ + 2H₂SO₄ → NO₂⁺ + H₃O⁺ + 2HSO₄⁻

    Nitronium ion (NO₂⁺) is the electrophile
    ```

    **Step 2: Electrophilic attack**
    ```
        H  NO₂⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Nitrobenzene + H₂SO₄
    ```

    ### Key Points
    - **Electrophile:** NO₂⁺ (nitronium ion)
    - **Reagents:** Conc. HNO₃ + Conc. H₂SO₄ (nitrating mixture)
    - **Product:** Nitrobenzene (yellow liquid)
    - **Application:** Starting material for aniline synthesis

    ---

    ## 5. Sulfonation

    ### Reaction
    ```
    Benzene + H₂SO₄ (fuming) → Benzenesulfonic acid + H₂O
    ```

    ### Mechanism

    **Step 1: Generation of electrophile**
    ```
    H₂SO₄ → SO₃ (sulfur trioxide) + H₂O
    OR
    2H₂SO₄ → SO₃H⁺ (protonated sulfur trioxide)

    Electrophile: SO₃ or SO₃H⁺
    ```

    **Step 2: Electrophilic attack**
    ```
        H  SO₃H⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Benzenesulfonic acid
    ```

    ### Key Points
    - **Electrophile:** SO₃ or SO₃H⁺
    - **Reagent:** Fuming H₂SO₄ (oleum, contains SO₃)
    - **Reversible reaction:** Can be reversed by heating with dilute H₂SO₄
    - **Application:** Detergent synthesis, dye intermediates

    ---

    ## 6. Friedel-Crafts Alkylation

    ### Reaction
    ```
    Benzene + R-X → Alkylbenzene + HX
    (Requires AlCl₃ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of carbocation**
    ```
    R-Cl + AlCl₃ → R⁺ (carbocation) + AlCl₄⁻

    Carbocation is the electrophile
    ```

    **Step 2: Electrophilic attack**
    ```
        H  R⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Alkylbenzene + HCl + AlCl₃
    ```

    ### Limitations

    #### 1. Polyalkylation
    - Product is more reactive than starting benzene
    - Leads to multiple substitutions
    ```
    Benzene → Toluene → Xylene → Trimethylbenzene
    (Difficult to stop at one substitution)
    ```

    #### 2. Carbocation Rearrangement
    - Primary and secondary carbocations rearrange to more stable forms
    ```
    CH₃-CH₂-CH₂-Cl + AlCl₃ → CH₃-CH₂-CH₂⁺
    → CH₃-CH⁺-CH₃ (more stable 2° carbocation)

    Expected: n-propylbenzene
    Actual: Isopropylbenzene (major product)
    ```

    #### 3. Cannot Use with Deactivated Rings
    - NO₂, COOH, SO₃H, etc. deactivate benzene
    - Friedel-Crafts reactions do NOT work on deactivated rings

    ---

    ## 7. Friedel-Crafts Acylation

    ### Reaction
    ```
    Benzene + RCOCl → Acylbenzene (ketone) + HCl
    (Requires AlCl₃ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of acylium ion**
    ```
    R-CO-Cl + AlCl₃ → R-CO⁺ (acylium ion) + AlCl₄⁻

    Acylium ion: R-C≡O⁺ (resonance stabilized)
    ```

    **Step 2: Electrophilic attack**
    ```
        H  R-CO⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Acylbenzene (ketone) + HCl + AlCl₃
    ```

    ### Advantages over Alkylation

    #### 1. No Polyacylation
    - Ketone product is LESS reactive (C=O is electron-withdrawing)
    - Stops after one substitution

    #### 2. No Rearrangement
    - Acylium ion (R-C≡O⁺) is resonance stabilized
    - Does not rearrange

    #### 3. Can be Reduced to Alkylbenzene
    ```
    Acylbenzene → Alkylbenzene (via Clemmensen or Wolff-Kishner reduction)

    Better route to alkylbenzenes than direct alkylation!
    ```

    ---

    ## 8. Comparison of EAS Reactions

    | Reaction | Electrophile | Reagents | Catalyst | Product |
    |----------|--------------|----------|----------|---------|
    | **Halogenation** | X⁺ (Cl⁺, Br⁺) | Cl₂, Br₂ | FeCl₃, FeBr₃ | Halobenzene |
    | **Nitration** | NO₂⁺ | HNO₃ | H₂SO₄ | Nitrobenzene |
    | **Sulfonation** | SO₃, SO₃H⁺ | H₂SO₄ (fuming) | None | Benzenesulfonic acid |
    | **F-C Alkylation** | R⁺ | R-X | AlCl₃ | Alkylbenzene |
    | **F-C Acylation** | RCO⁺ | RCOCl | AlCl₃ | Acylbenzene (ketone) |

    ---

    ## 9. Stability of σ-Complex (Arenium Ion)

    ### Resonance Structures
    The carbocation intermediate (σ-complex) is stabilized by resonance:

    ```
         H   E⁺           H   E⁺           H   E⁺
         |   |            |   |            |   |
     ⬡             ⟷  ⬡             ⟷  ⬡
    /  \\              /  \\              /  \\
   |    |            |    |            |    |
    \\  /              \\  /              \\  /

    Positive charge delocalized over 3 carbons
    (ortho, meta positions relative to attack site)
    ```

    ### Factors Affecting Stability
    1. **Electron-donating groups (+I, +M)** stabilize σ-complex → Faster reaction
    2. **Electron-withdrawing groups (-I, -M)** destabilize σ-complex → Slower reaction
    3. **Position of substituent** affects which positions are stabilized

    ---

    ## Important Points for IIT JEE

    1. **Benzene prefers substitution:**
       - Maintains aromaticity (150 kJ/mol stabilization)
       - Addition would destroy aromatic system

    2. **Rate-determining step:**
       - Formation of σ-complex (Step 1)
       - Electrophile attacks benzene ring
       - Loss of aromaticity is costly energetically

    3. **Friedel-Crafts limitations:**
       - Alkylation: polyalkylation, rearrangement issues
       - Acylation: better alternative, no rearrangement
       - Neither works on deactivated rings (NO₂, COOH, etc.)

    4. **Electrophile generation:**
       - Always requires catalyst or strong acid
       - Memorize electrophiles: X⁺, NO₂⁺, SO₃/SO₃H⁺, R⁺, RCO⁺

    5. **Sulfonation is reversible:**
       - Can remove -SO₃H by heating with dilute H₂SO₄
       - Useful for temporary blocking positions

    ---

    ## Practice Questions

    1. Why does benzene undergo substitution rather than addition with Br₂?
    2. Draw the mechanism for nitration of benzene.
    3. What is the major product when n-propyl chloride reacts with benzene in presence of AlCl₃?
    4. Why is Friedel-Crafts acylation preferred over alkylation?
    5. Why don't Friedel-Crafts reactions work on nitrobenzene?

## Key Points

- General mechanism of EAS

- Halogenation

- Nitration
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['General mechanism of EAS', 'Halogenation', 'Nitration', 'Sulfonation', 'Friedel-Crafts alkylation and acylation', 'Energy profile and intermediate stability'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Directing Effects - Ortho/Para and Meta Directors, Reactivity Patterns ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Directing Effects - Ortho/Para and Meta Directors, Reactivity Patterns',
  content: <<~MARKDOWN,
# Directing Effects - Ortho/Para and Meta Directors, Reactivity Patterns 🚀

# Directing Effects in Aromatic Substitution

    ## 1. Introduction to Directing Effects

    ### Substituents Influence EAS
    When benzene already has one substituent, it affects:
    1. **Reactivity:** How fast EAS occurs (activating/deactivating)
    2. **Orientation:** Where the next substituent goes (ortho/para or meta)

    ### Three Possible Positions
    ```
          Y (existing substituent)
          |
      ⬡
     /  \\
    |    |  (where does new substituent go?)
     \\  /
      ⬡

    Ortho: Positions 2 and 6 (adjacent to Y)
    Meta: Positions 3 and 5 (one carbon away)
    Para: Position 4 (opposite to Y)
    ```

    ---

    ## 2. Types of Directors

    ### A. Ortho/Para Directors
    Direct incoming electrophile to **ortho and para positions**.

    **Examples:**
    - **Activating (increase reactivity):**
      - -OH, -OR (alkoxy)
      - -NH₂, -NHR, -NR₂ (amino)
      - -NHCOCH₃ (acetamido)
      - Alkyl groups: -CH₃, -C₂H₅, etc.

    - **Deactivating (decrease reactivity):**
      - Halogens: -F, -Cl, -Br, -I

    ### B. Meta Directors
    Direct incoming electrophile to **meta position**.

    **All are deactivating (decrease reactivity):**
    - -NO₂ (nitro)
    - -CN (cyano)
    - -CHO (aldehyde)
    - -COR (ketone)
    - -COOH (carboxylic acid)
    - -COOR (ester)
    - -SO₃H (sulfonic acid)
    - -CF₃ (trifluoromethyl)
    - -NR₃⁺ (quaternary ammonium)

    ---

    ## 3. Summary Table

    | Group | Type | Orientation | Reactivity | Effect |
    |-------|------|-------------|------------|--------|
    | **-NH₂, -OH, -OR** | Strong activating | o/p | Very fast | +M >> -I |
    | **-NHCOCH₃** | Moderate activating | o/p | Moderate | +M > -I |
    | **-CH₃, alkyl** | Weak activating | o/p | Slightly fast | +I |
    | **-F, -Cl, -Br, -I** | Weak deactivating | o/p | Slow | -I > +M |
    | **-NO₂, -CN, -CHO, -COOH, -SO₃H** | Strong deactivating | m | Very slow | -M, -I |

    ---

    ## 4. Why Ortho/Para Direction?

    ### Electron-Donating Groups (+M, +I)
    Stabilize σ-complex at **ortho and para** positions through resonance.

    #### Example: Aniline (-NH₂)

    **Ortho attack:**
    ```
         NH₂           NH₂⁺          NH₂⁺          NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
        \\               \\               \\              \\
         E⁺              E              E              E

    Resonance structure with + charge on N
    → Extra stability (N can donate lone pair)
    ```

    **Para attack:**
    ```
         NH₂           NH₂⁺          NH₂⁺          NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
     |                |                |               |
     E⁺               E                E               E

    Resonance structure with + charge on N
    → Extra stability
    ```

    **Meta attack:**
    ```
         NH₂           NH₂           NH₂           NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
       \\              \\              \\             \\
        E⁺             E              E              E

    No resonance structure with + charge on N
    → Less stability
    ```

    **Conclusion:** o/p attack is favored because lone pair on N stabilizes σ-complex.

    ### Alkyl Groups (+I Effect)
    - **+I effect:** Donates electron density
    - Stabilizes positive charge at **o/p positions** more than meta
    - Example: Toluene (-CH₃ group)

    ---

    ## 5. Why Meta Direction?

    ### Electron-Withdrawing Groups (-M, -I)
    Destabilize σ-complex at **ortho and para** positions but meta is least destabilized.

    #### Example: Nitrobenzene (-NO₂)

    **Ortho attack:**
    ```
         NO₂           NO₂           NO₂⁺          NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
        \\               \\               \\              \\
         E⁺              E              E              E

    Resonance structure with + charge adjacent to NO₂
    → Highly unstable (two + charges close)
    ```

    **Para attack:**
    ```
         NO₂           NO₂           NO₂⁺          NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
     |                |                |               |
     E⁺               E                E               E

    Resonance structure with + charge on carbon bearing NO₂
    → Highly unstable
    ```

    **Meta attack:**
    ```
         NO₂           NO₂           NO₂           NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
       \\              \\              \\             \\
        E⁺             E              E              E

    No resonance structure with + charge adjacent to NO₂
    → Least destabilized (relatively)
    ```

    **Conclusion:** Meta attack is favored because it avoids placing + charge adjacent to electron-withdrawing group.

    ---

    ## 6. Special Case: Halogens

    ### Ortho/Para Directors but Deactivating

    **Why o/p directing?**
    - **+M effect (lone pair donation)** stabilizes o/p positions
    - Resonance effect dominates for **orientation**

    **Why deactivating?**
    - **-I effect (electronegativity)** withdraws electrons through σ bonds
    - Inductive effect dominates for **reactivity**

    **Net result:**
    - -I > +M → **Deactivating** (slower than benzene)
    - +M effect still operates → **o/p directing**

    **Order of reactivity:**
    ```
    -F is most deactivating (strongest -I, weakest +M)
    -I is least deactivating (weakest -I, strongest +M)

    Order: -F > -Cl > -Br > -I (deactivation)
    ```

    ---

    ## 7. Activating vs Deactivating Groups

    ### Activating Groups
    - **Make benzene MORE reactive** than unsubstituted benzene
    - **Stabilize σ-complex** (lower activation energy)
    - All are **ortho/para directors** (except none)

    **Order of activation:**
    ```
    -O⁻ > -NH₂ > -OH > -OR > -NHCOCH₃ > -CH₃ > -H (benzene)
    (strongest)                                    (reference)
    ```

    ### Deactivating Groups
    - **Make benzene LESS reactive** than unsubstituted benzene
    - **Destabilize σ-complex** (higher activation energy)
    - Most are **meta directors**
    - Exception: **Halogens are o/p directors** but deactivating

    **Order of deactivation:**
    ```
    -H (benzene) > -F > -Cl > -Br > -I > -COOH > -CHO > -NO₂ > -NR₃⁺
    (reference)                                              (strongest)
    ```

    ---

    ## 8. Orientation in Disubstituted Benzenes

    ### Rule 1: Activating Group Wins
    When two groups compete, the **more activating group** controls orientation.

    **Example:** p-Nitrotoluene
    ```
         CH₃ (o/p, activating)
          |
      ⬡
          |
         NO₂ (m, deactivating)

    -CH₃ is more activating → controls orientation
    → Electrophile goes ortho to -CH₃ (meta to -NO₂)
    ```

    ### Rule 2: When Both Are Activating
    If both are activating, **both direct** (may give mixture).

    **Example:** p-Cresol (p-methylphenol)
    ```
         OH (o/p, strong activating)
         |
     ⬡
         |
         CH₃ (o/p, weak activating)

    Both are activating, -OH is stronger
    → Major product: ortho and meta to -OH (ortho to -CH₃)
    ```

    ### Rule 3: Steric Effects
    - **Ortho position** to bulky groups is disfavored (steric hindrance)
    - **Para product** is often major when ortho is hindered

    ### Rule 4: When Both Are Deactivating
    - **Less deactivating group** controls
    - Reaction is very slow

    ---

    ## 9. Predicting Products

    ### Strategy
    1. **Identify existing substituent(s)**
    2. **Classify:** Activating/deactivating, o/p or meta directing
    3. **Apply rules:**
       - Activating group wins
       - o/p directors → ortho and para products
       - meta directors → meta products
    4. **Consider steric effects** (para favored if ortho is crowded)

    ### Example 1: Bromination of Toluene
    ```
    Toluene (-CH₃, o/p directing, activating)
    + Br₂/FeBr₃
    →
    Major products: o-Bromotoluene + p-Bromotoluene
    (ortho and para to -CH₃)
    ```

    ### Example 2: Nitration of Benzoic Acid
    ```
    Benzoic acid (-COOH, m directing, deactivating)
    + HNO₃/H₂SO₄
    →
    Major product: m-Nitrobenzoic acid
    (meta to -COOH)
    ```

    ### Example 3: Nitration of Chlorobenzene
    ```
    Chlorobenzene (-Cl, o/p directing, deactivating)
    + HNO₃/H₂SO₄
    →
    Major products: o-Nitrochlorobenzene + p-Nitrochlorobenzene
    (ortho and para to -Cl, but reaction is slower than benzene)
    ```

    ---

    ## 10. Blocking Positions

    ### Strategy for Selective Substitution
    Sometimes we need to "block" certain positions to control orientation.

    **Example: Synthesis of m-Bromonitrobenzene**

    **Wrong approach:**
    ```
    Benzene → Nitration → Nitrobenzene → Bromination → m-Bromonitrobenzene (✓)
    (NO₂ directs meta)
    ```

    **Right approach:**
    ```
    Benzene → Bromination → Bromobenzene → Nitration → o/p-Bromonitrobenzene (✗)
    (Br directs ortho/para, not meta!)
    ```

    **To get meta product:** Introduce meta-director FIRST.

    ---

    ## Important Points for IIT JEE

    1. **Memorize directors:**
       - o/p activating: -OH, -OR, -NH₂, -NHR, -CH₃
       - o/p deactivating: -F, -Cl, -Br, -I
       - m deactivating: -NO₂, -CHO, -COOH, -CN, -SO₃H

    2. **Orientation explanation:**
       - o/p directors stabilize σ-complex at o/p via +M or +I
       - m directors destabilize o/p more than meta via -M or -I

    3. **Halogens are special:**
       - o/p directing (due to +M)
       - But deactivating (due to -I > +M)

    4. **Reactivity order:**
       - Activated benzene > Benzene > Deactivated benzene
       - More activating = faster reaction

    5. **Disubstituted benzenes:**
       - More activating group controls orientation
       - Steric effects favor para over ortho

    ---

    ## Practice Questions

    1. Predict the major product of nitration of anisole (methoxybenzene).
    2. Why is chlorobenzene less reactive than benzene in EAS?
    3. Arrange in order of reactivity toward EAS: benzene, toluene, nitrobenzene.
    4. Explain why halogens are o/p directors but deactivating.
    5. How would you synthesize m-nitrochlorobenzene from benzene?

## Key Points

- Ortho/Para directing groups

- Meta directing groups

- Activating vs deactivating groups
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ortho/Para directing groups', 'Meta directing groups', 'Activating vs deactivating groups', 'Explanation using resonance and inductive effects', 'Orientation in disubstituted benzenes'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Introduction to Aromaticity - Benzene Structure and Huckel\ ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Aromaticity - Benzene Structure and Huckel\',
  content: <<~MARKDOWN,
# Introduction to Aromaticity - Benzene Structure and Huckel\ 🚀

# Introduction to Aromaticity

    ## 1. Discovery and Structure of Benzene

    ### Historical Context
    - **Molecular formula:** C₆H₆
    - **Discovered by:** Michael Faraday (1825)
    - **Structure proposed by:** Friedrich August Kekulé (1865)

    ### Kekulé Structure
    ```
    Two possible structures (resonance):

         ⬡                ⬡
        / \\              /  \\
       /   \\            //   \\
      |     |     ⟷    |     |
       \   /             \\   /
        \\_//              \\ //
         ⬡                ⬡

    Alternating single and double bonds
    ```

    ### Problems with Kekulé Structure
    1. **Should show reactivity of alkenes** → But benzene is very stable
    2. **Should have two different C-C bond lengths** → But all are equal (139 pm)
    3. **Heat of hydrogenation** should be 3× cyclohexene → But it's much less

    ---

    ## 2. Modern Structure of Benzene

    ### Resonance Model
    - **All C-C bonds are equivalent** (139 pm)
    - **Bond order:** 1.5 (between single and double)
    - **Hybrid structure:** Resonance between two Kekulé structures
    - **π electrons delocalized** over all six carbons

    ### Orbital Picture
    - **All carbons:** sp² hybridized
    - **Bond angles:** 120° (hexagonal, planar)
    - **π system:** 6 p orbitals overlap to form continuous π cloud above and below the ring

    ```
    Side view of benzene:

         π electron cloud (above)
         ___________________
        |                   |
    C — C — C — C — C — C (σ framework)
        |___________________|
         π electron cloud (below)

    6 π electrons delocalized
    ```

    ### Resonance Energy
    - **Definition:** Extra stability due to delocalization
    - **Benzene resonance energy:** 150 kJ/mol (36 kcal/mol)
    - **Meaning:** Benzene is 150 kJ/mol more stable than predicted for localized structure

    **Evidence from hydrogenation:**
    ```
    Cyclohexene + H₂ → Cyclohexane         ΔH = -120 kJ/mol

    Predicted for benzene (3 double bonds):
    3 × (-120) = -360 kJ/mol

    Actual for benzene:
    Benzene + 3H₂ → Cyclohexane            ΔH = -210 kJ/mol

    Difference = 360 - 210 = 150 kJ/mol
    (This is the resonance energy/stabilization)
    ```

    ---

    ## 3. Aromaticity - Definition and Criteria

    ### What is Aromaticity?
    **Aromaticity** is the special stability exhibited by cyclic, planar compounds with delocalized π electrons following Huckel's rule.

    ### Criteria for Aromaticity (Must satisfy ALL)

    #### 1. Cyclic Structure
    - Molecule must form a ring
    - Acyclic systems cannot be aromatic

    #### 2. Planar Geometry
    - All atoms in the ring must be in the same plane
    - Allows p orbital overlap for π delocalization
    - Non-planar rings cannot have effective π overlap

    #### 3. Complete Conjugation
    - Every atom in the ring has a p orbital
    - Continuous overlap of p orbitals around the ring
    - Typically sp² or sp hybridized atoms

    #### 4. Huckel's Rule: (4n + 2) π electrons
    - **n** is a non-negative integer (0, 1, 2, 3, ...)
    - **Aromatic:** 2, 6, 10, 14, 18, ... π electrons
    - **Antiaromatic:** 4n π electrons (4, 8, 12, ...)

    ---

    ## 4. Huckel's Rule Explained

    ### The (4n + 2) Rule

    **Aromatic compounds have (4n + 2) π electrons where n = 0, 1, 2, 3, ...**

    | n | 4n + 2 | π electrons | Example |
    |---|--------|-------------|---------|
    | 0 | 2 | 2 | Cyclopropenyl cation |
    | 1 | 6 | 6 | Benzene, pyridine |
    | 2 | 10 | 10 | Naphthalene, azulene |
    | 3 | 14 | 14 | Anthracene |
    | 4 | 18 | 18 | [18]Annulene |

    ### Quantum Mechanical Origin
    - Based on **molecular orbital theory**
    - (4n + 2) π electrons fill all bonding and non-bonding MOs
    - Results in **closed-shell configuration** (extra stable)

    ---

    ## 5. Types of Compounds

    ### A. Aromatic Compounds
    - **Satisfy all criteria** including (4n+2) π electrons
    - **Exceptionally stable** (low reactivity)
    - **Undergo substitution** rather than addition reactions
    - **Examples:** Benzene, naphthalene, pyridine, furan

    ### B. Antiaromatic Compounds
    - Cyclic, planar, conjugated
    - Have **4n π electrons** (n = 1, 2, 3, ...)
    - **Highly unstable** (more reactive than expected)
    - **Avoid planarity** if possible (to reduce instability)
    - **Examples:** Cyclobutadiene, cyclooctatetraene (if planar)

    ### C. Nonaromatic Compounds
    - Do NOT meet one or more criteria
    - **Not cyclic**, OR
    - **Not planar**, OR
    - **Not conjugated**
    - **Normal stability** (neither extra stable nor unstable)
    - **Examples:** Cyclohexene, cyclohexane, cyclooctatetraene (tub-shaped)

    ---

    ## 6. Examples and Analysis

    ### Aromatic Examples

    #### Benzene (C₆H₆)
    ```
    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated (6 p orbitals)
    ✓ 6 π electrons (4n+2, n=1)
    → AROMATIC
    ```

    #### Naphthalene (C₁₀H₈)
    ```
    ⬡⬡  (Two fused benzene rings)

    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated
    ✓ 10 π electrons (4n+2, n=2)
    → AROMATIC
    ```

    #### Cyclopropenyl Cation (C₃H₃⁺)
    ```
         +
        /⌃\\
       /    \\

    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated (3 p orbitals)
    ✓ 2 π electrons (4n+2, n=0)
    → AROMATIC
    ```

    ### Antiaromatic Example

    #### Cyclobutadiene (C₄H₄)
    ```
      ⬡
     /  \\
    |    |
     \\  /
      ⬡

    ✓ Cyclic
    ✓ Planar (if forced)
    ✓ Conjugated
    ✗ 4 π electrons (4n, n=1)
    → ANTIAROMATIC (highly unstable)
    ```

    ### Nonaromatic Examples

    #### Cyclohexene
    ```
       ⬡
      /  \\
     /    \\
    |      | (one double bond)
     \\    /
      \\  /

    ✓ Cyclic
    ✓ Planar (roughly)
    ✗ NOT fully conjugated (one sp³ carbon)
    → NONAROMATIC
    ```

    #### Cyclooctatetraene (C₈H₈) - Actual Structure
    ```
    ✓ Cyclic
    ✗ NOT planar (adopts tub shape to avoid antiaromaticity)
    ✓ Would be conjugated if planar
    ✗ 8 π electrons (4n, n=2) → would be antiaromatic if planar

    → NONAROMATIC (avoids antiaromaticity by being non-planar)
    ```

    ---

    ## 7. Aromatic Ions

    ### Cyclopropenyl Cation (C₃H₃⁺)
    - **2 π electrons** (4n+2, n=0)
    - **Aromatic** and very stable for a cation
    - pKa of precursor ~1 (very acidic)

    ### Cyclopropenyl Anion (C₃H₃⁻)
    - **4 π electrons** (4n, n=1)
    - **Antiaromatic** and very unstable

    ### Cyclopentadienyl Anion (C₅H₅⁻)
    ```
        ⊖
       /⌂\\
      /    \\
     |      |
      \\    /
       \\__/

    6 π electrons (4n+2, n=1)
    → AROMATIC (very stable anion)
    pKa of cyclopentadiene ≈ 16 (very acidic for hydrocarbon)
    ```

    ### Cyclopentadienyl Cation (C₅H₅⁺)
    - **4 π electrons** (4n, n=1)
    - **Antiaromatic** and very unstable

    ### Cycloheptatrienyl Cation (Tropylium, C₇H₇⁺)
    ```
         ⊕
        /⌃\\
       /    \\
      |      |
       \\    /
        \\__/

    6 π electrons (4n+2, n=1)
    → AROMATIC (stable cation)
    ```

    **Summary:**
    - **Cyclopentadienyl anion:** Aromatic (6 π e⁻)
    - **Tropylium cation:** Aromatic (6 π e⁻)
    - Both are exceptionally stable for ions

    ---

    ## 8. Aromatic Heterocycles

    ### Pyridine (C₅H₅N)
    ```
         N
        /⌂\\
       /    \\
      |      |
       \\    /
        \\__/

    - Nitrogen has one lone pair in sp² orbital (NOT in π system)
    - 6 π electrons from 5 carbons + 1 from N
    - Aromatic
    ```

    ### Pyrrole (C₄H₅N)
    ```
         N-H
        /⌂\\
       /    \\
      |      |
       \\____/

    - Nitrogen lone pair IN π system
    - 6 π electrons (4 from C=C + 2 from N)
    - Aromatic
    - Less basic than pyridine (lone pair delocalized)
    ```

    ### Furan (C₄H₄O)
    ```
         O
        /⌂\\
       /    \\
      |      |
       \\____/

    - Oxygen has one lone pair in π system
    - 6 π electrons (4 from C=C + 2 from O)
    - Aromatic
    ```

    ### Comparison

    | Compound | Heteroatom | Lone pair position | π electrons | Aromatic? |
    |----------|------------|-------------------|-------------|-----------|
    | Benzene | None | — | 6 | Yes |
    | Pyridine | N | sp² (not in π) | 6 | Yes |
    | Pyrrole | N | p (in π) | 6 | Yes |
    | Furan | O | p (in π) | 6 | Yes |

    ---

    ## 9. Stability Order

    ### Aromatic > Nonaromatic > Antiaromatic

    **Energy comparison:**
    ```
    Antiaromatic (least stable)
          ↑
          | (highly unstable)
          |
    Nonaromatic (normal stability)
          ↑
          | (resonance stabilization)
          |
    Aromatic (most stable)
    ```

    **Example: C₅H₅ species**
    ```
    C₅H₅⁺ (4π, antiaromatic) < C₅H₅• (5π, nonaromatic) < C₅H₅⁻ (6π, aromatic)
    (least stable)                                         (most stable)
    ```

    ---

    ## Important Points for IIT JEE

    1. **Huckel's rule memorization:**
       - Aromatic: 2, 6, 10, 14, 18 π electrons
       - Antiaromatic: 4, 8, 12, 16 π electrons
       - Must be cyclic, planar, and conjugated

    2. **Counting π electrons:**
       - Double bond = 2 π electrons
       - Lone pair (if in p orbital) = 2 π electrons
       - Empty p orbital = 0 π electrons
       - Check ONLY the cyclic system

    3. **Aromaticity in ions:**
       - C₃H₃⁺, C₅H₅⁻, C₇H₇⁺ are aromatic (6 π e⁻)
       - These ions are surprisingly stable

    4. **Heterocycles:**
       - Pyridine: N lone pair NOT in π system (basic)
       - Pyrrole: N lone pair IN π system (weakly basic)
       - Both are aromatic (6 π electrons)

    5. **Resonance energy:**
       - Measure of extra stability
       - Benzene: 150 kJ/mol
       - Explains why benzene undergoes substitution, not addition

    ---

    ## Practice Questions

    1. Is cyclooctatetraene aromatic, antiaromatic, or nonaromatic? Explain.
    2. Calculate the number of π electrons in furan and determine if it's aromatic.
    3. Why is cyclopentadienyl anion much more stable than typical carbanions?
    4. Draw the structure of naphthalene and verify it follows Huckel's rule.
    5. Compare the basicity of pyridine and pyrrole. Explain the difference.

## Key Points

- Structure of benzene

- Aromaticity and resonance energy

- Huckel\
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Structure of benzene', 'Aromaticity and resonance energy', 'Huckel\', ',
    ', ',
    '],
  prerequisite_ids: []
)

# === MICROLESSON 5: Electrophilic Aromatic Substitution - Mechanisms and Reactions ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Electrophilic Aromatic Substitution - Mechanisms and Reactions',
  content: <<~MARKDOWN,
# Electrophilic Aromatic Substitution - Mechanisms and Reactions 🚀

# Electrophilic Aromatic Substitution (EAS)

    ## 1. Why Substitution Instead of Addition?

    ### Benzene vs Alkenes

    **Alkenes:** Undergo addition reactions
    ```
    CH₂=CH₂ + Br₂ → CH₂Br-CH₂Br
    (Addition product - no loss of unsaturation)
    ```

    **Benzene:** Undergoes substitution reactions
    ```
    C₆H₆ + Br₂ → C₆H₅Br + HBr
    (Substitution product - maintains aromaticity)
    ```

    ### Reason
    - **Addition** would destroy aromaticity (loss of 150 kJ/mol stabilization)
    - **Substitution** maintains aromaticity (energetically favorable)
    - Benzene sacrifices one H to keep aromatic system intact

    ---

    ## 2. General Mechanism of EAS

    ### Two-Step Process

    **Step 1: Formation of σ-complex (Slow, Rate-determining)**
    ```
    Electrophile (E⁺) attacks π cloud
    → Arenium ion (σ-complex, Wheland intermediate)
    → Loss of aromaticity (carbocation intermediate)
    ```

    **Step 2: Deprotonation (Fast)**
    ```
    Loss of H⁺ from carbocation
    → Restoration of aromaticity
    → Substituted benzene
    ```

    ### Detailed Mechanism

    ```
    Step 1: Electrophilic Attack (SLOW)

          H   E                    H   E⁺
          |   |                    |   |
      ⬡       →               ⬡
     /  \\                    /  \\
    |    |                  |    |  (σ-complex)
     \\  /                    \\  /
      ⬡                      ⬡

    (Aromatic)           (Non-aromatic, less stable)


    Step 2: Deprotonation (FAST)

         H   E⁺                    E
         |   |                     |
     ⬡           + Base→       ⬡
    /  \\                      /  \\
   |    |                    |    |
    \\  /                      \\  /
     ⬡                        ⬡

    (σ-complex)              (Aromatic, restored)
    ```

    ### Energy Diagram

    ```
    Energy
      ↑
      |           σ-complex (arenium ion)
      |              /\\
      |             /  \\
      |            /    \\
      |  E⁺       /      \\        Product
      |  +    Ea₁/        \\Ea₂    (aromatic)
      | Benzene  /          \\___________
      |    ___/
      |   /
      |__________________________________→
                Reaction coordinate

    Step 1 (slow): Formation of carbocation (rate-determining)
    Step 2 (fast): Loss of H⁺
    ```

    ---

    ## 3. Halogenation

    ### Reaction
    ```
    Benzene + X₂ → Chlorobenzene/Bromobenzene + HX
    (X = Cl or Br)
    ```

    ### Mechanism

    **Step 1: Generation of electrophile**
    ```
    Br₂ + FeBr₃ → Br⁺ (bromonium ion) + FeBr₄⁻

    FeBr₃ acts as Lewis acid catalyst
    ```

    **Step 2: Electrophilic attack**
    ```
        H  Br⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Bromobenzene + HBr + FeBr₃
    ```

    ### Key Points
    - **Requires Lewis acid catalyst:** FeBr₃, FeCl₃, AlCl₃, AlBr₃
    - **Iodination:** Difficult (reversible), needs oxidizing agent
    - **Fluorination:** Too violent, not used
    - **Only Cl₂ and Br₂** are practical

    ---

    ## 4. Nitration

    ### Reaction
    ```
    Benzene + HNO₃ → Nitrobenzene + H₂O
    (Requires H₂SO₄ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of nitronium ion (NO₂⁺)**
    ```
    HNO₃ + 2H₂SO₄ → NO₂⁺ + H₃O⁺ + 2HSO₄⁻

    Nitronium ion (NO₂⁺) is the electrophile
    ```

    **Step 2: Electrophilic attack**
    ```
        H  NO₂⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Nitrobenzene + H₂SO₄
    ```

    ### Key Points
    - **Electrophile:** NO₂⁺ (nitronium ion)
    - **Reagents:** Conc. HNO₃ + Conc. H₂SO₄ (nitrating mixture)
    - **Product:** Nitrobenzene (yellow liquid)
    - **Application:** Starting material for aniline synthesis

    ---

    ## 5. Sulfonation

    ### Reaction
    ```
    Benzene + H₂SO₄ (fuming) → Benzenesulfonic acid + H₂O
    ```

    ### Mechanism

    **Step 1: Generation of electrophile**
    ```
    H₂SO₄ → SO₃ (sulfur trioxide) + H₂O
    OR
    2H₂SO₄ → SO₃H⁺ (protonated sulfur trioxide)

    Electrophile: SO₃ or SO₃H⁺
    ```

    **Step 2: Electrophilic attack**
    ```
        H  SO₃H⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Benzenesulfonic acid
    ```

    ### Key Points
    - **Electrophile:** SO₃ or SO₃H⁺
    - **Reagent:** Fuming H₂SO₄ (oleum, contains SO₃)
    - **Reversible reaction:** Can be reversed by heating with dilute H₂SO₄
    - **Application:** Detergent synthesis, dye intermediates

    ---

    ## 6. Friedel-Crafts Alkylation

    ### Reaction
    ```
    Benzene + R-X → Alkylbenzene + HX
    (Requires AlCl₃ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of carbocation**
    ```
    R-Cl + AlCl₃ → R⁺ (carbocation) + AlCl₄⁻

    Carbocation is the electrophile
    ```

    **Step 2: Electrophilic attack**
    ```
        H  R⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Alkylbenzene + HCl + AlCl₃
    ```

    ### Limitations

    #### 1. Polyalkylation
    - Product is more reactive than starting benzene
    - Leads to multiple substitutions
    ```
    Benzene → Toluene → Xylene → Trimethylbenzene
    (Difficult to stop at one substitution)
    ```

    #### 2. Carbocation Rearrangement
    - Primary and secondary carbocations rearrange to more stable forms
    ```
    CH₃-CH₂-CH₂-Cl + AlCl₃ → CH₃-CH₂-CH₂⁺
    → CH₃-CH⁺-CH₃ (more stable 2° carbocation)

    Expected: n-propylbenzene
    Actual: Isopropylbenzene (major product)
    ```

    #### 3. Cannot Use with Deactivated Rings
    - NO₂, COOH, SO₃H, etc. deactivate benzene
    - Friedel-Crafts reactions do NOT work on deactivated rings

    ---

    ## 7. Friedel-Crafts Acylation

    ### Reaction
    ```
    Benzene + RCOCl → Acylbenzene (ketone) + HCl
    (Requires AlCl₃ catalyst)
    ```

    ### Mechanism

    **Step 1: Generation of acylium ion**
    ```
    R-CO-Cl + AlCl₃ → R-CO⁺ (acylium ion) + AlCl₄⁻

    Acylium ion: R-C≡O⁺ (resonance stabilized)
    ```

    **Step 2: Electrophilic attack**
    ```
        H  R-CO⁺
        |  |
    ⬡      →  σ-complex
    ```

    **Step 3: Deprotonation**
    ```
    σ-complex → Acylbenzene (ketone) + HCl + AlCl₃
    ```

    ### Advantages over Alkylation

    #### 1. No Polyacylation
    - Ketone product is LESS reactive (C=O is electron-withdrawing)
    - Stops after one substitution

    #### 2. No Rearrangement
    - Acylium ion (R-C≡O⁺) is resonance stabilized
    - Does not rearrange

    #### 3. Can be Reduced to Alkylbenzene
    ```
    Acylbenzene → Alkylbenzene (via Clemmensen or Wolff-Kishner reduction)

    Better route to alkylbenzenes than direct alkylation!
    ```

    ---

    ## 8. Comparison of EAS Reactions

    | Reaction | Electrophile | Reagents | Catalyst | Product |
    |----------|--------------|----------|----------|---------|
    | **Halogenation** | X⁺ (Cl⁺, Br⁺) | Cl₂, Br₂ | FeCl₃, FeBr₃ | Halobenzene |
    | **Nitration** | NO₂⁺ | HNO₃ | H₂SO₄ | Nitrobenzene |
    | **Sulfonation** | SO₃, SO₃H⁺ | H₂SO₄ (fuming) | None | Benzenesulfonic acid |
    | **F-C Alkylation** | R⁺ | R-X | AlCl₃ | Alkylbenzene |
    | **F-C Acylation** | RCO⁺ | RCOCl | AlCl₃ | Acylbenzene (ketone) |

    ---

    ## 9. Stability of σ-Complex (Arenium Ion)

    ### Resonance Structures
    The carbocation intermediate (σ-complex) is stabilized by resonance:

    ```
         H   E⁺           H   E⁺           H   E⁺
         |   |            |   |            |   |
     ⬡             ⟷  ⬡             ⟷  ⬡
    /  \\              /  \\              /  \\
   |    |            |    |            |    |
    \\  /              \\  /              \\  /

    Positive charge delocalized over 3 carbons
    (ortho, meta positions relative to attack site)
    ```

    ### Factors Affecting Stability
    1. **Electron-donating groups (+I, +M)** stabilize σ-complex → Faster reaction
    2. **Electron-withdrawing groups (-I, -M)** destabilize σ-complex → Slower reaction
    3. **Position of substituent** affects which positions are stabilized

    ---

    ## Important Points for IIT JEE

    1. **Benzene prefers substitution:**
       - Maintains aromaticity (150 kJ/mol stabilization)
       - Addition would destroy aromatic system

    2. **Rate-determining step:**
       - Formation of σ-complex (Step 1)
       - Electrophile attacks benzene ring
       - Loss of aromaticity is costly energetically

    3. **Friedel-Crafts limitations:**
       - Alkylation: polyalkylation, rearrangement issues
       - Acylation: better alternative, no rearrangement
       - Neither works on deactivated rings (NO₂, COOH, etc.)

    4. **Electrophile generation:**
       - Always requires catalyst or strong acid
       - Memorize electrophiles: X⁺, NO₂⁺, SO₃/SO₃H⁺, R⁺, RCO⁺

    5. **Sulfonation is reversible:**
       - Can remove -SO₃H by heating with dilute H₂SO₄
       - Useful for temporary blocking positions

    ---

    ## Practice Questions

    1. Why does benzene undergo substitution rather than addition with Br₂?
    2. Draw the mechanism for nitration of benzene.
    3. What is the major product when n-propyl chloride reacts with benzene in presence of AlCl₃?
    4. Why is Friedel-Crafts acylation preferred over alkylation?
    5. Why don't Friedel-Crafts reactions work on nitrobenzene?

## Key Points

- General mechanism of EAS

- Halogenation

- Nitration
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['General mechanism of EAS', 'Halogenation', 'Nitration', 'Sulfonation', 'Friedel-Crafts alkylation and acylation', 'Energy profile and intermediate stability'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Directing Effects - Ortho/Para and Meta Directors, Reactivity Patterns ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Directing Effects - Ortho/Para and Meta Directors, Reactivity Patterns',
  content: <<~MARKDOWN,
# Directing Effects - Ortho/Para and Meta Directors, Reactivity Patterns 🚀

# Directing Effects in Aromatic Substitution

    ## 1. Introduction to Directing Effects

    ### Substituents Influence EAS
    When benzene already has one substituent, it affects:
    1. **Reactivity:** How fast EAS occurs (activating/deactivating)
    2. **Orientation:** Where the next substituent goes (ortho/para or meta)

    ### Three Possible Positions
    ```
          Y (existing substituent)
          |
      ⬡
     /  \\
    |    |  (where does new substituent go?)
     \\  /
      ⬡

    Ortho: Positions 2 and 6 (adjacent to Y)
    Meta: Positions 3 and 5 (one carbon away)
    Para: Position 4 (opposite to Y)
    ```

    ---

    ## 2. Types of Directors

    ### A. Ortho/Para Directors
    Direct incoming electrophile to **ortho and para positions**.

    **Examples:**
    - **Activating (increase reactivity):**
      - -OH, -OR (alkoxy)
      - -NH₂, -NHR, -NR₂ (amino)
      - -NHCOCH₃ (acetamido)
      - Alkyl groups: -CH₃, -C₂H₅, etc.

    - **Deactivating (decrease reactivity):**
      - Halogens: -F, -Cl, -Br, -I

    ### B. Meta Directors
    Direct incoming electrophile to **meta position**.

    **All are deactivating (decrease reactivity):**
    - -NO₂ (nitro)
    - -CN (cyano)
    - -CHO (aldehyde)
    - -COR (ketone)
    - -COOH (carboxylic acid)
    - -COOR (ester)
    - -SO₃H (sulfonic acid)
    - -CF₃ (trifluoromethyl)
    - -NR₃⁺ (quaternary ammonium)

    ---

    ## 3. Summary Table

    | Group | Type | Orientation | Reactivity | Effect |
    |-------|------|-------------|------------|--------|
    | **-NH₂, -OH, -OR** | Strong activating | o/p | Very fast | +M >> -I |
    | **-NHCOCH₃** | Moderate activating | o/p | Moderate | +M > -I |
    | **-CH₃, alkyl** | Weak activating | o/p | Slightly fast | +I |
    | **-F, -Cl, -Br, -I** | Weak deactivating | o/p | Slow | -I > +M |
    | **-NO₂, -CN, -CHO, -COOH, -SO₃H** | Strong deactivating | m | Very slow | -M, -I |

    ---

    ## 4. Why Ortho/Para Direction?

    ### Electron-Donating Groups (+M, +I)
    Stabilize σ-complex at **ortho and para** positions through resonance.

    #### Example: Aniline (-NH₂)

    **Ortho attack:**
    ```
         NH₂           NH₂⁺          NH₂⁺          NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
        \\               \\               \\              \\
         E⁺              E              E              E

    Resonance structure with + charge on N
    → Extra stability (N can donate lone pair)
    ```

    **Para attack:**
    ```
         NH₂           NH₂⁺          NH₂⁺          NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
     |                |                |               |
     E⁺               E                E               E

    Resonance structure with + charge on N
    → Extra stability
    ```

    **Meta attack:**
    ```
         NH₂           NH₂           NH₂           NH₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
       \\              \\              \\             \\
        E⁺             E              E              E

    No resonance structure with + charge on N
    → Less stability
    ```

    **Conclusion:** o/p attack is favored because lone pair on N stabilizes σ-complex.

    ### Alkyl Groups (+I Effect)
    - **+I effect:** Donates electron density
    - Stabilizes positive charge at **o/p positions** more than meta
    - Example: Toluene (-CH₃ group)

    ---

    ## 5. Why Meta Direction?

    ### Electron-Withdrawing Groups (-M, -I)
    Destabilize σ-complex at **ortho and para** positions but meta is least destabilized.

    #### Example: Nitrobenzene (-NO₂)

    **Ortho attack:**
    ```
         NO₂           NO₂           NO₂⁺          NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
        \\               \\               \\              \\
         E⁺              E              E              E

    Resonance structure with + charge adjacent to NO₂
    → Highly unstable (two + charges close)
    ```

    **Para attack:**
    ```
         NO₂           NO₂           NO₂⁺          NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
     |                |                |               |
     E⁺               E                E               E

    Resonance structure with + charge on carbon bearing NO₂
    → Highly unstable
    ```

    **Meta attack:**
    ```
         NO₂           NO₂           NO₂           NO₂
         |             |             |             |
     ⬡           ⟷ ⬡           ⟷ ⬡           ⟷ ⬡
       \\              \\              \\             \\
        E⁺             E              E              E

    No resonance structure with + charge adjacent to NO₂
    → Least destabilized (relatively)
    ```

    **Conclusion:** Meta attack is favored because it avoids placing + charge adjacent to electron-withdrawing group.

    ---

    ## 6. Special Case: Halogens

    ### Ortho/Para Directors but Deactivating

    **Why o/p directing?**
    - **+M effect (lone pair donation)** stabilizes o/p positions
    - Resonance effect dominates for **orientation**

    **Why deactivating?**
    - **-I effect (electronegativity)** withdraws electrons through σ bonds
    - Inductive effect dominates for **reactivity**

    **Net result:**
    - -I > +M → **Deactivating** (slower than benzene)
    - +M effect still operates → **o/p directing**

    **Order of reactivity:**
    ```
    -F is most deactivating (strongest -I, weakest +M)
    -I is least deactivating (weakest -I, strongest +M)

    Order: -F > -Cl > -Br > -I (deactivation)
    ```

    ---

    ## 7. Activating vs Deactivating Groups

    ### Activating Groups
    - **Make benzene MORE reactive** than unsubstituted benzene
    - **Stabilize σ-complex** (lower activation energy)
    - All are **ortho/para directors** (except none)

    **Order of activation:**
    ```
    -O⁻ > -NH₂ > -OH > -OR > -NHCOCH₃ > -CH₃ > -H (benzene)
    (strongest)                                    (reference)
    ```

    ### Deactivating Groups
    - **Make benzene LESS reactive** than unsubstituted benzene
    - **Destabilize σ-complex** (higher activation energy)
    - Most are **meta directors**
    - Exception: **Halogens are o/p directors** but deactivating

    **Order of deactivation:**
    ```
    -H (benzene) > -F > -Cl > -Br > -I > -COOH > -CHO > -NO₂ > -NR₃⁺
    (reference)                                              (strongest)
    ```

    ---

    ## 8. Orientation in Disubstituted Benzenes

    ### Rule 1: Activating Group Wins
    When two groups compete, the **more activating group** controls orientation.

    **Example:** p-Nitrotoluene
    ```
         CH₃ (o/p, activating)
          |
      ⬡
          |
         NO₂ (m, deactivating)

    -CH₃ is more activating → controls orientation
    → Electrophile goes ortho to -CH₃ (meta to -NO₂)
    ```

    ### Rule 2: When Both Are Activating
    If both are activating, **both direct** (may give mixture).

    **Example:** p-Cresol (p-methylphenol)
    ```
         OH (o/p, strong activating)
         |
     ⬡
         |
         CH₃ (o/p, weak activating)

    Both are activating, -OH is stronger
    → Major product: ortho and meta to -OH (ortho to -CH₃)
    ```

    ### Rule 3: Steric Effects
    - **Ortho position** to bulky groups is disfavored (steric hindrance)
    - **Para product** is often major when ortho is hindered

    ### Rule 4: When Both Are Deactivating
    - **Less deactivating group** controls
    - Reaction is very slow

    ---

    ## 9. Predicting Products

    ### Strategy
    1. **Identify existing substituent(s)**
    2. **Classify:** Activating/deactivating, o/p or meta directing
    3. **Apply rules:**
       - Activating group wins
       - o/p directors → ortho and para products
       - meta directors → meta products
    4. **Consider steric effects** (para favored if ortho is crowded)

    ### Example 1: Bromination of Toluene
    ```
    Toluene (-CH₃, o/p directing, activating)
    + Br₂/FeBr₃
    →
    Major products: o-Bromotoluene + p-Bromotoluene
    (ortho and para to -CH₃)
    ```

    ### Example 2: Nitration of Benzoic Acid
    ```
    Benzoic acid (-COOH, m directing, deactivating)
    + HNO₃/H₂SO₄
    →
    Major product: m-Nitrobenzoic acid
    (meta to -COOH)
    ```

    ### Example 3: Nitration of Chlorobenzene
    ```
    Chlorobenzene (-Cl, o/p directing, deactivating)
    + HNO₃/H₂SO₄
    →
    Major products: o-Nitrochlorobenzene + p-Nitrochlorobenzene
    (ortho and para to -Cl, but reaction is slower than benzene)
    ```

    ---

    ## 10. Blocking Positions

    ### Strategy for Selective Substitution
    Sometimes we need to "block" certain positions to control orientation.

    **Example: Synthesis of m-Bromonitrobenzene**

    **Wrong approach:**
    ```
    Benzene → Nitration → Nitrobenzene → Bromination → m-Bromonitrobenzene (✓)
    (NO₂ directs meta)
    ```

    **Right approach:**
    ```
    Benzene → Bromination → Bromobenzene → Nitration → o/p-Bromonitrobenzene (✗)
    (Br directs ortho/para, not meta!)
    ```

    **To get meta product:** Introduce meta-director FIRST.

    ---

    ## Important Points for IIT JEE

    1. **Memorize directors:**
       - o/p activating: -OH, -OR, -NH₂, -NHR, -CH₃
       - o/p deactivating: -F, -Cl, -Br, -I
       - m deactivating: -NO₂, -CHO, -COOH, -CN, -SO₃H

    2. **Orientation explanation:**
       - o/p directors stabilize σ-complex at o/p via +M or +I
       - m directors destabilize o/p more than meta via -M or -I

    3. **Halogens are special:**
       - o/p directing (due to +M)
       - But deactivating (due to -I > +M)

    4. **Reactivity order:**
       - Activated benzene > Benzene > Deactivated benzene
       - More activating = faster reaction

    5. **Disubstituted benzenes:**
       - More activating group controls orientation
       - Steric effects favor para over ortho

    ---

    ## Practice Questions

    1. Predict the major product of nitration of anisole (methoxybenzene).
    2. Why is chlorobenzene less reactive than benzene in EAS?
    3. Arrange in order of reactivity toward EAS: benzene, toluene, nitrobenzene.
    4. Explain why halogens are o/p directors but deactivating.
    5. How would you synthesize m-nitrochlorobenzene from benzene?

## Key Points

- Ortho/Para directing groups

- Meta directing groups

- Activating vs deactivating groups
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Ortho/Para directing groups', 'Meta directing groups', 'Activating vs deactivating groups', 'Explanation using resonance and inductive effects', 'Orientation in disubstituted benzenes'],
  prerequisite_ids: []
)

# === MICROLESSON 7: What is the resonance energy of benzene in kJ/mol? ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the resonance energy of benzene in kJ/mol?',
  content: <<~MARKDOWN,
# What is the resonance energy of benzene in kJ/mol? 🚀

Benzene has a resonance energy of approximately 150 kJ/mol (or 36 kcal/mol). This represents the extra stability gained from π electron delocalization.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the resonance energy of benzene in kJ/mol?',
    answer: '150',
    explanation: 'Benzene has a resonance energy of approximately 150 kJ/mol (or 36 kcal/mol). This represents the extra stability gained from π electron delocalization.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: Which of the following criteria must be satisfied for a compound to be aromatic? ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following criteria must be satisfied for a compound to be aromatic?',
  content: <<~MARKDOWN,
# Which of the following criteria must be satisfied for a compound to be aromatic? 🚀

For aromaticity: (1) Cyclic ✓ (2) Planar ✓ (3) Conjugated ✓ (4) (4n+2) π electrons, not 4n. The 4n rule gives antiaromatic compounds.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following criteria must be satisfied for a compound to be aromatic?',
    options: ['Cyclic structure', 'Planar geometry', 'Complete conjugation', '4n π electrons where n is an integer'],
    correct_answer: 2,
    explanation: 'For aromaticity: (1) Cyclic ✓ (2) Planar ✓ (3) Conjugated ✓ (4) (4n+2) π electrons, not 4n. The 4n rule gives antiaromatic compounds.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: According to Huckel\ ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'According to Huckel\',
  content: <<~MARKDOWN,
# According to Huckel\ 🚀

Aromatic compounds have (4n+2) π electrons where n=0,1,2,3... → 2,6,10,14,18... For n=1: 4(1)+2=6. The values 4, 8, 12 are 4n (antiaromatic).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'According to Huckel\',
    options: ['4', '6', '8', '12'],
    correct_answer: 1,
    explanation: 'Aromatic compounds have (4n+2) π electrons where n=0,1,2,3... → 2,6,10,14,18... For n=1: 4(1)+2=6. The values 4, 8, 12 are 4n (antiaromatic).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: How many π electrons does naphthalene (two fused benzene rings) have? ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'How many π electrons does naphthalene (two fused benzene rings) have?',
  content: <<~MARKDOWN,
# How many π electrons does naphthalene (two fused benzene rings) have? 🚀

Naphthalene (C₁₀H₈) has 10 π electrons (5 double bonds). This satisfies Huckel\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many π electrons does naphthalene (two fused benzene rings) have?',
    answer: '10',
    explanation: 'Naphthalene (C₁₀H₈) has 10 π electrons (5 double bonds). This satisfies Huckel\',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: Cyclobutadiene (C₄H₄) is classified as: ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cyclobutadiene (C₄H₄) is classified as:',
  content: <<~MARKDOWN,
# Cyclobutadiene (C₄H₄) is classified as: 🚀

Cyclobutadiene has 4 π electrons (4n where n=1), making it ANTIAROMATIC. It is cyclic, planar, and conjugated, but has 4n electrons instead of 4n+2, making it highly unstable.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cyclobutadiene (C₄H₄) is classified as:',
    options: ['Aromatic', 'Antiaromatic', 'Nonaromatic', 'None of the above'],
    correct_answer: 1,
    explanation: 'Cyclobutadiene has 4 π electrons (4n where n=1), making it ANTIAROMATIC. It is cyclic, planar, and conjugated, but has 4n electrons instead of 4n+2, making it highly unstable.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: Why is cyclopentadienyl anion (C₅H₅⁻) exceptionally stable? ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Why is cyclopentadienyl anion (C₅H₅⁻) exceptionally stable?',
  content: <<~MARKDOWN,
# Why is cyclopentadienyl anion (C₅H₅⁻) exceptionally stable? 🚀

C₅H₅⁻ has 6 π electrons (4n+2, n=1), making it AROMATIC and exceptionally stable for a carbanion. The cyclopentadienyl anion is one of the most stable organic anions due to aromaticity.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why is cyclopentadienyl anion (C₅H₅⁻) exceptionally stable?',
    options: ['It has 4 π electrons making it antiaromatic', 'It has 6 π electrons making it aromatic', 'It has resonance with oxygen', 'It is a primary carbanion'],
    correct_answer: 1,
    explanation: 'C₅H₅⁻ has 6 π electrons (4n+2, n=1), making it AROMATIC and exceptionally stable for a carbanion. The cyclopentadienyl anion is one of the most stable organic anions due to aromaticity.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 13: Cyclooctatetraene (C₈H₈) is nonaromatic rather than antiaromatic because: ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cyclooctatetraene (C₈H₈) is nonaromatic rather than antiaromatic because:',
  content: <<~MARKDOWN,
# Cyclooctatetraene (C₈H₈) is nonaromatic rather than antiaromatic because: 🚀

Cyclooctatetraene has 8 π electrons (4n, n=2) which would make it antiaromatic if planar. To avoid this instability, it adopts a non-planar tub conformation, making it nonaromatic instead.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Cyclooctatetraene (C₈H₈) is nonaromatic rather than antiaromatic because:',
    options: ['It has 6 π electrons', 'It adopts a non-planar tub shape', 'It lacks conjugation', 'It is not cyclic'],
    correct_answer: 1,
    explanation: 'Cyclooctatetraene has 8 π electrons (4n, n=2) which would make it antiaromatic if planar. To avoid this instability, it adopts a non-planar tub conformation, making it nonaromatic instead.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 14: How many π electrons does pyrrole (C₄H₅N) contain in its aromatic system? ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'How many π electrons does pyrrole (C₄H₅N) contain in its aromatic system?',
  content: <<~MARKDOWN,
# How many π electrons does pyrrole (C₄H₅N) contain in its aromatic system? 🚀

Pyrrole has 6 π electrons: 4 from the two C=C double bonds + 2 from the nitrogen lone pair (which is in a p orbital and part of the π system). This makes pyrrole aromatic.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many π electrons does pyrrole (C₄H₅N) contain in its aromatic system?',
    answer: '6',
    explanation: 'Pyrrole has 6 π electrons: 4 from the two C=C double bonds + 2 from the nitrogen lone pair (which is in a p orbital and part of the π system). This makes pyrrole aromatic.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: In pyridine (C₅H₅N), the nitrogen lone pair is: ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'In pyridine (C₅H₅N), the nitrogen lone pair is:',
  content: <<~MARKDOWN,
# In pyridine (C₅H₅N), the nitrogen lone pair is: 🚀

In pyridine, the N lone pair is in an sp² orbital in the plane of the ring (NOT part of the π system). The π system has 6 electrons from the ring. This makes pyridine basic (lone pair available).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In pyridine (C₅H₅N), the nitrogen lone pair is:',
    options: ['Part of the aromatic π system', 'In an sp² orbital perpendicular to the ring', 'Delocalized over all six atoms', 'Not present'],
    correct_answer: 1,
    explanation: 'In pyridine, the N lone pair is in an sp² orbital in the plane of the ring (NOT part of the π system). The π system has 6 electrons from the ring. This makes pyridine basic (lone pair available).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: Antiaromatic compounds are less stable than their corresponding nonaromatic compounds. ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Antiaromatic compounds are less stable than their corresponding nonaromatic compounds.',
  content: <<~MARKDOWN,
# Antiaromatic compounds are less stable than their corresponding nonaromatic compounds. 🚀

TRUE. Stability order: Aromatic > Nonaromatic > Antiaromatic. Antiaromatic compounds (4n π electrons in cyclic, planar, conjugated systems) are destabilized and less stable than nonaromatic compounds.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Antiaromatic compounds are less stable than their corresponding nonaromatic compounds.',
    answer: '',
    explanation: 'TRUE. Stability order: Aromatic > Nonaromatic > Antiaromatic. Antiaromatic compounds (4n π electrons in cyclic, planar, conjugated systems) are destabilized and less stable than nonaromatic compounds.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: Why does benzene undergo substitution reactions rather than addition reactions? ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Why does benzene undergo substitution reactions rather than addition reactions?',
  content: <<~MARKDOWN,
# Why does benzene undergo substitution reactions rather than addition reactions? 🚀

Benzene undergoes substitution to maintain its aromatic stability (150 kJ/mol resonance energy). Addition would destroy aromaticity, which is energetically unfavorable.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 17.2: MCQ
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why does benzene undergo substitution reactions rather than addition reactions?',
    options: ['Benzene has no double bonds', 'Addition reactions would destroy the aromatic stability', 'Benzene is too unreactive for addition', 'Substitution is faster than addition'],
    correct_answer: 1,
    explanation: 'Benzene undergoes substitution to maintain its aromatic stability (150 kJ/mol resonance energy). Addition would destroy aromaticity, which is energetically unfavorable.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 18: What is the electrophile in the nitration of benzene? ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the electrophile in the nitration of benzene?',
  content: <<~MARKDOWN,
# What is the electrophile in the nitration of benzene? 🚀

The electrophile in nitration is NO₂⁺ (nitronium ion), generated from HNO₃ and H₂SO₄. The reaction is: HNO₃ + 2H₂SO₄ → NO₂⁺ + H₃O⁺ + 2HSO₄⁻.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 18.2: MCQ
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the electrophile in the nitration of benzene?',
    options: ['HNO₃', 'NO₂⁺ (nitronium ion)', 'H₂SO₄', 'NO₃⁻'],
    correct_answer: 1,
    explanation: 'The electrophile in nitration is NO₂⁺ (nitronium ion), generated from HNO₃ and H₂SO₄. The reaction is: HNO₃ + 2H₂SO₄ → NO₂⁺ + H₃O⁺ + 2HSO₄⁻.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 19: Which step is the rate-determining step in electrophilic aromatic substitution? ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which step is the rate-determining step in electrophilic aromatic substitution?',
  content: <<~MARKDOWN,
# Which step is the rate-determining step in electrophilic aromatic substitution? 🚀

The rate-determining step is the formation of the σ-complex (arenium ion) where the electrophile attacks benzene. This step is slow because it temporarily destroys aromaticity.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 19.2: MCQ
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which step is the rate-determining step in electrophilic aromatic substitution?',
    options: ['Formation of the electrophile', 'Formation of the σ-complex (arenium ion)', 'Deprotonation of the σ-complex', 'Regeneration of the catalyst'],
    correct_answer: 1,
    explanation: 'The rate-determining step is the formation of the σ-complex (arenium ion) where the electrophile attacks benzene. This step is slow because it temporarily destroys aromaticity.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 20: Which of the following are limitations of Friedel-Crafts alkylation? ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following are limitations of Friedel-Crafts alkylation?',
  content: <<~MARKDOWN,
# Which of the following are limitations of Friedel-Crafts alkylation? 🚀

Friedel-Crafts alkylation has three major limitations: (1) Polyalkylation - product is more reactive (2) Carbocation rearrangement (3) Does not work on deactivated rings (NO₂, COOH, etc.).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 20.2: MCQ
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are limitations of Friedel-Crafts alkylation?',
    options: ['Polyalkylation occurs', 'Carbocation rearrangement can occur', 'Does not work on deactivated rings', 'Requires high temperatures'],
    correct_answer: 2,
    explanation: 'Friedel-Crafts alkylation has three major limitations: (1) Polyalkylation - product is more reactive (2) Carbocation rearrangement (3) Does not work on deactivated rings (NO₂, COOH, etc.).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 21: When n-propyl chloride reacts with benzene in the presence of AlCl₃, what is the major product? ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'When n-propyl chloride reacts with benzene in the presence of AlCl₃, what is the major product?',
  content: <<~MARKDOWN,
# When n-propyl chloride reacts with benzene in the presence of AlCl₃, what is the major product? 🚀

The n-propyl carbocation (1°) rearranges to the more stable isopropyl carbocation (2°) via hydride shift. Therefore, isopropylbenzene is the major product, not n-propylbenzene.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 21.2: MCQ
Exercise.create!(
  micro_lesson: lesson_21,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'When n-propyl chloride reacts with benzene in the presence of AlCl₃, what is the major product?',
    options: ['n-Propylbenzene', 'Isopropylbenzene', 'Benzyl chloride', 'Cyclopropylbenzene'],
    correct_answer: 1,
    explanation: 'The n-propyl carbocation (1°) rearranges to the more stable isopropyl carbocation (2°) via hydride shift. Therefore, isopropylbenzene is the major product, not n-propylbenzene.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 22: Why is Friedel-Crafts acylation preferred over alkylation for introducing alkyl groups? ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'Why is Friedel-Crafts acylation preferred over alkylation for introducing alkyl groups?',
  content: <<~MARKDOWN,
# Why is Friedel-Crafts acylation preferred over alkylation for introducing alkyl groups? 🚀

Friedel-Crafts acylation is preferred because: (1) Acylium ion is resonance stabilized (no rearrangement) (2) Ketone product is deactivated (no polyacylation). The ketone can then be reduced to give the alkyl group.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 22.2: MCQ
Exercise.create!(
  micro_lesson: lesson_22,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why is Friedel-Crafts acylation preferred over alkylation for introducing alkyl groups?',
    options: ['Acylation is faster', 'Acylation has no polysubstitution or rearrangement problems', 'Acylation requires milder conditions', 'Acylation gives higher yields'],
    correct_answer: 1,
    explanation: 'Friedel-Crafts acylation is preferred because: (1) Acylium ion is resonance stabilized (no rearrangement) (2) Ketone product is deactivated (no polyacylation). The ketone can then be reduced to give the alkyl group.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 23: Which catalyst is commonly used for halogenation of benzene? ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which catalyst is commonly used for halogenation of benzene?',
  content: <<~MARKDOWN,
# Which catalyst is commonly used for halogenation of benzene? 🚀

Halogenation of benzene requires a Lewis acid catalyst like FeBr₃, FeCl₃, AlBr₃, or AlCl₃. These generate the electrophilic X⁺ from X₂.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 23.2: MCQ
Exercise.create!(
  micro_lesson: lesson_23,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which catalyst is commonly used for halogenation of benzene?',
    options: ['H₂SO₄', 'FeBr₃ or AlCl₃', 'NaOH', 'Pt/C'],
    correct_answer: 1,
    explanation: 'Halogenation of benzene requires a Lewis acid catalyst like FeBr₃, FeCl₃, AlBr₃, or AlCl₃. These generate the electrophilic X⁺ from X₂.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 24: Friedel-Crafts reactions work efficiently on nitrobenzene. ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'Friedel-Crafts reactions work efficiently on nitrobenzene.',
  content: <<~MARKDOWN,
# Friedel-Crafts reactions work efficiently on nitrobenzene. 🚀

FALSE. Friedel-Crafts reactions (both alkylation and acylation) do NOT work on deactivated rings. Nitrobenzene is strongly deactivated by the -NO₂ group, which is a strong electron-withdrawing group.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 24.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_24,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Friedel-Crafts reactions work efficiently on nitrobenzene.',
    answer: '',
    explanation: 'FALSE. Friedel-Crafts reactions (both alkylation and acylation) do NOT work on deactivated rings. Nitrobenzene is strongly deactivated by the -NO₂ group, which is a strong electron-withdrawing group.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 25: Sulfonation of benzene is unique among EAS reactions because it is: ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'Sulfonation of benzene is unique among EAS reactions because it is:',
  content: <<~MARKDOWN,
# Sulfonation of benzene is unique among EAS reactions because it is: 🚀

Sulfonation is the only EAS reaction that is REVERSIBLE. The -SO₃H group can be removed by heating with dilute H₂SO₄, making it useful for temporary blocking of positions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 25.2: MCQ
Exercise.create!(
  micro_lesson: lesson_25,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Sulfonation of benzene is unique among EAS reactions because it is:',
    options: ['Irreversible', 'Reversible', 'Does not require a catalyst', 'Forms two products'],
    correct_answer: 1,
    explanation: 'Sulfonation is the only EAS reaction that is REVERSIBLE. The -SO₃H group can be removed by heating with dilute H₂SO₄, making it useful for temporary blocking of positions.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 26: Which of the following substituents are ortho/para directors? ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following substituents are ortho/para directors?',
  content: <<~MARKDOWN,
# Which of the following substituents are ortho/para directors? 🚀

Ortho/para directors include: -OH, -OR, -NH₂, -NHR, -CH₃ (activating) and halogens -F, -Cl, -Br, -I (deactivating). -NO₂ is a meta director.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 26.2: MCQ
Exercise.create!(
  micro_lesson: lesson_26,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following substituents are ortho/para directors?',
    options: ['-OH (hydroxyl)', '-NO₂ (nitro)', '-CH₃ (methyl)', '-Cl (chloro)'],
    correct_answer: 3,
    explanation: 'Ortho/para directors include: -OH, -OR, -NH₂, -NHR, -CH₃ (activating) and halogens -F, -Cl, -Br, -I (deactivating). -NO₂ is a meta director.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 27: Which group is a meta director and strongly deactivating? ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which group is a meta director and strongly deactivating?',
  content: <<~MARKDOWN,
# Which group is a meta director and strongly deactivating? 🚀

-NO₂ (nitro) is a strong meta director and strongly deactivating group due to its strong -M and -I effects. It makes the benzene ring much less reactive than benzene.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 27.2: MCQ
Exercise.create!(
  micro_lesson: lesson_27,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which group is a meta director and strongly deactivating?',
    options: ['-CH₃', '-OH', '-NO₂', '-Cl'],
    correct_answer: 2,
    explanation: '-NO₂ (nitro) is a strong meta director and strongly deactivating group due to its strong -M and -I effects. It makes the benzene ring much less reactive than benzene.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 28: Arrange the following compounds in order of INCREASING reactivity toward electrophilic aromatic substitution: (1) Benzene (2) Toluene (3) Nitrobenzene ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'Arrange the following compounds in order of INCREASING reactivity toward electrophilic aromatic substitution: (1) Benzene (2) Toluene (3) Nitrobenzene',
  content: <<~MARKDOWN,
# Arrange the following compounds in order of INCREASING reactivity toward electrophilic aromatic substitution: (1) Benzene (2) Toluene (3) Nitrobenzene 🚀

Nitrobenzene (least reactive, deactivated by -NO₂) < Benzene (reference) < Toluene (most reactive, activated by -CH₃). -CH₃ is activating, -NO₂ is strongly deactivating.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 28.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_28,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following compounds in order of INCREASING reactivity toward electrophilic aromatic substitution: (1) Benzene (2) Toluene (3) Nitrobenzene',
    answer: '',
    explanation: 'Nitrobenzene (least reactive, deactivated by -NO₂) < Benzene (reference) < Toluene (most reactive, activated by -CH₃). -CH₃ is activating, -NO₂ is strongly deactivating.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 29: Why are halogens (F, Cl, Br, I) ortho/para directors but deactivating? ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'Why are halogens (F, Cl, Br, I) ortho/para directors but deactivating?',
  content: <<~MARKDOWN,
# Why are halogens (F, Cl, Br, I) ortho/para directors but deactivating? 🚀

Halogens show both -I effect (electron-withdrawing through σ bonds) and +M effect (lone pair donation). +M effect stabilizes o/p positions (orientation), but -I > +M overall, making them deactivating (reactivity).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 29.2: MCQ
Exercise.create!(
  micro_lesson: lesson_29,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why are halogens (F, Cl, Br, I) ortho/para directors but deactivating?',
    options: ['They have only +M effect', '+M effect controls orientation, but -I effect dominates reactivity', 'They have only -I effect', 'They are actually meta directors'],
    correct_answer: 1,
    explanation: 'Halogens show both -I effect (electron-withdrawing through σ bonds) and +M effect (lone pair donation). +M effect stabilizes o/p positions (orientation), but -I > +M overall, making them deactivating (reactivity).',
    difficulty: 'hard'
  }
)

# === MICROLESSON 30: What is the major product when toluene undergoes nitration? ===
lesson_30 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is the major product when toluene undergoes nitration?',
  content: <<~MARKDOWN,
# What is the major product when toluene undergoes nitration? 🚀

Toluene has -CH₃ group which is an ortho/para director and activating. Nitration gives a mixture of o-nitrotoluene and p-nitrotoluene (with para usually predominating due to less steric hindrance).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 30,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 30.2: MCQ
Exercise.create!(
  micro_lesson: lesson_30,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the major product when toluene undergoes nitration?',
    options: ['Only m-Nitrotoluene', 'Only o-Nitrotoluene', 'Mixture of o-Nitrotoluene and p-Nitrotoluene', 'Only p-Nitrotoluene'],
    correct_answer: 2,
    explanation: 'Toluene has -CH₃ group which is an ortho/para director and activating. Nitration gives a mixture of o-nitrotoluene and p-nitrotoluene (with para usually predominating due to less steric hindrance).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 31: Why does the -NH₂ group direct electrophiles to ortho and para positions? ===
lesson_31 = MicroLesson.create!(
  course_module: module_var,
  title: 'Why does the -NH₂ group direct electrophiles to ortho and para positions?',
  content: <<~MARKDOWN,
# Why does the -NH₂ group direct electrophiles to ortho and para positions? 🚀

-NH₂ has a lone pair that can donate into the ring (+M effect). At o/p positions, resonance structures place positive charge on N, which stabilizes the σ-complex. This is not possible for meta attack.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 31,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 31.2: MCQ
Exercise.create!(
  micro_lesson: lesson_31,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why does the -NH₂ group direct electrophiles to ortho and para positions?',
    options: ['It withdraws electrons from these positions', 'It stabilizes the σ-complex at o/p positions through resonance', 'It is sterically hindered at meta position', 'It has strong -I effect'],
    correct_answer: 1,
    explanation: '-NH₂ has a lone pair that can donate into the ring (+M effect). At o/p positions, resonance structures place positive charge on N, which stabilizes the σ-complex. This is not possible for meta attack.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 32: When nitrobenzene undergoes bromination, what is the major product? ===
lesson_32 = MicroLesson.create!(
  course_module: module_var,
  title: 'When nitrobenzene undergoes bromination, what is the major product?',
  content: <<~MARKDOWN,
# When nitrobenzene undergoes bromination, what is the major product? 🚀

Nitrobenzene has -NO₂ group which is a strong meta director. Bromination gives m-bromonitrobenzene as the major product. The reaction is also very slow because -NO₂ is strongly deactivating.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 32,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 32.2: MCQ
Exercise.create!(
  micro_lesson: lesson_32,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'When nitrobenzene undergoes bromination, what is the major product?',
    options: ['o-Bromonitrobenzene', 'm-Bromonitrobenzene', 'p-Bromonitrobenzene', 'Mixture of o- and p-bromonitrobenzene'],
    correct_answer: 1,
    explanation: 'Nitrobenzene has -NO₂ group which is a strong meta director. Bromination gives m-bromonitrobenzene as the major product. The reaction is also very slow because -NO₂ is strongly deactivating.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 33: In a disubstituted benzene with one activating and one deactivating group, which group controls the orientation? ===
lesson_33 = MicroLesson.create!(
  course_module: module_var,
  title: 'In a disubstituted benzene with one activating and one deactivating group, which group controls the orientation?',
  content: <<~MARKDOWN,
# In a disubstituted benzene with one activating and one deactivating group, which group controls the orientation? 🚀

When an activating and deactivating group compete, the MORE ACTIVATING group controls the orientation. The more activated positions react faster and determine where the new substituent goes.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 33,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 33.2: MCQ
Exercise.create!(
  micro_lesson: lesson_33,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In a disubstituted benzene with one activating and one deactivating group, which group controls the orientation?',
    options: ['The deactivating group', 'The activating group', 'Both equally', 'The larger group'],
    correct_answer: 1,
    explanation: 'When an activating and deactivating group compete, the MORE ACTIVATING group controls the orientation. The more activated positions react faster and determine where the new substituent goes.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 34: Which of the following is the MOST activating group? ===
lesson_34 = MicroLesson.create!(
  course_module: module_var,
  title: 'Which of the following is the MOST activating group?',
  content: <<~MARKDOWN,
# Which of the following is the MOST activating group? 🚀

Order of activation: -O⁻ > -NH₂ > -OH > -OR > -NHCOCH₃ > -CH₃ > -H (benzene) > halogens > deactivating groups. Among the options, -OH is the most activating due to strong +M effect.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 34,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 34.2: MCQ
Exercise.create!(
  micro_lesson: lesson_34,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following is the MOST activating group?',
    options: ['-CH₃', '-OH', '-Cl', '-COOH'],
    correct_answer: 1,
    explanation: 'Order of activation: -O⁻ > -NH₂ > -OH > -OR > -NHCOCH₃ > -CH₃ > -H (benzene) > halogens > deactivating groups. Among the options, -OH is the most activating due to strong +M effect.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 35: Introduction to Aromaticity - Benzene Structure and Huckel\ ===
lesson_35 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Aromaticity - Benzene Structure and Huckel\',
  content: <<~MARKDOWN,
# Introduction to Aromaticity - Benzene Structure and Huckel\ 🚀

# Introduction to Aromaticity

    ## 1. Discovery and Structure of Benzene

    ### Historical Context
    - **Molecular formula:** C₆H₆
    - **Discovered by:** Michael Faraday (1825)
    - **Structure proposed by:** Friedrich August Kekulé (1865)

    ### Kekulé Structure
    ```
    Two possible structures (resonance):

         ⬡                ⬡
        / \\              /  \\
       /   \\            //   \\
      |     |     ⟷    |     |
       \   /             \\   /
        \\_//              \\ //
         ⬡                ⬡

    Alternating single and double bonds
    ```

    ### Problems with Kekulé Structure
    1. **Should show reactivity of alkenes** → But benzene is very stable
    2. **Should have two different C-C bond lengths** → But all are equal (139 pm)
    3. **Heat of hydrogenation** should be 3× cyclohexene → But it's much less

    ---

    ## 2. Modern Structure of Benzene

    ### Resonance Model
    - **All C-C bonds are equivalent** (139 pm)
    - **Bond order:** 1.5 (between single and double)
    - **Hybrid structure:** Resonance between two Kekulé structures
    - **π electrons delocalized** over all six carbons

    ### Orbital Picture
    - **All carbons:** sp² hybridized
    - **Bond angles:** 120° (hexagonal, planar)
    - **π system:** 6 p orbitals overlap to form continuous π cloud above and below the ring

    ```
    Side view of benzene:

         π electron cloud (above)
         ___________________
        |                   |
    C — C — C — C — C — C (σ framework)
        |___________________|
         π electron cloud (below)

    6 π electrons delocalized
    ```

    ### Resonance Energy
    - **Definition:** Extra stability due to delocalization
    - **Benzene resonance energy:** 150 kJ/mol (36 kcal/mol)
    - **Meaning:** Benzene is 150 kJ/mol more stable than predicted for localized structure

    **Evidence from hydrogenation:**
    ```
    Cyclohexene + H₂ → Cyclohexane         ΔH = -120 kJ/mol

    Predicted for benzene (3 double bonds):
    3 × (-120) = -360 kJ/mol

    Actual for benzene:
    Benzene + 3H₂ → Cyclohexane            ΔH = -210 kJ/mol

    Difference = 360 - 210 = 150 kJ/mol
    (This is the resonance energy/stabilization)
    ```

    ---

    ## 3. Aromaticity - Definition and Criteria

    ### What is Aromaticity?
    **Aromaticity** is the special stability exhibited by cyclic, planar compounds with delocalized π electrons following Huckel's rule.

    ### Criteria for Aromaticity (Must satisfy ALL)

    #### 1. Cyclic Structure
    - Molecule must form a ring
    - Acyclic systems cannot be aromatic

    #### 2. Planar Geometry
    - All atoms in the ring must be in the same plane
    - Allows p orbital overlap for π delocalization
    - Non-planar rings cannot have effective π overlap

    #### 3. Complete Conjugation
    - Every atom in the ring has a p orbital
    - Continuous overlap of p orbitals around the ring
    - Typically sp² or sp hybridized atoms

    #### 4. Huckel's Rule: (4n + 2) π electrons
    - **n** is a non-negative integer (0, 1, 2, 3, ...)
    - **Aromatic:** 2, 6, 10, 14, 18, ... π electrons
    - **Antiaromatic:** 4n π electrons (4, 8, 12, ...)

    ---

    ## 4. Huckel's Rule Explained

    ### The (4n + 2) Rule

    **Aromatic compounds have (4n + 2) π electrons where n = 0, 1, 2, 3, ...**

    | n | 4n + 2 | π electrons | Example |
    |---|--------|-------------|---------|
    | 0 | 2 | 2 | Cyclopropenyl cation |
    | 1 | 6 | 6 | Benzene, pyridine |
    | 2 | 10 | 10 | Naphthalene, azulene |
    | 3 | 14 | 14 | Anthracene |
    | 4 | 18 | 18 | [18]Annulene |

    ### Quantum Mechanical Origin
    - Based on **molecular orbital theory**
    - (4n + 2) π electrons fill all bonding and non-bonding MOs
    - Results in **closed-shell configuration** (extra stable)

    ---

    ## 5. Types of Compounds

    ### A. Aromatic Compounds
    - **Satisfy all criteria** including (4n+2) π electrons
    - **Exceptionally stable** (low reactivity)
    - **Undergo substitution** rather than addition reactions
    - **Examples:** Benzene, naphthalene, pyridine, furan

    ### B. Antiaromatic Compounds
    - Cyclic, planar, conjugated
    - Have **4n π electrons** (n = 1, 2, 3, ...)
    - **Highly unstable** (more reactive than expected)
    - **Avoid planarity** if possible (to reduce instability)
    - **Examples:** Cyclobutadiene, cyclooctatetraene (if planar)

    ### C. Nonaromatic Compounds
    - Do NOT meet one or more criteria
    - **Not cyclic**, OR
    - **Not planar**, OR
    - **Not conjugated**
    - **Normal stability** (neither extra stable nor unstable)
    - **Examples:** Cyclohexene, cyclohexane, cyclooctatetraene (tub-shaped)

    ---

    ## 6. Examples and Analysis

    ### Aromatic Examples

    #### Benzene (C₆H₆)
    ```
    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated (6 p orbitals)
    ✓ 6 π electrons (4n+2, n=1)
    → AROMATIC
    ```

    #### Naphthalene (C₁₀H₈)
    ```
    ⬡⬡  (Two fused benzene rings)

    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated
    ✓ 10 π electrons (4n+2, n=2)
    → AROMATIC
    ```

    #### Cyclopropenyl Cation (C₃H₃⁺)
    ```
         +
        /⌃\\
       /    \\

    ✓ Cyclic
    ✓ Planar
    ✓ Conjugated (3 p orbitals)
    ✓ 2 π electrons (4n+2, n=0)
    → AROMATIC
    ```

    ### Antiaromatic Example

    #### Cyclobutadiene (C₄H₄)
    ```
      ⬡
     /  \\
    |    |
     \\  /
      ⬡

    ✓ Cyclic
    ✓ Planar (if forced)
    ✓ Conjugated
    ✗ 4 π electrons (4n, n=1)
    → ANTIAROMATIC (highly unstable)
    ```

    ### Nonaromatic Examples

    #### Cyclohexene
    ```
       ⬡
      /  \\
     /    \\
    |      | (one double bond)
     \\    /
      \\  /

    ✓ Cyclic
    ✓ Planar (roughly)
    ✗ NOT fully conjugated (one sp³ carbon)
    → NONAROMATIC
    ```

    #### Cyclooctatetraene (C₈H₈) - Actual Structure
    ```
    ✓ Cyclic
    ✗ NOT planar (adopts tub shape to avoid antiaromaticity)
    ✓ Would be conjugated if planar
    ✗ 8 π electrons (4n, n=2) → would be antiaromatic if planar

    → NONAROMATIC (avoids antiaromaticity by being non-planar)
    ```

    ---

    ## 7. Aromatic Ions

    ### Cyclopropenyl Cation (C₃H₃⁺)
    - **2 π electrons** (4n+2, n=0)
    - **Aromatic** and very stable for a cation
    - pKa of precursor ~1 (very acidic)

    ### Cyclopropenyl Anion (C₃H₃⁻)
    - **4 π electrons** (4n, n=1)
    - **Antiaromatic** and very unstable

    ### Cyclopentadienyl Anion (C₅H₅⁻)
    ```
        ⊖
       /⌂\\
      /    \\
     |      |
      \\    /
       \\__/

    6 π electrons (4n+2, n=1)
    → AROMATIC (very stable anion)
    pKa of cyclopentadiene ≈ 16 (very acidic for hydrocarbon)
    ```

    ### Cyclopentadienyl Cation (C₅H₅⁺)
    - **4 π electrons** (4n, n=1)
    - **Antiaromatic** and very unstable

    ### Cycloheptatrienyl Cation (Tropylium, C₇H₇⁺)
    ```
         ⊕
        /⌃\\
       /    \\
      |      |
       \\    /
        \\__/

    6 π electrons (4n+2, n=1)
    → AROMATIC (stable cation)
    ```

    **Summary:**
    - **Cyclopentadienyl anion:** Aromatic (6 π e⁻)
    - **Tropylium cation:** Aromatic (6 π e⁻)
    - Both are exceptionally stable for ions

    ---

    ## 8. Aromatic Heterocycles

    ### Pyridine (C₅H₅N)
    ```
         N
        /⌂\\
       /    \\
      |      |
       \\    /
        \\__/

    - Nitrogen has one lone pair in sp² orbital (NOT in π system)
    - 6 π electrons from 5 carbons + 1 from N
    - Aromatic
    ```

    ### Pyrrole (C₄H₅N)
    ```
         N-H
        /⌂\\
       /    \\
      |      |
       \\____/

    - Nitrogen lone pair IN π system
    - 6 π electrons (4 from C=C + 2 from N)
    - Aromatic
    - Less basic than pyridine (lone pair delocalized)
    ```

    ### Furan (C₄H₄O)
    ```
         O
        /⌂\\
       /    \\
      |      |
       \\____/

    - Oxygen has one lone pair in π system
    - 6 π electrons (4 from C=C + 2 from O)
    - Aromatic
    ```

    ### Comparison

    | Compound | Heteroatom | Lone pair position | π electrons | Aromatic? |
    |----------|------------|-------------------|-------------|-----------|
    | Benzene | None | — | 6 | Yes |
    | Pyridine | N | sp² (not in π) | 6 | Yes |
    | Pyrrole | N | p (in π) | 6 | Yes |
    | Furan | O | p (in π) | 6 | Yes |

    ---

    ## 9. Stability Order

    ### Aromatic > Nonaromatic > Antiaromatic

    **Energy comparison:**
    ```
    Antiaromatic (least stable)
          ↑
          | (highly unstable)
          |
    Nonaromatic (normal stability)
          ↑
          | (resonance stabilization)
          |
    Aromatic (most stable)
    ```

    **Example: C₅H₅ species**
    ```
    C₅H₅⁺ (4π, antiaromatic) < C₅H₅• (5π, nonaromatic) < C₅H₅⁻ (6π, aromatic)
    (least stable)                                         (most stable)
    ```

    ---

    ## Important Points for IIT JEE

    1. **Huckel's rule memorization:**
       - Aromatic: 2, 6, 10, 14, 18 π electrons
       - Antiaromatic: 4, 8, 12, 16 π electrons
       - Must be cyclic, planar, and conjugated

    2. **Counting π electrons:**
       - Double bond = 2 π electrons
       - Lone pair (if in p orbital) = 2 π electrons
       - Empty p orbital = 0 π electrons
       - Check ONLY the cyclic system

    3. **Aromaticity in ions:**
       - C₃H₃⁺, C₅H₅⁻, C₇H₇⁺ are aromatic (6 π e⁻)
       - These ions are surprisingly stable

    4. **Heterocycles:**
       - Pyridine: N lone pair NOT in π system (basic)
       - Pyrrole: N lone pair IN π system (weakly basic)
       - Both are aromatic (6 π electrons)

    5. **Resonance energy:**
       - Measure of extra stability
       - Benzene: 150 kJ/mol
       - Explains why benzene undergoes substitution, not addition

    ---

    ## Practice Questions

    1. Is cyclooctatetraene aromatic, antiaromatic, or nonaromatic? Explain.
    2. Calculate the number of π electrons in furan and determine if it's aromatic.
    3. Why is cyclopentadienyl anion much more stable than typical carbanions?
    4. Draw the structure of naphthalene and verify it follows Huckel's rule.
    5. Compare the basicity of pyridine and pyrrole. Explain the difference.

## Key Points

- Structure of benzene

- Aromaticity and resonance energy

- Huckel\
  MARKDOWN
  sequence_order: 35,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Structure of benzene', 'Aromaticity and resonance energy', 'Huckel\', ',
    ', ',
    '],
  prerequisite_ids: []
)

puts "✓ Created 35 microlessons for Module 07 Aromatic Compounds"

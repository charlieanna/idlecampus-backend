# AUTO-GENERATED from module_09_qualitative_analysis.rb
puts "Creating Microlessons for Qualitative Analysis..."

module_var = CourseModule.find_by(slug: 'qualitative-analysis')

# === MICROLESSON 1: chemical_principles — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_principles — Practice',
  content: <<~MARKDOWN,
# chemical_principles — Practice 🚀

In acidic medium, [H⁺] is high which keeps [S²⁻] low (due to H₂S ⇌ 2H⁺ + S²⁻). This allows only Group II cations with very low Ksp to precipitate, while Group IV remains in solution.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['chemical_principles'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why is H₂S added in acidic medium for Group II precipitation?',
    options: ['To increase solubility of sulfides'],
    correct_answer: 0,
    explanation: 'In acidic medium, [H⁺] is high which keeps [S²⁻] low (due to H₂S ⇌ 2H⁺ + S²⁻). This allows only Group II cations with very low Ksp to precipitate, while Group IV remains in solution.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 2: Cation Group Analysis (Groups 0-VI) ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cation Group Analysis (Groups 0-VI)',
  content: <<~MARKDOWN,
# Cation Group Analysis (Groups 0-VI) 🚀

# Cation Group Analysis - Detailed

    ## Group 0: Ammonium Group

    **Cation**: NH₄⁺

    ### Detection
    **Reagent**: NaOH (heat)
    **Observation**: Ammonia gas evolved (pungent smell, turns red litmus blue)

    **Reaction**: NH₄⁺ + OH⁻ → NH₃↑ + H₂O

    ### Confirmatory Test
    - **Nessler's Reagent** (K₂HgI₄): Brown precipitate
    - NH₃ + 2K₂HgI₄ + 3KOH → NH₂Hg₂I₃↓ (brown) + 7KI + 2H₂O

    ---

    ## Group I: Silver Group

    **Cations**: Pb²⁺, Ag⁺, Hg₂²⁺

    ### Group Reagent
    **Reagent**: Dilute HCl
    **Precipitate**: White chlorides (PbCl₂, AgCl, Hg₂Cl₂)

    ### Reactions
    - Pb²⁺ + 2Cl⁻ → PbCl₂↓ (white, soluble in hot water)
    - Ag⁺ + Cl⁻ → AgCl↓ (white, curdy)
    - Hg₂²⁺ + 2Cl⁻ → Hg₂Cl₂↓ (white)

    ### Separation of Group I
    **Hot water treatment**:
    - PbCl₂ dissolves (soluble in hot water)
    - AgCl, Hg₂Cl₂ remain (filter)

    ### Confirmatory Tests

    #### Lead (Pb²⁺)
    1. **Chromate test**: Add K₂CrO₄ → Yellow precipitate (PbCrO₄)
    2. **Sulfate test**: Add H₂SO₄ → White precipitate (PbSO₄)

    #### Silver (Ag⁺)
    1. **Ammonia test**: AgCl + 2NH₃ → [Ag(NH₃)₂]Cl (soluble complex)
       - Add HNO₃: AgCl reprecipitates
    2. **Chromate test**: Add K₂CrO₄ → Reddish-brown Ag₂CrO₄

    #### Mercury(I) (Hg₂²⁺)
    1. **Ammonia test**: Hg₂Cl₂ + 2NH₃ → Hg + HgNH₂Cl↓ (black)
       - Disproportionation: white turns gray/black
    2. **Stannous chloride**: Hg₂Cl₂ + SnCl₂ → 2Hg (gray) + SnCl₄

    ---

    ## Group II: Copper-Arsenic Group

    **Cations**: Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺/Sn⁴⁺

    ### Group Reagent
    **Reagent**: H₂S in acidic medium (pH 0.5-1)
    **Precipitate**: Colored sulfides

    **Why acidic?** High [H⁺] keeps [S²⁻] low enough to precipitate only low Ksp sulfides

    ### Reactions
    - Hg²⁺ + S²⁻ → HgS (black)
    - Cu²⁺ + S²⁻ → CuS (black/brown)
    - Cd²⁺ + S²⁻ → CdS (yellow)
    - Bi³⁺ + 3S²⁻ → Bi₂S₃ (brown)
    - As³⁺ + 3S²⁻ → As₂S₃ (yellow)
    - Sb³⁺ + 3S²⁻ → Sb₂S₃ (orange)
    - Sn⁴⁺ + 2S²⁻ → SnS₂ (yellow)

    ### Separation: Copper Subgroup vs Arsenic Subgroup

    **Reagent**: (NH₄)₂Sx (yellow ammonium sulfide)

    - **Copper subgroup** (HgS, CuS, CdS, Bi₂S₃): Insoluble (remain as precipitate)
    - **Arsenic subgroup** (As₂S₃, Sb₂S₃, SnS₂): Dissolve as thioanions

    ### Confirmatory Tests (Selected)

    #### Mercury(II) (Hg²⁺)
    - **SnCl₂ test**: HgCl₂ + SnCl₂ → Hg₂Cl₂ (white) → Hg (gray/black)

    #### Copper (Cu²⁺)
    1. **Ammonia test**: Blue solution [Cu(NH₃)₄]²⁺
    2. **Potassium ferrocyanide**: Reddish-brown Cu₂[Fe(CN)₆]
    3. **Flame test**: Blue-green color

    #### Cadmium (Cd²⁺)
    - **Yellow CdS**: Characteristic yellow precipitate with H₂S

    ---

    ## Group III: Aluminum Group

    **Cations**: Fe³⁺, Al³⁺, Cr³⁺

    ### Group Reagent
    **Reagent**: NH₄OH + NH₄Cl (ammoniacal buffer)
    **Precipitate**: Hydroxides

    **Why NH₄Cl?** Suppresses excess OH⁻ to prevent precipitation of Group IV

    ### Reactions
    - Fe³⁺ + 3OH⁻ → Fe(OH)₃↓ (reddish-brown)
    - Al³⁺ + 3OH⁻ → Al(OH)₃↓ (white, gelatinous)
    - Cr³⁺ + 3OH⁻ → Cr(OH)₃↓ (green)

    ### Confirmatory Tests

    #### Iron(III) (Fe³⁺)
    1. **Potassium ferrocyanide**: Deep blue precipitate (Prussian blue)
       - Fe³⁺ + K₄[Fe(CN)₆] → Fe₄[Fe(CN)₆]₃ (blue)
    2. **Thiocyanate test**: Blood-red color
       - Fe³⁺ + SCN⁻ → [Fe(SCN)]²⁺ (red complex)

    #### Aluminum (Al³⁺)
    1. **Amphoteric nature**: Al(OH)₃ dissolves in both acid and base
       - Al(OH)₃ + 3H⁺ → Al³⁺ + 3H₂O
       - Al(OH)₃ + OH⁻ → [Al(OH)₄]⁻ (aluminate)
    2. **Morin test**: Green fluorescence in UV light

    #### Chromium(III) (Cr³⁺)
    1. **Oxidation to chromate**: Add H₂O₂ + NaOH → yellow CrO₄²⁻
    2. **Amphoteric hydroxide**: Dissolves in excess NaOH → [Cr(OH)₄]⁻

    ---

    ## Group IV: Zinc Group

    **Cations**: Co²⁺, Ni²⁺, Zn²⁺, Mn²⁺

    ### Group Reagent
    **Reagent**: H₂S in basic medium (NH₄OH + NH₄Cl)
    **Precipitate**: Sulfides

    ### Reactions
    - Co²⁺ + S²⁻ → CoS (black)
    - Ni²⁺ + S²⁻ → NiS (black)
    - Zn²⁺ + S²⁻ → ZnS (white/dirty white)
    - Mn²⁺ + S²⁻ → MnS (flesh/pink)

    ### Confirmatory Tests

    #### Cobalt (Co²⁺)
    1. **Borax bead test**: Blue bead
    2. **Potassium nitrite**: Yellow precipitate K₃[Co(NO₂)₆]

    #### Nickel (Ni²⁺)
    1. **Dimethylglyoxime (DMG)**: Bright red precipitate
    2. **Ammonia**: Blue complex [Ni(NH₃)₆]²⁺

    #### Zinc (Zn²⁺)
    1. **Amphoteric nature**: ZnS dissolves in acids
    2. **Potassium ferrocyanide**: White precipitate Zn₂[Fe(CN)₆]

    ---

    ## Group V: Calcium Group

    **Cations**: Ba²⁺, Sr²⁺, Ca²⁺

    ### Group Reagent
    **Reagent**: (NH₄)₂CO₃ in presence of NH₄Cl + NH₄OH
    **Precipitate**: White carbonates

    ### Reactions
    - Ba²⁺ + CO₃²⁻ → BaCO₃↓ (white)
    - Sr²⁺ + CO₃²⁻ → SrCO₃↓ (white)
    - Ca²⁺ + CO₃²⁻ → CaCO₃↓ (white)

    ### Confirmatory Tests

    #### Barium (Ba²⁺)
    1. **Flame test**: Apple green
    2. **Chromate test**: Yellow BaCrO₄

    #### Strontium (Sr²⁺)
    1. **Flame test**: Crimson red
    2. **Sulfate test**: White SrSO₄

    #### Calcium (Ca²⁺)
    1. **Flame test**: Brick red
    2. **Oxalate test**: White CaC₂O₄

    ---

    ## Group VI: Magnesium-Alkali Group

    **Cations**: Mg²⁺, Na⁺, K⁺

    ### Detection
    **No group reagent** - these cations remain in solution after all groups are removed

    ### Individual Tests

    #### Magnesium (Mg²⁺)
    1. **Magneson reagent**: Blue precipitate in alkaline solution
    2. **Sodium phosphate**: White crystalline MgNH₄PO₄

    #### Sodium (Na⁺)
    1. **Flame test**: Golden yellow (persistent)
    2. **Potassium pyroantimonate**: White crystalline precipitate

    #### Potassium (K⁺)
    1. **Flame test**: Violet (view through blue glass to mask Na)
    2. **Sodium cobaltinitrite**: Yellow precipitate K₂Na[Co(NO₂)₆]

    ---

    ## Important Notes for IIT JEE

    1. **Complete precipitation**: Always use excess reagent
    2. **Washing precipitates**: Remove soluble salts that interfere
    3. **Interfering ions**:
       - Colored ions (Fe³⁺, Cu²⁺, Ni²⁺) can mask other colors
       - Oxidizing ions (NO₃⁻) interfere with sulfide precipitation
    4. **Confirmatory tests**: At least 2 tests required for certainty
    5. **Common mistakes**:
       - Not acidifying before adding group reagent
       - Using wrong pH for H₂S precipitation
       - Confusing Group II and Group IV sulfides

## Key Points

- Group reagents

- Cation separation

- Confirmatory tests
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Group reagents', 'Cation separation', 'Confirmatory tests', 'Interfering ions'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Introduction to Qualitative Analysis ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Qualitative Analysis',
  content: <<~MARKDOWN,
# Introduction to Qualitative Analysis 🚀

# Qualitative Analysis - Introduction

    ## What is Qualitative Analysis?

    **Definition**: Systematic procedure to identify cations and anions present in a salt or mixture.

    ### Importance in IIT JEE
    - Practical-based questions (5-10 marks)
    - Requires understanding of chemical properties
    - Tests knowledge of group chemistry
    - Often combined with inorganic theory

    ## Types of Analysis

    ### 1. Preliminary Tests (Dry Tests)
    Performed on the solid salt before dissolving:
    - **Physical Examination**: Color, smell, appearance
    - **Flame Test**: Characteristic flame colors
    - **Borax Bead Test**: Colored beads with transition metals
    - **Heating Test**: Sublimation, decomposition products

    ### 2. Wet Tests
    Performed on aqueous solution:
    - **Group Analysis**: Systematic cation separation
    - **Anion Tests**: Individual confirmatory tests
    - **Confirmatory Tests**: Specific reactions for identification

    ## Cation Classification (Group Analysis)

    Cations are classified into 6 groups based on their behavior with group reagents:

    | Group | Cations | Group Reagent | Precipitate |
    |-------|---------|---------------|-------------|
    | **0** | NH₄⁺ | NaOH (heat) | NH₃ gas |
    | **I** | Pb²⁺, Ag⁺, Hg₂²⁺ | Dilute HCl | Chlorides (white) |
    | **II** | Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺ | H₂S (acidic medium) | Sulfides (colored) |
    | **III** | Fe³⁺, Al³⁺, Cr³⁺ | NH₄OH + NH₄Cl | Hydroxides |
    | **IV** | Co²⁺, Ni²⁺, Zn²⁺, Mn²⁺ | H₂S (basic medium) | Sulfides |
    | **V** | Ba²⁺, Sr²⁺, Ca²⁺ | (NH₄)₂CO₃ | Carbonates (white) |
    | **VI** | Mg²⁺, Na⁺, K⁺ | No group reagent | Remain in solution |

    ## Anion Classification

    ### Group A: Anions detected in solid state
    - CO₃²⁻, S²⁻, SO₃²⁻, NO₂⁻ (volatile products on heating with acid)

    ### Group B: Anions that give precipitates
    - Cl⁻, Br⁻, I⁻ (with AgNO₃)
    - SO₄²⁻ (with BaCl₂)
    - NO₃⁻ (brown ring test)

    ### Group C: Anions requiring special tests
    - PO₄³⁻, BO₃³⁻, CrO₄²⁻, MnO₄⁻

    ## Systematic Procedure

    ### Step 1: Preliminary Tests
    1. Physical examination (color, odor)
    2. Flame test
    3. Heating test
    4. Borax bead test (if metal present)

    ### Step 2: Preparation of Solution
    - Dissolve salt in water (if soluble)
    - If insoluble, try dilute HCl, then dilute HNO₃
    - Note any observations during dissolution

    ### Step 3: Anion Detection
    - Perform tests for anion groups A, B, C
    - Use confirmatory tests
    - Note interfering ions

    ### Step 4: Cation Detection
    - Test for Group 0 (NH₄⁺)
    - Add group reagents sequentially (Groups I-VI)
    - Perform confirmatory tests on each precipitate
    - Identify cations in final filtrate (Group VI)

    ## Important Flame Colors

    | Element | Flame Color |
    |---------|-------------|
    | Na | Golden yellow |
    | K | Violet (through blue glass) |
    | Ca | Brick red |
    | Sr | Crimson red |
    | Ba | Apple green |
    | Cu | Blue-green |

    ## Key Points for IIT JEE

    1. **Systematic approach**: Always follow the sequence (Group 0 → VI)
    2. **Interfering ions**: Some ions interfere with tests (e.g., colored ions mask others)
    3. **Group reagent specificity**: Understand why each reagent selectively precipitates
    4. **Confirmatory tests**: Know at least 2 tests for each ion
    5. **Common salt mixtures**: Practice identifying combinations

    ## Practical Tips

    - Always acidify before group precipitation to prevent interference
    - Use excess reagent to ensure complete precipitation
    - Wash precipitates to remove interfering ions
    - Perform blank tests to verify reagent purity
    - Note all color changes, precipitates, and gas evolution

## Key Points

- Salt analysis

- Preliminary tests

- Cation groups
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Salt analysis', 'Preliminary tests', 'Cation groups', 'Anion groups'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Cation Group Analysis (Groups 0-VI) ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Cation Group Analysis (Groups 0-VI)',
  content: <<~MARKDOWN,
# Cation Group Analysis (Groups 0-VI) 🚀

# Cation Group Analysis - Detailed

    ## Group 0: Ammonium Group

    **Cation**: NH₄⁺

    ### Detection
    **Reagent**: NaOH (heat)
    **Observation**: Ammonia gas evolved (pungent smell, turns red litmus blue)

    **Reaction**: NH₄⁺ + OH⁻ → NH₃↑ + H₂O

    ### Confirmatory Test
    - **Nessler's Reagent** (K₂HgI₄): Brown precipitate
    - NH₃ + 2K₂HgI₄ + 3KOH → NH₂Hg₂I₃↓ (brown) + 7KI + 2H₂O

    ---

    ## Group I: Silver Group

    **Cations**: Pb²⁺, Ag⁺, Hg₂²⁺

    ### Group Reagent
    **Reagent**: Dilute HCl
    **Precipitate**: White chlorides (PbCl₂, AgCl, Hg₂Cl₂)

    ### Reactions
    - Pb²⁺ + 2Cl⁻ → PbCl₂↓ (white, soluble in hot water)
    - Ag⁺ + Cl⁻ → AgCl↓ (white, curdy)
    - Hg₂²⁺ + 2Cl⁻ → Hg₂Cl₂↓ (white)

    ### Separation of Group I
    **Hot water treatment**:
    - PbCl₂ dissolves (soluble in hot water)
    - AgCl, Hg₂Cl₂ remain (filter)

    ### Confirmatory Tests

    #### Lead (Pb²⁺)
    1. **Chromate test**: Add K₂CrO₄ → Yellow precipitate (PbCrO₄)
    2. **Sulfate test**: Add H₂SO₄ → White precipitate (PbSO₄)

    #### Silver (Ag⁺)
    1. **Ammonia test**: AgCl + 2NH₃ → [Ag(NH₃)₂]Cl (soluble complex)
       - Add HNO₃: AgCl reprecipitates
    2. **Chromate test**: Add K₂CrO₄ → Reddish-brown Ag₂CrO₄

    #### Mercury(I) (Hg₂²⁺)
    1. **Ammonia test**: Hg₂Cl₂ + 2NH₃ → Hg + HgNH₂Cl↓ (black)
       - Disproportionation: white turns gray/black
    2. **Stannous chloride**: Hg₂Cl₂ + SnCl₂ → 2Hg (gray) + SnCl₄

    ---

    ## Group II: Copper-Arsenic Group

    **Cations**: Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺/Sn⁴⁺

    ### Group Reagent
    **Reagent**: H₂S in acidic medium (pH 0.5-1)
    **Precipitate**: Colored sulfides

    **Why acidic?** High [H⁺] keeps [S²⁻] low enough to precipitate only low Ksp sulfides

    ### Reactions
    - Hg²⁺ + S²⁻ → HgS (black)
    - Cu²⁺ + S²⁻ → CuS (black/brown)
    - Cd²⁺ + S²⁻ → CdS (yellow)
    - Bi³⁺ + 3S²⁻ → Bi₂S₃ (brown)
    - As³⁺ + 3S²⁻ → As₂S₃ (yellow)
    - Sb³⁺ + 3S²⁻ → Sb₂S₃ (orange)
    - Sn⁴⁺ + 2S²⁻ → SnS₂ (yellow)

    ### Separation: Copper Subgroup vs Arsenic Subgroup

    **Reagent**: (NH₄)₂Sx (yellow ammonium sulfide)

    - **Copper subgroup** (HgS, CuS, CdS, Bi₂S₃): Insoluble (remain as precipitate)
    - **Arsenic subgroup** (As₂S₃, Sb₂S₃, SnS₂): Dissolve as thioanions

    ### Confirmatory Tests (Selected)

    #### Mercury(II) (Hg²⁺)
    - **SnCl₂ test**: HgCl₂ + SnCl₂ → Hg₂Cl₂ (white) → Hg (gray/black)

    #### Copper (Cu²⁺)
    1. **Ammonia test**: Blue solution [Cu(NH₃)₄]²⁺
    2. **Potassium ferrocyanide**: Reddish-brown Cu₂[Fe(CN)₆]
    3. **Flame test**: Blue-green color

    #### Cadmium (Cd²⁺)
    - **Yellow CdS**: Characteristic yellow precipitate with H₂S

    ---

    ## Group III: Aluminum Group

    **Cations**: Fe³⁺, Al³⁺, Cr³⁺

    ### Group Reagent
    **Reagent**: NH₄OH + NH₄Cl (ammoniacal buffer)
    **Precipitate**: Hydroxides

    **Why NH₄Cl?** Suppresses excess OH⁻ to prevent precipitation of Group IV

    ### Reactions
    - Fe³⁺ + 3OH⁻ → Fe(OH)₃↓ (reddish-brown)
    - Al³⁺ + 3OH⁻ → Al(OH)₃↓ (white, gelatinous)
    - Cr³⁺ + 3OH⁻ → Cr(OH)₃↓ (green)

    ### Confirmatory Tests

    #### Iron(III) (Fe³⁺)
    1. **Potassium ferrocyanide**: Deep blue precipitate (Prussian blue)
       - Fe³⁺ + K₄[Fe(CN)₆] → Fe₄[Fe(CN)₆]₃ (blue)
    2. **Thiocyanate test**: Blood-red color
       - Fe³⁺ + SCN⁻ → [Fe(SCN)]²⁺ (red complex)

    #### Aluminum (Al³⁺)
    1. **Amphoteric nature**: Al(OH)₃ dissolves in both acid and base
       - Al(OH)₃ + 3H⁺ → Al³⁺ + 3H₂O
       - Al(OH)₃ + OH⁻ → [Al(OH)₄]⁻ (aluminate)
    2. **Morin test**: Green fluorescence in UV light

    #### Chromium(III) (Cr³⁺)
    1. **Oxidation to chromate**: Add H₂O₂ + NaOH → yellow CrO₄²⁻
    2. **Amphoteric hydroxide**: Dissolves in excess NaOH → [Cr(OH)₄]⁻

    ---

    ## Group IV: Zinc Group

    **Cations**: Co²⁺, Ni²⁺, Zn²⁺, Mn²⁺

    ### Group Reagent
    **Reagent**: H₂S in basic medium (NH₄OH + NH₄Cl)
    **Precipitate**: Sulfides

    ### Reactions
    - Co²⁺ + S²⁻ → CoS (black)
    - Ni²⁺ + S²⁻ → NiS (black)
    - Zn²⁺ + S²⁻ → ZnS (white/dirty white)
    - Mn²⁺ + S²⁻ → MnS (flesh/pink)

    ### Confirmatory Tests

    #### Cobalt (Co²⁺)
    1. **Borax bead test**: Blue bead
    2. **Potassium nitrite**: Yellow precipitate K₃[Co(NO₂)₆]

    #### Nickel (Ni²⁺)
    1. **Dimethylglyoxime (DMG)**: Bright red precipitate
    2. **Ammonia**: Blue complex [Ni(NH₃)₆]²⁺

    #### Zinc (Zn²⁺)
    1. **Amphoteric nature**: ZnS dissolves in acids
    2. **Potassium ferrocyanide**: White precipitate Zn₂[Fe(CN)₆]

    ---

    ## Group V: Calcium Group

    **Cations**: Ba²⁺, Sr²⁺, Ca²⁺

    ### Group Reagent
    **Reagent**: (NH₄)₂CO₃ in presence of NH₄Cl + NH₄OH
    **Precipitate**: White carbonates

    ### Reactions
    - Ba²⁺ + CO₃²⁻ → BaCO₃↓ (white)
    - Sr²⁺ + CO₃²⁻ → SrCO₃↓ (white)
    - Ca²⁺ + CO₃²⁻ → CaCO₃↓ (white)

    ### Confirmatory Tests

    #### Barium (Ba²⁺)
    1. **Flame test**: Apple green
    2. **Chromate test**: Yellow BaCrO₄

    #### Strontium (Sr²⁺)
    1. **Flame test**: Crimson red
    2. **Sulfate test**: White SrSO₄

    #### Calcium (Ca²⁺)
    1. **Flame test**: Brick red
    2. **Oxalate test**: White CaC₂O₄

    ---

    ## Group VI: Magnesium-Alkali Group

    **Cations**: Mg²⁺, Na⁺, K⁺

    ### Detection
    **No group reagent** - these cations remain in solution after all groups are removed

    ### Individual Tests

    #### Magnesium (Mg²⁺)
    1. **Magneson reagent**: Blue precipitate in alkaline solution
    2. **Sodium phosphate**: White crystalline MgNH₄PO₄

    #### Sodium (Na⁺)
    1. **Flame test**: Golden yellow (persistent)
    2. **Potassium pyroantimonate**: White crystalline precipitate

    #### Potassium (K⁺)
    1. **Flame test**: Violet (view through blue glass to mask Na)
    2. **Sodium cobaltinitrite**: Yellow precipitate K₂Na[Co(NO₂)₆]

    ---

    ## Important Notes for IIT JEE

    1. **Complete precipitation**: Always use excess reagent
    2. **Washing precipitates**: Remove soluble salts that interfere
    3. **Interfering ions**:
       - Colored ions (Fe³⁺, Cu²⁺, Ni²⁺) can mask other colors
       - Oxidizing ions (NO₃⁻) interfere with sulfide precipitation
    4. **Confirmatory tests**: At least 2 tests required for certainty
    5. **Common mistakes**:
       - Not acidifying before adding group reagent
       - Using wrong pH for H₂S precipitation
       - Confusing Group II and Group IV sulfides

## Key Points

- Group reagents

- Cation separation

- Confirmatory tests
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Group reagents', 'Cation separation', 'Confirmatory tests', 'Interfering ions'],
  prerequisite_ids: []
)

# === MICROLESSON 5: group_reagents — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'group_reagents — Practice',
  content: <<~MARKDOWN,
# group_reagents — Practice 🚀

Dilute HCl is the group reagent for Group I (Ag⁺, Pb²⁺, Hg₂²⁺), which precipitates as chlorides.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['group_reagents'],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which group reagent is used to precipitate Group I cations?',
    options: ['Dilute H₂SO₄', 'Dilute HCl', 'H₂S in acidic medium', 'NH₄OH'],
    correct_answer: 1,
    explanation: 'Dilute HCl is the group reagent for Group I (Ag⁺, Pb²⁺, Hg₂²⁺), which precipitates as chlorides.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: cation_groups — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'cation_groups — Practice',
  content: <<~MARKDOWN,
# cation_groups — Practice 🚀

Group II includes cations precipitated by H₂S in acidic medium: Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺. Zn²⁺ is Group IV, Pb²⁺ is Group I.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['cation_groups'],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which cations belong to Group II (Copper-Arsenic group)?',
    options: ['Cu²⁺', 'Cd²⁺', 'Zn²⁺', 'Pb²⁺'],
    correct_answer: 1,
    explanation: 'Group II includes cations precipitated by H₂S in acidic medium: Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺. Zn²⁺ is Group IV, Pb²⁺ is Group I.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 7: preliminary_tests — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'preliminary_tests — Practice',
  content: <<~MARKDOWN,
# preliminary_tests — Practice 🚀

Sodium (Na) produces a characteristic golden yellow flame color, which is persistent and easy to identify.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['preliminary_tests'],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The flame test for sodium gives a ________ color.',
    answer: 'golden yellow|yellow',
    explanation: 'Sodium (Na) produces a characteristic golden yellow flame color, which is persistent and easy to identify.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: group_separation — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'group_separation — Practice',
  content: <<~MARKDOWN,
# group_separation — Practice 🚀

NH₄Cl acts as a buffer and suppresses excess OH⁻ concentration (common ion effect), preventing premature precipitation of Group IV cations.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['group_separation'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'NH₄Cl is added along with NH₄OH during Group III precipitation to:',
    options: ['Increase pH of solution', 'Prevent precipitation of Group IV', 'Help dissolve Group II sulfides', 'Act as a catalyst'],
    correct_answer: 1,
    explanation: 'NH₄Cl acts as a buffer and suppresses excess OH⁻ concentration (common ion effect), preventing premature precipitation of Group IV cations.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 9: systematic_analysis — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'systematic_analysis — Practice',
  content: <<~MARKDOWN,
# systematic_analysis — Practice 🚀

Systematic analysis follows the sequence: Group 0 → I → II → III → IV → V → VI. This ensures complete separation without interference.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['systematic_analysis'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following steps for systematic cation analysis in correct order:',
    answer: '1,2,3,4',
    explanation: 'Systematic analysis follows the sequence: Group 0 → I → II → III → IV → V → VI. This ensures complete separation without interference.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: confirmatory_tests — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'confirmatory_tests — Practice',
  content: <<~MARKDOWN,
# confirmatory_tests — Practice 🚀

AgCl dissolves in ammonia to form a soluble complex: AgCl + 2NH₃ → [Ag(NH₃)₂]Cl. This is the confirmatory test for Ag⁺.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['confirmatory_tests'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is observed when AgCl is treated with ammonia solution?',
    options: ['Black precipitate forms', 'Precipitate dissolves forming a complex', 'No reaction occurs', 'Yellow precipitate forms'],
    correct_answer: 1,
    explanation: 'AgCl dissolves in ammonia to form a soluble complex: AgCl + 2NH₃ → [Ag(NH₃)₂]Cl. This is the confirmatory test for Ag⁺.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: group_identification — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'group_identification — Practice',
  content: <<~MARKDOWN,
# group_identification — Practice 🚀

Group II sulfides: HgS (black), CuS (black/brown), CdS (yellow), Bi₂S₃ (brown), As₂S₃ (yellow), Sb₂S₃ (orange), SnS₂ (yellow). Pb²⁺ is Group I, not II.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['group_identification'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following give colored sulfide precipitates in Group II?',
    options: ['Cu²⁺ (black/brown CuS)', 'Cd²⁺ (yellow CdS)', 'Pb²⁺ (black PbS)', 'As³⁺ (yellow As₂S₃)'],
    correct_answer: 3,
    explanation: 'Group II sulfides: HgS (black), CuS (black/brown), CdS (yellow), Bi₂S₃ (brown), As₂S₃ (yellow), Sb₂S₃ (orange), SnS₂ (yellow). Pb²⁺ is Group I, not II.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 12: group_reagents — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'group_reagents — Practice',
  content: <<~MARKDOWN,
# group_reagents — Practice 🚀

FALSE. Group IV cations (Zn²⁺, Ni²⁺, Co²⁺, Mn²⁺) are precipitated by H₂S in BASIC medium (NH₄OH + NH₄Cl). Acidic medium is used for Group II.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['group_reagents'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'H₂S precipitates Group IV cations in acidic medium.',
    answer: 'false',
    explanation: 'FALSE. Group IV cations (Zn²⁺, Ni²⁺, Co²⁺, Mn²⁺) are precipitated by H₂S in BASIC medium (NH₄OH + NH₄Cl). Acidic medium is used for Group II.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: confirmatory_tests — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'confirmatory_tests — Practice',
  content: <<~MARKDOWN,
# confirmatory_tests — Practice 🚀

Fe³⁺ reacts with K₄[Fe(CN)₆] to give Prussian blue: Fe³⁺ + K₄[Fe(CN)₆] → Fe₄[Fe(CN)₆]₃ (deep blue precipitate).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['confirmatory_tests'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The confirmatory test for Fe³⁺ using potassium ferrocyanide gives a ________ colored precipitate.',
    answer: 'blue|prussian blue|deep blue',
    explanation: 'Fe³⁺ reacts with K₄[Fe(CN)₆] to give Prussian blue: Fe³⁺ + K₄[Fe(CN)₆] → Fe₄[Fe(CN)₆]₃ (deep blue precipitate).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: Introduction to Qualitative Analysis ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Qualitative Analysis',
  content: <<~MARKDOWN,
# Introduction to Qualitative Analysis 🚀

# Qualitative Analysis - Introduction

    ## What is Qualitative Analysis?

    **Definition**: Systematic procedure to identify cations and anions present in a salt or mixture.

    ### Importance in IIT JEE
    - Practical-based questions (5-10 marks)
    - Requires understanding of chemical properties
    - Tests knowledge of group chemistry
    - Often combined with inorganic theory

    ## Types of Analysis

    ### 1. Preliminary Tests (Dry Tests)
    Performed on the solid salt before dissolving:
    - **Physical Examination**: Color, smell, appearance
    - **Flame Test**: Characteristic flame colors
    - **Borax Bead Test**: Colored beads with transition metals
    - **Heating Test**: Sublimation, decomposition products

    ### 2. Wet Tests
    Performed on aqueous solution:
    - **Group Analysis**: Systematic cation separation
    - **Anion Tests**: Individual confirmatory tests
    - **Confirmatory Tests**: Specific reactions for identification

    ## Cation Classification (Group Analysis)

    Cations are classified into 6 groups based on their behavior with group reagents:

    | Group | Cations | Group Reagent | Precipitate |
    |-------|---------|---------------|-------------|
    | **0** | NH₄⁺ | NaOH (heat) | NH₃ gas |
    | **I** | Pb²⁺, Ag⁺, Hg₂²⁺ | Dilute HCl | Chlorides (white) |
    | **II** | Hg²⁺, Cu²⁺, Cd²⁺, Bi³⁺, As³⁺, Sb³⁺, Sn²⁺ | H₂S (acidic medium) | Sulfides (colored) |
    | **III** | Fe³⁺, Al³⁺, Cr³⁺ | NH₄OH + NH₄Cl | Hydroxides |
    | **IV** | Co²⁺, Ni²⁺, Zn²⁺, Mn²⁺ | H₂S (basic medium) | Sulfides |
    | **V** | Ba²⁺, Sr²⁺, Ca²⁺ | (NH₄)₂CO₃ | Carbonates (white) |
    | **VI** | Mg²⁺, Na⁺, K⁺ | No group reagent | Remain in solution |

    ## Anion Classification

    ### Group A: Anions detected in solid state
    - CO₃²⁻, S²⁻, SO₃²⁻, NO₂⁻ (volatile products on heating with acid)

    ### Group B: Anions that give precipitates
    - Cl⁻, Br⁻, I⁻ (with AgNO₃)
    - SO₄²⁻ (with BaCl₂)
    - NO₃⁻ (brown ring test)

    ### Group C: Anions requiring special tests
    - PO₄³⁻, BO₃³⁻, CrO₄²⁻, MnO₄⁻

    ## Systematic Procedure

    ### Step 1: Preliminary Tests
    1. Physical examination (color, odor)
    2. Flame test
    3. Heating test
    4. Borax bead test (if metal present)

    ### Step 2: Preparation of Solution
    - Dissolve salt in water (if soluble)
    - If insoluble, try dilute HCl, then dilute HNO₃
    - Note any observations during dissolution

    ### Step 3: Anion Detection
    - Perform tests for anion groups A, B, C
    - Use confirmatory tests
    - Note interfering ions

    ### Step 4: Cation Detection
    - Test for Group 0 (NH₄⁺)
    - Add group reagents sequentially (Groups I-VI)
    - Perform confirmatory tests on each precipitate
    - Identify cations in final filtrate (Group VI)

    ## Important Flame Colors

    | Element | Flame Color |
    |---------|-------------|
    | Na | Golden yellow |
    | K | Violet (through blue glass) |
    | Ca | Brick red |
    | Sr | Crimson red |
    | Ba | Apple green |
    | Cu | Blue-green |

    ## Key Points for IIT JEE

    1. **Systematic approach**: Always follow the sequence (Group 0 → VI)
    2. **Interfering ions**: Some ions interfere with tests (e.g., colored ions mask others)
    3. **Group reagent specificity**: Understand why each reagent selectively precipitates
    4. **Confirmatory tests**: Know at least 2 tests for each ion
    5. **Common salt mixtures**: Practice identifying combinations

    ## Practical Tips

    - Always acidify before group precipitation to prevent interference
    - Use excess reagent to ensure complete precipitation
    - Wash precipitates to remove interfering ions
    - Perform blank tests to verify reagent purity
    - Note all color changes, precipitates, and gas evolution

## Key Points

- Salt analysis

- Preliminary tests

- Cation groups
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Salt analysis', 'Preliminary tests', 'Cation groups', 'Anion groups'],
  prerequisite_ids: []
)

puts "✓ Created 14 microlessons for Qualitative Analysis"

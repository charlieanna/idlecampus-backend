# AUTO-GENERATED from module_05_p_block_part2.rb
puts "Creating Microlessons for Module 05 P Block Part2..."

module_var = CourseModule.find_by(slug: 'module-05-p-block-part2')

# === MICROLESSON 1: uses — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'uses — Practice',
  content: <<~MARKDOWN,
# uses — Practice 🚀

TRUE. Helium is lighter than air (density less than air) and completely non-flammable, making it safe for balloons and airships.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['uses'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Helium is used in balloons because it is lighter than air and non-flammable.',
    answer: 'true',
    explanation: 'TRUE. Helium is lighter than air (density less than air) and completely non-flammable, making it safe for balloons and airships.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Group 17 - Halogens (F, Cl, Br, I, At) ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 17 - Halogens (F, Cl, Br, I, At)',
  content: <<~MARKDOWN,
# Group 17 - Halogens (F, Cl, Br, I, At) 🚀

# Group 17 - Halogens

    ## Introduction

    Group 17 elements have the general electronic configuration **ns² np⁵** (7 valence electrons).

    **Members:** Fluorine (F), Chlorine (Cl), Bromine (Br), Iodine (I), Astatine (At)

    **Name:** Halogens = Salt formers

    ## Electronic Configuration

    - F: [He] 2s² 2p⁵
    - Cl: [Ne] 3s² 3p⁵
    - Br: [Ar] 3d¹⁰ 4s² 4p⁵
    - I: [Kr] 4d¹⁰ 5s² 5p⁵
    - At: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁵

    ## Oxidation States

    Common oxidation state: **-1** (gain 1 electron)

    Higher oxidation states: +1, +3, +5, +7 (except F)

    **Fluorine:** Only -1 (most electronegative, no d-orbitals)
    **Chlorine:** -1, +1, +3, +5, +7 (ClO₄⁻ has Cl in +7)
    **Iodine:** -1, +1, +3, +5, +7 (I₂O₅, HIO₃)

    ## Physical Properties

    ### Physical State
    - F₂: Pale yellow gas
    - Cl₂: Greenish-yellow gas
    - Br₂: Red-brown liquid
    - I₂: Violet solid (sublimes)

    ### Color
    Halogens are colored due to absorption of visible light (electronic excitation)

    ### Atomic and Ionic Radii
    **Increase down the group:** F < Cl < Br < I

    ### Electronegativity
    **Decreases down the group:** F > Cl > Br > I > At
    - Fluorine is the **most electronegative** element (4.0)

    ### Electron Affinity
    **Order:** Cl > F > Br > I
    - Anomaly: Cl > F (due to small size of F, electron-electron repulsion)

    ### Bond Dissociation Energy
    **Order:** Cl₂ > Br₂ > F₂ > I₂
    - Anomaly: F₂ < Cl₂ (weak F-F bond due to lone pair repulsion in small F atom)

    ### Reactivity
    **Decreases down the group:** F₂ > Cl₂ > Br₂ > I₂
    - Fluorine is the **most reactive** non-metal

    ## Chemical Properties

    ### 1. Oxidizing Power

    **Decreases down the group:** F₂ > Cl₂ > Br₂ > I₂

    **Displacement reactions:**
    - Cl₂ + 2Br⁻ → 2Cl⁻ + Br₂ (Cl displaces Br)
    - Br₂ + 2I⁻ → 2Br⁻ + I₂ (Br displaces I)

    ### 2. Reaction with Hydrogen

    Form hydrogen halides (HX):

    H₂ + X₂ → 2HX

    **Reactivity:** H₂ + F₂ → 2HF (explosive even in dark)
    - H₂ + Cl₂ → 2HCl (explosive in sunlight)
    - Decreases down group

    **Thermal stability of HX:** HF > HCl > HBr > HI
    - H-F bond is strongest, H-I bond is weakest

    **Acid strength:** HF < HCl < HBr < HI
    - HF is weak acid (H-F bond very strong, doesn't ionize easily)
    - HI is strongest acid (H-I bond weak, ionizes easily)

    ### 3. Hydrogen Fluoride (HF)

    **Properties:**
    - Weak acid (Ka ~ 10⁻⁴)
    - Forms hydrogen bonds
    - Attacks glass: SiO₂ + 4HF → SiF₄ + 2H₂O
    - Stored in wax/plastic bottles

    ### 4. Hydrogen Chloride (HCl)

    **Preparation:**
    - Lab: NaCl + H₂SO₄ → NaHSO₄ + HCl
    - Industrial: H₂ + Cl₂ → 2HCl

    **Properties:**
    - Colorless, pungent gas
    - Highly soluble in water
    - Strong acid (HCl → H⁺ + Cl⁻)
    - Fumes in moist air

    **Aqua regia (Royal water):**
    3HCl + HNO₃ → 2H₂O + NOCl + Cl₂
    - Dissolves gold and platinum
    - Au + 3Cl₂ → AuCl₃ (oxidation by nascent chlorine)

    ### 5. Interhalogen Compounds

    Compounds between different halogens: XX', XX'₃, XX'₅, XX'₇

    **Examples:**
    - ClF, BrF, ICl (XX')
    - ClF₃, BrF₃, IF₃ (XX'₃)
    - ClF₅, BrF₅, IF₅ (XX'₅)
    - IF₇ (XX'₇)

    **Properties:**
    - More reactive than parent halogens
    - X is less electronegative, X' is more electronegative
    - Formed in decreasing electronegativity order

    ### 6. Chlorine Compounds

    **Bleaching Powder - CaOCl₂ or Ca(OCl)₂**

    **Preparation:**
    Ca(OH)₂ + Cl₂ → CaOCl₂ + H₂O

    **Properties:**
    - White powder, smell of chlorine
    - Oxidizing and bleaching agent
    - With dilute acid: Ca(OCl)₂ + H₂SO₄ → CaSO₄ + Cl₂ + H₂O

    **Uses:** Bleaching, disinfectant, oxidizing agent

    ## Anomalous Properties of Fluorine

    1. **Most electronegative** element (4.0)
    2. **Most reactive** non-metal
    3. **No positive oxidation states** (only -1)
    4. **HF is weak acid** (others are strong)
    5. **F₂ has low bond energy** (lone pair repulsion)
    6. Forms only **one oxoacid** (HOF)
    7. **Smallest halogen**, most reactive

    ## IIT JEE Key Points

    1. Halogens: **ns² np⁵** (7 valence electrons)
    2. **Reactivity:** F₂ > Cl₂ > Br₂ > I₂
    3. **Electronegativity:** F (4.0) is most electronegative
    4. **Acid strength:** HF < HCl < HBr < HI
    5. **Thermal stability:** HF > HCl > HBr > HI
    6. **Aqua regia:** 3HCl + HNO₃ (dissolves Au, Pt)
    7. **Bleaching powder:** CaOCl₂
    8. **Interhalogens:** XX', XX'₃, XX'₅, XX'₇

## Key Points

- Halogens

- Interhalogen compounds

- Hydrogen halides
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Halogens', 'Interhalogen compounds', 'Hydrogen halides', 'Bleaching powder', 'Aqua regia'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Group 18 - Noble Gases (He, Ne, Ar, Kr, Xe, Rn) ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 18 - Noble Gases (He, Ne, Ar, Kr, Xe, Rn)',
  content: <<~MARKDOWN,
# Group 18 - Noble Gases (He, Ne, Ar, Kr, Xe, Rn) 🚀

# Group 18 - Noble Gases

    ## Introduction

    Group 18 elements have the general electronic configuration **ns² np⁶** (complete octet).

    **Members:** Helium (He), Neon (Ne), Argon (Ar), Krypton (Kr), Xenon (Xe), Radon (Rn)

    **Name:** Noble gases (inert gases, rare gases)

    ## Electronic Configuration

    - He: 1s² (only 2 electrons - stable)
    - Ne: [He] 2s² 2p⁶
    - Ar: [Ne] 3s² 3p⁶
    - Kr: [Ar] 3d¹⁰ 4s² 4p⁶
    - Xe: [Kr] 4d¹⁰ 5s² 5p⁶
    - Rn: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁶

    ## Physical Properties

    ### Physical State
    - All are **monoatomic gases**
    - Colorless, odorless, tasteless

    ### Atomic Radii
    **Increase down the group:** He < Ne < Ar < Kr < Xe < Rn

    ### Ionization Energy
    **Decreases down the group:** He > Ne > Ar > Kr > Xe > Rn
    - He has **highest ionization energy** of all elements

    ### Electron Affinity
    - Nearly **zero** (stable octet, no tendency to gain electrons)

    ### Boiling Point
    **Increases down the group:** He < Ne < Ar < Kr < Xe < Rn
    - Due to increasing van der Waals forces

    ## Chemical Properties

    ### Inertness

    **Why are noble gases unreactive?**
    1. Complete octet (ns² np⁶) - stable electronic configuration
    2. Very high ionization energy
    3. Nearly zero electron affinity
    4. No tendency to gain, lose, or share electrons

    ### Compounds of Noble Gases

    **Historically:** Considered completely inert

    **1962:** Neil Bartlett prepared first noble gas compound
    - XePtF₆ (xenon hexafluoroplatinate)

    **Why only Xe and Kr form compounds?**
    - Lower ionization energy
    - Larger size (can accommodate F or O)
    - Empty d-orbitals available

    ### Xenon Compounds

    **Xenon fluorides:**
    - XeF₂ (linear)
    - XeF₄ (square planar)
    - XeF₆ (distorted octahedral)

    **Preparation:**
    Xe + F₂ → XeF₂, XeF₄, XeF₆ (conditions vary)

    **Xenon oxides:**
    - XeO₃ (explosive)
    - XeO₄ (explosive)

    **Xenon oxyfluorides:**
    - XeOF₄
    - XeO₂F₂

    **Hydrolysis of XeF₄:**
    XeF₄ + 2H₂O → XeO₂ + 4HF

    **Complete hydrolysis of XeF₆:**
    XeF₆ + 3H₂O → XeO₃ + 6HF

    ## Uses of Noble Gases

    ### Helium (He)
    - Filling balloons, airships (lighter than air, non-flammable)
    - Diving apparatus (mixed with O₂)
    - Cryogenics (liquid He, -269°C)

    ### Neon (Ne)
    - Neon signs, discharge tubes (red glow)
    - Advertising lights

    ### Argon (Ar)
    - Inert atmosphere for welding
    - Filling electric bulbs (prevents oxidation of filament)

    ### Krypton (Kr)
    - High-intensity lamps
    - Flash lamps for photography

    ### Xenon (Xe)
    - Flash lamps
    - Lasers
    - Anesthesia

    ### Radon (Rn)
    - Radiotherapy (radioactive)

    ## IIT JEE Key Points

    1. Noble gases: **ns² np⁶** (complete octet, except He: 1s²)
    2. **Monoatomic** gases
    3. **Very high ionization energy**, nearly zero electron affinity
    4. **Unreactive** due to stable electronic configuration
    5. **Only Xe and Kr** form compounds (with F and O)
    6. **XeF₂, XeF₄, XeF₆** - common xenon fluorides
    7. **He has highest ionization energy** of all elements
    8. **Uses:** He (balloons), Ne (signs), Ar (bulbs), Xe (anesthesia)

## Key Points

- Noble gases

- Inert gas configuration

- Xenon compounds
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Noble gases', 'Inert gas configuration', 'Xenon compounds', 'Low reactivity'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Group 15 - Nitrogen Family (N, P, As, Sb, Bi) ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 15 - Nitrogen Family (N, P, As, Sb, Bi)',
  content: <<~MARKDOWN,
# Group 15 - Nitrogen Family (N, P, As, Sb, Bi) 🚀

# Group 15 - Nitrogen Family (Pnictogens)

    ## Introduction

    Group 15 elements have the general electronic configuration **ns² np³** (5 valence electrons).

    **Members:** Nitrogen (N), Phosphorus (P), Arsenic (As), Antimony (Sb), Bismuth (Bi)

    ## Electronic Configuration

    - N: [He] 2s² 2p³
    - P: [Ne] 3s² 3p³
    - As: [Ar] 3d¹⁰ 4s² 4p³
    - Sb: [Kr] 4d¹⁰ 5s² 5p³
    - Bi: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p³

    ## Oxidation States

    Common oxidation states: **+5**, **+3**, **-3**

    **Trend:** Stability of +3 increases down group, +5 decreases
    - N: -3, +3, +5 (NO₂, HNO₃)
    - P: -3, +3, +5 (most stable: +5)
    - Bi: +3 most stable (inert pair effect)

    **Why nitrogen doesn't form pentahalides (NX₅)?**
    - No d-orbitals (cannot expand octet)
    - Maximum covalency = 4

    ## Allotropy of Phosphorus

    ### White Phosphorus (P₄)
    - Tetrahedral P₄ molecules
    - Waxy, white solid
    - Highly reactive, poisonous
    - Stored under water
    - Glows in dark (chemiluminescence)
    - Catches fire at 35°C

    ### Red Phosphorus
    - Polymeric structure
    - Less reactive
    - Non-poisonous
    - Does not glow in dark
    - Ignites at 260°C

    ### Black Phosphorus
    - Least reactive
    - Graphite-like structure
    - Electrical conductor

    **White → Red conversion:** Heat white P at 573 K (absence of air)

    ## Chemical Properties

    ### 1. Dinitrogen (N₂)

    **Properties:**
    - Triple bond (N≡N) - very strong (946 kJ/mol)
    - Unreactive at room temperature
    - Inert gas behavior

    **Reactions:**
    - With H₂: N₂ + 3H₂ ⇌ 2NH₃ (Haber process, 200 atm, 700 K, Fe catalyst)
    - With O₂: N₂ + O₂ → 2NO (at high temperature)
    - With Mg: N₂ + 3Mg → Mg₃N₂ (magnesium nitride)

    ### 2. Ammonia (NH₃)

    **Preparation:**
    - Lab: NH₄Cl + Ca(OH)₂ → CaCl₂ + 2H₂O + 2NH₃
    - Industrial: Haber process

    **Properties:**
    - Colorless, pungent gas
    - Highly soluble in water (fountain experiment)
    - Weak base: NH₃ + H₂O ⇌ NH₄⁺ + OH⁻
    - Reducing agent

    **Reactions:**
    - With HCl: NH₃ + HCl → NH₄Cl (white fumes)
    - With O₂: 4NH₃ + 5O₂ → 4NO + 6H₂O (Ostwald process)
    - With CuSO₄: Forms complex [Cu(NH₃)₄]²⁺ (deep blue)

    **Uses:** Fertilizers, refrigerant, manufacturing HNO₃

    ### 3. Oxides of Nitrogen

    | Formula | Name | Oxidation State | Nature |
    |---------|------|----------------|--------|
    | N₂O | Nitrous oxide | +1 | Neutral, laughing gas |
    | NO | Nitric oxide | +2 | Neutral, paramagnetic |
    | N₂O₃ | Dinitrogen trioxide | +3 | Acidic |
    | NO₂ | Nitrogen dioxide | +4 | Acidic, brown gas |
    | N₂O₅ | Dinitrogen pentoxide | +5 | Acidic |

    **NO₂ ⇌ N₂O₄ (brown) (colorless) equilibrium**

    ### 4. Nitric Acid (HNO₃)

    **Preparation (Ostwald process):**
    1. 4NH₃ + 5O₂ → 4NO + 6H₂O
    2. 2NO + O₂ → 2NO₂
    3. 4NO₂ + 2H₂O + O₂ → 4HNO₃

    **Properties:**
    - Strong acid
    - Strong oxidizing agent
    - Aqua regia: 3HCl + HNO₃ (dissolves gold and platinum)

    **Reactions:**
    - With Cu: 3Cu + 8HNO₃ (dilute) → 3Cu(NO₃)₂ + 2NO + 4H₂O
    - With Cu: Cu + 4HNO₃ (conc.) → Cu(NO₃)₂ + 2NO₂ + 2H₂O

    **Brown ring test (for NO₃⁻):**
    Add FeSO₄ + conc. H₂SO₄ → brown ring of [Fe(H₂O)₅(NO)]²⁺

    ### 5. Phosphorus Oxides

    **P₄O₁₀ (Phosphorus pentoxide):**
    - White powder
    - Extremely hygroscopic (dehydrating agent)
    - P₄ + 5O₂ → P₄O₁₀
    - P₄O₁₀ + 6H₂O → 4H₃PO₄

    ### 6. Phosphoric Acid (H₃PO₄)

    **Preparation:**
    - P₄O₁₀ + 6H₂O → 4H₃PO₄
    - Ca₃(PO₄)₂ + 3H₂SO₄ → 2H₃PO₄ + 3CaSO₄

    **Properties:**
    - Tribasic acid (3 ionizable H)
    - Oxidizing agent (when concentrated)

    **Salts:**
    - NaH₂PO₄ (monobasic)
    - Na₂HPO₄ (dibasic)
    - Na₃PO₄ (tribasic)

    ## IIT JEE Key Points

    1. Group 15: **ns² np³** (5 valence electrons)
    2. **N doesn't form NF₅** (no d-orbitals)
    3. **Phosphorus allotropes:** White (P₄, reactive), Red (polymeric, less reactive), Black (least reactive)
    4. **Ammonia:** Weak base, fountain experiment, [Cu(NH₃)₄]²⁺ complex
    5. **HNO₃:** Strong oxidizing agent, aqua regia dissolves Au/Pt
    6. **Brown ring test:** For NO₃⁻ using FeSO₄
    7. **H₃PO₄:** Tribasic acid

## Key Points

- Nitrogen family

- Allotropes of phosphorus

- Ammonia
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Nitrogen family', 'Allotropes of phosphorus', 'Ammonia', 'Nitric acid', 'Phosphoric acid'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Group 17 - Halogens (F, Cl, Br, I, At) ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 17 - Halogens (F, Cl, Br, I, At)',
  content: <<~MARKDOWN,
# Group 17 - Halogens (F, Cl, Br, I, At) 🚀

# Group 17 - Halogens

    ## Introduction

    Group 17 elements have the general electronic configuration **ns² np⁵** (7 valence electrons).

    **Members:** Fluorine (F), Chlorine (Cl), Bromine (Br), Iodine (I), Astatine (At)

    **Name:** Halogens = Salt formers

    ## Electronic Configuration

    - F: [He] 2s² 2p⁵
    - Cl: [Ne] 3s² 3p⁵
    - Br: [Ar] 3d¹⁰ 4s² 4p⁵
    - I: [Kr] 4d¹⁰ 5s² 5p⁵
    - At: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁵

    ## Oxidation States

    Common oxidation state: **-1** (gain 1 electron)

    Higher oxidation states: +1, +3, +5, +7 (except F)

    **Fluorine:** Only -1 (most electronegative, no d-orbitals)
    **Chlorine:** -1, +1, +3, +5, +7 (ClO₄⁻ has Cl in +7)
    **Iodine:** -1, +1, +3, +5, +7 (I₂O₅, HIO₃)

    ## Physical Properties

    ### Physical State
    - F₂: Pale yellow gas
    - Cl₂: Greenish-yellow gas
    - Br₂: Red-brown liquid
    - I₂: Violet solid (sublimes)

    ### Color
    Halogens are colored due to absorption of visible light (electronic excitation)

    ### Atomic and Ionic Radii
    **Increase down the group:** F < Cl < Br < I

    ### Electronegativity
    **Decreases down the group:** F > Cl > Br > I > At
    - Fluorine is the **most electronegative** element (4.0)

    ### Electron Affinity
    **Order:** Cl > F > Br > I
    - Anomaly: Cl > F (due to small size of F, electron-electron repulsion)

    ### Bond Dissociation Energy
    **Order:** Cl₂ > Br₂ > F₂ > I₂
    - Anomaly: F₂ < Cl₂ (weak F-F bond due to lone pair repulsion in small F atom)

    ### Reactivity
    **Decreases down the group:** F₂ > Cl₂ > Br₂ > I₂
    - Fluorine is the **most reactive** non-metal

    ## Chemical Properties

    ### 1. Oxidizing Power

    **Decreases down the group:** F₂ > Cl₂ > Br₂ > I₂

    **Displacement reactions:**
    - Cl₂ + 2Br⁻ → 2Cl⁻ + Br₂ (Cl displaces Br)
    - Br₂ + 2I⁻ → 2Br⁻ + I₂ (Br displaces I)

    ### 2. Reaction with Hydrogen

    Form hydrogen halides (HX):

    H₂ + X₂ → 2HX

    **Reactivity:** H₂ + F₂ → 2HF (explosive even in dark)
    - H₂ + Cl₂ → 2HCl (explosive in sunlight)
    - Decreases down group

    **Thermal stability of HX:** HF > HCl > HBr > HI
    - H-F bond is strongest, H-I bond is weakest

    **Acid strength:** HF < HCl < HBr < HI
    - HF is weak acid (H-F bond very strong, doesn't ionize easily)
    - HI is strongest acid (H-I bond weak, ionizes easily)

    ### 3. Hydrogen Fluoride (HF)

    **Properties:**
    - Weak acid (Ka ~ 10⁻⁴)
    - Forms hydrogen bonds
    - Attacks glass: SiO₂ + 4HF → SiF₄ + 2H₂O
    - Stored in wax/plastic bottles

    ### 4. Hydrogen Chloride (HCl)

    **Preparation:**
    - Lab: NaCl + H₂SO₄ → NaHSO₄ + HCl
    - Industrial: H₂ + Cl₂ → 2HCl

    **Properties:**
    - Colorless, pungent gas
    - Highly soluble in water
    - Strong acid (HCl → H⁺ + Cl⁻)
    - Fumes in moist air

    **Aqua regia (Royal water):**
    3HCl + HNO₃ → 2H₂O + NOCl + Cl₂
    - Dissolves gold and platinum
    - Au + 3Cl₂ → AuCl₃ (oxidation by nascent chlorine)

    ### 5. Interhalogen Compounds

    Compounds between different halogens: XX', XX'₃, XX'₅, XX'₇

    **Examples:**
    - ClF, BrF, ICl (XX')
    - ClF₃, BrF₃, IF₃ (XX'₃)
    - ClF₅, BrF₅, IF₅ (XX'₅)
    - IF₇ (XX'₇)

    **Properties:**
    - More reactive than parent halogens
    - X is less electronegative, X' is more electronegative
    - Formed in decreasing electronegativity order

    ### 6. Chlorine Compounds

    **Bleaching Powder - CaOCl₂ or Ca(OCl)₂**

    **Preparation:**
    Ca(OH)₂ + Cl₂ → CaOCl₂ + H₂O

    **Properties:**
    - White powder, smell of chlorine
    - Oxidizing and bleaching agent
    - With dilute acid: Ca(OCl)₂ + H₂SO₄ → CaSO₄ + Cl₂ + H₂O

    **Uses:** Bleaching, disinfectant, oxidizing agent

    ## Anomalous Properties of Fluorine

    1. **Most electronegative** element (4.0)
    2. **Most reactive** non-metal
    3. **No positive oxidation states** (only -1)
    4. **HF is weak acid** (others are strong)
    5. **F₂ has low bond energy** (lone pair repulsion)
    6. Forms only **one oxoacid** (HOF)
    7. **Smallest halogen**, most reactive

    ## IIT JEE Key Points

    1. Halogens: **ns² np⁵** (7 valence electrons)
    2. **Reactivity:** F₂ > Cl₂ > Br₂ > I₂
    3. **Electronegativity:** F (4.0) is most electronegative
    4. **Acid strength:** HF < HCl < HBr < HI
    5. **Thermal stability:** HF > HCl > HBr > HI
    6. **Aqua regia:** 3HCl + HNO₃ (dissolves Au, Pt)
    7. **Bleaching powder:** CaOCl₂
    8. **Interhalogens:** XX', XX'₃, XX'₅, XX'₇

## Key Points

- Halogens

- Interhalogen compounds

- Hydrogen halides
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Halogens', 'Interhalogen compounds', 'Hydrogen halides', 'Bleaching powder', 'Aqua regia'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Group 18 - Noble Gases (He, Ne, Ar, Kr, Xe, Rn) ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 18 - Noble Gases (He, Ne, Ar, Kr, Xe, Rn)',
  content: <<~MARKDOWN,
# Group 18 - Noble Gases (He, Ne, Ar, Kr, Xe, Rn) 🚀

# Group 18 - Noble Gases

    ## Introduction

    Group 18 elements have the general electronic configuration **ns² np⁶** (complete octet).

    **Members:** Helium (He), Neon (Ne), Argon (Ar), Krypton (Kr), Xenon (Xe), Radon (Rn)

    **Name:** Noble gases (inert gases, rare gases)

    ## Electronic Configuration

    - He: 1s² (only 2 electrons - stable)
    - Ne: [He] 2s² 2p⁶
    - Ar: [Ne] 3s² 3p⁶
    - Kr: [Ar] 3d¹⁰ 4s² 4p⁶
    - Xe: [Kr] 4d¹⁰ 5s² 5p⁶
    - Rn: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁶

    ## Physical Properties

    ### Physical State
    - All are **monoatomic gases**
    - Colorless, odorless, tasteless

    ### Atomic Radii
    **Increase down the group:** He < Ne < Ar < Kr < Xe < Rn

    ### Ionization Energy
    **Decreases down the group:** He > Ne > Ar > Kr > Xe > Rn
    - He has **highest ionization energy** of all elements

    ### Electron Affinity
    - Nearly **zero** (stable octet, no tendency to gain electrons)

    ### Boiling Point
    **Increases down the group:** He < Ne < Ar < Kr < Xe < Rn
    - Due to increasing van der Waals forces

    ## Chemical Properties

    ### Inertness

    **Why are noble gases unreactive?**
    1. Complete octet (ns² np⁶) - stable electronic configuration
    2. Very high ionization energy
    3. Nearly zero electron affinity
    4. No tendency to gain, lose, or share electrons

    ### Compounds of Noble Gases

    **Historically:** Considered completely inert

    **1962:** Neil Bartlett prepared first noble gas compound
    - XePtF₆ (xenon hexafluoroplatinate)

    **Why only Xe and Kr form compounds?**
    - Lower ionization energy
    - Larger size (can accommodate F or O)
    - Empty d-orbitals available

    ### Xenon Compounds

    **Xenon fluorides:**
    - XeF₂ (linear)
    - XeF₄ (square planar)
    - XeF₆ (distorted octahedral)

    **Preparation:**
    Xe + F₂ → XeF₂, XeF₄, XeF₆ (conditions vary)

    **Xenon oxides:**
    - XeO₃ (explosive)
    - XeO₄ (explosive)

    **Xenon oxyfluorides:**
    - XeOF₄
    - XeO₂F₂

    **Hydrolysis of XeF₄:**
    XeF₄ + 2H₂O → XeO₂ + 4HF

    **Complete hydrolysis of XeF₆:**
    XeF₆ + 3H₂O → XeO₃ + 6HF

    ## Uses of Noble Gases

    ### Helium (He)
    - Filling balloons, airships (lighter than air, non-flammable)
    - Diving apparatus (mixed with O₂)
    - Cryogenics (liquid He, -269°C)

    ### Neon (Ne)
    - Neon signs, discharge tubes (red glow)
    - Advertising lights

    ### Argon (Ar)
    - Inert atmosphere for welding
    - Filling electric bulbs (prevents oxidation of filament)

    ### Krypton (Kr)
    - High-intensity lamps
    - Flash lamps for photography

    ### Xenon (Xe)
    - Flash lamps
    - Lasers
    - Anesthesia

    ### Radon (Rn)
    - Radiotherapy (radioactive)

    ## IIT JEE Key Points

    1. Noble gases: **ns² np⁶** (complete octet, except He: 1s²)
    2. **Monoatomic** gases
    3. **Very high ionization energy**, nearly zero electron affinity
    4. **Unreactive** due to stable electronic configuration
    5. **Only Xe and Kr** form compounds (with F and O)
    6. **XeF₂, XeF₄, XeF₆** - common xenon fluorides
    7. **He has highest ionization energy** of all elements
    8. **Uses:** He (balloons), Ne (signs), Ar (bulbs), Xe (anesthesia)

## Key Points

- Noble gases

- Inert gas configuration

- Xenon compounds
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Noble gases', 'Inert gas configuration', 'Xenon compounds', 'Low reactivity'],
  prerequisite_ids: []
)

# === MICROLESSON 7: allotropy — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'allotropy — Practice',
  content: <<~MARKDOWN,
# allotropy — Practice 🚀

White phosphorus (P₄) is most reactive, poisonous, glows in dark, and catches fire at 35°C. Must be stored under water.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['allotropy'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which allotrope of phosphorus is the most reactive?',
    options: ['White phosphorus', 'Red phosphorus', 'Black phosphorus', 'All equally reactive'],
    correct_answer: 0,
    explanation: 'White phosphorus (P₄) is most reactive, poisonous, glows in dark, and catches fire at 35°C. Must be stored under water.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: chemical_tests — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_tests — Practice',
  content: <<~MARKDOWN,
# chemical_tests — Practice 🚀

Brown ring test detects NO₃⁻ ions. Add FeSO₄ and conc. H₂SO₄ to form brown ring of [Fe(H₂O)₅(NO)]²⁺ complex.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['chemical_tests'],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The brown ring test is used to detect the presence of _______ ions.',
    answer: 'nitrate|NO3-|NO₃⁻',
    explanation: 'Brown ring test detects NO₃⁻ ions. Add FeSO₄ and conc. H₂SO₄ to form brown ring of [Fe(H₂O)₅(NO)]²⁺ complex.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: ammonia — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'ammonia — Practice',
  content: <<~MARKDOWN,
# ammonia — Practice 🚀

NH₃ is a weak base, highly soluble (fountain experiment), forms [Cu(NH₃)₄]²⁺ (deep blue). It is a reducing agent, not oxidizing agent.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['ammonia'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which statements about ammonia (NH₃) are correct?',
    options: ['It is a weak base', 'It forms deep blue complex with Cu²⁺', 'It is a strong oxidizing agent', 'It is highly soluble in water'],
    correct_answer: 3,
    explanation: 'NH₃ is a weak base, highly soluble (fountain experiment), forms [Cu(NH₃)₄]²⁺ (deep blue). It is a reducing agent, not oxidizing agent.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 10: chemical_equations — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_equations — Practice',
  content: <<~MARKDOWN,
# chemical_equations — Practice 🚀

4NH₃ + 5O₂ → 4NO + 6H₂O. This is the first step of Ostwald process, using Pt catalyst at 500°C.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['chemical_equations'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Balance the first step of Ostwald process for HNO₃ production:',
    answer: '4 NH3 + 5 O2 -> 4 NO + 6 H2O',
    explanation: '4NH₃ + 5O₂ → 4NO + 6H₂O. This is the first step of Ostwald process, using Pt catalyst at 500°C.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: hydrogen_halides — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'hydrogen_halides — Practice',
  content: <<~MARKDOWN,
# hydrogen_halides — Practice 🚀

Acid strength increases down group: HF < HCl < HBr < HI. HF is weak (strong H-F bond), HI is strongest (weak H-I bond, easy ionization).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['hydrogen_halides'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following hydrogen halides in order of INCREASING acid strength:',
    answer: '1,2,3,4',
    explanation: 'Acid strength increases down group: HF < HCl < HBr < HI. HF is weak (strong H-F bond), HI is strongest (weak H-I bond, easy ionization).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: chlorine_compounds — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'chlorine_compounds — Practice',
  content: <<~MARKDOWN,
# chlorine_compounds — Practice 🚀

Aqua regia (royal water) is 3HCl:1HNO₃ mixture. Produces nascent chlorine which oxidizes noble metals like Au and Pt.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['chlorine_compounds'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The mixture of 3HCl and HNO₃ is called _______ and dissolves gold and platinum.',
    answer: 'aqua regia|aqua-regia|royal water',
    explanation: 'Aqua regia (royal water) is 3HCl:1HNO₃ mixture. Produces nascent chlorine which oxidizes noble metals like Au and Pt.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: periodic_trends — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'periodic_trends — Practice',
  content: <<~MARKDOWN,
# periodic_trends — Practice 🚀

Fluorine is the most electronegative element (electronegativity = 4.0 on Pauling scale). It has the highest tendency to attract electrons.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['periodic_trends'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which element is the most electronegative in the periodic table?',
    options: ['Oxygen', 'Fluorine', 'Chlorine', 'Nitrogen'],
    correct_answer: 1,
    explanation: 'Fluorine is the most electronegative element (electronegativity = 4.0 on Pauling scale). It has the highest tendency to attract electrons.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 14: displacement_reactions — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'displacement_reactions — Practice',
  content: <<~MARKDOWN,
# displacement_reactions — Practice 🚀

TRUE. Cl₂ + 2Br⁻ → 2Cl⁻ + Br₂. More reactive halogen displaces less reactive. Reactivity: F₂ > Cl₂ > Br₂ > I₂.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['displacement_reactions'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Chlorine can displace bromine from bromide solutions.',
    answer: 'true',
    explanation: 'TRUE. Cl₂ + 2Br⁻ → 2Cl⁻ + Br₂. More reactive halogen displaces less reactive. Reactivity: F₂ > Cl₂ > Br₂ > I₂.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: xenon_compounds — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'xenon_compounds — Practice',
  content: <<~MARKDOWN,
# xenon_compounds — Practice 🚀

Xenon forms the most compounds (XeF₂, XeF₄, XeF₆, XeO₃, XeO₄, XeOF₄). It has lower ionization energy and larger size than lighter noble gases.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['xenon_compounds'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which noble gas forms the most compounds?',
    options: ['Helium', 'Neon', 'Argon', 'Xenon'],
    correct_answer: 3,
    explanation: 'Xenon forms the most compounds (XeF₂, XeF₄, XeF₆, XeO₃, XeO₄, XeOF₄). It has lower ionization energy and larger size than lighter noble gases.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 16: electronic_configuration — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'electronic_configuration — Practice',
  content: <<~MARKDOWN,
# electronic_configuration — Practice 🚀

Noble gases have complete octet (ns² np⁶), making them very stable and unreactive. He has only 2 electrons (1s²) which is also stable.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['electronic_configuration'],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Noble gases are unreactive because they have a complete _______ configuration.',
    answer: 'octet|valence shell|outer shell',
    explanation: 'Noble gases have complete octet (ns² np⁶), making them very stable and unreactive. He has only 2 electrons (1s²) which is also stable.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: Group 15 - Nitrogen Family (N, P, As, Sb, Bi) ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 15 - Nitrogen Family (N, P, As, Sb, Bi)',
  content: <<~MARKDOWN,
# Group 15 - Nitrogen Family (N, P, As, Sb, Bi) 🚀

# Group 15 - Nitrogen Family (Pnictogens)

    ## Introduction

    Group 15 elements have the general electronic configuration **ns² np³** (5 valence electrons).

    **Members:** Nitrogen (N), Phosphorus (P), Arsenic (As), Antimony (Sb), Bismuth (Bi)

    ## Electronic Configuration

    - N: [He] 2s² 2p³
    - P: [Ne] 3s² 3p³
    - As: [Ar] 3d¹⁰ 4s² 4p³
    - Sb: [Kr] 4d¹⁰ 5s² 5p³
    - Bi: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p³

    ## Oxidation States

    Common oxidation states: **+5**, **+3**, **-3**

    **Trend:** Stability of +3 increases down group, +5 decreases
    - N: -3, +3, +5 (NO₂, HNO₃)
    - P: -3, +3, +5 (most stable: +5)
    - Bi: +3 most stable (inert pair effect)

    **Why nitrogen doesn't form pentahalides (NX₅)?**
    - No d-orbitals (cannot expand octet)
    - Maximum covalency = 4

    ## Allotropy of Phosphorus

    ### White Phosphorus (P₄)
    - Tetrahedral P₄ molecules
    - Waxy, white solid
    - Highly reactive, poisonous
    - Stored under water
    - Glows in dark (chemiluminescence)
    - Catches fire at 35°C

    ### Red Phosphorus
    - Polymeric structure
    - Less reactive
    - Non-poisonous
    - Does not glow in dark
    - Ignites at 260°C

    ### Black Phosphorus
    - Least reactive
    - Graphite-like structure
    - Electrical conductor

    **White → Red conversion:** Heat white P at 573 K (absence of air)

    ## Chemical Properties

    ### 1. Dinitrogen (N₂)

    **Properties:**
    - Triple bond (N≡N) - very strong (946 kJ/mol)
    - Unreactive at room temperature
    - Inert gas behavior

    **Reactions:**
    - With H₂: N₂ + 3H₂ ⇌ 2NH₃ (Haber process, 200 atm, 700 K, Fe catalyst)
    - With O₂: N₂ + O₂ → 2NO (at high temperature)
    - With Mg: N₂ + 3Mg → Mg₃N₂ (magnesium nitride)

    ### 2. Ammonia (NH₃)

    **Preparation:**
    - Lab: NH₄Cl + Ca(OH)₂ → CaCl₂ + 2H₂O + 2NH₃
    - Industrial: Haber process

    **Properties:**
    - Colorless, pungent gas
    - Highly soluble in water (fountain experiment)
    - Weak base: NH₃ + H₂O ⇌ NH₄⁺ + OH⁻
    - Reducing agent

    **Reactions:**
    - With HCl: NH₃ + HCl → NH₄Cl (white fumes)
    - With O₂: 4NH₃ + 5O₂ → 4NO + 6H₂O (Ostwald process)
    - With CuSO₄: Forms complex [Cu(NH₃)₄]²⁺ (deep blue)

    **Uses:** Fertilizers, refrigerant, manufacturing HNO₃

    ### 3. Oxides of Nitrogen

    | Formula | Name | Oxidation State | Nature |
    |---------|------|----------------|--------|
    | N₂O | Nitrous oxide | +1 | Neutral, laughing gas |
    | NO | Nitric oxide | +2 | Neutral, paramagnetic |
    | N₂O₃ | Dinitrogen trioxide | +3 | Acidic |
    | NO₂ | Nitrogen dioxide | +4 | Acidic, brown gas |
    | N₂O₅ | Dinitrogen pentoxide | +5 | Acidic |

    **NO₂ ⇌ N₂O₄ (brown) (colorless) equilibrium**

    ### 4. Nitric Acid (HNO₃)

    **Preparation (Ostwald process):**
    1. 4NH₃ + 5O₂ → 4NO + 6H₂O
    2. 2NO + O₂ → 2NO₂
    3. 4NO₂ + 2H₂O + O₂ → 4HNO₃

    **Properties:**
    - Strong acid
    - Strong oxidizing agent
    - Aqua regia: 3HCl + HNO₃ (dissolves gold and platinum)

    **Reactions:**
    - With Cu: 3Cu + 8HNO₃ (dilute) → 3Cu(NO₃)₂ + 2NO + 4H₂O
    - With Cu: Cu + 4HNO₃ (conc.) → Cu(NO₃)₂ + 2NO₂ + 2H₂O

    **Brown ring test (for NO₃⁻):**
    Add FeSO₄ + conc. H₂SO₄ → brown ring of [Fe(H₂O)₅(NO)]²⁺

    ### 5. Phosphorus Oxides

    **P₄O₁₀ (Phosphorus pentoxide):**
    - White powder
    - Extremely hygroscopic (dehydrating agent)
    - P₄ + 5O₂ → P₄O₁₀
    - P₄O₁₀ + 6H₂O → 4H₃PO₄

    ### 6. Phosphoric Acid (H₃PO₄)

    **Preparation:**
    - P₄O₁₀ + 6H₂O → 4H₃PO₄
    - Ca₃(PO₄)₂ + 3H₂SO₄ → 2H₃PO₄ + 3CaSO₄

    **Properties:**
    - Tribasic acid (3 ionizable H)
    - Oxidizing agent (when concentrated)

    **Salts:**
    - NaH₂PO₄ (monobasic)
    - Na₂HPO₄ (dibasic)
    - Na₃PO₄ (tribasic)

    ## IIT JEE Key Points

    1. Group 15: **ns² np³** (5 valence electrons)
    2. **N doesn't form NF₅** (no d-orbitals)
    3. **Phosphorus allotropes:** White (P₄, reactive), Red (polymeric, less reactive), Black (least reactive)
    4. **Ammonia:** Weak base, fountain experiment, [Cu(NH₃)₄]²⁺ complex
    5. **HNO₃:** Strong oxidizing agent, aqua regia dissolves Au/Pt
    6. **Brown ring test:** For NO₃⁻ using FeSO₄
    7. **H₃PO₄:** Tribasic acid

## Key Points

- Nitrogen family

- Allotropes of phosphorus

- Ammonia
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Nitrogen family', 'Allotropes of phosphorus', 'Ammonia', 'Nitric acid', 'Phosphoric acid'],
  prerequisite_ids: []
)

puts "✓ Created 17 microlessons for Module 05 P Block Part2"

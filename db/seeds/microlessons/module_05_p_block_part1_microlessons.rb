# AUTO-GENERATED from module_05_p_block_part1.rb
puts "Creating Microlessons for P Block Elements..."

module_var = CourseModule.find_by(slug: 'p-block-elements')

# === MICROLESSON 1: allotropy — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'allotropy — Practice',
  content: <<~MARKDOWN,
# allotropy — Practice 🚀

In diamond, each C is sp³ hybridized and forms 4 covalent bonds in a tetrahedral arrangement, creating a 3D network structure.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['allotropy'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In diamond, each carbon atom is bonded to how many other carbon atoms?',
    answer: '4',
    explanation: 'In diamond, each C is sp³ hybridized and forms 4 covalent bonds in a tetrahedral arrangement, creating a 3D network structure.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Group 14 - Carbon Family (C, Si, Ge, Sn, Pb) ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 14 - Carbon Family (C, Si, Ge, Sn, Pb)',
  content: <<~MARKDOWN,
# Group 14 - Carbon Family (C, Si, Ge, Sn, Pb) 🚀

# Group 14 - Carbon Family

    ## Introduction

    Group 14 elements have the general electronic configuration **ns² np²** (4 valence electrons).

    **Members:** Carbon (C), Silicon (Si), Germanium (Ge), Tin (Sn), Lead (Pb)

    ## Electronic Configuration

    - C: [He] 2s² 2p²
    - Si: [Ne] 3s² 3p²
    - Ge: [Ar] 3d¹⁰ 4s² 4p²
    - Sn: [Kr] 4d¹⁰ 5s² 5p²
    - Pb: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p²

    ## Oxidation States

    **Common oxidation states:** +4 (group oxidation state), +2

    **Trend:** Stability of +2 state increases down the group
    - C: +4, +2 (in CO)
    - Si: +4 predominantly
    - Ge: +4 and +2
    - Sn: Both +4 and +2 (SnCl₂, SnCl₄)
    - Pb: +2 more stable than +4

    **Inert Pair Effect:** Pb²⁺ is more stable than Pb⁴⁺ (PbO₂ is a strong oxidizing agent).

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group**

    ### Ionization Energy
    - **Decreases down the group**

    ### Electronegativity
    - **Decreases down the group**
    - C is most electronegative (2.5)

    ### Covalent Radius
    - **Increases down the group**

    ### Metallic Character
    - **Increases down the group**
    - C: Non-metal
    - Si, Ge: Metalloids
    - Sn, Pb: Metals

    ## Allotropy

    ### Carbon Allotropes

    **Diamond:**
    - 3D network of C atoms
    - Each C is sp³ hybridized
    - Hardest natural substance
    - Poor conductor of electricity
    - High refractive index

    **Graphite:**
    - Layered hexagonal structure
    - Each C is sp² hybridized
    - Soft and slippery
    - Good conductor of electricity (delocalized π electrons)
    - Used in pencils, lubricants, electrodes

    **Fullerenes:**
    - C₆₀ (Buckminsterfullerene) - soccer ball structure
    - Cage-like structures
    - Each C is bonded to 3 other C atoms

    **Graphene:**
    - Single layer of graphite
    - 2D material
    - Excellent electrical and thermal conductivity

    ## Chemical Properties

    ### 1. Catenation

    **Catenation:** Ability to form chains by bonding to itself

    **Order:** C >> Si > Ge > Sn > Pb

    **Reason:** C-C bond (356 kJ/mol) is strongest
    - C forms chains with millions of atoms
    - Si forms chains with up to 7-8 atoms (silanes)

    ### 2. Reaction with Oxygen

    Form MO₂ (dioxides):

    M + O₂ → MO₂

    **Nature of oxides:**
    - CO₂: Acidic gas
    - SiO₂: Acidic solid (giant covalent)
    - GeO₂: Amphoteric
    - SnO₂: Amphoteric
    - PbO₂: Amphoteric (strong oxidizing agent)

    Also form MO (monoxides):
    - CO: Neutral
    - SnO: Amphoteric
    - PbO: Amphoteric (Litharge)

    ### 3. Reaction with Halogens

    Form MX₄ and MX₂:

    **Tetrahalides (MX₄):**
    - CCl₄: Covalent, inert to hydrolysis
    - SiCl₄: Covalent, readily hydrolyzes (has d-orbitals)
    - SnCl₄, PbCl₄: Covalent

    **Dihalides (MX₂):**
    - SnCl₂: Reducing agent
    - PbCl₂: Sparingly soluble

    **Why CCl₄ doesn't hydrolyze but SiCl₄ does?**
    - C has no d-orbitals (cannot expand octet)
    - Si has d-orbitals (can accommodate H₂O attack)

    ### 4. Hydrides

    **Hydrides:** MH₄ type
    - CH₄: Methane (most stable)
    - SiH₄: Silane (less stable, catches fire in air)
    - GeH₄: Germane
    - SnH₄: Stannane (very unstable)

    **Stability decreases down the group** (M-H bond strength decreases)

    ## Important Compounds

    ### Carbon Monoxide - CO

    **Preparation:**
    - Incomplete combustion: 2C + O₂ → 2CO
    - From formic acid: HCOOH → CO + H₂O (with H₂SO₄)

    **Properties:**
    - Colorless, odorless, poisonous gas
    - Neutral oxide
    - Reducing agent
    - Forms carbonyls: Ni + 4CO → Ni(CO)₄

    **Toxicity:** Binds to hemoglobin more strongly than O₂, prevents oxygen transport

    ### Carbon Dioxide - CO₂

    **Preparation:**
    - Combustion: C + O₂ → CO₂
    - From carbonates: CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂

    **Properties:**
    - Colorless, odorless gas
    - Acidic oxide
    - Turns lime water milky: Ca(OH)₂ + CO₂ → CaCO₃↓ + H₂O
    - Does not support combustion (but Mg burns: 2Mg + CO₂ → 2MgO + C)

    **Uses:** Carbonated drinks, fire extinguisher, dry ice

    ### Silicon Dioxide - SiO₂ (Silica)

    **Occurrence:** Sand, quartz, agate

    **Structure:** 3D network of SiO₄ tetrahedra

    **Properties:**
    - Very hard
    - High melting point (1713°C)
    - Insoluble in water
    - Reacts with HF: SiO₂ + 4HF → SiF₄ + 2H₂O

    **Uses:** Glass, cement, pottery

    ### Silicates

    **Structure:** Based on SiO₄⁴⁻ tetrahedra

    **Types:**
    - Orthosilicates: Isolated SiO₄⁴⁻ (e.g., Mg₂SiO₄)
    - Pyrosilicates: Si₂O₇⁶⁻ (two tetrahedra sharing 1 O)
    - Chain silicates: (SiO₃²⁻)ₙ (pyroxenes)
    - Sheet silicates: (Si₂O₅²⁻)ₙ (mica, talc, asbestos)
    - 3D silicates: (SiO₂)ₙ (quartz, feldspar)

    ### Silicones

    **Formula:** (R₂SiO)ₙ

    **Structure:** Chains/rings of alternating Si and O atoms with organic groups (R = CH₃, C₂H₅)

    **Preparation:**
    RCl + Si → R₂SiCl₂ (with Cu catalyst)
    R₂SiCl₂ + H₂O → (R₂SiO)ₙ + HCl

    **Properties:**
    - Water repellent
    - Chemically inert
    - Heat resistant
    - Good electrical insulators

    **Uses:** Lubricants, sealants, water-proofing, cosmetics

    ### Lead Compounds

    **Lead(II) oxide - PbO (Litharge):**
    - Yellow or red powder
    - Amphoteric
    - Used in glass, pottery

    **Lead(IV) oxide - PbO₂:**
    - Dark brown powder
    - Strong oxidizing agent
    - Used in lead-acid batteries

    **Lead(II) sulfate - PbSO₄:**
    - White precipitate
    - Sparingly soluble
    - Used in lead storage batteries

    **Lead(II) chloride - PbCl₂:**
    - White precipitate
    - Sparingly soluble in cold water, soluble in hot water

    **Red lead - Pb₃O₄:**
    - Mixed oxide: 2PbO·PbO₂
    - Red powder
    - Used in paints (anti-rust)

    ## IIT JEE Key Points

    1. Group 14 has **ns² np²** configuration (4 valence electrons)
    2. **Inert pair effect:** Pb²⁺ more stable than Pb⁴⁺
    3. **Catenation:** C >> Si > Ge > Sn > Pb
    4. **Carbon allotropes:** Diamond (sp³, hard, insulator), Graphite (sp², soft, conductor), Fullerenes (C₆₀)
    5. **CCl₄ doesn't hydrolyze** (no d-orbitals), **SiCl₄ hydrolyzes** (has d-orbitals)
    6. **CO is poisonous** (binds to hemoglobin)
    7. **Silicones:** (R₂SiO)ₙ - water repellent, heat resistant
    8. **PbO₂:** Strong oxidizing agent

## Key Points

- Carbon family

- Allotropy

- Catenation
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Carbon family', 'Allotropy', 'Catenation', 'Silicones', 'Lead compounds'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Group 13 - Boron Family (B, Al, Ga, In, Tl) ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 13 - Boron Family (B, Al, Ga, In, Tl)',
  content: <<~MARKDOWN,
# Group 13 - Boron Family (B, Al, Ga, In, Tl) 🚀

# Group 13 - Boron Family

    ## Introduction

    Group 13 elements have the general electronic configuration **ns² np¹** (3 valence electrons).

    **Members:** Boron (B), Aluminium (Al), Gallium (Ga), Indium (In), Thallium (Tl)

    ## Electronic Configuration

    - B: [He] 2s² 2p¹
    - Al: [Ne] 3s² 3p¹
    - Ga: [Ar] 3d¹⁰ 4s² 4p¹
    - In: [Kr] 4d¹⁰ 5s² 5p¹
    - Tl: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p¹

    ## Oxidation States

    **Common oxidation states:** +3 (group oxidation state) and +1

    **Trend:** Stability of +1 state increases down the group
    - B, Al: Primarily +3
    - Ga, In: Both +3 and +1
    - Tl: +1 more stable than +3

    **Inert Pair Effect:** Due to poor shielding by d and f electrons, the ns² electrons become increasingly difficult to remove, making +1 state more stable for heavier elements.

    ## Physical Properties

    ### Atomic and Ionic Radii
    - Generally **increase down the group**
    - Anomaly: Ga < Al (due to presence of d-electrons with poor shielding)

    ### Ionization Energy
    - **Decreases down the group** (except Ga > Al)
    - Order: B > Tl > Ga > Al > In

    ### Electronegativity
    - **Decreases down the group**
    - Boron is most electronegative in the group

    ### Density
    - **Increases down the group**

    ### Metallic Character
    - **Increases down the group**
    - B is a metalloid (non-metal)
    - Al, Ga, In, Tl are metals

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    Form M₂O₃ (except Tl which also forms Tl₂O):

    4M + 3O₂ → 2M₂O₃

    - B₂O₃: Acidic
    - Al₂O₃: Amphoteric
    - Ga₂O₃, In₂O₃: Amphoteric
    - Tl₂O₃: Basic

    **Basicity increases** down the group.

    ### 2. Reaction with Acids and Bases

    **Aluminium is amphoteric:**
    - With acid: 2Al + 6HCl → 2AlCl₃ + 3H₂
    - With base: 2Al + 2NaOH + 2H₂O → 2NaAlO₂ + 3H₂

    ### 3. Reaction with Halogens

    Form MX₃ (trihalides):

    2M + 3X₂ → 2MX₃

    - Most halides are covalent (except some Al and heavier metal halides)
    - BCl₃, AlCl₃ are Lewis acids (electron deficient)

    ### 4. Hydrides

    Form MH₃ type hydrides:

    - B₂H₆ (diborane): Electron deficient, has 3-center-2-electron bonds
    - AlH₃: Polymeric
    - Hydride stability decreases down the group

    ## Anomalous Properties of Boron

    Boron differs from other Group 13 elements:

    1. **Non-metal** (others are metals)
    2. **Forms covalent compounds** exclusively
    3. **Does not form B³⁺ ion** (very high ionization energy)
    4. **Electron deficient compounds** (BH₃, BCl₃ have only 6 electrons)
    5. **Forms cluster compounds** (boranes like B₂H₆, B₄H₁₀)
    6. **High melting point** (2300°C)
    7. **Extremely hard**

    ## Diagonal Relationship: B and Si

    Boron shows similarity with Silicon (Group 14):

    | Property | Similarity |
    |----------|-----------|
    | Nature | Both are metalloids |
    | Oxides | B₂O₃ and SiO₂ are acidic |
    | Hydrides | Both form hydrides that burn in air |
    | Halides | Both halides are covalent and hydrolyze |
    | Hardness | Both are very hard |

    ## Important Compounds

    ### Borax - Na₂B₄O₇·10H₂O

    **Preparation:** From colemanite ore

    **Properties:**
    - White crystalline solid
    - Dissolves in water to give alkaline solution
    - On heating, swells up and loses water

    **Uses:**
    - Manufacture of glass and enamels
    - Borax bead test (qualitative analysis)
    - Antiseptic, water softener

    **Reactions:**
    - With acid: Na₂B₄O₇ + 2HCl + 5H₂O → 2NaCl + 4H₃BO₃
    - On heating: Na₂B₄O₇·10H₂O → Na₂B₄O₇ + 10H₂O

    ### Boric Acid - H₃BO₃ or B(OH)₃

    **Preparation:**
    Na₂B₄O₇ + 2HCl + 5H₂O → 2NaCl + 4H₃BO₃

    **Structure:** Layered structure with hydrogen bonding

    **Properties:**
    - Weak monobasic acid (not tribasic!)
    - Acts as Lewis acid: B(OH)₃ + H₂O → [B(OH)₄]⁻ + H⁺
    - Antiseptic

    **Uses:** Eye wash, food preservative, insecticide

    ### Diborane - B₂H₆

    **Structure:** Two 3-center-2-electron bonds (banana bonds)

    **Properties:**
    - Colorless gas
    - Highly reactive
    - Burns in air: B₂H₆ + 3O₂ → B₂O₃ + 3H₂O
    - Hydrolyzes: B₂H₆ + 6H₂O → 2B(OH)₃ + 6H₂

    **Uses:** Rocket fuel, reducing agent

    ### Aluminium Oxide - Al₂O₃ (Alumina)

    **Occurrence:** Bauxite (Al₂O₃·2H₂O), Corundum (Al₂O₃)

    **Properties:**
    - Very hard (used as abrasive)
    - High melting point (2050°C)
    - Amphoteric oxide
    - Insoluble in water

    **Amphoteric nature:**
    - With acid: Al₂O₃ + 6HCl → 2AlCl₃ + 3H₂O
    - With base: Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O

    ### Aluminium Chloride - AlCl₃

    **Structure:** Dimeric (Al₂Cl₆) in vapor phase

    **Properties:**
    - Anhydrous AlCl₃ is covalent
    - Fumes in moist air (hygroscopic)
    - Lewis acid (electron deficient)

    **Uses:** Friedel-Crafts catalyst in organic chemistry

    ### Alum - K₂SO₄·Al₂(SO₄)₃·24H₂O

    **General formula:** M₂SO₄·M₂³⁺(SO₄)₃·24H₂O

    **Properties:**
    - Double salt
    - Forms octahedral crystals
    - Dissolves in water

    **Uses:** Water purification, dyeing, paper industry

    ## IIT JEE Key Points

    1. Group 13 has **ns² np¹** configuration (3 valence electrons)
    2. **Inert pair effect:** +1 state stability increases down group (Tl⁺ > Tl³⁺)
    3. **Boron is anomalous:** non-metal, covalent compounds only
    4. **Diagonal relationship:** B resembles Si
    5. **Amphoteric:** Al₂O₃ and Al(OH)₃ react with both acids and bases
    6. **Lewis acids:** BCl₃ and AlCl₃ (electron deficient)
    7. **Borax formula:** Na₂B₄O₇·10H₂O
    8. **Boric acid:** Weak monobasic acid, acts as Lewis acid
    9. **Diborane:** B₂H₆ has 3-center-2-electron bonds

## Key Points

- Boron family

- Inert pair effect

- Diagonal relationship B-Si
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Boron family', 'Inert pair effect', 'Diagonal relationship B-Si', 'Borax', 'Alum'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Group 14 - Carbon Family (C, Si, Ge, Sn, Pb) ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 14 - Carbon Family (C, Si, Ge, Sn, Pb)',
  content: <<~MARKDOWN,
# Group 14 - Carbon Family (C, Si, Ge, Sn, Pb) 🚀

# Group 14 - Carbon Family

    ## Introduction

    Group 14 elements have the general electronic configuration **ns² np²** (4 valence electrons).

    **Members:** Carbon (C), Silicon (Si), Germanium (Ge), Tin (Sn), Lead (Pb)

    ## Electronic Configuration

    - C: [He] 2s² 2p²
    - Si: [Ne] 3s² 3p²
    - Ge: [Ar] 3d¹⁰ 4s² 4p²
    - Sn: [Kr] 4d¹⁰ 5s² 5p²
    - Pb: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p²

    ## Oxidation States

    **Common oxidation states:** +4 (group oxidation state), +2

    **Trend:** Stability of +2 state increases down the group
    - C: +4, +2 (in CO)
    - Si: +4 predominantly
    - Ge: +4 and +2
    - Sn: Both +4 and +2 (SnCl₂, SnCl₄)
    - Pb: +2 more stable than +4

    **Inert Pair Effect:** Pb²⁺ is more stable than Pb⁴⁺ (PbO₂ is a strong oxidizing agent).

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group**

    ### Ionization Energy
    - **Decreases down the group**

    ### Electronegativity
    - **Decreases down the group**
    - C is most electronegative (2.5)

    ### Covalent Radius
    - **Increases down the group**

    ### Metallic Character
    - **Increases down the group**
    - C: Non-metal
    - Si, Ge: Metalloids
    - Sn, Pb: Metals

    ## Allotropy

    ### Carbon Allotropes

    **Diamond:**
    - 3D network of C atoms
    - Each C is sp³ hybridized
    - Hardest natural substance
    - Poor conductor of electricity
    - High refractive index

    **Graphite:**
    - Layered hexagonal structure
    - Each C is sp² hybridized
    - Soft and slippery
    - Good conductor of electricity (delocalized π electrons)
    - Used in pencils, lubricants, electrodes

    **Fullerenes:**
    - C₆₀ (Buckminsterfullerene) - soccer ball structure
    - Cage-like structures
    - Each C is bonded to 3 other C atoms

    **Graphene:**
    - Single layer of graphite
    - 2D material
    - Excellent electrical and thermal conductivity

    ## Chemical Properties

    ### 1. Catenation

    **Catenation:** Ability to form chains by bonding to itself

    **Order:** C >> Si > Ge > Sn > Pb

    **Reason:** C-C bond (356 kJ/mol) is strongest
    - C forms chains with millions of atoms
    - Si forms chains with up to 7-8 atoms (silanes)

    ### 2. Reaction with Oxygen

    Form MO₂ (dioxides):

    M + O₂ → MO₂

    **Nature of oxides:**
    - CO₂: Acidic gas
    - SiO₂: Acidic solid (giant covalent)
    - GeO₂: Amphoteric
    - SnO₂: Amphoteric
    - PbO₂: Amphoteric (strong oxidizing agent)

    Also form MO (monoxides):
    - CO: Neutral
    - SnO: Amphoteric
    - PbO: Amphoteric (Litharge)

    ### 3. Reaction with Halogens

    Form MX₄ and MX₂:

    **Tetrahalides (MX₄):**
    - CCl₄: Covalent, inert to hydrolysis
    - SiCl₄: Covalent, readily hydrolyzes (has d-orbitals)
    - SnCl₄, PbCl₄: Covalent

    **Dihalides (MX₂):**
    - SnCl₂: Reducing agent
    - PbCl₂: Sparingly soluble

    **Why CCl₄ doesn't hydrolyze but SiCl₄ does?**
    - C has no d-orbitals (cannot expand octet)
    - Si has d-orbitals (can accommodate H₂O attack)

    ### 4. Hydrides

    **Hydrides:** MH₄ type
    - CH₄: Methane (most stable)
    - SiH₄: Silane (less stable, catches fire in air)
    - GeH₄: Germane
    - SnH₄: Stannane (very unstable)

    **Stability decreases down the group** (M-H bond strength decreases)

    ## Important Compounds

    ### Carbon Monoxide - CO

    **Preparation:**
    - Incomplete combustion: 2C + O₂ → 2CO
    - From formic acid: HCOOH → CO + H₂O (with H₂SO₄)

    **Properties:**
    - Colorless, odorless, poisonous gas
    - Neutral oxide
    - Reducing agent
    - Forms carbonyls: Ni + 4CO → Ni(CO)₄

    **Toxicity:** Binds to hemoglobin more strongly than O₂, prevents oxygen transport

    ### Carbon Dioxide - CO₂

    **Preparation:**
    - Combustion: C + O₂ → CO₂
    - From carbonates: CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂

    **Properties:**
    - Colorless, odorless gas
    - Acidic oxide
    - Turns lime water milky: Ca(OH)₂ + CO₂ → CaCO₃↓ + H₂O
    - Does not support combustion (but Mg burns: 2Mg + CO₂ → 2MgO + C)

    **Uses:** Carbonated drinks, fire extinguisher, dry ice

    ### Silicon Dioxide - SiO₂ (Silica)

    **Occurrence:** Sand, quartz, agate

    **Structure:** 3D network of SiO₄ tetrahedra

    **Properties:**
    - Very hard
    - High melting point (1713°C)
    - Insoluble in water
    - Reacts with HF: SiO₂ + 4HF → SiF₄ + 2H₂O

    **Uses:** Glass, cement, pottery

    ### Silicates

    **Structure:** Based on SiO₄⁴⁻ tetrahedra

    **Types:**
    - Orthosilicates: Isolated SiO₄⁴⁻ (e.g., Mg₂SiO₄)
    - Pyrosilicates: Si₂O₇⁶⁻ (two tetrahedra sharing 1 O)
    - Chain silicates: (SiO₃²⁻)ₙ (pyroxenes)
    - Sheet silicates: (Si₂O₅²⁻)ₙ (mica, talc, asbestos)
    - 3D silicates: (SiO₂)ₙ (quartz, feldspar)

    ### Silicones

    **Formula:** (R₂SiO)ₙ

    **Structure:** Chains/rings of alternating Si and O atoms with organic groups (R = CH₃, C₂H₅)

    **Preparation:**
    RCl + Si → R₂SiCl₂ (with Cu catalyst)
    R₂SiCl₂ + H₂O → (R₂SiO)ₙ + HCl

    **Properties:**
    - Water repellent
    - Chemically inert
    - Heat resistant
    - Good electrical insulators

    **Uses:** Lubricants, sealants, water-proofing, cosmetics

    ### Lead Compounds

    **Lead(II) oxide - PbO (Litharge):**
    - Yellow or red powder
    - Amphoteric
    - Used in glass, pottery

    **Lead(IV) oxide - PbO₂:**
    - Dark brown powder
    - Strong oxidizing agent
    - Used in lead-acid batteries

    **Lead(II) sulfate - PbSO₄:**
    - White precipitate
    - Sparingly soluble
    - Used in lead storage batteries

    **Lead(II) chloride - PbCl₂:**
    - White precipitate
    - Sparingly soluble in cold water, soluble in hot water

    **Red lead - Pb₃O₄:**
    - Mixed oxide: 2PbO·PbO₂
    - Red powder
    - Used in paints (anti-rust)

    ## IIT JEE Key Points

    1. Group 14 has **ns² np²** configuration (4 valence electrons)
    2. **Inert pair effect:** Pb²⁺ more stable than Pb⁴⁺
    3. **Catenation:** C >> Si > Ge > Sn > Pb
    4. **Carbon allotropes:** Diamond (sp³, hard, insulator), Graphite (sp², soft, conductor), Fullerenes (C₆₀)
    5. **CCl₄ doesn't hydrolyze** (no d-orbitals), **SiCl₄ hydrolyzes** (has d-orbitals)
    6. **CO is poisonous** (binds to hemoglobin)
    7. **Silicones:** (R₂SiO)ₙ - water repellent, heat resistant
    8. **PbO₂:** Strong oxidizing agent

## Key Points

- Carbon family

- Allotropy

- Catenation
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Carbon family', 'Allotropy', 'Catenation', 'Silicones', 'Lead compounds'],
  prerequisite_ids: []
)

# === MICROLESSON 5: inert_pair_effect — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'inert_pair_effect — Practice',
  content: <<~MARKDOWN,
# inert_pair_effect — Practice 🚀

Inert pair effect increases down the group. Thallium shows the strongest effect, with Tl⁺ being more stable than Tl³⁺ due to poor shielding by 4f and 5d electrons.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['inert_pair_effect'],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which element in Group 13 shows the strongest inert pair effect?',
    options: ['Boron', 'Aluminium', 'Gallium', 'Thallium'],
    correct_answer: 3,
    explanation: 'Inert pair effect increases down the group. Thallium shows the strongest effect, with Tl⁺ being more stable than Tl³⁺ due to poor shielding by 4f and 5d electrons.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 6: boron_compounds — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'boron_compounds — Practice',
  content: <<~MARKDOWN,
# boron_compounds — Practice 🚀

H₃BO₃ acts as a Lewis acid by accepting OH⁻: B(OH)₃ + H₂O → [B(OH)₄]⁻ + H⁺. It is NOT a Brønsted acid (doesn\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['boron_compounds'],
  prerequisite_ids: []
)

# Exercise 6.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Boric acid acts as a _______ acid (Lewis/Brønsted).',
    answer: 'Lewis|lewis',
    explanation: 'H₃BO₃ acts as a Lewis acid by accepting OH⁻: B(OH)₃ + H₂O → [B(OH)₄]⁻ + H⁺. It is NOT a Brønsted acid (doesn\',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 7: anomalous_behavior — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'anomalous_behavior — Practice',
  content: <<~MARKDOWN,
# anomalous_behavior — Practice 🚀

Boron is anomalous: (1) Non-metal (others are metals), (2) Forms only covalent compounds, (3) Electron-deficient (BH₃, BCl₃), (4) Does NOT form B³⁺ (very high IE).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['anomalous_behavior'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are anomalous properties of boron?',
    options: ['It is a non-metal', 'It forms ionic compounds', 'It forms electron-deficient compounds', 'It readily forms B³⁺ ions'],
    correct_answer: 2,
    explanation: 'Boron is anomalous: (1) Non-metal (others are metals), (2) Forms only covalent compounds, (3) Electron-deficient (BH₃, BCl₃), (4) Does NOT form B³⁺ (very high IE).',
    difficulty: 'hard'
  }
)

# === MICROLESSON 8: boron_compounds — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'boron_compounds — Practice',
  content: <<~MARKDOWN,
# boron_compounds — Practice 🚀

Borax is Na₂B₄O₇·10H₂O (sodium tetraborate decahydrate). It loses all 10 water molecules on heating.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['boron_compounds'],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many water molecules of crystallization are present in borax (Na₂B₄O₇·xH₂O)?',
    answer: '10',
    explanation: 'Borax is Na₂B₄O₇·10H₂O (sodium tetraborate decahydrate). It loses all 10 water molecules on heating.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: aluminium_compounds — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'aluminium_compounds — Practice',
  content: <<~MARKDOWN,
# aluminium_compounds — Practice 🚀

TRUE. Al₂O₃ is amphoteric - reacts with acids (Al₂O₃ + 6HCl → 2AlCl₃ + 3H₂O) and bases (Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['aluminium_compounds'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Aluminium oxide (Al₂O₃) is amphoteric in nature.',
    answer: 'true',
    explanation: 'TRUE. Al₂O₃ is amphoteric - reacts with acids (Al₂O₃ + 6HCl → 2AlCl₃ + 3H₂O) and bases (Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: periodic_trends — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'periodic_trends — Practice',
  content: <<~MARKDOWN,
# periodic_trends — Practice 🚀

Basicity of oxides increases down the group: B₂O₃ (acidic) < Al₂O₃ (amphoteric) < Ga₂O₃ (amphoteric) < Tl₂O₃ (basic).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['periodic_trends'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following in order of INCREASING basicity of oxides:',
    answer: '1,2,3,4',
    explanation: 'Basicity of oxides increases down the group: B₂O₃ (acidic) < Al₂O₃ (amphoteric) < Ga₂O₃ (amphoteric) < Tl₂O₃ (basic).',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: chemical_reactivity — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_reactivity — Practice',
  content: <<~MARKDOWN,
# chemical_reactivity — Practice 🚀

CCl₄ cannot hydrolyze because C (period 2) has no d-orbitals and cannot expand its octet to accommodate H₂O attack. Si (period 3) has empty d-orbitals that can accept lone pairs from water.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['chemical_reactivity'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why does CCl₄ not undergo hydrolysis while SiCl₄ does?',
    options: ['C-Cl bond is stronger than Si-Cl bond', 'C has no d-orbitals to accept lone pairs from H₂O', 'CCl₄ is less polar than SiCl₄', 'SiCl₄ is more soluble in water'],
    correct_answer: 1,
    explanation: 'CCl₄ cannot hydrolyze because C (period 2) has no d-orbitals and cannot expand its octet to accommodate H₂O attack. Si (period 3) has empty d-orbitals that can accept lone pairs from water.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 12: catenation — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'catenation — Practice',
  content: <<~MARKDOWN,
# catenation — Practice 🚀

Catenation ability: C >> Si > Ge > Sn > Pb. C-C bond (356 kJ/mol) is strongest, allowing formation of long chains. Si forms chains up to Si₇, then ability decreases.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['catenation'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following in order of DECREASING catenation ability:',
    answer: '1,2,3,4',
    explanation: 'Catenation ability: C >> Si > Ge > Sn > Pb. C-C bond (356 kJ/mol) is strongest, allowing formation of long chains. Si forms chains up to Si₇, then ability decreases.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: allotropy — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'allotropy — Practice',
  content: <<~MARKDOWN,
# allotropy — Practice 🚀

Graphite: sp² hybridized C atoms, layered hexagonal structure, good conductor (delocalized π electrons), soft and slippery. Diamond is the hardest form.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['allotropy'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following statements about graphite are correct?',
    options: ['Each carbon atom is sp² hybridized', 'It is a good conductor of electricity', 'It is the hardest form of carbon', 'It has a layered structure'],
    correct_answer: 3,
    explanation: 'Graphite: sp² hybridized C atoms, layered hexagonal structure, good conductor (delocalized π electrons), soft and slippery. Diamond is the hardest form.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: carbon_compounds — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'carbon_compounds — Practice',
  content: <<~MARKDOWN,
# carbon_compounds — Practice 🚀

CO binds to hemoglobin about 200 times more strongly than O₂, forming carboxyhemoglobin (COHb), which prevents oxygen transport in blood.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['carbon_compounds'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Carbon monoxide is poisonous because it binds to _______ more strongly than oxygen.',
    answer: 'hemoglobin|haemoglobin|hemoglobin (Hb)',
    explanation: 'CO binds to hemoglobin about 200 times more strongly than O₂, forming carboxyhemoglobin (COHb), which prevents oxygen transport in blood.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: lead_compounds — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'lead_compounds — Practice',
  content: <<~MARKDOWN,
# lead_compounds — Practice 🚀

PbO₂ (lead dioxide) is a strong oxidizing agent. Pb is in +4 state (unstable due to inert pair effect), readily reduced to Pb²⁺.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['lead_compounds'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which oxide of lead is a strong oxidizing agent?',
    options: ['PbO', 'PbO₂', 'Pb₃O₄', 'Pb₂O₃'],
    correct_answer: 1,
    explanation: 'PbO₂ (lead dioxide) is a strong oxidizing agent. Pb is in +4 state (unstable due to inert pair effect), readily reduced to Pb²⁺.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: silicon_compounds — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'silicon_compounds — Practice',
  content: <<~MARKDOWN,
# silicon_compounds — Practice 🚀

TRUE. Silicones (R₂SiO)ₙ are water repellent, chemically inert, heat resistant, and good electrical insulators. Used in waterproofing, lubricants, and sealants.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['silicon_compounds'],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Silicones are water repellent and chemically inert.',
    answer: 'true',
    explanation: 'TRUE. Silicones (R₂SiO)ₙ are water repellent, chemically inert, heat resistant, and good electrical insulators. Used in waterproofing, lubricants, and sealants.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: Group 13 - Boron Family (B, Al, Ga, In, Tl) ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 13 - Boron Family (B, Al, Ga, In, Tl)',
  content: <<~MARKDOWN,
# Group 13 - Boron Family (B, Al, Ga, In, Tl) 🚀

# Group 13 - Boron Family

    ## Introduction

    Group 13 elements have the general electronic configuration **ns² np¹** (3 valence electrons).

    **Members:** Boron (B), Aluminium (Al), Gallium (Ga), Indium (In), Thallium (Tl)

    ## Electronic Configuration

    - B: [He] 2s² 2p¹
    - Al: [Ne] 3s² 3p¹
    - Ga: [Ar] 3d¹⁰ 4s² 4p¹
    - In: [Kr] 4d¹⁰ 5s² 5p¹
    - Tl: [Xe] 4f¹⁴ 5d¹⁰ 6s² 6p¹

    ## Oxidation States

    **Common oxidation states:** +3 (group oxidation state) and +1

    **Trend:** Stability of +1 state increases down the group
    - B, Al: Primarily +3
    - Ga, In: Both +3 and +1
    - Tl: +1 more stable than +3

    **Inert Pair Effect:** Due to poor shielding by d and f electrons, the ns² electrons become increasingly difficult to remove, making +1 state more stable for heavier elements.

    ## Physical Properties

    ### Atomic and Ionic Radii
    - Generally **increase down the group**
    - Anomaly: Ga < Al (due to presence of d-electrons with poor shielding)

    ### Ionization Energy
    - **Decreases down the group** (except Ga > Al)
    - Order: B > Tl > Ga > Al > In

    ### Electronegativity
    - **Decreases down the group**
    - Boron is most electronegative in the group

    ### Density
    - **Increases down the group**

    ### Metallic Character
    - **Increases down the group**
    - B is a metalloid (non-metal)
    - Al, Ga, In, Tl are metals

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    Form M₂O₃ (except Tl which also forms Tl₂O):

    4M + 3O₂ → 2M₂O₃

    - B₂O₃: Acidic
    - Al₂O₃: Amphoteric
    - Ga₂O₃, In₂O₃: Amphoteric
    - Tl₂O₃: Basic

    **Basicity increases** down the group.

    ### 2. Reaction with Acids and Bases

    **Aluminium is amphoteric:**
    - With acid: 2Al + 6HCl → 2AlCl₃ + 3H₂
    - With base: 2Al + 2NaOH + 2H₂O → 2NaAlO₂ + 3H₂

    ### 3. Reaction with Halogens

    Form MX₃ (trihalides):

    2M + 3X₂ → 2MX₃

    - Most halides are covalent (except some Al and heavier metal halides)
    - BCl₃, AlCl₃ are Lewis acids (electron deficient)

    ### 4. Hydrides

    Form MH₃ type hydrides:

    - B₂H₆ (diborane): Electron deficient, has 3-center-2-electron bonds
    - AlH₃: Polymeric
    - Hydride stability decreases down the group

    ## Anomalous Properties of Boron

    Boron differs from other Group 13 elements:

    1. **Non-metal** (others are metals)
    2. **Forms covalent compounds** exclusively
    3. **Does not form B³⁺ ion** (very high ionization energy)
    4. **Electron deficient compounds** (BH₃, BCl₃ have only 6 electrons)
    5. **Forms cluster compounds** (boranes like B₂H₆, B₄H₁₀)
    6. **High melting point** (2300°C)
    7. **Extremely hard**

    ## Diagonal Relationship: B and Si

    Boron shows similarity with Silicon (Group 14):

    | Property | Similarity |
    |----------|-----------|
    | Nature | Both are metalloids |
    | Oxides | B₂O₃ and SiO₂ are acidic |
    | Hydrides | Both form hydrides that burn in air |
    | Halides | Both halides are covalent and hydrolyze |
    | Hardness | Both are very hard |

    ## Important Compounds

    ### Borax - Na₂B₄O₇·10H₂O

    **Preparation:** From colemanite ore

    **Properties:**
    - White crystalline solid
    - Dissolves in water to give alkaline solution
    - On heating, swells up and loses water

    **Uses:**
    - Manufacture of glass and enamels
    - Borax bead test (qualitative analysis)
    - Antiseptic, water softener

    **Reactions:**
    - With acid: Na₂B₄O₇ + 2HCl + 5H₂O → 2NaCl + 4H₃BO₃
    - On heating: Na₂B₄O₇·10H₂O → Na₂B₄O₇ + 10H₂O

    ### Boric Acid - H₃BO₃ or B(OH)₃

    **Preparation:**
    Na₂B₄O₇ + 2HCl + 5H₂O → 2NaCl + 4H₃BO₃

    **Structure:** Layered structure with hydrogen bonding

    **Properties:**
    - Weak monobasic acid (not tribasic!)
    - Acts as Lewis acid: B(OH)₃ + H₂O → [B(OH)₄]⁻ + H⁺
    - Antiseptic

    **Uses:** Eye wash, food preservative, insecticide

    ### Diborane - B₂H₆

    **Structure:** Two 3-center-2-electron bonds (banana bonds)

    **Properties:**
    - Colorless gas
    - Highly reactive
    - Burns in air: B₂H₆ + 3O₂ → B₂O₃ + 3H₂O
    - Hydrolyzes: B₂H₆ + 6H₂O → 2B(OH)₃ + 6H₂

    **Uses:** Rocket fuel, reducing agent

    ### Aluminium Oxide - Al₂O₃ (Alumina)

    **Occurrence:** Bauxite (Al₂O₃·2H₂O), Corundum (Al₂O₃)

    **Properties:**
    - Very hard (used as abrasive)
    - High melting point (2050°C)
    - Amphoteric oxide
    - Insoluble in water

    **Amphoteric nature:**
    - With acid: Al₂O₃ + 6HCl → 2AlCl₃ + 3H₂O
    - With base: Al₂O₃ + 2NaOH → 2NaAlO₂ + H₂O

    ### Aluminium Chloride - AlCl₃

    **Structure:** Dimeric (Al₂Cl₆) in vapor phase

    **Properties:**
    - Anhydrous AlCl₃ is covalent
    - Fumes in moist air (hygroscopic)
    - Lewis acid (electron deficient)

    **Uses:** Friedel-Crafts catalyst in organic chemistry

    ### Alum - K₂SO₄·Al₂(SO₄)₃·24H₂O

    **General formula:** M₂SO₄·M₂³⁺(SO₄)₃·24H₂O

    **Properties:**
    - Double salt
    - Forms octahedral crystals
    - Dissolves in water

    **Uses:** Water purification, dyeing, paper industry

    ## IIT JEE Key Points

    1. Group 13 has **ns² np¹** configuration (3 valence electrons)
    2. **Inert pair effect:** +1 state stability increases down group (Tl⁺ > Tl³⁺)
    3. **Boron is anomalous:** non-metal, covalent compounds only
    4. **Diagonal relationship:** B resembles Si
    5. **Amphoteric:** Al₂O₃ and Al(OH)₃ react with both acids and bases
    6. **Lewis acids:** BCl₃ and AlCl₃ (electron deficient)
    7. **Borax formula:** Na₂B₄O₇·10H₂O
    8. **Boric acid:** Weak monobasic acid, acts as Lewis acid
    9. **Diborane:** B₂H₆ has 3-center-2-electron bonds

## Key Points

- Boron family

- Inert pair effect

- Diagonal relationship B-Si
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Boron family', 'Inert pair effect', 'Diagonal relationship B-Si', 'Borax', 'Alum'],
  prerequisite_ids: []
)

puts "✓ Created 17 microlessons for P Block Elements"

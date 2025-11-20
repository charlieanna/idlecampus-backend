# AUTO-GENERATED from module_04_s_block.rb
puts "Creating Microlessons for S Block Elements..."

module_var = CourseModule.find_by(slug: 's-block-elements')

# === MICROLESSON 1: chemical_reactivity — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_reactivity — Practice',
  content: <<~MARKDOWN,
# chemical_reactivity — Practice 🚀

Reactivity with water increases down the group: Be < Mg < Ca < Sr < Ba. Be does not react (protective oxide), Mg reacts slowly with cold water, Ca/Sr/Ba react readily with cold water.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['chemical_reactivity'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following alkaline earth metals in order of INCREASING reactivity with water:',
    answer: '1,2,3,4',
    explanation: 'Reactivity with water increases down the group: Be < Mg < Ca < Sr < Ba. Be does not react (protective oxide), Mg reacts slowly with cold water, Ca/Sr/Ba react readily with cold water.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Group 2 - Alkaline Earth Metals (Be, Mg, Ca, Sr, Ba, Ra) ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 2 - Alkaline Earth Metals (Be, Mg, Ca, Sr, Ba, Ra)',
  content: <<~MARKDOWN,
# Group 2 - Alkaline Earth Metals (Be, Mg, Ca, Sr, Ba, Ra) 🚀

# Group 2 - Alkaline Earth Metals

    ## Introduction

    Group 2 elements are called **alkaline earth metals** because their oxides and hydroxides are alkaline and are found in earth's crust.

    **Members:** Beryllium (Be), Magnesium (Mg), Calcium (Ca), Strontium (Sr), Barium (Ba), Radium (Ra)

    ## Electronic Configuration

    All alkaline earth metals have **two valence electrons** in their outermost s-orbital.

    - Be: [He] 2s²
    - Mg: [Ne] 3s²
    - Ca: [Ar] 4s²
    - Sr: [Kr] 5s²
    - Ba: [Xe] 6s²
    - Ra: [Rn] 7s²

    Common oxidation state: **+2**

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group:** Be < Mg < Ca < Sr < Ba < Ra
    - Smaller than corresponding alkali metals (same period)
    - Reason: Higher nuclear charge with same number of shells

    ### Ionization Energy
    - **Decreases down the group:** Be > Mg > Ca > Sr > Ba > Ra
    - Higher than alkali metals (need to remove 2 electrons)
    - Still relatively low → readily form M²⁺ ions

    ### Electronegativity
    - **Decreases down the group:** Be > Mg > Ca > Sr > Ba > Ra
    - Lower than alkali metals in same period

    ### Density
    - **Increases down the group:** Be < Mg < Ca < Sr < Ba < Ra
    - Higher than alkali metals

    ### Melting and Boiling Points
    - **Decrease down the group** (except Mg < Ca)
    - Higher than alkali metals (stronger metallic bonding)

    ### Hardness
    - **Harder than alkali metals**
    - Beryllium is the hardest
    - Decreases down the group

    ### Physical Appearance
    - Silvery-white metals
    - Less reactive than alkali metals (but still reactive)

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    Form ionic oxides (MO):

    2M + O₂ → 2MO

    - BeO: Amphoteric (reacts with both acids and bases)
    - Other oxides: Basic
    - **Basicity increases down the group:** BeO < MgO < CaO < SrO < BaO

    ### 2. Reaction with Water

    **Beryllium:** Does not react with water (protective oxide layer)

    **Magnesium:** Reacts slowly with cold water, rapidly with hot water:
    Mg + 2H₂O → Mg(OH)₂ + H₂

    **Ca, Sr, Ba:** React readily with cold water:
    M + 2H₂O → M(OH)₂ + H₂

    **Reactivity:** Be < Mg < Ca < Sr < Ba

    ### 3. Reaction with Acids

    React with dilute acids to give hydrogen gas:

    M + 2HCl → MCl₂ + H₂↑

    ### 4. Reaction with Halogens

    Form ionic halides (MX₂):

    M + X₂ → MX₂

    - BeCl₂ has covalent character (polymeric structure)
    - Other halides are predominantly ionic

    ### 5. Reaction with Hydrogen

    Form hydrides (MH₂) at high temperature:

    M + H₂ → MH₂

    - BeH₂ is covalent (polymeric)
    - Others are ionic

    ### 6. Reducing Nature

    Alkaline earth metals are **reducing agents** (but weaker than alkali metals).

    **Reducing power:** Ba > Sr > Ca > Mg > Be

    ## Solubility of Salts

    ### Hydroxides: M(OH)₂
    **Solubility and basicity increase down the group:**
    Be(OH)₂ < Mg(OH)₂ < Ca(OH)₂ < Sr(OH)₂ < Ba(OH)₂

    - Be(OH)₂: Amphoteric, sparingly soluble
    - Mg(OH)₂: Sparingly soluble, weak base
    - Ca(OH)₂: Moderately soluble (lime water)
    - Ba(OH)₂: Quite soluble, strong base

    ### Sulfates: MSO₄
    **Solubility decreases down the group:**
    BeSO₄ > MgSO₄ > CaSO₄ > SrSO₄ > BaSO₄

    - BaSO₄: Almost insoluble (used in medical imaging)
    - Hydration enthalpy decreases faster than lattice energy

    ### Carbonates: MCO₃
    **Thermal stability increases down the group:**
    BeCO₃ < MgCO₃ < CaCO₃ < SrCO₃ < BaCO₃

    All decompose on heating:
    MCO₃ → MO + CO₂

    - BeCO₃ and MgCO₃: Least stable
    - BaCO₃: Most stable

    ## Anomalous Properties of Beryllium

    Beryllium differs from other alkaline earth metals due to **very small size** and **high ionization energy**:

    1. **Hardest** and **highest melting point**
    2. **Does not react with water** (protective oxide layer)
    3. Forms **covalent compounds** (BeCl₂, BeH₂ are covalent polymers)
    4. **BeO and Be(OH)₂ are amphoteric** (others are basic)
    5. **Does not form complexes easily** (except with fluoride: [BeF₄]²⁻)
    6. **Carbonate unstable** (BeCO₃ exists only in solution)
    7. Forms **coordinate covalent bonds** in many compounds

    ## Diagonal Relationship: Be and Al

    Beryllium shows similarity with Aluminium:

    | Property | Similarity |
    |----------|-----------|
    | Oxide | Both BeO and Al₂O₃ are amphoteric |
    | Hydroxide | Both Be(OH)₂ and Al(OH)₃ are amphoteric |
    | Carbide | Both form carbides that give methane with water |
    | Chloride | Both BeCl₂ and AlCl₃ are covalent, hygroscopic |
    | Complex formation | Both form complex fluorides |

    ## Important Compounds

    ### Calcium Oxide (CaO) - Quick Lime
    **Preparation:** Thermal decomposition of limestone
    CaCO₃ → CaO + CO₂ (at 1200 K)

    **Uses:** Manufacture of cement, slaked lime, mortar

    ### Calcium Hydroxide - Ca(OH)₂ - Slaked Lime
    **Preparation:** CaO + H₂O → Ca(OH)₂ + Heat

    **Uses:** Mortar, white wash, softening hard water

    ### Calcium Carbonate (CaCO₃)
    **Forms:** Limestone, marble, chalk

    **Uses:** Manufacture of lime, cement, glass

    ### Plaster of Paris - CaSO₄·½H₂O
    **Preparation:** Heating gypsum at 393 K
    CaSO₄·2H₂O → CaSO₄·½H₂O + 1½H₂O

    **Property:** Sets to a hard mass (gypsum) when mixed with water
    CaSO₄·½H₂O + 1½H₂O → CaSO₄·2H₂O

    **Uses:** Casts, molds, surgical bandages

    ### Gypsum - CaSO₄·2H₂O
    **Uses:** Manufacture of plaster of paris, cement retardant

    ### Magnesium Hydroxide - Mg(OH)₂ - Milk of Magnesia
    **Uses:** Antacid, laxative

    ### Magnesium Sulfate - MgSO₄·7H₂O - Epsom Salt
    **Uses:** Purgative, in tanning, dyeing

    ## Hardness of Water

    Water containing dissolved Ca²⁺ and Mg²⁺ salts is called **hard water**.

    ### Types of Hardness

    **1. Temporary Hardness (Carbonate hardness)**
    - Due to: Ca(HCO₃)₂, Mg(HCO₃)₂
    - **Removal:** Boiling
      - Ca(HCO₃)₂ → CaCO₃↓ + H₂O + CO₂
      - Mg(HCO₃)₂ → MgCO₃↓ + H₂O + CO₂
    - **Removal:** Clark's method (adding lime)
      - Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O

    **2. Permanent Hardness (Non-carbonate hardness)**
    - Due to: CaSO₄, CaCl₂, MgSO₄, MgCl₂
    - **Cannot be removed by boiling**
    - **Removal methods:**
      - **Washing soda:** Na₂CO₃ + CaSO₄ → CaCO₃↓ + Na₂SO₄
      - **Ion exchange resins:** Replace Ca²⁺, Mg²⁺ with Na⁺ or H⁺
      - **Calgon's method:** Sodium hexametaphosphate complexes Ca²⁺, Mg²⁺

    ## Flame Colors

    | Element | Flame Color |
    |---------|-------------|
    | Be | No distinct color |
    | Mg | No distinct color |
    | Ca | Brick red |
    | Sr | Crimson red |
    | Ba | Apple green |

    ## Biological Importance

    - **Mg²⁺:** Essential for chlorophyll (photosynthesis)
    - **Ca²⁺:** Bones, teeth, blood clotting, muscle contraction

    ## IIT JEE Key Points

    1. Alkaline earth metals have **two valence electrons** (ns²)
    2. **Reactivity increases** down the group
    3. **Beryllium is anomalous** (smallest size, covalent compounds)
    4. **Diagonal relationship:** Be resembles Al
    5. **Solubility of hydroxides increases** down the group
    6. **Solubility of sulfates decreases** down the group
    7. **Thermal stability of carbonates increases** down the group
    8. Hard water: Temporary (bicarbonates) vs Permanent (sulfates, chlorides)
    9. Plaster of Paris: CaSO₄·½H₂O (sets to gypsum)
    10. Flame colors: Ca (brick red), Sr (crimson), Ba (green)

## Key Points

- Alkaline earth metals

- Beryllium anomaly

- Calcium compounds
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Alkaline earth metals', 'Beryllium anomaly', 'Calcium compounds', 'Hardness of water'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Group 1 - Alkali Metals (Li, Na, K, Rb, Cs, Fr) ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 1 - Alkali Metals (Li, Na, K, Rb, Cs, Fr)',
  content: <<~MARKDOWN,
# Group 1 - Alkali Metals (Li, Na, K, Rb, Cs, Fr) 🚀

# Group 1 - Alkali Metals

    ## Introduction

    Group 1 elements are called **alkali metals** because they form alkalis (strong bases) when they react with water.

    **Members:** Lithium (Li), Sodium (Na), Potassium (K), Rubidium (Rb), Cesium (Cs), Francium (Fr)

    ## Electronic Configuration

    All alkali metals have **one valence electron** in their outermost s-orbital.

    - Li: [He] 2s¹
    - Na: [Ne] 3s¹
    - K: [Ar] 4s¹
    - Rb: [Kr] 5s¹
    - Cs: [Xe] 6s¹
    - Fr: [Rn] 7s¹

    This single valence electron makes them highly reactive and gives them similar chemical properties.

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group:** Li < Na < K < Rb < Cs < Fr
    - Reason: Addition of new electron shells
    - Alkali metals have the **largest atomic radii** in their respective periods

    ### Ionization Energy (IE)
    - **Decreases down the group:** Li > Na > K > Rb > Cs > Fr
    - Reason: Increasing atomic size, valence electron farther from nucleus
    - Alkali metals have the **lowest ionization energies** in their periods
    - Easy to lose the valence electron → +1 oxidation state

    ### Electronegativity
    - **Decreases down the group:** Li > Na > K > Rb > Cs > Fr
    - Very low electronegativity (highly electropositive)

    ### Density
    - Generally **increases down the group**
    - Exception: K < Na (due to large increase in atomic size)
    - Li, Na, K are less dense than water

    ### Melting and Boiling Points
    - **Decrease down the group:** Li > Na > K > Rb > Cs > Fr
    - Reason: Weaker metallic bonding with increasing size
    - Alkali metals are soft and have low melting points

    ### Physical State and Appearance
    - All are soft, silvery-white metals
    - Can be cut with a knife
    - Freshly cut surface is shiny but tarnishes quickly in air

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    All alkali metals react vigorously with oxygen, but products differ:

    **Lithium (Normal oxide):**
    4Li + O₂ → 2Li₂O (Lithium oxide)

    **Sodium (Peroxide):**
    2Na + O₂ → Na₂O₂ (Sodium peroxide)

    **K, Rb, Cs (Superoxide):**
    K + O₂ → KO₂ (Potassium superoxide)

    **Trend:** Normal oxide → Peroxide → Superoxide (down the group)

    ### 2. Reaction with Water

    All alkali metals react with water to form hydroxides and hydrogen gas:

    2M + 2H₂O → 2MOH + H₂↑

    **Reactivity increases down the group:** Li < Na < K < Rb < Cs

    - Li: Reacts steadily, floats
    - Na: Reacts vigorously, melts into a ball, floats
    - K: Reacts violently, catches fire (lilac flame), floats
    - Rb, Cs: Explosive reaction

    ### 3. Reaction with Halogens

    Form ionic halides (MX):

    2M + X₂ → 2MX

    - Highly exothermic reactions
    - Reactivity: F₂ > Cl₂ > Br₂ > I₂

    ### 4. Reaction with Hydrogen

    Form ionic hydrides (MH):

    2M + H₂ → 2MH (at high temperature)

    - These are strong reducing agents
    - Example: LiH, NaH

    ### 5. Reducing Nature

    Alkali metals are **strong reducing agents**.

    **Reducing power:** Li > Na > K > Rb > Cs (in aqueous solution)

    **Why is Li the strongest reducer?**
    - High hydration enthalpy due to small size
    - Compensates for high ionization energy

    ## Flame Colors

    Alkali metals impart characteristic colors to flame:

    | Element | Flame Color | Wavelength Range |
    |---------|-------------|------------------|
    | Li | Crimson red | 670 nm |
    | Na | Golden yellow | 589 nm |
    | K | Lilac/Violet | 766 nm |
    | Rb | Red-violet | - |
    | Cs | Blue | - |

    **Reason:** Excitation of valence electron by heat energy

    ## Solutions in Liquid Ammonia

    Alkali metals dissolve in liquid ammonia to form blue solutions:

    M + (x+y)NH₃ → [M(NH₃)ₓ]⁺ + [e(NH₃)ᵧ]⁻

    - Dilute solutions: Blue color (due to ammoniated electrons)
    - Concentrated solutions: Bronze color (metallic luster)
    - Solutions are good conductors of electricity
    - Paramagnetic due to unpaired electrons

    ## Anomalous Properties of Lithium

    Lithium differs from other alkali metals due to its **small size** and **high charge density**:

    1. **Hardest** alkali metal
    2. **Highest melting and boiling points**
    3. **Least reactive** with water
    4. Forms **covalent compounds** (e.g., LiCl has some covalent character)
    5. **Decomposes on heating:** 4LiNO₃ → 2Li₂O + 4NO₂ + O₂ (other alkali metal nitrates give nitrites)
    6. **LiOH is less basic** than other alkali metal hydroxides
    7. **Li₂CO₃ decomposes on heating** (others don't)
    8. **Does not form superoxide** (only normal oxide)

    ## Diagonal Relationship: Li and Mg

    Lithium shows similarity with Magnesium (diagonal element) due to similar charge/size ratio:

    | Property | Similarity |
    |----------|-----------|
    | Hardness | Both are harder than group members |
    | Carbonate | Both carbonates decompose on heating |
    | Nitrate | Both nitrates give oxides on heating |
    | Hydroxide | Both hydroxides are weak bases |
    | Bicarbonate | Neither forms solid bicarbonates |
    | Organometallic | Both form organometallic compounds |

    ## Important Compounds of Alkali Metals

    ### Sodium Hydroxide (NaOH) - Caustic Soda
    - **Preparation:** Chlor-alkali process (electrolysis of brine)
    - **Uses:** Soap making, paper industry, petroleum refining

    ### Sodium Carbonate (Na₂CO₃·10H₂O) - Washing Soda
    - **Preparation:** Solvay process (ammonia-soda process)
    - **Uses:** Water softening, glass manufacturing, cleaning

    ### Sodium Bicarbonate (NaHCO₃) - Baking Soda
    - **Preparation:** From washing soda and CO₂
    - **Uses:** Baking powder, antacid, fire extinguisher

    ### Sodium Chloride (NaCl) - Common Salt
    - **Source:** Sea water, rock salt
    - **Uses:** Food preservation, raw material for chemicals

    ### Sodium Thiosulfate (Na₂S₂O₃·5H₂O) - Hypo
    - **Uses:** Photography (fixing agent), dechlorination

    ## IIT JEE Key Points

    1. Alkali metals have **one valence electron** (ns¹)
    2. **Reactivity increases** down the group (Li < Na < K < Rb < Cs)
    3. **Reducing power in solution:** Li > Na > K > Rb > Cs
    4. Flame colors: Li (crimson), Na (yellow), K (lilac)
    5. **Lithium is anomalous** due to small size
    6. **Diagonal relationship:** Li resembles Mg
    7. Oxide formation: Li (oxide), Na (peroxide), K/Rb/Cs (superoxide)
    8. All form **ionic compounds** (except Li shows some covalent character)

## Key Points

- Alkali metals

- Electronic configuration

- Physical properties
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Alkali metals', 'Electronic configuration', 'Physical properties', 'Chemical reactivity', 'Flame colors'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Group 2 - Alkaline Earth Metals (Be, Mg, Ca, Sr, Ba, Ra) ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 2 - Alkaline Earth Metals (Be, Mg, Ca, Sr, Ba, Ra)',
  content: <<~MARKDOWN,
# Group 2 - Alkaline Earth Metals (Be, Mg, Ca, Sr, Ba, Ra) 🚀

# Group 2 - Alkaline Earth Metals

    ## Introduction

    Group 2 elements are called **alkaline earth metals** because their oxides and hydroxides are alkaline and are found in earth's crust.

    **Members:** Beryllium (Be), Magnesium (Mg), Calcium (Ca), Strontium (Sr), Barium (Ba), Radium (Ra)

    ## Electronic Configuration

    All alkaline earth metals have **two valence electrons** in their outermost s-orbital.

    - Be: [He] 2s²
    - Mg: [Ne] 3s²
    - Ca: [Ar] 4s²
    - Sr: [Kr] 5s²
    - Ba: [Xe] 6s²
    - Ra: [Rn] 7s²

    Common oxidation state: **+2**

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group:** Be < Mg < Ca < Sr < Ba < Ra
    - Smaller than corresponding alkali metals (same period)
    - Reason: Higher nuclear charge with same number of shells

    ### Ionization Energy
    - **Decreases down the group:** Be > Mg > Ca > Sr > Ba > Ra
    - Higher than alkali metals (need to remove 2 electrons)
    - Still relatively low → readily form M²⁺ ions

    ### Electronegativity
    - **Decreases down the group:** Be > Mg > Ca > Sr > Ba > Ra
    - Lower than alkali metals in same period

    ### Density
    - **Increases down the group:** Be < Mg < Ca < Sr < Ba < Ra
    - Higher than alkali metals

    ### Melting and Boiling Points
    - **Decrease down the group** (except Mg < Ca)
    - Higher than alkali metals (stronger metallic bonding)

    ### Hardness
    - **Harder than alkali metals**
    - Beryllium is the hardest
    - Decreases down the group

    ### Physical Appearance
    - Silvery-white metals
    - Less reactive than alkali metals (but still reactive)

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    Form ionic oxides (MO):

    2M + O₂ → 2MO

    - BeO: Amphoteric (reacts with both acids and bases)
    - Other oxides: Basic
    - **Basicity increases down the group:** BeO < MgO < CaO < SrO < BaO

    ### 2. Reaction with Water

    **Beryllium:** Does not react with water (protective oxide layer)

    **Magnesium:** Reacts slowly with cold water, rapidly with hot water:
    Mg + 2H₂O → Mg(OH)₂ + H₂

    **Ca, Sr, Ba:** React readily with cold water:
    M + 2H₂O → M(OH)₂ + H₂

    **Reactivity:** Be < Mg < Ca < Sr < Ba

    ### 3. Reaction with Acids

    React with dilute acids to give hydrogen gas:

    M + 2HCl → MCl₂ + H₂↑

    ### 4. Reaction with Halogens

    Form ionic halides (MX₂):

    M + X₂ → MX₂

    - BeCl₂ has covalent character (polymeric structure)
    - Other halides are predominantly ionic

    ### 5. Reaction with Hydrogen

    Form hydrides (MH₂) at high temperature:

    M + H₂ → MH₂

    - BeH₂ is covalent (polymeric)
    - Others are ionic

    ### 6. Reducing Nature

    Alkaline earth metals are **reducing agents** (but weaker than alkali metals).

    **Reducing power:** Ba > Sr > Ca > Mg > Be

    ## Solubility of Salts

    ### Hydroxides: M(OH)₂
    **Solubility and basicity increase down the group:**
    Be(OH)₂ < Mg(OH)₂ < Ca(OH)₂ < Sr(OH)₂ < Ba(OH)₂

    - Be(OH)₂: Amphoteric, sparingly soluble
    - Mg(OH)₂: Sparingly soluble, weak base
    - Ca(OH)₂: Moderately soluble (lime water)
    - Ba(OH)₂: Quite soluble, strong base

    ### Sulfates: MSO₄
    **Solubility decreases down the group:**
    BeSO₄ > MgSO₄ > CaSO₄ > SrSO₄ > BaSO₄

    - BaSO₄: Almost insoluble (used in medical imaging)
    - Hydration enthalpy decreases faster than lattice energy

    ### Carbonates: MCO₃
    **Thermal stability increases down the group:**
    BeCO₃ < MgCO₃ < CaCO₃ < SrCO₃ < BaCO₃

    All decompose on heating:
    MCO₃ → MO + CO₂

    - BeCO₃ and MgCO₃: Least stable
    - BaCO₃: Most stable

    ## Anomalous Properties of Beryllium

    Beryllium differs from other alkaline earth metals due to **very small size** and **high ionization energy**:

    1. **Hardest** and **highest melting point**
    2. **Does not react with water** (protective oxide layer)
    3. Forms **covalent compounds** (BeCl₂, BeH₂ are covalent polymers)
    4. **BeO and Be(OH)₂ are amphoteric** (others are basic)
    5. **Does not form complexes easily** (except with fluoride: [BeF₄]²⁻)
    6. **Carbonate unstable** (BeCO₃ exists only in solution)
    7. Forms **coordinate covalent bonds** in many compounds

    ## Diagonal Relationship: Be and Al

    Beryllium shows similarity with Aluminium:

    | Property | Similarity |
    |----------|-----------|
    | Oxide | Both BeO and Al₂O₃ are amphoteric |
    | Hydroxide | Both Be(OH)₂ and Al(OH)₃ are amphoteric |
    | Carbide | Both form carbides that give methane with water |
    | Chloride | Both BeCl₂ and AlCl₃ are covalent, hygroscopic |
    | Complex formation | Both form complex fluorides |

    ## Important Compounds

    ### Calcium Oxide (CaO) - Quick Lime
    **Preparation:** Thermal decomposition of limestone
    CaCO₃ → CaO + CO₂ (at 1200 K)

    **Uses:** Manufacture of cement, slaked lime, mortar

    ### Calcium Hydroxide - Ca(OH)₂ - Slaked Lime
    **Preparation:** CaO + H₂O → Ca(OH)₂ + Heat

    **Uses:** Mortar, white wash, softening hard water

    ### Calcium Carbonate (CaCO₃)
    **Forms:** Limestone, marble, chalk

    **Uses:** Manufacture of lime, cement, glass

    ### Plaster of Paris - CaSO₄·½H₂O
    **Preparation:** Heating gypsum at 393 K
    CaSO₄·2H₂O → CaSO₄·½H₂O + 1½H₂O

    **Property:** Sets to a hard mass (gypsum) when mixed with water
    CaSO₄·½H₂O + 1½H₂O → CaSO₄·2H₂O

    **Uses:** Casts, molds, surgical bandages

    ### Gypsum - CaSO₄·2H₂O
    **Uses:** Manufacture of plaster of paris, cement retardant

    ### Magnesium Hydroxide - Mg(OH)₂ - Milk of Magnesia
    **Uses:** Antacid, laxative

    ### Magnesium Sulfate - MgSO₄·7H₂O - Epsom Salt
    **Uses:** Purgative, in tanning, dyeing

    ## Hardness of Water

    Water containing dissolved Ca²⁺ and Mg²⁺ salts is called **hard water**.

    ### Types of Hardness

    **1. Temporary Hardness (Carbonate hardness)**
    - Due to: Ca(HCO₃)₂, Mg(HCO₃)₂
    - **Removal:** Boiling
      - Ca(HCO₃)₂ → CaCO₃↓ + H₂O + CO₂
      - Mg(HCO₃)₂ → MgCO₃↓ + H₂O + CO₂
    - **Removal:** Clark's method (adding lime)
      - Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O

    **2. Permanent Hardness (Non-carbonate hardness)**
    - Due to: CaSO₄, CaCl₂, MgSO₄, MgCl₂
    - **Cannot be removed by boiling**
    - **Removal methods:**
      - **Washing soda:** Na₂CO₃ + CaSO₄ → CaCO₃↓ + Na₂SO₄
      - **Ion exchange resins:** Replace Ca²⁺, Mg²⁺ with Na⁺ or H⁺
      - **Calgon's method:** Sodium hexametaphosphate complexes Ca²⁺, Mg²⁺

    ## Flame Colors

    | Element | Flame Color |
    |---------|-------------|
    | Be | No distinct color |
    | Mg | No distinct color |
    | Ca | Brick red |
    | Sr | Crimson red |
    | Ba | Apple green |

    ## Biological Importance

    - **Mg²⁺:** Essential for chlorophyll (photosynthesis)
    - **Ca²⁺:** Bones, teeth, blood clotting, muscle contraction

    ## IIT JEE Key Points

    1. Alkaline earth metals have **two valence electrons** (ns²)
    2. **Reactivity increases** down the group
    3. **Beryllium is anomalous** (smallest size, covalent compounds)
    4. **Diagonal relationship:** Be resembles Al
    5. **Solubility of hydroxides increases** down the group
    6. **Solubility of sulfates decreases** down the group
    7. **Thermal stability of carbonates increases** down the group
    8. Hard water: Temporary (bicarbonates) vs Permanent (sulfates, chlorides)
    9. Plaster of Paris: CaSO₄·½H₂O (sets to gypsum)
    10. Flame colors: Ca (brick red), Sr (crimson), Ba (green)

## Key Points

- Alkaline earth metals

- Beryllium anomaly

- Calcium compounds
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Alkaline earth metals', 'Beryllium anomaly', 'Calcium compounds', 'Hardness of water'],
  prerequisite_ids: []
)

# === MICROLESSON 5: periodic_trends — Practice ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'periodic_trends — Practice',
  content: <<~MARKDOWN,
# periodic_trends — Practice 🚀

Ionization energy decreases down the group due to increasing atomic size. Lithium has the smallest atomic radius, so highest ionization energy among alkali metals.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['periodic_trends'],
  prerequisite_ids: []
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which alkali metal has the highest ionization energy?',
    options: ['Lithium', 'Sodium', 'Potassium', 'Cesium'],
    correct_answer: 0,
    explanation: 'Ionization energy decreases down the group due to increasing atomic size. Lithium has the smallest atomic radius, so highest ionization energy among alkali metals.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: anomalous_behavior — Practice ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'anomalous_behavior — Practice',
  content: <<~MARKDOWN,
# anomalous_behavior — Practice 🚀

Lithium is anomalous due to small size. It is hardest, Li₂CO₃ decomposes (Li₂CO₃ → Li₂O + CO₂), and LiNO₃ gives oxide (4LiNO₃ → 2Li₂O + 4NO₂ + O₂). Li forms only normal oxide (Li₂O), not superoxide.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['anomalous_behavior'],
  prerequisite_ids: []
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are anomalous properties of lithium?',
    options: ['It is the hardest alkali metal', 'It forms superoxide when heated in oxygen', 'Its carbonate decomposes on heating', 'Its nitrate gives oxide on heating (not nitrite)'],
    correct_answer: 3,
    explanation: 'Lithium is anomalous due to small size. It is hardest, Li₂CO₃ decomposes (Li₂CO₃ → Li₂O + CO₂), and LiNO₃ gives oxide (4LiNO₃ → 2Li₂O + 4NO₂ + O₂). Li forms only normal oxide (Li₂O), not superoxide.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 7: flame_colors — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'flame_colors — Practice',
  content: <<~MARKDOWN,
# flame_colors — Practice 🚀

Sodium gives golden yellow flame (589 nm). Li gives crimson red, K gives lilac, and Cs gives blue.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['flame_colors'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What color does sodium impart to the flame?',
    options: ['Crimson red', 'Golden yellow', 'Lilac', 'Blue'],
    correct_answer: 1,
    explanation: 'Sodium gives golden yellow flame (589 nm). Li gives crimson red, K gives lilac, and Cs gives blue.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: reducing_power — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'reducing_power — Practice',
  content: <<~MARKDOWN,
# reducing_power — Practice 🚀

In aqueous solution: Li > Na > K > Cs. Lithium is the strongest reducer due to high hydration enthalpy that compensates for its high ionization energy.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['reducing_power'],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following alkali metals in order of DECREASING reducing power in aqueous solution:',
    answer: '1,2,3,4',
    explanation: 'In aqueous solution: Li > Na > K > Cs. Lithium is the strongest reducer due to high hydration enthalpy that compensates for its high ionization energy.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: chemical_reactions — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_reactions — Practice',
  content: <<~MARKDOWN,
# chemical_reactions — Practice 🚀

Potassium forms superoxide (KO₂) when heated in excess oxygen. Lithium forms normal oxide (Li₂O), sodium forms peroxide (Na₂O₂), and heavier alkali metals (K, Rb, Cs) form superoxides.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['chemical_reactions'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'When potassium reacts with excess oxygen, it forms _______ (type of oxide).',
    answer: 'superoxide|KO2|potassium superoxide',
    explanation: 'Potassium forms superoxide (KO₂) when heated in excess oxygen. Lithium forms normal oxide (Li₂O), sodium forms peroxide (Na₂O₂), and heavier alkali metals (K, Rb, Cs) form superoxides.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: diagonal_relationship — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'diagonal_relationship — Practice',
  content: <<~MARKDOWN,
# diagonal_relationship — Practice 🚀

Li and Mg show diagonal relationship due to similar charge density. Both Li₂CO₃ and MgCO₃ decompose on heating. Both LiNO₃ and Mg(NO₃)₂ give oxides on heating. Neither forms superoxides, and both have low solubility compounds.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['diagonal_relationship'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Lithium shows diagonal relationship with magnesium. Which properties support this?',
    options: ['Both carbonates decompose on heating', 'Both form superoxides', 'Both nitrates give oxides on heating', 'Both are highly soluble in water'],
    correct_answer: 2,
    explanation: 'Li and Mg show diagonal relationship due to similar charge density. Both Li₂CO₃ and MgCO₃ decompose on heating. Both LiNO₃ and Mg(NO₃)₂ give oxides on heating. Neither forms superoxides, and both have low solubility compounds.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 11: chemical_equations — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_equations — Practice',
  content: <<~MARKDOWN,
# chemical_equations — Practice 🚀

2K + 2H₂O → 2KOH + H₂. All alkali metals react with water to form hydroxides and hydrogen gas. The reaction becomes more vigorous down the group.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['chemical_equations'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Balance the equation for the reaction of potassium with water:',
    answer: '2 K + 2 H2O -> 2 KOH + H2',
    explanation: '2K + 2H₂O → 2KOH + H₂. All alkali metals react with water to form hydroxides and hydrogen gas. The reaction becomes more vigorous down the group.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: chemical_properties — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_properties — Practice',
  content: <<~MARKDOWN,
# chemical_properties — Practice 🚀

TRUE. All alkali metal hydroxides (LiOH, NaOH, KOH, etc.) are strong bases because they completely dissociate in water. However, LiOH is relatively less basic than others.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['chemical_properties'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'All alkali metal hydroxides are strong bases.',
    answer: 'true',
    explanation: 'TRUE. All alkali metal hydroxides (LiOH, NaOH, KOH, etc.) are strong bases because they completely dissociate in water. However, LiOH is relatively less basic than others.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: physical_properties — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'physical_properties — Practice',
  content: <<~MARKDOWN,
# physical_properties — Practice 🚀

Potassium is less dense than sodium (K < Na) despite being below it in the group. This is anomalous because density generally increases down the group. The large increase in atomic volume of K overshadows the mass increase.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['physical_properties'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which alkali metal shows an anomalous trend in density?',
    options: ['Lithium - highest density', 'Potassium - less dense than sodium', 'Cesium - lowest density', 'No anomaly in density trend'],
    correct_answer: 1,
    explanation: 'Potassium is less dense than sodium (K < Na) despite being below it in the group. This is anomalous because density generally increases down the group. The large increase in atomic volume of K overshadows the mass increase.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: special_properties — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'special_properties — Practice',
  content: <<~MARKDOWN,
# special_properties — Practice 🚀

Alkali metals dissolve in liquid ammonia to give blue solutions due to ammoniated electrons [e(NH₃)ₓ]⁻. Concentrated solutions are bronze colored with metallic luster.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['special_properties'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Dilute solutions of alkali metals in liquid ammonia are _______ colored due to ammoniated electrons.',
    answer: 'blue',
    explanation: 'Alkali metals dissolve in liquid ammonia to give blue solutions due to ammoniated electrons [e(NH₃)ₓ]⁻. Concentrated solutions are bronze colored with metallic luster.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: anomalous_behavior — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'anomalous_behavior — Practice',
  content: <<~MARKDOWN,
# anomalous_behavior — Practice 🚀

Beryllium is anomalous due to small size and high charge density. BeO and Be(OH)₂ are amphoteric, BeCl₂ is covalent (polymeric). Be does NOT react with water (protective oxide layer), and BeSO₄ is soluble.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['anomalous_behavior'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are anomalous properties of beryllium?',
    options: ['BeO is amphoteric', 'BeCl₂ is covalent', 'Be reacts vigorously with water', 'BeSO₄ is insoluble in water'],
    correct_answer: 1,
    explanation: 'Beryllium is anomalous due to small size and high charge density. BeO and Be(OH)₂ are amphoteric, BeCl₂ is covalent (polymeric). Be does NOT react with water (protective oxide layer), and BeSO₄ is soluble.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: solubility_trends — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'solubility_trends — Practice',
  content: <<~MARKDOWN,
# solubility_trends — Practice 🚀

Solubility of sulfates DECREASES down the group: BaSO₄ < SrSO₄ < CaSO₄ < MgSO₄ < BeSO₄. BaSO₄ is almost insoluble (used in barium meal for X-rays).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['solubility_trends'],
  prerequisite_ids: []
)

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following sulfates in order of INCREASING solubility in water:',
    answer: '1,2,3,4',
    explanation: 'Solubility of sulfates DECREASES down the group: BaSO₄ < SrSO₄ < CaSO₄ < MgSO₄ < BeSO₄. BaSO₄ is almost insoluble (used in barium meal for X-rays).',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: important_compounds — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'important_compounds — Practice',
  content: <<~MARKDOWN,
# important_compounds — Practice 🚀

Plaster of Paris is calcium sulfate hemihydrate: CaSO₄·½H₂O or (CaSO₄)₂·H₂O. It is prepared by heating gypsum (CaSO₄·2H₂O) at 393 K.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['important_compounds'],
  prerequisite_ids: []
)

# Exercise 17.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The chemical formula of Plaster of Paris is _______.',
    answer: 'CaSO4.1/2H2O|CaSO₄·½H₂O|(CaSO4)2.H2O|CaSO4.0.5H2O',
    explanation: 'Plaster of Paris is calcium sulfate hemihydrate: CaSO₄·½H₂O or (CaSO₄)₂·H₂O. It is prepared by heating gypsum (CaSO₄·2H₂O) at 393 K.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 18: hardness_of_water — Practice ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'hardness_of_water — Practice',
  content: <<~MARKDOWN,
# hardness_of_water — Practice 🚀

Temporary hardness is caused by bicarbonates: Ca(HCO₃)₂ and Mg(HCO₃)₂. It can be removed by boiling. Permanent hardness is caused by sulfates and chlorides (CaSO₄, CaCl₂, MgSO₄, MgCl₂).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['hardness_of_water'],
  prerequisite_ids: []
)

# Exercise 18.2: MCQ
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following causes temporary hardness in water?',
    options: ['CaSO₄', 'Ca(HCO₃)₂', 'CaCl₂', 'MgSO₄'],
    correct_answer: 1,
    explanation: 'Temporary hardness is caused by bicarbonates: Ca(HCO₃)₂ and Mg(HCO₃)₂. It can be removed by boiling. Permanent hardness is caused by sulfates and chlorides (CaSO₄, CaCl₂, MgSO₄, MgCl₂).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 19: thermal_stability — Practice ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'thermal_stability — Practice',
  content: <<~MARKDOWN,
# thermal_stability — Practice 🚀

Thermal stability of carbonates INCREASES down the group: BeCO₃ < MgCO₃ < CaCO₃ < SrCO₃ < BaCO₃. Smaller cations have higher polarizing power, making the carbonate more unstable.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['thermal_stability'],
  prerequisite_ids: []
)

# Exercise 19.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Arrange the following carbonates in order of INCREASING thermal stability:',
    answer: '1,2,3,4',
    explanation: 'Thermal stability of carbonates INCREASES down the group: BeCO₃ < MgCO₃ < CaCO₃ < SrCO₃ < BaCO₃. Smaller cations have higher polarizing power, making the carbonate more unstable.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 20: flame_colors — Practice ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'flame_colors — Practice',
  content: <<~MARKDOWN,
# flame_colors — Practice 🚀

Barium gives apple green flame. Calcium gives brick red, Strontium gives crimson red, and Mg/Be don\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['flame_colors'],
  prerequisite_ids: []
)

# Exercise 20.2: MCQ
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which alkaline earth metal gives an apple green flame?',
    options: ['Calcium', 'Strontium', 'Barium', 'Magnesium'],
    correct_answer: 2,
    explanation: 'Barium gives apple green flame. Calcium gives brick red, Strontium gives crimson red, and Mg/Be don\',
    difficulty: 'easy'
  }
)

# === MICROLESSON 21: diagonal_relationship — Practice ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'diagonal_relationship — Practice',
  content: <<~MARKDOWN,
# diagonal_relationship — Practice 🚀

Be and Al show diagonal relationship. Both BeO and Al₂O₃ are amphoteric, both BeCl₂ and AlCl₃ are covalent and hygroscopic. Be does not react with water, and Be forms [Be(H₂O)₄]²⁺, not 6-coordinate.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['diagonal_relationship'],
  prerequisite_ids: []
)

# Exercise 21.2: MCQ
Exercise.create!(
  micro_lesson: lesson_21,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Beryllium shows diagonal relationship with aluminium. Which properties are similar?',
    options: ['Both oxides are amphoteric', 'Both chlorides are covalent and hygroscopic', 'Both react vigorously with water'],
    correct_answer: 1,
    explanation: 'Be and Al show diagonal relationship. Both BeO and Al₂O₃ are amphoteric, both BeCl₂ and AlCl₃ are covalent and hygroscopic. Be does not react with water, and Be forms [Be(H₂O)₄]²⁺, not 6-coordinate.',
    difficulty: 'hard'
  }
)

# === MICROLESSON 22: chemical_equations — Practice ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_equations — Practice',
  content: <<~MARKDOWN,
# chemical_equations — Practice 🚀

CaCO₃ → CaO + CO₂ (already balanced). This reaction occurs at high temperature (~1200 K) and is the basis for manufacturing quicklime from limestone.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['chemical_equations'],
  prerequisite_ids: []
)

# Exercise 22.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_22,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Balance the thermal decomposition of calcium carbonate:',
    answer: 'CaCO3 -> CaO + CO2',
    explanation: 'CaCO₃ → CaO + CO₂ (already balanced). This reaction occurs at high temperature (~1200 K) and is the basis for manufacturing quicklime from limestone.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 23: chemical_properties — Practice ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'chemical_properties — Practice',
  content: <<~MARKDOWN,
# chemical_properties — Practice 🚀

Basicity of hydroxides increases down the group: Be(OH)₂ < Mg(OH)₂ < Ca(OH)₂ < Sr(OH)₂ < Ba(OH)₂. Ba(OH)₂ is the strongest base. Be(OH)₂ is amphoteric.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['chemical_properties'],
  prerequisite_ids: []
)

# Exercise 23.2: MCQ
Exercise.create!(
  micro_lesson: lesson_23,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following is the strongest base?',
    options: ['Be(OH)₂', 'Mg(OH)₂', 'Ca(OH)₂', 'Ba(OH)₂'],
    correct_answer: 3,
    explanation: 'Basicity of hydroxides increases down the group: Be(OH)₂ < Mg(OH)₂ < Ca(OH)₂ < Sr(OH)₂ < Ba(OH)₂. Ba(OH)₂ is the strongest base. Be(OH)₂ is amphoteric.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 24: important_compounds — Practice ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'important_compounds — Practice',
  content: <<~MARKDOWN,
# important_compounds — Practice 🚀

Gypsum is CaSO₄·2H₂O (calcium sulfate dihydrate). When heated at 393 K, it loses 1.5 molecules of water to form Plaster of Paris (CaSO₄·½H₂O).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['important_compounds'],
  prerequisite_ids: []
)

# Exercise 24.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_24,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many water molecules of crystallization are present in gypsum (CaSO₄·xH₂O)? Enter the value of x.',
    answer: '2',
    explanation: 'Gypsum is CaSO₄·2H₂O (calcium sulfate dihydrate). When heated at 393 K, it loses 1.5 molecules of water to form Plaster of Paris (CaSO₄·½H₂O).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 25: hardness_of_water — Practice ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'hardness_of_water — Practice',
  content: <<~MARKDOWN,
# hardness_of_water — Practice 🚀

Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O. Clark\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['hardness_of_water'],
  prerequisite_ids: []
)

# Exercise 25.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_25,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Balance the equation for Clark\',
    answer: 'Ca(HCO3)2 + Ca(OH)2 -> 2 CaCO3 + 2 H2O',
    explanation: 'Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O. Clark\',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 26: anomalous_behavior — Practice ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'anomalous_behavior — Practice',
  content: <<~MARKDOWN,
# anomalous_behavior — Practice 🚀

TRUE. BeO is amphoteric. It reacts with acids: BeO + 2HCl → BeCl₂ + H₂O, and with bases: BeO + 2NaOH → Na₂BeO₂ + H₂O (sodium beryllate).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['anomalous_behavior'],
  prerequisite_ids: []
)

# Exercise 26.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_26,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Beryllium oxide (BeO) reacts with both acids and bases.',
    answer: 'true',
    explanation: 'TRUE. BeO is amphoteric. It reacts with acids: BeO + 2HCl → BeCl₂ + H₂O, and with bases: BeO + 2NaOH → Na₂BeO₂ + H₂O (sodium beryllate).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 27: hardness_of_water — Practice ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'hardness_of_water — Practice',
  content: <<~MARKDOWN,
# hardness_of_water — Practice 🚀

Permanent hardness (due to sulfates/chlorides) can be removed by: (1) Washing soda - Na₂CO₃ + CaSO₄ → CaCO₃↓ + Na₂SO₄, (2) Ion exchange resins, (3) Calgon\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['hardness_of_water'],
  prerequisite_ids: []
)

# Exercise 27.2: MCQ
Exercise.create!(
  micro_lesson: lesson_27,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which methods can remove permanent hardness of water?',
    options: ['Boiling', 'Adding washing soda (Na₂CO₃)', 'Ion exchange resins', 'Adding slaked lime'],
    correct_answer: 2,
    explanation: 'Permanent hardness (due to sulfates/chlorides) can be removed by: (1) Washing soda - Na₂CO₃ + CaSO₄ → CaCO₃↓ + Na₂SO₄, (2) Ion exchange resins, (3) Calgon\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 28: biological_importance — Practice ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'biological_importance — Practice',
  content: <<~MARKDOWN,
# biological_importance — Practice 🚀

Magnesium is present at the center of chlorophyll molecule, which is essential for photosynthesis. Calcium is important for bones and teeth.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['biological_importance'],
  prerequisite_ids: []
)

# Exercise 28.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_28,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Magnesium is an essential component of _______, which is responsible for photosynthesis in plants.',
    answer: 'chlorophyll',
    explanation: 'Magnesium is present at the center of chlorophyll molecule, which is essential for photosynthesis. Calcium is important for bones and teeth.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 29: Group 1 - Alkali Metals (Li, Na, K, Rb, Cs, Fr) ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'Group 1 - Alkali Metals (Li, Na, K, Rb, Cs, Fr)',
  content: <<~MARKDOWN,
# Group 1 - Alkali Metals (Li, Na, K, Rb, Cs, Fr) 🚀

# Group 1 - Alkali Metals

    ## Introduction

    Group 1 elements are called **alkali metals** because they form alkalis (strong bases) when they react with water.

    **Members:** Lithium (Li), Sodium (Na), Potassium (K), Rubidium (Rb), Cesium (Cs), Francium (Fr)

    ## Electronic Configuration

    All alkali metals have **one valence electron** in their outermost s-orbital.

    - Li: [He] 2s¹
    - Na: [Ne] 3s¹
    - K: [Ar] 4s¹
    - Rb: [Kr] 5s¹
    - Cs: [Xe] 6s¹
    - Fr: [Rn] 7s¹

    This single valence electron makes them highly reactive and gives them similar chemical properties.

    ## Physical Properties

    ### Atomic and Ionic Radii
    - **Increase down the group:** Li < Na < K < Rb < Cs < Fr
    - Reason: Addition of new electron shells
    - Alkali metals have the **largest atomic radii** in their respective periods

    ### Ionization Energy (IE)
    - **Decreases down the group:** Li > Na > K > Rb > Cs > Fr
    - Reason: Increasing atomic size, valence electron farther from nucleus
    - Alkali metals have the **lowest ionization energies** in their periods
    - Easy to lose the valence electron → +1 oxidation state

    ### Electronegativity
    - **Decreases down the group:** Li > Na > K > Rb > Cs > Fr
    - Very low electronegativity (highly electropositive)

    ### Density
    - Generally **increases down the group**
    - Exception: K < Na (due to large increase in atomic size)
    - Li, Na, K are less dense than water

    ### Melting and Boiling Points
    - **Decrease down the group:** Li > Na > K > Rb > Cs > Fr
    - Reason: Weaker metallic bonding with increasing size
    - Alkali metals are soft and have low melting points

    ### Physical State and Appearance
    - All are soft, silvery-white metals
    - Can be cut with a knife
    - Freshly cut surface is shiny but tarnishes quickly in air

    ## Chemical Properties

    ### 1. Reaction with Oxygen

    All alkali metals react vigorously with oxygen, but products differ:

    **Lithium (Normal oxide):**
    4Li + O₂ → 2Li₂O (Lithium oxide)

    **Sodium (Peroxide):**
    2Na + O₂ → Na₂O₂ (Sodium peroxide)

    **K, Rb, Cs (Superoxide):**
    K + O₂ → KO₂ (Potassium superoxide)

    **Trend:** Normal oxide → Peroxide → Superoxide (down the group)

    ### 2. Reaction with Water

    All alkali metals react with water to form hydroxides and hydrogen gas:

    2M + 2H₂O → 2MOH + H₂↑

    **Reactivity increases down the group:** Li < Na < K < Rb < Cs

    - Li: Reacts steadily, floats
    - Na: Reacts vigorously, melts into a ball, floats
    - K: Reacts violently, catches fire (lilac flame), floats
    - Rb, Cs: Explosive reaction

    ### 3. Reaction with Halogens

    Form ionic halides (MX):

    2M + X₂ → 2MX

    - Highly exothermic reactions
    - Reactivity: F₂ > Cl₂ > Br₂ > I₂

    ### 4. Reaction with Hydrogen

    Form ionic hydrides (MH):

    2M + H₂ → 2MH (at high temperature)

    - These are strong reducing agents
    - Example: LiH, NaH

    ### 5. Reducing Nature

    Alkali metals are **strong reducing agents**.

    **Reducing power:** Li > Na > K > Rb > Cs (in aqueous solution)

    **Why is Li the strongest reducer?**
    - High hydration enthalpy due to small size
    - Compensates for high ionization energy

    ## Flame Colors

    Alkali metals impart characteristic colors to flame:

    | Element | Flame Color | Wavelength Range |
    |---------|-------------|------------------|
    | Li | Crimson red | 670 nm |
    | Na | Golden yellow | 589 nm |
    | K | Lilac/Violet | 766 nm |
    | Rb | Red-violet | - |
    | Cs | Blue | - |

    **Reason:** Excitation of valence electron by heat energy

    ## Solutions in Liquid Ammonia

    Alkali metals dissolve in liquid ammonia to form blue solutions:

    M + (x+y)NH₃ → [M(NH₃)ₓ]⁺ + [e(NH₃)ᵧ]⁻

    - Dilute solutions: Blue color (due to ammoniated electrons)
    - Concentrated solutions: Bronze color (metallic luster)
    - Solutions are good conductors of electricity
    - Paramagnetic due to unpaired electrons

    ## Anomalous Properties of Lithium

    Lithium differs from other alkali metals due to its **small size** and **high charge density**:

    1. **Hardest** alkali metal
    2. **Highest melting and boiling points**
    3. **Least reactive** with water
    4. Forms **covalent compounds** (e.g., LiCl has some covalent character)
    5. **Decomposes on heating:** 4LiNO₃ → 2Li₂O + 4NO₂ + O₂ (other alkali metal nitrates give nitrites)
    6. **LiOH is less basic** than other alkali metal hydroxides
    7. **Li₂CO₃ decomposes on heating** (others don't)
    8. **Does not form superoxide** (only normal oxide)

    ## Diagonal Relationship: Li and Mg

    Lithium shows similarity with Magnesium (diagonal element) due to similar charge/size ratio:

    | Property | Similarity |
    |----------|-----------|
    | Hardness | Both are harder than group members |
    | Carbonate | Both carbonates decompose on heating |
    | Nitrate | Both nitrates give oxides on heating |
    | Hydroxide | Both hydroxides are weak bases |
    | Bicarbonate | Neither forms solid bicarbonates |
    | Organometallic | Both form organometallic compounds |

    ## Important Compounds of Alkali Metals

    ### Sodium Hydroxide (NaOH) - Caustic Soda
    - **Preparation:** Chlor-alkali process (electrolysis of brine)
    - **Uses:** Soap making, paper industry, petroleum refining

    ### Sodium Carbonate (Na₂CO₃·10H₂O) - Washing Soda
    - **Preparation:** Solvay process (ammonia-soda process)
    - **Uses:** Water softening, glass manufacturing, cleaning

    ### Sodium Bicarbonate (NaHCO₃) - Baking Soda
    - **Preparation:** From washing soda and CO₂
    - **Uses:** Baking powder, antacid, fire extinguisher

    ### Sodium Chloride (NaCl) - Common Salt
    - **Source:** Sea water, rock salt
    - **Uses:** Food preservation, raw material for chemicals

    ### Sodium Thiosulfate (Na₂S₂O₃·5H₂O) - Hypo
    - **Uses:** Photography (fixing agent), dechlorination

    ## IIT JEE Key Points

    1. Alkali metals have **one valence electron** (ns¹)
    2. **Reactivity increases** down the group (Li < Na < K < Rb < Cs)
    3. **Reducing power in solution:** Li > Na > K > Rb > Cs
    4. Flame colors: Li (crimson), Na (yellow), K (lilac)
    5. **Lithium is anomalous** due to small size
    6. **Diagonal relationship:** Li resembles Mg
    7. Oxide formation: Li (oxide), Na (peroxide), K/Rb/Cs (superoxide)
    8. All form **ionic compounds** (except Li shows some covalent character)

## Key Points

- Alkali metals

- Electronic configuration

- Physical properties
  MARKDOWN
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Alkali metals', 'Electronic configuration', 'Physical properties', 'Chemical reactivity', 'Flame colors'],
  prerequisite_ids: []
)

puts "✓ Created 29 microlessons for S Block Elements"

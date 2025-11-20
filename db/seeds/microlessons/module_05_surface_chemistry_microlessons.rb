# AUTO-GENERATED from module_05_surface_chemistry.rb
puts "Creating Microlessons for Surface Chemistry..."

module_var = CourseModule.find_by(slug: 'surface-chemistry')

# === MICROLESSON 1: detergents — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'detergents — Practice',
  content: <<~MARKDOWN,
# detergents — Practice 🚀

Detergents (sulfonic acid salts) do not form insoluble precipitates with Ca²⁺ and Mg²⁺ ions in hard water, unlike soaps which form scum.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['detergents'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why do detergents work better than soaps in hard water?',
    options: ['They do not form insoluble salts with Ca²⁺ and Mg²⁺', 'They have stronger cleansing action in soft water only', 'They do not form micelles', 'They have shorter hydrocarbon chains'],
    correct_answer: 0,
    explanation: 'Detergents (sulfonic acid salts) do not form insoluble precipitates with Ca²⁺ and Mg²⁺ ions in hard water, unlike soaps which form scum.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: Catalysis - Types and Mechanisms ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Catalysis - Types and Mechanisms',
  content: <<~MARKDOWN,
# Catalysis - Types and Mechanisms 🚀

# Catalysis

    ## Introduction

    **Catalyst:** A substance that alters the rate of a chemical reaction without being consumed in the process.

    **Catalysis:** The phenomenon of altering the rate of reaction using a catalyst.

    ---

    ## Types of Catalysis

    ### 1. Positive Catalysis
    - Catalyst **increases** the rate of reaction
    - Most common type
    - **Example:** MnO₂ in decomposition of KClO₃

    ### 2. Negative Catalysis (Inhibition)
    - Catalyst **decreases** the rate of reaction
    - **Example:** Phosphoric acid retards decomposition of H₂O₂

    ### 3. Auto-catalysis
    - Product of reaction acts as catalyst
    - **Example:** CH₃COOC₂H₅ + H₂O → CH₃COOH + C₂H₅OH (CH₃COOH catalyzes the reaction)

    ---

    ## Classification Based on Phase

    ### Homogeneous Catalysis

    **Definition:** Catalyst and reactants are in the same phase.

    **Characteristics:**
    - Usually in liquid or gas phase
    - Catalyst uniformly distributed
    - High selectivity

    **Examples:**

    1. **Lead chamber process (SO₂ oxidation):**
       ```
       2SO₂(g) + O₂(g) --[NO(g)]--> 2SO₃(g)
       ```

    2. **Esterification:**
       ```
       CH₃COOH(l) + C₂H₅OH(l) --[H₂SO₄(l)]--> CH₃COOC₂H₅(l) + H₂O(l)
       ```

    3. **Hydrolysis of esters:**
       ```
       CH₃COOC₂H₅ + H₂O --[H⁺ or OH⁻]--> CH₃COOH + C₂H₅OH
       ```

    4. **Inversion of cane sugar:**
       ```
       C₁₂H₂₂O₁₁ + H₂O --[H⁺]--> C₆H₁₂O₆ + C₆H₁₂O₆
       ```

    ### Heterogeneous Catalysis

    **Definition:** Catalyst and reactants are in different phases.

    **Characteristics:**
    - Catalyst is usually solid, reactants are gas or liquid
    - Reaction occurs on catalyst surface
    - Surface area is important

    **Examples:**

    1. **Haber process (Ammonia synthesis):**
       ```
       N₂(g) + 3H₂(g) --[Fe(s)]--> 2NH₃(g)
       ```

    2. **Ostwald process (Oxidation of ammonia):**
       ```
       4NH₃(g) + 5O₂(g) --[Pt(s)]--> 4NO(g) + 6H₂O(g)
       ```

    3. **Contact process (SO₃ production):**
       ```
       2SO₂(g) + O₂(g) --[V₂O₅(s)]--> 2SO₃(g)
       ```

    4. **Hydrogenation of vegetable oils:**
       ```
       Vegetable oil + H₂ --[Ni(s)]--> Vanaspati ghee
       ```

    5. **Deacon's process (Chlorine production):**
       ```
       4HCl(g) + O₂(g) --[CuCl₂(s)]--> 2Cl₂(g) + 2H₂O(g)
       ```

    | Homogeneous | Heterogeneous |
    |-------------|---------------|
    | Same phase | Different phases |
    | Uniformly distributed | Localized at interface |
    | Example: NO in SO₂ oxidation | Example: Fe in Haber process |

    ---

    ## Mechanism of Heterogeneous Catalysis

    **Steps:**

    1. **Diffusion:** Reactant molecules diffuse to catalyst surface
    2. **Adsorption:** Reactants are adsorbed on catalyst surface (chemisorption)
    3. **Reaction:** Adsorbed molecules react on surface (activation energy lowered)
    4. **Desorption:** Products desorb from surface
    5. **Diffusion:** Products diffuse away from surface

    **Active sites:** Specific locations on catalyst surface where reaction occurs

    ---

    ## Important Features of Catalysis

    ### 1. Catalyst Remains Unchanged
    - Mass and chemical composition remain same
    - May undergo temporary physical/chemical change

    ### 2. Small Amount Required
    - Catalyst works in very small quantities
    - Effect depends on surface area, not mass

    ### 3. Catalyst Cannot Initiate Reaction
    - Can only alter rate of thermodynamically feasible reactions
    - Cannot make impossible reactions possible

    ### 4. Catalyst is Specific
    - A given catalyst works for specific reactions only
    - Example: MnO₂ catalyzes KClO₃ decomposition but not others

    ### 5. Catalyst Does Not Alter Equilibrium
    - Increases both forward and backward reaction rates equally
    - Position of equilibrium remains same
    - Equilibrium is attained faster

    ### 6. Catalyst Lowers Activation Energy
    - Provides alternate pathway with lower Ea
    - More molecules have energy ≥ Ea
    - Rate increases

    ---

    ## Promoters and Catalytic Poisons

    ### Promoters (Co-catalysts)
    - Substances that enhance catalyst activity
    - **Example:** In Haber process, Fe is catalyst, Mo acts as promoter

    ### Catalytic Poisons
    - Substances that reduce or destroy catalyst activity
    - **Example:**
      - Arsenic poisoning of Pt catalyst in Contact process
      - CO poisoning of Fe catalyst in Haber process
      - Lead poisoning of catalytic converters

    ---

    ## Enzyme Catalysis

    **Enzymes:** Biological catalysts (proteins) in living organisms

    **Characteristics:**
    - Highly specific (lock and key mechanism)
    - Work under mild conditions (body temperature, neutral pH)
    - Very efficient (increase rate by 10⁶ to 10²⁰ times)
    - Sensitive to temperature and pH

    **Examples:**
    - **Invertase:** Converts cane sugar to glucose and fructose
    - **Maltase:** Converts maltose to glucose
    - **Urease:** Converts urea to ammonia and CO₂
    - **Pepsin:** Digests proteins in stomach
    - **Amylase:** Converts starch to maltose

    **Mechanism:**
    ```
    Enzyme (E) + Substrate (S) ⇌ E-S complex → E + Product (P)
    ```

    ---

    ## Zeolites as Catalysts

    **Zeolites:** Microporous aluminosilicate minerals with shape-selective catalysis

    **Structure:**
    - 3D network of SiO₄ and AlO₄ tetrahedra
    - Contains cavities and channels of molecular dimensions

    **Applications:**
    - Petroleum refining (catalytic cracking)
    - Petrochemical industry
    - Conversion of alcohols to gasoline
    - **ZSM-5:** Used to convert methanol to gasoline

    **Shape Selectivity:** Only molecules of certain size and shape can enter pores and react

    ---

    ## IIT JEE Key Points

    1. Catalyst **does not alter ΔG** or equilibrium position
    2. Catalyst **lowers activation energy** (Ea)
    3. **Heterogeneous catalysis:** Adsorption → Reaction → Desorption
    4. **Homogeneous:** Same phase; **Heterogeneous:** Different phases
    5. **Promoters** enhance catalyst activity
    6. **Poisons** reduce catalyst activity
    7. **Enzymes** are highly specific biological catalysts
    8. **Zeolites** show shape-selective catalysis
    9. Catalyst increases rate of **both forward and backward** reactions equally

## Key Points

- Catalysis

- Homogeneous catalysis

- Heterogeneous catalysis
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Catalysis', 'Homogeneous catalysis', 'Heterogeneous catalysis', 'Enzyme catalysis', 'Catalyst poisoning'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Colloidal Systems - Properties and Classification ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Colloidal Systems - Properties and Classification',
  content: <<~MARKDOWN,
# Colloidal Systems - Properties and Classification 🚀

# Colloidal Systems

    ## Introduction

    **Colloidal solution (or sol):** A heterogeneous mixture where particle size is intermediate between true solution and suspension.

    **Particle size:**
    - True solution: < 1 nm
    - Colloidal solution: 1-1000 nm (1-100 nm typically)
    - Suspension: > 1000 nm

    **Components:**
    - **Dispersed phase:** Substance distributed as particles (like solute)
    - **Dispersion medium:** Medium in which particles are dispersed (like solvent)

    ---

    ## Classification of Colloids

    ### Based on Physical State

    | Dispersed Phase | Dispersion Medium | Name | Example |
    |-----------------|-------------------|------|---------|
    | Solid | Solid | Solid sol | Colored glasses, gemstones |
    | Solid | Liquid | Sol | Paint, ink, gold sol |
    | Solid | Gas | Aerosol | Smoke, dust in air |
    | Liquid | Solid | Gel | Jellies, cheese, butter |
    | Liquid | Liquid | Emulsion | Milk, mayonnaise |
    | Liquid | Gas | Aerosol | Fog, mist, cloud |
    | Gas | Solid | Solid foam | Pumice stone, foam rubber |
    | Gas | Liquid | Foam | Soap foam, whipped cream |

    **Note:** Gas-gas mixtures are always homogeneous (true solutions), never colloidal.

    ### Based on Nature of Interaction

    #### 1. Lyophilic Colloids (Solvent-loving)
    - Strong interaction between dispersed phase and medium
    - Directly formed by mixing with solvent
    - **Reversible:** Can be reconstituted after evaporation
    - **Stable:** Not easily coagulated
    - **Examples:** Starch, gelatin, rubber, proteins in water

    #### 2. Lyophobic Colloids (Solvent-hating)
    - Weak or no interaction between dispersed phase and medium
    - Not directly formed, need special methods
    - **Irreversible:** Cannot be reconstituted
    - **Unstable:** Easily coagulated
    - **Examples:** Metal sols (gold, silver), sulfur sol, As₂S₃ sol

    **If water is the medium:**
    - Lyophilic → Hydrophilic
    - Lyophobic → Hydrophobic

    ### Based on Type of Particles

    #### 1. Multimolecular Colloids
    - Large number of atoms/molecules aggregate together
    - Size in colloidal range
    - **Example:** Gold sol, sulfur sol

    #### 2. Macromolecular Colloids
    - Individual large molecules (macromolecules)
    - Size naturally in colloidal range
    - **Example:** Proteins, starch, cellulose, polymers

    #### 3. Associated Colloids (Micelles)
    - Formed by aggregation of small molecules above a certain concentration
    - **CMC (Critical Micelle Concentration):** Minimum concentration for micelle formation
    - **Kraft Temperature:** Minimum temperature for micelle formation
    - **Example:** Soaps, detergents

    ---

    ## Preparation of Colloids

    ### Dispersion Methods (Breaking down larger particles)

    #### 1. Mechanical Dispersion
    - Grinding substance with dispersion medium in colloid mill
    - **Example:** Preparation of colloidal solutions of dyes

    #### 2. Electrical Dispersion (Bredig's Arc Method)
    - Electric arc struck between metal electrodes under water
    - Metal vaporizes and condenses to colloidal particles
    - **Example:** Preparation of gold, silver, platinum sols

    #### 3. Peptization
    - Process of converting precipitate into colloid by adding electrolyte (peptizing agent)
    - Electrolyte gets preferentially adsorbed
    - **Example:** Fresh Fe(OH)₃ precipitate + FeCl₃ → Fe(OH)₃ sol

    ### Condensation Methods (Building up from smaller particles)

    #### 1. Chemical Methods

    **Oxidation:**
    ```
    2H₂S + SO₂ → 3S (sol) + 2H₂O
    ```

    **Reduction:**
    ```
    2AuCl₃ + 3HCHO + 3H₂O → 2Au (sol) + 3HCOOH + 6HCl
    ```

    **Hydrolysis:**
    ```
    FeCl₃ + 3H₂O → Fe(OH)₃ (sol) + 3HCl
    ```

    **Double decomposition:**
    ```
    As₂O₃ + 3H₂S → As₂S₃ (sol) + 3H₂O
    ```

    #### 2. Change of Solvent
    - Dissolve substance in one solvent
    - Pour into another solvent where it's less soluble
    - **Example:** Sulfur sol by pouring alcoholic sulfur solution into water

    ---

    ## Properties of Colloids

    ### 1. Heterogeneous Nature
    - Colloids are heterogeneous (two phases)
    - But appear homogeneous to naked eye

    ### 2. Filterability
    - Pass through ordinary filter paper
    - Do not pass through parchment or cellophane (semi-permeable membrane)
    - **Dialysis:** Purification of colloids by removing dissolved substances

    ### 3. Colligative Properties
    - Exhibit colligative properties
    - But much smaller than true solutions (fewer particles per unit mass)

    ### 4. Tyndall Effect
    - Scattering of light by colloidal particles
    - Path of light becomes visible
    - **Not shown by true solutions** (particles too small)
    - **Example:** Beam of light in a dusty room, car headlights in fog

    ### 5. Brownian Motion
    - Random, zig-zag motion of colloidal particles
    - Due to unequal bombardment by molecules of dispersion medium
    - Prevents settling of particles under gravity
    - Observed under ultramicroscope

    ### 6. Charge on Colloidal Particles
    - All particles in a given colloid have same charge
    - Prevents aggregation (repulsion)
    - **Positive sols:** Fe(OH)₃, Al(OH)₃, metal sols
    - **Negative sols:** As₂S₃, sulfur sol, gold sol, starch, gums

    ### 7. Electrophoresis
    - Movement of colloidal particles under electric field
    - Positive particles move to cathode (negative electrode)
    - Negative particles move to anode (positive electrode)
    - **Applications:** Determination of charge, purification

    ### 8. Coagulation or Flocculation
    - Settling down of colloidal particles
    - Achieved by:
      - **Adding electrolytes** (most effective)
      - Heating
      - Mixing oppositely charged sols
    - **Hardy-Schulze Rule:** Greater the valence of coagulating ion, greater its coagulating power
    - For negative sols: Al³⁺ > Ba²⁺ > Na⁺
    - For positive sols: [Fe(CN)₆]⁴⁻ > PO₄³⁻ > SO₄²⁻ > Cl⁻

    ---

    ## Protection of Colloids

    **Protective Colloids:** Lyophilic colloids added to lyophobic sols to prevent coagulation

    **Example:** Gelatin added to gold sol

    **Gold Number:** Minimum mass (in mg) of protective colloid required to prevent coagulation of 10 mL of gold sol by 1 mL of 10% NaCl solution

    - **Lower gold number = Better protective action**

    ---

    ## Applications of Colloids

    1. **Purification of water:** Alum coagulates suspended impurities
    2. **Medicines:** Colloidal silver (Argyrol) as antiseptic
    3. **Smoke precipitation:** Cottrell precipitator
    4. **Artificial rain:** Cloud seeding with AgI
    5. **Photography:** Silver bromide in gelatin
    6. **Food industry:** Ice cream, whipped cream
    7. **Rubber industry:** Latex is colloidal
    8. **Cleansing action of soaps**

    ---

    ## IIT JEE Key Points

    1. Colloidal particle size: **1-1000 nm** (typically 1-100 nm)
    2. **Tyndall effect:** Scattering of light by colloidal particles
    3. **Brownian motion:** Random motion preventing settling
    4. **Electrophoresis:** Movement under electric field
    5. **Hardy-Schulze rule:** Higher charge → Greater coagulating power
    6. **Lyophilic:** Reversible, stable; **Lyophobic:** Irreversible, unstable
    7. **Peptization:** Precipitate → Colloid (with electrolyte)
    8. **Gold number:** Lower value = Better protection
    9. Gas-gas mixtures are **never colloidal**

## Key Points

- Colloids

- Classification

- Preparation
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Colloids', 'Classification', 'Preparation', 'Properties', 'Tyndall effect', 'Brownian motion'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Emulsions and Micelles ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Emulsions and Micelles',
  content: <<~MARKDOWN,
# Emulsions and Micelles 🚀

# Emulsions and Micelles

    ## Emulsions

    **Emulsion:** Colloidal system where both dispersed phase and dispersion medium are liquids.

    - Both liquids must be immiscible
    - One liquid is dispersed in another as droplets

    ---

    ## Types of Emulsions

    ### 1. Oil-in-Water (O/W) Emulsion
    - **Dispersed phase:** Oil
    - **Dispersion medium:** Water
    - **Examples:**
      - Milk (fat in water)
      - Vanishing cream
      - Cod liver oil

    ### 2. Water-in-Oil (W/O) Emulsion
    - **Dispersed phase:** Water
    - **Dispersion medium:** Oil
    - **Examples:**
      - Butter
      - Cold cream
      - Cod liver oil

    | Property | O/W Emulsion | W/O Emulsion |
    |----------|--------------|--------------|
    | Dispersed phase | Oil | Water |
    | Dispersion medium | Water | Oil |
    | Dilution | With water | With oil |
    | Conductivity | Conducts electricity | Does not conduct |
    | Example | Milk | Butter |

    ---

    ## Tests to Identify Emulsion Type

    ### 1. Dilution Test
    - **O/W:** Can be diluted with water
    - **W/O:** Can be diluted with oil

    ### 2. Conductivity Test
    - **O/W:** Conducts electricity (water conducts)
    - **W/O:** Does not conduct (oil doesn't conduct)

    ### 3. Dye Test
    - **O/W:** Water-soluble dye colors the emulsion
    - **W/O:** Oil-soluble dye colors the emulsion

    ---

    ## Emulsifying Agents (Emulsifiers)

    **Function:** Stabilize emulsions by forming interfacial film between two liquids

    **Types:**

    1. **Lyophilic colloids:** Gelatin, albumin, casein
    2. **Surface active agents:** Soaps, detergents
    3. **Finely divided solids:** Lampblack, clay

    **Mechanism:**
    - Molecules have hydrophilic (water-loving) and hydrophobic (water-hating) parts
    - Form protective layer around droplets
    - Prevent coalescence

    ---

    ## Applications of Emulsions

    1. **Medicines:** Cod liver oil, liquid paraffin
    2. **Cosmetics:** Cold cream, vanishing cream
    3. **Food:** Milk, butter, ice cream
    4. **Paints:** Oil-based paints
    5. **Disinfectants:** Phenol emulsions
    6. **Asphalt emulsions:** Road surfacing

    ---

    ## Demulsification

    **Process of breaking emulsion into constituent liquids**

    **Methods:**
    1. **Heating:** Destroys emulsifying agent
    2. **Freezing:** Ice crystals break emulsion
    3. **Centrifugation:** Separates by density
    4. **Chemical methods:** Adding electrolytes, changing pH
    5. **Addition of opposite type emulsifier**

    **Example:** Cream separation from milk by centrifugation

    ---

    ## Micelles

    **Micelle:** Aggregate of surfactant molecules in colloidal dimensions

    ### Surfactants (Surface Active Agents)

    **Structure:**
    - **Hydrophilic head:** Polar, water-loving (COO⁻, SO₃⁻, SO₄⁻)
    - **Hydrophobic tail:** Non-polar, water-hating (long hydrocarbon chain)

    **Example - Soap (RCOO⁻Na⁺):**
    - Hydrophilic: COO⁻ group
    - Hydrophobic: Long alkyl chain (R)

    ### Micelle Formation

    **In water:**
    - Hydrophobic tails point inward
    - Hydrophilic heads point outward toward water
    - Forms spherical aggregate

    **Critical Micelle Concentration (CMC):**
    - Minimum concentration at which micelles form
    - Below CMC: Individual molecules
    - Above CMC: Micelles form

    **Kraft Temperature:**
    - Minimum temperature for micelle formation
    - Below this, surfactant precipitates

    ---

    ## Cleansing Action of Soaps

    **Mechanism:**

    1. **Soap dissolves in water** and forms micelles (above CMC)

    2. **Hydrophobic tails** dissolve in grease/oil on fabric
       **Hydrophilic heads** remain in water

    3. **Mechanical action** (rubbing) breaks up oil into droplets

    4. **Micelles surround oil droplets** with tails inside oil and heads outside in water

    5. **Repulsion between negatively charged heads** keeps droplets dispersed (emulsion)

    6. **Rinsing with water** removes emulsified oil droplets

    **Why soap doesn't work in hard water:**
    - Hard water contains Ca²⁺, Mg²⁺ ions
    - Forms insoluble salts: 2RCOO⁻Na⁺ + Ca²⁺ → (RCOO)₂Ca + 2Na⁺
    - These precipitate as scum, reducing cleansing action

    ---

    ## Detergents

    **Synthetic detergents:** Sodium salts of long-chain sulfonic acids or alkyl hydrogen sulfates

    **Structure:**
    - Example: Sodium lauryl sulfate (CH₃(CH₂)₁₁OSO₃⁻Na⁺)
    - Long hydrocarbon chain + sulfate group

    **Advantages over soaps:**

    1. **Work in hard water:** Don't form insoluble salts with Ca²⁺, Mg²⁺
    2. **Work in acidic solutions:** Don't precipitate
    3. **Stronger cleansing action**
    4. **Better solubility in water**

    **Types:**

    1. **Anionic detergents:**
       - Negatively charged (SO₃⁻, SO₄⁻)
       - Example: Sodium dodecyl benzene sulfonate
       - Best for removing oily dirt

    2. **Cationic detergents:**
       - Positively charged (NH₄⁺)
       - Example: Cetyltrimethylammonium bromide
       - Used as germicides, antiseptics

    3. **Non-ionic detergents:**
       - No charge
       - Example: Polyethylene glycol stearate
       - Used in dishwashing liquids

    **Disadvantage:** Some detergents are not biodegradable, causing water pollution

    ---

    ## IIT JEE Key Points

    1. **Emulsion:** Liquid in liquid colloidal system
    2. **O/W emulsion:** Can be diluted with water, conducts electricity
    3. **W/O emulsion:** Can be diluted with oil, doesn't conduct
    4. **Emulsifier:** Stabilizes emulsion (gelatin, soap)
    5. **Micelles:** Form above CMC and Kraft temperature
    6. **Soap structure:** Hydrophilic head (COO⁻) + Hydrophobic tail (alkyl chain)
    7. **Cleansing:** Micelles surround oil, emulsification occurs
    8. **Hard water:** Forms scum with soap (Ca²⁺/Mg²⁺ salts)
    9. **Detergents:** Work in hard water, more versatile than soaps

## Key Points

- Emulsions

- Emulsifying agents

- Types of emulsions
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Emulsions', 'Emulsifying agents', 'Types of emulsions', 'Micelles', 'Soaps and detergents'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Adsorption - Types and Mechanisms ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Adsorption - Types and Mechanisms',
  content: <<~MARKDOWN,
# Adsorption - Types and Mechanisms 🚀

# Adsorption

    ## Introduction

    **Adsorption** is the phenomenon of accumulation of molecules of a substance on the surface of a solid or liquid, forming a molecular or atomic film.

    - **Adsorbate:** The substance that gets adsorbed
    - **Adsorbent:** The surface on which adsorption occurs

    **Examples:**
    - Activated charcoal adsorbs gases
    - Silica gel adsorbs moisture
    - Animal charcoal decolorizes sugar solutions

    ## Adsorption vs Absorption

    | Adsorption | Absorption |
    |------------|------------|
    | Surface phenomenon | Bulk phenomenon |
    | Concentration on surface | Uniform distribution throughout |
    | Example: Gas on charcoal | Example: Water in sponge |

    **Sorption:** When both adsorption and absorption occur simultaneously

    ---

    ## Types of Adsorption

    ### 1. Physical Adsorption (Physisorption)

    **Characteristics:**
    - **Forces:** Weak van der Waals forces
    - **Heat of adsorption:** Low (20-40 kJ/mol)
    - **Temperature:** Occurs at low temperatures
    - **Reversibility:** Easily reversible
    - **Specificity:** Non-specific (any gas can be adsorbed)
    - **Layer formation:** Can form multi-molecular layers
    - **Activation energy:** Not required

    **Example:** Adsorption of N₂ on iron at low temperature

    ### 2. Chemical Adsorption (Chemisorption)

    **Characteristics:**
    - **Forces:** Strong chemical bonds (covalent/ionic)
    - **Heat of adsorption:** High (80-400 kJ/mol)
    - **Temperature:** Occurs at high temperatures
    - **Reversibility:** Irreversible
    - **Specificity:** Highly specific
    - **Layer formation:** Forms unimolecular layer only
    - **Activation energy:** Required

    **Example:** Adsorption of H₂ on nickel

    | Property | Physisorption | Chemisorption |
    |----------|---------------|---------------|
    | Nature of forces | Van der Waals | Chemical bonds |
    | Heat of adsorption | 20-40 kJ/mol | 80-400 kJ/mol |
    | Temperature | Low temperature favored | High temperature favored |
    | Reversibility | Reversible | Irreversible |
    | Specificity | Non-specific | Highly specific |
    | Layers | Multi-layer | Mono-layer |
    | Activation energy | Not required | Required |

    ---

    ## Factors Affecting Adsorption

    ### 1. Nature of Adsorbent
    - **Surface area:** Greater surface area → More adsorption
    - **Porosity:** Porous materials have higher adsorption capacity
    - **Activation:** Activated charcoal has very high surface area

    ### 2. Nature of Adsorbate
    - **Easily liquefiable gases** (high critical temperature) are easily adsorbed
    - Order: NH₃ > SO₂ > HCl > CO₂ > CH₄ > H₂ > N₂
    - Polar molecules are preferentially adsorbed over non-polar

    ### 3. Temperature
    - **Physisorption:** Decreases with increasing temperature (exothermic)
    - **Chemisorption:** Initially increases, then decreases

    ### 4. Pressure
    - **Increases with pressure** at constant temperature
    - At high pressure, adsorption becomes independent of pressure (saturation)

    ---

    ## Adsorption Isotherms

    Adsorption isotherms are graphs showing the variation of adsorption with pressure at constant temperature.

    ### 1. Freundlich Adsorption Isotherm

    **Equation:**
    ```
    x/m = k·P^(1/n)
    ```

    Where:
    - x = mass of gas adsorbed
    - m = mass of adsorbent
    - P = pressure
    - k, n = constants (depend on nature of adsorbate and adsorbent)
    - n > 1

    **Logarithmic form:**
    ```
    log(x/m) = log k + (1/n)log P
    ```

    This is a straight line with:
    - Slope = 1/n
    - Intercept = log k

    **Validity:**
    - Valid for moderate pressure range
    - Fails at very low and very high pressures

    ### 2. Langmuir Adsorption Isotherm

    **Assumptions:**
    - Adsorption occurs on specific sites on the adsorbent surface
    - Each site can hold only one molecule (monolayer)
    - All sites are equivalent
    - No interaction between adsorbed molecules

    **Equation:**
    ```
    x/m = (a·b·P)/(1 + b·P)
    ```

    Where:
    - a = maximum adsorption capacity
    - b = constant related to enthalpy of adsorption

    **At low pressure:** x/m = a·b·P (linear)
    **At high pressure:** x/m = a (constant, saturation)

    ---

    ## Applications of Adsorption

    1. **Gas masks:** Activated charcoal adsorbs poisonous gases
    2. **Decolorization:** Animal charcoal removes colored impurities from sugar
    3. **Water purification:** Removal of odor and taste
    4. **Humidity control:** Silica gel and alumina gel
    5. **Chromatography:** Separation of mixtures
    6. **Heterogeneous catalysis:** Catalyst provides surface for reaction
    7. **Froth flotation:** Separation of ores

    ---

    ## IIT JEE Key Points

    1. Adsorption is **exothermic** (ΔH < 0)
    2. **Entropy decreases** during adsorption (ΔS < 0)
    3. For spontaneity: ΔG = ΔH - TΔS < 0
    4. Physisorption occurs at **low temperature**
    5. Chemisorption requires **activation energy**
    6. **Freundlich isotherm:** x/m = k·P^(1/n), valid at moderate pressure
    7. **Langmuir isotherm:** Based on monolayer adsorption
    8. Easily liquefiable gases are **readily adsorbed**

## Key Points

- Adsorption

- Physisorption

- Chemisorption
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Adsorption', 'Physisorption', 'Chemisorption', 'Adsorption isotherms', 'Factors affecting adsorption'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Catalysis - Types and Mechanisms ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Catalysis - Types and Mechanisms',
  content: <<~MARKDOWN,
# Catalysis - Types and Mechanisms 🚀

# Catalysis

    ## Introduction

    **Catalyst:** A substance that alters the rate of a chemical reaction without being consumed in the process.

    **Catalysis:** The phenomenon of altering the rate of reaction using a catalyst.

    ---

    ## Types of Catalysis

    ### 1. Positive Catalysis
    - Catalyst **increases** the rate of reaction
    - Most common type
    - **Example:** MnO₂ in decomposition of KClO₃

    ### 2. Negative Catalysis (Inhibition)
    - Catalyst **decreases** the rate of reaction
    - **Example:** Phosphoric acid retards decomposition of H₂O₂

    ### 3. Auto-catalysis
    - Product of reaction acts as catalyst
    - **Example:** CH₃COOC₂H₅ + H₂O → CH₃COOH + C₂H₅OH (CH₃COOH catalyzes the reaction)

    ---

    ## Classification Based on Phase

    ### Homogeneous Catalysis

    **Definition:** Catalyst and reactants are in the same phase.

    **Characteristics:**
    - Usually in liquid or gas phase
    - Catalyst uniformly distributed
    - High selectivity

    **Examples:**

    1. **Lead chamber process (SO₂ oxidation):**
       ```
       2SO₂(g) + O₂(g) --[NO(g)]--> 2SO₃(g)
       ```

    2. **Esterification:**
       ```
       CH₃COOH(l) + C₂H₅OH(l) --[H₂SO₄(l)]--> CH₃COOC₂H₅(l) + H₂O(l)
       ```

    3. **Hydrolysis of esters:**
       ```
       CH₃COOC₂H₅ + H₂O --[H⁺ or OH⁻]--> CH₃COOH + C₂H₅OH
       ```

    4. **Inversion of cane sugar:**
       ```
       C₁₂H₂₂O₁₁ + H₂O --[H⁺]--> C₆H₁₂O₆ + C₆H₁₂O₆
       ```

    ### Heterogeneous Catalysis

    **Definition:** Catalyst and reactants are in different phases.

    **Characteristics:**
    - Catalyst is usually solid, reactants are gas or liquid
    - Reaction occurs on catalyst surface
    - Surface area is important

    **Examples:**

    1. **Haber process (Ammonia synthesis):**
       ```
       N₂(g) + 3H₂(g) --[Fe(s)]--> 2NH₃(g)
       ```

    2. **Ostwald process (Oxidation of ammonia):**
       ```
       4NH₃(g) + 5O₂(g) --[Pt(s)]--> 4NO(g) + 6H₂O(g)
       ```

    3. **Contact process (SO₃ production):**
       ```
       2SO₂(g) + O₂(g) --[V₂O₅(s)]--> 2SO₃(g)
       ```

    4. **Hydrogenation of vegetable oils:**
       ```
       Vegetable oil + H₂ --[Ni(s)]--> Vanaspati ghee
       ```

    5. **Deacon's process (Chlorine production):**
       ```
       4HCl(g) + O₂(g) --[CuCl₂(s)]--> 2Cl₂(g) + 2H₂O(g)
       ```

    | Homogeneous | Heterogeneous |
    |-------------|---------------|
    | Same phase | Different phases |
    | Uniformly distributed | Localized at interface |
    | Example: NO in SO₂ oxidation | Example: Fe in Haber process |

    ---

    ## Mechanism of Heterogeneous Catalysis

    **Steps:**

    1. **Diffusion:** Reactant molecules diffuse to catalyst surface
    2. **Adsorption:** Reactants are adsorbed on catalyst surface (chemisorption)
    3. **Reaction:** Adsorbed molecules react on surface (activation energy lowered)
    4. **Desorption:** Products desorb from surface
    5. **Diffusion:** Products diffuse away from surface

    **Active sites:** Specific locations on catalyst surface where reaction occurs

    ---

    ## Important Features of Catalysis

    ### 1. Catalyst Remains Unchanged
    - Mass and chemical composition remain same
    - May undergo temporary physical/chemical change

    ### 2. Small Amount Required
    - Catalyst works in very small quantities
    - Effect depends on surface area, not mass

    ### 3. Catalyst Cannot Initiate Reaction
    - Can only alter rate of thermodynamically feasible reactions
    - Cannot make impossible reactions possible

    ### 4. Catalyst is Specific
    - A given catalyst works for specific reactions only
    - Example: MnO₂ catalyzes KClO₃ decomposition but not others

    ### 5. Catalyst Does Not Alter Equilibrium
    - Increases both forward and backward reaction rates equally
    - Position of equilibrium remains same
    - Equilibrium is attained faster

    ### 6. Catalyst Lowers Activation Energy
    - Provides alternate pathway with lower Ea
    - More molecules have energy ≥ Ea
    - Rate increases

    ---

    ## Promoters and Catalytic Poisons

    ### Promoters (Co-catalysts)
    - Substances that enhance catalyst activity
    - **Example:** In Haber process, Fe is catalyst, Mo acts as promoter

    ### Catalytic Poisons
    - Substances that reduce or destroy catalyst activity
    - **Example:**
      - Arsenic poisoning of Pt catalyst in Contact process
      - CO poisoning of Fe catalyst in Haber process
      - Lead poisoning of catalytic converters

    ---

    ## Enzyme Catalysis

    **Enzymes:** Biological catalysts (proteins) in living organisms

    **Characteristics:**
    - Highly specific (lock and key mechanism)
    - Work under mild conditions (body temperature, neutral pH)
    - Very efficient (increase rate by 10⁶ to 10²⁰ times)
    - Sensitive to temperature and pH

    **Examples:**
    - **Invertase:** Converts cane sugar to glucose and fructose
    - **Maltase:** Converts maltose to glucose
    - **Urease:** Converts urea to ammonia and CO₂
    - **Pepsin:** Digests proteins in stomach
    - **Amylase:** Converts starch to maltose

    **Mechanism:**
    ```
    Enzyme (E) + Substrate (S) ⇌ E-S complex → E + Product (P)
    ```

    ---

    ## Zeolites as Catalysts

    **Zeolites:** Microporous aluminosilicate minerals with shape-selective catalysis

    **Structure:**
    - 3D network of SiO₄ and AlO₄ tetrahedra
    - Contains cavities and channels of molecular dimensions

    **Applications:**
    - Petroleum refining (catalytic cracking)
    - Petrochemical industry
    - Conversion of alcohols to gasoline
    - **ZSM-5:** Used to convert methanol to gasoline

    **Shape Selectivity:** Only molecules of certain size and shape can enter pores and react

    ---

    ## IIT JEE Key Points

    1. Catalyst **does not alter ΔG** or equilibrium position
    2. Catalyst **lowers activation energy** (Ea)
    3. **Heterogeneous catalysis:** Adsorption → Reaction → Desorption
    4. **Homogeneous:** Same phase; **Heterogeneous:** Different phases
    5. **Promoters** enhance catalyst activity
    6. **Poisons** reduce catalyst activity
    7. **Enzymes** are highly specific biological catalysts
    8. **Zeolites** show shape-selective catalysis
    9. Catalyst increases rate of **both forward and backward** reactions equally

## Key Points

- Catalysis

- Homogeneous catalysis

- Heterogeneous catalysis
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Catalysis', 'Homogeneous catalysis', 'Heterogeneous catalysis', 'Enzyme catalysis', 'Catalyst poisoning'],
  prerequisite_ids: []
)

# === MICROLESSON 7: Colloidal Systems - Properties and Classification ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Colloidal Systems - Properties and Classification',
  content: <<~MARKDOWN,
# Colloidal Systems - Properties and Classification 🚀

# Colloidal Systems

    ## Introduction

    **Colloidal solution (or sol):** A heterogeneous mixture where particle size is intermediate between true solution and suspension.

    **Particle size:**
    - True solution: < 1 nm
    - Colloidal solution: 1-1000 nm (1-100 nm typically)
    - Suspension: > 1000 nm

    **Components:**
    - **Dispersed phase:** Substance distributed as particles (like solute)
    - **Dispersion medium:** Medium in which particles are dispersed (like solvent)

    ---

    ## Classification of Colloids

    ### Based on Physical State

    | Dispersed Phase | Dispersion Medium | Name | Example |
    |-----------------|-------------------|------|---------|
    | Solid | Solid | Solid sol | Colored glasses, gemstones |
    | Solid | Liquid | Sol | Paint, ink, gold sol |
    | Solid | Gas | Aerosol | Smoke, dust in air |
    | Liquid | Solid | Gel | Jellies, cheese, butter |
    | Liquid | Liquid | Emulsion | Milk, mayonnaise |
    | Liquid | Gas | Aerosol | Fog, mist, cloud |
    | Gas | Solid | Solid foam | Pumice stone, foam rubber |
    | Gas | Liquid | Foam | Soap foam, whipped cream |

    **Note:** Gas-gas mixtures are always homogeneous (true solutions), never colloidal.

    ### Based on Nature of Interaction

    #### 1. Lyophilic Colloids (Solvent-loving)
    - Strong interaction between dispersed phase and medium
    - Directly formed by mixing with solvent
    - **Reversible:** Can be reconstituted after evaporation
    - **Stable:** Not easily coagulated
    - **Examples:** Starch, gelatin, rubber, proteins in water

    #### 2. Lyophobic Colloids (Solvent-hating)
    - Weak or no interaction between dispersed phase and medium
    - Not directly formed, need special methods
    - **Irreversible:** Cannot be reconstituted
    - **Unstable:** Easily coagulated
    - **Examples:** Metal sols (gold, silver), sulfur sol, As₂S₃ sol

    **If water is the medium:**
    - Lyophilic → Hydrophilic
    - Lyophobic → Hydrophobic

    ### Based on Type of Particles

    #### 1. Multimolecular Colloids
    - Large number of atoms/molecules aggregate together
    - Size in colloidal range
    - **Example:** Gold sol, sulfur sol

    #### 2. Macromolecular Colloids
    - Individual large molecules (macromolecules)
    - Size naturally in colloidal range
    - **Example:** Proteins, starch, cellulose, polymers

    #### 3. Associated Colloids (Micelles)
    - Formed by aggregation of small molecules above a certain concentration
    - **CMC (Critical Micelle Concentration):** Minimum concentration for micelle formation
    - **Kraft Temperature:** Minimum temperature for micelle formation
    - **Example:** Soaps, detergents

    ---

    ## Preparation of Colloids

    ### Dispersion Methods (Breaking down larger particles)

    #### 1. Mechanical Dispersion
    - Grinding substance with dispersion medium in colloid mill
    - **Example:** Preparation of colloidal solutions of dyes

    #### 2. Electrical Dispersion (Bredig's Arc Method)
    - Electric arc struck between metal electrodes under water
    - Metal vaporizes and condenses to colloidal particles
    - **Example:** Preparation of gold, silver, platinum sols

    #### 3. Peptization
    - Process of converting precipitate into colloid by adding electrolyte (peptizing agent)
    - Electrolyte gets preferentially adsorbed
    - **Example:** Fresh Fe(OH)₃ precipitate + FeCl₃ → Fe(OH)₃ sol

    ### Condensation Methods (Building up from smaller particles)

    #### 1. Chemical Methods

    **Oxidation:**
    ```
    2H₂S + SO₂ → 3S (sol) + 2H₂O
    ```

    **Reduction:**
    ```
    2AuCl₃ + 3HCHO + 3H₂O → 2Au (sol) + 3HCOOH + 6HCl
    ```

    **Hydrolysis:**
    ```
    FeCl₃ + 3H₂O → Fe(OH)₃ (sol) + 3HCl
    ```

    **Double decomposition:**
    ```
    As₂O₃ + 3H₂S → As₂S₃ (sol) + 3H₂O
    ```

    #### 2. Change of Solvent
    - Dissolve substance in one solvent
    - Pour into another solvent where it's less soluble
    - **Example:** Sulfur sol by pouring alcoholic sulfur solution into water

    ---

    ## Properties of Colloids

    ### 1. Heterogeneous Nature
    - Colloids are heterogeneous (two phases)
    - But appear homogeneous to naked eye

    ### 2. Filterability
    - Pass through ordinary filter paper
    - Do not pass through parchment or cellophane (semi-permeable membrane)
    - **Dialysis:** Purification of colloids by removing dissolved substances

    ### 3. Colligative Properties
    - Exhibit colligative properties
    - But much smaller than true solutions (fewer particles per unit mass)

    ### 4. Tyndall Effect
    - Scattering of light by colloidal particles
    - Path of light becomes visible
    - **Not shown by true solutions** (particles too small)
    - **Example:** Beam of light in a dusty room, car headlights in fog

    ### 5. Brownian Motion
    - Random, zig-zag motion of colloidal particles
    - Due to unequal bombardment by molecules of dispersion medium
    - Prevents settling of particles under gravity
    - Observed under ultramicroscope

    ### 6. Charge on Colloidal Particles
    - All particles in a given colloid have same charge
    - Prevents aggregation (repulsion)
    - **Positive sols:** Fe(OH)₃, Al(OH)₃, metal sols
    - **Negative sols:** As₂S₃, sulfur sol, gold sol, starch, gums

    ### 7. Electrophoresis
    - Movement of colloidal particles under electric field
    - Positive particles move to cathode (negative electrode)
    - Negative particles move to anode (positive electrode)
    - **Applications:** Determination of charge, purification

    ### 8. Coagulation or Flocculation
    - Settling down of colloidal particles
    - Achieved by:
      - **Adding electrolytes** (most effective)
      - Heating
      - Mixing oppositely charged sols
    - **Hardy-Schulze Rule:** Greater the valence of coagulating ion, greater its coagulating power
    - For negative sols: Al³⁺ > Ba²⁺ > Na⁺
    - For positive sols: [Fe(CN)₆]⁴⁻ > PO₄³⁻ > SO₄²⁻ > Cl⁻

    ---

    ## Protection of Colloids

    **Protective Colloids:** Lyophilic colloids added to lyophobic sols to prevent coagulation

    **Example:** Gelatin added to gold sol

    **Gold Number:** Minimum mass (in mg) of protective colloid required to prevent coagulation of 10 mL of gold sol by 1 mL of 10% NaCl solution

    - **Lower gold number = Better protective action**

    ---

    ## Applications of Colloids

    1. **Purification of water:** Alum coagulates suspended impurities
    2. **Medicines:** Colloidal silver (Argyrol) as antiseptic
    3. **Smoke precipitation:** Cottrell precipitator
    4. **Artificial rain:** Cloud seeding with AgI
    5. **Photography:** Silver bromide in gelatin
    6. **Food industry:** Ice cream, whipped cream
    7. **Rubber industry:** Latex is colloidal
    8. **Cleansing action of soaps**

    ---

    ## IIT JEE Key Points

    1. Colloidal particle size: **1-1000 nm** (typically 1-100 nm)
    2. **Tyndall effect:** Scattering of light by colloidal particles
    3. **Brownian motion:** Random motion preventing settling
    4. **Electrophoresis:** Movement under electric field
    5. **Hardy-Schulze rule:** Higher charge → Greater coagulating power
    6. **Lyophilic:** Reversible, stable; **Lyophobic:** Irreversible, unstable
    7. **Peptization:** Precipitate → Colloid (with electrolyte)
    8. **Gold number:** Lower value = Better protection
    9. Gas-gas mixtures are **never colloidal**

## Key Points

- Colloids

- Classification

- Preparation
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Colloids', 'Classification', 'Preparation', 'Properties', 'Tyndall effect', 'Brownian motion'],
  prerequisite_ids: []
)

# === MICROLESSON 8: Emulsions and Micelles ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Emulsions and Micelles',
  content: <<~MARKDOWN,
# Emulsions and Micelles 🚀

# Emulsions and Micelles

    ## Emulsions

    **Emulsion:** Colloidal system where both dispersed phase and dispersion medium are liquids.

    - Both liquids must be immiscible
    - One liquid is dispersed in another as droplets

    ---

    ## Types of Emulsions

    ### 1. Oil-in-Water (O/W) Emulsion
    - **Dispersed phase:** Oil
    - **Dispersion medium:** Water
    - **Examples:**
      - Milk (fat in water)
      - Vanishing cream
      - Cod liver oil

    ### 2. Water-in-Oil (W/O) Emulsion
    - **Dispersed phase:** Water
    - **Dispersion medium:** Oil
    - **Examples:**
      - Butter
      - Cold cream
      - Cod liver oil

    | Property | O/W Emulsion | W/O Emulsion |
    |----------|--------------|--------------|
    | Dispersed phase | Oil | Water |
    | Dispersion medium | Water | Oil |
    | Dilution | With water | With oil |
    | Conductivity | Conducts electricity | Does not conduct |
    | Example | Milk | Butter |

    ---

    ## Tests to Identify Emulsion Type

    ### 1. Dilution Test
    - **O/W:** Can be diluted with water
    - **W/O:** Can be diluted with oil

    ### 2. Conductivity Test
    - **O/W:** Conducts electricity (water conducts)
    - **W/O:** Does not conduct (oil doesn't conduct)

    ### 3. Dye Test
    - **O/W:** Water-soluble dye colors the emulsion
    - **W/O:** Oil-soluble dye colors the emulsion

    ---

    ## Emulsifying Agents (Emulsifiers)

    **Function:** Stabilize emulsions by forming interfacial film between two liquids

    **Types:**

    1. **Lyophilic colloids:** Gelatin, albumin, casein
    2. **Surface active agents:** Soaps, detergents
    3. **Finely divided solids:** Lampblack, clay

    **Mechanism:**
    - Molecules have hydrophilic (water-loving) and hydrophobic (water-hating) parts
    - Form protective layer around droplets
    - Prevent coalescence

    ---

    ## Applications of Emulsions

    1. **Medicines:** Cod liver oil, liquid paraffin
    2. **Cosmetics:** Cold cream, vanishing cream
    3. **Food:** Milk, butter, ice cream
    4. **Paints:** Oil-based paints
    5. **Disinfectants:** Phenol emulsions
    6. **Asphalt emulsions:** Road surfacing

    ---

    ## Demulsification

    **Process of breaking emulsion into constituent liquids**

    **Methods:**
    1. **Heating:** Destroys emulsifying agent
    2. **Freezing:** Ice crystals break emulsion
    3. **Centrifugation:** Separates by density
    4. **Chemical methods:** Adding electrolytes, changing pH
    5. **Addition of opposite type emulsifier**

    **Example:** Cream separation from milk by centrifugation

    ---

    ## Micelles

    **Micelle:** Aggregate of surfactant molecules in colloidal dimensions

    ### Surfactants (Surface Active Agents)

    **Structure:**
    - **Hydrophilic head:** Polar, water-loving (COO⁻, SO₃⁻, SO₄⁻)
    - **Hydrophobic tail:** Non-polar, water-hating (long hydrocarbon chain)

    **Example - Soap (RCOO⁻Na⁺):**
    - Hydrophilic: COO⁻ group
    - Hydrophobic: Long alkyl chain (R)

    ### Micelle Formation

    **In water:**
    - Hydrophobic tails point inward
    - Hydrophilic heads point outward toward water
    - Forms spherical aggregate

    **Critical Micelle Concentration (CMC):**
    - Minimum concentration at which micelles form
    - Below CMC: Individual molecules
    - Above CMC: Micelles form

    **Kraft Temperature:**
    - Minimum temperature for micelle formation
    - Below this, surfactant precipitates

    ---

    ## Cleansing Action of Soaps

    **Mechanism:**

    1. **Soap dissolves in water** and forms micelles (above CMC)

    2. **Hydrophobic tails** dissolve in grease/oil on fabric
       **Hydrophilic heads** remain in water

    3. **Mechanical action** (rubbing) breaks up oil into droplets

    4. **Micelles surround oil droplets** with tails inside oil and heads outside in water

    5. **Repulsion between negatively charged heads** keeps droplets dispersed (emulsion)

    6. **Rinsing with water** removes emulsified oil droplets

    **Why soap doesn't work in hard water:**
    - Hard water contains Ca²⁺, Mg²⁺ ions
    - Forms insoluble salts: 2RCOO⁻Na⁺ + Ca²⁺ → (RCOO)₂Ca + 2Na⁺
    - These precipitate as scum, reducing cleansing action

    ---

    ## Detergents

    **Synthetic detergents:** Sodium salts of long-chain sulfonic acids or alkyl hydrogen sulfates

    **Structure:**
    - Example: Sodium lauryl sulfate (CH₃(CH₂)₁₁OSO₃⁻Na⁺)
    - Long hydrocarbon chain + sulfate group

    **Advantages over soaps:**

    1. **Work in hard water:** Don't form insoluble salts with Ca²⁺, Mg²⁺
    2. **Work in acidic solutions:** Don't precipitate
    3. **Stronger cleansing action**
    4. **Better solubility in water**

    **Types:**

    1. **Anionic detergents:**
       - Negatively charged (SO₃⁻, SO₄⁻)
       - Example: Sodium dodecyl benzene sulfonate
       - Best for removing oily dirt

    2. **Cationic detergents:**
       - Positively charged (NH₄⁺)
       - Example: Cetyltrimethylammonium bromide
       - Used as germicides, antiseptics

    3. **Non-ionic detergents:**
       - No charge
       - Example: Polyethylene glycol stearate
       - Used in dishwashing liquids

    **Disadvantage:** Some detergents are not biodegradable, causing water pollution

    ---

    ## IIT JEE Key Points

    1. **Emulsion:** Liquid in liquid colloidal system
    2. **O/W emulsion:** Can be diluted with water, conducts electricity
    3. **W/O emulsion:** Can be diluted with oil, doesn't conduct
    4. **Emulsifier:** Stabilizes emulsion (gelatin, soap)
    5. **Micelles:** Form above CMC and Kraft temperature
    6. **Soap structure:** Hydrophilic head (COO⁻) + Hydrophobic tail (alkyl chain)
    7. **Cleansing:** Micelles surround oil, emulsification occurs
    8. **Hard water:** Forms scum with soap (Ca²⁺/Mg²⁺ salts)
    9. **Detergents:** Work in hard water, more versatile than soaps

## Key Points

- Emulsions

- Emulsifying agents

- Types of emulsions
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Emulsions', 'Emulsifying agents', 'Types of emulsions', 'Micelles', 'Soaps and detergents'],
  prerequisite_ids: []
)

# === MICROLESSON 9: adsorption — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'adsorption — Practice',
  content: <<~MARKDOWN,
# adsorption — Practice 🚀

Physisorption involves weak van der Waals forces, resulting in low heat of adsorption (20-40 kJ/mol). It is reversible and can form multilayers.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['adsorption'],
  prerequisite_ids: []
)

# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following is characteristic of physisorption?',
    options: ['Low heat of adsorption (20-40 kJ/mol)', 'Forms chemical bonds', 'Irreversible process', 'Forms only monolayer'],
    correct_answer: 0,
    explanation: 'Physisorption involves weak van der Waals forces, resulting in low heat of adsorption (20-40 kJ/mol). It is reversible and can form multilayers.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: adsorption — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'adsorption — Practice',
  content: <<~MARKDOWN,
# adsorption — Practice 🚀

Easily liquefiable gases (high critical temperature) are readily adsorbed. NH₃ has the highest critical temperature among these gases, so it is adsorbed most.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['adsorption'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which gas will be adsorbed to the maximum extent on activated charcoal?',
    options: ['Ammonia (NH₃)', 'Nitrogen (N₂)', 'Hydrogen (H₂)', 'Methane (CH₄)'],
    correct_answer: 0,
    explanation: 'Easily liquefiable gases (high critical temperature) are readily adsorbed. NH₃ has the highest critical temperature among these gases, so it is adsorbed most.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: adsorption_isotherms — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'adsorption_isotherms — Practice',
  content: <<~MARKDOWN,
# adsorption_isotherms — Practice 🚀

Freundlich isotherm: x/m = k·P^(1/n) with n > 1. The logarithmic form gives a straight line. It is valid only at moderate pressures, not all ranges. Langmuir (not Freundlich) assumes monolayer.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['adsorption_isotherms'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'According to Freundlich adsorption isotherm, which statements are correct?',
    options: ['x/m = k·P^(1/n) where n > 1', 'Valid for all pressure ranges', 'log(x/m) vs log P gives a straight line', 'Based on monolayer adsorption'],
    correct_answer: 2,
    explanation: 'Freundlich isotherm: x/m = k·P^(1/n) with n > 1. The logarithmic form gives a straight line. It is valid only at moderate pressures, not all ranges. Langmuir (not Freundlich) assumes monolayer.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 12: adsorption_thermodynamics — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'adsorption_thermodynamics — Practice',
  content: <<~MARKDOWN,
# adsorption_thermodynamics — Practice 🚀

Adsorption is exothermic (ΔH < 0, enthalpy decreases). It also decreases entropy (ΔS < 0) as molecules become more ordered on the surface.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['adsorption_thermodynamics'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Adsorption is accompanied by:',
    options: ['Decrease in enthalpy and decrease in entropy', 'Increase in enthalpy and increase in entropy', 'Decrease in enthalpy and increase in entropy', 'Increase in enthalpy and decrease in entropy'],
    correct_answer: 0,
    explanation: 'Adsorption is exothermic (ΔH < 0, enthalpy decreases). It also decreases entropy (ΔS < 0) as molecules become more ordered on the surface.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 13: adsorption_isotherms — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'adsorption_isotherms — Practice',
  content: <<~MARKDOWN,
# adsorption_isotherms — Practice 🚀

log(x/m) = log k + (1/n)log P. Slope = 1/n = 0.5, Intercept = log k = 0.301, so k = 2. At P = 4: log(x/m) = 0.301 + 0.5×log(4) = 0.301 + 0.5×0.602 = 0.602. Therefore x/m = 10^0.602 = 4.0 g/g.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['adsorption_isotherms'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For Freundlich adsorption isotherm, a plot of log(x/m) vs log P has a slope of 0.5 and intercept of 0.301. What is the value of x/m at pressure 4 atm? (x/m in g/g)',
    answer: '',
    explanation: 'log(x/m) = log k + (1/n)log P. Slope = 1/n = 0.5, Intercept = log k = 0.301, so k = 2. At P = 4: log(x/m) = 0.301 + 0.5×log(4) = 0.301 + 0.5×0.602 = 0.602. Therefore x/m = 10^0.602 = 4.0 g/g.',
    difficulty: 'hard',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: catalysis — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'catalysis — Practice',
  content: <<~MARKDOWN,
# catalysis — Practice 🚀

In Haber process, Fe (solid) catalyzes reaction of N₂ and H₂ (gases), making it heterogeneous. Others involve same-phase catalysis.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['catalysis'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following is an example of heterogeneous catalysis?',
    options: ['Haber process: N₂ + 3H₂ → 2NH₃ (Fe catalyst)', 'Esterification with H₂SO₄', 'Oxidation of SO₂ with NO catalyst', 'Hydrolysis of ester with H⁺'],
    correct_answer: 0,
    explanation: 'In Haber process, Fe (solid) catalyzes reaction of N₂ and H₂ (gases), making it heterogeneous. Others involve same-phase catalysis.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 15: catalysis_properties — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'catalysis_properties — Practice',
  content: <<~MARKDOWN,
# catalysis_properties — Practice 🚀

Catalysts lower activation energy and speed up both forward/backward reactions equally, so equilibrium position is unchanged. They do not alter ΔG or make impossible reactions possible.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['catalysis_properties'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which statements are true about catalysts?',
    options: ['Catalyst lowers activation energy', 'Catalyst does not alter equilibrium position', 'Catalyst changes Gibbs free energy of reaction', 'Catalyst can make thermodynamically unfavorable reactions occur'],
    correct_answer: 1,
    explanation: 'Catalysts lower activation energy and speed up both forward/backward reactions equally, so equilibrium position is unchanged. They do not alter ΔG or make impossible reactions possible.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: catalysis — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'catalysis — Practice',
  content: <<~MARKDOWN,
# catalysis — Practice 🚀

Molybdenum enhances the activity of Fe catalyst in Haber process, making it a promoter or co-catalyst.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['catalysis'],
  prerequisite_ids: []
)

# Exercise 16.2: MCQ
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In the Haber process for ammonia synthesis with Fe catalyst, molybdenum (Mo) acts as:',
    options: ['Promoter', 'Catalytic poison', 'Auto-catalyst', 'Negative catalyst'],
    correct_answer: 0,
    explanation: 'Molybdenum enhances the activity of Fe catalyst in Haber process, making it a promoter or co-catalyst.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 17: enzyme_catalysis — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'enzyme_catalysis — Practice',
  content: <<~MARKDOWN,
# enzyme_catalysis — Practice 🚀

Enzymes are highly specific (lock and key), work at mild conditions (37°C), but are sensitive to pH changes. They only catalyze specific reactions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['enzyme_catalysis'],
  prerequisite_ids: []
)

# Exercise 17.2: MCQ
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which are characteristics of enzyme catalysis?',
    options: ['Highly specific for particular substrate', 'Work efficiently at body temperature', 'Activity independent of pH', 'Can catalyze any chemical reaction'],
    correct_answer: 1,
    explanation: 'Enzymes are highly specific (lock and key), work at mild conditions (37°C), but are sensitive to pH changes. They only catalyze specific reactions.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 18: zeolites — Practice ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'zeolites — Practice',
  content: <<~MARKDOWN,
# zeolites — Practice 🚀

Zeolites have microporous structure with cavities of molecular dimensions, allowing only specific molecules to enter and react - this is called shape-selective catalysis.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['zeolites'],
  prerequisite_ids: []
)

# Exercise 18.2: MCQ
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Zeolites are used as catalysts due to their property of:',
    options: ['Shape-selective catalysis', 'Enzyme-like activity', 'Homogeneous catalysis', 'Auto-catalysis'],
    correct_answer: 0,
    explanation: 'Zeolites have microporous structure with cavities of molecular dimensions, allowing only specific molecules to enter and react - this is called shape-selective catalysis.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 19: colloids — Practice ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'colloids — Practice',
  content: <<~MARKDOWN,
# colloids — Practice 🚀

Colloidal particles have size in the range of 1-1000 nm (typically 1-100 nm), which is intermediate between true solutions (<1 nm) and suspensions (>1000 nm).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['colloids'],
  prerequisite_ids: []
)

# Exercise 19.2: MCQ
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The particle size range of colloidal solutions is:',
    options: ['1-1000 nm', '0.1-1 nm', '1000-10000 nm', '10-100 μm'],
    correct_answer: 0,
    explanation: 'Colloidal particles have size in the range of 1-1000 nm (typically 1-100 nm), which is intermediate between true solutions (<1 nm) and suspensions (>1000 nm).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 20: colloid_properties — Practice ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'colloid_properties — Practice',
  content: <<~MARKDOWN,
# colloid_properties — Practice 🚀

Tyndall effect (scattering of light) is observed only in colloidal solutions. True solutions have particles too small to scatter light.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['colloid_properties'],
  prerequisite_ids: []
)

# Exercise 20.2: MCQ
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Tyndall effect is observed in:',
    options: ['Colloidal solutions only', 'True solutions only', 'Both colloidal and true solutions', 'Neither colloidal nor true solutions'],
    correct_answer: 0,
    explanation: 'Tyndall effect (scattering of light) is observed only in colloidal solutions. True solutions have particles too small to scatter light.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 21: colloid_types — Practice ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'colloid_types — Practice',
  content: <<~MARKDOWN,
# colloid_types — Practice 🚀

Lyophilic colloids have strong interaction with medium, are reversible (can be reconstituted), stable (not easily coagulated), and can be prepared directly.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['colloid_types'],
  prerequisite_ids: []
)

# Exercise 21.2: MCQ
Exercise.create!(
  micro_lesson: lesson_21,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which are characteristics of lyophilic colloids?',
    options: ['Strong interaction with dispersion medium', 'Reversible nature', 'Easily coagulated by electrolytes', 'Require special methods for preparation'],
    correct_answer: 1,
    explanation: 'Lyophilic colloids have strong interaction with medium, are reversible (can be reconstituted), stable (not easily coagulated), and can be prepared directly.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 22: coagulation — Practice ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'coagulation — Practice',
  content: <<~MARKDOWN,
# coagulation — Practice 🚀

According to Hardy-Schulze rule, higher the valence of coagulating ion, greater its coagulating power. For negative sol: Al³⁺ (3+) > Ba²⁺ (2+) > Na⁺ (1+).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['coagulation'],
  prerequisite_ids: []
)

# Exercise 22.2: MCQ
Exercise.create!(
  micro_lesson: lesson_22,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For coagulation of a negative sol (like As₂S₃), the correct order of coagulating power is:',
    options: ['Al³⁺ > Ba²⁺ > Na⁺', 'Na⁺ > Ba²⁺ > Al³⁺', 'Ba²⁺ > Al³⁺ > Na⁺', 'All have equal coagulating power'],
    correct_answer: 0,
    explanation: 'According to Hardy-Schulze rule, higher the valence of coagulating ion, greater its coagulating power. For negative sol: Al³⁺ (3+) > Ba²⁺ (2+) > Na⁺ (1+).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 23: colloid_classification — Practice ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'colloid_classification — Practice',
  content: <<~MARKDOWN,
# colloid_classification — Practice 🚀

Milk is an emulsion where fat droplets (liquid) are dispersed in water (liquid). It is a liquid-in-liquid colloidal system.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['colloid_classification'],
  prerequisite_ids: []
)

# Exercise 23.2: MCQ
Exercise.create!(
  micro_lesson: lesson_23,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Milk is an example of:',
    options: ['Emulsion (liquid in liquid)', 'Sol (solid in liquid)', 'Foam (gas in liquid)', 'Aerosol (liquid in gas)'],
    correct_answer: 0,
    explanation: 'Milk is an emulsion where fat droplets (liquid) are dispersed in water (liquid). It is a liquid-in-liquid colloidal system.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 24: protective_colloids — Practice ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'protective_colloids — Practice',
  content: <<~MARKDOWN,
# protective_colloids — Practice 🚀

Gold number is the minimum mass (in mg) of protective colloid needed to prevent coagulation. Lower gold number means better protection. A (0.01) < B (0.1), so A is better.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['protective_colloids'],
  prerequisite_ids: []
)

# Exercise 24.2: MCQ
Exercise.create!(
  micro_lesson: lesson_24,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'If protective colloid A has gold number 0.01 and B has gold number 0.1, which statement is correct?',
    options: ['A is better protective colloid than B', 'B is better protective colloid than A', 'Both have equal protective action', 'Cannot determine from given information'],
    correct_answer: 0,
    explanation: 'Gold number is the minimum mass (in mg) of protective colloid needed to prevent coagulation. Lower gold number means better protection. A (0.01) < B (0.1), so A is better.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 25: emulsions — Practice ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'emulsions — Practice',
  content: <<~MARKDOWN,
# emulsions — Practice 🚀

Milk is an oil-in-water (O/W) emulsion where fat droplets (oil) are dispersed in water. It can be diluted with water and conducts electricity.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['emulsions'],
  prerequisite_ids: []
)

# Exercise 25.2: MCQ
Exercise.create!(
  micro_lesson: lesson_25,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Milk is an example of which type of emulsion?',
    options: ['Oil-in-water (O/W)', 'Water-in-oil (W/O)', 'Water-in-water', 'Oil-in-oil'],
    correct_answer: 0,
    explanation: 'Milk is an oil-in-water (O/W) emulsion where fat droplets (oil) are dispersed in water. It can be diluted with water and conducts electricity.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 26: emulsions — Practice ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'emulsions — Practice',
  content: <<~MARKDOWN,
# emulsions — Practice 🚀

Conductivity test: O/W emulsions conduct electricity because water (dispersion medium) conducts. W/O emulsions do not conduct because oil (dispersion medium) is non-conducting.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['emulsions'],
  prerequisite_ids: []
)

# Exercise 26.2: MCQ
Exercise.create!(
  micro_lesson: lesson_26,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which test can distinguish between O/W and W/O emulsions?',
    options: ['Conductivity test (O/W conducts, W/O does not)', 'pH test', 'Density test', 'Temperature test'],
    correct_answer: 0,
    explanation: 'Conductivity test: O/W emulsions conduct electricity because water (dispersion medium) conducts. W/O emulsions do not conduct because oil (dispersion medium) is non-conducting.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 27: micelles — Practice ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'micelles — Practice',
  content: <<~MARKDOWN,
# micelles — Practice 🚀

CMC is the minimum concentration of surfactant at which micelles start forming. Below CMC, molecules exist individually. Above CMC, micelles form.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['micelles'],
  prerequisite_ids: []
)

# Exercise 27.2: MCQ
Exercise.create!(
  micro_lesson: lesson_27,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Critical Micelle Concentration (CMC) is:',
    options: ['Minimum concentration at which micelles form', 'Maximum concentration of surfactant', 'Concentration at which emulsion breaks', 'Temperature for micelle formation'],
    correct_answer: 0,
    explanation: 'CMC is the minimum concentration of surfactant at which micelles start forming. Below CMC, molecules exist individually. Above CMC, micelles form.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 28: soaps — Practice ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'soaps — Practice',
  content: <<~MARKDOWN,
# soaps — Practice 🚀

Soap has hydrophilic COO⁻ head and hydrophobic alkyl tail, forms micelles above CMC. But soap does NOT work in hard water (forms scum with Ca²⁺/Mg²⁺).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['soaps'],
  prerequisite_ids: []
)

# Exercise 28.2: MCQ
Exercise.create!(
  micro_lesson: lesson_28,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which statements are correct about soap molecule (RCOO⁻Na⁺)?',
    options: ['Has hydrophilic head (COO⁻ group)', 'Has hydrophobic tail (alkyl chain)', 'Forms micelles above CMC', 'Works efficiently in hard water'],
    correct_answer: 2,
    explanation: 'Soap has hydrophilic COO⁻ head and hydrophobic alkyl tail, forms micelles above CMC. But soap does NOT work in hard water (forms scum with Ca²⁺/Mg²⁺).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 29: Adsorption - Types and Mechanisms ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'Adsorption - Types and Mechanisms',
  content: <<~MARKDOWN,
# Adsorption - Types and Mechanisms 🚀

# Adsorption

    ## Introduction

    **Adsorption** is the phenomenon of accumulation of molecules of a substance on the surface of a solid or liquid, forming a molecular or atomic film.

    - **Adsorbate:** The substance that gets adsorbed
    - **Adsorbent:** The surface on which adsorption occurs

    **Examples:**
    - Activated charcoal adsorbs gases
    - Silica gel adsorbs moisture
    - Animal charcoal decolorizes sugar solutions

    ## Adsorption vs Absorption

    | Adsorption | Absorption |
    |------------|------------|
    | Surface phenomenon | Bulk phenomenon |
    | Concentration on surface | Uniform distribution throughout |
    | Example: Gas on charcoal | Example: Water in sponge |

    **Sorption:** When both adsorption and absorption occur simultaneously

    ---

    ## Types of Adsorption

    ### 1. Physical Adsorption (Physisorption)

    **Characteristics:**
    - **Forces:** Weak van der Waals forces
    - **Heat of adsorption:** Low (20-40 kJ/mol)
    - **Temperature:** Occurs at low temperatures
    - **Reversibility:** Easily reversible
    - **Specificity:** Non-specific (any gas can be adsorbed)
    - **Layer formation:** Can form multi-molecular layers
    - **Activation energy:** Not required

    **Example:** Adsorption of N₂ on iron at low temperature

    ### 2. Chemical Adsorption (Chemisorption)

    **Characteristics:**
    - **Forces:** Strong chemical bonds (covalent/ionic)
    - **Heat of adsorption:** High (80-400 kJ/mol)
    - **Temperature:** Occurs at high temperatures
    - **Reversibility:** Irreversible
    - **Specificity:** Highly specific
    - **Layer formation:** Forms unimolecular layer only
    - **Activation energy:** Required

    **Example:** Adsorption of H₂ on nickel

    | Property | Physisorption | Chemisorption |
    |----------|---------------|---------------|
    | Nature of forces | Van der Waals | Chemical bonds |
    | Heat of adsorption | 20-40 kJ/mol | 80-400 kJ/mol |
    | Temperature | Low temperature favored | High temperature favored |
    | Reversibility | Reversible | Irreversible |
    | Specificity | Non-specific | Highly specific |
    | Layers | Multi-layer | Mono-layer |
    | Activation energy | Not required | Required |

    ---

    ## Factors Affecting Adsorption

    ### 1. Nature of Adsorbent
    - **Surface area:** Greater surface area → More adsorption
    - **Porosity:** Porous materials have higher adsorption capacity
    - **Activation:** Activated charcoal has very high surface area

    ### 2. Nature of Adsorbate
    - **Easily liquefiable gases** (high critical temperature) are easily adsorbed
    - Order: NH₃ > SO₂ > HCl > CO₂ > CH₄ > H₂ > N₂
    - Polar molecules are preferentially adsorbed over non-polar

    ### 3. Temperature
    - **Physisorption:** Decreases with increasing temperature (exothermic)
    - **Chemisorption:** Initially increases, then decreases

    ### 4. Pressure
    - **Increases with pressure** at constant temperature
    - At high pressure, adsorption becomes independent of pressure (saturation)

    ---

    ## Adsorption Isotherms

    Adsorption isotherms are graphs showing the variation of adsorption with pressure at constant temperature.

    ### 1. Freundlich Adsorption Isotherm

    **Equation:**
    ```
    x/m = k·P^(1/n)
    ```

    Where:
    - x = mass of gas adsorbed
    - m = mass of adsorbent
    - P = pressure
    - k, n = constants (depend on nature of adsorbate and adsorbent)
    - n > 1

    **Logarithmic form:**
    ```
    log(x/m) = log k + (1/n)log P
    ```

    This is a straight line with:
    - Slope = 1/n
    - Intercept = log k

    **Validity:**
    - Valid for moderate pressure range
    - Fails at very low and very high pressures

    ### 2. Langmuir Adsorption Isotherm

    **Assumptions:**
    - Adsorption occurs on specific sites on the adsorbent surface
    - Each site can hold only one molecule (monolayer)
    - All sites are equivalent
    - No interaction between adsorbed molecules

    **Equation:**
    ```
    x/m = (a·b·P)/(1 + b·P)
    ```

    Where:
    - a = maximum adsorption capacity
    - b = constant related to enthalpy of adsorption

    **At low pressure:** x/m = a·b·P (linear)
    **At high pressure:** x/m = a (constant, saturation)

    ---

    ## Applications of Adsorption

    1. **Gas masks:** Activated charcoal adsorbs poisonous gases
    2. **Decolorization:** Animal charcoal removes colored impurities from sugar
    3. **Water purification:** Removal of odor and taste
    4. **Humidity control:** Silica gel and alumina gel
    5. **Chromatography:** Separation of mixtures
    6. **Heterogeneous catalysis:** Catalyst provides surface for reaction
    7. **Froth flotation:** Separation of ores

    ---

    ## IIT JEE Key Points

    1. Adsorption is **exothermic** (ΔH < 0)
    2. **Entropy decreases** during adsorption (ΔS < 0)
    3. For spontaneity: ΔG = ΔH - TΔS < 0
    4. Physisorption occurs at **low temperature**
    5. Chemisorption requires **activation energy**
    6. **Freundlich isotherm:** x/m = k·P^(1/n), valid at moderate pressure
    7. **Langmuir isotherm:** Based on monolayer adsorption
    8. Easily liquefiable gases are **readily adsorbed**

## Key Points

- Adsorption

- Physisorption

- Chemisorption
  MARKDOWN
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Adsorption', 'Physisorption', 'Chemisorption', 'Adsorption isotherms', 'Factors affecting adsorption'],
  prerequisite_ids: []
)

puts "✓ Created 29 microlessons for Surface Chemistry"

# AUTO-GENERATED from module_12_environmental.rb
puts "Creating Microlessons for Environmental Chemistry..."

module_var = CourseModule.find_by(slug: 'environmental-chemistry')

# === MICROLESSON 1: green_chemistry — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'green_chemistry — Practice',
  content: <<~MARKDOWN,
# green_chemistry — Practice 🚀

Green chemistry principles include: catalysis (Principle 9), design for degradation (Principle 10), and prevention (Principle 1). Chlorinated solvents are hazardous and should be avoided (Principle 5: safer solvents).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'hard',
  key_concepts: ['green_chemistry'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are examples of green chemistry principles?',
    options: ['Use of catalysts instead of stoichiometric reagents', 'Design of biodegradable products', 'Use of chlorinated solvents', 'Prevention of waste at source'],
    correct_answer: 3,
    explanation: 'Green chemistry principles include: catalysis (Principle 9), design for degradation (Principle 10), and prevention (Principle 1). Chlorinated solvents are hazardous and should be avoided (Principle 5: safer solvents).',
    difficulty: 'hard'
  }
)

# === MICROLESSON 2: Water Pollution and Soil Pollution ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Water Pollution and Soil Pollution',
  content: <<~MARKDOWN,
# Water Pollution and Soil Pollution 🚀

# Water Pollution

    ## Definition
    **Water pollution**: Addition of undesirable substances that make water unfit for use.

    **Sources**:
    - Domestic sewage
    - Industrial effluents
    - Agricultural runoff
    - Oil spills
    - Thermal pollution

    ---

    ## Types of Water Pollutants

    ### 1. Pathogens
    - **Sources**: Domestic sewage, animal waste
    - **Examples**: Bacteria, viruses, protozoa
    - **Diseases**: Cholera, typhoid, dysentery, hepatitis
    - **Indicator**: Coliform bacteria count

    ### 2. Organic Matter
    - **Sources**: Sewage, food processing, paper mills
    - **Examples**: Proteins, carbohydrates, fats
    - **Effect**: Oxygen depletion (measured by BOD, COD)

    ### 3. Inorganic Chemicals
    #### Heavy Metals
    - **Examples**: Pb, Hg, Cd, As, Cr
    - **Sources**: Industrial waste, mining, batteries
    - **Effects**:
      - **Mercury (Hg)**: Minamata disease (neurological damage)
      - **Lead (Pb)**: Brain damage, anemia
      - **Cadmium (Cd)**: Itai-itai disease (bone disease)
      - **Arsenic (As)**: Skin cancer, arsenicosis

    #### Nitrates and Phosphates
    - **Sources**: Fertilizers, detergents
    - **Effect**: Eutrophication (excessive nutrient enrichment)

    ### 4. Pesticides
    - **Examples**: DDT, BHC, organophosphates
    - **Effect**: Toxic to aquatic life, biomagnification
    - **Persistence**: DDT is non-biodegradable

    ### 5. Radioactive Substances
    - **Sources**: Nuclear plants, medical waste
    - **Examples**: ¹³¹I, ⁹⁰Sr, ¹³⁷Cs
    - **Effects**: Cancer, genetic mutations

    ### 6. Thermal Pollution
    - **Source**: Cooling water from power plants
    - **Effect**: Reduces dissolved oxygen, affects aquatic life

    ---

    ## Biochemical Oxygen Demand (BOD)

    ### Definition
    **BOD**: Amount of oxygen required by microorganisms to decompose organic matter in water under aerobic conditions.

    **Unit**: mg O₂/L or ppm

    **Measurement**: Oxygen consumed in 5 days at 20°C (BOD₅)

    ### Interpretation
    - **Clean water**: BOD < 5 ppm
    - **Moderately polluted**: BOD 5-15 ppm
    - **Highly polluted**: BOD > 15 ppm

    ### Significance
    - **High BOD** = High organic pollution
    - Microbes consume oxygen → fish and aquatic life suffocate
    - Indicator of water quality

    ---

    ## Chemical Oxygen Demand (COD)

    ### Definition
    **COD**: Amount of oxygen required to chemically oxidize all organic and inorganic matter in water.

    **Method**: Strong oxidizing agent (K₂Cr₂O₇ in acidic medium)

    **Unit**: mg O₂/L or ppm

    ### BOD vs COD

    | Parameter | BOD | COD |
    |-----------|-----|-----|
    | **Oxidation** | Biological (microbes) | Chemical (K₂Cr₂O₇) |
    | **Time** | 5 days | Few hours |
    | **Measures** | Biodegradable organic matter | Total organic + inorganic matter |
    | **Value** | COD > BOD (always) | - |

    **Relationship**: COD includes both biodegradable and non-biodegradable matter, so COD ≥ BOD.

    ---

    ## Eutrophication

    ### Definition
    **Eutrophication**: Excessive nutrient enrichment (especially N and P) in water bodies, leading to algal blooms and oxygen depletion.

    ### Process
    1. **Nutrient input**: Fertilizers (NO₃⁻, PO₄³⁻), detergents (phosphates) enter water
    2. **Algal bloom**: Excessive growth of algae and aquatic plants
    3. **Light blocking**: Dense algae block sunlight → underwater plants die
    4. **Oxygen depletion**:
       - Dead algae decompose
       - Decomposition consumes oxygen (high BOD)
       - Dissolved oxygen drops
    5. **Fish death**: Aquatic animals die due to lack of oxygen (hypoxia)

    ### Effects
    - Death of fish and aquatic organisms
    - Bad smell (anaerobic decomposition → H₂S, CH₄)
    - Water unfit for drinking
    - Loss of biodiversity

    ### Prevention
    - Reduce fertilizer use
    - Phosphate-free detergents
    - Wastewater treatment before discharge
    - Aeration of water bodies

    ---

    ## Water Treatment

    ### 1. Primary Treatment (Physical)
    - **Screening**: Remove large debris
    - **Sedimentation**: Settle suspended solids (sludge)

    ### 2. Secondary Treatment (Biological)
    - **Activated sludge**: Aerobic bacteria decompose organic matter
    - Reduces BOD significantly

    ### 3. Tertiary Treatment (Chemical)
    - **Coagulation**: Alum [Al₂(SO₄)₃] precipitates colloidal particles
    - **Chlorination**: Disinfection (kills pathogens)
    - **Advanced**: Reverse osmosis, activated carbon

    ---

    ## Soil Pollution

    ### Definition
    **Soil pollution**: Contamination of soil by toxic chemicals that reduce fertility and harm organisms.

    ### Sources

    #### 1. Industrial Waste
    - Heavy metals (Pb, Hg, Cd, Cr)
    - Organic solvents
    - Acids and alkalis

    #### 2. Agricultural Chemicals
    ##### Pesticides
    - **Insecticides**: DDT, BHC, organophosphates
    - **Herbicides**: 2,4-D, atrazine
    - **Fungicides**: Sulfur, copper compounds

    **Problems**:
    - **Persistent**: DDT takes decades to degrade
    - **Biomagnification**: Concentration increases in food chain
    - **Non-target effects**: Kills beneficial insects, pollinators

    ##### Fertilizers
    - Excessive use leads to soil acidification
    - Runoff causes water pollution (eutrophication)

    #### 3. Solid Waste
    - **Municipal waste**: Plastics, paper, glass
    - **E-waste**: Electronics (contain heavy metals)
    - **Medical waste**: Syringes, contaminated materials

    ### Effects of Soil Pollution

    1. **Loss of soil fertility**
    2. **Contamination of food chain**: Heavy metals in crops
    3. **Groundwater pollution**: Leaching of pollutants
    4. **Health hazards**: Cancer, birth defects
    5. **Loss of soil organisms**: Earthworms, beneficial bacteria

    ### Remediation

    #### 1. Bioremediation
    - Use of microorganisms to degrade pollutants
    - Example: Pseudomonas bacteria degrade hydrocarbons

    #### 2. Phytoremediation
    - Plants absorb pollutants from soil
    - Example: Sunflower removes heavy metals

    #### 3. Composting
    - Organic waste converted to compost
    - Improves soil quality

    #### 4. Reduce, Reuse, Recycle (3R)
    - Minimize waste generation
    - Recycle plastics, metals, paper

    ---

    ## Case Studies

    ### 1. Minamata Disease (Japan, 1950s)
    - **Cause**: Mercury (Hg) from chemical plant discharged into bay
    - **Effect**: Biomagnification in fish → neurological damage in humans
    - **Symptoms**: Tremors, paralysis, insanity, death

    ### 2. Itai-Itai Disease (Japan, 1950s)
    - **Cause**: Cadmium (Cd) from mining waste
    - **Effect**: Softening of bones, kidney damage
    - **Symptoms**: Severe pain ("itai-itai" = "it hurts, it hurts")

    ### 3. Bhopal Gas Tragedy (India, 1984)
    - **Cause**: Methyl isocyanate (MIC) gas leak from Union Carbide plant
    - **Effect**: 3000+ deaths, thousands affected
    - **Soil pollution**: Site still contaminated

    ---

    ## Key Points for IIT JEE

    1. **BOD**: Biological oxygen demand, indicator of organic pollution, clean water < 5 ppm
    2. **COD**: Chemical oxygen demand, COD > BOD always
    3. **Eutrophication**: Excess nutrients (N, P) → algal bloom → oxygen depletion → fish death
    4. **Heavy metals**: Hg (Minamata disease), Cd (Itai-itai disease), Pb (brain damage)
    5. **Pesticides**: DDT is persistent, non-biodegradable, causes biomagnification
    6. **Water treatment**: Primary (physical), Secondary (biological), Tertiary (chemical)
    7. **Biomagnification**: Concentration of pollutants increases up the food chain
    8. **Bioremediation**: Microorganisms degrade pollutants
    9. **Phytoremediation**: Plants absorb pollutants from soil

## Key Points

- Water pollutants

- BOD

- COD
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Water pollutants', 'BOD', 'COD', 'Eutrophication', 'Soil pollution', 'Pesticides', 'Industrial waste'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Green Chemistry: Principles and Applications ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Green Chemistry: Principles and Applications',
  content: <<~MARKDOWN,
# Green Chemistry: Principles and Applications 🚀

# Green Chemistry

    ## What is Green Chemistry?

    **Definition**: Design of chemical products and processes that reduce or eliminate the use and generation of hazardous substances.

    **Other names**: Sustainable chemistry, environmentally benign chemistry

    **Goal**: Prevention of pollution at the source rather than treatment after generation.

    ---

    ## The 12 Principles of Green Chemistry

    ### 1. Prevention (Waste Prevention)
    **Principle**: Prevent waste rather than treat or clean up after it is formed.

    **Example**:
    - Design reactions with high yield and selectivity
    - Minimize byproducts

    ### 2. Atom Economy
    **Principle**: Design syntheses so maximum amount of starting materials is incorporated into final product.

    **Formula**:
    \\[ \\text{Atom Economy} = \\frac{\\text{Molar mass of desired product}}{\\text{Sum of molar masses of all reactants}} \\times 100\\% \\]

    **Example**:
    - **Addition reactions** (high atom economy): A + B → AB (100%)
    - **Substitution reactions** (lower atom economy): A-B + C → A-C + B (waste B)

    **IIT JEE Example**:
    - **Friedel-Crafts alkylation** (poor atom economy due to AlCl₃ waste)
    - **Hydrogenation** (excellent atom economy)

    ### 3. Less Hazardous Chemical Syntheses
    **Principle**: Use and generate substances with little or no toxicity.

    **Example**:
    - Replace toxic phosgene (COCl₂) in polycarbonate synthesis
    - Avoid carcinogens, mutagens, teratogens

    ### 4. Designing Safer Chemicals
    **Principle**: Design chemicals that are effective yet have minimal toxicity.

    **Example**:
    - Biodegradable detergents (linear alkyl benzene sulfonates)
    - Water-based paints instead of solvent-based

    ### 5. Safer Solvents and Auxiliaries
    **Principle**: Minimize or eliminate auxiliary substances (solvents, separation agents).

    **Green solvents**:
    - **Water**: Best, safest solvent
    - **Supercritical CO₂**: Non-toxic, non-flammable (used in caffeine extraction)
    - **Ionic liquids**: Non-volatile, recyclable
    - **Bio-based solvents**: Ethanol, ethyl lactate

    **Avoid**:
    - Chlorinated solvents (CHCl₃, CCl₄)
    - Benzene (carcinogenic)

    ### 6. Design for Energy Efficiency
    **Principle**: Minimize energy requirements of chemical processes.

    **Strategies**:
    - Conduct reactions at room temperature and pressure
    - Avoid energy-intensive heating/cooling
    - Use catalysts to lower activation energy

    **Example**:
    - Enzymatic reactions at mild conditions
    - Microwave-assisted synthesis

    ### 7. Use of Renewable Feedstocks
    **Principle**: Use renewable raw materials instead of depleting fossil fuels.

    **Examples**:
    - **Biofuels**: Ethanol from biomass
    - **Bioplastics**: PLA (polylactic acid) from corn starch
    - **Bio-based chemicals**: Glycerol, levulinic acid

    ### 8. Reduce Derivatives
    **Principle**: Minimize derivatization (protection/deprotection steps) as they require additional reagents and generate waste.

    **Example**:
    - Direct functionalization instead of protection-deprotection
    - Click chemistry (high selectivity, no protection needed)

    ### 9. Catalysis
    **Principle**: Use catalytic reagents (in small amounts) instead of stoichiometric reagents.

    **Advantages of catalysis**:
    - Reduces waste
    - Increases selectivity
    - Lowers energy requirements

    **Examples**:
    - **Zeolites**: Solid acid catalysts in petroleum cracking
    - **Enzyme catalysis**: Biocatalysis (mild conditions, high selectivity)
    - **Transition metal catalysis**: Pd-catalyzed cross-coupling

    ### 10. Design for Degradation
    **Principle**: Design products to break down into innocuous substances after use.

    **Examples**:
    - **Biodegradable plastics**: PLA, PHB (polyhydroxybutyrate)
    - **Green pesticides**: Neem-based pesticides (degrade quickly)

    **Avoid**:
    - Persistent pollutants (DDT, PCBs)

    ### 11. Real-Time Analysis for Pollution Prevention
    **Principle**: Monitor reactions in real-time to prevent formation of hazardous substances.

    **Tools**:
    - In-line sensors
    - Process analytical technology (PAT)
    - Spectroscopy (IR, NMR) for monitoring

    ### 12. Inherently Safer Chemistry for Accident Prevention
    **Principle**: Choose substances and processes to minimize accidents (explosions, fires, releases).

    **Strategies**:
    - Use less hazardous reagents
    - Lower temperatures and pressures
    - Avoid highly reactive intermediates

    **Example**:
    - Use aqueous H₂O₂ instead of organic peroxides (less explosive)

    ---

    ## Applications of Green Chemistry

    ### 1. Green Solvents

    #### Supercritical CO₂
    - **Properties**: Above critical point (31°C, 73 atm), behaves as both liquid and gas
    - **Uses**:
      - Decaffeination of coffee
      - Dry cleaning (replacing perchloroethylene)
      - Extraction of essential oils

    #### Ionic Liquids
    - Salts that are liquid at room temperature
    - Non-volatile, non-flammable, recyclable
    - Used in synthesis, catalysis

    ### 2. Green Catalysts

    #### Zeolites
    - Microporous aluminosilicates
    - Solid acid catalysts
    - Replace corrosive liquid acids (H₂SO₄, HF)
    - **Uses**: Petroleum cracking, isomerization

    #### Biocatalysts (Enzymes)
    - Highly selective, work at mild conditions
    - **Example**: Lipases for biodiesel production

    ### 3. Biodegradable Polymers

    | Polymer | Source | Uses |
    |---------|--------|------|
    | PLA (Polylactic acid) | Corn starch, sugarcane | Packaging, medical implants |
    | PHB (Polyhydroxybutyrate) | Bacterial fermentation | Biodegradable plastics |
    | PHA (Polyhydroxyalkanoates) | Bacteria | Medical devices |

    ### 4. Greener Synthetic Routes

    #### Ibuprofen Synthesis
    - **Old method**: 6 steps, 40% atom economy
    - **BHC (Boot-Hoechst-Celanese) method**: 3 steps, 77% atom economy
    - **Green improvement**: Catalytic route, fewer solvents

    #### Adipic Acid Synthesis
    - **Old method**: Oxidation of cyclohexane with HNO₃ (produces N₂O, greenhouse gas)
    - **Green method**: Bacterial fermentation from glucose

    ### 5. Alternative Energy

    - **Biofuels**: Ethanol, biodiesel (renewable)
    - **Solar cells**: Photoelectrochemical cells
    - **Fuel cells**: H₂/O₂ fuel cells (clean energy)

    ---

    ## Atom Economy: Quantitative Analysis

    ### Example 1: Addition Reaction
    **Reaction**: Hydrogenation of ethene
    - C₂H₄ + H₂ → C₂H₆

    **Atom economy** = (30/30) × 100% = **100%** (all atoms incorporated)

    ### Example 2: Substitution Reaction
    **Reaction**: Chlorination of methane
    - CH₄ + Cl₂ → CH₃Cl + HCl

    **Desired product**: CH₃Cl (molar mass = 50.5 g/mol)
    **Total reactants**: CH₄ (16) + Cl₂ (71) = 87 g/mol

    **Atom economy** = (50.5/87) × 100% = **58%** (HCl is waste)

    ### Example 3: Elimination Reaction
    **Reaction**: Dehydration of ethanol
    - C₂H₅OH → C₂H₄ + H₂O

    **Desired product**: C₂H₄ (molar mass = 28 g/mol)
    **Total reactants**: C₂H₅OH = 46 g/mol

    **Atom economy** = (28/46) × 100% = **61%**

    ---

    ## Benefits of Green Chemistry

    1. **Environmental**: Reduces pollution, waste, and resource depletion
    2. **Economic**: Saves money (less waste disposal, more efficient)
    3. **Safety**: Fewer hazardous chemicals, lower accident risk
    4. **Sustainability**: Ensures resources for future generations

    ---

    ## Challenges

    1. **Cost**: Green processes may be initially expensive
    2. **Performance**: Some green alternatives may be less effective
    3. **Scale-up**: Laboratory success may not translate to industrial scale
    4. **Awareness**: Need for education and training

    ---

    ## IIT JEE Examples

    ### Problem 1: Calculate Atom Economy
    **Question**: Calculate atom economy for the synthesis of ethyl acetate:
    - CH₃COOH + C₂H₅OH → CH₃COOC₂H₅ + H₂O

    **Solution**:
    - Desired product: CH₃COOC₂H₅ (molar mass = 88 g/mol)
    - Total reactants: CH₃COOH (60) + C₂H₅OH (46) = 106 g/mol
    - Atom economy = (88/106) × 100% = **83%**

    ### Problem 2: Compare Green Alternatives
    **Question**: Which is greener: chlorination or bromination of alkanes?

    **Answer**: **Bromination** is greener because:
    - More selective (less byproducts)
    - Milder conditions (no UV needed, just light)
    - Higher atom economy

    ---

    ## Key Points for IIT JEE

    1. **12 Principles**: Prevention, atom economy, less hazardous syntheses, safer chemicals, safer solvents, energy efficiency, renewable feedstocks, reduce derivatives, catalysis, degradation, real-time analysis, inherently safer
    2. **Atom economy** = (Molar mass of product / Molar mass of reactants) × 100%
    3. **Green solvents**: Water, supercritical CO₂, ionic liquids
    4. **Addition reactions**: 100% atom economy (ideal)
    5. **Catalysis**: Reduces waste, increases selectivity, uses small amounts
    6. **Biodegradable plastics**: PLA, PHB, PHA
    7. **Zeolites**: Solid acid catalysts, replace liquid acids
    8. **Supercritical CO₂**: Used in decaffeination, dry cleaning
    9. **Prevention > treatment**: Stop pollution at source

## Key Points

- Green chemistry principles

- Atom economy

- Safer solvents
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Green chemistry principles', 'Atom economy', 'Safer solvents', 'Biodegradable products', 'Energy efficiency'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Air Pollution: Tropospheric and Stratospheric ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Air Pollution: Tropospheric and Stratospheric',
  content: <<~MARKDOWN,
# Air Pollution: Tropospheric and Stratospheric 🚀

# Air Pollution

    ## Atmosphere Structure

    The atmosphere is divided into layers:

    | Layer | Altitude | Characteristics |
    |-------|----------|-----------------|
    | **Troposphere** | 0-10 km | Weather phenomena, 99% of water vapor |
    | **Stratosphere** | 10-50 km | Ozone layer (15-30 km) |
    | **Mesosphere** | 50-85 km | Coldest layer |
    | **Thermosphere** | 85-600 km | Very high temperature |

    **Focus**: Environmental chemistry primarily concerns troposphere and stratosphere.

    ---

    ## Tropospheric Pollution

    **Troposphere**: Lowest layer where we live and breathe.

    ### Major Air Pollutants

    #### 1. Gaseous Pollutants

    ##### A. Oxides of Sulfur (SOₓ)
    **Sources**:
    - Combustion of fossil fuels (coal, petroleum)
    - Smelting of sulfide ores
    - Volcanic eruptions

    **Main pollutants**: SO₂ and SO₃

    **Effects**:
    - **Respiratory problems**: Asthma, bronchitis
    - **Acid rain**: SO₂ + H₂O → H₂SO₃, SO₃ + H₂O → H₂SO₄
    - **Corrosion**: Damages buildings, monuments (marble cancer)
    - **Plant damage**: Chlorosis (yellowing of leaves)

    ##### B. Oxides of Nitrogen (NOₓ)
    **Sources**:
    - Automobile exhausts (high temperature combustion)
    - Power plants
    - Lightning

    **Formation**:
    - N₂ + O₂ → 2NO (at high temperature ~1500°C in engines)
    - 2NO + O₂ → 2NO₂ (brown gas)

    **Effects**:
    - **Acid rain**: NO₂ + H₂O → HNO₃
    - **Photochemical smog**: NO₂ + sunlight → NO + O·
    - **Respiratory irritation**
    - **Reduces oxygen-carrying capacity**: NO binds to hemoglobin

    ##### C. Carbon Monoxide (CO)
    **Sources**:
    - Incomplete combustion of fossil fuels
    - Automobile exhausts (major source)
    - Cigarette smoke

    **Properties**:
    - Colorless, odorless, tasteless
    - Toxic gas

    **Effects**:
    - **Fatal poison**: Binds to hemoglobin (200 times stronger than O₂)
    - CO + Hb → COHb (carboxyhemoglobin, stable, blocks O₂ transport)
    - Causes headache, dizziness, unconsciousness, death

    ##### D. Carbon Dioxide (CO₂)
    **Sources**:
    - Combustion of fossil fuels
    - Respiration
    - Deforestation

    **Effects**:
    - **Greenhouse gas**: Major contributor to global warming
    - Normal concentration: 0.03-0.04% (increasing)
    - Not toxic but excessive CO₂ causes climate change

    ##### E. Hydrocarbons (CₓHᵧ)
    **Sources**:
    - Automobile exhausts
    - Petroleum refineries
    - Incomplete combustion

    **Effects**:
    - Photochemical smog formation
    - Some are carcinogenic (benzene, PAHs)

    #### 2. Particulate Pollutants

    **Types**:
    - **Smoke**: Carbon particles from combustion
    - **Dust**: Soil particles, pollen, spores
    - **Mist**: Liquid droplets suspended in air
    - **Fumes**: Solid particles from metallurgical processes

    **Effects**:
    - Respiratory diseases
    - Reduces visibility
    - Soiling of materials

    ---

    ## Acid Rain

    ### Definition
    Rain with **pH < 5.6** (normal rain pH ~5.6 due to dissolved CO₂)

    ### Formation

    #### From SO₂:
    - 2SO₂ + O₂ → 2SO₃
    - SO₃ + H₂O → H₂SO₄ (sulfuric acid)

    #### From NOₓ:
    - 4NO₂ + O₂ + 2H₂O → 4HNO₃ (nitric acid)

    ### Effects

    1. **Soil acidification**: Leaching of nutrients (Ca²⁺, Mg²⁺), release of toxic Al³⁺
    2. **Water bodies**: Acidification kills fish and aquatic life
    3. **Buildings and monuments**:
       - **Marble cancer**: CaCO₃ + H₂SO₄ → CaSO₄ + H₂O + CO₂
       - Taj Mahal damage (SO₂ from Mathura refinery)
    4. **Vegetation damage**: Chlorosis, reduced growth
    5. **Corrosion**: Metal structures corrode faster

    ### Control
    - Use low-sulfur fuels
    - Flue gas desulfurization (scrubbers)
    - Catalytic converters in vehicles
    - Liming of soil and water bodies

    ---

    ## Smog

    ### Types of Smog

    #### 1. Classical Smog (London Smog)
    **Composition**: Smoke + Fog (hence "smog")

    **Conditions**:
    - Cool, humid climate
    - High SO₂ and particulate matter

    **Chemistry**:
    - SO₂ + H₂O (in fog droplets) → H₂SO₃
    - Particulates worsen visibility

    **Effects**: Respiratory problems, reduced visibility

    **Example**: London smog disaster (1952, 4000 deaths)

    #### 2. Photochemical Smog (Los Angeles Smog)
    **Composition**: NO₂ + O₃ + PAN (peroxyacetyl nitrate) + hydrocarbons

    **Conditions**:
    - Warm, dry, sunny climate
    - High automobile traffic

    **Formation**:
    1. NO₂ + sunlight → NO + O· (oxygen radical)
    2. O· + O₂ → O₃ (ozone)
    3. Hydrocarbons + O· → Aldehydes, PAN

    **Characteristics**:
    - Brown haze
    - Oxidizing nature
    - Peak at noon (maximum sunlight)

    **Effects**:
    - Eye irritation (tears)
    - Respiratory problems
    - Plant damage (ozone damages stomata)
    - Rubber cracking

    **Control**:
    - Catalytic converters (convert NO to N₂)
    - Use of CNG (cleaner fuel)
    - Public transport, electric vehicles

    ---

    ## Greenhouse Effect and Global Warming

    ### Greenhouse Effect

    **Definition**: Warming of Earth's surface due to trapping of infrared radiation by greenhouse gases.

    **Mechanism**:
    1. Solar radiation (UV, visible) passes through atmosphere
    2. Earth absorbs and re-emits as infrared (heat)
    3. Greenhouse gases absorb infrared → warm atmosphere
    4. Natural greenhouse effect maintains Earth's temperature (~15°C average)

    **Without greenhouse effect**: Earth's temperature would be -18°C (too cold for life)

    ### Greenhouse Gases

    | Gas | Sources | Contribution to Warming |
    |-----|---------|------------------------|
    | **CO₂** | Fossil fuel combustion, deforestation | 60% |
    | **CH₄** | Paddy fields, livestock, landfills, natural gas | 20% |
    | **CFC** | Refrigerants, aerosols | 14% |
    | **N₂O** | Fertilizers, combustion | 6% |

    **Note**: CH₄ is 25 times more potent than CO₂ as a greenhouse gas.

    ### Global Warming

    **Definition**: Increase in Earth's average temperature due to enhanced greenhouse effect.

    **Causes**:
    - Increased CO₂ from fossil fuels
    - Deforestation (less CO₂ absorption)
    - Increased CH₄ from agriculture

    **Observed Effects**:
    - Average temperature increased by ~1°C since pre-industrial era
    - Melting glaciers and ice caps
    - Rising sea levels (thermal expansion + melting ice)
    - Extreme weather events (hurricanes, droughts)
    - Coral bleaching
    - Shift in climate zones

    **Predicted Effects**:
    - Sea level rise → flooding of coastal cities
    - Species extinction
    - Agricultural disruption
    - Spread of diseases

    **Mitigation**:
    - Reduce fossil fuel use
    - Renewable energy (solar, wind)
    - Reforestation
    - Carbon capture and storage
    - International agreements (Paris Agreement)

    ---

    ## Stratospheric Pollution

    ### Ozone Layer

    **Location**: Stratosphere (15-30 km altitude)

    **Formation**:
    - O₂ + UV → O + O (photodissociation, λ < 240 nm)
    - O + O₂ → O₃ (ozone)

    **Importance**: Absorbs harmful UV-B radiation (280-320 nm)
    - UV-A (320-400 nm): Least harmful, passes through
    - UV-B (280-320 nm): Causes skin cancer, cataracts (absorbed by O₃)
    - UV-C (< 280 nm): Most harmful, absorbed by O₂ and O₃

    ### Ozone Depletion

    **Definition**: Reduction in stratospheric ozone concentration, especially over Antarctica ("ozone hole").

    **Causes**: Chlorofluorocarbons (CFCs) and other halogenated compounds

    #### Chemistry of Ozone Depletion

    **CFCs** (e.g., CFCl₃, CF₂Cl₂):
    1. CFCs released at ground level → diffuse to stratosphere
    2. UV radiation breaks C-Cl bond: CF₂Cl₂ + UV → CF₂Cl· + Cl·
    3. Chlorine radical catalyzes O₃ destruction:
       - Cl· + O₃ → ClO· + O₂
       - ClO· + O → Cl· + O₂
       - **Net**: O₃ + O → 2O₂ (Cl· regenerated → catalytic cycle)
    4. One Cl· atom can destroy 100,000 O₃ molecules

    **Other ozone-depleting substances**:
    - Halons (used in fire extinguishers)
    - CCl₄ (carbon tetrachloride)
    - CH₃CCl₃ (methyl chloroform)
    - N₂O (from fertilizers)

    **Effects of Ozone Depletion**:
    - Increased UV-B radiation reaching Earth
    - Skin cancer, melanoma
    - Eye cataracts, cornea damage
    - Suppression of immune system
    - Damage to phytoplankton (affects marine food chain)
    - Crop damage

    **Montreal Protocol (1987)**:
    - International treaty to phase out CFCs
    - Replacement: HFCs (hydrogen-containing, less harmful)
    - Success story: Ozone hole is slowly recovering

    ---

    ## Key Points for IIT JEE

    1. **Tropospheric pollutants**: SO₂, NO₂, CO, CO₂, hydrocarbons, particulates
    2. **Acid rain**: pH < 5.6, caused by SO₂ and NOₓ, damages monuments (marble cancer)
    3. **Classical smog**: Smoke + fog, SO₂ + particulates, reducing in nature
    4. **Photochemical smog**: NO₂ + O₃ + PAN, oxidizing, requires sunlight
    5. **Greenhouse gases**: CO₂ (60%), CH₄ (20%), CFCs (14%), N₂O (6%)
    6. **Global warming**: Enhanced greenhouse effect, rising temperatures, melting ice
    7. **Ozone formation**: O₂ + UV → 2O, O + O₂ → O₃
    8. **Ozone depletion**: CFCs release Cl·, which catalytically destroys O₃
    9. **Montreal Protocol**: International agreement to phase out CFCs

## Key Points

- Tropospheric pollution

- Stratospheric pollution

- Greenhouse gases
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Tropospheric pollution', 'Stratospheric pollution', 'Greenhouse gases', 'Acid rain', 'Smog', 'Ozone depletion'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Water Pollution and Soil Pollution ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Water Pollution and Soil Pollution',
  content: <<~MARKDOWN,
# Water Pollution and Soil Pollution 🚀

# Water Pollution

    ## Definition
    **Water pollution**: Addition of undesirable substances that make water unfit for use.

    **Sources**:
    - Domestic sewage
    - Industrial effluents
    - Agricultural runoff
    - Oil spills
    - Thermal pollution

    ---

    ## Types of Water Pollutants

    ### 1. Pathogens
    - **Sources**: Domestic sewage, animal waste
    - **Examples**: Bacteria, viruses, protozoa
    - **Diseases**: Cholera, typhoid, dysentery, hepatitis
    - **Indicator**: Coliform bacteria count

    ### 2. Organic Matter
    - **Sources**: Sewage, food processing, paper mills
    - **Examples**: Proteins, carbohydrates, fats
    - **Effect**: Oxygen depletion (measured by BOD, COD)

    ### 3. Inorganic Chemicals
    #### Heavy Metals
    - **Examples**: Pb, Hg, Cd, As, Cr
    - **Sources**: Industrial waste, mining, batteries
    - **Effects**:
      - **Mercury (Hg)**: Minamata disease (neurological damage)
      - **Lead (Pb)**: Brain damage, anemia
      - **Cadmium (Cd)**: Itai-itai disease (bone disease)
      - **Arsenic (As)**: Skin cancer, arsenicosis

    #### Nitrates and Phosphates
    - **Sources**: Fertilizers, detergents
    - **Effect**: Eutrophication (excessive nutrient enrichment)

    ### 4. Pesticides
    - **Examples**: DDT, BHC, organophosphates
    - **Effect**: Toxic to aquatic life, biomagnification
    - **Persistence**: DDT is non-biodegradable

    ### 5. Radioactive Substances
    - **Sources**: Nuclear plants, medical waste
    - **Examples**: ¹³¹I, ⁹⁰Sr, ¹³⁷Cs
    - **Effects**: Cancer, genetic mutations

    ### 6. Thermal Pollution
    - **Source**: Cooling water from power plants
    - **Effect**: Reduces dissolved oxygen, affects aquatic life

    ---

    ## Biochemical Oxygen Demand (BOD)

    ### Definition
    **BOD**: Amount of oxygen required by microorganisms to decompose organic matter in water under aerobic conditions.

    **Unit**: mg O₂/L or ppm

    **Measurement**: Oxygen consumed in 5 days at 20°C (BOD₅)

    ### Interpretation
    - **Clean water**: BOD < 5 ppm
    - **Moderately polluted**: BOD 5-15 ppm
    - **Highly polluted**: BOD > 15 ppm

    ### Significance
    - **High BOD** = High organic pollution
    - Microbes consume oxygen → fish and aquatic life suffocate
    - Indicator of water quality

    ---

    ## Chemical Oxygen Demand (COD)

    ### Definition
    **COD**: Amount of oxygen required to chemically oxidize all organic and inorganic matter in water.

    **Method**: Strong oxidizing agent (K₂Cr₂O₇ in acidic medium)

    **Unit**: mg O₂/L or ppm

    ### BOD vs COD

    | Parameter | BOD | COD |
    |-----------|-----|-----|
    | **Oxidation** | Biological (microbes) | Chemical (K₂Cr₂O₇) |
    | **Time** | 5 days | Few hours |
    | **Measures** | Biodegradable organic matter | Total organic + inorganic matter |
    | **Value** | COD > BOD (always) | - |

    **Relationship**: COD includes both biodegradable and non-biodegradable matter, so COD ≥ BOD.

    ---

    ## Eutrophication

    ### Definition
    **Eutrophication**: Excessive nutrient enrichment (especially N and P) in water bodies, leading to algal blooms and oxygen depletion.

    ### Process
    1. **Nutrient input**: Fertilizers (NO₃⁻, PO₄³⁻), detergents (phosphates) enter water
    2. **Algal bloom**: Excessive growth of algae and aquatic plants
    3. **Light blocking**: Dense algae block sunlight → underwater plants die
    4. **Oxygen depletion**:
       - Dead algae decompose
       - Decomposition consumes oxygen (high BOD)
       - Dissolved oxygen drops
    5. **Fish death**: Aquatic animals die due to lack of oxygen (hypoxia)

    ### Effects
    - Death of fish and aquatic organisms
    - Bad smell (anaerobic decomposition → H₂S, CH₄)
    - Water unfit for drinking
    - Loss of biodiversity

    ### Prevention
    - Reduce fertilizer use
    - Phosphate-free detergents
    - Wastewater treatment before discharge
    - Aeration of water bodies

    ---

    ## Water Treatment

    ### 1. Primary Treatment (Physical)
    - **Screening**: Remove large debris
    - **Sedimentation**: Settle suspended solids (sludge)

    ### 2. Secondary Treatment (Biological)
    - **Activated sludge**: Aerobic bacteria decompose organic matter
    - Reduces BOD significantly

    ### 3. Tertiary Treatment (Chemical)
    - **Coagulation**: Alum [Al₂(SO₄)₃] precipitates colloidal particles
    - **Chlorination**: Disinfection (kills pathogens)
    - **Advanced**: Reverse osmosis, activated carbon

    ---

    ## Soil Pollution

    ### Definition
    **Soil pollution**: Contamination of soil by toxic chemicals that reduce fertility and harm organisms.

    ### Sources

    #### 1. Industrial Waste
    - Heavy metals (Pb, Hg, Cd, Cr)
    - Organic solvents
    - Acids and alkalis

    #### 2. Agricultural Chemicals
    ##### Pesticides
    - **Insecticides**: DDT, BHC, organophosphates
    - **Herbicides**: 2,4-D, atrazine
    - **Fungicides**: Sulfur, copper compounds

    **Problems**:
    - **Persistent**: DDT takes decades to degrade
    - **Biomagnification**: Concentration increases in food chain
    - **Non-target effects**: Kills beneficial insects, pollinators

    ##### Fertilizers
    - Excessive use leads to soil acidification
    - Runoff causes water pollution (eutrophication)

    #### 3. Solid Waste
    - **Municipal waste**: Plastics, paper, glass
    - **E-waste**: Electronics (contain heavy metals)
    - **Medical waste**: Syringes, contaminated materials

    ### Effects of Soil Pollution

    1. **Loss of soil fertility**
    2. **Contamination of food chain**: Heavy metals in crops
    3. **Groundwater pollution**: Leaching of pollutants
    4. **Health hazards**: Cancer, birth defects
    5. **Loss of soil organisms**: Earthworms, beneficial bacteria

    ### Remediation

    #### 1. Bioremediation
    - Use of microorganisms to degrade pollutants
    - Example: Pseudomonas bacteria degrade hydrocarbons

    #### 2. Phytoremediation
    - Plants absorb pollutants from soil
    - Example: Sunflower removes heavy metals

    #### 3. Composting
    - Organic waste converted to compost
    - Improves soil quality

    #### 4. Reduce, Reuse, Recycle (3R)
    - Minimize waste generation
    - Recycle plastics, metals, paper

    ---

    ## Case Studies

    ### 1. Minamata Disease (Japan, 1950s)
    - **Cause**: Mercury (Hg) from chemical plant discharged into bay
    - **Effect**: Biomagnification in fish → neurological damage in humans
    - **Symptoms**: Tremors, paralysis, insanity, death

    ### 2. Itai-Itai Disease (Japan, 1950s)
    - **Cause**: Cadmium (Cd) from mining waste
    - **Effect**: Softening of bones, kidney damage
    - **Symptoms**: Severe pain ("itai-itai" = "it hurts, it hurts")

    ### 3. Bhopal Gas Tragedy (India, 1984)
    - **Cause**: Methyl isocyanate (MIC) gas leak from Union Carbide plant
    - **Effect**: 3000+ deaths, thousands affected
    - **Soil pollution**: Site still contaminated

    ---

    ## Key Points for IIT JEE

    1. **BOD**: Biological oxygen demand, indicator of organic pollution, clean water < 5 ppm
    2. **COD**: Chemical oxygen demand, COD > BOD always
    3. **Eutrophication**: Excess nutrients (N, P) → algal bloom → oxygen depletion → fish death
    4. **Heavy metals**: Hg (Minamata disease), Cd (Itai-itai disease), Pb (brain damage)
    5. **Pesticides**: DDT is persistent, non-biodegradable, causes biomagnification
    6. **Water treatment**: Primary (physical), Secondary (biological), Tertiary (chemical)
    7. **Biomagnification**: Concentration of pollutants increases up the food chain
    8. **Bioremediation**: Microorganisms degrade pollutants
    9. **Phytoremediation**: Plants absorb pollutants from soil

## Key Points

- Water pollutants

- BOD

- COD
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Water pollutants', 'BOD', 'COD', 'Eutrophication', 'Soil pollution', 'Pesticides', 'Industrial waste'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Green Chemistry: Principles and Applications ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Green Chemistry: Principles and Applications',
  content: <<~MARKDOWN,
# Green Chemistry: Principles and Applications 🚀

# Green Chemistry

    ## What is Green Chemistry?

    **Definition**: Design of chemical products and processes that reduce or eliminate the use and generation of hazardous substances.

    **Other names**: Sustainable chemistry, environmentally benign chemistry

    **Goal**: Prevention of pollution at the source rather than treatment after generation.

    ---

    ## The 12 Principles of Green Chemistry

    ### 1. Prevention (Waste Prevention)
    **Principle**: Prevent waste rather than treat or clean up after it is formed.

    **Example**:
    - Design reactions with high yield and selectivity
    - Minimize byproducts

    ### 2. Atom Economy
    **Principle**: Design syntheses so maximum amount of starting materials is incorporated into final product.

    **Formula**:
    \\[ \\text{Atom Economy} = \\frac{\\text{Molar mass of desired product}}{\\text{Sum of molar masses of all reactants}} \\times 100\\% \\]

    **Example**:
    - **Addition reactions** (high atom economy): A + B → AB (100%)
    - **Substitution reactions** (lower atom economy): A-B + C → A-C + B (waste B)

    **IIT JEE Example**:
    - **Friedel-Crafts alkylation** (poor atom economy due to AlCl₃ waste)
    - **Hydrogenation** (excellent atom economy)

    ### 3. Less Hazardous Chemical Syntheses
    **Principle**: Use and generate substances with little or no toxicity.

    **Example**:
    - Replace toxic phosgene (COCl₂) in polycarbonate synthesis
    - Avoid carcinogens, mutagens, teratogens

    ### 4. Designing Safer Chemicals
    **Principle**: Design chemicals that are effective yet have minimal toxicity.

    **Example**:
    - Biodegradable detergents (linear alkyl benzene sulfonates)
    - Water-based paints instead of solvent-based

    ### 5. Safer Solvents and Auxiliaries
    **Principle**: Minimize or eliminate auxiliary substances (solvents, separation agents).

    **Green solvents**:
    - **Water**: Best, safest solvent
    - **Supercritical CO₂**: Non-toxic, non-flammable (used in caffeine extraction)
    - **Ionic liquids**: Non-volatile, recyclable
    - **Bio-based solvents**: Ethanol, ethyl lactate

    **Avoid**:
    - Chlorinated solvents (CHCl₃, CCl₄)
    - Benzene (carcinogenic)

    ### 6. Design for Energy Efficiency
    **Principle**: Minimize energy requirements of chemical processes.

    **Strategies**:
    - Conduct reactions at room temperature and pressure
    - Avoid energy-intensive heating/cooling
    - Use catalysts to lower activation energy

    **Example**:
    - Enzymatic reactions at mild conditions
    - Microwave-assisted synthesis

    ### 7. Use of Renewable Feedstocks
    **Principle**: Use renewable raw materials instead of depleting fossil fuels.

    **Examples**:
    - **Biofuels**: Ethanol from biomass
    - **Bioplastics**: PLA (polylactic acid) from corn starch
    - **Bio-based chemicals**: Glycerol, levulinic acid

    ### 8. Reduce Derivatives
    **Principle**: Minimize derivatization (protection/deprotection steps) as they require additional reagents and generate waste.

    **Example**:
    - Direct functionalization instead of protection-deprotection
    - Click chemistry (high selectivity, no protection needed)

    ### 9. Catalysis
    **Principle**: Use catalytic reagents (in small amounts) instead of stoichiometric reagents.

    **Advantages of catalysis**:
    - Reduces waste
    - Increases selectivity
    - Lowers energy requirements

    **Examples**:
    - **Zeolites**: Solid acid catalysts in petroleum cracking
    - **Enzyme catalysis**: Biocatalysis (mild conditions, high selectivity)
    - **Transition metal catalysis**: Pd-catalyzed cross-coupling

    ### 10. Design for Degradation
    **Principle**: Design products to break down into innocuous substances after use.

    **Examples**:
    - **Biodegradable plastics**: PLA, PHB (polyhydroxybutyrate)
    - **Green pesticides**: Neem-based pesticides (degrade quickly)

    **Avoid**:
    - Persistent pollutants (DDT, PCBs)

    ### 11. Real-Time Analysis for Pollution Prevention
    **Principle**: Monitor reactions in real-time to prevent formation of hazardous substances.

    **Tools**:
    - In-line sensors
    - Process analytical technology (PAT)
    - Spectroscopy (IR, NMR) for monitoring

    ### 12. Inherently Safer Chemistry for Accident Prevention
    **Principle**: Choose substances and processes to minimize accidents (explosions, fires, releases).

    **Strategies**:
    - Use less hazardous reagents
    - Lower temperatures and pressures
    - Avoid highly reactive intermediates

    **Example**:
    - Use aqueous H₂O₂ instead of organic peroxides (less explosive)

    ---

    ## Applications of Green Chemistry

    ### 1. Green Solvents

    #### Supercritical CO₂
    - **Properties**: Above critical point (31°C, 73 atm), behaves as both liquid and gas
    - **Uses**:
      - Decaffeination of coffee
      - Dry cleaning (replacing perchloroethylene)
      - Extraction of essential oils

    #### Ionic Liquids
    - Salts that are liquid at room temperature
    - Non-volatile, non-flammable, recyclable
    - Used in synthesis, catalysis

    ### 2. Green Catalysts

    #### Zeolites
    - Microporous aluminosilicates
    - Solid acid catalysts
    - Replace corrosive liquid acids (H₂SO₄, HF)
    - **Uses**: Petroleum cracking, isomerization

    #### Biocatalysts (Enzymes)
    - Highly selective, work at mild conditions
    - **Example**: Lipases for biodiesel production

    ### 3. Biodegradable Polymers

    | Polymer | Source | Uses |
    |---------|--------|------|
    | PLA (Polylactic acid) | Corn starch, sugarcane | Packaging, medical implants |
    | PHB (Polyhydroxybutyrate) | Bacterial fermentation | Biodegradable plastics |
    | PHA (Polyhydroxyalkanoates) | Bacteria | Medical devices |

    ### 4. Greener Synthetic Routes

    #### Ibuprofen Synthesis
    - **Old method**: 6 steps, 40% atom economy
    - **BHC (Boot-Hoechst-Celanese) method**: 3 steps, 77% atom economy
    - **Green improvement**: Catalytic route, fewer solvents

    #### Adipic Acid Synthesis
    - **Old method**: Oxidation of cyclohexane with HNO₃ (produces N₂O, greenhouse gas)
    - **Green method**: Bacterial fermentation from glucose

    ### 5. Alternative Energy

    - **Biofuels**: Ethanol, biodiesel (renewable)
    - **Solar cells**: Photoelectrochemical cells
    - **Fuel cells**: H₂/O₂ fuel cells (clean energy)

    ---

    ## Atom Economy: Quantitative Analysis

    ### Example 1: Addition Reaction
    **Reaction**: Hydrogenation of ethene
    - C₂H₄ + H₂ → C₂H₆

    **Atom economy** = (30/30) × 100% = **100%** (all atoms incorporated)

    ### Example 2: Substitution Reaction
    **Reaction**: Chlorination of methane
    - CH₄ + Cl₂ → CH₃Cl + HCl

    **Desired product**: CH₃Cl (molar mass = 50.5 g/mol)
    **Total reactants**: CH₄ (16) + Cl₂ (71) = 87 g/mol

    **Atom economy** = (50.5/87) × 100% = **58%** (HCl is waste)

    ### Example 3: Elimination Reaction
    **Reaction**: Dehydration of ethanol
    - C₂H₅OH → C₂H₄ + H₂O

    **Desired product**: C₂H₄ (molar mass = 28 g/mol)
    **Total reactants**: C₂H₅OH = 46 g/mol

    **Atom economy** = (28/46) × 100% = **61%**

    ---

    ## Benefits of Green Chemistry

    1. **Environmental**: Reduces pollution, waste, and resource depletion
    2. **Economic**: Saves money (less waste disposal, more efficient)
    3. **Safety**: Fewer hazardous chemicals, lower accident risk
    4. **Sustainability**: Ensures resources for future generations

    ---

    ## Challenges

    1. **Cost**: Green processes may be initially expensive
    2. **Performance**: Some green alternatives may be less effective
    3. **Scale-up**: Laboratory success may not translate to industrial scale
    4. **Awareness**: Need for education and training

    ---

    ## IIT JEE Examples

    ### Problem 1: Calculate Atom Economy
    **Question**: Calculate atom economy for the synthesis of ethyl acetate:
    - CH₃COOH + C₂H₅OH → CH₃COOC₂H₅ + H₂O

    **Solution**:
    - Desired product: CH₃COOC₂H₅ (molar mass = 88 g/mol)
    - Total reactants: CH₃COOH (60) + C₂H₅OH (46) = 106 g/mol
    - Atom economy = (88/106) × 100% = **83%**

    ### Problem 2: Compare Green Alternatives
    **Question**: Which is greener: chlorination or bromination of alkanes?

    **Answer**: **Bromination** is greener because:
    - More selective (less byproducts)
    - Milder conditions (no UV needed, just light)
    - Higher atom economy

    ---

    ## Key Points for IIT JEE

    1. **12 Principles**: Prevention, atom economy, less hazardous syntheses, safer chemicals, safer solvents, energy efficiency, renewable feedstocks, reduce derivatives, catalysis, degradation, real-time analysis, inherently safer
    2. **Atom economy** = (Molar mass of product / Molar mass of reactants) × 100%
    3. **Green solvents**: Water, supercritical CO₂, ionic liquids
    4. **Addition reactions**: 100% atom economy (ideal)
    5. **Catalysis**: Reduces waste, increases selectivity, uses small amounts
    6. **Biodegradable plastics**: PLA, PHB, PHA
    7. **Zeolites**: Solid acid catalysts, replace liquid acids
    8. **Supercritical CO₂**: Used in decaffeination, dry cleaning
    9. **Prevention > treatment**: Stop pollution at source

## Key Points

- Green chemistry principles

- Atom economy

- Safer solvents
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Green chemistry principles', 'Atom economy', 'Safer solvents', 'Biodegradable products', 'Energy efficiency'],
  prerequisite_ids: []
)

# === MICROLESSON 7: greenhouse_gases — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'greenhouse_gases — Practice',
  content: <<~MARKDOWN,
# greenhouse_gases — Practice 🚀

CO₂ contributes about 60% to global warming, followed by CH₄ (20%), CFCs (14%), and N₂O (6%). CO₂ from fossil fuel combustion is the primary greenhouse gas.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['greenhouse_gases'],
  prerequisite_ids: []
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which gas is the major contributor to global warming?',
    options: ['CH₄ (Methane)', 'CO₂ (Carbon dioxide)', 'N₂O (Nitrous oxide)', 'CFCs'],
    correct_answer: 1,
    explanation: 'CO₂ contributes about 60% to global warming, followed by CH₄ (20%), CFCs (14%), and N₂O (6%). CO₂ from fossil fuel combustion is the primary greenhouse gas.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: acid_rain — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'acid_rain — Practice',
  content: <<~MARKDOWN,
# acid_rain — Practice 🚀

Acid rain is caused by SO₂ and NOₓ, which form H₂SO₄ and HNO₃ in the atmosphere. Normal rain has pH ~5.6, while acid rain has pH < 5.6.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['acid_rain'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Acid rain is primarily caused by:',
    options: ['CO₂ and CH₄', 'SO₂ and NOₓ', 'O₃ and CFCs', 'CO and hydrocarbons'],
    correct_answer: 1,
    explanation: 'Acid rain is caused by SO₂ and NOₓ, which form H₂SO₄ and HNO₃ in the atmosphere. Normal rain has pH ~5.6, while acid rain has pH < 5.6.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: acid_rain — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'acid_rain — Practice',
  content: <<~MARKDOWN,
# acid_rain — Practice 🚀

Normal rain has pH ~5.6 because atmospheric CO₂ dissolves to form weak carbonic acid: CO₂ + H₂O → H₂CO₃. Acid rain has pH < 5.6 due to SO₂ and NOₓ.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['acid_rain'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The pH of normal rainwater is approximately ________ due to dissolved CO₂.',
    answer: '5.6',
    explanation: 'Normal rain has pH ~5.6 because atmospheric CO₂ dissolves to form weak carbonic acid: CO₂ + H₂O → H₂CO₃. Acid rain has pH < 5.6 due to SO₂ and NOₓ.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: smog — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'smog — Practice',
  content: <<~MARKDOWN,
# smog — Practice 🚀

Photochemical smog (Los Angeles type) forms in warm, sunny conditions and contains NO₂, O₃, and PAN. It is oxidizing in nature. Classical smog (London type) contains SO₂ and forms in cool, humid conditions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['smog'],
  prerequisite_ids: []
)

# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following are characteristics of photochemical smog?',
    options: ['Contains NO₂, O₃, and PAN', 'Forms in sunny, warm conditions', 'Contains high SO₂', 'Forms in cool, humid conditions'],
    correct_answer: 1,
    explanation: 'Photochemical smog (Los Angeles type) forms in warm, sunny conditions and contains NO₂, O₃, and PAN. It is oxidizing in nature. Classical smog (London type) contains SO₂ and forms in cool, humid conditions.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 11: ozone_depletion — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'ozone_depletion — Practice',
  content: <<~MARKDOWN,
# ozone_depletion — Practice 🚀

Chlorine radicals from CFCs catalytically destroy ozone: Cl· + O₃ → ClO· + O₂, ClO· + O → Cl· + O₂. One Cl· can destroy 100,000 O₃ molecules. This is the mechanism of ozone layer depletion.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['ozone_depletion'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which of the following catalytically destroys ozone in the stratosphere?',
    options: ['CO₂', 'Cl· (chlorine radical from CFCs)', 'O₂', 'N₂'],
    correct_answer: 1,
    explanation: 'Chlorine radicals from CFCs catalytically destroy ozone: Cl· + O₃ → ClO· + O₂, ClO· + O → Cl· + O₂. One Cl· can destroy 100,000 O₃ molecules. This is the mechanism of ozone layer depletion.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 12: bod_calculation — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'bod_calculation — Practice',
  content: <<~MARKDOWN,
# bod_calculation — Practice 🚀

Pollution factor = 18 / 5 = 3.6. The water sample is 3.6 times more polluted than the upper limit of clean water. Water with BOD > 15 ppm is considered highly polluted.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['bod_calculation'],
  prerequisite_ids: []
)

# Exercise 12.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'If clean water has BOD < 5 ppm and a water sample has BOD = 18 ppm, calculate how many times more polluted this water is compared to the upper limit of clean water. (Answer as a decimal)',
    answer: '3.6',
    explanation: 'Pollution factor = 18 / 5 = 3.6. The water sample is 3.6 times more polluted than the upper limit of clean water. Water with BOD > 15 ppm is considered highly polluted.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 13: bod_cod — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'bod_cod — Practice',
  content: <<~MARKDOWN,
# bod_cod — Practice 🚀

TRUE. COD measures total organic and inorganic matter (chemical oxidation), while BOD measures only biodegradable organic matter (biological oxidation). Therefore, COD ≥ BOD always.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['bod_cod'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'COD (Chemical Oxygen Demand) is always greater than or equal to BOD (Biochemical Oxygen Demand) for the same water sample.',
    answer: 'true',
    explanation: 'TRUE. COD measures total organic and inorganic matter (chemical oxidation), while BOD measures only biodegradable organic matter (biological oxidation). Therefore, COD ≥ BOD always.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: eutrophication — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'eutrophication — Practice',
  content: <<~MARKDOWN,
# eutrophication — Practice 🚀

Eutrophication is caused by excessive nutrients (nitrogen and phosphorus) from fertilizers and detergents. This leads to algal blooms, oxygen depletion, and death of aquatic life.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['eutrophication'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Eutrophication of water bodies is primarily caused by excessive:',
    options: ['Heavy metals', 'Nitrogen and phosphorus', 'CO₂', 'Organic solvents'],
    correct_answer: 1,
    explanation: 'Eutrophication is caused by excessive nutrients (nitrogen and phosphorus) from fertilizers and detergents. This leads to algal blooms, oxygen depletion, and death of aquatic life.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 15: atom_economy — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'atom_economy — Practice',
  content: <<~MARKDOWN,
# atom_economy — Practice 🚀

Atom economy = (Molar mass of product / Sum of molar masses of reactants) × 100% = (30 / (28 + 2)) × 100% = (30/30) × 100% = 100%. This is an addition reaction with perfect atom economy.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['atom_economy'],
  prerequisite_ids: []
)

# Exercise 15.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Calculate the atom economy (%) for the reaction: C₂H₄ + H₂ → C₂H₆ (Molar masses: C₂H₄ = 28, H₂ = 2, C₂H₆ = 30)',
    answer: '100',
    explanation: 'Atom economy = (Molar mass of product / Sum of molar masses of reactants) × 100% = (30 / (28 + 2)) × 100% = (30/30) × 100% = 100%. This is an addition reaction with perfect atom economy.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 16: Air Pollution: Tropospheric and Stratospheric ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Air Pollution: Tropospheric and Stratospheric',
  content: <<~MARKDOWN,
# Air Pollution: Tropospheric and Stratospheric 🚀

# Air Pollution

    ## Atmosphere Structure

    The atmosphere is divided into layers:

    | Layer | Altitude | Characteristics |
    |-------|----------|-----------------|
    | **Troposphere** | 0-10 km | Weather phenomena, 99% of water vapor |
    | **Stratosphere** | 10-50 km | Ozone layer (15-30 km) |
    | **Mesosphere** | 50-85 km | Coldest layer |
    | **Thermosphere** | 85-600 km | Very high temperature |

    **Focus**: Environmental chemistry primarily concerns troposphere and stratosphere.

    ---

    ## Tropospheric Pollution

    **Troposphere**: Lowest layer where we live and breathe.

    ### Major Air Pollutants

    #### 1. Gaseous Pollutants

    ##### A. Oxides of Sulfur (SOₓ)
    **Sources**:
    - Combustion of fossil fuels (coal, petroleum)
    - Smelting of sulfide ores
    - Volcanic eruptions

    **Main pollutants**: SO₂ and SO₃

    **Effects**:
    - **Respiratory problems**: Asthma, bronchitis
    - **Acid rain**: SO₂ + H₂O → H₂SO₃, SO₃ + H₂O → H₂SO₄
    - **Corrosion**: Damages buildings, monuments (marble cancer)
    - **Plant damage**: Chlorosis (yellowing of leaves)

    ##### B. Oxides of Nitrogen (NOₓ)
    **Sources**:
    - Automobile exhausts (high temperature combustion)
    - Power plants
    - Lightning

    **Formation**:
    - N₂ + O₂ → 2NO (at high temperature ~1500°C in engines)
    - 2NO + O₂ → 2NO₂ (brown gas)

    **Effects**:
    - **Acid rain**: NO₂ + H₂O → HNO₃
    - **Photochemical smog**: NO₂ + sunlight → NO + O·
    - **Respiratory irritation**
    - **Reduces oxygen-carrying capacity**: NO binds to hemoglobin

    ##### C. Carbon Monoxide (CO)
    **Sources**:
    - Incomplete combustion of fossil fuels
    - Automobile exhausts (major source)
    - Cigarette smoke

    **Properties**:
    - Colorless, odorless, tasteless
    - Toxic gas

    **Effects**:
    - **Fatal poison**: Binds to hemoglobin (200 times stronger than O₂)
    - CO + Hb → COHb (carboxyhemoglobin, stable, blocks O₂ transport)
    - Causes headache, dizziness, unconsciousness, death

    ##### D. Carbon Dioxide (CO₂)
    **Sources**:
    - Combustion of fossil fuels
    - Respiration
    - Deforestation

    **Effects**:
    - **Greenhouse gas**: Major contributor to global warming
    - Normal concentration: 0.03-0.04% (increasing)
    - Not toxic but excessive CO₂ causes climate change

    ##### E. Hydrocarbons (CₓHᵧ)
    **Sources**:
    - Automobile exhausts
    - Petroleum refineries
    - Incomplete combustion

    **Effects**:
    - Photochemical smog formation
    - Some are carcinogenic (benzene, PAHs)

    #### 2. Particulate Pollutants

    **Types**:
    - **Smoke**: Carbon particles from combustion
    - **Dust**: Soil particles, pollen, spores
    - **Mist**: Liquid droplets suspended in air
    - **Fumes**: Solid particles from metallurgical processes

    **Effects**:
    - Respiratory diseases
    - Reduces visibility
    - Soiling of materials

    ---

    ## Acid Rain

    ### Definition
    Rain with **pH < 5.6** (normal rain pH ~5.6 due to dissolved CO₂)

    ### Formation

    #### From SO₂:
    - 2SO₂ + O₂ → 2SO₃
    - SO₃ + H₂O → H₂SO₄ (sulfuric acid)

    #### From NOₓ:
    - 4NO₂ + O₂ + 2H₂O → 4HNO₃ (nitric acid)

    ### Effects

    1. **Soil acidification**: Leaching of nutrients (Ca²⁺, Mg²⁺), release of toxic Al³⁺
    2. **Water bodies**: Acidification kills fish and aquatic life
    3. **Buildings and monuments**:
       - **Marble cancer**: CaCO₃ + H₂SO₄ → CaSO₄ + H₂O + CO₂
       - Taj Mahal damage (SO₂ from Mathura refinery)
    4. **Vegetation damage**: Chlorosis, reduced growth
    5. **Corrosion**: Metal structures corrode faster

    ### Control
    - Use low-sulfur fuels
    - Flue gas desulfurization (scrubbers)
    - Catalytic converters in vehicles
    - Liming of soil and water bodies

    ---

    ## Smog

    ### Types of Smog

    #### 1. Classical Smog (London Smog)
    **Composition**: Smoke + Fog (hence "smog")

    **Conditions**:
    - Cool, humid climate
    - High SO₂ and particulate matter

    **Chemistry**:
    - SO₂ + H₂O (in fog droplets) → H₂SO₃
    - Particulates worsen visibility

    **Effects**: Respiratory problems, reduced visibility

    **Example**: London smog disaster (1952, 4000 deaths)

    #### 2. Photochemical Smog (Los Angeles Smog)
    **Composition**: NO₂ + O₃ + PAN (peroxyacetyl nitrate) + hydrocarbons

    **Conditions**:
    - Warm, dry, sunny climate
    - High automobile traffic

    **Formation**:
    1. NO₂ + sunlight → NO + O· (oxygen radical)
    2. O· + O₂ → O₃ (ozone)
    3. Hydrocarbons + O· → Aldehydes, PAN

    **Characteristics**:
    - Brown haze
    - Oxidizing nature
    - Peak at noon (maximum sunlight)

    **Effects**:
    - Eye irritation (tears)
    - Respiratory problems
    - Plant damage (ozone damages stomata)
    - Rubber cracking

    **Control**:
    - Catalytic converters (convert NO to N₂)
    - Use of CNG (cleaner fuel)
    - Public transport, electric vehicles

    ---

    ## Greenhouse Effect and Global Warming

    ### Greenhouse Effect

    **Definition**: Warming of Earth's surface due to trapping of infrared radiation by greenhouse gases.

    **Mechanism**:
    1. Solar radiation (UV, visible) passes through atmosphere
    2. Earth absorbs and re-emits as infrared (heat)
    3. Greenhouse gases absorb infrared → warm atmosphere
    4. Natural greenhouse effect maintains Earth's temperature (~15°C average)

    **Without greenhouse effect**: Earth's temperature would be -18°C (too cold for life)

    ### Greenhouse Gases

    | Gas | Sources | Contribution to Warming |
    |-----|---------|------------------------|
    | **CO₂** | Fossil fuel combustion, deforestation | 60% |
    | **CH₄** | Paddy fields, livestock, landfills, natural gas | 20% |
    | **CFC** | Refrigerants, aerosols | 14% |
    | **N₂O** | Fertilizers, combustion | 6% |

    **Note**: CH₄ is 25 times more potent than CO₂ as a greenhouse gas.

    ### Global Warming

    **Definition**: Increase in Earth's average temperature due to enhanced greenhouse effect.

    **Causes**:
    - Increased CO₂ from fossil fuels
    - Deforestation (less CO₂ absorption)
    - Increased CH₄ from agriculture

    **Observed Effects**:
    - Average temperature increased by ~1°C since pre-industrial era
    - Melting glaciers and ice caps
    - Rising sea levels (thermal expansion + melting ice)
    - Extreme weather events (hurricanes, droughts)
    - Coral bleaching
    - Shift in climate zones

    **Predicted Effects**:
    - Sea level rise → flooding of coastal cities
    - Species extinction
    - Agricultural disruption
    - Spread of diseases

    **Mitigation**:
    - Reduce fossil fuel use
    - Renewable energy (solar, wind)
    - Reforestation
    - Carbon capture and storage
    - International agreements (Paris Agreement)

    ---

    ## Stratospheric Pollution

    ### Ozone Layer

    **Location**: Stratosphere (15-30 km altitude)

    **Formation**:
    - O₂ + UV → O + O (photodissociation, λ < 240 nm)
    - O + O₂ → O₃ (ozone)

    **Importance**: Absorbs harmful UV-B radiation (280-320 nm)
    - UV-A (320-400 nm): Least harmful, passes through
    - UV-B (280-320 nm): Causes skin cancer, cataracts (absorbed by O₃)
    - UV-C (< 280 nm): Most harmful, absorbed by O₂ and O₃

    ### Ozone Depletion

    **Definition**: Reduction in stratospheric ozone concentration, especially over Antarctica ("ozone hole").

    **Causes**: Chlorofluorocarbons (CFCs) and other halogenated compounds

    #### Chemistry of Ozone Depletion

    **CFCs** (e.g., CFCl₃, CF₂Cl₂):
    1. CFCs released at ground level → diffuse to stratosphere
    2. UV radiation breaks C-Cl bond: CF₂Cl₂ + UV → CF₂Cl· + Cl·
    3. Chlorine radical catalyzes O₃ destruction:
       - Cl· + O₃ → ClO· + O₂
       - ClO· + O → Cl· + O₂
       - **Net**: O₃ + O → 2O₂ (Cl· regenerated → catalytic cycle)
    4. One Cl· atom can destroy 100,000 O₃ molecules

    **Other ozone-depleting substances**:
    - Halons (used in fire extinguishers)
    - CCl₄ (carbon tetrachloride)
    - CH₃CCl₃ (methyl chloroform)
    - N₂O (from fertilizers)

    **Effects of Ozone Depletion**:
    - Increased UV-B radiation reaching Earth
    - Skin cancer, melanoma
    - Eye cataracts, cornea damage
    - Suppression of immune system
    - Damage to phytoplankton (affects marine food chain)
    - Crop damage

    **Montreal Protocol (1987)**:
    - International treaty to phase out CFCs
    - Replacement: HFCs (hydrogen-containing, less harmful)
    - Success story: Ozone hole is slowly recovering

    ---

    ## Key Points for IIT JEE

    1. **Tropospheric pollutants**: SO₂, NO₂, CO, CO₂, hydrocarbons, particulates
    2. **Acid rain**: pH < 5.6, caused by SO₂ and NOₓ, damages monuments (marble cancer)
    3. **Classical smog**: Smoke + fog, SO₂ + particulates, reducing in nature
    4. **Photochemical smog**: NO₂ + O₃ + PAN, oxidizing, requires sunlight
    5. **Greenhouse gases**: CO₂ (60%), CH₄ (20%), CFCs (14%), N₂O (6%)
    6. **Global warming**: Enhanced greenhouse effect, rising temperatures, melting ice
    7. **Ozone formation**: O₂ + UV → 2O, O + O₂ → O₃
    8. **Ozone depletion**: CFCs release Cl·, which catalytically destroys O₃
    9. **Montreal Protocol**: International agreement to phase out CFCs

## Key Points

- Tropospheric pollution

- Stratospheric pollution

- Greenhouse gases
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Tropospheric pollution', 'Stratospheric pollution', 'Greenhouse gases', 'Acid rain', 'Smog', 'Ozone depletion'],
  prerequisite_ids: []
)

puts "✓ Created 16 microlessons for Environmental Chemistry"

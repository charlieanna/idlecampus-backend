# AUTO-GENERATED from module_11_kinetics.rb
puts "Creating Microlessons for Chemical Kinetics..."

module_var = CourseModule.find_by(slug: 'chemical-kinetics')

# === MICROLESSON 1: first_order_kinetics — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'first_order_kinetics — Practice',
  content: <<~MARKDOWN,
# first_order_kinetics — Practice 🚀

87.5% complete means 12.5% remains (1/8 of original). [A]/[A]₀ = 1/8 = 1/2³. This is 3 half-lives. Time = 3 × 10 = 30 minutes.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['first_order_kinetics'],
  prerequisite_ids: []
)

# Exercise 1.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For first order reaction, what time is required for 87.5% completion if t₁/₂ = 10 min?',
    answer: '30',
    explanation: '87.5% complete means 12.5% remains (1/8 of original). [A]/[A]₀ = 1/8 = 1/2³. This is 3 half-lives. Time = 3 × 10 = 30 minutes.',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 2: Integrated Rate Laws, Half-Life and Arrhenius Equation ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Integrated Rate Laws, Half-Life and Arrhenius Equation',
  content: <<~MARKDOWN,
# Integrated Rate Laws, Half-Life and Arrhenius Equation 🚀

# Integrated Rate Laws, Half-Life and Arrhenius Equation

    ## Integrated Rate Laws

    **Purpose:** Relate concentration to time

    ### Zero Order Reaction:

    **A → Products**

    **Rate = k** (independent of [A])

    **Differential form:** -d[A]/dt = k

    **Integrated form:** **[A] = [A]₀ - kt**

    Or: **[A]₀ - [A] = kt**

    **Graph:** [A] vs t → **straight line**, slope = -k

    **Units of k:** mol L⁻¹ s⁻¹

    **Example:** Photochemical reactions, surface catalyzed reactions

    ### First Order Reaction:

    **A → Products**

    **Rate = k[A]**

    **Differential form:** -d[A]/dt = k[A]

    **Integrated form:**

    **ln[A] = ln[A]₀ - kt**

    Or: **ln([A]₀/[A]) = kt**

    Or: **log([A]₀/[A]) = kt/2.303**

    Or: **[A] = [A]₀e^(-kt)**

    **Graph:** ln[A] vs t → **straight line**, slope = -k

    **Units of k:** s⁻¹ or time⁻¹

    **Examples:** Radioactive decay, N₂O₅ decomposition

    ### Second Order Reaction:

    **Type 1: A + A → Products** (Rate = k[A]²)

    **Integrated form:**

    **1/[A] = 1/[A]₀ + kt**

    Or: **1/[A] - 1/[A]₀ = kt**

    **Graph:** 1/[A] vs t → **straight line**, slope = k

    **Type 2: A + B → Products** (Rate = k[A][B], if [A]₀ = [B]₀)

    Same as Type 1

    **Units of k:** L mol⁻¹ s⁻¹ or M⁻¹ s⁻¹

    **Example:** 2HI → H₂ + I₂

    ## Summary: Integrated Rate Laws

    | Order | Integrated Form | Linear Plot | Slope | Units of k |
    |-------|-----------------|-------------|-------|------------|
    | 0 | [A] = [A]₀ - kt | [A] vs t | -k | mol L⁻¹ s⁻¹ |
    | 1 | ln[A] = ln[A]₀ - kt | ln[A] vs t | -k | s⁻¹ |
    | 2 | 1/[A] = 1/[A]₀ + kt | 1/[A] vs t | +k | L mol⁻¹ s⁻¹ |

    ## Half-Life (t₁/₂)

    **Definition:** Time required for concentration to reduce to half of initial value

    **At t = t₁/₂:** [A] = [A]₀/2

    ### Zero Order:

    **[A]₀/2 = [A]₀ - kt₁/₂**

    **t₁/₂ = [A]₀/(2k)**

    **t₁/₂ ∝ [A]₀** (depends on initial concentration)

    ### First Order:

    **ln([A]₀/([A]₀/2)) = kt₁/₂**
    **ln 2 = kt₁/₂**

    **t₁/₂ = 0.693/k = ln 2/k**

    **t₁/₂ is constant** (independent of initial concentration)

    This is characteristic of first order!

    ### Second Order:

    **1/([A]₀/2) = 1/[A]₀ + kt₁/₂**

    **t₁/₂ = 1/(k[A]₀)**

    **t₁/₂ ∝ 1/[A]₀** (inversely proportional)

    ## Comparison of Half-Lives

    | Order | t₁/₂ Formula | Depends on [A]₀? |
    |-------|--------------|------------------|
    | 0 | [A]₀/(2k) | Yes (∝ [A]₀) |
    | 1 | 0.693/k | No (constant) |
    | 2 | 1/(k[A]₀) | Yes (∝ 1/[A]₀) |

    ## First Order Reaction Calculations

    ### Important Relations:

    **1. Number of half-lives:**

    After n half-lives: **[A] = [A]₀/(2ⁿ)**

    **2. Time for x% completion:**

    If x% reacted, (100-x)% remains

    **t = (2.303/k) log(100/(100-x))**

    **3. Time to reduce to 1/n of initial:**

    **t = (2.303/k) log n**

    ## Solved Problems: Integrated Rate Laws

    ### Problem 1: Zero order

    **Q: For zero order reaction, [A]₀ = 0.8 M, k = 0.02 M/s. Find [A] after 10 s.**

    Solution:
    [A] = [A]₀ - kt = 0.8 - 0.02 × 10
    **[A] = 0.6 M**

    ### Problem 2: First order - find k

    **Q: For first order reaction, 75% completed in 60 min. Find k.**

    Solution:
    - 75% completed → 25% remains
    - [A]/[A]₀ = 0.25

    k = (2.303/t) log([A]₀/[A])
    k = (2.303/60) log(1/0.25)
    k = (2.303/60) log 4
    k = (2.303/60) × 0.602
    **k = 0.0231 min⁻¹**

    ### Problem 3: First order - half-life

    **Q: For first order reaction, k = 0.0693 min⁻¹. Find t₁/₂.**

    Solution:
    t₁/₂ = 0.693/k = 0.693/0.0693
    **t₁/₂ = 10 min**

    ### Problem 4: First order - after n half-lives

    **Q: After 3 half-lives, what % of reactant remains?**

    Solution:
    [A] = [A]₀/(2³) = [A]₀/8
    **% remaining = 12.5%**
    **% reacted = 87.5%**

    ### Problem 5: Second order

    **Q: For 2A → Products (second order), [A]₀ = 0.1 M, k = 0.5 M⁻¹s⁻¹. Find [A] after 10 s.**

    Solution:
    1/[A] = 1/[A]₀ + kt
    1/[A] = 1/0.1 + 0.5 × 10
    1/[A] = 10 + 5 = 15
    **[A] = 1/15 = 0.067 M**

    ### Problem 6: Determine order from half-life

    **Q: Half-life of reaction doubles when initial concentration is halved. Find order.**

    Solution:
    - For zero order: t₁/₂ ∝ [A]₀ → halving [A]₀ halves t₁/₂ ✗
    - For first order: t₁/₂ constant → no change ✗
    - For second order: t₁/₂ ∝ 1/[A]₀ → halving [A]₀ doubles t₁/₂ ✓

    **Order = 2** (second order)

    ## Arrhenius Equation

    **Statement:** Rate constant increases exponentially with temperature

    **k = Ae^(-Ea/RT)**

    Where:
    - k = rate constant
    - A = pre-exponential factor (frequency factor)
    - Ea = activation energy (J/mol)
    - R = 8.314 J/(mol·K)
    - T = temperature (K)

    ### Logarithmic Form:

    **ln k = ln A - Ea/(RT)**

    Or: **log k = log A - Ea/(2.303RT)**

    **Graph:** log k vs 1/T → straight line
    - Slope = -Ea/(2.303R)
    - Intercept = log A

    ## Activation Energy (Ea)

    **Definition:** Minimum energy required for reaction to occur

    **Higher Ea** → Slower reaction
    **Lower Ea** → Faster reaction

    ### Effect of Temperature:

    At two different temperatures:

    **ln(k₂/k₁) = (Ea/R)(1/T₁ - 1/T₂)**

    Or: **log(k₂/k₁) = (Ea/2.303R)(T₂-T₁)/(T₁T₂)**

    Or: **log(k₂/k₁) = (Ea/2.303R)(ΔT)/(T₁T₂)**

    ### Determination of Ea:

    **Method 1:** Plot log k vs 1/T, slope = -Ea/(2.303R)

    **Method 2:** Use k at two temperatures:
    Ea = (2.303R log(k₂/k₁))/(1/T₁ - 1/T₂)

    ## Solved Problems: Arrhenius Equation

    ### Problem 1: Calculate Ea

    **Q: Rate constant doubles when temperature increases from 300 K to 310 K. Calculate Ea. (R = 8.314 J/mol·K)**

    Solution:
    k₂/k₁ = 2, T₁ = 300 K, T₂ = 310 K

    log(k₂/k₁) = (Ea/2.303R)(T₂-T₁)/(T₁T₂)
    log 2 = (Ea/(2.303 × 8.314)) × (10)/(300 × 310)
    0.301 = (Ea/19.15) × (10/93,000)
    0.301 = Ea/(19.15 × 9,300)
    Ea = 0.301 × 178,095
    **Ea ≈ 53,607 J/mol = 53.6 kJ/mol**

    ### Problem 2: Calculate k at different T

    **Q: k = 0.01 s⁻¹ at 300 K, Ea = 50 kJ/mol. Find k at 320 K.**

    Solution:
    log(k₂/k₁) = (Ea/2.303R)(T₂-T₁)/(T₁T₂)
    log(k₂/0.01) = (50,000/(2.303 × 8.314)) × (20)/(300 × 320)
    log(k₂/0.01) = 2612.4 × (20/96,000)
    log(k₂/0.01) = 0.544
    k₂/0.01 = 10^0.544 = 3.5
    **k₂ = 0.035 s⁻¹**

    ### Problem 3: Effect of catalyst

    **Q: Catalyst reduces Ea from 100 kJ to 80 kJ at 300 K. Find ratio k_catalyzed/k_uncatalyzed.**

    Solution:
    ln(k₂/k₁) = (ΔEa)/(RT) = (Ea1 - Ea2)/(RT)
    = (100,000 - 80,000)/(8.314 × 300)
    = 20,000/2,494.2 = 8.02

    k₂/k₁ = e^8.02 = **3,032**

    Catalyst increases rate by ~3000 times!

    ## Collision Theory

    **Statement:** For reaction to occur:
    1. Molecules must collide
    2. With sufficient energy (≥ Ea)
    3. With proper orientation

    **Rate ∝ (Collision frequency) × (Fraction with E ≥ Ea) × (Orientation factor)**

    **Fraction with E ≥ Ea = e^(-Ea/RT)** (Boltzmann distribution)

    This explains Arrhenius equation!

    ## IIT JEE Key Points

    1. **Zero order:** [A] = [A]₀ - kt, t₁/₂ = [A]₀/(2k)
    2. **First order:** ln[A] = ln[A]₀ - kt, t₁/₂ = 0.693/k
    3. **Second order:** 1/[A] = 1/[A]₀ + kt, t₁/₂ = 1/(k[A]₀)
    4. **First order t₁/₂:** Independent of [A]₀
    5. **After n half-lives:** [A] = [A]₀/(2ⁿ)
    6. **Arrhenius:** k = Ae^(-Ea/RT)
    7. **log(k₂/k₁) = (Ea/2.303R)(ΔT)/(T₁T₂)**
    8. **Higher Ea:** Slower reaction
    9. **Catalyst:** Lowers Ea
    10. **Collision theory:** E ≥ Ea + proper orientation

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Zero order | [A] = [A]₀ - kt |
    | First order | ln([A]₀/[A]) = kt |
    | Second order | 1/[A] - 1/[A]₀ = kt |
    | t₁/₂ (0th order) | [A]₀/(2k) |
    | t₁/₂ (1st order) | 0.693/k |
    | t₁/₂ (2nd order) | 1/(k[A]₀) |
    | Arrhenius | ln k = ln A - Ea/RT |
    | Ea from two T | (2.303R log(k₂/k₁))/(1/T₁-1/T₂) |

    ## Important Constants

    - **R** = 8.314 J/(mol·K)
    - **ln 2** = 0.693
    - **log 2** = 0.301
    - **2.303** = conversion factor (ln to log)

## Key Points

- Integrated rate laws

- Zero order kinetics

- First order kinetics
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Integrated rate laws', 'Zero order kinetics', 'First order kinetics', 'Second order kinetics', 'Half-life', 'Arrhenius equation', 'Activation energy'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Catalysis, Reaction Mechanisms and Temperature Effects ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Catalysis, Reaction Mechanisms and Temperature Effects',
  content: <<~MARKDOWN,
# Catalysis, Reaction Mechanisms and Temperature Effects 🚀

# Catalysis, Reaction Mechanisms and Temperature Effects

    ## Catalysis

    **Catalyst:** Substance that increases rate of reaction without being consumed

    **Functions:**
    1. Provides alternate pathway with **lower activation energy**
    2. Increases rate of both forward and backward reactions equally
    3. **Does not change equilibrium position or K**
    4. Needed in small amounts
    5. Specific for particular reactions

    ### Energy Profile:

    **Without catalyst:** Higher Ea
    **With catalyst:** Lower Ea (faster reaction)

    ΔH (enthalpy change) remains same!

    ## Types of Catalysis

    ### 1. Homogeneous Catalysis

    **Definition:** Catalyst and reactants in **same phase**

    **Examples:**

    **a) NO in lead chamber process:**
    2SO₂(g) + O₂(g) → 2SO₃(g) [catalyzed by NO(g)]

    **b) Acid catalysis:**
    Ester hydrolysis: CH₃COOC₂H₅ + H₂O → CH₃COOH + C₂H₅OH [H⁺ catalyst]

    **c) Base catalysis:**
    Aldol condensation catalyzed by OH⁻

    ### 2. Heterogeneous Catalysis

    **Definition:** Catalyst and reactants in **different phases**

    **Usually:** Solid catalyst, gaseous/liquid reactants

    **Mechanism - Adsorption Theory:**

    1. **Adsorption:** Reactants adsorbed on catalyst surface
    2. **Activation:** Bonds weakened, activated complex formed
    3. **Reaction:** Products formed on surface
    4. **Desorption:** Products leave surface, catalyst regenerated

    **Examples:**

    **a) Haber process (NH₃ synthesis):**
    N₂(g) + 3H₂(g) → 2NH₃(g) [Fe catalyst]

    **b) Hydrogenation of oils:**
    Vegetable oil + H₂ → Saturated fat [Ni catalyst]

    **c) Ostwald process (HNO₃ production):**
    4NH₃ + 5O₂ → 4NO + 6H₂O [Pt catalyst]

    **d) Contact process (H₂SO₄):**
    2SO₂ + O₂ → 2SO₃ [V₂O₅ catalyst]

    **e) Catalytic converter (automobiles):**
    2CO + 2NO → 2CO₂ + N₂ [Pt-Pd-Rh catalyst]

    ### Important Points - Heterogeneous Catalysis:

    1. **Surface phenomenon** (depends on surface area)
    2. **Adsorption is key step**
    3. Catalyst should have:
       - Moderate bond strength with reactants
       - High surface area (finely divided or porous)
    4. **Catalyst poisoning:** Impurities block active sites
       - Example: S, Pb poison Pt catalyst

    ### 3. Enzyme Catalysis (Biochemical)

    **Enzymes:** Biological catalysts (proteins)

    **Characteristics:**
    1. **Highly specific** (one enzyme → one reaction)
    2. **Very efficient** (increase rate by 10⁶ to 10¹⁸ times)
    3. **Work at moderate T and pH**
    4. **Active site:** Specific region for substrate binding

    **Lock and Key Model:**
    - Substrate fits into enzyme's active site like key in lock
    - Enzyme-substrate complex → Products

    **Michaelis-Menten Mechanism:**

    E + S ⇌ ES → E + P

    Where E = enzyme, S = substrate, ES = enzyme-substrate complex, P = product

    **Examples:**
    - **Invertase:** Sucrose → Glucose + Fructose
    - **Urease:** Urea → NH₃ + CO₂
    - **Zymase:** Glucose → Ethanol + CO₂ (fermentation)
    - **Pepsin:** Protein digestion (acidic pH)
    - **Trypsin:** Protein digestion (basic pH)

    ### 4. Autocatalysis

    **Definition:** Product acts as catalyst

    **Example:** MnO₄⁻ + C₂O₄²⁻ → Mn²⁺ + CO₂

    Mn²⁺ (product) catalyzes the reaction
    Initially slow, then faster (autocatalytic)

    ## Catalyst Promoters and Poisons

    ### Promoters (Activators):

    **Definition:** Substances that enhance catalyst activity

    **Examples:**
    - Mo promotes Fe in Haber process
    - As₂O₃ promotes Pt in H₂SO₄ contact process

    ### Poisons (Inhibitors):

    **Definition:** Substances that reduce catalyst activity

    **Examples:**
    - CO poisons Fe catalyst
    - S poisons Pt catalyst
    - Heavy metals poison enzymes

    ## Shape-Selective Catalysis (Zeolites)

    **Zeolites:** Microporous aluminosilicates

    **Properties:**
    - Honeycomb structure with pores
    - Shape selectivity (only specific size/shape molecules react)

    **Application:** ZSM-5 in petroleum refining

    ## Temperature Coefficient

    **Definition:** Ratio of rate constants at two temperatures differing by 10°C

    **Temperature coefficient = k_(T+10)/k_T**

    **Typically:** 2 to 3 (rate doubles or triples for 10°C rise)

    **Van't Hoff Rule:** Rate approximately doubles for every 10°C rise

    ## Reaction Mechanisms

    **Complex reactions:** Occur in multiple steps (elementary reactions)

    ### Example: Formation of HBr

    **Overall:** H₂ + Br₂ → 2HBr

    **Mechanism:**

    1. Br₂ → 2Br· (slow, rate-determining)
    2. Br· + H₂ → HBr + H· (fast)
    3. H· + Br₂ → HBr + Br· (fast)

    **Rate = k[H₂][Br₂]¹/²**

    ### Rate-Determining Step (RDS):

    **Definition:** Slowest step that determines overall rate

    **Characteristics:**
    - Controls overall reaction rate
    - Has highest activation energy
    - Appears in rate law

    ## Solved Problems: Catalysis

    ### Problem 1: Ea reduction

    **Q: Catalyst reduces Ea from 120 kJ to 80 kJ at 300 K. By what factor does rate increase?**

    Solution:
    ln(k_cat/k_uncat) = (ΔEa)/(RT) = (120-80)×1000/(8.314×300)
    = 40,000/2494.2 = 16.04

    k_cat/k_uncat = e^16.04 = **9.1 × 10⁶**

    Rate increases by ~9 million times!

    ### Problem 2: Temperature coefficient

    **Q: Rate constant at 300 K is 0.01 s⁻¹ and at 310 K is 0.03 s⁻¹. Find temperature coefficient.**

    Solution:
    Temperature coefficient = k₃₁₀/k₃₀₀ = 0.03/0.01 = **3**

    Rate triples for 10°C rise

    ### Problem 3: Catalyst and equilibrium

    **Q: For N₂ + 3H₂ ⇌ 2NH₃, K = 0.5. With catalyst, what is new K?**

    Solution:
    Catalyst does NOT change equilibrium constant
    **K = 0.5** (same)

    Catalyst only speeds up attainment of equilibrium

    ## Characteristics Comparison

    | Property | Homogeneous | Heterogeneous | Enzyme |
    |----------|-------------|---------------|--------|
    | Phase | Same | Different | Aqueous |
    | Efficiency | Moderate | Moderate | Very high |
    | Specificity | Low | Moderate | Very high |
    | Recovery | Difficult | Easy | Moderate |
    | Temperature | High | High | Moderate |
    | Example | H₂SO₄ in ester | Fe in Haber | Urease |

    ## Factors Affecting Catalyst Activity

    1. **Surface area:** Higher for heterogeneous
    2. **Temperature:** Optimum T exists
    3. **Pressure:** Affects gaseous reactions
    4. **Poisons:** Reduce activity
    5. **Promoters:** Enhance activity
    6. **pH:** Especially for enzymes

    ## Industrial Catalysts

    | Process | Reaction | Catalyst |
    |---------|----------|----------|
    | Haber | N₂ + 3H₂ → 2NH₃ | Fe + Mo |
    | Contact | 2SO₂ + O₂ → 2SO₃ | V₂O₅ |
    | Ostwald | 4NH₃ + 5O₂ → 4NO + 6H₂O | Pt |
    | Hydrogenation | Oil + H₂ → Fat | Ni |
    | Catalytic cracking | Long chain → Short chain | Zeolites |
    | Auto exhaust | CO, NO_x → CO₂, N₂ | Pt-Pd-Rh |

    ## IIT JEE Key Points

    1. **Catalyst:** Lowers Ea, doesn't change ΔH or K
    2. **Homogeneous:** Same phase
    3. **Heterogeneous:** Different phase (surface)
    4. **Enzyme:** Highly specific, biological
    5. **Autocatalysis:** Product catalyzes
    6. **Promoter:** Enhances catalyst
    7. **Poison:** Reduces catalyst activity
    8. **Zeolites:** Shape-selective
    9. **Temperature coefficient:** ~2-3 for 10°C
    10. **RDS:** Slowest step determines rate

    ## Quick Reference

    | Concept | Key Point |
    |---------|-----------|
    | Catalyst function | Lowers Ea |
    | Effect on K | None |
    | Homogeneous | Same phase |
    | Heterogeneous | Surface adsorption |
    | Enzyme | Lock and key model |
    | Promoter | Enhances activity |
    | Poison | Reduces activity |

    ## Summary

    **Catalysis** is crucial in:
    - Industrial processes (Haber, Contact, etc.)
    - Biological systems (enzymes)
    - Environmental protection (catalytic converters)
    - Green chemistry (selective, efficient reactions)

    Understanding mechanism helps in:
    - Designing better catalysts
    - Optimizing reaction conditions
    - Preventing catalyst poisoning

## Key Points

- Catalysis

- Homogeneous catalysis

- Heterogeneous catalysis
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Catalysis', 'Homogeneous catalysis', 'Heterogeneous catalysis', 'Enzyme catalysis', 'Reaction mechanisms', 'Temperature coefficient'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Rate of Reaction, Rate Law and Order of Reaction ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Rate of Reaction, Rate Law and Order of Reaction',
  content: <<~MARKDOWN,
# Rate of Reaction, Rate Law and Order of Reaction 🚀

# Rate of Reaction, Rate Law and Order of Reaction

    ## Rate of Reaction

    **Definition:** Change in concentration of reactant or product per unit time

    For: **aA + bB → cC + dD**

    **Rate = -1/a × d[A]/dt = -1/b × d[B]/dt = 1/c × d[C]/dt = 1/d × d[D]/dt**

    ### Units: mol L⁻¹ s⁻¹ or M/s

    **Negative sign:** For reactants (concentration decreases)
    **Positive sign:** For products (concentration increases)

    ### Example:

    For: **2N₂O₅ → 4NO₂ + O₂**

    **Rate = -1/2 × d[N₂O₅]/dt = 1/4 × d[NO₂]/dt = d[O₂]/dt**

    If d[N₂O₅]/dt = -0.004 M/s:
    - Rate = -1/2 × (-0.004) = **0.002 M/s**

    ## Average vs Instantaneous Rate

    ### Average Rate:

    **r_avg = Δ[A]/Δt**

    Over a time interval

    ### Instantaneous Rate:

    **r_inst = d[A]/dt**

    At a specific instant (slope of tangent on concentration-time curve)

    **Note:** Rate generally **decreases with time** (as reactant is consumed)

    ## Factors Affecting Rate of Reaction

    1. **Concentration:** Higher concentration → faster rate
    2. **Temperature:** Higher temperature → faster rate
    3. **Catalyst:** Speeds up reaction
    4. **Surface area:** Larger surface → faster (for solids)
    5. **Nature of reactants:** Some react faster than others
    6. **Presence of light:** Photochemical reactions

    ## Rate Law

    **Definition:** Expression relating rate to concentrations of reactants

    For: **aA + bB → Products**

    **Rate = k[A]ˣ[B]ʸ**

    Where:
    - k = rate constant (specific rate constant)
    - x, y = order with respect to A, B (NOT necessarily a, b)
    - x + y = overall order

    **Important:** Rate law is determined **experimentally**, not from stoichiometry

    ### Example:

    **2NO + O₂ → 2NO₂**

    Experimental rate law: **Rate = k[NO]²[O₂]**

    - Order w.r.t. NO = 2
    - Order w.r.t. O₂ = 1
    - Overall order = 2 + 1 = 3

    ## Order of Reaction

    **Definition:** Sum of powers of concentration terms in rate law

    **Overall order = x + y + z + ...**

    ### Types:

    **Zero order (n = 0):** Rate = k (independent of concentration)
    **First order (n = 1):** Rate = k[A]
    **Second order (n = 2):** Rate = k[A]² or k[A][B]
    **Third order (n = 3):** Rate = k[A]²[B] etc.
    **Fractional order:** Rate = k[A]³/² etc.

    ### Examples:

    **1. H₂ + Cl₂ → 2HCl** (in presence of light)
    Rate = k[H₂][Cl₂]¹/²
    Order = 1 + 1/2 = **3/2** (fractional)

    **2. NH₄NO₂ → N₂ + 2H₂O**
    Rate = k[NH₄NO₂]
    Order = **1** (first order)

    **3. 2N₂O₅ → 4NO₂ + O₂**
    Rate = k[N₂O₅]
    Order = **1** (not 2!)

    ## Rate Constant (k)

    **From rate law:** Rate = k[A]ˣ[B]ʸ

    **k = Rate / ([A]ˣ[B]ʸ)**

    ### Units of k:

    Depend on overall order (n):

    **Zero order:** k has units = mol L⁻¹ s⁻¹ (same as rate)
    **First order:** k has units = s⁻¹ or time⁻¹
    **Second order:** k has units = L mol⁻¹ s⁻¹ or M⁻¹ s⁻¹
    **nth order:** k has units = (mol L⁻¹)¹⁻ⁿ s⁻¹

    ### Properties of k:

    1. **Specific for each reaction** at given temperature
    2. **Independent of concentration**
    3. **Increases with temperature**
    4. **Depends on temperature and catalyst**

    ## Molecularity

    **Definition:** Number of molecules/atoms/ions that participate in an elementary step

    **Elementary reaction:** Single-step reaction

    ### Types:

    **Unimolecular:** One molecule
    - Example: N₂O₅ → NO₂ + NO₃ (molecularity = 1)

    **Bimolecular:** Two molecules
    - Example: 2HI → H₂ + I₂ (molecularity = 2)
    - Example: H₂ + I₂ → 2HI (molecularity = 2)

    **Trimolecular:** Three molecules
    - Example: 2NO + O₂ → 2NO₂ (molecularity = 3)

    **Note:** Molecularity > 3 is very rare (improbable simultaneous collision)

    ## Order vs Molecularity

    | Property | Order | Molecularity |
    |----------|-------|--------------|
    | Definition | Sum of powers in rate law | Molecules in elementary step |
    | Determination | Experimental | Theoretical (from mechanism) |
    | Value | 0, 1, 2, 3, fractional | 1, 2, 3 (always integer) |
    | Applicable to | Any reaction | Only elementary reactions |
    | Example | Can be 1.5 | Cannot be 1.5 |

    **For elementary reactions:** Order = Molecularity
    **For complex reactions:** Order ≠ Molecularity (usually)

    ## Methods to Determine Order

    ### 1. Initial Rate Method:

    Vary concentration of one reactant, keep others constant, measure initial rate

    **Example:**

    | Experiment | [A] | [B] | Initial Rate |
    |------------|-----|-----|--------------|
    | 1 | 0.1 | 0.1 | 0.005 |
    | 2 | 0.2 | 0.1 | 0.020 |
    | 3 | 0.1 | 0.2 | 0.010 |

    **Comparing 1 and 2:** [A] doubles, rate quadruples → order w.r.t. A = 2
    **Comparing 1 and 3:** [B] doubles, rate doubles → order w.r.t. B = 1

    **Rate law:** Rate = k[A]²[B]
    **Overall order:** 2 + 1 = 3

    ### 2. Integrated Rate Law Method:

    Try different integrated rate equations and see which gives straight line

    ### 3. Half-life Method:

    For nth order: t₁/₂ ∝ [A₀]¹⁻ⁿ

    Plot log t₁/₂ vs log [A₀], slope = 1 - n

    ## Pseudo Order Reactions

    **Definition:** Reactions that appear to be of lower order due to excess of one reactant

    **Example:** Hydrolysis of ester

    **CH₃COOC₂H₅ + H₂O → CH₃COOH + C₂H₅OH**

    Actual order: 2 (depends on both)
    With large excess of H₂O: **Pseudo first order**

    **Rate = k[CH₃COOC₂H₅][H₂O] ≈ k'[CH₃COOC₂H₅]**

    where k' = k[H₂O] (constant)

    **Other example:** Inversion of cane sugar in presence of excess water

    ## Solved Problems

    ### Problem 1: Calculate rate

    **Q: For 2N₂O₅ → 4NO₂ + O₂, if d[N₂O₅]/dt = -0.006 M/s, find rate of formation of NO₂.**

    Solution:
    - Rate = -1/2 × d[N₂O₅]/dt = 1/4 × d[NO₂]/dt
    - d[NO₂]/dt = -4/2 × d[N₂O₅]/dt
    - d[NO₂]/dt = -2 × (-0.006)
    - **d[NO₂]/dt = 0.012 M/s**

    ### Problem 2: Determine order

    **Q: For A → Products, doubling [A] doubles rate. Find order.**

    Solution:
    - Rate₁ = k[A]ⁿ
    - Rate₂ = k[2A]ⁿ = k × 2ⁿ[A]ⁿ
    - Given: Rate₂ = 2 × Rate₁
    - 2ⁿ = 2
    - **n = 1** (first order)

    ### Problem 3: Units of k

    **Q: For rate = k[A]²[B], find units of k if rate is in M/s.**

    Solution:
    - Order = 2 + 1 = 3
    - k = Rate/[A]²[B] = (M/s)/(M²·M) = (M/s)/M³
    - **Units: M⁻² s⁻¹** or **L² mol⁻² s⁻¹**

    ### Problem 4: Initial rate method

    **Q: From data below, find order w.r.t. A and B:**

    | [A] | [B] | Rate |
    |-----|-----|------|
    | 0.1 | 0.1 | 0.004 |
    | 0.2 | 0.1 | 0.016 |
    | 0.1 | 0.2 | 0.004 |

    Solution:
    - Exp 1 to 2: [A] × 2, rate × 4 → 2ⁿ = 4 → n = 2
    - Exp 1 to 3: [B] × 2, rate × 1 → 2ᵐ = 1 → m = 0
    - **Order w.r.t. A = 2, w.r.t. B = 0**
    - **Rate = k[A]²**

    ### Problem 5: Calculate k

    **Q: For first order reaction, rate = 0.01 M/s when [A] = 0.5 M. Find k.**

    Solution:
    - Rate = k[A]
    - 0.01 = k × 0.5
    - k = 0.01/0.5
    - **k = 0.02 s⁻¹**

    ## Temperature Dependence

    **Rate increases with temperature** (approximately doubles for every 10°C rise)

    **Reason:**
    1. More molecules have sufficient energy (activation energy)
    2. Frequency of collisions increases

    **Quantitative:** Arrhenius equation (discussed in next lesson)

    ## IIT JEE Key Points

    1. **Rate = -1/a × d[A]/dt** (with stoichiometric coefficient)
    2. **Rate law:** Rate = k[A]ˣ[B]ʸ (experimental)
    3. **Order:** Sum of powers (x + y)
    4. **Molecularity:** Molecules in elementary step
    5. **Order ≠ Molecularity** (except elementary reactions)
    6. **Units of k:** Depend on overall order
    7. **Zero order:** Rate = k
    8. **First order:** Rate = k[A], units of k = s⁻¹
    9. **Second order:** Rate = k[A]² or k[A][B]
    10. **Pseudo order:** Excess reagent makes it lower order

    ## Quick Reference

    | Order | Rate Law | Units of k | Example |
    |-------|----------|------------|---------|
    | 0 | Rate = k | mol L⁻¹ s⁻¹ | Photochemical |
    | 1 | Rate = k[A] | s⁻¹ | Radioactive decay |
    | 2 | Rate = k[A]² | L mol⁻¹ s⁻¹ | 2HI → H₂+I₂ |
    | 3 | Rate = k[A]²[B] | L² mol⁻² s⁻¹ | 2NO+O₂ |

    ## Summary Formulas

    | Concept | Formula |
    |---------|---------|
    | Rate | -1/a(d[A]/dt) = 1/c(d[C]/dt) |
    | Rate law | k[A]ˣ[B]ʸ |
    | Overall order | x + y |
    | k (first order) | s⁻¹ |
    | k (second order) | L mol⁻¹ s⁻¹ |

## Key Points

- Rate of reaction

- Rate law

- Order of reaction
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Rate of reaction', 'Rate law', 'Order of reaction', 'Molecularity', 'Rate constant', 'Factors affecting rate'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Integrated Rate Laws, Half-Life and Arrhenius Equation ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Integrated Rate Laws, Half-Life and Arrhenius Equation',
  content: <<~MARKDOWN,
# Integrated Rate Laws, Half-Life and Arrhenius Equation 🚀

# Integrated Rate Laws, Half-Life and Arrhenius Equation

    ## Integrated Rate Laws

    **Purpose:** Relate concentration to time

    ### Zero Order Reaction:

    **A → Products**

    **Rate = k** (independent of [A])

    **Differential form:** -d[A]/dt = k

    **Integrated form:** **[A] = [A]₀ - kt**

    Or: **[A]₀ - [A] = kt**

    **Graph:** [A] vs t → **straight line**, slope = -k

    **Units of k:** mol L⁻¹ s⁻¹

    **Example:** Photochemical reactions, surface catalyzed reactions

    ### First Order Reaction:

    **A → Products**

    **Rate = k[A]**

    **Differential form:** -d[A]/dt = k[A]

    **Integrated form:**

    **ln[A] = ln[A]₀ - kt**

    Or: **ln([A]₀/[A]) = kt**

    Or: **log([A]₀/[A]) = kt/2.303**

    Or: **[A] = [A]₀e^(-kt)**

    **Graph:** ln[A] vs t → **straight line**, slope = -k

    **Units of k:** s⁻¹ or time⁻¹

    **Examples:** Radioactive decay, N₂O₅ decomposition

    ### Second Order Reaction:

    **Type 1: A + A → Products** (Rate = k[A]²)

    **Integrated form:**

    **1/[A] = 1/[A]₀ + kt**

    Or: **1/[A] - 1/[A]₀ = kt**

    **Graph:** 1/[A] vs t → **straight line**, slope = k

    **Type 2: A + B → Products** (Rate = k[A][B], if [A]₀ = [B]₀)

    Same as Type 1

    **Units of k:** L mol⁻¹ s⁻¹ or M⁻¹ s⁻¹

    **Example:** 2HI → H₂ + I₂

    ## Summary: Integrated Rate Laws

    | Order | Integrated Form | Linear Plot | Slope | Units of k |
    |-------|-----------------|-------------|-------|------------|
    | 0 | [A] = [A]₀ - kt | [A] vs t | -k | mol L⁻¹ s⁻¹ |
    | 1 | ln[A] = ln[A]₀ - kt | ln[A] vs t | -k | s⁻¹ |
    | 2 | 1/[A] = 1/[A]₀ + kt | 1/[A] vs t | +k | L mol⁻¹ s⁻¹ |

    ## Half-Life (t₁/₂)

    **Definition:** Time required for concentration to reduce to half of initial value

    **At t = t₁/₂:** [A] = [A]₀/2

    ### Zero Order:

    **[A]₀/2 = [A]₀ - kt₁/₂**

    **t₁/₂ = [A]₀/(2k)**

    **t₁/₂ ∝ [A]₀** (depends on initial concentration)

    ### First Order:

    **ln([A]₀/([A]₀/2)) = kt₁/₂**
    **ln 2 = kt₁/₂**

    **t₁/₂ = 0.693/k = ln 2/k**

    **t₁/₂ is constant** (independent of initial concentration)

    This is characteristic of first order!

    ### Second Order:

    **1/([A]₀/2) = 1/[A]₀ + kt₁/₂**

    **t₁/₂ = 1/(k[A]₀)**

    **t₁/₂ ∝ 1/[A]₀** (inversely proportional)

    ## Comparison of Half-Lives

    | Order | t₁/₂ Formula | Depends on [A]₀? |
    |-------|--------------|------------------|
    | 0 | [A]₀/(2k) | Yes (∝ [A]₀) |
    | 1 | 0.693/k | No (constant) |
    | 2 | 1/(k[A]₀) | Yes (∝ 1/[A]₀) |

    ## First Order Reaction Calculations

    ### Important Relations:

    **1. Number of half-lives:**

    After n half-lives: **[A] = [A]₀/(2ⁿ)**

    **2. Time for x% completion:**

    If x% reacted, (100-x)% remains

    **t = (2.303/k) log(100/(100-x))**

    **3. Time to reduce to 1/n of initial:**

    **t = (2.303/k) log n**

    ## Solved Problems: Integrated Rate Laws

    ### Problem 1: Zero order

    **Q: For zero order reaction, [A]₀ = 0.8 M, k = 0.02 M/s. Find [A] after 10 s.**

    Solution:
    [A] = [A]₀ - kt = 0.8 - 0.02 × 10
    **[A] = 0.6 M**

    ### Problem 2: First order - find k

    **Q: For first order reaction, 75% completed in 60 min. Find k.**

    Solution:
    - 75% completed → 25% remains
    - [A]/[A]₀ = 0.25

    k = (2.303/t) log([A]₀/[A])
    k = (2.303/60) log(1/0.25)
    k = (2.303/60) log 4
    k = (2.303/60) × 0.602
    **k = 0.0231 min⁻¹**

    ### Problem 3: First order - half-life

    **Q: For first order reaction, k = 0.0693 min⁻¹. Find t₁/₂.**

    Solution:
    t₁/₂ = 0.693/k = 0.693/0.0693
    **t₁/₂ = 10 min**

    ### Problem 4: First order - after n half-lives

    **Q: After 3 half-lives, what % of reactant remains?**

    Solution:
    [A] = [A]₀/(2³) = [A]₀/8
    **% remaining = 12.5%**
    **% reacted = 87.5%**

    ### Problem 5: Second order

    **Q: For 2A → Products (second order), [A]₀ = 0.1 M, k = 0.5 M⁻¹s⁻¹. Find [A] after 10 s.**

    Solution:
    1/[A] = 1/[A]₀ + kt
    1/[A] = 1/0.1 + 0.5 × 10
    1/[A] = 10 + 5 = 15
    **[A] = 1/15 = 0.067 M**

    ### Problem 6: Determine order from half-life

    **Q: Half-life of reaction doubles when initial concentration is halved. Find order.**

    Solution:
    - For zero order: t₁/₂ ∝ [A]₀ → halving [A]₀ halves t₁/₂ ✗
    - For first order: t₁/₂ constant → no change ✗
    - For second order: t₁/₂ ∝ 1/[A]₀ → halving [A]₀ doubles t₁/₂ ✓

    **Order = 2** (second order)

    ## Arrhenius Equation

    **Statement:** Rate constant increases exponentially with temperature

    **k = Ae^(-Ea/RT)**

    Where:
    - k = rate constant
    - A = pre-exponential factor (frequency factor)
    - Ea = activation energy (J/mol)
    - R = 8.314 J/(mol·K)
    - T = temperature (K)

    ### Logarithmic Form:

    **ln k = ln A - Ea/(RT)**

    Or: **log k = log A - Ea/(2.303RT)**

    **Graph:** log k vs 1/T → straight line
    - Slope = -Ea/(2.303R)
    - Intercept = log A

    ## Activation Energy (Ea)

    **Definition:** Minimum energy required for reaction to occur

    **Higher Ea** → Slower reaction
    **Lower Ea** → Faster reaction

    ### Effect of Temperature:

    At two different temperatures:

    **ln(k₂/k₁) = (Ea/R)(1/T₁ - 1/T₂)**

    Or: **log(k₂/k₁) = (Ea/2.303R)(T₂-T₁)/(T₁T₂)**

    Or: **log(k₂/k₁) = (Ea/2.303R)(ΔT)/(T₁T₂)**

    ### Determination of Ea:

    **Method 1:** Plot log k vs 1/T, slope = -Ea/(2.303R)

    **Method 2:** Use k at two temperatures:
    Ea = (2.303R log(k₂/k₁))/(1/T₁ - 1/T₂)

    ## Solved Problems: Arrhenius Equation

    ### Problem 1: Calculate Ea

    **Q: Rate constant doubles when temperature increases from 300 K to 310 K. Calculate Ea. (R = 8.314 J/mol·K)**

    Solution:
    k₂/k₁ = 2, T₁ = 300 K, T₂ = 310 K

    log(k₂/k₁) = (Ea/2.303R)(T₂-T₁)/(T₁T₂)
    log 2 = (Ea/(2.303 × 8.314)) × (10)/(300 × 310)
    0.301 = (Ea/19.15) × (10/93,000)
    0.301 = Ea/(19.15 × 9,300)
    Ea = 0.301 × 178,095
    **Ea ≈ 53,607 J/mol = 53.6 kJ/mol**

    ### Problem 2: Calculate k at different T

    **Q: k = 0.01 s⁻¹ at 300 K, Ea = 50 kJ/mol. Find k at 320 K.**

    Solution:
    log(k₂/k₁) = (Ea/2.303R)(T₂-T₁)/(T₁T₂)
    log(k₂/0.01) = (50,000/(2.303 × 8.314)) × (20)/(300 × 320)
    log(k₂/0.01) = 2612.4 × (20/96,000)
    log(k₂/0.01) = 0.544
    k₂/0.01 = 10^0.544 = 3.5
    **k₂ = 0.035 s⁻¹**

    ### Problem 3: Effect of catalyst

    **Q: Catalyst reduces Ea from 100 kJ to 80 kJ at 300 K. Find ratio k_catalyzed/k_uncatalyzed.**

    Solution:
    ln(k₂/k₁) = (ΔEa)/(RT) = (Ea1 - Ea2)/(RT)
    = (100,000 - 80,000)/(8.314 × 300)
    = 20,000/2,494.2 = 8.02

    k₂/k₁ = e^8.02 = **3,032**

    Catalyst increases rate by ~3000 times!

    ## Collision Theory

    **Statement:** For reaction to occur:
    1. Molecules must collide
    2. With sufficient energy (≥ Ea)
    3. With proper orientation

    **Rate ∝ (Collision frequency) × (Fraction with E ≥ Ea) × (Orientation factor)**

    **Fraction with E ≥ Ea = e^(-Ea/RT)** (Boltzmann distribution)

    This explains Arrhenius equation!

    ## IIT JEE Key Points

    1. **Zero order:** [A] = [A]₀ - kt, t₁/₂ = [A]₀/(2k)
    2. **First order:** ln[A] = ln[A]₀ - kt, t₁/₂ = 0.693/k
    3. **Second order:** 1/[A] = 1/[A]₀ + kt, t₁/₂ = 1/(k[A]₀)
    4. **First order t₁/₂:** Independent of [A]₀
    5. **After n half-lives:** [A] = [A]₀/(2ⁿ)
    6. **Arrhenius:** k = Ae^(-Ea/RT)
    7. **log(k₂/k₁) = (Ea/2.303R)(ΔT)/(T₁T₂)**
    8. **Higher Ea:** Slower reaction
    9. **Catalyst:** Lowers Ea
    10. **Collision theory:** E ≥ Ea + proper orientation

    ## Quick Formulas

    | Concept | Formula |
    |---------|---------|
    | Zero order | [A] = [A]₀ - kt |
    | First order | ln([A]₀/[A]) = kt |
    | Second order | 1/[A] - 1/[A]₀ = kt |
    | t₁/₂ (0th order) | [A]₀/(2k) |
    | t₁/₂ (1st order) | 0.693/k |
    | t₁/₂ (2nd order) | 1/(k[A]₀) |
    | Arrhenius | ln k = ln A - Ea/RT |
    | Ea from two T | (2.303R log(k₂/k₁))/(1/T₁-1/T₂) |

    ## Important Constants

    - **R** = 8.314 J/(mol·K)
    - **ln 2** = 0.693
    - **log 2** = 0.301
    - **2.303** = conversion factor (ln to log)

## Key Points

- Integrated rate laws

- Zero order kinetics

- First order kinetics
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Integrated rate laws', 'Zero order kinetics', 'First order kinetics', 'Second order kinetics', 'Half-life', 'Arrhenius equation', 'Activation energy'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Catalysis, Reaction Mechanisms and Temperature Effects ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Catalysis, Reaction Mechanisms and Temperature Effects',
  content: <<~MARKDOWN,
# Catalysis, Reaction Mechanisms and Temperature Effects 🚀

# Catalysis, Reaction Mechanisms and Temperature Effects

    ## Catalysis

    **Catalyst:** Substance that increases rate of reaction without being consumed

    **Functions:**
    1. Provides alternate pathway with **lower activation energy**
    2. Increases rate of both forward and backward reactions equally
    3. **Does not change equilibrium position or K**
    4. Needed in small amounts
    5. Specific for particular reactions

    ### Energy Profile:

    **Without catalyst:** Higher Ea
    **With catalyst:** Lower Ea (faster reaction)

    ΔH (enthalpy change) remains same!

    ## Types of Catalysis

    ### 1. Homogeneous Catalysis

    **Definition:** Catalyst and reactants in **same phase**

    **Examples:**

    **a) NO in lead chamber process:**
    2SO₂(g) + O₂(g) → 2SO₃(g) [catalyzed by NO(g)]

    **b) Acid catalysis:**
    Ester hydrolysis: CH₃COOC₂H₅ + H₂O → CH₃COOH + C₂H₅OH [H⁺ catalyst]

    **c) Base catalysis:**
    Aldol condensation catalyzed by OH⁻

    ### 2. Heterogeneous Catalysis

    **Definition:** Catalyst and reactants in **different phases**

    **Usually:** Solid catalyst, gaseous/liquid reactants

    **Mechanism - Adsorption Theory:**

    1. **Adsorption:** Reactants adsorbed on catalyst surface
    2. **Activation:** Bonds weakened, activated complex formed
    3. **Reaction:** Products formed on surface
    4. **Desorption:** Products leave surface, catalyst regenerated

    **Examples:**

    **a) Haber process (NH₃ synthesis):**
    N₂(g) + 3H₂(g) → 2NH₃(g) [Fe catalyst]

    **b) Hydrogenation of oils:**
    Vegetable oil + H₂ → Saturated fat [Ni catalyst]

    **c) Ostwald process (HNO₃ production):**
    4NH₃ + 5O₂ → 4NO + 6H₂O [Pt catalyst]

    **d) Contact process (H₂SO₄):**
    2SO₂ + O₂ → 2SO₃ [V₂O₅ catalyst]

    **e) Catalytic converter (automobiles):**
    2CO + 2NO → 2CO₂ + N₂ [Pt-Pd-Rh catalyst]

    ### Important Points - Heterogeneous Catalysis:

    1. **Surface phenomenon** (depends on surface area)
    2. **Adsorption is key step**
    3. Catalyst should have:
       - Moderate bond strength with reactants
       - High surface area (finely divided or porous)
    4. **Catalyst poisoning:** Impurities block active sites
       - Example: S, Pb poison Pt catalyst

    ### 3. Enzyme Catalysis (Biochemical)

    **Enzymes:** Biological catalysts (proteins)

    **Characteristics:**
    1. **Highly specific** (one enzyme → one reaction)
    2. **Very efficient** (increase rate by 10⁶ to 10¹⁸ times)
    3. **Work at moderate T and pH**
    4. **Active site:** Specific region for substrate binding

    **Lock and Key Model:**
    - Substrate fits into enzyme's active site like key in lock
    - Enzyme-substrate complex → Products

    **Michaelis-Menten Mechanism:**

    E + S ⇌ ES → E + P

    Where E = enzyme, S = substrate, ES = enzyme-substrate complex, P = product

    **Examples:**
    - **Invertase:** Sucrose → Glucose + Fructose
    - **Urease:** Urea → NH₃ + CO₂
    - **Zymase:** Glucose → Ethanol + CO₂ (fermentation)
    - **Pepsin:** Protein digestion (acidic pH)
    - **Trypsin:** Protein digestion (basic pH)

    ### 4. Autocatalysis

    **Definition:** Product acts as catalyst

    **Example:** MnO₄⁻ + C₂O₄²⁻ → Mn²⁺ + CO₂

    Mn²⁺ (product) catalyzes the reaction
    Initially slow, then faster (autocatalytic)

    ## Catalyst Promoters and Poisons

    ### Promoters (Activators):

    **Definition:** Substances that enhance catalyst activity

    **Examples:**
    - Mo promotes Fe in Haber process
    - As₂O₃ promotes Pt in H₂SO₄ contact process

    ### Poisons (Inhibitors):

    **Definition:** Substances that reduce catalyst activity

    **Examples:**
    - CO poisons Fe catalyst
    - S poisons Pt catalyst
    - Heavy metals poison enzymes

    ## Shape-Selective Catalysis (Zeolites)

    **Zeolites:** Microporous aluminosilicates

    **Properties:**
    - Honeycomb structure with pores
    - Shape selectivity (only specific size/shape molecules react)

    **Application:** ZSM-5 in petroleum refining

    ## Temperature Coefficient

    **Definition:** Ratio of rate constants at two temperatures differing by 10°C

    **Temperature coefficient = k_(T+10)/k_T**

    **Typically:** 2 to 3 (rate doubles or triples for 10°C rise)

    **Van't Hoff Rule:** Rate approximately doubles for every 10°C rise

    ## Reaction Mechanisms

    **Complex reactions:** Occur in multiple steps (elementary reactions)

    ### Example: Formation of HBr

    **Overall:** H₂ + Br₂ → 2HBr

    **Mechanism:**

    1. Br₂ → 2Br· (slow, rate-determining)
    2. Br· + H₂ → HBr + H· (fast)
    3. H· + Br₂ → HBr + Br· (fast)

    **Rate = k[H₂][Br₂]¹/²**

    ### Rate-Determining Step (RDS):

    **Definition:** Slowest step that determines overall rate

    **Characteristics:**
    - Controls overall reaction rate
    - Has highest activation energy
    - Appears in rate law

    ## Solved Problems: Catalysis

    ### Problem 1: Ea reduction

    **Q: Catalyst reduces Ea from 120 kJ to 80 kJ at 300 K. By what factor does rate increase?**

    Solution:
    ln(k_cat/k_uncat) = (ΔEa)/(RT) = (120-80)×1000/(8.314×300)
    = 40,000/2494.2 = 16.04

    k_cat/k_uncat = e^16.04 = **9.1 × 10⁶**

    Rate increases by ~9 million times!

    ### Problem 2: Temperature coefficient

    **Q: Rate constant at 300 K is 0.01 s⁻¹ and at 310 K is 0.03 s⁻¹. Find temperature coefficient.**

    Solution:
    Temperature coefficient = k₃₁₀/k₃₀₀ = 0.03/0.01 = **3**

    Rate triples for 10°C rise

    ### Problem 3: Catalyst and equilibrium

    **Q: For N₂ + 3H₂ ⇌ 2NH₃, K = 0.5. With catalyst, what is new K?**

    Solution:
    Catalyst does NOT change equilibrium constant
    **K = 0.5** (same)

    Catalyst only speeds up attainment of equilibrium

    ## Characteristics Comparison

    | Property | Homogeneous | Heterogeneous | Enzyme |
    |----------|-------------|---------------|--------|
    | Phase | Same | Different | Aqueous |
    | Efficiency | Moderate | Moderate | Very high |
    | Specificity | Low | Moderate | Very high |
    | Recovery | Difficult | Easy | Moderate |
    | Temperature | High | High | Moderate |
    | Example | H₂SO₄ in ester | Fe in Haber | Urease |

    ## Factors Affecting Catalyst Activity

    1. **Surface area:** Higher for heterogeneous
    2. **Temperature:** Optimum T exists
    3. **Pressure:** Affects gaseous reactions
    4. **Poisons:** Reduce activity
    5. **Promoters:** Enhance activity
    6. **pH:** Especially for enzymes

    ## Industrial Catalysts

    | Process | Reaction | Catalyst |
    |---------|----------|----------|
    | Haber | N₂ + 3H₂ → 2NH₃ | Fe + Mo |
    | Contact | 2SO₂ + O₂ → 2SO₃ | V₂O₅ |
    | Ostwald | 4NH₃ + 5O₂ → 4NO + 6H₂O | Pt |
    | Hydrogenation | Oil + H₂ → Fat | Ni |
    | Catalytic cracking | Long chain → Short chain | Zeolites |
    | Auto exhaust | CO, NO_x → CO₂, N₂ | Pt-Pd-Rh |

    ## IIT JEE Key Points

    1. **Catalyst:** Lowers Ea, doesn't change ΔH or K
    2. **Homogeneous:** Same phase
    3. **Heterogeneous:** Different phase (surface)
    4. **Enzyme:** Highly specific, biological
    5. **Autocatalysis:** Product catalyzes
    6. **Promoter:** Enhances catalyst
    7. **Poison:** Reduces catalyst activity
    8. **Zeolites:** Shape-selective
    9. **Temperature coefficient:** ~2-3 for 10°C
    10. **RDS:** Slowest step determines rate

    ## Quick Reference

    | Concept | Key Point |
    |---------|-----------|
    | Catalyst function | Lowers Ea |
    | Effect on K | None |
    | Homogeneous | Same phase |
    | Heterogeneous | Surface adsorption |
    | Enzyme | Lock and key model |
    | Promoter | Enhances activity |
    | Poison | Reduces activity |

    ## Summary

    **Catalysis** is crucial in:
    - Industrial processes (Haber, Contact, etc.)
    - Biological systems (enzymes)
    - Environmental protection (catalytic converters)
    - Green chemistry (selective, efficient reactions)

    Understanding mechanism helps in:
    - Designing better catalysts
    - Optimizing reaction conditions
    - Preventing catalyst poisoning

## Key Points

- Catalysis

- Homogeneous catalysis

- Heterogeneous catalysis
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Catalysis', 'Homogeneous catalysis', 'Heterogeneous catalysis', 'Enzyme catalysis', 'Reaction mechanisms', 'Temperature coefficient'],
  prerequisite_ids: []
)

# === MICROLESSON 7: rate_of_reaction — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'rate_of_reaction — Practice',
  content: <<~MARKDOWN,
# rate_of_reaction — Practice 🚀

Rate = -1/2 × d[N₂O₅]/dt = -1/2 × (-0.008) = 0.004 M/s

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['rate_of_reaction'],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For 2N₂O₅ → 4NO₂ + O₂, if d[N₂O₅]/dt = -0.008 M/s, find rate of reaction in M/s.',
    answer: '0.004',
    explanation: 'Rate = -1/2 × d[N₂O₅]/dt = -1/2 × (-0.008) = 0.004 M/s',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: rate_constant — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'rate_constant — Practice',
  content: <<~MARKDOWN,
# rate_constant — Practice 🚀

For first order: Rate = k[A], so k = Rate/[A] = (mol L⁻¹ s⁻¹)/(mol L⁻¹) = s⁻¹

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['rate_constant'],
  prerequisite_ids: []
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For a first order reaction, units of rate constant k are:',
    options: ['s⁻¹', 'mol L⁻¹ s⁻¹', 'L mol⁻¹ s⁻¹', 'L² mol⁻² s⁻¹'],
    correct_answer: 0,
    explanation: 'For first order: Rate = k[A], so k = Rate/[A] = (mol L⁻¹ s⁻¹)/(mol L⁻¹) = s⁻¹',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: order_of_reaction — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'order_of_reaction — Practice',
  content: <<~MARKDOWN,
# order_of_reaction — Practice 🚀

Rate = k[A]ⁿ. When [A] → 2[A], rate → 4×rate. So 2ⁿ = 4, n = 2 (second order)

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['order_of_reaction'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Doubling concentration of A increases rate by 4 times. What is the order with respect to A?',
    answer: '2',
    explanation: 'Rate = k[A]ⁿ. When [A] → 2[A], rate → 4×rate. So 2ⁿ = 4, n = 2 (second order)',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: half_life — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'half_life — Practice',
  content: <<~MARKDOWN,
# half_life — Practice 🚀

t₁/₂ = 0.693/k = 0.693/0.0693 = 10 minutes

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['half_life'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For first order reaction with k = 0.0693 min⁻¹, calculate half-life in minutes.',
    answer: '10',
    explanation: 't₁/₂ = 0.693/k = 0.693/0.0693 = 10 minutes',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: first_order_kinetics — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'first_order_kinetics — Practice',
  content: <<~MARKDOWN,
# first_order_kinetics — Practice 🚀

TRUE. For first order: t₁/₂ = 0.693/k (constant, independent of [A]₀). This is a unique characteristic of first order reactions.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['first_order_kinetics'],
  prerequisite_ids: []
)

# Exercise 11.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Half-life of a first order reaction is independent of initial concentration.',
    answer: 'true',
    explanation: 'TRUE. For first order: t₁/₂ = 0.693/k (constant, independent of [A]₀). This is a unique characteristic of first order reactions.',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 12: integrated_rate_laws — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'integrated_rate_laws — Practice',
  content: <<~MARKDOWN,
# integrated_rate_laws — Practice 🚀

For second order: 1/[A] = 1/[A]₀ + kt. Plot of 1/[A] vs t gives straight line with slope = k.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['integrated_rate_laws'],
  prerequisite_ids: []
)

# === MICROLESSON 13: first_order_kinetics — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'first_order_kinetics — Practice',
  content: <<~MARKDOWN,
# first_order_kinetics — Practice 🚀

[A] = [A]₀/(2ⁿ) = [A]₀/8 = 0.125[A]₀. Percentage = 12.5%

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['first_order_kinetics'],
  prerequisite_ids: []
)

# Exercise 13.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For first order reaction, what percentage remains after 3 half-lives?',
    answer: '12.5',
    explanation: '[A] = [A]₀/(2ⁿ) = [A]₀/8 = 0.125[A]₀. Percentage = 12.5%',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 14: arrhenius_equation — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'arrhenius_equation — Practice',
  content: <<~MARKDOWN,
# arrhenius_equation — Practice 🚀

k = Ae^(-Ea/RT). k increases with temperature (exponentially). While lower Ea gives higher k for same T, the question asks what k increases WITH. The answer focuses on temperature increase.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['arrhenius_equation'],
  prerequisite_ids: []
)

# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'According to Arrhenius equation, rate constant k increases with:',
    options: ['Increase in temperature', 'Decrease in activation energy', 'Increase in concentration', 'Both A and B'],
    correct_answer: 0,
    explanation: 'k = Ae^(-Ea/RT). k increases with temperature (exponentially). While lower Ea gives higher k for same T, the question asks what k increases WITH. The answer focuses on temperature increase.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 15: catalysis — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'catalysis — Practice',
  content: <<~MARKDOWN,
# catalysis — Practice 🚀

Catalyst: (1) Lowers Ea, (2) Increases rate. Does NOT change: (1) K (equilibrium constant), (2) ΔH (enthalpy change).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['catalysis'],
  prerequisite_ids: []
)

# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'A catalyst affects which of the following?',
    options: ['Activation energy', 'Rate of reaction', 'Equilibrium constant K', 'Enthalpy change ΔH'],
    correct_answer: 1,
    explanation: 'Catalyst: (1) Lowers Ea, (2) Increases rate. Does NOT change: (1) K (equilibrium constant), (2) ΔH (enthalpy change).',
    difficulty: 'medium'
  }
)

# === MICROLESSON 16: catalysis — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'catalysis — Practice',
  content: <<~MARKDOWN,
# catalysis — Practice 🚀

Enzyme catalysis is homogeneous (both enzyme and substrate in aqueous solution, same phase).

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

# Exercise 16.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Enzyme catalysis is an example of _____ catalysis. (Answer: homogeneous or heterogeneous)',
    answer: 'homogeneous',
    explanation: 'Enzyme catalysis is homogeneous (both enzyme and substrate in aqueous solution, same phase).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 17: order_molecularity — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'order_molecularity — Practice',
  content: <<~MARKDOWN,
# order_molecularity — Practice 🚀

TRUE. Order is determined experimentally and can be 0, 1, 2, 1.5, etc. Molecularity is number of molecules in elementary step and must be integer (1, 2, or 3).

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['order_molecularity'],
  prerequisite_ids: []
)

# Exercise 17.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Order of reaction can be fractional but molecularity is always a whole number.',
    answer: 'true',
    explanation: 'TRUE. Order is determined experimentally and can be 0, 1, 2, 1.5, etc. Molecularity is number of molecules in elementary step and must be integer (1, 2, or 3).',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 18: Rate of Reaction, Rate Law and Order of Reaction ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Rate of Reaction, Rate Law and Order of Reaction',
  content: <<~MARKDOWN,
# Rate of Reaction, Rate Law and Order of Reaction 🚀

# Rate of Reaction, Rate Law and Order of Reaction

    ## Rate of Reaction

    **Definition:** Change in concentration of reactant or product per unit time

    For: **aA + bB → cC + dD**

    **Rate = -1/a × d[A]/dt = -1/b × d[B]/dt = 1/c × d[C]/dt = 1/d × d[D]/dt**

    ### Units: mol L⁻¹ s⁻¹ or M/s

    **Negative sign:** For reactants (concentration decreases)
    **Positive sign:** For products (concentration increases)

    ### Example:

    For: **2N₂O₅ → 4NO₂ + O₂**

    **Rate = -1/2 × d[N₂O₅]/dt = 1/4 × d[NO₂]/dt = d[O₂]/dt**

    If d[N₂O₅]/dt = -0.004 M/s:
    - Rate = -1/2 × (-0.004) = **0.002 M/s**

    ## Average vs Instantaneous Rate

    ### Average Rate:

    **r_avg = Δ[A]/Δt**

    Over a time interval

    ### Instantaneous Rate:

    **r_inst = d[A]/dt**

    At a specific instant (slope of tangent on concentration-time curve)

    **Note:** Rate generally **decreases with time** (as reactant is consumed)

    ## Factors Affecting Rate of Reaction

    1. **Concentration:** Higher concentration → faster rate
    2. **Temperature:** Higher temperature → faster rate
    3. **Catalyst:** Speeds up reaction
    4. **Surface area:** Larger surface → faster (for solids)
    5. **Nature of reactants:** Some react faster than others
    6. **Presence of light:** Photochemical reactions

    ## Rate Law

    **Definition:** Expression relating rate to concentrations of reactants

    For: **aA + bB → Products**

    **Rate = k[A]ˣ[B]ʸ**

    Where:
    - k = rate constant (specific rate constant)
    - x, y = order with respect to A, B (NOT necessarily a, b)
    - x + y = overall order

    **Important:** Rate law is determined **experimentally**, not from stoichiometry

    ### Example:

    **2NO + O₂ → 2NO₂**

    Experimental rate law: **Rate = k[NO]²[O₂]**

    - Order w.r.t. NO = 2
    - Order w.r.t. O₂ = 1
    - Overall order = 2 + 1 = 3

    ## Order of Reaction

    **Definition:** Sum of powers of concentration terms in rate law

    **Overall order = x + y + z + ...**

    ### Types:

    **Zero order (n = 0):** Rate = k (independent of concentration)
    **First order (n = 1):** Rate = k[A]
    **Second order (n = 2):** Rate = k[A]² or k[A][B]
    **Third order (n = 3):** Rate = k[A]²[B] etc.
    **Fractional order:** Rate = k[A]³/² etc.

    ### Examples:

    **1. H₂ + Cl₂ → 2HCl** (in presence of light)
    Rate = k[H₂][Cl₂]¹/²
    Order = 1 + 1/2 = **3/2** (fractional)

    **2. NH₄NO₂ → N₂ + 2H₂O**
    Rate = k[NH₄NO₂]
    Order = **1** (first order)

    **3. 2N₂O₅ → 4NO₂ + O₂**
    Rate = k[N₂O₅]
    Order = **1** (not 2!)

    ## Rate Constant (k)

    **From rate law:** Rate = k[A]ˣ[B]ʸ

    **k = Rate / ([A]ˣ[B]ʸ)**

    ### Units of k:

    Depend on overall order (n):

    **Zero order:** k has units = mol L⁻¹ s⁻¹ (same as rate)
    **First order:** k has units = s⁻¹ or time⁻¹
    **Second order:** k has units = L mol⁻¹ s⁻¹ or M⁻¹ s⁻¹
    **nth order:** k has units = (mol L⁻¹)¹⁻ⁿ s⁻¹

    ### Properties of k:

    1. **Specific for each reaction** at given temperature
    2. **Independent of concentration**
    3. **Increases with temperature**
    4. **Depends on temperature and catalyst**

    ## Molecularity

    **Definition:** Number of molecules/atoms/ions that participate in an elementary step

    **Elementary reaction:** Single-step reaction

    ### Types:

    **Unimolecular:** One molecule
    - Example: N₂O₅ → NO₂ + NO₃ (molecularity = 1)

    **Bimolecular:** Two molecules
    - Example: 2HI → H₂ + I₂ (molecularity = 2)
    - Example: H₂ + I₂ → 2HI (molecularity = 2)

    **Trimolecular:** Three molecules
    - Example: 2NO + O₂ → 2NO₂ (molecularity = 3)

    **Note:** Molecularity > 3 is very rare (improbable simultaneous collision)

    ## Order vs Molecularity

    | Property | Order | Molecularity |
    |----------|-------|--------------|
    | Definition | Sum of powers in rate law | Molecules in elementary step |
    | Determination | Experimental | Theoretical (from mechanism) |
    | Value | 0, 1, 2, 3, fractional | 1, 2, 3 (always integer) |
    | Applicable to | Any reaction | Only elementary reactions |
    | Example | Can be 1.5 | Cannot be 1.5 |

    **For elementary reactions:** Order = Molecularity
    **For complex reactions:** Order ≠ Molecularity (usually)

    ## Methods to Determine Order

    ### 1. Initial Rate Method:

    Vary concentration of one reactant, keep others constant, measure initial rate

    **Example:**

    | Experiment | [A] | [B] | Initial Rate |
    |------------|-----|-----|--------------|
    | 1 | 0.1 | 0.1 | 0.005 |
    | 2 | 0.2 | 0.1 | 0.020 |
    | 3 | 0.1 | 0.2 | 0.010 |

    **Comparing 1 and 2:** [A] doubles, rate quadruples → order w.r.t. A = 2
    **Comparing 1 and 3:** [B] doubles, rate doubles → order w.r.t. B = 1

    **Rate law:** Rate = k[A]²[B]
    **Overall order:** 2 + 1 = 3

    ### 2. Integrated Rate Law Method:

    Try different integrated rate equations and see which gives straight line

    ### 3. Half-life Method:

    For nth order: t₁/₂ ∝ [A₀]¹⁻ⁿ

    Plot log t₁/₂ vs log [A₀], slope = 1 - n

    ## Pseudo Order Reactions

    **Definition:** Reactions that appear to be of lower order due to excess of one reactant

    **Example:** Hydrolysis of ester

    **CH₃COOC₂H₅ + H₂O → CH₃COOH + C₂H₅OH**

    Actual order: 2 (depends on both)
    With large excess of H₂O: **Pseudo first order**

    **Rate = k[CH₃COOC₂H₅][H₂O] ≈ k'[CH₃COOC₂H₅]**

    where k' = k[H₂O] (constant)

    **Other example:** Inversion of cane sugar in presence of excess water

    ## Solved Problems

    ### Problem 1: Calculate rate

    **Q: For 2N₂O₅ → 4NO₂ + O₂, if d[N₂O₅]/dt = -0.006 M/s, find rate of formation of NO₂.**

    Solution:
    - Rate = -1/2 × d[N₂O₅]/dt = 1/4 × d[NO₂]/dt
    - d[NO₂]/dt = -4/2 × d[N₂O₅]/dt
    - d[NO₂]/dt = -2 × (-0.006)
    - **d[NO₂]/dt = 0.012 M/s**

    ### Problem 2: Determine order

    **Q: For A → Products, doubling [A] doubles rate. Find order.**

    Solution:
    - Rate₁ = k[A]ⁿ
    - Rate₂ = k[2A]ⁿ = k × 2ⁿ[A]ⁿ
    - Given: Rate₂ = 2 × Rate₁
    - 2ⁿ = 2
    - **n = 1** (first order)

    ### Problem 3: Units of k

    **Q: For rate = k[A]²[B], find units of k if rate is in M/s.**

    Solution:
    - Order = 2 + 1 = 3
    - k = Rate/[A]²[B] = (M/s)/(M²·M) = (M/s)/M³
    - **Units: M⁻² s⁻¹** or **L² mol⁻² s⁻¹**

    ### Problem 4: Initial rate method

    **Q: From data below, find order w.r.t. A and B:**

    | [A] | [B] | Rate |
    |-----|-----|------|
    | 0.1 | 0.1 | 0.004 |
    | 0.2 | 0.1 | 0.016 |
    | 0.1 | 0.2 | 0.004 |

    Solution:
    - Exp 1 to 2: [A] × 2, rate × 4 → 2ⁿ = 4 → n = 2
    - Exp 1 to 3: [B] × 2, rate × 1 → 2ᵐ = 1 → m = 0
    - **Order w.r.t. A = 2, w.r.t. B = 0**
    - **Rate = k[A]²**

    ### Problem 5: Calculate k

    **Q: For first order reaction, rate = 0.01 M/s when [A] = 0.5 M. Find k.**

    Solution:
    - Rate = k[A]
    - 0.01 = k × 0.5
    - k = 0.01/0.5
    - **k = 0.02 s⁻¹**

    ## Temperature Dependence

    **Rate increases with temperature** (approximately doubles for every 10°C rise)

    **Reason:**
    1. More molecules have sufficient energy (activation energy)
    2. Frequency of collisions increases

    **Quantitative:** Arrhenius equation (discussed in next lesson)

    ## IIT JEE Key Points

    1. **Rate = -1/a × d[A]/dt** (with stoichiometric coefficient)
    2. **Rate law:** Rate = k[A]ˣ[B]ʸ (experimental)
    3. **Order:** Sum of powers (x + y)
    4. **Molecularity:** Molecules in elementary step
    5. **Order ≠ Molecularity** (except elementary reactions)
    6. **Units of k:** Depend on overall order
    7. **Zero order:** Rate = k
    8. **First order:** Rate = k[A], units of k = s⁻¹
    9. **Second order:** Rate = k[A]² or k[A][B]
    10. **Pseudo order:** Excess reagent makes it lower order

    ## Quick Reference

    | Order | Rate Law | Units of k | Example |
    |-------|----------|------------|---------|
    | 0 | Rate = k | mol L⁻¹ s⁻¹ | Photochemical |
    | 1 | Rate = k[A] | s⁻¹ | Radioactive decay |
    | 2 | Rate = k[A]² | L mol⁻¹ s⁻¹ | 2HI → H₂+I₂ |
    | 3 | Rate = k[A]²[B] | L² mol⁻² s⁻¹ | 2NO+O₂ |

    ## Summary Formulas

    | Concept | Formula |
    |---------|---------|
    | Rate | -1/a(d[A]/dt) = 1/c(d[C]/dt) |
    | Rate law | k[A]ˣ[B]ʸ |
    | Overall order | x + y |
    | k (first order) | s⁻¹ |
    | k (second order) | L mol⁻¹ s⁻¹ |

## Key Points

- Rate of reaction

- Rate law

- Order of reaction
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Rate of reaction', 'Rate law', 'Order of reaction', 'Molecularity', 'Rate constant', 'Factors affecting rate'],
  prerequisite_ids: []
)

puts "✓ Created 18 microlessons for Chemical Kinetics"

# AUTO-GENERATED from module_04_states_of_matter.rb
puts "Creating Microlessons for States Of Matter..."

module_var = CourseModule.find_by(slug: 'states-of-matter')

# === MICROLESSON 1: solid_state — Practice ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'solid_state — Practice',
  content: <<~MARKDOWN,
# solid_state — Practice 🚀

In BCC, the central atom touches 8 corner atoms, giving coordination number = 8. (SC=6, FCC=12)

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['solid_state'],
  prerequisite_ids: []
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the coordination number in a Body-Centered Cubic (BCC) structure?',
    options: ['4', '6', '8', '12'],
    correct_answer: 2,
    explanation: 'In BCC, the central atom touches 8 corner atoms, giving coordination number = 8. (SC=6, FCC=12)',
    difficulty: 'easy'
  }
)

# === MICROLESSON 2: Kinetic Molecular Theory & Real Gases ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Kinetic Molecular Theory & Real Gases',
  content: <<~MARKDOWN,
# Kinetic Molecular Theory & Real Gases 🚀

# Kinetic Molecular Theory & Real Gases

    ## Kinetic Molecular Theory (KMT)

    ### Postulates:

    1. Gases consist of tiny particles (atoms/molecules)
    2. Volume of gas particles is **negligible** compared to container volume
    3. Particles in **constant random motion**
    4. **No attractive or repulsive forces** between particles
    5. Collisions are **perfectly elastic** (KE conserved)
    6. **Average kinetic energy ∝ absolute temperature**

    ## Kinetic Gas Equation

    **PV = (1/3)mnc²**

    Where:
    - m = mass of one molecule
    - n = number of molecules
    - c² = mean square velocity

    Combining with PV = nRT:

    **KE = (3/2)kT** (per molecule)
    **KE = (3/2)RT** (per mole)

    Where k = Boltzmann constant = R/Nₐ = 1.38 × 10⁻²³ J/K

    ## Types of Molecular Velocities

    ### 1. Most Probable Velocity (ump)

    **Velocity possessed by maximum number of molecules**

    **uₘₚ = √(2RT/M) = √(2kT/m)**

    ### 2. Average Velocity (uavg)

    **Arithmetic mean of velocities**

    **uₐᵥ��� = √(8RT/πM) = √(8kT/πm)**

    ### 3. Root Mean Square Velocity (urms)

    **Square root of mean of squared velocities**

    **uᵣₘₛ = √(3RT/M) = √(3kT/m)**

    ### Relationship:

    **uᵣₘₛ : uₐᵥ�� : uₘₚ = √3 : √(8/π) : √2 ≈ 1.73 : 1.60 : 1.41**

    **uᵣₘₛ > uₐᵥ�� > uₘₚ**

    ### Important Points:
    - All velocities ∝ √T
    - All velocities ∝ 1/√M
    - At same T: lighter gas molecules move faster

    ## Solved Problems on Velocity

    ### Problem 1: Calculate RMS velocity

    **Q: Calculate urms of O₂ at 27°C. (R = 8.314 J·mol⁻¹·K⁻¹, M = 32 g/mol)**

    Solution:
    - M = 32 × 10⁻³ kg/mol (convert to SI)
    - T = 300 K
    - uᵣₘₛ = √(3RT/M) = √(3 × 8.314 × 300)/(32 × 10⁻³)
    - uᵣₘₛ = √(7482.6/0.032) = √233,831
    - uᵣₘₛ = **484 m/s**

    ### Problem 2: Temperature for equal RMS

    **Q: At what temperature will O₂ have same urms as N₂ at 25°C?**

    Solution:
    - For same urms: √(T₁/M₁) = √(T₂/M₂)
    - T_O₂/32 = 298/28
    - T_O₂ = (298 × 32)/28 = **341 K = 68°C**

    ### Problem 3: Ratio of velocities

    **Q: Find ratio of urms of H₂ and O₂ at same temperature.**

    Solution:
    - u₁/u₂ = √(M₂/M₁) = √(32/2) = √16 = **4:1**
    - H₂ moves 4 times faster than O₂

    ## Real Gases

    **Real gases deviate from ideal behavior because:**

    1. Gas molecules have **finite volume**
    2. **Intermolecular forces** exist (van der Waals forces)

    ### Deviations:

    - **High pressure:** Molecular volume becomes significant
    - **Low temperature:** Attractive forces become important
    - **Polar gases:** Greater intermolecular forces → more deviation

    ## Compressibility Factor (Z)

    **Z = PV/nRT**

    **Interpretation:**
    - **Z = 1:** Ideal gas behavior
    - **Z > 1:** Repulsive forces dominant (high P, small V)
    - **Z < 1:** Attractive forces dominant (low P, large V)

    ### For Real Gases:
    - At very high P: Z > 1
    - At moderate P: Z < 1
    - At very low P: Z ≈ 1 (approaches ideal)

    ## van der Waals Equation

    **Corrected equation for real gases:**

    **(P + an²/V²)(V - nb) = nRT**

    Or for 1 mole:

    **(P + a/V²)(V - b) = RT**

    ### Corrections:

    **1. Pressure correction:** P + a/V²
    - 'a' accounts for **attractive forces**
    - Real pressure is less than ideal
    - Units of a: atm·L²·mol⁻²

    **2. Volume correction:** V - b
    - 'b' accounts for **molecular volume**
    - Available volume is less
    - Units of b: L·mol⁻¹

    ### van der Waals Constants:

    | Gas | a (atm·L²·mol⁻²) | b (L·mol⁻¹) |
    |-----|------------------|-------------|
    | He | 0.034 | 0.024 |
    | H₂ | 0.244 | 0.027 |
    | O₂ | 1.360 | 0.032 |
    | N₂ | 1.390 | 0.039 |
    | CO₂ | 3.592 | 0.043 |
    | NH₃ | 4.170 | 0.037 |
    | H₂O | 5.464 | 0.031 |

    **Higher 'a':** Stronger intermolecular forces
    **Higher 'b':** Larger molecular size

    ## Boyle Temperature

    **Temperature at which real gas behaves ideally over wide range of pressures**

    **Tᵦ = a/(Rb)**

    - Below Tᵦ: Z < 1 (attractive dominant)
    - Above Tᵦ: Z > 1 (repulsive dominant)
    - At Tᵦ: Z ≈ 1 (ideal behavior)

    ## Critical Constants

    **Critical temperature (Tc):** Temperature above which gas cannot be liquefied by pressure alone

    **Critical pressure (Pc):** Minimum pressure required to liquefy gas at Tc

    **Critical volume (Vc):** Volume occupied by 1 mole at Tc and Pc

    ### Relationships with van der Waals constants:

    - **Tc = 8a/(27Rb)**
    - **Pc = a/(27b²)**
    - **Vc = 3b**

    ## Liquefaction of Gases

    **Conditions:**
    1. Temperature must be **below Tc**
    2. Apply **high pressure**
    3. **Cool** the gas

    **Easier to liquefy:**
    - Higher Tc → easier
    - Stronger intermolecular forces → easier
    - CO₂ (Tc = 31°C) easier than N₂ (Tc = -147°C)

    ## IIT JEE Key Points

    1. **KE = (3/2)RT** per mole
    2. **uᵣₘₛ = √(3RT/M)** (most important)
    3. **uᵣₘₛ > uₐᵥ�� > uₘₚ**
    4. All velocities **∝ √T** and **∝ 1/√M**
    5. **Z = PV/nRT** (compressibility factor)
    6. **Z = 1:** Ideal gas
    7. **Z < 1:** Attractive forces (low P, high T)
    8. **Z > 1:** Repulsive forces (high P, low T)
    9. **van der Waals:** (P + a/V²)(V - b) = RT
    10. **'a' for attraction, 'b' for volume**

    ## Quick Formulas

    | Quantity | Formula |
    |----------|---------|
    | uᵣₘₛ | √(3RT/M) |
    | uₐᵥ�� | √(8RT/πM) |
    | uₘₚ | √(2RT/M) |
    | KE (per mole) | (3/2)RT |
    | Z | PV/nRT |
    | van der Waals | (P+a/V²)(V-b)=RT |
    | Tc | 8a/(27Rb) |
    | Pc | a/(27b²) |
    | Vc | 3b |

## Key Points

- Kinetic theory

- RMS velocity

- Real gases
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Kinetic theory', 'RMS velocity', 'Real gases', 'van der Waals equation', 'Compressibility factor'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Liquid State & Solid State ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Liquid State & Solid State',
  content: <<~MARKDOWN,
# Liquid State & Solid State 🚀

# Liquid State & Solid State

    ## Liquid State

    ### Characteristics:
    1. **Definite volume** but no definite shape
    2. **Incompressible** (molecules close)
    3. **Flow** (take shape of container)
    4. **Intermediate** properties between gas and solid

    ## Vapor Pressure

    **Definition:** Pressure exerted by vapor when in equilibrium with liquid

    ### Factors Affecting Vapor Pressure:

    1. **Temperature:** ↑ T → ↑ vapor pressure
    2. **Nature of liquid:** Stronger IMF → lower vapor pressure
    3. **Independent of:** Amount of liquid, container volume

    ### Examples:
    - Volatile liquids (ether, acetone): High vapor pressure
    - Non-volatile liquids (water, glycerol): Low vapor pressure

    ## Boiling Point

    **Definition:** Temperature at which vapor pressure equals atmospheric pressure

    - Normal BP: Vapor pressure = 1 atm
    - At high altitude: Lower atmospheric pressure → lower BP
    - At sea level: Higher atmospheric pressure → higher BP

    ## Surface Tension (γ)

    **Definition:** Force per unit length acting perpendicular to a line on liquid surface

    **Units:** N/m or J/m²

    **γ = F/l = E/A**

    ### Factors Affecting Surface Tension:

    1. **Temperature:** ↑ T → ↓ γ (molecules have more KE)
    2. **IMF:** Stronger forces → higher γ
    3. **Impurities:** Usually decrease γ

    ### Examples:
    - Water: High γ (strong H-bonding)
    - Mercury: Very high γ (metallic bonding)
    - Organic solvents: Low γ (weak IMF)

    ## Viscosity (η)

    **Definition:** Resistance to flow (internal friction)

    **Units:** Poise (P) or Pa·s
    - 1 Poise = 0.1 Pa·s

    ### Factors Affecting Viscosity:

    1. **Temperature:** ↑ T → ↓ η (easier flow)
    2. **IMF:** Stronger forces → higher η
    3. **Molecular size:** Larger molecules → higher η
    4. **Molecular shape:** Complex shapes → higher η

    ### Examples:
    - Water: Low viscosity
    - Honey: High viscosity
    - Glycerol: Very high viscosity

    ## Solid State

    ### Types of Solids:

    **1. Crystalline Solids:**
    - Regular, ordered arrangement
    - Sharp melting point
    - Anisotropic properties
    - Examples: NaCl, diamond, metals

    **2. Amorphous Solids:**
    - Irregular arrangement
    - No sharp melting point (soften over range)
    - Isotropic properties
    - Examples: Glass, rubber, plastics

    ## Crystal Lattice

    **Lattice:** Regular 3D arrangement of points representing positions of atoms/ions/molecules

    **Unit Cell:** Smallest repeating unit that generates entire lattice by translation

    ### Unit Cell Parameters:

    **Dimensions (Axes):** a, b, c
    **Angles:** α (between b and c), β (between a and c), γ (between a and b)

    ## Seven Crystal Systems

    | System | Axes | Angles | Examples |
    |--------|------|--------|----------|
    | Cubic | a=b=c | α=β=γ=90° | NaCl, Cu |
    | Tetragonal | a=b≠c | α=β=γ=90° | SnO₂ |
    | Orthorhombic | a≠b≠c | α=β=γ=90° | BaSO₄ |
    | Monoclinic | a≠b≠c | α=γ=90°≠β | Na₂SO₄ |
    | Triclinic | a≠b≠c | α≠β≠γ | CuSO₄·5H₂O |
    | Hexagonal | a=b≠c | α=β=90°, γ=120° | Graphite |
    | Rhombohedral | a=b=c | α=β=γ≠90° | Calcite |

    ## Cubic Unit Cells

    ### 1. Simple Cubic (SC)

    - **Atoms at corners only**
    - Atoms per unit cell: 8 × 1/8 = **1**
    - Coordination number: **6**
    - Packing efficiency: **52%**
    - Examples: Po (rare)

    ### 2. Body-Centered Cubic (BCC)

    - **Atoms at corners + 1 at body center**
    - Atoms per unit cell: (8 × 1/8) + 1 = **2**
    - Coordination number: **8**
    - Packing efficiency: **68%**
    - Examples: Fe, Na, K, Cr

    ### 3. Face-Centered Cubic (FCC)

    - **Atoms at corners + 1 at each face center**
    - Atoms per unit cell: (8 × 1/8) + (6 × 1/2) = **4**
    - Coordination number: **12**
    - Packing efficiency: **74%**
    - Examples: Cu, Ag, Au, Al

    ## Packing Efficiency

    **Definition:** Percentage of space occupied by atoms in unit cell

    **Formula:**
    **PE = (Volume of atoms in unit cell / Volume of unit cell) × 100**

    ### Calculations:

    **Simple Cubic:**
    - PE = **52.4%**

    **Body-Centered Cubic:**
    - PE = **68.0%**

    **Face-Centered Cubic:**
    - PE = **74.0%** (maximum for spheres)

    **Hexagonal Close Packing (HCP):**
    - PE = **74.0%** (same as FCC)

    ## Close Packing

    ### Types:

    **1. Hexagonal Close Packing (HCP):**
    - Layer sequence: **ABAB...**
    - Coordination number: 12
    - Packing efficiency: 74%
    - Examples: Mg, Zn

    **2. Cubic Close Packing (CCP) = FCC:**
    - Layer sequence: **ABCABC...**
    - Coordination number: 12
    - Packing efficiency: 74%
    - Examples: Cu, Ag, Au

    ## Voids in Close Packing

    ### 1. Tetrahedral Void:
    - Surrounded by **4 atoms**
    - Number: **2n** (n = atoms in packing)
    - Smaller size

    ### 2. Octahedral Void:
    - Surrounded by **6 atoms**
    - Number: **n** (n = atoms in packing)
    - Larger than tetrahedral

    ## Relationship Between Edge Length and Radius

    ### Simple Cubic:
    - **a = 2r**

    ### Body-Centered Cubic:
    - **a = 4r/√3**
    - Body diagonal = 4r

    ### Face-Centered Cubic:
    - **a = 2√2r**
    - Face diagonal = 4r

    ## Density of Unit Cell

    **Formula:**
    **ρ = (Z × M)/(a³ × Nₐ)**

    Where:
    - Z = number of atoms per unit cell
    - M = molar mass
    - a = edge length (in cm)
    - Nₐ = Avogadro's number

    ### Solved Problem:

    **Q: Calculate density of Cu (FCC, a = 3.61 Å, M = 63.5 g/mol)**

    Solution:
    - Z = 4 (FCC)
    - a = 3.61 × 10⁻⁸ cm
    - ρ = (4 × 63.5)/(3.61 × 10⁻⁸)³ × (6.022 × 10²³)
    - ρ = 254/(4.71 × 10⁻²³ × 6.022 × 10²³)
    - ρ = **8.96 g/cm³**

    ## Types of Crystalline Solids

    ### 1. Ionic Solids:
    - Held by ionic bonds
    - High melting points
    - Conduct electricity when molten
    - Examples: NaCl, CaF₂

    ### 2. Covalent Solids:
    - Held by covalent bonds
    - Very high melting points
    - Hard, non-conductors
    - Examples: Diamond, SiO₂

    ### 3. Molecular Solids:
    - Held by van der Waals forces
    - Low melting points
    - Soft, non-conductors
    - Examples: Ice, dry ice

    ### 4. Metallic Solids:
    - Held by metallic bonds
    - Variable melting points
    - Good conductors
    - Examples: Fe, Cu, Al

    ## IIT JEE Key Points

    1. **Vapor pressure ↑** with temperature
    2. **Surface tension ↓** with temperature
    3. **Viscosity ↓** with temperature (for liquids)
    4. **7 crystal systems** (cubic most important)
    5. **SC:** Z=1, CN=6, PE=52%
    6. **BCC:** Z=2, CN=8, PE=68%
    7. **FCC:** Z=4, CN=12, PE=74%
    8. **Tetrahedral voids:** 2n
    9. **Octahedral voids:** n
    10. **Density:** ρ = (Z×M)/(a³×Nₐ)

    ## Quick Reference

    | Unit Cell | Z | CN | PE | a-r relation |
    |-----------|---|----|----|--------------|
    | SC | 1 | 6 | 52% | a = 2r |
    | BCC | 2 | 8 | 68% | a = 4r/√3 |
    | FCC | 4 | 12 | 74% | a = 2√2r |
    | HCP | 6 | 12 | 74% | - |

    ## Formulas

    | Property | Formula |
    |----------|---------|
    | Density | ρ = (Z×M)/(a³×Nₐ) |
    | No. of atoms | Z = (ρ×a³×Nₐ)/M |
    | Edge length | a = ∛(Z×M)/(ρ×Nₐ) |

## Key Points

- Vapor pressure

- Surface tension

- Viscosity
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Vapor pressure', 'Surface tension', 'Viscosity', 'Crystal systems', 'Packing efficiency', 'Unit cells'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Gaseous State & Gas Laws ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Gaseous State & Gas Laws',
  content: <<~MARKDOWN,
# Gaseous State & Gas Laws 🚀

# Gaseous State & Gas Laws

    ## Characteristics of Gases

    1. **No definite shape or volume** (take shape and volume of container)
    2. **Highly compressible** (large intermolecular spaces)
    3. **Low density** (molecules far apart)
    4. **Complete miscibility** (gases mix in all proportions)
    5. **Exert pressure** (due to molecular collisions)

    ## Gas Laws

    ### 1. Boyle's Law (P-V Relationship)

    **Statement:** At constant temperature, volume of a gas is inversely proportional to pressure

    **Mathematical Form:**
    - **V ∝ 1/P** (at constant T and n)
    - **PV = constant**
    - **P₁V₁ = P₂V₂**

    **Graph:** Rectangular hyperbola (PV vs P is horizontal line)

    ### Example:
    A gas occupies 5 L at 2 atm. What volume at 5 atm (constant T)?

    - P₁V₁ = P₂V₂
    - 2 × 5 = 5 × V₂
    - V₂ = **2 L**

    ### 2. Charles's Law (V-T Relationship)

    **Statement:** At constant pressure, volume of a gas is directly proportional to absolute temperature

    **Mathematical Form:**
    - **V ∝ T** (at constant P and n)
    - **V/T = constant**
    - **V₁/T₁ = V₂/T₂**

    **Important:** Temperature must be in **Kelvin**
    - **T(K) = T(°C) + 273**

    **Graph:** Straight line passing through origin (at 0 K, V = 0)

    ### Example:
    A gas at 300 K occupies 4 L. What volume at 450 K (constant P)?

    - V₁/T₁ = V₂/T₂
    - 4/300 = V₂/450
    - V₂ = **6 L**

    ### 3. Gay-Lussac's Law (P-T Relationship)

    **Statement:** At constant volume, pressure is directly proportional to absolute temperature

    **Mathematical Form:**
    - **P ∝ T** (at constant V and n)
    - **P/T = constant**
    - **P₁/T₁ = P₂/T₂**

    ### 4. Avogadro's Law (V-n Relationship)

    **Statement:** At constant temperature and pressure, volume is directly proportional to number of moles

    **Mathematical Form:**
    - **V ∝ n** (at constant T and P)
    - **V/n = constant**
    - **V₁/n₁ = V₂/n₂**

    **Consequence:** Equal volumes of all gases at same T and P contain equal number of molecules

    ## Combined Gas Law

    Combining Boyle's, Charles's, and Gay-Lussac's:

    **P₁V₁/T₁ = P₂V₂/T₂**

    (when amount of gas is constant)

    ## Ideal Gas Equation

    Combining all gas laws:

    **PV = nRT**

    Where:
    - P = pressure
    - V = volume
    - n = number of moles
    - R = universal gas constant
    - T = absolute temperature (K)

    ### Values of R:

    | Units | Value |
    |-------|-------|
    | L·atm·mol⁻¹·K⁻¹ | 0.0821 |
    | J·mol⁻¹·K⁻¹ | 8.314 |
    | cal·mol⁻¹·K⁻¹ | 1.987 |
    | erg·mol⁻¹·K⁻¹ | 8.314 × 10⁷ |

    ### Alternate Forms:

    **1. Using mass:**
    - PV = (w/M)RT
    - Where w = mass, M = molar mass

    **2. Using density:**
    - PM = dRT
    - Where d = density (mass/volume)

    **3. For standard conditions (STP):**
    - T = 273 K, P = 1 atm
    - Molar volume = 22.4 L

    ## Dalton's Law of Partial Pressures

    **Statement:** Total pressure of a mixture equals sum of partial pressures

    **P_total = P₁ + P₂ + P₃ + ...**

    **Partial pressure:**
    - **Pᵢ = Xᵢ × P_total**
    - Where Xᵢ = mole fraction = nᵢ/n_total

    ### Example:
    A mixture contains 2 mol N₂ and 3 mol O₂ at 5 atm total pressure. Find partial pressures.

    - X_N₂ = 2/5 = 0.4
    - X_O₂ = 3/5 = 0.6
    - P_N₂ = 0.4 × 5 = **2 atm**
    - P_O₂ = 0.6 × 5 = **3 atm**

    ## Graham's Law of Diffusion/Effusion

    **Statement:** Rate of diffusion is inversely proportional to square root of molar mass

    **r₁/r₂ = √(M₂/M₁) = √(d₂/d₁)**

    Where:
    - r = rate of diffusion/effusion
    - M = molar mass
    - d = density

    ### Example:
    Compare rates of diffusion of H₂ (M=2) and O₂ (M=32).

    - r_H₂/r_O₂ = √(32/2) = √16 = **4**
    - H₂ diffuses 4 times faster than O₂

    ## Solved IIT JEE Problems

    ### Problem 1: Ideal gas equation

    **Q: Calculate the volume occupied by 8.8 g of CO₂ at 31.1°C and 1 atm. (R = 0.0821 L·atm·mol⁻¹·K⁻¹)**

    Solution:
    - Molar mass of CO₂ = 44 g/mol
    - n = 8.8/44 = 0.2 mol
    - T = 31.1 + 273 = 304.1 K
    - PV = nRT
    - V = nRT/P = (0.2 × 0.0821 × 304.1)/1
    - V = **5.0 L**

    ### Problem 2: Gas density

    **Q: Calculate the density of NH₃ gas at 30°C and 5 atm.**

    Solution:
    - PM = dRT
    - d = PM/RT
    - M = 17 g/mol, T = 303 K
    - d = (5 × 17)/(0.0821 × 303)
    - d = **3.42 g/L**

    ### Problem 3: Combined gas law

    **Q: A gas occupies 2 L at 27°C and 2 atm. What volume at 127°C and 4 atm?**

    Solution:
    - P₁V₁/T₁ = P₂V₂/T₂
    - T₁ = 300 K, T₂ = 400 K
    - (2 × 2)/300 = (4 × V₂)/400
    - V₂ = **1.33 L**

    ### Problem 4: Partial pressure

    **Q: A vessel contains 0.5 mol H₂, 1 mol He, and 1.5 mol Ne at 10 atm. Find pressure of He.**

    Solution:
    - Total moles = 0.5 + 1 + 1.5 = 3 mol
    - X_He = 1/3
    - P_He = (1/3) × 10 = **3.33 atm**

    ### Problem 5: Graham's law

    **Q: A gas diffuses 4 times faster than O₂. Find its molar mass.**

    Solution:
    - r_gas/r_O₂ = √(M_O₂/M_gas) = 4
    - √(32/M) = 4
    - 32/M = 16
    - M = **2 g/mol** (Hydrogen)

    ## STP vs SATP

    ### STP (Standard Temperature and Pressure):
    - T = 273 K (0°C)
    - P = 1 atm (101.325 kPa)
    - Molar volume = 22.4 L

    ### SATP (Standard Ambient Temperature and Pressure):
    - T = 298 K (25°C)
    - P = 1 bar (100 kPa)
    - Molar volume = 24.8 L

    ## Ideal Gas Assumptions

    1. Gas molecules have **negligible volume** (point masses)
    2. **No intermolecular forces** (elastic collisions)
    3. Molecules move in **random motion**
    4. Collisions are **perfectly elastic** (no energy loss)
    5. **Average kinetic energy ∝ T**

    ## IIT JEE Key Points

    1. **Boyle's Law:** P₁V₁ = P₂V₂ (constant T)
    2. **Charles's Law:** V₁/T₁ = V₂/T₂ (constant P)
    3. **Combined:** P₁V₁/T₁ = P₂V₂/T₂
    4. **Ideal gas:** PV = nRT
    5. **Density form:** PM = dRT
    6. **R = 0.0821** L·atm·mol⁻¹·K⁻¹
    7. **STP:** 1 mol = 22.4 L
    8. **Dalton:** P_total = ΣPᵢ
    9. **Partial pressure:** Pᵢ = Xᵢ × P_total
    10. **Graham:** r₁/r₂ = √(M₂/M₁)

    ## Quick Formulas

    | Law | Formula | Variables |
    |-----|---------|-----------|
    | Boyle | P₁V₁ = P₂V₂ | T, n constant |
    | Charles | V₁/T₁ = V₂/T₂ | P, n constant |
    | Gay-Lussac | P₁/T₁ = P₂/T₂ | V, n constant |
    | Avogadro | V₁/n₁ = V₂/n₂ | T, P constant |
    | Ideal gas | PV = nRT | - |
    | Dalton | P_t = ΣPᵢ | Mixtures |
    | Graham | r∝1/√M | Diffusion |

## Key Points

- Gas laws

- Ideal gas equation

- Boyles law
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Gas laws', 'Ideal gas equation', 'Boyles law', 'Charles law', 'Avogadros law', 'Gas density'],
  prerequisite_ids: []
)

# === MICROLESSON 5: Kinetic Molecular Theory & Real Gases ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Kinetic Molecular Theory & Real Gases',
  content: <<~MARKDOWN,
# Kinetic Molecular Theory & Real Gases 🚀

# Kinetic Molecular Theory & Real Gases

    ## Kinetic Molecular Theory (KMT)

    ### Postulates:

    1. Gases consist of tiny particles (atoms/molecules)
    2. Volume of gas particles is **negligible** compared to container volume
    3. Particles in **constant random motion**
    4. **No attractive or repulsive forces** between particles
    5. Collisions are **perfectly elastic** (KE conserved)
    6. **Average kinetic energy ∝ absolute temperature**

    ## Kinetic Gas Equation

    **PV = (1/3)mnc²**

    Where:
    - m = mass of one molecule
    - n = number of molecules
    - c² = mean square velocity

    Combining with PV = nRT:

    **KE = (3/2)kT** (per molecule)
    **KE = (3/2)RT** (per mole)

    Where k = Boltzmann constant = R/Nₐ = 1.38 × 10⁻²³ J/K

    ## Types of Molecular Velocities

    ### 1. Most Probable Velocity (ump)

    **Velocity possessed by maximum number of molecules**

    **uₘₚ = √(2RT/M) = √(2kT/m)**

    ### 2. Average Velocity (uavg)

    **Arithmetic mean of velocities**

    **uₐᵥ��� = √(8RT/πM) = √(8kT/πm)**

    ### 3. Root Mean Square Velocity (urms)

    **Square root of mean of squared velocities**

    **uᵣₘₛ = √(3RT/M) = √(3kT/m)**

    ### Relationship:

    **uᵣₘₛ : uₐᵥ�� : uₘₚ = √3 : √(8/π) : √2 ≈ 1.73 : 1.60 : 1.41**

    **uᵣₘₛ > uₐᵥ�� > uₘₚ**

    ### Important Points:
    - All velocities ∝ √T
    - All velocities ∝ 1/√M
    - At same T: lighter gas molecules move faster

    ## Solved Problems on Velocity

    ### Problem 1: Calculate RMS velocity

    **Q: Calculate urms of O₂ at 27°C. (R = 8.314 J·mol⁻¹·K⁻¹, M = 32 g/mol)**

    Solution:
    - M = 32 × 10⁻³ kg/mol (convert to SI)
    - T = 300 K
    - uᵣₘₛ = √(3RT/M) = √(3 × 8.314 × 300)/(32 × 10⁻³)
    - uᵣₘₛ = √(7482.6/0.032) = √233,831
    - uᵣₘₛ = **484 m/s**

    ### Problem 2: Temperature for equal RMS

    **Q: At what temperature will O₂ have same urms as N₂ at 25°C?**

    Solution:
    - For same urms: √(T₁/M₁) = √(T₂/M₂)
    - T_O₂/32 = 298/28
    - T_O₂ = (298 × 32)/28 = **341 K = 68°C**

    ### Problem 3: Ratio of velocities

    **Q: Find ratio of urms of H₂ and O₂ at same temperature.**

    Solution:
    - u₁/u₂ = √(M₂/M₁) = √(32/2) = √16 = **4:1**
    - H₂ moves 4 times faster than O₂

    ## Real Gases

    **Real gases deviate from ideal behavior because:**

    1. Gas molecules have **finite volume**
    2. **Intermolecular forces** exist (van der Waals forces)

    ### Deviations:

    - **High pressure:** Molecular volume becomes significant
    - **Low temperature:** Attractive forces become important
    - **Polar gases:** Greater intermolecular forces → more deviation

    ## Compressibility Factor (Z)

    **Z = PV/nRT**

    **Interpretation:**
    - **Z = 1:** Ideal gas behavior
    - **Z > 1:** Repulsive forces dominant (high P, small V)
    - **Z < 1:** Attractive forces dominant (low P, large V)

    ### For Real Gases:
    - At very high P: Z > 1
    - At moderate P: Z < 1
    - At very low P: Z ≈ 1 (approaches ideal)

    ## van der Waals Equation

    **Corrected equation for real gases:**

    **(P + an²/V²)(V - nb) = nRT**

    Or for 1 mole:

    **(P + a/V²)(V - b) = RT**

    ### Corrections:

    **1. Pressure correction:** P + a/V²
    - 'a' accounts for **attractive forces**
    - Real pressure is less than ideal
    - Units of a: atm·L²·mol⁻²

    **2. Volume correction:** V - b
    - 'b' accounts for **molecular volume**
    - Available volume is less
    - Units of b: L·mol⁻¹

    ### van der Waals Constants:

    | Gas | a (atm·L²·mol⁻²) | b (L·mol⁻¹) |
    |-----|------------------|-------------|
    | He | 0.034 | 0.024 |
    | H₂ | 0.244 | 0.027 |
    | O₂ | 1.360 | 0.032 |
    | N₂ | 1.390 | 0.039 |
    | CO₂ | 3.592 | 0.043 |
    | NH₃ | 4.170 | 0.037 |
    | H₂O | 5.464 | 0.031 |

    **Higher 'a':** Stronger intermolecular forces
    **Higher 'b':** Larger molecular size

    ## Boyle Temperature

    **Temperature at which real gas behaves ideally over wide range of pressures**

    **Tᵦ = a/(Rb)**

    - Below Tᵦ: Z < 1 (attractive dominant)
    - Above Tᵦ: Z > 1 (repulsive dominant)
    - At Tᵦ: Z ≈ 1 (ideal behavior)

    ## Critical Constants

    **Critical temperature (Tc):** Temperature above which gas cannot be liquefied by pressure alone

    **Critical pressure (Pc):** Minimum pressure required to liquefy gas at Tc

    **Critical volume (Vc):** Volume occupied by 1 mole at Tc and Pc

    ### Relationships with van der Waals constants:

    - **Tc = 8a/(27Rb)**
    - **Pc = a/(27b²)**
    - **Vc = 3b**

    ## Liquefaction of Gases

    **Conditions:**
    1. Temperature must be **below Tc**
    2. Apply **high pressure**
    3. **Cool** the gas

    **Easier to liquefy:**
    - Higher Tc → easier
    - Stronger intermolecular forces → easier
    - CO₂ (Tc = 31°C) easier than N₂ (Tc = -147°C)

    ## IIT JEE Key Points

    1. **KE = (3/2)RT** per mole
    2. **uᵣₘₛ = √(3RT/M)** (most important)
    3. **uᵣₘₛ > uₐᵥ�� > uₘₚ**
    4. All velocities **∝ √T** and **∝ 1/√M**
    5. **Z = PV/nRT** (compressibility factor)
    6. **Z = 1:** Ideal gas
    7. **Z < 1:** Attractive forces (low P, high T)
    8. **Z > 1:** Repulsive forces (high P, low T)
    9. **van der Waals:** (P + a/V²)(V - b) = RT
    10. **'a' for attraction, 'b' for volume**

    ## Quick Formulas

    | Quantity | Formula |
    |----------|---------|
    | uᵣₘₛ | √(3RT/M) |
    | uₐᵥ�� | √(8RT/πM) |
    | uₘₚ | √(2RT/M) |
    | KE (per mole) | (3/2)RT |
    | Z | PV/nRT |
    | van der Waals | (P+a/V²)(V-b)=RT |
    | Tc | 8a/(27Rb) |
    | Pc | a/(27b²) |
    | Vc | 3b |

## Key Points

- Kinetic theory

- RMS velocity

- Real gases
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Kinetic theory', 'RMS velocity', 'Real gases', 'van der Waals equation', 'Compressibility factor'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Liquid State & Solid State ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Liquid State & Solid State',
  content: <<~MARKDOWN,
# Liquid State & Solid State 🚀

# Liquid State & Solid State

    ## Liquid State

    ### Characteristics:
    1. **Definite volume** but no definite shape
    2. **Incompressible** (molecules close)
    3. **Flow** (take shape of container)
    4. **Intermediate** properties between gas and solid

    ## Vapor Pressure

    **Definition:** Pressure exerted by vapor when in equilibrium with liquid

    ### Factors Affecting Vapor Pressure:

    1. **Temperature:** ↑ T → ↑ vapor pressure
    2. **Nature of liquid:** Stronger IMF → lower vapor pressure
    3. **Independent of:** Amount of liquid, container volume

    ### Examples:
    - Volatile liquids (ether, acetone): High vapor pressure
    - Non-volatile liquids (water, glycerol): Low vapor pressure

    ## Boiling Point

    **Definition:** Temperature at which vapor pressure equals atmospheric pressure

    - Normal BP: Vapor pressure = 1 atm
    - At high altitude: Lower atmospheric pressure → lower BP
    - At sea level: Higher atmospheric pressure → higher BP

    ## Surface Tension (γ)

    **Definition:** Force per unit length acting perpendicular to a line on liquid surface

    **Units:** N/m or J/m²

    **γ = F/l = E/A**

    ### Factors Affecting Surface Tension:

    1. **Temperature:** ↑ T → ↓ γ (molecules have more KE)
    2. **IMF:** Stronger forces → higher γ
    3. **Impurities:** Usually decrease γ

    ### Examples:
    - Water: High γ (strong H-bonding)
    - Mercury: Very high γ (metallic bonding)
    - Organic solvents: Low γ (weak IMF)

    ## Viscosity (η)

    **Definition:** Resistance to flow (internal friction)

    **Units:** Poise (P) or Pa·s
    - 1 Poise = 0.1 Pa·s

    ### Factors Affecting Viscosity:

    1. **Temperature:** ↑ T → ↓ η (easier flow)
    2. **IMF:** Stronger forces → higher η
    3. **Molecular size:** Larger molecules → higher η
    4. **Molecular shape:** Complex shapes → higher η

    ### Examples:
    - Water: Low viscosity
    - Honey: High viscosity
    - Glycerol: Very high viscosity

    ## Solid State

    ### Types of Solids:

    **1. Crystalline Solids:**
    - Regular, ordered arrangement
    - Sharp melting point
    - Anisotropic properties
    - Examples: NaCl, diamond, metals

    **2. Amorphous Solids:**
    - Irregular arrangement
    - No sharp melting point (soften over range)
    - Isotropic properties
    - Examples: Glass, rubber, plastics

    ## Crystal Lattice

    **Lattice:** Regular 3D arrangement of points representing positions of atoms/ions/molecules

    **Unit Cell:** Smallest repeating unit that generates entire lattice by translation

    ### Unit Cell Parameters:

    **Dimensions (Axes):** a, b, c
    **Angles:** α (between b and c), β (between a and c), γ (between a and b)

    ## Seven Crystal Systems

    | System | Axes | Angles | Examples |
    |--------|------|--------|----------|
    | Cubic | a=b=c | α=β=γ=90° | NaCl, Cu |
    | Tetragonal | a=b≠c | α=β=γ=90° | SnO₂ |
    | Orthorhombic | a≠b≠c | α=β=γ=90° | BaSO₄ |
    | Monoclinic | a≠b≠c | α=γ=90°≠β | Na₂SO₄ |
    | Triclinic | a≠b≠c | α≠β≠γ | CuSO₄·5H₂O |
    | Hexagonal | a=b≠c | α=β=90°, γ=120° | Graphite |
    | Rhombohedral | a=b=c | α=β=γ≠90° | Calcite |

    ## Cubic Unit Cells

    ### 1. Simple Cubic (SC)

    - **Atoms at corners only**
    - Atoms per unit cell: 8 × 1/8 = **1**
    - Coordination number: **6**
    - Packing efficiency: **52%**
    - Examples: Po (rare)

    ### 2. Body-Centered Cubic (BCC)

    - **Atoms at corners + 1 at body center**
    - Atoms per unit cell: (8 × 1/8) + 1 = **2**
    - Coordination number: **8**
    - Packing efficiency: **68%**
    - Examples: Fe, Na, K, Cr

    ### 3. Face-Centered Cubic (FCC)

    - **Atoms at corners + 1 at each face center**
    - Atoms per unit cell: (8 × 1/8) + (6 × 1/2) = **4**
    - Coordination number: **12**
    - Packing efficiency: **74%**
    - Examples: Cu, Ag, Au, Al

    ## Packing Efficiency

    **Definition:** Percentage of space occupied by atoms in unit cell

    **Formula:**
    **PE = (Volume of atoms in unit cell / Volume of unit cell) × 100**

    ### Calculations:

    **Simple Cubic:**
    - PE = **52.4%**

    **Body-Centered Cubic:**
    - PE = **68.0%**

    **Face-Centered Cubic:**
    - PE = **74.0%** (maximum for spheres)

    **Hexagonal Close Packing (HCP):**
    - PE = **74.0%** (same as FCC)

    ## Close Packing

    ### Types:

    **1. Hexagonal Close Packing (HCP):**
    - Layer sequence: **ABAB...**
    - Coordination number: 12
    - Packing efficiency: 74%
    - Examples: Mg, Zn

    **2. Cubic Close Packing (CCP) = FCC:**
    - Layer sequence: **ABCABC...**
    - Coordination number: 12
    - Packing efficiency: 74%
    - Examples: Cu, Ag, Au

    ## Voids in Close Packing

    ### 1. Tetrahedral Void:
    - Surrounded by **4 atoms**
    - Number: **2n** (n = atoms in packing)
    - Smaller size

    ### 2. Octahedral Void:
    - Surrounded by **6 atoms**
    - Number: **n** (n = atoms in packing)
    - Larger than tetrahedral

    ## Relationship Between Edge Length and Radius

    ### Simple Cubic:
    - **a = 2r**

    ### Body-Centered Cubic:
    - **a = 4r/√3**
    - Body diagonal = 4r

    ### Face-Centered Cubic:
    - **a = 2√2r**
    - Face diagonal = 4r

    ## Density of Unit Cell

    **Formula:**
    **ρ = (Z × M)/(a³ × Nₐ)**

    Where:
    - Z = number of atoms per unit cell
    - M = molar mass
    - a = edge length (in cm)
    - Nₐ = Avogadro's number

    ### Solved Problem:

    **Q: Calculate density of Cu (FCC, a = 3.61 Å, M = 63.5 g/mol)**

    Solution:
    - Z = 4 (FCC)
    - a = 3.61 × 10⁻⁸ cm
    - ρ = (4 × 63.5)/(3.61 × 10⁻⁸)³ × (6.022 × 10²³)
    - ρ = 254/(4.71 × 10⁻²³ × 6.022 × 10²³)
    - ρ = **8.96 g/cm³**

    ## Types of Crystalline Solids

    ### 1. Ionic Solids:
    - Held by ionic bonds
    - High melting points
    - Conduct electricity when molten
    - Examples: NaCl, CaF₂

    ### 2. Covalent Solids:
    - Held by covalent bonds
    - Very high melting points
    - Hard, non-conductors
    - Examples: Diamond, SiO₂

    ### 3. Molecular Solids:
    - Held by van der Waals forces
    - Low melting points
    - Soft, non-conductors
    - Examples: Ice, dry ice

    ### 4. Metallic Solids:
    - Held by metallic bonds
    - Variable melting points
    - Good conductors
    - Examples: Fe, Cu, Al

    ## IIT JEE Key Points

    1. **Vapor pressure ↑** with temperature
    2. **Surface tension ↓** with temperature
    3. **Viscosity ↓** with temperature (for liquids)
    4. **7 crystal systems** (cubic most important)
    5. **SC:** Z=1, CN=6, PE=52%
    6. **BCC:** Z=2, CN=8, PE=68%
    7. **FCC:** Z=4, CN=12, PE=74%
    8. **Tetrahedral voids:** 2n
    9. **Octahedral voids:** n
    10. **Density:** ρ = (Z×M)/(a³×Nₐ)

    ## Quick Reference

    | Unit Cell | Z | CN | PE | a-r relation |
    |-----------|---|----|----|--------------|
    | SC | 1 | 6 | 52% | a = 2r |
    | BCC | 2 | 8 | 68% | a = 4r/√3 |
    | FCC | 4 | 12 | 74% | a = 2√2r |
    | HCP | 6 | 12 | 74% | - |

    ## Formulas

    | Property | Formula |
    |----------|---------|
    | Density | ρ = (Z×M)/(a³×Nₐ) |
    | No. of atoms | Z = (ρ×a³×Nₐ)/M |
    | Edge length | a = ∛(Z×M)/(ρ×Nₐ) |

## Key Points

- Vapor pressure

- Surface tension

- Viscosity
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Vapor pressure', 'Surface tension', 'Viscosity', 'Crystal systems', 'Packing efficiency', 'Unit cells'],
  prerequisite_ids: []
)

# === MICROLESSON 7: gas_laws — Practice ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'gas_laws — Practice',
  content: <<~MARKDOWN,
# gas_laws — Practice 🚀

Using Boyle\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['gas_laws'],
  prerequisite_ids: []
)

# Exercise 7.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'A gas occupies 10 L at 2 atm pressure. What will be its volume at 5 atm if temperature is constant?',
    answer: '4',
    explanation: 'Using Boyle\',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 8: gas_laws — Practice ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'gas_laws — Practice',
  content: <<~MARKDOWN,
# gas_laws — Practice 🚀

Using Charles\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['gas_laws'],
  prerequisite_ids: []
)

# Exercise 8.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'A gas at 300 K occupies 5 L. What volume will it occupy at 450 K if pressure is constant?',
    answer: '7.5',
    explanation: 'Using Charles\',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 9: ideal_gas_equation — Practice ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'ideal_gas_equation — Practice',
  content: <<~MARKDOWN,
# ideal_gas_equation — Practice 🚀

Using PV = nRT: n = PV/RT = (2×5)/(0.0821×300) = 10/24.63 = 0.406 mol

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['ideal_gas_equation'],
  prerequisite_ids: []
)

# Exercise 9.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many moles of gas are present in 5 L at 2 atm and 300 K? (R = 0.0821 L·atm·mol⁻¹·K⁻¹)',
    answer: '0.406',
    explanation: 'Using PV = nRT: n = PV/RT = (2×5)/(0.0821×300) = 10/24.63 = 0.406 mol',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 10: grahams_law — Practice ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'grahams_law — Practice',
  content: <<~MARKDOWN,
# grahams_law — Practice 🚀

Graham\

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['grahams_law'],
  prerequisite_ids: []
)

# Exercise 10.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'If He diffuses at rate 4 times that of an unknown gas, what is the molar mass of the unknown gas? (He = 4 g/mol)',
    answer: '64',
    explanation: 'Graham\',
    difficulty: 'medium',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 11: kinetic_theory — Practice ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'kinetic_theory — Practice',
  content: <<~MARKDOWN,
# kinetic_theory — Practice 🚀

urms = √(3RT/M), which shows urms ∝ √T (square root of temperature)

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['kinetic_theory'],
  prerequisite_ids: []
)

# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'The RMS velocity of a gas is proportional to:',
    options: ['√T', 'T', 'T²', '1/T'],
    correct_answer: 0,
    explanation: 'urms = √(3RT/M), which shows urms ∝ √T (square root of temperature)',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: real_gases — Practice ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'real_gases — Practice',
  content: <<~MARKDOWN,
# real_gases — Practice 🚀

Z = PV/nRT. For ideal gas, PV = nRT, so Z = 1. Real gases deviate: Z > 1 or Z < 1

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['real_gases'],
  prerequisite_ids: []
)

# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'For an ideal gas, the compressibility factor Z equals:',
    options: ['0', '1', 'Greater than 1', 'Less than 1'],
    correct_answer: 1,
    explanation: 'Z = PV/nRT. For ideal gas, PV = nRT, so Z = 1. Real gases deviate: Z > 1 or Z < 1',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: real_gases — Practice ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'real_gases — Practice',
  content: <<~MARKDOWN,
# real_gases — Practice 🚀

In van der Waals equation: \

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['real_gases'],
  prerequisite_ids: []
)

# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In van der Waals equation (P + a/V²)(V - b) = RT, which corrections apply?',
    options: ['a corrects for intermolecular attractions', 'b corrects for molecular volume', 'a corrects for molecular volume', 'b corrects for temperature'],
    correct_answer: 1,
    explanation: 'In van der Waals equation: \',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: solid_state — Practice ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'solid_state — Practice',
  content: <<~MARKDOWN,
# solid_state — Practice 🚀

FCC has: 8 corner atoms (×1/8) + 6 face atoms (×1/2) = 1 + 3 = 4 atoms per unit cell

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['solid_state'],
  prerequisite_ids: []
)

# Exercise 14.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'How many atoms are present in one Face-Centered Cubic (FCC) unit cell?',
    answer: '4',
    explanation: 'FCC has: 8 corner atoms (×1/8) + 6 face atoms (×1/2) = 1 + 3 = 4 atoms per unit cell',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 15: packing_efficiency — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'packing_efficiency — Practice',
  content: <<~MARKDOWN,
# packing_efficiency — Practice 🚀

FCC has the highest packing efficiency of 74%. This is also the packing efficiency of HCP (Hexagonal Close Packing)

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['packing_efficiency'],
  prerequisite_ids: []
)

# Exercise 15.2: Short Answer
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'short_answer',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the packing efficiency (in %) of a Face-Centered Cubic structure?',
    answer: '74',
    explanation: 'FCC has the highest packing efficiency of 74%. This is also the packing efficiency of HCP (Hexagonal Close Packing)',
    difficulty: 'easy',
    hints: ['Re-read the question carefully.', 'Recall the relevant formula or rule.', 'Review the explanation once you answer.']
  }
)

# === MICROLESSON 16: Gaseous State & Gas Laws ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Gaseous State & Gas Laws',
  content: <<~MARKDOWN,
# Gaseous State & Gas Laws 🚀

# Gaseous State & Gas Laws

    ## Characteristics of Gases

    1. **No definite shape or volume** (take shape and volume of container)
    2. **Highly compressible** (large intermolecular spaces)
    3. **Low density** (molecules far apart)
    4. **Complete miscibility** (gases mix in all proportions)
    5. **Exert pressure** (due to molecular collisions)

    ## Gas Laws

    ### 1. Boyle's Law (P-V Relationship)

    **Statement:** At constant temperature, volume of a gas is inversely proportional to pressure

    **Mathematical Form:**
    - **V ∝ 1/P** (at constant T and n)
    - **PV = constant**
    - **P₁V₁ = P₂V₂**

    **Graph:** Rectangular hyperbola (PV vs P is horizontal line)

    ### Example:
    A gas occupies 5 L at 2 atm. What volume at 5 atm (constant T)?

    - P₁V₁ = P₂V₂
    - 2 × 5 = 5 × V₂
    - V₂ = **2 L**

    ### 2. Charles's Law (V-T Relationship)

    **Statement:** At constant pressure, volume of a gas is directly proportional to absolute temperature

    **Mathematical Form:**
    - **V ∝ T** (at constant P and n)
    - **V/T = constant**
    - **V₁/T₁ = V₂/T₂**

    **Important:** Temperature must be in **Kelvin**
    - **T(K) = T(°C) + 273**

    **Graph:** Straight line passing through origin (at 0 K, V = 0)

    ### Example:
    A gas at 300 K occupies 4 L. What volume at 450 K (constant P)?

    - V₁/T₁ = V₂/T₂
    - 4/300 = V₂/450
    - V₂ = **6 L**

    ### 3. Gay-Lussac's Law (P-T Relationship)

    **Statement:** At constant volume, pressure is directly proportional to absolute temperature

    **Mathematical Form:**
    - **P ∝ T** (at constant V and n)
    - **P/T = constant**
    - **P₁/T₁ = P₂/T₂**

    ### 4. Avogadro's Law (V-n Relationship)

    **Statement:** At constant temperature and pressure, volume is directly proportional to number of moles

    **Mathematical Form:**
    - **V ∝ n** (at constant T and P)
    - **V/n = constant**
    - **V₁/n₁ = V₂/n₂**

    **Consequence:** Equal volumes of all gases at same T and P contain equal number of molecules

    ## Combined Gas Law

    Combining Boyle's, Charles's, and Gay-Lussac's:

    **P₁V₁/T₁ = P₂V₂/T₂**

    (when amount of gas is constant)

    ## Ideal Gas Equation

    Combining all gas laws:

    **PV = nRT**

    Where:
    - P = pressure
    - V = volume
    - n = number of moles
    - R = universal gas constant
    - T = absolute temperature (K)

    ### Values of R:

    | Units | Value |
    |-------|-------|
    | L·atm·mol⁻¹·K⁻¹ | 0.0821 |
    | J·mol⁻¹·K⁻¹ | 8.314 |
    | cal·mol⁻¹·K⁻¹ | 1.987 |
    | erg·mol⁻¹·K⁻¹ | 8.314 × 10⁷ |

    ### Alternate Forms:

    **1. Using mass:**
    - PV = (w/M)RT
    - Where w = mass, M = molar mass

    **2. Using density:**
    - PM = dRT
    - Where d = density (mass/volume)

    **3. For standard conditions (STP):**
    - T = 273 K, P = 1 atm
    - Molar volume = 22.4 L

    ## Dalton's Law of Partial Pressures

    **Statement:** Total pressure of a mixture equals sum of partial pressures

    **P_total = P₁ + P₂ + P₃ + ...**

    **Partial pressure:**
    - **Pᵢ = Xᵢ × P_total**
    - Where Xᵢ = mole fraction = nᵢ/n_total

    ### Example:
    A mixture contains 2 mol N₂ and 3 mol O₂ at 5 atm total pressure. Find partial pressures.

    - X_N₂ = 2/5 = 0.4
    - X_O₂ = 3/5 = 0.6
    - P_N₂ = 0.4 × 5 = **2 atm**
    - P_O₂ = 0.6 × 5 = **3 atm**

    ## Graham's Law of Diffusion/Effusion

    **Statement:** Rate of diffusion is inversely proportional to square root of molar mass

    **r₁/r₂ = √(M₂/M₁) = √(d₂/d₁)**

    Where:
    - r = rate of diffusion/effusion
    - M = molar mass
    - d = density

    ### Example:
    Compare rates of diffusion of H₂ (M=2) and O₂ (M=32).

    - r_H₂/r_O₂ = √(32/2) = √16 = **4**
    - H₂ diffuses 4 times faster than O₂

    ## Solved IIT JEE Problems

    ### Problem 1: Ideal gas equation

    **Q: Calculate the volume occupied by 8.8 g of CO₂ at 31.1°C and 1 atm. (R = 0.0821 L·atm·mol⁻¹·K⁻¹)**

    Solution:
    - Molar mass of CO₂ = 44 g/mol
    - n = 8.8/44 = 0.2 mol
    - T = 31.1 + 273 = 304.1 K
    - PV = nRT
    - V = nRT/P = (0.2 × 0.0821 × 304.1)/1
    - V = **5.0 L**

    ### Problem 2: Gas density

    **Q: Calculate the density of NH₃ gas at 30°C and 5 atm.**

    Solution:
    - PM = dRT
    - d = PM/RT
    - M = 17 g/mol, T = 303 K
    - d = (5 × 17)/(0.0821 × 303)
    - d = **3.42 g/L**

    ### Problem 3: Combined gas law

    **Q: A gas occupies 2 L at 27°C and 2 atm. What volume at 127°C and 4 atm?**

    Solution:
    - P₁V₁/T₁ = P₂V₂/T₂
    - T₁ = 300 K, T₂ = 400 K
    - (2 × 2)/300 = (4 × V₂)/400
    - V₂ = **1.33 L**

    ### Problem 4: Partial pressure

    **Q: A vessel contains 0.5 mol H₂, 1 mol He, and 1.5 mol Ne at 10 atm. Find pressure of He.**

    Solution:
    - Total moles = 0.5 + 1 + 1.5 = 3 mol
    - X_He = 1/3
    - P_He = (1/3) × 10 = **3.33 atm**

    ### Problem 5: Graham's law

    **Q: A gas diffuses 4 times faster than O₂. Find its molar mass.**

    Solution:
    - r_gas/r_O₂ = √(M_O₂/M_gas) = 4
    - √(32/M) = 4
    - 32/M = 16
    - M = **2 g/mol** (Hydrogen)

    ## STP vs SATP

    ### STP (Standard Temperature and Pressure):
    - T = 273 K (0°C)
    - P = 1 atm (101.325 kPa)
    - Molar volume = 22.4 L

    ### SATP (Standard Ambient Temperature and Pressure):
    - T = 298 K (25°C)
    - P = 1 bar (100 kPa)
    - Molar volume = 24.8 L

    ## Ideal Gas Assumptions

    1. Gas molecules have **negligible volume** (point masses)
    2. **No intermolecular forces** (elastic collisions)
    3. Molecules move in **random motion**
    4. Collisions are **perfectly elastic** (no energy loss)
    5. **Average kinetic energy ∝ T**

    ## IIT JEE Key Points

    1. **Boyle's Law:** P₁V₁ = P₂V₂ (constant T)
    2. **Charles's Law:** V₁/T₁ = V₂/T₂ (constant P)
    3. **Combined:** P₁V₁/T₁ = P₂V₂/T₂
    4. **Ideal gas:** PV = nRT
    5. **Density form:** PM = dRT
    6. **R = 0.0821** L·atm·mol⁻¹·K⁻¹
    7. **STP:** 1 mol = 22.4 L
    8. **Dalton:** P_total = ΣPᵢ
    9. **Partial pressure:** Pᵢ = Xᵢ × P_total
    10. **Graham:** r₁/r₂ = √(M₂/M₁)

    ## Quick Formulas

    | Law | Formula | Variables |
    |-----|---------|-----------|
    | Boyle | P₁V₁ = P₂V₂ | T, n constant |
    | Charles | V₁/T₁ = V₂/T₂ | P, n constant |
    | Gay-Lussac | P₁/T₁ = P₂/T₂ | V, n constant |
    | Avogadro | V₁/n₁ = V₂/n₂ | T, P constant |
    | Ideal gas | PV = nRT | - |
    | Dalton | P_t = ΣPᵢ | Mixtures |
    | Graham | r∝1/√M | Diffusion |

## Key Points

- Gas laws

- Ideal gas equation

- Boyles law
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Gas laws', 'Ideal gas equation', 'Boyles law', 'Charles law', 'Avogadros law', 'Gas density'],
  prerequisite_ids: []
)

puts "✓ Created 16 microlessons for States Of Matter"

# frozen_string_literal: true

# ========================================
# IIT JEE Physical Chemistry - Module 2
# Atomic Structure & Quantum Mechanics
# ========================================
# Complete module with lessons and questions
# Bohr model, quantum numbers, and electronic configuration
# ========================================

puts "\n" + "=" * 80
puts "MODULE 2: ATOMIC STRUCTURE & QUANTUM MECHANICS"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-physical-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Physical Chemistry course not found!"
  puts "   Please run module_00_mole_concept.rb first"
  exit 1
end

# Create Module 2: Atomic Structure
module_2 = course.course_modules.find_or_create_by!(slug: 'atomic-structure-quantum-mechanics') do |m|
  m.title = 'Atomic Structure & Quantum Mechanics'
  m.sequence_order = 2
  m.estimated_minutes = 400
  m.description = 'Bohr model, wave-particle duality, quantum numbers, orbitals, and electronic configuration'
  m.learning_objectives = [
    'Understand evolution of atomic models (Thomson to Bohr)',
    'Master de Broglie equation and Heisenberg uncertainty principle',
    'Learn quantum numbers and their significance',
    'Understand atomic orbitals and their shapes',
    'Master electronic configuration using aufbau, Pauli, and Hund rules',
    'Solve IIT JEE problems on atomic structure'
  ]
  m.published = true
end

puts "✅ Module 2: #{module_2.title}"

# ========================================
# Lesson 2.1: Atomic Models & Bohr Theory
# ========================================

lesson_2_1 = CourseLesson.create!(
  title: 'Atomic Models & Bohr Theory',
  reading_time_minutes: 45,
  key_concepts: ['Atomic models', 'Rutherford model', 'Bohr model', 'Hydrogen spectrum', 'Energy levels'],
  content: <<~MD
    # Atomic Models & Bohr Theory

    ## Evolution of Atomic Models

    ### 1. Dalton's Atomic Theory (1808)
    - Atoms are indivisible particles
    - All atoms of an element are identical
    - **Limitation:** Couldn't explain divisibility, isotopes

    ### 2. Thomson's Plum Pudding Model (1904)
    - Atom is a positively charged sphere with electrons embedded
    - Like plums in a pudding
    - **Limitation:** Couldn't explain Rutherford's scattering experiment

    ### 3. Rutherford's Nuclear Model (1911)

    **Gold Foil Experiment:**
    - Alpha particles (α) bombarded on thin gold foil
    - Most passed through (atom is mostly empty)
    - Few deflected at large angles (dense positive nucleus)

    **Model:**
    - Atom has a dense, positive nucleus
    - Electrons revolve around nucleus like planets
    - Most of atom is empty space

    **Limitations:**
    1. Couldn't explain stability of atom (accelerating electrons should radiate energy)
    2. Couldn't explain line spectra of hydrogen

    ## Electromagnetic Radiation

    **Key Properties:**
    - Wavelength (λ): Distance between two crests
    - Frequency (ν): Number of waves per second
    - Speed of light (c): 3 × 10⁸ m/s

    **Relationships:**
    - **c = νλ** (speed = frequency × wavelength)
    - **E = hν = hc/λ** (energy of photon)
    - h = Planck's constant = 6.626 × 10⁻³⁴ J·s

    ## Hydrogen Spectrum

    When hydrogen gas is excited, it emits light of specific wavelengths (line spectrum).

    ### Spectral Series:

    | Series | Region | Transition |
    |--------|--------|------------|
    | Lyman | UV | n → 1 |
    | Balmer | Visible | n → 2 |
    | Paschen | IR | n → 3 |
    | Brackett | IR | n → 4 |
    | Pfund | IR | n → 5 |

    ### Rydberg Equation:

    **1/λ = R(1/n₁² - 1/n₂²)**

    Where:
    - R = Rydberg constant = 1.097 × 10⁷ m⁻¹
    - n₁ = lower energy level
    - n₂ = higher energy level (n₂ > n₁)

    ## Bohr's Model of Hydrogen Atom (1913)

    ### Postulates:

    1. **Stationary Orbits:** Electrons revolve in certain fixed orbits without radiating energy
    2. **Quantized Angular Momentum:** mvr = nh/2π (n = 1, 2, 3...)
    3. **Energy Emission:** When electron jumps from higher to lower orbit, energy is emitted as photon
       - ΔE = E₂ - E₁ = hν

    ### Key Formulas:

    **Radius of nth orbit:**
    - **rₙ = 0.529n²/Z Å** (for H-like atoms)
    - For H: r₁ = 0.529 Å (Bohr radius)

    **Velocity in nth orbit:**
    - **vₙ = 2.18 × 10⁶ × Z/n m/s**

    **Energy of nth orbit:**
    - **Eₙ = -13.6Z²/n² eV** (for H-like atoms)
    - For hydrogen (Z=1): E₁ = -13.6 eV, E₂ = -3.4 eV, E₃ = -1.51 eV

    **Energy of photon emitted:**
    - **ΔE = 13.6Z²(1/n₁² - 1/n₂²) eV**

    ### Important Points:

    1. Energy is **negative** (electron is bound to nucleus)
    2. Energy **increases** as n increases (becomes less negative)
    3. At n = ∞, E = 0 (electron is free, ionization)
    4. Ground state: n = 1 (lowest energy, most stable)
    5. Excited states: n > 1

    ## Solved Problems

    ### Problem 1: Calculate wavelength of photon

    **Q: Calculate wavelength of radiation emitted when electron in H atom jumps from n=3 to n=2.**

    Solution:
    - ΔE = 13.6(1/2² - 1/3²) = 13.6(1/4 - 1/9) = 13.6 × 5/36 = 1.89 eV
    - Convert to Joules: 1.89 × 1.6 × 10⁻¹⁹ = 3.024 × 10⁻¹⁹ J
    - E = hc/λ → λ = hc/E
    - λ = (6.626 × 10⁻³⁴ × 3 × 10⁸)/(3.024 × 10⁻¹⁹)
    - λ = 6.56 × 10⁻⁷ m = **656 nm** (red line in Balmer series)

    ### Problem 2: Ionization energy

    **Q: Calculate ionization energy of hydrogen atom.**

    Solution:
    - Ionization means removing electron from ground state (n=1) to n=∞
    - ΔE = E∞ - E₁ = 0 - (-13.6) = **13.6 eV**
    - In kJ/mol: 13.6 × 96.5 = **1312 kJ/mol**

    ### Problem 3: He⁺ ion

    **Q: Calculate energy of electron in first orbit of He⁺ ion (Z=2).**

    Solution:
    - Eₙ = -13.6Z²/n² = -13.6 × 4/1 = **-54.4 eV**

    ### Problem 4: Radius calculation

    **Q: Calculate radius of 3rd orbit of hydrogen atom.**

    Solution:
    - rₙ = 0.529n²/Z = 0.529 × 9/1 = **4.76 Å**

    ## Limitations of Bohr Model

    1. **Only works for hydrogen** (one-electron systems)
    2. Couldn't explain **fine structure** of spectral lines
    3. Couldn't explain **Zeeman effect** (splitting in magnetic field)
    4. Couldn't explain **Stark effect** (splitting in electric field)
    5. Couldn't explain **intensities** of spectral lines
    6. Violates **Heisenberg uncertainty principle**

    ## Number of Spectral Lines

    When electron falls from nth level to ground state:

    **Number of lines = n(n-1)/2**

    ### Example:
    - From n=4 to n=1: Lines = 4(3)/2 = 6 lines
    - Transitions: 4→3, 4→2, 4→1, 3→2, 3→1, 2→1

    ## IIT JEE Key Points

    1. **Energy is negative** in Bohr model (bound electron)
    2. **Energy increases** (becomes less negative) as n increases
    3. **Radius ∝ n²** (rₙ = 0.529n² Å for H)
    4. **Energy ∝ -1/n²** (Eₙ = -13.6/n² eV for H)
    5. **Ionization energy** of H = 13.6 eV = 1312 kJ/mol
    6. For **He⁺, Li²⁺** etc.: Multiply by Z²
    7. **Balmer series** → visible region (n → 2)
    8. **c = νλ** and **E = hν = hc/λ**
    9. Number of lines from n: **n(n-1)/2**
    10. **Rydberg equation:** 1/λ = R(1/n₁² - 1/n₂²)

    ## Quick Formulas

    | Quantity | Formula | For Hydrogen |
    |----------|---------|--------------|
    | Radius | rₙ = 0.529n²/Z Å | 0.529n² Å |
    | Velocity | vₙ = 2.18×10⁶Z/n m/s | 2.18×10⁶/n m/s |
    | Energy | Eₙ = -13.6Z²/n² eV | -13.6/n² eV |
    | Photon energy | ΔE = 13.6Z²(1/n₁² - 1/n₂²) eV | |
    | Wave equation | c = νλ | |
    | Photon energy | E = hν = hc/λ | |
  MD
)

ModuleItem.create!(course_module: module_2, item: lesson_2_1, sequence_order: 1, required: true)

puts "  ✓ Lesson 2.1: #{lesson_2_1.title}"

# ========================================
# Lesson 2.2: Wave-Particle Duality & Quantum Numbers
# ========================================

lesson_2_2 = CourseLesson.create!(
  title: 'Wave-Particle Duality & Quantum Numbers',
  reading_time_minutes: 45,
  key_concepts: ['de Broglie equation', 'Heisenberg uncertainty', 'Schrodinger equation', 'Quantum numbers', 'Orbitals'],
  content: <<~MD
    # Wave-Particle Duality & Quantum Numbers

    ## de Broglie Hypothesis (1924)

    **Concept:** Matter has both particle and wave properties

    ### de Broglie Equation:

    **λ = h/mv = h/p**

    Where:
    - λ = wavelength of matter wave
    - h = Planck's constant = 6.626 × 10⁻³⁴ J·s
    - m = mass of particle
    - v = velocity
    - p = momentum (mv)

    ### Key Points:
    - All moving particles have wave character
    - Wavelength is **inversely proportional to momentum**
    - For macroscopic objects, λ is negligibly small
    - For electrons, λ is significant and measurable

    ### Solved Problems:

    **Problem 1: Calculate wavelength of electron**

    **Q: Calculate de Broglie wavelength of electron moving with velocity 2.05 × 10⁶ m/s.**

    Solution:
    - m = 9.11 × 10⁻³¹ kg
    - λ = h/mv = (6.626 × 10⁻³⁴)/(9.11 × 10⁻³¹ × 2.05 × 10⁶)
    - λ = 3.55 × 10⁻¹⁰ m = **0.355 nm**

    **Problem 2: Compare wavelengths**

    **Q: Calculate ratio of de Broglie wavelengths of proton and electron moving with same velocity.**

    Solution:
    - λ₁/λ₂ = (h/m₁v)/(h/m₂v) = m₂/m₁
    - λₚ/λₑ = mₑ/mₚ = (9.11 × 10⁻³¹)/(1.67 × 10⁻²⁷)
    - **λₑ/λₚ = 1836:1** (electron wavelength is 1836 times larger)

    ## Heisenberg Uncertainty Principle (1927)

    **Principle:** It is impossible to determine simultaneously the exact position and momentum of a particle with absolute precision.

    ### Mathematical Form:

    **Δx · Δp ≥ h/4π**

    Or equivalently:

    **Δx · Δv ≥ h/4πm**

    Where:
    - Δx = uncertainty in position
    - Δp = uncertainty in momentum
    - Δv = uncertainty in velocity
    - h = Planck's constant

    ### Important Points:
    1. More precisely we know position, less precisely we know momentum (and vice versa)
    2. This is **fundamental limitation of nature**, not instrumental
    3. Significant for microscopic particles (electrons)
    4. Negligible for macroscopic objects
    5. Explains why Bohr's fixed orbits are incorrect

    ### Solved Problem:

    **Q: Calculate uncertainty in position of electron if uncertainty in velocity is 5.7 × 10⁵ m/s.**

    Solution:
    - Δx · Δv ≥ h/4πm
    - Δx ≥ (6.626 × 10⁻³⁴)/(4 × 3.14 × 9.11 × 10⁻³¹ × 5.7 × 10⁵)
    - Δx ≥ **1.01 × 10⁻¹⁰ m = 1.01 Å**

    ## Schrödinger Wave Equation

    **Equation:** Ĥψ = Eψ

    - ψ (psi) = wave function (describes state of electron)
    - ψ² = probability density (probability of finding electron)
    - Solutions give **quantum numbers** and **energy levels**

    ### Key Concepts:
    - **Orbital** = region of space where probability of finding electron is maximum (typically 90%)
    - Orbital is NOT a fixed path (unlike Bohr orbit)
    - ψ² gives probability distribution

    ## Quantum Numbers

    Four quantum numbers describe an electron in an atom:

    ### 1. Principal Quantum Number (n)

    **Symbol:** n
    **Values:** 1, 2, 3, 4, ... (positive integers)

    **Significance:**
    - Determines **main energy level** or **shell**
    - Larger n → higher energy, farther from nucleus
    - n = 1 (K shell), n = 2 (L shell), n = 3 (M shell), n = 4 (N shell)

    **Maximum electrons in shell = 2n²**
    - n=1: max 2 electrons
    - n=2: max 8 electrons
    - n=3: max 18 electrons
    - n=4: max 32 electrons

    ### 2. Azimuthal Quantum Number (l)

    **Symbol:** l (or ℓ)
    **Values:** 0, 1, 2, 3, ... (n-1)

    **Significance:**
    - Determines **subshell** or **sublevel**
    - Determines **shape of orbital**

    | l value | Subshell | Shape |
    |---------|----------|-------|
    | 0 | s | Spherical |
    | 1 | p | Dumbbell |
    | 2 | d | Complex |
    | 3 | f | More complex |

    **Number of orbitals in subshell = 2l + 1**
    - s: 1 orbital
    - p: 3 orbitals
    - d: 5 orbitals
    - f: 7 orbitals

    **Maximum electrons in subshell = 2(2l + 1)**
    - s: 2 electrons
    - p: 6 electrons
    - d: 10 electrons
    - f: 14 electrons

    ### 3. Magnetic Quantum Number (mₗ)

    **Symbol:** mₗ (or m)
    **Values:** -l to +l (including 0)

    **Significance:**
    - Determines **orientation of orbital** in space
    - Number of values = 2l + 1 (number of orbitals)

    **Examples:**
    - l = 0 (s): mₗ = 0 (1 orbital)
    - l = 1 (p): mₗ = -1, 0, +1 (3 orbitals: px, py, pz)
    - l = 2 (d): mₗ = -2, -1, 0, +1, +2 (5 orbitals)

    ### 4. Spin Quantum Number (mₛ)

    **Symbol:** mₛ (or s)
    **Values:** +½ or -½

    **Significance:**
    - Describes **spin** of electron (intrinsic angular momentum)
    - +½ = spin up (↑)
    - -½ = spin down (↓)
    - Two electrons in same orbital must have **opposite spins**

    ## Summary Table

    | Quantum Number | Symbol | Values | Determines |
    |----------------|--------|--------|------------|
    | Principal | n | 1, 2, 3... | Shell, energy |
    | Azimuthal | l | 0 to (n-1) | Subshell, shape |
    | Magnetic | mₗ | -l to +l | Orientation |
    | Spin | mₛ | +½, -½ | Spin direction |

    ## Possible Combinations

    ### For n = 1:
    - l = 0 (1s)
    - mₗ = 0
    - mₛ = +½, -½
    - **2 electrons in 1s orbital**

    ### For n = 2:
    - l = 0 (2s): 1 orbital, 2 electrons
    - l = 1 (2p): 3 orbitals (px, py, pz), 6 electrons
    - **Total: 8 electrons in n=2 shell**

    ### For n = 3:
    - l = 0 (3s): 2 electrons
    - l = 1 (3p): 6 electrons
    - l = 2 (3d): 10 electrons
    - **Total: 18 electrons in n=3 shell**

    ## IIT JEE Key Points

    1. **de Broglie:** λ = h/mv (matter waves)
    2. **Heisenberg:** Δx·Δp ≥ h/4π (uncertainty)
    3. **n determines shell**: 1(K), 2(L), 3(M), 4(N)
    4. **l determines subshell**: 0(s), 1(p), 2(d), 3(f)
    5. **mₗ determines orientation**: -l to +l
    6. **mₛ determines spin**: +½ or -½
    7. **Max electrons in shell**: 2n²
    8. **Max electrons in subshell**: 2(2l+1)
    9. **Number of orbitals**: (2l+1)
    10. **Orbital ≠ Orbit** (probability vs fixed path)

    ## Common Questions

    **Q: How many electrons can have n=3, l=2?**
    A: l=2 is d subshell, can hold 10 electrons

    **Q: How many orbitals in n=3?**
    A: 3s(1) + 3p(3) + 3d(5) = **9 orbitals**

    **Q: Which is impossible: (a) n=2, l=2 (b) n=3, l=2?**
    A: (a) is impossible (l cannot equal n)

    ## Practice Tips
    - Remember: **l < n** always
    - For given n: l = 0, 1, 2, ... (n-1)
    - For given l: (2l+1) orbitals, 2(2l+1) electrons
    - **s² p⁶ d¹⁰ f¹⁴** (max electrons)
  MD
)

ModuleItem.create!(course_module: module_2, item: lesson_2_2, sequence_order: 2, required: true)

puts "  ✓ Lesson 2.2: #{lesson_2_2.title}"

# ========================================
# Lesson 2.3: Electronic Configuration
# ========================================

lesson_2_3 = CourseLesson.create!(
  title: 'Electronic Configuration & Periodic Trends',
  reading_time_minutes: 50,
  key_concepts: ['Aufbau principle', 'Pauli exclusion', 'Hunds rule', 'Electronic configuration', 'Orbital diagrams'],
  content: <<~MD
    # Electronic Configuration

    ## Principles for Filling Electrons

    ### 1. Aufbau Principle

    **Principle:** Electrons fill orbitals starting from lowest energy to highest energy

    **Energy Order:**
    1s < 2s < 2p < 3s < 3p < 4s < 3d < 4p < 5s < 4d < 5p < 6s < 4f < 5d < 6p < 7s < 5f < 6d < 7p

    **n + l Rule:**
    - Orbital with **lower (n + l)** fills first
    - If (n + l) is same, **lower n** fills first

    **Examples:**
    - 3d: n+l = 3+2 = 5
    - 4s: n+l = 4+0 = 4
    - Therefore, 4s fills before 3d

    - 4d: n+l = 4+2 = 6
    - 5p: n+l = 5+1 = 6
    - Same n+l, but 4d has lower n, so 4d fills before 5p

    ### 2. Pauli Exclusion Principle

    **Principle:** No two electrons in an atom can have the same set of four quantum numbers

    **Consequence:**
    - Maximum **2 electrons** per orbital
    - These two must have **opposite spins** (↑↓)

    ### 3. Hund's Rule of Maximum Multiplicity

    **Principle:** Electrons occupy degenerate orbitals (same energy) singly with parallel spins before pairing occurs

    **Example: Carbon (6 electrons)**
    - 1s² 2s² 2p²
    - 2p orbitals: ↑ ↑ _ (not ↑↓ _ _)
    - Electrons enter different p orbitals first

    **Example: Nitrogen (7 electrons)**
    - 1s² 2s² 2p³
    - 2p orbitals: ↑ ↑ ↑ (all three singly occupied)

    **Example: Oxygen (8 electrons)**
    - 1s² 2s² 2p⁴
    - 2p orbitals: ↑↓ ↑ ↑ (pairing starts)

    ## Writing Electronic Configurations

    ### Method 1: Complete Configuration

    **Examples:**

    **H (Z=1):** 1s¹

    **He (Z=2):** 1s²

    **C (Z=6):** 1s² 2s² 2p²

    **Na (Z=11):** 1s² 2s² 2p⁶ 3s¹

    **Ar (Z=18):** 1s² 2s² 2p⁶ 3s² 3p⁶

    **K (Z=19):** 1s² 2s² 2p⁶ 3s² 3p⁶ 4s¹

    **Ca (Z=20):** 1s² 2s² 2p⁶ 3s² 3p⁶ 4s²

    **Sc (Z=21):** 1s² 2s² 2p⁶ 3s² 3p⁶ 3d¹ 4s²

    **Fe (Z=26):** 1s² 2s² 2p⁶ 3s² 3p⁶ 3d⁶ 4s²

    ### Method 2: Noble Gas Core Configuration

    Use nearest noble gas in brackets:

    **Na (Z=11):** [Ne] 3s¹

    **Al (Z=13):** [Ne] 3s² 3p¹

    **K (Z=19):** [Ar] 4s¹

    **Fe (Z=26):** [Ar] 3d⁶ 4s²

    **Br (Z=35):** [Ar] 3d¹⁰ 4s² 4p⁵

    ## Exceptions to Aufbau Principle

    ### Half-filled and Fully-filled Stability

    **Extra stability** for:
    - **Half-filled** subshells (d⁵, f⁷)
    - **Fully-filled** subshells (d¹⁰, f¹⁴)

    ### Important Exceptions:

    **Chromium (Cr, Z=24):**
    - Expected: [Ar] 3d⁴ 4s²
    - Actual: **[Ar] 3d⁵ 4s¹** (half-filled d⁵ more stable)

    **Copper (Cu, Z=29):**
    - Expected: [Ar] 3d⁹ 4s²
    - Actual: **[Ar] 3d¹⁰ 4s¹** (fully-filled d¹⁰ more stable)

    **Molybdenum (Mo, Z=42):**
    - Actual: **[Kr] 4d⁵ 5s¹** (half-filled)

    **Silver (Ag, Z=47):**
    - Actual: **[Kr] 4d¹⁰ 5s¹** (fully-filled)

    **Gold (Au, Z=79):**
    - Actual: **[Xe] 4f¹⁴ 5d¹⁰ 6s¹** (fully-filled)

    ## Electronic Configuration of Ions

    ### Cations (Positive Ions)

    **Rule:** Remove electrons from **highest n orbital first**, then from d orbitals

    **Examples:**

    **Fe²⁺ (Z=26):**
    - Fe: [Ar] 3d⁶ 4s²
    - Fe²⁺: **[Ar] 3d⁶** (remove 2 electrons from 4s)

    **Fe³⁺ (Z=26):**
    - Fe²⁺: [Ar] 3d⁶
    - Fe³⁺: **[Ar] 3d⁵** (remove 1 more from 3d, gives half-filled)

    **Cu⁺ (Z=29):**
    - Cu: [Ar] 3d¹⁰ 4s¹
    - Cu⁺: **[Ar] 3d¹⁰** (remove from 4s)

    **Cr³⁺ (Z=24):**
    - Cr: [Ar] 3d⁵ 4s¹
    - Cr³⁺: **[Ar] 3d³** (remove 1 from 4s, 2 from 3d)

    ### Anions (Negative Ions)

    **Rule:** Add electrons to the orbital being filled

    **Examples:**

    **O²⁻ (Z=8):**
    - O: 1s² 2s² 2p⁴
    - O²⁻: **1s² 2s² 2p⁶** = [Ne]

    **Cl⁻ (Z=17):**
    - Cl: [Ne] 3s² 3p⁵
    - Cl⁻: **[Ne] 3s² 3p⁶** = [Ar]

    ## Isoelectronic Species

    **Definition:** Species having same number of electrons

    **Examples:**
    - **10 electrons:** O²⁻, F⁻, Ne, Na⁺, Mg²⁺, Al³⁺
    - **18 electrons:** S²⁻, Cl⁻, Ar, K⁺, Ca²⁺

    **Trend in size:** As nuclear charge increases, size decreases
    - O²⁻ > F⁻ > Ne > Na⁺ > Mg²⁺ > Al³⁺

    ## Paramagnetic vs Diamagnetic

    **Paramagnetic:**
    - Contains **unpaired electrons**
    - Attracted by magnetic field
    - Examples: O₂, Cu²⁺, Fe³⁺

    **Diamagnetic:**
    - All electrons **paired**
    - Weakly repelled by magnetic field
    - Examples: N₂, He, Zn²⁺

    ### How to Determine:

    **O (Z=8):** 1s² 2s² 2p⁴
    - 2p: ↑↓ ↑ ↑ → **2 unpaired electrons** → Paramagnetic

    **O²⁻ (Z=8, 10 e⁻):** 1s² 2s² 2p⁶
    - All paired → **Diamagnetic**

    **Cu (Z=29):** [Ar] 3d¹⁰ 4s¹
    - **1 unpaired electron** → Paramagnetic

    **Cu⁺:** [Ar] 3d¹⁰
    - All paired → **Diamagnetic**

    **Cu²⁺:** [Ar] 3d⁹
    - **1 unpaired electron** → Paramagnetic

    ## Solved IIT JEE Problems

    ### Problem 1: Configuration and unpaired electrons

    **Q: Give electronic configuration of Mn²⁺ (Z=25). How many unpaired electrons?**

    Solution:
    - Mn: [Ar] 3d⁵ 4s²
    - Mn²⁺: [Ar] 3d⁵ (remove 2 from 4s)
    - 3d⁵: ↑ ↑ ↑ ↑ ↑
    - **5 unpaired electrons** (maximum for d orbitals)

    ### Problem 2: Isoelectronic species

    **Q: Which of the following are isoelectronic with Ne?**
    **Options: (a) O²⁻ (b) F⁻ (c) Na⁺ (d) Mg²⁺**

    Solution:
    - Ne has 10 electrons
    - O²⁻: 8+2 = 10 ✓
    - F⁻: 9+1 = 10 ✓
    - Na⁺: 11-1 = 10 ✓
    - Mg²⁺: 12-2 = 10 ✓
    - **All are isoelectronic with Ne**

    ### Problem 3: Exception identification

    **Q: Which element shows exception to aufbau principle?**

    Solution:
    - Cr (Z=24): [Ar] 3d⁵ 4s¹ (not 3d⁴ 4s²)
    - Cu (Z=29): [Ar] 3d¹⁰ 4s¹ (not 3d⁹ 4s²)

    ## IIT JEE Key Points

    1. **Aufbau order:** 1s 2s 2p 3s 3p 4s 3d 4p 5s 4d 5p 6s 4f...
    2. **n+l rule:** Lower (n+l) fills first
    3. **Pauli:** Max 2 electrons per orbital, opposite spins
    4. **Hund:** Singly occupy degenerate orbitals first
    5. **Exceptions:** Cr (3d⁵ 4s¹), Cu (3d¹⁰ 4s¹)
    6. **For ions:** Remove from highest n first
    7. **Half-filled (d⁵, f⁷)** and **fully-filled (d¹⁰, f¹⁴)** are stable
    8. **Paramagnetic:** Unpaired electrons
    9. **Diamagnetic:** All paired
    10. **Isoelectronic:** Same electron count

    ## Quick Reference

    | Subshell | Max e⁻ | Orbitals |
    |----------|--------|----------|
    | s | 2 | 1 |
    | p | 6 | 3 |
    | d | 10 | 5 |
    | f | 14 | 7 |

    | Shell | Max e⁻ | Subshells |
    |-------|--------|-----------|
    | n=1 | 2 | 1s |
    | n=2 | 8 | 2s 2p |
    | n=3 | 18 | 3s 3p 3d |
    | n=4 | 32 | 4s 4p 4d 4f |
  MD
)

ModuleItem.create!(course_module: module_2, item: lesson_2_3, sequence_order: 3, required: true)

puts "  ✓ Lesson 2.3: #{lesson_2_3.title}"

# ========================================
# Quiz 2: Atomic Structure & Quantum Mechanics
# ========================================

quiz_2 = Quiz.create!(
  title: 'Atomic Structure & Quantum Mechanics Mastery',
  description: 'Test your understanding of Bohr model, quantum mechanics, and electronic configuration',
  time_limit_minutes: 45,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_2, item: quiz_2, sequence_order: 4, required: true)

# Questions for Quiz 2 (10 questions)
QuizQuestion.create!([
  # Question 1: Bohr energy calculation
  {
    quiz: quiz_2,
    question_type: 'numerical',
    question_text: 'Calculate the energy (in eV) of the electron in the first orbit of a hydrogen atom. (Use E = -13.6/n²)',
    correct_answer: '-13.6',
    tolerance: 0.1,
    explanation: 'For n=1: E₁ = -13.6 × 1²/1² = -13.6 eV (ground state energy of hydrogen)',
    points: 2,
    difficulty: -0.3,
    discrimination: 1.0,
    guessing: 0.0,
    difficulty_level: 'easy',
    topic: 'bohr_model',
    skill_dimension: 'recall',
    sequence_order: 1
  },

  # Question 2: de Broglie wavelength
  {
    quiz: quiz_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'The de Broglie wavelength is inversely proportional to:',
    options: [
      { text: 'Mass', correct: false },
      { text: 'Velocity', correct: false },
      { text: 'Momentum', correct: true },
      { text: 'Energy', correct: false }
    ],
    explanation: 'λ = h/p where p is momentum. Therefore, wavelength is inversely proportional to momentum (p = mv).',
    points: 2,
    difficulty: 0.1,
    discrimination: 1.1,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'wave_particle_duality',
    skill_dimension: 'conceptual_understanding',
    sequence_order: 2
  },

  # Question 3: Quantum numbers
  {
    quiz: quiz_2,
    question_type: 'numerical',
    question_text: 'How many orbitals are present in the n=3 shell?',
    correct_answer: '9',
    tolerance: 0,
    explanation: 'n=3 has: 3s (1 orbital) + 3p (3 orbitals) + 3d (5 orbitals) = 9 orbitals total',
    points: 3,
    difficulty: 0.3,
    discrimination: 1.2,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'quantum_numbers',
    skill_dimension: 'application',
    sequence_order: 3
  },

  # Question 4: Electronic configuration
  {
    quiz: quiz_2,
    question_type: 'fill_blank',
    question_text: 'What is the electronic configuration of chromium (Cr, Z=24)? Use [Ar] notation.',
    correct_answer: '[Ar] 3d5 4s1|[Ar] 3d⁵ 4s¹|[Ar]3d5 4s1|[Ar]3d⁵4s¹',
    explanation: 'Chromium shows exception to aufbau principle. Configuration is [Ar] 3d⁵ 4s¹ (half-filled d orbital is more stable than 3d⁴ 4s²)',
    points: 4,
    difficulty: 0.6,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'electronic_configuration',
    skill_dimension: 'application',
    sequence_order: 4
  },

  # Question 5: Pauli exclusion principle
  {
    quiz: quiz_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'According to Pauli exclusion principle, the maximum number of electrons that can occupy a single orbital is:',
    options: [
      { text: '1', correct: false },
      { text: '2', correct: true },
      { text: '4', correct: false },
      { text: '6', correct: false }
    ],
    explanation: 'Pauli exclusion principle states that no two electrons can have the same set of four quantum numbers. Therefore, maximum 2 electrons per orbital with opposite spins.',
    points: 2,
    difficulty: -0.4,
    discrimination: 1.0,
    guessing: 0.25,
    difficulty_level: 'easy',
    topic: 'quantum_principles',
    skill_dimension: 'recall',
    sequence_order: 5
  },

  # Question 6: Spectral lines
  {
    quiz: quiz_2,
    question_type: 'numerical',
    question_text: 'How many spectral lines will be observed when an electron jumps from n=5 to n=1 in hydrogen? (Use formula n(n-1)/2)',
    correct_answer: '10',
    tolerance: 0,
    explanation: 'From n=5: Number of lines = n(n-1)/2 = 5(4)/2 = 10 lines. These include: 5→4, 5→3, 5→2, 5→1, 4→3, 4→2, 4→1, 3→2, 3→1, 2→1',
    points: 3,
    difficulty: 0.4,
    discrimination: 1.3,
    guessing: 0.0,
    difficulty_level: 'medium',
    topic: 'hydrogen_spectrum',
    skill_dimension: 'problem_solving',
    sequence_order: 6
  },

  # Question 7: Unpaired electrons
  {
    quiz: quiz_2,
    question_type: 'numerical',
    question_text: 'How many unpaired electrons are present in Fe³⁺ ion? (Fe: Z=26)',
    correct_answer: '5',
    tolerance: 0,
    explanation: 'Fe: [Ar] 3d⁶ 4s². Fe³⁺: [Ar] 3d⁵ (remove 2 from 4s, 1 from 3d). The 3d⁵ configuration has all 5 d-orbitals singly occupied: ↑ ↑ ↑ ↑ ↑',
    points: 4,
    difficulty: 0.7,
    discrimination: 1.4,
    guessing: 0.0,
    difficulty_level: 'hard',
    topic: 'electronic_configuration',
    skill_dimension: 'problem_solving',
    sequence_order: 7
  },

  # Question 8: Isoelectronic species
  {
    quiz: quiz_2,
    question_type: 'mcq',
    multiple_correct: true,
    question_text: 'Which of the following species are isoelectronic with Ar (18 electrons)?',
    options: [
      { text: 'K⁺', correct: true },
      { text: 'Ca²⁺', correct: true },
      { text: 'Cl⁻', correct: true },
      { text: 'S²⁻', correct: true }
    ],
    explanation: 'All have 18 electrons: K⁺ (19-1=18), Ca²⁺ (20-2=18), Cl⁻ (17+1=18), S²⁻ (16+2=18)',
    points: 4,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.06,
    difficulty_level: 'medium',
    topic: 'electronic_configuration',
    skill_dimension: 'application',
    sequence_order: 8
  },

  # Question 9: Heisenberg uncertainty
  {
    quiz: quiz_2,
    question_type: 'true_false',
    question_text: 'According to Heisenberg uncertainty principle, it is impossible to determine both position and momentum of an electron with absolute precision simultaneously.',
    correct_answer: 'true',
    explanation: 'TRUE. Heisenberg uncertainty principle states: Δx·Δp ≥ h/4π. This is a fundamental limitation of nature, not of measurement instruments.',
    points: 2,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.5,
    difficulty_level: 'easy',
    topic: 'quantum_mechanics',
    skill_dimension: 'recall',
    sequence_order: 9
  },

  # Question 10: Paramagnetic vs diamagnetic
  {
    quiz: quiz_2,
    question_type: 'mcq',
    multiple_correct: false,
    question_text: 'Which of the following ions is diamagnetic?',
    options: [
      { text: 'Cu²⁺ [Ar] 3d⁹', correct: false },
      { text: 'Fe³⁺ [Ar] 3d⁵', correct: false },
      { text: 'Zn²⁺ [Ar] 3d¹⁰', correct: true },
      { text: 'Ni²⁺ [Ar] 3d⁸', correct: false }
    ],
    explanation: 'Zn²⁺ has configuration [Ar] 3d¹⁰ with all electrons paired, making it diamagnetic. All others have unpaired electrons and are paramagnetic.',
    points: 3,
    difficulty: 0.5,
    discrimination: 1.3,
    guessing: 0.25,
    difficulty_level: 'medium',
    topic: 'magnetic_properties',
    skill_dimension: 'application',
    sequence_order: 10
  }
])

puts "  ✓ Quiz 2: #{quiz_2.quiz_questions.count} questions created"

# ========================================
# Summary
# ========================================

puts "\n" + "=" * 80
puts "MODULE 2 COMPLETE"
puts "=" * 80
puts "✅ Module: #{module_2.title}"
puts "✅ Lessons: 3"
puts "✅ Quizzes: 1"
puts "✅ Questions: #{quiz_2.quiz_questions.count}"
puts "✅ Estimated Time: #{module_2.estimated_minutes} minutes"
puts "=" * 80
puts "\n"

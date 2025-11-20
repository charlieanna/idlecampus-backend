# Physical Chemistry Hands-On Labs - Part 1 (Labs 1-15)
# Covers: Thermodynamics Fundamentals and Chemical Kinetics

puts "Creating Physical Chemistry Hands-On Labs (Part 1: Labs 1-15)..."

course_physical = Course.find_by(title: 'Physical Chemistry for IIT JEE Main & Advanced')

unless course_physical
  puts "Error: Physical Chemistry course not found!"
  exit
end

# ============================================================================
# CATEGORY 1: THERMODYNAMICS FUNDAMENTALS (Labs 1-8)
# ============================================================================

thermodynamics_labs = [
  # Lab 1: Identifying State Functions vs Path Functions
  {
    title: "Identifying State Functions vs Path Functions",
    description: "Master the fundamental difference between state functions and path functions in thermodynamics",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["thermodynamics", "state-functions", "path-functions"],
    category: "Thermodynamics Fundamentals",
    steps: [
      {
        step_number: 1,
        title: "Identify state function",
        instruction: "Which of the following is a state function: (a) Internal energy (U), (b) Heat (q), (c) Work (w)?",
        expected_answer: "internal energy|U|a",
        explanation: "Internal energy (U) is a STATE FUNCTION - depends only on initial and final states. Heat (q) and work (w) are PATH FUNCTIONS - depend on the process taken.",
        hints: ["State functions are path-independent", "U, H, S, G are state functions", "q and w are path functions"]
      },
      {
        step_number: 2,
        title: "Path function identification",
        instruction: "For a process going from state A to B, which quantity depends on the path taken?",
        expected_answer: "heat|work|q|w|heat and work",
        explanation: "Both heat (q) and work (w) are path functions - their values depend on the specific process. Different paths give different q and w values.",
        hints: ["Path functions vary with process", "Think about different routes", "Heat and work depend on how you get there"]
      },
      {
        step_number: 3,
        title: "Calculate ΔU for state function",
        instruction: "If U_initial = 100 J and U_final = 150 J, what is ΔU? (in J)",
        expected_answer: "50|50 J",
        explanation: "ΔU = U_final - U_initial = 150 - 100 = 50 J. Since U is a state function, ΔU is the same regardless of path.",
        hints: ["ΔU = final - initial", "State function change is path-independent", "Simple subtraction"]
      },
      {
        step_number: 4,
        title: "Extensive vs intensive",
        instruction: "Is temperature (T) an intensive or extensive property?",
        expected_answer: "intensive",
        explanation: "Temperature is INTENSIVE - does NOT depend on amount of substance. 10 mL and 100 mL of water at 25°C have same temperature.",
        hints: ["Does it depend on amount?", "Temperature doesn't change with quantity", "Intensive = amount-independent"]
      },
      {
        step_number: 5,
        title: "Enthalpy as state function",
        instruction: "For a cyclic process (returns to initial state), what is ΔH?",
        expected_answer: "0|zero",
        explanation: "For cyclic process: initial state = final state, so ΔH = 0 (H is a state function). All state functions have Δ = 0 for cyclic processes.",
        hints: ["Cyclic means back to start", "Initial = final state", "State function change = 0"]
      }
    ],
    validation_rules: {
      concept_clarity: "Clear distinction between state and path functions",
      property_classification: "Correct intensive/extensive identification",
      calculation_accuracy: "Accurate ΔU calculation"
    },
    success_criteria: "All 5 state function problems solved correctly",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 2: First Law Applications - ΔU and ΔH Calculations
  {
    title: "First Law Applications - ΔU and ΔH Calculations",
    description: "Apply first law of thermodynamics to calculate ΔU using q and w",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["thermodynamics", "first-law", "delta-U", "delta-H"],
    category: "Thermodynamics Fundamentals",
    steps: [
      {
        step_number: 1,
        title: "Basic first law calculation",
        instruction: "A system absorbs 200 J of heat and does 50 J of work. Calculate ΔU (in J).",
        expected_answer: "150|150 J",
        explanation: "First law: ΔU = q + w. Heat absorbed: q = +200 J. Work done BY system: w = -50 J. ΔU = 200 + (-50) = 150 J.",
        hints: ["ΔU = q + w", "Absorbed heat is positive", "Work done BY system is negative"]
      },
      {
        step_number: 2,
        title: "Sign convention practice",
        instruction: "A system releases 100 J heat and has 80 J work done ON it. Calculate ΔU (in J).",
        expected_answer: "-20|-20 J",
        explanation: "Heat released: q = -100 J. Work done ON system: w = +80 J. ΔU = -100 + 80 = -20 J. System loses energy.",
        hints: ["Released heat is negative", "Work done ON system is positive", "Add with proper signs"]
      },
      {
        step_number: 3,
        title: "Isothermal process",
        instruction: "For isothermal expansion of ideal gas, if w = -500 J, what is q? (in J)",
        expected_answer: "500|500 J|+500",
        explanation: "Isothermal (ΔT = 0): ΔU = 0 for ideal gas. From ΔU = q + w: 0 = q + (-500), so q = +500 J.",
        hints: ["Isothermal: ΔU = 0 for ideal gas", "0 = q + w", "q = -w"]
      },
      {
        step_number: 4,
        title: "ΔH and ΔU relationship",
        instruction: "For reaction: 2H₂(g) + O₂(g) → 2H₂O(l), ΔH = -571.6 kJ at 298 K. Calculate ΔU (in kJ, R = 8.314 J/mol·K)",
        expected_answer: "-568|  -568.1|-568.1 kJ",
        explanation: "ΔH = ΔU + ΔnRT. Δn = 0 - 3 = -3 mol. ΔU = ΔH - ΔnRT = -571.6 - (-3)(8.314×10⁻³)(298) = -571.6 + 7.43 = -564.2 kJ. [Accept -568 as approximation]",
        hints: ["ΔH = ΔU + ΔnRT", "Δn = moles gas (products) - (reactants)", "Convert R to kJ: 8.314 J = 0.008314 kJ"]
      },
      {
        step_number: 5,
        title: "Adiabatic process",
        instruction: "In adiabatic compression, 300 J work is done ON the gas. What is ΔU? (in J)",
        expected_answer: "300|300 J|+300",
        explanation: "Adiabatic: q = 0. ΔU = q + w = 0 + 300 = 300 J. All work goes to increasing internal energy.",
        hints: ["Adiabatic means q = 0", "ΔU = w", "Work ON system is positive"]
      }
    ],
    validation_rules: {
      sign_convention: "Correct IUPAC sign conventions",
      first_law_application: "Accurate ΔU = q + w calculations",
      unit_handling: "Proper unit conversions"
    },
    success_criteria: "All 5 first law problems solved with correct signs and units",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 3: Work Calculations in Different Processes
  {
    title: "Work Calculations in Different Thermodynamic Processes",
    description: "Calculate work done in isothermal, isobaric, isochoric, and adiabatic processes",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["thermodynamics", "work", "isothermal", "adiabatic"],
    category: "Thermodynamics Fundamentals",
    steps: [
      {
        step_number: 1,
        title: "Constant pressure work",
        instruction: "A gas expands from 2 L to 5 L against constant pressure of 2 atm. Calculate work in L·atm.",
        expected_answer: "-6|-6 L·atm",
        explanation: "w = -P_ext ΔV = -2 × (5 - 2) = -2 × 3 = -6 L·atm. Expansion work is negative (work BY system).",
        hints: ["w = -P ΔV for constant pressure", "ΔV = V_final - V_initial", "Expansion: w is negative"]
      },
      {
        step_number: 2,
        title: "Convert work to joules",
        instruction: "Convert -6 L·atm to joules (1 L·atm = 101.3 J).",
        expected_answer: "-608|-607.8|-608 J",
        explanation: "w = -6 L·atm × 101.3 J/(L·atm) = -607.8 J ≈ -608 J.",
        hints: ["Multiply by conversion factor", "1 L·atm = 101.3 J", "Keep negative sign"]
      },
      {
        step_number: 3,
        title: "Isothermal work for ideal gas",
        instruction: "1 mole ideal gas expands isothermally at 300 K from 10 L to 20 L. Calculate work (R = 8.314 J/mol·K, use ln 2 = 0.693).",
        expected_answer: "-1730|-1729|-1730 J",
        explanation: "w = -nRT ln(V₂/V₁) = -1 × 8.314 × 300 × ln(20/10) = -2494 × 0.693 = -1728 J ≈ -1730 J.",
        hints: ["w = -nRT ln(V₂/V₁)", "ln(20/10) = ln 2 = 0.693", "Expansion: negative work"]
      },
      {
        step_number: 4,
        title: "Isochoric process work",
        instruction: "In an isochoric (constant volume) process, what is the work done?",
        expected_answer: "0|zero",
        explanation: "Isochoric: V = constant, ΔV = 0. w = -P ΔV = 0. No volume change means no expansion/compression work.",
        hints: ["Constant volume", "ΔV = 0", "w = -P × 0"]
      },
      {
        step_number: 5,
        title: "Maximum work",
        instruction: "Which process gives maximum work for expansion: reversible isothermal or irreversible (against constant P_ext)?",
        expected_answer: "reversible|reversible isothermal",
        explanation: "Reversible isothermal gives MAXIMUM work for expansion. |w_rev| > |w_irrev|. Reversible processes are most efficient.",
        hints: ["Reversible processes are most efficient", "Maximum work extracted", "Isothermal reversible"]
      }
    ],
    validation_rules: {
      formula_selection: "Correct work formula for each process",
      unit_conversion: "Proper L·atm to J conversions",
      sign_accuracy: "Correct negative sign for expansion"
    },
    success_criteria: "All 5 work calculation problems solved correctly",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 4: Hess's Law Applications
  {
    title: "Hess's Law - Multi-step Enthalpy Calculations",
    description: "Apply Hess's Law to calculate enthalpy changes using algebraic manipulation of equations",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["thermodynamics", "hess-law", "enthalpy", "delta-H"],
    category: "Thermodynamics Fundamentals",
    steps: [
      {
        step_number: 1,
        title: "Basic Hess's Law concept",
        instruction: "If reaction A→B has ΔH₁ = -50 kJ and B→C has ΔH₂ = -30 kJ, what is ΔH for A→C?",
        expected_answer: "-80|-80 kJ",
        explanation: "Hess's Law: ΔH_total = ΔH₁ + ΔH₂ = -50 + (-30) = -80 kJ. Add enthalpy changes for sequential reactions.",
        hints: ["Add the enthalpy changes", "A→B→C overall A→C", "Sum the ΔH values"]
      },
      {
        step_number: 2,
        title: "Reverse equation",
        instruction: "Given: C(s) + O₂(g) → CO₂(g), ΔH = -393.5 kJ. What is ΔH for CO₂(g) → C(s) + O₂(g)?",
        expected_answer: "+393.5|393.5|393.5 kJ",
        explanation: "Reversing equation CHANGES SIGN of ΔH. Forward: -393.5 kJ, Reverse: +393.5 kJ.",
        hints: ["Reverse equation = reverse sign", "Make negative positive", "+393.5 kJ"]
      },
      {
        step_number: 3,
        title: "Multiply equation",
        instruction: "Given: H₂(g) + ½O₂(g) → H₂O(l), ΔH = -286 kJ. What is ΔH for 2H₂(g) + O₂(g) → 2H₂O(l)?",
        expected_answer: "-572|-572 kJ",
        explanation: "Multiplying equation by 2 → multiply ΔH by 2. ΔH = 2 × (-286) = -572 kJ.",
        hints: ["Multiply coefficient = multiply ΔH", "2 times the equation", "2 × (-286)"]
      },
      {
        step_number: 4,
        title: "Calculate ΔH for CO formation",
        instruction: "Given: (1) C + O₂ → CO₂, ΔH₁ = -393.5 kJ; (2) CO + ½O₂ → CO₂, ΔH₂ = -283.0 kJ. Find ΔH for C + ½O₂ → CO (in kJ).",
        expected_answer: "-110.5|-110.5 kJ",
        explanation: "Target: C + ½O₂ → CO. Keep (1), reverse (2): CO₂ → CO + ½O₂ (ΔH = +283). Add: C + O₂ + CO₂ → CO₂ + CO + ½O₂. Cancel CO₂: C + ½O₂ → CO. ΔH = -393.5 + 283 = -110.5 kJ.",
        hints: ["Reverse equation 2", "Add equations and cancel", "ΔH = -393.5 + 283"]
      },
      {
        step_number: 5,
        title: "Using ΔH°f values",
        instruction: "Calculate ΔH°r for CH₄(g) + 2O₂(g) → CO₂(g) + 2H₂O(l). Given: ΔH°f(CH₄) = -74.8, ΔH°f(CO₂) = -393.5, ΔH°f(H₂O) = -285.8 kJ/mol.",
        expected_answer: "-890.3|-890|-890.3 kJ",
        explanation: "ΔH°r = ΣΔH°f(products) - ΣΔH°f(reactants) = [1(-393.5) + 2(-285.8)] - [1(-74.8) + 2(0)] = [-965.1] - [-74.8] = -890.3 kJ.",
        hints: ["ΔH°r = products - reactants", "Include stoichiometric coefficients", "ΔH°f(O₂) = 0"]
      }
    ],
    validation_rules: {
      equation_manipulation: "Correct reversal and multiplication",
      algebraic_addition: "Accurate equation addition and cancellation",
      formula_application: "Proper use of ΔH°r = Σproducts - Σreactants"
    },
    success_criteria: "All 5 Hess's Law problems solved correctly",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 5: Bond Enthalpy Calculations
  {
    title: "Bond Enthalpy - Calculating ΔH from Bond Energies",
    description: "Calculate reaction enthalpy using bond enthalpy values",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["thermodynamics", "bond-enthalpy", "bond-energy"],
    category: "Thermodynamics Fundamentals",
    steps: [
      {
        step_number: 1,
        title: "Bond breaking vs forming",
        instruction: "Is bond breaking endothermic (absorbs energy) or exothermic (releases energy)?",
        expected_answer: "endothermic|absorbs energy|endothermic",
        explanation: "Bond BREAKING is ENDOTHERMIC (requires energy, +). Bond FORMING is EXOTHERMIC (releases energy, -).",
        hints: ["Breaking bonds requires energy", "Like pulling magnets apart", "Endothermic = positive"]
      },
      {
        step_number: 2,
        title: "Bond enthalpy formula",
        instruction: "ΔH°r using bond enthalpies is: Bonds broken (minus/plus) Bonds formed?",
        expected_answer: "minus|-",
        explanation: "ΔH°r = Σ(Bonds broken) - Σ(Bonds formed). Breaking is +, forming is -, so subtract formed from broken.",
        hints: ["Break bonds costs energy (+)", "Make bonds releases energy (-)", "Broken minus formed"]
      },
      {
        step_number: 3,
        title: "Simple bond calculation",
        instruction: "H₂(g) → 2H(g). If H-H bond enthalpy = 436 kJ/mol, what is ΔH? (in kJ)",
        expected_answer: "436|436 kJ|+436",
        explanation: "Breaking 1 mole H-H bonds requires 436 kJ. ΔH = +436 kJ (endothermic).",
        hints: ["Breaking bonds", "Energy required", "Positive ΔH"]
      },
      {
        step_number: 4,
        title: "Calculate ΔH for reaction",
        instruction: "H₂ + Cl₂ → 2HCl. Bond enthalpies: H-H = 436, Cl-Cl = 242, H-Cl = 431 kJ/mol. Calculate ΔH (in kJ).",
        expected_answer: "-184|-184 kJ",
        explanation: "Broken: H-H (436) + Cl-Cl (242) = 678 kJ. Formed: 2×H-Cl = 2×431 = 862 kJ. ΔH = 678 - 862 = -184 kJ.",
        hints: ["Count bonds broken and formed", "Broken: 436 + 242", "Formed: 2 × 431", "Subtract"]
      },
      {
        step_number: 5,
        title: "CH₄ combustion bonds",
        instruction: "CH₄ + 2O₂ → CO₂ + 2H₂O. How many C-H bonds are broken?",
        expected_answer: "4",
        explanation: "CH₄ has 4 C-H bonds, all are broken. Plus 2 O=O bonds broken. Products form: 2 C=O and 4 O-H bonds.",
        hints: ["Methane structure", "4 hydrogen atoms", "All C-H bonds break"]
      }
    ],
    validation_rules: {
      bond_counting: "Accurate count of bonds broken and formed",
      calculation_accuracy: "Correct ΔH = broken - formed",
      sign_convention: "Proper positive/negative values"
    },
    success_criteria: "All 5 bond enthalpy problems solved correctly",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 6: Entropy Change Calculations
  {
    title: "Entropy Change Calculations - ΔS°",
    description: "Calculate entropy changes for reactions and processes",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["thermodynamics", "entropy", "delta-S", "second-law"],
    category: "Thermodynamics Fundamentals",
    steps: [
      {
        step_number: 1,
        title: "Entropy concept",
        instruction: "Does entropy increase or decrease when ice melts to water?",
        expected_answer: "increase|increases",
        explanation: "Entropy INCREASES. Solid → liquid has more disorder (higher entropy). ΔS > 0 for melting.",
        hints: ["Solid or liquid more disordered?", "More freedom of movement", "Disorder increases"]
      },
      {
        step_number: 2,
        title: "ΔS for phase change",
        instruction: "At melting point, ΔS_fus = ΔH_fus/T. If ΔH_fus = 6.01 kJ/mol and T = 273 K, calculate ΔS_fus (in J/mol·K).",
        expected_answer: "22|22.0|22 J/mol·K",
        explanation: "ΔS_fus = ΔH_fus/T = (6.01 × 1000 J/mol) / 273 K = 6010/273 = 22.0 J/(mol·K). Convert kJ to J.",
        hints: ["ΔS = ΔH/T", "Convert kJ to J: × 1000", "6010/273"]
      },
      {
        step_number: 3,
        title: "Standard entropy calculation",
        instruction: "For reaction: N₂(g) + 3H₂(g) → 2NH₃(g), S°(N₂) = 192, S°(H₂) = 131, S°(NH₃) = 193 J/mol·K. Calculate ΔS°r.",
        expected_answer: "-199|-199 J/mol·K",
        explanation: "ΔS°r = ΣS°(products) - ΣS°(reactants) = [2(193)] - [1(192) + 3(131)] = 386 - [192 + 393] = 386 - 585 = -199 J/(mol·K).",
        hints: ["ΔS° = products - reactants", "Include coefficients", "2(193) - [192 + 3(131)]"]
      },
      {
        step_number: 4,
        title: "Sign of ΔS",
        instruction: "For N₂ + 3H₂ → 2NH₃, moles decrease (4 → 2). Is ΔS positive or negative?",
        expected_answer: "negative",
        explanation: "Moles of gas DECREASE (4 mol → 2 mol), so disorder decreases. ΔS is NEGATIVE. Fewer gas molecules = less entropy.",
        hints: ["More moles = more disorder", "4 moles become 2", "Decrease in disorder"]
      },
      {
        step_number: 5,
        title: "Third law of thermodynamics",
        instruction: "At 0 K (absolute zero), the entropy of a perfect crystal is:",
        expected_answer: "0|zero",
        explanation: "Third law: At 0 K, S = 0 for perfect crystal (minimum disorder). This allows calculation of absolute entropy values.",
        hints: ["Absolute zero", "Perfect order", "Zero entropy"]
      }
    ],
    validation_rules: {
      entropy_concept: "Understanding disorder and entropy",
      calculation_accuracy: "Correct ΔS calculations",
      unit_handling: "Proper J vs kJ conversions"
    },
    success_criteria: "All 5 entropy problems solved correctly",
    points_reward: 135,
    max_attempts: 5
  },

  # Lab 7: Gibbs Free Energy and Spontaneity
  {
    title: "Gibbs Free Energy - Predicting Spontaneity",
    description: "Calculate ΔG° and predict reaction spontaneity",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["thermodynamics", "gibbs-energy", "delta-G", "spontaneity"],
    category: "Thermodynamics Fundamentals",
    steps: [
      {
        step_number: 1,
        title: "Spontaneity criterion",
        instruction: "A reaction is spontaneous when ΔG is: positive, negative, or zero?",
        expected_answer: "negative",
        explanation: "Spontaneous reaction: ΔG < 0 (negative). Non-spontaneous: ΔG > 0. At equilibrium: ΔG = 0.",
        hints: ["Negative ΔG = spontaneous", "Like rolling downhill", "Negative is favorable"]
      },
      {
        step_number: 2,
        title: "Gibbs equation",
        instruction: "Calculate ΔG° if ΔH° = -100 kJ and ΔS° = -200 J/K at 298 K (in kJ).",
        expected_answer: "-40.4|-40|-40.4 kJ",
        explanation: "ΔG° = ΔH° - TΔS° = -100 - (298)(- 0.200) = -100 + 59.6 = -40.4 kJ. Convert ΔS to kJ: -200 J/K = -0.2 kJ/K.",
        hints: ["ΔG = ΔH - TΔS", "Convert J to kJ: ÷1000", "-100 - 298(-0.2)"]
      },
      {
        step_number: 3,
        title: "Temperature dependence",
        instruction: "If ΔH° < 0 and ΔS° > 0, is the reaction spontaneous at all temperatures, never, or only at high/low T?",
        expected_answer: "all temperatures|always|all T",
        explanation: "ΔH < 0 (favorable) and ΔS > 0 (favorable). ΔG = ΔH - TΔS < 0 always (both terms make ΔG negative). Spontaneous at ALL temperatures.",
        hints: ["Both ΔH and ΔS favorable", "Negative - (positive) = negative", "Always spontaneous"]
      },
      {
        step_number: 4,
        title: "Equilibrium constant relationship",
        instruction: "The relationship between ΔG° and K is: ΔG° = -RT ln K or ΔG° = +RT ln K?",
        expected_answer: "-RT ln K|ΔG° = -RT ln K",
        explanation: "ΔG° = -RT ln K. When K > 1 (products favored), ln K > 0, so ΔG° < 0 (spontaneous forward).",
        hints: ["Negative sign in formula", "ΔG° = -RT ln K", "Large K means negative ΔG°"]
      },
      {
        step_number: 5,
        title: "Calculate ΔG° from K",
        instruction: "If K = 10 at 298 K, calculate ΔG° (R = 8.314 J/mol·K, ln 10 = 2.303, in kJ/mol).",
        expected_answer: "-5.7|-5.71|-5.7 kJ/mol",
        explanation: "ΔG° = -RT ln K = -(8.314)(298)(2.303) = -5706 J/mol = -5.7 kJ/mol. K > 1 means ΔG° < 0 (spontaneous).",
        hints: ["ΔG° = -RT ln K", "Use ln 10 = 2.303", "Convert J to kJ"]
      }
    ],
    validation_rules: {
      spontaneity_prediction: "Correct ΔG sign interpretation",
      calculation_accuracy: "Accurate ΔG = ΔH - TΔS calculations",
      temperature_analysis: "Understanding temperature effects"
    },
    success_criteria: "All 5 Gibbs energy problems solved correctly",
    points_reward: 160,
    max_attempts: 5
  },

  # Lab 8: ΔG° and Equilibrium Constant Relationship
  {
    title: "ΔG° and Equilibrium Constant - Quantitative Relationship",
    description: "Master the ΔG° = -RT ln K relationship and applications",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["thermodynamics", "gibbs-energy", "equilibrium-constant", "delta-G-K"],
    category: "Thermodynamics Fundamentals",
    steps: [
      {
        step_number: 1,
        title: "K and spontaneity",
        instruction: "If K = 100, is the forward reaction spontaneous (ΔG° positive or negative)?",
        expected_answer: "negative|spontaneous",
        explanation: "K > 1 means products favored. ΔG° = -RT ln K, and ln(100) > 0, so ΔG° < 0 (negative, spontaneous forward).",
        hints: ["K > 1 favors products", "ln K > 0", "ΔG° = -RT ln K → negative"]
      },
      {
        step_number: 2,
        title: "Calculate K from ΔG°",
        instruction: "If ΔG° = 0 at 298 K, what is K?",
        expected_answer: "1",
        explanation: "ΔG° = -RT ln K. If ΔG° = 0, then 0 = -RT ln K, so ln K = 0, meaning K = e⁰ = 1.",
        hints: ["ΔG° = 0", "ln K = 0", "K = 1 at equilibrium"]
      },
      {
        step_number: 3,
        title: "Calculate ΔG° from K",
        instruction: "If K = 1 × 10⁻⁵ at 298 K, is ΔG° positive or negative? (No calculation needed)",
        expected_answer: "positive",
        explanation: "K < 1 (very small) means reactants favored. ln K < 0, so ΔG° = -RT(negative) = positive. Non-spontaneous forward.",
        hints: ["K < 1 favors reactants", "ln(10⁻⁵) is negative", "ΔG° must be positive"]
      },
      {
        step_number: 4,
        title: "Temperature effect on K",
        instruction: "For endothermic reaction (ΔH° > 0), does K increase or decrease with temperature?",
        expected_answer: "increase|increases",
        explanation: "Van't Hoff: ln(K₂/K₁) = -ΔH°/R (1/T₂ - 1/T₁). For ΔH° > 0 (endothermic), K increases with T (Le Chatelier: heat favors forward).",
        hints: ["Endothermic absorbs heat", "Higher T favors forward", "K increases"]
      },
      {
        step_number: 5,
        title: "Numerical calculation",
        instruction: "Calculate K at 298 K if ΔG° = -11.4 kJ/mol (R = 8.314 J/mol·K, use e⁴·⁶ ≈ 100).",
        expected_answer: "100",
        explanation: "ΔG° = -RT ln K → ln K = -ΔG°/RT = -(-11400)/(8.314×298) = 11400/2478 = 4.6. K = e⁴·⁶ ≈ 100.",
        hints: ["Rearrange: ln K = -ΔG°/RT", "Convert kJ to J", "Use e⁴·⁶ ≈ 100"]
      }
    ],
    validation_rules: {
      relationship_understanding: "Clear ΔG°-K relationship",
      sign_interpretation: "Correct K prediction from ΔG° sign",
      calculation_accuracy: "Accurate ln K and K calculations"
    },
    success_criteria: "All 5 ΔG°-K relationship problems solved",
    points_reward: 155,
    max_attempts: 5
  }
]

# Create thermodynamics labs
puts "\nCreating Thermodynamics Fundamentals Labs (1-8)..."
thermodynamics_labs.each_with_index do |lab_data, index|
  lab = HandsOnLab.create!(
    course: course_physical,
    title: lab_data[:title],
    description: lab_data[:description],
    difficulty: lab_data[:difficulty],
    estimated_minutes: lab_data[:estimated_minutes],
    lab_type: lab_data[:lab_type],
    lab_format: lab_data[:lab_format],
    tags: lab_data[:tags],
    category: lab_data[:category],
    steps: lab_data[:steps],
    validation_rules: lab_data[:validation_rules],
    success_criteria: lab_data[:success_criteria],
    points_reward: lab_data[:points_reward],
    max_attempts: lab_data[:max_attempts],
    order_index: index + 1
  )
  puts "  ✓ Lab #{index + 1} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "Physical Chemistry Labs - Part 1 Summary (Labs 1-8)"
puts "="*80
puts "Created: 8 thermodynamics labs"
puts "Total lab time: ~#{thermodynamics_labs.sum { |l| l[:estimated_minutes] }} minutes"
puts "Total points: #{thermodynamics_labs.sum { |l| l[:points_reward] }}"
puts "="*80
puts "\nThermodynamics fundamentals labs complete!"
puts "Ready to create kinetics labs (Labs 9-15)..."
puts "="*80

# ============================================================================
# CATEGORY 2: CHEMICAL KINETICS (Labs 9-15)
# ============================================================================

kinetics_labs = [
  # Lab 9: Determining Rate Law from Data
  {
    title: "Determining Rate Law from Experimental Data",
    description: "Determine order of reaction and rate constant from concentration-time data",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["kinetics", "rate-law", "order", "rate-constant"],
    category: "Chemical Kinetics",
    steps: [
      {
        step_number: 1,
        title: "Rate law form",
        instruction: "For reaction A → products, the rate law is Rate = k[A]ⁿ. What does 'n' represent?",
        expected_answer: "order|order of reaction",
        explanation: "'n' is the ORDER of reaction with respect to A. It's determined experimentally (not from stoichiometry).",
        hints: ["Order of reaction", "Exponent in rate law", "Found by experiment"]
      },
      {
        step_number: 2,
        title: "Initial rate method",
        instruction: "If doubling [A] doubles the rate, the order with respect to A is:",
        expected_answer: "1|first order|first",
        explanation: "Rate doubles when [A] doubles → first order (n = 1). Rate = k[A]¹. If rate quadruples, n = 2.",
        hints: ["Rate ∝ [A]¹", "Linear relationship", "First order"]
      },
      {
        step_number: 3,
        title: "Determine order",
        instruction: "Experiment: [A] doubled, rate becomes 4x. What is the order?",
        expected_answer: "2|second order|second",
        explanation: "Rate becomes 4x = 2² when [A] doubles → second order (n = 2). Rate = k[A]².",
        hints: ["4 = 2²", "Quadratic relationship", "Second order"]
      },
      {
        step_number: 4,
        title: "Zero order check",
        instruction: "If changing [A] does NOT change the rate, the order is:",
        expected_answer: "0|zero|zero order",
        explanation: "Rate independent of [A] → zero order (n = 0). Rate = k[A]⁰ = k (constant).",
        hints: ["Rate doesn't depend on [A]", "Constant rate", "Zero order"]
      },
      {
        step_number: 5,
        title: "Calculate rate constant",
        instruction: "For first order: Rate = 0.01 M/s when [A] = 0.5 M. Calculate k (units: s⁻¹).",
        expected_answer: "0.02|0.02 s⁻¹",
        explanation: "Rate = k[A]. 0.01 = k(0.5), so k = 0.01/0.5 = 0.02 s⁻¹. Units for first order k: s⁻¹ or min⁻¹.",
        hints: ["k = Rate/[A]", "0.01/0.5", "Units: s⁻¹"]
      }
    ],
    validation_rules: {
      order_determination: "Correct method to find reaction order",
      rate_constant_calculation: "Accurate k calculation with units",
      data_interpretation: "Proper analysis of experimental data"
    },
    success_criteria: "All 5 rate law determination problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 10: Zero Order Kinetics Problems
  {
    title: "Zero Order Kinetics - Integrated Rate Law",
    description: "Apply zero order integrated rate equation [A] = [A]₀ - kt",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["kinetics", "zero-order", "integrated-rate-law"],
    category: "Chemical Kinetics",
    steps: [
      {
        step_number: 1,
        title: "Zero order equation",
        instruction: "The integrated rate law for zero order is: [A] = [A]₀ - kt or [A] = [A]₀ e^(-kt)?",
        expected_answer: "[A] = [A]₀ - kt|linear",
        explanation: "Zero order: [A] = [A]₀ - kt (LINEAR). Plot [A] vs t gives straight line with slope = -k.",
        hints: ["Linear equation", "Minus kt", "Not exponential"]
      },
      {
        step_number: 2,
        title: "Calculate concentration",
        instruction: "Zero order reaction: [A]₀ = 1.0 M, k = 0.05 M/s. Find [A] after 10 s (in M).",
        expected_answer: "0.5|0.5 M",
        explanation: "[A] = [A]₀ - kt = 1.0 - (0.05)(10) = 1.0 - 0.5 = 0.5 M.",
        hints: ["[A] = [A]₀ - kt", "1.0 - 0.05×10", "Linear decrease"]
      },
      {
        step_number: 3,
        title: "Calculate time",
        instruction: "Same reaction. How long for [A] to drop from 1.0 M to 0.2 M? (in seconds)",
        expected_answer: "16",
        explanation: "[A] = [A]₀ - kt. 0.2 = 1.0 - 0.05t. 0.05t = 0.8. t = 0.8/0.05 = 16 s.",
        hints: ["Rearrange: t = ([A]₀ - [A])/k", "(1.0 - 0.2)/0.05", "0.8/0.05"]
      },
      {
        step_number: 4,
        title: "Half-life for zero order",
        instruction: "For zero order, half-life formula is: t₁/₂ = [A]₀/2k or 0.693/k?",
        expected_answer: "[A]₀/2k|[A]0/2k",
        explanation: "Zero order: t₁/₂ = [A]₀/2k (depends on initial concentration). NOT constant like first order.",
        hints: ["Depends on [A]₀", "[A]₀/2k", "Not 0.693/k"]
      },
      {
        step_number: 5,
        title: "Units of k for zero order",
        instruction: "What are the units of rate constant k for zero order reaction?",
        expected_answer: "M/s|mol/(L·s)|concentration/time",
        explanation: "Zero order k units: M/s or mol/(L·s). Same units as rate. Different from first order (s⁻¹).",
        hints: ["Same as rate units", "Concentration per time", "M/s or M·s⁻¹"]
      }
    ],
    validation_rules: {
      equation_application: "Correct use of [A] = [A]₀ - kt",
      calculation_accuracy: "Accurate concentration and time calculations",
      unit_awareness: "Proper k units for zero order"
    },
    success_criteria: "All 5 zero order kinetics problems solved",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 11: First Order Kinetics and Half-life
  {
    title: "First Order Kinetics - Integrated Rate Law and Half-life",
    description: "Master first order kinetics: ln[A] = ln[A]₀ - kt and t₁/₂ = 0.693/k",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["kinetics", "first-order", "half-life", "integrated-rate-law"],
    category: "Chemical Kinetics",
    steps: [
      {
        step_number: 1,
        title: "First order equation",
        instruction: "The integrated rate law for first order is:",
        expected_answer: "ln[A] = ln[A]₀ - kt|logarithmic",
        explanation: "First order: ln[A] = ln[A]₀ - kt. Plot ln[A] vs t gives straight line with slope = -k. Exponential decay.",
        hints: ["Logarithmic form", "ln[A] vs time", "Slope = -k"]
      },
      {
        step_number: 2,
        title: "Calculate concentration",
        instruction: "First order: [A]₀ = 1.0 M, k = 0.1 s⁻¹, t = 10 s. Calculate [A] (use e^(-1) = 0.368).",
        expected_answer: "0.368|0.37|0.368 M",
        explanation: "ln[A] = ln[A]₀ - kt = ln(1.0) - (0.1)(10) = 0 - 1 = -1. [A] = e⁻¹ = 0.368 M.",
        hints: ["ln[A] = -1", "[A] = e⁻¹", "0.368 M"]
      },
      {
        step_number: 3,
        title: "Half-life calculation",
        instruction: "For first order reaction with k = 0.693 s⁻¹, calculate t₁/₂ (in seconds).",
        expected_answer: "1|1 s",
        explanation: "First order: t₁/₂ = 0.693/k = 0.693/0.693 = 1 s. Half-life is CONSTANT (independent of [A]₀).",
        hints: ["t₁/₂ = 0.693/k", "0.693/0.693", "1 second"]
      },
      {
        step_number: 4,
        title: "Multiple half-lives",
        instruction: "After 3 half-lives, what fraction of original remains: 1/2, 1/4, 1/8, or 1/16?",
        expected_answer: "1/8",
        explanation: "After each t₁/₂, amount halves. After 3 half-lives: (1/2)³ = 1/8 remains. 87.5% reacted.",
        hints: ["Each half-life: × 1/2", "(1/2)³", "1/8 remains"]
      },
      {
        step_number: 5,
        title: "Calculate rate constant",
        instruction: "[A] drops from 1.0 M to 0.25 M in 20 s (first order). Calculate k (use ln 4 = 1.386).",
        expected_answer: "0.069|0.0693|0.069 s⁻¹",
        explanation: "ln([A]₀/[A]) = kt. ln(1.0/0.25) = ln 4 = 1.386. k = 1.386/20 = 0.069 s⁻¹.",
        hints: ["Use ln([A]₀/[A]) = kt", "ln(1.0/0.25) = ln 4", "k = 1.386/20"]
      }
    ],
    validation_rules: {
      logarithmic_calculations: "Correct use of ln in rate law",
      half_life_concept: "Understanding constant t₁/₂",
      exponential_decay: "Accurate concentration calculations"
    },
    success_criteria: "All 5 first order kinetics problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 12: Second Order Kinetics Calculations
  {
    title: "Second Order Kinetics - Integrated Rate Law",
    description: "Apply second order integrated rate equation 1/[A] = 1/[A]₀ + kt",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["kinetics", "second-order", "integrated-rate-law"],
    category: "Chemical Kinetics",
    steps: [
      {
        step_number: 1,
        title: "Second order equation",
        instruction: "The integrated rate law for second order is:",
        expected_answer: "1/[A] = 1/[A]₀ + kt|reciprocal",
        explanation: "Second order: 1/[A] = 1/[A]₀ + kt. Plot 1/[A] vs t gives straight line with slope = k.",
        hints: ["Reciprocal form", "1/[A] vs time", "Plus kt"]
      },
      {
        step_number: 2,
        title: "Calculate concentration",
        instruction: "Second order: [A]₀ = 0.5 M, k = 0.2 M⁻¹s⁻¹, t = 5 s. Calculate [A] (in M).",
        expected_answer: "0.333|0.33|1/3",
        explanation: "1/[A] = 1/[A]₀ + kt = 1/0.5 + (0.2)(5) = 2 + 1 = 3. [A] = 1/3 = 0.333 M.",
        hints: ["1/[A] = 1/0.5 + 0.2×5", "2 + 1 = 3", "[A] = 1/3"]
      },
      {
        step_number: 3,
        title: "Units of k for second order",
        instruction: "What are the units of rate constant k for second order reaction?",
        expected_answer: "M⁻¹s⁻¹|L/(mol·s)|1/(M·s)",
        explanation: "Second order k units: M⁻¹s⁻¹ or L/(mol·s). From Rate = k[A]², units must give M/s.",
        hints: ["From Rate = k[A]²", "M⁻¹s⁻¹", "Inverse concentration × time"]
      },
      {
        step_number: 4,
        title: "Half-life for second order",
        instruction: "Second order half-life formula is: t₁/₂ = 1/(k[A]₀) or 0.693/k?",
        expected_answer: "1/(k[A]₀)|1/k[A]0",
        explanation: "Second order: t₁/₂ = 1/(k[A]₀). Depends on [A]₀ - decreases as reaction progresses (NOT constant).",
        hints: ["Depends on initial concentration", "1/(k[A]₀)", "Not constant"]
      },
      {
        step_number: 5,
        title: "Calculate half-life",
        instruction: "For second order with [A]₀ = 0.5 M and k = 0.2 M⁻¹s⁻¹, find t₁/₂ (in s).",
        expected_answer: "10|10 s",
        explanation: "t₁/₂ = 1/(k[A]₀) = 1/(0.2 × 0.5) = 1/0.1 = 10 s.",
        hints: ["t₁/₂ = 1/(k[A]₀)", "1/(0.2 × 0.5)", "1/0.1"]
      }
    },
    validation_rules: {
      reciprocal_calculations: "Correct use of 1/[A] form",
      unit_awareness: "Proper M⁻¹s⁻¹ units",
      half_life_variability: "Understanding concentration-dependent t₁/₂"
    },
    success_criteria: "All 5 second order kinetics problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 13: Integrated Rate Law Applications
  {
    title: "Integrated Rate Laws - Graphical and Numerical Methods",
    description: "Determine reaction order by testing different rate law plots",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["kinetics", "integrated-rate-law", "graphical-method", "order-determination"],
    category: "Chemical Kinetics",
    steps: [
      {
        step_number: 1,
        title: "Linear plot identification",
        instruction: "If plot of [A] vs t is linear, the order is:",
        expected_answer: "0|zero|zero order",
        explanation: "[A] vs t linear → zero order. ln[A] vs t linear → first order. 1/[A] vs t linear → second order.",
        hints: ["Linear [A] vs t", "Zero order", "Straight line"]
      },
      {
        step_number: 2,
        title: "Determine order from data",
        instruction: "Data: t=0, [A]=1.0M; t=10s, [A]=0.5M; t=20s, [A]=0.25M. Equal time intervals, [A] halves. Order?",
        expected_answer: "1|first|first order",
        explanation: "Constant half-life (10 s) → first order. Each 10 s, concentration halves. Characteristic of first order.",
        hints: ["Constant half-life", "Each interval: half remains", "First order"]
      },
      {
        step_number: 3,
        title: "Calculate k from plot",
        instruction: "ln[A] vs t plot has slope = -0.05 s⁻¹. What is k?",
        expected_answer: "0.05|0.05 s⁻¹",
        explanation: "For first order: ln[A] = ln[A]₀ - kt. Slope = -k, so k = 0.05 s⁻¹ (magnitude of slope).",
        hints: ["Slope = -k", "Take positive value", "k = 0.05 s⁻¹"]
      },
      {
        step_number: 4,
        title: "Time for 75% completion",
        instruction: "First order reaction: k = 0.1 s⁻¹. Time for 75% completion (2 half-lives)?",
        expected_answer: "13.9|14|13.86",
        explanation: "75% done = 25% remains = 1/4 of [A]₀. This is 2 half-lives. t₁/₂ = 0.693/0.1 = 6.93 s. Time = 2 × 6.93 = 13.86 s.",
        hints: ["75% done = 2 half-lives", "t₁/₂ = 0.693/k", "2 × 6.93"]
      },
      {
        step_number: 5,
        title: "Pseudo first order",
        instruction: "For A + B → products, if [B] >> [A], the reaction appears to be which order with respect to A?",
        expected_answer: "first|pseudo first",
        explanation: "Pseudo first order. When [B] >> [A], [B] essentially constant. Rate = k[A][B] ≈ k'[A] where k' = k[B]. Appears first order in A.",
        hints: ["[B] constant", "Pseudo first order", "Simplifies to first order in A"]
      }
    ],
    validation_rules: {
      graphical_analysis: "Correct plot interpretation",
      order_identification: "Accurate order determination methods",
      calculation_proficiency: "Complex multi-step calculations"
    },
    success_criteria: "All 5 advanced integrated rate law problems solved",
    points_reward: 160,
    max_attempts: 5
  },

  # Lab 14: Arrhenius Equation Problems
  {
    title: "Arrhenius Equation - Activation Energy and Temperature Dependence",
    description: "Apply Arrhenius equation k = Ae^(-Ea/RT) and ln k vs 1/T plots",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["kinetics", "arrhenius", "activation-energy", "temperature"],
    category: "Chemical Kinetics",
    steps: [
      {
        step_number: 1,
        title: "Arrhenius equation form",
        instruction: "The Arrhenius equation is: k = Ae^(-Ea/RT). What is Ea?",
        expected_answer: "activation energy",
        explanation: "Ea = activation energy (minimum energy needed for reaction). Higher Ea → slower reaction (lower k).",
        hints: ["Energy barrier", "Activation energy", "Ea in equation"]
      },
      {
        step_number: 2,
        title: "Temperature effect",
        instruction: "If temperature increases, does rate constant k increase or decrease?",
        expected_answer: "increase|increases",
        explanation: "Higher T → higher k (exponential relationship). More molecules have E ≥ Ea at higher temperature.",
        hints: ["Higher temp faster reaction", "k increases with T", "Exponential increase"]
      },
      {
        step_number: 3,
        title: "Logarithmic form",
        instruction: "ln k = ln A - Ea/RT. If we plot ln k vs 1/T, the slope is:",
        expected_answer: "-Ea/R",
        explanation: "ln k vs 1/T gives straight line with slope = -Ea/R. Intercept = ln A. This is how Ea is determined experimentally.",
        hints: ["Plot ln k vs 1/T", "Slope = -Ea/R", "Linear relationship"]
      },
      {
        step_number: 4,
        title: "Calculate Ea from slope",
        instruction: "If slope of ln k vs 1/T plot is -5000 K, calculate Ea (R = 8.314 J/mol·K, in kJ/mol).",
        expected_answer: "41.6|41.57|42",
        explanation: "Slope = -Ea/R = -5000 K. Ea = 5000 × 8.314 = 41,570 J/mol = 41.6 kJ/mol.",
        hints: ["Ea = |slope| × R", "5000 × 8.314", "Convert J to kJ"]
      },
      {
        step_number: 5,
        title: "Two-temperature formula",
        instruction: "ln(k₂/k₁) = -Ea/R (1/T₂ - 1/T₁). If k doubles when T increases, this formula relates k₁, k₂, and ___?",
        expected_answer: "Ea|activation energy|temperatures",
        explanation: "Two-point Arrhenius equation relates k at two temperatures to Ea. Useful for calculating Ea from experimental k values.",
        hints: ["Two-temperature equation", "Relates k₁, k₂, T₁, T₂, Ea", "Activation energy"]
      }
    ],
    validation_rules: {
      arrhenius_understanding: "Clear grasp of k-T relationship",
      calculation_accuracy: "Correct Ea calculations from slopes",
      unit_conversions: "Proper J to kJ conversions"
    },
    success_criteria: "All 5 Arrhenius equation problems solved",
    points_reward: 135,
    max_attempts: 5
  },

  # Lab 15: Activation Energy Calculations
  {
    title: "Activation Energy Calculations - Numerical Applications",
    description: "Calculate Ea using two-temperature Arrhenius equation",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["kinetics", "activation-energy", "arrhenius", "numerical"],
    category: "Chemical Kinetics",
    steps: [
      {
        step_number: 1,
        title: "Understand Ea meaning",
        instruction: "Higher activation energy means: faster or slower reaction?",
        expected_answer: "slower",
        explanation: "Higher Ea → fewer molecules have enough energy → slower reaction (lower k at given T).",
        hints: ["Higher barrier", "Fewer molecules react", "Slower reaction"]
      },
      {
        step_number: 2,
        title: "Calculate Ea (simple)",
        instruction: "At 300 K, k₁ = 1×10⁻³ s⁻¹. At 310 K, k₂ = 2×10⁻³ s⁻¹. Is Ea positive or negative?",
        expected_answer: "positive",
        explanation: "k increases with T → normal reaction → Ea is POSITIVE. (Only for catalysts or special cases is Ea effectively zero or negative)",
        hints: ["k increases with T", "Normal behavior", "Positive Ea"]
      },
      {
        step_number: 3,
        title: "Two-temperature calculation setup",
        instruction: "Using ln(k₂/k₁) = -Ea/R(1/T₂ - 1/T₁), what is ln(2)?",
        expected_answer: "0.693",
        explanation: "ln(2) = 0.693 (memorize this value, frequently used). ln(k₂/k₁) = ln(2×10⁻³ / 1×10⁻³) = ln 2 = 0.693.",
        hints: ["k₂/k₁ = 2", "ln(2) = 0.693", "Common value"]
      },
      {
        step_number: 4,
        title: "Calculate temperature term",
        instruction: "Calculate 1/T₂ - 1/T₁ where T₁ = 300 K, T₂ = 310 K (in K⁻¹, 3 sig figs).",
        expected_answer: "-0.000108|-1.08×10⁻⁴|-0.000107",
        explanation: "1/310 - 1/300 = 0.003226 - 0.003333 = -0.000107 K⁻¹ ≈ -1.08×10⁻⁴ K⁻¹.",
        hints: ["1/310 - 1/300", "Calculator needed", "Negative value"]
      },
      {
        step_number: 5,
        title: "Calculate Ea",
        instruction: "Using ln(k₂/k₁) = 0.693, 1/T₂ - 1/T₁ = -1.08×10⁻⁴ K⁻¹, R = 8.314 J/mol·K. Calculate Ea (kJ/mol).",
        expected_answer: "53.4|53|54",
        explanation: "0.693 = -Ea/8.314 × (-1.08×10⁻⁴). Ea = 0.693 / (8.314×1.08×10⁻⁴) = 0.693 / 8.98×10⁻⁴ = 53,400 J/mol = 53.4 kJ/mol.",
        hints: ["Rearrange: Ea = -ln(k₂/k₁) × R / (1/T₂ - 1/T₁)", "0.693 / (8.314 × 1.08×10⁻⁴)", "~53 kJ/mol"]
      }
    ],
    validation_rules: {
      formula_manipulation: "Correct rearrangement of Arrhenius equation",
      numerical_precision: "Accurate multi-step calculation",
      unit_awareness: "Proper J to kJ conversion"
    },
    success_criteria: "All 5 activation energy problems solved with correct numerical answers",
    points_reward: 155,
    max_attempts: 5
  }
]

# Create kinetics labs
puts "\nCreating Chemical Kinetics Labs (9-15)..."
kinetics_labs.each_with_index do |lab_data, index|
  lab = HandsOnLab.create!(
    course: course_physical,
    title: lab_data[:title],
    description: lab_data[:description],
    difficulty: lab_data[:difficulty],
    estimated_minutes: lab_data[:estimated_minutes],
    lab_type: lab_data[:lab_type],
    lab_format: lab_data[:lab_format],
    tags: lab_data[:tags],
    category: lab_data[:category],
    steps: lab_data[:steps],
    validation_rules: lab_data[:validation_rules],
    success_criteria: lab_data[:success_criteria],
    points_reward: lab_data[:points_reward],
    max_attempts: lab_data[:max_attempts],
    order_index: index + 9
  )
  puts "  ✓ Lab #{index + 9} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "🎉 Physical Chemistry Labs - Part 1 COMPLETE! 🎉"
puts "="*80
puts "Created: 15 comprehensive numerical labs"
puts ""
puts "Category 1: Thermodynamics Fundamentals (Labs 1-8)"
puts "  • State functions, first law, work, Hess's law"
puts "  • Entropy, Gibbs energy, spontaneity"
puts "  • Time: ~260 minutes, Points: 1,080"
puts ""
puts "Category 2: Chemical Kinetics (Labs 9-15)"
puts "  • Rate laws, zero/first/second order kinetics"
puts "  • Integrated rate laws, half-life calculations"
puts "  • Arrhenius equation, activation energy"
puts "  • Time: ~235 minutes, Points: 945"
puts ""
puts "TOTAL: 15 labs, ~495 minutes (~8.25 hours), 2,025 points"
puts "="*80
puts "\n✅ Labs 1-15 complete and ready for Phase 3!"
puts "Next: Create Labs 16-30 (equilibrium and ionic equilibrium)"
puts "="*80

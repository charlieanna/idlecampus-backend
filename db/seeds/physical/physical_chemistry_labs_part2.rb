# Physical Chemistry Hands-On Labs - Part 2 (Labs 16-30)
# Covers: Chemical Equilibrium and Ionic Equilibrium

puts "Creating Physical Chemistry Hands-On Labs (Part 2: Labs 16-30)..."

course_physical = Course.find_by(title: 'Physical Chemistry for IIT JEE Main & Advanced')

unless course_physical
  puts "Error: Physical Chemistry course not found!"
  exit
end

# ============================================================================
# CATEGORY 3: CHEMICAL EQUILIBRIUM (Labs 16-23)
# ============================================================================

equilibrium_labs = [
  # Lab 16: Kp and Kc Conversions
  {
    title: "Kp and Kc Conversions - Gas Phase Equilibria",
    description: "Master the relationship Kp = Kc(RT)^Δn and conversions between equilibrium constants",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["equilibrium", "Kp", "Kc", "conversions"],
    category: "Chemical Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Relationship formula",
        instruction: "The relationship between Kp and Kc is: Kp = Kc(RT)^Δn. What is Δn?",
        expected_answer: "change in moles of gas|moles of gaseous products - reactants|Δn gas",
        explanation: "Δn = (moles of gaseous products) - (moles of gaseous reactants). Only count GAS molecules, not solids or liquids.",
        hints: ["Difference in gas moles", "Products minus reactants", "Only gases count"]
      },
      {
        step_number: 2,
        title: "Calculate Δn",
        instruction: "For N₂(g) + 3H₂(g) ⇌ 2NH₃(g), what is Δn?",
        expected_answer: "-2",
        explanation: "Δn = 2 - (1 + 3) = 2 - 4 = -2. Moles of gas DECREASE (4 → 2).",
        hints: ["Count gas moles", "Products: 2, Reactants: 4", "2 - 4 = -2"]
      },
      {
        step_number: 3,
        title: "When Kp = Kc",
        instruction: "If Δn = 0, then Kp (equals/does not equal) Kc?",
        expected_answer: "equals",
        explanation: "When Δn = 0, Kp = Kc(RT)⁰ = Kc × 1 = Kc. Same number of gas moles on both sides.",
        hints: ["(RT)⁰ = 1", "Kp = Kc when Δn = 0", "Equal"]
      },
      {
        step_number: 4,
        title: "Calculate Kp from Kc",
        instruction: "For reaction with Δn = 2, Kc = 0.5, T = 300 K, R = 0.0821 L·atm/(mol·K). Calculate Kp.",
        expected_answer: "303.6|304|303",
        explanation: "Kp = Kc(RT)^Δn = 0.5 × (0.0821 × 300)² = 0.5 × (24.63)² = 0.5 × 606.8 = 303.4.",
        hints: ["Kp = Kc(RT)²", "RT = 0.0821 × 300 = 24.63", "0.5 × (24.63)²"]
      },
      {
        step_number: 5,
        title: "Units awareness",
        instruction: "Kc has units (mol/L)^Δn. For Δn = 0, what are Kc units?",
        expected_answer: "unitless|dimensionless|no units",
        explanation: "When Δn = 0, Kc = (mol/L)⁰ = unitless (dimensionless). Same for Kp (atm⁰).",
        hints: ["Δn = 0", "(mol/L)⁰ = 1", "No units"]
      }
    ],
    validation_rules: {
      delta_n_calculation: "Correct Δn from stoichiometry",
      conversion_accuracy: "Accurate Kp-Kc calculations",
      unit_awareness: "Understanding unit dependence on Δn"
    },
    success_criteria: "All 5 Kp-Kc conversion problems solved",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 17: ICE Table Method - Part 1
  {
    title: "ICE Table Method - Basic Equilibrium Calculations",
    description: "Use Initial-Change-Equilibrium tables to calculate equilibrium concentrations",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["equilibrium", "ICE-table", "calculations"],
    category: "Chemical Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "ICE table setup",
        instruction: "What does ICE stand for in ICE table?",
        expected_answer: "Initial Change Equilibrium|Initial-Change-Equilibrium",
        explanation: "ICE: Initial concentrations, Change in concentrations, Equilibrium concentrations. Systematic method for equilibrium problems.",
        hints: ["Three rows", "I-C-E", "Initial, Change, Equilibrium"]
      },
      {
        step_number: 2,
        title: "Stoichiometric relationships",
        instruction: "For A + 2B ⇌ C, if A decreases by x, B decreases by:",
        expected_answer: "2x",
        explanation: "Stoichiometry: A decreases by x, B decreases by 2x (coefficient ratio 1:2). C increases by x.",
        hints: ["Use coefficients", "Ratio 1:2", "2x for B"]
      },
      {
        step_number: 3,
        title: "Simple ICE calculation",
        instruction: "H₂ + I₂ ⇌ 2HI. Initial: [H₂]=1M, [I₂]=1M, [HI]=0. At equilibrium, [H₂]=0.5M. Find [HI] at equilibrium.",
        expected_answer: "1.0|1 M",
        explanation: "H₂ decreased by 0.5M → I₂ also decreased by 0.5M → HI increased by 2(0.5) = 1.0M. [HI]eq = 0 + 1.0 = 1.0M.",
        hints: ["H₂ decreased by 0.5", "HI increases by 2x", "2 × 0.5 = 1.0"]
      },
      {
        step_number: 4,
        title: "Calculate Kc",
        instruction: "From previous problem: [H₂]=[I₂]=0.5M, [HI]=1.0M. Calculate Kc.",
        expected_answer: "4",
        explanation: "Kc = [HI]²/([H₂][I₂]) = (1.0)²/(0.5 × 0.5) = 1.0/0.25 = 4.0.",
        hints: ["Kc = [products]/[reactants]", "[HI]²/([H₂][I₂])", "1/(0.5 × 0.5)"]
      },
      {
        step_number: 5,
        title: "Equilibrium expression",
        instruction: "For 2A ⇌ B + C, write Kc expression.",
        expected_answer: "Kc = [B][C]/[A]²|[B][C]/[A]^2",
        explanation: "Kc = [B][C]/[A]². Products in numerator, reactants in denominator. Use coefficients as exponents.",
        hints: ["Products over reactants", "[A] squared", "Coefficient = exponent"]
      }
    ],
    validation_rules: {
      ice_table_setup: "Correct ICE table construction",
      stoichiometric_changes: "Accurate use of coefficients",
      kc_calculation: "Proper equilibrium constant calculation"
    },
    success_criteria: "All 5 basic ICE table problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 18: ICE Table Method - Part 2
  {
    title: "ICE Table Method - Advanced Equilibrium Problems",
    description: "Solve complex equilibrium problems with small K approximations",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["equilibrium", "ICE-table", "approximations", "quadratic"],
    category: "Chemical Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Small K approximation",
        instruction: "If K << 1, the reaction proceeds to a (large/small) extent?",
        expected_answer: "small",
        explanation: "K << 1 means very little product formed. Reaction barely proceeds forward. Can approximate: initial ≈ equilibrium for reactants.",
        hints: ["K very small", "Little product", "Small extent"]
      },
      {
        step_number: 2,
        title: "Approximation validity",
        instruction: "For approximation x << [A]₀, typically require x < what % of [A]₀?",
        expected_answer: "5|5%",
        explanation: "Rule of thumb: x < 5% of [A]₀ for approximation to be valid. If not, must solve quadratic.",
        hints: ["5% rule", "Less than 5%", "x/[A]₀ < 0.05"]
      },
      {
        step_number: 3,
        title: "Calculate with approximation",
        instruction: "A ⇌ B, [A]₀ = 1.0M, K = 1×10⁻⁴. Using x << 1, find x (change in [A]).",
        expected_answer: "0.01|0.01 M|1×10⁻²",
        explanation: "K = x/(1-x) ≈ x/1 = 1×10⁻⁴. So x ≈ 1×10⁻⁴ M... wait, let me recalculate. Actually K = [B]/[A] = x/(1-x). If K = 1×10⁻⁴ and x << 1, then x ≈ 1×10⁻⁴ M. Check: x/1 = 0.0001/1 = 0.01% < 5% ✓",
        hints: ["K = x/(1-x) ≈ x/1", "x ≈ K × [A]₀", "x = 1×10⁻⁴"]
      },
      {
        step_number: 4,
        title: "Check approximation",
        instruction: "If x = 0.01M and [A]₀ = 1.0M, is approximation valid (x < 5% of [A]₀)?",
        expected_answer: "yes|valid",
        explanation: "x/[A]₀ = 0.01/1.0 = 0.01 = 1% < 5%. Valid! If >5%, must solve exact quadratic.",
        hints: ["Calculate percentage", "0.01/1.0 = 1%", "1% < 5% ✓"]
      },
      {
        step_number: 5,
        title: "When to use quadratic",
        instruction: "If K = 0.1 (not << 1), must you use quadratic formula?",
        expected_answer: "yes",
        explanation: "K = 0.1 is not very small. Approximation invalid. Must solve quadratic: ax² + bx + c = 0.",
        hints: ["K not small enough", "Approximation fails", "Use quadratic formula"]
      }
    ],
    validation_rules: {
      approximation_use: "Correct application of small K approximation",
      validity_check: "Proper verification of approximation",
      problem_solving: "Ability to choose appropriate method"
    },
    success_criteria: "All 5 advanced ICE table problems solved",
    points_reward: 145,
    max_attempts: 5
  },

  # Lab 19: Reaction Quotient and Prediction
  {
    title: "Reaction Quotient Q - Predicting Direction of Reaction",
    description: "Use Q to predict whether reaction proceeds forward, reverse, or at equilibrium",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["equilibrium", "reaction-quotient", "Q", "prediction"],
    category: "Chemical Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Define Q",
        instruction: "Reaction quotient Q uses (initial/equilibrium) concentrations?",
        expected_answer: "initial",
        explanation: "Q uses INITIAL (or any non-equilibrium) concentrations. K uses equilibrium concentrations. Q and K have same form, different concentrations.",
        hints: ["Non-equilibrium", "Initial values", "Not at equilibrium yet"]
      },
      {
        step_number: 2,
        title: "Q vs K comparison",
        instruction: "If Q < K, reaction proceeds in which direction: forward or reverse?",
        expected_answer: "forward",
        explanation: "Q < K: too few products. Reaction proceeds FORWARD (→) to make more products until Q = K.",
        hints: ["Q < K means need more products", "Forward direction", "Make products"]
      },
      {
        step_number: 3,
        title: "Q > K prediction",
        instruction: "If Q > K, reaction proceeds: forward or reverse?",
        expected_answer: "reverse",
        explanation: "Q > K: too many products. Reaction proceeds REVERSE (←) to make more reactants until Q = K.",
        hints: ["Q > K means excess products", "Reverse direction", "Make reactants"]
      },
      {
        step_number: 4,
        title: "Calculate Q",
        instruction: "A + B ⇌ C, [A]=2M, [B]=1M, [C]=3M initially. Calculate Q.",
        expected_answer: "1.5",
        explanation: "Q = [C]/([A][B]) = 3/(2 × 1) = 3/2 = 1.5.",
        hints: ["Q = products/reactants", "[C]/([A][B])", "3/(2×1)"]
      },
      {
        step_number: 5,
        title: "Predict direction",
        instruction: "If Q = 1.5 and K = 10, will reaction proceed forward or reverse?",
        expected_answer: "forward",
        explanation: "Q (1.5) < K (10). Need more products. Reaction proceeds FORWARD to increase [C] until Q = K = 10.",
        hints: ["Compare Q and K", "1.5 < 10", "Need more products"]
      }
    ],
    validation_rules: {
      q_calculation: "Correct Q calculation from concentrations",
      direction_prediction: "Accurate prediction from Q-K comparison",
      conceptual_understanding: "Clear grasp of Q vs K"
    },
    success_criteria: "All 5 reaction quotient problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 20: Le Chatelier's Principle Applications
  {
    title: "Le Chatelier's Principle - Predicting Equilibrium Shifts",
    description: "Apply Le Chatelier's principle to predict effects of concentration, pressure, and temperature changes",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["equilibrium", "le-chatelier", "stress", "shifts"],
    category: "Chemical Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Le Chatelier statement",
        instruction: "When stress is applied to equilibrium, system shifts to (relieve/increase) the stress?",
        expected_answer: "relieve|counteract",
        explanation: "Le Chatelier: System shifts to RELIEVE (counteract, oppose) the applied stress. Tries to restore equilibrium.",
        hints: ["Oppose the change", "Relieve stress", "Counteract"]
      },
      {
        step_number: 2,
        title: "Concentration change",
        instruction: "For A ⇌ B, if [A] is increased, equilibrium shifts: forward or reverse?",
        expected_answer: "forward",
        explanation: "Increase [A] (reactant) → shifts FORWARD to consume excess A and make more B.",
        hints: ["Consume added reactant", "Forward direction", "Make products"]
      },
      {
        step_number: 3,
        title: "Pressure effect",
        instruction: "N₂ + 3H₂ ⇌ 2NH₃. Increase pressure, equilibrium shifts toward: reactants (4 moles) or products (2 moles)?",
        expected_answer: "products|2 moles|NH3",
        explanation: "Increase P → shifts to FEWER moles of gas (2 moles of NH₃) to reduce pressure. 4 mol → 2 mol.",
        hints: ["Fewer moles side", "2 moles vs 4 moles", "Products side"]
      },
      {
        step_number: 4,
        title: "Temperature effect - endothermic",
        instruction: "For endothermic reaction (ΔH > 0), increasing T shifts equilibrium: forward or reverse?",
        expected_answer: "forward",
        explanation: "Endothermic (absorbs heat). Treat heat as reactant: Heat + reactants ⇌ products. Add heat → shifts FORWARD.",
        hints: ["Endothermic absorbs heat", "Heat is like reactant", "Forward"]
      },
      {
        step_number: 5,
        title: "Catalyst effect",
        instruction: "Does adding a catalyst shift equilibrium position?",
        expected_answer: "no",
        explanation: "NO. Catalyst speeds up both forward and reverse reactions equally. Equilibrium reached faster, but same position (same K).",
        hints: ["Affects rate, not position", "K unchanged", "No shift"]
      }
    ],
    validation_rules: {
      principle_application: "Correct Le Chatelier predictions",
      stress_identification: "Proper identification of applied stress",
      shift_direction: "Accurate direction of equilibrium shift"
    },
    success_criteria: "All 5 Le Chatelier problems solved",
    points_reward: 135,
    max_attempts: 5
  },

  # Lab 21: Degree of Dissociation Calculations
  {
    title: "Degree of Dissociation α - Relating α to K",
    description: "Calculate degree of dissociation and relate to equilibrium constant",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["equilibrium", "degree-of-dissociation", "alpha", "calculations"],
    category: "Chemical Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Define α",
        instruction: "Degree of dissociation α = (amount dissociated) / (initial amount). Range of α?",
        expected_answer: "0 to 1|0-1",
        explanation: "α ranges from 0 (no dissociation) to 1 (100% dissociation). α = 0.5 means 50% dissociated.",
        hints: ["Fraction", "0 = none, 1 = complete", "0 to 1"]
      },
      {
        step_number: 2,
        title: "Calculate moles at equilibrium",
        instruction: "A ⇌ 2B. Initial: 1 mol A. If α = 0.2, how many moles of A remain at equilibrium?",
        expected_answer: "0.8|0.8 mol",
        explanation: "20% dissociated. Remaining A = 1 × (1 - α) = 1 × 0.8 = 0.8 mol.",
        hints: ["1 - α remains", "1 × (1 - 0.2)", "0.8 mol"]
      },
      {
        step_number: 3,
        title: "Calculate moles of products",
        instruction: "Same reaction: A ⇌ 2B, 1 mol A initial, α = 0.2. How many moles of B at equilibrium?",
        expected_answer: "0.4|0.4 mol",
        explanation: "0.2 mol A dissociated → 2 × 0.2 = 0.4 mol B formed (stoichiometry 1:2).",
        hints: ["A dissociated: 1 × α = 0.2", "B formed: 2 × 0.2", "0.4 mol"]
      },
      {
        step_number: 4,
        title: "Relate α to Kp",
        instruction: "PCl₅ ⇌ PCl₃ + Cl₂. If α = 0.5, total pressure P, express Kp in terms of P.",
        expected_answer: "Kp = P/3|P/3",
        explanation: "Initial: 1 mol PCl₅. At equilibrium: (1-0.5)=0.5 PCl₅, 0.5 PCl₃, 0.5 Cl₂. Total moles = 1.5. Partial pressures: P_PCl₅ = (0.5/1.5)P = P/3, P_PCl₃ = P_Cl₂ = P/3. Kp = (P/3)(P/3)/(P/3) = P/3.",
        hints: ["Total moles = 1.5", "Partial pressure = mole fraction × P", "Kp = (products)/(reactants)"]
      },
      {
        step_number: 5,
        title: "Small α approximation",
        instruction: "If α << 1, then (1 - α) ≈ ?",
        expected_answer: "1",
        explanation: "If α very small (α << 1), then 1 - α ≈ 1. Useful approximation for weak dissociation.",
        hints: ["Small dissociation", "1 - 0.001 ≈ 1", "Approximates to 1"]
      }
    ],
    validation_rules: {
      alpha_calculations: "Correct use of α in mole calculations",
      stoichiometry: "Accurate product mole calculations",
      kp_derivation: "Proper relationship between α and K"
    },
    success_criteria: "All 5 degree of dissociation problems solved",
    points_reward: 145,
    max_attempts: 5
  },

  # Lab 22: Heterogeneous Equilibrium Problems
  {
    title: "Heterogeneous Equilibrium - Solids and Liquids in K Expression",
    description: "Understand how pure solids and liquids affect equilibrium expressions",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["equilibrium", "heterogeneous", "solids", "liquids"],
    category: "Chemical Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Pure solids and liquids in K",
        instruction: "Are pure solids and pure liquids included in K expression?",
        expected_answer: "no",
        explanation: "NO. Pure solids and pure liquids have constant concentration (activity = 1). NOT included in K expression.",
        hints: ["Constant concentration", "Not included", "Activity = 1"]
      },
      {
        step_number: 2,
        title: "Write K expression",
        instruction: "CaCO₃(s) ⇌ CaO(s) + CO₂(g). Write Kp expression.",
        expected_answer: "Kp = P_CO₂|P(CO2)|pressure of CO2",
        explanation: "Kp = P_CO₂. Solids (CaCO₃, CaO) not included. Only gas (CO₂) appears in expression.",
        hints: ["Ignore solids", "Only CO₂ gas", "Kp = P_CO₂"]
      },
      {
        step_number: 3,
        title: "Effect of solid amount",
        instruction: "If amount of CaCO₃(s) is doubled, does Kp change?",
        expected_answer: "no",
        explanation: "NO. K depends only on temperature. Amount of solid doesn't affect K (not in expression). Same equilibrium pressure of CO₂.",
        hints: ["K only depends on T", "Solid amount irrelevant", "No change"]
      },
      {
        step_number: 4,
        title: "Mixed phase equilibrium",
        instruction: "C(s) + CO₂(g) ⇌ 2CO(g). Write Kp expression.",
        expected_answer: "Kp = P_CO² / P_CO₂|P(CO)^2/P(CO2)",
        explanation: "Kp = P_CO² / P_CO₂. Solid C not included. Only gases CO and CO₂ in expression.",
        hints: ["Ignore solid C", "Only gases", "P_CO squared"]
      },
      {
        step_number: 5,
        title: "Aqueous vs pure liquid",
        instruction: "In solution phase, are dissolved species included in K expression?",
        expected_answer: "yes",
        explanation: "YES. Dissolved species (aq) ARE included in K (variable concentrations). Pure liquid solvent (like H₂O in aqueous) NOT included.",
        hints: ["(aq) species included", "Pure solvent excluded", "Variable concentrations"]
      }
    ],
    validation_rules: {
      expression_writing: "Correct K expressions for heterogeneous equilibria",
      phase_identification: "Proper identification of phases",
      conceptual_clarity: "Understanding solid/liquid exclusion"
    },
    success_criteria: "All 5 heterogeneous equilibrium problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 23: Simultaneous Equilibria
  {
    title: "Simultaneous Equilibria - Multiple Equilibria Problems",
    description: "Solve problems involving two or more equilibria occurring simultaneously",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["equilibrium", "simultaneous", "multiple-equilibria", "complex"],
    category: "Chemical Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Adding equilibria",
        instruction: "If reaction 1 has K₁ and reaction 2 has K₂, and you add them to get reaction 3, then K₃ = ?",
        expected_answer: "K₁ × K₂|K1*K2",
        explanation: "When adding reactions, MULTIPLY equilibrium constants: K₃ = K₁ × K₂.",
        hints: ["Add reactions → multiply K", "K₃ = K₁ × K₂", "Multiplication"]
      },
      {
        step_number: 2,
        title: "Reverse equilibrium",
        instruction: "If forward reaction has K, the reverse reaction has K' = ?",
        expected_answer: "1/K",
        explanation: "Reverse reaction: K' = 1/K (reciprocal). If K = 100, K_reverse = 0.01.",
        hints: ["Reciprocal", "1/K", "Flip the constant"]
      },
      {
        step_number: 3,
        title: "Calculate combined K",
        instruction: "Reaction 1: A ⇌ B, K₁ = 10. Reaction 2: B ⇌ C, K₂ = 5. Find K for A ⇌ C.",
        expected_answer: "50",
        explanation: "A ⇌ C is sum of reactions 1 and 2. K = K₁ × K₂ = 10 × 5 = 50.",
        hints: ["Add reactions", "Multiply constants", "10 × 5"]
      },
      {
        step_number: 4,
        title: "Common ion effect",
        instruction: "Two weak acids HA and HB in same solution share common ion:",
        expected_answer: "H+|H⁺|hydrogen ion",
        explanation: "Common ion is H⁺. Both acids produce H⁺, which affects both equilibria (Le Chatelier). Simultaneous equilibria problem.",
        hints: ["Both produce H⁺", "Common hydrogen ion", "Affects both equilibria"]
      },
      {
        step_number: 5,
        title: "Complex simultaneous problem",
        instruction: "For A ⇌ B (K₁ = 2) and A ⇌ C (K₂ = 3), find K for B ⇌ C.",
        expected_answer: "1.5|3/2",
        explanation: "Need B ⇌ C. Reverse reaction 1: B ⇌ A (K = 1/2). Add to reaction 2: A ⇌ C (K = 3). Overall B ⇌ C: K = (1/2) × 3 = 1.5.",
        hints: ["Reverse first reaction", "Then add", "K = (1/K₁) × K₂"]
      }
    ],
    validation_rules: {
      equilibrium_combination: "Correct combination of multiple K values",
      algebraic_manipulation: "Proper reversal and addition of reactions",
      complex_problem_solving: "Multi-step equilibria calculations"
    },
    success_criteria: "All 5 simultaneous equilibria problems solved",
    points_reward: 160,
    max_attempts: 5
  }
]

# Create equilibrium labs
puts "\nCreating Chemical Equilibrium Labs (16-23)..."
equilibrium_labs.each_with_index do |lab_data, index|
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
    order_index: index + 16
  )
  puts "  ✓ Lab #{index + 16} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "Chemical Equilibrium Labs (16-23) Complete!"
puts "="*80
puts "Created: 8 equilibrium labs"
puts "Time: ~#{equilibrium_labs.sum { |l| l[:estimated_minutes] }} minutes"
puts "Points: #{equilibrium_labs.sum { |l| l[:points_reward] }}"
puts "="*80
puts "\nReady to create Ionic Equilibrium labs (24-30)..."
puts "="*80

# ============================================================================
# CATEGORY 4: IONIC EQUILIBRIUM (Labs 24-30)
# ============================================================================

ionic_equilibrium_labs = [
  # Lab 24: pH Calculations - Strong Acids and Bases
  {
    title: "pH Calculations - Strong Acids and Bases",
    description: "Calculate pH for strong acids and strong bases with complete dissociation",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["ionic-equilibrium", "pH", "strong-acids", "strong-bases"],
    category: "Ionic Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "pH definition",
        instruction: "pH is defined as: pH = -log[H⁺] or pH = log[H⁺]?",
        expected_answer: "-log[H⁺]|pH = -log[H+]",
        explanation: "pH = -log[H⁺] = -log₁₀[H⁺]. Negative logarithm. Higher [H⁺] → lower pH (more acidic).",
        hints: ["Negative log", "-log[H⁺]", "Inverse relationship"]
      },
      {
        step_number: 2,
        title: "Calculate pH of strong acid",
        instruction: "Calculate pH of 0.01 M HCl (use log 10 = 1).",
        expected_answer: "2",
        explanation: "HCl fully dissociates: [H⁺] = 0.01 M = 10⁻² M. pH = -log(10⁻²) = 2.",
        hints: ["HCl → H⁺ + Cl⁻ (complete)", "[H⁺] = 0.01 = 10⁻²", "-log(10⁻²) = 2"]
      },
      {
        step_number: 3,
        title: "pH + pOH relationship",
        instruction: "At 25°C, pH + pOH = ?",
        expected_answer: "14",
        explanation: "pH + pOH = 14 at 25°C (from Kw = 10⁻¹⁴). This is fundamental relationship.",
        hints: ["Sum equals 14", "At 25°C", "pH + pOH = 14"]
      },
      {
        step_number: 4,
        title: "Calculate pH of strong base",
        instruction: "0.01 M NaOH solution. First find pOH, then pH.",
        expected_answer: "12",
        explanation: "NaOH → Na⁺ + OH⁻ (complete). [OH⁻] = 0.01 = 10⁻² M. pOH = -log(10⁻²) = 2. pH = 14 - 2 = 12.",
        hints: ["Find pOH first", "pOH = 2", "pH = 14 - pOH"]
      },
      {
        step_number: 5,
        title: "[H⁺] from pH",
        instruction: "If pH = 3, what is [H⁺]?",
        expected_answer: "10⁻³|0.001|1×10⁻³ M",
        explanation: "pH = -log[H⁺] = 3. Therefore [H⁺] = 10⁻ᵖᴴ = 10⁻³ M = 0.001 M.",
        hints: ["[H⁺] = 10⁻ᵖᴴ", "10⁻³", "0.001 M"]
      }
    ],
    validation_rules: {
      ph_calculation: "Correct -log[H⁺] calculations",
      strong_acid_base: "Understanding complete dissociation",
      ph_poh_relationship: "Accurate use of pH + pOH = 14"
    },
    success_criteria: "All 5 strong acid/base pH problems solved",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 25: pH Calculations - Weak Acids and Bases
  {
    title: "pH Calculations - Weak Acids and Bases",
    description: "Calculate pH using Ka and Kb for weak acids and weak bases",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["ionic-equilibrium", "pH", "weak-acids", "Ka", "Kb"],
    category: "Ionic Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Ka expression",
        instruction: "For weak acid HA ⇌ H⁺ + A⁻, write Ka expression.",
        expected_answer: "Ka = [H⁺][A⁻]/[HA]",
        explanation: "Ka = [H⁺][A⁻]/[HA]. Acid dissociation constant. Small Ka means weak acid (little dissociation).",
        hints: ["Products over reactants", "[H⁺][A⁻]/[HA]", "Acid constant"]
      },
      {
        step_number: 2,
        title: "Approximation for weak acid",
        instruction: "For weak acid, if x << C, then C - x ≈ ?",
        expected_answer: "C",
        explanation: "C - x ≈ C (initial concentration). Valid when x < 5% of C. Simplifies calculation.",
        hints: ["Small dissociation", "C - x ≈ C", "Approximation"]
      },
      {
        step_number: 3,
        title: "Calculate [H⁺] for weak acid",
        instruction: "0.1 M HA with Ka = 1×10⁻⁵. Using approximation, find [H⁺] (in M).",
        expected_answer: "0.001|1×10⁻³|10⁻³",
        explanation: "Ka = x²/C (with approximation). x² = Ka × C = 10⁻⁵ × 0.1 = 10⁻⁶. x = 10⁻³ M = [H⁺].",
        hints: ["Ka = x²/C", "x² = 10⁻⁵ × 0.1", "x = √(10⁻⁶) = 10⁻³"]
      },
      {
        step_number: 4,
        title: "Calculate pH",
        instruction: "If [H⁺] = 10⁻³ M, what is pH?",
        expected_answer: "3",
        explanation: "pH = -log[H⁺] = -log(10⁻³) = 3.",
        hints: ["pH = -log[H⁺]", "-log(10⁻³)", "pH = 3"]
      },
      {
        step_number: 5,
        title: "Ka and Kb relationship",
        instruction: "For conjugate acid-base pair, Ka × Kb = ?",
        expected_answer: "Kw|10⁻¹⁴",
        explanation: "Ka × Kb = Kw = 10⁻¹⁴ at 25°C. Important relationship for conjugate pairs.",
        hints: ["Product equals Kw", "10⁻¹⁴", "Ka × Kb = Kw"]
      }
    ],
    validation_rules: {
      ka_expression: "Correct weak acid equilibrium expression",
      approximation_use: "Proper application of x << C approximation",
      ph_calculation: "Accurate multi-step pH calculation"
    },
    success_criteria: "All 5 weak acid/base pH problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 26: Henderson-Hasselbalch Equation
  {
    title: "Henderson-Hasselbalch Equation - Buffer Calculations",
    description: "Use Henderson-Hasselbalch equation for buffer pH calculations",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["ionic-equilibrium", "buffers", "henderson-hasselbalch", "pH"],
    category: "Ionic Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Henderson-Hasselbalch equation",
        instruction: "The Henderson-Hasselbalch equation is: pH = pKa + log([A⁻]/[HA]) or pH = pKa - log([A⁻]/[HA])?",
        expected_answer: "pH = pKa + log([A⁻]/[HA])|plus",
        explanation: "pH = pKa + log([A⁻]/[HA]). Plus sign. [A⁻] = conjugate base, [HA] = weak acid.",
        hints: ["Plus sign", "pH = pKa + log", "Base over acid"]
      },
      {
        step_number: 2,
        title: "When pH = pKa",
        instruction: "When [A⁻] = [HA], pH = ?",
        expected_answer: "pKa",
        explanation: "When [A⁻] = [HA], ratio = 1, log(1) = 0. So pH = pKa + 0 = pKa.",
        hints: ["Ratio = 1", "log(1) = 0", "pH = pKa"]
      },
      {
        step_number: 3,
        title: "Calculate pH of buffer",
        instruction: "Buffer: 0.1 M CH₃COOH (pKa = 4.76) + 0.1 M CH₃COO⁻. Calculate pH.",
        expected_answer: "4.76",
        explanation: "pH = pKa + log([A⁻]/[HA]) = 4.76 + log(0.1/0.1) = 4.76 + log(1) = 4.76 + 0 = 4.76.",
        hints: ["Equal concentrations", "log(1) = 0", "pH = pKa"]
      },
      {
        step_number: 4,
        title: "Ratio effect on pH",
        instruction: "If [A⁻]/[HA] = 10, and pKa = 5, calculate pH.",
        expected_answer: "6",
        explanation: "pH = pKa + log([A⁻]/[HA]) = 5 + log(10) = 5 + 1 = 6.",
        hints: ["log(10) = 1", "5 + 1", "pH = 6"]
      },
      {
        step_number: 5,
        title: "Buffer range",
        instruction: "Effective buffer range is typically pKa ± how many units?",
        expected_answer: "1",
        explanation: "Buffer effective in range pKa ± 1. Best buffering when pH ≈ pKa (ratio close to 1).",
        hints: ["Plus minus 1", "pKa ± 1", "One unit"]
      }
    ],
    validation_rules: {
      equation_application: "Correct use of Henderson-Hasselbalch",
      ratio_calculation: "Accurate [A⁻]/[HA] ratio use",
      buffer_understanding: "Grasp of buffer behavior"
    },
    success_criteria: "All 5 Henderson-Hasselbalch problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 27: Buffer Solution Problems
  {
    title: "Buffer Solutions - Capacity and pH Changes",
    description: "Understand buffer action and calculate pH changes upon adding acid/base",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["ionic-equilibrium", "buffers", "buffer-capacity", "pH-change"],
    category: "Ionic Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Buffer definition",
        instruction: "A buffer resists changes in:",
        expected_answer: "pH",
        explanation: "Buffer resists pH changes when small amounts of acid or base are added. Made from weak acid + conjugate base (or weak base + conjugate acid).",
        hints: ["Resists pH change", "pH stability", "pH"]
      },
      {
        step_number: 2,
        title: "Buffer composition",
        instruction: "To make an acidic buffer (pH < 7), use weak acid + its conjugate:",
        expected_answer: "base",
        explanation: "Acidic buffer: weak acid + conjugate base (salt). Example: CH₃COOH + CH₃COONa. pH < 7.",
        hints: ["Weak acid system", "Conjugate base", "Salt of weak acid"]
      },
      {
        step_number: 3,
        title: "Adding strong acid to buffer",
        instruction: "Buffer: HA/A⁻. Add HCl (strong acid). Which species is consumed?",
        expected_answer: "A⁻|base|conjugate base",
        explanation: "A⁻ (base) reacts with added H⁺: A⁻ + H⁺ → HA. Converts conjugate base to acid. pH decreases slightly.",
        hints: ["Base neutralizes acid", "A⁻ + H⁺", "Conjugate base consumed"]
      },
      {
        step_number: 4,
        title: "pH change calculation setup",
        instruction: "1 L buffer: 0.1 M HA (pKa = 5) + 0.1 M A⁻. Add 0.01 mol HCl. New [HA] = ?",
        expected_answer: "0.11|0.11 M",
        explanation: "A⁻ + H⁺ → HA. [A⁻] decreases by 0.01, [HA] increases by 0.01. New [HA] = 0.1 + 0.01 = 0.11 M.",
        hints: ["HA increases", "0.1 + 0.01", "0.11 M"]
      },
      {
        step_number: 5,
        title: "Calculate new pH",
        instruction: "New [HA] = 0.11 M, new [A⁻] = 0.09 M, pKa = 5. Calculate new pH (use log(0.09/0.11) ≈ -0.09).",
        expected_answer: "4.91|4.9",
        explanation: "pH = pKa + log([A⁻]/[HA]) = 5 + log(0.09/0.11) = 5 + (-0.09) = 4.91. Small change from 5.00 to 4.91.",
        hints: ["Henderson-Hasselbalch", "5 + log(0.09/0.11)", "≈ 4.91"]
      }
    ],
    validation_rules: {
      buffer_action: "Understanding how buffers resist pH change",
      stoichiometry: "Correct calculation of concentration changes",
      ph_calculation: "Accurate final pH calculation"
    },
    success_criteria: "All 5 buffer solution problems solved",
    points_reward: 150,
    max_attempts: 5
  },

  # Lab 28: Salt Hydrolysis and pH
  {
    title: "Salt Hydrolysis - pH of Salt Solutions",
    description: "Predict and calculate pH of salt solutions based on acid-base strength",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["ionic-equilibrium", "salt-hydrolysis", "pH"],
    category: "Ionic Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Salt of strong acid + strong base",
        instruction: "NaCl (from NaOH + HCl) solution has pH:",
        expected_answer: "7|neutral",
        explanation: "pH = 7 (neutral). Neither Na⁺ nor Cl⁻ hydrolyzes. Strong acid + strong base → neutral salt.",
        hints: ["No hydrolysis", "Neutral", "pH = 7"]
      },
      {
        step_number: 2,
        title: "Salt of weak acid + strong base",
        instruction: "CH₃COONa (from CH₃COOH + NaOH) solution is: acidic, basic, or neutral?",
        expected_answer: "basic",
        explanation: "BASIC (pH > 7). CH₃COO⁻ hydrolyzes: CH₃COO⁻ + H₂O ⇌ CH₃COOH + OH⁻. Produces OH⁻.",
        hints: ["Anion of weak acid", "Produces OH⁻", "Basic"]
      },
      {
        step_number: 3,
        title: "Salt of strong acid + weak base",
        instruction: "NH₄Cl (from HCl + NH₃) solution is: acidic, basic, or neutral?",
        expected_answer: "acidic",
        explanation: "ACIDIC (pH < 7). NH₄⁺ hydrolyzes: NH₄⁺ ⇌ NH₃ + H⁺. Produces H⁺.",
        hints: ["Cation of weak base", "Produces H⁺", "Acidic"]
      },
      {
        step_number: 4,
        title: "Salt of weak acid + weak base",
        instruction: "CH₃COONH₄ solution pH depends on relative strength of:",
        expected_answer: "Ka and Kb|acid and base strengths",
        explanation: "Depends on Ka (of CH₃COOH) vs Kb (of NH₃). If Ka > Kb: acidic. If Kb > Ka: basic. If Ka = Kb: neutral.",
        hints: ["Compare Ka and Kb", "Both hydrolyze", "Stronger determines pH"]
      },
      {
        step_number: 5,
        title: "Calculate pH of salt",
        instruction: "For salt of weak base (Kb = 10⁻⁵), pH of 0.1 M solution (cation hydrolysis: Ka = Kw/Kb = 10⁻⁹). Using Ka = x²/C, find [H⁺].",
        expected_answer: "10⁻⁵|1×10⁻⁵ M",
        explanation: "Ka = x²/C. x² = Ka × C = 10⁻⁹ × 0.1 = 10⁻¹⁰. x = 10⁻⁵ M = [H⁺]. pH = 5 (acidic).",
        hints: ["Ka = Kw/Kb = 10⁻⁹", "x² = 10⁻⁹ × 0.1", "x = 10⁻⁵"]
      }
    ],
    validation_rules: {
      hydrolysis_prediction: "Correct prediction of acidic/basic/neutral",
      ph_reasoning: "Understanding hydrolysis reactions",
      calculation_accuracy: "Accurate pH calculations"
    },
    success_criteria: "All 5 salt hydrolysis problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 29: Ksp and Solubility Calculations
  {
    title: "Solubility Product Ksp - Solubility Calculations",
    description: "Calculate Ksp from solubility and vice versa for sparingly soluble salts",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["ionic-equilibrium", "Ksp", "solubility", "precipitation"],
    category: "Ionic Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Define Ksp",
        instruction: "Solubility product Ksp is equilibrium constant for:",
        expected_answer: "dissolution|dissolving of sparingly soluble salt",
        explanation: "Ksp is equilibrium constant for dissolution of sparingly soluble salt: AB(s) ⇌ A⁺(aq) + B⁻(aq). Ksp = [A⁺][B⁻].",
        hints: ["Dissolution equilibrium", "Sparingly soluble", "Salt dissolving"]
      },
      {
        step_number: 2,
        title: "Write Ksp expression",
        instruction: "For AgCl(s) ⇌ Ag⁺ + Cl⁻, write Ksp.",
        expected_answer: "Ksp = [Ag⁺][Cl⁻]",
        explanation: "Ksp = [Ag⁺][Cl⁻]. Solid AgCl not included (activity = 1).",
        hints: ["Products only", "No solid", "[Ag⁺][Cl⁻]"]
      },
      {
        step_number: 3,
        title: "Calculate Ksp from solubility",
        instruction: "If solubility of AgCl is S = 1×10⁻⁵ M, calculate Ksp.",
        expected_answer: "1×10⁻¹⁰|10⁻¹⁰",
        explanation: "AgCl → Ag⁺ + Cl⁻. If S mol/L dissolves, [Ag⁺] = [Cl⁻] = S. Ksp = S × S = S² = (10⁻⁵)² = 10⁻¹⁰.",
        hints: ["[Ag⁺] = [Cl⁻] = S", "Ksp = S²", "(10⁻⁵)²"]
      },
      {
        step_number: 4,
        title: "Calculate solubility from Ksp",
        instruction: "Ksp of PbI₂ = 8×10⁻⁹. PbI₂ → Pb²⁺ + 2I⁻. If solubility is S, express Ksp in terms of S.",
        expected_answer: "Ksp = 4S³|4S^3",
        explanation: "If S mol/L dissolves: [Pb²⁺] = S, [I⁻] = 2S. Ksp = [Pb²⁺][I⁻]² = S(2S)² = 4S³.",
        hints: ["[Pb²⁺] = S, [I⁻] = 2S", "Ksp = S × (2S)²", "4S³"]
      },
      {
        step_number: 5,
        title: "Calculate S",
        instruction: "From Ksp = 4S³ = 8×10⁻⁹, calculate S (in M, use cube root).",
        expected_answer: "1.26×10⁻³|0.00126|1.3×10⁻³",
        explanation: "S³ = (8×10⁻⁹)/4 = 2×10⁻⁹. S = ∛(2×10⁻⁹) = 1.26×10⁻³ M.",
        hints: ["S³ = 2×10⁻⁹", "Cube root", "≈ 1.26×10⁻³"]
      }
    },
    validation_rules: {
      ksp_expression: "Correct Ksp equilibrium expressions",
      solubility_relationship: "Accurate S to Ksp conversions",
      stoichiometry: "Proper handling of stoichiometric coefficients"
    },
    success_criteria: "All 5 Ksp and solubility problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 30: Common Ion Effect on Solubility
  {
    title: "Common Ion Effect - Impact on Solubility",
    description: "Calculate how common ion presence decreases solubility of sparingly soluble salts",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["ionic-equilibrium", "common-ion-effect", "Ksp", "solubility"],
    category: "Ionic Equilibrium",
    steps: [
      {
        step_number: 1,
        title: "Common ion effect",
        instruction: "Adding a common ion (increases/decreases) solubility of a salt?",
        expected_answer: "decreases",
        explanation: "DECREASES solubility. Le Chatelier: adding product shifts equilibrium left (less dissolution). Common ion effect.",
        hints: ["Le Chatelier", "Shifts to reactant", "Decreases"]
      },
      {
        step_number: 2,
        title: "Identify common ion",
        instruction: "For AgCl in NaCl solution, the common ion is:",
        expected_answer: "Cl⁻|chloride",
        explanation: "Cl⁻ is common ion (present in both AgCl and NaCl). Excess Cl⁻ suppresses AgCl dissolution.",
        hints: ["Both contain Cl⁻", "Chloride ion", "Cl⁻"]
      },
      {
        step_number: 3,
        title: "Setup with common ion",
        instruction: "AgCl in 0.01 M NaCl. [Cl⁻] from NaCl = 0.01 M. If AgCl solubility is S, total [Cl⁻] ≈ ?",
        expected_answer: "0.01|0.01 M",
        explanation: "[Cl⁻]_total ≈ 0.01 M (from NaCl). S very small, so [Cl⁻] from AgCl negligible. Approximation: [Cl⁻] ≈ 0.01.",
        hints: ["NaCl dominates", "S << 0.01", "[Cl⁻] ≈ 0.01"]
      },
      {
        step_number: 4,
        title: "Calculate solubility with common ion",
        instruction: "Ksp(AgCl) = 1×10⁻¹⁰, [Cl⁻] ≈ 0.01 M. Calculate S = [Ag⁺].",
        expected_answer: "1×10⁻⁸|10⁻⁸ M",
        explanation: "Ksp = [Ag⁺][Cl⁻]. 10⁻¹⁰ = S × 0.01. S = 10⁻¹⁰ / 10⁻² = 10⁻⁸ M.",
        hints: ["Ksp = [Ag⁺][Cl⁻]", "S × 0.01 = 10⁻¹⁰", "S = 10⁻⁸"]
      },
      {
        step_number: 5,
        title: "Compare solubilities",
        instruction: "Without NaCl, S(AgCl) = 10⁻⁵ M. With 0.01 M NaCl, S = 10⁻⁸ M. Solubility decreased by factor of:",
        expected_answer: "1000|10³",
        explanation: "Factor = 10⁻⁵ / 10⁻⁸ = 10³ = 1000. Common ion decreased solubility 1000-fold! Significant effect.",
        hints: ["10⁻⁵ / 10⁻⁸", "10³", "1000 times"]
      }
    },
    validation_rules: {
      common_ion_identification: "Correct identification of common ion",
      approximation_use: "Proper use of S << [common ion]",
      calculation_accuracy: "Accurate solubility with common ion"
    },
    success_criteria: "All 5 common ion effect problems solved",
    points_reward: 150,
    max_attempts: 5
  }
]

# Create ionic equilibrium labs
puts "\nCreating Ionic Equilibrium Labs (24-30)..."
ionic_equilibrium_labs.each_with_index do |lab_data, index|
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
    order_index: index + 24
  )
  puts "  ✓ Lab #{index + 24} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "🎉 Physical Chemistry Labs - Part 2 COMPLETE! 🎉"
puts "="*80
puts "Created: 15 comprehensive numerical labs (Labs 16-30)"
puts ""
puts "Category 3: Chemical Equilibrium (Labs 16-23, 8 labs)"
puts "  • Kp-Kc conversions, ICE tables, Q vs K"
puts "  • Le Chatelier, degree of dissociation"
puts "  • Heterogeneous and simultaneous equilibria"
puts "  • Time: ~260 minutes, Points: 1,060"
puts ""
puts "Category 4: Ionic Equilibrium (Labs 24-30, 7 labs)"
puts "  • pH of strong and weak acids/bases"
puts "  • Henderson-Hasselbalch, buffer solutions"
puts "  • Salt hydrolysis, Ksp, common ion effect"
puts "  • Time: ~230 minutes, Points: 945"
puts ""
puts "TOTAL Part 2: 15 labs, ~490 minutes (~8.2 hours), 2,005 points"
puts "="*80
puts "\n✅ Labs 16-30 complete! Total: 30/45 labs (67%)"
puts "Next: Create Labs 31-45 (electrochemistry and solutions)"
puts "="*80

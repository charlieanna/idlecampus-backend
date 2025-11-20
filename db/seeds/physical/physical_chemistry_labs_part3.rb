# Physical Chemistry Hands-On Labs - Part 3 (Labs 31-45)
# Covers: Electrochemistry and Solutions

puts "Creating Physical Chemistry Hands-On Labs (Part 3: Labs 31-45)..."

course_physical = Course.find_by(title: 'Physical Chemistry for IIT JEE Main & Advanced')

unless course_physical
  puts "Error: Physical Chemistry course not found!"
  exit
end

# ============================================================================
# CATEGORY 5: ELECTROCHEMISTRY (Labs 31-40)
# ============================================================================

electrochemistry_labs = [
  # Lab 31: Oxidation Numbers and Balancing Redox Reactions
  {
    title: "Oxidation Numbers and Balancing Redox Reactions",
    description: "Assign oxidation numbers and balance redox reactions using oxidation number method",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "oxidation-number", "redox", "balancing"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Oxidation number rules",
        instruction: "What is the oxidation number of an element in its free state (e.g., O₂, Na)?",
        expected_answer: "0|zero",
        explanation: "Elements in free state have oxidation number = 0. Examples: O₂, H₂, Na, Fe all have oxidation number 0.",
        hints: ["Free element", "Zero", "Uncombined element"]
      },
      {
        step_number: 2,
        title: "Oxidation number of oxygen",
        instruction: "In most compounds, oxygen has oxidation number:",
        expected_answer: "-2",
        explanation: "O is usually -2 (except in peroxides like H₂O₂ where it's -1, and OF₂ where it's +2).",
        hints: ["Negative two", "-2", "Usually -2"]
      },
      {
        step_number: 3,
        title: "Calculate oxidation number",
        instruction: "In H₂SO₄, what is the oxidation number of S? (H = +1, O = -2)",
        expected_answer: "+6|6",
        explanation: "Sum = 0: 2(+1) + S + 4(-2) = 0. 2 + S - 8 = 0. S = +6.",
        hints: ["Total charge = 0", "2 H atoms, 4 O atoms", "2 + S - 8 = 0"]
      },
      {
        step_number: 4,
        title: "Identify oxidation and reduction",
        instruction: "Zn + Cu²⁺ → Zn²⁺ + Cu. Which species is oxidized?",
        expected_answer: "Zn|zinc",
        explanation: "Zn (0 → +2): OXIDIZED (loses electrons, increase in oxidation number). Cu²⁺ (+2 → 0): REDUCED.",
        hints: ["Loses electrons", "0 to +2", "Zinc"]
      },
      {
        step_number: 5,
        title: "Oxidizing and reducing agents",
        instruction: "In above reaction, which species is the reducing agent: Zn or Cu²⁺?",
        expected_answer: "Zn|zinc",
        explanation: "Zn is REDUCING AGENT (gets oxidized itself, causes reduction of Cu²⁺). Cu²⁺ is oxidizing agent.",
        hints: ["Gets oxidized", "Causes reduction", "Zn"]
      }
    ],
    validation_rules: {
      oxidation_number_assignment: "Correct oxidation number rules",
      redox_identification: "Accurate identification of oxidation/reduction",
      agent_identification: "Proper oxidizing/reducing agent identification"
    },
    success_criteria: "All 5 oxidation number problems solved",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 32: Galvanic Cell Basics and Cell Notation
  {
    title: "Galvanic Cell Basics and Cell Notation",
    description: "Understand galvanic cell components and write standard cell notation",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "galvanic-cell", "cell-notation", "electrodes"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Galvanic cell definition",
        instruction: "In a galvanic cell, chemical energy is converted to:",
        expected_answer: "electrical energy|electricity",
        explanation: "Galvanic (voltaic) cell: Chemical → Electrical energy. Spontaneous redox reaction produces electricity.",
        hints: ["Spontaneous", "Produces electricity", "Chemical to electrical"]
      },
      {
        step_number: 2,
        title: "Anode vs cathode",
        instruction: "At the anode, oxidation or reduction occurs?",
        expected_answer: "oxidation",
        explanation: "ANODE: OXIDATION occurs (lose electrons). CATHODE: REDUCTION occurs (gain electrons). Remember: AN-OX, CAT-RED.",
        hints: ["AN-OX", "Loses electrons", "Oxidation"]
      },
      {
        step_number: 3,
        title: "Electron flow",
        instruction: "Electrons flow from (anode/cathode) to (anode/cathode) through external circuit?",
        expected_answer: "anode to cathode|from anode to cathode",
        explanation: "Electrons flow: ANODE → external circuit → CATHODE. Anode is negative terminal, cathode is positive.",
        hints: ["From oxidation site", "Anode to cathode", "Negative to positive"]
      },
      {
        step_number: 4,
        title: "Salt bridge function",
        instruction: "Salt bridge maintains:",
        expected_answer: "electrical neutrality|charge balance",
        explanation: "Salt bridge maintains electrical neutrality by allowing ion flow between half-cells. Prevents charge buildup.",
        hints: ["Ion movement", "Charge balance", "Neutrality"]
      },
      {
        step_number: 5,
        title: "Cell notation",
        instruction: "Write cell notation for: Zn(s)|Zn²⁺(aq) || Cu²⁺(aq)|Cu(s). Which electrode is on the left?",
        expected_answer: "anode|Zn",
        explanation: "Cell notation: ANODE | anode solution || cathode solution | CATHODE. Left = anode (oxidation), right = cathode (reduction).",
        hints: ["Left side", "Oxidation", "Anode"]
      }
    ],
    validation_rules: {
      cell_components: "Understanding galvanic cell parts",
      electron_flow: "Correct direction of electron flow",
      cell_notation: "Proper standard cell notation"
    },
    success_criteria: "All 5 galvanic cell basics problems solved",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 33: Standard Electrode Potential and EMF
  {
    title: "Standard Electrode Potential E° - Calculating Cell EMF",
    description: "Calculate standard cell potential E°cell from standard reduction potentials",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "standard-potential", "E-cell", "EMF"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Standard hydrogen electrode",
        instruction: "The standard hydrogen electrode (SHE) has E° = ?",
        expected_answer: "0|0 V|zero",
        explanation: "E°(SHE) = 0 V by definition. Reference electrode for all other potentials.",
        hints: ["Reference", "Zero volts", "0 V"]
      },
      {
        step_number: 2,
        title: "E°cell formula",
        instruction: "E°cell = E°(cathode) - E°(anode) or E°cell = E°(anode) - E°(cathode)?",
        expected_answer: "E°(cathode) - E°(anode)|cathode minus anode",
        explanation: "E°cell = E°(cathode) - E°(anode). Reduction potential of cathode MINUS reduction potential of anode.",
        hints: ["Cathode minus anode", "Reduction - Reduction", "Subtract anode"]
      },
      {
        step_number: 3,
        title: "Calculate E°cell",
        instruction: "Zn²⁺/Zn: E° = -0.76 V, Cu²⁺/Cu: E° = +0.34 V. For Zn|Zn²⁺||Cu²⁺|Cu, calculate E°cell.",
        expected_answer: "1.10|1.1|1.10 V",
        explanation: "Zn is anode (oxidized), Cu is cathode (reduced). E°cell = 0.34 - (-0.76) = 0.34 + 0.76 = 1.10 V.",
        hints: ["Cathode - anode", "0.34 - (-0.76)", "1.10 V"]
      },
      {
        step_number: 4,
        title: "Spontaneity criterion",
        instruction: "For a spontaneous galvanic cell, E°cell must be: positive or negative?",
        expected_answer: "positive",
        explanation: "Spontaneous: E°cell > 0 (positive). Non-spontaneous: E°cell < 0. Positive EMF drives spontaneous reaction.",
        hints: ["Spontaneous reaction", "Positive", "> 0"]
      },
      {
        step_number: 5,
        title: "Reduction potential comparison",
        instruction: "Higher reduction potential species is (better/worse) oxidizing agent?",
        expected_answer: "better",
        explanation: "Higher E° = BETTER OXIDIZING AGENT (stronger tendency to be reduced, gain electrons). F₂ (+2.87 V) is strongest oxidizing agent.",
        hints: ["Higher E°", "Better oxidizing agent", "Easily reduced"]
      }
    ],
    validation_rules: {
      potential_calculation: "Correct E°cell = cathode - anode",
      spontaneity_prediction: "Accurate use of E°cell sign",
      concept_clarity: "Understanding E° and oxidizing power"
    },
    success_criteria: "All 5 electrode potential problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 34: Nernst Equation Applications
  {
    title: "Nernst Equation - Non-standard Conditions",
    description: "Apply Nernst equation to calculate cell potential at non-standard conditions",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "nernst-equation", "cell-potential", "concentration"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Nernst equation at 298 K",
        instruction: "The Nernst equation at 25°C is: Ecell = E°cell - (0.0591/n) log Q or Ecell = E°cell + (0.0591/n) log Q?",
        expected_answer: "E°cell - (0.0591/n) log Q|minus",
        explanation: "Ecell = E°cell - (0.0591/n) log Q at 298 K. n = electrons transferred, Q = reaction quotient.",
        hints: ["Minus sign", "0.0591 at 25°C", "Subtract log Q term"]
      },
      {
        step_number: 2,
        title: "At equilibrium",
        instruction: "At equilibrium, Ecell = ?",
        expected_answer: "0|zero",
        explanation: "At equilibrium: Ecell = 0 (no net reaction, no current). Q = K at equilibrium.",
        hints: ["No current", "Zero", "Equilibrium"]
      },
      {
        step_number: 3,
        title: "Calculate n",
        instruction: "For Zn + Cu²⁺ → Zn²⁺ + Cu, how many electrons are transferred (n)?",
        expected_answer: "2",
        explanation: "Zn → Zn²⁺ + 2e⁻ (loses 2). Cu²⁺ + 2e⁻ → Cu (gains 2). n = 2 electrons transferred.",
        hints: ["Count electrons", "Zn loses 2e⁻", "n = 2"]
      },
      {
        step_number: 4,
        title: "Calculate Q",
        instruction: "For above reaction with [Zn²⁺] = 1.0 M, [Cu²⁺] = 0.01 M, calculate Q.",
        expected_answer: "100",
        explanation: "Q = [Zn²⁺]/[Cu²⁺] = 1.0/0.01 = 100. Products over reactants (solids not included).",
        hints: ["Q = products/reactants", "[Zn²⁺]/[Cu²⁺]", "1.0/0.01"]
      },
      {
        step_number: 5,
        title: "Calculate Ecell",
        instruction: "E°cell = 1.10 V, n = 2, Q = 100 (log 100 = 2). Calculate Ecell.",
        expected_answer: "1.04|1.041|1.04 V",
        explanation: "Ecell = E°cell - (0.0591/n) log Q = 1.10 - (0.0591/2)(2) = 1.10 - 0.0591 = 1.041 V ≈ 1.04 V.",
        hints: ["Ecell = 1.10 - (0.0591/2)(2)", "1.10 - 0.0591", "≈ 1.04 V"]
      }
    ],
    validation_rules: {
      nernst_application: "Correct use of Nernst equation",
      q_calculation: "Accurate reaction quotient calculation",
      numerical_accuracy: "Precise Ecell calculation"
    },
    success_criteria: "All 5 Nernst equation problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 35: Relating E°cell to ΔG° and K
  {
    title: "Relating E°cell to ΔG° and Equilibrium Constant",
    description: "Use ΔG° = -nFE°cell and E°cell = (RT/nF) ln K relationships",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "gibbs-energy", "equilibrium-constant", "thermodynamics"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "ΔG° and E°cell relationship",
        instruction: "The relationship is: ΔG° = -nFE°cell. What is F?",
        expected_answer: "Faraday constant|96500|96485",
        explanation: "F = Faraday constant = 96,485 C/mol ≈ 96,500 C/mol. Charge of 1 mole of electrons.",
        hints: ["Faraday constant", "~96,500 C/mol", "Charge per mole e⁻"]
      },
      {
        step_number: 2,
        title: "Sign relationship",
        instruction: "If E°cell > 0, then ΔG° is: positive or negative?",
        expected_answer: "negative",
        explanation: "E°cell > 0 → ΔG° < 0 (negative) → spontaneous. Inverse relationship: ΔG° = -nFE°.",
        hints: ["Negative sign in formula", "Spontaneous", "ΔG° < 0"]
      },
      {
        step_number: 3,
        title: "Calculate ΔG°",
        instruction: "E°cell = 1.10 V, n = 2. Calculate ΔG° (F = 96,500 C/mol, in kJ).",
        expected_answer: "-212|-212.3|-212 kJ",
        explanation: "ΔG° = -nFE° = -2 × 96,500 × 1.10 = -212,300 J = -212.3 kJ. Spontaneous (negative).",
        hints: ["ΔG° = -nFE°", "-2 × 96,500 × 1.10", "Convert J to kJ"]
      },
      {
        step_number: 4,
        title: "E° and K relationship",
        instruction: "At 298 K, E°cell = (0.0591/n) log K. If E°cell = 1.10 V and n = 2, calculate log K.",
        expected_answer: "37.2|37",
        explanation: "1.10 = (0.0591/2) log K. log K = 1.10 × 2 / 0.0591 = 2.20 / 0.0591 = 37.2.",
        hints: ["Rearrange formula", "log K = nE°/0.0591", "2.20/0.0591"]
      },
      {
        step_number: 5,
        title: "Calculate K",
        instruction: "If log K = 37.2, then K = 10³⁷·². This is a (very large/very small) K?",
        expected_answer: "very large",
        explanation: "K = 10³⁷·² ≈ 10³⁷ (enormous!). Reaction essentially goes to completion. Large E° → large K → products heavily favored.",
        hints: ["10³⁷", "Huge number", "Very large"]
      }
    ],
    validation_rules: {
      delta_g_calculation: "Correct ΔG° = -nFE° calculation",
      k_calculation: "Accurate K from E°cell",
      conceptual_relationships: "Understanding E°-ΔG°-K connections"
    },
    success_criteria: "All 5 thermodynamic-electrochemistry problems solved",
    points_reward: 155,
    max_attempts: 5
  },

  # Lab 36: Concentration Cells
  {
    title: "Concentration Cells - EMF from Concentration Differences",
    description: "Calculate EMF of concentration cells using Nernst equation",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "concentration-cell", "nernst-equation"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Concentration cell definition",
        instruction: "In a concentration cell, both electrodes are made of the (same/different) material?",
        expected_answer: "same",
        explanation: "SAME material, but different ion concentrations. E°cell = 0 (same half-reactions), but Ecell ≠ 0 due to concentration difference.",
        hints: ["Same electrode", "Different concentrations", "Same material"]
      },
      {
        step_number: 2,
        title: "E°cell for concentration cell",
        instruction: "For concentration cell, E°cell = ?",
        expected_answer: "0|zero",
        explanation: "E°cell = 0 (same half-reactions, same E° values cancel). EMF arises only from concentration difference (Nernst equation).",
        hints: ["Same reactions", "Zero", "E° = 0"]
      },
      {
        step_number: 3,
        title: "Direction of electron flow",
        instruction: "Electrons flow from (lower/higher) concentration electrode to (lower/higher) concentration electrode?",
        expected_answer: "lower to higher|from lower to higher",
        explanation: "Electrons flow from LOWER concentration → HIGHER concentration. Lower [M²⁺] electrode is anode (oxidation), higher is cathode (reduction).",
        hints: ["Lower → higher", "Dilute to concentrated", "Lower conc. oxidizes"]
      },
      {
        step_number: 4,
        title: "Concentration cell Nernst equation",
        instruction: "For Cu|Cu²⁺(0.01 M)||Cu²⁺(1.0 M)|Cu, write Q in terms of concentrations.",
        expected_answer: "Q = 0.01/1.0|0.01",
        explanation: "Q = [Cu²⁺]_anode / [Cu²⁺]_cathode = 0.01 / 1.0 = 0.01. Anode (dilute) / Cathode (concentrated).",
        hints: ["Anode conc. / Cathode conc.", "0.01/1.0", "Q = 0.01"]
      },
      {
        step_number: 5,
        title: "Calculate Ecell",
        instruction: "Using Ecell = 0 - (0.0591/2) log(0.01), calculate Ecell (log 0.01 = -2).",
        expected_answer: "0.0591|0.059|0.06",
        explanation: "Ecell = 0 - (0.0591/2)(-2) = 0 + 0.0591 = 0.0591 V ≈ 0.059 V. Positive, spontaneous from dilute to concentrated.",
        hints: ["E° = 0", "-(0.0591/2)(-2)", "Double negative"]
      }
    ],
    validation_rules: {
      concentration_cell_concept: "Understanding concentration cell mechanism",
      nernst_application: "Correct application to concentration cells",
      calculation_accuracy: "Accurate EMF calculation"
    },
    success_criteria: "All 5 concentration cell problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 37: Electrolysis and Faraday's Laws
  {
    title: "Electrolysis and Faraday's Laws of Electrolysis",
    description: "Apply Faraday's laws: Q = It and m = (Q × M) / (n × F)",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "electrolysis", "faraday-laws", "quantitative"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Electrolysis definition",
        instruction: "In electrolysis, electrical energy is converted to:",
        expected_answer: "chemical energy",
        explanation: "Electrolysis: Electrical → Chemical energy. Non-spontaneous reaction driven by external voltage (opposite of galvanic cell).",
        hints: ["Non-spontaneous", "External power", "Electrical to chemical"]
      },
      {
        step_number: 2,
        title: "Faraday's first law",
        instruction: "Mass deposited is proportional to:",
        expected_answer: "charge passed|quantity of electricity|Q",
        explanation: "Faraday's first law: mass ∝ charge (Q). More charge → more deposition. Q = I × t (current × time).",
        hints: ["Charge", "Q = It", "Quantity of electricity"]
      },
      {
        step_number: 3,
        title: "Calculate charge",
        instruction: "Current I = 2 A flows for t = 30 minutes. Calculate total charge Q (in coulombs).",
        expected_answer: "3600|3600 C",
        explanation: "Q = I × t = 2 A × (30 × 60 s) = 2 × 1800 = 3600 C. Convert minutes to seconds.",
        hints: ["Q = It", "30 min = 1800 s", "2 × 1800"]
      },
      {
        step_number: 4,
        title: "Moles of electrons",
        instruction: "How many moles of electrons in Q = 3600 C? (F = 96,500 C/mol)",
        expected_answer: "0.0373|0.037|0.04",
        explanation: "Moles e⁻ = Q/F = 3600/96,500 = 0.0373 mol.",
        hints: ["n = Q/F", "3600/96,500", "≈ 0.037 mol"]
      },
      {
        step_number: 5,
        title: "Calculate mass deposited",
        instruction: "Cu²⁺ + 2e⁻ → Cu. If 0.0373 mol e⁻ passed, how many moles of Cu deposited? (Cu needs 2e⁻)",
        expected_answer: "0.0187|0.019|0.02",
        explanation: "Moles Cu = (moles e⁻) / 2 = 0.0373 / 2 = 0.0187 mol. Each Cu²⁺ needs 2e⁻.",
        hints: ["2 electrons per Cu", "0.0373/2", "≈ 0.0187 mol"]
      }
    ],
    validation_rules: {
      charge_calculation: "Correct Q = It calculation",
      faraday_law_application: "Proper use of Q/F for moles",
      stoichiometry: "Accurate electron-to-metal ratio"
    },
    success_criteria: "All 5 Faraday's law problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 38: Quantitative Electrolysis Problems
  {
    title: "Quantitative Electrolysis - Mass and Volume Calculations",
    description: "Calculate mass of metal deposited and volume of gas liberated during electrolysis",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "electrolysis", "quantitative", "calculations"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Mass formula",
        instruction: "Mass deposited: m = (Q × M) / (n × F). What is M?",
        expected_answer: "molar mass|atomic mass",
        explanation: "M = molar mass of substance (g/mol). Q = charge, n = electrons per ion, F = 96,500.",
        hints: ["Molar mass", "Atomic mass", "g/mol"]
      },
      {
        step_number: 2,
        title: "Calculate mass of Ag",
        instruction: "Q = 9650 C, Ag⁺ + e⁻ → Ag (n=1), M(Ag) = 108 g/mol, F = 96,500. Calculate mass of Ag deposited (in g).",
        expected_answer: "10.8|10.8 g",
        explanation: "m = (Q × M)/(n × F) = (9650 × 108)/(1 × 96,500) = 1,042,200/96,500 = 10.8 g.",
        hints: ["m = QM/nF", "(9650 × 108)/(96,500)", "10.8 g"]
      },
      {
        step_number: 3,
        title: "Calculate mass of Al",
        instruction: "Same Q = 9650 C, Al³⁺ + 3e⁻ → Al (n=3), M(Al) = 27 g/mol. Calculate mass of Al (in g).",
        expected_answer: "0.9|0.9 g",
        explanation: "m = (9650 × 27)/(3 × 96,500) = 260,550/289,500 = 0.9 g. Al needs 3e⁻, so less mass than Ag.",
        hints: ["n = 3 for Al³⁺", "(9650 × 27)/(3 × 96,500)", "0.9 g"]
      },
      {
        step_number: 4,
        title: "Volume of gas at STP",
        instruction: "If 1 mole e⁻ passed produces 0.5 mol H₂ (2H⁺ + 2e⁻ → H₂), what volume at STP (22.4 L/mol)?",
        expected_answer: "11.2|11.2 L",
        explanation: "0.5 mol H₂ × 22.4 L/mol = 11.2 L at STP. Each mole e⁻ gives 0.5 mol H₂.",
        hints: ["0.5 mol H₂", "STP: 22.4 L/mol", "0.5 × 22.4"]
      },
      {
        step_number: 5,
        title: "Comparing depositions",
        instruction: "For same Q, does Ag⁺ (n=1) deposit more or less mass than Cu²⁺ (n=2) if M values are similar?",
        expected_answer: "more",
        explanation: "Ag⁺ deposits MORE (n=1 smaller denominator). Mass ∝ 1/n. Smaller charge → more mass for same Q.",
        hints: ["Mass ∝ 1/n", "Ag⁺ needs 1e⁻", "More mass"]
      }
    ],
    validation_rules: {
      mass_calculation: "Correct m = QM/nF application",
      volume_calculation: "Accurate gas volume at STP",
      comparative_analysis: "Understanding n effect on mass"
    },
    success_criteria: "All 5 quantitative electrolysis problems solved",
    points_reward: 150,
    max_attempts: 5
  },

  # Lab 39: Electrochemical Series and Reactivity
  {
    title: "Electrochemical Series - Predicting Reactions",
    description: "Use electrochemical series to predict spontaneous redox reactions",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "electrochemical-series", "reactivity", "predictions"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Series arrangement",
        instruction: "In electrochemical series, species are arranged in order of:",
        expected_answer: "reduction potential|E° values",
        explanation: "Arranged by increasing reduction potential (E°). Top: strong reducing agents (low E°). Bottom: strong oxidizing agents (high E°).",
        hints: ["Reduction potential", "E° order", "Standard potential"]
      },
      {
        step_number: 2,
        title: "Predicting spontaneity",
        instruction: "For spontaneous reaction, E°cell must be:",
        expected_answer: "positive|> 0",
        explanation: "E°cell > 0 for spontaneous reaction. Species with higher E° (oxidizing agent) oxidizes species with lower E° (reducing agent).",
        hints: ["Positive E°cell", "> 0", "Spontaneous"]
      },
      {
        step_number: 3,
        title: "Displacement reaction",
        instruction: "Can Zn (E° = -0.76 V) reduce Cu²⁺ (E° = +0.34 V)? Yes or no?",
        expected_answer: "yes",
        explanation: "YES. E°cell = 0.34 - (-0.76) = +1.10 V > 0. Spontaneous. Zn displaces Cu from Cu²⁺.",
        hints: ["Calculate E°cell", "Positive value", "Yes, spontaneous"]
      },
      {
        step_number: 4,
        title: "Reverse reaction",
        instruction: "Can Cu reduce Zn²⁺? Yes or no?",
        expected_answer: "no",
        explanation: "NO. E°cell = -0.76 - 0.34 = -1.10 V < 0. Non-spontaneous. Reverse of spontaneous reaction is non-spontaneous.",
        hints: ["Negative E°cell", "Non-spontaneous", "No"]
      },
      {
        step_number: 5,
        title: "Strongest oxidizing agent",
        instruction: "Which has higher reduction potential: F₂/F⁻ (+2.87 V) or Cl₂/Cl⁻ (+1.36 V)? Which is stronger oxidizing agent?",
        expected_answer: "F₂|fluorine",
        explanation: "F₂ has higher E° (+2.87 V) → STRONGEST oxidizing agent. Highest reduction potential = strongest oxidizer.",
        hints: ["Higher E°", "F₂", "Most positive"]
      }
    ],
    validation_rules: {
      series_understanding: "Correct interpretation of electrochemical series",
      spontaneity_prediction: "Accurate reaction prediction from E° values",
      agent_identification: "Proper identification of strongest oxidizing/reducing agents"
    },
    success_criteria: "All 5 electrochemical series problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 40: Batteries and Fuel Cells
  {
    title: "Batteries and Fuel Cells - Commercial Applications",
    description: "Understand working principles of different types of batteries and fuel cells",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["electrochemistry", "batteries", "fuel-cells", "applications"],
    category: "Electrochemistry",
    steps: [
      {
        step_number: 1,
        title: "Primary vs secondary cells",
        instruction: "Can primary cells be recharged?",
        expected_answer: "no",
        explanation: "Primary cells: NOT rechargeable (irreversible reactions). Examples: dry cell, alkaline cell. Secondary cells: rechargeable (reversible).",
        hints: ["One-time use", "Not rechargeable", "No"]
      },
      {
        step_number: 2,
        title: "Lead-acid battery",
        instruction: "Lead-acid battery (car battery) is a primary or secondary cell?",
        expected_answer: "secondary|rechargeable",
        explanation: "SECONDARY (rechargeable). Reactions: Pb + PbO₂ + H₂SO₄ ⇌ PbSO₄. Reversible by applying external voltage.",
        hints: ["Rechargeable", "Car battery", "Secondary"]
      },
      {
        step_number: 3,
        title: "Dry cell electrolyte",
        instruction: "Common dry cell (Leclanché cell) uses which paste electrolyte?",
        expected_answer: "NH₄Cl|ammonium chloride",
        explanation: "Dry cell: NH₄Cl paste electrolyte. Anode: Zn, Cathode: carbon rod + MnO₂. ~1.5 V, non-rechargeable.",
        hints: ["Ammonium chloride", "Paste", "NH₄Cl"]
      },
      {
        step_number: 4,
        title: "Fuel cell principle",
        instruction: "In hydrogen-oxygen fuel cell, the products are:",
        expected_answer: "water|H₂O",
        explanation: "H₂ + O₂ → H₂O. Clean energy: only product is water. Continuous fuel supply (not like batteries with fixed reactants).",
        hints: ["H₂ + O₂", "Water", "Clean product"]
      },
      {
        step_number: 5,
        title: "Fuel cell advantage",
        instruction: "Main advantage of fuel cell over battery is:",
        expected_answer: "continuous operation|refuelable|no recharging",
        explanation: "Continuous operation as long as fuel supplied. No recharging needed (unlike batteries). High efficiency (~60%), clean (H₂O product).",
        hints: ["Continuous supply", "No recharging", "Keep adding fuel"]
      }
    ],
    validation_rules: {
      cell_classification: "Correct primary/secondary classification",
      battery_knowledge: "Understanding different battery types",
      fuel_cell_concept: "Grasp of fuel cell advantages"
    },
    success_criteria: "All 5 battery and fuel cell problems solved",
    points_reward: 100,
    max_attempts: 5
  }
]

# Create electrochemistry labs
puts "\nCreating Electrochemistry Labs (31-40)..."
electrochemistry_labs.each_with_index do |lab_data, index|
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
    order_index: index + 31
  )
  puts "  ✓ Lab #{index + 31} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "Electrochemistry Labs (31-40) Complete!"
puts "="*80
puts "Created: 10 electrochemistry labs"
puts "Time: ~#{electrochemistry_labs.sum { |l| l[:estimated_minutes] }} minutes"
puts "Points: #{electrochemistry_labs.sum { |l| l[:points_reward] }}"
puts "="*80
puts "\nReady to create Solutions labs (41-45)..."
puts "="*80

# ============================================================================
# CATEGORY 6: SOLUTIONS (Labs 41-45)
# ============================================================================

solutions_labs = [
  # Lab 41: Molarity, Molality, and Mole Fraction
  {
    title: "Solution Concentration - Molarity, Molality, and Mole Fraction",
    description: "Calculate and interconvert between different concentration units",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["solutions", "molarity", "molality", "mole-fraction", "concentration"],
    category: "Solutions",
    steps: [
      {
        step_number: 1,
        title: "Molarity definition",
        instruction: "Molarity (M) is defined as moles of solute per:",
        expected_answer: "liter of solution|L solution",
        explanation: "Molarity (M) = moles solute / liters of SOLUTION. Temperature dependent (volume changes with T).",
        hints: ["Moles per liter", "Solution volume", "mol/L"]
      },
      {
        step_number: 2,
        title: "Calculate molarity",
        instruction: "4 moles NaCl dissolved in water to make 2 L solution. Calculate molarity.",
        expected_answer: "2|2 M",
        explanation: "M = moles/volume = 4 mol / 2 L = 2 M.",
        hints: ["M = n/V", "4/2", "2 M"]
      },
      {
        step_number: 3,
        title: "Molality definition",
        instruction: "Molality (m) is defined as moles of solute per:",
        expected_answer: "kilogram of solvent|kg solvent",
        explanation: "Molality (m) = moles solute / kg of SOLVENT. Temperature independent (mass doesn't change with T).",
        hints: ["Moles per kg", "Solvent mass", "mol/kg"]
      },
      {
        step_number: 4,
        title: "Calculate molality",
        instruction: "2 moles glucose in 500 g water. Calculate molality.",
        expected_answer: "4|4 m",
        explanation: "m = moles/kg solvent = 2 mol / 0.5 kg = 4 m (molal). Convert g to kg: 500 g = 0.5 kg.",
        hints: ["m = n/kg", "500 g = 0.5 kg", "2/0.5"]
      },
      {
        step_number: 5,
        title: "Mole fraction",
        instruction: "Solution: 1 mol NaCl + 9 mol water. Mole fraction of NaCl is:",
        expected_answer: "0.1",
        explanation: "χ(NaCl) = moles NaCl / total moles = 1/(1+9) = 1/10 = 0.1. Dimensionless, ranges 0-1.",
        hints: ["Part / whole", "1/(1+9)", "0.1"]
      }
    ],
    validation_rules: {
      molarity_calculation: "Correct M = n/V calculations",
      molality_calculation: "Accurate m = n/kg calculations",
      mole_fraction: "Proper χ = n_i/n_total calculations"
    },
    success_criteria: "All 5 concentration unit problems solved",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 42: Raoult's Law and Vapor Pressure
  {
    title: "Raoult's Law - Vapor Pressure of Solutions",
    description: "Apply Raoult's law to calculate vapor pressure lowering",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["solutions", "raoult-law", "vapor-pressure", "colligative"],
    category: "Solutions",
    steps: [
      {
        step_number: 1,
        title: "Raoult's law statement",
        instruction: "Raoult's law: P_solution = χ_solvent × P°_solvent. What is P°?",
        expected_answer: "vapor pressure of pure solvent",
        explanation: "P° = vapor pressure of PURE solvent. P_solution < P° (vapor pressure lowering due to solute).",
        hints: ["Pure solvent", "Vapor pressure", "P°"]
      },
      {
        step_number: 2,
        title: "Vapor pressure lowering",
        instruction: "Adding non-volatile solute (increases/decreases) vapor pressure?",
        expected_answer: "decreases",
        explanation: "DECREASES vapor pressure. Solute particles occupy surface, fewer solvent molecules escape. ΔP = P° - P.",
        hints: ["Colligative property", "Decreases", "Lower vapor pressure"]
      },
      {
        step_number: 3,
        title: "Calculate vapor pressure",
        instruction: "χ(water) = 0.9, P°(water) = 100 mmHg. Calculate P_solution.",
        expected_answer: "90|90 mmHg",
        explanation: "P_solution = χ_solvent × P° = 0.9 × 100 = 90 mmHg. Vapor pressure lowered by 10 mmHg.",
        hints: ["P = χ × P°", "0.9 × 100", "90 mmHg"]
      },
      {
        step_number: 4,
        title: "Vapor pressure lowering",
        instruction: "ΔP = P° - P_solution. From above, calculate ΔP.",
        expected_answer: "10|10 mmHg",
        explanation: "ΔP = 100 - 90 = 10 mmHg. Also: ΔP = χ_solute × P° = 0.1 × 100 = 10 mmHg.",
        hints: ["ΔP = P° - P", "100 - 90", "10 mmHg"]
      },
      {
        step_number: 5,
        title: "Relative lowering",
        instruction: "Relative lowering = ΔP/P° = χ_solute. For above case, relative lowering = ?",
        expected_answer: "0.1|10%",
        explanation: "ΔP/P° = 10/100 = 0.1 = 10%. Also equal to χ_solute = 0.1. Important colligative property relationship.",
        hints: ["ΔP/P°", "10/100", "0.1"]
      }
    ],
    validation_rules: {
      raoult_law_application: "Correct P = χP° calculations",
      vapor_pressure_lowering: "Accurate ΔP calculations",
      relative_lowering: "Understanding ΔP/P° = χ_solute"
    },
    success_criteria: "All 5 Raoult's law problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 43: Colligative Properties - Boiling Point and Freezing Point
  {
    title: "Colligative Properties - ΔT_b and ΔT_f Calculations",
    description: "Calculate boiling point elevation and freezing point depression",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["solutions", "colligative", "boiling-point", "freezing-point"],
    category: "Solutions",
    steps: [
      {
        step_number: 1,
        title: "Colligative properties",
        instruction: "Colligative properties depend on (number/type) of solute particles?",
        expected_answer: "number",
        explanation: "NUMBER of solute particles, NOT type. Examples: vapor pressure lowering, ΔT_b, ΔT_f, osmotic pressure.",
        hints: ["Number of particles", "Not identity", "Quantity matters"]
      },
      {
        step_number: 2,
        title: "Boiling point elevation",
        instruction: "The formula is: ΔT_b = K_b × m. What is K_b?",
        expected_answer: "ebullioscopic constant|molal boiling point constant",
        explanation: "K_b = ebullioscopic constant (molal boiling point elevation constant). Depends on solvent only.",
        hints: ["Boiling point constant", "K_b", "Solvent-specific"]
      },
      {
        step_number: 3,
        title: "Calculate ΔT_b",
        instruction: "1 molal solution in water (K_b = 0.52 °C/m). Calculate ΔT_b.",
        expected_answer: "0.52|0.52 °C",
        explanation: "ΔT_b = K_b × m = 0.52 × 1 = 0.52 °C. Boiling point increases by 0.52°C.",
        hints: ["ΔT_b = K_b × m", "0.52 × 1", "0.52 °C"]
      },
      {
        step_number: 4,
        title: "Freezing point depression",
        instruction: "ΔT_f = K_f × m. For same 1 molal solution in water (K_f = 1.86 °C/m), calculate ΔT_f.",
        expected_answer: "1.86|1.86 °C",
        explanation: "ΔT_f = K_f × m = 1.86 × 1 = 1.86 °C. Freezing point DECREASES by 1.86°C (depression).",
        hints: ["ΔT_f = K_f × m", "1.86 × 1", "1.86 °C"]
      },
      {
        step_number: 5,
        title: "New freezing point",
        instruction: "Pure water freezes at 0°C. With ΔT_f = 1.86°C, new freezing point is:",
        expected_answer: "-1.86|-1.86 °C",
        explanation: "T_f(solution) = 0 - 1.86 = -1.86°C. Depression means LOWER freezing point. Negative temperature.",
        hints: ["0 - 1.86", "Depression = lower", "-1.86°C"]
      }
    ],
    validation_rules: {
      colligative_concept: "Understanding particle number dependence",
      delta_t_calculations: "Correct ΔT_b and ΔT_f calculations",
      new_temperature: "Accurate new boiling/freezing point"
    },
    success_criteria: "All 5 colligative property problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 44: Osmotic Pressure Calculations
  {
    title: "Osmotic Pressure - van't Hoff Equation",
    description: "Calculate osmotic pressure using π = CRT equation",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["solutions", "osmotic-pressure", "colligative", "vant-hoff"],
    category: "Solutions",
    steps: [
      {
        step_number: 1,
        title: "Osmotic pressure definition",
        instruction: "Osmotic pressure is pressure required to stop:",
        expected_answer: "osmosis|solvent flow",
        explanation: "Pressure needed to STOP osmosis (solvent flow from dilute to concentrated through semipermeable membrane).",
        hints: ["Stop osmosis", "Pressure", "Solvent movement"]
      },
      {
        step_number: 2,
        title: "van't Hoff equation",
        instruction: "The osmotic pressure equation is: π = CRT or π = nRT/V?",
        expected_answer: "π = CRT|both",
        explanation: "π = CRT (where C = molarity = n/V). Also: π = nRT/V. Similar to ideal gas law PV = nRT.",
        hints: ["π = CRT", "Ideal gas-like", "C is molarity"]
      },
      {
        step_number: 3,
        title: "Calculate osmotic pressure",
        instruction: "0.1 M solution at 300 K. Calculate π (R = 0.0821 L·atm/(mol·K), in atm).",
        expected_answer: "2.46|2.463|2.5",
        explanation: "π = CRT = 0.1 × 0.0821 × 300 = 2.463 atm ≈ 2.46 atm.",
        hints: ["π = CRT", "0.1 × 0.0821 × 300", "≈ 2.46 atm"]
      },
      {
        step_number: 4,
        title: "Comparing colligative properties",
        instruction: "Which is most sensitive to low concentrations: ΔT_f (~2°C) or π (~2 atm)?",
        expected_answer: "π|osmotic pressure",
        explanation: "OSMOTIC PRESSURE (π) most sensitive. 2 atm is easily measurable, 2°C is small. π used for molar mass determination of polymers.",
        hints: ["2 atm more measurable than 2°C", "Osmotic pressure", "Most sensitive"]
      },
      {
        step_number: 5,
        title: "Molar mass from π",
        instruction: "π = (mass/M)RT/V. Rearrange to solve for M (molar mass).",
        expected_answer: "M = massRT/(πV)|mRT/πV",
        explanation: "M = (mass × R × T)/(π × V). Measure π to find molar mass M. Useful for large molecules (proteins, polymers).",
        hints: ["Rearrange for M", "M = mRT/πV", "Useful for polymers"]
      }
    ],
    validation_rules: {
      osmotic_pressure_concept: "Understanding osmosis and π",
      vant_hoff_application: "Correct π = CRT calculations",
      molar_mass_determination: "Understanding π method for M"
    },
    success_criteria: "All 5 osmotic pressure problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 45: van't Hoff Factor and Electrolytes
  {
    title: "van't Hoff Factor i - Colligative Properties of Electrolytes",
    description: "Calculate colligative properties using van't Hoff factor for electrolytes",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["solutions", "vant-hoff-factor", "electrolytes", "colligative"],
    category: "Solutions",
    steps: [
      {
        step_number: 1,
        title: "van't Hoff factor definition",
        instruction: "van't Hoff factor i = (actual number of particles)/(formula units dissolved). For non-electrolyte, i = ?",
        expected_answer: "1",
        explanation: "Non-electrolyte (like glucose): i = 1 (doesn't dissociate). Each molecule stays intact.",
        hints: ["No dissociation", "One particle", "i = 1"]
      },
      {
        step_number: 2,
        title: "i for NaCl",
        instruction: "Ideal i for NaCl (Na⁺ + Cl⁻) is:",
        expected_answer: "2",
        explanation: "NaCl → Na⁺ + Cl⁻ (2 ions). Ideal i = 2. Each formula unit gives 2 particles.",
        hints: ["2 ions", "Na⁺ and Cl⁻", "i = 2"]
      },
      {
        step_number: 3,
        title: "i for CaCl₂",
        instruction: "Ideal i for CaCl₂ (Ca²⁺ + 2Cl⁻) is:",
        expected_answer: "3",
        explanation: "CaCl₂ → Ca²⁺ + 2Cl⁻ (3 ions). Ideal i = 3. Each formula unit gives 3 particles.",
        hints: ["1 Ca²⁺ + 2 Cl⁻", "3 ions", "i = 3"]
      },
      {
        step_number: 4,
        title: "Modified colligative equations",
        instruction: "For electrolytes, ΔT_f = i × K_f × m. If 1 molal NaCl (i=2, K_f=1.86), calculate ΔT_f.",
        expected_answer: "3.72|3.72 °C",
        explanation: "ΔT_f = i × K_f × m = 2 × 1.86 × 1 = 3.72 °C. TWICE the depression of non-electrolyte.",
        hints: ["Include i factor", "2 × 1.86 × 1", "3.72 °C"]
      },
      {
        step_number: 5,
        title: "Actual vs ideal i",
        instruction: "For real electrolytes, actual i is (greater than/less than/equal to) ideal i?",
        expected_answer: "less than",
        explanation: "Actual i < ideal i due to ION PAIRING. Some ions associate, reducing effective particle count. Example: NaCl actual i ≈ 1.9 (not 2).",
        hints: ["Ion pairing", "Less than ideal", "Association"]
      }
    ],
    validation_rules: {
      vant_hoff_concept: "Understanding i for electrolytes",
      dissociation_particles: "Correct ion count calculation",
      modified_equations: "Proper use of i in colligative formulas"
    },
    success_criteria: "All 5 van't Hoff factor problems solved",
    points_reward: 150,
    max_attempts: 5
  }
]

# Create solutions labs
puts "\nCreating Solutions Labs (41-45)..."
solutions_labs.each_with_index do |lab_data, index|
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
    order_index: index + 41
  )
  puts "  ✓ Lab #{index + 41} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "🎉 Physical Chemistry Labs - Part 3 COMPLETE! 🎉"
puts "="*80
puts "Created: 15 comprehensive numerical labs (Labs 31-45)"
puts ""
puts "Category 5: Electrochemistry (Labs 31-40, 10 labs)"
puts "  • Oxidation numbers, galvanic cells, E°cell"
puts "  • Nernst equation, ΔG° and K relationships"
puts "  • Concentration cells, electrolysis, Faraday's laws"
puts "  • Electrochemical series, batteries and fuel cells"
puts "  • Time: ~305 minutes, Points: 1,310"
puts ""
puts "Category 6: Solutions (Labs 41-45, 5 labs)"
puts "  • Concentration units: M, m, χ"
puts "  • Raoult's law, vapor pressure lowering"
puts "  • Boiling point elevation, freezing point depression"
puts "  • Osmotic pressure, van't Hoff factor"
puts "  • Time: ~155 minutes, Points: 640"
puts ""
puts "TOTAL Part 3: 15 labs, ~460 minutes (~7.7 hours), 1,950 points"
puts "="*80
puts "\n🎊 COMPLETE PHYSICAL CHEMISTRY LAB SUITE (45 LABS) 🎊"
puts "="*80
puts ""
puts "📊 GRAND TOTAL SUMMARY:"
puts "Part 1 (Labs 1-15):  Thermodynamics & Kinetics"
puts "  • 15 labs, ~495 min (~8.25 hrs), 2,025 points"
puts ""
puts "Part 2 (Labs 16-30): Chemical & Ionic Equilibrium"
puts "  • 15 labs, ~490 min (~8.2 hrs), 2,005 points"
puts ""
puts "Part 3 (Labs 31-45): Electrochemistry & Solutions"
puts "  • 15 labs, ~460 min (~7.7 hrs), 1,950 points"
puts ""
puts "="*80
puts "COMPLETE SUITE: 45 labs, ~1,445 minutes (~24 hours), 5,980 points"
puts "="*80
puts ""
puts "✅ All Physical Chemistry Labs Complete!"
puts "✅ Comprehensive coverage of IIT JEE Physical Chemistry"
puts "✅ Ready for student use and assessment"
puts "="*80

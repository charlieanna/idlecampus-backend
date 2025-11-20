# frozen_string_literal: true

# ========================================
# Inorganic Chemistry Hands-On Problem Labs
# ========================================
# Interactive problem-solving labs for IIT JEE Inorganic Chemistry
# Pattern: Similar to Docker labs but for chemistry problems
# Progressive difficulty: easy → medium → hard
# ========================================

puts "\n" + "=" * 80
puts "🧪 SEEDING INORGANIC CHEMISTRY HANDS-ON LABS"
puts "=" * 80

# Clear existing chemistry labs if any
# HandsOnLab.where(lab_type: 'chemistry_problem').destroy_all

puts "✅ Ready to create chemistry problem labs"

inorganic_labs = [
  # ========================================
  # BASICS LABS (1-5) - Foundational Skills
  # ========================================

  {
    title: "Writing Chemical Formulas from Names",
    description: "Master the skill of writing correct chemical formulas from compound names",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "basics",
    certification_exam: nil,
    learning_objectives: "Write chemical formulas from IUPAC names, understand valency and ionic charges",
    prerequisites: ["Basic understanding of periodic table", "Knowledge of common ions"],
    steps: [
      {
        step_number: 1,
        title: "Simple binary ionic compounds",
        instruction: "Write the formula for Sodium chloride",
        expected_answer: "NaCl",
        explanation: "Na⁺ (charge +1) and Cl⁻ (charge -1) combine in 1:1 ratio",
        hints: ["Sodium has +1 charge", "Chloride has -1 charge", "Cross-multiply charges"]
      },
      {
        step_number: 2,
        title: "Compounds with polyatomic ions",
        instruction: "Write the formula for Calcium sulfate",
        expected_answer: "CaSO4|CaSO₄",
        explanation: "Ca²⁺ and SO₄²⁻ combine in 1:1 ratio to give CaSO₄",
        hints: ["Calcium has +2 charge", "Sulfate is SO₄²⁻", "Charges are equal, ratio is 1:1"]
      },
      {
        step_number: 3,
        title: "Compounds requiring brackets",
        instruction: "Write the formula for Calcium hydroxide",
        expected_answer: "Ca(OH)2|Ca(OH)₂",
        explanation: "Ca²⁺ needs 2 OH⁻ ions, so Ca(OH)₂. Brackets are needed for polyatomic ions with subscript > 1",
        hints: ["Calcium has +2 charge", "Hydroxide is OH⁻", "Use brackets for (OH)₂"]
      },
      {
        step_number: 4,
        title: "Transition metal compounds",
        instruction: "Write the formula for Iron(III) oxide",
        expected_answer: "Fe2O3|Fe₂O₃",
        explanation: "Fe³⁺ and O²⁻ in 2:3 ratio (cross-multiply: Fe₂O₃)",
        hints: ["Iron(III) means Fe³⁺", "Oxide is O²⁻", "Cross-multiply: 2 Fe and 3 O"]
      },
      {
        step_number: 5,
        title: "Hydrated salts",
        instruction: "Write the formula for Copper(II) sulfate pentahydrate",
        expected_answer: "CuSO4.5H2O|CuSO₄·5H₂O",
        explanation: "CuSO₄ with 5 water molecules of crystallization: CuSO₄·5H₂O",
        hints: ["First write CuSO₄", "Pentahydrate means 5H₂O", "Use dot notation"]
      }
    ],
    validation_rules: {
      correct_elements: "All elements must be correctly identified",
      correct_subscripts: "Subscripts must be in lowest whole number ratio",
      proper_notation: "Use brackets where necessary"
    },
    success_criteria: "All 5 formulas written correctly",
    points_reward: 100,
    max_attempts: 5,
    is_active: true
  },

  {
    title: "Naming Coordination Compounds - IUPAC Rules",
    description: "Learn systematic IUPAC nomenclature for coordination complexes",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "coordination_chemistry",
    learning_objectives: "Master IUPAC naming rules for coordination compounds, identify ligands and metal centers",
    prerequisites: ["Understanding of coordination chemistry basics", "Knowledge of ligand names"],
    steps: [
      {
        step_number: 1,
        title: "Simple neutral complex",
        instruction: "Name the complex: [Co(NH₃)₆]Cl₃",
        expected_answer: "Hexaamminecobalt(III) chloride",
        explanation: "6 NH₃ ligands (hexaammine), Co in +3 state, 3 Cl⁻ outside",
        hints: ["6 ammines = hexaammine", "Calculate Co oxidation state", "Cation named first"]
      },
      {
        step_number: 2,
        title: "Anionic complex",
        instruction: "Name the complex: K₄[Fe(CN)₆]",
        expected_answer: "Potassium hexacyanoferrate(II)|Potassium hexacyanidoferrate(II)",
        explanation: "Anionic complex uses -ate suffix: ferrate. 6 CN⁻ = hexacyano, Fe is +2",
        hints: ["Anionic complex = -ate suffix", "6 cyano = hexacyano", "K₄ outside, Fe is +2"]
      },
      {
        step_number: 3,
        title: "Mixed ligands",
        instruction: "Name the complex: [Pt(NH₃)₂Cl₂]",
        expected_answer: "Diamminedichloroplatinum(II)|Diamminedichloridoplatinum(II)",
        explanation: "Ligands in alphabetical order: ammine before chloro. Pt is +2",
        hints: ["Alphabetical: a before c", "2 NH₃ = diammine", "2 Cl = dichloro"]
      },
      {
        step_number: 4,
        title: "Complex with water ligands",
        instruction: "Name the complex: [Cr(H₂O)₆]Cl₃",
        expected_answer: "Hexaaquachromium(III) chloride",
        explanation: "H₂O ligands are called 'aqua'. 6 water molecules = hexaaqua, Cr is +3",
        hints: ["Water ligand = aqua", "6 aqua = hexaaqua", "Cr oxidation state is +3"]
      },
      {
        step_number: 5,
        title: "Complex with bidentate ligand",
        instruction: "Name the complex: [Co(en)₃]Cl₃ (en = ethylenediamine)",
        expected_answer: "Tris(ethylenediamine)cobalt(III) chloride",
        explanation: "For complex ligands, use bis/tris. 3 en ligands = tris(ethylenediamine), Co is +3",
        hints: ["Use 'tris' for 3 complex ligands", "Put ligand name in brackets", "Co is +3"]
      }
    ],
    validation_rules: {
      ligand_order: "Ligands must be in alphabetical order",
      oxidation_state: "Oxidation state must be correct",
      suffix_usage: "Correct use of -ate for anionic complexes"
    },
    success_criteria: "All 5 compounds named correctly following IUPAC rules",
    points_reward: 150,
    max_attempts: 5,
    is_active: true
  },

  {
    title: "Calculating Oxidation States in Compounds",
    description: "Master the technique of determining oxidation states of elements in compounds",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "basics",
    learning_objectives: "Calculate oxidation states using charge balance, apply oxidation state rules",
    prerequisites: ["Understanding of oxidation state concept", "Basic algebra"],
    steps: [
      {
        step_number: 1,
        title: "Simple ionic compound",
        instruction: "Find the oxidation state of S in Na₂SO₄",
        expected_answer: "+6|6",
        explanation: "Na is +1, O is -2. Let S be x. 2(+1) + x + 4(-2) = 0, so x = +6",
        hints: ["Na is always +1", "O is usually -2", "Total charge = 0"]
      },
      {
        step_number: 2,
        title: "Transition metal complex",
        instruction: "Find the oxidation state of Cr in K₂Cr₂O₇",
        expected_answer: "+6|6",
        explanation: "K is +1, O is -2. Let Cr be x. 2(+1) + 2x + 7(-2) = 0, so x = +6",
        hints: ["K is +1, O is -2", "There are 2 Cr atoms", "Solve: 2 + 2x - 14 = 0"]
      },
      {
        step_number: 3,
        title: "Compound with hydrogen",
        instruction: "Find the oxidation state of N in NH₃",
        expected_answer: "-3|-3",
        explanation: "H is +1 (in compounds with non-metals). Let N be x. x + 3(+1) = 0, so x = -3",
        hints: ["H is +1 here", "Molecule is neutral", "Solve: x + 3 = 0"]
      },
      {
        step_number: 4,
        title: "Peroxide compound",
        instruction: "Find the oxidation state of O in H₂O₂",
        expected_answer: "-1|-1",
        explanation: "In peroxides, O is -1 (not -2). H is +1. Check: 2(+1) + 2(-1) = 0 ✓",
        hints: ["This is a peroxide", "O in peroxides is -1", "H is +1"]
      },
      {
        step_number: 5,
        title: "Complex ion",
        instruction: "Find the oxidation state of Mn in MnO₄⁻",
        expected_answer: "+7|7",
        explanation: "O is -2, total charge is -1. Let Mn be x. x + 4(-2) = -1, so x = +7",
        hints: ["O is -2", "Total charge is -1 (not 0)", "Solve: x - 8 = -1"]
      }
    ],
    validation_rules: {
      charge_balance: "Sum of oxidation states must equal total charge",
      sign_included: "Include + or - sign with answer"
    },
    success_criteria: "All oxidation states calculated correctly",
    points_reward: 100,
    max_attempts: 5,
    is_active: true
  },

  {
    title: "VSEPR Theory - Predicting Molecular Geometry",
    description: "Use VSEPR theory to predict shapes of molecules and ions",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "chemical_bonding",
    learning_objectives: "Apply VSEPR theory, count bonding and lone pairs, predict 3D geometry",
    prerequisites: ["Lewis structures", "Understanding of VSEPR theory"],
    steps: [
      {
        step_number: 1,
        title: "Simple molecule - no lone pairs",
        instruction: "Predict the shape of CH₄ (methane)",
        expected_answer: "Tetrahedral|tetrahedral",
        explanation: "C has 4 bonding pairs, 0 lone pairs. Steric number = 4, shape = Tetrahedral, bond angle = 109.5°",
        hints: ["Count bonds around C", "No lone pairs on C", "4 bonds = tetrahedral"]
      },
      {
        step_number: 2,
        title: "Molecule with 1 lone pair",
        instruction: "Predict the shape of NH₃ (ammonia)",
        expected_answer: "Trigonal pyramidal|trigonal pyramidal|pyramidal",
        explanation: "N has 3 bonding pairs, 1 lone pair. Steric number = 4, shape = Trigonal pyramidal, angle ≈ 107°",
        hints: ["N has 5 valence electrons", "3 bonds + 1 lone pair", "Shape is pyramidal"]
      },
      {
        step_number: 3,
        title: "Molecule with 2 lone pairs",
        instruction: "Predict the shape of H₂O (water)",
        expected_answer: "Bent|bent|V-shaped|angular",
        explanation: "O has 2 bonding pairs, 2 lone pairs. Steric number = 4, shape = Bent, angle ≈ 104.5°",
        hints: ["O has 6 valence electrons", "2 bonds + 2 lone pairs", "Shape is bent"]
      },
      {
        step_number: 4,
        title: "Expanded octet",
        instruction: "Predict the shape of PCl₅",
        expected_answer: "Trigonal bipyramidal|trigonal bipyramidal",
        explanation: "P has 5 bonding pairs, 0 lone pairs. Steric number = 5, shape = Trigonal bipyramidal",
        hints: ["P can expand octet", "5 Cl atoms = 5 bonds", "Steric number 5"]
      },
      {
        step_number: 5,
        title: "Square planar geometry",
        instruction: "Predict the shape of XeF₄",
        expected_answer: "Square planar|square planar",
        explanation: "Xe has 4 bonding pairs, 2 lone pairs. Steric number = 6, shape = Square planar",
        hints: ["Xe has 8 valence electrons", "4 bonds + 2 lone pairs", "6 electron pairs"]
      }
    ],
    validation_rules: {
      correct_geometry: "Must identify correct 3D shape",
      lone_pairs_considered: "Lone pairs must be accounted for"
    },
    success_criteria: "All 5 geometries predicted correctly",
    points_reward: 150,
    max_attempts: 5,
    is_active: true
  },

  {
    title: "Drawing Lewis Structures",
    description: "Master the art of drawing Lewis dot structures for molecules and ions",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "chemical_bonding",
    learning_objectives: "Draw Lewis structures, identify bonding and lone pairs, apply octet rule",
    prerequisites: ["Valence electrons", "Octet rule", "Formal charge concept"],
    steps: [
      {
        step_number: 1,
        title: "Simple covalent molecule",
        instruction: "Draw Lewis structure for H₂O. How many lone pairs are on oxygen?",
        expected_answer: "2|two",
        explanation: "O has 6 valence e⁻, forms 2 bonds (4 e⁻), leaving 2 lone pairs (4 e⁻). Total = 8 e⁻ (octet)",
        hints: ["O has 6 valence electrons", "Each H contributes 1 electron", "Count non-bonding electrons"]
      },
      {
        step_number: 2,
        title: "Molecule with double bond",
        instruction: "How many bonding electrons are in CO₂ (carbon dioxide)?",
        expected_answer: "8|eight",
        explanation: "C forms 2 double bonds (O=C=O). Each double bond = 4 electrons, so 2×4 = 8 bonding e⁻",
        hints: ["C is central atom", "C needs 4 bonds for octet", "Each O forms double bond"]
      },
      {
        step_number: 3,
        title: "Polyatomic ion",
        instruction: "What is the total number of valence electrons in NH₄⁺ (ammonium ion)?",
        expected_answer: "8|eight",
        explanation: "N (5) + 4H (4) - 1 (positive charge) = 8 total valence electrons",
        hints: ["N has 5, each H has 1", "Total = 5 + 4 = 9", "Subtract 1 for positive charge"]
      },
      {
        step_number: 4,
        title: "Resonance structures",
        instruction: "How many resonance structures does CO₃²⁻ (carbonate) have?",
        expected_answer: "3|three",
        explanation: "Carbonate has 3 equivalent resonance structures (C=O bond can be at any of the 3 oxygen positions)",
        hints: ["C is central, bonded to 3 O", "One C=O, two C-O⁻", "Double bond can rotate"]
      },
      {
        step_number: 5,
        title: "Odd electron molecule",
        instruction: "How many total electrons are in NO (nitric oxide)?",
        expected_answer: "11|eleven",
        explanation: "N (7) + O (8) = 15 electrons total, but only 11 are valence electrons. NO is a free radical",
        hints: ["N has 5 valence e⁻", "O has 6 valence e⁻", "Total = 11 (odd number)"]
      }
    ],
    validation_rules: {
      octet_rule: "Octet rule should be satisfied (except valid exceptions)",
      formal_charges: "Formal charges should be minimized",
      total_electrons: "Total electrons must be correct"
    },
    success_criteria: "All Lewis structure questions answered correctly",
    points_reward: 150,
    max_attempts: 5,
    is_active: true
  },

  # ========================================
  # s-BLOCK LABS (6-8) - Alkali & Alkaline Earth Metals
  # ========================================

  {
    title: "Identifying Alkali Metal Compounds and Reactions",
    description: "Predict products and identify alkali metal compounds based on properties",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "s_block_elements",
    learning_objectives: "Identify alkali metal compounds, predict reaction products, understand periodic trends",
    prerequisites: ["Properties of Group 1 elements", "Basic chemical equations"],
    steps: [
      {
        step_number: 1,
        title: "Flame color identification",
        instruction: "Which alkali metal produces a golden yellow flame?",
        expected_answer: "Sodium|Na|sodium",
        explanation: "Sodium imparts golden yellow color to flame (589 nm). Li = crimson, K = lilac, Rb = red-violet, Cs = blue",
        hints: ["Common alkali metal", "Famous for yellow flame", "Atomic number 11"]
      },
      {
        step_number: 2,
        title: "Oxide formation",
        instruction: "What type of oxide does potassium form when heated in excess oxygen?",
        expected_answer: "Superoxide|superoxide|KO2",
        explanation: "K forms superoxide (KO₂). Li forms normal oxide (Li₂O), Na forms peroxide (Na₂O₂), K/Rb/Cs form superoxides",
        hints: ["Heavier alkali metals", "Contains O₂⁻ ion", "Formula is KO₂"]
      },
      {
        step_number: 3,
        title: "Reaction with water",
        instruction: "Balance: Na + H₂O → ? + ?",
        expected_answer: "2 Na + 2 H2O -> 2 NaOH + H2|NaOH + H2|sodium hydroxide + hydrogen",
        explanation: "2Na + 2H₂O → 2NaOH + H₂↑. Alkali metals react with water to form hydroxides and hydrogen gas",
        hints: ["Products are base + gas", "Na forms NaOH", "H₂ gas is released"]
      },
      {
        step_number: 4,
        title: "Solubility in ammonia",
        instruction: "What color do dilute solutions of alkali metals in liquid ammonia show?",
        expected_answer: "Blue|blue",
        explanation: "Alkali metals dissolve in liquid NH₃ to give blue solutions (due to ammoniated electrons). Concentrated solutions are bronze colored",
        hints: ["Characteristic color", "Due to solvated electrons", "Dilute solutions"]
      },
      {
        step_number: 5,
        title: "Anomalous lithium behavior",
        instruction: "When lithium nitrate is heated, what gas(es) are evolved?",
        expected_answer: "NO2 + O2|nitrogen dioxide + oxygen|NO₂ and O₂",
        explanation: "4LiNO₃ → 2Li₂O + 4NO₂ + O₂. Other alkali metal nitrates give nitrites: 2MNO₃ → 2MNO₂ + O₂",
        hints: ["Li is anomalous", "Decomposes to oxide", "Two gases released"]
      }
    ],
    validation_rules: {
      product_identification: "Correct products identified",
      stoichiometry: "Balanced equations where required"
    },
    success_criteria: "All 5 alkali metal problems solved correctly",
    points_reward: 125,
    max_attempts: 5,
    is_active: true
  },

  {
    title: "Alkaline Earth Metals - Reactions and Compounds",
    description: "Solve problems on Group 2 elements, their compounds, and reactions",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "s_block_elements",
    learning_objectives: "Understand alkaline earth metal chemistry, predict trends, solve compound problems",
    prerequisites: ["Properties of Group 2 elements", "Solubility rules"],
    steps: [
      {
        step_number: 1,
        title: "Amphoteric oxide",
        instruction: "Which alkaline earth metal oxide is amphoteric?",
        expected_answer: "BeO|Beryllium oxide|beryllium oxide",
        explanation: "BeO is amphoteric (reacts with both acids and bases). Be is anomalous due to small size",
        hints: ["First element of group", "Anomalous behavior", "Symbol Be"]
      },
      {
        step_number: 2,
        title: "Solubility trend",
        instruction: "Arrange in INCREASING solubility: BaSO₄, CaSO₄, MgSO₄",
        expected_answer: "BaSO4 < CaSO4 < MgSO4|BaSO₄ < CaSO₄ < MgSO₄",
        explanation: "Sulfate solubility DECREASES down group: BaSO₄ (insoluble) < SrSO₄ < CaSO₄ < MgSO₄ < BeSO₄ (soluble)",
        hints: ["Solubility decreases down group", "BaSO₄ is least soluble", "MgSO₄ is most soluble"]
      },
      {
        step_number: 3,
        title: "Plaster of Paris",
        instruction: "What is the chemical formula of Plaster of Paris?",
        expected_answer: "CaSO4.1/2H2O|CaSO₄·½H₂O|(CaSO4)2.H2O",
        explanation: "Plaster of Paris is CaSO₄·½H₂O (calcium sulfate hemihydrate), prepared by heating gypsum at 393 K",
        hints: ["Calcium sulfate with water", "Half molecule of water", "Hemihydrate"]
      },
      {
        step_number: 4,
        title: "Thermal decomposition",
        instruction: "What is the product when CaCO₃ is strongly heated?",
        expected_answer: "CaO + CO2|CaO|calcium oxide + carbon dioxide|quicklime",
        explanation: "CaCO₃ → CaO + CO₂ (at ~1200 K). This is how quicklime is manufactured from limestone",
        hints: ["Decomposition reaction", "Oxide + gas", "Makes quicklime"]
      },
      {
        step_number: 5,
        title: "Diagonal relationship",
        instruction: "Which element shows diagonal relationship with Beryllium?",
        expected_answer: "Aluminium|Al|aluminum",
        explanation: "Be and Al show diagonal relationship. Both form amphoteric oxides, covalent chlorides, and have similar properties",
        hints: ["Diagonal in periodic table", "Group 13", "Symbol Al"]
      }
    ],
    validation_rules: {
      trend_understanding: "Correct trends identified",
      formula_accuracy: "Chemical formulas written correctly"
    },
    success_criteria: "All 5 alkaline earth metal problems solved",
    points_reward: 125,
    max_attempts: 5,
    is_active: true
  },

  {
    title: "Hardness of Water - Identification and Removal",
    description: "Identify types of hardness and methods to remove them",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "s_block_elements",
    learning_objectives: "Distinguish temporary vs permanent hardness, apply removal methods, write relevant equations",
    prerequisites: ["Calcium and magnesium compounds", "Basic precipitation reactions"],
    steps: [
      {
        step_number: 1,
        title: "Identifying hardness type",
        instruction: "Which compound causes TEMPORARY hardness? (a) CaSO₄ (b) Ca(HCO₃)₂ (c) MgCl₂",
        expected_answer: "Ca(HCO3)2|b|calcium bicarbonate|Ca(HCO₃)₂",
        explanation: "Temporary hardness is caused by bicarbonates: Ca(HCO₃)₂ and Mg(HCO₃)₂. Permanent hardness is caused by sulfates and chlorides",
        hints: ["Bicarbonates", "Can be removed by boiling", "Option b"]
      },
      {
        step_number: 2,
        title: "Boiling method",
        instruction: "What happens when Ca(HCO₃)₂ solution is boiled?",
        expected_answer: "CaCO3 precipitate forms|CaCO₃ precipitates|calcium carbonate precipitates",
        explanation: "Ca(HCO₃)₂ → CaCO₃↓ + H₂O + CO₂. Boiling removes temporary hardness by precipitating carbonate",
        hints: ["Decomposition reaction", "Insoluble carbonate", "White precipitate"]
      },
      {
        step_number: 3,
        title: "Clark's method equation",
        instruction: "Balance: Ca(HCO₃)₂ + Ca(OH)₂ → CaCO₃ + H₂O",
        expected_answer: "Ca(HCO3)2 + Ca(OH)2 -> 2 CaCO3 + 2 H2O",
        explanation: "Ca(HCO₃)₂ + Ca(OH)₂ → 2CaCO₃↓ + 2H₂O. Clark's method uses calculated lime to remove temporary hardness",
        hints: ["2 CaCO₃ formed", "2 H₂O formed", "Add lime"]
      },
      {
        step_number: 4,
        title: "Permanent hardness removal",
        instruction: "Which chemical removes permanent hardness? (a) Ca(OH)₂ (b) Na₂CO₃ (c) HCl",
        expected_answer: "Na2CO3|b|washing soda|sodium carbonate",
        explanation: "Na₂CO₃ (washing soda) removes permanent hardness: CaSO₄ + Na₂CO₃ → CaCO₃↓ + Na₂SO₄",
        hints: ["Washing soda method", "Precipitates carbonate", "Option b"]
      },
      {
        step_number: 5,
        title: "Complete removal",
        instruction: "Which method can remove BOTH temporary and permanent hardness?",
        expected_answer: "Ion exchange|ion exchange resin|permutit|zeolite",
        explanation: "Ion exchange (permutit/zeolite) removes both types by replacing Ca²⁺/Mg²⁺ with Na⁺ or H⁺",
        hints: ["Modern method", "Resin-based", "Exchanges ions"]
      }
    ],
    validation_rules: {
      hardness_classification: "Correct identification of hardness types",
      method_application: "Appropriate removal method selected"
    },
    success_criteria: "All water hardness problems solved correctly",
    points_reward: 125,
    max_attempts: 5,
    is_active: true
  },

  # ========================================
  # COORDINATION CHEMISTRY LABS (9-10) - Preview
  # ========================================

  {
    title: "Calculating Coordination Number",
    description: "Determine coordination numbers in various coordination compounds",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "coordination_chemistry",
    learning_objectives: "Calculate coordination number, understand denticity, count donor atoms",
    prerequisites: ["Basic coordination chemistry", "Ligand types"],
    steps: [
      {
        step_number: 1,
        title: "Monodentate ligands",
        instruction: "What is the coordination number in [Co(NH₃)₆]³⁺?",
        expected_answer: "6|six",
        explanation: "6 NH₃ ligands, each monodentate (1 donor atom), so CN = 6",
        hints: ["Count NH₃ molecules", "Each donates 1 electron pair", "NH₃ is monodentate"]
      },
      {
        step_number: 2,
        title: "Bidentate ligands",
        instruction: "What is the coordination number in [Pt(en)₂]²⁺? (en = ethylenediamine, bidentate)",
        expected_answer: "4|four",
        explanation: "2 en ligands, each bidentate (2 donor atoms), so CN = 2×2 = 4",
        hints: ["en is bidentate", "2 en ligands present", "Count total donor atoms"]
      },
      {
        step_number: 3,
        title: "Mixed ligands",
        instruction: "What is the coordination number in [Co(NH₃)₄Cl₂]⁺?",
        expected_answer: "6|six",
        explanation: "4 NH₃ (monodentate) + 2 Cl⁻ (monodentate) = 6 donor atoms, CN = 6",
        hints: ["Count all ligands", "All are monodentate", "4 + 2 = ?"]
      },
      {
        step_number: 4,
        title: "Hexadentate ligand",
        instruction: "What is the coordination number when one EDTA molecule coordinates to a metal?",
        expected_answer: "6|six",
        explanation: "EDTA is hexadentate (6 donor atoms: 2 N and 4 O), so CN = 6",
        hints: ["EDTA is hexadentate", "One EDTA molecule", "Hexa means 6"]
      },
      {
        step_number: 5,
        title: "Complex calculation",
        instruction: "What is the coordination number in [Fe(C₂O₄)₃]³⁻? (oxalate is bidentate)",
        expected_answer: "6|six",
        explanation: "3 oxalate ions, each bidentate (2 donor O atoms), so CN = 3×2 = 6",
        hints: ["Oxalate is bidentate", "3 oxalate ligands", "Multiply: 3 × 2"]
      }
    ],
    validation_rules: {
      donor_atoms: "Count donor atoms, not number of ligands",
      denticity_considered: "Denticity must be accounted for"
    },
    success_criteria: "All coordination numbers calculated correctly",
    points_reward: 100,
    max_attempts: 5,
    is_active: true
  },

  {
    title: "EAN Rule Application",
    description: "Calculate Effective Atomic Number and predict complex stability",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    category: "coordination_chemistry",
    learning_objectives: "Apply EAN rule, calculate total electrons, predict stability based on noble gas configuration",
    prerequisites: ["Coordination chemistry", "Electronic configuration", "Oxidation states"],
    steps: [
      {
        step_number: 1,
        title: "Understanding EAN formula",
        instruction: "Formula: EAN = Z - oxidation state + 2×CN. What is Z for Fe?",
        expected_answer: "26|twenty six",
        explanation: "Z = atomic number. Iron (Fe) has atomic number 26",
        hints: ["Atomic number", "Fe is element 26", "Check periodic table"]
      },
      {
        step_number: 2,
        title: "Simple EAN calculation",
        instruction: "Calculate EAN for [Fe(CN)₆]⁴⁻. (Z=26, Fe is +2, CN=6)",
        expected_answer: "36|thirty six",
        explanation: "EAN = 26 - 2 + 2×6 = 26 - 2 + 12 = 36 (same as Kr, noble gas)",
        hints: ["Use formula: Z - ox.state + 2×CN", "26 - 2 + 12", "Result is 36"]
      },
      {
        step_number: 3,
        title: "EAN for Co complex",
        instruction: "Calculate EAN for [Co(NH₃)₆]³⁺. (Z(Co)=27, Co is +3, CN=6)",
        expected_answer: "36|thirty six",
        explanation: "EAN = 27 - 3 + 2×6 = 27 - 3 + 12 = 36 (Kr configuration)",
        hints: ["Z = 27 for Co", "Oxidation state = +3", "Use formula"]
      },
      {
        step_number: 4,
        title: "Stability prediction",
        instruction: "Is [Ni(CO)₄] stable according to EAN rule? (Z(Ni)=28, Ni is 0, CN=4, Kr=36)",
        expected_answer: "Yes|yes|stable",
        explanation: "EAN = 28 - 0 + 2×4 = 36 (Kr). Complex follows EAN rule, hence stable",
        hints: ["Calculate EAN first", "Compare with noble gas", "Kr has 36 electrons"]
      },
      {
        step_number: 5,
        title: "Finding required ligands",
        instruction: "How many Cl⁻ ligands needed for [CoCl_x]ⁿ⁻ to have EAN=36? (Z(Co)=27, Co is +3)",
        expected_answer: "6|six",
        explanation: "EAN = 27 - 3 + 2×x = 36, so 24 + 2x = 36, x = 6. Complex is [CoCl₆]³⁻",
        hints: ["Set up equation: 27-3+2x=36", "Solve for x", "24 + 2x = 36"]
      }
    ],
    validation_rules: {
      ean_formula: "Correct application of EAN = Z - oxidation state + 2×CN",
      noble_gas_comparison: "Compare with nearest noble gas"
    },
    success_criteria: "All EAN calculations correct and stability predictions accurate",
    points_reward: 175,
    max_attempts: 5,
    is_active: true
  }
]

# Create the labs
puts "\nCreating labs..."

created_count = 0
inorganic_labs.each_with_index do |lab_data, index|
  lab = HandsOnLab.create!(
    title: lab_data[:title],
    description: lab_data[:description],
    difficulty: lab_data[:difficulty],
    estimated_minutes: lab_data[:estimated_minutes],
    lab_type: lab_data[:lab_type],
    lab_format: lab_data[:lab_format] || "terminal",
    category: lab_data[:category],
    certification_exam: lab_data[:certification_exam],
    learning_objectives: lab_data[:learning_objectives],
    prerequisites: lab_data[:prerequisites],
    steps: lab_data[:steps],
    validation_rules: lab_data[:validation_rules],
    success_criteria: lab_data[:success_criteria],
    points_reward: lab_data[:points_reward],
    max_attempts: lab_data[:max_attempts],
    is_active: lab_data[:is_active]
  )

  created_count += 1
  puts "  ✓ Lab #{index + 1}: #{lab.title} (#{lab.difficulty})"
end

puts "\n" + "=" * 80
puts "LAB CREATION SUMMARY"
puts "=" * 80
puts "✅ Total Labs Created: #{created_count}"
puts "✅ Lab Types:"
puts "   - Basics: 5 labs"
puts "   - s-Block Elements: 3 labs"
puts "   - Coordination Chemistry: 2 labs"
puts "=" * 80
puts "\n"

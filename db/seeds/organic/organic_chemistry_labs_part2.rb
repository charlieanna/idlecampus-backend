# Organic Chemistry Hands-On Labs - Part 2 (Labs 6-20)
# Covers: Nomenclature, Isomerism, Mechanisms, Functional Groups

puts "Creating Organic Chemistry Hands-On Labs (Part 2: Labs 6-20)..."

course_organic = Course.find_by(title: 'Organic Chemistry for IIT JEE Main & Advanced')

unless course_organic
  puts "Error: Organic Chemistry course not found!"
  exit
end

# ============================================================================
# CATEGORY 2: NOMENCLATURE AND ISOMERISM (Labs 6-11)
# ============================================================================

nomenclature_isomerism_labs = [
  # Lab 6: IUPAC Naming - Basic Hydrocarbons
  {
    title: "IUPAC Naming - Hydrocarbons and Simple Functional Groups",
    description: "Practice systematic IUPAC naming of alkanes, alkenes, alkynes, and simple functional groups",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["nomenclature", "iupac", "hydrocarbons"],
    category: "Nomenclature and Isomerism",
    steps: [
      {
        step_number: 1,
        title: "Name simple alkane",
        instruction: "Write the IUPAC name for CH₃-CH₂-CH₂-CH₂-CH₃",
        expected_answer: "pentane|n-pentane",
        explanation: "5 carbon continuous chain = pentane. No branching, so numbering doesn't matter.",
        hints: ["Count total carbons in longest chain", "5 carbons = pent-", "Alkane suffix = -ane"]
      },
      {
        step_number: 2,
        title: "Name branched alkane",
        instruction: "Write the IUPAC name for CH₃-CH(CH₃)-CH₂-CH₃",
        expected_answer: "2-methylbutane",
        explanation: "Longest chain = 4 carbons (butane). CH₃ branch at C2. Name: 2-methylbutane.",
        hints: ["Longest chain has 4 carbons", "Branch is CH₃ (methyl)", "Number from end giving lowest locant to branch"]
      },
      {
        step_number: 3,
        title: "Name alkene",
        instruction: "Write the IUPAC name for CH₃-CH=CH-CH₃",
        expected_answer: "but-2-ene|2-butene",
        explanation: "4 carbons with double bond between C2-C3. Name: but-2-ene.",
        hints: ["4 carbons = but-", "Double bond = -ene", "Number to give lowest locant to double bond"]
      },
      {
        step_number: 4,
        title: "Name simple alcohol",
        instruction: "Write the IUPAC name for CH₃-CH₂-CH₂-OH",
        expected_answer: "propan-1-ol|1-propanol",
        explanation: "3 carbons with -OH at C1. Name: propan-1-ol. Common name: n-propyl alcohol.",
        hints: ["3 carbons = prop-", "Alcohol = -ol", "OH at position 1"]
      },
      {
        step_number: 5,
        title: "Name simple ketone",
        instruction: "Write the IUPAC name for CH₃-CO-CH₂-CH₃",
        expected_answer: "butan-2-one|2-butanone",
        explanation: "4 carbons with C=O at C2. Name: butan-2-one. Common name: methyl ethyl ketone (MEK).",
        hints: ["4 carbons = but-", "Ketone = -one", "C=O at position 2"]
      }
    ],
    validation_rules: {
      correct_parent_chain: "Longest continuous chain identified",
      correct_numbering: "Proper numbering system applied",
      correct_suffix: "Appropriate suffix for functional group"
    },
    success_criteria: "All 5 compounds named correctly using IUPAC rules",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 7: IUPAC Naming - Multi-functional Compounds
  {
    title: "IUPAC Naming - Multi-functional and Complex Molecules",
    description: "Master naming of compounds with multiple functional groups and priority rules",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["nomenclature", "iupac", "priority", "multi-functional"],
    category: "Nomenclature and Isomerism",
    steps: [
      {
        step_number: 1,
        title: "Identify highest priority group",
        instruction: "In a molecule with -OH (alcohol) and -CHO (aldehyde), which gets the suffix?",
        expected_answer: "aldehyde|CHO|-CHO",
        explanation: "Aldehyde has HIGHER priority than alcohol. Priority: COOH > CHO > Ketone > OH. Aldehyde gets -al suffix, alcohol becomes hydroxy- prefix.",
        hints: ["Check functional group priority table", "Aldehyde > Alcohol in priority", "Higher priority gets suffix"]
      },
      {
        step_number: 2,
        title: "Name compound with aldehyde and alcohol",
        instruction: "Write IUPAC name for HOCH₂-CH₂-CHO",
        expected_answer: "3-hydroxypropanal",
        explanation: "3 carbons, aldehyde (principal) at C1, OH at C3. Name: 3-hydroxypropanal.",
        hints: ["Aldehyde gets suffix (-al)", "OH becomes prefix (hydroxy-)", "Number from aldehyde end"]
      },
      {
        step_number: 3,
        title: "Name carboxylic acid derivative",
        instruction: "Write IUPAC name for CH₃-CH₂-COOH",
        expected_answer: "propanoic acid",
        explanation: "3 carbons (including COOH carbon) with carboxylic acid group. Name: propanoic acid. Common: propionic acid.",
        hints: ["COOH is highest priority", "Count COOH carbon in chain", "3 carbons = propan-, acid = -oic acid"]
      },
      {
        step_number: 4,
        title: "Name disubstituted benzene",
        instruction: "For a benzene ring with -NO₂ at position 1 and -CH₃ at position 4, what is the name?",
        expected_answer: "4-nitrotoluene|p-nitrotoluene|1-methyl-4-nitrobenzene",
        explanation: "Toluene (methylbenzene) with NO₂ at para position. Name: 4-nitrotoluene or p-nitrotoluene or 1-methyl-4-nitrobenzene.",
        hints: ["Positions 1 and 4 = para", "CH₃-benzene = toluene", "NO₂ = nitro"]
      },
      {
        step_number: 5,
        title: "Complex multi-functional naming",
        instruction: "In CH₃-CH(OH)-CH₂-COOH, which group gets the suffix?",
        expected_answer: "COOH|carboxylic acid|acid",
        explanation: "COOH (carboxylic acid) has HIGHEST priority. Gets -oic acid suffix. OH becomes hydroxy- prefix. Name: 3-hydroxybutan-oic acid.",
        hints: ["COOH is highest priority functional group", "OH becomes a prefix", "Number from COOH end"]
      }
    ],
    validation_rules: {
      priority_application: "Correct functional group priority",
      multi_functional_naming: "Proper handling of multiple groups",
      prefix_suffix_usage: "Correct prefix and suffix application"
    },
    success_criteria: "All 5 multi-functional naming problems solved",
    points_reward: 150,
    max_attempts: 5
  },

  # Lab 8: Structural Isomer Identification
  {
    title: "Identifying and Drawing Structural Isomers",
    description: "Practice recognizing and drawing different types of structural isomers",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["isomerism", "structural", "chain", "position", "functional"],
    category: "Nomenclature and Isomerism",
    steps: [
      {
        step_number: 1,
        title: "Count chain isomers",
        instruction: "How many chain isomers exist for C₅H₁₂ (pentane)?",
        expected_answer: "3",
        explanation: "3 chain isomers: n-pentane (straight), isopentane (2-methylbutane), neopentane (2,2-dimethylpropane).",
        hints: ["Draw different carbon skeletons", "Straight chain, one branch, two branches", "Same molecular formula, different skeletons"]
      },
      {
        step_number: 2,
        title: "Identify isomerism type",
        instruction: "CH₃-CH₂-OH and CH₃-O-CH₃ show which type of isomerism?",
        expected_answer: "functional group|functional",
        explanation: "Functional group isomerism. Same formula C₂H₆O but different functional groups: alcohol vs ether.",
        hints: ["Same molecular formula", "Different functional groups", "Alcohol vs ether"]
      },
      {
        step_number: 3,
        title: "Position isomers",
        instruction: "How many position isomers of C₃H₈O (propanol) exist?",
        expected_answer: "2",
        explanation: "2 position isomers: propan-1-ol (CH₃-CH₂-CH₂-OH) and propan-2-ol (CH₃-CH(OH)-CH₃). OH at different positions.",
        hints: ["Same carbon skeleton", "OH at different positions", "C3 chain with OH at C1 or C2"]
      },
      {
        step_number: 4,
        title: "Functional group isomers of C₃H₆O",
        instruction: "C₃H₆O can be an aldehyde or ketone. How many isomers total?",
        expected_answer: "2",
        explanation: "2 functional group isomers: propanal (CH₃-CH₂-CHO, aldehyde) and propanone (CH₃-CO-CH₃, ketone).",
        hints: ["Aldehyde has -CHO", "Ketone has -CO- in middle", "Different functional groups"]
      },
      {
        step_number: 5,
        title: "Metamerism identification",
        instruction: "CH₃-O-CH₂-CH₂-CH₃ and CH₃-CH₂-O-CH₂-CH₃ show which type of isomerism?",
        expected_answer: "metamerism",
        explanation: "Metamerism: different alkyl groups around same functional group (ether, -O-). Methyl propyl ether vs diethyl ether.",
        hints: ["Same functional group (ether)", "Different alkyl chain distribution", "Around the oxygen atom"]
      }
    ],
    validation_rules: {
      isomer_counting: "Correct number of isomers",
      type_identification: "Accurate isomerism type classification",
      structure_understanding: "Proper structural differences"
    },
    success_criteria: "All 5 structural isomerism problems solved",
    points_reward: 120,
    max_attempts: 5
  },

  # Lab 9: E-Z Nomenclature Practice
  {
    title: "E-Z Nomenclature for Alkenes - CIP Rules",
    description: "Master E-Z nomenclature using Cahn-Ingold-Prelog priority rules",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["isomerism", "geometrical", "E-Z", "CIP-rules", "alkenes"],
    category: "Nomenclature and Isomerism",
    steps: [
      {
        step_number: 1,
        title: "Simple cis-trans",
        instruction: "For CH₃-CH=CH-CH₃ with both CH₃ on same side, is it cis or trans?",
        expected_answer: "cis",
        explanation: "Both CH₃ groups on same side = cis. Cis = same side, Trans = opposite sides.",
        hints: ["Cis = Zusammen = same side", "Trans = Entgegen = opposite", "Both methyl groups together"]
      },
      {
        step_number: 2,
        title: "CIP priority - atomic number",
        instruction: "Which has HIGHER priority in CIP rules: -Br or -Cl?",
        expected_answer: "Br|bromine|-Br",
        explanation: "Br (atomic number 35) has HIGHER priority than Cl (atomic number 17). Higher atomic number = higher priority.",
        hints: ["CIP rule: higher atomic number = higher priority", "Br is below Cl in periodic table", "Br: 35, Cl: 17"]
      },
      {
        step_number: 3,
        title: "E-Z assignment",
        instruction: "If higher priority groups are on OPPOSITE sides of double bond, is it E or Z?",
        expected_answer: "E",
        explanation: "E (Entgegen) = opposite sides. Z (Zusammen) = same side. E = opposite.",
        hints: ["E = Entgegen (German for opposite)", "Z = Zusammen (German for together)", "Higher priority groups apart"]
      },
      {
        step_number: 4,
        title: "Priority with different atoms",
        instruction: "Which has higher CIP priority: -CH₃ or -CH₂CH₃?",
        expected_answer: "-CH2CH3|ethyl",
        explanation: "When first atom is same (C), look at next. -CH₂CH₃ has C-C-H vs -CH₃ has C-H-H-H. C > H, so ethyl has higher priority.",
        hints: ["First atom is C in both", "Look at second sphere of atoms", "C-C-H vs C-H-H-H, C > H"]
      },
      {
        step_number: 5,
        title: "E-Z for complex alkene",
        instruction: "For C₆H₅-CH=CH-Cl with C₆H₅ and Cl on opposite sides, what is the configuration?",
        expected_answer: "E",
        explanation: "C₆H₅ (phenyl, higher priority) and Cl (higher than H, higher priority) on opposite sides = E configuration.",
        hints: ["Identify higher priority on each C", "C₆H₅ > H, Cl > H", "Higher priorities on opposite sides = E"]
      }
    ],
    validation_rules: {
      priority_determination: "Correct CIP priority assignment",
      E_Z_assignment: "Accurate E/Z configuration",
      reasoning: "Proper application of CIP rules"
    },
    success_criteria: "All 5 E-Z nomenclature problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 10: R-S Configuration Assignment
  {
    title: "Assigning R-S Configuration to Chiral Centers",
    description: "Master R-S nomenclature for optical isomers using CIP rules",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["isomerism", "optical", "R-S", "CIP-rules", "chirality"],
    category: "Nomenclature and Isomerism",
    steps: [
      {
        step_number: 1,
        title: "Identify chiral center",
        instruction: "How many chiral centers in CH₃-CH(OH)-CH₂-CH₃?",
        expected_answer: "1",
        explanation: "1 chiral center at C2. Has 4 different groups: -H, -OH, -CH₃, -CH₂CH₃.",
        hints: ["Chiral center = 4 different groups", "Check each carbon", "C2 has H, OH, CH₃, CH₂CH₃"]
      },
      {
        step_number: 2,
        title: "Assign priorities",
        instruction: "For chiral center with groups: -Br, -Cl, -H, -CH₃, order them by DECREASING priority (1 to 4)",
        expected_answer: "Br > Cl > CH3 > H|Br,Cl,CH3,H",
        explanation: "Priority (decreasing): Br (35) > Cl (17) > C (6 in CH₃) > H (1). Higher atomic number = higher priority.",
        hints: ["Use atomic numbers", "Br: 35, Cl: 17, C: 6, H: 1", "Higher atomic number = priority 1"]
      },
      {
        step_number: 3,
        title: "R vs S determination",
        instruction: "If you trace 1→2→3 clockwise (with 4 away), is it R or S?",
        expected_answer: "R",
        explanation: "Clockwise = R (Rectus). Counterclockwise = S (Sinister). R = clockwise.",
        hints: ["R = Rectus = right = clockwise", "S = Sinister = left = counterclockwise", "Clockwise → R"]
      },
      {
        step_number: 4,
        title: "Orient molecule correctly",
        instruction: "In R-S assignment, which priority group should point AWAY from you?",
        expected_answer: "4|lowest|lowest priority",
        explanation: "Lowest priority (4) points away. Then trace 1→2→3. Clockwise = R, Counterclockwise = S.",
        hints: ["Lowest priority goes to back", "This is priority 4", "Away from viewer"]
      },
      {
        step_number: 5,
        title: "Complex R-S assignment",
        instruction: "For a chiral carbon with -COOH, -NH₂, -H, -CH₃, which has HIGHEST priority?",
        expected_answer: "NH2|-NH2|amino",
        explanation: "-NH₂ has highest priority. N (atomic number 7) > C (6 in COOH and CH₃) > H (1). When first atom same, -COOH and -CH₃ both have C, but we compare C bonding.",
        hints: ["Compare atomic numbers of directly bonded atoms", "N: 7, C: 6, H: 1", "N has highest atomic number"]
      }
    ],
    validation_rules: {
      chiral_center_identification: "Correct chiral center recognition",
      priority_assignment: "Accurate CIP priority ordering",
      R_S_determination: "Correct R or S configuration"
    },
    success_criteria: "All 5 R-S configuration problems solved",
    points_reward: 160,
    max_attempts: 5
  },

  # Lab 11: Counting Stereoisomers
  {
    title: "Counting Chiral Centers and Stereoisomers",
    description: "Learn to count chiral centers and calculate number of stereoisomers",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["isomerism", "optical", "stereoisomers", "chiral-centers", "meso"],
    category: "Nomenclature and Isomerism",
    steps: [
      {
        step_number: 1,
        title: "Formula for stereoisomer count",
        instruction: "For n chiral centers with NO plane of symmetry, how many stereoisomers? (Formula)",
        expected_answer: "2^n|2n|2 to the power n",
        explanation: "Formula: 2ⁿ stereoisomers. Each chiral center can be R or S (2 options), n centers = 2ⁿ combinations.",
        hints: ["Each chiral center: 2 possibilities (R or S)", "n centers = 2 × 2 × 2... (n times)", "Answer: 2ⁿ"]
      },
      {
        step_number: 2,
        title: "Calculate for 2 chiral centers",
        instruction: "How many stereoisomers for a compound with 2 chiral centers and NO symmetry?",
        expected_answer: "4",
        explanation: "2² = 4 stereoisomers (2 pairs of enantiomers). RR, RS, SR, SS configurations possible.",
        hints: ["Use 2ⁿ formula", "n = 2", "2² = ?"]
      },
      {
        step_number: 3,
        title: "Identify meso compound",
        instruction: "A compound with 2 chiral centers but a plane of symmetry is called?",
        expected_answer: "meso|meso compound",
        explanation: "Meso compound: has chiral centers BUT has plane of symmetry → optically inactive (internal compensation).",
        hints: ["Has chiral centers + symmetry plane", "Optically inactive despite chirality", "Special case: meso"]
      },
      {
        step_number: 4,
        title: "Stereoisomers with meso",
        instruction: "If a compound has 2 chiral centers and IS meso, how many stereoisomers total?",
        expected_answer: "3",
        explanation: "3 stereoisomers: 1 meso (optically inactive) + 1 pair of enantiomers (d and l). Not 2² = 4 due to meso.",
        hints: ["Formula 2ⁿ doesn't apply with meso", "Meso is 1 compound", "Plus one pair of enantiomers (2)", "Total: 1 + 2 = 3"]
      },
      {
        step_number: 5,
        title: "Complex stereoisomer counting",
        instruction: "How many stereoisomers for a compound with 3 chiral centers and NO symmetry?",
        expected_answer: "8",
        explanation: "2³ = 8 stereoisomers (4 pairs of enantiomers). All possible R/S combinations at 3 centers.",
        hints: ["Use 2ⁿ formula", "n = 3", "2³ = ?"]
      }
    ],
    validation_rules: {
      formula_application: "Correct use of 2ⁿ formula",
      meso_identification: "Recognition of meso compounds",
      accurate_counting: "Correct stereoisomer count"
    },
    success_criteria: "All 5 stereoisomer counting problems solved",
    points_reward: 145,
    max_attempts: 5
  }
]

# ============================================================================
# CATEGORY 3: REACTION MECHANISMS (Labs 12-15)
# ============================================================================

mechanism_labs = [
  # Lab 12: Electrophilic Addition to Alkenes
  {
    title: "Electrophilic Addition to Alkenes - Mechanism and Products",
    description: "Master electrophilic addition reactions and predict products",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "alkenes", "electrophilic-addition", "markovnikov"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "HBr addition to ethene",
        instruction: "What is the product when CH₂=CH₂ reacts with HBr?",
        expected_answer: "CH3CH2Br|bromoethane",
        explanation: "CH₂=CH₂ + HBr → CH₃-CH₂-Br (bromoethane). Mechanism: π bond attacks H⁺, forms carbocation, Br⁻ attacks.",
        hints: ["H adds to one C, Br to other", "Forms C-H and C-Br", "Symmetric alkene, one product"]
      },
      {
        step_number: 2,
        title: "Markovnikov's rule",
        instruction: "In HBr addition to CH₃-CH=CH₂, H adds to which carbon? (more or less substituted)",
        expected_answer: "less substituted|less|terminal",
        explanation: "H adds to LESS substituted carbon (terminal CH₂). Markovnikov: H to C with more H already. Forms more stable 2° carbocation.",
        hints: ["Markovnikov: H to carbon with more H", "Forms more stable carbocation", "Terminal carbon gets H"]
      },
      {
        step_number: 3,
        title: "Product with Markovnikov",
        instruction: "What is the major product: CH₃-CH=CH₂ + HCl →?",
        expected_answer: "CH3-CHCl-CH3|2-chloropropane",
        explanation: "CH₃-CHCl-CH₃ (2-chloropropane, major). Markovnikov product. H → terminal C, Cl → C2 (more substituted).",
        hints: ["Markovnikov rule applies", "H to less substituted C", "Cl to more substituted C (C2)"]
      },
      {
        step_number: 4,
        title: "Anti-Markovnikov (peroxide effect)",
        instruction: "CH₃-CH=CH₂ + HBr + peroxide → ? (major product)",
        expected_answer: "CH3-CH2-CH2Br|1-bromopropane",
        explanation: "CH₃-CH₂-CH₂-Br (1-bromopropane). Peroxide effect: anti-Markovnikov. Br adds to less substituted C. Free radical mechanism.",
        hints: ["Peroxide causes anti-Markovnikov", "Br to less substituted C", "Free radical mechanism (not carbocation)"]
      },
      {
        step_number: 5,
        title: "Br₂ addition",
        instruction: "CH₂=CH₂ + Br₂ → ? What is the product?",
        expected_answer: "CH2Br-CH2Br|1,2-dibromoethane",
        explanation: "CH₂Br-CH₂Br (1,2-dibromoethane). Br adds to both carbons. Anti addition (trans). Mechanism: bromonium ion intermediate.",
        hints: ["Br adds to both carbons", "Halogen addition", "Forms vicinal dibromide"]
      }
    ],
    validation_rules: {
      markovnikov_application: "Correct Markovnikov rule usage",
      product_prediction: "Accurate product structures",
      mechanism_understanding: "Proper mechanistic reasoning"
    },
    success_criteria: "All 5 electrophilic addition problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 13: Markovnikov vs Anti-Markovnikov
  {
    title: "Markovnikov vs Anti-Markovnikov - Selectivity in Additions",
    description: "Understand when Markovnikov or anti-Markovnikov products form",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "markovnikov", "peroxide-effect", "regioselectivity"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "State Markovnikov's rule",
        instruction: "In HX addition to alkene, does H add to more or less substituted carbon?",
        expected_answer: "less substituted|less",
        explanation: "H adds to LESS substituted carbon (carbon with more H already). This forms more stable carbocation at MORE substituted C.",
        hints: ["Rich get richer (H already present)", "Forms more stable carbocation", "H to carbon with more H"]
      },
      {
        step_number: 2,
        title: "Carbocation stability reasoning",
        instruction: "Why is 2° carbocation more stable than 1°? (What effect?)",
        expected_answer: "hyperconjugation|+I effect|inductive",
        explanation: "Hyperconjugation and +I effect from alkyl groups stabilize carbocation. More alkyl groups → more stable carbocation. 3° > 2° > 1°.",
        hints: ["Alkyl groups stabilize positive charge", "Hyperconjugation from α-H", "More substituted = more stable"]
      },
      {
        step_number: 3,
        title: "Which HX shows peroxide effect?",
        instruction: "Peroxide effect (anti-Markovnikov) works with HCl, HBr, or HI? (One answer)",
        expected_answer: "HBr",
        explanation: "ONLY HBr shows peroxide effect. HCl: too strong, HI: too weak. HBr has perfect bond energy for radical mechanism.",
        hints: ["Only one hydrogen halide works", "HBr is the special case", "Not HCl or HI"]
      },
      {
        step_number: 4,
        title: "Predict with peroxide",
        instruction: "(CH₃)₂C=CH₂ + HBr + peroxide → ? (major product)",
        expected_answer: "(CH3)2CH-CH2Br|1-bromo-2-methylpropane",
        explanation: "(CH₃)₂CH-CH₂Br (1-bromo-2-methylpropane). Anti-Markovnikov: Br to less substituted carbon (terminal CH₂).",
        hints: ["Peroxide = anti-Markovnikov", "Br to terminal carbon", "Less substituted gets Br"]
      },
      {
        step_number: 5,
        title: "No peroxide prediction",
        instruction: "(CH₃)₂C=CH₂ + HBr (NO peroxide) → ? (major product)",
        expected_answer: "(CH3)2CBr-CH3|2-bromo-2-methylpropane",
        explanation: "(CH₃)₂CBr-CH₃ (2-bromo-2-methylpropane). Markovnikov: Br to MORE substituted carbon. Forms 3° carbocation.",
        hints: ["No peroxide = Markovnikov", "Br to more substituted C", "Tertiary position gets Br"]
      }
    ],
    validation_rules: {
      rule_understanding: "Clear Markovnikov/anti-Markovnikov distinction",
      condition_analysis: "Correct interpretation of reaction conditions",
      product_selectivity: "Accurate regioselectivity prediction"
    },
    success_criteria: "All 5 selectivity problems solved correctly",
    points_reward: 130,
    max_attempts: 5
  },

  # Lab 14: Ozonolysis Product Prediction
  {
    title: "Ozonolysis of Alkenes - Predicting Products",
    description: "Master ozonolysis reactions and predict carbonyl products",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "ozonolysis", "alkenes", "oxidation"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "Basic ozonolysis",
        instruction: "CH₃-CH=CH₂ + O₃ then Zn/H₂O → ? (products)",
        expected_answer: "CH3CHO + HCHO|acetaldehyde + formaldehyde",
        explanation: "Products: CH₃-CHO (acetaldehyde) + H-CHO (formaldehyde). Double bond cleaves, each C becomes C=O.",
        hints: ["Break the C=C bond", "Each carbon gets =O", "Forms two aldehydes"]
      },
      {
        step_number: 2,
        title: "Symmetrical alkene",
        instruction: "CH₃-CH=CH-CH₃ + O₃ then Zn/H₂O → ? (product)",
        expected_answer: "CH3CHO|acetaldehyde|2 CH3CHO",
        explanation: "Product: 2 CH₃-CHO (2 molecules of acetaldehyde). Symmetrical alkene gives same product from both ends.",
        hints: ["Symmetrical molecule", "Both sides same", "Two identical aldehydes"]
      },
      {
        step_number: 3,
        title: "Terminal alkene",
        instruction: "What carbonyl compound forms from terminal C in R-CH=CH₂ after ozonolysis?",
        expected_answer: "HCHO|formaldehyde|methanal",
        explanation: "Terminal C (=CH₂) always gives H-CHO (formaldehyde). The other product depends on R group.",
        hints: ["Terminal carbon has 2 H", "Becomes CHO", "Formaldehyde (simplest aldehyde)"]
      },
      {
        step_number: 4,
        title: "Substituted alkene",
        instruction: "(CH₃)₂C=CH₂ + O₃ then Zn/H₂O → ? (products)",
        expected_answer: "(CH3)2CO + HCHO|acetone + formaldehyde",
        explanation: "Products: (CH₃)₂C=O (acetone, ketone) + H-CHO (formaldehyde, aldehyde). Disubstituted C gives ketone.",
        hints: ["(CH₃)₂C becomes (CH₃)₂C=O (ketone)", "Terminal becomes HCHO", "Ketone + aldehyde"]
      },
      {
        step_number: 5,
        title: "Reverse problem - deduce alkene",
        instruction: "If ozonolysis gives 2 molecules of CH₃-CH₂-CHO, what was the original alkene?",
        expected_answer: "CH3CH2-CH=CH-CH2CH3|3-hexene",
        explanation: "Original alkene: CH₃-CH₂-CH=CH-CH₂-CH₃ (hex-3-ene). Symmetrical, gives 2 same aldehydes.",
        hints: ["Work backwards", "Each CHO was part of C=C", "Join the two parts at C=C"]
      }
    ],
    validation_rules: {
      bond_cleavage_understanding: "Correct C=C cleavage prediction",
      product_identification: "Accurate carbonyl product determination",
      retrosynthesis: "Ability to deduce starting material"
    },
    success_criteria: "All 5 ozonolysis problems solved",
    points_reward: 135,
    max_attempts: 5
  },

  # Lab 15: Electrophilic Aromatic Substitution (EAS)
  {
    title: "Electrophilic Aromatic Substitution - Mechanism and Directive Effects",
    description: "Master EAS reactions and predict substitution positions",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "EAS", "benzene", "directive-effects"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "Basic EAS mechanism",
        instruction: "In EAS, what is the intermediate formed when electrophile attacks benzene?",
        expected_answer: "arenium ion|carbocation|sigma complex",
        explanation: "Arenium ion (sigma complex, carbocation). Benzene attacks E⁺ → carbocation intermediate → loses H⁺ → substituted benzene.",
        hints: ["Carbocation intermediate", "Positive charge on ring", "Also called sigma complex"]
      },
      {
        step_number: 2,
        title: "o/p vs m directors",
        instruction: "Does -OH group direct incoming substituent to ortho/para or meta position?",
        expected_answer: "ortho/para|o/p",
        explanation: "-OH is ortho/para director (+M effect donates electrons, stabilizes carbocation at o/p positions). Activating group.",
        hints: ["OH has lone pairs", "+M effect (electron donating)", "Activating groups → o/p directing"]
      },
      {
        step_number: 3,
        title: "Meta director",
        instruction: "Does -NO₂ group direct to ortho/para or meta?",
        expected_answer: "meta|m",
        explanation: "-NO₂ is meta director (-M effect withdraws electrons, destabilizes o/p but meta is least bad). Deactivating group.",
        hints: ["NO₂ is electron-withdrawing", "-M effect", "Deactivating groups → meta directing"]
      },
      {
        step_number: 4,
        title: "Predict substitution position",
        instruction: "In toluene (methylbenzene) nitration, where does NO₂ mainly go? (position)",
        expected_answer: "ortho/para|o/p",
        explanation: "Ortho and para positions. -CH₃ is ortho/para director (+I effect, activating). Usually mixture of o- and p-nitrotoluene.",
        hints: ["CH₃ is electron-donating", "+I effect, activating", "o/p director"]
      },
      {
        step_number: 5,
        title: "Directive effect reasoning",
        instruction: "Why are electron-donating groups (EDG) ortho/para directors?",
        expected_answer: "stabilize carbocation at ortho/para|resonance stabilization",
        explanation: "EDGs stabilize carbocation intermediate at ortho/para positions through resonance/inductive effects. Positive charge can be at C where EDG can donate.",
        hints: ["EDG stabilizes positive charge", "Resonance at o/p positions", "Cannot stabilize at meta"]
      }
    ],
    validation_rules: {
      mechanism_understanding: "Correct EAS mechanism knowledge",
      directive_effect_application: "Accurate o/p vs m prediction",
      reasoning: "Proper explanation of directive effects"
    },
    success_criteria: "All 5 EAS problems solved with understanding",
    points_reward: 160,
    max_attempts: 5
  }
]

# Create all labs
puts "\nCreating Nomenclature and Isomerism Labs (6-11)..."
(nomenclature_isomerism_labs + mechanism_labs).each_with_index do |lab_data, index|
  lab = HandsOnLab.create!(
    course: course_organic,
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
    order_index: index + 6
  )
  puts "  ✓ Lab #{index + 6} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "Organic Chemistry Labs - Part 2 Summary"
puts "="*80
puts "Created: 10 labs (Nomenclature, Isomerism, Mechanisms)"
puts "Labs 6-11: Nomenclature & Isomerism (6 labs)"
puts "Labs 12-15: Reaction Mechanisms (4 labs)"
puts "Total lab time: ~#{(nomenclature_isomerism_labs + mechanism_labs).sum { |l| l[:estimated_minutes] }} minutes"
puts "="*80
puts "\nRunning total: 15 labs created (5 from Part 1 + 10 from Part 2)"
puts "Remaining: 25 labs to reach 40-lab target"
puts "="*80

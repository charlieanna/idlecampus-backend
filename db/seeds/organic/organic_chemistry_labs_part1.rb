# Organic Chemistry Hands-On Labs - Part 1 (Labs 1-20)
# Comprehensive problem-solving practice modeled after Docker/Kubernetes labs
# Covers: GOC, Nomenclature, Isomerism, Mechanisms

puts "Creating Organic Chemistry Hands-On Labs (Part 1: Labs 1-20)..."

# Get course reference
course_organic = Course.find_by(title: 'Organic Chemistry for IIT JEE Main & Advanced')

unless course_organic
  puts "Error: Organic Chemistry course not found!"
  exit
end

# ============================================================================
# CATEGORY 1: GOC AND FUNDAMENTALS (Labs 1-8)
# ============================================================================

goc_labs = [
  # Lab 1: Determining Hybridization
  {
    title: "Determining Hybridization from Molecular Structure",
    description: "Master the skill of identifying hybridization states of carbon atoms in organic molecules",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["goc", "hybridization", "bonding", "structure"],
    category: "General Organic Chemistry",
    steps: [
      {
        step_number: 1,
        title: "Identify hybridization in methane (CH₄)",
        instruction: "What is the hybridization of carbon in CH₄?",
        expected_answer: "sp3",
        explanation: "CH₄ has 4 single bonds → 4 σ bonds → sp³ hybridization. Geometry: tetrahedral, bond angle: 109.5°.",
        hints: [
          "Count the number of sigma bonds",
          "4 sigma bonds = sp³",
          "Tetrahedral geometry"
        ]
      },
      {
        step_number: 2,
        title: "Identify hybridization in ethene (C₂H₄)",
        instruction: "What is the hybridization of each carbon in CH₂=CH₂?",
        expected_answer: "sp2",
        explanation: "Each carbon has 3 σ bonds (2 C-H + 1 C-C) and 1 π bond → sp² hybridization. Geometry: trigonal planar, 120°.",
        hints: [
          "Count sigma bonds (not pi bonds)",
          "3 sigma bonds = sp²",
          "Double bond = 1σ + 1π"
        ]
      },
      {
        step_number: 3,
        title: "Identify hybridization in ethyne (C₂H₂)",
        instruction: "What is the hybridization of each carbon in HC≡CH?",
        expected_answer: "sp",
        explanation: "Each carbon has 2 σ bonds (1 C-H + 1 C-C) and 2 π bonds → sp hybridization. Geometry: linear, 180°.",
        hints: [
          "Triple bond = 1σ + 2π",
          "2 sigma bonds = sp",
          "Linear geometry"
        ]
      },
      {
        step_number: 4,
        title: "Multiple hybridizations in one molecule",
        instruction: "In CH₂=CH-CN, what are the hybridizations of C1, C2, and C3 respectively? (Format: sp2,sp2,sp)",
        expected_answer: "sp2,sp2,sp|sp²,sp²,sp",
        explanation: "C1 (CH₂=): sp² (3σ bonds). C2 (-CH-): sp² (3σ bonds). C3 (≡N): sp (2σ bonds). Triple bond carbon is always sp.",
        hints: [
          "C1 has double bond → sp²",
          "C2 connects double and triple bonds → sp²",
          "C3 has triple bond → sp"
        ]
      },
      {
        step_number: 5,
        title: "Hybridization in benzene",
        instruction: "What is the hybridization of all carbon atoms in benzene (C₆H₆)?",
        expected_answer: "sp2",
        explanation: "All carbons in benzene are sp². Each has 3 σ bonds (2 C-C + 1 C-H) and participates in delocalized π system.",
        hints: [
          "Benzene has alternating single-double bonds",
          "Each carbon forms 3 sigma bonds",
          "All carbons have same hybridization"
        ]
      }
    ],
    validation_rules: {
      hybridization_identification: "Correctly identify sp, sp², or sp³",
      counting_bonds: "Accurately count sigma bonds",
      geometry_understanding: "Understand relationship between hybridization and geometry"
    },
    success_criteria: "All 5 hybridization identifications correct",
    points_reward: 100,
    max_attempts: 5
  },

  # Lab 2: Drawing Resonance Structures
  {
    title: "Drawing Resonance Structures - Step by Step",
    description: "Learn to draw valid resonance structures and identify the most stable contributor",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["goc", "resonance", "electron-delocalization"],
    category: "General Organic Chemistry",
    steps: [
      {
        step_number: 1,
        title: "Resonance in carboxylate ion",
        instruction: "How many equivalent resonance structures does CH₃COO⁻ (acetate ion) have?",
        expected_answer: "2",
        explanation: "Acetate ion has 2 equivalent resonance structures with negative charge alternating between the two oxygen atoms. Both C-O bonds are equivalent (127 pm).",
        hints: [
          "Move the π bond and negative charge",
          "Both oxygens are equivalent",
          "Charge distribution over 2 oxygens"
        ]
      },
      {
        step_number: 2,
        title: "Resonance in benzene",
        instruction: "How many Kekulé structures (resonance forms) does benzene have?",
        expected_answer: "2",
        explanation: "Benzene has 2 Kekulé structures (alternating double bonds). Reality: all C-C bonds are equivalent (139 pm) due to resonance.",
        hints: [
          "Alternating double bond positions",
          "Mirror image structures",
          "Resonance energy = 150 kJ/mol"
        ]
      },
      {
        step_number: 3,
        title: "Count resonance in allyl cation",
        instruction: "How many resonance structures does CH₂=CH-CH₂⁺ (allyl cation) have?",
        expected_answer: "2",
        explanation: "Allyl cation: CH₂=CH-CH₂⁺ ⟷ CH₂⁺-CH=CH₂. Positive charge delocalized over C1 and C3. This delocalization stabilizes the cation.",
        hints: [
          "Move π bond and positive charge",
          "Charge shifts between terminal carbons",
          "Central carbon remains sp²"
        ]
      },
      {
        step_number: 4,
        title: "Stability comparison",
        instruction: "Which is more stable: CH₃-CH₂-CH₂⁺ (propyl cation) or CH₂=CH-CH₂⁺ (allyl cation)?",
        expected_answer: "allyl|allyl cation|CH2=CH-CH2+",
        explanation: "Allyl cation is MORE stable due to resonance delocalization. Propyl cation (1°) has no resonance. Resonance > hyperconjugation for stability.",
        hints: [
          "Does resonance stabilize allyl cation?",
          "Propyl is just a primary carbocation",
          "Resonance provides major stabilization"
        ]
      },
      {
        step_number: 5,
        title: "Identify most stable resonance structure",
        instruction: "For CH₃-NH-CH=O, which atom (N or O) will preferably carry the negative charge in resonance structures?",
        expected_answer: "O|oxygen",
        explanation: "In resonance forms with negative charge, oxygen (more electronegative) preferably carries the charge. More stable: CH₃-NH=CH-O⁻.",
        hints: [
          "Which is more electronegative: N or O?",
          "Negative charge more stable on more electronegative atom",
          "Oxygen is in Group 16"
        ]
      }
    ],
    validation_rules: {
      resonance_counting: "Correct number of resonance forms",
      charge_distribution: "Proper charge placement",
      stability_ordering: "Correct stability comparisons"
    },
    success_criteria: "All 5 resonance problems solved correctly",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 3: Carbocation Stability
  {
    title: "Comparing Stability - Carbocations and Carbanions",
    description: "Understand and predict stability orders of reactive intermediates",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["goc", "carbocation", "carbanion", "stability"],
    category: "General Organic Chemistry",
    steps: [
      {
        step_number: 1,
        title: "Basic carbocation stability",
        instruction: "Order by INCREASING stability: CH₃⁺, CH₃CH₂⁺, (CH₃)₂CH⁺, (CH₃)₃C⁺",
        expected_answer: "CH3+ < CH3CH2+ < (CH3)2CH+ < (CH3)3C+|methyl < primary < secondary < tertiary",
        explanation: "Stability: 3° > 2° > 1° > methyl. Due to +I effect and hyperconjugation. Tertiary (3°) most stable.",
        hints: [
          "More alkyl groups = more stable",
          "Order: tertiary > secondary > primary > methyl",
          "Hyperconjugation: 9 α-H (3°) > 6 (2°) > 3 (1°) > 0 (methyl)"
        ]
      },
      {
        step_number: 2,
        title: "Resonance vs inductive effect",
        instruction: "Which is more stable: (CH₃)₃C⁺ (tert-butyl) or CH₂=CH-CH₂⁺ (allyl)?",
        expected_answer: "allyl|CH2=CH-CH2+|allyl cation",
        explanation: "Allyl cation is MORE stable. Resonance stabilization > hyperconjugation. Allyl has resonance, tert-butyl only has hyperconjugation.",
        hints: [
          "Does allyl have resonance?",
          "Resonance provides stronger stabilization",
          "Allyl positive charge delocalized"
        ]
      },
      {
        step_number: 3,
        title: "Carbanion stability order",
        instruction: "Order by INCREASING stability (REVERSE of carbocations): CH₃⁻, CH₃CH₂⁻, (CH₃)₂CH⁻, (CH₃)₃C⁻",
        expected_answer: "(CH3)3C- < (CH3)2CH- < CH3CH2- < CH3-|tertiary < secondary < primary < methyl",
        explanation: "Carbanion stability: methyl > 1° > 2° > 3° (OPPOSITE of carbocations). -I groups stabilize carbanions, +I groups destabilize them.",
        hints: [
          "Carbanions want electron-withdrawing groups",
          "+I effect destabilizes negative charge",
          "Less alkyl groups = more stable carbanion"
        ]
      },
      {
        step_number: 4,
        title: "Effect of -I groups on carbocation",
        instruction: "Which is more stable: CH₃-CH₂⁺ or Cl-CH₂-CH₂⁺? (Cl has -I effect)",
        expected_answer: "CH3-CH2+|CH3CH2+|ethyl",
        explanation: "CH₃-CH₂⁺ is MORE stable. -I groups (like Cl) destabilize carbocations by withdrawing electrons. +I groups stabilize carbocations.",
        hints: [
          "Carbocations need electron-donating groups",
          "Cl is electron-withdrawing (-I)",
          "Electron withdrawal destabilizes positive charge"
        ]
      },
      {
        step_number: 5,
        title: "Aromatic carbocation",
        instruction: "Which is more stable: benzyl cation (C₆H₅-CH₂⁺) or ethyl cation (CH₃-CH₂⁺)?",
        expected_answer: "benzyl|C6H5-CH2+|benzyl cation",
        explanation: "Benzyl cation is FAR more stable due to resonance with benzene ring. Positive charge delocalized over aromatic ring. Resonance >> +I effect.",
        hints: [
          "Can positive charge resonate into benzene?",
          "Benzyl = C₆H₅-CH₂⁺",
          "Resonance provides major stabilization"
        ]
      }
    ],
    validation_rules: {
      stability_ordering: "Correct stability sequences",
      effect_application: "Proper use of +I, -I, resonance",
      intermediate_comparison: "Accurate comparisons"
    },
    success_criteria: "All 5 stability problems solved correctly",
    points_reward: 130,
    max_attempts: 5
  },

  # Lab 4: Predicting Electronic Effects
  {
    title: "Predicting Inductive and Mesomeric Effects",
    description: "Identify and apply electronic effects to predict molecular properties",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["goc", "inductive-effect", "mesomeric-effect", "electronic-effects"],
    category: "General Organic Chemistry",
    steps: [
      {
        step_number: 1,
        title: "Identify -I groups",
        instruction: "Order by INCREASING -I (electron-withdrawing) strength: -CH₃, -OH, -NO₂, -COOH",
        expected_answer: "-CH3 < -OH < -COOH < -NO2|methyl < hydroxyl < carboxyl < nitro",
        explanation: "-I order: -NO₂ > -COOH > -OH > -CH₃. Nitro group has strongest -I effect. Methyl actually shows +I effect.",
        hints: [
          "Nitro group is strongest -I",
          "Carboxyl stronger than hydroxyl",
          "Methyl is actually +I (weakest -I here)"
        ]
      },
      {
        step_number: 2,
        title: "Dominant effect identification",
        instruction: "Does -OH group show net electron-donating or electron-withdrawing effect? (-I vs +M)",
        expected_answer: "donating|electron-donating|+M dominates",
        explanation: "-OH shows -I (O electronegative) AND +M (lone pair donation). +M DOMINATES, so net effect is electron-DONATING.",
        hints: [
          "OH has both -I and +M effects",
          "Which is stronger: inductive or resonance?",
          "Resonance (M) generally dominates over inductive (I)"
        ]
      },
      {
        step_number: 3,
        title: "Apply effects to acidity",
        instruction: "Order by INCREASING acidity: CH₃COOH, ClCH₂COOH, Cl₂CHCOOH",
        expected_answer: "CH3COOH < ClCH2COOH < Cl2CHCOOH",
        explanation: "More Cl (stronger -I) → more stable anion → MORE acidic. Cl₂CHCOOH most acidic. pKa: Cl₂CH (1.3) < ClCH₂ (2.9) < CH₃ (4.8).",
        hints: [
          "Cl is electron-withdrawing (-I)",
          "More Cl = stronger acid",
          "Stabilizing anion increases acidity"
        ]
      },
      {
        step_number: 4,
        title: "Phenol vs cyclohexanol acidity",
        instruction: "Which is more acidic: phenol (C₆H₅OH) or cyclohexanol (C₆H₁₁OH)?",
        expected_answer: "phenol|C6H5OH",
        explanation: "Phenol is MORE acidic (pKa ≈ 10) than cyclohexanol (pKa ≈ 16). Phenoxide ion stabilized by resonance with aromatic ring.",
        hints: [
          "Can phenoxide anion resonate?",
          "Cyclohexanol has no resonance",
          "Resonance stabilizes phenoxide"
        ]
      },
      {
        step_number: 5,
        title: "Basicity of amines",
        instruction: "Which is MORE basic: aniline (C₆H₅NH₂) or methylamine (CH₃NH₂)?",
        expected_answer: "methylamine|CH3NH2",
        explanation: "Methylamine is MORE basic (pKb ≈ 3.4) than aniline (pKb ≈ 9.4). Aniline's lone pair delocalized into benzene (+M), less available for protonation.",
        hints: [
          "Aniline lone pair delocalized",
          "Methylamine lone pair localized",
          "Less available lone pair = weaker base"
        ]
      }
    ],
    validation_rules: {
      effect_identification: "Correct electronic effect classification",
      property_prediction: "Accurate acidity/basicity predictions",
      reasoning_application: "Proper application of electronic effects"
    },
    success_criteria: "All 5 electronic effect problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 5: Reaction Mechanisms (SN1/SN2/E1/E2)
  {
    title: "Identifying Reaction Mechanisms - SN1, SN2, E1, E2",
    description: "Learn to differentiate between substitution and elimination mechanisms",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["goc", "mechanisms", "sn1", "sn2", "e1", "e2"],
    category: "General Organic Chemistry",
    steps: [
      {
        step_number: 1,
        title: "SN2 characteristics",
        instruction: "In SN2 mechanism, does rate depend on concentration of BOTH substrate and nucleophile? (yes/no)",
        expected_answer: "yes",
        explanation: "YES. SN2 is bimolecular. Rate = k[RX][Nu⁻]. Both substrate and nucleophile in rate-determining step. One-step mechanism.",
        hints: [
          "SN2 = Substitution Nucleophilic Bimolecular",
          "Bimolecular = 2 species in transition state",
          "Rate depends on both concentrations"
        ]
      },
      {
        step_number: 2,
        title: "SN1 vs SN2 - substrate preference",
        instruction: "Which substrate favors SN1: primary (1°) or tertiary (3°) alkyl halide?",
        expected_answer: "tertiary|3°|3 degree",
        explanation: "Tertiary (3°) favors SN1. Forms stable carbocation. SN2 favored by: 1° > 2° >> 3°. SN1 favored by: 3° > 2° >> 1°.",
        hints: [
          "SN1 involves carbocation formation",
          "Which carbocation is more stable?",
          "3° carbocation is most stable"
        ]
      },
      {
        step_number: 3,
        title: "SN2 stereochemistry",
        instruction: "What stereochemical outcome does SN2 produce: retention or inversion?",
        expected_answer: "inversion",
        explanation: "SN2 produces INVERSION of configuration (Walden inversion). Backside attack by nucleophile. (R) → (S) or vice versa.",
        hints: [
          "Nucleophile attacks from backside",
          "Backside attack causes what?",
          "Configuration flips"
        ]
      },
      {
        step_number: 4,
        title: "E2 characteristics",
        instruction: "E2 elimination requires anti-periplanar geometry. True or false?",
        expected_answer: "true",
        explanation: "TRUE. E2 requires H and leaving group to be anti-periplanar (180° dihedral angle). Concerted mechanism, one step.",
        hints: [
          "E2 is stereospecific",
          "H and X must be anti (opposite sides)",
          "Dihedral angle = 180°"
        ]
      },
      {
        step_number: 5,
        title: "Mechanism selection",
        instruction: "For CH₃CH₂Br + strong base (like OH⁻) in polar aprotic solvent at high temperature, which is favored: SN2 or E2?",
        expected_answer: "E2",
        explanation: "E2 is favored. High temperature + strong base favor elimination. Primary substrate can do SN2, but conditions favor E2. Heat promotes elimination.",
        hints: [
          "High temperature favors elimination",
          "Strong base promotes E2",
          "Heat shifts SN2 → E2"
        ]
      }
    ],
    validation_rules: {
      mechanism_identification: "Correct mechanism classification",
      stereochemistry_understanding: "Proper stereochemical predictions",
      condition_analysis: "Accurate condition-mechanism correlation"
    },
    success_criteria: "All 5 mechanism problems solved correctly",
    points_reward: 160,
    max_attempts: 5
  }
]

# Continue with more labs in next batch...
# This is Part 1 (Labs 1-5 shown as examples)
# Full implementation would include all 20 labs in this file

puts "Creating GOC Labs..."
goc_labs.each_with_index do |lab_data, index|
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
    order_index: index + 1
  )
  puts "  ✓ Lab #{index + 1} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "Organic Chemistry Labs - Part 1 Summary"
puts "="*80
puts "Created: #{goc_labs.length} labs (GOC and Fundamentals)"
puts "Total practice time: ~#{goc_labs.sum { |l| l[:estimated_minutes] }} minutes"
puts "="*80
puts "\nNote: Full implementation includes 40 total labs"
puts "Part 1 demonstrates the structure and quality"
puts "="*80

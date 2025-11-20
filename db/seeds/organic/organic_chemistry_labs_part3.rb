# Organic Chemistry Hands-On Labs - Part 3 (Labs 16-25)
# Covers: Reaction Mechanisms (continued) and Functional Group Transformations

puts "Creating Organic Chemistry Hands-On Labs (Part 3: Labs 16-25)..."

course_organic = Course.find_by(title: 'Organic Chemistry for IIT JEE Main & Advanced')

unless course_organic
  puts "Error: Organic Chemistry course not found!"
  exit
end

# ============================================================================
# CATEGORY 3: REACTION MECHANISMS (continued) (Labs 16-20)
# ============================================================================

mechanism_labs_continued = [
  # Lab 16: Directive Effects in Benzene Substitution
  {
    title: "Directive Effects in Benzene - Predicting Substitution Patterns",
    description: "Master predicting substitution positions based on existing substituents",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "EAS", "directive-effects", "benzene"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "Classify directive groups",
        instruction: "Is -Cl an ortho/para director or meta director?",
        expected_answer: "ortho/para|o/p",
        explanation: "-Cl is o/p director despite being deactivating. Lone pairs on Cl provide +M effect (donates through resonance) which outweighs -I effect for directive purposes.",
        hints: ["Halogens are special", "Deactivating but o/p directing", "Lone pairs provide resonance"]
      },
      {
        step_number: 2,
        title: "Strong activators",
        instruction: "Order these by ACTIVATING strength (highest first): -OH, -OCH₃, -NH₂",
        expected_answer: "-NH2 > -OH > -OCH3|-NH2, -OH, -OCH3",
        explanation: "Order: -NH₂ > -OH > -OCH₃. All are strong activators (+M effect). N donates better than O. -OCH₃ slightly weaker due to +I from CH₃.",
        hints: ["All are +M groups", "N is less electronegative than O", "NH₂ strongest donor"]
      },
      {
        step_number: 3,
        title: "Predict nitration of anisole",
        instruction: "In anisole (C₆H₅-OCH₃) nitration, where does NO₂ go? (position)",
        expected_answer: "ortho/para|o/p",
        explanation: "Ortho and para positions. -OCH₃ is strong o/p director (+M effect). Typically get mixture of o- and p-nitroanisole.",
        hints: ["-OCH₃ is electron-donating", "Strong +M effect", "o/p director"]
      },
      {
        step_number: 4,
        title: "Meta director prediction",
        instruction: "Benzoic acid (C₆H₅-COOH) undergoes nitration. Where does NO₂ go?",
        expected_answer: "meta|m",
        explanation: "Meta position. -COOH is meta director (strong -I and -M effects, deactivating). NO₂ goes to meta (least destabilized position).",
        hints: ["-COOH is electron-withdrawing", "Deactivating group", "Meta director"]
      },
      {
        step_number: 5,
        title: "Competing directors",
        instruction: "In p-nitrotoluene, if we add another substituent, which group dominates: -CH₃ or -NO₂?",
        expected_answer: "-CH3|methyl",
        explanation: "-CH₃ dominates (activating groups > deactivating). -CH₃ is o/p director (stronger). New substituent goes ortho to -CH₃.",
        hints: ["Activating beats deactivating", "-CH₃ is stronger director", "o/p director wins"]
      }
    ],
    validation_rules: {
      directive_classification: "Correct o/p vs m identification",
      strength_comparison: "Accurate activation/deactivation ordering",
      position_prediction: "Correct substitution position"
    },
    success_criteria: "All 5 directive effect problems solved",
    points_reward: 165,
    max_attempts: 5
  },

  # Lab 17: Grignard Reaction Product Prediction
  {
    title: "Grignard Reactions - Product Prediction and Synthesis",
    description: "Master Grignard reagent reactions with carbonyl compounds",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "grignard", "carbonyl", "synthesis"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "Grignard reagent reactivity",
        instruction: "What is the nucleophilic part in CH₃-MgBr?",
        expected_answer: "CH3|methyl|carbanion",
        explanation: "CH₃⁻ is nucleophilic (carbanion character). Mg-C bond is polarized: δ⁻C-Mg⁺δ. CH₃ acts as nucleophile attacking electrophiles.",
        hints: ["C is more electronegative than Mg", "C has partial negative charge", "Acts like carbanion"]
      },
      {
        step_number: 2,
        title: "Grignard + formaldehyde",
        instruction: "CH₃-MgBr + H-CHO then H₃O⁺ → ? (final product)",
        expected_answer: "CH3CH2OH|ethanol",
        explanation: "CH₃-CH₂-OH (ethanol, 1° alcohol). Mechanism: CH₃⁻ attacks formaldehyde → CH₃-CH₂-O⁻-MgBr → H₃O⁺ → CH₃-CH₂-OH.",
        hints: ["Formaldehyde → 1° alcohol", "CH₃ adds to C=O", "Protonation gives alcohol"]
      },
      {
        step_number: 3,
        title: "Grignard + acetaldehyde",
        instruction: "CH₃-MgBr + CH₃-CHO then H₃O⁺ → ? (final product)",
        expected_answer: "CH3-CH(OH)-CH3|2-propanol|isopropanol",
        explanation: "CH₃-CH(OH)-CH₃ (2-propanol, 2° alcohol). CH₃⁻ attacks acetaldehyde → CH₃-CH(O⁻MgBr)-CH₃ → H₃O⁺ → 2° alcohol.",
        hints: ["Aldehyde (not formaldehyde) → 2° alcohol", "CH₃ adds to CHO", "2° alcohol product"]
      },
      {
        step_number: 4,
        title: "Grignard + ketone",
        instruction: "CH₃-MgBr + CH₃-CO-CH₃ then H₃O⁺ → ? (final product)",
        expected_answer: "(CH3)3COH|tert-butanol|2-methylpropan-2-ol",
        explanation: "(CH₃)₃C-OH (tert-butanol, 3° alcohol). CH₃⁻ attacks ketone → (CH₃)₃C-O⁻MgBr → H₃O⁺ → 3° alcohol.",
        hints: ["Ketone → 3° alcohol", "Three methyl groups + OH", "Tertiary alcohol"]
      },
      {
        step_number: 5,
        title: "Reverse synthesis",
        instruction: "To make 1-phenylethanol (C₆H₅-CH(OH)-CH₃), which Grignard + carbonyl?",
        expected_answer: "C6H5MgBr + CH3CHO|PhMgBr + acetaldehyde",
        explanation: "C₆H₅-MgBr (phenyl Grignard) + CH₃-CHO (acetaldehyde). OR CH₃-MgBr + C₆H₅-CHO also works. 2° alcohol from Grignard + aldehyde.",
        hints: ["2° alcohol from aldehyde + Grignard", "Two options possible", "Ph-MgBr + CH₃CHO"]
      }
    ],
    validation_rules: {
      nucleophile_identification: "Correct nucleophilic center",
      product_prediction: "Accurate alcohol product",
      retrosynthesis: "Correct starting material identification"
    },
    success_criteria: "All 5 Grignard problems solved",
    points_reward: 155,
    max_attempts: 5
  },

  # Lab 18: Aldol Condensation Step-by-Step
  {
    title: "Aldol Condensation - Mechanism and Products",
    description: "Master aldol addition and condensation reactions",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "aldol", "carbonyl", "condensation"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "Aldol requirements",
        instruction: "For aldol to occur, what must the aldehyde/ketone have?",
        expected_answer: "alpha hydrogen|α-hydrogen|α-H",
        explanation: "Alpha hydrogen (α-H). Needed to form enolate ion. No α-H = no aldol. Example: formaldehyde has α-H, benzaldehyde does not.",
        hints: ["On carbon next to C=O", "Needed for enolate formation", "Alpha position"]
      },
      {
        step_number: 2,
        title: "Aldol addition product",
        instruction: "2 CH₃-CHO + NaOH (dilute) → ? (aldol addition product)",
        expected_answer: "CH3-CH(OH)-CH2-CHO|3-hydroxybutanal",
        explanation: "CH₃-CH(OH)-CH₂-CHO (3-hydroxybutanal, aldol). Enolate from one attacks C=O of other. β-hydroxy aldehyde.",
        hints: ["β-hydroxy aldehyde", "Two acetaldehydes combine", "OH at beta position"]
      },
      {
        step_number: 3,
        title: "Aldol condensation",
        instruction: "If aldol product (β-hydroxy carbonyl) is heated, what happens?",
        expected_answer: "dehydration|loses water|forms α,β-unsaturated carbonyl",
        explanation: "Dehydration (loses H₂O). Forms α,β-unsaturated carbonyl. β-OH and α-H eliminated → C=C forms. Conjugated system.",
        hints: ["Heat causes dehydration", "Water molecule lost", "Forms double bond"]
      },
      {
        step_number: 4,
        title: "Aldol condensation product",
        instruction: "2 CH₃-CHO + NaOH then heat → ? (condensation product)",
        expected_answer: "CH3-CH=CH-CHO|crotonaldehyde|but-2-enal",
        explanation: "CH₃-CH=CH-CHO (crotonaldehyde, but-2-enal). α,β-unsaturated aldehyde. Conjugated C=C-C=O.",
        hints: ["Aldol then dehydration", "α,β-unsaturated aldehyde", "Conjugated system"]
      },
      {
        step_number: 5,
        title: "Cross-aldol consideration",
        instruction: "Why is aldol between two DIFFERENT aldehydes (both with α-H) problematic?",
        expected_answer: "mixture of products|multiple products|4 products",
        explanation: "Gives mixture: 4 possible products (2 self-aldol + 2 cross-aldol). Both can form enolate, both can be electrophile. Not selective.",
        hints: ["Each can be nucleophile OR electrophile", "Multiple combinations", "Not practical synthesis"]
      }
    ],
    validation_rules: {
      requirement_understanding: "α-H necessity",
      mechanism_steps: "Correct aldol addition vs condensation",
      product_prediction: "Accurate β-hydroxy or α,β-unsaturated products"
    },
    success_criteria: "All 5 aldol condensation problems solved",
    points_reward: 165,
    max_attempts: 5
  },

  # Lab 19: Cannizzaro vs Aldol - Choosing Mechanism
  {
    title: "Cannizzaro vs Aldol - Mechanism Selection",
    description: "Learn when Cannizzaro or Aldol reactions occur",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "cannizzaro", "aldol", "carbonyl"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "Cannizzaro requirement",
        instruction: "Cannizzaro reaction requires aldehyde with or without α-hydrogen?",
        expected_answer: "without|no α-H|no alpha hydrogen",
        explanation: "WITHOUT α-hydrogen. Aldehydes with NO α-H undergo Cannizzaro with strong base. Examples: HCHO, C₆H₅-CHO.",
        hints: ["No α-H present", "Cannot form enolate", "Formaldehyde, benzaldehyde"]
      },
      {
        step_number: 2,
        title: "Cannizzaro products",
        instruction: "2 HCHO + conc. NaOH → ? (two products)",
        expected_answer: "CH3OH + HCOONa|methanol + sodium formate",
        explanation: "CH₃OH (methanol) + HCOO⁻Na⁺ (sodium formate). Disproportionation: one HCHO reduced, one oxidized. Alcohol + carboxylate salt.",
        hints: ["One oxidized, one reduced", "Alcohol + salt of acid", "Disproportionation"]
      },
      {
        step_number: 3,
        title: "Choose mechanism: acetaldehyde",
        instruction: "CH₃-CHO + NaOH → Aldol or Cannizzaro?",
        expected_answer: "aldol",
        explanation: "Aldol. Acetaldehyde HAS α-H (on CH₃). Forms enolate → aldol reaction. Cannizzaro only for NO α-H.",
        hints: ["Has α-H on methyl", "Can form enolate", "Aldol preferred"]
      },
      {
        step_number: 4,
        title: "Choose mechanism: benzaldehyde",
        instruction: "C₆H₅-CHO + conc. NaOH → Aldol or Cannizzaro?",
        expected_answer: "cannizzaro",
        explanation: "Cannizzaro. Benzaldehyde has NO α-H (CHO directly on benzene). Cannot form enolate → disproportionation.",
        hints: ["No α-H available", "Cannot do aldol", "Cannizzaro occurs"]
      },
      {
        step_number: 5,
        title: "Cannizzaro products from benzaldehyde",
        instruction: "2 C₆H₅-CHO + NaOH → ? (two products)",
        expected_answer: "C6H5CH2OH + C6H5COONa|benzyl alcohol + sodium benzoate",
        explanation: "C₆H₅-CH₂-OH (benzyl alcohol) + C₆H₅-COO⁻Na⁺ (sodium benzoate). One reduced to alcohol, one oxidized to carboxylic acid salt.",
        hints: ["Disproportionation", "Alcohol + carboxylate salt", "Benzyl alcohol + benzoate"]
      }
    ],
    validation_rules: {
      condition_analysis: "Correct α-H presence/absence identification",
      mechanism_selection: "Accurate aldol vs Cannizzaro choice",
      product_prediction: "Correct disproportionation products"
    },
    success_criteria: "All 5 mechanism selection problems solved",
    points_reward: 140,
    max_attempts: 5
  },

  # Lab 20: SN1 vs SN2 vs E1 vs E2 Decision Tree
  {
    title: "SN1/SN2/E1/E2 - Mechanism Prediction and Competition",
    description: "Master predicting which mechanism operates under different conditions",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["mechanisms", "SN1", "SN2", "E1", "E2", "substitution", "elimination"],
    category: "Reaction Mechanisms",
    steps: [
      {
        step_number: 1,
        title: "Substrate reactivity for SN2",
        instruction: "Order by SN2 reactivity (fastest first): CH₃-X, 1°, 2°, 3°",
        expected_answer: "CH3 > 1° > 2° > 3°|methyl > primary > secondary > tertiary",
        explanation: "CH₃-X > 1° > 2° > 3°. SN2 requires backside attack. More substitution = more steric hindrance. 3° essentially no SN2.",
        hints: ["Backside attack mechanism", "Steric hindrance matters", "Less substituted = faster"]
      },
      {
        step_number: 2,
        title: "Substrate reactivity for SN1",
        instruction: "Order by SN1 reactivity (fastest first): CH₃-X, 1°, 2°, 3°",
        expected_answer: "3° > 2° > 1° > CH3|tertiary > secondary > primary > methyl",
        explanation: "3° > 2° > 1° > CH₃-X. SN1 via carbocation. More substituted = more stable carbocation. 3° fastest.",
        hints: ["Carbocation intermediate", "Stability matters", "More substituted = faster"]
      },
      {
        step_number: 3,
        title: "Strong base + 2° substrate",
        instruction: "2° alkyl halide + strong bulky base (like t-BuO⁻) → major product type?",
        expected_answer: "E2|elimination",
        explanation: "E2 elimination (major). Strong bulky base favors elimination over substitution. Forms alkene via E2 mechanism.",
        hints: ["Strong base favors elimination", "Bulky base = more elimination", "E2 concerted mechanism"]
      },
      {
        step_number: 4,
        title: "Weak base + 3° substrate",
        instruction: "3° alkyl halide + weak nucleophile/base (like H₂O, ROH) → major mechanism?",
        expected_answer: "SN1 and E1|SN1/E1",
        explanation: "SN1 and E1 (both occur). Weak nucleophile/base with 3° halide. Forms carbocation → substitution (SN1) OR elimination (E1). Mixture.",
        hints: ["3° favors carbocation", "Weak nucleophile", "Both SN1 and E1 possible"]
      },
      {
        step_number: 5,
        title: "Optimal SN2 conditions",
        instruction: "For best SN2, use: 1° or 3° substrate, and strong or weak nucleophile?",
        expected_answer: "1° substrate and strong nucleophile|primary and strong",
        explanation: "1° substrate + strong nucleophile (like CN⁻, I⁻, RS⁻). Less steric hindrance, strong nucleophile, polar aprotic solvent (like DMSO, acetone).",
        hints: ["Need backside access", "Strong nucleophile attacks", "Primary substrate best"]
      }
    ],
    validation_rules: {
      mechanism_distinction: "Clear SN1/SN2/E1/E2 differences",
      condition_analysis: "Correct condition interpretation",
      major_product_prediction: "Accurate mechanism selection"
    },
    success_criteria: "All 5 mechanism prediction problems solved",
    points_reward: 170,
    max_attempts: 5
  }
]

# ============================================================================
# CATEGORY 4: FUNCTIONAL GROUP TRANSFORMATIONS (Labs 21-25)
# ============================================================================

functional_group_labs = [
  # Lab 21: Converting Alcohols to Halides - Reagent Selection
  {
    title: "Alcohol to Halide Conversions - Reagent Selection",
    description: "Master reagent selection for converting alcohols to alkyl halides",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["functional-groups", "alcohols", "halides", "reagents"],
    category: "Functional Group Transformations",
    steps: [
      {
        step_number: 1,
        title: "HCl reagent for alcohol",
        instruction: "To convert R-OH to R-Cl, what reagent besides HCl can be used?",
        expected_answer: "SOCl2|thionyl chloride|PCl5|PCl3",
        explanation: "SOCl₂ (thionyl chloride, best), PCl₅, or PCl₃. SOCl₂ gives clean product (byproducts SO₂ and HCl gas escape). PCl₅ also works.",
        hints: ["Thionyl chloride is common", "SOCl₂", "Also PCl₅ or PCl₃"]
      },
      {
        step_number: 2,
        title: "HBr formation from alcohol",
        instruction: "R-OH + HBr → R-Br. Which catalyst helps? (acid)",
        expected_answer: "H2SO4|conc. H2SO4|sulfuric acid",
        explanation: "Conc. H₂SO₄ as catalyst. Or use PBr₃ as reagent (better). R-OH + HBr/H₂SO₄ → R-Br + H₂O.",
        hints: ["Acid catalyst", "Sulfuric acid", "Protonates OH"]
      },
      {
        step_number: 3,
        title: "Best reagent for R-OH → R-I",
        instruction: "What is the best reagent to convert alcohol to iodide?",
        expected_answer: "PI3|red P + I2|phosphorus triiodide",
        explanation: "PI₃ or red P + I₂ (generates PI₃ in situ). HI can also be used but less common. PI₃ is best.",
        hints: ["Phosphorus triiodide", "Red P + I₂", "PI₃"]
      },
      {
        step_number: 4,
        title: "Reagent stereochemistry",
        instruction: "Does SOCl₂ conversion of 2° alcohol to chloride give retention or inversion of configuration?",
        expected_answer: "inversion",
        explanation: "Inversion (SN2-like). SOCl₂ → R-OH-SO-Cl → Cl⁻ attacks from backside → inversion. (Note: with pyridine, retention possible via different mechanism).",
        hints: ["Backside attack", "SN2 mechanism", "Configuration flips"]
      },
      {
        step_number: 5,
        title: "Compare reagents",
        instruction: "Which is milder: SOCl₂ or PCl₅?",
        expected_answer: "SOCl2|thionyl chloride",
        explanation: "SOCl₂ is milder. PCl₅ is more vigorous. SOCl₂ advantages: gaseous byproducts, clean product, milder conditions.",
        hints: ["Thionyl chloride preferred", "SOCl₂ gives clean product", "Gaseous byproducts"]
      }
    ],
    validation_rules: {
      reagent_selection: "Correct reagent choice",
      mechanism_understanding: "Proper stereochemistry",
      comparison: "Accurate reagent comparison"
    },
    success_criteria: "All 5 alcohol to halide problems solved",
    points_reward: 125,
    max_attempts: 5
  },

  # Lab 22: Oxidation of Alcohols - Product Prediction
  {
    title: "Oxidation of Alcohols - Reagents and Products",
    description: "Master oxidation reactions and predict carbonyl products",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["functional-groups", "alcohols", "oxidation", "carbonyl"],
    category: "Functional Group Transformations",
    steps: [
      {
        step_number: 1,
        title: "1° alcohol oxidation",
        instruction: "CH₃-CH₂-OH + [O] (mild) → ? (product)",
        expected_answer: "CH3CHO|acetaldehyde|ethanal",
        explanation: "CH₃-CHO (acetaldehyde). 1° alcohol → aldehyde (mild oxidation). Reagent: PCC or PDC (doesn't oxidize further to acid).",
        hints: ["1° alcohol oxidizes to aldehyde", "Mild oxidation", "Aldehyde product"]
      },
      {
        step_number: 2,
        title: "1° alcohol strong oxidation",
        instruction: "CH₃-CH₂-OH + [O] (strong) → ? (final product)",
        expected_answer: "CH3COOH|acetic acid|ethanoic acid",
        explanation: "CH₃-COOH (acetic acid). Strong oxidation (K₂Cr₂O₇/H⁺, KMnO₄). 1° alcohol → aldehyde → carboxylic acid.",
        hints: ["Strong oxidizing agent", "Goes all the way to acid", "Carboxylic acid"]
      },
      {
        step_number: 3,
        title: "2° alcohol oxidation",
        instruction: "CH₃-CH(OH)-CH₃ + [O] → ? (product)",
        expected_answer: "CH3-CO-CH3|acetone|propanone",
        explanation: "(CH₃)₂C=O (acetone). 2° alcohol → ketone. Reagent: any oxidizing agent (K₂Cr₂O₇, PCC, KMnO₄). Cannot oxidize further.",
        hints: ["2° alcohol gives ketone", "Cannot oxidize further", "Ketone product"]
      },
      {
        step_number: 4,
        title: "3° alcohol oxidation",
        instruction: "Can 3° alcohols be oxidized to carbonyl? (yes/no)",
        expected_answer: "no",
        explanation: "No. 3° alcohols resist oxidation (no H on C-OH). Would need to break C-C bond (harsh conditions). No carbonyl product under normal conditions.",
        hints: ["No H on carbinol carbon", "Cannot form C=O without breaking C-C", "Resistant to oxidation"]
      },
      {
        step_number: 5,
        title: "PCC vs K₂Cr₂O₇",
        instruction: "Which reagent stops at aldehyde for 1° alcohol: PCC or K₂Cr₂O₇/H⁺?",
        expected_answer: "PCC|pyridinium chlorochromate",
        explanation: "PCC (pyridinium chlorochromate). Mild oxidant, stops at aldehyde. K₂Cr₂O₇/H⁺ is strong, goes to carboxylic acid.",
        hints: ["Mild oxidizing agent", "Stops at aldehyde", "PCC in CH₂Cl₂"]
      }
    ],
    validation_rules: {
      product_prediction: "Correct oxidation products",
      reagent_selection: "Appropriate oxidizing agent",
      oxidation_level: "Accurate oxidation state"
    },
    success_criteria: "All 5 oxidation problems solved",
    points_reward: 135,
    max_attempts: 5
  },

  # Lab 23: Kolbe and Reimer-Tiemann Reactions
  {
    title: "Kolbe and Reimer-Tiemann Reactions of Phenols",
    description: "Master CO₂ and CHCl₃ reactions with phenoxide ion",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["functional-groups", "phenols", "kolbe", "reimer-tiemann"],
    category: "Functional Group Transformations",
    steps: [
      {
        step_number: 1,
        title: "Kolbe reaction conditions",
        instruction: "Kolbe reaction uses phenol + NaOH + ? (reagent) under pressure",
        expected_answer: "CO2|carbon dioxide",
        explanation: "CO₂ (carbon dioxide). Phenol + NaOH → phenoxide → CO₂ (4-7 atm, 125°C) → salicylate → H⁺ → salicylic acid.",
        hints: ["Carbon dioxide", "Under pressure", "Forms carboxylic acid"]
      },
      {
        step_number: 2,
        title: "Kolbe product",
        instruction: "Phenol + NaOH + CO₂ then H⁺ → ? (major product)",
        expected_answer: "o-hydroxybenzoic acid|salicylic acid|2-hydroxybenzoic acid",
        explanation: "o-Hydroxybenzoic acid (salicylic acid). COOH at ortho position to OH. Electrophile (CO₂) attacks ortho.",
        hints: ["Salicylic acid", "COOH at ortho", "OH and COOH on benzene"]
      },
      {
        step_number: 3,
        title: "Reimer-Tiemann reagent",
        instruction: "Reimer-Tiemann uses phenol + NaOH + ? (reagent)",
        expected_answer: "CHCl3|chloroform",
        explanation: "CHCl₃ (chloroform). Base generates :CCl₂ (dichlorocarbene) → inserts at ortho → o-hydroxybenzaldehyde (salicylaldehyde).",
        hints: ["Chloroform", "Forms carbene", "CHCl₃"]
      },
      {
        step_number: 4,
        title: "Reimer-Tiemann product",
        instruction: "Phenol + NaOH + CHCl₃ then H⁺ → ? (major product)",
        expected_answer: "o-hydroxybenzaldehyde|salicylaldehyde",
        explanation: "o-Hydroxybenzaldehyde (salicylaldehyde). CHO at ortho position to OH. Mechanism: dichlorocarbene insertion.",
        hints: ["Salicylaldehyde", "CHO at ortho", "Aldehyde group"]
      },
      {
        step_number: 5,
        title: "Compare Kolbe vs Reimer-Tiemann",
        instruction: "Kolbe introduces COOH or CHO group?",
        expected_answer: "COOH|carboxylic acid",
        explanation: "COOH (carboxylic acid) via Kolbe. CHO (aldehyde) via Reimer-Tiemann. Both ortho to OH. Kolbe uses CO₂, R-T uses CHCl₃.",
        hints: ["Kolbe → COOH", "Reimer-Tiemann → CHO", "Different functional groups"]
      }
    ],
    validation_rules: {
      reaction_identification: "Correct reaction type",
      reagent_knowledge: "Accurate reagent identification",
      product_prediction: "Correct ortho-substituted phenol products"
    },
    success_criteria: "All 5 Kolbe and Reimer-Tiemann problems solved",
    points_reward: 150,
    max_attempts: 5
  },

  # Lab 24: Nucleophilic Addition to Carbonyls
  {
    title: "Nucleophilic Addition to Carbonyls - Product Prediction",
    description: "Master nucleophilic additions to aldehydes and ketones",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["functional-groups", "carbonyl", "nucleophilic-addition", "aldehydes", "ketones"],
    category: "Functional Group Transformations",
    steps: [
      {
        step_number: 1,
        title: "HCN addition",
        instruction: "CH₃-CHO + HCN → ? (product)",
        expected_answer: "CH3-CH(OH)-CN|cyanohydrin",
        explanation: "CH₃-CH(OH)-CN (cyanohydrin). CN⁻ attacks C=O → CH₃-CH(O⁻)-CN → H⁺ → cyanohydrin. Both -OH and -CN on same carbon.",
        hints: ["Cyanohydrin formation", "CN and OH on same C", "Addition product"]
      },
      {
        step_number: 2,
        title: "NaHSO₃ addition",
        instruction: "CH₃-CHO + NaHSO₃ → ? (type of product)",
        expected_answer: "bisulfite adduct|α-hydroxy sulfonic acid",
        explanation: "Bisulfite adduct (CH₃-CH(OH)-SO₃Na). HSO₃⁻ attacks C=O. Water-soluble crystalline solid. Useful for purification.",
        hints: ["Bisulfite addition", "SO₃Na group added", "Crystalline product"]
      },
      {
        step_number: 3,
        title: "NH₂-OH addition",
        instruction: "CH₃-CHO + NH₂-OH → ? (functional group formed)",
        expected_answer: "oxime|C=N-OH",
        explanation: "Oxime (CH₃-CH=N-OH). Nucleophilic addition-elimination. C=O → C=N-OH. Water eliminated.",
        hints: ["Oxime formation", "C=N-OH", "Elimination of water"]
      },
      {
        step_number: 4,
        title: "NH₂-NH₂ addition",
        instruction: "CH₃-CHO + NH₂-NH₂ → ? (functional group formed)",
        expected_answer: "hydrazone|C=N-NH2",
        explanation: "Hydrazone (CH₃-CH=N-NH₂). Similar to oxime but C=N-NH₂. Addition-elimination mechanism.",
        hints: ["Hydrazone formation", "C=N-NH₂", "From hydrazine"]
      },
      {
        step_number: 5,
        title: "2,4-DNP test",
        instruction: "2,4-dinitrophenylhydrazine (2,4-DNP) + aldehyde/ketone → ?",
        expected_answer: "2,4-DNP hydrazone|yellow/orange precipitate",
        explanation: "2,4-DNP hydrazone (yellow/orange precipitate). Test for aldehydes and ketones. Forms colored crystalline derivative. Used for identification.",
        hints: ["Yellow/orange precipitate", "Hydrazone derivative", "Diagnostic test"]
      }
    ],
    validation_rules: {
      mechanism_understanding: "Correct addition-elimination mechanism",
      product_identification: "Accurate functional group recognition",
      reaction_type: "Proper classification of additions"
    },
    success_criteria: "All 5 nucleophilic addition problems solved",
    points_reward: 160,
    max_attempts: 5
  },

  # Lab 25: Distinguishing Aldehydes and Ketones
  {
    title: "Distinguishing Aldehydes and Ketones - Chemical Tests",
    description: "Master chemical tests to differentiate aldehydes from ketones",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "chemistry_problem",
    lab_format: "problem_solving",
    tags: ["functional-groups", "aldehydes", "ketones", "tests"],
    category: "Functional Group Transformations",
    steps: [
      {
        step_number: 1,
        title: "Tollens' test",
        instruction: "Which gives positive Tollens' test: aldehydes or ketones?",
        expected_answer: "aldehydes",
        explanation: "Aldehydes (positive). Tollens' reagent (Ag(NH₃)₂⁺) oxidizes aldehydes → silver mirror (Ag⁰). Ketones: negative (not oxidized).",
        hints: ["Silver mirror test", "Aldehydes are oxidized", "Ketones not oxidized"]
      },
      {
        step_number: 2,
        title: "Fehling's test result",
        instruction: "Fehling's test with aldehyde gives what color precipitate?",
        expected_answer: "red|reddish-brown",
        explanation: "Red/reddish-brown precipitate (Cu₂O). Fehling's (Cu²⁺ in alkali) oxidizes aldehyde → Cu₂O (red precipitate). Ketones: negative.",
        hints: ["Copper(I) oxide", "Red precipitate", "Cu₂O"]
      },
      {
        step_number: 3,
        title: "Iodoform test specificity",
        instruction: "Iodoform test is positive for CH₃-CO-R and ? (aldehyde)",
        expected_answer: "CH3CHO|acetaldehyde",
        explanation: "CH₃-CHO (acetaldehyde only). Iodoform test needs CH₃-CO- group (or CH₃-CH(OH)-). Methyl ketones + acetaldehyde → yellow CHI₃ precipitate.",
        hints: ["Needs CH₃-CO- group", "Only acetaldehyde among aldehydes", "Yellow precipitate"]
      },
      {
        step_number: 4,
        title: "Which aldehyde negative with Fehling's?",
        expected_answer: "aromatic aldehydes|benzaldehyde|C6H5CHO",
        explanation: "Aromatic aldehydes (like benzaldehyde). Fehling's/Benedict's are weak oxidants. Work with aliphatic aldehydes but NOT aromatic aldehydes.",
        hints: ["Benzaldehyde doesn't react", "Aromatic aldehydes resist", "Weak oxidizing conditions"]
      },
      {
        step_number: 5,
        title: "Best test to distinguish",
        instruction: "Best test to distinguish ANY aldehyde from ANY ketone?",
        expected_answer: "Tollens|silver mirror test",
        explanation: "Tollens' test. Works for ALL aldehydes (aliphatic and aromatic). All aldehydes: positive (silver mirror). All ketones: negative.",
        hints: ["Universal for aldehydes", "Silver mirror", "Works with aromatic too"]
      }
    ],
    validation_rules: {
      test_knowledge: "Correct test identification",
      result_interpretation: "Accurate positive/negative predictions",
      selectivity: "Understanding test limitations"
    },
    success_criteria: "All 5 distinguishing test problems solved",
    points_reward: 125,
    max_attempts: 5
  }
]

# Create all labs
puts "\nCreating Reaction Mechanisms (continued) Labs (16-20)..."
(mechanism_labs_continued + functional_group_labs).each_with_index do |lab_data, index|
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
    order_index: index + 16
  )
  puts "  ✓ Lab #{index + 16} created: #{lab_data[:title]}"
end

puts "\n" + "="*80
puts "Organic Chemistry Labs - Part 3 Summary"
puts "="*80
puts "Created: 10 labs (Mechanisms continued + Functional Groups)"
puts "Labs 16-20: Reaction Mechanisms (continued) (5 labs)"
puts "Labs 21-25: Functional Group Transformations (5 labs)"
puts "Total lab time: ~#{(mechanism_labs_continued + functional_group_labs).sum { |l| l[:estimated_minutes] }} minutes"
puts "="*80
puts "\nRunning total: 25 labs created (15 from Parts 1-2 + 10 from Part 3)"
puts "Remaining: 15 labs to reach 40-lab target (Labs 26-40)"
puts "="*80

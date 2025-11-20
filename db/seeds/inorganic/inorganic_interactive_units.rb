# Interactive Learning Units for Inorganic Chemistry
# 10 units modeled after Docker/Kubernetes interactive learning style
# Focus on conceptual understanding through guided exploration

puts "Creating 10 interactive learning units for Inorganic Chemistry..."

# Get course reference
course_inorganic = Course.find_by(title: 'Inorganic Chemistry for IIT JEE Main & Advanced')

unless course_inorganic
  puts "Error: Inorganic Chemistry course not found!"
  exit
end

# ============================================================================
# INTERACTIVE LEARNING UNITS (10 units)
# ============================================================================

interactive_units = [
  # Unit 1: Understanding Coordination Number
  {
    title: "Understanding Coordination Number - The Foundation of Complexes",
    description: "Master the concept of coordination number through interactive examples and pattern recognition",
    difficulty: "easy",
    estimated_minutes: 25,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Define coordination number accurately",
      "Count donor atoms correctly in various ligands",
      "Distinguish between monodentate, bidentate, and polydentate ligands",
      "Calculate coordination number in complex ions"
    ],
    key_concepts: [
      "Coordination number = number of donor atoms directly bonded to central metal",
      "Monodentate ligands: 1 donor atom (NH₃, Cl⁻, H₂O)",
      "Bidentate ligands: 2 donor atoms (en, ox²⁻)",
      "Polydentate ligands: 3+ donor atoms (EDTA = 6)"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Simple monodentate ligands",
        problem: "What is the coordination number in [Co(NH₃)₆]³⁺?",
        interactive_hints: [
          "Count the number of NH₃ ligands attached",
          "Each NH₃ is monodentate (1 donor N atom)",
          "Total donor atoms = coordination number"
        ],
        solution: "Coordination number = 6. Six NH₃ ligands, each with 1 donor atom = 6 total.",
        explanation: "NH₃ is monodentate (mono = one). It donates through the lone pair on nitrogen. Six NH₃ means six donor atoms."
      },
      {
        scenario_number: 2,
        title: "Mixed ligands",
        problem: "What is the coordination number in [Cr(H₂O)₄Cl₂]⁺?",
        interactive_hints: [
          "Count water molecules: each is monodentate",
          "Count chloride ions: each is monodentate",
          "Add them up"
        ],
        solution: "Coordination number = 6. 4 H₂O + 2 Cl⁻ = 6 donor atoms.",
        explanation: "Both H₂O (through O) and Cl⁻ are monodentate. 4 + 2 = 6."
      },
      {
        scenario_number: 3,
        title: "Bidentate ligand introduction",
        problem: "What is the coordination number in [Cu(en)₂]²⁺? (en = ethylenediamine)",
        interactive_hints: [
          "en is bidentate (2 donor N atoms per molecule)",
          "Count the number of 'en' molecules",
          "Multiply: (number of en) × 2"
        ],
        solution: "Coordination number = 4. 2 en × 2 donor atoms/en = 4.",
        explanation: "Ethylenediamine (en) has 2 NH₂ groups, so it's bidentate. Two en molecules = 4 donor atoms."
      },
      {
        scenario_number: 4,
        title: "Polydentate ligand - EDTA",
        problem: "What is the coordination number in [Ca(EDTA)]²⁻?",
        interactive_hints: [
          "EDTA is hexadentate (6 donor atoms)",
          "It has 2 N and 4 O donor atoms",
          "One EDTA wraps around the metal"
        ],
        solution: "Coordination number = 6. EDTA provides 6 donor atoms (2N + 4O).",
        explanation: "EDTA is a powerful hexadentate chelating agent. It completely occupies 6 coordination sites."
      },
      {
        scenario_number: 5,
        title: "Challenge: Mixed mono and bidentate",
        problem: "What is the coordination number in [Co(en)₂Cl₂]⁺?",
        interactive_hints: [
          "2 en (bidentate): 2 × 2 = 4 donor atoms",
          "2 Cl⁻ (monodentate): 2 × 1 = 2 donor atoms",
          "Total = 4 + 2 = ?"
        ],
        solution: "Coordination number = 6. (2 × 2) + (2 × 1) = 4 + 2 = 6.",
        explanation: "Always count total donor atoms, not total ligands. Two bidentate + two monodentate = 6 coordination sites."
      }
    ],
    practice_quiz: [
      {
        question: "What is the coordination number in [Ni(CO)₄]?",
        answer: "4",
        explanation: "CO is monodentate (donates through C). 4 CO = 4 donor atoms."
      },
      {
        question: "What is the coordination number in [Fe(ox)₃]³⁻? (ox = oxalate, bidentate)",
        answer: "6",
        explanation: "Oxalate is bidentate. 3 ox × 2 = 6 donor atoms."
      }
    ],
    points_reward: 100,
    tags: ["coordination-chemistry", "coordination-number", "ligands", "interactive"]
  },

  # Unit 2: Naming Coordination Compounds Step-by-Step
  {
    title: "Naming Coordination Compounds - IUPAC Made Easy",
    description: "Interactive guide to systematically name any coordination compound using IUPAC rules",
    difficulty: "medium",
    estimated_minutes: 35,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Apply IUPAC nomenclature rules systematically",
      "Name ligands correctly (neutral vs anionic)",
      "Determine oxidation states accurately",
      "Distinguish between cationic, anionic, and neutral complexes"
    ],
    key_concepts: [
      "Order: Counter ion → Ligands (alphabetically) → Metal → Oxidation state",
      "Anionic ligands end in -o (chlorido, hydroxido, cyano)",
      "Neutral ligands keep name (except: H₂O = aqua, NH₃ = ammine)",
      "Anionic complexes: metal name ends in -ate"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Simple cationic complex",
        problem: "Name [Cu(NH₃)₄]²⁺",
        interactive_hints: [
          "Start with ligands: 4 NH₃ = tetraammine",
          "Metal: copper",
          "Oxidation state: +2 (write as Roman numeral)",
          "Format: ligand-metal(oxidation state)"
        ],
        solution: "tetraamminecopper(II)",
        explanation: "NH₃ = ammine (double m). No counter ion (just the complex cation). Alphabetically simple here."
      },
      {
        scenario_number: 2,
        title: "Anionic complex with counter ion",
        problem: "Name K₃[Fe(CN)₆]",
        interactive_hints: [
          "Counter ion first: potassium",
          "Ligand: CN⁻ = cyano, 6 of them = hexacyano",
          "Anionic complex: iron → ferrate",
          "Oxidation state: K₃ and overall neutral → Fe is +3"
        ],
        solution: "potassium hexacyanoferrate(III)",
        explanation: "Anionic complex: metal name changes to '-ate' form. Fe → ferrate, Cr → chromate, Al → aluminate."
      },
      {
        scenario_number: 3,
        title: "Multiple ligands - alphabetical order",
        problem: "Name [Co(NH₃)₄Cl₂]Cl",
        interactive_hints: [
          "Ligands alphabetically: 'a' (ammine) before 'c' (chlorido)",
          "Inside brackets: tetraammine + dichlorido",
          "Cobalt oxidation state: +3 (2 Cl⁻ inside, 1 Cl⁻ outside)",
          "Counter ion outside: chloride"
        ],
        solution: "tetraamminedichloridocobalt(III) chloride",
        explanation: "Alphabetical by ligand name (ignore prefixes). Cationic complex, so cobalt stays cobalt (not cobaltate)."
      },
      {
        scenario_number: 4,
        title: "Water as ligand",
        problem: "Name [Cr(H₂O)₆]Cl₃",
        interactive_hints: [
          "H₂O as ligand = aqua (not water)",
          "6 water molecules = hexaaqua",
          "Cr oxidation state: +3 (3 Cl⁻ outside)",
          "Counter ion: chloride"
        ],
        solution: "hexaaquachromium(III) chloride",
        explanation: "Special names: H₂O = aqua, NH₃ = ammine, CO = carbonyl, NO = nitrosyl."
      },
      {
        scenario_number: 5,
        title: "Challenge: Complex anionic with multiple ligands",
        problem: "Name [Cr(en)₂Cl₂]Cl (en = ethylenediamine)",
        interactive_hints: [
          "en (neutral) comes before Cl⁻ (anionic) alphabetically",
          "2 en = bis(ethylenediamine) [use 'bis' for complex ligands]",
          "2 Cl⁻ = dichlorido",
          "Cr oxidation state: +3"
        ],
        solution: "bis(ethylenediamine)dichloridochromium(III) chloride",
        explanation: "Use 'bis', 'tris', 'tetrakis' for complex ligands (with parentheses). Alphabetically: 'bis' before 'dichlorido'."
      }
    ],
    practice_quiz: [
      {
        question: "Name [Ni(CO)₄]",
        answer: "tetracarbonylnickel(0)",
        explanation: "CO = carbonyl. Neutral complex, no counter ion. Ni is 0 oxidation state (neutral ligands)."
      },
      {
        question: "Name K₂[Cr(CN)₄]",
        answer: "potassium tetracyanochromate(II)",
        explanation: "Anionic complex: chromate. Cr oxidation state: +2."
      }
    ],
    points_reward: 125,
    tags: ["coordination-chemistry", "iupac-nomenclature", "naming", "interactive"]
  },

  # Unit 3: Oxidation States Made Easy
  {
    title: "Oxidation States - Master the Calculation",
    description: "Learn foolproof methods to calculate oxidation states in any compound or complex",
    difficulty: "easy",
    estimated_minutes: 20,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Apply oxidation state rules consistently",
      "Calculate oxidation states in compounds",
      "Determine oxidation states in complex ions",
      "Identify redox changes in reactions"
    ],
    key_concepts: [
      "Sum of oxidation states = overall charge",
      "Rules: F always -1, O usually -2, H usually +1, Group 1 always +1",
      "Ligands: anionic ligands have negative charge, neutral ligands = 0",
      "Method: Set up equation and solve for unknown"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Simple ionic compound",
        problem: "What is the oxidation state of S in H₂SO₄?",
        interactive_hints: [
          "H is +1, O is -2, overall charge = 0",
          "Set up equation: 2(+1) + S + 4(-2) = 0",
          "Solve for S"
        ],
        solution: "+6",
        explanation: "2 + S - 8 = 0, so S = +6. Sulfur in sulfuric acid is in its highest oxidation state."
      },
      {
        scenario_number: 2,
        title: "Polyatomic ion",
        problem: "What is the oxidation state of Cr in Cr₂O₇²⁻?",
        interactive_hints: [
          "O is -2, overall charge = -2",
          "Set up: 2(Cr) + 7(-2) = -2",
          "Solve for Cr"
        ],
        solution: "+6",
        explanation: "2Cr - 14 = -2, so 2Cr = 12, Cr = +6. Dichromate ion has chromium in +6 state."
      },
      {
        scenario_number: 3,
        title: "Complex ion with anionic ligands",
        problem: "What is the oxidation state of Fe in [Fe(CN)₆]³⁻?",
        interactive_hints: [
          "CN⁻ is anionic ligand with -1 charge each",
          "6 CN⁻ = 6(-1) = -6 total",
          "Set up: Fe + 6(-1) = -3"
        ],
        solution: "+3",
        explanation: "Fe - 6 = -3, so Fe = +3. Hexacyanoferrate(III) has iron in +3 oxidation state."
      },
      {
        scenario_number: 4,
        title: "Complex with neutral ligands",
        problem: "What is the oxidation state of Co in [Co(NH₃)₆]³⁺?",
        interactive_hints: [
          "NH₃ is neutral ligand (charge = 0)",
          "6 NH₃ = 6(0) = 0 total",
          "Set up: Co + 0 = +3"
        ],
        solution: "+3",
        explanation: "Co = +3. Neutral ligands don't contribute to charge calculation. Simply: metal oxidation state = overall charge."
      },
      {
        scenario_number: 5,
        title: "Mixed ligands challenge",
        problem: "What is the oxidation state of Pt in [Pt(NH₃)₄Cl₂]²⁺?",
        interactive_hints: [
          "NH₃ is neutral (0), Cl⁻ is anionic (-1)",
          "4 NH₃ + 2 Cl⁻ = 0 + 2(-1) = -2",
          "Set up: Pt + (-2) = +2"
        ],
        solution: "+4",
        explanation: "Pt - 2 = +2, so Pt = +4. Platinum(IV) complex with mixed ligands."
      }
    ],
    practice_quiz: [
      {
        question: "What is the oxidation state of Mn in KMnO₄?",
        answer: "+7",
        explanation: "K(+1) + Mn + 4O(-2) = 0. 1 + Mn - 8 = 0, Mn = +7."
      },
      {
        question: "What is the oxidation state of Ni in [Ni(CO)₄]?",
        answer: "0",
        explanation: "CO is neutral. Ni + 0 = 0 (overall neutral). Ni = 0."
      }
    ],
    points_reward: 100,
    tags: ["oxidation-states", "calculations", "coordination-chemistry", "interactive"]
  },

  # Unit 4: VSEPR Theory Interactive
  {
    title: "VSEPR Theory - Predicting Molecular Geometry",
    description: "Interactive exploration of VSEPR theory to predict 3D shapes of molecules",
    difficulty: "medium",
    estimated_minutes: 30,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Count electron pairs (bonding + lone pairs) correctly",
      "Apply VSEPR notation (AXₙEₘ)",
      "Predict molecular geometry from electron geometry",
      "Understand effect of lone pairs on bond angles"
    ],
    key_concepts: [
      "Electron pairs repel and arrange to minimize repulsion",
      "VSEPR notation: A = central atom, X = bonding pairs, E = lone pairs",
      "Lone pair-lone pair > lone pair-bond pair > bond pair-bond pair repulsion",
      "Lone pairs decrease bond angles"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Linear geometry",
        problem: "What is the geometry of CO₂? (C is central atom)",
        interactive_hints: [
          "Count: 2 bonding pairs (C=O double bonds count as 1), 0 lone pairs on C",
          "Notation: AX₂E₀ → AX₂",
          "Electron geometry = molecular geometry = ?"
        ],
        solution: "Linear",
        explanation: "AX₂ → Linear. Bond angle = 180°. No lone pairs, so electron and molecular geometry are same."
      },
      {
        scenario_number: 2,
        title: "Tetrahedral geometry",
        problem: "What is the geometry of CH₄?",
        interactive_hints: [
          "Count: 4 bonding pairs (C-H), 0 lone pairs on C",
          "Notation: AX₄",
          "Electron geometry = molecular geometry = ?"
        ],
        solution: "Tetrahedral",
        explanation: "AX₄ → Tetrahedral. Bond angle = 109.5°. Classic tetrahedral shape."
      },
      {
        scenario_number: 3,
        title: "Bent geometry - effect of lone pairs",
        problem: "What is the geometry of H₂O? (O is central)",
        interactive_hints: [
          "Count: 2 bonding pairs (O-H), 2 lone pairs on O",
          "Notation: AX₂E₂",
          "Electron geometry: tetrahedral, molecular geometry: ?"
        ],
        solution: "Bent",
        explanation: "AX₂E₂ → Bent. Electron geometry is tetrahedral, but molecular geometry considers only atoms. Bond angle ≈ 104.5° (< 109.5° due to lone pair repulsion)."
      },
      {
        scenario_number: 4,
        title: "Trigonal pyramidal",
        problem: "What is the geometry of NH₃?",
        interactive_hints: [
          "Count: 3 bonding pairs (N-H), 1 lone pair on N",
          "Notation: AX₃E₁",
          "Electron geometry: tetrahedral, molecular geometry: ?"
        ],
        solution: "Trigonal pyramidal",
        explanation: "AX₃E₁ → Trigonal pyramidal. Bond angle ≈ 107° (< 109.5° due to lone pair). Ammonia is a pyramid with N at apex."
      },
      {
        scenario_number: 5,
        title: "Challenge: Octahedral",
        problem: "What is the geometry of SF₆?",
        interactive_hints: [
          "Count: 6 bonding pairs (S-F), 0 lone pairs on S (expanded octet)",
          "Notation: AX₆",
          "6 electron pairs arrange in ?"
        ],
        solution: "Octahedral",
        explanation: "AX₆ → Octahedral. Bond angle = 90°. Sulfur uses d-orbitals (3rd period, can expand octet)."
      }
    ],
    practice_quiz: [
      {
        question: "What is the geometry of BF₃?",
        answer: "Trigonal planar",
        explanation: "AX₃ → Trigonal planar. Bond angle = 120°. Boron has only 6 electrons."
      },
      {
        question: "What is the geometry of ClF₃? (Cl is central, has 2 lone pairs)",
        answer: "T-shaped",
        explanation: "AX₃E₂ → T-shaped. Electron geometry: trigonal bipyramidal. Lone pairs occupy equatorial positions."
      }
    ],
    points_reward: 120,
    tags: ["vsepr", "molecular-geometry", "shapes", "interactive"]
  },

  # Unit 5: Crystal Field Theory Visualization
  {
    title: "Crystal Field Theory - d-Orbital Splitting Explained",
    description: "Visualize and understand d-orbital splitting in octahedral and tetrahedral complexes",
    difficulty: "hard",
    estimated_minutes: 35,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Understand origin of crystal field splitting",
      "Compare octahedral vs tetrahedral splitting",
      "Predict high spin vs low spin configurations",
      "Calculate magnetic moments and color predictions"
    ],
    key_concepts: [
      "Ligands create electrostatic field that splits d-orbitals",
      "Octahedral: t₂g (lower) and eg (higher), Δₒ = energy gap",
      "Tetrahedral: e (lower) and t₂ (higher), Δₜ ≈ 4/9 Δₒ",
      "Strong field → large Δ → low spin, Weak field → small Δ → high spin"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Basic octahedral splitting",
        problem: "In [Ti(H₂O)₆]³⁺, Ti³⁺ is d¹. Where does the electron go in octahedral field?",
        interactive_hints: [
          "Octahedral splits into t₂g (3 orbitals, lower) and eg (2 orbitals, higher)",
          "Electron occupies lowest energy level first",
          "1 electron goes to ?"
        ],
        solution: "t2g",
        explanation: "d¹ configuration: electron goes to lower t₂g orbital. This complex appears purple (d-d transition from t₂g to eg)."
      },
      {
        scenario_number: 2,
        title: "High spin vs low spin - weak field",
        problem: "For [Fe(H₂O)₆]²⁺, Fe²⁺ is d⁶. H₂O is weak field. How are electrons arranged?",
        interactive_hints: [
          "Weak field → small Δₒ → high spin",
          "Pairing energy > Δₒ, so electrons prefer to stay unpaired",
          "Configuration: t₂g? eg?"
        ],
        solution: "t2g4 eg2 (high spin, 4 unpaired)",
        explanation: "High spin d⁶: t₂g↑↑↑↓ eg↑↑ (4 unpaired electrons). Paramagnetic, pale green color."
      },
      {
        scenario_number: 3,
        title: "Low spin - strong field",
        problem: "For [Fe(CN)₆]⁴⁻, Fe²⁺ is d⁶. CN⁻ is strong field. How are electrons arranged?",
        interactive_hints: [
          "Strong field → large Δₒ → low spin",
          "Pairing energy < Δₒ, so electrons pair in t₂g first",
          "Configuration: t₂g? eg?"
        ],
        solution: "t2g6 eg0 (low spin, 0 unpaired)",
        explanation: "Low spin d⁶: t₂g↑↓↑↓↑↓ (all paired). Diamagnetic, yellow color. More stable due to large CFSE."
      },
      {
        scenario_number: 4,
        title: "Magnetic moment calculation",
        problem: "Calculate magnetic moment (μ) of [Mn(H₂O)₆]²⁺ (high spin d⁵). Use μ = √(n(n+2)) BM.",
        interactive_hints: [
          "High spin d⁵: t₂g³ eg² → all 5 electrons unpaired",
          "n = 5",
          "μ = √(5 × 7) = ?"
        ],
        solution: "5.92 BM",
        explanation: "n = 5, μ = √35 = 5.92 Bohr Magnetons. Highly paramagnetic, pale pink color."
      },
      {
        scenario_number: 5,
        title: "Tetrahedral splitting",
        problem: "In tetrahedral complexes, Δₜ ≈ 4/9 Δₒ. Are tetrahedral complexes high spin or low spin?",
        interactive_hints: [
          "Δₜ is much smaller than Δₒ",
          "Small splitting means pairing energy > Δₜ",
          "Electrons prefer to stay ?"
        ],
        solution: "High spin (always)",
        explanation: "Tetrahedral complexes are always high spin because Δₜ is too small to cause pairing. No low spin tetrahedral complexes exist."
      }
    ],
    practice_quiz: [
      {
        question: "Which has more unpaired electrons: [Co(NH₃)₆]³⁺ or [CoF₆]³⁻? (Co³⁺ is d⁶)",
        answer: "[CoF6]3- (high spin)",
        explanation: "NH₃ is strong field (low spin, 0 unpaired). F⁻ is weak field (high spin, 4 unpaired)."
      },
      {
        question: "Why are most d¹⁰ complexes colorless?",
        answer: "No d-d transitions possible",
        explanation: "d¹⁰ (all d-orbitals full) → no electron can transition. No absorption in visible range → colorless."
      }
    ],
    points_reward: 150,
    tags: ["cft", "crystal-field-theory", "d-orbitals", "magnetism", "interactive"]
  },

  # Unit 6: Periodic Trends Explorer
  {
    title: "Periodic Trends - Interactive Pattern Discovery",
    description: "Explore and understand periodic trends through interactive comparison",
    difficulty: "easy",
    estimated_minutes: 25,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Identify trends in atomic radius, ionic radius, ionization energy",
      "Understand electronegativity and electron affinity patterns",
      "Apply trends to predict properties",
      "Explain exceptions to trends"
    ],
    key_concepts: [
      "Across period: Z increases, radius decreases, IE increases, EN increases",
      "Down group: radius increases, IE decreases, EN decreases",
      "Ionic radius: cation < atom < anion",
      "Isoelectronic species: more positive charge → smaller radius"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Atomic radius trend",
        problem: "Arrange Na, Mg, Al in order of increasing atomic radius",
        interactive_hints: [
          "All are in Period 3",
          "Across a period, atomic radius decreases",
          "More protons → stronger nuclear pull"
        ],
        solution: "Al < Mg < Na",
        explanation: "Across period: radius decreases due to increasing effective nuclear charge. Al is smallest, Na is largest."
      },
      {
        scenario_number: 2,
        title: "Ionization energy exception",
        problem: "Why is IE₁ of B < IE₁ of Be despite B being to the right?",
        interactive_hints: [
          "Be: [He]2s², B: [He]2s²2p¹",
          "Consider electron configuration",
          "2p electron is easier to remove than 2s"
        ],
        solution: "2p electron in B is easier to remove",
        explanation: "Be has stable fully filled 2s². B has one 2p electron which is higher energy and easier to remove. Exception to general trend."
      },
      {
        scenario_number: 3,
        title: "Ionic radius comparison",
        problem: "Arrange Na⁺, Mg²⁺, Al³⁺ in order of increasing radius (all are isoelectronic with 10 electrons)",
        interactive_hints: [
          "All have 10 electrons (same as Ne)",
          "Different number of protons: Na(11), Mg(12), Al(13)",
          "More protons → stronger pull → smaller radius"
        ],
        solution: "Al3+ < Mg2+ < Na+",
        explanation: "Isoelectronic series: same electrons, but Al³⁺ has most protons (13) pulling electrons, so smallest. Na⁺ largest (11 protons)."
      },
      {
        scenario_number: 4,
        title: "Electronegativity trend",
        problem: "Why is F the most electronegative element?",
        interactive_hints: [
          "F is in Period 2, Group 17",
          "Small atomic size",
          "High effective nuclear charge"
        ],
        solution: "Small size + high nuclear charge",
        explanation: "F has 7 valence electrons in small 2p orbital. Strong attraction for additional electron. EN = 4.0 (highest)."
      },
      {
        scenario_number: 5,
        title: "Electron affinity exception",
        problem: "Why is EA of F < EA of Cl (exception to general trend)?",
        interactive_hints: [
          "F is very small atom",
          "Adding electron causes significant electron-electron repulsion",
          "Cl is larger, less repulsion"
        ],
        solution: "Small size causes repulsion in F",
        explanation: "F is so small that added electron faces strong repulsion from existing electrons. Cl is larger, less crowded, releases more energy when gaining electron."
      }
    ],
    practice_quiz: [
      {
        question: "Which has largest radius: O²⁻, F⁻, or Na⁺? (all isoelectronic)",
        answer: "O2-",
        explanation: "O²⁻ has 8 protons for 10 electrons. F⁻ has 9 protons. Na⁺ has 11 protons. Least protons → largest radius."
      },
      {
        question: "Why is IE₂ of Na >> IE₁ of Na?",
        answer: "IE2 removes from stable noble gas core",
        explanation: "IE₁ removes 3s¹ (easy). IE₂ removes from [Ne] core (very stable, very difficult)."
      }
    ],
    points_reward: 110,
    tags: ["periodic-trends", "atomic-properties", "periodic-table", "interactive"]
  },

  # Unit 7: Balancing Equations Mastery
  {
    title: "Balancing Chemical Equations - Step-by-Step Mastery",
    description: "Master equation balancing through systematic methods and practice",
    difficulty: "medium",
    estimated_minutes: 30,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Balance equations by inspection method",
      "Apply algebraic method for complex equations",
      "Balance redox equations using half-reaction method",
      "Verify balanced equations"
    ],
    key_concepts: [
      "Law of conservation of mass",
      "Balance atoms first, then check charges",
      "Start with most complex molecule",
      "Leave O and H for last in redox"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Simple combustion",
        problem: "Balance: C₃H₈ + O₂ → CO₂ + H₂O",
        interactive_hints: [
          "Start with C: 3 C on left → 3 CO₂ on right",
          "Then H: 8 H on left → 4 H₂O on right",
          "Finally O: count and balance"
        ],
        solution: "C3H8 + 5O2 → 3CO2 + 4H2O",
        explanation: "C: 3, H: 8 → 4H₂O, O: (3×2 + 4)/2 = 5 O₂. Check: C(3=3), H(8=8), O(10=10) ✓"
      },
      {
        scenario_number: 2,
        title: "Decomposition reaction",
        problem: "Balance: KClO₃ → KCl + O₂",
        interactive_hints: [
          "K and Cl are already 1:1",
          "O: 3 on left, 2 on right → need LCM(3,2) = 6",
          "Adjust coefficients"
        ],
        solution: "2KClO3 → 2KCl + 3O2",
        explanation: "To get 6 O: 2 KClO₃ (6 O) → 3 O₂. Then balance K and Cl: 2 KCl."
      },
      {
        scenario_number: 3,
        title: "Algebraic method",
        problem: "Balance: Fe + H₂O → Fe₃O₄ + H₂ (use coefficients a, b, c, d)",
        interactive_hints: [
          "aFe + bH₂O → cFe₃O₄ + dH₂",
          "Fe: a = 3c, H: 2b = 2d, O: b = 4c",
          "Let c = 1, solve: a = 3, b = 4, d = 4"
        ],
        solution: "3Fe + 4H2O → Fe3O4 + 4H2",
        explanation: "Algebraic method useful when inspection is difficult. Set one coefficient = 1, solve linear equations."
      },
      {
        scenario_number: 4,
        title: "Redox equation preview",
        problem: "Balance: Cu + HNO₃ → Cu(NO₃)₂ + NO + H₂O (hint: Cu is oxidized, N is reduced)",
        interactive_hints: [
          "Start with Cu and N atoms",
          "Cu: 1 → 1, N in NO₃: need 2, N in NO: need 1, total N on left: 3",
          "Balance O and H last"
        ],
        solution: "3Cu + 8HNO3 → 3Cu(NO3)2 + 2NO + 4H2O",
        explanation: "Complex! 3 Cu oxidized, 2 N reduced. Check all atoms: Cu(3=3), N(8=6+2), H(8=8), O(24=18+2+4) ✓"
      },
      {
        scenario_number: 5,
        title: "Verification challenge",
        problem: "Is this balanced? 2Al + 6HCl → 2AlCl₃ + 3H₂",
        interactive_hints: [
          "Check Al: left = 2, right = 2",
          "Check H: left = 6, right = 6",
          "Check Cl: left = 6, right = 6"
        ],
        solution: "Yes, balanced",
        explanation: "All atoms balanced: Al(2=2), H(6=6), Cl(6=6). Law of conservation of mass satisfied."
      }
    ],
    practice_quiz: [
      {
        question: "Balance: Al + O₂ → Al₂O₃",
        answer: "4Al + 3O2 → 2Al2O3",
        explanation: "LCM method: O needs 6 (LCM of 2 and 3). 3 O₂ → 2 Al₂O₃, then 4 Al."
      },
      {
        question: "Balance: NH₃ + O₂ → NO + H₂O",
        answer: "4NH3 + 5O2 → 4NO + 6H2O",
        explanation: "N: 1→1, H: 3→6 (need 2 NH₃→3 H₂O), scale up to avoid fractions."
      }
    ],
    points_reward: 120,
    tags: ["balancing-equations", "stoichiometry", "conservation-of-mass", "interactive"]
  },

  # Unit 8: Qualitative Analysis Flowchart
  {
    title: "Qualitative Analysis - Interactive Flowchart Navigator",
    description: "Navigate through systematic salt analysis using interactive decision trees",
    difficulty: "medium",
    estimated_minutes: 30,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Follow systematic qualitative analysis procedure",
      "Identify cations using group-wise separation",
      "Apply confirmatory tests correctly",
      "Interpret test results to identify unknown salts"
    ],
    key_concepts: [
      "Systematic approach: preliminary tests → group tests → confirmatory tests",
      "Group separation based on selective precipitation",
      "Each group has characteristic reagent and products",
      "Color, precipitate, and gas evolution give clues"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Start: Preliminary test",
        problem: "Unknown salt is blue. What cation is likely present?",
        interactive_hints: [
          "Color gives direct clue to metal ion",
          "Blue color is characteristic of hydrated Cu compounds",
          "Think of blue vitriol (CuSO₄·5H₂O)"
        ],
        solution: "Cu2+",
        explanation: "Blue color → Cu²⁺. Next step: confirm with group tests (Group II) and specific tests (NH₃ solution, K₄[Fe(CN)₆])."
      },
      {
        scenario_number: 2,
        title: "Group I test",
        problem: "Adding dilute HCl gives white precipitate. What group is present?",
        interactive_hints: [
          "Dilute HCl is Group I reagent",
          "White precipitate = chloride of Group I metal",
          "Group I: Pb²⁺, Ag⁺, Hg₂²⁺"
        ],
        solution: "Group I (Pb2+, Ag+, or Hg2^2+)",
        explanation: "White precipitate with HCl → PbCl₂, AgCl, or Hg₂Cl₂. Next: differentiate using hot water (PbCl₂ soluble) or NH₃ (AgCl soluble, Hg₂Cl₂ → black)."
      },
      {
        scenario_number: 3,
        title: "Confirmatory test for Fe³⁺",
        problem: "Suspected Fe³⁺. Add K₄[Fe(CN)₆] (potassium ferrocyanide). What color confirms Fe³⁺?",
        interactive_hints: [
          "Fe³⁺ + ferrocyanide → Prussian blue",
          "Characteristic intense blue precipitate",
          "Formula: Fe₄[Fe(CN)₆]₃"
        ],
        solution: "Prussian blue",
        explanation: "Fe³⁺ + [Fe(CN)₆]⁴⁻ → Fe₄[Fe(CN)₆]₃ (Prussian blue). Confirmatory test for ferric ion."
      },
      {
        scenario_number: 4,
        title: "Brown ring test",
        problem: "Testing for NO₃⁻. Added FeSO₄ + conc. H₂SO₄. What indicates positive test?",
        interactive_hints: [
          "Brown ring forms at junction of two liquids",
          "Complex ion: [Fe(H₂O)₅(NO)]²⁺",
          "Brown colored coordination compound"
        ],
        solution: "Brown ring at junction",
        explanation: "Brown ring = [Fe(H₂O)₅(NO)]²⁺. Confirmatory test for nitrate. Brown ring is unstable, fades on standing."
      },
      {
        scenario_number: 5,
        title: "Complete identification",
        problem: "Salt gives: (1) Green ppt with NH₄OH (2) Red color with KSCN. Identify cation.",
        interactive_hints: [
          "Green ppt with NH₄OH → Fe²⁺ or Fe³⁺ (Group III)",
          "Red color with KSCN is specific test",
          "KSCN + Fe³⁺ → [Fe(SCN)]²⁺ (blood red)"
        ],
        solution: "Fe3+",
        explanation: "Fe³⁺ confirmed. Green ppt = Fe(OH)₃ (appears greenish), red with KSCN = [Fe(SCN)]²⁺ (confirmatory)."
      }
    ],
    practice_quiz: [
      {
        question: "Which group reagent precipitates Cu²⁺?",
        answer: "H2S in acidic medium (Group II)",
        explanation: "Cu²⁺ + H₂S → CuS (black precipitate) in acidic medium."
      },
      {
        question: "What color flame does K⁺ give?",
        answer: "Lilac/Violet",
        explanation: "Potassium gives characteristic lilac (violet) flame. Viewed through cobalt glass to mask Na yellow."
      }
    ],
    points_reward: 125,
    tags: ["qualitative-analysis", "salt-analysis", "flowchart", "interactive"]
  },

  # Unit 9: Metallurgy Process Selection
  {
    title: "Metallurgy - Choosing the Right Extraction Method",
    description: "Learn to select appropriate extraction methods based on metal reactivity and ore type",
    difficulty: "medium",
    estimated_minutes: 30,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Understand relationship between metal reactivity and extraction method",
      "Select appropriate reduction method for given metal",
      "Apply Ellingham diagram principles",
      "Identify suitable concentration methods for different ores"
    ],
    key_concepts: [
      "High reactivity (Na, K, Ca, Mg, Al) → Electrolytic reduction",
      "Medium reactivity (Zn, Fe, Sn, Pb) → Carbon reduction (smelting)",
      "Low reactivity (Hg, Cu, Ag, Au) → Roasting alone or self-reduction",
      "Ore type determines concentration method"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Extraction method for aluminum",
        problem: "Al is very reactive (above C in reactivity). What extraction method is used?",
        interactive_hints: [
          "Carbon cannot reduce Al₂O₃ (C is less reactive than Al)",
          "Need very strong reducing agent",
          "Electrical energy can provide the reducing power"
        ],
        solution: "Electrolytic reduction (Hall-Heroult process)",
        explanation: "Al₂O₃ electrolyzed in molten cryolite (Na₃AlF₆) at 1000°C. Al forms at cathode, O₂ at anode. C + Al too difficult."
      },
      {
        scenario_number: 2,
        title: "Extraction method for iron",
        problem: "Fe is moderately reactive (below C in reactivity). What extraction method is used?",
        interactive_hints: [
          "Carbon can reduce Fe₂O₃",
          "Done in blast furnace",
          "CO acts as reducing agent"
        ],
        solution: "Carbon reduction (smelting)",
        explanation: "Fe₂O₃ + 3CO → 2Fe + 3CO₂ in blast furnace at ~1200°C. C + O₂ → CO₂, CO₂ + C → 2CO, then CO reduces iron oxide."
      },
      {
        scenario_number: 3,
        title: "Concentration method for sulfide ore",
        problem: "Zinc sulfide (ZnS) ore needs to be concentrated. What method is suitable?",
        interactive_hints: [
          "Sulfide ores are preferentially wetted by oil",
          "Uses principle of selective wetting",
          "Ore floats, gangue sinks"
        ],
        solution: "Froth flotation",
        explanation: "Froth flotation: ZnS particles attach to oil froth, gangue sinks. Add pine oil + collectors. Sulfide ore preferentially wetted by oil."
      },
      {
        scenario_number: 4,
        title: "Ellingham diagram application",
        problem: "At high temp, line for C → CO is below line for Fe → FeO. What does this mean?",
        interactive_hints: [
          "Lower line = more negative ΔG = more stable",
          "C → CO is thermodynamically more favorable than Fe → FeO",
          "CO will reduce FeO"
        ],
        solution: "CO can reduce FeO to Fe",
        explanation: "When C+O line is below metal oxide line, carbon (or CO) can reduce that metal oxide. This is why Fe extraction uses carbon."
      },
      {
        scenario_number: 5,
        title: "Self-reduction of copper",
        problem: "Cu₂S can be extracted without external reducing agent. How?",
        interactive_hints: [
          "Partial roasting: 2Cu₂S + 3O₂ → 2Cu₂O + 2SO₂",
          "Then Cu₂O reacts with remaining Cu₂S",
          "Internal redox reaction"
        ],
        solution: "Self-reduction (auto-reduction)",
        explanation: "2Cu₂O + Cu₂S → 6Cu + SO₂. Cu₂S acts as reducing agent for Cu₂O. No external C or H₂ needed. Cu is low reactivity metal."
      }
    ],
    practice_quiz: [
      {
        question: "Why can't we use electrolytic reduction for iron on industrial scale?",
        answer: "Too expensive; carbon reduction is cheaper",
        explanation: "Fe can be reduced by C (cheaper). Electrolysis reserved for very reactive metals where C won't work."
      },
      {
        question: "What is the difference between roasting and calcination?",
        answer: "Roasting: excess air (sulfide→oxide). Calcination: limited air (remove CO2, H2O)",
        explanation: "Roasting: 2ZnS + 3O₂ → 2ZnO + 2SO₂. Calcination: CaCO₃ → CaO + CO₂."
      }
    ],
    points_reward: 130,
    tags: ["metallurgy", "extraction", "ellingham-diagram", "interactive"]
  },

  # Unit 10: Ligand Types and Denticity
  {
    title: "Ligands - Understanding Types and Denticity",
    description: "Master classification of ligands by charge, donor atoms, and denticity",
    difficulty: "easy",
    estimated_minutes: 25,
    unit_type: "interactive_concept",
    learning_objectives: [
      "Classify ligands as anionic, neutral, or cationic",
      "Identify donor atoms in ligands",
      "Determine denticity of ligands",
      "Recognize ambidentate and bridging ligands"
    ],
    key_concepts: [
      "Ligand = electron pair donor to metal (Lewis base)",
      "Denticity = number of donor atoms in one ligand molecule",
      "Monodentate (1), bidentate (2), polydentate (3+)",
      "Chelating ligands form ring structures (more stable)"
    ],
    scenarios: [
      {
        scenario_number: 1,
        title: "Identify monodentate ligands",
        problem: "Which are monodentate: NH₃, Cl⁻, H₂O, CO?",
        interactive_hints: [
          "Count donor atoms in each",
          "NH₃: 1 N with lone pair",
          "Cl⁻, H₂O, CO: each has 1 donor atom"
        ],
        solution: "All are monodentate",
        explanation: "NH₃ (N donor), Cl⁻ (Cl donor), H₂O (O donor), CO (C donor). Each has one donor atom = monodentate."
      },
      {
        scenario_number: 2,
        title: "Bidentate ligand structure",
        problem: "Ethylenediamine (en) has formula NH₂-CH₂-CH₂-NH₂. What is its denticity?",
        interactive_hints: [
          "Count nitrogen atoms with lone pairs",
          "Each -NH₂ group can donate",
          "Total donor atoms = ?"
        ],
        solution: "Bidentate (denticity = 2)",
        explanation: "en has 2 NH₂ groups → 2 N donor atoms. Forms 5-membered chelate ring with metal. Very stable."
      },
      {
        scenario_number: 3,
        title: "Identify ambidentate ligand",
        problem: "NO₂⁻ can bind through N or O. What type of ligand is this?",
        interactive_hints: [
          "Can coordinate through different atoms",
          "'Ambi' = both",
          "Creates linkage isomerism"
        ],
        solution: "Ambidentate",
        explanation: "NO₂⁻ can bind via N (nitro, M-NO₂) or O (nitrito, M-ONO). Ambidentate ligands have 2 possible donor atoms. Other examples: SCN⁻, CN⁻."
      },
      {
        scenario_number: 4,
        title: "Polydentate ligand - EDTA",
        problem: "EDTA has structure with 2 nitrogen atoms and 4 carboxylate groups. What is its denticity?",
        interactive_hints: [
          "Each N can donate (2 donors)",
          "Each -COO⁻ can donate through O (4 donors)",
          "Total = 2 + 4 = ?"
        ],
        solution: "Hexadentate (denticity = 6)",
        explanation: "EDTA: 2N + 4O = 6 donor atoms. Wraps completely around metal ion. Used in water softening, analytical chemistry. Extremely stable complexes."
      },
      {
        scenario_number: 5,
        title: "Bridging ligand",
        problem: "In [(NH₃)₅Cr-OH-Cr(NH₃)₅]⁵⁺, OH⁻ connects two Cr atoms. What type is this?",
        interactive_hints: [
          "Ligand connects two metal centers",
          "Uses μ (mu) symbol in nomenclature",
          "OH⁻ has 2 lone pairs on O, can donate to 2 metals"
        ],
        solution: "Bridging ligand",
        explanation: "Bridging ligand connects 2+ metal centers. OH⁻, Cl⁻, O²⁻ commonly bridge. Creates polynuclear complexes. Named as μ-hydroxido."
      }
    ],
    practice_quiz: [
      {
        question: "What is the denticity of oxalate ion (C₂O₄²⁻)?",
        answer: "Bidentate (2)",
        explanation: "Oxalate has 2 -COO⁻ groups, each donates through one O. Total = 2 donor atoms."
      },
      {
        question: "Is CN⁻ ambidentate or monodentate (or both)?",
        answer: "Both (ambidentate monodentate)",
        explanation: "CN⁻ is monodentate (uses 1 donor at a time) but ambidentate (can use C or N). M-CN (cyano) or M-NC (isocyano)."
      }
    ],
    points_reward: 110,
    tags: ["ligands", "denticity", "coordination-chemistry", "chelate", "interactive"]
  }
]

# ============================================================================
# CREATE ALL INTERACTIVE UNITS
# ============================================================================

interactive_units.each_with_index do |unit_data, index|
  unit_number = index + 1

  puts "Creating Interactive Unit #{unit_number}: #{unit_data[:title]}..."

  # Create the interactive learning unit (assuming InteractiveLearningUnit model exists)
  unit = InteractiveLearningUnit.create!(
    course: course_inorganic,
    title: unit_data[:title],
    description: unit_data[:description],
    difficulty: unit_data[:difficulty],
    estimated_minutes: unit_data[:estimated_minutes],
    unit_type: unit_data[:unit_type],
    learning_objectives: unit_data[:learning_objectives],
    key_concepts: unit_data[:key_concepts],
    scenarios: unit_data[:scenarios],
    practice_quiz: unit_data[:practice_quiz],
    points_reward: unit_data[:points_reward],
    tags: unit_data[:tags],
    order_index: unit_number
  )

  puts "  ✓ Unit #{unit_number} created with #{unit_data[:scenarios].length} scenarios"
end

puts "\n" + "="*80
puts "SUCCESS! Created 10 interactive learning units"
puts "="*80
puts "\nSummary:"
puts "1. Understanding Coordination Number (easy, 25 min)"
puts "2. Naming Coordination Compounds (medium, 35 min)"
puts "3. Oxidation States Made Easy (easy, 20 min)"
puts "4. VSEPR Theory Interactive (medium, 30 min)"
puts "5. Crystal Field Theory Visualization (hard, 35 min)"
puts "6. Periodic Trends Explorer (easy, 25 min)"
puts "7. Balancing Equations Mastery (medium, 30 min)"
puts "8. Qualitative Analysis Flowchart (medium, 30 min)"
puts "9. Metallurgy Process Selection (medium, 30 min)"
puts "10. Ligand Types and Denticity (easy, 25 min)"
puts "\nTotal interactive learning time: 285 minutes (~4.75 hours)"
puts "\n" + "="*80
puts "PHASE 1 IMPLEMENTATION COMPLETE!"
puts "="*80
puts "\nFinal Statistics:"
puts "- Modules: 6 complete (s-block, p-block, d-block, f-block, metallurgy, qualitative)"
puts "- Lessons: 13 comprehensive lessons"
puts "- Quizzes: 13 quizzes with ~75 questions"
puts "- Hands-on Labs: 30 labs (10 basic + 20 advanced)"
puts "- Interactive Units: 10 units"
puts "- Total learning time: Theory (13 lessons) + Labs (15 hours) + Interactive (5 hours) ≈ 30+ hours"
puts "\nReady to seed database? Run: rails db:seed"

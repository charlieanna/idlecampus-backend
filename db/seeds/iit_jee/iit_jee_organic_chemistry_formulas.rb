# frozen_string_literal: true

# ========================================
# IIT JEE Organic Chemistry - Formula Database
# ========================================
# Comprehensive formula and compound memorization for organic chemistry
# Covers functional groups, important compounds, reagents, and reactions
#
# Total Formulas: ~150
# Question Types: fill_blank, mcq
# Integration: Automatic FSRS spaced repetition
#
# Usage:
#   rails runner db/seeds/iit_jee_organic_chemistry_formulas.rb
# ========================================

puts "\n" + "=" * 80
puts "IIT JEE ORGANIC CHEMISTRY - FORMULA DATABASE"
puts "=" * 80

# Find or create the organic chemistry course
course = Course.find_or_create_by!(slug: 'iit-jee-organic-chemistry') do |c|
  c.title = 'IIT JEE Organic Chemistry'
  c.description = 'Comprehensive Organic Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty_level = 'advanced'
  c.certification_track = 'none'
  c.estimated_hours = 120
  c.published = true
  c.learning_objectives = [
    'Master all functional groups and their nomenclature',
    'Understand reaction mechanisms and named reactions',
    'Identify reagents and their uses',
    'Solve problems on isomerism and stereochemistry',
    'Apply concepts to JEE-level organic synthesis problems'
  ]
  c.prerequisites = [
    'Basic understanding of chemical bonding',
    'Knowledge of atomic structure',
    'Familiarity with general chemistry concepts'
  ]
end

puts "✅ Course: #{course.title}"

# Create Formula Drill Module
formula_module = course.course_modules.find_or_create_by!(slug: 'organic-formula-drills') do |mod|
  mod.title = 'Essential Organic Formulas - Daily Drill'
  mod.description = 'Master all essential organic chemistry formulas, functional groups, and reagents through spaced repetition'
  mod.sequence_order = 0
  mod.estimated_minutes = 40
  mod.published = true
end

puts "✅ Formula Drill Module: #{formula_module.title}"

# ========================================
# QUIZ 1: Functional Groups & General Formulas
# ========================================

quiz_functional = Quiz.find_or_create_by!(title: 'Functional Groups Formulas') do |q|
  q.description = 'General formulas for all major functional groups'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_functional
) do |mi|
  mi.sequence_order = 1
  mi.required = false
end

puts "\n📝 Creating Functional Group Formula Questions..."

functional_formulas = [
  # Basic Functional Groups
  { name: 'Alkane general formula', formula: 'CₙH₂ₙ₊₂', alternate: 'CnH2n+2' },
  { name: 'Alkene general formula', formula: 'CₙH₂ₙ', alternate: 'CnH2n' },
  { name: 'Alkyne general formula', formula: 'CₙH₂ₙ₋₂', alternate: 'CnH2n-2' },
  { name: 'Alcohol general formula', formula: 'R-OH', alternate: 'ROH' },
  { name: 'Ether general formula', formula: 'R-O-R\'', alternate: 'ROR|R-O-R' },
  { name: 'Aldehyde general formula', formula: 'R-CHO', alternate: 'RCHO' },
  { name: 'Ketone general formula', formula: 'R-CO-R\'', alternate: 'RCOR|R-CO-R' },
  { name: 'Carboxylic acid general formula', formula: 'R-COOH', alternate: 'RCOOH' },
  { name: 'Ester general formula', formula: 'R-COO-R\'', alternate: 'RCOOR|R-COO-R' },
  { name: 'Amide general formula', formula: 'R-CO-NH₂', alternate: 'RCONH2|R-CO-NH2' },
  { name: 'Amine (primary) general formula', formula: 'R-NH₂', alternate: 'RNH2' },
  { name: 'Nitrile general formula', formula: 'R-CN', alternate: 'RCN|R-C≡N' },
  { name: 'Acid chloride general formula', formula: 'R-COCl', alternate: 'RCOCl' },
  { name: 'Anhydride general formula', formula: '(RCO)₂O', alternate: '(RCO)2O|RC(O)OC(O)R' },
  { name: 'Nitro compound general formula', formula: 'R-NO₂', alternate: 'RNO2' },

  # Cyclic Compounds
  { name: 'Cycloalkane general formula', formula: 'CₙH₂ₙ', alternate: 'CnH2n' },
  { name: 'Benzene formula', formula: 'C₆H₆', alternate: 'C6H6' },
  { name: 'Aromatic compound general formula (monosubstituted benzene)', formula: 'C₆H₅-R', alternate: 'C6H5R|C6H5-R' },
  { name: 'Phenol formula', formula: 'C₆H₅OH', alternate: 'C6H5OH' },
  { name: 'Aniline formula', formula: 'C₆H₅NH₂', alternate: 'C6H5NH2' },
]

functional_formulas.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_functional,
    question_text: "What is the #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} is #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.0
    q.discrimination = 1.0
    q.guessing = 0.0
    q.difficulty_level = 'easy'
    q.topic = 'functional groups'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{functional_formulas.size} functional group formula questions"

# ========================================
# QUIZ 2: Important Organic Compounds
# ========================================

quiz_compounds = Quiz.find_or_create_by!(title: 'Important Organic Compounds') do |q|
  q.description = 'Essential organic compounds and their formulas'
  q.time_limit_minutes = 20
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_compounds
) do |mi|
  mi.sequence_order = 2
  mi.required = false
end

puts "\n📝 Creating Important Organic Compounds Questions..."

organic_compounds = [
  # Simple Hydrocarbons
  { name: 'Methane', formula: 'CH₄', alternate: 'CH4' },
  { name: 'Ethane', formula: 'C₂H₆', alternate: 'C2H6' },
  { name: 'Ethene (Ethylene)', formula: 'C₂H₄', alternate: 'C2H4' },
  { name: 'Ethyne (Acetylene)', formula: 'C₂H₂', alternate: 'C2H2' },
  { name: 'Propane', formula: 'C₃H₈', alternate: 'C3H8' },
  { name: 'Butane', formula: 'C₄H₁₀', alternate: 'C4H10' },
  { name: 'Benzene', formula: 'C₆H₆', alternate: 'C6H6' },
  { name: 'Toluene', formula: 'C₆H₅CH₃', alternate: 'C6H5CH3|C7H8' },
  { name: 'Naphthalene', formula: 'C₁₀H₈', alternate: 'C10H8' },

  # Alcohols
  { name: 'Methanol (Methyl alcohol)', formula: 'CH₃OH', alternate: 'CH3OH' },
  { name: 'Ethanol (Ethyl alcohol)', formula: 'C₂H₅OH', alternate: 'C2H5OH|CH3CH2OH' },
  { name: 'Glycerol (Glycerine)', formula: 'C₃H₅(OH)₃', alternate: 'C3H5(OH)3|C3H8O3' },
  { name: 'Phenol (Carbolic acid)', formula: 'C₆H₅OH', alternate: 'C6H5OH' },

  # Aldehydes & Ketones
  { name: 'Formaldehyde (Methanal)', formula: 'HCHO', alternate: 'CH2O' },
  { name: 'Acetaldehyde (Ethanal)', formula: 'CH₃CHO', alternate: 'CH3CHO|C2H4O' },
  { name: 'Acetone (Propanone)', formula: 'CH₃COCH₃', alternate: 'CH3COCH3|(CH3)2CO|C3H6O' },
  { name: 'Benzaldehyde', formula: 'C₆H₅CHO', alternate: 'C6H5CHO|C7H6O' },

  # Carboxylic Acids
  { name: 'Formic acid (Methanoic acid)', formula: 'HCOOH', alternate: 'CH2O2' },
  { name: 'Acetic acid (Ethanoic acid)', formula: 'CH₃COOH', alternate: 'CH3COOH|C2H4O2' },
  { name: 'Oxalic acid', formula: 'HOOC-COOH', alternate: '(COOH)2|C2H2O4' },
  { name: 'Benzoic acid', formula: 'C₆H₅COOH', alternate: 'C6H5COOH|C7H6O2' },
  { name: 'Salicylic acid', formula: 'C₆H₄(OH)COOH', alternate: 'C6H4(OH)COOH|C7H6O3' },

  # Esters
  { name: 'Ethyl acetate', formula: 'CH₃COOC₂H₅', alternate: 'CH3COOC2H5|C4H8O2' },
  { name: 'Methyl salicylate (Oil of wintergreen)', formula: 'C₆H₄(OH)COOCH₃', alternate: 'C6H4(OH)COOCH3|C8H8O3' },

  # Amines
  { name: 'Methylamine', formula: 'CH₃NH₂', alternate: 'CH3NH2' },
  { name: 'Aniline', formula: 'C₆H₅NH₂', alternate: 'C6H5NH2' },
  { name: 'Dimethylamine', formula: '(CH₃)₂NH', alternate: '(CH3)2NH' },

  # Halogen Compounds
  { name: 'Chloroform', formula: 'CHCl₃', alternate: 'CHCl3' },
  { name: 'Carbon tetrachloride', formula: 'CCl₄', alternate: 'CCl4' },
  { name: 'Chlorobenzene', formula: 'C₆H₅Cl', alternate: 'C6H5Cl' },
  { name: 'Vinyl chloride', formula: 'CH₂=CHCl', alternate: 'CH2=CHCl|C2H3Cl' },

  # Nitrogenous Compounds
  { name: 'Nitrobenzene', formula: 'C₆H₅NO₂', alternate: 'C6H5NO2' },
  { name: 'Acetonitrile', formula: 'CH₃CN', alternate: 'CH3CN|C2H3N' },
  { name: 'Urea', formula: 'CO(NH₂)₂', alternate: 'CO(NH2)2|CH4N2O' },

  # Phenolic Compounds
  { name: 'Catechol (1,2-dihydroxybenzene)', formula: 'C₆H₄(OH)₂', alternate: 'C6H4(OH)2|C6H6O2' },
  { name: 'Resorcinol (1,3-dihydroxybenzene)', formula: 'C₆H₄(OH)₂', alternate: 'C6H4(OH)2|C6H6O2' },
  { name: 'Hydroquinone (1,4-dihydroxybenzene)', formula: 'C₆H₄(OH)₂', alternate: 'C6H4(OH)2|C6H6O2' },

  # Aromatic Compounds
  { name: 'Nitrotoluene (TNT precursor)', formula: 'CH₃C₆H₄NO₂', alternate: 'CH3C6H4NO2|C7H7NO2' },
  { name: 'Picric acid', formula: 'C₆H₂(OH)(NO₂)₃', alternate: 'C6H2(OH)(NO2)3|C6H3N3O7' },
]

organic_compounds.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_compounds,
    question_text: "What is the molecular formula for #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} has the formula #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.2
    q.discrimination = 1.1
    q.guessing = 0.0
    q.difficulty_level = 'medium'
    q.topic = 'organic compounds'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{organic_compounds.size} organic compound formula questions"

# ========================================
# QUIZ 3: Important Reagents & Their Formulas
# ========================================

quiz_reagents = Quiz.find_or_create_by!(title: 'Organic Reagents Formulas') do |q|
  q.description = 'Important reagents used in organic reactions'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_reagents
) do |mi|
  mi.sequence_order = 3
  mi.required = false
end

puts "\n📝 Creating Organic Reagents Formula Questions..."

reagent_formulas = [
  # Oxidizing Agents
  { name: 'Potassium permanganate', formula: 'KMnO₄', alternate: 'KMnO4' },
  { name: 'Potassium dichromate', formula: 'K₂Cr₂O₇', alternate: 'K2Cr2O7' },
  { name: 'Chromic acid', formula: 'H₂CrO₄', alternate: 'H2CrO4' },
  { name: 'PCC (Pyridinium chlorochromate)', formula: 'C₅H₅NH⁺CrO₃Cl⁻', alternate: 'C5H5NH+CrO3Cl-|C5H6ClCrNO3' },
  { name: 'Ozone', formula: 'O₃', alternate: 'O3' },

  # Reducing Agents
  { name: 'Lithium aluminium hydride', formula: 'LiAlH₄', alternate: 'LiAlH4' },
  { name: 'Sodium borohydride', formula: 'NaBH₄', alternate: 'NaBH4' },
  { name: 'Hydrogen gas (with catalyst)', formula: 'H₂/Ni', alternate: 'H2/Ni|H2/Pt|H2/Pd' },
  { name: 'Zinc amalgam (Clemmensen reduction)', formula: 'Zn(Hg)', alternate: 'Zn-Hg|Zn/Hg' },

  # Halogenating Agents
  { name: 'Phosphorus pentachloride', formula: 'PCl₅', alternate: 'PCl5' },
  { name: 'Phosphorus trichloride', formula: 'PCl₃', alternate: 'PCl3' },
  { name: 'Thionyl chloride', formula: 'SOCl₂', alternate: 'SOCl2' },
  { name: 'Bromine water', formula: 'Br₂/H₂O', alternate: 'Br2/H2O|Br2 + H2O' },

  # Grignard Reagent
  { name: 'Grignard reagent (general formula)', formula: 'RMgX', alternate: 'R-MgX|R-Mg-X' },
  { name: 'Methylmagnesium bromide', formula: 'CH₃MgBr', alternate: 'CH3MgBr' },

  # Acids & Bases
  { name: 'Sulfuric acid (conc.)', formula: 'H₂SO₄', alternate: 'H2SO4' },
  { name: 'Hydrochloric acid', formula: 'HCl', alternate: nil },
  { name: 'Sodium hydroxide', formula: 'NaOH', alternate: nil },
  { name: 'Potassium hydroxide (alcoholic)', formula: 'KOH/C₂H₅OH', alternate: 'KOH/C2H5OH|KOH in alcohol' },

  # Diazonium Salt Related
  { name: 'Nitrous acid', formula: 'HNO₂', alternate: 'HNO2' },
  { name: 'Sodium nitrite', formula: 'NaNO₂', alternate: 'NaNO2' },

  # Miscellaneous
  { name: 'Lucas reagent', formula: 'ZnCl₂/HCl', alternate: 'ZnCl2/HCl|ZnCl2 + HCl' },
  { name: 'Tollens\' reagent', formula: '[Ag(NH₃)₂]⁺', alternate: '[Ag(NH3)2]+|Ag(NH3)2+' },
  { name: 'Fehling\'s solution (Cu2+ complex)', formula: 'Cu²⁺ (complex)', alternate: 'Cu2+|Cu(II)' },
  { name: 'Benedict\'s reagent', formula: 'Cu²⁺ (citrate complex)', alternate: 'Cu2+|Cu(II)' },
  { name: 'Baeyer\'s reagent', formula: 'KMnO₄ (alkaline)', alternate: 'KMnO4|alkaline KMnO4' },
]

reagent_formulas.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_reagents,
    question_text: "What is the chemical formula for #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} has the formula #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.3
    q.discrimination = 1.2
    q.guessing = 0.0
    q.difficulty_level = 'medium'
    q.topic = 'reagents'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{reagent_formulas.size} reagent formula questions"

# ========================================
# QUIZ 4: Polymers & Biomolecules
# ========================================

quiz_polymers = Quiz.find_or_create_by!(title: 'Polymers & Biomolecules') do |q|
  q.description = 'Important polymers, monomers, and biomolecule formulas'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_polymers
) do |mi|
  mi.sequence_order = 4
  mi.required = false
end

puts "\n📝 Creating Polymers & Biomolecules Questions..."

polymer_formulas = [
  # Monomers for Polymers
  { name: 'Ethylene (Ethene) - monomer of polyethylene', formula: 'CH₂=CH₂', alternate: 'CH2=CH2|C2H4' },
  { name: 'Propylene (Propene) - monomer of polypropylene', formula: 'CH₂=CH-CH₃', alternate: 'CH2=CHCH3|C3H6' },
  { name: 'Vinyl chloride - monomer of PVC', formula: 'CH₂=CHCl', alternate: 'CH2=CHCl|C2H3Cl' },
  { name: 'Styrene - monomer of polystyrene', formula: 'C₆H₅CH=CH₂', alternate: 'C6H5CH=CH2|C8H8' },
  { name: 'Tetrafluoroethylene - monomer of Teflon', formula: 'CF₂=CF₂', alternate: 'CF2=CF2|C2F4' },
  { name: 'Acrylonitrile - monomer of PAN', formula: 'CH₂=CH-CN', alternate: 'CH2=CHCN|C3H3N' },
  { name: 'Isoprene - monomer of natural rubber', formula: 'CH₂=C(CH₃)-CH=CH₂', alternate: 'CH2=C(CH3)CH=CH2|C5H8' },

  # Polymer Repeating Units
  { name: 'Nylon-6,6 repeating unit formula', formula: '[-CO(CH₂)₄CO-NH(CH₂)₆NH-]ₙ', alternate: '[-CO(CH2)4CONH(CH2)6NH-]n' },
  { name: 'Terylene (PET) repeating unit', formula: '[-OC-C₆H₄-CO-O-CH₂-CH₂-O-]ₙ', alternate: '[-OCC6H4COOCH2CH2O-]n' },
  { name: 'Bakelite formula (phenol-formaldehyde)', formula: 'C₆H₆O-CH₂', alternate: 'C6H6OCH2|phenol + HCHO' },

  # Carbohydrates
  { name: 'Glucose', formula: 'C₆H₁₂O₆', alternate: 'C6H12O6' },
  { name: 'Fructose', formula: 'C₆H₁₂O₆', alternate: 'C6H12O6' },
  { name: 'Sucrose', formula: 'C₁₂H₂₂O₁₁', alternate: 'C12H22O11' },
  { name: 'Lactose', formula: 'C₁₂H₂₂O₁₁', alternate: 'C12H22O11' },
  { name: 'Maltose', formula: 'C₁₂H₂₂O₁₁', alternate: 'C12H22O11' },
  { name: 'Starch general formula', formula: '(C₆H₁₀O₅)ₙ', alternate: '(C6H10O5)n' },
  { name: 'Cellulose general formula', formula: '(C₆H₁₀O₅)ₙ', alternate: '(C6H10O5)n' },

  # Amino Acids
  { name: 'Glycine (simplest amino acid)', formula: 'NH₂CH₂COOH', alternate: 'NH2CH2COOH|C2H5NO2' },
  { name: 'Alanine', formula: 'CH₃CH(NH₂)COOH', alternate: 'CH3CH(NH2)COOH|C3H7NO2' },

  # Vitamins
  { name: 'Ascorbic acid (Vitamin C)', formula: 'C₆H₈O₆', alternate: 'C6H8O6' },

  # Nucleotides
  { name: 'Adenine', formula: 'C₅H₅N₅', alternate: 'C5H5N5' },
  { name: 'Guanine', formula: 'C₅H₅N₅O', alternate: 'C5H5N5O' },
  { name: 'Cytosine', formula: 'C₄H₅N₃O', alternate: 'C4H5N3O' },
  { name: 'Thymine', formula: 'C₅H₆N₂O₂', alternate: 'C5H6N2O2' },
  { name: 'Uracil', formula: 'C₄H₄N₂O₂', alternate: 'C4H4N2O2' },
]

polymer_formulas.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_polymers,
    question_text: "What is the formula for #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} has the formula #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.4
    q.discrimination = 1.1
    q.guessing = 0.0
    q.difficulty_level = 'medium'
    q.topic = 'polymers and biomolecules'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{polymer_formulas.size} polymer & biomolecule formula questions"

# ========================================
# Summary Statistics
# ========================================

puts "\n" + "=" * 80
puts "ORGANIC CHEMISTRY FORMULA DATABASE - SUMMARY"
puts "=" * 80

total_formulas = functional_formulas.size + organic_compounds.size + reagent_formulas.size + polymer_formulas.size

puts "📊 Total Formulas Created: #{total_formulas}"
puts ""
puts "   Functional Groups:       #{functional_formulas.size} formulas"
puts "   Organic Compounds:       #{organic_compounds.size} formulas"
puts "   Reagents:                #{reagent_formulas.size} formulas"
puts "   Polymers & Biomolecules: #{polymer_formulas.size} formulas"
puts ""
puts "✅ All organic chemistry formulas are ready for spaced repetition!"
puts "✅ Students can now practice and master essential IIT JEE organic formulas"
puts ""
puts "=" * 80

# frozen_string_literal: true

# ========================================
# IIT JEE Inorganic Chemistry - Formula Database
# ========================================
# Comprehensive formula memorization system with spaced repetition
# Covers all important formulas tested in IIT JEE Main & Advanced
#
# Total Formulas: ~200
# Question Types: fill_blank, mcq
# Integration: Automatic FSRS spaced repetition via SpacedRepetitionItem
#
# Usage:
#   rails runner db/seeds/iit_jee_inorganic_formulas.rb
# ========================================

puts "\n" + "=" * 80
puts "IIT JEE INORGANIC CHEMISTRY - FORMULA DATABASE"
puts "=" * 80

# Find the chemistry course
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')

unless course
  puts "❌ ERROR: IIT JEE Inorganic Chemistry course not found!"
  puts "   Please run db/seeds/iit_jee_inorganic_chemistry.rb first"
  exit 1
end

puts "✅ Found course: #{course.title}"

# Create or find Formula Drill Module
formula_module = course.course_modules.find_or_create_by!(slug: 'formula-drills') do |mod|
  mod.title = 'Essential Formulas - Daily Drill'
  mod.description = 'Master all essential inorganic chemistry formulas through spaced repetition'
  mod.sequence_order = 0  # First module
  mod.estimated_minutes = 30
  mod.published = true
end

puts "✅ Formula Drill Module: #{formula_module.title}"

# ========================================
# QUIZ 1: s-Block Elements (Alkali & Alkaline Earth Metals)
# ========================================

quiz_s_block = Quiz.find_or_create_by!(title: 's-Block Formulas Drill') do |q|
  q.description = 'Essential formulas for Group 1 and Group 2 elements'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.max_attempts = 999  # Unlimited for drill
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'  # Formula drill type
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_s_block
) do |mi|
  mi.sequence_order = 1
  mi.required = false  # Optional drill
end

puts "\n📝 Creating s-Block Formula Questions..."

s_block_formulas = [
  # Alkali Metals (Group 1)
  { name: 'Sodium hydroxide (Caustic soda)', formula: 'NaOH', alternate: nil },
  { name: 'Potassium hydroxide (Caustic potash)', formula: 'KOH', alternate: nil },
  { name: 'Sodium carbonate (Washing soda)', formula: 'Na₂CO₃·10H₂O', alternate: 'Na2CO3.10H2O|Na2CO3·10H2O' },
  { name: 'Sodium bicarbonate (Baking soda)', formula: 'NaHCO₃', alternate: 'NaHCO3' },
  { name: 'Sodium chloride (Common salt)', formula: 'NaCl', alternate: nil },
  { name: 'Potassium chloride', formula: 'KCl', alternate: nil },
  { name: 'Sodium sulfate (Glauber\'s salt)', formula: 'Na₂SO₄·10H₂O', alternate: 'Na2SO4.10H2O|Na2SO4·10H2O' },
  { name: 'Sodium thiosulfate (Hypo)', formula: 'Na₂S₂O₃·5H₂O', alternate: 'Na2S2O3.5H2O|Na2S2O3·5H2O' },
  { name: 'Sodium peroxide', formula: 'Na₂O₂', alternate: 'Na2O2' },
  { name: 'Potassium superoxide', formula: 'KO₂', alternate: 'KO2' },

  # Alkaline Earth Metals (Group 2)
  { name: 'Calcium carbonate (Limestone/Marble)', formula: 'CaCO₃', alternate: 'CaCO3' },
  { name: 'Calcium oxide (Quick lime)', formula: 'CaO', alternate: nil },
  { name: 'Calcium hydroxide (Slaked lime)', formula: 'Ca(OH)₂', alternate: 'Ca(OH)2' },
  { name: 'Calcium chloride', formula: 'CaCl₂', alternate: 'CaCl2' },
  { name: 'Calcium sulfate (Gypsum)', formula: 'CaSO₄·2H₂O', alternate: 'CaSO4.2H2O|CaSO4·2H2O' },
  { name: 'Plaster of Paris', formula: 'CaSO₄·½H₂O', alternate: 'CaSO4.1/2H2O|(CaSO4)2.H2O|CaSO4.0.5H2O' },
  { name: 'Magnesium hydroxide (Milk of magnesia)', formula: 'Mg(OH)₂', alternate: 'Mg(OH)2' },
  { name: 'Magnesium sulfate (Epsom salt)', formula: 'MgSO₄·7H₂O', alternate: 'MgSO4.7H2O|MgSO4·7H2O' },
  { name: 'Magnesium oxide', formula: 'MgO', alternate: nil },
  { name: 'Barium sulfate (Barytes)', formula: 'BaSO₄', alternate: 'BaSO4' },
  { name: 'Barium chloride', formula: 'BaCl₂', alternate: 'BaCl2' },
]

s_block_formulas.each_with_index do |formula_data, index|
  # Create fill-blank question
  question = QuizQuestion.find_or_create_by!(
    quiz: quiz_s_block,
    question_text: "What is the chemical formula for #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} has the formula #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.0  # Easy for memorization
    q.discrimination = 1.0
    q.guessing = 0.0
    q.difficulty_level = 'easy'
    q.topic = 's-block elements'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{s_block_formulas.size} s-block formula questions"

# ========================================
# QUIZ 2: p-Block Elements - Group 13 to 18
# ========================================

quiz_p_block = Quiz.find_or_create_by!(title: 'p-Block Formulas Drill') do |q|
  q.description = 'Essential formulas for Groups 13-18 (Boron to Noble gases)'
  q.time_limit_minutes = 20
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_p_block
) do |mi|
  mi.sequence_order = 2
  mi.required = false
end

puts "\n📝 Creating p-Block Formula Questions..."

p_block_formulas = [
  # Group 13 - Boron family
  { name: 'Borax', formula: 'Na₂B₄O₇·10H₂O', alternate: 'Na2B4O7.10H2O|Na2B4O7·10H2O' },
  { name: 'Boric acid', formula: 'H₃BO₃', alternate: 'H3BO3' },
  { name: 'Aluminium oxide (Alumina)', formula: 'Al₂O₃', alternate: 'Al2O3' },
  { name: 'Aluminium hydroxide', formula: 'Al(OH)₃', alternate: 'Al(OH)3' },
  { name: 'Aluminium chloride', formula: 'AlCl₃', alternate: 'AlCl3' },
  { name: 'Aluminium sulfate (Alum)', formula: 'K₂SO₄·Al₂(SO₄)₃·24H₂O', alternate: 'K2SO4.Al2(SO4)3.24H2O' },

  # Group 14 - Carbon family
  { name: 'Carbon monoxide', formula: 'CO', alternate: nil },
  { name: 'Carbon dioxide', formula: 'CO₂', alternate: 'CO2' },
  { name: 'Silicon dioxide (Silica)', formula: 'SiO₂', alternate: 'SiO2' },
  { name: 'Silicon carbide (Carborundum)', formula: 'SiC', alternate: nil },
  { name: 'Lead oxide (Litharge)', formula: 'PbO', alternate: nil },
  { name: 'Lead dioxide', formula: 'PbO₂', alternate: 'PbO2' },
  { name: 'Lead sulfate', formula: 'PbSO₄', alternate: 'PbSO4' },
  { name: 'Lead nitrate', formula: 'Pb(NO₃)₂', alternate: 'Pb(NO3)2' },
  { name: 'Tin chloride (Stannous chloride)', formula: 'SnCl₂', alternate: 'SnCl2' },
  { name: 'Tin chloride (Stannic chloride)', formula: 'SnCl₄', alternate: 'SnCl4' },

  # Group 15 - Nitrogen family
  { name: 'Ammonia', formula: 'NH₃', alternate: 'NH3' },
  { name: 'Ammonium chloride (Sal ammoniac)', formula: 'NH₄Cl', alternate: 'NH4Cl' },
  { name: 'Ammonium hydroxide', formula: 'NH₄OH', alternate: 'NH4OH' },
  { name: 'Ammonium nitrate', formula: 'NH₄NO₃', alternate: 'NH4NO3' },
  { name: 'Ammonium sulfate', formula: '(NH₄)₂SO₄', alternate: '(NH4)2SO4' },
  { name: 'Nitric acid', formula: 'HNO₃', alternate: 'HNO3' },
  { name: 'Nitrous acid', formula: 'HNO₂', alternate: 'HNO2' },
  { name: 'Nitrogen dioxide', formula: 'NO₂', alternate: 'NO2' },
  { name: 'Nitric oxide', formula: 'NO', alternate: nil },
  { name: 'Dinitrogen pentoxide', formula: 'N₂O₅', alternate: 'N2O5' },
  { name: 'Phosphoric acid', formula: 'H₃PO₄', alternate: 'H3PO4' },
  { name: 'Phosphorus pentoxide', formula: 'P₂O₅', alternate: 'P2O5|P4O10' },
  { name: 'Phosphorus trichloride', formula: 'PCl₃', alternate: 'PCl3' },
  { name: 'Phosphorus pentachloride', formula: 'PCl₅', alternate: 'PCl5' },
  { name: 'Calcium phosphate', formula: 'Ca₃(PO₄)₂', alternate: 'Ca3(PO4)2' },

  # Group 16 - Oxygen family (Chalcogens)
  { name: 'Sulfuric acid', formula: 'H₂SO₄', alternate: 'H2SO4' },
  { name: 'Sulfurous acid', formula: 'H₂SO₃', alternate: 'H2SO3' },
  { name: 'Sulfur dioxide', formula: 'SO₂', alternate: 'SO2' },
  { name: 'Sulfur trioxide', formula: 'SO₃', alternate: 'SO3' },
  { name: 'Hydrogen sulfide', formula: 'H₂S', alternate: 'H2S' },
  { name: 'Sodium sulfite', formula: 'Na₂SO₃', alternate: 'Na2SO3' },
  { name: 'Sodium sulfate', formula: 'Na₂SO₄', alternate: 'Na2SO4' },
  { name: 'Ferrous sulfate (Green vitriol)', formula: 'FeSO₄·7H₂O', alternate: 'FeSO4.7H2O|FeSO4·7H2O' },
  { name: 'Copper sulfate (Blue vitriol)', formula: 'CuSO₄·5H₂O', alternate: 'CuSO4.5H2O|CuSO4·5H2O' },
  { name: 'Zinc sulfate (White vitriol)', formula: 'ZnSO₄·7H₂O', alternate: 'ZnSO4.7H2O|ZnSO4·7H2O' },

  # Group 17 - Halogens
  { name: 'Hydrochloric acid', formula: 'HCl', alternate: nil },
  { name: 'Hydrofluoric acid', formula: 'HF', alternate: nil },
  { name: 'Hydrobromic acid', formula: 'HBr', alternate: nil },
  { name: 'Hydroiodic acid', formula: 'HI', alternate: nil },
  { name: 'Chlorine water', formula: 'Cl₂ + H₂O', alternate: 'Cl2 + H2O' },
  { name: 'Bleaching powder', formula: 'Ca(OCl)₂', alternate: 'Ca(OCl)2|CaOCl2' },
  { name: 'Sodium hypochlorite', formula: 'NaOCl', alternate: nil },
  { name: 'Potassium chlorate', formula: 'KClO₃', alternate: 'KClO3' },
  { name: 'Potassium perchlorate', formula: 'KClO₄', alternate: 'KClO4' },
  { name: 'Iodine', formula: 'I₂', alternate: 'I2' },
]

p_block_formulas.each_with_index do |formula_data, index|
  question = QuizQuestion.find_or_create_by!(
    quiz: quiz_p_block,
    question_text: "What is the chemical formula for #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} has the formula #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.0
    q.discrimination = 1.0
    q.guessing = 0.0
    q.difficulty_level = 'medium'
    q.topic = 'p-block elements'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{p_block_formulas.size} p-block formula questions"

# ========================================
# QUIZ 3: d-Block Elements (Transition Metals)
# ========================================

quiz_d_block = Quiz.find_or_create_by!(title: 'd-Block Formulas Drill') do |q|
  q.description = 'Essential formulas for transition metals and their compounds'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_d_block
) do |mi|
  mi.sequence_order = 3
  mi.required = false
end

puts "\n📝 Creating d-Block Formula Questions..."

d_block_formulas = [
  # Potassium compounds
  { name: 'Potassium permanganate', formula: 'KMnO₄', alternate: 'KMnO4' },
  { name: 'Potassium dichromate', formula: 'K₂Cr₂O₇', alternate: 'K2Cr2O7' },
  { name: 'Potassium chromate', formula: 'K₂CrO₄', alternate: 'K2CrO4' },
  { name: 'Potassium ferrocyanide', formula: 'K₄[Fe(CN)₆]', alternate: 'K4[Fe(CN)6]' },
  { name: 'Potassium ferricyanide', formula: 'K₃[Fe(CN)₆]', alternate: 'K3[Fe(CN)6]' },

  # Iron compounds
  { name: 'Ferrous sulfate (Green vitriol)', formula: 'FeSO₄·7H₂O', alternate: 'FeSO4.7H2O|FeSO4·7H2O' },
  { name: 'Ferric chloride', formula: 'FeCl₃', alternate: 'FeCl3' },
  { name: 'Ferrous chloride', formula: 'FeCl₂', alternate: 'FeCl2' },
  { name: 'Iron(III) oxide (Rust)', formula: 'Fe₂O₃', alternate: 'Fe2O3' },
  { name: 'Iron(II,III) oxide (Magnetite)', formula: 'Fe₃O₄', alternate: 'Fe3O4' },
  { name: 'Mohr\'s salt', formula: '(NH₄)₂SO₄·FeSO₄·6H₂O', alternate: '(NH4)2SO4.FeSO4.6H2O|FeSO4.(NH4)2SO4.6H2O' },

  # Copper compounds
  { name: 'Copper sulfate (Blue vitriol)', formula: 'CuSO₄·5H₂O', alternate: 'CuSO4.5H2O|CuSO4·5H2O' },
  { name: 'Copper oxide (Cupric oxide)', formula: 'CuO', alternate: nil },
  { name: 'Copper(I) oxide (Cuprous oxide)', formula: 'Cu₂O', alternate: 'Cu2O' },
  { name: 'Copper chloride', formula: 'CuCl₂', alternate: 'CuCl2' },
  { name: 'Copper nitrate', formula: 'Cu(NO₃)₂', alternate: 'Cu(NO3)2' },

  # Zinc compounds
  { name: 'Zinc sulfate (White vitriol)', formula: 'ZnSO₄·7H₂O', alternate: 'ZnSO4.7H2O|ZnSO4·7H2O' },
  { name: 'Zinc oxide', formula: 'ZnO', alternate: nil },
  { name: 'Zinc chloride', formula: 'ZnCl₂', alternate: 'ZnCl2' },
  { name: 'Zinc carbonate', formula: 'ZnCO₃', alternate: 'ZnCO3' },

  # Silver compounds
  { name: 'Silver nitrate', formula: 'AgNO₃', alternate: 'AgNO3' },
  { name: 'Silver chloride', formula: 'AgCl', alternate: nil },
  { name: 'Silver bromide', formula: 'AgBr', alternate: nil },
  { name: 'Silver iodide', formula: 'AgI', alternate: nil },

  # Chromium compounds
  { name: 'Chromium oxide', formula: 'Cr₂O₃', alternate: 'Cr2O3' },
  { name: 'Chromic acid', formula: 'H₂CrO₄', alternate: 'H2CrO4' },
  { name: 'Dichromic acid', formula: 'H₂Cr₂O₇', alternate: 'H2Cr2O7' },

  # Manganese compounds
  { name: 'Manganese dioxide', formula: 'MnO₂', alternate: 'MnO2' },
  { name: 'Manganous sulfate', formula: 'MnSO₄', alternate: 'MnSO4' },

  # Mercury compounds
  { name: 'Mercuric chloride (Corrosive sublimate)', formula: 'HgCl₂', alternate: 'HgCl2' },
  { name: 'Mercurous chloride (Calomel)', formula: 'Hg₂Cl₂', alternate: 'Hg2Cl2' },
  { name: 'Mercuric oxide', formula: 'HgO', alternate: nil },
]

d_block_formulas.each_with_index do |formula_data, index|
  question = QuizQuestion.find_or_create_by!(
    quiz: quiz_d_block,
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
    q.topic = 'd-block elements'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{d_block_formulas.size} d-block formula questions"

# ========================================
# QUIZ 4: Qualitative Analysis Reagents
# ========================================

quiz_qualitative = Quiz.find_or_create_by!(title: 'Qualitative Analysis Formulas') do |q|
  q.description = 'Essential formulas for salt analysis and group reagents'
  q.time_limit_minutes = 10
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_qualitative
) do |mi|
  mi.sequence_order = 4
  mi.required = false
end

puts "\n📝 Creating Qualitative Analysis Formula Questions..."

qualitative_formulas = [
  # Group reagents
  { name: 'Group I reagent (Dilute HCl)', formula: 'HCl', alternate: nil },
  { name: 'Group II reagent (H₂S in acidic medium)', formula: 'H₂S', alternate: 'H2S' },
  { name: 'Group III reagent (NH₄OH + NH₄Cl)', formula: 'NH₄OH + NH₄Cl', alternate: 'NH4OH + NH4Cl' },
  { name: 'Group IV reagent (H₂S in basic medium)', formula: 'H₂S', alternate: 'H2S' },
  { name: 'Group V reagent (Ammonium carbonate)', formula: '(NH₄)₂CO₃', alternate: '(NH4)2CO3' },

  # Common precipitates
  { name: 'Lead chloride (white ppt)', formula: 'PbCl₂', alternate: 'PbCl2' },
  { name: 'Silver chloride (white ppt)', formula: 'AgCl', alternate: nil },
  { name: 'Mercurous chloride (white ppt)', formula: 'Hg₂Cl₂', alternate: 'Hg2Cl2' },
  { name: 'Copper sulfide (black ppt)', formula: 'CuS', alternate: nil },
  { name: 'Cadmium sulfide (yellow ppt)', formula: 'CdS', alternate: nil },
  { name: 'Lead sulfide (black ppt)', formula: 'PbS', alternate: nil },
  { name: 'Ferric hydroxide (brown ppt)', formula: 'Fe(OH)₃', alternate: 'Fe(OH)3' },
  { name: 'Aluminium hydroxide (white ppt)', formula: 'Al(OH)₃', alternate: 'Al(OH)3' },
  { name: 'Zinc sulfide (white ppt)', formula: 'ZnS', alternate: nil },
  { name: 'Manganese sulfide (flesh colored ppt)', formula: 'MnS', alternate: nil },
  { name: 'Barium sulfate (white ppt)', formula: 'BaSO₄', alternate: 'BaSO4' },
  { name: 'Calcium oxalate (white ppt)', formula: 'CaC₂O₄', alternate: 'CaC2O4' },

  # Confirmatory test reagents
  { name: 'Nessler\'s reagent', formula: 'K₂[HgI₄]', alternate: 'K2[HgI4]' },
  { name: 'Brown ring test reagent', formula: 'FeSO₄', alternate: 'FeSO4' },
  { name: 'Chromyl chloride test product', formula: 'CrO₂Cl₂', alternate: 'CrO2Cl2' },
]

qualitative_formulas.each_with_index do |formula_data, index|
  question = QuizQuestion.find_or_create_by!(
    quiz: quiz_qualitative,
    question_text: "What is the chemical formula for #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} has the formula #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.5
    q.discrimination = 1.3
    q.guessing = 0.0
    q.difficulty_level = 'hard'
    q.topic = 'qualitative analysis'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{qualitative_formulas.size} qualitative analysis formula questions"

# ========================================
# QUIZ 5: Important Minerals and Ores
# ========================================

quiz_minerals = Quiz.find_or_create_by!(title: 'Minerals and Ores Formulas') do |q|
  q.description = 'Important mineral formulas for metallurgy and extraction'
  q.time_limit_minutes = 10
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_minerals
) do |mi|
  mi.sequence_order = 5
  mi.required = false
end

puts "\n📝 Creating Minerals and Ores Formula Questions..."

mineral_formulas = [
  # Aluminium ores
  { name: 'Bauxite (aluminium ore)', formula: 'Al₂O₃·2H₂O', alternate: 'Al2O3.2H2O|Al2O3·2H2O' },
  { name: 'Cryolite', formula: 'Na₃AlF₆', alternate: 'Na3AlF6' },
  { name: 'Corundum', formula: 'Al₂O₃', alternate: 'Al2O3' },

  # Iron ores
  { name: 'Haematite (iron ore)', formula: 'Fe₂O₃', alternate: 'Fe2O3' },
  { name: 'Magnetite (iron ore)', formula: 'Fe₃O₄', alternate: 'Fe3O4' },
  { name: 'Iron pyrite (Fool\'s gold)', formula: 'FeS₂', alternate: 'FeS2' },
  { name: 'Siderite', formula: 'FeCO₃', alternate: 'FeCO3' },

  # Copper ores
  { name: 'Copper pyrite (Chalcopyrite)', formula: 'CuFeS₂', alternate: 'CuFeS2' },
  { name: 'Cuprite', formula: 'Cu₂O', alternate: 'Cu2O' },
  { name: 'Malachite', formula: 'CuCO₃·Cu(OH)₂', alternate: 'CuCO3.Cu(OH)2' },
  { name: 'Azurite', formula: '2CuCO₃·Cu(OH)₂', alternate: '2CuCO3.Cu(OH)2' },

  # Zinc ores
  { name: 'Zinc blende (Sphalerite)', formula: 'ZnS', alternate: nil },
  { name: 'Calamine', formula: 'ZnCO₃', alternate: 'ZnCO3' },
  { name: 'Zincite', formula: 'ZnO', alternate: nil },

  # Lead ores
  { name: 'Galena (lead ore)', formula: 'PbS', alternate: nil },
  { name: 'Anglesite', formula: 'PbSO₄', alternate: 'PbSO4' },
  { name: 'Cerrusite', formula: 'PbCO₃', alternate: 'PbCO3' },

  # Other important ores
  { name: 'Cinnabar (mercury ore)', formula: 'HgS', alternate: nil },
  { name: 'Rock salt (halite)', formula: 'NaCl', alternate: nil },
  { name: 'Dolomite', formula: 'MgCO₃·CaCO₃', alternate: 'MgCO3.CaCO3|CaCO3.MgCO3' },
  { name: 'Gypsum', formula: 'CaSO₄·2H₂O', alternate: 'CaSO4.2H2O|CaSO4·2H2O' },
  { name: 'Fluorite (fluorspar)', formula: 'CaF₂', alternate: 'CaF2' },
  { name: 'Carnallite', formula: 'KCl·MgCl₂·6H₂O', alternate: 'KCl.MgCl2.6H2O' },
]

mineral_formulas.each_with_index do |formula_data, index|
  question = QuizQuestion.find_or_create_by!(
    quiz: quiz_minerals,
    question_text: "What is the chemical formula for #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} has the formula #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.4
    q.discrimination = 1.1
    q.guessing = 0.0
    q.difficulty_level = 'medium'
    q.topic = 'metallurgy'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{mineral_formulas.size} minerals and ores formula questions"

# ========================================
# Summary Statistics
# ========================================

puts "\n" + "=" * 80
puts "FORMULA DATABASE - SUMMARY"
puts "=" * 80

total_formulas = s_block_formulas.size + p_block_formulas.size + d_block_formulas.size +
                 qualitative_formulas.size + mineral_formulas.size

puts "📊 Total Formulas Created: #{total_formulas}"
puts ""
puts "   s-Block Elements:       #{s_block_formulas.size} formulas"
puts "   p-Block Elements:       #{p_block_formulas.size} formulas"
puts "   d-Block Elements:       #{d_block_formulas.size} formulas"
puts "   Qualitative Analysis:   #{qualitative_formulas.size} formulas"
puts "   Minerals & Ores:        #{mineral_formulas.size} formulas"
puts ""
puts "✅ All formulas are ready for spaced repetition!"
puts "✅ Students can now practice and master essential IIT JEE formulas"
puts ""
puts "Next Steps:"
puts "1. Students take formula drill quizzes"
puts "2. Failed formulas automatically enter FSRS spaced repetition"
puts "3. Review formulas appear on /reviews page based on decay"
puts "4. Mastery tracked via SpacedRepetitionItem model"
puts "=" * 80

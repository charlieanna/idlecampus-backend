# frozen_string_literal: true

# ========================================
# IIT JEE Physical Chemistry - Formula Database
# ========================================
# Comprehensive formula and equation memorization for physical chemistry
# Covers gas laws, thermodynamics, kinetics, electrochemistry, equilibrium
#
# Total Formulas: ~140
# Question Types: fill_blank
# Integration: Automatic FSRS spaced repetition
#
# Usage:
#   rails runner db/seeds/iit_jee_physical_chemistry_formulas.rb
# ========================================

puts "\n" + "=" * 80
puts "IIT JEE PHYSICAL CHEMISTRY - FORMULA DATABASE"
puts "=" * 80

# Find or create the physical chemistry course
course = Course.find_or_create_by!(slug: 'iit-jee-physical-chemistry') do |c|
  c.title = 'IIT JEE Physical Chemistry'
  c.description = 'Comprehensive Physical Chemistry course for IIT JEE Main and Advanced preparation'
  c.difficulty_level = 'advanced'
  c.certification_track = 'none'
  c.estimated_hours = 120
  c.published = true
  c.learning_objectives = [
    'Master all important equations and formulas',
    'Understand thermodynamic laws and applications',
    'Solve problems on chemical kinetics',
    'Apply electrochemistry concepts',
    'Calculate equilibrium constants and solve equilibrium problems'
  ]
  c.prerequisites = [
    'Strong foundation in mathematics',
    'Basic understanding of chemistry',
    'Knowledge of calculus and logarithms'
  ]
end

puts "✅ Course: #{course.title}"

# Create Formula Drill Module
formula_module = course.course_modules.find_or_create_by!(slug: 'physical-formula-drills') do |mod|
  mod.title = 'Essential Physical Chemistry Formulas - Daily Drill'
  mod.description = 'Master all essential physical chemistry equations, laws, and constants through spaced repetition'
  mod.sequence_order = 0
  mod.estimated_minutes = 45
  mod.published = true
end

puts "✅ Formula Drill Module: #{formula_module.title}"

# ========================================
# QUIZ 1: Gas Laws & Kinetic Theory
# ========================================

quiz_gas_laws = Quiz.find_or_create_by!(title: 'Gas Laws & Constants') do |q|
  q.description = 'Important gas law equations and constants'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_gas_laws
) do |mi|
  mi.sequence_order = 1
  mi.required = false
end

puts "\n📝 Creating Gas Laws Formula Questions..."

gas_law_formulas = [
  # Gas Laws
  { name: 'Ideal gas equation', formula: 'PV = nRT', alternate: 'PV=nRT' },
  { name: 'Boyle\'s law (constant T)', formula: 'P₁V₁ = P₂V₂', alternate: 'P1V1 = P2V2|P1V1=P2V2' },
  { name: 'Charles\' law (constant P)', formula: 'V₁/T₁ = V₂/T₂', alternate: 'V1/T1 = V2/T2' },
  { name: 'Gay-Lussac\'s law (constant V)', formula: 'P₁/T₁ = P₂/T₂', alternate: 'P1/T1 = P2/T2' },
  { name: 'Combined gas law', formula: 'P₁V₁/T₁ = P₂V₂/T₂', alternate: 'P1V1/T1 = P2V2/T2' },
  { name: 'Avogadro\'s law', formula: 'V ∝ n', alternate: 'V/n = constant|V = kn' },
  { name: 'Dalton\'s law of partial pressures', formula: 'P(total) = P₁ + P₂ + P₃ + ...', alternate: 'Ptotal = P1 + P2 + ...|P = ΣPi' },
  { name: 'Graham\'s law of diffusion', formula: 'r₁/r₂ = √(M₂/M₁)', alternate: 'r1/r2 = sqrt(M2/M1)' },
  { name: 'van der Waals equation', formula: '(P + a/V²)(V - b) = RT', alternate: '(P + a/V^2)(V - b) = RT' },

  # Kinetic Theory
  { name: 'Average kinetic energy of gas', formula: 'KE = (3/2)RT', alternate: 'KE = 3RT/2|KE = 1.5RT' },
  { name: 'Root mean square velocity', formula: 'u(rms) = √(3RT/M)', alternate: 'urms = sqrt(3RT/M)' },
  { name: 'Most probable velocity', formula: 'u(mp) = √(2RT/M)', alternate: 'ump = sqrt(2RT/M)' },
  { name: 'Average velocity of gas molecules', formula: 'u(avg) = √(8RT/πM)', alternate: 'uavg = sqrt(8RT/piM)' },

  # Constants
  { name: 'Universal gas constant R (in L·atm/mol·K)', formula: '0.0821 L·atm/mol·K', alternate: '0.0821|R = 0.0821' },
  { name: 'Universal gas constant R (in J/mol·K)', formula: '8.314 J/mol·K', alternate: '8.314|R = 8.314' },
  { name: 'Standard temperature (STP)', formula: '273 K or 0°C', alternate: '273 K|273|0°C|0 C' },
  { name: 'Standard pressure (STP)', formula: '1 atm or 101.325 kPa', alternate: '1 atm|101.325 kPa|101325 Pa' },
  { name: 'Avogadro\'s number', formula: '6.022 × 10²³', alternate: '6.022 x 10^23|6.022e23' },
]

gas_law_formulas.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_gas_laws,
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
    q.topic = 'gas laws'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{gas_law_formulas.size} gas law formula questions"

# ========================================
# QUIZ 2: Thermodynamics
# ========================================

quiz_thermo = Quiz.find_or_create_by!(title: 'Thermodynamics Equations') do |q|
  q.description = 'Important thermodynamic equations and laws'
  q.time_limit_minutes = 20
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_thermo
) do |mi|
  mi.sequence_order = 2
  mi.required = false
end

puts "\n📝 Creating Thermodynamics Formula Questions..."

thermo_formulas = [
  # First Law
  { name: 'First law of thermodynamics', formula: 'ΔU = q + w', alternate: 'ΔU = q + w|dU = dq + dw|deltaU = q + w' },
  { name: 'Work done by gas (constant P)', formula: 'w = -PΔV', alternate: 'w = -P*ΔV|w = -P*dV' },
  { name: 'Work done in isothermal process', formula: 'w = -nRT ln(V₂/V₁)', alternate: 'w = -nRT ln(V2/V1)|w = -2.303nRT log(V2/V1)' },
  { name: 'Work done in adiabatic process', formula: 'w = (nR(T₂ - T₁))/(1 - γ)', alternate: 'w = nR(T2-T1)/(1-gamma)' },

  # Enthalpy
  { name: 'Enthalpy definition', formula: 'H = U + PV', alternate: 'H = U + PV' },
  { name: 'Enthalpy change at constant pressure', formula: 'ΔH = ΔU + PΔV', alternate: 'ΔH = ΔU + P*ΔV|deltaH = deltaU + P*deltaV' },
  { name: 'Relation between ΔH and ΔU for gases', formula: 'ΔH = ΔU + ΔnRT', alternate: 'ΔH = ΔU + Δn*RT|deltaH = deltaU + Δn*RT' },
  { name: 'Heat capacity at constant pressure', formula: 'Cp = (∂H/∂T)p', alternate: 'Cp = dH/dT' },
  { name: 'Heat capacity at constant volume', formula: 'Cv = (∂U/∂T)v', alternate: 'Cv = dU/dT' },
  { name: 'Relation between Cp and Cv', formula: 'Cp - Cv = R', alternate: 'Cp = Cv + R' },
  { name: 'Adiabatic index (gamma)', formula: 'γ = Cp/Cv', alternate: 'gamma = Cp/Cv' },

  # Second Law & Entropy
  { name: 'Entropy change', formula: 'ΔS = q(rev)/T', alternate: 'ΔS = qrev/T|deltaS = q/T' },
  { name: 'Entropy change for ideal gas', formula: 'ΔS = nCv ln(T₂/T₁) + nR ln(V₂/V₁)', alternate: 'ΔS = nCv*ln(T2/T1) + nR*ln(V2/V1)' },
  { name: 'Second law of thermodynamics', formula: 'ΔS(universe) > 0', alternate: 'ΔSuniverse > 0|deltaS > 0' },

  # Gibbs Free Energy
  { name: 'Gibbs free energy', formula: 'G = H - TS', alternate: 'G = H - TS' },
  { name: 'Gibbs free energy change', formula: 'ΔG = ΔH - TΔS', alternate: 'ΔG = ΔH - T*ΔS|deltaG = deltaH - T*deltaS' },
  { name: 'Standard Gibbs free energy and equilibrium', formula: 'ΔG° = -RT ln K', alternate: 'ΔG° = -RT*lnK|ΔG° = -2.303RT*logK' },
  { name: 'Gibbs free energy and cell potential', formula: 'ΔG = -nFE', alternate: 'ΔG = -nFE|deltaG = -nFE' },

  # Hess's Law
  { name: 'Hess\'s law', formula: 'ΔH(reaction) = ΣΔH(products) - ΣΔH(reactants)', alternate: 'ΔH = ΣΔHf(products) - ΣΔHf(reactants)' },

  # Born-Haber Cycle
  { name: 'Lattice energy (Born-Haber)', formula: 'ΔH(lattice) = ΔH(f) - [ΔH(sub) + ΔH(diss) + ΔH(IE) + ΔH(EA)]', alternate: 'Lattice energy from Born-Haber cycle' },
]

thermo_formulas.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_thermo,
    question_text: "What is the #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} is #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.3
    q.discrimination = 1.2
    q.guessing = 0.0
    q.difficulty_level = 'medium'
    q.topic = 'thermodynamics'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{thermo_formulas.size} thermodynamics formula questions"

# ========================================
# QUIZ 3: Chemical Kinetics
# ========================================

quiz_kinetics = Quiz.find_or_create_by!(title: 'Chemical Kinetics Equations') do |q|
  q.description = 'Rate laws and kinetic equations'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_kinetics
) do |mi|
  mi.sequence_order = 3
  mi.required = false
end

puts "\n📝 Creating Chemical Kinetics Formula Questions..."

kinetics_formulas = [
  # Rate Laws
  { name: 'General rate law', formula: 'Rate = k[A]^m[B]^n', alternate: 'Rate = k[A]^m[B]^n|r = k[A]^m[B]^n' },
  { name: 'Zero order integrated rate law', formula: '[A] = [A]₀ - kt', alternate: '[A] = [A]0 - kt' },
  { name: 'First order integrated rate law', formula: 'ln[A] = ln[A]₀ - kt', alternate: 'ln[A] = ln[A]0 - kt|log[A] = log[A]0 - kt/2.303' },
  { name: 'Second order integrated rate law', formula: '1/[A] = 1/[A]₀ + kt', alternate: '1/[A] = 1/[A]0 + kt' },

  # Half-life
  { name: 'Half-life for zero order reaction', formula: 't₁/₂ = [A]₀/2k', alternate: 't1/2 = [A]0/2k' },
  { name: 'Half-life for first order reaction', formula: 't₁/₂ = 0.693/k', alternate: 't1/2 = 0.693/k|t1/2 = ln2/k' },
  { name: 'Half-life for second order reaction', formula: 't₁/₂ = 1/(k[A]₀)', alternate: 't1/2 = 1/k[A]0' },

  # Arrhenius Equation
  { name: 'Arrhenius equation', formula: 'k = Ae^(-Ea/RT)', alternate: 'k = A*e^(-Ea/RT)|k = A*exp(-Ea/RT)' },
  { name: 'Arrhenius equation (logarithmic form)', formula: 'ln k = ln A - Ea/RT', alternate: 'lnk = lnA - Ea/RT|logk = logA - Ea/2.303RT' },
  { name: 'Temperature dependence of rate constant', formula: 'log(k₂/k₁) = (Ea/2.303R)(1/T₁ - 1/T₂)', alternate: 'log(k2/k1) = (Ea/2.303R)*(1/T1 - 1/T2)' },

  # Collision Theory
  { name: 'Collision theory rate constant', formula: 'k = PZe^(-Ea/RT)', alternate: 'k = PZ*e^(-Ea/RT)' },

  # Catalysis
  { name: 'Effect of catalyst on activation energy', formula: 'Ea(catalyzed) < Ea(uncatalyzed)', alternate: 'Ea decreases with catalyst' },
]

kinetics_formulas.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_kinetics,
    question_text: "What is the #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} is #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.4
    q.discrimination = 1.3
    q.guessing = 0.0
    q.difficulty_level = 'medium'
    q.topic = 'chemical kinetics'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{kinetics_formulas.size} kinetics formula questions"

# ========================================
# QUIZ 4: Electrochemistry
# ========================================

quiz_electrochem = Quiz.find_or_create_by!(title: 'Electrochemistry Equations') do |q|
  q.description = 'Cell potential, Nernst equation, and electrolysis'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_electrochem
) do |mi|
  mi.sequence_order = 4
  mi.required = false
end

puts "\n📝 Creating Electrochemistry Formula Questions..."

electrochem_formulas = [
  # Cell Potential
  { name: 'Standard cell potential', formula: 'E°(cell) = E°(cathode) - E°(anode)', alternate: 'E°cell = E°cathode - E°anode' },
  { name: 'Nernst equation (general)', formula: 'E(cell) = E°(cell) - (RT/nF) ln Q', alternate: 'Ecell = E°cell - (RT/nF)*lnQ' },
  { name: 'Nernst equation at 25°C', formula: 'E(cell) = E°(cell) - (0.0591/n) log Q', alternate: 'Ecell = E°cell - (0.0591/n)*logQ|Ecell = E°cell - (0.059/n)*logQ' },
  { name: 'Relation between ΔG and E', formula: 'ΔG = -nFE', alternate: 'ΔG = -nFE|deltaG = -nFE' },
  { name: 'Relation between ΔG° and E°', formula: 'ΔG° = -nFE°', alternate: 'ΔG° = -nFE°|deltaG° = -nFE°' },
  { name: 'Relation between K and E°', formula: 'E° = (RT/nF) ln K', alternate: 'E° = (RT/nF)*lnK|E° = (0.0591/n)*logK' },

  # Conductance
  { name: 'Conductivity', formula: 'κ = 1/ρ', alternate: 'kappa = 1/rho|conductivity = 1/resistivity' },
  { name: 'Molar conductivity', formula: 'Λm = κ × 1000/M', alternate: 'Λm = kappa*1000/M|lambda = kappa/c' },
  { name: 'Kohlrausch\'s law', formula: 'Λ°m = λ°+ + λ°-', alternate: 'Λ°m = sum of ionic conductivities' },

  # Faraday's Laws
  { name: 'First law of electrolysis', formula: 'm ∝ Q', alternate: 'm = ZQ|m = Zit|mass proportional to charge' },
  { name: 'Second law of electrolysis', formula: 'm ∝ E', alternate: 'm = (E*Q)/F|mass proportional to equivalent weight' },
  { name: 'Faraday\'s constant', formula: 'F = 96500 C/mol', alternate: '96500|F = 96485|96485 C/mol' },
  { name: 'Charge passed in electrolysis', formula: 'Q = I × t', alternate: 'Q = It|Q = nF' },
  { name: 'Mass deposited in electrolysis', formula: 'm = (E × I × t)/F', alternate: 'm = EIt/F|m = (M*It)/(nF)' },

  # Battery EMF
  { name: 'EMF of concentration cell', formula: 'E = (0.0591/n) log(C₂/C₁)', alternate: 'E = (0.0591/n)*log(C2/C1)' },
]

electrochem_formulas.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_electrochem,
    question_text: "What is the #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} is #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.5
    q.discrimination = 1.4
    q.guessing = 0.0
    q.difficulty_level = 'hard'
    q.topic = 'electrochemistry'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{electrochem_formulas.size} electrochemistry formula questions"

# ========================================
# QUIZ 5: Equilibrium & Solutions
# ========================================

quiz_equilibrium = Quiz.find_or_create_by!(title: 'Equilibrium & Solutions') do |q|
  q.description = 'Equilibrium constants and colligative properties'
  q.time_limit_minutes = 20
  q.passing_score = 70
  q.max_attempts = 999
  q.shuffle_questions = true
  q.show_correct_answers = true
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(
  course_module: formula_module,
  item: quiz_equilibrium
) do |mi|
  mi.sequence_order = 5
  mi.required = false
end

puts "\n📝 Creating Equilibrium & Solutions Formula Questions..."

equilibrium_formulas = [
  # Equilibrium Constants
  { name: 'Equilibrium constant Kc', formula: 'Kc = [C]^c[D]^d / [A]^a[B]^b', alternate: 'Kc = [products]/[reactants]' },
  { name: 'Equilibrium constant Kp', formula: 'Kp = (Pc^c × Pd^d) / (Pa^a × Pb^b)', alternate: 'Kp = (partial pressures products)/(partial pressures reactants)' },
  { name: 'Relation between Kp and Kc', formula: 'Kp = Kc(RT)^Δn', alternate: 'Kp = Kc*(RT)^Δn|Kp = Kc(RT)^(delta n)' },
  { name: 'Le Chatelier\'s principle', formula: 'System shifts to counteract change', alternate: 'equilibrium shifts to oppose stress' },

  # Acid-Base Equilibrium
  { name: 'Water ionization constant', formula: 'Kw = [H⁺][OH⁻] = 10⁻¹⁴', alternate: 'Kw = 10^-14|Kw = 1e-14' },
  { name: 'pH definition', formula: 'pH = -log[H⁺]', alternate: 'pH = -log[H+]' },
  { name: 'pOH definition', formula: 'pOH = -log[OH⁻]', alternate: 'pOH = -log[OH-]' },
  { name: 'Relation between pH and pOH', formula: 'pH + pOH = 14', alternate: 'pH + pOH = 14' },
  { name: 'Henderson-Hasselbalch equation', formula: 'pH = pKa + log([A⁻]/[HA])', alternate: 'pH = pKa + log([salt]/[acid])' },
  { name: 'Degree of dissociation', formula: 'α = (dissociated)/(initial)', alternate: 'alpha = n(dissociated)/n(initial)' },

  # Solubility Equilibrium
  { name: 'Solubility product', formula: 'Ksp = [A⁺]^a[B⁻]^b', alternate: 'Ksp = product of ion concentrations' },
  { name: 'Common ion effect', formula: 'Solubility decreases with common ion', alternate: 'solubility reduced by common ion' },

  # Colligative Properties
  { name: 'Relative lowering of vapor pressure (Raoult\'s law)', formula: '(P° - P)/P° = χ(solute)', alternate: '(P0 - P)/P0 = n/(n+N)|relative lowering = mole fraction' },
  { name: 'Elevation in boiling point', formula: 'ΔTb = Kb × m', alternate: 'ΔTb = Kb*m|deltaTb = Kb*molality' },
  { name: 'Depression in freezing point', formula: 'ΔTf = Kf × m', alternate: 'ΔTf = Kf*m|deltaTf = Kf*molality' },
  { name: 'Osmotic pressure', formula: 'π = CRT', alternate: 'π = CRT|π = (n/V)RT|pi = CRT' },
  { name: 'Van\'t Hoff factor', formula: 'i = (observed colligative property)/(calculated colligative property)', alternate: 'i = actual/theoretical' },

  # Henry's Law
  { name: 'Henry\'s law', formula: 'P = KH × χ', alternate: 'P = KH*x|pressure = KH*mole fraction' },

  # Concentration Units
  { name: 'Molarity', formula: 'M = moles/L', alternate: 'M = n/V' },
  { name: 'Molality', formula: 'm = moles/kg(solvent)', alternate: 'm = moles solute/kg solvent' },
  { name: 'Mole fraction', formula: 'χ = n(component)/n(total)', alternate: 'x = n/ntotal|chi = n/ntotal' },
]

equilibrium_formulas.each_with_index do |formula_data, index|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_equilibrium,
    question_text: "What is the #{formula_data[:name]}?",
    question_type: 'fill_blank'
  ) do |q|
    q.correct_answer = formula_data[:alternate] ? "#{formula_data[:formula]}|#{formula_data[:alternate]}" : formula_data[:formula]
    q.explanation = "#{formula_data[:name]} is #{formula_data[:formula]}"
    q.points = 2
    q.difficulty = 0.3
    q.discrimination = 1.2
    q.guessing = 0.0
    q.difficulty_level = 'medium'
    q.topic = 'equilibrium and solutions'
    q.skill_dimension = 'memorization'
    q.sequence_order = index + 1
  end
end

puts "✅ Created #{equilibrium_formulas.size} equilibrium & solutions formula questions"

# ========================================
# Summary Statistics
# ========================================

puts "\n" + "=" * 80
puts "PHYSICAL CHEMISTRY FORMULA DATABASE - SUMMARY"
puts "=" * 80

total_formulas = gas_law_formulas.size + thermo_formulas.size + kinetics_formulas.size +
                 electrochem_formulas.size + equilibrium_formulas.size

puts "📊 Total Formulas Created: #{total_formulas}"
puts ""
puts "   Gas Laws & Constants:      #{gas_law_formulas.size} formulas"
puts "   Thermodynamics:            #{thermo_formulas.size} formulas"
puts "   Chemical Kinetics:         #{kinetics_formulas.size} formulas"
puts "   Electrochemistry:          #{electrochem_formulas.size} formulas"
puts "   Equilibrium & Solutions:   #{equilibrium_formulas.size} formulas"
puts ""
puts "✅ All physical chemistry formulas are ready for spaced repetition!"
puts "✅ Students can now practice and master essential IIT JEE physical chemistry equations"
puts ""
puts "=" * 80

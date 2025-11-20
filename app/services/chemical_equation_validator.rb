# Service to validate chemical equation balancing
# Parses chemical equations and verifies atom counts on both sides
#
# Usage:
#   validator = ChemicalEquationValidator.new(user_equation, correct_equation)
#   validator.valid? # => true/false
#   validator.errors # => array of error messages
#
class ChemicalEquationValidator
  attr_reader :user_equation, :correct_equation, :errors

  def initialize(user_equation, correct_equation)
    @user_equation = normalize_equation(user_equation.to_s)
    @correct_equation = normalize_equation(correct_equation.to_s)
    @errors = []
  end

  def valid?
    # Check if equations are structurally similar
    return false unless equations_match_structurally?

    # Parse both sides of user equation
    user_left, user_right = parse_equation(@user_equation)
    return false if user_left.nil? || user_right.nil?

    # Parse both sides of correct equation
    correct_left, correct_right = parse_equation(@correct_equation)
    return false if correct_left.nil? || correct_right.nil?

    # Check if atom counts match on both sides for user equation (balanced)
    user_balanced = atom_counts_match?(user_left, user_right)

    # Check if user equation matches correct equation
    equations_equivalent = equations_equivalent?(user_left, user_right, correct_left, correct_right)

    user_balanced && equations_equivalent
  end

  private

  def normalize_equation(equation)
    # Remove extra whitespace, normalize arrows
    equation.strip
      .gsub(/\s*-+>\s*/, ' -> ')
      .gsub(/\s*=+>\s*/, ' -> ')
      .gsub(/\s+/, ' ')
  end

  def equations_match_structurally?
    # Check if both equations have the same reactants and products (ignoring coefficients)
    user_compounds = extract_compounds(@user_equation)
    correct_compounds = extract_compounds(@correct_equation)

    user_compounds.sort == correct_compounds.sort
  end

  def extract_compounds(equation)
    # Extract all chemical compounds (ignoring coefficients)
    equation.gsub('->', '+').split('+').map do |part|
      # Remove leading digits (coefficients) and whitespace
      part.strip.gsub(/^\d+\s*/, '')
    end.sort
  end

  def parse_equation(equation)
    parts = equation.split('->')
    return [nil, nil] unless parts.length == 2

    left_side = parse_side(parts[0])
    right_side = parse_side(parts[1])

    [left_side, right_side]
  end

  def parse_side(side)
    # Parse one side of equation into compounds with coefficients
    # Returns hash: { 'H2O' => { coefficient: 2, atoms: {'H' => 2, 'O' => 1} } }
    compounds = {}

    side.split('+').each do |compound_str|
      compound_str = compound_str.strip
      next if compound_str.empty?

      # Extract coefficient (default 1)
      if compound_str =~ /^(\d+)\s*(.+)/
        coefficient = $1.to_i
        formula = $2.strip
      else
        coefficient = 1
        formula = compound_str
      end

      # Parse chemical formula to get atom counts
      atoms = parse_formula(formula)
      compounds[formula] = { coefficient: coefficient, atoms: atoms }
    end

    compounds
  end

  def parse_formula(formula)
    # Parse chemical formula to extract atom counts
    # e.g., "H2SO4" => {'H' => 2, 'S' => 1, 'O' => 4}
    # e.g., "Ca(OH)2" => {'Ca' => 1, 'O' => 2, 'H' => 2}
    atoms = Hash.new(0)

    # Handle parentheses by expanding them first
    # Ca(OH)2 => CaO2H2
    while formula =~ /\(([^\)]+)\)(\d*)/
      group = $1
      multiplier = $2.empty? ? 1 : $2.to_i

      # Parse elements in the group and multiply
      group_atoms = {}
      group.scan(/([A-Z][a-z]?)(\d*)/) do |element, count|
        group_atoms[element] = (count.empty? ? 1 : count.to_i)
      end

      # Build replacement string
      replacement = group_atoms.map { |elem, cnt| "#{elem}#{cnt * multiplier}" }.join
      formula = formula.sub(/\([^\)]+\)\d*/, replacement)
    end

    # Now parse the expanded formula
    formula.scan(/([A-Z][a-z]?)(\d*)/) do |element, count|
      atoms[element] += (count.empty? ? 1 : count.to_i)
    end

    atoms
  end

  def atom_counts_match?(left_side, right_side)
    # Calculate total atom counts on each side
    left_atoms = calculate_total_atoms(left_side)
    right_atoms = calculate_total_atoms(right_side)

    # Check if all atoms balance
    all_elements = (left_atoms.keys + right_atoms.keys).uniq

    all_elements.all? do |element|
      left_count = left_atoms[element] || 0
      right_count = right_atoms[element] || 0
      left_count == right_count
    end
  end

  def calculate_total_atoms(side)
    # Calculate total atoms on one side accounting for coefficients
    total_atoms = Hash.new(0)

    side.each do |formula, data|
      coefficient = data[:coefficient]
      data[:atoms].each do |element, count|
        total_atoms[element] += coefficient * count
      end
    end

    total_atoms
  end

  def equations_equivalent?(user_left, user_right, correct_left, correct_right)
    # Check if user equation is equivalent to correct equation
    # (same compounds with same coefficients on both sides)

    sides_match?(user_left, correct_left) && sides_match?(user_right, correct_right)
  end

  def sides_match?(side1, side2)
    # Check if two sides have the same compounds with same coefficients
    return false if side1.keys.sort != side2.keys.sort

    side1.all? do |formula, data|
      side2[formula] && side2[formula][:coefficient] == data[:coefficient]
    end
  end
end

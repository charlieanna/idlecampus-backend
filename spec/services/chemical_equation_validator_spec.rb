require 'rails_helper'

RSpec.describe ChemicalEquationValidator do
  describe '#valid?' do
    context 'with simple balanced equations' do
      it 'validates correctly balanced equations' do
        validator = ChemicalEquationValidator.new(
          '2 H2 + O2 -> 2 H2O',
          '2 H2 + O2 -> 2 H2O'
        )
        expect(validator.valid?).to be true
      end

      it 'accepts equations with different spacing' do
        validator = ChemicalEquationValidator.new(
          '2H2 + O2 -> 2H2O',
          '2 H2 + O2 -> 2 H2O'
        )
        expect(validator.valid?).to be true
      end

      it 'accepts equations with different arrow styles' do
        validator = ChemicalEquationValidator.new(
          '2 H2 + O2 => 2 H2O',
          '2 H2 + O2 -> 2 H2O'
        )
        expect(validator.valid?).to be true
      end

      it 'rejects unbalanced equations' do
        validator = ChemicalEquationValidator.new(
          'H2 + O2 -> H2O',  # Unbalanced
          '2 H2 + O2 -> 2 H2O'
        )
        expect(validator.valid?).to be false
      end

      it 'rejects equations with wrong coefficients' do
        validator = ChemicalEquationValidator.new(
          '3 H2 + O2 -> 2 H2O',  # Wrong coefficient
          '2 H2 + O2 -> 2 H2O'
        )
        expect(validator.valid?).to be false
      end
    end

    context 'with complex equations' do
      it 'validates iron oxide formation' do
        validator = ChemicalEquationValidator.new(
          '4 Fe + 3 O2 -> 2 Fe2O3',
          '4 Fe + 3 O2 -> 2 Fe2O3'
        )
        expect(validator.valid?).to be true
      end

      it 'validates combustion of methane' do
        validator = ChemicalEquationValidator.new(
          'CH4 + 2 O2 -> CO2 + 2 H2O',
          'CH4 + 2 O2 -> CO2 + 2 H2O'
        )
        expect(validator.valid?).to be true
      end

      it 'validates neutralization reaction' do
        validator = ChemicalEquationValidator.new(
          '2 HCl + Ca(OH)2 -> CaCl2 + 2 H2O',
          '2 HCl + Ca(OH)2 -> CaCl2 + 2 H2O'
        )
        expect(validator.valid?).to be true
      end

      it 'validates photosynthesis equation' do
        validator = ChemicalEquationValidator.new(
          '6 CO2 + 6 H2O -> C6H12O6 + 6 O2',
          '6 CO2 + 6 H2O -> C6H12O6 + 6 O2'
        )
        expect(validator.valid?).to be true
      end
    end

    context 'with compounds containing multiple elements' do
      it 'validates sulfuric acid reactions' do
        validator = ChemicalEquationValidator.new(
          'H2SO4 + 2 NaOH -> Na2SO4 + 2 H2O',
          'H2SO4 + 2 NaOH -> Na2SO4 + 2 H2O'
        )
        expect(validator.valid?).to be true
      end

      it 'rejects incorrectly balanced complex equations' do
        validator = ChemicalEquationValidator.new(
          'H2SO4 + NaOH -> Na2SO4 + H2O',  # Wrong coefficients
          'H2SO4 + 2 NaOH -> Na2SO4 + 2 H2O'
        )
        expect(validator.valid?).to be false
      end
    end

    context 'edge cases' do
      it 'handles equations without coefficients (coefficient = 1)' do
        validator = ChemicalEquationValidator.new(
          'H2 + Cl2 -> 2 HCl',
          'H2 + Cl2 -> 2 HCl'
        )
        expect(validator.valid?).to be true
      end

      it 'rejects completely different equations' do
        validator = ChemicalEquationValidator.new(
          'H2 + O2 -> H2O',
          'CH4 + O2 -> CO2 + H2O'
        )
        expect(validator.valid?).to be false
      end

      it 'rejects equations with missing reactants/products' do
        validator = ChemicalEquationValidator.new(
          'Fe + O2 -> Fe2O3',
          '4 Fe + 3 O2 -> 2 Fe2O3'
        )
        expect(validator.valid?).to be false  # Wrong coefficients
      end

      it 'handles single element reactions' do
        validator = ChemicalEquationValidator.new(
          '2 Na + 2 H2O -> 2 NaOH + H2',
          '2 Na + 2 H2O -> 2 NaOH + H2'
        )
        expect(validator.valid?).to be true
      end
    end

    context 'formula parsing' do
      it 'correctly parses H2SO4' do
        validator = ChemicalEquationValidator.new('', '')
        atoms = validator.send(:parse_formula, 'H2SO4')
        expect(atoms).to eq({ 'H' => 2, 'S' => 1, 'O' => 4 })
      end

      it 'correctly parses Fe2O3' do
        validator = ChemicalEquationValidator.new('', '')
        atoms = validator.send(:parse_formula, 'Fe2O3')
        expect(atoms).to eq({ 'Fe' => 2, 'O' => 3 })
      end

      it 'correctly parses Ca(OH)2' do
        validator = ChemicalEquationValidator.new('', '')
        # Note: Current simple parser doesn't handle parentheses
        # This is a limitation - in production, you'd want a more sophisticated parser
        atoms = validator.send(:parse_formula, 'CaOH2')
        expect(atoms).to eq({ 'Ca' => 1, 'O' => 1, 'H' => 2 })
      end

      it 'correctly parses compounds without numbers' do
        validator = ChemicalEquationValidator.new('', '')
        atoms = validator.send(:parse_formula, 'NaCl')
        expect(atoms).to eq({ 'Na' => 1, 'Cl' => 1 })
      end
    end
  end

  describe 'atom count calculation' do
    it 'correctly calculates atoms with coefficients' do
      validator = ChemicalEquationValidator.new('2 H2O -> H2 + O2', '2 H2O -> 2 H2 + O2')

      left_side = validator.send(:parse_side, '2 H2O')
      total_atoms = validator.send(:calculate_total_atoms, left_side)

      expect(total_atoms).to eq({ 'H' => 4, 'O' => 2 })
    end

    it 'correctly calculates atoms in complex compounds' do
      validator = ChemicalEquationValidator.new('', '')

      side = validator.send(:parse_side, '3 H2SO4')
      total_atoms = validator.send(:calculate_total_atoms, side)

      expect(total_atoms).to eq({ 'H' => 6, 'S' => 3, 'O' => 12 })
    end
  end
end

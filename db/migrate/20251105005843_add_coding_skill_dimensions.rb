class AddCodingSkillDimensions < ActiveRecord::Migration[6.0]
  def up
    # Add new coding-specific skill dimensions to the allowed list
    # This migration updates the UserSkillDimension model's DIMENSIONS constant

    # First, let's add any missing skill dimensions to existing records
    coding_dimensions = [
      'coding_arrays',
      'coding_strings',
      'coding_linked_lists',
      'coding_trees',
      'coding_graphs',
      'coding_sorting',
      'coding_searching',
      'coding_dynamic_programming',
      'coding_dp',
      'coding_greedy',
      'coding_backtracking',
      'coding_bit_manipulation',
      'coding_math',
      'coding_strategies'
    ]

    # Add a migration note - actual DIMENSIONS constant should be updated in the model
    puts "=" * 80
    puts "IMPORTANT: After running this migration, update the DIMENSIONS constant"
    puts "in app/models/user_skill_dimension.rb to include:"
    puts coding_dimensions.inspect
    puts "=" * 80

    # You could also seed initial skill dimensions for existing users if needed
    # User.find_each do |user|
    #   coding_dimensions.each do |dimension|
    #     UserSkillDimension.find_or_create_by!(
    #       user: user,
    #       dimension: dimension
    #     ) do |skill|
    #       skill.ability_estimate = 0.0
    #       skill.standard_error = 2.0
    #       skill.confidence_lower = -2.0
    #       skill.confidence_upper = 2.0
    #       skill.n_observations = 0
    #     end
    #   end
    # end
  end

  def down
    # Remove coding skill dimensions if rolling back
    coding_dimensions = [
      'coding_arrays',
      'coding_strings',
      'coding_linked_lists',
      'coding_trees',
      'coding_graphs',
      'coding_sorting',
      'coding_searching',
      'coding_dynamic_programming',
      'coding_dp',
      'coding_greedy',
      'coding_backtracking',
      'coding_bit_manipulation',
      'coding_math',
      'coding_strategies'
    ]

    UserSkillDimension.where(dimension: coding_dimensions).destroy_all
  end
end
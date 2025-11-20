module Mastery
  class DecayController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @user_id = current_user.id
      
      # Fetch available learning content
      @learning_units = InteractiveLearningUnit.published
                                               .ordered
                                               .limit(20)
                                               .select(:id, :title, :slug, :command_to_learn,
                                                      :difficulty_level, :category, :estimated_minutes)
      
      # Fetch docker commands
      @docker_commands = DockerCommand.active
                                      .order(exam_frequency: :desc)
                                      .limit(20)
                                      .select(:id, :command, :category, :difficulty,
                                             :explanation, :exam_frequency)
      
      # Get user's progress on learning units
      @user_progress = LearningUnitProgress.where(user_id: @user_id)
                                          .where(interactive_learning_unit_id: @learning_units.pluck(:id))
                                          .index_by(&:interactive_learning_unit_id)
      
      # Calculate stats
      @total_units = @learning_units.count
      @completed_count = @user_progress.count { |_, p| p.completed }
      @in_progress_count = @user_progress.count { |_, p| !p.completed && p.practice_attempts > 0 }
      @not_started_count = @total_units - @completed_count - @in_progress_count
      
      # Pass data to React component
      @initial_data = {
        userId: @user_id,
        stats: {
          total: @total_units,
          completed: @completed_count,
          inProgress: @in_progress_count,
          notStarted: @not_started_count
        },
        learningUnits: @learning_units.map do |unit|
          progress = @user_progress[unit.id]
          {
            id: unit.id,
            title: unit.title,
            slug: unit.slug,
            command: unit.command_to_learn,
            difficulty: unit.difficulty_level,
            category: unit.category,
            estimatedMinutes: unit.estimated_minutes,
            completed: progress&.completed || false,
            masteryScore: progress&.mastery_score || 0
          }
        end,
        dockerCommands: @docker_commands.map do |cmd|
          {
            id: cmd.id,
            command: cmd.command,
            category: cmd.category,
            difficulty: cmd.difficulty,
            explanation: cmd.explanation,
            examFrequency: cmd.exam_frequency
          }
        end
      }
    end
  end
end
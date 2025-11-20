# frozen_string_literal: true

module Api
  module Upsc
    class AiController < BaseController
      # GET /api/upsc/ai/status
      def status
        available = OllamaService.available?
        models = available ? OllamaService.list_models : []

        render_success({
          available: available,
          url: ENV.fetch('OLLAMA_URL', 'http://localhost:11434'),
          model: ENV.fetch('OLLAMA_MODEL', 'llama3.2'),
          models_available: models,
          status: available ? 'online' : 'offline'
        })
      end

      # POST /api/upsc/ai/explain
      def explain
        topic = params[:topic]

        unless topic.present?
          return render_error('Topic is required', [], :bad_request)
        end

        difficulty = params[:difficulty] || 'medium'

        begin
          explanation = OllamaService.explain_concept(
            topic: topic,
            difficulty_level: difficulty
          )

          render_success({
            topic: topic,
            difficulty: difficulty,
            explanation: explanation
          })
        rescue OllamaService::OllamaError => e
          render_error('AI service unavailable', [e.message], :service_unavailable)
        end
      end

      # POST /api/upsc/ai/generate_questions
      def generate_questions
        topic = params[:topic]
        question_type = params[:question_type] || 'mcq'
        count = (params[:count] || 5).to_i

        unless topic.present?
          return render_error('Topic is required', [], :bad_request)
        end

        begin
          questions = OllamaService.generate_practice_questions(
            topic: topic,
            question_type: question_type,
            count: count
          )

          render_success({
            topic: topic,
            questions: questions,
            count: questions.length
          })
        rescue OllamaService::OllamaError => e
          render_error('AI service unavailable', [e.message], :service_unavailable)
        end
      end

      # POST /api/upsc/ai/study_plan_suggestions
      def study_plan_suggestions
        target_date = params[:target_date]&.to_date
        current_level = params[:current_level] || 'beginner'
        subjects = params[:subjects] || []
        hours_per_day = (params[:hours_per_day] || 6).to_i

        unless target_date
          return render_error('Target date is required', [], :bad_request)
        end

        begin
          suggestions = OllamaService.generate_study_plan_suggestions(
            target_date: target_date,
            current_level: current_level,
            subjects: subjects,
            available_hours_per_day: hours_per_day
          )

          render_success({
            target_date: target_date,
            suggestions: suggestions
          })
        rescue OllamaService::OllamaError => e
          render_error('AI service unavailable', [e.message], :service_unavailable)
        end
      end
    end
  end
end

# Progressive Learning Plugin
# Enables Docker-style interactive learning units
# Allows step-by-step command practice with validation

module CourseBuilder
  module Plugins
    class ProgressiveLearningPlugin < BasePlugin
      def self.plugin_name
        :progressive_learning
      end

      def self.description
        "Enables progressive, step-by-step interactive learning units"
      end

      def self.config_schema
        {
          enabled: { type: :boolean, default: true, required: false },
          validation_strict: { type: :boolean, default: false, required: false },
          hints_enabled: { type: :boolean, default: true, required: false }
        }
      end

      # Called after course creation
      def on_course_complete(course)
        log("Progressive learning enabled for course: #{course.title}")

        # Add course_config if not present
        course.course_config ||= {}
        course.course_config["progressive_learning"] = {
          enabled: true,
          validation_strict: get_option(:validation_strict, false),
          hints_enabled: get_option(:hints_enabled, true)
        }
        course.save!
      end

      # API endpoints for progressive learning
      def api_endpoints
        [
          {
            method: :get,
            path: "courses/:course_slug/modules/:module_slug/progressive",
            action: "get_progressive_module",
            description: "Get module with progressive reveal"
          },
          {
            method: :post,
            path: "courses/:course_slug/validate_command",
            action: "validate_progressive_command",
            description: "Validate command in progressive learning"
          }
        ]
      end

      # Frontend components
      def frontend_components
        {
          module_viewer: "ProgressiveModuleViewer",
          command_input: "ProgressiveCommandInput",
          progress_indicator: "ProgressiveLearningProgress"
        }
      end

      # Routes to add
      def routes
        [
          "get 'courses/:course_slug/modules/:module_slug/progressive', to: 'progressive_learning#show'",
          "post 'courses/:course_slug/validate_command', to: 'progressive_learning#validate'"
        ]
      end

      # Controller actions
      def controller_actions
        {
          progressive_learning: [:show, :validate, :reset_progress]
        }
      end
    end

    # Auto-register
    PluginRegistry.register(ProgressiveLearningPlugin)
  end
end

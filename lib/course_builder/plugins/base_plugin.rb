# Base Plugin Class
# All course plugins must inherit from this class
# Provides hooks for extending course functionality

module CourseBuilder
  module Plugins
    class BasePlugin
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      # Plugin metadata
      def self.plugin_name
        raise NotImplementedError, "Plugin must define plugin_name"
      end

      def self.description
        "No description provided"
      end

      def self.version
        "1.0.0"
      end

      # Lifecycle hooks - override in subclasses

      # Called when plugin is registered
      def on_register
        # Override to perform setup tasks
      end

      # Called during course creation
      def on_course_create(course)
        # Override to modify course during creation
      end

      # Called during module creation
      def on_module_create(course_module, course)
        # Override to modify modules during creation
      end

      # Called during lesson creation
      def on_lesson_create(lesson, course_module, course)
        # Override to modify lessons during creation
      end

      # Called during lab creation
      def on_lab_create(lab, course_module, course)
        # Override to modify labs during creation
      end

      # Called during quiz creation
      def on_quiz_create(quiz, course_module, course)
        # Override to modify quizzes during creation
      end

      # Called after course generation is complete
      def on_course_complete(course)
        # Override to perform post-generation tasks
      end

      # Backend extensions

      # Additional routes to register
      # Returns array of route definitions
      def routes
        []
      end

      # Additional controller actions
      # Returns hash of { controller_name => [actions] }
      def controller_actions
        {}
      end

      # Additional migrations to run
      # Returns array of migration classes
      def migrations
        []
      end

      # Frontend extensions

      # React components to inject
      # Returns hash of { hook_name => component_path }
      def frontend_components
        {}
      end

      # Additional API endpoints for frontend
      # Returns array of endpoint definitions
      def api_endpoints
        []
      end

      # Configuration schema

      # Define configuration options for this plugin
      # Returns hash of { option_name => { type:, default:, required: } }
      def self.config_schema
        {}
      end

      # Validate plugin configuration
      def validate_config!
        schema = self.class.config_schema

        schema.each do |key, spec|
          value = options[key]

          # Check required
          if spec[:required] && value.nil?
            raise ArgumentError, "Plugin #{self.class.plugin_name} requires option: #{key}"
          end

          # Check type
          if value && spec[:type]
            expected_type = spec[:type]
            actual_type = value.class.name.downcase.to_sym

            unless actual_type == expected_type
              raise ArgumentError, "Plugin #{self.class.plugin_name} option #{key} must be #{expected_type}, got #{actual_type}"
            end
          end
        end
      end

      # Utility methods

      # Check if plugin is enabled
      def enabled?
        options.fetch(:enabled, true)
      end

      # Get plugin option with default
      def get_option(key, default = nil)
        options.fetch(key, default)
      end

      # Log plugin activity
      def log(message, level: :info)
        prefix = "[Plugin: #{self.class.plugin_name}]"
        case level
        when :info
          Rails.logger.info "#{prefix} #{message}"
        when :warn
          Rails.logger.warn "#{prefix} #{message}"
        when :error
          Rails.logger.error "#{prefix} #{message}"
        when :debug
          Rails.logger.debug "#{prefix} #{message}"
        end
      end

      # Execute block only if plugin is enabled
      def when_enabled(&block)
        return unless enabled?
        yield if block_given?
      end
    end
  end
end

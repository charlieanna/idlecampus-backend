# Command Reference Plugin
# Adds command documentation sidebar
# Useful for Docker, Kubernetes, Linux courses

module CourseBuilder
  module Plugins
    class CommandReferencePlugin < BasePlugin
      def self.plugin_name
        :command_reference
      end

      def self.description
        "Adds searchable command reference documentation"
      end

      def self.config_schema
        {
          enabled: { type: :boolean, default: true, required: false },
          command_type: { type: :string, required: true }, # docker, kubectl, bash
          searchable: { type: :boolean, default: true, required: false },
          categories: { type: :array, default: [], required: false }
        }
      end

      def on_course_complete(course)
        command_type = get_option(:command_type)
        log("Command reference enabled for course: #{course.title} (type: #{command_type})")

        course.course_config ||= {}
        course.course_config["command_reference"] = {
          enabled: true,
          type: command_type,
          searchable: get_option(:searchable, true),
          categories: get_option(:categories, [])
        }
        course.save!
      end

      def api_endpoints
        [
          {
            method: :get,
            path: "courses/:course_slug/commands",
            action: "list_commands",
            description: "Get all commands for this course"
          },
          {
            method: :get,
            path: "courses/:course_slug/commands/:command_name",
            action: "get_command_details",
            description: "Get details for specific command"
          },
          {
            method: :get,
            path: "courses/:course_slug/commands/search",
            action: "search_commands",
            description: "Search commands by keyword"
          }
        ]
      end

      def frontend_components
        {
          sidebar: "CommandReferenceSidebar",
          command_card: "CommandDocCard",
          search: "CommandSearch"
        }
      end

      def routes
        [
          "get 'courses/:course_slug/commands', to: 'command_reference#index'",
          "get 'courses/:course_slug/commands/search', to: 'command_reference#search'",
          "get 'courses/:course_slug/commands/:command_name', to: 'command_reference#show'"
        ]
      end
    end

    PluginRegistry.register(CommandReferencePlugin)
  end
end

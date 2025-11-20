# Plugin Registry
# Manages registration and retrieval of course plugins
# Singleton pattern for global plugin access

module CourseBuilder
  module Plugins
    class PluginRegistry
      include Singleton

      def initialize
        @plugins = {}
        @instances = {}
      end

      # Register a plugin class
      def register(plugin_class)
        unless plugin_class < BasePlugin
          raise ArgumentError, "Plugin must inherit from BasePlugin"
        end

        plugin_name = plugin_class.plugin_name
        if @plugins.key?(plugin_name)
          Rails.logger.warn "Plugin #{plugin_name} is already registered. Overwriting."
        end

        @plugins[plugin_name] = plugin_class
        Rails.logger.info "Registered plugin: #{plugin_name} (#{plugin_class.description})"

        plugin_class
      end

      # Get a registered plugin class
      def get_plugin_class(plugin_name)
        @plugins[plugin_name.to_sym] || @plugins[plugin_name.to_s]
      end

      # Create or get plugin instance with options
      def get_instance(plugin_name, options = {})
        key = [plugin_name, options.hash].join("-")

        @instances[key] ||= begin
          plugin_class = get_plugin_class(plugin_name)
          raise ArgumentError, "Plugin not found: #{plugin_name}" unless plugin_class

          instance = plugin_class.new(options)
          instance.validate_config!
          instance.on_register
          instance
        end
      end

      # Get all registered plugin names
      def all_plugin_names
        @plugins.keys
      end

      # Check if plugin is registered
      def registered?(plugin_name)
        @plugins.key?(plugin_name.to_sym) || @plugins.key?(plugin_name.to_s)
      end

      # Clear all plugins (useful for testing)
      def clear!
        @plugins.clear
        @instances.clear
      end

      # Get all plugins for a course
      def plugins_for_course(course)
        return [] unless course.respond_to?(:course_config)

        config = course.course_config || {}
        enabled_plugins = config["plugins"] || []

        enabled_plugins.map do |plugin_name|
          plugin_options = config["plugin_options"]&.dig(plugin_name.to_s) || {}
          get_instance(plugin_name, plugin_options)
        end
      end

      # Execute hook for all course plugins
      def execute_hook(course, hook_name, *args)
        plugins = plugins_for_course(course)

        plugins.each do |plugin|
          next unless plugin.enabled?
          plugin.public_send(hook_name, *args) if plugin.respond_to?(hook_name)
        end
      end

      class << self
        # Convenience method for registration
        def register(plugin_class)
          instance.register(plugin_class)
        end

        # Convenience method to get instance
        def [](plugin_name)
          instance.get_plugin_class(plugin_name)
        end
      end
    end

    # Auto-register plugins when they're defined
    def self.included(base)
      if base < BasePlugin
        PluginRegistry.instance.register(base)
      end
    end
  end
end

# Formula Sheet Plugin
# Adds mathematical/chemical formula reference
# Useful for IIT-JEE, GRE, and academic courses

module CourseBuilder
  module Plugins
    class FormulaSheetPlugin < BasePlugin
      def self.plugin_name
        :formula_sheet
      end

      def self.description
        "Adds formula sheets and equation reference for academic courses"
      end

      def self.config_schema
        {
          enabled: { type: :boolean, default: true, required: false },
          subject: { type: :string, required: true }, # chemistry, physics, math
          latex_support: { type: :boolean, default: true, required: false },
          categories: { type: :array, default: [], required: false },
          downloadable: { type: :boolean, default: true, required: false }
        }
      end

      def on_course_complete(course)
        subject = get_option(:subject)
        log("Formula sheet enabled for course: #{course.title} (subject: #{subject})")

        course.course_config ||= {}
        course.course_config["formula_sheet"] = {
          enabled: true,
          subject: subject,
          latex_support: get_option(:latex_support, true),
          categories: get_option(:categories, []),
          downloadable: get_option(:downloadable, true)
        }
        course.save!
      end

      def api_endpoints
        [
          {
            method: :get,
            path: "courses/:course_slug/formulas",
            action: "list_formulas",
            description: "Get all formulas for this course"
          },
          {
            method: :get,
            path: "courses/:course_slug/formulas/category/:category",
            action: "get_formulas_by_category",
            description: "Get formulas by category"
          },
          {
            method: :get,
            path: "courses/:course_slug/formulas/:formula_id",
            action: "get_formula_details",
            description: "Get details for specific formula"
          },
          {
            method: :get,
            path: "courses/:course_slug/formulas/download",
            action: "download_formula_sheet",
            description: "Download formula sheet as PDF"
          }
        ]
      end

      def frontend_components
        {
          sidebar: "FormulaSheetSidebar",
          formula_card: "FormulaCard",
          latex_renderer: "LatexRenderer",
          category_filter: "FormulaCategoryFilter"
        }
      end

      def routes
        [
          "get 'courses/:course_slug/formulas', to: 'formula_sheet#index'",
          "get 'courses/:course_slug/formulas/category/:category', to: 'formula_sheet#by_category'",
          "get 'courses/:course_slug/formulas/download', to: 'formula_sheet#download'",
          "get 'courses/:course_slug/formulas/:formula_id', to: 'formula_sheet#show'"
        ]
      end
    end

    PluginRegistry.register(FormulaSheetPlugin)
  end
end

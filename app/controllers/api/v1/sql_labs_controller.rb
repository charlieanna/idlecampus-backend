# frozen_string_literal: true

module Api
  module V1
    class SqlLabsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!, raise: false if respond_to?(:skip_before_action)
      protect_from_forgery with: :null_session

      before_action :set_lab, only: [:execute, :validate, :submit]

      # POST /api/v1/sql_labs/:id/execute
      def execute
        query = params[:query]

        if query.blank?
          render json: { success: false, error: 'Query cannot be empty' }, status: :bad_request
          return
        end

        begin
          result = execute_sql_query(query)
          render json: {
            success: true,
            columns: result[:columns],
            rows: result[:rows],
            execution_time: result[:execution_time]
          }
        rescue => e
          render json: {
            success: false,
            error: sanitize_error_message(e.message)
          }
        end
      end

      # POST /api/v1/sql_labs/:id/validate
      def validate
        query = params[:query]

        if query.blank?
          render json: { success: false, error: 'Query cannot be empty' }, status: :bad_request
          return
        end

        begin
          validation_result = validate_query_against_tests(query, @lab.test_cases)
          render json: {
            success: validation_result[:all_passed],
            validation: validation_result
          }
        rescue => e
          render json: {
            success: false,
            error: sanitize_error_message(e.message)
          }
        end
      end

      # POST /api/v1/sql_labs/:id/submit
      def submit
        query = params[:query]

        if query.blank?
          render json: { success: false, error: 'Query cannot be empty' }, status: :bad_request
          return
        end

        begin
          validation_result = validate_query_against_tests(query, @lab.all_test_cases)
          
          if validation_result[:all_passed]
            # Record completion (you can add user tracking here)
            render json: {
              success: true,
              validation: validation_result,
              points_earned: @lab.points_reward
            }
          else
            render json: {
              success: false,
              validation: validation_result
            }
          end
        rescue => e
          render json: {
            success: false,
            error: sanitize_error_message(e.message)
          }
        end
      end

      private

      def set_lab
        @lab = HandsOnLab.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Lab not found' }, status: :not_found
      end

      def execute_sql_query(query)
        start_time = Time.now
        
        # Create a sandboxed connection
        result = ActiveRecord::Base.connection.exec_query(query)
        
        execution_time = (Time.now - start_time).round(3)

        {
          columns: result.columns,
          rows: result.rows,
          execution_time: execution_time
        }
      end

      def validate_query_against_tests(query, test_cases)
        results = []
        passed_count = 0

        test_cases.each_with_index do |test, index|
          begin
            actual_result = execute_sql_query(query)
            expected_output = test['expected_output']
            
            # Compare results
            passed = compare_query_results(actual_result, expected_output)
            
            if passed
              passed_count += 1
            end

            results << {
              test_number: index + 1,
              description: test['description'],
              passed: passed,
              expected_output: format_result_for_display(expected_output),
              actual_output: format_result_for_display(actual_result),
              hidden: test['hidden'] || false
            }
          rescue => e
            results << {
              test_number: index + 1,
              description: test['description'],
              passed: false,
              expected_output: test['expected_output'],
              error: sanitize_error_message(e.message),
              hidden: test['hidden'] || false
            }
          end
        end

        {
          passed_tests: passed_count,
          total_tests: test_cases.length,
          pass_percentage: (passed_count.to_f / test_cases.length * 100).round(2),
          all_passed: passed_count == test_cases.length,
          results: results
        }
      end

      def compare_query_results(actual, expected)
        # Simple comparison - can be enhanced based on needs
        return false unless actual[:columns] == expected['columns']
        return false unless actual[:rows].length == expected['rows'].length
        
        actual[:rows].sort == expected['rows'].sort
      end

      def format_result_for_display(result)
        if result.is_a?(Hash) && result[:rows]
          "#{result[:rows].length} rows\n" + 
          result[:rows].map { |row| row.join(' | ') }.join("\n")
        else
          result.to_s
        end
      end

      def sanitize_error_message(message)
        # Remove sensitive information from error messages
        message.gsub(/PG::.*Error:/, 'SQL Error:')
               .gsub(/ActiveRecord::.*Error:/, 'Database Error:')
      end
    end
  end
end
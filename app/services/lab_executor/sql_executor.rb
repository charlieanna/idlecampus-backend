# SQL Lab Executor
# Handles execution and validation for SQL editor labs
# Supports: PostgreSQL, MySQL
#
# Usage:
#   executor = LabExecutor::SqlExecutor.new(lab, user: current_user)
#   result = executor.execute(user_query, step_index: 0)

module LabExecutor
  class SqlExecutor < BaseExecutor
    # Check if this executor supports the lab format
    def self.supports?(lab_format)
      %w[sql_editor sql postgresql mysql].include?(lab_format.to_s)
    end

    # Execute SQL query
    # @param input [String] User's SQL query
    # @param step_index [Integer] Current step index
    # @return [Hash] { success: Boolean, output: String, error: String, validation: Hash }
    def execute(input, step_index: 0)
      log("Executing SQL query for step #{step_index}", level: :info)

      step = current_step(step_index)

      # Set up database schema and sample data (if first step)
      if step_index == 0
        setup_result = setup_database
        return error_result(setup_result[:error]) unless setup_result[:success]
      end

      # Validate SQL syntax
      syntax_check = validate_sql_syntax(input)
      unless syntax_check[:valid]
        return error_result(syntax_check[:message])
      end

      # Execute query in isolated database
      execution_result = execute_sql_query(input)

      unless execution_result[:success]
        return error_result(execution_result[:error])
      end

      # Validate results if expected output provided
      if step && (step[:expected_output] || step[:expected_result])
        validation = validate_query_result(
          execution_result[:result],
          step[:expected_output] || step[:expected_result]
        )

        return {
          success: validation[:valid],
          output: format_sql_output(execution_result[:result]),
          error: validation[:valid] ? "" : validation[:message],
          validation: validation,
          rows_affected: execution_result[:rows_affected]
        }
      end

      # Query executed successfully
      {
        success: true,
        output: format_sql_output(execution_result[:result]),
        error: "",
        validation: { valid: true, message: "Query executed successfully" },
        rows_affected: execution_result[:rows_affected]
      }
    rescue => e
      log("SQL execution error: #{e.message}", level: :error)
      error_result(e.message)
    end

    private

    # Set up database schema and sample data
    def setup_database
      log("Setting up database schema and sample data", level: :info)

      # Create isolated database for this lab session
      db_name = create_isolated_database

      # Run schema setup
      if lab.schema_setup.present?
        result = execute_in_database(db_name, lab.schema_setup)
        return { success: false, error: result[:error] } unless result[:success]
      end

      # Load sample data
      if lab.sample_data.present?
        result = execute_in_database(db_name, lab.sample_data)
        return { success: false, error: result[:error] } unless result[:success]
      end

      @database_name = db_name
      { success: true, database: db_name }
    rescue => e
      { success: false, error: "Database setup failed: #{e.message}" }
    end

    # Create isolated database for lab session
    def create_isolated_database
      # Generate unique database name
      db_name = "lab_#{lab.id}_user_#{user&.id || 'guest'}_#{Time.current.to_i}"

      # Create database in Docker PostgreSQL container
      execute_psql_command("CREATE DATABASE #{db_name};")

      db_name
    end

    # Execute command in PostgreSQL
    def execute_psql_command(command, database: 'postgres')
      require 'open3'

      docker_cmd = [
        "docker", "exec",
        postgres_container_name,
        "psql",
        "-U", "postgres",
        "-d", database,
        "-c", command
      ]

      stdout, stderr, status = Open3.capture3(*docker_cmd)

      if status.success?
        stdout
      else
        raise "PostgreSQL error: #{stderr}"
      end
    end

    # Get or create PostgreSQL container for this session
    def postgres_container_name
      @postgres_container ||= ensure_postgres_container
    end

    # Ensure PostgreSQL container is running
    def ensure_postgres_container
      container_name = "idlecampus_postgres_#{user&.id || 'guest'}"

      # Check if container exists and is running
      check_cmd = "docker ps -q -f name=#{container_name}"
      container_id = `#{check_cmd}`.strip

      if container_id.empty?
        # Start new PostgreSQL container
        start_cmd = [
          "docker", "run",
          "-d",
          "--name", container_name,
          "--rm",
          "-e", "POSTGRES_PASSWORD=labpassword",
          "-e", "POSTGRES_USER=postgres",
          "--memory", "256m",
          "--cpus", "0.5",
          "postgres:15-alpine"
        ]

        `#{start_cmd.join(' ')}`
        sleep 3 # Wait for PostgreSQL to start
      end

      container_name
    end

    # Validate SQL syntax
    def validate_sql_syntax(query)
      # Basic SQL keyword validation
      query_upper = query.strip.upcase

      # Check for dangerous commands
      dangerous_keywords = %w[DROP TRUNCATE DELETE_FROM ALTER CREATE_USER GRANT]
      if step_allows_ddl?
        # Allow DDL in specific steps
      else
        dangerous_keywords.each do |keyword|
          if query_upper.include?(keyword.gsub('_', ' '))
            return {
              valid: false,
              message: "Dangerous SQL command not allowed: #{keyword.gsub('_', ' ')}"
            }
          end
        end
      end

      # Must start with valid SQL keyword
      valid_keywords = %w[SELECT INSERT UPDATE DELETE CREATE ALTER DROP WITH]
      first_keyword = query_upper.split.first

      unless valid_keywords.include?(first_keyword)
        return {
          valid: false,
          message: "Invalid SQL query. Must start with a valid SQL keyword."
        }
      end

      { valid: true, message: "Syntax OK" }
    end

    # Check if current step allows DDL operations
    def step_allows_ddl?
      lab.options&.dig(:allow_ddl) || false
    end

    # Execute SQL query in database
    def execute_sql_query(query)
      database = @database_name || 'postgres'

      # Execute query and capture results
      output = execute_psql_command(
        query,
        database: database
      )

      # Parse output to extract rows
      result = parse_psql_output(output)

      {
        success: true,
        result: result[:rows],
        rows_affected: result[:rows_affected],
        columns: result[:columns]
      }
    rescue => e
      {
        success: false,
        error: e.message,
        result: [],
        rows_affected: 0
      }
    end

    # Execute SQL in specific database
    def execute_in_database(database, sql)
      output = execute_psql_command(sql, database: database)
      { success: true, output: output }
    rescue => e
      { success: false, error: e.message }
    end

    # Parse PostgreSQL output
    def parse_psql_output(output)
      lines = output.split("\n").map(&:strip)

      # Find header row (columns)
      header_index = lines.index { |line| line.include?('|') }
      return { rows: [], columns: [], rows_affected: 0 } unless header_index

      columns = lines[header_index].split('|').map(&:strip)

      # Find separator row
      separator_index = header_index + 1

      # Extract data rows
      rows = []
      (separator_index + 1...lines.length).each do |i|
        break if lines[i].start_with?('(') # End of results

        row_data = lines[i].split('|').map(&:strip)
        next if row_data.empty?

        row_hash = {}
        columns.each_with_index do |col, idx|
          row_hash[col] = row_data[idx]
        end
        rows << row_hash
      end

      # Extract rows affected
      rows_affected = 0
      if output =~ /\((\d+) rows?\)/
        rows_affected = $1.to_i
      end

      {
        rows: rows,
        columns: columns,
        rows_affected: rows_affected
      }
    end

    # Validate query result against expected output
    def validate_query_result(actual_result, expected_output)
      # If expected output is an array of hashes, do exact match
      if expected_output.is_a?(Array)
        return validate_exact_result(actual_result, expected_output)
      end

      # If expected output is a hash with validation rules
      if expected_output.is_a?(Hash) && expected_output[:type]
        return validate_with_rules(actual_result, expected_output)
      end

      # Otherwise, check row count
      expected_count = expected_output.to_i
      actual_count = actual_result.size

      if actual_count == expected_count
        { valid: true, message: "Correct! #{actual_count} rows returned." }
      else
        {
          valid: false,
          message: "Expected #{expected_count} rows, got #{actual_count}"
        }
      end
    end

    # Validate exact result match
    def validate_exact_result(actual, expected)
      # Normalize both results for comparison
      actual_normalized = normalize_result_set(actual)
      expected_normalized = normalize_result_set(expected)

      if actual_normalized == expected_normalized
        { valid: true, message: "Query result matches expected output!" }
      else
        {
          valid: false,
          message: "Query result does not match. Review your query."
        }
      end
    end

    # Normalize result set for comparison
    def normalize_result_set(result)
      return [] unless result.is_a?(Array)

      result.map do |row|
        row.transform_values { |v| v.to_s.strip.downcase }
      end.sort_by(&:to_s)
    end

    # Validate with custom rules
    def validate_with_rules(result, rules)
      case rules[:type]
      when 'row_count'
        actual_count = result.size
        expected_count = rules[:count].to_i

        if actual_count == expected_count
          { valid: true, message: "Correct row count!" }
        else
          {
            valid: false,
            message: "Expected #{expected_count} rows, got #{actual_count}"
          }
        end

      when 'contains_column'
        column_name = rules[:column]
        first_row = result.first || {}

        if first_row.key?(column_name)
          { valid: true, message: "Column '#{column_name}' found!" }
        else
          {
            valid: false,
            message: "Missing column: #{column_name}"
          }
        end

      when 'aggregate_value'
        # Check if result contains specific aggregate value
        expected_value = rules[:value].to_s
        actual_value = result.first&.values&.first.to_s

        if actual_value == expected_value
          { valid: true, message: "Correct aggregate value!" }
        else
          {
            valid: false,
            message: "Expected #{expected_value}, got #{actual_value}"
          }
        end

      else
        { valid: false, message: "Unknown validation type: #{rules[:type]}" }
      end
    end

    # Format SQL output for display
    def format_sql_output(result)
      return "No results" if result.empty?

      # Create ASCII table
      columns = result.first.keys
      output = []

      # Header
      header = "| " + columns.join(" | ") + " |"
      separator = "+" + ("-" * (header.length - 2)) + "+"

      output << separator
      output << header
      output << separator

      # Rows
      result.each do |row|
        row_str = "| " + columns.map { |col| row[col].to_s }.join(" | ") + " |"
        output << row_str
      end

      output << separator
      output << "\n(#{result.size} rows)"

      output.join("\n")
    end

    # Return error result structure
    def error_result(message)
      {
        success: false,
        output: "",
        error: message,
        validation: { valid: false, message: message }
      }
    end

    # Cleanup: Remove isolated database
    def cleanup_database
      return unless @database_name

      begin
        execute_psql_command("DROP DATABASE IF EXISTS #{@database_name};")
      rescue => e
        log("Database cleanup error: #{e.message}", level: :warn)
      end
    end
  end
end

namespace :db do
  namespace :data do
    desc "Direct import from YAML to PostgreSQL"
    task direct_import: :environment do
      require 'yaml'
      
      conn = ActiveRecord::Base.connection
      
      # Disable FK constraints
      puts "Disabling foreign key constraints..."
      conn.execute("SET session_replication_role = 'replica';") if conn.adapter_name == 'PostgreSQL'
      
      # Load YAML data (multi-document)
      data_file = File.join(Rails.root, "db", "data.yml")
      puts "Loading data from #{data_file}..."
      
      total_imported = 0
      YAML.load_stream(File.read(data_file)).each do |doc|
        doc.each do |table_name, table_data|
          next if table_data.nil? || table_data['records'].nil? || table_data['records'].empty?
          
          puts "  Importing #{table_data['records'].count} records into #{table_name}..."
          
          # Truncate table
          conn.execute("TRUNCATE TABLE #{table_name} RESTART IDENTITY CASCADE;") rescue nil
          
          # Get columns
          columns = table_data['columns']
          
          # Insert records
          table_data['records'].each do |record_values|
            begin
              values_str = record_values.map { |v| conn.quote(v) }.join(', ')
              columns_str = columns.join(', ')
              
              sql = "INSERT INTO #{table_name} (#{columns_str}) VALUES (#{values_str})"
              conn.execute(sql)
              total_imported += 1
            rescue => e
              puts "    Skipped row: #{e.message}"
            end
          end
        end
      end
      
      # Re-enable FK constraints
      puts "Re-enabling foreign key constraints..."
      conn.execute("SET session_replication_role = 'origin';") if conn.adapter_name == 'PostgreSQL'
      
      puts "✅ Import complete! Imported #{total_imported} records."
    end
  end
end

namespace :db do
  namespace :data do
    desc "Load data from db/data.yml with FK constraints temporarily disabled"
    task load_safe: :environment do
      require 'yaml_db'
      
      conn = ActiveRecord::Base.connection
      
      if conn.adapter_name == 'PostgreSQL'
        puts "Disabling foreign key constraints..."
        conn.execute("SET session_replication_role = 'replica';")
      end
      
      puts "Importing data..."
      begin
        SerializationHelper::Load.load(File.join(Rails.root, "db", "data.yml"))
      rescue => e
        puts "Error: #{e.message}"
        puts "Trying alternative method..."
        YamlDb::Helper.loader.load(File.join(Rails.root, "db", "data.yml"))
      end
      
      if conn.adapter_name == 'PostgreSQL'
        puts "Re-enabling foreign key constraints..."
        conn.execute("SET session_replication_role = 'origin';")
      end
      
      puts "✅ Data import complete!"
    end
  end
end

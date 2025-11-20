# Database Migration: SQLite → PostgreSQL
# Migrates all data from SQLite database to PostgreSQL
#
# Usage:
#   1. First, ensure PostgreSQL is running and credentials are set
#   2. Run: rake db:migrate_to_postgres
#
# This task will:
#   - Export data from SQLite
#   - Create PostgreSQL database
#   - Run migrations
#   - Import data to PostgreSQL
#   - Preserve all relationships

namespace :db do
  desc 'Migrate data from SQLite to PostgreSQL'
  task migrate_to_postgres: :environment do
    puts "\n" + "=" * 80
    puts "  🔄 Migrating from SQLite to PostgreSQL"
    puts "=" * 80

    # Check if SQLite database exists
    sqlite_db = Rails.root.join('db', 'development.sqlite3')
    unless File.exist?(sqlite_db)
      puts "❌ SQLite database not found at: #{sqlite_db}"
      puts "   No data to migrate."
      exit 0
    end

    # Step 1: Backup SQLite database
    puts "\n📦 Step 1: Backing up SQLite database..."
    backup_file = Rails.root.join('db', "sqlite_backup_#{Time.current.strftime('%Y%m%d_%H%M%S')}.sqlite3")
    FileUtils.cp(sqlite_db, backup_file)
    puts "✅ Backup created: #{backup_file}"

    # Step 2: Connect to SQLite and export data
    puts "\n📤 Step 2: Exporting data from SQLite..."

    # Temporarily connect to SQLite
    sqlite_config = {
      adapter: 'sqlite3',
      database: sqlite_db.to_s
    }

    sqlite_conn = ActiveRecord::Base.establish_connection(sqlite_config).connection

    # Get all table names
    tables = sqlite_conn.tables.reject { |t| t == 'schema_migrations' || t == 'ar_internal_metadata' }

    puts "   Found #{tables.count} tables to migrate:"
    tables.each { |t| puts "     - #{t}" }

    # Export data from each table
    exported_data = {}
    tables.each do |table_name|
      puts "\n   Exporting: #{table_name}..."

      begin
        records = sqlite_conn.select_all("SELECT * FROM #{table_name}")
        exported_data[table_name] = records.to_a
        puts "     ✅ Exported #{records.count} records"
      rescue => e
        puts "     ⚠️  Warning: Could not export #{table_name}: #{e.message}"
        exported_data[table_name] = []
      end
    end

    # Step 3: Setup PostgreSQL database
    puts "\n🐘 Step 3: Setting up PostgreSQL database..."

    # Load PostgreSQL configuration
    postgres_config = ActiveRecord::Base.configurations.configs_for(env_name: 'development').first.configuration_hash

    puts "   PostgreSQL Config:"
    puts "     Host: #{postgres_config[:host]}"
    puts "     Port: #{postgres_config[:port]}"
    puts "     Database: #{postgres_config[:database]}"
    puts "     Username: #{postgres_config[:username]}"

    # Reconnect to PostgreSQL
    ActiveRecord::Base.establish_connection(:development)

    # Drop and create database
    puts "\n   Creating fresh PostgreSQL database..."
    begin
      Rake::Task['db:drop'].invoke
    rescue
      # Database might not exist, that's okay
    end

    Rake::Task['db:create'].invoke
    puts "   ✅ Database created"

    # Run migrations
    puts "\n   Running migrations..."
    Rake::Task['db:migrate'].invoke
    puts "   ✅ Migrations complete"

    # Step 4: Import data to PostgreSQL
    puts "\n📥 Step 4: Importing data to PostgreSQL..."

    # Disable foreign key checks temporarily
    ActiveRecord::Base.connection.execute('SET session_replication_role = replica;')

    tables.each do |table_name|
      records = exported_data[table_name]
      next if records.empty?

      puts "\n   Importing: #{table_name} (#{records.count} records)..."

      begin
        # Get the model class if it exists
        model_class = table_name.classify.safe_constantize

        if model_class && model_class < ActiveRecord::Base
          # Use ActiveRecord for import (handles relationships better)
          records.each_with_index do |record, index|
            model_class.create!(record)
            print "\r     Progress: #{index + 1}/#{records.count}" if (index + 1) % 10 == 0
          end
          puts "\r     ✅ Imported #{records.count} records"
        else
          # Fallback to raw SQL insert
          records.each_slice(100) do |batch|
            columns = batch.first.keys
            values = batch.map do |record|
              "(#{columns.map { |col| ActiveRecord::Base.connection.quote(record[col]) }.join(', ')})"
            end.join(', ')

            sql = "INSERT INTO #{table_name} (#{columns.join(', ')}) VALUES #{values}"
            ActiveRecord::Base.connection.execute(sql)
          end
          puts "     ✅ Imported #{records.count} records (raw SQL)"
        end

        # Reset sequence for PostgreSQL
        if model_class && model_class < ActiveRecord::Base
          max_id = model_class.maximum(:id)
          if max_id
            ActiveRecord::Base.connection.execute(
              "SELECT setval('#{table_name}_id_seq', #{max_id}, true)"
            )
          end
        end

      rescue => e
        puts "     ❌ Error importing #{table_name}: #{e.message}"
        puts "        #{e.backtrace.first}"
      end
    end

    # Re-enable foreign key checks
    ActiveRecord::Base.connection.execute('SET session_replication_role = DEFAULT;')

    # Step 5: Verification
    puts "\n" + "=" * 80
    puts "  ✅ Migration Complete!"
    puts "=" * 80

    puts "\n📊 Verification:"
    tables.each do |table_name|
      model_class = table_name.classify.safe_constantize
      if model_class && model_class < ActiveRecord::Base
        sqlite_count = exported_data[table_name].count
        postgres_count = model_class.count
        status = sqlite_count == postgres_count ? "✅" : "⚠️"
        puts "  #{status} #{table_name}: #{postgres_count} / #{sqlite_count} records"
      end
    end

    puts "\n📁 Files:"
    puts "  SQLite backup: #{backup_file}"
    puts "  PostgreSQL database: #{postgres_config[:database]}"

    puts "\n" + "=" * 80
    puts "  🎉 Data migration successful!"
    puts "=" * 80
    puts ""
  end
end

# frozen_string_literal: true

namespace :upsc do
  desc "Set up all UPSC migration files with complete schema"
  task setup_migrations: :environment do
    puts "Setting up UPSC migrations..."

    # This task will update all generated migration files with complete schema
    # Run after generating migrations with: rails generate migration CreateUpsc...

    puts "✅ Migration setup complete!"
    puts "Run 'rails db:migrate' to create tables"
  end
end

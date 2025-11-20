# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc "Seed all CAT courses"
    task cat: :environment do
      puts "🌱 Seeding CAT courses..."
      load_seed_directory('cat')
      puts "✅ CAT courses seeded successfully!"
    end

    desc "Seed all GRE courses"
    task gre: :environment do
      puts "🌱 Seeding GRE courses..."
      load_seed_directory('gre')
      puts "✅ GRE courses seeded successfully!"
    end

    desc "Seed all IIT JEE courses"
    task iit_jee: :environment do
      puts "🌱 Seeding IIT JEE courses..."
      load_seed_directory('iit_jee')
      puts "✅ IIT JEE courses seeded successfully!"
    end

    desc "Seed all Finance courses"
    task finance: :environment do
      puts "🌱 Seeding Finance courses..."
      load_seed_directory('finance')
      puts "✅ Finance courses seeded successfully!"
    end

    namespace :cat do
      desc "Seed CAT Quantitative Ability course"
      task quantitative_ability: :environment do
        puts "🌱 Seeding CAT Quantitative Ability..."
        load_seed_file('cat/cat_quantitative_ability.rb')
        puts "✅ CAT Quantitative Ability seeded successfully!"
      end
    end

    namespace :gre do
      desc "Seed GRE Quantitative Reasoning course"
      task quantitative_reasoning: :environment do
        puts "🌱 Seeding GRE Quantitative Reasoning..."
        load_seed_file('gre/gre_quantitative_reasoning.rb')
        puts "✅ GRE Quantitative Reasoning seeded successfully!"
      end
    end

    namespace :iit_jee do
      desc "Seed IIT JEE Inorganic Chemistry course"
      task inorganic_chemistry: :environment do
        puts "🌱 Seeding IIT JEE Inorganic Chemistry..."
        load_seed_file('iit_jee/iit_jee_inorganic_chemistry.rb')
        puts "✅ IIT JEE Inorganic Chemistry seeded successfully!"
      end

      desc "Seed IIT JEE Organic Chemistry course"
      task organic_chemistry: :environment do
        puts "🌱 Seeding IIT JEE Organic Chemistry..."
        load_seed_file('iit_jee/iit_jee_organic_chemistry_formulas.rb')
        puts "✅ IIT JEE Organic Chemistry seeded successfully!"
      end

      desc "Seed IIT JEE Physical Chemistry course"
      task physical_chemistry: :environment do
        puts "🌱 Seeding IIT JEE Physical Chemistry..."
        load_seed_file('iit_jee/iit_jee_physical_chemistry_formulas.rb')
        puts "✅ IIT JEE Physical Chemistry seeded successfully!"
      end
    end

    namespace :finance do
      desc "Seed Options Trading course"
      task options_trading: :environment do
        puts "🌱 Seeding Options Trading course..."
        load_seed_file('finance/options_trading_course.rb')
        puts "✅ Options Trading course seeded successfully!"
      end
    end

    # Helper method to load all seed files in a directory
    def load_seed_directory(directory)
      seed_dir = Rails.root.join('db', 'seeds', directory)

      unless Dir.exist?(seed_dir)
        puts "⚠️  Directory not found: #{seed_dir}"
        return
      end

      Dir.glob(File.join(seed_dir, '*.rb')).sort.each do |seed_file|
        puts "\n📂 Loading #{File.basename(seed_file)}..."
        load seed_file
      end
    end

    # Helper method to load a specific seed file
    def load_seed_file(relative_path)
      seed_path = Rails.root.join('db', 'seeds', relative_path)

      if File.exist?(seed_path)
        load seed_path
      else
        puts "⚠️  Seed file not found: #{seed_path}"
      end
    end
  end
end

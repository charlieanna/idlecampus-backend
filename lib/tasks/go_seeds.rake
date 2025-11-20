namespace :go do
  desc 'Seed Go course (enhanced) and concurrency units'
  task seed: :environment do
    puts "Seeding Go course (enhanced)..."
    load Rails.root.join('db/seeds/golang_course_enhanced.rb') if File.exist?(Rails.root.join('db/seeds/golang_course_enhanced.rb'))
    puts "Seeding Go code labs..."
    load Rails.root.join('db/seeds/golang_code_labs.rb') if File.exist?(Rails.root.join('db/seeds/golang_code_labs.rb'))
    puts "Seeding Go concurrency units..."
    load Rails.root.join('db/seeds/golang_concurrency_units.rb') if File.exist?(Rails.root.join('db/seeds/golang_concurrency_units.rb'))
    puts "Linking and adding additional Go labs..."
    load Rails.root.join('db/seeds/golang_additional_labs.rb') if File.exist?(Rails.root.join('db/seeds/golang_additional_labs.rb'))
    puts "Seeding Go pointers lesson..."
    load Rails.root.join('db/seeds/golang_pointers.rb') if File.exist?(Rails.root.join('db/seeds/golang_pointers.rb'))
    puts "Seeding Go web services module..."
    load Rails.root.join('db/seeds/golang_web_services.rb') if File.exist?(Rails.root.join('db/seeds/golang_web_services.rb'))
    puts "Seeding Go web services advanced content..."
    load Rails.root.join('db/seeds/golang_web_services_advanced.rb') if File.exist?(Rails.root.join('db/seeds/golang_web_services_advanced.rb'))
    puts "Seeding Go web services labs..."
    load Rails.root.join('db/seeds/golang_web_services_labs.rb') if File.exist?(Rails.root.join('db/seeds/golang_web_services_labs.rb'))
    puts "✅ Seeded Go course + concurrency units + web services (Week 7)"
  end
end

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ----------------------------------------
# Ruby Version
# ----------------------------------------
ruby '3.1.4'

# ----------------------------------------
# Rails & Core Dependencies
# ----------------------------------------
gem 'rails', '~> 6.0.3'
gem 'puma',  '~> 4.1'
gem 'shakapacker', '~> 7.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder',   '~> 2.7'
gem 'bootsnap',   '>= 1.4.2', require: false
# gem 'bcrypt',   '~> 3.1.7'   # Uncomment if you need secure passwords

# ----------------------------------------
# Database (PostgreSQL)
# ----------------------------------------
gem 'pg', '~> 1.5'
gem 'sqlite3', '~> 1.4'  # Temporary for data migration

# ----------------------------------------
# Frontend
# ----------------------------------------
# gem 'bootstrap', '~> 5.3' # Temporarily disabled due to sassc dependency
# gem 'sassc-rails', '~> 2.1.2' # Not needed - no SCSS files in project
gem 'ace-rails-ap',    '~> 4.2'
gem 'jquery-rails'
gem 'rails-ujs'
# gem 'dartsass-rails' # Temporarily disabled due to sassc conflicts

# ----------------------------------------
# Additional Libraries
# ----------------------------------------
gem 'docker-api'
gem 'devise'
gem 'httparty'
gem 'openai'          # or 'ruby-openai' (below)
gem 'ruby-openai'
gem 'whenever', require: false
# gem 'twitter-bootstrap-rails' # Temporarily disabled due to sassc dependency
# gem 'sass-embedded-rails', '~> 1.3' # Version not available, using dartsass-rails instead
gem 'redis'
gem 'rack-cors'
gem 'concurrent-ruby'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'omniauth'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-google-oauth2'
gem 'nokogiri'
gem 'kaminari'
# gem 'rails', '~> 6.0.3' # (already listed above — if needed, remove duplicate)
gem 'react-rails'

# ----------------------------------------
# Action Cable in Production (Comment/Uncomment if needed)
# ----------------------------------------
# gem 'redis' (already included above)

# ----------------------------------------
# Development & Test
# ----------------------------------------
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem 'dotenv', '~> 2.0'
  gem 'yaml_db'  # For database migration between SQLite and PostgreSQL
end

# Development-Only Tools
group :development do
  gem 'letter_opener'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Test-Only Tools
group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webmock'
  gem 'minitest'
end

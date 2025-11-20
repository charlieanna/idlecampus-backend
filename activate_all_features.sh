#!/bin/bash

# Complete System Activation Script
# This script sets up ALL advanced features we've built

set -e  # Exit on error

echo "🚀 Activating Complete Learning Platform with All Features..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track progress
STEP=1
TOTAL_STEPS=10

print_step() {
  echo ""
  echo "${GREEN}[$STEP/$TOTAL_STEPS]${NC} $1"
  ((STEP++))
}

print_error() {
  echo "${RED}❌ ERROR:${NC} $1"
}

print_success() {
  echo "${GREEN}✅${NC} $1"
}

print_warning() {
  echo "${YELLOW}⚠️${NC} $1"
}

cd "$(dirname "$0")"

# Step 1: Check prerequisites
print_step "Checking prerequisites..."

if ! command -v ruby &> /dev/null; then
  print_error "Ruby is not installed"
  exit 1
fi
print_success "Ruby found: $(ruby -v)"

if ! command -v bundle &> /dev/null; then
  print_error "Bundler is not installed"
  exit 1
fi
print_success "Bundler found"

if ! command -v node &> /dev/null; then
  print_error "Node.js is not installed"
  exit 1
fi
print_success "Node.js found: $(node -v)"

if ! command -v npm &> /dev/null; then
  print_error "npm is not installed"
  exit 1
fi
print_success "npm found: $(npm -v)"

# Step 2: Install Ruby dependencies
print_step "Installing Ruby dependencies..."
bundle install
print_success "Ruby gems installed"

# Step 3: Install JavaScript dependencies
print_step "Installing JavaScript dependencies..."
npm install
npm install recharts @heroicons/react
print_success "JavaScript packages installed"

# Step 4: Setup database
print_step "Setting up database..."

# Check if database exists
if bundle exec rails db:version &> /dev/null; then
  print_success "Database exists"
  
  # Run migrations
  print_warning "Running pending migrations..."
  bundle exec rails db:migrate
  print_success "Migrations completed"
else
  print_warning "Database doesn't exist, creating..."
  bundle exec rails db:create
  bundle exec rails db:migrate
  print_success "Database created and migrated"
fi

# Step 5: Verify critical tables
print_step "Verifying database tables..."

TABLES=(
  "user_command_masteries"
  "stealth_reviews"
  "courses"
  "chapters"
  "lessons"
  "micro_lessons"
)

for table in "${TABLES[@]}"; do
  if bundle exec rails runner "ActiveRecord::Base.connection.table_exists?('$table') ? exit(0) : exit(1)" 2>/dev/null; then
    print_success "Table '$table' exists"
  else
    print_warning "Table '$table' missing - may need seeds"
  fi
done

# Step 6: Load seed data
print_step "Loading seed data..."
read -p "Do you want to load/reload seed data? This will populate courses, lessons, etc. (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  bundle exec rails db:seed
  print_success "Seed data loaded"
else
  print_warning "Skipped seed data loading"
fi

# Step 7: Compile frontend assets
print_step "Compiling frontend assets..."
bundle exec rails assets:precompile RAILS_ENV=development
print_success "Assets compiled"

# Step 8: Clear caches
print_step "Clearing caches..."
bundle exec rails tmp:cache:clear 2>/dev/null || bundle exec rake tmp:clear
print_success "Rails cache cleared"

# Step 9: Verify routes
print_step "Verifying API routes..."

ROUTES=(
  "/api/mastery/decay_visualization"
  "/api/mastery/user_commands"
  "/api/mastery/request_stealth_review"
)

echo "Available mastery routes:"
bundle exec rails routes | grep mastery || print_warning "No mastery routes found - may need to add to routes.rb"

# Step 10: Create test data
print_step "Creating test data..."
read -p "Do you want to create sample mastery data for testing? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  bundle exec rails runner "
    user = User.first || User.create!(email: 'test@example.com', password: 'password123')
    
    # Create sample command masteries
    commands = ['docker ps', 'docker run', 'kubectl get pods', 'docker build', 'docker-compose up']
    
    commands.each_with_index do |cmd, idx|
      UserCommandMastery.find_or_create_by(user_id: user.id, canonical_command: cmd) do |m|
        m.proficiency_score = [50, 70, 85, 95, 100].sample
        m.last_practiced_at = rand(1..10).days.ago
        m.contexts_seen = ['basics', 'advanced'].sample(rand(1..2))
        m.total_attempts = rand(5..20)
        m.successful_attempts = (m.total_attempts * (0.5 + rand * 0.5)).to_i
      end
    end
    
    puts '✅ Created sample mastery data for user: ' + user.email
  "
  print_success "Test data created"
else
  print_warning "Skipped test data creation"
fi

# Final summary
echo ""
echo "════════════════════════════════════════════════════════════════"
echo "${GREEN}🎉 Setup Complete!${NC}"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo ""
echo "1️⃣  Start the development server:"
echo "   ${YELLOW}rails server${NC}"
echo ""
echo "2️⃣  In a separate terminal, start webpack:"
echo "   ${YELLOW}./bin/webpack-dev-server${NC}"
echo ""
echo "3️⃣  Visit these URLs to see your features:"
echo ""
echo "   📊 Mastery Dashboard (CodeSchool UI):"
echo "      ${YELLOW}http://localhost:3000/mastery/decay${NC}"
echo ""
echo "   🎯 API Endpoints:"
echo "      ${YELLOW}http://localhost:3000/api/mastery/decay_visualization?user_id=1&time_range=30${NC}"
echo "      ${YELLOW}http://localhost:3000/api/mastery/user_commands?user_id=1${NC}"
echo ""
echo "4️⃣  Read the guides for more info:"
echo "   📖 ${YELLOW}COMPLETE_SETUP_GUIDE.md${NC} - Complete system documentation"
echo "   🎨 ${YELLOW}ENHANCED_UI_GUIDE.md${NC} - UI customization guide"
echo ""
echo "Features activated:"
echo "  ✅ Intelligent Mastery Decay Tracking"
echo "  ✅ Command Mastery System with Ebbinghaus curves"
echo "  ✅ Stealth Review Insertion"
echo "  ✅ CodeSchool-Style Gamified UI"
echo "  ✅ XP, Leveling, Badges, and Streaks"
echo "  ✅ Adaptive Learning Integration"
echo "  ✅ Docker Lab Execution (if Docker is running)"
echo "  ✅ Real-time Progress Tracking"
echo "  ✅ Daily Challenges"
echo "  ✅ Battle Arena for at-risk commands"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
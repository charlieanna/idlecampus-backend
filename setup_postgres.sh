#!/bin/bash

# IdleCampus PostgreSQL Setup Script
# Automates the migration from SQLite to PostgreSQL

set -e  # Exit on error

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║       IdleCampus PostgreSQL Setup & Migration                 ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker first."
    echo "   Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose not found. Please install Docker Compose first."
    exit 1
fi

echo "✅ Docker found"
echo ""

# Step 1: Start PostgreSQL with Docker
echo "📦 Step 1: Starting PostgreSQL with Docker..."
echo ""
docker-compose up -d postgres

echo ""
echo "⏳ Waiting for PostgreSQL to be ready..."
sleep 5

# Check if PostgreSQL is running
if docker ps | grep -q idlecampus_postgres; then
    echo "✅ PostgreSQL is running"
else
    echo "❌ PostgreSQL failed to start. Check logs with: docker-compose logs postgres"
    exit 1
fi

echo ""

# Step 2: Install gems
echo "📚 Step 2: Installing gems..."
echo ""
bundle install

if [ $? -ne 0 ]; then
    echo "❌ Failed to install gems"
    exit 1
fi

echo "✅ Gems installed"
echo ""

# Step 3: Create database
echo "🗄️  Step 3: Creating PostgreSQL database..."
echo ""
bundle exec rails db:create

if [ $? -ne 0 ]; then
    echo "❌ Failed to create database"
    exit 1
fi

echo "✅ Database created"
echo ""

# Step 4: Run migrations
echo "🔨 Step 4: Running database migrations..."
echo ""
bundle exec rails db:migrate

if [ $? -ne 0 ]; then
    echo "❌ Failed to run migrations"
    exit 1
fi

echo "✅ Migrations complete"
echo ""

# Step 5: Check for existing SQLite data
SQLITE_DB="db/development.sqlite3"

if [ -f "$SQLITE_DB" ]; then
    echo "📂 Existing SQLite database found!"
    echo ""
    read -p "   Do you want to migrate data from SQLite to PostgreSQL? (y/n) " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        echo "🔄 Step 5: Migrating data from SQLite..."
        echo ""
        bundle exec rails db:migrate_to_postgres

        if [ $? -ne 0 ]; then
            echo "❌ Data migration failed"
            exit 1
        fi

        echo ""
        echo "✅ Data migration complete!"
    else
        echo ""
        echo "⏭️  Skipping data migration"
        echo ""
        echo "💡 You can run this later with: bundle exec rails db:migrate_to_postgres"
    fi
else
    echo "ℹ️  No existing SQLite database found - starting fresh"
    echo ""
    read -p "   Do you want to seed the database with sample data? (y/n) " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        echo "🌱 Seeding database..."
        bundle exec rails db:seed
        echo "✅ Database seeded"
    fi
fi

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                  🎉 Setup Complete!                           ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "✅ PostgreSQL is running on port 5432"
echo "✅ Database: idlecampus_development"
echo "✅ Ready to start Rails server!"
echo ""
echo "📋 Useful Commands:"
echo "   • Start Rails:          bundle exec rails server"
echo "   • Rails console:        bundle exec rails console"
echo "   • View PostgreSQL logs: docker-compose logs -f postgres"
echo "   • Stop PostgreSQL:      docker-compose down"
echo "   • Restart PostgreSQL:   docker-compose restart postgres"
echo ""
echo "🔗 Access:"
echo "   • Rails App:   http://localhost:3000"
echo "   • PostgreSQL:  localhost:5432"
echo ""
echo "📚 For more info, see: POSTGRES_MIGRATION_GUIDE.md"
echo ""

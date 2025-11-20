# Neon PostgreSQL Setup Guide

This guide walks you through setting up Neon PostgreSQL for the IdleCampus backend, from local development to production deployment.

## Table of Contents
- [What is Neon?](#what-is-neon)
- [Local Development Setup](#local-development-setup)
- [Neon Cloud Setup](#neon-cloud-setup)
- [Production Deployment](#production-deployment)
- [Database Branching](#database-branching)
- [Troubleshooting](#troubleshooting)

---

## What is Neon?

**Neon** is a serverless PostgreSQL platform with unique features:

- ✅ **Serverless**: Auto-scales to zero when inactive (save money!)
- ✅ **Database Branching**: Create instant database copies for testing
- ✅ **Free Tier**: 0.5GB storage, shared compute (perfect for starting)
- ✅ **Fast**: Built-in connection pooling
- ✅ **Standard PostgreSQL**: No vendor lock-in

### Pricing

| Tier | Cost | Storage | Compute | Best For |
|------|------|---------|---------|----------|
| **Free** | $0/month | 0.5GB | Shared | Development, testing |
| **Hobby** | $19/month | 10GB | Dedicated | Small production apps |
| **Pro** | $69/month | 50GB+ | Auto-scale | Production apps |

---

## Local Development Setup

For local development, you have two options:

### Option 1: Local PostgreSQL (Recommended for Development)

**Using Docker Compose:**

```bash
# Create docker-compose.yml in project root
docker-compose up -d

# Your .env should have:
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```

**Using Homebrew (macOS):**

```bash
# Install PostgreSQL
brew install postgresql@14
brew services start postgresql@14

# Create database
createdb idlecampus_development
createdb idlecampus_test
```

### Option 2: Connect Directly to Neon (Development Branch)

You can also use Neon's free tier for development:

```bash
# In your .env file:
DATABASE_URL=postgresql://user:password@ep-xxx-dev.neon.tech/neondb?sslmode=require
```

**Pros**: Same database as production, test features early
**Cons**: Requires internet connection

---

## Neon Cloud Setup

### Step 1: Create Neon Account

1. Go to [https://neon.tech](https://neon.tech)
2. Sign up with GitHub, Google, or email
3. Create your first project

### Step 2: Get Connection String

After creating a project, Neon provides connection strings:

**Pooled Connection (Use for Application):**
```
postgresql://user:password@ep-cool-darkness-123456-pooler.us-east-2.aws.neon.tech/neondb?sslmode=require
```

**Direct Connection (Use for Migrations):**
```
postgresql://user:password@ep-cool-darkness-123456.us-east-2.aws.neon.tech/neondb?sslmode=require
```

### Step 3: Configure Your Application

**For Development:**
```bash
# In .env
DATABASE_URL=postgresql://user:password@ep-xxx-pooler.neon.tech/neondb?sslmode=require
```

**For Production:**
```bash
# Set as environment variable on your hosting platform
DATABASE_URL=postgresql://user:password@ep-xxx-pooler.neon.tech/neondb?sslmode=require
```

### Step 4: Run Migrations

```bash
# Create and migrate database
rails db:create
rails db:migrate

# Seed data (including comprehensive Go course)
rails db:seed
rails runner "load 'tmp/full_golang_course.rb'"
```

---

## Production Deployment

### Option 1: Deploy to Heroku with Neon

**Setup:**
```bash
# Install Heroku CLI
brew tap heroku/brew && brew install heroku

# Login to Heroku
heroku login

# Create app
heroku create your-app-name

# Set Neon database URL
heroku config:set DATABASE_URL="postgresql://user:pass@ep-xxx-pooler.neon.tech/neondb?sslmode=require"

# Deploy
git push heroku main

# Run migrations
heroku run rails db:migrate
heroku run rails db:seed
```

**Cost Breakdown:**
- Heroku Hobby Dyno: $7/month
- Neon Hobby: $19/month
- **Total: $26/month**

### Option 2: Deploy to Render with Neon

**Setup:**
1. Go to [https://render.com](https://render.com)
2. Connect your GitHub repository
3. Create a new "Web Service"
4. Set environment variables:
   - `DATABASE_URL`: Your Neon connection string
   - `RAILS_MASTER_KEY`: Your master key
5. Deploy!

**Cost Breakdown:**
- Render Starter: $7/month
- Neon Hobby: $19/month
- **Total: $26/month**

### Option 3: Deploy to Railway with Neon

**Setup:**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Create project
railway init

# Set environment variable
railway variables set DATABASE_URL="postgresql://user:pass@ep-xxx.neon.tech/neondb?sslmode=require"

# Deploy
railway up
```

**Cost Breakdown:**
- Railway: Usage-based (~$5-10/month for small app)
- Neon Free Tier: $0/month
- **Total: ~$5-10/month**

---

## Database Branching

One of Neon's killer features is **database branching** - create instant copies of your database for testing!

### Creating a Branch

**Via Neon Dashboard:**
1. Go to your project in Neon dashboard
2. Click "Branches" → "Create Branch"
3. Select parent branch (usually `main`)
4. Name it (e.g., `staging`, `feature-golang-labs`)
5. Get the new branch's connection string

**Use Cases:**

**1. Staging Environment:**
```bash
# .env.staging
DATABASE_URL=postgresql://user:pass@ep-xxx-staging.neon.tech/neondb?sslmode=require
```

**2. Feature Testing:**
```bash
# Test new migrations on a branch before applying to production
DATABASE_URL=postgresql://user:pass@ep-xxx-feature.neon.tech/neondb?sslmode=require

# Run migrations
rails db:migrate

# If it works, apply to production
# If not, delete the branch and try again
```

**3. Pull Request Testing:**
```bash
# Create a branch for each PR
# Run full test suite against real database
# Delete branch after PR is merged
```

### Branching Workflow

```bash
# 1. Create branch from main (via Neon dashboard)

# 2. Test your changes
export DATABASE_URL="postgresql://...feature-branch..."
rails db:migrate
rails db:seed

# 3. If successful, apply to main
# 4. Delete feature branch
```

**Benefits:**
- Test migrations safely
- No need for separate staging database
- Instant creation (not copying data)
- Free on all plans!

---

## Configuration Examples

### Local Development (No Neon)
```bash
# .env
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```

### Local Development (Neon Dev Branch)
```bash
# .env
DATABASE_URL=postgresql://user:pass@ep-xxx-dev.neon.tech/neondb?sslmode=require
```

### Staging (Neon Staging Branch)
```bash
# .env.staging
DATABASE_URL=postgresql://user:pass@ep-xxx-staging.neon.tech/neondb?sslmode=require
RAILS_ENV=staging
```

### Production (Neon Main Branch)
```bash
# Set on hosting platform (Heroku/Render/Railway)
DATABASE_URL=postgresql://user:pass@ep-xxx-pooler.neon.tech/neondb?sslmode=require
RAILS_ENV=production
RAILS_MASTER_KEY=your_master_key
```

---

## Troubleshooting

### Connection Timeouts

**Problem:** Database connections timing out

**Solution:**
```bash
# Use pooled connection (has -pooler in hostname)
DATABASE_URL=postgresql://...ep-xxx-pooler.neon.tech/...
```

### SSL Certificate Errors

**Problem:** SSL verification failed

**Solution:**
```bash
# Add sslmode=require to connection string
DATABASE_URL=postgresql://...?sslmode=require

# Or in database.yml:
production:
  sslmode: require
```

### Too Many Connections

**Problem:** `too many connections` error

**Solution:**
```ruby
# In database.yml, reduce connection pool
production:
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>  # Lower this
```

### Migrations Failing

**Problem:** Migration fails with permission errors

**Solution:**
```bash
# Make sure you're using the DIRECT connection (not pooler) for migrations
# In your deployment setup:
heroku run rails db:migrate --app your-app

# The DATABASE_URL should NOT have "-pooler" for migrations
```

### Database Not Found

**Problem:** `database "idlecampus_development" does not exist`

**Solution:**
```bash
# Using DATABASE_URL, the database name comes from the URL
# Don't set separate database name in database.yml when using DATABASE_URL

# Create database (if needed)
rails db:create
```

---

## Performance Optimization

### Connection Pooling

Neon provides connection pooling automatically when using `-pooler` endpoint:

```bash
# Use pooled connection for application
DATABASE_URL=postgresql://...@ep-xxx-pooler.neon.tech/...

# Use direct connection for migrations
MIGRATION_DATABASE_URL=postgresql://...@ep-xxx.neon.tech/...
```

### Enable Auto-Suspend

In Neon dashboard:
- Go to Project Settings
- Enable "Auto-suspend" (scales to zero when inactive)
- Set delay (e.g., 5 minutes of inactivity)
- **Saves money on hobby/pro plans!**

### Query Performance

```ruby
# Enable query logging to find slow queries
# In config/environments/production.rb:
config.active_record.verbose_query_logs = true

# Use Neon dashboard to view:
# - Query statistics
# - Slow queries
# - Connection metrics
```

---

## Monitoring

### Neon Dashboard

Monitor your database at [https://console.neon.tech](https://console.neon.tech):

- **Metrics**: CPU, memory, connections
- **Query Stats**: Slow queries, most frequent
- **Branches**: All your database branches
- **Usage**: Storage and compute usage

### Application Monitoring

```ruby
# Add to Gemfile:
gem 'pg_query'
gem 'scout_apm'  # Or New Relic, Datadog, etc.

# Monitor:
# - Query performance
# - N+1 queries
# - Connection pool usage
```

---

## Migration Checklist

Before moving to Neon production:

- [ ] Test database connection locally with Neon dev branch
- [ ] Run all migrations successfully
- [ ] Seed data and verify it works
- [ ] Test database branching workflow
- [ ] Set up staging environment with Neon branch
- [ ] Configure production environment variables
- [ ] Enable auto-suspend for cost savings
- [ ] Set up database monitoring
- [ ] Test backup/restore process
- [ ] Document any Neon-specific configurations

---

## Cost Optimization Tips

1. **Start with Free Tier** for development
2. **Use Auto-Suspend** to scale to zero when inactive
3. **Delete unused branches** (they count toward storage)
4. **Monitor storage** in Neon dashboard
5. **Use connection pooling** (reduces compute costs)
6. **Optimize queries** before scaling up

---

## Additional Resources

- **Neon Documentation**: https://neon.tech/docs
- **Neon Discord**: https://discord.gg/neon
- **Rails + Neon Guide**: https://neon.tech/docs/guides/rails
- **Status Page**: https://status.neon.tech

---

## Support

### Neon Support
- Email: support@neon.tech
- Discord: https://discord.gg/neon
- Status: https://status.neon.tech

### IdleCampus Backend Issues
- Check this README
- Review database.yml configuration
- Verify environment variables in .env
- Test connection with `rails db:migrate:status`

---

**Last Updated**: $(date +%Y-%m-%d)
**Neon Version**: Compatible with all Neon tiers
**Rails Version**: 6.0.3+

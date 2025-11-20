# Starting the Backend from Idlecampus

## ✅ Everything is Ready!

All necessary files have been synced from the docker workspace:

- ✅ **Database files**: `db/development.sqlite3` (6.0M) and `db/test.sqlite3` (2.1M)
- ✅ **Environment file**: `.env` (copied from docker workspace)
- ✅ **Rails credentials**: `config/master.key` and `config/credentials.yml.enc`
- ✅ **Code files**: All synced from docker workspace

## 🚀 Quick Start

### 1. Install Dependencies (if needed)

```bash
cd /Users/ankurkothari/Documents/workspace/idlecampus/backend
bundle install
```

### 2. Start Rails Server

```bash
rails server
```

Or with a specific port:

```bash
rails server -p 3000
```

### 3. Verify It's Working

- API endpoint: http://localhost:3000/api/v1/kubernetes/courses
- Health check: http://localhost:3000

## 📋 What Was Copied

### Database Files
- `db/development.sqlite3` - 6.0M (latest data from docker workspace)
- `db/test.sqlite3` - 2.1M

### Configuration Files
- `.env` - Environment variables
- `config/master.key` - Rails master key
- `config/credentials.yml.enc` - Encrypted credentials

### Code Files
- All source code synced via `sync-backend-from-docker.sh`
- 7 files updated
- 15 new files added

## ⚠️  Notes

1. **Database**: The database is a copy from docker workspace as of Nov 4, 22:21. If you made changes in docker workspace after that, you may need to copy it again.

2. **Gems**: You may need to run `bundle install` if gems aren't installed yet.

3. **Port**: Default Rails port is 3000. Make sure nothing else is using it.

4. **Frontend**: The React frontend running on port 5002 expects the backend on port 3000.

## 🔄 If You Need to Re-sync

To sync code changes again:

```bash
cd /Users/ankurkothari/Documents/workspace/docker
./sync-backend-from-docker.sh --yes
```

To copy database again:

```bash
cd /Users/ankurkothari/Documents/workspace/docker/entry-app/SOVisits
cp db/development.sqlite3 /Users/ankurkothari/Documents/workspace/idlecampus/backend/db/development.sqlite3
cp db/test.sqlite3 /Users/ankurkothari/Documents/workspace/idlecampus/backend/db/test.sqlite3
```


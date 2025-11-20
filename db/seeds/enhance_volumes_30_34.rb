# Enhance Volumes Chapters 30-34

puts "Enhancing Volumes 30-34..."

[
  {
    slug: "codesprout-volume-types-comparison",
    command: "Volume type comparison",
    title: "Ch 30: Volume Types Comparison",
    content: <<-'MD'
**Volume Types: Named, Bind, tmpfs** 🗂️

Understanding different volume types is critical for the DCA exam!

### Three Volume Types

**1. Named Volumes (Recommended)**
**2. Bind Mounts**
**3. tmpfs Mounts**

### Named Volumes

**Managed by Docker, stored in Docker area**

```bash
docker volume create mydata
docker run -v mydata:/app/data nginx
```

**Pros:**
- ✅ Docker manages location
- ✅ Works on all platforms
- ✅ Easy backup/restore
- ✅ Use volume drivers
- ✅ Safe from accidental deletion

**Cons:**
- ❌ Not in obvious location
- ❌ Need docker commands to access

**Use when:** Production databases, app data

### Bind Mounts

**Mount host directory/file into container**

```bash
docker run -v /host/path:/container/path nginx
# or
docker run --mount type=bind,source=/host/path,target=/container/path nginx
```

**Pros:**
- ✅ Direct access to host files
- ✅ Easy file editing
- ✅ Development convenience
- ✅ Share code with container

**Cons:**
- ❌ Host path must exist
- ❌ Less portable
- ❌ Security risk (container can modify host)

**Use when:** Development, config files, logs

### tmpfs Mounts

**Stored in host memory only**

```bash
docker run --tmpfs /app/cache nginx
# or
docker run --mount type=tmpfs,destination=/app/cache nginx
```

**Pros:**
- ✅ Very fast (in-memory)
- ✅ No disk I/O
- ✅ Automatic cleanup
- ✅ Secure (no persistence)

**Cons:**
- ❌ Data lost on stop
- ❌ Uses system memory
- ❌ Limited by RAM

**Use when:** Temporary cache, secrets, fast temp storage

### DCA Exam Focus

Must know:
1. **Named volumes** - Docker-managed, /var/lib/docker/volumes
2. **Bind mounts** - Host directory → container
3. **tmpfs** - Memory-only, no persistence
4. **-v vs --mount** syntax

### Syntax Comparison

**Named volume:**
```bash
-v mydata:/app/data
--mount source=mydata,target=/app/data
```

**Bind mount:**
```bash
-v /host/dir:/container/dir
--mount type=bind,source=/host/dir,target=/container/dir
```

**tmpfs:**
```bash
--tmpfs /container/dir
--mount type=tmpfs,destination=/container/dir
```

### Try it!

```bash
# Named volume
docker volume create testdata
docker run --rm -v testdata:/data alpine sh -c "echo test > /data/file.txt"

# Bind mount
mkdir /tmp/testdir
docker run --rm -v /tmp/testdir:/data alpine sh -c "echo test > /data/file.txt"
ls /tmp/testdir  # file.txt exists on host!

# tmpfs
docker run --rm --tmpfs /cache alpine sh -c "echo test > /cache/file.txt && ls /cache"
# After container stops, data gone!
```
    MD
  },
  {
    slug: "codesprout-bind-mounts",
    command: "-v /host:/container vs --mount",
    title: "Ch 31: Bind Mounts",
    content: <<-'MD'
**Bind Mounts in Detail** 📂

Bind mounts connect host files/directories to containers - essential for development!

### What are Bind Mounts?

**Mount a host path into container:**

```bash
docker run -v /host/path:/container/path nginx
```

**Host file/directory appears inside container at specified path.**

### -v vs --mount Syntax

**Old style (-v):**
```bash
docker run -v /host/dir:/container/dir nginx
```

**New style (--mount):**
```bash
docker run --mount type=bind,source=/host/dir,target=/container/dir nginx
```

**--mount is preferred:**
- More explicit
- Easier to read
- Better error messages

### Read-Only Bind Mounts

**Prevent container from modifying host:**

```bash
# -v syntax
docker run -v /host/config:/config:ro nginx

# --mount syntax
docker run --mount type=bind,source=/host/config,target=/config,readonly nginx
```

**Use for:**
- Config files
- Static assets
- Security (container can't modify)

### Bind Mount Use Cases

**Development:**
```bash
# Mount source code for live editing
docker run -it \
  -v $(pwd):/app \
  -w /app \
  node:18 npm run dev
# Edit code on host, changes reflect in container!
```

**Configuration:**
```bash
# Mount config file
docker run -d \
  -v /etc/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
  nginx
```

**Logs:**
```bash
# Container writes logs to host
docker run -d \
  -v /var/log/myapp:/app/logs \
  myapp
```

### DCA Exam Focus

Must know:
1. **-v /host:/container** mounts host path
2. **:ro for read-only**
3. **Host path must exist** (or use --mount)
4. **Bind mounts bypass volume drivers**

### Best Practices

**✅ DO:**
```bash
# Use absolute paths
docker run -v /full/path:/container/path nginx

# Read-only for configs
docker run -v /config:/config:ro nginx
```

**❌ DON'T:**
```bash
# Relative paths (confusing)
docker run -v ./dir:/data nginx

# Write access when not needed
docker run -v /sensitive:/data nginx  # Risk!
```

### Try it!

```bash
# Create test directory
mkdir /tmp/bind-test
echo "Hello from host" > /tmp/bind-test/file.txt

# Mount and read
docker run --rm -v /tmp/bind-test:/data alpine cat /data/file.txt

# Write from container
docker run --rm -v /tmp/bind-test:/data alpine sh -c "echo 'From container' >> /data/file.txt"

# Check on host
cat /tmp/bind-test/file.txt
```
    MD
  },
  {
    slug: "codesprout-volume-drivers",
    command: "docker volume create --driver",
    title: "Ch 32: Volume Drivers",
    content: <<-'MD'
**Volume Drivers and Plugins** 🔌

Volume drivers enable different storage backends - important for production!

### What are Volume Drivers?

**Drivers determine where/how volume data is stored:**

- **local** (default): Host filesystem
- **nfs**: Network File System
- **ebs**: Amazon Elastic Block Store
- **azurefile**: Azure File Storage
- **ceph, glusterfs**: Distributed storage

### Local Driver (Default)

```bash
docker volume create mydata
# Uses local driver automatically

# Explicit:
docker volume create --driver local mydata
```

**Stores in:** `/var/lib/docker/volumes/`

### Third-Party Drivers

**Install plugin:**
```bash
docker plugin install PLUGIN_NAME
```

**Use in volume:**
```bash
docker volume create \
  --driver PLUGIN_NAME \
  --opt key=value \
  myvolume
```

### NFS Example

**NFS driver:**
```bash
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.1.100,rw \
  --opt device=:/exported/path \
  nfs-volume
```

**Use:**
```bash
docker run -v nfs-volume:/data nginx
# Data stored on NFS server!
```

### DCA Exam Focus

Must know:
1. **local driver** is default
2. **--driver** specifies storage backend
3. **Volume plugins** extend functionality
4. **--opt** passes driver-specific options

### Common Drivers

**Local with options:**
```bash
docker volume create \
  --driver local \
  --opt type=none \
  --opt o=bind \
  --opt device=/host/path \
  myvolume
```

**Cloud storage (example):**
```bash
# AWS EBS
docker volume create \
  --driver rexray/ebs \
  --opt size=10 \
  ebs-volume
```

### Try it!

```bash
# List available drivers
docker plugin ls

# Create with local driver
docker volume create --driver local testdata

# Inspect to see driver
docker volume inspect testdata | grep Driver

# Use in container
docker run --rm -v testdata:/data alpine sh -c "df -h /data"
```
    MD
  },
  {
    slug: "codesprout-volume-backup-restore",
    command: "Volume backup strategies",
    title: "Ch 33: Backup and Restore",
    content: <<-'MD'
**Backing Up and Restoring Volumes** 💾

Volume backups are critical for data safety and disaster recovery!

### Backup Strategy

**Use a container to backup volume data:**

```bash
docker run --rm \
  -v VOLUME_NAME:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/backup.tar.gz /data
```

**What this does:**
1. Mounts volume to /data
2. Mounts current directory to /backup
3. Creates compressed tar of /data
4. Saves to host filesystem

### Backup Example

**Backup database volume:**
```bash
# Create backup directory
mkdir -p /backups

# Backup postgres data
docker run --rm \
  -v pgdata:/data:ro \
  -v /backups:/backup \
  alpine tar czf /backup/pgdata-$(date +%Y%m%d).tar.gz -C /data .
```

**Result:** `/backups/pgdata-20250115.tar.gz`

### Restore from Backup

**Restore volume from tar:**

```bash
docker run --rm \
  -v NEW_VOLUME:/data \
  -v $(pwd):/backup \
  alpine tar xzf /backup/backup.tar.gz -C /data
```

### Complete Backup/Restore Example

**Backup:**
```bash
# Stop container
docker stop myapp

# Backup
docker run --rm \
  -v appdata:/data \
  -v /backups:/backup \
  alpine tar czf /backup/appdata.tar.gz /data

# Restart
docker start myapp
```

**Restore:**
```bash
# Create new volume
docker volume create appdata-restored

# Restore data
docker run --rm \
  -v appdata-restored:/data \
  -v /backups:/backup \
  alpine sh -c "cd /data && tar xzf /backup/appdata.tar.gz --strip 1"

# Use restored volume
docker run -v appdata-restored:/app/data myapp
```

### DCA Exam Focus

Must know:
1. **Use container to access volume** for backup
2. **tar for compression** and archiving
3. **Mount both volume and backup location**
4. **--rm for cleanup** after backup

### Automated Backups

**Cron job:**
```bash
# Daily backup script
#!/bin/bash
docker run --rm \
  -v pgdata:/data:ro \
  -v /backups:/backup \
  alpine tar czf /backup/pg-$(date +%Y%m%d-%H%M%S).tar.gz -C /data .

# Delete backups older than 7 days
find /backups -name "pg-*.tar.gz" -mtime +7 -delete
```

### Try it!

```bash
# Create volume with data
docker volume create testdata
docker run --rm -v testdata:/data alpine sh -c "echo 'Important data' > /data/file.txt"

# Backup
mkdir /tmp/backups
docker run --rm \
  -v testdata:/data \
  -v /tmp/backups:/backup \
  alpine tar czf /backup/test.tar.gz /data

# Delete volume
docker volume rm testdata

# Restore
docker volume create testdata-restored
docker run --rm \
  -v testdata-restored:/data \
  -v /tmp/backups:/backup \
  alpine sh -c "cd / && tar xzf /backup/test.tar.gz"

# Verify
docker run --rm -v testdata-restored:/data alpine cat /data/file.txt
```
    MD
  },
  {
    slug: "codesprout-volume-best-practices",
    command: "Volume best practices",
    title: "Ch 34: Volume Best Practices",
    content: <<-'MD'
**Volume Management Best Practices** ⭐

Follow these practices for reliable, maintainable Docker volumes!

### 1. Use Named Volumes

**✅ DO:**
```bash
docker volume create appdata
docker run -v appdata:/data myapp
```

**❌ DON'T:**
```bash
docker run -v /data myapp
# Creates anonymous volume - hard to manage!
```

### 2. Label Your Volumes

**Add metadata:**
```bash
docker volume create \
  --label env=production \
  --label app=postgres \
  --label backup=daily \
  pgdata
```

**Filter by label:**
```bash
docker volume ls --filter "label=env=production"
```

### 3. Regular Backups

**Automate backups:**
```bash
# Daily backup script
docker run --rm \
  -v dbdata:/data:ro \
  -v /backups:/backup \
  alpine tar czf /backup/db-$(date +%Y%m%d).tar.gz /data
```

### 4. Clean Up Unused Volumes

**Regular cleanup:**
```bash
# Remove dangling volumes
docker volume prune

# Check before production cleanup
docker volume ls -f dangling=true
```

### 5. Use Read-Only When Possible

**Prevent accidental writes:**
```bash
docker run -v config:/config:ro nginx
```

### 6. Document Volume Requirements

**In Dockerfile:**
```dockerfile
# Document expected volumes
VOLUME /var/lib/mysql
VOLUME /app/uploads
```

**In docker-compose.yml:**
```yaml
volumes:
  dbdata:
    driver: local
    labels:
      com.example.description: "Database volume for Postgres"
```

### DCA Exam Focus

Must know:
1. **Named volumes** over anonymous
2. **Labels** for organization
3. **Regular backups** critical
4. **Prune unused** volumes
5. **Read-only** when appropriate

### Volume Naming Convention

**Good naming:**
```
{app}_{component}_{env}
```

**Examples:**
```bash
docker volume create web_app_uploads_prod
docker volume create web_db_data_prod
docker volume create api_cache_dev
```

### Security Best Practices

**1. Principle of least privilege:**
```bash
# Read-only when possible
docker run -v data:/data:ro app

# Specific directories only
docker run -v config:/app/config:ro app
```

**2. Avoid mounting sensitive host paths:**
```bash
# ❌ DON'T
docker run -v /:/host app  # Full host access!

# ✅ DO
docker run -v /specific/safe/path:/data app
```

**3. Use secrets for sensitive data:**
```bash
# Docker secrets (Swarm)
docker secret create db_password password.txt
docker service create --secret db_password app
```

### Performance Best Practices

**1. Use volumes for databases:**
```bash
# ✅ Fast
docker run -v pgdata:/var/lib/postgresql/data postgres

# ❌ Slow
docker run -v /host/path:/var/lib/postgresql/data postgres
```

**2. Use tmpfs for temporary data:**
```bash
docker run --tmpfs /app/cache:rw,size=1g app
```

### Try it!

**Implement best practices:**
```bash
# Create labeled volume
docker volume create \
  --label env=dev \
  --label app=testapp \
  testapp_data_dev

# Use read-only where appropriate
docker run --rm \
  -v testapp_data_dev:/config:ro \
  alpine ls /config

# Cleanup
docker volume rm testapp_data_dev
```
    MD
  }
].each do |ch|
  puts "\n#{ch[:title]}"
  unit = InteractiveLearningUnit.find_by!(slug: ch[:slug])
  unit.update!(
    concept_explanation: ch[:content],
    command_to_learn: ch[:command],
    command_variations: ["docker volume create", "docker volume ls", "docker volume inspect", "docker volume rm"],
    practice_hints: [
      "Use named volumes for better management",
      "Backup volumes regularly using tar in containers",
      "Use read-only mounts when containers don't need to write",
      "Clean up unused volumes with docker volume prune"
    ]
  )
  puts "✅ Enhanced"
end

puts "\n#{'=' * 80}"
puts "🎉 ALL VOLUMES CHAPTERS COMPLETE (28-34)!"
puts "#{'=' * 80}"

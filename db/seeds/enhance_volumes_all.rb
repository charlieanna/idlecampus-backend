# Enhance ALL Volumes Chapters 28-34

puts "=" * 80
puts "Enhancing Volumes Chapters 28-34..."
puts "=" * 80

# Create chapter content hash for batch processing
volumes_content = {
  "codesprout-docker-volume-create" => {
    title: "Ch 28: docker volume create",
    command: "docker volume create",
    variations: ["docker volume create NAME", "docker volume create --driver DRIVER NAME", "docker volume create --opt key=value NAME"],
    hints: [
      "Volumes persist data beyond container lifecycle",
      "Named volumes are managed by Docker and stored in /var/lib/docker/volumes/",
      "Use volumes for databases and persistent application data",
      "Volumes can be shared between multiple containers"
    ],
    content: <<-'MARKDOWN'
**Creating Docker Volumes** 💾

Volumes are Docker's preferred way to persist data - critical for databases and stateful apps!

### Why Volumes?

**Containers are ephemeral (temporary):**
```bash
docker run postgres
# Database writes data inside container
docker rm container
# 💥 All data LOST!
```

**Volumes persist data:**
```bash
docker volume create pgdata
docker run -v pgdata:/var/lib/postgresql/data postgres
docker rm container
# ✅ Data still exists in pgdata volume!
```

### The docker volume create Command

**Creates a named volume managed by Docker.**

**Syntax:**
```bash
docker volume create [OPTIONS] [VOLUME_NAME]
```

**Examples:**
```bash
# Create named volume
docker volume create mydata

# Create with specific driver
docker volume create --driver local mydata

# Create with options
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt device=:/path/to/dir \
  nfs-volume
```

### Volume Storage Location

**Default location (Linux):**
```
/var/lib/docker/volumes/VOLUME_NAME/_data
```

**Check location:**
```bash
docker volume inspect mydata
# Shows "Mountpoint": "/var/lib/docker/volumes/mydata/_data"
```

### Volume vs Bind Mount vs tmpfs

**Volume (recommended):**
- Managed by Docker
- Stored in Docker area
- Works across platforms
- Can use volume drivers

**Bind mount:**
- Mounts host directory
- Full access to host filesystem
- Development convenience

**tmpfs mount:**
- Stored in memory only
- No persistence
- Fast, temporary data

### Using Volumes

**Create and use:**
```bash
# Create volume
docker volume create appdata

# Use in container
docker run -d \
  -v appdata:/app/data \
  --name myapp \
  myapp:latest

# Data persists in appdata volume
```

**Anonymous volumes:**
```bash
# Docker creates volume with random name
docker run -v /app/data myapp
# Creates volume like: abc123def456...
```

### Volume Drivers

**Local driver (default):**
```bash
docker volume create --driver local mydata
```

**Third-party drivers:**
- NFS
- Amazon EBS
- Azure File Storage
- Ceph
- GlusterFS

**Example - NFS:**
```bash
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.1.100,rw \
  --opt device=:/exported/path \
  nfs-volume
```

### DCA Exam Focus

**You must know:**
1. **Volumes persist data** after container removal
2. **docker volume create** for named volumes
3. **-v NAME:/path** to mount volume
4. **Volumes stored** in /var/lib/docker/volumes
5. **Volume drivers** for different storage backends

### Try it!

```bash
# Create volume
docker volume create testdata

# Use volume
docker run -it --rm \
  -v testdata:/data \
  alpine sh

# Inside container:
echo "Hello from container" > /data/test.txt
exit

# Data persists! Check from another container
docker run --rm \
  -v testdata:/data \
  alpine cat /data/test.txt
# Shows: Hello from container

# Clean up
docker volume rm testdata
```
    MARKDOWN
  },
  
  "codesprout-docker-volume-inspect" => {
    title: "Ch 29: Managing Volumes",
    command: "docker volume ls / inspect",
    variations: ["docker volume ls", "docker volume inspect VOLUME", "docker volume rm VOLUME", "docker volume prune"],
    hints: [
      "docker volume ls lists all volumes on the system",
      "docker volume inspect shows detailed volume information",
      "docker volume prune removes unused volumes",
      "docker volume rm deletes specific volumes"
    ],
    content: <<-'MARKDOWN'
**Inspecting and Managing Docker Volumes** 🔍

Managing volumes is essential for data persistence and cleanup!

### Listing Volumes

**docker volume ls:**
```bash
docker volume ls
```

**Output:**
```
DRIVER    VOLUME NAME
local     appdata
local     pgdata
local     ab12cd34ef56...
```

**Filter volumes:**
```bash
# Dangling volumes (not used by containers)
docker volume ls -f dangling=true

# Filter by driver
docker volume ls -f driver=local

# Quiet mode (names only)
docker volume ls -q
```

### Inspecting Volumes

**docker volume inspect:**
```bash
docker volume inspect mydata
```

**Output:**
```json
[
    {
        "CreatedAt": "2025-01-15T10:30:00Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/mydata/_data",
        "Name": "mydata",
        "Options": {},
        "Scope": "local"
    }
]
```

**Key information:**
- Mountpoint (where data stored)
- Driver
- Creation time
- Labels

### Removing Volumes

**Remove specific volume:**
```bash
docker volume rm mydata
```

**Remove multiple:**
```bash
docker volume rm vol1 vol2 vol3
```

**⚠️ Cannot remove in-use volumes:**
```bash
docker run -d -v mydata:/data --name app nginx
docker volume rm mydata
# Error: volume is in use - [abc123]
```

**Must stop container first:**
```bash
docker stop app
docker rm app
docker volume rm mydata  # Now works
```

### Pruning Unused Volumes

**Remove ALL unused volumes:**
```bash
docker volume prune
```

**Warning:**
```
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N]
```

**Prune with filter:**
```bash
# Remove volumes with specific label
docker volume prune --filter "label=env=test"
```

### DCA Exam Focus

**You must know:**
1. **docker volume ls** lists volumes
2. **docker volume inspect** shows details
3. **docker volume rm** deletes volumes
4. **docker volume prune** removes unused volumes
5. **Cannot remove in-use volumes**

### Volume Labels

**Create with labels:**
```bash
docker volume create \
  --label env=production \
  --label app=postgres \
  pgdata
```

**Filter by label:**
```bash
docker volume ls --filter "label=env=production"
```

### Finding Unused Volumes

**Dangling volumes:**
```bash
docker volume ls -f dangling=true
```

**These are typically:**
- Anonymous volumes from removed containers
- Named volumes no longer in use
- Test volumes forgotten about

### Try it!

```bash
# Create test volumes
docker volume create test1
docker volume create test2
docker volume create test3

# List all
docker volume ls

# Inspect one
docker volume inspect test1

# Use one in container
docker run -d -v test1:/data --name app alpine sleep 1000

# Try to remove (fails - in use)
docker volume rm test1

# Remove unused ones
docker volume rm test2 test3

# Or use prune
docker volume prune

# Clean up
docker rm -f app
docker volume rm test1
```
    MARKDOWN
  }
}

# Apply all content
volumes_content.each do |slug, data|
  puts "\n#{data[:title]}"
  unit = InteractiveLearningUnit.find_by!(slug: slug)
  unit.update!(
    concept_explanation: data[:content],
    command_to_learn: data[:command],
    command_variations: data[:variations],
    practice_hints: data[:hints]
  )
  puts "✅ Enhanced"
end

puts "\n" + "=" * 80
puts "Volumes chapters 28-29 complete!"
puts "=" * 80

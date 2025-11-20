# Enhance Chapter 19: ENTRYPOINT and WORKDIR

puts "Enhancing Chapter 19: ENTRYPOINT and WORKDIR..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-dockerfile-entrypoint-workdir")

concept_text = <<-'MARKDOWN'
**Dockerfile ENTRYPOINT and WORKDIR Instructions** 🎯

ENTRYPOINT makes your container behave like an executable. WORKDIR sets the working directory. Both are critical for DCA!

### The ENTRYPOINT Instruction

**ENTRYPOINT** configures a container to run as an executable - it's harder to override than CMD.

**Two forms:**

**1. Exec form (PREFERRED):**
```dockerfile
ENTRYPOINT ["executable", "param1", "param2"]
ENTRYPOINT ["python", "app.py"]
```

**2. Shell form:**
```dockerfile
ENTRYPOINT command param1 param2
ENTRYPOINT python app.py
```

### ENTRYPOINT vs CMD

**CMD alone (easily overridden):**
```dockerfile
FROM alpine:3.18
CMD ["echo", "Hello"]
```
```bash
docker run myapp                    # Outputs: Hello
docker run myapp echo "Goodbye"     # Outputs: Goodbye (CMD overridden)
```

**ENTRYPOINT alone (harder to override):**
```dockerfile
FROM alpine:3.18
ENTRYPOINT ["echo", "Hello"]
```
```bash
docker run myapp                    # Outputs: Hello
docker run myapp Goodbye            # Outputs: Hello Goodbye (args appended!)
docker run --entrypoint sh myapp    # Can override with --entrypoint flag
```

### ENTRYPOINT + CMD (Best Practice!)

**Combine them for flexible defaults:**
```dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY . .

# ENTRYPOINT = the main command
ENTRYPOINT ["python", "app.py"]

# CMD = default arguments
CMD ["--port", "8000", "--host", "0.0.0.0"]
```

**Usage:**
```bash
# Use defaults
docker run myapp
# Runs: python app.py --port 8000 --host 0.0.0.0

# Override CMD (provide different args)
docker run myapp --port 9000 --debug
# Runs: python app.py --port 9000 --debug

# Override ENTRYPOINT (rare)
docker run --entrypoint python myapp -m pytest
# Runs: python -m pytest
```

### The WORKDIR Instruction

**WORKDIR** sets the working directory for subsequent instructions and the container runtime.

**Syntax:**
```dockerfile
WORKDIR /path/to/directory
```

**Key behaviors:**
- Creates directory if it doesn't exist
- Affects RUN, CMD, ENTRYPOINT, COPY, ADD
- Can be used multiple times
- Can use relative paths

**Example:**
```dockerfile
FROM node:18-alpine

# Set working directory (creates /app if not exists)
WORKDIR /app

# Now we're in /app
COPY package*.json ./
RUN npm install

# Still in /app
COPY . .

# Container starts in /app
CMD ["node", "server.js"]
```

### WORKDIR Best Practices

**❌ BAD - Using cd in RUN:**
```dockerfile
FROM python:3.11-slim
RUN cd /app && pip install -r requirements.txt
# cd only affects this RUN layer!
COPY . .  # Not in /app anymore!
```

**✅ GOOD - Using WORKDIR:**
```dockerfile
FROM python:3.11-slim
WORKDIR /app
RUN pip install -r requirements.txt
COPY . .  # In /app as expected
```

### Multiple WORKDIR

**Absolute and relative paths:**
```dockerfile
FROM alpine:3.18

WORKDIR /app
# Now in: /app

WORKDIR data
# Now in: /app/data (relative path)

WORKDIR /var/log
# Now in: /var/log (absolute path)

RUN pwd
# Outputs: /var/log
```

### WORKDIR with Environment Variables

```dockerfile
FROM node:18-alpine

ENV APP_HOME=/app
WORKDIR $APP_HOME
# Now in /app

ENV DATA_DIR=data
WORKDIR $DATA_DIR
# Now in /app/data
```

### Common Patterns

**Pattern 1: Python application**
```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT ["python"]
CMD ["app.py"]
```

**Running:**
```bash
# Default
docker run myapp
# Runs: python app.py

# Run different script
docker run myapp test.py
# Runs: python test.py

# Run with flags
docker run myapp -m pytest tests/
# Runs: python -m pytest tests/
```

**Pattern 2: Go application (binary)**
```dockerfile
FROM golang:1.21 AS builder

WORKDIR /build
COPY . .
RUN go build -o app

FROM alpine:3.18

WORKDIR /app
COPY --from=builder /build/app .

ENTRYPOINT ["./app"]
CMD ["--help"]
```

**Pattern 3: CLI tool container**
```dockerfile
FROM alpine:3.18

RUN apk add --no-cache curl jq

WORKDIR /workspace

# Make it work like a CLI tool
ENTRYPOINT ["curl", "-s"]
CMD ["--help"]
```

**Usage:**
```bash
# Get help
docker run mytool

# Fetch URL
docker run mytool https://api.github.com/users/docker

# Pipe output
docker run mytool https://api.github.com/users/docker | jq .
```

### ENTRYPOINT Script Pattern

**Common pattern for initialization:**
```dockerfile
FROM postgres:15

WORKDIR /app

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]
```

**docker-entrypoint.sh:**
```bash
#!/bin/bash
set -e

# Initialization logic
echo "Initializing database..."
./init-db.sh

# Execute the CMD
exec "$@"
```

**This pattern allows:**
- Setup before main command
- Configuration checks
- Migration running
- `exec "$@"` runs the CMD

### DCA Exam Focus

**You must know:**
1. **ENTRYPOINT + CMD work together** - ENTRYPOINT is main command, CMD is default args
2. **WORKDIR creates directory** if it doesn't exist
3. **WORKDIR affects all subsequent instructions**
4. **Prefer WORKDIR over cd in RUN**
5. **Override ENTRYPOINT with --entrypoint flag**
6. **Exec form vs shell form** differences

### Common Mistakes

**Mistake 1: Using cd instead of WORKDIR**
```dockerfile
RUN cd /app  # ❌ Only affects this layer!
COPY . .     # Not in /app!
```

**Mistake 2: Forgetting exec in entrypoint script**
```bash
#!/bin/bash
# ❌ BAD - CMD runs as child process
python app.py
```
```bash
#!/bin/bash
# ✅ GOOD - CMD replaces shell (PID 1)
exec python app.py
```

**Mistake 3: Using shell form ENTRYPOINT**
```dockerfile
ENTRYPOINT python app.py  # ❌ Shell wrapper
```
```dockerfile
ENTRYPOINT ["python", "app.py"]  # ✅ Direct execution
```

### Testing ENTRYPOINT and WORKDIR

**Dockerfile:**
```dockerfile
FROM alpine:3.18

WORKDIR /app

# Create test file to verify WORKDIR
RUN echo "Working directory: $(pwd)" > location.txt
RUN ls -la

# Entrypoint prints working dir and runs command
ENTRYPOINT ["sh", "-c", "pwd && exec \"$@\"", "--"]
CMD ["ls", "-la"]
```

**Test:**
```bash
# Build
docker build -t test-entry-work .

# Default CMD
docker run test-entry-work
# Shows: /app and lists files

# Override CMD
docker run test-entry-work cat location.txt
# Shows working directory was /app during build

# Check WORKDIR persists at runtime
docker run test-entry-work pwd
# Outputs: /app
```

### Real-World Example: Database migration tool

**Dockerfile:**
```dockerfile
FROM python:3.11-slim

WORKDIR /migrations

# Install migration tool
RUN pip install alembic psycopg2-binary

# Copy migration scripts
COPY migrations/ .
COPY alembic.ini .

# ENTRYPOINT is the tool
ENTRYPOINT ["alembic"]

# Default CMD shows current version
CMD ["current"]
```

**Usage:**
```bash
# Check current migration
docker run db-migrate

# Run upgrade
docker run db-migrate upgrade head

# Show history
docker run db-migrate history

# Downgrade
docker run db-migrate downgrade -1
```

### Try it!

Create a CLI-like container:
```dockerfile
FROM alpine:3.18

WORKDIR /data

RUN apk add --no-cache curl

ENTRYPOINT ["curl"]
CMD ["--help"]
```

**Build and test:**
```bash
docker build -t mycurl .

# Show help
docker run mycurl

# Fetch URL
docker run mycurl https://httpbin.org/ip

# Mount local directory and save file
docker run -v $(pwd):/data mycurl -o /data/output.json https://httpbin.org/json

# Check file was saved in current directory
cat output.json
```
MARKDOWN

unit.update!(
  concept_explanation: concept_text,
  command_to_learn: "ENTRYPOINT, WORKDIR",
  command_variations: ["ENTRYPOINT [\"cmd\"]", "WORKDIR /path", "WORKDIR $VAR"],
  practice_hints: [
    "ENTRYPOINT + CMD work together - ENTRYPOINT is command, CMD is default args",
    "WORKDIR creates directory if it doesn't exist",
    "Use WORKDIR instead of cd in RUN commands",
    "Prefer exec form over shell form for ENTRYPOINT"
  ]
)

puts "✅ Chapter 19 enhanced successfully!"

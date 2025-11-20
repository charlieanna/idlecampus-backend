# Enhance Chapter 21: Dockerfile Optimization

puts "Enhancing Chapter 21: Dockerfile Optimization..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-dockerfile-optimization")

concept_text = <<-'MARKDOWN'
**Dockerfile Optimization and Best Practices** ⚡

Optimization is CRITICAL for the DCA exam! Smaller, faster, more secure images are essential.

### Why Optimization Matters

**Unoptimized Dockerfile:**
- Large image size (1-2GB+)
- Slow builds (no caching)
- Security vulnerabilities
- Slow deployments

**Optimized Dockerfile:**
- Small image size (50-200MB)
- Fast builds (layer caching)
- Fewer vulnerabilities
- Fast deployments

**For DCA:** You must understand layer caching, .dockerignore, and optimization patterns!

### Layer Caching (CRITICAL!)

**How Docker caching works:**
1. Docker checks if instruction has changed
2. If unchanged AND previous layers unchanged → use cache
3. If changed → rebuild this layer and ALL layers after

**❌ BAD - Cache broken on every build:**
```dockerfile
FROM python:3.11-slim

# This changes every time you edit ANY file!
COPY . /app/

# Cache is ALWAYS invalidated here
WORKDIR /app
RUN pip install -r requirements.txt
```

**✅ GOOD - Optimized caching:**
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Copy requirements FIRST (changes rarely)
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy code LAST (changes often)
COPY . .
```

**Result:**
- Code changes: Only last COPY rebuilds
- Dependency changes: RUN pip install + COPY code rebuild
- No changes: Everything cached!

### Order of Instructions Matters

**General principle:**
```dockerfile
FROM base-image

# 1. Rarely changing (system packages)
RUN apt-get update && apt-get install -y package

# 2. Sometimes changing (dependencies)
COPY requirements.txt .
RUN pip install -r requirements.txt

# 3. Frequently changing (your code)
COPY . .

# 4. Configuration (occasionally changing)
ENV APP_PORT=8000

# 5. Runtime (rarely changing)
CMD ["python", "app.py"]
```

### The .dockerignore File

**CRITICAL:** Exclude unnecessary files from build context!

**.dockerignore example:**
```
# Version control
.git/
.gitignore
.svn/

# Dependencies (install from package.json instead)
node_modules/
vendor/

# Build artifacts
dist/
build/
*.pyc
__pycache__/

# IDE files
.vscode/
.idea/
*.swp

# OS files
.DS_Store
Thumbs.db

# Environment files
.env
.env.local
*.pem

# Documentation
README.md
docs/

# Tests (don't need in production)
tests/
*.test.js
*.spec.js

# Logs
*.log
logs/
```

**Why this matters:**
1. **Faster builds** - Less data to send to Docker daemon
2. **Smaller images** - Don't copy unnecessary files
3. **Security** - Don't include .env, keys, credentials
4. **Cache efficiency** - Fewer file changes break cache

**Test .dockerignore:**
```bash
# Check what's being sent to Docker
docker build --progress=plain -t test . 2>&1 | grep "Transferring context"
# Should be small (< 10MB ideally)
```

### Combine RUN Commands

**❌ BAD - Multiple layers:**
```dockerfile
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y vim
RUN rm -rf /var/lib/apt/lists/*
```
**Result:** 5 layers, large image

**✅ GOOD - Single layer:**
```dockerfile
RUN apt-get update \
    && apt-get install -y \
        curl \
        wget \
        vim \
    && rm -rf /var/lib/apt/lists/*
```
**Result:** 1 layer, smaller image

**Why combine:**
- Fewer layers = smaller image
- Cleanup in same layer reduces size
- Better cache granularity

### Cleanup in the Same Layer

**❌ BAD - Cleanup doesn't help:**
```dockerfile
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get clean  # Too late! Previous layers still have the data
```

**✅ GOOD - Cleanup in same RUN:**
```dockerfile
RUN apt-get update \
    && apt-get install -y build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
```

**Common cleanup patterns:**

**APT (Debian/Ubuntu):**
```dockerfile
RUN apt-get update \
    && apt-get install -y package \
    && rm -rf /var/lib/apt/lists/*
```

**YUM (CentOS/RHEL):**
```dockerfile
RUN yum install -y package \
    && yum clean all \
    && rm -rf /var/cache/yum
```

**APK (Alpine):**
```dockerfile
RUN apk add --no-cache package
# --no-cache means no cleanup needed!
```

### Use Specific Package Versions

**❌ BAD - Unpredictable builds:**
```dockerfile
RUN pip install flask
# Which version? Could break in future!
```

**✅ GOOD - Pinned versions:**
```dockerfile
RUN pip install flask==2.3.0
# Reproducible builds!
```

**Even better - requirements file:**
```dockerfile
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
```

**requirements.txt:**
```
flask==2.3.0
requests==2.31.0
redis==5.0.0
```

### Use --no-cache-dir Flags

**Python:**
```dockerfile
RUN pip install --no-cache-dir -r requirements.txt
# Doesn't keep pip cache (saves ~200MB)
```

**Node.js:**
```dockerfile
RUN npm ci --only=production
# Uses package-lock.json, no dev deps
```

**APT:**
```dockerfile
RUN apt-get update \
    && apt-get install -y --no-install-recommends package
# Doesn't install recommended packages (saves space)
```

### Choose the Right Base Image

**Size comparison:**
```
ubuntu:22.04          →  77MB
python:3.11           → 920MB
python:3.11-slim      → 125MB
python:3.11-alpine    →  50MB
```

**Guidelines:**

**Use Alpine when:**
- You need smallest possible image
- You don't have complex C dependencies
- You understand musl vs glibc differences

**Use Slim when:**
- You need glibc compatibility
- You have compiled dependencies
- You want balance of size/compatibility

**Use Full when:**
- Development/debugging
- Complex build requirements
- You need many system tools

### Multi-Stage Builds (Best Optimization!)

**See Chapter 20 for details. Quick recap:**
```dockerfile
# Build stage (large)
FROM node:18 AS builder
RUN npm install && npm run build

# Production (small)
FROM node:18-alpine
COPY --from=builder /app/dist ./dist
```

**Result:** 10-50x smaller images!

### DCA Exam Focus

**You must know:**
1. **Layer caching** - Put changing things LAST
2. **.dockerignore** - Exclude unnecessary files
3. **Combine RUN commands** - Reduce layers
4. **Cleanup in same layer** - Remove temp files
5. **--no-cache flags** - Don't keep package manager cache
6. **Specific versions** - Reproducible builds
7. **Multi-stage builds** - Smallest final images

### Real-World Optimization Example

**Before optimization:**
```dockerfile
FROM python:3.11
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```

**Image size:** 980MB
**Build time:** 2 minutes (no caching)

**After optimization:**
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Copy requirements first
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy code last
COPY . .

# Non-root user
RUN useradd -m appuser && chown -R appuser /app
USER appuser

CMD ["python", "app.py"]
```

**.dockerignore:**
```
.git
__pycache__
*.pyc
tests/
.env
```

**Image size:** 145MB (85% smaller!)
**Build time:** 10 seconds (with cache)

### Optimization Checklist

**✅ Structure:**
- [ ] Using multi-stage builds?
- [ ] Smallest appropriate base image?
- [ ] Order optimized for caching?

**✅ Dependencies:**
- [ ] Using .dockerignore?
- [ ] Specific package versions?
- [ ] --no-cache-dir flags?
- [ ] --no-install-recommends?

**✅ Layers:**
- [ ] Combined RUN commands?
- [ ] Cleanup in same layer?
- [ ] Minimal layer count?

**✅ Security:**
- [ ] Non-root user?
- [ ] No secrets in image?
- [ ] Minimal attack surface?

### Measuring Optimization

**Check image size:**
```bash
docker images myapp
```

**Check layer sizes:**
```bash
docker history myapp
```

**Check what's in the image:**
```bash
docker run --rm myapp du -sh /*
```

**Check build time:**
```bash
time docker build -t myapp .
```

### Advanced Optimizations

**1. BuildKit (faster builds):**
```bash
DOCKER_BUILDKIT=1 docker build -t myapp .
```

**2. Cache mounts:**
```dockerfile
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r requirements.txt
```

**3. Bind mounts for build:**
```dockerfile
RUN --mount=type=bind,source=package.json,target=package.json \
    npm install
```

**4. Squash layers (experimental):**
```bash
docker build --squash -t myapp .
```

### Common Mistakes

**Mistake 1: Installing dev dependencies:**
```dockerfile
RUN pip install -r requirements-dev.txt  # ❌ pytest, black, etc in prod!
```

**Mistake 2: Not using .dockerignore:**
```
# No .dockerignore → copies node_modules/ (500MB!)
```

**Mistake 3: Using latest tag:**
```dockerfile
FROM python:latest  # ❌ Unpredictable!
```

**Mistake 4: Root user:**
```dockerfile
# No USER instruction → runs as root (security risk!)
```

### Try it!

**Unoptimized Dockerfile:**
```dockerfile
FROM python:3.11
COPY . /app
WORKDIR /app
RUN pip install flask
CMD ["python", "-m", "flask", "run"]
```

**Optimize it:**
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# .dockerignore first!
# Then:
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -m appuser && chown -R appuser /app
USER appuser

EXPOSE 5000
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
```

**.dockerignore:**
```
__pycache__/
*.pyc
.git/
.env
tests/
```

**Compare:**
```bash
# Before
docker build -t app:before -f Dockerfile.before .
docker images app:before

# After
docker build -t app:after -f Dockerfile.after .
docker images app:after

# Check size difference
```

**Expected results:**
- Before: ~950MB
- After: ~130MB
- **Savings: 86%!**
MARKDOWN

unit.update!(
  concept_explanation: concept_text,
  command_to_learn: "Dockerfile optimization",
  command_variations: [".dockerignore", "RUN commands &&", "--no-cache-dir", "multi-stage"],
  practice_hints: [
    "Put frequently changing instructions LAST for better caching",
    "Use .dockerignore to exclude unnecessary files",
    "Combine RUN commands and clean up in the same layer",
    "Use --no-cache-dir flags to reduce image size"
  ]
)

puts "✅ Chapter 21 enhanced successfully!"

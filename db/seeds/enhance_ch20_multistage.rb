# Enhance Chapter 20: Multi-stage Builds

puts "Enhancing Chapter 20: Multi-stage Builds..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-dockerfile-multistage")

concept_text = <<-'MARKDOWN'
**Multi-Stage Docker Builds** 🏗️

Multi-stage builds are CRITICAL for the DCA exam! They dramatically reduce image size and improve security.

### The Problem Multi-Stage Solves

**Without multi-stage (BAD):**
```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install        # Installs dev dependencies
COPY . .
RUN npm run build      # Builds the app
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

**Result:** Final image includes:
- Node.js runtime ✓ (needed)
- npm ✓ (needed)
- Build tools ✗ (NOT needed - wasted space!)
- Dev dependencies ✗ (NOT needed - security risk!)
- Source files ✗ (NOT needed - only need dist/)
- **Total size: ~1.2GB** 😱

### Multi-Stage Build Solution

**With multi-stage (GOOD):**
```dockerfile
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
RUN npm ci --only=production
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

**Result:** Final image includes ONLY:
- Node.js runtime ✓
- Production dependencies ✓
- Built application ✓
- **Total size: ~150MB** 🎉 **(8x smaller!)**

### How Multi-Stage Works

**Each FROM starts a new stage:**
```dockerfile
FROM node:18 AS stage1     # Stage 1
# ... commands ...

FROM node:18-alpine AS stage2   # Stage 2 (starts fresh)
# Previous stage is gone!
```

**Copy artifacts between stages:**
```dockerfile
COPY --from=builder /app/dist ./dist
# Copies from "builder" stage to current stage
```

### Naming Stages

**Name stages with AS:**
```dockerfile
FROM golang:1.21 AS builder    # Named "builder"
FROM alpine:3.18 AS runtime    # Named "runtime"
```

**Reference by name or number:**
```dockerfile
COPY --from=builder /app/binary .    # By name
COPY --from=0 /app/binary .          # By number (0 = first stage)
```

### Real-World Examples

**Example 1: Go application**
```dockerfile
# Build stage
FROM golang:1.21 AS builder

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app

# Runtime stage
FROM alpine:3.18

RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /build/app .

EXPOSE 8080
ENTRYPOINT ["./app"]
```

**Size comparison:**
- Builder stage: ~800MB (has Go compiler, build cache)
- Final image: ~15MB (just binary + Alpine)
- **53x smaller!**

**Example 2: React application**
```dockerfile
# Build stage
FROM node:18 AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**Result:**
- Builder: 1.2GB (Node.js + npm + deps)
- Final: 40MB (nginx + static files only)
- **30x smaller!**

**Example 3: Python with compiled dependencies**
```dockerfile
# Build stage
FROM python:3.11 AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Runtime stage
FROM python:3.11-slim

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /root/.local /root/.local
COPY . .

# Update PATH
ENV PATH=/root/.local/bin:$PATH

CMD ["python", "app.py"]
```

### Testing Specific Stages

**Build only a specific stage:**
```bash
# Build just the builder stage
docker build --target builder -t myapp:builder .

# Build the final stage (default)
docker build -t myapp:latest .
```

**Use case:** Testing build process without creating final image.

### Multiple Production Stages

**Different stages for different environments:**
```dockerfile
# Base stage
FROM python:3.11-slim AS base
WORKDIR /app
COPY requirements.txt .

# Development stage
FROM base AS development
RUN pip install -r requirements.txt -r requirements-dev.txt
COPY . .
CMD ["python", "-m", "pytest", "--watch"]

# Production stage
FROM base AS production
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["gunicorn", "app:app"]
```

**Build for different targets:**
```bash
# Development image
docker build --target development -t myapp:dev .

# Production image
docker build --target production -t myapp:prod .
```

### Copying from External Images

**You can copy from ANY image (not just previous stages):**
```dockerfile
FROM alpine:3.18

# Copy from official nginx image
COPY --from=nginx:alpine /usr/share/nginx/html/index.html /app/

# Copy from specific version
COPY --from=node:18-alpine /usr/local/bin/node /usr/local/bin/

CMD ["sh"]
```

**Use case:** Grabbing binaries from official images.

### DCA Exam Focus

**You must know:**
1. **Each FROM starts a new stage** - previous stage is discarded
2. **--from=stagename copies from previous stages**
3. **--target builds specific stage**
4. **Final stage = final image** (earlier stages are intermediate)
5. **Why multi-stage:** Smaller images, better security, faster deploys
6. **Naming stages with AS** for clarity

### Best Practices

**✅ DO:**
```dockerfile
# Separate build and runtime
FROM node:18 AS builder
# ... build steps ...

FROM node:18-alpine
COPY --from=builder /app/dist ./dist
```

**✅ DO:**
```dockerfile
# Use specific stage names
FROM golang:1.21 AS builder
FROM golang:1.21 AS tester
FROM alpine:3.18 AS runtime
```

**❌ DON'T:**
```dockerfile
# Don't copy everything
FROM builder
COPY --from=builder / /
# This defeats the purpose!
```

### Common Patterns

**Pattern 1: Build → Test → Production**
```dockerfile
# Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Test
FROM builder AS tester
RUN npm test

# Production
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
```

**Build with tests:**
```bash
# This will fail the build if tests fail
docker build --target tester -t myapp:test .

# Build production only if tests pass
docker build -t myapp:prod .
```

**Pattern 2: Shared base layer**
```dockerfile
# Base dependencies
FROM python:3.11-slim AS base
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

# Development
FROM base AS dev
COPY requirements-dev.txt .
RUN pip install -r requirements-dev.txt
COPY . .
CMD ["python", "-m", "pytest"]

# Production
FROM base AS prod
COPY . .
CMD ["gunicorn", "app:app"]
```

### Size Comparison Example

**Test it yourself:**
```dockerfile
# Single-stage (large)
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
CMD ["node", "dist/server.js"]
```

**Check size:**
```bash
docker build -f Dockerfile.single -t app:single .
docker images app:single
# REPOSITORY   TAG      SIZE
# app          single   1.2GB
```

**Multi-stage (small):**
```dockerfile
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm ci --only=production
CMD ["node", "dist/server.js"]
```

**Check size:**
```bash
docker build -f Dockerfile.multi -t app:multi .
docker images app:multi
# REPOSITORY   TAG      SIZE
# app          multi    150MB
```

**Savings: ~1GB** (87% smaller!)

### Security Benefits

**Single-stage risks:**
- Source code in final image
- Build tools (potential vulnerabilities)
- Dev dependencies
- Build cache and history

**Multi-stage benefits:**
- Only runtime files in final image
- No build tools
- No source code
- Smaller attack surface

### Try it!

**Create this Dockerfile:**
```dockerfile
# Build stage
FROM golang:1.21 AS builder
WORKDIR /app
RUN echo 'package main\nimport "fmt"\nfunc main() { fmt.Println("Hello from multi-stage!") }' > main.go
RUN go build -o app main.go

# Runtime stage
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/app .
CMD ["./app"]
```

**Build and compare:**
```bash
# Build multi-stage
docker build -t test-multi .

# Check sizes
docker images | grep -E "golang|test-multi|alpine"

# Run it
docker run test-multi

# Note: Builder stage (~800MB) is NOT in final image (~15MB)!
```

### Advanced: Multi-platform builds

```dockerfile
FROM --platform=$BUILDPLATFORM golang:1.21 AS builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN echo "Building on $BUILDPLATFORM for $TARGETPLATFORM"

WORKDIR /build
COPY . .
RUN go build -o app

FROM alpine:3.18
COPY --from=builder /build/app .
CMD ["./app"]
```

**Build for multiple platforms:**
```bash
docker buildx build --platform linux/amd64,linux/arm64 -t myapp .
```
MARKDOWN

unit.update!(
  concept_explanation: concept_text,
  command_to_learn: "Multi-stage builds",
  command_variations: ["FROM ... AS stagename", "COPY --from=stage", "docker build --target stage"],
  practice_hints: [
    "Each FROM starts a new stage - previous stage is discarded",
    "Use COPY --from=stagename to copy artifacts between stages",
    "Build specific stage with --target flag",
    "Multi-stage builds can reduce image size by 10-50x"
  ]
)

puts "✅ Chapter 20 enhanced successfully!"

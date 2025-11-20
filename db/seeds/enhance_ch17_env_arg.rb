# Enhance Chapter 17: ENV and ARG

puts "Enhancing Chapter 17: ENV and ARG..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-dockerfile-env-arg")

concept_text = <<-'MARKDOWN'
**Dockerfile ENV and ARG Instructions** 🔧

Understanding the difference between ENV and ARG is crucial for DCA! They both set variables, but at different times.

### The ENV Instruction

**ENV** sets environment variables that persist in the final image and are available at runtime.

**Syntax:**
```dockerfile
ENV <key>=<value>
ENV <key1>=<value1> <key2>=<value2>
```

**Examples:**
```dockerfile
FROM python:3.11-slim
ENV FLASK_APP=app.py
ENV FLASK_ENV=production
ENV PORT=5000

# App will see these variables when running
CMD flask run --host=0.0.0.0 --port=$PORT
```

**Key Points:**
- Available during BUILD and RUNTIME
- Visible with `docker inspect`
- Can be overridden with `docker run -e`
- Persists in the final image

### The ARG Instruction

**ARG** sets build-time variables that are NOT available at runtime.

**Syntax:**
```dockerfile
ARG <name>[=<default_value>]
```

**Examples:**
```dockerfile
FROM python:3.11-slim

# Build arguments with defaults
ARG PYTHON_VERSION=3.11
ARG BUILD_DATE
ARG VCS_REF

# Can use in RUN commands
RUN echo "Building on $BUILD_DATE"
RUN echo "Git commit: $VCS_REF"

# ARG values are NOT available here at runtime!
CMD python app.py
```

**Key Points:**
- Only available during BUILD
- NOT visible in final image
- Set with `docker build --build-arg KEY=VALUE`
- Disappear after image is built

### ENV vs ARG: When to Use What?

**Use ENV for:**
- Runtime configuration (database URLs, API keys)
- Application settings that containers need
- Values that should persist

**Use ARG for:**
- Build-time only values (build dates, versions)
- Secrets that shouldn't be in final image
- Conditional build logic

### Combined Usage Pattern

**Common pattern:**
```dockerfile
FROM python:3.11-slim

# ARG for build-time flexibility
ARG ENVIRONMENT=development

# Convert to ENV for runtime
ENV APP_ENV=$ENVIRONMENT

# Install based on environment
RUN if [ "$ENVIRONMENT" = "production" ]; then \
      pip install --no-cache-dir gunicorn; \
    fi

COPY . /app
WORKDIR /app
```

**Build for different environments:**
```bash
# Development build
docker build --build-arg ENVIRONMENT=development -t myapp:dev .

# Production build
docker build --build-arg ENVIRONMENT=production -t myapp:prod .
```

### Security Considerations

**❌ DANGEROUS - Secrets in ENV:**
```dockerfile
ENV DATABASE_PASSWORD=supersecret123
# This is VISIBLE in docker inspect!
```

**✅ BETTER - Use ARG (but still not perfect):**
```dockerfile
ARG DATABASE_PASSWORD
RUN curl https://api.example.com/auth?key=$DATABASE_PASSWORD
# Password not in final image, but in build history!
```

**✅ BEST - Use Docker secrets or external config:**
```bash
docker run -e DATABASE_PASSWORD=$(cat /secure/password) myapp
# Or use Docker secrets in Swarm
```

### Predefined ARGs

Docker provides built-in ARGs:
```dockerfile
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETARCH

RUN echo "Building for $TARGETPLATFORM on $BUILDPLATFORM"
```

**Example:**
```
Building for linux/amd64 on linux/arm64
```

### Variable Expansion

**ENV supports expansion:**
```dockerfile
ENV PATH=/app/bin:$PATH
ENV HOME=/home/appuser
ENV WORK=$HOME/workspace
```

**ARG can reference previous ARGs:**
```dockerfile
ARG VERSION=1.0
ARG IMAGE_NAME=myapp:$VERSION
```

### DCA Exam Focus

**You must understand:**
1. **ENV persists** in final image, **ARG does not**
2. **ARG only available during build**
3. **ENV can be overridden** with `docker run -e`
4. **ARG set with** `--build-arg` flag
5. **Security implications** of ENV vs ARG
6. **Variable expansion** in both

### Common Patterns

**Pattern 1: Multi-stage with ARGs**
```dockerfile
FROM node:18 AS builder
ARG NODE_ENV=production
ENV NODE_ENV=$NODE_ENV

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
```

**Pattern 2: Conditional builds**
```dockerfile
FROM python:3.11-slim
ARG INSTALL_DEV_DEPS=false

COPY requirements.txt .
RUN pip install -r requirements.txt

# Conditional install
RUN if [ "$INSTALL_DEV_DEPS" = "true" ]; then \
      pip install pytest black flake8; \
    fi
```

### Checking Values

**View ENV variables:**
```bash
docker inspect myapp | grep -A 10 "Env"
docker run myapp printenv
```

**ARG values:**
```bash
docker history myapp
# ARGs visible in build history layers
```

### Try it!

**Dockerfile:**
```dockerfile
FROM alpine:3.18

ARG BUILD_VERSION=1.0
ARG BUILD_DATE

ENV APP_VERSION=$BUILD_VERSION
ENV GREETING="Hello from Docker"

RUN echo "Built version $BUILD_VERSION on $BUILD_DATE"

CMD echo "$GREETING - Version: $APP_VERSION"
```

**Build and run:**
```bash
docker build --build-arg BUILD_DATE=$(date) -t test-env-arg .
docker run test-env-arg
docker inspect test-env-arg | grep APP_VERSION
```

**Notice:**
- BUILD_DATE used during build (in logs)
- APP_VERSION available at runtime (in output)
- BUILD_DATE NOT in final image
MARKDOWN

unit.update!(
  concept_explanation: concept_text,
  command_to_learn: "ENV, ARG",
  command_variations: ["ENV KEY=value", "ARG KEY=default", "ENV KEY=$ARG_VALUE"],
  practice_hints: [
    "ENV persists in final image, ARG only during build",
    "Use ARG for build-time values, ENV for runtime config",
    "Set ARG with --build-arg flag when building",
    "Never put secrets in ENV - visible in docker inspect"
  ]
)

puts "✅ Chapter 17 enhanced successfully!"

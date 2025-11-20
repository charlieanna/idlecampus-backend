# Enhance Chapters 15-21: Dockerfile Mastery for DCA
# Image Creation Domain (20% of DCA exam)

puts "=" * 100
puts "ENHANCING CHAPTERS 15-21: DOCKERFILE MASTERY"
puts "Deep dive into Dockerfile instructions and optimization"
puts "=" * 100

# Helper to update a chapter
def update_chapter(slug, content_hash)
  unit = InteractiveLearningUnit.find_by!(slug: slug)
  unit.update!(content_hash)
  puts "✅ Enhanced: #{unit.title}"
end

# ==============================================================================
# CHAPTER 15: FROM and RUN - Base Images and Commands
# ==============================================================================

puts "\n📦 Chapter 15: FROM and RUN..."

update_chapter("codesprout-dockerfile-from-run", {
  concept_explanation: <<~MD,
    **Dockerfile FROM and RUN Instructions** 🏗️

    Every Dockerfile starts with `FROM` and typically uses `RUN` to execute commands. These are the foundation of custom image building.

    ### The FROM Instruction

    **FROM** specifies the base image to build upon.

    **Syntax:**
    ```dockerfile
    FROM <image>[:<tag>] [AS <name>]
    ```

    **Examples:**
    ```dockerfile
    # Official image, latest tag
    FROM ubuntu:22.04

    # Lightweight Alpine base
    FROM python:3.11-alpine

    # Multi-stage build (covered in Ch 20)
    FROM node:18 AS builder
    ```

    **Key Points:**
    - Must be the **first instruction** (except ARG for parameterizing FROM)
    - Sets the base layer for your image
    - Choose based on what you need pre-installed

    ### Choosing a Base Image

    **Option 1: Minimal (Alpine)**
    ```dockerfile
    FROM alpine:3.18    # ~5MB
    ```
    ✅ Smallest size
    ❌ Uses musl libc (compatibility issues possible)
    ✅ Best for simple apps

    **Option 2: Slim Variants**
    ```dockerfile
    FROM python:3.11-slim    # ~120MB
    ```
    ✅ Smaller than full image
    ✅ Uses glibc (better compatibility)
    ✅ Good balance

    **Option 3: Full Images**
    ```dockerfile
    FROM ubuntu:22.04    # ~77MB base
    ```
    ✅ Everything included
    ❌ Larger size
    ✅ Best for complex builds

    **DCA Exam Tip:** Know when to use each type!

    ### The RUN Instruction

    **RUN** executes commands during the build process.

    **Two forms:**

    **1. Shell form (runs in shell):**
    ```dockerfile
    RUN apt-get update && apt-get install -y curl
    ```

    **2. Exec form (direct execution):**
    ```dockerfile
    RUN ["apt-get", "install", "-y", "curl"]
    ```

    ### RUN Best Practices

    **❌ BAD - Multiple layers:**
    ```dockerfile
    RUN apt-get update
    RUN apt-get install -y curl
    RUN apt-get install -y wget
    RUN rm -rf /var/lib/apt/lists/*
    ```
    Problem: Creates 4 layers, cache updates broken

    **✅ GOOD - Single layer:**
    ```dockerfile
    RUN apt-get update \\
        && apt-get install -y \\
            curl \\
            wget \\
        && rm -rf /var/lib/apt/lists/*
    ```
    Benefits: 1 layer, atomic operation, smaller image

    ### Complete FROM + RUN Example

    ```dockerfile
    # Start from Python slim base
    FROM python:3.11-slim

    # Install system dependencies in one layer
    RUN apt-get update \\
        && apt-get install -y --no-install-recommends \\
            gcc \\
            libpq-dev \\
        && rm -rf /var/lib/apt/lists/*

    # Install Python packages
    RUN pip install --no-cache-dir \\
            django==4.2 \\
            psycopg2-binary
    ```

    ### RUN Command Patterns

    **1. Package installation (Ubuntu/Debian):**
    ```dockerfile
    RUN apt-get update \\
        && apt-get install -y --no-install-recommends \\
            package1 \\
            package2 \\
        && rm -rf /var/lib/apt/lists/*
    ```

    **2. Package installation (Alpine):**
    ```dockerfile
    RUN apk add --no-cache \\
        package1 \\
        package2
    ```

    **3. Building from source:**
    ```dockerfile
    RUN wget https://example.com/app.tar.gz \\
        && tar -xzf app.tar.gz \\
        && cd app \\
        && ./configure \\
        && make \\
        && make install \\
        && cd .. \\
        && rm -rf app app.tar.gz
    ```

    ### Layer Caching (Critical!)

    Each `RUN` creates a layer. Docker caches layers:

    ```dockerfile
    FROM python:3.11-slim
    RUN apt-get update        # Layer 1 (cached)
    RUN pip install django    # Layer 2 (cached)
    COPY app.py /app/         # Layer 3 (rebuilds if app.py changes)
    ```

    If `app.py` changes, only Layer 3+ rebuilds. Layers 1-2 are cached!

    ### DCA Exam Focus

    **You must know:**
    1. FROM must be first instruction
    2. Combining RUN commands reduces layers
    3. Shell form vs exec form differences
    4. Cleaning up in same RUN layer (rm -rf)
    5. --no-cache-dir and --no-install-recommends flags

    ### Common Errors

    **"unable to prepare context"**
    - FROM references non-existent image
    - Check image exists on Docker Hub

    **"returned a non-zero code"**
    - Command in RUN failed
    - Check command syntax, availability

    ### Try it!

    Create a Dockerfile:
    ```dockerfile
    FROM alpine:3.18
    RUN apk add --no-cache curl
    RUN curl --version
    ```

    Build it:
    ```bash
    docker build -t test-from-run .
    ```

    Watch the layers being created!
  MD,

  command_to_learn: "FROM, RUN",
  command_variations: ["FROM image:tag", "RUN command", "RUN [\"cmd\", \"arg\"]"],
  practice_hints: [
    "FROM must be the first instruction",
    "Combine multiple RUN commands with && to reduce layers",
    "Clean up in the same RUN command (don't create temp files in one layer, delete in another)",
    "Use --no-cache flags to reduce image size"
  ]
})

# ==============================================================================
# CHAPTER 16: COPY and ADD - Adding Files to Images
# ==============================================================================

puts "\n📁 Chapter 16: COPY and ADD..."

update_chapter("codesprout-dockerfile-copy-add", {
  concept_explanation: <<~MD,
    **Dockerfile COPY and ADD Instructions** 📁

    COPY and ADD transfer files from your build context into the Docker image. Knowing the difference is crucial for the DCA exam!

    ### The COPY Instruction

    **COPY** copies files/directories from build context to the image.

    **Syntax:**
    ```dockerfile
    COPY [--chown=<user>:<group>] <src>... <dest>
    ```

    **Examples:**
    ```dockerfile
    # Copy single file
    COPY app.py /app/

    # Copy directory
    COPY ./src /app/src

    # Copy multiple files
    COPY file1.txt file2.txt /app/

    # Copy with ownership
    COPY --chown=www-data:www-data index.html /var/www/html/
    ```

    ### The ADD Instruction

    **ADD** is like COPY but with superpowers (which you often don't want!).

    **Syntax:**
    ```dockerfile
    ADD [--chown=<user>:<group>] <src>... <dest>
    ```

    **ADD can do 2 extra things:**

    **1. Download files from URLs:**
    ```dockerfile
    ADD https://example.com/file.tar.gz /tmp/
    ```

    **2. Auto-extract tar archives:**
    ```dockerfile
    ADD app.tar.gz /app/
    # Automatically extracts to /app/
    ```

    ### COPY vs ADD: When to Use What?

    **❌ DON'T use ADD unless you need its special features**

    **✅ PREFER COPY for clarity:**
    ```dockerfile
    # Clear and explicit
    COPY requirements.txt /app/
    COPY . /app/
    ```

    **✅ Use ADD only when needed:**
    ```dockerfile
    # Downloading from URL
    ADD https://github.com/user/repo/archive/v1.0.tar.gz /tmp/

    # Auto-extracting archives
    ADD myapp.tar.gz /opt/myapp/
    ```

    ### Common Patterns

    **Pattern 1: Copy application code**
    ```dockerfile
    FROM python:3.11-slim
    WORKDIR /app

    # Copy requirements first (for caching)
    COPY requirements.txt .
    RUN pip install -r requirements.txt

    # Copy code after (changes more often)
    COPY . .
    ```

    **Pattern 2: Copy with specific ownership**
    ```dockerfile
    FROM nginx:alpine

    # Copy with www-data ownership
    COPY --chown=www-data:www-data ./html /usr/share/nginx/html
    ```

    **Pattern 3: Copy from multiple sources**
    ```dockerfile
    FROM node:18
    WORKDIR /app

    COPY package*.json ./
    RUN npm install

    COPY src/ ./src/
    COPY public/ ./public/
    COPY config/ ./config/
    ```

    ### Build Context Matters!

    **The dot (.) in docker build:**
    ```bash
    docker build -t myapp .
    #                    ↑ This is the build context
    ```

    Only files in the build context can be copied:

    **Project structure:**
    ```
    myproject/
    ├── Dockerfile
    ├── app/
    │   ├── main.py
    │   └── utils.py
    └── ../other-project/
        └── lib.py  ← CANNOT access this!
    ```

    **In Dockerfile:**
    ```dockerfile
    COPY app/ /app/              # ✅ Works
    COPY ../other-project/ /     # ❌ ERROR: forbidden path
    ```

    ### Using .dockerignore

    Exclude files from build context:

    **`.dockerignore` file:**
    ```
    node_modules/
    .git/
    *.log
    .env
    __pycache__/
    *.pyc
    .DS_Store
    ```

    **Why this matters:**
    - Faster builds (less context to send to daemon)
    - Smaller images (won't accidentally copy junk)
    - Security (don't copy .env, .git)

    ### Caching Optimization

    **❌ BAD - Breaks cache on code change:**
    ```dockerfile
    COPY . /app/
    RUN pip install -r requirements.txt
    ```
    Problem: Every code change invalidates pip install cache

    **✅ GOOD - Dependencies cached separately:**
    ```dockerfile
    COPY requirements.txt /app/
    RUN pip install -r requirements.txt
    COPY . /app/
    ```
    Benefit: Code changes don't trigger pip install

    ### Complete Example

    ```dockerfile
    FROM node:18-alpine

    # Create app directory
    WORKDIR /usr/src/app

    # Copy package files (dependencies change less often)
    COPY package*.json ./

    # Install dependencies (cached if package.json unchanged)
    RUN npm install --production

    # Copy application code (changes frequently)
    COPY . .

    # Expose port
    EXPOSE 3000

    # Start app
    CMD ["node", "server.js"]
    ```

    ### ADD for Archives Example

    ```dockerfile
    FROM alpine:3.18

    # Download and extract in one instruction
    ADD https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz /tmp/

    # ADD auto-extracts local tar.gz
    ADD app-bundle.tar.gz /opt/app/

    RUN ls -la /opt/app/
    ```

    ### DCA Exam Focus

    **You must understand:**
    1. **COPY is preferred** over ADD for transparency
    2. **ADD auto-extracts** tar archives
    3. **ADD can download** from URLs
    4. **Build context** determines what can be copied
    5. **.dockerignore** excludes files from context
    6. **Copy order affects caching** (copy dependencies first!)

    ### Common Errors

    **"COPY failed: no source files"**
    - File doesn't exist in build context
    - Check path relative to Dockerfile location

    **"forbidden path outside the build context"**
    - Trying to copy from parent directory (../)
    - Solution: Run docker build from correct directory

    **Large image size**
    - Copied unnecessary files (node_modules, .git)
    - Solution: Use .dockerignore

    ### Best Practices

    **✅ DO:**
    ```dockerfile
    # Use COPY for simple file operations
    COPY src/ /app/src/

    # Copy dependencies before code
    COPY package.json /app/
    RUN npm install
    COPY . /app/

    # Use .dockerignore
    # (in .dockerignore file: node_modules/, .git/)
    ```

    **❌ DON'T:**
    ```dockerfile
    # Don't use ADD when COPY suffices
    ADD app.py /app/  # Use COPY instead

    # Don't copy everything first
    COPY . /app/      # Breaks dependency caching
    RUN npm install
    ```

    ### Try it!

    Create this structure:
    ```
    test-copy/
    ├── Dockerfile
    ├── .dockerignore
    ├── app.py
    └── secrets.txt
    ```

    **.dockerignore:**
    ```
    secrets.txt
    ```

    **Dockerfile:**
    ```dockerfile
    FROM python:3.11-slim
    COPY . /app/
    RUN ls -la /app/
    ```

    Build and notice secrets.txt is excluded!
  MD,

  command_to_learn: "COPY, ADD",
  command_variations: ["COPY src dest", "COPY --chown=user:group", "ADD url dest"],
  practice_hints: [
    "Prefer COPY over ADD for clarity",
    "ADD auto-extracts tar files and can download URLs",
    "Copy dependencies before code for better caching",
    "Use .dockerignore to exclude unnecessary files"
  ]
})

# ==============================================================================
# CHAPTER 17: ENV and ARG - Variables in Dockerfiles
# ==============================================================================

puts "\n⚙️  Chapter 17: ENV and ARG..."

update_chapter("codesprout-dockerfile-env-arg", {
  concept_explanation: <<~MD,
    **ENV and ARG: Build-time and Runtime Variables** ⚙️

    ENV and ARG let you parameterize Dockerfiles, but they work at different times. Understanding when to use each is critical for DCA!

    ### The ARG Instruction (Build-time only)

    **ARG** defines variables available ONLY during docker build.

    **Syntax:**
    ```dockerfile
    ARG <name>[=<default value>]
    ```

    **Example:**
    ```dockerfile
    ARG PYTHON_VERSION=3.11
    FROM python:${PYTHON_VERSION}-slim

    ARG APP_ENV=production
    RUN echo "Building for ${APP_ENV}"
    ```

    **Using ARG at build time:**
    ```bash
    docker build --build-arg PYTHON_VERSION=3.10 --build-arg APP_ENV=dev -t myapp .
    ```

    **Key Point:** ARG variables don't exist in the final container!

    ### The ENV Instruction (Runtime)

    **ENV** sets environment variables that persist in the image and running containers.

    **Syntax:**
    ```dockerfile
    ENV <key>=<value> [<key>=<value> ...]
    ```

    **Example:**
    ```dockerfile
    ENV NODE_ENV=production \\
        PORT=3000 \\
        APP_HOME=/usr/src/app
    ```

    **ENV variables are available:**
    - During build (in subsequent RUN commands)
    - In the final image
    - In running containers

    ### ARG vs ENV: The Critical Difference

    **Comparison:**
    ```dockerfile
    ARG BUILD_VERSION=1.0.0     # Available: Build only
    ENV APP_VERSION=1.0.0       # Available: Build + Runtime

    RUN echo $BUILD_VERSION     # ✅ Works
    RUN echo $APP_VERSION       # ✅ Works
    ```

    **At runtime:**
    ```bash
    docker run myapp env | grep VERSION
    # APP_VERSION=1.0.0    ✅ Present
    # BUILD_VERSION        ❌ Not present
    ```

    **DCA Exam Tip:** Know which persists into containers!

    ### Common Patterns

    **Pattern 1: Using ARG for FROM parameterization**
    ```dockerfile
    ARG BASE_IMAGE=python:3.11-slim
    FROM ${BASE_IMAGE}

    # Build with different bases:
    # docker build --build-arg BASE_IMAGE=python:3.10-alpine
    ```

    **Pattern 2: ARG to ENV conversion**
    ```dockerfile
    ARG VERSION=1.0.0
    ENV APP_VERSION=${VERSION}

    # Now VERSION available at runtime as APP_VERSION
    ```

    **Pattern 3: Multi-stage with ARG**
    ```dockerfile
    ARG NODE_VERSION=18
    FROM node:${NODE_VERSION} AS builder
    # ...build stage

    FROM nginx:alpine
    COPY --from=builder /app/dist /usr/share/nginx/html
    ```

    ### Complete Example

    ```dockerfile
    # Build-time argument with default
    ARG PYTHON_VERSION=3.11
    FROM python:${PYTHON_VERSION}-slim

    # Build arguments for configuration
    ARG APP_ENV=production
    ARG ENABLE_FEATURE_X=false

    # Convert to environment variables (persist to runtime)
    ENV ENVIRONMENT=${APP_ENV} \\
        FEATURE_X_ENABLED=${ENABLE_FEATURE_X}

    # Runtime environment variables
    ENV PYTHONUNBUFFERED=1 \\
        PORT=8000 \\
        WORKERS=4

    WORKDIR /app

    # ARG available in RUN
    RUN echo "Building for ${APP_ENV} environment"

    COPY requirements.txt .
    RUN pip install -r requirements.txt

    COPY . .

    # ENV used in CMD
    CMD python app.py --port ${PORT} --workers ${WORKERS}
    ```

    **Build with custom args:**
    ```bash
    docker build \\
      --build-arg PYTHON_VERSION=3.10 \\
      --build-arg APP_ENV=staging \\
      --build-arg ENABLE_FEATURE_X=true \\
      -t myapp:staging .
    ```

    ### Security Considerations

    **⚠️ ARG values can be seen:**
    ```bash
    docker history myapp
    # Shows all ARG values used in build!
    ```

    **❌ DON'T put secrets in ARG:**
    ```dockerfile
    ARG API_KEY=secret123  # ❌ Visible in image history!
    ```

    **✅ Use Docker secrets or ENV at runtime:**
    ```bash
    docker run -e API_KEY=secret123 myapp
    # Or use Docker secrets in Swarm
    ```

    ### ENV for PATH modification

    **Common pattern - adding to PATH:**
    ```dockerfile
    ENV PATH="/app/bin:${PATH}"

    # Now /app/bin is in PATH for build and runtime
    ```

    ### DCA Exam Focus

    **Must know:**
    1. ARG is **build-time only**, ENV persists to **runtime**
    2. ARG can be overridden with --build-arg
    3. ENV can be overridden with -e at runtime
    4. **Don't use ARG for secrets** (visible in history)
    5. ARG before FROM parameterizes the base image
    6. ENV affects PATH, variables available to CMD/ENTRYPOINT

    ### Try it!

    **Dockerfile:**
    ```dockerfile
    ARG BASE=alpine:3.18
    FROM ${BASE}

    ARG MESSAGE="Hello from build"
    ENV RUNTIME_MSG="Hello from runtime"

    RUN echo "ARG: ${MESSAGE}"
    RUN echo "ENV: ${RUNTIME_MSG}"

    CMD echo "At runtime, RUNTIME_MSG=${RUNTIME_MSG}"
    ```

    **Build and run:**
    ```bash
    docker build --build-arg MESSAGE="Custom build" -t test-vars .
    docker run test-vars
    # Only RUNTIME_MSG is available!
    ```
  MD,

  command_to_learn: "ENV, ARG",
  command_variations: ["ENV KEY=value", "ARG NAME=default", "--build-arg NAME=value"],
  practice_hints: [
    "ARG is build-time only, ENV persists to runtime",
    "Use --build-arg to override ARG values",
    "Use -e at runtime to override ENV values",
    "Don't put secrets in ARG (visible in image history)"
  ]
})

puts "\n✅ Chapters 15-17 enhanced!"
puts "=" * 100
puts "✅ ALL DOCKERFILE CHAPTERS 15-21 ENHANCED FOR DCA!"
puts "=" * 100


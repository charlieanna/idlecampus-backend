# Enhance Chapters 11-14 with DCA-Exam-Ready Content
# Image Creation Domain (20% of DCA exam)

puts "=" * 100
puts "ENHANCING CHAPTERS 11-14 FOR DCA CERTIFICATION"
puts "Image Creation, Management, and Registry (20%)"
puts "=" * 100

# ==============================================================================
# CHAPTER 11: docker pull - Downloading Images from Registry
# ==============================================================================

puts "\n📦 Updating Chapter 11: docker pull..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-docker-pull")
unit.update!(
  concept_explanation: <<~MD,
    **Downloading Images from Docker Hub** 🌐

    Before you can run a container, you need an image. The `docker pull` command downloads images from a registry (usually Docker Hub) to your local machine.

    ### Understanding Docker Registries

    **Docker Hub** = The default public registry (like GitHub for Docker images)
    - Hosts millions of public images
    - Official images (maintained by Docker and software vendors)
    - Community images (maintained by individuals)
    - Private registries also exist (AWS ECR, Google GCR, Harbor)

    ### The docker pull Command

    Basic syntax:
    ```bash
    docker pull [OPTIONS] NAME[:TAG]
    ```

    Example:
    ```bash
    docker pull nginx:alpine
    ```

    This downloads the `nginx` image with the `alpine` tag from Docker Hub.

    ### What Happens When You Pull?

    ```
    Using default tag: latest
    latest: Pulling from library/nginx
    a2abf6c4d29d: Pull complete  ← Layer 1
    a9edb18cadd1: Pull complete  ← Layer 2
    589b7251471a: Pull complete  ← Layer 3
    Digest: sha256:0d17b565c37bcbd895e9d92315a05c1c3c9a29f762b011a10c54a66cd53c9b31
    Status: Downloaded newer image for nginx:latest
    ```

    **What's happening:**
    1. Docker checks if you have the image locally
    2. If not, it contacts Docker Hub
    3. Downloads each **layer** of the image (layers are reusable components)
    4. Verifies the image using a cryptographic digest (SHA256)

    ### Understanding Image Layers

    Docker images are built in **layers**:
    - Each layer represents a change in the filesystem
    - Layers are **cached** and **reused** across images
    - If you pull `nginx:alpine` and later `nginx:1.25-alpine`, shared layers aren't re-downloaded

    **Example:**
    ```bash
    docker pull redis:alpine
    # Already has alpine base layers cached!
    # Only downloads Redis-specific layers
    ```

    **This makes Docker:**
    - **Fast**: Reuses cached layers
    - **Efficient**: Saves bandwidth and disk space

    ### Pulling Specific Versions

    **Always pull specific versions in production:**

    ```bash
    # ❌ BAD - latest might change
    docker pull nginx:latest

    # ✅ GOOD - locked to specific version
    docker pull nginx:1.25.3-alpine
    ```

    **Why?**
    - `latest` is just a tag - it can point to different versions over time
    - Pinning versions ensures reproducibility
    - Critical for DCA exam scenarios!

    ### Common Pull Patterns

    **1. Pull official image:**
    ```bash
    docker pull postgres:15-alpine
    ```

    **2. Pull from a specific registry:**
    ```bash
    docker pull myregistry.com:5000/myapp:v2.1
    ```

    **3. Pull all tags of an image (rarely used):**
    ```bash
    docker pull --all-tags nginx
    ```

    **4. Check for updates without downloading:**
    ```bash
    docker pull nginx:alpine
    # If you have it: "Image is up to date"
    # If there's an update: Downloads new layers
    ```

    ### DCA Exam Tips

    **Key concepts tested:**
    1. **Layer caching** - Understand how Docker reuses layers
    2. **Image digests** - SHA256 ensures image integrity
    3. **Registry URLs** - Know how to pull from different registries
    4. **Tag strategies** - latest vs. versioned tags
    5. **Pull policies** - When images are re-downloaded

    ### Common Issues

    **Problem: "Error response from daemon: pull access denied"**
    - Solution: Image is private, use `docker login` first

    **Problem: Slow pull speeds**
    - Solution: Use a closer registry mirror or private registry

    **Problem: "manifest unknown"**
    - Solution: Tag doesn't exist, check available tags on Docker Hub

    ### Try it!

    Pull a small image and watch the layers download:
    ```bash
    docker pull alpine:3.18
    ```

    Then pull a related image and see the layer caching in action:
    ```bash
    docker pull alpine:3.19
    ```

    Notice how some layers show "Already exists"? That's Docker's layer caching!
  MD

  command_to_learn: "docker pull",
  command_variations: ["docker pull nginx", "docker pull nginx:alpine", "docker image pull"],
  practice_hints: [
    "Pull a specific version, not 'latest'",
    "Watch for layer caching - layers marked 'Already exists' are reused",
    "The digest (SHA256) ensures image integrity",
    "Official images don't need a username prefix"
  ],
  scenario_narrative: <<~MD,
    **Setting Up the Development Environment**

    "Our team uses nginx as a reverse proxy. Before we can run it, we need to download the image.
    Pull the nginx:alpine image - it's a lightweight version perfect for our setup."
  MD

  problem_statement: "Download the nginx:alpine image from Docker Hub to your local machine"
)

puts "✅ Chapter 11 enhanced with DCA-level content"

# ==============================================================================
# CHAPTER 12: docker build - Building Images from Dockerfiles
# ==============================================================================

puts "\n🏗️  Updating Chapter 12: docker build..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-docker-build-basics")
unit.update!(
  concept_explanation: <<~MD,
    **Building Your First Docker Image** 🏗️

    While pulling existing images is useful, the real power of Docker comes from **building your own custom images** using a Dockerfile.

    ### What is a Dockerfile?

    **Dockerfile** = A text file with instructions for building a Docker image
    - Like a recipe that tells Docker how to create your image
    - Each instruction creates a new **layer** in the image
    - Dockerfiles are version-controlled with your code

    **Simple example:**
    ```dockerfile
    FROM nginx:alpine
    COPY index.html /usr/share/nginx/html/
    ```

    This creates a custom nginx image with your HTML file baked in.

    ### The docker build Command

    Basic syntax:
    ```bash
    docker build [OPTIONS] PATH
    ```

    Most common usage:
    ```bash
    docker build -t myapp:v1 .
    ```

    **What this does:**
    - `-t myapp:v1` = Tags the image as "myapp" with version "v1"
    - `.` = Build context (current directory)

    ### Understanding Build Context

    The **build context** is the directory Docker uses to build the image:
    - All files in this directory are sent to the Docker daemon
    - Referenced by `COPY` and `ADD` instructions
    - Use `.dockerignore` to exclude unnecessary files

    **Example:**
    ```
    myapp/
    ├── Dockerfile
    ├── app.py
    ├── requirements.txt
    └── .dockerignore
    ```

    When you run `docker build .` in `myapp/`, Docker sends all these files to the daemon.

    ### How Docker Build Works

    Watch a build in action:
    ```bash
    $ docker build -t myapp .

    [1/3] FROM nginx:alpine
    ← Uses cached layer if you have nginx:alpine

    [2/3] COPY index.html /usr/share/nginx/html/
    ← Creates new layer with your file

    [3/3] Successfully built abc123def456
    Successfully tagged myapp:latest
    ```

    **Each instruction = One layer**

    ### Build Caching (Critical for DCA!)

    Docker caches layers to speed up builds:

    **First build:**
    ```
    [1/4] FROM python:3.11-slim      ← Downloads
    [2/4] COPY requirements.txt .    ← New layer
    [3/4] RUN pip install -r ...     ← Installs packages (slow)
    [4/4] COPY . /app                ← Copies code
    ```

    **Second build (only code changed):**
    ```
    [1/4] FROM python:3.11-slim      ← CACHED
    [2/4] COPY requirements.txt .    ← CACHED
    [3/4] RUN pip install -r ...     ← CACHED
    [4/4] COPY . /app                ← NEW (code changed)
    ```

    **Optimization tip:** Put frequently changing files (like code) at the END of your Dockerfile!

    ### Common Build Options

    **1. Tag with name and version:**
    ```bash
    docker build -t myapp:v1.2.0 .
    ```

    **2. Build without cache (force fresh build):**
    ```bash
    docker build --no-cache -t myapp .
    ```

    **3. Specify a different Dockerfile:**
    ```bash
    docker build -f Dockerfile.prod -t myapp:prod .
    ```

    **4. Set build arguments:**
    ```bash
    docker build --build-arg VERSION=1.2.0 -t myapp .
    ```

    **5. Target a specific stage (multi-stage builds):**
    ```bash
    docker build --target production -t myapp:prod .
    ```

    ### A Complete Example

    **Dockerfile:**
    ```dockerfile
    # Start from official Python image
    FROM python:3.11-slim

    # Set working directory
    WORKDIR /app

    # Copy requirements first (for caching)
    COPY requirements.txt .

    # Install dependencies
    RUN pip install --no-cache-dir -r requirements.txt

    # Copy application code
    COPY . .

    # Expose port
    EXPOSE 8000

    # Run the application
    CMD ["python", "app.py"]
    ```

    **Build it:**
    ```bash
    docker build -t my-python-app:1.0 .
    ```

    **Run it:**
    ```bash
    docker run -p 8000:8000 my-python-app:1.0
    ```

    ### DCA Exam Focus Areas

    **You MUST know:**
    1. **Dockerfile syntax** - FROM, RUN, COPY, CMD, ENTRYPOINT
    2. **Build context** - What gets sent to the daemon
    3. **Layer caching** - How to optimize build times
    4. **Tagging** - Naming and versioning images
    5. **.dockerignore** - Excluding files from build context
    6. **Multi-stage builds** - Creating smaller production images (covered in Ch 20)

    ### Best Practices

    **❌ BAD:**
    ```dockerfile
    FROM ubuntu
    RUN apt-get update
    RUN apt-get install -y python3
    RUN apt-get install -y pip
    COPY . .
    ```
    - Multiple RUN commands create unnecessary layers
    - Doesn't use specific versions
    - Large base image

    **✅ GOOD:**
    ```dockerfile
    FROM python:3.11-slim
    WORKDIR /app
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt
    COPY . .
    ```
    - Uses official, minimal base image
    - Combines related commands
    - Optimizes layer caching

    ### Common Errors

    **Error: "COPY failed: no source files"**
    - Solution: File doesn't exist in build context, check your path

    **Error: "Cannot locate specified Dockerfile"**
    - Solution: Dockerfile must be in build context or specify with `-f`

    **Slow builds?**
    - Solution: Use `.dockerignore` to exclude node_modules, .git, etc.

    ### Try it!

    Create a simple Dockerfile and build it:
    ```dockerfile
    FROM alpine:latest
    RUN echo "Hello from my custom image!"
    CMD ["sh"]
    ```

    Build and run:
    ```bash
    docker build -t my-first-image .
    docker run -it my-first-image
    ```
  MD

  command_to_learn: "docker build",
  command_variations: ["docker build -t name .", "docker build --no-cache", "docker build -f Dockerfile.prod"],
  practice_hints: [
    "The dot (.) at the end specifies the build context",
    "Use -t to tag your image with a name",
    "Watch which layers are cached vs. rebuilt",
    "Put frequently changing files at the END for better caching"
  ],
  scenario_narrative: <<~MD,
    **Containerizing the CodeSprout Application**

    "We need to package our Python web application in a Docker image. Create a Dockerfile that:
    1. Uses python:3.11-slim as the base
    2. Installs dependencies from requirements.txt
    3. Copies the application code
    4. Exposes port 8000"
  MD

  problem_statement: "Build a Docker image from a Dockerfile using the docker build command"
)

puts "✅ Chapter 12 enhanced with DCA-level content"

# ==============================================================================
# CHAPTER 13: docker tag - Tagging Images for Organization
# ==============================================================================

puts "\n🏷️  Updating Chapter 13: docker tag..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-docker-tag")
unit.update!(
  concept_explanation: <<~MD,
    **Image Tagging and Version Management** 🏷️

    Tags are Docker's way of versioning and organizing images. Understanding tagging is **critical** for the DCA exam and real-world Docker usage.

    ### What is an Image Tag?

    A **tag** is a label you attach to an image to identify a specific version or variant.

    **Format:**
    ```
    [registry/][username/]repository:tag
    ```

    **Examples:**
    ```
    nginx:alpine          ← Official image, alpine variant
    myuser/myapp:v1.2.0   ← User image, version 1.2.0
    registry.company.com:5000/api:latest  ← Private registry
    ```

    ### The docker tag Command

    **Syntax:**
    ```bash
    docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
    ```

    **Example:**
    ```bash
    docker tag myapp:latest myapp:v1.0.0
    ```

    **This creates a NEW TAG pointing to the SAME image** (doesn't copy the image, just creates another reference)

    ### Why Tagging Matters

    **Without proper tagging:**
    ```bash
    docker build -t myapp .
    # Creates: myapp:latest (what version is this?)
    ```

    **With proper tagging:**
    ```bash
    docker build -t myapp:v1.2.3 .
    docker tag myapp:v1.2.3 myapp:v1.2
    docker tag myapp:v1.2.3 myapp:v1
    docker tag myapp:v1.2.3 myapp:latest
    ```

    Now you have:
    - `myapp:v1.2.3` ← Most specific
    - `myapp:v1.2` ← Minor version
    - `myapp:v1` ← Major version
    - `myapp:latest` ← Latest stable

    Users can pin to specific versions or track latest automatically!

    ### Tag Naming Strategies

    **1. Semantic Versioning (Best for Applications)**
    ```bash
    myapp:1.0.0      # Initial release
    myapp:1.0.1      # Bug fix
    myapp:1.1.0      # New feature (backwards compatible)
    myapp:2.0.0      # Breaking changes
    ```

    **2. Git-based Tags**
    ```bash
    myapp:main              # Latest from main branch
    myapp:develop           # Development branch
    myapp:abc123            # Git commit SHA
    myapp:feature-login     # Feature branch
    ```

    **3. Environment-based Tags**
    ```bash
    myapp:staging
    myapp:production
    myapp:dev
    ```

    **4. Variant Tags**
    ```bash
    nginx:alpine       # Alpine Linux base
    nginx:bullseye     # Debian Bullseye base
    python:3.11-slim   # Slim variant
    ```

    ### The 'latest' Tag Myth

    **⚠️ Common Misconception:** "`latest` is always the newest image"

    **Reality:** `latest` is just a tag name - it means **nothing special** to Docker!

    ```bash
    # Building version 2.0.0
    docker build -t myapp:2.0.0 .
    # latest still points to 1.0.0!

    # You must manually update latest:
    docker tag myapp:2.0.0 myapp:latest
    ```

    **DCA Exam Alert:** You WILL be tested on this!

    ### Tagging for Different Registries

    **Local image:**
    ```bash
    myapp:v1.0.0
    ```

    **Docker Hub:**
    ```bash
    docker tag myapp:v1.0.0 username/myapp:v1.0.0
    ```

    **Private Registry:**
    ```bash
    docker tag myapp:v1.0.0 registry.company.com:5000/myapp:v1.0.0
    ```

    **AWS ECR:**
    ```bash
    docker tag myapp:v1.0.0 123456789.dkr.ecr.us-west-2.amazonaws.com/myapp:v1.0.0
    ```

    ### Common Tagging Workflows

    **After building an image:**
    ```bash
    # Build with specific version
    docker build -t myapp:v1.2.0 .

    # Tag for Docker Hub
    docker tag myapp:v1.2.0 username/myapp:v1.2.0
    docker tag myapp:v1.2.0 username/myapp:latest

    # Push to Docker Hub
    docker push username/myapp:v1.2.0
    docker push username/myapp:latest
    ```

    **Creating multiple aliases:**
    ```bash
    # All these point to the SAME image:
    docker tag myapp:v1.2.3 myapp:v1.2
    docker tag myapp:v1.2.3 myapp:v1
    docker tag myapp:v1.2.3 myapp:stable
    docker tag myapp:v1.2.3 myapp:latest

    # Only one copy of the image exists!
    # Tags are just pointers
    ```

    ### Viewing Image Tags

    ```bash
    docker images myapp

    REPOSITORY   TAG      IMAGE ID      SIZE
    myapp        v1.2.3   abc123def     150MB
    myapp        v1.2     abc123def     150MB  ← Same image ID!
    myapp        v1       abc123def     150MB  ← Same image ID!
    myapp        latest   abc123def     150MB  ← Same image ID!
    ```

    Notice they all share the same `IMAGE ID` - they're the same image!

    ### Best Practices for Production

    **❌ DON'T:**
    ```bash
    docker run myapp:latest  # What version is running?
    ```

    **✅ DO:**
    ```bash
    docker run myapp:v1.2.3  # Explicit, reproducible
    ```

    **Why?**
    - `latest` can change between pulls
    - Production needs **reproducibility**
    - Rollbacks are easier with explicit versions

    ### DCA Exam Key Points

    **You must understand:**
    1. Tags are **labels**, not copies
    2. `latest` is **not** automatically maintained
    3. **Same image** can have multiple tags
    4. Tag format: `[registry/][user/]repo:tag`
    5. **Before pushing**, tag with registry path

    ### Common Issues

    **"Image not found when pulling"**
    - Check the tag exists: `docker pull username/myapp:v1.2.3`
    - Typo in tag name

    **"Denied: requested access to resource is denied"**
    - Need to tag with your username for Docker Hub
    - Need authentication: `docker login`

    ### Try it!

    Practice tagging an image multiple ways:
    ```bash
    # Build an image
    docker build -t testapp .

    # Create multiple tags
    docker tag testapp testapp:v1.0.0
    docker tag testapp testapp:stable
    docker tag testapp testapp:latest

    # View all tags (same IMAGE ID)
    docker images testapp
    ```
  MD

  command_to_learn: "docker tag",
  command_variations: ["docker tag myapp:latest myapp:v1.0", "docker tag SOURCE TARGET"],
  practice_hints: [
    "Tags are pointers to images, not copies",
    "'latest' is just a tag name - nothing special to Docker",
    "Before pushing to a registry, tag with the registry path",
    "Check IMAGE ID to see if tags point to the same image"
  ],
  scenario_narrative: <<~MD,
    **Preparing for Production Deployment**

    "We've built our application image locally as 'myapp'. Before pushing to Docker Hub,
    we need to:
    1. Tag it with version v1.0.0
    2. Tag it with your Docker Hub username
    3. Also tag it as 'latest'

    This ensures proper versioning and makes it available in our registry."
  MD

  problem_statement: "Tag a local image with multiple tags for versioning and registry publishing"
)

puts "✅ Chapter 13 enhanced with DCA-level content"

# ==============================================================================
# CHAPTER 14: docker push - Publishing Images to Registry
# ==============================================================================

puts "\n📤 Updating Chapter 14: docker push..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-docker-push")
unit.update!(
  concept_explanation: <<~MD,
    **Publishing Images to Docker Hub** 📤

    The final step in the image workflow is **pushing** your image to a registry so others (or other servers) can use it.

    ### What is docker push?

    `docker push` uploads your local image to a registry (Docker Hub, private registry, etc.).

    **Syntax:**
    ```bash
    docker push [OPTIONS] NAME[:TAG]
    ```

    **Example:**
    ```bash
    docker push username/myapp:v1.0.0
    ```

    ### The Complete Workflow

    **1. Build the image:**
    ```bash
    docker build -t myapp:v1.0.0 .
    ```

    **2. Tag for Docker Hub:**
    ```bash
    docker tag myapp:v1.0.0 username/myapp:v1.0.0
    ```

    **3. Login to Docker Hub:**
    ```bash
    docker login
    # Enter username and password
    ```

    **4. Push the image:**
    ```bash
    docker push username/myapp:v1.0.0
    ```

    **5. Others can now pull it:**
    ```bash
    docker pull username/myapp:v1.0.0
    ```

    ### Understanding docker login

    Before pushing, you must authenticate:

    ```bash
    $ docker login
    Username: your-username
    Password: ***********
    Login Succeeded
    ```

    **Credentials are stored** (securely) for future pushes.

    **Logout when done:**
    ```bash
    docker logout
    ```

    ### What Happens During a Push?

    ```bash
    $ docker push username/myapp:v1.0.0

    The push refers to repository [docker.io/username/myapp]
    5f70bf18a086: Pushed  ← Layer 1
    d2c3f3eeb3f5: Pushed  ← Layer 2
    1ab2c3d4e5f6: Pushed  ← Layer 3
    v1.0.0: digest: sha256:abc123... size: 1234
    ```

    **Docker pushes layers:**
    - Each layer is uploaded separately
    - If a layer already exists on the registry (from another image), it's **skipped**!
    - This saves bandwidth and time

    ### Pushing Multiple Tags

    **Push specific version:**
    ```bash
    docker push username/myapp:v1.0.0
    ```

    **Also push 'latest':**
    ```bash
    docker push username/myapp:latest
    ```

    **Push all tags of an image:**
    ```bash
    docker push username/myapp --all-tags
    ```

    ### Registry Types

    **1. Docker Hub (Default)**
    ```bash
    docker push username/myapp:v1.0.0
    # Goes to: hub.docker.com/r/username/myapp
    ```

    **2. Private Registry**
    ```bash
    docker push registry.company.com:5000/myapp:v1.0.0
    ```

    **3. AWS Elastic Container Registry (ECR)**
    ```bash
    # Login to ECR
    aws ecr get-login-password --region us-west-2 | \\
      docker login --username AWS --password-stdin \\
      123456789.dkr.ecr.us-west-2.amazonaws.com

    # Push
    docker push 123456789.dkr.ecr.us-west-2.amazonaws.com/myapp:v1.0.0
    ```

    **4. Google Container Registry (GCR)**
    ```bash
    docker push gcr.io/project-id/myapp:v1.0.0
    ```

    ### Common Push Workflow

    **Full CI/CD pipeline example:**
    ```bash
    # Build
    docker build -t myapp:${GIT_COMMIT} .

    # Tag with version and latest
    docker tag myapp:${GIT_COMMIT} username/myapp:${VERSION}
    docker tag myapp:${GIT_COMMIT} username/myapp:latest

    # Push both tags
    docker push username/myapp:${VERSION}
    docker push username/myapp:latest
    ```

    ### Layer Deduplication in Action

    **First push of nginx-based app:**
    ```bash
    $ docker push username/app1:v1
    5f70bf18a086: Pushed        ← Nginx base layers
    d2c3f3eeb3f5: Pushed        ← Your app layer
    ```

    **Second push of another nginx-based app:**
    ```bash
    $ docker push username/app2:v1
    5f70bf18a086: Layer already exists  ← Skipped!
    9a8b7c6d5e4f: Pushed                ← Only new layers pushed
    ```

    **This is why Docker is efficient!**

    ### Security Considerations

    **Private vs Public Images:**

    **Public** (anyone can pull):
    ```bash
    docker push username/myapp:v1.0.0
    # Available at: hub.docker.com/r/username/myapp
    ```

    **Private** (requires authentication):
    - Create private repository on Docker Hub first
    - Push as normal
    - Others need `docker login` to pull

    **Never push images containing:**
    - ❌ Secrets (API keys, passwords)
    - ❌ Private keys
    - ❌ Sensitive data
    - ❌ Development/debug tools in production images

    ### Image Size Matters

    **Check image size before pushing:**
    ```bash
    docker images myapp

    REPOSITORY   TAG      SIZE
    myapp        v1.0.0   850MB  ← Too big!
    ```

    **Optimize using:**
    - Multi-stage builds (Chapter 20)
    - Alpine base images
    - `.dockerignore`
    - Minimal dependencies

    **After optimization:**
    ```bash
    myapp        v1.0.0   45MB   ← Much better!
    ```

    ### DCA Exam Focus

    **You must know:**
    1. **Before pushing**, tag with username/registry
    2. **docker login** required for authentication
    3. **Layers are deduplicated** across images
    4. **Registry URL** format for different registries
    5. **Public vs private** repositories
    6. **Digest (SHA256)** ensures image integrity

    ### Common Errors

    **"denied: requested access to the resource is denied"**
    - Forgot to `docker login`
    - Image name doesn't match your username
    - Solution: Tag as `username/imagename`

    **"error parsing HTTP 408 response body"**
    - Network timeout during push
    - Solution: Retry or check internet connection

    **"name unknown: repository not found"**
    - Repository doesn't exist (for private registries)
    - Solution: Create repository first

    ### Best Practices

    **✅ DO:**
    ```bash
    # Tag with specific version
    docker tag myapp:v1.2.3 username/myapp:v1.2.3

    # Push the version
    docker push username/myapp:v1.2.3

    # Also update latest
    docker tag myapp:v1.2.3 username/myapp:latest
    docker push username/myapp:latest
    ```

    **❌ DON'T:**
    ```bash
    # Don't rely only on latest
    docker push myapp:latest  # What version is this?

    # Don't forget to tag with username
    docker push myapp  # ERROR: Must be username/myapp
    ```

    ### Try it!

    **Complete the full workflow:**
    ```bash
    # 1. Build
    docker build -t testpush:v1.0.0 .

    # 2. Tag for Docker Hub (replace 'yourusername')
    docker tag testpush:v1.0.0 yourusername/testpush:v1.0.0

    # 3. Login
    docker login

    # 4. Push
    docker push yourusername/testpush:v1.0.0

    # 5. Verify on Docker Hub:
    # Visit: hub.docker.com/r/yourusername/testpush
    ```

    **Congratulations!** You've completed the full Docker image lifecycle:
    - ✅ Pull (Ch 11)
    - ✅ Build (Ch 12)
    - ✅ Tag (Ch 13)
    - ✅ Push (Ch 14)

    You're ready for **Lab 1: Container Lifecycle Mastery!**
  MD

  command_to_learn: "docker push",
  command_variations: ["docker push username/image:tag", "docker push --all-tags"],
  practice_hints: [
    "Must tag image with username before pushing to Docker Hub",
    "docker login required first",
    "Layers already on registry are skipped (efficient!)",
    "Check image exists on Docker Hub after pushing"
  ],
  scenario_narrative: <<~MD,
    **Sharing with the Team**

    "Great! Our application image is built and tagged. Now let's push it to Docker Hub
    so the deployment team can pull it to production servers.

    Remember:
    1. Login to Docker Hub first
    2. Push the versioned tag (v1.0.0)
    3. Also push the 'latest' tag"
  MD

  problem_statement: "Push a locally built and tagged image to Docker Hub so others can use it"
)

puts "✅ Chapter 14 enhanced with DCA-level content"

puts "\n" + "=" * 100
puts "✅ ALL CHAPTERS 11-14 ENHANCED FOR DCA!"
puts "Image Creation Domain (20%) Complete"
puts "=" * 100

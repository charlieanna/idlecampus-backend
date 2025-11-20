# AUTO-GENERATED from docker_images_units.rb
puts "Creating Microlessons for Docker Images..."

module_var = CourseModule.find_by(slug: 'docker-images')

# === MICROLESSON 1: Docker Build: Building Images from Dockerfile ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Build: Building Images from Dockerfile',
  content: <<~MARKDOWN,
# Docker Build: Building Images from Dockerfile 🚀

# Mastering docker build: Creating Custom Docker Images

    ## What is docker build?
    `docker build` creates Docker images from a Dockerfile and a build context. This is how you package your applications into portable, reproducible containers - transforming source code and dependencies into ready-to-run images.

    ## Why Building Images Matters
    - **Customization**: Create images tailored to your application needs
    - **Reproducibility**: Same Dockerfile produces identical images everywhere
    - **Version Control**: Track image changes through Dockerfile history
    - **Automation**: Integrate into CI/CD pipelines for automated builds
    - **Efficiency**: Layer caching speeds up repeated builds

    ## Basic Syntax
    ```bash
    docker build [OPTIONS] PATH | URL | -
    ```

    ## Common Use Cases

    ### 1. Basic Build from Current Directory
    ```bash
    docker build .
    ```
    Builds image using Dockerfile in current directory.

    ### 2. Build and Tag Image
    ```bash
    docker build -t myapp:1.0 .
    ```
    Creates image with name and version tag.

    ### 3. Build with Custom Dockerfile
    ```bash
    docker build -f Dockerfile.prod -t myapp:prod .
    ```
    Uses different Dockerfile for production builds.

    ### 4. Build with Build Arguments
    ```bash
    docker build --build-arg NODE_VERSION=14 -t myapp .
    ```
    Passes variables to Dockerfile during build.

    ## How Docker Build Works

    ```
    1. Read Dockerfile
       ↓
    2. Send build context to Docker daemon
       ↓
    3. Execute each instruction sequentially
       ↓
    4. Create layer for each instruction
       ↓
    5. Cache layers for reuse
       ↓
    6. Tag final image
       ↓
    7. Return image ID
    ```

    ## Build Context Explained

    The build context is the set of files Docker can access during build:
    ```bash
    docker build .
                 └─ Build context (current directory)
    ```

    **Important**: Large contexts slow builds. Use `.dockerignore` to exclude files!

    ## Layer Caching

    Docker caches each layer. If nothing changes, cached layer is reused:
    ```
    Step 1/5 : FROM node:14        ← Using cache
    Step 2/5 : COPY package.json   ← Using cache
    Step 3/5 : RUN npm install     ← Using cache
    Step 4/5 : COPY . .            ← Changed! Rebuild from here
    Step 5/5 : CMD ["node", "app"] ← Rebuild
    ```

    ## Essential Build Options

    | Option | Description | Example |
    |--------|-------------|---------|
    | `-t` | Tag image with name:version | `docker build -t app:1.0 .` |
    | `-f` | Specify Dockerfile path | `docker build -f custom.Dockerfile .` |
    | `--build-arg` | Set build-time variables | `docker build --build-arg VERSION=1.0 .` |
    | `--no-cache` | Build without using cache | `docker build --no-cache .` |
    | `--target` | Build specific stage in multi-stage | `docker build --target production .` |

    ## Multi-Stage Builds

    Build multiple images in one Dockerfile:
    ```dockerfile
    # Build stage
    FROM node:14 AS builder
    COPY . .
    RUN npm install && npm run build

    # Production stage
    FROM node:14-alpine
    COPY --from=builder /app/dist /app
    CMD ["node", "app"]
    ```

    Build specific stage:
    ```bash
    docker build --target builder -t myapp:build .
    ```

    ## Common Mistakes to Avoid

    1. **Large build context**: Sending unnecessary files slows builds
    2. **No .dockerignore**: Including node_modules, .git, etc.
    3. **Poor layer ordering**: Put frequently changing layers last
    4. **Not using cache wisely**: Copy package.json before source code
    5. **Running as root**: Always specify USER in Dockerfile

    ## Optimizing Build Performance

    ### Bad Layer Order
    ```dockerfile
    FROM node:14
    COPY . .              ← Changes often, invalidates cache
    RUN npm install       ← Reinstalls every time
    ```

    ### Good Layer Order
    ```dockerfile
    FROM node:14
    COPY package*.json ./ ← Rarely changes
    RUN npm install       ← Cached until package.json changes
    COPY . .              ← Source changes don't affect npm install
    ```

    ## .dockerignore File

    Exclude files from build context:
    ```
    node_modules
    .git
    .env
    *.log
    .DS_Store
    README.md
    ```

    ## Build Arguments vs Environment Variables

    **Build Arguments (--build-arg)**
    - Available only during build
    - Set with ARG in Dockerfile
    - Example: versions, build modes

    **Environment Variables (ENV)**
    - Available at runtime
    - Set with ENV in Dockerfile
    - Example: API URLs, ports

    ## Practical Build Patterns

    ### Development Build
    ```bash
    docker build -t myapp:dev --target development .
    ```

    ### Production Build with Version
    ```bash
    docker build -t myapp:1.0.3 -t myapp:latest .
    ```

    ### Build with Secrets (BuildKit)
    ```bash
    DOCKER_BUILDKIT=1 docker build --secret id=npmrc,src=$HOME/.npmrc .
    ```

    ## Troubleshooting Builds

    ### Build Fails Midway
    ```bash
    # Check intermediate containers
    docker ps -a
    
    # Debug failed layer
    docker run -it <intermediate-container-id> sh
    ```

    ### Clear Build Cache
    ```bash
    docker builder prune
    ```

    ### Verbose Build Output
    ```bash
    docker build --progress=plain --no-cache .
    ```

    ## Pro Tips

    1. **Use specific base image tags**: `node:14.17-alpine` not `node:latest`
    2. **Leverage multi-stage builds**: Smaller production images
    3. **Order layers by change frequency**: Least to most frequent
    4. **Use .dockerignore**: Essential for large projects
    5. **Enable BuildKit**: `export DOCKER_BUILDKIT=1` for better performance
    6. **Tag semantic versions**: `app:1.0.0`, `app:1.0`, `app:latest`

    ## When to Use docker build

    - Creating custom application images
    - Packaging microservices
    - Building CI/CD pipeline artifacts
    - Creating development environments
    - Preparing deployment artifacts

## Syntax/Command

```bash
docker build -t myapp:1.0 .
```

## Example

```bash
docker build .
```

## Key Points

- Basic build: docker build .

- Tag image: docker build -t myapp:1.0 .

- Custom Dockerfile: docker build -f Dockerfile.prod .
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 1.1: Terminal
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker build -t myapp:1.0 .',
    description: 'Build a Docker image from Dockerfile, tag it as api-server:1.0, and pass API_ENV=production as build argument',
    difficulty: 'easy',
    hints: ['Basic build: docker build .', 'Tag image: docker build -t myapp:1.0 .', 'Custom Dockerfile: docker build -f Dockerfile.prod .']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker build -t myapp:1.0 .',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does the dot (.) represent in "docker build -t myapp ."?',
    options: ['The build context (current directory)', 'The Dockerfile name', 'The output directory', 'The cache location'],
    correct_answer: 0,
    explanation: 'Review the concept explanation above.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 2: Docker Images: List Local Images ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Images: List Local Images',
  content: <<~MARKDOWN,
# Docker Images: List Local Images 🚀

# Understanding docker images: Your Local Image Repository

    ## What is docker images?
    `docker images` displays all Docker images stored locally on your system. It's your inventory management tool for tracking downloaded and built images, their sizes, and when they were created.

    ## Why Image Management Matters
    - **Disk Space**: Images can consume significant storage
    - **Version Tracking**: See which versions you have locally
    - **Cleanup Planning**: Identify old or unused images
    - **Build Verification**: Confirm images were created successfully

    ## Common Use Cases

    ### 1. List All Images
    ```bash
    docker images
    ```
    Shows all locally available images.

    ### 2. List Images for Specific Repository
    ```bash
    docker images nginx
    ```
    Shows only nginx images with different tags.

    ### 3. Show Image IDs Only
    ```bash
    docker images -q
    ```
    Returns just image IDs for scripting.

    ### 4. Show All Including Intermediates
    ```bash
    docker images -a
    ```
    Includes intermediate layers used during builds.

    ## Output Columns Explained

    ```
    REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
    nginx         alpine    ae2feff98a0c   2 weeks ago    23.4MB
    myapp         1.0       f6d82d3d3a1b   1 hour ago     156MB
    ```

    - **REPOSITORY**: Image name (e.g., nginx, myapp)
    - **TAG**: Version/variant (e.g., latest, 1.0, alpine)
    - **IMAGE ID**: Unique identifier (first 12 chars of SHA256)
    - **CREATED**: When image was built or pulled
    - **SIZE**: Disk space consumed

    ## Understanding Image Tags

    Same image can have multiple tags:
    ```bash
    myapp    1.0      abc123...   1 hour ago   156MB
    myapp    latest   abc123...   1 hour ago   156MB
    ```
    Both tags point to the same image ID!

    ## Dangling Images

    Untagged images from failed builds or replaced tags:
    ```bash
    <none>   <none>   def456...   3 days ago   200MB
    ```

    View only dangling images:
    ```bash
    docker images -f dangling=true
    ```

    ## Common Patterns

    ### Find Large Images
    ```bash
    docker images --format "{{.Size}}\t{{.Repository}}:{{.Tag}}" | sort -h
    ```

    ### List Images by Date
    ```bash
    docker images --format "{{.CreatedAt}}\t{{.Repository}}:{{.Tag}}"
    ```

    ### Count Total Images
    ```bash
    docker images | wc -l
    ```

    ## Pro Tips

    1. Use `-q` flag for piping to other commands
    2. Filter by repository name to find specific images
    3. Check dangling images regularly for cleanup
    4. Use `--format` for custom output in scripts
    5. Sort by size to find storage hogs

## Syntax/Command

```bash
docker images
```

## Example

```bash
docker images -a
```

## Key Points

- List all images: docker images

- Only IDs: docker images -q

- Specific repo: docker images <name>
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['images', 'docker-images', 'listing', 'inventory', 'management'],
  prerequisite_ids: []
)

# Exercise 2.1: Terminal
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker images',
    description: 'Display all locally stored Docker images and their sizes',
    difficulty: 'easy',
    hints: ['List all images: docker images', 'Only IDs: docker images -q', 'Specific repo: docker images <name>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker images',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 2.2: MCQ
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does it mean when two images have the same IMAGE ID?',
    options: ['They are the same image with different tags', 'It is an error condition', 'They are duplicates wasting space', 'They have the same size'],
    correct_answer: 0,
    explanation: 'Multiple tags can point to the same image. For example, myapp:1.0 and myapp:latest can share the same IMAGE ID, using no extra disk space.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 3: Docker Pull: Download Images from Registry ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Pull: Download Images from Registry',
  content: <<~MARKDOWN,
# Docker Pull: Download Images from Registry 🚀

# Mastering docker pull: Downloading Images from Registries

    ## What is docker pull?
    `docker pull` downloads Docker images from a registry (like Docker Hub) to your local system. It's how you get pre-built images for databases, web servers, programming languages, and other services.

    ## Why Pulling Images Matters
    - **Quick Start**: Use production-ready software instantly
    - **Consistency**: Same image across development, staging, production
    - **Updates**: Get security patches and new versions
    - **Base Images**: Foundation for building custom images

    ## Basic Syntax
    ```bash
    docker pull [OPTIONS] NAME[:TAG|@DIGEST]
    ```

    ## Common Use Cases

    ### 1. Pull Latest Version
    ```bash
    docker pull nginx
    ```
    Downloads nginx:latest (default tag).

    ### 2. Pull Specific Version
    ```bash
    docker pull nginx:1.21-alpine
    ```
    Downloads exact version for reproducibility.

    ### 3. Pull from Private Registry
    ```bash
    docker pull myregistry.com/myapp:1.0
    ```
    Pulls from custom registry (requires authentication).

    ### 4. Pull by Digest
    ```bash
    docker pull nginx@sha256:abc123...
    ```
    Guarantees exact image, even if tags change.

    ## How Docker Pull Works

    ```
    1. Parse image name and tag
       ↓
    2. Connect to registry (Docker Hub by default)
       ↓
    3. Check authentication if required
       ↓
    4. Download image manifest
       ↓
    5. Download each layer (with progress bars)
       ↓
    6. Extract and store layers locally
       ↓
    7. Tag image in local repository
    ```

    ## Image Naming Convention

    ```
    [REGISTRY/]REPOSITORY[:TAG|@DIGEST]
    
    Examples:
    nginx                          → docker.io/library/nginx:latest
    nginx:alpine                   → docker.io/library/nginx:alpine
    myuser/myapp:1.0              → docker.io/myuser/myapp:1.0
    gcr.io/project/image:v1       → gcr.io/project/image:v1
    ```

    ## Layer Reuse

    Docker pulls only missing layers:
    ```bash
    docker pull nginx:1.21
    # Later...
    docker pull nginx:1.21-alpine
    # Only downloads alpine-specific layers!
    ```

    ## Common Tags

    | Tag | Meaning | Use Case |
    |-----|---------|----------|
    | `latest` | Most recent build | Development (not production!) |
    | `1.21` | Major.minor version | Production |
    | `1.21.3` | Specific patch | Critical stability |
    | `alpine` | Minimal Alpine Linux base | Smaller images |
    | `slim` | Reduced size variant | Balance size/features |

    ## Pull Strategies

    ### Development
    ```bash
    docker pull nginx:alpine
    # Small, fast, good for testing
    ```

    ### Production
    ```bash
    docker pull nginx:1.21.3-alpine
    # Specific version for reproducibility
    ```

    ### Security-Critical
    ```bash
    docker pull nginx@sha256:abc123def456...
    # Immutable digest ensures exact image
    ```

    ## Private Registries

    Login first:
    ```bash
    docker login myregistry.com
    docker pull myregistry.com/private-app:1.0
    ```

    ## Common Mistakes

    1. **Using :latest in production**: Version drifts cause issues
    2. **Not specifying tags**: Gets unpredictable :latest
    3. **Pulling repeatedly**: Wastes bandwidth, use local cache
    4. **Large images over slow connections**: Consider smaller variants
    5. **Not checking image authenticity**: Verify official images

    ## Pro Tips

    1. **Always specify version tags in production**
    2. **Use Alpine variants for smaller sizes**
    3. **Pull during build/deploy, not at runtime**
    4. **Check Docker Hub for official images**
    5. **Use digests for critical deployments**
    6. **Cache images in CI/CD pipelines**

## Syntax/Command

```bash
docker pull nginx:alpine
```

## Example

```bash
docker pull nginx
```

## Key Points

- Pull latest: docker pull nginx

- Specific version: docker pull nginx:1.21

- Alpine variant: docker pull nginx:alpine
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['images', 'docker-pull', 'registry', 'download', 'docker-hub'],
  prerequisite_ids: []
)

# Exercise 3.1: Terminal
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker pull nginx:alpine',
    description: 'Download PostgreSQL version 13 with Alpine Linux base image from Docker Hub',
    difficulty: 'easy',
    hints: ['Pull latest: docker pull nginx', 'Specific version: docker pull nginx:1.21', 'Alpine variant: docker pull nginx:alpine']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker pull nginx:alpine',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 3.2: MCQ
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What happens if you don\',
    options: ['Docker automatically pulls the :latest tag', 'Docker pulls all available tags', 'The command fails with an error', 'Docker prompts you to choose a tag'],
    correct_answer: 0,
    explanation: 'When no tag is specified, Docker defaults to :latest. This is why you should always specify explicit version tags in production to avoid unexpected updates.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 4: Docker Push: Upload Images to Registry ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Push: Upload Images to Registry',
  content: <<~MARKDOWN,
# Docker Push: Upload Images to Registry 🚀

# Mastering docker push: Sharing Images via Registries

    ## What is docker push?
    `docker push` uploads your local Docker images to a registry (Docker Hub, AWS ECR, Google GCR, etc.). This enables sharing images across teams, deploying to production servers, and distributing applications.

    ## Why Pushing Images Matters
    - **Deployment**: Ship images to production servers
    - **Collaboration**: Share images with team members
    - **CI/CD**: Automate build and deployment pipelines
    - **Backup**: Store images in centralized location
    - **Distribution**: Make images publicly available

    ## Basic Syntax
    ```bash
    docker push [OPTIONS] NAME[:TAG]
    ```

    ## Prerequisites

    1. **Tag image with registry prefix**:
    ```bash
    docker tag myapp:1.0 username/myapp:1.0
    ```

    2. **Login to registry**:
    ```bash
    docker login
    ```

    3. **Push image**:
    ```bash
    docker push username/myapp:1.0
    ```

    ## Common Use Cases

    ### Push to Docker Hub
    ```bash
    docker login
    docker tag myapp:1.0 username/myapp:1.0
    docker push username/myapp:1.0
    ```

    ### Push Multiple Tags
    ```bash
    docker push username/myapp:1.0
    docker push username/myapp:latest
    ```

    ### Push to Private Registry
    ```bash
    docker login myregistry.com
    docker tag myapp:1.0 myregistry.com/myapp:1.0
    docker push myregistry.com/myapp:1.0
    ```

    ## How Docker Push Works

    ```
    1. Check image exists locally
       ↓
    2. Verify authentication token
       ↓
    3. Check which layers already exist on registry
       ↓
    4. Upload only new/changed layers
       ↓
    5. Upload image manifest
       ↓
    6. Tag image in registry
    ```

    ## Layer Optimization

    Docker only uploads layers that don't exist on the registry:
    ```bash
    docker push myapp:1.0    # Uploads all layers
    docker push myapp:1.1    # Only uploads changed layers!
    ```

    ## Registry Types

    ### Docker Hub (Default)
    ```bash
    docker push username/image:tag
    ```

    ### AWS ECR
    ```bash
    aws ecr get-login-password | docker login --username AWS --password-stdin 123456.dkr.ecr.region.amazonaws.com
    docker push 123456.dkr.ecr.region.amazonaws.com/myapp:1.0
    ```

    ### Google GCR
    ```bash
    docker push gcr.io/project-id/myapp:1.0
    ```

    ### Private Registry
    ```bash
    docker push registry.company.com:5000/myapp:1.0
    ```

    ## Common Patterns

    ### CI/CD Pipeline Push
    ```bash
    # Build
    docker build -t myapp:${BUILD_NUMBER} .
    
    # Tag for registry
    docker tag myapp:${BUILD_NUMBER} username/myapp:${BUILD_NUMBER}
    docker tag myapp:${BUILD_NUMBER} username/myapp:latest
    
    # Push both tags
    docker push username/myapp:${BUILD_NUMBER}
    docker push username/myapp:latest
    ```

    ### Multi-Architecture Push
    ```bash
    docker buildx build --platform linux/amd64,linux/arm64 -t username/myapp:1.0 --push .
    ```

    ## Common Mistakes

    1. **Forgetting to tag with registry prefix**: Must include username/registry
    2. **Not logged in**: Login first with `docker login`
    3. **Wrong repository name**: Case-sensitive on some registries
    4. **Missing tag**: Defaults to :latest if not specified
    5. **Large images over slow connections**: Consider layer optimization

    ## Security Best Practices

    1. **Never commit credentials**: Use CI/CD secrets
    2. **Use access tokens**: Not passwords when possible
    3. **Limit push permissions**: Use read-only tokens for pulls
    4. **Scan images before pushing**: Check for vulnerabilities
    5. **Use private registries for sensitive code**

    ## Pro Tips

    1. **Push multiple tags in CI/CD**: version + latest
    2. **Use .dockerignore**: Reduce image size before building
    3. **Leverage layer caching**: Organize Dockerfile for efficiency
    4. **Tag with semantic versions**: 1.0.0, 1.0, 1, latest
    5. **Automate pushes in pipelines**: Don't push manually
    6. **Clean up old tags**: Implement retention policies

## Syntax/Command

```bash
docker push username/myapp:1.0
```

## Example

```bash
docker push myregistry.com/myapp:1.0
```

## Key Points

- Tag for registry: docker tag myapp username/myapp:1.0

- Login: docker login

- Push: docker push username/myapp:1.0
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['images', 'docker-push', 'registry', 'deployment', 'sharing'],
  prerequisite_ids: []
)

# Exercise 4.1: Terminal
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker push username/myapp:1.0',
    description: 'Tag and push local image to Docker Hub registry for team access',
    difficulty: 'medium',
    hints: ['Tag for registry: docker tag myapp username/myapp:1.0', 'Login: docker login', 'Push: docker push username/myapp:1.0']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker push username/myapp:1.0',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 4.2: MCQ
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Why must you tag an image with a registry prefix before pushing?',
    options: ['The tag tells Docker which registry to push to and where to store it', 'It is just a naming convention with no functional purpose', 'To make the image larger for better quality', 'Docker Hub requires it for security scanning'],
    correct_answer: 0,
    explanation: 'The image tag format registry/repository:version tells Docker where to push the image. For Docker Hub, username/myapp:1.0 means push to Docker Hub under that username\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 5: Docker Tag: Create Image Aliases ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Tag: Create Image Aliases',
  content: <<~MARKDOWN,
# Docker Tag: Create Image Aliases 🚀

# Mastering docker tag: Version Control for Images

    ## What is docker tag?
    `docker tag` creates a new tag (alias) for an existing image. It doesn't copy the image - both tags point to the same image ID, consuming no extra disk space. Essential for version management and registry operations.

    ## Why Tagging Matters
    - **Version Control**: Track different versions of same application
    - **Registry Preparation**: Add registry prefix before pushing
    - **Environment Management**: Tag same image for dev/staging/prod
    - **Release Management**: Mark stable versions as :latest
    - **No Duplication**: Multiple tags, single image storage

    ## Basic Syntax
    ```bash
    docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
    ```

    ## Common Use Cases

    ### 1. Add Version Tag
    ```bash
    docker tag myapp:latest myapp:1.0.0
    ```

    ### 2. Prepare for Registry Push
    ```bash
    docker tag myapp:1.0 username/myapp:1.0
    ```

    ### 3. Mark as Latest
    ```bash
    docker tag myapp:1.5.0 myapp:latest
    ```

    ### 4. Create Environment Tag
    ```bash
    docker tag myapp:build myapp:production
    ```

    ## How Tagging Works

    ```
    Before:
    myapp:1.0  → Image ID: abc123

    After: docker tag myapp:1.0 myapp:latest
    myapp:1.0     → Image ID: abc123
    myapp:latest  → Image ID: abc123 (same image!)
    
    Disk usage: No increase!
    ```

    ## Semantic Versioning Strategy

    ```bash
    # Build version 1.5.3
    docker build -t myapp:1.5.3 .

    # Tag additional versions
    docker tag myapp:1.5.3 myapp:1.5    # Minor version
    docker tag myapp:1.5.3 myapp:1      # Major version
    docker tag myapp:1.5.3 myapp:latest # Latest stable
    ```

    ## Registry Tagging Pattern

    ```bash
    # Local image
    docker build -t myapp:1.0 .

    # Tag for Docker Hub
    docker tag myapp:1.0 username/myapp:1.0
    docker tag myapp:1.0 username/myapp:latest

    # Tag for private registry
    docker tag myapp:1.0 registry.company.com/myapp:1.0

    # Now push
    docker push username/myapp:1.0
    docker push username/myapp:latest
    ```

    ## Multi-Registry Strategy

    Tag same image for multiple registries:
    ```bash
    # Original local image
    docker build -t myapp:1.0 .

    # Docker Hub
    docker tag myapp:1.0 dockerhub-user/myapp:1.0

    # AWS ECR
    docker tag myapp:1.0 123456.dkr.ecr.us-east-1.amazonaws.com/myapp:1.0

    # Google GCR
    docker tag myapp:1.0 gcr.io/my-project/myapp:1.0
    ```

    ## Environment-Based Tagging

    ```bash
    # Build once
    docker build -t myapp:${GIT_COMMIT} .

    # Tag for environments
    docker tag myapp:${GIT_COMMIT} myapp:dev
    docker tag myapp:${GIT_COMMIT} myapp:staging
    docker tag myapp:${GIT_COMMIT} myapp:production
    ```

    ## Common Mistakes

    1. **Thinking tag creates a copy**: It's an alias, not duplication
    2. **Overwriting important tags**: :latest changes frequently
    3. **Not using semantic versions**: Hard to track releases
    4. **Missing registry prefix**: Required for pushing
    5. **Forgetting to tag :latest**: Some tools expect it

    ## Best Practices

    ### Development
    ```bash
    docker tag myapp:dev myapp:$(git rev-parse --short HEAD)
    ```

    ### Release
    ```bash
    docker tag myapp:rc myapp:1.0.0
    docker tag myapp:rc myapp:latest
    ```

    ### Hotfix
    ```bash
    docker tag myapp:1.0.0 myapp:1.0.1
    docker tag myapp:1.0.1 myapp:latest
    ```

    ## Pro Tips

    1. **Use semantic versioning**: major.minor.patch
    2. **Tag before pushing**: Add registry prefix
    3. **Automate in CI/CD**: Tag based on git tags/branches
    4. **Keep :latest updated**: Point to most stable version
    5. **Document tagging strategy**: Team consistency
    6. **Use build metadata**: Include commit hash in tags

## Syntax/Command

```bash
docker tag myapp:1.0 username/myapp:1.0
```

## Example

```bash
docker tag myapp:latest myapp:1.0.0
```

## Key Points

- Basic tag: docker tag source:tag target:tag

- Add version: docker tag myapp:latest myapp:1.0

- For registry: docker tag myapp username/myapp:1.0
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 5.1: Terminal
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker tag myapp:1.0 username/myapp:1.0',
    description: 'Create version and latest tags for staging image before production deployment',
    difficulty: 'easy',
    hints: ['Basic tag: docker tag source:tag target:tag', 'Add version: docker tag myapp:latest myapp:1.0', 'For registry: docker tag myapp username/myapp:1.0']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker tag myapp:1.0 username/myapp:1.0',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# === MICROLESSON 6: Docker RMI: Remove Images ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker RMI: Remove Images',
  content: <<~MARKDOWN,
# Docker RMI: Remove Images 🚀

Remove one or more images from local storage to free disk space. Cannot remove images being used by containers unless forced.

## Syntax/Command

```bash
docker rmi myapp:1.0
```

## Example

```bash
docker rmi -f myapp:old
```

## Key Points

- Remove image: docker rmi <image:tag>

- Force remove: docker rmi -f <image>

- Remove multiple: docker rmi image1 image2
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['images', 'docker-rmi', 'cleanup', 'removal', 'disk-space'],
  prerequisite_ids: []
)

# Exercise 6.1: Terminal
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker rmi myapp:1.0',
    description: 'Remove unused images to reclaim disk space',
    difficulty: 'easy',
    hints: ['Remove image: docker rmi <image:tag>', 'Force remove: docker rmi -f <image>', 'Remove multiple: docker rmi image1 image2']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker rmi myapp:1.0',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Can you remove an image that has a running container?',
    options: ['No, unless you use -f flag to force removal', 'Yes, Docker automatically stops the container', 'Yes, but the container will fail', 'No, it is never possible'],
    correct_answer: 0,
    explanation: 'Docker prevents removing images in use by containers. Use -f to force, but this can cause running containers to fail.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 7: Docker Image Prune: Clean Unused Images ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Image Prune: Clean Unused Images',
  content: <<~MARKDOWN,
# Docker Image Prune: Clean Unused Images 🚀

Remove unused (dangling) images in batch to reclaim disk space. Use -a to remove all images not used by containers.

## Syntax/Command

```bash
docker image prune
```

## Example

```bash
docker image prune -f
```

## Key Points

- Remove dangling: docker image prune

- Skip confirmation: docker image prune -f

- Remove all unused: docker image prune -a
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['images', 'docker-prune', 'cleanup', 'maintenance', 'disk-space'],
  prerequisite_ids: []
)

# Exercise 7.1: Terminal
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker image prune',
    description: 'Automate cleanup of unused Docker images to maintain system health',
    difficulty: 'easy',
    hints: ['Remove dangling: docker image prune', 'Skip confirmation: docker image prune -f', 'Remove all unused: docker image prune -a']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker image prune',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What are "dangling" images?',
    options: ['Untagged images from builds or replaced tags', 'Images that are corrupted', 'Images over 1GB in size', 'Images from untrusted sources'],
    correct_answer: 0,
    explanation: 'Dangling images are those with <none>:<none> tags - intermediate layers or old images replaced by new tags.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: Docker Image LS: List Images ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Image LS: List Images',
  content: <<~MARKDOWN,
# Docker Image LS: List Images 🚀

Modern command to list Docker images - equivalent to docker images but follows new CLI structure.

## Syntax/Command

```bash
docker image ls
```

## Example

```bash
docker image ls -a
```

## Key Points

- List images: docker image ls

- All including intermediates: docker image ls -a

- Filter dangling: docker image ls -f dangling=true
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['images', 'docker-ls', 'listing', 'inventory'],
  prerequisite_ids: []
)

# Exercise 8.1: Terminal
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker image ls',
    description: 'List all images with custom formatting for audit report',
    difficulty: 'easy',
    hints: ['List images: docker image ls', 'All including intermediates: docker image ls -a', 'Filter dangling: docker image ls -f dangling=true']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker image ls',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the difference between "docker images" and "docker image ls"?',
    options: ['They are equivalent - same functionality', 'docker image ls shows more details', 'docker images is deprecated', 'docker image ls is faster'],
    correct_answer: 0,
    explanation: 'docker image ls is the modern form of docker images - both work identically, new syntax follows consistent CLI structure.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: Docker Image RM: Remove Images ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Image RM: Remove Images',
  content: <<~MARKDOWN,
# Docker Image RM: Remove Images 🚀

Modern syntax for removing images - equivalent to docker rmi but follows new CLI structure.

## Syntax/Command

```bash
docker image rm myapp:1.0
```

## Example

```bash
docker image rm -f myapp:old
```

## Key Points

- Remove: docker image rm <image>

- Force: docker image rm -f <image>

- Multiple: docker image rm img1 img2
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['images', 'docker-rm', 'cleanup', 'removal'],
  prerequisite_ids: []
)

# Exercise 9.1: Terminal
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker image rm myapp:1.0',
    description: 'Remove specific image versions no longer needed',
    difficulty: 'easy',
    hints: ['Remove: docker image rm <image>', 'Force: docker image rm -f <image>', 'Multiple: docker image rm img1 img2']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker image rm myapp:1.0',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What happens to containers when you force remove their image?',
    options: ['Running containers may fail when restarted', 'Containers are automatically stopped', 'Nothing - containers are unaffected', 'Containers are recreated from backup'],
    correct_answer: 0,
    explanation: 'Force removing an image in use can cause containers to fail on restart since the image layers are deleted.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 10: Docker Image Inspect: Detailed Image Information ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Image Inspect: Detailed Image Information',
  content: <<~MARKDOWN,
# Docker Image Inspect: Detailed Image Information 🚀

Display detailed image information in JSON format including layers, configuration, environment variables, and metadata.

## Syntax/Command

```bash
docker image inspect nginx:alpine
```

## Example

```bash
docker image inspect --format="{{.Size}}" nginx
```

## Key Points

- Inspect: docker image inspect <image>

- Extract field: docker image inspect --format="{{.Architecture}}" <image>

- Multiple images: docker image inspect img1 img2
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['images', 'docker-inspect', 'metadata', 'debugging', 'configuration'],
  prerequisite_ids: []
)

# Exercise 10.1: Terminal
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker image inspect nginx:alpine',
    description: 'Extract detailed configuration from image for security audit',
    difficulty: 'medium',
    hints: ['Inspect: docker image inspect <image>', 'Extract field: docker image inspect --format="{{.Architecture}}" <image>', 'Multiple images: docker image inspect img1 img2']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker image inspect nginx:alpine',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What information can you find with docker image inspect?',
    options: ['Layers, environment variables, exposed ports, and creation date', 'Only the image size', 'Running container information', 'Network connections'],
    correct_answer: 0,
    explanation: 'docker image inspect shows complete image metadata including layers, config, env vars, exposed ports, labels, and more.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 11: Docker History: Show Image Build History ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker History: Show Image Build History',
  content: <<~MARKDOWN,
# Docker History: Show Image Build History 🚀

Display the history of an image showing all layers, commands that created them, and their sizes. Essential for understanding image composition and optimization.

## Syntax/Command

```bash
docker history nginx:alpine
```

## Example

```bash
docker history --no-trunc nginx
```

## Key Points

- View history: docker history <image>

- Full commands: docker history --no-trunc <image>

- Size analysis: docker history <image> | head
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['images', 'docker-history', 'layers', 'optimization', 'analysis'],
  prerequisite_ids: []
)

# Exercise 11.1: Terminal
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker history nginx:alpine',
    description: 'Examine image layers to find optimization opportunities',
    difficulty: 'medium',
    hints: ['View history: docker history <image>', 'Full commands: docker history --no-trunc <image>', 'Size analysis: docker history <image> | head']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker history nginx:alpine',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does each line in docker history output represent?',
    options: ['A layer in the image with the command that created it', 'A version of the image', 'A container created from the image', 'A backup of the image'],
    correct_answer: 0,
    explanation: 'Each line shows a layer created by a Dockerfile instruction, displaying the command, size, and creation time.',
    difficulty: 'medium'
  }
)

puts "✓ Created 11 microlessons for Docker Images"

# Docker Images Interactive Learning Units
# Converting 11 image management commands into CodeSprout-style learning experiences

puts "🐳 Creating Docker Images Interactive Learning Units..."

# Find or create Docker Fundamentals course
course = Course.find_by(slug: 'docker-fundamentals')
unless course
  course = Course.create!(
    slug: 'docker-fundamentals',
    title: 'Docker Fundamentals',
    description: 'Master Docker from basics to advanced topics',
    difficulty_level: 'beginner',
    estimated_hours: 20,
    published: true,
    sequence_order: 1
  )
end

# Find or create Image Management module
images_module = course.course_modules.find_or_create_by!(slug: 'image-management') do |m|
  m.title = "Image Management"
  m.description = "Master Docker image creation, management, and registry operations"
  m.sequence_order = 3
  m.estimated_minutes = 275
  m.published = true
  m.learning_objectives = [
    'Build custom images from Dockerfiles',
    'Manage local image repository',
    'Push and pull images from registries',
    'Tag images for version control',
    'Inspect image layers and history',
    'Clean up unused images efficiently'
  ]
end

# Unit 38: docker build
unit_38 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-build-command') do |u|
  u.title = 'Docker Build: Building Images from Dockerfile'
  u.concept_explanation = <<~MD
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
  MD

  u.command_to_learn = 'docker build -t myapp:1.0 .'
  u.command_variations = [
    'docker build .',
    'docker build -t myapp:latest .',
    'docker build -f Dockerfile.prod -t myapp:prod .',
    'docker build --build-arg VERSION=1.0 -t myapp .',
    'docker build --no-cache -t myapp .'
  ]

  u.practice_hints = [
    'Basic build: docker build .',
    'Tag image: docker build -t myapp:1.0 .',
    'Custom Dockerfile: docker build -f Dockerfile.prod .',
    'With build args: docker build --build-arg NODE_VERSION=14 .',
    'No cache: docker build --no-cache .'
  ]

  u.scenario_narrative = <<~MD
    **First Production Build**
    
    Maria assigns you: "We need to containerize our Node.js API. I've created a Dockerfile in the project root. Build an image tagged 'api-server:1.0' and make sure to use build argument API_ENV=production. The application is in /app/api-server directory."
  MD

  u.problem_statement = 'Build a Docker image from Dockerfile, tag it as api-server:1.0, and pass API_ENV=production as build argument'

  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 38
  u.category = 'docker-images'
  u.published = true

  u.quiz_question_text = 'What does the dot (.) represent in "docker build -t myapp ."?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'The build context (current directory)', correct: true },
    { text: 'The Dockerfile name', correct: false },
    { text: 'The output directory', correct: false },
    { text: 'The cache location', correct: false }
  ]
  u.quiz_correct_answer = 'The build context (current directory)'
  u.quiz_explanation = 'The dot (.) specifies the build context - the directory containing files Docker can access during build. Docker sends this context to the daemon.'

  u.concept_tags = ['images', 'docker-build', 'dockerfile', 'creation', 'deployment']
end

unit_38.update!(
  code_examples: [
    {
      title: 'Simple build from current directory',
      code: 'docker build .',
      explanation: 'Builds image using Dockerfile in current directory - no tag assigned'
    },
    {
      title: 'Build and tag with version',
      code: 'docker build -t myapp:1.0.3 .',
      explanation: 'Creates image with specific version tag for deployment tracking'
    },
    {
      title: 'Production build with custom Dockerfile',
      code: 'docker build -f Dockerfile.prod -t myapp:prod .',
      explanation: 'Uses production-specific Dockerfile for optimized builds'
    },
    {
      title: 'Build with arguments and multiple tags',
      code: 'docker build --build-arg NODE_ENV=production -t myapp:1.0 -t myapp:latest .',
      explanation: 'Passes build-time variable and creates two tags for same image'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: images_module,
  interactive_learning_unit: unit_38
) do |miu|
  miu.sequence_order = 1
  miu.required = true
end

# Unit 39: docker images
unit_39 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-list-command') do |u|
  u.title = 'Docker Images: List Local Images'
  u.concept_explanation = <<~MD
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
  MD

  u.command_to_learn = 'docker images'
  u.command_variations = [
    'docker images -a',
    'docker images -q',
    'docker images nginx',
    'docker images --filter "dangling=true"'
  ]

  u.practice_hints = [
    'List all images: docker images',
    'Only IDs: docker images -q',
    'Specific repo: docker images <name>',
    'Include intermediates: docker images -a'
  ]

  u.scenario_narrative = 'Inventory check: List all local images and identify which are consuming the most disk space'
  u.problem_statement = 'Display all locally stored Docker images and their sizes'

  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 39
  u.category = 'docker-images'
  u.published = true

  u.quiz_question_text = 'What does it mean when two images have the same IMAGE ID?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'They are the same image with different tags', correct: true },
    { text: 'It is an error condition', correct: false },
    { text: 'They are duplicates wasting space', correct: false },
    { text: 'They have the same size', correct: false }
  ]
  u.quiz_correct_answer = 'They are the same image with different tags'
  u.quiz_explanation = 'Multiple tags can point to the same image. For example, myapp:1.0 and myapp:latest can share the same IMAGE ID, using no extra disk space.'

  u.concept_tags = ['images', 'docker-images', 'listing', 'inventory', 'management']
end

unit_39.update!(
  code_examples: [
    {
      title: 'List all local images',
      code: 'docker images',
      explanation: 'Shows complete inventory of images on your system'
    },
    {
      title: 'List only image IDs',
      code: 'docker images -q',
      explanation: 'Useful for scripting - pipe to removal commands'
    },
    {
      title: 'Filter by repository name',
      code: 'docker images nginx',
      explanation: 'Shows all nginx images with different tags'
    },
    {
      title: 'Find dangling images',
      code: 'docker images -f dangling=true',
      explanation: 'Lists untagged images that can be cleaned up'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: images_module,
  interactive_learning_unit: unit_39
) do |miu|
  miu.sequence_order = 2
  miu.required = true
end

# Unit 40: docker pull
unit_40 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-pull-command') do |u|
  u.title = 'Docker Pull: Download Images from Registry'
  u.concept_explanation = <<~MD
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
  MD

  u.command_to_learn = 'docker pull nginx:alpine'
  u.command_variations = [
    'docker pull nginx',
    'docker pull nginx:1.21',
    'docker pull postgres:13-alpine',
    'docker pull myregistry.com/myapp:1.0'
  ]

  u.practice_hints = [
    'Pull latest: docker pull nginx',
    'Specific version: docker pull nginx:1.21',
    'Alpine variant: docker pull nginx:alpine',
    'From registry: docker pull registry.com/image:tag'
  ]

  u.scenario_narrative = 'Setup task: Pull the official PostgreSQL 13 Alpine image for the new database service'
  u.problem_statement = 'Download PostgreSQL version 13 with Alpine Linux base image from Docker Hub'

  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 40
  u.category = 'docker-images'
  u.published = true

  u.quiz_question_text = 'What happens if you don\'t specify a tag when pulling an image?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Docker automatically pulls the :latest tag', correct: true },
    { text: 'Docker pulls all available tags', correct: false },
    { text: 'The command fails with an error', correct: false },
    { text: 'Docker prompts you to choose a tag', correct: false }
  ]
  u.quiz_correct_answer = 'Docker automatically pulls the :latest tag'
  u.quiz_explanation = 'When no tag is specified, Docker defaults to :latest. This is why you should always specify explicit version tags in production to avoid unexpected updates.'

  u.concept_tags = ['images', 'docker-pull', 'registry', 'download', 'docker-hub']
end

unit_40.update!(
  code_examples: [
    {
      title: 'Pull latest nginx',
      code: 'docker pull nginx',
      explanation: 'Downloads most recent nginx image (nginx:latest)'
    },
    {
      title: 'Pull specific version',
      code: 'docker pull postgres:13.4-alpine',
      explanation: 'Gets exact PostgreSQL version - reproducible deployments'
    },
    {
      title: 'Pull from Docker Hub user repository',
      code: 'docker pull username/custom-app:2.0',
      explanation: 'Downloads from personal Docker Hub repository'
    },
    {
      title: 'Pull using image digest',
      code: 'docker pull nginx@sha256:2bcabc23b45489fb0885d69a06ba1d648aeda973fae7bb981bafbb884165e514',
      explanation: 'Guarantees exact image content - immutable reference'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: images_module,
  interactive_learning_unit: unit_40
) do |miu|
  miu.sequence_order = 3
  miu.required = true
end

# Unit 41: docker push
unit_41 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-push-command') do |u|
  u.title = 'Docker Push: Upload Images to Registry'
  u.concept_explanation = <<~MD
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
  MD

  u.command_to_learn = 'docker push username/myapp:1.0'
  u.command_variations = [
    'docker push myregistry.com/myapp:1.0',
    'docker push username/myapp:latest',
    'docker push gcr.io/project/myapp:1.0'
  ]

  u.practice_hints = [
    'Tag for registry: docker tag myapp username/myapp:1.0',
    'Login: docker login',
    'Push: docker push username/myapp:1.0',
    'Push to private: docker push registry.com/myapp:1.0'
  ]

  u.scenario_narrative = 'Deployment prep: Push your built api-server:1.0 image to Docker Hub as username/api-server:1.0 for production deployment'
  u.problem_statement = 'Tag and push local image to Docker Hub registry for team access'

  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 41
  u.category = 'docker-images'
  u.published = true

  u.quiz_question_text = 'Why must you tag an image with a registry prefix before pushing?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'The tag tells Docker which registry to push to and where to store it', correct: true },
    { text: 'It is just a naming convention with no functional purpose', correct: false },
    { text: 'To make the image larger for better quality', correct: false },
    { text: 'Docker Hub requires it for security scanning', correct: false }
  ]
  u.quiz_correct_answer = 'The tag tells Docker which registry to push to and where to store it'
  u.quiz_explanation = 'The image tag format registry/repository:version tells Docker where to push the image. For Docker Hub, username/myapp:1.0 means push to Docker Hub under that username\'s repository.'

  u.concept_tags = ['images', 'docker-push', 'registry', 'deployment', 'sharing']
end

unit_41.update!(
  code_examples: [
    {
      title: 'Push to Docker Hub',
      code: 'docker push username/myapp:1.0',
      explanation: 'Uploads image to Docker Hub public registry'
    },
    {
      title: 'Push to AWS ECR',
      code: 'docker push 123456789.dkr.ecr.us-east-1.amazonaws.com/myapp:1.0',
      explanation: 'Deploys to private AWS Elastic Container Registry'
    },
    {
      title: 'Push multiple tags',
      code: 'docker push username/myapp:1.0 && docker push username/myapp:latest',
      explanation: 'Pushes both version tag and latest tag for same image'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: images_module,
  interactive_learning_unit: unit_41
) do |miu|
  miu.sequence_order = 4
  miu.required = true
end

# Unit 42: docker tag
unit_42 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-tag-command') do |u|
  u.title = 'Docker Tag: Create Image Aliases'
  u.concept_explanation = <<~MD
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
  MD

  u.command_to_learn = 'docker tag myapp:1.0 username/myapp:1.0'
  u.command_variations = [
    'docker tag myapp:latest myapp:1.0.0',
    'docker tag abc123 myapp:production',
    'docker tag myapp:1.0 registry.io/myapp:1.0'
  ]

  u.practice_hints = [
    'Basic tag: docker tag source:tag target:tag',
    'Add version: docker tag myapp:latest myapp:1.0',
    'For registry: docker tag myapp username/myapp:1.0',
    'By ID: docker tag <image-id> newname:tag'
  ]

  u.scenario_narrative = 'Release management: Tag your tested myapp:staging image as myapp:1.0.0 and myapp:latest for production release'
  u.problem_statement = 'Create version and latest tags for staging image before production deployment'

  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 42
  u.category = 'docker-images'
  u.published = true

  u.quiz_question_text = 'When you tag an image, what happens to disk space usage?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'No change - tags are aliases to the same image', correct: true },
    { text: 'Disk usage doubles with each tag', correct: false },
    { text: 'Disk usage increases slightly for metadata', correct: false },
    { text: 'Depends on the size of the tag name', correct: false }
  ]
  u.quiz_correct_answer = 'No change - tags are aliases to the same image'
  u.quiz_explanation = 'Docker tags are just names pointing to the same image ID. Multiple tags reference the same layers on disk, using no additional space.'

  u.concept_tags = ['images', 'docker-tag', 'versioning', 'naming', 'registry']
end

unit_42.update!(
  code_examples: [
    {
      title: 'Create version tag',
      code: 'docker tag myapp:latest myapp:1.0.0',
      explanation: 'Adds version tag to latest build - same image, new name'
    },
    {
      title: 'Prepare for Docker Hub push',
      code: 'docker tag myapp:1.0 username/myapp:1.0',
      explanation: 'Adds registry prefix required for pushing to Docker Hub'
    },
    {
      title: 'Tag for multiple registries',
      code: 'docker tag myapp:1.0 gcr.io/project/myapp:1.0',
      explanation: 'Same image tagged for Google Container Registry'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: images_module,
  interactive_learning_unit: unit_42
) do |miu|
  miu.sequence_order = 5
  miu.required = true
end

# Units 43-48: Concise but complete content following the pattern

# Unit 43: docker rmi
unit_43 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-rmi-command') do |u|
  u.title = 'Docker RMI: Remove Images'
  u.concept_explanation = 'Remove one or more images from local storage to free disk space. Cannot remove images being used by containers unless forced.'
  u.command_to_learn = 'docker rmi myapp:1.0'
  u.command_variations = [
    'docker rmi -f myapp:old',
    'docker rmi $(docker images -q)',
    'docker rmi myapp:1.0 myapp:2.0'
  ]
  u.practice_hints = [
    'Remove image: docker rmi <image:tag>',
    'Force remove: docker rmi -f <image>',
    'Remove multiple: docker rmi image1 image2',
    'Remove by ID: docker rmi <image-id>'
  ]
  u.scenario_narrative = 'Cleanup: Remove old image versions to free 5GB of disk space'
  u.problem_statement = 'Remove unused images to reclaim disk space'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 43
  u.category = 'docker-images'
  u.published = true
  u.quiz_question_text = 'Can you remove an image that has a running container?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'No, unless you use -f flag to force removal', correct: true },
    { text: 'Yes, Docker automatically stops the container', correct: false },
    { text: 'Yes, but the container will fail', correct: false },
    { text: 'No, it is never possible', correct: false }
  ]
  u.quiz_correct_answer = 'No, unless you use -f flag to force removal'
  u.quiz_explanation = 'Docker prevents removing images in use by containers. Use -f to force, but this can cause running containers to fail.'
  u.concept_tags = ['images', 'docker-rmi', 'cleanup', 'removal', 'disk-space']
end

unit_43.update!(
  code_examples: [
    { title: 'Remove single image', code: 'docker rmi nginx:alpine', explanation: 'Deletes image and its unused layers' },
    { title: 'Force remove', code: 'docker rmi -f myapp:old', explanation: 'Removes even if containers exist (use with caution)' },
    { title: 'Remove multiple images', code: 'docker rmi myapp:1.0 myapp:2.0 myapp:3.0', explanation: 'Batch removal of multiple versions' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(course_module: images_module, interactive_learning_unit: unit_43) { |miu| miu.sequence_order = 6; miu.required = true }

# Unit 44: docker image prune
unit_44 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-prune-command') do |u|
  u.title = 'Docker Image Prune: Clean Unused Images'
  u.concept_explanation = 'Remove unused (dangling) images in batch to reclaim disk space. Use -a to remove all images not used by containers.'
  u.command_to_learn = 'docker image prune'
  u.command_variations = [
    'docker image prune -f',
    'docker image prune -a',
    'docker image prune -a --filter "until=24h"'
  ]
  u.practice_hints = [
    'Remove dangling: docker image prune',
    'Skip confirmation: docker image prune -f',
    'Remove all unused: docker image prune -a',
    'Age filter: docker image prune --filter "until=24h"'
  ]
  u.scenario_narrative = 'Weekly maintenance: Clean all dangling images and unused images older than 7 days'
  u.problem_statement = 'Automate cleanup of unused Docker images to maintain system health'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 44
  u.category = 'docker-images'
  u.published = true
  u.quiz_question_text = 'What are "dangling" images?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Untagged images from builds or replaced tags', correct: true },
    { text: 'Images that are corrupted', correct: false },
    { text: 'Images over 1GB in size', correct: false },
    { text: 'Images from untrusted sources', correct: false }
  ]
  u.quiz_correct_answer = 'Untagged images from builds or replaced tags'
  u.quiz_explanation = 'Dangling images are those with <none>:<none> tags - intermediate layers or old images replaced by new tags.'
  u.concept_tags = ['images', 'docker-prune', 'cleanup', 'maintenance', 'disk-space']
end

unit_44.update!(
  code_examples: [
    { title: 'Remove dangling images', code: 'docker image prune -f', explanation: 'Cleans untagged images without confirmation' },
    { title: 'Remove all unused images', code: 'docker image prune -a -f', explanation: 'Removes all images not used by any container' },
    { title: 'Time-based cleanup', code: 'docker image prune -a --filter "until=168h" -f', explanation: 'Removes images unused for over 7 days' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(course_module: images_module, interactive_learning_unit: unit_44) { |miu| miu.sequence_order = 7; miu.required = true }

# Unit 45: docker image ls
unit_45 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-ls-command') do |u|
  u.title = 'Docker Image LS: List Images'
  u.concept_explanation = 'Modern command to list Docker images - equivalent to docker images but follows new CLI structure.'
  u.command_to_learn = 'docker image ls'
  u.command_variations = [
    'docker image ls -a',
    'docker image ls --filter "dangling=true"',
    'docker image ls --format "{{.Repository}}:{{.Tag}}"'
  ]
  u.practice_hints = [
    'List images: docker image ls',
    'All including intermediates: docker image ls -a',
    'Filter dangling: docker image ls -f dangling=true',
    'Custom format: docker image ls --format "table {{.Repository}}\\t{{.Tag}}"'
  ]
  u.scenario_narrative = 'Audit: Generate report of all images on production servers'
  u.problem_statement = 'List all images with custom formatting for audit report'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 45
  u.category = 'docker-images'
  u.published = true
  u.quiz_question_text = 'What is the difference between "docker images" and "docker image ls"?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'They are equivalent - same functionality', correct: true },
    { text: 'docker image ls shows more details', correct: false },
    { text: 'docker images is deprecated', correct: false },
    { text: 'docker image ls is faster', correct: false }
  ]
  u.quiz_correct_answer = 'They are equivalent - same functionality'
  u.quiz_explanation = 'docker image ls is the modern form of docker images - both work identically, new syntax follows consistent CLI structure.'
  u.concept_tags = ['images', 'docker-ls', 'listing', 'inventory']
end

unit_45.update!(
  code_examples: [
    { title: 'List all images', code: 'docker image ls', explanation: 'Shows local image repository inventory' },
    { title: 'Filter by name', code: 'docker image ls nginx', explanation: 'Lists only nginx images' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(course_module: images_module, interactive_learning_unit: unit_45) { |miu| miu.sequence_order = 8; miu.required = true }

# Unit 46: docker image rm
unit_46 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-rm-command') do |u|
  u.title = 'Docker Image RM: Remove Images'
  u.concept_explanation = 'Modern syntax for removing images - equivalent to docker rmi but follows new CLI structure.'
  u.command_to_learn = 'docker image rm myapp:1.0'
  u.command_variations = [
    'docker image rm -f myapp:old',
    'docker image rm myapp:1.0 myapp:2.0'
  ]
  u.practice_hints = [
    'Remove: docker image rm <image>',
    'Force: docker image rm -f <image>',
    'Multiple: docker image rm img1 img2'
  ]
  u.scenario_narrative = 'Cleanup old development images to free disk space'
  u.problem_statement = 'Remove specific image versions no longer needed'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 46
  u.category = 'docker-images'
  u.published = true
  u.quiz_question_text = 'What happens to containers when you force remove their image?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Running containers may fail when restarted', correct: true },
    { text: 'Containers are automatically stopped', correct: false },
    { text: 'Nothing - containers are unaffected', correct: false },
    { text: 'Containers are recreated from backup', correct: false }
  ]
  u.quiz_correct_answer = 'Running containers may fail when restarted'
  u.quiz_explanation = 'Force removing an image in use can cause containers to fail on restart since the image layers are deleted.'
  u.concept_tags = ['images', 'docker-rm', 'cleanup', 'removal']
end

unit_46.update!(
  code_examples: [
    { title: 'Remove image', code: 'docker image rm myapp:old', explanation: 'Deletes specific image version' },
    { title: 'Force removal', code: 'docker image rm -f myapp:1.0', explanation: 'Removes even if containers exist' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(course_module: images_module, interactive_learning_unit: unit_46) { |miu| miu.sequence_order = 9; miu.required = true }

# Unit 47: docker image inspect
unit_47 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-inspect-command') do |u|
  u.title = 'Docker Image Inspect: Detailed Image Information'
  u.concept_explanation = 'Display detailed image information in JSON format including layers, configuration, environment variables, and metadata.'
  u.command_to_learn = 'docker image inspect nginx:alpine'
  u.command_variations = [
    'docker image inspect --format="{{.Size}}" nginx',
    'docker image inspect --format="{{.Config.Env}}" myapp'
  ]
  u.practice_hints = [
    'Inspect: docker image inspect <image>',
    'Extract field: docker image inspect --format="{{.Architecture}}" <image>',
    'Multiple images: docker image inspect img1 img2'
  ]
  u.scenario_narrative = 'Investigation: Find base OS and installed packages in production image'
  u.problem_statement = 'Extract detailed configuration from image for security audit'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 47
  u.category = 'docker-images'
  u.published = true
  u.quiz_question_text = 'What information can you find with docker image inspect?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Layers, environment variables, exposed ports, and creation date', correct: true },
    { text: 'Only the image size', correct: false },
    { text: 'Running container information', correct: false },
    { text: 'Network connections', correct: false }
  ]
  u.quiz_correct_answer = 'Layers, environment variables, exposed ports, and creation date'
  u.quiz_explanation = 'docker image inspect shows complete image metadata including layers, config, env vars, exposed ports, labels, and more.'
  u.concept_tags = ['images', 'docker-inspect', 'metadata', 'debugging', 'configuration']
end

unit_47.update!(
  code_examples: [
    { title: 'Full image details', code: 'docker image inspect nginx:alpine', explanation: 'Complete JSON output of image configuration' },
    { title: 'Extract specific field', code: 'docker image inspect --format="{{.Architecture}}" nginx', explanation: 'Shows just the CPU architecture' },
    { title: 'Get image layers', code: 'docker image inspect --format="{{.RootFS.Layers}}" myapp', explanation: 'Lists all layer SHA256 hashes' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(course_module: images_module, interactive_learning_unit: unit_47) { |miu| miu.sequence_order = 10; miu.required = true }

# Unit 48: docker history
unit_48 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-images-history-command') do |u|
  u.title = 'Docker History: Show Image Build History'
  u.concept_explanation = 'Display the history of an image showing all layers, commands that created them, and their sizes. Essential for understanding image composition and optimization.'
  u.command_to_learn = 'docker history nginx:alpine'
  u.command_variations = [
    'docker history --no-trunc nginx',
    'docker history --human=false myapp',
    'docker history --format "{{.CreatedBy}}" myapp'
  ]
  u.practice_hints = [
    'View history: docker history <image>',
    'Full commands: docker history --no-trunc <image>',
    'Size analysis: docker history <image> | head',
    'Custom format: docker history --format "table {{.Size}}\\t{{.CreatedBy}}"'
  ]
  u.scenario_narrative = 'Optimization: Analyze image history to identify large layers for size reduction'
  u.problem_statement = 'Examine image layers to find optimization opportunities'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 48
  u.category = 'docker-images'
  u.published = true
  u.quiz_question_text = 'What does each line in docker history output represent?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'A layer in the image with the command that created it', correct: true },
    { text: 'A version of the image', correct: false },
    { text: 'A container created from the image', correct: false },
    { text: 'A backup of the image', correct: false }
  ]
  u.quiz_correct_answer = 'A layer in the image with the command that created it'
  u.quiz_explanation = 'Each line shows a layer created by a Dockerfile instruction, displaying the command, size, and creation time.'
  u.concept_tags = ['images', 'docker-history', 'layers', 'optimization', 'analysis']
end

unit_48.update!(
  code_examples: [
    { title: 'View image history', code: 'docker history nginx:alpine', explanation: 'Shows all layers and commands that built the image' },
    { title: 'Full command text', code: 'docker history --no-trunc myapp:1.0', explanation: 'Displays complete Dockerfile commands without truncation' },
    { title: 'Find large layers', code: 'docker history myapp | sort -k2 -h', explanation: 'Sorts layers by size to identify optimization targets' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(course_module: images_module, interactive_learning_unit: unit_48) { |miu| miu.sequence_order = 11; miu.required = true }

puts "✓ Created 11 Docker Images interactive learning units"
puts "  - Unit 38: docker build"
puts "  - Unit 39: docker images"
puts "  - Unit 40: docker pull"
puts "  - Unit 41: docker push"
puts "  - Unit 42: docker tag"
puts "  - Unit 43: docker rmi"
puts "  - Unit 44: docker image prune"
puts "  - Unit 45: docker image ls"
puts "  - Unit 46: docker image rm"
puts "  - Unit 47: docker image inspect"
puts "  - Unit 48: docker history"
puts ""
puts "All units include:"
puts "  ✓ Comprehensive concept explanations (first 5 detailed, remaining 6 concise)"
puts "  ✓ Command variations and examples"
puts "  ✓ Progressive practice hints"
puts "  ✓ Scenario narratives"
puts "  ✓ Problem statements"
puts "  ✓ MCQ quizzes with explanations"
puts "  ✓ 2-4 code examples with explanations"
puts "  ✓ Concept tags for remediation"
puts "  ✓ Associated with image-management module (sequence_order: 3)"
puts "  ✓ Sequence order: 38-48 (continuing from containers)"
puts "  ✓ Difficulty: beginner to intermediate"
puts "  ✓ Estimated time: 15-25 minutes each"
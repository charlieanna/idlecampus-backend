puts "Creating Docker Registry Interactive Learning Units..."

course = Course.find_by(slug: 'docker-fundamentals')
registry_module = course.course_modules.find_or_create_by!(slug: 'docker-registry') do |m|
  m.title = "Docker Registry & Distribution"
  m.description = "Master Docker image registries, authentication, and distribution workflows"
  m.sequence_order = 9
  m.estimated_minutes = 100
  m.published = true
end

# Unit 103: docker login
InteractiveLearningUnit.find_or_create_by!(
  course_module: registry_module,
  slug: 'docker-login'
) do |unit|
  unit.title = "docker login - Authenticate to Docker Registries"
  unit.description = "Learn to authenticate with Docker Hub, private registries, and cloud container registries for secure image access"
  unit.content = <<~CONTENT
    # Docker Login - Registry Authentication

    ## What is Docker Login?

    The `docker login` command authenticates you with Docker registries to:
    - **Push images** to your repositories
    - **Pull private images** that require authentication
    - **Access organization** or team repositories
    - **Use cloud registries** like AWS ECR, Google GCR, Azure ACR

    ## Core Concepts

    ### Registry Types
    1. **Docker Hub** (default registry)
       - Public registry at hub.docker.com
       - Free and paid tiers
       - Username-based authentication

    2. **Private Registries**
       - Self-hosted Docker Registry
       - Harbor, Artifactory, GitLab Registry
       - Custom authentication mechanisms

    3. **Cloud Registries**
       - AWS Elastic Container Registry (ECR)
       - Google Container Registry (GCR)
       - Azure Container Registry (ACR)
       - Use cloud provider credentials

    ### Authentication Storage
    - Credentials stored in `~/.docker/config.json`
    - Encoded (NOT encrypted) by default
    - Can use credential helpers for enhanced security

    ## Basic Syntax

    ```bash
    # Login to Docker Hub (default)
    docker login

    # Login to specific registry
    docker login <registry-url>

    # Login with username and password
    docker login -u <username> -p <password>

    # Login with password from stdin (more secure)
    echo "$PASSWORD" | docker login -u <username> --password-stdin
    ```

    ## Common Use Cases

    ### 1. Docker Hub Authentication
    ```bash
    # Interactive login (prompts for credentials)
    docker login
    # Enter username: myusername
    # Enter password: ********

    # Non-interactive login (for scripts)
    docker login -u myusername -p mypassword

    # Secure non-interactive login (recommended)
    echo "$DOCKER_PASSWORD" | docker login -u myusername --password-stdin

    # Verify login status
    docker info | grep Username
    ```

    ### 2. Private Registry Authentication
    ```bash
    # Login to self-hosted registry
    docker login registry.mycompany.com

    # With custom port
    docker login registry.mycompany.com:5000

    # With credentials
    docker login registry.mycompany.com -u admin --password-stdin
    ```

    ### 3. AWS ECR Authentication
    ```bash
    # Get ECR login token (AWS CLI required)
    aws ecr get-login-password --region us-east-1 | \\
      docker login --username AWS \\
      --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com

    # Alternative: Use ECR credential helper
    # In ~/.docker/config.json:
    # {
    #   "credHelpers": {
    #     "123456789012.dkr.ecr.us-east-1.amazonaws.com": "ecr-login"
    #   }
    # }
    ```

    ### 4. Google Container Registry (GCR)
    ```bash
    # Login using gcloud credentials
    gcloud auth configure-docker

    # Or use service account key
    cat keyfile.json | docker login -u _json_key \\
      --password-stdin https://gcr.io

    # Multiple GCP regions
    gcloud auth configure-docker us.gcr.io,eu.gcr.io,asia.gcr.io
    ```

    ### 5. Azure Container Registry (ACR)
    ```bash
    # Login using Azure CLI
    az acr login --name myregistry

    # Or with service principal
    docker login myregistry.azurecr.io \\
      -u $SERVICE_PRINCIPAL_ID \\
      --password-stdin <<< $SERVICE_PRINCIPAL_PASSWORD

    # With admin credentials
    az acr credential show --name myregistry
    docker login myregistry.azurecr.io -u myregistry
    ```

    ## Production Best Practices

    ### 1. Use Service Accounts / Deploy Tokens
    ```bash
    # Create read-only deploy token for pulling images
    # Use service account credentials for CI/CD
    # Never use personal credentials in production

    # Example: AWS ECR with IAM role
    aws ecr get-login-password | \\
      docker login --username AWS --password-stdin $ECR_REGISTRY
    ```

    ### 2. Rotate Credentials Regularly
    ```bash
    # Automated credential rotation script
    #!/bin/bash
    NEW_TOKEN=$(generate_new_token)  # Your token generation logic
    echo "$NEW_TOKEN" | docker login -u serviceaccount --password-stdin
    
    # Update in secret manager
    aws secretsmanager update-secret --secret-id docker-registry-token \\
      --secret-string "$NEW_TOKEN"
    ```

    ### 3. Use Credential Helpers
    ```json
    // ~/.docker/config.json
    {
      "credHelpers": {
        "gcr.io": "gcloud",
        "123456789012.dkr.ecr.us-east-1.amazonaws.com": "ecr-login",
        "myregistry.azurecr.io": "acr-env"
      }
    }
    ```

    ### 4. Least Privilege Access
    ```bash
    # Use read-only tokens for CI pull operations
    # Use write tokens only for push operations in trusted CI
    # Separate tokens per environment (dev, staging, prod)

    # Example: Read-only token for deployments
    echo "$READONLY_TOKEN" | docker login --username deploy-bot \\
      --password-stdin registry.company.com
    ```

    ## Key Takeaways

    - **docker login** authenticates you with Docker registries
    - **Use --password-stdin** for secure, scriptable authentication
    - **Credentials stored** in `~/.docker/config.json` per registry
    - **Credential helpers** provide enhanced security with system keychains
    - **Cloud registries** require provider-specific authentication methods
    - **CI/CD integration** uses service accounts and deploy tokens
    - **Regular rotation** of credentials is a security best practice
    - **Rate limits** apply on Docker Hub for anonymous/free accounts
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 103
  unit.estimated_minutes = 30
  unit.difficulty_level = 'intermediate'
  unit.is_required = true
  unit.category = 'docker-registry'
  
  unit.quiz_questions = [
    {
      question: "Which is the most secure way to login to a registry in a script?",
      options: [
        "docker login -u user -p password",
        "docker login -u user",
        "echo $PASSWORD | docker login -u user --password-stdin",
        "docker login --secure -u user"
      ],
      correct_answer: 2,
      explanation: "Using --password-stdin prevents the password from appearing in command history or process lists, making it the most secure option for scripts."
    },
    {
      question: "Where are Docker registry credentials stored by default?",
      options: [
        "/etc/docker/credentials",
        "~/.docker/config.json",
        "/var/lib/docker/auth",
        "~/.dockercfg"
      ],
      correct_answer: 1,
      explanation: "Docker stores authentication credentials in ~/.docker/config.json, with a separate entry for each registry you've authenticated with."
    },
    {
      question: "What is the purpose of credential helpers?",
      options: [
        "Speed up login process",
        "Store credentials securely in system keychains",
        "Automatically generate passwords",
        "Share credentials across users"
      ],
      correct_answer: 1,
      explanation: "Credential helpers integrate with system keychains (macOS Keychain, Windows Credential Manager, Linux Secret Service) to store credentials more securely than plain config.json."
    },
    {
      question: "How do you login to AWS ECR?",
      options: [
        "docker login ecr.amazonaws.com",
        "aws ecr get-login-password | docker login --username AWS --password-stdin [ECR_URL]",
        "docker login --aws-profile default",
        "docker login --provider aws"
      ],
      correct_answer: 1,
      explanation: "AWS ECR requires getting a temporary password using AWS CLI and piping it to docker login with username 'AWS' and the ECR registry URL."
    },
    {
      question: "Why should you avoid 'docker login -u user -p password' in production?",
      options: [
        "It's slower than other methods",
        "Password visible in command history and process list",
        "It doesn't support special characters",
        "It only works with Docker Hub"
      ],
      correct_answer: 1,
      explanation: "Using -p flag exposes the password in shell history and process listings, making it visible to other users and a security risk. Always use --password-stdin instead."
    }
  ]
  
  unit.code_examples = [
    {
      title: "Secure Docker Hub Login",
      language: "bash",
      code: <<~CODE
        # Set credentials in environment variables (from secret manager)
        export DOCKER_USERNAME="myusername"
        export DOCKER_PASSWORD="mytoken"

        # Login securely using stdin
        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

        # Verify login
        docker info | grep Username

        # Now you can push images
        docker push myusername/myapp:latest
      CODE
    },
    {
      title: "Multi-Registry Authentication",
      language: "bash",
      code: <<~CODE
        # Login to Docker Hub
        echo "$DOCKERHUB_TOKEN" | docker login -u myuser --password-stdin

        # Login to private registry
        echo "$PRIVATE_REGISTRY_PASSWORD" | \\
          docker login registry.company.com -u admin --password-stdin

        # Login to AWS ECR
        aws ecr get-login-password --region us-east-1 | \\
          docker login --username AWS --password-stdin \\
          123456789012.dkr.ecr.us-east-1.amazonaws.com

        # Login to Google GCR
        gcloud auth configure-docker

        # All registries now authenticated
        cat ~/.docker/config.json
      CODE
    },
    {
      title: "CI/CD Pipeline Login Example",
      language: "bash",
      code: <<~CODE
        #!/bin/bash
        # CI/CD deployment script

        set -e  # Exit on error

        # Login to registry (credentials from CI secrets)
        echo "Logging into container registry..."
        echo "$REGISTRY_PASSWORD" | docker login "$REGISTRY_URL" \\
          -u "$REGISTRY_USERNAME" --password-stdin

        # Build image
        echo "Building Docker image..."
        docker build -t "$REGISTRY_URL/myapp:$CI_COMMIT_SHA" .

        # Push image
        echo "Pushing image to registry..."
        docker push "$REGISTRY_URL/myapp:$CI_COMMIT_SHA"

        # Tag as latest
        docker tag "$REGISTRY_URL/myapp:$CI_COMMIT_SHA" "$REGISTRY_URL/myapp:latest"
        docker push "$REGISTRY_URL/myapp:latest"

        # Logout for security
        docker logout "$REGISTRY_URL"

        echo "Deployment complete!"
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Start by logging into Docker Hub to understand the basics",
    "Practice using --password-stdin for secure authentication",
    "Set up credential helpers for your operating system",
    "Try logging into multiple registries and inspect config.json",
    "Test authentication in a simple CI/CD script"
  ]
  
  unit.key_learnings = [
    "docker login authenticates with Docker registries for push/pull access",
    "Use --password-stdin to securely pass credentials in scripts",
    "Credentials stored in ~/.docker/config.json per registry",
    "Credential helpers provide enhanced security via system keychains",
    "Cloud registries (ECR, GCR, ACR) have provider-specific auth methods",
    "Always use service accounts or deploy tokens in CI/CD",
    "Regular credential rotation is essential for security",
    "Docker Hub imposes rate limits based on authentication tier"
  ]
  
  unit.additional_resources = [
    {
      title: "Docker Login Reference",
      url: "https://docs.docker.com/engine/reference/commandline/login/",
      resource_type: "documentation"
    },
    {
      title: "Docker Credential Helpers",
      url: "https://github.com/docker/docker-credential-helpers",
      resource_type: "tool"
    },
    {
      title: "AWS ECR Authentication",
      url: "https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry_auth.html",
      resource_type: "documentation"
    }
  ]
end

# Unit 104: docker logout
InteractiveLearningUnit.find_or_create_by!(
  course_module: registry_module,
  slug: 'docker-logout'
) do |unit|
  unit.title = "docker logout - Remove Registry Authentication"
  unit.description = "Learn when and how to logout from Docker registries to maintain security and manage authentication"
  unit.content = <<~CONTENT
    # Docker Logout - Registry Deauthentication

    Remove stored credentials from Docker registries when they're no longer needed or when switching contexts.

    ## Basic Syntax
    ```bash
    # Logout from Docker Hub (default)
    docker logout

    # Logout from specific registry
    docker logout <registry-url>
    ```

    ## Common Use Cases

    ### Security After Temporary Access
    ```bash
    # After working with production registry
    docker pull registry.company.com/app:latest
    docker logout registry.company.com

    # After CI/CD job completes
    docker push myimage:latest
    docker logout
    ```

    ### Switch Between Accounts
    ```bash
    # Logout from personal account
    docker logout

    # Login to work account
    docker login -u work-account

    # Work with work images
    docker push company/app:v1.0

    # Logout and back to personal
    docker logout
    docker login -u personal-account
    ```

    ## When to Use Logout

    ✅ **Do logout when:**
    - Finishing work on shared/temporary machines
    - Switching between different Docker Hub accounts
    - After CI/CD pipeline completes
    - Rotating credentials
    - Before handing off machine access

    ❌ **Don't need to logout when:**
    - Working on your personal/dedicated development machine
    - Using credential helpers (they manage auth automatically)
    - In containerized CI/CD (container is destroyed anyway)

    ## Security Best Practices

    ### Logout in Scripts
    ```bash
    #!/bin/bash
    # Always logout after push in scripts

    echo "$REGISTRY_PASSWORD" | docker login -u "$REGISTRY_USER" --password-stdin

    docker push myapp:latest

    # Clean up credentials
    docker logout
    ```

    ## Key Takeaways
    - docker logout removes stored registry credentials
    - Important for security on shared machines
    - Include in CI/CD scripts as cleanup step
    - Does not affect already-pulled images or running containers
    - Logout from specific registry or default (Docker Hub)
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 104
  unit.estimated_minutes = 15
  unit.difficulty_level = 'intermediate'
  unit.is_required = true
  unit.category = 'docker-registry'
  
  unit.quiz_questions = [
    {
      question: "What does 'docker logout' remove?",
      options: [
        "All pulled images",
        "Running containers",
        "Stored registry credentials",
        "Docker configuration files"
      ],
      correct_answer: 2,
      explanation: "docker logout only removes stored authentication credentials from ~/.docker/config.json. It does not affect images, containers, or other Docker resources."
    },
    {
      question: "When should you always use docker logout?",
      options: [
        "After every docker pull command",
        "Before creating new containers",
        "On shared workstations after use",
        "After building images"
      ],
      correct_answer: 2,
      explanation: "Always logout on shared/temporary machines to prevent others from using your credentials. It's essential for security on multi-user systems."
    }
  ]
  
  unit.code_examples = [
    {
      title: "Secure Script Pattern with Logout",
      language: "bash",
      code: <<~CODE
        #!/bin/bash
        set -e

        # Login
        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USER" --password-stdin

        # Do work
        docker build -t myapp:latest .
        docker push myapp:latest

        # Always logout (even if push fails)
        trap 'docker logout' EXIT

        echo "Deployment complete and logged out"
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Practice logout after temporary registry access",
    "Add logout to your deployment scripts",
    "Test switching between accounts with logout/login"
  ]
  
  unit.key_learnings = [
    "docker logout removes stored registry credentials",
    "Essential for security on shared workstations",
    "Include as cleanup step in CI/CD scripts",
    "Does not affect existing images or containers",
    "Can logout from specific registry or default Docker Hub"
  ]
end

# Unit 105: docker push
InteractiveLearningUnit.find_or_create_by!(
  course_module: registry_module,
  slug: 'docker-push'
) do |unit|
  unit.title = "docker push - Push Images to Registry"
  unit.description = "Master pushing Docker images to registries with tagging strategies, multi-architecture builds, and distribution best practices"
  unit.content = <<~CONTENT
    # Docker Push - Image Distribution

    Push Docker images to registries for sharing, deployment, and distribution across teams and environments.

    ## Basic Syntax
    ```bash
    docker push [OPTIONS] NAME[:TAG]
    ```

    ## Common Options
    - `--all-tags` or `-a`: Push all tagged images
    - `--disable-content-trust`: Skip image signing (not recommended)
    - `--quiet` or `-q`: Suppress verbose output

    ## Image Naming Convention

    ### Format
    ```
    [registry-host[:port]/][namespace/]repository[:tag]
    ```

    ### Examples
    ```bash
    # Docker Hub (default registry)
    myusername/myapp:latest
    myusername/myapp:v1.0.0

    # Private registry
    registry.company.com:5000/team/app:latest

    # AWS ECR
    123456789012.dkr.ecr.us-east-1.amazonaws.com/myapp:v2.1

    # Google GCR
    gcr.io/my-project/myapp:latest

    # Azure ACR
    myregistry.azurecr.io/myapp:v1.0
    ```

    ## Common Use Cases

    ### 1. Push to Docker Hub
    ```bash
    # Build image
    docker build -t myusername/myapp:v1.0 .

    # Login
    docker login

    # Push
    docker push myusername/myapp:v1.0

    # Push with latest tag too
    docker tag myusername/myapp:v1.0 myusername/myapp:latest
    docker push myusername/myapp:latest
    ```

    ### 2. Push Multiple Tags
    ```bash
    # Build once
    docker build -t myapp:build-123 .

    # Create multiple tags
    docker tag myapp:build-123 myusername/myapp:v1.0.5
    docker tag myapp:build-123 myusername/myapp:v1.0
    docker tag myapp:build-123 myusername/myapp:v1
    docker tag myapp:build-123 myusername/myapp:latest

    # Push all tags
    docker push --all-tags myusername/myapp
    ```

    ## Tagging Strategies

    ### Semantic Versioning
    ```bash
    # Full version
    docker push myusername/myapp:1.2.3

    # Minor version (latest patch)
    docker push myusername/myapp:1.2

    # Major version (latest minor)
    docker push myusername/myapp:1

    # Latest stable
    docker push myusername/myapp:latest
    ```

    ## Production Best Practices

    ### 1. Always Tag with Version
    ```bash
    # ❌ BAD: Only using latest
    docker push myapp:latest

    # ✅ GOOD: Version + latest
    docker push myapp:v1.2.3
    docker push myapp:latest
    ```

    ### 2. Use Immutable Tags for Production
    ```bash
    # Production should use specific versions
    docker push myapp:v1.2.3-prod
    
    # Not just 'latest' or 'prod' (these change)
    ```

    ### 3. Scan Before Pushing
    ```bash
    # Scan for vulnerabilities
    docker scan myapp:latest

    # Only push if scan passes
    if docker scan myapp:latest | grep -q "0 vulnerabilities"; then
      docker push myapp:latest
    else
      echo "Security scan failed, not pushing"
      exit 1
    fi
    ```

    ## Key Takeaways
    - docker push uploads images to registries
    - Proper tagging is critical for version management
    - Always authenticate before pushing
    - Use semantic versioning for production
    - Include build metadata in tags
    - Scan images before pushing to production
    - Enable Content Trust for image signing
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 105
  unit.estimated_minutes = 30
  unit.difficulty_level = 'advanced'
  unit.is_required = true
  unit.category = 'docker-registry'
  
  unit.quiz_questions = [
    {
      question: "What is the correct format for pushing to Docker Hub?",
      options: [
        "docker push myapp:latest",
        "docker push username/myapp:latest",
        "docker push hub.docker.com/myapp:latest",
        "docker push @username/myapp:latest"
      ],
      correct_answer: 1,
      explanation: "Docker Hub requires the format username/repository:tag. The username namespace is required to identify who owns the image."
    },
    {
      question: "What is a production best practice for image tagging?",
      options: [
        "Only use 'latest' tag",
        "Use semantic versioning with specific versions",
        "Use random numbers for tags",
        "Don't use tags at all"
      ],
      correct_answer: 1,
      explanation: "Semantic versioning (v1.2.3) provides clear version tracking and allows rollbacks. Production should use immutable version tags, not just 'latest'."
    },
    {
      question: "What does 'docker push --all-tags' do?",
      options: [
        "Creates new tags automatically",
        "Pushes all tags of a repository at once",
        "Tags all images with 'latest'",
        "Removes old tags"
      ],
      correct_answer: 1,
      explanation: "--all-tags pushes all tagged versions of a repository in a single command, useful when you have multiple tags pointing to the same image."
    }
  ]
  
  unit.code_examples = [
    {
      title: "Complete Build and Push Workflow",
      language: "bash",
      code: <<~CODE
        #!/bin/bash
        set -e

        # Variables
        IMAGE_NAME="myusername/myapp"
        VERSION="1.2.3"
        GIT_SHA=$(git rev-parse --short HEAD)

        # Build image
        docker build -t ${IMAGE_NAME}:build .

        # Create version tags
        docker tag ${IMAGE_NAME}:build ${IMAGE_NAME}:${VERSION}
        docker tag ${IMAGE_NAME}:build ${IMAGE_NAME}:${VERSION}-${GIT_SHA}
        docker tag ${IMAGE_NAME}:build ${IMAGE_NAME}:latest

        # Login to registry
        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

        # Push all versions
        docker push ${IMAGE_NAME}:${VERSION}
        docker push ${IMAGE_NAME}:${VERSION}-${GIT_SHA}
        docker push ${IMAGE_NAME}:latest

        # Logout
        docker logout

        echo "Successfully pushed ${IMAGE_NAME}:${VERSION}"
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Practice pushing to Docker Hub with different tags",
    "Try the complete workflow: build, tag, push, pull, run",
    "Experiment with multi-tag strategies",
    "Test pushing to a local private registry"
  ]
  
  unit.key_learnings = [
    "docker push uploads images to container registries",
    "Image naming follows: [registry]/[namespace]/repository:tag format",
    "Always authenticate with docker login before pushing",
    "Use semantic versioning for production deployments",
    "Multiple tags can point to the same image",
    "Include build metadata in tags for traceability",
    "Enable Content Trust for production image signing",
    "--all-tags pushes all tags of a repository at once"
  ]
  
  unit.additional_resources = [
    {
      title: "Docker Push Reference",
      url: "https://docs.docker.com/engine/reference/commandline/push/",
      resource_type: "documentation"
    }
  ]
end

# Unit 106: docker search
InteractiveLearningUnit.find_or_create_by!(
  course_module: registry_module,
  slug: 'docker-search'
) do |unit|
  unit.title = "docker search - Search Docker Hub for Images"
  unit.description = "Learn to search and discover Docker images on Docker Hub with filters and best practices for selecting trusted images"
  unit.content = <<~CONTENT
    # Docker Search - Discover Container Images

    Search Docker Hub to find public images for your applications, development environments, and infrastructure components.

    ## Basic Syntax
    ```bash
    docker search [OPTIONS] TERM
    ```

    ## Common Options
    - `--filter` or `-f`: Filter results (stars, is-official, is-automated)
    - `--limit`: Maximum number of results (default 25)
    - `--no-trunc`: Don't truncate output
    - `--format`: Format output using Go templates

    ## Basic Usage

    ### Simple Search
    ```bash
    # Search for nginx images
    docker search nginx

    # Search for Python images
    docker search python

    # Search for databases
    docker search postgres
    ```

    ### Filter Results

    #### By Stars (Popularity)
    ```bash
    # Images with at least 100 stars
    docker search --filter stars=100 nginx

    # Images with at least 1000 stars
    docker search --filter stars=1000 ubuntu
    ```

    #### Official Images Only
    ```bash
    # Show only official images
    docker search --filter is-official=true nginx

    # Official database images
    docker search --filter is-official=true mysql
    ```

    ## Understanding Search Results

    ### Result Fields
    - **NAME**: Repository name (user/image or just image for official)
    - **DESCRIPTION**: Short description of the image
    - **STARS**: Number of stars (popularity indicator)
    - **OFFICIAL**: [OK] for Docker Official Images
    - **AUTOMATED**: [OK] for automated builds from GitHub/Bitbucket

    ## Selecting Trusted Images

    ### Priority Order
    1. **Official Images** (highest trust)
       - Maintained by Docker, Inc.
       - Thoroughly reviewed
       - Regular security updates
       ```bash
       docker search --filter is-official=true postgres
       ```

    2. **High Star Count** (community trust)
       - Many users trust and use the image
       ```bash
       docker search --filter stars=500 nginx
       ```

    ## Production Best Practices

    ### 1. Always Prefer Official Images
    ```bash
    # ✅ GOOD: Official image
    docker search --filter is-official=true redis
    docker pull redis:7-alpine

    # ⚠️ CAUTION: Third-party image (verify source first)
    docker pull randomuser/redis
    ```

    ### 2. Verify on Docker Hub
    After searching, visit Docker Hub to:
    - Read full documentation
    - Check supported tags
    - Review Dockerfile source
    - Check last update date
    - Read user reviews

    ### 3. Check Security Scan Results
    ```bash
    # After finding image, scan it
    docker pull nginx:alpine
    docker scan nginx:alpine
    ```

    ## Key Takeaways
    - docker search queries Docker Hub for images
    - Prioritize official images for production use
    - Use filters to find trusted, popular images
    - Always verify images on Docker Hub before use
    - Check security scans and last update dates
    - Read documentation and reviews before pulling
    - Search only shows basic info - visit Docker Hub for details
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 106
  unit.estimated_minutes = 25
  unit.difficulty_level = 'intermediate'
  unit.is_required = true
  unit.category = 'docker-registry'
  
  unit.quiz_questions = [
    {
      question: "What does the [OK] in the OFFICIAL column indicate?",
      options: [
        "Image has no security vulnerabilities",
        "Image is maintained by Docker, Inc.",
        "Image is the most popular",
        "Image is free to use"
      ],
      correct_answer: 1,
      explanation: "The [OK] in the OFFICIAL column means the image is an official Docker image, maintained and vetted by Docker, Inc. These are the most trustworthy images."
    },
    {
      question: "How do you search for only official images?",
      options: [
        "docker search --official nginx",
        "docker search --filter is-official=true nginx",
        "docker search --trusted nginx",
        "docker search -o nginx"
      ],
      correct_answer: 1,
      explanation: "Use --filter is-official=true to show only Docker Official Images, which are maintained by Docker, Inc. and thoroughly reviewed."
    },
    {
      question: "What information does docker search NOT provide?",
      options: [
        "Image name",
        "Star count",
        "Available tags/versions",
        "Official status"
      ],
      correct_answer: 2,
      explanation: "docker search shows basic metadata but not available tags. You must visit Docker Hub or use docker pull to see available image versions."
    },
    {
      question: "What is the recommended first choice for production images?",
      options: [
        "Images with most stars",
        "Official Docker images",
        "Automated builds",
        "Recently updated images"
      ],
      correct_answer: 1,
      explanation: "Official Docker images are the first choice for production because they're maintained by Docker, Inc., thoroughly reviewed, and receive regular security updates."
    }
  ]
  
  unit.code_examples = [
    {
      title: "Comprehensive Image Search",
      language: "bash",
      code: <<~CODE
        # Search for official database images
        docker search --filter is-official=true --limit 5 postgres

        # Find popular nginx images
        docker search --filter stars=100 nginx

        # Search with custom format
        docker search --format "table {{.Name}}\\t{{.StarCount}}\\t{{.IsOfficial}}" python

        # Verify before pulling
        docker search --filter is-official=true alpine
        docker pull alpine:latest
        docker scan alpine:latest
      CODE
    },
    {
      title: "Production Image Selection Script",
      language: "bash",
      code: <<~CODE
        #!/bin/bash
        # Find and validate production-ready images

        IMAGE_TERM="postgres"

        echo "=== Searching for official ${IMAGE_TERM} images ==="
        docker search --filter is-official=true "$IMAGE_TERM"

        echo ""
        echo "=== Popular ${IMAGE_TERM} alternatives (500+ stars) ==="
        docker search --filter stars=500 "$IMAGE_TERM"

        echo ""
        echo "Visit Docker Hub for detailed information:"
        echo "https://hub.docker.com/search?q=${IMAGE_TERM}"
        
        echo ""
        echo "Recommended: Use official image"
        echo "docker pull postgres:15-alpine"
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Practice searching for common images (nginx, postgres, redis)",
    "Compare official vs. community images",
    "Use filters to find high-quality images",
    "Visit Docker Hub to verify search results",
    "Always scan images before production use"
  ]
  
  unit.key_learnings = [
    "docker search queries Docker Hub for public images",
    "Use --filter is-official=true to find Docker Official Images",
    "Star count indicates community trust and popularity",
    "Always verify images on Docker Hub before pulling",
    "Official images are the safest choice for production",
    "Search provides basic info - visit Docker Hub for complete details",
    "Check security scans and last update date before using",
    "Cannot search private registries with docker search"
  ]
  
  unit.additional_resources = [
    {
      title: "Docker Search Reference",
      url: "https://docs.docker.com/engine/reference/commandline/search/",
      resource_type: "documentation"
    },
    {
      title: "Docker Hub",
      url: "https://hub.docker.com/",
      resource_type: "tool"
    },
    {
      title: "Docker Official Images",
      url: "https://docs.docker.com/docker-hub/official_images/",
      resource_type: "guide"
    }
  ]
end

puts "✓ Created 4 Docker Registry interactive learning units (103-106)"
puts "✓ All 106 Docker Fundamentals units complete!"
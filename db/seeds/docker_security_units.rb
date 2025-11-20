puts "Creating Docker Security Interactive Learning Units..."

course = Course.find_by(slug: 'docker-fundamentals')
security_module = course.course_modules.find_or_create_by!(slug: 'docker-security') do |m|
  m.title = "Docker Security & Secrets"
  m.description = "Secure your Docker deployments with secrets management and image signing"
  m.sequence_order = 8
  m.estimated_minutes = 125
  m.published = true
end

# Unit 98: docker secret create
InteractiveLearningUnit.find_or_create_by!(
  course_module: security_module,
  slug: 'docker-secret-create'
) do |unit|
  unit.title = "docker secret create - Create Docker Secrets"
  unit.description = "Learn to securely store sensitive data like passwords, API keys, and certificates using Docker secrets in Swarm mode"
  unit.content = <<~CONTENT
    # Docker Secret Create - Secure Secrets Management

    ## What Are Docker Secrets?

    Docker secrets provide a secure way to store and manage sensitive data such as:
    - **Passwords** for databases and services
    - **API keys** and tokens
    - **TLS certificates** and private keys
    - **SSH keys** for remote access
    - **Configuration files** with sensitive data

    Secrets are encrypted during transit and at rest in the Swarm, and are only mounted in memory for containers that need them.

    ## Core Concepts

    ### Security Features
    - **Encryption at Rest**: Secrets are encrypted in the Swarm raft log
    - **Encryption in Transit**: TLS-encrypted when transmitted to nodes
    - **Access Control**: Only containers with explicit access can read secrets
    - **Memory-Only Mount**: Secrets never written to disk in containers
    - **Automatic Rotation**: Update secrets without rebuilding images

    ### Secret Lifecycle
    1. **Create**: Store sensitive data as a secret
    2. **Grant Access**: Assign secrets to services
    3. **Mount**: Secrets appear as files in `/run/secrets/`
    4. **Rotate**: Update secrets for security compliance
    5. **Remove**: Delete secrets when no longer needed

    ## Basic Syntax

    ```bash
    # Create from stdin
    docker secret create <secret-name> -

    # Create from file
    docker secret create <secret-name> <file-path>

    # With labels
    docker secret create --label env=production <secret-name> <file>
    ```

    ## Common Use Cases

    ### 1. Database Credentials
    ```bash
    # Create database password from stdin
    echo "mySecurePassword123!" | docker secret create db_password -

    # Create from environment variable
    echo "$DB_PASSWORD" | docker secret create db_password -

    # Use in service
    docker service create \\
      --name postgres \\
      --secret db_password \\
      -e POSTGRES_PASSWORD_FILE=/run/secrets/db_password \\
      postgres:15
    ```

    ### 2. API Keys and Tokens
    ```bash
    # Create API key from file
    echo "sk-abc123def456" > /tmp/api_key.txt
    docker secret create openai_api_key /tmp/api_key.txt
    rm /tmp/api_key.txt  # Remove temporary file

    # Use in application
    docker service create \\
      --name api-service \\
      --secret openai_api_key \\
      -e API_KEY_FILE=/run/secrets/openai_api_key \\
      my-api-app:latest
    ```

    ### 3. TLS Certificates
    ```bash
    # Create certificate and key secrets
    docker secret create server_cert server.crt
    docker secret create server_key server.key

    # Use in nginx service
    docker service create \\
      --name web \\
      --secret server_cert \\
      --secret server_key \\
      --publish 443:443 \\
      nginx:alpine
    ```

    ### 4. Configuration Files with Sensitive Data
    ```bash
    # Create config file with credentials
    cat > app_config.json <<EOF
    {
      "database": {
        "host": "db.example.com",
        "username": "admin",
        "password": "secure_pass_123"
      },
      "api_keys": {
        "stripe": "sk_live_abc123",
        "sendgrid": "SG.xyz789"
      }
    }
    EOF

    docker secret create app_config app_config.json
    rm app_config.json
    ```

    ### 5. SSH Keys for Git Access
    ```bash
    # Create SSH key secret for private repos
    docker secret create github_ssh_key ~/.ssh/github_deploy_key

    # Use in CI/CD container
    docker service create \\
      --name ci-runner \\
      --secret github_ssh_key \\
      -e SSH_KEY_FILE=/run/secrets/github_ssh_key \\
      gitlab/gitlab-runner:latest
    ```

    ## Advanced Options

    ### Labels and Metadata
    ```bash
    # Create with descriptive labels
    docker secret create \\
      --label environment=production \\
      --label tier=database \\
      --label rotation_date=2025-03-01 \\
      prod_db_password -

    # Create with team ownership
    docker secret create \\
      --label team=backend \\
      --label owner=alice@example.com \\
      backend_api_key -
    ```

    ### Template Variable Pattern
    ```bash
    # Create secrets for different environments
    for env in dev staging prod; do
      echo "$\{${env}_db_password\}" | \\
        docker secret create "${env}_db_password" -
    done

    # Use environment-specific secrets
    docker service create \\
      --name app-prod \\
      --secret prod_db_password \\
      --env ENVIRONMENT=production \\
      myapp:latest
    ```

    ## Reading Secrets in Containers

    ### Bash/Shell Scripts
    ```bash
    #!/bin/bash
    # Read secret from file
    DB_PASSWORD=$(cat /run/secrets/db_password)
    
    # Connect to database
    psql -h db -U admin -W "$DB_PASSWORD" mydb
    ```

    ### Python Applications
    ```python
    # Read secret in Python
    def read_secret(secret_name):
        try:
            with open(f'/run/secrets/{secret_name}', 'r') as f:
                return f.read().strip()
        except FileNotFoundError:
            return None

    db_password = read_secret('db_password')
    api_key = read_secret('api_key')
    ```

    ### Node.js Applications
    ```javascript
    const fs = require('fs');

    function readSecret(secretName) {
      try {
        return fs.readFileSync(
          `/run/secrets/${secretName}`, 
          'utf8'
        ).trim();
      } catch (err) {
        return null;
      }
    }

    const dbPassword = readSecret('db_password');
    ```

    ## Production Best Practices

    ### 1. Secret Naming Convention
    ```bash
    # Use descriptive, hierarchical names
    docker secret create prod_mysql_root_password -
    docker secret create staging_redis_password -
    docker secret create api_stripe_secret_key -
    ```

    ### 2. Never Commit Secrets to Version Control
    ```bash
    # Store in secure vault, load at runtime
    vault read -field=value secret/db/password | \\
      docker secret create db_password -
    ```

    ### 3. Implement Secret Rotation
    ```bash
    # Create new version of secret
    echo "newPassword456" | docker secret create db_password_v2 -

    # Update service to use new secret
    docker service update \\
      --secret-rm db_password \\
      --secret-add db_password_v2 \\
      my-service

    # Remove old secret after verification
    docker secret rm db_password
    ```

    ### 4. Use Least Privilege
    ```bash
    # Only grant secrets to services that need them
    docker service create \\
      --name frontend \\
      # No secrets - public facing
      nginx:alpine

    docker service create \\
      --name backend \\
      --secret db_password \\
      --secret api_key \\
      # Only necessary secrets
      my-backend:latest
    ```

    ### 5. Audit and Monitor Secret Usage
    ```bash
    # List secrets with labels
    docker secret ls --filter label=environment=production

    # Inspect which services use a secret
    docker secret inspect --format '{{.Spec.Name}}' db_password
    docker service ls --filter label=uses_secrets=true
    ```

    ## Common Pitfalls to Avoid

    ❌ **Don't use environment variables for secrets**
    ```bash
    # BAD - visible in process list and docker inspect
    docker service create -e PASSWORD=secret123 myapp
    ```

    ✅ **Use Docker secrets instead**
    ```bash
    # GOOD - encrypted and access-controlled
    echo "secret123" | docker secret create password -
    docker service create --secret password myapp
    ```

    ❌ **Don't store secrets in images**
    ```dockerfile
    # BAD - secrets baked into image layers
    RUN echo "password123" > /etc/app/secret
    ```

    ✅ **Mount secrets at runtime**
    ```bash
    # GOOD - secrets injected at runtime
    docker service create --secret app_secret myapp
    ```

    ## Comparison with Other Secret Management

    | Feature | Docker Secrets | Environment Variables | Config Files |
    |---------|---------------|----------------------|--------------|
    | Encryption | ✅ Yes | ❌ No | ❌ No |
    | Memory-Only | ✅ Yes | ❌ No | ❌ No |
    | Swarm Required | ✅ Yes | ❌ No | ❌ No |
    | Easy Rotation | ✅ Yes | ⚠️ Manual | ⚠️ Manual |
    | Access Control | ✅ Granular | ❌ Limited | ❌ Limited |

    ## Key Takeaways

    - **Secrets are encrypted** at rest and in transit
    - **Swarm mode required** - secrets only work in Swarm
    - **Mount as files** in `/run/secrets/` directory
    - **Access control** - only authorized services can read
    - **No disk writes** - secrets stay in memory only
    - **Use for sensitive data** like passwords, keys, certificates
    - **Implement rotation** for enhanced security compliance
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 98
  unit.estimated_minutes = 30
  unit.difficulty_level = 'advanced'
  unit.is_required = true
  unit.category = 'docker-security'
  
  unit.quiz_questions = [
    {
      question: "Where are Docker secrets mounted inside containers?",
      options: [
        "/etc/secrets/",
        "/var/secrets/",
        "/run/secrets/",
        "/opt/secrets/"
      ],
      correct_answer: 2,
      explanation: "Docker secrets are mounted as files in the /run/secrets/ directory, which is a memory-only filesystem (tmpfs), ensuring secrets are never written to disk."
    },
    {
      question: "What is a key security advantage of Docker secrets over environment variables?",
      options: [
        "Secrets are faster to access",
        "Secrets are easier to configure",
        "Secrets are encrypted at rest and in transit",
        "Secrets can be larger in size"
      ],
      correct_answer: 2,
      explanation: "Docker secrets are encrypted during transit and at rest in the Swarm raft log, while environment variables are stored in plain text and visible via docker inspect."
    },
    {
      question: "Which command creates a secret from stdin?",
      options: [
        "docker secret create mysecret < secret.txt",
        "echo 'password' | docker secret create mysecret -",
        "docker secret create mysecret --stdin",
        "cat secret.txt | docker secret add mysecret"
      ],
      correct_answer: 1,
      explanation: "Use 'echo \"password\" | docker secret create mysecret -' where the dash (-) indicates to read from stdin. This is useful for creating secrets without temporary files."
    },
    {
      question: "What happens to secrets when a container is removed?",
      options: [
        "Secrets are deleted from Swarm",
        "Secrets remain in Swarm and can be reused",
        "Secrets are archived to logs",
        "Secrets are backed up automatically"
      ],
      correct_answer: 1,
      explanation: "Secrets persist in the Swarm even after containers are removed. They remain available for other services unless explicitly deleted with 'docker secret rm'."
    },
    {
      question: "Why is Docker Swarm mode required for secrets?",
      options: [
        "For better performance",
        "For encryption and distributed secret management",
        "For easier CLI commands",
        "For Docker Hub integration"
      ],
      correct_answer: 1,
      explanation: "Swarm mode provides the encrypted raft log for storing secrets, TLS-encrypted communication between nodes, and the orchestration needed for secure secret distribution across the cluster."
    }
  ]
  
  unit.code_examples = [
    {
      title: "Basic Secret Creation and Usage",
      language: "bash",
      code: <<~CODE
        # Initialize Swarm (required for secrets)
        docker swarm init

        # Create a database password secret
        echo "mySecureDbPassword123" | docker secret create db_password -

        # Create a service that uses the secret
        docker service create \\
          --name postgres \\
          --secret db_password \\
          -e POSTGRES_PASSWORD_FILE=/run/secrets/db_password \\
          postgres:15

        # Verify secret exists
        docker secret ls

        # Inside container, secret is accessible as file
        docker exec $(docker ps -q -f name=postgres) cat /run/secrets/db_password
      CODE
    },
    {
      title: "Multi-Secret Application Setup",
      language: "bash",
      code: <<~CODE
        # Create multiple secrets for an application
        echo "admin_db_pass_2025" | docker secret create db_password -
        echo "sk_live_abc123xyz789" | docker secret create stripe_api_key -
        echo "smtp_password_456" | docker secret create email_password -

        # Create service with multiple secrets
        docker service create \\
          --name backend-api \\
          --secret db_password \\
          --secret stripe_api_key \\
          --secret email_password \\
          --env DATABASE_PASSWORD_FILE=/run/secrets/db_password \\
          --env STRIPE_KEY_FILE=/run/secrets/stripe_api_key \\
          --env EMAIL_PASSWORD_FILE=/run/secrets/email_password \\
          my-backend-app:latest

        # Application reads secrets from files
        # Example Python code:
        # db_pass = open('/run/secrets/db_password').read().strip()
      CODE
    },
    {
      title: "Secret Rotation Pattern",
      language: "bash",
      code: <<~CODE
        # Step 1: Create new version of secret
        echo "newRotatedPassword2025" | docker secret create db_password_v2 -

        # Step 2: Update service to use new secret
        docker service update \\
          --secret-rm db_password \\
          --secret-add source=db_password_v2,target=db_password \\
          my-service

        # Step 3: Verify service is healthy with new secret
        docker service ps my-service

        # Step 4: Remove old secret after successful rotation
        docker secret rm db_password

        # Step 5: Rename new secret for consistency (optional)
        # Note: Docker doesn't support renaming, so track versions with labels
        docker secret inspect db_password_v2
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Start with a simple password secret before moving to files and certificates",
    "Always remove temporary files after creating secrets from them",
    "Test secret access by execing into a container and reading /run/secrets/",
    "Use labels to track secret metadata like creation date and rotation schedule",
    "Practice secret rotation to understand the update workflow"
  ]
  
  unit.key_learnings = [
    "Docker secrets provide encrypted storage for sensitive data in Swarm mode",
    "Secrets are mounted as read-only files in /run/secrets/ (memory-only)",
    "Create secrets from stdin with 'docker secret create name -' to avoid temp files",
    "Secrets are encrypted at rest in raft log and in transit over TLS",
    "Only services explicitly granted access can read secrets",
    "Implement secret rotation by creating new versions and updating services",
    "Secrets are superior to environment variables for sensitive data"
  ]
  
  unit.additional_resources = [
    {
      title: "Docker Secrets Documentation",
      url: "https://docs.docker.com/engine/swarm/secrets/",
      resource_type: "documentation"
    },
    {
      title: "Managing Sensitive Data in Docker",
      url: "https://docs.docker.com/engine/security/secrets/",
      resource_type: "guide"
    },
    {
      title: "Docker Security Best Practices",
      url: "https://docs.docker.com/engine/security/",
      resource_type: "best_practices"
    }
  ]
end

# Unit 99: docker secret inspect
InteractiveLearningUnit.find_or_create_by!(
  course_module: security_module,
  slug: 'docker-secret-inspect'
) do |unit|
  unit.title = "docker secret inspect - Display Secret Details"
  unit.description = "Learn to inspect Docker secrets to view metadata, creation dates, labels, and usage information for security auditing"
  unit.content = <<~CONTENT
    # Docker Secret Inspect - Audit and Analyze Secrets

    ## What Is Secret Inspection?

    The `docker secret inspect` command displays detailed metadata about secrets including:
    - **Creation and update timestamps**
    - **Labels** for organization and tracking
    - **Secret ID** for unique identification
    - **Version information** from the raft log
    - **Size** of the secret data

    **Important**: The actual secret value is **never displayed** - only metadata is shown for security.

    ## Core Concepts

    ### Metadata vs. Secret Data
    - **Metadata**: Name, labels, timestamps, ID (safe to view)
    - **Secret Data**: Actual password, key, certificate (never shown)
    - **Access Control**: Metadata is visible to managers, data only to authorized containers

    ### Secret Lifecycle Tracking
    Inspect helps track:
    - **When secrets were created** (compliance auditing)
    - **Which version** is current (rotation tracking)
    - **What labels** are assigned (organization)
    - **Secret size** (storage planning)

    ## Basic Syntax

    ```bash
    # Inspect single secret
    docker secret inspect <secret-name>

    # Inspect multiple secrets
    docker secret inspect <secret1> <secret2> <secret3>

    # Format output for specific fields
    docker secret inspect --format '{{.Spec.Name}}' <secret-name>
    ```

    ## Common Use Cases

    ### 1. View Secret Metadata
    ```bash
    # Full JSON output
    docker secret inspect db_password

    # Output example:
    # [
    #   {
    #     "ID": "abc123xyz789",
    #     "Version": {
    #       "Index": 12
    #     },
    #     "CreatedAt": "2025-01-15T10:30:00.123456Z",
    #     "UpdatedAt": "2025-01-15T10:30:00.123456Z",
    #     "Spec": {
    #       "Name": "db_password",
    #       "Labels": {
    #         "environment": "production",
    #         "rotation_date": "2025-03-01"
    #       }
    #     }
    #   }
    # ]
    ```

    ### 2. Check Secret Creation Date
    ```bash
    # View when secret was created (for audit compliance)
    docker secret inspect --format '{{.CreatedAt}}' db_password
    # Output: 2025-01-15T10:30:00.123456Z

    # Check multiple secrets' ages
    for secret in $(docker secret ls -q); do
      echo -n "$(docker secret inspect --format '{{.Spec.Name}}' $secret): "
      docker secret inspect --format '{{.CreatedAt}}' $secret
    done
    ```

    ### 3. View Secret Labels
    ```bash
    # Check all labels on a secret
    docker secret inspect --format '{{json .Spec.Labels}}' api_key | jq

    # Check specific label value
    docker secret inspect \\
      --format '{{index .Spec.Labels "environment"}}' \\
      db_password

    # Filter secrets by label
    docker secret ls --filter label=environment=production
    ```

    ### 4. Audit Secret Rotation Schedule
    ```bash
    # View rotation metadata
    docker secret inspect --format '{{json .Spec.Labels}}' db_password
    # {
    #   "last_rotation": "2025-01-15",
    #   "next_rotation": "2025-04-15",
    #   "rotation_frequency": "quarterly"
    # }

    # Check which secrets need rotation
    docker secret ls --format 'table {{.Name}}\t{{.CreatedAt}}' | \\
      awk 'NR>1 {print $0}'
    ```

    ### 5. Verify Secret Exists Before Use
    ```bash
    # Check if secret exists in deployment script
    if docker secret inspect db_password &>/dev/null; then
      echo "Secret exists, deploying service..."
      docker service create --secret db_password myapp
    else
      echo "Error: db_password secret not found!"
      exit 1
    fi
    ```

    ## Advanced Formatting

    ### Extract Specific Fields
    ```bash
    # Get secret ID
    docker secret inspect --format '{{.ID}}' db_password

    # Get secret name
    docker secret inspect --format '{{.Spec.Name}}' db_password

    # Get version index
    docker secret inspect --format '{{.Version.Index}}' db_password

    # Get all labels as JSON
    docker secret inspect --format '{{json .Spec.Labels}}' db_password | jq
    ```

    ### Formatted Table Output
    ```bash
    # Create custom table of all secrets
    docker secret ls --format 'table {{.ID}}\t{{.Name}}\t{{.CreatedAt}}' | \\
      head -n 10

    # Compare multiple secrets side by side
    docker secret inspect \\
      --format '{{.Spec.Name}}: Created {{.CreatedAt}}' \\
      db_password api_key tls_cert
    ```

    ### Batch Inspection Script
    ```bash
    #!/bin/bash
    # Inspect all secrets and generate report

    echo "=== Secret Audit Report ==="
    echo "Generated: $(date)"
    echo ""

    for secret in $(docker secret ls -q); do
      name=$(docker secret inspect --format '{{.Spec.Name}}' $secret)
      created=$(docker secret inspect --format '{{.CreatedAt}}' $secret)
      labels=$(docker secret inspect --format '{{json .Spec.Labels}}' $secret)
      
      echo "Secret: $name"
      echo "  Created: $created"
      echo "  Labels: $labels"
      echo ""
    done
    ```

    ## Security Auditing Use Cases

    ### 1. Compliance Reporting
    ```bash
    # Generate secret age report for compliance
    docker secret ls --format '{{.Name}}' | while read secret; do
      created=$(docker secret inspect --format '{{.CreatedAt}}' $secret)
      echo "$secret,$created"
    done > secret_audit_$(date +%Y%m%d).csv
    ```

    ### 2. Find Secrets Without Proper Labels
    ```bash
    # Find secrets missing required labels
    docker secret ls -q | while read secret; do
      labels=$(docker secret inspect --format '{{json .Spec.Labels}}' $secret)
      if [[ "$labels" == "null" ]] || [[ "$labels" == "{}" ]]; then
        name=$(docker secret inspect --format '{{.Spec.Name}}' $secret)
        echo "WARNING: $name has no labels"
      fi
    done
    ```

    ### 3. Track Secret Usage by Services
    ```bash
    # Check which services use a secret (requires service inspection)
    SECRET_NAME="db_password"
    echo "Services using secret '$SECRET_NAME':"

    docker service ls -q | while read service; do
      if docker service inspect --format '{{range .Spec.TaskTemplate.ContainerSpec.Secrets}}{{.SecretName}}{{end}}' $service | grep -q "$SECRET_NAME"; then
        service_name=$(docker service inspect --format '{{.Spec.Name}}' $service)
        echo "  - $service_name"
      fi
    done
    ```

    ### 4. Verify Secret Rotation Dates
    ```bash
    # Check secrets older than 90 days
    THRESHOLD_DAYS=90
    CURRENT_TIMESTAMP=$(date +%s)

    docker secret ls -q | while read secret; do
      created=$(docker secret inspect --format '{{.CreatedAt}}' $secret)
      created_timestamp=$(date -d "$created" +%s)
      age_days=$(( ($CURRENT_TIMESTAMP - $created_timestamp) / 86400 ))
      
      if [ $age_days -gt $THRESHOLD_DAYS ]; then
        name=$(docker secret inspect --format '{{.Spec.Name}}' $secret)
        echo "⚠️  $name is $age_days days old (rotation needed)"
      fi
    done
    ```

    ## Production Best Practices

    ### 1. Document Secrets with Labels
    ```bash
    # Create secrets with comprehensive metadata
    echo "password123" | docker secret create db_password - \\
      --label owner=backend-team \\
      --label environment=production \\
      --label created_by=deploy-script \\
      --label rotation_schedule=quarterly \\
      --label compliance=pci-dss
    ```

    ### 2. Regular Secret Audits
    ```bash
    # Weekly audit script (add to cron)
    #!/bin/bash
    REPORT_FILE="/var/log/docker-secrets-$(date +%Y%m%d).log"
    
    {
      echo "=== Docker Secrets Audit ==="
      echo "Date: $(date)"
      docker secret ls
      echo ""
      echo "=== Secret Details ==="
      docker secret ls -q | while read s; do
        docker secret inspect $s
      done
    } > "$REPORT_FILE"
    ```

    ### 3. Integrate with Monitoring
    ```bash
    # Export secret metadata to monitoring system
    docker secret ls --format '{{json .}}' | \\
      jq -c '.[] | {name: .Name, created: .CreatedAt, updated: .UpdatedAt}' | \\
      curl -X POST -d @- https://monitoring.example.com/api/secrets
    ```

    ## Common Patterns

    ### Secret Existence Check in Scripts
    ```bash
    # Deployment script with secret validation
    REQUIRED_SECRETS=("db_password" "api_key" "tls_cert")

    for secret in "${REQUIRED_SECRETS[@]}"; do
      if ! docker secret inspect "$secret" &>/dev/null; then
        echo "ERROR: Required secret '$secret' not found"
        exit 1
      fi
    done

    echo "All required secrets present, proceeding with deployment..."
    ```

    ### Diff Secrets Between Environments
    ```bash
    # Compare production vs staging secrets
    echo "=== Production Secrets ==="
    docker secret ls --format '{{.Name}}'

    echo ""
    echo "=== Staging Secrets ==="
    docker -H staging-swarm:2376 secret ls --format '{{.Name}}'
    ```

    ## Key Takeaways

    - **Inspect shows metadata only** - actual secret values are never displayed
    - **Use for auditing** - track creation dates, labels, and versions
    - **Format output** with `--format` for custom reporting and scripts
    - **Label secrets** for better organization and compliance tracking
    - **Regular audits** help maintain security posture and rotation schedules
    - **Verify existence** before deployment to catch missing secrets early
    - **Integrate with compliance** tools for automated security reporting
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 99
  unit.estimated_minutes = 20
  unit.difficulty_level = 'advanced'
  unit.is_required = true
  unit.category = 'docker-security'
  
  unit.quiz_questions = [
    {
      question: "What information does 'docker secret inspect' NOT show?",
      options: [
        "Secret creation date",
        "Secret labels",
        "The actual secret value",
        "Secret ID"
      ],
      correct_answer: 2,
      explanation: "docker secret inspect shows metadata like creation date, labels, and ID, but NEVER shows the actual secret value for security reasons. Secret values can only be read by authorized containers."
    },
    {
      question: "Which command extracts only the creation date of a secret?",
      options: [
        "docker secret inspect --get CreatedAt secret_name",
        "docker secret inspect --format '{{.CreatedAt}}' secret_name",
        "docker secret inspect --show-date secret_name",
        "docker secret ls --date secret_name"
      ],
      correct_answer: 1,
      explanation: "Use --format '{{.CreatedAt}}' to extract specific fields from the JSON output. The format flag uses Go template syntax to select individual fields."
    },
    {
      question: "Why is secret inspection useful for compliance auditing?",
      options: [
        "It reveals passwords for security teams",
        "It tracks creation dates and rotation schedules",
        "It automatically rotates old secrets",
        "It encrypts secrets with new keys"
      ],
      correct_answer: 1,
      explanation: "Inspection provides metadata like creation timestamps and labels that help track when secrets were created and when they need rotation, essential for compliance requirements."
    }
  ]
  
  unit.code_examples = [
    {
      title: "Basic Secret Inspection",
      language: "bash",
      code: <<~CODE
        # Create a secret with labels
        echo "mypassword123" | docker secret create db_password - \\
          --label environment=production \\
          --label owner=backend-team \\
          --label rotation_date=2025-06-01

        # Inspect full metadata
        docker secret inspect db_password

        # Extract specific fields
        docker secret inspect --format '{{.Spec.Name}}' db_password
        docker secret inspect --format '{{.CreatedAt}}' db_password
        docker secret inspect --format '{{json .Spec.Labels}}' db_password | jq
      CODE
    },
    {
      title: "Secret Audit Report Script",
      language: "bash",
      code: <<~CODE
        #!/bin/bash
        # Generate comprehensive secret audit report

        echo "=== Docker Secret Audit Report ==="
        echo "Generated: $(date)"
        echo "=========================================="
        echo ""

        # Count total secrets
        total_secrets=$(docker secret ls -q | wc -l)
        echo "Total Secrets: $total_secrets"
        echo ""

        # List all secrets with details
        docker secret ls -q | while read secret_id; do
          name=$(docker secret inspect --format '{{.Spec.Name}}' $secret_id)
          created=$(docker secret inspect --format '{{.CreatedAt}}' $secret_id)
          labels=$(docker secret inspect --format '{{json .Spec.Labels}}' $secret_id)
          
          echo "Secret: $name"
          echo "  ID: $secret_id"
          echo "  Created: $created"
          echo "  Labels: $labels"
          echo ""
        done

        # Find secrets older than 90 days
        echo "=== Secrets Requiring Rotation (>90 days) ==="
        # Implementation for date comparison would go here
      CODE
    },
    {
      title: "Pre-Deployment Secret Validation",
      language: "bash",
      code: <<~CODE
        #!/bin/bash
        # Validate all required secrets exist before deployment

        REQUIRED_SECRETS=(
          "db_password"
          "redis_password"
          "api_key"
          "jwt_secret"
          "tls_cert"
          "tls_key"
        )

        echo "Validating required secrets..."
        missing_secrets=()

        for secret in "${REQUIRED_SECRETS[@]}"; do
          if docker secret inspect "$secret" &>/dev/null; then
            created=$(docker secret inspect --format '{{.CreatedAt}}' "$secret")
            echo "✓ $secret (created: $created)"
          else
            echo "✗ $secret - MISSING"
            missing_secrets+=("$secret")
          fi
        done

        if [ ${#missing_secrets[@]} -gt 0 ]; then
          echo ""
          echo "ERROR: Missing ${#missing_secrets[@]} required secret(s)"
          echo "Create missing secrets before deployment:"
          for secret in "${missing_secrets[@]}"; do
            echo "  docker secret create $secret -"
          done
          exit 1
        fi

        echo ""
        echo "✓ All required secrets are present"
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Practice inspecting secrets you create to understand the metadata structure",
    "Try different --format templates to extract specific fields",
    "Create a simple audit script to list all secrets and their ages",
    "Use jq to format JSON output for better readability"
  ]
  
  unit.key_learnings = [
    "docker secret inspect shows metadata only, never the actual secret value",
    "Use --format flag with Go templates to extract specific fields",
    "CreatedAt and UpdatedAt timestamps help track secret lifecycle",
    "Labels provide custom metadata for organization and compliance tracking",
    "Inspection is essential for security audits and rotation schedules",
    "Verify secret existence before deployment to catch configuration errors"
  ]
  
  unit.additional_resources = [
    {
      title: "Docker Secret Inspect Reference",
      url: "https://docs.docker.com/engine/reference/commandline/secret_inspect/",
      resource_type: "documentation"
    }
  ]
end

# Unit 100: docker secret ls
InteractiveLearningUnit.find_or_create_by!(
  course_module: security_module,
  slug: 'docker-secret-ls'
) do |unit|
  unit.title = "docker secret ls - List All Secrets"
  unit.description = "Master listing and filtering Docker secrets to manage and organize sensitive data across your Swarm cluster"
  unit.content = <<~CONTENT
    # Docker Secret ls - List and Manage Secrets

    List all secrets in your Swarm cluster with filtering, formatting, and sorting capabilities for effective secret management.

    ## Basic Syntax
    ```bash
    docker secret ls [OPTIONS]
    ```

    ## Common Options
    - `--filter` or `-f`: Filter output (e.g., by label, name)
    - `--format`: Format output using Go templates
    - `--quiet` or `-q`: Only show secret IDs

    ## Usage Examples

    ### List All Secrets
    ```bash
    docker secret ls
    ```

    ### Filter by Label
    ```bash
    docker secret ls --filter label=environment=production
    ```

    ### Show Only IDs
    ```bash
    docker secret ls -q
    ```

    ### Custom Format
    ```bash
    docker secret ls --format "table {{.Name}}\t{{.CreatedAt}}"
    ```

    ## Key Takeaways
    - List secrets for inventory management
    - Use filters to find specific secrets
    - Format output for scripts and reports
    - Monitor secret count and organization
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 100
  unit.estimated_minutes = 20
  unit.difficulty_level = 'advanced'
  unit.is_required = true
  unit.category = 'docker-security'
  
  unit.quiz_questions = [
    {
      question: "What does 'docker secret ls -q' output?",
      options: [
        "Secret names only",
        "Secret IDs only",
        "Secret values",
        "Full secret metadata"
      ],
      correct_answer: 1,
      explanation: "The -q or --quiet flag outputs only secret IDs, useful for scripting and batch operations."
    },
    {
      question: "How do you list secrets filtered by a specific label?",
      options: [
        "docker secret ls --label env=prod",
        "docker secret ls --filter label=env=prod",
        "docker secret ls -l env=prod",
        "docker secret ls --where label=env=prod"
      ],
      correct_answer: 1,
      explanation: "Use --filter label=key=value to filter secrets by labels. This helps organize and find secrets in large deployments."
    }
  ]
  
  unit.code_examples = [
    {
      title: "List and Filter Secrets",
      language: "bash",
      code: <<~CODE
        # List all secrets
        docker secret ls

        # List production secrets
        docker secret ls --filter label=environment=production

        # Get secret IDs for batch operations
        docker secret ls -q

        # Custom formatted output
        docker secret ls --format "table {{.Name}}\t{{.CreatedAt}}\t{{.UpdatedAt}}"
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Practice filtering secrets by different label criteria",
    "Create custom format strings for reporting",
    "Use -q flag when writing scripts that process secrets"
  ]
  
  unit.key_learnings = [
    "docker secret ls shows all secrets in the Swarm",
    "Use --filter to narrow down secret lists by labels or names",
    "Format output for integration with scripts and monitoring tools",
    "Quiet mode (-q) outputs only IDs for batch processing"
  ]
end

# Unit 101: docker secret rm
InteractiveLearningUnit.find_or_create_by!(
  course_module: security_module,
  slug: 'docker-secret-rm'
) do |unit|
  unit.title = "docker secret rm - Remove Secrets"
  unit.description = "Learn to safely remove Docker secrets and manage the secret lifecycle in production environments"
  unit.content = <<~CONTENT
    # Docker Secret rm - Safe Secret Removal

    Remove Docker secrets safely while ensuring no active services are using them.

    ## Basic Syntax
    ```bash
    docker secret rm SECRET [SECRET...]
    ```

    ## Usage Examples

    ### Remove Single Secret
    ```bash
    docker secret rm old_api_key
    ```

    ### Remove Multiple Secrets
    ```bash
    docker secret rm secret1 secret2 secret3
    ```

    ### Remove All Unused Secrets (Careful!)
    ```bash
    # Get list of secrets and filter manually
    docker secret ls
    docker secret rm unused_secret1 unused_secret2
    ```

    ## Safety Practices

    ### Check Secret Usage Before Removal
    ```bash
    # List services using a secret
    docker service ls --filter label=uses_secret=db_password

    # Only remove if no services reference it
    if [ $(docker service ls -q --filter label=uses_secret=db_password | wc -l) -eq 0 ]; then
      docker secret rm db_password
    fi
    ```

    ### Safe Secret Rotation
    ```bash
    # 1. Create new secret version
    echo "newpassword" | docker secret create db_password_v2 -

    # 2. Update all services to use new secret
    docker service update --secret-rm db_password --secret-add db_password_v2 myservice

    # 3. Verify services are healthy
    docker service ps myservice

    # 4. Remove old secret
    docker secret rm db_password
    ```

    ## Key Takeaways
    - Cannot remove secrets in use by services
    - Always verify no services reference the secret first
    - Use secret rotation workflow for safe updates
    - Batch remove multiple secrets at once
    - Removal is permanent - ensure backups if needed
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 101
  unit.estimated_minutes = 20
  unit.difficulty_level = 'advanced'
  unit.is_required = true
  unit.category = 'docker-security'
  
  unit.quiz_questions = [
    {
      question: "What happens if you try to remove a secret that's in use by a service?",
      options: [
        "Secret is removed and service stops",
        "Command fails with an error",
        "Secret is marked for deletion",
        "Service automatically updates"
      ],
      correct_answer: 1,
      explanation: "Docker prevents removal of secrets that are currently in use by services, returning an error to protect running applications from losing access to required secrets."
    },
    {
      question: "What is the recommended approach for updating a secret?",
      options: [
        "Remove old secret, create new secret with same name",
        "Create new secret version, update services, remove old secret",
        "Edit the secret in place",
        "Restart all services first, then update secret"
      ],
      correct_answer: 1,
      explanation: "The safe rotation pattern: create new secret version, update services to use it, verify health, then remove the old secret. This prevents service disruption."
    }
  ]
  
  unit.code_examples = [
    {
      title: "Safe Secret Removal Workflow",
      language: "bash",
      code: <<~CODE
        # Check if secret is in use before removing
        SECRET_NAME="old_api_key"

        # Try to find services using this secret
        USING_SERVICES=$(docker service ls -q --filter label=uses_$SECRET_NAME)

        if [ -z "$USING_SERVICES" ]; then
          echo "No services using $SECRET_NAME, safe to remove"
          docker secret rm $SECRET_NAME
          echo "Secret removed successfully"
        else
          echo "WARNING: Secret is still in use by services:"
          docker service ls --filter label=uses_$SECRET_NAME
          echo "Update services before removing secret"
        fi
      CODE
    },
    {
      title: "Batch Secret Cleanup",
      language: "bash",
      code: <<~CODE
        # Remove multiple old secret versions
        docker secret rm \\
          db_password_v1 \\
          api_key_v1 \\
          tls_cert_2024

        # Remove secrets matching pattern (carefully!)
        docker secret ls --format '{{.Name}}' | grep '_old$' | xargs docker secret rm
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Always verify secret usage before removal",
    "Test removal on non-critical secrets first",
    "Document secret removal for audit trails",
    "Use version suffixes to track secret generations"
  ]
  
  unit.key_learnings = [
    "docker secret rm removes secrets permanently",
    "Cannot remove secrets currently in use by services",
    "Safe pattern: create new version, update services, remove old version",
    "Can remove multiple secrets in one command",
    "Always verify no services depend on secret before removal"
  ]
end

# Unit 102: docker trust sign
InteractiveLearningUnit.find_or_create_by!(
  course_module: security_module,
  slug: 'docker-trust-sign'
) do |unit|
  unit.title = "docker trust sign - Sign Docker Images"
  unit.description = "Learn Docker Content Trust (DCT) and image signing to verify image integrity and publisher authenticity"
  unit.content = <<~CONTENT
    # Docker Trust Sign - Image Signing and Verification

    Docker Content Trust (DCT) provides cryptographic signing of images to ensure integrity and authenticity.

    ## What is Docker Content Trust?

    DCT uses digital signatures to verify:
    - **Image Integrity**: Content hasn't been tampered with
    - **Publisher Identity**: Image is from trusted source
    - **Freshness**: Not an old, vulnerable version

    ## Enabling Docker Content Trust
    ```bash
    export DOCKER_CONTENT_TRUST=1
    ```

    ## Basic Signing Workflow

    ### 1. Generate Signing Keys
    ```bash
    # DCT automatically generates keys on first push
    docker trust key generate mykey
    ```

    ### 2. Sign an Image
    ```bash
    # Enable DCT
    export DOCKER_CONTENT_TRUST=1

    # Push image (automatically signs)
    docker push myregistry.com/myimage:v1.0

    # Explicitly sign
    docker trust sign myregistry.com/myimage:v1.0
    ```

    ### 3. Verify Signed Images
    ```bash
    # With DCT enabled, only signed images can be pulled
    docker pull myregistry.com/myimage:v1.0

    # Inspect signature
    docker trust inspect myregistry.com/myimage:v1.0
    ```

    ## Use Cases

    ### Enforce Image Signing in Production
    ```bash
    # Set globally for all Docker operations
    echo 'export DOCKER_CONTENT_TRUST=1' >> ~/.bashrc

    # Now only signed images can be used
    docker pull untrusted/image  # Fails if unsigned
    ```

    ### Sign Images in CI/CD Pipeline
    ```bash
    # In GitLab CI / GitHub Actions
    export DOCKER_CONTENT_TRUST=1
    docker build -t myapp:$CI_COMMIT_SHA .
    docker tag myapp:$CI_COMMIT_SHA registry.com/myapp:$CI_COMMIT_SHA
    docker push registry.com/myapp:$CI_COMMIT_SHA  # Automatically signs
    ```

    ### Verify Image Signatures
    ```bash
    # Check signature status
    docker trust inspect --pretty myregistry.com/myimage:v1.0

    # View signing keys
    docker trust key load key.pem --name mykey
    ```

    ## Production Best Practices

    ### 1. Key Management
    - Store root keys securely (offline if possible)
    - Use hardware security modules (HSM) for production
    - Rotate keys regularly
    - Back up keys securely

    ### 2. Organizational Signing
    - Different keys for different teams
    - Delegate signing authority hierarchically
    - Audit signing operations

    ### 3. Policy Enforcement
    - Enable DCT on production nodes
    - Block unsigned images at admission control
    - Monitor signature verification failures

    ## Key Takeaways
    - DCT ensures images haven't been tampered with
    - Enable with DOCKER_CONTENT_TRUST=1
    - Images are automatically signed on push when DCT is enabled
    - Only signed images can be pulled with DCT enabled
    - Critical for production security and compliance
  CONTENT
  unit.content_type = 'lesson'
  unit.sequence_order = 102
  unit.estimated_minutes = 25
  unit.difficulty_level = 'advanced'
  unit.is_required = true
  unit.category = 'docker-security'
  
  unit.quiz_questions = [
    {
      question: "What does Docker Content Trust (DCT) verify?",
      options: [
        "Image size and build time",
        "Image integrity and publisher identity",
        "Container resource usage",
        "Network configuration"
      ],
      correct_answer: 1,
      explanation: "DCT uses cryptographic signatures to verify that images haven't been tampered with (integrity) and come from a trusted publisher (authenticity)."
    },
    {
      question: "How do you enable Docker Content Trust?",
      options: [
        "docker trust enable",
        "docker config --trust=on",
        "export DOCKER_CONTENT_TRUST=1",
        "docker trust init"
      ],
      correct_answer: 2,
      explanation: "Set the environment variable DOCKER_CONTENT_TRUST=1 to enable Docker Content Trust for all Docker operations."
    },
    {
      question: "What happens when you try to pull an unsigned image with DCT enabled?",
      options: [
        "Image pulls normally with a warning",
        "Docker automatically signs the image",
        "Pull operation fails",
        "Image is quarantined"
      ],
      correct_answer: 2,
      explanation: "With DCT enabled, Docker refuses to pull unsigned images, protecting against potentially tampered or untrusted images."
    }
  ]
  
  unit.code_examples = [
    {
      title: "Enable DCT and Sign Images",
      language: "bash",
      code: <<~CODE
        # Enable Docker Content Trust
        export DOCKER_CONTENT_TRUST=1

        # Build and tag image
        docker build -t myregistry.com/myapp:v1.0 .

        # Push image (automatically signs with DCT enabled)
        docker push myregistry.com/myapp:v1.0

        # Verify signature
        docker trust inspect --pretty myregistry.com/myapp:v1.0

        # Pull signed image (only works if signed)
        docker pull myregistry.com/myapp:v1.0
      CODE
    },
    {
      title: "CI/CD Pipeline with Image Signing",
      language: "yaml",
      code: <<~CODE
        # .gitlab-ci.yml or GitHub Actions workflow
        build-and-sign:
          stage: build
          script:
            # Enable Docker Content Trust
            - export DOCKER_CONTENT_TRUST=1
            
            # Load signing keys from CI secrets
            - echo "$DOCKER_TRUST_KEY" | base64 -d > trust.key
            - docker trust key load trust.key
            
            # Build image
            - docker build -t registry.com/myapp:$CI_COMMIT_SHA .
            
            # Push and automatically sign
            - docker push registry.com/myapp:$CI_COMMIT_SHA
            
            # Verify signature
            - docker trust inspect registry.com/myapp:$CI_COMMIT_SHA
      CODE
    }
  ]
  
  unit.practice_hints = [
    "Start by enabling DCT in a development environment",
    "Practice signing and verifying images before production use",
    "Set up key backup procedures early",
    "Test CI/CD pipeline with DCT enabled"
  ]
  
  unit.key_learnings = [
    "Docker Content Trust provides cryptographic image verification",
    "Enable with DOCKER_CONTENT_TRUST=1 environment variable",
    "Images are automatically signed on push when DCT is enabled",
    "Only signed images can be pulled with DCT enforcement",
    "Essential for production security and supply chain integrity",
    "Requires proper key management and rotation procedures"
  ]
  
  unit.additional_resources = [
    {
      title: "Docker Content Trust Documentation",
      url: "https://docs.docker.com/engine/security/trust/",
      resource_type: "documentation"
    },
    {
      title: "Image Signing Best Practices",
      url: "https://docs.docker.com/engine/security/trust/trust_automation/",
      resource_type: "best_practices"
    }
  ]
end

puts "✓ Created 5 Docker Security interactive learning units (98-102)"
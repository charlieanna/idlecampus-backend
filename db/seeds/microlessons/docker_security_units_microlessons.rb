# AUTO-GENERATED from docker_security_units.rb
puts "Creating Microlessons for Docker Security..."

module_var = CourseModule.find_by(slug: 'docker-security')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Lesson 3 ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 3',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 3 microlessons for Docker Security"

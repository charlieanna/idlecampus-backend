# CI/CD Pipelines Course
puts "Creating CI/CD Pipelines Course..."

cicd_course = Course.find_or_create_by!(slug: 'cicd-pipelines') do |course|
  course.title = 'CI/CD Pipelines & DevOps'
  course.description = 'Automate build, test, and deployment with Jenkins, GitHub Actions, GitLab CI'
  course.difficulty_level = 'intermediate'
  course.published = true
  course.sequence_order = 26
  course.estimated_hours = 25
  course.learning_objectives = JSON.generate([
    "Understand CI/CD principles and best practices",
    "Build automated pipelines with GitHub Actions",
    "Configure GitLab CI/CD workflows",
    "Implement Jenkins Pipeline as Code",
    "Automate testing in CI pipelines",
    "Deploy with advanced deployment strategies",
    "Monitor and troubleshoot pipeline failures"
  ])
  course.prerequisites = JSON.generate(["Git basics", "Command line familiarity", "Basic Docker knowledge"])
end

puts "Created course: #{cicd_course.title}"

# ==========================================
# MODULE 1: CI/CD Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'cicd-fundamentals', course: cicd_course) do |mod|
  mod.title = 'CI/CD Fundamentals'
  mod.description = 'Core principles, pipeline stages, and best practices'
  mod.sequence_order = 1
  mod.estimated_minutes = 35
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand CI vs CD vs Continuous Deployment",
    "Learn pipeline stages and artifact management",
    "Master environment strategies",
    "Apply CI/CD best practices"
  ])
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Continuous Integration & Deployment") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Continuous Integration & Deployment

    **CI/CD** automates the software delivery pipeline from code commit to production deployment.

    ## CI vs CD vs Continuous Deployment

    ### Continuous Integration (CI)
    **Automatically build and test code on every commit**

    ```
    Developer commits code
      ↓
    CI server detects change
      ↓
    Build application
      ↓
    Run automated tests
      ↓
    Report results (pass/fail)
    ```

    **Benefits:**
    - Catch bugs early (minutes, not days)
    - Reduce integration problems
    - Improve code quality
    - Enable faster development

    **Example CI workflow:**
    ```yaml
    # .github/workflows/ci.yml
    name: CI
    on: [push, pull_request]

    jobs:
      test:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v3
          - name: Install dependencies
            run: npm install
          - name: Run tests
            run: npm test
          - name: Run linter
            run: npm run lint
    ```

    ### Continuous Delivery (CD)
    **Automatically prepare code for production deployment**

    ```
    CI passes
      ↓
    Build deployment artifacts
      ↓
    Deploy to staging environment
      ↓
    Run integration tests
      ↓
    Ready for manual production release
    ```

    **Key point:** Deployment to production requires manual approval.

    **Benefits:**
    - Deployment-ready code at all times
    - Reduced deployment risk
    - Predictable release process
    - Manual control over production releases

    ### Continuous Deployment
    **Automatically deploy to production on every successful build**

    ```
    CI passes
      ↓
    Build artifacts
      ↓
    Deploy to staging
      ↓
    Automated tests pass
      ↓
    Automatically deploy to production
    ```

    **Key point:** No manual approval - every passing build goes to production.

    **Benefits:**
    - Fastest time to market
    - Smaller, lower-risk deployments
    - Immediate user feedback
    - Forces excellent automated testing

    **Trade-off:** Requires high confidence in automated tests and monitoring.

    ## Pipeline Stages

    A typical CI/CD pipeline has multiple stages:

    ### 1. Source Stage
    **Trigger pipeline on code changes**

    ```yaml
    # GitHub Actions trigger
    on:
      push:
        branches: [main, develop]
      pull_request:
        branches: [main]
    ```

    ### 2. Build Stage
    **Compile and package application**

    ```yaml
    build:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v3

        - name: Set up Node.js
          uses: actions/setup-node@v3
          with:
            node-version: '18'

        - name: Install dependencies
          run: npm ci

        - name: Build application
          run: npm run build

        - name: Upload build artifacts
          uses: actions/upload-artifact@v3
          with:
            name: dist
            path: dist/
    ```

    ### 3. Test Stage
    **Run automated tests**

    ```yaml
    test:
      needs: build
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v3

        # Unit tests
        - name: Run unit tests
          run: npm run test:unit

        # Integration tests
        - name: Run integration tests
          run: npm run test:integration

        # Code coverage
        - name: Generate coverage report
          run: npm run test:coverage

        - name: Upload coverage to Codecov
          uses: codecov/codecov-action@v3
    ```

    ### 4. Quality Stage
    **Code quality checks**

    ```yaml
    quality:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v3

        # Linting
        - name: Run ESLint
          run: npm run lint

        # Security scanning
        - name: Run security audit
          run: npm audit

        # Static analysis
        - name: SonarCloud scan
          uses: SonarSource/sonarcloud-github-action@master
          env:
            GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
            SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
    ```

    ### 5. Deploy Stage
    **Deploy to environments**

    ```yaml
    deploy-staging:
      needs: [test, quality]
      runs-on: ubuntu-latest
      environment: staging
      steps:
        - name: Download artifacts
          uses: actions/download-artifact@v3
          with:
            name: dist

        - name: Deploy to staging
          run: |
            aws s3 sync dist/ s3://my-app-staging
            aws cloudfront create-invalidation \\
              --distribution-id ${{ secrets.STAGING_DIST_ID }} \\
              --paths "/*"

    deploy-production:
      needs: deploy-staging
      runs-on: ubuntu-latest
      environment: production
      if: github.ref == 'refs/heads/main'
      steps:
        - name: Download artifacts
          uses: actions/download-artifact@v3
          with:
            name: dist

        - name: Deploy to production
          run: |
            aws s3 sync dist/ s3://my-app-production
            aws cloudfront create-invalidation \\
              --distribution-id ${{ secrets.PROD_DIST_ID }} \\
              --paths "/*"
    ```

    ## Artifact Management

    **Artifacts** are the build outputs that get deployed (JARs, Docker images, compiled binaries, etc.).

    ### Best Practices

    **1. Version artifacts**
    ```bash
    # Semantic versioning
    myapp-1.2.3.jar

    # Git commit hash
    myapp-abc123f.jar

    # Build number
    myapp-build-456.jar
    ```

    **2. Store artifacts in registries**
    ```yaml
    # Docker registry
    docker build -t myapp:${{ github.sha }} .
    docker tag myapp:${{ github.sha }} myapp:latest
    docker push myapp:${{ github.sha }}
    docker push myapp:latest
    ```

    **3. Artifact retention**
    ```yaml
    # GitHub Actions - keep artifacts for 30 days
    - name: Upload artifacts
      uses: actions/upload-artifact@v3
      with:
        name: build
        path: dist/
        retention-days: 30
    ```

    **4. Artifact promotion**
    ```
    Development: myapp:dev-abc123
    Staging:     myapp:staging-abc123
    Production:  myapp:v1.2.3 (same image, promoted)
    ```

    ## Environment Strategies

    ### Typical Environment Flow

    ```
    Development → Staging → Production
    ```

    ### 1. Development Environment
    **Purpose:** Developer testing and integration

    ```yaml
    environment: development
    config:
      - Auto-deploy on every commit
      - Debug logging enabled
      - Relaxed security for testing
      - Synthetic test data
      - Single instance
    ```

    ### 2. Staging Environment
    **Purpose:** Pre-production validation

    ```yaml
    environment: staging
    config:
      - Production-like configuration
      - Real-world data volume (sanitized)
      - Performance testing
      - QA validation
      - Load balancing (2-3 instances)
    ```

    ### 3. Production Environment
    **Purpose:** End users

    ```yaml
    environment: production
    config:
      - High availability (multi-AZ)
      - Monitoring and alerting
      - Automatic scaling
      - Backup and disaster recovery
      - Security hardening
    ```

    ### Environment Configuration

    **Use environment variables:**
    ```yaml
    # GitHub Actions environments
    deploy:
      runs-on: ubuntu-latest
      environment: production
      steps:
        - name: Deploy
          env:
            DATABASE_URL: ${{ secrets.DATABASE_URL }}
            API_KEY: ${{ secrets.API_KEY }}
            LOG_LEVEL: ${{ vars.LOG_LEVEL }}
          run: ./deploy.sh
    ```

    **Environment-specific configs:**
    ```yaml
    # config/staging.yml
    database:
      host: staging-db.example.com
      pool_size: 10
    logging:
      level: debug
    features:
      new_ui: true

    # config/production.yml
    database:
      host: prod-db.example.com
      pool_size: 50
    logging:
      level: warn
    features:
      new_ui: false
    ```

    ## CI/CD Best Practices

    ### 1. Fast Feedback
    **Fail fast, fail early**

    ```yaml
    # Run fast tests first
    jobs:
      lint:
        runs-on: ubuntu-latest
        steps:
          - run: npm run lint  # 30 seconds

      unit-tests:
        runs-on: ubuntu-latest
        steps:
          - run: npm run test:unit  # 2 minutes

      integration-tests:
        needs: unit-tests  # Only run if unit tests pass
        runs-on: ubuntu-latest
        steps:
          - run: npm run test:integration  # 10 minutes
    ```

    ### 2. Keep Pipelines Fast
    **Target: Under 10 minutes for CI**

    Strategies:
    - Parallel test execution
    - Incremental builds
    - Caching dependencies
    - Test only changed code

    ```yaml
    # Cache dependencies
    - name: Cache node modules
      uses: actions/cache@v3
      with:
        path: ~/.npm
        key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
        restore-keys: |
          ${{ runner.os }}-node-
    ```

    ### 3. Automate Everything
    **If you do it twice, automate it**

    - Testing
    - Code quality checks
    - Security scanning
    - Database migrations
    - Documentation generation

    ### 4. Make Pipelines Reproducible
    **Same code + same pipeline = same result**

    ```yaml
    # Pin versions
    - uses: actions/checkout@v3  # ✅ Specific version
    - uses: actions/setup-node@v3
      with:
        node-version: '18.16.0'  # ✅ Exact version

    # ❌ Avoid
    - uses: actions/checkout@main  # Unpredictable
    - uses: actions/setup-node@v3
      with:
        node-version: '18'  # Might get different minor versions
    ```

    ### 5. Secure Your Pipeline
    **Protect secrets and credentials**

    ```yaml
    # ✅ Use secrets
    - name: Deploy
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      run: ./deploy.sh

    # ❌ Never hardcode
    - name: Deploy
      env:
        AWS_ACCESS_KEY_ID: AKIAIOSFODNN7EXAMPLE  # BAD!
      run: ./deploy.sh
    ```

    ### 6. Monitor Pipeline Health
    **Track metrics:**
    - Build success rate
    - Average build time
    - Time to detect failures
    - Deployment frequency
    - Mean time to recovery (MTTR)

    ### 7. Keep main Branch Green
    **main/master should always be deployable**

    Strategies:
    - Required PR reviews
    - Status checks must pass
    - Protected branches
    - Revert quickly if broken

    ```yaml
    # Branch protection rules
    protection:
      required_reviews: 1
      required_status_checks:
        - ci/build
        - ci/test
        - ci/lint
      enforce_admins: true
    ```

    ## Summary

    **CI/CD Pipeline:**
    ```
    Code Commit
      ↓
    CI: Build + Test + Quality Checks
      ↓
    CD: Deploy to Staging
      ↓
    Continuous Deployment: Auto-deploy to Production
    (or manual approval for Continuous Delivery)
    ```

    **Key Principles:**
    1. **Automate** - Build, test, and deploy automatically
    2. **Fast feedback** - Fail fast, notify quickly
    3. **Reproducible** - Same input → same output
    4. **Secure** - Protect secrets and credentials
    5. **Monitor** - Track pipeline health and metrics
    6. **Incremental** - Small, frequent changes
    7. **Rollback** - Always have an escape hatch

    **Next:** We'll build complete CI/CD pipelines with GitHub Actions, GitLab CI, and Jenkins.
  MARKDOWN
  lesson.key_concepts = ['continuous integration', 'continuous delivery', 'continuous deployment', 'pipeline stages', 'artifacts', 'environments', 'automation', 'fast feedback']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

# ==========================================
# MODULE 2: Pipeline Implementation
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'pipeline-implementation', course: cicd_course) do |mod|
  mod.title = 'Pipeline Implementation'
  mod.description = 'Build complete pipelines with GitHub Actions, GitLab CI, and Jenkins'
  mod.sequence_order = 2
  mod.estimated_minutes = 40
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Build GitHub Actions workflows",
    "Configure GitLab CI/CD pipelines",
    "Create Jenkins Pipeline as Code",
    "Implement automated testing in pipelines",
    "Build and push Docker images"
  ])
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Building CI/CD Pipelines") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = <<~MARKDOWN
    # Building CI/CD Pipelines

    Let's build complete, production-ready CI/CD pipelines with the most popular platforms.

    ## GitHub Actions Complete Workflow

    ### Full-Stack Application Pipeline

    ```yaml
    # .github/workflows/main.yml
    name: CI/CD Pipeline

    on:
      push:
        branches: [main, develop]
      pull_request:
        branches: [main]

    env:
      NODE_VERSION: '18'
      DOCKER_IMAGE: myapp
      REGISTRY: ghcr.io

    jobs:
      # ========================================
      # STAGE 1: Code Quality
      # ========================================
      lint:
        name: Lint Code
        runs-on: ubuntu-latest
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Setup Node.js
            uses: actions/setup-node@v3
            with:
              node-version: ${{ env.NODE_VERSION }}
              cache: 'npm'

          - name: Install dependencies
            run: npm ci

          - name: Run ESLint
            run: npm run lint

          - name: Check code formatting
            run: npm run format:check

      # ========================================
      # STAGE 2: Build Application
      # ========================================
      build:
        name: Build Application
        runs-on: ubuntu-latest
        needs: lint
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Setup Node.js
            uses: actions/setup-node@v3
            with:
              node-version: ${{ env.NODE_VERSION }}
              cache: 'npm'

          - name: Install dependencies
            run: npm ci

          - name: Build application
            run: npm run build
            env:
              NODE_ENV: production

          - name: Upload build artifacts
            uses: actions/upload-artifact@v3
            with:
              name: build-artifacts
              path: |
                dist/
                package.json
                package-lock.json
              retention-days: 7

      # ========================================
      # STAGE 3: Unit Tests
      # ========================================
      test-unit:
        name: Unit Tests
        runs-on: ubuntu-latest
        needs: build
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Setup Node.js
            uses: actions/setup-node@v3
            with:
              node-version: ${{ env.NODE_VERSION }}
              cache: 'npm'

          - name: Install dependencies
            run: npm ci

          - name: Run unit tests
            run: npm run test:unit -- --coverage

          - name: Upload coverage reports
            uses: codecov/codecov-action@v3
            with:
              files: ./coverage/coverage-final.json
              flags: unittests
              name: codecov-unit

      # ========================================
      # STAGE 4: Integration Tests
      # ========================================
      test-integration:
        name: Integration Tests
        runs-on: ubuntu-latest
        needs: build
        services:
          postgres:
            image: postgres:15
            env:
              POSTGRES_PASSWORD: postgres
              POSTGRES_DB: testdb
            options: >-
              --health-cmd pg_isready
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5
            ports:
              - 5432:5432

          redis:
            image: redis:7
            options: >-
              --health-cmd "redis-cli ping"
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5
            ports:
              - 6379:6379

        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Setup Node.js
            uses: actions/setup-node@v3
            with:
              node-version: ${{ env.NODE_VERSION }}
              cache: 'npm'

          - name: Install dependencies
            run: npm ci

          - name: Run database migrations
            run: npm run db:migrate
            env:
              DATABASE_URL: postgresql://postgres:postgres@localhost:5432/testdb

          - name: Run integration tests
            run: npm run test:integration
            env:
              DATABASE_URL: postgresql://postgres:postgres@localhost:5432/testdb
              REDIS_URL: redis://localhost:6379

      # ========================================
      # STAGE 5: E2E Tests
      # ========================================
      test-e2e:
        name: E2E Tests
        runs-on: ubuntu-latest
        needs: build
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Setup Node.js
            uses: actions/setup-node@v3
            with:
              node-version: ${{ env.NODE_VERSION }}
              cache: 'npm'

          - name: Install dependencies
            run: npm ci

          - name: Install Playwright browsers
            run: npx playwright install --with-deps

          - name: Download build artifacts
            uses: actions/download-artifact@v3
            with:
              name: build-artifacts

          - name: Start application
            run: |
              npm start &
              npx wait-on http://localhost:3000 -t 30000

          - name: Run E2E tests
            run: npm run test:e2e

          - name: Upload test results
            if: always()
            uses: actions/upload-artifact@v3
            with:
              name: playwright-report
              path: playwright-report/
              retention-days: 7

      # ========================================
      # STAGE 6: Security Scanning
      # ========================================
      security:
        name: Security Scan
        runs-on: ubuntu-latest
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Run npm audit
            run: npm audit --audit-level=moderate
            continue-on-error: true

          - name: Run Snyk security scan
            uses: snyk/actions/node@master
            env:
              SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
            with:
              args: --severity-threshold=high

          - name: Run Trivy vulnerability scanner
            uses: aquasecurity/trivy-action@master
            with:
              scan-type: 'fs'
              scan-ref: '.'
              format: 'sarif'
              output: 'trivy-results.sarif'

          - name: Upload Trivy results to GitHub Security
            uses: github/codeql-action/upload-sarif@v2
            with:
              sarif_file: 'trivy-results.sarif'

      # ========================================
      # STAGE 7: Build Docker Image
      # ========================================
      docker:
        name: Build Docker Image
        runs-on: ubuntu-latest
        needs: [test-unit, test-integration, test-e2e]
        if: github.event_name == 'push'
        permissions:
          contents: read
          packages: write
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Set up Docker Buildx
            uses: docker/setup-buildx-action@v2

          - name: Log in to GitHub Container Registry
            uses: docker/login-action@v2
            with:
              registry: ${{ env.REGISTRY }}
              username: ${{ github.actor }}
              password: ${{ secrets.GITHUB_TOKEN }}

          - name: Extract metadata
            id: meta
            uses: docker/metadata-action@v4
            with:
              images: ${{ env.REGISTRY }}/${{ github.repository }}/${{ env.DOCKER_IMAGE }}
              tags: |
                type=ref,event=branch
                type=sha,prefix={{branch}}-
                type=semver,pattern={{version}}
                type=semver,pattern={{major}}.{{minor}}

          - name: Build and push Docker image
            uses: docker/build-push-action@v4
            with:
              context: .
              push: true
              tags: ${{ steps.meta.outputs.tags }}
              labels: ${{ steps.meta.outputs.labels }}
              cache-from: type=gha
              cache-to: type=gha,mode=max

      # ========================================
      # STAGE 8: Deploy to Staging
      # ========================================
      deploy-staging:
        name: Deploy to Staging
        runs-on: ubuntu-latest
        needs: docker
        if: github.ref == 'refs/heads/develop'
        environment:
          name: staging
          url: https://staging.myapp.com
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Configure AWS credentials
            uses: aws-actions/configure-aws-credentials@v2
            with:
              aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
              aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
              aws-region: us-east-1

          - name: Deploy to ECS
            run: |
              # Update ECS task definition
              aws ecs update-service \\
                --cluster staging-cluster \\
                --service myapp-service \\
                --force-new-deployment

          - name: Wait for deployment
            run: |
              aws ecs wait services-stable \\
                --cluster staging-cluster \\
                --services myapp-service

          - name: Run smoke tests
            run: |
              curl -f https://staging.myapp.com/health || exit 1

      # ========================================
      # STAGE 9: Deploy to Production
      # ========================================
      deploy-production:
        name: Deploy to Production
        runs-on: ubuntu-latest
        needs: docker
        if: github.ref == 'refs/heads/main'
        environment:
          name: production
          url: https://myapp.com
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Configure AWS credentials
            uses: aws-actions/configure-aws-credentials@v2
            with:
              aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
              aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
              aws-region: us-east-1

          - name: Deploy to ECS
            run: |
              aws ecs update-service \\
                --cluster production-cluster \\
                --service myapp-service \\
                --force-new-deployment

          - name: Wait for deployment
            run: |
              aws ecs wait services-stable \\
                --cluster production-cluster \\
                --services myapp-service

          - name: Run smoke tests
            run: |
              curl -f https://myapp.com/health || exit 1

          - name: Notify Slack
            uses: slackapi/slack-github-action@v1
            with:
              payload: |
                {
                  "text": "🚀 Production deployment successful!",
                  "blocks": [
                    {
                      "type": "section",
                      "text": {
                        "type": "mrkdwn",
                        "text": "*Production Deployment*\\n✅ Successfully deployed to production\\n*Commit:* ${{ github.sha }}\\n*Author:* ${{ github.actor }}"
                      }
                    }
                  ]
                }
            env:
              SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
    ```

    ## GitLab CI/CD Pipeline

    ### Complete .gitlab-ci.yml

    ```yaml
    # .gitlab-ci.yml
    image: node:18

    variables:
      DOCKER_IMAGE: registry.gitlab.com/$CI_PROJECT_PATH
      POSTGRES_DB: testdb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres

    stages:
      - lint
      - build
      - test
      - security
      - package
      - deploy

    # ========================================
    # Cache configuration
    # ========================================
    .node_cache:
      cache:
        key:
          files:
            - package-lock.json
        paths:
          - node_modules/
          - .npm/

    # ========================================
    # STAGE: Lint
    # ========================================
    lint:code:
      stage: lint
      extends: .node_cache
      script:
        - npm ci
        - npm run lint
        - npm run format:check
      rules:
        - if: $CI_PIPELINE_SOURCE == "merge_request_event"
        - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

    # ========================================
    # STAGE: Build
    # ========================================
    build:app:
      stage: build
      extends: .node_cache
      script:
        - npm ci
        - npm run build
      artifacts:
        paths:
          - dist/
        expire_in: 1 week
      rules:
        - if: $CI_PIPELINE_SOURCE == "merge_request_event"
        - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

    # ========================================
    # STAGE: Test
    # ========================================
    test:unit:
      stage: test
      extends: .node_cache
      script:
        - npm ci
        - npm run test:unit -- --coverage
      coverage: '/Statements\\s+:\\s+(\\d+\\.\\d+)%/'
      artifacts:
        reports:
          coverage_report:
            coverage_format: cobertura
            path: coverage/cobertura-coverage.xml
        paths:
          - coverage/
        expire_in: 1 week

    test:integration:
      stage: test
      extends: .node_cache
      services:
        - postgres:15
        - redis:7
      variables:
        DATABASE_URL: postgresql://postgres:postgres@postgres:5432/testdb
        REDIS_URL: redis://redis:6379
      script:
        - npm ci
        - npm run db:migrate
        - npm run test:integration
      artifacts:
        reports:
          junit: junit.xml

    test:e2e:
      stage: test
      extends: .node_cache
      services:
        - postgres:15
      variables:
        DATABASE_URL: postgresql://postgres:postgres@postgres:5432/testdb
      before_script:
        - apt-get update
        - apt-get install -y chromium
      script:
        - npm ci
        - npx playwright install
        - npm run build
        - npm start &
        - npx wait-on http://localhost:3000 -t 30000
        - npm run test:e2e
      artifacts:
        when: always
        paths:
          - playwright-report/
        expire_in: 1 week

    # ========================================
    # STAGE: Security
    # ========================================
    security:npm-audit:
      stage: security
      script:
        - npm audit --audit-level=moderate
      allow_failure: true

    security:sast:
      stage: security
      image: returntocorp/semgrep
      script:
        - semgrep --config=auto --json --output=semgrep-report.json
      artifacts:
        reports:
          sast: semgrep-report.json
      allow_failure: true

    security:dependency-scan:
      stage: security
      image: aquasec/trivy:latest
      script:
        - trivy fs --format json --output trivy-report.json .
      artifacts:
        paths:
          - trivy-report.json
      allow_failure: true

    # ========================================
    # STAGE: Package
    # ========================================
    package:docker:
      stage: package
      image: docker:24
      services:
        - docker:24-dind
      variables:
        DOCKER_TLS_CERTDIR: "/certs"
      before_script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
      script:
        # Build image
        - docker build -t $DOCKER_IMAGE:$CI_COMMIT_SHA .
        - docker tag $DOCKER_IMAGE:$CI_COMMIT_SHA $DOCKER_IMAGE:latest

        # Push to registry
        - docker push $DOCKER_IMAGE:$CI_COMMIT_SHA
        - docker push $DOCKER_IMAGE:latest
      only:
        - main
        - develop

    # ========================================
    # STAGE: Deploy to Staging
    # ========================================
    deploy:staging:
      stage: deploy
      image: alpine:latest
      environment:
        name: staging
        url: https://staging.myapp.com
      before_script:
        - apk add --no-cache curl
      script:
        - echo "Deploying to staging..."
        # Trigger deployment (example with Kubernetes)
        - |
          curl -X POST \\
            -H "Authorization: Bearer $KUBE_TOKEN" \\
            -H "Content-Type: application/json" \\
            -d '{"image":"'$DOCKER_IMAGE:$CI_COMMIT_SHA'"}' \\
            https://k8s-api.staging.myapp.com/deploy

        # Wait for deployment
        - sleep 30

        # Smoke test
        - curl -f https://staging.myapp.com/health || exit 1
      only:
        - develop

    # ========================================
    # STAGE: Deploy to Production
    # ========================================
    deploy:production:
      stage: deploy
      image: alpine:latest
      environment:
        name: production
        url: https://myapp.com
      before_script:
        - apk add --no-cache curl
      script:
        - echo "Deploying to production..."
        - |
          curl -X POST \\
            -H "Authorization: Bearer $KUBE_TOKEN" \\
            -H "Content-Type: application/json" \\
            -d '{"image":"'$DOCKER_IMAGE:$CI_COMMIT_SHA'"}' \\
            https://k8s-api.production.myapp.com/deploy

        # Wait for deployment
        - sleep 60

        # Smoke test
        - curl -f https://myapp.com/health || exit 1
      only:
        - main
      when: manual  # Require manual approval
    ```

    ## Jenkins Pipeline as Code

    ### Jenkinsfile (Declarative Pipeline)

    ```groovy
    // Jenkinsfile
    pipeline {
        agent any

        environment {
            NODE_VERSION = '18'
            DOCKER_IMAGE = 'myapp'
            DOCKER_REGISTRY = 'docker.io'
            DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
            AWS_CREDENTIALS_ID = 'aws-credentials'
            SLACK_CHANNEL = '#deployments'
        }

        options {
            buildDiscarder(logRotator(numToKeepStr: '10'))
            timeout(time: 30, unit: 'MINUTES')
            timestamps()
        }

        stages {
            // ========================================
            // STAGE 1: Checkout
            // ========================================
            stage('Checkout') {
                steps {
                    checkout scm
                    script {
                        env.GIT_COMMIT_SHORT = sh(
                            returnStdout: true,
                            script: 'git rev-parse --short HEAD'
                        ).trim()
                    }
                }
            }

            // ========================================
            // STAGE 2: Install Dependencies
            // ========================================
            stage('Install Dependencies') {
                steps {
                    nodejs(nodeJSInstallationName: "Node ${NODE_VERSION}") {
                        sh 'npm ci'
                    }
                }
            }

            // ========================================
            // STAGE 3: Code Quality
            // ========================================
            stage('Code Quality') {
                parallel {
                    stage('Lint') {
                        steps {
                            nodejs(nodeJSInstallationName: "Node ${NODE_VERSION}") {
                                sh 'npm run lint'
                            }
                        }
                    }

                    stage('Format Check') {
                        steps {
                            nodejs(nodeJSInstallationName: "Node ${NODE_VERSION}") {
                                sh 'npm run format:check'
                            }
                        }
                    }
                }
            }

            // ========================================
            // STAGE 4: Build
            // ========================================
            stage('Build') {
                steps {
                    nodejs(nodeJSInstallationName: "Node ${NODE_VERSION}") {
                        sh 'npm run build'
                    }

                    // Archive build artifacts
                    archiveArtifacts artifacts: 'dist/**/*', fingerprint: true
                }
            }

            // ========================================
            // STAGE 5: Test
            // ========================================
            stage('Test') {
                parallel {
                    stage('Unit Tests') {
                        steps {
                            nodejs(nodeJSInstallationName: "Node ${NODE_VERSION}") {
                                sh 'npm run test:unit -- --coverage'
                            }

                            // Publish test results
                            junit 'junit.xml'

                            // Publish coverage
                            publishHTML([
                                reportDir: 'coverage/lcov-report',
                                reportFiles: 'index.html',
                                reportName: 'Coverage Report'
                            ])
                        }
                    }

                    stage('Integration Tests') {
                        steps {
                            script {
                                docker.image('postgres:15').withRun('-e POSTGRES_PASSWORD=postgres') { db ->
                                    docker.image('redis:7').withRun() { redis ->
                                        nodejs(nodeJSInstallationName: "Node ${NODE_VERSION}") {
                                            sh '''
                                                export DATABASE_URL=postgresql://postgres:postgres@localhost:5432/testdb
                                                export REDIS_URL=redis://localhost:6379
                                                npm run db:migrate
                                                npm run test:integration
                                            '''
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // ========================================
            // STAGE 6: Security Scanning
            // ========================================
            stage('Security Scan') {
                parallel {
                    stage('NPM Audit') {
                        steps {
                            script {
                                try {
                                    sh 'npm audit --audit-level=moderate'
                                } catch (Exception e) {
                                    echo "NPM audit found vulnerabilities: ${e.message}"
                                    currentBuild.result = 'UNSTABLE'
                                }
                            }
                        }
                    }

                    stage('Trivy Scan') {
                        steps {
                            sh '''
                                docker run --rm -v $(pwd):/workspace \\
                                    aquasec/trivy:latest fs \\
                                    --format json \\
                                    --output trivy-report.json \\
                                    /workspace
                            '''

                            archiveArtifacts artifacts: 'trivy-report.json'
                        }
                    }

                    stage('SonarQube') {
                        steps {
                            script {
                                def scannerHome = tool 'SonarQube Scanner'
                                withSonarQubeEnv('SonarQube') {
                                    sh """
                                        ${scannerHome}/bin/sonar-scanner \\
                                            -Dsonar.projectKey=myapp \\
                                            -Dsonar.sources=src \\
                                            -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info
                                    """
                                }
                            }
                        }
                    }
                }
            }

            // ========================================
            // STAGE 7: Build Docker Image
            // ========================================
            stage('Build Docker Image') {
                when {
                    branch 'main'
                }
                steps {
                    script {
                        docker.withRegistry("https://${DOCKER_REGISTRY}", DOCKER_CREDENTIALS_ID) {
                            def customImage = docker.build("${DOCKER_IMAGE}:${env.GIT_COMMIT_SHORT}")
                            customImage.push()
                            customImage.push('latest')
                        }
                    }
                }
            }

            // ========================================
            // STAGE 8: Deploy to Staging
            // ========================================
            stage('Deploy to Staging') {
                when {
                    branch 'develop'
                }
                environment {
                    ENVIRONMENT = 'staging'
                }
                steps {
                    script {
                        withAWS(credentials: AWS_CREDENTIALS_ID, region: 'us-east-1') {
                            sh '''
                                aws ecs update-service \\
                                    --cluster staging-cluster \\
                                    --service myapp-service \\
                                    --force-new-deployment

                                aws ecs wait services-stable \\
                                    --cluster staging-cluster \\
                                    --services myapp-service
                            '''
                        }
                    }

                    // Smoke test
                    sh 'curl -f https://staging.myapp.com/health'
                }
            }

            // ========================================
            // STAGE 9: Deploy to Production
            // ========================================
            stage('Deploy to Production') {
                when {
                    branch 'main'
                }
                environment {
                    ENVIRONMENT = 'production'
                }
                steps {
                    // Require manual approval
                    input message: 'Deploy to production?', ok: 'Deploy'

                    script {
                        withAWS(credentials: AWS_CREDENTIALS_ID, region: 'us-east-1') {
                            sh '''
                                aws ecs update-service \\
                                    --cluster production-cluster \\
                                    --service myapp-service \\
                                    --force-new-deployment

                                aws ecs wait services-stable \\
                                    --cluster production-cluster \\
                                    --services myapp-service
                            '''
                        }
                    }

                    // Smoke test
                    sh 'curl -f https://myapp.com/health'
                }
            }
        }

        // ========================================
        // Post-build Actions
        // ========================================
        post {
            success {
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: 'good',
                    message: "✅ Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}\\n<${env.BUILD_URL}|View Build>"
                )
            }

            failure {
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: 'danger',
                    message: "❌ Build FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}\\n<${env.BUILD_URL}|View Build>"
                )
            }

            always {
                // Clean up workspace
                cleanWs()
            }
        }
    }
    ```

    ## Docker Build and Push Examples

    ### Multi-stage Dockerfile

    ```dockerfile
    # Dockerfile
    # ========================================
    # Stage 1: Build
    # ========================================
    FROM node:18-alpine AS builder

    WORKDIR /app

    # Copy dependency files
    COPY package*.json ./

    # Install dependencies
    RUN npm ci --only=production

    # Copy source code
    COPY . .

    # Build application
    RUN npm run build

    # ========================================
    # Stage 2: Production
    # ========================================
    FROM node:18-alpine

    # Add security updates
    RUN apk --no-cache upgrade

    # Create app user
    RUN addgroup -g 1001 -S nodejs && \\
        adduser -S nodejs -u 1001

    WORKDIR /app

    # Copy built application from builder
    COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist
    COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
    COPY --from=builder --chown=nodejs:nodejs /app/package.json ./

    # Switch to non-root user
    USER nodejs

    # Expose port
    EXPOSE 3000

    # Health check
    HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \\
      CMD node -e "require('http').get('http://localhost:3000/health', (r) => process.exit(r.statusCode === 200 ? 0 : 1))"

    # Start application
    CMD ["node", "dist/index.js"]
    ```

    ### GitHub Actions Docker Build

    ```yaml
    # Build and push with caching
    - name: Build and push Docker image
      uses: docker/build-push-action@v4
      with:
        context: .
        file: ./Dockerfile
        push: true
        tags: |
          ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
          ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest
        cache-from: type=gha
        cache-to: type=gha,mode=max
        build-args: |
          BUILD_DATE=${{ steps.date.outputs.date }}
          VERSION=${{ github.sha }}
    ```

    ## Complete Testing Pipeline

    ### Test Configuration

    ```yaml
    # Run all test types
    test:
      strategy:
        matrix:
          test-type: [unit, integration, e2e]
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v3

        - name: Setup Node.js
          uses: actions/setup-node@v3
          with:
            node-version: '18'

        - name: Install dependencies
          run: npm ci

        - name: Run ${{ matrix.test-type }} tests
          run: npm run test:${{ matrix.test-type }}
    ```

    ### Code Coverage

    ```yaml
    - name: Run tests with coverage
      run: npm run test:coverage

    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        files: ./coverage/coverage-final.json
        flags: ${{ matrix.test-type }}
        fail_ci_if_error: true

    - name: Check coverage threshold
      run: |
        COVERAGE=$(cat coverage/coverage-summary.json | jq '.total.lines.pct')
        if (( $(echo "$COVERAGE < 80" | bc -l) )); then
          echo "Coverage $COVERAGE% is below threshold 80%"
          exit 1
        fi
    ```

    ## Code Quality Checks

    ### ESLint + Prettier

    ```yaml
    quality:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v3

        - name: Setup Node.js
          uses: actions/setup-node@v3
          with:
            node-version: '18'

        - name: Install dependencies
          run: npm ci

        # Linting
        - name: Run ESLint
          run: npm run lint

        # Format checking
        - name: Check formatting
          run: npm run format:check

        # Type checking (TypeScript)
        - name: Type check
          run: npm run type-check
    ```

    ### SonarCloud Integration

    ```yaml
    - name: SonarCloud Scan
      uses: SonarSource/sonarcloud-github-action@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
      with:
        args: >
          -Dsonar.projectKey=myproject
          -Dsonar.organization=myorg
          -Dsonar.sources=src
          -Dsonar.tests=tests
          -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info
          -Dsonar.coverage.exclusions=**/*.test.js,**/*.spec.js
    ```

    ## Summary

    **Complete CI/CD Pipeline includes:**

    1. **Code Quality** - Linting, formatting, type checking
    2. **Build** - Compile and package application
    3. **Test** - Unit, integration, E2E tests
    4. **Security** - Vulnerability scanning, SAST/DAST
    5. **Package** - Docker image build and push
    6. **Deploy** - Automated deployment to environments
    7. **Monitor** - Health checks, notifications

    **Key Principles:**
    - Fail fast (run quick checks first)
    - Parallel execution (speed up pipeline)
    - Caching (reuse dependencies)
    - Artifacts (share build outputs)
    - Secrets management (never hardcode credentials)

    **Next:** We'll explore advanced deployment strategies like blue-green, canary, and rolling updates.
  MARKDOWN
  lesson.key_concepts = ['github actions', 'gitlab ci', 'jenkins', 'docker build', 'automated testing', 'code quality', 'security scanning', 'pipeline as code']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
  item.required = true
end

# ==========================================
# MODULE 3: Deployment Strategies
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'deployment-strategies', course: cicd_course) do |mod|
  mod.title = 'Deployment Strategies'
  mod.description = 'Advanced deployment patterns: blue-green, canary, rolling updates'
  mod.sequence_order = 3
  mod.estimated_minutes = 30
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Implement blue-green deployments",
    "Configure canary releases",
    "Set up rolling updates",
    "Use feature flags for gradual rollout",
    "Design rollback strategies"
  ])
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Advanced Deployment Patterns") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Advanced Deployment Patterns

    Advanced deployment strategies minimize downtime and risk when releasing new versions.

    ## Blue-Green Deployment

    **Run two identical environments, switch traffic between them**

    ### Concept

    ```
    Blue (Current):  v1.0 → 100% traffic
    Green (New):     v2.0 → 0% traffic

    Deploy to Green, test thoroughly

    Switch:
    Blue:  v1.0 → 0% traffic
    Green: v2.0 → 100% traffic
    ```

    ### Benefits
    - Instant rollback (switch back to blue)
    - Zero downtime
    - Full testing before switching
    - Reduced risk

    ### Implementation with AWS

    ```yaml
    # .github/workflows/blue-green.yml
    name: Blue-Green Deployment

    on:
      push:
        branches: [main]

    jobs:
      deploy:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Configure AWS credentials
            uses: aws-actions/configure-aws-credentials@v2
            with:
              aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
              aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
              aws-region: us-east-1

          # ========================================
          # Step 1: Determine current environment
          # ========================================
          - name: Get current target group
            id: current
            run: |
              LISTENER_ARN="${{ secrets.ALB_LISTENER_ARN }}"

              # Get current target group
              CURRENT_TG=$(aws elbv2 describe-listeners \\
                --listener-arns $LISTENER_ARN \\
                --query 'Listeners[0].DefaultActions[0].TargetGroupArn' \\
                --output text)

              # Determine which is active (blue or green)
              if [[ "$CURRENT_TG" == *"blue"* ]]; then
                echo "active=blue" >> $GITHUB_OUTPUT
                echo "inactive=green" >> $GITHUB_OUTPUT
              else
                echo "active=green" >> $GITHUB_OUTPUT
                echo "inactive=blue" >> $GITHUB_OUTPUT
              fi

          # ========================================
          # Step 2: Deploy to inactive environment
          # ========================================
          - name: Deploy to ${{ steps.current.outputs.inactive }}
            run: |
              INACTIVE="${{ steps.current.outputs.inactive }}"

              # Update ECS service in inactive environment
              aws ecs update-service \\
                --cluster production-cluster \\
                --service myapp-$INACTIVE \\
                --force-new-deployment \\
                --desired-count 2

              # Wait for deployment to stabilize
              aws ecs wait services-stable \\
                --cluster production-cluster \\
                --services myapp-$INACTIVE

          # ========================================
          # Step 3: Run smoke tests
          # ========================================
          - name: Test ${{ steps.current.outputs.inactive }} environment
            run: |
              INACTIVE="${{ steps.current.outputs.inactive }}"

              # Get target group ARN
              TG_ARN=$(aws elbv2 describe-target-groups \\
                --names myapp-$INACTIVE \\
                --query 'TargetGroups[0].TargetGroupArn' \\
                --output text)

              # Get target IPs
              TARGETS=$(aws elbv2 describe-target-health \\
                --target-group-arn $TG_ARN \\
                --query 'TargetHealthDescriptions[*].Target.Id' \\
                --output text)

              # Test each target
              for TARGET in $TARGETS; do
                HEALTH=$(curl -f http://$TARGET/health || echo "FAIL")
                if [[ "$HEALTH" == "FAIL" ]]; then
                  echo "Health check failed for $TARGET"
                  exit 1
                fi
              done

          # ========================================
          # Step 4: Switch traffic
          # ========================================
          - name: Switch to ${{ steps.current.outputs.inactive }}
            run: |
              INACTIVE="${{ steps.current.outputs.inactive }}"
              LISTENER_ARN="${{ secrets.ALB_LISTENER_ARN }}"

              # Get new target group ARN
              NEW_TG_ARN=$(aws elbv2 describe-target-groups \\
                --names myapp-$INACTIVE \\
                --query 'TargetGroups[0].TargetGroupArn' \\
                --output text)

              # Switch listener to new target group
              aws elbv2 modify-listener \\
                --listener-arn $LISTENER_ARN \\
                --default-actions Type=forward,TargetGroupArn=$NEW_TG_ARN

              echo "Traffic switched to $INACTIVE environment"

          # ========================================
          # Step 5: Monitor new environment
          # ========================================
          - name: Monitor for 5 minutes
            run: |
              echo "Monitoring production traffic..."
              sleep 300

              # Check error rate
              ERROR_RATE=$(aws cloudwatch get-metric-statistics \\
                --namespace AWS/ApplicationELB \\
                --metric-name HTTPCode_Target_5XX_Count \\
                --start-time $(date -u -d '5 minutes ago' +%Y-%m-%dT%H:%M:%S) \\
                --end-time $(date -u +%Y-%m-%dT%H:%M:%S) \\
                --period 300 \\
                --statistics Sum \\
                --query 'Datapoints[0].Sum' \\
                --output text)

              if (( $(echo "$ERROR_RATE > 10" | bc -l) )); then
                echo "High error rate detected: $ERROR_RATE"
                echo "Initiating rollback..."
                exit 1
              fi

          # ========================================
          # Step 6: Scale down old environment
          # ========================================
          - name: Scale down ${{ steps.current.outputs.active }}
            if: success()
            run: |
              ACTIVE="${{ steps.current.outputs.active }}"

              # Reduce old environment to minimum
              aws ecs update-service \\
                --cluster production-cluster \\
                --service myapp-$ACTIVE \\
                --desired-count 1

              echo "Deployment complete! New active: {{ steps.current.outputs.inactive }}"

          # ========================================
          # Rollback on failure
          # ========================================
          - name: Rollback on failure
            if: failure()
            run: |
              ACTIVE="${{ steps.current.outputs.active }}"
              LISTENER_ARN="${{ secrets.ALB_LISTENER_ARN }}"

              # Get original target group
              ORIGINAL_TG=$(aws elbv2 describe-target-groups \\
                --names myapp-$ACTIVE \\
                --query 'TargetGroups[0].TargetGroupArn' \\
                --output text)

              # Switch back
              aws elbv2 modify-listener \\
                --listener-arn $LISTENER_ARN \\
                --default-actions Type=forward,TargetGroupArn=$ORIGINAL_TG

              echo "Rolled back to $ACTIVE environment"
    ```

    ## Canary Deployment

    **Gradually roll out to a small subset of users**

    ### Concept

    ```
    v1.0: 100% traffic
    v2.0: 0% traffic

    Phase 1: v1.0 (95%) + v2.0 (5%)   → Monitor
    Phase 2: v1.0 (80%) + v2.0 (20%)  → Monitor
    Phase 3: v1.0 (50%) + v2.0 (50%)  → Monitor
    Phase 4: v1.0 (0%)  + v2.0 (100%) → Complete
    ```

    ### Benefits
    - Detect issues with minimal user impact
    - Gradual confidence building
    - A/B testing capability
    - Easy rollback at any stage

    ### Implementation with Kubernetes

    ```yaml
    # canary-deployment.yml
    apiVersion: v1
    kind: Service
    metadata:
      name: myapp
    spec:
      selector:
        app: myapp
      ports:
        - port: 80
          targetPort: 3000
    ---
    # Stable deployment (v1.0)
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: myapp-stable
    spec:
      replicas: 9  # 90% of traffic
      selector:
        matchLabels:
          app: myapp
          version: stable
      template:
        metadata:
          labels:
            app: myapp
            version: stable
        spec:
          containers:
          - name: myapp
            image: myapp:v1.0
            ports:
            - containerPort: 3000
    ---
    # Canary deployment (v2.0)
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: myapp-canary
    spec:
      replicas: 1  # 10% of traffic
      selector:
        matchLabels:
          app: myapp
          version: canary
      template:
        metadata:
          labels:
            app: myapp
            version: canary
        spec:
          containers:
          - name: myapp
            image: myapp:v2.0
            ports:
            - containerPort: 3000
    ```

    ### Automated Canary with Flagger

    ```yaml
    # flagger-canary.yml
    apiVersion: flagger.app/v1beta1
    kind: Canary
    metadata:
      name: myapp
    spec:
      targetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: myapp
      service:
        port: 80
      analysis:
        interval: 1m
        threshold: 5
        maxWeight: 50
        stepWeight: 10
        metrics:
        - name: request-success-rate
          thresholdRange:
            min: 99
          interval: 1m
        - name: request-duration
          thresholdRange:
            max: 500
          interval: 1m
        webhooks:
        - name: load-test
          url: http://load-tester/
          timeout: 5s
          metadata:
            cmd: "hey -z 1m -q 10 -c 2 http://myapp-canary/"
    ```

    ### CI/CD Pipeline with Canary

    ```yaml
    # .github/workflows/canary.yml
    name: Canary Deployment

    on:
      push:
        branches: [main]

    jobs:
      deploy:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout
            uses: actions/checkout@v3

          - name: Configure kubectl
            uses: azure/k8s-set-context@v3
            with:
              method: kubeconfig
              kubeconfig: ${{ secrets.KUBE_CONFIG }}

          # ========================================
          # Deploy canary
          # ========================================
          - name: Deploy canary (10%)
            run: |
              kubectl set image deployment/myapp-canary \\
                myapp=myapp:${{ github.sha }}

              kubectl scale deployment/myapp-stable --replicas=9
              kubectl scale deployment/myapp-canary --replicas=1

          - name: Wait and monitor (5 minutes)
            run: sleep 300

          - name: Check canary metrics
            run: |
              # Check error rate
              ERROR_RATE=$(kubectl exec -n monitoring prometheus-0 -- \\
                promtool query instant \\
                'rate(http_requests_total{status=~"5..",version="canary"}[5m])' \\
                | jq -r '.data.result[0].value[1]')

              if (( $(echo "$ERROR_RATE > 0.01" | bc -l) )); then
                echo "Canary error rate too high: $ERROR_RATE"
                exit 1
              fi

          # ========================================
          # Increase to 50%
          # ========================================
          - name: Scale canary to 50%
            if: success()
            run: |
              kubectl scale deployment/myapp-stable --replicas=5
              kubectl scale deployment/myapp-canary --replicas=5

          - name: Wait and monitor (10 minutes)
            run: sleep 600

          - name: Check canary metrics
            run: |
              ERROR_RATE=$(kubectl exec -n monitoring prometheus-0 -- \\
                promtool query instant \\
                'rate(http_requests_total{status=~"5..",version="canary"}[10m])' \\
                | jq -r '.data.result[0].value[1]')

              if (( $(echo "$ERROR_RATE > 0.01" | bc -l) )); then
                echo "Canary error rate too high: $ERROR_RATE"
                exit 1
              fi

          # ========================================
          # Promote to 100%
          # ========================================
          - name: Promote canary to stable
            if: success()
            run: |
              # Update stable deployment to new version
              kubectl set image deployment/myapp-stable \\
                myapp=myapp:${{ github.sha }}

              kubectl scale deployment/myapp-stable --replicas=10
              kubectl scale deployment/myapp-canary --replicas=0

              echo "Canary promoted to stable!"

          # ========================================
          # Rollback on failure
          # ========================================
          - name: Rollback canary
            if: failure()
            run: |
              kubectl scale deployment/myapp-canary --replicas=0
              kubectl scale deployment/myapp-stable --replicas=10

              echo "Canary rolled back"
    ```

    ## Rolling Update

    **Gradually replace old instances with new ones**

    ### Concept

    ```
    Initial:  [v1.0] [v1.0] [v1.0] [v1.0]
    Step 1:   [v2.0] [v1.0] [v1.0] [v1.0]
    Step 2:   [v2.0] [v2.0] [v1.0] [v1.0]
    Step 3:   [v2.0] [v2.0] [v2.0] [v1.0]
    Step 4:   [v2.0] [v2.0] [v2.0] [v2.0]
    ```

    ### Kubernetes Rolling Update

    ```yaml
    # deployment.yml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: myapp
    spec:
      replicas: 10
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 2        # Can add 2 extra pods during update
          maxUnavailable: 1  # Max 1 pod can be unavailable
      selector:
        matchLabels:
          app: myapp
      template:
        metadata:
          labels:
            app: myapp
        spec:
          containers:
          - name: myapp
            image: myapp:v2.0
            ports:
            - containerPort: 3000

            # Readiness probe - pod receives traffic when ready
            readinessProbe:
              httpGet:
                path: /health
                port: 3000
              initialDelaySeconds: 5
              periodSeconds: 5

            # Liveness probe - restart pod if unhealthy
            livenessProbe:
              httpGet:
                path: /health
                port: 3000
              initialDelaySeconds: 15
              periodSeconds: 10

            # Lifecycle hooks
            lifecycle:
              preStop:
                exec:
                  command: ["/bin/sh", "-c", "sleep 15"]  # Grace period
    ```

    ### CI/CD with Rolling Update

    ```yaml
    # .github/workflows/rolling.yml
    name: Rolling Update

    on:
      push:
        branches: [main]

    jobs:
      deploy:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout
            uses: actions/checkout@v3

          - name: Configure kubectl
            uses: azure/k8s-set-context@v3
            with:
              method: kubeconfig
              kubeconfig: ${{ secrets.KUBE_CONFIG }}

          - name: Update deployment
            run: |
              # Update image
              kubectl set image deployment/myapp \\
                myapp=myapp:${{ github.sha }} \\
                --record

              # Watch rollout
              kubectl rollout status deployment/myapp --timeout=10m

          - name: Verify deployment
            run: |
              # Check all pods are ready
              kubectl wait --for=condition=ready pod \\
                -l app=myapp \\
                --timeout=300s

              # Verify new version
              POD=$(kubectl get pod -l app=myapp -o jsonpath='{.items[0].metadata.name}')
              VERSION=$(kubectl exec $POD -- cat /app/version.txt)

              if [[ "$VERSION" != "${{ github.sha }}" ]]; then
                echo "Version mismatch!"
                exit 1
              fi

          - name: Rollback on failure
            if: failure()
            run: |
              kubectl rollout undo deployment/myapp
              kubectl rollout status deployment/myapp --timeout=5m
              echo "Deployment rolled back"
    ```

    ## Feature Flags

    **Control feature rollout without deploying code**

    ### Benefits
    - Decouple deployment from release
    - Gradual rollout to user segments
    - A/B testing
    - Kill switch for problematic features
    - Testing in production

    ### Implementation with LaunchDarkly

    ```javascript
    // feature-flags.js
    const LaunchDarkly = require('launchdarkly-node-server-sdk');

    const client = LaunchDarkly.init(process.env.LAUNCHDARKLY_SDK_KEY);

    async function checkFeature(userId, featureKey) {
      const user = {
        key: userId,
        email: 'user@example.com',
        custom: {
          groups: ['beta-users']
        }
      };

      await client.waitForInitialization();
      const showFeature = await client.variation(featureKey, user, false);

      return showFeature;
    }

    // Usage
    app.get('/api/dashboard', async (req, res) => {
      const newDashboard = await checkFeature(req.user.id, 'new-dashboard');

      if (newDashboard) {
        return res.json({ version: 'v2', data: getNewDashboard() });
      } else {
        return res.json({ version: 'v1', data: getOldDashboard() });
      }
    });
    ```

    ### Percentage Rollout

    ```yaml
    # Feature flag configuration
    feature: new-checkout-flow
    enabled: true
    rollout:
      - percentage: 10
        variation: true
        audience: beta-users
      - percentage: 90
        variation: false
        audience: all-users
    ```

    ### Kill Switch Pattern

    ```javascript
    // kill-switch.js
    async function processPayment(paymentData) {
      const newPaymentEnabled = await checkFeature('new-payment-processor', false);

      if (newPaymentEnabled) {
        // New payment processor
        return await stripePayment(paymentData);
      } else {
        // Fallback to old processor
        return await legacyPayment(paymentData);
      }
    }
    ```

    ## Rollback Strategies

    ### 1. Immediate Rollback (Blue-Green)

    ```bash
    # Switch traffic back instantly
    aws elbv2 modify-listener \\
      --listener-arn $LISTENER_ARN \\
      --default-actions Type=forward,TargetGroupArn=$BLUE_TG_ARN
    ```

    ### 2. Gradual Rollback (Canary)

    ```bash
    # Reduce canary traffic
    kubectl scale deployment/myapp-canary --replicas=0
    kubectl scale deployment/myapp-stable --replicas=10
    ```

    ### 3. Version Rollback (Kubernetes)

    ```bash
    # Rollback to previous version
    kubectl rollout undo deployment/myapp

    # Rollback to specific revision
    kubectl rollout undo deployment/myapp --to-revision=3

    # Check rollout history
    kubectl rollout history deployment/myapp
    ```

    ### 4. Database Migration Rollback

    ```javascript
    // migrations/20240101_add_user_field.js
    exports.up = async (knex) => {
      await knex.schema.table('users', (table) => {
        table.string('phone_number');
      });
    };

    exports.down = async (knex) => {
      await knex.schema.table('users', (table) => {
        table.dropColumn('phone_number');
      });
    };

    // Rollback migration
    // npx knex migrate:rollback
    ```

    ## Monitoring Deployments

    ### Key Metrics to Track

    ```yaml
    metrics:
      # Application metrics
      - error_rate
      - response_time (p50, p95, p99)
      - requests_per_second
      - cpu_usage
      - memory_usage

      # Business metrics
      - conversion_rate
      - revenue_per_user
      - active_users
      - feature_usage
    ```

    ### Alerting on Deployment Issues

    ```yaml
    # prometheus-alerts.yml
    groups:
      - name: deployment
        interval: 30s
        rules:
          - alert: HighErrorRate
            expr: |
              rate(http_requests_total{status=~"5.."}[5m]) > 0.05
            for: 2m
            annotations:
              summary: "High error rate detected"
              description: "Error rate is {{ $value }} (threshold: 0.05)"

          - alert: SlowResponseTime
            expr: |
              histogram_quantile(0.95,
                rate(http_request_duration_seconds_bucket[5m])
              ) > 1
            for: 5m
            annotations:
              summary: "Slow response time"
              description: "P95 latency is {{ $value }}s"

          - alert: DeploymentFailed
            expr: |
              kube_deployment_status_replicas_available !=
              kube_deployment_spec_replicas
            for: 5m
            annotations:
              summary: "Deployment has failed"
              description: "{{ $labels.deployment }} has issues"
    ```

    ### Deployment Dashboard

    ```yaml
    # grafana-dashboard.json (simplified)
    {
      "dashboard": {
        "title": "Deployment Monitoring",
        "panels": [
          {
            "title": "Request Rate",
            "targets": [
              {
                "expr": "rate(http_requests_total[5m])"
              }
            ]
          },
          {
            "title": "Error Rate",
            "targets": [
              {
                "expr": "rate(http_requests_total{status=~'5..'}[5m])"
              }
            ]
          },
          {
            "title": "Response Time (P95)",
            "targets": [
              {
                "expr": "histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))"
              }
            ]
          },
          {
            "title": "Pod Status",
            "targets": [
              {
                "expr": "kube_pod_status_phase"
              }
            ]
          }
        ]
      }
    }
    ```

    ## Complete Example: Progressive Deployment

    ### Full workflow combining strategies

    ```yaml
    # .github/workflows/progressive-deployment.yml
    name: Progressive Deployment

    on:
      push:
        branches: [main]

    jobs:
      deploy:
        runs-on: ubuntu-latest
        steps:
          # ========================================
          # 1. Deploy to staging (rolling update)
          # ========================================
          - name: Deploy to staging
            run: |
              kubectl set image deployment/myapp-staging \\
                myapp=myapp:${{ github.sha }} \\
                --namespace=staging

              kubectl rollout status deployment/myapp-staging -n staging

          - name: Run E2E tests on staging
            run: npm run test:e2e:staging

          # ========================================
          # 2. Enable feature flag for 5% of users
          # ========================================
          - name: Enable for 5% of users
            run: |
              curl -X PATCH https://api.launchdarkly.com/api/v2/flags/default/new-version \\
                -H "Authorization: ${{ secrets.LAUNCHDARKLY_TOKEN }}" \\
                -H "Content-Type: application/json" \\
                -d '{
                  "patch": [
                    {
                      "op": "replace",
                      "path": "/environments/production/fallthrough/rollout/variations/0/weight",
                      "value": 5000
                    }
                  ]
                }'

          - name: Monitor for 30 minutes
            run: |
              sleep 1800
              # Check metrics
              # If error rate > threshold, rollback flag

          # ========================================
          # 3. Canary deployment (20% traffic)
          # ========================================
          - name: Deploy canary
            run: |
              kubectl set image deployment/myapp-canary \\
                myapp=myapp:${{ github.sha }}

              kubectl scale deployment/myapp-stable --replicas=8
              kubectl scale deployment/myapp-canary --replicas=2

          - name: Monitor canary for 1 hour
            run: |
              sleep 3600
              # Check canary metrics

          # ========================================
          # 4. Increase to 50%
          # ========================================
          - name: Scale to 50%
            run: |
              kubectl scale deployment/myapp-stable --replicas=5
              kubectl scale deployment/myapp-canary --replicas=5

          - name: Monitor for 2 hours
            run: sleep 7200

          # ========================================
          # 5. Full rollout
          # ========================================
          - name: Complete rollout
            run: |
              # Update stable to new version
              kubectl set image deployment/myapp-stable \\
                myapp=myapp:${{ github.sha }}

              kubectl rollout status deployment/myapp-stable

              # Scale down canary
              kubectl scale deployment/myapp-canary --replicas=0

              # Enable feature flag for 100%
              curl -X PATCH https://api.launchdarkly.com/api/v2/flags/default/new-version \\
                -H "Authorization: ${{ secrets.LAUNCHDARKLY_TOKEN }}" \\
                -d '{"patch": [{"op": "replace", "path": "/environments/production/on", "value": true}]}'

          - name: Notify team
            run: |
              curl -X POST ${{ secrets.SLACK_WEBHOOK }} \\
                -H 'Content-Type: application/json' \\
                -d '{
                  "text": "🚀 Production deployment complete!",
                  "attachments": [{
                    "color": "good",
                    "fields": [
                      {"title": "Version", "value": "${{ github.sha }}", "short": true},
                      {"title": "Environment", "value": "Production", "short": true}
                    ]
                  }]
                }'
    ```

    ## Summary

    **Deployment Strategies Comparison:**

    | Strategy | Downtime | Rollback Speed | Resource Cost | Complexity |
    |----------|----------|----------------|---------------|------------|
    | **Blue-Green** | None | Instant | High (2x resources) | Medium |
    | **Canary** | None | Fast | Low | High |
    | **Rolling** | None | Medium | Low | Low |
    | **Feature Flags** | None | Instant | None | Medium |

    **Best Practices:**
    1. **Start conservative** - Begin with small percentages
    2. **Monitor closely** - Watch metrics during rollout
    3. **Automate rollback** - Set thresholds for automatic rollback
    4. **Test thoroughly** - Validate in staging first
    5. **Communicate** - Notify team of deployment status
    6. **Document** - Keep runbooks for rollback procedures

    **Choosing a Strategy:**
    - **Blue-Green**: High-stakes releases, need instant rollback
    - **Canary**: Gradual confidence building, risk mitigation
    - **Rolling**: Standard updates, resource-constrained
    - **Feature Flags**: A/B testing, gradual feature rollout

    **Next Steps:**
    - Practice each strategy in a test environment
    - Set up monitoring and alerting
    - Create runbooks for rollback scenarios
    - Implement automated health checks
  MARKDOWN
  lesson.key_concepts = ['blue-green deployment', 'canary release', 'rolling update', 'feature flags', 'rollback', 'progressive deployment', 'monitoring']
end

ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1) do |item|
  item.sequence_order = 1
  item.required = true
end

puts "  ✅ Created CI/CD Pipelines course with comprehensive lessons\n"

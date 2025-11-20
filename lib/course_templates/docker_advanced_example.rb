# Example Template: Docker Advanced
# Demonstrates the new plugin system and config options
#
# This template shows how to:
# 1. Use plugins (progressive_learning, command_reference)
# 2. Set custom config
# 3. Create a complete course with all features

CourseBuilder::DSL.define("docker-advanced") do
  course(
    title: "Docker Advanced: Production Deployment",
    description: "Master Docker for production environments",
    difficulty_level: "advanced",
    estimated_hours: 30,
    certification_track: "dca",
    published: false
  ) do
    # Enable plugins for this course
    plugin :progressive_learning, enabled: true, validation_strict: true, hints_enabled: true
    plugin :command_reference, enabled: true, command_type: "docker", searchable: true

    # Set custom configuration
    config(
      interactive_units: true,
      command_validation: true,
      real_time_feedback: true,
      theme: "docker-pro",
      prerequisites: ["docker-fundamentals"]
    )

    # Module 1: Advanced Container Orchestration
    mod "Advanced Container Orchestration" do
      description "Deep dive into container orchestration patterns"
      estimated_minutes 240
      learning_objectives(
        "Understand multi-container orchestration",
        "Master Docker Compose advanced features",
        "Implement service mesh patterns"
      )

      lesson "Multi-Container Applications" do
        content <<~MARKDOWN
          # Multi-Container Applications

          Modern applications rarely run in a single container. Learn how to:
          - Orchestrate multiple containers
          - Manage inter-container communication
          - Handle shared volumes and networks
          - Implement health checks and dependencies

          ## Container Dependencies
          When building complex applications, containers often depend on each other...
        MARKDOWN
        reading_time 20
        key_concepts "Orchestration", "Service Dependencies", "Health Checks"
      end

      lab "Multi-Container Setup", lab_type: "docker-compose", format: "terminal" do
        description "Deploy a multi-tier application using Docker Compose"
        difficulty "hard"
        estimated_minutes 45

        step "Create Compose File",
          instruction: "Create a docker-compose.yml with web, api, and database services",
          command: "docker-compose up -d",
          validation: "docker-compose ps"

        step "Verify Services",
          instruction: "Check that all services are running",
          command: "docker-compose ps",
          expected_output: "Up"

        step "Test Communication",
          instruction: "Verify inter-service communication",
          command: "docker-compose exec web curl http://api:3000/health",
          expected_output: "OK"
      end

      quiz "Container Orchestration Quiz", passing_score: 80 do
        mcq "What is the purpose of depends_on in Docker Compose?",
          options: [
            "A) Defines service startup order",
            "B) Creates network dependencies",
            "C) Shares volumes between services",
            "D) Sets resource limits"
          ],
          correct: "A",
          explanation: "depends_on controls the startup order of services"

        command "How do you view logs for all services?",
          answer: "docker-compose logs",
          explanation: "docker-compose logs shows combined logs from all services"
      end
    end

    # Module 2: Production Security
    mod "Production Security Best Practices" do
      description "Secure your Docker containers for production"
      estimated_minutes 180

      lesson "Container Security Fundamentals" do
        content <<~MARKDOWN
          # Container Security

          Security is paramount in production environments...
        MARKDOWN
        reading_time 15
      end

      lab "Security Hardening", lab_type: "docker", format: "terminal" do
        description "Implement security best practices"

        step "Run as Non-Root",
          instruction: "Create a container running as non-root user",
          command: "docker run --user 1000:1000 nginx",
          validation: "ps aux | grep nginx"

        step "Read-Only Filesystem",
          instruction: "Run container with read-only root filesystem",
          command: "docker run --read-only nginx",
          validation: "docker inspect"
      end
    end

    # Module 3: Performance Optimization
    mod "Performance Optimization" do
      description "Optimize Docker for production performance"

      lesson "Image Optimization" do
        content <<~MARKDOWN
          # Image Optimization Strategies

          Smaller images = faster deployments = lower costs
        MARKDOWN
      end

      lab "Multi-Stage Builds", lab_type: "dockerfile", format: "code_editor" do
        description "Create optimized images using multi-stage builds"
        programming_language "dockerfile"

        starter_code <<~DOCKERFILE
          # Build stage
          FROM golang:1.21 AS builder
          WORKDIR /app
          # Your code here

          # Runtime stage
          FROM alpine:latest
          # Complete this stage
        DOCKERFILE

        solution <<~DOCKERFILE
          # Build stage
          FROM golang:1.21 AS builder
          WORKDIR /app
          COPY . .
          RUN go build -o app

          # Runtime stage
          FROM alpine:latest
          COPY --from=builder /app/app /app
          CMD ["/app"]
        DOCKERFILE

        test_case(
          name: "Image size",
          type: "size_check",
          max_size_mb: 50,
          points: 20
        )

        test_case(
          name: "Multi-stage used",
          type: "dockerfile_check",
          pattern: "FROM.*AS",
          points: 20
        )
      end
    end
  end
end

# This template demonstrates:
#
# ✅ Plugin system usage (progressive_learning, command_reference)
# ✅ Custom configuration (interactive_units, theme, prerequisites)
# ✅ Multiple lab types (terminal, code_editor)
# ✅ Advanced features (multi-stage builds, test cases)
# ✅ DCA certification alignment
#
# To generate this course:
#   rails course:generate[docker_advanced_example]
#
# To validate without generating:
#   rails course:validate[docker_advanced_example]

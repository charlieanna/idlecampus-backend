# AUTO-GENERATED from kubernetes_certification_courses.rb
puts "Creating Microlessons for Kubernetes Certification Courses..."

module_var = CourseModule.find_by(slug: 'kubernetes-certification-courses')

# === MICROLESSON 1: Practice Question ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# etcd Backup and Restore

    - etcdctl v3 snapshot save/restore
    - Certificates and endpoints
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

# Cluster Upgrades Strategy

    - Control plane then workers
    - Version skew policy
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 4: Lesson 4 ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 4',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Operating System Upgrades

    - Node image updates
    - Kernel and container runtime considerations
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 5: Lesson 5 ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 5',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Performance Tuning

    - Resource limits/requests and binpacking
    - kubelet/runtime flags
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 6: Lesson 6 ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 6',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Kubernetes Architecture Overview
    
    ## Control Plane Components
    
    ### API Server (kube-apiserver)
    - Central management entity
    - Exposes Kubernetes API
    - Frontend for the control plane
    - All operations go through the API server
    
    ### etcd
    - Consistent and highly-available key-value store
    - Stores all cluster data
    - Source of truth for cluster state
    
    ### Scheduler (kube-scheduler)
    - Watches for newly created Pods
    - Selects nodes for pods to run on
    - Considers resource requirements, constraints, and affinity
    
    ### Controller Manager (kube-controller-manager)
    - Runs controller processes
    - Node Controller: Monitors node status
    - Replication Controller: Maintains correct number of pods
    - Endpoints Controller: Populates endpoints objects
    - Service Account Controller: Creates default accounts
    
    ## Node Components
    
    ### kubelet
    - Runs on each node
    - Ensures containers are running in a Pod
    - Communicates with API server
    - Manages pod lifecycle
    
    ### kube-proxy
    - Network proxy on each node
    - Implements Kubernetes Service concept
    - Maintains network rules
    - Enables pod-to-pod communication
    
    ### Container Runtime
    - Software responsible for running containers
    - Examples: Docker, containerd, CRI-O
    
    ## Add-ons
    
    - **DNS**: Cluster DNS server (CoreDNS)
    - **Dashboard**: Web-based UI
    - **Ingress Controller**: HTTP/HTTPS routing
    - **Metrics Server**: Resource usage monitoring
    
    ## Communication Flow
    
    1. kubectl sends request to API server
    2. API server validates and stores in etcd
    3. Controllers watch for changes
    4. Scheduler assigns pods to nodes
    5. kubelet pulls images and starts containers
    6. kube-proxy configures networking
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 7: Lesson 7 ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 7',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Cluster Component Failures

    - API server, controller-manager, scheduler symptoms
    - Logs and health endpoints
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: Lesson 8 ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 8',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Node Troubleshooting

    - kubelet status and logs
    - NotReady nodes and taints
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 9: Lesson 9 ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 9',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod and Container Debugging

    - CrashLoopBackOff and ImagePullBackOff
    - kubectl describe/logs/exec, ephemeral containers
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 10: Lesson 10 ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 10',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Networking Issues

    - DNS, Services, Endpoints
    - CNI plugin diagnostics
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 11: Lesson 11 ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 11',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Storage Problems

    - Pending PVCs and provisioner logs
    - Mount failures
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 12: Lesson 12 ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 12',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Performance Bottlenecks

    - CPU/memory pressure, throttling
    - Scheduling delays and resource quotas
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 13: Lesson 13 ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 13',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Authentication Methods

    - Client certs, bearer tokens, OIDC
    - API server flags and configuration
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 14: Lesson 14 ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 14',
  content: <<~MARKDOWN,
# Microlesson 🚀

# RBAC Deep Dive

    - Roles vs ClusterRoles
    - RoleBinding and ClusterRoleBinding
    - Aggregated roles
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 15: Lesson 15 ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 15',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod Security Standards

    - Baseline, restricted profiles
    - Namespace-level enforcement
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 16: Lesson 16 ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 16',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Admission Controllers

    - Mutating vs Validating webhooks
    - Common built-in controllers
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 17: Lesson 17 ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 17',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Audit Logging

    - Policy configuration
    - Log backends and rotation
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 18: Lesson 18 ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 18',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Persistent Volumes Deep Dive

    - PV lifecycle and reclaim policies
    - Access modes and binding
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 19: Lesson 19 ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 19',
  content: <<~MARKDOWN,
# Microlesson 🚀

# StorageClasses and Provisioners

    - parameters and reclaimPolicy
    - default class and topology
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 20: Lesson 20 ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 20',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CSI Drivers

    - CSI fundamentals and sidecars
    - Driver deployment models
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 21: Lesson 21 ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 21',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Volume Snapshots and Cloning

    - Snapshot CRDs and classes
    - Clone from PVC
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 22: Lesson 22 ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 22',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Storage Troubleshooting

    - Pending PVC causes
    - Node/pod mount errors and driver logs
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 23: Lesson 23 ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 23',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Service Types and Endpoints (Admin)

    - ClusterIP/NodePort/LoadBalancer and externalTrafficPolicy
    - EndpointSlice and readiness gates for endpoints
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 24: Lesson 24 ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 24',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CoreDNS and Service Discovery

    - Server blocks and stub domains
    - Service discovery patterns
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 25: Lesson 25 ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 25',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CNI and Network Plugins

    - CNI basics and plugin architecture
    - Popular CNIs (Calico, Cilium, Weave)
  MARKDOWN
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 26: Lesson 26 ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 26',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Ingress Controllers Deep Dive

    - Controller deployment and class annotations
    - TLS, path/host routing, rewrites
  MARKDOWN
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 27: Lesson 27 ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 27',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Network Policies Advanced

    - Egress rules and namespace scoping
    - Common patterns and testing
  MARKDOWN
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 28: Lesson 28 ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 28',
  content: <<~MARKDOWN,
# Microlesson 🚀

# IPv6 and Dual-Stack

    - Dual-stack service/pod CIDRs
    - Caveats and controller support
  MARKDOWN
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 29: Lesson 29 ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 29',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod Scheduling Basics

    - Scheduler flow and predicates/priorities (legacy -> profiles)
    - Node selection and default scheduler behavior
  MARKDOWN
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 30: Lesson 30 ===
lesson_30 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 30',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Node Selectors and Affinity

    - nodeSelector vs nodeAffinity
    - requiredDuringScheduling vs preferredDuringScheduling
  MARKDOWN
  sequence_order: 30,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 31: Lesson 31 ===
lesson_31 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 31',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Taints, Tolerations, and Priority

    - NoSchedule, PreferNoSchedule, NoExecute effects
    - Pod priority and preemption
  MARKDOWN
  sequence_order: 31,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 32: Lesson 32 ===
lesson_32 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 32',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Resource Management and QoS

    - requests/limits and QoS classes
    - eviction thresholds and scheduling implications
  MARKDOWN
  sequence_order: 32,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 33: Lesson 33 ===
lesson_33 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 33',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod Disruption Budgets

    - minAvailable vs maxUnavailable
    - voluntary disruptions and drains
  MARKDOWN
  sequence_order: 33,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 34: Lesson 34 ===
lesson_34 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 34',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Container Images and Registries
    
    ## Building Container Images
    
    ### Dockerfile Best Practices
    
    ```dockerfile
    # Use specific base image versions
    FROM node:18-alpine
    
    # Set working directory
    WORKDIR /app
    
    # Copy dependency files first (better caching)
    COPY package*.json ./
    RUN npm ci --only=production
    
    # Copy application code
    COPY . .
    
    # Use non-root user
    USER node
    
    # Expose port
    EXPOSE 3000
    
    # Define command
    CMD ["node", "server.js"]
    ```
    
    ### Multi-stage Builds
    
    ```dockerfile
    # Build stage
    FROM golang:1.20 AS builder
    WORKDIR /app
    COPY . .
    RUN CGO_ENABLED=0 go build -o myapp
    
    # Runtime stage
    FROM alpine:latest
    COPY --from=builder /app/myapp /
    CMD ["/myapp"]
    ```
    
    ## Image Registries
    
    ### Docker Hub
    ```bash
    # Tag image
    docker tag myapp:latest username/myapp:v1.0
    
    # Push to Docker Hub
    docker push username/myapp:v1.0
    ```
    
    ### Private Registries
    ```bash
    # Tag for private registry
    docker tag myapp:latest registry.example.com/myapp:v1.0
    
    # Push to private registry
    docker push registry.example.com/myapp:v1.0
    ```
    
    ## Kubernetes Image Pull
    
    ### Using Public Images
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx-pod
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        imagePullPolicy: IfNotPresent
    ```
    
    ### Using Private Registries
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: private-app
    spec:
      containers:
      - name: app
        image: registry.example.com/myapp:v1.0
      imagePullSecrets:
      - name: regcred
    ```
    
    ### Creating Image Pull Secret
    ```bash
    kubectl create secret docker-registry regcred \
      --docker-server=registry.example.com \
      --docker-username=myuser \
      --docker-password=mypass \
      --docker-email=myemail@example.com
    ```
    
    ## Image Pull Policies
    
    - **Always**: Always pull the image
    - **IfNotPresent**: Pull if not cached locally
    - **Never**: Never pull, use local image only
    
    ## Security Best Practices
    
    1. Use specific image tags (not `latest`)
    2. Scan images for vulnerabilities
    3. Use minimal base images (alpine, distroless)
    4. Don't run as root
    5. Remove unnecessary packages
    6. Use multi-stage builds
  MARKDOWN
  sequence_order: 34,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 35: Lesson 35 ===
lesson_35 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 35',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Deployments: Rolling Updates and Rollbacks

    Use Deployments to declaratively manage application updates.
    - Strategies: RollingUpdate (maxSurge, maxUnavailable), Recreate
    - Rollout operations: status, pause, resume, undo
    - History and revisions
  MARKDOWN
  sequence_order: 35,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 36: Lesson 36 ===
lesson_36 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 36',
  content: <<~MARKDOWN,
# Microlesson 🚀

# StatefulSets for Stateful Applications

    Provide stable network IDs and storage for stateful workloads.
    - Ordered, graceful deployment and scaling
    - Persistent volume claims per replica
    - Headless services for DNS
  MARKDOWN
  sequence_order: 36,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 37: Lesson 37 ===
lesson_37 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 37',
  content: <<~MARKDOWN,
# Microlesson 🚀

# DaemonSets and Jobs

    - DaemonSets ensure a Pod runs on every node or subset
    - Jobs run a task to completion; CronJobs schedule Jobs
  MARKDOWN
  sequence_order: 37,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 38: Lesson 38 ===
lesson_38 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 38',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CronJobs and Batch Processing

    Schedule recurring tasks with CronJobs.
    - cron schedule format
    - history limits and concurrencyPolicy
    - suspend and resume
  MARKDOWN
  sequence_order: 38,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 39: Lesson 39 ===
lesson_39 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 39',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Blue-Green and Canary Deployments

    Progressive delivery strategies to minimize risk.
    - Blue/Green: switch traffic between environments
    - Canary: gradually shift traffic to new version
  MARKDOWN
  sequence_order: 39,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 40: Lesson 40 ===
lesson_40 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 40',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Helm Charts and Package Management

    - Helm chart structure (Chart.yaml, templates, values)
    - Installing and upgrading releases
    - Values overrides and templating basics
  MARKDOWN
  sequence_order: 40,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 41: Lesson 41 ===
lesson_41 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 41',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod Design Fundamentals

    Pods are the smallest deployable unit in Kubernetes. This lesson covers:

    - Pod anatomy: containers, initContainers, volumes
    - Restart policies and probes
    - Resource requests/limits and QoS classes
    - Labels, selectors, and annotations

    ## QoS Classes
    - Guaranteed: requests == limits for all containers
    - Burstable: some requests set, limits may differ
    - BestEffort: no requests or limits specified

    ## Best Practices
    - Keep Pods small and focused
    - Use requests to ensure scheduling and stability
    - Prefer readinessProbe to gate traffic
  MARKDOWN
  sequence_order: 41,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 42: Lesson 42 ===
lesson_42 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 42',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Multi-Container Pod Patterns

    Learn common multi-container patterns:
    - Sidecar: helper handles logs/metrics/proxy
    - Ambassador: proxy pattern for external services
    - Adapter: transforms output for consumption

    ## Shared Volumes
    Use emptyDir or other volumes to share data between containers.

    ## Example
    Sidecar tailing nginx access logs stored in a shared volume.
  MARKDOWN
  sequence_order: 42,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 43: Lesson 43 ===
lesson_43 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 43',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Init Containers and Pod Lifecycle

    Init containers run to completion before app containers start.
    Use cases:
    - Fetch configuration or warm caches
    - Wait for dependencies
    - Perform pre-flight checks

    ## Lifecycle Hooks
    - postStart and preStop hooks allow custom lifecycle actions
  MARKDOWN
  sequence_order: 43,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 44: Lesson 44 ===
lesson_44 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 44',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Building Cloud-Native Applications

    Design 12-factor applications for Kubernetes:
    - Config via environment
    - Stateless processes
    - Disposability
    - Dev/prod parity
    - Logs as event streams
  MARKDOWN
  sequence_order: 44,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 45: Lesson 45 ===
lesson_45 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 45',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Container Security Best Practices

    - Use non-root user
    - Read-only root filesystem
    - Pin image versions
    - Scan images for vulnerabilities
    - Limit capabilities
  MARKDOWN
  sequence_order: 45,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 46: Lesson 46 ===
lesson_46 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 46',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Health Checks: Liveness, Readiness, Startup

    - livenessProbe: restarts unhealthy containers
    - readinessProbe: controls traffic gating
    - startupProbe: delays liveness until startup completes
  MARKDOWN
  sequence_order: 46,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 47: Lesson 47 ===
lesson_47 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 47',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Application Logging Strategies

    - Write logs to stdout/stderr
    - Use sidecar for log shipping
    - Structured logs and correlation IDs
  MARKDOWN
  sequence_order: 47,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 48: Lesson 48 ===
lesson_48 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 48',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Monitoring Fundamentals

    - Metrics collection (Prometheus)
    - Alerting and recording rules
    - ServiceMonitor/PodMonitor basics
  MARKDOWN
  sequence_order: 48,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 49: Lesson 49 ===
lesson_49 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 49',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Debugging and Troubleshooting

    - kubectl describe, events, and logs
    - exec/attach and ephemeral containers
    - node/pod/network/storage triage
  MARKDOWN
  sequence_order: 49,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 50: Lesson 50 ===
lesson_50 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 50',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Distributed Tracing Basics

    - Trace context propagation
    - OpenTelemetry instrumentation
    - Visualizing traces in Jaeger/Grafana Tempo
  MARKDOWN
  sequence_order: 50,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 51: Lesson 51 ===
lesson_51 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 51',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Service Types and Endpoints

    - ClusterIP, NodePort, LoadBalancer
    - headless services and Endpoints/EndpointSlice
    - Session affinity and externalTrafficPolicy
  MARKDOWN
  sequence_order: 51,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 52: Lesson 52 ===
lesson_52 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 52',
  content: <<~MARKDOWN,
# Microlesson 🚀

# DNS and Service Discovery

    - CoreDNS, stub domains, and search paths
    - Service DNS names and SRV records
  MARKDOWN
  sequence_order: 52,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 53: Lesson 53 ===
lesson_53 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 53',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Ingress Controllers and Rules

    - path vs host rules, pathType
    - TLS termination
    - common controllers (nginx, traefik)
  MARKDOWN
  sequence_order: 53,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 54: Lesson 54 ===
lesson_54 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 54',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Network Policies for Microservices

    - policyTypes, podSelector, namespaceSelector
    - common allow/deny patterns
    - testing connectivity
  MARKDOWN
  sequence_order: 54,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 55: Lesson 55 ===
lesson_55 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 55',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Service Mesh Basics

    - sidecar proxies and data plane
    - traffic splitting and retries
    - mTLS overview
  MARKDOWN
  sequence_order: 55,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 56: Lesson 56 ===
lesson_56 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 56',
  content: <<~MARKDOWN,
# Microlesson 🚀

# ConfigMaps: Application Configuration

    - Key/value pairs and file-based configs
    - Mount via envFrom, env, and volumes
    - Updates and rollout behavior
  MARKDOWN
  sequence_order: 56,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 57: Lesson 57 ===
lesson_57 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 57',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Secrets Management and Security

    - Opaque secrets and stringData
    - Mounting secrets and envFrom
    - Secret encryption at rest (KMS)
  MARKDOWN
  sequence_order: 57,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 58: Lesson 58 ===
lesson_58 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 58',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Environment Variables and Command Arguments

    - env and envFrom with ConfigMap/Secret
    - args and command for entrypoint configuration
  MARKDOWN
  sequence_order: 58,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 59: Lesson 59 ===
lesson_59 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 59',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Resource Limits and Requests

    - CPU/memory units
    - QoS classes and scheduling impact
    - Best practices for sizing
  MARKDOWN
  sequence_order: 59,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 60: Lesson 60 ===
lesson_60 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 60',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Security Contexts and Pod Security

    - runAsUser, fsGroup, readOnlyRootFilesystem
    - Capabilities and privilege escalation
    - Overview of Pod Security standards
  MARKDOWN
  sequence_order: 60,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 61: Lesson 61 ===
lesson_61 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 61',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Service Accounts and RBAC for Apps

    - Default service account behavior
    - Binding Roles to service accounts
    - Token/ProjectedVolume considerations
  MARKDOWN
  sequence_order: 61,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 62: Lesson 62 ===
lesson_62 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 62',
  content: <<~MARKDOWN,
# Microlesson 🚀

# RBAC and Authentication in Kubernetes
    
    ## Role-Based Access Control (RBAC)
    
    ### Key Concepts
    
    - **Subjects**: Users, Groups, ServiceAccounts
    - **Resources**: Pods, Services, Deployments, etc.
    - **Verbs**: get, list, create, update, delete, watch
    
    ### Roles and ClusterRoles
    
    **Role** (namespace-scoped):
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      namespace: development
      name: pod-reader
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "list"]
    ```
    
    **ClusterRole** (cluster-wide):
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: secret-reader
    rules:
    - apiGroups: [""]
      resources: ["secrets"]
      verbs: ["get", "list"]
    ```
    
    ### RoleBindings and ClusterRoleBindings
    
    **RoleBinding**:
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: read-pods
      namespace: development
    subjects:
    - kind: User
      name: jane
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: Role
      name: pod-reader
      apiGroup: rbac.authorization.k8s.io
    ```
    
    **ClusterRoleBinding**:
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      name: read-secrets-global
    subjects:
    - kind: Group
      name: admins
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: ClusterRole
      name: secret-reader
      apiGroup: rbac.authorization.k8s.io
    ```
    
    ## Authentication Methods
    
    ### 1. X.509 Client Certificates
    ```bash
    # Create private key
    openssl genrsa -out jane.key 2048
    
    # Create certificate signing request
    openssl req -new -key jane.key -out jane.csr -subj "/CN=jane/O=developers"
    
    # Sign with cluster CA
    openssl x509 -req -in jane.csr -CA /etc/kubernetes/pki/ca.crt \
      -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial \
      -out jane.crt -days 365
    ```
    
    ### 2. Service Account Tokens
    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: build-bot
      namespace: ci-cd
    ```
    
    ```bash
    # Get token
    kubectl create token build-bot -n ci-cd
    ```
    
    ### 3. OpenID Connect (OIDC)
    Configure in kube-apiserver:
    ```
    --oidc-issuer-url=https://accounts.google.com
    --oidc-client-id=kubernetes
    --oidc-username-claim=email
    --oidc-groups-claim=groups
    ```
    
    ## Checking Permissions
    
    ```bash
    # Check if you can create deployments
    kubectl auth can-i create deployments --namespace=production
    
    # Check permissions for another user
    kubectl auth can-i list pods --as=jane --namespace=development
    
    # List all permissions for a user
    kubectl auth can-i --list --as=jane --namespace=development
    ```
    
    ## Best Practices
    
    1. **Principle of Least Privilege**: Grant minimum necessary permissions
    2. **Use ServiceAccounts**: For pod authentication
    3. **Avoid Wildcards**: Be specific with resources and verbs
    4. **Regular Audits**: Review and update RBAC policies
    5. **Separate Namespaces**: Isolate workloads
    6. **Use Groups**: Manage permissions via groups, not individual users
    
    ## Common RBAC Patterns
    
    ### Read-Only Access
    ```yaml
    rules:
    - apiGroups: ["", "apps", "batch"]
      resources: ["*"]
      verbs: ["get", "list", "watch"]
    ```
    
    ### Developer Access
    ```yaml
    rules:
    - apiGroups: ["", "apps"]
      resources: ["pods", "deployments", "services"]
      verbs: ["get", "list", "create", "update", "delete"]
    - apiGroups: [""]
      resources: ["pods/log"]
      verbs: ["get"]
    ```
    
    ### Cluster Admin
    ```yaml
    rules:
    - apiGroups: ["*"]
      resources: ["*"]
      verbs: ["*"]
    ```
  MARKDOWN
  sequence_order: 62,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 63: Lesson 63 ===
lesson_63 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 63',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Node Maintenance Procedures

    - cordon/drain/uncordon
    - DaemonSets behavior and PDBs impact
  MARKDOWN
  sequence_order: 63,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 64: Lesson 64 ===
lesson_64 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 64',
  content: <<~MARKDOWN,
# Microlesson 🚀

# etcd Backup and Restore

    - etcdctl v3 snapshot save/restore
    - Certificates and endpoints
  MARKDOWN
  sequence_order: 64,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 65: Lesson 65 ===
lesson_65 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 65',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Cluster Upgrades Strategy

    - Control plane then workers
    - Version skew policy
  MARKDOWN
  sequence_order: 65,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 66: Lesson 66 ===
lesson_66 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 66',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Operating System Upgrades

    - Node image updates
    - Kernel and container runtime considerations
  MARKDOWN
  sequence_order: 66,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 67: Lesson 67 ===
lesson_67 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 67',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Performance Tuning

    - Resource limits/requests and binpacking
    - kubelet/runtime flags
  MARKDOWN
  sequence_order: 67,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 68: Lesson 68 ===
lesson_68 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 68',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Kubernetes Architecture Overview
    
    ## Control Plane Components
    
    ### API Server (kube-apiserver)
    - Central management entity
    - Exposes Kubernetes API
    - Frontend for the control plane
    - All operations go through the API server
    
    ### etcd
    - Consistent and highly-available key-value store
    - Stores all cluster data
    - Source of truth for cluster state
    
    ### Scheduler (kube-scheduler)
    - Watches for newly created Pods
    - Selects nodes for pods to run on
    - Considers resource requirements, constraints, and affinity
    
    ### Controller Manager (kube-controller-manager)
    - Runs controller processes
    - Node Controller: Monitors node status
    - Replication Controller: Maintains correct number of pods
    - Endpoints Controller: Populates endpoints objects
    - Service Account Controller: Creates default accounts
    
    ## Node Components
    
    ### kubelet
    - Runs on each node
    - Ensures containers are running in a Pod
    - Communicates with API server
    - Manages pod lifecycle
    
    ### kube-proxy
    - Network proxy on each node
    - Implements Kubernetes Service concept
    - Maintains network rules
    - Enables pod-to-pod communication
    
    ### Container Runtime
    - Software responsible for running containers
    - Examples: Docker, containerd, CRI-O
    
    ## Add-ons
    
    - **DNS**: Cluster DNS server (CoreDNS)
    - **Dashboard**: Web-based UI
    - **Ingress Controller**: HTTP/HTTPS routing
    - **Metrics Server**: Resource usage monitoring
    
    ## Communication Flow
    
    1. kubectl sends request to API server
    2. API server validates and stores in etcd
    3. Controllers watch for changes
    4. Scheduler assigns pods to nodes
    5. kubelet pulls images and starts containers
    6. kube-proxy configures networking
  MARKDOWN
  sequence_order: 68,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 69: Lesson 69 ===
lesson_69 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 69',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Cluster Component Failures

    - API server, controller-manager, scheduler symptoms
    - Logs and health endpoints
  MARKDOWN
  sequence_order: 69,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 70: Lesson 70 ===
lesson_70 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 70',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Node Troubleshooting

    - kubelet status and logs
    - NotReady nodes and taints
  MARKDOWN
  sequence_order: 70,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 71: Lesson 71 ===
lesson_71 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 71',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod and Container Debugging

    - CrashLoopBackOff and ImagePullBackOff
    - kubectl describe/logs/exec, ephemeral containers
  MARKDOWN
  sequence_order: 71,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 72: Lesson 72 ===
lesson_72 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 72',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Networking Issues

    - DNS, Services, Endpoints
    - CNI plugin diagnostics
  MARKDOWN
  sequence_order: 72,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 73: Lesson 73 ===
lesson_73 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 73',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Storage Problems

    - Pending PVCs and provisioner logs
    - Mount failures
  MARKDOWN
  sequence_order: 73,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 74: Lesson 74 ===
lesson_74 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 74',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Performance Bottlenecks

    - CPU/memory pressure, throttling
    - Scheduling delays and resource quotas
  MARKDOWN
  sequence_order: 74,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 75: Lesson 75 ===
lesson_75 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 75',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Authentication Methods

    - Client certs, bearer tokens, OIDC
    - API server flags and configuration
  MARKDOWN
  sequence_order: 75,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 76: Lesson 76 ===
lesson_76 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 76',
  content: <<~MARKDOWN,
# Microlesson 🚀

# RBAC Deep Dive

    - Roles vs ClusterRoles
    - RoleBinding and ClusterRoleBinding
    - Aggregated roles
  MARKDOWN
  sequence_order: 76,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 77: Lesson 77 ===
lesson_77 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 77',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod Security Standards

    - Baseline, restricted profiles
    - Namespace-level enforcement
  MARKDOWN
  sequence_order: 77,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 78: Lesson 78 ===
lesson_78 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 78',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Admission Controllers

    - Mutating vs Validating webhooks
    - Common built-in controllers
  MARKDOWN
  sequence_order: 78,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 79: Lesson 79 ===
lesson_79 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 79',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Audit Logging

    - Policy configuration
    - Log backends and rotation
  MARKDOWN
  sequence_order: 79,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 80: Lesson 80 ===
lesson_80 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 80',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Persistent Volumes Deep Dive

    - PV lifecycle and reclaim policies
    - Access modes and binding
  MARKDOWN
  sequence_order: 80,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 81: Lesson 81 ===
lesson_81 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 81',
  content: <<~MARKDOWN,
# Microlesson 🚀

# StorageClasses and Provisioners

    - parameters and reclaimPolicy
    - default class and topology
  MARKDOWN
  sequence_order: 81,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 82: Lesson 82 ===
lesson_82 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 82',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CSI Drivers

    - CSI fundamentals and sidecars
    - Driver deployment models
  MARKDOWN
  sequence_order: 82,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 83: Lesson 83 ===
lesson_83 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 83',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Volume Snapshots and Cloning

    - Snapshot CRDs and classes
    - Clone from PVC
  MARKDOWN
  sequence_order: 83,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 84: Lesson 84 ===
lesson_84 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 84',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Storage Troubleshooting

    - Pending PVC causes
    - Node/pod mount errors and driver logs
  MARKDOWN
  sequence_order: 84,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 85: Lesson 85 ===
lesson_85 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 85',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Service Types and Endpoints (Admin)

    - ClusterIP/NodePort/LoadBalancer and externalTrafficPolicy
    - EndpointSlice and readiness gates for endpoints
  MARKDOWN
  sequence_order: 85,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 86: Lesson 86 ===
lesson_86 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 86',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CoreDNS and Service Discovery

    - Server blocks and stub domains
    - Service discovery patterns
  MARKDOWN
  sequence_order: 86,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 87: Lesson 87 ===
lesson_87 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 87',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CNI and Network Plugins

    - CNI basics and plugin architecture
    - Popular CNIs (Calico, Cilium, Weave)
  MARKDOWN
  sequence_order: 87,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 88: Lesson 88 ===
lesson_88 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 88',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Ingress Controllers Deep Dive

    - Controller deployment and class annotations
    - TLS, path/host routing, rewrites
  MARKDOWN
  sequence_order: 88,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 89: Lesson 89 ===
lesson_89 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 89',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Network Policies Advanced

    - Egress rules and namespace scoping
    - Common patterns and testing
  MARKDOWN
  sequence_order: 89,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 90: Lesson 90 ===
lesson_90 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 90',
  content: <<~MARKDOWN,
# Microlesson 🚀

# IPv6 and Dual-Stack

    - Dual-stack service/pod CIDRs
    - Caveats and controller support
  MARKDOWN
  sequence_order: 90,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 91: Lesson 91 ===
lesson_91 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 91',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod Scheduling Basics

    - Scheduler flow and predicates/priorities (legacy -> profiles)
    - Node selection and default scheduler behavior
  MARKDOWN
  sequence_order: 91,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 92: Lesson 92 ===
lesson_92 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 92',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Node Selectors and Affinity

    - nodeSelector vs nodeAffinity
    - requiredDuringScheduling vs preferredDuringScheduling
  MARKDOWN
  sequence_order: 92,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 93: Lesson 93 ===
lesson_93 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 93',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Taints, Tolerations, and Priority

    - NoSchedule, PreferNoSchedule, NoExecute effects
    - Pod priority and preemption
  MARKDOWN
  sequence_order: 93,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 94: Lesson 94 ===
lesson_94 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 94',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Resource Management and QoS

    - requests/limits and QoS classes
    - eviction thresholds and scheduling implications
  MARKDOWN
  sequence_order: 94,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 95: Lesson 95 ===
lesson_95 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 95',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod Disruption Budgets

    - minAvailable vs maxUnavailable
    - voluntary disruptions and drains
  MARKDOWN
  sequence_order: 95,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 96: Lesson 96 ===
lesson_96 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 96',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Container Images and Registries
    
    ## Building Container Images
    
    ### Dockerfile Best Practices
    
    ```dockerfile
    # Use specific base image versions
    FROM node:18-alpine
    
    # Set working directory
    WORKDIR /app
    
    # Copy dependency files first (better caching)
    COPY package*.json ./
    RUN npm ci --only=production
    
    # Copy application code
    COPY . .
    
    # Use non-root user
    USER node
    
    # Expose port
    EXPOSE 3000
    
    # Define command
    CMD ["node", "server.js"]
    ```
    
    ### Multi-stage Builds
    
    ```dockerfile
    # Build stage
    FROM golang:1.20 AS builder
    WORKDIR /app
    COPY . .
    RUN CGO_ENABLED=0 go build -o myapp
    
    # Runtime stage
    FROM alpine:latest
    COPY --from=builder /app/myapp /
    CMD ["/myapp"]
    ```
    
    ## Image Registries
    
    ### Docker Hub
    ```bash
    # Tag image
    docker tag myapp:latest username/myapp:v1.0
    
    # Push to Docker Hub
    docker push username/myapp:v1.0
    ```
    
    ### Private Registries
    ```bash
    # Tag for private registry
    docker tag myapp:latest registry.example.com/myapp:v1.0
    
    # Push to private registry
    docker push registry.example.com/myapp:v1.0
    ```
    
    ## Kubernetes Image Pull
    
    ### Using Public Images
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx-pod
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        imagePullPolicy: IfNotPresent
    ```
    
    ### Using Private Registries
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: private-app
    spec:
      containers:
      - name: app
        image: registry.example.com/myapp:v1.0
      imagePullSecrets:
      - name: regcred
    ```
    
    ### Creating Image Pull Secret
    ```bash
    kubectl create secret docker-registry regcred \
      --docker-server=registry.example.com \
      --docker-username=myuser \
      --docker-password=mypass \
      --docker-email=myemail@example.com
    ```
    
    ## Image Pull Policies
    
    - **Always**: Always pull the image
    - **IfNotPresent**: Pull if not cached locally
    - **Never**: Never pull, use local image only
    
    ## Security Best Practices
    
    1. Use specific image tags (not `latest`)
    2. Scan images for vulnerabilities
    3. Use minimal base images (alpine, distroless)
    4. Don't run as root
    5. Remove unnecessary packages
    6. Use multi-stage builds
  MARKDOWN
  sequence_order: 96,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 97: Lesson 97 ===
lesson_97 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 97',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Deployments: Rolling Updates and Rollbacks

    Use Deployments to declaratively manage application updates.
    - Strategies: RollingUpdate (maxSurge, maxUnavailable), Recreate
    - Rollout operations: status, pause, resume, undo
    - History and revisions
  MARKDOWN
  sequence_order: 97,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 98: Lesson 98 ===
lesson_98 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 98',
  content: <<~MARKDOWN,
# Microlesson 🚀

# StatefulSets for Stateful Applications

    Provide stable network IDs and storage for stateful workloads.
    - Ordered, graceful deployment and scaling
    - Persistent volume claims per replica
    - Headless services for DNS
  MARKDOWN
  sequence_order: 98,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 99: Lesson 99 ===
lesson_99 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 99',
  content: <<~MARKDOWN,
# Microlesson 🚀

# DaemonSets and Jobs

    - DaemonSets ensure a Pod runs on every node or subset
    - Jobs run a task to completion; CronJobs schedule Jobs
  MARKDOWN
  sequence_order: 99,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 100: Lesson 100 ===
lesson_100 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 100',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CronJobs and Batch Processing

    Schedule recurring tasks with CronJobs.
    - cron schedule format
    - history limits and concurrencyPolicy
    - suspend and resume
  MARKDOWN
  sequence_order: 100,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 101: Lesson 101 ===
lesson_101 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 101',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Blue-Green and Canary Deployments

    Progressive delivery strategies to minimize risk.
    - Blue/Green: switch traffic between environments
    - Canary: gradually shift traffic to new version
  MARKDOWN
  sequence_order: 101,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 102: Lesson 102 ===
lesson_102 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 102',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Helm Charts and Package Management

    - Helm chart structure (Chart.yaml, templates, values)
    - Installing and upgrading releases
    - Values overrides and templating basics
  MARKDOWN
  sequence_order: 102,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 103: Lesson 103 ===
lesson_103 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 103',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Pod Design Fundamentals

    Pods are the smallest deployable unit in Kubernetes. This lesson covers:

    - Pod anatomy: containers, initContainers, volumes
    - Restart policies and probes
    - Resource requests/limits and QoS classes
    - Labels, selectors, and annotations

    ## QoS Classes
    - Guaranteed: requests == limits for all containers
    - Burstable: some requests set, limits may differ
    - BestEffort: no requests or limits specified

    ## Best Practices
    - Keep Pods small and focused
    - Use requests to ensure scheduling and stability
    - Prefer readinessProbe to gate traffic
  MARKDOWN
  sequence_order: 103,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 104: Lesson 104 ===
lesson_104 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 104',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Multi-Container Pod Patterns

    Learn common multi-container patterns:
    - Sidecar: helper handles logs/metrics/proxy
    - Ambassador: proxy pattern for external services
    - Adapter: transforms output for consumption

    ## Shared Volumes
    Use emptyDir or other volumes to share data between containers.

    ## Example
    Sidecar tailing nginx access logs stored in a shared volume.
  MARKDOWN
  sequence_order: 104,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 105: Lesson 105 ===
lesson_105 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 105',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Init Containers and Pod Lifecycle

    Init containers run to completion before app containers start.
    Use cases:
    - Fetch configuration or warm caches
    - Wait for dependencies
    - Perform pre-flight checks

    ## Lifecycle Hooks
    - postStart and preStop hooks allow custom lifecycle actions
  MARKDOWN
  sequence_order: 105,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 106: Lesson 106 ===
lesson_106 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 106',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Building Cloud-Native Applications

    Design 12-factor applications for Kubernetes:
    - Config via environment
    - Stateless processes
    - Disposability
    - Dev/prod parity
    - Logs as event streams
  MARKDOWN
  sequence_order: 106,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 107: Lesson 107 ===
lesson_107 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 107',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Container Security Best Practices

    - Use non-root user
    - Read-only root filesystem
    - Pin image versions
    - Scan images for vulnerabilities
    - Limit capabilities
  MARKDOWN
  sequence_order: 107,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 108: Lesson 108 ===
lesson_108 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 108',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Health Checks: Liveness, Readiness, Startup

    - livenessProbe: restarts unhealthy containers
    - readinessProbe: controls traffic gating
    - startupProbe: delays liveness until startup completes
  MARKDOWN
  sequence_order: 108,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 109: Lesson 109 ===
lesson_109 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 109',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Application Logging Strategies

    - Write logs to stdout/stderr
    - Use sidecar for log shipping
    - Structured logs and correlation IDs
  MARKDOWN
  sequence_order: 109,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 110: Lesson 110 ===
lesson_110 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 110',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Monitoring Fundamentals

    - Metrics collection (Prometheus)
    - Alerting and recording rules
    - ServiceMonitor/PodMonitor basics
  MARKDOWN
  sequence_order: 110,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 111: Lesson 111 ===
lesson_111 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 111',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Debugging and Troubleshooting

    - kubectl describe, events, and logs
    - exec/attach and ephemeral containers
    - node/pod/network/storage triage
  MARKDOWN
  sequence_order: 111,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 112: Lesson 112 ===
lesson_112 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 112',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Distributed Tracing Basics

    - Trace context propagation
    - OpenTelemetry instrumentation
    - Visualizing traces in Jaeger/Grafana Tempo
  MARKDOWN
  sequence_order: 112,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 113: Lesson 113 ===
lesson_113 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 113',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Service Types and Endpoints

    - ClusterIP, NodePort, LoadBalancer
    - headless services and Endpoints/EndpointSlice
    - Session affinity and externalTrafficPolicy
  MARKDOWN
  sequence_order: 113,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 114: Lesson 114 ===
lesson_114 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 114',
  content: <<~MARKDOWN,
# Microlesson 🚀

# DNS and Service Discovery

    - CoreDNS, stub domains, and search paths
    - Service DNS names and SRV records
  MARKDOWN
  sequence_order: 114,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 115: Lesson 115 ===
lesson_115 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 115',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Ingress Controllers and Rules

    - path vs host rules, pathType
    - TLS termination
    - common controllers (nginx, traefik)
  MARKDOWN
  sequence_order: 115,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 116: Lesson 116 ===
lesson_116 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 116',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Network Policies for Microservices

    - policyTypes, podSelector, namespaceSelector
    - common allow/deny patterns
    - testing connectivity
  MARKDOWN
  sequence_order: 116,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 117: Lesson 117 ===
lesson_117 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 117',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Service Mesh Basics

    - sidecar proxies and data plane
    - traffic splitting and retries
    - mTLS overview
  MARKDOWN
  sequence_order: 117,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 118: Lesson 118 ===
lesson_118 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 118',
  content: <<~MARKDOWN,
# Microlesson 🚀

# ConfigMaps: Application Configuration

    - Key/value pairs and file-based configs
    - Mount via envFrom, env, and volumes
    - Updates and rollout behavior
  MARKDOWN
  sequence_order: 118,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 119: Lesson 119 ===
lesson_119 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 119',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Secrets Management and Security

    - Opaque secrets and stringData
    - Mounting secrets and envFrom
    - Secret encryption at rest (KMS)
  MARKDOWN
  sequence_order: 119,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 120: Lesson 120 ===
lesson_120 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 120',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Environment Variables and Command Arguments

    - env and envFrom with ConfigMap/Secret
    - args and command for entrypoint configuration
  MARKDOWN
  sequence_order: 120,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 121: Lesson 121 ===
lesson_121 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 121',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Resource Limits and Requests

    - CPU/memory units
    - QoS classes and scheduling impact
    - Best practices for sizing
  MARKDOWN
  sequence_order: 121,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 122: Lesson 122 ===
lesson_122 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 122',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Security Contexts and Pod Security

    - runAsUser, fsGroup, readOnlyRootFilesystem
    - Capabilities and privilege escalation
    - Overview of Pod Security standards
  MARKDOWN
  sequence_order: 122,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 123: Lesson 123 ===
lesson_123 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 123',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Service Accounts and RBAC for Apps

    - Default service account behavior
    - Binding Roles to service accounts
    - Token/ProjectedVolume considerations
  MARKDOWN
  sequence_order: 123,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 124: Lesson 124 ===
lesson_124 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 124',
  content: <<~MARKDOWN,
# Microlesson 🚀

# RBAC and Authentication in Kubernetes
    
    ## Role-Based Access Control (RBAC)
    
    ### Key Concepts
    
    - **Subjects**: Users, Groups, ServiceAccounts
    - **Resources**: Pods, Services, Deployments, etc.
    - **Verbs**: get, list, create, update, delete, watch
    
    ### Roles and ClusterRoles
    
    **Role** (namespace-scoped):
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      namespace: development
      name: pod-reader
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "list"]
    ```
    
    **ClusterRole** (cluster-wide):
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: secret-reader
    rules:
    - apiGroups: [""]
      resources: ["secrets"]
      verbs: ["get", "list"]
    ```
    
    ### RoleBindings and ClusterRoleBindings
    
    **RoleBinding**:
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: read-pods
      namespace: development
    subjects:
    - kind: User
      name: jane
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: Role
      name: pod-reader
      apiGroup: rbac.authorization.k8s.io
    ```
    
    **ClusterRoleBinding**:
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      name: read-secrets-global
    subjects:
    - kind: Group
      name: admins
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: ClusterRole
      name: secret-reader
      apiGroup: rbac.authorization.k8s.io
    ```
    
    ## Authentication Methods
    
    ### 1. X.509 Client Certificates
    ```bash
    # Create private key
    openssl genrsa -out jane.key 2048
    
    # Create certificate signing request
    openssl req -new -key jane.key -out jane.csr -subj "/CN=jane/O=developers"
    
    # Sign with cluster CA
    openssl x509 -req -in jane.csr -CA /etc/kubernetes/pki/ca.crt \
      -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial \
      -out jane.crt -days 365
    ```
    
    ### 2. Service Account Tokens
    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: build-bot
      namespace: ci-cd
    ```
    
    ```bash
    # Get token
    kubectl create token build-bot -n ci-cd
    ```
    
    ### 3. OpenID Connect (OIDC)
    Configure in kube-apiserver:
    ```
    --oidc-issuer-url=https://accounts.google.com
    --oidc-client-id=kubernetes
    --oidc-username-claim=email
    --oidc-groups-claim=groups
    ```
    
    ## Checking Permissions
    
    ```bash
    # Check if you can create deployments
    kubectl auth can-i create deployments --namespace=production
    
    # Check permissions for another user
    kubectl auth can-i list pods --as=jane --namespace=development
    
    # List all permissions for a user
    kubectl auth can-i --list --as=jane --namespace=development
    ```
    
    ## Best Practices
    
    1. **Principle of Least Privilege**: Grant minimum necessary permissions
    2. **Use ServiceAccounts**: For pod authentication
    3. **Avoid Wildcards**: Be specific with resources and verbs
    4. **Regular Audits**: Review and update RBAC policies
    5. **Separate Namespaces**: Isolate workloads
    6. **Use Groups**: Manage permissions via groups, not individual users
    
    ## Common RBAC Patterns
    
    ### Read-Only Access
    ```yaml
    rules:
    - apiGroups: ["", "apps", "batch"]
      resources: ["*"]
      verbs: ["get", "list", "watch"]
    ```
    
    ### Developer Access
    ```yaml
    rules:
    - apiGroups: ["", "apps"]
      resources: ["pods", "deployments", "services"]
      verbs: ["get", "list", "create", "update", "delete"]
    - apiGroups: [""]
      resources: ["pods/log"]
      verbs: ["get"]
    ```
    
    ### Cluster Admin
    ```yaml
    rules:
    - apiGroups: ["*"]
      resources: ["*"]
      verbs: ["*"]
    ```
  MARKDOWN
  sequence_order: 124,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 125: Practice Question ===
lesson_125 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 125,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 126: Practice Question ===
lesson_126 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 126,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 127: Practice Question ===
lesson_127 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 127,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 128: Practice Question ===
lesson_128 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 128,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 129: Practice Question ===
lesson_129 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 129,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 130: Practice Question ===
lesson_130 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 130,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 131: Practice Question ===
lesson_131 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 131,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 132: Practice Question ===
lesson_132 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 132,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 133: Practice Question ===
lesson_133 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 133,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 134: Practice Question ===
lesson_134 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 134,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 135: Practice Question ===
lesson_135 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 135,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 136: Practice Question ===
lesson_136 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 136,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 137: Practice Question ===
lesson_137 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 137,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 138: Practice Question ===
lesson_138 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 138,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 139: Practice Question ===
lesson_139 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

Use etcdctl v3 snapshot save.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 139,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 140: Practice Question ===
lesson_140 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

kubectl create deploy <name> --image=... --replicas=...

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 140,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 141: Practice Question ===
lesson_141 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

RoleBinding can bind a ClusterRole in a namespace.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 141,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 142: Practice Question ===
lesson_142 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 142,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 143: Practice Question ===
lesson_143 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 143,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 144: Practice Question ===
lesson_144 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 144,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 145: Practice Question ===
lesson_145 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 145,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 146: Practice Question ===
lesson_146 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 146,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 147: Practice Question ===
lesson_147 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 147,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 148: Practice Question ===
lesson_148 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 148,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 149: Practice Question ===
lesson_149 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 149,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 150: Practice Question ===
lesson_150 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 150,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 151: Practice Question ===
lesson_151 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 151,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 152: Practice Question ===
lesson_152 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 152,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 153: Practice Question ===
lesson_153 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 153,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 154: Practice Question ===
lesson_154 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 154,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 155: Practice Question ===
lesson_155 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 155,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 156: Practice Question ===
lesson_156 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 156,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 157: Practice Question ===
lesson_157 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 157,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 158: Lesson 158 ===
lesson_158 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 158',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Node Maintenance Procedures

    - cordon/drain/uncordon
    - DaemonSets behavior and PDBs impact
  MARKDOWN
  sequence_order: 158,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 158 microlessons for Kubernetes Certification Courses"

# AUTO-GENERATED from kubernetes_complete_guide.rb
puts "Creating Microlessons for Kubernetes Complete Guide..."

module_var = CourseModule.find_by(slug: 'kubernetes-complete-guide')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Security & Operations

    Master security best practices and operational procedures for production Kubernetes clusters.

    ## Role-Based Access Control (RBAC)

    Control who can access what resources:

    **Roles & ClusterRoles:**
    - **Role**: Namespace-scoped permissions
    - **ClusterRole**: Cluster-wide permissions

    **RoleBindings & ClusterRoleBindings:**
    - Grant permissions to users/groups/service accounts
    - Bind roles to subjects

    **Example:**
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      name: pod-reader
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "list"]
    ```

    ## Security Contexts

    Define privilege and access control for pods/containers:

    **Pod Security Context:**
    ```yaml
    securityContext:
      runAsNonRoot: true
      runAsUser: 1000
      fsGroup: 2000
    ```

    **Container Security Context:**
    ```yaml
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
    ```

    ## Pod Security Standards

    - **Privileged**: Unrestricted
    - **Baseline**: Minimal restrictions
    - **Restricted**: Heavily restricted (production recommended)

    ## Admission Controllers

    Intercept and validate/mutate requests:
    - **PodSecurityPolicy** (deprecated)
    - **PodSecurity admission** (replacement)
    - **ResourceQuota**: Limit resource usage
    - **LimitRanger**: Set default limits
    - **MutatingWebhook**: Modify objects
    - **ValidatingWebhook**: Validate objects

    ## Network Security

    **Network Policies:**
    - Default deny all traffic
    - Explicitly allow required connections
    - Namespace isolation

    **TLS/SSL:**
    - Encrypt traffic between services
    - Use cert-manager for certificate management
    - Rotate certificates regularly

    ## Cluster Maintenance

    **Node Maintenance:**
    ```bash
    # Drain node (evict pods)
    kubectl drain node-name --ignore-daemonsets

    # Mark node unschedulable
    kubectl cordon node-name

    # Mark node schedulable
    kubectl uncordon node-name
    ```

    **Backup & Disaster Recovery:**
    - Backup etcd regularly
    - Store backups securely off-cluster
    - Test restore procedures
    - Document recovery steps

    **Etcd Backup:**
    ```bash
    # Backup etcd
    ETCDCTL_API=3 etcdctl snapshot save backup.db \
      --endpoints=https://127.0.0.1:2379 \
      --cacert=/etc/kubernetes/pki/etcd/ca.crt \
      --cert=/etc/kubernetes/pki/etcd/server.crt \
      --key=/etc/kubernetes/pki/etcd/server.key

    # Verify backup
    ETCDCTL_API=3 etcdctl snapshot status backup.db
    ```

    **Upgrade Strategies:**
    - Review release notes
    - Test in staging first
    - Upgrade control plane first
    - Then upgrade worker nodes
    - Use rolling updates for nodes

    ## Security Best Practices

    1. **Least Privilege Principle**
       - Minimal RBAC permissions
       - Non-root containers
       - Read-only filesystems

    2. **Image Security**
       - Scan images for vulnerabilities
       - Use trusted registries
       - Implement image pull policies
       - Verify image signatures

    3. **Secrets Management**
       - Encrypt secrets at rest
       - Use external secret managers (Vault)
       - Rotate secrets regularly
       - Limit secret access with RBAC

    4. **Audit Logging**
       - Enable audit logs
       - Monitor suspicious activities
       - Implement alerting
       - Regular security reviews

    5. **Resource Limits**
       - Set requests and limits
       - Prevent resource exhaustion
       - Use ResourceQuotas
       - Implement LimitRanges

    Master security and operations in the final labs!
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 1.1: Code (Security context Pod)
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'code',
  sequence_order: 1,
  exercise_data: {
    files: ['k8s/security/pod-sec.yaml'],
    starter_code: <<~YAML,
      apiVersion: v1
      kind: Pod
      metadata:
        name: secure-pod
      spec:
        securityContext:
          runAsNonRoot: true
          runAsUser: 1000
          fsGroup: 2000
        containers:
        - name: app
          image: busybox:1.36
          command: ['sh','-c','sleep 3600']
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
    YAML
    tests: {
      run: 'kubectl apply -f k8s/security/pod-sec.yaml && kubectl get pod secure-pod -o jsonpath="{.spec.securityContext.runAsNonRoot}"',
      visible: ['Pod has runAsNonRoot true'],
      hidden: ['Container readOnlyRootFilesystem true']
    },
    require_pass: true,
    hints: ['Set pod-level runAsNonRoot/user/fsGroup', 'Disable privilege escalation and set readOnlyRootFilesystem at container']
  }
)

# Exercise 1.2: Code (RBAC Role/Binding)
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'code',
  sequence_order: 2,
  exercise_data: {
    files: ['k8s/rbac/role.yaml','k8s/rbac/binding.yaml'],
    starter_code: <<~YAML,
      ---
      apiVersion: rbac.authorization.k8s.io/v1
      kind: Role
      metadata:
        name: pod-reader
        namespace: default
      rules:
      - apiGroups: ['']
        resources: ['pods']
        verbs: ['get','list']
      ---
      apiVersion: rbac.authorization.k8s.io/v1
      kind: RoleBinding
      metadata:
        name: read-pods
        namespace: default
      subjects:
      - kind: ServiceAccount
        name: default
        namespace: default
      roleRef:
        kind: Role
        name: pod-reader
        apiGroup: rbac.authorization.k8s.io
    YAML
    tests: {
      run: 'kubectl apply -f k8s/rbac/role.yaml -f k8s/rbac/binding.yaml && kubectl auth can-i get pods --as=system:serviceaccount:default:default -n default',
      visible: ['can-i returns yes'],
      hidden: ['Role and binding namespaces match']
    },
    require_pass: true,
    hints: ['Bind Role to subject in same namespace', 'verbs should include get/list for pods']
  }
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Deployments & ReplicaSets

    Learn how to manage application replicas and perform zero-downtime updates using Deployments and ReplicaSets.

    ## Deployments

    Deployments provide declarative updates for Pods and ReplicaSets. They handle:
    - Scaling applications up or down
    - Rolling updates with zero downtime
    - Rollback to previous versions
    - Pausing and resuming updates

    ## ReplicaSets

    ReplicaSets ensure a specified number of pod replicas are running at all times. Features:
    - Self-healing: Automatically replaces failed pods
    - Scaling: Adjusts replica count based on demand
    - Label selectors: Identifies which pods to manage

    ## Deployment Strategies

    **Rolling Update (Default)**
    - Gradually replaces old pods with new ones
    - Zero downtime
    - Rollback capability

    **Recreate**
    - Terminates all old pods before creating new ones
    - Brief downtime
    - Useful for incompatible updates

    ## Essential Commands

    ```bash
    # Create deployment
    kubectl create deployment nginx --image=nginx:1.25 --replicas=3

    # Scale deployment
    kubectl scale deployment nginx --replicas=5

    # Update image
    kubectl set image deployment/nginx nginx=nginx:1.26

    # Check rollout status
    kubectl rollout status deployment/nginx

    # View rollout history
    kubectl rollout history deployment/nginx

    # Rollback deployment
    kubectl rollout undo deployment/nginx
    ```

    Master these concepts through practical exercises!
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

# Services & Networking

    Learn how to expose your applications and enable communication between pods and external clients.

    ## Services

    Services provide stable networking endpoints for accessing pods. Types:

    **ClusterIP (Default)**
    - Internal-only access
    - Pods within cluster can communicate
    - Use for internal microservices

    **NodePort**
    - Exposes service on each node's IP
    - External access via <NodeIP>:<NodePort>
    - Useful for development/testing

    **LoadBalancer**
    - Creates external load balancer
    - Cloud provider integration required
    - Production external access

    **ExternalName**
    - Maps service to external DNS name
    - No proxy or forwarding

    ## DNS in Kubernetes

    Every service gets a DNS name:
    - Format: `<service-name>.<namespace>.svc.cluster.local`
    - Pods can access services by name
    - Automatic service discovery

    ## Network Policies

    Control traffic flow between pods:
    - Ingress rules: Incoming traffic
    - Egress rules: Outgoing traffic
    - Label-based selection
    - Namespace isolation

    ## Essential Commands

    ```bash
    # Create service
    kubectl expose deployment nginx --port=80 --type=LoadBalancer

    # List services
    kubectl get services
    kubectl get svc

    # Describe service
    kubectl describe service nginx

    # Test service connectivity
    kubectl run curl --image=curlimages/curl -it --rm -- curl http://nginx
    ```

    Practice service configuration in the labs!
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

# Configuration Management

    Learn to externalize configuration from application code using ConfigMaps and Secrets.

    ## ConfigMaps

    Store non-confidential configuration data as key-value pairs:
    - Application settings
    - Configuration files
    - Environment variables
    - Command-line arguments

    **Creation Methods:**
    - From literal values: `kubectl create configmap app-config --from-literal=KEY=VALUE`
    - From files: `kubectl create configmap app-config --from-file=config.properties`
    - From directories: `kubectl create configmap app-config --from-file=./config/`

    ## Secrets

    Store sensitive information securely:
    - Passwords and API keys
    - TLS certificates
    - Docker registry credentials
    - OAuth tokens

    **Secret Types:**
    - **Opaque**: Generic secret (default)
    - **kubernetes.io/tls**: TLS certificate
    - **kubernetes.io/dockerconfigjson**: Docker registry auth
    - **kubernetes.io/service-account-token**: Service account token

    ## Using Configuration

    **Environment Variables:**
    ```yaml
    env:
    - name: DATABASE_URL
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: db_url
    ```

    **Volume Mounts:**
    ```yaml
    volumes:
    - name: config
      configMap:
        name: app-config
    volumeMounts:
    - name: config
      mountPath: /etc/config
    ```

    ## Best Practices

    - Never hardcode sensitive data
    - Use Secrets for credentials
    - Use ConfigMaps for non-sensitive config
    - Enable encryption at rest for Secrets
    - Limit Secret access with RBAC

    Practice configuration management in the labs!
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

# Storage & Persistence

    Learn to provide persistent storage for stateful applications in Kubernetes.

    ## Volume Types

    **Ephemeral Volumes (Pod lifetime):**
    - **emptyDir**: Temporary storage, deleted when pod dies
    - **configMap/secret**: Configuration mounted as volumes

    **Persistent Volumes (Beyond pod lifetime):**
    - **hostPath**: Mount directory from node filesystem
    - **nfs**: Network File System mount
    - **cloud volumes**: AWS EBS, GCE PD, Azure Disk
    - **csi**: Container Storage Interface drivers

    ## Persistent Volume (PV)

    Cluster-level storage resource provisioned by admin:
    - Lifecycle independent of pods
    - Can be statically or dynamically provisioned
    - Has capacity, access modes, and reclaim policy

    **Access Modes:**
    - **ReadWriteOnce (RWO)**: Single node read-write
    - **ReadOnlyMany (ROX)**: Multiple nodes read-only
    - **ReadWriteMany (RWX)**: Multiple nodes read-write

    **Reclaim Policies:**
    - **Retain**: Manual reclamation
    - **Delete**: Automatic deletion
    - **Recycle**: Basic scrub (deprecated)

    ## Persistent Volume Claim (PVC)

    User request for storage:
    - Requests specific size and access modes
    - Binds to available PV
    - Can specify StorageClass

    ## Storage Classes

    Dynamic provisioning of storage:
    - Define storage provisioner (AWS, GCE, etc.)
    - Set parameters (type, IOPS, replication)
    - Enable automatic PV creation
    - Support for different storage tiers

    ## Essential Commands

    ```bash
    # List persistent volumes
    kubectl get pv

    # List persistent volume claims
    kubectl get pvc

    # Describe PVC
    kubectl describe pvc my-pvc

    # List storage classes
    kubectl get storageclass
    kubectl get sc
    ```

    Practice storage configuration in the labs!
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

# Advanced Workloads

    Learn specialized workload controllers for stateful applications, background tasks, and system services.

    ## StatefulSets

    For stateful applications requiring:
    - Stable network identities
    - Persistent storage
    - Ordered deployment and scaling
    - Ordered rolling updates

    **Use Cases:**
    - Databases (MySQL, PostgreSQL, MongoDB)
    - Distributed systems (Kafka, Zookeeper)
    - Any app requiring persistent identity

    **Features:**
    - Predictable pod names: `<statefulset-name>-<ordinal>`
    - Headless service for stable network identity
    - Ordered pod creation: 0, 1, 2, ...
    - Ordered pod deletion: 2, 1, 0, ...

    ## DaemonSets

    Ensures all (or specific) nodes run a copy of a pod:
    - Node monitoring agents
    - Log collectors
    - Storage daemons
    - Network plugins

    **Features:**
    - Automatically schedules pods on new nodes
    - Removes pods from nodes being decommissioned
    - Can target specific nodes using selectors

    ## Jobs

    Run batch tasks to completion:
    - One-time tasks
    - Parallel processing
    - Guaranteed completion
    - Retry on failure

    **Job Patterns:**
    - **Single completion**: Run task once
    - **Fixed completions**: Run N times
    - **Work queue**: Process items from queue

    ## CronJobs

    Scheduled recurring tasks:
    - Backups
    - Report generation
    - Data cleanup
    - Periodic checks

    **Schedule Format:**
    - Cron syntax: `* * * * *` (minute hour day month weekday)
    - Example: `0 2 * * *` (daily at 2 AM)

    ## Resource Management

    **Requests**: Minimum guaranteed resources
    ```yaml
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
    ```

    **Limits**: Maximum allowed resources
    ```yaml
    resources:
      limits:
        memory: "128Mi"
        cpu: "500m"
    ```

    **Quality of Service (QoS) Classes:**
    - **Guaranteed**: Requests = Limits
    - **Burstable**: Requests < Limits
    - **BestEffort**: No requests/limits set

    Practice these advanced patterns in the labs!
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

# Networking Deep Dive

    Master advanced networking concepts including Ingress, Network Policies, and troubleshooting techniques.

    ## Ingress

    HTTP/HTTPS routing to services:
    - Single external endpoint
    - Path-based routing
    - Virtual hosting
    - TLS/SSL termination

    **Ingress Controllers:**
    - NGINX Ingress Controller
    - Traefik
    - HAProxy
    - Cloud-specific (ALB, GCE)

    **Example Ingress:**
    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: my-ingress
    spec:
      rules:
      - host: app.example.com
        http:
          paths:
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: api-service
                port:
                  number: 80
    ```

    ## Network Policies

    Control traffic between pods:

    **Default Behavior:** All pods can communicate

    **With NetworkPolicy:**
    - Deny all, allow specific
    - Label-based selection
    - Namespace isolation
    - Ingress and egress rules

    **Example Policy:**
    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: allow-frontend
    spec:
      podSelector:
        matchLabels:
          role: backend
      ingress:
      - from:
        - podSelector:
            matchLabels:
              role: frontend
        ports:
        - protocol: TCP
          port: 8080
    ```

    ## Network Troubleshooting

    **Common Issues:**
    - Service not accessible
    - DNS resolution failures
    - Network policy blocking traffic
    - Ingress misconfiguration

    **Debugging Tools:**
    ```bash
    # Test service connectivity
    kubectl run debug --image=nicolaka/netshoot -it --rm -- bash

    # DNS lookup
    nslookup my-service

    # Check endpoints
    kubectl get endpoints

    # Test port connectivity
    nc -zv my-service 80
    ```

    ## Service Mesh (Introduction)

    Advanced traffic management:
    - Istio, Linkerd, Consul
    - Traffic splitting
    - Circuit breaking
    - Observability

    Practice networking in the hands-on labs!
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

# Observability

    Learn to monitor, log, and debug applications running in Kubernetes clusters.

    ## Health Checks

    **Liveness Probes**
    - Is container alive?
    - Kubelet restarts failed containers
    - Use for detecting deadlocks

    **Readiness Probes**
    - Is container ready to serve traffic?
    - Removes pod from service endpoints if fails
    - Use during startup or temporary unavailability

    **Startup Probes**
    - Has application started?
    - Useful for slow-starting applications
    - Prevents liveness probe from interfering

    **Probe Types:**
    - **HTTP GET**: Check HTTP endpoint
    - **TCP Socket**: Check TCP connection
    - **Exec**: Execute command in container

    ## Logging

    **Container Logs:**
    ```bash
    # View logs
    kubectl logs pod-name

    # Follow logs
    kubectl logs -f pod-name

    # Previous container logs
    kubectl logs pod-name --previous

    # Specific container in pod
    kubectl logs pod-name -c container-name

    # All pods with label
    kubectl logs -l app=nginx
    ```

    **Logging Architecture:**
    - **Node-level**: Log files on nodes
    - **Cluster-level**: Centralized logging (ELK, Splunk, Loki)
    - **Application-level**: Direct to logging service

    ## Monitoring

    **Metrics Server:**
    - Resource usage metrics
    - `kubectl top nodes/pods`
    - Horizontal Pod Autoscaler input

    **Prometheus Stack:**
    - Metrics collection
    - Alerting rules
    - Grafana dashboards
    - Custom metrics

    ## Debugging

    **Describe Resources:**
    ```bash
    # Pod details and events
    kubectl describe pod pod-name

    # Node details
    kubectl describe node node-name
    ```

    **Execute Commands:**
    ```bash
    # Interactive shell
    kubectl exec -it pod-name -- /bin/bash

    # Run command
    kubectl exec pod-name -- ls /app
    ```

    **Port Forwarding:**
    ```bash
    # Forward local port to pod
    kubectl port-forward pod-name 8080:80

    # Forward to service
    kubectl port-forward service/my-service 8080:80
    ```

    **Copy Files:**
    ```bash
    # From pod to local
    kubectl cp pod-name:/path/to/file ./local-file

    # From local to pod
    kubectl cp ./local-file pod-name:/path/to/file
    ```

    ## Common Issues

    **CrashLoopBackOff:**
    - Application exits immediately
    - Check logs: `kubectl logs pod-name --previous`
    - Review resource limits
    - Verify liveness probe configuration

    **ImagePullBackOff:**
    - Cannot pull container image
    - Check image name and tag
    - Verify registry credentials
    - Check imagePullSecrets

    **Pending Pods:**
    - Insufficient resources
    - Node selector not matching
    - PVC not bound
    - Check events: `kubectl describe pod`

    Master debugging in the practical labs!
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

# Security & Operations

    Master security best practices and operational procedures for production Kubernetes clusters.

    ## Role-Based Access Control (RBAC)

    Control who can access what resources:

    **Roles & ClusterRoles:**
    - **Role**: Namespace-scoped permissions
    - **ClusterRole**: Cluster-wide permissions

    **RoleBindings & ClusterRoleBindings:**
    - Grant permissions to users/groups/service accounts
    - Bind roles to subjects

    **Example:**
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      name: pod-reader
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "list"]
    ```

    ## Security Contexts

    Define privilege and access control for pods/containers:

    **Pod Security Context:**
    ```yaml
    securityContext:
      runAsNonRoot: true
      runAsUser: 1000
      fsGroup: 2000
    ```

    **Container Security Context:**
    ```yaml
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
    ```

    ## Pod Security Standards

    - **Privileged**: Unrestricted
    - **Baseline**: Minimal restrictions
    - **Restricted**: Heavily restricted (production recommended)

    ## Admission Controllers

    Intercept and validate/mutate requests:
    - **PodSecurityPolicy** (deprecated)
    - **PodSecurity admission** (replacement)
    - **ResourceQuota**: Limit resource usage
    - **LimitRanger**: Set default limits
    - **MutatingWebhook**: Modify objects
    - **ValidatingWebhook**: Validate objects

    ## Network Security

    **Network Policies:**
    - Default deny all traffic
    - Explicitly allow required connections
    - Namespace isolation

    **TLS/SSL:**
    - Encrypt traffic between services
    - Use cert-manager for certificate management
    - Rotate certificates regularly

    ## Cluster Maintenance

    **Node Maintenance:**
    ```bash
    # Drain node (evict pods)
    kubectl drain node-name --ignore-daemonsets

    # Mark node unschedulable
    kubectl cordon node-name

    # Mark node schedulable
    kubectl uncordon node-name
    ```

    **Backup & Disaster Recovery:**
    - Backup etcd regularly
    - Store backups securely off-cluster
    - Test restore procedures
    - Document recovery steps

    **Etcd Backup:**
    ```bash
    # Backup etcd
    ETCDCTL_API=3 etcdctl snapshot save backup.db \
      --endpoints=https://127.0.0.1:2379 \
      --cacert=/etc/kubernetes/pki/etcd/ca.crt \
      --cert=/etc/kubernetes/pki/etcd/server.crt \
      --key=/etc/kubernetes/pki/etcd/server.key

    # Verify backup
    ETCDCTL_API=3 etcdctl snapshot status backup.db
    ```

    **Upgrade Strategies:**
    - Review release notes
    - Test in staging first
    - Upgrade control plane first
    - Then upgrade worker nodes
    - Use rolling updates for nodes

    ## Security Best Practices

    1. **Least Privilege Principle**
       - Minimal RBAC permissions
       - Non-root containers
       - Read-only filesystems

    2. **Image Security**
       - Scan images for vulnerabilities
       - Use trusted registries
       - Implement image pull policies
       - Verify image signatures

    3. **Secrets Management**
       - Encrypt secrets at rest
       - Use external secret managers (Vault)
       - Rotate secrets regularly
       - Limit secret access with RBAC

    4. **Audit Logging**
       - Enable audit logs
       - Monitor suspicious activities
       - Implement alerting
       - Regular security reviews

    5. **Resource Limits**
       - Set requests and limits
       - Prevent resource exhaustion
       - Use ResourceQuotas
       - Implement LimitRanges

    Master security and operations in the final labs!
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

# Kubernetes Fundamentals

    Welcome to the Kubernetes Complete Guide! This module introduces you to Kubernetes, the industry-standard container orchestration platform.

    ## What You'll Learn

    - Kubernetes architecture and core components
    - Control plane and worker node structure
    - Essential kubectl commands
    - How to interact with a Kubernetes cluster
    - Understanding namespaces and contexts

    ## Key Concepts

    **Control Plane Components:**
    - API Server: Central management entity
    - etcd: Distributed key-value store for cluster data
    - Scheduler: Assigns pods to nodes
    - Controller Manager: Manages cluster state

    **Worker Node Components:**
    - kubelet: Node agent that runs containers
    - kube-proxy: Network proxy for services
    - Container runtime: Docker, containerd, or CRI-O

    ## Why Kubernetes?

    Kubernetes provides:
    - Automated deployment and scaling
    - Self-healing capabilities
    - Service discovery and load balancing
    - Rolling updates and rollbacks
    - Resource optimization

    Let's dive into the hands-on labs to start working with Kubernetes!
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

# Deployments & ReplicaSets

    Learn how to manage application replicas and perform zero-downtime updates using Deployments and ReplicaSets.

    ## Deployments

    Deployments provide declarative updates for Pods and ReplicaSets. They handle:
    - Scaling applications up or down
    - Rolling updates with zero downtime
    - Rollback to previous versions
    - Pausing and resuming updates

    ## ReplicaSets

    ReplicaSets ensure a specified number of pod replicas are running at all times. Features:
    - Self-healing: Automatically replaces failed pods
    - Scaling: Adjusts replica count based on demand
    - Label selectors: Identifies which pods to manage

    ## Deployment Strategies

    **Rolling Update (Default)**
    - Gradually replaces old pods with new ones
    - Zero downtime
    - Rollback capability

    **Recreate**
    - Terminates all old pods before creating new ones
    - Brief downtime
    - Useful for incompatible updates

    ## Essential Commands

    ```bash
    # Create deployment
    kubectl create deployment nginx --image=nginx:1.25 --replicas=3

    # Scale deployment
    kubectl scale deployment nginx --replicas=5

    # Update image
    kubectl set image deployment/nginx nginx=nginx:1.26

    # Check rollout status
    kubectl rollout status deployment/nginx

    # View rollout history
    kubectl rollout history deployment/nginx

    # Rollback deployment
    kubectl rollout undo deployment/nginx
    ```

    Master these concepts through practical exercises!
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

# Services & Networking

    Learn how to expose your applications and enable communication between pods and external clients.

    ## Services

    Services provide stable networking endpoints for accessing pods. Types:

    **ClusterIP (Default)**
    - Internal-only access
    - Pods within cluster can communicate
    - Use for internal microservices

    **NodePort**
    - Exposes service on each node's IP
    - External access via <NodeIP>:<NodePort>
    - Useful for development/testing

    **LoadBalancer**
    - Creates external load balancer
    - Cloud provider integration required
    - Production external access

    **ExternalName**
    - Maps service to external DNS name
    - No proxy or forwarding

    ## DNS in Kubernetes

    Every service gets a DNS name:
    - Format: `<service-name>.<namespace>.svc.cluster.local`
    - Pods can access services by name
    - Automatic service discovery

    ## Network Policies

    Control traffic flow between pods:
    - Ingress rules: Incoming traffic
    - Egress rules: Outgoing traffic
    - Label-based selection
    - Namespace isolation

    ## Essential Commands

    ```bash
    # Create service
    kubectl expose deployment nginx --port=80 --type=LoadBalancer

    # List services
    kubectl get services
    kubectl get svc

    # Describe service
    kubectl describe service nginx

    # Test service connectivity
    kubectl run curl --image=curlimages/curl -it --rm -- curl http://nginx
    ```

    Practice service configuration in the labs!
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

# Configuration Management

    Learn to externalize configuration from application code using ConfigMaps and Secrets.

    ## ConfigMaps

    Store non-confidential configuration data as key-value pairs:
    - Application settings
    - Configuration files
    - Environment variables
    - Command-line arguments

    **Creation Methods:**
    - From literal values: `kubectl create configmap app-config --from-literal=KEY=VALUE`
    - From files: `kubectl create configmap app-config --from-file=config.properties`
    - From directories: `kubectl create configmap app-config --from-file=./config/`

    ## Secrets

    Store sensitive information securely:
    - Passwords and API keys
    - TLS certificates
    - Docker registry credentials
    - OAuth tokens

    **Secret Types:**
    - **Opaque**: Generic secret (default)
    - **kubernetes.io/tls**: TLS certificate
    - **kubernetes.io/dockerconfigjson**: Docker registry auth
    - **kubernetes.io/service-account-token**: Service account token

    ## Using Configuration

    **Environment Variables:**
    ```yaml
    env:
    - name: DATABASE_URL
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: db_url
    ```

    **Volume Mounts:**
    ```yaml
    volumes:
    - name: config
      configMap:
        name: app-config
    volumeMounts:
    - name: config
      mountPath: /etc/config
    ```

    ## Best Practices

    - Never hardcode sensitive data
    - Use Secrets for credentials
    - Use ConfigMaps for non-sensitive config
    - Enable encryption at rest for Secrets
    - Limit Secret access with RBAC

    Practice configuration management in the labs!
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

# Storage & Persistence

    Learn to provide persistent storage for stateful applications in Kubernetes.

    ## Volume Types

    **Ephemeral Volumes (Pod lifetime):**
    - **emptyDir**: Temporary storage, deleted when pod dies
    - **configMap/secret**: Configuration mounted as volumes

    **Persistent Volumes (Beyond pod lifetime):**
    - **hostPath**: Mount directory from node filesystem
    - **nfs**: Network File System mount
    - **cloud volumes**: AWS EBS, GCE PD, Azure Disk
    - **csi**: Container Storage Interface drivers

    ## Persistent Volume (PV)

    Cluster-level storage resource provisioned by admin:
    - Lifecycle independent of pods
    - Can be statically or dynamically provisioned
    - Has capacity, access modes, and reclaim policy

    **Access Modes:**
    - **ReadWriteOnce (RWO)**: Single node read-write
    - **ReadOnlyMany (ROX)**: Multiple nodes read-only
    - **ReadWriteMany (RWX)**: Multiple nodes read-write

    **Reclaim Policies:**
    - **Retain**: Manual reclamation
    - **Delete**: Automatic deletion
    - **Recycle**: Basic scrub (deprecated)

    ## Persistent Volume Claim (PVC)

    User request for storage:
    - Requests specific size and access modes
    - Binds to available PV
    - Can specify StorageClass

    ## Storage Classes

    Dynamic provisioning of storage:
    - Define storage provisioner (AWS, GCE, etc.)
    - Set parameters (type, IOPS, replication)
    - Enable automatic PV creation
    - Support for different storage tiers

    ## Essential Commands

    ```bash
    # List persistent volumes
    kubectl get pv

    # List persistent volume claims
    kubectl get pvc

    # Describe PVC
    kubectl describe pvc my-pvc

    # List storage classes
    kubectl get storageclass
    kubectl get sc
    ```

    Practice storage configuration in the labs!
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

# Advanced Workloads

    Learn specialized workload controllers for stateful applications, background tasks, and system services.

    ## StatefulSets

    For stateful applications requiring:
    - Stable network identities
    - Persistent storage
    - Ordered deployment and scaling
    - Ordered rolling updates

    **Use Cases:**
    - Databases (MySQL, PostgreSQL, MongoDB)
    - Distributed systems (Kafka, Zookeeper)
    - Any app requiring persistent identity

    **Features:**
    - Predictable pod names: `<statefulset-name>-<ordinal>`
    - Headless service for stable network identity
    - Ordered pod creation: 0, 1, 2, ...
    - Ordered pod deletion: 2, 1, 0, ...

    ## DaemonSets

    Ensures all (or specific) nodes run a copy of a pod:
    - Node monitoring agents
    - Log collectors
    - Storage daemons
    - Network plugins

    **Features:**
    - Automatically schedules pods on new nodes
    - Removes pods from nodes being decommissioned
    - Can target specific nodes using selectors

    ## Jobs

    Run batch tasks to completion:
    - One-time tasks
    - Parallel processing
    - Guaranteed completion
    - Retry on failure

    **Job Patterns:**
    - **Single completion**: Run task once
    - **Fixed completions**: Run N times
    - **Work queue**: Process items from queue

    ## CronJobs

    Scheduled recurring tasks:
    - Backups
    - Report generation
    - Data cleanup
    - Periodic checks

    **Schedule Format:**
    - Cron syntax: `* * * * *` (minute hour day month weekday)
    - Example: `0 2 * * *` (daily at 2 AM)

    ## Resource Management

    **Requests**: Minimum guaranteed resources
    ```yaml
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
    ```

    **Limits**: Maximum allowed resources
    ```yaml
    resources:
      limits:
        memory: "128Mi"
        cpu: "500m"
    ```

    **Quality of Service (QoS) Classes:**
    - **Guaranteed**: Requests = Limits
    - **Burstable**: Requests < Limits
    - **BestEffort**: No requests/limits set

    Practice these advanced patterns in the labs!
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

# Networking Deep Dive

    Master advanced networking concepts including Ingress, Network Policies, and troubleshooting techniques.

    ## Ingress

    HTTP/HTTPS routing to services:
    - Single external endpoint
    - Path-based routing
    - Virtual hosting
    - TLS/SSL termination

    **Ingress Controllers:**
    - NGINX Ingress Controller
    - Traefik
    - HAProxy
    - Cloud-specific (ALB, GCE)

    **Example Ingress:**
    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: my-ingress
    spec:
      rules:
      - host: app.example.com
        http:
          paths:
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: api-service
                port:
                  number: 80
    ```

    ## Network Policies

    Control traffic between pods:

    **Default Behavior:** All pods can communicate

    **With NetworkPolicy:**
    - Deny all, allow specific
    - Label-based selection
    - Namespace isolation
    - Ingress and egress rules

    **Example Policy:**
    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: allow-frontend
    spec:
      podSelector:
        matchLabels:
          role: backend
      ingress:
      - from:
        - podSelector:
            matchLabels:
              role: frontend
        ports:
        - protocol: TCP
          port: 8080
    ```

    ## Network Troubleshooting

    **Common Issues:**
    - Service not accessible
    - DNS resolution failures
    - Network policy blocking traffic
    - Ingress misconfiguration

    **Debugging Tools:**
    ```bash
    # Test service connectivity
    kubectl run debug --image=nicolaka/netshoot -it --rm -- bash

    # DNS lookup
    nslookup my-service

    # Check endpoints
    kubectl get endpoints

    # Test port connectivity
    nc -zv my-service 80
    ```

    ## Service Mesh (Introduction)

    Advanced traffic management:
    - Istio, Linkerd, Consul
    - Traffic splitting
    - Circuit breaking
    - Observability

    Practice networking in the hands-on labs!
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

# Observability

    Learn to monitor, log, and debug applications running in Kubernetes clusters.

    ## Health Checks

    **Liveness Probes**
    - Is container alive?
    - Kubelet restarts failed containers
    - Use for detecting deadlocks

    **Readiness Probes**
    - Is container ready to serve traffic?
    - Removes pod from service endpoints if fails
    - Use during startup or temporary unavailability

    **Startup Probes**
    - Has application started?
    - Useful for slow-starting applications
    - Prevents liveness probe from interfering

    **Probe Types:**
    - **HTTP GET**: Check HTTP endpoint
    - **TCP Socket**: Check TCP connection
    - **Exec**: Execute command in container

    ## Logging

    **Container Logs:**
    ```bash
    # View logs
    kubectl logs pod-name

    # Follow logs
    kubectl logs -f pod-name

    # Previous container logs
    kubectl logs pod-name --previous

    # Specific container in pod
    kubectl logs pod-name -c container-name

    # All pods with label
    kubectl logs -l app=nginx
    ```

    **Logging Architecture:**
    - **Node-level**: Log files on nodes
    - **Cluster-level**: Centralized logging (ELK, Splunk, Loki)
    - **Application-level**: Direct to logging service

    ## Monitoring

    **Metrics Server:**
    - Resource usage metrics
    - `kubectl top nodes/pods`
    - Horizontal Pod Autoscaler input

    **Prometheus Stack:**
    - Metrics collection
    - Alerting rules
    - Grafana dashboards
    - Custom metrics

    ## Debugging

    **Describe Resources:**
    ```bash
    # Pod details and events
    kubectl describe pod pod-name

    # Node details
    kubectl describe node node-name
    ```

    **Execute Commands:**
    ```bash
    # Interactive shell
    kubectl exec -it pod-name -- /bin/bash

    # Run command
    kubectl exec pod-name -- ls /app
    ```

    **Port Forwarding:**
    ```bash
    # Forward local port to pod
    kubectl port-forward pod-name 8080:80

    # Forward to service
    kubectl port-forward service/my-service 8080:80
    ```

    **Copy Files:**
    ```bash
    # From pod to local
    kubectl cp pod-name:/path/to/file ./local-file

    # From local to pod
    kubectl cp ./local-file pod-name:/path/to/file
    ```

    ## Common Issues

    **CrashLoopBackOff:**
    - Application exits immediately
    - Check logs: `kubectl logs pod-name --previous`
    - Review resource limits
    - Verify liveness probe configuration

    **ImagePullBackOff:**
    - Cannot pull container image
    - Check image name and tag
    - Verify registry credentials
    - Check imagePullSecrets

    **Pending Pods:**
    - Insufficient resources
    - Node selector not matching
    - PVC not bound
    - Check events: `kubectl describe pod`

    Master debugging in the practical labs!
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

# Kubernetes Fundamentals

    Welcome to the Kubernetes Complete Guide! This module introduces you to Kubernetes, the industry-standard container orchestration platform.

    ## What You'll Learn

    - Kubernetes architecture and core components
    - Control plane and worker node structure
    - Essential kubectl commands
    - How to interact with a Kubernetes cluster
    - Understanding namespaces and contexts

    ## Key Concepts

    **Control Plane Components:**
    - API Server: Central management entity
    - etcd: Distributed key-value store for cluster data
    - Scheduler: Assigns pods to nodes
    - Controller Manager: Manages cluster state

    **Worker Node Components:**
    - kubelet: Node agent that runs containers
    - kube-proxy: Network proxy for services
    - Container runtime: Docker, containerd, or CRI-O

    ## Why Kubernetes?

    Kubernetes provides:
    - Automated deployment and scaling
    - Self-healing capabilities
    - Service discovery and load balancing
    - Rolling updates and rollbacks
    - Resource optimization

    Let's dive into the hands-on labs to start working with Kubernetes!
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 18 microlessons for Kubernetes Complete Guide"

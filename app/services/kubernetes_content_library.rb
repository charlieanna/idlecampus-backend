class KubernetesContentLibrary
  # Comprehensive Kubernetes learning content with micro-lessons
  KUBERNETES_LESSONS = {
  'containers-101' => {
    title: 'Containers 101: What are Containers?',
    micro_lessons: [
      {
        id: 'containers_concept_intro',
        type: 'interactive',
        content: {
          title: 'Understanding Containers: The Foundation',
          explanation: %{
**What is a Container?**

A container is a lightweight, standalone, executable package that includes everything needed to run an application: code, runtime, system tools, libraries, and settings.

Think of a container like a **shipping container** - it works the same way whether it's on a ship, train, or truck. Similarly, a software container works the same way on your laptop, a server, or in the cloud.

**Key Characteristics:**
- **Isolated**: Each container runs in its own isolated environment
- **Portable**: Run anywhere (laptop, server, cloud) without changes
- **Lightweight**: Shares the host OS kernel (unlike VMs which need a full OS)
- **Consistent**: Same behavior every time, everywhere

**Containers vs Virtual Machines:**

| Containers | Virtual Machines |
|------------|------------------|
| Share host OS kernel | Each has its own OS |
| Start in seconds | Start in minutes |
| Use minimal resources | Use significant resources |
| Lightweight | Heavier |

**Why Containers Matter:**
- **"Works on my machine" problem solved**: Same container runs identically everywhere
- **Isolation**: Applications don't interfere with each other
- **Efficiency**: Multiple containers on one machine vs one app per VM
- **Scalability**: Easy to start/stop/scale containers

**Real-World Example:**
When you run `docker run nginx`, you're:
1. Downloading a container image (pre-built package)
2. Creating an isolated environment
3. Running the nginx web server inside that container
4. The container has everything it needs - no installation required!

**The Foundation for Kubernetes:**
Kubernetes doesn't run applications directly - it runs **containers**. Understanding containers is essential because:
- Kubernetes manages containers
- Pods wrap one or more containers
- Your applications run inside containers

Next, you'll learn how Kubernetes orchestrates these containers to run your applications at scale!
          }.strip
        },
        hints: [
          'Containers package applications with all dependencies',
          'Containers are lightweight and portable',
          'Kubernetes manages containers, not applications directly'
        ]
      }
    ]
  },
  'kubernetes-architecture-101' => {
    title: 'Kubernetes Architecture: The Big Picture',
    micro_lessons: [
      {
        id: 'k8s_architecture_overview',
        type: 'interactive',
        content: {
          title: 'How Kubernetes Works: Architecture Overview',
          explanation: %{
**What is Kubernetes?**

Kubernetes (K8s) is a container orchestration platform - it **automates** the deployment, scaling, and management of containerized applications.

Think of Kubernetes as a **smart traffic controller** for containers:
- Decides where containers should run
- Keeps them running (restarts if they crash)
- Scales them up or down based on demand
- Manages networking between them
- Handles updates without downtime

**The Kubernetes Cluster:**

A **cluster** is a set of machines (nodes) working together:

```
┌─────────────────────────────────────────────┐
│         KUBERNETES CLUSTER                  │
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │      CONTROL PLANE (The Brain)       │  │
│  │  • API Server                        │  │
│  │  • etcd (Database)                   │  │
│  │  • Scheduler                         │  │
│  │  • Controller Manager                │  │
│  └──────────────────────────────────────┘  │
│                                             │
│  ┌──────────────┐  ┌──────────────┐        │
│  │   NODE 1     │  │   NODE 2     │        │
│  │  (Worker)    │  │  (Worker)    │        │
│  │              │  │              │        │
│  │  Pods run    │  │  Pods run    │        │
│  │  here!       │  │  here!       │        │
│  └──────────────┘  └──────────────┘        │
└─────────────────────────────────────────────┘
```

**Control Plane (The Brain):**
- **API Server**: Front door to Kubernetes - you send commands here
- **etcd**: Database storing cluster state (what's running, where, etc.)
- **Scheduler**: Decides which node runs each pod
- **Controller Manager**: Watches for changes and keeps things in desired state

**Worker Nodes (The Workers):**
- **kubelet**: Agent that runs on each node, manages pods on that node
- **kube-proxy**: Handles networking (routes traffic to pods)
- **Container Runtime**: Actually runs containers (Docker, containerd, etc.)

**The Flow:**
1. You tell Kubernetes: "I want 3 copies of my web app"
2. API Server receives your request
3. Scheduler decides which nodes to run them on
4. kubelet on each node starts the containers
5. Controllers watch to ensure 3 copies are always running

**Key Insight:**
You don't manage individual containers. You tell Kubernetes **what you want** (desired state), and it figures out **how to make it happen** (actual state).

Next, you'll learn the core building blocks: Pods, Nodes, and how they connect!
          }.strip
        },
        hints: [
          'Kubernetes automates container management',
          'Control plane is the brain, nodes are the workers',
          'You declare what you want, Kubernetes makes it happen'
        ]
      }
    ]
  },
  'kubernetes-concepts-101' => {
    title: 'Core Concepts: How Everything Connects',
    micro_lessons: [
      {
        id: 'k8s_core_concepts',
        type: 'interactive',
        content: {
          title: 'The Building Blocks: Containers → Pods → Nodes → Clusters',
          explanation: %{
**The Hierarchy: How Everything Fits Together**

Understanding the relationships is crucial for Kubernetes mastery:

```
CLUSTER (All machines together)
    │
    ├── NODE 1 (Physical or virtual machine)
    │     │
    │     └── POD 1 (Smallest deployable unit)
    │           │
    │           ├── CONTAINER 1 (Your app)
    │           └── CONTAINER 2 (Sidecar, e.g., log collector)
    │
    └── NODE 2 (Another machine)
          │
          └── POD 2
                └── CONTAINER 1 (Another copy of your app)
```

**1. Container (The App Itself)**
- Your application code running
- Examples: nginx web server, Node.js app, Python script
- **One container = one process** (typically)

**2. Pod (One or More Containers)**
- **Smallest unit Kubernetes manages**
- Can contain 1 or more tightly coupled containers
- Containers in a pod share:
  - **IP address** (same network namespace)
  - **Storage volumes** (shared filesystem)
  - **localhost** (can talk to each other via localhost)
- Think: "Pods are like apartments for containers - they share the same address and utilities"

**Why Pods?**
- **Sidecar pattern**: App container + log shipper container in same pod
- **Multi-container apps**: Frontend + backend in same pod (though usually separate)
- **Shared storage**: Containers can share files via volumes

**3. Node (A Machine)**
- Physical or virtual machine that runs pods
- Contains:
  - **kubelet**: Kubernetes agent managing pods on this node
  - **kube-proxy**: Network routing
  - **Container runtime**: Runs the actual containers
- Nodes can be in different datacenters, clouds, etc.

**4. Cluster (All Nodes Together)**
- Collection of nodes working together
- Managed by the control plane
- Provides redundancy and scalability

**Key Relationships:**

**Containers → Pods:**
- Containers are **inside** pods
- A pod can have multiple containers that work together
- Containers in same pod can communicate via localhost

**Pods → Nodes:**
- Pods run **on** nodes
- Kubernetes scheduler decides which node runs which pod
- A node can run many pods

**Nodes → Cluster:**
- Nodes are **part of** a cluster
- Cluster provides abstraction - you don't care which node runs your pod

**Real-World Analogy:**
- **Container** = A single apartment unit
- **Pod** = An apartment building (containers that share utilities)
- **Node** = A city block (where buildings are located)
- **Cluster** = The entire city (all blocks working together)

**Why This Matters:**
Understanding these relationships helps you:
- Debug issues (is it the container, pod, or node?)
- Design applications (should these containers be in same pod?)
- Scale effectively (scale pods, not containers)
- Understand networking (how pods communicate)

Now you're ready to learn about Pods in detail!
          }.strip
        },
        hints: [
          'Pods are the smallest unit Kubernetes manages',
          'Containers run inside pods',
          'Pods run on nodes, nodes are in clusters',
          'Containers in same pod share network and storage'
        ]
      }
    ]
  },
  'pods-101' => {
    title: 'Pods 101: What is a Pod?',
    micro_lessons: [
      {
        id: 'pods_concept_intro',
        type: 'interactive',
        content: {
          title: 'Pods 101: Core building block',
          explanation: %{
A Pod is the smallest deployable unit in Kubernetes. It encapsulates one or more tightly coupled containers that share the same network namespace and storage volumes.

Why Pods?
- Co-locate tightly coupled containers (app + sidecar)
- Shared localhost networking and volumes
- Unit of scheduling, readiness, and liveness

Key concepts:
- One or more containers per pod
- One IP per pod, shared by all containers
- Labels select pods for Services and Deployments

You’ll first learn how to create a single Pod, then observe it, then expose it with a Service, and only later move to higher-level controllers (ReplicaSets/Deployments).
          }.strip
        },
        hints: [
          'Pods are the smallest deployable units in Kubernetes',
          'Pods share IP/network and volumes across their containers',
          'Use labels to connect Pods with Services/Deployments'
        ]
      }
    ]
  },
  'kubectl run' => {
    title: 'Create a single Pod (kubectl run)',
    micro_lessons: [
      {
        id: 'run_pod_basic',
        type: 'interactive',
        content: {
          title: 'Create your first Pod',
          explanation: %{
`kubectl run` creates a single Pod. This is ideal for learning pod lifecycle before using controllers.

Basic syntax:
`kubectl run <name> --image=<image> --restart=Never`

Notes:
- `--restart=Never` ensures a Pod (not a Deployment)
- Use labels to connect later with Services
          }.strip,
          examples: [
            'kubectl run pod-demo --image=nginx:1.25 --restart=Never',
            'kubectl run api --image=busybox --restart=Never --command -- sh -c "sleep 3600"'
          ],
          task: 'Execute: kubectl run pod-demo --image=nginx:1.25 --restart=Never',
          expected_command: 'kubectl run pod-demo --image=nginx:1.25 --restart=Never'
        },
        validation: {
          type: 'command_match',
          base_command: 'kubectl run',
          must_contain: ['--image', '--restart=Never'],
          requires_argument: true
        },
        hints: [
          'Use kubectl run <name> --image=<image> --restart=Never',
          'Without --restart=Never you create a Deployment in some versions',
          'Try nginx:1.25 for a quick web pod'
        ]
      }
    ]
  },
  'services-101' => {
    title: 'Services 101: Stable networking',
    micro_lessons: [
      {
        id: 'services_concept_intro',
        type: 'interactive',
        content: {
          title: 'Services 101: Stable access to Pods',
          explanation: %{
Pods are ephemeral; Services provide a stable virtual IP and DNS to reach matching Pods via label selectors.

Service types:
- ClusterIP (default): internal only
- NodePort: nodeIP:nodePort external access
- LoadBalancer: cloud LB + external IP

Selectors match pod labels to create Endpoints; if a Service has no Endpoints, check labels.
          }.strip
        },
        hints: [
          'Services target Pods using label selectors',
          'ClusterIP is default; NodePort/LoadBalancer provide external access',
          'No endpoints? Check selectors vs pod labels'
        ]
      }
    ]
  },
  'controllers-and-replicasets' => {
    title: 'Controllers: ReplicaSets and Deployments',
    micro_lessons: [
      {
        id: 'controllers_concept_intro',
        type: 'interactive',
        content: {
          title: 'From single Pods to controlled Pods',
          explanation: %{
ReplicaSets maintain a desired number of identical Pods. Deployments manage ReplicaSets to add rollout/rollback and strategy.

Why controllers?
- Ensure desired replicas
- Enable rolling updates and rollbacks
- Decouple declarative spec from runtime state
          }.strip
        }
      }
    ]
  },
  'rollouts-and-rollback' => {
    title: 'Rollouts and Rollbacks',
    micro_lessons: [
      {
        id: 'rollout_concepts',
        type: 'interactive',
        content: {
          title: 'Understand rollouts',
          explanation: %{
Deployments support rolling updates with `kubectl rollout status` and safe rollback with `kubectl rollout undo`.

Typical flow:
1) Update image (kubectl set image)
2) Watch rollout status
3) If issues, rollback to previous revision
          }.strip,
          examples: [
            'kubectl set image deploy/web nginx=nginx:1.25',
            'kubectl rollout status deploy/web',
            'kubectl rollout undo deploy/web'
          ]
        }
      }
    ]
  },
  'probes-101' => {
    title: 'Probes 101: Liveness and Readiness',
    micro_lessons: [
      {
        id: 'probes_concepts',
        type: 'interactive',
        content: {
          title: 'Health checks in Kubernetes',
          explanation: %{
Probes let Kubernetes know if a container is ready to receive traffic or needs a restart.
- Readiness: when to add/remove Pod from Service
- Liveness: when to restart a stuck container
- Startup: give apps time to initialize
          }.strip
        }
      }
    ]
  },
  'configmaps-secrets-101' => {
    title: 'ConfigMaps and Secrets 101',
    micro_lessons: [
      {
        id: 'config_concepts',
        type: 'interactive',
        content: {
          title: 'Externalize configuration',
          explanation: %{
Use ConfigMaps for non-sensitive config and Secrets for sensitive data. Mount as env vars or volumes; reference with valueFrom.
          }.strip
        }
      }
    ]
  },
  'jobs-cronjobs-101' => {
    title: 'Jobs and CronJobs 101',
    micro_lessons: [
      {
        id: 'jobs_concepts',
        type: 'interactive',
        content: {
          title: 'Batch and scheduled workloads',
          explanation: %{
Jobs run to completion; CronJobs schedule Jobs periodically. Useful for batch tasks, reports, and maintenance.
          }.strip
        }
      }
    ]
  },
  'kubectl get pods' => {
      title: 'Viewing Running Pods',
      micro_lessons: [
        {
          id: 'pods_base',
          type: 'interactive',
          content: {
            title: 'Understanding kubectl get pods',
            explanation: %{
The `kubectl get pods` command is your window into the Kubernetes cluster. It shows all pods in your current namespace.

**Why kubectl get pods?**
- Monitor application health at a glance
- Identify problematic pods (CrashLoopBackOff, Pending)
- Get pod names for troubleshooting
- Verify deployments are working

**How it works:**
Kubectl queries the Kubernetes API server for pod resources in your namespace and displays their current state.

**Key information shown:**
- NAME: Unique pod identifier
- READY: Containers ready vs total (1/1 means all healthy)
- STATUS: Running, Pending, CrashLoopBackOff, etc.
- RESTARTS: How many times containers have restarted
- AGE: Time since pod creation

**Simplest form:**
`kubectl get pods`

**Now try it yourself below!**
            }.strip,
            examples: [
              'kubectl get pods',
              'kubectl get pod',
              'kubectl get po'
            ],
            task: 'Execute: kubectl get pods',
            expected_command: 'kubectl get pods'
          },
          validation: {
            type: 'command_match',
            base_command: ['kubectl get pods', 'kubectl get pod', 'kubectl get po'],
            no_extra_flags: true
          },
          hints: [
            'Type: kubectl get pods',
            'You can also use shortcuts: kubectl get po',
            'No flags needed for basic listing'
          ]
        },
        {
          id: 'pods_all_namespaces',
          type: 'interactive',
          content: {
            title: 'The -A Flag: All Namespaces',
            explanation: %{
By default, kubectl only shows pods in your current namespace (usually "default").

**The -A flag (all namespaces):**
- Shows pods across ALL namespaces
- Useful for cluster-wide monitoring
- Reveals system pods in kube-system
- Helps find "lost" pods in other namespaces

**Usage:**
`kubectl get pods -A`

This is equivalent to `--all-namespaces`

**Why this matters:**
Many issues are caused by pods you can't see because they're in different namespaces!

**Try it now - see how many more pods appear!**
            }.strip,
            examples: [
              'kubectl get pods -A',
              'kubectl get pods --all-namespaces'
            ],
            task: 'Execute: kubectl get pods -A',
            expected_command: 'kubectl get pods -A'
          },
          validation: {
            type: 'command_match',
            base_command: ['kubectl get pods', 'kubectl get pod', 'kubectl get po'],
            required_flags: ['-A']
          },
          hints: [
            'Add -A flag: kubectl get pods -A',
            'This shows pods from all namespaces',
            'Alternative: kubectl get pods --all-namespaces'
          ]
        },
        {
          id: 'pods_wide',
          type: 'interactive',
          content: {
            title: 'The -o wide Flag: More Details',
            explanation: %{
The `-o wide` flag shows additional crucial information.

**Extra columns with -o wide:**
- IP: Pod's internal IP address
- NODE: Which node the pod is running on
- NOMINATED NODE: For pod scheduling
- READINESS GATES: Advanced health checks

**Usage:**
`kubectl get pods -o wide`

**When to use:**
- Debugging networking issues (need the IP)
- Checking pod distribution across nodes
- Verifying pod placement

**Pro tip:** Combine with -A for maximum visibility!
            }.strip,
            examples: [
              'kubectl get pods -o wide',
              'kubectl get pods -A -o wide'
            ],
            task: 'Execute: kubectl get pods -o wide',
            expected_command: 'kubectl get pods -o wide'
          },
          validation: {
            type: 'command_match',
            base_command: ['kubectl get pods', 'kubectl get pod', 'kubectl get po'],
            required_flags: ['-o wide']
          },
          hints: [
            'Add -o wide for extra columns',
            'Example: kubectl get pods -o wide',
            'Shows IP addresses and node placement'
          ]
        },
        {
          id: 'pods_watch',
          type: 'interactive',
          content: {
            title: 'The --watch Flag: Real-time Updates',
            explanation: %{
The `--watch` flag turns kubectl into a real-time monitor.

**What --watch does:**
- Continuously updates the display
- Shows changes as they happen
- Perfect for watching deployments
- Press Ctrl+C to exit

**Usage:**
`kubectl get pods --watch`

**When to use:**
- During deployments to see pods starting
- Monitoring troubled pods
- Watching for crashes or restarts
- Observing scaling operations

**Try it - you'll see live updates! (Ctrl+C to stop)**
            }.strip,
            examples: [
              'kubectl get pods --watch',
              'kubectl get pods -w'
            ],
            task: 'Execute: kubectl get pods --watch',
            expected_command: 'kubectl get pods --watch'
          },
          validation: {
            type: 'command_match',
            base_command: ['kubectl get pods', 'kubectl get pod', 'kubectl get po'],
            required_flags: ['--watch']
          },
          hints: [
            'Add --watch to see real-time updates',
            'Short form: kubectl get pods -w',
            'Press Ctrl+C to stop watching'
          ]
        }
      ],
      explanation: %{
Pods are the smallest deployable units in Kubernetes - they contain one or more containers. The `kubectl get pods` command shows you all pods in your current namespace.

**Why use kubectl get pods?**
- Monitor which pods are running
- Check pod status and health
- Find pod names for management tasks
- Troubleshoot deployment issues

**Understanding the output:**
- NAME: Unique identifier for the pod
- READY: Number of containers ready vs total (e.g., 1/1)
- STATUS: Running, Pending, CrashLoopBackOff, etc.
- RESTARTS: How many times containers have restarted
- AGE: How long the pod has been running
      }.strip,
      examples: [
        'kubectl get pods',
        'kubectl get pods -A  # All namespaces',
        'kubectl get pods -o wide  # More details',
        'kubectl get pods --watch  # Watch for changes'
      ],
      command_to_learn: 'kubectl get pods',
      practice_prompt: 'List all pods in all namespaces with more details',
      practice_exercise: {
        problem: 'List all pods across all namespaces',
        solution_command: 'kubectl get pods -A',
        validation: {
          type: 'command_match',
          required_flags: ['-A'],
          base_command: 'kubectl get pods'
        },
        hints: [
          'Use -A flag to see all namespaces',
          'By default, kubectl only shows current namespace',
          'The command is: kubectl get pods -A'
        ]
      }
    },
    
    'kubectl create deployment' => {
      title: 'Creating Deployments',
      micro_lessons: [
        {
          id: 'deployment_base',
          type: 'interactive',
          content: {
            title: 'Create Your First Deployment',
            explanation: %{
A Deployment manages a set of identical pods, ensuring they're running and healthy.

**Why Deployments?**
- Automatic pod replacement if they fail
- Easy scaling (increase/decrease replicas)
- Rolling updates with zero downtime
- Rollback to previous versions

**Basic syntax:**
`kubectl create deployment <name> --image=<image>`

**What happens:**
1. Creates a Deployment resource
2. Deployment creates a ReplicaSet
3. ReplicaSet creates the Pod(s)
4. Kubernetes ensures desired state

**Try creating a simple nginx deployment!**
            }.strip,
            examples: [
              'kubectl create deployment nginx --image=nginx',
              'kubectl create deployment web --image=nginx:latest'
            ],
            task: 'Execute: kubectl create deployment nginx --image=nginx',
            expected_command: 'kubectl create deployment nginx --image=nginx'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl create deployment',
            required_flags: ['--image=nginx'],
            requires_argument: true
          },
          hints: [
            'Use: kubectl create deployment nginx --image=nginx',
            'The name comes before --image flag',
            'Image can be any Docker image'
          ]
        },
        {
          id: 'deployment_replicas',
          type: 'interactive',
          content: {
            title: 'Set Replicas During Creation',
            explanation: %{
Control how many pod instances to run with `--replicas`.

**Why multiple replicas?**
- High availability (if one fails, others continue)
- Load distribution
- Zero-downtime deployments
- Handle more traffic

**Usage:**
`kubectl create deployment <name> --image=<image> --replicas=3`

**Default behavior:**
Without --replicas, Kubernetes creates 1 pod.

**Best practice:**
Always run at least 2 replicas in production for availability!
            }.strip,
            examples: [
              'kubectl create deployment web --image=nginx --replicas=3',
              'kubectl create deployment api --image=node:14 --replicas=5'
            ],
            task: 'Execute: kubectl create deployment web --image=nginx --replicas=3',
            expected_command: 'kubectl create deployment web --image=nginx --replicas=3'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl create deployment',
            required_flags: ['--image=nginx', '--replicas=3']
          },
          hints: [
            'Add --replicas=3 to the command',
            'Full command: kubectl create deployment web --image=nginx --replicas=3',
            'This creates 3 identical pods'
          ]
        },
        {
          id: 'deployment_port',
          type: 'interactive',
          content: {
            title: 'Expose Port During Creation',
            explanation: %{
The `--port` flag documents which port your container uses.

**Important:** This doesn't expose the port externally!
It just adds port information to the deployment.

**Usage:**
`kubectl create deployment web --image=nginx --port=80`

**What it does:**
- Adds containerPort to the pod spec
- Documents the port for other resources
- Required info for creating services later

**Next steps after:**
Use `kubectl expose` to actually make it accessible!
            }.strip,
            examples: [
              'kubectl create deployment web --image=nginx --port=80',
              'kubectl create deployment api --image=node:14 --port=3000'
            ],
            task: 'Execute: kubectl create deployment web --image=nginx --port=80',
            expected_command: 'kubectl create deployment web --image=nginx --port=80'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl create deployment',
            required_flags: ['--image=nginx', '--port=80']
          },
          hints: [
            'Add --port=80 to document the container port',
            'This is nginx default port',
            'Command: kubectl create deployment web --image=nginx --port=80'
          ]
        }
      ],
      explanation: %{
A Deployment manages a set of identical pods, ensuring they're running and healthy. It's the primary way to run applications in Kubernetes.

**Why use deployments?**
- Automatic pod replacement if they fail
- Easy scaling (increase/decrease replicas)
- Rolling updates with zero downtime
- Rollback to previous versions if needed

**How it works:**
When you create a deployment, Kubernetes creates a ReplicaSet which creates the pods. The deployment continuously monitors and maintains the desired state.
      }.strip,
      examples: [
        'kubectl create deployment nginx --image=nginx',
        'kubectl create deployment myapp --image=myapp:v1 --replicas=3',
        'kubectl create deployment db --image=postgres:13',
        'kubectl create deployment api --image=node:14'
      ],
      command_to_learn: 'kubectl create deployment',
      practice_prompt: 'Create a deployment named "web" using the nginx image',
      practice_exercise: {
        problem: 'Create a deployment named "web" using the nginx image',
        solution_command: 'kubectl create deployment web --image=nginx',
        validation: {
          type: 'command_match',
          base_command: 'kubectl create deployment',
          required_flags: ['--image=nginx'],
          requires_argument: true
        },
        hints: [
          'Use kubectl create deployment followed by name',
          'Specify image with --image=nginx',
          'Command: kubectl create deployment web --image=nginx'
        ]
      }
    },
    
    'kubectl get services' => {
      title: 'Viewing Services',
      micro_lessons: [
        {
          id: 'services_base',
          type: 'interactive',
          content: {
            title: 'List Kubernetes Services',
            explanation: %{
Services provide stable networking for pods. While pods come and go, services remain constant.

**Why Services matter:**
- Pods are ephemeral (temporary)
- Pod IPs change when recreated
- Services provide stable endpoints
- Enable load balancing

**What you'll see:**
- NAME: Service name
- TYPE: ClusterIP, NodePort, LoadBalancer
- CLUSTER-IP: Internal IP
- EXTERNAL-IP: External access (if any)
- PORT(S): Port mappings
- AGE: How long it's existed

**Try listing services now!**
            }.strip,
            examples: [
              'kubectl get services',
              'kubectl get svc',
              'kubectl get service'
            ],
            task: 'Execute: kubectl get services',
            expected_command: 'kubectl get services'
          },
          validation: {
            type: 'command_match',
            base_command: ['kubectl get services', 'kubectl get svc', 'kubectl get service'],
            no_extra_flags: true
          },
          hints: [
            'Type: kubectl get services',
            'Short form: kubectl get svc',
            'Shows all services in current namespace'
          ]
        },
        {
          id: 'services_all_namespaces',
          type: 'interactive',
          content: {
            title: 'Services Across All Namespaces',
            explanation: %{
See services in all namespaces with -A flag.

**System services you'll discover:**
- kubernetes (API server) in default
- kube-dns in kube-system
- metrics-server in kube-system
- Your app services in various namespaces

**Usage:**
`kubectl get svc -A`

**Why check all namespaces:**
- Find DNS service (crucial for pod communication)
- Locate ingress controllers
- Discover monitoring services
            }.strip,
            examples: [
              'kubectl get svc -A',
              'kubectl get services --all-namespaces'
            ],
            task: 'Execute: kubectl get svc -A',
            expected_command: 'kubectl get svc -A'
          },
          validation: {
            type: 'command_match',
            base_command: ['kubectl get services', 'kubectl get svc'],
            required_flags: ['-A']
          },
          hints: [
            'Add -A to see all namespaces',
            'Short form: kubectl get svc -A',
            'Shows system services too'
          ]
        },
        {
          id: 'services_wide',
          type: 'interactive',
          content: {
            title: 'Detailed Service Information',
            explanation: %{
The `-o wide` flag reveals additional service details.

**Extra information shown:**
- SELECTOR: Which pods this service routes to
- Additional network details

**Usage:**
`kubectl get svc -o wide`

**Why selectors matter:**
Services find pods using label selectors. If your service has no endpoints, check if the selector matches your pod labels!

**Common troubleshooting:**
Service not working? Check if selector matches pod labels!
            }.strip,
            examples: [
              'kubectl get svc -o wide',
              'kubectl get services -o wide'
            ],
            task: 'Execute: kubectl get svc -o wide',
            expected_command: 'kubectl get svc -o wide'
          },
          validation: {
            type: 'command_match',
            base_command: ['kubectl get services', 'kubectl get svc'],
            required_flags: ['-o wide']
          },
          hints: [
            'Add -o wide for extra details',
            'Shows the selector used to find pods',
            'Command: kubectl get svc -o wide'
          ]
        }
      ],
      explanation: %{
Services provide stable networking for pods. While pods are ephemeral and their IPs change, services give you a consistent way to access them.

**Why use services?**
- Stable DNS name and IP for accessing pods
- Load balancing across multiple pods
- Expose applications to outside the cluster
- Service discovery within the cluster

**Service types:**
- ClusterIP: Internal only (default)
- NodePort: Accessible from outside via node IP
- LoadBalancer: Cloud load balancer
- ExternalName: DNS alias to external service
      }.strip,
      examples: [
        'kubectl get services',
        'kubectl get svc  # Short form',
        'kubectl get svc -A',
        'kubectl get svc -o wide'
      ],
      command_to_learn: 'kubectl get services',
      practice_prompt: 'List all services in the current namespace',
      practice_exercise: {
        problem: 'List all services in the current namespace',
        solution_command: 'kubectl get services',
        validation: {
          type: 'command_match',
          base_command: 'kubectl get services',
          accepts_flags: true
        },
        hints: [
          'The command is simply: kubectl get services',
          'You can also use the short form: kubectl get svc',
          'No flags are required for this exercise'
        ]
      }
    },
    
    'kubectl expose' => {
      title: 'Exposing Applications',
      micro_lessons: [
        {
          id: 'expose_base',
          type: 'interactive',
          content: {
            title: 'Create a Basic Service',
            explanation: %{
`kubectl expose` creates a Service for an existing deployment or pod.

**What it does:**
- Creates a stable endpoint
- Enables network access to your pods
- Sets up load balancing
- Creates DNS entry

**Basic syntax:**
`kubectl expose deployment <name> --port=<port>`

**The --port flag:**
The port the service will listen on.

**DNS name created:**
`<service-name>.<namespace>.svc.cluster.local`

**Let's expose a deployment!**
            }.strip,
            examples: [
              'kubectl expose deployment nginx --port=80',
              'kubectl expose deployment web --port=8080'
            ],
            task: 'Execute: kubectl expose deployment nginx --port=80',
            expected_command: 'kubectl expose deployment nginx --port=80'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl expose deployment',
            required_flags: ['--port=80']
          },
          hints: [
            'Use: kubectl expose deployment nginx --port=80',
            'The port is where the service listens',
            'This creates a ClusterIP service by default'
          ]
        },
        {
          id: 'expose_nodeport',
          type: 'interactive',
          content: {
            title: 'NodePort: External Access',
            explanation: %{
NodePort services are accessible from outside the cluster.

**How NodePort works:**
- Opens a port on every node (30000-32767)
- Traffic to any node:port reaches your service
- Works without cloud load balancers

**Usage:**
`kubectl expose deployment <name> --type=NodePort --port=<port>`

**Access pattern:**
`<any-node-ip>:<nodeport>`

**When to use:**
- Development and testing
- On-premises clusters
- When LoadBalancer isn't available
            }.strip,
            examples: [
              'kubectl expose deployment web --type=NodePort --port=80',
              'kubectl expose deployment api --type=NodePort --port=3000'
            ],
            task: 'Execute: kubectl expose deployment web --type=NodePort --port=80',
            expected_command: 'kubectl expose deployment web --type=NodePort --port=80'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl expose deployment',
            required_flags: ['--type=NodePort', '--port=80']
          },
          hints: [
            'Add --type=NodePort for external access',
            'Port 80 is the service port',
            'Node port will be auto-assigned (30000-32767)'
          ]
        },
        {
          id: 'expose_target_port',
          type: 'interactive',
          content: {
            title: 'Target Port: Container Port Mapping',
            explanation: %{
Sometimes service port and container port differ. Use --target-port!

**Port vs Target Port:**
- --port: Port the service listens on
- --target-port: Port the container listens on

**Example scenario:**
Service on port 80, but container runs on 8080

**Usage:**
`kubectl expose deployment app --port=80 --target-port=8080`

**Common patterns:**
- Service port 80 → Container port 8080
- Service port 443 → Container port 8443
            }.strip,
            examples: [
              'kubectl expose deployment app --port=80 --target-port=8080',
              'kubectl expose deployment api --port=443 --target-port=3000'
            ],
            task: 'Execute: kubectl expose deployment app --port=80 --target-port=8080',
            expected_command: 'kubectl expose deployment app --port=80 --target-port=8080'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl expose deployment',
            required_flags: ['--port=80', '--target-port=8080']
          },
          hints: [
            'Use both --port and --target-port',
            '--port=80 for service, --target-port=8080 for container',
            'This maps service:80 to container:8080'
          ]
        }
      ],
      explanation: %{
The `kubectl expose` command creates a Service for an existing deployment, making your application accessible.

**Why expose deployments?**
- Make your application accessible to users
- Enable communication between microservices
- Create load balancers for traffic distribution
- Set up DNS names for service discovery

**Common patterns:**
Use ClusterIP for internal services, NodePort for development/testing, and LoadBalancer for production external access.
      }.strip,
      examples: [
        'kubectl expose deployment nginx --port=80',
        'kubectl expose deployment web --type=NodePort --port=8080',
        'kubectl expose deployment api --type=LoadBalancer --port=3000',
        'kubectl expose pod my-pod --port=80 --name=my-service'
      ],
      command_to_learn: 'kubectl expose',
      practice_prompt: 'Expose a deployment named "nginx" on port 80',
      practice_exercise: {
        problem: 'Expose the nginx deployment on port 80',
        solution_command: 'kubectl expose deployment nginx --port=80',
        validation: {
          type: 'command_match',
          base_command: 'kubectl expose deployment',
          required_flags: ['--port=80'],
          requires_argument: true
        },
        hints: [
          'Use kubectl expose deployment followed by name',
          'Specify port with --port=80',
          'Command: kubectl expose deployment nginx --port=80'
        ]
      }
    },
    
    'kubectl scale' => {
      title: 'Scaling Applications',
      micro_lessons: [
        {
          id: 'scale_up',
          type: 'interactive',
          content: {
            title: 'Scale Up Your Application',
            explanation: %{
Scaling changes the number of pod replicas in a deployment.

**Why scale up?**
- Handle more traffic
- Improve availability
- Distribute load
- Prepare for maintenance

**Syntax:**
`kubectl scale deployment <name> --replicas=<number>`

**What happens:**
- Deployment updates desired replicas
- ReplicaSet creates new pods
- Service automatically includes new pods

**Watch it happen:**
Use `kubectl get pods -w` in another terminal!

**Let's scale to 3 replicas!**
            }.strip,
            examples: [
              'kubectl scale deployment nginx --replicas=3',
              'kubectl scale deployment web --replicas=5'
            ],
            task: 'Execute: kubectl scale deployment web --replicas=3',
            expected_command: 'kubectl scale deployment web --replicas=3'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl scale deployment',
            required_flags: ['--replicas=3']
          },
          hints: [
            'Use: kubectl scale deployment web --replicas=3',
            'This scales to exactly 3 pods',
            'Kubernetes will create or delete pods as needed'
          ]
        },
        {
          id: 'scale_down',
          type: 'interactive',
          content: {
            title: 'Scale Down to Save Resources',
            explanation: %{
Scaling down reduces pod count to save resources.

**Why scale down?**
- Reduce costs
- Low traffic periods
- Development environments
- Maintenance windows

**Scale to zero:**
`kubectl scale deployment <name> --replicas=0`
This stops all pods but keeps the deployment!

**Graceful shutdown:**
Kubernetes drains connections before terminating pods.

**Let's scale down to 1 replica.**
            }.strip,
            examples: [
              'kubectl scale deployment web --replicas=1',
              'kubectl scale deployment test --replicas=0'
            ],
            task: 'Execute: kubectl scale deployment web --replicas=1',
            expected_command: 'kubectl scale deployment web --replicas=1'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl scale deployment',
            required_flags: ['--replicas=1']
          },
          hints: [
            'Scale down to 1: --replicas=1',
            'Command: kubectl scale deployment web --replicas=1',
            'This reduces to a single pod'
          ]
        },
        {
          id: 'scale_conditional',
          type: 'interactive',
          content: {
            title: 'Conditional Scaling with --current-replicas',
            explanation: %{
Scale only if current replica count matches expected.

**Why conditional scaling?**
- Avoid race conditions
- Ensure expected state
- Safe for automation
- Prevent accidental overwrites

**Syntax:**
`kubectl scale deployment <name> --current-replicas=2 --replicas=4`

**What it does:**
Only scales from 2→4 if currently at 2. Otherwise, fails safely.

**Use case:**
Automated scaling scripts that shouldn't override manual interventions.
            }.strip,
            examples: [
              'kubectl scale deployment web --current-replicas=2 --replicas=4'
            ],
            task: 'Execute: kubectl scale deployment web --current-replicas=1 --replicas=3',
            expected_command: 'kubectl scale deployment web --current-replicas=1 --replicas=3'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl scale deployment',
            required_flags: ['--current-replicas=1', '--replicas=3']
          },
          hints: [
            'Use both --current-replicas and --replicas',
            'Only scales if current count matches',
            'Fails safely if current count is different'
          ]
        }
      ],
      explanation: %{
The `kubectl scale` command changes the number of pod replicas in a deployment, allowing you to handle more or less traffic.

**Why scale applications?**
- Handle increased traffic (scale up)
- Save resources during low traffic (scale down)
- Test high-availability configurations
- Implement auto-healing by running multiple replicas

**Best practices:**
Always run at least 2 replicas in production for high availability. Use Horizontal Pod Autoscaler for automatic scaling based on CPU/memory usage.
      }.strip,
      examples: [
        'kubectl scale deployment nginx --replicas=3',
        'kubectl scale deployment web --replicas=5',
        'kubectl scale deployment api --replicas=1',
        'kubectl scale deployment db --replicas=0  # Scale to zero'
      ],
      command_to_learn: 'kubectl scale',
      practice_prompt: 'Scale the "web" deployment to 5 replicas',
      practice_exercise: {
        problem: 'Scale the web deployment to 5 replicas for high availability',
        solution_command: 'kubectl scale deployment web --replicas=5',
        validation: {
          type: 'command_match',
          base_command: 'kubectl scale deployment',
          required_flags: ['--replicas=5'],
          requires_argument: true
        },
        hints: [
          'Use kubectl scale deployment followed by name',
          'Specify replica count with --replicas=5',
          'Command: kubectl scale deployment web --replicas=5'
        ]
      }
    },
    
    'kubectl logs' => {
      title: 'Viewing Pod Logs',
      micro_lessons: [
        {
          id: 'logs_base',
          type: 'interactive',
          content: {
            title: 'View Container Logs',
            explanation: %{
`kubectl logs` shows output from containers in pods - essential for debugging!

**What you see:**
- Application output (stdout/stderr)
- Error messages
- Startup logs
- Debug information

**Basic syntax:**
`kubectl logs <pod-name>`

**For deployments with multiple pods:**
Pick a specific pod from `kubectl get pods` output.

**Let's view some logs!**
            }.strip,
            examples: [
              'kubectl logs nginx-abc123',
              'kubectl logs my-pod'
            ],
            task: 'Execute: kubectl logs <pod-name>',
            expected_command: 'kubectl logs'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl logs',
            requires_argument: true
          },
          hints: [
            'Use: kubectl logs <pod-name>',
            'Get pod name from kubectl get pods',
            'Shows recent log output'
          ]
        },
        {
          id: 'logs_follow',
          type: 'interactive',
          content: {
            title: 'Follow Logs in Real-Time',
            explanation: %{
The `-f` flag follows log output as it's generated.

**Like tail -f for Kubernetes!**
- See logs as they happen
- Watch application behavior
- Monitor during debugging
- Ctrl+C to stop

**Usage:**
`kubectl logs -f <pod-name>`

**Perfect for:**
- Watching application startup
- Monitoring active requests
- Debugging live issues
- Observing periodic tasks

**Try it - watch logs stream!**
            }.strip,
            examples: [
              'kubectl logs -f nginx-abc123',
              'kubectl logs --follow my-pod'
            ],
            task: 'Execute: kubectl logs -f <pod-name>',
            expected_command: 'kubectl logs -f'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl logs',
            required_flags: ['-f'],
            requires_argument: true
          },
          hints: [
            'Add -f to follow logs',
            'Example: kubectl logs -f my-pod',
            'Press Ctrl+C to stop following'
          ]
        },
        {
          id: 'logs_previous',
          type: 'interactive',
          content: {
            title: 'Logs from Crashed Containers',
            explanation: %{
When a container crashes and restarts, you lose the logs... unless you use `--previous`!

**The --previous flag:**
Shows logs from the previous container instance.

**Usage:**
`kubectl logs --previous <pod-name>`

**When to use:**
- Pod is in CrashLoopBackOff
- Container restarted unexpectedly
- Need to see why it crashed
- Debugging startup failures

**Pro tip:**
This is often the key to solving crash loops!
            }.strip,
            examples: [
              'kubectl logs --previous crashed-pod',
              'kubectl logs -p my-pod'
            ],
            task: 'Execute: kubectl logs --previous <pod-name>',
            expected_command: 'kubectl logs --previous'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl logs',
            required_flags: ['--previous'],
            requires_argument: true
          },
          hints: [
            'Use --previous to see crashed container logs',
            'Short form: kubectl logs -p <pod>',
            'Essential for debugging crashes'
          ]
        },
        {
          id: 'logs_tail',
          type: 'interactive',
          content: {
            title: 'Tail: Show Recent Logs Only',
            explanation: %{
The `--tail` flag limits output to recent lines.

**Why use --tail?**
- Avoid overwhelming output
- Focus on recent events
- Faster to load
- Easier to read

**Usage:**
`kubectl logs --tail=100 <pod-name>`

**Common values:**
- --tail=10 (last 10 lines)
- --tail=100 (last 100 lines)
- --tail=500 (last 500 lines)

**Combine with -f:**
`kubectl logs --tail=50 -f <pod>` - Start with last 50, then follow!
            }.strip,
            examples: [
              'kubectl logs --tail=100 my-pod',
              'kubectl logs --tail=50 -f nginx-abc123'
            ],
            task: 'Execute: kubectl logs --tail=50 <pod-name>',
            expected_command: 'kubectl logs --tail=50'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl logs',
            required_flags: ['--tail=50'],
            requires_argument: true
          },
          hints: [
            'Use --tail=50 to see last 50 lines',
            'Example: kubectl logs --tail=50 my-pod',
            'Combine with -f to follow after showing tail'
          ]
        }
      ],
      explanation: %{
The `kubectl logs` command shows you the output from containers running in pods - essential for debugging and monitoring.

**Why use kubectl logs?**
- Debug application errors and crashes
- Monitor application behavior
- See startup messages and warnings
- Track what happened before a pod crashed

**Pro tips:**
Use `-f` to follow logs in real-time. Use `--previous` to see logs from crashed containers. Use `-c` to specify which container in a multi-container pod.
      }.strip,
      examples: [
        'kubectl logs my-pod',
        'kubectl logs -f my-pod  # Follow logs',
        'kubectl logs my-pod -c my-container',
        'kubectl logs --previous my-pod  # From crashed container'
      ],
      command_to_learn: 'kubectl logs',
      practice_prompt: 'View and follow the logs of a pod in real-time',
      practice_exercise: {
        problem: 'View the logs of a pod and follow them in real-time',
        solution_command: 'kubectl logs -f <pod_name>',
        validation: {
          type: 'command_match',
          base_command: 'kubectl logs',
          required_flags: ['-f'],
          requires_argument: true
        },
        hints: [
          'Use -f flag to follow logs in real-time',
          'Specify the pod name',
          'Example: kubectl logs -f my-pod'
        ]
      }
    },
    
    'kubectl exec' => {
      title: 'Running Commands in Pods',
      micro_lessons: [
        {
          id: 'exec_shell',
          type: 'interactive',
          content: {
            title: 'Get a Shell Inside a Pod',
            explanation: %{
`kubectl exec -it` gives you an interactive shell inside a running pod - like SSH for containers!

**The flags explained:**
- `-i` : Keep stdin open (interactive)
- `-t` : Allocate a terminal (TTY)
- `--` : Separates kubectl args from command

**Syntax:**
`kubectl exec -it <pod-name> -- bash`

**Common shells:**
- bash (most common)
- sh (fallback if bash unavailable)
- /bin/ash (Alpine Linux)

**Exit the shell:**
Type `exit` or press Ctrl+D

**Let's get inside a pod!**
            }.strip,
            examples: [
              'kubectl exec -it nginx-abc123 -- bash',
              'kubectl exec -it my-pod -- sh'
            ],
            task: 'Execute: kubectl exec -it <pod-name> -- bash',
            expected_command: 'kubectl exec -it'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl exec',
            required_flags: ['-it'],
            requires_argument: true
          },
          hints: [
            'Use: kubectl exec -it <pod> -- bash',
            'The -- is important!',
            'If bash fails, try sh instead'
          ]
        },
        {
          id: 'exec_command',
          type: 'interactive',
          content: {
            title: 'Run a Single Command',
            explanation: %{
Execute a command without opening a shell.

**When to use:**
- Quick checks
- Automated scripts
- Getting specific info
- Running maintenance

**Examples:**
- Check files: `kubectl exec <pod> -- ls /app`
- View config: `kubectl exec <pod> -- cat /etc/config`
- Check processes: `kubectl exec <pod> -- ps aux`

**No -it needed for single commands!**

**Try listing the root directory:**
            }.strip,
            examples: [
              'kubectl exec my-pod -- ls /',
              'kubectl exec nginx-pod -- cat /etc/nginx/nginx.conf'
            ],
            task: 'Execute: kubectl exec <pod-name> -- ls /',
            expected_command: 'kubectl exec'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl exec',
            requires_argument: true,
            must_contain: ['--', 'ls']
          },
          hints: [
            'No -it flags needed for single commands',
            'Use: kubectl exec <pod> -- ls /',
            'The -- separates kubectl from the command'
          ]
        },
        {
          id: 'exec_container',
          type: 'interactive',
          content: {
            title: 'Multi-Container Pods: Choose Container',
            explanation: %{
Pods can have multiple containers. Use `-c` to specify which one!

**Multi-container patterns:**
- Sidecar: Log collector, proxy
- Adapter: Format converter
- Ambassador: External connection proxy

**Syntax:**
`kubectl exec -it <pod> -c <container> -- bash`

**Find container names:**
`kubectl describe pod <pod-name>`

**Default behavior:**
Without `-c`, kubectl uses the first container.

**Example with specific container:**
            }.strip,
            examples: [
              'kubectl exec -it my-pod -c app-container -- bash',
              'kubectl exec -it pod-xyz -c sidecar -- sh'
            ],
            task: 'Execute: kubectl exec -it <pod> -c <container> -- bash',
            expected_command: 'kubectl exec -it'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl exec',
            required_flags: ['-it', '-c'],
            requires_argument: true
          },
          hints: [
            'Add -c <container-name> to specify container',
            'Use: kubectl exec -it <pod> -c <container> -- bash',
            'Find container names with kubectl describe pod'
          ]
        }
      ],
      explanation: %{
The `kubectl exec` command lets you run commands inside a running pod - essential for debugging and maintenance.

**Why use kubectl exec?**
- Debug issues by inspecting the pod from inside
- Run maintenance tasks (database operations, cache clearing)
- Check file contents or configurations
- Install debugging tools temporarily

**Common use case:**
Getting a shell inside a pod to explore and troubleshoot. Use `-it` for an interactive terminal session.
      }.strip,
      examples: [
        'kubectl exec -it my-pod -- bash',
        'kubectl exec my-pod -- ls /app',
        'kubectl exec -it my-pod -c my-container -- sh',
        'kubectl exec my-pod -- cat /var/log/app.log'
      ],
      command_to_learn: 'kubectl exec',
      practice_prompt: 'Open an interactive bash shell in a running pod',
      practice_exercise: {
        problem: 'Open an interactive bash shell inside a running pod',
        solution_command: 'kubectl exec -it <pod_name> -- bash',
        validation: {
          type: 'command_match',
          base_command: 'kubectl exec',
          required_flags: ['-it'],
          requires_argument: true
        },
        hints: [
          'Use -it flags for interactive terminal',
          'Use -- to separate kubectl flags from command',
          'Example: kubectl exec -it my-pod -- bash'
        ]
      }
    },
    
    'kubectl apply' => {
      title: 'Applying Configurations',
      micro_lessons: [
        {
          id: 'apply_file',
          type: 'interactive',
          content: {
            title: 'Apply from a YAML File',
            explanation: %{
`kubectl apply` is the declarative way to manage Kubernetes - you describe the desired state in YAML.

**Declarative vs Imperative:**
- Imperative: kubectl create, kubectl expose (do this)
- Declarative: kubectl apply (make it like this)

**Why declarative is better:**
- Reproducible
- Version controlled
- Idempotent (safe to run multiple times)
- Self-documenting

**Basic syntax:**
`kubectl apply -f <filename.yaml>`

**Let's apply a configuration!**
            }.strip,
            examples: [
              'kubectl apply -f deployment.yaml',
              'kubectl apply -f service.yaml'
            ],
            task: 'Execute: kubectl apply -f app.yaml',
            expected_command: 'kubectl apply -f app.yaml'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl apply',
            required_flags: ['-f', 'app.yaml']
          },
          hints: [
            'Use: kubectl apply -f app.yaml',
            'The -f flag specifies the file',
            'File should contain Kubernetes resources in YAML'
          ]
        },
        {
          id: 'apply_directory',
          type: 'interactive',
          content: {
            title: 'Apply All Files in a Directory',
            explanation: %{
Apply all YAML files in a directory at once!

**Directory structure example:**
```
configs/
├── deployment.yaml
├── service.yaml
├── configmap.yaml
└── ingress.yaml
```

**Usage:**
`kubectl apply -f <directory>/`

**What happens:**
- Reads all .yaml and .yml files
- Applies them in dependency order
- Creates/updates all resources

**Perfect for:**
Complete application deployments!
            }.strip,
            examples: [
              'kubectl apply -f ./configs/',
              'kubectl apply -f manifests/'
            ],
            task: 'Execute: kubectl apply -f ./configs/',
            expected_command: 'kubectl apply -f ./configs/'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl apply',
            required_flags: ['-f', './configs/']
          },
          hints: [
            'Apply whole directory: kubectl apply -f ./configs/',
            'Trailing slash is optional but clear',
            'Processes all YAML files in the directory'
          ]
        },
        {
          id: 'apply_url',
          type: 'interactive',
          content: {
            title: 'Apply from URL',
            explanation: %{
Kubernetes can apply configurations directly from URLs!

**Common uses:**
- Official manifests (ingress controllers, etc.)
- Raw GitHub files
- Shared configurations

**Syntax:**
`kubectl apply -f <url>`

**Example URLs:**
- GitHub raw content
- Official Kubernetes addons
- Company artifact repositories

**Security note:**
Only apply from trusted sources!

**Try applying from a URL:**
            }.strip,
            examples: [
              'kubectl apply -f https://raw.githubusercontent.com/org/repo/main/deploy.yaml',
              'kubectl apply -f https://k8s.io/examples/application/nginx-app.yaml'
            ],
            task: 'Execute: kubectl apply -f https://k8s.io/examples/application/deployment.yaml',
            expected_command: 'kubectl apply -f https://k8s.io/examples/application/deployment.yaml'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl apply',
            required_flags: ['-f'],
            must_contain: ['https://']
          },
          hints: [
            'Use full URL with https://',
            'Works with raw GitHub URLs',
            'Only apply from trusted sources!'
          ]
        }
      ],
      explanation: %{
The `kubectl apply` command creates or updates resources from YAML/JSON files. This is the declarative way to manage Kubernetes - you describe what you want, not how to get there.

**Why use kubectl apply?**
- Manage infrastructure as code
- Version control your configurations
- Share configurations with team
- Idempotent operations (safe to run multiple times)

**Best practices:**
Store your YAML files in Git for version control. Use `apply` instead of `create` because apply can update existing resources.
      }.strip,
      examples: [
        'kubectl apply -f deployment.yaml',
        'kubectl apply -f ./configs/',
        'kubectl apply -f https://example.com/config.yaml',
        'kubectl apply -k ./kustomize-dir'
      ],
      command_to_learn: 'kubectl apply',
      practice_prompt: 'Apply a configuration from a file named app.yaml',
      practice_exercise: {
        problem: 'Apply a Kubernetes configuration from app.yaml',
        solution_command: 'kubectl apply -f app.yaml',
        validation: {
          type: 'command_match',
          base_command: 'kubectl apply',
          required_flags: ['-f'],
          requires_argument: true
        },
        hints: [
          'Use -f flag to specify file',
          'Specify the filename: app.yaml',
          'Command: kubectl apply -f app.yaml'
        ]
      }
    },
    
    'kubectl delete' => {
      title: 'Deleting Resources',
      micro_lessons: [
        {
          id: 'delete_resource',
          type: 'interactive',
          content: {
            title: 'Delete a Specific Resource',
            explanation: %{
`kubectl delete` removes resources from your cluster.

**Basic syntax:**
`kubectl delete <resource-type> <name>`

**Common resource types:**
- pod
- deployment
- service
- configmap
- secret

**What happens:**
- Resource is marked for deletion
- Kubernetes performs cleanup
- Dependent resources may also be deleted

**Warning:** Deletion is permanent!

**Let's delete a pod:**
            }.strip,
            examples: [
              'kubectl delete pod my-pod',
              'kubectl delete deployment nginx'
            ],
            task: 'Execute: kubectl delete pod old-pod',
            expected_command: 'kubectl delete pod old-pod'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl delete pod',
            requires_argument: true
          },
          hints: [
            'Use: kubectl delete pod old-pod',
            'Specify resource type then name',
            'Deletion is immediate and permanent'
          ]
        },
        {
          id: 'delete_file',
          type: 'interactive',
          content: {
            title: 'Delete Using the Same YAML',
            explanation: %{
Delete resources using the same YAML that created them!

**The symmetry of apply and delete:**
- `kubectl apply -f app.yaml` → Creates
- `kubectl delete -f app.yaml` → Deletes

**Benefits:**
- Deletes all resources in the file
- Ensures complete cleanup
- No need to remember resource names

**Usage:**
`kubectl delete -f <filename>`

**This is the clean way to remove applications!**
            }.strip,
            examples: [
              'kubectl delete -f deployment.yaml',
              'kubectl delete -f ./configs/'
            ],
            task: 'Execute: kubectl delete -f app.yaml',
            expected_command: 'kubectl delete -f app.yaml'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl delete',
            required_flags: ['-f', 'app.yaml']
          },
          hints: [
            'Use the same file that created resources',
            'Command: kubectl delete -f app.yaml',
            'Deletes all resources defined in the file'
          ]
        },
        {
          id: 'delete_selector',
          type: 'interactive',
          content: {
            title: 'Delete by Label Selector',
            explanation: %{
Delete multiple resources at once using labels!

**Label selectors:**
Delete all resources matching a label.

**Syntax:**
`kubectl delete <resource> -l <label=value>`

**Examples:**
- Delete all pods with app=test
- Clean up by environment label
- Remove old versions

**Common patterns:**
- `-l app=myapp` (by app name)
- `-l env=dev` (by environment)
- `-l version=v1` (by version)

**Powerful but dangerous - be careful!**
            }.strip,
            examples: [
              'kubectl delete pods -l app=test',
              'kubectl delete all -l env=dev'
            ],
            task: 'Execute: kubectl delete pods -l app=test',
            expected_command: 'kubectl delete pods -l app=test'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl delete pods',
            required_flags: ['-l', 'app=test']
          },
          hints: [
            'Use -l to specify label selector',
            'Command: kubectl delete pods -l app=test',
            'Deletes all pods with that label'
          ]
        }
      ],
      explanation: %{
The `kubectl delete` command removes resources from your cluster. Use it to clean up resources you no longer need.

**Why delete resources?**
- Remove failed or outdated deployments
- Clean up test resources
- Save cluster resources
- Start fresh after troubleshooting

**Be careful:**
Deleting a deployment removes all its pods. Use `--dry-run=client` to preview what will be deleted. Always double-check before deleting production resources.
      }.strip,
      examples: [
        'kubectl delete pod my-pod',
        'kubectl delete deployment nginx',
        'kubectl delete service web',
        'kubectl delete -f app.yaml'
      ],
      command_to_learn: 'kubectl delete',
      practice_prompt: 'Delete a deployment named "old-app"',
      practice_exercise: {
        problem: 'Delete a deployment by name',
        solution_command: 'kubectl delete deployment <name>',
        validation: {
          type: 'command_match',
          base_command: 'kubectl delete deployment',
          requires_argument: true
        },
        hints: [
          'Use kubectl delete deployment followed by name',
          'You can also delete using -f with a YAML file',
          'Example: kubectl delete deployment old-app'
        ]
      }
    },
    
    'kubectl describe' => {
      title: 'Detailed Resource Information',
      micro_lessons: [
        {
          id: 'describe_pod',
          type: 'interactive',
          content: {
            title: 'Describe a Pod for Troubleshooting',
            explanation: %{
`kubectl describe` is your debugging Swiss army knife!

**What it shows:**
- Complete resource details
- Current status
- Events history (crucial!)
- Error messages

**Pod information includes:**
- Container states
- Image pull status
- Resource limits
- Volume mounts
- Network settings
- **Events** (most important section!)

**The Events section tells you:**
- Why pods won't start
- Image pull failures
- Scheduling problems
- Container crashes

**Let's describe a pod:**
            }.strip,
            examples: [
              'kubectl describe pod my-pod',
              'kubectl describe pod nginx-abc123'
            ],
            task: 'Execute: kubectl describe pod <pod-name>',
            expected_command: 'kubectl describe pod'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl describe pod',
            requires_argument: true
          },
          hints: [
            'Use: kubectl describe pod <name>',
            'Check the Events section at the bottom',
            'Events show what happened and when'
          ]
        },
        {
          id: 'describe_deployment',
          type: 'interactive',
          content: {
            title: 'Describe Deployments',
            explanation: %{
Describing deployments reveals rollout status and issues.

**Key sections for deployments:**
- Replicas: desired/updated/available
- Strategy: RollingUpdate or Recreate
- Pod Template: container specs
- Conditions: current state
- Events: recent activities

**Common issues found:**
- Insufficient resources
- Image pull failures
- Failed readiness probes
- Rollout stuck

**Usage:**
`kubectl describe deployment <name>`
            }.strip,
            examples: [
              'kubectl describe deployment nginx',
              'kubectl describe deploy web'
            ],
            task: 'Execute: kubectl describe deployment <name>',
            expected_command: 'kubectl describe deployment'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl describe deployment',
            requires_argument: true
          },
          hints: [
            'Use: kubectl describe deployment <name>',
            'Shows rollout status and conditions',
            'Events section reveals deployment issues'
          ]
        },
        {
          id: 'describe_node',
          type: 'interactive',
          content: {
            title: 'Describe Nodes for Cluster Health',
            explanation: %{
Describing nodes shows cluster capacity and health.

**Node information includes:**
- Capacity: CPU, memory, pods
- Allocatable: Available resources
- Conditions: Ready, MemoryPressure, DiskPressure
- System info: OS, kernel, container runtime
- Pods running on this node

**When to describe nodes:**
- Pods stuck in Pending
- Performance issues
- Cluster capacity planning
- Node not ready

**Usage:**
`kubectl describe node <node-name>`

**Get node names:**
`kubectl get nodes`
            }.strip,
            examples: [
              'kubectl describe node worker-1',
              'kubectl describe node minikube'
            ],
            task: 'Execute: kubectl describe node <node-name>',
            expected_command: 'kubectl describe node'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl describe node',
            requires_argument: true
          },
          hints: [
            'First run: kubectl get nodes',
            'Then: kubectl describe node <name>',
            'Shows resource capacity and conditions'
          ]
        }
      ],
      explanation: %{
The `kubectl describe` command shows detailed information about a resource, including events and status - perfect for troubleshooting.

**Why use kubectl describe?**
- See detailed error messages
- View resource events and history
- Check configuration details
- Troubleshoot why pods won't start

**What you'll see:**
Events at the bottom show what happened (pod started, image pulled, errors occurred). This is often the key to solving problems.
      }.strip,
      examples: [
        'kubectl describe pod my-pod',
        'kubectl describe deployment nginx',
        'kubectl describe node my-node',
        'kubectl describe service web'
      ],
      command_to_learn: 'kubectl describe',
      practice_prompt: 'Get detailed information about a pod',
      practice_exercise: {
        problem: 'Show detailed information about a specific pod',
        solution_command: 'kubectl describe pod <pod_name>',
        validation: {
          type: 'command_match',
          base_command: 'kubectl describe pod',
          requires_argument: true
        },
        hints: [
          'Use kubectl describe pod followed by name',
          'This shows events and detailed status',
          'Example: kubectl describe pod my-pod'
        ]
      }
    },
    
    'kubectl get namespaces' => {
      title: 'Managing Namespaces',
      micro_lessons: [
        {
          id: 'namespaces_list',
          type: 'interactive',
          content: {
            title: 'List All Namespaces',
            explanation: %{
Namespaces are virtual clusters within your physical cluster.

**Think of namespaces as:**
- Separate environments (dev, staging, prod)
- Project boundaries
- Team workspaces
- Security boundaries

**Default namespaces:**
- `default`: Where your resources go if unspecified
- `kube-system`: Kubernetes system components
- `kube-public`: Publicly accessible data
- `kube-node-lease`: Node heartbeat data

**Usage:**
`kubectl get namespaces` or `kubectl get ns`

**Let's see all namespaces:**
            }.strip,
            examples: [
              'kubectl get namespaces',
              'kubectl get ns'
            ],
            task: 'Execute: kubectl get namespaces',
            expected_command: 'kubectl get namespaces'
          },
          validation: {
            type: 'command_match',
            base_command: ['kubectl get namespaces', 'kubectl get ns'],
            no_extra_flags: true
          },
          hints: [
            'Use: kubectl get namespaces',
            'Short form: kubectl get ns',
            'Shows all namespaces in cluster'
          ]
        },
        {
          id: 'namespaces_create',
          type: 'interactive',
          content: {
            title: 'Create a New Namespace',
            explanation: %{
Create namespaces to organize and isolate resources.

**Syntax:**
`kubectl create namespace <name>`

**Naming conventions:**
- Lowercase letters, numbers, hyphens
- DNS-compliant names
- Examples: dev, staging, team-alpha

**Why create namespaces:**
- Separate environments
- Resource isolation
- Apply different policies
- Avoid naming conflicts

**Let's create a development namespace:**
            }.strip,
            examples: [
              'kubectl create namespace dev',
              'kubectl create namespace staging'
            ],
            task: 'Execute: kubectl create namespace dev',
            expected_command: 'kubectl create namespace dev'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl create namespace',
            required_argument: 'dev'
          },
          hints: [
            'Use: kubectl create namespace dev',
            'Namespace names must be DNS-compliant',
            'Lowercase letters, numbers, hyphens only'
          ]
        },
        {
          id: 'namespaces_switch',
          type: 'interactive',
          content: {
            title: 'Switch Default Namespace',
            explanation: %{
Change your default namespace to avoid typing -n every time!

**Set default namespace:**
`kubectl config set-context --current --namespace=<name>`

**What this does:**
- Changes default for all kubectl commands
- No need for -n flag anymore
- Stays until you change it again

**Check current namespace:**
`kubectl config view --minify | grep namespace:`

**Best practice:**
Always be aware of your current namespace to avoid mistakes!
            }.strip,
            examples: [
              'kubectl config set-context --current --namespace=dev',
              'kubectl config set-context --current --namespace=production'
            ],
            task: 'Execute: kubectl config set-context --current --namespace=dev',
            expected_command: 'kubectl config set-context --current --namespace=dev'
          },
          validation: {
            type: 'command_match',
            base_command: 'kubectl config set-context',
            required_flags: ['--current', '--namespace=dev']
          },
          hints: [
            'Use: kubectl config set-context --current --namespace=dev',
            'This changes your default namespace',
            'All future commands will use this namespace'
          ]
        }
      ],
      explanation: %{
Namespaces provide virtual clusters within a physical cluster, allowing you to organize and isolate resources.

**Why use namespaces?**
- Separate environments (dev, staging, prod)
- Multi-tenancy (different teams/projects)
- Resource quotas and limits per namespace
- Avoid naming conflicts

**Default namespaces:**
- default: Where resources go if no namespace specified
- kube-system: Kubernetes system components
- kube-public: Publicly accessible resources
- kube-node-lease: Node heartbeat data
      }.strip,
      examples: [
        'kubectl get namespaces',
        'kubectl get ns  # Short form',
        'kubectl create namespace dev',
        'kubectl config set-context --current --namespace=dev'
      ],
      command_to_learn: 'kubectl get namespaces',
      practice_prompt: 'List all namespaces in the cluster',
      practice_exercise: {
        problem: 'List all namespaces in the cluster',
        solution_command: 'kubectl get namespaces',
        validation: {
          type: 'command_match',
          base_command: 'kubectl get namespaces',
          accepts_flags: true
        },
        hints: [
          'The command is: kubectl get namespaces',
          'You can also use the short form: kubectl get ns',
          'No flags required for this exercise'
        ]
      }
    },
  'multi-container-pods-101' => {
    title: 'Multi-Container Pods: Sidecars and Adapters',
    micro_lessons: [
      {
        id: 'multi_container_concept',
        type: 'interactive',
        content: {
          title: 'Running Multiple Containers in a Pod',
          explanation: %{
**Why Multiple Containers in One Pod?**

A pod can contain **multiple containers** that work together as a cohesive unit. They share:
- **Same IP address** - Containers can communicate via `localhost`
- **Same volumes** - Shared filesystem
- **Same network namespace** - Can share ports (but must use different port numbers)

**Common Patterns:**

**1. Sidecar Pattern:**
Main application container + helper container that enhances it
- Example: Web server + log shipper
- Example: Application + proxy/cache

**2. Adapter Pattern:**
Transforms output from main container
- Example: App outputs in one format, adapter converts it

**3. Ambassador Pattern:**
Acts as proxy to external services
- Example: App + database connection proxy

**Key Points:**
- Containers in a pod start together and stop together
- If one container crashes, the entire pod restarts
- Use when containers are tightly coupled and need to share resources
- Don't use for loosely coupled services (use separate pods + Services)

**Real Example:**
A web server pod with a sidecar that ships logs:
- Container 1: nginx (web server on port 80)
- Container 2: fluentd (log collector, reads logs from shared volume)
          }.strip,
          examples: [
            'Pods with app + log shipper',
            'Pods with app + metrics collector',
            'Pods with adapter containers'
          ],
          hints: [
            'Multiple containers in a pod share IP and volumes',
            'Use sidecar pattern for helper containers',
            'Containers must use different ports if sharing network'
          ]
        }
      }
    ]
  },
  'init-containers-101' => {
    title: 'Init Containers: Setup Before Main Containers',
    micro_lessons: [
      {
        id: 'init_containers_concept',
        type: 'interactive',
        content: {
          title: 'Init Containers: Preparation Before Main Containers',
          explanation: %{
**What are Init Containers?**

Init containers run **before** the main containers in a pod start. They:
- Run to completion (unlike main containers which run continuously)
- Run in sequence (one completes before the next starts)
- If any init container fails, the pod restarts from the first init container

**Common Use Cases:**

**1. Setup/Database Migration:**
```yaml
# Init container runs database migrations
# Then main app container starts
```

**2. Wait for Dependencies:**
```yaml
# Init container waits for database to be ready
# Only then starts the application
```

**3. Download/Prepare Files:**
```yaml
# Init container downloads configs from Git
# Main container uses those configs
```

**4. Security Setup:**
```yaml
# Init container sets up certificates
# Main container uses those certificates
```

**Key Differences:**

| Init Containers | Main Containers |
|----------------|-----------------|
| Run to completion | Run continuously |
| Run sequentially | Run in parallel |
| Must succeed | Can restart if fail |
| Run first | Run after init containers |

**Example Flow:**
1. Init container 1: Wait for database (completes)
2. Init container 2: Run migrations (completes)
3. Main container: Start application (runs continuously)

**Why This Matters:**
- Ensures prerequisites are met before app starts
- Clean separation of setup vs runtime logic
- Better error handling (fails fast if setup fails)
          }.strip,
          hints: [
            'Init containers run before main containers',
            'Init containers run sequentially and must succeed',
            'Use for setup, migrations, or waiting for dependencies'
          ]
        }
      }
    ]
  },
  'resource-requests-limits-101' => {
    title: 'Resource Requests and Limits: CPU and Memory',
    micro_lessons: [
      {
        id: 'resource_management_concept',
        type: 'interactive',
        content: {
          title: 'Managing CPU and Memory Resources',
          explanation: %{
**Why Resource Management?**

Kubernetes needs to know how much CPU and memory your containers need so it can:
- **Schedule pods** on nodes with available resources
- **Prevent one pod** from starving others
- **Ensure stability** and performance

**Two Types of Resource Specifications:**

**1. Requests (Minimum Guaranteed):**
- Amount of resources **guaranteed** to the container
- Kubernetes uses this for **scheduling decisions**
- Pod is guaranteed at least this much

**2. Limits (Maximum Allowed):**
- **Maximum** amount of resources a container can use
- If exceeded, container is throttled (CPU) or killed (Memory OOMKilled)
- Prevents one container from consuming all resources

**Resource Units:**

**CPU:**
- `1000m` = 1 CPU core = `1` = `1.0`
- `500m` = 0.5 CPU = `0.5`
- `100m` = 0.1 CPU

**Memory:**
- `128Mi` = 128 mebibytes
- `1Gi` = 1 gibibyte
- `512Mi` = 512 mebibytes

**Best Practices:**

1. **Always set requests and limits** (prevents resource exhaustion)
2. **Start conservative** and adjust based on monitoring
3. **CPU requests** help with scheduling
4. **Memory limits** prevent OOMKilled errors
5. **Requests = Limits** for predictable workloads

**Example:**
```yaml
resources:
  requests:
    cpu: "100m"      # Guaranteed 0.1 CPU
    memory: "128Mi"  # Guaranteed 128MB
  limits:
    cpu: "500m"      # Can use up to 0.5 CPU
    memory: "256Mi"  # Can use up to 256MB
```

**What Happens Without Limits?**
- Container could consume all CPU/memory on node
- Other pods get starved
- Node becomes unstable
- Can cause cascading failures
          }.strip,
          examples: [
            'kubectl run app --requests=cpu=100m,memory=128Mi --limits=cpu=500m,memory=256Mi',
            'Setting resources in YAML manifests'
          ],
          hints: [
            'Requests are for scheduling, limits prevent resource exhaustion',
            'CPU: use m (millicores), Memory: use Mi/Gi',
            'Always set both requests and limits in production'
          ]
        }
      }
    ]
  },
  'resource-quotas-101' => {
    title: 'Resource Quotas: Namespace-Level Limits',
    micro_lessons: [
      {
        id: 'resource_quotas_concept',
        type: 'interactive',
        content: {
          title: 'Resource Quotas: Limiting Resource Usage Per Namespace',
          explanation: %{
**What are Resource Quotas?**

Resource Quotas limit the **total resources** that can be consumed by all resources in a namespace. They:
- Prevent one namespace from consuming all cluster resources
- Enforce multi-tenancy (different teams/projects)
- Help with capacity planning

**Types of Quotas:**

**1. Compute Resources:**
- CPU requests/limits (total across all pods)
- Memory requests/limits (total across all pods)

**2. Object Count Quotas:**
- Number of pods
- Number of services
- Number of ConfigMaps, Secrets
- Number of PersistentVolumeClaims

**Example Quota:**
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: production
spec:
  hard:
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
    pods: "10"
```

This means the `production` namespace can have:
- Total CPU requests: 4 cores max
- Total CPU limits: 8 cores max
- Total memory requests: 8Gi max
- Total memory limits: 16Gi max
- Maximum 10 pods

**What Happens When Quota Exceeded?**

If you try to create a pod that would exceed the quota:
- Pod creation **fails** with quota exceeded error
- You must either:
  - Delete other pods to free resources
  - Request quota increase
  - Move to different namespace

**Quota vs Limits:**
- **ResourceQuota**: Namespace-level total limits
- **Resource Limits**: Per-pod maximum usage
- **Resource Requests**: Per-pod guaranteed minimum

**Use Cases:**
- Multi-tenant clusters (different teams)
- Cost control (prevent runaway resource usage)
- Fair resource sharing
- Capacity planning
          }.strip,
          hints: [
            'ResourceQuotas limit total resources per namespace',
            'Different from pod resource limits (which are per-pod)',
            'Use for multi-tenancy and resource governance'
          ]
        }
      }
    ]
  },
  'security-context-101' => {
    title: 'Security Context: Running Containers Securely',
    micro_lessons: [
      {
        id: 'security_context_concept',
        type: 'interactive',
        content: {
          title: 'Security Context: Control Container Permissions',
          explanation: %{
**What is a Security Context?**

Security Context defines **privilege and access control settings** for a pod or container:
- Which user ID to run as
- Which group ID to use
- File system permissions
- Capabilities (Linux capabilities)
- SELinux options

**Why Security Context Matters:**

**Security Best Practices:**
- **Never run as root** (user ID 0) - major security risk
- **Use least privilege** - only grant necessary permissions
- **Read-only root filesystem** - prevent malicious writes
- **Drop unnecessary capabilities** - reduce attack surface

**Key Settings:**

**1. runAsUser / runAsGroup:**
```yaml
securityContext:
  runAsUser: 1000      # Run as user ID 1000 (non-root)
  runAsGroup: 3000     # Run as group ID 3000
```

**2. fsGroup:**
```yaml
securityContext:
  fsGroup: 2000        # Group ID for volumes
```

**3. readOnlyRootFilesystem:**
```yaml
securityContext:
  readOnlyRootFilesystem: true  # Root FS is read-only
```

**4. capabilities:**
```yaml
securityContext:
  capabilities:
    drop:
      - ALL            # Drop all capabilities
    add:
      - NET_BIND_SERVICE  # Only add what's needed
```

**Pod vs Container Security Context:**
- **Pod-level**: Applies to all containers (and init containers)
- **Container-level**: Overrides pod-level for that container

**Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  securityContext:          # Pod-level
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: app
    securityContext:        # Container-level (overrides pod)
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
```

**Security Checklist:**
- [ ] Run as non-root user
- [ ] Read-only root filesystem when possible
- [ ] Drop all capabilities, add only what's needed
- [ ] Disable privilege escalation
- [ ] Set appropriate fsGroup for volumes
          }.strip,
          hints: [
            'Always run containers as non-root users',
            'Use readOnlyRootFilesystem when possible',
            'Drop unnecessary capabilities for security'
          ]
        }
      }
    ]
  },
  'service-accounts-101' => {
    title: 'Service Accounts: Pod Identity and Permissions',
    micro_lessons: [
      {
        id: 'service_accounts_concept',
        type: 'interactive',
        content: {
          title: 'Service Accounts: Identity for Pods',
          explanation: %{
**What is a Service Account?**

A Service Account provides an **identity** for pods running in the cluster:
- Every pod has a Service Account (default is `default`)
- Service Account determines **what the pod can do** (via RBAC)
- Used for authentication and authorization

**Why Service Accounts?**

**1. Identity:**
- Pods need identity to access Kubernetes API
- Service Account = identity for the pod

**2. RBAC (Role-Based Access Control):**
- Service Account is bound to Roles/RoleBindings
- Determines which API operations the pod can perform

**3. Image Pull Secrets:**
- Service Accounts can have imagePullSecrets
- Allows pulling from private registries

**Default Service Account:**
- Every namespace has a `default` service account
- Pods use `default` if no service account specified
- Has minimal permissions (can't access API server)

**Creating and Using Service Accounts:**

**Create Service Account:**
```bash
kubectl create serviceaccount my-sa
```

**Use in Pod:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  serviceAccountName: my-sa  # Use this service account
  containers:
  - name: app
    image: nginx
```

**Service Account + RBAC:**

1. Create Service Account: `my-sa`
2. Create Role: Defines permissions (e.g., "get pods")
3. Create RoleBinding: Binds Service Account to Role
4. Pod uses Service Account: Pod inherits permissions from Role

**Image Pull Secrets:**
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: private-registry-sa
imagePullSecrets:
- name: registry-secret  # Allows pulling from private registry
```

**Common Use Cases:**
- Pods that need to query Kubernetes API (read pods, services)
- Pods accessing private image registries
- Different permissions for different applications
- Multi-tenant security (different service accounts per team)

**Key Insight:**
Service Accounts + RBAC = Fine-grained access control. Each pod gets only the permissions it needs.
          }.strip,
          hints: [
            'Service Accounts provide identity for pods',
            'Used with RBAC to control API access',
            'Default service account has minimal permissions'
          ]
        }
      }
    ]
  },
  'ingress-101' => {
    title: 'Ingress: HTTP/HTTPS Routing to Services',
    micro_lessons: [
      {
        id: 'ingress_concept',
        type: 'interactive',
        content: {
          title: 'Ingress: External HTTP/HTTPS Access',
          explanation: %{
**What is Ingress?**

Ingress provides **HTTP and HTTPS routing** from outside the cluster to services inside:
- Exposes HTTP/HTTPS routes to services
- Provides load balancing, SSL termination, name-based virtual hosting
- More powerful than NodePort or LoadBalancer for HTTP traffic

**Why Ingress?**

**NodePort Problems:**
- Requires opening ports on nodes (security risk)
- Hard to manage multiple services (need different ports)
- No SSL/TLS termination
- No path-based routing

**LoadBalancer Problems:**
- Expensive (one load balancer per service)
- Cloud provider specific
- Still no path-based routing

**Ingress Solves:**
- **One entry point** for multiple services
- **Path-based routing** (`/api` → api-service, `/web` → web-service)
- **Host-based routing** (`api.example.com` → api, `web.example.com` → web)
- **SSL/TLS termination** (HTTPS to cluster, HTTP inside)
- **Cost effective** (one load balancer for many services)

**How Ingress Works:**

```
Internet
   ↓
Load Balancer (provided by cloud/infrastructure)
   ↓
Ingress Controller (runs in cluster)
   ↓
Ingress Resource (defines rules)
   ↓
Services → Pods
```

**Ingress Controller:**
- Must be installed separately (nginx-ingress, traefik, etc.)
- Watches for Ingress resources
- Configures load balancer based on Ingress rules

**Ingress Resource Example:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
spec:
  rules:
  - host: api.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
  - host: web.example.com
    http:
      paths:
      - path: /
        backend:
          service:
            name: web-service
            port:
              number: 80
```

**Path Types:**
- `Prefix`: Matches paths starting with prefix (`/api/v1` matches `/api/v1/users`)
- `Exact`: Matches exact path only

**TLS/SSL:**
```yaml
spec:
  tls:
  - hosts:
    - api.example.com
    secretName: tls-secret  # Contains certificate and key
```

**Key Points:**
- Ingress = HTTP/HTTPS only (not TCP/UDP)
- Requires Ingress Controller to be installed
- One Ingress can route to multiple services
- Most cost-effective way to expose HTTP services
          }.strip,
          examples: [
            'kubectl create ingress my-ingress --rule="api.example.com/*=api-service:80"',
            'Path-based and host-based routing examples'
          ],
          hints: [
            'Ingress provides HTTP/HTTPS routing to services',
            'Requires Ingress Controller to be installed',
            'One Ingress can route to multiple services'
          ]
        }
      }
    ]
  },
  'network-policies-101' => {
    title: 'Network Policies: Pod-to-Pod Communication Rules',
    micro_lessons: [
      {
        id: 'network_policies_concept',
        type: 'interactive',
        content: {
          title: 'Network Policies: Firewall Rules for Pods',
          explanation: %{
**What are Network Policies?**

Network Policies are like **firewall rules** for pods:
- Control which pods can communicate with each other
- Default: **all pods can communicate** (if no network policy)
- Once a Network Policy is applied, **deny by default** (only explicitly allowed traffic)

**Why Network Policies?**

**Security:**
- **Micro-segmentation**: Limit blast radius if one pod is compromised
- **Zero trust**: Only allow necessary communication
- **Compliance**: Meet security requirements (PCI-DSS, HIPAA, etc.)

**Default Behavior:**
- **No Network Policy**: All pods can communicate (permissive)
- **Network Policy exists**: Deny all, only allow what's specified (restrictive)

**Network Policy Example:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-allow-frontend
spec:
  podSelector:
    matchLabels:
      app: api              # Applies to pods with label app=api
  policyTypes:
  - Ingress                 # Rules for incoming traffic
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend     # Allow traffic from frontend pods
    ports:
    - protocol: TCP
      port: 8080
```

**Key Components:**

**1. podSelector:**
- Selects which pods this policy applies to
- Uses labels (just like Services use selectors)

**2. policyTypes:**
- `Ingress`: Rules for traffic coming INTO selected pods
- `Egress`: Rules for traffic going OUT FROM selected pods

**3. ingress / egress:**
- `from`: Where traffic can come from
  - `podSelector`: Other pods (by labels)
  - `namespaceSelector`: Pods in specific namespaces
  - `ipBlock`: Specific IP addresses/CIDR blocks
- `ports`: Which ports/protocols are allowed

**Common Patterns:**

**1. Isolate Namespace:**
```yaml
# Deny all ingress to production namespace
podSelector: {}  # All pods
ingress: []      # No allowed ingress
```

**2. Frontend → Backend Only:**
```yaml
# Backend only accepts traffic from frontend
podSelector:
  matchLabels:
    app: backend
ingress:
- from:
  - podSelector:
      matchLabels:
        app: frontend
```

**3. Database Isolation:**
```yaml
# Database only accepts from app pods, no egress
podSelector:
  matchLabels:
    app: database
ingress:
- from:
  - podSelector:
      matchLabels:
        app: api
egress: []  # No egress allowed
```

**Important Notes:**
- Network Policies require a **CNI plugin** that supports them
- Not all network plugins support Network Policies (check your cluster)
- Default deny can break applications if not carefully configured
- Test thoroughly in non-production first!
          }.strip,
          hints: [
            'Network Policies control pod-to-pod communication',
            'Default: allow all. With policy: deny all, allow only specified',
            'Requires CNI plugin with Network Policy support'
          ]
        }
      }
    ]
  },
  'statefulsets-101' => {
    title: 'StatefulSets: Stateful Applications with Stable Identity',
    micro_lessons: [
      {
        id: 'statefulsets_concept',
        type: 'interactive',
        content: {
          title: 'StatefulSets: Managing Stateful Applications',
          explanation: %{
**What are StatefulSets?**

StatefulSets manage **stateful applications** that need:
- **Stable, unique network identities**
- **Stable, persistent storage**
- **Ordered deployment and scaling**
- **Ordered termination**

**When to Use StatefulSets:**

**Stateful Applications:**
- Databases (MySQL, PostgreSQL, MongoDB)
- Message queues (RabbitMQ, Kafka)
- Caching systems (Redis with persistence)
- Any app that stores data and needs stable identity

**When NOT to Use StatefulSets:**
- Stateless applications (web servers, APIs) → Use **Deployments**

**Key Differences: Deployments vs StatefulSets**

| Feature | Deployment | StatefulSet |
|---------|-----------|-------------|
| Pod identity | Random (pod-abc123) | Stable (web-0, web-1, web-2) |
| Storage | Shared or none | Each pod gets own PVC |
| Scaling | Any order | Ordered (0, 1, 2, ...) |
| Networking | Service load balances | Headless Service, stable DNS |
| Use case | Stateless | Stateful |

**Stable Network Identity:**

**Deployment pods:**
- Names: `web-abc123`, `web-def456` (random)
- No guaranteed order

**StatefulSet pods:**
- Names: `web-0`, `web-1`, `web-2` (ordered, stable)
- DNS: `web-0.web-service`, `web-1.web-service`
- Pod name stays same even after restart

**Stable Storage:**

Each StatefulSet pod gets its **own PersistentVolumeClaim**:
- `web-0` → `data-web-0` (PVC)
- `web-1` → `data-web-1` (PVC)
- `web-2` → `data-web-2` (PVC)

When pod `web-1` is recreated, it gets the **same PVC** `data-web-1`.

**Headless Service:**

StatefulSets use a **Headless Service** (clusterIP: None):
- Provides stable DNS for each pod
- No load balancing (direct pod access)
- DNS: `<pod-name>.<service-name>.<namespace>.svc.cluster.local`

**Ordered Operations:**

**Scaling:**
- Scale up: Creates pods in order (0, 1, 2, ...)
- Scale down: Deletes pods in reverse order (2, 1, 0)

**Updates:**
- Rolling updates happen in reverse order

**Example:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  serviceName: mysql-headless  # Headless service
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7
        volumeMounts:
        - name: data
          mountPath: /var/lib/mysql
  volumeClaimTemplates:  # Each pod gets own PVC
  - metadata:
      name: data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 10Gi
```

**Key Points:**
- Use for databases, queues, stateful apps
- Provides stable pod names and storage
- Requires Headless Service
- Ordered scaling and updates
          }.strip,
          hints: [
            'StatefulSets are for stateful applications (databases, queues)',
            'Provide stable pod names (web-0, web-1) and storage',
            'Use Headless Service for stable DNS per pod'
          ]
        }
      }
    ]
  },
  'daemonsets-101' => {
    title: 'DaemonSets: Run Pod on Every Node',
    micro_lessons: [
      {
        id: 'daemonsets_concept',
        type: 'interactive',
        content: {
          title: 'DaemonSets: One Pod Per Node',
          explanation: %{
**What are DaemonSets?**

DaemonSets ensure that a **copy of a pod runs on every node** (or specific nodes) in the cluster:
- One pod per node automatically
- New nodes get the pod automatically
- Nodes removed → pod removed automatically

**When to Use DaemonSets:**

**1. Node-Level Services:**
- Log collection (fluentd, filebeat)
- Monitoring agents (Prometheus node-exporter)
- Network plugins (Calico, Flannel)
- Storage drivers

**2. System Services:**
- Security agents
- Performance monitoring
- Resource collection

**Key Characteristics:**

**Automatic Placement:**
- DaemonSet automatically places one pod on each node
- No need to specify replicas (it's based on number of nodes)

**Node Selection:**
- Can target specific nodes using `nodeSelector` or `affinity`
- Example: Only run on nodes with `role=worker`

**Rolling Updates:**
- Supports rolling updates (like Deployments)
- Can update pods on nodes one at a time

**Differences: DaemonSet vs Deployment**

| Feature | Deployment | DaemonSet |
|---------|-----------|-----------|
| Pod count | User specifies replicas | One per node (automatic) |
| Use case | Application services | Node-level services |
| Scaling | Manual (change replicas) | Automatic (add/remove nodes) |

**Example:**
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd-logging
spec:
  selector:
    matchLabels:
      name: fluentd-logging
  template:
    metadata:
      labels:
        name: fluentd-logging
    spec:
      containers:
      - name: fluentd
        image: fluentd:latest
        volumeMounts:
        - name: varlog
          mountPath: /var/log
        - name: varlibdockercontainers
          mountPath: /var/lib/docker/containers
          readOnly: true
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
      - name: varlibdockercontainers
        hostPath:
          path: /var/lib/docker/containers
```

**Node Selectors:**

Run only on specific nodes:
```yaml
spec:
  template:
    spec:
      nodeSelector:
        role: worker  # Only on nodes labeled role=worker
```

**Common DaemonSet Examples:**
- **Logging**: fluentd, filebeat on every node
- **Monitoring**: node-exporter (Prometheus) on every node
- **Networking**: CNI plugins, kube-proxy
- **Security**: security scanners, antivirus

**Key Insight:**
DaemonSets = "Run this on every node automatically". Perfect for node-level infrastructure services.
          }.strip,
          hints: [
            'DaemonSets run one pod per node automatically',
            'Use for node-level services (logging, monitoring)',
            'New nodes automatically get the pod'
          ]
        }
      }
    ]
  },
  'helm-basics-101' => {
    title: 'Helm Basics: Kubernetes Package Manager',
    micro_lessons: [
      {
        id: 'helm_concept',
        type: 'interactive',
        content: {
          title: 'Helm: Package Manager for Kubernetes',
          explanation: %{
**What is Helm?**

Helm is the **package manager for Kubernetes**:
- Think of it like `apt` for Ubuntu or `npm` for Node.js
- Packages Kubernetes applications as "Charts"
- Simplifies deployment, updates, and rollbacks

**Why Helm?**

**Without Helm:**
- Deploy application = create many YAML files (Deployment, Service, ConfigMap, Secret, Ingress, etc.)
- Update = modify all YAML files manually
- Share = send multiple YAML files
- Rollback = manually revert changes

**With Helm:**
- Deploy application = `helm install my-app ./chart`
- Update = `helm upgrade my-app ./chart`
- Share = single Chart package
- Rollback = `helm rollback my-app`

**Key Concepts:**

**1. Chart:**
- Package containing all Kubernetes resources for an application
- Includes templates (YAML with variables)
- Includes default values

**2. Release:**
- Instance of a Chart deployed to cluster
- Can have multiple releases of same Chart (different names)

**3. Repository:**
- Collection of Charts (like app store)
- Public: Artifact Hub, ChartMuseum
- Private: Your own repository

**4. Values:**
- Configuration parameters for Chart
- Default values in `values.yaml`
- Override with `--set` or `--values`

**Basic Helm Commands:**

**Install:**
```bash
helm install my-release ./my-chart
helm install my-release stable/nginx  # From repository
```

**List Releases:**
```bash
helm list
```

**Upgrade:**
```bash
helm upgrade my-release ./my-chart
helm upgrade my-release ./my-chart --set image.tag=v2.0
```

**Rollback:**
```bash
helm rollback my-release
helm rollback my-release 2  # Rollback to revision 2
```

**Uninstall:**
```bash
helm uninstall my-release
```

**Chart Structure:**
```
my-chart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default values
├── templates/          # Kubernetes YAML templates
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
└── charts/             # Sub-charts (dependencies)
```

**Values Example:**
```yaml
# values.yaml
replicaCount: 3
image:
  repository: nginx
  tag: "1.21"
service:
  type: ClusterIP
  port: 80
```

**Template Example:**
```yaml
# templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
spec:
  replicas: {{ .Values.replicaCount }}
  containers:
  - image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
```

**Common Use Cases:**
- Deploying complex applications (multiple resources)
- Sharing applications across teams
- Versioning application configurations
- Managing application lifecycle (install, upgrade, rollback)

**Helm vs kubectl:**
- **kubectl**: Low-level, one resource at a time
- **Helm**: High-level, entire application as package
- Use both: Helm for applications, kubectl for debugging
          }.strip,
          examples: [
            'helm install my-app stable/nginx',
            'helm upgrade my-app ./chart --set replicaCount=5',
            'helm rollback my-app'
          ],
          hints: [
            'Helm is the package manager for Kubernetes',
            'Charts package multiple Kubernetes resources',
            'Use for deploying complex applications'
          ]
        }
      }
    ]
  },
  'monitoring-101' => {
    title: 'Monitoring: Observing Application Health',
    micro_lessons: [
      {
        id: 'monitoring_concept',
        type: 'interactive',
        content: {
          title: 'Monitoring Kubernetes Applications',
          explanation: %{
**Why Monitor?**

Monitoring tells you:
- **Is my application healthy?**
- **Are there performance issues?**
- **Do I need to scale?**
- **What's causing errors?**

**Monitoring Stack Components:**

**1. Metrics Collection:**
- **Metrics Server**: Built-in, collects CPU/memory usage
- **Prometheus**: Popular metrics database
- **Node Exporter**: Node-level metrics

**2. Visualization:**
- **Grafana**: Create dashboards from metrics
- **Kubernetes Dashboard**: Built-in web UI

**3. Alerting:**
- **Alertmanager**: Handles alerts from Prometheus
- **PagerDuty, Slack**: Notification channels

**Built-in Monitoring: kubectl top**

**View Resource Usage:**
```bash
kubectl top pods          # CPU/memory per pod
kubectl top nodes         # CPU/memory per node
```

**Requirements:**
- Metrics Server must be installed
- Provides real-time resource usage

**Application Metrics:**

**1. Application-Level:**
- Request rate, latency, error rate
- Business metrics (orders, users)
- Custom application metrics

**2. Infrastructure-Level:**
- CPU, memory, disk, network
- Node health, pod restarts
- Cluster capacity

**Prometheus Example:**

**Expose Metrics:**
- Applications expose `/metrics` endpoint
- Prometheus scrapes metrics periodically
- Metrics stored in time-series database

**Query Metrics:**
```promql
# CPU usage of all pods
rate(container_cpu_usage_seconds_total[5m])

# Memory usage
container_memory_usage_bytes

# Request rate
rate(http_requests_total[5m])
```

**Grafana Dashboards:**

- Visualize metrics as graphs
- Create dashboards for different teams
- Set up alerts on metrics

**Key Metrics to Monitor:**

**1. Application Health:**
- Request rate
- Error rate (4xx, 5xx)
- Latency (p50, p95, p99)
- Availability (uptime)

**2. Resource Usage:**
- CPU utilization
- Memory usage
- Disk I/O
- Network traffic

**3. Kubernetes-Specific:**
- Pod restarts
- Node conditions
- Resource quotas
- Deployment rollouts

**Best Practices:**

1. **Monitor at multiple levels**: Application, pod, node, cluster
2. **Set up alerts**: Get notified of issues before users notice
3. **Use dashboards**: Visualize trends over time
4. **Log aggregation**: Combine with logging (ELK, Loki)
5. **Distributed tracing**: Track requests across services

**CKAD Focus:**

For CKAD exam, understand:
- `kubectl top` for resource usage
- How to expose metrics from applications
- Basic Prometheus concepts
- How to interpret metrics
          }.strip,
          hints: [
            'Use kubectl top for resource usage',
            'Prometheus is popular for metrics collection',
            'Monitor application and infrastructure metrics'
          ]
        }
      }
    ]
  },
  'advanced-debugging-101' => {
    title: 'Advanced Debugging: Troubleshooting Pod Issues',
    micro_lessons: [
      {
        id: 'advanced_debugging_concept',
        type: 'interactive',
        content: {
          title: 'Debugging Techniques for Kubernetes',
          explanation: %{
**Debugging Workflow:**

When a pod isn't working, follow this systematic approach:

**1. Check Pod Status:**
```bash
kubectl get pods
# Look for: Pending, CrashLoopBackOff, ImagePullBackOff, Error
```

**2. Describe the Pod:**
```bash
kubectl describe pod <pod-name>
# Shows: Events, conditions, volumes, containers
```

**3. Check Logs:**
```bash
kubectl logs <pod-name>
kubectl logs <pod-name> -c <container-name>  # Multi-container pod
kubectl logs <pod-name> --previous  # Previous container instance
```

**4. Execute Commands in Pod:**
```bash
kubectl exec -it <pod-name> -- /bin/sh
kubectl exec <pod-name> -- env  # Check environment variables
```

**Common Issues and Solutions:**

**1. CrashLoopBackOff:**
- **Cause**: Container crashing repeatedly
- **Debug**: `kubectl logs --previous` (see crash logs)
- **Check**: Application errors, missing dependencies, wrong command

**2. ImagePullBackOff:**
- **Cause**: Cannot pull container image
- **Debug**: `kubectl describe pod` (check events)
- **Fix**: Check image name, registry credentials, network

**3. Pending:**
- **Cause**: Cannot schedule pod
- **Debug**: `kubectl describe pod` (check events)
- **Common reasons**:
  - Insufficient resources (CPU/memory)
  - Node selector doesn't match
  - Taints/tolerations

**4. Not Ready:**
- **Cause**: Readiness probe failing
- **Debug**: `kubectl describe pod` (check probe status)
- **Fix**: Check application health endpoint, probe configuration

**5. Container Creating:**
- **Cause**: Initializing (init containers, volumes)
- **Debug**: `kubectl describe pod` (check init container status)
- **Wait**: Init containers must complete

**Debugging Commands:**

**View Events:**
```bash
kubectl get events --sort-by='.lastTimestamp'
kubectl get events -n <namespace>
```

**Check Resource Usage:**
```bash
kubectl top pod <pod-name>
kubectl top node
```

**Inspect Container:**
```bash
kubectl exec -it <pod-name> -- /bin/sh
# Inside container:
ps aux
env
df -h
netstat -tulpn
```

**Check Service Endpoints:**
```bash
kubectl get endpoints <service-name>
# Shows which pods are backing the service
```

**Network Debugging:**
```bash
# Test DNS resolution
kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup <service-name>

# Test connectivity
kubectl run -it --rm debug --image=busybox --restart=Never -- wget -O- <service-name>:<port>
```

**Debugging Multi-Container Pods:**
```bash
# Logs from specific container
kubectl logs <pod-name> -c <container-name>

# Exec into specific container
kubectl exec -it <pod-name> -c <container-name> -- /bin/sh
```

**Debugging Strategies:**

1. **Start broad, narrow down**: Cluster → Node → Pod → Container
2. **Check events first**: Often reveals the issue immediately
3. **Compare working vs broken**: What's different?
4. **Check recent changes**: What was modified?
5. **Use temporary debug pods**: `kubectl run debug --image=busybox -it --rm`

**CKAD Exam Tips:**
- Know `kubectl describe` output well
- Understand pod conditions and events
- Practice debugging common scenarios
- Time is limited - be efficient
          }.strip,
          hints: [
            'Use kubectl describe to see events and conditions',
            'Check logs with --previous flag for crashed containers',
            'Debug systematically: status → describe → logs → exec'
          ]
        }
      }
    ]
  },

  # ============================================================
  # DEPLOYMENTS - COMPLETE COVERAGE
  # ============================================================
  
  'deployments-complete' => {
    title: 'Deployments: Complete Guide',
    micro_lessons: [
      {
        id: 'deployment_overview',
        type: 'interactive',
        content: {
          title: 'Understanding Deployments',
          explanation: %{
**What is a Deployment?**

A Deployment provides declarative updates for Pods and ReplicaSets. It's the most common way to run applications in Kubernetes.

**Key Features:**
- **Declarative updates**: Describe desired state, Kubernetes handles the rest
- **Rolling updates**: Zero-downtime deployments
- **Rollback**: Easy revert to previous versions
- **Scaling**: Horizontal scaling of replicas
- **Self-healing**: Automatic pod replacement

**Deployment → ReplicaSet → Pods**
```
Deployment (manages) → ReplicaSet (ensures) → Pods (run)
```

**When to use Deployments:**
- Stateless applications
- Web servers, APIs
- Background workers
- Any app that can scale horizontally

**Example: Simple nginx deployment**
          }.strip,
          examples: [
            'kubectl create deployment nginx --image=nginx:latest',
            'kubectl get deployments',
            'kubectl describe deployment nginx'
          ]
        }
      }
    ]
  },

  'deployment-strategies' => {
    title: 'Deployment Strategies',
    micro_lessons: [
      {
        id: 'rolling_update_strategy',
        type: 'interactive',
        content: {
          title: 'Rolling Update Strategy',
          explanation: %{
**Rolling Update (Default)**

Updates pods gradually, ensuring availability during updates.

**How it works:**
1. Create new pods with new version
2. Wait for them to be ready
3. Terminate old pods
4. Repeat until all updated

**Key parameters:**
- **maxSurge**: How many extra pods during update (default: 25%)
- **maxUnavailable**: How many pods can be down (default: 25%)

**Example:**
```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 0
```

**Use when:**
- You need zero downtime
- Database schema is backward compatible
- Most production applications
          }.strip,
          examples: [
            'kubectl set image deployment/nginx nginx=nginx:1.25',
            'kubectl rollout status deployment/nginx',
            'kubectl rollout history deployment/nginx'
          ]
        }
      },
      {
        id: 'recreate_strategy',
        type: 'interactive',
        content: {
          title: 'Recreate Strategy',
          explanation: %{
**Recreate Strategy**

Terminates ALL old pods before creating new ones.

**How it works:**
1. Terminate all existing pods
2. Wait for termination
3. Create all new pods
4. Wait for them to be ready

**Pros:**
- Simple and predictable
- No version mixing
- Good for database migrations

**Cons:**
- Downtime during update
- Not suitable for production web apps

**Example:**
```yaml
strategy:
  type: Recreate
```

**Use when:**
- Downtime is acceptable
- Breaking schema changes
- Development/testing environments
          }.strip,
          examples: [
            'kubectl apply -f deployment-recreate.yaml',
            'kubectl describe deployment myapp'
          ]
        }
      }
    ]
  },

  'deployment-rollouts' => {
    title: 'Managing Rollouts and Rollbacks',
    micro_lessons: [
      {
        id: 'rollout_management',
        type: 'interactive',
        content: {
          title: 'Rollout Control',
          explanation: %{
**Managing Rollouts**

Control how your deployments update in production.

**Common commands:**
- `kubectl rollout status` - Watch rollout progress
- `kubectl rollout pause` - Pause a rollout
- `kubectl rollout resume` - Resume a paused rollout
- `kubectl rollout restart` - Restart all pods
- `kubectl rollout undo` - Rollback to previous version

**Pause a rollout:**
Useful for:
- Testing canary deployments
- Making multiple changes
- Investigating issues

**Example workflow:**
1. Start update
2. Pause rollout
3. Verify new pods work
4. Resume or rollback
          }.strip,
          examples: [
            'kubectl rollout status deployment/nginx',
            'kubectl rollout pause deployment/nginx',
            'kubectl rollout resume deployment/nginx',
            'kubectl rollout restart deployment/nginx'
          ]
        }
      },
      {
        id: 'rollback_deployment',
        type: 'interactive',
        content: {
          title: 'Rolling Back Deployments',
          explanation: %{
**Rollback to Previous Version**

When things go wrong, quickly revert to a working version.

**View rollout history:**
```bash
kubectl rollout history deployment/nginx
```

**Rollback to previous version:**
```bash
kubectl rollout undo deployment/nginx
```

**Rollback to specific revision:**
```bash
kubectl rollout undo deployment/nginx --to-revision=2
```

**Check revision details:**
```bash
kubectl rollout history deployment/nginx --revision=3
```

**Best practices:**
- Use `--record` flag when updating (deprecated but useful)
- Set `revisionHistoryLimit` in deployment spec
- Monitor rollout status before marking complete
- Have rollback plan ready
          }.strip,
          examples: [
            'kubectl rollout undo deployment/nginx',
            'kubectl rollout history deployment/nginx',
            'kubectl rollout undo deployment/nginx --to-revision=2'
          ]
        }
      }
    ]
  },

  'deployment-health-checks' => {
    title: 'Health Checks and Probes',
    micro_lessons: [
      {
        id: 'liveness_probes',
        type: 'interactive',
        content: {
          title: 'Liveness Probes',
          explanation: %{
**Liveness Probes**

Checks if container is running. If it fails, Kubernetes restarts the container.

**Types of probes:**
1. **HTTP GET** - Send HTTP request
2. **TCP Socket** - Check if port is open
3. **Exec** - Run command in container

**HTTP Liveness example:**
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3
```

**When to use:**
- Detect deadlocks
- Catch infinite loops
- Restart hung processes

**Warning:** Don't make it too sensitive or you'll restart healthy pods!
          }.strip,
          examples: [
            'kubectl describe pod nginx-xxx | grep Liveness',
            'kubectl get events --field-selector involvedObject.name=nginx-xxx'
          ]
        }
      },
      {
        id: 'readiness_probes',
        type: 'interactive',
        content: {
          title: 'Readiness Probes',
          explanation: %{
**Readiness Probes**

Checks if container is ready to serve traffic. If it fails, pod is removed from service endpoints.

**Key difference from Liveness:**
- Liveness → Restarts container
- Readiness → Removes from load balancer

**HTTP Readiness example:**
```yaml
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
  successThreshold: 1
```

**Use readiness for:**
- Waiting for dependencies (database, cache)
- Warming up caches
- Loading configuration
- Temporary unavailability (without restart)

**Best practice:** Use both liveness AND readiness probes!
          }.strip,
          examples: [
            'kubectl describe pod nginx-xxx | grep Readiness',
            'kubectl get endpoints myservice'
          ]
        }
      },
      {
        id: 'startup_probes',
        type: 'interactive',
        content: {
          title: 'Startup Probes',
          explanation: %{
**Startup Probes**

Checks if application has started. Disables liveness/readiness checks until startup succeeds.

**Problem it solves:**
Some apps take a long time to start (30+ seconds). Setting high `initialDelaySeconds` on liveness probe delays detection of crashes.

**Solution: Startup probe**
```yaml
startupProbe:
  httpGet:
    path: /healthz
    port: 8080
  failureThreshold: 30
  periodSeconds: 10
```

This gives app 300 seconds (30 × 10) to start, then switches to liveness probe.

**Use for:**
- Legacy applications
- Apps with slow initialization
- Database migrations on startup
- Large data loading

**After startup succeeds:** Liveness and readiness probes take over
          }.strip,
          examples: [
            'kubectl describe pod myapp-xxx | grep Startup'
          ]
        }
      }
    ]
  },

  # ============================================================
  # SERVICES - COMPLETE COVERAGE
  # ============================================================
  
  'services-deep-dive' => {
    title: 'Services: Complete Guide',
    micro_lessons: [
      {
        id: 'service_types_complete',
        type: 'interactive',
        content: {
          title: 'Service Types: ClusterIP, NodePort, LoadBalancer',
          explanation: %{
**Understanding Service Types**

Services provide stable networking for dynamic pods.

**1. ClusterIP (Default)**
- Internal-only access
- Gets a cluster-internal IP
- Perfect for microservices communication
```yaml
type: ClusterIP
```

**2. NodePort**
- Exposes on each Node's IP at a static port
- Port range: 30000-32767
- Access via `<NodeIP>:<NodePort>`
```yaml
type: NodePort
port: 80
nodePort: 30080
```

**3. LoadBalancer**
- Cloud provider external load balancer
- Gets external IP (on AWS, GCP, Azure)
- Routes traffic to NodePort
```yaml
type: LoadBalancer
```

**4. ExternalName**
- Maps service to DNS name
- Returns CNAME record
- No proxying, just DNS
```yaml
type: ExternalName
externalName: api.example.com
```

**Choosing the right type:**
- Internal services → ClusterIP
- Development/testing → NodePort
- Production external → LoadBalancer
          }.strip,
          examples: [
            'kubectl expose deployment nginx --type=ClusterIP --port=80',
            'kubectl expose deployment web --type=NodePort --port=8080',
            'kubectl expose deployment api --type=LoadBalancer --port=443'
          ]
        }
      },
      {
        id: 'service_discovery',
        type: 'interactive',
        content: {
          title: 'Service Discovery and DNS',
          explanation: %{
**Kubernetes DNS**

Every service gets a DNS name automatically!

**DNS format:**
```
<service-name>.<namespace>.svc.cluster.local
```

**Short forms (within same namespace):**
- `service-name`
- `service-name.namespace`

**Example:**
Service "redis" in "cache" namespace:
- Full: `redis.cache.svc.cluster.local`
- Short: `redis.cache`
- Same namespace: `redis`

**How it works:**
1. Service created → DNS entry created
2. Pods can use service name as hostname
3. DNS resolves to ClusterIP
4. kube-proxy routes to healthy pods

**Test DNS resolution:**
```bash
kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup redis
```

**Environment variables:**
Kubernetes also injects env vars:
- `REDIS_SERVICE_HOST=10.96.1.5`
- `REDIS_SERVICE_PORT=6379`
          }.strip,
          examples: [
            'kubectl get services',
            'kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup kubernetes',
            'kubectl exec -it mypod -- env | grep SERVICE'
          ]
        }
      },
      {
        id: 'headless_services',
        type: 'interactive',
        content: {
          title: 'Headless Services',
          explanation: %{
**Headless Services**

Services without load balancing - DNS returns pod IPs directly.

**Create headless service:**
```yaml
spec:
  clusterIP: None  # This makes it headless
  selector:
    app: myapp
```

**When to use:**
1. **StatefulSets** - Direct pod access
2. **Client-side load balancing** - App handles routing
3. **Service discovery** - Get all pod IPs

**DNS behavior:**
Normal service: DNS → ClusterIP → kube-proxy → pods
Headless: DNS → [pod-ip-1, pod-ip-2, pod-ip-3]

**StatefulSet + Headless:**
Pods get stable DNS:
```
myapp-0.myapp.default.svc.cluster.local
myapp-1.myapp.default.svc.cluster.local
```

**Use cases:**
- Databases (MongoDB, Cassandra)
- Message queues (Kafka, RabbitMQ)
- Peer-to-peer apps
          }.strip,
          examples: [
            'kubectl get svc',
            'kubectl describe svc myapp'
          ]
        }
      },
      {
        id: 'service_endpoints',
        type: 'interactive',
        content: {
          title: 'Endpoints and Service Connectivity',
          explanation: %{
**Understanding Endpoints**

Endpoints are the actual pod IPs behind a service.

**How it works:**
1. Service created with selector
2. Endpoint controller watches matching pods
3. Creates/updates Endpoints object
4. kube-proxy configures iptables/IPVS

**View endpoints:**
```bash
kubectl get endpoints myservice
```

**Troubleshooting:**
Service not working? Check endpoints:
- No endpoints → No pods match selector
- Some endpoints → Some pods ready
- All endpoints → All pods ready

**Manual endpoints (no selector):**
```yaml
kind: Service
metadata:
  name: external-db
spec:
  ports:
  - port: 5432
---
kind: Endpoints
metadata:
  name: external-db
subsets:
- addresses:
  - ip: 192.168.1.100
  ports:
  - port: 5432
```

Use for external databases!
          }.strip,
          examples: [
            'kubectl get endpoints',
            'kubectl describe endpoints myservice',
            'kubectl get svc,endpoints'
          ]
        }
      }
    ]
  },

  # ============================================================
  # STORAGE - COMPLETE COVERAGE
  # ============================================================
  
  'persistent-volumes' => {
    title: 'Persistent Volumes (PV)',
    micro_lessons: [
      {
        id: 'pv_overview',
        type: 'interactive',
        content: {
          title: 'Understanding Persistent Volumes',
          explanation: %{
**Persistent Volumes (PV)**

Cluster-level storage resources provisioned by admins.

**PV Lifecycle:**
1. **Provisioned** - Admin creates or dynamic provisioning
2. **Bound** - Claimed by a PVC
3. **Released** - PVC deleted
4. **Reclaimed** - Recycled, deleted, or retained

**Reclaim Policies:**
- **Retain** - Manual cleanup (production)
- **Delete** - Auto-delete with PVC (cloud)
- **Recycle** - Deprecated

**Access Modes:**
- **ReadWriteOnce (RWO)** - Single node read-write
- **ReadOnlyMany (ROX)** - Multiple nodes read-only
- **ReadWriteMany (RWX)** - Multiple nodes read-write

**Example PV:**
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-demo
spec:
  capacity:
    storage: 10Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /data/pv-demo
```
          }.strip,
          examples: [
            'kubectl get pv',
            'kubectl describe pv pv-demo',
            'kubectl get pv -o wide'
          ]
        }
      }
    ]
  },

  'persistent-volume-claims' => {
    title: 'Persistent Volume Claims (PVC)',
    micro_lessons: [
      {
        id: 'pvc_overview',
        type: 'interactive',
        content: {
          title: 'Understanding PVCs',
          explanation: %{
**Persistent Volume Claims (PVC)**

A request for storage by a user. PVCs bind to PVs.

**PVC → PV binding:**
1. User creates PVC with requirements
2. Kubernetes finds matching PV
3. Binds PVC to PV
4. Pod uses PVC in volume mount

**Example PVC:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: standard
```

**Using PVC in Pod:**
```yaml
volumes:
- name: data
  persistentVolumeClaim:
    claimName: my-pvc
containers:
- name: app
  volumeMounts:
  - name: data
    mountPath: /data
```

**Best practices:**
- Request appropriate size
- Use StorageClass for dynamic provisioning
- Set resource limits
          }.strip,
          examples: [
            'kubectl get pvc',
            'kubectl describe pvc my-pvc',
            'kubectl get pvc,pv'
          ]
        }
      }
    ]
  },

  'storage-classes' => {
    title: 'Storage Classes',
    micro_lessons: [
      {
        id: 'storage_class_overview',
        type: 'interactive',
        content: {
          title: 'Dynamic Provisioning with StorageClasses',
          explanation: %{
**StorageClass**

Describes the "classes" of storage available. Enables dynamic provisioning.

**How it works:**
1. Admin creates StorageClass
2. User creates PVC with storageClassName
3. Kubernetes automatically creates PV
4. PV binds to PVC

**Example StorageClass (AWS EBS):**
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-ssd
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp3
  iopsPerGB: "10"
  encrypted: "true"
```

**Common provisioners:**
- AWS: `kubernetes.io/aws-ebs`
- GCP: `kubernetes.io/gce-pd`
- Azure: `kubernetes.io/azure-disk`
- NFS: `nfs-client`
- Local: `kubernetes.io/no-provisioner`

**Volume binding modes:**
- **Immediate** - Create PV when PVC created
- **WaitForFirstConsumer** - Wait until pod scheduled (better)

**Default StorageClass:**
Mark one as default with annotation:
```yaml
storageclass.kubernetes.io/is-default-class: "true"
```
          }.strip,
          examples: [
            'kubectl get storageclass',
            'kubectl get sc',
            'kubectl describe sc standard'
          ]
        }
      }
    ]
  },

  # ============================================================
  # NETWORKING - COMPLETE COVERAGE
  # ============================================================
  
  'ingress-complete' => {
    title: 'Ingress: Complete Guide',
    micro_lessons: [
      {
        id: 'ingress_overview',
        type: 'interactive',
        content: {
          title: 'Understanding Ingress',
          explanation: %{
**Ingress**

HTTP/HTTPS routing to services. One external IP for multiple services.

**Without Ingress:**
```
Internet → LoadBalancer1 → Service1
Internet → LoadBalancer2 → Service2
Internet → LoadBalancer3 → Service3
```
(Expensive! Each LoadBalancer costs money)

**With Ingress:**
```
Internet → Ingress Controller → Service1
                               → Service2
                               → Service3
```
(One external IP, many services!)

**Ingress features:**
- **Path-based routing**: /api → api-service, /web → web-service
- **Host-based routing**: api.example.com → api-service
- **TLS termination**: HTTPS encryption
- **Load balancing**: Across pods
- **URL rewriting**: Transform URLs

**Example Ingress:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
spec:
  rules:
  - host: example.com
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

**Requires Ingress Controller:**
- nginx-ingress
- traefik
- HAProxy
- AWS ALB
          }.strip,
          examples: [
            'kubectl get ingress',
            'kubectl describe ingress my-ingress',
            'kubectl get ing -A'
          ]
        }
      },
      {
        id: 'ingress_path_routing',
        type: 'interactive',
        content: {
          title: 'Path-Based Routing',
          explanation: %{
**Path-Based Routing**

Route different URL paths to different services.

**Example:**
```yaml
spec:
  rules:
  - http:
      paths:
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 3000
      - path: /web
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
      - path: /
        pathType: Prefix
        backend:
          service:
            name: default-service
            port:
              number: 80
```

**PathType options:**
- **Prefix** - Matches path prefix (most common)
- **Exact** - Exact path match
- **ImplementationSpecific** - Controller-specific

**URL matching:**
- `/api` matches `/api`, `/api/users`, `/api/v1/users`
- `/api/` with Exact only matches `/api/`

**Best practices:**
- Most specific paths first
- Use Prefix for flexibility
- Have a default / catch-all route
          }.strip,
          examples: [
            'kubectl get ingress',
            'kubectl describe ingress my-ingress'
          ]
        }
      },
      {
        id: 'ingress_tls',
        type: 'interactive',
        content: {
          title: 'TLS/HTTPS with Ingress',
          explanation: %{
**TLS Termination**

Ingress can handle HTTPS and terminate SSL at the edge.

**Steps:**
1. Create TLS secret with cert and key
2. Reference in Ingress

**Create TLS secret:**
```bash
kubectl create secret tls my-tls \\
  --cert=path/to/cert.crt \\
  --key=path/to/key.key
```

**Ingress with TLS:**
```yaml
spec:
  tls:
  - hosts:
    - example.com
    secretName: my-tls
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        backend:
          service:
            name: web
            port:
              number: 80
```

**Automatic redirect HTTP → HTTPS:**
Most controllers support annotations:
```yaml
annotations:
  nginx.ingress.kubernetes.io/ssl-redirect: "true"
```

**Let's Encrypt with cert-manager:**
Automate TLS certificate management!
          }.strip,
          examples: [
            'kubectl get secrets',
            'kubectl describe ingress my-ingress',
            'kubectl get certificate'
          ]
        }
      }
    ]
  },

  'network-policies-complete' => {
    title: 'Network Policies: Complete Guide',
    micro_lessons: [
      {
        id: 'network_policy_overview',
        type: 'interactive',
        content: {
          title: 'Understanding Network Policies',
          explanation: %{
**Network Policies**

Firewall rules for Kubernetes. Control pod-to-pod communication.

**Default behavior:**
- All pods can communicate with all pods
- All pods can reach internet
- No restrictions!

**With NetworkPolicy:**
- Whitelist allowed traffic
- Deny by default
- Fine-grained control

**Example: Allow only from frontend to backend**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend-policy
spec:
  podSelector:
    matchLabels:
      role: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: frontend
    ports:
    - protocol: TCP
      port: 8080
```

**Policy types:**
- **Ingress** - Incoming traffic rules
- **Egress** - Outgoing traffic rules

**Requires CNI plugin support:**
- Calico ✅
- Cilium ✅
- Weave ✅
- Flannel ❌ (no NetworkPolicy support)
          }.strip,
          examples: [
            'kubectl get networkpolicies',
            'kubectl get netpol',
            'kubectl describe networkpolicy backend-policy'
          ]
        }
      },
      {
        id: 'network_policy_egress',
        type: 'interactive',
        content: {
          title: 'Egress Network Policies',
          explanation: %{
**Egress Policies**

Control outbound traffic from pods.

**Common use cases:**
- Restrict internet access
- Allow only specific external APIs
- Prevent data exfiltration
- Compliance requirements

**Example: Allow only DNS and specific API**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-egress
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Egress
  egress:
  - to:  # Allow DNS
    - namespaceSelector:
        matchLabels:
          name: kube-system
    ports:
    - protocol: UDP
      port: 53
  - to:  # Allow specific external IP
    - ipBlock:
        cidr: 203.0.113.0/24
    ports:
    - protocol: TCP
      port: 443
```

**Default deny all egress:**
```yaml
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress: []  # Empty = deny all
```

**Best practices:**
- Always allow DNS (kube-system)
- Be explicit about external access
- Test before production
          }.strip,
          examples: [
            'kubectl get networkpolicy',
            'kubectl describe netpol api-egress'
          ]
        }
      }
    ]
  },

  # ============================================================
  # RBAC - COMPLETE COVERAGE
  # ============================================================
  
  'rbac-overview' => {
    title: 'RBAC: Role-Based Access Control',
    micro_lessons: [
      {
        id: 'rbac_basics',
        type: 'interactive',
        content: {
          title: 'Understanding RBAC',
          explanation: %{
**Role-Based Access Control (RBAC)**

Control who can do what in your cluster.

**Core concepts:**
1. **Role** - Permissions within a namespace
2. **ClusterRole** - Cluster-wide permissions
3. **RoleBinding** - Grant Role to users/groups/ServiceAccounts
4. **ClusterRoleBinding** - Grant ClusterRole cluster-wide

**RBAC flow:**
```
User/ServiceAccount → RoleBinding → Role → Resources + Verbs
```

**Example Role:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
```

**Example RoleBinding:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: jane
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

**Common verbs:**
- get, list, watch (read)
- create, update, patch (write)
- delete, deletecollection (delete)
          }.strip,
          examples: [
            'kubectl get roles',
            'kubectl get rolebindings',
            'kubectl describe role pod-reader'
          ]
        }
      },
      {
        id: 'cluster_roles',
        type: 'interactive',
        content: {
          title: 'ClusterRoles and ClusterRoleBindings',
          explanation: %{
**ClusterRole**

Cluster-wide permissions for non-namespaced resources or across all namespaces.

**Use ClusterRole for:**
- Cluster-scoped resources (nodes, PV, namespaces)
- Permissions across all namespaces
- Admin-level access

**Example ClusterRole:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: node-reader
rules:
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
```

**ClusterRoleBinding:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: read-nodes-global
subjects:
- kind: Group
  name: system:authenticated
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: node-reader
  apiGroup: rbac.authorization.k8s.io
```

**Aggregated ClusterRoles:**
Combine multiple ClusterRoles:
```yaml
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      rbac.example.com/aggregate-to-monitoring: "true"
```
          }.strip,
          examples: [
            'kubectl get clusterroles',
            'kubectl get clusterrolebindings',
            'kubectl describe clusterrole cluster-admin'
          ]
        }
      },
      {
        id: 'service_accounts_rbac',
        type: 'interactive',
        content: {
          title: 'Service Accounts with RBAC',
          explanation: %{
**Service Accounts**

Identities for pods to access Kubernetes API.

**Every pod has a ServiceAccount:**
- Default: `default` ServiceAccount in namespace
- Custom: Create specific ServiceAccounts

**Create ServiceAccount:**
```bash
kubectl create serviceaccount my-app-sa
```

**Use in Pod:**
```yaml
spec:
  serviceAccountName: my-app-sa
  containers:
  - name: app
    image: myapp:1.0
```

**Grant permissions:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-manager
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "create", "delete"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: my-app-pod-manager
subjects:
- kind: ServiceAccount
  name: my-app-sa
roleRef:
  kind: Role
  name: pod-manager
```

**Security best practices:**
- Don't use default ServiceAccount
- Principle of least privilege
- One ServiceAccount per application
- Disable automounting if not needed:
```yaml
automountServiceAccountToken: false
```
          }.strip,
          examples: [
            'kubectl get serviceaccounts',
            'kubectl get sa',
            'kubectl describe sa my-app-sa'
          ]
        }
      }
    ]
  },

  # ============================================================
  # OBSERVABILITY - COMPLETE COVERAGE
  # ============================================================
  
  'monitoring-complete' => {
    title: 'Monitoring: Complete Guide',
    micro_lessons: [
      {
        id: 'metrics_server',
        type: 'interactive',
        content: {
          title: 'Metrics Server and Resource Usage',
          explanation: %{
**Metrics Server**

Collects resource metrics from kubelets. Required for `kubectl top`.

**Install Metrics Server:**
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

**View node metrics:**
```bash
kubectl top nodes
```

**View pod metrics:**
```bash
kubectl top pods
kubectl top pods -A
kubectl top pods --containers
```

**Output shows:**
- CPU usage (millicores)
- Memory usage (Mi/Gi)
- CPU/Memory percentage

**Use for:**
- Identifying resource hogs
- Right-sizing requests/limits
- Capacity planning
- Horizontal Pod Autoscaling (HPA)

**Autoscaling based on metrics:**
```bash
kubectl autoscale deployment nginx --cpu-percent=80 --min=2 --max=10
```
          }.strip,
          examples: [
            'kubectl top nodes',
            'kubectl top pods',
            'kubectl top pods --containers',
            'kubectl top pods -A --sort-by=memory'
          ]
        }
      },
      {
        id: 'prometheus_monitoring',
        type: 'interactive',
        content: {
          title: 'Prometheus for Monitoring',
          explanation: %{
**Prometheus**

Industry-standard monitoring for Kubernetes.

**Architecture:**
```
Pods (metrics) → Service Discovery → Prometheus → Grafana (visualize)
                                    ↓
                                AlertManager (alerts)
```

**What Prometheus monitors:**
- Container metrics (CPU, memory, network)
- Application metrics (custom metrics)
- Kubernetes API metrics
- Node metrics

**ServiceMonitor (with Prometheus Operator):**
```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: myapp
spec:
  selector:
    matchLabels:
      app: myapp
  endpoints:
  - port: metrics
    interval: 30s
```

**Common queries (PromQL):**
```
# Pod CPU usage
sum(rate(container_cpu_usage_seconds_total[5m])) by (pod)

# Pod memory usage
container_memory_usage_bytes

# Request rate
rate(http_requests_total[5m])
```

**Install with Helm:**
```bash
helm install prometheus prometheus-community/kube-prometheus-stack
```
          }.strip,
          examples: [
            'kubectl get servicemonitors',
            'kubectl get prometheuses',
            'kubectl port-forward svc/prometheus 9090:9090'
          ]
        }
      }
    ]
  },

  'logging-complete' => {
    title: 'Logging: Complete Guide',
    micro_lessons: [
      {
        id: 'centralized_logging',
        type: 'interactive',
        content: {
          title: 'Centralized Logging',
          explanation: %{
**Centralized Logging**

Aggregate logs from all pods in one place.

**Popular stacks:**

**1. EFK Stack:**
- **Elasticsearch** - Store and index logs
- **Fluentd** - Collect and forward logs
- **Kibana** - Visualize and search logs

**2. ELK Stack:**
- **Elasticsearch** - Store
- **Logstash** - Process
- **Kibana** - Visualize

**3. Loki (by Grafana):**
- Lightweight alternative to Elasticsearch
- Integrates with Grafana
- Cost-effective

**How it works:**
```
Pods → logs to stdout/stderr
         ↓
Container runtime → /var/log/containers/
         ↓
DaemonSet (Fluentd/Fluent Bit) → reads logs
         ↓
Elasticsearch/Loki → stores logs
         ↓
Kibana/Grafana → visualize
```

**Best practices:**
- Log to stdout/stderr (not files)
- Use JSON structured logging
- Include correlation IDs
- Set log levels (debug, info, warn, error)
- Rotate logs to prevent disk fill

**Query logs in Kibana:**
```
kubernetes.namespace_name:"production" AND kubernetes.labels.app:"myapp"
```
          }.strip,
          examples: [
            'kubectl logs -f deployment/myapp',
            'kubectl logs myapp-xxx --all-containers=true',
            'kubectl logs -l app=myapp --tail=100'
          ]
        }
      }
    ]
  },

  # ============================================================
  # ADVANCED TOPICS
  # ============================================================
  
  'custom-resources' => {
    title: 'Custom Resource Definitions (CRDs)',
    micro_lessons: [
      {
        id: 'crd_overview',
        type: 'interactive',
        content: {
          title: 'Understanding CRDs',
          explanation: %{
**Custom Resource Definitions (CRDs)**

Extend Kubernetes with your own resource types!

**Built-in resources:**
- Pods, Services, Deployments, etc.

**CRDs let you create:**
- Database (custom type)
- Application (custom type)
- Certificate (cert-manager)
- Anything you can imagine!

**Example CRD:**
```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: databases.example.com
spec:
  group: example.com
  versions:
  - name: v1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              engine:
                type: string
              version:
                type: string
  scope: Namespaced
  names:
    plural: databases
    singular: database
    kind: Database
```

**After CRD is created, use it:**
```yaml
apiVersion: example.com/v1
kind: Database
metadata:
  name: my-db
spec:
  engine: postgresql
  version: "14"
```

**Used by:**
- Operators (automate complex apps)
- Platform engineering
- Custom workflows
          }.strip,
          examples: [
            'kubectl get crds',
            'kubectl get crd',
            'kubectl describe crd databases.example.com'
          ]
        }
      }
    ]
  },

  'operators' => {
    title: 'Kubernetes Operators',
    micro_lessons: [
      {
        id: 'operator_pattern',
        type: 'interactive',
        content: {
          title: 'Understanding Operators',
          explanation: %{
**Kubernetes Operators**

Operators = CRD + Controller. Automate complex applications.

**What Operators do:**
1. Watch for custom resources
2. Reconcile actual state with desired state
3. Perform complex operational tasks

**Example: Database Operator**
Instead of:
- Manually deploying pods
- Configuring replication
- Setting up backups
- Managing failover

You do:
```yaml
apiVersion: postgresql.example.com/v1
kind: PostgreSQL
metadata:
  name: my-db
spec:
  replicas: 3
  version: "14"
  backup:
    schedule: "0 2 * * *"
```

Operator handles everything!

**Popular Operators:**
- **Prometheus Operator** - Monitoring
- **Cert-Manager** - TLS certificates
- **Strimzi** - Kafka
- **PostgreSQL Operator** - Databases
- **Istio Operator** - Service mesh
- **Argo CD** - GitOps

**Operator Framework:**
- Operator SDK (build operators)
- OperatorHub (find operators)
- OLM (Operator Lifecycle Manager)

**Build operators with:**
- Go (kubebuilder, operator-sdk)
- Ansible
- Helm
          }.strip,
          examples: [
            'kubectl get operators',
            'kubectl get csv',
            'kubectl describe operator prometheus'
          ]
        }
      }
    ]
  },

  'helm-complete' => {
    title: 'Helm: Package Manager',
    micro_lessons: [
      {
        id: 'helm_overview',
        type: 'interactive',
        content: {
          title: 'Helm Basics',
          explanation: %{
**Helm**

Package manager for Kubernetes. Think npm for K8s.

**What is a Helm Chart?**
Collection of Kubernetes YAML files packaged together.

**Helm concepts:**
- **Chart** - Package (like npm package)
- **Release** - Instance of a chart
- **Repository** - Where charts are stored

**Common commands:**
```bash
# Add repo
helm repo add bitnami https://charts.bitnami.com/bitnami

# Search charts
helm search repo nginx

# Install chart
helm install my-nginx bitnami/nginx

# List releases
helm list

# Upgrade release
helm upgrade my-nginx bitnami/nginx --set replicaCount=3

# Rollback
helm rollback my-nginx

# Uninstall
helm uninstall my-nginx
```

**Chart structure:**
```
mychart/
  Chart.yaml          # Chart metadata
  values.yaml         # Default config
  templates/          # K8s YAML templates
    deployment.yaml
    service.yaml
    ingress.yaml
```

**Override values:**
```bash
helm install myapp ./mychart \\
  --set image.tag=v2.0 \\
  --set replicaCount=5
```

Or use values file:
```bash
helm install myapp ./mychart -f prod-values.yaml
```
          }.strip,
          examples: [
            'helm list',
            'helm repo list',
            'helm search repo prometheus'
          ]
        }
      }
    ]
  },

  'kustomize' => {
    title: 'Kustomize: Configuration Management',
    micro_lessons: [
      {
        id: 'kustomize_overview',
        type: 'interactive',
        content: {
          title: 'Understanding Kustomize',
          explanation: %{
**Kustomize**

Template-free configuration management. Built into kubectl!

**Philosophy:**
- No templates (unlike Helm)
- Patch and overlay YAML files
- Native Kubernetes YAML

**Structure:**
```
base/
  deployment.yaml
  service.yaml
  kustomization.yaml

overlays/
  dev/
    kustomization.yaml
    patches.yaml
  prod/
    kustomization.yaml
    patches.yaml
```

**kustomization.yaml (base):**
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- deployment.yaml
- service.yaml

commonLabels:
  app: myapp
```

**kustomization.yaml (overlay/prod):**
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
- ../../base

replicas:
- name: myapp
  count: 5

images:
- name: myapp
  newTag: v2.0.0
```

**Apply with kubectl:**
```bash
kubectl apply -k overlays/prod/
```

**Benefits:**
- No templating language to learn
- Easy to review diffs
- Built into kubectl
- GitOps friendly
          }.strip,
          examples: [
            'kubectl apply -k ./base',
            'kubectl kustomize ./overlays/prod',
            'kubectl get all -l app=myapp'
          ]
        }
      }
    ]
  },

  'gitops' => {
    title: 'GitOps with ArgoCD and Flux',
    micro_lessons: [
      {
        id: 'gitops_overview',
        type: 'interactive',
        content: {
          title: 'Understanding GitOps',
          explanation: %{
**GitOps**

Git as the single source of truth for infrastructure and applications.

**Core principles:**
1. **Declarative** - Describe system in Git
2. **Versioned** - Git history = deployment history
3. **Automated** - Git commit → auto deploy
4. **Auditable** - Who changed what when

**GitOps workflow:**
```
Developer → Git push → GitOps tool → Kubernetes cluster
                           ↓
                    Monitors Git repo
                    Compares with cluster
                    Syncs differences
```

**Benefits:**
- **Rollback** - Git revert = cluster rollback
- **Disaster recovery** - Recreate from Git
- **Audit trail** - Git history
- **Code review** - Pull requests for changes
- **Security** - No kubectl access needed

**ArgoCD:**
```bash
# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Create application
argocd app create myapp \\
  --repo https://github.com/org/repo \\
  --path k8s/prod \\
  --dest-server https://kubernetes.default.svc \\
  --dest-namespace default
```

**Flux CD:**
Lightweight, GitOps toolkit.

**Comparison:**
- ArgoCD: UI, multi-tenancy, more features
- Flux: Lightweight, Helm-native, Kustomize-native
          }.strip,
          examples: [
            'kubectl get applications',
            'kubectl describe application myapp',
            'argocd app sync myapp'
          ]
        }
      }
    ]
  },

  # ============================================================
  # CLUSTER ADMINISTRATION
  # ============================================================
  
  'cluster-management' => {
    title: 'Cluster Management',
    micro_lessons: [
      {
        id: 'node_management',
        type: 'interactive',
        content: {
          title: 'Managing Nodes',
          explanation: %{
**Node Management**

Nodes are the worker machines in Kubernetes.

**View nodes:**
```bash
kubectl get nodes
kubectl get nodes -o wide
```

**Node details:**
```bash
kubectl describe node <node-name>
```

**Cordon node (prevent scheduling):**
```bash
kubectl cordon <node-name>
```
New pods won't be scheduled here, but existing pods stay.

**Drain node (maintenance):**
```bash
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```
Evicts all pods safely. Use before:
- Node upgrades
- Hardware maintenance
- Decommissioning

**Uncordon node (allow scheduling):**
```bash
kubectl uncordon <node-name>
```

**Label nodes:**
```bash
kubectl label nodes <node-name> disktype=ssd
```

**Node selectors in pods:**
```yaml
spec:
  nodeSelector:
    disktype: ssd
```

**Taints and tolerations:**
Prevent pods from scheduling on certain nodes:
```bash
kubectl taint nodes node1 key=value:NoSchedule
```
          }.strip,
          examples: [
            'kubectl get nodes',
            'kubectl describe node minikube',
            'kubectl top nodes'
          ]
        }
      },
      {
        id: 'namespace_management',
        type: 'interactive',
        content: {
          title: 'Managing Namespaces',
          explanation: %{
**Namespace Management**

Organize resources and enforce policies per namespace.

**Create namespace:**
```bash
kubectl create namespace production
kubectl create ns dev
```

**Set default namespace:**
```bash
kubectl config set-context --current --namespace=production
```

**Resource quotas per namespace:**
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: production
spec:
  hard:
    requests.cpu: "10"
    requests.memory: 20Gi
    limits.cpu: "20"
    limits.memory: 40Gi
    pods: "50"
```

**Limit ranges (default/max):**
```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
  namespace: production
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    max:
      memory: 1Gi
    type: Container
```

**Network isolation:**
Each namespace can have its own NetworkPolicies.

**RBAC per namespace:**
Roles are namespaced - isolate access!
          }.strip,
          examples: [
            'kubectl get namespaces',
            'kubectl create namespace production',
            'kubectl get resourcequota -A',
            'kubectl describe quota -n production'
          ]
        }
      }
    ]
  },

  # ============================================================
  # ADVANCED WORKLOADS
  # ============================================================
  
  'statefulsets-complete' => {
    title: 'StatefulSets: Complete Guide',
    micro_lessons: [
      {
        id: 'statefulset_overview',
        type: 'interactive',
        content: {
          title: 'Understanding StatefulSets',
          explanation: %{
**StatefulSets**

For stateful applications that need:
- Stable network identities
- Stable persistent storage
- Ordered deployment and scaling

**StatefulSet vs Deployment:**

| StatefulSet | Deployment |
|-------------|------------|
| Stable pod names (app-0, app-1) | Random names |
| Ordered startup/shutdown | Parallel |
| Stable storage per pod | Shared or random |
| For databases, queues | For stateless apps |

**Example: MongoDB cluster**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mongodb
spec:
  serviceName: mongodb
  replicas: 3
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: mongodb
        image: mongo:5.0
        ports:
        - containerPort: 27017
        volumeMounts:
        - name: data
          mountPath: /data/db
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 10Gi
```

**Pod naming:**
- mongodb-0
- mongodb-1
- mongodb-2

**DNS per pod:**
- mongodb-0.mongodb.default.svc.cluster.local
- mongodb-1.mongodb.default.svc.cluster.local

**Requires headless service!**
          }.strip,
          examples: [
            'kubectl get statefulsets',
            'kubectl get sts',
            'kubectl scale sts mongodb --replicas=5'
          ]
        }
      }
    ]
  },

  'daemonsets-complete' => {
    title: 'DaemonSets: Complete Guide',
    micro_lessons: [
      {
        id: 'daemonset_overview',
        type: 'interactive',
        content: {
          title: 'Understanding DaemonSets',
          explanation: %{
**DaemonSets**

Ensures a pod runs on every node (or selected nodes).

**Common use cases:**
- **Log collectors** - Fluentd, Filebeat
- **Monitoring agents** - Prometheus Node Exporter
- **Storage daemons** - Ceph, GlusterFS
- **Network plugins** - CNI agents
- **Security agents** - Falco

**Example: Node monitoring**
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      hostNetwork: true
      containers:
      - name: node-exporter
        image: prom/node-exporter:latest
        ports:
        - containerPort: 9100
```

**Automatic behavior:**
- New node added → Pod automatically created
- Node removed → Pod automatically deleted

**Node selection:**
```yaml
spec:
  template:
    spec:
      nodeSelector:
        disktype: ssd
```

Or use tolerations to run on master nodes:
```yaml
tolerations:
- key: node-role.kubernetes.io/master
  effect: NoSchedule
```

**Update strategy:**
- RollingUpdate (default)
- OnDelete
          }.strip,
          examples: [
            'kubectl get daemonsets',
            'kubectl get ds',
            'kubectl get ds -A'
          ]
        }
      }
    ]
  },

  'jobs-complete' => {
    title: 'Jobs and CronJobs: Complete Guide',
    micro_lessons: [
      {
        id: 'jobs_overview',
        type: 'interactive',
        content: {
          title: 'Understanding Jobs',
          explanation: %{
**Jobs**

Run containers to completion (not continuously like Deployments).

**Use cases:**
- Data processing
- Batch jobs
- Database migrations
- Backups
- One-time tasks

**Example Job:**
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pi-calculation
spec:
  completions: 3      # Run 3 times
  parallelism: 2      # Run 2 at a time
  template:
    spec:
      restartPolicy: Never
      containers:
      - name: pi
        image: perl:slim
        command: ["perl", "-Mbignum=bpi", "-wle", "print bpi(2000)"]
```

**Job patterns:**
1. **Single completion** - Run once
2. **Fixed completions** - Run N times
3. **Work queue** - Process items from queue

**Restart policies:**
- Never - Don't restart on failure
- OnFailure - Restart failed container

**Cleanup:**
```yaml
ttlSecondsAfterFinished: 100  # Auto-delete after 100s
```

**Monitor jobs:**
```bash
kubectl get jobs
kubectl describe job pi-calculation
kubectl logs job/pi-calculation
```
          }.strip,
          examples: [
            'kubectl get jobs',
            'kubectl describe job pi-calculation',
            'kubectl logs job/pi-calculation'
          ]
        }
      },
      {
        id: 'cronjobs_overview',
        type: 'interactive',
        content: {
          title: 'Understanding CronJobs',
          explanation: %{
**CronJobs**

Schedule jobs to run at specific times. Like cron on Linux.

**Example: Daily backup**
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: daily-backup
spec:
  schedule: "0 2 * * *"  # 2 AM daily
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: OnFailure
          containers:
          - name: backup
            image: backup-tool:latest
            command: ["/backup.sh"]
```

**Cron schedule format:**
```
# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of week (0 - 6)
# │ │ │ │ │
  * * * * *
```

**Common schedules:**
- `*/5 * * * *` - Every 5 minutes
- `0 * * * *` - Every hour
- `0 0 * * *` - Daily at midnight
- `0 0 * * 0` - Weekly on Sunday
- `0 0 1 * *` - Monthly on 1st

**Job history:**
```yaml
successfulJobsHistoryLimit: 3
failedJobsHistoryLimit: 1
```

**Concurrency:**
```yaml
concurrencyPolicy: Forbid  # Don't run if previous still running
# Or: Allow, Replace
```
          }.strip,
          examples: [
            'kubectl get cronjobs',
            'kubectl get cj',
            'kubectl describe cronjob daily-backup'
          ]
        }
      }
    ]
  },

  }.freeze
  
  # Multi-step labs with prerequisites
  LABS = [
    {
      id: 'lab_deploy_and_expose',
      title: 'Lab: Deploy and Expose an Application',
      scenario: 'You need to deploy an nginx application with 3 replicas and make it accessible via a service.',
      objectives: [
        'Create a deployment with 3 replicas',
        'Verify all pods are running',
        'Create a service to expose the deployment',
        'Verify the service has endpoints'
      ],
      requires_mastery: ['kubectl create deployment', 'kubectl get pods', 'kubectl expose'],
      steps: [
        {
          instruction: "Create an nginx deployment named 'web' with 3 replicas",
          validation: { type: 'deployment_exists', name: 'web', replicas: 3 }
        },
        {
          instruction: "Verify that all 3 pods are running",
          validation: { type: 'pods_running', deployment: 'web', count: 3 }
        },
        {
          instruction: "Expose the deployment as a service on port 80",
          validation: { type: 'service_exists', name: 'web', port: 80 }
        },
        {
          instruction: "Verify the service has endpoints",
          validation: { type: 'service_has_endpoints', name: 'web' }
        }
      ]
    },
    {
      id: 'lab_troubleshoot_crashloop',
      title: 'Lab: Troubleshoot a CrashLoopBackOff',
      scenario: 'A pod is in CrashLoopBackOff state. You need to investigate why and gather information.',
      objectives: [
        'Identify the problematic pod',
        'Check the pod logs',
        'Examine previous container logs',
        'Describe the pod for events'
      ],
      requires_mastery: ['kubectl get pods', 'kubectl logs', 'kubectl describe'],
      steps: [
        {
          instruction: "List all pods and identify any in CrashLoopBackOff state",
          validation: { type: 'command_executed', command: 'kubectl get pods' }
        },
        {
          instruction: "Check the current logs of the problematic pod",
          validation: { type: 'command_executed', command: 'kubectl logs' }
        },
        {
          instruction: "Check the previous container's logs using --previous",
          validation: { type: 'command_executed', command: 'kubectl logs --previous' }
        },
        {
          instruction: "Describe the pod to see events and error details",
          validation: { type: 'command_executed', command: 'kubectl describe pod' }
        }
      ]
    }
  ].freeze
  
  # Learning progression from beginner to advanced (CKAD-focused)
  LEARNING_PATH_ORDER = [
    'containers-101',            # Foundation: What are containers?
    'kubernetes-architecture-101', # Foundation: How Kubernetes works
    'kubernetes-concepts-101',   # Foundation: How everything connects
    'pods-101',                  # Concepts: What is a Pod?
    'kubectl run',               # Create a single Pod
    'kubectl get pods',          # Inspect
    'kubectl describe',          # Inspect deeper
    'kubectl logs',              # Inspect logs
    'kubectl exec',              # Inspect interactively
    'services-101',              # Service concepts
    'kubectl get services',      # List services
    'kubectl expose',            # Expose Pods/Deployments
    'controllers-and-replicasets', # Controllers concepts
    'kubectl create deployment', # Move to controllers
    'kubectl scale',             # Scale apps
    'rollouts-and-rollback',     # Update strategies
    'probes-101',                # Health checks
    'configmaps-secrets-101',    # Application configuration
    'jobs-cronjobs-101',         # Batch and scheduled
    'multi-container-pods-101',  # Multi-container patterns
    'init-containers-101',       # Init containers
    'resource-requests-limits-101', # Resource management
    'resource-quotas-101',       # Namespace quotas
    'security-context-101',      # Security settings
    'service-accounts-101',      # Pod identity and RBAC
    'ingress-101',               # HTTP/HTTPS routing
    'network-policies-101',      # Network security
    'statefulsets-101',          # Stateful workloads
    'daemonsets-101',            # Node-level services
    'helm-basics-101',           # Package management
    'monitoring-101',            # Observability
    'advanced-debugging-101',    # Troubleshooting
    'kubectl apply',             # Declarative management
    'kubectl delete',            # Cleanup
    'kubectl get namespaces',    # Organization (advanced)
    
    # Complete Kubernetes - Advanced Topics
    'deployments-complete',      # Deep dive: Deployments
    'deployment-strategies',     # Rolling vs Recreate
    'deployment-rollouts',       # Rollout management
    'deployment-health-checks',  # Probes deep dive
    'services-deep-dive',        # Services complete
    'persistent-volumes',        # Storage: PV
    'persistent-volume-claims',  # Storage: PVC
    'storage-classes',           # Dynamic provisioning
    'ingress-complete',          # Ingress deep dive
    'network-policies-complete', # Network security
    'rbac-overview',             # RBAC basics
    'monitoring-complete',       # Metrics and Prometheus
    'logging-complete',          # Centralized logging
    'custom-resources',          # CRDs
    'operators',                 # Operator pattern
    'helm-complete',             # Helm package manager
    'kustomize',                 # Kustomize
    'gitops',                    # GitOps (ArgoCD/Flux)
    'cluster-management',        # Node and namespace management
    'statefulsets-complete',     # StatefulSets deep dive
    'daemonsets-complete',       # DaemonSets deep dive
    'jobs-complete'              # Jobs and CronJobs
  ].freeze
  
  def self.get_lesson(command)
    KUBERNETES_LESSONS[command] || generate_fallback_lesson(command)
  end
  
  def self.get_random_lesson
    command = KUBERNETES_LESSONS.keys.sample
    KUBERNETES_LESSONS[command].merge(canonical_command: command)
  end
  
  def self.get_next_lesson_for_user(user)
    # Get user's learning progress
    learned_commands = user.command_masteries
                           .where('proficiency_score > ?', 30)
                           .pluck(:canonical_command)
    
    # Find the first command in learning path they haven't learned yet
    next_command = LEARNING_PATH_ORDER.find { |cmd| !learned_commands.include?(cmd) }
    
    # Default to first lesson if nothing found or user is new
    next_command ||= LEARNING_PATH_ORDER.first
    
    lesson = KUBERNETES_LESSONS[next_command]
    lesson.merge(canonical_command: next_command)
  end
  
  def self.get_practice_content(command)
    lesson = KUBERNETES_LESSONS[command]
    return nil unless lesson
    
    {
      title: "Practice: #{command}",
      description: lesson[:practice_prompt],
      command: command
    }
  end
  
  # Micro-lesson methods
  def self.get_micro_lesson(chapter, micro_id)
    lesson = KUBERNETES_LESSONS[chapter]
    return nil unless lesson && lesson[:micro_lessons]
    
    lesson[:micro_lessons].find { |micro| micro[:id] == micro_id }
  end
  
  def self.get_first_micro_for_chapter(chapter)
    lesson = KUBERNETES_LESSONS[chapter]
    return nil unless lesson && lesson[:micro_lessons]
    
    lesson[:micro_lessons].first
  end
  
  def self.get_next_micro(chapter, current_micro_id)
    lesson = KUBERNETES_LESSONS[chapter]
    return nil unless lesson && lesson[:micro_lessons]
    
    current_index = lesson[:micro_lessons].find_index { |m| m[:id] == current_micro_id }
    return nil unless current_index
    
    lesson[:micro_lessons][current_index + 1]
  end
  
  def self.chapter_has_micros?(chapter)
    lesson = KUBERNETES_LESSONS[chapter]
    lesson && lesson[:micro_lessons].present?
  end
  
  def self.get_next_chapter_for_user(user)
    # Get chapters user has completed (all micros done)
    completed_chapters = []
    
    LEARNING_PATH_ORDER.each do |chapter|
      if chapter_has_micros?(chapter)
        # Check if all micros are completed (tracked in session or mastery)
        mastery = user.command_masteries.find_by(canonical_command: chapter)
        completed_chapters << chapter if mastery && mastery.proficiency_score >= 50
      end
    end
    
    # Find first chapter not completed
    next_chapter = LEARNING_PATH_ORDER.find { |cmd| !completed_chapters.include?(cmd) }
    
    next_chapter || LEARNING_PATH_ORDER.first
  end
  
  # Labs helpers
  def self.labs
    LABS
  end
  
  def self.get_lab(lab_id)
    LABS.find { |l| l[:id] == lab_id }
  end
  
  def self.eligible_labs_for_user(user, min_mastery: 60)
    LABS.select do |lab|
      (lab[:requires_mastery] || []).all? do |cmd|
        mastery = user.command_masteries.find_by(canonical_command: cmd)
        mastery && mastery.proficiency_score >= min_mastery
      end
    end
  end
  
  private
  
  def self.generate_fallback_lesson(command)
    {
      title: "Understanding #{command}",
      explanation: "This is a Kubernetes command used in cluster management. Practice using it to improve your skills.",
      examples: [command],
      command_to_learn: command,
      practice_prompt: "Try using the #{command} command"
    }
  end
end
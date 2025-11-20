puts "🧪 Seeding Kubernetes Hands-On Labs..."

k8s_labs = [
  # ======================
  # CKAD Labs (Application Developer)
  # ======================
  {
    title: "ConfigMaps and Secrets for App Configuration",
    description: "Create ConfigMaps and Secrets and mount them as env and volumes in a Pod",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "configuration",
    certification_exam: "CKAD",
    learning_objectives: "Use ConfigMap/Secret with envFrom, volume mounts, and manifests",
    prerequisites: ["kubectl installed", "Access to a Kubernetes cluster"],
    steps: [
      { step_number: 1, title: "Create ConfigMap", instruction: "Create a ConfigMap named app-config with KEY=VALUE", expected_command: "kubectl create configmap app-config --from-literal=KEY=VALUE", validation: "kubectl get configmap app-config -o yaml" },
      { step_number: 2, title: "Create Secret", instruction: "Create an opaque Secret named app-secret with API_KEY=demo", expected_command: "kubectl create secret generic app-secret --from-literal=API_KEY=demo", validation: "kubectl get secret app-secret -o yaml" },
      { step_number: 3, title: "Pod with envFrom", instruction: "Run a Pod named cm-demo with alpine using envFrom from app-config and app-secret", expected_command: "kubectl run cm-demo --image=alpine --restart=Never --env-from=configmap/app-config --env-from=secret/app-secret -- sh -c 'sleep 3600'", validation: "kubectl exec cm-demo -- sh -c 'printenv | grep -E \"KEY|API_KEY\"'" }
    ],
    validation_rules: { cm_created: "ConfigMap exists", secret_created: "Secret exists", pod_running: "Pod cm-demo is Running" },
    success_criteria: "Variables exposed and readable inside the Pod",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },
  {
    title: "Service Types and Load Balancing",
    description: "Expose workloads using ClusterIP, NodePort, and LoadBalancer; verify connectivity",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "networking",
    certification_exam: "CKAD",
    learning_objectives: "Create Services of different types and test network reachability",
    prerequisites: ["kubectl", "Basic Services knowledge"],
    steps: [
      { step_number: 1, title: "Deploy App", instruction: "Create deploy svc-web with 2 replicas", expected_command: "kubectl create deploy svc-web --image=nginx:1.25 --replicas=2", validation: "kubectl get deploy svc-web" },
      { step_number: 2, title: "ClusterIP Service", instruction: "Expose deployment as ClusterIP on port 80", expected_command: "kubectl expose deploy svc-web --port 80 --target-port 80 --name web", validation: "kubectl get svc web" },
      { step_number: 3, title: "NodePort Service", instruction: "Change service type to NodePort", expected_command: "kubectl patch svc web -p '{\"spec\":{\"type\":\"NodePort\"}}'", validation: "kubectl get svc web -o yaml | grep -i nodePort" }
    ],
    validation_rules: { service_created: "Service web exists", nodeport_set: "Service has nodePort" },
    success_criteria: "Service exposed and reachable via appropriate type",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 160,
    is_active: true
  },
  {
    title: "Ingress Configuration",
    description: "Configure an Ingress resource to route traffic to a backend service",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "kubernetes",
    category: "networking",
    certification_exam: "CKAD",
    learning_objectives: "Create Ingress with path rules and verify routing",
    prerequisites: ["Ingress controller installed"],
    steps: [
      { step_number: 1, title: "Backend Service", instruction: "Create deployment app and expose as ClusterIP svc app-svc:80", expected_command: "kubectl create deploy app --image=nginx:1.25 && kubectl expose deploy app --name app-svc --port 80", validation: "kubectl get svc app-svc" },
      { step_number: 2, title: "Create Ingress", instruction: "Create an Ingress route / to app-svc:80", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: networking.k8s.io/v1\nkind: Ingress\nmetadata:\n  name: app-ing\nspec:\n  rules:\n  - http:\n      paths:\n      - path: /\n        pathType: Prefix\n        backend:\n          service:\n            name: app-svc\n            port:\n              number: 80\nEOF", validation: "kubectl get ing app-ing" }
    ],
    validation_rules: { ingress_created: "Ingress app-ing exists" },
    success_criteria: "Ingress routes traffic to service",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 170,
    is_active: true
  },
  {
    title: "Build and Optimize Container Images",
    description: "Use multi-stage builds and best practices to produce optimized images",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "images",
    certification_exam: "CKAD",
    learning_objectives: "Build multi-stage images, reduce image size, follow best practices",
    prerequisites: ["Dockerfile basics", "Docker/Podman installed"],
    steps: [
      { step_number: 1, title: "Create Multi-Stage Dockerfile", instruction: "Write a multi-stage Dockerfile for a Go app producing a statically-linked binary", expected_command: "cat > Dockerfile <<'EOF'\nFROM golang:1.20 AS build\nWORKDIR /app\nRUN go env -w CGO_ENABLED=0\nRUN printf 'package main\\nimport \\\"fmt\\\"\\nfunc main(){fmt.Println(\\\"hello\\\")}' > main.go\nRUN go build -o app\nFROM alpine:3.19\nCOPY --from=build /app/app /usr/local/bin/app\nENTRYPOINT [\"/usr/local/bin/app\"]\nEOF", validation: "grep -c FROM Dockerfile" },
      { step_number: 2, title: "Build Image", instruction: "Build the image with tag ckad/app:latest", expected_command: "docker build -t ckad/app:latest .", validation: "docker images | grep ckad/app" },
      { step_number: 3, title: "Run Container", instruction: "Run the container and verify output", expected_command: "docker run --rm ckad/app:latest", validation: "docker run --rm ckad/app:latest | grep hello" }
    ],
    validation_rules: { multistage_ok: "Dockerfile uses multi-stage", built: "Image built", output_ok: "Container prints hello" },
    success_criteria: "Image builds successfully and runs printing 'hello'",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 140,
    is_active: true
  },
  {
    title: "Multi-Container Pod Patterns",
    description: "Implement sidecar and adapter patterns in a single Pod",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "kubernetes",
    category: "workloads",
    certification_exam: "CKAD",
    learning_objectives: "Create multi-container pod with sidecar and shared volumes",
    prerequisites: ["kubectl", "Basic YAML"],
    steps: [
      { step_number: 1, title: "Create Pod with Sidecar", instruction: "Create a pod mc-pod with nginx app and busybox sidecar that tails nginx access log via shared volume", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: mc-pod\nspec:\n  volumes:\n  - name: logs\n    emptyDir: {}\n  containers:\n  - name: app\n    image: nginx:1.25\n    volumeMounts:\n    - name: logs\n      mountPath: /var/log/nginx\n  - name: sidecar\n    image: busybox\n    args: ['sh','-c','tail -F /var/log/nginx/access.log']\n    volumeMounts:\n    - name: logs\n      mountPath: /var/log/nginx\nEOF", validation: "kubectl get pod mc-pod" },
      { step_number: 2, title: "Generate Traffic", instruction: "Port-forward and curl to generate access logs", expected_command: "kubectl port-forward pod/mc-pod 8080:80 & sleep 2; curl -s localhost:8080 >/dev/null", validation: "kubectl logs mc-pod -c sidecar --tail=5 | grep -E 'GET /'" }
    ],
    validation_rules: { pod_running: "Pod mc-pod Running", logs_flowing: "Sidecar sees requests" },
    success_criteria: "Sidecar container streams nginx access logs",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 160,
    is_active: true
  },
  {
    title: "Application Lifecycle Management",
    description: "Use init containers and lifecycle hooks (preStop) to manage app lifecycle",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "workloads",
    certification_exam: "CKAD",
    learning_objectives: "Configure init containers and lifecycle hooks",
    prerequisites: ["kubectl", "Basic YAML"],
    steps: [
      { step_number: 1, title: "Create Deployment with Init", instruction: "Create deploy lifecycle with an initContainer that waits for config file then starts app", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: lifecycle\nspec:\n  replicas: 1\n  selector:\n    matchLabels:\n      app: lifecycle\n  template:\n    metadata:\n      labels:\n        app: lifecycle\n    spec:\n      initContainers:\n      - name: init\n        image: busybox\n        args: ['sh','-c','echo ready > /tmp/ready; sleep 2']\n      containers:\n      - name: app\n        image: busybox\n        args: ['sh','-c','trap \"echo stopping\" TERM; echo running; sleep 3600']\n        lifecycle:\n          preStop:\n            exec:\n              command: ['sh','-c','echo preStop >> /tmp/hook']\nEOF", validation: "kubectl get deploy lifecycle" },
      { step_number: 2, title: "Trigger Shutdown", instruction: "Scale to 0 and verify preStop executed", expected_command: "kubectl scale deploy/lifecycle --replicas=0", validation: "kubectl get deploy lifecycle -o yaml | grep replicas: 0" }
    ],
    validation_rules: { deploy_created: "Deployment exists", prestop_triggered: "preStop executed" },
    success_criteria: "Init ran before app and preStop executed on termination",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },
  {
    title: "Rolling Updates and Rollback Scenarios",
    description: "Perform rolling updates on Deployments and execute rollbacks",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "workloads",
    certification_exam: "CKAD",
    learning_objectives: "Use kubectl rollout for status, pause, resume, and rollback",
    prerequisites: ["kubectl", "Basic Deployments"],
    steps: [
      { step_number: 1, title: "Create Deployment", instruction: "Create deployment web with nginx:1.23 (2 replicas)", expected_command: "kubectl create deploy web --image=nginx:1.23 --replicas=2", validation: "kubectl get deploy web" },
      { step_number: 2, title: "Rolling Update", instruction: "Update image to nginx:1.25 and watch rollout status", expected_command: "kubectl set image deploy/web nginx=nginx:1.25 && kubectl rollout status deploy/web", validation: "kubectl get deploy web -o yaml | grep nginx:1.25" },
      { step_number: 3, title: "Introduce Bad Image", instruction: "Set image to nginx:badtag and check rollout", expected_command: "kubectl set image deploy/web nginx=nginx:badtag && kubectl rollout status deploy/web --timeout=20s || true", validation: "kubectl rollout history deploy/web" },
      { step_number: 4, title: "Rollback", instruction: "Rollback to previous working version", expected_command: "kubectl rollout undo deploy/web", validation: "kubectl get deploy web -o yaml | grep nginx:1.25" }
    ],
    validation_rules: { updated_ok: "Updated to 1.25", rollback_ok: "Rollback completed" },
    success_criteria: "Deployment updated then rolled back successfully",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 160,
    is_active: true
  },
  {
    title: "Probes: Liveness and Readiness",
    description: "Configure HTTP liveness and readiness probes for a deployment",
    difficulty: "medium",
    estimated_minutes: 20,
    lab_type: "kubernetes",
    category: "observability",
    certification_exam: "CKAD",
    learning_objectives: "Set liveness/readiness probes and verify status transitions",
    prerequisites: ["Create a namespace", "Basic YAML editing"],
    steps: [
      { step_number: 1, title: "Create Deployment", instruction: "Create a deployment web with nginx:1.25, 2 replicas", expected_command: "kubectl create deploy web --image=nginx:1.25 --replicas=2", validation: "kubectl get deploy web" },
      { step_number: 2, title: "Patch Probes", instruction: "Add HTTP GET probes on / with port 80 for both liveness and readiness", expected_command: "kubectl set probe deploy/web --liveness --get-url=http://:80/ --readiness --get-url=http://:80/", validation: "kubectl get deploy web -o yaml | grep -A5 livenessProbe" },
      { step_number: 3, title: "Verify", instruction: "Ensure Pods become Ready then simulate probe failures", expected_command: "kubectl get pods -w", validation: "kubectl describe pod -l app=web | grep -i readiness" }
    ],
    validation_rules: { deployment_ready: "Deployment available", probes_configured: "Probes present in spec" },
    success_criteria: "Deployment shows Ready with correct probe configuration",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },
  {
    title: "Jobs and CronJobs",
    description: "Create a one-off Job and a CronJob to run periodic tasks",
    difficulty: "medium",
    estimated_minutes: 20,
    lab_type: "kubernetes",
    category: "workloads",
    certification_exam: "CKAD",
    learning_objectives: "Write Job and CronJob manifests and verify completions",
    prerequisites: ["kubectl", "Basic YAML"],
    steps: [
      { step_number: 1, title: "Create Job", instruction: "Job named pi that runs perl to compute pi", expected_command: "kubectl create job pi --image=perl -- perl -Mbignum=bpi -wle 'print bpi(50)'", validation: "kubectl get jobs pi" },
      { step_number: 2, title: "Create CronJob", instruction: "CronJob hello runs every minute printing date", expected_command: "kubectl create cronjob hello --image=busybox --schedule='*/1 * * * *' -- /bin/sh -c 'date; echo Hello'", validation: "kubectl get cronjob hello" }
    ],
    validation_rules: { job_complete: "Job completed", cronjob_created: "CronJob exists" },
    success_criteria: "Job completes and CronJob schedules successfully",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 120,
    is_active: true
  },
  {
    title: "Application Logging and Debugging",
    description: "Configure container logging, exec into pods, and use ephemeral containers for debug",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "kubernetes",
    category: "observability",
    certification_exam: "CKAD",
    learning_objectives: "kubectl logs, -c selection, exec, and ephemeral containers",
    prerequisites: ["kubectl", "K8s v1.25+ for ephemeral containers"],
    steps: [
      { step_number: 1, title: "Create Multi-Container Pod", instruction: "Create pod log-demo with app and logger sidecar", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: log-demo\nspec:\n  containers:\n  - name: app\n    image: busybox\n    args: ['sh','-c','while true; do echo tick; sleep 3; done']\n  - name: logger\n    image: busybox\n    args: ['sh','-c','sleep 3600']\nEOF", validation: "kubectl get pod log-demo" },
      { step_number: 2, title: "View Logs", instruction: "View logs for app container", expected_command: "kubectl logs log-demo -c app --tail=5", validation: "kubectl logs log-demo -c app --tail=5 | grep tick" },
      { step_number: 3, title: "Ephemeral Container", instruction: "Add ephemeral container debug to inspect process namespace", expected_command: "kubectl debug -it log-demo --image=busybox --target=app -- bash -lc 'echo debug' || true", validation: "kubectl get pod log-demo -o yaml | grep -i ephemeral" }
    ],
    validation_rules: { logs_ok: "App logs visible", ephemeral_ok: "Ephemeral container added" },
    success_criteria: "Logs viewed and ephemeral container used for debugging",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 170,
    is_active: true
  },
  {
    title: "Resource Management and Limits",
    description: "Set resource requests/limits and observe QoS class and throttling",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "configuration",
    certification_exam: "CKAD",
    learning_objectives: "Configure requests/limits and understand QoS classes",
    prerequisites: ["kubectl"],
    steps: [
      { step_number: 1, title: "Create Deployment", instruction: "Create deploy res-web with nginx:1.25 (2 replicas)", expected_command: "kubectl create deploy res-web --image=nginx:1.25 --replicas=2", validation: "kubectl get deploy res-web" },
      { step_number: 2, title: "Set Resources", instruction: "Set CPU request=100m limit=200m for container nginx", expected_command: "kubectl set resources deploy/res-web -c=nginx --requests=cpu=100m --limits=cpu=200m", validation: "kubectl get deploy res-web -o yaml | grep -A2 resources:" },
      { step_number: 3, title: "Check QoS", instruction: "Verify Pod QoS class is Burstable", expected_command: "kubectl get pod -l app=res-web -o jsonpath='{.items[0].status.qosClass}'", validation: "kubectl get pod -l app=res-web -o jsonpath='{.items[0].status.qosClass}' | grep -E 'Burstable|Guaranteed'" }
    ],
    validation_rules: { resources_set: "Requests/limits set", qos_ok: "QoS class reported" },
    success_criteria: "Deployment has resource limits and Pods report expected QoS",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },
  {
    title: "Application Security Contexts",
    description: "Harden application pods with runAsUser, fsGroup, and readOnlyRootFilesystem",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "security",
    certification_exam: "CKAD",
    learning_objectives: "Apply pod and container securityContext fields",
    prerequisites: ["kubectl"],
    steps: [
      { step_number: 1, title: "Create Pod", instruction: "Create pod sc-app with runAsUser=1000 and fsGroup=2000", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: sc-app\nspec:\n  securityContext:\n    runAsUser: 1000\n    fsGroup: 2000\n  containers:\n  - name: app\n    image: busybox\n    command: ['sh','-c','sleep 3600']\n    securityContext:\n      readOnlyRootFilesystem: true\n      allowPrivilegeEscalation: false\nEOF", validation: "kubectl get pod sc-app -o yaml | grep -i securityContext" },
      { step_number: 2, title: "Verify", instruction: "Confirm pod is running and security context applied", expected_command: "kubectl get pod sc-app", validation: "kubectl describe pod sc-app | grep -i RunAsUser" }
    ],
    validation_rules: { pod_running: "Pod Running", sc_applied: "securityContext present" },
    success_criteria: "Pod runs with hardened security context",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 160,
    is_active: true
  },

  # ======================
  # CKA Labs (Administrator)
  # ======================
  {
    title: "Advanced Pod Scheduling",
    description: "Use nodeSelector, affinity/anti-affinity, taints/tolerations, and priorities",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "kubernetes",
    category: "scheduling",
    certification_exam: "CKA",
    learning_objectives: "Apply multiple scheduling constraints and verify placement",
    prerequisites: ["kubectl", "Multi-node cluster"],
    steps: [
      { step_number: 1, title: "Label Nodes", instruction: "Label a worker node disk=ssd and another zone=a", expected_command: "kubectl label node $(kubectl get nodes -o name | sed -n '2p' | cut -d/ -f2) disk=ssd --overwrite && kubectl label node $(kubectl get nodes -o name | sed -n '3p' | cut -d/ -f2) zone=a --overwrite", validation: "kubectl get nodes --show-labels | grep -E 'disk=ssd|zone=a'" },
      { step_number: 2, title: "Taint Node", instruction: "Taint first worker node key=workload:NoSchedule", expected_command: "kubectl taint nodes $(kubectl get nodes -o name | sed -n '2p' | cut -d/ -f2) workload=ok:NoSchedule --overwrite || true", validation: "kubectl get nodes -o json | grep -i taints -A2" },
      { step_number: 3, title: "Schedule Pod", instruction: "Create a Pod requiring disk=ssd and tolerating taint", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: sched-demo\nspec:\n  tolerations:\n  - key: workload\n    operator: Exists\n    effect: NoSchedule\n  affinity:\n    nodeAffinity:\n      requiredDuringSchedulingIgnoredDuringExecution:\n        nodeSelectorTerms:\n        - matchExpressions:\n          - key: disk\n            operator: In\n            values: ['ssd']\n  containers:\n  - name: app\n    image: busybox\n    command: ['sh','-c','sleep 1200']\nEOF", validation: "kubectl get pod sched-demo -o wide" }
    ],
    validation_rules: { labels_set: "Node labels present", pod_scheduled: "Pod scheduled on labeled node" },
    success_criteria: "Pod schedules honoring labels and tolerations",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },
  {
    title: "Pod Disruption Budgets",
    description: "Protect availability using PDB while performing voluntary disruptions",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "scheduling",
    certification_exam: "CKA",
    learning_objectives: "Create PDB and observe effect during rollout/drain",
    prerequisites: ["kubectl", "Multi-node cluster"],
    steps: [
      { step_number: 1, title: "Create Deployment", instruction: "Create deploy api with 3 replicas", expected_command: "kubectl create deploy api --image=nginx:1.25 --replicas=3", validation: "kubectl get deploy api" },
      { step_number: 2, title: "Create PDB", instruction: "Require at least 2 available pods", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: policy/v1\nkind: PodDisruptionBudget\nmetadata:\n  name: api-pdb\nspec:\n  minAvailable: 2\n  selector:\n    matchLabels:\n      app: api\nEOF", validation: "kubectl get pdb api-pdb" },
      { step_number: 3, title: "Drain Node", instruction: "Attempt to drain a node hosting pods and observe blocking", expected_command: "kubectl get nodes | awk 'NR==2{print $1}' | xargs -I{} sh -c 'kubectl drain {} --ignore-daemonsets --delete-emptydir-data --timeout=20s || true'", validation: "kubectl get pdb api-pdb -o yaml | grep disruptionsAllowed" }
    ],
    validation_rules: { pdb_exists: "PDB created", pdb_blocks: "Disruptions limited" },
    success_criteria: "PDB prevents too many pods from being disrupted",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 160,
    is_active: true
  },
  {
    title: "RBAC: Least Privilege Access",
    description: "Create Role/RoleBinding to grant minimal permissions",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "rbac",
    certification_exam: "CKA",
    learning_objectives: "Grant namespace-scoped read access via Role/RoleBinding",
    prerequisites: ["Namespace created"],
    steps: [
      { step_number: 1, title: "Create Namespace", instruction: "Create a namespace dev", expected_command: "kubectl create ns dev", validation: "kubectl get ns dev" },
      { step_number: 2, title: "Create Role", instruction: "Role pod-reader allows get,list on pods in dev", expected_command: "kubectl -n dev create role pod-reader --verb=get --verb=list --resource=pods", validation: "kubectl -n dev get role pod-reader -o yaml" },
      { step_number: 3, title: "Bind Role", instruction: "Bind user jane to Role pod-reader", expected_command: "kubectl -n dev create rolebinding read-pods --role=pod-reader --user=jane", validation: "kubectl -n dev get rolebinding read-pods -o yaml" }
    ],
    validation_rules: { role_exists: "Role created", binding_exists: "RoleBinding created" },
    success_criteria: "User grants follow least-privilege pattern",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },
  {
    title: "Admission Controllers",
    description: "Configure and test admission controller behavior using ValidatingWebhookConfiguration",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "kubernetes",
    category: "security",
    certification_exam: "CKA",
    learning_objectives: "Understand admission phases; deploy a simple validating webhook",
    prerequisites: ["kubectl", "Cluster allowing webhooks"],
    steps: [
      { step_number: 1, title: "Create Webhook Service", instruction: "Create a placeholder service/webhook-svc (simulation)", expected_command: "kubectl create ns webhook || true; kubectl create service clusterip webhook-svc --tcp=443:443 -n webhook || true", validation: "kubectl -n webhook get svc webhook-svc" },
      { step_number: 2, title: "Apply ValidatingWebhook", instruction: "Apply a ValidatingWebhookConfiguration that targets pods (dummy)", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: admissionregistration.k8s.io/v1\nkind: ValidatingWebhookConfiguration\nmetadata:\n  name: demo-webhook\nwebhooks:\n- name: vpods.demo.local\n  rules:\n  - apiGroups: ['']\n    apiVersions: ['v1']\n    operations: ['CREATE']\n    resources: ['pods']\n  clientConfig:\n    service:\n      name: webhook-svc\n      namespace: webhook\n      path: /validate\n    caBundle: ''\n  admissionReviewVersions: ['v1']\n  sideEffects: None\n  failurePolicy: Ignore\nEOF", validation: "kubectl get validatingwebhookconfiguration demo-webhook" }
    ],
    validation_rules: { vwc_created: "Webhook configuration present" },
    success_criteria: "ValidatingWebhookConfiguration applied and visible",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },
  {
    title: "Persistent Volumes and Claims",
    description: "Create a StorageClass, PersistentVolumeClaim, and mount into a Pod",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "kubernetes",
    category: "storage",
    certification_exam: "CKA",
    learning_objectives: "Work with SC/PVC and mount to Pod",
    prerequisites: ["Cluster supports default or provided StorageClass"],
    steps: [
      { step_number: 1, title: "Create PVC", instruction: "Create a PVC named data-pvc (1Gi, ReadWriteOnce)", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: PersistentVolumeClaim\nmetadata:\n  name: data-pvc\nspec:\n  accessModes: [\"ReadWriteOnce\"]\n  resources:\n    requests:\n      storage: 1Gi\nEOF", validation: "kubectl get pvc data-pvc" },
      { step_number: 2, title: "Mount PVC", instruction: "Mount PVC at /data in a Pod named pvc-tester", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: pvc-tester\nspec:\n  containers:\n  - name: app\n    image: busybox\n    command: ['sh','-c','sleep 3600']\n    volumeMounts:\n    - name: data\n      mountPath: /data\n  volumes:\n  - name: data\n    persistentVolumeClaim:\n      claimName: data-pvc\nEOF", validation: "kubectl get pod pvc-tester" }
    ],
    validation_rules: { pvc_bound: "PVC Bound", pod_running: "Pod pvc-tester Running" },
    success_criteria: "Pod mounts PVC at /data",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 160,
    is_active: true
  },
  {
    title: "Dynamic Provisioning",
    description: "Use a StorageClass to dynamically provision PVCs and verify binding",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "storage",
    certification_exam: "CKA",
    learning_objectives: "Create StorageClass and PVC and observe PV provisioning",
    prerequisites: ["Cluster with default provisioner or local-path provisioner"],
    steps: [
      { step_number: 1, title: "Create PVC", instruction: "Create PVC dyn-pvc 1Gi ReadWriteOnce with default SC", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: PersistentVolumeClaim\nmetadata:\n  name: dyn-pvc\nspec:\n  accessModes: [\"ReadWriteOnce\"]\n  resources:\n    requests:\n      storage: 1Gi\nEOF", validation: "kubectl get pvc dyn-pvc" },
      { step_number: 2, title: "Verify PV Bound", instruction: "Check that a PV was dynamically created and bound", expected_command: "kubectl get pvc dyn-pvc -o jsonpath='{.status.phase}'", validation: "kubectl get pv | grep dyn-pvc" }
    ],
    validation_rules: { pvc_bound: "PVC phase Bound", pv_exists: "PV created" },
    success_criteria: "PVC is Bound with dynamically provisioned PV",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },
  {
    title: "Node Maintenance: Drain and Uncordon",
    description: "Safely drain a node and bring it back",
    difficulty: "medium",
    estimated_minutes: 20,
    lab_type: "kubernetes",
    category: "maintenance",
    certification_exam: "CKA",
    learning_objectives: "Use kubectl drain and uncordon with proper flags",
    prerequisites: ["Cluster with 2+ nodes"],
    steps: [
      { step_number: 1, title: "Pick Node", instruction: "Select a worker node", expected_command: "kubectl get nodes", validation: "kubectl get nodes" },
      { step_number: 2, title: "Drain", instruction: "Drain the node ignoring daemonsets and deleting local data", expected_command: "kubectl drain <NODE> --ignore-daemonsets --delete-emptydir-data", validation: "kubectl get nodes" },
      { step_number: 3, title: "Uncordon", instruction: "Mark node schedulable again", expected_command: "kubectl uncordon <NODE>", validation: "kubectl describe node <NODE> | grep -i schedulable" }
    ],
    validation_rules: { node_drained: "SchedulingDisabled", node_ready: "Ready status restored" },
    success_criteria: "Node successfully drained and uncordoned",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 140,
    is_active: true
  },
  {
    title: "etcd Backup and Restore",
    description: "Perform an etcd v3 snapshot backup and restore (simulated)",
    difficulty: "hard",
    estimated_minutes: 30,
    lab_type: "kubernetes",
    category: "maintenance",
    certification_exam: "CKA",
    learning_objectives: "Use etcdctl v3 to snapshot and restore configuration",
    prerequisites: ["Cluster with control-plane access"],
    steps: [
      { step_number: 1, title: "Set ETCDCTL_API=3", instruction: "Export environment variable for etcdctl v3", expected_command: "export ETCDCTL_API=3", validation: "echo $ETCDCTL_API" },
      { step_number: 2, title: "Snapshot Save", instruction: "Run snapshot save to /tmp/etcd.db (simulated)", expected_command: "echo snapshot > /tmp/etcd.db && ls /tmp/etcd.db", validation: "ls /tmp/etcd.db" }
    ],
    validation_rules: { env_set: "ETCDCTL_API set", snap_ok: "Snapshot file exists" },
    success_criteria: "Snapshot file created and visible",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 180,
    is_active: true
  },

  # ======================
  # CKS Labs (Security)
  # ======================
  {
    title: "Network Policies: Restrict Pod Egress/Ingress",
    description: "Create NetworkPolicies to restrict traffic to a service",
    difficulty: "hard",
    estimated_minutes: 30,
    lab_type: "kubernetes",
    category: "security",
    certification_exam: "CKS",
    learning_objectives: "Apply ingress/egress NetworkPolicies and verify connectivity",
    prerequisites: ["CNI supporting NetworkPolicy"],
    steps: [
      { step_number: 1, title: "Deploy App", instruction: "Create nginx service and a busybox tester", expected_command: "kubectl create deploy web --image=nginx && kubectl expose deploy web --port 80 && kubectl run tester --image=busybox --restart=Never --command -- sleep 3600", validation: "kubectl get svc web" },
      { step_number: 2, title: "Deny All", instruction: "Apply default deny-all policy in namespace", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: networking.k8s.io/v1\nkind: NetworkPolicy\nmetadata:\n  name: default-deny\nspec:\n  podSelector: {}\n  policyTypes: [Ingress, Egress]\nEOF", validation: "kubectl get networkpolicy default-deny" },
      { step_number: 3, title: "Allow From Tester", instruction: "Allow tester to access web on port 80", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: networking.k8s.io/v1\nkind: NetworkPolicy\nmetadata:\n  name: allow-tester\nspec:\n  podSelector:\n    matchLabels:\n      app: web\n  ingress:\n  - from:\n    - podSelector:\n        matchLabels:\n          run: tester\n    ports:\n    - protocol: TCP\n      port: 80\nEOF", validation: "kubectl get networkpolicy allow-tester" }
    ],
    validation_rules: { deny_all_active: "Default deny applied", allow_rule_active: "Tester can curl web" },
    success_criteria: "Traffic is restricted except from allowed source",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },
  {
    title: "Network Troubleshooting",
    description: "Diagnose service discovery and connectivity issues using common tools",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "networking",
    certification_exam: "CKA",
    learning_objectives: "Use kubectl, exec, DNS utilities to debug",
    prerequisites: ["kubectl", "dig available (busybox:1.36 or dnsutils)"],
    steps: [
      { step_number: 1, title: "Deploy App and Service", instruction: "Create deployment net-web and expose as ClusterIP web:80", expected_command: "kubectl create deploy net-web --image=nginx:1.25 && kubectl expose deploy net-web --name web --port 80", validation: "kubectl get svc web" },
      { step_number: 2, title: "Test from Busybox", instruction: "Run busybox tester and curl service via DNS name", expected_command: "kubectl run tester --image=busybox:1.36 --restart=Never --command -- sh -c 'sleep 3600' && kubectl exec tester -- wget -qO- http://web || true", validation: "kubectl logs tester --tail=1 || true" },
      { step_number: 3, title: "Inspect Endpoints", instruction: "Verify endpoints and resolve DNS name", expected_command: "kubectl get endpoints web && kubectl exec tester -- nslookup web", validation: "kubectl get endpoints web -o yaml | grep addresses -A2" }
    ],
    validation_rules: { svc_ok: "Service exists", endpoints_ok: "Endpoints present", dns_ok: "DNS resolves" },
    success_criteria: "Service responds and DNS resolves from tester pod",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 160,
    is_active: true
  },
  {
    title: "Seccomp and Read-Only Root Filesystem",
    description: "Harden a Pod with seccompProfile and readOnlyRootFilesystem",
    difficulty: "hard",
    estimated_minutes: 25,
    lab_type: "kubernetes",
    category: "runtime-security",
    certification_exam: "CKS",
    learning_objectives: "Apply Pod SecurityContext and seccomp profile",
    prerequisites: ["K8s v1.25+ recommended"],
    steps: [
      { step_number: 1, title: "Create Pod", instruction: "Pod hardened with readOnlyRootFilesystem and seccompProfile RuntimeDefault", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: hardened\nspec:\n  securityContext:\n    seccompProfile:\n      type: RuntimeDefault\n  containers:\n  - name: app\n    image: busybox\n    command: ['sh','-c','sleep 3600']\n    securityContext:\n      readOnlyRootFilesystem: true\nEOF", validation: "kubectl get pod hardened -o yaml | grep -i readOnlyRootFilesystem" }
    ],
    validation_rules: { seccomp_set: "seccompProfile present", readonly_set: "readOnlyRootFilesystem true" },
    success_criteria: "Pod runs with hardened settings",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 5,
    points_reward: 180,
    is_active: true
  },

  # ======================
  # NEW ESSENTIAL LABS - Day-to-Day Kubernetes Operations
  # ======================
  {
    title: "ConfigMap Mastery",
    description: "Master all ConfigMap creation methods, editing, and update strategies for real-world configuration management",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "kubernetes",
    category: "configuration",
    certification_exam: "CKAD",
    learning_objectives: "Create ConfigMaps from literals, files, directories, and env-files; mount as volumes and env vars; edit ConfigMaps; understand update strategies",
    prerequisites: ["kubectl installed", "Access to a Kubernetes cluster", "Basic pod concepts"],
    steps: [
      { step_number: 1, title: "Create ConfigMap from Literals", instruction: "Create a ConfigMap named app-config with KEY1=value1 and KEY2=value2 using --from-literal", expected_command: "kubectl create configmap app-config --from-literal=KEY1=value1 --from-literal=KEY2=value2", validation: "kubectl get configmap app-config -o yaml" },
      { step_number: 2, title: "Create ConfigMap from File", instruction: "Create a file config.txt with content 'database=postgres' and create ConfigMap file-config from it", expected_command: "echo 'database=postgres' > config.txt && kubectl create configmap file-config --from-file=config.txt", validation: "kubectl get configmap file-config -o yaml" },
      { step_number: 3, title: "Create ConfigMap from Env File", instruction: "Create .env file with DB_HOST=localhost and DB_PORT=5432, then create ConfigMap env-config from it", expected_command: "cat > .env <<'EOF'\nDB_HOST=localhost\nDB_PORT=5432\nEOF\nkubectl create configmap env-config --from-env-file=.env", validation: "kubectl get configmap env-config -o yaml" },
      { step_number: 4, title: "Pod with ConfigMap as Environment Variables", instruction: "Create pod cm-env-pod using nginx image that loads env-config as environment variables", expected_command: "kubectl run cm-env-pod --image=nginx:1.25 --restart=Never --dry-run=client -o yaml | kubectl apply -f - && kubectl set env pod/cm-env-pod --from=configmap/env-config", validation: "kubectl exec cm-env-pod -- printenv | grep DB_" },
      { step_number: 5, title: "Pod with ConfigMap as Volume", instruction: "Create pod cm-vol-pod using busybox that mounts file-config as volume at /config", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: cm-vol-pod\nspec:\n  containers:\n  - name: busybox\n    image: busybox\n    command: ['sh', '-c', 'sleep 3600']\n    volumeMounts:\n    - name: config-vol\n      mountPath: /config\n  volumes:\n  - name: config-vol\n    configMap:\n      name: file-config\nEOF", validation: "kubectl exec cm-vol-pod -- ls /config" },
      { step_number: 6, title: "Edit ConfigMap", instruction: "Use kubectl edit to change KEY1 value to 'updated' in app-config ConfigMap", expected_command: "kubectl edit configmap app-config", validation: "kubectl get configmap app-config -o yaml | grep 'KEY1: updated'" },
      { step_number: 7, title: "Verify Pod Sees Updated ConfigMap", instruction: "Create a new pod cm-test that uses app-config and verify it sees the updated value", expected_command: "kubectl run cm-test --image=busybox --restart=Never --env='KEY1' --env='KEY2' --dry-run=client -o yaml | kubectl apply -f - && kubectl set env pod/cm-test --from=configmap/app-config && kubectl wait --for=condition=Ready pod/cm-test --timeout=30s", validation: "kubectl exec cm-test -- sh -c 'echo $KEY1' | grep updated" }
    ],
    validation_rules: {
      literals_created: "ConfigMap from literals exists",
      file_created: "ConfigMap from file exists",
      env_file_created: "ConfigMap from env-file exists",
      env_pod_running: "Pod with env vars running",
      vol_pod_running: "Pod with volume mount running",
      configmap_edited: "ConfigMap was edited successfully",
      pod_sees_update: "New pod sees updated ConfigMap values"
    },
    success_criteria: "All ConfigMap creation methods mastered, editing works, pods can consume ConfigMaps via env and volumes",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 8,
    points_reward: 200,
    is_active: true
  },
  {
    title: "Complete Service Types Deep Dive",
    description: "Master all Kubernetes service types: ClusterIP, NodePort, LoadBalancer, Headless, and multi-port services",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "kubernetes",
    category: "networking",
    certification_exam: "CKAD",
    learning_objectives: "Create and test all service types; understand use cases; use kubectl edit to change service types; configure multi-port services",
    prerequisites: ["kubectl installed", "Kubernetes cluster", "Basic networking knowledge"],
    steps: [
      { step_number: 1, title: "Deploy Application", instruction: "Create deployment web-app with nginx:1.25 image and 3 replicas", expected_command: "kubectl create deployment web-app --image=nginx:1.25 --replicas=3", validation: "kubectl get deployment web-app -o yaml | grep 'replicas: 3'" },
      { step_number: 2, title: "ClusterIP Service", instruction: "Expose web-app as ClusterIP service on port 80 named web-clusterip", expected_command: "kubectl expose deployment web-app --port=80 --target-port=80 --name=web-clusterip --type=ClusterIP", validation: "kubectl get service web-clusterip -o yaml | grep 'type: ClusterIP'" },
      { step_number: 3, title: "Test ClusterIP Internally", instruction: "Create test pod and curl the ClusterIP service to verify internal connectivity", expected_command: "kubectl run test-pod --image=curlimages/curl:latest --restart=Never --rm -it -- curl -s web-clusterip", validation: "kubectl run test-pod --image=curlimages/curl:latest --restart=Never --rm -it -- curl -s web-clusterip | grep nginx" },
      { step_number: 4, title: "NodePort Service", instruction: "Create NodePort service for web-app on port 80 named web-nodeport", expected_command: "kubectl expose deployment web-app --port=80 --target-port=80 --name=web-nodeport --type=NodePort", validation: "kubectl get service web-nodeport -o yaml | grep 'type: NodePort'" },
      { step_number: 5, title: "Verify NodePort", instruction: "Get the NodePort value and verify it's in the 30000-32767 range", expected_command: "kubectl get service web-nodeport -o jsonpath='{.spec.ports[0].nodePort}'", validation: "kubectl get service web-nodeport -o yaml | grep nodePort" },
      { step_number: 6, title: "Headless Service", instruction: "Create headless service (ClusterIP: None) for web-app named web-headless", expected_command: "kubectl expose deployment web-app --port=80 --target-port=80 --name=web-headless --cluster-ip=None", validation: "kubectl get service web-headless -o yaml | grep 'clusterIP: None'" },
      { step_number: 7, title: "Verify Headless DNS", instruction: "Query DNS for headless service to see individual pod IPs instead of single cluster IP", expected_command: "kubectl run dns-test --image=busybox --restart=Never --rm -it -- nslookup web-headless", validation: "kubectl run dns-test --image=busybox --restart=Never --rm -it -- nslookup web-headless | grep Address" },
      { step_number: 8, title: "Multi-Port Service", instruction: "Create deployment multi-app with nginx, then expose it with multiple ports (80 and 443) named multi-svc", expected_command: "kubectl create deployment multi-app --image=nginx:1.25 && kubectl expose deployment multi-app --name=multi-svc --port=80,443 --target-port=80,443", validation: "kubectl get service multi-svc -o yaml | grep -c port: | grep 2" },
      { step_number: 9, title: "Edit Service Type", instruction: "Use kubectl edit to change web-clusterip from ClusterIP to NodePort", expected_command: "kubectl edit service web-clusterip", validation: "kubectl get service web-clusterip -o yaml | grep 'type: NodePort'" },
      { step_number: 10, title: "Cleanup and Verify", instruction: "Delete all services created in this lab", expected_command: "kubectl delete service web-clusterip web-nodeport web-headless multi-svc", validation: "kubectl get services | grep -v kubernetes | wc -l | grep 0" }
    ],
    validation_rules: {
      deployment_created: "web-app deployment exists with 3 replicas",
      clusterip_works: "ClusterIP service created and accessible internally",
      nodeport_works: "NodePort service created with valid port",
      headless_works: "Headless service returns multiple pod IPs",
      multiport_works: "Multi-port service has 2 ports",
      edit_successful: "Service type changed via kubectl edit"
    },
    success_criteria: "All service types created and tested; understand differences and use cases; can edit services",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 10,
    points_reward: 220,
    is_active: true
  },
  {
    title: "Deployment Lifecycle Operations",
    description: "Master deployment operations: scaling, pausing, resuming, restarting, rollback, and editing deployments",
    difficulty: "medium",
    estimated_minutes: 40,
    lab_type: "kubernetes",
    category: "workloads",
    certification_exam: "CKAD",
    learning_objectives: "Scale deployments up/down; pause and resume rollouts; perform restarts; rollback to previous versions; edit deployments safely",
    prerequisites: ["kubectl installed", "Kubernetes cluster", "Understanding of deployments"],
    steps: [
      { step_number: 1, title: "Create Initial Deployment", instruction: "Create deployment lifecycle-app with nginx:1.24 image and 2 replicas", expected_command: "kubectl create deployment lifecycle-app --image=nginx:1.24 --replicas=2", validation: "kubectl get deployment lifecycle-app -o yaml | grep 'replicas: 2'" },
      { step_number: 2, title: "Verify Rollout Status", instruction: "Check rollout status to ensure deployment completed successfully", expected_command: "kubectl rollout status deployment/lifecycle-app", validation: "kubectl rollout status deployment/lifecycle-app | grep 'successfully rolled out'" },
      { step_number: 3, title: "Scale Up", instruction: "Scale lifecycle-app deployment to 5 replicas", expected_command: "kubectl scale deployment lifecycle-app --replicas=5", validation: "kubectl get deployment lifecycle-app -o yaml | grep 'replicas: 5'" },
      { step_number: 4, title: "Verify Scaling", instruction: "Wait for all 5 replicas to be ready", expected_command: "kubectl wait --for=condition=available --timeout=60s deployment/lifecycle-app", validation: "kubectl get deployment lifecycle-app -o jsonpath='{.status.readyReplicas}' | grep 5" },
      { step_number: 5, title: "Update Image", instruction: "Update deployment to use nginx:1.25 image", expected_command: "kubectl set image deployment/lifecycle-app nginx=nginx:1.25", validation: "kubectl get deployment lifecycle-app -o yaml | grep 'image: nginx:1.25'" },
      { step_number: 6, title: "Pause Rollout", instruction: "Pause the rollout while it's in progress", expected_command: "kubectl rollout pause deployment/lifecycle-app", validation: "kubectl rollout status deployment/lifecycle-app | grep paused" },
      { step_number: 7, title: "Resume Rollout", instruction: "Resume the paused rollout", expected_command: "kubectl rollout resume deployment/lifecycle-app", validation: "kubectl rollout status deployment/lifecycle-app | grep 'successfully rolled out'" },
      { step_number: 8, title: "Check Rollout History", instruction: "View rollout history to see all revisions", expected_command: "kubectl rollout history deployment/lifecycle-app", validation: "kubectl rollout history deployment/lifecycle-app | grep -c REVISION | grep -E '[2-9]'" },
      { step_number: 9, title: "Rollback to Previous Version", instruction: "Rollback deployment to previous revision (nginx:1.24)", expected_command: "kubectl rollout undo deployment/lifecycle-app", validation: "kubectl get deployment lifecycle-app -o yaml | grep 'image: nginx:1.24'" },
      { step_number: 10, title: "Rollback to Specific Revision", instruction: "Rollback to revision 2 (nginx:1.25)", expected_command: "kubectl rollout undo deployment/lifecycle-app --to-revision=2", validation: "kubectl get deployment lifecycle-app -o yaml | grep 'image: nginx:1.25'" },
      { step_number: 11, title: "Edit Deployment", instruction: "Use kubectl edit to change replicas to 3", expected_command: "kubectl edit deployment lifecycle-app", validation: "kubectl get deployment lifecycle-app -o yaml | grep 'replicas: 3'" },
      { step_number: 12, title: "Restart Deployment", instruction: "Perform a rolling restart of all pods without changing image", expected_command: "kubectl rollout restart deployment/lifecycle-app", validation: "kubectl rollout status deployment/lifecycle-app | grep 'successfully rolled out'" },
      { step_number: 13, title: "Scale Down", instruction: "Scale deployment down to 1 replica", expected_command: "kubectl scale deployment lifecycle-app --replicas=1", validation: "kubectl get deployment lifecycle-app -o jsonpath='{.spec.replicas}' | grep 1" },
      { step_number: 14, title: "Verify Final State", instruction: "Confirm exactly 1 pod is running for lifecycle-app", expected_command: "kubectl get pods -l app=lifecycle-app --no-headers | wc -l | grep 1", validation: "kubectl get deployment lifecycle-app -o jsonpath='{.status.readyReplicas}' | grep 1" }
    ],
    validation_rules: {
      deployment_created: "Initial deployment created with 2 replicas",
      scaled_up: "Successfully scaled to 5 replicas",
      image_updated: "Image updated to nginx:1.25",
      pause_resume_works: "Rollout paused and resumed successfully",
      rollback_works: "Rollback to previous version successful",
      edit_works: "Deployment edited via kubectl edit",
      restart_works: "Rolling restart completed",
      scaled_down: "Final state is 1 replica"
    },
    success_criteria: "Mastered all deployment lifecycle operations: scale, pause/resume, rollback, edit, restart",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 14,
    points_reward: 250,
    is_active: true
  },
  {
    title: "kubectl edit Mastery",
    description: "Master editing Kubernetes resources with kubectl edit; understand immutable fields and safe editing practices",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "kubernetes",
    category: "operations",
    certification_exam: "CKAD",
    learning_objectives: "Use kubectl edit for deployments, services, configmaps, secrets; understand immutable fields; learn safe editing workflow",
    prerequisites: ["kubectl installed", "Kubernetes cluster", "Basic knowledge of Kubernetes resources"],
    steps: [
      { step_number: 1, title: "Create Test Resources", instruction: "Create deployment edit-deploy (nginx:1.24, 2 replicas), service edit-svc (ClusterIP, port 80), and configmap edit-cm (KEY=value)", expected_command: "kubectl create deployment edit-deploy --image=nginx:1.24 --replicas=2 && kubectl expose deployment edit-deploy --name=edit-svc --port=80 && kubectl create configmap edit-cm --from-literal=KEY=value", validation: "kubectl get deployment,service,configmap | grep edit-" },
      { step_number: 2, title: "Edit Deployment - Change Replicas", instruction: "Use kubectl edit to change edit-deploy replicas from 2 to 4", expected_command: "kubectl edit deployment edit-deploy", validation: "kubectl get deployment edit-deploy -o yaml | grep 'replicas: 4'" },
      { step_number: 3, title: "Edit Deployment - Change Image", instruction: "Use kubectl edit to update image to nginx:1.25", expected_command: "kubectl edit deployment edit-deploy", validation: "kubectl get deployment edit-deploy -o yaml | grep 'image: nginx:1.25'" },
      { step_number: 4, title: "Edit Service - Change Type", instruction: "Use kubectl edit to change edit-svc from ClusterIP to NodePort", expected_command: "kubectl edit service edit-svc", validation: "kubectl get service edit-svc -o yaml | grep 'type: NodePort'" },
      { step_number: 5, title: "Edit Service - Add Port", instruction: "Use kubectl edit to add port 443 to edit-svc (alongside port 80)", expected_command: "kubectl edit service edit-svc", validation: "kubectl get service edit-svc -o yaml | grep -c 'port: 443' | grep 1" },
      { step_number: 6, title: "Edit ConfigMap", instruction: "Use kubectl edit to change KEY value to 'updated' in edit-cm", expected_command: "kubectl edit configmap edit-cm", validation: "kubectl get configmap edit-cm -o yaml | grep 'KEY: updated'" },
      { step_number: 7, title: "Create Secret and Edit", instruction: "Create secret edit-secret (PASSWORD=secret123) and use kubectl edit to add USERNAME=admin", expected_command: "kubectl create secret generic edit-secret --from-literal=PASSWORD=secret123 && kubectl edit secret edit-secret", validation: "kubectl get secret edit-secret -o jsonpath='{.data.USERNAME}' | base64 -d | grep admin" },
      { step_number: 8, title: "Edit Pod - Understand Immutability", instruction: "Create pod edit-pod (nginx), then try to edit its image (will fail for running pod - this demonstrates immutability)", expected_command: "kubectl run edit-pod --image=nginx:1.24", validation: "kubectl get pod edit-pod -o yaml | grep 'image: nginx:1.24'" },
      { step_number: 9, title: "Edit Deployment Strategy", instruction: "Use kubectl edit to change edit-deploy rolling update strategy maxUnavailable to 1", expected_command: "kubectl edit deployment edit-deploy", validation: "kubectl get deployment edit-deploy -o yaml | grep 'maxUnavailable: 1'" },
      { step_number: 10, title: "Verify Changes Trigger Rollout", instruction: "Confirm that editing deployment image triggered a new rollout", expected_command: "kubectl rollout history deployment/edit-deploy", validation: "kubectl rollout history deployment/edit-deploy | grep -c REVISION | grep -E '[2-9]'" }
    ],
    validation_rules: {
      resources_created: "All test resources created",
      deployment_edited: "Deployment replicas and image changed",
      service_edited: "Service type changed and port added",
      configmap_edited: "ConfigMap value updated",
      secret_edited: "Secret field added",
      pod_immutability_understood: "Pod immutability demonstrated",
      strategy_edited: "Deployment strategy modified",
      rollout_triggered: "Image change triggered rollout"
    },
    success_criteria: "Mastered kubectl edit for all resource types; understand immutable fields; know when edits trigger rollouts",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 10,
    points_reward: 200,
    is_active: true
  },
  {
    title: "Full-Stack Application Deployment",
    description: "Deploy a complete 3-tier application: React frontend, Node.js API, and PostgreSQL database with ConfigMaps, Secrets, Services, and StatefulSet",
    difficulty: "hard",
    estimated_minutes: 60,
    lab_type: "kubernetes",
    category: "applications",
    certification_exam: "CKAD",
    learning_objectives: "Deploy multi-tier application; configure inter-service communication; use StatefulSet for stateful workloads; manage configurations and secrets; perform rolling updates; scale based on load",
    prerequisites: ["kubectl installed", "Kubernetes cluster with storage class", "Understanding of deployments, services, configmaps, secrets, statefulsets"],
    steps: [
      { step_number: 1, title: "Create Namespace", instruction: "Create namespace fullstack for the application", expected_command: "kubectl create namespace fullstack", validation: "kubectl get namespace fullstack" },
      { step_number: 2, title: "Create Database Secret", instruction: "Create secret db-secret in fullstack namespace with POSTGRES_USER=appuser POSTGRES_PASSWORD=apppass123 POSTGRES_DB=appdb", expected_command: "kubectl create secret generic db-secret --from-literal=POSTGRES_USER=appuser --from-literal=POSTGRES_PASSWORD=apppass123 --from-literal=POSTGRES_DB=appdb -n fullstack", validation: "kubectl get secret db-secret -n fullstack" },
      { step_number: 3, title: "Create API ConfigMap", instruction: "Create configmap api-config in fullstack namespace with API_PORT=3000 LOG_LEVEL=info", expected_command: "kubectl create configmap api-config --from-literal=API_PORT=3000 --from-literal=LOG_LEVEL=info -n fullstack", validation: "kubectl get configmap api-config -n fullstack" },
      { step_number: 4, title: "Deploy PostgreSQL StatefulSet", instruction: "Create StatefulSet postgres with 1 replica using postgres:15-alpine image, using db-secret for env vars, with volumeClaimTemplate for 1Gi storage", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: apps/v1\nkind: StatefulSet\nmetadata:\n  name: postgres\n  namespace: fullstack\nspec:\n  serviceName: postgres-svc\n  replicas: 1\n  selector:\n    matchLabels:\n      app: postgres\n  template:\n    metadata:\n      labels:\n        app: postgres\n    spec:\n      containers:\n      - name: postgres\n        image: postgres:15-alpine\n        ports:\n        - containerPort: 5432\n        envFrom:\n        - secretRef:\n            name: db-secret\n        volumeMounts:\n        - name: postgres-data\n          mountPath: /var/lib/postgresql/data\n  volumeClaimTemplates:\n  - metadata:\n      name: postgres-data\n    spec:\n      accessModes: ['ReadWriteOnce']\n      resources:\n        requests:\n          storage: 1Gi\nEOF", validation: "kubectl get statefulset postgres -n fullstack" },
      { step_number: 5, title: "Create Database Headless Service", instruction: "Create headless service postgres-svc for StatefulSet on port 5432", expected_command: "kubectl expose statefulset postgres --name=postgres-svc --port=5432 --cluster-ip=None -n fullstack", validation: "kubectl get service postgres-svc -n fullstack -o yaml | grep 'clusterIP: None'" },
      { step_number: 6, title: "Wait for Database Ready", instruction: "Wait for postgres StatefulSet to be ready", expected_command: "kubectl wait --for=condition=ready pod/postgres-0 -n fullstack --timeout=120s", validation: "kubectl get pod postgres-0 -n fullstack -o jsonpath='{.status.phase}' | grep Running" },
      { step_number: 7, title: "Deploy API Backend", instruction: "Create deployment api with node:18-alpine image, 2 replicas, using api-config and db-secret, with DATABASE_URL=postgresql://appuser:apppass123@postgres-svc:5432/appdb", expected_command: "kubectl create deployment api --image=node:18-alpine --replicas=2 -n fullstack && kubectl set env deployment/api --from=configmap/api-config -n fullstack && kubectl set env deployment/api --from=secret/db-secret -n fullstack && kubectl set env deployment/api DATABASE_URL=postgresql://appuser:apppass123@postgres-svc:5432/appdb -n fullstack", validation: "kubectl get deployment api -n fullstack -o yaml | grep 'replicas: 2'" },
      { step_number: 8, title: "Create API Service", instruction: "Expose api deployment as ClusterIP service api-svc on port 3000", expected_command: "kubectl expose deployment api --name=api-svc --port=3000 -n fullstack", validation: "kubectl get service api-svc -n fullstack" },
      { step_number: 9, title: "Deploy Frontend", instruction: "Create deployment frontend with nginx:1.25-alpine image, 3 replicas", expected_command: "kubectl create deployment frontend --image=nginx:1.25-alpine --replicas=3 -n fullstack", validation: "kubectl get deployment frontend -n fullstack -o yaml | grep 'replicas: 3'" },
      { step_number: 10, title: "Create Frontend Service", instruction: "Expose frontend as NodePort service frontend-svc on port 80", expected_command: "kubectl expose deployment frontend --name=frontend-svc --port=80 --type=NodePort -n fullstack", validation: "kubectl get service frontend-svc -n fullstack -o yaml | grep 'type: NodePort'" },
      { step_number: 11, title: "Verify All Pods Running", instruction: "Check that all pods in fullstack namespace are running (1 postgres, 2 api, 3 frontend = 6 total)", expected_command: "kubectl get pods -n fullstack --no-headers | grep -c Running | grep 6", validation: "kubectl get pods -n fullstack --no-headers | wc -l | grep 6" },
      { step_number: 12, title: "Test Inter-Service Communication", instruction: "Create test pod and verify API can reach database", expected_command: "kubectl run test-connectivity --image=busybox --rm -it --restart=Never -n fullstack -- nslookup postgres-svc", validation: "kubectl run test-connectivity --image=busybox --rm -it --restart=Never -n fullstack -- nslookup api-svc | grep Address" },
      { step_number: 13, title: "Scale API Based on Load", instruction: "Scale api deployment to 4 replicas to handle increased load", expected_command: "kubectl scale deployment api --replicas=4 -n fullstack", validation: "kubectl get deployment api -n fullstack -o jsonpath='{.spec.replicas}' | grep 4" },
      { step_number: 14, title: "Perform Rolling Update", instruction: "Update frontend image to nginx:1.26-alpine", expected_command: "kubectl set image deployment/frontend nginx=nginx:1.26-alpine -n fullstack", validation: "kubectl get deployment frontend -n fullstack -o yaml | grep 'image: nginx:1.26-alpine'" },
      { step_number: 15, title: "Verify Rollout Completed", instruction: "Check rollout status for frontend deployment", expected_command: "kubectl rollout status deployment/frontend -n fullstack", validation: "kubectl rollout status deployment/frontend -n fullstack | grep 'successfully rolled out'" },
      { step_number: 16, title: "View All Resources", instruction: "List all resources in fullstack namespace to see the complete application stack", expected_command: "kubectl get all -n fullstack", validation: "kubectl get all -n fullstack | grep -c deployment | grep 2" }
    ],
    validation_rules: {
      namespace_created: "fullstack namespace exists",
      secrets_configs_created: "Database secret and API config created",
      database_running: "PostgreSQL StatefulSet running with persistent storage",
      api_running: "API deployment running with 2+ replicas",
      frontend_running: "Frontend deployment running with 3+ replicas",
      services_created: "All services created (postgres-svc, api-svc, frontend-svc)",
      connectivity_works: "Inter-service communication verified",
      scaling_works: "API scaled to 4 replicas",
      rollout_successful: "Frontend rolling update completed"
    },
    success_criteria: "Complete 3-tier application deployed and communicating; demonstrated scaling, rolling updates, and configuration management",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 16,
    points_reward: 300,
    is_active: true
  },
  {
    title: "Troubleshooting Kubernetes Deployments",
    description: "Debug and fix 10 common Kubernetes deployment failures: CrashLoopBackOff, ImagePullBackOff, Pending pods, failed services, and more",
    difficulty: "hard",
    estimated_minutes: 45,
    lab_type: "kubernetes",
    category: "troubleshooting",
    certification_exam: "CKA",
    learning_objectives: "Diagnose CrashLoopBackOff, ImagePullBackOff, Pending pods, OOMKilled, service connectivity issues, failed rollouts; use kubectl logs, describe, events, and debugging techniques",
    prerequisites: ["kubectl installed", "Kubernetes cluster", "Understanding of pods, deployments, services"],
    steps: [
      { step_number: 1, title: "Scenario 1: ImagePullBackOff", instruction: "Create pod bad-image with non-existent image nginx:doesnotexist999, diagnose why it fails, then fix it to use nginx:1.25", expected_command: "kubectl run bad-image --image=nginx:doesnotexist999 && kubectl describe pod bad-image | grep -i imagepull && kubectl delete pod bad-image && kubectl run bad-image --image=nginx:1.25", validation: "kubectl get pod bad-image -o jsonpath='{.status.phase}' | grep Running" },
      { step_number: 2, title: "Scenario 2: CrashLoopBackOff", instruction: "Create pod crash-pod that exits immediately (busybox with command 'exit 1'), diagnose with logs, then fix with command 'sleep 3600'", expected_command: "kubectl run crash-pod --image=busybox --command -- sh -c 'exit 1' && sleep 10 && kubectl logs crash-pod && kubectl delete pod crash-pod && kubectl run crash-pod --image=busybox --command -- sleep 3600", validation: "kubectl get pod crash-pod -o jsonpath='{.status.phase}' | grep Running" },
      { step_number: 3, title: "Scenario 3: Pending Pod - No Resources", instruction: "Create pod huge-pod requesting 1000Gi memory (will be Pending), diagnose with describe, then fix by requesting 64Mi", expected_command: "kubectl run huge-pod --image=nginx --dry-run=client -o yaml > huge-pod.yaml && echo '    resources:\n      requests:\n        memory: \"1000Gi\"' >> huge-pod.yaml && kubectl apply -f huge-pod.yaml && kubectl describe pod huge-pod | grep -i insufficient && kubectl delete pod huge-pod && kubectl run huge-pod --image=nginx --requests='memory=64Mi'", validation: "kubectl get pod huge-pod -o jsonpath='{.status.phase}' | grep Running" },
      { step_number: 4, title: "Scenario 4: Service Not Routing Traffic", instruction: "Create deployment svc-test (nginx, 2 replicas) and service with wrong selector (app=wrong), diagnose why no endpoints, fix selector to app=svc-test", expected_command: "kubectl create deployment svc-test --image=nginx --replicas=2 && kubectl expose deployment svc-test --port=80 --name=broken-svc && kubectl patch service broken-svc -p '{\"spec\":{\"selector\":{\"app\":\"wrong\"}}}' && kubectl describe service broken-svc | grep -i endpoints && kubectl patch service broken-svc -p '{\"spec\":{\"selector\":{\"app\":\"svc-test\"}}}'", validation: "kubectl get endpoints broken-svc -o yaml | grep -i 'ip:'" },
      { step_number: 5, title: "Scenario 5: Wrong Container Port", instruction: "Create deployment port-app (nginx) exposed on port 8080, but nginx listens on 80, diagnose connection failure, fix service targetPort to 80", expected_command: "kubectl create deployment port-app --image=nginx && kubectl expose deployment port-app --port=8080 --target-port=8080 --name=port-svc && kubectl patch service port-svc -p '{\"spec\":{\"ports\":[{\"port\":8080,\"targetPort\":80}]}}'", validation: "kubectl get service port-svc -o yaml | grep 'targetPort: 80'" },
      { step_number: 6, title: "Scenario 6: Failed Rollout - Bad Image", instruction: "Create deployment rollout-test (nginx:1.25), update to bad image nginx:badversion, diagnose failed rollout, rollback to previous version", expected_command: "kubectl create deployment rollout-test --image=nginx:1.25 && kubectl set image deployment/rollout-test nginx=nginx:badversion && sleep 15 && kubectl rollout status deployment/rollout-test --timeout=5s; kubectl rollout undo deployment/rollout-test", validation: "kubectl get deployment rollout-test -o yaml | grep 'image: nginx:1.25'" },
      { step_number: 7, title: "Scenario 7: ConfigMap Not Mounted", instruction: "Create configmap app-cfg (KEY=value), create pod cfg-pod that references non-existent configmap wrong-cfg (will be Pending), diagnose with describe, fix to reference app-cfg", expected_command: "kubectl create configmap app-cfg --from-literal=KEY=value && kubectl run cfg-pod --image=busybox --command sleep 3600 --dry-run=client -o yaml > cfg-pod.yaml && kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: cfg-pod\nspec:\n  containers:\n  - name: busybox\n    image: busybox\n    command: ['sleep', '3600']\n    envFrom:\n    - configMapRef:\n        name: wrong-cfg\nEOF\nkubectl describe pod cfg-pod | grep -i configmap && kubectl delete pod cfg-pod && kubectl run cfg-pod --image=busybox --command sleep 3600 && kubectl set env pod/cfg-pod --from=configmap/app-cfg", validation: "kubectl get pod cfg-pod -o jsonpath='{.status.phase}' | grep Running" },
      { step_number: 8, title: "Scenario 8: Readiness Probe Failing", instruction: "Create deployment readiness-app with failing readiness probe (httpGet on /healthz), diagnose why pods not ready, fix by changing probe path to /", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: readiness-app\nspec:\n  replicas: 2\n  selector:\n    matchLabels:\n      app: readiness-app\n  template:\n    metadata:\n      labels:\n        app: readiness-app\n    spec:\n      containers:\n      - name: nginx\n        image: nginx:1.25\n        readinessProbe:\n          httpGet:\n            path: /healthz\n            port: 80\n          initialDelaySeconds: 5\n          periodSeconds: 5\nEOF\nkubectl describe pod -l app=readiness-app | grep -i readiness && kubectl patch deployment readiness-app -p '{\"spec\":{\"template\":{\"spec\":{\"containers\":[{\"name\":\"nginx\",\"readinessProbe\":{\"httpGet\":{\"path\":\"/\",\"port\":80}}}]}}}}'", validation: "kubectl get deployment readiness-app -o jsonpath='{.status.readyReplicas}' | grep 2" },
      { step_number: 9, title: "Scenario 9: Insufficient Permissions (RBAC)", instruction: "Create serviceaccount limited-sa, try to create pod using this SA without proper RBAC (will fail API calls from pod), diagnose with kubectl auth can-i", expected_command: "kubectl create serviceaccount limited-sa && kubectl auth can-i create pods --as=system:serviceaccount:default:limited-sa", validation: "kubectl get serviceaccount limited-sa" },
      { step_number: 10, title: "Scenario 10: Node Selector Mismatch", instruction: "Create pod node-pod with nodeSelector disktype=ssd (node doesn't exist), diagnose Pending state, remove nodeSelector to fix", expected_command: "kubectl apply -f - <<'EOF'\napiVersion: v1\nkind: Pod\nmetadata:\n  name: node-pod\nspec:\n  nodeSelector:\n    disktype: ssd\n  containers:\n  - name: nginx\n    image: nginx:1.25\nEOF\nkubectl describe pod node-pod | grep -i 'no nodes' && kubectl delete pod node-pod && kubectl run node-pod --image=nginx:1.25", validation: "kubectl get pod node-pod -o jsonpath='{.status.phase}' | grep Running" }
    ],
    validation_rules: {
      imagepull_fixed: "ImagePullBackOff resolved with correct image",
      crash_fixed: "CrashLoopBackOff fixed with proper command",
      pending_fixed: "Pending pod fixed with reasonable resource requests",
      service_fixed: "Service routing fixed with correct selector",
      port_fixed: "Service targetPort corrected",
      rollout_fixed: "Failed rollout recovered via rollback",
      configmap_fixed: "ConfigMap reference corrected",
      readiness_fixed: "Readiness probe fixed, all replicas ready",
      rbac_diagnosed: "RBAC permissions diagnosed",
      nodeselector_fixed: "NodeSelector issue resolved"
    },
    success_criteria: "Successfully diagnosed and fixed all 10 common Kubernetes deployment failures",
    environment_image: "kindest/node:v1.29.0",
    required_tools: ["kubectl"],
    max_attempts: 15,
    points_reward: 280,
    is_active: true
  }
]

k8s_labs.each_with_index do |lab_data, index|
  lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
  lab.assign_attributes(lab_data)
  lab.save!
  puts "  ✔︎ Lab upserted: #{lab.title} (#{index + 1}/#{k8s_labs.length})"
end

puts "\n✅ Kubernetes labs seeding complete. Total labs: #{HandsOnLab.where(lab_type: 'kubernetes').count}"


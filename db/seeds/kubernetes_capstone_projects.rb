# Kubernetes Capstone Projects
# Three comprehensive final projects for CKAD, CKA, and CKS certification prep

puts "🎓 Seeding Kubernetes Capstone Projects..."

capstone_projects = [
  # ======================
  # CKAD CAPSTONE PROJECT
  # ======================
  {
    title: "CKAD Capstone: Deploy E-Commerce Microservices Application",
    slug: "ckad-capstone-ecommerce-microservices",
    description: "Deploy a complete e-commerce application with frontend, backend API, database, caching, and monitoring. Implement ConfigMaps, Secrets, Services, Ingress, PersistentVolumes, health checks, and resource management.",
    difficulty: "hard",
    estimated_minutes: 240, # 4 hours
    lab_type: "kubernetes",
    lab_format: "terminal",
    category: "capstone",
    certification_exam: "CKAD",
    learning_objectives: "Demonstrate mastery of application deployment, configuration management, networking, storage, and observability in Kubernetes. Apply CKAD exam skills in a real-world scenario.",
    prerequisites: [
      "kubectl installed and configured",
      "Access to a Kubernetes cluster (v1.28+)",
      "Basic understanding of microservices architecture",
      "Completed CKAD fundamentals"
    ],
    scenario_narrative: <<~SCENARIO,
      You've been hired as a Kubernetes Application Developer at ShopFast, an e-commerce startup.
      Your mission: Deploy their entire application stack to Kubernetes before the Black Friday launch.

      The application consists of:
      - React frontend (web-ui)
      - Node.js REST API (backend-api)
      - PostgreSQL database (db)
      - Redis cache (cache)
      - Nginx ingress controller

      Success means: All services running, database persistent, secrets secure, auto-scaling enabled,
      health checks configured, and the application accessible via a custom domain.
    SCENARIO
    steps: [
      {
        step_number: 1,
        title: "Create Namespaces and Labels",
        instruction: "Create namespace 'ecommerce' and label it with environment=production",
        expected_command: "kubectl create namespace ecommerce && kubectl label namespace ecommerce environment=production",
        validation: "kubectl get namespace ecommerce -o yaml | grep 'environment: production'",
        points: 10
      },
      {
        step_number: 2,
        title: "Create Database Secrets",
        instruction: "Create a Secret 'db-credentials' with POSTGRES_USER=shop_admin, POSTGRES_PASSWORD=secure_pass_123, POSTGRES_DB=ecommerce_db",
        expected_command: "kubectl create secret generic db-credentials -n ecommerce --from-literal=POSTGRES_USER=shop_admin --from-literal=POSTGRES_PASSWORD=secure_pass_123 --from-literal=POSTGRES_DB=ecommerce_db",
        validation: "kubectl get secret db-credentials -n ecommerce -o jsonpath='{.data}'",
        points: 15
      },
      {
        step_number: 3,
        title: "Create Application ConfigMap",
        instruction: "Create a ConfigMap 'app-config' with API_URL=http://backend-api:3000, CACHE_HOST=redis, LOG_LEVEL=info",
        expected_command: "kubectl create configmap app-config -n ecommerce --from-literal=API_URL=http://backend-api:3000 --from-literal=CACHE_HOST=redis --from-literal=LOG_LEVEL=info",
        validation: "kubectl get configmap app-config -n ecommerce -o yaml",
        points: 10
      },
      {
        step_number: 4,
        title: "Deploy PostgreSQL with Persistent Storage",
        instruction: "Create a PersistentVolumeClaim 'postgres-pvc' (5Gi, ReadWriteOnce) and deploy PostgreSQL using the db-credentials secret. Use postgres:15-alpine image with /var/lib/postgresql/data mounted to PVC.",
        expected_command: "kubectl apply -f postgres-deployment.yaml",
        validation: "kubectl get pod -n ecommerce -l app=postgres | grep Running && kubectl get pvc -n ecommerce postgres-pvc | grep Bound",
        points: 25
      },
      {
        step_number: 5,
        title: "Deploy Redis Cache",
        instruction: "Deploy Redis (redis:7-alpine) with 1 replica, label app=redis, expose port 6379",
        expected_command: "kubectl create deployment redis --image=redis:7-alpine --replicas=1 -n ecommerce && kubectl label deployment redis app=redis -n ecommerce && kubectl expose deployment redis --port=6379 -n ecommerce",
        validation: "kubectl get pod -n ecommerce -l app=redis | grep Running",
        points: 15
      },
      {
        step_number: 6,
        title: "Deploy Backend API",
        instruction: "Deploy backend-api (node:18-alpine) with 3 replicas. Use envFrom to load app-config and db-credentials. Add liveness probe (HTTP GET /health on port 3000) and readiness probe (HTTP GET /ready on port 3000). Set resource requests (cpu: 100m, memory: 128Mi) and limits (cpu: 500m, memory: 512Mi).",
        expected_command: "kubectl apply -f backend-api-deployment.yaml",
        validation: "kubectl get pods -n ecommerce -l app=backend-api | grep '3/3' | wc -l | grep 3",
        points: 30
      },
      {
        step_number: 7,
        title: "Create Backend Service",
        instruction: "Expose backend-api as a ClusterIP service on port 3000",
        expected_command: "kubectl expose deployment backend-api --port=3000 --name=backend-api -n ecommerce --type=ClusterIP",
        validation: "kubectl get svc backend-api -n ecommerce -o jsonpath='{.spec.type}' | grep ClusterIP",
        points: 10
      },
      {
        step_number: 8,
        title: "Deploy Frontend",
        instruction: "Deploy web-ui (nginx:1.25-alpine) with 2 replicas. Mount app-config as environment variables. Add readiness probe (HTTP GET / on port 80).",
        expected_command: "kubectl apply -f web-ui-deployment.yaml",
        validation: "kubectl get pods -n ecommerce -l app=web-ui | grep '1/1' | wc -l | grep 2",
        points: 20
      },
      {
        step_number: 9,
        title: "Create Frontend Service",
        instruction: "Expose web-ui as a NodePort service on port 80, targetPort 80",
        expected_command: "kubectl expose deployment web-ui --port=80 --target-port=80 --name=web-ui -n ecommerce --type=NodePort",
        validation: "kubectl get svc web-ui -n ecommerce -o jsonpath='{.spec.type}' | grep NodePort",
        points: 10
      },
      {
        step_number: 10,
        title: "Configure Ingress",
        instruction: "Create an Ingress resource routing shop.local/ to web-ui:80 and shop.local/api to backend-api:3000",
        expected_command: "kubectl apply -f ingress.yaml",
        validation: "kubectl get ingress -n ecommerce | grep shop.local",
        points: 20
      },
      {
        step_number: 11,
        title: "Configure HorizontalPodAutoscaler for Backend",
        instruction: "Create HPA for backend-api: min 3, max 10 replicas, target CPU 70%",
        expected_command: "kubectl autoscale deployment backend-api -n ecommerce --min=3 --max=10 --cpu-percent=70",
        validation: "kubectl get hpa backend-api -n ecommerce",
        points: 15
      },
      {
        step_number: 12,
        title: "Add Resource Quotas",
        instruction: "Create ResourceQuota for ecommerce namespace: max 20 pods, 10 CPU cores, 20Gi memory",
        expected_command: "kubectl apply -f resource-quota.yaml",
        validation: "kubectl get resourcequota -n ecommerce",
        points: 10
      },
      {
        step_number: 13,
        title: "Add Network Policy",
        instruction: "Create NetworkPolicy allowing only web-ui to access backend-api, and backend-api to access postgres and redis",
        expected_command: "kubectl apply -f network-policy.yaml",
        validation: "kubectl get networkpolicy -n ecommerce",
        points: 20
      },
      {
        step_number: 14,
        title: "Test Application Connectivity",
        instruction: "Create a test pod and verify you can curl http://web-ui and http://backend-api:3000/health",
        expected_command: "kubectl run test -n ecommerce --image=curlimages/curl:8.0.0 --rm -it --restart=Never -- curl -s http://web-ui",
        validation: "kubectl run test -n ecommerce --image=curlimages/curl:8.0.0 --rm -it --restart=Never -- curl -s http://backend-api:3000/health | grep -i ok",
        points: 15
      },
      {
        step_number: 15,
        title: "Verify Persistent Data",
        instruction: "Exec into postgres pod and verify database exists",
        expected_command: "kubectl exec -n ecommerce -it $(kubectl get pod -n ecommerce -l app=postgres -o jsonpath='{.items[0].metadata.name}') -- psql -U shop_admin -d ecommerce_db -c '\\l'",
        validation: "Database list shows ecommerce_db",
        points: 10
      },
      {
        step_number: 16,
        title: "Final Verification",
        instruction: "Run kubectl get all -n ecommerce and verify all resources are running and healthy",
        expected_command: "kubectl get all -n ecommerce",
        validation: "All pods Running, all services have endpoints, HPA configured, Ingress has address",
        points: 15
      }
    ],
    validation_rules: {
      namespace_exists: "Namespace 'ecommerce' created",
      all_pods_running: "All pods in Running state",
      pvc_bound: "PVC bound to PV",
      services_healthy: "All services have endpoints",
      ingress_configured: "Ingress routing configured",
      hpa_active: "HPA monitoring backend-api",
      secrets_secure: "Database credentials in Secrets",
      network_policy_applied: "Network policies restrict traffic"
    },
    success_criteria: "Complete e-commerce application deployed with database persistence, auto-scaling, health checks, secure configuration, and proper networking. All 16 steps completed successfully with 250+ points earned.",
    max_attempts: 3,
    points_reward: 500,
    is_active: true,
    pass_threshold: 80
  },

  # ======================
  # CKA CAPSTONE PROJECT
  # ======================
  {
    title: "CKA Capstone: Production Kubernetes Cluster Setup & Operations",
    slug: "cka-capstone-production-cluster",
    description: "Set up a production-ready Kubernetes cluster with HA control plane, configure RBAC, implement backup/restore procedures, perform cluster upgrades, troubleshoot node failures, and implement monitoring.",
    difficulty: "hard",
    estimated_minutes: 300, # 5 hours
    lab_type: "kubernetes",
    lab_format: "terminal",
    category: "capstone",
    certification_exam: "CKA",
    learning_objectives: "Demonstrate mastery of cluster architecture, installation, configuration, node management, RBAC, etcd backup/restore, cluster upgrades, and troubleshooting. Apply CKA exam skills in production scenarios.",
    prerequisites: [
      "kubectl and kubeadm installed",
      "Access to 3+ Linux nodes for cluster setup",
      "Understanding of systemd and Linux administration",
      "Completed CKA fundamentals"
    ],
    scenario_narrative: <<~SCENARIO,
      You're the new Kubernetes Administrator at FinTech Corp. The previous admin left abruptly,
      and you need to:
      1. Set up a production HA cluster from scratch
      2. Configure secure access control
      3. Implement backup/restore procedures
      4. Upgrade the cluster to the latest stable version
      5. Troubleshoot and fix a failing node
      6. Set up monitoring and ensure cluster health

      The board meeting is in 5 hours. The cluster must be production-ready.
    SCENARIO
    steps: [
      # Cluster Setup
      {step_number: 1, title: "Initialize Control Plane", instruction: "Initialize first control plane node with kubeadm (pod network CIDR: 10.244.0.0/16)", expected_command: "sudo kubeadm init --pod-network-cidr=10.244.0.0/16", validation: "kubectl get nodes", points: 30},
      {step_number: 2, title: "Install CNI Plugin", instruction: "Install Calico CNI for pod networking", expected_command: "kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml", validation: "kubectl get pods -n kube-system -l k8s-app=calico-node", points: 20},
      {step_number: 3, title: "Join Worker Nodes", instruction: "Join 2 worker nodes to the cluster", expected_command: "kubeadm join <control-plane-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>", validation: "kubectl get nodes | grep Ready | wc -l | grep 3", points: 25},
      {step_number: 4, title: "Add HA Control Plane", instruction: "Join additional control plane node for HA", expected_command: "kubeadm join <control-plane-ip>:6443 --token <token> --control-plane --certificate-key <key>", validation: "kubectl get nodes -l node-role.kubernetes.io/control-plane | wc -l | grep 2", points: 30},

      # RBAC Configuration
      {step_number: 5, title: "Create Developer Role", instruction: "Create Role 'developer' in namespace 'apps' with get/list/create/update/delete permissions for pods, deployments, services", expected_command: "kubectl create role developer --verb=get,list,create,update,delete --resource=pods,deployments,services -n apps", validation: "kubectl describe role developer -n apps", points: 20},
      {step_number: 6, title: "Create RoleBinding", instruction: "Bind 'developer' role to user 'alice' in 'apps' namespace", expected_command: "kubectl create rolebinding alice-developer --role=developer --user=alice -n apps", validation: "kubectl auth can-i create pods --as=alice -n apps", points: 15},
      {step_number: 7, title: "Create ClusterRole for Monitoring", instruction: "Create ClusterRole 'monitoring' with read-only access to all resources", expected_command: "kubectl create clusterrole monitoring --verb=get,list,watch --resource='*'", validation: "kubectl describe clusterrole monitoring", points: 15},
      {step_number: 8, title: "Service Account for CI/CD", instruction: "Create ServiceAccount 'cicd' in 'apps' namespace and bind it to 'developer' role", expected_command: "kubectl create serviceaccount cicd -n apps && kubectl create rolebinding cicd-developer --role=developer --serviceaccount=apps:cicd -n apps", validation: "kubectl get serviceaccount cicd -n apps", points: 15},

      # Backup & Restore
      {step_number: 9, title: "Backup etcd", instruction: "Create etcd snapshot backup to /backup/etcd-snapshot.db", expected_command: "ETCDCTL_API=3 etcdctl snapshot save /backup/etcd-snapshot.db --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key", validation: "ETCDCTL_API=3 etcdctl snapshot status /backup/etcd-snapshot.db", points: 25},
      {step_number: 10, title: "Verify Backup", instruction: "Verify etcd snapshot integrity", expected_command: "ETCDCTL_API=3 etcdctl snapshot status /backup/etcd-snapshot.db --write-out=table", validation: "Snapshot shows hash and size", points: 10},

      # Cluster Upgrade
      {step_number: 11, title: "Upgrade Control Plane", instruction: "Upgrade control plane from v1.28.0 to v1.29.0", expected_command: "sudo kubeadm upgrade apply v1.29.0 && sudo apt-get install -y kubelet=1.29.0-00 kubectl=1.29.0-00 && sudo systemctl restart kubelet", validation: "kubectl version --short | grep 'Server Version: v1.29'", points: 30},
      {step_number: 12, title: "Upgrade Worker Nodes", instruction: "Drain, upgrade, and uncordon worker nodes one by one", expected_command: "kubectl drain worker-1 --ignore-daemonsets && ssh worker-1 'sudo apt-get install -y kubelet=1.29.0-00 && sudo systemctl restart kubelet' && kubectl uncordon worker-1", validation: "kubectl get nodes -o wide | grep v1.29", points: 25},

      # Node Troubleshooting
      {step_number: 13, title: "Fix NotReady Node", instruction: "Troubleshoot and fix a NotReady node (check kubelet status, logs, certificates)", expected_command: "ssh node-2 'sudo systemctl status kubelet && sudo journalctl -xeu kubelet' && fix identified issue", validation: "kubectl get nodes | grep node-2 | grep Ready", points: 30},
      {step_number: 14, title: "Add Node Taints", instruction: "Taint production nodes with env=production:NoSchedule", expected_command: "kubectl taint nodes worker-1 worker-2 env=production:NoSchedule", validation: "kubectl describe node worker-1 | grep 'Taints:.*env=production:NoSchedule'", points: 15},

      # Monitoring & Health
      {step_number: 15, title: "Check Component Status", instruction: "Verify all cluster components are healthy", expected_command: "kubectl get componentstatuses && kubectl get pods -n kube-system", validation: "All components healthy, all kube-system pods Running", points: 15},
      {step_number: 16, title: "Resource Usage Analysis", instruction: "Check node resource usage and top pods", expected_command: "kubectl top nodes && kubectl top pods -A --sort-by=cpu", validation: "Resource metrics displayed", points: 10},

      # Final Verification
      {step_number: 17, title: "Deploy Test Workload", instruction: "Deploy nginx with 3 replicas, expose as NodePort, verify accessibility", expected_command: "kubectl create deployment nginx --image=nginx:1.25 --replicas=3 && kubectl expose deployment nginx --port=80 --type=NodePort", validation: "curl <node-ip>:<nodeport> returns nginx welcome page", points: 20},
      {step_number: 18, title: "Final Cluster Health Check", instruction: "Run complete cluster health check", expected_command: "kubectl get nodes && kubectl get pods -A && kubectl cluster-info", validation: "All nodes Ready, all pods Running, cluster-info shows healthy endpoints", points: 15}
    ],
    validation_rules: {
      ha_control_plane: "2+ control plane nodes running",
      all_nodes_ready: "All nodes in Ready state",
      cni_installed: "CNI plugin installed and pods can communicate",
      rbac_configured: "Roles and bindings configured correctly",
      backup_created: "etcd backup exists and is valid",
      cluster_upgraded: "Cluster running v1.29.0",
      monitoring_active: "Resource metrics available"
    },
    success_criteria: "Production HA cluster deployed with secure RBAC, backup procedures, successfully upgraded, all nodes healthy, and test workload accessible. All 18 steps completed with 365+ points earned.",
    max_attempts: 2,
    points_reward: 600,
    is_active: true,
    pass_threshold: 85
  },

  # ======================
  # CKS CAPSTONE PROJECT
  # ======================
  {
    title: "CKS Capstone: Complete Kubernetes Security Hardening",
    slug: "cks-capstone-security-hardening",
    description: "Perform comprehensive security audit and hardening of a Kubernetes cluster. Implement Pod Security Standards, network policies, image scanning, runtime security with Falco, admission control with OPA, secrets encryption, RBAC hardening, and security monitoring.",
    difficulty: "hard",
    estimated_minutes: 240, # 4 hours
    lab_type: "kubernetes",
    lab_format: "terminal",
    category: "capstone",
    certification_exam: "CKS",
    learning_objectives: "Demonstrate mastery of Kubernetes security: cluster hardening, system hardening, minimize microservice vulnerabilities, supply chain security, and monitoring/logging/runtime security. Apply CKS exam skills in real-world security scenarios.",
    prerequisites: [
      "kubectl installed and configured",
      "Access to Kubernetes cluster with admin privileges",
      "Understanding of Linux security, SELinux/AppArmor",
      "Completed CKS security fundamentals",
      "Falco, OPA Gatekeeper, and Trivy installed"
    ],
    scenario_narrative: <<~SCENARIO,
      URGENT: Security audit revealed critical vulnerabilities in CloudBank's Kubernetes cluster.
      As the Certified Kubernetes Security Specialist, you have 4 hours to harden the entire cluster
      before the regulatory review.

      Issues found:
      - Pods running as root with privileged access
      - No network segmentation
      - Unencrypted secrets at rest
      - No image vulnerability scanning
      - Weak RBAC permissions
      - No runtime security monitoring
      - Insecure admission controls

      Fix everything or the bank fails compliance and faces millions in fines.
    SCENARIO
    steps: [
      # Cluster Hardening
      {step_number: 1, title: "Enable Pod Security Standards", instruction: "Apply restricted Pod Security Standards to all namespaces except kube-system", expected_command: "kubectl label namespace default production finance pod-security.kubernetes.io/enforce=restricted pod-security.kubernetes.io/audit=restricted pod-security.kubernetes.io/warn=restricted", validation: "kubectl get namespaces -L pod-security.kubernetes.io/enforce", points: 20},
      {step_number: 2, title: "Audit Privileged Pods", instruction: "Find all pods running as root or with privileged: true", expected_command: "kubectl get pods -A -o json | jq -r '.items[] | select(.spec.containers[].securityContext.privileged == true or .spec.securityContext.runAsUser == 0) | .metadata.name'", validation: "List of privileged pods identified", points: 15},
      {step_number: 3, title: "Harden Pod Security Contexts", instruction: "Update all application pods to runAsNonRoot, drop ALL capabilities, and use readOnlyRootFilesystem", expected_command: "kubectl patch deployment <app-name> -p '{\"spec\":{\"template\":{\"spec\":{\"securityContext\":{\"runAsNonRoot\":true},\"containers\":[{\"name\":\"<container>\",\"securityContext\":{\"allowPrivilegeEscalation\":false,\"readOnlyRootFilesystem\":true,\"capabilities\":{\"drop\":[\"ALL\"]}}}]}}}}'", validation: "kubectl get pods -o yaml | grep 'runAsNonRoot: true'", points: 25},

      # Network Security
      {step_number: 4, title: "Default Deny Network Policy", instruction: "Create default deny-all ingress and egress NetworkPolicy in all namespaces", expected_command: "kubectl apply -f default-deny-networkpolicy.yaml", validation: "kubectl get networkpolicies -A", points: 20},
      {step_number: 5, title: "Whitelist Network Policies", instruction: "Create NetworkPolicies allowing only required communication: frontend->backend, backend->database", expected_command: "kubectl apply -f allow-frontend-backend-np.yaml && kubectl apply -f allow-backend-db-np.yaml", validation: "kubectl describe networkpolicy -n production", points: 25},

      # RBAC Hardening
      {step_number: 6, title: "Audit RBAC Permissions", instruction: "List all ClusterRoleBindings and identify overly permissive bindings", expected_command: "kubectl get clusterrolebindings -o json | jq -r '.items[] | select(.roleRef.name==\"cluster-admin\") | .metadata.name'", validation: "List of cluster-admin bindings", points: 15},
      {step_number: 7, title: "Remove Excessive Permissions", instruction: "Remove unnecessary cluster-admin bindings, create least-privilege roles", expected_command: "kubectl delete clusterrolebinding <excessive-binding> && kubectl create role limited-admin --verb=get,list,watch --resource=pods,services -n production", validation: "kubectl get clusterrolebindings | grep -v 'system:'", points: 20},
      {step_number: 8, title: "Service Account Security", instruction: "Disable default service account automounting in production namespace", expected_command: "kubectl patch serviceaccount default -n production -p '{\"automountServiceAccountToken\":false}'", validation: "kubectl get sa default -n production -o yaml | grep 'automountServiceAccountToken: false'", points: 15},

      # Secrets Management
      {step_number: 9, title: "Enable Secrets Encryption at Rest", instruction: "Configure encryption provider for etcd to encrypt Secrets", expected_command: "Create /etc/kubernetes/encryption-config.yaml with aescbc provider && add --encryption-provider-config to kube-apiserver", validation: "kubectl get secrets -A -o json | jq '.items[0].data' shows encrypted data", points: 30},
      {step_number: 10, title: "Rotate Encryption Keys", instruction: "Rotate encryption keys and re-encrypt all secrets", expected_command: "kubectl get secrets -A -o json | kubectl replace -f -", validation: "All secrets re-encrypted with new key", points: 20},

      # Image Security
      {step_number: 11, title: "Scan Images for Vulnerabilities", instruction: "Use Trivy to scan all container images in cluster and identify HIGH/CRITICAL vulnerabilities", expected_command: "for img in $(kubectl get pods -A -o jsonpath='{.items[*].spec.containers[*].image}' | tr ' ' '\\n' | sort -u); do trivy image --severity HIGH,CRITICAL $img; done", validation: "Vulnerability report generated", points: 25},
      {step_number: 12, title: "Implement ImagePolicyWebhook", instruction: "Configure admission controller to block images from untrusted registries", expected_command: "Configure ImagePolicyWebhook admission controller with allowed-registries: docker.io/library, gcr.io/company", validation: "kubectl run test --image=unknown-registry.com/malicious:latest fails with admission denied", points: 25},

      # Admission Control
      {step_number: 13, title: "Deploy OPA Gatekeeper", instruction: "Install OPA Gatekeeper and create ConstraintTemplate requiring resource limits", expected_command: "kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml && kubectl apply -f require-limits-constrainttemplate.yaml", validation: "kubectl get constrainttemplate", points: 25},
      {step_number: 14, title: "Enforce Security Policies", instruction: "Create Gatekeeper Constraints: no privileged pods, required labels, container limits", expected_command: "kubectl apply -f no-privileged-pods-constraint.yaml && kubectl apply -f required-labels-constraint.yaml && kubectl apply -f require-resource-limits.yaml", validation: "kubectl get constraints", points: 20},

      # Runtime Security
      {step_number: 15, title: "Deploy Falco Runtime Security", instruction: "Install Falco with default rules to detect suspicious container behavior", expected_command: "helm install falco falcosecurity/falco --set falcosidekick.enabled=true", validation: "kubectl get pods -n falco | grep Running", points: 20},
      {step_number: 16, title: "Configure Falco Custom Rules", instruction: "Add Falco rules to detect: shell spawned in container, sensitive file access, privilege escalation", expected_command: "kubectl apply -f falco-custom-rules-configmap.yaml && kubectl rollout restart daemonset falco -n falco", validation: "Falco logs show custom rules loaded", points: 20},
      {step_number: 17, title: "Test Runtime Detection", instruction: "Trigger security event by spawning shell in pod and verify Falco alert", expected_command: "kubectl exec -it test-pod -- /bin/sh && check Falco alerts", validation: "Falco alert logged for shell spawned", points: 15},

      # Audit Logging
      {step_number: 18, title: "Enable Audit Logging", instruction: "Configure comprehensive audit policy logging all metadata for sensitive resources", expected_command: "Create /etc/kubernetes/audit-policy.yaml with metadata level for secrets, configmaps, RBAC && add --audit-policy-file to kube-apiserver", validation: "Audit logs in /var/log/kubernetes/audit.log", points: 20},
      {step_number: 19, title: "Analyze Audit Logs", instruction: "Search audit logs for failed authentication attempts and unauthorized access", expected_command: "grep 'Forbidden' /var/log/kubernetes/audit.log | jq '.user.username' | sort | uniq -c", validation: "List of users with unauthorized access attempts", points: 15},

      # Final Verification
      {step_number: 20, title: "Security Compliance Check", instruction: "Run kube-bench to verify CIS Kubernetes Benchmark compliance", expected_command: "kube-bench run --targets=master,node --scored", validation: "Report shows 90%+ compliance", points: 25},
      {step_number: 21, title: "Penetration Test", instruction: "Attempt to deploy privileged pod, access secrets from wrong namespace, use excessive RBAC - all should fail", expected_command: "kubectl run priv-pod --image=nginx --privileged=true (SHOULD FAIL) && kubectl get secrets -n kube-system (SHOULD FAIL)", validation: "All malicious actions blocked", points: 20},
      {step_number: 22, title: "Final Security Audit", instruction: "Generate comprehensive security report", expected_command: "Run security scanner and generate report", validation: "All critical and high vulnerabilities mitigated, security policies enforced", points: 20}
    ],
    validation_rules: {
      pod_security_enforced: "Pod Security Standards applied to all namespaces",
      network_policies_active: "Default deny + whitelist policies configured",
      rbac_hardened: "Least-privilege RBAC, no excessive permissions",
      secrets_encrypted: "Secrets encrypted at rest",
      images_scanned: "All images scanned, no HIGH/CRITICAL vulnerabilities",
      admission_control_active: "OPA Gatekeeper policies enforcing security",
      runtime_security_monitoring: "Falco detecting suspicious activity",
      audit_logging_enabled: "Comprehensive audit logs capturing security events",
      compliance_achieved: "90%+ CIS benchmark compliance"
    },
    success_criteria: "Cluster fully hardened with Pod Security Standards, network segmentation, RBAC least-privilege, encrypted secrets, image scanning, admission control, runtime security monitoring, and audit logging. All 22 steps completed with 420+ points. Compliance achieved.",
    max_attempts: 2,
    points_reward: 800,
    is_active: true,
    pass_threshold: 85
  }
]

# Create or update the capstone projects
capstone_projects.each_with_index do |lab_data, index|
  puts "\n#{index + 1}. Creating capstone: #{lab_data[:title]}..."

  lab = HandsOnLab.find_or_initialize_by(slug: lab_data[:slug])

  lab.assign_attributes(
    title: lab_data[:title],
    description: lab_data[:description],
    difficulty: lab_data[:difficulty],
    estimated_minutes: lab_data[:estimated_minutes],
    lab_type: lab_data[:lab_type],
    lab_format: lab_data[:lab_format],
    category: lab_data[:category],
    certification_exam: lab_data[:certification_exam],
    learning_objectives: lab_data[:learning_objectives],
    prerequisites: lab_data[:prerequisites],
    scenario_narrative: lab_data[:scenario_narrative],
    steps: lab_data[:steps],
    validation_rules: lab_data[:validation_rules],
    success_criteria: lab_data[:success_criteria],
    max_attempts: lab_data[:max_attempts],
    points_reward: lab_data[:points_reward],
    is_active: lab_data[:is_active],
    pass_threshold: lab_data[:pass_threshold]
  )

  if lab.save
    puts "   ✅ Capstone project created: #{lab.title} (#{lab_data[:points_reward]} points)"
  else
    puts "   ❌ Failed: #{lab.errors.full_messages.join(', ')}"
  end
end

puts "\n" + "="*80
puts "🎓 CAPSTONE PROJECTS SUMMARY"
puts "="*80
puts "Total capstone projects: #{capstone_projects.count}"
puts "   - CKAD: E-Commerce Microservices (500 points, 4 hours)"
puts "   - CKA: Production Cluster Setup (600 points, 5 hours)"
puts "   - CKS: Security Hardening (800 points, 4 hours)"
puts "\nTotal points available: 1,900"
puts "Total estimated time: 13 hours"
puts "="*80

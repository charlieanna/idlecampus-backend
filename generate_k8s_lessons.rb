#!/usr/bin/env ruby
require 'yaml'

# K8s content templates for different topics
templates = {
  10 => {
    title: "Kubernetes Pods",
    difficulty: "easy",
    key_concepts: ["Pods", "Containers", "Pod lifecycle", "Multi-container pods"],
    content: "# Kubernetes Pods\n\nPods are the smallest deployable units in Kubernetes. A Pod represents a single instance of a running process and can contain one or more containers.\n\n## What is a Pod?\n\n- **Atomic unit** of deployment in Kubernetes\n- Can contain one or more containers\n- Containers in a Pod share network and storage\n- Each Pod gets its own IP address\n\n## Creating a Pod\n\n```yaml\napiVersion: v1\nkind: Pod\nmetadata:\n  name: nginx-pod\nspec:\n  containers:\n  - name: nginx\n    image: nginx:latest\n    ports:\n    - containerPort: 80\n```\n\n## kubectl Commands\n\n```bash\n# Create Pod\nkubectl apply -f pod.yaml\n\n# List Pods\nkubectl get pods\n\n# Describe Pod\nkubectl describe pod nginx-pod\n\n# Delete Pod\nkubectl delete pod nginx-pod\n```\n\n## Pod Lifecycle\n\n1. **Pending** - Pod accepted, containers not yet running\n2. **Running** - Pod bound to node, containers created\n3. **Succeeded** - All containers terminated successfully\n4. **Failed** - At least one container failed\n5. **Unknown** - Pod state cannot be determined\n\n## Multi-Container Pods\n\n```yaml\napiVersion: v1\nkind: Pod\nmetadata:\n  name: multi-container\nspec:\n  containers:\n  - name: app\n    image: myapp:latest\n  - name: sidecar\n    image: logger:latest\n```\n\n## Best Practices\n\n1. Use Deployments instead of bare Pods\n2. Set resource requests and limits\n3. Use health checks (liveness/readiness probes)\n4. Don't run as root\n5. Use labels for organization",
    exercises: [
      {
        type: "mcq",
        question: "What is the smallest deployable unit in Kubernetes?",
        options: ["Container", "Pod", "Deployment", "Service"],
        correct_answer: "Pod",
        explanation: "Pods are the smallest deployable units in Kubernetes. They can contain one or more containers.",
        sequence_order: 1
      }
    ]
  },
  11 => {
    title: "Kubernetes Deployments",
    difficulty: "easy",
    key_concepts: ["Deployments", "Replicas", "Rolling updates", "Rollbacks"],
    content: "# Kubernetes Deployments\n\nDeployments provide declarative updates for Pods and ReplicaSets. They manage the desired state of your application.\n\n## What is a Deployment?\n\n- Manages multiple replicas of Pods\n- Handles rolling updates\n- Supports rollbacks\n- Ensures desired number of Pods are running\n\n## Creating a Deployment\n\n```yaml\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: nginx-deployment\nspec:\n  replicas: 3\n  selector:\n    matchLabels:\n      app: nginx\n  template:\n    metadata:\n      labels:\n        app: nginx\n    spec:\n      containers:\n      - name: nginx\n        image: nginx:1.14.2\n        ports:\n        - containerPort: 80\n```\n\n## kubectl Commands\n\n```bash\n# Create Deployment\nkubectl apply -f deployment.yaml\n\n# List Deployments\nkubectl get deployments\n\n# Scale Deployment\nkubectl scale deployment nginx-deployment --replicas=5\n\n# Update image\nkubectl set image deployment/nginx-deployment nginx=nginx:1.16.1\n\n# Check rollout status\nkubectl rollout status deployment/nginx-deployment\n\n# Rollback\nkubectl rollout undo deployment/nginx-deployment\n```\n\n## Rolling Updates\n\nDeployments update Pods gradually:\n- Creates new Pods with updated spec\n- Terminates old Pods gradually\n- Zero downtime deployments\n\n## Strategies\n\n1. **RollingUpdate** (default) - Gradual replacement\n2. **Recreate** - Delete all, then create new\n\n## Best Practices\n\n1. Always use Deployments (not bare Pods)\n2. Set appropriate replica counts\n3. Use resource limits\n4. Test updates in staging first\n5. Monitor rollout status",
    exercises: [
      {
        type: "mcq",
        question: "What command scales a deployment to 5 replicas?",
        options: [
          "kubectl scale deployment nginx --replicas=5",
          "kubectl replicas nginx 5",
          "kubectl set replicas nginx 5",
          "kubectl update deployment nginx 5"
        ],
        correct_answer: "kubectl scale deployment nginx --replicas=5",
        explanation: "kubectl scale deployment <name> --replicas=<number> is the correct command to scale deployments.",
        sequence_order: 1
      }
    ]
  }
}

# Generate minimal content for remaining lessons
[17, 20, 72, 73, 79, 82].each_with_index do |lesson_num, idx|
  topics = ["Services", "ConfigMaps", "Namespaces", "Persistent Volumes", "Ingress", "kubectl Basics"]
  templates[lesson_num] = {
    title: "Kubernetes #{topics[idx]}",
    difficulty: "easy",
    key_concepts: [topics[idx]],
    content: "# Kubernetes #{topics[idx]}\n\nContent about #{topics[idx]} in Kubernetes.\n\nThis lesson covers the fundamentals of #{topics[idx]} and how to use them effectively in your Kubernetes cluster.",
    exercises: []
  }
end

puts "Generated templates for #{templates.keys.length} Kubernetes lessons"
puts "Lesson numbers: #{templates.keys.sort.join(', ')}"

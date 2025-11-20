class MiniLessonGenerator
  # Topic-specific mini-lesson templates
  MINI_LESSONS = {
    'pods' => {
      title: 'Understanding Pods',
      summary: 'Pods are the smallest deployable units in Kubernetes that contain one or more containers.',
      key_concepts: [
        'Pods are atomic units of deployment',
        'Each pod gets a unique IP address',
        'Containers in a pod share network and storage',
        'Pods are ephemeral - they can be created and destroyed'
      ],
      common_commands: [
        'kubectl get pods',
        'kubectl describe pod <pod-name>',
        'kubectl logs <pod-name>',
        'kubectl exec -it <pod-name> -- /bin/bash'
      ],
      visual_example: 'A pod is like a "wrapper" around containers, similar to how a docker-compose group relates containers.'
    },
    'deployments' => {
      title: 'Understanding Deployments',
      summary: 'Deployments manage the desired state of your application, handling rolling updates and rollbacks.',
      key_concepts: [
        'Deployments manage ReplicaSets',
        'ReplicaSets ensure desired number of pod replicas',
        'Rolling updates with zero downtime',
        'Easy rollback to previous versions'
      ],
      common_commands: [
        'kubectl create deployment <name> --image=<image>',
        'kubectl scale deployment <name> --replicas=3',
        'kubectl rollout status deployment/<name>',
        'kubectl rollout undo deployment/<name>'
      ],
      visual_example: 'Deployment → ReplicaSet → Pods (hierarchy of control)'
    },
    'services' => {
      title: 'Understanding Services',
      summary: 'Services provide stable network endpoints to access pods, abstracting away pod IP changes.',
      key_concepts: [
        'ClusterIP: Internal cluster access only',
        'NodePort: External access via node IP:port',
        'LoadBalancer: Cloud load balancer integration',
        'Services use selectors to find pods'
      ],
      common_commands: [
        'kubectl expose deployment <name> --port=80',
        'kubectl get services',
        'kubectl describe service <service-name>'
      ],
      visual_example: 'Service acts as a stable "DNS name" that load-balances to matching pods'
    },
    'configmaps' => {
      title: 'Understanding ConfigMaps',
      summary: 'ConfigMaps store non-sensitive configuration data as key-value pairs.',
      key_concepts: [
        'Separate configuration from code',
        'Can be consumed as env vars or volumes',
        'Not encrypted (use Secrets for sensitive data)',
        'Can be updated without rebuilding images'
      ],
      common_commands: [
        'kubectl create configmap <name> --from-literal=key=value',
        'kubectl create configmap <name> --from-file=config.json',
        'kubectl get configmaps',
        'kubectl describe configmap <name>'
      ],
      visual_example: 'ConfigMap = .env file or config.json for your containers'
    },
    'secrets' => {
      title: 'Understanding Secrets',
      summary: 'Secrets store sensitive data like passwords, tokens, and keys in base64-encoded format.',
      key_concepts: [
        'Base64-encoded (not encrypted by default)',
        'Can be consumed as env vars or volumes',
        'Types: Opaque, docker-registry, tls',
        'Should enable encryption at rest in production'
      ],
      common_commands: [
        'kubectl create secret generic <name> --from-literal=password=secret',
        'kubectl get secrets',
        'kubectl describe secret <name>'
      ],
      visual_example: 'Secrets = ConfigMaps but for sensitive data (passwords, API keys)'
    },
    'volumes' => {
      title: 'Understanding Volumes',
      summary: 'Volumes provide persistent storage for pods, surviving container restarts.',
      key_concepts: [
        'EmptyDir: Temporary storage, deleted when pod dies',
        'HostPath: Mount from node filesystem',
        'PersistentVolume: Cluster-wide storage resource',
        'PersistentVolumeClaim: Request for storage'
      ],
      common_commands: [
        'kubectl get pv',
        'kubectl get pvc',
        'kubectl describe pv <pv-name>'
      ],
      visual_example: 'Volume = Docker volume, but with more types and cluster-wide management'
    },
    'namespaces' => {
      title: 'Understanding Namespaces',
      summary: 'Namespaces provide logical separation and multi-tenancy within a cluster.',
      key_concepts: [
        'Default namespaces: default, kube-system, kube-public',
        'Resource quotas per namespace',
        'RBAC policies can be namespace-scoped',
        'DNS: <service>.<namespace>.svc.cluster.local'
      ],
      common_commands: [
        'kubectl get namespaces',
        'kubectl create namespace <name>',
        'kubectl get pods -n <namespace>',
        'kubectl config set-context --current --namespace=<name>'
      ],
      visual_example: 'Namespace = Virtual cluster for organizing resources'
    },
    'labels_selectors' => {
      title: 'Understanding Labels and Selectors',
      summary: 'Labels are key-value pairs attached to objects; selectors query objects by labels.',
      key_concepts: [
        'Labels organize and select resources',
        'Selectors match labels (equality or set-based)',
        'Used by Services, Deployments, etc.',
        'Best practice: app, environment, version labels'
      ],
      common_commands: [
        'kubectl get pods -l app=nginx',
        'kubectl label pod <name> env=production',
        'kubectl get pods --show-labels'
      ],
      visual_example: 'Labels = Tags on resources; Selectors = Queries to find tagged resources'
    }
  }
  
  def generate_for_question(question)
    topic_key = normalize_topic(question.topic)
    
    # Try to find matching mini-lesson
    mini_lesson = MINI_LESSONS[topic_key]
    
    if mini_lesson
      mini_lesson.merge(
        question_context: generate_context_from_question(question)
      )
    else
      # Generate generic mini-lesson
      generate_generic_mini_lesson(question)
    end
  end
  
  def generate_for_topic(topic)
    topic_key = normalize_topic(topic)
    MINI_LESSONS[topic_key] || generate_generic_mini_lesson_for_topic(topic)
  end
  
  private
  
  def normalize_topic(topic)
    return 'pods' if topic.blank?
    
    normalized = topic.to_s.downcase.strip
    
    # Map variations to standard keys
    case normalized
    when /pod/
      'pods'
    when /deployment/
      'deployments'
    when /service|networking/
      'services'
    when /configmap/
      'configmaps'
    when /secret/
      'secrets'
    when /volume|storage|pv|pvc/
      'volumes'
    when /namespace/
      'namespaces'
    when /label|selector/
      'labels_selectors'
    else
      normalized.gsub(/[^a-z_]/, '_')
    end
  end
  
  def generate_context_from_question(question)
    # Extract specific context from the question
    context = []
    
    case question.question_type
    when 'command'
      context << "This question tests your knowledge of Kubernetes commands."
      context << "The correct command is: #{question.correct_answer}"
    when 'mcq'
      context << "This is a conceptual question about #{question.topic}."
    when 'true_false'
      context << "This tests a specific fact about #{question.topic}."
    end
    
    context.join(' ')
  end
  
  def generate_generic_mini_lesson(question)
    {
      title: "Understanding #{question.topic || 'This Concept'}",
      summary: "Let's review the key concepts related to #{question.topic}.",
      key_concepts: [
        'Review the official Kubernetes documentation',
        'Practice with hands-on labs',
        'Try the command in a test cluster',
        'Ask questions in the community'
      ],
      common_commands: [],
      visual_example: 'Refer to the related lessons for detailed examples.',
      question_context: generate_context_from_question(question)
    }
  end
  
  def generate_generic_mini_lesson_for_topic(topic)
    {
      title: "Understanding #{topic}",
      summary: "This topic covers important concepts in Kubernetes.",
      key_concepts: [
        'Review the core concepts',
        'Practice with examples',
        'Test your understanding'
      ],
      common_commands: [],
      visual_example: 'See the related lessons for more details.'
    }
  end
end

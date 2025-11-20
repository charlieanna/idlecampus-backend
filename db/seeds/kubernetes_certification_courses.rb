# Kubernetes Certification Courses Seed Data
# CKA (Certified Kubernetes Administrator)
# CKAD (Certified Kubernetes Application Developer)  
# CKS (Certified Kubernetes Security)

puts "Creating Kubernetes Certification Courses..."

# ==========================================
# CKA - Certified Kubernetes Administrator
# ==========================================

cka_course = Course.find_or_create_by!(slug: 'cka-certification') do |course|
  course.title = 'CKA: Certified Kubernetes Administrator'
  course.description = 'Master Kubernetes administration and prepare for the CKA certification exam. Covers cluster architecture, workloads, services, storage, troubleshooting, and more.'
  course.difficulty_level = 'advanced'
  course.estimated_hours = 40
  course.certification_track = 'cka'
  course.published = true
  course.learning_objectives = [
    'Understand Kubernetes architecture and components',
    'Deploy and manage applications in Kubernetes',
    'Configure networking and services',
    'Manage storage and persistent volumes',
    'Troubleshoot cluster issues',
    'Perform cluster maintenance and upgrades'
  ]
  course.prerequisites = [
    'Linux Fundamentals course (recommended)',
    'Docker Fundamentals course',
    'Basic networking knowledge',
    'YAML syntax understanding'
  ]
end

puts "Created CKA course: #{cka_course.title}"

# Module 1: Cluster Architecture & Installation
cka_mod1 = CourseModule.find_or_create_by!(course: cka_course, slug: 'cluster-architecture') do |mod|
  mod.title = 'Cluster Architecture & Installation'
  mod.description = 'Learn Kubernetes architecture, components, and how to set up a production-ready cluster'
  mod.sequence_order = 1
  mod.estimated_minutes = 180
end
cka_mod1.update(published: true)

# Module 2: Workloads & Scheduling
cka_mod2 = CourseModule.find_or_create_by!(course: cka_course, slug: 'workloads-scheduling') do |mod|
  mod.title = 'Workloads & Scheduling'
  mod.description = 'Manage deployments, pods, and scheduling strategies'
  mod.sequence_order = 2
  mod.estimated_minutes = 240
end
cka_mod2.update(published: true)

# Module 3: Services & Networking
cka_mod3 = CourseModule.find_or_create_by!(course: cka_course, slug: 'services-networking') do |mod|
  mod.title = 'Services & Networking'
  mod.description = 'Configure services, ingress, network policies, and DNS'
  mod.sequence_order = 3
  mod.estimated_minutes = 200
end
cka_mod3.update(published: true)

# Module 4: Storage
cka_mod4 = CourseModule.find_or_create_by!(course: cka_course, slug: 'storage') do |mod|
  mod.title = 'Storage Management'
  mod.description = 'Work with volumes, persistent volumes, and storage classes'
  mod.sequence_order = 4
  mod.estimated_minutes = 150
end
cka_mod4.update(published: true)

# Module 5: Troubleshooting
cka_mod5 = CourseModule.find_or_create_by!(course: cka_course, slug: 'troubleshooting') do |mod|
  mod.title = 'Troubleshooting'
  mod.description = 'Debug and resolve common Kubernetes issues'
  mod.sequence_order = 5
  mod.estimated_minutes = 180
end
cka_mod5.update(published: true)

# Module 6: Cluster Maintenance
cka_mod6 = CourseModule.find_or_create_by!(course: cka_course, slug: 'cluster-maintenance') do |mod|
  mod.title = 'Cluster Maintenance'
  mod.description = 'Perform cluster maintenance tasks and upgrades'
  mod.sequence_order = 6
  mod.estimated_minutes = 120
end
cka_mod6.update(published: true)

# === CKA Module 6: Cluster Maintenance ===

# M6-1: Node Maintenance Procedures
cka_mt_l1 = CourseLesson.find_or_create_by!(title: 'Node Maintenance Procedures') do |lesson|
  lesson.content = <<~MARKDOWN
    # Node Maintenance Procedures

    - cordon/drain/uncordon
    - DaemonSets behavior and PDBs impact
  MARKDOWN
  lesson.reading_time_minutes = 15
end
cka_mt_l1_quiz = Quiz.find_or_create_by!(title: 'Node Maintenance Quiz') do |quiz|
  quiz.description = 'Cordon/drain/uncordon best practices'
  quiz.time_limit_minutes = 8
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod6, item_type: 'CourseLesson', item_id: cka_mt_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod6, item_type: 'Quiz', item_id: cka_mt_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# M6-2: etcd Backup and Restore
cka_mt_l2 = CourseLesson.find_or_create_by!(title: 'etcd Backup and Restore') do |lesson|
  lesson.content = <<~MARKDOWN
    # etcd Backup and Restore

    - etcdctl v3 snapshot save/restore
    - Certificates and endpoints
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_mt_l2_quiz = Quiz.find_or_create_by!(title: 'etcd Quiz') do |quiz|
  quiz.description = 'Snapshot and restore basics'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod6, item_type: 'CourseLesson', item_id: cka_mt_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod6, item_type: 'Quiz', item_id: cka_mt_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# M6-3: Cluster Upgrades Strategy
cka_mt_l3 = CourseLesson.find_or_create_by!(title: 'Cluster Upgrades Strategy') do |lesson|
  lesson.content = <<~MARKDOWN
    # Cluster Upgrades Strategy

    - Control plane then workers
    - Version skew policy
  MARKDOWN
  lesson.reading_time_minutes = 15
end
ModuleItem.find_or_create_by!(course_module: cka_mod6, item_type: 'CourseLesson', item_id: cka_mt_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }

# M6-4: Operating System Upgrades
cka_mt_l4 = CourseLesson.find_or_create_by!(title: 'Operating System Upgrades') do |lesson|
  lesson.content = <<~MARKDOWN
    # Operating System Upgrades

    - Node image updates
    - Kernel and container runtime considerations
  MARKDOWN
  lesson.reading_time_minutes = 15
end
ModuleItem.find_or_create_by!(course_module: cka_mod6, item_type: 'CourseLesson', item_id: cka_mt_l4.id) { |mi| mi.sequence_order = 6; mi.required = true }

# M6-5: Performance Tuning
cka_mt_l5 = CourseLesson.find_or_create_by!(title: 'Performance Tuning') do |lesson|
  lesson.content = <<~MARKDOWN
    # Performance Tuning

    - Resource limits/requests and binpacking
    - kubelet/runtime flags
  MARKDOWN
  lesson.reading_time_minutes = 15
end
ModuleItem.find_or_create_by!(course_module: cka_mod6, item_type: 'CourseLesson', item_id: cka_mt_l5.id) { |mi| mi.sequence_order = 7; mi.required = true }

# Link maintenance labs
['Node Maintenance: Drain and Uncordon', 'etcd Backup and Restore'].each_with_index do |lab_title, idx|
  if (lab = HandsOnLab.find_by(title: lab_title))
    ModuleItem.find_or_create_by!(course_module: cka_mod6, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
      mi.sequence_order = 8 + idx
      mi.required = true
    end
  end
end

# CKA Lessons
cka_lesson1 = CourseLesson.find_or_create_by!(title: 'Kubernetes Architecture Overview') do |lesson|
  lesson.content = <<~MARKDOWN
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
  lesson.reading_time_minutes = 20
end

# === CKA Module 5: Troubleshooting Content ===

# T5-1: Cluster Component Failures
cka_tr_l1 = CourseLesson.find_or_create_by!(title: 'Cluster Component Failures') do |lesson|
  lesson.content = <<~MARKDOWN
    # Cluster Component Failures

    - API server, controller-manager, scheduler symptoms
    - Logs and health endpoints
  MARKDOWN
  lesson.reading_time_minutes = 20
end
ModuleItem.find_or_create_by!(course_module: cka_mod5, item_type: 'CourseLesson', item_id: cka_tr_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }

# T5-2: Node Troubleshooting
cka_tr_l2 = CourseLesson.find_or_create_by!(title: 'Node Troubleshooting') do |lesson|
  lesson.content = <<~MARKDOWN
    # Node Troubleshooting

    - kubelet status and logs
    - NotReady nodes and taints
  MARKDOWN
  lesson.reading_time_minutes = 15
end
ModuleItem.find_or_create_by!(course_module: cka_mod5, item_type: 'CourseLesson', item_id: cka_tr_l2.id) { |mi| mi.sequence_order = 2; mi.required = true }

# T5-3: Pod and Container Debugging
cka_tr_l3 = CourseLesson.find_or_create_by!(title: 'Pod and Container Debugging') do |lesson|
  lesson.content = <<~MARKDOWN
    # Pod and Container Debugging

    - CrashLoopBackOff and ImagePullBackOff
    - kubectl describe/logs/exec, ephemeral containers
  MARKDOWN
  lesson.reading_time_minutes = 20
end
ModuleItem.find_or_create_by!(course_module: cka_mod5, item_type: 'CourseLesson', item_id: cka_tr_l3.id) { |mi| mi.sequence_order = 3; mi.required = true }

# T5-4: Networking Issues
cka_tr_l4 = CourseLesson.find_or_create_by!(title: 'Networking Issues') do |lesson|
  lesson.content = <<~MARKDOWN
    # Networking Issues

    - DNS, Services, Endpoints
    - CNI plugin diagnostics
  MARKDOWN
  lesson.reading_time_minutes = 20
end
ModuleItem.find_or_create_by!(course_module: cka_mod5, item_type: 'CourseLesson', item_id: cka_tr_l4.id) { |mi| mi.sequence_order = 4; mi.required = true }

# T5-5: Storage Problems
cka_tr_l5 = CourseLesson.find_or_create_by!(title: 'Storage Problems') do |lesson|
  lesson.content = <<~MARKDOWN
    # Storage Problems

    - Pending PVCs and provisioner logs
    - Mount failures
  MARKDOWN
  lesson.reading_time_minutes = 15
end
ModuleItem.find_or_create_by!(course_module: cka_mod5, item_type: 'CourseLesson', item_id: cka_tr_l5.id) { |mi| mi.sequence_order = 5; mi.required = true }

# T5-6: Performance Bottlenecks
cka_tr_l6 = CourseLesson.find_or_create_by!(title: 'Performance Bottlenecks') do |lesson|
  lesson.content = <<~MARKDOWN
    # Performance Bottlenecks

    - CPU/memory pressure, throttling
    - Scheduling delays and resource quotas
  MARKDOWN
  lesson.reading_time_minutes = 15
end
ModuleItem.find_or_create_by!(course_module: cka_mod5, item_type: 'CourseLesson', item_id: cka_tr_l6.id) { |mi| mi.sequence_order = 6; mi.required = true }

# Link troubleshooting lab(s)
if (lab = HandsOnLab.find_by(title: 'Network Troubleshooting'))
  ModuleItem.find_or_create_by!(course_module: cka_mod5, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 7
    mi.required = true
  end
end
# Create Quiz for Module 1
cka_quiz1 = Quiz.find_or_create_by!(title: 'Cluster Architecture Quiz') do |quiz|
  quiz.description = 'Test your knowledge of Kubernetes architecture components'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

# CKA Quiz 1 Questions
quiz_questions = [
  {
    question_type: 'mcq',
    question_text: 'Which component is responsible for storing all cluster data in Kubernetes?',
    correct_answer: 'etcd',
    options: [
      { text: 'API Server', correct: false },
      { text: 'etcd', correct: true },
      { text: 'Controller Manager', correct: false },
      { text: 'Scheduler', correct: false }
    ],
    explanation: 'etcd is a consistent and highly-available key-value store that stores all cluster data and is the single source of truth for cluster state.',
    difficulty_level: 'medium',
    points: 10
  },
  {
    question_type: 'mcq',
    question_text: 'What is the primary role of kube-scheduler?',
    correct_answer: 'Selecting nodes for pods to run on',
    options: [
      { text: 'Managing pod lifecycle', correct: false },
      { text: 'Storing cluster state', correct: false },
      { text: 'Selecting nodes for pods to run on', correct: true },
      { text: 'Implementing network policies', correct: false }
    ],
    explanation: 'kube-scheduler watches for newly created Pods with no assigned node and selects a node for them to run on based on resource requirements and constraints.',
    difficulty_level: 'medium',
    points: 10
  },
  {
    question_type: 'command',
    question_text: 'What command would you use to check the status of all control plane components?',
    correct_answer: 'kubectl get componentstatuses',
    explanation: 'The kubectl get componentstatuses command (or kubectl get cs) displays the health status of the control plane components.',
    difficulty_level: 'hard',
    points: 15
  },
  {
    question_type: 'true_false',
    question_text: 'kubelet runs on the master node only.',
    correct_answer: 'false',
    explanation: 'kubelet runs on every node in the cluster, including worker nodes. It ensures containers are running in Pods.',
    difficulty_level: 'easy',
    points: 5
  },
  {
    question_type: 'mcq',
    question_text: 'Which component implements the Kubernetes Service concept on each node?',
    correct_answer: 'kube-proxy',
    options: [
      { text: 'kubelet', correct: false },
      { text: 'kube-proxy', correct: true },
      { text: 'API Server', correct: false },
      { text: 'Controller Manager', correct: false }
    ],
    explanation: 'kube-proxy is a network proxy that runs on each node and implements the Kubernetes Service concept by maintaining network rules.',
    difficulty_level: 'medium',
    points: 10
  }
]

quiz_questions.each_with_index do |q, index|
  QuizQuestion.find_or_create_by!(quiz: cka_quiz1, sequence_order: index + 1) do |question|
    question.question_type = q[:question_type]
    question.question_text = q[:question_text]
    question.correct_answer = q[:correct_answer]
    question.options = q[:options].to_json if q[:options]
    question.explanation = q[:explanation]
    question.difficulty_level = q[:difficulty_level]
    question.points = q[:points]
  end
end

puts "Created CKA Module 1 with lesson and quiz"

# Link items to module
ModuleItem.find_or_create_by!(
  course_module: cka_mod1,
  item_type: 'CourseLesson',
  item_id: cka_lesson1.id,
  sequence_order: 1
)

ModuleItem.find_or_create_by!(
  course_module: cka_mod1,
  item_type: 'Quiz',
  item_id: cka_quiz1.id,
  sequence_order: 2
)

# Link CKA labs if available
if (lab = HandsOnLab.find_by(title: 'RBAC: Least Privilege Access'))
  ModuleItem.find_or_create_by!(course_module: cka_mod1, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 3
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Persistent Volumes and Claims'))
  ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 3
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Node Maintenance: Drain and Uncordon'))
  ModuleItem.find_or_create_by!(course_module: cka_mod5, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 3
    mi.required = true
  end
end

# === CKA Module 5: Security & RBAC ===
cka_sec_mod = CourseModule.find_or_create_by!(course: cka_course, slug: 'security-rbac') do |mod|
  mod.title = 'Security & RBAC'
  mod.description = 'Authentication, RBAC, pod security, admission, and audit'
  mod.sequence_order = 6
  mod.estimated_minutes = 180
end
cka_sec_mod.update(published: true)

# S5-1: Authentication Methods
cka_sec_l1 = CourseLesson.find_or_create_by!(title: 'Authentication Methods') do |lesson|
  lesson.content = <<~MARKDOWN
    # Authentication Methods

    - Client certs, bearer tokens, OIDC
    - API server flags and configuration
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_sec_l1_quiz = Quiz.find_or_create_by!(title: 'Authentication Quiz') do |quiz|
  quiz.description = 'Identify and configure auth methods'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'CourseLesson', item_id: cka_sec_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'Quiz', item_id: cka_sec_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# S5-2: RBAC Deep Dive
cka_sec_l2 = CourseLesson.find_or_create_by!(title: 'RBAC Deep Dive') do |lesson|
  lesson.content = <<~MARKDOWN
    # RBAC Deep Dive

    - Roles vs ClusterRoles
    - RoleBinding and ClusterRoleBinding
    - Aggregated roles
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_sec_l2_quiz = Quiz.find_or_create_by!(title: 'RBAC Quiz') do |quiz|
  quiz.description = 'Roles, bindings, and permissions'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'CourseLesson', item_id: cka_sec_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'Quiz', item_id: cka_sec_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# S5-3: Pod Security Standards
cka_sec_l3 = CourseLesson.find_or_create_by!(title: 'Pod Security Standards') do |lesson|
  lesson.content = <<~MARKDOWN
    # Pod Security Standards

    - Baseline, restricted profiles
    - Namespace-level enforcement
  MARKDOWN
  lesson.reading_time_minutes = 15
end
cka_sec_l3_quiz = Quiz.find_or_create_by!(title: 'Pod Security Quiz') do |quiz|
  quiz.description = 'Namespace policy and restricted settings'
  quiz.time_limit_minutes = 8
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'CourseLesson', item_id: cka_sec_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'Quiz', item_id: cka_sec_l3_quiz.id) { |mi| mi.sequence_order = 6; mi.required = true }

# S5-4: Admission Controllers
cka_sec_l4 = CourseLesson.find_or_create_by!(title: 'Admission Controllers') do |lesson|
  lesson.content = <<~MARKDOWN
    # Admission Controllers

    - Mutating vs Validating webhooks
    - Common built-in controllers
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_sec_l4_quiz = Quiz.find_or_create_by!(title: 'Admission Controllers Quiz') do |quiz|
  quiz.description = 'Webhook types and behavior'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'CourseLesson', item_id: cka_sec_l4.id) { |mi| mi.sequence_order = 7; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'Quiz', item_id: cka_sec_l4_quiz.id) { |mi| mi.sequence_order = 8; mi.required = true }

# S5-5: Audit Logging
cka_sec_l5 = CourseLesson.find_or_create_by!(title: 'Audit Logging') do |lesson|
  lesson.content = <<~MARKDOWN
    # Audit Logging

    - Policy configuration
    - Log backends and rotation
  MARKDOWN
  lesson.reading_time_minutes = 15
end
cka_sec_l5_quiz = Quiz.find_or_create_by!(title: 'Audit Logging Quiz') do |quiz|
  quiz.description = 'Audit policy and backends'
  quiz.time_limit_minutes = 8
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'CourseLesson', item_id: cka_sec_l5.id) { |mi| mi.sequence_order = 9; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'Quiz', item_id: cka_sec_l5_quiz.id) { |mi| mi.sequence_order = 10; mi.required = true }

# Link security labs
['RBAC: Least Privilege Access', 'Admission Controllers'].each_with_index do |lab_title, idx|
  if (lab = HandsOnLab.find_by(title: lab_title))
    ModuleItem.find_or_create_by!(course_module: cka_sec_mod, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
      mi.sequence_order = 11 + idx
      mi.required = true
    end
  end
end

# === CKA Module 4: Storage ===

# M4-1: Persistent Volumes Deep Dive
cka_st_l1 = CourseLesson.find_or_create_by!(title: 'Persistent Volumes Deep Dive') do |lesson|
  lesson.content = <<~MARKDOWN
    # Persistent Volumes Deep Dive

    - PV lifecycle and reclaim policies
    - Access modes and binding
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_st_l1_quiz = Quiz.find_or_create_by!(title: 'Persistent Volumes Quiz') do |quiz|
  quiz.description = 'PV policies and binding behavior'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'CourseLesson', item_id: cka_st_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'Quiz', item_id: cka_st_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# M4-2: StorageClasses and Provisioners
cka_st_l2 = CourseLesson.find_or_create_by!(title: 'StorageClasses and Provisioners') do |lesson|
  lesson.content = <<~MARKDOWN
    # StorageClasses and Provisioners

    - parameters and reclaimPolicy
    - default class and topology
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_st_l2_quiz = Quiz.find_or_create_by!(title: 'StorageClasses Quiz') do |quiz|
  quiz.description = 'Class parameters and default behavior'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'CourseLesson', item_id: cka_st_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'Quiz', item_id: cka_st_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# M4-3: CSI Drivers
cka_st_l3 = CourseLesson.find_or_create_by!(title: 'CSI Drivers') do |lesson|
  lesson.content = <<~MARKDOWN
    # CSI Drivers

    - CSI fundamentals and sidecars
    - Driver deployment models
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_st_l3_quiz = Quiz.find_or_create_by!(title: 'CSI Quiz') do |quiz|
  quiz.description = 'CSI architecture and components'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'CourseLesson', item_id: cka_st_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'Quiz', item_id: cka_st_l3_quiz.id) { |mi| mi.sequence_order = 6; mi.required = true }

# M4-4: Snapshots and Cloning
cka_st_l4 = CourseLesson.find_or_create_by!(title: 'Volume Snapshots and Cloning') do |lesson|
  lesson.content = <<~MARKDOWN
    # Volume Snapshots and Cloning

    - Snapshot CRDs and classes
    - Clone from PVC
  MARKDOWN
  lesson.reading_time_minutes = 15
end
cka_st_l4_quiz = Quiz.find_or_create_by!(title: 'Snapshots Quiz') do |quiz|
  quiz.description = 'Snapshot/restore and cloning'
  quiz.time_limit_minutes = 8
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'CourseLesson', item_id: cka_st_l4.id) { |mi| mi.sequence_order = 7; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'Quiz', item_id: cka_st_l4_quiz.id) { |mi| mi.sequence_order = 8; mi.required = true }

# M4-5: Storage Troubleshooting
cka_st_l5 = CourseLesson.find_or_create_by!(title: 'Storage Troubleshooting') do |lesson|
  lesson.content = <<~MARKDOWN
    # Storage Troubleshooting

    - Pending PVC causes
    - Node/pod mount errors and driver logs
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_st_l5_quiz = Quiz.find_or_create_by!(title: 'Storage Troubleshooting Quiz') do |quiz|
  quiz.description = 'Diagnose PVC/PV and mount issues'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'CourseLesson', item_id: cka_st_l5.id) { |mi| mi.sequence_order = 9; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'Quiz', item_id: cka_st_l5_quiz.id) { |mi| mi.sequence_order = 10; mi.required = true }

# Link storage labs
['Persistent Volumes and Claims', 'Dynamic Provisioning'].each_with_index do |lab_title, idx|
  if (lab = HandsOnLab.find_by(title: lab_title))
    ModuleItem.find_or_create_by!(course_module: cka_mod4, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
      mi.sequence_order = 11 + idx
      mi.required = true
    end
  end
end

# === CKA Module 3: Services & Networking ===

# M3-1: Service Types and Endpoints (Admin)
cka_nw_l1 = CourseLesson.find_or_create_by!(title: 'Service Types and Endpoints (Admin)') do |lesson|
  lesson.content = <<~MARKDOWN
    # Service Types and Endpoints (Admin)

    - ClusterIP/NodePort/LoadBalancer and externalTrafficPolicy
    - EndpointSlice and readiness gates for endpoints
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_nw_l1_quiz = Quiz.find_or_create_by!(title: 'Service Types (Admin) Quiz') do |quiz|
  quiz.description = 'Service behavior and endpoint readiness'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'CourseLesson', item_id: cka_nw_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'Quiz', item_id: cka_nw_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# M3-2: CoreDNS and Service Discovery
cka_nw_l2 = CourseLesson.find_or_create_by!(title: 'CoreDNS and Service Discovery') do |lesson|
  lesson.content = <<~MARKDOWN
    # CoreDNS and Service Discovery

    - Server blocks and stub domains
    - Service discovery patterns
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_nw_l2_quiz = Quiz.find_or_create_by!(title: 'CoreDNS Quiz') do |quiz|
  quiz.description = 'DNS configuration and resolution'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'CourseLesson', item_id: cka_nw_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'Quiz', item_id: cka_nw_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# M3-3: CNI and Network Plugins
cka_nw_l3 = CourseLesson.find_or_create_by!(title: 'CNI and Network Plugins') do |lesson|
  lesson.content = <<~MARKDOWN
    # CNI and Network Plugins

    - CNI basics and plugin architecture
    - Popular CNIs (Calico, Cilium, Weave)
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_nw_l3_quiz = Quiz.find_or_create_by!(title: 'CNI Quiz') do |quiz|
  quiz.description = 'Plugin behavior and capabilities'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'CourseLesson', item_id: cka_nw_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'Quiz', item_id: cka_nw_l3_quiz.id) { |mi| mi.sequence_order = 6; mi.required = true }

# M3-4: Ingress Controllers Deep Dive
cka_nw_l4 = CourseLesson.find_or_create_by!(title: 'Ingress Controllers Deep Dive') do |lesson|
  lesson.content = <<~MARKDOWN
    # Ingress Controllers Deep Dive

    - Controller deployment and class annotations
    - TLS, path/host routing, rewrites
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_nw_l4_quiz = Quiz.find_or_create_by!(title: 'Ingress (Admin) Quiz') do |quiz|
  quiz.description = 'Controller behavior and TLS routing'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'CourseLesson', item_id: cka_nw_l4.id) { |mi| mi.sequence_order = 7; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'Quiz', item_id: cka_nw_l4_quiz.id) { |mi| mi.sequence_order = 8; mi.required = true }

# M3-5: Network Policies Advanced
cka_nw_l5 = CourseLesson.find_or_create_by!(title: 'Network Policies Advanced') do |lesson|
  lesson.content = <<~MARKDOWN
    # Network Policies Advanced

    - Egress rules and namespace scoping
    - Common patterns and testing
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_nw_l5_quiz = Quiz.find_or_create_by!(title: 'Network Policies (Admin) Quiz') do |quiz|
  quiz.description = 'Advanced policy scenarios'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'CourseLesson', item_id: cka_nw_l5.id) { |mi| mi.sequence_order = 9; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'Quiz', item_id: cka_nw_l5_quiz.id) { |mi| mi.sequence_order = 10; mi.required = true }

# M3-6: IPv6 and Dual-Stack
cka_nw_l6 = CourseLesson.find_or_create_by!(title: 'IPv6 and Dual-Stack') do |lesson|
  lesson.content = <<~MARKDOWN
    # IPv6 and Dual-Stack

    - Dual-stack service/pod CIDRs
    - Caveats and controller support
  MARKDOWN
  lesson.reading_time_minutes = 15
end
cka_nw_l6_quiz = Quiz.find_or_create_by!(title: 'Dual-Stack Quiz') do |quiz|
  quiz.description = 'Dual-stack concepts and limitations'
  quiz.time_limit_minutes = 8
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'CourseLesson', item_id: cka_nw_l6.id) { |mi| mi.sequence_order = 11; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'Quiz', item_id: cka_nw_l6_quiz.id) { |mi| mi.sequence_order = 12; mi.required = true }

# Link labs for CKA Networking
['Service Types and Load Balancing', 'Ingress Configuration', 'Network Policies: Restrict Pod Egress/Ingress', 'Network Troubleshooting'].each_with_index do |lab_title, idx|
  if (lab = HandsOnLab.find_by(title: lab_title))
    ModuleItem.find_or_create_by!(course_module: cka_mod3, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
      mi.sequence_order = 13 + idx
      mi.required = true
    end
  end
end

# ==========================
# CKA Practice Bank (120+)
# ==========================

cka_bank_module = CourseModule.find_or_create_by!(course: cka_course, slug: 'practice-bank-cka') do |mod|
  mod.title = 'CKA Practice Question Bank (120+)'
  mod.description = 'Large bank across cluster admin domains'
  mod.sequence_order = 8
  mod.estimated_minutes = 240
  mod.published = true
end

# === CKA Module 2: Workloads & Scheduling ===

# M2-1: Pod Scheduling Basics
cka_m2_l1 = CourseLesson.find_or_create_by!(title: 'Pod Scheduling Basics') do |lesson|
  lesson.content = <<~MARKDOWN
    # Pod Scheduling Basics

    - Scheduler flow and predicates/priorities (legacy -> profiles)
    - Node selection and default scheduler behavior
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_m2_l1_quiz = Quiz.find_or_create_by!(title: 'Pod Scheduling Basics Quiz') do |quiz|
  quiz.description = 'Scheduler fundamentals and default behavior'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'CourseLesson', item_id: cka_m2_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'Quiz', item_id: cka_m2_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# M2-2: Node Selectors and Affinity
cka_m2_l2 = CourseLesson.find_or_create_by!(title: 'Node Selectors and Affinity') do |lesson|
  lesson.content = <<~MARKDOWN
    # Node Selectors and Affinity

    - nodeSelector vs nodeAffinity
    - requiredDuringScheduling vs preferredDuringScheduling
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_m2_l2_quiz = Quiz.find_or_create_by!(title: 'Affinity Quiz') do |quiz|
  quiz.description = 'Match expressions and scheduling preferences'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'CourseLesson', item_id: cka_m2_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'Quiz', item_id: cka_m2_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# M2-3: Taints, Tolerations, and Priority
cka_m2_l3 = CourseLesson.find_or_create_by!(title: 'Taints, Tolerations, and Priority') do |lesson|
  lesson.content = <<~MARKDOWN
    # Taints, Tolerations, and Priority

    - NoSchedule, PreferNoSchedule, NoExecute effects
    - Pod priority and preemption
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_m2_l3_quiz = Quiz.find_or_create_by!(title: 'Taints & Priority Quiz') do |quiz|
  quiz.description = 'Apply tolerations; understand preemption'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'CourseLesson', item_id: cka_m2_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'Quiz', item_id: cka_m2_l3_quiz.id) { |mi| mi.sequence_order = 6; mi.required = true }

# M2-4: Resource Management and QoS
cka_m2_l4 = CourseLesson.find_or_create_by!(title: 'Resource Management and QoS') do |lesson|
  lesson.content = <<~MARKDOWN
    # Resource Management and QoS

    - requests/limits and QoS classes
    - eviction thresholds and scheduling implications
  MARKDOWN
  lesson.reading_time_minutes = 20
end
cka_m2_l4_quiz = Quiz.find_or_create_by!(title: 'Resource Management Quiz') do |quiz|
  quiz.description = 'Requests, limits, and eviction'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'CourseLesson', item_id: cka_m2_l4.id) { |mi| mi.sequence_order = 7; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'Quiz', item_id: cka_m2_l4_quiz.id) { |mi| mi.sequence_order = 8; mi.required = true }

# M2-5: Pod Disruption Budgets
cka_m2_l5 = CourseLesson.find_or_create_by!(title: 'Pod Disruption Budgets') do |lesson|
  lesson.content = <<~MARKDOWN
    # Pod Disruption Budgets

    - minAvailable vs maxUnavailable
    - voluntary disruptions and drains
  MARKDOWN
  lesson.reading_time_minutes = 15
end
cka_m2_l5_quiz = Quiz.find_or_create_by!(title: 'PDB Quiz') do |quiz|
  quiz.description = 'Define and validate PDB behavior'
  quiz.time_limit_minutes = 8
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'CourseLesson', item_id: cka_m2_l5.id) { |mi| mi.sequence_order = 9; mi.required = true }
ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'Quiz', item_id: cka_m2_l5_quiz.id) { |mi| mi.sequence_order = 10; mi.required = true }

# Link CKA Module 2 labs
if (lab = HandsOnLab.find_by(title: 'Advanced Pod Scheduling'))
  ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 11
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Pod Disruption Budgets'))
  ModuleItem.find_or_create_by!(course_module: cka_mod2, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 12
    mi.required = true
  end
end

cka_bank = Quiz.find_or_create_by!(title: 'CKA Question Bank (120+)') do |quiz|
  quiz.description = 'Comprehensive practice across architecture, scheduling, networking, storage, and troubleshooting'
  quiz.time_limit_minutes = 0
  quiz.passing_score = 0
  quiz.max_attempts = 0
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

cka_base = [
  { type: 'mcq', text: 'Which component stores cluster state?', options: [
      { text: 'etcd', correct: true }, { text: 'kubelet', correct: false }, { text: 'scheduler', correct: false }, { text: 'kube-proxy', correct: false }
    ], explanation: 'etcd stores all cluster data.' },
  { type: 'command', text: 'Check if you can create deployments in ns=prod', answer: 'kubectl auth can-i create deployments -n prod', explanation: 'kubectl auth can-i verifies RBAC permissions.' },
  { type: 'true_false', text: 'ClusterRole is cluster-scoped.', answer: 'true', explanation: 'Role is namespace-scoped; ClusterRole is cluster-scoped.' },
  { type: 'mcq', text: 'Default policyTypes when only ingress is specified?', options: [
      { text: 'Ingress', correct: true }, { text: 'Egress', correct: false }, { text: 'Ingress,Egress', correct: false }, { text: 'None', correct: false }
    ], explanation: 'Defaults to Ingress.' },
  { type: 'command', text: 'Create PVC 1Gi ReadWriteOnce named data-pvc', answer: 'kubectl apply -f pvc.yaml', explanation: 'PVC manifest defines size and access mode.' },
  { type: 'true_false', text: 'kubectl drain makes a node Unschedulable.', answer: 'true', explanation: 'Node is cordoned and workloads evicted.' }
]

needed = 120
exist = cka_bank.quiz_questions.count
seq = exist
variant = 1
while cka_bank.quiz_questions.count < needed
  cka_base.each do |tpl|
    break if cka_bank.quiz_questions.count >= needed
    seq += 1
    case tpl[:type]
    when 'mcq'
      cka_bank.quiz_questions.find_or_create_by!(sequence_order: seq) do |qq|
        qq.question_type = 'mcq'
        qq.question_text = "#{tpl[:text]} (v#{variant})"
        qq.options = tpl[:options].to_json
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = variant % 3 == 0 ? 'medium' : 'easy'
        qq.points = 8
      end
    when 'command'
      cka_bank.quiz_questions.find_or_create_by!(sequence_order: seq) do |qq|
        qq.question_type = 'command'
        qq.question_text = "#{tpl[:text]} (v#{variant})"
        qq.correct_answer = tpl[:answer]
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = 'medium'
        qq.points = 10
      end
    when 'true_false'
      cka_bank.quiz_questions.find_or_create_by!(sequence_order: seq) do |qq|
        qq.question_type = 'true_false'
        qq.question_text = "#{tpl[:text]} (v#{variant})"
        qq.correct_answer = tpl[:answer]
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = 'easy'
        qq.points = 5
      end
    end
  end
  variant += 1
end

ModuleItem.find_or_create_by!(course_module: cka_bank_module, item_type: 'Quiz', item_id: cka_bank.id) do |mi|
  mi.sequence_order = 1
  mi.required = false
end

# ==========================================
# CKAD - Certified Kubernetes Application Developer
# ==========================================

ckad_course = Course.find_or_create_by!(slug: 'ckad-certification') do |course|
  course.title = 'CKAD: Certified Kubernetes Application Developer'
  course.description = 'Learn to design, build, and deploy cloud-native applications on Kubernetes. Prepare for the CKAD certification exam.'
  course.difficulty_level = 'intermediate'
  course.estimated_hours = 30
  course.certification_track = 'ckad'
  course.published = true
  course.learning_objectives = [
    'Design and build container images',
    'Deploy applications using Kubernetes primitives',
    'Configure application resources and environment',
    'Implement observability and debugging',
    'Manage application lifecycle',
    'Work with Helm charts'
  ]
  course.prerequisites = [
    'Linux Fundamentals course (recommended)',
    'Docker Fundamentals course',
    'YAML syntax',
    'Basic Kubernetes concepts'
  ]
end

puts "Created CKAD course: #{ckad_course.title}"

# CKAD Modules
ckad_mod1 = CourseModule.find_or_create_by!(course: ckad_course, slug: 'application-design') do |mod|
  mod.title = 'Application Design & Build'
  mod.description = 'Learn to design and build container images for Kubernetes'
  mod.sequence_order = 1
  mod.estimated_minutes = 150
end
ckad_mod1.update(published: true)

ckad_mod2 = CourseModule.find_or_create_by!(course: ckad_course, slug: 'application-deployment') do |mod|
  mod.title = 'Application Deployment'
  mod.description = 'Deploy and manage applications using Kubernetes resources'
  mod.sequence_order = 2
  mod.estimated_minutes = 180
end
ckad_mod2.update(published: true)

ckad_mod3 = CourseModule.find_or_create_by!(course: ckad_course, slug: 'application-observability') do |mod|
  mod.title = 'Application Observability & Maintenance'
  mod.description = 'Monitor, debug, and maintain Kubernetes applications'
  mod.sequence_order = 3
  mod.estimated_minutes = 150
end
ckad_mod3.update(published: true)

# CKAD Module 4: Services & Networking
ckad_mod4 = CourseModule.find_or_create_by!(course: ckad_course, slug: 'services-networking-ckad') do |mod|
  mod.title = 'Services & Networking'
  mod.description = 'Service types, DNS, Ingress, and NetworkPolicies for apps'
  mod.sequence_order = 4
  mod.estimated_minutes = 180
end
ckad_mod4.update(published: true)

# CKAD Lesson
ckad_lesson1 = CourseLesson.find_or_create_by!(title: 'Container Images and Registries') do |lesson|
  lesson.content = <<~MARKDOWN
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
  lesson.reading_time_minutes = 25
end

# CKAD Quiz
ckad_quiz1 = Quiz.find_or_create_by!(title: 'Container Images Quiz') do |quiz|
  quiz.description = 'Test your knowledge of container images and registries'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ckad_questions = [
  {
    question_type: 'command',
    question_text: 'What command creates a secret for pulling images from a private registry named "myregistry"?',
    correct_answer: 'kubectl create secret docker-registry',
    explanation: 'The kubectl create secret docker-registry command creates a Secret to authenticate with a container registry.',
    difficulty_level: 'hard',
    points: 15
  },
  {
    question_type: 'mcq',
    question_text: 'Which imagePullPolicy pulls the image only if it is not already present on the node?',
    correct_answer: 'IfNotPresent',
    options: [
      { text: 'Always', correct: false },
      { text: 'IfNotPresent', correct: true },
      { text: 'Never', correct: false },
      { text: 'OnDemand', correct: false }
    ],
    explanation: 'IfNotPresent policy pulls the image only if it is not already cached on the node, reducing unnecessary pulls.',
    difficulty_level: 'medium',
    points: 10
  },
  {
    question_type: 'true_false',
    question_text: 'Using the "latest" tag is considered a best practice for production deployments.',
    correct_answer: 'false',
    explanation: 'Using "latest" tag is not recommended for production as it can lead to unpredictable deployments. Always use specific version tags.',
    difficulty_level: 'medium',
    points: 10
  }
]

ckad_questions.each_with_index do |q, index|
  QuizQuestion.find_or_create_by!(quiz: ckad_quiz1, sequence_order: index + 1) do |question|
    question.question_type = q[:question_type]
    question.question_text = q[:question_text]
    question.correct_answer = q[:correct_answer]
    question.options = q[:options].to_json if q[:options]
    question.explanation = q[:explanation]
    question.difficulty_level = q[:difficulty_level]
    question.points = q[:points]
  end
end

# Link CKAD items
ModuleItem.find_or_create_by!(
  course_module: ckad_mod1,
  item_type: 'CourseLesson',
  item_id: ckad_lesson1.id,
  sequence_order: 1
)

ModuleItem.find_or_create_by!(
  course_module: ckad_mod1,
  item_type: 'Quiz',
  item_id: ckad_quiz1.id,
  sequence_order: 2
)

# === CKAD Module 2 Lessons & Quizzes ===

# L2-1: Deployments - Rolling Updates and Rollbacks
ckad_m2_l1 = CourseLesson.find_or_create_by!(title: 'Deployments: Rolling Updates and Rollbacks') do |lesson|
  lesson.content = <<~MARKDOWN
    # Deployments: Rolling Updates and Rollbacks

    Use Deployments to declaratively manage application updates.
    - Strategies: RollingUpdate (maxSurge, maxUnavailable), Recreate
    - Rollout operations: status, pause, resume, undo
    - History and revisions
  MARKDOWN
  lesson.reading_time_minutes = 25
end

ckad_m2_l1_quiz = Quiz.find_or_create_by!(title: 'Deployments Rolling Update Quiz') do |quiz|
  quiz.description = 'Rolling updates, rollout, and rollback operations'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

[
  { type: 'mcq', text: 'Which flag controls unavailable Pods during RollingUpdate?', options: [
      { text: 'maxUnavailable', correct: true },
      { text: 'maxSurge', correct: false },
      { text: 'minReadySeconds', correct: false },
      { text: 'progressDeadlineSeconds', correct: false }
    ], explanation: 'maxUnavailable controls how many pods can be unavailable.' },
  { type: 'command', text: 'Rollback a deployment named web to previous revision', answer: 'kubectl rollout undo deploy/web', explanation: 'Use rollout undo to revert to previous revision.' }
].each_with_index do |tpl, idx|
  QuizQuestion.find_or_create_by!(quiz: ckad_m2_l1_quiz, sequence_order: idx + 1) do |qq|
    if tpl[:type] == 'mcq'
      qq.question_type = 'mcq'
      qq.question_text = tpl[:text]
      qq.options = tpl[:options].to_json
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 8
    else
      qq.question_type = 'command'
      qq.question_text = tpl[:text]
      qq.correct_answer = tpl[:answer]
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'medium'
      qq.points = 10
    end
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'CourseLesson', item_id: ckad_m2_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'Quiz', item_id: ckad_m2_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# L2-2: StatefulSets for Stateful Applications
ckad_m2_l2 = CourseLesson.find_or_create_by!(title: 'StatefulSets for Stateful Applications') do |lesson|
  lesson.content = <<~MARKDOWN
    # StatefulSets for Stateful Applications

    Provide stable network IDs and storage for stateful workloads.
    - Ordered, graceful deployment and scaling
    - Persistent volume claims per replica
    - Headless services for DNS
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m2_l2_quiz = Quiz.find_or_create_by!(title: 'StatefulSets Quiz') do |quiz|
  quiz.description = 'Ordered deployment, stable identities, PVC templates'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

[
  { type: 'true_false', text: 'StatefulSet pods get stable network identities.', answer: 'true', explanation: 'Pod ordinals and stable DNS names.' },
  { type: 'mcq', text: 'Which service type pairs with StatefulSets?', options: [
      { text: 'Headless Service', correct: true },
      { text: 'NodePort', correct: false },
      { text: 'LoadBalancer', correct: false },
      { text: 'ClusterIP', correct: false }
    ], explanation: 'Use headless service for per-pod DNS.' }
].each_with_index do |tpl, idx|
  QuizQuestion.find_or_create_by!(quiz: ckad_m2_l2_quiz, sequence_order: idx + 1) do |qq|
    case tpl[:type]
    when 'mcq'
      qq.question_type = 'mcq'; qq.question_text = tpl[:text]; qq.options = tpl[:options].to_json; qq.explanation = tpl[:explanation]; qq.difficulty_level = 'easy'; qq.points = 8
    when 'true_false'
      qq.question_type = 'true_false'; qq.question_text = tpl[:text]; qq.correct_answer = tpl[:answer]; qq.explanation = tpl[:explanation]; qq.difficulty_level = 'easy'; qq.points = 6
    end
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'CourseLesson', item_id: ckad_m2_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'Quiz', item_id: ckad_m2_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# L2-3: DaemonSets and Jobs
ckad_m2_l3 = CourseLesson.find_or_create_by!(title: 'DaemonSets and Jobs') do |lesson|
  lesson.content = <<~MARKDOWN
    # DaemonSets and Jobs

    - DaemonSets ensure a Pod runs on every node or subset
    - Jobs run a task to completion; CronJobs schedule Jobs
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m2_l3_quiz = Quiz.find_or_create_by!(title: 'DaemonSets and Jobs Quiz') do |quiz|
  quiz.description = 'DaemonSet coverage and Job completions'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

[
  { type: 'mcq', text: 'DaemonSets typically run on which nodes?', options: [
      { text: 'All nodes (or matching labels)', correct: true },
      { text: 'Control plane only', correct: false },
      { text: 'Random subset', correct: false },
      { text: 'One node', correct: false }
    ], explanation: 'DaemonSets target nodes via nodeSelector/affinity.' }
].each_with_index do |tpl, idx|
  QuizQuestion.find_or_create_by!(quiz: ckad_m2_l3_quiz, sequence_order: idx + 1) do |qq|
    qq.question_type = 'mcq'; qq.question_text = tpl[:text]; qq.options = tpl[:options].to_json; qq.explanation = tpl[:explanation]; qq.difficulty_level = 'easy'; qq.points = 8
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'CourseLesson', item_id: ckad_m2_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'Quiz', item_id: ckad_m2_l3_quiz.id) { |mi| mi.sequence_order = 6; mi.required = true }

# L2-4: CronJobs and Batch Processing
ckad_m2_l4 = CourseLesson.find_or_create_by!(title: 'CronJobs and Batch Processing') do |lesson|
  lesson.content = <<~MARKDOWN
    # CronJobs and Batch Processing

    Schedule recurring tasks with CronJobs.
    - cron schedule format
    - history limits and concurrencyPolicy
    - suspend and resume
  MARKDOWN
  lesson.reading_time_minutes = 15
end

ckad_m2_l4_quiz = Quiz.find_or_create_by!(title: 'CronJobs Quiz') do |quiz|
  quiz.description = 'Scheduling, concurrency, and history limits'
  quiz.time_limit_minutes = 8
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'CourseLesson', item_id: ckad_m2_l4.id) { |mi| mi.sequence_order = 7; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'Quiz', item_id: ckad_m2_l4_quiz.id) { |mi| mi.sequence_order = 8; mi.required = true }

# L2-5: Blue-Green and Canary Deployments
ckad_m2_l5 = CourseLesson.find_or_create_by!(title: 'Blue-Green and Canary Deployments') do |lesson|
  lesson.content = <<~MARKDOWN
    # Blue-Green and Canary Deployments

    Progressive delivery strategies to minimize risk.
    - Blue/Green: switch traffic between environments
    - Canary: gradually shift traffic to new version
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m2_l5_quiz = Quiz.find_or_create_by!(title: 'Progressive Delivery Quiz') do |quiz|
  quiz.description = 'Blue/Green vs Canary patterns'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'CourseLesson', item_id: ckad_m2_l5.id) { |mi| mi.sequence_order = 9; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'Quiz', item_id: ckad_m2_l5_quiz.id) { |mi| mi.sequence_order = 10; mi.required = true }

# L2-6: Helm Charts and Package Management
ckad_m2_l6 = CourseLesson.find_or_create_by!(title: 'Helm Charts and Package Management') do |lesson|
  lesson.content = <<~MARKDOWN
    # Helm Charts and Package Management

    - Helm chart structure (Chart.yaml, templates, values)
    - Installing and upgrading releases
    - Values overrides and templating basics
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m2_l6_quiz = Quiz.find_or_create_by!(title: 'Helm Basics Quiz') do |quiz|
  quiz.description = 'Chart structure, install/upgrade, values overrides'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'CourseLesson', item_id: ckad_m2_l6.id) { |mi| mi.sequence_order = 11; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'Quiz', item_id: ckad_m2_l6_quiz.id) { |mi| mi.sequence_order = 12; mi.required = true }

# Link CKAD Module 2 lab(s)
if (lab = HandsOnLab.find_by(title: 'Rolling Updates and Rollback Scenarios'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 13
    mi.required = true
  end
end

# === CKAD Module 1 Additional Lessons & Quizzes ===

# Lesson 2: Pod Design Fundamentals
ckad_lesson2 = CourseLesson.find_or_create_by!(title: 'Pod Design Fundamentals') do |lesson|
  lesson.content = <<~MARKDOWN
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
  lesson.reading_time_minutes = 25
end

ckad_lesson2_quiz = Quiz.find_or_create_by!(title: 'Pod Design Fundamentals Quiz') do |quiz|
  quiz.description = 'Assess understanding of pod anatomy, QoS, and probes'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

[
  { type: 'mcq', text: 'Which QoS class applies if no requests/limits are set?', options: [
      { text: 'Guaranteed', correct: false },
      { text: 'Burstable', correct: false },
      { text: 'BestEffort', correct: true },
      { text: 'None', correct: false }
    ], explanation: 'No requests or limits => BestEffort.' },
  { type: 'true_false', text: 'readinessProbe controls traffic gating to a Pod.', answer: 'true', explanation: 'Readiness decides if Pod is ready for Service endpoints.' },
  { type: 'command', text: 'Set CPU request=100m and limit=200m for container app in deploy web', answer: 'kubectl set resources deploy/web -c=app --requests=cpu=100m --limits=cpu=200m', explanation: 'Use kubectl set resources to update container resources.' }
].each_with_index do |tpl, idx|
  QuizQuestion.find_or_create_by!(quiz: ckad_lesson2_quiz, sequence_order: idx + 1) do |qq|
    case tpl[:type]
    when 'mcq'
      qq.question_type = 'mcq'
      qq.question_text = tpl[:text]
      qq.options = tpl[:options].to_json
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 8
    when 'true_false'
      qq.question_type = 'true_false'
      qq.question_text = tpl[:text]
      qq.correct_answer = tpl[:answer]
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 6
    when 'command'
      qq.question_type = 'command'
      qq.question_text = tpl[:text]
      qq.correct_answer = tpl[:answer]
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'medium'
      qq.points = 10
    end
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'CourseLesson', item_id: ckad_lesson2.id) do |mi|
  mi.sequence_order = 3
  mi.required = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'Quiz', item_id: ckad_lesson2_quiz.id) do |mi|
  mi.sequence_order = 4
  mi.required = true
end

# Lesson 3: Multi-Container Pod Patterns
ckad_lesson3 = CourseLesson.find_or_create_by!(title: 'Multi-Container Pod Patterns') do |lesson|
  lesson.content = <<~MARKDOWN
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
  lesson.reading_time_minutes = 25
end

ckad_lesson3_quiz = Quiz.find_or_create_by!(title: 'Multi-Container Patterns Quiz') do |quiz|
  quiz.description = 'Test knowledge of sidecar/ambassador/adapter patterns'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

[
  { type: 'mcq', text: 'Which pattern is best for log shipping?', options: [
      { text: 'Ambassador', correct: false },
      { text: 'Adapter', correct: false },
      { text: 'Sidecar', correct: true },
      { text: 'Init Container', correct: false }
    ], explanation: 'Sidecars commonly handle logs/metrics.' },
  { type: 'true_false', text: 'emptyDir volumes can be used to share files between containers in a Pod.', answer: 'true', explanation: 'emptyDir is per-Pod and accessible to all containers mounted.' },
  { type: 'command', text: 'Patch deploy web to add sidecar busybox container', answer: 'kubectl patch deploy web --type=strategic -p "{\"spec\":{\"template\":{\"spec\":{\"containers\":[{\"name\":\"sidecar\",\"image\":\"busybox\",\"args\":[\"sh\",\"-c\",\"sleep 3600\"]}]}}}}"', explanation: 'Demonstrates adding a second container.' }
].each_with_index do |tpl, idx|
  QuizQuestion.find_or_create_by!(quiz: ckad_lesson3_quiz, sequence_order: idx + 1) do |qq|
    case tpl[:type]
    when 'mcq'
      qq.question_type = 'mcq'
      qq.question_text = tpl[:text]
      qq.options = tpl[:options].to_json
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 8
    when 'true_false'
      qq.question_type = 'true_false'
      qq.question_text = tpl[:text]
      qq.correct_answer = tpl[:answer]
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 6
    when 'command'
      qq.question_type = 'command'
      qq.question_text = tpl[:text]
      qq.correct_answer = tpl[:answer]
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'medium'
      qq.points = 10
    end
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'CourseLesson', item_id: ckad_lesson3.id) do |mi|
  mi.sequence_order = 5
  mi.required = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'Quiz', item_id: ckad_lesson3_quiz.id) do |mi|
  mi.sequence_order = 6
  mi.required = true
end

# Lesson 4: Init Containers and Pod Lifecycle
ckad_lesson4 = CourseLesson.find_or_create_by!(title: 'Init Containers and Pod Lifecycle') do |lesson|
  lesson.content = <<~MARKDOWN
    # Init Containers and Pod Lifecycle

    Init containers run to completion before app containers start.
    Use cases:
    - Fetch configuration or warm caches
    - Wait for dependencies
    - Perform pre-flight checks

    ## Lifecycle Hooks
    - postStart and preStop hooks allow custom lifecycle actions
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_lesson4_quiz = Quiz.find_or_create_by!(title: 'Init Containers & Lifecycle Quiz') do |quiz|
  quiz.description = 'Quiz on initContainers and lifecycle hooks'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

[
  { type: 'true_false', text: 'App containers can start before init containers finish.', answer: 'false', explanation: 'Init containers must complete first.' },
  { type: 'mcq', text: 'Which hook runs before container termination?', options: [
      { text: 'postStart', correct: false },
      { text: 'preStop', correct: true },
      { text: 'liveness', correct: false },
      { text: 'readiness', correct: false }
    ], explanation: 'preStop executes prior to termination.' }
].each_with_index do |tpl, idx|
  QuizQuestion.find_or_create_by!(quiz: ckad_lesson4_quiz, sequence_order: idx + 1) do |qq|
    case tpl[:type]
    when 'mcq'
      qq.question_type = 'mcq'
      qq.question_text = tpl[:text]
      qq.options = tpl[:options].to_json
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 8
    when 'true_false'
      qq.question_type = 'true_false'
      qq.question_text = tpl[:text]
      qq.correct_answer = tpl[:answer]
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 6
    end
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'CourseLesson', item_id: ckad_lesson4.id) do |mi|
  mi.sequence_order = 7
  mi.required = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'Quiz', item_id: ckad_lesson4_quiz.id) do |mi|
  mi.sequence_order = 8
  mi.required = true
end

# Lesson 5: Building Cloud-Native Applications
ckad_lesson5 = CourseLesson.find_or_create_by!(title: 'Building Cloud-Native Applications') do |lesson|
  lesson.content = <<~MARKDOWN
    # Building Cloud-Native Applications

    Design 12-factor applications for Kubernetes:
    - Config via environment
    - Stateless processes
    - Disposability
    - Dev/prod parity
    - Logs as event streams
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_lesson5_quiz = Quiz.find_or_create_by!(title: 'Cloud-Native Apps Quiz') do |quiz|
  quiz.description = 'Core concepts of 12-factor and K8s-native development'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

[
  { type: 'mcq', text: 'Which practice aligns with 12-factor?', options: [
      { text: 'Bake config into image', correct: false },
      { text: 'Externalize config via env/ConfigMap', correct: true },
      { text: 'Store logs on disk', correct: false },
      { text: 'Couple state with app', correct: false }
    ], explanation: 'Config should be externalized.' }
].each_with_index do |tpl, idx|
  QuizQuestion.find_or_create_by!(quiz: ckad_lesson5_quiz, sequence_order: idx + 1) do |qq|
    if tpl[:type] == 'mcq'
      qq.question_type = 'mcq'
      qq.question_text = tpl[:text]
      qq.options = tpl[:options].to_json
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 8
    end
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'CourseLesson', item_id: ckad_lesson5.id) do |mi|
  mi.sequence_order = 9
  mi.required = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'Quiz', item_id: ckad_lesson5_quiz.id) do |mi|
  mi.sequence_order = 10
  mi.required = true
end

# Lesson 6: Container Security Best Practices
ckad_lesson6 = CourseLesson.find_or_create_by!(title: 'Container Security Best Practices') do |lesson|
  lesson.content = <<~MARKDOWN
    # Container Security Best Practices

    - Use non-root user
    - Read-only root filesystem
    - Pin image versions
    - Scan images for vulnerabilities
    - Limit capabilities
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_lesson6_quiz = Quiz.find_or_create_by!(title: 'Container Security Best Practices Quiz') do |quiz|
  quiz.description = 'Assess container hardening best practices'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

[
  { type: 'true_false', text: 'Running containers as root is recommended for simplicity.', answer: 'false', explanation: 'Always prefer non-root.' },
  { type: 'mcq', text: 'Which option hardens containers?', options: [
      { text: 'readOnlyRootFilesystem: true', correct: true },
      { text: 'Use :latest tag', correct: false },
      { text: 'Add ALL capabilities', correct: false },
      { text: 'Disable liveness', correct: false }
    ], explanation: 'Use read-only root FS and least privilege.' }
].each_with_index do |tpl, idx|
  QuizQuestion.find_or_create_by!(quiz: ckad_lesson6_quiz, sequence_order: idx + 1) do |qq|
    case tpl[:type]
    when 'mcq'
      qq.question_type = 'mcq'
      qq.question_text = tpl[:text]
      qq.options = tpl[:options].to_json
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 8
    when 'true_false'
      qq.question_type = 'true_false'
      qq.question_text = tpl[:text]
      qq.correct_answer = tpl[:answer]
      qq.explanation = tpl[:explanation]
      qq.difficulty_level = 'easy'
      qq.points = 6
    end
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'CourseLesson', item_id: ckad_lesson6.id) do |mi|
  mi.sequence_order = 11
  mi.required = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'Quiz', item_id: ckad_lesson6_quiz.id) do |mi|
  mi.sequence_order = 12
  mi.required = true
end

# Link CKAD Module 1 Labs (if present)
if (lab = HandsOnLab.find_by(title: 'Build and Optimize Container Images'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 13
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Multi-Container Pod Patterns'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 14
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Application Lifecycle Management'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod1, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 15
    mi.required = true
  end
end

# === CKAD Module 3 Lessons & Quizzes (Observability) ===

# M3-1: Health Checks - Probes
ckad_m3_l1 = CourseLesson.find_or_create_by!(title: 'Health Checks: Liveness, Readiness, Startup Probes') do |lesson|
  lesson.content = <<~MARKDOWN
    # Health Checks: Liveness, Readiness, Startup

    - livenessProbe: restarts unhealthy containers
    - readinessProbe: controls traffic gating
    - startupProbe: delays liveness until startup completes
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m3_l1_quiz = Quiz.find_or_create_by!(title: 'Probes Quiz') do |quiz|
  quiz.description = 'When to use liveness, readiness, and startup probes'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'CourseLesson', item_id: ckad_m3_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'Quiz', item_id: ckad_m3_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# M3-2: Application Logging Strategies
ckad_m3_l2 = CourseLesson.find_or_create_by!(title: 'Application Logging Strategies') do |lesson|
  lesson.content = <<~MARKDOWN
    # Application Logging Strategies

    - Write logs to stdout/stderr
    - Use sidecar for log shipping
    - Structured logs and correlation IDs
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m3_l2_quiz = Quiz.find_or_create_by!(title: 'Application Logging Quiz') do |quiz|
  quiz.description = 'Best practices for app logging in Kubernetes'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'CourseLesson', item_id: ckad_m3_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'Quiz', item_id: ckad_m3_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# M3-3: Monitoring Fundamentals
ckad_m3_l3 = CourseLesson.find_or_create_by!(title: 'Monitoring Fundamentals') do |lesson|
  lesson.content = <<~MARKDOWN
    # Monitoring Fundamentals

    - Metrics collection (Prometheus)
    - Alerting and recording rules
    - ServiceMonitor/PodMonitor basics
  MARKDOWN
  lesson.reading_time_minutes = 25
end

ckad_m3_l3_quiz = Quiz.find_or_create_by!(title: 'Monitoring Quiz') do |quiz|
  quiz.description = 'Metrics, alerting, and scraping targets'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'CourseLesson', item_id: ckad_m3_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'Quiz', item_id: ckad_m3_l3_quiz.id) { |mi| mi.sequence_order = 6; mi.required = true }

# M3-4: Debugging and Troubleshooting
ckad_m3_l4 = CourseLesson.find_or_create_by!(title: 'Debugging and Troubleshooting') do |lesson|
  lesson.content = <<~MARKDOWN
    # Debugging and Troubleshooting

    - kubectl describe, events, and logs
    - exec/attach and ephemeral containers
    - node/pod/network/storage triage
  MARKDOWN
  lesson.reading_time_minutes = 25
end

ckad_m3_l4_quiz = Quiz.find_or_create_by!(title: 'Debugging Quiz') do |quiz|
  quiz.description = 'Common triage steps and tools'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'CourseLesson', item_id: ckad_m3_l4.id) { |mi| mi.sequence_order = 7; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'Quiz', item_id: ckad_m3_l4_quiz.id) { |mi| mi.sequence_order = 8; mi.required = true }

# M3-5: Distributed Tracing (Intro)
ckad_m3_l5 = CourseLesson.find_or_create_by!(title: 'Distributed Tracing Basics') do |lesson|
  lesson.content = <<~MARKDOWN
    # Distributed Tracing Basics

    - Trace context propagation
    - OpenTelemetry instrumentation
    - Visualizing traces in Jaeger/Grafana Tempo
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m3_l5_quiz = Quiz.find_or_create_by!(title: 'Tracing Quiz') do |quiz|
  quiz.description = 'Trace propagation and visualization basics'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'CourseLesson', item_id: ckad_m3_l5.id) { |mi| mi.sequence_order = 9; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'Quiz', item_id: ckad_m3_l5_quiz.id) { |mi| mi.sequence_order = 10; mi.required = true }

# Link labs for Observability
if (lab = HandsOnLab.find_by(title: 'Probes: Liveness and Readiness'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 11
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Application Logging and Debugging'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 12
    mi.required = true
  end
end

# === CKAD Module 4 Lessons & Quizzes (Services & Networking) ===

# M4-1: Service Types and Endpoints
ckad_m4_l1 = CourseLesson.find_or_create_by!(title: 'Service Types and Endpoints') do |lesson|
  lesson.content = <<~MARKDOWN
    # Service Types and Endpoints

    - ClusterIP, NodePort, LoadBalancer
    - headless services and Endpoints/EndpointSlice
    - Session affinity and externalTrafficPolicy
  MARKDOWN
  lesson.reading_time_minutes = 25
end

ckad_m4_l1_quiz = Quiz.find_or_create_by!(title: 'Service Types Quiz') do |quiz|
  quiz.description = 'Service types, selectors, and endpoint behavior'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'CourseLesson', item_id: ckad_m4_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'Quiz', item_id: ckad_m4_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# M4-2: DNS and Service Discovery
ckad_m4_l2 = CourseLesson.find_or_create_by!(title: 'DNS and Service Discovery') do |lesson|
  lesson.content = <<~MARKDOWN
    # DNS and Service Discovery

    - CoreDNS, stub domains, and search paths
    - Service DNS names and SRV records
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m4_l2_quiz = Quiz.find_or_create_by!(title: 'DNS Quiz') do |quiz|
  quiz.description = 'CoreDNS basics and service discovery'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'CourseLesson', item_id: ckad_m4_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'Quiz', item_id: ckad_m4_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# M4-3: Ingress Controllers and Rules
ckad_m4_l3 = CourseLesson.find_or_create_by!(title: 'Ingress Controllers and Rules') do |lesson|
  lesson.content = <<~MARKDOWN
    # Ingress Controllers and Rules

    - path vs host rules, pathType
    - TLS termination
    - common controllers (nginx, traefik)
  MARKDOWN
  lesson.reading_time_minutes = 25
end

ckad_m4_l3_quiz = Quiz.find_or_create_by!(title: 'Ingress Quiz') do |quiz|
  quiz.description = 'Ingress routing, TLS, and rules'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'CourseLesson', item_id: ckad_m4_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'Quiz', item_id: ckad_m4_l3_quiz.id) { |mi| mi.sequence_order = 6; mi.required = true }

# M4-4: Network Policies for Microservices
ckad_m4_l4 = CourseLesson.find_or_create_by!(title: 'Network Policies for Microservices') do |lesson|
  lesson.content = <<~MARKDOWN
    # Network Policies for Microservices

    - policyTypes, podSelector, namespaceSelector
    - common allow/deny patterns
    - testing connectivity
  MARKDOWN
  lesson.reading_time_minutes = 25
end

ckad_m4_l4_quiz = Quiz.find_or_create_by!(title: 'Network Policies Quiz') do |quiz|
  quiz.description = 'Selectors and policy crafting'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'CourseLesson', item_id: ckad_m4_l4.id) { |mi| mi.sequence_order = 7; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'Quiz', item_id: ckad_m4_l4_quiz.id) { |mi| mi.sequence_order = 8; mi.required = true }

# M4-5: Service Mesh Basics
ckad_m4_l5 = CourseLesson.find_or_create_by!(title: 'Service Mesh Basics') do |lesson|
  lesson.content = <<~MARKDOWN
    # Service Mesh Basics

    - sidecar proxies and data plane
    - traffic splitting and retries
    - mTLS overview
  MARKDOWN
  lesson.reading_time_minutes = 20
end

ckad_m4_l5_quiz = Quiz.find_or_create_by!(title: 'Service Mesh Quiz') do |quiz|
  quiz.description = 'Sidecars, routing, and mTLS basics'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'CourseLesson', item_id: ckad_m4_l5.id) { |mi| mi.sequence_order = 9; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'Quiz', item_id: ckad_m4_l5_quiz.id) { |mi| mi.sequence_order = 10; mi.required = true }

# Link labs for Networking
if (lab = HandsOnLab.find_by(title: 'Service Types and Load Balancing'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 11
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Ingress Configuration'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 12
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Network Policies: Restrict Pod Egress/Ingress'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod4, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 13
    mi.required = true
  end
end

# CKAD Module 5: Application Configuration
ckad_mod5 = CourseModule.find_or_create_by!(course: ckad_course, slug: 'application-configuration') do |mod|
  mod.title = 'Application Configuration'
  mod.description = 'ConfigMaps, Secrets, env/args, resources, security contexts, and SAs'
  mod.sequence_order = 5
  mod.estimated_minutes = 180
end
ckad_mod5.update(published: true)

# M5-1: ConfigMaps - Application Configuration
ckad_m5_l1 = CourseLesson.find_or_create_by!(title: 'ConfigMaps: Application Configuration') do |lesson|
  lesson.content = <<~MARKDOWN
    # ConfigMaps: Application Configuration

    - Key/value pairs and file-based configs
    - Mount via envFrom, env, and volumes
    - Updates and rollout behavior
  MARKDOWN
  lesson.reading_time_minutes = 20
end
ckad_m5_l1_quiz = Quiz.find_or_create_by!(title: 'ConfigMaps Quiz') do |quiz|
  quiz.description = 'Using ConfigMaps with env and volumes'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'CourseLesson', item_id: ckad_m5_l1.id) { |mi| mi.sequence_order = 1; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'Quiz', item_id: ckad_m5_l1_quiz.id) { |mi| mi.sequence_order = 2; mi.required = true }

# M5-2: Secrets Management and Security
ckad_m5_l2 = CourseLesson.find_or_create_by!(title: 'Secrets Management and Security') do |lesson|
  lesson.content = <<~MARKDOWN
    # Secrets Management and Security

    - Opaque secrets and stringData
    - Mounting secrets and envFrom
    - Secret encryption at rest (KMS)
  MARKDOWN
  lesson.reading_time_minutes = 20
end
ckad_m5_l2_quiz = Quiz.find_or_create_by!(title: 'Secrets Quiz') do |quiz|
  quiz.description = 'Create and use Secrets securely'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'CourseLesson', item_id: ckad_m5_l2.id) { |mi| mi.sequence_order = 3; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'Quiz', item_id: ckad_m5_l2_quiz.id) { |mi| mi.sequence_order = 4; mi.required = true }

# M5-3: Environment Variables and Command Arguments
ckad_m5_l3 = CourseLesson.find_or_create_by!(title: 'Environment Variables and Command Arguments') do |lesson|
  lesson.content = <<~MARKDOWN
    # Environment Variables and Command Arguments

    - env and envFrom with ConfigMap/Secret
    - args and command for entrypoint configuration
  MARKDOWN
  lesson.reading_time_minutes = 15
end
ckad_m5_l3_quiz = Quiz.find_or_create_by!(title: 'Env and Args Quiz') do |quiz|
  quiz.description = 'Configure env, envFrom, and container args'
  quiz.time_limit_minutes = 8
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'CourseLesson', item_id: ckad_m5_l3.id) { |mi| mi.sequence_order = 5; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'Quiz', item_id: ckad_m5_l3_quiz.id) { |mi| mi.sequence_order = 6; mi.required = true }

# M5-4: Resource Limits and Requests
ckad_m5_l4 = CourseLesson.find_or_create_by!(title: 'Resource Limits and Requests') do |lesson|
  lesson.content = <<~MARKDOWN
    # Resource Limits and Requests

    - CPU/memory units
    - QoS classes and scheduling impact
    - Best practices for sizing
  MARKDOWN
  lesson.reading_time_minutes = 20
end
ckad_m5_l4_quiz = Quiz.find_or_create_by!(title: 'Resources Quiz') do |quiz|
  quiz.description = 'Requests/limits and QoS classes'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'CourseLesson', item_id: ckad_m5_l4.id) { |mi| mi.sequence_order = 7; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'Quiz', item_id: ckad_m5_l4_quiz.id) { |mi| mi.sequence_order = 8; mi.required = true }

# M5-5: Security Contexts and Pod Security
ckad_m5_l5 = CourseLesson.find_or_create_by!(title: 'Security Contexts and Pod Security') do |lesson|
  lesson.content = <<~MARKDOWN
    # Security Contexts and Pod Security

    - runAsUser, fsGroup, readOnlyRootFilesystem
    - Capabilities and privilege escalation
    - Overview of Pod Security standards
  MARKDOWN
  lesson.reading_time_minutes = 20
end
ckad_m5_l5_quiz = Quiz.find_or_create_by!(title: 'Security Contexts Quiz') do |quiz|
  quiz.description = 'Configure securityContext fields'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'CourseLesson', item_id: ckad_m5_l5.id) { |mi| mi.sequence_order = 9; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'Quiz', item_id: ckad_m5_l5_quiz.id) { |mi| mi.sequence_order = 10; mi.required = true }

# M5-6: Service Accounts and RBAC for Apps
ckad_m5_l6 = CourseLesson.find_or_create_by!(title: 'Service Accounts and RBAC for Apps') do |lesson|
  lesson.content = <<~MARKDOWN
    # Service Accounts and RBAC for Apps

    - Default service account behavior
    - Binding Roles to service accounts
    - Token/ProjectedVolume considerations
  MARKDOWN
  lesson.reading_time_minutes = 20
end
ckad_m5_l6_quiz = Quiz.find_or_create_by!(title: 'Service Accounts Quiz') do |quiz|
  quiz.description = 'Use service accounts with least-privilege roles'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'CourseLesson', item_id: ckad_m5_l6.id) { |mi| mi.sequence_order = 11; mi.required = true }
ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'Quiz', item_id: ckad_m5_l6_quiz.id) { |mi| mi.sequence_order = 12; mi.required = true }

# Link labs for Application Configuration
if (lab = HandsOnLab.find_by(title: 'ConfigMaps and Secrets for App Configuration'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 13
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Resource Management and Limits'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 14
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Application Security Contexts'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod5, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 15
    mi.required = true
  end
end

puts "Created CKAD Module 1 with lesson and quiz"

# ==========================
# CKAD Practice Bank (120+)
# ==========================

ckad_bank_module = CourseModule.find_or_create_by!(course: ckad_course, slug: 'practice-bank-ckad') do |mod|
  mod.title = 'CKAD Practice Question Bank (120+)'
  mod.description = 'Large bank across application developer domains'
  mod.sequence_order = 8
  mod.estimated_minutes = 200
  mod.published = true
end

ckad_bank = Quiz.find_or_create_by!(title: 'CKAD Question Bank (120+)') do |quiz|
  quiz.description = 'Comprehensive practice on Pods, config, services, observability, and jobs'
  quiz.time_limit_minutes = 0
  quiz.passing_score = 0
  quiz.max_attempts = 0
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

ckad_base = [
  { type: 'command', text: 'Create ConfigMap app-config with KEY=VALUE', answer: 'kubectl create configmap app-config --from-literal=KEY=VALUE', explanation: 'Use kubectl create configmap with --from-literal.' },
  { type: 'mcq', text: 'Which object exposes a Deployment internally?', options: [
      { text: 'Service', correct: true }, { text: 'Ingress', correct: false }, { text: 'EndpointSlice', correct: false }, { text: 'NetworkPolicy', correct: false }
    ], explanation: 'Service provides stable virtual IP and DNS.' },
  { type: 'true_false', text: 'Readiness probe gates Service endpoints.', answer: 'true', explanation: 'Only Ready pods receive traffic.' },
  { type: 'command', text: 'Create CronJob hello every minute printing date', answer: "kubectl create cronjob hello --image=busybox --schedule='*/1 * * * *' -- /bin/sh -c 'date'", explanation: 'kubectl create cronjob <name> --schedule ...' }
]

need = 120
existing = ckad_bank.quiz_questions.count
s = existing
v = 1
while ckad_bank.quiz_questions.count < need
  ckad_base.each do |tpl|
    break if ckad_bank.quiz_questions.count >= need
    s += 1
    case tpl[:type]
    when 'mcq'
      ckad_bank.quiz_questions.find_or_create_by!(sequence_order: s) do |qq|
        qq.question_type = 'mcq'
        qq.question_text = "#{tpl[:text]} (v#{v})"
        qq.options = tpl[:options].to_json
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = v % 3 == 0 ? 'medium' : 'easy'
        qq.points = 8
      end
    when 'command'
      ckad_bank.quiz_questions.find_or_create_by!(sequence_order: s) do |qq|
        qq.question_type = 'command'
        qq.question_text = "#{tpl[:text]} (v#{v})"
        qq.correct_answer = tpl[:answer]
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = 'medium'
        qq.points = 10
      end
    when 'true_false'
      ckad_bank.quiz_questions.find_or_create_by!(sequence_order: s) do |qq|
        qq.question_type = 'true_false'
        qq.question_text = "#{tpl[:text]} (v#{v})"
        qq.correct_answer = tpl[:answer]
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = 'easy'
        qq.points = 5
      end
    end
  end
  v += 1
end

ModuleItem.find_or_create_by!(course_module: ckad_bank_module, item_type: 'Quiz', item_id: ckad_bank.id) do |mi|
  mi.sequence_order = 1
  mi.required = false
end

# Link CKAD labs if available
if (lab = HandsOnLab.find_by(title: 'ConfigMaps and Secrets for App Configuration'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 3
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Jobs and CronJobs'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod2, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 4
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Probes: Liveness and Readiness'))
  ModuleItem.find_or_create_by!(course_module: ckad_mod3, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 3
    mi.required = true
  end
end

# ==========================================
# CKS - Certified Kubernetes Security
# ==========================================

cks_course = Course.find_or_create_by!(slug: 'cks-certification') do |course|
  course.title = 'CKS: Certified Kubernetes Security Specialist'
  course.description = 'Master Kubernetes security best practices and prepare for the CKS certification. Learn cluster hardening, security monitoring, and compliance.'
  course.difficulty_level = 'advanced'
  course.estimated_hours = 35
  course.certification_track = 'cks'
  course.published = true
  course.learning_objectives = [
    'Implement cluster hardening',
    'Configure system hardening',
    'Minimize microservice vulnerabilities',
    'Implement supply chain security',
    'Monitor and detect threats',
    'Respond to security incidents'
  ]
  course.prerequisites = [
    'Linux Fundamentals course (required)',
    'CKA certification or equivalent knowledge',
    'Linux security fundamentals',
    'Network security basics',
    'Docker security practices'
  ]
end

puts "Created CKS course: #{cks_course.title}"

# CKS Modules
cks_mod1 = CourseModule.find_or_create_by!(course: cks_course, slug: 'cluster-hardening') do |mod|
  mod.title = 'Cluster Hardening'
  mod.description = 'Learn to secure Kubernetes cluster components and API access'
  mod.sequence_order = 1
  mod.estimated_minutes = 200
end
cks_mod1.update(published: true)

cks_mod2 = CourseModule.find_or_create_by!(course: cks_course, slug: 'system-hardening') do |mod|
  mod.title = 'System Hardening'
  mod.description = 'Harden the underlying host operating system'
  mod.sequence_order = 2
  mod.estimated_minutes = 180
end
cks_mod2.update(published: true)

cks_mod3 = CourseModule.find_or_create_by!(course: cks_course, slug: 'microservice-security') do |mod|
  mod.title = 'Minimize Microservice Vulnerabilities'
  mod.description = 'Secure containerized applications and minimize attack surface'
  mod.sequence_order = 3
  mod.estimated_minutes = 150
end
cks_mod3.update(published: true)

# CKS Lesson
cks_lesson1 = CourseLesson.find_or_create_by!(title: 'RBAC and Authentication') do |lesson|
  lesson.content = <<~MARKDOWN
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
  lesson.reading_time_minutes = 30
end

# CKS Quiz
cks_quiz1 = Quiz.find_or_create_by!(title: 'RBAC and Authentication Quiz') do |quiz|
  quiz.description = 'Test your knowledge of Kubernetes RBAC and authentication'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 75
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

cks_questions = [
  {
    question_type: 'mcq',
    question_text: 'Which resource is namespace-scoped in RBAC?',
    correct_answer: 'Role',
    options: [
      { text: 'ClusterRole', correct: false },
      { text: 'Role', correct: true },
      { text: 'ClusterRoleBinding', correct: false },
      { text: 'All of the above', correct: false }
    ],
    explanation: 'Role is namespace-scoped, while ClusterRole is cluster-wide. RoleBinding is also namespace-scoped, but ClusterRoleBinding is not.',
    difficulty_level: 'medium',
    points: 10
  },
  {
    question_type: 'command',
    question_text: 'What command checks if the current user can create deployments in the "production" namespace?',
    correct_answer: 'kubectl auth can-i create deployments --namespace=production',
    explanation: 'kubectl auth can-i is used to check if a user has permission to perform an action on a resource.',
    difficulty_level: 'hard',
    points: 15
  },
  {
    question_type: 'true_false',
    question_text: 'ServiceAccount tokens are automatically mounted into pods by default.',
    correct_answer: 'true',
    explanation: 'By default, Kubernetes automatically mounts a ServiceAccount token into pods, which can be disabled using automountServiceAccountToken: false.',
    difficulty_level: 'medium',
    points: 10
  },
  {
    question_type: 'mcq',
    question_text: 'Which authentication method uses the --oidc-issuer-url flag?',
    correct_answer: 'OpenID Connect',
    options: [
      { text: 'X.509 Certificates', correct: false },
      { text: 'OpenID Connect', correct: true },
      { text: 'Service Account Tokens', correct: false },
      { text: 'Static Token File', correct: false }
    ],
    explanation: 'OpenID Connect (OIDC) authentication is configured in kube-apiserver using flags like --oidc-issuer-url, --oidc-client-id, etc.',
    difficulty_level: 'hard',
    points: 15
  }
]

cks_questions.each_with_index do |q, index|
  QuizQuestion.find_or_create_by!(quiz: cks_quiz1, sequence_order: index + 1) do |question|
    question.question_type = q[:question_type]
    question.question_text = q[:question_text]
    question.correct_answer = q[:correct_answer]
    question.options = q[:options].to_json if q[:options]
    question.explanation = q[:explanation]
    question.difficulty_level = q[:difficulty_level]
    question.points = q[:points]
  end
end

# Link CKS items
ModuleItem.find_or_create_by!(
  course_module: cks_mod1,
  item_type: 'CourseLesson',
  item_id: cks_lesson1.id,
  sequence_order: 1
)

ModuleItem.find_or_create_by!(
  course_module: cks_mod1,
  item_type: 'Quiz',
  item_id: cks_quiz1.id,
  sequence_order: 2
)

puts "Created CKS Module 1 with lesson and quiz"

# ==========================
# CKS Practice Bank (120+)
# ==========================

cks_bank_module = CourseModule.find_or_create_by!(course: cks_course, slug: 'practice-bank-cks') do |mod|
  mod.title = 'CKS Practice Question Bank (120+)'
  mod.description = 'Large bank across Kubernetes security domains'
  mod.sequence_order = 8
  mod.estimated_minutes = 220
  mod.published = true
end

cks_bank = Quiz.find_or_create_by!(title: 'CKS Question Bank (120+)') do |quiz|
  quiz.description = 'Comprehensive practice on cluster hardening, network policy, runtime security, supply chain'
  quiz.time_limit_minutes = 0
  quiz.passing_score = 0
  quiz.max_attempts = 0
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

cks_base = [
  { type: 'mcq', text: 'Which field enables default seccomp profile?', options: [
      { text: 'securityContext.seccompProfile.type: RuntimeDefault', correct: true },
      { text: 'securityContext.apparmor: default', correct: false },
      { text: 'podSecurityLevel: baseline', correct: false },
      { text: 'serviceAccount.automount: false', correct: false }
    ], explanation: 'Use spec.securityContext.seccompProfile.type.' },
  { type: 'true_false', text: 'NetworkPolicies require a supporting CNI plugin.', answer: 'true', explanation: 'Not all CNIs enforce NetworkPolicy.' },
  { type: 'command', text: 'Create Role secret-reader for get/list on secrets', answer: 'kubectl create role secret-reader --verb=get --verb=list --resource=secrets', explanation: 'kubectl create role with verbs and resources.' }
]

goal = 120
exists = cks_bank.quiz_questions.count
i = exists
ver = 1
while cks_bank.quiz_questions.count < goal
  cks_base.each do |tpl|
    break if cks_bank.quiz_questions.count >= goal
    i += 1
    case tpl[:type]
    when 'mcq'
      cks_bank.quiz_questions.find_or_create_by!(sequence_order: i) do |qq|
        qq.question_type = 'mcq'
        qq.question_text = "#{tpl[:text]} (v#{ver})"
        qq.options = tpl[:options].to_json
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = ver % 3 == 0 ? 'medium' : 'easy'
        qq.points = 8
      end
    when 'command'
      cks_bank.quiz_questions.find_or_create_by!(sequence_order: i) do |qq|
        qq.question_type = 'command'
        qq.question_text = "#{tpl[:text]} (v#{ver})"
        qq.correct_answer = tpl[:answer]
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = 'medium'
        qq.points = 10
      end
    when 'true_false'
      cks_bank.quiz_questions.find_or_create_by!(sequence_order: i) do |qq|
        qq.question_type = 'true_false'
        qq.question_text = "#{tpl[:text]} (v#{ver})"
        qq.correct_answer = tpl[:answer]
        qq.explanation = tpl[:explanation]
        qq.difficulty_level = 'easy'
        qq.points = 5
      end
    end
  end
  ver += 1
end

ModuleItem.find_or_create_by!(course_module: cks_bank_module, item_type: 'Quiz', item_id: cks_bank.id) do |mi|
  mi.sequence_order = 1
  mi.required = false
end

# Link CKS labs if available
if (lab = HandsOnLab.find_by(title: 'Seccomp and Read-Only Root Filesystem'))
  ModuleItem.find_or_create_by!(course_module: cks_mod2, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 3
    mi.required = true
  end
end
if (lab = HandsOnLab.find_by(title: 'Network Policies: Restrict Pod Egress/Ingress'))
  ModuleItem.find_or_create_by!(course_module: cks_mod3, item_type: 'HandsOnLab', item_id: lab.id) do |mi|
    mi.sequence_order = 3
    mi.required = true
  end
end

# ==============================
# Exam Readiness Modules + Mocks
# ==============================

# CKA Mock Exam
cka_mock_module = CourseModule.find_or_create_by!(course: cka_course, slug: 'exam-readiness-cka-mock-1') do |mod|
  mod.title = 'Exam Readiness: CKA Mock 1'
  mod.description = 'Timed mixed-topic CKA practice'
  mod.sequence_order = 10
  mod.estimated_minutes = 120
  mod.published = true
end

cka_mock = Quiz.find_or_create_by!(title: 'CKA Mock Exam 1') do |quiz|
  quiz.description = '120-minute practice on cluster admin domains'
  quiz.time_limit_minutes = 120
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = false
end

cka_mock_questions = [
  { question_type: 'mcq', question_text: 'Which command backs up etcd data safely on control-plane?', options: [
      { text: 'etcdctl snapshot save', correct: true },
      { text: 'kubectl get etcd', correct: false },
      { text: 'etcd snapshot backup', correct: false },
      { text: 'kubeadm etcd backup', correct: false }
    ], explanation: 'Use etcdctl v3 with snapshot save.', difficulty_level: 'hard', points: 12 },
  { question_type: 'command', question_text: 'Drain node node01 for maintenance ignoring DaemonSets and deleting local data', correct_answer: 'kubectl drain node01 --ignore-daemonsets --delete-emptydir-data', explanation: 'kubectl drain flags for safe maintenance.', difficulty_level: 'medium', points: 10 },
  { question_type: 'mcq', question_text: 'Default policy types when only ingress rules are specified?', options: [
      { text: 'Ingress', correct: true }, { text: 'Ingress,Egress', correct: false }, { text: 'Egress', correct: false }, { text: 'None', correct: false }
    ], explanation: 'If only ingress specified, policyTypes defaults to Ingress.', difficulty_level: 'medium', points: 8 },
  { question_type: 'true_false', question_text: 'ClusterRole is namespace-scoped.', correct_answer: 'false', explanation: 'ClusterRole is cluster-scoped.', difficulty_level: 'easy', points: 6 }
]

cka_mock_questions.each_with_index do |q, i|
  QuizQuestion.find_or_create_by!(quiz: cka_mock, sequence_order: i + 1) do |question|
    question.question_type = q[:question_type]
    question.question_text = q[:question_text]
    question.correct_answer = q[:correct_answer]
    question.options = q[:options].to_json if q[:options]
    question.explanation = q[:explanation]
    question.difficulty_level = q[:difficulty_level]
    question.points = q[:points]
  end
end

ModuleItem.find_or_create_by!(course_module: cka_mock_module, item: cka_mock, sequence_order: 1)

# CKAD Mock Exam
ckad_mock_module = CourseModule.find_or_create_by!(course: ckad_course, slug: 'exam-readiness-ckad-mock-1') do |mod|
  mod.title = 'Exam Readiness: CKAD Mock 1'
  mod.description = 'Timed practice for app developer scenarios'
  mod.sequence_order = 10
  mod.estimated_minutes = 90
  mod.published = true
end

ckad_mock = Quiz.find_or_create_by!(title: 'CKAD Mock Exam 1') do |quiz|
  quiz.description = '90-minute practice on Pods, Config, Services, and Observability'
  quiz.time_limit_minutes = 90
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = false
end

ckad_mock_qs = [
  { question_type: 'command', question_text: 'Create a multi-container Pod with an app and sidecar busybox that tails /var/log/app.log', correct_answer: "kubectl apply -f - <<'EOF'\\napiVersion: v1\\nkind: Pod\\nmetadata: { name: multic }\\nspec:\\n  containers:\\n  - name: app\\n    image: nginx\\n  - name: sidecar\\n    image: busybox\\n    args: ['sh','-c','tail -F /var/log/app.log']\\nEOF", explanation: 'Multi-container pods share volumes and network.', difficulty_level: 'medium', points: 10 },
  { question_type: 'mcq', question_text: 'Which object exposes a Deployment internally at stable DNS?', options: [
      { text: 'Service', correct: true }, { text: 'Ingress', correct: false }, { text: 'EndpointSlice', correct: false }, { text: 'NetworkPolicy', correct: false }
    ], explanation: 'Service provides cluster IP and DNS.', difficulty_level: 'easy', points: 6 }
]

ckad_mock_qs.each_with_index do |q, i|
  QuizQuestion.find_or_create_by!(quiz: ckad_mock, sequence_order: i + 1) do |question|
    question.question_type = q[:question_type]
    question.question_text = q[:question_text]
    question.correct_answer = q[:correct_answer]
    question.options = q[:options].to_json if q[:options]
    question.explanation = q[:explanation]
    question.difficulty_level = q[:difficulty_level]
    question.points = q[:points]
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mock_module, item: ckad_mock, sequence_order: 1)

# CKS Mock Exam
cks_mock_module = CourseModule.find_or_create_by!(course: cks_course, slug: 'exam-readiness-cks-mock-1') do |mod|
  mod.title = 'Exam Readiness: CKS Mock 1'
  mod.description = 'Timed practice for Kubernetes security domains'
  mod.sequence_order = 10
  mod.estimated_minutes = 90
  mod.published = true
end

cks_mock = Quiz.find_or_create_by!(title: 'CKS Mock Exam 1') do |quiz|
  quiz.description = '90-minute practice on cluster and workload security'
  quiz.time_limit_minutes = 90
  quiz.passing_score = 75
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = false
end

cks_mock_qs = [
  { question_type: 'mcq', question_text: 'What field enables default seccomp profile?', options: [
      { text: 'securityContext.seccompProfile.type: RuntimeDefault', correct: true },
      { text: 'securityContext.apparmor: default', correct: false },
      { text: 'podSecurityLevel: baseline', correct: false },
      { text: 'serviceAccount.automount: false', correct: false }
    ], explanation: 'Set spec.securityContext.seccompProfile.type.', difficulty_level: 'medium', points: 8 },
  { question_type: 'true_false', question_text: 'NetworkPolicies affect hostNetwork pods by default.', correct_answer: 'false', explanation: 'Policies target Pods; hostNetwork often bypasses CNI rules.', difficulty_level: 'hard', points: 10 }
]

cks_mock_qs.each_with_index do |q, i|
  QuizQuestion.find_or_create_by!(quiz: cks_mock, sequence_order: i + 1) do |question|
    question.question_type = q[:question_type]
    question.question_text = q[:question_text]
    question.correct_answer = q[:correct_answer]
    question.options = q[:options].to_json if q[:options]
    question.explanation = q[:explanation]
    question.difficulty_level = q[:difficulty_level]
    question.points = q[:points]
  end
end

ModuleItem.find_or_create_by!(course_module: cks_mock_module, item: cks_mock, sequence_order: 1)

# ==================
# Mock Exam 2 (All)
# ==================

# CKA Mock Exam 2
cka_mock_module2 = CourseModule.find_or_create_by!(course: cka_course, slug: 'exam-readiness-cka-mock-2') do |mod|
  mod.title = 'Exam Readiness: CKA Mock 2'
  mod.description = 'Second timed CKA mock'
  mod.sequence_order = 11
  mod.estimated_minutes = 120
  mod.published = true
end

cka_mock2 = Quiz.find_or_create_by!(title: 'CKA Mock Exam 2') do |quiz|
  quiz.description = '120-minute practice covering networking, storage, RBAC, maintenance'
  quiz.time_limit_minutes = 120
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = false
end

(1..24).each do |n|
  QuizQuestion.find_or_create_by!(quiz: cka_mock2, sequence_order: n) do |qq|
    if n % 2 == 0
      qq.question_type = 'command'
      qq.question_text = "Backup etcd snapshot to /var/backups/etcd-#{n}.db"
      qq.correct_answer = 'ETCDCTL_API=3 etcdctl snapshot save /var/backups/etcd.db'
      qq.explanation = 'Use etcdctl v3 snapshot save.'
      qq.difficulty_level = 'hard'
      qq.points = 12
    else
      qq.question_type = 'mcq'
      qq.question_text = "Which taint prevents new Pods from scheduling? (Q#{n})"
      qq.options = [
        { text: 'node.kubernetes.io/unschedulable:NoSchedule', correct: true },
        { text: 'node.kubernetes.io/unschedulable:PreferNoSchedule', correct: false },
        { text: 'node-role.kubernetes.io/master:NoExecute', correct: false },
        { text: 'No effect', correct: false }
      ].to_json
      qq.explanation = 'NoSchedule prevents scheduling; NoExecute evicts.'
      qq.difficulty_level = 'medium'
      qq.points = 8
    end
  end
end

ModuleItem.find_or_create_by!(course_module: cka_mock_module2, item_type: 'Quiz', item_id: cka_mock2.id) do |mi|
  mi.sequence_order = 1
  mi.required = true
end

# CKAD Mock Exam 2
ckad_mock_module2 = CourseModule.find_or_create_by!(course: ckad_course, slug: 'exam-readiness-ckad-mock-2') do |mod|
  mod.title = 'Exam Readiness: CKAD Mock 2'
  mod.description = 'Second timed CKAD mock'
  mod.sequence_order = 11
  mod.estimated_minutes = 90
  mod.published = true
end

ckad_mock2 = Quiz.find_or_create_by!(title: 'CKAD Mock Exam 2') do |quiz|
  quiz.description = '90-minute practice on Pods, Config, Services, and Observability'
  quiz.time_limit_minutes = 90
  quiz.passing_score = 70
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = false
end

(1..24).each do |n|
  QuizQuestion.find_or_create_by!(quiz: ckad_mock2, sequence_order: n) do |qq|
    if n % 2 == 1
      qq.question_type = 'command'
      qq.question_text = "Create a Deployment appsrv with 3 replicas using nginx:1.25"
      qq.correct_answer = 'kubectl create deploy appsrv --image=nginx:1.25 --replicas=3'
      qq.explanation = 'kubectl create deploy <name> --image=... --replicas=...'
      qq.difficulty_level = 'medium'
      qq.points = 10
    else
      qq.question_type = 'mcq'
      qq.question_text = "Which probe ensures Pod receives traffic only when ready? (Q#{n})"
      qq.options = [
        { text: 'readinessProbe', correct: true },
        { text: 'livenessProbe', correct: false },
        { text: 'startupProbe', correct: false },
        { text: 'healthcheck', correct: false }
      ].to_json
      qq.explanation = 'Readiness gates Service endpoints.'
      qq.difficulty_level = 'easy'
      qq.points = 6
    end
  end
end

ModuleItem.find_or_create_by!(course_module: ckad_mock_module2, item_type: 'Quiz', item_id: ckad_mock2.id) do |mi|
  mi.sequence_order = 1
  mi.required = true
end

# CKS Mock Exam 2
cks_mock_module2 = CourseModule.find_or_create_by!(course: cks_course, slug: 'exam-readiness-cks-mock-2') do |mod|
  mod.title = 'Exam Readiness: CKS Mock 2'
  mod.description = 'Second timed CKS mock'
  mod.sequence_order = 11
  mod.estimated_minutes = 90
  mod.published = true
end

cks_mock2 = Quiz.find_or_create_by!(title: 'CKS Mock Exam 2') do |quiz|
  quiz.description = '90-minute practice on RBAC, NetworkPolicy, and runtime hardening'
  quiz.time_limit_minutes = 90
  quiz.passing_score = 75
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = false
end

(1..24).each do |n|
  QuizQuestion.find_or_create_by!(quiz: cks_mock2, sequence_order: n) do |qq|
    if n % 3 == 0
      qq.question_type = 'true_false'
      qq.question_text = 'RoleBinding can reference a ClusterRole.'
      qq.correct_answer = 'true'
      qq.explanation = 'RoleBinding can bind a ClusterRole in a namespace.'
      qq.difficulty_level = 'medium'
      qq.points = 8
    elsif n.odd?
      qq.question_type = 'command'
      qq.question_text = 'Create NetworkPolicy deny-all for namespace default'
      qq.correct_answer = 'kubectl apply -f deny-all.yaml'
      qq.explanation = 'Apply a policy with empty podSelector and both policyTypes.'
      qq.difficulty_level = 'medium'
      qq.points = 10
    else
      qq.question_type = 'mcq'
      qq.question_text = 'Which setting disables automounting SA token for a specific Pod?'
      qq.options = [
        { text: 'automountServiceAccountToken: false', correct: true },
        { text: 'serviceAccountAutomount: false', correct: false },
        { text: 'disableSAToken: true', correct: false },
        { text: 'tokenAuto: off', correct: false }
      ].to_json
      qq.explanation = 'Set spec.automountServiceAccountToken: false.'
      qq.difficulty_level = 'easy'
      qq.points = 6
    end
  end
end

ModuleItem.find_or_create_by!(course_module: cks_mock_module2, item_type: 'Quiz', item_id: cks_mock2.id) do |mi|
  mi.sequence_order = 1
  mi.required = true
end

# Additional achievements for Kubernetes certifications
kubernetes_achievements = [
  {
    name: 'CKA Master',
    slug: 'cka-master',
    description: 'Complete the CKA certification course',
    icon_url: 'fas fa-certificate',
    badge_type: 'gold',
    category: 'course_completion',
    criteria: { type: 'complete_course', course_id: cka_course.id }.to_json,
    points_value: 500
  },
  {
    name: 'CKAD Developer',
    slug: 'ckad-developer',
    description: 'Complete the CKAD certification course',
    icon_url: 'fas fa-code',
    badge_type: 'silver',
    category: 'course_completion',
    criteria: { type: 'complete_course', course_id: ckad_course.id }.to_json,
    points_value: 400
  },
  {
    name: 'Security Specialist',
    slug: 'security-specialist',
    description: 'Complete the CKS certification course',
    icon_url: 'fas fa-shield-alt',
    badge_type: 'platinum',
    category: 'course_completion',
    criteria: { type: 'complete_course', course_id: cks_course.id }.to_json,
    points_value: 600
  },
  {
    name: 'Kubernetes Ninja',
    slug: 'kubernetes-ninja',
    description: 'Complete all three Kubernetes certification courses',
    icon_url: 'fas fa-trophy',
    badge_type: 'platinum',
    category: 'course_completion',
    criteria: { type: 'complete_all_courses', course_ids: [cka_course.id, ckad_course.id, cks_course.id] }.to_json,
    points_value: 1000
  }
]

kubernetes_achievements.each do |achievement_data|
  CourseAchievement.find_or_create_by!(slug: achievement_data[:slug]) do |achievement|
    achievement.name = achievement_data[:name]
    achievement.description = achievement_data[:description]
    achievement.icon_url = achievement_data[:icon_url]
    achievement.badge_type = achievement_data[:badge_type]
    achievement.category = achievement_data[:category]
    achievement.criteria = achievement_data[:criteria]
    achievement.points_value = achievement_data[:points_value]
  end
end

puts "\n✅ Kubernetes Certification Courses Created Successfully!"
puts "   - CKA: #{cka_course.course_modules.count} modules"
puts "   - CKAD: #{ckad_course.course_modules.count} modules"
puts "   - CKS: #{cks_course.course_modules.count} modules"
puts "   - Total Achievements: #{kubernetes_achievements.count}"
puts "\nRun 'rails db:seed' to load all seed data including these courses."

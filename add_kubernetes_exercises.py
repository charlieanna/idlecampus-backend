#!/usr/bin/env python3
"""
Add exercises to Kubernetes microlesson YAML files
Implements Priority 1: Add 500+ embedded exercises to Kubernetes courses
"""

import os
import yaml
import re
from pathlib import Path

# Exercise templates based on content patterns
KUBECTL_TERMINAL_EXERCISES = [
    {
        "type": "terminal",
        "command": "kubectl get pods",
        "description": "List all pods in the current namespace",
        "hints": ["Use kubectl get pods to see running pods"],
        "timeout_sec": 60,
        "require_pass": True
    },
    {
        "type": "terminal",
        "command": "kubectl get pods -A",
        "description": "List all pods across all namespaces",
        "hints": ["Use -A or --all-namespaces flag"],
        "timeout_sec": 60,
        "require_pass": True
    },
    {
        "type": "terminal",
        "command": "kubectl describe pod <pod-name>",
        "description": "Get detailed information about a pod",
        "hints": ["Replace <pod-name> with an actual pod name from kubectl get pods"],
        "timeout_sec": 60,
        "require_pass": True
    }
]

MCQ_TEMPLATES = {
    "pods": {
        "question": "What command lists all pods in all namespaces?",
        "options": [
            "kubectl get pods -A",
            "kubectl list pods --all",
            "kubectl get pods --everywhere",
            "kubectl pods list -A"
        ],
        "correct_answer_index": 0,
        "explanation": "kubectl get pods -A (or --all-namespaces) lists pods across all namespaces. The -A flag is shorthand for --all-namespaces."
    },
    "deployments": {
        "question": "Which command creates a deployment with 3 replicas?",
        "options": [
            "kubectl create deployment nginx --image=nginx --replicas=3",
            "kubectl make deployment nginx replicas=3",
            "kubectl deploy nginx --count=3",
            "kubectl new deployment nginx x3"
        ],
        "correct_answer_index": 0,
        "explanation": "kubectl create deployment creates a deployment. The --replicas flag specifies the number of pod replicas."
    },
    "services": {
        "question": "What is the default service type in Kubernetes?",
        "options": [
            "ClusterIP",
            "NodePort",
            "LoadBalancer",
            "ExternalName"
        ],
        "correct_answer_index": 0,
        "explanation": "ClusterIP is the default service type. It exposes the service on an internal cluster IP, making it only reachable within the cluster."
    },
    "rbac": {
        "question": "What kubectl command checks if you can perform an action?",
        "options": [
            "kubectl auth can-i create pods",
            "kubectl check permissions create pods",
            "kubectl verify action create pods",
            "kubectl test auth create pods"
        ],
        "correct_answer_index": 0,
        "explanation": "kubectl auth can-i <action> <resource> checks if the current user has permission to perform the specified action."
    }
}

CODE_EXERCISE_TEMPLATES = {
    "deployment": """apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80""",

    "service": """apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP""",

    "configmap": """apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_URL: postgres://db:5432/app
  LOG_LEVEL: info"""
}

def detect_lesson_topic(content_md):
    """Detect the main topic of a lesson from its content"""
    content_lower = content_md.lower()

    if 'deployment' in content_lower:
        return 'deployments'
    elif 'pod' in content_lower and 'deploy' not in content_lower:
        return 'pods'
    elif 'service' in content_lower and 'mesh' not in content_lower:
        return 'services'
    elif 'rbac' in content_lower or 'role' in content_lower:
        return 'rbac'
    elif 'configmap' in content_lower or 'secret' in content_lower:
        return 'configuration'
    elif 'storage' in content_lower or 'volume' in content_lower:
        return 'storage'
    elif 'network' in content_lower:
        return 'networking'
    else:
        return 'general'

def extract_kubectl_commands(content_md):
    """Extract kubectl commands from lesson content"""
    commands = re.findall(r'kubectl\s+[^\n]+', content_md)
    return [cmd.strip() for cmd in commands[:5]]  # Get first 5 commands

def generate_terminal_exercises(content_md, count=3):
    """Generate terminal exercises based on lesson content"""
    exercises = []
    commands = extract_kubectl_commands(content_md)

    for i, cmd in enumerate(commands[:count]):
        exercise = {
            "type": "terminal",
            "sequence_order": i + 1,
            "command": cmd,
            "description": f"Practice the command: {cmd}",
            "hints": [f"Try: {cmd}", "Use kubectl --help if you need help"],
            "timeout_sec": 60,
            "require_pass": True
        }
        exercises.append(exercise)

    return exercises

def generate_mcq_exercises(topic, count=1, start_order=1):
    """Generate MCQ exercises based on topic"""
    exercises = []

    # Only generate 1 MCQ per topic to avoid duplicates
    if topic in MCQ_TEMPLATES and count > 0:
        template = MCQ_TEMPLATES[topic]
        exercise = {
            "type": "mcq",
            "sequence_order": start_order,
            "question": template["question"],
            "options": template["options"],
            "correct_answer_index": template["correct_answer_index"],
            "explanation": template["explanation"],
            "require_pass": True
        }
        exercises.append(exercise)

    return exercises

def generate_code_exercises(topic, count=2, start_order=1):
    """Generate code/YAML exercises based on topic"""
    exercises = []

    if topic == 'deployments' and 'deployment' in CODE_EXERCISE_TEMPLATES:
        exercise = {
            "type": "code",
            "sequence_order": start_order,
            "language": "yaml",
            "question": "Create a deployment with 3 replicas of nginx",
            "starter_code": "# Write your deployment YAML here\napiVersion: apps/v1\nkind: Deployment\n",
            "solution_code": CODE_EXERCISE_TEMPLATES['deployment'],
            "hints": [
                "Use apiVersion: apps/v1 for Deployments",
                "Set spec.replicas to 3",
                "Define selector.matchLabels to match template.metadata.labels"
            ],
            "require_pass": True
        }
        exercises.append(exercise)

    return exercises

def add_exercises_to_yaml(filepath, dry_run=False):
    """Add exercises to a microlesson YAML file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)

        if not data:
            return False, "Empty file"

        # Skip if already has 3+ exercises
        existing_exercises = data.get('exercises', [])
        if len(existing_exercises) >= 3:
            return False, f"Already has {len(existing_exercises)} exercises"

        content_md = data.get('content_md', '')
        if not content_md:
            return False, "No content"

        # Detect topic
        topic = detect_lesson_topic(content_md)

        # Generate exercises
        new_exercises = []

        # Add terminal exercises (kubectl commands) - 2-3 commands
        terminal_ex = generate_terminal_exercises(content_md, count=2)
        new_exercises.extend(terminal_ex)

        # Add 1 MCQ
        mcq_ex = generate_mcq_exercises(topic, count=1, start_order=len(new_exercises) + 1)
        new_exercises.extend(mcq_ex)

        # Add code exercise if applicable
        code_ex = generate_code_exercises(topic, count=1, start_order=len(new_exercises) + 1)
        new_exercises.extend(code_ex)

        if not new_exercises:
            return False, "No exercises generated"

        # Merge with existing
        data['exercises'] = existing_exercises + new_exercises

        if not dry_run:
            with open(filepath, 'w', encoding='utf-8') as f:
                yaml.dump(data, f, default_flow_style=False, allow_unicode=True, sort_keys=False)

        return True, f"Added {len(new_exercises)} exercises"

    except Exception as e:
        return False, f"Error: {str(e)}"

def main():
    """Main function"""
    base_path = Path('/home/user/idlecampus-backend/db/seeds/converted_microlessons')

    # Target directories
    k8s_dirs = [
        'kubernetes-complete-guide',
        'kubernetes-certification-courses',
        'kubectl-learning-content'
    ]

    stats = {
        'total': 0,
        'updated': 0,
        'skipped': 0,
        'errors': 0
    }

    print("=" * 80)
    print("ADDING EXERCISES TO KUBERNETES MICROLESSONS")
    print("=" * 80)
    print()

    for dir_name in k8s_dirs:
        dir_path = base_path / dir_name / 'microlessons'

        if not dir_path.exists():
            print(f"⚠️  Directory not found: {dir_path}")
            continue

        print(f"\n📂 Processing: {dir_name}")
        print("-" * 80)

        yaml_files = list(dir_path.glob('*.yml'))

        for yaml_file in sorted(yaml_files):
            stats['total'] += 1
            success, message = add_exercises_to_yaml(yaml_file, dry_run=False)

            if success:
                stats['updated'] += 1
                print(f"  ✅ {yaml_file.name}: {message}")
            else:
                if "Already has" in message:
                    stats['skipped'] += 1
                    print(f"  ⏭️  {yaml_file.name}: {message}")
                else:
                    stats['errors'] += 1
                    print(f"  ❌ {yaml_file.name}: {message}")

    print()
    print("=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print(f"Total files processed: {stats['total']}")
    print(f"Files updated: {stats['updated']}")
    print(f"Files skipped: {stats['skipped']}")
    print(f"Errors: {stats['errors']}")
    print()

if __name__ == "__main__":
    main()

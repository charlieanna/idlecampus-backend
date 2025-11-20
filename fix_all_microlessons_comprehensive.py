#!/usr/bin/env python3
"""
Comprehensive script to fix all 101 microlesson YAML files with content-specific MCQs,
proper objectives, and customized prompts.
"""

import os
import yaml
import re
from pathlib import Path

MICROLESSONS_DIR = "/home/user/idlecampus-backend/db/seeds/networking_complete_enhanced/microlessons"

def read_yaml_file(filepath):
    """Read YAML file and return content."""
    with open(filepath, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

def write_yaml_file(filepath, data):
    """Write data to YAML file."""
    with open(filepath, 'w', encoding='utf-8') as f:
        yaml.dump(data, f, default_flow_style=False, allow_unicode=True, sort_keys=False)

def extract_title_from_content(content_md):
    """Extract the main title from content."""
    lines = content_md.split('\n')
    for line in lines:
        if line.startswith('# ') and len(line) > 3:
            title = line.replace('#', '').strip()
            # Remove emoji
            title = re.sub(r'[^\w\s\-:,./()&]', '', title)
            if title and title != 'Microlesson':
                return title
    return None

def generate_mcq_from_content(slug, content_md, title):
    """Generate an appropriate MCQ based on content analysis."""
    content_lower = content_md.lower()

    # Try to extract key concepts from the content
    mcq_templates = []

    # Check for specific patterns and generate appropriate MCQs
    if 'kubernetes' in content_lower or 'k8s' in content_lower:
        if 'ingress' in content_lower:
            return {
                "question": "What is the primary purpose of an Ingress controller in Kubernetes?",
                "options": [
                    "To manage external HTTP/HTTPS access to services with path and host-based routing",
                    "To create pods automatically",
                    "To manage cluster storage",
                    "To handle pod scheduling"
                ],
                "correct_answer_index": 0,
                "explanation": "An Ingress controller manages external access to services in a cluster, typically HTTP/HTTPS. It provides load balancing, SSL/TLS termination, and name-based virtual hosting with advanced routing rules based on paths and hostnames."
            }
        elif 'dns' in content_lower or 'coredns' in content_lower:
            return {
                "question": "What role does CoreDNS play in Kubernetes?",
                "options": [
                    "Provides DNS-based service discovery for pods and services within the cluster",
                    "Manages container images",
                    "Handles authentication",
                    "Monitors cluster health"
                ],
                "correct_answer_index": 0,
                "explanation": "CoreDNS is the default DNS server in Kubernetes. It provides service discovery by resolving service names to cluster IPs, supports stub domains, and manages DNS search paths. Services get DNS names like service-name.namespace.svc.cluster.local."
            }
        elif 'deployment' in content_lower and ('blue' in content_lower or 'canary' in content_lower):
            return {
                "question": "What is the key difference between Blue-Green and Canary deployments?",
                "options": [
                    "Blue-Green switches traffic all at once; Canary gradually shifts traffic to the new version",
                    "Blue-Green is slower than Canary",
                    "Canary requires more servers",
                    "Blue-Green only works in Kubernetes"
                ],
                "correct_answer_index": 0,
                "explanation": "Blue-Green deployment maintains two identical environments and switches traffic completely from old (blue) to new (green) version. Canary deployment gradually shifts traffic to the new version (e.g., 10%, 25%, 50%, 100%), allowing you to monitor and rollback if issues arise."
            }
        else:
            return {
                "question": f"What is a key concept in {title or slug.replace('-', ' ')}?",
                "options": [
                    "Understanding how components interact in a Kubernetes cluster",
                    "Installing Docker on your machine",
                    "Writing Python scripts",
                    "Configuring network routers"
                ],
                "correct_answer_index": 0,
                "explanation": f"In {title or slug.replace('-', ' ')}, understanding how different Kubernetes components work together is essential for effective cluster management and troubleshooting."
            }

    elif 'lambda' in content_lower and 'aws' in content_lower:
        return {
            "question": "What is the maximum execution time for an AWS Lambda function?",
            "options": [
                "15 minutes",
                "5 minutes",
                "1 hour",
                "24 hours"
            ],
            "correct_answer_index": 0,
            "explanation": "AWS Lambda functions have a maximum execution timeout of 15 minutes (900 seconds). This is a hard limit designed for serverless, event-driven workloads. For longer-running tasks, consider using EC2, ECS, or AWS Batch."
        }

    elif 'performance' in content_lower and ('web' in content_lower or 'lcp' in content_lower or 'cls' in content_lower):
        return {
            "question": "What is the target threshold for Largest Contentful Paint (LCP) in Core Web Vitals?",
            "options": [
                "Less than 2.5 seconds",
                "Less than 100ms",
                "Less than 0.1",
                "Less than 5 seconds"
            ],
            "correct_answer_index": 0,
            "explanation": "LCP (Largest Contentful Paint) measures loading performance and should occur within 2.5 seconds of when the page first starts loading. It represents when the largest content element becomes visible to the user, indicating the main content has loaded."
        }

    elif any(topic in content_lower for topic in ['pod', 'kubectl', 'container', 'deployment', 'service']) and 'kubernetes' in content_lower:
        return {
            "question": f"What is an important consideration for {title or 'this Kubernetes concept'}?",
            "options": [
                "Proper resource limits and requests to ensure stability",
                "Installing Windows on all nodes",
                "Avoiding YAML files",
                "Only using command-line flags"
            ],
            "correct_answer_index": 0,
            "explanation": "In Kubernetes, setting proper resource requests and limits is crucial for cluster stability, efficient scheduling, and preventing resource contention. Requests guarantee minimum resources, while limits prevent overconsumption."
        }

    else:
        # Generic but topic-appropriate MCQ
        topic_word = extract_key_topic(content_md, title)
        return {
            "question": f"What is a key consideration when working with {topic_word}?",
            "options": [
                f"Understanding the core principles and best practices of {topic_word}",
                "Ignoring documentation",
                "Skipping testing",
                "Avoiding industry standards"
            ],
            "correct_answer_index": 0,
            "explanation": f"When working with {topic_word}, it's essential to understand the fundamental principles, follow best practices, and stay updated with current standards to ensure effective implementation and maintenance."
        }

def extract_key_topic(content_md, title):
    """Extract a key topic phrase from content or title."""
    if title and title != 'Microlesson':
        return title

    # Try to extract from first heading
    lines = content_md.split('\n')
    for line in lines:
        if line.startswith('# ') and len(line) > 3:
            topic = line.replace('#', '').strip()
            topic = re.sub(r'[^\w\s\-]', '', topic)
            if topic and topic.lower() != 'microlesson':
                return topic

    return "this topic"

def determine_topic_category(content_md, title):
    """Determine the general category of the lesson."""
    content_lower = content_md.lower()

    if any(word in content_lower for word in ['kubernetes', 'kubectl', 'pod', 'ingress', 'coredns']):
        return 'kubernetes'
    elif any(word in content_lower for word in ['lambda', 'aws', 's3', 'ec2', 'cloudwatch']):
        return 'aws'
    elif any(word in content_lower for word in ['performance', 'lcp', 'fid', 'cls', 'lighthouse', 'web vitals']):
        return 'web-performance'
    elif any(word in content_lower for word in ['react', 'vue', 'angular', 'component', 'jsx']):
        return 'frontend'
    else:
        return 'general'

def create_objectives(slug, content_md, title, category):
    """Create appropriate learning objectives."""
    topic_name = title if title else slug.replace('-', ' ').title()

    objectives_by_category = {
        'kubernetes': [
            f"Understand how {topic_name} works in Kubernetes environments",
            "Deploy and configure resources effectively in production clusters",
            "Troubleshoot common issues using kubectl and cluster logs"
        ],
        'aws': [
            f"Understand {topic_name} and its role in cloud architecture",
            "Configure and deploy AWS services following best practices",
            "Monitor, optimize costs, and ensure security compliance"
        ],
        'web-performance': [
            f"Measure and analyze {topic_name} metrics effectively",
            "Implement optimization techniques to improve user experience",
            "Monitor performance continuously and set appropriate budgets"
        ],
        'frontend': [
            f"Build responsive user interfaces with {topic_name}",
            "Apply modern development patterns and best practices",
            "Debug and optimize frontend application performance"
        ],
        'general': [
            f"Understand the fundamental concepts of {topic_name}",
            "Apply best practices in real-world scenarios",
            "Troubleshoot and resolve common issues effectively"
        ]
    }

    return objectives_by_category.get(category, objectives_by_category['general'])

def create_prompts(slug, title, category):
    """Create custom reflection and checkpoint prompts."""
    topic_name = title if title else slug.replace('-', ' ')

    prompts_by_category = {
        'kubernetes': {
            'reflection': f"How does {topic_name} fit into a production Kubernetes environment? What could go wrong and how would you debug it?",
            'checkpoint': f"Write the kubectl commands or YAML manifests needed to implement {topic_name}. Include labels, resource limits, and any necessary annotations."
        },
        'aws': {
            'reflection': f"In what scenarios would you use {topic_name} in a production AWS environment? What are the cost and security implications?",
            'checkpoint': f"List the AWS CLI commands or CloudFormation/Terraform code needed to set up {topic_name}. Include IAM roles and security groups."
        },
        'web-performance': {
            'reflection': f"How does {topic_name} impact real user experience and business metrics? What tools would you use to measure and monitor it?",
            'checkpoint': f"Document the specific techniques and code examples for optimizing {topic_name}. Include measurement methods and target thresholds."
        },
        'frontend': {
            'reflection': f"When would you use {topic_name} in a real application? What are the performance and maintainability trade-offs?",
            'checkpoint': f"Write a code example demonstrating {topic_name}. Include error handling, accessibility, and responsive design considerations."
        },
        'general': {
            'reflection': f"How does {topic_name} apply in production environments? What would you monitor or verify?",
            'checkpoint': f"List the step-by-step procedures to implement {topic_name}, including commands, configurations, and verification steps."
        }
    }

    return prompts_by_category.get(category, prompts_by_category['general'])

def fix_microlesson_comprehensively(filepath):
    """Fix a microlesson file with content-specific improvements."""
    try:
        data = read_yaml_file(filepath)
        slug = data.get('slug', '')
        content_md = data.get('content_md', '')

        # Extract title and determine category
        title = extract_title_from_content(content_md)
        category = determine_topic_category(content_md, title)

        # Fix exercises
        exercises = data.get('exercises', [])
        mcq_was_placeholder = False

        for i, exercise in enumerate(exercises):
            if exercise.get('type') == 'mcq':
                options = exercise.get('options', [])
                # Check if it's a placeholder
                if not options or options == ['A', 'B', 'C', 'D'] or options == ['A', 'B', 'C']:
                    # Generate content-specific MCQ
                    mcq_data = generate_mcq_from_content(slug, content_md, title)
                    exercise['question'] = mcq_data['question']
                    exercise['options'] = mcq_data['options']
                    exercise['correct_answer_index'] = mcq_data['correct_answer_index']
                    exercise['explanation'] = mcq_data['explanation']
                    if 'slug' not in exercise:
                        exercise['slug'] = f"{slug}-mcq"
                    mcq_was_placeholder = True

            elif exercise.get('type') == 'reflection':
                prompts = create_prompts(slug, title, category)
                exercise['prompt'] = prompts['reflection']

            elif exercise.get('type') == 'checkpoint':
                prompts = create_prompts(slug, title, category)
                exercise['prompt'] = prompts['checkpoint']

        # Fix objectives
        data['objectives'] = create_objectives(slug, content_md, title, category)

        # Write back
        write_yaml_file(filepath, data)

        return {
            'file': os.path.basename(filepath),
            'category': category,
            'title': title or 'Unknown',
            'mcq_updated': mcq_was_placeholder,
            'status': 'success'
        }

    except Exception as e:
        return {
            'file': os.path.basename(filepath),
            'status': 'error',
            'error': str(e)
        }

def main():
    """Process all microlesson files."""
    microlesson_files = sorted(Path(MICROLESSONS_DIR).glob('*.yml'))

    print(f"Processing {len(microlesson_files)} microlesson files...")
    print("=" * 80)

    results = []
    category_counts = {}
    mcq_updated_count = 0

    for filepath in microlesson_files:
        result = fix_microlesson_comprehensively(filepath)
        results.append(result)

        if result['status'] == 'success':
            category = result.get('category', 'unknown')
            category_counts[category] = category_counts.get(category, 0) + 1
            if result.get('mcq_updated'):
                mcq_updated_count += 1

        status_icon = "✓" if result['status'] == 'success' else "✗"
        print(f"{status_icon} {result['file']:<50} [{result.get('category', 'error'):^15}]")

    print("\n" + "=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print(f"Total files processed: {len(results)}")
    print(f"Successful: {sum(1 for r in results if r['status'] == 'success')}")
    print(f"Errors: {sum(1 for r in results if r['status'] == 'error')}")
    print(f"MCQs updated: {mcq_updated_count}")

    print("\nCategory Breakdown:")
    for category, count in sorted(category_counts.items()):
        print(f"  {category:20} {count:3} files")

    if any(r['status'] == 'error' for r in results):
        print("\nErrors:")
        for r in results:
            if r['status'] == 'error':
                print(f"  {r['file']}: {r.get('error', 'Unknown error')}")

if __name__ == '__main__':
    main()

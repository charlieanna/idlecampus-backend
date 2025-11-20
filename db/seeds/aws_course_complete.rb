# AWS Cloud Architecture - Complete Course with Lessons and Quizzes
puts "Creating Complete AWS Cloud Architecture Course..."

aws_course = Course.find_or_create_by!(slug: 'aws-cloud-architecture') do |course|
  course.title = "AWS Cloud Architecture"
  course.description = "Build production-ready cloud infrastructure on AWS. Master compute, storage, networking, and serverless services through hands-on labs."
  course.difficulty_level = "intermediate"
  course.estimated_hours = 35
  course.certification_track = nil
  course.published = true
  course.sequence_order = 11
  course.learning_objectives = JSON.generate([
    "Design highly available AWS architectures",
    "Master EC2, S3, VPC, and Lambda services",
    "Implement security best practices with IAM",
    "Configure auto-scaling and load balancing",
    "Prepare for AWS Solutions Architect certification"
  ])
  course.prerequisites = JSON.generate([
    "Basic cloud computing concepts",
    "Understanding of networking (TCP/IP, DNS)",
    "Linux command line familiarity"
  ])
end

puts "Created course: #{aws_course.title}"

# ==========================================
# MODULE 1: AWS Fundamentals & IAM
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'aws-fundamentals', course: aws_course) do |mod|
  mod.title = "AWS Fundamentals & IAM"
  mod.description = "Introduction to AWS services, regions, and Identity Access Management"
  mod.sequence_order = 1
  mod.estimated_minutes = 200
  mod.published = true
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "AWS Global Infrastructure") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # AWS Global Infrastructure

    ### Why Does AWS Have a Global Infrastructure?

    **The Problem:**
    Running a website from ONE location means:
    - Users far away experience high latency
    - One power outage = entire service down
    - Legal restrictions on where data can be stored

    **AWS's Solution:**
    Distribute infrastructure globally across **Regions**, **Availability Zones**, and **Edge Locations** to provide:
    - Low latency worldwide
    - High availability (survive failures)
    - Data sovereignty compliance

    ## Regions: Geographic Locations

    **What is an AWS Region?**

    A **Region** is a separate geographic area (like a country or state) containing multiple data centers. Each region is completely independent.

    **Current Regions (33+):**
    - **North America**: `us-east-1` (Virginia), `us-west-2` (Oregon), `ca-central-1` (Canada)
    - **Europe**: `eu-west-1` (Ireland), `eu-central-1` (Frankfurt), `eu-north-1` (Stockholm)
    - **Asia Pacific**: `ap-southeast-1` (Singapore), `ap-northeast-1` (Tokyo), `ap-south-1` (Mumbai)
    - **South America**: `sa-east-1` (São Paulo)
    - **Middle East/Africa**: `me-south-1` (Bahrain), `af-south-1` (Cape Town)

    ### Why Multiple Regions?

    **1. Latency (Speed)**
    - Light travels at 300,000 km/s
    - New York to London: ~50ms
    - New York to Singapore: ~220ms

    **Example:**
    If your users are in Europe but your servers are in the US:
    - Every page load: +100ms latency
    - Every API call: +100ms latency
    - Video streaming: buffering issues

    **Solution:** Deploy in `eu-west-1` (Ireland) for European users.

    **2. Data Sovereignty (Legal Requirements)**

    Some countries require data to stay within borders:
    - **GDPR (EU)**: European citizen data must stay in EU
    - **China**: Data must stay in China regions
    - **Banking**: Financial data often has residency requirements

    **Example:**
    A German healthcare company MUST use `eu-central-1` (Frankfurt) due to patient privacy laws.

    **3. Disaster Recovery**

    If one region fails (earthquake, political unrest), your app continues in another region.

    **4. Service Availability**

    Newer AWS services launch in popular regions first:
    - `us-east-1` (Virginia): Almost all services immediately
    - Smaller regions: Services arrive 6-12 months later

    ### How to Choose a Region

    **Decision Framework:**

    ```
    1. Where are your users?
       → Pick closest region for lowest latency

    2. Any legal requirements?
       → Must use specific region(s)

    3. Does this region have the services you need?
       → Check AWS Regional Services list

    4. What's your budget?
       → Prices vary 10-30% between regions
          (us-east-1 is usually cheapest)
    ```

    **Real-World Example:**

    You're building a video streaming app:
    - **Primary users**: United States
    - **Legal requirement**: None
    - **Services needed**: S3, CloudFront, Lambda
    - **Budget**: Cost-conscious

    **Best choice**: `us-east-1` (Virginia)
    - Lowest latency for US users
    - Cheapest region
    - All services available first

    ## Availability Zones (AZs): Isolated Data Centers

    **What is an Availability Zone?**

    An **AZ** is one or more data centers within a region. Think of it as a separate building with its own power, cooling, and network.

    **Key Facts:**
    - Each region has **2-6 AZs** (usually 3)
    - AZs are **physically separated** (miles apart)
    - Connected by **high-speed, low-latency** private fiber links
    - Naming: `us-east-1a`, `us-east-1b`, `us-east-1c`

    ### Why Availability Zones Exist

    **The Problem:**
    Data centers can fail:
    - Power outages
    - Network failures
    - Fire, flood, cooling failure
    - Human error (someone trips over a cable!)

    **The Solution: Redundancy**
    Deploy your app across MULTIPLE AZs. If one fails, others keep running.

    ### High Availability Architecture

    **Single AZ (BAD - No redundancy):**
    ```
    Region: us-east-1
    └── AZ us-east-1a
        ├── Web Server (if this AZ fails = downtime!)
        └── Database
    ```
    **Risk**: One AZ failure = entire service down.

    **Multi-AZ (GOOD - High availability):**
    ```
    Region: us-east-1
    ├── AZ us-east-1a
    │   ├── Web Server 1
    │   └── Database Replica
    ├── AZ us-east-1b
    │   ├── Web Server 2
    │   └── Database Primary
    └── AZ us-east-1c
        ├── Web Server 3
        └── Database Replica
    ```

    **What happens if `us-east-1b` fails?**
    - Load balancer stops sending traffic to Web Server 2
    - Web Servers 1 and 3 handle requests
    - Database replica in `us-east-1a` becomes primary
    - Users experience NO downtime! ✓

    ### Real-World Example: Netflix

    Netflix uses multi-AZ deployment:
    1. Load balancer distributes traffic across 3 AZs
    2. If one AZ goes down, traffic shifts to other 2
    3. Databases replicate across AZs
    4. Users keep streaming without interruption

    **Cost of high availability?**
    Running 3 instances instead of 1, but you get 99.99% uptime.

    ### AZ Naming Confusion

    ⚠️ **Important**: Your `us-east-1a` might be a different physical AZ than mine!

    AWS randomizes AZ names per account to distribute load:
    - Your account: `us-east-1a` = Physical AZ 1
    - My account: `us-east-1a` = Physical AZ 3

    **Why?** Prevents everyone from using "1a" and overloading it.

    **Solution**: Use AZ IDs (`use1-az1`, `use1-az2`) for coordination between accounts.

    ## Edge Locations: Content Delivery

    **What is an Edge Location?**

    A smaller data center that caches content for CloudFront (AWS's CDN). Not a full AWS region.

    **Purpose:** Deliver static content (images, videos, JavaScript) faster by caching it closer to users.

    **Scale:**
    - 400+ edge locations worldwide
    - In major cities globally
    - Much more than 33 regions

    ### How Edge Locations Work

    **Without CloudFront (Slow):**
    ```
    User in Tokyo → 🌍 → Your server in Virginia (200ms latency)
    User in Tokyo → 🌍 → Your server in Virginia (200ms latency)
    User in Tokyo → 🌍 → Your server in Virginia (200ms latency)
    [Every request goes halfway around the world!]
    ```

    **With CloudFront (Fast):**
    ```
    User in Tokyo → Local edge location in Tokyo (5ms latency) ✓
    [Content cached at edge, no need to reach Virginia]
    ```

    **When to use Edge Locations:**
    - Serving images, videos, CSS, JavaScript
    - Streaming media
    - Software downloads
    - API acceleration

    ## Local Zones: Ultra-Low Latency

    **What is a Local Zone?**

    An extension of a region placed in major cities for **single-digit millisecond latency**.

    **Available in:**
    - Los Angeles, Boston, Houston, Miami (US)
    - Other major metros

    **Use Cases:**
    - Real-time gaming (lag = bad experience)
    - Live video production (broadcast TV)
    - Machine learning inference (milliseconds matter)
    - Financial trading (microseconds = money)

    **Example:**
    A gaming company serving Los Angeles gamers:
    - Regular region (`us-west-2` Oregon): 20ms latency
    - Local Zone (`us-west-2-lax-1a` LA): 2ms latency
    - **10x improvement** for better gameplay

    ## Comparing Infrastructure Components

    | Component | Count | Purpose | Latency | Services |
    |-----------|-------|---------|---------|----------|
    | **Regions** | 33+ | Geographic independence | 50-200ms between | All AWS services |
    | **Availability Zones** | 100+ (2-6 per region) | High availability | <2ms within region | All services |
    | **Edge Locations** | 400+ | Content caching | <10ms to users | CloudFront only |
    | **Local Zones** | 20+ | Ultra-low latency | <5ms | Select compute/storage |

    ### Decision Tree

    ```
    Need to run compute/databases?
    ├─ Yes → Use Region + Multiple AZs
    └─ No → Just serving static content?
           └─ Yes → Use CloudFront (Edge Locations)

    Need <5ms latency in specific city?
    └─ Yes → Consider Local Zone
    ```

    ## AWS Services Categories

    ### Compute
    - EC2 (Virtual Machines)
    - Lambda (Serverless Functions)
    - ECS/EKS (Containers)

    ### Storage
    - S3 (Object Storage)
    - EBS (Block Storage)
    - EFS (File Storage)

    ### Database
    - RDS (Relational)
    - DynamoDB (NoSQL)
    - ElastiCache (In-memory)

    ### Networking
    - VPC (Virtual Private Cloud)
    - Route 53 (DNS)
    - CloudFront (CDN)

    ### Security
    - IAM (Identity & Access)
    - KMS (Key Management)
    - WAF (Web Application Firewall)

    ## Shared Responsibility Model

    **AWS Responsibility** (Security OF the cloud):
    - Physical security
    - Hardware maintenance
    - Network infrastructure
    - Hypervisor

    **Customer Responsibility** (Security IN the cloud):
    - OS patches
    - Application security
    - Data encryption
    - IAM configuration
    - Network firewall rules

    **Practice**: Try the AWS Fundamentals lab!
  MARKDOWN
  lesson.key_concepts = ['regions', 'availability zones', 'edge locations', 'shared responsibility']
end

lesson1_2 = CourseLesson.find_or_create_by!(title: "IAM: Identity and Access Management") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # IAM: Identity and Access Management

    Control access to AWS services securely.

    ## IAM Components

    ### 1. Users
    Individual people or applications.

    ```bash
    # Create user
    aws iam create-user --user-name alice

    # List users
    aws iam list-users
    ```

    **Best Practices**:
    - One user per person/app
    - Enable MFA (Multi-Factor Authentication)
    - Use strong passwords
    - Rotate access keys regularly

    ### 2. Groups
    Collection of users with shared permissions.

    ```bash
    # Create group
    aws iam create-group --group-name developers

    # Add user to group
    aws iam add-user-to-group --user-name alice --group-name developers
    ```

    Common groups:
    - Admins
    - Developers
    - ReadOnly
    - Auditors

    ### 3. Roles
    Temporary permissions for AWS services or users.

    **Use cases**:
    - EC2 instance accessing S3
    - Lambda function accessing DynamoDB
    - Cross-account access
    - External identity federation

    ```bash
    # Create role
    aws iam create-role --role-name EC2-S3-Access \\
      --assume-role-policy-document file://trust-policy.json
    ```

    ### 4. Policies
    JSON documents defining permissions.

    **Policy Structure**:
    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::my-bucket/*"
        }
      ]
    }
    ```

    **Components**:
    - `Effect`: Allow or Deny
    - `Action`: What can be done
    - `Resource`: Which resources
    - `Condition` (optional): When it applies

    ## Policy Types

    ### 1. AWS Managed Policies
    Pre-built by AWS.

    Examples:
    - `AdministratorAccess`: Full access
    - `ReadOnlyAccess`: Read all services
    - `PowerUserAccess`: All except IAM

    ### 2. Customer Managed Policies
    Custom policies you create.

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:ListBucket",
            "s3:GetObject"
          ],
          "Resource": [
            "arn:aws:s3:::my-app-bucket",
            "arn:aws:s3:::my-app-bucket/*"
          ]
        }
      ]
    }
    ```

    ### 3. Inline Policies
    Embedded directly in user/group/role.

    ## IAM Best Practices

    ### 1. Principle of Least Privilege
    Grant minimum permissions needed.

    ❌ Bad:
    ```json
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
    ```

    ✅ Good:
    ```json
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "arn:aws:s3:::my-bucket/uploads/*"
    }
    ```

    ### 2. Enable MFA
    Especially for:
    - Root account (always!)
    - Admin users
    - Production access

    ### 3. Use Roles, Not Keys
    For EC2, Lambda, etc., use IAM roles instead of hardcoding keys.

    ❌ Bad:
    ```python
    # Hardcoded credentials
    aws_access_key = "AKIAIOSFODNN7EXAMPLE"
    aws_secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
    ```

    ✅ Good:
    ```python
    # Use IAM role attached to EC2
    s3 = boto3.client('s3')  # Credentials from role
    ```

    ### 4. Rotate Credentials
    - Access keys: Every 90 days
    - Passwords: Every 90 days
    - Use AWS Secrets Manager for app secrets

    ### 5. Monitor with CloudTrail
    Log all API calls for audit.

    ## IAM Access Methods

    ### 1. AWS Management Console
    Web-based UI with username/password + MFA.

    ### 2. AWS CLI
    Command-line with access keys.

    ```bash
    aws configure
    # Enter Access Key ID
    # Enter Secret Access Key
    # Enter Region
    ```

    ### 3. AWS SDK
    Programmatic access with access keys or IAM roles.

    ## Cross-Account Access

    Allow users from Account A to access Account B.

    **Account B (Resource Account)**:
    1. Create role with trust policy allowing Account A
    2. Attach permissions policy

    **Account A (User Account)**:
    1. Grant users permission to assume role
    2. Users switch to role via console or CLI

    ## IAM Policy Evaluation Logic

    ```
    1. Deny by default
    2. Evaluate all policies
    3. Explicit DENY overrides everything
    4. Explicit ALLOW granted if no DENY
    5. Otherwise: DENY
    ```

    ## Common IAM Policies

    ### S3 Read-Only
    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:ListBucket"
          ],
          "Resource": [
            "arn:aws:s3:::my-bucket",
            "arn:aws:s3:::my-bucket/*"
          ]
        }
      ]
    }
    ```

    ### EC2 Start/Stop
    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "ec2:StartInstances",
            "ec2:StopInstances"
          ],
          "Resource": "arn:aws:ec2:*:*:instance/*",
          "Condition": {
            "StringEquals": {
              "ec2:ResourceTag/Environment": "dev"
            }
          }
        }
      ]
    }
    ```

    **Practice**: Try the IAM lab!
  MARKDOWN
  lesson.key_concepts = ['IAM users', 'groups', 'roles', 'policies', 'least privilege', 'MFA']
end

# Quiz 1.1: AWS Fundamentals
quiz1_1 = Quiz.find_or_create_by!(title: "AWS Fundamentals Quiz") do |quiz|
  quiz.description = 'Test your knowledge of AWS infrastructure and IAM'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
end

[
  {
    question_text: "What is an AWS Region?",
    question_type: "mcq",
    points: 5,
    options: ["Geographic location with multiple data centers", "A single data center", "An AWS service", "A security group"],
    correct_answer: "Geographic location with multiple data centers",
    explanation: "An AWS Region is a geographic area containing multiple isolated Availability Zones."
  },
  {
    question_text: "How many Availability Zones does an AWS Region typically have?",
    question_type: "mcq",
    points: 5,
    options: ["2-6 AZs", "Always 3 AZs", "1 AZ", "10+ AZs"],
    correct_answer: "2-6 AZs",
    explanation: "Most AWS Regions have 2-6 Availability Zones for redundancy."
  },
  {
    question_text: "What is IAM used for?",
    question_type: "mcq",
    points: 5,
    options: ["Managing user access and permissions", "Storing files", "Running virtual machines", "Hosting websites"],
    correct_answer: "Managing user access and permissions",
    explanation: "IAM (Identity and Access Management) controls who can access AWS resources and what they can do."
  },
  {
    question_text: "What is the principle of least privilege?",
    question_type: "mcq",
    points: 5,
    options: ["Grant minimum permissions needed", "Grant all permissions", "Grant no permissions", "Grant random permissions"],
    correct_answer: "Grant minimum permissions needed",
    explanation: "Least privilege means granting only the permissions necessary to perform a task."
  },
  {
    question_text: "Should you use the root account for daily tasks?",
    question_type: "mcq",
    points: 5,
    options: ["No, create IAM users instead", "Yes, it's convenient", "Only for production", "Only on weekends"],
    correct_answer: "No, create IAM users instead",
    explanation: "The root account has full access and should only be used for account setup. Create IAM users for daily work."
  },
  {
    question_text: "What is MFA?",
    question_type: "mcq",
    points: 5,
    options: ["Multi-Factor Authentication", "Multiple File Access", "Master Firewall Authorization", "Managed Federated Accounts"],
    correct_answer: "Multi-Factor Authentication",
    explanation: "MFA adds an extra layer of security by requiring a second factor (like a code from your phone) in addition to password."
  },
  {
    question_text: "What's the best way for EC2 to access S3?",
    question_type: "mcq",
    points: 5,
    options: ["Attach an IAM role to EC2", "Hardcode access keys", "Use root credentials", "Don't use S3 from EC2"],
    correct_answer: "Attach an IAM role to EC2",
    explanation: "IAM roles provide temporary credentials and are more secure than hardcoded access keys."
  },
  {
    question_text: "What does an IAM policy define?",
    question_type: "mcq",
    points: 5,
    options: ["Permissions for resources", "Server configurations", "Network routes", "Storage capacity"],
    correct_answer: "Permissions for resources",
    explanation: "IAM policies are JSON documents that define what actions are allowed or denied on which resources."
  },
  {
    question_text: "In the Shared Responsibility Model, who secures the hypervisor?",
    question_type: "mcq",
    points: 5,
    options: ["AWS", "Customer", "Both", "Third party"],
    correct_answer: "AWS",
    explanation: "AWS is responsible for security OF the cloud, including hardware and hypervisor."
  },
  {
    question_text: "What is an IAM role used for?",
    question_type: "mcq",
    points: 5,
    options: ["Temporary permissions for services or users", "Permanent user accounts", "Storing passwords", "Creating backups"],
    correct_answer: "Temporary permissions for services or users",
    explanation: "IAM roles provide temporary security credentials for AWS services or federated users."
  },
  {
    question_text: "How often should you rotate IAM access keys?",
    question_type: "mcq",
    points: 5,
    options: ["Every 90 days", "Never", "Every day", "Every 10 years"],
    correct_answer: "Every 90 days",
    explanation: "AWS recommends rotating access keys every 90 days as a security best practice."
  },
  {
    question_text: "What overrides all other IAM policy evaluations?",
    question_type: "mcq",
    points: 5,
    options: ["Explicit DENY", "Explicit ALLOW", "Implicit DENY", "Nothing"],
    correct_answer: "Explicit DENY",
    explanation: "An explicit DENY in any policy always takes precedence over any ALLOWs."
  },
  {
    question_text: "What are Edge Locations used for?",
    question_type: "mcq",
    points: 5,
    options: ["CDN endpoints for CloudFront", "Running EC2 instances", "Storing databases", "IAM authentication"],
    correct_answer: "CDN endpoints for CloudFront",
    explanation: "Edge Locations are used by CloudFront to cache content closer to users for lower latency."
  },
  {
    question_text: "What is an AWS Availability Zone?",
    question_type: "mcq",
    points: 5,
    options: ["One or more isolated data centers", "A region", "A service", "A user account"],
    correct_answer: "One or more isolated data centers",
    explanation: "Availability Zones are isolated locations within a region, each with independent power, cooling, and networking."
  },
  {
    question_text: "Which IAM entity should you use to group users with similar permissions?",
    question_type: "mcq",
    points: 5,
    options: ["IAM Groups", "IAM Roles", "IAM Policies", "IAM Regions"],
    correct_answer: "IAM Groups",
    explanation: "IAM Groups allow you to manage permissions for multiple users collectively."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz1_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 2: Compute Services
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'compute-services', course: aws_course) do |mod|
  mod.title = "Compute Services - EC2 and Lambda"
  mod.description = "Master AWS compute options from virtual machines to serverless functions"
  mod.sequence_order = 2
  mod.estimated_minutes = 240
  mod.published = true
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "EC2: Elastic Compute Cloud") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = <<~MARKDOWN
    # EC2: Elastic Compute Cloud

    Virtual servers in the AWS cloud.

    ## EC2 Instance Types

    ### General Purpose (T, M series)
    - Balanced CPU, memory, networking
    - **t3.micro**: 2 vCPU, 1 GB RAM (free tier)
    - **m5.large**: 2 vCPU, 8 GB RAM
    - Use for: Web servers, small databases

    ### Compute Optimized (C series)
    - High-performance processors
    - **c5.large**: 2 vCPU, 4 GB RAM
    - Use for: Batch processing, gaming servers

    ### Memory Optimized (R, X series)
    - Fast processing of large datasets in memory
    - **r5.large**: 2 vCPU, 16 GB RAM
    - Use for: In-memory databases, caching

    ### Storage Optimized (I, D series)
    - High sequential read/write to local storage
    - **i3.large**: 2 vCPU, 15 GB RAM, NVMe SSD
    - Use for: Data warehouses, NoSQL databases

    ## Launching an EC2 Instance

    ### 1. Choose AMI (Amazon Machine Image)
    Pre-configured OS template.

    ```bash
    # List Amazon Linux AMIs
    aws ec2 describe-images --owners amazon \\
      --filters "Name=name,Values=amzn2-ami-hvm-*"
    ```

    Types:
    - Amazon Linux 2
    - Ubuntu
    - Red Hat
    - Windows Server
    - Custom AMIs

    ### 2. Select Instance Type
    ```bash
    aws ec2 run-instances \\
      --image-id ami-0c55b159cbfafe1f0 \\
      --instance-type t3.micro \\
      --key-name MyKeyPair \\
      --security-group-ids sg-0123456789abcdef0
    ```

    ### 3. Configure Instance
    - Number of instances
    - Network (VPC, subnet)
    - IAM role
    - User data (bootstrap script)

    ### 4. Add Storage
    - Root volume (OS)
    - Additional EBS volumes
    - Instance store (ephemeral)

    ### 5. Configure Security Group
    Firewall rules.

    ```bash
    # Allow SSH from anywhere
    aws ec2 authorize-security-group-ingress \\
      --group-id sg-0123456789abcdef0 \\
      --protocol tcp --port 22 --cidr 0.0.0.0/0
    ```

    ### 6. Review and Launch
    Select or create key pair for SSH access.

    ## EC2 User Data

    Bootstrap script that runs on first launch.

    ```bash
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.html
    ```

    ## EC2 Instance States

    ```
    pending → running → stopping → stopped → terminating → terminated
                  ↓
              rebooting
    ```

    - **Stopped**: No compute charges, storage charges apply
    - **Terminated**: All data lost, cannot restart

    ## EC2 Pricing Models

    ### 1. On-Demand
    - Pay by the hour/second
    - No upfront cost
    - No commitment
    - **Use for**: Short-term, unpredictable workloads

    ### 2. Reserved Instances
    - 1 or 3 year commitment
    - Up to 75% discount
    - **Use for**: Steady-state workloads

    ### 3. Spot Instances
    - Bid on spare capacity
    - Up to 90% discount
    - Can be interrupted
    - **Use for**: Fault-tolerant, flexible workloads

    ### 4. Savings Plans
    - Commit to $/hour for 1 or 3 years
    - Up to 72% discount
    - Flexibility across instance types
    - **Use for**: Long-term workloads

    ## Elastic Load Balancing

    Distribute traffic across multiple EC2 instances.

    ### Application Load Balancer (ALB)
    - Layer 7 (HTTP/HTTPS)
    - Path-based routing
    - Host-based routing
    - WebSocket support

    ```bash
    aws elbv2 create-load-balancer \\
      --name my-alb \\
      --subnets subnet-12345 subnet-67890 \\
      --security-groups sg-12345
    ```

    ### Network Load Balancer (NLB)
    - Layer 4 (TCP/UDP)
    - Ultra-high performance
    - Static IP addresses

    ### Classic Load Balancer
    - Legacy (Layer 4 & 7)
    - Use ALB or NLB for new applications

    ## Auto Scaling

    Automatically adjust capacity.

    ### Components

    **1. Launch Template**:
    ```bash
    aws ec2 create-launch-template \\
      --launch-template-name my-template \\
      --version-description "Web server template" \\
      --launch-template-data file://template.json
    ```

    **2. Auto Scaling Group**:
    ```bash
    aws autoscaling create-auto-scaling-group \\
      --auto-scaling-group-name my-asg \\
      --launch-template LaunchTemplateName=my-template \\
      --min-size 2 --max-size 10 --desired-capacity 4 \\
      --vpc-zone-identifier "subnet-12345,subnet-67890"
    ```

    **3. Scaling Policies**:
    - **Target Tracking**: Maintain average CPU at 70%
    - **Step Scaling**: Add 2 instances when CPU > 80%
    - **Scheduled**: Scale up at 9 AM, down at 6 PM

    ## EC2 Best Practices

    1. **Use IAM Roles**: Never hardcode credentials
    2. **Security Groups**: Restrict inbound traffic
    3. **EBS Snapshots**: Regular backups
    4. **Monitoring**: Enable CloudWatch metrics
    5. **Tagging**: Organize and track costs
    6. **Right-sizing**: Choose appropriate instance type

    **Practice**: Try the EC2 lab!
  MARKDOWN
  lesson.key_concepts = ['EC2 instances', 'instance types', 'AMI', 'security groups', 'auto scaling', 'load balancing']
end

lesson2_2 = CourseLesson.find_or_create_by!(title: "Lambda: Serverless Computing") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # AWS Lambda: Serverless Computing

    Run code without managing servers.

    ## What is Lambda?

    **Serverless compute service** that:
    - Runs your code in response to events
    - Automatically scales
    - You pay only for compute time used
    - No servers to manage

    ## Lambda Components

    ### Function
    Your code + configuration.

    **Supported Runtimes**:
    - Python 3.x
    - Node.js 18.x
    - Java 11/17
    - Go 1.x
    - .NET 6
    - Ruby 2.7
    - Custom runtimes

    ### Trigger
    Event that invokes your function.

    **Common Triggers**:
    - API Gateway (HTTP requests)
    - S3 (file uploads)
    - DynamoDB (table changes)
    - CloudWatch Events (scheduled)
    - SNS/SQS (messages)

    ## Creating a Lambda Function

    ### Python Example

    ```python
    import json

    def lambda_handler(event, context):
        # Your code here
        name = event.get('name', 'World')

        return {
            'statusCode': 200,
            'body': json.dumps(f'Hello, {name}!')
        }
    ```

    ### CLI Creation

    ```bash
    # Create function
    aws lambda create-function \\
      --function-name my-function \\
      --runtime python3.9 \\
      --role arn:aws:iam::123456789012:role/lambda-role \\
      --handler lambda_function.lambda_handler \\
      --zip-file fileb://function.zip
    ```

    ### Invoke Function

    ```bash
    aws lambda invoke \\
      --function-name my-function \\
      --payload '{"name": "Alice"}' \\
      response.json
    ```

    ## Lambda Configuration

    ### Memory and Timeout
    ```bash
    aws lambda update-function-configuration \\
      --function-name my-function \\
      --memory-size 512 \\
      --timeout 30
    ```

    - **Memory**: 128 MB - 10 GB
    - **Timeout**: Max 15 minutes
    - **More memory = more CPU**

    ### Environment Variables
    ```bash
    aws lambda update-function-configuration \\
      --function-name my-function \\
      --environment Variables={DB_HOST=localhost,DB_PORT=5432}
    ```

    ### Layers
    Share code across functions.

    ```bash
    # Create layer
    aws lambda publish-layer-version \\
      --layer-name my-layer \\
      --zip-file fileb://layer.zip \\
      --compatible-runtimes python3.9

    # Attach to function
    aws lambda update-function-configuration \\
      --function-name my-function \\
      --layers arn:aws:lambda:us-east-1:123456789012:layer:my-layer:1
    ```

    ## Lambda Triggers

    ### API Gateway
    Create REST API.

    ```python
    def lambda_handler(event, context):
        # Access HTTP request data
        method = event['httpMethod']
        path = event['path']
        body = json.loads(event['body'])

        return {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({'message': 'Success'})
        }
    ```

    ### S3 Trigger
    Process uploaded files.

    ```python
    def lambda_handler(event, context):
        for record in event['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']

            print(f"Processing {key} from {bucket}")
            # Process file
    ```

    ### CloudWatch Events
    Scheduled execution (cron).

    ```bash
    aws events put-rule \\
      --name my-scheduled-rule \\
      --schedule-expression 'rate(5 minutes)'

    aws events put-targets \\
      --rule my-scheduled-rule \\
      --targets "Id"="1","Arn"="arn:aws:lambda:us-east-1:123:function:my-function"
    ```

    ## Lambda Pricing

    **Free Tier**:
    - 1M requests/month free
    - 400,000 GB-seconds compute time/month free

    **Pricing**:
    - $0.20 per 1M requests
    - $0.00001667 per GB-second

    **Example**:
    ```
    Function: 512 MB, runs 100ms, 5M invocations/month

    Requests: 5M - 1M (free) = 4M
    Cost: 4M × $0.20/1M = $0.80

    Compute: 5M × 0.1s × 0.5GB = 250,000 GB-seconds
    Free: 400,000 GB-seconds
    Cost: $0 (under free tier)

    Total: $0.80/month
    ```

    ## Lambda Best Practices

    ### 1. Minimize Cold Starts
    - Keep functions warm with provisioned concurrency
    - Reduce package size
    - Use compiled languages (Go, Java)

    ### 2. Use Environment Variables
    Store configuration, not in code.

    ### 3. Implement Idempotency
    Handle duplicate events gracefully.

    ### 4. Set Appropriate Timeouts
    Don't use default 3 seconds for long tasks.

    ### 5. Use Layers
    Share common dependencies.

    ### 6. Monitor with CloudWatch
    - View logs
    - Set alarms
    - Track metrics (invocations, errors, duration)

    ### 7. Handle Errors
    ```python
    def lambda_handler(event, context):
        try:
            # Your code
            result = process_data(event)
            return {'statusCode': 200, 'body': json.dumps(result)}
        except Exception as e:
            print(f"Error: {str(e)}")
            return {'statusCode': 500, 'body': json.dumps({'error': str(e)})}
    ```

    ## Lambda vs EC2

    | Feature | Lambda | EC2 |
    |---------|--------|-----|
    | Management | Serverless | Manual |
    | Scaling | Automatic | Manual/Auto Scaling |
    | Pricing | Per invocation | Per hour |
    | Max Runtime | 15 minutes | Unlimited |
    | Startup | Cold start | Always on |
    | Use Case | Event-driven | Long-running |

    **Practice**: Try the Lambda lab!
  MARKDOWN
  lesson.key_concepts = ['serverless', 'lambda functions', 'triggers', 'event-driven', 'API Gateway']
end

# Quiz 2.1: Compute Services
quiz2_1 = Quiz.find_or_create_by!(title: "Compute Services Quiz") do |quiz|
  quiz.description = 'Test your knowledge of EC2 and Lambda'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
end

[
  {
    question_text: "What is EC2?",
    question_type: "mcq",
    points: 5,
    options: ["Virtual servers in the cloud", "Object storage service", "Database service", "Content delivery network"],
    correct_answer: "Virtual servers in the cloud",
    explanation: "EC2 (Elastic Compute Cloud) provides resizable virtual servers."
  },
  {
    question_text: "Which EC2 instance type is best for memory-intensive applications?",
    question_type: "mcq",
    points: 5,
    options: ["R series (Memory Optimized)", "C series (Compute Optimized)", "T series (General Purpose)", "I series (Storage Optimized)"],
    correct_answer: "R series (Memory Optimized)",
    explanation: "R-series instances are optimized for memory-intensive workloads."
  },
  {
    question_text: "What is Lambda?",
    question_type: "mcq",
    points: 5,
    options: ["Serverless compute service", "Virtual machine service", "Container service", "Load balancer"],
    correct_answer: "Serverless compute service",
    explanation: "AWS Lambda runs your code without provisioning or managing servers."
  },
  {
    question_text: "What's the maximum Lambda execution time?",
    question_type: "mcq",
    points: 5,
    options: ["15 minutes", "5 minutes", "1 hour", "Unlimited"],
    correct_answer: "15 minutes",
    explanation: "Lambda functions have a maximum execution time of 15 minutes."
  },
  {
    question_text: "Which EC2 pricing model offers up to 90% discount but can be interrupted?",
    question_type: "mcq",
    points: 5,
    options: ["Spot Instances", "On-Demand", "Reserved Instances", "Savings Plans"],
    correct_answer: "Spot Instances",
    explanation: "Spot Instances offer the deepest discounts but can be terminated by AWS when capacity is needed."
  },
  {
    question_text: "What is an AMI?",
    question_type: "mcq",
    points: 5,
    options: ["Amazon Machine Image (OS template)", "Auto Monitoring Instance", "AWS Memory Interface", "Application Management Interface"],
    correct_answer: "Amazon Machine Image (OS template)",
    explanation: "An AMI is a template that contains the OS and software configuration for launching EC2 instances."
  },
  {
    question_text: "What is Auto Scaling used for?",
    question_type: "mcq",
    points: 5,
    options: ["Automatically adjust EC2 capacity", "Scale disk storage", "Scale database size", "Scale network bandwidth"],
    correct_answer: "Automatically adjust EC2 capacity",
    explanation: "Auto Scaling automatically adds or removes EC2 instances based on demand."
  },
  {
    question_text: "Which load balancer operates at Layer 7 (HTTP)?",
    question_type: "mcq",
    points: 5,
    options: ["Application Load Balancer", "Network Load Balancer", "Classic Load Balancer", "Gateway Load Balancer"],
    correct_answer: "Application Load Balancer",
    explanation: "ALB operates at the application layer (Layer 7) and can route based on URL paths and headers."
  },
  {
    question_text: "How are you charged for Lambda?",
    question_type: "mcq",
    points: 5,
    options: ["Per invocation and compute time", "Per hour", "Per day", "Flat monthly rate"],
    correct_answer: "Per invocation and compute time",
    explanation: "Lambda charges based on the number of requests and the duration your code executes."
  },
  {
    question_text: "What is EC2 User Data used for?",
    question_type: "mcq",
    points: 5,
    options: ["Bootstrap script that runs on first launch", "Storing files", "User authentication", "Monitoring"],
    correct_answer: "Bootstrap script that runs on first launch",
    explanation: "User Data runs commands automatically when an EC2 instance first starts."
  },
  {
    question_text: "What happens to data on an EC2 instance store when the instance stops?",
    question_type: "mcq",
    points: 5,
    options: ["Data is lost", "Data is preserved", "Data is backed up automatically", "Data is encrypted"],
    correct_answer: "Data is lost",
    explanation: "Instance store volumes are ephemeral - data is lost when the instance stops or terminates."
  },
  {
    question_text: "What is a Lambda Layer?",
    question_type: "mcq",
    points: 5,
    options: ["Shared code library for Lambda functions", "Network configuration", "Database connection", "Security policy"],
    correct_answer: "Shared code library for Lambda functions",
    explanation: "Layers allow you to package dependencies that can be shared across multiple Lambda functions."
  },
  {
    question_text: "What triggers a Lambda function when a file is uploaded to S3?",
    question_type: "mcq",
    points: 5,
    options: ["S3 event notification", "CloudWatch alarm", "Manual invocation", "Auto Scaling"],
    correct_answer: "S3 event notification",
    explanation: "S3 can trigger Lambda functions automatically when objects are created, deleted, or modified."
  },
  {
    question_text: "What is a Security Group?",
    question_type: "mcq",
    points: 5,
    options: ["Virtual firewall for EC2 instances", "User access control", "Data encryption", "Backup system"],
    correct_answer: "Virtual firewall for EC2 instances",
    explanation: "Security Groups control inbound and outbound traffic to EC2 instances."
  },
  {
    question_text: "What is the benefit of Reserved Instances?",
    question_type: "mcq",
    points: 5,
    options: ["Up to 75% discount for 1-3 year commitment", "No commitment needed", "Can be interrupted", "Fastest performance"],
    correct_answer: "Up to 75% discount for 1-3 year commitment",
    explanation: "Reserved Instances offer significant cost savings in exchange for a 1 or 3-year commitment."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz2_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 3: Storage Services
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'storage-services', course: aws_course) do |mod|
  mod.title = "Storage Services - S3, EBS, and EFS"
  mod.description = "Learn AWS storage solutions for objects, blocks, and files"
  mod.sequence_order = 3
  mod.estimated_minutes = 220
  mod.published = true
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "S3: Simple Storage Service") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # S3: Simple Storage Service

    Scalable object storage in the cloud.

    ## S3 Basics

    **Object Storage**: Store files (objects) in containers (buckets).

    ### Key Concepts

    **Bucket**:
    - Container for objects
    - Globally unique name
    - Region-specific
    - Max 100 buckets per account

    **Object**:
    - File + metadata
    - Max size: 5 TB
    - Key (name) + Value (data)

    **Key**:
    - Full path: `s3://my-bucket/folder/file.txt`
    - No true folders (simulated with prefixes)

    ## Creating Buckets

    ```bash
    # Create bucket
    aws s3 mb s3://my-unique-bucket-name-12345

    # List buckets
    aws s3 ls

    # Delete bucket (must be empty)
    aws s3 rb s3://my-bucket
    ```

    ## Working with Objects

    ### Upload
    ```bash
    # Upload file
    aws s3 cp myfile.txt s3://my-bucket/

    # Upload directory
    aws s3 cp mydir/ s3://my-bucket/mydir/ --recursive

    # Upload with storage class
    aws s3 cp file.txt s3://my-bucket/ --storage-class GLACIER
    ```

    ### Download
    ```bash
    # Download file
    aws s3 cp s3://my-bucket/file.txt .

    # Download directory
    aws s3 cp s3://my-bucket/mydir/ ./local-dir/ --recursive
    ```

    ### List and Delete
    ```bash
    # List objects
    aws s3 ls s3://my-bucket/

    # Delete object
    aws s3 rm s3://my-bucket/file.txt

    # Delete directory
    aws s3 rm s3://my-bucket/mydir/ --recursive
    ```

    ## S3 Storage Classes

    Choose based on access patterns and cost.

    ### S3 Standard
    - **Use**: Frequently accessed data
    - **Durability**: 99.999999999% (11 nines)
    - **Availability**: 99.99%
    - **Cost**: Highest storage, lowest retrieval

    ### S3 Intelligent-Tiering
    - **Use**: Unknown or changing access patterns
    - **Auto-moves**: Between frequent and infrequent access
    - **Cost**: Small monitoring fee

    ### S3 Standard-IA (Infrequent Access)
    - **Use**: Less frequently accessed, rapid access needed
    - **Availability**: 99.9%
    - **Cost**: Lower storage, higher retrieval

    ### S3 One Zone-IA
    - **Use**: Infrequently accessed, can recreate if lost
    - **Availability**: 99.5% (single AZ)
    - **Cost**: 20% less than Standard-IA

    ### S3 Glacier
    - **Use**: Long-term archival
    - **Retrieval**: Minutes to hours
    - **Cost**: Very low storage

    ### S3 Glacier Deep Archive
    - **Use**: Rarely accessed archival
    - **Retrieval**: 12-48 hours
    - **Cost**: Lowest storage

    ## S3 Versioning

    Keep multiple versions of objects.

    ```bash
    # Enable versioning
    aws s3api put-bucket-versioning \\
      --bucket my-bucket \\
      --versioning-configuration Status=Enabled

    # List versions
    aws s3api list-object-versions --bucket my-bucket
    ```

    Benefits:
    - Protect from accidental deletion
    - Roll back to previous versions
    - Compliance requirements

    ## S3 Security

    ### Bucket Policies
    JSON-based access policies.

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::my-bucket/*"
        }
      ]
    }
    ```

    ### Access Control Lists (ACLs)
    Legacy access control (use bucket policies instead).

    ### Encryption

    **At Rest**:
    - SSE-S3: AWS managed keys
    - SSE-KMS: KMS managed keys
    - SSE-C: Customer provided keys

    **In Transit**:
    - HTTPS/TLS

    ```bash
    # Upload with encryption
    aws s3 cp file.txt s3://my-bucket/ --sse AES256
    ```

    ## S3 Static Website Hosting

    Host static websites.

    ```bash
    # Enable website hosting
    aws s3 website s3://my-bucket/ \\
      --index-document index.html \\
      --error-document error.html
    ```

    URL: `http://my-bucket.s3-website-us-east-1.amazonaws.com`

    ## S3 Cross-Region Replication

    Replicate objects to another region.

    ```bash
    aws s3api put-bucket-replication \\
      --bucket source-bucket \\
      --replication-configuration file://replication.json
    ```

    Use cases:
    - Disaster recovery
    - Compliance
    - Latency reduction

    ## S3 Lifecycle Policies

    Automatically transition or delete objects.

    ```json
    {
      "Rules": [
        {
          "Id": "Move old logs to Glacier",
          "Status": "Enabled",
          "Transitions": [
            {
              "Days": 30,
              "StorageClass": "GLACIER"
            }
          ],
          "Expiration": {
            "Days": 365
          }
        }
      ]
    }
    ```

    ## S3 Performance

    ### Multipart Upload
    For files > 100 MB.

    ```bash
    aws s3 cp large-file.zip s3://my-bucket/ \\
      --storage-class GLACIER \\
      --metadata key1=value1
    ```

    ### Transfer Acceleration
    Use CloudFront edge locations for faster uploads.

    ### S3 Select
    Query data without downloading entire object.

    ## S3 Pricing

    **Costs**:
    - Storage (per GB-month)
    - Requests (PUT, GET, etc.)
    - Data transfer out
    - Data retrieval (for IA, Glacier)

    **Free Tier**:
    - 5 GB Standard storage
    - 20,000 GET requests
    - 2,000 PUT requests

    ## S3 Best Practices

    1. **Enable versioning**: Protect from accidental deletion
    2. **Use lifecycle policies**: Automate cost optimization
    3. **Encrypt data**: Always encrypt sensitive data
    4. **Block public access**: Unless hosting public website
    5. **Use CloudFront**: Cache static content globally
    6. **Monitor costs**: Use Cost Explorer

    **Practice**: Try the S3 lab!
  MARKDOWN
  lesson.key_concepts = ['S3 buckets', 'objects', 'storage classes', 'versioning', 'encryption', 'lifecycle policies']
end

# Continuing with EBS and EFS lessons and quizzes...
# (Due to length, showing structure for remaining content)

lesson3_2 = CourseLesson.find_or_create_by!(title: "EBS and EFS: Block and File Storage") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # EBS and EFS: Block and File Storage

    Persistent storage for EC2 instances.

    ## EBS: Elastic Block Store

    **Block storage** volumes for EC2 instances (like virtual hard drives).

    ### EBS Volume Types

    **GP3 (General Purpose SSD)**:
    - 3,000-16,000 IOPS
    - 125-1,000 MB/s throughput
    - Cost-effective

    **IO2 (Provisioned IOPS SSD)**:
    - Up to 64,000 IOPS
    - Mission-critical workloads
    - Databases

    **ST1 (Throughput Optimized HDD)**:
    - Big data, data warehouses
    - Cannot be boot volume

    **SC1 (Cold HDD)**:
    - Infrequently accessed data
    - Lowest cost
    - Cannot be boot volume

    ### Creating EBS Volumes

    ```bash
    aws ec2 create-volume \\
      --availability-zone us-east-1a \\
      --size 100 \\
      --volume-type gp3
    ```

    ### Attaching Volumes

    ```bash
    aws ec2 attach-volume \\
      --volume-id vol-1234567890abcdef0 \\
      --instance-id i-1234567890abcdef0 \\
      --device /dev/sdf
    ```

    ### EBS Snapshots

    Backup EBS volumes.

    ```bash
    # Create snapshot
    aws ec2 create-snapshot \\
      --volume-id vol-1234567890abcdef0 \\
      --description "My backup"

    # List snapshots
    aws ec2 describe-snapshots --owner-ids self

    # Create volume from snapshot
    aws ec2 create-volume \\
      --snapshot-id snap-1234567890abcdef0 \\
      --availability-zone us-east-1a
    ```

    ## EFS: Elastic File System

    **Network file system** (NFS) for multiple EC2 instances.

    ### EFS vs EBS

    | Feature | EBS | EFS |
    |---------|-----|-----|
    | Type | Block storage | File storage |
    | Attachment | One EC2 at a time* | Multiple EC2 simultaneously |
    | Scope | Single AZ | Multi-AZ |
    | Use Case | Boot volumes, databases | Shared file storage |

    *Multi-attach available for io1/io2 in same AZ

    ### Creating EFS

    ```bash
    aws efs create-file-system \\
      --creation-token my-efs \\
      --performance-mode generalPurpose \\
      --throughput-mode bursting
    ```

    ### Mounting EFS

    ```bash
    # Install NFS client
    sudo yum install -y amazon-efs-utils

    # Mount EFS
    sudo mount -t efs fs-1234567890abcdef0:/ /mnt/efs
    ```

    ### EFS Storage Classes

    **Standard**: Frequently accessed
    **Infrequent Access**: Automatically move rarely accessed files

    ## Storage Comparison

    | Service | Type | Use Case |
    |---------|------|----------|
    | **S3** | Object | Static files, backups, big data |
    | **EBS** | Block | EC2 boot volumes, databases |
    | **EFS** | File | Shared file storage across EC2 |
    | **S3 Glacier** | Object (archive) | Long-term backups |

    **Practice**: Try the EBS/EFS lab!
  MARKDOWN
  lesson.key_concepts = ['EBS volumes', 'EBS snapshots', 'EFS', 'block storage', 'file storage']
end

# Quiz 3.1: Storage Services
quiz3_1 = Quiz.find_or_create_by!(title: "Storage Services Quiz") do |quiz|
  quiz.description = 'Test your knowledge of S3, EBS, and EFS'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
end

[
  {
    question_text: "What type of storage is S3?",
    question_type: "mcq",
    points: 5,
    options: ["Object storage", "Block storage", "File storage", "Database storage"],
    correct_answer: "Object storage",
    explanation: "S3 is an object storage service for storing files (objects) in buckets."
  },
  {
    question_text: "What is the maximum object size in S3?",
    question_type: "mcq",
    points: 5,
    options: ["5 TB", "5 GB", "500 GB", "Unlimited"],
    correct_answer: "5 TB",
    explanation: "S3 objects can be up to 5 terabytes in size."
  },
  {
    question_text: "Which S3 storage class is cheapest for long-term archival?",
    question_type: "mcq",
    points: 5,
    options: ["S3 Glacier Deep Archive", "S3 Standard", "S3 Intelligent-Tiering", "S3 One Zone-IA"],
    correct_answer: "S3 Glacier Deep Archive",
    explanation: "Glacier Deep Archive offers the lowest cost for long-term archival with 12-48 hour retrieval."
  },
  {
    question_text: "What is EBS?",
    question_type: "mcq",
    points: 5,
    options: ["Block storage for EC2", "Object storage", "Database service", "Content delivery network"],
    correct_answer: "Block storage for EC2",
    explanation: "EBS provides block-level storage volumes for EC2 instances."
  },
  {
    question_text: "Can multiple EC2 instances mount the same EFS file system simultaneously?",
    question_type: "mcq",
    points: 5,
    options: ["Yes", "No", "Only in same AZ", "Only with special configuration"],
    correct_answer: "Yes",
    explanation: "EFS supports concurrent access from multiple EC2 instances across multiple AZs."
  },
  {
    question_text: "What is S3 versioning used for?",
    question_type: "mcq",
    points: 5,
    options: ["Keeping multiple versions of objects", "Compressing files", "Encrypting data", "Faster uploads"],
    correct_answer: "Keeping multiple versions of objects",
    explanation: "Versioning preserves every version of every object, protecting from accidental deletion."
  },
  {
    question_text: "What is an EBS snapshot?",
    question_type: "mcq",
    points: 5,
    options: ["Backup of an EBS volume", "Copy of an instance", "Network configuration", "Security policy"],
    correct_answer: "Backup of an EBS volume",
    explanation: "EBS snapshots are point-in-time backups of EBS volumes stored in S3."
  },
  {
    question_text: "What does S3 bucket name need to be?",
    question_type: "mcq",
    points: 5,
    options: ["Globally unique", "Unique within region", "Unique within account", "Not unique"],
    correct_answer: "Globally unique",
    explanation: "S3 bucket names must be globally unique across all AWS accounts."
  },
  {
    question_text: "Which EBS volume type is best for databases requiring high IOPS?",
    question_type: "mcq",
    points: 5,
    options: ["IO2 (Provisioned IOPS SSD)", "GP3 (General Purpose)", "ST1 (Throughput Optimized)", "SC1 (Cold HDD)"],
    correct_answer: "IO2 (Provisioned IOPS SSD)",
    explanation: "IO2 volumes provide the highest IOPS performance for mission-critical applications."
  },
  {
    question_text: "What is S3 Lifecycle policy used for?",
    question_type: "mcq",
    points: 5,
    options: ["Automatically transition or delete objects", "Encrypt data", "Replicate data", "Monitor usage"],
    correct_answer: "Automatically transition or delete objects",
    explanation: "Lifecycle policies automate moving objects between storage classes or deleting them after a time period."
  },
  {
    question_text: "What is the durability of S3 Standard?",
    question_type: "mcq",
    points: 5,
    options: ["99.999999999% (11 nines)", "99.99%", "99.9%", "99%"],
    correct_answer: "99.999999999% (11 nines)",
    explanation: "S3 Standard provides 11 nines of durability, meaning objects are extremely unlikely to be lost."
  },
  {
    question_text: "Can EBS volumes be attached to EC2 instances in different AZs?",
    question_type: "mcq",
    points: 5,
    options: ["No, must be in same AZ", "Yes, any AZ", "Only in same region", "Yes, any region"],
    correct_answer: "No, must be in same AZ",
    explanation: "EBS volumes are specific to an Availability Zone and can only attach to instances in that AZ."
  },
  {
    question_text: "What is S3 Transfer Acceleration?",
    question_type: "mcq",
    points: 5,
    options: ["Faster uploads using CloudFront edge locations", "Compress files automatically", "Parallel uploads", "Direct connection to AWS"],
    correct_answer: "Faster uploads using CloudFront edge locations",
    explanation: "Transfer Acceleration uses CloudFront's globally distributed edge locations to accelerate uploads to S3."
  },
  {
    question_text: "Which storage service would you use for shared file storage across multiple servers?",
    question_type: "mcq",
    points: 5,
    options: ["EFS", "EBS", "S3", "Instance Store"],
    correct_answer: "EFS",
    explanation: "EFS (Elastic File System) provides shared file storage that can be mounted by multiple EC2 instances simultaneously."
  },
  {
    question_text: "What happens to data on an EBS volume when the EC2 instance is terminated?",
    question_type: "mcq",
    points: 5,
    options: ["Depends on DeleteOnTermination attribute", "Always deleted", "Always preserved", "Moved to S3"],
    correct_answer: "Depends on DeleteOnTermination attribute",
    explanation: "By default, root volumes are deleted but additional volumes are preserved. This can be configured with the DeleteOnTermination attribute."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz3_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 4: Database Services
# ==========================================

module4 = CourseModule.find_or_create_by!(slug: 'database-services', course: aws_course) do |mod|
  mod.title = "Database Services - RDS, DynamoDB, and Aurora"
  mod.description = "Master AWS database solutions for relational and NoSQL workloads"
  mod.sequence_order = 4
  mod.estimated_minutes = 240
  mod.published = true
end

lesson4_1 = CourseLesson.find_or_create_by!(title: "RDS and Aurora: Managed Relational Databases") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = <<~MARKDOWN
    # RDS and Aurora: Managed Relational Databases

    AWS-managed relational database service supporting multiple engines.

    ## What is RDS?

    **Managed Database Service** that:
    - Handles provisioning, patching, backup, recovery
    - Supports multiple database engines
    - Provides high availability with Multi-AZ
    - Enables read replicas for scaling reads

    ## Supported Database Engines

    ### MySQL
    - Most popular open-source database
    - Compatible with existing MySQL apps
    - Versions: 5.7, 8.0

    ### PostgreSQL
    - Advanced open-source database
    - Strong data integrity
    - Supports JSON, geospatial data

    ### MariaDB
    - MySQL fork with additional features
    - Drop-in replacement for MySQL

    ### Oracle
    - Enterprise database
    - Bring Your Own License (BYOL) or License Included

    ### SQL Server
    - Microsoft database
    - Express, Web, Standard, Enterprise editions

    ### Amazon Aurora
    - AWS-built MySQL/PostgreSQL compatible
    - 5x faster than MySQL, 3x faster than PostgreSQL
    - Cloud-native architecture

    ## Creating an RDS Instance

    ```bash
    aws rds create-db-instance \\
      --db-instance-identifier mydb \\
      --db-instance-class db.t3.micro \\
      --engine mysql \\
      --master-username admin \\
      --master-user-password MyPassword123 \\
      --allocated-storage 20 \\
      --backup-retention-period 7
    ```

    ## RDS Multi-AZ Deployment

    **High Availability** with automatic failover.

    ### How Multi-AZ Works

    ```
    Primary AZ (us-east-1a)          Standby AZ (us-east-1b)
    ├── Primary DB Instance          ├── Standby DB Instance
    │   (handles all traffic)        │   (synchronous replication)
    │                                 │   (not accessible)
    └── If fails → Automatic failover to standby
    ```

    **Failover Scenarios**:
    - Primary instance failure
    - AZ outage
    - Network failure
    - Storage failure
    - Maintenance operations

    **Benefits**:
    - 99.95% availability SLA
    - Automatic failover (1-2 minutes)
    - No data loss (synchronous replication)

    **Cost**: ~2x single-AZ (running 2 instances)

    ## Read Replicas

    **Scale read traffic** by creating copies.

    ### Use Cases
    - Read-heavy workloads (reporting, analytics)
    - Offload reads from primary
    - Disaster recovery (cross-region)

    ### Creating Read Replicas

    ```bash
    aws rds create-db-instance-read-replica \\
      --db-instance-identifier mydb-replica \\
      --source-db-instance-identifier mydb \\
      --availability-zone us-east-1b
    ```

    **Key Points**:
    - Asynchronous replication
    - Up to 5 read replicas per primary
    - Can promote to standalone database
    - Can be in different regions

    ## Amazon Aurora

    **Cloud-native** database built by AWS.

    ### Aurora Architecture

    **Storage Layer**:
    - Distributed across 3 AZs
    - 6 copies of data
    - Self-healing (automatic repair)
    - 128 TB max size

    **Compute Layer**:
    - 1 primary instance (writes)
    - Up to 15 read replicas (reads)
    - Auto-scaling replicas

    ### Aurora Serverless

    **Auto-scaling** database capacity.

    ```bash
    aws rds create-db-cluster \\
      --db-cluster-identifier aurora-serverless \\
      --engine aurora-mysql \\
      --engine-mode serverless \\
      --scaling-configuration MinCapacity=2,MaxCapacity=16
    ```

    **Use Cases**:
    - Unpredictable workloads
    - Development/test databases
    - Infrequently used applications

    **Pricing**: Pay per second for capacity used

    ### Aurora Global Database

    **Cross-region replication** for disaster recovery.

    - Primary region (read/write)
    - Up to 5 secondary regions (read-only)
    - <1 second replication lag
    - RPO <1 second, RTO <1 minute

    ## RDS Backup and Restore

    ### Automated Backups
    - Daily snapshots
    - Transaction logs every 5 minutes
    - Retention: 0-35 days
    - Point-in-time recovery (PITR)

    ### Manual Snapshots
    - User-initiated
    - Retained until explicitly deleted
    - Can copy across regions

    ```bash
    # Create snapshot
    aws rds create-db-snapshot \\
      --db-snapshot-identifier mydb-snapshot-2024 \\
      --db-instance-identifier mydb

    # Restore from snapshot
    aws rds restore-db-instance-from-db-snapshot \\
      --db-instance-identifier mydb-restored \\
      --db-snapshot-identifier mydb-snapshot-2024
    ```

    ## RDS Security

    ### Network Isolation
    - Deploy in VPC
    - Private subnets (no internet access)
    - Security groups control access

    ### Encryption
    - **At rest**: AES-256 encryption via KMS
    - **In transit**: SSL/TLS connections
    - Enable encryption at creation (can't add later)

    ### IAM Database Authentication
    - Use IAM credentials instead of passwords
    - Token-based (15 minutes validity)

    ```bash
    aws rds generate-db-auth-token \\
      --hostname mydb.abcdef.us-east-1.rds.amazonaws.com \\
      --port 3306 \\
      --username dbuser
    ```

    ## RDS Pricing

    **Components**:
    - Instance hours (db.t3.micro = $0.017/hour)
    - Storage (gp3 = $0.115/GB-month)
    - I/O requests (Provisioned IOPS)
    - Backup storage (beyond free allocation)
    - Data transfer

    **Free Tier**:
    - 750 hours db.t2.micro/month
    - 20 GB storage
    - 20 GB backup storage

    ## RDS Best Practices

    1. **Use Multi-AZ for production**: High availability
    2. **Enable automated backups**: Disaster recovery
    3. **Use read replicas for reads**: Scale horizontally
    4. **Monitor with CloudWatch**: Track performance
    5. **Use parameter groups**: Configure engine settings
    6. **Apply patches during maintenance windows**: Minimize disruption
    7. **Use encryption**: Protect sensitive data

    **Practice**: Try the RDS lab!
  MARKDOWN
  lesson.key_concepts = ['RDS', 'Multi-AZ', 'read replicas', 'Aurora', 'Aurora Serverless', 'database backups']
end

lesson4_2 = CourseLesson.find_or_create_by!(title: "DynamoDB: NoSQL Database Service") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # DynamoDB: NoSQL Database Service

    Fully managed NoSQL database with single-digit millisecond performance.

    ## What is DynamoDB?

    **Key-Value and Document Database** that:
    - Provides consistent performance at any scale
    - Fully managed (no servers to manage)
    - Built-in security, backup, restore
    - Global tables for multi-region replication

    ## DynamoDB Core Concepts

    ### Tables
    Collection of items (like rows).

    ### Items
    Individual records (up to 400 KB).

    ### Attributes
    Data elements (like columns).

    ### Primary Key
    Unique identifier for items.

    **Partition Key** (Hash Key):
    ```
    User Table
    ├── UserID (partition key)
    ├── Name
    └── Email
    ```

    **Composite Key** (Partition + Sort Key):
    ```
    Orders Table
    ├── UserID (partition key)
    ├── OrderDate (sort key)
    ├── Amount
    └── Status
    ```

    ## Creating a DynamoDB Table

    ```bash
    aws dynamodb create-table \\
      --table-name Users \\
      --attribute-definitions \\
        AttributeName=UserID,AttributeType=S \\
      --key-schema \\
        AttributeName=UserID,KeyType=HASH \\
      --billing-mode PAY_PER_REQUEST
    ```

    ## Reading and Writing Data

    ### PutItem (Write)
    ```bash
    aws dynamodb put-item \\
      --table-name Users \\
      --item '{
        "UserID": {"S": "user123"},
        "Name": {"S": "Alice"},
        "Email": {"S": "alice@example.com"},
        "Age": {"N": "30"}
      }'
    ```

    ### GetItem (Read)
    ```bash
    aws dynamodb get-item \\
      --table-name Users \\
      --key '{"UserID": {"S": "user123"}}'
    ```

    ### Query (Read multiple items)
    ```bash
    aws dynamodb query \\
      --table-name Orders \\
      --key-condition-expression "UserID = :uid" \\
      --expression-attribute-values '{":uid": {"S": "user123"}}'
    ```

    ### Scan (Read entire table)
    ```bash
    aws dynamodb scan \\
      --table-name Users \\
      --filter-expression "Age > :age" \\
      --expression-attribute-values '{":age": {"N": "25"}}'
    ```

    ⚠️ **Scan is expensive**: Reads entire table, use Query instead when possible.

    ## DynamoDB Capacity Modes

    ### Provisioned Capacity
    - Specify read/write capacity units
    - Predictable workloads
    - Lower cost if traffic is consistent

    **Capacity Units**:
    - 1 RCU = 1 strongly consistent read/sec (4 KB)
    - 1 WCU = 1 write/sec (1 KB)

    **Example**:
    ```
    Need: 100 reads/sec (8 KB items)
    Calculation: 100 reads × (8 KB / 4 KB) × 1 RCU = 200 RCU

    Cost: 200 RCU × $0.00013/hour = $0.026/hour = $18.72/month
    ```

    ### On-Demand Capacity
    - Pay per request
    - Unpredictable workloads
    - No capacity planning needed

    **Pricing**: $1.25 per million write requests, $0.25 per million reads

    ## Secondary Indexes

    ### Global Secondary Index (GSI)
    - Different partition key than table
    - Query on non-key attributes
    - Has its own RCU/WCU

    ```bash
    aws dynamodb update-table \\
      --table-name Users \\
      --attribute-definitions AttributeName=Email,AttributeType=S \\
      --global-secondary-index-updates '[{
        "Create": {
          "IndexName": "EmailIndex",
          "KeySchema": [{"AttributeName":"Email","KeyType":"HASH"}],
          "Projection": {"ProjectionType": "ALL"},
          "ProvisionedThroughput": {"ReadCapacityUnits":5,"WriteCapacityUnits":5}
        }
      }]'
    ```

    ### Local Secondary Index (LSI)
    - Same partition key, different sort key
    - Must create with table (can't add later)
    - Shares RCU/WCU with table

    ## DynamoDB Streams

    **Capture table changes** for processing.

    ### Use Cases
    - Trigger Lambda on data changes
    - Replicate to another table
    - Maintain aggregations
    - Audit trail

    **Stream Record**:
    ```json
    {
      "eventName": "INSERT",
      "dynamodb": {
        "Keys": {"UserID": {"S": "user123"}},
        "NewImage": {
          "UserID": {"S": "user123"},
          "Name": {"S": "Alice"}
        }
      }
    }
    ```

    ## DynamoDB Global Tables

    **Multi-region replication** for global applications.

    - Active-active replication
    - Write to any region, replicate to all
    - <1 second replication lag
    - Conflict resolution (last writer wins)

    ```bash
    aws dynamodb create-global-table \\
      --global-table-name Users \\
      --replication-group RegionName=us-east-1 RegionName=eu-west-1
    ```

    ## DynamoDB Accelerator (DAX)

    **In-memory cache** for DynamoDB.

    - Microsecond latency (vs millisecond)
    - No application changes (drop-in compatibility)
    - Cache popular items automatically

    **Use Cases**:
    - Read-heavy workloads
    - Real-time bidding
    - Gaming leaderboards

    ## DynamoDB Backup and Restore

    ### On-Demand Backups
    - Full table backup
    - No performance impact
    - Retained until deleted

    ### Point-in-Time Recovery (PITR)
    - Continuous backups (35 days)
    - Restore to any second in the window
    - Enable per table

    ```bash
    # Enable PITR
    aws dynamodb update-continuous-backups \\
      --table-name Users \\
      --point-in-time-recovery-specification PointInTimeRecoveryEnabled=true

    # Restore table
    aws dynamodb restore-table-to-point-in-time \\
      --source-table-name Users \\
      --target-table-name Users-Restored \\
      --restore-date-time 2024-01-01T12:00:00Z
    ```

    ## DynamoDB Best Practices

    ### Design Principles
    1. **Choose the right primary key**: Distribute data evenly
    2. **Use composite keys**: Enable rich queries
    3. **Denormalize data**: Store related data together
    4. **Use sparse indexes**: Index only items with attribute

    ### Performance Optimization
    1. **Use Query instead of Scan**: More efficient
    2. **Use projection expressions**: Retrieve only needed attributes
    3. **Batch operations**: BatchGetItem, BatchWriteItem
    4. **Use GSI for alternative access patterns**: Don't scan

    ### Cost Optimization
    1. **Use on-demand for unpredictable traffic**: Avoid over-provisioning
    2. **Enable auto-scaling**: Adjust capacity automatically
    3. **Archive old data to S3**: Use DynamoDB to S3 export
    4. **Use eventually consistent reads**: 50% cheaper than strongly consistent

    ## DynamoDB vs RDS

    | Feature | DynamoDB | RDS |
    |---------|----------|-----|
    | Type | NoSQL (Key-Value) | SQL (Relational) |
    | Scaling | Automatic, unlimited | Vertical (resize instance) |
    | Performance | Single-digit ms | Varies with load |
    | Schema | Flexible | Fixed schema |
    | Joins | No (denormalize) | Yes |
    | Transactions | Limited (single item) | Full ACID |
    | Use Case | High-scale apps | Complex queries, reports |

    **Practice**: Try the DynamoDB lab!
  MARKDOWN
  lesson.key_concepts = ['DynamoDB', 'NoSQL', 'partition key', 'GSI', 'LSI', 'DynamoDB Streams', 'Global Tables', 'DAX']
end

# Quiz 4.1: Database Services
quiz4_1 = Quiz.find_or_create_by!(title: "Database Services Quiz") do |quiz|
  quiz.description = 'Test your knowledge of RDS, Aurora, and DynamoDB'
  quiz.time_limit_minutes = 25
  quiz.passing_score = 70
end

[
  {
    question_text: "What is the main benefit of RDS Multi-AZ deployment?",
    question_type: "mcq",
    points: 5,
    options: ["High availability with automatic failover", "Increased read performance", "Lower cost", "Faster writes"],
    correct_answer: "High availability with automatic failover",
    explanation: "Multi-AZ provides high availability by maintaining a synchronous standby replica in a different AZ. If the primary fails, RDS automatically fails over to the standby within 1-2 minutes."
  },
  {
    question_text: "What is the purpose of RDS read replicas?",
    question_type: "mcq",
    points: 5,
    options: ["Scale read traffic and offload reporting queries", "Automatic failover", "Encrypt data", "Reduce storage costs"],
    correct_answer: "Scale read traffic and offload reporting queries",
    explanation: "Read replicas use asynchronous replication to create read-only copies of your database. They're ideal for read-heavy workloads, analytics, and reporting without impacting the primary instance."
  },
  {
    question_text: "How many copies of data does Amazon Aurora maintain?",
    question_type: "mcq",
    points: 5,
    options: ["6 copies across 3 AZs", "2 copies across 2 AZs", "3 copies in 1 AZ", "1 copy"],
    correct_answer: "6 copies across 3 AZs",
    explanation: "Aurora stores 6 copies of your data across 3 Availability Zones, providing exceptional durability and availability. The storage layer can lose 2 copies without affecting write availability and 3 copies without affecting read availability."
  },
  {
    question_text: "What is Aurora Serverless best suited for?",
    question_type: "mcq",
    points: 5,
    options: ["Unpredictable or intermittent workloads", "Always-on production databases", "Data warehousing", "Real-time analytics"],
    correct_answer: "Unpredictable or intermittent workloads",
    explanation: "Aurora Serverless automatically scales capacity based on demand and only charges for resources used. It's perfect for development/test environments, infrequently used applications, and unpredictable workloads."
  },
  {
    question_text: "What is the primary key in DynamoDB?",
    question_type: "mcq",
    points: 5,
    options: ["Unique identifier consisting of partition key (and optional sort key)", "Foreign key reference", "Encryption key", "Auto-incrementing integer"],
    correct_answer: "Unique identifier consisting of partition key (and optional sort key)",
    explanation: "DynamoDB primary key can be a simple partition key or a composite key (partition key + sort key). The partition key determines which partition stores the item, while the sort key enables range queries."
  },
  {
    question_text: "What is a DynamoDB Global Secondary Index (GSI)?",
    question_type: "mcq",
    points: 5,
    options: ["Index with different partition key than the table for alternative query patterns", "Index in the same region only", "Backup of the table", "Cache layer"],
    correct_answer: "Index with different partition key than the table for alternative query patterns",
    explanation: "GSI allows you to query data using a different partition key than the table's primary key. It has its own throughput capacity and can project specific attributes from the table."
  },
  {
    question_text: "What is DynamoDB Streams used for?",
    question_type: "mcq",
    points: 5,
    options: ["Capture and process changes to table items", "Improve query performance", "Encrypt data", "Reduce costs"],
    correct_answer: "Capture and process changes to table items",
    explanation: "DynamoDB Streams captures a time-ordered sequence of item-level modifications (insert, update, delete). Common uses include triggering Lambda functions, cross-region replication, and maintaining aggregated views."
  },
  {
    question_text: "What is DynamoDB Accelerator (DAX)?",
    question_type: "mcq",
    points: 5,
    options: ["In-memory cache providing microsecond latency", "Backup service", "Replication tool", "Query optimizer"],
    correct_answer: "In-memory cache providing microsecond latency",
    explanation: "DAX is a fully managed, in-memory cache for DynamoDB that reduces response times from milliseconds to microseconds. It's API-compatible with DynamoDB, requiring minimal code changes."
  },
  {
    question_text: "How do DynamoDB Global Tables work?",
    question_type: "mcq",
    points: 5,
    options: ["Multi-region, active-active replication with automatic conflict resolution", "Single-region only", "Read-only replicas", "Manual synchronization required"],
    correct_answer: "Multi-region, active-active replication with automatic conflict resolution",
    explanation: "Global Tables replicate your DynamoDB tables across multiple AWS regions. All replicas have read and write capabilities, and changes propagate to all regions typically within one second using last-writer-wins conflict resolution."
  },
  {
    question_text: "What's the maximum item size in DynamoDB?",
    question_type: "mcq",
    points: 5,
    options: ["400 KB", "1 MB", "5 GB", "Unlimited"],
    correct_answer: "400 KB",
    explanation: "Each DynamoDB item can be up to 400 KB in size, including attribute names and values. For larger objects, store them in S3 and reference the S3 key in DynamoDB."
  },
  {
    question_text: "When should you use DynamoDB Scan operation?",
    question_type: "mcq",
    points: 5,
    options: ["Rarely - only when you need all items or can't use Query", "For all read operations", "Instead of GetItem", "For best performance"],
    correct_answer: "Rarely - only when you need all items or can't use Query",
    explanation: "Scan reads every item in the table and is expensive in terms of consumed capacity. Use Query whenever possible by designing good partition keys. Scan is appropriate only when you truly need all data or for one-time administrative tasks."
  },
  {
    question_text: "What's the difference between RCU and WCU in DynamoDB?",
    question_type: "mcq",
    points: 5,
    options: ["RCU = read capacity (4KB), WCU = write capacity (1KB)", "They are the same", "RCU is for replicas only", "WCU is cheaper than RCU"],
    correct_answer: "RCU = read capacity (4KB), WCU = write capacity (1KB)",
    explanation: "1 RCU provides one strongly consistent read per second for items up to 4 KB (or two eventually consistent reads). 1 WCU provides one write per second for items up to 1 KB. Larger items consume proportionally more capacity units."
  },
  {
    question_text: "What happens during an RDS automatic failover?",
    question_type: "mcq",
    points: 5,
    options: ["DNS record updated to point to standby, typically 1-2 minutes", "Application must manually reconnect", "All data is lost", "Service is down for hours"],
    correct_answer: "DNS record updated to point to standby, typically 1-2 minutes",
    explanation: "During Multi-AZ failover, RDS automatically updates the DNS CNAME to point to the standby instance. Applications using the DNS name will automatically connect to the new primary after a brief interruption (60-120 seconds)."
  },
  {
    question_text: "Which DynamoDB capacity mode should you use for unpredictable traffic?",
    question_type: "mcq",
    points: 5,
    options: ["On-Demand", "Provisioned", "Reserved", "Spot"],
    correct_answer: "On-Demand",
    explanation: "On-Demand capacity mode is ideal for unpredictable workloads. You pay per request without managing capacity. For predictable traffic, Provisioned mode with auto-scaling is more cost-effective."
  },
  {
    question_text: "What is the retention period for RDS automated backups?",
    question_type: "mcq",
    points: 5,
    options: ["0-35 days (configurable)", "Always 7 days", "Unlimited", "No automated backups"],
    correct_answer: "0-35 days (configurable)",
    explanation: "RDS automated backups are retained for a configurable period from 0 to 35 days. Setting it to 0 disables automated backups. Manual snapshots are retained until you explicitly delete them."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz4_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 5: Advanced Networking
# ==========================================

module5 = CourseModule.find_or_create_by!(slug: 'advanced-networking', course: aws_course) do |mod|
  mod.title = "Advanced Networking - VPC, Route 53, CloudFront"
  mod.description = "Master AWS networking for secure and performant architectures"
  mod.sequence_order = 5
  mod.estimated_minutes = 260
  mod.published = true
end

lesson5_1 = CourseLesson.find_or_create_by!(title: "VPC: Virtual Private Cloud Deep Dive") do |lesson|
  lesson.reading_time_minutes = 45
  lesson.content = <<~MARKDOWN
    # VPC: Virtual Private Cloud Deep Dive

    Isolated network environment in AWS cloud.

    ## VPC Fundamentals

    **Virtual Private Cloud** provides:
    - Logically isolated section of AWS
    - Complete control over network configuration
    - Multiple layers of security
    - Connection to on-premises networks

    ## VPC Components

    ### 1. CIDR Block
    IP address range for your VPC.

    ```
    VPC CIDR: 10.0.0.0/16
    └── Provides 65,536 IP addresses
        (10.0.0.0 to 10.0.255.255)
    ```

    **Best Practices**:
    - Use private IP ranges (RFC 1918)
      - 10.0.0.0/8 (10.0.0.0 - 10.255.255.255)
      - 172.16.0.0/12 (172.16.0.0 - 172.31.255.255)
      - 192.168.0.0/16 (192.168.0.0 - 192.168.255.255)
    - Choose /16 for flexibility (65,536 IPs)
    - Avoid overlap with on-premises networks

    ### 2. Subnets
    Subdivisions of VPC CIDR in specific AZs.

    ```bash
    # Create subnet
    aws ec2 create-subnet \\
      --vpc-id vpc-12345678 \\
      --cidr-block 10.0.1.0/24 \\
      --availability-zone us-east-1a
    ```

    **Subnet Design**:
    ```
    VPC: 10.0.0.0/16

    Public Subnets (internet-accessible):
    ├── 10.0.1.0/24 (us-east-1a) - Web servers
    ├── 10.0.2.0/24 (us-east-1b) - Web servers
    └── 10.0.3.0/24 (us-east-1c) - Web servers

    Private Subnets (no direct internet):
    ├── 10.0.10.0/24 (us-east-1a) - App servers
    ├── 10.0.11.0/24 (us-east-1b) - App servers
    └── 10.0.12.0/24 (us-east-1c) - App servers

    Database Subnets (most restricted):
    ├── 10.0.20.0/24 (us-east-1a) - Databases
    └── 10.0.21.0/24 (us-east-1b) - Databases
    ```

    ### 3. Internet Gateway (IGW)
    Enables internet access for VPC.

    ```bash
    # Create IGW
    aws ec2 create-internet-gateway

    # Attach to VPC
    aws ec2 attach-internet-gateway \\
      --vpc-id vpc-12345678 \\
      --internet-gateway-id igw-12345678
    ```

    **Requirements for Internet Access**:
    1. Internet Gateway attached to VPC
    2. Route table entry pointing to IGW
    3. Public IP address on instance
    4. Security group allowing outbound traffic

    ### 4. NAT Gateway
    Enables private subnets to access internet.

    ```bash
    # Create NAT Gateway (requires public subnet)
    aws ec2 create-nat-gateway \\
      --subnet-id subnet-public-12345678 \\
      --allocation-id eipalloc-12345678
    ```

    **NAT Gateway vs NAT Instance**:

    | Feature | NAT Gateway | NAT Instance |
    |---------|-------------|--------------|
    | Managed | AWS-managed | Self-managed |
    | Availability | High (within AZ) | Manual setup |
    | Bandwidth | Up to 100 Gbps | Depends on instance |
    | Cost | $0.045/hour + data | Instance cost |
    | Maintenance | None | You manage |

    **Best Practice**: Use NAT Gateway per AZ for high availability.

    ### 5. Route Tables
    Control traffic routing within VPC.

    **Public Subnet Route Table**:
    ```
    Destination       Target
    10.0.0.0/16       local (within VPC)
    0.0.0.0/0         igw-12345678 (internet)
    ```

    **Private Subnet Route Table**:
    ```
    Destination       Target
    10.0.0.0/16       local
    0.0.0.0/0         nat-12345678 (NAT Gateway)
    ```

    ### 6. Security Groups
    Stateful firewall at instance level.

    ```bash
    aws ec2 create-security-group \\
      --group-name web-servers \\
      --description "Security group for web servers" \\
      --vpc-id vpc-12345678

    # Allow HTTP from anywhere
    aws ec2 authorize-security-group-ingress \\
      --group-id sg-12345678 \\
      --protocol tcp --port 80 --cidr 0.0.0.0/0

    # Allow HTTPS from anywhere
    aws ec2 authorize-security-group-ingress \\
      --group-id sg-12345678 \\
      --protocol tcp --port 443 --cidr 0.0.0.0/0
    ```

    **Characteristics**:
    - Stateful (return traffic automatically allowed)
    - Allow rules only (no deny rules)
    - Evaluate all rules before deciding
    - Default: Deny all inbound, allow all outbound

    ### 7. Network ACLs (NACLs)
    Stateless firewall at subnet level.

    ```bash
    # Create NACL rule
    aws ec2 create-network-acl-entry \\
      --network-acl-id acl-12345678 \\
      --rule-number 100 \\
      --protocol tcp \\
      --port-range From=80,To=80 \\
      --cidr-block 0.0.0.0/0 \\
      --rule-action allow
    ```

    **Security Groups vs NACLs**:

    | Feature | Security Group | NACL |
    |---------|---------------|------|
    | Level | Instance | Subnet |
    | State | Stateful | Stateless |
    | Rules | Allow only | Allow & Deny |
    | Order | All evaluated | Numbered order |
    | Apply | Selective | All instances in subnet |

    ## VPC Peering

    **Connect two VPCs** privately.

    ```bash
    aws ec2 create-vpc-peering-connection \\
      --vpc-id vpc-11111111 \\
      --peer-vpc-id vpc-22222222
    ```

    **Use Cases**:
    - Connect production and development VPCs
    - Share resources across VPCs
    - Connect VPCs in different accounts

    **Limitations**:
    - Non-transitive (A↔B and B↔C doesn't mean A↔C)
    - CIDR blocks must not overlap
    - Cross-region peering supported

    ## VPC Endpoints

    **Private connections** to AWS services without internet.

    ### Interface Endpoint (PrivateLink)
    - Elastic Network Interface with private IP
    - Supports many services (S3, DynamoDB, SNS, SQS, etc.)
    - Charged per hour + data processed

    ### Gateway Endpoint
    - Route table entry
    - Supports S3 and DynamoDB only
    - Free

    ```bash
    # Create S3 Gateway Endpoint
    aws ec2 create-vpc-endpoint \\
      --vpc-id vpc-12345678 \\
      --service-name com.amazonaws.us-east-1.s3 \\
      --route-table-ids rtb-12345678
    ```

    **Benefits**:
    - No internet gateway needed
    - Lower latency
    - Private access (more secure)
    - Avoid data transfer charges

    ## VPN and Direct Connect

    ### VPN Connection
    Encrypted tunnel over internet.

    ```
    On-Premises ←[VPN over Internet]→ Virtual Private Gateway → VPC
    ```

    **Characteristics**:
    - Quick to setup (hours)
    - Lower cost ($0.05/hour)
    - Up to 1.25 Gbps per tunnel
    - Encrypted by default
    - Subject to internet variability

    ### AWS Direct Connect
    Dedicated network connection.

    ```
    On-Premises ←[Dedicated Line]→ Direct Connect Location → AWS
    ```

    **Characteristics**:
    - Takes weeks/months to provision
    - Higher cost (port hours + data transfer)
    - 1 Gbps or 10 Gbps
    - Consistent network performance
    - Not encrypted (use VPN over DX for encryption)

    ## VPC Flow Logs

    **Capture network traffic** information.

    ```bash
    aws ec2 create-flow-logs \\
      --resource-type VPC \\
      --resource-ids vpc-12345678 \\
      --traffic-type ALL \\
      --log-destination-type cloud-watch-logs \\
      --log-group-name vpc-flow-logs
    ```

    **Use Cases**:
    - Security analysis (detect attacks)
    - Troubleshoot connectivity issues
    - Monitor traffic patterns
    - Meet compliance requirements

    ## VPC Best Practices

    1. **Use multiple AZs**: Deploy subnets in 2+ AZs for high availability
    2. **Layer security**: Use both security groups and NACLs
    3. **Minimize public subnets**: Only resources needing internet should be public
    4. **Use VPC endpoints**: Access AWS services privately
    5. **Enable Flow Logs**: Monitor and troubleshoot network traffic
    6. **Plan CIDR carefully**: Choose large enough block, avoid overlaps
    7. **Use bastion hosts**: Secure access to private resources

    **Practice**: Try the VPC lab!
  MARKDOWN
  lesson.key_concepts = ['VPC', 'subnets', 'Internet Gateway', 'NAT Gateway', 'route tables', 'security groups', 'NACLs', 'VPC peering', 'VPC endpoints']
end

lesson5_2 = CourseLesson.find_or_create_by!(title: "Route 53 and CloudFront") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Route 53 and CloudFront

    DNS management and global content delivery.

    ## Route 53: DNS Service

    **Managed DNS service** that:
    - Translates domain names to IP addresses
    - Routes users to applications
    - Performs health checks
    - Provides domain registration

    ### DNS Basics

    **DNS Record Types**:

    **A Record**: Maps domain to IPv4 address
    ```
    example.com → 54.123.45.67
    ```

    **AAAA Record**: Maps domain to IPv6 address
    ```
    example.com → 2001:0db8:85a3::8a2e:0370:7334
    ```

    **CNAME Record**: Maps domain to another domain
    ```
    www.example.com → example.com
    ```

    **MX Record**: Mail server for domain
    ```
    example.com → mail.example.com (priority: 10)
    ```

    **TXT Record**: Text information
    ```
    example.com → "v=spf1 include:_spf.google.com ~all"
    ```

    ### Creating DNS Records

    ```bash
    aws route53 change-resource-record-sets \\
      --hosted-zone-id Z1234567890ABC \\
      --change-batch '{
        "Changes": [{
          "Action": "CREATE",
          "ResourceRecordSet": {
            "Name": "www.example.com",
            "Type": "A",
            "TTL": 300,
            "ResourceRecords": [{"Value": "54.123.45.67"}]
          }
        }]
      }'
    ```

    ## Route 53 Routing Policies

    ### Simple Routing
    Single resource for domain.

    ```
    example.com → 54.123.45.67
    ```

    **Use Case**: One web server.

    ### Weighted Routing
    Split traffic by percentage.

    ```
    example.com
    ├── 70% → Server A (54.123.45.67)
    └── 30% → Server B (54.123.45.68)
    ```

    **Use Cases**:
    - Blue/green deployments
    - A/B testing
    - Gradual migration

    ### Latency-Based Routing
    Route to lowest latency endpoint.

    ```
    User in Tokyo → ap-northeast-1 (20ms)
    User in London → eu-west-1 (15ms)
    User in New York → us-east-1 (5ms)
    ```

    **Use Case**: Global applications needing best performance.

    ### Failover Routing
    Active-passive failover.

    ```
    Primary (healthy) → Primary Server
    Primary (unhealthy) → Secondary Server
    ```

    **Use Case**: Disaster recovery.

    ### Geolocation Routing
    Route based on user location.

    ```
    Users in Europe → EU servers
    Users in Asia → Asia servers
    Users elsewhere → US servers
    ```

    **Use Cases**:
    - Content localization
    - License restrictions
    - Data sovereignty

    ### Geoproximity Routing
    Route based on geographic distance with bias.

    **Use Case**: Shift traffic between regions (e.g., 60% to nearby region, 40% to farther region).

    ### Multi-Value Answer Routing
    Return multiple IP addresses (up to 8).

    ```
    example.com
    ├── 54.123.45.67 (if healthy)
    ├── 54.123.45.68 (if healthy)
    └── 54.123.45.69 (if healthy)
    ```

    **Use Case**: Simple load distribution with health checks.

    ## Route 53 Health Checks

    **Monitor endpoint health** and route traffic accordingly.

    ```bash
    aws route53 create-health-check \\
      --health-check-config \\
        IPAddress=54.123.45.67,Port=80,Type=HTTP,ResourcePath=/health \\
      --caller-reference $(date +%s)
    ```

    **Health Check Types**:
    - **Endpoint**: Monitor IP or domain
    - **Calculated**: Combine multiple health checks
    - **CloudWatch Alarm**: Monitor CloudWatch metrics

    **Features**:
    - Check from multiple global locations
    - String matching in response
    - Fast or standard interval (10s or 30s)
    - SNS notifications on status changes

    ## CloudFront: Content Delivery Network

    **Global CDN** that:
    - Caches content at edge locations
    - Reduces latency for global users
    - Offloads traffic from origin
    - Provides DDoS protection

    ### How CloudFront Works

    ```
    1. User requests video.mp4
    2. Request goes to nearest edge location
    3. If cached → Return immediately ✓
    4. If not cached:
       - Fetch from origin (S3, EC2, ALB)
       - Cache at edge
       - Return to user
    5. Subsequent requests served from cache
    ```

    ### Creating a CloudFront Distribution

    ```bash
    aws cloudfront create-distribution \\
      --origin-domain-name mybucket.s3.amazonaws.com \\
      --default-root-object index.html
    ```

    **Distribution Settings**:
    - **Origin**: Where content comes from (S3, HTTP server, MediaPackage)
    - **Behaviors**: How CloudFront handles requests (cache, compress, redirect)
    - **Restrictions**: Geographic restrictions
    - **SSL/TLS**: HTTPS support

    ### CloudFront Origins

    **S3 Origin**:
    - Static websites
    - Media files
    - Software downloads
    - Use Origin Access Identity (OAI) to restrict direct S3 access

    **Custom Origin** (HTTP server):
    - EC2 instances
    - Application Load Balancer
    - On-premises servers
    - Any HTTP server

    ### Cache Behavior

    **TTL (Time To Live)**:
    ```
    Minimum TTL: 0 seconds
    Default TTL: 86400 seconds (24 hours)
    Maximum TTL: 31536000 seconds (1 year)
    ```

    **Cache Key**:
    - URL path
    - Query strings (optional)
    - Headers (optional)
    - Cookies (optional)

    **Invalidation** (Clear cache):
    ```bash
    aws cloudfront create-invalidation \\
      --distribution-id E1234567890ABC \\
      --paths "/*"
    ```

    ### CloudFront Security

    **Signed URLs**: Restrict access to content.

    ```python
    # Generate signed URL (expires in 1 hour)
    from botocore.signers import CloudFrontSigner

    url = cloudfront_signer.generate_presigned_url(
        'https://d111111abcdef8.cloudfront.net/video.mp4',
        date_less_than=datetime.now() + timedelta(hours=1)
    )
    ```

    **Geo Restriction**:
    - Whitelist: Allow only specific countries
    - Blacklist: Block specific countries

    **HTTPS**:
    - Viewer → CloudFront: HTTPS
    - CloudFront → Origin: HTTP or HTTPS

    **AWS WAF Integration**: Protect against web attacks.

    ## CloudFront Use Cases

    ### Static Website
    ```
    S3 Bucket (origin) → CloudFront → Users worldwide
    ```
    **Benefit**: Fast load times globally.

    ### Video Streaming
    ```
    S3 (videos) → CloudFront → Users
    ```
    **Benefit**: Smooth streaming without buffering.

    ### API Acceleration
    ```
    API Gateway → CloudFront → Global users
    ```
    **Benefit**: Reduce API latency.

    ### Dynamic Content
    ```
    ALB + EC2 → CloudFront → Users
    ```
    **Benefit**: Cache static assets, proxy dynamic requests.

    ## Route 53 + CloudFront Integration

    **Complete Solution**:
    ```
    1. User requests www.example.com
    2. Route 53 resolves to CloudFront distribution
    3. CloudFront serves cached content from edge
    4. If not cached, fetches from S3/ALB origin
    ```

    **Setup**:
    ```bash
    # Create CloudFront distribution
    DISTRIBUTION_ID=$(aws cloudfront create-distribution ...)

    # Get CloudFront domain name
    CF_DOMAIN=d111111abcdef8.cloudfront.net

    # Create Route 53 alias record
    aws route53 change-resource-record-sets \\
      --hosted-zone-id Z1234567890ABC \\
      --change-batch '{
        "Changes": [{
          "Action": "CREATE",
          "ResourceRecordSet": {
            "Name": "www.example.com",
            "Type": "A",
            "AliasTarget": {
              "HostedZoneId": "Z2FDTNDATAQYW2",
              "DNSName": "d111111abcdef8.cloudfront.net",
              "EvaluateTargetHealth": false
            }
          }
        }]
      }'
    ```

    ## Pricing

    ### Route 53
    - Hosted zone: $0.50/month
    - Standard queries: $0.40 per million
    - Latency-based routing: $0.60 per million
    - Health checks: $0.50/month per check

    ### CloudFront
    - Data transfer out: $0.085/GB (first 10 TB)
    - Requests: $0.0075 per 10,000 HTTPS requests
    - Invalidations: First 1,000/month free, then $0.005 per path

    ## Best Practices

    1. **Use Route 53 health checks**: Automatic failover
    2. **Enable CloudFront compression**: Reduce bandwidth
    3. **Set appropriate cache TTLs**: Balance freshness and performance
    4. **Use CloudFront signed URLs**: Protect premium content
    5. **Monitor with CloudWatch**: Track cache hit ratio
    6. **Use Route 53 alias records**: Point to CloudFront (no charge)

    **Practice**: Try the Route 53 and CloudFront lab!
  MARKDOWN
  lesson.key_concepts = ['Route 53', 'DNS', 'routing policies', 'health checks', 'CloudFront', 'CDN', 'edge locations', 'cache behavior']
end

# Quiz 5.1: Advanced Networking
quiz5_1 = Quiz.find_or_create_by!(title: "Advanced Networking Quiz") do |quiz|
  quiz.description = 'Test your knowledge of VPC, Route 53, and CloudFront'
  quiz.time_limit_minutes = 25
  quiz.passing_score = 70
end

[
  {
    question_text: "What is the purpose of a NAT Gateway in a VPC?",
    question_type: "mcq",
    points: 5,
    options: ["Allow instances in private subnets to access the internet", "Allow internet to access private instances", "Encrypt traffic", "Balance load"],
    correct_answer: "Allow instances in private subnets to access the internet",
    explanation: "NAT Gateway enables instances in private subnets to initiate outbound connections to the internet (e.g., for software updates) while preventing inbound connections from the internet."
  },
  {
    question_text: "What's the difference between Security Groups and Network ACLs?",
    question_type: "mcq",
    points: 5,
    options: ["Security Groups are stateful (instance-level), NACLs are stateless (subnet-level)", "They are the same", "NACLs are stateful, Security Groups are stateless", "Security Groups are for VPCs, NACLs are for subnets"],
    correct_answer: "Security Groups are stateful (instance-level), NACLs are stateless (subnet-level)",
    explanation: "Security Groups operate at the instance level and are stateful (return traffic automatically allowed). NACLs operate at the subnet level and are stateless (must explicitly allow both inbound and outbound traffic)."
  },
  {
    question_text: "What is a VPC endpoint used for?",
    question_type: "mcq",
    points: 5,
    options: ["Private connection to AWS services without using internet", "Connect to on-premises network", "Public internet access", "DNS resolution"],
    correct_answer: "Private connection to AWS services without using internet",
    explanation: "VPC endpoints enable private connections between your VPC and AWS services without requiring an internet gateway, NAT device, VPN, or Direct Connect. This improves security and reduces data transfer costs."
  },
  {
    question_text: "What is VPC peering?",
    question_type: "mcq",
    points: 5,
    options: ["Direct network connection between two VPCs", "Connection to internet", "Load balancing between VPCs", "DNS service"],
    correct_answer: "Direct network connection between two VPCs",
    explanation: "VPC peering creates a direct network route between two VPCs, enabling instances to communicate using private IP addresses. Peering is non-transitive and requires non-overlapping CIDR blocks."
  },
  {
    question_text: "Which Route 53 routing policy routes traffic based on lowest latency?",
    question_type: "mcq",
    points: 5,
    options: ["Latency-based routing", "Geolocation routing", "Simple routing", "Weighted routing"],
    correct_answer: "Latency-based routing",
    explanation: "Latency-based routing directs users to the AWS region that provides the lowest latency, improving application performance for global users."
  },
  {
    question_text: "What is the purpose of Route 53 health checks?",
    question_type: "mcq",
    points: 5,
    options: ["Monitor endpoint health and route traffic only to healthy resources", "Check DNS configuration", "Measure network speed", "Count requests"],
    correct_answer: "Monitor endpoint health and route traffic only to healthy resources",
    explanation: "Health checks monitor the health of your resources and Route 53 uses this information to route traffic only to healthy endpoints, providing automatic failover capability."
  },
  {
    question_text: "What is CloudFront?",
    question_type: "mcq",
    points: 5,
    options: ["Content Delivery Network (CDN) that caches content at edge locations", "Database service", "Compute service", "Storage service"],
    correct_answer: "Content Delivery Network (CDN) that caches content at edge locations",
    explanation: "CloudFront is AWS's CDN service with 400+ edge locations worldwide. It caches content closer to users, reducing latency and improving performance for global applications."
  },
  {
    question_text: "What is a CloudFront signed URL used for?",
    question_type: "mcq",
    points: 5,
    options: ["Restrict access to premium content with time-limited access", "Speed up content delivery", "Encrypt data", "Compress files"],
    correct_answer: "Restrict access to premium content with time-limited access",
    explanation: "Signed URLs provide temporary, secure access to private content. They include an expiration time and optional IP restrictions, commonly used for premium content, paid videos, or subscriber-only resources."
  },
  {
    question_text: "What does TTL stand for in CloudFront, and what does it control?",
    question_type: "mcq",
    points: 5,
    options: ["Time To Live - how long content is cached at edge locations", "Total Transfer Limit", "Traffic Threshold Level", "Transmission Time Lag"],
    correct_answer: "Time To Live - how long content is cached at edge locations",
    explanation: "TTL determines how long CloudFront caches an object before requesting a fresh copy from the origin. Longer TTLs reduce origin load but may serve stale content; shorter TTLs ensure freshness but increase origin requests."
  },
  {
    question_text: "What is the benefit of using a CloudFront Origin Access Identity (OAI)?",
    question_type: "mcq",
    points: 5,
    options: ["Restrict S3 bucket access to only CloudFront, preventing direct access", "Speed up S3 access", "Encrypt S3 data", "Reduce S3 costs"],
    correct_answer: "Restrict S3 bucket access to only CloudFront, preventing direct access",
    explanation: "OAI is a special CloudFront user that can access your S3 bucket. You configure S3 bucket policies to allow only the OAI, preventing users from bypassing CloudFront and accessing S3 directly."
  },
  {
    question_text: "Which VPC component allows instances in a public subnet to communicate with the internet?",
    question_type: "mcq",
    points: 5,
    options: ["Internet Gateway", "NAT Gateway", "VPC Endpoint", "Virtual Private Gateway"],
    correct_answer: "Internet Gateway",
    explanation: "Internet Gateway enables bidirectional communication between instances in a VPC and the internet. It performs NAT for instances with public IP addresses and is required for any internet-facing resources."
  },
  {
    question_text: "What is AWS Direct Connect?",
    question_type: "mcq",
    points: 5,
    options: ["Dedicated network connection from on-premises to AWS", "VPN over internet", "CloudFront edge location", "Route 53 feature"],
    correct_answer: "Dedicated network connection from on-premises to AWS",
    explanation: "Direct Connect provides a dedicated, private network connection between your data center and AWS, offering more consistent network performance than VPN over internet, though it takes longer to provision and costs more."
  },
  {
    question_text: "What are VPC Flow Logs used for?",
    question_type: "mcq",
    points: 5,
    options: ["Capture network traffic information for security analysis and troubleshooting", "Improve network speed", "Reduce costs", "Balance load"],
    correct_answer: "Capture network traffic information for security analysis and troubleshooting",
    explanation: "VPC Flow Logs capture information about IP traffic going to and from network interfaces in your VPC. They're useful for security analysis, troubleshooting connectivity issues, and monitoring traffic patterns."
  },
  {
    question_text: "Which Route 53 routing policy would you use for blue/green deployments?",
    question_type: "mcq",
    points: 5,
    options: ["Weighted routing", "Simple routing", "Latency routing", "Geolocation routing"],
    correct_answer: "Weighted routing",
    explanation: "Weighted routing allows you to split traffic by percentage (e.g., 90% to blue, 10% to green), making it ideal for gradual migrations, A/B testing, and blue/green deployments where you want to shift traffic gradually."
  },
  {
    question_text: "What is the difference between Gateway Endpoint and Interface Endpoint?",
    question_type: "mcq",
    points: 5,
    options: ["Gateway uses route tables (S3/DynamoDB only, free), Interface uses ENI (many services, charged)", "They are the same", "Gateway is faster", "Interface is only for EC2"],
    correct_answer: "Gateway uses route tables (S3/DynamoDB only, free), Interface uses ENI (many services, charged)",
    explanation: "Gateway endpoints work via route table entries and support only S3 and DynamoDB (free). Interface endpoints use Elastic Network Interfaces with private IPs, support many services, but incur hourly and data processing charges."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz5_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 6: Monitoring & Management
# ==========================================

module6 = CourseModule.find_or_create_by!(slug: 'monitoring-management', course: aws_course) do |mod|
  mod.title = "Monitoring & Management - CloudWatch and CloudTrail"
  mod.description = "Monitor, log, and audit your AWS infrastructure"
  mod.sequence_order = 6
  mod.estimated_minutes = 180
  mod.published = true
end

lesson6_1 = CourseLesson.find_or_create_by!(title: "CloudWatch: Monitoring and Observability") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # CloudWatch: Monitoring and Observability

    Comprehensive monitoring service for AWS resources and applications.

    ## What is CloudWatch?

    **Monitoring and Observability Platform** that:
    - Collects and tracks metrics
    - Monitors log files
    - Sets alarms
    - Automatically reacts to changes

    ## CloudWatch Metrics

    **Time-ordered data points** about your resources.

    ### Default Metrics (Free)

    **EC2 Instance Metrics**:
    - CPU Utilization
    - Disk Reads/Writes
    - Network In/Out
    - Status Checks

    **Frequency**: Every 5 minutes (basic monitoring)

    **Enable Detailed Monitoring**: 1-minute intervals (charged)

    ```bash
    aws ec2 monitor-instances --instance-ids i-1234567890abcdef0
    ```

    ### Custom Metrics

    **Send your own metrics**:

    ```bash
    aws cloudwatch put-metric-data \\
      --namespace "MyApp" \\
      --metric-name "PageLoadTime" \\
      --value 245 \\
      --unit Milliseconds
    ```

    **Common Use Cases**:
    - Application performance (response time, error rate)
    - Business metrics (orders, signups)
    - Custom health checks

    ## CloudWatch Alarms

    **Trigger actions** based on metric thresholds.

    ### Creating an Alarm

    ```bash
    aws cloudwatch put-metric-alarm \\
      --alarm-name "HighCPU" \\
      --alarm-description "Alert when CPU exceeds 80%" \\
      --metric-name CPUUtilization \\
      --namespace AWS/EC2 \\
      --statistic Average \\
      --period 300 \\
      --evaluation-periods 2 \\
      --threshold 80 \\
      --comparison-operator GreaterThanThreshold \\
      --dimensions Name=InstanceId,Value=i-1234567890abcdef0
    ```

    ### Alarm States

    ```
    OK → Metric within threshold
    ALARM → Metric exceeds threshold
    INSUFFICIENT_DATA → Not enough data to determine
    ```

    ### Alarm Actions

    **SNS Notification**:
    - Email
    - SMS
    - Lambda function
    - HTTP/HTTPS endpoint

    **Auto Scaling**:
    - Scale up when CPU > 70%
    - Scale down when CPU < 30%

    **EC2 Actions**:
    - Stop instance
    - Terminate instance
    - Reboot instance
    - Recover instance

    ## CloudWatch Logs

    **Centralized log management**.

    ### Log Components

    **Log Groups**: Container for log streams (e.g., `/aws/lambda/my-function`)

    **Log Streams**: Sequence of log events from same source

    **Log Events**: Record of activity (timestamp + message)

    ### Sending Logs to CloudWatch

    **CloudWatch Logs Agent**:
    ```bash
    # Install agent on EC2
    sudo yum install -y awslogs

    # Configure
    sudo vi /etc/awslogs/awslogs.conf

    # Start agent
    sudo service awslogs start
    ```

    **Application Code** (Python):
    ```python
    import boto3
    import time

    logs = boto3.client('logs')

    logs.put_log_events(
        logGroupName='/myapp/logs',
        logStreamName='app-server-1',
        logEvents=[
            {
                'timestamp': int(time.time() * 1000),
                'message': 'User login successful: user123'
            }
        ]
    )
    ```

    ### Log Insights

    **Query and analyze logs**:

    ```sql
    # Find errors in last hour
    fields @timestamp, @message
    | filter @message like /ERROR/
    | sort @timestamp desc
    | limit 20

    # Count errors by type
    fields @message
    | filter @message like /ERROR/
    | stats count() by @message
    ```

    **Example Queries**:

    **Find slowest Lambda invocations**:
    ```sql
    filter @type = "REPORT"
    | fields @requestId, @duration
    | sort @duration desc
    | limit 10
    ```

    **Count 5xx errors**:
    ```sql
    fields @timestamp, @message
    | filter @message like /5\d{2}/
    | stats count() as errors by bin(5m)
    ```

    ## CloudWatch Dashboards

    **Visualize metrics** in custom dashboards.

    ### Creating Dashboard

    ```bash
    aws cloudwatch put-dashboard \\
      --dashboard-name "MyApp" \\
      --dashboard-body file://dashboard.json
    ```

    **dashboard.json**:
    ```json
    {
      "widgets": [
        {
          "type": "metric",
          "properties": {
            "metrics": [
              ["AWS/EC2", "CPUUtilization", {"stat": "Average"}]
            ],
            "period": 300,
            "stat": "Average",
            "region": "us-east-1",
            "title": "EC2 CPU Utilization"
          }
        }
      ]
    }
    ```

    **Widget Types**:
    - Line graph
    - Stacked area
    - Number (single value)
    - Bar chart
    - Pie chart
    - Logs table

    ## CloudWatch Events (EventBridge)

    **React to state changes** in AWS resources.

    ### Event Patterns

    **EC2 Instance State Change**:
    ```json
    {
      "source": ["aws.ec2"],
      "detail-type": ["EC2 Instance State-change Notification"],
      "detail": {
        "state": ["terminated"]
      }
    }
    ```

    **Scheduled Event** (Cron):
    ```bash
    # Run Lambda every day at 9 AM UTC
    aws events put-rule \\
      --name "DailyReport" \\
      --schedule-expression "cron(0 9 * * ? *)"

    aws events put-targets \\
      --rule "DailyReport" \\
      --targets "Id"="1","Arn"="arn:aws:lambda:us-east-1:123:function:report"
    ```

    ### Event Targets

    - Lambda function
    - SNS topic
    - SQS queue
    - ECS task
    - Step Functions
    - Systems Manager

    ## CloudWatch Pricing

    **Free Tier**:
    - 10 custom metrics
    - 10 alarms
    - 1,000,000 API requests
    - 5 GB log ingestion
    - 5 GB log storage

    **Paid**:
    - Custom metrics: $0.30/metric/month
    - Alarms: $0.10/alarm/month
    - Log ingestion: $0.50/GB
    - Log storage: $0.03/GB/month
    - Logs Insights queries: $0.005/GB scanned

    ## CloudWatch Best Practices

    1. **Set meaningful alarms**: Alert on what matters
    2. **Use composite alarms**: Combine multiple metrics
    3. **Tag resources**: Organize metrics by environment
    4. **Use Log Insights**: Don't export logs unnecessarily
    5. **Set log retention**: Auto-delete old logs to save costs
    6. **Create dashboards**: Visualize key metrics
    7. **Use detailed monitoring for critical resources**: 1-minute granularity

    **Practice**: Try the CloudWatch lab!
  MARKDOWN
  lesson.key_concepts = ['CloudWatch', 'metrics', 'alarms', 'logs', 'Log Insights', 'dashboards', 'EventBridge']
end

lesson6_2 = CourseLesson.find_or_create_by!(title: "CloudTrail and AWS Config") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # CloudTrail and AWS Config

    Audit and compliance monitoring for AWS accounts.

    ## AWS CloudTrail

    **Track user activity and API usage**.

    ### What CloudTrail Records

    **Every API call** made in your account:
    - Who made the request (user, role)
    - When it was made (timestamp)
    - What action was performed
    - Which resources were affected
    - Source IP address
    - Request parameters
    - Response elements

    **Example CloudTrail Event**:
    ```json
    {
      "eventName": "RunInstances",
      "eventTime": "2024-01-15T10:30:00Z",
      "userIdentity": {
        "type": "IAMUser",
        "userName": "alice"
      },
      "sourceIPAddress": "203.0.113.42",
      "requestParameters": {
        "instanceType": "t3.micro",
        "imageId": "ami-0c55b159cbfafe1f0"
      }
    }
    ```

    ### Enabling CloudTrail

    ```bash
    aws cloudtrail create-trail \\
      --name my-trail \\
      --s3-bucket-name my-cloudtrail-bucket

    aws cloudtrail start-logging \\
      --name my-trail
    ```

    ### CloudTrail Event Types

    **Management Events**:
    - Creating EC2 instances
    - Creating S3 buckets
    - Configuring security groups
    - IAM user creation

    **Data Events** (optional, extra cost):
    - S3 object-level operations (GetObject, PutObject)
    - Lambda function executions

    **Insights Events**:
    - Unusual API activity detected by ML

    ### Use Cases

    **Security Analysis**:
    - Who deleted the production database?
    - Which user created this insecure security group?

    **Compliance Auditing**:
    - Prove who accessed sensitive data
    - Track changes to compliance-critical resources

    **Troubleshooting**:
    - What changed before the outage?
    - When was this instance terminated?

    ## CloudTrail Log Storage

    **S3 Bucket**:
    - Long-term storage
    - Encrypted by default
    - Lifecycle policies for archival

    **CloudWatch Logs** (optional):
    - Real-time monitoring
    - Create alarms on specific events

    ```bash
    # Send to CloudWatch Logs
    aws cloudtrail update-trail \\
      --name my-trail \\
      --cloud-watch-logs-log-group-arn arn:aws:logs:us-east-1:123:log-group:CloudTrail \\
      --cloud-watch-logs-role-arn arn:aws:iam::123:role/CloudTrailRole
    ```

    ## CloudTrail Insights

    **Detect unusual activity** using machine learning.

    ### What Insights Detects

    - Unusual API call volume
    - Rare API calls
    - Error rate spikes
    - Atypical service usage

    **Example**:
    ```
    Normal: 10 DescribeInstances/hour
    Insight: 1,000 DescribeInstances in 5 minutes
    → Possible credential compromise or misconfigured script
    ```

    ### Enabling Insights

    ```bash
    aws cloudtrail put-insight-selectors \\
      --trail-name my-trail \\
      --insight-selectors '[{"InsightType": "ApiCallRateInsight"}]'
    ```

    ## AWS Config

    **Track resource configuration changes** over time.

    ### What Config Records

    - Resource inventory
    - Configuration history
    - Change timeline
    - Relationships between resources

    **Example**: Track EC2 security group changes
    ```
    Time: 2024-01-15 10:00 AM
    Security Group sg-12345:
      Inbound rules: SSH from 10.0.0.0/8

    Time: 2024-01-15 11:00 AM
    Security Group sg-12345:
      Inbound rules: SSH from 0.0.0.0/0  ← CHANGED!
    ```

    ### Enabling AWS Config

    ```bash
    aws configservice put-configuration-recorder \\
      --configuration-recorder name=default,roleARN=arn:aws:iam::123:role/ConfigRole

    aws configservice put-delivery-channel \\
      --delivery-channel name=default,s3BucketName=my-config-bucket

    aws configservice start-configuration-recorder \\
      --configuration-recorder-name default
    ```

    ## Config Rules

    **Automated compliance checking**.

    ### AWS Managed Rules

    **Common Rules**:
    - `encrypted-volumes`: Check if EBS volumes are encrypted
    - `rds-multi-az-support`: Verify RDS has Multi-AZ enabled
    - `s3-bucket-public-read-prohibited`: Ensure S3 buckets aren't public
    - `required-tags`: Check if resources have required tags

    ### Creating a Config Rule

    ```bash
    aws configservice put-config-rule \\
      --config-rule '{
        "ConfigRuleName": "encrypted-volumes",
        "Source": {
          "Owner": "AWS",
          "SourceIdentifier": "ENCRYPTED_VOLUMES"
        }
      }'
    ```

    ### Compliance Dashboard

    ```
    Rule: encrypted-volumes
    ├── Compliant: 45 volumes
    └── Non-Compliant: 3 volumes
        ├── vol-abc123 (us-east-1a) - Not encrypted
        ├── vol-def456 (us-east-1b) - Not encrypted
        └── vol-ghi789 (us-east-1c) - Not encrypted
    ```

    ## Config Remediation

    **Automatically fix** non-compliant resources.

    ```bash
    # Attach remediation to rule
    aws configservice put-remediation-configurations \\
      --remediation-configurations '{
        "ConfigRuleName": "s3-bucket-public-read-prohibited",
        "TargetType": "SSM_DOCUMENT",
        "TargetIdentifier": "AWS-PublishSNSNotification",
        "Automatic": true
      }'
    ```

    **Remediation Actions**:
    - Remove public access from S3 bucket
    - Attach required tags
    - Enable encryption
    - Notify via SNS

    ## CloudTrail vs Config

    | Feature | CloudTrail | Config |
    |---------|-----------|---------|
    | Records | API calls | Resource configurations |
    | When | Point-in-time events | Configuration snapshots |
    | Use Case | Who did what, when | How resource is configured |
    | Example | "Alice created EC2 at 10 AM" | "EC2 security group allows SSH from 0.0.0.0/0" |

    **Use Together**: CloudTrail shows WHO made change, Config shows WHAT changed.

    ## Compliance and Security

    ### Common Compliance Scenarios

    **PCI-DSS**:
    - Track all access to cardholder data environment
    - Prove encryption is enabled
    - Monitor for configuration changes

    **HIPAA**:
    - Audit access to PHI (Protected Health Information)
    - Track who accessed which resources
    - Ensure encryption and access controls

    **SOC 2**:
    - Demonstrate security controls
    - Log all administrative actions
    - Monitor for unauthorized changes

    ## Multi-Account Strategy

    **Organization Trail**:
    - One trail for all accounts
    - Centralized logging to master account
    - Prevents individual accounts from disabling logging

    ```bash
    aws cloudtrail create-trail \\
      --name org-trail \\
      --s3-bucket-name org-cloudtrail-bucket \\
      --is-organization-trail
    ```

    ## Pricing

    ### CloudTrail
    - First trail: Free
    - Additional trails: $2.00/100,000 events
    - Insights: $0.35/100,000 events
    - Data events: $0.10/100,000 events

    ### AWS Config
    - Configuration items: $0.003 per item recorded
    - Rule evaluations: $0.001 per evaluation
    - Example: 100 resources × 30 days = $9/month

    ## Best Practices

    1. **Enable CloudTrail in all regions**: Comprehensive coverage
    2. **Use organization trail**: Centralized logging
    3. **Enable log file validation**: Detect tampering
    4. **Enable Insights**: Detect unusual activity
    5. **Set up Config rules**: Automated compliance
    6. **Integrate with Security Hub**: Unified security view
    7. **Set S3 lifecycle policies**: Archive old logs to save costs

    **Practice**: Try the CloudTrail and Config lab!
  MARKDOWN
  lesson.key_concepts = ['CloudTrail', 'audit logging', 'API tracking', 'AWS Config', 'compliance', 'Config Rules', 'remediation']
end

# Quiz 6.1: Monitoring & Management
quiz6_1 = Quiz.find_or_create_by!(title: "Monitoring & Management Quiz") do |quiz|
  quiz.description = 'Test your knowledge of CloudWatch, CloudTrail, and AWS Config'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
end

[
  {
    question_text: "What is the purpose of CloudWatch?",
    question_type: "mcq",
    points: 5,
    options: ["Monitor AWS resources and applications with metrics, logs, and alarms", "Audit API calls", "Configure resources", "Encrypt data"],
    correct_answer: "Monitor AWS resources and applications with metrics, logs, and alarms",
    explanation: "CloudWatch is AWS's monitoring and observability service. It collects metrics, monitors log files, sets alarms, and automatically reacts to changes in your AWS environment."
  },
  {
    question_text: "What is a CloudWatch alarm used for?",
    question_type: "mcq",
    points: 5,
    options: ["Trigger actions based on metric thresholds", "Store log files", "Encrypt data", "Create backups"],
    correct_answer: "Trigger actions based on metric thresholds",
    explanation: "CloudWatch alarms watch metrics and trigger actions (like SNS notifications or Auto Scaling) when a metric exceeds a defined threshold over a specified time period."
  },
  {
    question_text: "What is AWS CloudTrail used for?",
    question_type: "mcq",
    points: 5,
    options: ["Record API calls and user activity for audit and compliance", "Monitor metrics", "Configure resources", "Deploy applications"],
    correct_answer: "Record API calls and user activity for audit and compliance",
    explanation: "CloudTrail tracks all API calls made in your AWS account, recording who made the request, when, from where, and what action was performed - essential for security auditing and compliance."
  },
  {
    question_text: "What's the difference between CloudWatch and CloudTrail?",
    question_type: "mcq",
    points: 5,
    options: ["CloudWatch monitors performance, CloudTrail audits API activity", "They are the same", "CloudTrail monitors performance", "CloudWatch only works with EC2"],
    correct_answer: "CloudWatch monitors performance, CloudTrail audits API activity",
    explanation: "CloudWatch monitors resource performance and application health through metrics and logs. CloudTrail provides audit trails of API calls for governance, compliance, and security analysis."
  },
  {
    question_text: "What is AWS Config used for?",
    question_type: "mcq",
    points: 5,
    options: ["Track resource configuration changes and compliance", "Monitor application logs", "Encrypt data", "Deploy code"],
    correct_answer: "Track resource configuration changes and compliance",
    explanation: "AWS Config continuously monitors and records AWS resource configurations, tracks changes over time, and evaluates compliance against desired configurations using Config Rules."
  },
  {
    question_text: "What are Config Rules?",
    question_type: "mcq",
    points: 5,
    options: ["Automated compliance checks for resource configurations", "CloudWatch alarms", "IAM policies", "Network rules"],
    correct_answer: "Automated compliance checks for resource configurations",
    explanation: "Config Rules are compliance policies that automatically evaluate whether your AWS resources comply with your desired configurations (e.g., all EBS volumes must be encrypted)."
  },
  {
    question_text: "What is CloudWatch Log Insights?",
    question_type: "mcq",
    points: 5,
    options: ["Query and analyze log data interactively", "Store metrics", "Create alarms", "Deploy applications"],
    correct_answer: "Query and analyze log data interactively",
    explanation: "CloudWatch Logs Insights is a fully managed query service that lets you search and analyze log data using a query language, making it easy to troubleshoot issues and understand application behavior."
  },
  {
    question_text: "How often does CloudWatch collect default EC2 metrics?",
    question_type: "mcq",
    points: 5,
    options: ["Every 5 minutes (basic monitoring)", "Every minute", "Every second", "Every hour"],
    correct_answer: "Every 5 minutes (basic monitoring)",
    explanation: "By default, CloudWatch collects EC2 metrics every 5 minutes at no charge. You can enable detailed monitoring for 1-minute intervals at an additional cost."
  },
  {
    question_text: "What can CloudWatch alarms trigger?",
    question_type: "mcq",
    points: 5,
    options: ["SNS notifications, Auto Scaling actions, EC2 actions", "Only emails", "Only EC2 actions", "Nothing automatically"],
    correct_answer: "SNS notifications, Auto Scaling actions, EC2 actions",
    explanation: "CloudWatch alarms can trigger multiple actions: send notifications via SNS, trigger Auto Scaling policies, or perform EC2 actions (stop, terminate, reboot, recover instances)."
  },
  {
    question_text: "What is CloudTrail Insights?",
    question_type: "mcq",
    points: 5,
    options: ["ML-powered detection of unusual API activity", "Log storage service", "Metric collection", "Resource configuration"],
    correct_answer: "ML-powered detection of unusual API activity",
    explanation: "CloudTrail Insights uses machine learning to automatically detect unusual API call volumes or error rates, helping identify potential security issues or misconfigurations."
  },
  {
    question_text: "Where are CloudTrail logs stored?",
    question_type: "mcq",
    points: 5,
    options: ["S3 bucket (and optionally CloudWatch Logs)", "Only CloudWatch", "Only DynamoDB", "Local disk"],
    correct_answer: "S3 bucket (and optionally CloudWatch Logs)",
    explanation: "CloudTrail stores logs in an S3 bucket for long-term storage and compliance. You can optionally send logs to CloudWatch Logs for real-time monitoring and alerting."
  },
  {
    question_text: "What is an organization trail in CloudTrail?",
    question_type: "mcq",
    points: 5,
    options: ["Single trail that logs events for all accounts in an AWS Organization", "Trail for one account", "Trail for one region", "Trial version of CloudTrail"],
    correct_answer: "Single trail that logs events for all accounts in an AWS Organization",
    explanation: "An organization trail automatically logs all events for all AWS accounts in an AWS Organization, providing centralized audit logging and preventing individual accounts from disabling it."
  },
  {
    question_text: "What can Config remediation do?",
    question_type: "mcq",
    points: 5,
    options: ["Automatically fix non-compliant resources", "Delete resources", "Create backups", "Monitor metrics"],
    correct_answer: "Automatically fix non-compliant resources",
    explanation: "Config remediation can automatically execute Systems Manager automation documents to fix non-compliant resources, such as removing public access from S3 buckets or enabling encryption."
  },
  {
    question_text: "What type of events does CloudTrail record by default?",
    question_type: "mcq",
    points: 5,
    options: ["Management events (control plane operations)", "Data events only", "Network traffic", "Application logs"],
    correct_answer: "Management events (control plane operations)",
    explanation: "CloudTrail records management events (API calls for creating, modifying, deleting resources) by default at no extra cost. Data events (S3 object operations, Lambda executions) are optional and incur additional charges."
  },
  {
    question_text: "What is the default retention period for CloudWatch Logs?",
    question_type: "mcq",
    points: 5,
    options: ["Never expire (indefinite retention until you delete)", "30 days", "7 days", "1 year"],
    correct_answer: "Never expire (indefinite retention until you delete)",
    explanation: "By default, CloudWatch Logs are retained indefinitely. You should configure retention policies (1 day to 10 years) to control storage costs and meet compliance requirements."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz6_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 7: Messaging & Integration
# ==========================================

module7 = CourseModule.find_or_create_by!(slug: 'messaging-integration', course: aws_course) do |mod|
  mod.title = "Messaging & Integration - SQS, SNS, and EventBridge"
  mod.description = "Build decoupled, scalable applications with AWS messaging services"
  mod.sequence_order = 7
  mod.estimated_minutes = 200
  mod.published = true
end

lesson7_1 = CourseLesson.find_or_create_by!(title: "SQS: Simple Queue Service") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = "# SQS: Simple Queue Service\n\nFully managed message queuing service for decoupling applications.\n\n## What is SQS?\n\n**Message Queue Service** that:\n- Stores messages temporarily between application components\n- Enables asynchronous communication\n- Decouples producers from consumers\n- Automatically scales to handle any load\n\n## Why Use Queues?\n\n### Without Queue (Tight Coupling)\n```\nWeb Server → Database\nProblem: If database is slow/down, web server waits/fails\n```\n\n### With Queue (Loose Coupling)\n```\nWeb Server → SQS Queue → Worker Processes → Database\nBenefits:\n- Web server responds immediately\n- Workers process at their own pace\n- System survives component failures\n```\n\n## SQS Queue Types\n\n### Standard Queue\n\n**Characteristics**:\n- Unlimited throughput\n- At-least-once delivery (messages may be delivered more than once)\n- Best-effort ordering (messages may arrive out of order)\n\n**Use Cases**:\n- High throughput needed\n- Duplicate messages are acceptable\n- Order doesn't matter\n\n### FIFO Queue\n\n**Characteristics**:\n- First-In-First-Out ordering (guaranteed)\n- Exactly-once processing (no duplicates)\n- Limited to 300 messages/second (3,000 with batching)\n\n**Use Cases**:\n- Order matters\n- No duplicates allowed\n- Financial transactions\n\n**Practice**: Try the SQS lab!"
  lesson.key_concepts = ['SQS', 'message queues', 'standard queue', 'FIFO queue', 'visibility timeout', 'long polling', 'dead letter queue']
end

lesson7_2 = CourseLesson.find_or_create_by!(title: "SNS and EventBridge") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = "# SNS and EventBridge\n\nPublish-subscribe messaging and event-driven architectures.\n\n## SNS: Simple Notification Service\n\n**Pub/Sub Messaging Service** for:\n- Sending messages to many subscribers\n- Push notifications (email, SMS, mobile)\n- Application-to-application messaging\n\n### SNS Fan-Out Pattern\n\n**Send one message to many destinations**:\n\n```\nProducer publishes to SNS Topic\n├── Subscription 1 → SQS Queue → Analytics Service\n├── Subscription 2 → Lambda → Email Alerts\n├── Subscription 3 → HTTP Endpoint → Dashboard\n└── Subscription 4 → SQS Queue → Archive Service\n```\n\n## Amazon EventBridge\n\n**Serverless event bus** for application integration.\n\n**Event-driven architecture platform**:\n- Receives events from various sources\n- Routes events based on rules\n- Targets multiple services\n\n**Practice**: Try the messaging lab!"
  lesson.key_concepts = ['SNS', 'pub/sub', 'EventBridge', 'event-driven architecture', 'fan-out pattern', 'message filtering']
end

# Quiz 7.1: Messaging & Integration
quiz7_1 = Quiz.find_or_create_by!(title: "Messaging & Integration Quiz") do |quiz|
  quiz.description = 'Test your knowledge of SQS, SNS, and EventBridge'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
end

[
  {
    question_text: "What is the main difference between SQS Standard and FIFO queues?",
    question_type: "mcq",
    points: 5,
    options: ["Standard: unlimited throughput, at-least-once delivery; FIFO: ordered, exactly-once, limited throughput", "They are the same", "FIFO is faster", "Standard guarantees order"],
    correct_answer: "Standard: unlimited throughput, at-least-once delivery; FIFO: ordered, exactly-once, limited throughput",
    explanation: "Standard queues offer unlimited throughput with at-least-once delivery and best-effort ordering. FIFO queues guarantee first-in-first-out order and exactly-once processing, but are limited to 300 messages/second (3,000 with batching)."
  },
  {
    question_text: "What is the SNS fan-out pattern?",
    question_type: "mcq",
    points: 5,
    options: ["One message published to SNS topic distributed to multiple SQS queues/subscribers", "Multiple senders to one queue", "Load balancing", "Caching pattern"],
    correct_answer: "One message published to SNS topic distributed to multiple SQS queues/subscribers",
    explanation: "Fan-out pattern uses SNS to publish one message to a topic, which then delivers copies to multiple SQS queues or other subscribers. This enables parallel, asynchronous processing by multiple services."
  },
  {
    question_text: "What is Amazon EventBridge?",
    question_type: "mcq",
    points: 5,
    options: ["Serverless event bus for routing events from AWS services, SaaS, and custom apps", "Message queue", "Database service", "Load balancer"],
    correct_answer: "Serverless event bus for routing events from AWS services, SaaS, and custom apps",
    explanation: "EventBridge is a serverless event bus that receives events from AWS services, SaaS applications, and custom applications, then routes them to targets based on rules. It's the evolution of CloudWatch Events with enhanced capabilities."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz7_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 8: Architecture Best Practices
# ==========================================

module8 = CourseModule.find_or_create_by!(slug: 'architecture-best-practices', course: aws_course) do |mod|
  mod.title = "Architecture Best Practices - High Availability & Performance"
  mod.description = "Design resilient, scalable, and high-performance AWS architectures"
  mod.sequence_order = 8
  mod.estimated_minutes = 220
  mod.published = true
end

lesson8_1 = CourseLesson.find_or_create_by!(title: "Designing Highly Available Architectures") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = "# Designing Highly Available Architectures\n\nBuild systems that remain operational despite failures.\n\n## High Availability Fundamentals\n\n### What is High Availability?\n\n**Definition**: System continues operating despite component failures.\n\n**Measured by \"nines\"**:\n```\n99%      = 3.65 days downtime/year\n99.9%    = 8.76 hours downtime/year (three nines)\n99.95%   = 4.38 hours downtime/year (RDS Multi-AZ SLA)\n99.99%   = 52.56 minutes downtime/year (four nines)\n99.999%  = 5.26 minutes downtime/year (five nines)\n```\n\n## Multi-AZ Design Patterns\n\n**Multi-AZ Web Application**:\n```\nRoute 53 (DNS)\n↓\nCloudFront (Global CDN)\n↓\nApplication Load Balancer (in 3 AZs)\n├── AZ us-east-1a: EC2 Web Servers (Auto Scaling)\n├── AZ us-east-1b: EC2 Web Servers (Auto Scaling)\n└── AZ us-east-1c: EC2 Web Servers (Auto Scaling)\n        ↓\nRDS Multi-AZ (Primary + Standby)\n```\n\n## Load Balancing Strategies\n\n### Application Load Balancer (ALB)\n\n**Features**:\n- Path-based routing: `/api` → API servers, `/web` → Web servers\n- Host-based routing\n- HTTP/2 and WebSocket support\n- Health checks with configurable thresholds\n\n**Practice**: Design a highly available architecture!"
  lesson.key_concepts = ['high availability', 'Multi-AZ', 'load balancing', 'Auto Scaling', 'failover', 'RTO', 'RPO', 'disaster recovery']
end

lesson8_2 = CourseLesson.find_or_create_by!(title: "Designing High Performance Architectures") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = "# Designing High Performance Architectures\n\nOptimize for speed, scalability, and cost-efficiency.\n\n## Performance Optimization Principles\n\n### 1. Compute Optimization\n\n**Choose the right instance type**:\n\n| Workload | Instance Type | Why |\n|----------|--------------|-----|\n| Web server | T3/T4g (burstable) | Variable load, cost-effective |\n| API backend | C6g (compute optimized) | Consistent high CPU |\n| In-memory cache | R6g (memory optimized) | Large RAM needs |\n| ML inference | G4 (GPU) | Specialized acceleration |\n\n### 2. Caching Strategies\n\n**Multi-Layer Caching**:\n```\n1. CloudFront (Edge Cache) → 5-50ms\n2. ElastiCache (Application Cache) → 1-5ms\n3. Database Read Replica → 10-50ms\n4. Primary Database → 50-200ms\n```\n\n### 3. Scalability Patterns\n\n**Horizontal Scaling**:\n```\nLoad Balancer\n├── App Server 1  ┐\n├── App Server 2  │ All identical\n├── App Server 3  │ No local state\n└── App Server 4  ┘\n\nState stored in:\n- ElastiCache (session data)\n- RDS (persistent data)\n- S3 (file uploads)\n```\n\n**Practice**: Optimize a sample architecture!"
  lesson.key_concepts = ['performance optimization', 'caching strategies', 'horizontal scaling', 'microservices', 'right-sizing', 'cost optimization']
end

# Quiz 8.1: Architecture Best Practices
quiz8_1 = Quiz.find_or_create_by!(title: "Architecture Best Practices Quiz") do |quiz|
  quiz.description = 'Test your knowledge of high availability and performance architecture'
  quiz.time_limit_minutes = 25
  quiz.passing_score = 70
end

[
  {
    question_text: "What does 99.99% availability mean in terms of downtime per year?",
    question_type: "mcq",
    points: 5,
    options: ["52.56 minutes", "8.76 hours", "3.65 days", "5.26 minutes"],
    correct_answer: "52.56 minutes",
    explanation: "99.99% (four nines) availability allows for approximately 52.56 minutes of downtime per year. This is a common SLA target for production systems."
  },
  {
    question_text: "What is the primary purpose of deploying applications across multiple Availability Zones?",
    question_type: "mcq",
    points: 5,
    options: ["Eliminate single points of failure and survive AZ outages", "Reduce costs", "Improve performance", "Simplify management"],
    correct_answer: "Eliminate single points of failure and survive AZ outages",
    explanation: "Multi-AZ deployment ensures your application continues running even if an entire Availability Zone fails due to power outage, natural disaster, or other issues. Each AZ has independent infrastructure."
  },
  {
    question_text: "What is horizontal scaling?",
    question_type: "mcq",
    points: 5,
    options: ["Adding more instances to handle load", "Increasing instance size", "Adding more storage", "Using faster CPUs"],
    correct_answer: "Adding more instances to handle load",
    explanation: "Horizontal scaling (scaling out) adds more instances of the same size to distribute load. Vertical scaling (scaling up) increases the size of existing instances. Horizontal scaling is generally preferred for cloud applications."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz8_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# LINK LESSONS AND QUIZZES TO MODULES
# ==========================================

puts "Linking lessons and quizzes to modules..."

# Module 1: AWS Fundamentals
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module1, item: quiz1_1, sequence_order: 3)

# Module 2: Compute Services
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module2, item: quiz2_1, sequence_order: 3)

# Module 3: Storage Services
ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module3, item: quiz3_1, sequence_order: 3)

# Module 4: Database Services
ModuleItem.find_or_create_by!(course_module: module4, item: lesson4_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module4, item: lesson4_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module4, item: quiz4_1, sequence_order: 3)

# Module 5: Advanced Networking
ModuleItem.find_or_create_by!(course_module: module5, item: lesson5_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module5, item: lesson5_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module5, item: quiz5_1, sequence_order: 3)

# Module 6: Monitoring & Management
ModuleItem.find_or_create_by!(course_module: module6, item: lesson6_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module6, item: lesson6_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module6, item: quiz6_1, sequence_order: 3)

# Module 7: Messaging & Integration
ModuleItem.find_or_create_by!(course_module: module7, item: lesson7_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module7, item: lesson7_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module7, item: quiz7_1, sequence_order: 3)

# Module 8: Architecture Best Practices
ModuleItem.find_or_create_by!(course_module: module8, item: lesson8_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module8, item: lesson8_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module8, item: quiz8_1, sequence_order: 3)

# ==========================================
# LINK AWS LABS
# ==========================================

puts "Linking AWS labs to modules..."

aws_labs = HandsOnLab.where(lab_type: 'aws').order(:sequence_order)

if aws_labs.any?
  aws_labs.each_with_index do |lab, index|
    mod = case index
          when 0..1 then module1
          when 2..3 then module2
          else module3
          end
    ModuleItem.find_or_create_by!(
      course_module: mod,
      item: lab,
      sequence_order: 20 + index
    )
  end
  puts "Linked #{aws_labs.count} AWS labs"
end

puts "\n✅ Complete AWS Cloud Architecture course created!"
puts "   - Course: #{aws_course.title}"
puts "   - Modules: #{aws_course.course_modules.count}"
puts "   - Lessons: #{CourseLesson.joins(course_module: :course).where(courses: { id: aws_course.id }).count}"
puts "   - Quizzes: #{Quiz.joins(course_module: :course).where(courses: { id: aws_course.id }).count}"
puts "   - Quiz Questions: #{QuizQuestion.joins(quiz: {course_module: :course}).where(courses: { id: aws_course.id }).count}"
puts "   - Labs: #{aws_labs.count}"
puts "\n📚 Content Coverage:"
puts "   ✅ Module 1: AWS Fundamentals & IAM (regions, AZs, users, roles, policies)"
puts "   ✅ Module 2: Compute Services (EC2, Lambda, Auto Scaling, Load Balancing)"
puts "   ✅ Module 3: Storage Services (S3, EBS, EFS)"
puts "   ✅ Module 4: Database Services (RDS, Aurora, DynamoDB)"
puts "   ✅ Module 5: Advanced Networking (VPC, Route 53, CloudFront)"
puts "   ✅ Module 6: Monitoring & Management (CloudWatch, CloudTrail, AWS Config)"
puts "   ✅ Module 7: Messaging & Integration (SQS, SNS, EventBridge)"
puts "   ✅ Module 8: Architecture Best Practices (High Availability & Performance)"
puts "\n🎯 Learning Features:"
puts "   ✅ 100+ quiz questions with detailed explanations"
puts "   ✅ 16 comprehensive lessons"
puts "   ✅ Hands-on LocalStack labs"
puts "   ✅ Real-world AWS scenarios & architecture patterns"
puts "   ✅ Complete Solutions Architect certification prep"
puts "\n🚀 COMPLETE AWS course - Production-ready architecture skills!"
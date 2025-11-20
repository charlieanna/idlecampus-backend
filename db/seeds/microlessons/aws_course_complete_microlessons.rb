# AUTO-GENERATED from aws_course_complete.rb
puts "Creating Microlessons for Aws Fundamentals..."

module_var = CourseModule.find_by(slug: 'aws-fundamentals')

# === MICROLESSON 1: Practice Question ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 13: Practice Question ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 14: Practice Question ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 15: Practice Question ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 16: Practice Question ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 17: Practice Question ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 18: Lesson 18 ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 18',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 18 microlessons for Aws Fundamentals"

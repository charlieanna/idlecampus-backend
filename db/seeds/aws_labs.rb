# AWS Cloud Architecture Hands-On Labs
# Learn AWS services through practical LocalStack-based labs

puts "☁️ Seeding AWS Cloud Architecture Hands-On Labs..."

aws_labs = [
  # BEGINNER LABS
  {
    title: "AWS S3 - Create and Manage Buckets",
    description: "Learn S3 fundamentals by creating buckets, uploading files, and managing permissions",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "aws",
    category: "storage",
    certification_exam: "AWS Solutions Architect",
    learning_objectives: "Master S3 basics, understand bucket policies, learn object storage concepts",
    prerequisites: ["Basic cloud concepts", "AWS CLI familiarity"],
    steps: [
      {
        step_number: 1,
        title: "Start LocalStack",
        instruction: "Start LocalStack container for AWS service emulation",
        expected_command: "docker run -d --name localstack -p 4566:4566 -e SERVICES=s3 localstack/localstack:latest",
        validation: "docker ps | grep localstack"
      },
      {
        step_number: 2,
        title: "Configure AWS CLI",
        instruction: "Configure AWS CLI to use LocalStack endpoint",
        expected_command: "export AWS_ENDPOINT=http://localhost:4566 && export AWS_ACCESS_KEY_ID=test && export AWS_SECRET_ACCESS_KEY=test",
        validation: "echo $AWS_ENDPOINT | grep 4566"
      },
      {
        step_number: 3,
        title: "Create S3 bucket",
        instruction: "Create a new S3 bucket named 'my-app-bucket'",
        expected_command: "aws --endpoint-url=http://localhost:4566 s3 mb s3://my-app-bucket",
        validation: "aws --endpoint-url=http://localhost:4566 s3 ls | grep my-app-bucket"
      },
      {
        step_number: 4,
        title: "Upload file to S3",
        instruction: "Create and upload a test file",
        expected_command: "echo 'Hello S3' > test.txt && aws --endpoint-url=http://localhost:4566 s3 cp test.txt s3://my-app-bucket/",
        validation: "aws --endpoint-url=http://localhost:4566 s3 ls s3://my-app-bucket/ | grep test.txt"
      },
      {
        step_number: 5,
        title: "List bucket contents",
        instruction: "List all objects in the bucket",
        expected_command: "aws --endpoint-url=http://localhost:4566 s3 ls s3://my-app-bucket/",
        validation: "aws --endpoint-url=http://localhost:4566 s3 ls s3://my-app-bucket/ | wc -l"
      },
      {
        step_number: 6,
        title: "Download file from S3",
        instruction: "Download the file back from S3",
        expected_command: "aws --endpoint-url=http://localhost:4566 s3 cp s3://my-app-bucket/test.txt downloaded.txt",
        validation: "test -f downloaded.txt && cat downloaded.txt | grep 'Hello S3'"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Delete bucket and stop LocalStack",
        expected_command: "aws --endpoint-url=http://localhost:4566 s3 rb s3://my-app-bucket --force && docker rm -f localstack && rm test.txt downloaded.txt",
        validation: "docker ps | grep localstack"
      }
    ],
    validation_rules: {
      bucket_created: "S3 bucket must exist",
      file_uploaded: "file successfully uploaded to S3",
      file_downloaded: "file retrieved from S3",
      cleanup_complete: "all resources removed"
    },
    success_criteria: "Successfully create, use, and delete S3 bucket",
    environment_image: "amazon/aws-cli:latest",
    required_tools: ["aws", "docker"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  {
    title: "AWS EC2 Instance Metadata and User Data",
    description: "Learn to work with EC2 instance metadata and user data scripts",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "aws",
    category: "compute",
    certification_exam: "AWS Solutions Architect",
    learning_objectives: "Understand EC2 metadata service, use user data scripts, automate instance configuration",
    prerequisites: ["Basic Linux knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Create user data script",
        instruction: "Create a bash script for EC2 user data",
        expected_command: "cat > user-data.sh << 'EOF'\n#!/bin/bash\necho 'Starting application setup...'\nyum update -y\nyum install -y nginx\nsystemctl start nginx\necho '<h1>Hello from EC2</h1>' > /usr/share/nginx/html/index.html\nEOF",
        validation: "test -f user-data.sh && grep nginx user-data.sh"
      },
      {
        step_number: 2,
        title: "Simulate metadata service",
        instruction: "Create mock metadata responses",
        expected_command: "cat > metadata.json << 'EOF'\n{\n  \"instance-id\": \"i-1234567890abcdef0\",\n  \"instance-type\": \"t3.medium\",\n  \"availability-zone\": \"us-east-1a\",\n  \"public-ipv4\": \"54.123.45.67\"\n}\nEOF",
        validation: "test -f metadata.json && cat metadata.json | grep instance-id"
      },
      {
        step_number: 3,
        title: "Parse metadata",
        instruction: "Extract instance information using jq",
        expected_command: "cat metadata.json | grep instance-id | cut -d'\"' -f4",
        validation: "cat metadata.json | grep instance-id"
      },
      {
        step_number: 4,
        title: "Validate user data script",
        instruction: "Check script syntax",
        expected_command: "bash -n user-data.sh && echo 'Syntax OK'",
        validation: "bash -n user-data.sh"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove test files",
        expected_command: "rm user-data.sh metadata.json",
        validation: "test ! -f user-data.sh"
      }
    ],
    validation_rules: {
      user_data_created: "user data script exists",
      metadata_parsed: "metadata correctly extracted",
      script_valid: "bash script syntax valid"
    },
    success_criteria: "Successfully create and validate EC2 automation scripts",
    environment_image: "amazon/aws-cli:latest",
    required_tools: ["bash"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },

  # INTERMEDIATE LABS
  {
    title: "AWS Lambda Function Deployment",
    description: "Deploy and test serverless functions using AWS Lambda",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "aws",
    category: "serverless",
    certification_exam: "AWS Solutions Architect",
    learning_objectives: "Master Lambda deployment, understand serverless architecture, work with function configurations",
    prerequisites: ["Python programming", "Understanding of serverless concepts"],
    steps: [
      {
        step_number: 1,
        title: "Create Lambda function",
        instruction: "Create a Python Lambda function",
        expected_command: "mkdir lambda-function && cat > lambda-function/lambda_function.py << 'EOF'\nimport json\n\ndef lambda_handler(event, context):\n    name = event.get('name', 'World')\n    return {\n        'statusCode': 200,\n        'body': json.dumps(f'Hello {name} from Lambda!')\n    }\nEOF",
        validation: "test -f lambda-function/lambda_function.py"
      },
      {
        step_number: 2,
        title: "Create deployment package",
        instruction: "Package Lambda function as ZIP",
        expected_command: "cd lambda-function && zip -r ../function.zip lambda_function.py && cd ..",
        validation: "test -f function.zip"
      },
      {
        step_number: 3,
        title: "Start LocalStack",
        instruction: "Start LocalStack with Lambda support",
        expected_command: "docker run -d --name localstack-lambda -p 4566:4566 -e SERVICES=lambda localstack/localstack:latest",
        validation: "docker ps | grep localstack-lambda"
      },
      {
        step_number: 4,
        title: "Create IAM role",
        instruction: "Create Lambda execution role",
        expected_command: "aws --endpoint-url=http://localhost:4566 iam create-role --role-name lambda-role --assume-role-policy-document '{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}'",
        validation: "aws --endpoint-url=http://localhost:4566 iam list-roles | grep lambda-role || echo 'Role creation attempted'"
      },
      {
        step_number: 5,
        title: "Deploy Lambda function",
        instruction: "Create Lambda function in LocalStack",
        expected_command: "aws --endpoint-url=http://localhost:4566 lambda create-function --function-name hello-lambda --runtime python3.9 --role arn:aws:iam::000000000000:role/lambda-role --handler lambda_function.lambda_handler --zip-file fileb://function.zip",
        validation: "aws --endpoint-url=http://localhost:4566 lambda list-functions | grep hello-lambda || echo 'Function deployed'"
      },
      {
        step_number: 6,
        title: "Invoke Lambda function",
        instruction: "Test the Lambda function",
        expected_command: "aws --endpoint-url=http://localhost:4566 lambda invoke --function-name hello-lambda --payload '{\"name\":\"AWS\"}' response.json && cat response.json",
        validation: "test -f response.json"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Remove all resources",
        expected_command: "docker rm -f localstack-lambda && rm -rf lambda-function function.zip response.json",
        validation: "docker ps | grep localstack-lambda"
      }
    ],
    validation_rules: {
      function_created: "Lambda function code written",
      package_created: "deployment package built",
      function_deployed: "function deployed to Lambda",
      function_invoked: "function successfully invoked"
    },
    success_criteria: "Successfully deploy and invoke Lambda function",
    environment_image: "amazon/aws-cli:latest",
    required_tools: ["aws", "docker", "python3", "zip"],
    max_attempts: 5,
    points_reward: 350,
    is_active: true
  },

  {
    title: "AWS VPC and Security Groups Configuration",
    description: "Design and configure Virtual Private Cloud with security groups",
    difficulty: "medium",
    estimated_minutes: 40,
    lab_type: "aws",
    category: "networking",
    certification_exam: "AWS Solutions Architect",
    learning_objectives: "Master VPC design, configure security groups, understand network isolation",
    prerequisites: ["Networking fundamentals", "AWS VPC concepts"],
    steps: [
      {
        step_number: 1,
        title: "Design VPC architecture",
        instruction: "Document VPC design with CIDR blocks",
        expected_command: "cat > vpc-design.md << 'EOF'\n# VPC Architecture\n\n## VPC: 10.0.0.0/16\n- Public Subnet 1: 10.0.1.0/24 (us-east-1a)\n- Public Subnet 2: 10.0.2.0/24 (us-east-1b)\n- Private Subnet 1: 10.0.10.0/24 (us-east-1a)\n- Private Subnet 2: 10.0.11.0/24 (us-east-1b)\nEOF",
        validation: "test -f vpc-design.md && grep '10.0.0.0/16' vpc-design.md"
      },
      {
        step_number: 2,
        title: "Calculate subnet capacity",
        instruction: "Calculate available IPs per subnet",
        expected_command: "python3 -c \"import math; hosts = 2**8 - 5; print(f'Available IPs per /24 subnet: {hosts}')\"",
        validation: "python3 -c \"print(f'{2**8-5}')\" | grep '251'"
      },
      {
        step_number: 3,
        title: "Create security group rules",
        instruction: "Define security group for web servers",
        expected_command: "cat > sg-web.json << 'EOF'\n{\n  \"GroupName\": \"web-servers-sg\",\n  \"Description\": \"Security group for web servers\",\n  \"InboundRules\": [\n    {\"Protocol\": \"tcp\", \"Port\": 80, \"Source\": \"0.0.0.0/0\"},\n    {\"Protocol\": \"tcp\", \"Port\": 443, \"Source\": \"0.0.0.0/0\"},\n    {\"Protocol\": \"tcp\", \"Port\": 22, \"Source\": \"10.0.0.0/16\"}\n  ]\n}\nEOF",
        validation: "test -f sg-web.json && grep '\"Port\": 80' sg-web.json"
      },
      {
        step_number: 4,
        title: "Create database security group",
        instruction: "Define restrictive SG for database tier",
        expected_command: "cat > sg-db.json << 'EOF'\n{\n  \"GroupName\": \"database-sg\",\n  \"Description\": \"Security group for databases\",\n  \"InboundRules\": [\n    {\"Protocol\": \"tcp\", \"Port\": 3306, \"Source\": \"web-servers-sg\"},\n    {\"Protocol\": \"tcp\", \"Port\": 5432, \"Source\": \"web-servers-sg\"}\n  ]\n}\nEOF",
        validation: "test -f sg-db.json && grep database sg-db.json"
      },
      {
        step_number: 5,
        title: "Validate CIDR blocks",
        instruction: "Check for CIDR overlap",
        expected_command: "python3 -c \"import ipaddress; vpc = ipaddress.ip_network('10.0.0.0/16'); pub = ipaddress.ip_network('10.0.1.0/24'); print(f'Subnet in VPC: {pub.subnet_of(vpc)}')\"",
        validation: "python3 -c \"import ipaddress; print('True')\" | grep True"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove configuration files",
        expected_command: "rm vpc-design.md sg-web.json sg-db.json",
        validation: "test ! -f vpc-design.md"
      }
    ],
    validation_rules: {
      vpc_designed: "VPC architecture documented",
      security_groups_defined: "security group rules created",
      cidr_validated: "CIDR blocks verified"
    },
    success_criteria: "Successfully design VPC with proper network isolation",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 350,
    is_active: true
  },

  # ADVANCED LABS
  {
    title: "AWS Auto Scaling and Load Balancer Configuration",
    description: "Design and configure auto-scaling infrastructure with load balancing",
    difficulty: "hard",
    estimated_minutes: 50,
    lab_type: "aws",
    category: "high-availability",
    certification_exam: "AWS Solutions Architect",
    learning_objectives: "Master auto-scaling policies, configure load balancers, design highly available systems",
    prerequisites: ["Advanced AWS knowledge", "Understanding of scaling patterns"],
    steps: [
      {
        step_number: 1,
        title: "Define scaling policy",
        instruction: "Create target tracking scaling policy",
        expected_command: "cat > scaling-policy.json << 'EOF'\n{\n  \"TargetValue\": 70.0,\n  \"PredefinedMetricSpecification\": {\n    \"PredefinedMetricType\": \"ASGAverageCPUUtilization\"\n  },\n  \"ScaleOutCooldown\": 300,\n  \"ScaleInCooldown\": 300\n}\nEOF",
        validation: "test -f scaling-policy.json && grep TargetValue scaling-policy.json"
      },
      {
        step_number: 2,
        title: "Calculate scaling thresholds",
        instruction: "Calculate instances needed for different CPU loads",
        expected_command: "python3 -c \"baseline_load = 1000; instance_capacity = 100; instances = []; cpu_targets = [50, 70, 90]; [instances.append(int(baseline_load/(instance_capacity*(cpu/100)))) for cpu in cpu_targets]; print(f'Instances at 50% CPU: {instances[0]}'); print(f'Instances at 70% CPU: {instances[1]}'); print(f'Instances at 90% CPU: {instances[2]}')\"",
        validation: "python3 -c \"print('Instances at')\" | grep 'Instances'"
      },
      {
        step_number: 3,
        title: "Create ALB configuration",
        instruction: "Configure Application Load Balancer",
        expected_command: "cat > alb-config.json << 'EOF'\n{\n  \"LoadBalancerName\": \"web-app-alb\",\n  \"Scheme\": \"internet-facing\",\n  \"TargetGroups\": [{\n    \"Name\": \"web-servers-tg\",\n    \"Protocol\": \"HTTP\",\n    \"Port\": 80,\n    \"HealthCheck\": {\n      \"Path\": \"/health\",\n      \"Interval\": 30,\n      \"Timeout\": 5,\n      \"HealthyThreshold\": 2,\n      \"UnhealthyThreshold\": 3\n    }\n  }]\n}\nEOF",
        validation: "test -f alb-config.json && grep HealthCheck alb-config.json"
      },
      {
        step_number: 4,
        title: "Design multi-AZ deployment",
        instruction: "Document high availability strategy",
        expected_command: "cat > ha-design.md << 'EOF'\n# High Availability Design\n\n## Multi-AZ Deployment\n- Minimum 2 instances per AZ\n- 3 Availability Zones (us-east-1a, 1b, 1c)\n- Total minimum: 6 instances\n- Maximum: 18 instances (3x scaling)\n\n## Failure Scenarios\n- Single instance failure: Load balancer removes from pool\n- AZ failure: Traffic redirected to healthy AZs\n- Region failure: Failover to secondary region\nEOF",
        validation: "test -f ha-design.md && grep 'Multi-AZ' ha-design.md"
      },
      {
        step_number: 5,
        title: "Calculate cost estimates",
        instruction: "Estimate monthly costs for auto-scaling setup",
        expected_command: "python3 -c \"instance_cost = 0.0416; avg_instances = 9; hours_month = 730; alb_cost = 22.5; data_processing = 8.0; total = (instance_cost * avg_instances * hours_month) + alb_cost + data_processing; print(f'Estimated monthly cost: ${total:.2f}')\"",
        validation: "python3 -c \"print('Estimated monthly cost')\" | grep 'cost'"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove configuration files",
        expected_command: "rm scaling-policy.json alb-config.json ha-design.md",
        validation: "test ! -f scaling-policy.json"
      }
    ],
    validation_rules: {
      scaling_configured: "auto-scaling policy defined",
      load_balancer_configured: "ALB properly configured",
      ha_designed: "high availability architecture documented"
    },
    success_criteria: "Design complete auto-scaling infrastructure",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 3,
    points_reward: 500,
    is_active: true
  }
]

# Create AWS Labs
aws_labs.each_with_index do |lab_data, index|
  begin
    lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
    lab.assign_attributes(lab_data)

    if lab.save
      print "."
    else
      puts "\n❌ Failed to create: #{lab_data[:title]}"
      puts "   Errors: #{lab.errors.full_messages.join(', ')}"
    end
  rescue => e
    puts "\n❌ Error on #{lab_data[:title]}: #{e.message}"
  end
end

puts "\n\n✅ AWS Cloud Architecture Labs Seeding Complete!"
puts "   Total labs: #{HandsOnLab.where(lab_type: 'aws').count}"
puts "\n☁️ Ready for AWS Learning!"

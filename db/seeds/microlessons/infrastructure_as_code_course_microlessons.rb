# AUTO-GENERATED from infrastructure_as_code_course.rb
puts "Creating Microlessons for Iac Fundamentals..."

module_var = CourseModule.find_by(slug: 'iac-fundamentals')

# === MICROLESSON 1: Infrastructure as Code with Terraform ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Infrastructure as Code with Terraform',
  content: <<~MARKDOWN,
# Infrastructure as Code with Terraform 🚀

# Infrastructure as Code with Terraform

    ## Why Infrastructure as Code?

    Infrastructure as Code (IaC) treats infrastructure the same way developers treat application code - version controlled, tested, and automated.

    ### Traditional Problems
    - **Manual provisioning**: Error-prone, slow, not repeatable
    - **Configuration drift**: Servers diverge from standards over time
    - **No audit trail**: Hard to track who changed what
    - **Scaling challenges**: Can't quickly replicate environments
    - **Documentation**: Often outdated or incomplete

    ### Benefits of IaC
    1. **Reproducibility**: Same code = same infrastructure every time
    2. **Version control**: Track every change, rollback if needed
    3. **Automation**: Deploy faster and more reliably
    4. **Documentation as code**: Infrastructure is self-documenting
    5. **Cost optimization**: Tear down and recreate environments easily
    6. **Testing**: Test infrastructure changes before production

    ## Terraform Overview

    Terraform is an open-source IaC tool by HashiCorp that provisions and manages infrastructure across cloud providers.

    ### Key Features
    - **Provider agnostic**: AWS, Azure, GCP, Kubernetes, and 1000+ providers
    - **Declarative**: Describe desired state, Terraform figures out how
    - **Plan before apply**: Preview changes before making them
    - **Resource graph**: Understands dependencies between resources
    - **State management**: Tracks actual infrastructure state

    ## The Terraform Workflow

    ### 1. Write Configuration
    ```hcl
    # main.tf
    terraform {
      required_version = ">= 1.0"
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
    }

    provider "aws" {
      region = var.aws_region
    }

    resource "aws_instance" "web" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"

      tags = {
        Name = "WebServer"
      }
    }
    ```

    ### 2. Initialize (`terraform init`)
    - Downloads provider plugins
    - Initializes backend for state storage
    - Prepares working directory

    ```bash
    terraform init
    ```

    ### 3. Plan (`terraform plan`)
    - Shows what will be created, modified, or destroyed
    - No actual changes made
    - Safety check before applying

    ```bash
    terraform plan
    ```

    Output shows:
    ```
    Terraform will perform the following actions:

      # aws_instance.web will be created
      + resource "aws_instance" "web" {
          + ami           = "ami-0c55b159cbfafe1f0"
          + instance_type = "t2.micro"
          ...
        }

    Plan: 1 to add, 0 to change, 0 to destroy.
    ```

    ### 4. Apply (`terraform apply`)
    - Creates/modifies infrastructure to match configuration
    - Updates state file
    - Shows execution plan and asks for confirmation

    ```bash
    terraform apply
    ```

    ### 5. Destroy (when needed)
    ```bash
    terraform destroy
    ```

    ## Understanding Providers

    Providers are plugins that interact with APIs of cloud platforms and services.

    ### AWS Provider
    ```hcl
    provider "aws" {
      region     = "us-west-2"
      access_key = var.aws_access_key
      secret_key = var.aws_secret_key
    }
    ```

    ### Azure Provider
    ```hcl
    provider "azurerm" {
      features {}
      subscription_id = var.subscription_id
    }
    ```

    ### GCP Provider
    ```hcl
    provider "google" {
      project = "my-project-id"
      region  = "us-central1"
    }
    ```

    ### Multiple Provider Instances
    ```hcl
    provider "aws" {
      alias  = "west"
      region = "us-west-2"
    }

    provider "aws" {
      alias  = "east"
      region = "us-east-1"
    }

    resource "aws_instance" "west_server" {
      provider = aws.west
      ami      = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
    }
    ```

    ## Resources vs Data Sources

    ### Resources
    Resources create, modify, and delete infrastructure objects.

    ```hcl
    resource "aws_s3_bucket" "assets" {
      bucket = "my-app-assets"

      tags = {
        Environment = "Production"
      }
    }

    resource "aws_s3_bucket_versioning" "assets_versioning" {
      bucket = aws_s3_bucket.assets.id

      versioning_configuration {
        status = "Enabled"
      }
    }
    ```

    ### Data Sources
    Data sources fetch information about existing resources (read-only).

    ```hcl
    # Get latest Amazon Linux 2 AMI
    data "aws_ami" "amazon_linux" {
      most_recent = true
      owners      = ["amazon"]

      filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }
    }

    # Use data source in resource
    resource "aws_instance" "web" {
      ami           = data.aws_ami.amazon_linux.id
      instance_type = "t2.micro"
    }

    # Get existing VPC
    data "aws_vpc" "default" {
      default = true
    }

    # Get availability zones
    data "aws_availability_zones" "available" {
      state = "available"
    }
    ```

    ## Variables and Outputs

    ### Variables (Inputs)
    ```hcl
    # variables.tf
    variable "aws_region" {
      description = "AWS region for resources"
      type        = string
      default     = "us-west-2"
    }

    variable "instance_type" {
      description = "EC2 instance type"
      type        = string
      default     = "t2.micro"
    }

    variable "environment" {
      description = "Environment name"
      type        = string
      validation {
        condition     = contains(["dev", "staging", "prod"], var.environment)
        error_message = "Environment must be dev, staging, or prod."
      }
    }

    variable "tags" {
      description = "Common tags for all resources"
      type        = map(string)
      default     = {}
    }
    ```

    ### Using Variables
    ```hcl
    resource "aws_instance" "web" {
      ami           = data.aws_ami.amazon_linux.id
      instance_type = var.instance_type

      tags = merge(var.tags, {
        Name = "web-${var.environment}"
      })
    }
    ```

    ### Variable Files
    ```hcl
    # terraform.tfvars
    aws_region    = "us-east-1"
    instance_type = "t2.small"
    environment   = "production"

    tags = {
      Project = "MyApp"
      Team    = "Platform"
    }
    ```

    ```hcl
    # dev.tfvars
    environment   = "dev"
    instance_type = "t2.micro"
    ```

    Apply with specific file:
    ```bash
    terraform apply -var-file="dev.tfvars"
    ```

    ### Outputs
    ```hcl
    # outputs.tf
    output "instance_id" {
      description = "ID of the EC2 instance"
      value       = aws_instance.web.id
    }

    output "instance_public_ip" {
      description = "Public IP of the instance"
      value       = aws_instance.web.public_ip
    }

    output "vpc_id" {
      description = "VPC ID"
      value       = aws_vpc.main.id
    }

    output "db_connection_string" {
      description = "Database connection string"
      value       = "postgresql://${aws_db_instance.main.endpoint}/${aws_db_instance.main.db_name}"
      sensitive   = true
    }
    ```

    View outputs:
    ```bash
    terraform output
    terraform output instance_public_ip
    terraform output -json  # JSON format
    ```

    ## Complete AWS Infrastructure Example

    This example creates a complete AWS infrastructure with VPC, subnets, security groups, EC2 instance, and RDS database.

    ### Project Structure
    ```
    infrastructure/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── terraform.tfvars
    └── modules/
    ```

    ### main.tf
    ```hcl
    terraform {
      required_version = ">= 1.0"
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
    }

    provider "aws" {
      region = var.aws_region
    }

    # VPC
    resource "aws_vpc" "main" {
      cidr_block           = var.vpc_cidr
      enable_dns_hostnames = true
      enable_dns_support   = true

      tags = {
        Name        = "${var.project_name}-vpc"
        Environment = var.environment
      }
    }

    # Internet Gateway
    resource "aws_internet_gateway" "main" {
      vpc_id = aws_vpc.main.id

      tags = {
        Name = "${var.project_name}-igw"
      }
    }

    # Public Subnets
    resource "aws_subnet" "public" {
      count                   = length(var.availability_zones)
      vpc_id                  = aws_vpc.main.id
      cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
      availability_zone       = var.availability_zones[count.index]
      map_public_ip_on_launch = true

      tags = {
        Name = "${var.project_name}-public-${count.index + 1}"
        Type = "Public"
      }
    }

    # Private Subnets
    resource "aws_subnet" "private" {
      count             = length(var.availability_zones)
      vpc_id            = aws_vpc.main.id
      cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 100)
      availability_zone = var.availability_zones[count.index]

      tags = {
        Name = "${var.project_name}-private-${count.index + 1}"
        Type = "Private"
      }
    }

    # Public Route Table
    resource "aws_route_table" "public" {
      vpc_id = aws_vpc.main.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
      }

      tags = {
        Name = "${var.project_name}-public-rt"
      }
    }

    # Associate Public Subnets with Public Route Table
    resource "aws_route_table_association" "public" {
      count          = length(aws_subnet.public)
      subnet_id      = aws_subnet.public[count.index].id
      route_table_id = aws_route_table.public.id
    }

    # Security Group for Web Server
    resource "aws_security_group" "web" {
      name        = "${var.project_name}-web-sg"
      description = "Security group for web servers"
      vpc_id      = aws_vpc.main.id

      ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      ingress {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.admin_cidr]
      }

      egress {
        description = "Allow all outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }

      tags = {
        Name = "${var.project_name}-web-sg"
      }
    }

    # Security Group for RDS
    resource "aws_security_group" "db" {
      name        = "${var.project_name}-db-sg"
      description = "Security group for RDS database"
      vpc_id      = aws_vpc.main.id

      ingress {
        description     = "PostgreSQL from web servers"
        from_port       = 5432
        to_port         = 5432
        protocol        = "tcp"
        security_groups = [aws_security_group.web.id]
      }

      egress {
        description = "Allow all outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }

      tags = {
        Name = "${var.project_name}-db-sg"
      }
    }

    # Get Latest Amazon Linux 2 AMI
    data "aws_ami" "amazon_linux" {
      most_recent = true
      owners      = ["amazon"]

      filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }

      filter {
        name   = "virtualization-type"
        values = ["hvm"]
      }
    }

    # EC2 Instance
    resource "aws_instance" "web" {
      ami                    = data.aws_ami.amazon_linux.id
      instance_type          = var.instance_type
      subnet_id              = aws_subnet.public[0].id
      vpc_security_group_ids = [aws_security_group.web.id]
      key_name               = var.key_name

      user_data = <<-EOF
                  #!/bin/bash
                  yum update -y
                  yum install -y httpd
                  systemctl start httpd
                  systemctl enable httpd
                  echo "<h1>Hello from Terraform!</h1>" > /var/www/html/index.html
                  EOF

      root_block_device {
        volume_size = 20
        volume_type = "gp3"
        encrypted   = true
      }

      tags = {
        Name        = "${var.project_name}-web-server"
        Environment = var.environment
      }
    }

    # DB Subnet Group
    resource "aws_db_subnet_group" "main" {
      name       = "${var.project_name}-db-subnet-group"
      subnet_ids = aws_subnet.private[*].id

      tags = {
        Name = "${var.project_name}-db-subnet-group"
      }
    }

    # RDS Instance
    resource "aws_db_instance" "main" {
      identifier             = "${var.project_name}-db"
      engine                 = "postgres"
      engine_version         = "15.3"
      instance_class         = var.db_instance_class
      allocated_storage      = 20
      storage_type           = "gp3"
      storage_encrypted      = true

      db_name  = var.db_name
      username = var.db_username
      password = var.db_password

      db_subnet_group_name   = aws_db_subnet_group.main.name
      vpc_security_group_ids = [aws_security_group.db.id]

      backup_retention_period = 7
      backup_window          = "03:00-04:00"
      maintenance_window     = "mon:04:00-mon:05:00"

      skip_final_snapshot = var.environment != "production"
      final_snapshot_identifier = var.environment == "production" ? "${var.project_name}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}" : null

      tags = {
        Name        = "${var.project_name}-database"
        Environment = var.environment
      }
    }
    ```

    ### variables.tf
    ```hcl
    variable "aws_region" {
      description = "AWS region"
      type        = string
      default     = "us-west-2"
    }

    variable "project_name" {
      description = "Project name for resource naming"
      type        = string
    }

    variable "environment" {
      description = "Environment (dev, staging, prod)"
      type        = string
    }

    variable "vpc_cidr" {
      description = "CIDR block for VPC"
      type        = string
      default     = "10.0.0.0/16"
    }

    variable "availability_zones" {
      description = "List of availability zones"
      type        = list(string)
      default     = ["us-west-2a", "us-west-2b"]
    }

    variable "instance_type" {
      description = "EC2 instance type"
      type        = string
      default     = "t3.micro"
    }

    variable "key_name" {
      description = "SSH key pair name"
      type        = string
    }

    variable "admin_cidr" {
      description = "CIDR block for admin SSH access"
      type        = string
    }

    variable "db_instance_class" {
      description = "RDS instance class"
      type        = string
      default     = "db.t3.micro"
    }

    variable "db_name" {
      description = "Database name"
      type        = string
    }

    variable "db_username" {
      description = "Database admin username"
      type        = string
      sensitive   = true
    }

    variable "db_password" {
      description = "Database admin password"
      type        = string
      sensitive   = true
    }
    ```

    ### outputs.tf
    ```hcl
    output "vpc_id" {
      description = "VPC ID"
      value       = aws_vpc.main.id
    }

    output "public_subnet_ids" {
      description = "Public subnet IDs"
      value       = aws_subnet.public[*].id
    }

    output "private_subnet_ids" {
      description = "Private subnet IDs"
      value       = aws_subnet.private[*].id
    }

    output "web_instance_id" {
      description = "Web server instance ID"
      value       = aws_instance.web.id
    }

    output "web_public_ip" {
      description = "Web server public IP"
      value       = aws_instance.web.public_ip
    }

    output "web_url" {
      description = "Web server URL"
      value       = "http://${aws_instance.web.public_ip}"
    }

    output "db_endpoint" {
      description = "RDS endpoint"
      value       = aws_db_instance.main.endpoint
    }

    output "db_connection_string" {
      description = "Database connection string"
      value       = "postgresql://${var.db_username}@${aws_db_instance.main.endpoint}/${var.db_name}"
      sensitive   = true
    }
    ```

    ### terraform.tfvars
    ```hcl
    project_name = "myapp"
    environment  = "dev"
    aws_region   = "us-west-2"
    key_name     = "my-key-pair"
    admin_cidr   = "203.0.113.0/24"  # Replace with your IP

    db_name     = "myappdb"
    db_username = "dbadmin"
    db_password = "SuperSecret123!"  # Use AWS Secrets Manager in production
    ```

    ## Deployment Commands

    ```bash
    # Initialize Terraform
    terraform init

    # Validate configuration
    terraform validate

    # Format code
    terraform fmt

    # Preview changes
    terraform plan

    # Apply changes
    terraform apply

    # View outputs
    terraform output

    # Get specific output
    terraform output web_public_ip

    # Access the web server
    curl $(terraform output -raw web_public_ip)

    # Connect to database
    psql $(terraform output -raw db_connection_string)

    # Destroy everything
    terraform destroy
    ```

    ## Best Practices

    1. **Use version control**: Always commit Terraform code to Git
    2. **Never commit secrets**: Use variables, environment variables, or secret managers
    3. **Use remote state**: Store state in S3, Terraform Cloud, or other backends
    4. **Lock state**: Prevent concurrent modifications
    5. **Use workspaces or separate state**: Isolate environments
    6. **Tag resources**: Make tracking and cost allocation easier
    7. **Use data sources**: Reference existing resources instead of hardcoding
    8. **Enable encryption**: Encrypt volumes, databases, and state files
    9. **Plan before apply**: Always review changes
    10. **Automate with CI/CD**: Integrate Terraform into pipelines

    ## Summary

    Infrastructure as Code with Terraform enables:
    - Automated, reproducible infrastructure provisioning
    - Version-controlled infrastructure changes
    - Multi-cloud and provider-agnostic deployments
    - Predictable and testable infrastructure changes
    - Complete infrastructure lifecycle management

    The basic workflow is: write configuration → init → plan → apply → manage state.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Advanced Terraform Patterns ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Advanced Terraform Patterns',
  content: <<~MARKDOWN,
# Advanced Terraform Patterns 🚀

# Advanced Terraform Patterns

    ## Terraform Modules

    Modules are containers for multiple resources that are used together. They enable code reuse, organization, and abstraction.

    ### Why Use Modules?

    1. **Reusability**: Write once, use many times
    2. **Organization**: Group related resources
    3. **Abstraction**: Hide complexity
    4. **Consistency**: Standardize resource creation
    5. **Encapsulation**: Control what's configurable

    ### Module Structure

    ```
    modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
    ```

    ### Creating a VPC Module

    #### modules/vpc/main.tf
    ```hcl
    resource "aws_vpc" "main" {
      cidr_block           = var.cidr_block
      enable_dns_hostnames = var.enable_dns_hostnames
      enable_dns_support   = var.enable_dns_support

      tags = merge(
        var.tags,
        {
          Name = var.name
        }
      )
    }

    resource "aws_subnet" "public" {
      count                   = length(var.public_subnet_cidrs)
      vpc_id                  = aws_vpc.main.id
      cidr_block              = var.public_subnet_cidrs[count.index]
      availability_zone       = var.availability_zones[count.index]
      map_public_ip_on_launch = true

      tags = merge(
        var.tags,
        {
          Name = "${var.name}-public-${count.index + 1}"
          Type = "Public"
        }
      )
    }

    resource "aws_subnet" "private" {
      count             = length(var.private_subnet_cidrs)
      vpc_id            = aws_vpc.main.id
      cidr_block        = var.private_subnet_cidrs[count.index]
      availability_zone = var.availability_zones[count.index]

      tags = merge(
        var.tags,
        {
          Name = "${var.name}-private-${count.index + 1}"
          Type = "Private"
        }
      )
    }

    resource "aws_internet_gateway" "main" {
      vpc_id = aws_vpc.main.id

      tags = merge(
        var.tags,
        {
          Name = "${var.name}-igw"
        }
      )
    }

    resource "aws_route_table" "public" {
      vpc_id = aws_vpc.main.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
      }

      tags = merge(
        var.tags,
        {
          Name = "${var.name}-public-rt"
        }
      )
    }

    resource "aws_route_table_association" "public" {
      count          = length(aws_subnet.public)
      subnet_id      = aws_subnet.public[count.index].id
      route_table_id = aws_route_table.public.id
    }
    ```

    #### modules/vpc/variables.tf
    ```hcl
    variable "name" {
      description = "Name prefix for VPC resources"
      type        = string
    }

    variable "cidr_block" {
      description = "CIDR block for VPC"
      type        = string
      default     = "10.0.0.0/16"
    }

    variable "availability_zones" {
      description = "List of availability zones"
      type        = list(string)
    }

    variable "public_subnet_cidrs" {
      description = "CIDR blocks for public subnets"
      type        = list(string)
    }

    variable "private_subnet_cidrs" {
      description = "CIDR blocks for private subnets"
      type        = list(string)
    }

    variable "enable_dns_hostnames" {
      description = "Enable DNS hostnames in VPC"
      type        = bool
      default     = true
    }

    variable "enable_dns_support" {
      description = "Enable DNS support in VPC"
      type        = bool
      default     = true
    }

    variable "tags" {
      description = "Tags to apply to all resources"
      type        = map(string)
      default     = {}
    }
    ```

    #### modules/vpc/outputs.tf
    ```hcl
    output "vpc_id" {
      description = "ID of the VPC"
      value       = aws_vpc.main.id
    }

    output "vpc_cidr" {
      description = "CIDR block of the VPC"
      value       = aws_vpc.main.cidr_block
    }

    output "public_subnet_ids" {
      description = "IDs of public subnets"
      value       = aws_subnet.public[*].id
    }

    output "private_subnet_ids" {
      description = "IDs of private subnets"
      value       = aws_subnet.private[*].id
    }

    output "internet_gateway_id" {
      description = "ID of the Internet Gateway"
      value       = aws_internet_gateway.main.id
    }
    ```

    ### Using Modules

    #### Local Module
    ```hcl
    module "vpc" {
      source = "./modules/vpc"

      name               = "production"
      cidr_block         = "10.0.0.0/16"
      availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

      public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

      tags = {
        Environment = "production"
        Project     = "myapp"
      }
    }

    # Reference module outputs
    resource "aws_instance" "web" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t3.micro"
      subnet_id     = module.vpc.public_subnet_ids[0]

      tags = {
        Name = "web-server"
      }
    }
    ```

    #### Remote Module (Terraform Registry)
    ```hcl
    module "vpc" {
      source  = "terraform-aws-modules/vpc/aws"
      version = "5.0.0"

      name = "my-vpc"
      cidr = "10.0.0.0/16"

      azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
      private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

      enable_nat_gateway = true
      enable_vpn_gateway = false

      tags = {
        Environment = "dev"
      }
    }
    ```

    #### Module from Git
    ```hcl
    module "vpc" {
      source = "git::https://github.com/myorg/terraform-modules.git//vpc?ref=v1.2.0"

      name       = "staging"
      cidr_block = "10.1.0.0/16"
    }
    ```

    ### Module Composition

    Build complex infrastructure from smaller modules:

    ```hcl
    # Network layer
    module "vpc" {
      source = "./modules/vpc"
      name   = var.environment
    }

    # Security layer
    module "security_groups" {
      source = "./modules/security-groups"
      vpc_id = module.vpc.vpc_id
    }

    # Compute layer
    module "web_cluster" {
      source = "./modules/asg-web"

      vpc_id         = module.vpc.vpc_id
      subnet_ids     = module.vpc.public_subnet_ids
      security_group = module.security_groups.web_sg_id
    }

    # Data layer
    module "database" {
      source = "./modules/rds"

      vpc_id         = module.vpc.vpc_id
      subnet_ids     = module.vpc.private_subnet_ids
      security_group = module.security_groups.db_sg_id
    }
    ```

    ## State Management

    Terraform state is a critical component that tracks resource mappings and metadata.

    ### State File Contents
    ```json
    {
      "version": 4,
      "terraform_version": "1.5.0",
      "serial": 42,
      "lineage": "unique-id",
      "outputs": {},
      "resources": [
        {
          "mode": "managed",
          "type": "aws_instance",
          "name": "web",
          "instances": []
        }
      ]
    }
    ```

    ### Local State Problems

    - **No collaboration**: Can't share state with team
    - **No locking**: Risk of concurrent modifications
    - **No versioning**: Can't recover from mistakes
    - **Security**: Secrets stored in plain text

    ### Remote State Backends

    #### S3 Backend (Recommended for AWS)
    ```hcl
    terraform {
      backend "s3" {
        bucket         = "myapp-terraform-state"
        key            = "production/terraform.tfstate"
        region         = "us-west-2"
        encrypt        = true
        dynamodb_table = "terraform-state-lock"

        # Role-based access
        role_arn = "arn:aws:iam::123456789012:role/TerraformRole"
      }
    }
    ```

    Setup S3 backend:
    ```hcl
    # backend-setup/main.tf
    resource "aws_s3_bucket" "terraform_state" {
      bucket = "myapp-terraform-state"

      lifecycle {
        prevent_destroy = true
      }
    }

    resource "aws_s3_bucket_versioning" "terraform_state" {
      bucket = aws_s3_bucket.terraform_state.id

      versioning_configuration {
        status = "Enabled"
      }
    }

    resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
      bucket = aws_s3_bucket.terraform_state.id

      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }

    resource "aws_s3_bucket_public_access_block" "terraform_state" {
      bucket = aws_s3_bucket.terraform_state.id

      block_public_acls       = true
      block_public_policy     = true
      ignore_public_acls      = true
      restrict_public_buckets = true
    }

    resource "aws_dynamodb_table" "terraform_locks" {
      name         = "terraform-state-lock"
      billing_mode = "PAY_PER_REQUEST"
      hash_key     = "LockID"

      attribute {
        name = "LockID"
        type = "S"
      }
    }
    ```

    #### Azure Backend
    ```hcl
    terraform {
      backend "azurerm" {
        resource_group_name  = "terraform-state-rg"
        storage_account_name = "tfstatestore"
        container_name       = "tfstate"
        key                  = "prod.terraform.tfstate"
      }
    }
    ```

    #### Terraform Cloud Backend
    ```hcl
    terraform {
      cloud {
        organization = "myorg"

        workspaces {
          name = "production"
        }
      }
    }
    ```

    ### State Commands

    ```bash
    # List resources in state
    terraform state list

    # Show specific resource
    terraform state show aws_instance.web

    # Move resource (rename)
    terraform state mv aws_instance.old aws_instance.new

    # Remove resource from state (but keep in cloud)
    terraform state rm aws_instance.web

    # Import existing resource
    terraform import aws_instance.web i-1234567890abcdef0

    # Pull remote state to local file
    terraform state pull > terraform.tfstate.backup

    # Push local state to remote
    terraform state push terraform.tfstate

    # Replace provider in state (after provider changes)
    terraform state replace-provider hashicorp/aws registry.terraform.io/hashicorp/aws
    ```

    ### Importing Existing Infrastructure

    ```hcl
    # 1. Write configuration
    resource "aws_instance" "existing" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
    }

    # 2. Import existing resource
    terraform import aws_instance.existing i-1234567890abcdef0

    # 3. Align configuration with actual state
    terraform plan  # Shows differences
    terraform apply # Aligns if needed
    ```

    ## Workspaces

    Workspaces allow multiple state files for the same configuration - useful for environments.

    ### Workspace Commands
    ```bash
    # List workspaces (* indicates current)
    terraform workspace list

    # Create new workspace
    terraform workspace new development
    terraform workspace new staging
    terraform workspace new production

    # Switch workspace
    terraform workspace select production

    # Show current workspace
    terraform workspace show

    # Delete workspace (must be empty)
    terraform workspace delete development
    ```

    ### Using Workspaces in Configuration

    ```hcl
    locals {
      environment = terraform.workspace

      instance_types = {
        development = "t2.micro"
        staging     = "t3.small"
        production  = "t3.large"
      }

      instance_counts = {
        development = 1
        staging     = 2
        production  = 3
      }
    }

    resource "aws_instance" "web" {
      count         = local.instance_counts[local.environment]
      ami           = data.aws_ami.amazon_linux.id
      instance_type = local.instance_types[local.environment]

      tags = {
        Name        = "web-${local.environment}-${count.index + 1}"
        Environment = local.environment
      }
    }
    ```

    ### Workspace-Specific Backend Keys
    ```hcl
    terraform {
      backend "s3" {
        bucket = "myapp-terraform-state"
        key    = "env/${terraform.workspace}/terraform.tfstate"
        region = "us-west-2"
      }
    }
    ```

    This creates separate state files:
    - `env/development/terraform.tfstate`
    - `env/staging/terraform.tfstate`
    - `env/production/terraform.tfstate`

    ## Count and For_Each

    ### Count
    Create multiple similar resources with an index.

    ```hcl
    variable "availability_zones" {
      default = ["us-west-2a", "us-west-2b", "us-west-2c"]
    }

    resource "aws_subnet" "public" {
      count             = length(var.availability_zones)
      vpc_id            = aws_vpc.main.id
      cidr_block        = "10.0.${count.index + 1}.0/24"
      availability_zone = var.availability_zones[count.index]

      tags = {
        Name = "public-subnet-${count.index + 1}"
      }
    }

    # Reference: aws_subnet.public[0].id
    ```

    **Limitation**: Removing an item from the middle of a list causes Terraform to destroy and recreate resources.

    ### For_Each (Preferred)
    Create resources based on a map or set.

    ```hcl
    variable "subnets" {
      type = map(object({
        cidr_block        = string
        availability_zone = string
      }))

      default = {
        public-1 = {
          cidr_block        = "10.0.1.0/24"
          availability_zone = "us-west-2a"
        }
        public-2 = {
          cidr_block        = "10.0.2.0/24"
          availability_zone = "us-west-2b"
        }
        public-3 = {
          cidr_block        = "10.0.3.0/24"
          availability_zone = "us-west-2c"
        }
      }
    }

    resource "aws_subnet" "public" {
      for_each          = var.subnets
      vpc_id            = aws_vpc.main.id
      cidr_block        = each.value.cidr_block
      availability_zone = each.value.availability_zone

      tags = {
        Name = each.key
      }
    }

    # Reference: aws_subnet.public["public-1"].id
    ```

    ### For_Each with Sets
    ```hcl
    variable "users" {
      type    = set(string)
      default = ["alice", "bob", "charlie"]
    }

    resource "aws_iam_user" "developers" {
      for_each = var.users
      name     = each.value

      tags = {
        Role = "Developer"
      }
    }
    ```

    ### For_Each with Resources
    ```hcl
    locals {
      instances = {
        web = {
          instance_type = "t3.small"
          subnet        = "public"
        }
        api = {
          instance_type = "t3.medium"
          subnet        = "private"
        }
        worker = {
          instance_type = "t3.large"
          subnet        = "private"
        }
      }
    }

    resource "aws_instance" "app" {
      for_each      = local.instances
      ami           = data.aws_ami.amazon_linux.id
      instance_type = each.value.instance_type
      subnet_id     = each.value.subnet == "public" ? aws_subnet.public.id : aws_subnet.private.id

      tags = {
        Name = "${each.key}-server"
        Type = each.key
      }
    }
    ```

    ## Dynamic Blocks

    Generate nested blocks dynamically.

    ### Without Dynamic Blocks (Repetitive)
    ```hcl
    resource "aws_security_group" "web" {
      name   = "web-sg"
      vpc_id = aws_vpc.main.id

      ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["203.0.113.0/24"]
      }
    }
    ```

    ### With Dynamic Blocks (Clean)
    ```hcl
    variable "ingress_rules" {
      type = list(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
        description = string
      }))

      default = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "HTTP"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "HTTPS"
        },
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["203.0.113.0/24"]
          description = "SSH"
        }
      ]
    }

    resource "aws_security_group" "web" {
      name   = "web-sg"
      vpc_id = aws_vpc.main.id

      dynamic "ingress" {
        for_each = var.ingress_rules
        content {
          from_port   = ingress.value.from_port
          to_port     = ingress.value.to_port
          protocol    = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_blocks
          description = ingress.value.description
        }
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    ```

    ### Nested Dynamic Blocks
    ```hcl
    resource "aws_autoscaling_group" "web" {
      name                = "web-asg"
      max_size            = 5
      min_size            = 1
      vpc_zone_identifier = var.subnet_ids

      dynamic "tag" {
        for_each = var.tags
        content {
          key                 = tag.key
          value               = tag.value
          propagate_at_launch = true
        }
      }

      dynamic "initial_lifecycle_hook" {
        for_each = var.lifecycle_hooks
        content {
          name                 = initial_lifecycle_hook.value.name
          default_result       = initial_lifecycle_hook.value.default_result
          lifecycle_transition = initial_lifecycle_hook.value.transition

          dynamic "notification_metadata" {
            for_each = initial_lifecycle_hook.value.metadata != null ? [1] : []
            content {
              metadata = initial_lifecycle_hook.value.metadata
            }
          }
        }
      }
    }
    ```

    ## Terraform Cloud

    Terraform Cloud provides remote execution, state management, and collaboration features.

    ### Features
    - **Remote state management**: Encrypted, versioned state storage
    - **Remote operations**: Run plans and applies in the cloud
    - **Workspaces**: Separate environments with role-based access
    - **VCS integration**: Automatic runs on Git commits
    - **Policy as code**: Sentinel policies for governance
    - **Cost estimation**: Preview infrastructure costs
    - **Private registry**: Share internal modules
    - **Team collaboration**: Approval workflows

    ### Configuration
    ```hcl
    terraform {
      cloud {
        organization = "mycompany"

        workspaces {
          name = "production-app"
        }
      }
    }
    ```

    ### Login
    ```bash
    terraform login
    ```

    ### VCS-Driven Workflow

    1. Connect workspace to Git repository
    2. Push to main branch
    3. Terraform Cloud automatically runs plan
    4. Review and approve in UI
    5. Apply runs automatically

    ### API-Driven Workflow

    ```bash
    # Create configuration version
    curl \
      --header "Authorization: Bearer $TOKEN" \
      --header "Content-Type: application/vnd.api+json" \
      --request POST \
      --data @payload.json \
      https://app.terraform.io/api/v2/workspaces/$WORKSPACE_ID/configuration-versions
    ```

    ### Sentinel Policies

    Enforce governance and compliance.

    ```hcl
    # policy/restrict-instance-type.sentinel
    import "tfplan/v2" as tfplan

    allowed_types = ["t2.micro", "t2.small", "t3.micro", "t3.small"]

    main = rule {
      all tfplan.resource_changes as _, rc {
        rc.type is "aws_instance" implies
          rc.change.after.instance_type in allowed_types
      }
    }
    ```

    Apply policy set to workspace:
    ```hcl
    # Policy fails if:
    resource "aws_instance" "web" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "m5.xlarge"  # NOT in allowed list
    }
    ```

    ## Summary

    Advanced Terraform patterns enable:
    - **Modules**: Reusable, composable infrastructure components
    - **Remote state**: Secure, collaborative state management
    - **Workspaces**: Environment isolation with shared configuration
    - **For_each**: Flexible resource creation without index issues
    - **Dynamic blocks**: Generate repetitive nested blocks
    - **Terraform Cloud**: Enterprise-grade collaboration and governance

    These patterns are essential for managing infrastructure at scale.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Configuration Management ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Configuration Management',
  content: <<~MARKDOWN,
# Configuration Management 🚀

# Configuration Management with Ansible

    ## What is Configuration Management?

    Configuration management automates the setup, configuration, and maintenance of servers and applications.

    ### Problems with Manual Configuration
    - **Time-consuming**: Manual steps for each server
    - **Error-prone**: Human mistakes in complex setups
    - **Inconsistent**: Different configurations across servers
    - **Not repeatable**: Hard to replicate exact configurations
    - **No audit trail**: Can't track who changed what
    - **Scaling issues**: Managing 100s or 1000s of servers manually

    ### Benefits of Configuration Management
    1. **Automation**: Deploy and configure in minutes, not hours
    2. **Consistency**: Identical configuration across all servers
    3. **Repeatability**: Same playbook, same result every time
    4. **Version control**: Track all configuration changes
    5. **Documentation**: Code documents the configuration
    6. **Compliance**: Enforce security and operational standards
    7. **Disaster recovery**: Quickly rebuild from code

    ## Ansible Overview

    Ansible is an agentless configuration management tool that uses SSH to configure systems.

    ### Key Features
    - **Agentless**: No software to install on managed nodes
    - **Simple**: Uses YAML for configuration (playbooks)
    - **Powerful**: Manages complex multi-tier deployments
    - **Idempotent**: Safe to run multiple times
    - **Extensible**: 1000s of modules for different systems
    - **Push-based**: Control node pushes configurations

    ### Ansible Architecture

    ```
    Control Node (Your laptop/server)
    ├── Ansible installed
    ├── Inventory (list of servers)
    └── Playbooks (configuration code)
         │
         └─── SSH ───┐
                     │
    Managed Nodes    │
    ├── web-1 ───────┘
    ├── web-2
    ├── db-1
    └── db-2
    ```

    ### Installation

    ```bash
    # macOS
    brew install ansible

    # Ubuntu/Debian
    sudo apt update
    sudo apt install ansible

    # CentOS/RHEL
    sudo yum install ansible

    # Using pip
    pip install ansible

    # Verify installation
    ansible --version
    ```

    ## Ansible Inventory

    The inventory defines hosts and groups of hosts.

    ### Simple Inventory (INI format)
    ```ini
    # inventory.ini
    [webservers]
    web1.example.com
    web2.example.com
    web3.example.com

    [databases]
    db1.example.com
    db2.example.com

    [loadbalancers]
    lb1.example.com

    [all:vars]
    ansible_user=ubuntu
    ansible_ssh_private_key_file=~/.ssh/id_rsa
    ```

    ### YAML Inventory
    ```yaml
    # inventory.yml
    all:
      children:
        webservers:
          hosts:
            web1.example.com:
            web2.example.com:
            web3.example.com:
          vars:
            http_port: 80

        databases:
          hosts:
            db1.example.com:
              ansible_host: 10.0.1.10
            db2.example.com:
              ansible_host: 10.0.1.11
          vars:
            db_port: 5432

        loadbalancers:
          hosts:
            lb1.example.com:
      vars:
        ansible_user: ubuntu
        ansible_ssh_private_key_file: ~/.ssh/id_rsa
    ```

    ### Dynamic Inventory
    ```bash
    # AWS EC2
    ansible-inventory -i aws_ec2.yml --list

    # Script
    ./dynamic_inventory.py --list
    ```

    ## Ad-Hoc Commands

    Quick one-off commands without playbooks.

    ```bash
    # Ping all hosts
    ansible all -i inventory.ini -m ping

    # Run command on all web servers
    ansible webservers -i inventory.ini -a "uptime"

    # Install package
    ansible webservers -i inventory.ini -m apt -a "name=nginx state=present" --become

    # Copy file
    ansible webservers -i inventory.ini -m copy -a "src=./app.conf dest=/etc/app/app.conf"

    # Restart service
    ansible webservers -i inventory.ini -m service -a "name=nginx state=restarted" --become

    # Gather facts
    ansible web1.example.com -i inventory.ini -m setup
    ```

    ## Ansible Playbooks

    Playbooks are YAML files that describe automation jobs.

    ### Basic Playbook Structure
    ```yaml
    ---
    - name: Configure web servers
      hosts: webservers
      become: yes

      tasks:
        - name: Install Nginx
          apt:
            name: nginx
            state: present
            update_cache: yes
    ```

    ### Complete Web Server Playbook

    ```yaml
    ---
    # webserver.yml
    - name: Configure web servers
      hosts: webservers
      become: yes

      vars:
        http_port: 80
        https_port: 443
        app_user: webapp
        app_dir: /var/www/myapp

      tasks:
        - name: Update apt cache
          apt:
            update_cache: yes
            cache_valid_time: 3600

        - name: Install required packages
          apt:
            name:
              - nginx
              - python3
              - python3-pip
              - git
              - ufw
            state: present

        - name: Create application user
          user:
            name: "{{ app_user }}"
            shell: /bin/bash
            create_home: yes

        - name: Create application directory
          file:
            path: "{{ app_dir }}"
            state: directory
            owner: "{{ app_user }}"
            group: "{{ app_user }}"
            mode: '0755'

        - name: Copy Nginx configuration
          template:
            src: templates/nginx.conf.j2
            dest: /etc/nginx/sites-available/myapp
            owner: root
            group: root
            mode: '0644'
          notify: Restart Nginx

        - name: Enable site
          file:
            src: /etc/nginx/sites-available/myapp
            dest: /etc/nginx/sites-enabled/myapp
            state: link
          notify: Restart Nginx

        - name: Remove default site
          file:
            path: /etc/nginx/sites-enabled/default
            state: absent
          notify: Restart Nginx

        - name: Configure firewall
          ufw:
            rule: allow
            port: "{{ item }}"
            proto: tcp
          loop:
            - "{{ http_port }}"
            - "{{ https_port }}"
            - "22"

        - name: Enable firewall
          ufw:
            state: enabled
            policy: deny

        - name: Start and enable Nginx
          service:
            name: nginx
            state: started
            enabled: yes

      handlers:
        - name: Restart Nginx
          service:
            name: nginx
            state: restarted
    ```

    ### Nginx Template (templates/nginx.conf.j2)
    ```nginx
    server {
        listen {{ http_port }};
        server_name {{ ansible_fqdn }};

        root {{ app_dir }};
        index index.html index.htm;

        location / {
            try_files $uri $uri/ =404;
        }

        location /api {
            proxy_pass http://localhost:3000;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }

        access_log /var/log/nginx/{{ ansible_hostname }}-access.log;
        error_log /var/log/nginx/{{ ansible_hostname }}-error.log;
    }
    ```

    ### Run Playbook
    ```bash
    # Check syntax
    ansible-playbook webserver.yml --syntax-check

    # Dry run (check mode)
    ansible-playbook -i inventory.ini webserver.yml --check

    # Run playbook
    ansible-playbook -i inventory.ini webserver.yml

    # Verbose output
    ansible-playbook -i inventory.ini webserver.yml -v

    # Limit to specific hosts
    ansible-playbook -i inventory.ini webserver.yml --limit web1.example.com

    # Start at specific task
    ansible-playbook -i inventory.ini webserver.yml --start-at-task="Install Nginx"
    ```

    ## Ansible Roles

    Roles organize playbooks into reusable components.

    ### Role Structure
    ```
    roles/
    └── webserver/
        ├── tasks/
        │   └── main.yml
        ├── handlers/
        │   └── main.yml
        ├── templates/
        │   └── nginx.conf.j2
        ├── files/
        │   └── index.html
        ├── vars/
        │   └── main.yml
        ├── defaults/
        │   └── main.yml
        ├── meta/
        │   └── main.yml
        └── README.md
    ```

    ### roles/webserver/tasks/main.yml
    ```yaml
    ---
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Copy configuration
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/default
      notify: Restart Nginx

    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: yes
    ```

    ### roles/webserver/handlers/main.yml
    ```yaml
    ---
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
    ```

    ### roles/webserver/defaults/main.yml
    ```yaml
    ---
    http_port: 80
    https_port: 443
    worker_processes: auto
    ```

    ### Using Roles in Playbook
    ```yaml
    ---
    - name: Configure web infrastructure
      hosts: webservers
      become: yes

      roles:
        - common
        - webserver
        - monitoring
    ```

    ### Ansible Galaxy
    Download community roles:

    ```bash
    # Install role from Galaxy
    ansible-galaxy install geerlingguy.nginx

    # Install from requirements file
    ansible-galaxy install -r requirements.yml
    ```

    requirements.yml:
    ```yaml
    ---
    - src: geerlingguy.nginx
      version: 3.1.4

    - src: geerlingguy.postgresql
      version: 3.3.0
    ```

    ## Complete Web Server Provisioning Example

    ### Project Structure
    ```
    ansible-webserver/
    ├── inventory/
    │   ├── production.ini
    │   └── staging.ini
    ├── group_vars/
    │   ├── all.yml
    │   ├── webservers.yml
    │   └── databases.yml
    ├── host_vars/
    │   └── web1.example.com.yml
    ├── roles/
    │   ├── common/
    │   ├── webserver/
    │   └── database/
    ├── playbooks/
    │   ├── site.yml
    │   ├── webservers.yml
    │   └── databases.yml
    └── ansible.cfg
    ```

    ### ansible.cfg
    ```ini
    [defaults]
    inventory = inventory/production.ini
    remote_user = ubuntu
    private_key_file = ~/.ssh/id_rsa
    host_key_checking = False
    retry_files_enabled = False
    roles_path = ./roles

    [privilege_escalation]
    become = True
    become_method = sudo
    become_user = root
    become_ask_pass = False
    ```

    ### group_vars/all.yml
    ```yaml
    ---
    # Global variables
    ansible_python_interpreter: /usr/bin/python3

    # Common packages
    common_packages:
      - vim
      - curl
      - wget
      - htop
      - git

    # Timezone
    timezone: America/New_York

    # NTP servers
    ntp_servers:
      - 0.pool.ntp.org
      - 1.pool.ntp.org
    ```

    ### group_vars/webservers.yml
    ```yaml
    ---
    http_port: 80
    https_port: 443
    app_name: myapp
    app_port: 3000
    app_dir: /var/www/{{ app_name }}

    # SSL certificate
    ssl_certificate: /etc/ssl/certs/{{ app_name }}.crt
    ssl_certificate_key: /etc/ssl/private/{{ app_name }}.key
    ```

    ### playbooks/site.yml
    ```yaml
    ---
    # Master playbook
    - import_playbook: webservers.yml
    - import_playbook: databases.yml
    - import_playbook: monitoring.yml
    ```

    ### playbooks/webservers.yml
    ```yaml
    ---
    - name: Configure web servers
      hosts: webservers
      become: yes

      roles:
        - common
        - webserver
        - { role: ssl, when: enable_ssl }
        - monitoring-agent

      tasks:
        - name: Deploy application
          git:
            repo: https://github.com/myorg/myapp.git
            dest: "{{ app_dir }}"
            version: "{{ app_version | default('main') }}"
          notify: Restart application

        - name: Install application dependencies
          pip:
            requirements: "{{ app_dir }}/requirements.txt"
            virtualenv: "{{ app_dir }}/venv"

        - name: Copy systemd service file
          template:
            src: templates/myapp.service.j2
            dest: /etc/systemd/system/myapp.service
          notify:
            - Reload systemd
            - Restart application

        - name: Start application
          service:
            name: myapp
            state: started
            enabled: yes

      handlers:
        - name: Reload systemd
          systemd:
            daemon_reload: yes

        - name: Restart application
          service:
            name: myapp
            state: restarted
    ```

    ### Run Complete Provisioning
    ```bash
    # Deploy to staging
    ansible-playbook -i inventory/staging.ini playbooks/site.yml

    # Deploy to production with specific version
    ansible-playbook -i inventory/production.ini playbooks/site.yml -e "app_version=v1.2.3"

    # Check what would change
    ansible-playbook -i inventory/production.ini playbooks/site.yml --check --diff
    ```

    ## CloudFormation vs Terraform

    ### AWS CloudFormation

    **Pros:**
    - Native AWS service, deep integration
    - No additional tools needed
    - Direct support from AWS
    - Free to use

    **Cons:**
    - AWS-only (vendor lock-in)
    - JSON/YAML can be verbose
    - Slower to adopt new AWS features
    - Limited reusability

    ### Example CloudFormation
    ```yaml
    AWSTemplateFormatVersion: '2010-09-09'
    Resources:
      MyEC2Instance:
        Type: AWS::EC2::Instance
        Properties:
          InstanceType: t2.micro
          ImageId: ami-0c55b159cbfafe1f0
          Tags:
            - Key: Name
              Value: MyInstance
    ```

    ### Terraform

    **Pros:**
    - Multi-cloud support
    - Clean HCL syntax
    - Strong community
    - Better state management
    - Modules for reusability

    **Cons:**
    - Additional tool to install
    - State file management complexity
    - May lag behind new AWS features

    ### Same Example in Terraform
    ```hcl
    resource "aws_instance" "web" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"

      tags = {
        Name = "MyInstance"
      }
    }
    ```

    ### When to Use What?

    **Use CloudFormation if:**
    - Exclusively using AWS
    - Want native AWS integration
    - Using AWS-specific features
    - Prefer AWS support

    **Use Terraform if:**
    - Multi-cloud environment
    - Want cleaner syntax
    - Need strong module ecosystem
    - Value community tools

    ## Pulumi - IaC with Programming Languages

    Pulumi lets you use real programming languages (TypeScript, Python, Go, C#) for infrastructure.

    ### Benefits
    - Use familiar programming languages
    - IDE autocomplete and type checking
    - Standard programming constructs (loops, functions, classes)
    - Better abstraction and reusability
    - Test with standard testing frameworks

    ### Example: Python with Pulumi
    ```python
    import pulumi
    import pulumi_aws as aws

    # Create VPC
    vpc = aws.ec2.Vpc('my-vpc',
        cidr_block='10.0.0.0/16',
        enable_dns_hostnames=True,
        tags={'Name': 'my-vpc'})

    # Create subnet
    subnet = aws.ec2.Subnet('my-subnet',
        vpc_id=vpc.id,
        cidr_block='10.0.1.0/24',
        availability_zone='us-west-2a',
        tags={'Name': 'my-subnet'})

    # Create instances using loop
    instances = []
    for i in range(3):
        instance = aws.ec2.Instance(f'web-{i}',
            ami='ami-0c55b159cbfafe1f0',
            instance_type='t2.micro',
            subnet_id=subnet.id,
            tags={'Name': f'web-{i}'})
        instances.append(instance)

    # Export outputs
    pulumi.export('vpc_id', vpc.id)
    pulumi.export('instance_ids', [i.id for i in instances])
    ```

    ### Example: TypeScript with Pulumi
    ```typescript
    import * as pulumi from "@pulumi/pulumi";
    import * as aws from "@pulumi/aws";

    // Create S3 bucket
    const bucket = new aws.s3.Bucket("my-bucket", {
        acl: "private",
        versioning: {
            enabled: true,
        },
    });

    // Create multiple EC2 instances
    const instances = Array.from({length: 3}, (_, i) =>
        new aws.ec2.Instance(`web-${i}`, {
            ami: "ami-0c55b159cbfafe1f0",
            instanceType: "t2.micro",
            tags: {
                Name: `web-${i}`,
            },
        })
    );

    // Export outputs
    export const bucketName = bucket.id;
    export const instanceIds = instances.map(i => i.id);
    ```

    ## IaC Best Practices

    ### 1. Version Control Everything
    - All IaC code in Git
    - Branch strategy for environments
    - Code review for changes
    - Tag releases

    ### 2. Modular and DRY
    - Create reusable modules
    - Don't repeat yourself
    - Parameterize configurations
    - Use inheritance and composition

    ### 3. Immutable Infrastructure
    - Replace servers, don't modify
    - Version everything
    - Use blue-green deployments
    - Treat servers as cattle, not pets

    ### 4. Security
    - Never commit secrets
    - Use secret managers (AWS Secrets Manager, Vault)
    - Encrypt state files
    - Scan IaC for vulnerabilities
    - Apply least privilege

    ### 5. Testing
    - Validate syntax before apply
    - Test in non-production first
    - Use automated testing (Terratest, InSpec)
    - Integration tests
    - Security scanning

    ### 6. Documentation
    - README for each project
    - Document variables and outputs
    - Diagram architecture
    - Runbook for operations

    ### 7. CI/CD Integration
    ```yaml
    # .github/workflows/terraform.yml
    name: Terraform

    on:
      push:
        branches: [main]
      pull_request:
        branches: [main]

    jobs:
      terraform:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Setup Terraform
            uses: hashicorp/setup-terraform@v1

          - name: Terraform Init
            run: terraform init

          - name: Terraform Format
            run: terraform fmt -check

          - name: Terraform Validate
            run: terraform validate

          - name: Terraform Plan
            run: terraform plan

          - name: Terraform Apply
            if: github.ref == 'refs/heads/main'
            run: terraform apply -auto-approve
    ```

    ### 8. State Management
    - Use remote state
    - Enable state locking
    - Regular backups
    - State encryption
    - Access control

    ### 9. Monitoring and Alerts
    - Monitor infrastructure changes
    - Alert on drift detection
    - Track cost changes
    - Log all operations

    ### 10. Disaster Recovery
    - Test recovery procedures
    - Document rollback steps
    - Maintain backups
    - Practice chaos engineering

    ## Summary

    Configuration management and IaC tools enable:
    - **Ansible**: Agentless configuration management with simple YAML
    - **CloudFormation**: Native AWS infrastructure provisioning
    - **Terraform**: Multi-cloud infrastructure with HCL
    - **Pulumi**: Infrastructure using real programming languages
    - **Best practices**: Security, testing, CI/CD, and documentation

    Choose tools based on your needs:
    - Terraform for infrastructure provisioning
    - Ansible for configuration and application deployment
    - Both together for complete automation
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 3 microlessons for Iac Fundamentals"

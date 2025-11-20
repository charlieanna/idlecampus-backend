# AUTO-GENERATED from linux_browser_course_part3.rb
puts "Creating Microlessons for Shell Scripting Automation..."

module_var = CourseModule.find_by(slug: 'shell-scripting-automation')

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

# Capstone Project: Deploy and Secure a Web Service

    ## Project Overview

    You are now the Linux administrator for a small web project. Your task is to:
    1. Set up a basic web server
    2. Secure it with proper user permissions and firewall
    3. Automate backups
    4. Verify the deployment works end-to-end

    This project integrates skills from all 7 modules:
    - **Module 1-2**: File management, navigation
    - **Module 3**: User accounts, permissions
    - **Module 4**: Process management, cron scheduling
    - **Module 5**: Package installation, service management
    - **Module 6**: Firewall configuration, networking
    - **Module 7**: Shell scripting for automation

    ## Scenario

    Your organization needs a web server to host a simple website. Security is important:
    - Web files should be owned by a dedicated user (not root)
    - Firewall should only allow necessary ports (SSH, HTTP)
    - Automated daily backups of website content
    - The web service must start automatically on boot

    ## Project Tasks

    ### 1. Create Dedicated User

    Create a `webadmin` user who will own website files (principle of least privilege):

    ```bash
    sudo adduser webadmin
    # Set password when prompted
    ```

    ### 2. Install Apache HTTP Server

    ```bash
    sudo apt update
    sudo apt install -y apache2
    sudo systemctl status apache2
    sudo systemctl enable apache2
    ```

    ### 3. Customize Web Content

    ```bash
    # Create custom homepage
    echo "Hello from $(hostname) at $(date)" | sudo tee /var/www/html/index.html

    # Add webadmin to www-data group
    sudo usermod -aG www-data webadmin

    # Change ownership
    sudo chown -R www-data:www-data /var/www

    # Test
    curl http://localhost
    ```

    ### 4. Configure Firewall

    ```bash
    # Allow SSH and HTTP
    sudo ufw allow 22/tcp
    sudo ufw allow 80/tcp
    sudo ufw enable
    sudo ufw status verbose
    ```

    ### 5. Create Backup Script

    ```bash
    #!/bin/bash
    # /home/webadmin/backup_web.sh

    BACKUP_DIR="/home/webadmin"
    DATE=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="web_backup_$DATE.tar.gz"

    echo "Creating backup: $BACKUP_FILE"
    tar -czf "$BACKUP_DIR/$BACKUP_FILE" /var/www/html
    echo "Backup complete: $BACKUP_DIR/$BACKUP_FILE"
    ```

    Make executable:
    ```bash
    chmod +x /home/webadmin/backup_web.sh
    ```

    ### 6. Schedule Automated Backups

    ```bash
    sudo crontab -u webadmin -e
    # Add: 0 0 * * * /home/webadmin/backup_web.sh
    ```

    This runs the backup daily at midnight.

    ### 7. Testing and Verification

    **Test web service:**
    ```bash
    curl http://localhost
    systemctl status apache2
    ```

    **Test backup:**
    ```bash
    sudo -u webadmin /home/webadmin/backup_web.sh
    ls -lh /home/webadmin/web_backup_*.tar.gz
    ```

    **Verify firewall:**
    ```bash
    sudo ufw status numbered
    ```

    **Check logs:**
    ```bash
    sudo journalctl -u apache2 -n 20
    ```

    ## Success Criteria

    - ✅ Apache installed and running
    - ✅ Apache enabled to start on boot
    - ✅ Custom webpage accessible via curl/browser
    - ✅ Dedicated webadmin user created
    - ✅ Proper file ownership (www-data:www-data)
    - ✅ Firewall enabled with SSH and HTTP allowed
    - ✅ Backup script creates compressed archive
    - ✅ Cron job scheduled for daily backups
    - ✅ All services and logs verified

    ## What You've Accomplished

    By completing this capstone, you've demonstrated:
    - **Systems Administration**: Installing and configuring services
    - **Security**: User separation, permissions, firewall
    - **Automation**: Scripting and scheduling
    - **Troubleshooting**: Testing and log verification
    - **Best Practices**: Following principle of least privilege

    ## Next Steps

    With this solid Linux foundation, you're ready for:
    - **Docker**: Containerizing this web service
    - **Kubernetes**: Orchestrating multiple containers
    - **CI/CD**: Automating deployments
    - **Cloud**: Deploying to AWS, Azure, or GCP

    The skills you've learned apply directly to container environments:
    - Containers are Linux processes (you know process management)
    - Container images are like Linux filesystems (you know the hierarchy)
    - Container networking uses Linux networking (you know the basics)
    - Container security uses Linux permissions (you know users/groups)
    - Automation skills transfer to container orchestration

    Congratulations on completing the Browser-Based Linux Fundamentals Course! 🎉
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

# Shell Scripting and Automation

    ## Why Scripting Matters

    **Shell scripts automate repetitive tasks:**
    - System backups
    - User provisioning
    - Log rotation
    - Health checks
    - Deployment automation

    **Benefits:**
    - Save time
    - Reduce human error
    - Ensure consistency
    - Enable scheduling (cron)

    In DevOps and containerization, scripting is essential for CI/CD pipelines, container builds, and infrastructure automation.

    ## Shell Script Basics

    ### What is a Shell Script?

    A shell script is a text file containing a sequence of shell commands that can be executed together.

    **Basic structure:**
    ```bash
    #!/bin/bash
    # This is a comment

    echo "Hello, World!"
    ```

    ### The Shebang (#!)

    The **shebang** tells the system which interpreter to use:

    ```bash
    #!/bin/bash          # Use Bash
    #!/bin/sh            # Use sh (POSIX)
    #!/usr/bin/env bash  # Find bash in PATH (portable)
    #!/usr/bin/python3   # Python script
    ```

    Must be the **first line** of the script.

    ### Creating and Running Scripts

    **Create script:**
    ```bash
    nano myscript.sh
    ```

    **Make executable:**
    ```bash
    chmod +x myscript.sh
    ```

    **Run script:**
    ```bash
    # If executable and in PATH
    ./myscript.sh

    # Or explicitly with bash
    bash myscript.sh

    # Or with absolute path
    /home/user/scripts/myscript.sh
    ```

    ### Simple Script Example

    ```bash
    #!/bin/bash
    # Simple system info script

    echo "System Information Report"
    echo "========================="
    echo "User: $(whoami)"
    echo "Date: $(date)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    ```

    ## Variables

    ### Declaring Variables

    ```bash
    # No spaces around =
    NAME="Alice"
    COUNT=10
    TODAY=$(date +%Y-%m-%d)

    # Use variables with $
    echo "Hello, $NAME"
    echo "Count is $COUNT"
    echo "Today is $TODAY"
    ```

    **Variable naming:**
    - Use UPPERCASE for constants
    - Use lowercase for local variables
    - Use descriptive names

    ### Command Substitution

    Execute a command and capture its output:

    ```bash
    # Modern syntax (recommended)
    CURRENT_USER=$(whoami)
    FILE_COUNT=$(ls | wc -l)

    # Legacy syntax (backticks)
    CURRENT_USER=`whoami`

    echo "User: $CURRENT_USER"
    echo "Files: $FILE_COUNT"
    ```

    ### Special Variables

    | Variable | Meaning |
    |----------|---------|
    | `$0` | Script name |
    | `$1`, `$2`, ... | Positional parameters (arguments) |
    | `$#` | Number of arguments |
    | `$@` | All arguments as separate words |
    | `$*` | All arguments as single word |
    | `$?` | Exit status of last command |
    | `$$` | Current process ID |
    | `$HOME` | Home directory |
    | `$PATH` | Command search path |
    | `$PWD` | Current directory |

    ### Example with Variables

    ```bash
    #!/bin/bash
    # Backup script with variables

    SOURCE_DIR="/var/www"
    BACKUP_DIR="/backup"
    DATE=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="website_backup_$DATE.tar.gz"

    echo "Creating backup: $BACKUP_FILE"
    tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"
    echo "Backup complete!"
    ```

    ## Control Structures

    ### If Statements

    **Basic syntax:**
    ```bash
    if [ condition ]; then
        # commands
    elif [ condition ]; then
        # commands
    else
        # commands
    fi
    ```

    **Example:**
    ```bash
    #!/bin/bash

    if [ -f "/etc/passwd" ]; then
        echo "Password file exists"
    else
        echo "Password file not found"
    fi
    ```

    ### Test Operators

    **File tests:**
    ```bash
    [ -e file ]     # File exists
    [ -f file ]     # Regular file exists
    [ -d dir ]      # Directory exists
    [ -r file ]     # File is readable
    [ -w file ]     # File is writable
    [ -x file ]     # File is executable
    [ -s file ]     # File exists and not empty
    ```

    **String tests:**
    ```bash
    [ -z "$str" ]      # String is empty
    [ -n "$str" ]      # String is not empty
    [ "$a" = "$b" ]    # Strings equal
    [ "$a" != "$b" ]   # Strings not equal
    ```

    **Numeric tests:**
    ```bash
    [ "$a" -eq "$b" ]  # Equal
    [ "$a" -ne "$b" ]  # Not equal
    [ "$a" -lt "$b" ]  # Less than
    [ "$a" -le "$b" ]  # Less than or equal
    [ "$a" -gt "$b" ]  # Greater than
    [ "$a" -ge "$b" ]  # Greater than or equal
    ```

    **Logical operators:**
    ```bash
    [ condition1 ] && [ condition2 ]  # AND
    [ condition1 ] || [ condition2 ]  # OR
    [ ! condition ]                   # NOT
    ```

    ### Example: Check if Service is Running

    ```bash
    #!/bin/bash

    if systemctl is-active --quiet apache2; then
        echo "Apache is running"
    else
        echo "Apache is NOT running"
        echo "Starting Apache..."
        sudo systemctl start apache2
    fi
    ```

    ### For Loops

    **Loop over list:**
    ```bash
    #!/bin/bash

    for user in alice bob charlie; do
        echo "Processing user: $user"
        # Add commands here
    done
    ```

    **Loop over files:**
    ```bash
    #!/bin/bash

    for file in *.txt; do
        echo "Processing: $file"
        # Add commands here
    done
    ```

    **Loop with range:**
    ```bash
    #!/bin/bash

    for i in {1..5}; do
        echo "Number: $i"
    done
    ```

    **C-style loop:**
    ```bash
    #!/bin/bash

    for ((i=1; i<=10; i++)); do
        echo "Count: $i"
    done
    ```

    ### While Loops

    ```bash
    #!/bin/bash

    COUNT=1
    while [ $COUNT -le 5 ]; do
        echo "Count: $COUNT"
        COUNT=$((COUNT + 1))
    done
    ```

    ### Example: Cleanup Script

    ```bash
    #!/bin/bash
    # Clean up old log files

    LOG_DIR="/var/log/myapp"
    DAYS=30

    echo "Removing log files older than $DAYS days..."

    for file in "$LOG_DIR"/*.log; do
        if [ -f "$file" ]; then
            # Check if file is older than DAYS
            if [ $(find "$file" -mtime +$DAYS) ]; then
                echo "Deleting: $file"
                rm "$file"
            fi
        fi
    done

    echo "Cleanup complete!"
    ```

    ## Script Arguments

    ### Accepting Arguments

    ```bash
    #!/bin/bash
    # backup.sh - Backup a directory

    if [ $# -eq 0 ]; then
        echo "Usage: $0 <directory>"
        exit 1
    fi

    SOURCE=$1
    BACKUP_DIR="/backup"
    DATE=$(date +%Y%m%d)

    if [ ! -d "$SOURCE" ]; then
        echo "Error: $SOURCE is not a directory"
        exit 1
    fi

    echo "Backing up $SOURCE..."
    tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE"
    echo "Backup complete!"
    ```

    **Usage:**
    ```bash
    ./backup.sh /var/www
    ./backup.sh /home/user/documents
    ```

    ### Exit Status

    Scripts return an exit code:
    - **0**: Success
    - **Non-zero**: Error

    ```bash
    #!/bin/bash

    if ping -c 1 google.com &> /dev/null; then
        echo "Internet is working"
        exit 0
    else
        echo "No internet connection"
        exit 1
    fi
    ```

    Check exit status:
    ```bash
    ./check_internet.sh
    echo "Exit status: $?"
    ```

    ## Functions

    ```bash
    #!/bin/bash

    # Define function
    backup_directory() {
        local dir=$1
        local backup_file="backup_$(date +%Y%m%d).tar.gz"

        echo "Backing up $dir..."
        tar -czf "$backup_file" "$dir"
        echo "Backup saved to $backup_file"
    }

    # Call function
    backup_directory "/var/www"
    backup_directory "/etc"
    ```

    ## Scheduling Scripts with Cron

    ### Cron Integration

    Once you have a working script, schedule it:

    ```bash
    # Edit crontab
    crontab -e

    # Run backup script daily at 2 AM
    0 2 * * * /home/user/scripts/backup.sh

    # Run cleanup weekly on Sunday at midnight
    0 0 * * 0 /home/user/scripts/cleanup.sh

    # Run health check every 15 minutes
    */15 * * * * /home/user/scripts/health_check.sh >> /var/log/health.log 2>&1
    ```

    **Important:** Use absolute paths in cron scripts!

    ### Cron Script Best Practices

    ```bash
    #!/bin/bash
    # Good cron script template

    # Set PATH explicitly
    PATH=/usr/local/bin:/usr/bin:/bin

    # Redirect output to log file
    LOG_FILE="/var/log/myscript.log"
    exec >> "$LOG_FILE" 2>&1

    # Log start time
    echo "[$(date)] Script started"

    # Your commands here
    # ...

    # Log completion
    echo "[$(date)] Script completed"
    ```

    ## Debugging Scripts

    ### Common Techniques

    ```bash
    # Run with verbose output
    bash -x script.sh

    # Add debugging in script
    #!/bin/bash
    set -x          # Enable debugging
    # commands
    set +x          # Disable debugging

    # Check syntax without running
    bash -n script.sh

    # Add error handling
    set -e          # Exit on any error
    set -u          # Exit on undefined variable
    set -o pipefail # Exit on pipe failure
    ```

    ### Example with Error Handling

    ```bash
    #!/bin/bash
    set -euo pipefail

    # Log function
    log() {
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
    }

    log "Script started"

    # Commands that might fail
    if ! ping -c 1 google.com &> /dev/null; then
        log "ERROR: No internet connection"
        exit 1
    fi

    log "Script completed successfully"
    exit 0
    ```

    ## Advanced Automation Tools

    ### Beyond Shell Scripts

    As infrastructure grows, consider:

    **Ansible:**
    - Configuration management
    - Uses YAML playbooks
    - Agentless (SSH-based)

    ```yaml
    # Example Ansible playbook
    - hosts: webservers
      tasks:
        - name: Install Apache
          apt: name=apache2 state=present
    ```

    **Python:**
    - More powerful than Bash
    - Better error handling
    - Rich libraries

    **Terraform:**
    - Infrastructure as code
    - Cloud provisioning

    **Version Control (Git):**
    - Store scripts in Git repositories
    - Track changes
    - Collaborate with team

    ## Summary

    In this module, you learned:
    - Shell scripts automate repetitive Linux tasks
    - Use shebang (#!/bin/bash) and make scripts executable
    - Variables store data, command substitution captures output
    - Control structures: if/then/else, for loops, while loops
    - Pass arguments to scripts using $1, $2, etc.
    - Exit status indicates success (0) or failure (non-zero)
    - Schedule scripts with cron for automation
    - Debug scripts with bash -x and error handling
    - Advanced tools: Ansible, Python, Terraform for complex automation
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

# Capstone Project: Deploy and Secure a Web Service

    ## Project Overview

    You are now the Linux administrator for a small web project. Your task is to:
    1. Set up a basic web server
    2. Secure it with proper user permissions and firewall
    3. Automate backups
    4. Verify the deployment works end-to-end

    This project integrates skills from all 7 modules:
    - **Module 1-2**: File management, navigation
    - **Module 3**: User accounts, permissions
    - **Module 4**: Process management, cron scheduling
    - **Module 5**: Package installation, service management
    - **Module 6**: Firewall configuration, networking
    - **Module 7**: Shell scripting for automation

    ## Scenario

    Your organization needs a web server to host a simple website. Security is important:
    - Web files should be owned by a dedicated user (not root)
    - Firewall should only allow necessary ports (SSH, HTTP)
    - Automated daily backups of website content
    - The web service must start automatically on boot

    ## Project Tasks

    ### 1. Create Dedicated User

    Create a `webadmin` user who will own website files (principle of least privilege):

    ```bash
    sudo adduser webadmin
    # Set password when prompted
    ```

    ### 2. Install Apache HTTP Server

    ```bash
    sudo apt update
    sudo apt install -y apache2
    sudo systemctl status apache2
    sudo systemctl enable apache2
    ```

    ### 3. Customize Web Content

    ```bash
    # Create custom homepage
    echo "Hello from $(hostname) at $(date)" | sudo tee /var/www/html/index.html

    # Add webadmin to www-data group
    sudo usermod -aG www-data webadmin

    # Change ownership
    sudo chown -R www-data:www-data /var/www

    # Test
    curl http://localhost
    ```

    ### 4. Configure Firewall

    ```bash
    # Allow SSH and HTTP
    sudo ufw allow 22/tcp
    sudo ufw allow 80/tcp
    sudo ufw enable
    sudo ufw status verbose
    ```

    ### 5. Create Backup Script

    ```bash
    #!/bin/bash
    # /home/webadmin/backup_web.sh

    BACKUP_DIR="/home/webadmin"
    DATE=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="web_backup_$DATE.tar.gz"

    echo "Creating backup: $BACKUP_FILE"
    tar -czf "$BACKUP_DIR/$BACKUP_FILE" /var/www/html
    echo "Backup complete: $BACKUP_DIR/$BACKUP_FILE"
    ```

    Make executable:
    ```bash
    chmod +x /home/webadmin/backup_web.sh
    ```

    ### 6. Schedule Automated Backups

    ```bash
    sudo crontab -u webadmin -e
    # Add: 0 0 * * * /home/webadmin/backup_web.sh
    ```

    This runs the backup daily at midnight.

    ### 7. Testing and Verification

    **Test web service:**
    ```bash
    curl http://localhost
    systemctl status apache2
    ```

    **Test backup:**
    ```bash
    sudo -u webadmin /home/webadmin/backup_web.sh
    ls -lh /home/webadmin/web_backup_*.tar.gz
    ```

    **Verify firewall:**
    ```bash
    sudo ufw status numbered
    ```

    **Check logs:**
    ```bash
    sudo journalctl -u apache2 -n 20
    ```

    ## Success Criteria

    - ✅ Apache installed and running
    - ✅ Apache enabled to start on boot
    - ✅ Custom webpage accessible via curl/browser
    - ✅ Dedicated webadmin user created
    - ✅ Proper file ownership (www-data:www-data)
    - ✅ Firewall enabled with SSH and HTTP allowed
    - ✅ Backup script creates compressed archive
    - ✅ Cron job scheduled for daily backups
    - ✅ All services and logs verified

    ## What You've Accomplished

    By completing this capstone, you've demonstrated:
    - **Systems Administration**: Installing and configuring services
    - **Security**: User separation, permissions, firewall
    - **Automation**: Scripting and scheduling
    - **Troubleshooting**: Testing and log verification
    - **Best Practices**: Following principle of least privilege

    ## Next Steps

    With this solid Linux foundation, you're ready for:
    - **Docker**: Containerizing this web service
    - **Kubernetes**: Orchestrating multiple containers
    - **CI/CD**: Automating deployments
    - **Cloud**: Deploying to AWS, Azure, or GCP

    The skills you've learned apply directly to container environments:
    - Containers are Linux processes (you know process management)
    - Container images are like Linux filesystems (you know the hierarchy)
    - Container networking uses Linux networking (you know the basics)
    - Container security uses Linux permissions (you know users/groups)
    - Automation skills transfer to container orchestration

    Congratulations on completing the Browser-Based Linux Fundamentals Course! 🎉
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 5: Practice Question ===
lesson_5 = MicroLesson.create!(
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
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 6: Practice Question ===
lesson_6 = MicroLesson.create!(
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
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 7: Practice Question ===
lesson_7 = MicroLesson.create!(
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
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: Practice Question ===
lesson_8 = MicroLesson.create!(
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
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 9: Lesson 9 ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 9',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Shell Scripting and Automation

    ## Why Scripting Matters

    **Shell scripts automate repetitive tasks:**
    - System backups
    - User provisioning
    - Log rotation
    - Health checks
    - Deployment automation

    **Benefits:**
    - Save time
    - Reduce human error
    - Ensure consistency
    - Enable scheduling (cron)

    In DevOps and containerization, scripting is essential for CI/CD pipelines, container builds, and infrastructure automation.

    ## Shell Script Basics

    ### What is a Shell Script?

    A shell script is a text file containing a sequence of shell commands that can be executed together.

    **Basic structure:**
    ```bash
    #!/bin/bash
    # This is a comment

    echo "Hello, World!"
    ```

    ### The Shebang (#!)

    The **shebang** tells the system which interpreter to use:

    ```bash
    #!/bin/bash          # Use Bash
    #!/bin/sh            # Use sh (POSIX)
    #!/usr/bin/env bash  # Find bash in PATH (portable)
    #!/usr/bin/python3   # Python script
    ```

    Must be the **first line** of the script.

    ### Creating and Running Scripts

    **Create script:**
    ```bash
    nano myscript.sh
    ```

    **Make executable:**
    ```bash
    chmod +x myscript.sh
    ```

    **Run script:**
    ```bash
    # If executable and in PATH
    ./myscript.sh

    # Or explicitly with bash
    bash myscript.sh

    # Or with absolute path
    /home/user/scripts/myscript.sh
    ```

    ### Simple Script Example

    ```bash
    #!/bin/bash
    # Simple system info script

    echo "System Information Report"
    echo "========================="
    echo "User: $(whoami)"
    echo "Date: $(date)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    ```

    ## Variables

    ### Declaring Variables

    ```bash
    # No spaces around =
    NAME="Alice"
    COUNT=10
    TODAY=$(date +%Y-%m-%d)

    # Use variables with $
    echo "Hello, $NAME"
    echo "Count is $COUNT"
    echo "Today is $TODAY"
    ```

    **Variable naming:**
    - Use UPPERCASE for constants
    - Use lowercase for local variables
    - Use descriptive names

    ### Command Substitution

    Execute a command and capture its output:

    ```bash
    # Modern syntax (recommended)
    CURRENT_USER=$(whoami)
    FILE_COUNT=$(ls | wc -l)

    # Legacy syntax (backticks)
    CURRENT_USER=`whoami`

    echo "User: $CURRENT_USER"
    echo "Files: $FILE_COUNT"
    ```

    ### Special Variables

    | Variable | Meaning |
    |----------|---------|
    | `$0` | Script name |
    | `$1`, `$2`, ... | Positional parameters (arguments) |
    | `$#` | Number of arguments |
    | `$@` | All arguments as separate words |
    | `$*` | All arguments as single word |
    | `$?` | Exit status of last command |
    | `$$` | Current process ID |
    | `$HOME` | Home directory |
    | `$PATH` | Command search path |
    | `$PWD` | Current directory |

    ### Example with Variables

    ```bash
    #!/bin/bash
    # Backup script with variables

    SOURCE_DIR="/var/www"
    BACKUP_DIR="/backup"
    DATE=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="website_backup_$DATE.tar.gz"

    echo "Creating backup: $BACKUP_FILE"
    tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"
    echo "Backup complete!"
    ```

    ## Control Structures

    ### If Statements

    **Basic syntax:**
    ```bash
    if [ condition ]; then
        # commands
    elif [ condition ]; then
        # commands
    else
        # commands
    fi
    ```

    **Example:**
    ```bash
    #!/bin/bash

    if [ -f "/etc/passwd" ]; then
        echo "Password file exists"
    else
        echo "Password file not found"
    fi
    ```

    ### Test Operators

    **File tests:**
    ```bash
    [ -e file ]     # File exists
    [ -f file ]     # Regular file exists
    [ -d dir ]      # Directory exists
    [ -r file ]     # File is readable
    [ -w file ]     # File is writable
    [ -x file ]     # File is executable
    [ -s file ]     # File exists and not empty
    ```

    **String tests:**
    ```bash
    [ -z "$str" ]      # String is empty
    [ -n "$str" ]      # String is not empty
    [ "$a" = "$b" ]    # Strings equal
    [ "$a" != "$b" ]   # Strings not equal
    ```

    **Numeric tests:**
    ```bash
    [ "$a" -eq "$b" ]  # Equal
    [ "$a" -ne "$b" ]  # Not equal
    [ "$a" -lt "$b" ]  # Less than
    [ "$a" -le "$b" ]  # Less than or equal
    [ "$a" -gt "$b" ]  # Greater than
    [ "$a" -ge "$b" ]  # Greater than or equal
    ```

    **Logical operators:**
    ```bash
    [ condition1 ] && [ condition2 ]  # AND
    [ condition1 ] || [ condition2 ]  # OR
    [ ! condition ]                   # NOT
    ```

    ### Example: Check if Service is Running

    ```bash
    #!/bin/bash

    if systemctl is-active --quiet apache2; then
        echo "Apache is running"
    else
        echo "Apache is NOT running"
        echo "Starting Apache..."
        sudo systemctl start apache2
    fi
    ```

    ### For Loops

    **Loop over list:**
    ```bash
    #!/bin/bash

    for user in alice bob charlie; do
        echo "Processing user: $user"
        # Add commands here
    done
    ```

    **Loop over files:**
    ```bash
    #!/bin/bash

    for file in *.txt; do
        echo "Processing: $file"
        # Add commands here
    done
    ```

    **Loop with range:**
    ```bash
    #!/bin/bash

    for i in {1..5}; do
        echo "Number: $i"
    done
    ```

    **C-style loop:**
    ```bash
    #!/bin/bash

    for ((i=1; i<=10; i++)); do
        echo "Count: $i"
    done
    ```

    ### While Loops

    ```bash
    #!/bin/bash

    COUNT=1
    while [ $COUNT -le 5 ]; do
        echo "Count: $COUNT"
        COUNT=$((COUNT + 1))
    done
    ```

    ### Example: Cleanup Script

    ```bash
    #!/bin/bash
    # Clean up old log files

    LOG_DIR="/var/log/myapp"
    DAYS=30

    echo "Removing log files older than $DAYS days..."

    for file in "$LOG_DIR"/*.log; do
        if [ -f "$file" ]; then
            # Check if file is older than DAYS
            if [ $(find "$file" -mtime +$DAYS) ]; then
                echo "Deleting: $file"
                rm "$file"
            fi
        fi
    done

    echo "Cleanup complete!"
    ```

    ## Script Arguments

    ### Accepting Arguments

    ```bash
    #!/bin/bash
    # backup.sh - Backup a directory

    if [ $# -eq 0 ]; then
        echo "Usage: $0 <directory>"
        exit 1
    fi

    SOURCE=$1
    BACKUP_DIR="/backup"
    DATE=$(date +%Y%m%d)

    if [ ! -d "$SOURCE" ]; then
        echo "Error: $SOURCE is not a directory"
        exit 1
    fi

    echo "Backing up $SOURCE..."
    tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE"
    echo "Backup complete!"
    ```

    **Usage:**
    ```bash
    ./backup.sh /var/www
    ./backup.sh /home/user/documents
    ```

    ### Exit Status

    Scripts return an exit code:
    - **0**: Success
    - **Non-zero**: Error

    ```bash
    #!/bin/bash

    if ping -c 1 google.com &> /dev/null; then
        echo "Internet is working"
        exit 0
    else
        echo "No internet connection"
        exit 1
    fi
    ```

    Check exit status:
    ```bash
    ./check_internet.sh
    echo "Exit status: $?"
    ```

    ## Functions

    ```bash
    #!/bin/bash

    # Define function
    backup_directory() {
        local dir=$1
        local backup_file="backup_$(date +%Y%m%d).tar.gz"

        echo "Backing up $dir..."
        tar -czf "$backup_file" "$dir"
        echo "Backup saved to $backup_file"
    }

    # Call function
    backup_directory "/var/www"
    backup_directory "/etc"
    ```

    ## Scheduling Scripts with Cron

    ### Cron Integration

    Once you have a working script, schedule it:

    ```bash
    # Edit crontab
    crontab -e

    # Run backup script daily at 2 AM
    0 2 * * * /home/user/scripts/backup.sh

    # Run cleanup weekly on Sunday at midnight
    0 0 * * 0 /home/user/scripts/cleanup.sh

    # Run health check every 15 minutes
    */15 * * * * /home/user/scripts/health_check.sh >> /var/log/health.log 2>&1
    ```

    **Important:** Use absolute paths in cron scripts!

    ### Cron Script Best Practices

    ```bash
    #!/bin/bash
    # Good cron script template

    # Set PATH explicitly
    PATH=/usr/local/bin:/usr/bin:/bin

    # Redirect output to log file
    LOG_FILE="/var/log/myscript.log"
    exec >> "$LOG_FILE" 2>&1

    # Log start time
    echo "[$(date)] Script started"

    # Your commands here
    # ...

    # Log completion
    echo "[$(date)] Script completed"
    ```

    ## Debugging Scripts

    ### Common Techniques

    ```bash
    # Run with verbose output
    bash -x script.sh

    # Add debugging in script
    #!/bin/bash
    set -x          # Enable debugging
    # commands
    set +x          # Disable debugging

    # Check syntax without running
    bash -n script.sh

    # Add error handling
    set -e          # Exit on any error
    set -u          # Exit on undefined variable
    set -o pipefail # Exit on pipe failure
    ```

    ### Example with Error Handling

    ```bash
    #!/bin/bash
    set -euo pipefail

    # Log function
    log() {
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
    }

    log "Script started"

    # Commands that might fail
    if ! ping -c 1 google.com &> /dev/null; then
        log "ERROR: No internet connection"
        exit 1
    fi

    log "Script completed successfully"
    exit 0
    ```

    ## Advanced Automation Tools

    ### Beyond Shell Scripts

    As infrastructure grows, consider:

    **Ansible:**
    - Configuration management
    - Uses YAML playbooks
    - Agentless (SSH-based)

    ```yaml
    # Example Ansible playbook
    - hosts: webservers
      tasks:
        - name: Install Apache
          apt: name=apache2 state=present
    ```

    **Python:**
    - More powerful than Bash
    - Better error handling
    - Rich libraries

    **Terraform:**
    - Infrastructure as code
    - Cloud provisioning

    **Version Control (Git):**
    - Store scripts in Git repositories
    - Track changes
    - Collaborate with team

    ## Summary

    In this module, you learned:
    - Shell scripts automate repetitive Linux tasks
    - Use shebang (#!/bin/bash) and make scripts executable
    - Variables store data, command substitution captures output
    - Control structures: if/then/else, for loops, while loops
    - Pass arguments to scripts using $1, $2, etc.
    - Exit status indicates success (0) or failure (non-zero)
    - Schedule scripts with cron for automation
    - Debug scripts with bash -x and error handling
    - Advanced tools: Ansible, Python, Terraform for complex automation
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 9 microlessons for Shell Scripting Automation"

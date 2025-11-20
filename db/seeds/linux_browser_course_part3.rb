# Browser-Based Linux Fundamentals Course - Part 3 (Module 7 + Capstone)
# This file must be loaded after linux_browser_course_part2.rb
puts "🐧 Adding Module 7 and Capstone Project to Linux Browser Course..."

# Find the existing course
linux_browser_course = Course.find_by!(slug: 'linux-browser-fundamentals')

# ==========================================
# MODULE 7: Shell Scripting and Automation (60 min)
# ==========================================

module7 = CourseModule.find_or_create_by!(slug: 'shell-scripting-automation', course: linux_browser_course) do |mod|
  mod.title = "Module 7: Shell Scripting and Automation"
  mod.description = "Write basic shell scripts to automate tasks, use variables and control structures, pass arguments, and schedule script execution."
  mod.sequence_order = 7
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Write basic shell scripts with shebang and make them executable",
    "Use variables, command substitution, and control structures",
    "Run scripts and pass arguments, understand exit status",
    "Schedule script execution using cron",
    "Understand role of automation in Linux administration"
  ])
end

module7_lesson = CourseLesson.find_or_create_by!(title: "Shell Scripting and Automation") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
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
end

module7_lab = HandsOnLab.find_or_create_by!(title: "Shell Scripting Lab") do |lab|
  lab.description = "Write shell scripts to automate tasks, use variables and control structures, and schedule with cron."
  lab.difficulty = "medium"
  lab.lab_type = "linux"
  lab.lab_format = "terminal"
  lab.estimated_minutes = 30
  lab.prerequisites = JSON.generate(["Module 1-6 completed"])
  lab.learning_objectives = JSON.generate([
    "Create executable shell scripts",
    "Use variables and command substitution",
    "Implement if statements and loops",
    "Accept and process script arguments",
    "Schedule scripts with cron"
  ])
  lab.steps = JSON.generate([
    {
      title: "Hello World Script",
      instruction: "Create a simple greeting script with command substitution",
      commands: [
        "cd ~",
        "nano hello.sh",
        "# Write: #!/bin/bash",
        "# echo \"Hello, $(whoami)! Today is $(date '+%A, %d %B %Y').\"",
        "chmod +x hello.sh",
        "./hello.sh"
      ],
      expected_output: "Script displays personalized greeting with current date"
    },
    {
      title: "System Info Script with Variables",
      instruction: "Create a script that gathers and displays system information",
      commands: [
        "nano sysinfo.sh",
        "# Add variables for hostname, date, uptime, memory",
        "chmod +x sysinfo.sh",
        "./sysinfo.sh"
      ],
      expected_output: "System information report displayed with hostname, date, uptime"
    },
    {
      title: "If Statement - Service Check",
      instruction: "Write a script to check if a service is running",
      commands: [
        "nano check_apache.sh",
        "# Add: #!/bin/bash",
        "# if systemctl is-active --quiet apache2; then",
        "#   echo \"Apache is running\"",
        "# else",
        "#   echo \"Apache is NOT running\"",
        "# fi",
        "chmod +x check_apache.sh",
        "./check_apache.sh"
      ],
      expected_output: "Script reports whether Apache service is active"
    },
    {
      title: "Loop Example - Cleanup Script",
      instruction: "Create a script that removes .tmp files using a for loop",
      commands: [
        "touch a.tmp b.tmp c.tmp",
        "nano cleanup.sh",
        "# Add loop: for f in *.tmp; do rm \"$f\"; done",
        "chmod +x cleanup.sh",
        "./cleanup.sh",
        "ls *.tmp"
      ],
      expected_output: "All .tmp files deleted, ls shows no .tmp files found"
    },
    {
      title: "Script with Arguments",
      instruction: "Create a backup script that accepts directory argument",
      commands: [
        "nano backup.sh",
        "# Add argument handling: if [ $# -eq 0 ]; then echo 'Usage...'; exit 1; fi",
        "chmod +x backup.sh",
        "mkdir testdir && touch testdir/file.txt",
        "./backup.sh testdir",
        "ls -lh backup_*.tar.gz"
      ],
      expected_output: "Backup created for specified directory"
    },
    {
      title: "Schedule Script with Cron",
      instruction: "Schedule the system info script to run periodically",
      commands: [
        "crontab -e",
        "# Add: */5 * * * * /home/$(whoami)/sysinfo.sh >> /home/$(whoami)/sysinfo.log 2>&1",
        "crontab -l",
        "# Wait 5-10 minutes",
        "cat ~/sysinfo.log"
      ],
      expected_output: "Cron job scheduled, log file shows periodic execution"
    }
  ])
end

module7_quiz = Quiz.find_or_create_by!(title: "Module 7 Quiz: Shell Scripting") do |quiz|
  quiz.description = "Test your understanding of shell scripting, variables, control structures, and automation"
  quiz.time_limit_minutes = 10
  quiz.passing_score = 80
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

q7_1 = QuizQuestion.find_or_create_by!(quiz: module7_quiz, question_order: 1) do |q|
  q.question_text = "What is the significance of #!/bin/bash at the top of a shell script?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "It's a comment that documents the script", correct: false },
    { text: "It specifies which interpreter should execute the script", correct: true },
    { text: "It makes the script executable", correct: false },
    { text: "It sets the script's permissions", correct: false }
  ])
  q.explanation = "The shebang (#!/bin/bash) tells the system to use the Bash shell to execute the script. Without it, the default shell is used."
end

q7_2 = QuizQuestion.find_or_create_by!(quiz: module7_quiz, question_order: 2) do |q|
  q.question_text = "How do you make a shell script file executable?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "chmod +x script.sh", correct: true },
    { text: "chown +x script.sh", correct: false },
    { text: "execute script.sh", correct: false },
    { text: "run script.sh", correct: false }
  ])
  q.explanation = "chmod +x script.sh adds execute permission. After that, you can run ./script.sh"
end

q7_3 = QuizQuestion.find_or_create_by!(quiz: module7_quiz, question_order: 3) do |q|
  q.question_text = "In a shell script, how would you reference the first command-line argument?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "$0", correct: false },
    { text: "$1", correct: true },
    { text: "$arg1", correct: false },
    { text: "$first", correct: false }
  ])
  q.explanation = "$1 represents the first argument. $0 is the script name, $2 is the second argument, etc."
end

q7_4 = QuizQuestion.find_or_create_by!(quiz: module7_quiz, question_order: 4) do |q|
  q.question_text = "Which test operator checks if a directory exists in a shell script?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "[ -f directory ]", correct: false },
    { text: "[ -d directory ]", correct: true },
    { text: "[ -e directory ]", correct: false },
    { text: "[ -x directory ]", correct: false }
  ])
  q.explanation = "[ -d path ] tests if path is a directory. -f tests for regular file, -e tests if exists (any type), -x tests if executable."
end

q7_5 = QuizQuestion.find_or_create_by!(quiz: module7_quiz, question_order: 5) do |q|
  q.question_text = "Name one tool or technology (aside from Bash scripting) used for automating system configuration or deployment."
  q.question_type = "multiple_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "Ansible", correct: true },
    { text: "Python", correct: true },
    { text: "Terraform", correct: true },
    { text: "Microsoft Word", correct: false }
  ])
  q.explanation = "Ansible (configuration management), Python (scripting), and Terraform (infrastructure as code) are all used for automation. Git is for version control."
end

# Link items to module
module7.module_items.find_or_create_by!(item: module7_lesson, sequence_order: 1) { |mi| mi.required = true }
module7.module_items.find_or_create_by!(item: module7_lab, sequence_order: 2) { |mi| mi.required = true }
module7.module_items.find_or_create_by!(item: module7_quiz, sequence_order: 3) { |mi| mi.required = true }

puts "  ✓ Module 7: Shell Scripting and Automation"

# ==========================================
# CAPSTONE PROJECT: Deploy and Secure a Web Service (60 min)
# ==========================================

capstone_module = CourseModule.find_or_create_by!(slug: 'capstone-web-service', course: linux_browser_course) do |mod|
  mod.title = "Capstone Project: Deploy and Secure a Web Service"
  mod.description = "Apply skills from all modules to set up a web server, secure it with proper permissions and firewall, and automate backups."
  mod.sequence_order = 8
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Integrate user management, package installation, and service control",
    "Deploy a functional web service with proper security",
    "Configure firewall to secure network access",
    "Create and schedule automated backup scripts",
    "Apply Linux fundamentals in a realistic scenario"
  ])
end

capstone_lesson = CourseLesson.find_or_create_by!(title: "Capstone Project Overview") do |lesson|
  lesson.reading_time_minutes = 10
  lesson.content = <<~MARKDOWN
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
end

capstone_lab = HandsOnLab.find_or_create_by!(title: "Capstone: Deploy and Secure Web Service") do |lab|
  lab.description = "End-to-end project integrating all course skills: deploy Apache, configure security, and automate backups."
  lab.difficulty = "hard"
  lab.lab_type = "linux"
  lab.lab_format = "terminal"
  lab.estimated_minutes = 60
  lab.prerequisites = JSON.generate(["All modules 1-7 completed", "sudo access"])
  lab.learning_objectives = JSON.generate([
    "Deploy a complete web service with proper configuration",
    "Implement security best practices (users, permissions, firewall)",
    "Create and schedule automated backup scripts",
    "Verify and troubleshoot service deployment",
    "Demonstrate proficiency in Linux system administration"
  ])
  lab.steps = JSON.generate([
    {
      title: "Create Dedicated User",
      instruction: "Create webadmin user for managing website files",
      commands: [
        "sudo adduser webadmin",
        "# Provide password when prompted",
        "id webadmin",
        "ls -ld /home/webadmin"
      ],
      expected_output: "User webadmin created with UID/GID, home directory exists"
    },
    {
      title: "Install Apache Web Server",
      instruction: "Install and enable Apache HTTP server",
      commands: [
        "sudo apt update",
        "sudo apt install -y apache2",
        "apache2 -v",
        "systemctl status apache2",
        "sudo systemctl enable apache2",
        "systemctl is-enabled apache2"
      ],
      expected_output: "Apache installed, running, and enabled for boot"
    },
    {
      title: "Customize Web Content",
      instruction: "Create custom webpage and set proper ownership",
      commands: [
        "echo \"Hello from $(hostname) at $(date)\" | sudo tee /var/www/html/index.html",
        "sudo usermod -aG www-data webadmin",
        "sudo chown -R www-data:www-data /var/www",
        "ls -ld /var/www/html",
        "curl http://localhost"
      ],
      expected_output: "Custom webpage created, ownership set, accessible via curl"
    },
    {
      title: "Configure Firewall",
      instruction: "Enable UFW and allow SSH and HTTP traffic",
      commands: [
        "sudo ufw allow 22/tcp",
        "sudo ufw allow 80/tcp",
        "sudo ufw --force enable",
        "sudo ufw status verbose"
      ],
      expected_output: "Firewall enabled with ports 22 and 80 allowed"
    },
    {
      title: "Create Backup Script",
      instruction: "Write shell script to backup website content",
      commands: [
        "sudo -u webadmin bash -c 'cat > /home/webadmin/backup_web.sh << \"EOF\"\n#!/bin/bash\nBACKUP_DIR=\"/home/webadmin\"\nDATE=$(date +%Y%m%d_%H%M%S)\nBACKUP_FILE=\"web_backup_$DATE.tar.gz\"\necho \"Creating backup: $BACKUP_FILE\"\ntar -czf \"$BACKUP_DIR/$BACKUP_FILE\" /var/www/html 2>/dev/null\necho \"Backup complete: $BACKUP_DIR/$BACKUP_FILE\"\nEOF'",
        "sudo chmod +x /home/webadmin/backup_web.sh",
        "sudo -u webadmin /home/webadmin/backup_web.sh",
        "ls -lh /home/webadmin/web_backup_*.tar.gz"
      ],
      expected_output: "Backup script created, executable, and produces .tar.gz archive"
    },
    {
      title: "Schedule Automated Backups",
      instruction: "Configure cron job for daily backups at midnight",
      commands: [
        "echo \"0 0 * * * /home/webadmin/backup_web.sh >> /home/webadmin/backup.log 2>&1\" | sudo crontab -u webadmin -",
        "sudo crontab -u webadmin -l"
      ],
      expected_output: "Cron job scheduled, visible in webadmin's crontab"
    },
    {
      title: "Verification and Testing",
      instruction: "Verify all components working correctly",
      commands: [
        "curl http://localhost",
        "systemctl status apache2",
        "sudo ufw status",
        "ls -lh /home/webadmin/web_backup_*.tar.gz | tail -1",
        "sudo journalctl -u apache2 -n 10",
        "ps aux | grep apache"
      ],
      expected_output: "All services operational, backups present, logs clean, processes running"
    }
  ])
end

# Link items to capstone module
capstone_module.module_items.find_or_create_by!(item: capstone_lesson, sequence_order: 1) { |mi| mi.required = true }
capstone_module.module_items.find_or_create_by!(item: capstone_lab, sequence_order: 2) { |mi| mi.required = true }

puts "  ✓ Capstone Project: Deploy and Secure a Web Service"

puts "✅ Part 3 (Module 7 + Capstone) added successfully!"
puts "📊 Course: #{linux_browser_course.title}"
puts "📚 Total Modules: #{linux_browser_course.course_modules.count}"
puts "🎉 Complete 8-hour Linux Browser Course created!"

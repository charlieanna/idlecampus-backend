# Linux Fundamentals Course Seed Data
puts "🐧 Seeding Linux Fundamentals Course..."

# ========================================
# COURSE: Linux Fundamentals
# ========================================

linux_course = Course.find_or_create_by!(slug: "linux-fundamentals") do |course|
  course.title = "Linux Fundamentals"
  course.description = "Master essential Linux command line skills and system administration concepts. Build a solid foundation for Docker, Kubernetes, and cloud technologies."
  course.difficulty_level = "beginner"
  course.estimated_hours = 15
  course.certification_track = "linux"
  course.published = true
  course.sequence_order = 0
  course.learning_objectives = JSON.generate([
    "Navigate the Linux filesystem with confidence",
    "Master essential command-line tools and utilities",
    "Understand Linux file permissions and ownership",
    "Manage processes and system resources",
    "Work with text files and streams effectively",
    "Configure basic networking and system services"
  ])
  course.prerequisites = JSON.generate([
    "Basic computer literacy",
    "Familiarity with using a terminal or command prompt"
  ])
end

puts "📦 Created course: #{linux_course.title}"

# ========================================
# Module 1: Linux Basics & Navigation
# ========================================

module1 = linux_course.course_modules.create!(
  title: "Linux Basics & Navigation",
  slug: "linux-basics-navigation",
  description: "Introduction to Linux, the filesystem hierarchy, and basic navigation commands",
  sequence_order: 1,
  estimated_minutes: 120,
  published: true,
  learning_objectives: JSON.generate([
    "Understand what Linux is and why it's important",
    "Navigate the filesystem using cd, ls, pwd",
    "Understand absolute vs relative paths",
    "Use basic file operations: cp, mv, rm, mkdir"
  ])
)

lesson1_1 = CourseLesson.create!(
  title: "Introduction to Linux",
  content: <<~MARKDOWN,
    # Introduction to Linux

    Linux is an open-source operating system kernel that powers millions of servers, containers, and cloud platforms worldwide.

    ## Why Learn Linux?

    1. **Ubiquity**: Powers most web servers, cloud infrastructure, and containers
    2. **Docker & Kubernetes**: Built on Linux kernel features (cgroups, namespaces)
    3. **Career Skills**: Essential for DevOps, SRE, and cloud engineering
    4. **Open Source**: Free, customizable, and community-driven

    ## Linux Distributions

    - **Ubuntu/Debian**: Popular for servers and beginners
    - **CentOS/RHEL**: Enterprise-focused distributions
    - **Alpine**: Minimal distribution used in Docker images
    - **Amazon Linux**: Optimized for AWS environments

    ## The Shell

    The shell is your interface to Linux. Common shells include:
    - **bash** (Bourne Again Shell): Most common default shell
    - **sh** (Bourne Shell): Basic POSIX-compliant shell
    - **zsh**: Enhanced shell with advanced features

    ### Your First Commands

    ```bash
    # Display current user
    whoami

    # Show current date and time
    date

    # Display current directory
    pwd

    # List files in current directory
    ls
    ```
  MARKDOWN
  video_url: nil,
  reading_time_minutes: 10,
  key_concepts: JSON.generate([
    "Linux operating system",
    "Shell and terminal",
    "Linux distributions",
    "Basic commands"
  ])
)

module1.module_items.create!(item: lesson1_1, sequence_order: 1, required: true)

lesson1_2 = CourseLesson.create!(
  title: "Linux Filesystem Hierarchy",
  content: <<~MARKDOWN,
    # Linux Filesystem Hierarchy

    Linux organizes files in a hierarchical tree structure starting from the root directory `/`.

    ## Key Directories

    ```
    /                   Root directory (top of filesystem)
    ├── bin/           Essential user binaries (ls, cat, cp)
    ├── etc/           System configuration files
    ├── home/          User home directories
    ├── opt/           Optional application packages
    ├── root/          Root user's home directory
    ├── tmp/           Temporary files
    ├── usr/           User programs and data
    │   ├── bin/       User binaries
    │   └── local/     Locally installed software
    └── var/           Variable data (logs, databases)
        └── log/       System and application logs
    ```

    ## Navigation Commands

    ### pwd - Print Working Directory
    ```bash
    pwd
    # Output: /home/user
    ```

    ### ls - List Directory Contents
    ```bash
    # Basic listing
    ls

    # Long format with details
    ls -l

    # Show hidden files (starting with .)
    ls -a

    # Human-readable sizes with -h
    ls -lh

    # Combine options
    ls -lah
    ```

    ### cd - Change Directory
    ```bash
    # Change to home directory
    cd ~
    cd

    # Change to parent directory
    cd ..

    # Change to previous directory
    cd -

    # Absolute path
    cd /var/log

    # Relative path
    cd ../documents
    ```

    ## Path Types

    - **Absolute Path**: Starts from root `/` (e.g., `/home/user/file.txt`)
    - **Relative Path**: Relative to current directory (e.g., `./file.txt`, `../other/`)

    ## Special Path Symbols

    - `.` - Current directory
    - `..` - Parent directory
    - `~` - Home directory
    - `/` - Root directory
    - `-` - Previous directory (with cd)
  MARKDOWN
  reading_time_minutes: 15
)

module1.module_items.create!(item: lesson1_2, sequence_order: 2, required: true)

lesson1_3 = CourseLesson.create!(
  title: "File Operations",
  content: <<~MARKDOWN,
    # File Operations

    ## Creating Directories

    ```bash
    # Create a single directory
    mkdir projects

    # Create nested directories
    mkdir -p projects/docker/configs

    # Create multiple directories
    mkdir dir1 dir2 dir3
    ```

    ## Copying Files and Directories

    ```bash
    # Copy file
    cp source.txt destination.txt

    # Copy to directory
    cp file.txt /home/user/backup/

    # Copy directory recursively
    cp -r source_dir/ destination_dir/

    # Copy with verbose output
    cp -v file.txt backup/

    # Preserve attributes (permissions, timestamps)
    cp -p file.txt backup/
    ```

    ## Moving and Renaming

    ```bash
    # Rename file
    mv oldname.txt newname.txt

    # Move file to directory
    mv file.txt /home/user/documents/

    # Move multiple files
    mv file1.txt file2.txt file3.txt /destination/

    # Move directory
    mv old_dir/ new_location/
    ```

    ## Removing Files and Directories

    ```bash
    # Remove file
    rm file.txt

    # Remove multiple files
    rm file1.txt file2.txt

    # Remove directory and contents
    rm -r directory/

    # Force remove without prompts
    rm -f file.txt

    # Interactive mode (confirm each deletion)
    rm -i *.txt

    # Remove empty directory
    rmdir empty_directory/
    ```

    ## Viewing File Contents

    ```bash
    # Display entire file
    cat file.txt

    # Display with line numbers
    cat -n file.txt

    # View first 10 lines
    head file.txt

    # View first 20 lines
    head -n 20 file.txt

    # View last 10 lines
    tail file.txt

    # Follow file updates (useful for logs)
    tail -f /var/log/app.log

    # Page through file
    less file.txt
    # (Press 'q' to quit, Space for next page)
    ```

    ## Creating Empty Files

    ```bash
    # Create or update timestamp
    touch newfile.txt

    # Create multiple files
    touch file1.txt file2.txt file3.txt
    ```
  MARKDOWN
  reading_time_minutes: 20
)

module1.module_items.create!(item: lesson1_3, sequence_order: 3, required: true)

quiz1 = Quiz.create!(
  title: "Linux Basics Quiz",
  description: "Test your understanding of Linux basics and navigation",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true
)

[
  {
    question_type: "mcq",
    question_text: "Which directory contains user home directories?",
    options: JSON.generate([
      { text: "/home", correct: true },
      { text: "/root", correct: false },
      { text: "/usr", correct: false },
      { text: "/var", correct: false }
    ]),
    explanation: "The /home directory contains subdirectories for each user, e.g., /home/alice, /home/bob",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "command",
    question_text: "What command shows your current directory?",
    correct_answer: "pwd",
    explanation: "'pwd' stands for Print Working Directory and displays the absolute path of your current location",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  },
  {
    question_type: "mcq",
    question_text: "Which command lists files including hidden files?",
    options: JSON.generate([
      { text: "ls", correct: false },
      { text: "ls -a", correct: true },
      { text: "ls -l", correct: false },
      { text: "dir -all", correct: false }
    ]),
    explanation: "The -a flag shows all files, including hidden files that start with a dot (.)",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 3
  },
  {
    question_type: "command",
    question_text: "What command copies file.txt to backup.txt?",
    correct_answer: "cp file.txt backup.txt",
    explanation: "The cp command copies files. Syntax: cp source destination",
    points: 15,
    difficulty_level: "easy",
    sequence_order: 4
  },
  {
    question_type: "true_false",
    question_text: "The '~' symbol represents the user's home directory.",
    correct_answer: "true",
    explanation: "~ is a shortcut for the current user's home directory, typically /home/username",
    points: 5,
    difficulty_level: "easy",
    sequence_order: 5
  }
].each { |q| quiz1.quiz_questions.create!(q) }

module1.module_items.create!(item: quiz1, sequence_order: 4, required: true)

puts "  ✅ Created module: #{module1.title}"

# ========================================
# Module 2: File Permissions & Ownership
# ========================================

module2 = linux_course.course_modules.create!(
  title: "File Permissions & Ownership",
  slug: "file-permissions-ownership",
  description: "Understand and manage file permissions, ownership, and security",
  sequence_order: 2,
  estimated_minutes: 120,
  published: true,
  learning_objectives: JSON.generate([
    "Read and understand Linux file permissions",
    "Use chmod to modify file permissions",
    "Manage file ownership with chown",
    "Apply the principle of least privilege"
  ])
)

lesson2_1 = CourseLesson.create!(
  title: "Understanding Permissions",
  content: <<~MARKDOWN,
    # Understanding File Permissions

    Linux uses a permission system to control access to files and directories.

    ## Permission Types

    Each file has three permission types:
    - **r (read)**: View file contents or list directory
    - **w (write)**: Modify file or directory contents
    - **x (execute)**: Run file as program or access directory

    ## Permission Groups

    Permissions apply to three groups:
    - **Owner (u)**: The user who owns the file
    - **Group (g)**: Users in the file's group
    - **Others (o)**: Everyone else

    ## Reading Permissions

    ```bash
    ls -l file.txt
    # -rw-r--r-- 1 user group 1234 Jan 15 10:00 file.txt
    #  │││ │││ │││
    #  │││ │││ │└─ others permissions (r--)
    #  │││ │└──── group permissions (r--)
    #  │└────── owner permissions (rw-)
    #  └───────── file type (- = regular file, d = directory)
    ```

    ### Permission Breakdown

    | Position | Meaning | Example |
    |----------|---------|---------|
    | 1 | File type | `-` (file), `d` (directory), `l` (link) |
    | 2-4 | Owner permissions | `rw-` (read, write, no execute) |
    | 5-7 | Group permissions | `r--` (read only) |
    | 8-10 | Other permissions | `r--` (read only) |

    ## Numeric (Octal) Permissions

    Permissions can be represented as numbers:
    - **r (read) = 4**
    - **w (write) = 2**
    - **x (execute) = 1**

    Add them together for each group:

    ```
    rwx = 4 + 2 + 1 = 7
    rw- = 4 + 2 + 0 = 6
    r-- = 4 + 0 + 0 = 4
    r-x = 4 + 0 + 1 = 5
    ```

    ### Common Permission Modes

    | Octal | Symbolic | Meaning |
    |-------|----------|---------|
    | 644 | rw-r--r-- | Owner read/write, others read |
    | 755 | rwxr-xr-x | Owner all, others read/execute |
    | 600 | rw------- | Owner read/write only |
    | 700 | rwx------ | Owner all, no access for others |
    | 777 | rwxrwxrwx | Everyone all (dangerous!) |

    ## Changing Permissions with chmod

    ### Symbolic Mode

    ```bash
    # Add execute for owner
    chmod u+x script.sh

    # Remove write for group
    chmod g-w file.txt

    # Set read for others
    chmod o=r file.txt

    # Add read for everyone
    chmod a+r file.txt

    # Multiple changes
    chmod u+x,g-w,o-r file.txt
    ```

    ### Numeric Mode

    ```bash
    # Owner: rw-, Group: r--, Others: r-- (644)
    chmod 644 file.txt

    # Owner: rwx, Group: r-x, Others: r-x (755)
    chmod 755 script.sh

    # Owner: rwx, Group: ---, Others: --- (700)
    chmod 700 private_script.sh

    # Recursive chmod
    chmod -R 755 /var/www/html/
    ```

    ## Changing Ownership

    ```bash
    # Change owner
    sudo chown newuser file.txt

    # Change owner and group
    sudo chown newuser:newgroup file.txt

    # Change group only
    sudo chgrp newgroup file.txt

    # Recursive ownership change
    sudo chown -R user:group /path/to/directory/
    ```

    ## Best Practices

    1. **Principle of Least Privilege**: Grant minimum permissions needed
    2. **Avoid 777**: Never use unless absolutely necessary
    3. **Scripts**: Use 755 for executable scripts
    4. **Config Files**: Use 644 for readable configs, 600 for secrets
    5. **Directories**: Need execute (x) permission to access contents
  MARKDOWN
  reading_time_minutes: 20
)

module2.module_items.create!(item: lesson2_1, sequence_order: 1, required: true)

quiz2 = Quiz.create!(
  title: "Permissions Quiz",
  description: "Test your knowledge of Linux file permissions",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "mcq",
    question_text: "What does the permission 'rwxr-xr--' mean in octal?",
    options: JSON.generate([
      { text: "754", correct: true },
      { text: "644", correct: false },
      { text: "755", correct: false },
      { text: "744", correct: false }
    ]),
    explanation: "rwx = 7, r-x = 5, r-- = 4, so the answer is 754",
    points: 15,
    difficulty_level: "medium",
    sequence_order: 1
  },
  {
    question_type: "command",
    question_text: "Make script.sh executable for the owner",
    correct_answer: "chmod u+x script.sh|chmod +x script.sh",
    explanation: "Use chmod u+x to add execute permission for the owner",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  },
  {
    question_type: "true_false",
    question_text: "A directory needs execute (x) permission to access its contents.",
    correct_answer: "true",
    explanation: "Execute permission on directories allows entering and accessing files within",
    points: 5,
    difficulty_level: "easy",
    sequence_order: 3
  }
].each { |q| quiz2.quiz_questions.create!(q) }

module2.module_items.create!(item: quiz2, sequence_order: 2, required: true)

puts "  ✅ Created module: #{module2.title}"

# ========================================
# Module 3: Text Processing & Streams
# ========================================

module3 = linux_course.course_modules.create!(
  title: "Text Processing & Streams",
  slug: "text-processing-streams",
  description: "Master text manipulation, pipes, and stream redirection",
  sequence_order: 3,
  estimated_minutes: 120,
  published: true,
  learning_objectives: JSON.generate([
    "Use grep to search text patterns",
    "Combine commands with pipes",
    "Redirect input and output streams",
    "Process text with awk, sed, and cut"
  ])
)

lesson3_1 = CourseLesson.create!(
  title: "Searching with grep",
  content: <<~MARKDOWN,
    # Searching with grep

    `grep` (Global Regular Expression Print) searches text for patterns.

    ## Basic Usage

    ```bash
    # Search for pattern in file
    grep "error" logfile.txt

    # Case-insensitive search
    grep -i "error" logfile.txt

    # Show line numbers
    grep -n "error" logfile.txt

    # Invert match (lines NOT matching)
    grep -v "success" logfile.txt

    # Count matches
    grep -c "error" logfile.txt

    # Recursive search in directory
    grep -r "TODO" /path/to/code/

    # Search multiple files
    grep "error" *.log
    ```

    ## Useful Options

    | Option | Description |
    |--------|-------------|
    | -i | Case-insensitive |
    | -n | Show line numbers |
    | -v | Invert match |
    | -c | Count matches |
    | -r | Recursive |
    | -l | Show only filenames |
    | -A 3 | Show 3 lines after match |
    | -B 3 | Show 3 lines before match |
    | -C 3 | Show 3 lines before and after |
  MARKDOWN
  reading_time_minutes: 10
)

module3.module_items.create!(item: lesson3_1, sequence_order: 1, required: true)

lesson3_2 = CourseLesson.create!(
  title: "Pipes and Redirection",
  content: <<~MARKDOWN,
    # Pipes and Redirection

    ## Pipes (|)

    Send output of one command to input of another:

    ```bash
    # List files and search for pattern
    ls -l | grep "txt"

    # Count number of processes
    ps aux | wc -l

    # Find largest files
    du -sh * | sort -hr | head -10

    # Chain multiple commands
    cat access.log | grep "ERROR" | grep "2024" | wc -l
    ```

    ## Output Redirection

    ### Redirect to File (>)

    ```bash
    # Overwrite file with output
    echo "Hello" > file.txt

    # Command output to file
    ls -l > listing.txt

    # Redirect errors (stderr) to file
    command 2> errors.txt

    # Redirect both stdout and stderr
    command > output.txt 2>&1
    command &> output.txt  # Same thing, shorter
    ```

    ### Append to File (>>)

    ```bash
    # Append to file (don't overwrite)
    echo "New line" >> file.txt

    # Append command output
    date >> log.txt
    ```

    ### Input Redirection (<)

    ```bash
    # Read input from file
    wc -l < file.txt

    # Here document
    cat << EOF > config.txt
    Setting1=value1
    Setting2=value2
    EOF
    ```

    ## Standard Streams

    - **stdin (0)**: Standard input
    - **stdout (1)**: Standard output
    - **stderr (2)**: Standard error

    ```bash
    # Redirect stderr to stdout, then pipe
    command 2>&1 | grep "error"

    # Discard output
    command > /dev/null 2>&1
    ```
  MARKDOWN
  reading_time_minutes: 15
)

module3.module_items.create!(item: lesson3_2, sequence_order: 2, required: true)

quiz3 = Quiz.create!(
  title: "Text Processing Quiz",
  description: "Test your text processing and stream skills",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "command",
    question_text: "Search for 'error' case-insensitively in app.log",
    correct_answer: "grep -i error app.log|grep -i \"error\" app.log",
    explanation: "Use grep with -i flag for case-insensitive search",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "mcq",
    question_text: "What does the pipe (|) operator do?",
    options: JSON.generate([
      { text: "Sends output of one command to input of another", correct: true },
      { text: "Runs commands in parallel", correct: false },
      { text: "Redirects to a file", correct: false },
      { text: "Appends to a file", correct: false }
    ]),
    explanation: "The pipe operator chains commands by sending stdout of the left command to stdin of the right command",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  }
].each { |q| quiz3.quiz_questions.create!(q) }

module3.module_items.create!(item: quiz3, sequence_order: 3, required: true)

puts "  ✅ Created module: #{module3.title}"

# ========================================
# Module 4: Process Management
# ========================================

module4 = linux_course.course_modules.create!(
  title: "Process Management",
  slug: "process-management",
  description: "Monitor and control running processes",
  sequence_order: 4,
  estimated_minutes: 90,
  published: true,
  learning_objectives: JSON.generate([
    "View running processes with ps and top",
    "Send signals to processes with kill",
    "Run processes in background and foreground",
    "Understand process hierarchy and PIDs"
  ])
)

lesson4_1 = CourseLesson.create!(
  title: "Working with Processes",
  content: <<~MARKDOWN,
    # Working with Processes

    ## Viewing Processes

    ```bash
    # Show processes for current user
    ps

    # Show all processes
    ps aux

    # Show process tree
    ps auxf
    pstree

    # Interactive process viewer
    top

    # Better top alternative (if installed)
    htop
    ```

    ## Process Information

    ```bash
    # Find process by name
    pgrep nginx
    ps aux | grep nginx

    # Show specific process details
    ps -p 1234 -f
    ```

    ## Managing Processes

    ```bash
    # Run command in background
    long_command &

    # List background jobs
    jobs

    # Bring job to foreground
    fg %1

    # Send job to background
    bg %1

    # Suspend current process
    Ctrl+Z

    # Kill current process
    Ctrl+C
    ```

    ## Killing Processes

    ```bash
    # Graceful shutdown (SIGTERM)
    kill 1234

    # Force kill (SIGKILL)
    kill -9 1234
    kill -KILL 1234

    # Kill by name
    pkill nginx
    killall nginx

    # Kill all processes matching pattern
    pkill -f "python.*server"
    ```

    ## Common Signals

    | Signal | Number | Description |
    |--------|--------|-------------|
    | SIGTERM | 15 | Graceful termination (default) |
    | SIGKILL | 9 | Force kill (cannot be caught) |
    | SIGHUP | 1 | Hangup (reload config) |
    | SIGINT | 2 | Interrupt (Ctrl+C) |
    | SIGSTOP | 19 | Pause process |
    | SIGCONT | 18 | Continue paused process |

    ## Background Processes

    ```bash
    # Run and detach from terminal
    nohup long_command &

    # Output goes to nohup.out by default
    nohup ./script.sh > output.log 2>&1 &
    ```
  MARKDOWN
  reading_time_minutes: 15
)

module4.module_items.create!(item: lesson4_1, sequence_order: 1, required: true)

quiz4 = Quiz.create!(
  title: "Process Management Quiz",
  description: "Test your process management knowledge",
  time_limit_minutes: 10,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "command",
    question_text: "Show all running processes",
    correct_answer: "ps aux|ps -ef",
    explanation: "'ps aux' shows all processes with detailed information",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "mcq",
    question_text: "Which signal forcefully kills a process?",
    options: JSON.generate([
      { text: "SIGKILL (9)", correct: true },
      { text: "SIGTERM (15)", correct: false },
      { text: "SIGHUP (1)", correct: false },
      { text: "SIGINT (2)", correct: false }
    ]),
    explanation: "SIGKILL (9) forcefully terminates a process and cannot be caught or ignored",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  }
].each { |q| quiz4.quiz_questions.create!(q) }

module4.module_items.create!(item: quiz4, sequence_order: 2, required: true)

puts "  ✅ Created module: #{module4.title}"

# ========================================
# Module 5: Networking Basics
# ========================================

module5 = linux_course.course_modules.create!(
  title: "Networking Basics",
  slug: "networking-basics",
  description: "Essential networking commands and concepts",
  sequence_order: 5,
  estimated_minutes: 90,
  published: true,
  learning_objectives: JSON.generate([
    "Check network connectivity with ping and curl",
    "View network configuration with ip and ifconfig",
    "Understand ports and netstat",
    "Transfer files with scp and rsync"
  ])
)

lesson5_1 = CourseLesson.create!(
  title: "Network Commands",
  content: <<~MARKDOWN,
    # Essential Network Commands

    ## Testing Connectivity

    ```bash
    # Ping host
    ping google.com
    ping -c 4 8.8.8.8  # Send 4 packets

    # Test HTTP connectivity
    curl https://example.com

    # Show response headers
    curl -I https://example.com

    # Download file
    curl -O https://example.com/file.zip
    wget https://example.com/file.zip

    # DNS lookup
    nslookup example.com
    dig example.com
    host example.com
    ```

    ## Network Configuration

    ```bash
    # Show network interfaces (modern)
    ip addr show
    ip a

    # Show specific interface
    ip addr show eth0

    # Show routing table
    ip route show

    # Show network statistics
    netstat -i
    ```

    ## Checking Ports

    ```bash
    # Show listening ports
    netstat -tuln
    ss -tuln  # Modern alternative

    # Show which process is using a port
    sudo lsof -i :80
    sudo netstat -tulpn | grep :80

    # Test specific port
    telnet example.com 80
    nc -zv example.com 80
    ```

    ## File Transfer

    ```bash
    # Copy file to remote server
    scp file.txt user@server:/path/

    # Copy from remote to local
    scp user@server:/path/file.txt .

    # Copy directory recursively
    scp -r directory/ user@server:/path/

    # Sync directories (more efficient)
    rsync -avz source/ user@server:/destination/

    # Sync with progress
    rsync -avz --progress source/ dest/
    ```

    ## Common Ports

    | Port | Service |
    |------|---------|
    | 22 | SSH |
    | 80 | HTTP |
    | 443 | HTTPS |
    | 3306 | MySQL |
    | 5432 | PostgreSQL |
    | 6379 | Redis |
    | 27017 | MongoDB |
  MARKDOWN
  reading_time_minutes: 15
)

module5.module_items.create!(item: lesson5_1, sequence_order: 1, required: true)

quiz5 = Quiz.create!(
  title: "Networking Quiz",
  description: "Test your Linux networking knowledge",
  time_limit_minutes: 10,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "command",
    question_text: "Show all network interfaces",
    correct_answer: "ip addr show|ip a|ifconfig",
    explanation: "Use 'ip addr show' or 'ip a' to display network interfaces",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "mcq",
    question_text: "Which port is used for HTTPS?",
    options: JSON.generate([
      { text: "443", correct: true },
      { text: "80", correct: false },
      { text: "22", correct: false },
      { text: "8080", correct: false }
    ]),
    explanation: "HTTPS uses port 443 by default",
    points: 5,
    difficulty_level: "easy",
    sequence_order: 2
  }
].each { |q| quiz5.quiz_questions.create!(q) }

module5.module_items.create!(item: quiz5, sequence_order: 2, required: true)

puts "  ✅ Created module: #{module5.title}"

# ========================================
# Summary
# ========================================

puts "\n✅ Linux Fundamentals Course Seeding Complete!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{linux_course.title}"
puts "📖 Modules: #{linux_course.course_modules.count}"
puts "📝 Lessons: #{CourseLesson.where(id: linux_course.course_modules.flat_map { |m| m.module_items.where(item_type: 'CourseLesson').pluck(:item_id) }).count}"
puts "❓ Quizzes: #{Quiz.where(id: linux_course.course_modules.flat_map { |m| m.module_items.where(item_type: 'Quiz').pluck(:item_id) }).count}"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

# AUTO-GENERATED from linux_fundamentals_course.rb
puts "Creating Microlessons for Linux Basics Navigation..."

module_var = CourseModule.find_by(slug: 'linux-basics-navigation')

# === MICROLESSON 1: Network Commands ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Network Commands',
  content: <<~MARKDOWN,
# Network Commands 🚀

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
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Linux Filesystem Hierarchy ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Linux Filesystem Hierarchy',
  content: <<~MARKDOWN,
# Linux Filesystem Hierarchy 🚀

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
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 2.1: Terminal (create dirs and list)
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'DIR=$(mktemp -d); cd "$DIR" && mkdir -p etc/app && echo hello > etc/app/config && ls -R; rm -rf "$DIR"',
    description: 'Create a nested directory and list it recursively.',
    require_pass: true,
    timeout_sec: 30,
    validation: { must_include: ['etc', 'app', 'config'], must_not_include: ['No such file', 'permission denied'] },
    difficulty: 'easy',
    hints: ['Use mktemp to create a safe temp dir', 'mkdir -p creates nested dirs', 'ls -R lists recursively']
  }
)

# Exercise 2.2: Terminal (create file and inspect)
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'terminal',
  sequence_order: 2,
  exercise_data: {
    command: 'DIR=$(mktemp -d); cd "$DIR" && echo data > file.txt && ls -l file.txt; rm -rf "$DIR"',
    description: 'Create a file and list details with -l.',
    require_pass: true,
    timeout_sec: 30,
    validation: { must_include: ['file.txt'], must_not_include: ['No such file', 'permission denied'] },
    difficulty: 'easy',
    hints: ['echo writes to a file', 'ls -l shows size and permissions']
  }
)
# Exercise 1.1: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Which command shows the current directory?',
    options: ['pwd', 'ls', 'cd', 'echo $PWD'],
    correct_answer: 0,
    explanation: 'pwd prints the present working directory.',
    difficulty: 'easy'
  }
)


# === MICROLESSON 3: File Operations ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'File Operations',
  content: <<~MARKDOWN,
# File Operations 🚀

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
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 4: Understanding Permissions ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Understanding Permissions',
  content: <<~MARKDOWN,
# Understanding Permissions 🚀

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
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)
# Exercise 3.1: MCQ
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Which command shows the current directory?',
    options: ['pwd', 'ls', 'cd', 'echo $PWD'],
    correct_answer: 0,
    explanation: 'pwd prints the present working directory.',
    difficulty: 'easy'
  }
)


# === MICROLESSON 5: Searching with grep ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Searching with grep',
  content: <<~MARKDOWN,
# Searching with grep 🚀

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
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 6: Pipes and Redirection ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Pipes and Redirection',
  content: <<~MARKDOWN,
# Pipes and Redirection 🚀

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
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)
# Exercise 5.1: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Which command shows the current directory?',
    options: ['pwd', 'ls', 'cd', 'echo $PWD'],
    correct_answer: 0,
    explanation: 'pwd prints the present working directory.',
    difficulty: 'easy'
  }
)


# === MICROLESSON 7: Working with Processes ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Working with Processes',
  content: <<~MARKDOWN,
# Working with Processes 🚀

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
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: Network Commands ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Network Commands',
  content: <<~MARKDOWN,
# Network Commands 🚀

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
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)
# Exercise 7.1: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Which command shows the current directory?',
    options: ['pwd', 'ls', 'cd', 'echo $PWD'],
    correct_answer: 0,
    explanation: 'pwd prints the present working directory.',
    difficulty: 'easy'
  }
)


# === MICROLESSON 9: Introduction to Linux ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Linux',
  content: <<~MARKDOWN,
# Introduction to Linux 🚀

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

## Key Points

- Linux operating system

- Shell and terminal

- Linux distributions
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Linux operating system', 'Shell and terminal', 'Linux distributions', 'Basic commands'],
  prerequisite_ids: []
)

# === MICROLESSON 10: Linux Filesystem Hierarchy ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Linux Filesystem Hierarchy',
  content: <<~MARKDOWN,
# Linux Filesystem Hierarchy 🚀

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
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)
# Exercise 9.1: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Which command shows the current directory?',
    options: ['pwd', 'ls', 'cd', 'echo $PWD'],
    correct_answer: 0,
    explanation: 'pwd prints the present working directory.',
    difficulty: 'easy'
  }
)


# === MICROLESSON 11: File Operations ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'File Operations',
  content: <<~MARKDOWN,
# File Operations 🚀

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
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 12: Understanding Permissions ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Understanding Permissions',
  content: <<~MARKDOWN,
# Understanding Permissions 🚀

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
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)
# Exercise 11.1: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Which command shows the current directory?',
    options: ['pwd', 'ls', 'cd', 'echo $PWD'],
    correct_answer: 0,
    explanation: 'pwd prints the present working directory.',
    difficulty: 'easy'
  }
)


# === MICROLESSON 13: Searching with grep ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Searching with grep',
  content: <<~MARKDOWN,
# Searching with grep 🚀

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
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 14: Pipes and Redirection ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Pipes and Redirection',
  content: <<~MARKDOWN,
# Pipes and Redirection 🚀

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
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)
# Exercise 13.1: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Which command shows the current directory?',
    options: ['pwd', 'ls', 'cd', 'echo $PWD'],
    correct_answer: 0,
    explanation: 'pwd prints the present working directory.',
    difficulty: 'easy'
  }
)


# === MICROLESSON 15: Working with Processes ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Working with Processes',
  content: <<~MARKDOWN,
# Working with Processes 🚀

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
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 16: Introduction to Linux ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Linux',
  content: <<~MARKDOWN,
# Introduction to Linux 🚀

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

## Key Points

- Linux operating system

- Shell and terminal

- Linux distributions
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Linux operating system', 'Shell and terminal', 'Linux distributions', 'Basic commands'],
  prerequisite_ids: []
)
# Exercise 15.1: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Which command shows the current directory?',
    options: ['pwd', 'ls', 'cd', 'echo $PWD'],
    correct_answer: 0,
    explanation: 'pwd prints the present working directory.',
    difficulty: 'easy'
  }
)


puts "✓ Created 16 microlessons for Linux Basics Navigation"

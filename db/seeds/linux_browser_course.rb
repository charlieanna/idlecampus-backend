# Browser-Based Linux Fundamentals Course (8 Hours)
# Comprehensive hands-on Linux course delivered entirely through browser-based terminal labs
puts "🐧 Creating Browser-Based Linux Fundamentals Course (8 Hours)..."

linux_browser_course = Course.find_or_create_by!(slug: 'linux-browser-fundamentals') do |course|
  course.title = "Browser-Based Linux Fundamentals"
  course.description = "8-hour hands-on Linux course delivered entirely through the browser using interactive terminal labs. Designed for learners with some command-line experience who need a solid Linux foundation before diving into Docker and Kubernetes. Aligns with CompTIA Linux+ objectives and emphasizes practical skills."
  course.difficulty_level = "beginner"
  course.estimated_hours = 8
  course.certification_track = "linux"
  course.published = true
  course.sequence_order = 15
  course.learning_objectives = JSON.generate([
    "Understand Linux system architecture, kernel, and shell",
    "Navigate the filesystem and manage files/directories confidently",
    "Master user accounts, groups, and file permissions",
    "Monitor and control processes, schedule jobs with cron",
    "Install software packages and manage system services",
    "Configure basic networking and firewalls",
    "Write shell scripts to automate common tasks",
    "Deploy and secure a web service end-to-end"
  ])
  course.prerequisites = JSON.generate([
    "Some command-line experience",
    "Basic understanding of operating systems",
    "Familiarity with text editors"
  ])
end

puts "✓ Course: #{linux_browser_course.title}"

# ==========================================
# MODULE 1: Introduction to Linux and the Shell (60 min)
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'intro-linux-shell', course: linux_browser_course) do |mod|
  mod.title = "Module 1: Introduction to Linux and the Shell"
  mod.description = "Understand what Linux is, its history, and the role of the kernel vs. the shell. Use basic shell commands to navigate the file system and manage files/directories."
  mod.sequence_order = 1
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand what Linux is, its history, and the role of the kernel vs. the shell",
    "Identify major components of a Linux system (boot process, kernel, and file system hierarchy)",
    "Use basic shell commands to navigate the file system and manage files/directories",
    "Utilize the Linux manual pages and --help for finding command usage information"
  ])
end

module1_lesson = CourseLesson.find_or_create_by!(title: "Introduction to Linux and the Shell") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Introduction to Linux and the Shell

    ## Linux Overview

    Linux is an open-source operating system kernel created by Linus Torvalds in 1991. Today, it powers the majority of web servers, cloud infrastructure, containers, and embedded systems worldwide.

    ### Brief History
    - **1969**: Unix developed at AT&T Bell Labs
    - **1991**: Linus Torvalds creates Linux kernel
    - **Today**: Powers billions of devices from smartphones to supercomputers

    ### Why Linux Matters for Containers
    Docker and Kubernetes are built on Linux kernel features:
    - **Namespaces**: Process isolation
    - **Cgroups**: Resource management
    - **Union filesystems**: Efficient container layers

    Understanding Linux is critical since Kubernetes nodes usually run Linux.

    ### Open Source Philosophy
    - Free to use, modify, and distribute
    - Community-driven development
    - Transparent security (anyone can audit code)
    - Thousands of distributions for different needs

    ### Common Linux Distributions
    | Distribution | Use Case | Package Manager |
    |-------------|----------|----------------|
    | **Ubuntu** | Servers, desktops, beginners | apt |
    | **Red Hat Enterprise Linux (RHEL)** | Enterprise servers | yum/dnf |
    | **CentOS** | RHEL clone for servers | yum/dnf |
    | **Debian** | Stable servers | apt |
    | **Alpine** | Minimal Docker images | apk |
    | **Amazon Linux** | AWS-optimized | yum |

    ## The Linux Kernel vs. The Shell

    ### The Kernel
    The kernel is the core of Linux that:
    - Manages hardware resources (CPU, memory, storage, network)
    - Handles process scheduling
    - Controls file systems
    - Manages security and permissions
    - Provides system calls for applications

    ### The Shell
    The shell is a command-line interface that allows users to communicate with the kernel:
    - **bash** (Bourne Again Shell): Most common default shell
    - **sh** (Bourne Shell): Basic POSIX-compliant shell
    - **zsh**: Enhanced shell with advanced features
    - **fish**: User-friendly shell with auto-suggestions

    ## Linux Boot Process

    Understanding the boot process helps with troubleshooting:

    1. **BIOS/UEFI**: Hardware initialization, finds bootloader
    2. **Bootloader (GRUB)**: Loads Linux kernel into memory
    3. **Kernel Initialization**: Mounts root filesystem, starts init
    4. **Init System (systemd)**: Starts system services and daemons
    5. **Login Prompt**: System ready for user login

    ## Linux Filesystem Hierarchy

    Linux uses a single inverted tree structure starting at root `/`:

    ```
    /
    ├── bin/     # Essential user binaries (ls, cp, mv)
    ├── boot/    # Boot loader files, kernel
    ├── dev/     # Device files (disks, terminals)
    ├── etc/     # System configuration files
    ├── home/    # User home directories
    ├── lib/     # Shared libraries
    ├── opt/     # Optional software packages
    ├── proc/    # Process and kernel info (virtual)
    ├── root/    # Root user home directory
    ├── sbin/    # System administration binaries
    ├── tmp/     # Temporary files
    ├── usr/     # User programs and data
    └── var/     # Variable data (logs, databases)
    ```

    ## Shell Basics

    ### The Shell Prompt
    ```bash
    user@hostname:~$
    ```
    - `user`: Current username
    - `hostname`: Machine name
    - `~`: Current directory (~ means home)
    - `$`: Regular user (# for root)

    ### Command Structure
    ```
    command [options] [arguments]
    ```

    Example:
    ```bash
    ls -la /home
    ```
    - `ls`: Command (list directory contents)
    - `-la`: Options (long format + all files)
    - `/home`: Argument (directory to list)

    ### Essential Navigation Commands

    | Command | Description | Example |
    |---------|-------------|---------|
    | `pwd` | Print working directory | `pwd` |
    | `ls` | List directory contents | `ls -l` |
    | `cd` | Change directory | `cd /etc` |
    | `whoami` | Display current user | `whoami` |
    | `uname` | System information | `uname -a` |

    ### Shell Features
    - **Tab Completion**: Press Tab to auto-complete commands/paths
    - **Command History**: Up/Down arrows to recall previous commands
    - **Command History Search**: `Ctrl+R` to search history
    - **Clear Screen**: `Ctrl+L` or `clear` command
    - **Stop Command**: `Ctrl+C` to interrupt running command

    ## Using Help & Manual Pages

    ### The `man` Command
    Linux has built-in documentation called "man pages" (manual pages):

    ```bash
    man ls        # View manual for ls command
    man passwd    # View manual for passwd command
    man man       # View manual for man itself
    ```

    **Navigation in man pages:**
    - Space: Next page
    - b: Previous page
    - /pattern: Search forward
    - n: Next search result
    - q: Quit

    ### The `--help` Option
    Most commands support `--help` for quick reference:

    ```bash
    ls --help
    cp --help
    mkdir --help
    ```

    ### The `info` Command
    Some programs have more detailed info pages:

    ```bash
    info coreutils
    ```

    ## Environment Variables

    Environment variables affect how commands execute:

    ```bash
    # View all environment variables
    env

    # View specific variable
    echo $HOME      # User home directory
    echo $PATH      # Command search path
    echo $USER      # Current username
    echo $SHELL     # Current shell

    # Set environment variable
    export MY_VAR="hello"
    echo $MY_VAR
    ```

    ### Important Environment Variables
    - **PATH**: Directories to search for commands
    - **HOME**: User's home directory
    - **USER**: Current username
    - **SHELL**: Current shell program
    - **PWD**: Current working directory

    ## Text Editors in Linux

    You'll need a text editor for configuration files and scripts:

    ### nano (Beginner-friendly)
    ```bash
    nano filename.txt
    ```
    - `Ctrl+O`: Save (Write Out)
    - `Ctrl+X`: Exit
    - `Ctrl+K`: Cut line
    - `Ctrl+U`: Paste

    ### vi/vim (Powerful but steep learning curve)
    ```bash
    vi filename.txt
    ```
    - Press `i` to enter INSERT mode
    - Press `Esc` to return to COMMAND mode
    - `:w` to save
    - `:q` to quit
    - `:wq` to save and quit

    ## Summary

    In this module, you learned:
    - Linux is an open-source kernel powering servers, containers, and cloud
    - The kernel manages hardware; the shell is your interface
    - Linux uses a hierarchical filesystem starting at /
    - Basic commands: pwd, ls, cd, whoami, uname
    - How to use man pages and --help for documentation
    - Environment variables like $PATH affect command execution
  MARKDOWN
end

module1_lab = HandsOnLab.find_or_create_by!(title: "Linux Shell Basics Lab") do |lab|
  lab.description = "Practice basic Linux commands, navigate the filesystem, and use manual pages in a live terminal environment."
  lab.difficulty = "easy"
  lab.lab_type = "linux"
  lab.lab_format = "terminal"
  lab.estimated_minutes = 20
  lab.prerequisites = JSON.generate([])
  lab.learning_objectives = JSON.generate([
    "Use basic Linux commands to display system information",
    "Navigate the filesystem with pwd, cd, ls",
    "View and understand man pages",
    "Create and manipulate files using touch, echo, cat, rm",
    "Practice shell shortcuts and command history"
  ])
  lab.steps = JSON.generate([
    {
      title: "System Information",
      instruction: "Display the Linux kernel version, distribution info, and system uptime",
      commands: ["uname -r", "cat /etc/os-release", "uptime"],
      expected_output: "Kernel version, OS distribution name/version, and system uptime"
    },
    {
      title: "Navigation Practice",
      instruction: "Practice navigation commands to understand your current location and move between directories",
      commands: ["pwd", "ls -l", "cd /", "ls", "cd ~", "ls", "cd ..", "pwd"],
      expected_output: "Ability to determine current directory and navigate the filesystem"
    },
    {
      title: "Using Man Pages",
      instruction: "Open the manual page for the ls command, find the -a option description, then exit",
      commands: ["man ls", "# (scroll to find -a option)", "# (press q to quit)"],
      expected_output: "Understanding that ls -a shows hidden files (those starting with .)"
    },
    {
      title: "Test Hidden Files Option",
      instruction: "Use ls -a to display all files including hidden ones in your home directory",
      commands: ["cd ~", "ls -a"],
      expected_output: "List showing hidden files like .bashrc, .profile"
    },
    {
      title: "Basic File Operations",
      instruction: "Create a file, write content to it, view it, and delete it",
      commands: [
        "touch testfile.txt",
        "ls",
        "echo 'Hello Linux' > testfile.txt",
        "cat testfile.txt",
        "rm testfile.txt",
        "ls"
      ],
      expected_output: "File created, content written, displayed, and removed successfully"
    },
    {
      title: "Shell Shortcuts",
      instruction: "Practice command history and auto-completion",
      commands: [
        "history",
        "# (press Up arrow to recall last command)",
        "# (type 'una' and press Tab to auto-complete to 'uname')",
        "uname -a"
      ],
      expected_output: "Command history displayed, auto-completion working"
    }
  ])
end

module1_quiz = Quiz.find_or_create_by!(title: "Module 1 Quiz: Linux and Shell Basics") do |quiz|
  quiz.description = "Test your understanding of Linux fundamentals, the shell, and basic commands"
  quiz.time_limit_minutes = 10
  quiz.passing_score = 80
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

q1_1 = QuizQuestion.find_or_create_by!(quiz: module1_quiz, question_order: 1) do |q|
  q.question_text = "What component of Linux interacts directly with the hardware and manages resources?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "The shell", correct: false },
    { text: "The kernel", correct: true },
    { text: "The bootloader", correct: false },
    { text: "The terminal", correct: false }
  ])
  q.explanation = "The kernel is the core of Linux that interacts with hardware and manages resources (CPU, memory, storage). The shell is the interface that allows users to communicate with the kernel."
end

q1_2 = QuizQuestion.find_or_create_by!(quiz: module1_quiz, question_order: 2) do |q|
  q.question_text = "Which command would you use to find out your current working directory?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "cd", correct: false },
    { text: "ls", correct: false },
    { text: "pwd", correct: true },
    { text: "whoami", correct: false }
  ])
  q.explanation = "pwd (print working directory) displays the full path of your current directory. cd changes directories, ls lists contents, and whoami shows your username."
end

q1_3 = QuizQuestion.find_or_create_by!(quiz: module1_quiz, question_order: 3) do |q|
  q.question_text = "How can you display a list of files, including hidden files, in a directory?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "ls", correct: false },
    { text: "ls -l", correct: false },
    { text: "ls -a", correct: true },
    { text: "ls --all-files", correct: false }
  ])
  q.explanation = "ls -a lists all files including hidden files (those starting with .). The -l option shows long format with details, but doesn't show hidden files by itself."
end

q1_4 = QuizQuestion.find_or_create_by!(quiz: module1_quiz, question_order: 4) do |q|
  q.question_text = "If you're not sure how to use a command or what options it supports, what built-in resource can you use to learn more?"
  q.question_type = "multiple_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "man pages (man command)", correct: true },
    { text: "The --help option", correct: true },
    { text: "info pages (info command)", correct: true },
    { text: "Google search", correct: false }
  ])
  q.explanation = "Linux provides built-in documentation through man pages (man ls), the --help option (ls --help), and info pages (info coreutils). While online searches help, the built-in resources are the primary documentation."
end

q1_5 = QuizQuestion.find_or_create_by!(quiz: module1_quiz, question_order: 5) do |q|
  q.question_text = "True or False: Linux commands are case-sensitive, and LS is the same as ls."
  q.question_type = "true_false"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "True", correct: false },
    { text: "False", correct: true }
  ])
  q.explanation = "False. Linux is case-sensitive, so LS would not work for listing files. The correct command is lowercase ls. Filenames, commands, and paths are all case-sensitive in Linux."
end

# Link items to module
module1.module_items.find_or_create_by!(item: module1_lesson, sequence_order: 1) { |mi| mi.required = true }
module1.module_items.find_or_create_by!(item: module1_lab, sequence_order: 2) { |mi| mi.required = true }
module1.module_items.find_or_create_by!(item: module1_quiz, sequence_order: 3) { |mi| mi.required = true }

puts "  ✓ Module 1: Introduction to Linux and the Shell"

# ==========================================
# MODULE 2: Navigating the Filesystem and Managing Files (60 min)
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'filesystem-file-management', course: linux_browser_course) do |mod|
  mod.title = "Module 2: Navigating the Filesystem and Managing Files"
  mod.description = "Master the Linux filesystem hierarchy, file types, and common file operations. Learn to view, search, archive, and compress files."
  mod.sequence_order = 2
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand the Linux filesystem hierarchy and important directories",
    "Identify different file types and list files with their attributes",
    "Perform common file operations: create, copy, move, rename, and delete",
    "Use file-viewing and text-processing commands to inspect and search content",
    "Create archives and compressed files for backup or transfer"
  ])
end

module2_lesson = CourseLesson.find_or_create_by!(title: "Linux Filesystem and File Management") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Navigating the Filesystem and Managing Files

    ## Linux Filesystem Hierarchy Standard (FHS)

    Linux organizes files in a single inverted tree structure starting at the root directory `/`. Understanding this structure helps you navigate and find things quickly.

    ### Important Directories

    | Directory | Purpose | Examples |
    |-----------|---------|----------|
    | `/` | Root of filesystem | All other directories branch from here |
    | `/home` | User home directories | `/home/alice`, `/home/bob` |
    | `/etc` | System configuration files | `/etc/passwd`, `/etc/network/interfaces` |
    | `/var` | Variable data (logs, databases) | `/var/log`, `/var/www` |
    | `/usr` | User programs and data | `/usr/bin`, `/usr/local` |
    | `/bin` | Essential user binaries | `ls`, `cp`, `mv`, `cat` |
    | `/sbin` | System administration binaries | `ifconfig`, `reboot`, `fdisk` |
    | `/tmp` | Temporary files (cleared on reboot) | Session files, temp downloads |
    | `/dev` | Device files | `/dev/sda` (hard drive), `/dev/tty` (terminal) |
    | `/proc` | Process and kernel info (virtual) | `/proc/cpuinfo`, `/proc/meminfo` |
    | `/boot` | Boot loader files, kernel | `/boot/vmlinuz`, `/boot/grub` |
    | `/lib` | Shared libraries | System libraries needed by binaries |
    | `/opt` | Optional software packages | Third-party applications |
    | `/root` | Root user home directory | Not in `/home` for security |

    ### Path Types

    **Absolute Path**: Starts from root `/`
    ```bash
    /home/user/documents/report.txt
    /etc/nginx/nginx.conf
    ```

    **Relative Path**: Relative to current directory
    ```bash
    documents/report.txt    # Relative to current location
    ../other_user/file.txt  # Go up one level, then down
    ./script.sh             # Current directory
    ```

    **Special Path Shortcuts**
    - `.` = Current directory
    - `..` = Parent directory
    - `~` = Home directory
    - `-` = Previous directory

    ```bash
    cd ~        # Go to home directory
    cd ..       # Go up one level
    cd -        # Return to previous directory
    cd ~/docs   # Go to docs in home directory
    ```

    ## File Types in Linux

    Linux has several file types:

    | Symbol | Type | Description |
    |--------|------|-------------|
    | `-` | Regular file | Text, binary, executable |
    | `d` | Directory | Container for files |
    | `l` | Symbolic link | Pointer to another file |
    | `b` | Block device | Hard drives, USB drives |
    | `c` | Character device | Terminals, serial ports |
    | `p` | Named pipe | Inter-process communication |
    | `s` | Socket | Network communication |

    View file type with `ls -l`:
    ```bash
    $ ls -l
    drwxr-xr-x  2 user group 4096 Nov  5 10:00 mydir
    -rw-r--r--  1 user group  100 Nov  5 10:00 file.txt
    lrwxrwxrwx  1 user group    8 Nov  5 10:00 link -> file.txt
    ```

    ## Managing Files and Directories

    ### Creating Directories

    ```bash
    mkdir mydir                    # Create directory
    mkdir -p path/to/nested/dir    # Create nested directories
    mkdir dir1 dir2 dir3           # Create multiple directories
    ```

    ### Creating Files

    ```bash
    touch newfile.txt              # Create empty file or update timestamp
    touch file1.txt file2.txt      # Create multiple files
    ```

    ### Copying Files

    ```bash
    cp source.txt dest.txt         # Copy file
    cp -r dir1/ dir2/              # Copy directory recursively
    cp -v file.txt backup.txt      # Verbose output
    cp -i file.txt existing.txt    # Interactive (prompt before overwrite)
    ```

    ### Moving and Renaming

    ```bash
    mv oldname.txt newname.txt     # Rename file
    mv file.txt /home/user/        # Move file
    mv dir1/ dir2/                 # Move/rename directory
    mv -i file.txt existing.txt    # Interactive mode
    ```

    ### Deleting Files and Directories

    ```bash
    rm file.txt                    # Delete file
    rm -i file.txt                 # Interactive (prompt before delete)
    rm -f file.txt                 # Force delete (no prompt)
    rm -r dir/                     # Delete directory recursively
    rm -rf dir/                    # Force recursive delete (DANGEROUS!)
    rmdir emptydir/                # Delete empty directory only
    ```

    ⚠️ **Warning**: `rm` is permanent! There is no recycle bin. Use `-i` for safety.

    ### Wildcards (Globbing)

    Match multiple files with patterns:

    ```bash
    *                # Matches any characters
    ?                # Matches single character
    [abc]            # Matches a, b, or c
    [0-9]            # Matches any digit
    [!abc]           # Matches anything except a, b, c

    # Examples
    ls *.txt         # All .txt files
    ls file?.txt     # file1.txt, fileA.txt
    ls [A-Z]*.txt    # Files starting with uppercase
    rm temp*         # Delete all files starting with "temp"
    ```

    ## Viewing File Contents

    ### cat - Concatenate and Display

    ```bash
    cat file.txt                   # Display entire file
    cat file1.txt file2.txt        # Display multiple files
    cat file1.txt file2.txt > combined.txt  # Combine files
    ```

    ### head - View Beginning

    ```bash
    head file.txt                  # First 10 lines
    head -n 5 file.txt             # First 5 lines
    head -20 file.txt              # First 20 lines
    ```

    ### tail - View End

    ```bash
    tail file.txt                  # Last 10 lines
    tail -n 20 file.txt            # Last 20 lines
    tail -f /var/log/syslog        # Follow log file (watch new lines)
    ```

    ### less - Paged Viewing

    ```bash
    less file.txt                  # View file page by page
    # Space: next page
    # b: previous page
    # /pattern: search
    # q: quit
    ```

    ### grep - Search Text

    ```bash
    grep "pattern" file.txt        # Search for pattern
    grep -i "pattern" file.txt     # Case-insensitive search
    grep -r "pattern" dir/         # Recursive search in directory
    grep -n "pattern" file.txt     # Show line numbers
    grep -v "pattern" file.txt     # Invert match (lines NOT matching)
    grep "root" /etc/passwd        # Find all users with "root"
    ```

    ## Archiving and Compression

    ### tar - Tape Archive

    Create archives (bundles of files):

    ```bash
    # Create archive
    tar -cvf archive.tar files/    # Create tar archive
    tar -czvf archive.tar.gz files/  # Create + compress with gzip
    tar -cjvf archive.tar.bz2 files/ # Create + compress with bzip2

    # Extract archive
    tar -xvf archive.tar           # Extract tar
    tar -xzvf archive.tar.gz       # Extract gzip compressed
    tar -xjvf archive.tar.bz2      # Extract bzip2 compressed

    # List contents
    tar -tvf archive.tar           # List contents without extracting
    ```

    **tar options:**
    - `c`: Create archive
    - `x`: Extract archive
    - `v`: Verbose (show files)
    - `f`: File (specify filename)
    - `z`: gzip compression
    - `j`: bzip2 compression

    ### gzip - Compress Files

    ```bash
    gzip file.txt                  # Compress (creates file.txt.gz, removes original)
    gzip -k file.txt               # Keep original file
    gunzip file.txt.gz             # Decompress
    gzip -d file.txt.gz            # Decompress (same as gunzip)
    ```

    ### zip/unzip - Zip Archives

    ```bash
    zip archive.zip file1.txt file2.txt  # Create zip
    zip -r archive.zip directory/        # Zip directory recursively
    unzip archive.zip                    # Extract zip
    unzip -l archive.zip                 # List contents
    ```

    ## File Metadata

    ### Checking File Information

    ```bash
    file filename                  # Determine file type
    stat filename                  # Detailed file statistics
    du -h file.txt                 # Disk usage (human-readable)
    du -sh directory/              # Total size of directory
    df -h                          # Disk space of filesystems
    ```

    ### Finding Files

    ```bash
    find /path -name "filename"    # Find by name
    find /home -name "*.txt"       # Find all .txt files
    find /var -type f -size +100M  # Find files larger than 100MB
    find /tmp -mtime -7            # Files modified in last 7 days
    ```

    ## Summary

    In this module, you learned:
    - Linux filesystem hierarchy and important directories (/etc, /home, /var, etc.)
    - How to create, copy, move, and delete files and directories
    - Viewing file contents with cat, head, tail, less
    - Searching text with grep
    - Creating archives and compressing files with tar, gzip, zip
    - Understanding file types and metadata
  MARKDOWN
end

module2_lab = HandsOnLab.find_or_create_by!(title: "Filesystem Navigation and File Operations Lab") do |lab|
  lab.description = "Practice navigating the Linux filesystem, creating and manipulating files, viewing content, and creating archives."
  lab.difficulty = "easy"
  lab.lab_type = "linux"
  lab.lab_format = "terminal"
  lab.estimated_minutes = 25
  lab.prerequisites = JSON.generate(["Module 1 completed"])
  lab.learning_objectives = JSON.generate([
    "Navigate the Linux filesystem hierarchy",
    "Create, copy, move, rename, and delete files and directories",
    "View and search file contents",
    "Create and extract tar archives with compression"
  ])
  lab.steps = JSON.generate([
    {
      title: "Explore the Filesystem",
      instruction: "Navigate to root and identify important directories, then explore your home directory",
      commands: [
        "cd /",
        "ls -l",
        "cd /home",
        "cd ~",
        "ls -a"
      ],
      expected_output: "Understanding of root filesystem structure and hidden files in home directory"
    },
    {
      title: "File Creation & Deletion",
      instruction: "Create a directory, create files in it, and practice deleting files",
      commands: [
        "mkdir labfiles",
        "cd labfiles",
        "touch file1.txt file2.txt",
        "ls -l",
        "rm file2.txt",
        "ls"
      ],
      expected_output: "Directory created, files created and deleted successfully"
    },
    {
      title: "Copying and Moving Files",
      instruction: "Practice copying files, creating subdirectories, and moving files between directories",
      commands: [
        "echo 'Sample text' > file1.txt",
        "cp file1.txt file1_copy.txt",
        "mkdir subdir",
        "mv file1_copy.txt subdir/",
        "ls subdir",
        "mv file1.txt renamed.txt",
        "ls"
      ],
      expected_output: "Files copied, moved to subdirectory, and renamed successfully"
    },
    {
      title: "Viewing & Searching Content",
      instruction: "Add content to files and practice viewing and searching",
      commands: [
        "cat renamed.txt",
        "echo 'Another line' >> renamed.txt",
        "head -n1 renamed.txt",
        "tail -n1 renamed.txt",
        "grep 'Sample' renamed.txt",
        "grep '/bin/bash' /etc/passwd"
      ],
      expected_output: "File contents displayed, grep finds matching lines"
    },
    {
      title: "Archiving and Compressing",
      instruction: "Create a compressed archive of your lab files",
      commands: [
        "cd ~",
        "tar -cvf labfiles.tar labfiles/",
        "ls -lh labfiles.tar",
        "gzip labfiles.tar",
        "ls -lh labfiles.tar.gz",
        "tar -xzvf labfiles.tar.gz",
        "ls labfiles/"
      ],
      expected_output: "Archive created, compressed, and extracted successfully"
    }
  ])
end

module2_quiz = Quiz.find_or_create_by!(title: "Module 2 Quiz: Filesystem and File Management") do |quiz|
  quiz.description = "Test your knowledge of the Linux filesystem hierarchy, file operations, and archiving"
  quiz.time_limit_minutes = 10
  quiz.passing_score = 80
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

q2_1 = QuizQuestion.find_or_create_by!(quiz: module2_quiz, question_order: 1) do |q|
  q.question_text = "Which directory is the root of the Linux filesystem, from which all other directories branch?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "/root", correct: false },
    { text: "/home", correct: false },
    { text: "/", correct: true },
    { text: "/etc", correct: false }
  ])
  q.explanation = "The root of the filesystem is / (a single forward slash). All other directories branch from this point. Don't confuse this with /root, which is the root user's home directory."
end

q2_2 = QuizQuestion.find_or_create_by!(quiz: module2_quiz, question_order: 2) do |q|
  q.question_text = "Where are system configuration files typically stored?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "/home", correct: false },
    { text: "/etc", correct: true },
    { text: "/var", correct: false },
    { text: "/usr", correct: false }
  ])
  q.explanation = "Most system configuration files reside in /etc (for example, network config, user accounts, application settings). /var contains variable data like logs, /home has user directories, and /usr contains user programs."
end

q2_3 = QuizQuestion.find_or_create_by!(quiz: module2_quiz, question_order: 3) do |q|
  q.question_text = "What command would you use to copy a file named report.txt to a directory /backup/docs/?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "mv report.txt /backup/docs/", correct: false },
    { text: "cp report.txt /backup/docs/", correct: true },
    { text: "copy report.txt /backup/docs/", correct: false },
    { text: "move report.txt /backup/docs/", correct: false }
  ])
  q.explanation = "Use cp (copy) to duplicate files: cp report.txt /backup/docs/. The mv command moves (or renames) files instead of copying them. 'copy' and 'move' are not valid Linux commands."
end

q2_4 = QuizQuestion.find_or_create_by!(quiz: module2_quiz, question_order: 4) do |q|
  q.question_text = "How do you display the contents of a text file one page at a time, allowing you to scroll?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "cat filename", correct: false },
    { text: "head filename", correct: false },
    { text: "less filename", correct: true },
    { text: "grep filename", correct: false }
  ])
  q.explanation = "Use less to view a file page by page with scrolling capability. cat displays the entire file at once, head shows only the beginning, and grep searches for patterns."
end

q2_5 = QuizQuestion.find_or_create_by!(quiz: module2_quiz, question_order: 5) do |q|
  q.question_text = "What is the purpose of the tar command in Linux?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "To compress files", correct: false },
    { text: "To archive multiple files into a single file", correct: true },
    { text: "To encrypt files", correct: false },
    { text: "To transfer files over network", correct: false }
  ])
  q.explanation = "tar (tape archive) bundles multiple files and directories into a single archive file. While it's often combined with compression (gzip/bzip2), tar itself doesn't compress. It just creates an archive."
end

# Link items to module
module2.module_items.find_or_create_by!(item: module2_lesson, sequence_order: 1) { |mi| mi.required = true }
module2.module_items.find_or_create_by!(item: module2_lab, sequence_order: 2) { |mi| mi.required = true }
module2.module_items.find_or_create_by!(item: module2_quiz, sequence_order: 3) { |mi| mi.required = true }

puts "  ✓ Module 2: Navigating the Filesystem and Managing Files"

# ==========================================
# MODULE 3: User and Permission Management (60 min)
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'user-permission-management', course: linux_browser_course) do |mod|
  mod.title = "Module 3: User and Permission Management"
  mod.description = "Understand Linux's multi-user model, create and manage user accounts and groups, interpret and modify file permissions, and use sudo for privilege escalation."
  mod.sequence_order = 3
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand Linux's multi-user model and the roles of users and groups",
    "Create, modify, and remove user accounts and groups",
    "Interpret and modify file permissions (read, write, execute)",
    "Change file ownership and group ownership",
    "Utilize sudo for privilege escalation safely"
  ])
end

module3_lesson = CourseLesson.find_or_create_by!(title: "Users, Groups, and Permissions") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # User and Permission Management

    ## Linux Multi-User Model

    Linux is a multi-user operating system designed to allow multiple users to work simultaneously while maintaining security and isolation.

    ### Users

    **Regular Users**:
    - Limited permissions
    - Own home directory (`/home/username`)
    - Cannot modify system files
    - UID (User ID) typically starts at 1000

    **Root User (superuser)**:
    - Complete system control
    - UID = 0
    - Can do anything (including break the system!)
    - Login as root directly is often disabled for security

    **System Users**:
    - Run services and daemons
    - No login shell
    - Examples: `www-data` (web server), `mysql`, `nobody`

    ### User Information Files

    | File | Purpose | Readable By |
    |------|---------|-------------|
    | `/etc/passwd` | User account information | Everyone |
    | `/etc/shadow` | Encrypted passwords and password policies | Root only |
    | `/etc/group` | Group information | Everyone |

    #### /etc/passwd Format
    ```
    username:x:UID:GID:comment:home_dir:shell
    alice:x:1001:1001:Alice Smith:/home/alice:/bin/bash
    ```

    #### /etc/group Format
    ```
    group_name:x:GID:member_list
    developers:x:1005:alice,bob
    ```

    ## Groups

    Groups allow collective permission management:
    - **Primary Group**: User's default group (usually same name as username)
    - **Supplementary Groups**: Additional groups user belongs to

    ```bash
    # View user's groups
    groups username
    id username

    # Example output
    $ id alice
    uid=1001(alice) gid=1001(alice) groups=1001(alice),27(sudo),1005(developers)
    ```

    ## User Management Commands

    ### Creating Users

    ```bash
    # Ubuntu/Debian (interactive)
    sudo adduser alice

    # RHEL/CentOS or manual
    sudo useradd -m -s /bin/bash alice
    sudo passwd alice

    # Options
    -m    # Create home directory
    -s    # Specify shell
    -G    # Add to supplementary groups
    -c    # Add comment (full name)
    ```

    ### Modifying Users

    ```bash
    # Change user password
    sudo passwd alice

    # Add user to group
    sudo usermod -aG developers alice

    # Change user's shell
    sudo usermod -s /bin/zsh alice

    # Lock/unlock user account
    sudo usermod -L alice    # Lock
    sudo usermod -U alice    # Unlock
    ```

    ### Deleting Users

    ```bash
    # Delete user but keep home directory
    sudo userdel alice

    # Delete user and home directory
    sudo userdel -r alice
    ```

    ### Group Management

    ```bash
    # Create group
    sudo groupadd developers

    # Delete group
    sudo groupdel developers

    # Change group password (rarely used)
    sudo gpasswd developers
    ```

    ## File Permissions

    Linux permissions determine who can read, write, or execute files.

    ### Permission Types

    | Permission | Files | Directories |
    |-----------|-------|-------------|
    | **r** (read) | View file contents | List directory contents |
    | **w** (write) | Modify file contents | Create/delete files in directory |
    | **x** (execute) | Execute file as program | Enter (cd into) directory |

    ### Permission Groups

    Every file has three permission groups:
    1. **Owner (u)**: The user who owns the file
    2. **Group (g)**: Members of the file's group
    3. **Others (o)**: Everyone else

    ### Reading ls -l Output

    ```bash
    $ ls -l
    -rw-r--r--  1 alice developers  1024 Nov  5 10:00 report.txt
    drwxr-xr-x  2 alice developers  4096 Nov  5 10:00 mydir
    lrwxrwxrwx  1 alice developers    10 Nov  5 10:00 link -> target
    │││││││││
    │└┴┴┴┴┴┴┴┴ Permissions
    └────────── File type
    ```

    **Breaking down permissions: `-rw-r--r--`**

    ```
    -        rw-      r--      r--
    │        │        │        │
    │        │        │        └─ Others: read only
    │        │        └────────── Group: read only
    │        └─────────────────── Owner: read + write
    └──────────────────────────── File type (- = regular file)
    ```

    **File types:**
    - `-` = Regular file
    - `d` = Directory
    - `l` = Symbolic link
    - `b` = Block device
    - `c` = Character device

    ### Permission Notation

    **Symbolic (rwx)**:
    - `rwx` = read, write, execute (all permissions)
    - `rw-` = read and write only
    - `r--` = read only
    - `---` = no permissions

    **Octal (numeric)**:
    - r = 4
    - w = 2
    - x = 1

    | Octal | Binary | Symbolic | Meaning |
    |-------|--------|----------|---------|
    | 7 | 111 | rwx | Read + write + execute |
    | 6 | 110 | rw- | Read + write |
    | 5 | 101 | r-x | Read + execute |
    | 4 | 100 | r-- | Read only |
    | 3 | 011 | -wx | Write + execute |
    | 2 | 010 | -w- | Write only |
    | 1 | 001 | --x | Execute only |
    | 0 | 000 | --- | No permissions |

    **Common permission combinations:**
    - `644` (`rw-r--r--`): Files readable by all, writable by owner
    - `755` (`rwxr-xr-x`): Executables/directories accessible by all
    - `600` (`rw-------`): Private files (owner only)
    - `700` (`rwx------`): Private directories/executables
    - `777` (`rwxrwxrwx`): All permissions for everyone (insecure!)

    ## Changing Permissions (chmod)

    ### Symbolic Mode

    ```bash
    chmod u+x file.sh        # Add execute for owner
    chmod g+w file.txt       # Add write for group
    chmod o-r file.txt       # Remove read for others
    chmod a+r file.txt       # Add read for all (u+g+o)
    chmod u=rwx,g=rx,o=r file.txt  # Set exact permissions

    # Recursively change directory
    chmod -R 755 /var/www
    ```

    **Format**: `chmod [who][+/-/=][permissions] file`
    - Who: `u` (user), `g` (group), `o` (others), `a` (all)
    - Operation: `+` (add), `-` (remove), `=` (set exactly)
    - Permissions: `r`, `w`, `x`

    ### Octal Mode

    ```bash
    chmod 644 file.txt       # rw-r--r--
    chmod 755 script.sh      # rwxr-xr-x
    chmod 600 secret.txt     # rw-------
    chmod 777 public.sh      # rwxrwxrwx (avoid this!)
    ```

    ## Changing Ownership

    ### chown - Change Owner

    ```bash
    # Change owner
    sudo chown alice file.txt

    # Change owner and group
    sudo chown alice:developers file.txt

    # Change owner recursively
    sudo chown -R alice:developers /var/www
    ```

    ### chgrp - Change Group

    ```bash
    # Change group only
    sudo chgrp developers file.txt

    # Recursive
    sudo chgrp -R developers /shared/projects
    ```

    ## Sudo - Superuser Do

    Instead of logging in as root, use `sudo` to run specific commands with elevated privileges.

    ### Why sudo?

    ✅ **Benefits**:
    - Accountability (logs who ran what)
    - Limited privilege escalation
    - Doesn't require sharing root password
    - Can grant granular permissions

    ❌ **Risks of direct root login**:
    - One mistake can break the system
    - No audit trail
    - Can't restrict which commands

    ### Using sudo

    ```bash
    # Run single command as root
    sudo apt update
    sudo systemctl restart nginx
    sudo nano /etc/hosts

    # Open shell as root (use sparingly)
    sudo -i          # Root shell with root environment
    sudo -s          # Root shell with current environment

    # Run command as another user
    sudo -u alice cat /home/alice/file.txt
    ```

    ### sudo Configuration

    Users must be in the `sudo` group (Ubuntu/Debian) or `wheel` group (RHEL/CentOS):

    ```bash
    # Add user to sudo group
    sudo usermod -aG sudo alice

    # Check who has sudo access
    sudo cat /etc/sudoers
    ```

    ### sudoers File

    Edit with `visudo` (validates syntax before saving):

    ```bash
    sudo visudo
    ```

    Example entries:
    ```
    # Allow alice to run all commands
    alice ALL=(ALL:ALL) ALL

    # Allow developers group to run all commands
    %developers ALL=(ALL:ALL) ALL

    # Allow bob to restart nginx without password
    bob ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx
    ```

    ## Special Permissions

    ### setuid (Set User ID)

    When set on executable, it runs with owner's permissions:
    ```bash
    chmod u+s file
    chmod 4755 file    # setuid + 755
    ```

    Example: `/usr/bin/passwd` has setuid so users can change their passwords (which requires writing to /etc/shadow).

    ### setgid (Set Group ID)

    On directory: New files inherit directory's group:
    ```bash
    chmod g+s directory
    chmod 2755 directory
    ```

    ### Sticky Bit

    On directory: Users can only delete their own files:
    ```bash
    chmod +t directory
    chmod 1777 directory
    ```

    Example: `/tmp` has sticky bit so users can't delete each other's temp files.

    ## Best Practices

    1. **Principle of Least Privilege**: Give minimum permissions needed
    2. **Avoid 777**: Almost never necessary and insecure
    3. **Use sudo**: Don't log in as root directly
    4. **Review permissions**: Regularly audit sensitive files
    5. **Secure private keys**: SSH keys should be 600 or 400
    6. **Web files**: Typically 644 for files, 755 for directories

    ## Summary

    In this module, you learned:
    - Linux multi-user architecture with regular users, root, and system users
    - How to create, modify, and delete user accounts and groups
    - Understanding file permissions: read, write, execute for owner, group, others
    - Using chmod (symbolic and octal), chown, chgrp
    - Using sudo for privilege escalation safely
    - Special permissions: setuid, setgid, sticky bit
  MARKDOWN
end

module3_lab = HandsOnLab.find_or_create_by!(title: "User and Permission Management Lab") do |lab|
  lab.description = "Practice creating users, managing groups, modifying file permissions, changing ownership, and using sudo."
  lab.difficulty = "medium"
  lab.lab_type = "linux"
  lab.lab_format = "terminal"
  lab.estimated_minutes = 25
  lab.prerequisites = JSON.generate(["Module 1-2 completed", "sudo access"])
  lab.learning_objectives = JSON.generate([
    "Create and manage user accounts and groups",
    "Understand and modify file permissions using chmod",
    "Change file ownership with chown and chgrp",
    "Use sudo for administrative tasks safely"
  ])
  lab.steps = JSON.generate([
    {
      title: "Create a User",
      instruction: "Create a new user account and verify it was created",
      commands: [
        "sudo adduser demo",
        "# (provide password when prompted)",
        "id demo",
        "ls -ld /home/demo"
      ],
      expected_output: "User created with UID/GID, home directory exists"
    },
    {
      title: "Manage Groups",
      instruction: "Create a new group and add user to it",
      commands: [
        "sudo groupadd developers",
        "sudo usermod -aG developers demo",
        "id demo",
        "groups demo"
      ],
      expected_output: "Group created, user added to developers group"
    },
    {
      title: "Test User Context",
      instruction: "Switch to the new user and test permissions",
      commands: [
        "su - demo",
        "cat /etc/shadow",
        "# (should be permission denied)",
        "exit"
      ],
      expected_output: "Regular user cannot read /etc/shadow (root only)"
    },
    {
      title: "Explore Permissions",
      instruction: "Create file, view permissions, and modify them",
      commands: [
        "cd ~",
        "echo 'secret data' > confidential.txt",
        "ls -l confidential.txt",
        "sudo -u demo cat confidential.txt",
        "# (should work if world-readable)",
        "chmod 600 confidential.txt",
        "ls -l confidential.txt",
        "sudo -u demo cat confidential.txt",
        "# (should fail - not readable by others)"
      ],
      expected_output: "Permissions restrict access to file"
    },
    {
      title: "Change Ownership",
      instruction: "Create file as root and transfer ownership to demo user",
      commands: [
        "sudo touch /tmp/rootfile",
        "ls -l /tmp/rootfile",
        "sudo chown demo:demo /tmp/rootfile",
        "ls -l /tmp/rootfile"
      ],
      expected_output: "File ownership changed from root to demo"
    },
    {
      title: "Using Sudo",
      instruction: "Test sudo access and edit system file",
      commands: [
        "sudo nano /etc/hosts",
        "# (add comment, save and exit)",
        "sudo cat /etc/sudoers | grep sudo"
      ],
      expected_output: "Successfully edited system file with sudo, viewed sudoers entries"
    }
  ])
end

module3_quiz = Quiz.find_or_create_by!(title: "Module 3 Quiz: Users and Permissions") do |quiz|
  quiz.description = "Test your understanding of Linux users, groups, file permissions, and sudo"
  quiz.time_limit_minutes = 10
  quiz.passing_score = 80
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

q3_1 = QuizQuestion.find_or_create_by!(quiz: module3_quiz, question_order: 1) do |q|
  q.question_text = "What file contains user account information (usernames, UID, default shell, etc.) on a Linux system?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "/etc/shadow", correct: false },
    { text: "/etc/passwd", correct: true },
    { text: "/etc/group", correct: false },
    { text: "/etc/users", correct: false }
  ])
  q.explanation = "/etc/passwd contains user account information. /etc/shadow stores encrypted passwords (root-only), and /etc/group contains group information."
end

q3_2 = QuizQuestion.find_or_create_by!(quiz: module3_quiz, question_order: 2) do |q|
  q.question_text = "True or False: The user root is the only user who can use the sudo command."
  q.question_type = "true_false"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "True", correct: false },
    { text: "False", correct: true }
  ])
  q.explanation = "False. Any user in the sudo/wheel group or configured in /etc/sudoers can use sudo. Root doesn't need sudo (root can do anything already)."
end

q3_3 = QuizQuestion.find_or_create_by!(quiz: module3_quiz, question_order: 3) do |q|
  q.question_text = "If a file has permissions -rw-rw-r--, what can a user who is not the owner or in the file's group do?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "Read and write", correct: false },
    { text: "Read only", correct: true },
    { text: "Write only", correct: false },
    { text: "No access", correct: false }
  ])
  q.explanation = "-rw-rw-r-- breaks down as: Owner=rw, Group=rw, Others=r. Users not in owner/group can only read (r--), not write."
end

q3_4 = QuizQuestion.find_or_create_by!(quiz: module3_quiz, question_order: 4) do |q|
  q.question_text = "Which command changes the group ownership of a file example.txt to a group named team?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "chmod team example.txt", correct: false },
    { text: "chown team example.txt", correct: false },
    { text: "chgrp team example.txt", correct: true },
    { text: "usermod -G team example.txt", correct: false }
  ])
  q.explanation = "chgrp team example.txt changes the group. Alternatively, you can use 'chown :team example.txt'. chmod changes permissions, not ownership."
end

q3_5 = QuizQuestion.find_or_create_by!(quiz: module3_quiz, question_order: 5) do |q|
  q.question_text = "You need to add user alice to an existing group projectX. What command accomplishes this?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "sudo adduser alice projectX", correct: false },
    { text: "sudo groupadd alice projectX", correct: false },
    { text: "sudo usermod -aG projectX alice", correct: true },
    { text: "sudo gpasswd alice projectX", correct: false }
  ])
  q.explanation = "sudo usermod -aG projectX alice adds alice to the projectX group. The -aG flag appends the group without removing other groups."
end

# Link items to module
module3.module_items.find_or_create_by!(item: module3_lesson, sequence_order: 1) { |mi| mi.required = true }
module3.module_items.find_or_create_by!(item: module3_lab, sequence_order: 2) { |mi| mi.required = true }
module3.module_items.find_or_create_by!(item: module3_quiz, sequence_order: 3) { |mi| mi.required = true }

puts "  ✓ Module 3: User and Permission Management"

# ==========================================
# MODULE 4: Process Management and Job Scheduling (60 min)
# ==========================================

module4 = CourseModule.find_or_create_by!(slug: 'process-management-scheduling', course: linux_browser_course) do |mod|
  mod.title = "Module 4: Process Management and Job Scheduling"
  mod.description = "Monitor and control running processes, manage foreground/background jobs, terminate processes, and schedule automated tasks with cron."
  mod.sequence_order = 4
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Monitor and list running processes with ps and top",
    "Control processes: foreground/background, terminate with signals",
    "Adjust process priorities with nice and renice",
    "Schedule automated tasks using cron jobs"
  ])
end

module4_lesson = CourseLesson.find_or_create_by!(title: "Process Management and Scheduling") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Process Management and Job Scheduling

    ## Understanding Processes

    A **process** is an instance of a running program. Every command you run creates at least one process.

    ### Process Attributes

    | Attribute | Description |
    |-----------|-------------|
    | **PID** | Process ID (unique identifier) |
    | **PPID** | Parent Process ID |
    | **UID** | User ID (owner) |
    | **CPU%** | CPU usage percentage |
    | **MEM%** | Memory usage percentage |
    | **STAT** | Process state |
    | **TIME** | CPU time consumed |
    | **CMD** | Command that started the process |

    ### Process States

    | State | Code | Meaning |
    |-------|------|---------|
    | Running | R | Currently executing |
    | Sleeping | S | Waiting for event |
    | Stopped | T | Suspended/paused |
    | Zombie | Z | Finished but parent hasn't read exit status |
    | Defunct | D | Uninterruptible sleep (usually I/O) |

    ## Viewing Processes

    ### ps - Process Status

    ```bash
    # Current shell processes
    ps

    # All processes (BSD style)
    ps aux

    # All processes (System V style)
    ps -ef

    # Process tree (parent-child relationships)
    ps -ejH
    pstree

    # Find specific process
    ps aux | grep nginx
    ```

    **ps aux output:**
    ```
    USER  PID %CPU %MEM   VSZ  RSS TTY STAT START TIME COMMAND
    root    1  0.0  0.1 16856 2048 ?   Ss   10:00 0:01 /sbin/init
    alice 1234  1.5  2.3 45678 8192 pts/0 S+ 10:30 0:05 python app.py
    ```

    ### top - Real-time Process Monitoring

    ```bash
    top            # Interactive process viewer
    htop           # Enhanced version (if installed)
    ```

    **top commands:**
    - `q`: Quit
    - `k`: Kill process (enter PID)
    - `M`: Sort by memory
    - `P`: Sort by CPU
    - `u`: Filter by user
    - `1`: Show individual CPU cores

    ### Finding Processes

    ```bash
    # Find process by name
    pgrep nginx
    pgrep -u alice     # Processes owned by alice

    # Find process with details
    ps aux | grep nginx
    pidof nginx        # PIDs of running program
    ```

    ## Foreground and Background Jobs

    ### Foreground Processes

    By default, commands run in the foreground and occupy your terminal:
    ```bash
    sleep 60           # Terminal blocked for 60 seconds
    ```

    ### Background Processes

    Run processes in background with `&`:
    ```bash
    sleep 60 &         # Returns immediately
    ping 8.8.8.8 > ping.log &
    ```

    ### Job Control

    ```bash
    # Suspend foreground process
    Ctrl+Z             # Sends SIGTSTP (pause)

    # Resume in background
    bg                 # Continue last suspended job
    bg %1              # Continue job #1

    # Resume in foreground
    fg                 # Bring last background job to foreground
    fg %2              # Bring job #2 to foreground

    # List jobs
    jobs               # Show jobs in current shell
    jobs -l            # Show with PIDs
    ```

    **Example workflow:**
    ```bash
    $ ping 8.8.8.8 > ping.log
    # Press Ctrl+Z
    [1]+  Stopped    ping 8.8.8.8 > ping.log

    $ bg
    [1]+ ping 8.8.8.8 > ping.log &

    $ jobs
    [1]+  Running    ping 8.8.8.8 > ping.log &
    ```

    ## Terminating Processes

    ### Signals

    Processes communicate via signals. Common signals:

    | Signal | Number | Meaning | Effect |
    |--------|--------|---------|--------|
    | **SIGTERM** | 15 | Terminate (default) | Graceful shutdown |
    | **SIGKILL** | 9 | Kill | Force kill (can't be caught) |
    | **SIGHUP** | 1 | Hang up | Reload configuration |
    | **SIGINT** | 2 | Interrupt (Ctrl+C) | Interrupt process |
    | **SIGTSTP** | 20 | Stop (Ctrl+Z) | Suspend process |
    | **SIGCONT** | 18 | Continue | Resume suspended process |

    ### kill - Send Signal to Process

    ```bash
    # Terminate gracefully (SIGTERM)
    kill PID
    kill 1234

    # Force kill (SIGKILL)
    kill -9 PID
    kill -SIGKILL PID

    # Reload configuration (SIGHUP)
    kill -1 PID
    kill -HUP PID

    # List all signals
    kill -l
    ```

    ### killall - Kill by Name

    ```bash
    # Kill all processes named "firefox"
    killall firefox

    # Force kill
    killall -9 firefox

    # Kill user's processes
    killall -u alice
    ```

    ### pkill - Pattern-based Kill

    ```bash
    # Kill processes matching pattern
    pkill nginx
    pkill -9 python
    pkill -u alice    # Kill all alice's processes
    ```

    **⚠️ Best Practice**: Always try SIGTERM first, use SIGKILL only if necessary.

    ## Process Priorities

    Linux scheduler assigns CPU time based on priority (niceness).

    ### Nice Values

    - Range: `-20` (highest priority) to `+19` (lowest priority)
    - Default: `0`
    - Only root can set negative (higher priority) values

    ### nice - Start Process with Priority

    ```bash
    # Start with lower priority (nice +10)
    nice -n 10 command

    # Start with higher priority (root only)
    sudo nice -n -10 command

    # Example: Run CPU-intensive task nicely
    nice -n 15 gzip large_file.tar
    ```

    ### renice - Change Priority of Running Process

    ```bash
    # Make process nicer (lower priority)
    renice +5 -p PID

    # Increase priority (root only)
    sudo renice -10 -p PID

    # Renice all user's processes
    renice +10 -u alice
    ```

    ## Job Scheduling with Cron

    **cron** runs commands on a schedule automatically.

    ### Cron Time Format

    ```
    * * * * * command
    │ │ │ │ │
    │ │ │ │ └─ Day of week (0-7, Sunday=0 or 7)
    │ │ │ └─── Month (1-12)
    │ │ └───── Day of month (1-31)
    │ └─────── Hour (0-23)
    └───────── Minute (0-59)
    ```

    ### Cron Examples

    ```bash
    # Every minute
    * * * * * /path/to/script.sh

    # Every hour at minute 0
    0 * * * * /path/to/script.sh

    # Every day at 2:30 AM
    30 2 * * * /path/to/backup.sh

    # Every Monday at 9:00 AM
    0 9 * * 1 /path/to/report.sh

    # First day of every month at midnight
    0 0 1 * * /path/to/monthly.sh

    # Every 15 minutes
    */15 * * * * /path/to/check.sh

    # Every weekday at 6:00 PM
    0 18 * * 1-5 /path/to/end_day.sh
    ```

    ### Managing Cron Jobs

    ```bash
    # Edit crontab
    crontab -e         # Current user's crontab

    # List cron jobs
    crontab -l

    # Remove all cron jobs
    crontab -r

    # Edit another user's crontab (root only)
    sudo crontab -e -u alice
    ```

    ### Cron Special Strings

    ```bash
    @reboot     /path/to/script.sh    # Run at system boot
    @daily      /path/to/backup.sh    # Run once a day (midnight)
    @hourly     /path/to/check.sh     # Run every hour
    @weekly     /path/to/report.sh    # Run once a week
    @monthly    /path/to/monthly.sh   # Run once a month
    ```

    ### Cron Environment

    Cron jobs run with a limited environment:
    - No terminal
    - Limited PATH
    - Different environment variables

    **Best practices:**
    ```bash
    # Use absolute paths
    0 2 * * * /usr/bin/python3 /home/user/script.py

    # Set PATH in crontab
    PATH=/usr/local/bin:/usr/bin:/bin
    0 2 * * * backup.sh

    # Redirect output to log
    0 2 * * * /path/to/script.sh >> /var/log/backup.log 2>&1
    ```

    ### Cron Logs

    ```bash
    # View cron logs (Ubuntu/Debian)
    grep CRON /var/log/syslog

    # View cron logs (RHEL/CentOS)
    grep CRON /var/log/cron
    ```

    ## Summary

    In this module, you learned:
    - Processes are running programs with PIDs, owners, and states
    - Monitor processes with ps, top, htop
    - Control jobs with fg, bg, jobs
    - Terminate processes with kill, killall, pkill
    - Adjust priorities with nice and renice
    - Schedule recurring tasks with cron
    - Cron time format and best practices
  MARKDOWN
end

module4_lab = HandsOnLab.find_or_create_by!(title: "Process Management and Cron Lab") do |lab|
  lab.description = "Practice monitoring processes, controlling jobs, killing processes, and scheduling tasks with cron."
  lab.difficulty = "medium"
  lab.lab_type = "linux"
  lab.lab_format = "terminal"
  lab.estimated_minutes = 25
  lab.prerequisites = JSON.generate(["Module 1-3 completed"])
  lab.learning_objectives = JSON.generate([
    "Monitor processes with ps and top",
    "Control foreground and background jobs",
    "Terminate processes safely",
    "Create and manage cron jobs"
  ])
  lab.steps = JSON.generate([
    {
      title: "List Processes",
      instruction: "View running processes and find your shell's PID",
      commands: [
        "ps -ef | head -10",
        "echo $$",
        "ps -p $$",
        "top",
        "# (press q to quit)"
      ],
      expected_output: "Process list displayed, current shell PID identified"
    },
    {
      title: "Background Job Control",
      instruction: "Start a process, suspend it, and resume in background",
      commands: [
        "ping 127.0.0.1 > pingout.txt",
        "# (press Ctrl+Z to suspend)",
        "bg",
        "jobs",
        "ps aux | grep ping"
      ],
      expected_output: "Ping running in background, visible in jobs list"
    },
    {
      title: "Kill a Process",
      instruction: "Find and terminate the background ping process",
      commands: [
        "ps aux | grep ping",
        "kill <PID>",
        "# (if doesn't stop, use: kill -9 <PID>)",
        "ps aux | grep ping",
        "cat pingout.txt"
      ],
      expected_output: "Ping process terminated, output file contains ping results"
    },
    {
      title: "Create a Shell Script for Cron",
      instruction: "Write a simple script that logs timestamps",
      commands: [
        "cd ~",
        "echo '#!/bin/bash' > crontest.sh",
        "echo 'echo \"Cron ran at $(date)\" >> ~/cron_test.txt' >> crontest.sh",
        "chmod +x crontest.sh",
        "./crontest.sh",
        "cat cron_test.txt"
      ],
      expected_output: "Script created and manually tested, timestamp logged"
    },
    {
      title: "Schedule Cron Job",
      instruction: "Add a cron job to run the script every minute",
      commands: [
        "crontab -e",
        "# (add line: * * * * * /home/$(whoami)/crontest.sh)",
        "crontab -l",
        "# (wait 2-3 minutes)",
        "cat ~/cron_test.txt"
      ],
      expected_output: "Cron job scheduled, multiple timestamps appear in log file"
    },
    {
      title: "Clean Up",
      instruction: "Remove the cron job",
      commands: [
        "crontab -e",
        "# (delete the cron job line)",
        "crontab -l"
      ],
      expected_output: "Cron job removed from crontab"
    }
  ])
end

module4_quiz = Quiz.find_or_create_by!(title: "Module 4 Quiz: Process Management") do |quiz|
  quiz.description = "Test your knowledge of processes, job control, signals, and cron scheduling"
  quiz.time_limit_minutes = 10
  quiz.passing_score = 80
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

q4_1 = QuizQuestion.find_or_create_by!(quiz: module4_quiz, question_order: 1) do |q|
  q.question_text = "What command provides a real-time, interactive view of running processes with CPU/memory usage?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "ps", correct: false },
    { text: "top", correct: true },
    { text: "kill", correct: false },
    { text: "jobs", correct: false }
  ])
  q.explanation = "top provides an interactive, real-time view of processes. ps shows a snapshot, jobs shows shell jobs, and kill terminates processes."
end

q4_2 = QuizQuestion.find_or_create_by!(quiz: module4_quiz, question_order: 2) do |q|
  q.question_text = "To suspend a foreground process and then send it to the background, what key sequence and command would you use?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "Ctrl+C then bg", correct: false },
    { text: "Ctrl+Z then bg", correct: true },
    { text: "Ctrl+D then fg", correct: false },
    { text: "Ctrl+Z then fg", correct: false }
  ])
  q.explanation = "Ctrl+Z suspends the process (SIGTSTP), then bg resumes it in the background. Ctrl+C terminates the process."
end

q4_3 = QuizQuestion.find_or_create_by!(quiz: module4_quiz, question_order: 3) do |q|
  q.question_text = "True or False: The kill command always forcefully kills a process immediately."
  q.question_type = "true_false"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "True", correct: false },
    { text: "False", correct: true }
  ])
  q.explanation = "False. By default, kill sends SIGTERM (graceful termination). Only kill -9 (SIGKILL) forcefully kills a process."
end

q4_4 = QuizQuestion.find_or_create_by!(quiz: module4_quiz, question_order: 4) do |q|
  q.question_text = "In cron scheduling, what does this entry do? 30 2 * * * /usr/local/bin/backup.sh"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "Run at 2:30 PM every day", correct: false },
    { text: "Run at 2:30 AM every day", correct: true },
    { text: "Run every 30 minutes after 2 AM", correct: false },
    { text: "Run at 2:00 AM on the 30th of each month", correct: false }
  ])
  q.explanation = "30 2 * * * means minute 30, hour 2 (2:30 AM), every day of month, every month, every day of week = daily at 2:30 AM."
end

q4_5 = QuizQuestion.find_or_create_by!(quiz: module4_quiz, question_order: 5) do |q|
  q.question_text = "Which utility is used for recurring scheduled jobs, and which is used for one-time scheduling?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "cron for recurring, at for one-time", correct: true },
    { text: "at for recurring, cron for one-time", correct: false },
    { text: "Both cron and at for recurring", correct: false },
    { text: "systemd timers only", correct: false }
  ])
  q.explanation = "cron schedules recurring jobs (daily, weekly, etc.), while at schedules one-time jobs at a specific time."
end

# Link items to module
module4.module_items.find_or_create_by!(item: module4_lesson, sequence_order: 1) { |mi| mi.required = true }
module4.module_items.find_or_create_by!(item: module4_lab, sequence_order: 2) { |mi| mi.required = true }
module4.module_items.find_or_create_by!(item: module4_quiz, sequence_order: 3) { |mi| mi.required = true }

puts "  ✓ Module 4: Process Management and Job Scheduling"

puts "✅ Linux Browser Course seeded successfully!"
puts "📊 Course: #{linux_browser_course.title}"
puts "📚 Modules: #{linux_browser_course.course_modules.count}"

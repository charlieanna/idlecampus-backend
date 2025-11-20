# AUTO-GENERATED from linux_browser_course.rb
puts "Creating Microlessons for Intro Linux Shell..."

module_var = CourseModule.find_by(slug: 'intro-linux-shell')

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
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 9: Practice Question ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

The kernel is the core of Linux that interacts with hardware and manages resources (CPU, memory, storage). The shell is the interface that allows users to communicate with the kernel.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 10: Practice Question ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

top provides an interactive, real-time view of processes. ps shows a snapshot, jobs shows shell jobs, and kill terminates processes.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 11: Practice Question ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

False. By default, kill sends SIGTERM (graceful termination). Only kill -9 (SIGKILL) forcefully kills a process.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 12: Practice Question ===
lesson_12 = MicroLesson.create!(
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
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'medium',
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

# === MICROLESSON 18: Practice Question ===
lesson_18 = MicroLesson.create!(
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
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 19: Practice Question ===
lesson_19 = MicroLesson.create!(
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
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 20: Practice Question ===
lesson_20 = MicroLesson.create!(
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
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 21: Practice Question ===
lesson_21 = MicroLesson.create!(
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
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 22: Practice Question ===
lesson_22 = MicroLesson.create!(
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
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 23: Practice Question ===
lesson_23 = MicroLesson.create!(
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
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 24: Practice Question ===
lesson_24 = MicroLesson.create!(
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
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 25: Practice Question ===
lesson_25 = MicroLesson.create!(
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
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 26: Practice Question ===
lesson_26 = MicroLesson.create!(
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
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 27: Practice Question ===
lesson_27 = MicroLesson.create!(
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
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 28: Practice Question ===
lesson_28 = MicroLesson.create!(
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
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 29: Practice Question ===
lesson_29 = MicroLesson.create!(
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
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 30: Practice Question ===
lesson_30 = MicroLesson.create!(
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
  sequence_order: 30,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 31: Lesson 31 ===
lesson_31 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 31',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 31,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 31 microlessons for Intro Linux Shell"

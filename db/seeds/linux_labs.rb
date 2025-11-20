# Linux Fundamentals - Hands-On Labs
puts "🧪 Seeding Linux Fundamentals Labs..."

linux_course = Course.find_by(slug: 'linux-fundamentals')

unless linux_course
  puts "⚠️  Linux Fundamentals course not found. Run linux_fundamentals_course.rb first."
  exit
end

# ========================================
# LAB 1: Filesystem Navigation & File Operations
# ========================================

lab1 = HandsOnLab.find_or_create_by!(title: "Linux Lab 1: Filesystem Navigation") do |lab|
  lab.description = "Practice navigating the Linux filesystem and performing basic file operations"
  lab.difficulty = "easy"
  lab.lab_type = "linux"
  lab.estimated_minutes = 30
  lab.prerequisites = [
    "Understanding of basic Linux commands",
    "Knowledge of filesystem hierarchy"
  ]
  lab.learning_objectives = [
    "Navigate directories using cd, pwd, and ls",
    "Create and organize files and directories",
    "Use absolute and relative paths",
    "View file contents with various commands"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Explore the current directory",
      instruction: "Use pwd to print your current working directory, then use ls -lah to list all files including hidden ones with human-readable sizes.",
      expected_output: "You should see your current directory path and a detailed file listing",
      hints: ["pwd shows your current location", "ls -lah combines multiple useful flags"]
    },
    {
      step_number: 2,
      title: "Create a project directory structure",
      instruction: "Create a nested directory structure: ~/linux-practice/projects/web-app/configs using mkdir with the -p flag.",
      expected_output: "Directory structure created successfully",
      hints: ["The -p flag creates parent directories as needed", "Use absolute path starting with ~"]
    },
    {
      step_number: 3,
      title: "Navigate to the new directory",
      instruction: "Change to the configs directory you just created using cd.",
      expected_output: "Your pwd should show ~/linux-practice/projects/web-app/configs",
      hints: ["You can use absolute or relative paths", "cd ~/linux-practice/projects/web-app/configs"]
    },
    {
      step_number: 4,
      title: "Create multiple files",
      instruction: "Create three empty files: app.conf, database.conf, and cache.conf using the touch command.",
      expected_output: "Three empty configuration files created",
      hints: ["touch can create multiple files at once", "touch file1 file2 file3"]
    },
    {
      step_number: 5,
      title: "Add content to a file",
      instruction: "Add some text to app.conf using echo and redirection: echo 'port=8080' > app.conf",
      expected_output: "File contains the text 'port=8080'",
      hints: ["Use > to redirect output to a file", "Verify with cat app.conf"]
    },
    {
      step_number: 6,
      title: "Copy files",
      instruction: "Copy app.conf to backup.conf in the same directory.",
      expected_output: "backup.conf created with same content as app.conf",
      hints: ["Use cp source destination", "Verify both files exist with ls"]
    },
    {
      step_number: 7,
      title: "Navigate using relative paths",
      instruction: "Navigate to the parent directory (web-app) using a relative path.",
      expected_output: "Your pwd should show ~/linux-practice/projects/web-app",
      hints: [".. represents the parent directory", "cd .."]
    },
    {
      step_number: 8,
      title: "View file contents",
      instruction: "View the contents of configs/app.conf without changing directories.",
      expected_output: "You should see 'port=8080'",
      hints: ["Use relative path with cat", "cat configs/app.conf"]
    },
    {
      step_number: 9,
      title: "Move and rename",
      instruction: "Move backup.conf from the configs directory to the current directory and rename it to app-backup.conf.",
      expected_output: "File moved and renamed successfully",
      hints: ["mv can move and rename in one command", "mv configs/backup.conf ./app-backup.conf"]
    },
    {
      step_number: 10,
      title: "Clean up",
      instruction: "Remove the entire linux-practice directory tree.",
      expected_output: "Directory and all contents removed",
      hints: ["Use rm -r for recursive deletion", "cd ~ first, then rm -r linux-practice"]
    }
  ]
  # Note: validation_commands, hints, and solution are stored in steps
  lab.solution_code = <<~SOLUTION
    # Step-by-step solution:
    pwd
    ls -lah
    mkdir -p ~/linux-practice/projects/web-app/configs
    cd ~/linux-practice/projects/web-app/configs
    touch app.conf database.conf cache.conf
    echo 'port=8080' > app.conf
    cp app.conf backup.conf
    cd ..
    cat configs/app.conf
    mv configs/backup.conf ./app-backup.conf
    cd ~
    rm -r linux-practice
  SOLUTION
end

puts "  ✅ Created lab: #{lab1.title}"

# ========================================
# LAB 2: File Permissions & Ownership
# ========================================

lab2 = HandsOnLab.find_or_create_by!(title: "Linux Lab 2: File Permissions") do |lab|
  lab.description = "Master Linux file permissions using both symbolic and numeric modes"
  lab.difficulty = "easy"
  lab.lab_type = "linux"
  lab.estimated_minutes = 25
  lab.prerequisites = [
    "Understanding of rwx permissions",
    "Knowledge of user/group/other permission groups"
  ]
  lab.learning_objectives = [
    "Read and interpret file permissions",
    "Modify permissions using chmod",
    "Understand numeric (octal) permission notation",
    "Apply security best practices"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Create a test script",
      instruction: "Create a file called script.sh with the content: #!/bin/bash\\necho 'Hello World'",
      expected_output: "File created with shell script content",
      hints: ["Use echo with redirection or a text editor", "echo -e allows newline escape sequences"]
    },
    {
      step_number: 2,
      title: "Check initial permissions",
      instruction: "Use ls -l script.sh to view the file's permissions.",
      expected_output: "You should see something like -rw-r--r-- or -rw-rw-r--",
      hints: ["The first character indicates file type", "Next 9 characters are permissions (rwx for user, group, others)"]
    },
    {
      step_number: 3,
      title: "Try to execute the script",
      instruction: "Try running ./script.sh",
      expected_output: "Permission denied error",
      hints: ["The file needs execute permission", "Currently it only has read/write"]
    },
    {
      step_number: 4,
      title: "Add execute permission",
      instruction: "Add execute permission for the owner using chmod u+x script.sh",
      expected_output: "Permissions now include x for owner",
      hints: ["u = user/owner, +x = add execute", "Verify with ls -l"]
    },
    {
      step_number: 5,
      title: "Execute the script",
      instruction: "Run ./script.sh again",
      expected_output: "Script runs and prints 'Hello World'",
      hints: ["The execute bit allows running the file", "./ means current directory"]
    },
    {
      step_number: 6,
      title: "Create a private file",
      instruction: "Create a file called secret.txt and set permissions so only the owner can read and write (no access for group or others).",
      expected_output: "Permissions should be -rw------- (600)",
      hints: ["Use chmod 600 secret.txt", "Or chmod u=rw,go= secret.txt"]
    },
    {
      step_number: 7,
      title: "Create a public read file",
      instruction: "Create a file called readme.txt and set permissions to 644 (owner read/write, others read-only).",
      expected_output: "Permissions should be -rw-r--r--",
      hints: ["chmod 644 readme.txt", "6 = rw- (4+2), 4 = r-- (4)"]
    },
    {
      step_number: 8,
      title: "Make a fully executable script",
      instruction: "Set script.sh to 755 (owner all permissions, others read and execute).",
      expected_output: "Permissions should be -rwxr-xr-x",
      hints: ["chmod 755 script.sh", "7 = rwx (4+2+1), 5 = r-x (4+1)"]
    },
    {
      step_number: 9,
      title: "Remove all permissions for others",
      instruction: "Remove all permissions for 'others' from script.sh using symbolic notation.",
      expected_output: "Permissions should be -rwxr-x--- (750)",
      hints: ["chmod o= script.sh or chmod o-rwx script.sh", "o = others, = sets exact permissions"]
    },
    {
      step_number: 10,
      title: "Practice permission calculation",
      instruction: "Create a file test.txt and set its permissions to rwxr-x--- using numeric notation.",
      expected_output: "Permissions should be -rwxr-x--- (750)",
      hints: ["rwx = 7, r-x = 5, --- = 0", "chmod 750 test.txt"]
    }
  ]
  lab.solution_code = <<~SOLUTION
    # Solution:
    echo -e '#!/bin/bash\\necho "Hello World"' > script.sh
    ls -l script.sh
    ./script.sh  # Will fail
    chmod u+x script.sh
    ./script.sh  # Now works
    touch secret.txt
    chmod 600 secret.txt
    touch readme.txt
    chmod 644 readme.txt
    chmod 755 script.sh
    chmod o= script.sh
    touch test.txt
    chmod 750 test.txt
    ls -l
  SOLUTION
end

puts "  ✅ Created lab: #{lab2.title}"

# ========================================
# LAB 3: Text Processing & Pipes
# ========================================

lab3 = HandsOnLab.find_or_create_by!(title: "Linux Lab 3: Text Processing") do |lab|
  lab.description = "Master grep, pipes, and stream redirection for text processing"
  lab.difficulty = "easy"
  lab.lab_type = "linux"
  lab.estimated_minutes = 30
  lab.prerequisites = [
    "Basic command line navigation",
    "Understanding of file operations"
  ]
  lab.learning_objectives = [
    "Search text with grep",
    "Chain commands using pipes",
    "Redirect output to files",
    "Process log files effectively"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Create a sample log file",
      instruction: "Create a file called app.log with multiple log entries using cat with a heredoc or multiple echo commands. Include lines with ERROR, WARN, and INFO levels.",
      expected_output: "Log file with various severity levels created",
      hints: ["Use cat << EOF > app.log to create multi-line files", "Include timestamps and different log levels"]
    },
    {
      step_number: 2,
      title: "Search for errors",
      instruction: "Use grep to find all lines containing 'ERROR' in app.log",
      expected_output: "Only lines with ERROR are displayed",
      hints: ["grep 'ERROR' app.log", "grep is case-sensitive by default"]
    },
    {
      step_number: 3,
      title: "Case-insensitive search",
      instruction: "Search for 'error' (lowercase) using case-insensitive search",
      expected_output: "Lines with ERROR, Error, error are all shown",
      hints: ["Use -i flag for case-insensitive", "grep -i 'error' app.log"]
    },
    {
      step_number: 4,
      title: "Count occurrences",
      instruction: "Count how many ERROR lines exist in the log file",
      expected_output: "A number showing count of ERROR lines",
      hints: ["Use -c flag to count matches", "grep -c 'ERROR' app.log"]
    },
    {
      step_number: 5,
      title: "Show line numbers",
      instruction: "Display ERROR lines with their line numbers",
      expected_output: "Each match shows line number prefix",
      hints: ["Use -n flag for line numbers", "grep -n 'ERROR' app.log"]
    },
    {
      step_number: 6,
      title: "Invert match",
      instruction: "Show all lines that do NOT contain 'INFO'",
      expected_output: "Only ERROR and WARN lines shown",
      hints: ["Use -v flag to invert match", "grep -v 'INFO' app.log"]
    },
    {
      step_number: 7,
      title: "Pipe commands",
      instruction: "List all files in /etc, then use grep to find only files with 'conf' in the name",
      expected_output: "List of configuration files",
      hints: ["ls /etc | grep conf", "Pipe (|) sends output of ls to input of grep"]
    },
    {
      step_number: 8,
      title: "Chain multiple pipes",
      instruction: "From app.log, get only ERROR lines, sort them, and count the unique ones",
      expected_output: "Sorted unique error messages",
      hints: ["grep 'ERROR' app.log | sort | uniq", "Commands are processed left to right"]
    },
    {
      step_number: 9,
      title: "Redirect to file",
      instruction: "Extract all ERROR lines from app.log and save them to errors.log",
      expected_output: "New file errors.log contains only ERROR lines",
      hints: ["Use > to redirect to a new file", "grep 'ERROR' app.log > errors.log"]
    },
    {
      step_number: 10,
      title: "Append to file",
      instruction: "Extract WARN lines and append them to errors.log (don't overwrite)",
      expected_output: "errors.log now contains both ERROR and WARN lines",
      hints: ["Use >> to append instead of overwrite", "grep 'WARN' app.log >> errors.log"]
    },
    {
      step_number: 11,
      title: "Count words and lines",
      instruction: "Use wc to count lines, words, and characters in errors.log",
      expected_output: "Three numbers: lines, words, characters",
      hints: ["wc errors.log shows all three counts", "wc -l shows only lines"]
    },
    {
      step_number: 12,
      title: "Advanced piping",
      instruction: "Find the 3 most common words in app.log (hint: use grep, tr, sort, uniq, and head)",
      expected_output: "Top 3 most frequent words with counts",
      hints: ["tr -s ' ' '\\n' splits words to lines", "sort | uniq -c counts occurrences", "sort -rn sorts numerically reversed", "head -3 shows top 3"]
    }
  ]
  lab.solution_code = <<~SOLUTION
    # Solution:
    cat << EOF > app.log
    2024-01-15 10:00:01 INFO Application started
    2024-01-15 10:00:15 ERROR Database connection failed
    2024-01-15 10:00:16 ERROR Retry attempt 1 failed
    2024-01-15 10:00:20 WARN Connection timeout warning
    2024-01-15 10:00:25 INFO Retry successful
    2024-01-15 10:01:00 ERROR Failed to load config
    2024-01-15 10:01:05 WARN Memory usage high
    2024-01-15 10:02:00 INFO Processing request
    EOF

    grep 'ERROR' app.log
    grep -i 'error' app.log
    grep -c 'ERROR' app.log
    grep -n 'ERROR' app.log
    grep -v 'INFO' app.log
    ls /etc | grep conf
    grep 'ERROR' app.log | sort | uniq
    grep 'ERROR' app.log > errors.log
    grep 'WARN' app.log >> errors.log
    wc errors.log
    cat app.log | tr -s ' ' '\\n' | sort | uniq -c | sort -rn | head -3
  SOLUTION
end

puts "  ✅ Created lab: #{lab3.title}"

# ========================================
# LAB 4: Process Management
# ========================================

lab4 = HandsOnLab.find_or_create_by!(title: "Linux Lab 4: Process Management") do |lab|
  lab.description = "Learn to monitor, manage, and control Linux processes"
  lab.difficulty = "easy"
  lab.lab_type = "linux"
  lab.estimated_minutes = 25
  lab.prerequisites = [
    "Basic Linux command line skills",
    "Understanding of processes"
  ]
  lab.learning_objectives = [
    "View and monitor running processes",
    "Run processes in background and foreground",
    "Send signals to processes",
    "Understand process IDs (PIDs)"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "View your processes",
      instruction: "Use ps to show processes running in your current terminal",
      expected_output: "List of processes with PID, TTY, TIME, CMD",
      hints: ["Just type: ps", "Shows only your terminal's processes"]
    },
    {
      step_number: 2,
      title: "View all processes",
      instruction: "Use ps aux to show all running processes on the system",
      expected_output: "Comprehensive list of all processes with details",
      hints: ["ps aux shows user, PID, CPU%, MEM%, and command", "Output can be very long"]
    },
    {
      step_number: 3,
      title: "Find specific processes",
      instruction: "Use ps and grep to find all bash processes",
      expected_output: "List of bash shell processes",
      hints: ["ps aux | grep bash", "You'll see your grep command in results too"]
    },
    {
      step_number: 4,
      title: "Start a long-running process",
      instruction: "Run 'sleep 300' in the background using &",
      expected_output: "Job number and PID displayed, prompt returns immediately",
      hints: ["sleep 300 &", "The & runs the command in background"]
    },
    {
      step_number: 5,
      title: "List background jobs",
      instruction: "Use the jobs command to see your background jobs",
      expected_output: "List showing [1]+ Running sleep 300 &",
      hints: ["Just type: jobs", "Shows job number, status, and command"]
    },
    {
      step_number: 6,
      title: "Find process ID",
      instruction: "Use pgrep to find the PID of your sleep process",
      expected_output: "A number (the process ID)",
      hints: ["pgrep sleep", "Alternative: ps aux | grep sleep"]
    },
    {
      step_number: 7,
      title: "Kill a process",
      instruction: "Terminate the sleep process using kill and its PID",
      expected_output: "Process terminated",
      hints: ["kill <PID>", "Use the PID from previous step", "Check with jobs afterwards"]
    },
    {
      step_number: 8,
      title: "Force kill a process",
      instruction: "Start another 'sleep 300' and kill it using SIGKILL (signal 9)",
      expected_output: "Process forcefully terminated",
      hints: ["sleep 300 &", "kill -9 <PID> or kill -KILL <PID>"]
    },
    {
      step_number: 9,
      title: "Monitor processes with top",
      instruction: "Run 'top' to view processes interactively (press 'q' to quit)",
      expected_output: "Real-time process monitoring display",
      hints: ["Type: top", "Shows CPU, memory usage", "Press 'q' to exit"]
    },
    {
      step_number: 10,
      title: "Kill by name",
      instruction: "Start 'sleep 400' in background, then kill it using pkill",
      expected_output: "Process killed by name",
      hints: ["sleep 400 &", "pkill sleep kills all processes named sleep"]
    }
  ]
  lab.solution_code = <<~SOLUTION
    # Solution:
    ps
    ps aux
    ps aux | grep bash
    sleep 300 &
    jobs
    pgrep sleep
    kill $(pgrep sleep)  # Or use actual PID
    sleep 300 &
    kill -9 $(pgrep sleep)
    top  # Press 'q' to quit
    sleep 400 &
    pkill sleep
  SOLUTION
end

puts "  ✅ Created lab: #{lab4.title}"

# ========================================
# LAB 5: Networking Basics
# ========================================

lab5 = HandsOnLab.find_or_create_by!(title: "Linux Lab 5: Networking Commands") do |lab|
  lab.description = "Master essential networking commands for connectivity and troubleshooting"
  lab.difficulty = "easy"
  lab.lab_type = "linux"
  lab.estimated_minutes = 25
  lab.prerequisites = [
    "Basic Linux command line skills",
    "Understanding of networking concepts"
  ]
  lab.learning_objectives = [
    "Test network connectivity",
    "View network configuration",
    "Check open ports and connections",
    "Perform DNS lookups"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Test basic connectivity",
      instruction: "Ping google.com to test internet connectivity (use -c 4 to send only 4 packets)",
      expected_output: "4 packets transmitted and received with response times",
      hints: ["ping -c 4 google.com", "-c limits number of packets"]
    },
    {
      step_number: 2,
      title: "Ping an IP address",
      instruction: "Ping Google's public DNS server at 8.8.8.8 with 3 packets",
      expected_output: "3 packets sent and received successfully",
      hints: ["ping -c 3 8.8.8.8", "Tests connectivity without DNS"]
    },
    {
      step_number: 3,
      title: "View network interfaces",
      instruction: "Display all network interfaces and their IP addresses using ip addr show",
      expected_output: "List of network interfaces with IP addresses, MAC addresses, and status",
      hints: ["ip addr show or ip a", "Look for inet (IPv4) and inet6 (IPv6) addresses"]
    },
    {
      step_number: 4,
      title: "Show routing table",
      instruction: "Display the routing table using ip route show",
      expected_output: "Default gateway and network routes",
      hints: ["ip route show or ip r", "Shows where packets are sent"]
    },
    {
      step_number: 5,
      title: "DNS lookup with host",
      instruction: "Look up the IP address for github.com using the host command",
      expected_output: "IP address(es) for github.com",
      hints: ["host github.com", "Shows A records (IPv4) and AAAA records (IPv6)"]
    },
    {
      step_number: 6,
      title: "Detailed DNS lookup",
      instruction: "Use dig to perform a detailed DNS lookup for google.com",
      expected_output: "Comprehensive DNS information including query time, answer section",
      hints: ["dig google.com", "More detailed than host command"]
    },
    {
      step_number: 7,
      title: "Test HTTP connectivity",
      instruction: "Use curl to fetch the headers from https://example.com",
      expected_output: "HTTP headers including status code 200 OK",
      hints: ["curl -I https://example.com", "-I shows headers only"]
    },
    {
      step_number: 8,
      title: "Download with curl",
      instruction: "Download https://example.com and display its HTML content",
      expected_output: "HTML content of example.com displayed",
      hints: ["curl https://example.com", "Without -I it shows content"]
    },
    {
      step_number: 9,
      title: "Check listening ports",
      instruction: "Display all listening TCP/UDP ports using ss or netstat",
      expected_output: "List of listening ports and their states",
      hints: ["ss -tuln or netstat -tuln", "-t=TCP, -u=UDP, -l=listening, -n=numeric"]
    },
    {
      step_number: 10,
      title: "Test specific port",
      instruction: "Test if port 443 is open on google.com using nc (netcat) or telnet",
      expected_output: "Connection successful message",
      hints: ["nc -zv google.com 443", "Or: telnet google.com 443", "-z scan without data, -v verbose"]
    }
  ]
  lab.solution_code = <<~SOLUTION
    # Solution:
    ping -c 4 google.com
    ping -c 3 8.8.8.8
    ip addr show
    ip route show
    host github.com
    dig google.com
    curl -I https://example.com
    curl https://example.com
    ss -tuln
    nc -zv google.com 443
  SOLUTION
end

puts "  ✅ Created lab: #{lab5.title}"

# ========================================
# Link Labs to Course Modules
# ========================================

# Module 1: Linux Basics & Navigation
module1 = linux_course.course_modules.find_by(slug: 'linux-basics-navigation')
if module1 && !ModuleItem.exists?(course_module: module1, item: lab1)
  # Get the highest sequence_order and add after it
  max_order = module1.module_items.maximum(:sequence_order) || 0
  module1.module_items.create!(item: lab1, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab1.title} to #{module1.title}"
end

# Module 2: File Permissions & Ownership
module2 = linux_course.course_modules.find_by(slug: 'file-permissions-ownership')
if module2 && !ModuleItem.exists?(course_module: module2, item: lab2)
  max_order = module2.module_items.maximum(:sequence_order) || 0
  module2.module_items.create!(item: lab2, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab2.title} to #{module2.title}"
end

# Module 3: Text Processing & Streams
module3 = linux_course.course_modules.find_by(slug: 'text-processing-streams')
if module3 && !ModuleItem.exists?(course_module: module3, item: lab3)
  max_order = module3.module_items.maximum(:sequence_order) || 0
  module3.module_items.create!(item: lab3, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab3.title} to #{module3.title}"
end

# Module 4: Process Management
module4 = linux_course.course_modules.find_by(slug: 'process-management')
if module4 && !ModuleItem.exists?(course_module: module4, item: lab4)
  max_order = module4.module_items.maximum(:sequence_order) || 0
  module4.module_items.create!(item: lab4, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab4.title} to #{module4.title}"
end

# Module 5: Networking Basics
module5 = linux_course.course_modules.find_by(slug: 'networking-basics')
if module5 && !ModuleItem.exists?(course_module: module5, item: lab5)
  max_order = module5.module_items.maximum(:sequence_order) || 0
  module5.module_items.create!(item: lab5, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab5.title} to #{module5.title}"
end

# ========================================
# Summary
# ========================================

puts "\n✅ Linux Labs Seeding Complete!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "🧪 Total Labs: 5"
puts "  • Lab 1: Filesystem Navigation (30 min, 10 steps)"
puts "  • Lab 2: File Permissions (25 min, 10 steps)"
puts "  • Lab 3: Text Processing (30 min, 12 steps)"
puts "  • Lab 4: Process Management (25 min, 10 steps)"
puts "  • Lab 5: Networking Commands (25 min, 10 steps)"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

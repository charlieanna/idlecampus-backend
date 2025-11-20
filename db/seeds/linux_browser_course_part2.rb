# Browser-Based Linux Fundamentals Course - Part 2 (Modules 5-7 + Capstone)
# This file must be loaded after linux_browser_course.rb
puts "🐧 Adding Modules 5-7 to Linux Browser Course..."

# Find the existing course
linux_browser_course = Course.find_by!(slug: 'linux-browser-fundamentals')

# ==========================================
# MODULE 5: Software Package Management and Services (60 min)
# ==========================================

module5 = CourseModule.find_or_create_by!(slug: 'package-management-services', course: linux_browser_course) do |mod|
  mod.title = "Module 5: Software Package Management and Services"
  mod.description = "Install and manage software packages, control system services with systemd, view logs, and understand containerized services as an alternative."
  mod.sequence_order = 5
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand package managers and install/remove software packages",
    "Manage services (daemons) with systemd: start, stop, restart, enable/disable",
    "View and analyze service status and logs",
    "Understand basics of containerized services as alternative to host installation"
  ])
end

module5_lesson = CourseLesson.find_or_create_by!(title: "Package Management and System Services") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Software Package Management and Services

    ## Package Management Basics

    Package managers simplify software installation, updates, and removal by automatically handling dependencies and configurations.

    ### What is a Package?

    A package is precompiled software bundled with:
    - Executables and binaries
    - Configuration files
    - Documentation
    - Metadata (dependencies, version, description)

    ### Common Package Managers

    | Distribution | Package Manager | Package Format | Example Command |
    |--------------|----------------|----------------|-----------------|
    | **Ubuntu/Debian** | apt, dpkg | .deb | `apt install nginx` |
    | **RHEL/CentOS 7** | yum, rpm | .rpm | `yum install nginx` |
    | **RHEL/CentOS 8+** | dnf | .rpm | `dnf install nginx` |
    | **Alpine** | apk | .apk | `apk add nginx` |
    | **Arch** | pacman | .pkg.tar.xz | `pacman -S nginx` |

    ## APT Package Manager (Debian/Ubuntu)

    **APT** (Advanced Package Tool) is the high-level package manager for Debian-based systems.

    ### Repository Management

    ```bash
    # Update package index (always do this first!)
    sudo apt update

    # Upgrade all installed packages
    sudo apt upgrade

    # Full system upgrade (handles dependencies more aggressively)
    sudo apt full-upgrade

    # Remove unused dependencies
    sudo apt autoremove
    ```

    ### Installing Software

    ```bash
    # Install package
    sudo apt install nginx

    # Install multiple packages
    sudo apt install nginx mysql-server php

    # Install without prompts (-y = assume yes)
    sudo apt install -y apache2

    # Install specific version
    sudo apt install nginx=1.18.0-0ubuntu1
    ```

    ### Removing Software

    ```bash
    # Remove package (keep configuration files)
    sudo apt remove nginx

    # Remove package AND configuration files
    sudo apt purge nginx

    # Remove package and unused dependencies
    sudo apt autoremove nginx
    ```

    ### Searching and Information

    ```bash
    # Search for package
    apt search nginx
    apt search web server

    # Show package details
    apt show nginx

    # List installed packages
    apt list --installed

    # Check if package is installed
    dpkg -l | grep nginx
    ```

    ## YUM/DNF Package Manager (RHEL/CentOS)

    ### Basic Commands

    ```bash
    # Update package cache
    sudo yum check-update       # CentOS 7
    sudo dnf check-update       # CentOS 8+

    # Install package
    sudo yum install nginx      # CentOS 7
    sudo dnf install nginx      # CentOS 8+

    # Remove package
    sudo yum remove nginx
    sudo dnf remove nginx

    # Update all packages
    sudo yum update
    sudo dnf upgrade

    # Search for package
    yum search nginx
    dnf search nginx

    # Show package info
    yum info nginx
    dnf info nginx
    ```

    ## Service Management with systemd

    **systemd** is the init system and service manager for most modern Linux distributions.

    ### What is a Service?

    A **service** (or daemon) is a background process that:
    - Starts automatically at boot
    - Runs continuously
    - Provides functionality (web server, database, SSH)

    Examples: `nginx`, `mysql`, `sshd`, `docker`

    ### Service Commands

    ```bash
    # Check service status
    systemctl status nginx

    # Start service
    sudo systemctl start nginx

    # Stop service
    sudo systemctl stop nginx

    # Restart service (stop then start)
    sudo systemctl restart nginx

    # Reload configuration without stopping
    sudo systemctl reload nginx

    # Enable service (start at boot)
    sudo systemctl enable nginx

    # Disable service (don't start at boot)
    sudo systemctl disable nginx

    # Enable and start in one command
    sudo systemctl enable --now nginx

    # Check if service is enabled
    systemctl is-enabled nginx

    # Check if service is active
    systemctl is-active nginx
    ```

    ### Listing Services

    ```bash
    # List all services
    systemctl list-units --type=service

    # List running services
    systemctl list-units --type=service --state=running

    # List failed services
    systemctl list-units --type=service --state=failed

    # List enabled services (start at boot)
    systemctl list-unit-files --type=service --state=enabled
    ```

    ### Service Dependencies

    ```bash
    # View service dependencies
    systemctl list-dependencies nginx

    # View what depends on this service
    systemctl list-dependencies --reverse nginx
    ```

    ## Viewing Logs

    ### journalctl - systemd Journal

    systemd captures service logs in the journal:

    ```bash
    # View all logs
    journalctl

    # View logs for specific service
    journalctl -u nginx
    journalctl -u apache2

    # Follow logs in real-time (like tail -f)
    journalctl -u nginx -f

    # View recent logs (last N lines)
    journalctl -u nginx -n 50

    # View logs since boot
    journalctl -u nginx -b

    # View logs from specific time
    journalctl -u nginx --since "2024-11-05 10:00:00"
    journalctl -u nginx --since yesterday
    journalctl -u nginx --since "1 hour ago"

    # View logs with priority level
    journalctl -p err         # Only errors
    journalctl -p warning     # Warnings and above
    ```

    ### Traditional Log Files

    Some services still write to `/var/log/`:

    ```bash
    # Web server logs
    /var/log/apache2/access.log
    /var/log/apache2/error.log
    /var/log/nginx/access.log
    /var/log/nginx/error.log

    # System logs
    /var/log/syslog           # Ubuntu/Debian general system log
    /var/log/messages         # RHEL/CentOS general system log
    /var/log/auth.log         # Authentication logs
    /var/log/kern.log         # Kernel logs
    ```

    **Viewing log files:**
    ```bash
    # View entire log
    sudo cat /var/log/syslog

    # View last 20 lines
    sudo tail -20 /var/log/syslog

    # Follow log in real-time
    sudo tail -f /var/log/nginx/access.log

    # Search logs
    sudo grep "error" /var/log/nginx/error.log
    ```

    ## Installing and Managing Web Server Example

    ### Installing Apache HTTP Server

    ```bash
    # Update package index
    sudo apt update

    # Install Apache
    sudo apt install -y apache2

    # Verify installation
    apache2 -v

    # Check service status
    systemctl status apache2

    # Ensure it starts at boot
    sudo systemctl enable apache2

    # Test the web server
    curl http://localhost
    ```

    ### Managing Apache

    ```bash
    # Stop Apache
    sudo systemctl stop apache2

    # Start Apache
    sudo systemctl start apache2

    # Restart Apache (configuration changes)
    sudo systemctl restart apache2

    # Reload Apache (graceful restart)
    sudo systemctl reload apache2

    # View Apache logs
    sudo journalctl -u apache2 -n 50
    sudo tail -f /var/log/apache2/access.log
    ```

    ### Web Server Files

    | Path | Purpose |
    |------|---------|
    | `/var/www/html/` | Default web root (place website files here) |
    | `/etc/apache2/` | Apache configuration directory |
    | `/etc/nginx/` | Nginx configuration directory |
    | `/var/log/apache2/` | Apache logs |
    | `/var/log/nginx/` | Nginx logs |

    ## Introduction to Containers

    ### Traditional Installation vs. Containers

    **Traditional Installation:**
    - Install software on host OS
    - Shares system libraries
    - May conflict with other software
    - Updates affect all applications

    **Container Installation:**
    - Isolated environment
    - Bundles application + dependencies
    - No conflicts
    - Each container independent

    ### Why Containers Matter

    Since this course prepares for Docker/Kubernetes:
    - Docker uses Linux containers to isolate applications
    - Kubernetes orchestrates containers across multiple machines
    - Understanding services helps understand containerized services

    ### Container Concepts

    ```bash
    # Traditional: Install on host
    sudo apt install nginx
    sudo systemctl start nginx

    # Container: Run isolated
    docker run -d -p 80:80 nginx
    ```

    **Container benefits:**
    - Portable (run anywhere)
    - Isolated (doesn't affect host)
    - Version control (specific image versions)
    - Easy rollback

    ## Troubleshooting Services

    ### Common Issues

    **1. Service won't start:**
    ```bash
    # Check status for error message
    systemctl status nginx

    # View detailed logs
    journalctl -u nginx -n 100

    # Check configuration syntax
    nginx -t
    apache2ctl configtest
    ```

    **2. Port already in use:**
    ```bash
    # Check what's using the port
    sudo netstat -tulpn | grep :80
    sudo ss -tulpn | grep :80
    sudo lsof -i :80
    ```

    **3. Permission denied:**
    ```bash
    # Check file permissions
    ls -l /var/www/html/

    # Check SELinux (RHEL/CentOS)
    getenforce
    sudo setenforce 0    # Temporarily disable for testing
    ```

    **4. Service crashed:**
    ```bash
    # Check if service failed
    systemctl list-units --failed

    # View crash logs
    journalctl -u nginx --since "10 minutes ago"
    ```

    ## Best Practices

    1. **Always update before installing**: `sudo apt update`
    2. **Enable important services**: `sudo systemctl enable nginx`
    3. **Monitor logs**: Use `journalctl -f` or `tail -f` to watch logs
    4. **Test after changes**: `nginx -t` or `apache2ctl configtest`
    5. **Regular updates**: `sudo apt upgrade` for security patches
    6. **Backup configs**: Before modifying `/etc/nginx/` or `/etc/apache2/`

    ## Summary

    In this module, you learned:
    - Package managers (apt, yum/dnf) install and manage software
    - How to install, remove, search, and update packages
    - systemd manages services (start, stop, restart, enable/disable)
    - View logs with journalctl and traditional log files
    - Install and manage web servers like Apache
    - Containers provide an alternative to direct host installation
  MARKDOWN
end

module5_lab = HandsOnLab.find_or_create_by!(title: "Package Management and Services Lab") do |lab|
  lab.description = "Practice installing packages, managing services with systemd, and viewing logs."
  lab.difficulty = "medium"
  lab.lab_type = "linux"
  lab.lab_format = "terminal"
  lab.estimated_minutes = 25
  lab.prerequisites = JSON.generate(["Module 1-4 completed", "sudo access"])
  lab.learning_objectives = JSON.generate([
    "Use apt to install and remove packages",
    "Manage services with systemctl (start, stop, enable)",
    "View service logs with journalctl",
    "Test a web server installation"
  ])
  lab.steps = JSON.generate([
    {
      title: "Update Package Index",
      instruction: "Refresh the package database to ensure latest package information",
      commands: [
        "sudo apt update"
      ],
      expected_output: "Package lists updated successfully"
    },
    {
      title: "Install Apache Web Server",
      instruction: "Install Apache HTTP Server using apt",
      commands: [
        "sudo apt install -y apache2",
        "apache2 -v",
        "systemctl status apache2"
      ],
      expected_output: "Apache installed, version displayed, service active and running"
    },
    {
      title: "Test the Web Server",
      instruction: "Verify Apache is serving web pages",
      commands: [
        "curl http://localhost",
        "systemctl is-active apache2",
        "systemctl is-enabled apache2"
      ],
      expected_output: "HTML content returned, service active and enabled"
    },
    {
      title: "Manage Service",
      instruction: "Practice controlling the Apache service",
      commands: [
        "sudo systemctl stop apache2",
        "systemctl status apache2",
        "sudo systemctl start apache2",
        "systemctl status apache2",
        "sudo systemctl restart apache2"
      ],
      expected_output: "Service stops, starts, and restarts successfully"
    },
    {
      title: "Enable Service at Boot",
      instruction: "Ensure Apache starts automatically on boot",
      commands: [
        "sudo systemctl enable apache2",
        "systemctl is-enabled apache2"
      ],
      expected_output: "Service enabled, confirmed with is-enabled check"
    },
    {
      title: "View Service Logs",
      instruction: "Check Apache logs using journalctl and log files",
      commands: [
        "sudo journalctl -u apache2 -n 10",
        "sudo tail -5 /var/log/apache2/access.log",
        "sudo tail -5 /var/log/apache2/error.log"
      ],
      expected_output: "Recent Apache logs displayed from journal and log files"
    }
  ])
end

module5_quiz = Quiz.find_or_create_by!(title: "Module 5 Quiz: Package Management and Services") do |quiz|
  quiz.description = "Test your understanding of package managers, systemd services, and logging"
  quiz.time_limit_minutes = 10
  quiz.passing_score = 80
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

q5_1 = QuizQuestion.find_or_create_by!(quiz: module5_quiz, question_order: 1) do |q|
  q.question_text = "What is the purpose of running 'sudo apt update' before installing packages on a Debian/Ubuntu system?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "To upgrade all installed packages to latest versions", correct: false },
    { text: "To refresh the package repository index", correct: true },
    { text: "To remove unused packages", correct: false },
    { text: "To restart system services", correct: false }
  ])
  q.explanation = "'apt update' refreshes the repository index, ensuring you have the latest information on available packages and versions. 'apt upgrade' is what updates installed packages."
end

q5_2 = QuizQuestion.find_or_create_by!(quiz: module5_quiz, question_order: 2) do |q|
  q.question_text = "Which command would you use to install a package called 'git' on a Red Hat-based system (RHEL/CentOS 7)?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "sudo apt install git", correct: false },
    { text: "sudo yum install git", correct: true },
    { text: "sudo pacman -S git", correct: false },
    { text: "sudo apk add git", correct: false }
  ])
  q.explanation = "Red Hat-based systems use yum (CentOS 7) or dnf (CentOS 8+). apt is for Debian/Ubuntu, pacman for Arch, and apk for Alpine."
end

q5_3 = QuizQuestion.find_or_create_by!(quiz: module5_quiz, question_order: 3) do |q|
  q.question_text = "After installing and starting a service, which command ensures it starts automatically on boot?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "systemctl start <service>", correct: false },
    { text: "systemctl restart <service>", correct: false },
    { text: "systemctl enable <service>", correct: true },
    { text: "systemctl status <service>", correct: false }
  ])
  q.explanation = "'systemctl enable <service>' configures the service to start at boot. 'start' only starts it now, 'restart' restarts it, and 'status' shows its state."
end

q5_4 = QuizQuestion.find_or_create_by!(quiz: module5_quiz, question_order: 4) do |q|
  q.question_text = "If a web server service is running but you can't fetch a webpage, where would you look for clues?"
  q.question_type = "multiple_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "Service logs via journalctl -u <service>", correct: true },
    { text: "Log files in /var/log/ (e.g., error log)", correct: true },
    { text: "systemctl status <service> output", correct: true },
    { text: "/etc/passwd file", correct: false }
  ])
  q.explanation = "Check service logs (journalctl, /var/log/), systemctl status for errors, and possibly firewall rules or port conflicts. /etc/passwd is for user accounts, not relevant here."
end

q5_5 = QuizQuestion.find_or_create_by!(quiz: module5_quiz, question_order: 5) do |q|
  q.question_text = "True or False: Containers allow you to run applications in isolation without installing them directly on the host OS."
  q.question_type = "true_false"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "True", correct: true },
    { text: "False", correct: false }
  ])
  q.explanation = "True. Containers package applications with their dependencies in isolated environments. The host just needs a container runtime (like Docker), not the application itself."
end

# Link items to module
module5.module_items.find_or_create_by!(item: module5_lesson, sequence_order: 1) { |mi| mi.required = true }
module5.module_items.find_or_create_by!(item: module5_lab, sequence_order: 2) { |mi| mi.required = true }
module5.module_items.find_or_create_by!(item: module5_quiz, sequence_order: 3) { |mi| mi.required = true }

puts "  ✓ Module 5: Software Package Management and Services"

# ==========================================
# MODULE 6: Networking and Security Basics (60 min)
# ==========================================

module6 = CourseModule.find_or_create_by!(slug: 'networking-security-basics', course: linux_browser_course) do |mod|
  mod.title = "Module 6: Networking and Security Basics"
  mod.description = "Display and interpret network configuration, use networking tools, understand SSH, configure firewalls, and apply basic security practices."
  mod.sequence_order = 6
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Display and interpret network configuration (IP, DNS, routes)",
    "Use networking tools: ping, traceroute, dig, netstat",
    "Understand SSH for remote login and key-based authentication",
    "Configure basic firewall with UFW to allow/restrict traffic",
    "Apply basic system security best practices"
  ])
end

module6_lesson = CourseLesson.find_or_create_by!(title: "Networking and Security Fundamentals") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Networking and Security Basics

    ## Network Configuration

    ### Viewing Network Interfaces

    **Modern command (ip):**
    ```bash
    # Show all network interfaces and IP addresses
    ip addr show
    ip a

    # Show specific interface
    ip addr show eth0

    # Show only IPv4 addresses
    ip -4 addr

    # Show only IPv6 addresses
    ip -6 addr
    ```

    **Legacy command (ifconfig):**
    ```bash
    # Show all interfaces (deprecated, but still common)
    ifconfig

    # Show specific interface
    ifconfig eth0
    ```

    ### Network Interface Names

    | Name Pattern | Type |
    |-------------|------|
    | `lo` | Loopback (127.0.0.1) |
    | `eth0`, `eth1` | Ethernet (older naming) |
    | `ens33`, `enp0s3` | Ethernet (predictable naming) |
    | `wlan0`, `wlp2s0` | Wireless |
    | `docker0` | Docker bridge network |

    ### Viewing Routes

    ```bash
    # Show routing table (modern)
    ip route show
    ip r

    # Show routing table (legacy)
    route -n
    netstat -rn
    ```

    **Sample output:**
    ```
    default via 192.168.1.1 dev eth0    # Default gateway
    192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100
    ```

    ### DNS Configuration

    **View DNS servers:**
    ```bash
    # Modern (systemd-resolved)
    systemd-resolve --status

    # Traditional
    cat /etc/resolv.conf
    ```

    **Sample /etc/resolv.conf:**
    ```
    nameserver 8.8.8.8
    nameserver 8.8.4.4
    ```

    ### Hostname

    ```bash
    # Display hostname
    hostname

    # Display FQDN (Fully Qualified Domain Name)
    hostname -f

    # Change hostname temporarily
    sudo hostname newhostname

    # Change hostname permanently
    sudo hostnamectl set-hostname newhostname

    # View hostname details
    hostnamectl
    ```

    ### /etc/hosts File

    Static hostname-to-IP mappings:

    ```bash
    # View hosts file
    cat /etc/hosts

    # Example entries
    127.0.0.1    localhost
    127.0.1.1    mycomputer
    192.168.1.10 server1.local server1
    ```

    ## Network Connectivity Tools

    ### ping - Test Reachability

    ```bash
    # Ping host (Ctrl+C to stop)
    ping google.com

    # Send specific number of packets
    ping -c 4 8.8.8.8

    # Ping with specific interval (seconds)
    ping -i 2 google.com

    # Ping localhost
    ping 127.0.0.1
    ping localhost
    ```

    **Interpreting results:**
    - **0% packet loss**: Good connectivity
    - **Time (ms)**: Lower is better (latency)
    - **TTL**: Time to live (hops remaining)

    ### traceroute - Trace Network Path

    ```bash
    # Trace route to host
    traceroute google.com

    # Use ICMP instead of UDP
    traceroute -I google.com

    # Maximum hops
    traceroute -m 20 google.com
    ```

    Useful for identifying where network issues occur along the path.

    ### dig - DNS Lookup

    ```bash
    # DNS lookup
    dig google.com

    # Short answer only
    dig +short google.com

    # Query specific record type
    dig google.com A        # IPv4 address
    dig google.com AAAA     # IPv6 address
    dig google.com MX       # Mail servers
    dig google.com NS       # Name servers

    # Query specific DNS server
    dig @8.8.8.8 google.com

    # Reverse DNS lookup
    dig -x 8.8.8.8
    ```

    ### nslookup - DNS Lookup (Alternative)

    ```bash
    # DNS lookup
    nslookup google.com

    # Query specific DNS server
    nslookup google.com 8.8.8.8
    ```

    ### netstat - Network Statistics

    ```bash
    # Show all listening ports
    sudo netstat -tulpn

    # Show all connections
    netstat -an

    # Show routing table
    netstat -rn

    # Show interface statistics
    netstat -i
    ```

    **Options:**
    - `-t`: TCP connections
    - `-u`: UDP connections
    - `-l`: Listening ports
    - `-p`: Show program/PID
    - `-n`: Numeric (don't resolve names)

    ### ss - Socket Statistics (Modern Alternative)

    ```bash
    # Show all listening TCP ports
    sudo ss -tulpn

    # Show all connections
    ss -an

    # Show process using port 80
    sudo ss -lptn 'sport = :80'
    ```

    ### curl/wget - HTTP Tools

    ```bash
    # Fetch webpage
    curl http://example.com
    wget http://example.com

    # Follow redirects
    curl -L http://example.com

    # Save to file
    curl -o output.html http://example.com
    wget -O output.html http://example.com

    # Test API endpoint
    curl https://api.github.com

    # HTTP headers only
    curl -I http://example.com
    ```

    ## SSH - Secure Shell

    ### What is SSH?

    **SSH** provides secure remote access to Linux systems over encrypted connections.

    **Default port**: 22 (TCP)

    ### Connecting via SSH

    ```bash
    # Basic connection
    ssh username@hostname

    # Specify port
    ssh -p 2222 username@hostname

    # Examples
    ssh alice@192.168.1.100
    ssh root@server.example.com
    ssh user@localhost
    ```

    ### SSH Key-Based Authentication

    **Why use SSH keys?**
    - More secure than passwords
    - No password to type (convenient)
    - Can be automated (scripts, CI/CD)

    **Generate SSH key pair:**
    ```bash
    # Generate RSA key (default)
    ssh-keygen

    # Generate ED25519 key (modern, recommended)
    ssh-keygen -t ed25519 -C "your_email@example.com"

    # Keys saved to:
    # ~/.ssh/id_rsa (private key) - Keep secret!
    # ~/.ssh/id_rsa.pub (public key) - Share this
    ```

    **Copy public key to server:**
    ```bash
    # Automatic (recommended)
    ssh-copy-id username@hostname

    # Manual
    cat ~/.ssh/id_rsa.pub | ssh username@hostname "cat >> ~/.ssh/authorized_keys"
    ```

    **SSH config (~/.ssh/config):**
    ```
    Host myserver
        HostName 192.168.1.100
        User alice
        Port 22
        IdentityFile ~/.ssh/id_rsa

    # Now just: ssh myserver
    ```

    ### SSH Service (sshd)

    ```bash
    # Check SSH service status
    systemctl status sshd
    systemctl status ssh    # Debian/Ubuntu

    # Start/stop SSH service
    sudo systemctl start sshd
    sudo systemctl stop sshd

    # SSH configuration
    sudo nano /etc/ssh/sshd_config

    # Restart after config changes
    sudo systemctl restart sshd
    ```

    **Security hardening:**
    - `PermitRootLogin no` - Disable root SSH login
    - `PasswordAuthentication no` - Require keys only
    - `Port 2222` - Change from default port 22

    ## Firewall Configuration

    ### UFW - Uncomplicated Firewall (Ubuntu/Debian)

    **Enable/Disable:**
    ```bash
    # Check status
    sudo ufw status

    # Enable firewall
    sudo ufw enable

    # Disable firewall
    sudo ufw disable

    # Verbose status
    sudo ufw status verbose
    ```

    **Allow Traffic:**
    ```bash
    # Allow port
    sudo ufw allow 22/tcp      # SSH
    sudo ufw allow 80/tcp      # HTTP
    sudo ufw allow 443/tcp     # HTTPS

    # Allow service by name
    sudo ufw allow ssh
    sudo ufw allow http
    sudo ufw allow https

    # Allow from specific IP
    sudo ufw allow from 192.168.1.100

    # Allow port range
    sudo ufw allow 3000:4000/tcp
    ```

    **Deny Traffic:**
    ```bash
    # Deny port
    sudo ufw deny 23/tcp       # Telnet

    # Deny from IP
    sudo ufw deny from 203.0.113.100
    ```

    **Remove Rules:**
    ```bash
    # Delete by rule specification
    sudo ufw delete allow 80/tcp

    # Delete by rule number
    sudo ufw status numbered
    sudo ufw delete 3
    ```

    **Default Policies:**
    ```bash
    # Set default policies
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    ```

    ### firewalld (RHEL/CentOS)

    ```bash
    # Check status
    sudo firewall-cmd --state

    # List rules
    sudo firewall-cmd --list-all

    # Allow service
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https

    # Allow port
    sudo firewall-cmd --permanent --add-port=8080/tcp

    # Reload firewall
    sudo firewall-cmd --reload
    ```

    ### iptables (Advanced)

    Low-level firewall (UFW/firewalld are frontends for iptables):

    ```bash
    # List rules
    sudo iptables -L -n -v

    # Allow port
    sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

    # Save rules (Ubuntu)
    sudo iptables-save > /etc/iptables/rules.v4
    ```

    ## Security Best Practices

    ### 1. Keep Software Updated

    ```bash
    # Update package lists and upgrade
    sudo apt update && sudo apt upgrade -y

    # Enable automatic security updates (Ubuntu)
    sudo apt install unattended-upgrades
    sudo dpkg-reconfigure -plow unattended-upgrades
    ```

    ### 2. Strong Authentication

    **Passwords:**
    - Minimum 12 characters
    - Mix of uppercase, lowercase, numbers, symbols
    - Unique per system
    - Consider password managers

    **SSH Keys:**
    - Use ED25519 or RSA 4096-bit keys
    - Protect private keys with passphrases
    - Disable password authentication

    ### 3. Principle of Least Privilege

    - Don't use root directly
    - Use sudo for admin tasks
    - Give users minimum necessary permissions
    - Remove unused user accounts

    ### 4. Firewall Configuration

    - Enable firewall
    - Default deny incoming
    - Only allow necessary ports
    - Limit SSH to specific IPs if possible

    ### 5. Disable Unnecessary Services

    ```bash
    # List enabled services
    systemctl list-unit-files --type=service --state=enabled

    # Disable unnecessary service
    sudo systemctl disable telnet
    sudo systemctl stop telnet
    ```

    ### 6. Monitor Logs

    ```bash
    # Watch authentication attempts
    sudo tail -f /var/log/auth.log

    # Check for failed SSH logins
    sudo grep "Failed password" /var/log/auth.log

    # Monitor system logs
    sudo journalctl -f
    ```

    ### 7. Use SELinux/AppArmor

    **SELinux** (RHEL/CentOS) and **AppArmor** (Ubuntu) provide mandatory access control:

    ```bash
    # Check AppArmor status (Ubuntu)
    sudo aa-status

    # Check SELinux status (RHEL/CentOS)
    getenforce
    ```

    ### 8. Regular Backups

    - Backup critical data regularly
    - Test restores periodically
    - Store backups securely offsite

    ## Summary

    In this module, you learned:
    - Display network configuration with ip, ifconfig, hostname
    - Test connectivity with ping, traceroute, dig, nslookup
    - Use SSH for secure remote access and key-based auth
    - Configure firewall with UFW to allow/deny traffic
    - Security best practices: updates, strong auth, least privilege, monitoring
  MARKDOWN
end

module6_lab = HandsOnLab.find_or_create_by!(title: "Networking and Firewall Configuration Lab") do |lab|
  lab.description = "Practice network configuration viewing, connectivity testing, SSH, and firewall configuration."
  lab.difficulty = "medium"
  lab.lab_type = "linux"
  lab.lab_format = "terminal"
  lab.estimated_minutes = 25
  lab.prerequisites = JSON.generate(["Module 1-5 completed", "sudo access"])
  lab.learning_objectives = JSON.generate([
    "View and understand network configuration",
    "Test connectivity with networking tools",
    "Use SSH for local connections",
    "Configure UFW firewall rules"
  ])
  lab.steps = JSON.generate([
    {
      title: "View Network Settings",
      instruction: "Display network interfaces, IP addresses, routes, and hostname",
      commands: [
        "ip addr show",
        "ip route",
        "hostname",
        "cat /etc/hosts"
      ],
      expected_output: "Network interfaces displayed, default gateway shown, hostname visible"
    },
    {
      title: "Test Connectivity",
      instruction: "Use ping and dig to test network connectivity and DNS",
      commands: [
        "ping -c 4 8.8.8.8",
        "ping -c 4 google.com",
        "dig google.com",
        "nslookup example.com"
      ],
      expected_output: "Successful ping responses, DNS resolution working"
    },
    {
      title: "SSH to Localhost",
      instruction: "Test SSH connection to the local machine",
      commands: [
        "ssh localhost",
        "# (accept host key, enter password)",
        "exit"
      ],
      expected_output: "Successfully connected via SSH and exited"
    },
    {
      title: "Enable UFW Firewall",
      instruction: "Configure and enable the UFW firewall",
      commands: [
        "sudo ufw status",
        "sudo ufw allow 22/tcp",
        "sudo ufw allow 80/tcp",
        "sudo ufw enable",
        "sudo ufw status verbose"
      ],
      expected_output: "Firewall enabled with SSH and HTTP allowed"
    },
    {
      title: "Test Firewall Effect",
      instruction: "View active rules and understand firewall configuration",
      commands: [
        "sudo ufw status numbered",
        "sudo netstat -tulpn | grep LISTEN",
        "curl http://localhost"
      ],
      expected_output: "Firewall rules listed, listening ports shown, HTTP still accessible"
    },
    {
      title: "Security Audit",
      instruction: "Check for available updates and review users",
      commands: [
        "sudo apt upgrade --dry-run",
        "cut -d: -f1 /etc/passwd | tail -10",
        "last -10"
      ],
      expected_output: "Available updates shown, recent user logins displayed"
    }
  ])
end

module6_quiz = Quiz.find_or_create_by!(title: "Module 6 Quiz: Networking and Security") do |quiz|
  quiz.description = "Test your knowledge of networking, SSH, firewalls, and security best practices"
  quiz.time_limit_minutes = 10
  quiz.passing_score = 80
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

q6_1 = QuizQuestion.find_or_create_by!(quiz: module6_quiz, question_order: 1) do |q|
  q.question_text = "Which command displays network interfaces and IP addresses on a modern Linux system?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "netstat", correct: false },
    { text: "ip addr show", correct: true },
    { text: "ping", correct: false },
    { text: "route", correct: false }
  ])
  q.explanation = "'ip addr show' (or 'ip a') is the modern command to display network interfaces and IP addresses. ifconfig is the legacy equivalent."
end

q6_2 = QuizQuestion.find_or_create_by!(quiz: module6_quiz, question_order: 2) do |q|
  q.question_text = "What tool can you use to check if you can reach another host on the network and measure packet loss or delay?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "dig", correct: false },
    { text: "ssh", correct: false },
    { text: "ping", correct: true },
    { text: "curl", correct: false }
  ])
  q.explanation = "ping sends ICMP echo requests to test reachability and measure round-trip time. dig is for DNS, ssh for remote access, curl for HTTP."
end

q6_3 = QuizQuestion.find_or_create_by!(quiz: module6_quiz, question_order: 3) do |q|
  q.question_text = "By default, which TCP port does the SSH service listen on?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "21", correct: false },
    { text: "22", correct: true },
    { text: "80", correct: false },
    { text: "443", correct: false }
  ])
  q.explanation = "SSH listens on TCP port 22 by default. Port 21 is FTP, 80 is HTTP, and 443 is HTTPS."
end

q6_4 = QuizQuestion.find_or_create_by!(quiz: module6_quiz, question_order: 4) do |q|
  q.question_text = "To allow web traffic through the firewall on port 80 using UFW, what command should you run?"
  q.question_type = "single_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "sudo ufw deny 80/tcp", correct: false },
    { text: "sudo ufw allow 80/tcp", correct: true },
    { text: "sudo firewall allow http", correct: false },
    { text: "sudo iptables -A INPUT 80", correct: false }
  ])
  q.explanation = "'sudo ufw allow 80/tcp' allows HTTP traffic. You can also use 'sudo ufw allow http' which does the same."
end

q6_5 = QuizQuestion.find_or_create_by!(quiz: module6_quiz, question_order: 5) do |q|
  q.question_text = "Name one security best practice for improving Linux system security."
  q.question_type = "multiple_choice"
  q.points = 20
  q.answer_choices = JSON.generate([
    { text: "Keep software up to date with security patches", correct: true },
    { text: "Use strong passwords or SSH key authentication", correct: true },
    { text: "Enable firewall and allow only necessary ports", correct: true },
    { text: "Disable all security features for convenience", correct: false }
  ])
  q.explanation = "Good practices include: keeping software updated, using strong authentication, enabling firewalls, least privilege, monitoring logs. Never disable security for convenience."
end

# Link items to module
module6.module_items.find_or_create_by!(item: module6_lesson, sequence_order: 1) { |mi| mi.required = true }
module6.module_items.find_or_create_by!(item: module6_lab, sequence_order: 2) { |mi| mi.required = true }
module6.module_items.find_or_create_by!(item: module6_quiz, sequence_order: 3) { |mi| mi.required = true }

puts "  ✓ Module 6: Networking and Security Basics"

puts "✅ Part 2 (Modules 5-6) added successfully!"
puts "📚 Total Modules: #{linux_browser_course.course_modules.count}"

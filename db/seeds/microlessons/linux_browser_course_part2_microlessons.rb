# AUTO-GENERATED from linux_browser_course_part2.rb
puts "Creating Microlessons for Package Management Services..."

module_var = CourseModule.find_by(slug: 'package-management-services')

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

'apt update' refreshes the repository index, ensuring you have the latest information on available packages and versions. 'apt upgrade' is what updates installed packages.

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

'ip addr show' (or 'ip a') is the modern command to display network interfaces and IP addresses. ifconfig is the legacy equivalent.

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

# === MICROLESSON 9: Practice Question ===
lesson_9 = MicroLesson.create!(
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

## What is this?
A concise explanation of the concept.

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

## What is this?
A concise explanation of the concept.

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

# === MICROLESSON 16: Lesson 16 ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 16',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 16 microlessons for Package Management Services"

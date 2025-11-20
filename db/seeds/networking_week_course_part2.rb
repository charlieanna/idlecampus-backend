# One-Week Networking Fundamentals Course - Part 2 (Days 4-7)
# Continuation of the browser-based hands-on networking course
puts "Adding Days 4-7 to Networking Fundamentals Course..."

networking_course = Course.find_by(slug: 'networking-fundamentals')
unless networking_course
  puts "❌ Error: networking-fundamentals course not found. Run networking_week_course.rb first."
  exit
end

# ==========================================
# DAY 4: Transport Protocols, Ports, and Network Security
# ==========================================

day4_module = CourseModule.find_or_create_by!(slug: 'day4-tcp-udp-security', course: networking_course) do |mod|
  mod.title = "Day 4: Transport Protocols, Ports, and Network Security Basics"
  mod.description = "Compare TCP and UDP transport protocols, understand ports as service identifiers, learn about firewalls and packet inspection including deep packet inspection (DPI)."
  mod.sequence_order = 4
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Compare TCP vs UDP and understand when to use each",
    "Learn about ports and how they enable multiple services",
    "Understand firewalls and how they filter traffic",
    "Grasp the concept of deep packet inspection (DPI)"
  ])
end

day4_lesson = CourseLesson.find_or_create_by!(title: "TCP vs UDP, Ports, Firewalls, and Packet Inspection") do |lesson|
  lesson.reading_time_minutes = 60
  lesson.content = <<~MARKDOWN
    # Day 4: Transport Protocols, Ports, and Network Security Basics

    ## Learning Goals

    - Compare TCP and UDP transport protocols
    - Understand ports as numerical identifiers for services
    - Learn about firewalls and how they filter traffic
    - Grasp deep packet inspection (DPI) for advanced filtering
    - Apply security controls to network services

    ## The Transport Layer: TCP vs UDP

    The **Transport Layer** (Layer 4) is responsible for end-to-end communication between applications. The two main protocols are TCP and UDP.

    ### TCP (Transmission Control Protocol)

    **Characteristics**:
    - **Connection-oriented**: Establishes connection before data transfer
    - **Reliable**: Guarantees delivery of all data in correct order
    - **Error-checked**: Detects and retransmits lost packets
    - **Flow-controlled**: Prevents overwhelming receiver
    - **Ordered**: Data arrives in the same order it was sent
    - **Overhead**: Higher due to all these features

    **TCP Three-Way Handshake**:
    ```
    Client → Server: SYN (Synchronize)
      "Let's start a connection"

    Server → Client: SYN-ACK (Synchronize-Acknowledge)
      "OK, I'm ready too"

    Client → Server: ACK (Acknowledge)
      "Great, let's begin"

    [Connection established, data transfer begins]
    ```

    **When to Use TCP**:
    - Web browsing (HTTP/HTTPS)
    - File transfer (FTP, SFTP)
    - Email (SMTP, IMAP)
    - SSH remote access
    - Database connections
    - Any application where data accuracy is critical

    **TCP Features in Detail**:
    - **Sequence numbers**: Each byte numbered for ordering
    - **Acknowledgments**: Receiver confirms receipt
    - **Retransmission**: Sender resends if ACK not received
    - **Congestion control**: Adjusts speed based on network conditions
    - **Connection termination**: Proper close with FIN packets

    ### UDP (User Datagram Protocol)

    **Characteristics**:
    - **Connectionless**: No connection setup, just send
    - **Unreliable**: No guarantee of delivery or order
    - **No error recovery**: Dropped packets are just lost
    - **Fast**: Minimal overhead (8-byte header vs TCP's 20+ bytes)
    - **Fire-and-forget**: Send and move on

    **How UDP Works**:
    ```
    Application → UDP: "Send this datagram to 8.8.8.8:53"
    UDP: "OK, sent!" [No confirmation, no tracking]
    ```

    **When to Use UDP**:
    - DNS queries (fast lookups, can retry)
    - Video streaming (occasional frame loss OK)
    - Online gaming (speed > accuracy)
    - VoIP (voice calls - better to skip than delay)
    - DHCP (simple request/response)
    - Network monitoring (SNMP)
    - Live broadcasts

    **UDP Advantages**:
    - **Low latency**: No handshake delay
    - **Less bandwidth**: Smaller headers
    - **Multicast/broadcast**: Can send to multiple recipients
    - **Simple**: Less complexity in implementation

    ### TCP vs UDP Comparison

    | Feature | TCP | UDP |
    |---------|-----|-----|
    | **Connection** | Connection-oriented | Connectionless |
    | **Reliability** | Guaranteed delivery | Best effort |
    | **Ordering** | Yes | No |
    | **Speed** | Slower (overhead) | Faster (minimal overhead) |
    | **Header Size** | 20-60 bytes | 8 bytes |
    | **Error Checking** | Extensive | Basic checksum only |
    | **Flow Control** | Yes | No |
    | **Congestion Control** | Yes | No |
    | **Use Case** | Accuracy critical | Speed critical |

    ### Real-World Analogy

    **TCP = Phone Call**:
    - Dial and wait for answer (handshake)
    - Confirm understanding ("Did you get that?")
    - Ordered conversation
    - Hang up properly at end

    **UDP = Postcard**:
    - Write and drop in mailbox
    - No confirmation of delivery
    - May arrive out of order (if sending multiple)
    - Fast and simple

    ## Ports: The "Apartment Numbers" of Networking

    **What are Ports?**

    Ports are 16-bit numbers (0-65535) that identify specific services or applications on a device. They allow multiple network services to run on the same IP address.

    **Analogy**: If an IP address is like a building address, a port is like an apartment number.

    ### Port Ranges

    | Range | Name | Purpose | Examples |
    |-------|------|---------|----------|
    | 0-1023 | **Well-Known Ports** | System/standard services | 80 (HTTP), 443 (HTTPS), 22 (SSH) |
    | 1024-49151 | **Registered Ports** | User/vendor applications | 3306 (MySQL), 5432 (PostgreSQL) |
    | 49152-65535 | **Dynamic/Ephemeral** | Temporary client ports | Random ports for outgoing connections |

    ### Common Well-Known Ports

    | Port | Protocol | Service | Description |
    |------|----------|---------|-------------|
    | **20/21** | TCP | FTP | File Transfer (Data/Control) |
    | **22** | TCP | SSH | Secure Shell (remote access) |
    | **23** | TCP | Telnet | Insecure remote access |
    | **25** | TCP | SMTP | Email sending |
    | **53** | TCP/UDP | DNS | Domain name resolution |
    | **67/68** | UDP | DHCP | Dynamic IP configuration |
    | **80** | TCP | HTTP | Web traffic (unencrypted) |
    | **110** | TCP | POP3 | Email retrieval |
    | **143** | TCP | IMAP | Email access |
    | **443** | TCP | HTTPS | Secure web traffic (TLS/SSL) |
    | **3389** | TCP | RDP | Windows Remote Desktop |
    | **3306** | TCP | MySQL | MySQL database |
    | **5432** | TCP | PostgreSQL | PostgreSQL database |
    | **6379** | TCP | Redis | Redis cache |
    | **8080** | TCP | HTTP Alt | Alternative HTTP port |
    | **27017** | TCP | MongoDB | MongoDB database |

    ### How Ports Work

    **Example**: Web server running multiple services

    ```
    Server IP: 192.168.1.10

    Port 80:   HTTP web server (Apache)
    Port 443:  HTTPS web server (Apache with SSL)
    Port 22:   SSH server (OpenSSH)
    Port 3306: MySQL database
    ```

    **Client Connection**:
    ```
    Client: 192.168.1.100:54321 → Server: 192.168.1.10:80
            [Random source port]    [Destination: HTTP service]
    ```

    ### Socket = IP + Port

    A **socket** is the combination of IP address and port:
    - **192.168.1.10:80** ← Socket
    - Uniquely identifies an endpoint for network communication

    ## Firewalls: Network Traffic Gatekeepers

    ### What is a Firewall?

    A **firewall** is a security device or software that monitors and controls network traffic based on predetermined security rules.

    **Purpose**:
    - Block unauthorized access
    - Allow legitimate traffic
    - Protect against attacks
    - Enforce security policies

    ### Types of Firewalls

    1. **Packet Filtering Firewall**:
       - Inspects packets at network/transport layers
       - Checks: Source IP, Dest IP, Protocol, Port
       - Fast but basic

    2. **Stateful Firewall**:
       - Tracks connection state (connection table)
       - Understands TCP handshakes and sessions
       - Automatically allows return traffic
       - More intelligent than packet filtering

    3. **Application Layer Firewall** (Proxy):
       - Inspects application-layer protocols (HTTP, FTP, etc.)
       - Can filter based on URLs, content
       - Acts as intermediary between client and server

    4. **Next-Generation Firewall (NGFW)**:
       - Deep packet inspection
       - Intrusion prevention (IPS)
       - Application awareness
       - Threat intelligence integration

    ### Firewall Rules

    **Basic Rule Structure**:
    ```
    [Action] [Protocol] [Source IP]:[Source Port] → [Dest IP]:[Dest Port]

    Examples:
    ALLOW TCP from 192.168.1.0/24 port ANY to 10.0.0.5 port 443
    DENY  TCP from ANY port ANY to ANY port 23 (block Telnet)
    ALLOW UDP from ANY port ANY to 8.8.8.8 port 53 (allow DNS)
    ```

    **Rule Evaluation**:
    - Firewalls process rules in order (top to bottom)
    - First matching rule wins
    - Default action: Usually DENY (implicit deny)

    ### Host-Based vs Network Firewalls

    **Host-Based Firewall**:
    - Software running on individual device
    - Examples: Windows Firewall, iptables (Linux), UFW (Ubuntu)
    - Protects single host
    - Customized per device

    **Network Firewall**:
    - Dedicated device at network boundary
    - Examples: Cisco ASA, Palo Alto, pfSense
    - Protects entire network
    - Centralized management

    ### Firewall in Cloud Environments

    **AWS**:
    - **Security Groups**: Stateful firewall for EC2 instances
    - **Network ACLs**: Stateless firewall for subnets

    **Azure**:
    - **Network Security Groups (NSGs)**: Filter traffic to/from resources
    - **Azure Firewall**: Managed firewall service

    **GCP**:
    - **VPC Firewall Rules**: Control traffic to/from instances

    ### Common Firewall Configurations

    **Web Server Example**:
    ```
    ALLOW TCP from ANY to SERVER_IP port 80 (HTTP)
    ALLOW TCP from ANY to SERVER_IP port 443 (HTTPS)
    ALLOW TCP from ADMIN_IP to SERVER_IP port 22 (SSH - admin only)
    DENY  TCP from ANY to SERVER_IP port ANY (default deny)
    ```

    **Database Server Example**:
    ```
    ALLOW TCP from APP_SERVERS to DB_IP port 3306 (MySQL)
    ALLOW TCP from ADMIN_IP to DB_IP port 22 (SSH - admin only)
    DENY  TCP from ANY to DB_IP port ANY (default deny all else)
    ```

    ## Deep Packet Inspection (DPI)

    ### What is DPI?

    **Deep Packet Inspection** examines the contents (payload) of packets, not just headers. It goes beyond Layer 4 to analyze application-layer data.

    **Traditional Firewall**:
    ```
    Checks: Source IP, Dest IP, Protocol, Port
    Decision: "This is HTTPS to port 443 - ALLOW"
    ```

    **DPI-Enabled Device**:
    ```
    Checks: Everything above PLUS payload content
    Analyzes: URLs, file types, application protocols, data patterns
    Decision: "This is HTTPS to port 443, but contains malware signature - BLOCK"
    ```

    ### DPI Capabilities

    1. **Application Identification**:
       - Detect apps even on non-standard ports
       - Example: BitTorrent running on port 80 (disguised as HTTP)

    2. **Content Filtering**:
       - Block specific file types
       - Filter URLs and domains
       - Prevent data exfiltration

    3. **Intrusion Detection/Prevention (IDS/IPS)**:
       - Detect attack patterns (SQL injection, XSS, etc.)
       - Block malicious traffic in real-time
       - Signature and anomaly-based detection

    4. **Quality of Service (QoS)**:
       - Prioritize traffic by application
       - Example: Prioritize video calls over file downloads

    5. **Data Loss Prevention (DLP)**:
       - Detect sensitive data leaving network
       - Block credit card numbers, SSNs, confidential docs

    ### DPI Use Cases

    **Positive Uses**:
    - Malware detection and blocking
    - Intrusion prevention
    - Network optimization and QoS
    - Regulatory compliance (monitor for violations)

    **Controversial Uses**:
    - Content censorship by governments
    - ISP traffic shaping (throttling)
    - Privacy concerns (reading packet contents)

    ### DPI Limitations

    - **Encryption**: Can't inspect encrypted traffic (HTTPS, VPN) without decryption
      - Some DPI devices use SSL/TLS interception (controversial)
    - **Performance**: DPI is computationally expensive
    - **Privacy**: Raises ethical and legal concerns

    ### DPI in Security Tools

    **IDS/IPS Systems**:
    - Snort
    - Suricata
    - Zeek (formerly Bro)

    **Next-Gen Firewalls**:
    - Palo Alto Networks
    - Fortinet FortiGate
    - Cisco Firepower

    ## Putting It All Together

    ### Securing a Web Application

    **Scenario**: E-commerce site with web, app, and database tiers

    **Architecture**:
    ```
    Internet → Firewall → Load Balancer (Port 443) → Web Servers (Port 80/443)
                                                   → App Servers (Port 8080)
                                                   → Database (Port 3306)
    ```

    **Firewall Rules**:
    ```
    1. ALLOW TCP from ANY to LOAD_BALANCER port 443 (HTTPS from internet)
    2. ALLOW TCP from LOAD_BALANCER to WEB_SERVERS port 80, 443
    3. ALLOW TCP from WEB_SERVERS to APP_SERVERS port 8080
    4. ALLOW TCP from APP_SERVERS to DATABASE port 3306
    5. ALLOW TCP from ADMIN_NET to ALL port 22 (SSH for admins)
    6. DENY ALL (default deny)
    ```

    **Security Layers**:
    - **Perimeter Firewall**: Protects from internet threats
    - **DPI/IPS**: Detects and blocks application-layer attacks
    - **Internal Firewalls**: Segment tiers (web, app, DB)
    - **Host Firewalls**: Additional protection on each server
    - **Security Groups** (if in cloud): Instance-level filtering

    ### Traffic Flow Example

    **Legitimate User**:
    ```
    1. User browser → Firewall → Load Balancer:443 [HTTPS] ✓ Allowed
    2. Load Balancer → Web Server:80 [HTTP] ✓ Allowed
    3. Web Server → App Server:8080 [HTTP] ✓ Allowed
    4. App Server → Database:3306 [MySQL] ✓ Allowed
    5. Responses flow back through same path
    ```

    **Attacker Attempt**:
    ```
    1. Attacker → Database:3306 [Attempt direct DB access] ✗ Blocked by firewall
    2. Attacker → Web Server:22 [SSH brute force] ✗ Blocked (SSH only from admin net)
    3. Attacker → Web Server:443 [SQL injection in HTTP] ✗ Detected and blocked by DPI/IPS
    ```

    ## Key Takeaways

    1. **TCP** is reliable and connection-oriented (use for accuracy)
    2. **UDP** is fast and connectionless (use for speed)
    3. **Ports** identify services; well-known ports are 0-1023
    4. **Firewalls** control traffic based on IP, port, protocol, and state
    5. **Stateful firewalls** track connections and allow return traffic
    6. **Deep Packet Inspection** analyzes packet content for advanced filtering
    7. **Cloud security groups** act as virtual firewalls for instances
    8. **Defense in depth** uses multiple firewall layers for better security

    ## Security Best Practices

    1. **Principle of Least Privilege**: Only allow necessary ports and IPs
    2. **Default Deny**: Block everything, then allow only what's needed
    3. **Segment Networks**: Use firewalls to isolate tiers (web, app, DB)
    4. **Regular Audits**: Review and update firewall rules
    5. **Monitor Logs**: Track denied connections and attacks
    6. **Disable Unused Services**: Close ports not in use
    7. **Use Encryption**: HTTPS, SSH, VPN to protect data in transit
    8. **Keep Updated**: Patch firewalls and security systems regularly
  MARKDOWN

  lesson.key_concepts = JSON.generate([
    "TCP vs UDP characteristics and use cases",
    "Port numbers and socket addressing",
    "Firewall types and rule configuration",
    "Stateful vs stateless filtering",
    "Deep packet inspection capabilities",
    "Cloud security groups and network ACLs"
  ])
end

ModuleItem.find_or_create_by!(
  course_module: day4_module,
  item: day4_lesson,
  sequence_order: 1
) do |item|
  item.required = true
end

puts "  ✓ Day 4 Module and Lesson"

# ==========================================
# DAY 5: Network Troubleshooting Tools
# ==========================================

day5_module = CourseModule.find_or_create_by!(slug: 'day5-troubleshooting-tools', course: networking_course) do |mod|
  mod.title = "Day 5: Network Troubleshooting Tools and Techniques"
  mod.description = "Master fundamental network troubleshooting tools: ping, traceroute, dig, netstat/ss, and curl. Learn when and how to use each tool to systematically diagnose network issues."
  mod.sequence_order = 5
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Use ping to test connectivity and measure latency",
    "Trace network paths with traceroute",
    "Query DNS records with dig",
    "Inspect network connections with netstat/ss",
    "Test HTTP endpoints with curl"
  ])
end

day5_lesson = CourseLesson.find_or_create_by!(title: "Essential Network Troubleshooting Tools") do |lesson|
  lesson.reading_time_minutes = 55
  lesson.content = <<~MARKDOWN
    # Day 5: Network Troubleshooting Tools and Techniques

    ## Learning Goals

    - Master fundamental network troubleshooting tools
    - Know when and how to use each tool
    - Systematically diagnose network issues
    - Build a troubleshooting methodology

    ## The Troubleshooting Toolkit

    Every DevOps engineer should master these essential network tools:

    1. **ping** - Basic connectivity testing
    2. **traceroute/tracepath** - Path analysis
    3. **dig/nslookup** - DNS queries
    4. **netstat/ss** - Socket and connection inspection
    5. **curl/wget** - HTTP client testing

    ## 1. ping - The First Responder

    ### What is ping?

    **ping** sends ICMP Echo Request packets to a target and waits for Echo Reply. It's the most basic connectivity test.

    **Protocol**: ICMP (Internet Control Message Protocol) at Layer 3

    ### Basic Usage

    ```bash
    # Ping a host (Ctrl+C to stop)
    ping google.com

    # Ping with count (send 4 packets)
    ping -c 4 google.com

    # Ping with interval (1 packet per 2 seconds)
    ping -i 2 google.com

    # Ping with specific packet size
    ping -s 1000 google.com

    # Ping with timeout
    ping -W 2 google.com
    ```

    ### Reading ping Output

    ```
    $ ping -c 4 google.com
    PING google.com (142.250.64.78): 56 data bytes
    64 bytes from 142.250.64.78: icmp_seq=0 ttl=117 time=15.2 ms
    64 bytes from 142.250.64.78: icmp_seq=1 ttl=117 time=14.8 ms
    64 bytes from 142.250.64.78: icmp_seq=2 ttl=117 time=15.1 ms
    64 bytes from 142.250.64.78: icmp_seq=3 ttl=117 time=15.3 ms

    --- google.com ping statistics ---
    4 packets transmitted, 4 packets received, 0.0% packet loss
    round-trip min/avg/max/stddev = 14.8/15.1/15.3/0.2 ms
    ```

    **Key Metrics**:
    - **time (RTT)**: Round-trip time in milliseconds (latency)
    - **ttl**: Time To Live (hops remaining, decremented by each router)
    - **packet loss**: Percentage of packets lost
    - **min/avg/max**: Latency statistics

    ### What ping Tells You

    ✅ **Success**: Host is reachable, network path exists
    - Good latency (< 50ms): Excellent
    - Moderate latency (50-150ms): Acceptable
    - High latency (> 150ms): Investigate

    ❌ **Request timeout**: Packets not returning
    - Host down
    - Firewall blocking ICMP
    - Network congestion
    - No route to host

    ❌ **Destination host unreachable**: No route exists
    - Network not configured
    - Routing problem
    - No default gateway

    ### ping Limitations

    - **ICMP may be blocked**: Some networks/firewalls block ping for security
    - **Doesn't test application layer**: Ping success doesn't mean HTTP works
    - **Can't check specific ports**: Use other tools for port testing

    ### When to Use ping

    - ✅ Quick connectivity check
    - ✅ Measure network latency
    - ✅ Test if host is up
    - ✅ Verify DNS resolution (ping by hostname)
    - ✅ Test network stability (continuous ping)

    ## 2. traceroute - The Path Mapper

    ### What is traceroute?

    **traceroute** (Linux/Mac) or **tracert** (Windows) maps the path packets take to reach a destination by revealing each router hop.

    **How it works**: Sends packets with incrementing TTL values, forcing routers to respond with ICMP Time Exceeded messages.

    ### Basic Usage

    ```bash
    # Trace route to host
    traceroute google.com

    # Trace route with max hops
    traceroute -m 20 google.com

    # Use ICMP instead of UDP (Linux)
    traceroute -I google.com

    # Windows equivalent
    tracert google.com
    ```

    ### Reading traceroute Output

    ```
    $ traceroute google.com
    traceroute to google.com (142.250.64.78), 30 hops max, 60 byte packets
     1  router.local (192.168.1.1)  2.345 ms  2.123 ms  2.456 ms
     2  10.0.0.1 (10.0.0.1)  5.678 ms  5.432 ms  5.789 ms
     3  isp-gateway.net (203.0.113.1)  12.345 ms  11.234 ms  12.678 ms
     4  core-router.isp.net (203.0.114.5)  15.456 ms  14.789 ms  15.123 ms
     5  peer-exchange.net (198.51.100.10)  18.234 ms  17.890 ms  18.567 ms
     6  google-peer.net (142.250.64.1)  20.123 ms  19.876 ms  20.456 ms
     7  142.250.64.78 (142.250.64.78)  21.234 ms  20.987 ms  21.567 ms
    ```

    **Each line shows**:
    - **Hop number**: Sequential router number
    - **Hostname/IP**: Router identification
    - **Three RTT values**: Latency for three probe packets

    ### Interpreting traceroute

    **Normal**: Each hop has reasonable latency, incremental increase
    ```
     1  2ms
     2  5ms
     3  12ms
     4  15ms  ← Each hop adds ~3-5ms
    ```

    **Problem Indicators**:

    ```
     1  router.local (192.168.1.1)  2ms
     2  * * *  ← Timeout: Router not responding
     3  isp-gateway.net (203.0.113.1)  450ms  ← High latency spike
     4  * * *
     5  * * *  ← Multiple timeouts: Likely blocked or route issue
    ```

    **Asterisks (* * *)**:
    - Router not responding to probe packets
    - ICMP blocked by firewall
    - Router configured not to respond
    - Doesn't always mean a problem if destination is reached

    ### Modern Alternative: mtr

    **mtr** (My Traceroute) combines ping + traceroute in real-time:

    ```bash
    # Install: apt-get install mtr (Linux) or brew install mtr (Mac)
    mtr google.com
    ```

    Continuously shows:
    - All hops
    - Packet loss percentage per hop
    - Latency statistics (avg, best, worst)
    - More accurate than single traceroute run

    ### When to Use traceroute

    - ✅ Identify where connection fails (which hop)
    - ✅ Measure latency increase across path
    - ✅ Verify routing path
    - ✅ Diagnose intermittent connectivity
    - ✅ Troubleshoot slow connections

    ## 3. dig - The DNS Interrogator

    ### What is dig?

    **dig** (Domain Information Groper) queries DNS servers to retrieve DNS records. It's the preferred DNS troubleshooting tool.

    **Alternative**: `nslookup` (older, simpler but less detailed)

    ### Basic Usage

    ```bash
    # Basic DNS query (A record)
    dig example.com

    # Query specific DNS server
    dig @8.8.8.8 example.com

    # Query specific record type
    dig example.com MX    # Mail servers
    dig example.com AAAA  # IPv6 address
    dig example.com TXT   # Text records
    dig example.com NS    # Nameservers

    # Short answer only
    dig +short example.com

    # Reverse DNS lookup (IP to hostname)
    dig -x 8.8.8.8

    # Trace DNS resolution path
    dig +trace example.com
    ```

    ### Reading dig Output

    ```
    $ dig example.com

    ; <<>> DiG 9.16.1 <<>> example.com
    ;; QUESTION SECTION:
    ;example.com.                   IN      A

    ;; ANSWER SECTION:
    example.com.            3600    IN      A       93.184.216.34

    ;; Query time: 12 msec
    ;; SERVER: 8.8.8.8#53(8.8.8.8)
    ;; WHEN: Wed Nov 06 10:30:00 UTC 2024
    ;; MSG SIZE  rcvd: 56
    ```

    **Sections**:
    - **QUESTION**: What you asked for
    - **ANSWER**: The DNS response
    - **AUTHORITY**: Authoritative nameservers (if shown)
    - **ADDITIONAL**: Additional helpful records
    - **Query time**: How long DNS lookup took
    - **SERVER**: Which DNS server answered

    ### Common DNS Record Types

    | Record | Purpose | Example |
    |--------|---------|---------|
    | **A** | IPv4 address | example.com → 93.184.216.34 |
    | **AAAA** | IPv6 address | example.com → 2606:2800:220:1:... |
    | **CNAME** | Alias/canonical name | www.example.com → example.com |
    | **MX** | Mail server | example.com → mail.example.com (priority 10) |
    | **TXT** | Text info | SPF, DKIM, verification |
    | **NS** | Nameserver | example.com → ns1.provider.com |
    | **SOA** | Start of authority | Zone information |
    | **PTR** | Reverse DNS | 93.184.216.34 → example.com |

    ### Troubleshooting with dig

    **Test if DNS is working**:
    ```bash
    dig google.com
    # If returns IP → DNS working
    # If timeout → DNS server issue
    ```

    **Compare different DNS servers**:
    ```bash
    dig @8.8.8.8 example.com       # Google DNS
    dig @1.1.1.1 example.com       # Cloudflare DNS
    dig example.com                # System default DNS
    ```

    **Check DNS propagation** (after changing DNS):
    ```bash
    dig @ns1.example.com example.com  # Query authoritative nameserver directly
    ```

    **Verify MX records** (email troubleshooting):
    ```bash
    dig example.com MX
    ```

    ### When to Use dig

    - ✅ Verify DNS resolution
    - ✅ Troubleshoot "can't resolve hostname" errors
    - ✅ Check DNS record changes/propagation
    - ✅ Compare DNS servers
    - ✅ Diagnose email delivery (MX records)

    ## 4. netstat/ss - The Connection Inspector

    ### What is netstat/ss?

    **netstat** (network statistics) and **ss** (socket statistics) display network connections, listening ports, and routing tables.

    **Note**: `ss` is the modern replacement for `netstat` on Linux, faster and more detailed.

    ### Basic Usage

    ```bash
    # Show all listening ports
    netstat -tuln       # Linux
    netstat -an | grep LISTEN  # Mac
    ss -tuln            # Modern Linux

    # Show all established connections
    netstat -tun
    ss -tun

    # Show listening TCP ports with process info (requires sudo)
    netstat -tlnp
    ss -tlnp

    # Show all connections with process info
    netstat -tunap
    ss -tunap

    # Show routing table
    netstat -r
    route -n
    ip route
    ```

    **Common Flags**:
    - `-t`: TCP
    - `-u`: UDP
    - `-l`: Listening ports
    - `-n`: Show numbers (don't resolve names)
    - `-p`: Show process/PID
    - `-a`: All (listening + established)

    ### Reading netstat/ss Output

    ```
    $ ss -tuln
    Netid  State   Recv-Q Send-Q Local Address:Port    Peer Address:Port
    tcp    LISTEN  0      128    0.0.0.0:22            0.0.0.0:*
    tcp    LISTEN  0      128    0.0.0.0:80            0.0.0.0:*
    tcp    ESTAB   0      0      192.168.1.100:54321   142.250.64.78:443
    tcp    LISTEN  0      128    127.0.0.1:3306        0.0.0.0:*
    udp    UNCONN  0      0      0.0.0.0:68            0.0.0.0:*
    ```

    **Columns**:
    - **Netid/Proto**: Protocol (TCP/UDP)
    - **State**: Connection state
    - **Local Address:Port**: Local endpoint
    - **Peer Address:Port**: Remote endpoint (if connected)

    **Connection States**:
    - **LISTEN**: Server waiting for connections
    - **ESTABLISHED**: Active connection
    - **TIME_WAIT**: Connection closed, waiting for cleanup
    - **CLOSE_WAIT**: Remote closed, local still open
    - **SYN_SENT**: Attempting connection

    ### What netstat/ss Tells You

    **Check if service is listening**:
    ```bash
    $ ss -tuln | grep :80
    tcp    LISTEN  0  128  0.0.0.0:80    0.0.0.0:*
    # ✅ Web server is listening on port 80
    ```

    **Check which interface service binds to**:
    ```
    0.0.0.0:3306      # Listening on ALL interfaces (accessible externally)
    127.0.0.1:3306    # Listening ONLY on localhost (not accessible externally)
    ```

    **Check active connections**:
    ```bash
    $ ss -tn | grep ESTAB
    # Shows all active TCP connections
    ```

    **Find which process is using a port**:
    ```bash
    $ sudo ss -tlnp | grep :80
    tcp   LISTEN  0  128  0.0.0.0:80   0.0.0.0:*   users:(("nginx",pid=1234,fd=6))
    # nginx process (PID 1234) is using port 80
    ```

    ### When to Use netstat/ss

    - ✅ Verify service is listening on correct port
    - ✅ Check if port is already in use
    - ✅ See active connections to/from server
    - ✅ Troubleshoot "connection refused" errors
    - ✅ Find which process is using a port
    - ✅ Verify service binds to correct interface

    ## 5. curl - The HTTP Swiss Army Knife

    ### What is curl?

    **curl** (Client URL) is a command-line tool for transferring data using various protocols, primarily HTTP/HTTPS.

    **Alternative**: `wget` (simpler, mainly for downloading files)

    ### Basic Usage

    ```bash
    # Simple GET request
    curl example.com

    # Show HTTP headers only
    curl -I example.com

    # Verbose output (see full request/response)
    curl -v example.com

    # Follow redirects
    curl -L example.com

    # Save output to file
    curl -o output.html example.com

    # POST request with data
    curl -X POST -d "key=value" example.com/api

    # POST JSON data
    curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' example.com/api

    # Custom headers
    curl -H "Authorization: Bearer TOKEN" example.com/api

    # Test specific HTTP method
    curl -X DELETE example.com/api/resource/123

    # Timeout
    curl --connect-timeout 5 example.com

    # Test HTTPS certificate
    curl -vI https://example.com 2>&1 | grep -i cert
    ```

    ### Reading curl Output

    **Simple request**:
    ```bash
    $ curl example.com
    <!doctype html>
    <html>
    <head>
        <title>Example Domain</title>
    ...
    ```

    **Headers only** (-I):
    ```bash
    $ curl -I https://example.com
    HTTP/2 200
    content-type: text/html; charset=UTF-8
    date: Wed, 06 Nov 2024 10:30:00 GMT
    server: nginx
    ```

    **Verbose** (-v):
    ```bash
    $ curl -v https://example.com
    * Trying 93.184.216.34:443...
    * Connected to example.com (93.184.216.34) port 443
    * TLS handshake...
    > GET / HTTP/2
    > Host: example.com
    > User-Agent: curl/7.68.0
    > Accept: */*
    <
    < HTTP/2 200
    < content-type: text/html
    ...
    ```

    **Status Codes**:
    - **2xx**: Success (200 OK, 201 Created, 204 No Content)
    - **3xx**: Redirection (301 Moved Permanently, 302 Found, 304 Not Modified)
    - **4xx**: Client Error (400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found)
    - **5xx**: Server Error (500 Internal Server Error, 502 Bad Gateway, 503 Service Unavailable)

    ### Troubleshooting with curl

    **Test if web service is up**:
    ```bash
    curl -I http://myserver:8080
    # 200 OK → Service is up
    # Connection refused → Service not listening
    # Timeout → Network/firewall issue
    ```

    **Test from server to server**:
    ```bash
    # On Server A, test if can reach Server B's API
    curl http://serverb:3000/health
    ```

    **Test API endpoint**:
    ```bash
    curl -X POST http://api.example.com/login \\
      -H "Content-Type: application/json" \\
      -d '{"username":"test","password":"test"}'
    ```

    **Debug SSL/TLS issues**:
    ```bash
    curl -vI https://example.com
    # Look for certificate errors, handshake failures
    ```

    ### When to Use curl

    - ✅ Test HTTP/HTTPS endpoints
    - ✅ Verify API functionality
    - ✅ Check if web service is responding
    - ✅ Test load balancers
    - ✅ Debug SSL/TLS issues
    - ✅ Automate HTTP requests in scripts

    ## Systematic Troubleshooting Methodology

    ### The Layer-by-Layer Approach

    When facing a connectivity issue, work bottom-up through the OSI model:

    **1. Physical Layer** (Is the cable plugged in?)
    - Check physical connections
    - Verify interface is up: `ip link show`

    **2. Data Link Layer** (Is the local network working?)
    - Check MAC address: `ip addr show`
    - Verify switch connectivity

    **3. Network Layer** (Can I reach the IP?)
    ```bash
    ping <target_ip>
    # Success → Network layer OK
    # Failure → Routing or connectivity issue
    ```

    **4. Transport Layer** (Is the port open?)
    ```bash
    # On server: ss -tuln | grep :<port>
    # On client: curl <server>:<port> or telnet <server> <port>
    ```

    **5. Application Layer** (Is the service working?)
    ```bash
    curl http://<server>:<port>/health
    # Check application logs
    ```

    ### Common Scenarios

    **Scenario 1: "I can't reach my website"**

    ```bash
    # Step 1: Can you resolve the domain?
    dig example.com
    # If fails → DNS issue (check DNS servers, domain configuration)

    # Step 2: Can you ping the IP?
    ping 93.184.216.34
    # If fails → Network connectivity issue (routing, firewall, host down)

    # Step 3: Can you reach the web server?
    curl -I http://93.184.216.34
    # If fails → Web server not running, firewall blocking port 80

    # Step 4: Check if server is listening
    ssh into server
    ss -tuln | grep :80
    # If not listening → Web server not running or bound to wrong interface
    ```

    **Scenario 2: "Service is slow"**

    ```bash
    # Step 1: Check network latency
    ping <server>
    # High latency → Network congestion, routing issue

    # Step 2: Trace the path
    traceroute <server>
    # Identify which hop has high latency

    # Step 3: Check server load
    ssh into server
    top  # Check CPU, memory usage
    ```

    **Scenario 3: "Can ping but can't connect to service"**

    ```bash
    # Ping works → Network Layer OK
    # Service doesn't → Transport or Application Layer issue

    # Check if port is open
    curl -v telnet://<server>:<port>

    # On server, check if listening
    ss -tuln | grep :<port>

    # Check firewall
    sudo iptables -L -n | grep <port>
    sudo ufw status | grep <port>
    ```

    ## Key Takeaways

    1. **ping**: Test basic connectivity and latency (Layer 3)
    2. **traceroute**: Map network path and find bottlenecks
    3. **dig**: Query DNS and troubleshoot name resolution (Layer 7)
    4. **netstat/ss**: Inspect listening ports and active connections (Layer 4)
    5. **curl**: Test HTTP endpoints and APIs (Layer 7)
    6. **Troubleshoot systematically**: Bottom-up through OSI layers
    7. **Combine tools**: Use multiple tools to narrow down the issue
    8. **Document findings**: Track what works and what doesn't

    ## Quick Reference Card

    | Problem | First Tool | Then Use |
    |---------|-----------|----------|
    | Can't reach host | `ping` | `traceroute`, check routing |
    | Can't resolve name | `dig` | Check DNS servers, `/etc/resolv.conf` |
    | Connection refused | `ss -tuln` on server | Check if service running, firewall |
    | Service slow | `ping` for latency | `mtr`, check server load |
    | HTTP not working | `curl -v` | Check headers, status codes, errors |
    | Port in use | `ss -tulnp | grep :port` | Find process, kill or use different port |
  MARKDOWN

  lesson.key_concepts = JSON.generate([
    "ping for connectivity testing and latency measurement",
    "traceroute/mtr for path analysis",
    "dig for DNS troubleshooting",
    "netstat/ss for socket and port inspection",
    "curl for HTTP testing",
    "Systematic troubleshooting methodology"
  ])
end

ModuleItem.find_or_create_by!(
  course_module: day5_module,
  item: day5_lesson,
  sequence_order: 1
) do |item|
  item.required = true
end

puts "  ✓ Day 5 Module and Lesson"

puts "\n✅ Days 4-5 added successfully!"
puts "   - Day 4: TCP/UDP, Ports, and Security"
puts "   - Day 5: Troubleshooting Tools"
puts "   - Days 6-7 will be added in part 3"

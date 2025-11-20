# AUTO-GENERATED from networking_course_complete.rb
puts "Creating Microlessons for Tcp Ip Fundamentals..."

module_var = CourseModule.find_by(slug: 'tcp-ip-fundamentals')

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

# DNS Fundamentals

    Domain Name System translates human-readable names to IP addresses.

    ## What is DNS?

    **DNS**: Distributed database mapping domain names → IP addresses.

    Example:
    ```
    google.com → 142.250.80.46
    ```

    Without DNS, you'd need to remember IP addresses for every website!

    ## DNS Hierarchy

    ```
    Root (.)
    ├── .com
    │   ├── google.com
    │   │   ├── www.google.com
    │   │   └── mail.google.com
    │   └── amazon.com
    ├── .org
    │   └── wikipedia.org
    └── .net
        └── example.net
    ```

    ### DNS Components

    **1. Root Servers**
    - 13 root server clusters (a.root-servers.net to m.root-servers.net)
    - Top of DNS hierarchy
    - Operated by different organizations

    **2. TLD Servers** (Top-Level Domain)
    - `.com`, `.org`, `.net`, `.edu`
    - Country codes: `.uk`, `.jp`, `.de`
    - New TLDs: `.app`, `.dev`, `.cloud`

    **3. Authoritative Name Servers**
    - Store DNS records for domains
    - Answer queries with actual data

    **4. Recursive Resolvers**
    - Query on behalf of clients
    - Cache responses
    - Usually your ISP or 8.8.8.8 (Google), 1.1.1.1 (Cloudflare)

    ## DNS Resolution Process

    **Query: www.example.com**

    ```
    1. Client → Recursive Resolver: "What's www.example.com?"
    2. Resolver → Root Server: "Where's .com?"
    3. Root → Resolver: "Ask TLD server at 192.x.x.x"
    4. Resolver → TLD Server: "Where's example.com?"
    5. TLD → Resolver: "Ask authoritative server at 93.x.x.x"
    6. Resolver → Authoritative: "What's www.example.com?"
    7. Authoritative → Resolver: "It's 93.184.216.34"
    8. Resolver → Client: "www.example.com is 93.184.216.34"
    ```

    ## DNS Record Types

    ### A Record (Address)
    Map domain to IPv4 address.

    ```
    example.com.  IN  A  93.184.216.34
    ```

    ### AAAA Record
    Map domain to IPv6 address.

    ```
    example.com.  IN  AAAA  2606:2800:220:1:248:1893:25c8:1946
    ```

    ### CNAME Record (Canonical Name)
    Alias one domain to another.

    ```
    www.example.com.  IN  CNAME  example.com.
    blog.example.com. IN  CNAME  example.com.
    ```

    Use when: Multiple names point to same destination.

    ### MX Record (Mail Exchange)
    Specify mail servers.

    ```
    example.com.  IN  MX  10  mail1.example.com.
    example.com.  IN  MX  20  mail2.example.com.
    ```

    Priority: Lower number = higher priority.

    ### TXT Record
    Store arbitrary text (SPF, DKIM, verification).

    ```
    example.com.  IN  TXT  "v=spf1 mx -all"
    _dmarc.example.com.  IN  TXT  "v=DMARC1; p=reject"
    ```

    ### NS Record (Name Server)
    Delegate subdomain to name servers.

    ```
    example.com.  IN  NS  ns1.example.com.
    example.com.  IN  NS  ns2.example.com.
    ```

    ### PTR Record (Pointer)
    Reverse DNS (IP → domain).

    ```
    34.216.184.93.in-addr.arpa.  IN  PTR  example.com.
    ```

    ### SRV Record (Service)
    Specify service location.

    ```
    _http._tcp.example.com.  IN  SRV  10 5 80 www.example.com.
    ```

    ## DNS Commands

    ### dig (Domain Information Groper)
    ```bash
    # Basic query
    dig example.com

    # Query specific record type
    dig example.com MX
    dig example.com AAAA

    # Query specific DNS server
    dig @8.8.8.8 example.com

    # Short answer only
    dig +short example.com

    # Trace resolution path
    dig +trace example.com

    # Reverse DNS lookup
    dig -x 93.184.216.34
    ```

    ### nslookup
    ```bash
    # Basic query
    nslookup example.com

    # Query specific server
    nslookup example.com 8.8.8.8

    # Interactive mode
    nslookup
    > set type=MX
    > example.com
    ```

    ### host
    ```bash
    # Basic query
    host example.com

    # Query MX records
    host -t MX example.com

    # Query all records
    host -a example.com
    ```

    ## DNS Caching

    **TTL** (Time To Live): How long to cache a record.

    ```
    example.com.  300  IN  A  93.184.216.34
                  ^^^
                  TTL in seconds (5 minutes)
    ```

    **Cache Levels**:
    1. Browser cache (~1 minute)
    2. OS cache (~1 minute)
    3. Recursive resolver cache (TTL value)

    ## DNS Security

    ### DNSSEC (DNS Security Extensions)
    Cryptographically sign DNS records.

    **Prevents**:
    - DNS cache poisoning
    - Man-in-the-middle attacks

    **Check DNSSEC**:
    ```bash
    dig example.com +dnssec
    ```

    ### DNS over HTTPS (DoH)
    Encrypt DNS queries over HTTPS.

    Providers:
    - Cloudflare: https://1.1.1.1/dns-query
    - Google: https://dns.google/dns-query

    ### DNS over TLS (DoT)
    Encrypt DNS queries over TLS (port 853).

    ## Common DNS Problems

    ### 1. DNS Propagation Delay
    Changes take time to spread (up to 48 hours).

    **Solution**: Lower TTL before making changes.

    ### 2. Negative Caching
    Failed lookups also cached.

    **Check**:
    ```bash
    dig example.com +norecurse
    ```

    ### 3. DNS Amplification Attacks
    Attackers use DNS to amplify DDoS attacks.

    **Mitigation**: Rate limiting, response rate limiting (RRL).

    ## Best Practices

    1. **Use multiple name servers**: Redundancy (ns1, ns2)
    2. **Set appropriate TTLs**: Lower before changes, higher for stability
    3. **Monitor DNS**: Alert on resolution failures
    4. **Use DNSSEC**: When possible
    5. **Geo-DNS**: Serve different IPs by location
    6. **Load balancing**: Multiple A records for same domain

    **Practice**: Try the DNS resolution lab!
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

# Routing Fundamentals

    Learn how packets find their way across networks.

    ## What is Routing?

    **Routing**: Forwarding packets from source to destination across multiple networks.

    **Router**: Device that forwards packets between networks.

    ## Routing Table

    Database of routes to destinations.

    ### View Routing Table

    **Linux/Mac**:
    ```bash
    ip route show
    route -n
    netstat -rn
    ```

    **Output Example**:
    ```
    default via 192.168.1.1 dev eth0
    192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100
    ```

    ### Routing Table Entries

    | Destination | Gateway | Interface | Metric |
    |-------------|---------|-----------|--------|
    | 0.0.0.0/0 | 192.168.1.1 | eth0 | 100 |
    | 192.168.1.0/24 | 0.0.0.0 | eth0 | 0 |
    | 10.0.0.0/8 | 192.168.1.254 | eth0 | 50 |

    **Columns**:
    - **Destination**: Target network
    - **Gateway**: Next hop router (0.0.0.0 = directly connected)
    - **Interface**: Outgoing network interface
    - **Metric**: Cost of route (lower = better)

    ## Static Routing

    Manually configured routes.

    ### Add Static Route

    **Linux**:
    ```bash
    # Add route to 10.0.0.0/8 via 192.168.1.254
    sudo ip route add 10.0.0.0/8 via 192.168.1.254

    # Delete route
    sudo ip route del 10.0.0.0/8

    # Add default route
    sudo ip route add default via 192.168.1.1
    ```

    **Pros**: Simple, predictable, secure
    **Cons**: Doesn't adapt to failures, manual configuration

    ## Dynamic Routing

    Routers automatically share route information.

    ### Interior Gateway Protocols (IGP)

    Within a single organization.

    **RIP (Routing Information Protocol)**:
    - Distance-vector protocol
    - Uses hop count as metric
    - Max 15 hops
    - Simple but slow convergence

    **OSPF (Open Shortest Path First)**:
    - Link-state protocol
    - Uses cost as metric (based on bandwidth)
    - Fast convergence
    - Scalable
    - Industry standard for enterprises

    **EIGRP (Enhanced Interior Gateway Routing Protocol)**:
    - Cisco proprietary (now open)
    - Advanced distance-vector
    - Fast convergence
    - Supports unequal-cost load balancing

    ### Exterior Gateway Protocol (EGP)

    Between different organizations (ASes).

    **BGP (Border Gateway Protocol)**:
    - The routing protocol of the internet
    - Path-vector protocol
    - Policy-based routing
    - Highly scalable

    ## BGP (Border Gateway Protocol)

    ### Autonomous Systems (AS)

    **AS**: Collection of IP networks under single administrative control.

    - AS Numbers: 16-bit (1-65535) or 32-bit
    - Examples:
      - AS15169: Google
      - AS16509: Amazon
      - AS32934: Facebook

    ### BGP Basics

    ```
    AS 100 ←→ AS 200 ←→ AS 300
    (You)     (ISP)     (Internet)
    ```

    **eBGP**: Between different ASes
    **iBGP**: Within same AS

    ### BGP Attributes

    **AS Path**: List of ASes packet traversed
    ```
    Path: AS100 → AS200 → AS300
    ```

    **Next Hop**: Next router to forward to

    **Local Preference**: Prefer certain paths (higher = better)

    **MED** (Multi-Exit Discriminator): Suggest path to neighbor AS

    ### BGP Route Selection

    1. Highest Local Preference
    2. Shortest AS Path
    3. Lowest Origin Type
    4. Lowest MED
    5. eBGP over iBGP
    6. Lowest IGP metric to next hop
    7. Lowest Router ID

    ### BGP Commands

    ```bash
    # Show BGP summary
    show ip bgp summary

    # Show BGP routes
    show ip bgp

    # Show specific route
    show ip bgp 8.8.8.8
    ```

    ## Packet Forwarding

    ### How Routing Works

    ```
    1. Packet arrives at router
    2. Router examines destination IP
    3. Router checks routing table
    4. Router finds longest prefix match
    5. Router forwards to next hop
    6. TTL decremented
    7. Repeat until destination reached
    ```

    ### Longest Prefix Match

    Most specific route wins.

    **Example Routes**:
    - 0.0.0.0/0 (default)
    - 10.0.0.0/8
    - 10.1.0.0/16
    - 10.1.2.0/24

    **Packet to 10.1.2.5**: Matches 10.1.2.0/24 (most specific)

    ## Network Address Translation (NAT)

    Translate private IPs to public IPs.

    ### Why NAT?

    - Conserve public IPv4 addresses
    - Security (hide internal IPs)
    - Flexibility (change ISP without renumbering)

    ### NAT Types

    **Static NAT**: One-to-one mapping
    ```
    192.168.1.10 → 203.0.113.5
    ```

    **Dynamic NAT**: Pool of public IPs
    ```
    192.168.1.0/24 → {203.0.113.1-10}
    ```

    **PAT** (Port Address Translation / NAT Overload):
    Many private IPs → One public IP (different ports)
    ```
    192.168.1.10:5000 → 203.0.113.1:50001
    192.168.1.20:6000 → 203.0.113.1:50002
    ```

    ### NAT Commands

    **Linux (iptables)**:
    ```bash
    # Enable NAT (masquerade)
    sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

    # Port forwarding (forward port 80 to 192.168.1.10:80)
    sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.10:80
    ```

    ## Traffic Shaping

    Control bandwidth and prioritize traffic.

    ### tc (Traffic Control)

    **Linux command for traffic shaping**.

    ```bash
    # Limit bandwidth to 1 Mbps
    sudo tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms

    # Add latency (simulate slow network)
    sudo tc qdisc add dev eth0 root netem delay 100ms

    # Add packet loss (simulate unreliable network)
    sudo tc qdisc add dev eth0 root netem loss 5%

    # Combine: 100ms delay + 5% loss
    sudo tc qdisc add dev eth0 root netem delay 100ms loss 5%

    # Remove rules
    sudo tc qdisc del dev eth0 root
    ```

    ### QoS (Quality of Service)

    Prioritize important traffic.

    **Traffic Classes**:
    1. Real-time (VoIP, video conferencing)
    2. Interactive (SSH, gaming)
    3. Bulk (file transfers, backups)
    4. Best effort (everything else)

    **QoS Mechanisms**:
    - **Priority queuing**: High priority first
    - **Weighted fair queuing**: Allocate bandwidth proportionally
    - **Token bucket**: Rate limiting

    ## Troubleshooting Tools

    ### ping
    Test connectivity.

    ```bash
    ping -c 4 google.com
    ```

    ### traceroute / tracepath
    Show route to destination.

    ```bash
    traceroute google.com
    ```

    ### mtr
    Combines ping and traceroute.

    ```bash
    mtr google.com
    ```

    ### tcpdump
    Capture packets.

    ```bash
    # Capture on interface
    sudo tcpdump -i eth0

    # Capture HTTP traffic
    sudo tcpdump -i eth0 port 80

    # Write to file
    sudo tcpdump -i eth0 -w capture.pcap

    # Read from file
    tcpdump -r capture.pcap
    ```

    ### Wireshark
    GUI packet analyzer (uses tcpdump/libpcap).

    ## Best Practices

    1. **Use dynamic routing**: For resilience and scalability
    2. **Monitor BGP**: Critical for internet connectivity
    3. **Implement QoS**: Prioritize important traffic
    4. **Document static routes**: Keep inventory
    5. **Test failover**: Ensure redundancy works
    6. **Use longest prefix match**: Most specific routes

    **Practice**: Try the Routing and Traffic Control lab!
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

# OSI and TCP/IP Models

    ### Why Do We Need Network Layers?

    **The Problem:**
    Imagine if every app had to understand WiFi signals, ethernet frames, routing, AND display data! Impossibly complex.

    **The Solution: Layering**
    Break networking into independent layers, each solving ONE problem. Each layer:
    - Has a specific job
    - Provides services to the layer above
    - Uses services from the layer below
    - Can change independently (upgrade WiFi without changing HTTP)

    **Real-World Analogy: Sending a Letter**
    ```
    Layer 7 (Application): Write letter content
    Layer 4 (Transport): Put in envelope, add return address
    Layer 3 (Network): Add routing info (street, city, zip)
    Layer 2 (Data Link): Postal truck transports envelope
    Layer 1 (Physical): Physical roads the truck drives on
    ```

    Each layer doesn't care HOW lower layers work - you don't worry about truck engines when writing a letter!

    ## OSI Model (7 Layers)

    **What is OSI?**

    OSI (Open Systems Interconnection) is a **reference model** created in 1984 to standardize how networks communicate. It's theoretical but helps understand networking.

    | Layer | Name | What It Does | Real-World Example |
    |-------|------|--------------|-------------------|
    | 7 | Application | Data your apps use | Opening Netflix website |
    | 6 | Presentation | Data format/encryption | Converting video to H.264 |
    | 5 | Session | Maintains connections | Keeping your login active |
    | 4 | Transport | Reliable delivery | Ensuring all video packets arrive |
    | 3 | Network | Routing between networks | Finding path to Netflix servers |
    | 2 | Data Link | Local network transmission | WiFi sending data to router |
    | 1 | Physical | Physical signals | Radio waves in the air |

    **Mnemonic to remember:** "**P**lease **D**o **N**ot **T**hrow **S**ausage **P**izza **A**way"
    (Physical → Data Link → Network → Transport → Session → Presentation → Application)

    ### Layer-by-Layer Deep Dive

    **Layer 1: Physical**
    - **What**: Actual electrical signals, light pulses, or radio waves
    - **Hardware**: Cables (Cat6, fiber optic), WiFi radio, Bluetooth
    - **Units**: Bits (1s and 0s)
    - **Analogy**: The roads mail trucks drive on
    - **Example**: When you plug in an Ethernet cable, that's Layer 1

    **Layer 2: Data Link (Ethernet/WiFi)**
    - **What**: Transfers data between devices on the SAME network
    - **Addressing**: MAC addresses (48-bit, like `AA:BB:CC:DD:EE:FF`)
    - **Hardware**: Switches, WiFi access points, network cards
    - **Units**: Frames
    - **Analogy**: Local delivery truck route (house-to-house)
    - **Example**: Your laptop talking to your WiFi router
    - **Key feature**: Error detection with CRC (Cyclic Redundancy Check)

    **Layer 3: Network (IP)**
    - **What**: Routes data across MULTIPLE networks (the internet!)
    - **Addressing**: IP addresses (192.168.1.1, 2001:db8::1)
    - **Hardware**: Routers
    - **Units**: Packets
    - **Analogy**: Postal service routing between cities
    - **Example**: Sending data from your home to Google's servers
    - **Key protocols**: IP (routing), ICMP (ping), ARP (MAC ↔ IP mapping)

    **Layer 4: Transport**
    - **What**: Ensures data arrives reliably (TCP) or quickly (UDP)
    - **Addressing**: Port numbers (80 for HTTP, 443 for HTTPS)
    - **Units**: Segments (TCP) or Datagrams (UDP)
    - **Analogy**: Certified mail (TCP) vs standard mail (UDP)
    - **Example**: TCP ensures all parts of a web page arrive correctly
    - **Key feature**: Multiplexing (multiple apps using network simultaneously)

    **Layers 5-7: Session, Presentation, Application**
    - **What**: High-level protocols apps use
    - **Session**: Manages connections (login sessions, API calls)
    - **Presentation**: Data formatting (encryption with TLS, compression)
    - **Application**: Actual application protocols (HTTP, DNS, SSH, FTP)
    - **Analogy**: The actual letter content and meaning
    - **Example**: Your browser using HTTPS (Application + Presentation)

    ## TCP/IP Model (4 Layers)

    **Why TCP/IP Instead of OSI?**

    The OSI model is great for teaching, but the internet ACTUALLY uses TCP/IP model:
    - Developed in the 1970s (before OSI!)
    - Simpler (4 layers vs 7)
    - Proven in real-world (runs the entire internet)
    - OSI layers 5-7 merged into one "Application" layer

    | TCP/IP Layer | OSI Equivalent | Protocols | What It Does |
    |--------------|----------------|-----------|--------------|
    | 4. Application | Layers 5-7 | HTTP, DNS, SSH, FTP, SMTP | App-level protocols |
    | 3. Transport | Layer 4 | TCP, UDP | Reliable/fast delivery |
    | 2. Internet | Layer 3 | IP, ICMP, ARP | Routing across networks |
    | 1. Link | Layers 1-2 | Ethernet, WiFi, PPP | Physical network |

    ### TCP/IP in Action: Loading a Webpage

    Let's trace what happens when you visit `https://example.com`:

    ```
    Application Layer:
    - Browser creates HTTP GET request: "GET /index.html HTTP/1.1"
    - TLS encrypts the request

    Transport Layer:
    - TCP wraps it with source port (e.g., 54321) and destination port (443)
    - Breaks data into segments if needed
    - Adds sequence numbers for reassembly

    Internet Layer:
    - IP adds your IP (192.168.1.100) and destination IP (93.184.216.34)
    - Determines next hop router to reach destination

    Link Layer:
    - Ethernet/WiFi adds MAC addresses for local network
    - Sends frame to your router's MAC address

    [Data travels through internet]

    Link Layer:
    - Server's network card receives frame, checks MAC
    - Removes ethernet header

    Internet Layer:
    - Router checks destination IP, confirms it's correct server
    - Removes IP header

    Transport Layer:
    - TCP checks port 443, sends to HTTPS process
    - Acknowledges receipt back to client
    - Removes TCP header

    Application Layer:
    - Web server software processes HTTP request
    - Sends back HTML response through all layers in reverse!
    ```

    ## Layer Responsibilities

    ### Layer 1: Physical
    - Bits on wire/fiber/air
    - Electrical signals
    - Cable standards (Cat5e, fiber optic)

    ### Layer 2: Data Link (Ethernet)
    - MAC addresses (48-bit)
    - Frames
    - Switches
    - Error detection (CRC)

    ### Layer 3: Network (IP)
    - IP addresses
    - Routing
    - Routers
    - Fragmentation

    ### Layer 4: Transport
    - **TCP**: Reliable, ordered, connection-oriented
    - **UDP**: Fast, connectionless, no guarantees
    - Port numbers (0-65535)

    ### Layer 7: Application
    - HTTP, DNS, SMTP, SSH
    - User-facing protocols

    ## Encapsulation

    Data gets wrapped at each layer:

    ```
    Application: [HTTP Data]
    Transport:   [TCP Header][HTTP Data]
    Internet:    [IP Header][TCP Header][HTTP Data]
    Link:        [Ethernet Header][IP Header][TCP Header][HTTP Data][Ethernet Trailer]
    ```

    Each layer adds its own header (and sometimes trailer).

    ## IP Addressing

    ### IPv4
    - 32-bit address
    - Dotted decimal: `192.168.1.1`
    - ~4.3 billion addresses
    - Running out of addresses

    ### IPv6
    - 128-bit address
    - Hexadecimal: `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
    - 340 undecillion addresses
    - Future-proof

    ### Private IP Ranges (RFC 1918)
    - `10.0.0.0/8` (10.0.0.0 - 10.255.255.255)
    - `172.16.0.0/12` (172.16.0.0 - 172.31.255.255)
    - `192.168.0.0/16` (192.168.0.0 - 192.168.255.255)

    ## Subnetting

    Divide networks into smaller subnetworks.

    ### CIDR Notation
    `192.168.1.0/24`
    - Network: 192.168.1.0
    - Subnet mask: /24 = 255.255.255.0
    - Hosts: 256 addresses (254 usable)

    ### Common Subnet Masks
    | CIDR | Subnet Mask | Hosts |
    |------|-------------|-------|
    | /32 | 255.255.255.255 | 1 |
    | /31 | 255.255.255.254 | 2 |
    | /30 | 255.255.255.252 | 4 |
    | /29 | 255.255.255.248 | 8 |
    | /28 | 255.255.255.240 | 16 |
    | /24 | 255.255.255.0 | 256 |
    | /16 | 255.255.0.0 | 65,536 |
    | /8 | 255.0.0.0 | 16,777,216 |

    ## TCP vs UDP: The Fundamental Trade-off

    **The Core Question:** Do you need reliability or speed?

    Transport Layer protocols must choose: guarantee delivery (slow) or send fast (maybe lose data). TCP and UDP represent opposite answers.

    ### TCP (Transmission Control Protocol): The Reliable One

    **What is TCP?**

    TCP is like sending a package with **tracking, signature confirmation, and insurance**. It guarantees:
    - Every byte arrives
    - In the correct order
    - Without duplication
    - With error checking

    **How TCP Achieves Reliability:**

    **1. Connection Setup (3-Way Handshake)**
    ```
    Client: "Hey server, want to talk?" (SYN)
    Server: "Sure! Ready to listen." (SYN-ACK)
    Client: "Great, let's start!" (ACK)
    [Now connected - can send data]
    ```

    This handshake ensures both sides are ready before sending real data.

    **2. Acknowledgments (ACKs)**
    Every packet sent gets acknowledged by the receiver.

    ```
    Sender: [Packet 1] "Here's data 1"
    Receiver: [ACK 1] "Got it! Send next"
    Sender: [Packet 2] "Here's data 2"
    Receiver: [ACK 2] "Got it!"
    ```

    If no ACK arrives → Sender retransmits the packet.

    **3. Sequence Numbers**
    Each byte gets a number, so receiver can:
    - Detect missing packets (sequence gap)
    - Reorder packets that arrive out-of-order
    - Detect duplicates

    ```
    Packets sent: [1][2][3][4][5]
    Packets arrive: [1][2][4][3][5]
    TCP reorders: [1][2][3][4][5] ✓
    ```

    **4. Flow Control (Sliding Window)**
    Prevents sender from overwhelming receiver.

    ```
    Receiver: "I can handle 10 packets at once" (window size)
    Sender: Only sends 10, waits for ACKs before sending more
    ```

    **5. Congestion Control**
    Slows down when network is congested (too many packets being dropped).

    **The Cost of Reliability:**
    - More overhead (ACKs, sequence numbers, retransmissions)
    - Higher latency (waiting for ACKs)
    - Connection setup delay (handshake)

    **When to Use TCP:**
    - **Data integrity matters**: File transfers, emails, web pages
    - **Order matters**: Chat messages, database transactions
    - **All data must arrive**: Downloading software, API calls

    **Real-World TCP Uses:**
    - **HTTP/HTTPS**: Web browsing (missing CSS breaks page)
    - **SSH**: Remote terminal (every keystroke must arrive)
    - **FTP/SFTP**: File transfer (corrupt files are useless)
    - **Email (SMTP/IMAP)**: Lost emails are unacceptable
    - **Database connections**: Corrupted queries = disaster

    ### UDP (User Datagram Protocol): The Fast One

    **What is UDP?**

    UDP is like **shouting across a room**:
    - No handshake (just start talking)
    - No confirmation (don't wait for "I heard you")
    - No retries (if they miss it, oh well)
    - No ordering (messages arrive whenever)

    **How UDP Works:**
    ```
    Sender: [Packet 1] "Data!" → Sent
    Sender: [Packet 2] "Data!" → Sent
    Sender: [Packet 3] "Data!" → Sent
    [No waiting, no ACKs, done!]
    ```

    That's it. Fire and forget.

    **Characteristics:**
    - **Connectionless**: No handshake, just send
    - **No reliability**: Packets can be lost, duplicated, or reordered
    - **No flow control**: Send as fast as you want
    - **Minimal overhead**: Just 8 bytes header (TCP has 20+ bytes)

    **The Benefits:**
    - **Lower latency**: No waiting for ACKs
    - **Simpler**: Less processing overhead
    - **Multicast/Broadcast capable**: Send to multiple hosts at once
    - **No connection state**: Server doesn't track clients

    **When to Use UDP:**
    - **Speed > reliability**: Live video, VoIP
    - **Occasional loss is OK**: Gaming (one lost position update is fine)
    - **Real-time is critical**: Can't wait for retransmissions
    - **Small requests**: DNS (faster to resend than wait for TCP setup)

    **Real-World UDP Uses:**
    - **DNS**: Quick queries (if lost, just resend - faster than TCP handshake)
    - **Video Streaming**: Live TV, Zoom calls (skip lost frames, keep going)
    - **VoIP**: Phone calls (brief audio glitch better than delay)
    - **Online Gaming**: Player positions (old data is useless anyway)
    - **DHCP**: Get IP address (simple request/response)
    - **IoT sensors**: Temperature readings (next reading coming soon anyway)

    ### The Decision Matrix

    **Use TCP when:**
    - ✅ Data MUST arrive correctly (downloads, bank transactions)
    - ✅ Order matters (chat, terminal sessions)
    - ✅ You can tolerate slight delays
    - ✅ Connection is long-lived

    **Use UDP when:**
    - ✅ Speed is critical (live streaming, gaming)
    - ✅ Occasional loss is acceptable (one lost video frame)
    - ✅ Real-time is more important than completeness
    - ✅ Messages are small and independent (DNS queries)

    ### Side-by-Side Comparison

    | Feature | TCP | UDP |
    |---------|-----|-----|
    | **Connection** | Yes (3-way handshake) | No (connectionless) |
    | **Reliability** | Guaranteed delivery | No guarantee |
    | **Ordering** | Packets arrive in order | May arrive out-of-order |
    | **Speed** | Slower (overhead) | Faster (minimal overhead) |
    | **Header Size** | 20-60 bytes | 8 bytes |
    | **Error Checking** | Yes (checksum + retransmission) | Yes (checksum only) |
    | **Flow Control** | Yes (sliding window) | No |
    | **Congestion Control** | Yes | No |
    | **Use Case** | File transfer, web, email | Streaming, gaming, DNS |

    ### Hybrid Approaches

    Modern protocols sometimes use UDP but add their own reliability:
    - **QUIC** (HTTP/3): UDP-based but adds reliability features
    - **WebRTC**: UDP with selective retransmission
    - **Custom game protocols**: UDP with app-level ACKs for critical data

    **Why?** Get UDP's speed while adding reliability only where needed, avoiding TCP's all-or-nothing approach.

    ### Common Misconception

    ❌ **Myth**: "UDP is unreliable and bad"
    ✅ **Truth**: UDP is perfect for real-time apps where speed > reliability

    Think of it this way:
    - TCP = Certified mail (slow but guaranteed)
    - UDP = Shouting (fast but might not be heard)

    Both are tools. Use the right one for the job!

    ## Port Numbers

    ### Well-Known Ports (0-1023)
    | Port | Protocol | Service |
    |------|----------|---------|
    | 20/21 | TCP | FTP |
    | 22 | TCP | SSH |
    | 23 | TCP | Telnet |
    | 25 | TCP | SMTP (email) |
    | 53 | TCP/UDP | DNS |
    | 80 | TCP | HTTP |
    | 110 | TCP | POP3 (email) |
    | 143 | TCP | IMAP (email) |
    | 443 | TCP | HTTPS |
    | 3306 | TCP | MySQL |
    | 5432 | TCP | PostgreSQL |
    | 6379 | TCP | Redis |

    ### Registered Ports (1024-49151)
    Assigned to specific applications.

    ### Dynamic/Private Ports (49152-65535)
    Temporarily assigned by OS.

    ## TCP Three-Way Handshake

    Establish connection:

    ```
    Client                Server
      |                     |
      |----SYN seq=100----->|  (1. Client initiates)
      |                     |
      |<---SYN-ACK----------|  (2. Server acknowledges)
      |  seq=200 ack=101    |
      |                     |
      |-----ACK ack=201---->|  (3. Client confirms)
      |                     |
      [Connection established]
    ```

    ## TCP Four-Way Termination

    Close connection gracefully:

    ```
    Client                Server
      |                     |
      |-----FIN------------>|  (1. Client wants to close)
      |                     |
      |<----ACK-------------|  (2. Server acknowledges)
      |                     |
      |<----FIN-------------|  (3. Server closes its side)
      |                     |
      |-----ACK------------>|  (4. Client acknowledges)
      |                     |
      [Connection closed]
    ```

    ## Practice

    Try the TCP/IP packet analysis lab!
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

# DNS Fundamentals

    Domain Name System translates human-readable names to IP addresses.

    ## What is DNS?

    **DNS**: Distributed database mapping domain names → IP addresses.

    Example:
    ```
    google.com → 142.250.80.46
    ```

    Without DNS, you'd need to remember IP addresses for every website!

    ## DNS Hierarchy

    ```
    Root (.)
    ├── .com
    │   ├── google.com
    │   │   ├── www.google.com
    │   │   └── mail.google.com
    │   └── amazon.com
    ├── .org
    │   └── wikipedia.org
    └── .net
        └── example.net
    ```

    ### DNS Components

    **1. Root Servers**
    - 13 root server clusters (a.root-servers.net to m.root-servers.net)
    - Top of DNS hierarchy
    - Operated by different organizations

    **2. TLD Servers** (Top-Level Domain)
    - `.com`, `.org`, `.net`, `.edu`
    - Country codes: `.uk`, `.jp`, `.de`
    - New TLDs: `.app`, `.dev`, `.cloud`

    **3. Authoritative Name Servers**
    - Store DNS records for domains
    - Answer queries with actual data

    **4. Recursive Resolvers**
    - Query on behalf of clients
    - Cache responses
    - Usually your ISP or 8.8.8.8 (Google), 1.1.1.1 (Cloudflare)

    ## DNS Resolution Process

    **Query: www.example.com**

    ```
    1. Client → Recursive Resolver: "What's www.example.com?"
    2. Resolver → Root Server: "Where's .com?"
    3. Root → Resolver: "Ask TLD server at 192.x.x.x"
    4. Resolver → TLD Server: "Where's example.com?"
    5. TLD → Resolver: "Ask authoritative server at 93.x.x.x"
    6. Resolver → Authoritative: "What's www.example.com?"
    7. Authoritative → Resolver: "It's 93.184.216.34"
    8. Resolver → Client: "www.example.com is 93.184.216.34"
    ```

    ## DNS Record Types

    ### A Record (Address)
    Map domain to IPv4 address.

    ```
    example.com.  IN  A  93.184.216.34
    ```

    ### AAAA Record
    Map domain to IPv6 address.

    ```
    example.com.  IN  AAAA  2606:2800:220:1:248:1893:25c8:1946
    ```

    ### CNAME Record (Canonical Name)
    Alias one domain to another.

    ```
    www.example.com.  IN  CNAME  example.com.
    blog.example.com. IN  CNAME  example.com.
    ```

    Use when: Multiple names point to same destination.

    ### MX Record (Mail Exchange)
    Specify mail servers.

    ```
    example.com.  IN  MX  10  mail1.example.com.
    example.com.  IN  MX  20  mail2.example.com.
    ```

    Priority: Lower number = higher priority.

    ### TXT Record
    Store arbitrary text (SPF, DKIM, verification).

    ```
    example.com.  IN  TXT  "v=spf1 mx -all"
    _dmarc.example.com.  IN  TXT  "v=DMARC1; p=reject"
    ```

    ### NS Record (Name Server)
    Delegate subdomain to name servers.

    ```
    example.com.  IN  NS  ns1.example.com.
    example.com.  IN  NS  ns2.example.com.
    ```

    ### PTR Record (Pointer)
    Reverse DNS (IP → domain).

    ```
    34.216.184.93.in-addr.arpa.  IN  PTR  example.com.
    ```

    ### SRV Record (Service)
    Specify service location.

    ```
    _http._tcp.example.com.  IN  SRV  10 5 80 www.example.com.
    ```

    ## DNS Commands

    ### dig (Domain Information Groper)
    ```bash
    # Basic query
    dig example.com

    # Query specific record type
    dig example.com MX
    dig example.com AAAA

    # Query specific DNS server
    dig @8.8.8.8 example.com

    # Short answer only
    dig +short example.com

    # Trace resolution path
    dig +trace example.com

    # Reverse DNS lookup
    dig -x 93.184.216.34
    ```

    ### nslookup
    ```bash
    # Basic query
    nslookup example.com

    # Query specific server
    nslookup example.com 8.8.8.8

    # Interactive mode
    nslookup
    > set type=MX
    > example.com
    ```

    ### host
    ```bash
    # Basic query
    host example.com

    # Query MX records
    host -t MX example.com

    # Query all records
    host -a example.com
    ```

    ## DNS Caching

    **TTL** (Time To Live): How long to cache a record.

    ```
    example.com.  300  IN  A  93.184.216.34
                  ^^^
                  TTL in seconds (5 minutes)
    ```

    **Cache Levels**:
    1. Browser cache (~1 minute)
    2. OS cache (~1 minute)
    3. Recursive resolver cache (TTL value)

    ## DNS Security

    ### DNSSEC (DNS Security Extensions)
    Cryptographically sign DNS records.

    **Prevents**:
    - DNS cache poisoning
    - Man-in-the-middle attacks

    **Check DNSSEC**:
    ```bash
    dig example.com +dnssec
    ```

    ### DNS over HTTPS (DoH)
    Encrypt DNS queries over HTTPS.

    Providers:
    - Cloudflare: https://1.1.1.1/dns-query
    - Google: https://dns.google/dns-query

    ### DNS over TLS (DoT)
    Encrypt DNS queries over TLS (port 853).

    ## Common DNS Problems

    ### 1. DNS Propagation Delay
    Changes take time to spread (up to 48 hours).

    **Solution**: Lower TTL before making changes.

    ### 2. Negative Caching
    Failed lookups also cached.

    **Check**:
    ```bash
    dig example.com +norecurse
    ```

    ### 3. DNS Amplification Attacks
    Attackers use DNS to amplify DDoS attacks.

    **Mitigation**: Rate limiting, response rate limiting (RRL).

    ## Best Practices

    1. **Use multiple name servers**: Redundancy (ns1, ns2)
    2. **Set appropriate TTLs**: Lower before changes, higher for stability
    3. **Monitor DNS**: Alert on resolution failures
    4. **Use DNSSEC**: When possible
    5. **Geo-DNS**: Serve different IPs by location
    6. **Load balancing**: Multiple A records for same domain

    **Practice**: Try the DNS resolution lab!
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

# Routing Fundamentals

    Learn how packets find their way across networks.

    ## What is Routing?

    **Routing**: Forwarding packets from source to destination across multiple networks.

    **Router**: Device that forwards packets between networks.

    ## Routing Table

    Database of routes to destinations.

    ### View Routing Table

    **Linux/Mac**:
    ```bash
    ip route show
    route -n
    netstat -rn
    ```

    **Output Example**:
    ```
    default via 192.168.1.1 dev eth0
    192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100
    ```

    ### Routing Table Entries

    | Destination | Gateway | Interface | Metric |
    |-------------|---------|-----------|--------|
    | 0.0.0.0/0 | 192.168.1.1 | eth0 | 100 |
    | 192.168.1.0/24 | 0.0.0.0 | eth0 | 0 |
    | 10.0.0.0/8 | 192.168.1.254 | eth0 | 50 |

    **Columns**:
    - **Destination**: Target network
    - **Gateway**: Next hop router (0.0.0.0 = directly connected)
    - **Interface**: Outgoing network interface
    - **Metric**: Cost of route (lower = better)

    ## Static Routing

    Manually configured routes.

    ### Add Static Route

    **Linux**:
    ```bash
    # Add route to 10.0.0.0/8 via 192.168.1.254
    sudo ip route add 10.0.0.0/8 via 192.168.1.254

    # Delete route
    sudo ip route del 10.0.0.0/8

    # Add default route
    sudo ip route add default via 192.168.1.1
    ```

    **Pros**: Simple, predictable, secure
    **Cons**: Doesn't adapt to failures, manual configuration

    ## Dynamic Routing

    Routers automatically share route information.

    ### Interior Gateway Protocols (IGP)

    Within a single organization.

    **RIP (Routing Information Protocol)**:
    - Distance-vector protocol
    - Uses hop count as metric
    - Max 15 hops
    - Simple but slow convergence

    **OSPF (Open Shortest Path First)**:
    - Link-state protocol
    - Uses cost as metric (based on bandwidth)
    - Fast convergence
    - Scalable
    - Industry standard for enterprises

    **EIGRP (Enhanced Interior Gateway Routing Protocol)**:
    - Cisco proprietary (now open)
    - Advanced distance-vector
    - Fast convergence
    - Supports unequal-cost load balancing

    ### Exterior Gateway Protocol (EGP)

    Between different organizations (ASes).

    **BGP (Border Gateway Protocol)**:
    - The routing protocol of the internet
    - Path-vector protocol
    - Policy-based routing
    - Highly scalable

    ## BGP (Border Gateway Protocol)

    ### Autonomous Systems (AS)

    **AS**: Collection of IP networks under single administrative control.

    - AS Numbers: 16-bit (1-65535) or 32-bit
    - Examples:
      - AS15169: Google
      - AS16509: Amazon
      - AS32934: Facebook

    ### BGP Basics

    ```
    AS 100 ←→ AS 200 ←→ AS 300
    (You)     (ISP)     (Internet)
    ```

    **eBGP**: Between different ASes
    **iBGP**: Within same AS

    ### BGP Attributes

    **AS Path**: List of ASes packet traversed
    ```
    Path: AS100 → AS200 → AS300
    ```

    **Next Hop**: Next router to forward to

    **Local Preference**: Prefer certain paths (higher = better)

    **MED** (Multi-Exit Discriminator): Suggest path to neighbor AS

    ### BGP Route Selection

    1. Highest Local Preference
    2. Shortest AS Path
    3. Lowest Origin Type
    4. Lowest MED
    5. eBGP over iBGP
    6. Lowest IGP metric to next hop
    7. Lowest Router ID

    ### BGP Commands

    ```bash
    # Show BGP summary
    show ip bgp summary

    # Show BGP routes
    show ip bgp

    # Show specific route
    show ip bgp 8.8.8.8
    ```

    ## Packet Forwarding

    ### How Routing Works

    ```
    1. Packet arrives at router
    2. Router examines destination IP
    3. Router checks routing table
    4. Router finds longest prefix match
    5. Router forwards to next hop
    6. TTL decremented
    7. Repeat until destination reached
    ```

    ### Longest Prefix Match

    Most specific route wins.

    **Example Routes**:
    - 0.0.0.0/0 (default)
    - 10.0.0.0/8
    - 10.1.0.0/16
    - 10.1.2.0/24

    **Packet to 10.1.2.5**: Matches 10.1.2.0/24 (most specific)

    ## Network Address Translation (NAT)

    Translate private IPs to public IPs.

    ### Why NAT?

    - Conserve public IPv4 addresses
    - Security (hide internal IPs)
    - Flexibility (change ISP without renumbering)

    ### NAT Types

    **Static NAT**: One-to-one mapping
    ```
    192.168.1.10 → 203.0.113.5
    ```

    **Dynamic NAT**: Pool of public IPs
    ```
    192.168.1.0/24 → {203.0.113.1-10}
    ```

    **PAT** (Port Address Translation / NAT Overload):
    Many private IPs → One public IP (different ports)
    ```
    192.168.1.10:5000 → 203.0.113.1:50001
    192.168.1.20:6000 → 203.0.113.1:50002
    ```

    ### NAT Commands

    **Linux (iptables)**:
    ```bash
    # Enable NAT (masquerade)
    sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

    # Port forwarding (forward port 80 to 192.168.1.10:80)
    sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.10:80
    ```

    ## Traffic Shaping

    Control bandwidth and prioritize traffic.

    ### tc (Traffic Control)

    **Linux command for traffic shaping**.

    ```bash
    # Limit bandwidth to 1 Mbps
    sudo tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms

    # Add latency (simulate slow network)
    sudo tc qdisc add dev eth0 root netem delay 100ms

    # Add packet loss (simulate unreliable network)
    sudo tc qdisc add dev eth0 root netem loss 5%

    # Combine: 100ms delay + 5% loss
    sudo tc qdisc add dev eth0 root netem delay 100ms loss 5%

    # Remove rules
    sudo tc qdisc del dev eth0 root
    ```

    ### QoS (Quality of Service)

    Prioritize important traffic.

    **Traffic Classes**:
    1. Real-time (VoIP, video conferencing)
    2. Interactive (SSH, gaming)
    3. Bulk (file transfers, backups)
    4. Best effort (everything else)

    **QoS Mechanisms**:
    - **Priority queuing**: High priority first
    - **Weighted fair queuing**: Allocate bandwidth proportionally
    - **Token bucket**: Rate limiting

    ## Troubleshooting Tools

    ### ping
    Test connectivity.

    ```bash
    ping -c 4 google.com
    ```

    ### traceroute / tracepath
    Show route to destination.

    ```bash
    traceroute google.com
    ```

    ### mtr
    Combines ping and traceroute.

    ```bash
    mtr google.com
    ```

    ### tcpdump
    Capture packets.

    ```bash
    # Capture on interface
    sudo tcpdump -i eth0

    # Capture HTTP traffic
    sudo tcpdump -i eth0 port 80

    # Write to file
    sudo tcpdump -i eth0 -w capture.pcap

    # Read from file
    tcpdump -r capture.pcap
    ```

    ### Wireshark
    GUI packet analyzer (uses tcpdump/libpcap).

    ## Best Practices

    1. **Use dynamic routing**: For resilience and scalability
    2. **Monitor BGP**: Critical for internet connectivity
    3. **Implement QoS**: Prioritize important traffic
    4. **Document static routes**: Keep inventory
    5. **Test failover**: Ensure redundancy works
    6. **Use longest prefix match**: Most specific routes

    **Practice**: Try the Routing and Traffic Control lab!
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
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

# === MICROLESSON 12: Lesson 12 ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 12',
  content: <<~MARKDOWN,
# Microlesson 🚀

# OSI and TCP/IP Models

    ### Why Do We Need Network Layers?

    **The Problem:**
    Imagine if every app had to understand WiFi signals, ethernet frames, routing, AND display data! Impossibly complex.

    **The Solution: Layering**
    Break networking into independent layers, each solving ONE problem. Each layer:
    - Has a specific job
    - Provides services to the layer above
    - Uses services from the layer below
    - Can change independently (upgrade WiFi without changing HTTP)

    **Real-World Analogy: Sending a Letter**
    ```
    Layer 7 (Application): Write letter content
    Layer 4 (Transport): Put in envelope, add return address
    Layer 3 (Network): Add routing info (street, city, zip)
    Layer 2 (Data Link): Postal truck transports envelope
    Layer 1 (Physical): Physical roads the truck drives on
    ```

    Each layer doesn't care HOW lower layers work - you don't worry about truck engines when writing a letter!

    ## OSI Model (7 Layers)

    **What is OSI?**

    OSI (Open Systems Interconnection) is a **reference model** created in 1984 to standardize how networks communicate. It's theoretical but helps understand networking.

    | Layer | Name | What It Does | Real-World Example |
    |-------|------|--------------|-------------------|
    | 7 | Application | Data your apps use | Opening Netflix website |
    | 6 | Presentation | Data format/encryption | Converting video to H.264 |
    | 5 | Session | Maintains connections | Keeping your login active |
    | 4 | Transport | Reliable delivery | Ensuring all video packets arrive |
    | 3 | Network | Routing between networks | Finding path to Netflix servers |
    | 2 | Data Link | Local network transmission | WiFi sending data to router |
    | 1 | Physical | Physical signals | Radio waves in the air |

    **Mnemonic to remember:** "**P**lease **D**o **N**ot **T**hrow **S**ausage **P**izza **A**way"
    (Physical → Data Link → Network → Transport → Session → Presentation → Application)

    ### Layer-by-Layer Deep Dive

    **Layer 1: Physical**
    - **What**: Actual electrical signals, light pulses, or radio waves
    - **Hardware**: Cables (Cat6, fiber optic), WiFi radio, Bluetooth
    - **Units**: Bits (1s and 0s)
    - **Analogy**: The roads mail trucks drive on
    - **Example**: When you plug in an Ethernet cable, that's Layer 1

    **Layer 2: Data Link (Ethernet/WiFi)**
    - **What**: Transfers data between devices on the SAME network
    - **Addressing**: MAC addresses (48-bit, like `AA:BB:CC:DD:EE:FF`)
    - **Hardware**: Switches, WiFi access points, network cards
    - **Units**: Frames
    - **Analogy**: Local delivery truck route (house-to-house)
    - **Example**: Your laptop talking to your WiFi router
    - **Key feature**: Error detection with CRC (Cyclic Redundancy Check)

    **Layer 3: Network (IP)**
    - **What**: Routes data across MULTIPLE networks (the internet!)
    - **Addressing**: IP addresses (192.168.1.1, 2001:db8::1)
    - **Hardware**: Routers
    - **Units**: Packets
    - **Analogy**: Postal service routing between cities
    - **Example**: Sending data from your home to Google's servers
    - **Key protocols**: IP (routing), ICMP (ping), ARP (MAC ↔ IP mapping)

    **Layer 4: Transport**
    - **What**: Ensures data arrives reliably (TCP) or quickly (UDP)
    - **Addressing**: Port numbers (80 for HTTP, 443 for HTTPS)
    - **Units**: Segments (TCP) or Datagrams (UDP)
    - **Analogy**: Certified mail (TCP) vs standard mail (UDP)
    - **Example**: TCP ensures all parts of a web page arrive correctly
    - **Key feature**: Multiplexing (multiple apps using network simultaneously)

    **Layers 5-7: Session, Presentation, Application**
    - **What**: High-level protocols apps use
    - **Session**: Manages connections (login sessions, API calls)
    - **Presentation**: Data formatting (encryption with TLS, compression)
    - **Application**: Actual application protocols (HTTP, DNS, SSH, FTP)
    - **Analogy**: The actual letter content and meaning
    - **Example**: Your browser using HTTPS (Application + Presentation)

    ## TCP/IP Model (4 Layers)

    **Why TCP/IP Instead of OSI?**

    The OSI model is great for teaching, but the internet ACTUALLY uses TCP/IP model:
    - Developed in the 1970s (before OSI!)
    - Simpler (4 layers vs 7)
    - Proven in real-world (runs the entire internet)
    - OSI layers 5-7 merged into one "Application" layer

    | TCP/IP Layer | OSI Equivalent | Protocols | What It Does |
    |--------------|----------------|-----------|--------------|
    | 4. Application | Layers 5-7 | HTTP, DNS, SSH, FTP, SMTP | App-level protocols |
    | 3. Transport | Layer 4 | TCP, UDP | Reliable/fast delivery |
    | 2. Internet | Layer 3 | IP, ICMP, ARP | Routing across networks |
    | 1. Link | Layers 1-2 | Ethernet, WiFi, PPP | Physical network |

    ### TCP/IP in Action: Loading a Webpage

    Let's trace what happens when you visit `https://example.com`:

    ```
    Application Layer:
    - Browser creates HTTP GET request: "GET /index.html HTTP/1.1"
    - TLS encrypts the request

    Transport Layer:
    - TCP wraps it with source port (e.g., 54321) and destination port (443)
    - Breaks data into segments if needed
    - Adds sequence numbers for reassembly

    Internet Layer:
    - IP adds your IP (192.168.1.100) and destination IP (93.184.216.34)
    - Determines next hop router to reach destination

    Link Layer:
    - Ethernet/WiFi adds MAC addresses for local network
    - Sends frame to your router's MAC address

    [Data travels through internet]

    Link Layer:
    - Server's network card receives frame, checks MAC
    - Removes ethernet header

    Internet Layer:
    - Router checks destination IP, confirms it's correct server
    - Removes IP header

    Transport Layer:
    - TCP checks port 443, sends to HTTPS process
    - Acknowledges receipt back to client
    - Removes TCP header

    Application Layer:
    - Web server software processes HTTP request
    - Sends back HTML response through all layers in reverse!
    ```

    ## Layer Responsibilities

    ### Layer 1: Physical
    - Bits on wire/fiber/air
    - Electrical signals
    - Cable standards (Cat5e, fiber optic)

    ### Layer 2: Data Link (Ethernet)
    - MAC addresses (48-bit)
    - Frames
    - Switches
    - Error detection (CRC)

    ### Layer 3: Network (IP)
    - IP addresses
    - Routing
    - Routers
    - Fragmentation

    ### Layer 4: Transport
    - **TCP**: Reliable, ordered, connection-oriented
    - **UDP**: Fast, connectionless, no guarantees
    - Port numbers (0-65535)

    ### Layer 7: Application
    - HTTP, DNS, SMTP, SSH
    - User-facing protocols

    ## Encapsulation

    Data gets wrapped at each layer:

    ```
    Application: [HTTP Data]
    Transport:   [TCP Header][HTTP Data]
    Internet:    [IP Header][TCP Header][HTTP Data]
    Link:        [Ethernet Header][IP Header][TCP Header][HTTP Data][Ethernet Trailer]
    ```

    Each layer adds its own header (and sometimes trailer).

    ## IP Addressing

    ### IPv4
    - 32-bit address
    - Dotted decimal: `192.168.1.1`
    - ~4.3 billion addresses
    - Running out of addresses

    ### IPv6
    - 128-bit address
    - Hexadecimal: `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
    - 340 undecillion addresses
    - Future-proof

    ### Private IP Ranges (RFC 1918)
    - `10.0.0.0/8` (10.0.0.0 - 10.255.255.255)
    - `172.16.0.0/12` (172.16.0.0 - 172.31.255.255)
    - `192.168.0.0/16` (192.168.0.0 - 192.168.255.255)

    ## Subnetting

    Divide networks into smaller subnetworks.

    ### CIDR Notation
    `192.168.1.0/24`
    - Network: 192.168.1.0
    - Subnet mask: /24 = 255.255.255.0
    - Hosts: 256 addresses (254 usable)

    ### Common Subnet Masks
    | CIDR | Subnet Mask | Hosts |
    |------|-------------|-------|
    | /32 | 255.255.255.255 | 1 |
    | /31 | 255.255.255.254 | 2 |
    | /30 | 255.255.255.252 | 4 |
    | /29 | 255.255.255.248 | 8 |
    | /28 | 255.255.255.240 | 16 |
    | /24 | 255.255.255.0 | 256 |
    | /16 | 255.255.0.0 | 65,536 |
    | /8 | 255.0.0.0 | 16,777,216 |

    ## TCP vs UDP: The Fundamental Trade-off

    **The Core Question:** Do you need reliability or speed?

    Transport Layer protocols must choose: guarantee delivery (slow) or send fast (maybe lose data). TCP and UDP represent opposite answers.

    ### TCP (Transmission Control Protocol): The Reliable One

    **What is TCP?**

    TCP is like sending a package with **tracking, signature confirmation, and insurance**. It guarantees:
    - Every byte arrives
    - In the correct order
    - Without duplication
    - With error checking

    **How TCP Achieves Reliability:**

    **1. Connection Setup (3-Way Handshake)**
    ```
    Client: "Hey server, want to talk?" (SYN)
    Server: "Sure! Ready to listen." (SYN-ACK)
    Client: "Great, let's start!" (ACK)
    [Now connected - can send data]
    ```

    This handshake ensures both sides are ready before sending real data.

    **2. Acknowledgments (ACKs)**
    Every packet sent gets acknowledged by the receiver.

    ```
    Sender: [Packet 1] "Here's data 1"
    Receiver: [ACK 1] "Got it! Send next"
    Sender: [Packet 2] "Here's data 2"
    Receiver: [ACK 2] "Got it!"
    ```

    If no ACK arrives → Sender retransmits the packet.

    **3. Sequence Numbers**
    Each byte gets a number, so receiver can:
    - Detect missing packets (sequence gap)
    - Reorder packets that arrive out-of-order
    - Detect duplicates

    ```
    Packets sent: [1][2][3][4][5]
    Packets arrive: [1][2][4][3][5]
    TCP reorders: [1][2][3][4][5] ✓
    ```

    **4. Flow Control (Sliding Window)**
    Prevents sender from overwhelming receiver.

    ```
    Receiver: "I can handle 10 packets at once" (window size)
    Sender: Only sends 10, waits for ACKs before sending more
    ```

    **5. Congestion Control**
    Slows down when network is congested (too many packets being dropped).

    **The Cost of Reliability:**
    - More overhead (ACKs, sequence numbers, retransmissions)
    - Higher latency (waiting for ACKs)
    - Connection setup delay (handshake)

    **When to Use TCP:**
    - **Data integrity matters**: File transfers, emails, web pages
    - **Order matters**: Chat messages, database transactions
    - **All data must arrive**: Downloading software, API calls

    **Real-World TCP Uses:**
    - **HTTP/HTTPS**: Web browsing (missing CSS breaks page)
    - **SSH**: Remote terminal (every keystroke must arrive)
    - **FTP/SFTP**: File transfer (corrupt files are useless)
    - **Email (SMTP/IMAP)**: Lost emails are unacceptable
    - **Database connections**: Corrupted queries = disaster

    ### UDP (User Datagram Protocol): The Fast One

    **What is UDP?**

    UDP is like **shouting across a room**:
    - No handshake (just start talking)
    - No confirmation (don't wait for "I heard you")
    - No retries (if they miss it, oh well)
    - No ordering (messages arrive whenever)

    **How UDP Works:**
    ```
    Sender: [Packet 1] "Data!" → Sent
    Sender: [Packet 2] "Data!" → Sent
    Sender: [Packet 3] "Data!" → Sent
    [No waiting, no ACKs, done!]
    ```

    That's it. Fire and forget.

    **Characteristics:**
    - **Connectionless**: No handshake, just send
    - **No reliability**: Packets can be lost, duplicated, or reordered
    - **No flow control**: Send as fast as you want
    - **Minimal overhead**: Just 8 bytes header (TCP has 20+ bytes)

    **The Benefits:**
    - **Lower latency**: No waiting for ACKs
    - **Simpler**: Less processing overhead
    - **Multicast/Broadcast capable**: Send to multiple hosts at once
    - **No connection state**: Server doesn't track clients

    **When to Use UDP:**
    - **Speed > reliability**: Live video, VoIP
    - **Occasional loss is OK**: Gaming (one lost position update is fine)
    - **Real-time is critical**: Can't wait for retransmissions
    - **Small requests**: DNS (faster to resend than wait for TCP setup)

    **Real-World UDP Uses:**
    - **DNS**: Quick queries (if lost, just resend - faster than TCP handshake)
    - **Video Streaming**: Live TV, Zoom calls (skip lost frames, keep going)
    - **VoIP**: Phone calls (brief audio glitch better than delay)
    - **Online Gaming**: Player positions (old data is useless anyway)
    - **DHCP**: Get IP address (simple request/response)
    - **IoT sensors**: Temperature readings (next reading coming soon anyway)

    ### The Decision Matrix

    **Use TCP when:**
    - ✅ Data MUST arrive correctly (downloads, bank transactions)
    - ✅ Order matters (chat, terminal sessions)
    - ✅ You can tolerate slight delays
    - ✅ Connection is long-lived

    **Use UDP when:**
    - ✅ Speed is critical (live streaming, gaming)
    - ✅ Occasional loss is acceptable (one lost video frame)
    - ✅ Real-time is more important than completeness
    - ✅ Messages are small and independent (DNS queries)

    ### Side-by-Side Comparison

    | Feature | TCP | UDP |
    |---------|-----|-----|
    | **Connection** | Yes (3-way handshake) | No (connectionless) |
    | **Reliability** | Guaranteed delivery | No guarantee |
    | **Ordering** | Packets arrive in order | May arrive out-of-order |
    | **Speed** | Slower (overhead) | Faster (minimal overhead) |
    | **Header Size** | 20-60 bytes | 8 bytes |
    | **Error Checking** | Yes (checksum + retransmission) | Yes (checksum only) |
    | **Flow Control** | Yes (sliding window) | No |
    | **Congestion Control** | Yes | No |
    | **Use Case** | File transfer, web, email | Streaming, gaming, DNS |

    ### Hybrid Approaches

    Modern protocols sometimes use UDP but add their own reliability:
    - **QUIC** (HTTP/3): UDP-based but adds reliability features
    - **WebRTC**: UDP with selective retransmission
    - **Custom game protocols**: UDP with app-level ACKs for critical data

    **Why?** Get UDP's speed while adding reliability only where needed, avoiding TCP's all-or-nothing approach.

    ### Common Misconception

    ❌ **Myth**: "UDP is unreliable and bad"
    ✅ **Truth**: UDP is perfect for real-time apps where speed > reliability

    Think of it this way:
    - TCP = Certified mail (slow but guaranteed)
    - UDP = Shouting (fast but might not be heard)

    Both are tools. Use the right one for the job!

    ## Port Numbers

    ### Well-Known Ports (0-1023)
    | Port | Protocol | Service |
    |------|----------|---------|
    | 20/21 | TCP | FTP |
    | 22 | TCP | SSH |
    | 23 | TCP | Telnet |
    | 25 | TCP | SMTP (email) |
    | 53 | TCP/UDP | DNS |
    | 80 | TCP | HTTP |
    | 110 | TCP | POP3 (email) |
    | 143 | TCP | IMAP (email) |
    | 443 | TCP | HTTPS |
    | 3306 | TCP | MySQL |
    | 5432 | TCP | PostgreSQL |
    | 6379 | TCP | Redis |

    ### Registered Ports (1024-49151)
    Assigned to specific applications.

    ### Dynamic/Private Ports (49152-65535)
    Temporarily assigned by OS.

    ## TCP Three-Way Handshake

    Establish connection:

    ```
    Client                Server
      |                     |
      |----SYN seq=100----->|  (1. Client initiates)
      |                     |
      |<---SYN-ACK----------|  (2. Server acknowledges)
      |  seq=200 ack=101    |
      |                     |
      |-----ACK ack=201---->|  (3. Client confirms)
      |                     |
      [Connection established]
    ```

    ## TCP Four-Way Termination

    Close connection gracefully:

    ```
    Client                Server
      |                     |
      |-----FIN------------>|  (1. Client wants to close)
      |                     |
      |<----ACK-------------|  (2. Server acknowledges)
      |                     |
      |<----FIN-------------|  (3. Server closes its side)
      |                     |
      |-----ACK------------>|  (4. Client acknowledges)
      |                     |
      [Connection closed]
    ```

    ## Practice

    Try the TCP/IP packet analysis lab!
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 12 microlessons for Tcp Ip Fundamentals"

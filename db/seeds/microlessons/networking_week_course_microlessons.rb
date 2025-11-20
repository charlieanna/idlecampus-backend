# AUTO-GENERATED from networking_week_course.rb
puts "Creating Microlessons for Day1 Osi Model Practice..."

module_var = CourseModule.find_by(slug: 'day1-osi-model-practice')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Day 1: Networking Foundations – The OSI Model in Practice

    ## Learning Goals

    - Understand the purpose of the OSI 7-layer model and how real-world protocols map to each layer
    - Recognize examples like how HTTP (web) fits at the Application layer and TCP/IP fit in Transport/Network layers
    - Grasp why the OSI layered approach helps in troubleshooting and designing networks

    ## Why Networking Matters for DevOps

    Networking knowledge is critical for DevOps roles – even if many focus on code or cloud, no part of IT infrastructure should remain a "black box". Many common DevOps tasks rely on understanding networking fundamentals:
    - Troubleshooting connectivity issues
    - Setting up container networks
    - Configuring Kubernetes networking
    - Designing cloud VPCs and security groups

    ## The OSI Model: A Conceptual Framework

    ### What is the OSI Model?

    The Open Systems Interconnection (OSI) model is a conceptual framework that breaks network communication into seven layers, from physical hardware up to applications. Each layer has specific roles, making it easier to pinpoint where issues occur.

    **The Problem It Solves:**
    Without layering, every application would need to understand everything from WiFi signals to data display – impossibly complex!

    **The Solution:**
    Break networking into independent layers, each solving ONE problem. Each layer:
    - Has a specific job
    - Provides services to the layer above
    - Uses services from the layer below
    - Can change independently (upgrade WiFi without changing HTTP)

    ### The 7 Layers of the OSI Model

    | Layer | Name | What It Does | Real-World Example |
    |-------|------|--------------|-------------------|
    | **7** | Application | User-facing applications and protocols | HTTP, FTP, SMTP, DNS |
    | **6** | Presentation | Data representation and encryption | TLS, data formatting |
    | **5** | Session | Manages sessions or connections | API session tokens, TCP sessions |
    | **4** | Transport | End-to-end data transport | TCP (reliable), UDP (fast) |
    | **3** | Network | Routing and addressing | IP addresses, routers |
    | **2** | Data Link | Local network communication | Ethernet, switches, MAC addresses |
    | **1** | Physical | Physical medium | Ethernet cables, Wi-Fi, fiber optics |

    **Mnemonic:** "**P**lease **D**o **N**ot **T**hrow **S**ausage **P**izza **A**way"

    ### Layer-by-Layer Deep Dive

    #### Layer 1: Physical
    - **What**: Actual electrical signals, light pulses, or radio waves transmitting raw bits
    - **Examples**: Ethernet cables, Wi-Fi radio, fiber optics
    - **Data Units**: Bits (1s and 0s)
    - **Analogy**: The roads mail trucks drive on

    #### Layer 2: Data Link
    - **What**: Local network communication within the same network
    - **Addressing**: MAC addresses (e.g., `AA:BB:CC:DD:EE:FF`)
    - **Devices**: Switches, network cards
    - **Data Units**: Frames
    - **Key Feature**: Error detection with CRC
    - **Example**: Your laptop talking to your WiFi router

    #### Layer 3: Network
    - **What**: Routing and addressing across multiple networks
    - **Addressing**: IP addresses (e.g., `192.168.1.1`)
    - **Devices**: Routers
    - **Data Units**: Packets
    - **Protocols**: IP, ICMP (ping), routing protocols
    - **Example**: Sending data from your home to Google's servers

    #### Layer 4: Transport
    - **What**: End-to-end reliable delivery or fast delivery
    - **Protocols**:
      - **TCP**: Reliable, connection-oriented, ensures data arrives in order
      - **UDP**: Unreliable, connectionless, just sends packets without guarantees
    - **Addressing**: Port numbers (e.g., 80 for HTTP, 443 for HTTPS)
    - **Data Units**: Segments (TCP) or Datagrams (UDP)

    #### Layer 5: Session
    - **What**: Manages connections between applications
    - **Examples**: Ongoing TCP session, API session token
    - **Purpose**: Establishes, maintains, and terminates connections

    #### Layer 6: Presentation
    - **What**: Data representation and encryption
    - **Examples**: TLS/SSL encryption, data compression, format conversion
    - **Purpose**: Ensures data is in a usable format

    #### Layer 7: Application
    - **What**: User-facing protocols that enable software to communicate
    - **Examples**: HTTP (web), DNS (name resolution), SMTP (email), FTP (file transfer)
    - **Purpose**: Provides network services to applications

    ## The TCP/IP Model (4 Layers)

    While the OSI model is great for teaching, the internet ACTUALLY uses the TCP/IP model:

    | TCP/IP Layer | OSI Equivalent | Key Protocols | Purpose |
    |--------------|----------------|---------------|---------|
    | Application | Layers 5-7 | HTTP, DNS, SSH, FTP | App-level protocols |
    | Transport | Layer 4 | TCP, UDP | Reliable/fast delivery |
    | Internet | Layer 3 | IP, ICMP, ARP | Routing across networks |
    | Link | Layers 1-2 | Ethernet, WiFi | Physical network |

    ## Example: Loading a Webpage

    When you visit `https://example.com`, here's what happens at each layer:

    ### Going Down the Stack (Sending Request)

    ```
    Application Layer (L7):
    - Browser creates HTTP GET request
    - HTTPS adds TLS encryption

    Transport Layer (L4):
    - TCP wraps request with source port (random) and dest port (443)
    - Adds sequence numbers for reassembly

    Network Layer (L3):
    - IP adds your IP address and destination IP
    - Determines next hop router

    Data Link Layer (L2):
    - Ethernet adds MAC addresses for local network
    - Sends frame to router's MAC address

    Physical Layer (L1):
    - Electrical/radio signals transmitted over wire/air
    ```

    ### Coming Up the Stack (Receiving Response)

    ```
    Physical Layer: Receives electrical signals
    Data Link Layer: Checks MAC, removes Ethernet header
    Network Layer: Checks destination IP, removes IP header
    Transport Layer: Checks port 443, sends to HTTPS process, removes TCP header
    Application Layer: Web server processes HTTP request, sends back HTML
    ```

    ## Encapsulation: How Data Travels

    Data gets wrapped at each layer like Russian nesting dolls:

    ```
    Application:  [HTTP Data]
    Transport:    [TCP Header][HTTP Data]
    Network:      [IP Header][TCP Header][HTTP Data]
    Data Link:    [Ethernet Header][IP][TCP][HTTP Data][Ethernet Trailer]
    Physical:     Bits on the wire
    ```

    Each layer adds its own header (and sometimes trailer).

    ## Why the OSI Model Matters for Troubleshooting

    Understanding layers helps pinpoint where problems occur:

    - **Can't ping a server?** → Layer 3 (Network) issue
    - **Ping works but HTTP doesn't?** → Check Layer 4 (ports/firewall) or Layer 7 (HTTP service)
    - **Ethernet cable unplugged?** → Layer 1 (Physical) issue
    - **DNS not resolving?** → Layer 7 (Application) issue
    - **TCP connection refused?** → Layer 4 (Transport) issue

    The OSI model provides a common language: "This looks like a Layer 4 issue" means a transport (TCP/UDP) problem.

    ## Key Takeaways

    1. **OSI model has 7 layers** from Physical to Application
    2. **TCP/IP model has 4 layers** and is what the internet actually uses
    3. **Each layer serves a specific purpose** and communicates with adjacent layers
    4. **Encapsulation** wraps data at each layer with headers
    5. **Troubleshooting** becomes easier when you understand which layer a problem occurs at
    6. **Real protocols map to layers**: HTTP (L7), TCP (L4), IP (L3), Ethernet (L2)
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Day 2: IP Addressing and Subnetting Basics

    ## Learning Goals

    - Develop a solid understanding of IP addresses (especially IPv4)
    - Learn how networks are divided into subnets
    - Interpret CIDR notation (e.g., /24) and perform basic subnet calculations
    - Distinguish between public vs private IP ranges
    - Understand why private networks use NAT to reach the internet

    ## What is an IP Address?

    An **IP address** is a numerical label assigned to every device on a network. Think of it as a mailing address for your computer – it tells other devices where to send data.

    ### IPv4 Address Anatomy

    - **Format**: 32-bit address shown in dotted-decimal notation
    - **Example**: `192.168.4.12`
    - **Structure**: Four octets (bytes), each ranging from 0-255
    - **Binary**: Each octet is 8 bits: `11000000.10101000.00000100.00001100`

    ### IPv4 Address Space

    - **Total addresses**: 2³² = ~4.3 billion addresses
    - **Problem**: We're running out due to internet growth
    - **Solution**: IPv6 (128-bit addresses), NAT, and private IP ranges

    ## Subnet Masks and Network/Host Division

    A subnet mask splits an IP address into two parts:
    1. **Network portion**: Identifies which network the device is on
    2. **Host portion**: Identifies the specific device within that network

    ### Example: 192.168.5.0/24

    - **IP Range**: `192.168.5.0/24`
    - **Subnet Mask**: `255.255.255.0`
    - **/24 means**: First 24 bits are network, last 8 bits are hosts
    - **Network portion**: `192.168.5` (first 24 bits)
    - **Host portion**: last 8 bits = 256 possible addresses
    - **Usable hosts**: 254 (we subtract network address .0 and broadcast .255)

    ## CIDR Notation (Classless Inter-Domain Routing)

    CIDR notation uses a slash followed by the number of network bits:

    | CIDR | Subnet Mask | Network Bits | Host Bits | Total IPs | Usable Hosts |
    |------|-------------|--------------|-----------|-----------|--------------|
    | /32 | 255.255.255.255 | 32 | 0 | 1 | 1 (single host) |
    | /30 | 255.255.255.252 | 30 | 2 | 4 | 2 |
    | /29 | 255.255.255.248 | 29 | 3 | 8 | 6 |
    | /28 | 255.255.255.240 | 28 | 4 | 16 | 14 |
    | /27 | 255.255.255.224 | 27 | 5 | 32 | 30 |
    | /26 | 255.255.255.192 | 26 | 6 | 64 | 62 |
    | /25 | 255.255.255.128 | 25 | 7 | 128 | 126 |
    | /24 | 255.255.255.0 | 24 | 8 | 256 | 254 |
    | /16 | 255.255.0.0 | 16 | 16 | 65,536 | 65,534 |
    | /8 | 255.0.0.0 | 8 | 24 | 16,777,216 | 16,777,214 |

    ### Calculating Usable Hosts

    For a subnet with N host bits:
    - **Total addresses**: 2ᴺ
    - **Usable hosts**: 2ᴺ - 2 (subtract network and broadcast addresses)

    **Example**: /26 subnet
    - Host bits: 32 - 26 = 6
    - Total addresses: 2⁶ = 64
    - Usable hosts: 64 - 2 = 62

    ## Private vs Public IP Addresses

    ### Private IP Ranges (RFC 1918)

    These IP ranges are reserved for internal networks and NOT routable on the public internet:

    | Class | Range | CIDR | Total IPs |
    |-------|-------|------|-----------|
    | A | 10.0.0.0 - 10.255.255.255 | 10.0.0.0/8 | 16,777,216 |
    | B | 172.16.0.0 - 172.31.255.255 | 172.16.0.0/12 | 1,048,576 |
    | C | 192.168.0.0 - 192.168.255.255 | 192.168.0.0/16 | 65,536 |

    **Uses:**
    - Home networks (typically 192.168.x.x)
    - Corporate internal networks
    - Cloud VPCs (often use 10.x.x.x or 172.16.x.x)

    ### Public IP Addresses

    - **Globally unique** addresses assigned by IANA/ISPs
    - **Routable** on the public internet
    - **Examples**: `8.8.8.8` (Google DNS), `1.1.1.1` (Cloudflare DNS)
    - **Cost**: Public IPs are a limited resource and often cost money in cloud environments

    ### Why Both Private and Public?

    - **IPv4 address exhaustion**: Not enough public IPs for every device
    - **Security**: Private networks hidden behind NAT
    - **Flexibility**: Reuse same private ranges in different organizations

    ## NAT (Network Address Translation)

    NAT allows multiple devices on a private network to share a single public IP address when accessing the internet.

    ### How NAT Works

    1. **Internal device** (192.168.1.100) wants to access Google (142.250.64.78)
    2. **Device sends packet** with source IP 192.168.1.100
    3. **Router (NAT device)** receives packet, replaces source IP with its own public IP (e.g., 203.0.113.5)
    4. **Router tracks** the connection in a NAT table
    5. **Google responds** to 203.0.113.5
    6. **Router receives response**, looks up NAT table, forwards to 192.168.1.100

    ### Types of NAT

    - **Static NAT**: One-to-one mapping (one private IP to one public IP)
    - **Dynamic NAT**: Pool of public IPs shared among private IPs
    - **PAT (Port Address Translation)**: Most common – many private IPs share one public IP using different port numbers

    ## Subnetting: Dividing Networks

    **Subnetting** is dividing a network into smaller networks (subnets) for:
    - Efficient IP address allocation
    - Improved security (isolate network segments)
    - Reduced broadcast traffic
    - Organizational structure (one subnet per department/floor)

    ### Subnetting Example

    **Given**: 10.0.0.0/16 network
    **Goal**: Create 4 equal subnets

    **Solution**:
    - Original: /16 (16 network bits, 16 host bits)
    - Need 4 subnets: 2² = 4, so borrow 2 bits from host portion
    - New prefix: /18 (16 + 2 = 18)
    - Each subnet: 2⁽³²⁻¹⁸⁾ = 2¹⁴ = 16,384 addresses

    **Result**:
    1. 10.0.0.0/18 (10.0.0.0 - 10.0.63.255)
    2. 10.0.64.0/18 (10.0.64.0 - 10.0.127.255)
    3. 10.0.128.0/18 (10.0.128.0 - 10.0.191.255)
    4. 10.0.192.0/18 (10.0.192.0 - 10.0.255.255)

    ## Special IP Addresses

    - **0.0.0.0**: Default route or "this network"
    - **127.0.0.1**: Localhost (loopback address)
    - **169.254.x.x**: Link-local addresses (APIPA - auto-configured when DHCP fails)
    - **224.0.0.0/4**: Multicast addresses
    - **First IP in subnet**: Network address (identifies the subnet)
    - **Last IP in subnet**: Broadcast address (send to all hosts in subnet)

    ## IP Addressing in Cloud VPCs

    When designing cloud networks (AWS VPC, Azure VNet, GCP VPC):

    1. **Choose a large enough CIDR block**: e.g., 10.0.0.0/16 gives 65,536 addresses
    2. **Subnet for different tiers**:
       - Public subnet: 10.0.0.0/24 (web servers)
       - Private subnet: 10.0.1.0/24 (app servers)
       - Database subnet: 10.0.2.0/24 (databases)
    3. **Avoid overlapping**: If connecting VPCs or to on-premises, ensure no overlap
    4. **Reserve IPs**: Cloud providers reserve some IPs in each subnet (e.g., AWS reserves .0, .1, .2, .3, .255)

    ## Key Takeaways

    1. **IPv4 addresses** are 32-bit addresses in dotted-decimal notation
    2. **Subnet masks** divide addresses into network and host portions
    3. **CIDR notation** (/24, /16, etc.) indicates the number of network bits
    4. **Private IP ranges** (10.x.x.x, 172.16.x.x, 192.168.x.x) are for internal networks
    5. **Public IPs** are globally unique and routable on the internet
    6. **NAT** allows private IPs to access the internet via a shared public IP
    7. **Subnetting** divides networks for better organization and security
    8. **Calculating hosts**: For /N, hosts = 2⁽³²⁻ᴺ⁾ - 2

    ## Practice Calculations

    **Exercise 1**: What is the network address and broadcast address for 192.168.10.50/24?
    - Network: 192.168.10.0
    - Broadcast: 192.168.10.255

    **Exercise 2**: How many usable hosts in a /27 subnet?
    - Host bits: 32 - 27 = 5
    - Total: 2⁵ = 32
    - Usable: 32 - 2 = 30

    **Exercise 3**: Is 172.20.5.10 a private or public IP?
    - Private (falls within 172.16.0.0/12 range)
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

# Day 3: Network Services – DNS, DHCP, NAT and Routing Essentials

    ## Learning Goals

    - Understand key network services that make IP networks function
    - Learn how DNS resolves names to IP addresses
    - Understand how DHCP automatically assigns IP configurations
    - Master NAT concepts and why it's essential
    - Grasp basic routing between networks

    ## The Four Pillars of Network Services

    Modern networks rely on four key services:
    1. **DHCP** - Automatic IP configuration
    2. **DNS** - Name to IP address resolution
    3. **NAT** - Sharing public IPs across private networks
    4. **Routing** - Forwarding packets between networks

    ## DHCP (Dynamic Host Configuration Protocol)

    ### What is DHCP?

    DHCP automatically provides devices with their network configuration when they join a network. Without DHCP, you'd have to manually configure every device!

    ### What DHCP Provides

    When a device connects to a network, DHCP can supply:
    - **IP address** (e.g., 192.168.1.100)
    - **Subnet mask** (e.g., 255.255.255.0)
    - **Default gateway** (e.g., 192.168.1.1)
    - **DNS server(s)** (e.g., 8.8.8.8, 8.8.4.4)
    - **Lease time** (how long the IP is valid)
    - **Domain name** (e.g., company.local)

    ### DHCP Process (DORA)

    The DHCP handshake has four steps:

    ```
    1. DISCOVER: Client broadcasts "I need an IP!"
       Source: 0.0.0.0, Dest: 255.255.255.255 (broadcast)

    2. OFFER: DHCP server responds "Here's 192.168.1.100"
       Server offers available IP from its pool

    3. REQUEST: Client broadcasts "I'll take 192.168.1.100"
       Client requests the offered IP

    4. ACK: Server confirms "192.168.1.100 is yours for 24 hours"
       Server acknowledges and activates the lease
    ```

    ### DHCP Components

    - **DHCP Server**: Device that manages IP address pool and leases
      - Often your router in home networks
      - Dedicated server in enterprise networks
      - Managed service in cloud environments

    - **DHCP Client**: Any device that requests automatic configuration
      - Laptops, phones, IoT devices, VMs

    - **IP Address Pool**: Range of IPs available for assignment
      - Example: 192.168.1.100 - 192.168.1.200

    - **Lease Time**: How long a client can use an IP before renewal
      - Home networks: Often 24 hours
      - Enterprise: May be shorter for better control

    ### Static vs Dynamic IP

    - **Dynamic (DHCP)**: IP assigned automatically, can change
      - Best for: Client devices, laptops, phones, non-critical servers

    - **Static**: Manually configured IP that doesn't change
      - Best for: Servers, printers, network equipment, DNS servers

    ## DNS (Domain Name System)

    ### What is DNS?

    DNS is the internet's "phonebook" – it translates human-friendly domain names into IP addresses that computers use to communicate.

    **Without DNS**: You'd need to remember `142.250.64.78` instead of `google.com`

    ### How DNS Resolution Works

    When you type `www.example.com` in your browser:

    ```
    1. Browser checks local cache
       → If found, use cached IP

    2. Browser asks OS resolver
       → OS checks /etc/hosts (Linux/Mac) or C:\\Windows\\System32\\drivers\\etc\\hosts

    3. OS asks configured DNS server (from DHCP or manual config)
       → Usually your ISP's DNS or public DNS like 8.8.8.8

    4. DNS server checks its cache
       → If not cached, performs recursive resolution

    5. Recursive resolution (if needed):
       a. Query root DNS servers (.) → "Ask .com servers"
       b. Query TLD servers (.com) → "Ask example.com nameserver"
       c. Query authoritative nameserver → "www.example.com is 93.184.216.34"

    6. DNS server returns IP to OS

    7. OS returns IP to browser

    8. Browser connects to 93.184.216.34
    ```

    ### DNS Record Types

    | Record | Purpose | Example |
    |--------|---------|---------|
    | **A** | Maps domain to IPv4 address | example.com → 93.184.216.34 |
    | **AAAA** | Maps domain to IPv6 address | example.com → 2606:2800:220:1:... |
    | **CNAME** | Alias from one domain to another | www.example.com → example.com |
    | **MX** | Mail server for domain | example.com → mail.example.com (priority 10) |
    | **TXT** | Text information (SPF, DKIM, verification) | Various metadata |
    | **NS** | Nameserver for domain | example.com → ns1.provider.com |
    | **PTR** | Reverse DNS (IP to domain) | 93.184.216.34 → example.com |

    ### DNS in Practice

    **Home Network**:
    - Router acts as DNS forwarder
    - Forwards queries to ISP DNS or configured DNS (e.g., 8.8.8.8)

    **Enterprise**:
    - Internal DNS servers for company domains (e.g., server1.company.local)
    - Forward public queries to internet DNS

    **Cloud (AWS/Azure/GCP)**:
    - Managed DNS services (Route 53, Azure DNS, Cloud DNS)
    - Internal DNS for VPC/VNet resources

    ### Public DNS Servers

    | Provider | IPv4 | Purpose |
    |----------|------|---------|
    | Google | 8.8.8.8, 8.8.4.4 | Fast, reliable |
    | Cloudflare | 1.1.1.1, 1.0.0.1 | Privacy-focused, fast |
    | Quad9 | 9.9.9.9 | Security filtering |
    | OpenDNS | 208.67.222.222, 208.67.220.220 | Content filtering |

    ## NAT (Network Address Translation)

    ### What is NAT?

    NAT allows multiple devices on a private network to share a single public IP address when accessing the internet.

    **Why NAT Exists:**
    - IPv4 address exhaustion (not enough public IPs for every device)
    - Security (hide internal network structure)
    - Cost (public IPs cost money)

    ### How NAT Works

    **Scenario**: Home network with multiple devices behind a router

    ```
    Internal Network (Private): 192.168.1.0/24
    Router's Public IP: 203.0.113.5

    Device A (192.168.1.100) wants to visit Google (142.250.64.78)

    Step 1: Device sends packet
      Source: 192.168.1.100:54321
      Dest: 142.250.64.78:443

    Step 2: Router (NAT) modifies packet
      Source: 203.0.113.5:54321 ← Changed!
      Dest: 142.250.64.78:443
      [Router records: 192.168.1.100:54321 → 203.0.113.5:54321]

    Step 3: Google responds
      Source: 142.250.64.78:443
      Dest: 203.0.113.5:54321

    Step 4: Router translates back
      [Looks up: 54321 → 192.168.1.100:54321]
      Source: 142.250.64.78:443
      Dest: 192.168.1.100:54321 ← Changed back!

    Step 5: Device receives response
    ```

    ### Types of NAT

    1. **Static NAT**: One-to-one mapping
       - One private IP always maps to one specific public IP
       - Used for servers that need consistent public access

    2. **Dynamic NAT**: Many-to-many mapping
       - Pool of public IPs shared among private IPs
       - First-come, first-served

    3. **PAT (Port Address Translation)** / NAT Overload: Many-to-one
       - Most common type
       - Many private IPs share ONE public IP
       - Uses different port numbers to distinguish connections

    ### NAT in Cloud Environments

    **AWS**:
    - **NAT Gateway**: Managed NAT service for private subnets
    - **Internet Gateway**: Provides NAT for instances with public IPs

    **Azure**:
    - **Azure NAT Gateway**: Outbound internet connectivity for VNets

    **GCP**:
    - **Cloud NAT**: Managed NAT service

    ## Routing Basics

    ### What is Routing?

    **Routing** is the process of forwarding IP packets between networks. A **router** is a device (or software function) that performs this forwarding.

    ### How Routing Works

    Every device has a **routing table** that determines where to send packets:

    ```
    Example routing table for host 10.0.1.5:

    Destination        Gateway        Interface
    10.0.1.0/24        *              eth0       (Direct: same subnet)
    0.0.0.0/0          10.0.1.1       eth0       (Default: everything else)
    ```

    **Decision process**:
    1. Packet destined for 10.0.1.100 → Same subnet → Send directly via eth0
    2. Packet destined for 8.8.8.8 → No specific route → Send to default gateway 10.0.1.1

    ### Default Gateway

    The **default gateway** is the router that handles all traffic destined for other networks.

    **Example**:
    - Your laptop: 192.168.1.100
    - Default gateway: 192.168.1.1 (your router)
    - To reach Google (8.8.8.8), laptop sends packet to 192.168.1.1
    - Router forwards packet toward the internet

    ### Routing Between Networks

    ```
    Network A: 10.0.1.0/24 ←→ Router ←→ Network B: 10.0.2.0/24

    Host A (10.0.1.5) sends packet to Host B (10.0.2.10):

    1. Host A checks routing table: 10.0.2.0/24 not in local subnet
    2. Host A sends to default gateway (10.0.1.1)
    3. Router receives packet, checks its routing table
    4. Router knows 10.0.2.0/24 is on its eth1 interface
    5. Router forwards packet to 10.0.2.10
    6. Host B receives packet
    ```

    ### Static vs Dynamic Routing

    **Static Routing**:
    - Routes manually configured by administrator
    - Simple, predictable
    - Doesn't adapt to network changes
    - Good for small networks

    **Dynamic Routing**:
    - Routers automatically discover routes and adapt to changes
    - Uses routing protocols: RIP, OSPF, EIGRP, BGP
    - Scales to large networks
    - More complex but more resilient

    ## Putting It All Together: Complete Scenario

    **Scenario**: You connect your laptop to Wi-Fi and visit google.com

    ### Step-by-Step Flow

    ```
    1. DHCP Configuration
       - Laptop sends DHCP DISCOVER
       - Router responds with DHCP OFFER: 192.168.1.100/24
       - Laptop accepts, gets: IP, subnet, gateway (192.168.1.1), DNS (8.8.8.8)

    2. DNS Resolution
       - Laptop asks DNS server (8.8.8.8): "What's the IP for google.com?"
       - DNS responds: "142.250.64.78"

    3. Routing Decision
       - Laptop checks: 142.250.64.78 not in local subnet (192.168.1.0/24)
       - Sends packet to default gateway (192.168.1.1)

    4. NAT Translation
       - Router (NAT) receives packet from 192.168.1.100:54321
       - Changes source to router's public IP: 203.0.113.5:54321
       - Records mapping in NAT table

    5. Internet Routing
       - Packet travels through ISP routers to Google's network
       - Google responds to 203.0.113.5:54321

    6. NAT Translation (Return)
       - Router receives response on port 54321
       - Looks up NAT table: 54321 → 192.168.1.100:54321
       - Forwards to laptop

    7. Application
       - Laptop's browser receives data
       - Displays Google homepage
    ```

    ## Key Takeaways

    1. **DHCP** automatically configures devices with IP, gateway, DNS, and more
    2. **DNS** translates domain names to IP addresses via recursive resolution
    3. **NAT** allows multiple private IPs to share one public IP using port mapping
    4. **Routing** forwards packets between networks using routing tables and gateways
    5. **Default gateway** is the router that handles traffic to other networks
    6. All four services work together to enable seamless internet connectivity

    ## Common Troubleshooting

    | Problem | Likely Service | What to Check |
    |---------|---------------|---------------|
    | No IP address | DHCP | Is DHCP server running? IP pool exhausted? |
    | Can't resolve names | DNS | Check DNS server config, try `nslookup` or `dig` |
    | Can't reach internet | NAT/Routing | Check gateway IP, NAT configuration, routing table |
    | Local network works, internet doesn't | Gateway/NAT | Verify default gateway, NAT rules, ISP connection |
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

# Day 1: Networking Foundations – The OSI Model in Practice

    ## Learning Goals

    - Understand the purpose of the OSI 7-layer model and how real-world protocols map to each layer
    - Recognize examples like how HTTP (web) fits at the Application layer and TCP/IP fit in Transport/Network layers
    - Grasp why the OSI layered approach helps in troubleshooting and designing networks

    ## Why Networking Matters for DevOps

    Networking knowledge is critical for DevOps roles – even if many focus on code or cloud, no part of IT infrastructure should remain a "black box". Many common DevOps tasks rely on understanding networking fundamentals:
    - Troubleshooting connectivity issues
    - Setting up container networks
    - Configuring Kubernetes networking
    - Designing cloud VPCs and security groups

    ## The OSI Model: A Conceptual Framework

    ### What is the OSI Model?

    The Open Systems Interconnection (OSI) model is a conceptual framework that breaks network communication into seven layers, from physical hardware up to applications. Each layer has specific roles, making it easier to pinpoint where issues occur.

    **The Problem It Solves:**
    Without layering, every application would need to understand everything from WiFi signals to data display – impossibly complex!

    **The Solution:**
    Break networking into independent layers, each solving ONE problem. Each layer:
    - Has a specific job
    - Provides services to the layer above
    - Uses services from the layer below
    - Can change independently (upgrade WiFi without changing HTTP)

    ### The 7 Layers of the OSI Model

    | Layer | Name | What It Does | Real-World Example |
    |-------|------|--------------|-------------------|
    | **7** | Application | User-facing applications and protocols | HTTP, FTP, SMTP, DNS |
    | **6** | Presentation | Data representation and encryption | TLS, data formatting |
    | **5** | Session | Manages sessions or connections | API session tokens, TCP sessions |
    | **4** | Transport | End-to-end data transport | TCP (reliable), UDP (fast) |
    | **3** | Network | Routing and addressing | IP addresses, routers |
    | **2** | Data Link | Local network communication | Ethernet, switches, MAC addresses |
    | **1** | Physical | Physical medium | Ethernet cables, Wi-Fi, fiber optics |

    **Mnemonic:** "**P**lease **D**o **N**ot **T**hrow **S**ausage **P**izza **A**way"

    ### Layer-by-Layer Deep Dive

    #### Layer 1: Physical
    - **What**: Actual electrical signals, light pulses, or radio waves transmitting raw bits
    - **Examples**: Ethernet cables, Wi-Fi radio, fiber optics
    - **Data Units**: Bits (1s and 0s)
    - **Analogy**: The roads mail trucks drive on

    #### Layer 2: Data Link
    - **What**: Local network communication within the same network
    - **Addressing**: MAC addresses (e.g., `AA:BB:CC:DD:EE:FF`)
    - **Devices**: Switches, network cards
    - **Data Units**: Frames
    - **Key Feature**: Error detection with CRC
    - **Example**: Your laptop talking to your WiFi router

    #### Layer 3: Network
    - **What**: Routing and addressing across multiple networks
    - **Addressing**: IP addresses (e.g., `192.168.1.1`)
    - **Devices**: Routers
    - **Data Units**: Packets
    - **Protocols**: IP, ICMP (ping), routing protocols
    - **Example**: Sending data from your home to Google's servers

    #### Layer 4: Transport
    - **What**: End-to-end reliable delivery or fast delivery
    - **Protocols**:
      - **TCP**: Reliable, connection-oriented, ensures data arrives in order
      - **UDP**: Unreliable, connectionless, just sends packets without guarantees
    - **Addressing**: Port numbers (e.g., 80 for HTTP, 443 for HTTPS)
    - **Data Units**: Segments (TCP) or Datagrams (UDP)

    #### Layer 5: Session
    - **What**: Manages connections between applications
    - **Examples**: Ongoing TCP session, API session token
    - **Purpose**: Establishes, maintains, and terminates connections

    #### Layer 6: Presentation
    - **What**: Data representation and encryption
    - **Examples**: TLS/SSL encryption, data compression, format conversion
    - **Purpose**: Ensures data is in a usable format

    #### Layer 7: Application
    - **What**: User-facing protocols that enable software to communicate
    - **Examples**: HTTP (web), DNS (name resolution), SMTP (email), FTP (file transfer)
    - **Purpose**: Provides network services to applications

    ## The TCP/IP Model (4 Layers)

    While the OSI model is great for teaching, the internet ACTUALLY uses the TCP/IP model:

    | TCP/IP Layer | OSI Equivalent | Key Protocols | Purpose |
    |--------------|----------------|---------------|---------|
    | Application | Layers 5-7 | HTTP, DNS, SSH, FTP | App-level protocols |
    | Transport | Layer 4 | TCP, UDP | Reliable/fast delivery |
    | Internet | Layer 3 | IP, ICMP, ARP | Routing across networks |
    | Link | Layers 1-2 | Ethernet, WiFi | Physical network |

    ## Example: Loading a Webpage

    When you visit `https://example.com`, here's what happens at each layer:

    ### Going Down the Stack (Sending Request)

    ```
    Application Layer (L7):
    - Browser creates HTTP GET request
    - HTTPS adds TLS encryption

    Transport Layer (L4):
    - TCP wraps request with source port (random) and dest port (443)
    - Adds sequence numbers for reassembly

    Network Layer (L3):
    - IP adds your IP address and destination IP
    - Determines next hop router

    Data Link Layer (L2):
    - Ethernet adds MAC addresses for local network
    - Sends frame to router's MAC address

    Physical Layer (L1):
    - Electrical/radio signals transmitted over wire/air
    ```

    ### Coming Up the Stack (Receiving Response)

    ```
    Physical Layer: Receives electrical signals
    Data Link Layer: Checks MAC, removes Ethernet header
    Network Layer: Checks destination IP, removes IP header
    Transport Layer: Checks port 443, sends to HTTPS process, removes TCP header
    Application Layer: Web server processes HTTP request, sends back HTML
    ```

    ## Encapsulation: How Data Travels

    Data gets wrapped at each layer like Russian nesting dolls:

    ```
    Application:  [HTTP Data]
    Transport:    [TCP Header][HTTP Data]
    Network:      [IP Header][TCP Header][HTTP Data]
    Data Link:    [Ethernet Header][IP][TCP][HTTP Data][Ethernet Trailer]
    Physical:     Bits on the wire
    ```

    Each layer adds its own header (and sometimes trailer).

    ## Why the OSI Model Matters for Troubleshooting

    Understanding layers helps pinpoint where problems occur:

    - **Can't ping a server?** → Layer 3 (Network) issue
    - **Ping works but HTTP doesn't?** → Check Layer 4 (ports/firewall) or Layer 7 (HTTP service)
    - **Ethernet cable unplugged?** → Layer 1 (Physical) issue
    - **DNS not resolving?** → Layer 7 (Application) issue
    - **TCP connection refused?** → Layer 4 (Transport) issue

    The OSI model provides a common language: "This looks like a Layer 4 issue" means a transport (TCP/UDP) problem.

    ## Key Takeaways

    1. **OSI model has 7 layers** from Physical to Application
    2. **TCP/IP model has 4 layers** and is what the internet actually uses
    3. **Each layer serves a specific purpose** and communicates with adjacent layers
    4. **Encapsulation** wraps data at each layer with headers
    5. **Troubleshooting** becomes easier when you understand which layer a problem occurs at
    6. **Real protocols map to layers**: HTTP (L7), TCP (L4), IP (L3), Ethernet (L2)
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

# Day 2: IP Addressing and Subnetting Basics

    ## Learning Goals

    - Develop a solid understanding of IP addresses (especially IPv4)
    - Learn how networks are divided into subnets
    - Interpret CIDR notation (e.g., /24) and perform basic subnet calculations
    - Distinguish between public vs private IP ranges
    - Understand why private networks use NAT to reach the internet

    ## What is an IP Address?

    An **IP address** is a numerical label assigned to every device on a network. Think of it as a mailing address for your computer – it tells other devices where to send data.

    ### IPv4 Address Anatomy

    - **Format**: 32-bit address shown in dotted-decimal notation
    - **Example**: `192.168.4.12`
    - **Structure**: Four octets (bytes), each ranging from 0-255
    - **Binary**: Each octet is 8 bits: `11000000.10101000.00000100.00001100`

    ### IPv4 Address Space

    - **Total addresses**: 2³² = ~4.3 billion addresses
    - **Problem**: We're running out due to internet growth
    - **Solution**: IPv6 (128-bit addresses), NAT, and private IP ranges

    ## Subnet Masks and Network/Host Division

    A subnet mask splits an IP address into two parts:
    1. **Network portion**: Identifies which network the device is on
    2. **Host portion**: Identifies the specific device within that network

    ### Example: 192.168.5.0/24

    - **IP Range**: `192.168.5.0/24`
    - **Subnet Mask**: `255.255.255.0`
    - **/24 means**: First 24 bits are network, last 8 bits are hosts
    - **Network portion**: `192.168.5` (first 24 bits)
    - **Host portion**: last 8 bits = 256 possible addresses
    - **Usable hosts**: 254 (we subtract network address .0 and broadcast .255)

    ## CIDR Notation (Classless Inter-Domain Routing)

    CIDR notation uses a slash followed by the number of network bits:

    | CIDR | Subnet Mask | Network Bits | Host Bits | Total IPs | Usable Hosts |
    |------|-------------|--------------|-----------|-----------|--------------|
    | /32 | 255.255.255.255 | 32 | 0 | 1 | 1 (single host) |
    | /30 | 255.255.255.252 | 30 | 2 | 4 | 2 |
    | /29 | 255.255.255.248 | 29 | 3 | 8 | 6 |
    | /28 | 255.255.255.240 | 28 | 4 | 16 | 14 |
    | /27 | 255.255.255.224 | 27 | 5 | 32 | 30 |
    | /26 | 255.255.255.192 | 26 | 6 | 64 | 62 |
    | /25 | 255.255.255.128 | 25 | 7 | 128 | 126 |
    | /24 | 255.255.255.0 | 24 | 8 | 256 | 254 |
    | /16 | 255.255.0.0 | 16 | 16 | 65,536 | 65,534 |
    | /8 | 255.0.0.0 | 8 | 24 | 16,777,216 | 16,777,214 |

    ### Calculating Usable Hosts

    For a subnet with N host bits:
    - **Total addresses**: 2ᴺ
    - **Usable hosts**: 2ᴺ - 2 (subtract network and broadcast addresses)

    **Example**: /26 subnet
    - Host bits: 32 - 26 = 6
    - Total addresses: 2⁶ = 64
    - Usable hosts: 64 - 2 = 62

    ## Private vs Public IP Addresses

    ### Private IP Ranges (RFC 1918)

    These IP ranges are reserved for internal networks and NOT routable on the public internet:

    | Class | Range | CIDR | Total IPs |
    |-------|-------|------|-----------|
    | A | 10.0.0.0 - 10.255.255.255 | 10.0.0.0/8 | 16,777,216 |
    | B | 172.16.0.0 - 172.31.255.255 | 172.16.0.0/12 | 1,048,576 |
    | C | 192.168.0.0 - 192.168.255.255 | 192.168.0.0/16 | 65,536 |

    **Uses:**
    - Home networks (typically 192.168.x.x)
    - Corporate internal networks
    - Cloud VPCs (often use 10.x.x.x or 172.16.x.x)

    ### Public IP Addresses

    - **Globally unique** addresses assigned by IANA/ISPs
    - **Routable** on the public internet
    - **Examples**: `8.8.8.8` (Google DNS), `1.1.1.1` (Cloudflare DNS)
    - **Cost**: Public IPs are a limited resource and often cost money in cloud environments

    ### Why Both Private and Public?

    - **IPv4 address exhaustion**: Not enough public IPs for every device
    - **Security**: Private networks hidden behind NAT
    - **Flexibility**: Reuse same private ranges in different organizations

    ## NAT (Network Address Translation)

    NAT allows multiple devices on a private network to share a single public IP address when accessing the internet.

    ### How NAT Works

    1. **Internal device** (192.168.1.100) wants to access Google (142.250.64.78)
    2. **Device sends packet** with source IP 192.168.1.100
    3. **Router (NAT device)** receives packet, replaces source IP with its own public IP (e.g., 203.0.113.5)
    4. **Router tracks** the connection in a NAT table
    5. **Google responds** to 203.0.113.5
    6. **Router receives response**, looks up NAT table, forwards to 192.168.1.100

    ### Types of NAT

    - **Static NAT**: One-to-one mapping (one private IP to one public IP)
    - **Dynamic NAT**: Pool of public IPs shared among private IPs
    - **PAT (Port Address Translation)**: Most common – many private IPs share one public IP using different port numbers

    ## Subnetting: Dividing Networks

    **Subnetting** is dividing a network into smaller networks (subnets) for:
    - Efficient IP address allocation
    - Improved security (isolate network segments)
    - Reduced broadcast traffic
    - Organizational structure (one subnet per department/floor)

    ### Subnetting Example

    **Given**: 10.0.0.0/16 network
    **Goal**: Create 4 equal subnets

    **Solution**:
    - Original: /16 (16 network bits, 16 host bits)
    - Need 4 subnets: 2² = 4, so borrow 2 bits from host portion
    - New prefix: /18 (16 + 2 = 18)
    - Each subnet: 2⁽³²⁻¹⁸⁾ = 2¹⁴ = 16,384 addresses

    **Result**:
    1. 10.0.0.0/18 (10.0.0.0 - 10.0.63.255)
    2. 10.0.64.0/18 (10.0.64.0 - 10.0.127.255)
    3. 10.0.128.0/18 (10.0.128.0 - 10.0.191.255)
    4. 10.0.192.0/18 (10.0.192.0 - 10.0.255.255)

    ## Special IP Addresses

    - **0.0.0.0**: Default route or "this network"
    - **127.0.0.1**: Localhost (loopback address)
    - **169.254.x.x**: Link-local addresses (APIPA - auto-configured when DHCP fails)
    - **224.0.0.0/4**: Multicast addresses
    - **First IP in subnet**: Network address (identifies the subnet)
    - **Last IP in subnet**: Broadcast address (send to all hosts in subnet)

    ## IP Addressing in Cloud VPCs

    When designing cloud networks (AWS VPC, Azure VNet, GCP VPC):

    1. **Choose a large enough CIDR block**: e.g., 10.0.0.0/16 gives 65,536 addresses
    2. **Subnet for different tiers**:
       - Public subnet: 10.0.0.0/24 (web servers)
       - Private subnet: 10.0.1.0/24 (app servers)
       - Database subnet: 10.0.2.0/24 (databases)
    3. **Avoid overlapping**: If connecting VPCs or to on-premises, ensure no overlap
    4. **Reserve IPs**: Cloud providers reserve some IPs in each subnet (e.g., AWS reserves .0, .1, .2, .3, .255)

    ## Key Takeaways

    1. **IPv4 addresses** are 32-bit addresses in dotted-decimal notation
    2. **Subnet masks** divide addresses into network and host portions
    3. **CIDR notation** (/24, /16, etc.) indicates the number of network bits
    4. **Private IP ranges** (10.x.x.x, 172.16.x.x, 192.168.x.x) are for internal networks
    5. **Public IPs** are globally unique and routable on the internet
    6. **NAT** allows private IPs to access the internet via a shared public IP
    7. **Subnetting** divides networks for better organization and security
    8. **Calculating hosts**: For /N, hosts = 2⁽³²⁻ᴺ⁾ - 2

    ## Practice Calculations

    **Exercise 1**: What is the network address and broadcast address for 192.168.10.50/24?
    - Network: 192.168.10.0
    - Broadcast: 192.168.10.255

    **Exercise 2**: How many usable hosts in a /27 subnet?
    - Host bits: 32 - 27 = 5
    - Total: 2⁵ = 32
    - Usable: 32 - 2 = 30

    **Exercise 3**: Is 172.20.5.10 a private or public IP?
    - Private (falls within 172.16.0.0/12 range)
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

# Day 3: Network Services – DNS, DHCP, NAT and Routing Essentials

    ## Learning Goals

    - Understand key network services that make IP networks function
    - Learn how DNS resolves names to IP addresses
    - Understand how DHCP automatically assigns IP configurations
    - Master NAT concepts and why it's essential
    - Grasp basic routing between networks

    ## The Four Pillars of Network Services

    Modern networks rely on four key services:
    1. **DHCP** - Automatic IP configuration
    2. **DNS** - Name to IP address resolution
    3. **NAT** - Sharing public IPs across private networks
    4. **Routing** - Forwarding packets between networks

    ## DHCP (Dynamic Host Configuration Protocol)

    ### What is DHCP?

    DHCP automatically provides devices with their network configuration when they join a network. Without DHCP, you'd have to manually configure every device!

    ### What DHCP Provides

    When a device connects to a network, DHCP can supply:
    - **IP address** (e.g., 192.168.1.100)
    - **Subnet mask** (e.g., 255.255.255.0)
    - **Default gateway** (e.g., 192.168.1.1)
    - **DNS server(s)** (e.g., 8.8.8.8, 8.8.4.4)
    - **Lease time** (how long the IP is valid)
    - **Domain name** (e.g., company.local)

    ### DHCP Process (DORA)

    The DHCP handshake has four steps:

    ```
    1. DISCOVER: Client broadcasts "I need an IP!"
       Source: 0.0.0.0, Dest: 255.255.255.255 (broadcast)

    2. OFFER: DHCP server responds "Here's 192.168.1.100"
       Server offers available IP from its pool

    3. REQUEST: Client broadcasts "I'll take 192.168.1.100"
       Client requests the offered IP

    4. ACK: Server confirms "192.168.1.100 is yours for 24 hours"
       Server acknowledges and activates the lease
    ```

    ### DHCP Components

    - **DHCP Server**: Device that manages IP address pool and leases
      - Often your router in home networks
      - Dedicated server in enterprise networks
      - Managed service in cloud environments

    - **DHCP Client**: Any device that requests automatic configuration
      - Laptops, phones, IoT devices, VMs

    - **IP Address Pool**: Range of IPs available for assignment
      - Example: 192.168.1.100 - 192.168.1.200

    - **Lease Time**: How long a client can use an IP before renewal
      - Home networks: Often 24 hours
      - Enterprise: May be shorter for better control

    ### Static vs Dynamic IP

    - **Dynamic (DHCP)**: IP assigned automatically, can change
      - Best for: Client devices, laptops, phones, non-critical servers

    - **Static**: Manually configured IP that doesn't change
      - Best for: Servers, printers, network equipment, DNS servers

    ## DNS (Domain Name System)

    ### What is DNS?

    DNS is the internet's "phonebook" – it translates human-friendly domain names into IP addresses that computers use to communicate.

    **Without DNS**: You'd need to remember `142.250.64.78` instead of `google.com`

    ### How DNS Resolution Works

    When you type `www.example.com` in your browser:

    ```
    1. Browser checks local cache
       → If found, use cached IP

    2. Browser asks OS resolver
       → OS checks /etc/hosts (Linux/Mac) or C:\\Windows\\System32\\drivers\\etc\\hosts

    3. OS asks configured DNS server (from DHCP or manual config)
       → Usually your ISP's DNS or public DNS like 8.8.8.8

    4. DNS server checks its cache
       → If not cached, performs recursive resolution

    5. Recursive resolution (if needed):
       a. Query root DNS servers (.) → "Ask .com servers"
       b. Query TLD servers (.com) → "Ask example.com nameserver"
       c. Query authoritative nameserver → "www.example.com is 93.184.216.34"

    6. DNS server returns IP to OS

    7. OS returns IP to browser

    8. Browser connects to 93.184.216.34
    ```

    ### DNS Record Types

    | Record | Purpose | Example |
    |--------|---------|---------|
    | **A** | Maps domain to IPv4 address | example.com → 93.184.216.34 |
    | **AAAA** | Maps domain to IPv6 address | example.com → 2606:2800:220:1:... |
    | **CNAME** | Alias from one domain to another | www.example.com → example.com |
    | **MX** | Mail server for domain | example.com → mail.example.com (priority 10) |
    | **TXT** | Text information (SPF, DKIM, verification) | Various metadata |
    | **NS** | Nameserver for domain | example.com → ns1.provider.com |
    | **PTR** | Reverse DNS (IP to domain) | 93.184.216.34 → example.com |

    ### DNS in Practice

    **Home Network**:
    - Router acts as DNS forwarder
    - Forwards queries to ISP DNS or configured DNS (e.g., 8.8.8.8)

    **Enterprise**:
    - Internal DNS servers for company domains (e.g., server1.company.local)
    - Forward public queries to internet DNS

    **Cloud (AWS/Azure/GCP)**:
    - Managed DNS services (Route 53, Azure DNS, Cloud DNS)
    - Internal DNS for VPC/VNet resources

    ### Public DNS Servers

    | Provider | IPv4 | Purpose |
    |----------|------|---------|
    | Google | 8.8.8.8, 8.8.4.4 | Fast, reliable |
    | Cloudflare | 1.1.1.1, 1.0.0.1 | Privacy-focused, fast |
    | Quad9 | 9.9.9.9 | Security filtering |
    | OpenDNS | 208.67.222.222, 208.67.220.220 | Content filtering |

    ## NAT (Network Address Translation)

    ### What is NAT?

    NAT allows multiple devices on a private network to share a single public IP address when accessing the internet.

    **Why NAT Exists:**
    - IPv4 address exhaustion (not enough public IPs for every device)
    - Security (hide internal network structure)
    - Cost (public IPs cost money)

    ### How NAT Works

    **Scenario**: Home network with multiple devices behind a router

    ```
    Internal Network (Private): 192.168.1.0/24
    Router's Public IP: 203.0.113.5

    Device A (192.168.1.100) wants to visit Google (142.250.64.78)

    Step 1: Device sends packet
      Source: 192.168.1.100:54321
      Dest: 142.250.64.78:443

    Step 2: Router (NAT) modifies packet
      Source: 203.0.113.5:54321 ← Changed!
      Dest: 142.250.64.78:443
      [Router records: 192.168.1.100:54321 → 203.0.113.5:54321]

    Step 3: Google responds
      Source: 142.250.64.78:443
      Dest: 203.0.113.5:54321

    Step 4: Router translates back
      [Looks up: 54321 → 192.168.1.100:54321]
      Source: 142.250.64.78:443
      Dest: 192.168.1.100:54321 ← Changed back!

    Step 5: Device receives response
    ```

    ### Types of NAT

    1. **Static NAT**: One-to-one mapping
       - One private IP always maps to one specific public IP
       - Used for servers that need consistent public access

    2. **Dynamic NAT**: Many-to-many mapping
       - Pool of public IPs shared among private IPs
       - First-come, first-served

    3. **PAT (Port Address Translation)** / NAT Overload: Many-to-one
       - Most common type
       - Many private IPs share ONE public IP
       - Uses different port numbers to distinguish connections

    ### NAT in Cloud Environments

    **AWS**:
    - **NAT Gateway**: Managed NAT service for private subnets
    - **Internet Gateway**: Provides NAT for instances with public IPs

    **Azure**:
    - **Azure NAT Gateway**: Outbound internet connectivity for VNets

    **GCP**:
    - **Cloud NAT**: Managed NAT service

    ## Routing Basics

    ### What is Routing?

    **Routing** is the process of forwarding IP packets between networks. A **router** is a device (or software function) that performs this forwarding.

    ### How Routing Works

    Every device has a **routing table** that determines where to send packets:

    ```
    Example routing table for host 10.0.1.5:

    Destination        Gateway        Interface
    10.0.1.0/24        *              eth0       (Direct: same subnet)
    0.0.0.0/0          10.0.1.1       eth0       (Default: everything else)
    ```

    **Decision process**:
    1. Packet destined for 10.0.1.100 → Same subnet → Send directly via eth0
    2. Packet destined for 8.8.8.8 → No specific route → Send to default gateway 10.0.1.1

    ### Default Gateway

    The **default gateway** is the router that handles all traffic destined for other networks.

    **Example**:
    - Your laptop: 192.168.1.100
    - Default gateway: 192.168.1.1 (your router)
    - To reach Google (8.8.8.8), laptop sends packet to 192.168.1.1
    - Router forwards packet toward the internet

    ### Routing Between Networks

    ```
    Network A: 10.0.1.0/24 ←→ Router ←→ Network B: 10.0.2.0/24

    Host A (10.0.1.5) sends packet to Host B (10.0.2.10):

    1. Host A checks routing table: 10.0.2.0/24 not in local subnet
    2. Host A sends to default gateway (10.0.1.1)
    3. Router receives packet, checks its routing table
    4. Router knows 10.0.2.0/24 is on its eth1 interface
    5. Router forwards packet to 10.0.2.10
    6. Host B receives packet
    ```

    ### Static vs Dynamic Routing

    **Static Routing**:
    - Routes manually configured by administrator
    - Simple, predictable
    - Doesn't adapt to network changes
    - Good for small networks

    **Dynamic Routing**:
    - Routers automatically discover routes and adapt to changes
    - Uses routing protocols: RIP, OSPF, EIGRP, BGP
    - Scales to large networks
    - More complex but more resilient

    ## Putting It All Together: Complete Scenario

    **Scenario**: You connect your laptop to Wi-Fi and visit google.com

    ### Step-by-Step Flow

    ```
    1. DHCP Configuration
       - Laptop sends DHCP DISCOVER
       - Router responds with DHCP OFFER: 192.168.1.100/24
       - Laptop accepts, gets: IP, subnet, gateway (192.168.1.1), DNS (8.8.8.8)

    2. DNS Resolution
       - Laptop asks DNS server (8.8.8.8): "What's the IP for google.com?"
       - DNS responds: "142.250.64.78"

    3. Routing Decision
       - Laptop checks: 142.250.64.78 not in local subnet (192.168.1.0/24)
       - Sends packet to default gateway (192.168.1.1)

    4. NAT Translation
       - Router (NAT) receives packet from 192.168.1.100:54321
       - Changes source to router's public IP: 203.0.113.5:54321
       - Records mapping in NAT table

    5. Internet Routing
       - Packet travels through ISP routers to Google's network
       - Google responds to 203.0.113.5:54321

    6. NAT Translation (Return)
       - Router receives response on port 54321
       - Looks up NAT table: 54321 → 192.168.1.100:54321
       - Forwards to laptop

    7. Application
       - Laptop's browser receives data
       - Displays Google homepage
    ```

    ## Key Takeaways

    1. **DHCP** automatically configures devices with IP, gateway, DNS, and more
    2. **DNS** translates domain names to IP addresses via recursive resolution
    3. **NAT** allows multiple private IPs to share one public IP using port mapping
    4. **Routing** forwards packets between networks using routing tables and gateways
    5. **Default gateway** is the router that handles traffic to other networks
    6. All four services work together to enable seamless internet connectivity

    ## Common Troubleshooting

    | Problem | Likely Service | What to Check |
    |---------|---------------|---------------|
    | No IP address | DHCP | Is DHCP server running? IP pool exhausted? |
    | Can't resolve names | DNS | Check DNS server config, try `nslookup` or `dig` |
    | Can't reach internet | NAT/Routing | Check gateway IP, NAT configuration, routing table |
    | Local network works, internet doesn't | Gateway/NAT | Verify default gateway, NAT rules, ISP connection |
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 6 microlessons for Day1 Osi Model Practice"

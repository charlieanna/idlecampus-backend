# AUTO-GENERATED from tcp_ip_networking_course.rb
puts "Creating Microlessons for Network Models..."

module_var = CourseModule.find_by(slug: 'network-models')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# OSI and TCP/IP Models

    Understanding network models is essential for troubleshooting and designing networks.

    ## OSI Model (7 Layers)

    **Open Systems Interconnection** - conceptual framework

    ### Layer 7: Application
    - **Purpose**: End-user services and applications
    - **Protocols**: HTTP, HTTPS, FTP, SMTP, DNS, SSH
    - **Data Unit**: Data/Messages
    - **Examples**: Web browsers, email clients

    ### Layer 6: Presentation
    - **Purpose**: Data formatting, encryption, compression
    - **Protocols**: SSL/TLS, JPEG, MPEG
    - **Functions**: Character encoding, data serialization

    ### Layer 5: Session
    - **Purpose**: Session management and control
    - **Protocols**: NetBIOS, PPTP, RPC
    - **Functions**: Authentication, reconnection

    ### Layer 4: Transport
    - **Purpose**: End-to-end communication
    - **Protocols**: TCP, UDP
    - **Data Unit**: Segments (TCP) / Datagrams (UDP)
    - **Port Numbers**: 0-65535

    ### Layer 3: Network
    - **Purpose**: Routing and logical addressing
    - **Protocols**: IP, ICMP, OSPF, BGP
    - **Data Unit**: Packets
    - **Addressing**: IP addresses

    ### Layer 2: Data Link
    - **Purpose**: Node-to-node data transfer
    - **Protocols**: Ethernet, Wi-Fi (802.11), PPP
    - **Data Unit**: Frames
    - **Addressing**: MAC addresses

    ### Layer 1: Physical
    - **Purpose**: Physical transmission
    - **Components**: Cables, hubs, NICs
    - **Data Unit**: Bits
    - **Media**: Copper, fiber, wireless

    ## TCP/IP Model (4 Layers)

    **Practical implementation used in the Internet**

    ### Layer 4: Application
    - Combines OSI layers 5-7
    - Protocols: HTTP, FTP, DNS, SMTP, SSH

    ### Layer 3: Transport
    - Same as OSI Layer 4
    - TCP and UDP

    ### Layer 2: Internet
    - Same as OSI Layer 3
    - IP, ICMP, ARP

    ### Layer 1: Network Access
    - Combines OSI layers 1-2
    - Ethernet, Wi-Fi

    ## Encapsulation

    **Data is wrapped at each layer as it goes down the stack**

    ```
    Application Layer:    [Data]
    Transport Layer:      [TCP Header | Data]  → Segment
    Internet Layer:       [IP Header | TCP Header | Data]  → Packet
    Network Access:       [Ethernet Header | IP | TCP | Data | Trailer]  → Frame
    Physical:             01010101...  → Bits
    ```

    ### Example: Sending an HTTP Request

    ```
    1. Application: HTTP GET request
    2. Transport: Add TCP header (ports 52341 → 80)
    3. Internet: Add IP header (192.168.1.10 → 93.184.216.34)
    4. Network: Add Ethernet header (MAC addresses)
    5. Physical: Transmit as electrical/optical signals
    ```

    ## TCP vs UDP

    ### TCP (Transmission Control Protocol)
    **Reliable, connection-oriented**

    ✓ **Features:**
    - Connection establishment (3-way handshake)
    - Guaranteed delivery
    - Order preservation
    - Flow control
    - Error checking and recovery

    **Use cases:**
    - HTTP/HTTPS (web)
    - FTP (file transfer)
    - SMTP (email)
    - SSH (remote shell)

    **TCP Header:**
    ```
    0                   16                  31
    +---------------------------------------+
    |  Source Port  |  Destination Port     |
    +---------------------------------------+
    |        Sequence Number                |
    +---------------------------------------+
    |     Acknowledgment Number             |
    +---------------------------------------+
    | Offset| Flags |    Window Size        |
    +---------------------------------------+
    |  Checksum     |  Urgent Pointer       |
    +---------------------------------------+
    ```

    ### UDP (User Datagram Protocol)
    **Fast, connectionless**

    ✓ **Features:**
    - No connection establishment
    - No delivery guarantee
    - No ordering
    - Minimal overhead

    **Use cases:**
    - DNS queries
    - Video streaming
    - Online gaming
    - VoIP (voice)

    **UDP Header:**
    ```
    0                   16                  31
    +---------------------------------------+
    |  Source Port  |  Destination Port     |
    +---------------------------------------+
    |     Length    |      Checksum         |
    +---------------------------------------+
    ```

    ## TCP Three-Way Handshake

    **Connection establishment:**

    ```
    Client                              Server

    1. SYN (seq=100)
       ------------------------------------>
       "I want to connect"

    2.                        SYN-ACK (seq=300, ack=101)
       <------------------------------------
       "OK, let's connect"

    3. ACK (seq=101, ack=301)
       ------------------------------------>
       "Connection established"

    [Data Transfer]

    4. FIN
       ------------------------------------>
       "I'm done"

    5.                        ACK
       <------------------------------------

    6.                        FIN
       <------------------------------------

    7. ACK
       ------------------------------------>
    ```

    ## Common Port Numbers

    ### Well-Known Ports (0-1023)

    ```
    20/21  - FTP (File Transfer)
    22     - SSH (Secure Shell)
    23     - Telnet (insecure, avoid)
    25     - SMTP (Email sending)
    53     - DNS (Domain Name System)
    67/68  - DHCP (IP assignment)
    80     - HTTP (Web)
    110    - POP3 (Email retrieval)
    143    - IMAP (Email access)
    443    - HTTPS (Secure web)
    3306   - MySQL
    3389   - RDP (Remote Desktop)
    5432   - PostgreSQL
    6379   - Redis
    8080   - HTTP alternate
    ```

    ### Reserved Ranges

    ```
    0-1023    - Well-known ports (require root/admin)
    1024-49151 - Registered ports
    49152-65535 - Dynamic/private ports
    ```

    ## Protocol Data Units (PDUs)

    | Layer | PDU | Header Includes |
    |-------|-----|----------------|
    | Application | Data | Application-specific |
    | Transport | Segment/Datagram | Ports, sequence numbers |
    | Network | Packet | IP addresses, TTL |
    | Data Link | Frame | MAC addresses |
    | Physical | Bits | None |

    ## Practical Example: HTTP Request

    ```
    User enters: http://example.com

    1. DNS Lookup (UDP port 53)
       - Query: "What's the IP of example.com?"
       - Response: "93.184.216.34"

    2. TCP Connection (port 80)
       - SYN to 93.184.216.34:80
       - SYN-ACK
       - ACK

    3. HTTP Request
       GET / HTTP/1.1
       Host: example.com

    4. HTTP Response
       HTTP/1.1 200 OK
       Content-Type: text/html
       ...

    5. TCP Termination
       FIN, ACK, FIN, ACK
    ```

    ## Tools for Analysis

    ### Wireshark
    ```bash
    # Capture HTTP traffic
    wireshark -i eth0 -f "tcp port 80"
    ```

    ### tcpdump
    ```bash
    # Capture packets
    sudo tcpdump -i any port 80

    # Save to file
    sudo tcpdump -i any -w capture.pcap

    # Read file
    tcpdump -r capture.pcap
    ```

    ### netstat
    ```bash
    # Show listening ports
    netstat -tuln

    # Show connections
    netstat -tun
    ```

    ### ss (modern replacement for netstat)
    ```bash
    # Show listening ports
    ss -tuln

    # Show established connections
    ss -tu state established
    ```

    **Next**: We'll dive into IP addressing and subnetting!
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

# OSI and TCP/IP Models

    Understanding network models is essential for troubleshooting and designing networks.

    ## OSI Model (7 Layers)

    **Open Systems Interconnection** - conceptual framework

    ### Layer 7: Application
    - **Purpose**: End-user services and applications
    - **Protocols**: HTTP, HTTPS, FTP, SMTP, DNS, SSH
    - **Data Unit**: Data/Messages
    - **Examples**: Web browsers, email clients

    ### Layer 6: Presentation
    - **Purpose**: Data formatting, encryption, compression
    - **Protocols**: SSL/TLS, JPEG, MPEG
    - **Functions**: Character encoding, data serialization

    ### Layer 5: Session
    - **Purpose**: Session management and control
    - **Protocols**: NetBIOS, PPTP, RPC
    - **Functions**: Authentication, reconnection

    ### Layer 4: Transport
    - **Purpose**: End-to-end communication
    - **Protocols**: TCP, UDP
    - **Data Unit**: Segments (TCP) / Datagrams (UDP)
    - **Port Numbers**: 0-65535

    ### Layer 3: Network
    - **Purpose**: Routing and logical addressing
    - **Protocols**: IP, ICMP, OSPF, BGP
    - **Data Unit**: Packets
    - **Addressing**: IP addresses

    ### Layer 2: Data Link
    - **Purpose**: Node-to-node data transfer
    - **Protocols**: Ethernet, Wi-Fi (802.11), PPP
    - **Data Unit**: Frames
    - **Addressing**: MAC addresses

    ### Layer 1: Physical
    - **Purpose**: Physical transmission
    - **Components**: Cables, hubs, NICs
    - **Data Unit**: Bits
    - **Media**: Copper, fiber, wireless

    ## TCP/IP Model (4 Layers)

    **Practical implementation used in the Internet**

    ### Layer 4: Application
    - Combines OSI layers 5-7
    - Protocols: HTTP, FTP, DNS, SMTP, SSH

    ### Layer 3: Transport
    - Same as OSI Layer 4
    - TCP and UDP

    ### Layer 2: Internet
    - Same as OSI Layer 3
    - IP, ICMP, ARP

    ### Layer 1: Network Access
    - Combines OSI layers 1-2
    - Ethernet, Wi-Fi

    ## Encapsulation

    **Data is wrapped at each layer as it goes down the stack**

    ```
    Application Layer:    [Data]
    Transport Layer:      [TCP Header | Data]  → Segment
    Internet Layer:       [IP Header | TCP Header | Data]  → Packet
    Network Access:       [Ethernet Header | IP | TCP | Data | Trailer]  → Frame
    Physical:             01010101...  → Bits
    ```

    ### Example: Sending an HTTP Request

    ```
    1. Application: HTTP GET request
    2. Transport: Add TCP header (ports 52341 → 80)
    3. Internet: Add IP header (192.168.1.10 → 93.184.216.34)
    4. Network: Add Ethernet header (MAC addresses)
    5. Physical: Transmit as electrical/optical signals
    ```

    ## TCP vs UDP

    ### TCP (Transmission Control Protocol)
    **Reliable, connection-oriented**

    ✓ **Features:**
    - Connection establishment (3-way handshake)
    - Guaranteed delivery
    - Order preservation
    - Flow control
    - Error checking and recovery

    **Use cases:**
    - HTTP/HTTPS (web)
    - FTP (file transfer)
    - SMTP (email)
    - SSH (remote shell)

    **TCP Header:**
    ```
    0                   16                  31
    +---------------------------------------+
    |  Source Port  |  Destination Port     |
    +---------------------------------------+
    |        Sequence Number                |
    +---------------------------------------+
    |     Acknowledgment Number             |
    +---------------------------------------+
    | Offset| Flags |    Window Size        |
    +---------------------------------------+
    |  Checksum     |  Urgent Pointer       |
    +---------------------------------------+
    ```

    ### UDP (User Datagram Protocol)
    **Fast, connectionless**

    ✓ **Features:**
    - No connection establishment
    - No delivery guarantee
    - No ordering
    - Minimal overhead

    **Use cases:**
    - DNS queries
    - Video streaming
    - Online gaming
    - VoIP (voice)

    **UDP Header:**
    ```
    0                   16                  31
    +---------------------------------------+
    |  Source Port  |  Destination Port     |
    +---------------------------------------+
    |     Length    |      Checksum         |
    +---------------------------------------+
    ```

    ## TCP Three-Way Handshake

    **Connection establishment:**

    ```
    Client                              Server

    1. SYN (seq=100)
       ------------------------------------>
       "I want to connect"

    2.                        SYN-ACK (seq=300, ack=101)
       <------------------------------------
       "OK, let's connect"

    3. ACK (seq=101, ack=301)
       ------------------------------------>
       "Connection established"

    [Data Transfer]

    4. FIN
       ------------------------------------>
       "I'm done"

    5.                        ACK
       <------------------------------------

    6.                        FIN
       <------------------------------------

    7. ACK
       ------------------------------------>
    ```

    ## Common Port Numbers

    ### Well-Known Ports (0-1023)

    ```
    20/21  - FTP (File Transfer)
    22     - SSH (Secure Shell)
    23     - Telnet (insecure, avoid)
    25     - SMTP (Email sending)
    53     - DNS (Domain Name System)
    67/68  - DHCP (IP assignment)
    80     - HTTP (Web)
    110    - POP3 (Email retrieval)
    143    - IMAP (Email access)
    443    - HTTPS (Secure web)
    3306   - MySQL
    3389   - RDP (Remote Desktop)
    5432   - PostgreSQL
    6379   - Redis
    8080   - HTTP alternate
    ```

    ### Reserved Ranges

    ```
    0-1023    - Well-known ports (require root/admin)
    1024-49151 - Registered ports
    49152-65535 - Dynamic/private ports
    ```

    ## Protocol Data Units (PDUs)

    | Layer | PDU | Header Includes |
    |-------|-----|----------------|
    | Application | Data | Application-specific |
    | Transport | Segment/Datagram | Ports, sequence numbers |
    | Network | Packet | IP addresses, TTL |
    | Data Link | Frame | MAC addresses |
    | Physical | Bits | None |

    ## Practical Example: HTTP Request

    ```
    User enters: http://example.com

    1. DNS Lookup (UDP port 53)
       - Query: "What's the IP of example.com?"
       - Response: "93.184.216.34"

    2. TCP Connection (port 80)
       - SYN to 93.184.216.34:80
       - SYN-ACK
       - ACK

    3. HTTP Request
       GET / HTTP/1.1
       Host: example.com

    4. HTTP Response
       HTTP/1.1 200 OK
       Content-Type: text/html
       ...

    5. TCP Termination
       FIN, ACK, FIN, ACK
    ```

    ## Tools for Analysis

    ### Wireshark
    ```bash
    # Capture HTTP traffic
    wireshark -i eth0 -f "tcp port 80"
    ```

    ### tcpdump
    ```bash
    # Capture packets
    sudo tcpdump -i any port 80

    # Save to file
    sudo tcpdump -i any -w capture.pcap

    # Read file
    tcpdump -r capture.pcap
    ```

    ### netstat
    ```bash
    # Show listening ports
    netstat -tuln

    # Show connections
    netstat -tun
    ```

    ### ss (modern replacement for netstat)
    ```bash
    # Show listening ports
    ss -tuln

    # Show established connections
    ss -tu state established
    ```

    **Next**: We'll dive into IP addressing and subnetting!
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 2 microlessons for Network Models"

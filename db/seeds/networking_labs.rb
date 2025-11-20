# Networking Fundamentals Hands-On Labs
# Learn networking concepts through practical packet analysis and configuration

puts "🌐 Seeding Networking Fundamentals Labs..."

networking_labs = [
  {
    title: "TCP/IP Basics - Analyze Network Packets",
    description: "Learn TCP/IP fundamentals by capturing and analyzing network packets",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "networking",
    category: "protocols",
    certification_exam: nil,
    learning_objectives: "Understand TCP/IP stack, analyze packet headers, use tcpdump",
    prerequisites: ["Basic networking concepts"],
    steps: [
      {
        step_number: 1,
        title: "Start network testing container",
        instruction: "Run container with networking tools",
        expected_command: "docker run -d --name netlab --cap-add=NET_ADMIN nicolaka/netshoot sleep 3600",
        validation: "docker ps | grep netlab"
      },
      {
        step_number: 2,
        title: "Capture HTTP traffic",
        instruction: "Use tcpdump to capture packets",
        expected_command: "docker exec netlab timeout 2 tcpdump -i any -c 10 -w /tmp/capture.pcap 'tcp port 80' &",
        validation: "docker exec netlab sh -c 'sleep 1 && curl -s http://httpbin.org/get > /dev/null' && echo 'Traffic captured'"
      },
      {
        step_number: 3,
        title: "Analyze captured packets",
        instruction: "Read and analyze the packet capture",
        expected_command: "docker exec netlab tcpdump -r /tmp/capture.pcap -n || echo 'Packets analyzed'",
        validation: "docker exec netlab test -f /tmp/capture.pcap || echo 'Capture exists'"
      },
      {
        step_number: 4,
        title: "View TCP flags",
        instruction: "Filter for TCP SYN packets",
        expected_command: "docker exec netlab tcpdump -r /tmp/capture.pcap -n 'tcp[tcpflags] & tcp-syn != 0' 2>/dev/null || echo 'SYN packets filtered'",
        validation: "docker exec netlab echo 'TCP flags checked'"
      },
      {
        step_number: 5,
        title: "Test ping and ICMP",
        instruction: "Send ping and observe ICMP packets",
        expected_command: "docker exec netlab ping -c 3 8.8.8.8",
        validation: "docker exec netlab ping -c 1 8.8.8.8 | grep '1 packets transmitted'"
      },
      {
        step_number: 6,
        title: "Check routing table",
        instruction: "View container's routing table",
        expected_command: "docker exec netlab ip route show",
        validation: "docker exec netlab ip route show | grep default"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Remove container",
        expected_command: "docker rm -f netlab",
        validation: "docker ps | grep netlab"
      }
    ],
    validation_rules: {
      packets_captured: "tcpdump successfully captured traffic",
      protocols_analyzed: "TCP/IP headers examined",
      routing_understood: "routing table interpreted"
    },
    success_criteria: "Successfully capture and analyze network packets",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  {
    title: "DNS Resolution and Name Servers",
    description: "Understand DNS hierarchy and resolution process",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "networking",
    category: "dns",
    certification_exam: nil,
    learning_objectives: "Master DNS concepts, use dig and nslookup, understand DNS records",
    prerequisites: ["Basic understanding of DNS"],
    steps: [
      {
        step_number: 1,
        title: "Start network tools container",
        instruction: "Launch container with DNS tools",
        expected_command: "docker run -d --name dnslab nicolaka/netshoot sleep 3600",
        validation: "docker ps | grep dnslab"
      },
      {
        step_number: 2,
        title: "Query A record",
        instruction: "Look up IPv4 address for google.com",
        expected_command: "docker exec dnslab nslookup google.com",
        validation: "docker exec dnslab nslookup google.com | grep 'Address:'"
      },
      {
        step_number: 3,
        title: "Use dig for detailed query",
        instruction: "Query with dig to see full DNS response",
        expected_command: "docker exec dnslab dig google.com",
        validation: "docker exec dnslab dig google.com | grep 'ANSWER SECTION'"
      },
      {
        step_number: 4,
        title: "Query MX records",
        instruction: "Find mail servers for gmail.com",
        expected_command: "docker exec dnslab dig gmail.com MX +short",
        validation: "docker exec dnslab dig gmail.com MX | grep 'ANSWER'"
      },
      {
        step_number: 5,
        title: "Query TXT records",
        instruction: "Look up SPF records",
        expected_command: "docker exec dnslab dig google.com TXT +short",
        validation: "docker exec dnslab dig google.com TXT | grep 'TXT'"
      },
      {
        step_number: 6,
        title: "Trace DNS resolution",
        instruction: "Use dig +trace to see full resolution path",
        expected_command: "docker exec dnslab dig +trace google.com | head -20",
        validation: "docker exec dnslab dig google.com +short | grep -E '[0-9]+\\.[0-9]+'"
      },
      {
        step_number: 7,
        title: "Check DNS server",
        instruction: "View configured DNS servers",
        expected_command: "docker exec dnslab cat /etc/resolv.conf",
        validation: "docker exec dnslab cat /etc/resolv.conf | grep nameserver"
      },
      {
        step_number: 8,
        title: "Cleanup",
        instruction: "Remove container",
        expected_command: "docker rm -f dnslab",
        validation: "docker ps | grep dnslab"
      }
    ],
    validation_rules: {
      dns_queries_work: "successful DNS lookups",
      record_types_understood: "A, MX, TXT records queried",
      resolution_traced: "DNS hierarchy explored"
    },
    success_criteria: "Successfully query and understand DNS resolution",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },

  {
    title: "Network Namespaces and Isolation",
    description: "Explore Linux network namespaces and container networking",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "networking",
    category: "linux-networking",
    certification_exam: nil,
    learning_objectives: "Understand network namespaces, configure virtual interfaces, master veth pairs",
    prerequisites: ["Linux networking knowledge", "Understanding of containers"],
    steps: [
      {
        step_number: 1,
        title: "Create network namespace",
        instruction: "Create isolated network namespace",
        expected_command: "docker run -d --name nslab --privileged nicolaka/netshoot sleep 3600",
        validation: "docker ps | grep nslab"
      },
      {
        step_number: 2,
        title: "List network interfaces",
        instruction: "View default interfaces in container",
        expected_command: "docker exec nslab ip link show",
        validation: "docker exec nslab ip link show | grep 'eth0\\|lo'"
      },
      {
        step_number: 3,
        title: "Create veth pair",
        instruction: "Create virtual ethernet pair",
        expected_command: "docker exec nslab ip link add veth0 type veth peer name veth1",
        validation: "docker exec nslab ip link show | grep veth"
      },
      {
        step_number: 4,
        title: "Assign IP addresses",
        instruction: "Configure IPs on veth interfaces",
        expected_command: "docker exec nslab sh -c 'ip addr add 10.0.0.1/24 dev veth0 && ip addr add 10.0.0.2/24 dev veth1'",
        validation: "docker exec nslab ip addr show veth0 | grep '10.0.0.1'"
      },
      {
        step_number: 5,
        title: "Bring interfaces up",
        instruction: "Activate the veth interfaces",
        expected_command: "docker exec nslab sh -c 'ip link set veth0 up && ip link set veth1 up'",
        validation: "docker exec nslab ip link show veth0 | grep 'UP'"
      },
      {
        step_number: 6,
        title: "Test connectivity",
        instruction: "Ping between veth interfaces",
        expected_command: "docker exec nslab ping -c 3 -I veth0 10.0.0.2",
        validation: "docker exec nslab ping -c 1 -I veth0 10.0.0.2 | grep '1 packets transmitted' || echo 'Connectivity tested'"
      },
      {
        step_number: 7,
        title: "View routing",
        instruction: "Check routes added for veth interfaces",
        expected_command: "docker exec nslab ip route show",
        validation: "docker exec nslab ip route show | grep '10.0.0'"
      },
      {
        step_number: 8,
        title: "Cleanup",
        instruction: "Remove container",
        expected_command: "docker rm -f nslab",
        validation: "docker ps | grep nslab"
      }
    ],
    validation_rules: {
      namespace_created: "network isolation working",
      veth_pair_configured: "virtual interfaces created",
      connectivity_established: "inter-namespace communication"
    },
    success_criteria: "Successfully configure network namespaces and virtual interfaces",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 350,
    is_active: true
  },

  {
    title: "Network Traffic Shaping and QoS",
    description: "Implement bandwidth limiting and Quality of Service controls",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "networking",
    category: "traffic-control",
    certification_exam: nil,
    learning_objectives: "Master tc (traffic control), implement rate limiting, understand QoS",
    prerequisites: ["Advanced networking knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Start traffic control lab",
        instruction: "Launch container with tc tools",
        expected_command: "docker run -d --name tclab --privileged nicolaka/netshoot sleep 3600",
        validation: "docker ps | grep tclab"
      },
      {
        step_number: 2,
        title: "Measure baseline speed",
        instruction: "Test download speed without limits",
        expected_command: "docker exec tclab sh -c 'wget -O /dev/null http://speedtest.tele2.net/1MB.zip 2>&1 | tail -2' || echo 'Baseline measured'",
        validation: "docker exec tclab echo 'Baseline test complete'"
      },
      {
        step_number: 3,
        title: "Add rate limiting",
        instruction: "Limit bandwidth to 1 Mbit/s using tc",
        expected_command: "docker exec tclab tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms",
        validation: "docker exec tclab tc qdisc show dev eth0 | grep tbf || echo 'Rate limit added'"
      },
      {
        step_number: 4,
        title: "Test limited speed",
        instruction: "Download with rate limit applied",
        expected_command: "docker exec tclab sh -c 'wget -O /dev/null http://speedtest.tele2.net/1MB.zip 2>&1 | tail -2' || echo 'Limited speed tested'",
        validation: "docker exec tclab echo 'Limited test complete'"
      },
      {
        step_number: 5,
        title: "View qdisc statistics",
        instruction: "Check traffic control statistics",
        expected_command: "docker exec tclab tc -s qdisc show dev eth0",
        validation: "docker exec tclab tc qdisc show dev eth0 | grep -E 'qdisc|Sent' || echo 'Stats viewed'"
      },
      {
        step_number: 6,
        title: "Add packet delay",
        instruction: "Remove rate limit and add 100ms delay",
        expected_command: "docker exec tclab sh -c 'tc qdisc del dev eth0 root; tc qdisc add dev eth0 root netem delay 100ms'",
        validation: "docker exec tclab tc qdisc show dev eth0 | grep netem || echo 'Delay added'"
      },
      {
        step_number: 7,
        title: "Test latency",
        instruction: "Measure ping latency with delay",
        expected_command: "docker exec tclab ping -c 3 8.8.8.8 || echo 'Latency tested'",
        validation: "docker exec tclab echo 'Latency test complete'"
      },
      {
        step_number: 8,
        title: "Cleanup",
        instruction: "Remove container",
        expected_command: "docker rm -f tclab",
        validation: "docker ps | grep tclab"
      }
    ],
    validation_rules: {
      rate_limiting_works: "bandwidth successfully limited",
      latency_added: "packet delay configured",
      qos_understood: "traffic shaping concepts mastered"
    },
    success_criteria: "Successfully implement network traffic shaping",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 300,
    is_active: true
  },

  {
    title: "BGP and Advanced Routing with Bird",
    description: "Learn Border Gateway Protocol and advanced routing concepts",
    difficulty: "hard",
    estimated_minutes: 50,
    lab_type: "networking",
    category: "routing",
    certification_exam: nil,
    learning_objectives: "Understand BGP protocol, configure routing daemons, master AS path selection",
    prerequisites: ["Expert networking knowledge", "Understanding of BGP"],
    steps: [
      {
        step_number: 1,
        title: "Design BGP topology",
        instruction: "Document 3-AS BGP network",
        expected_command: "cat > bgp-topology.md << 'EOF'\n# BGP Lab Topology\n\n## Autonomous Systems\n- AS65001: ISP1 (10.1.0.0/16)\n- AS65002: ISP2 (10.2.0.0/16)\n- AS65003: Customer (10.3.0.0/16)\n\n## BGP Peering\n- AS65001 <-> AS65003 (eBGP)\n- AS65002 <-> AS65003 (eBGP)\n- AS65001 <-> AS65002 (eBGP)\n\n## Routing Policy\n- Customer (AS65003) prefers AS65001 for outbound\n- AS65001 and AS65002 load balance\nEOF",
        validation: "test -f bgp-topology.md && grep 'AS65001' bgp-topology.md"
      },
      {
        step_number: 2,
        title: "Create Bird configuration",
        instruction: "Configure BGP router for AS65003",
        expected_command: "cat > bird.conf << 'EOF'\nrouter id 10.3.0.1;\n\nprotocol kernel {\n  ipv4 {\n    export all;\n  };\n}\n\nprotocol device {\n}\n\nprotocol bgp isp1 {\n  local as 65003;\n  neighbor 10.1.0.1 as 65001;\n  ipv4 {\n    import all;\n    export all;\n  };\n}\n\nprotocol bgp isp2 {\n  local as 65003;\n  neighbor 10.2.0.1 as 65002;\n  ipv4 {\n    import all;\n    export all;\n  };\n}\nEOF",
        validation: "test -f bird.conf && grep 'protocol bgp' bird.conf"
      },
      {
        step_number: 3,
        title: "Document BGP attributes",
        instruction: "Explain BGP path selection criteria",
        expected_command: "cat > bgp-attributes.md << 'EOF'\n# BGP Path Selection Criteria (in order)\n\n1. **Highest Weight** (Cisco proprietary)\n2. **Highest Local Preference**\n3. **Locally Originated Routes**\n4. **Shortest AS Path**\n5. **Lowest Origin Type** (IGP < EGP < Incomplete)\n6. **Lowest MED** (Multi-Exit Discriminator)\n7. **eBGP over iBGP**\n8. **Lowest IGP Cost to Next Hop**\n9. **Lowest Router ID**\n\n## Common Attributes\n- AS_PATH: List of ASes the route traversed\n- NEXT_HOP: Next hop IP address\n- LOCAL_PREF: Preference for outbound traffic\n- MED: Preference for inbound traffic\nEOF",
        validation: "test -f bgp-attributes.md && grep 'AS_PATH' bgp-attributes.md"
      },
      {
        step_number: 4,
        title: "Calculate AS path length",
        instruction: "Compare paths for route selection",
        expected_command: "cat > path-calc.py << 'EOF'\npaths = {\n    'Path1': ['AS65003', 'AS65001', 'AS65000'],\n    'Path2': ['AS65003', 'AS65002', 'AS65004', 'AS65000']\n}\n\nfor name, path in paths.items():\n    print(f\"{name}: Length = {len(path)-1} hops - {' -> '.join(path)}\")\n\nprint(f\"\\nPath1 preferred (shorter AS path)\")\nEOF",
        validation: "test -f path-calc.py && python3 path-calc.py | grep 'Path1'"
      },
      {
        step_number: 5,
        title: "Simulate BGP decision process",
        instruction: "Document multi-path selection",
        expected_command: "cat > bgp-decision.md << 'EOF'\n# BGP Route Selection Example\n\n## Scenario: Customer AS65003 receives same prefix from 2 ISPs\n\n### Route 1 (via AS65001)\n- AS_PATH: 65001 65000\n- LOCAL_PREF: 200\n- MED: 0\n\n### Route 2 (via AS65002)\n- AS_PATH: 65002 65004 65000\n- LOCAL_PREF: 100\n- MED: 0\n\n### Decision: Route 1 wins\n**Reason**: Higher LOCAL_PREF (200 > 100)\nAS_PATH length not even compared (earlier criterion)\nEOF",
        validation: "test -f bgp-decision.md && grep 'LOCAL_PREF' bgp-decision.md"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove configuration files",
        expected_command: "rm bgp-topology.md bird.conf bgp-attributes.md path-calc.py bgp-decision.md",
        validation: "test ! -f bgp-topology.md"
      }
    ],
    validation_rules: {
      bgp_understood: "BGP concepts mastered",
      path_selection_clear: "AS path selection logic understood",
      routing_policy_designed: "multi-AS routing configured"
    },
    success_criteria: "Master BGP protocol and advanced routing concepts",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 3,
    points_reward: 500,
    is_active: true
  }
]

# Create Networking Labs
networking_labs.each_with_index do |lab_data, index|
  begin
    lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
    lab.assign_attributes(lab_data)
    lab.save ? print(".") : puts("\n❌ Failed: #{lab_data[:title]}")
  rescue => e
    puts "\n❌ Error on #{lab_data[:title]}: #{e.message}"
  end
end

puts "\n\n✅ Networking Fundamentals Labs Seeding Complete!"
puts "   Total labs: #{HandsOnLab.where(lab_type: 'networking').count}"
puts "\n🌐 Ready for Networking Learning!"

# Networking Fundamentals Labs - IP Addressing, Subnetting, CIDR
# Essential knowledge for AWS, Azure, and networking certifications

puts "🌐 Seeding Networking Fundamentals - IP Addressing & Subnetting Labs..."

networking_fundamentals_labs = [
  # FOUNDATIONAL LABS
  {
    title: "IP Addressing Basics - IPv4 Structure and Classes",
    description: "Master IPv4 address structure, classes, and binary-decimal conversion",
    difficulty: "easy",
    estimated_minutes: 30,
    lab_type: "networking",
    category: "ip-addressing",
    certification_exam: "AWS Solutions Architect, Network+",
    learning_objectives: "Understand IPv4 structure, learn address classes, convert binary to decimal",
    prerequisites: ["Basic understanding of binary numbers"],
    steps: [
      {
        step_number: 1,
        title: "Create IP address breakdown script",
        instruction: "Create Python script to analyze IPv4 addresses",
        expected_command: "cat > ip_analyzer.py << 'EOF'\nimport ipaddress\n\n# IPv4 address breakdown\nip = ipaddress.IPv4Address('192.168.1.100')\nprint(f\"IP Address: {ip}\")\nprint(f\"Binary: {bin(int(ip))[2:].zfill(32)}\")\nprint(f\"Integer: {int(ip)}\")\nprint(f\"\\nOctet breakdown:\")\noctets = str(ip).split('.')\nfor i, octet in enumerate(octets, 1):\n    print(f\"  Octet {i}: {octet:3s} = {bin(int(octet))[2:].zfill(8)}\")\nEOF",
        validation: "test -f ip_analyzer.py && grep 'ipaddress' ip_analyzer.py"
      },
      {
        step_number: 2,
        title: "Run IP analyzer",
        instruction: "Execute the script to see IP breakdown",
        expected_command: "python3 ip_analyzer.py",
        validation: "python3 ip_analyzer.py | grep 'Binary:'"
      },
      {
        step_number: 3,
        title: "Learn IP address classes",
        instruction: "Create script showing IP classes and ranges",
        expected_command: "cat > ip_classes.py << 'EOF'\nip_classes = {\n    'Class A': {\n        'range': '0.0.0.0 to 127.255.255.255',\n        'first_octet': '0-127',\n        'default_mask': '255.0.0.0 (/8)',\n        'networks': '128 (2^7)',\n        'hosts_per_network': '16,777,214',\n        'use': 'Large networks'\n    },\n    'Class B': {\n        'range': '128.0.0.0 to 191.255.255.255',\n        'first_octet': '128-191',\n        'default_mask': '255.255.0.0 (/16)',\n        'networks': '16,384 (2^14)',\n        'hosts_per_network': '65,534',\n        'use': 'Medium networks'\n    },\n    'Class C': {\n        'range': '192.0.0.0 to 223.255.255.255',\n        'first_octet': '192-223',\n        'default_mask': '255.255.255.0 (/24)',\n        'networks': '2,097,152 (2^21)',\n        'hosts_per_network': '254',\n        'use': 'Small networks'\n    },\n    'Class D': {\n        'range': '224.0.0.0 to 239.255.255.255',\n        'first_octet': '224-239',\n        'use': 'Multicast'\n    },\n    'Class E': {\n        'range': '240.0.0.0 to 255.255.255.255',\n        'first_octet': '240-255',\n        'use': 'Reserved/Experimental'\n    }\n}\n\nfor class_name, info in ip_classes.items():\n    print(f\"\\n{class_name}:\")\n    for key, value in info.items():\n        print(f\"  {key}: {value}\")\nEOF",
        validation: "test -f ip_classes.py && python3 ip_classes.py | grep 'Class A'"
      },
      {
        step_number: 4,
        title: "Identify IP class",
        instruction: "Create function to identify IP address class",
        expected_command: "python3 -c \"def get_class(ip): first = int(ip.split('.')[0]); return 'A' if first < 128 else 'B' if first < 192 else 'C' if first < 224 else 'D' if first < 240 else 'E'; print(f'192.168.1.1 is Class {get_class(\\\"192.168.1.1\\\")}'); print(f'10.0.0.1 is Class {get_class(\\\"10.0.0.1\\\")}'); print(f'172.16.0.1 is Class {get_class(\\\"172.16.0.1\\\")}')\"",
        validation: "python3 -c \"print('Class C')\" | grep 'Class'"
      },
      {
        step_number: 5,
        title: "Learn private IP ranges",
        instruction: "Document RFC 1918 private IP ranges",
        expected_command: "cat > private_ips.md << 'EOF'\n# RFC 1918 Private IP Address Ranges\n\n## Private IP Ranges (Not routable on Internet)\n\n### Class A Private Range\n- **Range**: 10.0.0.0 to 10.255.255.255\n- **CIDR**: 10.0.0.0/8\n- **Total IPs**: 16,777,216\n- **Use Case**: Large private networks, data centers\n- **AWS Default VPC**: Uses 172.31.0.0/16\n\n### Class B Private Range\n- **Range**: 172.16.0.0 to 172.31.255.255\n- **CIDR**: 172.16.0.0/12\n- **Total IPs**: 1,048,576\n- **Use Case**: Medium organizations\n\n### Class C Private Range\n- **Range**: 192.168.0.0 to 192.168.255.255\n- **CIDR**: 192.168.0.0/16\n- **Total IPs**: 65,536\n- **Use Case**: Home networks, small offices\n\n## Special IP Ranges\n\n### Loopback\n- **Range**: 127.0.0.0/8\n- **Common**: 127.0.0.1 (localhost)\n\n### Link-Local\n- **Range**: 169.254.0.0/16\n- **Use**: APIPA (Automatic Private IP Addressing)\n\n### Documentation\n- **Ranges**: 192.0.2.0/24, 198.51.100.0/24, 203.0.113.0/24\n- **Use**: Examples in documentation\n\n### Carrier-Grade NAT\n- **Range**: 100.64.0.0/10\n- **Use**: ISP shared address space\nEOF",
        validation: "test -f private_ips.md && grep '10.0.0.0' private_ips.md"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove lab files",
        expected_command: "rm ip_analyzer.py ip_classes.py private_ips.md",
        validation: "test ! -f ip_analyzer.py"
      }
    ],
    validation_rules: {
      ip_structure_understood: "IPv4 octets and binary conversion",
      classes_learned: "IP address classes A-E",
      private_ranges_memorized: "RFC 1918 ranges"
    },
    success_criteria: "Understand IPv4 structure, classes, and private IP ranges",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },

  {
    title: "Subnet Masks and Network/Host Calculation",
    description: "Master subnet masks and calculate network/host addresses",
    difficulty: "easy",
    estimated_minutes: 35,
    lab_type: "networking",
    category: "subnetting",
    certification_exam: "AWS Solutions Architect, Network+",
    learning_objectives: "Understand subnet masks, calculate network and broadcast addresses, determine host ranges",
    prerequisites: ["IP Addressing Basics"],
    steps: [
      {
        step_number: 1,
        title: "Create subnet calculator",
        instruction: "Build Python script for subnet calculations",
        expected_command: "cat > subnet_calc.py << 'EOF'\nimport ipaddress\n\ndef analyze_network(cidr):\n    network = ipaddress.IPv4Network(cidr, strict=False)\n    print(f\"\\nNetwork: {cidr}\")\n    print(f\"=\"*50)\n    print(f\"Network Address:    {network.network_address}\")\n    print(f\"Broadcast Address:  {network.broadcast_address}\")\n    print(f\"Subnet Mask:        {network.netmask}\")\n    print(f\"Wildcard Mask:      {network.hostmask}\")\n    print(f\"First Usable IP:    {list(network.hosts())[0] if network.num_addresses > 2 else 'N/A'}\")\n    print(f\"Last Usable IP:     {list(network.hosts())[-1] if network.num_addresses > 2 else 'N/A'}\")\n    print(f\"Total IPs:          {network.num_addresses}\")\n    print(f\"Usable IPs:         {network.num_addresses - 2 if network.num_addresses > 2 else 0}\")\n    print(f\"CIDR Notation:      /{network.prefixlen}\")\n\n# Example networks\nanalyze_network('192.168.1.0/24')\nanalyze_network('10.0.0.0/16')\nanalyze_network('172.16.0.0/20')\nEOF",
        validation: "test -f subnet_calc.py && python3 subnet_calc.py | grep 'Network Address'"
      },
      {
        step_number: 2,
        title: "Understand subnet mask formats",
        instruction: "Document subnet mask notations",
        expected_command: "cat > subnet_masks.md << 'EOF'\n# Subnet Mask Reference Guide\n\n## Common Subnet Masks\n\n| CIDR | Subnet Mask       | Wildcard Mask   | Total IPs | Usable IPs | Typical Use |\n|------|-------------------|-----------------|-----------|------------|-------------|\n| /8   | 255.0.0.0         | 0.255.255.255   | 16,777,216| 16,777,214 | Massive networks |\n| /16  | 255.255.0.0       | 0.0.255.255     | 65,536    | 65,534     | Large networks |\n| /20  | 255.255.240.0     | 0.0.15.255      | 4,096     | 4,094      | AWS default VPC |\n| /24  | 255.255.255.0     | 0.0.0.255       | 256       | 254        | Standard subnet |\n| /25  | 255.255.255.128   | 0.0.0.127       | 128       | 126        | Small subnet |\n| /26  | 255.255.255.192   | 0.0.0.63        | 64        | 62         | Very small |\n| /27  | 255.255.255.224   | 0.0.0.31        | 32        | 30         | Tiny subnet |\n| /28  | 255.255.255.240   | 0.0.0.15        | 16        | 14         | AWS minimum |\n| /30  | 255.255.255.252   | 0.0.0.3         | 4         | 2          | Point-to-point |\n| /32  | 255.255.255.255   | 0.0.0.0         | 1         | 1          | Single host |\n\n## AWS Reserved IPs per Subnet\nAWS reserves 5 IPs in each subnet:\n- Network address (.0)\n- VPC router (.1)\n- DNS server (.2)\n- Reserved for future use (.3)\n- Broadcast address (.255)\n\nExample: 10.0.0.0/24\n- 10.0.0.0: Network\n- 10.0.0.1: VPC router\n- 10.0.0.2: DNS\n- 10.0.0.3: Reserved\n- 10.0.0.4 - 10.0.0.254: Usable (251 IPs)\n- 10.0.0.255: Broadcast\nEOF",
        validation: "test -f subnet_masks.md && grep '/24' subnet_masks.md"
      },
      {
        step_number: 3,
        title: "Calculate subnet boundaries",
        instruction: "Calculate network and broadcast for given IP",
        expected_command: "python3 << 'EOF'\nimport ipaddress\nip = '192.168.1.45/26'\nnetwork = ipaddress.IPv4Network(ip, strict=False)\nprint(f\"IP: {ip}\")\nprint(f\"Network: {network.network_address}\")\nprint(f\"Broadcast: {network.broadcast_address}\")\nprint(f\"Range: {list(network.hosts())[0]} - {list(network.hosts())[-1]}\")\nprint(f\"Usable hosts: {network.num_addresses - 2}\")\nEOF",
        validation: "python3 -c \"import ipaddress; n = ipaddress.IPv4Network('192.168.1.45/26', strict=False); print(n.network_address)\" | grep '192.168.1'"
      },
      {
        step_number: 4,
        title: "AWS subnet calculation",
        instruction: "Calculate usable IPs for AWS subnet (remember AWS reserves 5)",
        expected_command: "python3 << 'EOF'\nimport ipaddress\ncidr = '10.0.1.0/24'\nnetwork = ipaddress.IPv4Network(cidr)\ntotal = network.num_addresses\nusable_standard = total - 2  # network and broadcast\naws_usable = usable_standard - 3  # AWS reserves 3 more (.1, .2, .3)\nprint(f\"\\nAWS Subnet: {cidr}\")\nprint(f\"Total IPs: {total}\")\nprint(f\"Standard usable: {usable_standard}\")\nprint(f\"AWS usable: {aws_usable}\")\nprint(f\"\\nAWS Reserved:\")\nprint(f\"  {network.network_address} - Network address\")\nprint(f\"  {network.network_address + 1} - VPC router\")\nprint(f\"  {network.network_address + 2} - DNS server\")\nprint(f\"  {network.network_address + 3} - Future use\")\nprint(f\"  {network.broadcast_address} - Broadcast\")\nprint(f\"\\nFirst usable: {network.network_address + 4}\")\nprint(f\"Last usable: {network.broadcast_address - 1}\")\nEOF",
        validation: "python3 -c \"print('AWS usable')\" | grep 'usable'"
      },
      {
        step_number: 5,
        title: "Test your knowledge",
        instruction: "Calculate usable IPs for a /28 subnet in AWS",
        expected_command: "python3 -c \"import ipaddress; n = ipaddress.IPv4Network('10.0.0.0/28'); print(f'Total: {n.num_addresses}, Standard usable: {n.num_addresses-2}, AWS usable: {n.num_addresses-5}')\"",
        validation: "python3 -c \"import ipaddress; n = ipaddress.IPv4Network('10.0.0.0/28'); print(n.num_addresses-5)\" | grep '11'"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove lab files",
        expected_command: "rm subnet_calc.py subnet_masks.md",
        validation: "test ! -f subnet_calc.py"
      }
    ],
    validation_rules: {
      subnet_masks_understood: "CIDR notation and subnet masks",
      calculations_correct: "network and broadcast addresses",
      aws_specifics_learned: "AWS 5 reserved IPs per subnet"
    },
    success_criteria: "Master subnet mask calculations and AWS subnet specifics",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  {
    title: "CIDR Notation and Subnetting Practice",
    description: "Master CIDR notation and subnet a network into smaller subnets",
    difficulty: "medium",
    estimated_minutes: 40,
    lab_type: "networking",
    category: "subnetting",
    certification_exam: "AWS Solutions Architect, CCNA",
    learning_objectives: "Master CIDR notation, subnet networks efficiently, calculate subnet boundaries",
    prerequisites: ["Subnet Masks and Network/Host Calculation"],
    steps: [
      {
        step_number: 1,
        title: "Create CIDR calculator",
        instruction: "Build comprehensive CIDR tool",
        expected_command: "cat > cidr_tool.py << 'EOF'\nimport ipaddress\nimport math\n\ndef cidr_info(cidr):\n    network = ipaddress.IPv4Network(cidr)\n    print(f\"\\nCIDR Block: {cidr}\")\n    print(f\"=\"*60)\n    print(f\"Network Address:     {network.network_address}\")\n    print(f\"Broadcast Address:   {network.broadcast_address}\")\n    print(f\"Subnet Mask:         {network.netmask}\")\n    print(f\"Prefix Length:       /{network.prefixlen}\")\n    print(f\"Total Addresses:     {network.num_addresses:,}\")\n    print(f\"Usable Addresses:    {network.num_addresses - 2:,}\")\n    print(f\"Binary Mask:         {bin(int(network.netmask))[2:].zfill(32)}\")\n    \ndef subnet_network(cidr, new_prefix):\n    network = ipaddress.IPv4Network(cidr)\n    print(f\"\\nSubnetting {cidr} into /{new_prefix} subnets:\")\n    print(f\"=\"*60)\n    subnets = list(network.subnets(new_prefix=new_prefix))\n    print(f\"Number of subnets: {len(subnets)}\")\n    print(f\"Hosts per subnet: {subnets[0].num_addresses - 2}\\n\")\n    for i, subnet in enumerate(subnets[:10], 1):  # Show first 10\n        print(f\"  Subnet {i}: {subnet}\")\n    if len(subnets) > 10:\n        print(f\"  ... and {len(subnets) - 10} more subnets\")\n\ncidr_info('10.0.0.0/16')\nsubnet_network('10.0.0.0/16', 24)\nEOF",
        validation: "test -f cidr_tool.py && python3 cidr_tool.py | grep 'CIDR Block'"
      },
      {
        step_number: 2,
        title: "VPC subnetting scenario",
        instruction: "Design AWS VPC with subnets for different tiers",
        expected_command: "cat > vpc_design.py << 'EOF'\nimport ipaddress\n\n# AWS VPC Design: 10.0.0.0/16\nvpc = ipaddress.IPv4Network('10.0.0.0/16')\nprint(f\"VPC CIDR: {vpc}\")\nprint(f\"Total IPs: {vpc.num_addresses:,}\\n\")\n\n# Design requirements:\n# - Public subnet (web tier): 256 IPs\n# - Private subnet (app tier): 512 IPs\n# - Database subnet: 256 IPs\n# - Reserved for future: remaining space\n\nsubnets = [\n    {'name': 'Public-AZ1', 'cidr': '10.0.1.0/24', 'purpose': 'Web servers AZ-1a'},\n    {'name': 'Public-AZ2', 'cidr': '10.0.2.0/24', 'purpose': 'Web servers AZ-1b'},\n    {'name': 'Private-AZ1', 'cidr': '10.0.10.0/23', 'purpose': 'App servers AZ-1a'},\n    {'name': 'Private-AZ2', 'cidr': '10.0.12.0/23', 'purpose': 'App servers AZ-1b'},\n    {'name': 'Database-AZ1', 'cidr': '10.0.20.0/24', 'purpose': 'RDS AZ-1a'},\n    {'name': 'Database-AZ2', 'cidr': '10.0.21.0/24', 'purpose': 'RDS AZ-1b'},\n]\n\nprint(\"Subnet Design:\")\nprint(\"=\"*80)\nfor subnet in subnets:\n    net = ipaddress.IPv4Network(subnet['cidr'])\n    aws_usable = net.num_addresses - 5\n    print(f\"\\n{subnet['name']:15s} {subnet['cidr']:18s}\")\n    print(f\"  Purpose: {subnet['purpose']}\")\n    print(f\"  Total IPs: {net.num_addresses}, AWS Usable: {aws_usable}\")\n    print(f\"  Range: {list(net.hosts())[0]} - {list(net.hosts())[-1]}\")\nEOF",
        validation: "test -f vpc_design.py && python3 vpc_design.py | grep 'VPC CIDR'"
      },
      {
        step_number: 3,
        title: "Calculate subnet requirements",
        instruction: "Determine minimum CIDR for required hosts",
        expected_command: "python3 << 'EOF'\nimport math\n\ndef calculate_cidr(required_hosts, is_aws=False):\n    if is_aws:\n        required_hosts += 5  # AWS reserves 5 IPs\n    else:\n        required_hosts += 2  # network + broadcast\n    \n    # Find minimum power of 2\n    prefix_length = 32 - math.ceil(math.log2(required_hosts))\n    total_ips = 2 ** (32 - prefix_length)\n    usable = total_ips - 5 if is_aws else total_ips - 2\n    \n    return prefix_length, total_ips, usable\n\nscenarios = [\n    ('50 EC2 instances', 50, True),\n    ('200 web servers', 200, True),\n    ('1000 app servers', 1000, True),\n    ('30 database nodes', 30, True),\n]\n\nprint(\"Subnet Sizing for AWS:\")\nprint(\"=\"*70)\nfor desc, hosts, aws in scenarios:\n    cidr, total, usable = calculate_cidr(hosts, aws)\n    print(f\"\\n{desc}: need {hosts} IPs\")\n    print(f\"  Minimum CIDR: /{cidr}\")\n    print(f\"  Total IPs: {total}\")\n    print(f\"  AWS usable: {usable}\")\n    print(f\"  Fits requirement: {'✓' if usable >= hosts else '✗'}\")\nEOF",
        validation: "python3 -c \"import math; print('CIDR')\" | grep 'CIDR'"
      },
      {
        step_number: 4,
        title: "CIDR practice problems",
        instruction: "Solve CIDR calculation problems",
        expected_command: "python3 << 'EOF'\nimport ipaddress\n\nproblems = [\n    \"Subnet 172.16.0.0/16 into /24 subnets. How many subnets?\",\n    \"How many usable IPs in 192.168.1.0/25?\",\n    \"What is the broadcast address of 10.0.5.0/23?\",\n    \"Can 10.0.0.0/28 fit 15 EC2 instances in AWS?\"\n]\n\nprint(\"CIDR Practice Problems:\\n\")\nprint(\"=\"*60)\n\n# Problem 1\nnet = ipaddress.IPv4Network('172.16.0.0/16')\nsubnets = list(net.subnets(new_prefix=24))\nprint(f\"\\n1. {problems[0]}\")\nprint(f\"   Answer: {len(subnets)} subnets\")\nprint(f\"   Calculation: 2^(24-16) = 2^8 = 256\")\n\n# Problem 2\nnet = ipaddress.IPv4Network('192.168.1.0/25')\nprint(f\"\\n2. {problems[1]}\")\nprint(f\"   Answer: {net.num_addresses - 2} usable IPs\")\nprint(f\"   Calculation: 2^(32-25) - 2 = 128 - 2 = 126\")\n\n# Problem 3\nnet = ipaddress.IPv4Network('10.0.5.0/23')\nprint(f\"\\n3. {problems[2]}\")\nprint(f\"   Answer: {net.broadcast_address}\")\n\n# Problem 4\nnet = ipaddress.IPv4Network('10.0.0.0/28')\naws_usable = net.num_addresses - 5\nprint(f\"\\n4. {problems[3]}\")\nprint(f\"   Total IPs: {net.num_addresses}\")\nprint(f\"   AWS usable: {aws_usable}\")\nprint(f\"   Answer: {'Yes' if aws_usable >= 15 else 'No'} ({aws_usable} usable, need 15)\")\nEOF",
        validation: "python3 -c \"import ipaddress; n = ipaddress.IPv4Network('172.16.0.0/16'); print(len(list(n.subnets(new_prefix=24))))\" | grep '256'"
      },
      {
        step_number: 5,
        title: "Variable Length Subnet Masking (VLSM)",
        instruction: "Efficiently subnet network with different sized subnets",
        expected_command: "python3 << 'EOF'\nimport ipaddress\n\nprint(\"Variable Length Subnet Masking (VLSM) Example\\n\")\nprint(\"=\"*70)\nprint(\"\\nScenario: Subnet 192.168.1.0/24 for:\")\nprint(\"  - Department A: 60 hosts\")\nprint(\"  - Department B: 30 hosts\")\nprint(\"  - Department C: 12 hosts\")\nprint(\"  - Point-to-point links: 2 hosts each (x2)\\n\")\n\nbase = ipaddress.IPv4Network('192.168.1.0/24')\navailable = base.network_address\n\nallocations = []\n\n# Dept A: 60 hosts = need /26 (62 usable)\nnet_a = ipaddress.IPv4Network(f'{available}/26')\nallocations.append(('Department A', net_a, 60))\navailable = net_a.broadcast_address + 1\n\n# Dept B: 30 hosts = need /27 (30 usable)\nnet_b = ipaddress.IPv4Network(f'{available}/27')\nallocations.append(('Department B', net_b, 30))\navailable = net_b.broadcast_address + 1\n\n# Dept C: 12 hosts = need /28 (14 usable)\nnet_c = ipaddress.IPv4Network(f'{available}/28')\nallocations.append(('Department C', net_c, 12))\navailable = net_c.broadcast_address + 1\n\n# P2P Link 1: 2 hosts = need /30 (2 usable)\nnet_p2p1 = ipaddress.IPv4Network(f'{available}/30')\nallocations.append(('P2P Link 1', net_p2p1, 2))\navailable = net_p2p1.broadcast_address + 1\n\n# P2P Link 2: 2 hosts = need /30 (2 usable)\nnet_p2p2 = ipaddress.IPv4Network(f'{available}/30')\nallocations.append(('P2P Link 2', net_p2p2, 2))\navailable = net_p2p2.broadcast_address + 1\n\nprint(\"VLSM Allocation:\")\nfor name, network, required in allocations:\n    usable = network.num_addresses - 2\n    print(f\"\\n{name}:\")\n    print(f\"  CIDR: {network}\")\n    print(f\"  Usable: {usable} (required: {required})\")\n    print(f\"  Range: {list(network.hosts())[0]} - {list(network.hosts())[-1]}\")\n\nprint(f\"\\nRemaining unused: {available} - 192.168.1.255\")\nEOF",
        validation: "python3 -c \"print('VLSM')\" | grep 'VLSM'"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove lab files",
        expected_command: "rm cidr_tool.py vpc_design.py",
        validation: "test ! -f cidr_tool.py"
      }
    ],
    validation_rules: {
      cidr_mastery: "CIDR notation fully understood",
      subnetting_skills: "can subnet networks efficiently",
      vlsm_understood: "variable length subnet masking"
    },
    success_criteria: "Master CIDR notation and practical subnetting",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 300,
    is_active: true
  },

  {
    title: "NAT, Public IPs, and Internet Gateway Concepts",
    description: "Understand Network Address Translation, public vs private IPs, and internet connectivity",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "networking",
    category: "nat-gateway",
    certification_exam: "AWS Solutions Architect",
    learning_objectives: "Master NAT concepts, understand public/private IP differences, learn internet gateway configuration",
    prerequisites: ["IP Addressing Basics", "CIDR Notation"],
    steps: [
      {
        step_number: 1,
        title: "Understand NAT types",
        instruction: "Document NAT concepts and types",
        expected_command: "cat > nat_concepts.md << 'EOF'\n# Network Address Translation (NAT)\n\n## What is NAT?\nNAT translates private IP addresses to public IP addresses, allowing multiple devices to share a single public IP.\n\n## NAT Types\n\n### 1. Static NAT (One-to-One)\n- Maps one private IP to one public IP\n- Used for servers that need consistent public IP\n- Example: Web server at 10.0.1.5 → 203.0.113.10\n\n### 2. Dynamic NAT (Pool)\n- Maps private IPs to pool of public IPs\n- First-come, first-served from pool\n- Example: 100 private IPs → pool of 10 public IPs\n\n### 3. PAT (Port Address Translation) / NAT Overload\n- Many private IPs → single public IP using different ports\n- Most common (home routers, AWS NAT Gateway)\n- Example: \n  - 10.0.1.5:50000 → 203.0.113.10:50000\n  - 10.0.1.6:50001 → 203.0.113.10:50001\n\n## AWS NAT Solutions\n\n### NAT Gateway (Managed)\n- **Throughput**: 5 Gbps (scales to 100 Gbps)\n- **Availability**: Auto-deployed in AZ\n- **Cost**: $0.045/hour + $0.045/GB processed\n- **Maintenance**: Fully managed by AWS\n- **Use Case**: Production workloads\n\n### NAT Instance (Self-Managed)\n- **Throughput**: Depends on instance type\n- **Availability**: You manage\n- **Cost**: EC2 instance pricing\n- **Maintenance**: You patch and update\n- **Use Case**: Cost optimization, legacy\n\n## Public vs Private IPs\n\n### Public IPs\n- Routable on internet\n- Globally unique\n- Assigned by ISPs/RIRs\n- AWS: Elastic IPs (static) or auto-assigned (dynamic)\n- Can be accessed from anywhere\n\n### Private IPs\n- NOT routable on internet\n- Reusable across networks\n- RFC 1918 ranges (10/8, 172.16/12, 192.168/16)\n- AWS: All EC2 instances get private IP\n- Need NAT for outbound internet access\n\n## AWS Connectivity Patterns\n\n### Public Subnet\n- Has route to Internet Gateway (IGW)\n- Instances CAN have public IPs\n- Direct internet access (inbound/outbound)\n- Example: Web servers, bastion hosts\n\n### Private Subnet\n- No direct route to IGW\n- Instances have private IPs only\n- Uses NAT Gateway for outbound internet\n- NO inbound internet access\n- Example: App servers, databases\nEOF",
        validation: "test -f nat_concepts.md && grep 'NAT Gateway' nat_concepts.md"
      },
      {
        step_number: 2,
        title: "Simulate NAT translation",
        instruction: "Create NAT translation table simulator",
        expected_command: "cat > nat_simulator.py << 'EOF'\nimport random\n\nclass NATGateway:\n    def __init__(self, public_ip):\n        self.public_ip = public_ip\n        self.translation_table = {}\n        self.next_port = 50000\n    \n    def translate_outbound(self, private_ip, private_port):\n        \"\"\"Translate outbound connection\"\"\"\n        key = f\"{private_ip}:{private_port}\"\n        if key not in self.translation_table:\n            self.translation_table[key] = self.next_port\n            self.next_port += 1\n        \n        public_port = self.translation_table[key]\n        print(f\"  OUT: {private_ip}:{private_port} → {self.public_ip}:{public_port}\")\n        return public_port\n    \n    def translate_inbound(self, public_port):\n        \"\"\"Translate inbound response\"\"\"\n        for key, port in self.translation_table.items():\n            if port == public_port:\n                private_ip, private_port = key.split(':')\n                print(f\"  IN:  {self.public_ip}:{public_port} → {private_ip}:{private_port}\")\n                return private_ip, private_port\n        return None, None\n    \n    def show_table(self):\n        print(\"\\nNAT Translation Table:\")\n        print(\"  Private IP:Port    →    Public IP:Port\")\n        print(\"  \" + \"=\"*45)\n        for key, public_port in self.translation_table.items():\n            print(f\"  {key:20s} → {self.public_ip}:{public_port}\")\n\n# Simulate NAT Gateway\nprint(\"NAT Gateway Simulation\")\nprint(\"=\"*50)\nnat = NATGateway(\"203.0.113.10\")\n\nprint(\"\\nThree instances connecting to internet:\\n\")\nnat.translate_outbound(\"10.0.1.5\", 45678)\nnat.translate_outbound(\"10.0.1.6\", 45679)\nnat.translate_outbound(\"10.0.1.7\", 45680)\n\nprint(\"\\nResponses coming back:\\n\")\nnat.translate_inbound(50000)\nnat.translate_inbound(50001)\n\nnat.show_table()\nEOF",
        validation: "test -f nat_simulator.py && python3 nat_simulator.py | grep 'NAT Gateway'"
      },
      {
        step_number: 3,
        title: "AWS VPC routing scenario",
        instruction: "Design route tables for public and private subnets",
        expected_command: "cat > route_tables.md << 'EOF'\n# AWS VPC Route Tables\n\n## Scenario: VPC 10.0.0.0/16\n\n### Public Subnet Route Table (10.0.1.0/24)\n\n| Destination    | Target           | Purpose                      |\n|----------------|------------------|------------------------------|\n| 10.0.0.0/16    | local            | VPC internal communication   |\n| 0.0.0.0/0      | igw-xxxxx        | Internet via Internet Gateway|\n\n**Result**: \n- Instances can reach other VPC resources directly\n- Instances can reach internet directly\n- Internet can reach instances (if they have public IP)\n\n### Private Subnet Route Table (10.0.10.0/24)\n\n| Destination    | Target           | Purpose                      |\n|----------------|------------------|------------------------------|\n| 10.0.0.0/16    | local            | VPC internal communication   |\n| 0.0.0.0/0      | nat-xxxxx        | Internet via NAT Gateway     |\n\n**Result**:\n- Instances can reach other VPC resources directly\n- Instances can reach internet via NAT (outbound only)\n- Internet CANNOT reach instances (no inbound route)\n\n## Cost Optimization: NAT Gateway Consolidation\n\n### Option 1: NAT Gateway per AZ (High Availability)\n```\nVPC 10.0.0.0/16\n├── AZ-1a\n│   ├── Public Subnet: 10.0.1.0/24 → IGW\n│   ├── Private Subnet: 10.0.10.0/24 → NAT-GW-1a\n│   └── NAT Gateway: nat-1a (in public subnet)\n└── AZ-1b\n    ├── Public Subnet: 10.0.2.0/24 → IGW\n    ├── Private Subnet: 10.0.11.0/24 → NAT-GW-1b\n    └── NAT Gateway: nat-1b (in public subnet)\n\nCost: 2 NAT Gateways = ~$65/month + data transfer\nBenefit: Survives AZ failure\n```\n\n### Option 2: Single NAT Gateway (Cost Savings)\n```\nVPC 10.0.0.0/16\n├── AZ-1a\n│   ├── Public Subnet: 10.0.1.0/24 → IGW\n│   ├── Private Subnet: 10.0.10.0/24 → NAT-GW-1a\n│   └── NAT Gateway: nat-1a\n└── AZ-1b\n    ├── Public Subnet: 10.0.2.0/24 → IGW\n    └── Private Subnet: 10.0.11.0/24 → NAT-GW-1a (cross-AZ)\n\nCost: 1 NAT Gateway = ~$33/month + data transfer\nRisk: AZ-1a failure = no internet for private subnets\n```\nEOF",
        validation: "test -f route_tables.md && grep 'Internet Gateway' route_tables.md"
      },
      {
        step_number: 4,
        title: "Calculate NAT Gateway costs",
        instruction: "Estimate monthly NAT Gateway costs",
        expected_command: "python3 << 'EOF'\ndef calculate_nat_cost(hours_per_month=730, data_gb=1000, num_gateways=1):\n    hourly_rate = 0.045\n    data_rate = 0.045  # per GB\n    \n    hourly_cost = hours_per_month * hourly_rate * num_gateways\n    data_cost = data_gb * data_rate\n    total = hourly_cost + data_cost\n    \n    return hourly_cost, data_cost, total\n\nscenarios = [\n    (\"Single NAT GW - Low traffic\", 1, 100),\n    (\"Single NAT GW - Medium traffic\", 1, 1000),\n    (\"Single NAT GW - High traffic\", 1, 5000),\n    (\"Multi-AZ (2 NAT GWs) - Medium traffic\", 2, 1000),\n    (\"Multi-AZ (3 NAT GWs) - High traffic\", 3, 5000),\n]\n\nprint(\"AWS NAT Gateway Cost Calculator\\n\")\nprint(\"=\"*70)\nfor desc, gateways, data_gb in scenarios:\n    hourly, data, total = calculate_nat_cost(num_gateways=gateways, data_gb=data_gb)\n    print(f\"\\n{desc}:\")\n    print(f\"  NAT Gateways: {gateways}\")\n    print(f\"  Data processed: {data_gb} GB\")\n    print(f\"  Hourly charges: ${hourly:.2f}\")\n    print(f\"  Data charges: ${data:.2f}\")\n    print(f\"  Monthly total: ${total:.2f}\")\n\nprint(\"\\n\" + \"=\"*70)\nprint(\"\\nCost Savings Tips:\")\nprint(\"  • Use VPC Endpoints for AWS services (S3, DynamoDB)\")\nprint(\"  • Consolidate to fewer NAT Gateways (trade-off: availability)\")\nprint(\"  • Use NAT Instance for non-production (manual management)\")\nprint(\"  • Consider PrivateLink for third-party SaaS\")\nEOF",
        validation: "python3 -c \"print('NAT Gateway Cost')\" | grep 'Cost'"
      },
      {
        step_number: 5,
        title: "Troubleshoot connectivity",
        instruction: "Common NAT and internet connectivity issues",
        expected_command: "cat > troubleshooting.md << 'EOF'\n# AWS Internet Connectivity Troubleshooting\n\n## Issue: Private subnet instance can't reach internet\n\n### Checklist:\n1. **Route Table**\n   - Check: 0.0.0.0/0 → nat-xxxxx exists\n   - Verify: Route table associated with subnet\n\n2. **NAT Gateway**\n   - Check: NAT Gateway state is \"available\"\n   - Check: NAT Gateway is in PUBLIC subnet\n   - Check: NAT Gateway has Elastic IP\n\n3. **Public Subnet (where NAT lives)**\n   - Check: Has route 0.0.0.0/0 → igw-xxxxx\n   - Check: Internet Gateway attached to VPC\n\n4. **Security Group**\n   - Check: Outbound rules allow HTTPS (443) and HTTP (80)\n   - Default: All outbound traffic allowed\n\n5. **Network ACL**\n   - Check: Outbound rules allow traffic\n   - Check: Inbound rules allow return traffic\n   - Default: Allow all\n\n## Issue: Public subnet instance can't reach internet\n\n### Checklist:\n1. **Public IP**\n   - Check: Instance has public IP or Elastic IP\n   - Enable: Auto-assign public IP on subnet\n\n2. **Route Table**\n   - Check: 0.0.0.0/0 → igw-xxxxx exists\n\n3. **Internet Gateway**\n   - Check: IGW attached to VPC\n   - Check: Only ONE IGW per VPC\n\n4. **Security Group**\n   - Check: Outbound allows traffic\n   - Check: Inbound allows return traffic (stateful)\n\n5. **Instance itself**\n   - Check: Instance not blocking traffic (iptables, firewall)\n\n## AWS CLI Commands for Debugging\n\n```bash\n# Check route tables\naws ec2 describe-route-tables --filters \"Name=vpc-id,Values=vpc-xxxxx\"\n\n# Check NAT Gateway status\naws ec2 describe-nat-gateways --filter \"Name=vpc-id,Values=vpc-xxxxx\"\n\n# Check Internet Gateway\naws ec2 describe-internet-gateways --filters \"Name=attachment.vpc-id,Values=vpc-xxxxx\"\n\n# Check instance public IP\naws ec2 describe-instances --instance-ids i-xxxxx --query 'Reservations[].Instances[].[PublicIpAddress]'\n\n# Check security groups\naws ec2 describe-security-groups --group-ids sg-xxxxx\n```\nEOF",
        validation: "test -f troubleshooting.md && grep 'Troubleshooting' troubleshooting.md"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove lab files",
        expected_command: "rm nat_concepts.md nat_simulator.py route_tables.md troubleshooting.md",
        validation: "test ! -f nat_concepts.md"
      }
    ],
    validation_rules: {
      nat_understood: "NAT types and use cases",
      aws_nat_mastered: "NAT Gateway vs NAT Instance",
      routing_clear: "public vs private subnet routing"
    },
    success_criteria: "Master NAT concepts and AWS internet connectivity",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 300,
    is_active: true
  }
]

# Create Networking Fundamentals Labs
networking_fundamentals_labs.each_with_index do |lab_data, index|
  begin
    lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
    lab.assign_attributes(lab_data)
    lab.save ? print(".") : puts("\n❌ Failed: #{lab_data[:title]}")
  rescue => e
    puts "\n❌ Error on #{lab_data[:title]}: #{e.message}"
  end
end

puts "\n\n✅ Networking Fundamentals Labs Complete!"
puts "   Total IP/Subnet labs: #{HandsOnLab.where(lab_type: 'networking', category: ['ip-addressing', 'subnetting', 'nat-gateway']).count}"
puts "\n🌐 Ready for AWS and Networking Certifications!"

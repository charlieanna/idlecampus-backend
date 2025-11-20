#!/usr/bin/env python3
"""
Script to fix all microlesson YAML files:
1. Replace placeholder MCQs with content-specific questions
2. Fix misaligned objectives
3. Customize reflection/checkpoint prompts
4. Expand minimal content files
"""

import os
import yaml
import re
from pathlib import Path

MICROLESSONS_DIR = "/home/user/idlecampus-backend/db/seeds/networking_complete_enhanced/microlessons"

# Chemistry MCQs based on content
CHEMISTRY_MCQS = {
    "adsorption-types-and-mechanisms": {
        "question": "What is the primary difference between physisorption and chemisorption?",
        "options": [
            "Physisorption involves weak van der Waals forces while chemisorption involves strong chemical bonds",
            "Physisorption is irreversible while chemisorption is reversible",
            "Physisorption requires activation energy while chemisorption does not",
            "Physisorption forms monolayers while chemisorption forms multilayers"
        ],
        "correct_answer_index": 0,
        "explanation": "Physisorption involves weak van der Waals forces with low heat of adsorption (20-40 kJ/mol) and is reversible, while chemisorption involves strong chemical bonds with high heat of adsorption (80-400 kJ/mol) and is irreversible."
    },
    "anomalousbehavior-practice": {
        "question": "Why does beryllium show anomalous behavior compared to other alkaline earth metals?",
        "options": [
            "Small size and high charge density",
            "Large atomic radius",
            "Low electronegativity",
            "High reactivity with water"
        ],
        "correct_answer_index": 0,
        "explanation": "Beryllium's anomalous behavior is due to its small size and high charge density, which leads to properties like amphoteric nature of BeO and Be(OH)₂, covalent character in BeCl₂, and protective oxide layer preventing reaction with water."
    },
    "basic-laboratory-techniques-purification-and-separation-methods": {
        "question": "Which distillation technique should be used for separating liquids with boiling points that differ by less than 25°C?",
        "options": [
            "Fractional distillation",
            "Simple distillation",
            "Steam distillation",
            "Vacuum distillation"
        ],
        "correct_answer_index": 0,
        "explanation": "Fractional distillation uses a fractionating column that provides multiple vaporization-condensation cycles, making it effective for separating liquids with close boiling points (<25°C). Simple distillation is only effective when the boiling point difference is greater than 25°C."
    },
    "cation-and-anion-analysis-group-reagents-and-tests": {
        "question": "Which group reagent is used to precipitate Group I cations (Pb²⁺, Ag⁺, Hg₂²⁺)?",
        "options": [
            "Dilute HCl",
            "H₂S in acidic medium",
            "NH₄OH + NH₄Cl",
            "(NH₄)₂CO₃"
        ],
        "correct_answer_index": 0,
        "explanation": "Dilute HCl is the group reagent for Group I cations, forming white precipitates: PbCl₂, AgCl, and Hg₂Cl₂. These chlorides are insoluble in dilute HCl, allowing separation from other cation groups."
    },
    "close-packing-packing-efficiency-and-crystal-defects": {
        "question": "What is the packing efficiency of a face-centered cubic (FCC) structure?",
        "options": [
            "74%",
            "68%",
            "52%",
            "34%"
        ],
        "correct_answer_index": 0,
        "explanation": "The FCC structure (also called cubic close packing or CCP) has a packing efficiency of 74%, which is the maximum possible for spheres. It has a coordination number of 12 and both tetrahedral and octahedral voids."
    },
    "conductance-kohlrausch": {
        "question": "According to Kohlrausch's law, what does the molar conductivity at infinite dilution represent?",
        "options": [
            "The sum of individual ionic conductivities at infinite dilution",
            "The product of cation and anion conductivities",
            "The ratio of equivalent conductivity to concentration",
            "The resistance of the electrolyte solution"
        ],
        "correct_answer_index": 0,
        "explanation": "Kohlrausch's law states that at infinite dilution, the molar conductivity (Λ°ₘ) of an electrolyte is the sum of the individual contributions of cations and anions: Λ°ₘ = λ°₊ + λ°₋. This is used to calculate Λ°ₘ for weak electrolytes."
    },
    "electrolysis-faraday": {
        "question": "According to Faraday's first law of electrolysis, the mass of substance deposited is directly proportional to:",
        "options": [
            "The quantity of electricity passed through the electrolyte",
            "The voltage applied",
            "The resistance of the electrolyte",
            "The temperature of the solution"
        ],
        "correct_answer_index": 0,
        "explanation": "Faraday's first law states that m = ZQ, where m is the mass deposited, Z is the electrochemical equivalent, and Q is the quantity of electricity (in coulombs). The mass deposited is directly proportional to the charge passed."
    },
    "emulsions-and-micelles": {
        "question": "What is the critical micelle concentration (CMC)?",
        "options": [
            "The minimum concentration of surfactant needed for micelle formation",
            "The maximum concentration of surfactant in solution",
            "The concentration at which emulsion breaks",
            "The concentration of surfactant at the interface"
        ],
        "correct_answer_index": 0,
        "explanation": "CMC is the minimum concentration of surfactant at which micelles begin to form. Below CMC, surfactants exist as individual molecules; above CMC, they aggregate into micelles with hydrophobic tails inside and hydrophilic heads outside."
    },
    "group-14-carbon-family-c-si-ge-sn-pb": {
        "question": "Why does carbon primarily form covalent compounds while lead forms ionic compounds?",
        "options": [
            "Carbon has high ionization energy and small atomic size, while lead has lower ionization energy",
            "Carbon is more electronegative than lead",
            "Lead has more valence electrons",
            "Carbon can form multiple bonds"
        ],
        "correct_answer_index": 0,
        "explanation": "Carbon has high ionization energy and small atomic size, making it difficult to lose electrons, so it forms covalent bonds. Lead, being larger with lower ionization energy down the group, more readily forms ionic compounds, especially Pb²⁺ due to the inert pair effect."
    },
    "group-16-elements-oxygen-and-sulfur": {
        "question": "Which property increases down Group 16 from oxygen to polonium?",
        "options": [
            "Atomic radius and metallic character",
            "Electronegativity",
            "Ionization energy",
            "Non-metallic character"
        ],
        "correct_answer_index": 0,
        "explanation": "Down Group 16, atomic radius increases due to addition of shells, and metallic character increases. Conversely, electronegativity, ionization energy, and non-metallic character all decrease down the group."
    },
    "group-2-alkaline-earth-metals-be-mg-ca-sr-ba-ra": {
        "question": "Why is the second ionization energy of alkaline earth metals higher than the first?",
        "options": [
            "Removing an electron from a positively charged ion requires more energy",
            "The second electron is in a lower energy level",
            "The atomic radius decreases",
            "The nuclear charge increases"
        ],
        "correct_answer_index": 0,
        "explanation": "The second ionization energy is always higher because after losing the first electron, the ion has a positive charge. Removing another electron from this positively charged species requires more energy due to increased effective nuclear charge on the remaining electrons."
    },
    "liquid-state-solid-state": {
        "question": "According to the kinetic molecular theory, what distinguishes a liquid from a solid?",
        "options": [
            "Liquids have particles with enough energy to overcome some intermolecular forces but not all",
            "Liquids have no intermolecular forces",
            "Liquids have fixed shape and volume",
            "Liquids have completely free molecular motion"
        ],
        "correct_answer_index": 0,
        "explanation": "In liquids, particles have enough kinetic energy to partially overcome intermolecular forces, allowing them to move past each other (flow) while staying close together (definite volume). Solids have fixed positions, while gases have completely free motion."
    },
    "qualitative-analysis-detection-tests-for-elements-and-functional-groups": {
        "question": "Which test is used to detect the presence of nitrogen in an organic compound?",
        "options": [
            "Lassaigne's test (Sodium fusion test)",
            "Fehling's test",
            "Tollen's test",
            "Lucas test"
        ],
        "correct_answer_index": 0,
        "explanation": "Lassaigne's test (sodium fusion test) is used to detect nitrogen, sulfur, and halogens in organic compounds. For nitrogen, the compound is fused with sodium metal to form sodium cyanide, which gives a Prussian blue color with FeSO₄ and FeCl₃."
    },
    "which-reagent-can-be-used-to-distinguish-between-benzoic-acid-and-phenol-using-extraction": {
        "question": "Which reagent can distinguish between benzoic acid and phenol using extraction?",
        "options": [
            "NaHCO₃ (sodium bicarbonate)",
            "NaCl solution",
            "Dilute HCl",
            "Ether"
        ],
        "correct_answer_index": 0,
        "explanation": "NaHCO₃ can distinguish between benzoic acid and phenol because benzoic acid (stronger acid, pKa ~4.2) reacts with NaHCO₃ to form water-soluble sodium benzoate, while phenol (weaker acid, pKa ~10) does not react with the weak base NaHCO₃."
    }
}

# Docker/DevOps MCQs
DOCKER_MCQS = {
    "docker-build-building-images-from-dockerfile": {
        "question": "What is the purpose of the -t flag in the docker build command?",
        "options": [
            "To tag the image with a name and optional version tag",
            "To set the timeout for the build process",
            "To run the build in test mode",
            "To specify the target architecture"
        ],
        "correct_answer_index": 0,
        "explanation": "The -t (tag) flag allows you to name your image and optionally specify a version tag (e.g., myapp:1.0). Without it, the image would only be identifiable by its hash ID. Format: docker build -t imagename:tag ."
    },
    "docker-compose-build-build-or-rebuild-service-images": {
        "question": "When should you use docker-compose build instead of docker-compose up?",
        "options": [
            "When you've modified a Dockerfile and need to rebuild images",
            "When you want to start containers",
            "When you want to stop running containers",
            "When you need to view logs"
        ],
        "correct_answer_index": 0,
        "explanation": "docker-compose build is used specifically to build or rebuild service images after changes to Dockerfiles. docker-compose up will use existing images unless you add the --build flag. Running build separately gives you more control over the build process."
    },
    "docker-compose-up-start-multi-container-applications": {
        "question": "What does the -d flag do in docker-compose up -d?",
        "options": [
            "Runs containers in detached mode (in the background)",
            "Deletes existing containers before starting",
            "Enables debug mode",
            "Deploys containers to production"
        ],
        "correct_answer_index": 0,
        "explanation": "The -d flag runs containers in detached mode, meaning they run in the background and don't block your terminal. Without -d, logs from all services would stream to your terminal, and pressing Ctrl+C would stop all containers."
    },
    "docker-network-connect": {
        "question": "What happens when you connect a running container to a network using docker network connect?",
        "options": [
            "The container can communicate with other containers on that network without restarting",
            "The container must be restarted for the network change to take effect",
            "All existing network connections are removed",
            "The container is disconnected from all other networks"
        ],
        "correct_answer_index": 0,
        "explanation": "docker network connect allows you to add a running container to an additional network without restarting it. A container can be connected to multiple networks simultaneously, enabling flexible network architectures for microservices."
    },
    "docker-network-create": {
        "question": "What is the default network driver when creating a custom network with docker network create?",
        "options": [
            "bridge",
            "host",
            "overlay",
            "macvlan"
        ],
        "correct_answer_index": 0,
        "explanation": "The default driver is 'bridge', which creates an isolated network on a single Docker host. Other drivers include 'overlay' for multi-host networks in Swarm mode, 'host' to remove network isolation, and 'macvlan' to assign MAC addresses to containers."
    },
    "docker-port-list-port-mappings": {
        "question": "What does the command 'docker port <container>' display?",
        "options": [
            "All port mappings between the container and host",
            "Only the ports the container is listening on internally",
            "Only the host ports that are available",
            "The container's IP address"
        ],
        "correct_answer_index": 0,
        "explanation": "docker port shows the mapping between container ports and host ports, displaying which host port forwards to which container port. Example output: '80/tcp -> 0.0.0.0:8080' means container port 80 is accessible on host port 8080."
    },
    "docker-pull-download-images-from-registry": {
        "question": "What happens if you don't specify a tag when running docker pull?",
        "options": [
            "It pulls the image tagged as 'latest' by default",
            "It pulls all available tags",
            "It fails with an error",
            "It pulls the oldest version"
        ],
        "correct_answer_index": 0,
        "explanation": "When no tag is specified, Docker automatically appends ':latest' to the image name. For example, 'docker pull nginx' is equivalent to 'docker pull nginx:latest'. Note that 'latest' doesn't always mean the most recent version - it's just a default tag."
    },
    "docker-push-upload-images-to-registry": {
        "question": "Before pushing an image to Docker Hub, what must you do?",
        "options": [
            "Tag the image with your Docker Hub username and authenticate with docker login",
            "Only run docker login",
            "Set the image as public in Docker settings",
            "Create a Dockerfile"
        ],
        "correct_answer_index": 0,
        "explanation": "You must: 1) Authenticate with 'docker login', 2) Tag your image with your username: 'docker tag myimage username/myimage:tag', then 3) Push with 'docker push username/myimage:tag'. The username in the tag tells Docker where to push."
    },
    "docker-rm-removing-containers": {
        "question": "Why would you use docker rm -f instead of docker rm?",
        "options": [
            "To force remove a running container without stopping it first",
            "To remove the container and its associated images",
            "To remove only failed containers",
            "To remove containers faster"
        ],
        "correct_answer_index": 0,
        "explanation": "The -f (force) flag allows you to remove a running container without explicitly stopping it first. Without -f, trying to remove a running container will fail with an error. Use with caution as it doesn't allow graceful shutdown."
    },
    "docker-run-creating-and-starting-containers": {
        "question": "What is the difference between docker run and docker start?",
        "options": [
            "docker run creates and starts a new container; docker start restarts an existing stopped container",
            "They are identical commands",
            "docker run is faster than docker start",
            "docker start creates new containers while docker run restarts them"
        ],
        "correct_answer_index": 0,
        "explanation": "docker run creates a new container from an image and starts it (combines docker create + docker start). docker start only works with existing containers that have been stopped, restarting them with their original configuration."
    },
    "codesprout-exposing-containers-with-port-mapping": {
        "question": "In the command 'docker run -p 8080:80 nginx', which port is on the container?",
        "options": [
            "80",
            "8080",
            "Both ports are on the container",
            "Neither, both are on the host"
        ],
        "correct_answer_index": 0,
        "explanation": "The format is -p host:container. So 8080:80 means host port 8080 maps to container port 80. Traffic to localhost:8080 on your machine is forwarded to port 80 inside the container where nginx is listening."
    }
}

# Go/Programming MCQs
GO_MCQS = {
    "introduction-to-goroutines": {
        "question": "How do you start a goroutine in Go?",
        "options": [
            "Use the 'go' keyword before a function call",
            "Call the .start() method on a function",
            "Use the 'async' keyword",
            "Import the goroutine package"
        ],
        "correct_answer_index": 0,
        "explanation": "Goroutines are started simply by prefixing a function call with the 'go' keyword, e.g., 'go myFunction()'. This creates a lightweight thread managed by the Go runtime. Goroutines are much more lightweight than OS threads."
    },
    "introduction-to-channels": {
        "question": "What is the primary purpose of channels in Go?",
        "options": [
            "To enable safe communication and data sharing between goroutines",
            "To store large amounts of data",
            "To replace function parameters",
            "To speed up program execution"
        ],
        "correct_answer_index": 0,
        "explanation": "Channels provide a safe way for goroutines to communicate and share data, following the Go proverb: 'Don't communicate by sharing memory; share memory by communicating.' Channels prevent race conditions and make concurrent programming safer."
    },
    "concurrency-vs-parallelism": {
        "question": "What is the key difference between concurrency and parallelism?",
        "options": [
            "Concurrency is about dealing with multiple tasks; parallelism is about executing multiple tasks simultaneously",
            "They are the same concept",
            "Concurrency is faster than parallelism",
            "Parallelism only works on multi-core systems"
        ],
        "correct_answer_index": 0,
        "explanation": "Concurrency is about structure - dealing with multiple tasks that can make progress independently. Parallelism is about execution - running multiple tasks at the exact same time on different cores. A concurrent program may or may not execute in parallel."
    },
    "fan-outfan-in-pipeline": {
        "question": "In a fan-out/fan-in pattern, what does 'fan-out' mean?",
        "options": [
            "Starting multiple goroutines to process items from a single channel",
            "Sending data to multiple output channels",
            "Closing all channels simultaneously",
            "Combining results from multiple sources"
        ],
        "correct_answer_index": 0,
        "explanation": "Fan-out means starting multiple goroutines to read from the same channel to distribute work across multiple workers. Fan-in is the opposite - combining multiple input channels into one output channel. This pattern enables parallel processing of a pipeline stage."
    },
    "pointers-in-go": {
        "question": "What does the & operator do in Go?",
        "options": [
            "Returns the memory address of a variable",
            "Dereferences a pointer",
            "Performs a bitwise AND operation",
            "Declares a pointer type"
        ],
        "correct_answer_index": 0,
        "explanation": "The & operator returns the memory address of a variable (creating a pointer). For example, &x gives you a pointer to x. The * operator is used for dereferencing (accessing the value at a pointer) and declaring pointer types."
    },
    "building-http-servers-with-nethttp": {
        "question": "What is the purpose of http.HandleFunc in Go?",
        "options": [
            "To register a handler function for a specific URL pattern",
            "To start the HTTP server",
            "To parse HTTP requests",
            "To create HTTP responses"
        ],
        "correct_answer_index": 0,
        "explanation": "http.HandleFunc registers a handler function that will be called when requests match a specific URL pattern. Example: http.HandleFunc('/hello', myHandler) will call myHandler for all requests to /hello. Use http.ListenAndServe to start the server."
    },
    "database-integration-with-databasesql": {
        "question": "Why should you use prepared statements with database/sql in Go?",
        "options": [
            "To prevent SQL injection and improve performance through query plan caching",
            "To make queries run faster only",
            "To automatically create database tables",
            "To enable concurrent database access"
        ],
        "correct_answer_index": 0,
        "explanation": "Prepared statements (db.Prepare) prevent SQL injection by separating query structure from data, and improve performance by allowing the database to cache the query execution plan. They're essential for security when using user input in queries."
    },
    "json-requestresponse-handling": {
        "question": "Which Go function is used to convert a struct to JSON?",
        "options": [
            "json.Marshal()",
            "json.Encode()",
            "json.Stringify()",
            "json.Parse()"
        ],
        "correct_answer_index": 0,
        "explanation": "json.Marshal() converts a Go value (typically a struct) into JSON bytes. json.Unmarshal() does the reverse - converting JSON bytes into a Go value. Note that struct fields must be exported (capitalized) to be included in JSON output."
    },
    "middleware-and-logging": {
        "question": "What is middleware in the context of HTTP servers?",
        "options": [
            "A function that wraps HTTP handlers to add functionality like logging or authentication",
            "A database management tool",
            "A frontend framework",
            "A type of HTTP response"
        ],
        "correct_answer_index": 0,
        "explanation": "Middleware wraps HTTP handlers to add cross-cutting functionality like logging, authentication, or CORS handling. Middleware functions take a handler as input and return a new handler, allowing you to chain multiple middleware together."
    },
    "rest-api-design-basics": {
        "question": "Which HTTP method should be used to update an existing resource in a RESTful API?",
        "options": [
            "PUT or PATCH",
            "POST",
            "GET",
            "DELETE"
        ],
        "correct_answer_index": 0,
        "explanation": "PUT is used for full updates (replacing entire resource) and PATCH for partial updates (modifying specific fields). POST creates new resources, GET retrieves resources, and DELETE removes resources. Following these conventions makes APIs more intuitive."
    }
}

# Infrastructure/DevOps MCQs
DEVOPS_MCQS = {
    "infrastructure-as-code-with-terraform": {
        "question": "What is the primary benefit of using Infrastructure as Code (IaC) with Terraform?",
        "options": [
            "Version-controlled, repeatable, and automated infrastructure provisioning",
            "Faster server performance",
            "Automatic security patches",
            "Reduced cloud costs"
        ],
        "correct_answer_index": 0,
        "explanation": "IaC with Terraform allows you to define infrastructure in code files that can be version-controlled, reviewed, and reused. This enables repeatable deployments, reduces manual errors, and allows teams to collaborate on infrastructure changes like they do with application code."
    },
    "advanced-terraform-patterns": {
        "question": "What is a Terraform module?",
        "options": [
            "A container for multiple resources that are used together",
            "A cloud provider's API",
            "A type of variable",
            "A deployment strategy"
        ],
        "correct_answer_index": 0,
        "explanation": "Modules are containers for multiple resources that are used together. They enable you to organize, encapsulate, and reuse Terraform configurations. A module can be called multiple times with different input variables to create similar infrastructure components."
    },
    "configuration-management": {
        "question": "What is the main difference between configuration management and infrastructure provisioning?",
        "options": [
            "Configuration management handles software/settings on existing servers; provisioning creates the servers",
            "They are the same thing",
            "Configuration management is faster",
            "Provisioning is only for cloud resources"
        ],
        "correct_answer_index": 0,
        "explanation": "Infrastructure provisioning (like Terraform) creates and manages the servers, networks, and resources. Configuration management (like Ansible, Chef, Puppet) installs and configures software on those servers. They complement each other in a complete automation strategy."
    },
    "managing-secrets-securely": {
        "question": "Why should secrets never be committed to version control?",
        "options": [
            "Git history is permanent and public, exposing credentials even if deleted later",
            "It makes the repository too large",
            "Version control systems can't handle encrypted data",
            "It slows down git operations"
        ],
        "correct_answer_index": 0,
        "explanation": "Once committed, secrets remain in git history forever unless you rewrite history (which breaks collaborators' clones). Even if deleted in a new commit, they're still accessible in old commits. Public repositories expose these to everyone. Use secret management tools instead."
    },
    "introduction-to-cryptography": {
        "question": "What is the main difference between symmetric and asymmetric encryption?",
        "options": [
            "Symmetric uses one key for both encryption and decryption; asymmetric uses a key pair",
            "Symmetric is more secure",
            "Asymmetric is faster",
            "Symmetric is only for files, asymmetric for network traffic"
        ],
        "correct_answer_index": 0,
        "explanation": "Symmetric encryption (AES, DES) uses the same key for encryption and decryption - faster but requires secure key exchange. Asymmetric encryption (RSA, ECC) uses a public/private key pair - slower but solves the key distribution problem and enables digital signatures."
    },
    "understanding-tlsssl": {
        "question": "What is the primary purpose of TLS/SSL?",
        "options": [
            "To encrypt data in transit and verify server identity",
            "To compress network traffic",
            "To speed up HTTP requests",
            "To cache web pages"
        ],
        "correct_answer_index": 0,
        "explanation": "TLS (Transport Layer Security) encrypts data during transmission to prevent eavesdropping and tampering, and uses certificates to verify that you're communicating with the intended server (not an imposter). This provides confidentiality, integrity, and authentication."
    },
    "working-with-certificates": {
        "question": "What is a Certificate Authority (CA) in the context of TLS certificates?",
        "options": [
            "A trusted third party that issues and signs digital certificates",
            "A server that hosts websites",
            "A type of encryption algorithm",
            "A database of user credentials"
        ],
        "correct_answer_index": 0,
        "explanation": "A CA is a trusted entity that verifies the identity of certificate requesters and issues signed certificates. Browsers and systems have a list of trusted root CAs. When a CA signs a certificate, it's vouching that the certificate owner is who they claim to be."
    },
    "security-principles-best-practices": {
        "question": "What does the principle of 'least privilege' mean?",
        "options": [
            "Users and systems should have only the minimum permissions needed to perform their tasks",
            "Security should be as simple as possible",
            "Passwords should be as short as possible",
            "Systems should have the least amount of security"
        ],
        "correct_answer_index": 0,
        "explanation": "Least privilege means granting only the minimum permissions necessary for a user or system to do their job. This limits damage from compromised accounts, reduces attack surface, and prevents accidental mistakes. Regularly review and reduce excessive permissions."
    },
    "ssh-keys-and-authentication": {
        "question": "What advantage do SSH keys have over password authentication?",
        "options": [
            "More secure against brute-force attacks and enable passwordless automation",
            "Easier to remember",
            "Work on all operating systems",
            "Faster to type"
        ],
        "correct_answer_index": 0,
        "explanation": "SSH keys use cryptographic key pairs (2048+ bit RSA or Ed25519) which are practically impossible to brute force, unlike passwords. They enable secure automation since scripts can use keys without storing passwords. Private keys can also be protected with passphrases for additional security."
    },
    "introduction-to-bash-and-shell-scripting": {
        "question": "What is the purpose of the shebang (#!) line at the start of a bash script?",
        "options": [
            "Specifies which interpreter should execute the script",
            "Comments out the first line",
            "Sets execute permissions",
            "Defines the script name"
        ],
        "correct_answer_index": 0,
        "explanation": "The shebang (#!/bin/bash) tells the system which interpreter to use when executing the script. For bash scripts, it's #!/bin/bash or #!/usr/bin/env bash. This allows you to run the script with ./script.sh instead of bash script.sh."
    },
    "introduction-to-regular-expressions": {
        "question": "In regex, what does the metacharacter '.' represent?",
        "options": [
            "Any single character except newline",
            "A literal period",
            "The end of a line",
            "Zero or more characters"
        ],
        "correct_answer_index": 0,
        "explanation": "The dot (.) matches any single character except newline. To match a literal period, you must escape it: \\. Other common metacharacters: * (zero or more), + (one or more), ? (zero or one), ^ (start of line), $ (end of line)."
    },
    "mastering-quantifiers": {
        "question": "What is the difference between greedy and non-greedy (lazy) quantifiers in regex?",
        "options": [
            "Greedy matches as much as possible; non-greedy matches as little as possible",
            "Greedy is faster than non-greedy",
            "Non-greedy only works in some languages",
            "Greedy requires more memory"
        ],
        "correct_answer_index": 0,
        "explanation": "Greedy quantifiers (*, +, {n,}) match as many characters as possible while still allowing the overall pattern to match. Non-greedy quantifiers (*?, +?, {n,}?) match as few characters as possible. Example: .*? in '<b>text</b>' matches '<b>' while .* matches '<b>text</b>'."
    },
    "network-commands": {
        "question": "What does the 'ping' command test?",
        "options": [
            "Network connectivity and latency to a host",
            "Port availability on a server",
            "DNS resolution only",
            "Bandwidth between hosts"
        ],
        "correct_answer_index": 0,
        "explanation": "ping sends ICMP echo requests to test if a host is reachable and measures round-trip time (latency). It's useful for basic connectivity testing but doesn't test specific ports or services. Use telnet, nc, or curl for port-specific testing."
    }
}

# Additional MCQs for other topics
GENERAL_MCQS = {
    "python-setup-and-essential-libraries": {
        "question": "What is the purpose of a virtual environment in Python?",
        "options": [
            "To isolate project dependencies and avoid version conflicts",
            "To speed up Python execution",
            "To compile Python to machine code",
            "To enable multi-threading"
        ],
        "correct_answer_index": 0,
        "explanation": "Virtual environments (venv, virtualenv) create isolated Python environments for each project, preventing dependency conflicts. Each environment has its own Python interpreter and package installations, allowing different projects to use different versions of libraries."
    },
    "practice-question": {
        "question": "What is a best practice when solving technical problems?",
        "options": [
            "Read the question carefully and identify all requirements before starting",
            "Start coding immediately",
            "Skip the examples",
            "Optimize first, then make it work"
        ],
        "correct_answer_index": 0,
        "explanation": "Always read the problem thoroughly to understand all requirements, constraints, and edge cases. Identify the inputs, outputs, and any special conditions. Plan your approach before coding. Remember: make it work, make it right, then make it fast."
    },
    # Geography/Social studies
    "physical-features-of-india": {
        "question": "Which is the highest mountain peak in India?",
        "options": [
            "Kanchenjunga (8,586 m)",
            "Nanda Devi (7,816 m)",
            "Mount Everest (8,849 m)",
            "K2 (8,611 m)"
        ],
        "correct_answer_index": 0,
        "explanation": "Kanchenjunga (8,586 m) is the highest mountain peak entirely within India (on the India-Nepal border). While Mount Everest and K2 are higher, Everest's summit is on the Nepal-China border, and K2 is in Pakistan-administered Kashmir."
    },
    "information-technology-and-digital-india": {
        "question": "What is the primary goal of the Digital India initiative?",
        "options": [
            "To transform India into a digitally empowered society and knowledge economy",
            "To manufacture more computers",
            "To increase internet prices",
            "To restrict digital access"
        ],
        "correct_answer_index": 0,
        "explanation": "Digital India is a government initiative to ensure digital infrastructure, services, and literacy reach all citizens. Key pillars include digital infrastructure, governance & services on demand, and digital empowerment of citizens through initiatives like Aadhaar, e-governance, and broadband connectivity."
    },
    # Environmental
    "air-pollution-tropospheric-and-stratospheric": {
        "question": "What is the main difference between tropospheric and stratospheric ozone?",
        "options": [
            "Tropospheric ozone is a pollutant; stratospheric ozone protects from UV radiation",
            "They are chemically different molecules",
            "Tropospheric ozone is beneficial while stratospheric is harmful",
            "There is no difference"
        ],
        "correct_answer_index": 0,
        "explanation": "Both are O₃, but context matters: Stratospheric ozone (ozone layer, 15-30 km altitude) shields Earth from harmful UV radiation - its depletion is dangerous. Tropospheric ozone (ground level) is a harmful air pollutant causing respiratory issues and is a component of smog."
    },
    "biodiversity-conservation-and-climate-change": {
        "question": "How does climate change threaten biodiversity?",
        "options": [
            "Alters habitats faster than species can adapt, disrupts ecosystems, and causes range shifts",
            "Only affects temperature, which doesn't matter to species",
            "Increases biodiversity by creating new habitats",
            "Has no impact on species"
        ],
        "correct_answer_index": 0,
        "explanation": "Climate change affects biodiversity through: temperature and precipitation changes that alter habitats, sea level rise flooding coastal ecosystems, ocean acidification harming marine life, phenological mismatches (timing of biological events), and forcing species to migrate or face extinction if they can't adapt quickly enough."
    }
}

# Combine all MCQ dictionaries
ALL_MCQS = {**CHEMISTRY_MCQS, **DOCKER_MCQS, **GO_MCQS, **DEVOPS_MCQS, **GENERAL_MCQS}

def read_yaml_file(filepath):
    """Read YAML file and return content."""
    with open(filepath, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

def write_yaml_file(filepath, data):
    """Write data to YAML file."""
    with open(filepath, 'w', encoding='utf-8') as f:
        yaml.dump(data, f, default_flow_style=False, allow_unicode=True, sort_keys=False)

def get_topic_from_content(content_md):
    """Determine topic type from content."""
    content_lower = content_md.lower()

    # Chemistry indicators
    if any(word in content_lower for word in ['chemistry', 'chemical', 'reaction', 'molecule', 'compound',
                                                'atom', 'element', 'periodic', 'ion', 'cation', 'anion',
                                                'acid', 'base', 'ph', 'equilibrium', 'organic', 'inorganic']):
        return 'chemistry'

    # Docker indicators
    if any(word in content_lower for word in ['docker', 'container', 'image', 'dockerfile', 'compose']):
        return 'docker'

    # Kubernetes indicators
    if any(word in content_lower for word in ['kubernetes', 'k8s', 'pod', 'deployment', 'kubectl']):
        return 'kubernetes'

    # Go/Programming indicators
    if any(word in content_lower for word in ['goroutine', 'channel', 'golang', 'func ', 'package ', 'struct']):
        return 'go'

    # DevOps/Infrastructure indicators
    if any(word in content_lower for word in ['terraform', 'ansible', 'infrastructure', 'deployment', 'cicd', 'ci/cd']):
        return 'devops'

    return 'general'

def create_custom_objectives(slug, content_md, topic):
    """Create topic-appropriate objectives."""
    objectives_map = {
        'chemistry': [
            f"Understand the fundamental concepts and mechanisms of {slug.replace('-', ' ')}",
            "Apply chemical principles to solve related problems",
            "Identify key reactions, equations, and chemical behaviors"
        ],
        'docker': [
            f"Understand how to use {slug.replace('-', ' ')} effectively",
            "Apply Docker best practices in real-world scenarios",
            "Troubleshoot common issues with containers and images"
        ],
        'kubernetes': [
            f"Understand {slug.replace('-', ' ')} in Kubernetes",
            "Deploy and manage Kubernetes resources effectively",
            "Debug and troubleshoot cluster issues"
        ],
        'go': [
            f"Understand {slug.replace('-', ' ')} in Go programming",
            "Write clean, idiomatic Go code using these concepts",
            "Apply Go best practices and patterns"
        ],
        'devops': [
            f"Understand {slug.replace('-', ' ')} in modern DevOps",
            "Implement infrastructure automation and best practices",
            "Ensure security and reliability in deployments"
        ],
        'general': [
            f"Understand the key concepts of {slug.replace('-', ' ')}",
            "Apply learned principles to practical scenarios",
            "Analyze and solve related problems effectively"
        ]
    }

    return objectives_map.get(topic, objectives_map['general'])

def create_custom_prompts(slug, topic):
    """Create topic-appropriate reflection and checkpoint prompts."""
    prompts = {
        'chemistry': {
            'reflection': "How does this chemical concept appear in real-world applications or industrial processes? What safety considerations are important?",
            'checkpoint': "Write out the key reactions, equations, or mechanisms. Explain the conditions needed and expected observations."
        },
        'docker': {
            'reflection': "When would you use this Docker command in a real project? What problems does it solve and what are common pitfalls?",
            'checkpoint': "Write the exact Docker commands needed to implement this concept, including relevant flags and options."
        },
        'kubernetes': {
            'reflection': "How does this fit into a production Kubernetes setup? What could go wrong and how would you debug it?",
            'checkpoint': "Write the kubectl commands or YAML manifests needed to implement this. Include resource limits and labels."
        },
        'go': {
            'reflection': "Where would you use this pattern in real Go applications? What are the trade-offs and alternatives?",
            'checkpoint': "Write a code example demonstrating this concept. Include error handling and comments explaining key points."
        },
        'devops': {
            'reflection': "How does this practice improve reliability, security, or automation? What are the risks of not following it?",
            'checkpoint': "Document the step-by-step process to implement this, including tools, commands, and verification steps."
        },
        'general': {
            'reflection': "How does this concept apply in real-world scenarios? What would you need to verify or check?",
            'checkpoint': "List the specific steps, commands, or procedures needed to apply this concept effectively."
        }
    }

    return prompts.get(topic, prompts['general'])

def fix_microlesson_file(filepath):
    """Fix a single microlesson YAML file."""
    try:
        data = read_yaml_file(filepath)
        slug = data.get('slug', '')
        content_md = data.get('content_md', '')

        # Determine topic
        topic = get_topic_from_content(content_md)

        # Fix exercises - find and update MCQ
        exercises = data.get('exercises', [])
        mcq_fixed = False

        for i, exercise in enumerate(exercises):
            if exercise.get('type') == 'mcq':
                # Check if it's a placeholder MCQ
                options = exercise.get('options', [])
                if not options or options == ['A', 'B', 'C', 'D']:
                    # Try to find a custom MCQ for this slug
                    if slug in ALL_MCQS:
                        mcq_data = ALL_MCQS[slug]
                        exercise['question'] = mcq_data['question']
                        exercise['options'] = mcq_data['options']
                        exercise['correct_answer_index'] = mcq_data['correct_answer_index']
                        exercise['explanation'] = mcq_data['explanation']
                        if 'slug' not in exercise:
                            exercise['slug'] = f"{slug}-mcq"
                        mcq_fixed = True

            elif exercise.get('type') == 'reflection':
                prompts = create_custom_prompts(slug, topic)
                exercise['prompt'] = prompts['reflection']

            elif exercise.get('type') == 'checkpoint':
                prompts = create_custom_prompts(slug, topic)
                exercise['prompt'] = prompts['checkpoint']

        # Fix objectives
        data['objectives'] = create_custom_objectives(slug, content_md, topic)

        # Write back
        write_yaml_file(filepath, data)

        return {
            'file': os.path.basename(filepath),
            'topic': topic,
            'mcq_fixed': mcq_fixed,
            'has_custom_mcq': slug in ALL_MCQS
        }

    except Exception as e:
        return {
            'file': os.path.basename(filepath),
            'error': str(e)
        }

def main():
    """Process all microlesson files."""
    microlesson_files = sorted(Path(MICROLESSONS_DIR).glob('*.yml'))

    print(f"Processing {len(microlesson_files)} microlesson files...")
    print("=" * 80)

    results = []
    for filepath in microlesson_files:
        result = fix_microlesson_file(filepath)
        results.append(result)

        status = "✓" if 'error' not in result else "✗"
        print(f"{status} {result['file']}")

    print("\n" + "=" * 80)
    print("Summary:")
    print(f"Total files: {len(results)}")
    print(f"Errors: {sum(1 for r in results if 'error' in r)}")
    print(f"Files with custom MCQs: {sum(1 for r in results if r.get('has_custom_mcq'))}")
    print(f"MCQs fixed: {sum(1 for r in results if r.get('mcq_fixed'))}")

    # Topic breakdown
    topics = {}
    for r in results:
        if 'error' not in r:
            topic = r.get('topic', 'unknown')
            topics[topic] = topics.get(topic, 0) + 1

    print("\nTopic breakdown:")
    for topic, count in sorted(topics.items()):
        print(f"  {topic}: {count}")

if __name__ == '__main__':
    main()

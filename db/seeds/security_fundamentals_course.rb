# Security Fundamentals Course Seed Data
puts "🔐 Seeding Security Fundamentals Course..."

# ========================================
# COURSE: Security Fundamentals
# ========================================

security_course = Course.find_or_create_by!(slug: "security-fundamentals") do |course|
  course.title = "Security Fundamentals"
  course.description = "Master essential security concepts including TLS, HTTPS, certificates, SSH, and security best practices for modern infrastructure."
  course.difficulty_level = "intermediate"
  course.estimated_hours = 12
  course.certification_track = "security"
  course.published = true
  course.sequence_order = 2
  course.learning_objectives = JSON.generate([
    "Understand cryptography basics and encryption methods",
    "Configure and manage TLS/SSL certificates",
    "Implement secure authentication with SSH keys",
    "Apply security best practices for containers and cloud",
    "Manage secrets and sensitive data securely",
    "Identify and mitigate common security vulnerabilities"
  ])
  course.prerequisites = JSON.generate([
    "Linux Fundamentals course (recommended)",
    "Basic networking knowledge",
    "Command line proficiency"
  ])
end

puts "📦 Created course: #{security_course.title}"

# ========================================
# Module 1: Cryptography & Encryption Basics
# ========================================

module1 = security_course.course_modules.create!(
  title: "Cryptography & Encryption Basics",
  slug: "cryptography-basics",
  description: "Understand fundamental cryptographic concepts and encryption methods",
  sequence_order: 1,
  estimated_minutes: 120,
  published: true,
  learning_objectives: JSON.generate([
    "Understand symmetric and asymmetric encryption",
    "Learn about hashing and data integrity",
    "Explore common cryptographic algorithms",
    "Apply encryption in practical scenarios"
  ])
)

lesson1_1 = CourseLesson.create!(
  title: "Introduction to Cryptography",
  content: <<~MARKDOWN,
    # Introduction to Cryptography

    Cryptography is the foundation of modern security, protecting data in transit and at rest.

    ## Core Concepts

    ### Confidentiality, Integrity, Availability (CIA Triad)
    - **Confidentiality**: Only authorized parties can access data
    - **Integrity**: Data hasn't been tampered with
    - **Availability**: Systems and data are accessible when needed

    ### Types of Cryptography

    ## 1. Symmetric Encryption
    Same key for encryption and decryption.

    **Pros:**
    - Fast and efficient
    - Good for large amounts of data

    **Cons:**
    - Key distribution problem
    - Need secure channel to share key

    **Common Algorithms:**
    - **AES (Advanced Encryption Standard)**: Industry standard, very secure
    - **ChaCha20**: Fast, used in TLS
    - **3DES**: Legacy, being phased out

    ```bash
    # Encrypt file with AES-256
    openssl enc -aes-256-cbc -salt -in file.txt -out file.txt.enc

    # Decrypt file
    openssl enc -d -aes-256-cbc -in file.txt.enc -out file.txt
    ```

    ## 2. Asymmetric Encryption (Public Key Cryptography)
    Uses key pairs: public key (encrypt) and private key (decrypt).

    **Pros:**
    - Solves key distribution problem
    - Enables digital signatures

    **Cons:**
    - Slower than symmetric encryption
    - More computationally expensive

    **Common Algorithms:**
    - **RSA**: Widely used, 2048-bit or 4096-bit
    - **ECDSA**: Elliptic Curve, smaller keys, faster
    - **Ed25519**: Modern, fast, secure

    ## 3. Hashing (One-Way Functions)
    Creates fixed-size fingerprint of data. Cannot be reversed.

    **Use Cases:**
    - Password storage
    - Data integrity verification
    - Digital signatures

    **Common Algorithms:**
    - **SHA-256**: 256-bit hash, very secure
    - **SHA-512**: 512-bit hash, even more secure
    - **bcrypt**: Designed for passwords, includes salt
    - **MD5**: **BROKEN - DO NOT USE**

    ```bash
    # Generate SHA-256 hash
    echo "Hello World" | sha256sum

    # Verify file integrity
    sha256sum file.txt > file.txt.sha256
    sha256sum -c file.txt.sha256
    ```

    ## Practical Applications

    ### Passwords
    **Never store passwords in plain text!**

    ```bash
    # Bad: Storing password directly
    PASSWORD="secret123"

    # Good: Store hashed password with salt
    # System does this automatically with bcrypt/scrypt
    ```

    ### Data at Rest
    Encrypt sensitive files, databases, disk volumes.

    ### Data in Transit
    Use TLS/SSL to encrypt network communication.
  MARKDOWN
  reading_time_minutes: 20,
  key_concepts: JSON.generate([
    "Symmetric vs Asymmetric encryption",
    "Hashing and integrity",
    "AES, RSA, SHA-256",
    "CIA Triad"
  ])
)

module1.module_items.create!(item: lesson1_1, sequence_order: 1, required: true)

lesson1_2 = CourseLesson.create!(
  title: "OpenSSL and Practical Cryptography",
  content: <<~MARKDOWN,
    # OpenSSL and Practical Cryptography

    OpenSSL is a powerful toolkit for cryptographic operations.

    ## Generating Keys

    ### RSA Key Pair
    ```bash
    # Generate private key (2048-bit)
    openssl genrsa -out private.key 2048

    # Extract public key
    openssl rsa -in private.key -pubout -out public.key

    # Generate 4096-bit key (more secure)
    openssl genrsa -out private-4096.key 4096
    ```

    ### Ed25519 Key Pair (Modern, Faster)
    ```bash
    # Generate Ed25519 private key
    openssl genpkey -algorithm Ed25519 -out ed25519-private.key

    # Extract public key
    openssl pkey -in ed25519-private.key -pubout -out ed25519-public.key
    ```

    ## File Encryption

    ### Symmetric Encryption (AES)
    ```bash
    # Encrypt file with password
    openssl enc -aes-256-cbc -salt -pbkdf2 -in secret.txt -out secret.enc

    # Decrypt file
    openssl enc -d -aes-256-cbc -pbkdf2 -in secret.enc -out secret.txt
    ```

    ### Asymmetric Encryption (RSA)
    ```bash
    # Encrypt with public key
    openssl rsautl -encrypt -pubin -inkey public.key -in message.txt -out message.enc

    # Decrypt with private key
    openssl rsautl -decrypt -inkey private.key -in message.enc -out message.txt
    ```

    ## Digital Signatures

    Prove authenticity and integrity of data.

    ```bash
    # Sign file with private key
    openssl dgst -sha256 -sign private.key -out file.sig file.txt

    # Verify signature with public key
    openssl dgst -sha256 -verify public.key -signature file.sig file.txt
    ```

    ## Hashing

    ```bash
    # SHA-256 hash
    sha256sum file.txt

    # Multiple algorithms
    openssl dgst -sha256 file.txt
    openssl dgst -sha512 file.txt

    # Hash password (for demonstration only)
    echo -n "mypassword" | sha256sum
    ```

    ## Base64 Encoding

    Not encryption, but useful for encoding binary data.

    ```bash
    # Encode to base64
    base64 file.bin > file.b64

    # Decode from base64
    base64 -d file.b64 > file.bin

    # Inline encoding
    echo "Hello World" | base64
    echo "SGVsbG8gV29ybGQK" | base64 -d
    ```

    ## Random Data Generation

    ```bash
    # Generate random bytes
    openssl rand -hex 32

    # Generate random password
    openssl rand -base64 24

    # Generate random file
    openssl rand 1024 > random.dat
    ```

    ## Best Practices

    1. **Use Strong Algorithms**: AES-256, RSA-2048+, SHA-256+
    2. **Protect Private Keys**: Never share, use proper permissions (600)
    3. **Use Salt**: Always salt passwords
    4. **Key Rotation**: Rotate keys periodically
    5. **Secure Random**: Use cryptographically secure random generators
  MARKDOWN
  reading_time_minutes: 25
)

module1.module_items.create!(item: lesson1_2, sequence_order: 2, required: true)

quiz1 = Quiz.create!(
  title: "Cryptography Basics Quiz",
  description: "Test your understanding of encryption and cryptography",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true
)

[
  {
    question_type: "mcq",
    question_text: "Which encryption type uses the same key for encryption and decryption?",
    options: JSON.generate([
      { text: "Symmetric encryption", correct: true },
      { text: "Asymmetric encryption", correct: false },
      { text: "Hashing", correct: false },
      { text: "Public key encryption", correct: false }
    ]),
    explanation: "Symmetric encryption uses a single shared key for both encryption and decryption (e.g., AES).",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "mcq",
    question_text: "What is the main purpose of hashing?",
    options: JSON.generate([
      { text: "Data integrity verification", correct: true },
      { text: "Encrypt files", correct: false },
      { text: "Generate encryption keys", correct: false },
      { text: "Compress data", correct: false }
    ]),
    explanation: "Hashing creates a fixed-size fingerprint to verify data hasn't been modified. It's one-way and cannot be reversed.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  },
  {
    question_type: "command",
    question_text: "Generate a SHA-256 hash of a file called data.txt",
    correct_answer: "sha256sum data.txt|openssl dgst -sha256 data.txt",
    explanation: "Use sha256sum or openssl dgst -sha256 to generate SHA-256 hashes",
    points: 15,
    difficulty_level: "medium",
    sequence_order: 3
  },
  {
    question_type: "true_false",
    question_text: "MD5 is secure for password hashing.",
    correct_answer: "false",
    explanation: "MD5 is broken and should never be used for passwords. Use bcrypt, scrypt, or Argon2 instead.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 4
  },
  {
    question_type: "mcq",
    question_text: "Which algorithm is recommended for modern SSH keys?",
    options: JSON.generate([
      { text: "Ed25519", correct: true },
      { text: "DSA", correct: false },
      { text: "MD5", correct: false },
      { text: "DES", correct: false }
    ]),
    explanation: "Ed25519 is modern, fast, and secure. DSA is deprecated, MD5 is broken, DES is obsolete.",
    points: 10,
    difficulty_level: "medium",
    sequence_order: 5
  }
].each { |q| quiz1.quiz_questions.create!(q) }

module1.module_items.create!(item: quiz1, sequence_order: 3, required: true)

puts "  ✅ Created module: #{module1.title}"

# ========================================
# Module 2: TLS/SSL & HTTPS
# ========================================

module2 = security_course.course_modules.create!(
  title: "TLS/SSL & HTTPS",
  slug: "tls-ssl-https",
  description: "Master TLS/SSL certificates, HTTPS, and secure communication",
  sequence_order: 2,
  estimated_minutes: 150,
  published: true,
  learning_objectives: JSON.generate([
    "Understand how TLS/SSL works",
    "Generate and manage certificates",
    "Configure HTTPS servers",
    "Troubleshoot certificate issues"
  ])
)

lesson2_1 = CourseLesson.create!(
  title: "Understanding TLS/SSL",
  content: <<~MARKDOWN,
    # Understanding TLS/SSL

    TLS (Transport Layer Security) encrypts data in transit between clients and servers.

    ## What is TLS?

    **TLS** (formerly SSL) provides:
    - **Encryption**: Data is encrypted in transit
    - **Authentication**: Verify server identity
    - **Integrity**: Detect tampering

    ## TLS Handshake Process

    ```
    Client                                    Server
      |                                         |
      |--- ClientHello (supported ciphers) ---->|
      |                                         |
      |<--- ServerHello (chosen cipher) --------|
      |<--- Certificate (server's cert) --------|
      |<--- ServerHelloDone -------------------|
      |                                         |
      |--- ClientKeyExchange ----------------->|
      |--- ChangeCipherSpec ------------------>|
      |--- Finished -------------------------->|
      |                                         |
      |<--- ChangeCipherSpec ------------------|
      |<--- Finished --------------------------|
      |                                         |
      |<========== Encrypted Data ===========>|
    ```

    ### Steps Explained:

    1. **ClientHello**: Client sends supported TLS versions and cipher suites
    2. **ServerHello**: Server chooses TLS version and cipher
    3. **Certificate**: Server sends its certificate (public key)
    4. **Certificate Verification**: Client validates certificate
    5. **Key Exchange**: Generate shared session key
    6. **Finished**: Both confirm encryption is working
    7. **Encrypted Communication**: All data now encrypted

    ## Certificates

    ### Certificate Components

    - **Subject**: Who the certificate is issued to (domain name)
    - **Issuer**: Who signed the certificate (CA)
    - **Public Key**: Server's public key
    - **Validity Period**: Start and end dates
    - **Signature**: CA's digital signature

    ### Certificate Types

    1. **Self-Signed**: You sign your own certificate
       - ⚠️ Browsers will show warnings
       - ✅ Good for testing/development
       - ✅ Good for internal services

    2. **Certificate Authority (CA) Signed**: Trusted third party
       - ✅ Browsers trust automatically
       - ✅ Required for public websites
       - Examples: Let's Encrypt, DigiCert, Comodo

    3. **Wildcard**: Covers all subdomains
       - `*.example.com` covers `api.example.com`, `www.example.com`

    ## TLS Versions

    - **TLS 1.3**: Current, fastest, most secure ✅
    - **TLS 1.2**: Still widely used, secure ✅
    - **TLS 1.1**: Deprecated ⚠️
    - **TLS 1.0**: Deprecated ⚠️
    - **SSL 3.0**: Broken, do not use ❌
    - **SSL 2.0**: Broken, do not use ❌

    ## Common Ports

    | Protocol | Port | Description |
    |----------|------|-------------|
    | HTTP | 80 | Unencrypted web traffic |
    | HTTPS | 443 | Encrypted web traffic (TLS) |
    | SMTP (TLS) | 587 | Encrypted email submission |
    | IMAP (TLS) | 993 | Encrypted email retrieval |

    ## Certificate Authorities (CAs)

    ### Root CA
    Browsers and operating systems trust a set of root CAs.

    ### Chain of Trust
    ```
    Root CA (trusted by browser)
      └── Intermediate CA
            └── Your Certificate
    ```

    ### Let's Encrypt
    Free, automated certificate authority.

    ```bash
    # Install certbot
    sudo apt install certbot

    # Get certificate for domain
    sudo certbot certonly --standalone -d example.com
    ```

    ## Certificate Pinning

    **Hard-code** expected certificate or public key in application.
    - Extra security against compromised CAs
    - Used in mobile apps, critical services
    - ⚠️ Requires careful key rotation
  MARKDOWN
  reading_time_minutes: 25
)

module2.module_items.create!(item: lesson2_1, sequence_order: 1, required: true)

lesson2_2 = CourseLesson.create!(
  title: "Working with Certificates",
  content: <<~MARKDOWN,
    # Working with Certificates

    ## Generating Self-Signed Certificates

    ### Quick Self-Signed Certificate
    ```bash
    # Generate private key and certificate in one command
    openssl req -x509 -newkey rsa:4096 -nodes \\
      -keyout server.key \\
      -out server.crt \\
      -days 365 \\
      -subj "/CN=localhost"
    ```

    ### Step-by-Step Certificate Generation

    ```bash
    # 1. Generate private key
    openssl genrsa -out server.key 2048

    # 2. Create certificate signing request (CSR)
    openssl req -new -key server.key -out server.csr \\
      -subj "/C=US/ST=CA/L=SF/O=MyOrg/CN=example.com"

    # 3. Self-sign the certificate
    openssl x509 -req -days 365 \\
      -in server.csr \\
      -signkey server.key \\
      -out server.crt
    ```

    ## Inspecting Certificates

    ### View Certificate Details
    ```bash
    # View certificate contents
    openssl x509 -in server.crt -text -noout

    # Check certificate dates
    openssl x509 -in server.crt -noout -dates

    # View subject and issuer
    openssl x509 -in server.crt -noout -subject -issuer

    # Check certificate fingerprint
    openssl x509 -in server.crt -noout -fingerprint -sha256
    ```

    ### View Remote Server Certificate
    ```bash
    # Check server's certificate
    openssl s_client -connect example.com:443 -servername example.com

    # Get certificate expiry
    echo | openssl s_client -connect example.com:443 2>/dev/null | \\
      openssl x509 -noout -dates
    ```

    ## Certificate Formats

    ### PEM (Privacy Enhanced Mail)
    ```
    -----BEGIN CERTIFICATE-----
    Base64 encoded data
    -----END CERTIFICATE-----
    ```
    - Most common format
    - Text-based
    - Extensions: `.pem`, `.crt`, `.cer`, `.key`

    ### DER (Distinguished Encoding Rules)
    - Binary format
    - Extensions: `.der`, `.cer`

    ```bash
    # Convert PEM to DER
    openssl x509 -in cert.pem -outform DER -out cert.der

    # Convert DER to PEM
    openssl x509 -in cert.der -inform DER -out cert.pem
    ```

    ### PKCS#12 / PFX
    - Bundle: certificate + private key + chain
    - Password protected
    - Extension: `.p12`, `.pfx`

    ```bash
    # Create PKCS#12 bundle
    openssl pkcs12 -export \\
      -in server.crt \\
      -inkey server.key \\
      -out server.p12 \\
      -name "My Server Cert"

    # Extract from PKCS#12
    openssl pkcs12 -in server.p12 -out server.pem -nodes
    ```

    ## Testing HTTPS

    ### Using curl
    ```bash
    # Test HTTPS endpoint
    curl https://example.com

    # Show certificate details
    curl -vI https://example.com

    # Ignore certificate validation (testing only!)
    curl -k https://localhost:8443

    # Use specific CA certificate
    curl --cacert custom-ca.crt https://internal.example.com
    ```

    ### Using wget
    ```bash
    # Download over HTTPS
    wget https://example.com/file.txt

    # Ignore certificate (testing only!)
    wget --no-check-certificate https://localhost:8443/file.txt
    ```

    ## Common Certificate Errors

    ### 1. Certificate Expired
    ```
    ERROR: certificate has expired
    ```
    - Certificate validity period has passed
    - Renew certificate

    ### 2. Hostname Mismatch
    ```
    ERROR: certificate subject name does not match target host name
    ```
    - Certificate CN/SAN doesn't match domain
    - Need new certificate for correct domain

    ### 3. Self-Signed Certificate
    ```
    ERROR: self signed certificate
    ```
    - Certificate not signed by trusted CA
    - Add certificate to trust store, or use --insecure (dev only)

    ### 4. Untrusted CA
    ```
    ERROR: unable to get local issuer certificate
    ```
    - Issuing CA not in trust store
    - Add CA certificate to system trust store

    ## Certificate Best Practices

    1. **Use 2048-bit or higher** RSA keys (or Ed25519)
    2. **Keep private keys secure** - never commit to git, use 600 permissions
    3. **Use strong Subject Alternative Names (SANs)** for multiple domains
    4. **Set appropriate validity periods** (90 days recommended with auto-renewal)
    5. **Use Let's Encrypt** for public-facing services
    6. **Monitor expiration dates** - automate renewals
    7. **Use TLS 1.2 or 1.3 only** - disable older versions
  MARKDOWN
  reading_time_minutes: 30
)

module2.module_items.create!(item: lesson2_2, sequence_order: 2, required: true)

quiz2 = Quiz.create!(
  title: "TLS/SSL Quiz",
  description: "Test your knowledge of TLS, certificates, and HTTPS",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "mcq",
    question_text: "What port does HTTPS use by default?",
    options: JSON.generate([
      { text: "443", correct: true },
      { text: "80", correct: false },
      { text: "8080", correct: false },
      { text: "22", correct: false }
    ]),
    explanation: "HTTPS uses port 443 by default. HTTP uses port 80.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "command",
    question_text: "View the details of a certificate file called server.crt",
    correct_answer: "openssl x509 -in server.crt -text -noout",
    explanation: "Use 'openssl x509 -in <file> -text -noout' to view certificate contents",
    points: 15,
    difficulty_level: "medium",
    sequence_order: 2
  },
  {
    question_type: "true_false",
    question_text: "Self-signed certificates are trusted by browsers by default.",
    correct_answer: "false",
    explanation: "Self-signed certificates are not trusted by browsers and will show security warnings. Only CA-signed certificates are trusted by default.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 3
  },
  {
    question_type: "mcq",
    question_text: "Which TLS version is most recommended for production use?",
    options: JSON.generate([
      { text: "TLS 1.3", correct: true },
      { text: "TLS 1.0", correct: false },
      { text: "SSL 3.0", correct: false },
      { text: "SSL 2.0", correct: false }
    ]),
    explanation: "TLS 1.3 is the latest and most secure version. SSL versions are broken and deprecated.",
    points: 10,
    difficulty_level: "medium",
    sequence_order: 4
  }
].each { |q| quiz2.quiz_questions.create!(q) }

module2.module_items.create!(item: quiz2, sequence_order: 3, required: true)

puts "  ✅ Created module: #{module2.title}"

# ========================================
# Module 3: SSH & Key-Based Authentication
# ========================================

module3 = security_course.course_modules.create!(
  title: "SSH & Key-Based Authentication",
  slug: "ssh-key-authentication",
  description: "Master SSH, key-based authentication, and secure remote access",
  sequence_order: 3,
  estimated_minutes: 120,
  published: true,
  learning_objectives: JSON.generate([
    "Generate and manage SSH keys",
    "Configure SSH for secure access",
    "Use SSH agents and key forwarding",
    "Implement security best practices"
  ])
)

lesson3_1 = CourseLesson.create!(
  title: "SSH Keys and Authentication",
  content: <<~MARKDOWN,
    # SSH Keys and Authentication

    SSH (Secure Shell) provides secure remote access using cryptographic keys.

    ## SSH Key Pairs

    ### Public Key
    - Can be shared freely
    - Stored on servers you want to access
    - Located in `~/.ssh/authorized_keys` on server

    ### Private Key
    - **NEVER share this**
    - Stays on your local machine only
    - Located in `~/.ssh/id_rsa` or `~/.ssh/id_ed25519`
    - Permissions must be 600 (read/write for owner only)

    ## Generating SSH Keys

    ### RSA Keys (Traditional)
    ```bash
    # Generate 4096-bit RSA key
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

    # Specify custom filename
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_work
    ```

    ### Ed25519 Keys (Modern, Recommended)
    ```bash
    # Generate Ed25519 key (faster, more secure)
    ssh-keygen -t ed25519 -C "your_email@example.com"

    # With passphrase for extra security
    ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519_secure
    ```

    ### Key Fingerprints
    ```bash
    # View key fingerprint
    ssh-keygen -lf ~/.ssh/id_ed25519.pub

    # View in different format
    ssh-keygen -lf ~/.ssh/id_ed25519.pub -E sha256
    ssh-keygen -lf ~/.ssh/id_ed25519.pub -E md5
    ```

    ## Setting Up Key-Based Authentication

    ### 1. Copy Public Key to Server
    ```bash
    # Using ssh-copy-id (easiest)
    ssh-copy-id user@server.com

    # Using specific key
    ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server.com

    # Manual method
    cat ~/.ssh/id_ed25519.pub | ssh user@server.com "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
    ```

    ### 2. Connect Using Key
    ```bash
    # Connect (uses default key)
    ssh user@server.com

    # Use specific key
    ssh -i ~/.ssh/id_ed25519_work user@server.com
    ```

    ## SSH Configuration

    ### ~/.ssh/config File
    ```
    # Personal server
    Host myserver
        HostName server.example.com
        User john
        IdentityFile ~/.ssh/id_ed25519
        Port 22

    # Work server
    Host work
        HostName gitlab.company.com
        User john.doe
        IdentityFile ~/.ssh/id_ed25519_work
        Port 2222

    # GitHub
    Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519_github
    ```

    Now you can use shortcuts:
    ```bash
    ssh myserver
    ssh work
    git clone git@github.com:user/repo.git
    ```

    ## SSH Agent

    Holds decrypted private keys in memory.

    ```bash
    # Start SSH agent
    eval "$(ssh-agent -s)"

    # Add key to agent
    ssh-add ~/.ssh/id_ed25519

    # Add with timeout (1 hour)
    ssh-add -t 3600 ~/.ssh/id_ed25519

    # List keys in agent
    ssh-add -l

    # Remove all keys from agent
    ssh-add -D
    ```

    ## File Permissions

    **Critical for security!**

    ```bash
    # SSH directory
    chmod 700 ~/.ssh

    # Private keys
    chmod 600 ~/.ssh/id_ed25519
    chmod 600 ~/.ssh/id_rsa

    # Public keys
    chmod 644 ~/.ssh/id_ed25519.pub

    # authorized_keys (on server)
    chmod 600 ~/.ssh/authorized_keys

    # config file
    chmod 600 ~/.ssh/config
    ```

    ## SSH Security Best Practices

    ### 1. Disable Password Authentication
    Edit `/etc/ssh/sshd_config` on server:
    ```
    PasswordAuthentication no
    PubkeyAuthentication yes
    ```

    ### 2. Disable Root Login
    ```
    PermitRootLogin no
    ```

    ### 3. Use Custom Port
    ```
    Port 2222
    ```

    ### 4. Use Strong Keys
    - Prefer Ed25519
    - Minimum RSA 4096-bit
    - Use passphrases on private keys

    ### 5. Limit User Access
    ```
    AllowUsers john jane
    DenyUsers baduser
    ```

    ### 6. Enable Two-Factor Authentication
    ```
    AuthenticationMethods publickey,keyboard-interactive
    ```

    ## Advanced SSH

    ### Port Forwarding (Tunneling)
    ```bash
    # Local port forwarding
    ssh -L 8080:localhost:80 user@server.com

    # Remote port forwarding
    ssh -R 9090:localhost:3000 user@server.com

    # Dynamic port forwarding (SOCKS proxy)
    ssh -D 1080 user@server.com
    ```

    ### Jump Hosts (ProxyJump)
    ```bash
    # Connect through bastion
    ssh -J bastion.example.com target.internal

    # In config:
    Host target
        HostName target.internal
        ProxyJump bastion.example.com
    ```

    ### Keep Alive
    ```bash
    # In ~/.ssh/config
    Host *
        ServerAliveInterval 60
        ServerAliveCountMax 3
    ```

    ### Execute Commands
    ```bash
    # Run single command
    ssh user@server.com "ls -la /var/log"

    # Run multiple commands
    ssh user@server.com "cd /app && ./deploy.sh && systemctl restart app"
    ```
  MARKDOWN
  reading_time_minutes: 35
)

module3.module_items.create!(item: lesson3_1, sequence_order: 1, required: true)

quiz3 = Quiz.create!(
  title: "SSH & Authentication Quiz",
  description: "Test your SSH and key-based authentication knowledge",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "command",
    question_text: "Generate an Ed25519 SSH key with comment 'work@example.com'",
    correct_answer: "ssh-keygen -t ed25519 -C \"work@example.com\"|ssh-keygen -t ed25519 -C 'work@example.com'",
    explanation: "Use ssh-keygen -t ed25519 -C to generate Ed25519 keys with a comment",
    points: 15,
    difficulty_level: "medium",
    sequence_order: 1
  },
  {
    question_type: "mcq",
    question_text: "What permissions should a private SSH key have?",
    options: JSON.generate([
      { text: "600 (read/write for owner only)", correct: true },
      { text: "644 (read for everyone)", correct: false },
      { text: "777 (full permissions)", correct: false },
      { text: "755 (executable)", correct: false }
    ]),
    explanation: "Private keys must be 600 (chmod 600) - readable and writable only by the owner for security.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  },
  {
    question_type: "true_false",
    question_text: "Private keys should be shared with servers you want to access.",
    correct_answer: "false",
    explanation: "NEVER share private keys! Only public keys (.pub) should be shared. Private keys stay on your local machine.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 3
  }
].each { |q| quiz3.quiz_questions.create!(q) }

module3.module_items.create!(item: quiz3, sequence_order: 2, required: true)

puts "  ✅ Created module: #{module3.title}"

# ========================================
# Module 4: Secrets Management
# ========================================

module4 = security_course.course_modules.create!(
  title: "Secrets Management",
  slug: "secrets-management",
  description: "Learn to securely manage secrets, API keys, and sensitive configuration",
  sequence_order: 4,
  estimated_minutes: 90,
  published: true,
  learning_objectives: JSON.generate([
    "Understand secrets management principles",
    "Use environment variables securely",
    "Apply secrets best practices",
    "Explore secrets management tools"
  ])
)

lesson4_1 = CourseLesson.create!(
  title: "Managing Secrets Securely",
  content: <<~MARKDOWN,
    # Managing Secrets Securely

    Secrets include passwords, API keys, tokens, certificates - anything that grants access.

    ## Common Mistakes ❌

    ### 1. Hardcoding Secrets
    ```python
    # BAD - Never do this!
    API_KEY = "sk_live_abc123xyz789"
    DATABASE_URL = "postgres://user:password@host/db"
    ```

    ### 2. Committing Secrets to Git
    ```bash
    # BAD - Secrets in repository
    git add config.json
    git commit -m "Add API keys"  # Now in git history forever!
    ```

    ### 3. Logging Secrets
    ```bash
    # BAD - Secrets in logs
    echo "Connecting with password: $DB_PASSWORD"
    ```

    ### 4. Sharing Secrets via Email/Chat
    Insecure channels = compromised secrets.

    ## Environment Variables

    ### Setting Environment Variables
    ```bash
    # Temporary (current session only)
    export DATABASE_URL="postgres://localhost/mydb"
    export API_KEY="secret_key_here"

    # In application
    python app.py
    ```

    ### .env Files
    ```bash
    # .env file (NEVER commit this!)
    DATABASE_URL=postgres://user:pass@localhost/db
    API_KEY=sk_live_abc123
    STRIPE_SECRET=sk_test_xyz789
    JWT_SECRET=my_super_secret_key
    ```

    **Always add .env to .gitignore:**
    ```bash
    echo ".env" >> .gitignore
    ```

    ### .env.example Template
    ```bash
    # .env.example (safe to commit)
    DATABASE_URL=postgres://user:password@localhost/dbname
    API_KEY=your_api_key_here
    STRIPE_SECRET=your_stripe_secret_key
    JWT_SECRET=generate_a_random_secret
    ```

    ## Docker Secrets

    ### Environment Variables in Docker
    ```bash
    # Pass at runtime
    docker run -e DATABASE_URL="postgres://..." myapp

    # From .env file
    docker run --env-file .env myapp
    ```

    ### Docker Compose
    ```yaml
    version: '3.8'
    services:
      app:
        image: myapp
        environment:
          - DATABASE_URL=${DATABASE_URL}
          - API_KEY=${API_KEY}
        # Or use env_file
        env_file:
          - .env
    ```

    ### Docker Swarm Secrets
    ```bash
    # Create secret
    echo "my_secret_password" | docker secret create db_password -

    # Use in service
    docker service create \\
      --name myapp \\
      --secret db_password \\
      myimage

    # Access in container: /run/secrets/db_password
    ```

    ## Kubernetes Secrets

    ### Create Secret
    ```bash
    # From literal
    kubectl create secret generic db-creds \\
      --from-literal=username=admin \\
      --from-literal=password=secret123

    # From file
    kubectl create secret generic api-keys \\
      --from-file=api-key.txt

    # From .env file
    kubectl create secret generic app-secrets --from-env-file=.env
    ```

    ### Use Secret in Pod
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: myapp
    spec:
      containers:
      - name: app
        image: myapp:latest
        env:
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-creds
              key: password
        volumeMounts:
        - name: secrets-volume
          mountPath: /etc/secrets
          readOnly: true
      volumes:
      - name: secrets-volume
        secret:
          secretName: api-keys
    ```

    ## Secrets Management Tools

    ### HashiCorp Vault
    Industry standard for secrets management.

    ```bash
    # Start Vault dev server
    vault server -dev

    # Store secret
    vault kv put secret/myapp/db password="secret123" username="admin"

    # Read secret
    vault kv get secret/myapp/db

    # Use in application
    export VAULT_ADDR='http://127.0.0.1:8200'
    export VAULT_TOKEN='dev-token'
    vault kv get -field=password secret/myapp/db
    ```

    ### AWS Secrets Manager
    ```bash
    # Store secret
    aws secretsmanager create-secret \\
      --name myapp/db \\
      --secret-string '{"username":"admin","password":"secret"}'

    # Retrieve secret
    aws secretsmanager get-secret-value --secret-id myapp/db
    ```

    ### Azure Key Vault
    ```bash
    # Create secret
    az keyvault secret set \\
      --vault-name myvault \\
      --name db-password \\
      --value "secret123"

    # Get secret
    az keyvault secret show --vault-name myvault --name db-password
    ```

    ## Best Practices

    ### 1. Never Commit Secrets
    - Use .gitignore for .env files
    - Scan repos: `git-secrets`, `truffleHog`
    - Use pre-commit hooks

    ### 2. Rotate Secrets Regularly
    - API keys: every 90 days
    - Passwords: every 60-90 days
    - Certificates: before expiry

    ### 3. Principle of Least Privilege
    - Grant minimum permissions needed
    - Separate dev/staging/prod secrets
    - Use service accounts, not personal credentials

    ### 4. Encrypt at Rest
    - Database encryption
    - Encrypted filesystems
    - Secrets encrypted in etcd (Kubernetes)

    ### 5. Audit Access
    - Log who accessed which secrets
    - Monitor for anomalies
    - Set up alerts for unauthorized access

    ### 6. Use Secure Channels
    - Share secrets via encrypted tools
    - Use password managers (1Password, LastPass, Bitwarden)
    - Never email/Slack secrets in plain text

    ## Emergency Response

    ### If Secret is Compromised:
    1. **Rotate immediately** - generate new secret
    2. **Revoke old secret** - invalidate compromised credential
    3. **Audit access** - check who used the secret
    4. **Update all systems** - deploy new secret
    5. **Investigate** - how was it compromised?
    6. **Document** - post-mortem, lessons learned
  MARKDOWN
  reading_time_minutes: 30
)

module4.module_items.create!(item: lesson4_1, sequence_order: 1, required: true)

quiz4 = Quiz.create!(
  title: "Secrets Management Quiz",
  description: "Test your secrets management knowledge",
  time_limit_minutes: 10,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "true_false",
    question_text: "It's safe to commit .env files to git repositories.",
    correct_answer: "false",
    explanation: ".env files contain secrets and should NEVER be committed. Always add .env to .gitignore.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "mcq",
    question_text: "What is the recommended rotation period for API keys?",
    options: JSON.generate([
      { text: "Every 90 days", correct: true },
      { text: "Never", correct: false },
      { text: "Every 5 years", correct: false },
      { text: "Only when compromised", correct: false }
    ]),
    explanation: "API keys should be rotated regularly, typically every 90 days, as a security best practice.",
    points: 10,
    difficulty_level: "medium",
    sequence_order: 2
  }
].each { |q| quiz4.quiz_questions.create!(q) }

module4.module_items.create!(item: quiz4, sequence_order: 2, required: true)

puts "  ✅ Created module: #{module4.title}"

# ========================================
# Module 5: Security Best Practices
# ========================================

module5 = security_course.course_modules.create!(
  title: "Security Best Practices",
  slug: "security-best-practices",
  description: "Learn security hardening, vulnerability scanning, and defense in depth",
  sequence_order: 5,
  estimated_minutes: 120,
  published: true,
  learning_objectives: JSON.generate([
    "Apply principle of least privilege",
    "Understand common vulnerabilities",
    "Implement defense in depth",
    "Perform security scanning"
  ])
)

lesson5_1 = CourseLesson.create!(
  title: "Security Principles & Best Practices",
  content: <<~MARKDOWN,
    # Security Principles & Best Practices

    ## Core Security Principles

    ### 1. Defense in Depth
    Multiple layers of security controls.

    **Example Stack:**
    - **Network**: Firewalls, VPNs
    - **Host**: Hardened OS, antivirus
    - **Application**: Input validation, authentication
    - **Data**: Encryption at rest and in transit

    ### 2. Principle of Least Privilege
    Grant minimum permissions required.

    ```bash
    # BAD - Running as root
    docker run --user root myapp

    # GOOD - Non-root user
    docker run --user 1000:1000 myapp
    ```

    ### 3. Zero Trust
    "Never trust, always verify"
    - Verify every request
    - Assume breach
    - Micro-segmentation

    ### 4. Fail Securely
    Errors should not expose sensitive data.

    ```python
    # BAD - Leaks information
    except Exception as e:
        return f"Database error: {str(e)}"

    # GOOD - Generic error
    except Exception as e:
        logger.error(f"Database error: {str(e)}")
        return "An error occurred. Please try again."
    ```

    ## Common Vulnerabilities (OWASP Top 10)

    ### 1. Injection (SQL, Command, etc.)
    ```python
    # BAD - SQL Injection vulnerable
    query = f"SELECT * FROM users WHERE username='{username}'"

    # GOOD - Parameterized query
    query = "SELECT * FROM users WHERE username=%s"
    cursor.execute(query, (username,))
    ```

    ### 2. Broken Authentication
    - Weak passwords
    - No MFA
    - Session hijacking

    **Mitigations:**
    - Enforce strong passwords
    - Implement MFA
    - Use secure session management
    - Rate limiting on login

    ### 3. Sensitive Data Exposure
    - Unencrypted data in transit
    - Weak encryption
    - Exposed secrets

    **Mitigations:**
    - Use TLS everywhere
    - Encrypt data at rest
    - Use strong algorithms (AES-256)

    ### 4. XML External Entities (XXE)
    Disable external entity processing in XML parsers.

    ### 5. Broken Access Control
    ```python
    # BAD - No authorization check
    @app.route('/user/<id>')
    def get_user(id):
        return User.get(id)

    # GOOD - Verify ownership
    @app.route('/user/<id>')
    @login_required
    def get_user(id):
        if current_user.id != id and not current_user.is_admin:
            abort(403)
        return User.get(id)
    ```

    ### 6. Security Misconfiguration
    - Default credentials
    - Unnecessary services enabled
    - Verbose error messages

    ### 7. Cross-Site Scripting (XSS)
    ```html
    <!-- BAD - Unsanitized input -->
    <div>${user_input}</div>

    <!-- GOOD - Escaped/sanitized -->
    <div>${escape(user_input)}</div>
    ```

    ### 8. Insecure Deserialization
    Don't deserialize untrusted data.

    ### 9. Using Components with Known Vulnerabilities
    ```bash
    # Scan for vulnerabilities
    npm audit
    pip-audit
    snyk test
    ```

    ### 10. Insufficient Logging & Monitoring
    - Log security events
    - Monitor for anomalies
    - Set up alerts

    ## Container Security

    ### 1. Use Official Images
    ```dockerfile
    # GOOD - Official base image
    FROM node:18-alpine

    # BAD - Random image
    FROM random-user/node-maybe
    ```

    ### 2. Run as Non-Root
    ```dockerfile
    FROM node:18-alpine

    # Create non-root user
    RUN addgroup -g 1000 appuser && \\
        adduser -D -u 1000 -G appuser appuser

    USER appuser

    WORKDIR /app
    COPY --chown=appuser:appuser . .

    CMD ["node", "server.js"]
    ```

    ### 3. Scan Images
    ```bash
    # Scan for vulnerabilities
    docker scan myimage:latest

    # Using Trivy
    trivy image myimage:latest

    # Using Anchore
    anchore-cli image scan myimage:latest
    ```

    ### 4. Minimal Base Images
    ```dockerfile
    # Smaller attack surface
    FROM alpine:3.18
    FROM gcr.io/distroless/nodejs:18
    ```

    ### 5. Read-Only Filesystem
    ```bash
    docker run --read-only --tmpfs /tmp myapp
    ```

    ### 6. Drop Capabilities
    ```bash
    docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE myapp
    ```

    ## Network Security

    ### Firewalls
    ```bash
    # List firewall rules (ufw)
    sudo ufw status

    # Allow specific port
    sudo ufw allow 22/tcp
    sudo ufw allow 443/tcp

    # Deny port
    sudo ufw deny 3306/tcp

    # Enable firewall
    sudo ufw enable
    ```

    ### Port Scanning
    ```bash
    # Scan your own systems only!
    nmap -sV localhost
    nmap -p 1-1000 192.168.1.1
    ```

    ## Security Scanning

    ### Dependency Scanning
    ```bash
    # Node.js
    npm audit
    npm audit fix

    # Python
    pip-audit
    safety check

    # Ruby
    bundle audit
    ```

    ### Static Analysis
    ```bash
    # Bandit (Python)
    bandit -r ./src

    # Semgrep (multi-language)
    semgrep --config=auto .

    # SonarQube
    sonar-scanner
    ```

    ### Secret Scanning
    ```bash
    # TruffleHog
    trufflehog git https://github.com/user/repo

    # git-secrets
    git secrets --scan

    # gitleaks
    gitleaks detect --source .
    ```

    ## Monitoring & Logging

    ### What to Log
    - Authentication attempts (success/failure)
    - Authorization failures
    - Input validation failures
    - Security exceptions
    - Admin actions

    ### What NOT to Log
    - Passwords
    - Session tokens
    - Credit card numbers
    - Personal data (PII)

    ### Log Analysis
    ```bash
    # Check failed SSH attempts
    grep "Failed password" /var/log/auth.log

    # Monitor logs in real-time
    tail -f /var/log/app.log

    # Count unique IPs
    awk '{print $1}' access.log | sort | uniq -c | sort -rn
    ```

    ## Security Checklist

    - [ ] All traffic uses HTTPS/TLS
    - [ ] Secrets not in source code or logs
    - [ ] Strong authentication (MFA enabled)
    - [ ] Authorization checks on all endpoints
    - [ ] Input validation on all user input
    - [ ] Security headers configured
    - [ ] Dependencies up to date
    - [ ] Security scanning in CI/CD
    - [ ] Logs collected and monitored
    - [ ] Incident response plan documented
    - [ ] Regular backups tested
    - [ ] Containers run as non-root
    - [ ] Firewall configured
    - [ ] Rate limiting enabled
    - [ ] Security training for team
  MARKDOWN
  reading_time_minutes: 40
)

module5.module_items.create!(item: lesson5_1, sequence_order: 1, required: true)

quiz5 = Quiz.create!(
  title: "Security Best Practices Quiz",
  description: "Test your security best practices knowledge",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "mcq",
    question_text: "Which principle states to grant minimum permissions required?",
    options: JSON.generate([
      { text: "Principle of Least Privilege", correct: true },
      { text: "Defense in Depth", correct: false },
      { text: "Zero Trust", correct: false },
      { text: "Fail Securely", correct: false }
    ]),
    explanation: "Principle of Least Privilege means granting only the minimum permissions necessary to perform a task.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "true_false",
    question_text: "Containers should run as root for better performance.",
    correct_answer: "false",
    explanation: "Containers should NEVER run as root. Always use non-root users for security.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  },
  {
    question_type: "mcq",
    question_text: "Which tool can scan Docker images for vulnerabilities?",
    options: JSON.generate([
      { text: "Trivy", correct: true },
      { text: "grep", correct: false },
      { text: "curl", correct: false },
      { text: "wget", correct: false }
    ]),
    explanation: "Trivy is a popular vulnerability scanner for container images. Others include docker scan, Anchore, and Clair.",
    points: 10,
    difficulty_level: "medium",
    sequence_order: 3
  }
].each { |q| quiz5.quiz_questions.create!(q) }

module5.module_items.create!(item: quiz5, sequence_order: 2, required: true)

puts "  ✅ Created module: #{module5.title}"

# ========================================
# Summary
# ========================================

puts "\n✅ Security Fundamentals Course Seeding Complete!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{security_course.title}"
puts "📖 Modules: #{security_course.course_modules.count}"
puts "📝 Lessons: #{CourseLesson.where(id: security_course.course_modules.flat_map { |m| m.module_items.where(item_type: 'CourseLesson').pluck(:item_id) }).count}"
puts "❓ Quizzes: #{Quiz.where(id: security_course.course_modules.flat_map { |m| m.module_items.where(item_type: 'Quiz').pluck(:item_id) }).count}"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

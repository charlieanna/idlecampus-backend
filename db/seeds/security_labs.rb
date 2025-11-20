# Security Fundamentals - Hands-On Labs
puts "🔐 Seeding Security Fundamentals Labs..."

security_course = Course.find_by(slug: 'security-fundamentals')

unless security_course
  puts "⚠️  Security Fundamentals course not found. Run security_fundamentals_course.rb first."
  exit
end

# ========================================
# LAB 1: Cryptography & Encryption Basics
# ========================================

lab1 = HandsOnLab.find_or_create_by!(title: "Security Lab 1: Cryptography Basics") do |lab|
  lab.description = "Practice encryption, hashing, and key generation using OpenSSL"
  lab.difficulty = "intermediate"
  lab.estimated_minutes = 35
  lab.prerequisites = [
    "OpenSSL installed",
    "Understanding of encryption concepts"
  ]
  lab.objectives = [
    "Generate and use RSA and Ed25519 keys",
    "Encrypt and decrypt files with symmetric and asymmetric encryption",
    "Create and verify hashes",
    "Sign and verify digital signatures"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Generate RSA key pair",
      instruction: "Generate a 2048-bit RSA private key named 'my-rsa.key'",
      expected_output: "Private key file created",
      hints: ["Use openssl genrsa", "Specify output with -out", "Key size comes last"]
    },
    {
      step_number: 2,
      title: "Extract public key from RSA private key",
      instruction: "Extract the public key from my-rsa.key and save it as my-rsa-public.key",
      expected_output: "Public key extracted",
      hints: ["Use openssl rsa", "-in for input, -pubout for public key", "-out for output file"]
    },
    {
      step_number: 3,
      title: "Create a secret message",
      instruction: "Create a file called secret.txt with the text 'This is my secret message'",
      expected_output: "File created with secret message",
      hints: ["Use echo with redirection", "echo 'text' > file.txt"]
    },
    {
      step_number: 4,
      title: "Encrypt with symmetric encryption (AES-256)",
      instruction: "Encrypt secret.txt using AES-256-CBC and save as secret.enc. Use password-based encryption.",
      expected_output: "Encrypted file created, password prompted",
      hints: ["openssl enc -aes-256-cbc", "Use -salt and -pbkdf2", "-in secret.txt -out secret.enc"]
    },
    {
      step_number: 5,
      title: "Decrypt the encrypted file",
      instruction: "Decrypt secret.enc back to a new file called decrypted.txt",
      expected_output: "Original message recovered",
      hints: ["Use -d flag for decrypt", "Same password as encryption", "openssl enc -d -aes-256-cbc"]
    },
    {
      step_number: 6,
      title: "Create SHA-256 hash",
      instruction: "Generate a SHA-256 hash of secret.txt",
      expected_output: "256-bit hexadecimal hash displayed",
      hints: ["Use sha256sum command", "Or openssl dgst -sha256"]
    },
    {
      step_number: 7,
      title: "Verify file integrity with hash",
      instruction: "Save the hash to secret.txt.sha256, then verify the file hasn't been modified",
      expected_output: "Verification shows file is OK",
      hints: ["sha256sum secret.txt > secret.txt.sha256", "sha256sum -c secret.txt.sha256 to verify"]
    },
    {
      step_number: 8,
      title: "Create digital signature",
      instruction: "Sign secret.txt using your RSA private key and save signature as secret.sig",
      expected_output: "Digital signature created",
      hints: ["openssl dgst -sha256 -sign", "Use my-rsa.key as signing key", "-out secret.sig"]
    },
    {
      step_number: 9,
      title: "Verify digital signature",
      instruction: "Verify the signature using the public key",
      expected_output: "Verified OK",
      hints: ["openssl dgst -sha256 -verify", "Use my-rsa-public.key", "-signature secret.sig"]
    },
    {
      step_number: 10,
      title: "Generate random password",
      instruction: "Generate a random 32-character base64-encoded password",
      expected_output: "Random password string displayed",
      hints: ["openssl rand -base64 24", "Base64 encoding expands size, so 24 bytes gives ~32 chars"]
    }
  ]
  lab.validation_commands = [
    "ls my-rsa.key my-rsa-public.key",
    "cat secret.txt",
    "sha256sum secret.txt",
    "openssl dgst -sha256 -verify my-rsa-public.key -signature secret.sig secret.txt"
  ]
  lab.hints = [
    "OpenSSL is your Swiss Army knife for cryptography",
    "Always protect private keys with proper permissions (chmod 600)",
    "Hashing is one-way; encryption is two-way",
    "Digital signatures prove authenticity and integrity"
  ]
  lab.solution = <<~SOLUTION
    # Solution:
    openssl genrsa -out my-rsa.key 2048
    openssl rsa -in my-rsa.key -pubout -out my-rsa-public.key
    echo 'This is my secret message' > secret.txt
    openssl enc -aes-256-cbc -salt -pbkdf2 -in secret.txt -out secret.enc
    openssl enc -d -aes-256-cbc -pbkdf2 -in secret.enc -out decrypted.txt
    sha256sum secret.txt
    sha256sum secret.txt > secret.txt.sha256
    sha256sum -c secret.txt.sha256
    openssl dgst -sha256 -sign my-rsa.key -out secret.sig secret.txt
    openssl dgst -sha256 -verify my-rsa-public.key -signature secret.sig secret.txt
    openssl rand -base64 24
  SOLUTION
end

puts "  ✅ Created lab: #{lab1.title}"

# ========================================
# LAB 2: TLS/SSL Certificates
# ========================================

lab2 = HandsOnLab.find_or_create_by!(title: "Security Lab 2: TLS/SSL Certificates") do |lab|
  lab.description = "Generate self-signed certificates, inspect certificates, and test HTTPS"
  lab.difficulty = "intermediate"
  lab.estimated_minutes = 30
  lab.prerequisites = [
    "OpenSSL installed",
    "Understanding of TLS/SSL concepts"
  ]
  lab.objectives = [
    "Generate self-signed TLS certificates",
    "Inspect certificate details",
    "Understand certificate chains",
    "Test HTTPS connections"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Generate self-signed certificate (one command)",
      instruction: "Create a self-signed certificate and private key for localhost, valid for 365 days. Save as server.key and server.crt",
      expected_output: "Private key and certificate created",
      hints: ["openssl req -x509 -newkey rsa:4096 -nodes", "-keyout server.key -out server.crt", "-days 365 -subj '/CN=localhost'"]
    },
    {
      step_number: 2,
      title: "Set proper permissions",
      instruction: "Set the private key to be readable only by owner (600 permissions)",
      expected_output: "Permissions changed to 600",
      hints: ["chmod 600 server.key", "Private keys should never be world-readable"]
    },
    {
      step_number: 3,
      title: "View certificate details",
      instruction: "Display the full details of server.crt in text format",
      expected_output: "Certificate details including subject, issuer, validity dates",
      hints: ["openssl x509 -in server.crt -text -noout", "-text shows full details", "-noout suppresses the encoded output"]
    },
    {
      step_number: 4,
      title: "Check certificate validity period",
      instruction: "Display only the validity dates (notBefore and notAfter) of the certificate",
      expected_output: "Start and end dates of certificate validity",
      hints: ["openssl x509 -in server.crt -noout -dates", "-dates shows validity period"]
    },
    {
      step_number: 5,
      title: "Extract subject and issuer",
      instruction: "Show the subject (who the cert is for) and issuer (who signed it)",
      expected_output: "Subject and Issuer displayed (should both be CN=localhost for self-signed)",
      hints: ["openssl x509 -in server.crt -noout -subject -issuer", "For self-signed, subject == issuer"]
    },
    {
      step_number: 6,
      title: "Get certificate fingerprint",
      instruction: "Generate SHA-256 fingerprint of the certificate",
      expected_output: "SHA-256 fingerprint hash",
      hints: ["openssl x509 -in server.crt -noout -fingerprint -sha256", "Fingerprints uniquely identify certificates"]
    },
    {
      step_number: 7,
      title: "Test remote HTTPS certificate",
      instruction: "View the certificate from https://example.com (port 443)",
      expected_output: "Certificate chain and details from example.com",
      hints: ["openssl s_client -connect example.com:443 -servername example.com", "Press Ctrl+C after connection", "Use </dev/null to auto-exit"]
    },
    {
      step_number: 8,
      title: "Check certificate expiry for remote site",
      instruction: "Get the expiration date of https://google.com certificate",
      expected_output: "Certificate validity dates",
      hints: ["echo | openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates", "Pipeline: connect, extract cert, show dates"]
    },
    {
      step_number: 9,
      title: "Convert certificate format (PEM to DER)",
      instruction: "Convert server.crt from PEM format to DER format, save as server.der",
      expected_output: "Binary DER format certificate created",
      hints: ["openssl x509 -in server.crt -outform DER -out server.der", "DER is binary, PEM is text-based"]
    },
    {
      step_number: 10,
      title: "Create certificate bundle (PKCS#12)",
      instruction: "Combine server.key and server.crt into a PKCS#12 bundle called server.p12 with name 'My Server'",
      expected_output: "PKCS#12 file created, password prompted",
      hints: ["openssl pkcs12 -export -in server.crt -inkey server.key", "-out server.p12 -name 'My Server'", "You'll be prompted for export password"]
    }
  ]
  lab.validation_commands = [
    "ls -l server.key server.crt",
    "openssl x509 -in server.crt -noout -subject",
    "stat -c '%a' server.key",
    "ls server.der server.p12"
  ]
  lab.hints = [
    "Self-signed certificates work for testing but browsers will warn users",
    "Production sites need CA-signed certificates (Let's Encrypt is free)",
    "Always keep private keys secure with 600 permissions",
    "Certificate fingerprints are useful for pinning"
  ]
  lab.solution = <<~SOLUTION
    # Solution:
    openssl req -x509 -newkey rsa:4096 -nodes -keyout server.key -out server.crt -days 365 -subj "/CN=localhost"
    chmod 600 server.key
    openssl x509 -in server.crt -text -noout
    openssl x509 -in server.crt -noout -dates
    openssl x509 -in server.crt -noout -subject -issuer
    openssl x509 -in server.crt -noout -fingerprint -sha256
    echo | openssl s_client -connect example.com:443 -servername example.com 2>/dev/null | head -30
    echo | openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates
    openssl x509 -in server.crt -outform DER -out server.der
    openssl pkcs12 -export -in server.crt -inkey server.key -out server.p12 -name "My Server"
  SOLUTION
end

puts "  ✅ Created lab: #{lab2.title}"

# ========================================
# LAB 3: SSH Key Management
# ========================================

lab3 = HandsOnLab.find_or_create_by!(title: "Security Lab 3: SSH Key Management") do |lab|
  lab.description = "Generate SSH keys, configure SSH, and practice secure authentication"
  lab.difficulty = "beginner"
  lab.estimated_minutes = 25
  lab.prerequisites = [
    "SSH client installed",
    "Basic Linux command line skills"
  ]
  lab.objectives = [
    "Generate different types of SSH keys",
    "Configure SSH client settings",
    "Set proper file permissions",
    "Use SSH agent"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Generate Ed25519 SSH key",
      instruction: "Generate an Ed25519 SSH key pair with comment 'test@example.com' and save to ~/.ssh/test_ed25519",
      expected_output: "Key pair generated",
      hints: ["ssh-keygen -t ed25519", "-C for comment", "-f to specify filename"]
    },
    {
      step_number: 2,
      title: "Generate RSA SSH key",
      instruction: "Generate a 4096-bit RSA key with comment 'work@example.com' and save to ~/.ssh/test_rsa",
      expected_output: "4096-bit RSA key pair generated",
      hints: ["ssh-keygen -t rsa -b 4096", "-b specifies bit size", "-C for comment"]
    },
    {
      step_number: 3,
      title: "List your SSH keys",
      instruction: "List all files in the ~/.ssh directory to see your keys",
      expected_output: "List showing test_ed25519, test_ed25519.pub, test_rsa, test_rsa.pub",
      hints: ["ls -la ~/.ssh/", "Private keys have no extension, public keys have .pub"]
    },
    {
      step_number: 4,
      title: "Check private key permissions",
      instruction: "Display the permissions of your Ed25519 private key",
      expected_output: "Should show 600 or -rw------- permissions",
      hints: ["ls -l ~/.ssh/test_ed25519", "ssh-keygen sets 600 by default"]
    },
    {
      step_number: 5,
      title: "View public key",
      instruction: "Display the contents of your Ed25519 public key",
      expected_output: "Public key starting with 'ssh-ed25519' and ending with your comment",
      hints: ["cat ~/.ssh/test_ed25519.pub", "Public keys are safe to share"]
    },
    {
      step_number: 6,
      title: "Get key fingerprint",
      instruction: "Display the SHA256 fingerprint of your Ed25519 key",
      expected_output: "Fingerprint hash displayed",
      hints: ["ssh-keygen -lf ~/.ssh/test_ed25519.pub", "-l shows fingerprint", "-f specifies file"]
    },
    {
      step_number: 7,
      title: "Create SSH config",
      instruction: "Create an SSH config file at ~/.ssh/config with a host entry for 'testserver' pointing to example.com with user 'testuser' and your Ed25519 key",
      expected_output: "Config file created",
      hints: ["Create ~/.ssh/config with a text editor or echo", "Format: Host testserver\\n  HostName example.com\\n  User testuser\\n  IdentityFile ~/.ssh/test_ed25519"]
    },
    {
      step_number: 8,
      title: "Set config file permissions",
      instruction: "Set ~/.ssh/config to 600 permissions",
      expected_output: "Permissions set to 600",
      hints: ["chmod 600 ~/.ssh/config", "SSH requires strict permissions on config"]
    },
    {
      step_number: 9,
      title: "Start SSH agent",
      instruction: "Start the SSH agent and display the process",
      expected_output: "SSH agent started, environment variables set",
      hints: ["eval $(ssh-agent -s)", "Sets SSH_AUTH_SOCK and SSH_AGENT_PID"]
    },
    {
      step_number: 10,
      title: "Add key to SSH agent",
      instruction: "Add your Ed25519 key to the SSH agent",
      expected_output: "Identity added confirmation",
      hints: ["ssh-add ~/.ssh/test_ed25519", "Agent holds decrypted keys in memory"]
    },
    {
      step_number: 11,
      title: "List keys in agent",
      instruction: "Display all keys currently loaded in the SSH agent",
      expected_output: "List showing your Ed25519 key fingerprint",
      hints: ["ssh-add -l", "-l lists keys", "-L would show full public keys"]
    }
  ]
  lab.validation_commands = [
    "ls ~/.ssh/test_ed25519 ~/.ssh/test_ed25519.pub",
    "stat -c '%a' ~/.ssh/test_ed25519",
    "ssh-keygen -lf ~/.ssh/test_ed25519.pub",
    "cat ~/.ssh/config"
  ]
  lab.hints = [
    "Ed25519 keys are smaller and faster than RSA",
    "Private keys must be 600, public keys can be 644",
    "SSH agent prevents entering passphrase repeatedly",
    "Never share private keys, only public keys"
  ]
  lab.solution = <<~SOLUTION
    # Solution:
    ssh-keygen -t ed25519 -C "test@example.com" -f ~/.ssh/test_ed25519
    ssh-keygen -t rsa -b 4096 -C "work@example.com" -f ~/.ssh/test_rsa
    ls -la ~/.ssh/
    ls -l ~/.ssh/test_ed25519
    cat ~/.ssh/test_ed25519.pub
    ssh-keygen -lf ~/.ssh/test_ed25519.pub
    cat > ~/.ssh/config <<EOF
    Host testserver
        HostName example.com
        User testuser
        IdentityFile ~/.ssh/test_ed25519
    EOF
    chmod 600 ~/.ssh/config
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/test_ed25519
    ssh-add -l
  SOLUTION
end

puts "  ✅ Created lab: #{lab3.title}"

# ========================================
# LAB 4: Secrets Management Practice
# ========================================

lab4 = HandsOnLab.find_or_create_by!(title: "Security Lab 4: Secrets Management") do |lab|
  lab.description = "Practice secure secrets management with environment variables and files"
  lab.difficulty = "beginner"
  lab.estimated_minutes = 20
  lab.prerequisites = [
    "Basic command line skills",
    "Understanding of environment variables"
  ]
  lab.objectives = [
    "Work with environment variables",
    "Create and use .env files",
    "Set proper file permissions for secrets",
    "Use .gitignore to protect secrets"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Create application directory",
      instruction: "Create a directory called 'myapp' and navigate into it",
      expected_output: "Directory created and you're inside it",
      hints: ["mkdir myapp && cd myapp", "pwd should show you're in myapp"]
    },
    {
      step_number: 2,
      title: "Create .env file with secrets",
      instruction: "Create a .env file containing DATABASE_URL, API_KEY, and SECRET_TOKEN variables",
      expected_output: ".env file with three environment variables",
      hints: ["echo 'DATABASE_URL=postgres://localhost/mydb' > .env", "Add more lines with >> (append)", "Format: KEY=value"]
    },
    {
      step_number: 3,
      title: "Set restrictive permissions on .env",
      instruction: "Set .env file permissions to 600 (owner read/write only)",
      expected_output: "Permissions changed to 600",
      hints: ["chmod 600 .env", "Secrets should not be readable by others"]
    },
    {
      step_number: 4,
      title: "Verify .env permissions",
      instruction: "Display the permissions of .env file",
      expected_output: "Should show -rw------- or 600",
      hints: ["ls -l .env", "Or: stat -c '%a' .env for numeric format"]
    },
    {
      step_number: 5,
      title: "Create .env.example template",
      instruction: "Create .env.example with the same keys but placeholder values",
      expected_output: ".env.example with placeholders like 'your_database_url_here'",
      hints: ["Copy structure from .env but use placeholder values", "This file is safe to commit to git"]
    },
    {
      step_number: 6,
      title: "Initialize git repository",
      instruction: "Initialize a git repository in the current directory",
      expected_output: "Git repository initialized",
      hints: ["git init", "Creates .git directory"]
    },
    {
      step_number: 7,
      title: "Create .gitignore",
      instruction: "Create .gitignore file and add .env to it to prevent committing secrets",
      expected_output: ".gitignore created with .env entry",
      hints: ["echo '.env' > .gitignore", "One pattern per line", "Can also add *.key, *.pem, etc."]
    },
    {
      step_number: 8,
      title: "Test git status",
      instruction: "Run git status to verify .env is ignored but .env.example is not",
      expected_output: ".env.example shown as untracked, .env should not appear",
      hints: ["git status", ".gitignore prevents .env from showing up"]
    },
    {
      step_number: 9,
      title: "Load environment variables",
      instruction: "Export the variables from .env file into your current shell session",
      expected_output: "Variables loaded into environment",
      hints: ["export $(cat .env | xargs)", "Or: set -a; source .env; set +a", "Test with: echo $DATABASE_URL"]
    },
    {
      step_number: 10,
      title: "Verify environment variable",
      instruction: "Display the value of DATABASE_URL environment variable",
      expected_output: "Your database URL displayed",
      hints: ["echo $DATABASE_URL", "Should show the value from .env"]
    }
  ]
  lab.validation_commands = [
    "ls -l .env .env.example .gitignore",
    "stat -c '%a' .env",
    "cat .gitignore",
    "git status"
  ]
  lab.hints = [
    "NEVER commit .env files to version control",
    ".env.example serves as documentation for required variables",
    "Use 600 permissions for any file containing secrets",
    "Environment variables are inherited by child processes"
  ]
  lab.solution = <<~SOLUTION
    # Solution:
    mkdir myapp && cd myapp
    cat > .env <<EOF
    DATABASE_URL=postgres://user:password@localhost/mydb
    API_KEY=sk_test_abc123xyz789
    SECRET_TOKEN=super_secret_token_value
    EOF
    chmod 600 .env
    ls -l .env
    cat > .env.example <<EOF
    DATABASE_URL=your_database_url_here
    API_KEY=your_api_key_here
    SECRET_TOKEN=your_secret_token_here
    EOF
    git init
    echo '.env' > .gitignore
    git status
    export $(cat .env | xargs)
    echo $DATABASE_URL
  SOLUTION
end

puts "  ✅ Created lab: #{lab4.title}"

# ========================================
# LAB 5: Security Scanning & Hardening
# ========================================

lab5 = HandsOnLab.find_or_create_by!(title: "Security Lab 5: Security Scanning") do |lab|
  lab.description = "Practice security scanning, permission hardening, and vulnerability checks"
  lab.difficulty = "intermediate"
  lab.estimated_minutes = 25
  lab.prerequisites = [
    "Linux command line skills",
    "Understanding of file permissions"
  ]
  lab.objectives = [
    "Scan for files with dangerous permissions",
    "Find SUID/SGID binaries",
    "Check for world-writable files",
    "Harden file permissions"
  ]
  lab.steps = [
    {
      step_number: 1,
      title: "Find world-writable files",
      instruction: "Search /tmp for world-writable files (dangerous!)",
      expected_output: "List of files writable by everyone",
      hints: ["find /tmp -type f -perm -002", "-perm -002 means others have write permission", "May need sudo for full search"]
    },
    {
      step_number: 2,
      title: "Find SUID binaries",
      instruction: "Find all SUID binaries in /usr/bin (setuid bit set)",
      expected_output: "List of SUID programs",
      hints: ["find /usr/bin -perm -4000", "-4000 checks for SUID bit", "SUID programs run with owner's permissions"]
    },
    {
      step_number: 3,
      title: "Find files without owner",
      instruction: "Search /tmp for files with no valid owner (nouser)",
      expected_output: "Files owned by non-existent users",
      hints: ["find /tmp -nouser", "Can indicate compromised files or cleanup issues"]
    },
    {
      step_number: 4,
      title: "Create test directory structure",
      instruction: "Create a directory ~/security-test with subdirectories config/ and scripts/",
      expected_output: "Directory structure created",
      hints: ["mkdir -p ~/security-test/{config,scripts}", "-p creates parent directories"]
    },
    {
      step_number: 5,
      title: "Create test files with various permissions",
      instruction: "Create config/database.yml and scripts/deploy.sh in your test directory",
      expected_output: "Two files created",
      hints: ["touch ~/security-test/config/database.yml", "touch ~/security-test/scripts/deploy.sh"]
    },
    {
      step_number: 6,
      title: "Harden config file permissions",
      instruction: "Set database.yml to 600 (owner read/write only) since it contains secrets",
      expected_output: "Permissions set to 600",
      hints: ["chmod 600 ~/security-test/config/database.yml", "Config files with secrets need restricted access"]
    },
    {
      step_number: 7,
      title: "Make script executable",
      instruction: "Set deploy.sh to 700 (owner can read/write/execute, no access for others)",
      expected_output: "Permissions set to 700",
      hints: ["chmod 700 ~/security-test/scripts/deploy.sh", "Scripts need execute permission"]
    },
    {
      step_number: 8,
      title: "Scan directory permissions recursively",
      instruction: "List all files in ~/security-test recursively with detailed permissions",
      expected_output: "Tree view of all files with permission details",
      hints: ["ls -lR ~/security-test", "-R for recursive", "-l for long format"]
    },
    {
      step_number: 9,
      title: "Find files with weak permissions",
      instruction: "Find any files in ~/security-test that are readable by others",
      expected_output: "List of world-readable files",
      hints: ["find ~/security-test -type f -perm -004", "-004 checks if others can read"]
    },
    {
      step_number: 10,
      title: "Secure directory permissions",
      instruction: "Set the ~/security-test directory itself to 700",
      expected_output: "Directory permissions set to 700",
      hints: ["chmod 700 ~/security-test", "Prevents others from even listing directory contents"]
    }
  ]
  lab.validation_commands = [
    "ls -ld ~/security-test",
    "ls -l ~/security-test/config/database.yml",
    "ls -l ~/security-test/scripts/deploy.sh",
    "find ~/security-test -type f -perm -004"
  ]
  lab.hints = [
    "World-writable files are security risks",
    "SUID binaries should be audited regularly",
    "Secrets should have 600 permissions",
    "Use principle of least privilege for permissions"
  ]
  lab.solution = <<~SOLUTION
    # Solution:
    find /tmp -type f -perm -002 2>/dev/null
    find /usr/bin -perm -4000 2>/dev/null
    find /tmp -nouser 2>/dev/null
    mkdir -p ~/security-test/{config,scripts}
    touch ~/security-test/config/database.yml
    touch ~/security-test/scripts/deploy.sh
    chmod 600 ~/security-test/config/database.yml
    chmod 700 ~/security-test/scripts/deploy.sh
    ls -lR ~/security-test
    find ~/security-test -type f -perm -004
    chmod 700 ~/security-test
  SOLUTION
end

puts "  ✅ Created lab: #{lab5.title}"

# ========================================
# Link Labs to Course Modules
# ========================================

# Module 1: Cryptography Basics
module1 = security_course.course_modules.find_by(slug: 'cryptography-basics')
if module1 && !ModuleItem.exists?(course_module: module1, item: lab1)
  max_order = module1.module_items.maximum(:sequence_order) || 0
  module1.module_items.create!(item: lab1, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab1.title} to #{module1.title}"
end

# Module 2: TLS/SSL & HTTPS
module2 = security_course.course_modules.find_by(slug: 'tls-ssl-https')
if module2 && !ModuleItem.exists?(course_module: module2, item: lab2)
  max_order = module2.module_items.maximum(:sequence_order) || 0
  module2.module_items.create!(item: lab2, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab2.title} to #{module2.title}"
end

# Module 3: SSH & Key Authentication
module3 = security_course.course_modules.find_by(slug: 'ssh-key-authentication')
if module3 && !ModuleItem.exists?(course_module: module3, item: lab3)
  max_order = module3.module_items.maximum(:sequence_order) || 0
  module3.module_items.create!(item: lab3, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab3.title} to #{module3.title}"
end

# Module 4: Secrets Management
module4 = security_course.course_modules.find_by(slug: 'secrets-management')
if module4 && !ModuleItem.exists?(course_module: module4, item: lab4)
  max_order = module4.module_items.maximum(:sequence_order) || 0
  module4.module_items.create!(item: lab4, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab4.title} to #{module4.title}"
end

# Module 5: Security Best Practices
module5 = security_course.course_modules.find_by(slug: 'security-best-practices')
if module5 && !ModuleItem.exists?(course_module: module5, item: lab5)
  max_order = module5.module_items.maximum(:sequence_order) || 0
  module5.module_items.create!(item: lab5, sequence_order: max_order + 1, required: true)
  puts "  🔗 Linked #{lab5.title} to #{module5.title}"
end

# ========================================
# Summary
# ========================================

puts "\n✅ Security Labs Seeding Complete!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "🧪 Total Labs: 5"
puts "  • Lab 1: Cryptography Basics (35 min, 10 steps)"
puts "  • Lab 2: TLS/SSL Certificates (30 min, 10 steps)"
puts "  • Lab 3: SSH Key Management (25 min, 11 steps)"
puts "  • Lab 4: Secrets Management (20 min, 10 steps)"
puts "  • Lab 5: Security Scanning (25 min, 10 steps)"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

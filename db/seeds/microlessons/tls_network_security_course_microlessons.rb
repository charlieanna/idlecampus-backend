# AUTO-GENERATED from tls_network_security_course.rb
puts "Creating Microlessons for Cryptography Fundamentals..."

module_var = CourseModule.find_by(slug: 'cryptography-fundamentals')

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

# TLS/SSL Protocol Overview

    **TLS (Transport Layer Security)** is the protocol that secures communications over the internet. It's the successor to SSL (Secure Sockets Layer).

    ## TLS vs SSL

    | Version | Year | Status |
    |---------|------|--------|
    | SSL 1.0 | Never released | Insecure |
    | SSL 2.0 | 1995 | **Deprecated (2011)** |
    | SSL 3.0 | 1996 | **Deprecated (2015)** |
    | TLS 1.0 | 1999 | **Deprecated (2021)** |
    | TLS 1.1 | 2006 | **Deprecated (2021)** |
    | TLS 1.2 | 2008 | **Supported** ✓ |
    | TLS 1.3 | 2018 | **Recommended** ✓✓ |

    **Only use TLS 1.2+ in production!**

    ## What TLS Provides

    1. **Confidentiality**: Data encrypted in transit
    2. **Integrity**: Detect tampering with MAC (Message Authentication Code)
    3. **Authentication**: Verify server (and optionally client) identity

    ## TLS Handshake (TLS 1.2)

    The handshake establishes a secure connection:

    ### Step-by-Step Process

    ```
    Client                                         Server

    1. ClientHello
       - TLS version (1.2)
       - Cipher suites supported
       - Random number
       ---------------------------------------->

    2.                                      ServerHello
                                            - Chosen cipher suite
                                            - Random number
                                            Certificate
                                            - Server's public key
                                            ServerHelloDone
       <----------------------------------------

    3. ClientKeyExchange
       - Encrypted pre-master secret
       ChangeCipherSpec
       Finished (encrypted)
       ---------------------------------------->

    4.                                      ChangeCipherSpec
                                            Finished (encrypted)
       <----------------------------------------

    5. Application Data <-----------------> Application Data
       (encrypted with session keys)
    ```

    ### Handshake in Detail

    **1. ClientHello**
    ```
    - TLS Version: 1.2
    - Cipher Suites:
      TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
      TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
      ...
    - Extensions: SNI, ALPN, etc.
    - Random: 28 random bytes + 4 bytes timestamp
    ```

    **2. ServerHello**
    ```
    - Selected cipher suite
    - Server certificate (contains public key)
    - Server random number
    ```

    **3. Key Exchange**
    - Client generates pre-master secret
    - Encrypts with server's public key (from certificate)
    - Both derive master secret:
      ```
      master_secret = PRF(pre_master_secret,
                          "master secret",
                          ClientHello.random + ServerHello.random)
      ```

    **4. Generate Session Keys**
    ```
    - Client write key (client encrypts)
    - Server write key (server encrypts)
    - Client MAC key (client integrity)
    - Server MAC key (server integrity)
    - Client IV (initialization vector)
    - Server IV
    ```

    ## TLS 1.3 Handshake (Simplified)

    TLS 1.3 is faster - only 1 round trip:

    ```
    Client                                         Server

    1. ClientHello
       - Supported groups & key shares
       - Cipher suites
       ---------------------------------------->

    2.                                      ServerHello
                                            - Key share
                                            Certificate
                                            CertificateVerify
                                            Finished
       <----------------------------------------

    3. Finished
       Application Data
       ---------------------------------------->

    4.                                      Application Data
       <----------------------------------------
    ```

    **Improvements in TLS 1.3:**
    - Faster (1-RTT instead of 2-RTT)
    - Forward secrecy mandatory
    - Removed weak ciphers
    - 0-RTT mode for resumption (with caveats)

    ## Cipher Suites

    A cipher suite specifies algorithms for:

    ### Format: TLS_[KeyExchange]_[Authentication]_WITH_[Encryption]_[MAC]

    Example: `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`

    - **ECDHE**: Elliptic Curve Diffie-Hellman Ephemeral (key exchange)
    - **RSA**: RSA signature for authentication
    - **AES_256_GCM**: AES 256-bit in GCM mode (encryption)
    - **SHA384**: SHA-384 hash (integrity)

    ### Modern Recommended Cipher Suites (TLS 1.2)

    ```nginx
    # Strong, recommended order
    TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
    TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
    TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
    TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
    TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
    TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
    ```

    ### TLS 1.3 Cipher Suites (Much Simpler)

    ```
    TLS_AES_256_GCM_SHA384
    TLS_CHACHA20_POLY1305_SHA256
    TLS_AES_128_GCM_SHA256
    ```

    **Note**: Key exchange is separate in TLS 1.3

    ### Cipher Suite Components

    **Key Exchange Algorithms:**
    - ✓ ECDHE (Elliptic Curve Diffie-Hellman Ephemeral) - Best
    - ✓ DHE (Diffie-Hellman Ephemeral) - Good
    - ✗ RSA - No forward secrecy
    - ✗ ECDH, DH (non-ephemeral) - No forward secrecy

    **Encryption Algorithms:**
    - ✓ AES-GCM (Authenticated encryption)
    - ✓ ChaCha20-Poly1305 (Modern, fast on mobile)
    - ⚠ AES-CBC (Use with caution, padding oracle risks)
    - ✗ 3DES, RC4 - Deprecated

    ## Forward Secrecy

    **If server private key is compromised, past sessions remain secure**

    ```
    Without Forward Secrecy (RSA key exchange):
    - Attacker records encrypted traffic
    - Later steals server private key
    - Decrypts ALL past traffic ❌

    With Forward Secrecy (ECDHE):
    - Each session uses ephemeral keys
    - Stealing server key doesn't help
    - Past traffic remains secure ✓
    ```

    **Always use ECDHE or DHE for forward secrecy!**

    ## Session Resumption

    Avoid full handshake for repeat connections:

    ### Session IDs (TLS 1.2)
    ```
    1. Server sends session ID in ServerHello
    2. Client stores session ID
    3. On reconnect, client sends session ID
    4. Server resumes session (if valid)
    ```

    ### Session Tickets (TLS 1.2)
    ```
    1. Server sends encrypted session state to client
    2. Client stores ticket
    3. On reconnect, client presents ticket
    4. Server decrypts and resumes
    ```

    ### PSK (Pre-Shared Key) - TLS 1.3
    ```
    - 0-RTT: Send data in first packet!
    - Trade-off: No forward secrecy for 0-RTT data
    - Use carefully (replay attacks possible)
    ```

    ## SNI (Server Name Indication)

    **Enable multiple HTTPS sites on same IP:**

    ```
    ClientHello:
      ...
      Extensions:
        server_name: www.example.com
    ```

    Server selects appropriate certificate based on SNI.

    **Important**: SNI is sent unencrypted in TLS 1.2!
    - TLS 1.3 can encrypt SNI with ESNI/ECH

    ## ALPN (Application-Layer Protocol Negotiation)

    **Negotiate application protocol during TLS handshake:**

    ```
    ClientHello:
      ...
      Extensions:
        application_layer_protocol_negotiation:
          - h2 (HTTP/2)
          - http/1.1
    ```

    Prevents extra round trip for protocol negotiation.

    ## Common TLS Configurations

    ### Nginx
    ```nginx
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384';
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    ```

    ### Apache
    ```apache
    SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
    SSLCipherSuite HIGH:!aNULL:!MD5
    SSLHonorCipherOrder on
    ```

    ### Node.js
    ```javascript
    const options = {
      minVersion: 'TLSv1.2',
      ciphers: 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256',
      honorCipherOrder: true
    };
    https.createServer(options, app);
    ```

    ## Testing TLS Configuration

    ```bash
    # Test with OpenSSL
    openssl s_client -connect example.com:443 -tls1_2

    # Check cipher suite
    openssl s_client -connect example.com:443 -cipher 'ECDHE-RSA-AES256-GCM-SHA384'

    # Test for weak ciphers
    nmap --script ssl-enum-ciphers -p 443 example.com

    # Online tools
    # SSL Labs: https://www.ssllabs.com/ssltest/
    ```

    **Next**: We'll explore certificates and PKI in depth.
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

# X.509 Certificates and PKI

    **X.509 certificates** bind public keys to identities and are the foundation of TLS authentication.

    ## What is a Certificate?

    A certificate contains:
    - **Subject**: Who the certificate is for (domain name, organization)
    - **Issuer**: Who signed it (Certificate Authority)
    - **Public Key**: For encryption/verification
    - **Validity Period**: Not before / not after dates
    - **Signature**: Issuer's digital signature
    - **Extensions**: Additional information (SANs, key usage, etc.)

    ### Certificate Example (OpenSSL output)
    ```
    Certificate:
        Version: 3
        Serial Number: 0x1a2b3c4d5e6f
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=Let's Encrypt, CN=R3
        Validity:
            Not Before: Jan 1 00:00:00 2024 GMT
            Not After : Apr 1 00:00:00 2024 GMT
        Subject: CN=example.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
            RSA Public-Key: (2048 bit)
        X509v3 extensions:
            X509v3 Subject Alternative Name:
                DNS:example.com, DNS:www.example.com
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
    ```

    ## PKI (Public Key Infrastructure)

    The trust system for certificates:

    ```
    Root CA (trusted by OS/browser)
        ↓ signs
    Intermediate CA
        ↓ signs
    Server Certificate (example.com)
    ```

    ### Trust Chain Verification

    1. Browser checks server certificate
    2. Verifies it's signed by intermediate CA
    3. Verifies intermediate is signed by root CA
    4. Root CA is in browser's trust store
    5. If chain is valid → connection proceeds

    ## Certificate Types

    ### 1. Domain Validated (DV)
    - Only proves domain ownership
    - Automated validation
    - Free (Let's Encrypt)
    - Fast issuance (minutes)

    ### 2. Organization Validated (OV)
    - Proves organization identity
    - Manual verification required
    - Shows organization name
    - Takes days

    ### 3. Extended Validation (EV)
    - Highest validation level
    - Extensive vetting process
    - ~~Shows green bar~~ (removed in modern browsers)
    - Takes weeks
    - Expensive

    **Recommendation**: Use DV for most sites (Let's Encrypt is perfect)

    ## Generating Certificates

    ### Self-Signed Certificate (Development Only)
    ```bash
    # Generate private key
    openssl genrsa -out server.key 2048

    # Generate certificate signing request (CSR)
    openssl req -new -key server.key -out server.csr \
      -subj "/CN=localhost"

    # Self-sign (NOT for production)
    openssl x509 -req -days 365 -in server.csr \
      -signkey server.key -out server.crt
    ```

    ### Production Certificate with Let's Encrypt
    ```bash
    # Install certbot
    sudo apt-get install certbot

    # Get certificate (automatic)
    sudo certbot certonly --standalone -d example.com -d www.example.com

    # Certificates saved to:
    # /etc/letsencrypt/live/example.com/fullchain.pem
    # /etc/letsencrypt/live/example.com/privkey.pem

    # Auto-renew (Let's Encrypt certs expire in 90 days)
    sudo certbot renew
    ```

    ### Manual CSR for Commercial CA
    ```bash
    # 1. Generate private key (keep this secret!)
    openssl genrsa -out example.com.key 2048

    # 2. Generate CSR
    openssl req -new -key example.com.key -out example.com.csr \
      -subj "/C=US/ST=California/L=San Francisco/O=Example Inc/CN=example.com"

    # 3. Submit CSR to CA (DigiCert, GlobalSign, etc.)
    # 4. Complete validation process
    # 5. Download signed certificate
    ```

    ## Certificate Formats

    ### PEM (Privacy Enhanced Mail)
    ```
    -----BEGIN CERTIFICATE-----
    MIIDXTCCAkWgAwIBAgIJAKL...
    ...
    -----END CERTIFICATE-----
    ```
    - Base64 encoded
    - Most common
    - Used by nginx, Apache

    ### DER (Distinguished Encoding Rules)
    - Binary format
    - Common in Java

    ### P12/PFX (PKCS#12)
    - Bundle: certificate + private key
    - Password protected
    - Common in Windows

    ### Converting Formats
    ```bash
    # PEM to DER
    openssl x509 -in cert.pem -outform DER -out cert.der

    # DER to PEM
    openssl x509 -in cert.der -inform DER -out cert.pem

    # Create P12 bundle
    openssl pkcs12 -export -in cert.pem -inkey key.pem -out cert.p12
    ```

    ## Subject Alternative Names (SAN)

    **Modern way to specify multiple domains:**

    ```
    X509v3 Subject Alternative Name:
        DNS:example.com
        DNS:www.example.com
        DNS:api.example.com
        DNS:*.example.com (wildcard)
        IP Address:192.0.2.1
    ```

    ### Generating Certificate with SANs
    ```bash
    # Create config file
    cat > san.cnf <<EOF
    [req]
    distinguished_name = req_distinguished_name
    req_extensions = v3_req

    [req_distinguished_name]
    CN = example.com

    [v3_req]
    subjectAltName = @alt_names

    [alt_names]
    DNS.1 = example.com
    DNS.2 = www.example.com
    DNS.3 = *.api.example.com
    EOF

    # Generate with SANs
    openssl req -new -key server.key -out server.csr -config san.cnf
    ```

    ## Certificate Validation

    ### What Browsers Check:

    1. **Signature**: Certificate is signed by trusted CA
    2. **Validity Period**: Current time is within not-before/not-after
    3. **Hostname**: Domain matches CN or SAN
    4. **Revocation**: Certificate not revoked (CRL/OCSP)
    5. **Chain**: Complete chain to trusted root

    ### Common Certificate Errors:

    **ERR_CERT_AUTHORITY_INVALID**
    - Certificate not signed by trusted CA
    - Self-signed certificate
    - Incomplete chain

    **ERR_CERT_DATE_INVALID**
    - Certificate expired or not yet valid
    - Check system clock

    **ERR_CERT_COMMON_NAME_INVALID**
    - Domain name doesn't match certificate
    - Missing from SAN

    ## Certificate Revocation

    ### CRL (Certificate Revocation List)
    - Published by CA
    - List of revoked certificates
    - Client downloads and checks
    - Can be large and slow

    ### OCSP (Online Certificate Status Protocol)
    - Real-time check with CA
    - Query: "Is cert X revoked?"
    - Response: Good / Revoked / Unknown

    ### OCSP Stapling
    - Server gets OCSP response from CA
    - Includes it in TLS handshake
    - Faster, more private

    ```nginx
    # Enable OCSP stapling in nginx
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /path/to/chain.pem;
    ```

    ## Certificate Pinning

    **Hard-code which certificates/keys are valid:**

    ```javascript
    // HTTP Public Key Pinning (HPKP) - Deprecated!
    // Use Certificate Transparency instead

    // Pin in mobile app
    const pins = [
      'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
      'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB='
    ];
    ```

    **Warning**: Pinning is risky! If pin is lost, app breaks.

    ## Best Practices

    1. **Use Let's Encrypt** for free automated certificates
    2. **Automate renewal** (90-day expiry!)
    3. **Include full chain** in server configuration
    4. **Enable OCSP stapling** for faster validation
    5. **Monitor expiration** with alerting
    6. **Use wildcard certs carefully** (wider attack surface)
    7. **Rotate keys** when certificate is compromised
    8. **Test configuration** with SSL Labs

    **Next**: We'll explore HTTPS implementation and securing web applications.
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

# Introduction to Cryptography

    Cryptography is the foundation of secure communications. Understanding these concepts is essential for implementing TLS/SSL correctly.

    ## Types of Cryptography

    ### 1. Symmetric Encryption
    **Same key for encryption and decryption**

    ```python
    # Example: AES (Advanced Encryption Standard)
    from cryptography.fernet import Fernet

    # Generate key
    key = Fernet.generate_key()
    cipher = Fernet(key)

    # Encrypt
    plaintext = b"Secret message"
    ciphertext = cipher.encrypt(plaintext)

    # Decrypt (with same key)
    decrypted = cipher.decrypt(ciphertext)
    ```

    **Pros:**
    - Fast and efficient
    - Good for large amounts of data

    **Cons:**
    - Key distribution problem (how to share key securely?)
    - N users need N(N-1)/2 keys

    **Common algorithms:**
    - AES-128, AES-256 (recommended)
    - ChaCha20 (modern alternative)
    - ~~DES, 3DES~~ (deprecated, insecure)

    ### 2. Asymmetric Encryption (Public Key Cryptography)
    **Two keys: public key (encrypt) and private key (decrypt)**

    ```python
    # Example: RSA
    from cryptography.hazmat.primitives.asymmetric import rsa, padding
    from cryptography.hazmat.primitives import hashes

    # Generate key pair
    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048
    )
    public_key = private_key.public_key()

    # Encrypt with public key
    message = b"Secret message"
    ciphertext = public_key.encrypt(
        message,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )

    # Decrypt with private key
    plaintext = private_key.decrypt(
        ciphertext,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    ```

    **Pros:**
    - Solves key distribution (public key can be shared openly)
    - Enables digital signatures

    **Cons:**
    - Much slower than symmetric
    - Limited message size

    **Common algorithms:**
    - RSA (2048-bit minimum, 4096-bit recommended)
    - ECC (Elliptic Curve Cryptography) - faster, smaller keys
    - ~~RSA-1024~~ (deprecated, insecure)

    ## Hash Functions

    **One-way functions that produce fixed-size output**

    ```python
    import hashlib

    # SHA-256
    message = b"Hello, World!"
    hash_value = hashlib.sha256(message).hexdigest()
    print(hash_value)  # Always the same for same input

    # SHA-3 (modern alternative)
    hash_value = hashlib.sha3_256(message).hexdigest()
    ```

    **Properties:**
    1. **Deterministic**: Same input → same output
    2. **One-way**: Can't reverse to get input
    3. **Collision-resistant**: Hard to find two inputs with same hash
    4. **Avalanche effect**: Small input change → completely different hash

    **Use cases:**
    - Password storage (with salt!)
    - Data integrity verification
    - Digital signatures

    **Common algorithms:**
    - SHA-256, SHA-384, SHA-512 (recommended)
    - SHA-3 (latest standard)
    - BLAKE2, BLAKE3 (fast alternatives)
    - ~~MD5, SHA-1~~ (broken, do not use)

    ## Digital Signatures

    **Prove authenticity and integrity using asymmetric cryptography**

    ### How it works:
    1. Hash the message
    2. Encrypt hash with private key → signature
    3. Recipient decrypts signature with public key
    4. Compares with hash of received message

    ```python
    from cryptography.hazmat.primitives import hashes
    from cryptography.hazmat.primitives.asymmetric import padding

    # Sign with private key
    message = b"I approve this transaction"
    signature = private_key.sign(
        message,
        padding.PSS(
            mgf=padding.MGF1(hashes.SHA256()),
            salt_length=padding.PSS.MAX_LENGTH
        ),
        hashes.SHA256()
    )

    # Verify with public key
    try:
        public_key.verify(
            signature,
            message,
            padding.PSS(
                mgf=padding.MGF1(hashes.SHA256()),
                salt_length=padding.PSS.MAX_LENGTH
            ),
            hashes.SHA256()
        )
        print("Signature valid!")
    except:
        print("Signature invalid!")
    ```

    **Use cases:**
    - Email signing (S/MIME)
    - Code signing
    - TLS certificate chains
    - Blockchain transactions

    ## Key Exchange

    **How to establish shared secret over insecure channel?**

    ### Diffie-Hellman Key Exchange

    ```python
    from cryptography.hazmat.primitives.asymmetric import dh

    # Generate parameters (shared publicly)
    parameters = dh.generate_parameters(generator=2, key_size=2048)

    # Alice generates private key and derives public key
    alice_private = parameters.generate_private_key()
    alice_public = alice_private.public_key()

    # Bob generates private key and derives public key
    bob_private = parameters.generate_private_key()
    bob_public = bob_private.public_key()

    # Both derive same shared secret!
    alice_shared = alice_private.exchange(bob_public)
    bob_shared = bob_private.exchange(alice_public)

    # alice_shared == bob_shared (without ever transmitting it!)
    ```

    **Modern variant**: ECDH (Elliptic Curve Diffie-Hellman)
    - Faster, smaller keys
    - Curves: P-256, P-384, Curve25519 (recommended)

    ## Random Number Generation

    **Critical for security!**

    ```python
    import secrets  # Cryptographically secure

    # Generate random bytes
    key = secrets.token_bytes(32)  # 256 bits

    # Generate random URL-safe string
    token = secrets.token_urlsafe(32)

    # DON'T use random.random() for security!
    ```

    ## Common Cryptographic Mistakes

    ### 1. Using Weak Algorithms
    ```python
    # BAD
    hashlib.md5(password)  # Broken!

    # GOOD
    hashlib.sha256(password + salt)  # Better
    hashlib.pbkdf2_hmac('sha256', password, salt, 100000)  # Best for passwords
    ```

    ### 2. Predictable Random Numbers
    ```python
    # BAD
    import random
    key = random.randint(0, 1000000)  # Predictable!

    # GOOD
    import secrets
    key = secrets.token_bytes(32)  # Cryptographically secure
    ```

    ### 3. Not Using Salt
    ```python
    # BAD: Same password → same hash
    hash = hashlib.sha256(password.encode()).hexdigest()

    # GOOD: Salt makes each hash unique
    import os
    salt = os.urandom(32)
    hash = hashlib.pbkdf2_hmac('sha256', password.encode(), salt, 100000)
    ```

    ### 4. Homemade Cryptography
    **Never roll your own crypto!**
    - Use established libraries
    - Use proven algorithms
    - Use recommended parameters

    ## Key Length Recommendations (2024)

    | Algorithm | Minimum | Recommended | Purpose |
    |-----------|---------|-------------|---------|
    | RSA | 2048 bits | 4096 bits | Long-term security |
    | ECC | 256 bits | 384 bits | Equivalent to RSA-3072 |
    | AES | 128 bits | 256 bits | Symmetric encryption |
    | SHA | SHA-256 | SHA-384 | Hashing |

    **Next**: We'll explore how these concepts come together in TLS/SSL.
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

# TLS/SSL Protocol Overview

    **TLS (Transport Layer Security)** is the protocol that secures communications over the internet. It's the successor to SSL (Secure Sockets Layer).

    ## TLS vs SSL

    | Version | Year | Status |
    |---------|------|--------|
    | SSL 1.0 | Never released | Insecure |
    | SSL 2.0 | 1995 | **Deprecated (2011)** |
    | SSL 3.0 | 1996 | **Deprecated (2015)** |
    | TLS 1.0 | 1999 | **Deprecated (2021)** |
    | TLS 1.1 | 2006 | **Deprecated (2021)** |
    | TLS 1.2 | 2008 | **Supported** ✓ |
    | TLS 1.3 | 2018 | **Recommended** ✓✓ |

    **Only use TLS 1.2+ in production!**

    ## What TLS Provides

    1. **Confidentiality**: Data encrypted in transit
    2. **Integrity**: Detect tampering with MAC (Message Authentication Code)
    3. **Authentication**: Verify server (and optionally client) identity

    ## TLS Handshake (TLS 1.2)

    The handshake establishes a secure connection:

    ### Step-by-Step Process

    ```
    Client                                         Server

    1. ClientHello
       - TLS version (1.2)
       - Cipher suites supported
       - Random number
       ---------------------------------------->

    2.                                      ServerHello
                                            - Chosen cipher suite
                                            - Random number
                                            Certificate
                                            - Server's public key
                                            ServerHelloDone
       <----------------------------------------

    3. ClientKeyExchange
       - Encrypted pre-master secret
       ChangeCipherSpec
       Finished (encrypted)
       ---------------------------------------->

    4.                                      ChangeCipherSpec
                                            Finished (encrypted)
       <----------------------------------------

    5. Application Data <-----------------> Application Data
       (encrypted with session keys)
    ```

    ### Handshake in Detail

    **1. ClientHello**
    ```
    - TLS Version: 1.2
    - Cipher Suites:
      TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
      TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
      ...
    - Extensions: SNI, ALPN, etc.
    - Random: 28 random bytes + 4 bytes timestamp
    ```

    **2. ServerHello**
    ```
    - Selected cipher suite
    - Server certificate (contains public key)
    - Server random number
    ```

    **3. Key Exchange**
    - Client generates pre-master secret
    - Encrypts with server's public key (from certificate)
    - Both derive master secret:
      ```
      master_secret = PRF(pre_master_secret,
                          "master secret",
                          ClientHello.random + ServerHello.random)
      ```

    **4. Generate Session Keys**
    ```
    - Client write key (client encrypts)
    - Server write key (server encrypts)
    - Client MAC key (client integrity)
    - Server MAC key (server integrity)
    - Client IV (initialization vector)
    - Server IV
    ```

    ## TLS 1.3 Handshake (Simplified)

    TLS 1.3 is faster - only 1 round trip:

    ```
    Client                                         Server

    1. ClientHello
       - Supported groups & key shares
       - Cipher suites
       ---------------------------------------->

    2.                                      ServerHello
                                            - Key share
                                            Certificate
                                            CertificateVerify
                                            Finished
       <----------------------------------------

    3. Finished
       Application Data
       ---------------------------------------->

    4.                                      Application Data
       <----------------------------------------
    ```

    **Improvements in TLS 1.3:**
    - Faster (1-RTT instead of 2-RTT)
    - Forward secrecy mandatory
    - Removed weak ciphers
    - 0-RTT mode for resumption (with caveats)

    ## Cipher Suites

    A cipher suite specifies algorithms for:

    ### Format: TLS_[KeyExchange]_[Authentication]_WITH_[Encryption]_[MAC]

    Example: `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`

    - **ECDHE**: Elliptic Curve Diffie-Hellman Ephemeral (key exchange)
    - **RSA**: RSA signature for authentication
    - **AES_256_GCM**: AES 256-bit in GCM mode (encryption)
    - **SHA384**: SHA-384 hash (integrity)

    ### Modern Recommended Cipher Suites (TLS 1.2)

    ```nginx
    # Strong, recommended order
    TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
    TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
    TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
    TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
    TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
    TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
    ```

    ### TLS 1.3 Cipher Suites (Much Simpler)

    ```
    TLS_AES_256_GCM_SHA384
    TLS_CHACHA20_POLY1305_SHA256
    TLS_AES_128_GCM_SHA256
    ```

    **Note**: Key exchange is separate in TLS 1.3

    ### Cipher Suite Components

    **Key Exchange Algorithms:**
    - ✓ ECDHE (Elliptic Curve Diffie-Hellman Ephemeral) - Best
    - ✓ DHE (Diffie-Hellman Ephemeral) - Good
    - ✗ RSA - No forward secrecy
    - ✗ ECDH, DH (non-ephemeral) - No forward secrecy

    **Encryption Algorithms:**
    - ✓ AES-GCM (Authenticated encryption)
    - ✓ ChaCha20-Poly1305 (Modern, fast on mobile)
    - ⚠ AES-CBC (Use with caution, padding oracle risks)
    - ✗ 3DES, RC4 - Deprecated

    ## Forward Secrecy

    **If server private key is compromised, past sessions remain secure**

    ```
    Without Forward Secrecy (RSA key exchange):
    - Attacker records encrypted traffic
    - Later steals server private key
    - Decrypts ALL past traffic ❌

    With Forward Secrecy (ECDHE):
    - Each session uses ephemeral keys
    - Stealing server key doesn't help
    - Past traffic remains secure ✓
    ```

    **Always use ECDHE or DHE for forward secrecy!**

    ## Session Resumption

    Avoid full handshake for repeat connections:

    ### Session IDs (TLS 1.2)
    ```
    1. Server sends session ID in ServerHello
    2. Client stores session ID
    3. On reconnect, client sends session ID
    4. Server resumes session (if valid)
    ```

    ### Session Tickets (TLS 1.2)
    ```
    1. Server sends encrypted session state to client
    2. Client stores ticket
    3. On reconnect, client presents ticket
    4. Server decrypts and resumes
    ```

    ### PSK (Pre-Shared Key) - TLS 1.3
    ```
    - 0-RTT: Send data in first packet!
    - Trade-off: No forward secrecy for 0-RTT data
    - Use carefully (replay attacks possible)
    ```

    ## SNI (Server Name Indication)

    **Enable multiple HTTPS sites on same IP:**

    ```
    ClientHello:
      ...
      Extensions:
        server_name: www.example.com
    ```

    Server selects appropriate certificate based on SNI.

    **Important**: SNI is sent unencrypted in TLS 1.2!
    - TLS 1.3 can encrypt SNI with ESNI/ECH

    ## ALPN (Application-Layer Protocol Negotiation)

    **Negotiate application protocol during TLS handshake:**

    ```
    ClientHello:
      ...
      Extensions:
        application_layer_protocol_negotiation:
          - h2 (HTTP/2)
          - http/1.1
    ```

    Prevents extra round trip for protocol negotiation.

    ## Common TLS Configurations

    ### Nginx
    ```nginx
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384';
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    ```

    ### Apache
    ```apache
    SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
    SSLCipherSuite HIGH:!aNULL:!MD5
    SSLHonorCipherOrder on
    ```

    ### Node.js
    ```javascript
    const options = {
      minVersion: 'TLSv1.2',
      ciphers: 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256',
      honorCipherOrder: true
    };
    https.createServer(options, app);
    ```

    ## Testing TLS Configuration

    ```bash
    # Test with OpenSSL
    openssl s_client -connect example.com:443 -tls1_2

    # Check cipher suite
    openssl s_client -connect example.com:443 -cipher 'ECDHE-RSA-AES256-GCM-SHA384'

    # Test for weak ciphers
    nmap --script ssl-enum-ciphers -p 443 example.com

    # Online tools
    # SSL Labs: https://www.ssllabs.com/ssltest/
    ```

    **Next**: We'll explore certificates and PKI in depth.
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

# X.509 Certificates and PKI

    **X.509 certificates** bind public keys to identities and are the foundation of TLS authentication.

    ## What is a Certificate?

    A certificate contains:
    - **Subject**: Who the certificate is for (domain name, organization)
    - **Issuer**: Who signed it (Certificate Authority)
    - **Public Key**: For encryption/verification
    - **Validity Period**: Not before / not after dates
    - **Signature**: Issuer's digital signature
    - **Extensions**: Additional information (SANs, key usage, etc.)

    ### Certificate Example (OpenSSL output)
    ```
    Certificate:
        Version: 3
        Serial Number: 0x1a2b3c4d5e6f
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=Let's Encrypt, CN=R3
        Validity:
            Not Before: Jan 1 00:00:00 2024 GMT
            Not After : Apr 1 00:00:00 2024 GMT
        Subject: CN=example.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
            RSA Public-Key: (2048 bit)
        X509v3 extensions:
            X509v3 Subject Alternative Name:
                DNS:example.com, DNS:www.example.com
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
    ```

    ## PKI (Public Key Infrastructure)

    The trust system for certificates:

    ```
    Root CA (trusted by OS/browser)
        ↓ signs
    Intermediate CA
        ↓ signs
    Server Certificate (example.com)
    ```

    ### Trust Chain Verification

    1. Browser checks server certificate
    2. Verifies it's signed by intermediate CA
    3. Verifies intermediate is signed by root CA
    4. Root CA is in browser's trust store
    5. If chain is valid → connection proceeds

    ## Certificate Types

    ### 1. Domain Validated (DV)
    - Only proves domain ownership
    - Automated validation
    - Free (Let's Encrypt)
    - Fast issuance (minutes)

    ### 2. Organization Validated (OV)
    - Proves organization identity
    - Manual verification required
    - Shows organization name
    - Takes days

    ### 3. Extended Validation (EV)
    - Highest validation level
    - Extensive vetting process
    - ~~Shows green bar~~ (removed in modern browsers)
    - Takes weeks
    - Expensive

    **Recommendation**: Use DV for most sites (Let's Encrypt is perfect)

    ## Generating Certificates

    ### Self-Signed Certificate (Development Only)
    ```bash
    # Generate private key
    openssl genrsa -out server.key 2048

    # Generate certificate signing request (CSR)
    openssl req -new -key server.key -out server.csr \
      -subj "/CN=localhost"

    # Self-sign (NOT for production)
    openssl x509 -req -days 365 -in server.csr \
      -signkey server.key -out server.crt
    ```

    ### Production Certificate with Let's Encrypt
    ```bash
    # Install certbot
    sudo apt-get install certbot

    # Get certificate (automatic)
    sudo certbot certonly --standalone -d example.com -d www.example.com

    # Certificates saved to:
    # /etc/letsencrypt/live/example.com/fullchain.pem
    # /etc/letsencrypt/live/example.com/privkey.pem

    # Auto-renew (Let's Encrypt certs expire in 90 days)
    sudo certbot renew
    ```

    ### Manual CSR for Commercial CA
    ```bash
    # 1. Generate private key (keep this secret!)
    openssl genrsa -out example.com.key 2048

    # 2. Generate CSR
    openssl req -new -key example.com.key -out example.com.csr \
      -subj "/C=US/ST=California/L=San Francisco/O=Example Inc/CN=example.com"

    # 3. Submit CSR to CA (DigiCert, GlobalSign, etc.)
    # 4. Complete validation process
    # 5. Download signed certificate
    ```

    ## Certificate Formats

    ### PEM (Privacy Enhanced Mail)
    ```
    -----BEGIN CERTIFICATE-----
    MIIDXTCCAkWgAwIBAgIJAKL...
    ...
    -----END CERTIFICATE-----
    ```
    - Base64 encoded
    - Most common
    - Used by nginx, Apache

    ### DER (Distinguished Encoding Rules)
    - Binary format
    - Common in Java

    ### P12/PFX (PKCS#12)
    - Bundle: certificate + private key
    - Password protected
    - Common in Windows

    ### Converting Formats
    ```bash
    # PEM to DER
    openssl x509 -in cert.pem -outform DER -out cert.der

    # DER to PEM
    openssl x509 -in cert.der -inform DER -out cert.pem

    # Create P12 bundle
    openssl pkcs12 -export -in cert.pem -inkey key.pem -out cert.p12
    ```

    ## Subject Alternative Names (SAN)

    **Modern way to specify multiple domains:**

    ```
    X509v3 Subject Alternative Name:
        DNS:example.com
        DNS:www.example.com
        DNS:api.example.com
        DNS:*.example.com (wildcard)
        IP Address:192.0.2.1
    ```

    ### Generating Certificate with SANs
    ```bash
    # Create config file
    cat > san.cnf <<EOF
    [req]
    distinguished_name = req_distinguished_name
    req_extensions = v3_req

    [req_distinguished_name]
    CN = example.com

    [v3_req]
    subjectAltName = @alt_names

    [alt_names]
    DNS.1 = example.com
    DNS.2 = www.example.com
    DNS.3 = *.api.example.com
    EOF

    # Generate with SANs
    openssl req -new -key server.key -out server.csr -config san.cnf
    ```

    ## Certificate Validation

    ### What Browsers Check:

    1. **Signature**: Certificate is signed by trusted CA
    2. **Validity Period**: Current time is within not-before/not-after
    3. **Hostname**: Domain matches CN or SAN
    4. **Revocation**: Certificate not revoked (CRL/OCSP)
    5. **Chain**: Complete chain to trusted root

    ### Common Certificate Errors:

    **ERR_CERT_AUTHORITY_INVALID**
    - Certificate not signed by trusted CA
    - Self-signed certificate
    - Incomplete chain

    **ERR_CERT_DATE_INVALID**
    - Certificate expired or not yet valid
    - Check system clock

    **ERR_CERT_COMMON_NAME_INVALID**
    - Domain name doesn't match certificate
    - Missing from SAN

    ## Certificate Revocation

    ### CRL (Certificate Revocation List)
    - Published by CA
    - List of revoked certificates
    - Client downloads and checks
    - Can be large and slow

    ### OCSP (Online Certificate Status Protocol)
    - Real-time check with CA
    - Query: "Is cert X revoked?"
    - Response: Good / Revoked / Unknown

    ### OCSP Stapling
    - Server gets OCSP response from CA
    - Includes it in TLS handshake
    - Faster, more private

    ```nginx
    # Enable OCSP stapling in nginx
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /path/to/chain.pem;
    ```

    ## Certificate Pinning

    **Hard-code which certificates/keys are valid:**

    ```javascript
    // HTTP Public Key Pinning (HPKP) - Deprecated!
    // Use Certificate Transparency instead

    // Pin in mobile app
    const pins = [
      'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
      'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB='
    ];
    ```

    **Warning**: Pinning is risky! If pin is lost, app breaks.

    ## Best Practices

    1. **Use Let's Encrypt** for free automated certificates
    2. **Automate renewal** (90-day expiry!)
    3. **Include full chain** in server configuration
    4. **Enable OCSP stapling** for faster validation
    5. **Monitor expiration** with alerting
    6. **Use wildcard certs carefully** (wider attack surface)
    7. **Rotate keys** when certificate is compromised
    8. **Test configuration** with SSL Labs

    **Next**: We'll explore HTTPS implementation and securing web applications.
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

# Introduction to Cryptography

    Cryptography is the foundation of secure communications. Understanding these concepts is essential for implementing TLS/SSL correctly.

    ## Types of Cryptography

    ### 1. Symmetric Encryption
    **Same key for encryption and decryption**

    ```python
    # Example: AES (Advanced Encryption Standard)
    from cryptography.fernet import Fernet

    # Generate key
    key = Fernet.generate_key()
    cipher = Fernet(key)

    # Encrypt
    plaintext = b"Secret message"
    ciphertext = cipher.encrypt(plaintext)

    # Decrypt (with same key)
    decrypted = cipher.decrypt(ciphertext)
    ```

    **Pros:**
    - Fast and efficient
    - Good for large amounts of data

    **Cons:**
    - Key distribution problem (how to share key securely?)
    - N users need N(N-1)/2 keys

    **Common algorithms:**
    - AES-128, AES-256 (recommended)
    - ChaCha20 (modern alternative)
    - ~~DES, 3DES~~ (deprecated, insecure)

    ### 2. Asymmetric Encryption (Public Key Cryptography)
    **Two keys: public key (encrypt) and private key (decrypt)**

    ```python
    # Example: RSA
    from cryptography.hazmat.primitives.asymmetric import rsa, padding
    from cryptography.hazmat.primitives import hashes

    # Generate key pair
    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048
    )
    public_key = private_key.public_key()

    # Encrypt with public key
    message = b"Secret message"
    ciphertext = public_key.encrypt(
        message,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )

    # Decrypt with private key
    plaintext = private_key.decrypt(
        ciphertext,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    ```

    **Pros:**
    - Solves key distribution (public key can be shared openly)
    - Enables digital signatures

    **Cons:**
    - Much slower than symmetric
    - Limited message size

    **Common algorithms:**
    - RSA (2048-bit minimum, 4096-bit recommended)
    - ECC (Elliptic Curve Cryptography) - faster, smaller keys
    - ~~RSA-1024~~ (deprecated, insecure)

    ## Hash Functions

    **One-way functions that produce fixed-size output**

    ```python
    import hashlib

    # SHA-256
    message = b"Hello, World!"
    hash_value = hashlib.sha256(message).hexdigest()
    print(hash_value)  # Always the same for same input

    # SHA-3 (modern alternative)
    hash_value = hashlib.sha3_256(message).hexdigest()
    ```

    **Properties:**
    1. **Deterministic**: Same input → same output
    2. **One-way**: Can't reverse to get input
    3. **Collision-resistant**: Hard to find two inputs with same hash
    4. **Avalanche effect**: Small input change → completely different hash

    **Use cases:**
    - Password storage (with salt!)
    - Data integrity verification
    - Digital signatures

    **Common algorithms:**
    - SHA-256, SHA-384, SHA-512 (recommended)
    - SHA-3 (latest standard)
    - BLAKE2, BLAKE3 (fast alternatives)
    - ~~MD5, SHA-1~~ (broken, do not use)

    ## Digital Signatures

    **Prove authenticity and integrity using asymmetric cryptography**

    ### How it works:
    1. Hash the message
    2. Encrypt hash with private key → signature
    3. Recipient decrypts signature with public key
    4. Compares with hash of received message

    ```python
    from cryptography.hazmat.primitives import hashes
    from cryptography.hazmat.primitives.asymmetric import padding

    # Sign with private key
    message = b"I approve this transaction"
    signature = private_key.sign(
        message,
        padding.PSS(
            mgf=padding.MGF1(hashes.SHA256()),
            salt_length=padding.PSS.MAX_LENGTH
        ),
        hashes.SHA256()
    )

    # Verify with public key
    try:
        public_key.verify(
            signature,
            message,
            padding.PSS(
                mgf=padding.MGF1(hashes.SHA256()),
                salt_length=padding.PSS.MAX_LENGTH
            ),
            hashes.SHA256()
        )
        print("Signature valid!")
    except:
        print("Signature invalid!")
    ```

    **Use cases:**
    - Email signing (S/MIME)
    - Code signing
    - TLS certificate chains
    - Blockchain transactions

    ## Key Exchange

    **How to establish shared secret over insecure channel?**

    ### Diffie-Hellman Key Exchange

    ```python
    from cryptography.hazmat.primitives.asymmetric import dh

    # Generate parameters (shared publicly)
    parameters = dh.generate_parameters(generator=2, key_size=2048)

    # Alice generates private key and derives public key
    alice_private = parameters.generate_private_key()
    alice_public = alice_private.public_key()

    # Bob generates private key and derives public key
    bob_private = parameters.generate_private_key()
    bob_public = bob_private.public_key()

    # Both derive same shared secret!
    alice_shared = alice_private.exchange(bob_public)
    bob_shared = bob_private.exchange(alice_public)

    # alice_shared == bob_shared (without ever transmitting it!)
    ```

    **Modern variant**: ECDH (Elliptic Curve Diffie-Hellman)
    - Faster, smaller keys
    - Curves: P-256, P-384, Curve25519 (recommended)

    ## Random Number Generation

    **Critical for security!**

    ```python
    import secrets  # Cryptographically secure

    # Generate random bytes
    key = secrets.token_bytes(32)  # 256 bits

    # Generate random URL-safe string
    token = secrets.token_urlsafe(32)

    # DON'T use random.random() for security!
    ```

    ## Common Cryptographic Mistakes

    ### 1. Using Weak Algorithms
    ```python
    # BAD
    hashlib.md5(password)  # Broken!

    # GOOD
    hashlib.sha256(password + salt)  # Better
    hashlib.pbkdf2_hmac('sha256', password, salt, 100000)  # Best for passwords
    ```

    ### 2. Predictable Random Numbers
    ```python
    # BAD
    import random
    key = random.randint(0, 1000000)  # Predictable!

    # GOOD
    import secrets
    key = secrets.token_bytes(32)  # Cryptographically secure
    ```

    ### 3. Not Using Salt
    ```python
    # BAD: Same password → same hash
    hash = hashlib.sha256(password.encode()).hexdigest()

    # GOOD: Salt makes each hash unique
    import os
    salt = os.urandom(32)
    hash = hashlib.pbkdf2_hmac('sha256', password.encode(), salt, 100000)
    ```

    ### 4. Homemade Cryptography
    **Never roll your own crypto!**
    - Use established libraries
    - Use proven algorithms
    - Use recommended parameters

    ## Key Length Recommendations (2024)

    | Algorithm | Minimum | Recommended | Purpose |
    |-----------|---------|-------------|---------|
    | RSA | 2048 bits | 4096 bits | Long-term security |
    | ECC | 256 bits | 384 bits | Equivalent to RSA-3072 |
    | AES | 128 bits | 256 bits | Symmetric encryption |
    | SHA | SHA-256 | SHA-384 | Hashing |

    **Next**: We'll explore how these concepts come together in TLS/SSL.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 12 microlessons for Cryptography Fundamentals"

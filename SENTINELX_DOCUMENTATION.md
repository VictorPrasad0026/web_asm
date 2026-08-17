# SentinelX V5 — Complete Platform Documentation

> **Your reference guide to explain everything about this platform — what it is, how it works, what every file does, and what every technical term means.**

---

## TABLE OF CONTENTS

1. [What is SentinelX?](#1-what-is-sentinelx)
2. [Why Does It Exist?](#2-why-does-it-exist)
3. [Key Terms Explained](#3-key-terms-explained)
4. [How a Scan Works — End to End](#4-how-a-scan-works--end-to-end)
5. [Platform Architecture](#5-platform-architecture)
6. [Every File Explained](#6-every-file-explained)
7. [The 4 Intelligence Phases](#7-the-4-intelligence-phases)
8. [The AI Copilot](#8-the-ai-copilot)
9. [The Web Interface](#9-the-web-interface)
10. [Risk Scoring Explained](#10-risk-scoring-explained)
11. [Attack Paths Explained](#11-attack-paths-explained)
12. [How to Explain This to Anyone](#12-how-to-explain-this-to-anyone)

---

## 1. What is SentinelX?

SentinelX is an **Attack Surface Management (ASM) platform**. 

In plain English: you give it a website domain (like `google.com`) and it automatically maps everything that domain exposes to the internet, finds security weaknesses, simulates how an attacker would exploit those weaknesses, and tells you exactly what to fix first.

It is a **Python-based security intelligence platform** with:
- A command-line interface (run from terminal)
- A web interface (React UI + Flask API)
- An AI copilot powered by Gemini/Groq/Claude that answers security questions in plain English

**What makes it different from a basic security scanner:**
A basic scanner checks if a website is up and if it has obvious problems. SentinelX goes much deeper — it discovers hidden subdomains, maps how assets are connected to each other, identifies which assets are most critical to the business, simulates complete attack chains step by step, and tracks how the security posture changes over time.

---

## 2. Why Does It Exist?

Every company that has a website has an **attack surface** — the sum of all the digital things an attacker can try to access. Most companies don't know what their full attack surface looks like. They might know about `www.company.com` but not realize they also have `dev.company.com`, `api.company.com`, and `admin.company.com` — each potentially with its own vulnerabilities.

SentinelX automates the work of:
1. Finding everything that's exposed
2. Understanding how dangerous each exposure is
3. Figuring out how an attacker would chain exposures together
4. Prioritizing what to fix first

---

## 3. Key Terms Explained

These are the core concepts you'll encounter throughout SentinelX. If someone asks you what any of these mean, here is how to explain them.

---

### Attack Surface
**What it is:** Everything about your company that's accessible from the internet — your website, subdomains, APIs, mail servers, login pages, databases, etc.

**Analogy:** Think of your company as a building. The attack surface is every door, window, vent, and opening on that building. Some are locked, some aren't, some you don't even know exist.

**In SentinelX:** The platform maps your entire attack surface — not just the front door, but every entrance.

---

### Subdomain
**What it is:** A website that lives under your main domain. If your domain is `company.com`, then `api.company.com`, `mail.company.com`, and `admin.company.com` are subdomains.

**Why it matters:** Companies often create subdomains for different purposes (development, API, admin) and forget about them. Each one is a potential entry point for attackers.

**In SentinelX:** The platform discovers subdomains using 8 different methods (certificate transparency logs, brute force, DNS enumeration, etc.)

---

### CVE (Common Vulnerabilities and Exposures)
**What it is:** A CVE is a publicly known security flaw with an official ID number (like `CVE-2024-21887`). Think of it as a catalogue entry for a known bug in software that attackers can exploit.

**Example:** If your server runs Apache web server version 2.4.49, there is a known CVE for that version — attackers know exactly how to exploit it.

**In SentinelX:** The platform checks your technology stack against the CVE database (NVD — National Vulnerability Database) to see if any of your software has known exploitable bugs.

---

### CVSS Score
**What it is:** Common Vulnerability Scoring System. A number from 0 to 10 that rates how severe a CVE is. 10.0 = most dangerous, 0 = no real risk.

| Score | Label | Meaning |
|-------|-------|---------|
| 9.0–10.0 | Critical | Drop everything, fix now |
| 7.0–8.9 | High | Fix this week |
| 4.0–6.9 | Medium | Fix this month |
| 0.1–3.9 | Low | Fix when convenient |

---

### EPSS Score
**What it is:** Exploit Prediction Scoring System. A percentage (0–100%) that estimates the probability that a CVE will actually be exploited in the next 30 days based on real-world threat intelligence.

**Why it matters:** A CVE might have CVSS 9.8 (very severe) but EPSS 0.1% (almost nobody is exploiting it right now). Another CVE might have CVSS 6.5 but EPSS 84% (attackers are actively using this right now). EPSS helps you prioritize what's actually being attacked vs. what's theoretically dangerous.

**In SentinelX:** Every CVE found shows both CVSS (severity) and EPSS (probability of being exploited), so you know which ones to patch first in the real world.

---

### CISA KEV (Known Exploited Vulnerabilities)
**What it is:** A list maintained by the US Cybersecurity and Infrastructure Security Agency (CISA) of CVEs that are confirmed to be actively exploited by real attackers right now.

**Why it matters:** If a CVE is on the KEV list, it means real hackers are using it today. These are the highest priority to fix, above all others.

**In SentinelX:** The platform checks your CVEs against the CISA KEV list and flags any matches with a `🚨 KEV` badge. These paths are ranked #1 for remediation.

---

### Attack Path / Attack Chain
**What it is:** A step-by-step sequence showing exactly how an attacker could move from the public internet into your systems. Each step is a real, evidence-based action using information discovered during the scan.

**Example attack path:**
```
Internet → Scan finds MySQL port 3306 open → 
Connect directly (no firewall) → 
Brute force database password → 
Extract all student records
```

**In SentinelX:** Paths are generated only from real evidence found during the scan. They include the MITRE ATT&CK technique ID for each step and a likelihood percentage.

---

### MITRE ATT&CK
**What it is:** A globally recognized framework that catalogues the tactics and techniques attackers use. Every technique has an ID (like `T1595` for "Active Scanning" or `T1552` for "Unsecured Credentials").

**Why it matters:** When SentinelX says a step uses technique `T1190 — Exploit Public-Facing Application`, it's speaking the universal language of cybersecurity that any security professional worldwide will understand immediately.

**In SentinelX:** Every step in every attack path is tagged with a MITRE technique. This lets security teams communicate precisely with each other and with incident responders.

---

### TLS / SSL
**What it is:** TLS (Transport Layer Security) and SSL (Secure Sockets Layer) are the encryption protocols that protect data travelling between a browser and a website. When you see `https://` and a padlock, TLS is working.

**TLS Grades (A+ to F):**
- **A+** — Perfect. HSTS preloaded, TLS 1.3, strong ciphers, no issues.
- **A** — Good. Minor improvements possible.
- **B** — Acceptable but some configuration issues.
- **C/D** — Problems. Outdated protocols or weak encryption.
- **F** — Failed. Certificate invalid or broken — attackers can intercept traffic.

**In SentinelX:** The TLS grading engine grades every discovered asset like a report card, showing exactly what's wrong with each one.

---

### SPF, DKIM, DMARC
These three work together to prevent email spoofing (fake emails from your domain).

| Term | Full Name | What it does |
|------|-----------|--------------|
| **SPF** | Sender Policy Framework | Lists which servers are allowed to send email for your domain |
| **DKIM** | DomainKeys Identified Mail | Adds a cryptographic signature to every email, proving it's genuine |
| **DMARC** | Domain-based Message Authentication | The enforcement policy — what to do with emails that fail SPF/DKIM |

**DMARC policies:**
- `p=none` — Monitor only. Fake emails still get delivered. Weak.
- `p=quarantine` — Send suspicious emails to spam.
- `p=reject` — Block fake emails entirely. Strongest.

**In SentinelX:** The email security module checks all three and flags weak configurations that let attackers send convincing phishing emails pretending to be from your domain.

---

### WAF (Web Application Firewall)
**What it is:** A security layer that sits in front of your website and filters malicious traffic before it reaches your server. Think of it as a security guard at the door.

**Examples:** Cloudflare, AWS WAF, Akamai, Imperva, F5 BIG-IP.

**In SentinelX:** The platform detects whether each asset has WAF protection. Assets without a WAF are scored higher risk because they have no traffic filtering.

---

### CDN (Content Delivery Network)
**What it is:** A network of servers spread around the world that serve your website content from the closest location to the user. Examples: Cloudflare, AWS CloudFront, Akamai.

**Security relevance:** A CDN hides your real server's IP address. Without a CDN, attackers can see your actual server IP and attack it directly, bypassing some protections.

**In SentinelX:** The platform detects CDN usage. Assets without a CDN get a higher exposure score because their origin IP is exposed.

---

### Crown Jewels
**What it is:** The most business-critical assets in your attack surface. If these are compromised, the impact on the business is maximum.

**Examples:**
- `auth.company.com` — the login/authentication server. Compromise this and you get access to everything.
- `api.company.com` — the core API handling all customer data.
- `admin.company.com` — the administrative control panel.

**In SentinelX:** The crown jewel identifier looks at asset names, the technologies they run, which other assets depend on them, and how many attack paths lead to them. The most interconnected, most critical assets get the crown jewel label.

---

### Passive DNS
**What it is:** Historical DNS records — a record of what IP addresses a domain pointed to in the past, and what subdomains existed at previous points in time.

**Why it matters:** Companies create `dev.company.com` for development, then forget about it. It might still be accessible years later with old software. Passive DNS reveals these "forgotten" assets.

**In SentinelX:** The passive DNS module queries HackerTarget, CIRCL, and CT log history to find historical subdomains and IP changes that the company may not know about.

---

### Exposure Score
**What it is:** A score from 0 to 100 for each individual asset, representing how exposed it is to attack. Similar to how Wiz or Cortex Xpanse score cloud assets.

**Factors that raise the score:**
- Critical services exposed (database ports, Docker, RDP)
- No WAF protection (+8 points)
- No CDN (+5 points)
- Invalid SSL (+15 points)
- Admin keywords in hostname (+10 points)
- Data-sensitive keywords like "exam", "admission", "finance" (+10 points)

**In SentinelX:** Every discovered asset gets an exposure score. The highest-scored assets appear first in the dashboard and are treated as highest priority.

---

### Knowledge Graph
**What it is:** A visual map of all assets and how they relate to each other. In a knowledge graph, assets are "nodes" (circles) and relationships are "edges" (lines connecting them).

**Relationships it captures:**
- Two subdomains pointing to the same IP (`SHARES_IP`)
- Two domains using the same SSL certificate (`SHARES_CERTIFICATE`)
- Assets hosted on the same cloud provider (`SAME_CLOUD`)
- Domains belonging to the same organization (`SAME_ORG`)

**Why it matters:** A vulnerability on one asset might give access to another asset that shares infrastructure. The graph reveals these hidden connections.

**In SentinelX:** The graph builder creates this map and can optionally write it to a Neo4j graph database for visualization.

---

### Compliance Frameworks
These are sets of security rules that companies must follow by law or industry standards.

| Framework | Who it applies to | Key focus |
|-----------|-------------------|-----------|
| **PCI-DSS** | Any company handling credit cards | Payment data security |
| **GDPR** | Any company with EU users | Personal data privacy |
| **ISO 27001** | Any organization (global standard) | Information security management |
| **NIST CSF** | US government + enterprises | Risk management framework |
| **OWASP Top 10** | Web application developers | Top 10 web security risks |

**In SentinelX:** The compliance mapper automatically maps every finding to the relevant compliance requirements it violates. If an SSL certificate is invalid, it flags PCI-DSS 4.1, HIPAA § 164.312, and ISO 27001 A.10.1.

---

### Certificate Transparency (CT) Logs
**What it is:** Public logs where every SSL certificate ever issued is recorded. By law, certificate authorities must log every certificate they issue.

**Why it matters for security:** Attackers use CT logs to find all subdomains of a target (because every certificate reveals what hostnames it covers). SentinelX uses the same technique — querying `crt.sh` — to discover subdomains that might not be publicly listed anywhere.

---

### Neo4j
**What it is:** A graph database — a database designed specifically to store and query relationship data (nodes and edges).

**In SentinelX:** Optionally, the knowledge graph can be written to a Neo4j database (`--neo4j` flag). This allows visual exploration of asset relationships in the Neo4j browser.

---

## 4. How a Scan Works — End to End

When you run `python run.py example.com`, here is exactly what happens in sequence:

```
You type: python run.py example.com
              │
              ▼
    ┌─────────────────────────────────┐
    │  PHASE 1 — DATA COLLECTION     │
    │                                 │
    │  1. Resolve DNS records         │
    │  2. Grab SSL certificate        │
    │  3. Fingerprint HTTP headers    │
    │  4. Detect technologies         │
    │  5. Analyze email security      │
    │  6. Find subdomains (8 methods) │
    │  7. Scan each subdomain         │
    │  8. Calculate initial risk      │
    └───────────────┬─────────────────┘
                    │
                    ▼
    ┌─────────────────────────────────┐
    │  PHASE 2 — V3 INTELLIGENCE     │
    │                                 │
    │  1. Build knowledge graph       │
    │  2. Map attack surface          │
    │  3. Identify crown jewels       │
    │  4. Map compliance violations   │
    │  5. Generate remediation plan   │
    │  6. Build attack paths          │
    │  7. Generate AI summary         │
    └───────────────┬─────────────────┘
                    │
                    ▼
    ┌─────────────────────────────────┐
    │  PHASE 3 — V4 ATTACK GRAPH     │
    │                                 │
    │  1. Correlate assets            │
    │  2. Score each asset 0-100      │
    │  3. Build evidence-only chains  │
    │  4. Look up CVEs (optional)     │
    │  5. Discover APIs               │
    │  6. Analyze JavaScript files    │
    └───────────────┬─────────────────┘
                    │
                    ▼
    ┌─────────────────────────────────┐
    │  PHASE 4 — V5 ENHANCED INTEL   │
    │                                 │
    │  1. Compare to last scan        │
    │  2. Grade TLS on all assets     │
    │  3. Check CT log history        │
    │  4. Find login pages            │
    │  5. Scan for exposed secrets    │
    │  6. Query passive DNS history   │
    │  7. (Optional) Screenshots      │
    │  8. Enrich paths with CVEs      │
    │  9. Prioritize vulnerabilities  │
    │ 10. Calculate risk trend        │
    └───────────────┬─────────────────┘
                    │
                    ▼
    ┌─────────────────────────────────┐
    │  OUTPUT                         │
    │                                 │
    │  • Terminal report              │
    │  • JSON report files            │
    │  • Historical snapshot saved    │
    │  • AI Copilot session           │
    └─────────────────────────────────┘
```

---

## 5. Platform Architecture

```
sentinelx/
│
├── run.py                          ← ENTRY POINT — run the whole scan
│
├── api_server.py                   ← WEB SERVER — Flask API for the web UI
│
├── collectors/                     ← PHASE 1: Raw data collection
│   ├── asset_profile.py            ← Orchestrates all collectors
│   ├── dns_intelligence.py         ← DNS records
│   ├── ssl_intelligence.py         ← SSL/TLS certificates
│   ├── http_intelligence.py        ← HTTP headers, WAF, cookies
│   ├── technology_intelligence.py  ← Tech stack detection
│   ├── email_intelligence.py       ← SPF, DKIM, DMARC, MX
│   ├── domain_intelligence.py      ← WHOIS, reputation
│   ├── infrastructure_intelligence.py ← IP, ASN, GeoIP, cloud, ports
│   ├── subdomain_intelligence.py   ← Subdomain discovery
│   ├── subdomain_asset_enrichment.py  ← Deep scan each subdomain
│   ├── risk_engine.py              ← Risk scoring engine
│   ├── asset_graph.py              ← Basic node/edge graph
│   ├── port_intelligence.py        ← Port scanning
│   ├── asn_intelligence.py         ← ASN lookup
│   ├── cdn_detection.py            ← CDN detection
│   ├── cloud_intelligence.py       ← Cloud provider detection
│   ├── csp_intelligence.py         ← Content Security Policy
│   ├── geoip_intelligence.py       ← Geographic location
│   ├── reverse_dns.py              ← Reverse DNS lookups
│   ├── service_banner.py           ← Service banner grabbing
│   └── subdomain_sources/          ← 8 subdomain discovery methods
│       ├── crtsh.py                ← Certificate transparency logs
│       ├── certspotter.py          ← Another CT log source
│       ├── alienvault_otx.py       ← AlienVault threat intel
│       ├── dns_bruteforce.py       ← Dictionary brute force
│       ├── permutation.py          ← Name permutations
│       ├── passive.py              ← Passive DNS
│       ├── recursive.py            ← Recursive DNS discovery
│       ├── registry.py             ← Registry sources
│       ├── wildcard.py             ← Wildcard DNS detection
│       └── dns_zone_transfer.py    ← Zone transfer attempt
│
├── intelligence_engine/            ← PHASE 2+: Analysis and intelligence
│   ├── engine.py                   ← V3 orchestrator
│   │
│   ├── graph/                      ← Knowledge graph construction
│   │   ├── graph_builder.py        ← Main graph pipeline
│   │   ├── asset_mapper.py         ← Profile → nodes/edges
│   │   ├── relationship_engine.py  ← Discover hidden relationships
│   │   ├── duplicate_detector.py   ← Merge duplicate nodes
│   │   ├── graph_validator.py      ← Integrity checking
│   │   ├── graph_updater.py        ← Diff between scans
│   │   ├── graph_queries.py        ← Query the graph
│   │   ├── graph_models.py         ← Data models
│   │   └── neo4j_client.py         ← Optional Neo4j export
│   │
│   ├── intelligence/               ← Deep analysis modules
│   │   ├── attack_surface_mapper.py  ← Map the full attack surface
│   │   ├── asset_classifier.py     ← Classify asset types
│   │   ├── asset_criticality.py    ← Score business criticality
│   │   ├── exposure_analyzer.py    ← Internet exposure analysis
│   │   ├── internet_exposure.py    ← What's reachable from internet
│   │   └── trust_relationships.py  ← Trust between assets
│   │
│   ├── attack_engine/              ← Attack path construction
│   │   ├── attack_path_builder.py  ← Build paths from graph
│   │   ├── attack_path_ranker.py   ← Rank by likelihood
│   │   ├── attack_path_validator.py ← Validate paths
│   │   ├── attack_chain_generator.py ← Generate step-by-step chains
│   │   ├── exploitability_engine.py  ← Exploitability scoring
│   │   ├── lateral_movement.py     ← Lateral movement paths
│   │   ├── privilege_escalation.py ← Privilege escalation paths
│   │   └── persistence_engine.py   ← Attacker persistence paths
│   │
│   ├── business/                   ← Business context
│   │   ├── business_asset_mapper.py   ← Map assets to business functions
│   │   ├── crown_jewel_identifier.py  ← Identify most critical assets
│   │   ├── business_impact.py         ← Translate tech → business language
│   │   └── compliance_mapper.py       ← Map to compliance frameworks
│   │
│   ├── remediation/                ← Fix prioritization
│   │   ├── remediation_engine.py   ← Which fixes break most attack paths
│   │   ├── fix_prioritizer.py      ← Priority ranking
│   │   └── risk_reduction_calculator.py ← Calculate risk reduction per fix
│   │
│   ├── timeline/                   ← Historical tracking
│   │   ├── snapshot_manager.py     ← Save scan snapshots
│   │   ├── change_detector.py      ← Detect changes between scans
│   │   └── trend_engine.py         ← Risk trend analysis
│   │
│   ├── ai/                         ← AI intelligence
│   │   ├── llm_client.py           ← Connects to Groq/Gemini/Anthropic
│   │   ├── security_copilot.py     ← Q&A about scan results
│   │   ├── executive_summary.py    ← Generate non-technical summary
│   │   ├── report_explainer.py     ← Explain specific findings
│   │   └── ai_reasoning.py         ← AI-assisted risk reasoning
│   │
│   ├── v4/                         ← V4 advanced intelligence
│   │   ├── v4_engine.py            ← V4 orchestrator
│   │   ├── asset_correlation.py    ← Group findings by asset
│   │   ├── attack_graph_engine.py  ← Evidence-only attack chains
│   │   ├── exposure_score.py       ← Wiz-style 0-100 exposure scoring
│   │   ├── vulnerability_intelligence.py ← NVD + CVE + EPSS
│   │   ├── api_discovery.py        ← REST/GraphQL/Swagger discovery
│   │   └── js_intelligence.py      ← JavaScript secret extraction
│   │
│   └── v5/                         ← V5 enhanced intelligence
│       ├── v5_engine.py            ← V5 orchestrator
│       ├── tls_grading.py          ← A+ to F TLS grades
│       ├── login_detection.py      ← Find login pages + default creds
│       ├── secrets_exposure.py     ← .env, .git, config file exposure
│       ├── passive_dns.py          ← Historical DNS data
│       ├── screenshot_capture.py   ← Playwright screenshots
│       ├── historical_comparison.py ← Compare to previous scans
│       ├── vuln_prioritization.py  ← CVE + KEV + EPSS prioritization
│       └── attack_path_generator.py ← CVE-enriched attack paths
│
└── sentinelx_web/                  ← WEB INTERFACE
    ├── api_server.py               ← Flask backend
    ├── package.json                ← React dependencies
    ├── src/
    │   ├── App.jsx                 ← Full React UI (1700+ lines)
    │   └── index.js                ← React entry point
    └── public/
        └── index.html              ← HTML shell
```

---

## 6. Every File Explained

### `run.py` — The Entry Point
**What it does:** The main script that runs the entire scan. You run `python run.py example.com` and it orchestrates all 4 phases in sequence.

**How it works:**
1. Parses command-line arguments (`--vuln`, `--github`, `--screenshots`, etc.)
2. Calls Phase 1 (collectors) → Phase 2 (V3 intelligence) → Phase 3 (V4) → Phase 4 (V5)
3. Prints a complete terminal report with color-coded findings
4. Saves JSON reports to the `reports/` folder
5. Starts the AI Copilot session for live Q&A
6. Saves a snapshot for historical comparison

**Key flags:**
- `--vuln` — enables CVE lookup against NVD database (slower)
- `--github` — searches GitHub for leaked credentials
- `--screenshots` — captures visual screenshots (needs Playwright)
- `--no-ai` — skip the AI copilot
- `--neo4j` — write graph to Neo4j database

---

### `collectors/asset_profile.py` — The Collection Orchestrator
**What it does:** Calls every collector in sequence to build a complete intelligence profile of a domain. This is the "master profile" that every other engine reads from.

**Output structure:**
```json
{
  "asset": "example.com",
  "dns_intelligence": { ... },
  "ssl_intelligence": { ... },
  "http_intelligence": { ... },
  "technology_intelligence": { ... },
  "email_intelligence": { ... },
  "infrastructure": { ... },
  "subdomain_assets": { "assets": [...] },
  "risk_assessment": { "risk_score": 62, "findings": [...] },
  "attack_surface": { ... }
}
```

---

### `collectors/dns_intelligence.py` — DNS Records
**What it does:** Queries every DNS record type for the domain.

**Records it collects:**
- **A** — IPv4 address the domain points to
- **AAAA** — IPv6 address
- **MX** — Mail servers
- **TXT** — SPF, DMARC, verification records
- **NS** — Name servers (who controls DNS)
- **SOA** — Start of Authority (domain registration info)
- **CAA** — Certificate Authority Authorization (which CAs can issue certs)
- **SRV** — Service location records

**Why it matters:** DNS records reveal the complete infrastructure map of a domain — every server, mail provider, and service.

---

### `collectors/ssl_intelligence.py` — SSL/TLS Certificates
**What it does:** Connects to the domain on port 443 and extracts everything from the SSL certificate.

**What it extracts:**
- Certificate issuer (Let's Encrypt, DigiCert, Sectigo, etc.)
- Subject (what domain the cert was issued for)
- Subject Alternative Names (SAN) — other domains covered by the same cert
- TLS version (TLS 1.0, 1.1, 1.2, 1.3)
- Cipher suite (the encryption algorithm)
- Key size (2048-bit, 4096-bit)
- Expiry date and days remaining
- Whether it's self-signed
- Whether it's a wildcard certificate (`*.company.com`)
- SHA-256 fingerprint

**Security findings it generates:**
- Certificate expired or invalid
- Weak TLS version (TLS 1.0 or 1.1)
- Certificate expires within 30 days
- Self-signed certificate

---

### `collectors/http_intelligence.py` — HTTP Analysis
**What it does:** Makes HTTP requests to the domain and analyzes the response.

**What it checks:**
- HTTP status code (200, 301, 403, 500, etc.)
- Response time
- Server banner (what web server software is running)
- `X-Powered-By` header (reveals technology like PHP, ASP.NET)
- Security headers presence/absence
- Cookie security flags (HttpOnly, Secure, SameSite)
- WAF detection (by analyzing headers and responses)
- Basic technology fingerprinting

**Security headers it checks:**
- `Strict-Transport-Security` (HSTS) — forces HTTPS
- `Content-Security-Policy` (CSP) — prevents code injection
- `X-Frame-Options` — prevents clickjacking
- `X-Content-Type-Options` — prevents MIME sniffing
- `Referrer-Policy` — controls referrer information
- `Permissions-Policy` — controls browser features

---

### `collectors/technology_intelligence.py` — Technology Detection
**What it does:** Identifies what software, frameworks, and services the website runs.

**How it detects technologies:**
- HTTP headers reveal web servers (Nginx, Apache) and languages (PHP, Python)
- HTML source code patterns reveal frameworks (WordPress, React, Vue.js)
- JavaScript file names reveal libraries
- Cookie names reveal backend frameworks (PHPSESSID → PHP, JSESSIONID → Java)
- Meta tags reveal CMS platforms

**Why it matters:** Every technology has known vulnerabilities. Knowing the stack means knowing which CVEs to check.

---

### `collectors/email_intelligence.py` — Email Security
**What it does:** Analyzes email security configuration by querying DNS.

**What it checks:**
- **MX records** — what mail servers handle email for this domain
- **SPF record** — is it present? what's the policy? (`+all` is dangerous)
- **DMARC record** — is it present? what's the policy? (`p=none` is weak)
- **DKIM** — attempts to detect common DKIM selectors
- **SMTP** — checks if the mail server is reachable
- **Email provider** — detects Google Workspace, Microsoft 365, etc.

---

### `collectors/subdomain_intelligence.py` — Subdomain Discovery
**What it does:** Finds all subdomains of a domain using 8 parallel methods.

**The 8 discovery methods:**

1. **crtsh.py** — Queries Certificate Transparency logs at `crt.sh`. Every SSL cert ever issued for the domain is listed here, revealing all subdomains that ever had a cert.

2. **certspotter.py** — Another CT log source (Certspotter by SSLMate) for cross-validation.

3. **alienvault_otx.py** — Queries AlienVault's Open Threat Exchange, which has passive DNS data from millions of sensors worldwide.

4. **dns_bruteforce.py** — Tries thousands of common subdomain names (www, api, mail, admin, dev, staging, etc.) and checks if they resolve.

5. **permutation.py** — Takes known subdomains and generates variations (api1, api2, api-prod, api-staging, etc.).

6. **passive.py** — Queries passive DNS sources for historical records.

7. **recursive.py** — Takes discovered subdomains and recursively looks for their subdomains.

8. **dns_zone_transfer.py** — Attempts a DNS zone transfer (a misconfiguration that reveals all DNS records at once). Rare but critical when it works.

9. **wildcard.py** — Detects wildcard DNS (`*.company.com`) so it doesn't miscount fake subdomains.

---

### `collectors/risk_engine.py` — Risk Scoring
**What it does:** Aggregates all findings from all collectors and produces a risk score (0–100) and severity level (LOW/MEDIUM/HIGH/CRITICAL).

**What it scores:**
- Asset criticality (admin, login, VPN keywords)
- SSL validity and TLS version
- Certificate expiry
- Missing security headers
- CSP configuration
- Email security (DMARC/DKIM)
- Sensitive subdomain exposure
- Technology fingerprint disclosure
- DNS errors
- **Asset rollup** — scans every subdomain and aggregates the worst score

**Score formula (after fixes):**
```
final_score = (root_domain_score × 0.4) + (worst_asset_score × 0.6)
```

---

### `collectors/port_intelligence.py` — Port Scanning
**What it does:** Scans for open ports on discovered assets, identifying what services are running.

**Why certain ports are critical:**

| Port | Service | Risk |
|------|---------|------|
| 3306 | MySQL | CRITICAL — Database directly exposed |
| 5432 | PostgreSQL | CRITICAL — Database exposed |
| 6379 | Redis | CRITICAL — Often no auth required |
| 27017 | MongoDB | CRITICAL — Often no auth required |
| 3389 | RDP | HIGH — Remote desktop, brute-force target |
| 22 | SSH | MEDIUM — Secure but should be restricted |
| 21 | FTP | HIGH — Cleartext credentials |
| 23 | Telnet | CRITICAL — Completely unencrypted |

---

### `intelligence_engine/engine.py` — V3 Intelligence Orchestrator
**What it does:** Runs the second phase of intelligence — higher-level analysis that takes the raw data collected in Phase 1 and turns it into actionable security intelligence.

**What it runs:**
1. Builds the knowledge graph
2. Maps the attack surface
3. Analyzes internet exposure
4. Maps trust relationships between assets
5. Identifies crown jewels
6. Maps compliance violations
7. Generates attack paths
8. Builds attack chains (lateral movement, privilege escalation, persistence)
9. Calculates business impact
10. Generates remediation plan
11. Runs AI executive summary
12. Saves historical snapshot

---

### `intelligence_engine/graph/graph_builder.py` — Knowledge Graph
**What it does:** Builds a graph (network of nodes and edges) representing all assets and their relationships.

**Node types:**
- **Organization** — The company being scanned
- **Domain** — Root domain
- **Subdomain** — Each discovered subdomain
- **IP Address** — Each IP address
- **SSL Certificate** — Each certificate
- **Technology** — Each detected technology
- **Vulnerability** — Each CVE found
- **Cloud Provider** — AWS, GCP, Azure

**Edge types (relationships):**
- `HAS_SUBDOMAIN` — Organization owns this subdomain
- `RESOLVES_TO` — Domain/subdomain points to this IP
- `SHARES_IP` — Two subdomains on same server
- `USES_CERTIFICATE` — Asset uses this SSL cert
- `SHARES_CERTIFICATE` — Two assets share a cert
- `RUNS_TECHNOLOGY` — Asset runs this software
- `HAS_VULNERABILITY` — Asset has this CVE
- `HOSTED_ON` — Asset hosted on this cloud
- `CONNECTED_TO` — Assets in same ASN

**Why the graph matters:** It reveals hidden connections. If you patch a vulnerability on `api.company.com`, the graph might show that `admin.company.com` shares the same IP — so it might be vulnerable too.

---

### `intelligence_engine/v4/asset_correlation.py` — Asset Correlation
**What it does:** Groups all findings by the asset they belong to. Before V4, findings were organized by category (all SSL findings together, all header findings together). After V4, each asset owns its complete security picture.

**Before V4:**
```
SSL findings: [cert expired on mail, weak TLS on api]
Header findings: [missing HSTS on www, missing CSP on admin]
```

**After V4:**
```
mail.company.com: [cert expired, no HSTS]
api.company.com: [weak TLS, CORS wildcard, GraphQL exposed]
admin.company.com: [missing CSP, default cred risk]
```

This makes it much easier to prioritize — you can see which single asset has the most problems.

---

### `intelligence_engine/v4/attack_graph_engine.py` — Evidence-Only Attack Chains
**What it does:** Builds attack chains where every single step is backed by real evidence from the scan. No guessing.

**Chain templates it uses:**
- `_chain_database_direct` — Database port exposed to internet
- `_chain_ssh_exposed` — SSH accessible from internet
- `_chain_admin_panel` — Admin panel publicly accessible
- `_chain_docker_api` — Docker management API exposed
- `_chain_email_spoofing` — Weak SPF/DMARC enables phishing

**How it decides likelihood:**
- Direct evidence of the vulnerability = base 80%
- CVE exists for the service = +5-15%
- CVE is on CISA KEV list = +10%
- EPSS score boost = up to +15%

---

### `intelligence_engine/v4/exposure_score.py` — Wiz-Style Exposure Scoring
**What it does:** Assigns every asset a score from 0 to 100 representing how exposed it is to attack, similar to how Wiz scores cloud workloads.

**Scoring factors:**
- Critical ports exposed (MySQL, Redis, MongoDB) = +40–45 points
- Sensitive ports (SSH, RDP, FTP) = +10–20 points
- No WAF = +8 points
- No CDN = +5 points
- Invalid SSL = +15 points
- Missing HSTS = +5 points
- Missing CSP = +5 points
- Data-sensitive hostname (exam, finance, crm) = +10 points
- Admin interface = +10 points
- Too many open ports = up to +10 points

---

### `intelligence_engine/v4/vulnerability_intelligence.py` — CVE Intelligence
**What it does:** Takes the detected technology stack and looks up known CVEs for each technology from the NVD (National Vulnerability Database), enriched with EPSS scores and CISA KEV status.

**For each CVE it returns:**
- CVE ID
- CVSS score (severity)
- EPSS score (exploitation probability)
- Whether it's on CISA KEV (actively exploited)
- CVE description
- Affected technology

---

### `intelligence_engine/v4/api_discovery.py` — API Discovery
**What it does:** Probes common API endpoint paths on every discovered asset to find exposed REST APIs, GraphQL endpoints, and API documentation.

**Paths it checks:**
`/api`, `/api/v1`, `/api/v2`, `/graphql`, `/swagger.json`, `/openapi.json`, `/api-docs`, `/actuator/env`, `/actuator/health`, etc.

**For each discovered API it checks:**
- Authentication required? (is there an auth token needed?)
- CORS policy (does `Access-Control-Allow-Origin: *` expose data to any website?)
- GraphQL introspection enabled? (reveals complete schema to anyone)
- Sensitive data in response (user IDs, emails, tokens)

---

### `intelligence_engine/v4/js_intelligence.py` — JavaScript Secret Extraction
**What it does:** Downloads JavaScript files from the website and scans them for secrets, credentials, and internal information that developers accidentally left in client-side code.

**What it finds:**
- AWS access keys (`AKIA...`)
- Google API keys (`AIzaSy...`)
- Stripe API keys (`pk_live_...`, `sk_live_...`)
- GitHub tokens
- Slack tokens
- Firebase keys
- JWT tokens
- Hardcoded passwords
- Internal API endpoints
- Internal IP addresses
- Cloud bucket references

---

### `intelligence_engine/v5/tls_grading.py` — TLS Grade (A+ to F)
**What it does:** Grades the TLS configuration of every discovered asset from A+ to F, similar to SSL Labs.

**Grading criteria:**
- **A+** — TLS 1.3 only, HSTS preloaded, OCSP stapling, perfect cipher suites
- **A** — TLS 1.2+, HSTS present, strong ciphers
- **B** — Minor issues (TLS 1.0 allowed, weak ciphers, no HSTS)
- **C** — Significant issues (weak protocols, poor ciphers)
- **F** — Certificate invalid, broken chain, or completely misconfigured

Also fetches CT log timeline from `crt.sh` showing the history of certificates issued for the domain.

---

### `intelligence_engine/v5/login_detection.py` — Login Page Detection
**What it does:** Probes discovered assets for login pages and admin panels, then checks for default credential risk.

**What it detects:**
- Login page URLs (`/login`, `/admin`, `/wp-admin`, `/panel`, `/auth`, etc.)
- Authentication type (form login, HTTP Basic Auth, OAuth, SSO)
- Panel type (WordPress admin, cPanel, phpMyAdmin, router admin, etc.)
- Default credential risk (does this panel use known default credentials?)
- Known default credentials for each panel type

**Default credential examples it checks:**
- phpMyAdmin: `root` / (blank)
- WordPress: `admin` / `admin`
- Router panels: `admin` / `admin`, `admin` / `password`

---

### `intelligence_engine/v5/secrets_exposure.py` — Sensitive File Detection
**What it does:** Checks if sensitive configuration files are publicly accessible on web servers.

**Files it checks:**
- `/.env` — Environment files containing database passwords, API keys
- `/.git/config` — Git configuration revealing internal repository URLs
- `/config.json` — Application configuration files
- `/phpinfo.php` — PHP information page revealing server config
- `/.htpasswd` — Apache password files
- `/wp-config.php` — WordPress database credentials
- `/backup.sql` — Database backup files
- `/.DS_Store` — Mac directory files that reveal folder structure

Also checks for publicly accessible cloud storage buckets (S3, GCS, Azure Blob).

---

### `intelligence_engine/v5/passive_dns.py` — Passive DNS History
**What it does:** Queries multiple passive DNS sources to retrieve historical DNS data for the domain.

**Data sources it queries:**
- HackerTarget Passive DNS API
- CIRCL Passive DNS
- RapidDNS
- Certificate Transparency logs (historical certificates)

**What it reveals:**
- Subdomains that existed in the past (forgotten assets)
- IP address history (where the domain pointed before)
- Infrastructure changes over time

---

### `intelligence_engine/v5/historical_comparison.py` — Change Detection
**What it does:** Compares the current scan against the previous scan to detect what changed.

**What it tracks:**
- New assets discovered since last scan
- Assets that disappeared
- Risk score changes per asset
- New findings vs. resolved findings
- WHOIS changes (new registrar, new contact info)
- Infrastructure changes (new IPs, new cloud providers)

**Why it matters:** New assets appearing between scans can indicate shadow IT (employees spinning up infrastructure without security team knowledge). Risk score increases can indicate new vulnerabilities or misconfigurations.

---

### `intelligence_engine/v5/vuln_prioritization.py` — Vulnerability Prioritization
**What it does:** Takes all CVEs found and prioritizes them using three data sources combined.

**Prioritization formula:**
```
Priority = CVSS weight + EPSS weight + KEV bonus
         = (CVSS/10 × 0.3) + (EPSS × 0.5) + (KEV ? 0.2 : 0)
```

This means a CVE with moderate CVSS but high EPSS (lots of active exploitation) ranks higher than a critical CVSS with low EPSS (dangerous but not being exploited yet).

---

### `intelligence_engine/business/crown_jewel_identifier.py` — Crown Jewels
**What it does:** Identifies the most business-critical assets — the ones that, if compromised, would have the highest blast radius.

**Criteria for crown jewel status:**
- Asset has auth/login/SSO in the name → it's the identity provider
- Asset has api/data/db in the name → it holds sensitive data
- Asset is connected to many other assets in the graph → compromise cascades
- Asset has high criticality score from business asset mapper

---

### `intelligence_engine/business/compliance_mapper.py` — Compliance Mapping
**What it does:** Takes every security finding and maps it to the specific compliance requirement it violates.

**Example mappings:**
- "Invalid SSL certificate" → PCI-DSS 4.1, HIPAA § 164.312(e)(2)(ii), ISO 27001 A.10.1
- "DMARC not enforced" → NIST SP 800-177, DMARC RFC 7489
- "Database port exposed" → PCI-DSS 6.4, GDPR Article 32, HIPAA § 164.312

**Why it matters:** For enterprise customers, compliance violations are often more actionable than security findings because they have legal and financial consequences (fines, audits, certifications).

---

### `intelligence_engine/remediation/remediation_engine.py` — Fix Prioritization
**What it does:** Calculates which fixes break the most attack paths and reduces risk the most. Produces a prioritized remediation plan.

**Fix catalog it uses:**

| Category | Example fix | Effort | Risk reduction |
|----------|-------------|--------|----------------|
| SSL | Renew/fix certificate | < 2 hours | High |
| Security Headers | Add HSTS, CSP | 1 hour | Medium |
| Database | Firewall port 3306 | < 1 hour | Very High |
| Email | DMARC to p=reject | 4 hours | Medium |
| Admin Panel | Enforce MFA | 2 hours | High |

**Ranking logic:** The fix that breaks the most attack paths AND has the lowest implementation effort gets ranked #1.

---

### `intelligence_engine/timeline/snapshot_manager.py` — Historical Snapshots
**What it does:** Saves every scan as a JSON file in the `snapshots/` folder, organized by domain and timestamp. This enables the historical comparison in V5.

**Storage structure:**
```
snapshots/
  example_com/
    20240101_120000.json
    20240115_143000.json
    20240201_090000.json
```

Each snapshot is the complete intelligence report for that scan. The historical comparison reads these files and diffs them.

---

### `intelligence_engine/ai/llm_client.py` — AI Connection
**What it does:** Connects to an AI language model (Groq, Gemini, or Anthropic) and provides a simple `complete(system, user)` function that every AI module uses.

**Supported providers:**
- **Groq** — Free. Fast. Uses Llama 3.3 70B. Best for quick Q&A.
- **Gemini** — Google's model. Free tier available. Good quality.
- **Anthropic** — Claude. Best quality but paid.

---

### `intelligence_engine/ai/security_copilot.py` — AI Q&A
**What it does:** Answers natural-language security questions about the scan results. Strict rule: it can ONLY reference data that was provided to it in the context — it cannot invent findings.

**Predefined queries it supports:**
- "What is my most critical asset?"
- "Which attack path has the highest probability?"
- "Which remediation reduces the most risk?"
- "Show every internet-facing database."
- "What changed since the last scan?"

**How it works:**
1. Builds a context object with the full scan data (truncated to fit the LLM context window)
2. Sends it to the LLM with strict instructions not to invent anything
3. Returns the answer

---

### `intelligence_engine/ai/executive_summary.py` — Executive Report
**What it does:** Generates a non-technical executive summary of the scan, written for a CEO or board member who doesn't understand CVEs or port numbers.

**What the summary includes:**
- Overall risk posture in plain English
- Top 3 business risks (no technical jargon)
- Single most important immediate action
- Compliance exposure summary
- Scan coverage warning (if modules were disabled)

---

### `api_server.py` — Web API Server
**What it does:** A Flask web server that exposes the Python scan engine as a REST API for the React web interface.

**API endpoints:**
- `POST /api/scan` — Start a new scan, returns scan ID
- `GET /api/scan/{id}` — Get scan status and result
- `GET /api/scan/{id}/events` — SSE stream of live scan log
- `POST /api/ai` — Proxy AI requests to Gemini (fixes browser CORS)
- `GET /api/health` — Server health check

**Why the AI proxy is needed:** Browsers block direct calls to external APIs (CORS security restriction). The Flask server makes the call instead and returns the result to the browser.

---

### `src/App.jsx` — The React Web Interface
**What it does:** The complete web-based dashboard UI. 1700+ lines of React code that provides a visual interface to all scan data.

**The 15 dashboard tabs:**
1. **Overview** — Risk score, top findings, attack paths, world map
2. **Knowledge Graph** — Interactive node graph of all assets
3. **Asset Inventory** — Full table of all discovered assets
4. **Findings** — All security findings with severity badges
5. **Attack Simulation** — Step-by-step attack path animator
6. **Vulnerabilities** — CVEs with CVSS/EPSS/KEV status
7. **API Discovery** — All discovered API endpoints
8. **JS Intelligence** — Secrets found in JavaScript files
9. **Email Security** — SPF/DKIM/DMARC analysis
10. **TLS/SSL** — Certificate grades and CT timeline
11. **Secrets & Login** — Exposed files and login pages
12. **Compliance** — Violations across all frameworks
13. **History** — Risk trend and passive DNS history
14. **Remediation** — Prioritized fix plan
15. **Executive Report** — Non-technical summary

**Special features:**
- **AI Copilot panel** — Slides in from the right side. Sends questions to the Flask `/api/ai` endpoint which queries Gemini. 8 preset questions for quick analysis.
- **Attack Simulator** — Animates the attacker's movement through each step of an attack path with MITRE tags.
- **Asset side panel** — Click any asset to see its complete security picture.

---

## 7. The 4 Intelligence Phases

### Phase 1 — Collection (Collectors)
**Goal:** Gather raw data about the domain.
**Input:** Domain name (e.g., `example.com`)
**Output:** Complete asset profile JSON with DNS, SSL, HTTP, technology, email, infrastructure, and all subdomains.
**Time:** 30 seconds to 3 minutes depending on number of subdomains.

### Phase 2 — V3 Intelligence (engine.py)
**Goal:** Transform raw data into security intelligence.
**Input:** Asset profile from Phase 1
**Output:** Knowledge graph, attack paths, crown jewels, compliance map, remediation plan, AI summary.
**Time:** 15–60 seconds.

### Phase 3 — V4 Attack Graph (v4_engine.py)
**Goal:** Build precise, evidence-only attack chains and score every asset.
**Input:** Asset profile from Phase 1
**Output:** Asset correlation, exposure scores (0–100), attack chains with MITRE mapping, CVEs, API endpoints, JavaScript secrets.
**Time:** 30 seconds to 3 minutes (CVE lookup is the slow part).

### Phase 4 — V5 Enhanced Intelligence (v5_engine.py)
**Goal:** Add 17 additional intelligence capabilities.
**Input:** Asset profile + V4 report
**Output:** TLS grades, CT timeline, login pages, exposed secrets, passive DNS history, screenshots, CVE-enriched attack paths, historical comparison, risk trends.
**Time:** 1–5 minutes depending on number of assets and enabled modules.

---

## 8. The AI Copilot

The AI Copilot is the Q&A interface that lets you ask questions about the scan in plain English.

**How it works technically:**
1. Takes the scan data (up to 7000 characters of context)
2. Sends it to the AI model with a strict system prompt
3. The system prompt says: "Use ONLY the data provided. Never invent findings."
4. Returns the answer

**The strict grounding rule:** The AI cannot say things like "you might also have vulnerabilities in your mobile app" if the scan didn't find a mobile app. Every statement must come from actual scan data. This prevents hallucination — the biggest risk with AI in security tools.

**8 preset questions:**
1. Critical risks — what's most dangerous and what's the business impact?
2. Top attack path — walk through the most dangerous scenario step by step.
3. CEO briefing — non-technical summary for executive audience.
4. Fix priorities — prioritized remediation plan.
5. KEV CVEs — which CVEs are actively being exploited right now?
6. API security — what API data could be exfiltrated and how?
7. Compliance gaps — where do we violate PCI-DSS, GDPR, ISO 27001?
8. Crown jewels — which assets have the highest blast radius if compromised?

---

## 9. The Web Interface

The web interface has two parts:

### Flask Backend (`api_server.py`)
- Runs on port 5000
- Receives scan requests from the browser
- Runs the Python scan engine in a background thread
- Streams live scan progress via Server-Sent Events (SSE)
- Proxies AI requests to Gemini (because browsers can't call external APIs directly)

### React Frontend (`src/App.jsx`)
- Runs on port 3000 (development) or is served from Flask in production
- Communicates with the Flask backend via REST API calls to `localhost:5000`
- Shows live scan pipeline animation while scanning
- Displays all scan results across 15 tabs
- Hosts the AI Copilot panel

### Running it
```bash
# Terminal 1 - Backend
python api_server.py

# Terminal 2 - Frontend
npm start

# Open browser
http://localhost:3000
```

---

## 10. Risk Scoring Explained

The risk score (0–100) is calculated in layers:

### Layer 1 — Root Domain Score
Checks the main domain for: SSL validity, certificate expiry, security headers, CSP, email security (DMARC/DKIM), subdomain exposure, technology risks, DNS errors.

### Layer 2 — Asset Rollup (the important one)
Runs the same checks on every discovered subdomain individually, then takes the worst asset score.

### Layer 3 — Aggregation
```
final_score = (root_score × 40%) + (worst_asset_score × 60%)
```

The asset score is weighted higher because subdomain vulnerabilities (like an exposed database on `exam.company.com`) are often more dangerous than root domain issues.

### Severity Thresholds
| Score | Severity | Meaning |
|-------|----------|---------|
| 75–100 | CRITICAL | Immediate action required. Likely being actively scanned by attackers. |
| 50–74 | HIGH | Significant risk. Address within 1 week. |
| 25–49 | MEDIUM | Moderate risk. Address within 1 month. |
| 0–24 | LOW | Low risk. Address in next security cycle. |

---

## 11. Attack Paths Explained

Attack paths are the most important output of SentinelX because they show exactly how an attacker would exploit your weaknesses — not just what the weaknesses are.

### Structure of an Attack Path
```
{
  "name": "Direct Database Access via MySQL",
  "entry_point": "exam.company.com",
  "service": "MySQL",
  "port": 3306,
  "likelihood": 89,
  "steps": [
    { "step": 1, "actor": "Internet", "action": "Port scan finds MySQL 3306 open", "technique": "T1595" },
    { "step": 2, "actor": "Attacker", "action": "Connect directly — no firewall blocking", "technique": "T1190" },
    { "step": 3, "actor": "MySQL",    "action": "Brute force or default credentials", "technique": "T1110" },
    { "step": 4, "actor": "Database", "action": "Extract all tables and data", "technique": "T1213" }
  ],
  "mitre_chain": ["T1595", "T1190", "T1110", "T1213"],
  "business_impact": "Complete database breach — all student exam records exposed",
  "skill_required": "Script Kiddie",
  "kev_matched": false,
  "likelihood": 89
}
```

### Likelihood Score
How it's calculated:
- Open port confirmed by scan = base 70%
- Service responds to connection = +10%
- No WAF/firewall detected = +5%
- CVE exists for this service = +5%
- EPSS boost = up to +15%
- On CISA KEV = +10%

### Skill Level Labels
- **Script Kiddie** — Anyone can do this with a tutorial and basic tools
- **Intermediate** — Needs some technical knowledge and scripting
- **Advanced** — Requires deep knowledge and custom tooling
- **Nation State** — Requires zero-days and sophisticated tradecraft

---

## 12. How to Explain This to Anyone

### If someone asks "What does SentinelX do?"
> "It's an automated security scanner for websites and web applications. You give it a domain name and it maps everything the company has exposed to the internet, finds security weaknesses, simulates how an attacker would actually exploit those weaknesses step by step, and tells you what to fix first. It also has an AI assistant that can answer security questions in plain English."

### If someone asks "How is this different from a normal security scanner?"
> "Normal scanners check if a website is up and look for obvious vulnerabilities. SentinelX goes much deeper — it discovers hidden subdomains the company might not know about, maps how all assets are connected to each other, builds full attack scenarios showing every step an attacker would take, and tracks how the security posture changes over time. It also identifies which assets are most critical to the business, so you know what to protect first."

### If someone asks "What is an attack surface?"
> "Everything your company has on the internet that someone could try to attack. Your website is obvious, but you also have subdomains, APIs, admin panels, mail servers, login pages — and possibly old development servers you forgot about. The attack surface is the sum total of all of that. Most companies don't know how big their attack surface really is."

### If someone asks "What is a CVE?"
> "It's like a publicly known bug ID for software. When someone discovers a security flaw in software like Apache or WordPress, they report it and it gets an official ID number — like CVE-2024-21887. That number goes into a public database. Attackers use this database to find which companies are running vulnerable software. Our platform checks your technology against this database to see if you have any known vulnerable software."

### If someone asks "What is an attack path?"
> "An attack path shows exactly how a hacker would break into your system — step by step. It's not just 'you have a vulnerability' — it's 'here's how an attacker finds it, connects to it, gets in, and reaches your sensitive data.' Every step is based on real evidence from the scan. This is important because it shows you what the actual impact would be, not just the theoretical risk."

### If someone asks "What does the AI Copilot do?"
> "It's an AI assistant trained on the scan data. You can ask it questions in plain English — like 'what's my biggest risk?' or 'write me a security briefing for my CEO' — and it answers using only the real data from the scan. It can't make things up because it's strictly grounded to the scan results."

### If someone asks "What is a crown jewel in security?"
> "A crown jewel is an asset that, if an attacker compromised it, would give them the keys to the kingdom. For example, the authentication server — because if you control authentication, you control who can log into everything. Or the core API that holds all customer data. We identify these specifically so you know exactly what to protect most."

---

## Quick Reference — Platform at a Glance

| What | Answer |
|------|--------|
| Language | Python (backend) + React (frontend) |
| Entry point | `python run.py domain.com` |
| Web server | Flask on port 5000 |
| Web UI | React on port 3000 |
| AI providers | Gemini, Groq (free), Anthropic |
| Output formats | Terminal report + JSON files |
| Report location | `reports/` folder |
| Snapshots | `snapshots/` folder |
| Scan phases | 4 (Collection, V3, V4, V5) |
| Subdomain methods | 8 parallel sources |
| Intelligence modules | 17 in V5 |
| Dashboard tabs | 15 |
| Risk score range | 0–100 |
| Severity levels | LOW / MEDIUM / HIGH / CRITICAL |
| Compliance frameworks | PCI-DSS, GDPR, ISO 27001, NIST, OWASP |
| Graph database | Neo4j (optional) |
| Attack path sources | V4 chains + V5 CVE enrichment |

---

*Documentation version: SentinelX V5 — covers all fixes through Priority 1–6 (risk aggregation, SSL attribution, canonical attack paths, exposure labelling, scan coverage, executive summary).*

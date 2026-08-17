<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0a0a0a,50:FF6B00,100:0a0a0a&height=200&section=header&text=SentinelX%20V5&fontSize=60&fontColor=FF6B00&fontAlignY=38&desc=Enterprise%20Attack%20Surface%20Management%20Platform&descAlignY=58&descColor=ffffff&animation=fadeIn" width="100%"/>

<br/>

[![Live Demo](https://img.shields.io/badge/🌐%20LIVE%20DEMO-Visit%20Site-FF6B00?style=for-the-badge&logoColor=black)](https://victorprasad0026.github.io/web_asm/)
[![Documentation](https://img.shields.io/badge/📚%20DOCUMENTATION-Read%20Docs-FF8C00?style=for-the-badge&logoColor=white)](https://github.com/VictorPrasad0026/web_asm/blob/main/SENTINELX_DOCUMENTATION.md)
[![Backend](https://img.shields.io/badge/⚙️%20BACKEND-Private%20Repo-1a1a1a?style=for-the-badge&logoColor=white)](https://github.com/VictorPrasad0026/sentinelx-backend)

<br/>

> **Find your attack surface before attackers do.**
>
> Automated reconnaissance · Threat intelligence · AI-powered analysis · From a single domain to a complete security picture in seconds.

<br/>

![Python](https://img.shields.io/badge/Python-3.11-FF6B00?style=flat-square&logo=python&logoColor=white)
![React](https://img.shields.io/badge/React-18-FF8C00?style=flat-square&logo=react&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-3.0-1a1a1a?style=flat-square&logo=flask&logoColor=FF6B00)
![Groq](https://img.shields.io/badge/Groq-AI-FF6B00?style=flat-square&logoColor=white)
![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-181717?style=flat-square&logo=github&logoColor=white)

</div>

---

## 🎯 What is SentinelX?

SentinelX is a **full-stack enterprise Attack Surface Management (ASM) platform** built in Python + React. You give it a domain name and it automatically:

- 🔍 **Discovers** everything the target exposes to the internet
- 🧠 **Analyzes** each asset for vulnerabilities, misconfigurations, and secrets
- 🎯 **Simulates** how an attacker would chain weaknesses into a full breach
- 📊 **Reports** findings in both technical and executive language with AI assistance

```
You type: target.com
               ↓
  ┌────────────────────────────┐
  │   39-Stage Pipeline        │
  │                            │
  │  Phase 1 — Recon           │  DNS, Subdomains, CT Logs
  │  Phase 2 — Enumeration     │  ASN, Cloud, WAF, GeoIP
  │  Phase 3 — Deep Analysis   │  TLS, Headers, Email, CSP
  │  Phase 4 — Intelligence    │  Secrets, APIs, JS, Login
  │  Phase 5 — Correlation     │  CVEs, KEV, Graph, Crown Jewels
  │  Phase 6 — Synthesis       │  Attack Paths, Risk Score, AI
  └────────────────────────────┘
               ↓
  ┌────────────────────────────┐
  │   Full Security Dashboard  │
  │   15 tabs · AI Copilot     │
  │   Risk Score 0-100         │
  └────────────────────────────┘
```

---

## ⚡ Features

<table>
<tr>
<td width="50%">

### 🔍 Reconnaissance
- Subdomain discovery via 8 parallel sources
- Certificate Transparency logs (crt.sh)
- Passive DNS history (HackerTarget)
- ASN & GeoIP enrichment
- WHOIS intelligence
- Zone transfer detection

### 🎯 Attack Intelligence
- Evidence-only attack path construction
- MITRE ATT&CK technique mapping
- Step-by-step adversary simulation
- Exploitation likelihood scoring
- Business impact translation
- KEV-enriched attack chains

### 🤖 AI Security Copilot
- Powered by Groq LLM
- 8 preset security queries
- Executive briefing generation
- Evidence-grounded responses only
- Natural language Q&A

</td>
<td width="50%">

### 🔐 Deep Analysis
- TLS/SSL grading (A+ to F)
- Security header analysis
- CSP policy evaluation
- Email security (SPF/DKIM/DMARC)
- Login page detection
- Default credential risk assessment

### 💀 Vulnerability Intelligence
- NVD CVE database lookup
- CISA KEV correlation
- EPSS exploitation probability
- CVSS severity scoring
- Prioritized remediation plan

### ⚖️ Compliance Mapping
- PCI-DSS violations
- GDPR Article mapping
- ISO 27001 controls
- NIST CSF alignment
- OWASP Top 10 mapping

</td>
</tr>
</table>

---

## 🖥️ Dashboard — 15 Tabs

| # | Tab | What it shows |
|---|-----|---------------|
| 01 | 🏠 Overview | Risk score, KPIs, crown jewels, world map |
| 02 | 🕸️ Knowledge Graph | Interactive asset relationship visualization |
| 03 | 🖥️ Asset Inventory | Full table of all discovered assets |
| 04 | ⚠️ Findings | CVE/MITRE mapped security findings |
| 05 | 🎯 Attack Simulation | Step-by-step adversary path animator |
| 06 | 💀 Vulnerabilities | CVEs with CVSS, EPSS, KEV status |
| 07 | 🔌 API Discovery | REST/GraphQL endpoints with auth analysis |
| 08 | 📝 JS Intelligence | Secrets found in JavaScript files |
| 09 | ✉️ Email Security | SPF/DKIM/DMARC configuration |
| 10 | 🔐 TLS/SSL | Certificate grades + CT log timeline |
| 11 | 🗝️ Secrets | Exposed files and login page detection |
| 12 | ⚖️ Compliance | PCI-DSS, GDPR, ISO27001, NIST, OWASP |
| 13 | 📅 History | Risk trend + passive DNS history |
| 14 | 🔨 Remediation | Prioritized fix plan with effort estimates |
| 15 | 📊 Exec Report | AI-generated non-technical summary |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    React UI (Frontend)                   │
│         Landing → Scan View → 15-Tab Dashboard          │
│              AI Copilot Panel (Groq LLM)                │
└──────────────────────┬──────────────────────────────────┘
                       │ REST API
┌──────────────────────▼──────────────────────────────────┐
│                  Flask API Server                        │
│              /api/scan  /api/ai  /api/health             │
└──────┬───────────────┬─────────────────┬────────────────┘
       │               │                 │
┌──────▼──────┐ ┌──────▼──────┐ ┌───────▼──────┐
│  Collectors │ │  V4 Engine  │ │  V5 Engine   │
│ DNS · SSL   │ │ Asset Corr. │ │ TLS Grading  │
│ Subdomains  │ │ Attack Graph│ │ Login Detect │
│ HTTP · Tech │ │ CVE Intel   │ │ Secrets Scan │
│ Email · ASN │ │ API Discov. │ │ Passive DNS  │
└─────────────┘ └─────────────┘ └──────────────┘
       │
┌──────▼──────────────────────────────────────────────────┐
│              Business Intelligence Layer                 │
│   Crown Jewels · Compliance · Business Impact · AI      │
└─────────────────────────────────────────────────────────┘
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | React 18, Canvas animations, SVG graphs |
| **Backend** | Python 3.11, Flask, REST API |
| **AI** | Groq LLM (`openai/gpt-oss-120b`) |
| **Intelligence** | NVD, CISA KEV, EPSS, crt.sh, HackerTarget |
| **Frontend Host** | GitHub Pages |
| **Backend Host** | Render |

---

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/VictorPrasad0026/web_asm.git
cd web_asm

# Install dependencies
npm install

# Start development server
npm start
```

Open [http://localhost:3000](http://localhost:3000)

---

## 📁 Project Structure

```
web_asm/
├── src/
│   ├── App.jsx                     ← Full React UI (1900+ lines)
│   └── index.js                    ← Entry point
├── public/
│   └── index.html
├── api_server.py                   ← Flask backend API
├── package.json
├── SENTINELX_DOCUMENTATION.md     ← Full platform docs
└── README.md
```

---

## 🔗 Links

| Resource | Link |
|----------|------|
| 🌐 Live Demo | [victorprasad0026.github.io/web_asm](https://victorprasad0026.github.io/web_asm/) |
| 📚 Documentation | [SENTINELX_DOCUMENTATION.md](https://github.com/VictorPrasad0026/web_asm/blob/main/SENTINELX_DOCUMENTATION.md) |
| ⚙️ Backend | [sentinelx-backend](https://github.com/VictorPrasad0026/sentinelx-backend) (Private) |
| 👤 Author | [VictorPrasad0026](https://github.com/VictorPrasad0026) |

---

## 🤖 AI Copilot Examples

```
"What are my most critical vulnerabilities?"
→ Lists CRITICAL findings with CVE IDs, CVSS scores, and business impact

"Generate a CEO briefing on our security posture"
→ Non-technical executive summary with risk score and top 3 business risks

"Walk me through the most dangerous attack path"
→ Step-by-step adversary simulation with MITRE ATT&CK techniques

"What compliance violations do we have?"
→ Maps findings to PCI-DSS, GDPR, ISO27001, NIST, OWASP controls
```

---

<div align="center">

**Built for security professionals who need answers, not just data.**

⭐ **Star this repo if you find it useful!**

[![Star](https://img.shields.io/github/stars/VictorPrasad0026/web_asm?style=for-the-badge&logo=github&color=FF6B00&logoColor=white)](https://github.com/VictorPrasad0026/web_asm/stargazers)

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0a0a0a,50:FF6B00,100:0a0a0a&height=100&section=footer" width="100%"/>

</div>

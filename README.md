# SentinelX V5 — Web Interface

## Folder Structure
```
sentinelx_web/
├── install.sh          ← Run this FIRST (one time)
├── start.sh            ← Run this to start the app
├── api_server.py       ← Flask backend API
├── requirements.txt    ← Python packages
├── package.json        ← React packages
├── public/
│   └── index.html
└── src/
    ├── index.js
    └── App.jsx         ← The full SentinelX UI
```

## Steps

### Step 1 — Copy this folder next to your sentinelx folder
```
your-projects/
  sentinelx/          ← your existing Python code
  sentinelx_web/      ← this folder
```

### Step 2 — Open terminal inside sentinelx_web
```bash
cd sentinelx_web
```

### Step 3 — Install (one time only)
```bash
bash install.sh
```

### Step 4 — Start the app
```bash
bash start.sh
```

### Step 5 — Open browser
```
http://localhost:3000
```

---

## Set AI Key (optional — for AI Copilot)
```bash
export ANTHROPIC_API_KEY=sk-ant-...
# or
export GROQ_API_KEY=gsk_...
```

## Run a real scan
The UI connects to the Flask API which runs your Python scan engine.
Type any domain in the search box and click Scan.

---

## Troubleshooting

**Node.js not found:**
Download from https://nodejs.org (LTS version)

**pip not found:**
```bash
python3 -m pip install flask flask-cors
```

**Port 3000 in use:**
```bash
PORT=3001 npm start
```

**CORS error in browser:**
Make sure api_server.py is running (Flask must be on port 5000)

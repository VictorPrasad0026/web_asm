#!/bin/bash
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   SentinelX V5 — Web Setup              ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
  echo "❌  Node.js not found."
  echo "    Install it from: https://nodejs.org"
  echo "    Then re-run this script."
  exit 1
fi
echo "✓  Node.js $(node -v) found"

# Check Python
if ! command -v python3 &> /dev/null; then
  echo "❌  Python3 not found."
  exit 1
fi
echo "✓  Python $(python3 --version) found"

# Install Python deps
echo ""
echo "→  Installing Python packages..."
pip3 install flask flask-cors dnspython requests python-whois ipwhois --quiet
echo "✓  Python packages installed"

# Install React deps
echo ""
echo "→  Installing React packages (may take a minute)..."
npm install --silent
echo "✓  React packages installed"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   ✅  Setup complete!                    ║"
echo "║                                          ║"
echo "║   Now run:  bash start.sh                ║"
echo "╚══════════════════════════════════════════╝"
echo ""

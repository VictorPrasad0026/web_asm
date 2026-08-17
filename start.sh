#!/bin/bash
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   SentinelX V5 — Starting               ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "→  Starting Flask API on  http://localhost:5000"
echo "→  Starting React UI  on  http://localhost:3000"
echo ""
echo "   Open your browser at: http://localhost:3000"
echo "   Press Ctrl+C to stop."
echo ""

# Start Flask in background
python3 api_server.py &
FLASK_PID=$!

# Start React dev server
npm start

# When React exits, kill Flask too
kill $FLASK_PID 2>/dev/null

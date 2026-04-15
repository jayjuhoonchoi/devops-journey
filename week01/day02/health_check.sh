#!/bin/bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "=============================="
echo "  Server Health Check"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================="

echo ""
echo "[CPU]"
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
echo "CPU Usage: ${CPU}%"

echo ""
echo "[Memory]"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
echo "Memory: ${MEM_USED}MB / ${MEM_TOTAL}MB"

echo ""
echo "[Disk]"
df -h / | awk 'NR==2 {print "Disk: " $3 " / " $2 " (" $5 " used)"}'

echo ""
echo "[Status]"
echo -e "${GREEN}All checks done!${NC}"

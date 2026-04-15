#!/bin/bash
set -euo pipefail


LOG_DIR="/var/log"
DAYS=7

echo "=============================="
echo "  Log Cleanup Script"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================="


echo ""
echo "[7일 이상 된 로그 파일 목록]"
find $LOG_DIR -name "*.log" -mtime +$DAYS 2>/dev/null


echo ""
echo "[삭제 완료]"
find $LOG_DIR -name "*.log" -mtime +$DAYS -delete 2>/dev/null
echo "오래된 로그 정리 완료!"




#!/bin/bash
set -euo pipefail

SOURCE_DIR="$HOME/devops-journey"
BACKUP_DIR="$HOME/backups"
DATE=$(date '+%Y-%m-%d')
BACKUP_FILE="backup_${DATE}.tar.gz"

echo "==============================="
echo "  Backup Script"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "==============================="


mkdir -p $BACKUP_DIR
tar -czf $BACKUP_DIR/$BACKUP_FILE $SOURCE_DIR


echo ""
echo "[백업 완료]"
echo "파일: $BACKUP_DIR/$BACKUP_FILE"
echo "크기: $(du -h $BACKUP_DIR/$BACKUP_FILE | cut -f1)"

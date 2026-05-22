#!/bin/bash

BASE_DIR="$HOME/infra-baselines"

echo "========================================="
echo "   BVRINFRA SNAPSHOT CLEANUP"
echo "========================================="
echo

echo "[+] Removing snapshots older than 7 days..."

find "$BASE_DIR" -type f \
\( -name "health-*.log" \
-o -name "pressure-*.log" \
-o -name "trend-*.log" \
-o -name "upgrade-*.log" \) \
-mtime +7 -delete

echo "[+] Removing cron logs older than 14 days..."

find "$BASE_DIR" -type f \
-name "snapshot-cron.log" \
-mtime +14 -delete

echo
echo "[+] Remaining snapshot files:"
echo

ls -lh "$BASE_DIR"

echo
echo "Cleanup completed."
echo

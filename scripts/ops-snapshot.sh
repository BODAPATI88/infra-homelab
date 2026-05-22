#!/bin/bash

TIMESTAMP=$(date +%F-%H%M)

BASE_DIR="$HOME/infra-baselines"

mkdir -p "$BASE_DIR"

echo "========================================="
echo "   BVRINFRA OPERATIONAL SNAPSHOT"
echo "========================================="
echo
echo "Timestamp: $TIMESTAMP"
echo

# =========================================
# HEALTH SNAPSHOT
# =========================================

echo "[+] Capturing cluster health..."

{
echo "===== DAILY HEALTH REPORT ====="
echo
echo "=== Cluster ==="
kubectl get nodes
echo
echo "=== Node Usage ==="
kubectl top nodes
echo
echo "=== Problem Pods ==="
kubectl get pods -A | grep -Ei "CrashLoopBackOff|Error|Pending" || echo "No failed pods"
echo
echo "=== Restart Leaders ==="
kubectl get pods -A --sort-by=.status.containerStatuses[0].restartCount | tail
echo
echo "=== Ingress ==="
kubectl get ingress -A
echo
echo "=== Certificates ==="
kubectl get certificates -A
echo
echo "=== PVC Usage ==="
kubectl get pvc -A
echo
echo "=== Disk ==="
df -h /
echo
echo "=== Memory ==="
free -h
} > "$BASE_DIR/health-$TIMESTAMP.log"

# =========================================
# PRESSURE SNAPSHOT
# =========================================

echo "[+] Capturing cluster pressure..."

{
echo "===== CLUSTER PRESSURE ====="
echo
kubectl top nodes
echo
echo "=== High Memory Pods ==="
kubectl top pods -A --sort-by=memory | head -20
echo
echo "=== PVC Usage ==="
kubectl get pvc -A
} > "$BASE_DIR/pressure-$TIMESTAMP.log"

# =========================================
# TREND SNAPSHOT
# =========================================

echo "[+] Capturing resource trends..."

{
echo "===== RESOURCE TREND ====="
echo
kubectl top nodes
echo
echo "=== Top Memory Pods ==="
kubectl top pods -A --sort-by=memory | head -20
} > "$BASE_DIR/trend-$TIMESTAMP.log"

# =========================================
# UPGRADE SNAPSHOT
# =========================================

echo "[+] Capturing upgrade readiness..."

{
echo "===== UPGRADE READINESS ====="
echo
echo "=== Nodes ==="
kubectl get nodes
echo
echo "=== Failed Pods ==="
kubectl get pods -A | grep -Ei "CrashLoopBackOff|Error|Pending" || echo "No failed pods"
echo
echo "=== PVCs ==="
kubectl get pvc -A
echo
echo "=== Certificates ==="
kubectl get certificates -A
echo
echo "=== Ingress ==="
kubectl get ingress -A
} > "$BASE_DIR/upgrade-$TIMESTAMP.log"

# =========================================
# COMPLETE
# =========================================

echo
echo "========================================="
echo " Snapshot Completed Successfully"
echo "========================================="
echo

echo "Saved files:"
echo

ls -lh "$BASE_DIR" | tail

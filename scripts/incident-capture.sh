#!/bin/bash

TIMESTAMP=$(date +%F-%H%M)

BASE_DIR="$HOME/incident-captures/$TIMESTAMP"

mkdir -p "$BASE_DIR"

echo "========================================="
echo "   BVRINFRA INCIDENT CAPTURE"
echo "========================================="
echo
echo "Incident Timestamp: $TIMESTAMP"
echo

# =========================================
# CLUSTER NODES
# =========================================

echo "[+] Capturing node status..."

kubectl get nodes -o wide > "$BASE_DIR/nodes.log"

kubectl describe nodes > "$BASE_DIR/nodes-describe.log"

# =========================================
# POD STATES
# =========================================

echo "[+] Capturing pod states..."

kubectl get pods -A -o wide > "$BASE_DIR/pods.log"

kubectl get pods -A | grep -Ei "CrashLoop|Error|Pending|Evicted" \
> "$BASE_DIR/problem-pods.log"

# =========================================
# EVENTS
# =========================================

echo "[+] Capturing cluster events..."

kubectl get events -A --sort-by=.metadata.creationTimestamp \
> "$BASE_DIR/events.log"

# =========================================
# RESOURCE PRESSURE
# =========================================

echo "[+] Capturing resource pressure..."

kubectl top nodes > "$BASE_DIR/top-nodes.log"

kubectl top pods -A --sort-by=memory \
> "$BASE_DIR/top-pods-memory.log"

# =========================================
# PVC STATE
# =========================================

echo "[+] Capturing PVC state..."

kubectl get pvc -A > "$BASE_DIR/pvc.log"

# =========================================
# INGRESS STATE
# =========================================

echo "[+] Capturing ingress state..."

kubectl get ingress -A > "$BASE_DIR/ingress.log"

# =========================================
# CERTIFICATES
# =========================================

echo "[+] Capturing certificate state..."

kubectl get certificates -A > "$BASE_DIR/certificates.log"

# =========================================
# SYSTEM HEALTH
# =========================================

echo "[+] Capturing system health..."

df -h > "$BASE_DIR/disk.log"

free -h > "$BASE_DIR/memory.log"

uptime > "$BASE_DIR/uptime.log"

# =========================================
# RESTART ANALYSIS
# =========================================

echo "[+] Capturing restart leaders..."

kubectl get pods -A \
--sort-by=.status.containerStatuses[0].restartCount \
> "$BASE_DIR/restarts.log"

# =========================================
# COMPLETE
# =========================================

echo
echo "========================================="
echo " Incident Capture Completed"
echo "========================================="
echo

echo "Evidence stored at:"
echo "$BASE_DIR"
echo

tree "$BASE_DIR"

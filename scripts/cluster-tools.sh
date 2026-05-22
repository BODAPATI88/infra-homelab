#!/bin/bash

# =========================
# CLUSTER HEALTH
# =========================

alias khealth='
echo "===== DAILY HEALTH REPORT =====" &&
echo &&
echo "=== Cluster ===" &&
kubectl get nodes &&
echo &&
echo "=== Node Usage ===" &&
kubectl top nodes &&
echo &&
echo "=== Problem Pods ===" &&
kubectl get pods -A | grep -Ei "CrashLoopBackOff|Error|Pending" || echo "No failed pods" &&
echo &&
echo "=== Restart Leaders ===" &&
kubectl get pods -A --sort-by=.status.containerStatuses[0].restartCount | tail &&
echo &&
echo "=== Ingress ===" &&
kubectl get ingress -A &&
echo &&
echo "=== Certificates ===" &&
kubectl get certificates -A &&
echo &&
echo "=== PVC Usage ===" &&
kubectl get pvc -A &&
echo &&
echo "=== Disk ===" &&
df -h / &&
echo &&
echo "=== Memory ===" &&
free -h
'

# =========================
# RESOURCE TREND
# =========================

alias ktrend='
echo "===== RESOURCE TREND =====" &&
echo &&
kubectl top nodes &&
echo &&
echo "=== Top Memory Pods ===" &&
kubectl top pods -A --sort-by=memory | head -20
'

# =========================
# PRESSURE VALIDATION
# =========================

alias kpressure='
echo "===== CLUSTER PRESSURE =====" &&
echo &&
kubectl top nodes &&
echo &&
echo "=== High Memory Pods ===" &&
kubectl top pods -A --sort-by=memory | head -20 &&
echo &&
echo "=== PVC Usage ===" &&
kubectl get pvc -A
'

# =========================
# UPGRADE READINESS
# =========================

alias kupgrade-ready='
echo "===== UPGRADE READINESS =====" &&
echo &&
echo "=== Nodes ===" &&
kubectl get nodes &&
echo &&
echo "=== Failed Pods ===" &&
kubectl get pods -A | grep -Ei "CrashLoopBackOff|Error|Pending" || echo "No failed pods" &&
echo &&
echo "=== PVCs ===" &&
kubectl get pvc -A &&
echo &&
echo "=== Certificates ===" &&
kubectl get certificates -A &&
echo &&
echo "=== Ingress ===" &&
kubectl get ingress -A
'

# =========================
# INCIDENT MODE
# =========================

alias kincident='
echo "===== INCIDENT MODE =====" &&
echo &&
kubectl get pods -A &&
echo &&
kubectl get events -A --sort-by=.lastTimestamp | head -20 &&
echo &&
kubectl top nodes &&
echo &&
kubectl top pods -A --sort-by=memory | head -20
'

# =========================
# FULL VALIDATION
# =========================

alias kfull='
khealth &&
echo &&
ktrend &&
echo &&
kpressure
'

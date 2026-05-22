#!/bin/bash

DATE=$(date)

LOG=~/ops-logs/cluster-history.log

echo "===== $DATE =====" >> $LOG

echo "--- Nodes ---" >> $LOG
kubectl top nodes >> $LOG

echo "" >> $LOG

echo "--- Failed Pods ---" >> $LOG
kubectl get pods -A | grep -E "CrashLoop|Error|Pending|Evicted" >> $LOG

echo "" >> $LOG

echo "--- Disk ---" >> $LOG
df -h / >> $LOG

echo "" >> $LOG

echo "--- Memory ---" >> $LOG
free -h >> $LOG

echo "" >> $LOG
echo "" >> $LOG

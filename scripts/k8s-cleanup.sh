#!/bin/bash

echo "===== Kubernetes Cleanup $(date) ====="

kubectl get pods -A | grep Evicted | awk '{print $1 " " $2}' | while read ns pod
do
  kubectl delete pod $pod -n $ns
done

kubectl get pods -A | grep Completed | awk '{print $1 " " $2}' | while read ns pod
do
  kubectl delete pod $pod -n $ns
done

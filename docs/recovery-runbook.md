# Homelab Recovery Runbook

## Proxmox Host
IP: 192.168.29.173
Hostname: bgroups

## Kubernetes Nodes
k8s-master:
k8s-worker1:
k8s-worker2:

## Cloudflare Tunnel
Tunnel Name: k8s-homelab

## Public URLs
https://argocd.bvrinfra.in
https://grafana.bvrinfra.in
https://demo.bvrinfra.in
https://proxmox.bvrinfra.in

## Backup Locations
External HDD:
GitHub Repo:

## Important Paths
/home/ravi/infra-git
/mnt/backup-drive

## Helm Releases
grafana
traefik
traefik-crd

## Restore Procedure
1.
2.
3.

## Critical Commands
kubectl get pods -A
helm list -A
kubectl get ingress -A

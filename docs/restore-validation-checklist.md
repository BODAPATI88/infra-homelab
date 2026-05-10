# Restore Validation Checklist

## Critical Recovery Assets

### External Backup Storage
- NFS export reachable
- Backup archives readable
- Backup archive integrity verified

Validation:
ls -lh /mnt/k8s-backups
tar -tzf <backup-file>.tar.gz | head

---

## GitHub Infrastructure Repo

Repository:
https://github.com/BODAPATI88/infra-homelab

Validation:
git pull
git log --oneline

---

## Kubernetes Cluster Recovery Order

1. Restore Proxmox host
2. Restore Kubernetes VMs
3. Restore networking
4. Reinstall K3s
5. Restore Traefik
6. Restore Cloudflare tunnel
7. Restore ArgoCD
8. Restore GitOps repo
9. Restore ingress manifests
10. Restore monitoring stack
11. Restore PVC-backed workloads

---

## Critical Kubernetes Objects

Validation Commands:

kubectl get nodes
kubectl get pods -A
kubectl get ingress -A
kubectl get pvc -A
kubectl get applications -n argocd

---

## External Access Validation

curl -I https://argocd.bvrinfra.in
curl -I https://grafana.bvrinfra.in

---

## Grafana Persistence Validation

kubectl get pvc -n monitoring

Verify dashboards survive pod restart.

---

## Backup Automation Validation

crontab -l

Check:
- daily backup execution
- archive creation
- NFS storage availability

---

## Known Technical Debt

- ingress reconciliation drift
- NodePort ingress architecture
- historical kube-system Traefik release metadata
- monitoring stack incomplete

---

## Recovery Success Criteria

Recovery considered successful when:

- cluster nodes healthy
- ingress functional
- applications reachable
- Grafana persistent data intact
- ArgoCD syncing
- backups operational

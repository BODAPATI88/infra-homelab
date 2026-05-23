# BVRINFRA CLUSTER RECOVERY RUNBOOK

# 1. PLATFORM OVERVIEW

## Cluster Nodes

| Node | Role | Specs |
|------|------|------|
| k8s-master | control-plane | i5 / 8GB / 1TB SSD |
| k8s-worker1 | worker | existing |
| k8s-worker2 | worker | existing |

## Core Stack

- K3s
- MetalLB
- Traefik
- Cert-Manager
- ArgoCD
- Prometheus
- Grafana
- Loki
- Promtail

---

# 2. PREREQUISITES

## Ubuntu Preparation

Run on all nodes:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git vim
```

Set hostname:

```bash
sudo hostnamectl set-hostname <hostname>
```

Update `/etc/hosts`.

Disable swap:

```bash
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
```

Reboot.

---

# 3. INSTALL K3S MASTER

```bash
curl -sfL https://get.k3s.io | sh -
```

Verify:

```bash
kubectl get nodes
```

Get join token:

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

---

# 4. JOIN WORKER NODES

Run on workers:

```bash
curl -sfL https://get.k3s.io | K3S_URL=https://<MASTER-IP>:6443 K3S_TOKEN=<TOKEN> sh -
```

Verify cluster:

```bash
kubectl get nodes -o wide
```

---

# 5. RESTORE GIT REPOSITORY

```bash
git clone https://github.com/BODAPATI88/infra-homelab.git ~/infra-git
```

---

# 6. INSTALL METALLB

Apply manifests.

Verify:

```bash
kubectl get pods -n metallb-system
```

Verify IP allocation pool.

---

# 7. INSTALL TRAEFIK

Apply Helm values from:

```text
helm-values/traefik-k3s-values.yaml
helm-values/traefik-custom-values.yaml
```

Verify ingress:

```bash
kubectl get ingress -A
```

---

# 8. INSTALL CERT-MANAGER

Install CRDs.

Install cert-manager.

Verify:

```bash
kubectl get pods -n cert-manager
```

Check certificates:

```bash
kubectl get certificates -A
```

---

# 9. RESTORE GOVERNANCE

Apply:

```text
governance/
```

Commands:

```bash
kubectl apply -f governance/
```

Verify:

```bash
kubectl get limitrange -A
kubectl get resourcequota -A
```

---

# 10. INSTALL MONITORING STACK

Use:

```text
helm-values/monitoring-optimized.yaml
```

Verify:

```bash
kubectl get pods -n monitoring
kubectl top nodes
```

---

# 11. INSTALL LOGGING STACK

Use:

```text
helm-values/loki-values.yaml
```

Verify:

```bash
kubectl get pods -n logging
```

---

# 12. RESTORE BACKUP SCRIPTS

Copy:

```text
scripts/
```

Restore aliases:

```bash
source ~/.bashrc
```

Verify commands:

- khealth
- kpressure
- ktrend
- kupgrade-ready
- ksnapshot
- kincident

---

# 13. RESTORE BACKUPS

Backup location:

```text
~/backups/k3s/
```

Current active structure:

- infra-git/
- manifests/
- state/
- logs/

---

# 14. VALIDATION CHECKLIST

## Cluster

```bash
kubectl get nodes
```

## Workloads

```bash
kubectl get pods -A
```

## Ingress

```bash
kubectl get ingress -A
```

## Certificates

```bash
kubectl get certificates -A
```

## Resource Usage

```bash
kubectl top nodes
```

## Logging

Verify Loki datasource in Grafana.

## Monitoring

Verify Prometheus targets healthy.

---

# 15. KNOWN PLATFORM CONSTRAINTS

- Limited memory environment
- Observability stack optimized for low-resource operation
- Loki canary disabled
- Governance enforced via quotas and limitranges
- Monitoring admission hooks unstable on constrained hardware

---

# 16. RECOVERY PRIORITIES

Order of importance:

1. K3s control plane
2. Git repository
3. Networking
4. Ingress
5. Certificates
6. Governance
7. Monitoring
8. Logging
9. Applications


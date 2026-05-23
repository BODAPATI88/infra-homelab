# BVR Infra Homelab Platform

## Overview

BVR Infra is a self-hosted Kubernetes homelab platform focused on infrastructure engineering, GitOps workflows, observability, automation, governance, and operational reliability.

The platform is built around lightweight infrastructure principles using K3s, ArgoCD, Prometheus, Grafana, Loki, Traefik, and MetalLB.

This repository contains:
- Kubernetes manifests
- GitOps applications
- operational automation
- governance standards
- monitoring configurations
- recovery procedures
- infrastructure documentation

---

# Platform Goals

- Build production-style infrastructure engineering experience
- Develop Kubernetes operational discipline
- Implement GitOps deployment workflows
- Practice observability engineering
- Build reusable infrastructure standards
- Validate resilience and recovery operations
- Maintain stable operations under constrained hardware

---

# Infrastructure Overview

## Kubernetes Distribution

- K3s

## GitOps

- ArgoCD

## Ingress

- Traefik

## Monitoring

- Prometheus
- Grafana

## Logging

- Loki
- Promtail

## Load Balancer

- MetalLB

## Remote Access

- Tailscale

---

# Cluster Architecture

## Nodes

### k8s-master

Role:
- control-plane
- ingress
- cluster services

### k8s-worker1

Role:
- application workloads
- apps namespace

### k8s-worker2

Role:
- monitoring workloads
- logging workloads
- observability stack

---

# Namespace Layout

| Namespace | Purpose |
|---|---|
| apps | business applications |
| monitoring | observability stack |
| logging | centralized logging |
| argocd | GitOps controllers |
| kube-system | cluster system services |
| metallb-system | load balancer services |

---

# Current Features

## GitOps Deployment Workflow

- GitHub-driven manifests
- ArgoCD reconciliation
- rollout validation
- rollback support

## Deployment Standards

- readiness probes
- liveness probes
- resource requests
- resource limits
- rolling updates
- revision retention

## Monitoring Stack

- Prometheus metrics
- Grafana dashboards
- Loki centralized logs
- node metrics
- kube-state metrics

## Security

- SSH hardening
- Tailscale remote access
- TLS certificates
- ingress isolation

---

# Repository Structure

```text
infra-git/
├── apps/
├── backups/
├── docs/
│   └── recovery/
├── gitops/
├── governance/
├── helm-values/
├── infrastructure/
├── scripts/
└── README.md
```

---

# Operational Commands

## Cluster Health

```bash
khealth
```

## Incident Capture

```bash
kincident
```

## Platform Audit

```bash
~/scripts/platform-audit.sh
```

## Backup Execution

```bash
~/scripts/k3s-backup.sh
```

---

# Backup Architecture

Backup structure:

```text
~/backups/k3s/
├── infra-git/
├── manifests/
├── state/
├── logs/
└── legacy/
```

Backups include:
- K3s datastore snapshots
- cluster manifests
- GitOps repository
- operational logs

---

# Recovery Documentation

Primary recovery runbook:

```text
docs/recovery/cluster-recovery.md
```

Recovery coverage:
- cluster rebuild
- worker restoration
- observability restoration
- governance restoration
- backup restoration

---

# Governance Model

Governed namespaces:
- apps
- monitoring
- logging

Governance controls:
- ResourceQuota
- LimitRange

Purpose:
- prevent resource exhaustion
- stabilize observability workloads
- control scheduling pressure

---

# Operational Automation

Automated operational tasks:
- backups
- audit collection
- retention cleanup
- incident capture
- operational snapshots

Managed through:
- shell automation
- cron scheduling
- Git-tracked scripts

---

# Observability Optimization

Platform optimized for constrained hardware.

Key optimizations:
- reduced Prometheus retention
- Loki canary disabled
- self-monitoring disabled
- resource governance enabled
- workload redistribution applied

---

# Resilience Validation

Validated scenarios:
- worker node outage
- observability recovery
- PVC remount recovery
- ingress continuity
- workload redistribution
- backup validation

---

# Backup Validation Status

Validated recovery assets:
- infra-git archive
- K3s manifests archive
- K3s state snapshots
- operational recovery documentation

Validated recovery operations:
- worker node recovery
- PVC remount recovery
- observability recovery
- ingress continuity
- workload redistribution

---

# Recovery Priorities

Recovery order:
1. K3s control plane
2. Git repository
3. networking
4. ingress
5. certificates
6. governance
7. monitoring
8. logging
9. applications

---

# Known Constraints

- limited RAM environment
- local-path storage only
- non-HA storage architecture
- observability resource sensitivity

---

# Hardware Constraints

Environment operates on constrained hardware:
- low-memory Kubernetes nodes
- local-path storage
- single control-plane architecture

Operational decisions prioritize:
- stability
- recoverability
- low resource overhead
- observability efficiency

---

# Current Operational State

Platform currently includes:
- multi-node K3s cluster
- GitOps-managed workloads
- centralized observability stack
- governance enforcement
- validated backup system
- operational audit framework
- incident capture tooling
- documented recovery procedures

---

# Operational Priorities

Priority order:
1. stability
2. recoverability
3. operational visibility
4. governance
5. automation quality
6. workload expansion

---

# Platform Status

Current platform maturity includes:
- operational Kubernetes cluster
- governed observability stack
- validated resilience testing
- documented disaster recovery
- operational audit automation
- structured backup engineering
- GitOps operational workflows

```

# Cluster Operations Handbook

## Purpose

This document defines the operational procedures, validation workflows, and incident-response commands for the BVR Infra Kubernetes platform.

This handbook must be followed during all operational activities.

---

# Cluster Overview

Platform:
- Kubernetes: K3s
- GitOps: ArgoCD
- Ingress: Traefik
- Monitoring: Prometheus + Grafana
- Logging: Loki + Promtail
- Load Balancer: MetalLB
- Remote Access: Tailscale

---

# Node Roles

## k8s-master
- control-plane
- ingress
- cluster services

## k8s-worker1
- application workloads
- apps namespace

## k8s-worker2
- observability workloads
- monitoring namespace
- logging namespace

---

# Critical Operational Rules

Always:
- validate cluster health before changes
- use GitOps workflow
- make small controlled changes
- validate rollout success
- validate probes and PVCs
- maintain rollback capability

Never:
- modify production manifests directly with kubectl edit
- perform large infra changes during instability
- modify monitoring stack during cluster pressure
- bypass GitOps reconciliation
- ignore failed pods or PVC issues

---

# Daily Health Validation

## Full Health Audit

```bash
khealth

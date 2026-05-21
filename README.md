# BVR Infra Homelab Platform

## Overview

BVR Infra is a self-hosted Kubernetes homelab platform built for learning, infrastructure engineering, GitOps workflows, monitoring, observability, automation, and platform operations.

The platform is designed around lightweight infrastructure principles using K3s, ArgoCD, Prometheus, Grafana, Loki, and Traefik.

This repository contains:
- Kubernetes manifests
- GitOps applications
- deployment standards
- operational documentation
- monitoring configurations
- recovery procedures
- infrastructure architecture

---

# Platform Goals

- Learn production-style infrastructure engineering
- Build operational Kubernetes experience
- Implement GitOps workflows
- Create reusable deployment standards
- Practice observability engineering
- Develop platform operations discipline
- Build career-grade infrastructure portfolio

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
├── gitops/
├── helm-values/
├── infrastructure/

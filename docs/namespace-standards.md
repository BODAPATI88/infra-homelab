# Namespace Standards

## Overview

This document defines namespace governance standards for the BVR Infra Kubernetes platform.

Goals:
- workload segregation
- operational consistency
- deployment discipline
- resource governance
- infrastructure clarity

Namespaces are strictly separated by operational purpose.

---

# Namespace Principles

Each namespace must:
- have a clearly defined purpose
- avoid mixed workloads
- follow deployment standards
- maintain operational isolation
- support GitOps workflows

---

# Namespace Layout

| Namespace | Purpose | Criticality |
|---|---|---|
| apps | business applications | medium |
| monitoring | observability stack | high |
| logging | centralized logging | high |
| argocd | GitOps controllers | critical |
| kube-system | Kubernetes system services | critical |
| metallb-system | load balancing | critical |

---

# apps Namespace

## Purpose

Hosts business and customer-facing workloads.

Examples:
- bvrinfra-site
- frontend applications
- APIs
- internal platform services

---

## Allowed Workloads

Allowed:
- Deployments
- Services
- Ingresses
- ConfigMaps
- Secrets

---

## Deployment Standards

All deployments must include:
- readiness probes
- liveness probes
- resource requests
- resource limits
- rolling update strategy

---

## Resource Governance

Required:
- quotas
- limits
- controlled scaling

Applications must avoid:
- unlimited memory usage
- excessive replicas
- noisy workloads

---

# monitoring Namespace

## Purpose

Hosts metrics and visualization infrastructure.

Components:
- Prometheus
- Grafana
- Alertmanager
- kube-state-metrics
- node-exporter

---

## Operational Rules

Monitoring workloads:
- remain isolated from business apps
- must be carefully resource controlled
- require persistent storage validation

---

## Critical Notes

This namespace is:
```text
highest memory consumer in cluster

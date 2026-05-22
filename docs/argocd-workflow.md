# ArgoCD Workflow

## Overview

This document defines the official GitOps workflow used in the BVR Infra Kubernetes platform.

The platform follows:
- Git-driven infrastructure
- declarative deployments
- controlled rollouts
- operational validation
- rollback-safe procedures

---

# GitOps Principles

All infrastructure and application changes must:
- originate from GitHub
- remain version controlled
- follow rollout validation
- support rollback procedures

Direct manual cluster modifications are discouraged.

---

# GitOps Architecture

```text
GitHub Repository
        │
        ▼
ArgoCD Application
        │
        ▼
Kubernetes Cluster

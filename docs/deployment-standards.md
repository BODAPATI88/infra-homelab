# Deployment Standards

## Purpose

This document defines the baseline deployment standards for workloads deployed into the BVR Infra Kubernetes platform.

All application deployments must follow these standards.

---

# Required Labels

All deployments must include:

```yaml
labels:
  app: <application-name>
  managed-by: argocd

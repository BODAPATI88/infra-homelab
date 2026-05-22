# Platform Architecture

## Overview

BVR Infra is a lightweight Kubernetes-based platform designed for GitOps operations, monitoring, observability, infrastructure automation, and platform engineering learning.

The platform is built using K3s and follows operational discipline around:
- declarative infrastructure
- GitOps workflows
- observability
- rollout safety
- infrastructure documentation

---

# High-Level Architecture

```text
                    ┌────────────────────┐
                    │     Internet       │
                    └─────────┬──────────┘
                              │
                    ┌─────────▼──────────┐
                    │   Cloudflare DNS   │
                    └─────────┬──────────┘
                              │
                    ┌─────────▼──────────┐
                    │  Cloudflare Tunnel │
                    └─────────┬──────────┘
                              │
                    ┌─────────▼──────────┐
                    │      Traefik       │
                    │   Ingress Layer    │
                    └─────────┬──────────┘
                              │
          ┌───────────────────┼───────────────────┐
          │                   │                   │
          ▼                   ▼                   ▼

    bvrinfra.in       argocd.bvrinfra.in   newgrafana.bvrinfra.in

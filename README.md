# k3d-local

A local Kubernetes development environment using k3d with pre-configured services for development and testing.

## Quick Start

### Cluster Management
```bash
# Start the cluster
k3d cluster start mycluster

# Stop the cluster
k3d cluster stop mycluster
```

## Services Overview

| Service | Description | Purpose |
|---------|-------------|---------|
| **ArgoCD** | GitOps operator | Continuous deployment |
| **Portainer** | Cluster dashboard | Container management UI |
| **Istio** | Service mesh | Traffic management & security |
| **Grafana** | Observability stack | Monitoring with Prometheus & Loki |
| **PostgreSQL** | Database | Persistent data storage |
| **Todo App** | Sample application | Development testing |
| **Vault** | Secret management | Secure credential storage |
| **Reloader** | Restart automation | Auto-restart on config changes |

## Service Access & Credentials

### Todo Application
```bash
# Port forward to access
kubectl port-forward svc/todo -n todo 3001:3000
```
- **URL:** http://localhost:3001

### PostgreSQL Database
```bash
# Port forward to access
kubectl port-forward svc/postgres-postgresql -n postgres 5432:5432
```

| User | Password | Database |
|------|----------|----------|
| `postgres` (superuser) | `hoCOdVCQdy` | `postgres` |
| `todoappuser` | `todoapppassword` | `todoappdb` |

### Portainer (Container Management)
```bash
# Port forward to access
kubectl port-forward svc/portainer -n dashboard 9000:9000
```
- **URL:** http://localhost:9000
- **Username:** `admin`
- **Password:** `ilhamellyakhahar`

### Grafana (Monitoring)
```bash
# Port forward to access
kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80
```
- **URL:** http://localhost:3000
- **Username:** `admin`
- **Password:** `ilhamellyakhahar`

### HashiCorp Vault (Secret Management)
```bash
# Port forward to access
kubectl port-forward svc/hashicorp-vault-ui -n vault 8200:8200
```
- **URL:** http://localhost:8200

#### Vault Unseal Keys
```
Unseal Key 1: CbwR1oMtmSZkWRXpmo1NsUtfISJy1aJXV+2Iksz5x+3v
Unseal Key 2: NP7DpyqcIwucsxKt4qeGEZWh1OMn2hh2LUcEnqHvKP5F
Unseal Key 3: bz1ScZHW+uMYiyWDwdJfeevqEpfGfsg0xbOJmWto+7fe
Unseal Key 4: 4whT+mTJDjCdBJqmd6+ZEDh6ag/1EkYWa1wMpsMSqslE
Unseal Key 5: 87HNJaodYVbJjRAOme6MjzG4bqkvN4ONxMe0kA9jP0Xn
```

#### Root Token
```
Initial Root Token: hvs.fLVtEZ4pscvuqFKX0hbx2cSC
```

#### Post-Restart Configuration
⚠️ **Important:** Vault must be unsealed and configured after cluster restart:

```bash
# Configure Kubernetes auth method
vault write auth/kubernetes/config \
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

### ArgoCD (GitOps)
```bash
# Port forward to access
kubectl port-forward svc/argocd-server -n argocd 8000:80
```
- **URL:** http://localhost:8000
- **Username:** `admin`
- **Password:** `amNtPa5SPtydi8zy`

## Useful Commands

```bash
# Create port-forward alias for convenience
alias kpf="kubectl port-forward"

# Check all pods status
kubectl get pods --all-namespaces

# View cluster info
kubectl cluster-info

# Check k3d clusters
k3d cluster list
```

## Prerequisites

- Docker installed and running
- k3d installed
- kubectl installed
- Basic understanding of Kubernetes concepts

## Troubleshooting

### Common Issues
1. **Vault sealed after restart:** Use the unseal keys provided above
2. **Port conflicts:** Ensure no other services are using the specified ports
3. **Cluster won't start:** Check Docker is running and ports are available

### Logs
```bash
# Check pod logs
kubectl logs <pod-name> -n <namespace>

# Follow logs
kubectl logs -f <pod-name> -n <namespace>
```
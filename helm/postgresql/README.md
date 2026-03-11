# PostgreSQL Helm Chart

A Helm chart for PostgreSQL database with pgAdmin following the same patterns as the as-vdb-grpc chart.

## Features

- PostgreSQL database with persistent storage
- pgAdmin web interface for database administration
- Namespace deployment to `ai` namespace
- Ingress configuration with IP whitelisting
- Service account and security contexts
- Resource limits and requests
- Health checks (liveness and readiness probes)

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure (for persistent storage)

## Installation

### For AKS deployment:

```bash
helm install postgresql ./postgresql -f values-aks.yaml
```

### For non-AKS deployment:

```bash
helm install postgresql ./postgresql -f values-non-aks.yaml
```

### Custom values:

You can override default values by creating your own values file or using `--set` flags:

```bash
helm install postgresql ./postgresql -f values-aks.yaml \
  --set postgresql.database.name=mydb \
  --set pgadmin.config.email=admin@mycompany.com
```

## Configuration

### Key Configuration Options

| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.namespace` | Target namespace | `ai` |
| `postgresql.enabled` | Enable PostgreSQL deployment | `true` |
| `postgresql.image.tag` | PostgreSQL image tag | `15.5` |
| `postgresql.database.name` | PostgreSQL database name | `postgres` |
| `postgresql.database.user` | PostgreSQL username | `postgres` |
| `postgresql.persistence.size` | Size of persistent volume | `20Gi` |
| `pgadmin.enabled` | Enable pgAdmin deployment | `true` |
| `pgadmin.config.email` | pgAdmin login email | `admin@example.com` |
| `ingress.enabled` | Enable ingress | `true` (AKS), `false` (non-AKS) |
| `ingress.pgadmin.host` | pgAdmin ingress hostname | `ai-pgadmin` |

### Security

The chart includes the same IP whitelist as the as-vdb-grpc chart for ingress access control. Default passwords are set for both PostgreSQL and pgAdmin - **make sure to change these in production environments**.

## Access

### pgAdmin Web Interface

After deployment, you can access pgAdmin using one of these methods:

1. **Via Ingress** (if enabled):
   ```
   http://ai-pgadmin.dp1.atsnl-emea.azure.dataplanes.pro
   ```

2. **Via Port Forwarding**:
   ```bash
   kubectl port-forward -n ai svc/postgresql-pgadmin 8080:80
   ```
   Then access http://localhost:8080

### PostgreSQL Database

Connect to PostgreSQL database:

1. **Via LoadBalancer (External JDBC Access)**:
   
   **Get the external IP:**
   ```bash
   kubectl get svc -n ai postgresql-postgresql
   ```
   
   **JDBC Connection:**
   ```
   Host: <EXTERNAL-IP from above command>
   Port: 5432
   JDBC URL: jdbc:postgresql://<EXTERNAL-IP>:5432/postgres
   ```
   
   **Note:** Configure AKS Network Security Group to allow whitelisted IPs to access the LoadBalancer IP on port 5432

2. **Via Ingress (pgAdmin Web Interface)**:
   ```
   Host: ai-postgresql.dp1.atsnl-emea.azure.dataplanes.pro
   Port: 5432 (not functional for JDBC - use NodePort above)
   ```

3. **Via Port Forwarding (Development)**:
   ```bash
   kubectl port-forward -n ai svc/postgresql-postgresql 5432:5432
   psql -h localhost -U postgres -d postgres
   ```
   ```
   JDBC URL: jdbc:postgresql://localhost:5432/postgres
   ```

4. **From within cluster**:
   ```
   Host: postgresql-postgresql.ai.svc.cluster.local
   Port: 5432
   JDBC URL: jdbc:postgresql://postgresql-postgresql.ai.svc.cluster.local:5432/postgres
   ```

### Retrieve Passwords

Get PostgreSQL password:
```bash
kubectl get secret -n ai postgresql-secret -o jsonpath="{.data.postgresql-password}" | base64 --decode
```

Get pgAdmin password:
```bash
kubectl get secret -n ai postgresql-secret -o jsonpath="{.data.pgadmin-password}" | base64 --decode
```

## pgAdmin Login Users

The chart creates two pgAdmin users automatically:

**Primary Admin User:**
- **Email:** `admin@atsbnl.com` 
- **Password:** `admin123`

**Additional User:**
- **Email:** `tibco@atsbnl.com`
- **Password:** `tibco!2026`

Both users have full access to the pgAdmin interface and the pre-configured PostgreSQL server.

## Uninstall

To uninstall the chart:

```bash
helm uninstall postgresql
```

**Note**: This will not delete the persistent volume claims. To delete them manually:

```bash
kubectl delete pvc -n ai postgresql-postgresql-pvc
```

## Chart Structure

The chart follows the same patterns as the as-vdb-grpc chart:

- Uses `ai` namespace
- Follows naming conventions with helper templates
- Includes security contexts and resource limits
- Implements the same ingress whitelist configuration
- Uses structured values files for different environments

## Security Notes

1. **LoadBalancer External Access**: PostgreSQL is exposed via LoadBalancer service which gets its own external IP. Configure your AKS Network Security Group to allow only the whitelisted IPs to access port 5432:
   - 63.34.112.27/32
   - 18.200.217.204/32
   - 108.129.54.220/32
   - 62.250.248.64/32
   - 217.120.32.76/32
   - 86.90.167.198/32
   - 86.95.114.49/32
   - 10.4.0.0/16
   - 93.90.66.59/32
   - 20.67.24.154/32
   - 108.142.236.62/32
   - 157.97.112.70/32
   - 185.54.183.206/32

2. **Network Policy**: A NetworkPolicy is included to restrict internal cluster access, but external NodePort access requires firewall configuration.

3. **Database Exposure**: PostgreSQL is exposed externally via NodePort for JDBC access. Ensure strong authentication and network security.

4. **Default Passwords**: Change the default passwords in production environments.

5. **IP Whitelisting**: pgAdmin ingress includes IP whitelisting, but NodePort requires external firewall rules.

6. **Pod Security**: Runs with non-root user and drops unnecessary capabilities.